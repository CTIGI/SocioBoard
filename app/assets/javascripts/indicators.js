var IndicatorsController = Paloma.controller('Indicators');

IndicatorsController.prototype.indicator_01 = function() {
  inconformsData();
  resizeSlide();
  enableSlideShow();
  reloadPageEveryMinutes(15);
}

IndicatorsController.prototype.units = function() {
  $('#unit-profile').hide()

  $('.tile').each(function(i, e){
    setTimeout( function() { $(e).show() }, 100 * i)
  });

  $(document).ready(function () {
    $('.iCheck-helper').click(function() {
      $('form').submit();
    })
  });

  loadUnitProfile();
};

function loadUnitProfile() {
  $('.load-unit-profile').click(function(e) {
    e.preventDefault();
    var url = $(this).attr('data-link');

    $.ajax({
      method: "get",
      url: url,
      success: function(rt) {
        $('#units-indicator').hide()
        $('#unit-profile').show()
      }
    })
  });
}
