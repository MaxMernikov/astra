(function($) {
  $.fn.removeClassWild = function(mask) {
      return this.removeClass(function(index, cls) {
          var re = mask.replace(/\*/g, '\\S+');
          return (cls.match(new RegExp('\\b' + re + '', 'g')) || []).join(' ');
      });
  };
})(jQuery);

var resize_gridster = function(){
  $('.gridster.responsive ul').height( $('.gridster ul').width() / 5 * 2 );
}

$(document).ready(function() {
  if ($('#pagepiling').length){
    $('#pagepiling').pagepiling({
      afterLoad: function(anchorLink, index){
        $('body').removeClassWild('slide-*');
        $('body').addClass('slide-' + index);
      },
      navigation: {
        'position': 'right',
        'tooltips': []
      },
    });

    $('.slide-down').click(function(){ $('#pagepiling').pagepiling.moveSectionDown() });
  }

  if ($('.gridster.responsive ul').length){
    gridster = $(".gridster.responsive ul").gridster({
      widget_base_dimensions: [300, 200],
      widget_margins: [0, 7],
      helper: 'clone',
      max_cols: 5,
    }).data('gridster')
    resize_gridster();

    $(window).resize(function(){
      resize_gridster();
    });
  }


});