class QuestionTagsController < ApplicationController

  def search
    @tag = params.permit(:tag)[:tag]
    @questions = Question.tagged_with(@tag)
    
  end

end
