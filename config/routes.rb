Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :projects
      resources :roles
    end
  end
end
