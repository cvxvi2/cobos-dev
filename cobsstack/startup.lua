local soutput = true
local supver = "V0.0.5"
local doupdate = true
function doLogo()
  
    term.setCursorPos(4,4)
    print("               __         __             __  ")
    print("      _________  / /_  _____/ /_____ ______/ /__")
    print("     / ___/ __ \\/ __ \\/ ___/ __/ __ `/ ___/ //_/")
    print("    / /__/ /_/ / /_/ (__  ) /_/ /_/ / /__/ ,<   ")
    print("    \\___/\\____/_.___/____/\\__/\\__,_/\\___/_/|_|  ")
    print("") 

end


function printToScreen(txt)
    if soutput == true then
        print(txt)
    else

    end
end


function loadSettings()
    settings.load("/cobos/.fw/cobsstack.inf")
    if settings.get("cstack.starter.quietboot") == true then
        soutput = false
    else
        soutput = true
    end
    if settings.get("cstack.starter.updateonstartup") == true then
        doupdate = true
    else
        doupdate = false
    end
end




term.setCursorPos(1,1)
term.clear()

--Load Settings
if fs.exists("/cobos/.fw/cobsstack.inf") then
    if settings then
        loadSettings()
    else
        print("Warning: Settings API is not available. Some settings may not apply.")
        print("To remove this message, update to a version with the SETTINGS API available.")
        print("\nSystem will resume in 5 seconds.")
        sleep(5)
    end

   
else
    soutput = true
end






doLogo()                                   
sleep(1)
--printToScreen("V0.0.1 -- Starting now...")
term.setBackgroundColor(colors.white)
term.setTextColor(colors.white)
--textutils.slowprintToScreen("=========")
term.setBackgroundColor(colors.black)
sleep(0.25)


printToScreen("[>] Starting CobsStack now...")
printToScreen("[i] Detecting your terminal type...")
if term.isColor() then
    printToScreen("[i] Detecting your terminal type...Modern with colour support.")
else
    printToScreen("[i] Detecting your terminal type...Legacy with monochrome support.")
end
local x,y = term.getSize()
printToScreen("Screen Resolution: "..x.." x "..y)
printToScreen("[>] Search for programs...")

if fs.exists("cobos/programs") then
    printToScreen("[i] Programs directory located, searching for known programs.")
    if(fs.exists("cobos/programs/coregui")) then
        printToScreen("[i] CoreGUI applications located at programs/CoreGUI")
    else
        printToScreen("[i] The CoreGUI suite is not installed.")
        printToScreen("[i] Missing suites can be downloaded. Use the dev.danos.cloud repo.")
    end
    if(fs.exists("cobos/programs/mysuperserve")) then
        printToScreen("[i] SuperServe applications located at programs/mysuperserve")
    else
        printToScreen("[i] The SuperServe suite is not installed.")
        printToScreen("[i] Missing suites can be downloaded. Use the dev.danos.cloud repo.")
    end       
    
    if(fs.exists("cobos/programs/memester")) then
        printToScreen("[i] SuperServe applications located at programs/memester")
    else
        printToScreen("[i] The memester suite is not installed.")
        printToScreen("[i] Missing suites can be downloaded. Use the dev.danos.cloud repo.")
    end   

else
    printToScreen("[X] Programs directory not located.")
end
if fs.exists("/tmp") then
    printToScreen("[>] Removing temporary directory...")
    fs.delete("/tmp")
else
    printToScreen("[i] This boot has no temporary directory, creating now...")
end
fs.makeDir("/tmp")
printToScreen("[i] Temporary Folder sorted.")
printToScreen("[>] Checking if CPM is installed..")
if doupdate == true then
    if fs.exists("/cobos/programs/cpm/cpm.lua") then
        printToScreen("[>] Attempting quick preboot system update. Please wait...")
        shell.run("cd","/")
        if fs.isDir("/cobos/core/core") then
            --core install, don't update.
        else
    
        shell.run("/cobos/programs/cpm/cpm.lua", "uninstall sys-utils")
        shell.run("/cobos/programs/cpm/cpm.lua", "install sys-utils")
        end
        printToScreen("[i] Preboot System Update completed.")
        
    else
        printToScreen("[X] CPM is not installed.")
    end
    shell.run("cd","/")

else

end





term.clear()
doLogo()
sleep(0.5)
--the below is no longer used and to be deprecated
x2 = math.random(1,15)
motd2 = "Unown!"
if x2 == 1 then
    motd2 = "So venetian!"
elseif x2 == 2 then
    motd2 = "Sail the ocean wide"
elseif x2 == 3 then
    motd2 = "See the shining lights"
elseif x2 == 4 then
    motd2 = "Sail the planet"
elseif x3 == 5 then
    motd2 = "Rocket Fuel"
elseif x3 == 6 then
    motd2 = "5-9-78"
elseif x3 == 7 then
    motd2 = "the fall"
elseif x3 == 8 then
    motd2 = "worbi!"
elseif x3 == 9 then
    motd2 = "that really BUMMED me out man!"
elseif x3 == 10 then
    motd2 = "witty fanta"
elseif x3 == 11 then
    motd2 = "witty banter"
elseif x3 == 12 then
    motd2 = "prepare to be bricked"
elseif x3 == 13 then
    motd2 = "starting now..."
elseif x3 == 14 then
    motd2 = "Installing Gentoo..."
elseif x3 == 15 then
    motd2 = "Open Source'nt"
end

--printToScreen("                "..motd2)
printToScreen("                 . . .")
printToScreen("")
printToScreen("")
printToScreen("")
printToScreen("")
printToScreen("")
term.setBackgroundColor(colors.white)
term.setTextColor(colors.white)

--sleep(1)

term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)
term.setBackgroundColor(colors.white)
term.setTextColor(colors.white)
term.clearLine()
term.setCursorPos(1,1)
term.setTextColor(colors.black)
print("CobsStack V0.0.1")
sleep(0.2)
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
print("")
if fs.exists("/cobos/programs/sesman/sesman.lua") then
    shell.execute("/cobos/programs/sesman/sesman.lua")
    term.clear()
    term.setCursorPos(1,1)
    print("CobsStack has encountered a problem and needs to restart.")
    print("")
    print("Error: The session manager was terminated unexpectedly.")
    print("")
    print("Attempting a hot-reload. If this keeps happening, run recovery.")
    sleep(5)
    if fs.exists('/cobos/startup.lua') then
        shell.run("/cobos/startup.lua")
    else
        print("CobsStack cannot continue because core system files are missing.")
        print("")
        print("The system will restart in 10 seconds.")
        sleep(10)
        os.reboot()
    end

    
   
else
    print("[X] CobsStack has detected a fault with your installation")
    print("    The user session manager SESMAN does not exist")
    print("    You have been dropped to root shell.")
end    