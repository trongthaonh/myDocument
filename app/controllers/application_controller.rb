class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  
  #Allow controllers to handle token authentication
  acts_as_token_authentication_handler_for User
  
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
