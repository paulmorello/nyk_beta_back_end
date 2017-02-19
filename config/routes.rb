Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :campaigns do
    collection do
      post 'flag', action: :flag, controller: 'campaigns'
      post 'copy', action: :copy, controller: 'campaigns'
      put  'update_note/:id', action: :update_note, controller: 'campaigns'
    end
  end
  resources :writers do
    collection do
      delete 'delete_job/:id', action: :delete_job, controller: 'writers'
      post 'flag/:id', action: :flag, controller: 'writers'
    end
  end
  resources :outlets do
    collection do
      post 'search', action: :search, controller: 'outlets'
      get 'search/:q', action: :search, controller: 'outlets'
      post 'filter', action: :filter, controller: 'outlets'
      get 'filter', action: :filter, controller: 'outlets'
    end
  end
  resources :saved_jobs, only: [:create, :update] do
    collection do
      # post '', action: :create, controller: 'saved_jobs'
      delete '', action: :destroy, controller: 'saved_jobs'
    end
  end
  resources :genres

  # devise_for :users
  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
