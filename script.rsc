/system scheduler
add interval=1w name=UpdateUpgrade on-event="/system script run UpdateUpgrade" \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=may/31/2021 start-time=10:00:00
/system script
add dont-require-permissions=no name=UpdateUpgrade owner=404NotFound policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    ####\r\
    \n# telegram setings \r\
    \n#####\r\
    \n:local BotId \"xxxxxxxxxxxxxxxxxxxxxxxxxxxxx\";\r\
    \n:local ChatId \"xxxxxx\";\r\
    \n#####\r\r\
    \n# email setings\r\r\
    \n#####\r\r\
    \n:local Mail xxxxxxxxxxxxxxx;\r\r\
    \n#####\r\r\
    \n# script setings\r\r\
    \n#####\r\r\
    \n:local SendStatus true;\r\r\
    \n:local TasckUpgrade true;\r\r\
    \n:local AutoUpdate true;\r\r\
    \n:local SendBackup false;\r\r\
    \n#####\r\r\
    \n# router info\r\r\
    \n#####\r\r\
    \n:local Name [/system identity get name];\r\r\
    \n:local Cheking [/system package update check-for-updates as-value];\r\r\
    \n:local Stat (\$Cheking -> \"status\");\r\r\
    \n:local CurrentVer (\$Cheking -> \"installed-version\");\r\r\
    \n:local NewVer (\$Cheking -> \"latest-version\");\r\r\
    \n:local Model [/system routerboard get model];\r\r\
    \n:local Factory  [/system routerboard get factory-firmware];\r\r\
    \n#####\r\r\
    \n# send status\r\r\
    \n#####\r\r\
    \n:if (\$SendStatus = true) do={        \r\r\
    \n\t/tool fetch url=\"https://api.telegram.org/bot\$BotId/sendMessage\\\?c\
    hat_id=\$ChatId&text=\$Name %0a\$Model %0a\$Stat %0aCurrent version=\$Curr\
    entVer %0aAvailable version=\$NewVer %0aFactory firmware=\$Factory\" keep-\
    result=no;\r\r\
    \n}\r\r\
    \n#####\r\r\
    \n# MAIN SCRIPT\r\r\
    \n#####\r\r\
    \n:if (\$CurrentVer != \$NewVer) do={\r\r\
    \n\t#####\r\r\
    \n\t# send backup to email\r\r\
    \n\t#####\r\r\
    \n\t:if (\$SendBackup = true) do={\r\r\
    \n\t\t/export file=backup;\r\r\
    \n\t\t:delay 5s;\r\r\
    \n\t\t/system backup save name=backup;\r\r\
    \n\t\t:delay 5s;\r\r\
    \n\t\t/tool e-mail send to=\$Mail subject=\"BACKUP\" body=\"\" file=backup\
    .backup;\r\r\
    \n\t\t:delay 5s;\r\r\
    \n\t\t/tool e-mail send to=\$Mail subject=\"BACKUP\" body=\"\" file=backup\
    .rsc;\r\r\
    \n\t\t:delay 10s;\r\r\
    \n\t\t/file remove backup.backup;\r\r\
    \n\t\t/file remove backup.rsc;\r\r\
    \n\t\t:delay 10s;\r\r\
    \n\t}\t\r\r\
    \n\t#####\r\r\
    \n\t# auto make task upgrade\r\r\
    \n\t#####\r\r\
    \n\t:if (\$TasckUpgrade = true) do={\r\r\
    \n\t\t/system schedule add name=UPGRADE on-event=\":delay 10s; /system sch\
    eduler remove UPGRADE; :delay 30s; /system routerboard upgrade; :delay 30s\
    ; /system reboot;\" start-time=startup interval=0;\r\r\
    \n\t}\r\r\
    \n\t#####\r\r\
    \n\t# update\r\r\
    \n\t#####\r\r\
    \n\t:if (\$AutoUpdate = true) do={\r\r\
    \n\t\t/system package update install;\r\r\
    \n\t}\r\r\
    \n}\r\
    \n\r\
    \n"
