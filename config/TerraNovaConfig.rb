require 'json'

def loadConfig
  #Sets what keys should be found for prefs and default values
  config={"TerraNovaVersion"=>"2.2.0",
          "timezone"=>"Eastern Time (US & Canada)",
          "name"=>"EDIT CONFIG FILE TO FINISH SETUP",
          "enableMultiserver"=>"false",
          "multiserverList"=>[["Mutli1","IP1"],["Multi2","IP2"],["Multi3","IP3"]],
          "enableHTTPAuth"=>"false",
          "HTTPAuth"=>{"username"=>"user","password"=>"secret"},
          "adminEnableHTTPAuth"=>"true",
          "adminHTTPAuth"=>{"username"=>"admin","passowrd"=>"supersecret"},
          "systemCSS"=>{"bodyBG"=>"#ecfbff",
            "terrWarn"=>"yellow",
            "terrLate"=>"#ff4a2b",
            "toolbarBG"=>"#e5eeff",
            "thBG"=>"#e5efff",
            "tdBG"=>"#efefff"},
          "dncCSS"=>{"dncCardWidth"=>"5in",
            "specialDNC" => "blue"}
          }

  #File name to use for the configFile
  configFileName="TerraNovaConfig.json"
  # If in development mode load a dev config file and save a default config with the latest defaults
  if Rails.env.development?
    configFile=File.new(configFileName,"w")
    configFile.puts(JSON.pretty_generate(config))
    configFile.close
    configFileName="Dev#{configFileName}"
  end
  #Checks to see if config file exists and creates if not
  if File.file?(configFileName)==false
    File.new(configFileName,"a+").close
  end
  #Loads the JSON File
  #Error handling for if there is an issue with the JSON data(ex: doesn't exist)
  #Which resets to a blank/default config
  begin
    loadedConfig=JSON.parse(File.read(configFileName))
  rescue JSON::ParserError
    loadedConfig={}
  end
  #Checks for the version of TerraNova used to save the config file
  #This is then removed so that the current version can be written out
  #This block could also contain migration logic based on version if needed(Ex: If a key is renamed)
  if loadedConfig["TerraNovaVersion"]
    loadedConfig.delete("TerraNovaVersion")
  end
  #For each config value read from the file it loads the value into our config var
  #This way if there is supposed to be a config value but isn't, the default is used
  #Removes arbitary data stored in config.json that isn't called for
  loadedConfig.each do |key|
    # Check to see if the key should exist and loadedConfig contains the type of value it should
    if config[key[0]] && config[key[0]].class == loadedConfig[key[0]].class
      # If hash or array merge the two so new keys get added to the config file
      if config[key[0]].class == Hash
        loadedConfig[key[0]].each do |hashKey|
          # Check to see if the hashKey should exist and loadedConfig contains the type of value it should
          if config[key[0]][hashKey[0]] && config[key[0]][hashKey[0]].class == loadedConfig[key[0]][hashKey[0]].class
            config[key[0]][hashKey[0]]=loadedConfig[key[0]][hashKey[0]]
          end
        end
      else
        config[key[0]]=loadedConfig[key[0]]
      end
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
