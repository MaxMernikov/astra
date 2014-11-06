$(function(){
  gridster = $(".gridster ul").gridster({
    widget_base_dimensions: [300, 217],
    // widget_margins: [0, 7],
    widget_margins: [8, 8],
    helper: 'clone',
    max_cols: 4,
    resize: {
      enabled: true
    },
    serialize_params: function($w, wgd) {
      return {
        id: $($w).data('id'),
        col: wgd.col,
        row: wgd.row,
        size_x: wgd.size_x,
        size_y: wgd.size_y
      };
    }
  }).data('gridster');

  $('#js-seralize').on('click', function() {
    url = '/admin/lookbook_items/save_position'
    $.post( url, { positions: gridster.serialize() })
  })
});