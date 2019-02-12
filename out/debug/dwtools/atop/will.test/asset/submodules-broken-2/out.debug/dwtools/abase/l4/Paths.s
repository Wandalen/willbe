( function _Paths_s_() {

'use strict';

/**
 * @file Paths.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( '../l3/Path.s' );

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

function vectorize( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( routine ) );
  select = select || 1;
  return _.routineVectorize_functor
  ({
    routine : [ 'single', routine ],
    vectorizingArray : 1,
    vectorizingMap : 0,
    vectorizingKeys : 1,
    select : select,
  });
}

//

function vectorizeAsArray( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( routine ) );
  select = select || 1;

  let after = _.routineVectorize_functor
  ({
    routine : [ 'single', routine ],
    vectorizingArray : 1,
    vectorizingMap : 0,
    vectorizingKeys : 0,
    select : select,
  });

  return wrap;

  function wrap( srcs )
  {
    // _.assert( arguments.length === 1 );
    if( _.mapIs( srcs ) )
    srcs = _.mapKeys( srcs );
    arguments[ 0 ] = srcs;
    return after.apply( this, arguments );
  }

}

//

function vectorizeAll( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( routine ) );

  let routine2 = vectorizeAsArray( routine, select );

  return all;

  function all()
  {
    let result = routine2.apply( this, arguments );
    return _.all( result );
  }

}

//

function vectorizeAny( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( routine ) );

  let routine2 = vectorizeAsArray( routine, select );

  return any;

  function any()
  {
    let result = routine2.apply( this, arguments );
    return _.any( result );
  }

}

//

function vectorizeNone( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( routine ) );

  let routine2 = vectorizeAsArray( routine, select );

  return none;

  function none()
  {
    let result = routine2.apply( this, arguments );
    return _.none( result );
  }

}

//

function vectorizeOnly( routine )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( routine ) );
  return _.routineVectorize_functor
  ({
    routine : [ 'single', routine ],
    fieldFilter : _keyEndsPathFilter,
    vectorizingArray : 1,
    vectorizingMap : 1,
  });
}

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

  _keyEndsPathFilter : _keyEndsPathFilter,
  _isPathFilter : _isPathFilter,

  // checker

  are : vectorizeAsArray( 'is' ),
  areAbsolute : vectorizeAsArray( 'isAbsolute' ),
  areRelative : vectorizeAsArray( 'isRelative' ),
  areGlobal : vectorizeAsArray( 'isGlobal' ),
  areGlob : vectorizeAsArray( 'isGlob' ),
  areRefined : vectorizeAsArray( 'isRefined' ),
  areNormalized : vectorizeAsArray( 'isNormalized' ),
  areRoot : vectorizeAsArray( 'isRoot' ),
  areDotted : vectorizeAsArray( 'isDotted' ),
  areTrailed : vectorizeAsArray( 'isTrailed' ),
  areSafe : vectorizeAsArray( 'isSafe' ),

  allAre : vectorizeAll( 'is' ),
  allAreAbsolute : vectorizeAll( 'isAbsolute' ),
  allAreRelative : vectorizeAll( 'isRelative' ),
  allAreGlobal : vectorizeAll( 'isGlobal' ),
  allAreGlob : vectorizeAll( 'isGlob' ),
  allAreRefined : vectorizeAll( 'isRefined' ),
  allAreNormalized : vectorizeAll( 'isNormalized' ),
  allAreRoot : vectorizeAll( 'isRoot' ),
  allAreDotted : vectorizeAll( 'isDotted' ),
  allAreTrailed : vectorizeAll( 'isTrailed' ),
  allAreSafe : vectorizeAll( 'isSafe' ),

  anyAre : vectorizeAny( 'is' ),
  anyAreAbsolute : vectorizeAny( 'isAbsolute' ),
  anyAreRelative : vectorizeAny( 'isRelative' ),
  anyAreGlobal : vectorizeAny( 'isGlobal' ),
  anyAreGlob : vectorizeAny( 'isGlob' ),
  anyAreRefined : vectorizeAny( 'isRefined' ),
  anyAreNormalized : vectorizeAny( 'isNormalized' ),
  anyAreRoot : vectorizeAny( 'isRoot' ),
  anyAreDotted : vectorizeAny( 'isDotted' ),
  anyAreTrailed : vectorizeAny( 'isTrailed' ),
  anyAreSafe : vectorizeAny( 'isSafe' ),

  noneAre : vectorizeNone( 'is' ),
  noneAreAbsolute : vectorizeNone( 'isAbsolute' ),
  noneAreRelative : vectorizeNone( 'isRelative' ),
  noneAreGlobal : vectorizeNone( 'isGlobal' ),
  noneAreGlob : vectorizeNone( 'isGlob' ),
  noneAreRefined : vectorizeNone( 'isRefined' ),
  noneAreNormalized : vectorizeNone( 'isNormalized' ),
  noneAreRoot : vectorizeNone( 'isRoot' ),
  noneAreDotted : vectorizeNone( 'isDotted' ),
  noneAreTrailed : vectorizeNone( 'isTrailed' ),
  noneAreSafe : vectorizeNone( 'isSafe' ),

  // normalizer

  refine : vectorize( 'refine' ),
  normalize : vectorize( 'normalize' ),
  nativize : vectorize( 'nativize' ),
  dot : vectorize( 'dot' ),
  undot : vectorize( 'undot' ),
  trail : vectorize( 'trail' ),
  detrail : vectorize( 'detrail' ),

  onlyRefine : vectorizeOnly( 'refine' ),
  onlyNormalize : vectorizeOnly( 'normalize' ),
  onlyDot : vectorizeOnly( 'dot' ),
  onlyUndot : vectorizeOnly( 'undot' ),
  onlyTrail : vectorizeOnly( 'trail' ),
  onlyDetrail : vectorizeOnly( 'detrail' ),

  // joiner

  join : vectorize( 'join', Infinity ),
  joinRaw : vectorize( 'joinRaw', Infinity ),
  joinIfDefined : vectorize( 'joinIfDefined', Infinity ),
  reroot : vectorize( 'reroot', Infinity ),
  resolve : vectorize( 'resolve', Infinity ),
  joinNames : vectorize( 'joinNames', Infinity ),

  // path cut off

  dir : vectorize( 'dir' ),
  prefixGet : vectorize( 'prefixGet' ),
  name : vectorize( 'name' ),
  withoutExt : vectorize( 'withoutExt' ),
  changeExt : vectorize( 'changeExt', 2 ),
  ext : vectorize( 'ext' ),
  exts : vectorize( 'exts' ),

  onlyDir : vectorizeOnly( 'dir' ),
  onlyPrefixGet : vectorizeOnly( 'prefixGet' ),
  onlyName : vectorizeOnly( 'name' ),
  onlyWithoutExt : vectorizeOnly( 'withoutExt' ),
  onlyExt : vectorizeOnly( 'ext' ),

  // path transformer

  from : vectorize( 'from' ),
  relative : vectorize( 'relative', 2 ),
  common : vectorize( 'common', Infinity ),

}

_.mapSupplementOwn( Self, Fields );
_.mapSupplementOwn( Self, Routines );

_.assert( _.path.s === null );
_.path.s = Self;

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
