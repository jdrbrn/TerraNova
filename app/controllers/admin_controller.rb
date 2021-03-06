class AdminController < ApplicationController
    if TerraNovaConfig["enableAdminHTTPAuth"] == "true"
        http_basic_authenticate_with name: TerraNovaConfig["adminHTTPAuth"]["username"], password: TerraNovaConfig["adminHTTPAuth"]["password"]
    end

    def index
        if params[:configUp]
            require 'fileutils'
            FileUtils.move(params[:configUp].path,"config/user/TerraNovaConfig.json")
        end
        
        if params[:configDown]
            tempConfig = TerraNovaConfig.dup
            layouts=[]
            Dir.children("config/user/layouts").each do |file|
                if file.include?(".xml")
                    layouts << file.sub(".xml", "")
                end
            end
            layouts.each do |key|
                tempConfig[key] = File.read("config/user/layouts/"+key+".xml")
            end
            tempFile=File.new("tmp/TerraNovaConfig.json","w")
            tempFile.puts(JSON.pretty_generate(tempConfig))
            tempFile.close
            send_file("tmp/TerraNovaConfig.json")
        end
        
        if params[:configReset]
            require 'fileutils'
            FileUtils.rm("config/user/TerraNovaConfig.json")
            Dir.children("config/user/layouts").each do |file|
                if file.include?(".xml")
                    FileUtils.rm("config/user/layouts/"+file)
                end
            end
        end

        if params[:dbUp]
            require 'fileutils'
            if Rails.env.development? 
                if File.file?("db/development.sqlite3")
                  FileUtils.rm("db/development.sqlite3")
                end
                FileUtils.move(params[:dbUp].path, "db/development.sqlite3") 
            elsif Rails.env.test? 
                if File.file?("db/test.sqlite3")
                  FileUtils.rm("db/test.sqlite3")
                end
                FileUtils.move(params[:dbUp].path, "db/test.sqlite3") 
              else 
                if File.file?("db/production.sqlite3")
                  FileUtils.rm("db/production.sqlite3")
                end
                FileUtils.move(params[:dbUp].path, "db/production.sqlite3")  
              end
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

        puts "Reloading TerraNovaConfig.rb"
        Object.const_set("TerraNovaConfig", ConfigHelper.loadConfig)
        ConfigHelper.loadLayouts
        puts "Set TerraNovaConfig to #{TerraNovaConfig}"
    end

    #Required for HTML Post for file upload
    #  def create
    #      self.index
    #  end

    def admin_params
        params.permit(:restart, :update, :dbUp, :dbDown, :confUp, :confDown)
    end
end
