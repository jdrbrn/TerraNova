require 'json'

#Sets what keys should be found for prefs and default values
config={"multi"=>"false",
        "congs"=>["Name","Name2"],
        "color"=>"Blue"}
#Checks to see if config file exists and creates if not
if File.file?("config.json")==false
  File.new("config.json","a+").close
end
#Loads the JSON File
#Error handling for if there is an issue with the JSON data(ex: doesn't exist)
#Which resets to a blank/default config
begin
  loadedConfig=JSON.parse(File.read("config.json"))
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
configFile=File.new("config.json","w")
configFile.puts(config.to_json)
configFile.close

#Set constant config
TerraNovaConfig=config.freeze
