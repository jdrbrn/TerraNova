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
        # Check if file already exists and delete if so
        if File.file?(@configDir+key[0])
          File.rm(@configDir+key[0])
        end
        File.write(@configDir+key[0], key[1])
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

  def self.readLayout(layoutName)
    layoutFile = layoutName+".xml"
    # Check for file, copy from defaults if exists there
    if File.file?(@configDir+"layouts/"+layoutFile)
      # Load layout file so we can read the XML
      layoutXML=Nokogiri::XML.fragment(File.read(@configDir+"layouts/"+layoutFile))
      # Get the table entries and add record their existance
      @layoutsTable[layoutName]=[]
      layoutXML.xpath("./*").each do |table|
        @layoutsTable[layoutName]<<table.name
      end
      # Check for includes and import those tables as well
      layoutXML.xpath(".//includes").each do |include|
        if !includeCheck(include.content.split("/")[0], include.content.split("/")[1])
          puts "Error: Failed to include #{include.content} from #{layoutName}"
        end
      end
      @layoutsTable
    elsif File.file?(@defaultsDir+"layouts/"+layoutFile)
      copyDefault("layouts/"+layoutFile)
      readLayout(layoutName)
    else
      puts "Error: No layout #{layoutName} found"
      false
    end
  end

  def self.includeCheck(layout, table)
    if @layoutsTable[layout]
      @layoutsTable[layout].include?(table)
    else
      self.readLayout(layout)
      includeCheck(layout, table)
    end
  end

  def self.loadLayouts
    output={}
    @layoutsTable.keys.each do |layout|
      output[layout]=Nokogiri::XML.fragment(File.read(@configDir+"layouts/"+layout+".xml"))
    end
    output
  end

  def self.copyDefault(fileName)
    File.write(@configDir+fileName, File.read(@defaultsDir+fileName))
  end
end