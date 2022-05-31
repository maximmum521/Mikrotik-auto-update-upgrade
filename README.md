# Mikrotik auto update upgrade

### Automate install from console 

```
/tool fetch url="https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/script.rsc"
```
```
import script.rsc
```
```
/file remove script.rsc
```  

### Setings script
Change in script BotId and ChatId on your own Telegram Bot ID and Chat ID 

```
#####
# telegram setings 
#####
:local BotId "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
:local ChatId "xxxxxx";
```

Set your email address in SendBackup script
```
#####
# email setings
#####
:local Mail xxxxxxxxxxxxxxx;
```

### Manual install

Make in "/system script"
 - [WakeUp](https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/WakeUp) 
 - [Update](https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/Update) 
 - [SendBackup](https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/SendBackup) 

Generate after poweron task in "/system scheduler" run scripts WakeUp
Generate periodic task in "/system scheduler" run scripts Update