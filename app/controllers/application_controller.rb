class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # http_basic_authenticate_with name: 'max', password: '123'
  protect_from_forgery with: :exception
  before_filter :load_categories

  def after_sign_in_path_for(resource)
    admin_dashboards_path
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin)
  end

  def load_categories
    @categories = Category.show.by_pos
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from CanCan::AccessDenied, ActiveRecord::RecordNotFound, ActionController::RoutingError, ActionController::UnknownController, AbstractController::ActionNotFound, with: :render_404
  end

  def render_404
    set_meta_tags title: '404 Страница не найдена'
    render 'page/page_404', formats: 'html', status: '404'
  end
end
