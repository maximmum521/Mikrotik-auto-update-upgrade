add dont-require-permissions=no name=install policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    local delname;\r\
    \n:local wakeup \"no\";\r\
    \n:local sendback \"no\";\r\
    \n:local mail \"NO\";\r\
    \n##### make backup\r\
    \n:local readinput do={:return};\r\
    \n:put \"\\ndo you want make backup \?\?\? [y or n] \\n\\r\\ndefault set \
    \\\"n\\\"\\n\";\r\
    \n:local makebackup [\$readinput];\r\
    \n:if (\"y\" = \$makebackup or \"Y\" = \$makebackup) do={\r\
    \n/export file=installbackup;\r\
    \n:delay 2s;\r\
    \n/system backup save name=installbackup;\r\
    \n:delay 2s;\r\
    \n:local readinput do={:return};\r\
    \n:put \"\\nyou can download backup file \\\"installbackup.backup\\\" and \
    \\\"installbackup.rsc\\\" \\r\\npress any key to continue\";\r\
    \n:local tmp [\$readinput];\r\
    \n};\r\
    \n##### remove old script\r\
    \n:local funDelScr do={\r\
    \n:local tmp [:len [/system/script/find name=\"\$delname\"]];\r\
    \n:if ( \$tmp > 0 ) do={\r\
    \n:put \"\\n del script \$delname\";\r\
    \n/system script remove \$delname;\r\
    \n};\r\
    \n};\r\
    \n\$funDelScr delname=\"ScriptSetings\";\r\
    \n\$funDelScr delname=\"SendBackup\";\r\
    \n\$funDelScr delname=\"Update\";\r\
    \n\$funDelScr delname=\"WakeUp\";\r\
    \n\$funDelScr delname=\"UpdateStat\";\r\
    \n##### remove old scheduler\r\
    \n:local funDelSch do={\r\
    \n:local tmp [:len [/system/scheduler/find name=\"\$delname\"]];\r\
    \n:if ( \$tmp > 0 ) do={\r\
    \n:put \"\\n del scheduler \$delname\";\r\
    \n/system scheduler remove \$delname;\r\
    \n};\r\
    \n};\r\
    \n\$funDelSch delname=\"WakeUp\";\r\
    \n\$funDelSch delname=\"Update\";\r\
    \n##### send wakeup \r\
    \n:local readinput do={:return};\r\
    \n:put \"\\nsend wakeup messages [y or n] \\n\\r\\ndefault set \\\"n\\\"\\\
    n\";\r\
    \n:local sendwake [\$readinput];\r\
    \n##### send backup \r\
    \n:local readinput do={:return};\r\
    \n:put \"\\nsend backup to mail [y or n] \\n\\r\\ndefault set \\\"n\\\"\\n\
    \";\r\
    \n:local backmail [\$readinput];\r\
    \n##### chat ID \r\
    \n:local readinput do={:return};\r\
    \n:put \"\\nInsert a chat ID\\n\";\r\
    \n:local chat [\$readinput];\r\
    \n##### bot ID\r\
    \n:local readinput do={:return};\r\
    \n:put \"\\nInsert a bot ID\\n\";\r\
    \n:local bot [\$readinput];\r\
    \n##### mail\r\
    \n:if (\"y\" = \$backmail or \"Y\" = \$backmail) do={\r\
    \n:set sendback \"yes\";\r\
    \n:local readinput do={:return};\r\
    \n:put \"\\nInsert a mail\\n\";\r\
    \n:set mail [\$readinput];\r\
    \n};\r\
    \n##### test messages\r\
    \n:local readinput do={:return};\r\
    \n:put \"\\nSend test messages [y or n]\\n\\r\\ndefault set \\\"n\\\"\\n\"\
    ;\r\
    \n:local testmessages [\$readinput];\r\
    \n##### test messages func\r\
    \n:local messages \"test messages from MikroTik %0achatID \$chat %0abotID \
    \$bot %0amail \$mail\";\r\
    \n:local sendFunc do={\r\
    \n\t/tool fetch url=\"https://api.telegram.org/bot\$bot/sendMessage\\\?cha\
    t_id=\$chat&text=\$messages\" keep-result=no;\r\
    \n};\r\
    \n##### output\r\
    \n:local outputFUNC do={\r\
    \n:put \"\\nCheck \\r\\nchat ID : \$chat \\r\\nbot ID : \$bot \\r\\nmail :\
    \_\$mail\";\r\
    \n};\r\
    \n##### add settings script func\r\
    \n:local ADDscriptFUNC do={\r\
    \n/system script add name=ScriptSetings source=\"\\\r\
    \n:global BotId \\\"\$bot\\\";\\\r\
    \n\\r\\n:global ChatId \\\"\$chat\\\";\\\r\
    \n\\r\\n:global Mail \\\"\$mail\\\";\\\r\
    \n\\r\\n:global wakeup \\\"\$wakeup\\\";\\\r\
    \n\\r\\n:global sendbackup \\\"\$sendback\\\";\"\r\
    \n};\r\
    \n:local ADDscriptFUNCup do={\r\
    \n/system script add name=UpdateStat source=\"\\\r\
    \n\\r\\n:global updatestatus \\\"no\\\";\"\r\
    \n};\r\
    \n##### del file\r\
    \n:local funDelFile do={\r\
    \n:local tmp [:len [/file/find name=\"\$delname\"]];\r\
    \n:if ( \$tmp > 0 ) do={\r\
    \n:put \"\\n del file \$delname\";\r\
    \n/file remove \$delname;\r\
    \n};\r\
    \n};\r\
    \n##### run\r\
    \n:if (\"y\" = \$sendwake or \"Y\" = \$sendwake) do={\r\
    \n:set wakeup \"yes\";\r\
    \n};\r\
    \n\$outputFUNC bot=[\$bot] chat=[\$chat] mail=[\$mail];\r\
    \n\$ADDscriptFUNC bot=[\$bot] chat=[\$chat] mail=[\$mail] wakeup=[\$wakeup\
    ] sendback=[\$sendback];\r\
    \n\$ADDscriptFUNCup;\r\
    \n:if (\"y\" = \$testmessages or \"Y\" = \$testmessages) do={\r\
    \n\$sendFunc bot=[\$bot] chat=[\$chat] mail=[\$mail] messages=[\$messages]\
    ;\r\
    \n};\r\
    \n/tool fetch url=\"https://raw.githubusercontent.com/maximmum521/Mikrotik\
    -auto-update-upgrade/main/CHR/script.rsc\";\r\
    \n:import script.rsc;\r\
    \n:delay 2s;\r\
    \n\$funDelFile delname=\"script.rsc\";\r\
    \n:delay 1s;\r\
    \n\$funDelFile delname=\"install.rsc\";\r\
    \n:delay 1s;\r\
    \n\$funDelScr delname=\"install\";\r\
    \n:put \"\\nEND\";"