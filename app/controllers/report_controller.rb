class ReportController < ApplicationController
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
end
