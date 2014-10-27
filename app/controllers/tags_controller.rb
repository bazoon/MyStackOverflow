class TagsController < ApplicationController


  def search
    respond_to do |format|
      @tag = params.permit(:tag)[:tag]
      @questions = Question.tagged_with(@tag)
    
      format.html
      format.js { render json: @questions }
    end  
    
  end


  def tags
    name = params[:q]
    tags = Tag.find_or_new(name)
    respond_to do |format|
      format.js { render json: tags.to_json }
    end
  end



end
