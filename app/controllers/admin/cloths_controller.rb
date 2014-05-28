class Admin::ClothsController < ApplicationController
  load_and_authorize_resource except: [:create]
  layout 'admin'
  before_action :set_cloth, only: [:edit, :update, :destroy]

  def index
    @cloths = Cloth.all
  end

  def new
    @cloth = Cloth.new
  end

  def edit
  end

  def create
    authorize! :manage, :all
    @cloth = Cloth.new(cloth_params)

    if @cloth.save
      redirect_to admin_cloths_path, notice: 'Cloth was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    params[:cloth][:category_ids] ||= []

    if @cloth.update(cloth_params)
      redirect_to admin_cloths_path, notice: 'Cloth was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @cloth.destroy
    redirect_to admin_cloths_path
  end

private
  def set_cloth
    @cloth = Cloth.find(params[:id])
  end

  def cloth_params
    # raise params.inspect
    params.require(:cloth).permit({category_ids: []}, :show, :image )
  end
end
