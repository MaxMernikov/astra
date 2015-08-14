$(window).on('scroll', function() {
  // $('.product-block')
        // Momentarily declare all divs out of the viewport...
        // .removeClass('within-viewport');
        // Then filter them to reveal which ones are still within it
  console.log($('.product-block img').filter(':within-viewport'))
  console.log($('#test').filter(':within-viewport'))

  // .addClass('within-viewport');

});