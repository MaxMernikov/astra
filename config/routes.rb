require 'sidekiq/web'

Astra::Application.routes.draw do  
  devise_for :admins, skip: [:registrations, :passwords],
    controllers: { :sessions => 'admin/sessions' }

  namespace :admin do
    resources :dashboards, path: '', only: [:index]
    resources :categories
    resources :products do
      post :change_position, on: :collection
    end
    resources :cloths
    resources :categories_cloths
    resources :orders, except: [:show, :new, :create]
    resources :feedbacks, only: [:index, :destroy]
    resources :lookbook_items, except: [:show] do
      post :save_position, on: :collection
      get :show_hide
    end
    resources :galleries
    namespace :public_relations do
      get :index
    end

    namespace :insta do
      get :statistics
      get :partial
      get :index
      get :index_2

      get :callback

      get :user
      get :user_info
      get :user_followed_by

      get :init_bot

      resources :insta_schedules, only: [:destroy], defaults: {format: :json} do
        collection do
          get :set_schedule
          get :run_workers

          get :schedules
        end
      end

      resources :insta_users, only: [:show, :index], defaults: {format: :json} do
        get :spud
        get :reset_spud
        get :relationship
        get :followers
        get :info
        collection do
          get :in_spudding
        end
      end

    end

  end

  namespace :page, path: '' do
    get :about
    get :contacts
    get :cart
    get :thankyou
  end
  

  resources :lookbooks, only: [:index], path: 'lookbook'
  resources :categories, only: [:show], path: ''
  resources :products, only: [:show]
  resources :orders, only: [:create] do
    get :add_item
    get :remove_item

  end
  resources :feedbacks, only: [:create]


  mount Sidekiq::Web, at: 'admin/sidekiq'
  root 'page#home'
end
