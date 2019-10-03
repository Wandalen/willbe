(function _Setup_s_() {

'use strict';

let _global = _global_;
let _ = _global.wTools;
let Self = _global.wTools;

// --
// setup
// --

function _setupUnhandledErrorHandler1()
{

  if( !_global._setupUnhandledErrorHandlerDone )
  {
    debugger;
    throw Error( 'setup0 should be called first' );
  }

  if( _global._setupUnhandledErrorHandlerDone > 1 )
  return;

  _global._setupUnhandledErrorHandlerDone = 2;

  /* */

  if( _global.process && _.routineIs( _global.process.on ) )
  {
    Self._handleUnhandledError1 = handleNodeError;
  }
  else if( Object.hasOwnProperty.call( _global,'onerror' ) )
  {
    Self._handleUnhandledError1 = handleBrowserError;
  }

  /* */

  function handleBrowserError( message, sourcePath, lineno, colno, error )
  {

    let err = error;
    if( _._err )
    err = _._err
    ({
      args : [ error ],
      level : 1,
      fallBackStack : 'at handleError @ ' + sourcePath + ':' + lineno,
      location :
      {
        path : sourcePath,
        line : lineno,
        col : colno,
      },
    });

    return handleError( err );
  }

  /* */

  function handleNodeError( err )
  {
    return handleError( err );
  }

  /* */

  function handleError( err )
  {
    let prefix = '------------------------------- unhandled error ------------------------------->\n';
    let postfix = '------------------------------- unhandled error -------------------------------<\n';

    /* */

    try
    {
      if( _.errIsAttended( err ) )
      return
    }
    catch( err2 )
    {
      debugger;
      console.error( err2 );
    }

    /* */

    if( _.process && _.process.exitCode )
    try
    {
      _.process.exitCode( -1 )
    }
    catch( err2 )
    {
      debugger;
      console.log( err2 );
    }

    /* */

    console.error( prefix );

    /* */

    try
    {
      console.error( ' * Application' );
      console.error( _.diagnosticApplicationEntryPointInfo() + '\n' );
    }
    catch( err2 )
    {
      debugger;
      console.error( err2 );
    }

    /* */

    if( !err.originalMessage && _.objectLike && _.objectLike( err ) )
    try
    {
      let serr = _.toStr && _.field ? _.toStr.fields( err,{ errorAsMap : 1 } ) : err;
      console.error( err );
    }
    catch( err2 )
    {
      debugger;
      console.error( err2 );
    }

    try
    {
      if( _.errLog )
      _.errLog( err );
      else
      console.error( err );
    }
    catch( err2 )
    {
      debugger;
      console.error( err2 );
      console.error( err );
    }

    console.error( postfix );
    debugger;

  }

}

//

function _setupConfig()
{

  // if( _global.WTOOLS_PRIVATE )
  // return;

  if( _global.__GLOBAL_WHICH__ !== 'real' )
  return;

  if( !_global.Config )
  _global.Config = Object.create( null );

  if( _global.Config.debug === undefined )
  _global.Config.debug = true;

  _global.Config.debug = !!_global.Config.debug;

}

//

function _setupLoggerPlaceholder()
{

  if( !_global.console.debug )
  _global.console.debug = function debug()
  {
    this.log.apply( this,arguments );
  }

  if( !_global.logger )
  _global.logger =
  {
    log : function log() { console.log.apply( console,arguments ); },
    logUp : function logUp() { console.log.apply( console,arguments ); },
    logDown : function logDown() { console.log.apply( console,arguments ); },
    error : function error() { console.error.apply( console,arguments ); },
    errorUp :  function errorUp() { console.error.apply( console,arguments ); },
    errorDown : function errorDown() { console.error.apply( console,arguments ); },
  }

}

//

function _setupTesterPlaceholder()
{

  if( !_global.wTestSuite )
  _global.wTestSuite = function wTestSuite( testSuit )
  {

    if( !_realGlobal_.wTests )
    _realGlobal_.wTests = Object.create( null );

    if( !testSuit.suiteFilePath )
    testSuit.suiteFilePath = _.diagnosticLocation( 1 ).path;

    if( !testSuit.suiteFileLocation )
    testSuit.suiteFileLocation = _.diagnosticLocation( 1 ).full;

    _.assert( _.strDefined( testSuit.suiteFileLocation ),'Test suit expects a mandatory option ( suiteFileLocation )' );
    _.assert( _.objectIs( testSuit ) );

    if( !testSuit.abstract )
    _.assert( !_realGlobal_.wTests[ testSuit.name ],'Test suit with name "' + testSuit.name + '" already registered!' );
    _realGlobal_.wTests[ testSuit.name ] = testSuit;

    testSuit.inherit = function inherit()
    {
      this.inherit = _.longSlice( arguments );
    }

    return testSuit;
  }

  /* */

  if( !_realGlobal_.wTester )
  {
    _realGlobal_.wTester = Object.create( null );
    _realGlobal_.wTester.test = function test( testSuitName )
    {
      if( _.workerIs() )
      return;
      _.assert( arguments.length === 0 || arguments.length === 1 );
      _.assert( _.strIs( testSuitName ) || testSuitName === undefined, 'test : expects string {-testSuitName-}' );
      debugger;
      _.timeReady( function()
      {
        debugger;
        if( _realGlobal_.wTester.test === test )
        throw _.err( 'Cant wTesting.test, missing wTesting package' );
        _realGlobal_.wTester.test.call( _realGlobal_.wTester, testSuitName );
      });
    }
  }

}

//

function _setup1()
{

  Self._sourcePath = _.diagnosticStack([ 1, Infinity ]);

  _.assert( _global._WTOOLS_SETUP_EXPECTED_ !== false );

  if( _global._WTOOLS_SETUP_EXPECTED_ !== false )
  {
    _._setupConfig();
    _._setupUnhandledErrorHandler1();
    _._setupLoggerPlaceholder();
    _._setupTesterPlaceholder();
  }

  _.assert( !!Self.timeNow );

}

// --
// routines
// --

let Routines =
{

  _setupUnhandledErrorHandler1,

  _setupConfig,
  _setupLoggerPlaceholder,
  _setupTesterPlaceholder,

  _setup1,

}

Object.assign( Self,Routines );

Self._setup1();

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
