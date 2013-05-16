class AccomplishmentsController < ApplicationController
  before_action :set_accomplishment, only: [:show, :edit, :update, :destroy]

  # GET /accomplishments
  def index
    @accomplishments = Accomplishment.all
  end

  # GET /accomplishments/1
  def show
  end

  # GET /accomplishments/new
  def new
    @accomplishment = Accomplishment.new
  end

  # GET /accomplishments/1/edit
  def edit
  end

  # POST /accomplishments
  def create
    @accomplishment = Accomplishment.new(accomplishment_params)

    if @accomplishment.save
      redirect_to @accomplishment, notice: 'Accomplishment was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /accomplishments/1
  def update
    if @accomplishment.update(accomplishment_params)
      redirect_to @accomplishment, notice: 'Accomplishment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /accomplishments/1
  def destroy
    @accomplishment.destroy
    redirect_to accomplishments_url, notice: 'Accomplishment was successfully destroyed.'
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
