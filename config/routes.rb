Rails.application.routes.draw do
  get 'welcome/index'

  get '/images/search', to: 'images#search'

  resources :images

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
