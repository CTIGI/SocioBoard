class MapsController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_policy_scoped
  include Concerns::OffendersControllerConcern
  before_action :set_dependencies, only: [:index]

  def index
    map_configs

    gon.hash_json = Gmaps4rails.build_markers(Unit.all) do |unit, marker|
      marker.lat unit.latitude
      marker.lng unit.longitude
      marker.json({:id => unit.id,
                    custom_marker: "<div class='marker-info'>
                                      <img src=#{ActionController::Base.helpers.asset_path("institution-map.png")}>
                                    </div>"})

      marker.infowindow render_to_string(:partial => "/units/infowindow", :locals => { unit: unit})
    end

    @q = Offender.ransack()

    gon.district_json = Gmaps4rails.build_markers(District.all) do |d, marker|
      offenders = d.offenders.ransack(params[:q]).result
      if offenders.count > 0
        marker.json({:id => d.name,
                    custom_marker: "<div class='marker-info'>
                                      <img src=#{ActionController::Base.helpers.asset_path('offenders_icon.png')}>
                                      <span>#{offenders.count}</span>
                                      </div>"})
        marker.lat d.latitude
        marker.lng d.longitude

        marker.infowindow render_to_string(:partial => "/offenders/infowindow", :locals => { offenders: offenders })
      end
    end

    gon.district_json = gon.district_json.reject { |c| c.empty? }

    respond_to do |format|
      format.html
      format.json { render json: gon.district_json}
    end

  end

  private

  def map_offender_search
  end

  def map_configs
    gon.center_lat = -5.4546
    gon.center_lng = -39.7177
  end
end
