var resize_gridster = function(){
  $('.gridster.responsive ul').height( $('.gridster ul').width() / 3 * 2 );
};

var return_lookbook_slide = function(){
  $('.lookbook-slide.active').removeClass('active');
  $('.lookbook-slide.passive').removeClass('passive');
};

var render_result = function(data){
  $(window).scrollTop(0);

  $('.lookbook-gridster').addClass('gridster');
  $(this).removeClass('close');

  $('.lookbook-gridster').html('<ul></ul>');
  
  $(window).resize(function(){
    resize_gridster();
  });

  $('.w-row').hide();

  gridster = $(".gridster.responsive ul").gridster({
    widget_base_dimensions: [300, 200],
    widget_margins: [0, 7],
    helper: 'clone',
    max_cols: 3,
  }).data('gridster');

  gridster.disable();

  function addElement(widget){
    elem = '<li data-col=' + widget.col + ' data-row=' + widget.row + '  style= "background-image: url(' + widget.bg_size + '); background-position: ' + widget.bg_position + '"></li>';
    return gridster.add_widget.apply(gridster, [elem, widget.size_x, widget.size_y])
  }

  for (var i = 0; i < data.length; i++) {
    (function(idx){
      var cof = 0;
      if(idx < 5){ cof = idx } else { cof = 5 };

      setTimeout(function(){
        addElement(data[idx]);
        resize_gridster(); 
      }, 250 * cof + 350);

    })(i);
  };

  resize_gridster(); 
};

$(function() {
  var currentScrollTop = 0;
  $('.lookbook-slide').click(function(){
    start_func = Date.now();

    currentScrollTop = $(window).scrollTop();

    $('.go-back-button').removeClass('close');
    $(this).addClass('active');
    $('.lookbook-slide:not(.active)').addClass('passive');


    $.ajax({
      url: "1",
      context: document.body
        }).done(function(data) {
          end_func = Date.now();
          console.log(end_func - start_func);

          render_timeout = 500 - (end_func - start_func)
          if( render_timeout < 0){render_timeout = 0}
          
          setTimeout(function(){
            render_result(data);
          }, render_timeout );
          
        });
      });

  $('.go-back-button').click(function(){
    $(this).addClass('close');
    $('.w-row').show();

    setTimeout(function(){
      return_lookbook_slide();
    }, 350);

    $('.lookbook-gridster').empty();
    
    $('.lookbook-gridster').removeClass('gridster');

    $('html, body').scrollTop(currentScrollTop);

  })

});