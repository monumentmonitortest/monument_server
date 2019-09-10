Rails.application.routes.draw do
  get '/', to: 'filter_home#index'
  devise_for :users
    
  scope '/admin' do
    get '/', to: 'welcome#index'
    resources :types
    resources :submissions
    
  
    resources :sites do
      resources :submissions
      resources :registrations
    end
    
    resources :bulk_upload, only: [:index, :create]
  
    resources :insta_upload
    
    resources :results

    # get '/person-specific-type-results', to: 'results#person_specific_type_results'
    # post '/sites/csv/results', to: 'csv#results', as: :results
  end

  # API  
  namespace :api do
    namespace :v1 do
      resources :submissions
      get :type_specific_report, to: 'csv#type_specific'
      get :basic_submission_report, to: 'csv#basic_submission'
    end
  end
end
