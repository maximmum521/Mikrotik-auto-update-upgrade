:delay 120s;
#####
# settings
#####
:local text "ROUTER WAKE UP";
:local Tag "WakeUp";
/system script run ScriptSetings;
:global BotId;
:global ChatId;
:global wakeup;
/system script run UpdateStat;
:global updatestatus;
:local Cheking [/system package update check-for-updates as-value];
:local CurrentVer ($Cheking -> "installed-version");
:local NewVer ($Cheking -> "latest-version");
#####
:local sendFunc do={
  /tool fetch url="https://api.telegram.org/bot$BotId/sendMessage\?chat_id=$ChatId&text=\
  $[/system identity get name] \
  %0a$text\
  %0a$[/system resource get board-name]\ 
  %0a%23$Tag" keep-result=no;
};
#####
:local ADDscriptUpdateStat do={
/system script add name=UpdateStat source="\
:global updatestatus \"no\";"
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
  $ADDscriptUpdateStat 
  $sendFunc text=[$text] BotId=[$BotId] ChatId=[$ChatId] Tag=[$Tag]
  } else={
:if ( $wakeup = "yes" ) do={
  $sendFunc text=[$text] BotId=[$BotId] ChatId=[$ChatId] Tag=[$Tag] 
  };
};