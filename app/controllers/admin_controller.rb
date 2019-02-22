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
            #Section to update the config file
            #File name to use for the configFile
            configFileName="TerraNovaConfig.json"
            # If in development mode load change to dev file name
            if Rails.env.development?
                configFileName="Dev#{configFileName}"
            end
            #Creates mutable TerraNovaConfig
            config=TerraNovaConfig
            #For each config value provided by the user it loads the value into current config
            #This way if there is supposed to be a config value but isn't, the current is used
            puts "newConfig(#{newConfig.class}):#{newConfig}"
            newConfig.each do |key|
                # Check to see if the key should exist and newConfig contains the type of value it should
                if config[key] && config[key].class == newConfig[key].class
                    # If hash or array merge the two so new keys get added to the config file
                    if config[key].class == Hash
                        newConfig[key].each do |hashKey|
                            # Check to see if the hashKey should exist and newConfig contains the type of value it should
                            if config[key][hashkey] && config[key][hashkey].class == newConfig[key][hashkey].class
                                config[key][hashkey]=newConfig[key][hashkey]
                            end
                        end
                    else
                        config[key]=newConfig[key]
                    end
                end
            end
            #Saves to a temp file
            #This makes sure to easily add any keys that were missing or changed
            configFile=File.new(configFileName,"w")
            configFile.puts(JSON.pretty_generate(config))
            configFile.close
            #Moves temp config to proper location
            #FileUtils.move("tmp.json",configFileName)
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
