class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])

    set_meta_tags title:          "#{@product.category.dative} #{@product.title}",
                  description:    @product.description ? @product.description : @product.category.description,
                  image_src:      (root_url + @product.images.first.image(:preview)).gsub('//', '/'),
                  og: {
                    title:    "#{@product.category.dative} #{@product.title}",
                    type:     'product',
                    url:      request.original_url,
                    image:    (root_url + @product.images.first.image(:preview)).gsub('//', '/')
                  }
    return render 'show3' if @product.v3
    render 'show2'
  end
end