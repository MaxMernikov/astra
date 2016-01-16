var currentScrollTop = 0;
var resize_gridster = function(){
  // console.log($('.gridster ul').width() / 3 * 2);
  $('.gridster.responsive ul').height( $('.gridster ul').width() / 2 * 2 );
  // console.log($('.gridster.responsive ul').height());

};

var return_lookbook_slide = function(){
  $('.lookbook-slide.active').removeClass('active');
  $('.lookbook-slide.passive').removeClass('passive');
  $('.lookbook-gridster').empty();
  $('.w-row').show();
  $('html, body').scrollTop(currentScrollTop);
};

var render_result = function(data){
  $(window).scrollTop(0);

  $(this).removeClass('close');

  $('.lookbook-gridster').html('<ul></ul>');

  $(window).resize(function(){
    resize_gridster();
  });

  $('.w-row').hide();

  gridster = $(".gridster.responsive ul").gridster({
    widget_base_dimensions: [200, 200],
    widget_margins: [0, 7],
    helper: 'clone',
    max_cols: 5,
    min_cols: 5,
  }).data('gridster');

  gridster.disable();

  function addElement(widget){
    console.log(widget.row);
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
  $('.lookbook-slide').click(function(){
    page_url = '/lookbook/' + $(this).data('id');

    start_func = Date.now();

    currentScrollTop = $(window).scrollTop();

    $('.go-back-button').removeClass('close');
    $('.lookbook-gridster').removeClass('close');
    $(this).addClass('active');
    $('.lookbook-slide:not(.active)').addClass('passive');

    $.ajax({
      url: page_url,
      context: document.body
        }).done(function(data) {
          end_func = Date.now();

          // window.history.pushState('', '', page_url);

          render_timeout = 500 - (end_func - start_func)
          if( render_timeout < 0){render_timeout = 0}
          
          setTimeout(function(){
            render_result(data);
          }, render_timeout );
          
        });
      });

  $('.go-back-button').click(function(){
    $(this).addClass('close');
    $('.lookbook-gridster').addClass('close');
    // window.history.pushState('', '', '/lookbook');

    setTimeout(function(){
      return_lookbook_slide();
    }, 350);

  })

});