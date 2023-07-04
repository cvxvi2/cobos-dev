local biosVersion="V0.0.1"
shell.run("cd","/")
term.clear()
term.setCursorPos(1,1)
term.setBackgroundColor(colors.white)
term.setTextColor(colors.white)
term.clearLine()
term.setCursorPos(1,1)
term.setTextColor(colors.black)
print("CobOS System Firmware Utilities - System Setup")
sleep(0.25)
term.setTextColor(colors.white)
term.setBackgroundColor(colors.black)

print("")
print("=== Basic System Information ===")
if term.isColor() then
    print("System:       Advanced Computer, Colour Support")
else
    print("System:       Standard Computer, Monochrome")
end

ssyn = os.getComputerLabel()
if ssyn == nil then
    print("System Name:  Not Set")    
else
    print("System Name:  ".. os.getComputerLabel())
end


print("System ID/SN: ".. os.getComputerID())
print("System ROM:   ".. os.version())
print("CobOS BIOS:   "..biosVersion)

print("")
print("=== Drive Configuration == ")

ds = fs.getCapacity("")
cm = (ds / 100) / 10
print("HDD: "..cm.."KB drive")
if fs.isDir("disk") then
    ds2 = fs.getCapacity("disk")
    cm2 = (ds2/100) / 10
    print("FDD: "..cm2.."KB disk")
    --print("FDD: Present")
else
    print("FDD: Not Present")
end
print("")
print("=== Time and Date ===")

print("Time: ".. textutils.formatTime(os.time()))
print("Day:  "..os.date())
print("")
print("Push ENTER to boot.")

os.startTimer(1)
while true do
    local event, param = os.pullEvent()
    if event == "timer" or event == "key" then
        if event == "key" and param == 257  then
            os.reboot()
        elseif event == "timer" then
            term.setCursorPos(1,15)
            print("IG Time:   ".. textutils.formatTime(os.time()))
            print("IRL Time:  "..os.date())
            os.startTimer(1)
        end
    end
end




-- print("Press ENTER to resume.")
--als = read()
--os.reboot()