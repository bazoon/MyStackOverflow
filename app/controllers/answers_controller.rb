class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  load_and_authorize_resource only: [:update, :destroy, :select]
  before_action :set_question, only: [:new, :create]
  before_action :set_answer, only: [:edit, :show, :update, :destroy, :select]


  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @question = @answer.question

 

    respond_to do |format|
      if @answer.save
        format.json do
          PrivatePub.publish_to '/questions', create_answer: (render template: 'answers/create.json.jbuilder')
        end
        # format.json { render nothing: true }
      else
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end

  end

  def show
    respond_to do |format|
      format.json
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
   
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.json do
          PrivatePub.publish_to '/questions', update_answer: (render template: 'answers/update.json.jbuilder')
        end
      else
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end

    end

  end

  def destroy
    question = @answer.question
    respond_to do |format|
      @answer.destroy
      format.html { redirect_to question, notice: t(:destroyed) }
      format.json do
        PrivatePub.publish_to "/questions", destroy_answer: @answer.id 
        render nothing: true
      end      
    end
  end

  def select
    @answer.set_as_selected
    respond_to do |format|
      format.html { redirect_to @answer.question }
      format.js
    end
  end

  private
  
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
