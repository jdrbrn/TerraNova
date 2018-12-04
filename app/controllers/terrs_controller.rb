class TerrsController < ApplicationController
  before_action :set_terr, only: [:show, :edit, :update, :destroy]

  # GET /terrs
  # GET /terrs.json
  def index
    @terrs = Terr.all
  end

  # GET /terrs/1
  # GET /terrs/1.json
  def show
  end

  # GET /terrs/new
  def new
    @terr = Terr.new
    @terr.history=[]
  end

  # GET /terrs/1/edit
  def edit
  end

  # POST /terrs
  # POST /terrs.json
  def create
    @terr = Terr.new(terr_params)

    respond_to do |format|
      if @terr.save
        format.html { redirect_to @terr, notice: 'Territory was successfully created.' }
        format.json { render :show, status: :created, location: @terr }
      else
        format.html { render :new }
        format.json { render json: @terr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /terrs/1
  # PATCH/PUT /terrs/1.json
  def update
    # makes a copy of the params so that we can edit them
    tempParams=terr_params
    # creates a copy of the terr's history that may be edited and then resaved
    tempParams["history"]=@terr.history
    if params[:historyDelete]
      params[:historyDelete].each do |historyIndex|
        if params[:historyDelete][historyIndex]=="1"
          # Deletes history records by getting the original record from the saved history
          # Doesn't delete by index, but by contents because the index of the mutable record will change with deletes
          tempParams["history"].delete(@terr.history[historyIndex.to_i])
        end
      end
    end
    respond_to do |format|
      if @terr.update(tempParams)
        format.html { redirect_to @terr, notice: 'Territory was successfully updated.' }
        format.json { render :show, status: :ok, location: @terr }
      else
        format.html { render :edit }
        format.json { render json: @terr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terrs/1
  # DELETE /terrs/1.json
  def destroy
    #Since multiple records can be linked to a territory those also need to be destroyed
    #Each step follows the same process
    # 1) Get all entries of a certain type that link to the Territory
    # 2) Delete those entries one by one
    dncs=Dnc.all.select{|dnc| dnc.terrid==@terr.id}
    dncs.each do |dnc|
      dnc.destroy
    end
    terrouts=Terrout.all.select{|terrout| terrout.terrid==@terr.id}
    terrouts.each do |terrout|
      terrout.destroy
    end
    terrins=Terrin.all.select{|terrin| terrin.terrid==@terr.id}
    terrins.each do |terrin|
      terrin.destroy
    end
    @terr.destroy
    respond_to do |format|
      format.html { redirect_to terrs_url, notice: 'Territory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_terr
      @terr = Terr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def terr_params
      params.require(:terr).permit(:name, :region, :datecomp, :notes, :history, :historyDelete)
    end
end
