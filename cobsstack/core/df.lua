
function makeDFTable(Location)
    if fs.isDir(Location) then
        spc = (fs.getCapacity(Location) / 100) / 10
        spd = (fs.getFreeSpace(Location) / 100) / 10
        dsunits = "KB"
        capunits = "KB"
        if 9999 < spc then
            spc = spc / 1000
            capunits = "MB"

            if 9999 < spc then
                spc = spc / 1000
                capunits = "GB"
                if 9999 < spc then
                    spc = spc / 1000
                    capunits = "TB"
                else
                end
            else
            end


        else
        end
        if 9999 < spd then
            spd = spd / 1000
            dsunits = "MB"
            if 9999 < spd then
                spd = spd / 1000
                dsunits = "GB"
                if 9999 < spd then
                    spd = spd / 1000
                    dsunits = "TB"
                else
                end
            else
            end
           
        else
        end


        if string.find(Location,"disk") then
            print("FDD          "..spc..capunits.."    "..Location.."        "..spd..dsunits)
        else
            print("System       "..spc..capunits.."    "..Location.."        "..spd..dsunits)
        end


        
    else

    end


end

print("Filesystem    Size    Mount Point    Free")
print("==============================================")
makeDFTable("/")
makeDFTable("/disk")
makeDFTable("/disk1")
makeDFTable("/disk2")


