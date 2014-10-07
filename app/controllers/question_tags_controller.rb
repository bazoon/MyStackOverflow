class QuestionTagsController < ApplicationController

  def search
    respond_to do |format|
      @tag = params.permit(:tag)[:tag]
      @questions = Question.tagged_with(@tag)
    
      format.html
      format.js { render json: @questions }
    end  
  end

end
