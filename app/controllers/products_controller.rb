class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])

    set_meta_tags title:          @product.category.title,
                  description:    @product.category.detail_product,
                  image_src:      (root_url + @product.images.first.image(:preview)).gsub('//', '/'),
                  og: {
                    title:    @product.category.title,
                    type:     'product',
                    url:      request.original_url,
                    image:    (root_url + @product.images.first.image(:preview)).gsub('//', '/')
                  }
    render 'show2'
  end
end