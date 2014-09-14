class QuestionsController < ApplicationController

  before_action :set_question, except: [:index, :new, :create]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def update
    
    if @question.user_id != current_user.id
      redirect_to root_path
    elsif @question.update(question_params)
      redirect_to @question
    else  
      render :edit
    end
  end

  def destroy

    if @question.user_id == current_user.id
      @question.destroy
      redirect_to questions_path
    else
      redirect_to root_path
    end
  end


  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end


end
