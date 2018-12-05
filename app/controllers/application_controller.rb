class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #Enables basic httpAuth for all pages
  if TerraNovaConfig["enableHTTPAuth"] == "true"
    http_basic_authenticate_with name: TerraNovaConfig["HTTPAuth"]["username"], password: TerraNovaConfig["HTTPAuth"]["password"]
  end
end
