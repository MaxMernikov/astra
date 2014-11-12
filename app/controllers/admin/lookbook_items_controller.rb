class Admin::LookbookItemsController < Admin::BaseController
  def new
    @lookbook_item = LookbookItem.new
  end

  def edit
    resource.galeries.build if resource.galeries.blank?
  end

  def create
    create!{ resource.book ? admin_galleries_url : collection_url }
  end

  def update
    resource.update_attributes(lookbook_item_params)
    redirect_to resource.book ? admin_galleries_url : collection_url
    # update!{ resource.book ? admin_galleries_url : collection_url }
  end

  def destroy
    destroy!{ resource.book ? admin_galleries_url : collection_url }
  end

  def show_hide
    lookbook_item = LookbookItem.find(params[:lookbook_item_id])
    lookbook_item.update_column(:show, !lookbook_item.show)
    render text: 'ok'
  end

  def save_position
    params['positions'].each do |position|
      position = position[1]
      item = LookbookItem.find_by(id: position['id'])
      item.update_attributes(
        position: {
          col: position['col'],
          row: position['row'],
          size_x: position['size_x'],
          size_y: position['size_y']
          },
        row: position['row']
      ) if item.present?
    end
    render text: 'ok'
  end

  def lookbook_item_params
    params.require(:lookbook_item).permit(:image, :position, :background_position, :product_id, :url, :comment, :show, :y_orient, :book, galeries_attributes: [:id, :delete, :product_id, :lookbook_item_id])
  end

  protected
    def collection
      LookbookItem.where(book: false)
    end
end