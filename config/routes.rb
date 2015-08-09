Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

  devise_scope :user do
    get 'api/v1/users', :to => "registrations#index"
    get 'api/v1/users/:id', :to => "registrations#show"
    put 'api/v1/users/:id', :to => "registrations#update"
    post 'api/v1/users', :to => "registrations#create"
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :projects
      resources :documents
      resources :roles do
        get 'users', :to => "roles#get_users" 
      end
    end
  end
end
