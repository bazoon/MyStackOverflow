class VotesController < ApplicationController
  before_action :load_voteable
  respond_to :json
  after_action :publish_up, only: :vote_up
  after_action :publish_down, only: :vote_down

  def vote_up
    @rm = RatingModifier.new(current_user)
    @rm.vote_up(@voteable)
    respond_with @voteable
  end

  def vote_down
    @rm = RatingModifier.new(current_user)
    @rm.vote_down(@voteable)
    respond_with @voteable
  end

  private

  def publish_up
    PrivatePub.publish_to '/questions', "vote_up_#{@resource}" => { id: @voteable.id }
  end

  def publish_down
    PrivatePub.publish_to '/questions', "vote_down_#{@resource}" => { id: @voteable.id } 
  end

  def load_voteable
    @resource, id = request.path.split('/')[1, 2]
    @resource = @resource.singularize
    @voteable = @resource.classify.constantize.find(id)
  end

end
