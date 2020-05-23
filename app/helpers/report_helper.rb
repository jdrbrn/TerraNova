module ReportHelper
    # Territory Functions
    def territoryGetID(territory)
        if territory.class != Terr
            territory.terrid
        else
            territory.id
        end
    end

    def territoryDeadlineCSS(territory)
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

    def territoryFullname(territory)
        output = ""
        output += territoryName(territory) + "<br>" + territoryRegion(territory)
    end

    def territoryDatecomp(territory)
        terrid = territoryGetID(territory)

        output = ""
        output += @terrs.find(terrid).datecomp.strftime("%m/%d/%y")
    end

    def territoryName(territory)
        terrid = territoryGetID(territory)

        output = ""
        output += @terrs.find(terrid).name
    end
    
    def territoryRegion(territory)
        terrid = territoryGetID(territory)

        output = ""
        output += @terrs.find(terrid).region
    end

    def territoryViewdetails(territory)
        terrtype = territory.class.to_s.downcase
        output = "<a href=\"#\" onclick=\""
        output += terrtype
        output += "sViewDetails('#{territory.id}');return false;\">View Details</a>"
    end

    def territoryCheckin(territory)
        if territory.class.to_s == "Terrout"
            link_to 'Check In', [territory,checkin: territory.terrid], method: :delete, data: { confirm: "Are you sure you want to check in #{@terrs.find(territory.terrid).name}?" }
        elsif territory.class.to_s == "Terr"
            link_to 'Check In', {:controller => "terrins", :action => "new", :terrid => territory.id}
        else
            ""
        end
    end

    def territoryCheckout(territory)
        if territory.class.to_s == "Terrin"
            link_to 'Check Out', [territory,checkout: territory.terrid], method: :delete, data: { confirm: "Are you sure you want to check out #{@terrs.find(territory.terrid).name}?" }
        elsif territory.class.to_s == "Terr"
            link_to 'Check Out', {:controller => "terrouts", :action => "new", :terrid => territory.id}
        else
            ""
        end
    end

    # Terrout Functions
    def terroutPublisher(terrout)
        output = ""
        output += terrout.publisher
    end

    def terroutDateout(terrout)
        output = ""
        output += terrout.dateout.strftime("%m/%d/%y")
    end
    
    def terroutDatedue(terrout)
        output = ""
        output += terrout.datedue.strftime("%m/%d/%y")
    end
end
