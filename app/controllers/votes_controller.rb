class VotesController < ApplicationController
  before_action :set_question
  #TODO: вложить в вопрос
 
  def up
    @rm = RatingModifier.new(current_user)
    @rm.vote_up(@question)
    
    respond_to do |format|
      format.json do
        PrivatePub.publish_to '/questions', vote_up_question: (render json: { id: @question.id })
      end
    end

  end

  def down
    @rm = RatingModifier.new(current_user)
    @rm.vote_down(@question)
    
    respond_to do |format|
      format.json do
        PrivatePub.publish_to '/questions', vote_down_question: (render json: { id: @question.id })
      end
    end
   
  end


  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  

end
