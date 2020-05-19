class AdminController < ApplicationController
    if TerraNovaConfig["enableAdminHTTPAuth"] == "true"
        http_basic_authenticate_with name: TerraNovaConfig["adminHTTPAuth"]["username"], password: TerraNovaConfig["adminHTTPAuth"]["password"]
    end

    def index
        if params[:configUp]
            require 'fileutils'
            FileUtils.move(params[:configUp].path,"tmp/UploadedConfig.json") 
        end
        
        if params[:configDown]
            send_file("config/user/TerraNovaConfig.json")
        end
        
        if params[:configReset]
            require 'fileutils'
            FileUtils.rm("config/user/TerraNovaConfig.json")
        end

        if params[:dbUp]
            require 'fileutils'
            FileUtils.move(params[:dbUp].path,"tmp/UploadedDB.sqlite3") 
        end

        if params[:dbDown]
            if Rails.env.development? 
                send_file("db/development.sqlite3")
            elsif Rails.env.test? 
                send_file("db/test.sqlite3")
            else 
                send_file("db/production.sqlite3")
            end
        end

        if params[:update]
            `touch tmp/update.txt`
        end

        #Keep this last so that server can be restarted after any other admin action
        if params[:restart]
            `touch tmp/restart.txt`
        end
    end

    #Required for HTML Post for file upload
    #  def create
    #      self.index
    #  end

    def admin_params
        params.permit(:restart, :update, :dbUp, :dbDown, :confUp, :confDown)
    end
end
