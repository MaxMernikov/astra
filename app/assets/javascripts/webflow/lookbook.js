$(function() {
  $('.lookbook-slide').click(function(){
    $('.lookbook-slide.active').removeClass('active')
    $('.lookbook-slide.passive').removeClass('passive')
    
    $(this).addClass('active')
    $('.lookbook-slide:not(.active)').addClass('passive')
  });

});