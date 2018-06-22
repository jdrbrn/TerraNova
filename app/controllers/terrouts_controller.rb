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
    #Create a mutable copy of the params
    terrout_contents=terrout_params
    #Delete params that are passed as a flag
    #A terrout will not save correctly if these params are passed to the terrout itself
    terrout_contents.delete("checkout")
    @terrout = Terrout.new(terrout_contents)
    respond_to do |format|
      if @terrout.save
        #Updates the Territory's history adding a checked out listing
        Terr.all.find(@terrout.terrid).update(history: Terr.all.find(@terrout.terrid).history<<[Time.now, "Checked Out", @terrout.dateout, @terrout.publisher])
        format.html { redirect_to '/'}
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
        format.html { redirect_to @terrout, notice: 'Check Out was successfully updated.' }
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
    #If the checkout flag is passed, we need to redirect to the terrin controller
    #So that the terrin entry can be created, and the territory can be tracked as checked in
    if params[:checkin]
      redirect_to :controller => 'terrins', :action => 'new', :terrid => params[:checkin]
    else
      respond_to do |format|
        format.html { redirect_to terrouts_url, notice: 'Check Out was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_terrout
      @terrout = Terrout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def terrout_params
      params.require(:terrout).permit(:terrid, :publisher, :dateout, :datedue, :checkin, :checkout)
    end
end
