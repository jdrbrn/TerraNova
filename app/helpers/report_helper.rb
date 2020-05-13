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

        output
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

    def viewdetails(territory)
        terrtype = territory.class.to_s.downcase
        output = "<a href=\"#\" onclick=\""
        output += terrtype
        output += "sViewDetails('#{territory.id}');return false;\">View Details</a>"
    end

    # Terrout Functions
    def publisherTerrout(terrout)
        output = ""
        output += terrout.publisher
    end

    def dateoutTerrout(terrout)
        output = ""
        output += terrout.dateout.strftime("%m/%d/%y")
    end
    
    def datedueTerrout(terrout)
        output = ""
        output += terrout.datedue.strftime("%m/%d/%y")
    end

    def checkinTerrout(terrout)
        link_to 'Check In', [terrout,checkin: terrout.terrid], method: :delete, data: { confirm: "Are you sure you want to check in #{@terrs.find(terrout.terrid).name}?" }
    end

    # Terrin Functions
    def checkoutTerrin(terrin)
        link_to 'Check Out', [terrin,checkout: terrin.terrid], method: :delete, data: { confirm: "Are you sure you want to check out #{@terrs.find(terrin.terrid).name}?" }
    end

    # Terr Functions
    def checkoutTerr(terr)
        link_to 'Check Out', {:controller => "terrouts", :action => "new", :terrid => terr.id}
    end

    def checkinTerr(terr)
        link_to 'Check In', {:controller => "terrins", :action => "new", :terrid => terr.id}
    end
end
