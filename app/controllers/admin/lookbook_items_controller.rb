class Admin::LookbookItemsController < Admin::BaseController
  def create
    create!{ collection_url }
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

  def permitted_params
    params.permit(:lookbook_item => [:image, :position, :background_position, :product_id, :url, :comment, :show])
  end
end