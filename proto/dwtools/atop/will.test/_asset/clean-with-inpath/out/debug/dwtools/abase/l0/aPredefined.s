( function _aPredefined_s_() {

'use strict'; 

/**
 * @file aPredefined.s.
 */

// /**
//   @module Tools/base/Fundamental - Collection of general purpose tools for solving problems. Fundamentally extend JavaScript without corrupting it, so may be used solely or in conjunction with another module of such kind. Tools contain hundreds of routines to operate effectively with Array, SortedArray, Map, RegExp, Buffer, Time, String, Number, Routine, Error and other fundamental types. The module provides advanced tools for diagnostics and errors handling. Use it to have a stronger foundation for the application.
// */

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

if( !_global_.WTOOLS_PRIVATE )
{

  if( _global_.wBase )
  {
    if( _global_.wTools.usePath )
    _global_.wTools.usePath( __dirname + '/../..' );
    module[ 'exports' ] = _global_.wBase;
    return;
  }

  if( _global_.wBase )
  {
    throw new Error( 'wTools included several times' );
  }

}

// config

if( !_realGlobal.__which__ )
_realGlobal.__which__ = 'real';

if( !_realGlobal.Config )
_realGlobal.Config = { debug : true }
if( _realGlobal.Config.debug === undefined )
_realGlobal.Config.debug = true;
if( _realGlobal.Config.platform === undefined )
_realGlobal.Config.platform = ( ( typeof module !== 'undefined' ) && ( typeof process !== 'undefined' ) ) ? 'nodejs' : 'browser';
if( _realGlobal.Config.isWorker === undefined )
_realGlobal.Config.isWorker = !!( typeof self !== 'undefined' && self.self === self && typeof importScripts !== 'undefined' );

if( !_global_.Config )
_global_.Config = { debug : true }
if( _global_.Config.debug === undefined )
_global_.Config.debug = true;
if( _global_.Config.platform === undefined )
_global_.Config.platform = ( ( typeof module !== 'undefined' ) && ( typeof process !== 'undefined' ) ) ? 'nodejs' : 'browser';
if( _global_.Config.isWorker === undefined )
_global_.Config.isWorker = !!( typeof self !== 'undefined' && self.self === self && typeof importScripts !== 'undefined' );

if( !_global_.WTOOLS_PRIVATE  )
if( !_global_.Underscore && _global_._ )
_global_.Underscore = _global_._;

if( Object.hasOwnProperty.call( _global, 'wTools' ) && _global !== _realGlobal_ )
throw Error( 'wTools was already defined' );

//

_global.wTools = Object.create( null );
_realGlobal_.wTools = _realGlobal_.wTools || Object.create( null );
let Self = _global.wTools;
let _ = Self;

Self.__which__ = _global.__which__;

// special globals

Self.def = Symbol.for( 'def' );
Self.nothing = Symbol.for( 'nothing' );
Self.maybe = Symbol.for( 'maybe' );
Self.dont = Symbol.for( 'dont' );
Self.unroll = Symbol.for( 'unroll' );
Self.hold = Symbol.for( 'hold' );

// type aliases

_global_.U32x = Uint32Array;
_global_.U16x = Uint16Array;
_global_.U8x = Uint8Array;
_global_.Ux = _global_.U32x;

_global_.I32x = Int32Array;
_global_.I16x = Int16Array;
_global_.I8x = Int8Array;
_global_.Ix = _global_.I32x;

_global_.F64x = Float64Array;
_global_.F32x = Float32Array;
_global_.Fx = _global_.F32x;

// --
// export
// --

_global[ 'wTools' ] = Self;
_global.wTools = Self;
_global.wBase = Self;

// if( typeof module !== 'undefined' )
// if( _global.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
