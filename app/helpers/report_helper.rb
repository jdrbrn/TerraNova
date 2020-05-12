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
    end

    def fullname(territory)
        output = ""
        output += name(territory) + "<br>" + region(territory)
    end

    def datecomp(territory)
        terrid = getID(territory)

        output = ""
        output += @terrs.find(terrid).datecomp.strftime("%m/%d/%y")
    end

    def name(territory)
        terrid = getID(territory)

        output = ""
        output += @terrs.find(terrid).name
    end
    
    def region(territory)
        terrid = getID(territory)

        output = ""
        output += @terrs.find(terrid).region
    end

    # Terrout Functions
    def publisher(terrout)
        output = ""
        output += terrout.publisher
    end

    def dateout(terrout)
        output = ""
        output += terrout.dateout.strftime("%m/%d/%y")
    end
    
    def datedue(terrout)
        output = ""
        output += terrout.datedue.strftime("%m/%d/%y")
    end
end
