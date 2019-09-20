( function _PathsBasic_s_() {

'use strict';

/**
 * @file PathsBasic.s.
 */

/**
 * Collection of routines to operate multiple paths in the reliable and consistent way.
 * @namespace "wTools.paths"
 * @memberof module:Tools/PathBasic
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( '../l3/PathBasic.s' );

}

//

let _global = _global_;
let _ = _global_.wTools;
let Parent = _.path;
let Self = _.paths = _.paths || Object.create( Parent );

// --
//
// --

function _keyEndsPathFilter( e,k,c )
{
  if( _.strIs( k ) )
  {
    if( _.strEnds( k,'Path' ) )
    return true;
    else
    return false
  }
  return this.is( e );
}

//

function _isPathFilter( e )
{
  return this.is( e[ 0 ] )
}

//

function _vectorize( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( routine ) );
  select = select || 1;
  return _.routineVectorize_functor
  ({
    routine : [ 'single', routine ],
    vectorizingArray : 1,
    vectorizingMapVals : 0,
    vectorizingMapKeys : 1,
    select,
  });
}

//

function _vectorizeAsArray( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( routine ) );
  select = select || 1;

  let after = _.routineVectorize_functor
  ({
    routine : [ 'single', routine ],
    vectorizingArray : 1,
    vectorizingMapVals : 0,
    vectorizingMapKeys : 0,
    select,
  });

  return wrap;

  function wrap( srcs )
  {
    if( _.mapIs( srcs ) )
    srcs = _.mapKeys( srcs );
    arguments[ 0 ] = srcs;
    return after.apply( this, arguments );
  }

}

//

function _vectorizeAll( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( routine ) );

  let routine2 = _vectorizeAsArray( routine, select );

  return all;

  function all()
  {
    let result = routine2.apply( this, arguments );
    return _.all( result );
  }

}

//

function _vectorizeAny( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( routine ) );

  let routine2 = _vectorizeAsArray( routine, select );

  return any;

  function any()
  {
    let result = routine2.apply( this, arguments );
    return _.any( result );
  }

}

//

function _vectorizeNone( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( routine ) );

  let routine2 = _vectorizeAsArray( routine, select );

  return none;

  function none()
  {
    let result = routine2.apply( this, arguments );
    return _.none( result );
  }

}

//

function _vectorizeOnly( routine )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( routine ) );
  return _.routineVectorize_functor
  ({
    routine : [ 'single', routine ],
    fieldFilter : _keyEndsPathFilter,
    vectorizingArray : 1,
    vectorizingMapVals : 1,
  });
}

//

/**
 * @summary Check if elements from provided array( src ) are paths. Writes results into array.
 * @param {Array|Object} src
 * @example
 * _.path.s.are(['/a', 1 ]); //[ true, false ]
 * @returns {Array} Returns array of same size with check results.
 * @function are
 * @memberof module:Tools/PathBasic.wTools.paths
 */

/**
 * @summary Check if all elements from provided array( src ) are paths.
 * @param {Array|Object} src
 * @example
 * _.path.s.allAre(['/a', 1 ]); //false
 * @returns {Bollean} Returns true if all elements are paths or false.
 * @function allAre
 * @memberof module:Tools/PathBasic.wTools.paths
 */

/**
 * @summary Check if at least one element from provided array( src ) are paths.
 * @param {Array|Object} src
 * @example
 * _.path.s.anyAre(['/a', 1 ]); //true
 * @returns {Bollean} Returns true if at least one element is a path or false.
 * @function anyAre
 * @memberof module:Tools/PathBasic.wTools.paths
 */

 /**
 * @summary Check if provided array( src ) contains path element.
 * @param {Array|Object} src
 * @example
 * _.path.s.noneAre(['/a', 1 ]); //false
 * @returns {Bollean} Returns false if at least one element is a path, otherwise true.
 * @function noneAre
 * @memberof module:Tools/PathBasic.wTools.paths
 */

 /**
 * @summary Normalizes paths from array( src ).
 * @description Look {@link module:Tools/PathBasic.normalize _.path.normalize } for details.
 * @param {Array|Object} src
 * @example
 * _.path.s.normalize(['\\a', '/a/../b' ]); //['/a', '/b' ]
 * @returns {Array} Returns array with normalized paths.
 * @function normalize
 * @memberof module:Tools/PathBasic.wTools.paths
 */

/**
 * @summary Joins provided paths.
 * @description
 * Supports combining of arrays/maps/strings, see examples.
 * Look {@link module:Tools/PathBasic.join _.path.join } for details.
 * @param {...String|...Array|...Object} arguments
 *
 * @example //also works same as regular _.path.join
 * _.path.s.join( '/a', 'b' ); //'/a/b'
 *
 * @example //combining string with array
 * _.path.s.join( '/a', [ 'b', 'c' ], 'd' ); // [ '/a/b/d', '/a/c/d' ]
 *
 * @example //combining string with array and map
 * _.path.s.join( 'a', ['b', 'c'], {'d' : 1 } ); // { 'a/b/d' : 1, 'a/c/d' : 1 }
 *
 * @returns {Array|Object} Returns array with joined paths.
 * @function join
 * @memberof module:Tools/PathBasic.wTools.paths
 */

/**
 * @summary Gets parent dir for each path from array( src ). Writes results into array.
 * @description
 * Look {@link module:Tools/PathBasic.dir _.path.dir } for details.
 * @param {Array} src Array of paths
 *
 *  @example //also works same as regular _.path.dir
 * _.path.s.dir( '/a/b' ); // '/a'
 *
 * @example
 * _.path.s.dir( [ '/a/b', '/b/c' ] ); // [ '/a', '/b' ]
 *
 * @returns {Array} Returns array with results of dir operation.
 * @function dir
 * @memberof module:Tools/PathBasic.wTools.paths
 */

/**
 * @summary Gets name of each path from array( src ). Writes results into array.
 * @description
 * Look {@link module:Tools/PathBasic.name _.path.name } for details.
 * @param {Array} src Array of paths
 *
 *  @example //also works same as regular _.path.dir
 * _.path.s.name( '/a/b' ); // 'b'
 *
 * @example
 * _.path.s.name( [ '/a/b', '/b/c' ] ); // [ 'b', 'c' ]
 *
 * @returns {Array} Returns array with results of name operation.
 * @function name
 * @memberof module:Tools/PathBasic.wTools.paths
 */


/**
 * @summary Gets extension of each path from array( src ). Writes results into array.
 * @description
 * Look {@link module:Tools/PathBasic.ext _.path.ext } for details.
 * @param {Array} src Array of paths
 *
 *  @example //also works same as regular _.path.dir
 * _.path.s.ext( '/a/b.js' ); // 'js'
 *
 * @example
 * _.path.s.ext( [ '/a/b.js', '/b/c.s' ] ); // [ 'js', 's' ]
 *
 * @returns {Array} Returns array with results of ext operation.
 * @function ext
 * @memberof module:Tools/PathBasic.wTools.paths
 */


/**
 * @summary Gets common path
 * @description
 * Supports combining of arrays/maps/strings, see examples.
 * Look {@link module:Tools/PathBasic.common _.path.common } for details.
 * @param {...String|...Array|...Object} src Array of paths
 *
 * @example //also works same as regular _.path.common
 * _.path.s.common( '/a', '/a/b', '/a/c' ); //'/a'
 *
 * @example //combining string with array
 * _.path.s.common('/a', ['/a/b', '/c' ] ); // [ '/a', '/' ]
 *
 * @example //combining string with array and map
 * _.path.s.common('/a', ['/a/b', '/c' ], {'/a/b' : 1 } ) //{ '/a' : 1, '/': 1}
 *
 * @returns {Array|Object} Returns array with result for each combination of paths.
 * @function common
 * @memberof module:Tools/PathBasic.wTools.paths
 */

// --
// meta
// --

let OriginalInit = Parent.Init;
Parent.Init = function Init()
{
  let result = OriginalInit.apply( this, arguments );

  _.assert( _.objectIs( this.s ) );
  _.assert( this.s.single !== undefined );
  this.s = Object.create( this.s );
  this.s.single = this;

  return result;
}

// --
// fields
// --

let Fields =
{
  path : Parent,
}

// --
// routines
// --

let Routines =
{

  _keyEndsPathFilter,
  _isPathFilter,

  _vectorize,
  _vectorizeAsArray,
  _vectorizeAll,
  _vectorizeAny,
  _vectorizeNone,
  _vectorizeOnly,

  // checker

  are : _vectorizeAsArray( 'is' ),
  areAbsolute : _vectorizeAsArray( 'isAbsolute' ),
  areRelative : _vectorizeAsArray( 'isRelative' ),
  areGlobal : _vectorizeAsArray( 'isGlobal' ),
  areGlob : _vectorizeAsArray( 'isGlob' ),
  areRefined : _vectorizeAsArray( 'isRefined' ),
  areNormalized : _vectorizeAsArray( 'isNormalized' ),
  areRoot : _vectorizeAsArray( 'isRoot' ),
  areDotted : _vectorizeAsArray( 'isDotted' ),
  areTrailed : _vectorizeAsArray( 'isTrailed' ),
  areSafe : _vectorizeAsArray( 'isSafe' ),

  allAre : _vectorizeAll( 'is' ),
  allAreAbsolute : _vectorizeAll( 'isAbsolute' ),
  allAreRelative : _vectorizeAll( 'isRelative' ),
  allAreGlobal : _vectorizeAll( 'isGlobal' ),
  allAreGlob : _vectorizeAll( 'isGlob' ),
  allAreRefined : _vectorizeAll( 'isRefined' ),
  allAreNormalized : _vectorizeAll( 'isNormalized' ),
  allAreRoot : _vectorizeAll( 'isRoot' ),
  allAreDotted : _vectorizeAll( 'isDotted' ),
  allAreTrailed : _vectorizeAll( 'isTrailed' ),
  allAreSafe : _vectorizeAll( 'isSafe' ),

  anyAre : _vectorizeAny( 'is' ),
  anyAreAbsolute : _vectorizeAny( 'isAbsolute' ),
  anyAreRelative : _vectorizeAny( 'isRelative' ),
  anyAreGlobal : _vectorizeAny( 'isGlobal' ),
  anyAreGlob : _vectorizeAny( 'isGlob' ),
  anyAreRefined : _vectorizeAny( 'isRefined' ),
  anyAreNormalized : _vectorizeAny( 'isNormalized' ),
  anyAreRoot : _vectorizeAny( 'isRoot' ),
  anyAreDotted : _vectorizeAny( 'isDotted' ),
  anyAreTrailed : _vectorizeAny( 'isTrailed' ),
  anyAreSafe : _vectorizeAny( 'isSafe' ),

  noneAre : _vectorizeNone( 'is' ),
  noneAreAbsolute : _vectorizeNone( 'isAbsolute' ),
  noneAreRelative : _vectorizeNone( 'isRelative' ),
  noneAreGlobal : _vectorizeNone( 'isGlobal' ),
  noneAreGlob : _vectorizeNone( 'isGlob' ),
  noneAreRefined : _vectorizeNone( 'isRefined' ),
  noneAreNormalized : _vectorizeNone( 'isNormalized' ),
  noneAreRoot : _vectorizeNone( 'isRoot' ),
  noneAreDotted : _vectorizeNone( 'isDotted' ),
  noneAreTrailed : _vectorizeNone( 'isTrailed' ),
  noneAreSafe : _vectorizeNone( 'isSafe' ),

  // normalizer

  refine : _vectorize( 'refine' ),
  normalize : _vectorize( 'normalize' ),
  canonize : _vectorize( 'canonize' ),
  normalizeTolerant : _vectorize( 'normalizeTolerant' ),
  nativize : _vectorize( 'nativize' ),
  dot : _vectorize( 'dot' ),
  undot : _vectorize( 'undot' ),
  trail : _vectorize( 'trail' ),
  detrail : _vectorize( 'detrail' ),

  onlyRefine : _vectorizeOnly( 'refine' ),
  onlyNormalize : _vectorizeOnly( 'normalize' ),
  onlyDot : _vectorizeOnly( 'dot' ),
  onlyUndot : _vectorizeOnly( 'undot' ),
  onlyTrail : _vectorizeOnly( 'trail' ),
  onlyDetrail : _vectorizeOnly( 'detrail' ),

  // joiner

  join : _vectorize( 'join', Infinity ),
  joinRaw : _vectorize( 'joinRaw', Infinity ),
  joinIfDefined : _vectorize( 'joinIfDefined', Infinity ),
  reroot : _vectorize( 'reroot', Infinity ),
  resolve : _vectorize( 'resolve', Infinity ),
  joinNames : _vectorize( 'joinNames', Infinity ),

  // path cut off

  dir : _vectorize( 'dir' ),
  dirFirst : _vectorize( 'dirFirst' ),
  prefixGet : _vectorize( 'prefixGet' ),
  name : _vectorize( 'name' ),
  fullName : _vectorize( 'fullName' ),
  withoutExt : _vectorize( 'withoutExt' ),
  changeExt : _vectorize( 'changeExt', 2 ),
  ext : _vectorize( 'ext' ),
  exts : _vectorize( 'exts' ),

  onlyDir : _vectorizeOnly( 'dir' ),
  onlyPrefixGet : _vectorizeOnly( 'prefixGet' ),
  onlyName : _vectorizeOnly( 'name' ),
  onlyWithoutExt : _vectorizeOnly( 'withoutExt' ),
  onlyExt : _vectorizeOnly( 'ext' ),

  // path transformer

  from : _vectorize( 'from' ),
  relative : _vectorize( 'relative', 2 ),
  common : _vectorize( 'common', Infinity ),

}

_.mapSupplementOwn( Self, Fields );
_.mapSupplementOwn( Self, Routines );

_.assert( _.path.s === null );
_.path.s = Self;

Self.Init();

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
