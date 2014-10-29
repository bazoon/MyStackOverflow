class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  before_action :set_question, only: [:new, :create]
  before_action :set_answer, only: [:edit, :show, :update, :destroy, :select]

  after_action :publish_new_answer, only: :create
  after_action :publish_updated_answer, only: :update
  after_action :publish_deleted_answer, only: :destroy
  
  responders :location, :flash 
  respond_to :json, :js


  #TODO: refactor
  def create
    authorize Answer
    # @answer = @question.answers.new(answer_params)
    @answer = @question.answers.create(answer_params.merge(user: current_user))
    # @answer.user = current_user
    # @question = @answer.question
    # @answer.save
    respond_with @answer
  end

  def show
    authorize @answer
    respond_to do |format|
      format.json
    end
  end

  #TODO: не стоит аякс делать
  def edit
    authorize @answer
    respond_with @answer
  end

  def update
    authorize @answer
    @answer.update(answer_params)
    respond_with @answer
  end

  def destroy
    authorize @answer
    respond_with @answer.destroy
  end

  def select
    authorize @answer
    @answer.set_as_selected
    respond_with @answer
  end

  private
  
  def publish_new_answer
    PrivatePub.publish_to '/questions', create_answer: AnswerSerializer.new(@answer).as_json if @answer.valid?
  end

  def publish_updated_answer
    PrivatePub.publish_to '/questions', update_answer: AnswerSerializer.new(@answer).as_json if @answer.valid?
  end

  def publish_deleted_answer
    PrivatePub.publish_to '/questions', destroy_answer: @answer.id
  end
  
  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id, attachments_attributes: [:file, :_destroy, :id])
  end

end
