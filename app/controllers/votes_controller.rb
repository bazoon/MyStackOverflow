class VotesController < ApplicationController
  before_action :load_voteable
 
  def vote_up
    @rm = RatingModifier.new(current_user)
    @rm.vote_up(@voteable)
    
    respond_to do |format|
      format.json do
        PrivatePub.publish_to '/questions', "vote_up_#{@resource}" => (render json: { id: @question.id })
      end
    end

  end

  def vote_down
    @rm = RatingModifier.new(current_user)
    @rm.vote_down(@voteable)
    
    respond_to do |format|
      format.json do
        PrivatePub.publish_to '/questions', "vote_down_#{@resource}" => (render json: { id: @question.id })
      end
    end
   
  end

  private

  def load_voteable
    @resource, id = request.path.split('/')[1, 2]
    @resource = @resource.singularize
    @voteable = @resource.classify.constantize.find(id)
  end

end
