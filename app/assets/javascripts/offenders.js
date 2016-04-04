var OffendersController = Paloma.controller('Offenders');

function setSelectedUnits() {
  var values  = JSON.parse($('#q_unit_id_in').attr('data-value'))
  $('#q_unit_id_in').val(values).trigger("change");
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
  selectSubGroupsElements();
  setSelectedUnits();
}
