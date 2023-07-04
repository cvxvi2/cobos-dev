term.clear()
term.setTextColor(colors.white)
term.setBackgroundColor(colors.black)


local cdir = shell.dir()


local t2 = shell.dir()
--local pms = shell.programs()
local pmsg = fs.list("/cobos/core")


local pms = {}


for i=1,#pmsg do
    if fs.isDir("/cobos/core"..pmsg[i]) then
        print("Detect DIR: "..pmsg[i])
        
    else
        print("Detect PRO: "..pmsg[i])
        table.insert(pms,pmsg[i])
        --do nothing, dir not file.
    end
end


table.insert(pms,1,"Return to Menu")

shell.run("cd",t2)
local SelectedOption=1
function drawMenu()
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.black)
    term.setBackgroundColor(colors.white)
    term.clearLine()
    term.setCursorPos(1,1)
    print("CobOS V0.0.1 -- Programs -- "..textutils.formatTime(os.time()).." Opt:"..SelectedOption.."          ")
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)
    term.setCursorPos(1,1)
   
    print("")
    for i=1,#pms do
        if SelectedOption == i then
            term.setTextColor(colors.white)
            --term.setBackgroundColor(colors.white)

            if i > 33 then
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.white)
                term.setCursorPos(36,(i-32))
                write(">"..pms[i])

            elseif i > 17 then
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.white)
                term.setCursorPos(16,(i-16))
                write(">"..pms[i])
            else
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.white)
                print(">"..pms[i])

            end
            term.setTextColor(colors.white)
                term.setBackgroundColor(colors.black)
            
            
        else
           
                
            if i > 33 then
                term.setCursorPos(36,(i-32))
                write(pms[i])

            elseif i > 17 then
                term.setCursorPos(16,(i-16))
                write(pms[i])
            else
                print(pms[i])

            end

            
        end

    end

    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)


end




local ctm = 1



drawMenu()
os.startTimer(1)
while ctm == 1 do
    local event, param = os.pullEvent()
    if event == "timer" then
        term.setCursorPos(1,1)
        term.setTextColor(colors.black)
        term.setBackgroundColor(colors.white)
        term.clearLine()
        term.setCursorPos(1,1)
        print("CobOS V0.0.1 -- Programs -- "..textutils.formatTime(os.time()).." Opt:"..SelectedOption)
        term.setTextColor(colors.white)
        term.setBackgroundColor(colors.black)
        os.startTimer(1)
    end

    if event == "key" and param == 200 then
        --up key pushed
        if SelectedOption == 1 then
            --Do nothing, we cannot go below 1
        else
            SelectedOption = SelectedOption - 1
         
            drawMenu()
            os.startTimer(1)
        end
    end

    if event == "key" and param == 208 then
        --up key pushed
        if SelectedOption == #pms then
            --Do nothing, we cannot go below 1
        else
            SelectedOption = SelectedOption + 1
           drawMenu()
           os.startTimer(1)
        end
    end



    --16

    if event == "key" and param == 203 then --sidescroll
        if SelectedOption -17 > 0 then
            SelectedOption = SelectedOption -17
         
            drawMenu()
            os.startTimer(1)
        end
    end

    if event == "key" and param == 205 then
        --up key pushed
        if SelectedOption + 17 > #pms then
          
        else
            SelectedOption = SelectedOption +17
            
            drawMenu()
            os.startTimer(1)
            
        end
    end

    if event == "key" and param == 28 then
       term.setBackgroundColor(colors.black)
       term.setTextColor(colors.white)
       term.clear()
        term.setCursorPos(1,1)
        term.setTextColor(colors.black)
        term.setBackgroundColor(colors.white)
        term.clearLine()
        term.setCursorPos(1,1)
        print("CobOS V0.0.1 -- "..pms[SelectedOption].." -- "..textutils.formatTime(os.time()).." Opt:"..SelectedOption.."              ")
        term.setTextColor(colors.white)
        term.setBackgroundColor(colors.black)
        print("")

       
      
        if pms[SelectedOption] == "Return to Menu" then
         
            ctm=0
        else
            print("Starting Program: "..pms[SelectedOption])
            print("Control+T or Terminate NOW to cancel.")
            print("If you need to use arguments, enter them now and push enter. Otherwise, just push enter:")
            pmsargs = ""
            pmsargs = read()
            term.clear()
            term.setCursorPos(1,1)
            term.setTextColor(colors.black)
            term.setBackgroundColor(colors.white)
            term.clearLine()
            term.setCursorPos(1,1)
            print("CobOS V0.0.1 -- "..pms[SelectedOption].." -- "..textutils.formatTime(os.time()).." Opt:"..SelectedOption.."              ")
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.black)
            print("")
            shell.run("/cobos/core/"..pms[SelectedOption],pmsargs)
            
            term.setBackgroundColor(colors.white)
            term.setTextColor(colors.black)
            print("\nPress enter to return to menu.")
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.black)
            als = read()
            drawMenu()
            os.startTimer(1)
        end

    end

end


shell.setDir("/"..cdir)
