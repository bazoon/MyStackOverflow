
class RegistrationsController < Devise::RegistrationsController
  
  skip_after_action :verify_authorized, except: :index
  

  protected

    def after_update_path_for(resource)
      profile_path(current_user)
    end

  private
 
  # def sign_up_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end
 
  # def account_update_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end
  

  #можно через ApplicationController
end