class TerrinsController < ApplicationController
  before_action :set_terrin, only: [:show, :edit, :update, :destroy]

  # GET /terrins
  # GET /terrins.json
  def index
    @terrins = Terrin.all
  end

  # GET /terrins/1
  # GET /terrins/1.json
  def show
  end

  # GET /terrins/new
  def new
    @terrin = Terrin.new
  end

  # GET /terrins/1/edit
  def edit
  end

  # POST /terrins
  # POST /terrins.json
  def create
    @terrin = Terrin.new(terrin_params)

    respond_to do |format|
      if @terrin.save
        format.html { redirect_to @terrin, notice: 'Terrin was successfully created.' }
        format.json { render :show, status: :created, location: @terrin }
      else
        format.html { render :new }
        format.json { render json: @terrin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /terrins/1
  # PATCH/PUT /terrins/1.json
  def update
    respond_to do |format|
      if @terrin.update(terrin_params)
        format.html { redirect_to @terrin, notice: 'Terrin was successfully updated.' }
        format.json { render :show, status: :ok, location: @terrin }
      else
        format.html { render :edit }
        format.json { render json: @terrin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terrins/1
  # DELETE /terrins/1.json
  def destroy
    @terrin.destroy
    respond_to do |format|
      format.html { redirect_to terrins_url, notice: 'Terrin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_terrin
      @terrin = Terrin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def terrin_params
      params.require(:terrin).permit(:terrid)
    end
end
