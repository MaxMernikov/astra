function closeCart(){
  $('body').removeClass('st-effect-2-right');
  $('body').removeClass('st-menu-open');
}

function successOrder(){
  $('.success-cart').show();

  $('.total-cart').hide();
  $('#new_order')[0].reset();
}