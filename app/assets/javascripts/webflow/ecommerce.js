var showed_products = [];
var productHash = function(product){
  return {
    'id': product.data('id'),
    'name': product.data('name'),
    'category': product.data('category'),
    'list': product.data('list'),
    'position': product.data('position'),
    'price': product.data('price')
  }
};

var checkShowed = function(product){
  product_id = product.data('id');

  if($.inArray(product_id, showed_products) == -1){
    showed_products.push(product_id);

    ga('ec:addImpression', productHash(product));
    ga('ec:setAction', 'detail');
    // ga('send', 'event','scroll',window.location.href);
    ga('send', 'event', 'scroll', 'impression', {'nonInteraction': true});
  }
};

var onProductClick = function(elem){
  $product = $(elem);
  ga('ec:addProduct', productHash( $product ));
  ga('ec:setAction', 'click', {list: $product.data('list')});
  ga('send', 'event', 'UX', 'click', 'Results', {
    hitCallback: function() {
      document.location = $product.prop('href');
    }
  });
}

$(function() {
  $(window).on('scroll', function() {
    $('.product-block img')
      .filter(':within-viewport')
      .each(function( index, value ) {
        product = $(value).parent();

        checkShowed(product);    
      })
  });

  $('.js-product-page').each(function(){
    ga('ec:addProduct', productHash( $(this) ));
    ga('ec:setAction', 'detail');
  });

  $('.js-add-product').click(function(event){
    event.preventDefault();

    button = $(this);

    product = $('.js-product-page')[0]
    ga('ec:addProduct', productHash($(this)));
    ga('ec:setAction', 'add');
    ga('send', 'event', 'UX', 'click', 'add to cart', {
      hitCallback: function() {
        $.get( button.prop('href'), function( data ){});
      }
    });
  });

  $('.js-remove-product').click(function(event){
    event.preventDefault();

    product = $(this);

    ga('ec:addProduct', productHash($(this)));
    ga('ec:setAction', 'remove');
    ga('send', 'event', 'UX', 'click', 'remove from cart', {
      hitCallback: function() {
        $.get( product.prop('href'), function( data ){ location.reload(); 
        });
      }
    });
  });

  if($('.js-order').length > 0){
    $('.js-order .js-product').each(function(){
      product = productHash( $(this) )
      product['quantity'] = 1
      ga('ec:addProduct', product);
    });

    order = $('.js-order')
    ga('ec:setAction', 'purchase', {
      'id': order.data('id'),
      'revenue': order.data('revenue')
    });
  }

});