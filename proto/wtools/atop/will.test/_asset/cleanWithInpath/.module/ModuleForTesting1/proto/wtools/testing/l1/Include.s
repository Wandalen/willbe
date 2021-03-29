( function _Include_s_()
{

'use strict';

const _global = undefined;
if( typeof _global_ !== 'undefined' && _global_._global_ === _global_ )
_global = _global_;
else if( typeof globalThis !== 'undefined' && globalThis.globalThis === globalThis )
_global = globalThis;
else if( typeof Global !== 'undefined' && Global.Global === Global )
_global = Global;
else if( typeof global !== 'undefined' && global.global === global )
_global = global;
else if( typeof window !== 'undefined' && window.window === window )
_global = window;
else if( typeof self !== 'undefined' && self.self === self )
_global = self;
if( !_global._globals_ )
{
  _global._globals_ = Object.create( null );
  _global._globals_.real = _global;
  _global._realGlobal_ = _global;
  _global._global_ = _global;
}

//

// let _wasGlobal, _wasCache;
// function globalNamespaceOpen( _global, name )
// {
//   if( _realGlobal_._globals_[ name ] )
//   throw Error( `Global namespace::${name} already exists!` );
//   let ModuleFileNative = require( 'module' );
//   if( _global.moduleNativeFilesMap && _global.moduleNativeFilesMap !== ModuleFileNative._cache )
//   throw Error( `Current global have native module files map of different global` );
//   _global.moduleNativeFilesMap = ModuleFileNative._cache;
//   _wasCache = ModuleFileNative._cache;
//   _wasGlobal = _global;
//   ModuleFileNative._cache = Object.create( null );
//   _global = Object.create( _global );
//   _global.moduleNativeFilesMap = ModuleFileNative._cache;
//   _global.__GLOBAL_NAME__ = name;
//   _global._global_ = _global;
//   _realGlobal_._global_ = _global;
//   _realGlobal_._globals_[ name ] = _global;
//   if( module.nativeFilesMap )
//   module.nativeFilesMap = ModuleFileNative._cache;
//   return _global;
// }
//
// //
//
// function globalNamespaceClose()
// {
//   let ModuleFileNative = require( 'module' );
//   ModuleFileNative._cache = _wasCache;
//   _realGlobal_._global_ = _wasGlobal;
// }

//

if( typeof module !== 'undefined' )
{

  if( _realGlobal_._test_ && _realGlobal_._test_._isReal_ )
  return;

  _global = globalNamespaceOpen( _global, '_test_' );

  require( '../l1/ModuleForTesting1.s' )
}

if( typeof module !== 'undefined' )
module[ 'exports' ] = _globals_._test_;

})();
