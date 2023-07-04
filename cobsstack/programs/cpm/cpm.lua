local cpmver = "V0.0.6a"
appargs = { ... }

local curdir2 = shell.dir()
function downloadFile(url, saveloc)
    --based on rom/programs/http/wget.lua
    if not http then
        print("Installation requires a HTTP enabled PC.")
       
    end
    local ok, err = http.checkURL(url)
    if not ok then
        print("Error parsing URL")
       
    end
    local response = http.get(url, nil, true)
    local sResponse = response.readAll()
    response.close()
    local file = fs.open(saveloc,"wb")
    file.write(sResponse)
    file.close()

end


function checkPackage(packagename)
    if fs.exists("/cobos/programs/cpm/install") then
        --installation mode for initial cpm setup, keep things silent.
        local repoloc = fs.open("/cobos/programs/cpm/default.repo", "r")
        if repoloc then
            local remro = repoloc.readAll()
            --print("Connecting to "..remro)
            repoloc.close()
            if http.checkURL(remro) then
                local resp=http.get(remro.."packages/"..packagename.."/desc.txt")
                if resp == nil then
              --      print("Package not available.")
                    return false
                else
                    --write("Install package: "..packagename)
                --    print("Package Description: "..resp.readAll())
                    resp.close()
    
                    local resp=http.get(remro.."packages/"..packagename.."/install.lua")
                    if resp == nil then
                       -- print("The package "..packagename.." was found, but has no installation file.")
                        return false
                    else
                       -- print("Downloading package now...")
                       print("Downloading Package "..packagename.." to "..curdir2.."/"..packagename..".lua")
                        downloadFile(""..remro.."packages/"..packagename.."/install.lua",curdir2.."/"..packagename..".lua")
                        --shell.run("wget",""..remro.."packages/"..packagename.."/install.lua "..packagename..".lua")
                        return true
                    end
                end
            else
               -- print("[X] Invalid URL specified for default.repo.")
                return false
            end
        end







    else
        --casual mode
        local repoloc = fs.open("/cobos/programs/cpm/default.repo", "r")
        if repoloc then
            local remro = repoloc.readAll()
            print("Connecting to "..remro)
            repoloc.close()
            if http.checkURL(remro) then
                local resp=http.get(remro.."packages/"..packagename.."/desc.txt")
                if resp == nil then
                    print("Package not available.")
                    return false
                else
                    print("Package:             "..packagename)
                    print("Package Description: "..resp.readAll())
                    resp.close()
    
                    local resp=http.get(remro.."packages/"..packagename.."/install.lua")
                    if resp == nil then
                        print("The package "..packagename.." was found, but has no installation file.")
                        return false
                    else
                        print("Downloading package now...")
                        shell.run("wget",""..remro.."packages/"..packagename.."/install.lua "..packagename..".lua")
                        return true
                    end
                end
            else
                print("[X] Invalid URL specified for default.repo.")
                return false
            end
        end
    end
end










if #appargs == 0 then
    print("CPM -- The Cobs Package Manager")    
    print("===============================")
    print("[x] No request defined.")
    print("Install package - CPM install packagename")
    print("Remove package  - CPM uninstall packagename")
    print("Update package  - CPM update packagename")
    print("Update all      - CPM updateall")
    print("Test Repo       - CPM testrepo")
else
    if(#appargs == 1) then
        if appargs[1] == "updateall" then
            --update all packages
            print("CPM -- The Cobs Package Manager")    
            print("Updating all packages, please wait...")
        elseif appargs[1] == "about" then
            print("CPM -- The Cobs Package Manager "..cpmver)
        elseif appargs[1] == "testrepo" then
            print("CPM -- The Cobs Package Manager ")
            print("Please wait...")
            local repoloc = fs.open("/cobos/programs/cpm/default.repo", "r")
            if repoloc then
                local remro = repoloc.readAll()
                print("Connecting to "..remro)
                repoloc.close()
                if http.checkURL(remro) then
                    local resp=http.get(remro.."/desc.txt")
                    print(resp.readAll())
                    resp.close()
                else
                    print("[X] Invalid URL specified for default.repo.")
                end

            else
                print("[X] Missing /cobos/programs/cpm/default.repo")
                print("[i] Please create this and enter the URL of your desired REPO, or reun recovery to restore default settings.")
            end


        else
            print("CPM -- The Cobs Package Manager")    
            print("Unknown command")
        end

    elseif (#appargs == 2) then

        if fs.exists("/cobos/programs/cpm/install") then
         
            
            --installation mode for initial cpm setup, keep things silent.
          
            if appargs[1] == "install" then
                write("CPM is installing "..appargs[2])
               -- print("Preparing install for "..appargs[2])
                if checkPackage(appargs[2]) == true then
                    
                    
                    if appargs[2] == "sys-utils" then
                        shell.run("sys-utils.lua")
                    else
                       -- print("CPM Finished.")
                    end
                  
                    
                else
                    print("Failure installing "..appargs[2])
    
                end
            elseif appargs[1] == "uninstall" then
               -- print("Preparing uninstall for "..appargs[2])
    
              --  print("Checking for file "..appargs[2]..".lua")
                if fs.exists(shell.dir().."/"..appargs[2]..".lua") then
                    fs.delete(shell.dir().."/"..appargs[2]..".lua")
                 --  print("The package has been removed.")
                else
                    --print("Package cannot be updated because it does not exist.")
                end
            elseif appargs[1] == "update" then
                if appargs[2] == "sys-utils" then
                    shell.run("/cobos/programs/cpm/cpm.lua","uninstall sys-utils")
                    shell.run("/cobos/programs/cpm/cpm.lua","install sys-utils")
                else
                
                  --  print("Working directory: "..shell.dir())
                   -- print("Preparing update for "..appargs[2])
                   -- print("Checking for file "..appargs[2])
                    if fs.exists(shell.dir().."/"..appargs[2]) then
                        fs.delete(shell.dir().."/"..appargs[2])
                       -- print("Preparing install for "..appargs[2])
                        if checkPackage(appargs[2]) == true then
                           -- print("If no errors are shown, the package should be installed.")
                        else
                           -- print("Failure installing "..appargs[2])
                        end
                    else
                       -- print("Checking for file "..appargs[2]..".lua")
                        if fs.exists(shell.dir().."/"..appargs[2]..".lua") then
                            fs.delete(shell.dir().."/"..appargs[2]..".lua")
                            --print("Preparing install for "..appargs[2])
                            if checkPackage(appargs[2]) == true then
                                --print("If no errors are shown, the package should be installed.")
                            else
                             --   print("Failure installing "..appargs[2])
                            end
                        else
                           -- print("Package cannot be updated because it does not exist.")
                        end
                    end
                end
            else
                print("Invalid argument "..appargs[1])
            end
    
        else
            --standard mode
            print("CPM -- The Cobs Package Manager")    
            if appargs[1] == "install" then
                print("Preparing install for "..appargs[2])
                if checkPackage(appargs[2]) == true then
                    
                    
                    if appargs[2] == "sys-utils" then
                        shell.run("sys-utils.lua")
                    else
                        print("If no errors are shown, the package should be installed.")
                    end
                  
                    
                else
                    print("Failure installing "..appargs[2])
    
                end
            elseif appargs[1] == "uninstall" then
                print("Preparing uninstall for "..appargs[2])
    
                print("Checking for file "..appargs[2]..".lua")
                if fs.exists(shell.dir().."/"..appargs[2]..".lua") then
                    fs.delete(shell.dir().."/"..appargs[2]..".lua")
                   print("The package has been removed.")
                else
                    print("Package cannot be updated because it does not exist.")
                end
            elseif appargs[1] == "update" then
                if appargs[2] == "sys-utils" then
                    shell.run("/cobos/programs/cpm/cpm.lua","uninstall sys-utils")
                    shell.run("/cobos/programs/cpm/cpm.lua","install sys-utils")
                else
                
                    print("Working directory: "..shell.dir())
                    print("Preparing update for "..appargs[2])
                    print("Checking for file "..appargs[2])
                    if fs.exists(shell.dir().."/"..appargs[2]) then
                        fs.delete(shell.dir().."/"..appargs[2])
                        print("Preparing install for "..appargs[2])
                        if checkPackage(appargs[2]) == true then
                            print("If no errors are shown, the package should be installed.")
                        else
                            print("Failure installing "..appargs[2])
                        end
                    else
                        print("Checking for file "..appargs[2]..".lua")
                        if fs.exists(shell.dir().."/"..appargs[2]..".lua") then
                            fs.delete(shell.dir().."/"..appargs[2]..".lua")
                            print("Preparing install for "..appargs[2])
                            if checkPackage(appargs[2]) == true then
                                print("If no errors are shown, the package should be installed.")
                            else
                                print("Failure installing "..appargs[2])
                            end
                        else
                            print("Package cannot be updated because it does not exist.")
                        end
                    end
                end
            else
                print("Invalid argument "..appargs[1])
            end
    
        end



    
    else
        print("CPM -- The Cobs Package Manager")    
        print("Invalid number of arguments were recieved: "..#appargs)

    end

end
