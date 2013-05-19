class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]
  before_action :find_resources

  # GET /likes
  def index
    # @likes = Like.all
  end

  # GET /likes/1
  def show
  end

  # GET /likes/new
  def new
    # @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes
  def create
    @like = @accomplishment.likes.build
    @like.user = current_user

    respond_to do |format|
      if @like.save
        # binding.remote_pry
        sync_update @accomplishment
        format.html { redirect_to @accomplishment }
        format.js { head :no_content }
      else
        sync_update @accomplishment
        format.html { render action: "new" }
        format.js { head :no_content }
      end
    end
  end

  # PATCH/PUT /likes/1
  def update
    # if @like.update(like_params)
    #   redirect_to @like, notice: 'Like was successfully updated.'
    # else
    #   render action: 'edit'
    # end
  end

  # DELETE /likes/1
  def destroy
    @like = @accomplishment.likes.find_by(user: current_user)
    @like.destroy
    sync_update @accomplishment
    respond_to do |format|
      format.html { redirect_to @accomplishment }
      format.js { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    def find_resources
      @accomplishment = Accomplishment.find(params[:accomplishment_id])
    end

    # Only allow a trusted parameter "white list" through.
    def like_params
      params.require(:like).permit(:accomplishment_id, :user_id)
    end
end
