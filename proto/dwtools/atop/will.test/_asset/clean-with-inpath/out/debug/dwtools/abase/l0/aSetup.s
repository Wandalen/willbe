(function _aSetup_s_() {

'use strict';

let _global = _global_;
let _realGlobal = _global._realGlobal_
let _ = _global.wTools;
let Self = _global.wTools;;

// --
// setup
// --

function _setupUnhandledErrorHandler0()
{

  if( _global._setupUnhandledErrorHandlerDone )
  return;

  _global._setupUnhandledErrorHandlerDone = 1;

  let handlerWas = null;
  if( _global.process && typeof _global.process.on === 'function' )
  {
    handlerWas = _global.process.onUncaughtException;
    _global.process.on( 'uncaughtException', handleNodeError );
    Self._handleUnhandledError0 = handleNodeError;
    if( handlerWas )
    throw Error( 'not tested' );
  }
  else if( Object.hasOwnProperty.call( _global, 'onerror' ) )
  {
    handlerWas = _global.onerror;
    _global.onerror = handleBrowserError;
    Self._handleUnhandledError0 = handleBrowserError;
  }

  /* */

  function handleBrowserError( message, sourcePath, lineno, colno, error )
  {
    let result;

    if( Self._handleUnhandledError1 )
    result = Self._handleUnhandledError1.apply( this, arguments );
    else
    result = handleError( new Error( message ) );

    if( handlerWas )
    handlerWas.apply( this, arguments );

    return result;
  }

  /* */

  function handleNodeError( err )
  {
    let result;

    if( Self._handleUnhandledError1 )
    result = Self._handleUnhandledError1.apply( this, arguments );
    else
    result = handleError( err );

    if( handlerWas )
    handlerWas.apply( this, arguments );

    if( _appExitError )
    _appExitError( -1 );

    if( Self._handleUnhandledError1 )
    return result;
  }

  /* */

  function handleError( err )
  {
    let prefix = '------------------------------- unhandled errorr ------------------------------->\n';
    let postfix = '------------------------------- unhandled errorr -------------------------------<\n';
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

  }

  /* */

  function _appExitError()
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

function _setup0()
{

  _setupUnhandledErrorHandler0();

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

  _handleUnhandledError0 : null,
  _handleUnhandledError1 : null,
  _setupUnhandledErrorHandler0,
  _setup0,

}

Object.assign( Self, Fields );
Object.assign( Self, Routines );

Self._setup0();

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
