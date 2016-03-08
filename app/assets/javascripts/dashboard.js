var DashboardController = Paloma.controller('Dashboard');

DashboardController.prototype.index = function() {
  setBarChart($('#crime-by-unit'), gon.crimes_by_unit_categories, gon.crimes_by_unit , "Unidade x Tipo de Ato")
}

var bulbaColors = [
   '#399494',
   '#209483',
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
   '#83e6d5'
  ]

function setBarChart(chartDiv, categories, chartData, title) {
  chartDiv.highcharts({
    chart: {
      type: 'bar'
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
    plotOptions: {
      series: {
        stacking: 'normal'
      }
    },
    colors: bulbaColors,
    series: chartData
    });
}
