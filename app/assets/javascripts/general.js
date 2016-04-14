I18n.defaultLocale = 'pt-BR';
I18n.locale = 'pt-BR';

function replaceAll(term, search, replace) {
  if (replace === undefined) {
    return toString(term);
  }
  return term.replace(new RegExp('[' + search + ']', 'g'), replace);
}

var Btn = {
  next: function() {
    $('.btn-next').click(function(e) {
      e.preventDefault();
      $(this).closest('form').submit();
    })
  }
}

function enableiCheck() {
  $('.i-checks').iCheck({
    checkboxClass: 'icheckbox_square-green',
    radioClass: 'iradio_square-green'
  });
}

function enableSelect2() {
  $('.select2').select2({
    "language": "pt-BR"
  });
}

var General = {
  submit: function() {
    $('.btn-submit').click(function(e) {
      e.preventDefault();
      $(this).closest('form').submit()
    });
  },

  easterEgg: function() {
    var egg = new Egg();
    egg
      .addCode("a,b,o,u,t", function() {
        $('#about').modal()
      }).listen();
  },

  reload: function() {
    $('#reload').click(function(e) { e.preventDefault() ; location.reload() ; })
  },

  animatedPercentage: function() {
    $.each($('td.animatedPercentage'), function(){
      var percentageValue = parseFloat($(this).attr('data-value'));

      if ($(this).attr('data-value') === undefined) {
        dataValue = '0'
      } else {
        dataValue = $(this).attr('data-value').toString()
      }

      var percent_number_step = $.animateNumber.numberStepFactories.append('%')
      var radix = 10
      var markup = '.animatedPercentage.' + parseInt(dataValue, radix);
     $(markup).animateNumber({
       number: percentageValue,
       easing: 'easeInQuad'
     }, 2500);
    })
  },

  textEditor: function() {
    $('.summernote').summernote({
      height: 200,
      lang: 'pt-BR',
      toolbar: [
       ['style', ['bold', 'italic', 'underline', 'clear']],
       ['font', ['strikethrough', 'superscript', 'subscript']],
       ['fontsize', ['fontsize']],
       ['para', ['ul', 'ol', 'paragraph']],
       ['height', ['height']],
       ['Misc', ['fullscreen']]
      ]
    });
  },

  tagsInput:function() {
    $(".tagsinput").tagsinput({
      tagClass: 'label bg-teal'
    })
  },

  loadFilenameUploadedFile: function() {
    $(":file").each(function() {
      var placeholder = $(this).attr("data-placeholder")
      var uploadedFilename = ( placeholder === 'null' ? '' : placeholder)
      $(this).parent().find('.bootstrap-filestyle input').val(uploadedFilename)
    });
  },

  uploadFile: function() {
    $(":file").filestyle({
      buttonName: "btn-success",
      buttonText: ""
    });
  }
}

var Mask = {
  datePicker: function() {
    $(".date-time-picker").each(function() {
      $(this).datetimepicker({
        format: 'DD/MM/YYYY',
        locale: moment.locale('pt-br'),
        icons: {
          next: "fa fa-chevron-right",
          previous: "fa fa-chevron-left"
        }
      })
    })
  },

  cellphone: function() {
    $(".phone").mask("(99)99999-9999");
  },

  money: function() {
    $(".currency").attr("data-prefix", "R$ ").attr("data-thousands", ".").attr("data-decimal", ",").maskMoney();
    $('.currency').each(function() {
      var value = $(this).attr('value');
      value = parseFloat(value).toFixed(2);
      $(this).attr('value', value);
      $(this).maskMoney('mask', $(this).attr('value'));
    })
  },

  justNumbers: function() {
    $('.numbers-only').keyup(function () {
      this.value = this.value.replace(/[^0-9\,]/g,'');
    });
  }
}

$(document).ready(function() {
  enableSelect2();
  enableiCheck();
  Mask.datePicker();
});
