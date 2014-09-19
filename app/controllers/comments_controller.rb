class CommentsController < ApplicationController
  before_action :load_commentable, only: [:create]

  def new
    prefix = params[:commentable]
    @model = prefix.camelize.constantize
    @commentable = @model.find(params["commentable_id"])

  end

  def create

    comment = @commentable.comments.create(comment_params)
    if comment.save
      redirect_to :back, notice: t('created')
    else
      redirect_to :back, flash: { error: t('can_not_save_comment') }
    end 
  
  end


  private

  def load_commentable
    prefix = params[:comment][:commentable_type].underscore
    @model = prefix.camelize.constantize
    @commentable = @model.find(params[prefix+"_id"])
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end

end
