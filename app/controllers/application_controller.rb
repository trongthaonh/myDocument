class ApplicationController < ActionController::Base

  include PublicActivity::StoreController
  
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  
  #Allow controllers to handle token authentication
  acts_as_token_authentication_handler_for User
  
  # Apply strong_parameters filtering before CanCan authorization
  # See https://github.com/ryanb/cancan/issues/571#issuecomment-10753675
  before_filter :authenticate_user!

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  
  rescue_from CanCan::AccessDenied do |exception|  
    respond_to do |format| 
      format.json { render :json=> {:error => "You don't have authorization to extract from data source"}, :status => :forbidden }  
    end   
  end

  protected

    def can_create_user
      if controller_name == 'registrations' && action_name == 'create'
        true
      else
        false
      end
    end

    def can_confirmation
      if controller_name == 'confirmations' && action_name == 'show'
        true
      else
        false
      end      
    end

    def can_reset_password
      if controller_name == 'passwords'
        true
      end
    end

    def authenticate_user!
      if user_signed_in? || can_create_user || can_confirmation || can_reset_password
        super
      else
        render :json=> {:error => "You are not logged in or incorrect CSRF token authenticity"}, :status => :forbidden 
      end
    end  
end
