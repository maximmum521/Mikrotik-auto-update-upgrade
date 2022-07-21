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
Change in script BotId, ChatId, Email address

```
:global BotId "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
:global ChatId "xxxxxx";
:global Mail xxxxxxxxxxxxxxx;
```
