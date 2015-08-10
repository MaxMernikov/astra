class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # http_basic_authenticate_with name: 'max', password: '123'
  protect_from_forgery with: :exception
  before_filter :load_categories
  before_filter :cart_value

  def after_sign_in_path_for(resource)
    admin_dashboards_path
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin)
  end

  def load_categories
    @categories = Category.show.by_pos
  end

  # unless Rails.application.config.consider_all_requests_local
    rescue_from CanCan::AccessDenied, ActiveRecord::RecordNotFound, ActionController::RoutingError, ActionController::UnknownController, AbstractController::ActionNotFound, with: :render_404
  # end

  def render_404
    @random_three = Product.show.where(id: Product.show.ids.shuffle.take(3))
    set_meta_tags title: '404 Страница не найдена'
    render 'page/page_404', formats: 'html', status: '404', layout: 'webflow'
  end

  def cart_value
    astra_cart = JSON.parse(cookies[:astra_cart]) if cookies[:astra_cart].present?
    astra_cart = [] if astra_cart.blank?
    @cart_value = astra_cart.size
  end
end
