var RichMarkerBuilder,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

RichMarkerBuilder = (function(superClass) {
  extend(RichMarkerBuilder, superClass);

  function RichMarkerBuilder() {
    return RichMarkerBuilder.__super__.constructor.apply(this, arguments);
  }

  RichMarkerBuilder.prototype.create_marker = function() {
    var options;
    options = _.extend(this.marker_options(), this.rich_marker_options());
    this.serviceObject = new RichMarker(options);
    this.serviceObject.setShadow("")
    return this.serviceObject
  };

  RichMarkerBuilder.prototype.rich_marker_options = function() {
    var marker;
    marker = document.createElement("div");
    marker.setAttribute('class', 'pin');
    marker.innerHTML = this.args.custom_marker;
    return {
      content: marker
    };
  };

  return RichMarkerBuilder;

})(Gmaps.Google.Builders.Marker);

var offenderMap = {
  loading: function () {
    $('.loading-map-data').css({
      top:  $(window).height() / 2,
      left: $(window).width() / 2
    });
  },

  setMapSize: function () {
    var height = $(window).height();
    $('#map').height(height);
  },

  adjustElementsView: function() {
    $('#header, #sidebar').remove();
    $('#content').attr("style", "");
    $('#content').css({
      marginLeft: "-50px",
      marginRight: "-50px",
      padding: "0 !important"
    });
    $('body').css({
      padding: "0",
      margin: "-30px 0 0 0"
    })
  },

  initVariables: function() {
    var handler;

    handler = Gmaps.build('Google', {
      builders: {
        Marker: RichMarkerBuilder
      },
      markers: {
        clusterer: {
          gridSize: 20,
          minimumClusterSize: 10
        }
      }

    });

    handler.buildMap({ provider: {disableDefaultUI: true}, internal: {id: 'map'}}, function(){
      markers = handler.addMarkers(gon.hash_json)
      markers2 = handler.addMarkers(gon.district_json)

      handler.bounds.extendWith(markers);
      handler.getMap().setZoom(new google.maps.LatLng(gon.center_lat, gon.center_lng))

      var kmls = handler.addKml(
        { url: "/kmls/bairros_fortaleza.kml" }
      );
    });

    var geoXml = new geoXML3.parser({
      map: handler.map.serviceObject,
      polygonOptions: { clickable: false }
    });
    geoXml.parse('/kmls/bairros_fortaleza.kml')
  }
}

function initMap() {
  $(document).ready(function() {
    offenderMap.initVariables();

    offenderMap.adjustElementsView();
    offenderMap.setMapSize();
  });
}
