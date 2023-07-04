local keepActive = true
local curSetMen = "MainMenu"
local selectedOption = ""
local selectedOptionID = 1
local cconfigver = "V0.0.1"
local appnm = "CobsStack Settings"
local ogdir = shell.dir()


function navBar()
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.black)
    term.setBackgroundColor(colors.white)
    term.clearLine()
    term.setCursorPos(1,1)
    print(appnm.." "..cconfigver.." - "..curSetMen)
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)
    term.setCursorPos(1,1)
    print("")

end

local callInitOnDefault = true
function makeDefaultSettings()
    local spath = "/cobos/.fw/cobsstack.inf"
    print("Creating default settings file now...")
    
    --cobsstack bootloader
    settings.set("cstack.bootloader.quietboot",false)
    settings.set("cstack.bootloader.hideoptions",false)
    settings.set("cstack.bootloader.forcetosetup",false)
    settings.set("cstack.bootloader.bootentry1","/cobos/startup.lua")

    --cobbstack starter
    settings.set("cstack.starter.updateonstartup",true)
    settings.set("cstack.starter.quietboot",false)

    --sesman
    settings.set("cstack.sesman.useAlternateLoginServer",false)
    settings.set("cstack.sesman.hideLogonMessage",false)
    settings.set("cstack.sesman.AutoLogin",false)
    settings.set("cstack.sesman.AutoLoginAs","Guest")
    settings.set("cstack.sesman.useAlternativeLauncher",false)
    settings.set("cstack.sesman.ALauncherPath","/cobos/programs/launcher.lua")



    print("Saving settings...")
    settings.save(spath)
    print("Settings update complete. Please wait...")
    sleep(3)
    if callInitOnDefault then
        init()
    else
    end

end

--Menu Config
local curoption = 1 --using 1 instead of 0 as arrays start at 1 (or 0 if # -1)



--Main Menu Options
local responseOptions = {"Cancel","Enabled","Disabled","Custom Value"}
local optionsMainMenu = {"Exit","General","Disk Management","Device Manager","Startup","Session Manager","Bootloader","Launcher","Load Defaults","Load speed-optimised defaults"}

local optionsStartup = {"Exit","Update on Startup","Quiet Startup"}
local setsStartup = {nil,"cstack.starter.updateonstartup","cstack.starter.quietboot"}
local optionsSESMAN = {"Exit","Use Alternative Logon Server","Hide Logon Message","Auto Login","Auto Login As", "Use Alternative Launcher","Alternative Launcher Path"}
local optionsBootLo = {"Exit","Quiet Boot","Force to Setup on next boot","Hide Key Options"}

local optionsBuffer = {}
function drawGUI()
    term.clear()
    navBar()
    print("")
    --Buffer the options so the MenuTool can use them and this can dynamically generate
    if curSetMen == "MainMenu" then
        optionsBuffer = optionsMainMenu
    elseif curSetMen == "Startup" then
        optionsBuffer = optionsStartup
    elseif curSetMen == "SESMAN" then
        optionsBuffer = optionsSESMAN
    elseif curSetMen == "BootLo" then
        optionsBuffer = optionsBootLo
    elseif curSetMen == "responseOptions" then
        optionsBuffer = responseOptions
    else
        optionsBuffer = optionsMainMenu
    end

    for i=1,#optionsBuffer do
        if i > #optionsBuffer then
            curoption = 1
        end
        if i == curoption then
            term.setTextColor(colors.black)
            term.setBackgroundColor(colors.white)
            print(">"..optionsBuffer[i])
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.black)
        else
            print(optionsBuffer[i])
        end
    end
end

function applySettings(optionToSet,newvalue)
    --handle response options (cancel, new value, true false etc)
end





function MenuTool()
    drawGUI()
    while keepActive == true do
        local event, param = os.pullEvent()
        if event == "key" and param == 200 then
            if curoption == 1 then --Up Arrow Key
                --Do nothing, can't go up an option below 1
            else
                curoption = curoption -1
                drawGUI()
            end
        elseif event == "key" and param == 208 then
            --down arrow
            if curoption == #optionsBuffer then
                --Do nothing, at end of buffer
            else
                curoption = curoption + 1
                drawGUI()
            end
        elseif event == "key" and param == 28 then
            --Enter key pushed
            selectedOption = optionsBuffer[curoption]
            selectedOptionID = curoption
            if curSetMen == "MainMenu" then
                print("Selected Option: "..selectedOptionID.." and ID "..selectedOptionID)
                if selectedOption == "Exit" then
                    --Quit settings, in top level
                    keepActive = false
                    break
                else
                    term.clear()
                    navBar()
                    print("")
                    --Not quitting out of main menu, change menu option
                    if selectedOptionID == 2 then --Start at 2 because 1 is exit
                        --General menu, computer name etc
                         --Doesn't exist yet
                    elseif selectedOptionID == 3 then
                        --Disk Management-- Doesn't exist yet, build GUI for this, set labels etc, default to df for now
                        if fs.exists("/cobos/core/df.lua") then
                            shell.run("/cobos/core/df.lua")
                            als = read() --app auto exits by default
                        else
                        end
                        
                    elseif selectedOptionID == 4 then
                        --device manager (potentially ref to newer CPM version?)
                        if fs.exists("/cobos/core/devmgmt.lua") then
                            shell.run("/cobos/core/devmgmt.lua")
                            als = read() --app auto exits by default
                        else
                        end
                        

                    elseif selectedOptionID == 5 then
                        --Startup Settings
                        curoption = 1
                        curSetMen="Startup"
                    elseif selectedOptionID == 9 then
                        --load defaults           
                        callInitOnDefault = false             
                        makeDefaultSettings()
                        callInitOnDefault = true
                        print("Defaults loaded. Please wait...")
                        sleep(2)
                    elseif selectedOptionID == 10 then
                        local spath = "/cobos/.fw/cobsstack.inf"
                        print("Loading SO defaults...")
    
                        --cobsstack bootloader
                        settings.set("cstack.bootloader.quietboot",true)
                        settings.set("cstack.bootloader.hideoptions",false)
                        settings.set("cstack.bootloader.forcetosetup",false)
                        settings.set("cstack.bootloader.bootentry1","/cobos/startup.lua")
                        settings.set("cstack.bootloader.bootentry2","/cobos/recovery.lua")
                        settings.set("cstack.bootloader.bootentry3","/cobos/bios.lua")

                        --cobbstack starter
                        settings.set("cstack.starter.updateonstartup",false)
                        settings.set("cstack.starter.quietboot",true)

                        --sesman
                        settings.set("cstack.sesman.useAlternateLoginServer",false)
                        settings.set("cstack.sesman.hideLogonMessage",true)
                        settings.set("cstack.sesman.AutoLogin",false)
                        settings.set("cstack.sesman.AutoLoginAs","Guest")
                        settings.set("cstack.sesman.useAlternativeLauncher",false)
                        settings.set("cstack.sesman.ALauncherPath","/cobos/programs/launcher.lua")



                        print("Saving settings...")
                        settings.save(spath)
                        print("Settings saved!")
                        sleep(5)
                    else
                        
                    end

                    drawGUI()

                end


            elseif curSetMen == "Startup" then
                if selectedOptionID == 1 then
                    --quit to top level
                    curoption = 1
                    curSetMen = "MainMenu"
                else
                    
                end

                drawGUI()
            else
                --Not in top level, handle appropriately.
                

            end

        end


    end

end









function init()
    navBar()
    print("Please wait while starting CCONFIG...")
    
    if fs.exists("/cobos/.fw/cobsstack.inf") then
        print("Please wait while reading configuration.")
    
        MenuTool()



    else
        print("Configuration file does not exist. Please wait for generation...")
        makeDefaultSettings()
    end
end





if settings then 
    init()
else
    print("This utility requires the SETTINGS API to be available which currently isn't on your system or could not be loaded.")
    print("\nPlease update and try again.")
    print("\nPress Enter to return to menu")
    als = read()


end



