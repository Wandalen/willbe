( function _WareCode_s_() {

'use strict';

let _ = wTools;

// debugger;
// let wasPrepareStackTrace = Error.prepareStackTrace;
// Error.prepareStackTrace = function( err, stack )
// {
//   debugger;
// }

// --
// begin
// --

function _Begin()
{

  'use strict';

  let _global = undefined;
  if( !_global && typeof Global !== 'undefined' && Global.Global === Global ) _global = Global;
  if( !_global && typeof global !== 'undefined' && global.global === global ) _global = global;
  if( !_global && typeof window !== 'undefined' && window.window === window ) _global = window;
  if( !_global && typeof self   !== 'undefined' && self.self === self ) _global = self;
  let _realGlobal = _global._realGlobal_ = _global;
  let _wasGlobal = _global._global_ || _global;
  _global = _wasGlobal;
  _global._global_ = _wasGlobal;

  if( !_global_.Config )
  _global_.Config = Object.create( null );
  if( _global_.Config.interpreter === undefined )
  _global_.Config.interpreter = ( ( typeof module !== 'undefined' ) && ( typeof process !== 'undefined' ) ) ? 'njs' : 'browser';
  if( _global_.Config.isWorker === undefined )
  _global_.Config.isWorker = !!( typeof self !== 'undefined' && self.self === self && typeof importScripts !== 'undefined' );

  if( _global._starter_ && _global._starter_._inited )
  return;

  let _starter_ = _global._starter_ = _global._starter_ || Object.create( null );
  let _ = _starter_;
  let path = _starter_.path = _starter_.path || Object.create( null );
  let sourcesMap = _starter_.sourcesMap = _starter_.sourcesMap || Object.create( null );

  //

  function assert()
  {
  }

  //

  function assertRoutineOptions()
  {
    return arguments[ 0 ];
  }

  //

  function assertMapHasOnly()
  {
  }

  //

  function assertMapHasNoUndefine()
  {
  }

  //

  function dir( filePath )
  {
    let canonized = this.canonize( filePath );
    let splits = canonized.split( '/' );
    if( splits[ splits.length-1 ] )
    splits.pop();
    return splits.join( '/' );
  }

  //

  function nativize()
  {
    if( _global.process && _global.process.platform === 'win32' )
    this.nativize = this._pathNativizeWindows;
    else
    this.nativize = this._pathNativizePosix;
    return this.nativize.apply( this, arguments );
  }

  //

  function toStr( src )
  {
    try
    {
      return String( src );
    }
    catch( err )
    {
      return '<COMPLEX>';
    }
  }

  //

  function mapFields( src )
  {
    let result = Object.create( null );
    if( !src )
    return result;
    for( let s in src )
    result[ s ] = src[ s ];
    return result;
  }

}

// --
// end
// --

function _End()
{

  let Extend =
  {

    assert,
    assertRoutineOptions,
    assertMapHasOnly,
    assertMapHasNoUndefine,
    toStr,
    mapFields,

    path,

  }

  Object.assign( _starter_, Extend );

  let ExtendPath =
  {

    dir,
    nativize,

  }

  Object.assign( _starter_.path, ExtendPath );

}

// --
//
// --

let Self =
{
  begin : _Begin,
  end : _End,
}

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
