/system script
add dont-require-permissions=no name=install policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    local wakeup \"no\";\r\
    \n:local sendback \"no\";\r\
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
    \n:local tmp \"tmp\";\r\
    \n:local tmp [/ system/script/find name=\"ScriptSetings\"];\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\
    \n/system script remove \$tmp;\r\
    \n};\r\
    \n:local tmp \"tmp\";\r\
    \n:local tmp [/ system/script/find name=\"SendBackup\"];\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\
    \n/system script remove \$tmp;\r\
    \n};\r\
    \n:local tmp \"tmp\";\r\
    \n:local tmp [/ system/script/find name=\"Update\"];\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\
    \n/system script remove \$tmp;\r\
    \n};\r\
    \n:local tmp \"tmp\";\r\
    \n:local tmp [/ system/script/find name=\"WakeUp\"];\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\
    \n/system script remove \$tmp;\r\
    \n};\r\
    \n##### remove old scheduler\r\
    \n:local tmp \"tmp\";\r\
    \n:local tmp [/ system/scheduler/find name=\"WakeUp\"];\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\
    \n/system scheduler remove \$tmp;\r\
    \n};\r\
    \n:local tmp \"tmp\";\r\
    \n:local tmp [/ system/scheduler/find name=\"Update\"];\r\
    \n:if ( \$tmp != \"tmp\" ) do={\r\
    \n/system scheduler remove \$tmp;\r\
    \n};\r\
    \n##### send wakeup \r\
    \n:local readinput do={:return};\r\
    \n:put \"\\nsend wakeup messege [y or n] \\n\\r\\ndefault set \\\"n\\\"\\n\
    \";\r\
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
    \n:local readinput do={:return};\r\
    \n:put \"\\nInsert a mail\\n\";\r\
    \n:local mail [\$readinput];\r\
    \n##### test masseg\r\
    \n:local readinput do={:return};\r\
    \n:put \"\\nSend test messeg [y or n]\\n\\r\\ndefault set \\\"n\\\"\\n\";\
    \r\
    \n:local testmesseg [\$readinput];\r\
    \n##### test messeg func\r\
    \n:local messege \"test messeg from MikroTik %0achatID \$chat %0abotID \$b\
    ot %0amail \$mail\";\r\
    \n:local sendFunc do={\r\
    \n\t/tool fetch url=\"https://api.telegram.org/bot\$bot/sendMessage\\\?cha\
    t_id=\$chat&text=\$messege\" keep-result=no;\r\
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
    \n##### run\r\
    \n:if (\"y\" = \$sendwake or \"Y\" = \$sendwake) do={\r\
    \n:set wakeup \"yes\";\r\
    \n};\r\
    \n:if (\"y\" = \$backmail or \"Y\" = \$backmail) do={\r\
    \n:set sendback \"yes\";\r\
    \n};\r\
    \n\$outputFUNC bot=[\$bot] chat=[\$chat] mail=[\$mail];\r\
    \n\$ADDscriptFUNC bot=[\$bot] chat=[\$chat] mail=[\$mail] wakeup=[\$wakeup\
    ] sendback=[\$sendback];\r\
    \n:if (\"y\" = \$testmesseg or \"Y\" = \$testmesseg) do={\r\
    \n\$sendFunc bot=[\$bot] chat=[\$chat] mail=[\$mail] messege=[\$messege];\
    \r\
    \n};\r\
    \n/tool fetch url=\"https://raw.githubusercontent.com/maximmum521/Mikrotik\
    -auto-update-upgrade/main/script.rsc\";\r\
    \n:import script.rsc;\r\
    \n:delay 2s;\r\
    \n/file remove script.rsc;\r\
    \n/file remove install.rsc;"