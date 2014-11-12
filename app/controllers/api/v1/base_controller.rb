class Api::V1::BaseController < ApplicationController
  after_action :verify_authorized
  
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
  doorkeeper_for :all
  layout false

  protected

  def current_user
    current_resource_owner
  end

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end