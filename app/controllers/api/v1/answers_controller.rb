class Api::V1::AnswersController < Api::V1::BaseController
  respond_to :json

  before_action :load_question, only: [:index, :create]

  def index
    authorize Question, :index?
    respond_with @question.answers, each_serializer: Api::AnswerSerializer
  end

  def show
    authorize Question, :index?
    answer = Answer.find(params[:id])
    authorize answer, :show?
    respond_with answer, serializer: Api::AnswerSerializer
  end

  def create
    authorize Answer, :create?
    
    answer = @question.answers.create(answer_params.merge(user: current_resource_owner))
    respond_with answer, serializer: Api::AnswerSerializer
  end


  private


  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end



end