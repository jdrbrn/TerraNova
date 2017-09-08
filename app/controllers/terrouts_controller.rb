class TerroutsController < ApplicationController
  before_action :set_terrout, only: [:show, :edit, :update, :destroy]

  # GET /terrouts
  # GET /terrouts.json
  def index
    @terrouts = Terrout.all
  end

  # GET /terrouts/1
  # GET /terrouts/1.json
  def show
  end

  # GET /terrouts/new
  def new
    @terrout = Terrout.new
  end

  # GET /terrouts/1/edit
  def edit
  end

  # POST /terrouts
  # POST /terrouts.json
  def create
    @terrout = Terrout.new(terrout_params)

    respond_to do |format|
      if @terrout.save
        format.html { redirect_to @terrout, notice: 'Terrout was successfully created.' }
        format.json { render :show, status: :created, location: @terrout }
      else
        format.html { render :new }
        format.json { render json: @terrout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /terrouts/1
  # PATCH/PUT /terrouts/1.json
  def update
    respond_to do |format|
      if @terrout.update(terrout_params)
        format.html { redirect_to @terrout, notice: 'Terrout was successfully updated.' }
        format.json { render :show, status: :ok, location: @terrout }
      else
        format.html { render :edit }
        format.json { render json: @terrout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terrouts/1
  # DELETE /terrouts/1.json
  def destroy
    @terrout.destroy
    respond_to do |format|
      format.html { redirect_to terrouts_url, notice: 'Terrout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_terrout
      @terrout = Terrout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def terrout_params
      params.require(:terrout).permit(:terrid, :publisher, :dateout, :datedue)
    end
end
