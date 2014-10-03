class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  load_and_authorize_resource only: [:update, :destroy, :select]
  before_action :set_question, only: [:new, :create]
  before_action :set_answer, only: [:edit, :show, :update, :destroy, :select]


  def create
    # binding.pry
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @question = @answer.question

    respond_to do |format|
      if @answer.save
        flash[:notice] = t(:created)
        format.html { redirect_to @answer.question, notice: t(:created) }
        format.js { @answer = Answer.new }
      else
        flash[:error] = t(:can_not_save_answer)
        format.html { redirect_to @answer.question }
        format.js { render 'error_form' }
      end
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
        flash[:notice] = t(:updated)
        format.html { redirect_to @answer.question }
        format.js
      else
        flash[:error] = t(:can_not_update)
        format.html { render :edit }
        format.js
      end

    end

  end

  def destroy
    question = @answer.question
    respond_to do |format|
      @id = @answer.id
      @answer.destroy
      format.html { redirect_to question, notice: t(:destroyed) }
      format.js
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
    params.require(:answer).permit(:body, :question_id)
  end

end
