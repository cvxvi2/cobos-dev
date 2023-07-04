local showLogonMessage = true


function defineAliases()
    shell.setAlias("df","/cobos/core/df.lua")
    shell.setAlias("update","/cobos/core/update.lua")
    shell.setAlias("recovery","/cobos/core/recovery.lua")
    shell.setAlias("sesman","/cobos/programs/sesman/sesman.lua")
    shell.setAlias("logout","/cobos/programs/sesman/sesman.lua")
    shell.setAlias("launcher","/cobos/programs/launcher/launcher.lua")
    shell.setAlias("cpm","/cobos/programs/cpm/cpm.lua")
    shell.setAlias("cconfig","/cobos/programs/launcher/cconfig.lua")
end


function doLogin()

    if fs.exists("/cobos/.fw/cobsstack.inf") then
        settings.load("/cobos/.fw/cobsstack.inf")
        if settings.get("cstack.sesman.hideLogonMessage") == true then
            showLogonMessage = false
        else
            showLogonMessage = true
        end
    else
        showLogonMessage = true
    end

    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.white)
    term.clearLine()
    term.setTextColor(colors.black)
    term.setCursorPos(1,1)
    print("CobsStack Login ")
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)

    if showLogonMessage==true then
        print("")
        print("Warning -- This version of CobsStack is for CC:Tweaked and CraftOS2 Emulator. It will not work with CopyCat due to different keymaps.")
        print("You can disable this notification in Settings")
        print("")
        term.setTextColor(colors.white)
        term.setBackgroundColor(colors.white)
        term.clearLine()
    else

    end

  
    term.setBackgroundColor(colors.black)
    print("\n")
    if fs.isDir("/cobos/users") then
        print("Welcome to CobsStack. Please enter your username to continue: ")    
        write("Login as ")
        local iu = read()

        if iu==nil or iu== '' then
            print("\n\nYou must specify a username to login with.")
            print("\n\nPush Enter to try again.")
            als = read()
            doLogin()
        else
            currentuser=iu
            local upath = "/cobos/users/"..iu
            isLoggedOut = false
            if fs.isDir(upath) then
                print("[i] Loading your settings, please wait.")
                shell.execute("cd",upath)
                term.clear()
                term.setCursorPos(1,1)
                term.setTextColor(colors.white)
                term.setBackgroundColor(colors.white)
                term.clearLine()
                term.setTextColor(colors.black)
                term.setCursorPos(1,1)
                print("CobsStack V0.0.1 -- "..iu)
                term.setTextColor(colors.white)
                term.setBackgroundColor(colors.black)
                print("")
                defineAliases()
            else
                print("[i] Welcome for the first time.")
                fs.makeDir(upath)
                print("[i] Rebooting for user profile creation. Please wait.")
                print("[i] Loading your settings, please wait.")
                shell.execute("cd",upath)
                sleep(0.5)
                term.clear()
                term.setCursorPos(1,1)
                term.setTextColor(colors.white)
                term.setBackgroundColor(colors.white)
                term.clearLine()
                term.setTextColor(colors.black)
                term.setCursorPos(1,1)
                print("CobsStack V0.0.1 -- "..iu)
                term.setTextColor(colors.white)
                term.setBackgroundColor(colors.black)
                print("")
                write("Configuring aliases...")
                defineAliases()
                write("done!")
                print("")
                
            end  
            if fs.exists("/cobos/programs/launcher/launcher.lua") then
                shell.run("/cobos/programs/launcher/launcher.lua")
                if fs.exists("/cobos/core/lout") then
                    fs.delete("/cobos/core/lout")
                    shell.execute("/cobos/programs/sesman/sesman.lua")
                else
                    print("Has the launcher quit unexpectedly? No logout was detected. Restarting launcher...")
                    sleep(3)
                    shell.run("/cobos/programs/launcher/launcher.lua")
                end
            else
                print("[i] No Launcher found. Dropping to shell.")
            end
        end

    else -- else for missing cobos/users
            fs.makeDir("cobos/users")
            if fs.isDir("cobos/users") then
                print("[i] SESMAN has updated your installation of CobOS. Please wait...")
                sleep(3)
                print("[>] Downloading update for CobOS...")
                shell.run("wget","run http://dev.danos.cloud/cobos/recovery.lua")
            else 
                print("[X] Failure creating users directory. You have been dropped to shell.")
            end  -- end of mkdir  
        end
    end

doLogin()