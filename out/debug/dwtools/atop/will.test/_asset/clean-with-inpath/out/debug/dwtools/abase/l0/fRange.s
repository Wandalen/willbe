( function _fRange_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
// let Object.prototype.toString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

// --
// range
// --

function rangeIs( range )
{
  _.assert( arguments.length === 1 );
  if( !_.numbersAre( range ) )
  return false;
  if( range.length !== 2 )
  return false;
  return true;
}

//

function rangeInInclusive( range, srcNumber )
{

  if( _.longIs( srcNumber ) )
  srcNumber = srcNumber.length;

  _.assert( arguments.length === 2 );
  _.assert( _.rangeIs( range ) );
  _.assert( _.numberIs( srcNumber ) );

  if( srcNumber < range[ 0 ] )
  return false;
  if( srcNumber > range[ 1 ] )
  return false;

  return true;
}

//

function rangeInExclusive( range, srcNumber )
{
  if( _.longIs( srcNumber ) )
  srcNumber = srcNumber.length;

  _.assert( arguments.length === 2 );
  _.assert( _.rangeIs( range ) );
  _.assert( _.numberIs( srcNumber ) );

  if( srcNumber <= range[ 0 ] )
  return false;
  if( srcNumber >= range[ 1 ] )
  return false;

  return true;
}

//

function rangeInInclusiveLeft( range, srcNumber )
{
  if( _.longIs( srcNumber ) )
  srcNumber = srcNumber.length;

  _.assert( arguments.length === 2 );
  _.assert( _.rangeIs( range ) );
  _.assert( _.numberIs( srcNumber ) );

  if( srcNumber < range[ 0 ] )
  return false;
  if( srcNumber >= range[ 1 ] )
  return false;

  return true;
}

//

function rangeInInclusiveRight( range, srcNumber )
{
  if( _.longIs( srcNumber ) )
  srcNumber = srcNumber.length;

  _.assert( arguments.length === 2 );
  _.assert( _.rangeIs( range ) );
  _.assert( _.numberIs( srcNumber ) );

  if( srcNumber < range[ 0 ] )
  return false;
  if( srcNumber >= range[ 1 ] )
  return false;

  return true;
}

//

function sureInRange( src, range )
{
  _.assert( arguments.length >= 2 );
  if( arguments.length !== 2 )
  debugger;
  let args = _.unrollFrom([ _.rangeIn( range, src ), () => 'Out of range' + _.rangeToStr( range ), _.unrollSelect( arguments, 2 ) ]);
  _.assert.apply( _, args );
  return true;
}

//

function assertInRange( src, range )
{
  _.assert( arguments.length >= 2 );
  if( arguments.length !== 2 )
  debugger;
  let args = _.unrollFrom([ _.rangeIn( range, src ), () => 'Out of range' + _.rangeToStr( range ), _.unrollSelect( arguments, 2 ) ]);
  _.assert.apply( _, args );
  return true;
}

//

function rangeFromLeft( range )
{
  _.assert( arguments.length === 1 );
  if( _.numberIs( range ) )
  return [ range, Infinity ];
  _.assert( _.longIs( range ) );
  _.assert( range.length === 1 || range.length === 2 );
  _.assert( range[ 0 ] === undefined || _.numberIs( range[ 0 ] ) );
  _.assert( range[ 1 ] === undefined || _.numberIs( range[ 1 ] ) );
  if( range[ 0 ] === undefined )
  return [ 0, range[ 1 ] ];
  if( range[ 1 ] === undefined )
  return [ range[ 0 ], Infinity ];
  return range;
}

//

function rangeFromRight( range )
{
  _.assert( arguments.length === 1 );
  if( _.numberIs( range ) )
  return [ range, Infinity ];
  _.assert( _.longIs( range ) );
  _.assert( range.length === 1 || range.length === 2 );
  _.assert( range[ 0 ] === undefined || _.numberIs( range[ 0 ] ) );
  _.assert( range[ 1 ] === undefined || _.numberIs( range[ 1 ] ) );
  if( range[ 0 ] === undefined )
  return [ 0, range[ 1 ] ];
  if( range[ 1 ] === undefined )
  return [ range[ 0 ], Infinity ];
  return range;
}

//

function rangeFromSingle( range )
{
  _.assert( arguments.length === 1 );
  if( _.numberIs( range ) )
  return [ range, range + 1 ];

  _.assert( _.longIs( range ) );
  _.assert( range.length === 1 || range.length === 2 );
  _.assert( range[ 0 ] === undefined || _.numberIs( range[ 0 ] ) );
  _.assert( range[ 1 ] === undefined || _.numberIs( range[ 1 ] ) );

  if( range[ 0 ] === undefined )
  if( range[ 1 ] !== undefined )
  return [ range[ 1 ]-1, range[ 1 ] ];
  else
  return [ 0, 1 ];

  if( range[ 1 ] === undefined )
  return [ range[ 0 ], range[ 0 ] + 1 ];
  return range;
}

//

function rangeClamp( dstRange, clampRange )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.rangeIs( dstRange ) );
  _.assert( _.rangeIs( clampRange ) );

  if( dstRange[ 0 ] < clampRange[ 0 ] )
  dstRange[ 0 ] = clampRange[ 0 ];
  else if( dstRange[ 0 ] > clampRange[ 1 ] )
  dstRange[ 0 ] = clampRange[ 1 ];

  if( dstRange[ 1 ] < clampRange[ 0 ] )
  dstRange[ 1 ] = clampRange[ 0 ];
  else if( dstRange[ 1 ] > clampRange[ 1 ] )
  dstRange[ 1 ] = clampRange[ 1 ];

  return dstRange;
}

//

function rangeNumberElements( range, increment )
{

  _.assert( _.rangeIs( range ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( increment === undefined )
  increment = 1;

  return increment ? ( range[ 1 ]-range[ 0 ] ) / increment : 0;

}

//

function rangeFirstGet( range,options )
{

  var options = options || Object.create( null );
  if( options.increment === undefined )
  options.increment = 1;

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( _.arrayIs( range ) )
  {
    return range[ 0 ];
  }
  else if( _.mapIs( range ) )
  {
    return range.first
  }
  _.assert( 0, 'unexpected type of range',_.strType( range ) );

}

//

function rangeLastGet( range,options )
{

  var options = options || Object.create( null );
  if( options.increment === undefined )
  options.increment = 1;

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( _.arrayIs( range ) )
  {
    return range[ 1 ];
  }
  else if( _.mapIs( range ) )
  {
    return range.last
  }
  _.assert( 0, 'unexpected type of range',_.strType( range ) );

}

//

function rangeToStr( range )
{
  _.assert( _.rangeIs( range ) );
  _.assert( arguments.length === 1 );
  return range[ 0 ] + '..' + range[ 1 ];
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

  // range

  /* qqq : good coverage of each routine is required */

  rangeIs,

  rangeInInclusive,
  rangeInExclusive,
  rangeInInclusiveLeft,
  rangeInInclusiveRight,
  rangeIn : rangeInInclusiveLeft,

  sureInRange,
  assertInRange,

  rangeFromLeft,
  rangeFromRight,
  rangeFromSingle,

  rangeClamp,
  rangeNumberElements,
  rangeFirstGet,
  rangeLastGet,

  rangeToStr,

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
