class TerrinsController < ApplicationController
  #Enables basic httpAuth for all pages
  if TerraNovaConfig["enableHTTPAuth"] == "true"
    http_basic_authenticate_with name: TerraNovaConfig["HTTPAuth"]["username"], password: TerraNovaConfig["HTTPAuth"]["password"]
  end

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
    #Manually passes the only param required
    #Rest of the paramaters are either flags or not used in creation of the terrin entry itself
    @terrin = Terrin.new({"terrid"=>terrin_params["terrid"]})
    #Constructs a date from passed in strings
    datecomp=Date.new(terrin_params["datecomp(1i)"].to_i,terrin_params["datecomp(2i)"].to_i,terrin_params["datecomp(3i)"].to_i)
    respond_to do |format|
      if @terrin.save
        #Updates the Territory's completion date
        Terr.all.find(terrin_params["terrid"]).update(datecomp: datecomp)
        #Updates the Territory's history adding a checked in listing
        Terr.all.find(@terrin.terrid).update(history: Terr.all.find(@terrin.terrid).history<<[Time.now,"Checked In",datecomp])
        format.html { redirect_to '/'}
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
        format.html { redirect_to @terrin, notice: 'Check In was successfully updated.' }
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
    #If the checkout flag is passed, we need to redirect to the terrout controller
    #So that the terrout entry can be created, and the territory can be tracked as checked out
    if params[:checkout]
      redirect_to :controller => 'terrouts', :action => 'new', :terrid => params[:checkout]
    else
      respond_to do |format|
        format.html { redirect_to terrins_url, notice: 'Check In was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_terrin
      @terrin = Terrin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def terrin_params
      params.require(:terrin).permit(:terrid, :checkout, :checkin, :datecomp)
    end
end
