module ReportHelper
    # Territory Functions
    def getID(territory)
        if territory.class != Terr
            territory.terrid
        else
            territory.id
        end
    end

    def deadlineCSS(territory)
        output = nil
        terrid = getID(territory)

        if territory.class == Terrout
            if territory.datedue-Date.current<0
                output = "late"
            elsif (territory.datedue-1.months)-Date.current<0
                output = "warn"
            end
        end
        if (output==nil)
            output = "normal"
        end

        output.html_safe
    end

    def fullname(territory)
        terrid = getID(territory)

        output = ""
        output += @terrs.find(terrid).name + "<br>" + @terrs.find(terrid).region
        output.html_safe
    end

    def datecomp(territory)
        terrid = getID(territory)

        output = ""
        output += @terrs.find(terrid).datecomp.strftime("%m/%d/%y")
        output.html_safe
    end

    # Terrout Functions
    def publisher(terrout)
        output = ""
        output += terrout.publisher
        output.html_safe
    end

    def dateout(terrout)
        output = ""
        output += terrout.dateout.strftime("%m/%d/%y")
        output.html_safe
    end
    
    def datedue(terrout)
        output = ""
        output += terrout.datedue.strftime("%m/%d/%y")
        output.html_safe
    end

    # Table Gen Functions
    def testing
        return "TESTING"
    end

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

        if config["class"]
            output+=" class=\""
            if config["class"]["html"]
                output+=config["class"]["html"]
            elsif config["class"]["function"]
                output+=runFunctionTH(config["class"]["function"])
            end
            output+="\""
        end
        output+=">"

        if config["html"]
            output+=config["html"]
        elsif config["function"]
            output+=runFunctionTH(config["function"])
        end

        output+="</th>"

        output.html_safe
    end
    
    def generateTD(config, territory)
        output="<td"

        if config["class"]
            output+=" class=\""
            if config["class"]["html"]
                output+=config["class"]["html"]
            elsif config["class"]["function"]
                output+=runFunctionTD(config["class"]["function"], territory)
            end
            output+="\""
        end
        output+=">"

        if config["html"]
            output+=config["html"]
        elsif config["function"]
            output+=runFunctionTD(config["function"], territory)
        end

        output+="</td>"

        output.html_safe
    end
end
