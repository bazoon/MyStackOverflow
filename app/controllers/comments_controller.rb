class CommentsController < ApplicationController
  before_action :load_commentable, only: [:create]

  def new
    prefix = params[:commentable]
    @model = prefix.camelize.constantize
    @commentable = @model.find(params["commentable_id"])

  end

  def edit
    @comment = Comment.find(params['id'])
    @commentable = @comment.commentable_type.constantize
  end

  def create

    comment = @commentable.comments.create(comment_params.merge({ user_id: current_user.id }))
    if comment.save
      redirect_to :back, notice: t('created')
    else
      redirect_to :back, flash: { error: t('can_not_save_comment') }
    end 
  
  end

  def update
    
    comment = Comment.find(params[:id])
    
    if cannot? :update, comment
      redirect_to root_path, flash: { error: t('can_not_update_comment') } 
    elsif comment.update(comment_params)
      redirect_to :back, notice: t('updated')
    else
      redirect_to :back, flash: { error: t('can_not_save_comment') }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if cannot? :update, comment
      redirect_to root_path, flash: { error: t('can_not_destroy_comment') }
    else
      comment.destroy
      redirect_to :back, notice: t('destroyed')
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
