class Api::V1::AnswersController < Api::V1::BaseController
  respond_to :json

  before_action :load_question, only: :index

  def index
    respond_with @question.answers
  end

  def show
    respond_with Answer.find(params[:id])
  end


  private


  def load_question
    @question = Question.find(params[:question_id])
  end


end