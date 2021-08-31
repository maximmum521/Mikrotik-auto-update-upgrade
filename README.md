# Mikrotik auto update upgrade

### Automate install from console 

```
/tool fetch url="https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/script.rsc"
```
```
import script.rsc
```

Change in script "/system script UpdateUpgrade" BotId and ChatId on your own Telegram Bot ID and Chat ID 

    :local BotId "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"; 
    :local ChatId "xxxxxx";
    
### Manual install

Make [script](https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/script) "/system script" 

Generate periodic task in "/system scheduler"

Change in script BotId and ChatId on your own Telegram Bot ID and Chat ID 

    :local BotId "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"; 
    :local ChatId "xxxxxx";


### Setings script

Edit this parameters default all enabled
```
#####
# script setings
#####
:local SendStatus true;
:local TasckUpgrade true;
:local AutoUpdate true;
```

SendStatus - send notification to telegram 

TasckUpgrade - run task auto update packages 

TasckUpgrade - run task auto upgrade core firmware