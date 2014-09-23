class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, except: [:index, :new, :create]

  def index
    @questions = Question.all.order('created_at desc')
  end

  def show
    @answers = @question.answers
    binding.pry
    @answer = Answer.new
    # @answer.errors = session[:errors] if session[:errors]
    # @answer.errors.add(session[:errors].first)
    @answer.question = @question
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: I18n.t(:created) #t
    else
      render :new
    end
  end

  def update
    
    if @question.user != current_user
      redirect_to root_path
    elsif @question.update(question_params)
      redirect_to @question, notice: I18n.t(:updated)
    else
      render :edit
    end
  end

  def destroy
    if @question.user == current_user
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
    params.require(:question).permit(:title, :body, :user_id)
  end


end
