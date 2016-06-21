module Concerns
  module SharedChartsDataConcern
  extend ActiveSupport::Concern

    included do
      private

      def set_values
        @total_offenders             = Offender.not_evaded.all.count
        @near_due_date_counter       = Offender.nears_due_date.count
        @near_current_period_counter = Offender.near_current_periods.count
        @measure_overdues            = Offender.overdues.count
        @sanctions                   = Offender.sanctions.count
      end

      def units_inconsistences
        @units_inconsistences      = 0
        @offenders_out_of_measure  = 0
        @offenders_out_of_profile  = 0

        Unit.all.each do |u|
          @units_inconsistences     += u.inconsistences
          @offenders_out_of_measure += u.offenders_out_of_measure
          @offenders_out_of_profile += u.offenders_out_of_profile_by_age
        end
      end

      def units_capacity_data
        set_units_capacity_charts(true)
        gon.units_capacity_data = t("views.dashboards.units_capacity")
      end

      def set_units_capacity_charts(extreme_truncate = false)
        begin
          body = open("http://www11.stds.ce.gov.br/sgi/rest/crvqavu/#{Constants::CRV::PWD}").read
          result = JSON.parse(body)

          gon.units_capacity_categories = []
          gon.units_capacity_series_percentage = {}
          series = []
          series << { name: I18n.t("views.dashboards.occupied") , data: [], percentage_value: [] }
          series << { name: I18n.t("views.dashboards.total_capacity") , data: [] }

          result.each do |r|
            initials_measure_unit_type = view_context.initials_measure_unit_type Unit.find_by(name: r["unidade"]).measure_types.pluck(:name)
            initials_measure_unit_type = initials_measure_unit_type.blank? ? "" : "<br/><strong>(#{initials_measure_unit_type})</strong>"
            gon.units_capacity_categories << view_context.truncate_words(r["unidade"], extreme_truncate) + initials_measure_unit_type
            series[1][:data] << r["capacidade"]
            series[0][:data] << r["totalOcupado"]
            series[0][:percentage_value] << r["totalOcupado"].to_f/r["capacidade"].to_f*100
          end

          gon.units_capacity_series = series
        rescue
          gon.units_capacity_series = []
          gon.units_capacity_categories = []
        end
      end

      def units_inconsistences_data_chart
        gon.units_inconsistences_title = t("views.indicators.inconsistences_title_chart")
        gon.units_inconsistences_categories = []

        total_out_of_measure         = { name: t("views.analysis.total_on_measure"),     data: [] }
        total_out_of_age             = { name: t("views.analysis.total_on_age"),         data: [] }
        total_out_of_age_and_measure = { name: t("views.analysis.total_on_measure_age"), data: [] }
        conformities                 = { name: t("views.analysis.total_conformities"),   data: [] }

        Unit.all.order(:name).each do |u|
          gon.units_inconsistences_categories << view_context.truncate_words( u.name, true)
          analysis_data_count = u.analysis_data_count
          total_out_of_measure[:data]         << analysis_data_count[0]
          total_out_of_age[:data]             << analysis_data_count[1]
          total_out_of_age_and_measure[:data] << analysis_data_count[2]
          conformities[:data]                 << analysis_data_count[3]
        end

        series = [ total_out_of_measure, total_out_of_age, total_out_of_age_and_measure, conformities]
        gon.units_inconsistences_series = series
      end
    end
  end
end
