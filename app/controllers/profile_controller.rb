class ProfileController < ApplicationController
  skip_after_action :verify_authorized, only: :show

  def show
    @user = User.find(params[:user_id])
  end



end
