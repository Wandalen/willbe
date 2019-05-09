( function _gRange_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

// --
// range
// --

// function rangeIs( range )
// {
//   _.assert( arguments.length === 1 );
//   if( !_.numbersAre( range ) )
//   return false;
//   if( range.length !== 2 )
//   return false;
//   return true;
// }
//
// //
//
// function rangeFrom( range )
// {
//   _.assert( arguments.length === 1 );
//   if( _.numberIs( range ) )
//   return [ range, Infinity ];
//   _.assert( _.longIs( range ) );
//   _.assert( range.length === 1 || range.length === 2 );
//   _.assert( range[ 0 ] === undefined || _.numberIs( range[ 0 ] ) );
//   _.assert( range[ 1 ] === undefined || _.numberIs( range[ 1 ] ) );
//   if( range[ 0 ] === undefined )
//   return [ 0, range[ 1 ] ];
//   if( range[ 1 ] === undefined )
//   return [ range[ 0 ], Infinity ];
//   return range;
// }
//
// //
//
// function rangeClamp( dstRange, clampRange )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( _.rangeIs( dstRange ) );
//   _.assert( _.rangeIs( clampRange ) );
//
//   if( dstRange[ 0 ] < clampRange[ 0 ] )
//   dstRange[ 0 ] = clampRange[ 0 ];
//   else if( dstRange[ 0 ] > clampRange[ 1 ] )
//   dstRange[ 0 ] = clampRange[ 1 ];
//
//   if( dstRange[ 1 ] < clampRange[ 0 ] )
//   dstRange[ 1 ] = clampRange[ 0 ];
//   else if( dstRange[ 1 ] > clampRange[ 1 ] )
//   dstRange[ 1 ] = clampRange[ 1 ];
//
//   return dstRange;
// }
//
// //
//
// function rangeNumberElements( range, increment )
// {
//
//   _.assert( _.rangeIs( range ) );
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   if( increment === undefined )
//   increment = 1;
//
//   return increment ? ( range[ 1 ]-range[ 0 ] ) / increment : 0;
//
// }
//
// //
//
// function rangeFirstGet( range,options )
// {
//
//   var options = options || Object.create( null );
//   if( options.increment === undefined )
//   options.increment = 1;
//
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   if( _.arrayIs( range ) )
//   {
//     return range[ 0 ];
//   }
//   else if( _.mapIs( range ) )
//   {
//     return range.first
//   }
//   _.assert( 0, 'unexpected type of range',_.strType( range ) );
//
// }
//
// //
//
// function rangeLastGet( range,options )
// {
//
//   var options = options || Object.create( null );
//   if( options.increment === undefined )
//   options.increment = 1;
//
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   if( _.arrayIs( range ) )
//   {
//     return range[ 1 ];
//   }
//   else if( _.mapIs( range ) )
//   {
//     return range.last
//   }
//   _.assert( 0, 'unexpected type of range',_.strType( range ) );
//
// }

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

  // rangeIs : rangeIs,
  // rangeFrom : rangeFrom,
  // rangeClamp : rangeClamp,
  // rangeNumberElements : rangeNumberElements,
  // rangeFirstGet : rangeFirstGet,
  // rangeLastGet : rangeLastGet,

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
