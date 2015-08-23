Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => "overrides/registrations",
    :sessions => "overrides/sessions",
    :passwords => "overrides/passwords"
  }

  devise_scope :user do
    get 'api/v1/users', :to => "overrides/registrations#index"
    get 'api/v1/users/:id', :to => "overrides/registrations#show"
    put 'api/v1/users/:id', :to => "overrides/registrations#update"
    post 'api/v1/users', :to => "overrides/registrations#create"
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :projects
      resources :documents
      resources :bookmarks
      resources :activities
      resources :roles do
        get 'users', :to => "roles#get_users" 
      end
    end
  end
end
