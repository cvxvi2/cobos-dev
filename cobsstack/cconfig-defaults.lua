--ToDo
--Implement into cmenu as GUI
--Check disk space before reading/writing
--Add multiple profiles
--Add support for alternative BIOS menus

function loadDefaults()
    --Speed Optimised Defaults
    ---CPM Update on boot disabled
    ---Auto Recovery on boot failure
    --Quiet Boot at starter
    local spath = "/cobos/.fw/cobsstack.inf" --Do not need to check if exists, will be auto created if not.
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
    if settings.save(spath) then
        print("Settings saved!")
    else
        print("An error occurred whilst running. Please review the output to continue.")
    end


end

if settings then
    loadDefaults()
else
    print("[X] Settings API required. Please update or install the API and try again.")
    print("[i] The bootloader will currently bypass any custom settings without the Settings API being available.")
end