var config = {
  map: {
    center: new google.maps.LatLng(gon.center_lat, gon.center_lng)
  },

  marker: {
    gridSize: 160,
    minimumClusterSize: 5,
    ignoreHidden: true,
    averageCenter: true,
    styles: [{
      url: gon.m3,
      height: 65,
      width: 65,
      anchor: [0],
      textColor: '#fff',
      textSize: 14
    }]
  }

}

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
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
      var markers = handler.addMarkers(gon.hash_json);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();

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
