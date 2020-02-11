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

    # post '/sites/csv/results', to: 'csv#results', as: :results
  end

  # API  
  namespace :api do
    namespace :v1 do
      resources :submissions
      get :submission_data, to: 'submissions#data'
      get :type_specific_report, to: 'csv#type_specific'
      get :basic_submission_report, to: 'csv#basic_submission'
      get :site_specific_report, to: 'csv#site_specific'
      get :site_specific_tags_report, to: 'csv#site_specific_tags'
      get :all_tags_report, to: 'csv#tags_report'
      get :image_quality_report, to: 'csv#image_quality'
      get :all_images, to: 'image_zip#get_images'

    end
  end
end
