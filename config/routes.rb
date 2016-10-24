Rails.application.routes.draw do
  resources :campaigns
  resources :writers
  resources :outlets do
    collection do
      post 'search', action: :search, controller: 'outlets'
      get 'search/:q', action: :search, controller: 'outlets'
      post 'filter', action: :filter, controller: 'outlets'
      get 'filter', action: :filter, controller: 'outlets'
    end
  end
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
