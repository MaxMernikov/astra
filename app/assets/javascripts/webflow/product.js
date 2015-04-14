$(function() {
  var slideshows = $('.cycle-slideshow').on('cycle-next cycle-prev', function(e, opts) {
    slideshows.not(this).cycle('goto', opts.currSlide);
  });

  $('.slideshow-control img').click(function(){
    console.log($(this).data('slide'));
    slideshows.cycle('goto', $(this).data('slide'));
  });
});