class ProfileController < ApplicationController
  skip_after_action :verify_authorized
  before_action :set_bound, only: :index

  def show
    @user = User.find(params[:user_id])
  end

  def index
    @users = User.send(@bound).paginate(page: params[:page], per_page: 50)
  end

  private

  def set_bound
    _, bound = request.path.split('/')[1, 2]
    @bound = %w(alphabeticaly active rating membership).include?(bound) ? bound : "all"
  end


end
