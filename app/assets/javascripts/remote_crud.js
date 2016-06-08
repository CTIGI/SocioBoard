function setModalTitle(title) {
  $('#skinny-modal').find('.modal-title').html(title);
}

function showDetails() {
  $('.details-object').click(function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    $.ajax({
      method: "get",
      url: url,
      success: function(rt) {
        $('#skinny-modal').find('.response-content').html(rt);
        $('#skinny-modal').modal();
      }
    })
  })
}

function showIndex(modalTitle) {
  $('.index-object').click(function(e) {
    e.preventDefault();
    setModalTitle(modalTitle, '#skinny-modal');
    var url = $(this).attr('data-link');
    $.ajax({
      method: "get",
      url: url,
      success: function(rt) {
        $('#skinny-modal').find('.response-content').html(rt);
        $('#skinny-modal').modal();
        loadSimulation();
        removeSimulation();
      }
    })
  })
}

function renderFormObject(markup, modalTitle, extra_args, method) {
  var url = $(markup).attr('data-link');
  setModalTitle(modalTitle, '#skinny-modal');
  $.ajax({
    method: method,
    url: url,
    data: {
      parent: $(markup).attr('data-parent'),
      extra: extra_args
    },
    success: function(rt) {
      $('#skinny-modal').find('.response-content').html($(rt));
      $('#skinny-modal').modal();
      enableSelect2();
    }
  });
}

function addObject(modalTitle) {
  $('.add-object').click(function(e) {
    e.preventDefault();
    renderFormObject(this,modalTitle, '#skinny-modal', 'get');
  })
}

function editObject(modalTitle) {
  $('.btn-edit-object').click(function(e) {
    e.preventDefault();
    renderFormObject(this);
    setModalTitle(modalTitle, '#skinny-modal');
  })
}

function submitFormAction(reload_page) {
  $('#skinny-modal').on('click', '#btn-submit-action', function(e) {
    e.preventDefault();
    var form = $('#skinny-modal').find('.modal-body > form');
    var url  = $(form).attr('action');
    $.ajax({
      method: 'post',
      url: url,
      data: $(form).serialize(),
      async: 'false',
      dataType: 'html',
      success: function(rt) {
        $('#skinny-modal').modal('hide');
        if (reload_page === true) {
          confirmationSaved();
        }
      },
      error: function(rt) {
        var form = $(rt.responseText).find('.content-modal')
        $('#skinny-modal').find('.response-content').html(form);
      }
    })
  })
}

function confirmationSaved() {
  swal( {
    title: I18n.t('messages.saved.title'),
    text: I18n.t('messages.saved.text'),
    type: 'success',
    timer: 1500,
    showConfirmButton: false
  },
  function(){
    location.reload();
  })
}
