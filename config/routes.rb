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
    resources :feedbacks, only: [:index]
    resources :lookbook_items, except: [:show] do
      post :save_position, on: :collection
      get :show_hide
    end
    resources :galleries
  end

  get '/about', to: 'page#about'
  get '/contacts', to: 'page#contacts'
  

  resources :lookbooks, only: [:index], path: 'lookbook'
  resources :categories, only: [:show], path: ''
  resources :products, only: [:show]
  resources :orders, only: [:create]
  resources :feedbacks, only: [:create]



  root 'page#home'
end
