Rails.application.routes.draw do
  get '/', to: 'filter_home#index'
  devise_for :users
    
  scope '/admin' do
    get '/', to: 'welcome#index'
    
    
    
    
    resources :insta_upload
    
    
    get :zip_images, to: 'image_zip#zip_images'
    get :download_zipped_images, to: 'image_zip#download_zip'
    # post '/sites/csv/results', to: 'csv#results', as: :results
  end
  
  # todo - will slowly be moving controllers from scope to namespace
  namespace :admin do
    resources :bulk_upload, only: [:index, :create]
    resources :results
    resources :types
    
    resources :submissions
    resources :sites do
      resources :submissions
      resources :registrations
    end

    # reporting
    get :participant_report, to: 'csv#participant_report'
    get :basic_submission_report, to: 'csv#basic_submission'
    get :site_specific_time_period_report, to: 'csv#site_specific_time_period'
    get :site_specific_tags_report, to: 'csv#site_specific_tags'
    get :tag_specific_report, to: 'csv#tags_report'
    get :image_quality_report, to: 'csv#image_quality'
  end
  
  # API  
  namespace :api do
    namespace :v1 do
      resources :submissions
      get :submission_data, to: 'submissions#data'
    end
  end
end
