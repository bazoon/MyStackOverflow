class Api::V1::QuestionsController < Api::V1::BaseController
  respond_to :json

  def index
    respond_with Question.all, serializers: Api::QuestionSerializer
  end

  def show
    # binding.pry
    question = Question.find(params[:id])
    respond_with question, serializer: Api::QuestionSerializer
  end


end