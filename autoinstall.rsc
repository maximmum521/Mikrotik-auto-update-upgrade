:local wakeup "no";
:local sendback "no";
##### make backup
:local readinput do={:return};
:put "\ndo you want make backup ??? [y or n] \n\r\ndefault set \"n\"\n";
:local makebackup [$readinput];
:if ("y" = $makebackup or "Y" = $makebackup) do={
/export file=installbackup;
:delay 2s;
/system backup save name=installbackup;
:delay 2s;
:local readinput do={:return};
:put "\nyou can download backup file \"installbackup.backup\" and \"installbackup.rsc\" \r\npress any key to continue";
:local tmp [$readinput];
};
##### remove old script
:local tmp "tmp";
:local tmp [/ system/script/find name="ScriptSetings"];
:if ( $tmp != "tmp" ) do={
/system script remove $tmp;
};
:local tmp "tmp";
:local tmp [/ system/script/find name="SendBackup"];
:if ( $tmp != "tmp" ) do={
/system script remove $tmp;
};
:local tmp "tmp";
:local tmp [/ system/script/find name="Update"];
:if ( $tmp != "tmp" ) do={
/system script remove $tmp;
};
:local tmp "tmp";
:local tmp [/ system/script/find name="WakeUp"];
:if ( $tmp != "tmp" ) do={
/system script remove $tmp;
};
##### remove old scheduler
:local tmp "tmp";
:local tmp [/ system/scheduler/find name="WakeUp"];
:if ( $tmp != "tmp" ) do={
/system scheduler remove $tmp;
};
:local tmp "tmp";
:local tmp [/ system/scheduler/find name="Update"];
:if ( $tmp != "tmp" ) do={
/system scheduler remove $tmp;
};
##### send wakeup 
:local readinput do={:return};
:put "\nsend wakeup messege [y or n] \n\r\ndefault set \"n\"\n";
:local sendwake [$readinput];
##### send backup 
:local readinput do={:return};
:put "\nsend backup to mail [y or n] \n\r\ndefault set \"n\"\n";
:local backmail [$readinput];
##### chat ID 
:local readinput do={:return};
:put "\nInsert a chat ID\n";
:local chat [$readinput];
##### bot ID
:local readinput do={:return};
:put "\nInsert a bot ID\n";
:local bot [$readinput];
##### mail
:local readinput do={:return};
:put "\nInsert a mail\n";
:local mail [$readinput];
##### test masseg
:local readinput do={:return};
:put "\nSend test messeg [y or n]\n\r\ndefault set \"n\"\n";
:local testmesseg [$readinput];
##### test messeg func
:local messege "test messeg from MikroTik %0achatID $chat %0abotID $bot %0amail $mail";
:local sendFunc do={
	/tool fetch url="https://api.telegram.org/bot$bot/sendMessage\?chat_id=$chat&text=$messege" keep-result=no;
};
##### output
:local outputFUNC do={
:put "\nCheck \r\nchat ID : $chat \r\nbot ID : $bot \r\nmail : $mail";
};
##### add settings script func
:local ADDscriptFUNC do={
/system script add name=ScriptSetings source="\
:global BotId \"$bot\";\
\r\n:global ChatId \"$chat\";\
\r\n:global Mail \"$mail\";\
\r\n:global wakeup \"$wakeup\";\
\r\n:global sendbackup \"$sendback\";"
};
##### run
:if ("y" = $sendwake or "Y" = $sendwake) do={
:set wakeup "yes";
};
:if ("y" = $backmail or "Y" = $backmail) do={
:set sendback "yes";
};
$outputFUNC bot=[$bot] chat=[$chat] mail=[$mail];
$ADDscriptFUNC bot=[$bot] chat=[$chat] mail=[$mail] wakeup=[$wakeup] sendback=[$sendback];
:if ("y" = $testmesseg or "Y" = $testmesseg) do={
$sendFunc bot=[$bot] chat=[$chat] mail=[$mail] messege=[$messege];
};
/tool fetch url="https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/script.rsc";
:import script.rsc;
:delay 2s;
/file remove script.rsc;
/file remove install.rsc;
/system script remove install;