(function _Setup_s_() {

'use strict';

let _global = _global_;
let _realGlobal = _global._realGlobal_
let _ = _global.wTools;
let Self = _global.wTools.setup = _global.wTools.setup || Object.create( null );

// --
// setup
// --

function _errUnhandledHandler1()
{

  let args = _.setup._errUnhandledPre( arguments );
  let result = _.setup._errUnhandledHandler2.apply( this, args );

  if( _.setup._errUnhandledHandler0 )
  _.setup._errUnhandledHandler0.apply( this, arguments );

  return result;
}

//

function _errUnhandledHandler2( err, kind )
{
  if( !kind )
  kind = 'unhandled error';
  let prefix = `--------------- ${kind} --------------->\n`;
  let postfix = `--------------- ${kind} ---------------<\n`;
  let errStr = err.toString();

  try
  {
    errStr = err.toString();
  }
  catch( err2 )
  {
    debugger;
    console.error( err2 );
  }

  console.error( prefix );
  console.error( errStr );
  console.error( err ? err.stack : '' );
  console.error( postfix );
  debugger;

  processExit();

  /* */

  function processExit()
  {
    try
    {
      if( _global.process )
      {
        if( !process.exitCode )
        process.exitCode = -1;
      }
    }
    catch( err )
    {
    }
  }

}

//

function _setupUnhandledErrorHandler0()
{

  if( _global._setupUnhandledErrorHandlerDone )
  return;

  _global._setupUnhandledErrorHandlerDone = 1;

  _.setup._errUnhandledHandler1 = _errUnhandledHandler1;
  if( _global.process && typeof _global.process.on === 'function' )
  {
    _global.process.on( 'uncaughtException', _.setup._errUnhandledHandler1 );
    _.setup._errUnhandledPre = _errPreNode;
  }
  else if( Object.hasOwnProperty.call( _global, 'onerror' ) )
  {
    _.setup._errUnhandledHandler0 = _global.onerror;
    _global.onerror = _.setup._errUnhandledHandler1;
    _.setup._errUnhandledPre = _errPreBrowser;
  }

  /* */

  function _errPreBrowser( args )
  {
    return [ new Error( args[ 0 ] ) ];
  }

  /* */

  function _errPreNode( args )
  {
    return args;
  }

  /* */

}

//

function _setup2()
{

  _.setup._setupUnhandledErrorHandler0();

}

// --
// extend
// --

let Fields =
{

  _setupUnhandledErrorHandlerDone : 0,

}

let Routines =
{

  _errUnhandledPre : null,
  _errUnhandledHandler0 : null,
  _errUnhandledHandler1,
  _errUnhandledHandler2,
  _setupUnhandledErrorHandler0,
  _setup2,

}

Object.assign( Self, Fields );
Object.assign( Self, Routines );

Self._setup2();

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
