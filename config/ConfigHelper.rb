require 'json'
module ConfigHelper
  def ConfigHelper.loadConfig
    # Loads default config
    # Sets what keys need to exist and default values
    default=JSON.parse(File.read("config/defaults/default.json"))
    
    #File name to use for the configFile
    configFileName="TerraNovaConfig.json"

    #Checks to see if config file exists and creates if not
    if File.file?(configFileName)==false
      File.new(configFileName,"a+").close
    end

    #Loads the JSON File
    #Error handling for if there is an issue with the JSON data(ex: doesn't exist)
    #Which resets to a blank/default config
    begin
      config=JSON.parse(File.read(configFileName))
    rescue JSON::ParserError
      config={}
    end

    # Checks for the version of TerraNova used to last save the config file
    # Version number is then updated to be the current version number
    # This block could also contain migration logic based on version if needed(Ex: If a key is renamed)
    if config["TerraNovaVersion"]
      config["TerraNovaVersion"]=default["TerraNovaVersion"]
    end

    # Goes through each default key to verify that all needed keys exist and are valid types
    default.each do |key|
      # Check to see if the key exists and is a valid type
      if config[key[0]] && config[key[0]].class == default[key[0]].class
        # If hash or array make sure all required values are included
        if default[key[0]].class == Hash
          default[key[0]].each do |hashKey|
            # Check to see if the hashKey should exist and loadedConfig contains the type of value it should
            # If not, the value is reset
            if config[key[0]][hashKey[0]] && config[key[0]][hashKey[0]].class != default[key[0]][hashKey[0]].class
              config[key[0]][hashKey[0]]=default[key[0]][hashKey[0]]
            end
          end
        end
      # If key doesn't exist copy it into user config
      else
        config[key[0]]=default[key[0]]
      end
    end


    #Deletes the existing config and then saves the loaded config
    #This makes sure to easily add any keys that were missing or changed
    configFile=File.new(configFileName,"w")
    configFile.puts(JSON.pretty_generate(config))
    configFile.close

    #Set constant config
    puts "Retreived Configuration #{configFileName}: #{config}"
    config
  end
end