( function _Predefined_s_() {

'use strict';

/**
 * @file Predefined.s.
 */

/**
  @module Tools/base/Fundamental - Collection of general purpose tools for solving problems. Fundamentally extend JavaScript without spoiling namespace, so may be used solely or in conjunction with another module of such kind. Tools contain hundreds of routines to operate effectively with Array, SortedArray, Map, RegExp, Buffer, Time, String, Number, Routine, Error and other fundamental types. The module provides advanced tools for diagnostics and errors handling. Use it to have a stronger foundation for the application.
*/

/**
 * wTools - Generic purpose tools of base level for solving problems in Java Script.
 * @namespace wTools
 */

// global

let _global = undefined;
if( !_global && typeof Global !== 'undefined' && Global.Global === Global ) _global = Global;
if( !_global && typeof global !== 'undefined' && global.global === global ) _global = global;
if( !_global && typeof window !== 'undefined' && window.window === window ) _global = window;
if( !_global && typeof self   !== 'undefined' && self.self === self ) _global = self;
let _realGlobal = _global._realGlobal_ = _global;
let _wasGlobal = _global._global_ || _global;
_global = _wasGlobal;
_global._global_ = _wasGlobal;

// verification

if( _global_.__GLOBAL_WHICH__ === 'real' )
{

  if( _global_.wBase )
  {
    if( _global_.wTools.usePath )
    _global_.wTools.usePath( __dirname + '/../..' ); /* xxx : remove later */
    module[ 'exports' ] = _global_.wBase;
    return;
  }

  if( _global_.wBase )
  {
    throw new Error( 'wTools was included several times' );
  }

}

// config

if( _realGlobal.__GLOBAL_WHICH__ === undefined )
_realGlobal.__GLOBAL_WHICH__ = 'real';

if( !_realGlobal.Config )
_realGlobal.Config = { debug : true }
if( _realGlobal.Config.debug === undefined )
_realGlobal.Config.debug = true;
if( _realGlobal.Config.interpreter === undefined )
if( ( ( typeof module !== 'undefined' ) && ( typeof process !== 'undefined' ) ) )
_realGlobal.Config.interpreter = 'njs';
else
_realGlobal.Config.interpreter = 'browser';
if( _realGlobal.Config.isWorker === undefined )
if( !!( typeof self !== 'undefined' && self.self === self && typeof importScripts !== 'undefined' ) )
_realGlobal.Config.isWorker = true;
else
_realGlobal.Config.isWorker = false;

if( !_global_.Config )
_global_.Config = { debug : true }
if( _global_.Config.debug === undefined )
_global_.Config.debug = true;
if( _global_.Config.interpreter === undefined )
_global_.Config.interpreter = _realGlobal.Config.interpreter;
if( _global_.Config.isWorker === undefined )
_global_.Config.isWorker = _realGlobal.Config.isWorker

if( _global_.__GLOBAL_WHICH__ === 'real' )
if( _global_._ )
{
  _global_.Underscore = _global_._;
  delete _global_._;
}

if( Object.hasOwnProperty.call( _global, 'wTools' ) && _global !== _realGlobal_ )
throw Error( 'wTools was already defined' );

//

_global.wTools = Object.create( null );
_realGlobal_.wTools = _realGlobal_.wTools || Object.create( null );
let Self = _global.wTools;
let _ = Self;

Self.__GLOBAL_WHICH__ = _global.__GLOBAL_WHICH__;

// special globals

Self.def = Symbol.for( 'def' );
Self.nothing = Symbol.for( 'nothing' );
Self.maybe = Symbol.for( 'maybe' );
Self.uknown = Symbol.for( 'unknown' );
Self.dont = Symbol.for( 'dont' );
Self.unroll = Symbol.for( 'unroll' );
Self.self = Symbol.for( 'self' );

// type aliases

_realGlobal_.U32x = Uint32Array;
_realGlobal_.U16x = Uint16Array;
_realGlobal_.U8x = Uint8Array;
_realGlobal_.U8ClampedX = Uint8ClampedArray;

_realGlobal_.Ux = _realGlobal_.U32x;

_realGlobal_.I32x = Int32Array;
_realGlobal_.I16x = Int16Array;
_realGlobal_.I8x = Int8Array;
_realGlobal_.Ix = _realGlobal_.I32x;

_realGlobal_.F64x = Float64Array;
_realGlobal_.F32x = Float32Array;
_realGlobal_.Fx = _realGlobal_.F32x;

if( typeof Buffer !== 'undefined' )
_realGlobal_.BufferNode = Buffer;
_realGlobal_.BufferRaw = ArrayBuffer;
_realGlobal_.BufferRawShared = SharedArrayBuffer;
_realGlobal_.BufferView = DataView;

_realGlobal_.HashMap = Map;
_realGlobal_.HashMapWeak = WeakMap;

// --
// export
// --

_global[ 'wTools' ] = Self;
_global.wTools = Self;
_global.wBase = Self;

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
