
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

var customMarkers = []
var customMarkers2 = []

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
    $('.map-search').height($(window).height());

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

  openMenuSearch: function () {
    $('.form-components').height($(window).height() - 140)
    $('.open-search').on('click', function (e) {
      e.preventDefault()
      $('.map-search').show('slide', { direction: 'left' }, 'fast');
    })
  },

  closeSearch: function () {
    $('.close-search').click(function () {
      $('.map-search').hide('slide', { direction: 'left' }, 'fast');
    })
  },

  clearSearch: function() {
    $('.form-control.select2').select2('val', null);

    $('#clear-search').click(function (e) {
      e.preventDefault();
      $('.form-control.select2').each(function ()  {

        $(this).val('').change();
      });
    })
  },

  searchMap: function(handler) {
    $('#search-on-map').click(function (e) {
      e.preventDefault();
      handler.removeMarkers(customMarkers2)

      $.ajax({
        method: "get",
        url: $('form').closest().attr("href"),
        data: $('form').serialize(),
        dataType: "json",
        beforeSend: function () {
          $('.loading-map-data').show();
        },
        complete: function () {
          $('.loading-map-data').hide();
        },
        success: function (data) {
          customMarkers2 = handler.addMarkers(data)
        }
      })
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

    handler.buildMap({ provider: {disableDefaultUI: false}, internal: {id: 'map'}}, function(){
      customMarkers = handler.addMarkers(gon.hash_json)
      customMarkers2 = handler.addMarkers(gon.district_json)

      handler.getMap().setZoom(12)
    });

    var geoXml = new geoXML3.parser({
      map: handler.map.serviceObject,
      polygonOptions: { clickable: false }
    });
    geoXml.parse('/kmls/bairros_fortaleza.kml')

    return handler
  }
}

function initMap() {
  $(document).ready(function() {
    var handler = offenderMap.initVariables();

    offenderMap.adjustElementsView();
    offenderMap.setMapSize();
    offenderMap.loading();
    offenderMap.openMenuSearch();
    offenderMap.closeSearch();
    offenderMap.clearSearch();
    offenderMap.searchMap(handler, customMarkers, customMarkers2);

    enableSelect2();
  });
}
