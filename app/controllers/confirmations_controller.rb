class ConfirmationsController < Devise::ConfirmationsController
  
  def show
    @user = User.with_token(params[:confirmation_token])
    if valid_user?(@user)
      confirm_and_sign_in(@user)
    else
      redirect_to root_path, notice: I18n.t(:unconfirmed)
    end
  end


  private

  def confirm_and_sign_in(user)
    user.confirm_and_authorize(session[:provider], session[:uid])
    set_flash_message(:notice, :confirmed) if is_flashing_format?
    sign_in_and_redirect user
  end

  def valid_user?(user)
    user && user.confirmation_sent_at > 6.hours.ago
  end


end