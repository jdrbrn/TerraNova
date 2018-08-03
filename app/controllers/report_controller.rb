class ReportController < ApplicationController
  #Setup for letting the report pages easily reference needed entries
  def index
    # If in development reload TerraNovaConfig when loading report/index
    if Rails.env.development?
      Object.const_set("TerraNovaConfig", loadConfig)
    end
    puts "Set TerraNovaConfig to #{TerraNovaConfig}"
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
