( function _gString_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

// --
// str
// --

function _strCutOff_pre( routine, args )
{
  let o;

  if( args.length > 1 )
  {
    o = { src : args[ 0 ], delimeter : args[ 1 ], number : args[ 2 ] };
  }
  else
  {
    o = args[ 0 ];
    _.assert( args.length === 1, 'Expects single argument' );
  }

  _.routineOptions( routine, o );
  _.assert( args.length === 1 || args.length === 2 || args.length === 3 );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( o.src ) );
  _.assert( _.strIs( o.delimeter ) || _.arrayIs( o.delimeter ) );

  return o;
}

//

/**
* @typedef {object} wTools~toStrInhalfOptions
* @property {string} [ o.src=null ] - Source string.
* @property {string | array} [ o.delimeter=' ' ] - Splitter of the string.
* @property {boolean} [ o.left=1 ] - Finds occurrence from begining of the string.
*/

/**
 * Finds occurrence of delimeter( o.delimeter ) in source( o.src ) and splits string in finded position by half.
 * If function finds  more then one occurrence, it separates string in the position of the last.
 *
 * @param {wTools~toStrInhalfOptions} o - Contains data and options {@link wTools~toStrInhalfOptions}.
 * @returns {array} Returns array with separated parts of string( o.src ) or original string if nothing finded.
 *
 * @example
 * //returns [ 'sample', 'string' ]
 * _._strIsolate( { src : 'sample,string', delimeter : [ ',' ] } );
 *
 * @example
 * //returns [ 'sample', 'string' ]
 *_._strIsolate( { src : 'sample string', delimeter : ' ' } )
 *
 * @example
 * //returns [ 'sample string,name', 'string' ]
 * _._strIsolate( { src : 'sample string,name string', delimeter : [ ',', ' ' ] } )
 *
 * @method _strIsolate
 * @throws { Exception } Throw an exception if no argument provided.
 * @throws { Exception } Throw an exception if( o ) is not a Map.
 * @throws { Exception } Throw an exception if( o.src ) is not a String.
 * @throws { Exception } Throw an exception if( o.delimeter ) is not a Array or String.
 * @throws { Exception } Throw an exception if( o ) is extended by uknown property.
 * @memberof wTools
 *
 */

function _strIsolate( o )
{
  let result = [];
  let number = o.number;
  let delimeter
  let index = o.left ? -1 : o.src.length;

  // let result = [ o.src.substring( 0,i ), o.delimeter, o.src.substring( i+o.delimeter.length,o.src.length ) ];

  _.assertRoutineOptions( _strIsolate, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.src ), 'Expects string {-o.src-}, got',_.strType( o.src ) );
  _.assert( _.strIs( o.delimeter ) || _.arrayIs( o.delimeter ) );
  _.assert( _.numberIs( o.number ) );

  /* */

  if( !( number >= 1 ) )
  {
    // debugger;
    return whatLeft( o.left ^ o.none );
  }

  if( _.arrayIs( o.delimeter ) && o.delimeter.length === 1 )
  o.delimeter = o.delimeter[ 0 ];

  let closest = o.left ? entityMin : entityMax;

  /* */

  while( number > 0 )
  {

    index += o.left ? +1 : -1;

    if( _.arrayIs( o.delimeter ) )
    {

      if( !o.delimeter.length )
      {
        // debugger;
        return whatLeft( o.left ^ o.none );
      }

      let c = closest( index )

      delimeter = c.element;
      index = c.value;

      if( o.number === 1 && index === o.src.length && o.left )
      index = -1;

    }
    else
    {

      delimeter = o.delimeter;
      index = o.left ? o.src.indexOf( delimeter,index ) : o.src.lastIndexOf( delimeter,index );

      if( o.left && !( index >= 0 ) && o.number > 1 )
      {
        index = o.src.length;
        break;
      }

    }

    /* */

    if( !o.left && number > 1 && index === 0  )
    {
      // debugger;
      return whatLeft( !o.none )
    }

    if( !( index >= 0 ) && o.number === 1 )
    {
      // debugger;
      return whatLeft( o.left ^ o.none )
    }

    number -= 1;

  }

  /* */

  result.push( o.src.substring( 0,index ) );
  result.push( delimeter );
  result.push( o.src.substring( index + delimeter.length ) );

  return result;

  /* */

  function whatLeft( side )
  {
    return ( side ) ? [ o.src, '', '' ] : [ '', '', o.src ];
  }

  /* */

  function entityMin( index )
  {
    return _.entityMin( o.delimeter,function( a )
    {
      let i = o.src.indexOf( a,index );
      if( i === -1 )
      return o.src.length;
      return i;
    });
  }

  /* */

  function entityMax( index )
  {
    return _.entityMax( o.delimeter,function( a )
    {
      let i = o.src.lastIndexOf( a,index );
      return i;
    });
  }

}

_strIsolate.defaults =
{
  src : null,
  delimeter : ' ',
  quoting : null,
  left : 1,
  number : 1,
  none : 1,
}

//

/**
 * Short-cut for _strIsolate function.
 * Finds occurrence of delimeter( o.delimeter ) from begining of ( o.src ) and splits string in finded position by half.
 *
 * @param {wTools~toStrInhalfOptions} o - Contains data and options {@link wTools~toStrInhalfOptions}.
 * @returns {array} Returns array with separated parts of string( o.src ) or original string if nothing finded.
 *
 * @example
 * //returns [ 'sample', 'string' ]
 * _.strIsolateBeginOrNone( { src : 'sample,string', delimeter : [ ',' ] } );
 *
 * @example
 * //returns [ 'sample', 'string' ]
 *_.strIsolateBeginOrNone( { src : 'sample string', delimeter : ' ' } )
 *
 * @example
 * //returns [ 'sample string,name', 'string' ]
 * _.strIsolateBeginOrNone( 'sample string,name string', ',' )
 *
 * @method strIsolateBeginOrNone
 * @throws { Exception } Throw an exception if no argument provided.
 * @throws { Exception } Throw an exception if( o ) is not a Map.
 * @throws { Exception } Throw an exception if( o.src ) is not a String.
 * @memberof wTools
 *
 */

function _strIsolateBeginOrNone_body( o )
{
  o.left = 1;
  o.none = 1;
  let result = _strIsolate( o );
  return result;
}

_strIsolateBeginOrNone_body.defaults =
{
  src : null,
  delimeter : ' ',
  number : 1,
  quoting : null,
}

// let strIsolateBeginOrNone = _.routineFromPreAndBody( _strCutOff_pre, _strIsolateBeginOrNone_body );

//

/**
 * Short-cut for _strIsolate function.
 * Finds occurrence of delimeter( o.delimeter ) from end of ( o.src ) and splits string in finded position by half.
 *
 * @param {wTools~toStrInhalfOptions} o - Contains data and options {@link wTools~toStrInhalfOptions}.
 * @returns {array} Returns array with separated parts of string( o.src ) or original string if nothing finded.
 *
 * @example
 * //returns [ 'sample', 'string' ]
 * _.strIsolateEndOrNone( { src : 'sample,string', delimeter : [ ',' ] } );
 *
 * @example
 * //returns [ 'sample', 'string' ]
 *_.strIsolateEndOrNone( { src : 'sample string', delimeter : ' ' } )
 *
 * @example
 * //returns [ 'sample, ', 'string' ]
 * _.strIsolateEndOrNone( { src : 'sample,  string', delimeter : [ ',', ' ' ] } )
 *
 * @method strIsolateEndOrNone
 * @throws { Exception } Throw an exception if no argument provided.
 * @throws { Exception } Throw an exception if( o ) is not a Map.
 * @throws { Exception } Throw an exception if( o.src ) is not a String.
 * @memberof wTools
 *
 */

function _strIsolateEndOrNone_body( o )
{
  o.left = 0;
  o.none = 1;
  let result = _strIsolate( o );
  return result;
}

_strIsolateEndOrNone_body.defaults =
{
  src : null,
  delimeter : ' ',
  number : 1,
  quoting : null,
}

// let strIsolateEndOrNone = _.routineFromPreAndBody( _strCutOff_pre, _strIsolateEndOrNone_body );

//

function _strIsolateEndOrAll_body( o )
{
  o.left = 0;
  o.none = 0;
  let result = _strIsolate( o );
  return result;

  // let i = o.src.lastIndexOf( o.delimeter );
  //
  // if( i === -1 )
  // return [ '', '', o.src ];
  //
  // let result = [ o.src.substring( 0,i ), o.delimeter, o.src.substring( i+o.delimeter.length,o.src.length ) ];
  //
  // return result;
}

_strIsolateEndOrAll_body.defaults =
{
  src : null,
  delimeter : ' ',
  number : 1,
  quoting : null,
}

// let strIsolateEndOrAll = _.routineFromPreAndBody( _strCutOff_pre, _strIsolateEndOrAll_body );

//

function _strIsolateBeginOrAll_body( o )
{
  o.left = 1;
  o.none = 0;
  let result = _strIsolate( o );
  return result;

  // let i = o.src.indexOf( o.delimeter );
  //
  // if( i === -1 )
  // return [ o.src, '', '' ];
  //
  // let result = [ o.src.substring( 0,i ), o.delimeter, o.src.substring( i+o.delimeter.length,o.src.length ) ];
  //
  // return result;
}

_strIsolateBeginOrAll_body.defaults =
{
  src : null,
  delimeter : ' ',
  number : 1,
  quoting : null,
}

// let strIsolateBeginOrAll = _.routineFromPreAndBody( _strCutOff_pre, _strIsolateBeginOrAll_body );

//

/**
  * Returns part of a source string( src ) between first occurrence of( begin ) and last occurrence of( end ).
  * Returns result if ( begin ) and ( end ) exists in source( src ) and index of( end ) is bigger the index of( begin ).
  * Otherwise returns undefined.
  *
  * @param { String } src - The source string.
  * @param { String } begin - String to find from begin of source.
  * @param { String } end - String to find from end source.
  *
  * @example
  * _.strIsolateInsideOrNone( 'abcd', 'a', 'd' );
  * //returns 'bc'
  *
  * @example
  * _.strIsolateInsideOrNone( 'aabcc', 'a', 'c' );
  * //returns 'aabcc'
  *
  * @example
  * _.strIsolateInsideOrNone( 'aabcc', 'a', 'a' );
  * //returns 'a'
  *
  * @example
  * _.strIsolateInsideOrNone( 'abc', 'a', 'a' );
  * //returns undefined
  *
  * @example
  * _.strIsolateInsideOrNone( 'abcd', 'x', 'y' )
  * //returns undefined
  *
  * @example
  * //index of begin is bigger then index of end
  * _.strIsolateInsideOrNone( 'abcd', 'c', 'a' )
  * //returns undefined
  *
  * @returns { string } Returns part of source string between ( begin ) and ( end ) or undefined.
  * @throws { Exception } If all arguments are not strings;
  * @throws { Exception } If ( argumets.length ) is not equal 3.
  * @function strIsolateInsideOrNone
  * @memberof wTools
  */

function _strIsolateInsideOrNone( src, begin, end )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  let b = _.strFirst( src, begin );

  if( b.entry === undefined )
  return;

  let e = _.strLast( src, end );

  if( e.entry === undefined )
  return;

  if( e.index < b.index + b.entry.length )
  return;

  let result = [ src.substring( 0, b.index ), b.entry, src.substring( b.index + b.entry.length, e.index ), e.entry, src.substring( e.index+e.entry.length, src.length ) ];

  return result;
}

//

function strIsolateInsideOrNone( src, begin, end )
{

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  if( _.arrayLike( src ) )
  {
    let result = [];
    for( let s = 0 ; s < src.length ; s++ )
    result[ s ] = _._strIsolateInsideOrNone( src[ s ], begin, end );
    return result;
  }
  else
  {
    return _._strIsolateInsideOrNone( src, begin, end );
  }

}

//

function _strIsolateInsideOrAll( src, begin, end )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  let b = _.strFirst( src, begin );

  if( b.entry === undefined )
  b = { entry : '', index : 0 }

  let e = _.strLast( src, end );

  if( e.entry === undefined )
  e = { entry : '', index : src.length }

  if( e.index < b.index + b.entry.length )
  {
    e.index = src.length;
    e.entry = '';
  }

  let result = [ src.substring( 0, b.index ), b.entry, src.substring( b.index + b.entry.length, e.index ), e.entry, src.substring( e.index+e.entry.length, src.length ) ];

  return result;
}

//

function strIsolateInsideOrAll( src, begin, end )
{

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  if( _.arrayLike( src ) )
  {
    let result = [];
    for( let s = 0 ; s < src.length ; s++ )
    result[ s ] = _._strIsolateInsideOrAll( src[ s ], begin, end );
    return result;
  }
  else
  {
    return _._strIsolateInsideOrAll( src, begin, end );
  }

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

  _strIsolate : _strIsolate,

  strIsolateBeginOrNone : _.routineFromPreAndBody( _strCutOff_pre, _strIsolateBeginOrNone_body ),
  strIsolateEndOrNone : _.routineFromPreAndBody( _strCutOff_pre, _strIsolateEndOrNone_body ),
  strIsolateEndOrAll : _.routineFromPreAndBody( _strCutOff_pre, _strIsolateEndOrAll_body ),
  strIsolateBeginOrAll : _.routineFromPreAndBody( _strCutOff_pre, _strIsolateBeginOrAll_body ),

  _strIsolateInsideOrNone : _strIsolateInsideOrNone,
  strIsolateInsideOrNone : strIsolateInsideOrNone,
  _strIsolateInsideOrAll : _strIsolateInsideOrAll,
  strIsolateInsideOrAll : strIsolateInsideOrAll,

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
