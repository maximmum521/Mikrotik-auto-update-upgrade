/system script
add dont-require-permissions=no name=install policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    local wakeup \"no\";\r\r\
    \n:local sendback \"no\";\r\r\
    \n##### make backup\r\r\
    \n:local readinput do={:return};\r\r\
    \n:put \"\\ndo you want make backup \?\?\? [y or n] \\n\\r\\ndefault set \
    \\\"n\\\"\\n\";\r\r\
    \n:local makebackup [\$readinput];\r\r\
    \n:if (\"y\" = \$makebackup or \"Y\" = \$makebackup) do={\r\r\
    \n/export file=installbackup;\r\r\
    \n:delay 2s;\r\r\
    \n/system backup save name=installbackup;\r\r\
    \n:delay 2s;\r\r\
    \n:local readinput do={:return};\r\r\
    \n:put \"\\nyou can download backup file \\\"installbackup.backup\\\" and \
    \\\"installbackup.rsc\\\" \\r\\npress any key to continue\";\r\r\
    \n:local tmp [\$readinput];\r\r\
    \n};\r\r\
    \n##### remove old script\r\r\
    \n:local tmp \"tmp\";\r\r\
    \n:local tmp [/ system/script/find name=\"ScriptSetings\"];\r\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\r\
    \n:put \$tmp;\r\r\
    \n/system script remove \$tmp;\r\r\
    \n};\r\r\
    \n:local tmp \"tmp\";\r\r\
    \n:local tmp [/ system/script/find name=\"SendBackup\"];\r\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\r\
    \n:put \$tmp;\r\r\
    \n/system script remove \$tmp;\r\r\
    \n};\r\r\
    \n:local tmp \"tmp\";\r\r\
    \n:local tmp [/ system/script/find name=\"Update\"];\r\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\r\
    \n:put \$tmp;\r\r\
    \n/system script remove \$tmp;\r\r\
    \n};\r\r\
    \n:local tmp \"tmp\";\r\r\
    \n:local tmp [/ system/script/find name=\"WakeUp\"];\r\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\r\
    \n:put \$tmp;\r\r\
    \n/system script remove \$tmp;\r\r\
    \n};\r\r\
    \n##### remove old scheduler\r\r\
    \n:local tmp \"tmp\";\r\r\
    \n:local tmp [/ system/scheduler/find name=\"WakeUp\"];\r\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\r\
    \n:put \$tmp;\r\r\
    \n/system scheduler remove \$tmp;\r\r\
    \n};\r\r\
    \n:local tmp \"tmp\";\r\r\
    \n:local tmp [/ system/scheduler/find name=\"Update\"];\r\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\r\
    \n:put \$tmp;\r\r\
    \n/system scheduler remove \$tmp;\r\r\
    \n};\r\r\
    \n##### send wakeup \r\r\
    \n:local readinput do={:return};\r\r\
    \n:put \"\\nsend wakeup messege [y or n] \\n\\r\\ndefault set \\\"n\\\"\\n\
    \";\r\r\
    \n:local sendwake [\$readinput];\r\r\
    \n##### send backup \r\r\
    \n:local readinput do={:return};\r\r\
    \n:put \"\\nsend backup to mail [y or n] \\n\\r\\ndefault set \\\"n\\\"\\n\
    \";\r\r\
    \n:local backmail [\$readinput];\r\r\
    \n##### chat ID \r\r\
    \n:local readinput do={:return};\r\r\
    \n:put \"\\nInsert a chat ID\\n\";\r\r\
    \n:local chat [\$readinput];\r\r\
    \n##### bot ID\r\r\
    \n:local readinput do={:return};\r\r\
    \n:put \"\\nInsert a bot ID\\n\";\r\r\
    \n:local bot [\$readinput];\r\r\
    \n##### mail\r\r\
    \n:local readinput do={:return};\r\r\
    \n:put \"\\nInsert a mail\\n\";\r\r\
    \n:local mail [\$readinput];\r\r\
    \n##### test masseg\r\r\
    \n:local readinput do={:return};\r\r\
    \n:put \"\\nSend test messeg [y or n]\\n\\r\\ndefault set \\\"n\\\"\\n\";\
    \r\r\
    \n:local testmesseg [\$readinput];\r\r\
    \n##### test messeg func\r\r\
    \n:local messege \"test messeg from MikroTik %0achatID \$chat %0abotID \$b\
    ot %0amail \$mail\";\r\r\
    \n:local sendFunc do={\r\r\
    \n\t/tool fetch url=\"https://api.telegram.org/bot\$bot/sendMessage\\\?cha\
    t_id=\$chat&text=\$messege\" keep-result=no;\r\r\
    \n};\r\r\
    \n##### output\r\r\
    \n:local outputFUNC do={\r\r\
    \n:put \"\\nCheck \\r\\nchat ID : \$chat \\r\\nbot ID : \$bot \\r\\nmail :\
    \_\$mail\";\r\r\
    \n};\r\r\
    \n##### add settings script func\r\r\
    \n:local ADDscriptFUNC do={\r\r\
    \n/system script add name=ScriptSetings source=\"\\\r\r\
    \n:global BotId \\\"\$bot\\\";\\\r\r\
    \n\\r\\n:global ChatId \\\"\$chat\\\";\\\r\r\
    \n\\r\\n:global Mail \\\"\$mail\\\";\\\r\r\
    \n\\r\\n:global wakeup \\\"\$wakeup\\\";\\\r\r\
    \n\\r\\n:global sendbackup \\\"\$sendback\\\";\"\r\r\
    \n};\r\r\
    \n##### run\r\r\
    \n:if (\"y\" = \$sendwake or \"Y\" = \$sendwake) do={\r\r\
    \n:set wakeup \"yes\";\r\r\
    \n};\r\r\
    \n:if (\"y\" = \$backmail or \"Y\" = \$backmail) do={\r\r\
    \n:set sendback \"yes\";\r\r\
    \n};\r\r\
    \n\$outputFUNC bot=[\$bot] chat=[\$chat] mail=[\$mail];\r\r\
    \n\$ADDscriptFUNC bot=[\$bot] chat=[\$chat] mail=[\$mail] wakeup=[\$wakeup\
    ] sendback=[\$sendback];\r\r\
    \n:if (\"y\" = \$testmesseg or \"Y\" = \$testmesseg) do={\r\r\
    \n\$sendFunc bot=[\$bot] chat=[\$chat] mail=[\$mail] messege=[\$messege];\
    \r\r\
    \n};\r\r\
    \n/tool fetch url=\"https://raw.githubusercontent.com/maximmum521/Mikrotik\
    -auto-update-upgrade/main/script.rsc\";\r\r\
    \n:import script.rsc;\r\r\
    \n:delay 2s;\r\r\
    \n/file remove script.rsc;"
