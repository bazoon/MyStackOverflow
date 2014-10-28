class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  # load_and_authorize_resource only: [:update, :destroy]

  before_action :load_commentable, only: :create
  before_action :new_commentable, only: :new
  after_action :publish_new_comment, only: :create
  after_action :publish_updated_comment, only: :update
  after_action :publish_destroyed_comment, only: :destroy
  before_action :load_comment, except: [:new, :create]
  responders :location, :flash
  respond_to :json

  def new
  end

  def edit
    authorize @comment
    @commentable = @comment.commentable_type.constantize
  end

  def create
    authorize Comment
    @comment = @commentable.comments.create(comment_params.merge(user: current_user))
    respond_with @comment
  end

  def update
    authorize @comment
    @comment.update(comment_params)
    respond_with @comment
  end

  def destroy
    authorize @comment
    respond_with @comment.destroy
  end

  private

  def publish_new_comment
    PrivatePub.publish_to '/questions', create_comment: CommentSerializer.new(@comment).as_json if @comment.valid?
  end

  def publish_updated_comment
    PrivatePub.publish_to '/questions', update_comment: CommentSerializer.new(@comment).as_json if @comment.valid?
  end

  def publish_destroyed_comment
    PrivatePub.publish_to '/questions', destroy_comment: @comment.id
  end

  def load_comment
    @comment = Comment.find(params[:id])   
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
