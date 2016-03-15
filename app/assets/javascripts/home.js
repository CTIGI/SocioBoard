var HomeController = Paloma.controller('Home');

HomeController.prototype.index = function() {
  $('.tile').each(function(i, e){
    setTimeout( function() { $(e).show() }, 100 * i)
  });

  $(document).ready(function () {
    $('.iCheck-helper').click(function() {
      $('form').submit();
    })
  });
};
