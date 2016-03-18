var UnitsController = Paloma.controller('Units');

UnitsController.prototype.index = function() {
  editObject(I18n.t("views.units.edit_unit"));
  submitFormAction();
  showDetails();
};

UnitsController.prototype.edit = function() {

};

UnitsController.prototype.update = function() {

};
