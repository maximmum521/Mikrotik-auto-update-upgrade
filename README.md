# Mikrotik auto update upgrade

### Automate install from console 

```
/tool fetch url="https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/script.rsc"
```
```
import script.rsc
```

Change in script BotId and ChatId on your own Telegram Bot ID and Chat ID 

    :local BotId "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"; 
    :local ChatId "xxxxxx";
    
### Manual install

Make [scrypt](https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/script) "/system script" 

Generate periodic task in "/system scheduler"

Change in script BotId and ChatId on your own Telegram Bot ID and Chat ID 

    :local BotId "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"; 
    :local ChatId "xxxxxx";
