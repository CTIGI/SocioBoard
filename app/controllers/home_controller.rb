class HomeController < ApplicationController
  include Concerns::SharedChartsDataConcern
  before_action :authenticate_user!

  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  before_action :set_values, only: [ :index ]
  before_action :units_inconsistences, only: [ :index ]
  before_action :units_capacity_data, only: [ :index ]
  before_action :units_inconsistences_data_chart, only: [ :index ]

  def index
  end
end
