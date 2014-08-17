function success_feedback(){
  $('#new_feedback').hide();
  $('.js-open').hide();
  $('.js-success').show();
  $('.help_widjet').addClass('success')

}

$( function() {
  $('.help_widjet').click(function(){
    if($(this).hasClass('open')){

    }else{
      $('#new_feedback').show();
      $('#new_feedback').addClass('uk-animation-fade');
      $(this).addClass('open');

      $('.js-open').show();
      $('.js-default').hide();

      $('#feedback_name').focus();
    }
  })

  var rules = {
    'feedback[email]': { required:true },
    'feedback[body]': { required:true}
    // 'order[phone]': { required:true, PHONE: true }

  };

  var messages = {
    'feedback[email]': { required: "Поле обязательно для заполнения" },
    'feedback[body]': { required: "Надо бы хоть что то написать" },
  };

  var validator = $("#new_feedback").validate({
    rules: rules,
    messages: messages,
    onkeyup: function (element) {
        $(element).valid();
    },
    onclick: function (element) {
        $(element).valid();
    },
    meta: "validate",
    // submitHandler: function (form) {
    //   process_form(form);
    // }
  });
})