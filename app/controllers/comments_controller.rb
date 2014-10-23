class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource only: [:update, :destroy]
  before_action :load_commentable, only: :create
  before_action :new_commentable, only: :new
  after_action :publish_new_comment, only: :create

  responders :location, :flash
  respond_to :json, :js

  def new
  end

  def edit
    @comment = Comment.find(params['id'])
    @commentable = @comment.commentable_type.constantize
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    respond_with @comment

    # respond_to do |format|
      
    #   if @comment.save
    #     format.html { redirect_to :back, notice: t('created') }
    #     format.js
    #   else
    #     format.html { redirect_to :back, flash: { error: t('can_not_save_comment') } }
    #     format.js { render 'error_form' }
    #   end 

    # end
  
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update(comment_params)
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
        @commentable = comment.commentable
        comment.destroy
        format.html { redirect_to :back, notice: t('destroyed') }
        format.js
    end
  end

  private

  def publish_new_comment
    PrivatePub.publish_to '/questions', create_comment: CommentSerializer.new(@comment).as_json if @comment.valid?
  end

  def new_commentable
    prefix = params[:commentable]
    @model = prefix.constantize
    @commentable = @model.find(params["commentable_id"])
    @form_id = "#{@commentable.class.to_s.underscore}_#{@commentable.id}"
  end

  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id) 
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end

end
