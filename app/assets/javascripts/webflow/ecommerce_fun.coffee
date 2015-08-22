productHash = (product) ->
  hash = {
    'id': product.data('id'),
    'name': product.data('name'),
    'price': product.data('price')
  }

  hash['category'] = product.data('category') if product.data('category')
  hash['list'] = product.data('list') if product.data('list')
  hash['position'] = product.data('position') if product.data('position')
  hash

ecProductView = ()->
  console.log 'ecProductView'
  $('.js-product-view .js-product').each ->
    product = productHash $(this)

    ga 'ec:addProduct', product

ecProductPageview = ()->
  console.log 'ecProductPageview'
  $('.js-product-pageview .js-product').each ->
    product = productHash $(this)

    ga 'ec:addProduct', product
    ga 'ec:setAction', 'detail'

ecCart = ()->
  console.log 'ecCart'
  $('.js-cart .js-product').each ->
    product = productHash $(this)
    product['quantity'] = 1

    ga 'ec:addProduct', product

  ga 'ec:setAction','checkout',
    'step': 1,            
    'option': 'Order Form'     

ecThanks = ()->
  console.log 'ecThanks'
  $('.js-thanks .js-product').each ->
    product = productHash $(this)
    product['quantity'] = 1

    ga 'ec:addProduct', product

  order = $('.js-order')
  ga 'ec:setAction', 'purchase',
    'id': order.data('id')
    'revenue': order.data('revenue')

window.onProductClick = (product)->
  $product = $(product)

  ga 'ec:addProduct', productHash($product)
  ga 'ec:setAction', 'click', list: $product.data('list')
  ga 'send', 'event', 'UX', 'click', hitCallback: ->
    document.location = $product.prop('href')

window.onAddToCartClick = (product)->
  $product = $(product)
  product = productHash($product)
  product['quantity'] = 1

  ga 'ec:addProduct', product
  ga 'ec:setAction', 'add'
  ga 'send', 'event', 'UX', 'click', hitCallback: ->
    $.get $product.prop('href'), (data) ->
      return

  return false

window.onRemoveFromCartClick = (product)->
  $product = $(product)
  
  ga 'ec:addProduct', productHash($product)
  ga 'ec:setAction', 'remove'
  ga 'send', 'event', 'UX', 'click', 'remove from cart', hitCallback: ->
    $.get $product.prop('href'), (data) ->
      location.reload()
      return
    return


$(document).ready ->
  ecProductView() if $('.js-product-view').length
  ecProductPageview() if $('.js-product-pageview').length
  ecCart() if $('.js-cart').length
  ecThanks() if $('.js-thanks').length
  ga 'send', 'pageview'
