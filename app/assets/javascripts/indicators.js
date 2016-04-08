var IndicatorsController = Paloma.controller('Indicators');

IndicatorsController.prototype.indicator_01 = function() {
  inconformsData();
  resizeSlide();
  enableSlideShow();
  reloadPageEveryMinutes(15);
}
