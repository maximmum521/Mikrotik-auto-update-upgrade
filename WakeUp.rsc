:delay 120s;
#####
# settings
#####
:local Tag "WakeUp"
/system script run ScriptSetings;
:global BotId;
:global ChatId;
:global wakeup;
:local Current [/system routerboard get current-firmware];
:local Upgrade [/system routerboard get upgrade-firmware];
#####
# run
#####
:if ($Current != $Upgrade) do={
  :global BackText "UPGRADE FIRMWARE RUN BACKUP";
  /system script run SendBackup;
  /system routerboard upgrade;
  /system reboot;
  }; 
:if ( $wakeup = "yes" ) do={
  /tool fetch url="https://api.telegram.org/bot$BotId/sendMessage\?chat_id=$ChatId&text=\
  $[/system identity get name] \
  %0a$[/system routerboard get model] \
  %0aROUTER WAKE UP\
  %0a%23$Tag" keep-result=no;
  }