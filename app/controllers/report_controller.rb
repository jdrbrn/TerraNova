class ReportController < ApplicationController
  #Enables basic httpAuth for all pages
  if TerraNovaConfig["enableHTTPAuth"] == "true"
    http_basic_authenticate_with name: TerraNovaConfig["HTTPAuth"]["username"], password: TerraNovaConfig["HTTPAuth"]["password"]
  end

  #Setup for letting the report pages easily reference needed entries
  def index
    @terrins=Terrin.all
    @terrouts=Terrout.all
    @terrs=Terr.all
    render layout: "layouts/reportIndex"
  end
  
  def print
    @terrins=Terrin.all
    @terrouts=Terrout.all
    @terrs=Terr.all
    render layout: "layouts/reportPrint"
  end

  def history
    @terrs=Terr.all
  end

  def admin
  end

  def report_params
    params.permit(:db)
  end
end
