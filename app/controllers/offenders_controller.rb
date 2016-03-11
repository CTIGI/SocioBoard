class OffendersController < ApplicationController
  before_action :set_dependencies
  before_action :set_counters

  def index
    @q = Offender.ransack(params[:q])
    @offenders = @q.result.page(params[:page])
  end

  private
  def set_counters
    @total                 = [{ I18n.t("views.offenders.filter_panel.total") => Offender.all.count }]
    @near_due_date_counter = Measure.nears_due_date.count
    search_terms           = []
    @counters              = []

    if params[:q].present?
      params[:q].each do |key, value|
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

  def set_dependencies
    @units              = Offender.order(:unit).select("distinct(unit)")
    @ages               = Offender.order(:age).select("distinct(age)")
    @recurrents         = Offender.order(:recurrent).select("distinct(recurrent)")
    @origin_counties    = Offender.render_data_list(:origin_county)
    @crimes             = Crime.order(:name).select("distinct(name)")
    @measure_types      = Measure.render_data_list(:measure_type)
    @measure_deadlines  = Measure.render_data_list(:measure_deadline)
    @measure_situations = Measure.render_data_list(:measure_situation)
  end
end
