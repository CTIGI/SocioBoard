var AnalysisController = Paloma.controller('Analysis');

AnalysisController.prototype.unconformities = function() {
  showIndex();
  enableSelect2();
  countOffenders();
}

AnalysisController.prototype.simulator = function() {
  loadModalForm();
  countOffenders();
  removeTableRow();
  submitTableUpdate();
  exportDivToPDF();
}

function exportDivToPDF(){
  var doc = new jsPDF();
  var specialElementHandlers = {
    '#simulator-movements': function (element, renderer) {
      return true;
    }
  };

  $('#export-simulator-movements').click(function () {
      doc.setFontSize(9);
      doc.text($('#simulator-movements').html(), 15, 15, {
          'width': 170,
              'elementHandlers': specialElementHandlers
      });

      doc.save('simulacao.pdf');
  });
}

function loadModalForm() {
  $('.btn-edit-object').on('click', function(e) {
    e.preventDefault();
    renderFormObject(this, "Simular Movimentação", this.textContent);
  })
}

function submitTableUpdate() {
  $('#skinny-modal').on('click', '#btn-submit-action', function(e) {
    e.preventDefault();
    var form = $('#skinny-modal').find('.modal-body > form');
      $.ajax({
        url: 'update_table',
        data: $(form).serialize() + "&target_cell_value=" + $("#" + $("#_analysis_update_table_unit").val() + "-" + $("#_analysis_update_table_measure_type").val() + "-" + $("#_analysis_update_table_age").val())[0].textContent
        + "&origin_occupation=" + $('#unit-occupation-' + $('#_analysis_update_table_origin_unit').val()).html()
        + "&target_occupation=" + $('#unit-occupation-' + $('#_analysis_update_table_unit').val()).html(),
        dataType: 'script',
        success: function(rt) {
          $('#skinny-modal').modal('hide');
      },
      error: function(rt) {
        var form = $(rt.responseText).find('.content-modal')
        $('#skinny-modal').find('.response-content').html(form);
      }
    })
  })
}

function removeTableRow(){
  $(".remove-unit").click(function(e) {
    var id = $(this).attr('id').split('-')[1]
    $("#unit-" + id).remove()
  })
}

function countOutOfProfile(unit_id){
  var count = 0
  var capacity = parseInt($('#unit-capacity-' + unit_id).html(), 10)
  var occupation = parseInt($('#unit-occupation-' + unit_id).html(), 10)

  $('#unit-' + unit_id + ' .table-red-rowspan').map(function(unit_id) {
    count += parseInt(this.children[0].children[0].textContent, 10)
  })

  $('#unit-' + unit_id + ' .table-orange-rowspan').map(function() {
    count += parseInt(this.children[0].children[0].textContent, 10)
  })

  $('#unit-' + unit_id + ' .table-yellow-rowspan').map(function() {
    count += parseInt(this.children[0].children[0].textContent, 10)
  })

  var out_of_profile = (count/capacity)*100

  $('#unit-out-of-profile-' + unit_id).html(out_of_profile.toFixed(2) + "%")
}

function countOffenders() {
  var count = 0
  $('.table-red-rowspan').map(function() {
    count += parseInt(this.children[0].children[0].textContent, 10)
  })

  $('#total-measure-span').text(count);

  count = 0
  $('.table-yellow-rowspan').map(function() {
    count += parseInt(this.children[0].children[0].textContent, 10)
  })

  $('#total-age-span').text(count);

  count = 0
  $('.table-orange-rowspan').map(function() {
    count += parseInt(this.children[0].children[0].textContent, 10)
  })

  $('#total-age-measure-span').text(count);

  count = 0
  $('.table-blue-rowspan').map(function() {
    count += parseInt(this.children[0].children[0].textContent, 10)
  })

  $('#total-conformities-span').text(count);
}
