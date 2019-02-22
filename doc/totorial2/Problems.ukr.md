# Питання
<a name="1"></a>
При введенні 'will .clean' отримую наступне

```

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

<a name="2"></a>
Я використовував попередній мануал для створення експорту файла. Після багатьох маніпуляцій з файлами лог консолі не змінився. Навіть тоді, коли використав файл з готовим прикладом і змінював '.export' на '.build'. В чому причина?   

```

dmytry@dmytry:~/Документы/UpWork/IntellectualServiceMysnyk/willbe/doc/tutorial/mird$ will .export
Request ".export"
   . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe/doc/tutorial/modules/third/.will.yml
 . Read 1 will-files in 0.069s
 * Message
Failed to resolve "export" for step::export.single in module::third
Cant select "export"
because "export" does not exist
at "/"
in container
module::third
{
  dirPath : [ '/home/dmytry/Докумен' ... 'torial/modules/third' ],
  clonePath : null,
  remotePath : null,
  configName : null,
  isRemote : false,
  isDownloaded : 1,
  isUpToDate : null,
  verbosity : 0,
  alias : null,
  about : [ wWillParagraphAbout with 7 elements ],
  execution : [ wWillParagraphExecution with 2 elements ],
  submoduleMap : [ Map:Pure with 0 elements ],
  pathMap : [ Map:Pure with 2 elements ],
  pathObjMap : [ Map:Pure with 2 elements ],
  reflectorMap : [ Map:Pure with 3 elements ],
  stepMap : [ Map:Pure with 13 elements ],
  buildMap : [ Map:Pure with 1 elements ],
  exportedMap : [ Map:Pure with 0 elements ],
  willFileArray : [ Array with 1 elements ],
  willFileWithRoleMap : [ Map:Pure with 1 elements ]
}
ErrorLooking       

 * Condensed calls stack
    at errDoesNotExistThrow (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l3/Selector.s:67:17)
    at Object.iterateSingle (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l3/Selector.s:493:7)
    at Object.iterate [as onIterate] (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l3/Selector.s:266:19)
    at Object.iteratorLook [as look] (/usr/lib/node_modules/willbe/node_modules/wlooker/proto/dwtools/abase/l3/Looker.s:219:6)
    at Function._look_body [as body] (/usr/lib/node_modules/willbe/node_modules/wlooker/proto/dwtools/abase/l3/Looker.s:734:13)
    at Function.selectAct_body [as body] (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l3/Selector.s:571:33)
    at Object.selectSingle_body (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l3/Selector.s:612:25)
    at Object.selectSingle (/usr/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l0/fRoutine.s:777:21)
    at Object.select_body (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l3/Selector.s:671:16)
    at Object.select (/usr/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l0/fRoutine.s:777:21)
    at wWillModule._resolveAct (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:2682:16)
    at wWillModule._resolveMaybe_body (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:2436:23)
    at wWillModule._resolve_body (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:2607:42)
    at wWillModule._resolve (/usr/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l0/fRoutine.s:777:21)
    at o.ancestors.map (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l5/Resource.s:292:28)
    at Array.map (<anonymous>:null:null)
    at wWillStep._inheritMultiple (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l5/Resource.s:284:15)
    at wWillStep._inheritForm (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l5/Resource.s:261:12)
    at wWillStep.form2 (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l5/Resource.s:234:12)
    at wWillStep.form2 (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l7/Step.s:96:33)
    at wConsequence.con.keep (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1953:35)
    at wConsequence.thenKeep (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:397:8)
    at wWillModule._resourcesFormAct (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1953:9)
    at wWillModule._resourcesForm (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1921:10)
    at wConsequence.con.keep (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1859:30)
    at wConsequence.thenKeep (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:397:8)
    at wConsequence.module.stager.stageConsequence.split.keep (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1859:11)
    at wConsequence.thenKeep (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:397:8)
    at wWillModule.resourcesForm (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1848:4)
    at wWill.moduleMake (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainBase.s:179:14)
    at wWill._moduleOnReady (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:87:38)
    at wWill.moduleOnReady (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:116:15)
    at wWill.commandExport (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:609:15)
    at wCommandsAggregator.performCommand (/usr/lib/node_modules/willbe/node_modules/wcommandsaggregator/proto/dwtools/amid/l7/commands/CommandsAggregator.s:256:14)
    at wConsequence.con.keep (/usr/lib/node_modules/willbe/node_modules/wcommandsaggregator/proto/dwtools/amid/l7/commands/CommandsAggregator.s:189:26)
    at wConsequence.thenKeep (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:397:8)
    at wCommandsAggregator.performCommands (/usr/lib/node_modules/willbe/node_modules/wcommandsaggregator/proto/dwtools/amid/l7/commands/CommandsAggregator.s:189:9)
    at wCommandsAggregator.performApplicationArguments (/usr/lib/node_modules/willbe/node_modules/wcommandsaggregator/proto/dwtools/amid/l7/commands/CommandsAggregator.s:141:15)
    at wWill.exec (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:44:13)
    at Function.Exec (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:25:15)
    at _MainTop_s_ (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:891:6)
    at Object.<anonymous> (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:893:3)
    at Module._compile (internal/modules/cjs/loader.js:738:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:749:10)
    at Module.load (internal/modules/cjs/loader.js:630:32)
    at tryModuleLoad (internal/modules/cjs/loader.js:570:12)
    at Function.Module._load (internal/modules/cjs/loader.js:562:3)
    at Function.Module.runMain (internal/modules/cjs/loader.js:801:12)
    at internal/main/run_main_module.js:21:11

 * Catches stack
    caught at wWill.moduleDone @ /usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:154
    caught at wStager.stageError @ /usr/lib/node_modules/willbe/node_modules/wstager/proto/dwtools/amid/l3/stager/Stager.s:119
    caught at wWillModule.errResolving @ /usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:2340
    caught at Object.iterateSingle @ /usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l3/Selector.s:493

 * Source code from /usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l3/Selector.s:67
    66 :     // debugger;
    67 :     let err = _.ErrorLooking
    68 :     (

  ```

<a name="2.1"></a>
Після оновлення змінилось не багато

```

dmytry@dmytry:~/Документы/UpWork/IntellectualServiceMysnyk/willbe/doc/tutorial/mird$ will .export
Request ".export"
   . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe/doc/tutorial/modules/third/.will.yml
 . Read 1 will-files in 0.114s
 * Message
Failed to resolve "export" for step::export.single in module::third
Cant select "export"
because "export" does not exist
at "/"
in container
[ wWillModule with 36 elements ]
ErrorLooking       

 * Condensed calls stack
    at errDoesNotExistThrow (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l5/Selector.s:751:17)
    at Object.iterateSingle (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l5/Selector.s:419:7)
    at Object.iterate [as onIterate] (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l5/Selector.s:337:19)
    at Object.iteratorLook [as look] (/usr/lib/node_modules/willbe/node_modules/wlooker/proto/dwtools/abase/l3/Looker.s:190:6)
    at Function.look_body [as body] (/usr/lib/node_modules/willbe/node_modules/wlooker/proto/dwtools/abase/l3/Looker.s:647:13)
    at Function.selectAct_body [as body] (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l5/Selector.s:497:33)
    at Object.selectSingle_body (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l5/Selector.s:539:25)
    at Object.selectSingle (/usr/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l0/fRoutine.s:777:21)
    at singleSelect (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l5/Selector.s:643:17)
    at Object.select_body (/usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l5/Selector.s:596:10)
    at Object.select (/usr/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l0/fRoutine.s:777:21)
    at wWillModule._resolveAct (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:2682:16)
    at wWillModule._resolveMaybe_body (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:2436:23)
    at wWillModule._resolve_body (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:2607:42)
    at wWillModule._resolve (/usr/lib/node_modules/willbe/node_modules/wTools/proto/dwtools/abase/l0/fRoutine.s:777:21)
    at o.ancestors.map (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l5/Resource.s:292:28)
    at Array.map (<anonymous>:null:null)
    at wWillStep._inheritMultiple (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l5/Resource.s:284:15)
    at wWillStep._inheritForm (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l5/Resource.s:261:12)
    at wWillStep.form2 (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l5/Resource.s:234:12)
    at wWillStep.form2 (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l7/Step.s:96:33)
    at wConsequence.con.keep (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1953:35)
    at wConsequence.thenKeep (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:397:8)
    at wWillModule._resourcesFormAct (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1953:9)
    at wWillModule._resourcesForm (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1921:10)
    at wConsequence.con.keep (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1859:30)
    at wConsequence.thenKeep (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:397:8)
    at wConsequence.module.stager.stageConsequence.split.keep (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1859:11)
    at wConsequence.thenKeep (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:397:8)
    at wWillModule.resourcesForm (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:1848:4)
    at wWill.moduleMake (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainBase.s:179:14)
    at wWill._moduleOnReady (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:87:38)
    at wWill.moduleOnReady (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:116:15)
    at wWill.commandExport (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:609:15)
    at wCommandsAggregator.performCommand (/usr/lib/node_modules/willbe/node_modules/wcommandsaggregator/proto/dwtools/amid/l7/commands/CommandsAggregator.s:256:14)
    at wConsequence.con.keep (/usr/lib/node_modules/willbe/node_modules/wcommandsaggregator/proto/dwtools/amid/l7/commands/CommandsAggregator.s:189:26)
    at wConsequence.thenKeep (/usr/lib/node_modules/willbe/node_modules/wConsequence/proto/dwtools/abase/l9/consequence/Consequence.s:397:8)
    at wCommandsAggregator.performCommands (/usr/lib/node_modules/willbe/node_modules/wcommandsaggregator/proto/dwtools/amid/l7/commands/CommandsAggregator.s:189:9)
    at wCommandsAggregator.performApplicationArguments (/usr/lib/node_modules/willbe/node_modules/wcommandsaggregator/proto/dwtools/amid/l7/commands/CommandsAggregator.s:141:15)
    at wWill.exec (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:44:13)
    at Function.Exec (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:25:15)
    at _MainTop_s_ (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:891:6)
    at Object.<anonymous> (/usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:893:3)
    at Module._compile (internal/modules/cjs/loader.js:738:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:749:10)
    at Module.load (internal/modules/cjs/loader.js:630:32)
    at tryModuleLoad (internal/modules/cjs/loader.js:570:12)
    at Function.Module._load (internal/modules/cjs/loader.js:562:3)
    at Function.Module.runMain (internal/modules/cjs/loader.js:801:12)
    at internal/main/run_main_module.js:21:11

 * Catches stack
    caught at wWill.moduleDone @ /usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s:154
    caught at wStager.stageError @ /usr/lib/node_modules/willbe/node_modules/wstager/proto/dwtools/amid/l3/stager/Stager.s:119
    caught at wWillModule.errResolving @ /usr/lib/node_modules/willbe/proto/dwtools/atop/will/l3/Module.s:2340
    caught at Object.iterateSingle @ /usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l5/Selector.s:419

 * Source code from /usr/lib/node_modules/willbe/node_modules/wselector/proto/dwtools/abase/l5/Selector.s:751
    750 :     debugger;
    751 :     let err = _.ErrorLooking
    752 :     (

  ```
