class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource only: [:update, :destroy]
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
    # @question.attachments.build
  end

  def edit
    @remote = true
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    # binding.pry
    @question = current_user.questions.new(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: I18n.t(:created) }
      else
        format.html { render :new }
      end
    end

  end

  def update
    
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: I18n.t(:updated) }
        format.js { @answer = Answer.new }
      else
        format.html { render :edit }
        format.js { render 'error_form' }
      end

    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: I18n.t(:destroyed)
  end


  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :_destroy, :id])
  end


end
