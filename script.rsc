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
    log info \"Run WakeUp script\";\
    \n\r\
    \n\
    \n:delay 120s;\r\
    \n#####\r\
    \n# settings\r\
    \n#####\r\
    \n:local Tag \"WakeUp\"\r\
    \n:local BotId \"xxxxxxxxxxxxxxxxxxxxxxxxxxxxx\";\r\
    \n:local ChatId \"xxxxxx\";\r\
    \n:local Current [/system routerboard get current-firmware];\r\
    \n:local Upgrade [/system routerboard get upgrade-firmware];\r\
    \n#####\r\
    \n# run\r\
    \n#####\r\r\
    \n:if (\$Current != \$Upgrade) do={\r\
    \n  :global BackText \"UPGRADE FIRMWARE RUN BACKUP\";\r\
    \n  /system script run SendBackup;\r\
    \n  :delay 5s;\r\
    \n  /system routerboard upgrade;\r\
    \n  /system reboot;\r\
    \n  } else={\r\
    \n  /tool fetch url=\"https://api.telegram.org/bot\$BotId/sendMessage\\\?c\
    hat_id=\$ChatId&text=\\\r\
    \n  \$[/system identity get name] \\\r\
    \n  %0a\$[/system routerboard get model] \\\r\
    \n  %0a\$[/system clock get date] \$[/system clock get time]\\ \r\
    \n  %0aROUTER WAKE UP\\\r\
    \n  %0a%23\$Tag\" keep-result=no;\r\
    \n  }\r\
    \n"
add dont-require-permissions=no name=Update policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    log info \"Run Update script\";\r\
    \n#####\r\
    \n# telegram setings \r\
    \n#####\r\
    \n:local BotId \"xxxxxxxxxxxxxxxxxxxxxxxxxxxxx\";\r\
    \n:local ChatId \"xxxxxx\";\r\
    \n#####\r\
    \n# router info\r\
    \n#####\r\
    \n:local Tag \"%23UpdateRouterOS\";\r\
    \n:local TagStat;\r\
    \n:local Name [/system identity get name];\r\
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
    \n\t%0a\$Stat\\\r\
    \n\t%0aCurrent version=\$CurrentVer\\\r\
    \n\t%0aAvailable version=\$NewVer\\  \r\
    \n\t%0aCurrent firmware=\$CurrentFirmware\\\r\
    \n\t%0aUpgrade firmware=\$UpgradeFirmware\\\r\
    \n\t%0aFactory firmware=\$Factory\\ \r\
    \n\t%0a\$Tag \$TagStat\" keep-result=no;\r\
    \n};\r\
    \n#####\r\
    \n# MAIN SCRIPT\r\
    \n#####\r\
    \n:if (\"New version is available\" = \$Stat ) do={\r\
    \n\t\$sendFunc ChatId=[\$ChatId] BotId=[\$BotId] Model=[\$Model] Stat=[\$S\
    tat] CurrentVer=[\$CurrentVer] NewVer=[\$NewVer] CurrentFirmware=[\$Curren\
    tFirmware] UpgradeFirmware=[\$UpgradeFirmware] Factory=[\$Factory] Tag=[\$\
    Tag] TagStat=\"%23NeedUpdate\"\t\r\
    \n\t:global BackText \"UPDATE PACKAGE RUN BACKUP\";\r\
    \n\t/system script run SendBackup;\r\
    \n\t:delay 5s;\r\
    \n/system package update install;\r\
    \n} else={\r\
    \n\t\$sendFunc ChatId=[\$ChatId] BotId=[\$BotId] Model=[\$Model] Stat=[\$S\
    tat] CurrentVer=[\$CurrentVer] NewVer=[\$NewVer] CurrentFirmware=[\$Curren\
    tFirmware] UpgradeFirmware=[\$UpgradeFirmware] Factory=[\$Factory] Tag=[\$\
    Tag] TagStat=\"%23NoNeedUpdate\"\r\
    \n}"
add dont-require-permissions=no name=SendBackup policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    log info \"Start SendBackup scripts\";\r\
    \n#####\r\
    \n# e-mail setings\r\
    \n#####\r\
    \n:local Mail xxxxxxxxxxxxxxx;\r\
    \n:global BackText;\r\
    \n#####\r\
    \n# job\r\
    \n#####\r\
    \n/export file=backup;\r\
    \n/system backup save name=backup;\r\
    \n:delay 1s;\r\
    \n/tool e-mail send to=\$Mail \\\r\
    \nsubject=\"BACKUP \$[/system clock get date]\" \\\r\
    \nbody=\"\$[/system identity get name] \\n\$[/system routerboard get model\
    ] \\n\$BackText\"\\\r\
    \nfile=backup.backup,backup.rsc;\r\
    \n:delay 1s;\r\
    \n/file remove backup.backup;\r\
    \n/file remove backup.rsc;\r\
    \n/file remove log.txt;\r\
    \n:delay 1s;"
