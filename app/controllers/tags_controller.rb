class TagsController < ApplicationController
  before_action :authenticate_user!, only: :tags
  skip_after_action :verify_authorized

  before_action :load_tag, only: :search
  respond_to :json, :html

  def search
    @questions = Question.tagged_with(@tag)
    respond_with @questions
  end

  def tags
    tags = Tag.find_or_new(params[:q])
    respond_with tags do |format|
      format.json { render json: tags.to_json }
    end
  end

  private
  

  def load_tag
    @tag = params.permit(:tag)[:tag]
  end


end
