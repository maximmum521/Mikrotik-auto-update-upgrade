# Mikrotik auto update upgrade

### Setings script
Change in script ScriptSetings BotId, ChatId, Email address

```
:global BotId "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
:global ChatId "xxxxxx";
:global Mail xxxxxxxxxxxxxxx;
```

### Add Sheduler
```
/system scheduler
add name=WakeUp on-event="/system script run WakeUp " policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add interval=1w name=Update on-event="/system script run Update " policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=jan/17/2022 start-time=10:00:00
```