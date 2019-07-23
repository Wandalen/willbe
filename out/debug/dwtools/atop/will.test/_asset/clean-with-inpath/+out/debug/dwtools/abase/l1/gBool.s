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

/**
 * @summary Converts argument( src ) to boolean.
 * @function boolFrom
 * @param {*} src - entity to convert
 * @memberof wTools
 */

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

  boolFrom,

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
