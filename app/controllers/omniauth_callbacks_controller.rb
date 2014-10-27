class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_action :load_omniauth_info, only: [:facebook, :twitter]
  before_action :find_user, only: [:facebook, :twitter]
  after_action :set_flash, only: [:facebook, :twitter]

  def facebook
  end

  def twitter
    # render json: request.env['omniauth.auth']
  end

  def find_user
    @user = User.find_for_oauth(@auth)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      cookies[:provider], cookies[:uid] = @auth.provider, @auth.provider.to_s
      @user.name = @auth.info.nickname || @auth.info.name || "new user"
      render 'ask_for_email'
    end
  end


  def save_email
    @user = User.find_or_initialize_by(email: params[:user][:email])
    if @user.persisted? || @user.update(email_params)
      @user.send_confirmation_instructions(cookies[:provider])
      redirect_to root_path, notice: 'Confirmation hase been sent'
    else
      render 'ask_for_email'
    end
  end


  private

  def set_flash
    set_flash_message(:notice, :success, kind: @auth.provider) if @user.persisted? && is_navigational_format?
  end

  def load_omniauth_info
    @auth = request.env['omniauth.auth']
  end

  def email_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

end