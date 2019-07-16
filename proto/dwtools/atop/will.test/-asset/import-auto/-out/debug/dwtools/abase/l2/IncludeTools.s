( function _IncludeTools_s_() {

'use strict';

//

var usingSinglePath = 0;
var Self = _global_.wTools;
var _global = _global_;
var _ = _global_.wTools;
var _global = _global_;

var Module = null;
var __include;
if( typeof require !== 'undefined' )
__include = require;
else if( typeof importScripts !== 'undefined' )
__include = importScripts;
else if( _global._remoteRequire )
__include = _global._remoteRequire;

_global.ModulesRegistry = _global.ModulesRegistry || Object.create( null );

// _global.ModulesRegistry.ModulesRegistry =
// {
//   includeAny : [ '../../abase/l3/ModulesRegistry.s','l3/ModulesRegistry.s','wmodulesregistry' ],
//   isIncluded : function(){ return Object.keys( _global.ModulesRegistry ).length > 3 },
// }

// --
// routines
// --

function usePath( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( src ) );

  if( _.path && _.path.refine )
  src = _.path.refine( src );

  if( typeof module !== 'undefined' && module.paths )
  if( module.paths.indexOf( src ) === -1 )
  module.paths.push( src );

}

//

function usePathGlobally( paths )
{

  if( _.strIs( paths ) )
  paths = [ paths ];

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.arrayIs( paths ) );

  debugger;
  if( _.path.nativize && _.path.refine )
  {
    for( var p = 0 ; p < paths.length ; p++ )
    {
      paths[ p ] = _.path.nativize( _.path.resolve( paths[ p ] ) );
      console.log( 'usePathGlobally',paths[ p ] );
    }
  }

  return _usePathGlobally( module, paths, [] );
}

//

function _usePathGlobally( _module,paths,visited )
{

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.arrayIs( paths ) );

  if( visited.indexOf( _module ) !== -1 )
  return;

  if( !Module )
  Module = require( 'module' );

  for( let p = 0 ; p < paths.length ; p++ )
  if( Module.globalPaths.indexOf( paths[ p ] ) === -1 )
  Module.globalPaths.push( paths[ p ] );

  // [].push.apply( Module.globalPaths, paths );

  /* patch parents */

  while( _module )
  {
    _usePathGloballyChildren( _module, paths, visited );
    _module = _module.parent;
  }

}

//

function _usePathGloballyChildren( _module, paths, visited )
{

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.arrayIs( paths ) );

  if( visited.indexOf( _module ) !== -1 )
  return;

  visited.push( _module );

  for( let p = 0 ; p < paths.length ; p++ )
  if( _module.paths.indexOf( paths[ p ] ) === -1 )
  _module.paths.push( paths[ p ] );

  // [].push.apply( _module.paths, paths );

  /* patch parents */

  if( _module.children )
  for( var c = 0 ; c < _module.children.length ; c++ )
  _usePathGloballyChildren( _module.children[ c ], paths, visited );

}

//

function _includeWithRequireAct( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( src ),'include expects string' );

  /* console.log( '_includeWithRequireAct', '"' + src + '"' ); */

  if( typeof module !== 'undefined' )
  try
  {
    // if( _.strHas( src, 'Consequence' ) )
    // debugger;
    return __include( src );
  }
  catch( err )
  {
    debugger;
    throw _.err( err, '\n', 'Cant require', src );
  }
  else throw _.err( 'Cant include, no "require".' );

}

//

function _includeAct( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( src ) );

  var handler;
  if( _global.ModulesRegistry[ src ] )
  handler = _global.ModulesRegistry[ src ];

  if( !handler )
  {
    return _includeWithRequireAny( src );
  }

  /* */

  if( handler.isIncluded )
  if( handler.isIncluded() )
  return handler.returned;

  var result;
  if( handler.include )
  {
    result = _includeWithRequire( handler.include );
  }
  else if( handler.includeAny )
  {
    _.assert( _.arrayIs( handler.includeAny ),'include handler expect an array ( includeAny ) if present' );
    result = _includeWithRequireAny.apply( _,handler.includeAny );
  }
  else throw _.err( 'Handler does not has ( include ) neither ( includeAny ).\nCant use the handler to include file',src );

  handler.returned = result;

  return result;
}

//

function _includeAnyAct( srcs )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.longIs( srcs ) );

  /* */

  var paths = [];
  for( var s = 0 ; s < srcs.length ; s++ )
  {
    var src = srcs[ s ];
    var handler = _global.ModulesRegistry[ src ];

    if( !handler )
    {
      paths.push({ path : src });
      continue;
    }

    if( handler.isIncluded )
    if( handler.isIncluded() )
    return handler.returned;

    var result;
    if( handler.include )
    {
      paths.push({ path : handler.include, handler : handler }); debugger;
    }
    else if( handler.includeAny )
    {
      _.assert( _.arrayIs( handler.includeAny ),'include handler expect an array ( includeAny ) if present' );
      for( var p = 0 ; p < handler.includeAny.length ; p++ )
      paths.push({ path : handler.includeAny[ p ], handler : handler });
    }
    else throw _.err( 'Handler does not has ( include ) neither ( includeAny ).\nCant use the handler to include file',src );

  }

  /* */

  for( var a = 0 ; a < paths.length ; a++ )
  {
    var src = paths[ a ].path;

    if( src !== '' )
    try
    {
      var resolved = __include.resolve( src );
      src = resolved;
    }
    catch( err )
    {
      if( a !== paths.length-1 && !usingSinglePath )
      continue;
    }

    if( a === paths.length-1 && src === '' )
    return;

    var result = _includeWithRequireAct( src );
    if( paths[ a ].handler )
    paths[ a ].handler.returned = result;
    return result;
  }

  /* */

  debugger;
  throw _.err( 'Can include none of file',srcs );
}

//

function _includeWithRequire( src )
{
  if( arguments.length !== 1 )
  return _includeWithRequire( arguments );

  if( _.longIs( src ) )
  {
    var result = [];
    src = _.arrayFlatten( [], src );
    for( var a = 0 ; a < src.length ; a++ )
    result[ a ] = _includeWithRequireAct( src[ a ] );
    return result;
  }

  return _includeWithRequireAct( src );
}

//

function include( src )
{
  if( arguments.length !== 1 )
  return _includeAct( arguments );

  if( _.longIs( src ) )
  {
    var result = [];
    src = _.arrayFlatten( [], src );
    for( var a = 0 ; a < src.length ; a++ )
    result[ a ] = _includeAct( src[ a ] );
    return result;
  }

  return _includeAct( src );
}

//

function _includeWithRequireAny( src )
{
  var errors = [];

  for( var a = 0 ; a < arguments.length ; a++ )
  {
    var src = arguments[ a ];
    var resolved;

    if( src !== '' )
    try
    {
      resolved = __include.resolve( src );
      // src = resolved;
    }
    catch( err )
    {
      if( a !== arguments.length-1 && !usingSinglePath )
      continue;
    }

    if( a === arguments.length-1 && src === '' )
    return;

    var result = _includeWithRequireAct( resolved || arguments[ 0 ] );
    return result;

  }

  _.assert( 0,'unexpected' );
}

//

function includeAny()
{
  return _includeAnyAct( arguments );
}

//

function isIncluded( src )
{

  var handler;
  if( _global.ModulesRegistry[ src ] )
  handler = _global.ModulesRegistry[ src ];

  if( !handler )
  return false;

  if( !handler.isIncluded )
  return false;

  return handler.isIncluded();
}

// --
// declare
// --

var Proto =
{

  /* qqq : comment out maybe !!! */

  usePath : usePath,
  usePathGlobally : usePathGlobally,
  _usePathGlobally : _usePathGlobally,
  _usePathGloballyChildren : _usePathGloballyChildren,

  //

  _includeWithRequireAct : _includeWithRequireAct,
  _includeAct : _includeAct,
  _includeAnyAct : _includeAnyAct,

  _includeWithRequire : _includeWithRequire,
  include : include,

  _includeWithRequireAny : _includeWithRequireAny,
  includeAny : includeAny,

  isIncluded : isIncluded,

}

_.mapExtend( Self, Proto );

if( _.usePath && typeof __dirname !== 'undefined' )
_.usePath( __dirname + '/../..' );

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
