/system scheduler
add interval=1w name=UpdateUpgrade on-event="/system script run UpdateUpgrade" \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=may/31/2021 start-time=10:00:00
/system script
add dont-require-permissions=no name=UpdateUpgrade policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    ####\r\
    \n# telegram setings \r\
    \n#####\r\
    \n:local BotId \"xxxxxxxxxxxxxxxxxxxxxxxxxxxxx\";\r\
    \n:local ChatId \"xxxxxx\";\r\
    \n#####\r\
    \n# script setings\r\
    \n#####\r\
    \n:local SendStatus true;\r\
    \n:local TasckUpgrade true;\r\
    \n:local AutoUpdate true;\r\
    \n#####\r\
    \n# router Name\r\
    \n#####\r\
    \n:local Name [/system identity get name];\r\
    \n#####\r\
    \n# package version check \r\
    \n#####\r\
    \n:local Cheking [/system package update check-for-updates as-value];\r\
    \n:local Stat (\$Cheking -> \"status\");\r\
    \n:local CurrentVer (\$Cheking -> \"installed-version\");\r\
    \n:local NewVer (\$Cheking -> \"latest-version\");\r\
    \n#####\r\
    \n# routerbord version check\r\
    \n#####\r\
    \n:local Model [/system routerboard get model];\r\
    \n:local Factory  [/system routerboard get factory-firmware];\r\
    \n#####\r\
    \n# send status\r\
    \n#####\r\
    \n:if (\$SendStatus = true) do={        \r\
    \n\t/tool fetch url=\"https://api.telegram.org/bot\$BotId/sendMessage\\\?c\
    hat_id=\$ChatId&text=\$Name %0a\$Model %0a\$Stat %0aCurrent version=\$Curr\
    entVer %0aAvailable version=\$NewVer %0aFactory firmware=\$Factory\" keep-\
    result=no;\r\
    \n}\r\
    \n#####\r\
    \n# MAIN SCRIPT\r\
    \n#####\r\
    \n:if (\$CurrentVer != \$NewVer) do={\r\
    \n\t#####\r\
    \n\t# auto make task upgrade\r\
    \n\t#####\r\
    \n\t:if (\$TasckUpgrade = true) do={\r\
    \n\t\t/system schedule add name=UPGRADE on-event=\":delay 5s; /system sche\
    duler remove UPGRADE; :delay 30s; /system routerboard upgrade; :delay 30s;\
    \_/system reboot;\" start-time=startup interval=0;\r\
    \n\t}\r\
    \n\t#####\r\
    \n\t# update\r\
    \n\t#####\r\
    \n\t:if (\$AutoUpdate = true) do={\r\
    \n\t\t/system package update install;\r\
    \n\t}\r\
    \n}\r\
    \n"
