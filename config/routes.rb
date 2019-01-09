Rails.application.routes.draw do
  get 'welcome/index'

  resources :images
  resources :types
  resources :submissions, only: [:index, :edit]
  
  resources :sites do
    resources :submissions
  end

  get '/submissions', to: 'submissions#plain_index'

  get '/images/search', to: 'images#search'

  post '/results', to: 'csv#results', as: :results

  get '/machrie', to: 'images#machrie'

  get '/d3/machrie', to: 'd3#machrie'
  
  root 'welcome#index'
end
