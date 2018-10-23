Rails.application.routes.draw do
  get 'welcome/index'

  resources :images

  get '/images/search', to: 'images#search'

  post '/results', to: 'csv#results', as: :results

  get '/machrie', to: 'images#machrie'

  get '/d3/machrie', to: 'd3#machrie'
  
  root 'welcome#index'
end
