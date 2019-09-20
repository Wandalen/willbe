( function _AppBasic_test_s( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wFiles' );

  require( '../l4/AppBasic.s' );

}

/*

qqq :

- reacts on requests ( qqq ) in the module
- use application code from test rouitne shellConcurrent for all test routines, maybe?
- make sure tests works in collection, not only in stand-alone mode

*/

var _global = _global_;
var _ = _global_.wTools;
var Self = {};

// --
// context
// --

function testDirMake()
{
  var context = this;
  if( Config.platform === 'nodejs' )
  context.suitePath = _.path.dirTempOpen( _.path.join( __dirname, '../..'  ), 'ProcessBasic' );
  else
  context.suitePath = _.path.current();
}

//

function testDirClean()
{
  var context = this;
  if( Config.platform === 'nodejs' )
  _.fileProvider.filesDelete( context.suitePath );
}

//

function testApp()
{
  var ended = 0;
  var fs = require( 'fs' );
  var path = require( 'path' );
  var filePath = path.join( __dirname, 'file.txt' );
  console.log( 'begin', process.argv.slice( 2 ).join( ', ' ) );
  var time = parseInt( process.argv[ 2 ] );
  if( isNaN( time ) )
  throw 'Expects number';

  setTimeout( end, time );
  function end()
  {
    ended = 1;
    fs.writeFileSync( filePath, 'written by ' + process.argv[ 2 ] );
    console.log( 'end', process.argv.slice( 2 ).join( ', ' ) );
  }

  setTimeout( periodic, 50 );
  function periodic()
  {
    console.log( 'tick', process.argv.slice( 2 ).join( ', ' ) );
    if( !ended )
    setTimeout( periodic, 50 );
  }

}

//

function testAppShell()
{
  let _ = require( '../../../Tools.s' );
  _.include( 'wAppBasic' );
  _.include( 'wStringsExtra' )

  var args = _.process.args();

  if( args.map.exitWithCode )
  process.exit( args.map.exitWithCode )

  if( args.map.loop )
  return _.timeOut( 4000 )

  console.log( __filename );
}

// --
// test
// --

function appArgs( test )
{
  var _argv =  process.argv.slice( 0, 2 );
  _argv = _.path.s.normalize( _argv );

  /* */

  var argv = [];
  argv.unshift.apply( argv, _argv );
  var got = _.process.args({ argv, caching : 0 });
  var expected =
  {
    interpreterPath : _argv[ 0 ],
    mainPath : _argv[ 1 ],
    interpreterArgs : [],
    keyValDelimeter : ':',
    subject : '',
    map : Object.create( null ),
    scriptArgs : [],
    scriptString : '',
    subjects : [],
    maps : [],
  }
  test.contains( got, expected );

  /* */

  var argv = [ '' ];
  argv.unshift.apply( argv, _argv );
  var got = _.process.args({ argv, caching : 0 });
  var expected =
  {
    interpreterPath : _argv[ 0 ],
    mainPath : _argv[ 1 ],
    interpreterArgs : [],
    keyValDelimeter : ':',
    subject : '',
    map : Object.create( null ),
    scriptArgs : [''],
    scriptString : '',
    subjects : [],
    maps : [],
  }
  test.contains( got, expected );

  /* */

  var argv = [ 'x', ':', 'aa', 'bbb :' ];
  argv.unshift.apply( argv, _argv );
  var got = _.process.args({ argv, caching : 0 });
  var expected =
  {
    interpreterPath : _argv[ 0 ],
    mainPath : _argv[ 1 ],
    interpreterArgs : [],
    keyValDelimeter : ':',
    map : { x : 'aa', bbb : '' },
    subject : '',
    scriptArgs : [ 'x', ':', 'aa', 'bbb :' ]
  }
  test.contains( got, expected );

  /* */

  var argv = [ 'x', ' : ', 'y' ];
  argv.unshift.apply( argv, _argv );
  var got = _.process.args({ argv, caching : 0 });
  var expected =
  {
    interpreterPath : _argv[ 0 ],
    mainPath : _argv[ 1 ],
    interpreterArgs : [],
    keyValDelimeter : ':',
    map : { x : 'y' },
    subject : '',
    scriptArgs :[ 'x', ' : ', 'y' ]
  }
  test.contains( got, expected );

  /* */

  var argv = [ 'x', ' :', 'y', 'x', ' :', '1' ];
  argv.unshift.apply( argv, _argv );
  var got = _.process.args({ argv, caching : 0 });
  var expected =
  {
    interpreterPath : _argv[ 0 ],
    mainPath : _argv[ 1 ],
    interpreterArgs : [],
    keyValDelimeter : ':',
    map : { x : 1 },
    subject : '',
    scriptArgs : [ 'x', ' :', 'y', 'x', ' :', '1']
  }
  test.contains( got, expected );

  /* */

  var argv = [ 'a b c d', 'x', ' :', 'y', 'xyz', 'y', ' :', 1 ];
  argv.unshift.apply( argv, _argv );
  var got = _.process.args({ argv, caching : 0 });
  var expected =
  {
    interpreterPath : _argv[ 0 ],
    mainPath : _argv[ 1 ],
    interpreterArgs : [],
    keyValDelimeter : ':',
    map : { x : 'y xyz', y : 1 },
    subject : 'a b c d',
    scriptArgs : [ 'a b c d', 'x', ' :', 'y', 'xyz', 'y', ' :', 1 ]
  }
  test.contains( got, expected );

  /* */

  var argv =
  [
    'filePath',
    'a :', 1,
    'b', ' :2',
    'c :  ', 3,
    'd', ' :  4',
    'e', ' :  ', 5
  ];
  argv.unshift.apply( argv, _argv );
  var got = _.process.args({ argv, caching : 0 });
  var expected =
  {
    interpreterPath : _argv[ 0 ],
    mainPath : _argv[ 1 ],
    interpreterArgs : [],
    keyValDelimeter : ':',
    map : { a : 1, b : 2, c : 3, d : 4, e : 5 },
    subject : 'filePath',
    scriptArgs :
    [
      'filePath',
      'a :', 1,
      'b', ' :2',
      'c :  ', 3,
      'd', ' :  4',
      'e', ' :  ', 5
    ]
  }
  test.contains( got, expected );

  /* */

  var argv = [ 'a :b :c :d', 'x', ' :', 0, 'y', ' :', 1 ];
  argv.unshift.apply( argv, _argv );
  var got = _.process.args({ argv, caching : 0 });
  var expected =
  {
    interpreterPath : _argv[ 0 ],
    mainPath : _argv[ 1 ],
    interpreterArgs : [],
    keyValDelimeter : ':',
    map : { a : '', b : '', c : 'd', x : 0, y : 1 },
    subject : '',
    scriptArgs : [ 'a :b :c :d', 'x', ' :', 0, 'y', ' :', 1 ]
  }
  test.contains( got, expected );

  /* */

  var argv = [];
  var got = _.process.args({ argv : [ 'interpreter', 'main.js', '.set v:5 ; .build debug:1 ; .export' ], caching : 0 });
  var expected =
  {
    interpreterPath : 'interpreter',
    mainPath : 'main.js',
    interpreterArgs : [],
    keyValDelimeter : ':',
    cmmandsDelimeter : ';',
    subject : '.set',
    map : { v : 5 },
    scriptArgs : [ '.set v:5 ; .build debug:1 ; .export' ],
    scriptString : '.set v:5 ; .build debug:1 ; .export',
    subjects : [ '.set', '.build', '.export' ],
    maps : [ { v : 5 }, { debug : 1 }, {} ],
  }
  test.contains( got, expected );

  /* */

  var argv = [];
  var got = _.process.args({ argv : [ 'interpreter', 'main.js', '.set v:[1 2  3 ] ; .build debug:1 ; .export' ], caching : 0 });
  var expected =
  {
    interpreterPath : 'interpreter',
    mainPath : 'main.js',
    interpreterArgs : [],
    keyValDelimeter : ':',
    cmmandsDelimeter : ';',
    subject : '.set',
    map : { v : [ 1,2,3 ] },
    scriptArgs : [ '.set v:[1 2  3 ] ; .build debug:1 ; .export' ],
    scriptString : '.set v:[1 2  3 ] ; .build debug:1 ; .export',
    subjects : [ '.set', '.build', '.export' ],
    maps : [ { v : [ 1,2,3 ] }, { debug : 1 }, {} ],
  }
  test.contains( got, expected );

  /* */

  test.case = 'windows native path as option, no quotes'
  var argv = [];
  var got = _.process.args({ argv : [ 'interpreter', 'main.js', 'path:D:\\path\\to\\file' ], caching : 0 });
  var expected =
  {
    interpreterPath : 'interpreter',
    mainPath : 'main.js',
    interpreterArgs : [],
    keyValDelimeter : ':',
    cmmandsDelimeter : ';',
    subject : '',
    map : { path : '', D : '\\path\\to\\file' },
    scriptArgs : [ 'path:D:\\path\\to\\file' ],
    scriptString : 'path:D:\\path\\to\\file',
    subjects : [ '' ],
    maps : [ { path : '', D : '\\path\\to\\file' } ],
  }
  test.contains( got, expected );

  test.case = 'windows native path as option, with quotes'
  var argv = [];
  var got = _.process.args({ argv : [ 'interpreter', 'main.js', 'path:"D:\\path\\to\\file"' ], caching : 0 });
  var expected =
  {
    interpreterPath : 'interpreter',
    mainPath : 'main.js',
    interpreterArgs : [],
    keyValDelimeter : ':',
    cmmandsDelimeter : ';',
    subject : '',
    map : { path : 'D:\\path\\to\\file' },
    scriptArgs : [ 'path:"D:\\path\\to\\file"' ],
    scriptString : 'path:"D:\\path\\to\\file"',
    subjects : [ '' ],
    maps : [ { path : 'D:\\path\\to\\file' } ],
  }
  test.contains( got, expected );

  test.case = 'number option with quotes'
  var argv = [];
  var got = _.process.args({ argv : [ 'interpreter', 'main.js', 'v:"10"' ], caching : 0 });
  var expected =
  {
    interpreterPath : 'interpreter',
    mainPath : 'main.js',
    interpreterArgs : [],
    keyValDelimeter : ':',
    cmmandsDelimeter : ';',
    subject : '',
    map : { v : 10 },
    scriptArgs : [ 'v:"10"' ],
    scriptString : 'v:"10"',
    subjects : [ '' ],
    maps : [ { v : 10 } ],
  }
  test.contains( got, expected );

  test.case = 'string option with quotes'
  var argv = [];
  var got = _.process.args({ argv : [ 'interpreter', 'main.js', 'str:"abc"' ], caching : 0 });
  var expected =
  {
    interpreterPath : 'interpreter',
    mainPath : 'main.js',
    interpreterArgs : [],
    keyValDelimeter : ':',
    cmmandsDelimeter : ';',
    subject : '',
    map : { str : 'abc' },
    scriptArgs : [ 'str:"abc"' ],
    scriptString : 'str:"abc"',
    subjects : [ '' ],
    maps : [ { str : 'abc' } ],
  }
  test.contains( got, expected );

}

//

function appExitHandlerOnce( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );
  var commonDefaults =
  {
    outputPiping : 1,
    outputCollecting : 1,
    applyingExitCode : 0,
    throwingExitCode : 1,
    sync : 1
  }

  function testApp()
  {
    let _ = require( '../../../Tools.s' );
    _.include( 'wAppBasic' );
    _.include( 'wStringsExtra' )

    var args = _.process.args();

    _.process.exitHandlerOnce( ( arg ) =>
    {
      console.log( 'appExitHandlerOnce:', arg );
    });

    _.timeOut( 1000, () =>
    {
      console.log( 'timeOut handler executed' );
      return 1;
    })

    if( args.map.terminate )
    process.exit( 'SIGINT' );

  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  var expectedOutput = testAppPath + '\n';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  var o;
  var con = new _.Consequence().take( null )


  /*  */

  .thenKeep( () =>
  {
    var o =
    {
      execPath :  'node ' + testAppPath,
      mode : 'spawn',
      stdio : 'pipe',
      sync : 0,
      outputPiping : 1,
      outputCollecting : 1,
    }

    return _.process.start( o )
    .thenKeep( ( got ) =>
    {
      test.is( got.exitCode === 0 );
      test.is( _.strHas( got.output, 'timeOut handler executed' ) )
      test.is( _.strHas( got.output, 'appExitHandlerOnce: 0' ) );
      return null;
    })

  })

  .thenKeep( () =>
  {
    var o =
    {
      execPath :  'node ' + testAppPath + ' terminate : 1',
      mode : 'spawn',
      stdio : 'pipe',
      sync : 0,
      outputPiping : 1,
      outputCollecting : 1,
    }

    return _.process.start( o )
    .thenKeep( ( got ) =>
    {
      test.is( got.exitCode === 0 );
      test.is( !_.strHas( got.output, 'timeOut handler executed' ) )
      test.is( !_.strHas( got.output, 'appExitHandlerOnce: 0' ) );
      test.is( _.strHas( got.output, 'appExitHandlerOnce: SIGINT' ) );
      return null;
    });
  })

  return con;
}

//

function shell( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );
  var commonDefaults =
  {
    outputPiping : 1,
    outputCollecting : 1,
    applyingExitCode : 0,
    throwingExitCode : 1
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = context.testAppShell.toString() + '\ntestAppShell();';
  var expectedOutput = testAppPath + '\n';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  var o;
  var con = new _.Consequence().take( null );

  con.thenKeep( function()
  {
    test.case = 'mode : spawn';

    o =
    {
      execPath :  'node ' + testAppPath,
      mode : 'spawn',
      stdio : 'pipe'
    }

    return null;
  })
  .thenKeep( function( arg )
  {
    /* mode : spawn, stdio : pipe */

    var options = _.mapSupplement( {}, o, commonDefaults );

    return _.process.start( options )
    .thenKeep( function()
    {
      test.identical( options.exitCode, 0 );
      test.identical( options.output, expectedOutput );
      return null;
    })
  })
  .thenKeep( function( arg )
  {
    /* mode : spawn, stdio : ignore */

    o.stdio = 'ignore';
    var options = _.mapSupplement( {}, o, commonDefaults );

    return _.process.start( options )
    .thenKeep( function()
    {
      test.identical( options.exitCode, 0 );
      test.identical( options.output.length, 0 );
      return null;
    })
  })
  // .thenKeep( function( arg )
  // {
  //   /* mode : spawn, stdio : inherit */

  //   o.stdio = 'inherit';

  //   var options = _.mapSupplement( {}, o, commonDefaults );

  //   return _.process.start( options )
  //   .thenKeep( function()
  //   {
  //     test.identical( options.exitCode, 0 );
  //     test.identical( options.output.length, 0 );
  //   })
  // })
  .thenKeep( function( arg )
  {
    test.case = 'mode : shell';

    o =
    {
      execPath :  'node ' + testAppPath,
      mode : 'shell',
      stdio : 'pipe'
    }
    return null;
  })
  .thenKeep( function( arg )
  {
    /* mode : shell, stdio : pipe */

    var options = _.mapSupplement( {}, o, commonDefaults );

    return _.process.start( options )
    .thenKeep( function()
    {
      test.identical( options.exitCode, 0 );
      test.identical( options.output, expectedOutput );
      return null;
    })
  })
  .thenKeep( function( arg )
  {
    /* mode : shell, stdio : ignore */

    o.stdio = 'ignore'

    var options = _.mapSupplement( {}, o, commonDefaults );

    return _.process.start( options )
    .thenKeep( function()
    {
      test.identical( options.exitCode, 0 );
      test.identical( options.output.length, 0 );
      return null;
    })
  })
  // .thenKeep( function( arg )
  // {
  //   /* mode : shell, stdio : inherit */

  //   o.stdio = 'inherit'

  //   var options = _.mapSupplement( {}, o, commonDefaults );

  //   return _.process.start( options )
  //   .thenKeep( function()
  //   {
  //     test.identical( options.exitCode, 0 );
  //     test.identical( options.output.length, 0 );
  //   })
  // })
  .thenKeep( function( arg )
  {
    test.case = 'spawn, stop process using kill';

    o =
    {
      execPath :  'node ' + testAppPath + ' loop : 1',
      mode : 'spawn',
      stdio : 'pipe'
    }

    var options = _.mapSupplement( {}, o, commonDefaults );

    var shell = _.process.start( options );
    _.timeOut( 500, () =>
    {
      test.identical( options.process.killed, false );
      options.process.kill( 'SIGINT' );
      return null;
    })
    shell.finally(function()
    {
      test.identical( options.process.killed, true );
      test.identical( !options.exitCode, true );
      return null;
    })

    return shell;
  })
  .thenKeep( function( arg )
  {
    test.case = 'shell, stop process using kill';

    o =
    {
      execPath :  'node ' + testAppPath + ' loop : 1',
      mode : 'shell',
      stdio : 'pipe'
    }

    var options = _.mapSupplement( {}, o, commonDefaults );

    var shell = _.process.start( options );
    _.timeOut( 500, () =>
    {
      test.identical( options.process.killed, false );
      options.process.kill( 'SIGINT' );
      return null;
    })
    shell.finally(function()
    {
      test.identical( options.process.killed, true );
      test.identical( !options.exitCode, true );
      return null;
    })

    return shell;
  })
  .thenKeep( function( arg )
  {
    test.case = 'spawn, return good code';

    o =
    {
      execPath :  'node ' + testAppPath + ' exitWithCode : 0',
      mode : 'spawn',
      stdio : 'pipe'
    }

    var options = _.mapSupplement( {}, o, commonDefaults );

    return test.mustNotThrowError( _.process.start( options ) )
    .thenKeep( () =>
    {
      test.identical( options.exitCode, 0 );
      return null;
    });
  })
  .thenKeep( function( arg )
  {
    test.case = 'spawn, return bad code';

    o =
    {
      execPath :  'node ' + testAppPath + ' exitWithCode : 1',
      mode : 'spawn',
      stdio : 'pipe'
    }

    var options = _.mapSupplement( {}, o, commonDefaults );

    return test.shouldThrowErrorOfAnyKind( _.process.start( options ) )
    .thenKeep( () =>
    {
      test.identical( options.exitCode, 1 );
      return null;
    });
  })
  .thenKeep( function( arg )
  {
    test.case = 'shell, return good code';

    o =
    {
      execPath :  'node ' + testAppPath + ' exitWithCode : 0',
      mode : 'shell',
      stdio : 'pipe'
    }

    var options = _.mapSupplement( {}, o, commonDefaults );

    return test.mustNotThrowError( _.process.start( options ) )
    .thenKeep( () =>
    {
      test.identical( options.exitCode, 0 );
      return null;
    });
  })
  .thenKeep( function( arg )
  {
    test.case = 'shell, return bad code';

    o =
    {
      execPath :  'node ' + testAppPath + ' exitWithCode : 1',
      mode : 'shell',
      stdio : 'pipe'
    }

    var options = _.mapSupplement( {}, o, commonDefaults );

    return test.shouldThrowErrorOfAnyKind( _.process.start( options ) )
    .thenKeep( () =>
    {
      test.identical( options.exitCode, 1 );
      return null;
    });
  })
  //
  // test.case = 'test';
  // test.identical( 0, 0 );

  // con
  // .thenKeep( function( arg )
  // {
  //   test.case = 'simple command';
  //   var con = _.process.start( 'exit' );
  //   return test.shouldMessageOnlyOnce( con );
  // })
  // .thenKeep( function( arg )
  // {
  //   test.case = 'bad command, shell';
  //   var con = _.process.start({ code : 'xxx', throwingExitCode : 1, mode : 'shell' });
  //   return test.shouldThrowErrorSync( con );
  // })
  // .thenKeep( function( arg )
  // {
  //   test.case = 'bad command, spawn';
  //   var con = _.process.start({ code : 'xxx', throwingExitCode : 1, mode : 'spawn' });
  //   return test.shouldThrowErrorSync( con );
  // })
  // .thenKeep( function( arg )
  // {
  //   test.case = 'several arguments';
  //   var con = _.process.start( 'echo echo something' );
  //   return test.mustNotThrowError( con );
  // })
  // ;

  // con.thenKeep( () =>  _.fileProvider.fileDelete( testAppPath ) );

  .thenKeep( function( arg )
  {
    test.case = 'shell, stop using timeOut';

    o =
    {
      execPath :  'node ' + testAppPath + ' loop : 1',
      mode : 'shell',
      stdio : 'pipe',
      timeOut : 500
    }

    var options = _.mapSupplement( {}, o, commonDefaults );

    var shell = _.process.start( options );
    return test.shouldThrowErrorAsync( shell )
    .thenKeep( () =>
    {
      test.identical( options.process.killed, true );
      test.identical( !options.exitCode, true );
      return null;
    })
  })


  return con;
}

shell.timeOut = 30000;

//

function shellSync( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );
  var commonDefaults =
  {
    outputPiping : 1,
    outputCollecting : 1,
    applyingExitCode : 0,
    throwingExitCode : 1,
    sync : 1
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = context.testAppShell.toString() + '\ntestAppShell();';
  var expectedOutput = testAppPath + '\n';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  var o;

  //

  test.case = 'mode : spawn';
  o =
  {
    execPath :  'node ' + testAppPath,
    mode : 'spawn',
    stdio : 'pipe'
  }

  /* mode : spawn, stdio : pipe */

  var options = _.mapSupplement( {}, o, commonDefaults );
  _.process.start( options )
  test.identical( options.exitCode, 0 );
  test.identical( options.output, expectedOutput );

  /* mode : spawn, stdio : ignore */

  o.stdio = 'ignore';
  var options = _.mapSupplement( {}, o, commonDefaults );
  _.process.start( options )
  test.identical( options.exitCode, 0 );
  test.identical( options.output.length, 0 );

  //

  test.case = 'mode : shell';
  o =
  {
    execPath :  'node ' + testAppPath,
    mode : 'shell',
    stdio : 'pipe'
  }
  var options = _.mapSupplement( {}, o, commonDefaults );
  _.process.start( options )
  test.identical( options.exitCode, 0 );
  test.identical( options.output, expectedOutput );

  /* mode : shell, stdio : ignore */

  o.stdio = 'ignore'
  var options = _.mapSupplement( {}, o, commonDefaults );
  _.process.start( options )
  test.identical( options.exitCode, 0 );
  test.identical( options.output.length, 0 );

  //

  test.case = 'shell, stop process using timeOut';
  o =
  {
    execPath :  'node ' + testAppPath + ' loop : 1',
    mode : 'shell',
    stdio : 'pipe',
    timeOut : 500
  }

  var options = _.mapSupplement( {}, o, commonDefaults );
  test.shouldThrowErrorSync( () => _.process.start( options ) );

  //

  test.case = 'spawn, return good code';
  o =
  {
    execPath :  'node ' + testAppPath + ' exitWithCode : 0',
    mode : 'spawn',
    stdio : 'pipe'
  }
  var options = _.mapSupplement( {}, o, commonDefaults );
  test.mustNotThrowError( () => _.process.start( options ) )
  test.identical( options.exitCode, 0 );

  //

  test.case = 'spawn, return bad code';
  o =
  {
    execPath :  'node ' + testAppPath + ' exitWithCode : 1',
    mode : 'spawn',
    stdio : 'pipe'
  }
  var options = _.mapSupplement( {}, o, commonDefaults );
  test.shouldThrowErrorSync( () => _.process.start( options ) )
  test.identical( options.exitCode, 1 );

  //

  test.case = 'shell, return good code';
  o =
  {
    execPath :  'node ' + testAppPath + ' exitWithCode : 0',
    mode : 'shell',
    stdio : 'pipe'
  }

  var options = _.mapSupplement( {}, o, commonDefaults );
  test.mustNotThrowError( () => _.process.start( options ) )
  test.identical( options.exitCode, 0 );

  //

  test.case = 'shell, return bad code';
  o =
  {
    execPath :  'node ' + testAppPath + ' exitWithCode : 1',
    mode : 'shell',
    stdio : 'pipe'
  }
  var options = _.mapSupplement( {}, o, commonDefaults );
  test.shouldThrowErrorSync( () => _.process.start( options ) )
  test.identical( options.exitCode, 1 );

}

shellSync.timeOut = 30000;

//

function shellSyncAsync( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );
  var commonDefaults =
  {
    outputPiping : 1,
    outputCollecting : 1,
    applyingExitCode : 0,
    throwingExitCode : 1,
    sync : 1,
    deasync : 1
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = context.testAppShell.toString() + '\ntestAppShell();';
  var expectedOutput = testAppPath + '\n';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  var o;

  //

  test.case = 'mode : fork';
  o =
  {
    execPath : testAppPath,
    mode : 'fork',
    stdio : 'pipe'
  }

  /* mode : spawn, stdio : pipe */

  var options = _.mapSupplement( {}, o, commonDefaults );
  var got = _.process.start( options );
  test.is( got === options );
  test.identical( got.process.constructor.name, 'ChildProcess' );
  test.identical( options.exitCode, 0 );
  test.identical( options.output, expectedOutput );

  /* mode : fork, stdio : ignore */

  o.stdio = 'ignore';
  var options = _.mapSupplement( {}, o, commonDefaults );
  var got = _.process.start( options );
  test.is( got === options );
  test.identical( got.process.constructor.name, 'ChildProcess' );
  test.identical( options.exitCode, 0 );
  test.identical( options.output.length, 0 );

  //

  test.case = 'mode : spawn';
  o =
  {
    execPath :  'node ' + testAppPath,
    mode : 'spawn',
    stdio : 'pipe'
  }

  /* mode : spawn, stdio : pipe */

  var options = _.mapSupplement( {}, o, commonDefaults );
  var got = _.process.start( options );
  test.is( got === options );
  test.identical( got.process.constructor.name, 'ChildProcess' );
  test.identical( options.exitCode, 0 );
  test.identical( options.output, expectedOutput );

  /* mode : spawn, stdio : ignore */

  o.stdio = 'ignore';
  var options = _.mapSupplement( {}, o, commonDefaults );
  var got = _.process.start( options );
  test.is( got === options );
  test.identical( got.process.constructor.name, 'ChildProcess' );
  test.identical( options.exitCode, 0 );
  test.identical( options.output.length, 0 );

  //

  test.case = 'mode : shell';
  o =
  {
    execPath :  'node ' + testAppPath,
    mode : 'shell',
    stdio : 'pipe'
  }
  var options = _.mapSupplement( {}, o, commonDefaults );
  var got = _.process.start( options );
  test.is( got === options );
  test.identical( got.process.constructor.name, 'ChildProcess' );
  test.identical( options.exitCode, 0 );
  test.identical( options.output, expectedOutput );

  /* mode : shell, stdio : ignore */

  o.stdio = 'ignore'
  var options = _.mapSupplement( {}, o, commonDefaults );
  var got = _.process.start( options );
  test.is( got === options );
  test.identical( got.process.constructor.name, 'ChildProcess' );
  test.identical( options.exitCode, 0 );
  test.identical( options.output.length, 0 );

  //

  test.case = 'shell, stop process using timeOut';
  o =
  {
    execPath :  'node ' + testAppPath + ' loop : 1',
    mode : 'shell',
    stdio : 'pipe',
    timeOut : 500
  }

  var options = _.mapSupplement( {}, o, commonDefaults );
  test.shouldThrowErrorSync( () => _.process.start( options ) );

  //

  test.case = 'spawn, return good code';
  o =
  {
    execPath :  'node ' + testAppPath + ' exitWithCode : 0',
    mode : 'spawn',
    stdio : 'pipe'
  }
  var options = _.mapSupplement( {}, o, commonDefaults );
  var got = _.process.start( options );
  test.is( got === options );
  test.identical( got.process.constructor.name, 'ChildProcess' );
  test.identical( options.exitCode, 0 );

  //

  test.case = 'spawn, return bad code';
  o =
  {
    execPath :  'node ' + testAppPath + ' exitWithCode : 1',
    mode : 'spawn',
    stdio : 'pipe'
  }
  var options = _.mapSupplement( {}, o, commonDefaults );
  test.shouldThrowErrorSync( () => _.process.start( options ) )
  test.identical( options.exitCode, 1 );

  //

  test.case = 'shell, return good code';
  o =
  {
    execPath :  'node ' + testAppPath + ' exitWithCode : 0',
    mode : 'shell',
    stdio : 'pipe'
  }

  var options = _.mapSupplement( {}, o, commonDefaults );
  var got = _.process.start( options );
  test.is( got === options );
  test.identical( got.process.constructor.name, 'ChildProcess' );
  test.identical( options.exitCode, 0 );

  //

  test.case = 'shell, return bad code';
  o =
  {
    execPath :  'node ' + testAppPath + ' exitWithCode : 1',
    mode : 'shell',
    stdio : 'pipe'
  }
  var options = _.mapSupplement( {}, o, commonDefaults );
  test.shouldThrowErrorSync( () => _.process.start( options ) )
  test.identical( options.exitCode, 1 );

}

shellSyncAsync.timeOut = 30000;

//

function shell2( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );
  var commonDefaults =
  {
    outputPiping : 1,
    outputCollecting : 1,
    applyingExitCode : 0,
    throwingExitCode : 1
  }

  /* */

  function testApp()
  {
    console.log( process.argv.slice( 2 ).join( ' ' ) );
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  var o;
  var con = new _.Consequence().take( null );

  con.thenKeep( function()
  {
    test.case = 'mode : shell';

    o =
    {
      execPath :  'node ' + testAppPath,
      args : [ 'staging', 'debug' ],
      mode : 'shell',
      stdio : 'pipe'
    }
    return null;
  })
  .thenKeep( function( arg )
  {
    /* mode : shell, stdio : pipe */

    var options = _.mapSupplement( {}, _.cloneJust( o ), commonDefaults );

    return _.process.start( options )
    .thenKeep( function()
    {
      test.identical( options.exitCode, 0 );
      test.identical( options.output, o.args.join( ' ' ) + '\n' );
      return null;
    })
  })

  //

  con.thenKeep( function()
  {
    test.case = 'mode : shell, passingThrough : true, no args';

    o =
    {
      execPath :  'node ' + testAppPath,
      mode : 'shell',
      passingThrough : 1,
      stdio : 'pipe'
    }

    return null;
  })
  .thenKeep( function( arg )
  {
    /* mode : shell, stdio : pipe, passingThrough : true */

    var options = _.mapSupplement( {}, o, commonDefaults );

    return _.process.start( options )
    .thenKeep( function()
    {
      test.identical( options.exitCode, 0 );
      var expectedArgs= _.arrayAppendArray( [], process.argv.slice( 2 ) );
      test.identical( options.output, expectedArgs.join( ' ' ) + '\n' );
      return null;
    })
  })

  //

  con.thenKeep( function()
  {
    test.case = 'mode : spawn, passingThrough : true, only filePath in args';

    o =
    {
      execPath :  'node',
      args : [ testAppPath ],
      mode : 'spawn',
      passingThrough : 1,
      stdio : 'pipe'
    }
    return null;
  })
  .thenKeep( function( arg )
  {
    /* mode : spawn, stdio : pipe, passingThrough : true */

    var options = _.mapSupplement( {}, o, commonDefaults );

    return _.process.start( options )
    .thenKeep( function()
    {
      test.identical( options.exitCode, 0 );
      var expectedArgs = _.arrayAppendArray( [], process.argv.slice( 2 ) );
      test.identical( options.output, expectedArgs.join( ' ' ) + '\n' );
      return null;
    })
  })

  //

  con.thenKeep( function()
  {
    test.case = 'mode : spawn, passingThrough : true, incorrect usage of o.path in spawn mode';

    o =
    {
      execPath :  'node ' + testApp,
      args : [ 'staging' ],
      mode : 'spawn',
      passingThrough : 1,
      stdio : 'pipe'
    }
    return null;
  })
  .thenKeep( function( arg )
  {
    var options = _.mapSupplement( {}, o, commonDefaults );
    return test.shouldThrowErrorOfAnyKind( _.process.start( options ) );
  })

  //

  con.thenKeep( function()
  {
    test.case = 'mode : shell, passingThrough : true';

    o =
    {
      execPath :  'node ' + testAppPath,
      args : [ 'staging', 'debug' ],
      mode : 'shell',
      passingThrough : 1,
      stdio : 'pipe'
    }
    return null;
  })
  .thenKeep( function( arg )
  {
    /* mode : shell, stdio : pipe, passingThrough : true */

    var options = _.mapSupplement( {}, o, commonDefaults );

    return _.process.start( options )
    .thenKeep( function()
    {
      test.identical( options.exitCode, 0 );
      var expectedArgs = _.arrayAppendArray( [ 'staging', 'debug' ], process.argv.slice( 2 ) );
      test.identical( options.output, expectedArgs.join( ' ' ) + '\n');
      return null;
    })
  })

  return con;
}

shell2.timeOut = 30000;

//

function shellCurrentPath( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );

  /* */

  function testApp()
  {
    debugger
    console.log( process.cwd() ); /* qqq : should not be visible if verbosity of tester is low, if possible */
    if( process.send )
    process.send({ currentPath : process.cwd() })
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  var expectedOutput = __dirname + '\n'
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  //

  var con = new _.Consequence().take( null );

  con.thenKeep( function()
  {
    test.case = 'mode : shell';

    let o =
    {
      execPath :  'node ' + testAppPath,
      currentPath : __dirname,
      mode : 'shell',
      stdio : 'pipe',
      outputCollecting : 1,
    }
    return _.process.start( o )
    .thenKeep( function( got )
    {
      test.identical( o.output, expectedOutput );
      return null;
    })
  })

  /**/

  con.thenKeep( function()
  {
    test.case = 'mode : spawn';

    let o =
    {
      execPath :  'node ' + testAppPath,
      currentPath : __dirname,
      mode : 'spawn',
      stdio : 'pipe',
      outputCollecting : 1,
    }
    return _.process.start( o )
    .thenKeep( function( got )
    {
      test.identical( o.output, expectedOutput );
      return null;
    })
  })

  /**/

  con.thenKeep( function()
  {
    test.case = 'mode : exec';

    let o =
    {
      execPath :  'node ' + testAppPath,
      currentPath : __dirname,
      mode : 'exec',
      stdio : 'pipe',
      outputCollecting : 1,
    }
    return _.process.start( o )
    .thenKeep( function( got )
    {
      test.identical( o.output, expectedOutput );
      return null;
    })
  })

  /**/

  con.thenKeep( function()
  {
    test.case = 'mode : fork';

    let output;

    let o =
    {
      execPath : testAppPath,
      currentPath : __dirname,
      mode : 'fork',
    }
    let con = _.process.start( o );
    o.process.on( 'message', ( m ) =>
    {
      output = m;
    })
    con.thenKeep( function( got )
    {
      test.identical( output.currentPath, __dirname );
      return null;
    })

    return con;
  })

  return con;
}

shellCurrentPath.timeOut = 30000;

//

function shellCurrentPaths( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );

  /* */

  function testApp()
  {
    debugger
    console.log( process.cwd() ); /* qqq : should not be visible if verbosity of tester is low, if possible */
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  var expectedOutput = __dirname + '\n'
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  let ready = new _.Consequence().take( null );

  let o2 =
  {
    execPath : 'node ' + testAppPath,
    ready,
    currentPath : [ routinePath, __dirname ],
    stdio : 'pipe',
    outputCollecting : 1
  }

  /* */

  _.process.start( _.mapSupplement( { mode : 'shell' }, o2 ) );

  ready.then( ( got ) =>
  {
    let o1 = got[ 0 ];
    let o2 = got[ 1 ];

    test.is( _.strHas( o1.output, _.path.nativize( routinePath ) ) );
    test.identical( o1.exitCode, 0 );

    test.is( _.strHas( o2.output, __dirname ) );
    test.identical( o2.exitCode, 0 );

    return got;
  })

  /* */

  _.process.start( _.mapSupplement( { mode : 'spawn' }, o2 ) );

  ready.then( ( got ) =>
  {
    let o1 = got[ 0 ];
    let o2 = got[ 1 ];

    test.is( _.strHas( o1.output, _.path.nativize( routinePath ) ) );
    test.identical( o1.exitCode, 0 );

    test.is( _.strHas( o2.output, __dirname ) );
    test.identical( o2.exitCode, 0 );

    return got;
  })

  /* */

  _.process.start( _.mapSupplement( { mode : 'exec' }, o2 ) );

  ready.then( ( got ) =>
  {
    let o1 = got[ 0 ];
    let o2 = got[ 1 ];

    test.is( _.strHas( o1.output, _.path.nativize( routinePath ) ) );
    test.identical( o1.exitCode, 0 );

    test.is( _.strHas( o2.output, __dirname ) );
    test.identical( o2.exitCode, 0 );

    return got;
  })

  /* */

  _.process.start( _.mapSupplement( { mode : 'fork', execPath : testAppPath }, o2 ) );

  ready.then( ( got ) =>
  {
    let o1 = got[ 0 ];
    let o2 = got[ 1 ];

    test.is( _.strHas( o1.output, _.path.nativize( routinePath ) ) );
    test.identical( o1.exitCode, 0 );

    test.is( _.strHas( o2.output, __dirname ) );
    test.identical( o2.exitCode, 0 );

    return got;
  })

  /*  */

  _.process.start( _.mapSupplement( { mode : 'spawn', execPath : [ 'node ' + testAppPath, 'node ' + testAppPath ] }, o2 ) );

  ready.then( ( got ) =>
  {
    let o1 = got[ 0 ];
    let o2 = got[ 1 ];
    let o3 = got[ 2 ];
    let o4 = got[ 3 ];

    test.is( _.strHas( o1.output, _.path.nativize( routinePath ) ) );
    test.identical( o1.exitCode, 0 );

    test.is( _.strHas( o2.output, __dirname ) );
    test.identical( o2.exitCode, 0 );

    test.is( _.strHas( o3.output, _.path.nativize( routinePath ) ) );
    test.identical( o3.exitCode, 0 );

    test.is( _.strHas( o4.output, __dirname ) );
    test.identical( o4.exitCode, 0 );

    return got;
  })

  return ready;
}

//

/*

  qqq : investigate please
  test routine shellFork causes

 1: node::DecodeWrite
 2: node::Start
 3: v8::RetainedObjectInfo::~RetainedObjectInfo
 4: uv_loop_size
 5: uv_disable_stdio_inheritance
 6: uv_dlerror
 7: uv_run
 8: node::CreatePlatform
 9: node::CreatePlatform
10: node::Start
11: v8_inspector::protocol::Runtime::API::StackTrace::fromJSONString
12: BaseThreadInitThunk
13: RtlUserThreadStart

*/


function shellFork( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );

  /* */

  function testApp()
  {
    console.log( process.argv.slice( 2 ) );
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  var expectedOutput = __dirname + '\n'
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  //

  var con = new _.Consequence().take( null );

  con.thenKeep( function()
  {
    test.case = 'no args';

    let o =
    {
      execPath :   testAppPath,
      args : null,
      mode : 'fork',
      stdio : 'pipe',
      outputCollecting : 1,
      outputPiping : 1,
    }
    return _.process.start( o )
    .thenKeep( function( got )
    {
      test.identical( o.exitCode, 0 );
      test.is( _.strHas( o.output, '[]' ) );
      return null;
    })
  })

  //

  con.thenKeep( function()
  {
    test.case = 'args';

    let o =
    {
      execPath :   testAppPath,
      args : [ 'arg1', 'arg2' ],
      mode : 'fork',
      stdio : 'pipe',
      outputCollecting : 1,
      outputPiping : 1,
    }
    return _.process.start( o )
    .thenKeep( function( got )
    {
      test.identical( o.exitCode, 0 );
      test.is( _.strHas( o.output,  "[ 'arg1', 'arg2' ]" ) );
      return null;
    })
  })

  //

  // con.thenKeep( function()
  // {
  //   test.case = 'stdio : inherit';

  //   let o =
  //   {
  //     execPath :   testAppPath,
  //     args : [ 'arg1', 'arg2' ],
  //     mode : 'fork',
  //     stdio : 'inherit',
  //     outputCollecting : 1,
  //     outputPiping : 1,
  //   }

  //   return _.process.start( o )
  //   .thenKeep( function( got )
  //   {
  //     test.identical( o.exitCode, 0 );
  //     test.identical( o.output.length, 0 );
  //     return null;
  //   })
  // })

  //

  con.thenKeep( function()
  {
    test.case = 'stdio : ignore';

    let o =
    {
      execPath :   testAppPath,
      args : [ 'arg1', 'arg2' ],
      mode : 'fork',
      stdio : 'ignore',
      outputCollecting : 1,
      outputPiping : 1,
    }

    return _.process.start( o )
    .thenKeep( function( got )
    {
      test.identical( o.exitCode, 0 );
      test.identical( o.output.length, 0 );
      return null;
    })
  })

  //

  con.thenKeep( function()
  {
    test.case = 'complex';

    function testApp2()
    {
      console.log( process.argv.slice( 2 ) );
      console.log( process.env );
      console.log( process.cwd() );
      console.log( process.execArgv );
    }

    let testAppPath2 = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp2.js' ) );
    var testApp2 = testApp2.toString() + '\ntestApp2();';
    _.fileProvider.fileWrite( testAppPath2, testApp2 );

    let o =
    {
      execPath :   testAppPath2,
      currentPath : routinePath,
      env : { 'key1' : 'val' },
      args : [ 'arg1', 'arg2' ],
      interpreterArgs : [ '--no-warnings' ],
      mode : 'fork',
      stdio : 'pipe',
      outputCollecting : 1,
      outputPiping : 1,
    }
    return _.process.start( o )
    .thenKeep( function( got )
    {
      test.identical( o.exitCode, 0 );
      test.is( _.strHas( o.output,  "[ 'arg1', 'arg2' ]" ) );
      test.is( _.strHas( o.output,  "key1: 'val'" ) );
      test.is( _.strHas( o.output,  _.fileProvider.path.nativize( routinePath ) ) );
      test.is( _.strHas( o.output,  "[ '--no-warnings' ]" ) );

      return null;
    })
  })

  //

  con.thenKeep( function()
  {
    test.case = 'complex + deasync';

    function testApp2()
    {
      console.log( process.argv.slice( 2 ) );
      console.log( process.env );
      console.log( process.cwd() );
      console.log( process.execArgv );
    }

    let testAppPath2 = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp2.js' ) );
    var testApp2 = testApp2.toString() + '\ntestApp2();';
    _.fileProvider.fileWrite( testAppPath2, testApp2 );

    let o =
    {
      execPath :   testAppPath2,
      currentPath : routinePath,
      env : { 'key1' : 'val' },
      args : [ 'arg1', 'arg2' ],
      interpreterArgs : [ '--no-warnings' ],
      mode : 'fork',
      stdio : 'pipe',
      outputCollecting : 1,
      outputPiping : 1,
      sync : 1,
      deasync : 1
    }

    _.process.start( o );

    test.identical( o.exitCode, 0 );
    test.is( _.strHas( o.output,  "[ 'arg1', 'arg2' ]" ) );
    test.is( _.strHas( o.output,  "key1: 'val'" ) );
    test.is( _.strHas( o.output,  _.fileProvider.path.nativize( routinePath ) ) );
    test.is( _.strHas( o.output,  "[ '--no-warnings' ]" ) );

    return null;
  })

  //

  //

  con.thenKeep( function()
  {
    test.case = 'test is ipc works';

    function testApp2()
    {
      process.on( 'message', ( got ) =>
      {
        process.send({ message : 'child received ' + got.message })
        process.exit();
      })
    }

    let testAppPath2 = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp2.js' ) );
    var testApp2 = testApp2.toString() + '\ntestApp2();';
    _.fileProvider.fileWrite( testAppPath2, testApp2 );

    let o =
    {
      execPath :   testAppPath2,
      mode : 'fork',
      stdio : 'pipe',
    }

    let gotMessage;
    let con = _.process.start( o );

    o.process.send({ message : 'message from parent' });
    o.process.on( 'message', ( got ) =>
    {
      gotMessage = got.message;
    })

    con.thenKeep( function( got )
    {
      test.identical( gotMessage, 'child received message from parent' )
      test.identical( o.exitCode, 0 );
      return null;
    })

    return con;
  })

  //

  con.thenKeep( function()
  {
    test.case = 'execPath can contain path to js file and arguments';

    let o =
    {
      execPath :   testAppPath + ' arg0',
      mode : 'fork',
      stdio : 'pipe',
      outputCollecting : 1,
      outputPiping : 1,
    }

    return _.process.start( o )
    .thenKeep( function( got )
    {
      test.identical( o.exitCode, 0 );
      test.is( _.strHas( o.output,  `[ 'arg0' ]` ) );
      return null;
    })
  })

  //

  con.thenKeep( function()
  {
    test.case = 'test timeOut';

    function testApp2()
    {
      setTimeout( () =>
      {
        console.log( 'timeOut' );
      }, 5000 )
    }

    let testAppPath2 = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp2.js' ) );
    var testApp2 = testApp2.toString() + '\ntestApp2();';
    _.fileProvider.fileWrite( testAppPath2, testApp2 );

    let o =
    {
      execPath :   testAppPath2,
      mode : 'fork',
      stdio : 'pipe',
      outputCollecting : 1,
      outputPiping : 1,
      throwingExitCode : 1,
      timeOut : 1000,
    }

    return test.shouldThrowErrorOfAnyKind( _.process.start( o ) )
    .thenKeep( function( got )
    {
      test.identical( o.exitCode, null );
      return null;
    })
  })

  //

  con.thenKeep( function()
  {
    test.case = 'test timeOut';

    function testApp2()
    {
      setTimeout( () =>
      {
        console.log( 'timeOut' );
      }, 5000 )
    }

    let testAppPath2 = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp2.js' ) );
    var testApp2 = testApp2.toString() + '\ntestApp2();';
    _.fileProvider.fileWrite( testAppPath2, testApp2 );

    let o =
    {
      execPath :   testAppPath2,
      mode : 'fork',
      stdio : 'pipe',
      outputCollecting : 1,
      outputPiping : 1,
      throwingExitCode : 0,
      timeOut : 1000,
    }

    return _.process.start( o )
    .thenKeep( function( got )
    {
      test.identical( o.exitCode, null );
      return null;
    })
  })

  return con;

}

shellFork.timeOut = 30000;

//

function shellWithoutExecPath( test )
{
  let context = this;
  let counter = 0;
  let time = 0;
  let routinePath = _.path.join( context.suitePath, test.name );
  let testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  let filePath = _.fileProvider.path.nativize( _.path.join( routinePath, 'file.txt' ) );
  let ready = _.Consequence().take( null );

  let testAppCode = `let filePath = '${_.strEscape( filePath )}';\n` + context.testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'single';
    time = _.timeNow();
    return null;
  })

  let singleOption =
  {
    args : [ 'node', testAppPath, '1000' ],
    ready,
    verbosity : 3,
    outputCollecting : 1,
  }

  _.process.start( singleOption )
  .then( ( arg ) =>
  {
    test.identical( arg.exitCode, 0 );
    test.is( singleOption === arg );
    test.is( _.strHas( arg.output, 'begin 1000' ) );
    test.is( _.strHas( arg.output, 'end 1000' ) );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 1000' );
    _.fileProvider.fileDelete( filePath );
    counter += 1;
    return null;
  });

  return ready;
}

//

function shellArgumentsParsing( test )
{
  let context = this;
  let routinePath = _.path.join( context.suitePath, test.name );
  let testAppPathNoSpace = _.fileProvider.path.nativize( _.path.join( routinePath, 'noSpace', 'testApp.js' ) );
  let testAppPathSpace= _.fileProvider.path.nativize( _.path.join( routinePath, 'with space', 'testApp.js' ) );
  let ready = _.Consequence().take( null );

  let testAppCode = testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPathNoSpace, testAppCode );
  _.fileProvider.fileWrite( testAppPathSpace, testAppCode );

  /*
    +'path to exec : with space' 'execPath: has arguments' 'args has arguments' 'fork'
    +'path to exec : without space' 'execPath: has arguments' 'args has arguments' 'fork'
    +'path to exec : with space' 'execPath: only path' 'args has arguments' 'fork'
    +'path to exec : without space' 'execPath: only path' 'args has arguments' 'fork'
    +'path to exec : with space' 'execPath: has arguments' 'args: empty' 'fork'
    +'path to exec : without space' 'execPath: has arguments' 'args: empty' 'fork'
    +'path to exec : with space' 'execPath: only path' 'args: empty' 'fork'
    +'path to exec : without space' 'execPath: only path' 'args: empty' 'fork'
    +'path to exec : with space' 'execPath: has arguments' 'args has arguments' 'spawn'
    +'path to exec : without space' 'execPath: has arguments' 'args has arguments' 'spawn'
    +'path to exec : with space' 'execPath: only path' 'args has arguments' 'spawn'
    +'path to exec : without space' 'execPath: only path' 'args has arguments' 'spawn'
    +'path to exec : with space' 'execPath: has arguments' 'args: empty' 'spawn'
    +'path to exec : without space' 'execPath: has arguments' 'args: empty' 'spawn'
    +'path to exec : with space' 'execPath: only path' 'args: empty' 'spawn'
    +'path to exec : without space' 'execPath: only path' 'args: empty' 'spawn'
    +'path to exec : with space' 'execPath: has arguments' 'args has arguments' 'shell'
    +'path to exec : without space' 'execPath: has arguments' 'args has arguments' 'shell'
    +'path to exec : with space' 'execPath: only path' 'args has arguments' 'shell'
    +'path to exec : without space' 'execPath: only path' 'args has arguments' 'shell'
    +'path to exec : with space' 'execPath: has arguments' 'args: empty' 'shell'
    +'path to exec : without space' 'execPath: has arguments' 'args: empty' 'shell'
    +'path to exec : with space' 'execPath: only path' 'args: empty' 'shell'
    +'path to exec : without space' 'execPath: only path' 'args: empty' 'shell'"
  */

  /* - */

  ready

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: has arguments' 'args has arguments' 'fork'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1 "third arg"',
      args : [ '\'fourth arg\'',  `"fifth" arg` ],
      ipc : 1,
      mode : 'fork',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: has arguments' 'args has arguments' 'fork'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathNoSpace ) + ' firstArg secondArg:1 "third arg"',
      args : [ '\'fourth arg\'',  `"fifth" arg` ],
      ipc : 1,
      mode : 'fork',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args has arguments' 'fork'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathSpace ),
      args : [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', `"fifth" arg` ],
      ipc : 1,
      mode : 'fork',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: only path' 'args has arguments' 'fork'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathNoSpace ),
      args : [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', `"fifth" arg` ],
      ipc : 1,
      mode : 'fork',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: has arguments' 'args: empty' 'fork'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1 "third arg" \'fourth arg\' `"fifth" arg`',
      args : null,
      ipc : 1,
      mode : 'fork',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', 'fourth arg', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: has arguments' 'args: empty' 'fork'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathNoSpace ) + ' firstArg secondArg:1 "third arg" \'fourth arg\' `"fifth" arg`',
      args : null,
      ipc : 1,
      mode : 'fork',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', 'fourth arg', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args: empty' 'fork'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathSpace ),
      args : null,
      ipc : 1,
      mode : 'fork',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, [] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: only path' 'args: empty' 'fork'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathNoSpace ),
      args : null,
      ipc : 1,
      mode : 'fork',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, [] )

      return null;
    })

    return con;
  })

  //end of fork

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: has arguments' 'args has arguments' 'exec'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1 "third arg"',
      args : [ '\'fourth arg\'',  `"fifth" arg` ],
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let expected =
      {
        mainPath : _.path.normalize( testAppPathSpace ),
        map : { secondArg : 1 },
        scriptArgs : [ 'firstArg', 'secondArg:1', 'third arg', '\'fourth arg\'', '"fifth" arg' ]
      }
      let args = JSON.parse( o.output );
      test.contains( args, expected )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: has arguments' 'args has arguments' 'exec'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ) + ' firstArg secondArg:1 "third arg"',
      args : [ '\'fourth arg\'',  `"fifth" arg` ],
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let expected =
      {
        mainPath : _.path.normalize( testAppPathNoSpace ),
        map : { secondArg : 1 },
        scriptArgs : [ 'firstArg', 'secondArg:1', 'third arg', '\'fourth arg\'', '"fifth" arg' ]
      }
      let args = JSON.parse( o.output );
      test.contains( args, expected )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args has arguments' 'exec'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', `"fifth" arg` ],
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let expected =
      {
        mainPath : _.path.normalize( testAppPathSpace ),
        map : { secondArg : 1 },
        scriptArgs : [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', '"fifth" arg' ]
      }
      let args = JSON.parse( o.output );
      test.contains( args, expected )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: only path' 'args has arguments' 'exec'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ),
      args : [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', `"fifth" arg` ],
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let expected =
      {
        mainPath : _.path.normalize( testAppPathNoSpace ),
        map : { secondArg : 1 },
        scriptArgs : [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', '"fifth" arg' ]
      }
      let args = JSON.parse( o.output );
      test.contains( args, expected )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: has arguments' 'args: empty' 'exec'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1 "third arg" \'fourth arg\' `"fifth" arg`',
      args : null,
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let expected =
      {
        mainPath : _.path.normalize( testAppPathSpace ),
        map : { secondArg : 1 },
        scriptArgs : [ 'firstArg', 'secondArg:1', 'third arg', 'fourth arg', '"fifth" arg' ]
      }
      let args = JSON.parse( o.output );
      test.contains( args, expected )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: has arguments' 'args: empty' 'exec'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' +_.strQuote( testAppPathNoSpace ) + ' firstArg secondArg:1 "third arg" \'fourth arg\' `"fifth" arg`',
      args : null,
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let expected =
      {
        mainPath : _.path.normalize( testAppPathNoSpace ),
        map : { secondArg : 1 },
        scriptArgs : [ 'firstArg', 'secondArg:1', 'third arg', 'fourth arg', '"fifth" arg' ]
      }
      let args = JSON.parse( o.output );
      test.contains( args, expected )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args: empty' 'exec'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : null,
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let expected =
      {
        mainPath : _.path.normalize( testAppPathSpace ),
        map : {},
        scriptArgs : []
      }
      let args = JSON.parse( o.output );
      test.contains( args, expected )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: only path' 'args: empty' 'exec'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ),
      args : null,
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let expected =
      {
        mainPath : _.path.normalize( testAppPathNoSpace ),
        map : {},
        scriptArgs : []
      }
      let args = JSON.parse( o.output );
      test.contains( args, expected )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: has arguments' 'args has arguments' 'spawn'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1 "third arg"',
      args : [ '\'fourth arg\'',  `"fifth" arg` ],
      ipc : 1,
      mode : 'spawn',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: has arguments' 'args has arguments' 'spawn'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ) + ' firstArg secondArg:1 "third arg"',
      args : [ '\'fourth arg\'',  `"fifth" arg` ],
      ipc : 1,
      mode : 'spawn',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args has arguments' 'spawn'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', `"fifth" arg` ],
      ipc : 1,
      mode : 'spawn',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: only path' 'args has arguments' 'spawn'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ),
      args : [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', `"fifth" arg` ],
      ipc : 1,
      mode : 'spawn',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: has arguments' 'args: empty' 'spawn'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1 "third arg" \'fourth arg\' `"fifth" arg`',
      args : null,
      ipc : 1,
      mode : 'spawn',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', 'fourth arg', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: has arguments' 'args: empty' 'spawn'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ) + ' firstArg secondArg:1 "third arg" \'fourth arg\' `"fifth" arg`',
      args : null,
      ipc : 1,
      mode : 'spawn',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', 'fourth arg', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args: empty' 'spawn'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : null,
      ipc : 1,
      mode : 'spawn',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, [] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: only path' 'args: empty' 'spawn'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ),
      args : null,
      ipc : 1,
      mode : 'spawn',
      outputPiping : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, [] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: has arguments' 'args has arguments' 'shell'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1 "third arg"',
      args : [ '\'fourth arg\'',  `"fifth" arg` ],
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', '\'fourth arg\'', '"fifth" arg' ] )
      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: has arguments' 'args has arguments' 'shell'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ) + ' firstArg secondArg:1 "third arg"',
      args : [ '\'fourth arg\'',  `"fifth" arg` ],
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args has arguments' 'shell'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', `"fifth" arg` ],
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: only path' 'args has arguments' 'shell'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ),
      args : [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', `"fifth" arg` ],
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', '"third arg"', '\'fourth arg\'', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: has arguments' 'args: empty' 'shell'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ) + ' firstArg secondArg:1 "third arg" \'fourth arg\' `"fifth" arg`',
      args : null,
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', 'fourth arg', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: has arguments' 'args: empty' 'shell'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ) + ' firstArg secondArg:1 "third arg" \'fourth arg\' `"fifth" arg`',
      args : null,
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', 'third arg', 'fourth arg', '"fifth" arg' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args: empty' 'shell'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : null,
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, [] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : without space' 'execPath: only path' 'args: empty' 'shell'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathNoSpace ),
      args : null,
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathNoSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, [] )

      return null;
    })

    return con;
  })

  /* special case from willbe */

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args: willbe args' 'fork'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathSpace ),
      args : '.imply v:1 ; .each . .resources.list about::name',
      mode : 'fork',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    let got;
    o.process.on( 'message', ( data ) => { got = data } )

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { v : 1 } )
      test.identical( got.scriptArgs, [ '.imply v:1 ; .each . .resources.list about::name' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args: willbe args' 'spawn'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : '.imply v:1 ; .each . .resources.list about::name',
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { v : 1 } )
      test.identical( got.scriptArgs, [ '.imply v:1 ; .each . .resources.list about::name' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args: willbe args' 'shell'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : '.imply v:1 ; .each . .resources.list about::name',
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { v : 1 } )
      test.identical( got.scriptArgs, [ '.imply v:1 ; .each . .resources.list about::name' ] )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = `'path to exec : with space' 'execPath: only path' 'args: willbe args' 'exec'`

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : '.imply v:1 ; .each . .resources.list about::name',
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { v : 1 } )
      test.identical( got.scriptArgs, [ '.imply v:1 ; .each . .resources.list about::name' ] )

      return null;
    })

    return con;
  })

  /*  */

  return ready;

  /**/

  function testApp()
  {
    let _ = require( '../../../../Tools.s' );
    _.include( 'wAppBasic' );
    _.include( 'wStringsExtra' )
    var args = _.process.args();
    if( process.send )
    process.send( args );
    else
    console.log( JSON.stringify( args ) );
  }

}

shellArgumentsParsing.timeOut = 60000;

//

function shellArgumentsParsingNonTrivial( test )
{
  let context = this;
  let routinePath = _.path.join( context.suitePath, test.name );
  let testAppPathNoSpace = _.fileProvider.path.nativize( _.path.join( routinePath, 'noSpace', 'testApp.js' ) );
  let testAppPathSpace= _.fileProvider.path.nativize( _.path.join( routinePath, 'with space', 'testApp.js' ) );
  let ready = _.Consequence().take( null );

  let testAppCode = testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPathNoSpace, testAppCode );
  _.fileProvider.fileWrite( testAppPathSpace, testAppCode );
  
  /* 
  
  execPath : '"/dir with space/app.exe" `firstArg secondArg ":" 1` "third arg" \'fourth arg\'  `"fifth" arg`,
  args : '"some arg"'
  mode : 'spawn'
  ->
  execPath : '/dir with space/app.exe'
  args : [ 'firstArg secondArg ":" 1', 'third arg', 'fourth arg', '"fifth" arg', '"some arg"' ],

  =

  execPath : '"/dir with space/app.exe" firstArg secondArg:1',
  args : '"third arg"',
  ->
  execPath : '/dir with space/app.exe'
  args : [ 'firstArg', 'secondArg:1', '"third arg"' ]

  =

  execPath : '"first arg"'
  ->
  execPath : 'first arg'
  args : []

  =

  args : '"first arg"'
  ->
  execPath : 'first arg'
  args : []

  =

  args : [ '"first arg"', 'second arg' ]
  ->
  execPath : 'first arg'
  args : [ 'second arg' ]

  =

  args : [ '"', 'first', 'arg', '"' ]
  ->
  execPath : '"'
  args : [ 'first', 'arg', '"' ]

  =

  args : [ '', 'first', 'arg', '"' ]
  ->
  execPath : ''
  args : [ 'first', 'arg', '"' ]

  =

  args : [ '"', '"', 'first', 'arg', '"' ]
  ->
  execPath : '"'
  args : [ '"', 'first', 'arg', '"' ]
  
  */
 
  ready
 
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' `firstArg secondArg ":" 1` "third arg" \'fourth arg\'  `"fifth" arg`',
      args : '"some arg"',
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( o.execPath, 'node' );
      test.identical( o.args, [ testAppPathSpace, 'firstArg secondArg ":" 1', 'third arg', 'fourth arg', '"fifth" arg', '"some arg"' ] );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, [ 'firstArg secondArg ":" 1', 'third arg', 'fourth arg', '"fifth" arg', '"some arg"' ] )

      return null;
    })

    return con;
  })
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' `firstArg secondArg ":" 1` "third arg" \'fourth arg\'  `"fifth" arg`',
      args : '"some arg"',
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( o.execPath, 'node' );
      test.identical( o.args, [ testAppPathSpace, 'firstArg secondArg ":" 1', 'third arg', 'fourth arg', '"fifth" arg', '"some arg"' ] );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, [ 'firstArg secondArg ":" 1', 'third arg', 'fourth arg', '"fifth" arg', '"some arg"' ] )

      return null;
    })

    return con;
  })
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' `firstArg secondArg ":" 1` "third arg" \'fourth arg\'  `"fifth" arg`',
      args : '"some arg"',
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( o.execPath, 'node' );
      test.identical( o.args, [ testAppPathSpace, 'firstArg secondArg ":" 1', 'third arg', 'fourth arg', '"fifth" arg', '"some arg"' ] );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, [ 'firstArg secondArg ":" 1', 'third arg', 'fourth arg', '"fifth" arg', '"some arg"' ] )

      return null;
    })

    return con;
  })
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathSpace ) + ' `firstArg secondArg ":" 1` "third arg" \'fourth arg\'  `"fifth" arg`',
      args : '"some arg"',
      mode : 'fork',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( o.execPath, testAppPathSpace );
      test.identical( o.args, [ 'firstArg secondArg ":" 1', 'third arg', 'fourth arg', '"fifth" arg', '"some arg"' ] );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, [ 'firstArg secondArg ":" 1', 'third arg', 'fourth arg', '"fifth" arg', '"some arg"' ] )

      return null;
    })

    return con;
  })
  
  /*  */
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1',
      args : '"third arg"',
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( o.execPath, 'node' );
      test.identical( o.args, [ testAppPathSpace, 'firstArg', 'secondArg:1', '"third arg"' ] );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', '"third arg"' ] )

      return null;
    })

    return con;
  })
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1',
      args : '"third arg"',
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( o.execPath, 'node' );
      test.identical( o.args, [ testAppPathSpace, 'firstArg', 'secondArg:1', '"third arg"' ] );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', '"third arg"' ] )

      return null;
    })

    return con;
  })
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1',
      args : '"third arg"',
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( o.execPath, 'node' );
      test.identical( o.args, [ testAppPathSpace, 'firstArg', 'secondArg:1', '"third arg"' ] );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', '"third arg"' ] )

      return null;
    })

    return con;
  })
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : _.strQuote( testAppPathSpace ) + ' firstArg secondArg:1',
      args : '"third arg"',
      mode : 'fork',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      test.identical( o.execPath, testAppPathSpace );
      test.identical( o.args, [ 'firstArg', 'secondArg:1', '"third arg"' ] );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, { secondArg : 1 } )
      test.identical( got.scriptArgs, [ 'firstArg', 'secondArg:1', '"third arg"' ] )

      return null;
    })

    return con;
  })
  
  /*  */
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      execPath : '"first arg"',
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      throwingExitCode : 0,
      ready : con
    }
    _.process.start( o );

    con.finally( ( err, got ) =>
    { 
      test.is( !!err );
      test.is( _.strHas( err.message, 'first arg' ) )
      test.identical( o.execPath, 'first arg' );
      test.identical( o.args, [] );
      
      return null;
    })

    return con;
  })
  
  /* */
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      args : '"first arg"',
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      throwingExitCode : 0,
      ready : con
    }
    _.process.start( o );

    con.finally( ( err, got ) =>
    { 
      test.is( !!err );
      test.is( _.strHas( err.message, 'first arg' ) )
      test.identical( o.execPath, 'first arg' );
      test.identical( o.args, [] );
      
      return null;
    })

    return con;
  })
  
  /* */
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      args : [ '"first arg"', 'second arg' ],
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      throwingExitCode : 0,
      ready : con
    }
    _.process.start( o );

    con.finally( ( err, got ) =>
    { 
      test.is( !!err );
      test.is( _.strHas( err.message, 'first arg' ) )
      test.identical( o.execPath, 'first arg' );
      test.identical( o.args, [ 'second arg' ] );
      
      return null;
    })

    return con;
  })
  
  /* */
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      args : [ '"', 'first', 'arg', '"' ],
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      throwingExitCode : 0,
      ready : con
    }
    _.process.start( o );

    con.finally( ( err, got ) =>
    { 
      test.is( !!err );
      test.is( _.strHas( err.message, '"' ) )
      test.identical( o.execPath, '"' );
      test.identical( o.args, [ 'first', 'arg', '"' ] );
      
      return null;
    })

    return con;
  })
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      args : [ '', 'first', 'arg', '"' ],
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      throwingExitCode : 0,
      ready : con
    }
    _.process.start( o );

    con.finally( ( err, got ) =>
    { 
      test.is( !!err );
      test.is( _.strHas( err.message, `Received ''` ) );
      test.identical( o.execPath, '' );
      test.identical( o.args, [ 'first', 'arg', '"' ] );
      
      return null;
    })

    return con;
  })
  
  .then( () =>
  {
    test.case = 'args in execPath and args options'

    let con = new _.Consequence().take( null );
    let o =
    {
      args : [ '"', '"', 'first', 'arg', '"' ],
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      throwingExitCode : 0,
      ready : con
    }
    _.process.start( o );

    con.finally( ( err, got ) =>
    { 
      test.is( !!err );
      test.is( _.strHas( err.message, `spawn " ENOENT` ) );
      test.identical( o.execPath, '"' );
      test.identical( o.args, [ '"', 'first', 'arg', '"' ] );
      
      return null;
    })

    return con;
  })
  
  /*  */

  return ready;
  

  /**/

  function testApp()
  {
    let _ = require( '../../../../Tools.s' );
    _.include( 'wAppBasic' );
    _.include( 'wStringsExtra' )
    var args = _.process.args();
    console.log( JSON.stringify( args ) );
  }
}

shellArgumentsParsingNonTrivial.timeOut = 60000;


//

function shellArgumentsNestedQuotes( test )
{
  let context = this;
  let routinePath = _.path.join( context.suitePath, test.name );
  let testAppPathNoSpace = _.fileProvider.path.nativize( _.path.join( routinePath, 'noSpace', 'testApp.js' ) );
  let testAppPathSpace= _.fileProvider.path.nativize( _.path.join( routinePath, 'with space', 'testApp.js' ) );
  let ready = _.Consequence().take( null );

  let testAppCode = testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPathNoSpace, testAppCode );
  _.fileProvider.fileWrite( testAppPathSpace, testAppCode );

  /* */

  ready

  .then( () =>
  {
    test.case = 'fork'

    let con = new _.Consequence().take( null );
    let args =
    [
      ` '\'s-s\''  '\"s-d\"'  '\`s-b\`'  `,
      ` "\'d-s\'"  "\"d-d\""  "\`d-b\`"  `,
      ` \`\'b-s\'\`  \`\"b-d\"\`  \`\`b-b\`\` `,
    ]
    let o =
    {
      execPath : _.strQuote( testAppPathSpace ) + ' ' + args.join( ' ' ),
      mode : 'fork',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      let scriptArgs =
      [
        `'s-s'`, `"s-d"`, "`s-b`",
        `'d-s'`, `"d-d"`, "`d-b`",
        `'b-s'`, `"b-d"`, "`b-b`",
      ]
      test.identical( got.scriptArgs, scriptArgs )

      return null;
    })

    return con;
  })
  
  .then( () =>
  {
    test.case = 'fork'

    let con = new _.Consequence().take( null );
    let args =
    [
      ` '\'s-s\''  '\"s-d\"'  '\`s-b\`'  `,
      ` "\'d-s\'"  "\"d-d\""  "\`d-b\`"  `,
      ` \`\'b-s\'\`  \`\"b-d\"\`  \`\`b-b\`\` `,
    ]
    let o =
    {
      execPath : _.strQuote( testAppPathSpace ),
      args : args.slice(),
      mode : 'fork',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, args )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = 'spawn'

    let con = new _.Consequence().take( null );
    let args =
    [
      ` '\'s-s\''  '\"s-d\"'  '\`s-b\`'  `,
      ` "\'d-s\'"  "\"d-d\""  "\`d-b\`"  `,
      ` \`\'b-s\'\`  \`\"b-d\"\`  \`\`b-b\`\` `,
    ]
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' ' + args.join( ' ' ),
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      let scriptArgs =
      [
        `'s-s'`, `"s-d"`, "`s-b`",
        `'d-s'`, `"d-d"`, "`d-b`",
        `'b-s'`, `"b-d"`, "`b-b`",
      ]
      test.identical( got.scriptArgs, scriptArgs )

      return null;
    })

    return con;

  })
  
  .then( () =>
  {
    test.case = 'spawn'

    let con = new _.Consequence().take( null );
    let args =
    [
      ` '\'s-s\''  '\"s-d\"'  '\`s-b\`'  `,
      ` "\'d-s\'"  "\"d-d\""  "\`d-b\`"  `,
      ` \`\'b-s\'\`  \`\"b-d\"\`  \`\`b-b\`\` `,
    ]
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : args.slice(),
      mode : 'spawn',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, args )

      return null;
    })

    return con;

  })

  .then( () =>
  {
    test.case = 'shell'

    let con = new _.Consequence().take( null );
    let args =
    [
      ` '\'s-s\''  '\"s-d\"'  '\`s-b\`'  `,
      ` "\'d-s\'"  "\"d-d\""  "\`d-b\`"  `,
      ` \`\'b-s\'\`  \`\"b-d\"\`  \`\`b-b\`\` `,
    ]
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' ' + args.join( ' ' ),
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      let scriptArgs =
      [
        `'s-s'`, `"s-d"`, "`s-b`",
        `'d-s'`, `"d-d"`, "`d-b`",
        `'b-s'`, `"b-d"`, "`b-b`",
      ]
      test.identical( got.scriptArgs, scriptArgs )

      return null;
    })

    return con;
  })
  
  .then( () =>
  {
    test.case = 'shell'

    let con = new _.Consequence().take( null );
    let args =
    [
      ` '\'s-s\''  '\"s-d\"'  '\`s-b\`'  `,
      ` "\'d-s\'"  "\"d-d\""  "\`d-b\`"  `,
      ` \`\'b-s\'\`  \`\"b-d\"\`  \`\`b-b\`\` `,
    ]
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : args.slice(),
      mode : 'shell',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, args )

      return null;
    })

    return con;
  })

  .then( () =>
  {
    test.case = 'exec'

    let con = new _.Consequence().take( null );
    let args =
    [
      ` '\'s-s\''  '\"s-d\"'  '\`s-b\`'  `,
      ` "\'d-s\'"  "\"d-d\""  "\`d-b\`"  `,
      ` \`\'b-s\'\`  \`\"b-d\"\`  \`\`b-b\`\` `,
    ]
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ) + ' ' + args.join( ' ' ),
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      let scriptArgs =
      [
        `'s-s'`, `"s-d"`, "`s-b`",
        `'d-s'`, `"d-d"`, "`d-b`",
        `'b-s'`, `"b-d"`, "`b-b`",
      ]
      test.identical( got.scriptArgs, scriptArgs )

      return null;
    })

    return con;

  })
  
  .then( () =>
  {
    test.case = 'exec'

    let con = new _.Consequence().take( null );
    let args =
    [
      ` '\'s-s\''  '\"s-d\"'  '\`s-b\`'  `,
      ` "\'d-s\'"  "\"d-d\""  "\`d-b\`"  `,
      ` \`\'b-s\'\`  \`\"b-d\"\`  \`\`b-b\`\` `,
    ]
    let o =
    {
      execPath : 'node ' + _.strQuote( testAppPathSpace ),
      args : args.slice(),
      mode : 'exec',
      outputPiping : 1,
      outputCollecting : 1,
      ready : con
    }
    _.process.start( o );

    con.then( () =>
    {
      test.identical( o.exitCode, 0 );
      let got = JSON.parse( o.output );
      test.identical( got.mainPath, _.path.normalize( testAppPathSpace ) )
      test.identical( got.map, {} )
      test.identical( got.scriptArgs, args )

      return null;
    })

    return con;

  })

  /* */

  return ready;

  /**/

  function testApp()
  {
    let _ = require( '../../../../Tools.s' );
    _.include( 'wAppBasic' );
    _.include( 'wStringsExtra' )
    var args = _.process.args();
    console.log( JSON.stringify( args ) );
  }
}

shellArgumentsNestedQuotes.timeOut = 60000;

//

function shellVerbosity( test )
{
  let context = this;
  let routinePath = _.path.join( context.suitePath, test.name );
  let ready = _.Consequence().take( null );

  let capturedOutput = '';
  let captureLogger = new _.Logger({ output : null, onTransformEnd, raw : 1 })

  /* */

  testCase( 'verbosity : 0' )
  _.process.start
  ({
    execPath : `node -e "console.log('message')"`,
    mode : 'spawn',
    verbosity : 0,
    outputPiping : null,
    outputCollecting : 0,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( capturedOutput, '' );
    return true;
  })

  /* */

  testCase( 'verbosity : 1' )
  _.process.start
  ({
    execPath : `node -e "console.log('message')"`,
    mode : 'spawn',
    verbosity : 1,
    outputPiping : null,
    outputCollecting : 0,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    console.log( capturedOutput )
    test.identical( _.strCount( capturedOutput, `node -e "console.log('message')"`), 1 );
    test.identical( _.strCount( capturedOutput, 'message' ), 1 );
    test.identical( _.strCount( capturedOutput, 'at ' + _.path.current() ), 0 );
    return true;
  })

  /* */

   testCase( 'verbosity : 2' )
   _.process.start
   ({
     execPath : `node -e "console.log('message')"`,
     mode : 'spawn',
     verbosity : 2,
     stdio : 'pipe',
     outputPiping : null,
     outputCollecting : 0,
     outputGray : 1,
     logger : captureLogger,
     ready : ready
   })
   .then( ( got ) =>
   {
     test.identical( got.exitCode, 0 );
     test.identical( _.strCount( capturedOutput, `node -e "console.log('message')"` ), 1 );
     test.identical( _.strCount( capturedOutput, 'message' ), 2 );
     test.identical( _.strCount( capturedOutput, 'at ' + _.path.current() ), 0 );
     return true;
   })

  /* */

  testCase( 'verbosity : 3' )
  _.process.start
  ({
    execPath : `node -e "console.log('message')"`,
    mode : 'spawn',
    verbosity : 3,
    stdio : 'pipe',
    outputPiping : null,
    outputCollecting : 0,
    outputGray : 1,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( capturedOutput, `node -e "console.log('message')"` ), 1 );
    test.identical( _.strCount( capturedOutput, 'message' ), 2 );
    test.identical( _.strCount( capturedOutput, 'at ' + _.path.current() ), 1 );
    return true;
  })

  /* */

  testCase( 'verbosity : 5' )
  _.process.start
  ({
    execPath : `node -e "console.log('message')"`,
    mode : 'spawn',
    verbosity : 5,
    stdio : 'pipe',
    outputPiping : null,
    outputCollecting : 0,
    outputGray : 1,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( capturedOutput, `node -e "console.log('message')"` ), 1 );
    test.identical( _.strCount( capturedOutput, 'message' ), 2 );
    test.identical( _.strCount( capturedOutput, 'at ' + _.path.current() ), 1 );
    return true;
  })

  /* */

  testCase( 'error, verbosity : 0' )
  _.process.start
  ({
    execPath : `node -e "process.exit(1)"`,
    mode : 'spawn',
    verbosity : 0,
    stdio : 'pipe',
    outputPiping : null,
    outputCollecting : 0,
    throwingExitCode : 0,
    outputGray : 1,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 1 );
    test.identical( _.strCount( capturedOutput, 'Process returned error code ' + got.exitCode ), 0 );
    return true;
  })

  /*  */

  testCase( 'error, verbosity : 1' )
  _.process.start
  ({
    execPath : `node -e "process.exit(1)"`,
    mode : 'spawn',
    verbosity : 1,
    stdio : 'pipe',
    outputPiping : null,
    outputCollecting : 0,
    throwingExitCode : 0,
    outputGray : 1,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 1 );
    test.identical( _.strCount( capturedOutput, 'Process returned error code ' + got.exitCode ), 0 );
    return true;
  })

  /*  */

  testCase( 'error, verbosity : 2' )
  _.process.start
  ({
    execPath : `node -e "process.exit(1)"`,
    mode : 'spawn',
    verbosity : 2,
    stdio : 'pipe',
    outputPiping : null,
    outputCollecting : 0,
    throwingExitCode : 0,
    outputGray : 1,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 1 );
    test.identical( _.strCount( capturedOutput, 'Process returned error code ' + got.exitCode ), 0 );
    return true;
  })

  /* */

  testCase( 'error, verbosity : 3' )
  _.process.start
  ({
    execPath : `node -e "process.exit(1)"`,
    mode : 'spawn',
    verbosity : 3,
    stdio : 'pipe',
    outputPiping : null,
    outputCollecting : 0,
    throwingExitCode : 0,
    outputGray : 1,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 1 );
    test.identical( _.strCount( capturedOutput, 'Process returned error code ' + got.exitCode ), 0 );
    return true;
  })

  /*  */

  testCase( 'error, verbosity : 5' )
  _.process.start
  ({
    execPath : `node -e "process.exit(1)"`,
    mode : 'spawn',
    verbosity : 5,
    stdio : 'pipe',
    outputPiping : null,
    outputCollecting : 0,
    throwingExitCode : 0,
    outputGray : 1,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 1 );
    test.identical( _.strCount( capturedOutput, 'Process returned error code ' + got.exitCode ), 1 );
    return true;
  })

  /*  */

  testCase( 'execPath has quotes, verbosity : 1' )
  _.process.start
  ({
    execPath : `node -e "console.log( \"a\", 'b', \`c\` )"`,
    mode : 'spawn',
    verbosity : 5,
    stdio : 'pipe',
    outputPiping : null,
    outputCollecting : 0,
    throwingExitCode : 1,
    outputGray : 1,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( got.fullExecPath, `node -e "console.log( \"a\", 'b', \`c\` )"` );
    test.identical( _.strCount( capturedOutput, `node -e "console.log( \"a\", 'b', \`c\` )"` ), 1 );
    return true;
  })

  /* */

  testCase( 'execPath has double quotes, verbosity : 1' )
  _.process.start
  ({
    execPath : `node -e "console.log( '"a"', "'b'", \`"c"\` )"`,
    mode : 'spawn',
    verbosity : 5,
    stdio : 'pipe',
    outputPiping : null,
    outputCollecting : 0,
    throwingExitCode : 1,
    outputGray : 1,
    logger : captureLogger,
    ready : ready
  })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( got.fullExecPath, `node -e "console.log( '"a"', "'b'", \`"c"\` )"` );
    test.identical( _.strCount( capturedOutput, `node -e "console.log( '"a"', "'b'", \`"c"\` )"` ), 1 );
    return true;
  })

  return ready;

  /*  */

  function testCase( src )
  {
    ready.then( () =>
    {
      capturedOutput = '';
      test.case = src;
      return null
    });
  }

  function onTransformEnd( o )
  {
    capturedOutput += o.outputForPrinter[ 0 ] + '\n';
  }
}

//

function shellErrorHadling( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );

  /* */

  function testApp()
  {
    throw 'Error message from child'
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  var expectedOutput = __dirname + '\n'
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  //

  var con = new _.Consequence().take( null );

  con.thenKeep( function()
  {
    test.case = 'collecting, verbosity and piping off';

    let o =
    {
      execPath :   'node ' + testAppPath,
      mode : 'spawn',
      stdio : 'pipe',
      verbosity : 0,
      outputCollecting : 0,
      outputPiping : 0
    }
    return test.shouldThrowErrorOfAnyKind( _.process.start( o ) )
    .thenKeep( function( got )
    {
      test.is( _.errIs( got ) );
      test.is( _.strHas( got.message, 'Process returned exit code' ) )
      test.is( _.strHas( got.message, 'Launched as' ) )
      test.is( _.strHas( got.message, 'Stderr' ) )
      test.is( _.strHas( got.message, 'Error message from child' ) )

      test.notIdentical( o.exitCode, 0 );

      return null;
    })

  })

  con.thenKeep( function()
  {
    test.case = 'collecting, verbosity and piping off';

    let o =
    {
      execPath :   'node ' + testAppPath,
      mode : 'shell',
      stdio : 'pipe',
      verbosity : 0,
      outputCollecting : 0,
      outputPiping : 0
    }
    return test.shouldThrowErrorOfAnyKind( _.process.start( o ) )
    .thenKeep( function( got )
    {
      test.is( _.errIs( got ) );
      test.is( _.strHas( got.message, 'Process returned exit code' ) )
      test.is( _.strHas( got.message, 'Launched as' ) )
      test.is( _.strHas( got.message, 'Stderr' ) )
      test.is( _.strHas( got.message, 'Error message from child' ) )

      test.notIdentical( o.exitCode, 0 );

      return null;
    })

  })

  con.thenKeep( function()
  {
    test.case = 'collecting, verbosity and piping off';

    let o =
    {
      execPath :   testAppPath,
      mode : 'fork',
      stdio : 'pipe',
      verbosity : 0,
      outputCollecting : 0,
      outputPiping : 0
    }
    return test.shouldThrowErrorOfAnyKind( _.process.start( o ) )
    .thenKeep( function( got )
    {
      test.is( _.errIs( got ) );
      test.is( _.strHas( got.message, 'Process returned exit code' ) )
      test.is( _.strHas( got.message, 'Launched as' ) )
      test.is( _.strHas( got.message, 'Stderr' ) )
      test.is( _.strHas( got.message, 'Error message from child' ) )

      test.notIdentical( o.exitCode, 0 );

      return null;
    })

  })

  con.thenKeep( function()
  {
    test.case = 'sync, collecting, verbosity and piping off';

    let o =
    {
      execPath :   'node ' + testAppPath,
      mode : 'spawn',
      stdio : 'pipe',
      sync : 1,
      deasync : 1,
      verbosity : 0,
      outputCollecting : 0,
      outputPiping : 0
    }
    var got = test.shouldThrowErrorSync( () => _.process.start( o ) )

    test.is( _.errIs( got ) );
    test.is( _.strHas( got.message, 'Process returned exit code' ) )
    test.is( _.strHas( got.message, 'Launched as' ) )
    test.is( _.strHas( got.message, 'Stderr' ) )
    test.is( _.strHas( got.message, 'Error message from child' ) )

    test.notIdentical( o.exitCode, 0 );

    return null;

  })

  con.thenKeep( function()
  {
    test.case = 'sync, collecting, verbosity and piping off';

    let o =
    {
      execPath :   'node ' + testAppPath,
      mode : 'shell',
      stdio : 'pipe',
      sync : 1,
      deasync : 1,
      verbosity : 0,
      outputCollecting : 0,
      outputPiping : 0
    }
    var got = test.shouldThrowErrorSync( () => _.process.start( o ) )

    test.is( _.errIs( got ) );
    test.is( _.strHas( got.message, 'Process returned exit code' ) )
    test.is( _.strHas( got.message, 'Launched as' ) )
    test.is( _.strHas( got.message, 'Stderr' ) )
    test.is( _.strHas( got.message, 'Error message from child' ) )

    test.notIdentical( o.exitCode, 0 );

    return null;

  })

  con.thenKeep( function()
  {
    test.case = 'sync, collecting, verbosity and piping off';

    let o =
    {
      execPath :   testAppPath,
      mode : 'fork',
      stdio : 'pipe',
      sync : 1,
      deasync : 1,
      verbosity : 0,
      outputCollecting : 0,
      outputPiping : 0
    }
    var got = test.shouldThrowErrorSync( () => _.process.start( o ) )

    test.is( _.errIs( got ) );
    test.is( _.strHas( got.message, 'Process returned exit code' ) )
    test.is( _.strHas( got.message, 'Launched as' ) )
    test.is( _.strHas( got.message, 'Stderr' ) )
    test.is( _.strHas( got.message, 'Error message from child' ) )

    test.notIdentical( o.exitCode, 0 );

    return null;

  })

  con.thenKeep( function()
  {
    test.case = 'stdio ignore, sync, collecting, verbosity and piping off';

    let o =
    {
      execPath :   testAppPath,
      mode : 'fork',
      stdio : 'ignore',
      sync : 1,
      deasync : 1,
      verbosity : 0,
      outputCollecting : 0,
      outputPiping : 0
    }
    var got = test.shouldThrowErrorSync( () => _.process.start( o ) )

    test.is( _.errIs( got ) );
    test.is( _.strHas( got.message, 'Process returned exit code' ) )
    test.is( _.strHas( got.message, 'Launched as' ) )
    test.is( !_.strHas( got.message, 'Stderr' ) )
    test.is( !_.strHas( got.message, 'Error message from child' ) )

    test.notIdentical( o.exitCode, 0 );

    return null;

  })

  // con.thenKeep( function()
  // {
  //   test.case = 'stdio inherit, sync, collecting, verbosity and piping off';

  //   let o =
  //   {
  //     execPath :   testAppPath,
  //     mode : 'fork',
  //     stdio : 'inherit',
  //     sync : 1,
  //     deasync : 1,
  //     verbosity : 0,
  //     outputCollecting : 0,
  //     outputPiping : 0
  //   }
  //   var got = test.shouldThrowErrorSync( () => _.process.start( o ) )

  //   test.is( _.errIs( got ) );
  //   test.is( _.strHas( got.message, 'Process returned error code' ) )
  //   test.is( _.strHas( got.message, 'Launched as' ) )
  //   test.is( !_.strHas( got.message, 'Stderr' ) )
  //   test.is( !_.strHas( got.message, 'Error message from child' ) )

  //   test.notIdentical( o.exitCode, 0 );

  //   return null;

  // })

  return con;

}


//

function shellNode( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );

  /* */

  function testApp()
  {
    throw 'Error message from child';
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  var con = new _.Consequence().take( null );

  var modes = [ 'fork', 'exec', 'spawn', 'shell' ];

  modes.forEach( ( mode ) =>
  {
    con.thenKeep( () =>
    {
      var o = { execPath : testAppPath, mode : mode, applyingExitCode : 1, throwingExitCode : 1, stdio : 'ignore' };
      return _.process.startNode( o )
      .finally( ( err, got ) =>
      {
        test.identical( o.exitCode, 1 );
        test.identical( process.exitCode, 1 );
        process.exitCode = 0;
        test.is( _.errIs( err ) );
        return true;
      })
    })

    con.thenKeep( () =>
    {
      var o = { execPath : testAppPath, mode : mode,  applyingExitCode : 1, throwingExitCode : 0, stdio : 'ignore' };
      return _.process.startNode( o )
      .finally( ( err, got ) =>
      {
        test.identical( o.exitCode, 1 );
        test.identical( process.exitCode, 1 );
        process.exitCode = 0;
        test.is( !_.errIs( err ) );
        return true;
      })
    })

    con.thenKeep( () =>
    {
      var o = { execPath : testAppPath,  mode : mode, applyingExitCode : 0, throwingExitCode : 1, stdio : 'ignore' };
      return _.process.startNode( o )
      .finally( ( err, got ) =>
      {
        test.identical( o.exitCode, 1 );
        test.identical( process.exitCode, 0 );
        test.is( _.errIs( err ) );
        return true;
      })
    })

    con.thenKeep( () =>
    {
      var o = { execPath : testAppPath,  mode : mode, applyingExitCode : 0, throwingExitCode : 0, stdio : 'ignore' };
      return _.process.startNode( o )
      .finally( ( err, got ) =>
      {
        test.identical( o.exitCode, 1 );
        test.identical( process.exitCode, 0 );
        test.is( !_.errIs( err ) );
        return true;
      })
    })

    con.thenKeep( () =>
    {
      var o = { execPath : testAppPath,  mode : mode, maximumMemory : 1, applyingExitCode : 0, throwingExitCode : 0, stdio : 'ignore' };
      return _.process.startNode( o )
      .finally( ( err, got ) =>
      {
        test.identical( o.exitCode, 1 );
        test.identical( process.exitCode, 0 );
        let spawnArgs = _.toStr( o.process.spawnargs, { levels : 99 } );
        test.is( _.strHasAll( spawnArgs, [ "--expose-gc",  "--stack-trace-limit=999", "--max_old_space_size=" ] ) )
        test.is( !_.errIs( err ) );
        return true;
      })
    })
  })

  return con;

}

shellNode.timeOut = 20000;

//

function shellTerminate( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );

  /* */

  function testApp()
  {
    setTimeout( () =>
    {
      console.log( 'Timeout');
    },5000 )
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPath, testAppCode );
  var ready = new _.Consequence().take( null );

  let terminateChild =
  {
    execPath : 'node ' + testAppPath,
    ready,
    throwingExitCode : 1,
  }

  _.process.start( terminateChild );

  terminateChild.process.kill();

  ready.finally( ( err, got ) =>
  {
    test.is( _.errIs( err ) );
    test.identical( terminateChild.exitCode, null );
    return null;
  })

  return ready;
}

shellTerminate.timeOut = 10000;


//

function shellConcurrent( test )
{
  let context = this;
  let counter = 0;
  let time = 0;
  let routinePath = _.path.join( context.suitePath, test.name );
  let testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  let filePath = _.fileProvider.path.nativize( _.path.join( routinePath, 'file.txt' ) );
  let ready = _.Consequence().take( null );

  let testAppCode = `let filePath = '${_.strEscape( filePath )}';\n` + context.testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  logger.log( 'this is #foreground : bright white#an#foreground : default# experiment' ); /* qqq fix logger, please !!! */

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'single';
    time = _.timeNow();
    return null;
  })

  let singleOption =
  {
    execPath : 'node ' + testAppPath + ' 1000',
    ready : ready,
    verbosity : 3,
    outputCollecting : 1,
  }

  _.process.start( singleOption )
  .then( ( arg ) =>
  {

    test.identical( arg.exitCode, 0 );
    test.is( singleOption === arg );
    test.is( _.strHas( arg.output, 'begin 1000' ) );
    test.is( _.strHas( arg.output, 'end 1000' ) );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 1000' );
    _.fileProvider.fileDelete( filePath );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'single, execPath in array';
    time = _.timeNow();
    return null;
  })

  let singleExecPathInArrayOptions =
  {
    execPath : [ 'node ' + testAppPath + ' 1000' ],
    ready : ready,
    verbosity : 3,
    outputCollecting : 1,
  }

  _.process.start( singleExecPathInArrayOptions )
  .then( ( arg ) =>
  {

    test.identical( arg.length, 1 );
    test.identical( arg[ 0 ].exitCode, 0 );
    test.is( singleExecPathInArrayOptions !== arg[ 0 ] );
    test.is( _.strHas( arg[ 0 ].output, 'begin 1000' ) );
    test.is( _.strHas( arg[ 0 ].output, 'end 1000' ) );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 1000' );
    _.fileProvider.fileDelete( filePath );

    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'single, error in ready';
    time = _.timeNow();
    throw _.err( 'Error!' );
  })

  let singleErrorBeforeScalar =
  {
    execPath : 'node ' + testAppPath + ' 1000',
    ready : ready,
    verbosity : 3,
    outputCollecting : 1,
  }

  _.process.start( singleErrorBeforeScalar )
  .finally( ( err, arg ) =>
  {

    test.is( arg === undefined );
    test.is( _.errIs( err ) );
    test.identical( singleErrorBeforeScalar.exitCode, null );
    test.identical( singleErrorBeforeScalar.output, undefined );
    test.is( !_.fileProvider.fileExists( filePath ) );

    _.errAttend( err );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'single, error in ready';
    time = _.timeNow();
    throw _.err( 'Error!' );
  })

  let singleErrorBefore =
  {
    execPath : [ 'node ' + testAppPath + ' 1000' ],
    ready : ready,
    verbosity : 3,
    outputCollecting : 1,
  }

  _.process.start( singleErrorBefore )
  .finally( ( err, arg ) =>
  {

    test.is( arg === undefined );
    test.is( _.errIs( err ) );
    test.identical( singleErrorBefore.exitCode, null );
    test.identical( singleErrorBefore.output, undefined );
    test.is( !_.fileProvider.fileExists( filePath ) );

    _.errAttend( err );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, serial';
    time = _.timeNow();
    return null;
  })

  let subprocessesOptionsSerial =
  {
    execPath :  [ 'node ' + testAppPath + ' 1000', 'node ' + testAppPath + ' 10' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 0,
  }

  _.process.start( subprocessesOptionsSerial )
  .then( ( arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent );
    test.gt( spent, 1000 );
    test.le( spent, 5000 );

    test.identical( subprocessesOptionsSerial.exitCode, 0 );
    test.identical( arg.length, 2 );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 10' );
    _.fileProvider.fileDelete( filePath );

    test.identical( arg[ 0 ].exitCode, 0 );
    test.is( _.strHas( arg[ 0 ].output, 'begin 1000' ) );
    test.is( _.strHas( arg[ 0 ].output, 'end 1000' ) );

    test.identical( arg[ 1 ].exitCode, 0 );
    test.is( _.strHas( arg[ 1 ].output, 'begin 10' ) );
    test.is( _.strHas( arg[ 1 ].output, 'end 10' ) );

    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, serial, error, throwingExitCode : 1';
    time = _.timeNow();
    return null;
  })

  let subprocessesError =
  {
    execPath :  [ 'node ' + testAppPath + ' x', 'node ' + testAppPath + ' 10' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 0,
  }

  _.process.start( subprocessesError )
  .finally( ( err, arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent );
    test.gt( spent, 0 );
    test.le( spent, 5000 );

    test.identical( subprocessesError.exitCode, 1 );
    test.is( _.errIs( err ) );
    test.is( arg === undefined );
    test.is( !_.fileProvider.fileExists( filePath ) );

    _.errAttend( err );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, serial, error, throwingExitCode : 0';
    time = _.timeNow();
    return null;
  })

  let subprocessesErrorNonThrowing =
  {
    execPath :  [ 'node ' + testAppPath + ' x', 'node ' + testAppPath + ' 10' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 0,
    throwingExitCode : 0,
  }

  _.process.start( subprocessesErrorNonThrowing )
  .finally( ( err, arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent );
    test.gt( spent, 0 );
    test.le( spent, 5000 );

    test.identical( subprocessesErrorNonThrowing.exitCode, 1 );
    test.identical( arg.length, 2 );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 10' );
    _.fileProvider.fileDelete( filePath );

    test.identical( arg[ 0 ].exitCode, 1 );
    test.is( _.strHas( arg[ 0 ].output, 'begin x' ) );
    test.is( !_.strHas( arg[ 0 ].output, 'end x' ) );
    test.is( _.strHas( arg[ 0 ].output, 'Expects number' ) );

    test.identical( arg[ 1 ].exitCode, 0 );
    test.is( _.strHas( arg[ 1 ].output, 'begin 10' ) );
    test.is( _.strHas( arg[ 1 ].output, 'end 10' ) );

    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, concurrent : 1, error, throwingExitCode : 1';
    time = _.timeNow();
    return null;
  })

  let subprocessesErrorConcurrent =
  {
    execPath :  [ 'node ' + testAppPath + ' x', 'node ' + testAppPath + ' 10' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 1,
  }

  _.process.start( subprocessesErrorConcurrent )
  .finally( ( err, arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent );
    test.gt( spent, 0 );
    test.le( spent, 5000 );

    test.identical( subprocessesErrorConcurrent.exitCode, 1 );
    test.is( _.errIs( err ) );
    test.is( arg === undefined );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 10' );
    _.fileProvider.fileDelete( filePath );

    _.errAttend( err );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, concurrent : 1, error, throwingExitCode : 0';
    time = _.timeNow();
    return null;
  })

  let subprocessesErrorConcurrentNonThrowing =
  {
    execPath :  [ 'node ' + testAppPath + ' x', 'node ' + testAppPath + ' 10' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 1,
    throwingExitCode : 0,
  }

  _.process.start( subprocessesErrorConcurrentNonThrowing )
  .finally( ( err, arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent );
    test.gt( spent, 0 );
    test.le( spent, 5000 );

    test.identical( subprocessesErrorConcurrentNonThrowing.exitCode, 1 );
    test.identical( arg.length, 2 );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 10' );
    _.fileProvider.fileDelete( filePath );

    test.identical( arg[ 0 ].exitCode, 1 );
    test.is( _.strHas( arg[ 0 ].output, 'begin x' ) );
    test.is( !_.strHas( arg[ 0 ].output, 'end x' ) );
    test.is( _.strHas( arg[ 0 ].output, 'Expects number' ) );

    test.identical( arg[ 1 ].exitCode, 0 );
    test.is( _.strHas( arg[ 1 ].output, 'begin 10' ) );
    test.is( _.strHas( arg[ 1 ].output, 'end 10' ) );

    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, concurrent : 1';
    time = _.timeNow();
    return null;
  })

  let suprocessesConcurrentOptions =
  {
    execPath :  [ 'node ' + testAppPath + ' 1000', 'node ' + testAppPath + ' 100' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 1,
  }

  _.process.start( suprocessesConcurrentOptions )
  .then( ( arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent )
    test.gt( spent, 1000 );
    test.le( spent, 5000 );

    test.identical( suprocessesConcurrentOptions.exitCode, 0 );
    test.identical( arg.length, 2 );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 1000' );
    _.fileProvider.fileDelete( filePath );

    test.identical( arg[ 0 ].exitCode, 0 );
    test.is( _.strHas( arg[ 0 ].output, 'begin 1000' ) );
    test.is( _.strHas( arg[ 0 ].output, 'end 1000' ) );

    test.identical( arg[ 1 ].exitCode, 0 );
    test.is( _.strHas( arg[ 1 ].output, 'begin 100' ) );
    test.is( _.strHas( arg[ 1 ].output, 'end 100' ) );

    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'args';
    time = _.timeNow();
    return null;
  })

  let suprocessesConcurrentArgumentsOptions =
  {
    execPath :  [ 'node ' + testAppPath + ' 1000', 'node ' + testAppPath + ' 100' ],
    args : [ 'second', 'argument' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 1,
  }

  _.process.start( suprocessesConcurrentArgumentsOptions )
  .then( ( arg ) =>
  {
    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent )
    test.gt( spent, 1000 );
    test.le( spent, 5000 );

    test.identical( suprocessesConcurrentArgumentsOptions.exitCode, 0 );
    test.identical( arg.length, 2 );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 1000' );
    _.fileProvider.fileDelete( filePath );

    test.identical( arg[ 0 ].exitCode, 0 );
    test.is( _.strHas( arg[ 0 ].output, 'begin 1000, second, argument' ) );
    test.is( _.strHas( arg[ 0 ].output, 'end 1000, second, argument' ) );

    test.identical( arg[ 1 ].exitCode, 0 );
    test.is( _.strHas( arg[ 1 ].output, 'begin 100, second, argument' ) );
    test.is( _.strHas( arg[ 1 ].output, 'end 100, second, argument' ) );

    counter += 1;
    return null;
  });

  /* - */

  return ready.finally( ( err, arg ) =>
  {
    debugger;
    test.identical( counter, 11 );
    if( err )
    throw err;
    return arg;
  });
}

shellConcurrent.timeOut = 100000;

//

function shellerConcurrent( test )
{
  let context = this;
  let counter = 0;
  let time = 0;
  let routinePath = _.path.join( context.suitePath, test.name );
  let testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  let filePath = _.fileProvider.path.nativize( _.path.join( routinePath, 'file.txt' ) );
  let ready = _.Consequence().take( null );

  let testAppCode = `let filePath = '${_.strEscape( filePath )}';\n` + context.testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'single';
    time = _.timeNow();
    return null;
  })

  let singleOption2 = {}
  let singleOption =
  {
    execPath : 'node ' + testAppPath + ' 1000',
    ready : ready,
    verbosity : 3,
    outputCollecting : 1,
  }

  var shell = _.process.starter( singleOption );
  shell( singleOption2 )

  .then( ( arg ) =>
  {
    test.identical( arg.exitCode, 0 );
    test.is( singleOption !== arg );
    test.is( singleOption2 === arg );
    test.is( _.strHas( arg.output, 'begin 1000' ) );
    test.is( _.strHas( arg.output, 'end 1000' ) );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 1000' );
    _.fileProvider.fileDelete( filePath );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'single, no second options';
    time = _.timeNow();
    return null;
  })

  let singleOptionWithoutSecond =
  {
    execPath : 'node ' + testAppPath + ' 1000',
    ready : ready,
    verbosity : 3,
    outputCollecting : 1,
  }

  var shell = _.process.starter( singleOptionWithoutSecond );
  shell()

  .then( ( arg ) =>
  {

    test.identical( arg.exitCode, 0 );
    test.is( singleOptionWithoutSecond !== arg );
    test.is( _.strHas( arg.output, 'begin 1000' ) );
    test.is( _.strHas( arg.output, 'end 1000' ) );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 1000' );
    _.fileProvider.fileDelete( filePath );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'single, execPath in array';
    time = _.timeNow();
    return null;
  })

  let singleExecPathInArrayOptions2 = {};
  let singleExecPathInArrayOptions =
  {
    execPath : 'node ' + testAppPath + ' 1000',
    ready : ready,
    verbosity : 3,
    outputCollecting : 1,
  }

  var shell = _.process.starter( singleExecPathInArrayOptions );
  shell( singleExecPathInArrayOptions2 )

  .then( ( arg ) =>
  {
    test.identical( arg.exitCode, 0 );
    test.is( singleExecPathInArrayOptions2 === arg );
    test.is( _.strHas( arg.output, 'begin 1000' ) );
    test.is( _.strHas( arg.output, 'end 1000' ) );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 1000' );
    _.fileProvider.fileDelete( filePath );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'single, error in ready, exec is scalar';
    time = _.timeNow();
    throw _.err( 'Error!' );
  })

  let singleErrorBeforeScalar2 = {};
  let singleErrorBeforeScalar =
  {
    execPath : 'node ' + testAppPath + ' 1000',
    ready : ready,
    verbosity : 3,
    outputCollecting : 1,
  }

  var shell = _.process.starter( singleErrorBeforeScalar );
  shell( singleErrorBeforeScalar2 )

  .finally( ( err, arg ) =>
  {

    test.is( arg === undefined );
    test.is( _.errIs( err ) );
    test.identical( singleErrorBeforeScalar.exitCode, undefined );
    test.identical( singleErrorBeforeScalar.output, undefined );
    test.is( !_.fileProvider.fileExists( filePath ) );

    _.errAttend( err );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'single, error in ready, exec is single-element vector';
    time = _.timeNow();
    throw _.err( 'Error!' );
  })

  let singleErrorBefore2 = {};
  let singleErrorBefore =
  {
    execPath : [ 'node ' + testAppPath + ' 1000' ],
    ready : ready,
    verbosity : 3,
    outputCollecting : 1,
  }

  var shell = _.process.starter( singleErrorBefore );
  shell( singleErrorBefore2 )

  .finally( ( err, arg ) =>
  {

    test.is( arg === undefined );
    test.is( _.errIs( err ) );
    test.identical( singleErrorBefore.exitCode, undefined );
    test.identical( singleErrorBefore.output, undefined );
    test.is( !_.fileProvider.fileExists( filePath ) );

    _.errAttend( err );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, serial';
    time = _.timeNow();
    return null;
  })

  let subprocessesOptionsSerial2 = {};
  let subprocessesOptionsSerial =
  {
    execPath :  [ 'node ' + testAppPath + ' 1000', 'node ' + testAppPath + ' 10' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 0,
  }

  var shell = _.process.starter( subprocessesOptionsSerial );
  shell( subprocessesOptionsSerial2 )

  .then( ( arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent );
    test.gt( spent, 1000 );
    test.le( spent, 5000 );

    test.identical( subprocessesOptionsSerial2.exitCode, 0 );
    test.identical( arg.length, 2 );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 10' );
    _.fileProvider.fileDelete( filePath );

    test.identical( arg[ 0 ].exitCode, 0 );
    test.is( _.strHas( arg[ 0 ].output, 'begin 1000' ) );
    test.is( _.strHas( arg[ 0 ].output, 'end 1000' ) );

    test.identical( arg[ 1 ].exitCode, 0 );
    test.is( _.strHas( arg[ 1 ].output, 'begin 10' ) );
    test.is( _.strHas( arg[ 1 ].output, 'end 10' ) );

    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, serial, error, throwingExitCode : 1';
    time = _.timeNow();
    return null;
  })

  let subprocessesError2 = {};
  let subprocessesError =
  {
    execPath :  [ 'node ' + testAppPath + ' x', 'node ' + testAppPath + ' 10' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 0,
  }

  var shell = _.process.starter( subprocessesError );
  shell( subprocessesError2 )

  .finally( ( err, arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent );
    test.gt( spent, 0 );
    test.le( spent, 5000 );

    test.identical( subprocessesError2.exitCode, 1 );
    test.is( _.errIs( err ) );
    test.is( arg === undefined );
    test.is( !_.fileProvider.fileExists( filePath ) );

    _.errAttend( err );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, serial, error, throwingExitCode : 0';
    time = _.timeNow();
    return null;
  })

  let subprocessesErrorNonThrowing2 = {};
  let subprocessesErrorNonThrowing =
  {
    execPath :  [ 'node ' + testAppPath + ' x', 'node ' + testAppPath + ' 10' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 0,
    throwingExitCode : 0,
  }

  var shell = _.process.starter( subprocessesErrorNonThrowing );
  shell( subprocessesErrorNonThrowing2 )

  .finally( ( err, arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent );
    test.gt( spent, 0 );
    test.le( spent, 5000 );

    test.identical( subprocessesErrorNonThrowing2.exitCode, 1 );
    test.identical( arg.length, 2 );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 10' );
    _.fileProvider.fileDelete( filePath );

    test.identical( arg[ 0 ].exitCode, 1 );
    test.is( _.strHas( arg[ 0 ].output, 'begin x' ) );
    test.is( !_.strHas( arg[ 0 ].output, 'end x' ) );
    test.is( _.strHas( arg[ 0 ].output, 'Expects number' ) );

    test.identical( arg[ 1 ].exitCode, 0 );
    test.is( _.strHas( arg[ 1 ].output, 'begin 10' ) );
    test.is( _.strHas( arg[ 1 ].output, 'end 10' ) );

    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, concurrent : 1, error, throwingExitCode : 1';
    time = _.timeNow();
    return null;
  })

  let subprocessesErrorConcurrent2 = {};
  let subprocessesErrorConcurrent =
  {
    execPath :  [ 'node ' + testAppPath + ' x', 'node ' + testAppPath + ' 10' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 1,
  }

  var shell = _.process.starter( subprocessesErrorConcurrent );
  shell( subprocessesErrorConcurrent2 )

  .finally( ( err, arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent );
    test.gt( spent, 0 );
    test.le( spent, 5000 );

    test.identical( subprocessesErrorConcurrent2.exitCode, 1 );
    test.is( _.errIs( err ) );
    test.is( arg === undefined );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 10' );
    _.fileProvider.fileDelete( filePath );

    _.errAttend( err );
    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, concurrent : 1, error, throwingExitCode : 0';
    time = _.timeNow();
    return null;
  })

  let subprocessesErrorConcurrentNonThrowing2 = {};
  let subprocessesErrorConcurrentNonThrowing =
  {
    execPath :  [ 'node ' + testAppPath + ' x', 'node ' + testAppPath + ' 10' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 1,
    throwingExitCode : 0,
  }

  var shell = _.process.starter( subprocessesErrorConcurrentNonThrowing );
  shell( subprocessesErrorConcurrentNonThrowing2 )

  .finally( ( err, arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent );
    test.gt( spent, 0 );
    test.le( spent, 5000 );

    test.identical( subprocessesErrorConcurrentNonThrowing2.exitCode, 1 );
    test.identical( arg.length, 2 );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 10' );
    _.fileProvider.fileDelete( filePath );

    test.identical( arg[ 0 ].exitCode, 1 );
    test.is( _.strHas( arg[ 0 ].output, 'begin x' ) );
    test.is( !_.strHas( arg[ 0 ].output, 'end x' ) );
    test.is( _.strHas( arg[ 0 ].output, 'Expects number' ) );

    test.identical( arg[ 1 ].exitCode, 0 );
    test.is( _.strHas( arg[ 1 ].output, 'begin 10' ) );
    test.is( _.strHas( arg[ 1 ].output, 'end 10' ) );

    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'subprocesses, concurrent : 1';
    time = _.timeNow();
    return null;
  })

  let subprocessesConcurrentOptions2 = {};
  let subprocessesConcurrentOptions =
  {
    execPath :  [ 'node ' + testAppPath + ' 1000', 'node ' + testAppPath + ' 100' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 1,
  }

  var shell = _.process.starter( subprocessesConcurrentOptions );
  shell( subprocessesConcurrentOptions2 )

  .then( ( arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent )
    test.gt( spent, 1000 );
    test.le( spent, 5000 );

    test.identical( subprocessesConcurrentOptions2.exitCode, 0 );
    test.identical( arg.length, 2 );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 1000' );
    _.fileProvider.fileDelete( filePath );

    test.identical( arg[ 0 ].exitCode, 0 );
    test.is( _.strHas( arg[ 0 ].output, 'begin 1000' ) );
    test.is( _.strHas( arg[ 0 ].output, 'end 1000' ) );

    test.identical( arg[ 1 ].exitCode, 0 );
    test.is( _.strHas( arg[ 1 ].output, 'begin 100' ) );
    test.is( _.strHas( arg[ 1 ].output, 'end 100' ) );

    counter += 1;
    return null;
  });

  /* - */

  ready.then( ( arg ) =>
  {
    test.case = 'args';
    time = _.timeNow();
    return null;
  })

  let subprocessesConcurrentArgumentsOptions2 = {}
  let subprocessesConcurrentArgumentsOptions =
  {
    execPath :  [ 'node ' + testAppPath + ' 1000', 'node ' + testAppPath + ' 100' ],
    args : [ 'second', 'argument' ],
    ready : ready,
    outputCollecting : 1,
    verbosity : 3,
    concurrent : 1,
  }

  var shell = _.process.starter( subprocessesConcurrentArgumentsOptions );
  shell( subprocessesConcurrentArgumentsOptions2 )

  .then( ( arg ) =>
  {

    var spent = _.timeNow() - time;
    logger.log( 'Spent', spent )
    test.gt( spent, 1000 );
    test.le( spent, 5000 );

    test.identical( subprocessesConcurrentArgumentsOptions2.exitCode, 0 );
    test.identical( arg.length, 2 );
    test.identical( _.fileProvider.fileRead( filePath ), 'written by 1000' );
    _.fileProvider.fileDelete( filePath );

    test.identical( arg[ 0 ].exitCode, 0 );
    test.is( _.strHas( arg[ 0 ].output, 'begin 1000, second, argument' ) );
    test.is( _.strHas( arg[ 0 ].output, 'end 1000, second, argument' ) );

    test.identical( arg[ 1 ].exitCode, 0 );
    test.is( _.strHas( arg[ 1 ].output, 'begin 100, second, argument' ) );
    test.is( _.strHas( arg[ 1 ].output, 'end 100, second, argument' ) );

    counter += 1;
    return null;
  });

  /* - */

  return ready.finally( ( err, arg ) =>
  {
    debugger;
    test.identical( counter, 12 );
    if( err )
    throw err;
    return arg;
  });
}

shellerConcurrent.timeOut = 100000;

//

function sheller( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );
  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  function testApp()
  {
    console.log( process.argv.slice( 2 ) );
  }

  /* */

  var con = new _.Consequence().take( null )

  .thenKeep( () =>
  {
    var shell = _.process.starter
    ({
      execPath :  'node ' + testAppPath,
      outputCollecting : 1,
      outputPiping : 1
    })

    debugger;
    return shell({ execPath :  [ 'arg1', 'arg2' ] })
    .thenKeep( ( got ) =>
    {
      debugger;
      test.identical( got.length, 2 );

      let o1 = got[ 0 ];
      let o2 = got[ 1 ];

      test.identical( o1.execPath, 'node' );
      test.identical( o2.execPath, 'node' );
      test.is( _.strHas( o1.output, "[ 'arg1' ]" ) );
      test.is( _.strHas( o2.output, "[ 'arg2' ]" ) );

      return got;
    })
  })

  .thenKeep( () =>
  {
    var shell = _.process.starter
    ({
      execPath :  'node ' + testAppPath + ' arg0',
      outputCollecting : 1,
      outputPiping : 1
    })

    return shell({ execPath :  [ 'arg1', 'arg2' ] })
    .thenKeep( ( got ) =>
    {
      test.identical( got.length, 2 );

      let o1 = got[ 0 ];
      let o2 = got[ 1 ];

      test.identical( o1.execPath, 'node' );
      test.identical( o2.execPath, 'node' );
      test.is( _.strHas( o1.output, "[ 'arg0', 'arg1' ]" ) );
      test.is( _.strHas( o2.output, "[ 'arg0', 'arg2' ]" ) );

      return got;
    })
  })


  .thenKeep( () =>
  {
    var shell = _.process.starter
    ({
      execPath :  'node ' + testAppPath,
      outputCollecting : 1,
      outputPiping : 1
    })

    return shell({ execPath :  [ 'arg1', 'arg2' ], args : [ 'arg3' ] })
    .thenKeep( ( got ) =>
    {
      test.identical( got.length, 2 );

      let o1 = got[ 0 ];
      let o2 = got[ 1 ];

      test.identical( o1.execPath, 'node' );
      test.identical( o2.execPath, 'node' );
      test.identical( o1.args, [ testAppPath, 'arg1', 'arg3' ] );
      test.identical( o2.args, [ testAppPath, 'arg2', 'arg3' ] );
      test.is( _.strHas( o1.output, "[ 'arg1', 'arg3' ]" ) );
      test.is( _.strHas( o2.output, "[ 'arg2', 'arg3' ]" ) );

      return got;
    })
  })

  .thenKeep( () =>
  {
    var shell = _.process.starter
    ({
      execPath :  'node ' + testAppPath,
      outputCollecting : 1,
      outputPiping : 1
    })

    return shell({ execPath :  'arg1' })
    .thenKeep( ( got ) =>
    {
      test.identical( got.execPath, 'node' );
      test.is( _.strHas( got.output, "[ 'arg1' ]" ) );

      return got;
    })
  })

  .thenKeep( () =>
  {
    var shell = _.process.starter
    ({
      execPath :
      [
        'node ' + testAppPath,
        'node ' + testAppPath
      ],
      outputCollecting : 1,
      outputPiping : 1
    })

    return shell({ execPath :  'arg1' })
    .thenKeep( ( got ) =>
    {
      test.identical( got.length, 2 );

      let o1 = got[ 0 ];
      let o2 = got[ 1 ];

      test.identical( o1.execPath, 'node' );
      test.identical( o2.execPath, 'node' );
      test.is( _.strHas( o1.output, "[ 'arg1' ]" ) );
      test.is( _.strHas( o2.output, "[ 'arg1' ]" ) );

      return got;
    })
  })

  .thenKeep( () =>
  {
    var shell = _.process.starter
    ({
      execPath :
      [
        'node ' + testAppPath,
        'node ' + testAppPath
      ],
      outputCollecting : 1,
      outputPiping : 1
    })

    return shell({ execPath :  [ 'arg1', 'arg2' ]})
    .thenKeep( ( got ) =>
    {
      test.identical( got.length, 4 );

      let o1 = got[ 0 ];
      let o2 = got[ 1 ];
      let o3 = got[ 2 ];
      let o4 = got[ 3 ];

      test.identical( o1.execPath, 'node' );
      test.identical( o2.execPath, 'node' );
      test.identical( o3.execPath, 'node' );
      test.identical( o4.execPath, 'node' );
      test.is( _.strHas( o1.output, "[ 'arg1' ]" ) );
      test.is( _.strHas( o2.output, "[ 'arg1' ]" ) );
      test.is( _.strHas( o3.output, "[ 'arg2' ]" ) );
      test.is( _.strHas( o4.output, "[ 'arg2' ]" ) );

      return got;
    })
  })

  .thenKeep( () =>
  {
    var shell = _.process.starter
    ({
      execPath : 'node',
      args : 'arg1',
      outputCollecting : 1,
      outputPiping : 1
    })

    return shell({ execPath : testAppPath })
    .thenKeep( ( got ) =>
    {
      test.identical( got.execPath, 'node' );
      test.is( _.strHas( got.output, "[ 'arg1' ]" ) );

      return got;
    })
  })

  .thenKeep( () =>
  {
    var shell = _.process.starter
    ({
      execPath : 'node',
      args : 'arg1',
      outputCollecting : 1,
      outputPiping : 1
    })

    return shell({ execPath : testAppPath, args : 'arg2' })
    .thenKeep( ( got ) =>
    {
      test.identical( got.execPath, 'node' );
      test.is( _.strHas( got.output, "[ 'arg2' ]" ) );

      return got;
    })
  })

  .thenKeep( () =>
  {
    var shell = _.process.starter
    ({
      execPath : 'node',
      args : [ 'arg1', 'arg2' ],
      outputCollecting : 1,
      outputPiping : 1
    })

    return shell({ execPath : testAppPath, args : 'arg3' })
    .thenKeep( ( got ) =>
    {
      test.identical( got.execPath, 'node' );
      test.is( _.strHas( got.output, "[ 'arg3' ]" ) );

      return got;
    })
  })

  .thenKeep( () =>
  {
    var shell = _.process.starter
    ({
      execPath : 'node',
      args : 'arg1',
      outputCollecting : 1,
      outputPiping : 1
    })

    return shell({ execPath : testAppPath, args : [ 'arg2', 'arg3' ] })
    .thenKeep( ( got ) =>
    {
      test.identical( got.execPath, 'node' );
      test.is( _.strHas( got.output, "[ 'arg2', 'arg3' ]" ) );

      return got;
    })
  })

  return con;
}

sheller.timeOut = 60000;

//

function outputHandling( test )
{
  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );

  /* */

  function testApp()
  {
    console.log( 'testApp-output\n' );
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  var con = new _.Consequence().take( null );

  var modes = [ 'shell', 'spawn', 'exec', 'fork' ];
  var loggerOutput = '';

  function onTransformEnd( o )
  {
    loggerOutput += o.outputForPrinter[ 0 ];
  }
  var logger = new _.Logger({ output : null, onTransformEnd });

  modes.forEach( ( mode ) =>
  {
    let path = testAppPath;
    if( mode !== 'fork' )
    path = 'node ' + path;

    console.log( mode )

    con.thenKeep( () =>
    {
      loggerOutput = '';
      var o = { execPath : path, mode, outputPiping : 0, outputCollecting : 0, logger };
      return _.process.start( o )
      .thenKeep( () =>
      {
        test.identical( o.output, undefined );
        test.is( !_.strHas( loggerOutput, 'testApp-output') );
        console.log( loggerOutput )
        return true;
      })
    })

    con.thenKeep( () =>
    {
      loggerOutput = '';
      var o = { execPath : path, mode, outputPiping : 1, outputCollecting : 0, logger };
      return _.process.start( o )
      .thenKeep( () =>
      {
        test.identical( o.output, undefined );
        test.is( _.strHas( loggerOutput, 'testApp-output') );
        return true;
      })
    })

    con.thenKeep( () =>
    {
      loggerOutput = '';
      var o = { execPath : path, mode, outputPiping : 0, outputCollecting : 1, logger };
      return _.process.start( o )
      .thenKeep( () =>
      {
        test.identical( o.output, 'testApp-output\n\n' );
        test.is( !_.strHas( loggerOutput, 'testApp-output') );
        return true;
      })
    })

    con.thenKeep( () =>
    {
      loggerOutput = '';
      var o = { execPath : path, mode, outputPiping : 1, outputCollecting : 1, logger };
      return _.process.start( o )
      .thenKeep( () =>
      {
        test.identical( o.output, 'testApp-output\n\n' );
        test.is( _.strHas( loggerOutput, 'testApp-output') );
        return true;
      })
    })
  })

  return con;
}

outputHandling.timeOut = 10000;

//

function experiment( test )
{
  let self = this;

  var context = this;
  var routinePath = _.path.join( context.suitePath, test.name );

  /* */

  function testApp()
  {
  }

  /* */

  var testAppPath = _.fileProvider.path.nativize( _.path.join( routinePath, 'testApp.js' ) );
  var testAppCode = testApp.toString() + '\ntestApp();';
  var expectedOutput = __dirname + '\n'
  _.fileProvider.fileWrite( testAppPath, testAppCode );

  let ChildProcess = require( 'child_process' );

  let ready = new _.Consequence().take( null )
  for( var i = 0; i < 1000; i++ )
  ready.then( () => f() );

  return ready;

  /*  */

  function f()
  {
    var con = new _.Consequence().take( null );

    con.thenKeep( function()
    {
      test.case = 'no args';

      let r = new _.Consequence();
      var process = ChildProcess.fork( testAppPath, [], {} );
      process.on( 'close', () =>
      {
        r.take( 1 );
      });

      return r;
    })

    con.thenKeep( function()
    {
      test.case = 'deasync';
      _.timeOut( 1 ).finallyDeasyncGive();
      return null;
    })

    return con;
  }
}

experiment.experimental = 1;

//

var Proto =
{

  name : 'Tools.base.l4.ProcessBasic',
  silencing : 1,
  routineTimeOut : 60000,
  onSuiteBegin : testDirMake,
  onSuiteEnd : testDirClean,

  context :
  {

    suitePath : null,
    testApp,
    testAppShell
  },

  tests :
  {

    appArgs,
    appExitHandlerOnce,

    shell,
    shellSync,
    shellSyncAsync,
    shell2,
    shellCurrentPath,
    shellCurrentPaths,
    shellFork,
    shellWithoutExecPath,

    shellArgumentsParsing,
    shellArgumentsParsingNonTrivial,
    shellArgumentsNestedQuotes,
    shellVerbosity,
    shellErrorHadling,
    shellNode,

    shellTerminate,

    shellConcurrent,
    shellerConcurrent,

    sheller,

    outputHandling,

  },

}

_.mapExtend( Self,Proto );

//

Self = wTestSuite( Self );

if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self )

})();
