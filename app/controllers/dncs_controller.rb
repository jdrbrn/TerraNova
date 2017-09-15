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
    dnc_contents=dnc_params
    dnc_contents.delete("terrtype")
    dnc_contents.delete("redirid")
    @dnc = Dnc.new(dnc_contents)

    respond_to do |format|
      if @dnc.save
        format.html { redirect_to "/#{dnc_params["terrtype"]}/#{dnc_params["redirid"]}", notice: 'Dnc was successfully created.' }
        format.json { render :show, status: :created, location: @dnc }
      else
        format.html { render :new }
        format.json { render json: @dnc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dncs/1
  # PATCH/PUT /dncs/1.json
  def update
    respond_to do |format|
      if @dnc.update(dnc_params)
        format.html { redirect_to @dnc, notice: 'Dnc was successfully updated.' }
        format.json { render :show, status: :ok, location: @dnc }
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
      format.html { redirect_to dncs_url, notice: 'Dnc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print
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
