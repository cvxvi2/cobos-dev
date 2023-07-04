term.setCursorPos(1,1)
term.clear()
term.setCursorPos(4,4)
print("")
print("")
print("                  __         __             __  ")
print("      _________  / /_  _____/ /_____ ______/ /__")
print("     / ___/ __ \\/ __ \\/ ___/ __/ __ `/ ___/ //_/")
print("    / /__/ /_/ / /_/ (__  ) /_/ /_/ / /__/ ,<   ")
print("    \\___/\\____/_.___/____/\\__/\\__,_/\\___/_/|_|  ")
print("") 
sleep(0.5)
--print("V0.0.1 -- Starting now...")
term.setBackgroundColor(colors.white)
term.setTextColor(colors.white)
--textutils.slowPrint("=========")
term.setBackgroundColor(colors.black)


print("[>] Starting CobsStack...")
print("[i] Detecting your terminal type...")
if term.isColor() then
    print("[i] Detecting your terminal type...Modern with colour support.")
else
    print("[i] Detecting your terminal type...Legacy with monochrome support.")
end
print("[>] Search for programs...")

if fs.exists("cobos/programs") then
    print("[i] Programs directory located, searching for known programs.")
    if(fs.exists("cobos/programs/coregui")) then
        print("[i] CoreGUI applications located at programs/CoreGUI")
    else
        print("[i] The CoreGUI suite is not installed.")
        print("[i] Missing suites can be downloaded. Use the dev.danos.cloud repo.")
    end
    if(fs.exists("cobos/programs/mysuperserve")) then
        print("[i] SuperServe applications located at programs/mysuperserve")
    else
        print("[i] The SuperServe suite is not installed.")
        print("[i] Missing suites can be downloaded. Use the dev.danos.cloud repo.")
    end       
    
    if(fs.exists("cobos/programs/memester")) then
        print("[i] SuperServe applications located at programs/memester")
    else
        print("[i] The memester suite is not installed.")
        print("[i] Missing suites can be downloaded. Use the dev.danos.cloud repo.")
    end   

else
    print("[X] Programs directory not located.")
end
if fs.exists("/tmp") then
    print("[>] Removing temporary directory...")
    fs.delete("/tmp")
else
    print("[i] This boot has no temporary directory, creating now...")
end
fs.makeDir("/tmp")
print("[i] Temporary Folder sorted.")
print("[>] Checking if CPM is installed..")
if fs.exists("/cobos/programs/cpm/cpm.lua") then
    print("[>] Attempting quick preboot system update. Please wait...")
    shell.run("cd","/")
    shell.run("/cobos/programs/cpm/cpm.lua", "uninstall sys-utils")
    shell.run("/cobos/programs/cpm/cpm.lua", "install sys-utils")
    print("[i] Preboot System Update completed.")
else
    print("[X] CPM is not installed.")
end
shell.run("cd","/")

sleep(0.8)
term.clear()
term.setCursorPos(4,4)

sleep(0.5)
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

print("                "..motd2)
print("")
print("")
print("")
print("")
print("")
term.setBackgroundColor(colors.white)
term.setTextColor(colors.white)
sleep(0.2)

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
    print("CobOS has encountered a problem and needs to restart.")
    print("Please restart your computer to continue.")
    print("Error: The session manager was terminated unexpectedly.")
    sleep(5)
    shell.run("/rom/programs/reboot.lua")
else
    print("[X] CobsStack has detected a fault with your installation")
    print("    The user session manager SESMAN does not exist")
    print("    You have been dropped to root shell.")
end    