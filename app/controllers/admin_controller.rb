class AdminController < ApplicationController
    if TerraNovaConfig["enableAdminHTTPAuth"] == "true"
        http_basic_authenticate_with name: TerraNovaConfig["adminHTTPAuth"]["username"], password: TerraNovaConfig["adminHTTPAuth"]["password"]
    end

    def index
        if params[:usrconf]
            require 'fileutils'
            #Create mutable hash of the submitted config
            newConfig=params[:usrconf].to_unsafe_hash

            # config is converted to JSON for editing then passed as a param
            # this changes the json back to an object so it can be saved properly at
            # the end
            newConfig["multiserverList"] = JSON.parse(newConfig["multiserverList"])
            newConfig["reportPrintLayout"] = JSON.parse(newConfig["reportPrintLayout"])

            #Saves new config to a temp file
            #This file will be moved + loaded on next restart via config/application.rb
            #Invalid keys/values will silently fail and be replaced w/ default values at that time
            configFile=File.new("tmp/UploadedConfig.json","w")
            configFile.puts(JSON.pretty_generate(newConfig))
            configFile.close
        end

        if params[:configUp]
            require 'fileutils'
            FileUtils.move(params[:configUp].path,"tmp/UploadedConfig.json") 
        end
        
        if params[:configDown]
            if Rails.env.development? 
                send_file("DevTerraNovaConfig.json")
            else 
                send_file("TerraNovaConfig.json")
            end
        end
        
        if params[:configReset]
            require 'fileutils'
            if Rails.env.development? 
                FileUtils.rm("DevTerraNovaConfig.json")
            else 
                FileUtils.rm("TerraNovaConfig.json")
            end
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
        params.permit(:restart, :update, :usrconf, :dbUp, :dbDown, :confUp, :confDown)
    end
end
