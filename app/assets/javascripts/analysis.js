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
}

function loadModalForm() {
  $('.btn-edit-object').on('click', function(e) {
    e.preventDefault();
    renderFormObject(this, I18n.t("views.analysis.move_offenders"), this.textContent);
  })
}


function submitTableUpdate() {
  $('#skinny-modal').on('click', '#btn-submit-action', function(e) {
    e.preventDefault();
    var form = $('#skinny-modal').find('.modal-body > form');
      $.ajax({
        url: 'update_table',
        data: $(form).serialize() + "&target_cell_value=" + $("#" + $("#_analysis_update_table_unit").val() + "-" + $("#_analysis_update_table_measure_type").val() + "-" + $("#_analysis_update_table_age").val())[0].textContent,
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
