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