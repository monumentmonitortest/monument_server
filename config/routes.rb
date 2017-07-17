Rails.application.routes.draw do
  get 'welcome/index'

  resources :images

  get '/images/search', to: 'images#search'
  get '/csv', to: 'images#csv', as: :csv


  root 'welcome#index'
end
