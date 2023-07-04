--DEPRECATED AND PENDING REMOVAL
--USE CPM DEVMGMT PACKAGE INSTEAD

term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
 term.setCursorPos(1,1)
 term.setTextColor(colors.black)
 term.setBackgroundColor(colors.white)
 print("CobOS V0.0.1 -- Device Manager -- "..textutils.formatTime(os.time()).."                  ")
 term.setTextColor(colors.white)
 term.setBackgroundColor(colors.black)
 print("")
 
 
 

sds = {"Top","Bottom","Front","Back","Left","Right"}
 for i=1,#sds do
    if peripheral.isPresent(sds[i]) then
        print(sds[i].." device present: Yes. Device: "..peripheral.getType(sds[i]))
    else
        print(sds[i].." device present: No")
    end

 end


print("")