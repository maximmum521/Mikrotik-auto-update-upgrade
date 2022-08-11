/system scheduler
add name=WakeUp on-event="/system script run WakeUp " policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add interval=1w name=Update on-event="/system script run Update " policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=jan/17/2022 start-time=10:00:00
/system script
add dont-require-permissions=no name=WakeUp policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    delay 120s;\r\
    \n#####\r\
    \n# settings\r\
    \n#####\r\
    \n:local text \"ROUTER WAKE UP\";\r\
    \n:local Tag \"WakeUp\"\r\
    \n/system script run ScriptSetings;\r\
    \n:global BotId;\r\
    \n:global ChatId;\r\
    \n:global wakeup;\r\
    \n:global sendbackup;\r\
    \n:global sendbackupupgrade;\r\
    \n:local Current [/system routerboard get current-firmware];\r\
    \n:local Upgrade [/system routerboard get upgrade-firmware];\r\
    \n/system script run UpdateStat;\r\
    \n:global updatestatus;\r\
    \n/system script run UpgradeStat;\r\
    \n:global upgradestatus;\r\
    \n:local Cheking [/system package update check-for-updates as-value];\r\
    \n:local CurrentVer (\$Cheking -> \"installed-version\");\r\
    \n:local NewVer (\$Cheking -> \"latest-version\");\r\
    \n######\r\
    \n:local sendFunc do={\r\
    \n  /tool fetch url=\"https://api.telegram.org/bot\$BotId/sendMessage\\\?c\
    hat_id=\$ChatId&text=\\\r\
    \n  \$[/system identity get name]\\\r\
    \n  %0a\$[/system routerboard get model]\\\r\
    \n  %0a\$[/system resource get board-name]\\ \r\
    \n  %0a\$text\\\r\
    \n  %0a%23\$Tag\" keep-result=no;\r\
    \n};\r\
    \n#####\r\
    \n:local ADDscriptUpdateStat do={\r\
    \n/system script add name=UpdateStat source=\"\\\r\
    \n:global updatestatus \\\"no\\\";\"\r\
    \n};\r\
    \n#####\r\
    \n:local ADDscriptUpgradeStatNO do={\r\
    \n/system script add name=UpgradeStat source=\"\\\r\
    \n:global upgradestatus \\\"no\\\";\"\r\
    \n};\r\
    \n#####\r\
    \n:local ADDscriptUpgradeStatYES do={\r\
    \n/system script add name=UpgradeStat source=\"\\\r\
    \n:global upgradestatus \\\"yes\\\";\"\r\
    \n};\r\
    \n#####\r\
    \n# run\r\
    \n#####\r\
    \n:if ( \$updatestatus = \"yes\" ) do={\r\
    \n :if (\$CurrentVer = \$NewVer) do={  \r\
    \n  :set text \"ROUTER WAKE UP %0aUPDATE OK\"   \r\
    \n  :set Tag \"UPDATE_OK\";\r\
    \n  } else={\r\
    \n   :set text \"ROUTER WAKE UP %0aUPDATE FAILED\"   \r\
    \n   :set Tag \"UPDATE_FAILED\";\r\
    \n   };\r\
    \n   /system script remove UpdateStat;\r\
    \n   \$ADDscriptUpdateStat;\r\
    \n   \$sendFunc text=[\$text] BotId=[\$BotId] ChatId=[\$ChatId] Tag=[\$Tag\
    ]\r\
    \n   :delay 10s;\r\
    \n   :if (\$Current != \$Upgrade) do={\r\
    \n    :if ( \$sendbackupupgrade = \"yes\") do={\r\
    \n\t  :global BackText \"UPGRADE FIRMWARE RUN BACKUP\";\r\
    \n\t  /system script run SendBackup;\r\
    \n\t  :delay 2s;\r\
    \n\t};\r\
    \n   /system script remove UpgradeStat;\r\
    \n   \$ADDscriptUpgradeStatYES;\r\
    \n   /system routerboard upgrade;\r\
    \n   /system reboot;\r\
    \n  }; \r\
    \n} else={\r\
    \n\t:if ( \$upgradestatus = \"yes\" ) do={\r\
    \n\t :if (\$Current != \$Upgrade) do={\r\
    \n\t  :set text \"ROUTER WAKE UP %0aUPGRADE FAILED\"   \r\
    \n      :set Tag \"UPGRADE_FAILED\";\r\
    \n\t } else={\r\
    \n\t  :set text \"ROUTER WAKE UP %0aUPGRADE OK\"   \r\
    \n      :set Tag \"UPGRADE_OK\";\r\
    \n\t  };\r\
    \n\t/system script remove UpgradeStat;\r\
    \n    \$ADDscriptUpgradeStatNO;\r\
    \n\t\$sendFunc text=[\$text] BotId=[\$BotId] ChatId=[\$ChatId] Tag=[\$Tag]\
    \r\
    \n\t} else={\r\
    \n\t:if ( \$wakeup = \"yes\" ) do={\r\
    \n\t\$sendFunc text=[\$text] BotId=[\$BotId] ChatId=[\$ChatId] Tag=[\$Tag]\
    \r\
    \n\t};\t\r\
    \n\t};\r\
    \n};"
add dont-require-permissions=no name=Update policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    ####\r\
    \n# telegram setings \r\
    \n#####\r\
    \n/system script run ScriptSetings;\r\
    \n:global BotId;\r\
    \n:global ChatId;\r\
    \n:global sendbackup;\r\
    \n#####\r\
    \n# router info\r\
    \n#####\r\
    \n:local Tag \"%23UpdateRouterOS\";\r\
    \n:local TagStat;\r\
    \n:local Name [/system identity get name];\r\
    \n:local board [/system resource get board-name];\r\
    \n:local Cheking [/system package update check-for-updates as-value];\r\
    \n:local Stat (\$Cheking -> \"status\");\r\
    \n:local CurrentVer (\$Cheking -> \"installed-version\");\r\
    \n:local NewVer (\$Cheking -> \"latest-version\");\r\
    \n:local Model [/system routerboard get model];\r\
    \n:local CurrentFirmware [/system routerboard get current-firmware];\r\
    \n:local UpgradeFirmware [/system routerboard get upgrade-firmware];\r\
    \n:local Factory  [/system routerboard get factory-firmware];\r\
    \n#####\r\
    \n# send status\r\
    \n#####     \r\
    \n:local sendFunc do={\r\
    \n\t/tool fetch url=\"https://api.telegram.org/bot\$BotId/sendMessage\\\?c\
    hat_id=\$ChatId&text=\\\r\
    \n\t\$Name\\\r\
    \n\t%0a\$Model\\\r\
    \n\t%0a\$board\\\r\
    \n\t%0a\$Stat\\\r\
    \n\t%0aCurrent version=\$CurrentVer\\\r\
    \n\t%0aAvailable version=\$NewVer\\  \r\
    \n\t%0aCurrent firmware=\$CurrentFirmware\\\r\
    \n\t%0aUpgrade firmware=\$UpgradeFirmware\\\r\
    \n\t%0aFactory firmware=\$Factory\\ \r\
    \n\t%0a\$Tag \$TagStat\" keep-result=no;\r\
    \n};\r\
    \n#####\r\
    \n:local ADDscriptUpdateStat do={\r\
    \n/system script add name=UpdateStat source=\"\\\r\
    \n:global updatestatus \\\"yes\\\";\"\r\
    \n};\r\
    \n#####\r\
    \n# run\r\
    \n#####\r\
    \n:if (\"New version is available\" = \$Stat ) do={\r\
    \n\t/system script remove UpdateStat;\r\
    \n\t\$ADDscriptUpdateStat\r\
    \n\t:delay 5s;\r\
    \n\t\$sendFunc ChatId=[\$ChatId] BotId=[\$BotId] Name=[\$Name] Model=[\$Mo\
    del] board=[\$board] Stat=[\$Stat] CurrentVer=[\$CurrentVer] NewVer=[\$New\
    Ver] CurrentFirmware=[\$CurrentFirmware] UpgradeFirmware=[\$UpgradeFirmwar\
    e] Factory=[\$Factory] Tag=[\$Tag] TagStat=\"%23NeedUpdate\"\r\
    \n\t:if ( \$sendbackup = \"yes\") do={\r\
    \n\t:global BackText \"UPDATE PACKAGE RUN BACKUP\";\r\
    \n\t/system script run SendBackup;\r\
    \n\t};\r\
    \n\t:delay 5s;\r\
    \n\t/system package update install;\r\
    \n} else={\r\
    \n\t\$sendFunc ChatId=[\$ChatId] BotId=[\$BotId] Name=[\$Name] Model=[\$Mo\
    del] board=[\$board] Stat=[\$Stat] CurrentVer=[\$CurrentVer] NewVer=[\$New\
    Ver] CurrentFirmware=[\$CurrentFirmware] UpgradeFirmware=[\$UpgradeFirmwar\
    e] Factory=[\$Factory] Tag=[\$Tag] TagStat=\"%23NoNeedUpdate\"\r\
    \n}"
add dont-require-permissions=no name=SendBackup policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    ####\r\
    \n# e-mail setings\r\
    \n#####\r\
    \n/system script run ScriptSetings;\r\
    \n:global Mail;\r\
    \n:global BackText;\r\
    \n#####\r\
    \n:local funDelFile do={\r\
    \n:local tmp [:len [/file/find name=\"\$delname\"]];\r\
    \n:if ( \$tmp > 0 ) do={\r\
    \n:put \"\\n del file \$delname\";\r\
    \n/file remove \$delname;\r\
    \n};\r\
    \n};\r\
    \n#####\r\
    \n# run\r\
    \n#####\r\
    \n/export file=backup;\r\
    \n/system backup save name=backup;\r\
    \n:delay 5s;\r\
    \n/tool e-mail send to=\$Mail \\\r\
    \nsubject=\"BACKUP \$[/system clock get date]\" \\\r\
    \nbody=\"\$[/system identity get name] \\n\$[/system resource get board-na\
    me] \\n\$[/system routerboard get model] \\n\$BackText\"\\\r\
    \nfile=backup.backup,backup.rsc;\r\
    \n:delay 20s;\r\
    \n\$funDelFile delname=\"backup.backup\";\r\
    \n\$funDelFile delname=\"backup.rsc\";"