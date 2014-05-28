class Admin::CategoriesClothsController < ApplicationController
  load_and_authorize_resource :category, parent: false
  layout 'admin'

  def index
    @cloths = Cloth.all
  end

end