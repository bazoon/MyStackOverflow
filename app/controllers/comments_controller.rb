class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_commentable, only: [:create]

  def new
    prefix = params[:commentable]
    @model = prefix.constantize
    @commentable = @model.find(params["commentable_id"])
    @form_id = "#{@commentable.class.to_s.underscore}_#{@commentable.id}"
    # # @form_id=123
  end

  def edit
    @comment = Comment.find(params['id'])
    @commentable = @comment.commentable_type.constantize
  end

  def create
    #create remove
    @comment = @commentable.comments.create(comment_params.merge({ user_id: current_user.id }))
    #comment.user = current_user

    respond_to do |format|
      
      if @comment.save
        format.html { redirect_to :back, notice: t('created') }
        format.js 
      else
        format.html { redirect_to :back, flash: { error: t('can_not_save_comment') } }
        format.js { render 'error_form' }
      end 

    end
  
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if cannot? :manage, @comment
        format.html { redirect_to root_path, flash: { error: t('can_not_update_comment') } }
        format.js { head 403 }
      elsif @comment.update(comment_params)
        format.html { redirect_to :back, notice: t('updated') }
        format.js 
      else
        format.html { redirect_to :back, flash: { error: t('can_not_save_comment') } }
        format.js { render 'update_error_form' }
      end
    end
  end

  def destroy
    # binding.pry
    comment = Comment.find(params[:id])

    respond_to do |format|
      if cannot? :manage, comment
        format.html { redirect_to root_path, flash: { error: t('can_not_destroy_comment') } }
        format.js { head 403 }
      else
        @commentable = comment.commentable
        comment.destroy
        format.html { redirect_to :back, notice: t('destroyed') }
        format.js
      end
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
