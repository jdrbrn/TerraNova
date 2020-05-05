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

        output = "<td class=\""+deadlineCSS(territory)+"\">"
        output += @terrs.find(terrid).name + "<br>" + @terrs.find(terrid).region
        output += "</td>"
        output.html_safe
    end

    def datecomp(territory)
        terrid = getID(territory)

        output = "<td>"
        output += @terrs.find(terrid).datecomp.strftime("%m/%d/%y")
        output += "</td>"
        output.html_safe
    end

    # Terrout Functions
    def publisher(terrout)
        output = "<td>"
        output += terrout.publisher
        output += "</td>"
        output.html_safe
    end

    def dateout(terrout)
        output = "<td>"
        output += terrout.dateout.strftime("%m/%d/%y")
        output += "</td>"
        output.html_safe
    end
    
    def datedue(terrout)
        output = "<td>"
        output += terrout.datedue.strftime("%m/%d/%y")
        output += "</td>"
        output.html_safe
    end
end
