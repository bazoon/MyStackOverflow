class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_after_action :verify_authorized
  before_action :load_omniauth_info, only: [:facebook, :twitter]
  before_action :find_user, only: [:facebook, :twitter]

  #TODO: how to test?
  def facebook

  end

  def twitter
    # render json: request.env['omniauth.auth']
  end

  def save_email
    @user = User.find_or_initialize_by(email: params[:user][:email], name: params[:user][:name])
    @user.password = Devise.friendly_token[0, 20]
    if @user.persisted? || @user.update(email_params)
      @user.send_confirmation_instructions(session[:provider])
      redirect_to root_path, notice: 'Confirmation hase been sent'
    else
      render 'ask_for_email'
    end
  end

  private

  def find_user
    @auth = load_omniauth_info
    @user = User.find_for_oauth(@auth)

    if @user.persisted?
      set_flash_message(:notice, :success, kind: @auth.provider)
      sign_in_and_redirect @user, event: :authentication
    else
      session[:provider], session[:uid] = @auth.provider, @auth.provider.to_s
      render 'ask_for_email'
    end
  end






  def load_omniauth_info
    @auth = request.env['omniauth.auth']
  end

  def email_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

end