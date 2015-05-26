class Admin::LookbookCategoriesController < Admin::BaseController
  def show
    @lookbook_items = LookbookCategory.find(params[:id]).lookbook_items
  end

protected
  def collection
    LookbookCategory.order(created_at: :desc)
  end

  def lookbook_category_params
    params.require(:lookbook_category).permit(:title, :overview, :image, :show, :created_at)
  end
end