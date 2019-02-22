class AdminController < ApplicationController
    if TerraNovaConfig["enableAdminHTTPAuth"] == "true"
        http_basic_authenticate_with name: TerraNovaConfig["adminHTTPAuth"]["username"], password: TerraNovaConfig["adminHTTPAuth"]["password"]
    end

    def index
        if params[:usrconf]
            require 'fileutils'
            #Create mutable copy of the submitted config
            newConfig=params[:usrconf]
            #This section converts the submitted string of multiserverList into the wanted array
            #Gets rid of the [[ and ]] at each end of the string
            newConfig["multiserverList"][0..1]=""
            newConfig["multiserverList"][-2..-1]=""
            #Splits the internal arrays into seperate entries
            newConfig["multiserverList"]=newConfig["multiserverList"].split("], [")
            #Fixes each internal array string into an array
            i=0
            while i < newConfig["multiserverList"].length
                #This uses the same process as above but applied to the internal arrays
                newConfig["multiserverList"][i][0]=""
                newConfig["multiserverList"][i][-1]=""
                newConfig["multiserverList"][i]=newConfig["multiserverList"][i].split("\", \"")
                i+=1
            end
            #Saves new config to a temp file
            #This file will be moved + loaded on next restart via config/application.rb
            #Invalid keys/values will silently fail and be replaced w/ default values at that time
            configFile=File.new("tmp/UploadedConfig.json","w")
            configFile.puts(JSON.pretty_generate(config))
            configFile.close
        end

        #Keep this last so that server can be restarted after any other admin action
        if params[:restart]
            `touch tmp/restart.txt`
        end
    end

    def admin_params
        params.permit(:restart, :usrconf, :dbUp)
    end
end
