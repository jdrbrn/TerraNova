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
        format.html { redirect_to @terr, notice: 'Terr was successfully created.' }
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
    # terr_contents=terr_params
    # if terr_contents[history].class=="String"
    #   terr_contents[history][-1]=""
    #   terr_contents[history][0]=""
    #   terr_contents.
    #^^Commented out History Edit related code
    respond_to do |format|
      if @terr.update(terr_params)
        format.html { redirect_to @terr, notice: 'Terr was successfully updated.' }
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
    dncs=Dnc.all.select{|dnc| dnc.terrid==@terr.id}
    dncs.each do |dnc|
      dnc.destroy
    end
    terrouts=Terrout.all.select{|terrout| terrout.terrid=@terr.id}
    terrouts.each do |terrout|
      terrout.destroy
    end
    terrins=Terrin.all.select{|terrin| terrin.terrid=@terr.id}
    terrins.each do |terrin|
      terrin.destroy
    end
    @terr.destroy
    respond_to do |format|
      format.html { redirect_to terrs_url, notice: 'Terr was successfully destroyed.' }
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
      params.require(:terr).permit(:name, :region, :datecomp, :notes, :history)
    end
end
