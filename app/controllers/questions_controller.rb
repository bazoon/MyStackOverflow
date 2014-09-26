class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, except: [:index, :new, :create]

  def index
    @questions = Question.all.order('created_at desc')
    # binding.pry
  end

  def show
    @answers = @question.answers
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: I18n.t(:created) 
    else
      render :new
    end
  end

  def update
    
    if cannot? :manage, @question  
      redirect_to root_path
    elsif @question.update(question_params)
      redirect_to @question, notice: I18n.t(:updated)
    else
      render :edit
    end
  end

  def destroy
    if can? :manage, @question
      @question.destroy
      redirect_to questions_path, notice: I18n.t(:destroyed)
    else
      redirect_to root_path
    end
  end


  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end


end
