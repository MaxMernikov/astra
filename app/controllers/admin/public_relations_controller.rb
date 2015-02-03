class Admin::PublicRelationsController < ApplicationController
  # load_and_authorize_resource except: [:create]
  before_action :authenticate_admin!
  layout 'admin'

  def index

  end

end