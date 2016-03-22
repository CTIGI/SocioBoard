var hotkeys = {
  closeModal: function() {
    $(document).bind('keydown', 'esc', function() {
      $('.modal').modal('hide')
    });
  }
}

$(document).ready(function() {
  hotkeys.closeModal();
})
