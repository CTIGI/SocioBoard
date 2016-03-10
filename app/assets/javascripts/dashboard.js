var DashboardController = Paloma.controller('Dashboard');

DashboardController.prototype.index = function() {
  setBarChart($('#crime-by-unit'), gon.crimes_by_unit_categories, gon.crimes_by_units , "Unidades x Tipos de Ato")
  setBarChart($('#measure-by-unit'), gon.measure_by_units_categories, gon.measures_by_units , "Unidades x Medidas")
  setBarChart($('#unit-by-measure'), gon.units_by_measures_categories, gon.units_by_measures , "Medidas x Unidades")
  setBarChart($('#unit-by-crimes'), gon.units_by_crimes_categories, gon.units_by_crimes , "Tipos de Ato x Unidades")
  setWebChart($('#units-capacity'), gon.units_capacity_categories, gon.units_capacity_series , "Capacidade das unidades")
}

var bulbaColors = [
   '#399494',
   '#83e6d5',
   '#5acbdb',
   '#317b52',
   '#104a39',
   '#d5415a',
   '#62d5b4',
   '#101010',
   '#83eec5',
   '#184a4a',
   '#73ac31',
   '#317373',
   '#526229',
   '#a4d541',
   '#ee2039',
   '#ff6a62',
   '#7b3129',
   '#cdcdcd',
   '#ffaca4',
   '#ff7b7b',
   '#20b49c',
   '#105241',
   '#ff7b73',
   '#5a9c39',
   '#ffee52',
   '#5ad5c5',
   '#de4141',
   '#83de7b',
   '#833100',
   '#209483'
  ]

function setWebChart(chartDiv, categories, chartData, title) {
  chartDiv.highcharts({
    chart: {
       polar: true,
       type: 'line',
       height: 800,
       width: 1200
     },

     title: {
       text: title,
       x: -80
     },

     pane: {
       size: '80%'
     },

     xAxis: {
       categories: categories,
       tickmarkPlacement: 'on',
       lineWidth: 0
     },
     yAxis: {
       gridLineInterpolation: 'polygon',
       lineWidth: 0,
       min: 0
     },

     tooltip: {
       shared: true,
       pointFormat: '<span style="color:{series.color}">{series.name}: <b>{point.y:,.0f}</b><br/>'
     },
     legend: {
       align: 'right',
       verticalAlign: 'top',
       y: 400,
       layout: 'vertical'
     },
     colors: ["blue", "red"],
     series: chartData
   });

}

function setBarChart(chartDiv, categories, chartData, title) {
  chartDiv.highcharts({
    chart: {
      type: 'bar',
      height: 800,
      width: 1200
    },
    title: {
      text: title
    },
    xAxis: {
      categories: categories,
    },
    yAxis: {
      min: 0
    },
    legend: {
      align: 'right',
      verticalAlign: 'top',
      layout: 'vertical',
      labelFormatter: function () {
        return this.name.substring(0, 15);
      }
    },
    plotOptions: {
      series: {
        stacking: 'normal'
      }
    },

    colors: bulbaColors,
    series: chartData
    });
}
