class Admin::GalleriesController < Admin::AdminController
  defaults resource_class: LookbookItem

  protected
    def collection
      LookbookItem.where(book: true)
    end
end