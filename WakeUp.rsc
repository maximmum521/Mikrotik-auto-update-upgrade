:delay 120s;
#####
# settings
#####
:local text "ROUTER WAKE UP";
:local Tag "WakeUp"
/system script run ScriptSetings;
:global BotId;
:global ChatId;
:global wakeup;
:global sendbackup;
:global sendbackupupgrade;
:local Current [/system routerboard get current-firmware];
:local Upgrade [/system routerboard get upgrade-firmware];
/system script run UpdateStat;
:global updatestatus;
/system script run UpgradeStat;
:global upgradestatus;
:local Cheking [/system package update check-for-updates as-value];
:local CurrentVer ($Cheking -> "installed-version");
:local NewVer ($Cheking -> "latest-version");
######
:local sendFunc do={
  /tool fetch url="https://api.telegram.org/bot$BotId/sendMessage\?chat_id=$ChatId&text=\
  $[/system identity get name]\
  %0a$[/system routerboard get model]\
  %0a$[/system resource get board-name]\ 
  %0a$text\
  %0a%23$Tag" keep-result=no;
};
#####
:local ADDscriptUpdateStat do={
/system script add name=UpdateStat source="\
:global updatestatus \"no\";"
};
#####
:local ADDscriptUpgradeStatNO do={
/system script add name=UpgradeStat source="\
:global upgradestatus \"no\";"
};
#####
:local ADDscriptUpgradeStatYES do={
/system script add name=UpgradeStat source="\
:global upgradestatus \"yes\";"
};
#####
# run
#####
:if ( $updatestatus = "yes" ) do={
 :if ($CurrentVer = $NewVer) do={  
  :set text "ROUTER WAKE UP %0aUPDATE OK"   
  :set Tag "UPDATE_OK";
  } else={
   :set text "ROUTER WAKE UP %0aUPDATE FAILED"   
   :set Tag "UPDATE_FAILED";
   };
   /system script remove UpdateStat;
   $ADDscriptUpdateStat;
   $sendFunc text=[$text] BotId=[$BotId] ChatId=[$ChatId] Tag=[$Tag]
   :delay 10s;
   :if ($Current != $Upgrade) do={
    :if ( $sendbackupupgrade = "yes") do={
	  :global BackText "UPGRADE FIRMWARE RUN BACKUP";
	  /system script run SendBackup;
	  :delay 2s;
	};
   /system script remove UpgradeStat;
   $ADDscriptUpgradeStatYES;
   /system routerboard upgrade;
   /system reboot;
  }; 
} else={
	:if ( $upgradestatus = "yes" ) do={
	 :if ($Current != $Upgrade) do={
	  :set text "ROUTER WAKE UP %0aUPGRADE FAILED"   
      :set Tag "UPGRADE_FAILED";
	 } else={
	  :set text "ROUTER WAKE UP %0aUPGRADE OK"   
      :set Tag "UPGRADE_OK";
	  };
	/system script remove UpgradeStat;
    $ADDscriptUpgradeStatNO;
	$sendFunc text=[$text] BotId=[$BotId] ChatId=[$ChatId] Tag=[$Tag]
	} else={
	:if ( $wakeup = "yes" ) do={
	$sendFunc text=[$text] BotId=[$BotId] ChatId=[$ChatId] Tag=[$Tag]
	};	
	};
};
