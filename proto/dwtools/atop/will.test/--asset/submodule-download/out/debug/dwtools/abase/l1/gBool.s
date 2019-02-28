( function _gBool_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

// --
// bool
// --

// function boolIs( src )
// {
//   return src === true || src === false;
// }
//
// //
//
// function boolLike( src )
// {
//   let type = _ObjectToString.call( src );
//   return type === '[object Boolean]' || type === '[object Number]';
// }

//

function boolFrom( src )
{
  if( _.strIs( src ) )
  {
    src = src.toLowerCase();
    if( src == '0' ) return false;
    if( src == 'false' ) return false;
    if( src == 'null' ) return false;
    if( src == 'undefined' ) return false;
    if( src == '' ) return false;
    return true;
  }
  return Boolean( src );
}

// //
//
// function boolsAre( src )
// {
//   _.assert( arguments.length === 1 );
//   if( !_.arrayLike( src ) )
//   return false;
//   return src.filter( ( e ) => _.boolIs( e ) );
// }
//
// //
//
// function boolsAllAre( src )
// {
//   _.assert( arguments.length === 1 );
//   if( !_.arrayIs( src ) )
//   return _.boolIs( src );
//   return _.all( src.filter( ( e ) => _.boolIs( e ) ) );
// }
//
// //
//
// function boolsAnyAre( src )
// {
//   _.assert( arguments.length === 1 );
//   if( !_.arrayIs( src ) )
//   return _.boolIs( src );
//   return _.any( src.filter( ( e ) => _.boolIs( e ) ) );
// }
//
// //
//
// function boolsNoneAre( src )
// {
//   _.assert( arguments.length === 1 );
//   if( !_.arrayIs( src ) )
//   return _.boolIs( src );
//   return _.none( src.filter( ( e ) => _.boolIs( e ) ) );
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

  // boolIs : boolIs,
  // boolLike : boolLike,
  boolFrom : boolFrom,

  // boolsAre : boolsAre,
  // boolsAllAre : boolsAllAre,
  // boolsAnyAre : boolsAnyAre,
  // boolsNoneAre : boolsNoneAre,

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
