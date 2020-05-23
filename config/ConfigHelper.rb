require 'json'
class ConfigHelper

  @defaultsDir="config/defaults/"
  @configDir="config/user/"
  @configFile="TerraNovaConfig.json"
  @layoutsTable = {}

  def self.loadConfig
    # Loads default config
    # Sets what keys need to exist and default values
    default=JSON.parse(File.read(@defaultsDir+@configFile))
    
    #File name to use for the configFile
    configFileName=@configDir+@configFile

    #Checks to see if config file exists and creates if not
    if File.file?(configFileName)==false
      copyDefault(@configFile)
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

    # Goes through each config key to verify that all needed keys exist and are valid types
    config.each do |key|
      # Check to see if the key should exist
      if default[key[0]]
        # Makes sure it's a valid type
        if default[key[0]].class == key[1].class
          # If hash or array make sure all required values are included
          if default[key[0]].class == Hash
            default[key[0]].each do |hashKey|
              # Check to see if the hashKey exists and loadedConfig contains the type of value it should
              # If not, the value is reset
              if config[key[0]][hashKey[0]] && config[key[0]][hashKey[0]].class != default[key[0]][hashKey[0]].class
                config[key[0]][hashKey[0]]=default[key[0]][hashKey[0]]
              end
            end
          end
        # If key doesn't exist or is malformed
        else
          config[key[0]]=default[key[0]]
        end
      # If the key isn't a default key
      else
        # Assume imported data and create new file with key name as name/location and key contents
        # Overwrites existing file
        File.write(@configDir+key[0], key[1], mode: "w+")
        # Remove the extraneous key
        config.delete(key[0])
      end
    end


    #Deletes the existing config and then saves the loaded config
    #This makes sure to easily add any keys that were missing or changed
    configFile=File.new(configFileName,"w")
    configFile.puts(JSON.pretty_generate(config))
    configFile.close

    # Reset layoutsTable
    @layoutsTable={}

    #Set constant config
    puts "Retreived Configuration #{configFileName}: #{config}"
    config
  end

  def self.loadLayouts
    TerraNovaConfig.keys.each do |key|
      if key.include?("Layout")
        self.loadLayout(TerraNovaConfig[key])
      end
    end
  end

  def self.loadLayout(layoutName)
    layoutFile = layoutName+".xml"
    # Check for file, copy from defaults if exists there
    if File.file?(@configDir+"layouts/"+layoutFile)
      # Return XML of layout
      Nokogiri::XML.fragment(File.read(@configDir+"layouts/"+layoutFile))
    elsif File.file?(@defaultsDir+"layouts/"+layoutFile)
      copyDefault("layouts/"+layoutFile)
      loadLayout(layoutName)
    else
      "Error: No layout #{layoutName} found"
    end
  end

  def self.loadTableLayout(layoutName, tableName)
    layoutFile = layoutName+".xml"
    # Check for file, copy from defaults if exists there
    if File.file?(@configDir+"layouts/"+layoutFile)
      # Get XML of layout
      layout=Nokogiri::XML.fragment(File.read(@configDir+"layouts/"+layoutFile))
      # Get the table
      table = layout.xpath("./"+tableName)
      # Check if table actually exists
      if table.to_s == ""
        "Error: No table #{tableName} in layout #{layoutName}"
      else
        table
      end
    elsif File.file?(@defaultsDir+"layouts/"+layoutFile)
      copyDefault("layouts/"+layoutFile)
      loadTableLayout(layoutName, tableName)
    else
      "Error: No layout #{layoutName} found"
    end
  end

  def self.copyDefault(fileName)
    File.write(@configDir+fileName, File.read(@defaultsDir+fileName))
  end
end