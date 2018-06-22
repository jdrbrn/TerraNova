class ReportController < ApplicationController
  #Setup for letting the report pages easily reference needed entries
  def index
    @terrins=Terrin.all
    @terrouts=Terrout.all
    @terrs=Terr.all
  end
  def print
    @terrins=Terrin.all
    @terrouts=Terrout.all
    @terrs=Terr.all
  end
  def history
    @terrs=Terr.all
  end
end
