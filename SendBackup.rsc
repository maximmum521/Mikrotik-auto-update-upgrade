:log info "Run script SendBackup";
#####
# e-mail setings
#####
:global Mail "xxxxxxxxxx";
:local NameRSC "EXPORT_$[/system clock get date]";
:local NameBACKUP "BACKUP_$[/system clock get date]";
:global NameBACKUPfull "$NameBACKUP.backup";
:global NameRSCfull "$NameRSC.rsc";
#####
:local funDelFile do={
:local tmp [:len [/file/find name="$delname"]];
:if ( $tmp > 0 ) do={
:log info "delete file $delname";
/file remove $delname;
};
};

#####
# run
#####
/system sup-output name=supout.rif
/export file=$NameRSC;
/system backup save name=$NameBACKUP;
:delay 10s;
/tool e-mail send to=$Mail subject="BACKUP $[/system clock get date] $[/system identity get name]"\
body="\
BACKUP - $[/system identity get name] Date - $[/system clock get date]\
Model - $[/system routerboard get model] Revision - $[/system routerboard get revision]\
Board-name - $[/system resource get board-name]\n\ 
Serial Number - $[/system routerboard get serial-number]\
Factory-firmware - $[/system routerboard get factory-firmware]\
Current-firmware - $[/system routerboard get current-firmware]\
Upgrade-firmware - $[/system routerboard get upgrade-firmware]\
"\
file="$NameRSCfull,$NameBACKUPfull,supout.rif";
:delay 10s;
$funDelFile delname=$NameBACKUPfull;
$funDelFile delname=$NameRSCfull;
$funDelFile delname=supout.rif;