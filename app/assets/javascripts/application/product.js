$( function() {
  $('.other_cloth').click( function(){
    $(this).removeClass('hidden')
    $('.label', this).text('Доступные расцветки')
  })

  $('.cloth_preview').click(function(element){
    if (!$(this).closest('.other_cloth').hasClass('hidden')){
      $('.other_cloth .active').removeClass('active');
      $(this).addClass('active');
      $('.cloth_variants').show(300);
      $('.cloth_variants .cloth_preview').attr('src', $(this).attr('src'))
      $('#order_cloth_id').val( $(this).data('clothId') );
      $('html, body').animate({
        scrollTop: ($('#new_order').offset().top - 70)
      }, 400);
      $('#add_cloth').text('изменить')
    }
  })

  $('#remove_cloth').click(function(){ remove_cloth() });

  $('#add_cloth').click(function(){
    $('html, body').animate({
      scrollTop: ($('.other_cloth').offset().top - 16)
    }, 400);
    $('.other_cloth').removeClass('hidden');
  })

  // $.validator.addMethod("PHONE", function(value,element){
  //   // if(element.value.match(/^8 \(\d\d\d\) \d\d\d \d\d \d\d$/) != null){
  //   if(element.value.match(/^\d\d\d \d\d\d-\d\d-\d\d$/) != null){
  //     value = true;
  //   }else{ value = false; }
  //   return this.optional(element) || value;
  // },  "Телефон указан в неверном формате.");

  var rules = {
    'order[name]': { required:true },
    'order[phone]': { required:true}
    // 'order[phone]': { required:true, PHONE: true }

  };

  var messages = {
    'order[name]': { required: "Поле обязательно для заполнения" },
    'order[phone]': { required: "Поле обязательно для заполнения" },
  };

  var validator = $("#new_order").validate({
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

  $('#order_phone').mask("(999) 999-99-99");

  $('#buy_it_button').click(function(){
    $('#buy_it_button').hide(300);
    $('#buy_it_content').show(300);
    $('#order_name').focus();
  })

} )

function remove_cloth(){
  $('.cloth_variants').hide(300);
  $('.cloth_preview.active').removeClass('active');
  $('#add_cloth').text('выбрать');
}

function success_order(){
  var modal = new $.UIkit.modal.Modal("#success_order");
  modal.show();
  $('#new_order')[0].reset();
  remove_cloth();
}