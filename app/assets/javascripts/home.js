var HomeController = Paloma.controller('Home');

HomeController.prototype.index = function() {
  inconformsData();
  resizeSlide();
  unitsInconsistencesChart();
  unitsCapacityChart();
  reloadPageEveryMinutes(15);
};
