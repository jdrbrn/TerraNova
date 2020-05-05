module ReportHelper
    # Territory Functions
    def deadlineCSS(territory)
        output = nil

        if territory.class != Terr
            terrid = territory.terrid
        else
            terrid = territory.id
        end

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
        output = "<td class=\""+tdclass+"\">"
        output += @terrs.find(terrid).name + "<br>" + @terrs.find(terrid).region
        output += "</td>"
        output.html_safe
    end

    def datecomp(territory)
        if territory.class != Terr
            terrid = territory.terrid
        else
            terrid = territory.id
        end

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
