class AdminController < ApplicationController
    if TerraNovaConfig["enableHTTPAuth"] == "true"
        http_basic_authenticate_with name: "admin", password: "test"
    end
end
