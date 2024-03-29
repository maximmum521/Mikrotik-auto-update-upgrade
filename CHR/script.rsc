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
    \n:local Tag \"WakeUp\";\r\
    \n/system script run ScriptSetings;\r\
    \n:global BotId;\r\
    \n:global ChatId;\r\
    \n:global wakeup;\r\
    \n/system script run UpdateStat;\r\
    \n:global updatestatus;\r\
    \n:local Cheking [/system package update check-for-updates as-value];\r\
    \n:local CurrentVer (\$Cheking -> \"installed-version\");\r\
    \n:local NewVer (\$Cheking -> \"latest-version\");\r\
    \n#####\r\
    \n:local sendFunc do={\r\
    \n  /tool fetch url=\"https://api.telegram.org/bot\$BotId/sendMessage\\\?c\
    hat_id=\$ChatId&text=\\\r\
    \n  \$[/system identity get name] \\\r\
    \n  %0a\$text\\\r\
    \n  %0a\$[/system resource get board-name]\\ \r\
    \n  %0a%23\$Tag\" keep-result=no;\r\
    \n};\r\
    \n#####\r\
    \n:local ADDscriptUpdateStat do={\r\
    \n/system script add name=UpdateStat source=\"\\\r\
    \n:global updatestatus \\\"no\\\";\"\r\
    \n};\r\
    \n#####\r\
    \n# run\r\
    \n#####\r\
    \n:if ( \$updatestatus = \"yes\" ) do={\r\
    \n  :if (\$CurrentVer = \$NewVer) do={  \r\
    \n  :set text \"ROUTER WAKE UP %0aUPDATE OK\"   \r\
    \n  :set Tag \"UPDATE_OK\";\r\
    \n  } else={\r\
    \n  :set text \"ROUTER WAKE UP %0aUPDATE FAILED\"   \r\
    \n  :set Tag \"UPDATE_FAILED\";\r\
    \n  };\r\
    \n  /system script remove UpdateStat;\r\
    \n  \$ADDscriptUpdateStat \r\
    \n  \$sendFunc text=[\$text] BotId=[\$BotId] ChatId=[\$ChatId] Tag=[\$Tag]\
    \r\
    \n  } else={\r\
    \n:if ( \$wakeup = \"yes\" ) do={\r\
    \n  \$sendFunc text=[\$text] BotId=[\$BotId] ChatId=[\$ChatId] Tag=[\$Tag]\
    \_\r\
    \n  };\r\
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
    \n:local Cheking [/system package update check-for-updates as-value];\r\
    \n:local Stat (\$Cheking -> \"status\");\r\
    \n:local CurrentVer (\$Cheking -> \"installed-version\");\r\
    \n:local NewVer (\$Cheking -> \"latest-version\");\r\
    \n:local Model [/system resource get board-name];\r\
    \n#####\r\
    \n# send status\r\
    \n#####\r\
    \n:local sendFunc do={\r\
    \n\t/tool fetch url=\"https://api.telegram.org/bot\$BotId/sendMessage\\\?c\
    hat_id=\$ChatId&text=\\\r\
    \n\t\$Name\\\r\
    \n\t%0a\$Model\\\r\
    \n\t%0a\$Stat\\\r\
    \n\t%0aCurrent version=\$CurrentVer\\\r\
    \n\t%0aAvailable version=\$NewVer\\  \r\
    \n\t%0a\$Tag \$TagStat\" keep-result=no;\r\
    \n};\r\
    \n:local ADDscriptUpdateStat do={\r\
    \n/system script add name=UpdateStat source=\"\\\r\
    \n:global updatestatus \\\"yes\\\";\"\r\
    \n};\r\
    \n#####\r\
    \n# run\r\
    \n#####\r\
    \n:if (\"New version is available\" = \$Stat ) do={\r\
    \n    /system script remove UpdateStat;\r\
    \n\t\$ADDscriptUpdateStat   \r\
    \n\t\$sendFunc ChatId=[\$ChatId] BotId=[\$BotId] Name=[\$Name] Model=[\$Mo\
    del] Stat=[\$Stat] CurrentVer=[\$CurrentVer] NewVer=[\$NewVer] Tag=[\$Tag]\
    \_TagStat=\"%23NeedUpdate\"\t\r\
    \n\t:if ( \$sendbackup = \"yes\") do={\r\
    \n\t:global BackText \"UPDATE PACKAGE RUN BACKUP\";\r\
    \n\t/system script run SendBackup;\r\
    \n\t};\r\
    \n\t/system package update install;\r\
    \n} else={\r\
    \n\t\$sendFunc ChatId=[\$ChatId] BotId=[\$BotId] Name=[\$Name] Model=[\$Mo\
    del] Stat=[\$Stat] CurrentVer=[\$CurrentVer] NewVer=[\$NewVer] Tag=[\$Tag]\
    \_TagStat=\"%23NoNeedUpdate\"\r\
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
    me] \\n\$BackText\"\\\r\
    \nfile=backup.backup,backup.rsc;\r\
    \n:delay 5s;\r\
    \n\$funDelFile delname=\"backup.backup\";\r\
    \n\$funDelFile delname=\"backup.rsc\";"