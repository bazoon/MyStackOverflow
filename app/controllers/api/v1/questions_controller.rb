class Api::V1::QuestionsController < Api::V1::BaseController
  respond_to :json
  

  def index
    authorize Question, :index?
    
    respond_with Question.all, each_serializer: Api::QuestionSerializer
  end

  def show
    question = Question.find(params[:id])
    authorize question, :show?
    respond_with question, serializer: Api::QuestionSerializer
  end

  def create
    # binding.pry
    authorize Question, :create?
    respond_with @question = current_resource_owner.questions.create(question_params)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :tag_list)
  end

end