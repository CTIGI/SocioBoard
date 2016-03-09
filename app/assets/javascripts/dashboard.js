var DashboardController = Paloma.controller('Dashboard');

DashboardController.prototype.index = function() {
  setBarChart($('#crime-by-unit'), gon.crimes_by_unit_categories, gon.crimes_by_units , "Unidades x Tipos de Ato")
  setBarChart($('#measure-by-unit'), gon.measure_by_units_categories, gon.measures_by_units , "Unidades x Medidas")
  setBarChart($('#unit-by-measure'), gon.units_by_measures_categories, gon.units_by_measures , "Medidas x Unidades")
  setBarChart($('#unit-by-crimes'), gon.units_by_crimes_categories, gon.units_by_crimes , "Medidas x Unidades")
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

function setBarChart(chartDiv, categories, chartData, title) {
  chartDiv.highcharts({
    chart: {
      type: 'bar',
      height: 800
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
