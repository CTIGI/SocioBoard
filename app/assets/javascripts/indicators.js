var IndicatorsController = Paloma.controller('Indicators');

IndicatorsController.prototype.indicator_01 = function() {
  inconformsData();
  resizeSlide();
  enableSlideShow();
  reloadPageEveryMinutes(15);
}

IndicatorsController.prototype.units = function() {
  $('.tile').each(function(i, e){
    setTimeout( function() { $(e).show() }, 100 * i)
  });

  $(document).ready(function () {
    $('.iCheck-helper').click(function() {
      $('form').submit();
    })
  });
};
