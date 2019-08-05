Rails.application.routes.draw do
  get 'filter', to: 'filter_home#index'
  devise_for :users
  get 'welcome/index'

  resources :types
  resources :submissions
  

  resources :sites do
    resources :submissions
    resources :registrations
  end
  
  resources :bulk_upload, only: [:index, :create]

  post '/sites/csv/results', to: 'csv#results', as: :results

  get '/d3/machrie', to: 'd3#machrie'
  
  root 'welcome#index'

  # API  
  namespace :api do
    namespace :v1 do
      resources :submissions
    end
  end
end
