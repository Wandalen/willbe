( function _fTime_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wModuleForTesting1;
let Self = _global_.wModuleForTesting1;

let _ArrayIndexOf = Array.prototype.indexOf;
let _ArrayLastIndexOf = Array.prototype.lastIndexOf;
let _ArraySlice = Array.prototype.slice;
let _ArraySplice = Array.prototype.splice;
let _FunctionBind = Function.prototype.bind;
let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _ObjectPropertyIsEumerable = Object.propertyIsEnumerable;
let _ceil = Math.ceil;
let _floor = Math.floor;

// --
// time
// --

function dateIs( src )
{
  return Object.prototype.toString.call( src ) === '[object Date]';
}

//

function datesAreIdentical( src1, src2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( !_.dateIs( src1 ) )
  return false;
  if( !_.dateIs( src2 ) )
  return false;

  src1 = src1.getTime();
  src2 = src2.getTime();

  return src1 === src2;
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

  dateIs,
  datesAreIdentical,

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();