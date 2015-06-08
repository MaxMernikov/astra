class Admin::ProductsController < Admin::BaseController
  def create
    create!{ collection_url }
  end

  def update
    update!{ collection_url }
  end

  def upload_vk_photo
    product = Product.find(params[:product_id])

    product.generate_vk_photo_images unless product.vk_photo_image_file_name?
    product.upload_vk_product(params[:type])

    redirect_to :back
  end

  def change_position
    params[:positions].each_with_index do |product_id, index|
      Product.find(product_id).update_attribute(:pos, index)
    end
    render text: 'ok'
  end

private
  def product_params
    params.require(:product).permit(:title, :category_id, :cost, :show, :v3, :pos, :about_product, :description, Product::PARAMS, images_attributes: [:id, :image, :_destroy])
  end

  def collection
    get_collection_ivar || Product.by_pos
  end
end
