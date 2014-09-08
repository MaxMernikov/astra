$.fn.scrollStopped = function(callback) {
  $(this).scroll(function(){
    var self = this, $this = $(self);
      if ($this.data('scrollTimeout')) {
        clearTimeout($this.data('scrollTimeout'));
      }
      $this.data('scrollTimeout', setTimeout(callback,250,self));
    });
  };

$(window).scrollStopped(function(){
  $( ".header" ).css( "background-color", "rgba(255, 255, 255, 1)" );
});

$( window ).scroll(function( event ) {
  $( ".header" ).css( "background-color", "rgba(255, 255, 255, 0.9)" );
});