Rails.application.routes.draw do

  get '/auth/:service/callback' => 'services#create' 
  devise_for :users

  root :to => 'questions#index'
  
  resources :services, :only => [:index, :create, :destroy]
  resources :questions do
    resource :ratings
    resources :answers do
      resources :comments
    end
  end
  resources :tags
  resources :answers do
    resource :ratings
  end
end 
