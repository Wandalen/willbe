# Помилки і проблеми в роботі з пакетом

Помилка при роботі з оновленням підмодуля. завантаження або завантаження через апгрейд проходить успішно:

```
dmytry@dmytry:~/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/FirSubmoduleImporting$ will .submodules.upgrade
Request ".submodules.upgrade"
   . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/FirstModule_SubmoduleImporting/.will.yml
 . Read 1 will-files in 0.061s
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading
   . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/FirstModule_SubmoduleImporting/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals was upgraded in 6.133s
 + 1/1 submodule(s) of module::first were upgraded in 6.138s

```

Але повторний апгрейд викликає помилку і такий лог:

```
dmytry@dmytry:~/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/FirSubmoduleImporting$ will .submodules.upgrade
Request ".submodules.upgrade"
   . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/FirstModule_SubmoduleImporting/.will.yml
 . Read 1 will-files in 0.072s
 . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/FirstModule_SubmoduleImporting/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
 * Message
Failed to upgrade submodules of module::first
Failed to upgrade module::PathFundamentals
Dead lock!


 * Condensed calls stack
    at wConsequence.assertNoDeadLockWith (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:2830:5)
    at wConsequence._and (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:1533:11)
    at wConsequence.andKeep (/usr/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l0/fRoutine.s:771:21)
    at multiple (/usr/lib/node_modules/willbe/node_modules/wexternalfundamentals/proto/dwtools/abase/l4/External.s:121:6)
    at Object.shell (/usr/lib/node_modules/willbe/node_modules/wexternalfundamentals/proto/dwtools/abase/l4/External.s:62:10)
    at er (/usr/lib/node_modules/willbe/node_modules/wexternalfundamentals/proto/dwtools/abase/l4/External.s:708:14)
    at wFileProviderGit.isUpToDate (/usr/lib/node_modules/willbe/node_modules/wFiles/proto/dwtools/amid/files/l5_provider/Git.ss:411:3)
    at wWillModule.remoteIsUpToDate (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1723:30)
    at wConsequence.con.keep (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1849:23)
    at wConsequence.thenKeep (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:397:8)
    at wWillModule._remoteDownload (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1849:4)
    at wConsequence.con.keep (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1448:45)
    at wConsequence.thenKeep (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:397:8)
    at wWillModule._submodulesDownload (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1443:9)
    at wWillModule.submodulesUpgrade (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1506:17)
    at Object.onReady (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:492:19)
    at wConsequence.<anonymous> (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:74:20)
    at wConsequence.take (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:2213:8)
    at timeOut (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:2165:10)
    at timeOutEnd (/usr/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l1/gTime.s:300:29)
    at wConsequence._first (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:832:16)
    at wConsequence.first (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:915:15)
    at Timeout.timeEnd [as _onTimeout] (/usr/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l1/gTime.s:379:11)
    at listOnTimeout (timers.js:327:15)
    at processTimers (timers.js:271:5)

 * Catches stack
    caught at wWill.moduleDone @ /usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:133
    caught at wConsequence.con.finally @ /usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1467
    caught at wConsequence.? @ /usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1891
    caught at wConsequence.assertNoDeadLockWith @ /usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:2830

 * Source code from /usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:2830
    2829 :
    2830 :   _.assert( !result, msg );
    2831 :

at multiple (/usr/lib/node_modules/willbe/node_modules/wexternalfundamentals/proto/dwtools/abase/l4/External.s:121:6) - and # 125
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...
Waiting for 1 procedure(s) ...

```
