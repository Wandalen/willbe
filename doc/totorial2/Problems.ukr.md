# Питання
При введенні `will .clean` отримую наступне
```bash
dmytry@dmytry:~/Документы/Intellectual/willbe/sample/submodules$ will .clean
Request ".clean"
   . Read : /home/dmytry/Документы/Intellectual/willbe/sample/submodules/.will.yml
 . Read 1 will-files in 0.067s
 . Read : /home/dmytry/Документы/Intellectual/willbe/sample/submodules/.module/Tools/out/wTools.out.will.yml
 . Read : /home/dmytry/Документы/Intellectual/willbe/sample/submodules/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
 * Message
Expects at least one argument   

 * Condensed calls stack
    at Object.common (/usr/local/lib/node_modules/willbe/node_modules/wurifundamentals/proto/dwtools/abase/l4/Uri.s:1206:5)
    at find (/usr/local/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:525:41)
    at wWillModule.cleanWhat (/usr/local/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:494:5)
    at wWillModule.clean (/usr/local/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:588:32)
    at Object.onReady (/usr/local/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:536:19)
    at wConsequence.<anonymous> (/usr/local/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:95:20)
    at wConsequence.take (/usr/local/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:2213:8)
    at timeOut (/usr/local/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:2165:10)
    at timeOutEnd (/usr/local/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l1/gTime.s:300:29)
    at wConsequence._first (/usr/local/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:832:16)
    at wConsequence.first (/usr/local/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:915:15)
    at Timeout.timeEnd [as _onTimeout] (/usr/local/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l1/gTime.s:379:11)
    at ontimeout (timers.js:482:11)
    at tryOnTimeout (timers.js:317:5)
    at Timer.listOnTimeout (timers.js:277:5)

 * Catches stack
    caught at wWill.moduleDone @ /usr/local/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:154
    caught at Object.common @ /usr/local/lib/node_modules/willbe/node_modules/wurifundamentals/proto/dwtools/abase/l4/Uri.s:1206

 * Source code from /usr/local/lib/node_modules/willbe/node_modules/wurifundamentals/proto/dwtools/abase/l4/Uri.s:1206
    1205 : 
    1206 :   _.assert( uris.length, 'Expects at least one argument' );
    1207 :   _.assert( _.strsAreAll( uris ), 'Expects only strings as arguments' );
	
	```
	Що може бути причиною? В файлі немає розділу? Ви здається не згадували саме про цей розділ.

