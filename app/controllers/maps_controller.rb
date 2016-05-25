class MapsController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_policy_scoped

  def index
    map_configs
    @units = Unit.all

    gon.hash_json = Gmaps4rails.build_markers(@units) do |unit, marker|
      marker.lat unit.latitude
      marker.lng unit.longitude
      marker.json({:id => unit.id })
      marker.picture({
             "url" => ActionController::Base.helpers.asset_path("institution-map.png"),
             "width" =>  36,
             "height" => 36})

      marker.infowindow render_to_string(:partial => "/units/infowindow", :locals => { unit: unit})
    end

  end

  private

  def map_configs
    gon.center_lat = -5.4546
    gon.center_lng = -39.7177
  end
end
