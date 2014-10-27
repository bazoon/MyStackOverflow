class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource only: [:update, :destroy]
  before_action :set_question, except: [:index, :new, :create]
  after_action :publish_question, only: [:update]

  responders :location, :flash
  respond_to :html
  
  def index
    @questions = Question.all.order('created_at desc')
  end

  def show
    @answers = @question.answers
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit
    respond_with @question
  end

  def create
    @question = current_user.questions.create(question_params)
    respond_with @question
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    @question.destroy
    respond_with @question
  end


  private

  def publish_question
    if @question.valid?
      PrivatePub.publish_to '/questions', update_question: QuestionSerializer.new(@question).as_json
    end
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :tag_tokens, attachments_attributes: [:file, :_destroy, :id])
  end


end
