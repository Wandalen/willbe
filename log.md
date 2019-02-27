Tester Settings :
{
  scenario : test, 
  sanitareTime : 500, 
  fails : null, 
  beeping : true, 
  coloring : 1, 
  timing : 1, 
  rapidity : 3, 
  routine : submodulesDownload, 
  importanceOfNegative : null, 
  routineTimeOut : null, 
  concurrent : null, 
  verbosity : 10, 
  silencing : null, 
  shoulding : null, 
  accuracy : null
}

[30m[107m  Launching several ( 1 ) test suites ..[49;0m[39;0m
  D:\work\willbe\proto\dwtools\atop\will.test\WillExternals.test.s:2883 - enabled
  1 test suite

  Silencing console
[30m[107m    Running test suite ( Tools/atop/WillExternals ) ..[49;0m[39;0m
    [33m[44mat  D:\work\willbe\proto\dwtools\atop\will.test\WillExternals.test.s:2883[49;0m[39;0m
    
    wTestSuite( Tools/atop/WillExternals#in0 )
    {
      name : 'Tools/atop/WillExternals', 
      verbosity : 9, 
      importanceOfDetails : 0, 
      importanceOfNegative : 1, 
      silencing : 1, 
      shoulding : 1, 
      routineTimeOut : 5000, 
      concurrent : 0, 
      routine : 'submodulesDownload', 
      platforms : null, 
      suiteFilePath : [ 'D:\\work\\willbe\\pr' ... 'WillExternals.test.s' ], 
      suiteFileLocation : [ 'D:\\work\\willbe\\pr' ... 'xternals.test.s:2883' ], 
      tests : [ Map:Pure with 24 elements ], 
      abstract : 0, 
      enabled : 1, 
      takingIntoAccount : 1, 
      usingSourceCode : 1, 
      ignoringTesterOptions : 0, 
      accuracy : 1e-7, 
      report : [ Map:Pure with 9 elements ], 
      debug : 0, 
      override : [ Map:Pure with 0 elements ], 
      _routineCon : [ routine bound anonymous ], 
      _inroutineCon : [ routine bound anonymous ], 
      onRoutineBegin : [ routine onRoutineBegin ], 
      onRoutineEnd : [ routine onRoutineEnd ], 
      onSuiteBegin : [ routine onSuiteBegin ], 
      onSuiteEnd : [ routine onSuiteEnd ]
    }
[30m[107m      Running test routine ( submodulesDownload ) ..[49;0m[39;0m
      [30m[43m[97m > [39;0mnode D:\work\willbe\proto\dwtools\atop\will\Exec2[49;0m[39;0m
      
      [30m[43m[35m  .help - Get help. 
        .set - Command set. 
        .list - List information about the current module. 
        .paths.list - List paths of the current module. 
        .submodules.list - List submodules of the current module. 
        .reflectors.list - List avaialable reflectors. 
        .steps.list - List avaialable steps. 
        .builds.list - List avaialable builds. 
        .exports.list - List avaialable exports. 
        .about.list - List descriptive information about the module. 
        .execution.list - List execution scenarios. 
        .submodules.download - Download each submodule if such was not downloaded so far. 
        .submodules.upgrade - Upgrade each submodule, checking for available updates for such. 
        .submodules.clean - Delete all downloaded submodules. 
        .clean - Clean current module. Delete genrated artifacts, temp files and downloaded submodules. 
        .clean.what - Find out which files will be deleted by clean command. 
        .build - Build current module with spesified criterion. 
        .export - Export selected the module with spesified criterion. Save output to output file and archive. 
        .with - Use "with" to select a module. 
        .each - Use "each" to iterate each module in a directory.[39;0m[49;0m[39;0m
      
      [30m[43m[35mUse [32m"will .help"[39;0m to get help[39;0m[49;0m[39;0m

[92m         [39;0m[92m 
        D:\work\willbe\proto\dwtools\atop\will.test\WillExternals.test.s:1694
            1690 :     test.case = 'simple run without args'
            1691 :     return shell()
            1692 :     .thenKeep( ( got ) =>
            1693 :     {
            1694 :       test.identical( got.exitCode, 0 ); [39;0m[92m [39;0m
[92m[40m        [49;0m[39;0m[92m[40mTest check[49;0m[39;0m[92m[40m [49;0m[39;0m[92m[40m([49;0m[39;0m[92m[40m Tools[49;0m[39;0m[92m[40m/[49;0m[39;0m[92m[40matop[49;0m[39;0m[92m[40m/[49;0m[39;0m[92m[40mWillExternals [49;0m[39;0m[92m[40m/[49;0m[39;0m[92m[40m submodulesDownload [49;0m[39;0m[92m[40m/[49;0m[39;0m[92m[40m simple run without args[49;0m[39;0m[92m[40m # [49;0m[39;0m[92m[40m1 [49;0m[39;0m[92m[40m)[49;0m[39;0m[92m[40m ... [49;0m[39;0m[92m[40mok[49;0m[39;0m


[92m         [39;0m[92m 
        D:\work\willbe\proto\dwtools\atop\will.test\WillExternals.test.s:1695
            1691 :     return shell()
            1692 :     .thenKeep( ( got ) =>
            1693 :     {
            1694 :       test.identical( got.exitCode, 0 );
            1695 :       test.is( got.output.length ); [39;0m[92m [39;0m
[92m[40m        [49;0m[39;0m[92m[40mTest check[49;0m[39;0m[92m[40m [49;0m[39;0m[92m[40m([49;0m[39;0m[92m[40m Tools[49;0m[39;0m[92m[40m/[49;0m[39;0m[92m[40matop[49;0m[39;0m[92m[40m/[49;0m[39;0m[92m[40mWillExternals [49;0m[39;0m[92m[40m/[49;0m[39;0m[92m[40m submodulesDownload [49;0m[39;0m[92m[40m/[49;0m[39;0m[92m[40m simple run without args[49;0m[39;0m[92m[40m # [49;0m[39;0m[92m[40m2 [49;0m[39;0m[92m[40m)[49;0m[39;0m[92m[40m [49;0m[39;0m[92m[40m:[49;0m[39;0m[92m[40m expected true[49;0m[39;0m[92m[40m ... [49;0m[39;0m[92m[40mok[49;0m[39;0m

      [30m[43m[97m > [39;0mnode D:\work\willbe\proto\dwtools\atop\will\Exec2 .list[49;0m[39;0m
      [30m[43mSIGINT[49;0m[39;0m

[91m         * Message
        Terminated by user   
        
         * Condensed calls stack
            at wTestSuite._testSuiteTerminated (D:\work\willbe\node_modules\wTesting\proto\dwtools\atop\tester\l5\Suite.s:719:15)
            at process.emit (events.js:180:13)
            at process.exit (internal/process.js:147:15)
            at process.<anonymous> (D:\work\willbe\node_modules\wexternalfundamentals\proto\dwtools\abase\l4\External.s:1113:15)
            at process.emit (events.js:180:13)
        
         * Catches stack
            caught at Proxy.exceptionReport @ D:\work\willbe\node_modules\wTesting\proto\dwtools\atop\tester\l5\Routine.s:2243
            caught at Object.cancel @ D:\work\willbe\node_modules\wTesting\proto\dwtools\atop\tester\l5\Tester.s:709
            caught at wTestSuite._testSuiteTerminated @ D:\work\willbe\node_modules\wTesting\proto\dwtools\atop\tester\l5\Suite.s:719
        
         * Source code from D:\work\willbe\node_modules\wTesting\proto\dwtools\atop\tester\l5\Suite.s:719
            718 :   debugger;
            719 :   let err = _.err( 'Terminated by user' );
            720 :   wTester.cancel({ err : err, terminatedByUser : 1, global : 1 });
        [39;0m
[91m[40m        Test check ( Tools/atop/WillExternals / submodulesDownload / list # 3 ) ... failed throwing error[49;0m[39;0m

[91m[40m      Failed [49;0m[39;0m[91m[40mtest routine[49;0m[39;0m[91m[40m [49;0m[39;0m[91m[40m([49;0m[39;0m[91m[40m Tools[49;0m[39;0m[91m[40m/[49;0m[39;0m[91m[40matop[49;0m[39;0m[91m[40m/[49;0m[39;0m[91m[40mWillExternals [49;0m[39;0m[91m[40m/[49;0m[39;0m[91m[40m submodulesDownload [49;0m[39;0m[91m[40m)[49;0m[39;0m[91m[40m in [49;0m[39;0m[91m[40m2.705s[49;0m[39;0m

[91m    Thrown 2 error(s)
    Passed test checks 2 / 4
    Passed test cases 1 / 2
    Passed test routines 0 / 1[39;0m
[91m[40m    Test suite [49;0m[39;0m[91m[40m([49;0m[39;0m[91m[40m Tools[49;0m[39;0m[91m[40m/[49;0m[39;0m[91m[40matop[49;0m[39;0m[91m[40m/[49;0m[39;0m[91m[40mWillExternals [49;0m[39;0m[91m[40m)[49;0m[39;0m[91m[40m ... in[49;0m[39;0m[91m[40m 2.899s[49;0m[39;0m[91m[40m ... [49;0m[39;0m[91m[40mfailed[49;0m[39;0m



[91m  ExitCode : -1
  Thrown 2 error(s)
  Passed test checks 2 / 4
  Passed test cases 1 / 2
  Passed test routines 0 / 1
  Passed test suites 0 / 1[39;0m
[91m[40m  Testing[49;0m[39;0m[91m[40m ... in[49;0m[39;0m[91m[40m 2.964s[49;0m[39;0m[91m[40m ... [49;0m[39;0m[91m[40mfailed[49;0m[39;0m
