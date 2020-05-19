class ReportController < ApplicationController
  #Enables basic httpAuth for all pages
  if TerraNovaConfig["enableHTTPAuth"] == "true"
    http_basic_authenticate_with name: TerraNovaConfig["HTTPAuth"]["username"], password: TerraNovaConfig["HTTPAuth"]["password"]
  end

  #Setup for letting the report pages easily reference needed entries
  def index
    # If in development reload TerraNovaConfig when loading report/index
    if Rails.env.development?
      puts "Reloading TerraNovaConfig.rb"
      load "#{Dir.pwd}/config/ConfigHelper.rb"
      Object.const_set("TerraNovaConfig", ConfigHelper.loadConfig)
      Object.const_set("TerraNovaLayouts", ConfigHelper.loadLayouts)
      puts "Set TerraNovaConfig to #{TerraNovaConfig}"
    end
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
