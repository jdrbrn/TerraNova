class DncsController < ApplicationController
  before_action :set_dnc, only: [:show, :edit, :update, :destroy]

  # GET /dncs
  # GET /dncs.json
  def index
    @dncs = Dnc.all.sort_by { |dnc| [Terr.find(dnc.terrid).region, dnc.street, dnc.number] }
  end

  # GET /dncs/1
  # GET /dncs/1.json
  def show
  end

  # GET /dncs/new
  def new
    @dnc = Dnc.new
  end

  # GET /dncs/1/edit
  def edit
  end

  # POST /dncs
  # POST /dncs.json
  def create
    #Create a mutable copy of the params
    dnc_contents=dnc_params
    #Delete params that are only passed as flags
    #A DNC will not save correctly if these params are passed to the DNC itself
    dnc_contents.delete("terrtype")
    dnc_contents.delete("redirid")
    @dnc = Dnc.new(dnc_contents)

    respond_to do |format|
      if @dnc.save
        if dnc_params["terrtype"]
          #Terrtype is passed when creating from a territory listing
          #This section is to redirect back to that listing instead of to the DNC
          format.html { redirect_to "/#{dnc_params["terrtype"]}/#{dnc_params["redirid"]}", notice: 'DNC was successfully created.' }
          format.json { render :show, status: :ok, location: @dnc }
        else
          format.html { redirect_to @dnc, notice: 'DNC was successfully created.' }
          format.json { render :show, status: :ok, location: @dnc }
        end
      else
        format.html { render :new }
        format.json { render json: @dnc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dncs/1
  # PATCH/PUT /dncs/1.json
  def update
    dnc_contents=dnc_params
    #Delete params that are only passed as flags
    #A DNC will not save correctly if these params are passed to the DNC itself
    dnc_contents.delete("terrtype")
    dnc_contents.delete("redirid")

    respond_to do |format|
      if @dnc.update(dnc_contents)
        if dnc_params["terrtype"]
          #Terrtype is passed when creating from a territory listing
          #This section is to redirect back to that listing instead of to the DNC
          format.html { redirect_to "/#{dnc_params["terrtype"]}/#{dnc_params["redirid"]}", notice: 'DNC was successfully updated.' }
          format.json { render :show, status: :ok, location: @dnc }
        else
          format.html { redirect_to @dnc, notice: 'DNC was successfully updated.' }
          format.json { render :show, status: :ok, location: @dnc }
        end
      else
        format.html { render :edit }
        format.json { render json: @dnc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dncs/1
  # DELETE /dncs/1.json
  def destroy
    @dnc.destroy
    respond_to do |format|
      if params["terrtype"]
        #Terrtype is passed when creating from a territory listing
        #This section is to redirect back to that listing instead of to the DNC
        #There's no need to seperate the params as they are never passed to the DNC
        format.html { redirect_to "/#{params["terrtype"]}/#{params["redirid"]}", notice: 'Dnc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to dncs_url, notice: 'Dnc was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def print
    render layout: "layouts/dncsPrint"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dnc
      @dnc = Dnc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dnc_params
      params.require(:dnc).permit(:terrid, :number, :street, :name, :publisher, :date, :notes, :terrtype, :redirid)
    end
end
