class ConfirmationsController < Devise::ConfirmationsController

  def show

    @user = User.find_by_confirmation_token(params[:confirmation_token])
    
    if !@user || @user.confirmation_sent_at < 6.hours.ago
      redirect_to root_path, notice: "Incorrect confirmation. Please reconfirm your email"
    else
      @user.confirm!
      @user.authorizations.create(provider: session[:provider], uid: session[:uid])
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      sign_in_and_redirect @user
    end

  end

end