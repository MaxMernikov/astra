var resize_gridster = function(){
  $('.gridster.responsive ul').height( $('.gridster ul').width() / 3 * 2 );
}

$(function() {
  $('.lookbook-slide').click(function(){
    $('.lookbook-slide.active').removeClass('active')
    $('.lookbook-slide.passive').removeClass('passive')

    $(this).addClass('active')
    $('.lookbook-slide:not(.active)').addClass('passive')


    $.ajax({
      url: "1",
      context: document.body
        }).done(function(data) {
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

          for (var i=0; i < data.length; i++) {
            (function(idx){
                  setTimeout(function(){
                    addElement(data[idx]);
                    resize_gridster(); 
                  },250*idx + 350);
              })(i);
          };

          resize_gridster(); 
        });
      });

});