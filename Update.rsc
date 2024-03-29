#####
# telegram setings 
#####
/system script run ScriptSetings;
:global BotId;
:global ChatId;
:global sendbackup;
#####
# router info
#####
:local Tag "%23UpdateRouterOS";
:local TagStat;
:local Name [/system identity get name];
:local board [/system resource get board-name];
:local Cheking [/system package update check-for-updates as-value];
:local Stat ($Cheking -> "status");
:local CurrentVer ($Cheking -> "installed-version");
:local NewVer ($Cheking -> "latest-version");
:local Model [/system routerboard get model];
:local CurrentFirmware [/system routerboard get current-firmware];
:local UpgradeFirmware [/system routerboard get upgrade-firmware];
:local Factory  [/system routerboard get factory-firmware];
#####
# send status
#####     
:local sendFunc do={
	/tool fetch url="https://api.telegram.org/bot$BotId/sendMessage\?chat_id=$ChatId&text=\
	$Name\
	%0a$Model\
	%0a$board\
	%0a$Stat\
	%0aCurrent version=$CurrentVer\
	%0aAvailable version=$NewVer\  
	%0aCurrent firmware=$CurrentFirmware\
	%0aUpgrade firmware=$UpgradeFirmware\
	%0aFactory firmware=$Factory\ 
	%0a$Tag $TagStat" keep-result=no;
};
#####
:local ADDscriptUpdateStat do={
/system script add name=UpdateStat source="\
:global updatestatus \"yes\";"
};
#####
# run
#####
:if ("New version is available" = $Stat ) do={
	/system script remove UpdateStat;
	$ADDscriptUpdateStat
	:delay 5s;
	$sendFunc ChatId=[$ChatId] BotId=[$BotId] Name=[$Name] Model=[$Model] board=[$board] Stat=[$Stat] CurrentVer=[$CurrentVer] NewVer=[$NewVer] CurrentFirmware=[$CurrentFirmware] UpgradeFirmware=[$UpgradeFirmware] Factory=[$Factory] Tag=[$Tag] TagStat="%23NeedUpdate"
	:if ( $sendbackup = "yes") do={
	:global BackText "UPDATE PACKAGE RUN BACKUP";
	/system script run SendBackup;
	};
	:delay 5s;
	/system package update install;
} else={
	$sendFunc ChatId=[$ChatId] BotId=[$BotId] Name=[$Name] Model=[$Model] board=[$board] Stat=[$Stat] CurrentVer=[$CurrentVer] NewVer=[$NewVer] CurrentFirmware=[$CurrentFirmware] UpgradeFirmware=[$UpgradeFirmware] Factory=[$Factory] Tag=[$Tag] TagStat="%23NoNeedUpdate"
}