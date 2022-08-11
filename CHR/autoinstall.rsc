:local delname;
:local wakeup "no";
:local sendback "no";
:local mail "NO";
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
:local funDelScr do={
:local tmp [:len [/system/script/find name="$delname"]];
:if ( $tmp > 0 ) do={
:put "\n del script $delname";
/system script remove $delname;
};
};
$funDelScr delname="ScriptSetings";
$funDelScr delname="SendBackup";
$funDelScr delname="Update";
$funDelScr delname="WakeUp";
$funDelScr delname="UpdateStat";
##### remove old scheduler
:local funDelSch do={
:local tmp [:len [/system/scheduler/find name="$delname"]];
:if ( $tmp > 0 ) do={
:put "\n del scheduler $delname";
/system scheduler remove $delname;
};
};
$funDelSch delname="WakeUp";
$funDelSch delname="Update";
##### send wakeup 
:local readinput do={:return};
:put "\nsend wakeup messages [y or n] \n\r\ndefault set \"n\"\n";
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
:if ("y" = $backmail or "Y" = $backmail) do={
:set sendback "yes";
:local readinput do={:return};
:put "\nInsert a mail\n";
:set mail [$readinput];
};
##### test messages
:local readinput do={:return};
:put "\nSend test messages [y or n]\n\r\ndefault set \"n\"\n";
:local testmessages [$readinput];
##### test messages func
:local messages "test messages from MikroTik %0achatID $chat %0abotID $bot %0amail $mail";
:local sendFunc do={
	/tool fetch url="https://api.telegram.org/bot$bot/sendMessage\?chat_id=$chat&text=$messages" keep-result=no;
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
:local ADDscriptFUNCup do={
/system script add name=UpdateStat source="\
\r\n:global updatestatus \"no\";"
};
##### del file
:local funDelFile do={
:local tmp [:len [/file/find name="$delname"]];
:if ( $tmp > 0 ) do={
:put "\n del file $delname";
/file remove $delname;
};
};
##### run
:if ("y" = $sendwake or "Y" = $sendwake) do={
:set wakeup "yes";
};
$outputFUNC bot=[$bot] chat=[$chat] mail=[$mail];
$ADDscriptFUNC bot=[$bot] chat=[$chat] mail=[$mail] wakeup=[$wakeup] sendback=[$sendback];
$ADDscriptFUNCup;
:if ("y" = $testmessages or "Y" = $testmessages) do={
$sendFunc bot=[$bot] chat=[$chat] mail=[$mail] messages=[$messages];
};
/tool fetch url="https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/script.rsc";
:import script.rsc;
:delay 2s;
$funDelFile delname="script.rsc";
:delay 1s;
$funDelFile delname="install.rsc";
:delay 1s;
$funDelScr delname="install";
:put "\nEND";