var AnalysisController = Paloma.controller('Analysis');

AnalysisController.prototype.unconformities = function() {
  showIndex();
  enableSelect2();
  countOffenders();
}

function countOffenders() {
  var count = 0
  $('.table-red-rowspan').map(function() {
    count += parseInt(this.children[0].children[0].innerText, 10)
  })

  $('#total-measure-span').text(count);

  count = 0
  $('.table-yellow-rowspan').map(function() {
    count += parseInt(this.children[0].children[0].innerText, 10)
  })

  $('#total-age-span').text(count);

  count = 0
  $('.table-orange-rowspan').map(function() {
    count += parseInt(this.children[0].children[0].innerText, 10)
  })

  $('#total-age-measure-span').text(count);

  count = 0
  $('.table-blue-rowspan').map(function() {
    count += parseInt(this.children[0].children[0].innerText, 10)
  })

  $('#total-conformities-span').text(count);
}
