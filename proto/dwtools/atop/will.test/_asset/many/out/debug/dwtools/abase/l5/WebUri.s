( function _WebUri_s_() {

'use strict';

/**
 * Collection of routines to operate web URIs ( URLs ) in the reliable and consistent way. Module WebUri extends Uri module to handle host and port parts of URI in a way appropriate for world wide web resources. This module leverages parsing, joining, extracting, normalizing, nativizing, resolving paths. Use the module to get uniform experience from playing with paths on different platforms.
  @module Tools/base/WebUri
*/

/**
 * @file WebUri.s.
 */

/**
 * Collection of routines to operate web URIs ( URLs ) in the reliable and consistent way.
  @namespace "wTools.weburi"
  @memberof module:Tools/base/WebUri
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wPathBasic' );
  _.include( 'wUriBasic' );

}

//

let _global = _global_;
let _ = _global_.wTools;
let Parent = _.uri;
let Self = _.weburi = _.weburi || Object.create( Parent );

// --
//
// --

/**
 * @summary Checks if argument `path` is a absolute path.
 * @param {String} path Source path.
 * @returns {Boolean} Returns true if provided path is absolute.
 * @function isAbsolute
 * @memberof module:Tools/base/WebUri.wTools.weburi
 */

function isAbsolute( path )
{
  let parent = this.path;
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( path ), 'Expects string' );
  if( this.isGlobal( path ) )
  return true;
  return parent.isAbsolute( path );
}

//

/**
 * @summary Joins a sequence of paths into single web uri.
 * @param {...String} path Source paths.
 * @example
 * _.weburi.join( 'http://www.site.com:13','a','http:///dir','b' );
 * //'http://www.site.com:13/dir/b'
 * @returns {String} Returns normalized new web uri.
 * @function join
 * @memberof module:Tools/base/WebUri.wTools.weburi
 */

let join = Parent.join_functor( 'join', 1 );

/**
 * @summary Joins a sequence of paths into single web uri.
 * @param {...String} path Source paths.
 * @example
 * _.weburi.joinRaw( 'http://www.site.com:13','a','http:///dir///','b' );
 * //'http://www.site.com:13/dir////b'
 * @returns {String} Returns new web uri withou normalization.
 * @function joinRaw
 * @memberof module:Tools/base/WebUri.wTools.weburi
 */

let joinRaw = Parent.join_functor( 'joinRaw', 1 );

//

// let urisJoin = _.path._pathMultiplicator_functor
// ({
//   routine : join,
// });

//
//
// function resolve()
// {
//   let parent = this.path;
//   let result = Object.create( null );
//   let srcs = [];
//   let parsed = false;
//
//   for( let s = 0 ; s < arguments.length ; s++ )
//   {
//     if( this.isGlobal( arguments[ s ] ) )
//     {
//       parsed = true;
//       srcs[ s ] = this.parseConsecutive( arguments[ s ] );
//     }
//     else
//     {
//       srcs[ s ] = { longPath : arguments[ s ] };
//     }
//   }
//
//   for( let s = 0 ; s < srcs.length ; s++ )
//   {
//     let src = srcs[ s ];
//
//     if( !result.protocol && src.protocol !== undefined )
//     result.protocol = src.protocol;
//
//     // if( !result.host && src.host !== undefined )
//     // result.host = src.host;
//     //
//     // if( !result.port && src.port !== undefined )
//     // result.port = src.port;
//
//     if( !result.longPath && src.longPath !== undefined )
//     {
//       if( !_.strDefined( src.longPath ) )
//       src.longPath = this._rootStr;
//
//       result.longPath = src.longPath;
//     }
//     else
//     {
//       result.longPath = parent.resolve( result.longPath, src.longPath );
//     }
//
//     if( src.query !== undefined )
//     if( !result.query )
//     result.query = src.query;
//     else
//     result.query = src.query + '&' + result.query;
//
//     if( !result.hash && src.hash !==undefined )
//     result.hash = src.hash;
//
//   }
//
//   if( !parsed )
//   return result.longPath;
//
//   return this.str( result );
// }

/**
 * @summary Resolves a sequence of paths or path segments into web uri.
 * @description
 * The given sequence of paths is processed from right to left,with each subsequent path prepended until an absolute
 * path is constructed. If after processing all given path segments an absolute path has not yet been generated,
 * the current working directory is used.
 * @param {...String} path Source paths.
 * @example
 * _.weburi.resolve( 'http://www.site.com:13','a/../' );
 * //'http://www.site.com:13/'
 * @returns {String} Returns new web uri withou normalization.
 * @function resolve
 * @memberof module:Tools/base/WebUri.wTools.weburi
 */

function resolve()
{
  let parent = this.path;
  let joined = this.join.apply( this, arguments );
  let parsed = this.parseAtomic( joined );
  parsed.localWebPath = parent.resolve( parsed.localWebPath );
  return this.str( parsed );
}

//

// let urisResolve = _.path._pathMultiplicator_functor
// ({
//   routine : resolve,
// });

// --
// declare Fields
// --

let Fields =
{
  single : Self,
}

// --
// declare routines
// --

let Routines =
{

  isAbsolute,

  join,
  joinRaw,
  // urisJoin,

  resolve,
  // urisResolve,

}

_.mapSupplementOwn( Self, Fields );
_.mapSupplementOwn( Self, Routines );

Self.Init();

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
