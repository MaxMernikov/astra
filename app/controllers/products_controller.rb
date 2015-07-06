class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])

    set_meta_tags title: "#{@product.category.dative} #{@product.title} | характеристики, оформление заказа",
      description: @product.description ? @product.description : @product.category.description,
      image_src: (root_url + @product.images.first.image(:preview)).gsub('//', '/'),
      og: {
        title: "#{@product.category.dative} #{@product.title}",
        type:  'product',
        url: request.original_url,
        image: (root_url + @product.images.first.image(:preview)).gsub('//', '/')
      },
      vk: {
        title: "#{@product.category.dative} #{@product.title}",
        url: request.original_url,
        image: (root_url + @product.images.first.image(:preview)).gsub('//', '/'),
        description: @product.description ? @product.description : @product.category.description
      }
    

    @random_three = Product.show.where(id: Product.show.ids.shuffle.take(3))
    return render('show', layout: 'webflow') if @product.v3
    render 'show2'
  end
end