class CommentsController < ApplicationController

  before_action :find_resources

  def index
    @comments = @accomplishment.comments

    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def show
    @comment = @accomplishment.comments.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  def new
    @comment = @accomplishment.comments.build

    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = @accomplishment.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        sync_new @comment, scope: @accomplishment
        @comment = nil
        sync_update @accomplishment
        format.html { redirect_to @accomplishment, notice: 'Comment was successfully created.' }
        format.js { head :no_content }
      else
        sync_update @accomplishment
        format.html { render action: "new" }
        format.js { head :no_content }
      end
    end
  end

  def update
    @comment = @accomplishment.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to @accomplishment, notice: 'Comment was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @accomplishment.comments.find(params[:id])
    @comment.destroy
    sync_destroy @comment
    # sync_update @todo.project
    respond_to do |format|
      format.html { redirect_to @accomplishment }
      format.js { head :no_content }
    end
  end


  private

  def comment_params
    params.require(:comment).permit :message
  end

  def find_resources
    @accomplishment = current_user.accomplishments.find(params[:accomplishment_id])
  end
end
