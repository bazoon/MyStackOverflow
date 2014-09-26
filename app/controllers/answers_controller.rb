class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_question, only: [:new, :create]
  before_action :set_answer, only: [:edit, :show, :update, :destroy, :select]


  def create
    # binding.pry
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @answer.question, notice: t(:created)
    else
      redirect_to @answer.question, flash: { error: t(:can_not_save_answer) }
    end
  end

  def update

    if cannot? :update, @answer
      redirect_to root_path
    elsif @answer.update(answer_params)
      redirect_to @answer.question, notice: t(:updated)
    else
      render :edit
    end
    
  end

  def destroy
    
    question = @answer.question
    if can? :update, @answer
      @answer.destroy
      redirect_to question, notice: t(:destroyed)
    else
      redirect_to root_path
    end
  end

  def select
    @answer.set_as_selected if can? :select, @answer
    redirect_to @answer.question
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
