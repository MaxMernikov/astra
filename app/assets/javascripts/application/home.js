var $win = $(window)

function scrolium(){
  var full_header_h = 278
  var small_header_h = 65


  $scrollTop = $win.scrollTop()

  if($scrollTop <= (full_header_h - small_header_h) ){
    if ($('.header-').hasClass('small')){
      $('.header-').removeClass('small')
    }

    $('.header-').css('height', full_header_h - $scrollTop)

    var fragment_top = 0 - ($scrollTop / 1.66)
    $('.header- .menu-fragment').css('top', (fragment_top > -121 ? fragment_top : -121) )

    var small_top = 0 - ($scrollTop / 1.65)
    $('.header- .small').css('top', (small_top > -122 ? small_top : -122) )

    $('.header- .slogan').css('opacity', 1 - ($scrollTop / 100))
    $('.header- .city').css('opacity', 0 + ($scrollTop / 100))

    var full_img_opacity = 0.2 - ($scrollTop / 100 / 6)
    $('.header- .full img').css('opacity', (full_img_opacity > 0.01 ? full_img_opacity : 0 ) )

  } else {
    if (!$('.header-').hasClass('small')){
      $('.header-').addClass('small')

      $('.header- .menu-fragment').css('top', 0)
      $('.header-').css('height', 67)
      $('.header- .small').css('top', 0)
    }
  }

  if($scrollTop <= 300 ){
    $('.header- .full').css('top', 0 - $scrollTop)
  }
}

$(document).ready(function() {

  $win.scroll(function() {
    scrolium();
  })
});