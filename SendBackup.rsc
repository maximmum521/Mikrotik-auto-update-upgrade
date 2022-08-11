#####
# e-mail setings
#####
/system script run ScriptSetings;
:global Mail;
:global BackText;
#####
:local funDelFile do={
:local tmp [:len [/file/find name="$delname"]];
:if ( $tmp > 0 ) do={
:put "\n del file $delname";
/file remove $delname;
};
};
#####
# run
#####
/export file=backup;
/system backup save name=backup;
:delay 5s;
/tool e-mail send to=$Mail \
subject="BACKUP $[/system clock get date]" \
body="$[/system identity get name] \n$[/system resource get board-name] \n$BackText"\
file=backup.backup,backup.rsc;
:delay 20s;
$funDelFile delname="backup.backup";
$funDelFile delname="backup.rsc";