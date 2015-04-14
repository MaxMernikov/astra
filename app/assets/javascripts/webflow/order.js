$(function() {
  $('#order_phone').mask("+375 99 999-99-99");

  var order_rules = {
    'order[name]': { required:true },
    'order[phone]': { required:true}
  }

  var order_messages = {
    'order[name]': { required: "Поле обязательно для заполнения" },
    'order[phone]': { required: "Поле обязательно для заполнения" },
  };

  var validator = $("#new_order").validate({
    rules: order_rules,
    messages: order_messages,
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
});