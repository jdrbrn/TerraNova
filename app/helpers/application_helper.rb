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

    def runFunctionTD(functionString, territory)
        if respond_to?(functionString)
            if method(functionString).parameters!=[]
                method(functionString).call(territory)
            else
                method(functionString).call
            end
        end
    end

    def generateTH(config)
        output="<th"
        body=""

        config.each do |layout|
            if layout[0]=="body"
                layout[1].each do |entry|
                    if entry["html"]
                        body+=entry["html"]
                    elsif entry["function"]
                        body+=runFunctionTH(entry["function"])
                    end
                end
            else
                output+=" #{layout[0]}=\""
                layout[1].each do |entry|
                    if entry["html"]
                        output+=entry["html"]
                    elsif entry["function"]
                        output+=runFunctionTH(entry["function"])
                    end
                end
                output+="\""
            end
        end
        output+=">"

        output+=body
        output+="</th>"

        output.html_safe
    end
    
    def generateTD(config, territory)
        output="<td"
        body=""
        config.each do |layout|
            if layout[0]=="body"
                layout[1].each do |entry|
                    if entry["html"]
                        body+=entry["html"]
                    elsif entry["function"]
                        body+=runFunctionTD(entry["function"], territory)
                    end
                end
            else
                output+=" #{layout[0]}=\""
                layout[1].each do |entry|
                    if entry["html"]
                        output+=entry["html"]
                    elsif entry["function"]
                        output+=runFunctionTD(entry["function"], territory)
                    end
                end
                output+="\""
            end
        end
        output+=">"

        output+=body
        output+="</td>"

        output.html_safe
    end

    def makeTableHeaders(container, table)
        output=""
        if TerraNovaConfig[container][table]["extends"]
            refContainer = TerraNovaConfig[container][table]["extends"]["container"]
            refTable = TerraNovaConfig[container][table]["extends"]["table"]
            output += makeTableHeaders(refContainer, refTable)
        end
        TerraNovaConfig[container][table]["headers"].each do |header|
            if header["includes"]
                refContainer = header["includes"]["container"]
                refTable = header["includes"]["table"]
                output += makeTableHeaders(refContainer, refTable)
            else
                output+=generateTH(header)
            end
        end
        output.html_safe
    end

    def makeTableData(container, table, object)
        output=""
        TerraNovaConfig[container][table]["cells"].each do |cell|
            if cell["includes"]
                refContainer = cell["includes"]["container"]
                refTable = cell["includes"]["table"]
                output += makeTableData(refContainer, refTable, object)
            else
                output+=generateTD(cell, object)
            end
        end
        output.html_safe
    end
end
