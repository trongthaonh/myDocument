Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :projects
    end
  end
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
    end
  end
end
