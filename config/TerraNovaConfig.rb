require 'json'

def loadConfig
  #Sets what keys should be found for prefs and default values
  config={"name"=>"EDIT CONFIG FILE TO FINISH SETUP",
          "enableMultiserver"=>"false",
          "multiserverList"=>[["Mutli1","IP1"],["Multi2","IP2"],["Multi3","IP3"]],
          "enableHTTPAuth"=>"false",
          "HTTPAuth"=>["username","password"],
          "bodyBG"=>"#ecfbff",
          "terrWarn"=>"yellow",
          "terrLate"=>"#ff4a2b",
          "dncCardWidth"=>"6.75in"}

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
    loadedConfig=JSON.parse(File.read(configFileName))
  rescue JSON::ParserError
    loadedConfig={}
  end
  #For each config value read from the file it loads the value into our config var
  #This way if there is supposed to be a config value but isn't, the default is used
  #Removes arbitary data stored in config.json that isn't called for
  #This block could also contain migration logic if needed(Ex: If a key is renamed)
  loadedConfig.each do |key|
    if config[key[0]]
      config[key[0]]=loadedConfig[key[0]]
    end
  end
  #Deletes the existing config and then saves the loaded config
  #This makes sure to easily add any keys that were missing or changed
  configFile=File.new(configFileName,"w")
  configFile.puts(JSON.pretty_generate(config))
  configFile.close

  #Set constant config
  puts "Retreived Configuration: #{config}"
  config
end
