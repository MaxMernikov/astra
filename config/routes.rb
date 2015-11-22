Astra::Application.routes.draw do  
  devise_for :admins, skip: [:registrations, :passwords],
    controllers: { :sessions => 'admin/sessions' }

  namespace :admin do
    resources :dashboards, path: '', only: [:index] do
      collection do
        get :completed
        get :vk_friends
        get :image_resize
        post :image_resize_run
      end
    end

    resources :categories
    resources :products do
      post :change_position, on: :collection
      get :upload_vk_photo
    end
    resources :cloths
    resources :categories_cloths
    resources :orders, except: [:show, :new, :create] do
      get :completed
    end
    resources :feedbacks, only: [:index, :destroy]
    resources :lookbook_categories do
      resources :lookbook_items, except: [:show] do
        post :save_position, on: :collection
        get :show_hide
      end
    end
    resources :statistics, only: :index

    namespace :instagram do
      get :callback
      get :connect
      get :limits

      post :init_subscribers
      get :get_likes      

      get :index
    end
  end

  namespace :page, path: '' do
    get :about
    get :contacts
    get :cart
    get :thankyou
    get :test
  end
  

  resources :lookbooks, only: [:index, :show], path: 'lookbook' do
    get :index_2, on: :collection
    get :index_3, on: :collection


  end
  resources :categories, only: [:show], path: ''
  resources :products, only: [:show]
  resources :orders, only: [:create] do
    get :add_item
    get :remove_item

  end
  resources :feedbacks, only: [:create]

  root 'page#home'
end
