( function _fNumbers_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

let _ArrayIndexOf = Array.prototype.indexOf;
let _ArrayLastIndexOf = Array.prototype.lastIndexOf;
let _ArraySlice = Array.prototype.slice;
let _ArraySplice = Array.prototype.splice;
let _FunctionBind = Function.prototype.bind;
// let Object.prototype.toString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _ObjectPropertyIsEumerable = Object.propertyIsEnumerable;
let _ceil = Math.ceil;
let _floor = Math.floor;

// --
// number
// --

/**
 * @summary Checks if argument( src ) is a Number.
 * @returns Returns true if ( src ) is a Number, otherwise returns false.
 *
 * @example
 * numberIs( 5 );
 * // returns true
 *
 * @example
 * numberIs( 'song' );
 * // returns false
 *
 * @param {*} src.
 * @return {Boolean}.
 * @function numberIs
 * @memberof wTools
 */

function numberIs( src )
{
  return typeof src === 'number';
  return Object.prototype.toString.call( src ) === '[object Number]';
}

//

function numberIsNotNan( src )
{
  return _.numberIs( src ) && !isNaN( src );
}

//

function numberIsFinite( src )
{
  if( !_.numberIs( src ) )
  return false;
  return isFinite( src );
}

//

function numberIsInfinite( src )
{

  if( !_.numberIs( src ) )
  return false;

  return src === +Infinity || src === -Infinity;
}

//

function numberIsInt( src )
{

  if( !_.numberIs( src ) )
  return false;

  return Math.floor( src ) === src;
}

//

function numbersAre( src )
{
  _.assert( arguments.length === 1 );

  if( _.bufferTypedIs( src ) )
  return true;

  if( _.arrayLike( src ) )
  {
    for( let s = 0 ; s < src.length ; s++ )
    if( !_.numberIs( src[ s ] ) )
    return false;
    return true;
  }

  return false;
}

//

function numbersAreIdentical( src1, src2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  return Object.is( src1, src2 );
}

//

function numbersAreEquivalent( src1, src2, accuracy )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  if( accuracy === undefined )
  accuracy = _.accuracy;
  return Math.abs( src1-src2 ) <= accuracy;
}

//

function numbersAreFinite( src )
{

  if( _.longIs( src ) )
  {
    for( let s = 0 ; s < src.length ; s++ )
    if( !numbersAreFinite( src[ s ] ) )
    return false;
    return true;
  }

  if( !_.numberIs( src ) )
  return false;

  return isFinite( src );
}

//

function numbersArePositive( src )
{

  if( _.longIs( src ) )
  {
    for( let s = 0 ; s < src.length ; s++ )
    if( !numbersArePositive( src[ s ] ) )
    return false;
    return true;
  }

  if( !_.numberIs( src ) )
  return false;

  return src >= 0;
}

//

function numbersAreInt( src )
{

  if( _.longIs( src ) )
  {
    for( let s = 0 ; s < src.length ; s++ )
    if( !numbersAreInt( src[ s ] ) )
    return false;
    return true;
  }

  if( !_.numberIs( src ) )
  return false;

  return Math.floor( src ) === src;
}

//

function numberInRange( n,range )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( range.length === 2 );
  _.assert( _.numberIs( range[ 0 ] ) );
  _.assert( _.numberIs( range[ 1 ] ) );
  if( !_.numberIs( n ) )
  return false;
  return range[ 0 ] <= n && n <= range[ 1 ];
}

//

function numberClamp( src,low,high )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  if( arguments.length === 2 )
  {
    _.assert( arguments[ 1 ].length === 2 );
    low = arguments[ 1 ][ 0 ];
    high = arguments[ 1 ][ 1 ];
  }

  if( src > high )
  return high;

  if( src < low )
  return low;

  return src;
}

//

function numberMix( ins1, ins2, progress )
{
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  return ins1*( 1-progress ) + ins2*( progress );
}

// --
// fields
// --

let Fields =
{
}

// --
// routines
// --

let Routines =
{

  numberIs,
  numberIsNotNan,
  numberIsFinite,
  numberDefined : numberIsFinite,
  numberIsInfinite,
  numberIsInt,

  numbersAre,
  numbersAreIdentical,
  numbersAreEquivalent,
  numbersAreFinite,
  numbersArePositive,
  numbersAreInt,

  numberInRange,
  numberClamp,
  numberMix,

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
