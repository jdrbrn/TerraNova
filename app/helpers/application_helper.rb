module ApplicationHelper
    # Table Gen Functions

    def runFunctionTH(functionString)
        # TH doesn't pass any paramaters so check if function
        # wants paramaters, if so don't call
        if respond_to?(functionString.to_sym)
            if method(functionString).parameters==[]
                method(functionString).call
            end
        end
    end

    def runFunctionTD(functionString, object)
        if respond_to?(functionString)
            if method(functionString).parameters!=[]
                method(functionString).call(object)
            else
                method(functionString).call
            end
        end
    end

    def generateTH(config)
        # Setup the variables to store the output and body
        # output is a broken tag as html attributes can be added
        # body is seperate so that it can be combined after all generation is done
        output="<th"
        body=""

        # Iterate through each part of the header
        config.elements.each do |attribute|
            # Check if the header is defining the body content
            # Else we set an html attribute with the name of the element
            if attribute.name == "body"
                # Iterate through the body elements
                # Check to see if it's an html element or function
                # html is stored into the body var
                # function is run and stored
                attribute.elements.each do |element|
                    if element.name == "html"
                        body+=element.content
                    elsif element.name == "function"
                        body+=runFunctionTH(element.content)
                    end
                end
            else
                # Add the html attribute to the tag
                # Ex: output = "<th", attribute.name="class" => output="<th class=""
                # This leaves an open quote that is closed at the end of the loop once the attribute
                # has been defined
                output += " #{attribute.name}=\""
                # Iterate through the elements
                # Check to see if it's an html element or function
                # html is stored into the output var
                # function is run and stored
                attribute.elements.each do |element|
                    if element.name == "html"
                        output+=element.content
                    elsif element.name == "function"
                        output+=runFunctionTH(element.content)
                    end
                end
                output += "\""
            end
        end

        # Close the opening tag, insert the body, add closing tag
        output+=">"
        output+=body
        output+="</th>"

        output.html_safe
    end
    
    def generateTD(config, object)
        # Setup the variables to store the output and body
        # output is a broken tag as html attributes can be added
        # body is seperate so that it can be combined after all generation is done
        output="<td"
        body=""

        # Iterate through each part of the header
        config.elements.each do |attribute|
            # Check if the header is defining the body content
            # Else we set an html attribute with the name of the element
            if attribute.name == "body"
                # Iterate through the body elements
                # Check to see if it's an html element or function
                # html is stored into the body var
                # function is run and stored
                attribute.elements.each do |element|
                    if element.name == "html"
                        body+=element.children.to_s
                    elsif element.name == "function"
                        body+=runFunctionTD(element.content, object)
                    end
                end
            else
                # Add the html attribute to the tag
                # Ex: output = "<td", attribute.name="class" => output="<td class=""
                # This leaves an open quote that is closed at the end of the loop once the attribute
                # has been defined
                output += " #{attribute.name}=\""
                # Iterate through the elements
                # Check to see if it's an html element or function
                # html is stored into the output var
                # function is run and stored
                attribute.elements.each do |element|
                    if element.name == "html"
                        output+=element.content
                    elsif element.name == "function"
                        output+=runFunctionTD(element.content, object)
                    end
                end
                output += "\""
            end
        end

        # Close the opening tag, insert the body, add closing tag
        output+=">"
        output+=body
        output+="</td>"

        output.html_safe
    end

    def makeTableHeaders(layoutName, tableName)
        # Create output string
        output=""
        # Get a list of each header in the table and iterate
        table=ConfigHelper.loadTableLayout(layoutName, tableName)
        if table.class.to_s != "String"
            headers = table.xpath(".//header")
            headers.each do |header|
                # Check if the header is an includes and then import the headers it calls for
                # Else generate a TH from the header info
                if header.elements[0].name=="includes"
                    includeLayout = header.elements[0].content.split("/")[0]
                    includeTable = header.elements[0].content.split("/")[1]
                    output += makeTableHeaders(includeLayout, includeTable)
                else
                    output += generateTH(header)
                end
            end
        else
            output = table
        end
        output.html_safe
    end

    def makeTableData(layoutName, tableName, object)
        # Create output string
        output=""
        # Get a list of each cell in the table and iterate
        table=ConfigHelper.loadTableLayout(layoutName, tableName)
        if table.class.to_s != "String"
            cells = table.xpath(".//cell")
            cells.each do |cell|
                # Check if the cell is an includes and then import the cell it calls for
                # Else generate a TD from the header info
                if cell.elements[0].name=="includes"
                    includeLayout = cell.elements[0].content.split("/")[0]
                    includeTable = cell.elements[0].content.split("/")[1]
                    output += makeTableData(includeLayout, includeTable, object)
                else
                    output += generateTD(cell, object)
                end
            end
        else
            output = table
        end
        output.html_safe
    end

    # DNC Table Functions
    # Put here as they need to be accessed throughout the program
    # On DNC pages and on individual territory pages

    def dncDate(dnc)
        if dnc.date == nil
            ""
        else
            dnc.date.strftime("%m/%d/%y")
        end
    end
    
    def dncName(dnc)
        dnc.name
    end

    def dncAddress(dnc)
        output = ""
        output += dncNumber(dnc) 
        output += " "
        output += dncStreet(dnc)
    end

    def dncNumber(dnc)
        dnc.number
    end

    def dncStreet(dnc)
        dnc.street
    end

    def dncPublisher(dnc)
        dnc.publisher
    end

    def dncNotes(dnc)
        dnc.notes
    end
end
