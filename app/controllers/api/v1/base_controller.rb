class Api::V1::BaseController < ApplicationController
  skip_after_action :verify_authorized
  doorkeeper_for :all
  layout false

  protected

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end