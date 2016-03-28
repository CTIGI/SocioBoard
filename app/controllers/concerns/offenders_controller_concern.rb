module Concerns
  module OffendersControllerConcern
  extend ActiveSupport::Concern

    included do
      before_action :authenticate_user!
      skip_after_action :verify_policy_scoped
      skip_after_action :verify_authorized
      before_action :set_dependencies, only: [:index]
      before_action :params_search, only: [:index]
      before_action :set_counters, only: [:index, :generate_pdf, :generate_sheet]
      before_action :format_data_search_for_pdf, only: [:generate_pdf]

      def modal_index
        result_offenders
        respond_with(@offenders, layout: false)
      end

      def generate_pdf
        result_offenders
      end

      def generate_sheet
        result_offenders
      end

      private

      def result_offenders
        @q = Offender.ransack(session[:query_search])
        @offenders = @q.result
      end

      def params_search
        units = []
        if params[:units].present?
          params[:units].each_key do |k|
            measure_unit_type     = Unit.measure_unit_types[k]
            measure_unit_type_ids = Unit.where(measure_unit_type: measure_unit_type).pluck(:id)
            units << measure_unit_type_ids if params[:units].has_key?(k)
          end
          params[:q] = { "scope_units_in": units.flatten }.merge(params[:q])
        end

        session[:query_search] = params[:q]
      end

      def format_data_search_for_pdf
        headers = []
        values  = []
        @total[0].to_a.transpose
        @data_result = @total[0].to_a.transpose
        @counters.each do |c|
          @data_result[0] << c.keys[0]
          @data_result[1] << "#{c.values[0]} (#{c.values[1]})"
          counter = c.to_a[0]
        end
        @data_result[1].map! {|dr| dr = "<font size='14'>#{dr}</font>"}
      end

      def set_counters
        @total                       = [{ I18n.t("views.offenders.filter_panel.total") => Offender.all.count }]
        @near_due_date_counter       = Measure.nears_due_date.count
        @near_current_period_counter = Measure.near_current_periods.count
        @measure_overdues            = Measure.overdues.count
        @sanctions                   = Measure.sanctions.count
        search_terms                 = []
        @counters                    = []
        if session[:query_search].present?
          session[:query_search].each do |key, value|
            search_terms << ({ key => value }) unless ( value.class == Array ? value.reject(&:blank?).blank? : value.blank? )
          end
          terms = { }
          search_terms.each do |search_term|
            field_name = search_term.keys[0].split("_")
            field_name.pop
            field_name = field_name.join("_")
            terms.merge!(search_term)
            current_value = Offender.ransack(terms).result.count
            percentage = @counters.blank? ? calculate_percentage(@total[0].values[0], current_value) : calculate_percentage(@counters.last.values[0], current_value)
            @counters << { I18n.t("activerecord.attributes.offender.#{field_name}") => current_value, percentage: percentage }
          end
        end
      end

      def calculate_percentage(total, current)
        percentage = (current.to_f * 100.0) / total.to_f
        "#{percentage.round(2)}%"
      end

      def grouped_units
        @units = []
        free_range_unit_label = UnicodeUtils.upcase(Unit.measure_unit_types_i18n[:free_range_unit])
        free_range_units      = Unit.all.where(measure_unit_type: Unit.measure_unit_types[:free_range_unit]).pluck(:name, :id)
        @units << [free_range_unit_label , free_range_units]

        admission_unit_label = UnicodeUtils.upcase(Unit.measure_unit_types_i18n[:admission_unit])
        admission_units      = Unit.all.where(measure_unit_type: Unit.measure_unit_types[:admission_unit]).pluck(:name, :id)
        @units << [admission_unit_label , admission_units]

        provisional_admission_unit_label = UnicodeUtils.upcase(Unit.measure_unit_types_i18n[:provisional_admission_unit])
        provisional_admission_units      = Unit.all.where(measure_unit_type: Unit.measure_unit_types[:provisional_admission_unit]).pluck(:name, :id)
        @units << [provisional_admission_unit_label , provisional_admission_units]

        @units
      end

      def set_dependencies
        grouped_units
        @ages               = Offender.order(:age).select("distinct(age)")
        @recurrents         = Offender.order(:recurrent).select("distinct(recurrent)")
        @origin_counties    = Offender.render_data_list(:origin_county)
        @crimes             = Crime.order(:name).select("distinct(name)")
        @measure_types      = Measure.render_data_list(:measure_type)
        @measure_deadlines  = Measure.render_data_list(:measure_deadline)
        @measure_situations = Measure.render_data_list(:measure_situation)
      end
    end
  end
end
