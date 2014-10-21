class TagsController < ApplicationController
#TODO: TagController rename

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
    tags = Tag.where(name: name)
    tags = tags.map { |tag| { id: tag.name, name: tag.name } }

    # binding.pry
    tags = [id: "#{name}", name: "New: #{name}"] if tags.empty?
    
    respond_to do |format|

      format.js { render json: tags.to_json }

    end
  end



end
