class OffendersController < ApplicationController
  before_action :set_dependencies
  before_action :set_counters

  def index
    @q = Offender.ransack(params[:q])
    @offenders = @q.result.page(params[:page])
  end

  private
  def set_counters
    search_terms = []
    @counters = []
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
        @counters << { I18n.t("activerecord.attributes.offender.#{field_name}") =>  Offender.ransack(terms).result.count }
      end
      @counters
    end
  end

  def set_dependencies
    @total              = [{ I18n.t("views.offenders.filter_panel.total") => Offender.all.count }]
    @duplicated         = [{ I18n.t("views.offenders.filter_panel.duplicated") => Offender.duplicated.count }]
    @units              = Offender.order(:unit).select("distinct(unit)")
    @ages               = Offender.order(:age).select("distinct(age)")
    @recurrents         = Offender.order(:recurrent).select("distinct(recurrent)")
    @origin_counties    = Offender.order(:origin_county).select("distinct(origin_county)")
    @crimes             = Crime.order(:name).select("distinct(name)")
    @measure_types      = Measure.render_data_list(:measure_type)
    @measure_deadlines  = Measure.render_data_list(:measure_deadline)
    @measure_situations = Measure.render_data_list(:measure_situation)
  end
end
