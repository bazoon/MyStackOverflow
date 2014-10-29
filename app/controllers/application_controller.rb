require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # after_action :verify_authorized, except: :index
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

 
  private

  def user_not_authorized

    flash[:error] = 'You are not authorized to perform this action'
    
    if request.format.html?
      redirect_to(root_path)
    else
      render nothing: true, status: :forbidden
    end

  end


end
