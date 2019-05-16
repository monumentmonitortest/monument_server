Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  resources :types
  resources :submissions
  

  resources :sites do
    resources :submissions
    resources :registrations
  end
  
  get '/bulk_upload', to: 'submissions#bulk_upload'
  post '/js_bulk_upload', to: 'submissions#js_bulk_upload'

  post '/sites/csv/results', to: 'csv#results', as: :results

  get '/d3/machrie', to: 'd3#machrie'
  
  root 'welcome#index'
end
