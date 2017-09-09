class ReportController < ApplicationController
  def index
    @terrins=Terrin.all
    @terrouts=Terrout.all
    @terrs=Terr.all
  end
end
