class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # To enable username/password authentication uncomment the bellow and set the username and password
  # http_basic_authenticate_with name: "", password: "password"
end
