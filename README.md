# Mikrotik auto update upgrade

### Automate install from console 

```
/tool fetch url="https://raw.githubusercontent.com/maximmum521/Mikrotik-auto-update-upgrade/main/install.rsc"
```
```
import install.rsc
```
```
/system/script/run install
```
```
/file remove install.rsc
```  

### Setings script
Change in script BotId, ChatId, Email address

```
:global BotId "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
:global ChatId "xxxxxx";
:global Mail xxxxxxxxxxxxxxx;
```
