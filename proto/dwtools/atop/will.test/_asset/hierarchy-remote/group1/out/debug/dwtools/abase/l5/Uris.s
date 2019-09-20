( function _Uris_s_() {

'use strict';

/**
 * @file Uris.s.
 */

/**
 * Collection of routines to operate multiple uris in the reliable and consistent way.
 * @namespace "wTools.uri.s"
 * @memberof module:Tools/base/Uri
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( '../l4/Uri.s' );

}

//

let _ = _global_.wTools;
let Parent = _.uri;
let Self = _.uri.s = _.uri.s || Object.create( Parent );

// --
// functors
// --

let _vectorize = _.path.s._vectorize;
let _vectorizeOnly = _.path.s._vectorizeOnly;

// function _keyEndsUriFilter( e,k,c )
// {
//   _.assert( 0, 'not tested' );
//
//   if( _.strIs( k ) )
//   {
//     if( _.strEnds( k,'Uri' ) )
//     return true;
//     else
//     return false
//   }
//   return this.is( e );
// }
//
// //
//
// function _isUriFilter( e )
// {
//   return this.is( e[ 0 ] )
// }

// //
//
// function _vectorize( routine, select )
// {
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//   _.assert( _.strIs( routine ) );
//   select = select || 1;
//   return _.routineVectorize_functor
//   ({
//     routine : [ 'single', routine ],
//     vectorizingArray : 1,
//     vectorizingMapVals : 0,
//     vectorizingMapKeys : 1,
//     select,
//   });
// }
//
// //
//
// function _vectorizeOnly( routine )
// {
//   _.assert( arguments.length === 1 );
//   _.assert( _.strIs( routine ) );
//   return _.routineVectorize_functor
//   ({
//     routine : [ 'single', routine ],
//     fieldFilter : _keyEndsUriFilter,
//     vectorizingArray : 1,
//     vectorizingMapVals : 1,
//   });
// }

/**
 * @summary Parses uris from array `src`. Writes results into array.
 * @param {Array|String} src
 * @example
 * _.uri.s.parse( [ '/a', 'https:///stackoverflow.com' ] );
 * @returns {Array} Returns array with results of parse operation.
 * @function parse
 * @memberof module:Tools/base/Uri.wTools.uri.s
 */

/**
 * @summary Parses uris from array `src`. Looks only for atomic components of the uri. Writes results into array.
 * @description Atomic components: protocol,host,port,localWebPath,query,hash.
 * @param {Array|String} src
 * @example
 * _.uri.s.parseAtomic( [ '/a', 'https:///stackoverflow.com' ] );
 * @returns {Array} Returns array with results of parse operation.
 * @function parseAtomic
 * @memberof module:Tools/base/Uri.wTools.uri.s
 */

/**
 * @summary Parses uris from array `src`. Looks only for consecutive components of the uri. Writes results into array.
 * @description Consecutive components: protocol,longPath,query,hash.
 * @param {Array|String} src
 * @example
 * _.uri.s.parseConsecutive( [ '/a', 'https:///stackoverflow.com' ] );
 * @returns {Array} Returns array with results of parse operation.
 * @function parseConsecutive
 * @memberof module:Tools/base/Uri.wTools.uri.s
 */

 /**
 * @summary Assembles uris from array of components( src ).
 * @param {Array|Object} src
 * @example
 * _.uri.s.str( [ { localWebPath : '/a' }, { protocol : 'http', localWebPath : '/a' } ] );
 * //['/a', 'http:///a' ]
 * @returns {Array} Returns array of strings, each element represent a uri.
 * @function str
 * @memberof module:Tools/base/Uri.wTools.uri.s
 */

/**
 * @summary Complements current window uri origin with array of components.
 * @param {Array|Object} src
 * @example
 * _.uri.s.full( [ { localWebPath : '/a' }, { protocol : 'http', localWebPath : '/a' } ] );
 * @returns {Array} Returns array of strings, each element represent a uri.
 * @function full
 * @memberof module:Tools/base/Uri.wTools.uri.s
 */

// --
// fields
// --

let Fields =
{
  uri : Parent,
}

// --
// routines
// --

let Routines =
{

  // _keyEndsUriFilter,
  // _isUriFilter,
  //
  // _vectorize,
  // _vectorizeOnly,

  //

  parse : _vectorize( 'parse' ),
  parseAtomic : _vectorize( 'parseAtomic' ),
  parseConsecutive : _vectorize( 'parseConsecutive' ),

  onlyParse : _vectorizeOnly( 'parse' ),
  onlyParseAtomic : _vectorizeOnly( 'parseAtomic' ),
  onlyParseConsecutive : _vectorizeOnly( 'parseConsecutive' ),

  str : _vectorize( 'str' ),
  full : _vectorize( 'full' ),

  normalizeTolerant : _vectorize( 'normalizeTolerant' ),
  onlyNormalizeTolerant : _vectorizeOnly( 'normalizeTolerant' ),

  rebase : _vectorize( 'rebase', 3 ),

  documentGet : _vectorize( 'documentGet', 2 ),
  server : _vectorize( 'server' ),
  query : _vectorize( 'query' ),
  dequery : _vectorize( 'dequery' )

}

_.mapSupplementOwn( Self, Fields );
_.mapSupplementOwn( Self, Routines );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
