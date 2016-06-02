class MapsController < ApplicationController
  #before_action :authenticate_user!
  skip_after_action :verify_policy_scoped

  def index
    map_configs
    @units = Unit.all

    gon.hash_json = Gmaps4rails.build_markers(@units) do |unit, marker|
      marker.lat unit.latitude
      marker.lng unit.longitude
      marker.json({:id => unit.id,
                    custom_marker: "<div class='marker-info'>
                                      <img src=#{ActionController::Base.helpers.asset_path("institution-map.png")}>
                                    </div>"})

      marker.infowindow render_to_string(:partial => "/units/infowindow", :locals => { unit: unit})
    end

    gon.district_json = Gmaps4rails.build_markers(District.all) do |d, marker|
      marker.json({:id => d.name,
                    custom_marker: "<div class='marker-info'>
                                      <img src=#{ActionController::Base.helpers.asset_path('offenders_icon.png')}>
                                      <span>#{d.offenders.count}</span>
                                    </div>"})
      marker.lat d.latitude
      marker.lng d.longitude
      marker.infowindow render_to_string(:partial => "/offenders/infowindow", :locals => { offenders: d.offenders})
    end
  end

  private

  def map_configs
    gon.center_lat = -5.4546
    gon.center_lng = -39.7177
  end
end
