function inconformsData() {
  $.ajax({
    method: "get",
    url: "/analysis/unconformities",
    success: function(rt) {
      var by_measures = $(rt).find('.table-red-rowspan')
      var by_measures_count = 0
      by_measures.map(function() {
        by_measures_count += parseInt(this.children[0].children[0].textContent, 10)
      });
      $('#total-measure-span').text(by_measures_count);
      var by_age = $(rt).find('.table-yellow-rowspan')
      var by_age_count = 0
      by_age.map(function() {
        by_age_count += parseInt(this.children[0].children[0].textContent, 10)
      });
      $('#total-age-span').text(by_age_count);

      var by_age_and_measure = $(rt).find('.table-orange-rowspan')
      var by_age_and_measure_count = 0

      by_age_and_measure.map(function() {
        by_age_and_measure_count += parseInt(this.children[0].children[0].textContent, 10)
      });
      $('#total-age-measure-span').text(by_age_and_measure_count);

      var by_conformities = $(rt).find('.table-blue-rowspan')
      var by_conformities_count = 0

      by_conformities.map(function() {
        by_conformities_count += parseInt(this.children[0].children[0].textContent, 10)
      });
      $('#total-conformities-span').text(by_conformities_count);
    }
  });
}

function resizeSlide() {
  $('.item').css('height', $(window).height() - 80)
}

function unitsCapacityChart() {
  $('#units-capacity').highcharts({
    chart: {
      width: $(window).width() - 180
    },
    title: {
      text: gon.units_capacity_data
    },
    xAxis: {
      categories: gon.units_capacity_categories,
      labels: {
        padding: 1
      }
    },
    yAxis: {
      title: {
        text: 'Quantidade'
      }
    },
    series: [{
      type: 'column',
      name: gon.units_capacity_series[1].name,
      data: gon.units_capacity_series[1].data,
      dataLabels: {
        enabled: true
      }
    }, {
      type: 'spline',
      color: 'red',
      name: gon.units_capacity_series[0].name,
      data: gon.units_capacity_series[0].data,
      dataLabels: {
        enabled: true
      },
      marker: {
        lineWidth: 2,
        lineColor: '#890000',
        fillColor: 'white'
      }
    }]
  });
}

function unitsInconsistencesChart() {
  $('#units-inconsistences').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: gon.units_inconsistences_title
    },
    xAxis: {
      categories: gon.units_inconsistences_categories,
      crosshair: true
    },
    yAxis: {
      title: {
        text: 'Quantidade'
      }
    },
    plotOptions: {
      column: {
        pointPadding: 0.2,
        borderWidth: 0
      }
    },
    series: [{
      color: '#f44336',
      name: gon.units_inconsistences_series[0].name,
      data: gon.units_inconsistences_series[0].data,
      dataLabels: {
        enabled: true
      }
    }, {
      color: '#FF5722',
      name: gon.units_inconsistences_series[1].name,
      data: gon.units_inconsistences_series[1].data,
      dataLabels: {
        enabled: true
      }
    }, {
      color: '#FF9801',
      name: gon.units_inconsistences_series[2].name,
      data: gon.units_inconsistences_series[2].data,
      dataLabels: {
        enabled: true
      }
    }, {
      color: '#2196F3',
      name: gon.units_inconsistences_series[3].name,
      data: gon.units_inconsistences_series[3].data,
      dataLabels: {
        enabled: true
      }
    }]
  });
}

function enableSlideShow() {
  var carousel = '#carousel'

  $(carousel).carousel({
    interval: 20000,
    pause: ""
  });

  $('.left.carousel-control').click(function () {
    $(carousel).carousel('prev')
  })

  $('.right.carousel-control').click(function () {
    $(carousel).carousel('next')
  })

  unitsCapacityChart();
  $(carousel).on('slide.bs.carousel', function() {
    setTimeout(function(){
      unitsInconsistencesChart();
    }, 1);
  })
}

function reloadPageEveryMinutes(minutes) {
  setTimeout(function(){
    window.location.reload(1);
  }, 60000 * minutes);
}
