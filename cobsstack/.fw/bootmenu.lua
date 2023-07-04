

shell.run("cd","/")
term.clear()
term.setCursorPos(1,1)
term.setBackgroundColor(colors.white)
term.setTextColor(colors.white)
term.clearLine()
term.setCursorPos(1,1)
term.setTextColor(colors.black)
print("CobOS System Firmware Utilities - Boot Menu")
sleep(1)
term.setTextColor(colors.white)
term.setBackgroundColor(colors.black)
print("")
if fs.exists("startup") then
    print("1 - FW//HDD - CobOS System Bootloader")
else
    if fs.exists("startup.lua") then
        print("1 - FW//HDD - CobOS System Bootloader")
    else
        print("1 - FW//HDD - Unavailable")
    end
end


if fs.exists("cobos/startup.lua") then
    print("2 - HDD - CobOS")
else
    print("2 - HDD - Unavailable")
end


if fs.exists("cobos/core/recovery.lua") then
    print("3 - HDD - CobOS Recovery")
else
    print("3 - HDD - Unavailable")
end

if fs.exists("disk/startup.lua") then
    print("4 - DSK - Boot from Floppy Disk")
else
    print("4 - DSK - Unavailable")
end

print("")
write("[i] Enter option number followed by ENTER:")
als = read()
if als == "1" then
    if fs.exists("startup") then
        shell.run("startup")
    else
        shell.run("startup.lua")
    end
elseif als == "2" then
    shell.run("cobos/startup.lua")
elseif als == "3" then
    shell.run("cobos/core/recovery.lua")
elseif als == "4" then
    if fs.exists("disk/startup.lua") then
        shell.run("disk/startup.lua")
    else
        print("[X] Startup option not available. Push ENTER to return.")
        als2 = read()
        shell.run("/cobos/.fw/bootmenu.lua")
    end
else
    shell.run("/cobos/.fw/bootmenu.lua")

end
