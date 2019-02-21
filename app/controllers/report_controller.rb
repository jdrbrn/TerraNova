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
      load "#{Dir.pwd}/config/TerraNovaConfig.rb"
      Object.const_set("TerraNovaConfig", loadConfig)
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
  def download
     require 'fileutils'
    if params[:db]
      if Rails.env.development? 
        FileUtils.copy("db/development.sqlite3", "public/development.sqlite3") 
      elsif Rails.env.test? 
        FileUtils.copy("db/test.sqlite3", "public/test.sqlite3") 
      else 
        FileUtils.copy("db/production.sqlite3", "public/production.sqlite3") 
      end
    end
  end
  def admin
  end

  def report_params
    params.permit(:db)
  end
end
