class Api::V1::ProfilesController < Api::V1::BaseController
  respond_to :json
  skip_after_action :verify_authorized

  def me
    # respond_with UserSerializer.new(current_resource_owner).as_json
    # binding.pry
    respond_with current_resource_owner, serializer: Api::UserSerializer
  end

  def index
    respond_with User.excluding(current_resource_owner), serializer: Api::UserSerializer
  end


end