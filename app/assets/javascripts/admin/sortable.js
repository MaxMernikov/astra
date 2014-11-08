$(function() {
  $('.sortable_grid').sortable({
    stop: function(event, ui) {
      array = [];
      $('.js_sort', this).each(function(){ array.push($(this).data('id')) });

      url = '/admin/products/change_position?category_id=' + $(this).data('id')
      $.post( url, { positions: array })
    }
  });
});