local lver = "V0.0.7b6"

term.clear()
term.setCursorPos(1,1)
--define selected option and whether or not we're in a menu.
SelectedOption=1
InMenu=0


mainmenu=1
powermenu=0
updatemenu=0

function drawGUI()
    term.clear()
    term.setCursorPos(1,1)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    print("CobsStack V0.0.1 -- Launcher -- ")
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.white)
    print("===================================================")
    for i=2,17 do
        term.setCursorPos(1,1+i)
        print("1")
        term.setCursorPos(51,1+i)
        print("1")
        if i<14 then
            term.setCursorPos((51/2),1+i)
            print("1")
        end    
    end
    term.setCursorPos(1,15)
    print("===================================================")
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.setCursorPos(3,16)
    --print("BKSP: Quit             /\\ \\/ > <  : Select Item")
    print("BKSP: Quit              "..utf8.char(0x18).." "..utf8.char(0x19).." "..utf8.char(0x1A).." "..utf8.char(0x1B).."  : Select Item")
    term.setCursorPos(3,17)
    print("Launcher "..lver)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.white)
    term.setCursorPos(1,18)
    print("===================================================")
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
end

function drawMenu()
    BiosOptions = {"> Shell","> Run Program","> Settings", "> ROM Programs","> CobsStack Programs","> PC Information","> Updates","> Power","> Logout"}
    optIncrement = 2
    optIncrement2 = 2
    for i=1,#BiosOptions do
        optIncrement=optIncrement+2
        term.setCursorPos(3,optIncrement)
        if SelectedOption == i then
            term.setBackgroundColor(colors.white)
            term.setTextColor(colors.black)
            if i>5 then
                optIncrement2=optIncrement2+2
                term.setCursorPos((51/2) + 2,optIncrement2)
                print(BiosOptions[i]) 
            else
                print(BiosOptions[i]) 
            end
        else
            term.setBackgroundColor(colors.black)
            term.setTextColor(colors.white)
            if i>5 then
                optIncrement2=optIncrement2+2
                term.setCursorPos((51/2) + 2,optIncrement2)
                print(BiosOptions[i]) 
            else
                print(BiosOptions[i]) 
            end
        end
    end
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
end




function ShowPowerMenu()
    powermenu=1
    mainmenu=0
    updatemenu=0
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(1,1)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    print("CobsStack V0.0.1 -- Power Options -- "..textutils.formatTime(os.time()).." ")
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.white)
    print("===================================================")
    for i=2,17 do
        term.setCursorPos(1,1+i)
        print("1")
        term.setCursorPos(51,1+i)
        print("1")
    end
    term.setCursorPos(1,15)
    print("===================================================")
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.setCursorPos(3,16)
    print("BKSP: Quit              "..utf8.char(0x18).." "..utf8.char(0x19).." "..utf8.char(0x1A).." "..utf8.char(0x1B).."  : Select Item")
    term.setCursorPos(3,17)
    print("Launcher "..lver)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.white)
    term.setCursorPos(1,18)
    print("===================================================")
    term.setBackgroundColor(colors.black)
    BiosOptions = {"> Shutdown","> Reboot","> Cancel"}
    optIncrement = 2
    optIncrement2 = 2
    for i=1,#BiosOptions do
        optIncrement=optIncrement+2
        term.setCursorPos(3,optIncrement)
        if SelectedOption == i then
            term.setBackgroundColor(colors.white)
            term.setTextColor(colors.black)
            if i>5 then
                optIncrement2=optIncrement2+2
                term.setCursorPos((51/2) + 2,optIncrement2)
                print(BiosOptions[i]) 
            else
                print(BiosOptions[i]) 
            end
        else
            term.setBackgroundColor(colors.black)
            term.setTextColor(colors.white)
            if i>5 then
                optIncrement2=optIncrement2+2
                term.setCursorPos((51/2) + 2,optIncrement2)
                print(BiosOptions[i]) 
            else
                print(BiosOptions[i]) 
            end
        end
    end
    os.startTimer(1)
    while powermenu==1 do
        local event, param = os.pullEvent()
        if event == "timer" then
            term.setCursorPos(1,1)
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.black)
            print("CobsStack V0.0.1 -- Power Options -- "..textutils.formatTime(os.time()).." ")
            os.startTimer(1)
        end
        if event == "key" and param == 200 then
            --up key pushed
            if SelectedOption == 1 then
                --Do nothing, we cannot go below 1
            else
                SelectedOption = SelectedOption - 1
                ShowPowerMenu()
            end
        end
        if event == "key" and param == 208 then
            --up key pushed
            if SelectedOption == 3 then
                --Do nothing, we cannot go below 1
            else
                SelectedOption = SelectedOption + 1
                ShowPowerMenu()
            end
        end
        if event == "key" and param == 28 then
            if SelectedOption == 1 then
                os.shutdown()
            elseif SelectedOption == 2 then
                os.reboot()
            elseif SelectedOption == 3 then
                powermenu=0
                mainmenu=1
                drawGUI()
                drawMenu()
            end
        end
    end
end




function ShowUpdateMenu()
    updatemenu=1
    powermenu=0
    mainmenu=0
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(1,1)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    print("CobsStack V0.0.1 -- Updates -- "..textutils.formatTime(os.time()).." ")
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.white)
    print("===================================================")
    for i=2,17 do
        term.setCursorPos(1,1+i)
        print("1")
        term.setCursorPos(51,1+i)
        print("1")
    end
    term.setCursorPos(1,15)
    print("===================================================")
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.setCursorPos(3,16)
    print("BKSP: Quit              "..utf8.char(0x18).." "..utf8.char(0x19).." "..utf8.char(0x1A).." "..utf8.char(0x1B).."  : Select Item")
    
    term.setCursorPos(3,17)
    print("Launcher "..lver)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.white)
    term.setCursorPos(1,18)
    print("===================================================")
    term.setBackgroundColor(colors.black)
    BiosOptions = {"> Update Now","> Update and Reboot Now","> Cancel"}
    optIncrement = 2
    optIncrement2 = 2
    for i=1,#BiosOptions do
        optIncrement=optIncrement+2
        term.setCursorPos(3,optIncrement)
        if SelectedOption == i then
            term.setBackgroundColor(colors.white)
            term.setTextColor(colors.black)
            if i>5 then
                optIncrement2=optIncrement2+2
                term.setCursorPos((51/2) + 2,optIncrement2)
                print(BiosOptions[i]) 
            else
                print(BiosOptions[i]) 
            end
        else
            term.setBackgroundColor(colors.black)
            term.setTextColor(colors.white)
            if i>5 then
                optIncrement2=optIncrement2+2
                term.setCursorPos((51/2) + 2,optIncrement2)
                print(BiosOptions[i]) 
            else
                print(BiosOptions[i]) 
            end
        end
    end
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)

    os.startTimer(1)
    while updatemenu==1 do
        local event, param = os.pullEvent()
        if event == "timer" then
            term.setCursorPos(1,1)
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.black)
            print("CobsStack V0.0.1 -- Updates -- "..textutils.formatTime(os.time()).." ")
            os.startTimer(1)
        end
        if event == "key" and param == 200 then
            --up key pushed
            if SelectedOption == 1 then
                --Do nothing, we cannot go below 1
            else
                SelectedOption = SelectedOption - 1
                ShowUpdateMenu()
            end
        end
        if event == "key" and param == 208 then
            --up key pushed
            if SelectedOption == 3 then
                --Do nothing, we cannot go below 1
            else
                SelectedOption = SelectedOption + 1
                ShowUpdateMenu()
            end
        end
        if event == "key" and param == 28 then
            if SelectedOption == 1 then
                term.clear()
                sleep(0.25)
                term.clear()
                term.setCursorPos(1,1)
                term.setBackgroundColor(colors.black)
                term.setTextColor(colors.white)
                print("CobsStack V0.0.1 -- Updates -- "..textutils.formatTime(os.time()).." ")
                term.setBackgroundColor(colors.white)
                term.setTextColor(colors.white)
                print("===================================================")
                for i=2,17 do
                    term.setCursorPos(1,1+i)
                    print("1")
                    term.setCursorPos(51,1+i)
                    print("1")
                end
                term.setCursorPos(1,15)
                print("===================================================")
                term.setBackgroundColor(colors.black)
                term.setTextColor(colors.white)
                term.setBackgroundColor(colors.white)
                term.setTextColor(colors.white)
                term.setCursorPos(1,18)
                print("===================================================")
                term.setBackgroundColor(colors.black)
                term.setTextColor(colors.white)
                term.setCursorPos(4,4)
                shell.run("/cobos/core/update.lua")

                if fs.exists("/tmp/lupd") then
                    term.clear()
                    term.setCursorPos(1,1)
                    print("[i] [UPDATES] The launcher has updated. Please use the Logout function and then log back in for launcher updates to reflect.\n\nAlternatively, you can restart Cobsstack.")
                    print("\nPush ENTER to return to the menu.")


                    als=read()
                else

                end

                
                ShowUpdateMenu()
            elseif SelectedOption == 2 then
                term.clear()
                sleep(0.25)
                shell.run("/cobos/core/recovery.lua")
                ShowUpdateMenu()
            elseif SelectedOption == 3 then
                powermenu=0
                updatemenu=0
                mainmenu=1
                drawGUI()
                drawMenu()
            end
        end
    end
end












--above is now defined, draw the BIOS utility
drawGUI()
drawMenu()
os.startTimer(1)
while mainmenu==1 do
    local event, param = os.pullEvent()
    if event == "timer" then
        
        term.setCursorPos(1,1)
        term.setTextColor(colors.white)
        term.setBackgroundColor(colors.black)
        print("CobsStack V0.0.1 -- Launcher -- "..textutils.formatTime(os.time()).." ")
        os.startTimer(1)
    end

    if event == "key" and param == 200 then
        --up key pushed
        if SelectedOption == 1 then
            --Do nothing, we cannot go below 1
        else
            SelectedOption = SelectedOption - 1
            drawGUI()
            drawMenu()
        end
    end

    if event == "key" and param == 208 then
        --up key pushed
        if SelectedOption == 9 then
            --Do nothing, we cannot go below 1
        else
            SelectedOption = SelectedOption + 1
            drawGUI()
            drawMenu()
        end
    end

    if event == "key" and param == 203 then --sidescroll
        if SelectedOption -5 > 0 then
            SelectedOption = SelectedOption -5
            drawGUI()
            drawMenu()
        end
    end

    if event == "key" and param == 205 then
        --up key pushed
        if SelectedOption + 5 > #BiosOptions then
          
        else
            SelectedOption = SelectedOption +5
            drawGUI()
            drawMenu()
            
        end
    end

    if event == "key" and param == 259 then
        --backspace key pushed
       if InMenu==0 then
            --Not in Menu, quit.
            term.setBackgroundColor(colors.black)
            term.setTextColor(colors.white)
            term.setCursorPos(1,1)
            term.clear()
            break
       else
            --Are in menu, return to main
            drawGUI()
            drawMenu()
       end
    end

    if event == "key" and param == 28 then
        --enter pushed
     
            if SelectedOption == 1 then
                term.setBackgroundColor(colors.black)
                term.setTextColor(colors.white)
                term.clear()
                term.setCursorPos(1,1)
                print("[i] Type 'exit' at any time to return to the launcher.")
                shell.run("shell")
                print("Leaving shell..")
                term.clear()
                drawGUI()
                os.startTimer(1)
                drawMenu()
            elseif SelectedOption == 2 then
                --run program
                term.clear()
                term.setCursorPos(1,1)
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.white)
                term.clearLine()
                term.setCursorPos(1,1)

                print("CobsStack V0.0.1 -- Launcher -- "..textutils.formatTime(os.time()).." ")
                term.setTextColor(colors.white)
                term.setBackgroundColor(colors.black)
                term.setCursorPos(1,3)
                print("The current directory is "..shell.dir())
                print("Enter the program you want to run, or the full path:")
                local prognm = read()
                print("\nEnter any arguments you need:")
                local proargs=read()
                print("\n")
                shell.run(prognm,proargs)
                print("\n\nPush Enter to return to the menu.")
                als23333 = read()
                drawGUI()
                drawMenu()
               
                


            elseif SelectedOption == 3 then
                --settings
                term.setBackgroundColor(colors.black)
                term.setTextColor(colors.white)
                term.clear()
                term.setCursorPos(1,1)
                
                if fs.exists("/cobos/programs/launcher/cconfig.lua") then
                    shell.run("/cobos/programs/launcher/cconfig.lua")
                else
                    --    print("This option is currently unavailable. It will be introduced in a future update.")
                    print("Please install the latest updates to use this function.")  
                    print("\nPush Enter to return to the menu.")
                    
                end


                drawGUI()
                drawMenu()
            elseif SelectedOption == 4 then
                --build programs list gui
                local previdr = shell.dir()
                
                shell.run("/cobos/programs/launcher/pmenu.lua")
                
                drawGUI()
                drawMenu()
            elseif SelectedOption == 5 then
                local previdr = shell.dir()
                cmenu = "/cobos/programs/launcher/cmenu.lua"
                if fs.exists(cmenu) then
                    shell.run(cmenu)
                else
                    term.setBackgroundColor(colors.black)
                    term.setTextColor(colors.white)
                    term.clear()
                    term.setCursorPos(1,1)
                    print("The menu item is currently missing. Please run Updates > Update to try reinstalling it.")
                    print("\nPush Enter to return to the menu.")
                    als23333 = read()
                end



                
                
                drawGUI()
                drawMenu()
            elseif SelectedOption == 6 then
                term.clear()
                term.setCursorPos(1,1)
                --build pc info 
                local previdr = shell.dir()
                if fs.exists("msinfo32-cobsstack.lua") then
                    shell.run("msinfo32-cobsstack.lua")
                else
                    term.setBackgroundColor(colors.black)
                    term.setTextColor(colors.white)
                    term.setCursorPos(1,1)
                    print("Missing package MSINFO32-cobsstack. Please wait while installing...")
                    if fs.exists("/cobos/programs/cpm/cpm.lua") then
                        shell.run("/cobos/programs/cpm/cpm.lua","install msinfo32-cobsstack")
                        shell.run("msinfo32-cobsstack")
                       
                    else
                        term.setBackgroundColor(colors.black)
                        term.setTextColor(colors.white)
                        term.setCursorPos(1,1)
                        print("MSINFO32-cobsstack is not installed but is available via CPM.")                        
                        print("Unforunately CPM is not installed. You can get this from recovery.")
                        print("Press enter to return to the menu")
                        als=read()
                    end
                 
                end
                drawGUI()
                drawMenu()
            elseif SelectedOption == 7 then
                --build updates menu
                SelectedOption=1
                powermenu=0
                mainmenu=0
                updatemenu=1
                ShowUpdateMenu()
            elseif SelectedOption == 8 then
               --reboot and shutdown options
               SelectedOption=1
               powermenu=1
               mainmenu=0
               updatemenu=0
               ShowPowerMenu()
            elseif SelectedOption == 9 then
                isLoggedOut=true
                fs.makeDir("/cobos/core/lout")
                break
            end
    end
end



--als=read()



--up=200   --> 200
--down=208 --> 208
--left=203 --> 203
--right=205 -> 205
--f10=299  --> 
--enter=28 ->  28
--backspace=259