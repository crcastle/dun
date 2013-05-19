class AccomplishmentsController < ApplicationController
  before_action :set_accomplishment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /accomplishments
  def index
    teams = current_user.teams
    @accomplishments = Accomplishment.where('team_id in (?)', teams)
  end

  # GET /accomplishments/1
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.js { render json: @accomplishment }
    end
  end

  # GET /accomplishments/new
  def new
    @accomplishment = Accomplishment.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { render json: @accomplishment }
    end
  end

  # GET /accomplishments/1/edit
  def edit
    @accomplishment
  end

  # POST /accomplishments
  def create
    @accomplishment = Accomplishment.new(accomplishment_params)
    @team = @accomplishment.team

    respond_to do |format|
      if @accomplishment.save
        sync_new @accomplishment, scope: @team
        sync_update @accomplishment.team.reload

        format.html { redirect_to @accomplishment, notice: 'Accomplishment was successfully created.' }
        format.js { render json: @accomplishment, status: :created, location: @accomplishment }
      else
        format.html { render action: "new" }
        format.js { render json: @accomplishment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accomplishments/1
  def update
    respond_to do |format|
      if @accomplishment.update(accomplishment_params)
        sync_update @accomplishment
        format.html { redirect_to @accomplishment, notice: 'Accomplishment was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render action: "edit" }
        format.js { render json: @accomplishment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accomplishments/1
  def destroy
    @accomplishment.destroy

    sync_destroy @accomplishment
    # sync_update @todo.project.reload
    respond_to do |format|
      format.html { redirect_to accomplishments_path }
      format.js { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accomplishment
      @accomplishment = Accomplishment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def accomplishment_params
      params.require(:accomplishment).permit(:title, :description, :tags, :user_id)
    end
end
