Rails.application.routes.draw do
  get 'welcome/index'

  resources :images
  resources :types
  resources :submissions
  
  resources :sites do
    resources :submissions
    resources :registrations
  end

  get '/submissions', to: 'submissions#plain_index'

  get '/images/search', to: 'images#search'

  post '/results', to: 'csv#results', as: :results

  get '/machrie', to: 'images#machrie'

  get '/d3/machrie', to: 'd3#machrie'
  
  root 'welcome#index'
end
