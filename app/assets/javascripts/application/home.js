(function($) {
  $.fn.removeClassWild = function(mask) {
      return this.removeClass(function(index, cls) {
          var re = mask.replace(/\*/g, '\\S+');
          return (cls.match(new RegExp('\\b' + re + '', 'g')) || []).join(' ');
      });
  };
})(jQuery);

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


});