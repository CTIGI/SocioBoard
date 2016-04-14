var OffendersController = Paloma.controller('Offenders');

function setSelectedUnits() {
  if ($('#q_unit_id_in').attr('data-value') !== undefined) {
    var values  = JSON.parse($('#q_unit_id_in').attr('data-value'));
    $('#q_unit_id_in').val(values).trigger("change");
  }
}

function setValuesIntoSelect(arrayIds) {
  var settedValues = $('#q_unit_id_in').val()
  if (settedValues !== null) {
    $.each(arrayIds, function (i, el) {
      settedValues.push(el)
    })
  } else {
    settedValues = arrayIds
  }

  return settedValues;
}

function exportFiles() {
  $('.export-file').click(function (e) {
    e.preventDefault();
    var extension = $(this).attr('data-extension');
    var link      = $(this).attr('data-link');
    var params    = window.location.href.split("?")[1] === undefined ? "" : "?" + window.location.href.split("?")[1];
    window.open(link + extension + params);
  })
}

function selectSubGroupsElements() {
  $('#q_unit_id_in').on("select2:open", function (e) {
    setTimeout( function () {
      $('.select2-results__group').on("click", function() {
        var list = $(this).next()
        var results = $(list).find('li')
        var arrayIds = []
        $.each(results, function (index, el) {
          var id = $(el).attr('id').split("-").slice(-1)[0]
          arrayIds.push(id)
        })
        setValuesIntoSelect(arrayIds)
        $('#q_unit_id_in').val(setValuesIntoSelect(arrayIds)).trigger("change");
      })
    }, 1000 );
  });
}

OffendersController.prototype.index = function() {
  exportFiles();
  selectSubGroupsElements();
  setSelectedUnits();
}
