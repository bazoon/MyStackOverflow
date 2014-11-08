class Api::V1::QuestionsController < Api::V1::BaseController
  respond_to :json

  def index
    respond_with Question.all #TODO: too many?
  end

  def show
    # binding.pry
    question = Question.find(params[:id])
    respond_with question
  end


end