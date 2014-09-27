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
    @remote = false
  end

  def edit
    @remote = true
    respond_to do |format|
      format.html
      format.js 

    end
  end

  def create
    @question = current_user.questions.new(question_params)
    
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: I18n.t(:created) }
        format.js 
      else
        format.html { render :new }
      end
    end

  end

  def update
    
    respond_to do |format|
    
      if cannot? :manage, @question
        format.html { redirect_to root_path }
      elsif @question.update(question_params)
        format.html { redirect_to @question, notice: I18n.t(:updated) }
        format.js { @answer = Answer.new }
      else
        format.html { render :edit }
        format.js do
          @remote = true
          render 'error_form' 
        end
      end

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
