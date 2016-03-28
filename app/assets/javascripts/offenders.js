var OffendersController = Paloma.controller('Offenders');
function setSelectedUnits() {
  var values  = JSON.parse($('#q_unit_id_in').attr('data-value'))
  $('#q_unit_id_in').val(values).trigger("change");
}

OffendersController.prototype.index = function() {
  setSelectedUnits();
}
