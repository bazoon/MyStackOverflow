class QuestionVoteController < ApplicationController
  before_action :set_question
  #TODO: вложить в вопрос
  def up
    rm = RatingModifier.new(current_user)
    rm.vote_up(@question)
    
    respond_to do |format|
      format.json { render json: @question.rating }
    end
  end

  def down
    
  end


  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  

end
