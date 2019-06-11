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

function strIsolate_pre( routine, args )
{
  let o;

  if( args.length > 1 )
  {
    o = { src : args[ 0 ], delimeter : args[ 1 ], times : args[ 2 ] };
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
  _.assert( _.strsLikeAll( o.delimeter ) )
  _.assert( _.numberIs( o.times ) );

  return o;
}

//

/**
* @typedef {object} wTools.toStrInhalfOptions
* @property {string} [ o.src=null ] - Source string.
* @property {string | array} [ o.delimeter=' ' ] - Splitter of the string.
* @property {boolean} [ o.left=1 ] - Finds occurrence from begining of the string.
*/

/**
 * Finds occurrence of delimeter( o.delimeter ) in source( o.src ) and splits string in finded position by half.
 * If function finds  more then one occurrence, it separates string in the position of the last.
 *
 * @param {wTools.toStrInhalfOptions} o - Contains data and options {@link wTools.toStrInhalfOptions}.
 * @returns {array} Returns array with separated parts of string( o.src ) or original string if nothing finded.
 *
 * @example
 * //returns [ 'sample', 'string' ]
 * _.strIsolate( { src : 'sample, string', delimeter : [ ',' ] } );
 *
 * @example
 * //returns [ 'sample', 'string' ]
 *_.strIsolate( { src : 'sample string', delimeter : ' ' } )
 *
 * @example
 * //returns [ 'sample string, name', 'string' ]
 * _.strIsolate( { src : 'sample string, name string', delimeter : [ ',', ' ' ] } )
 *
 * @method strIsolate
 * @throws { Exception } Throw an exception if no argument provided.
 * @throws { Exception } Throw an exception if( o ) is not a Map.
 * @throws { Exception } Throw an exception if( o.src ) is not a String.
 * @throws { Exception } Throw an exception if( o.delimeter ) is not a Array or String.
 * @throws { Exception } Throw an exception if( o ) is extended by uknown property.
 * @memberof wTools
 *
 */

// function strIsolate( o )
// {
//   let result = [];
//   let times = o.times;
//   let delimeter
//   let index = o.left ? -1 : o.src.length;
//
//   _.assertRoutineOptions( strIsolate, o );
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( o.src ), 'Expects string {-o.src-}, got', _.strType( o.src ) );
//   _.assert( _.strIs( o.delimeter ) || _.arrayIs( o.delimeter ) );
//   _.assert( _.numberIs( o.times ) );
//
//   /* */
//
//   if( !( times >= 1 ) )
//   {
//     return everything( o.left ^ o.none );
//   }
//
//   if( _.arrayIs( o.delimeter ) && o.delimeter.length === 1 )
//   o.delimeter = o.delimeter[ 0 ];
//
//   let closest = o.left ? strLeft : strRight;
//
//   /* */
//
//   while( times > 0 )
//   {
//
//     index += o.left ? +1 : -1;
//
//     if( _.arrayIs( o.delimeter ) )
//     {
//
//       if( !o.delimeter.length )
//       {
//         return everything( o.left ^ o.none );
//       }
//
//       let c = closest( index );
//
//       delimeter = c.element;
//       index = c.value;
//
//       if( o.times === 1 && index === o.src.length && o.left )
//       index = -1;
//
//     }
//     else
//     {
//
//       delimeter = o.delimeter;
//       index = o.left ? o.src.indexOf( delimeter, index ) : o.src.lastIndexOf( delimeter, index );
//
//       if( o.left && !( index >= 0 ) && o.times > 1 )
//       {
//         index = o.src.length;
//         break;
//       }
//
//     }
//
//     /* */
//
//     if( !o.left && times > 1 && index === 0  )
//     {
//       return everything( !o.none )
//     }
//
//     if( !( index >= 0 ) && o.times === 1 )
//     {
//       return everything( o.left ^ o.none )
//     }
//
//     times -= 1;
//
//   }
//
//   /* */
//
//   result.push( o.src.substring( 0, index ) );
//   result.push( delimeter );
//   result.push( o.src.substring( index + delimeter.length ) );
//
//   return result;
//
//   /* */
//
//   function everything( side )
//   {
//     return ( side ) ? [ o.src, '', '' ] : [ '', '', o.src ];
//   }
//
//   /* */
//
//   function strLeft( index )
//   {
//     return _.entityMin( o.delimeter, function( a )
//     {
//       let i = o.src.indexOf( a, index );
//       if( i === -1 )
//       return o.src.length;
//       return i;
//     });
//   }
//
//   /* */
//
//   function strRight( index )
//   {
//     return _.entityMax( o.delimeter, function( a )
//     {
//       let i = o.src.lastIndexOf( a, index );
//       return i;
//     });
//   }
//
// }
//
// strIsolate.defaults =
// {
//   src : null,
//   delimeter : ' ',
//   quoting : null,
//   left : 1,
//   times : 1,
//   none : 1,
// }

function strIsolate_body( o )
{
  let result = [];
  let times = o.times;
  let delimeter
  let index = o.left ? 0 : o.src.length;
  let more = o.left ? strLeft : strRight;
  let delta = ( o.left ? +1 : -1 );

  _.assertRoutineOptions( strIsolate_body, arguments );

  /* */

  if( _.arrayIs( o.delimeter ) && o.delimeter.length === 1 )
  o.delimeter = o.delimeter[ 0 ];

  /* */

  while( times > 0 )
  {
    let found = more( index );

    if( found.entry === undefined )
    break;

    times -= 1;

    if( o.left )
    index = found.index + delta;
    else
    index = found.index + found.entry.length + delta;

    if( times === 0 )
    {
      result.push( o.src.substring( 0, found.index ) );
      result.push( found.entry );
      result.push( o.src.substring( found.index + found.entry.length ) );
      return result;
    }

    /* */

    if( o.left )
    {
      if( index >= o.src.length )
      break;
    }
    else
    {
      if( index <= 0 )
      break;
    }

  }

  /* */

  if( !result.length )
  {

    if( o.times === 0 )
    return everything( !o.left );
    else if( times === o.times )
    return everything( o.left ^ o.none );
    else
    return everything( o.left );

  }

  return result;

  /* */

  function everything( side )
  {
    return ( side ) ? [ o.src, undefined, '' ] : [ '', undefined, o.src ];
  }

  /* */

  function strLeft( index )
  {
    return _._strLeftSingle( o.src, o.delimeter, index, undefined );
  }

  /* */

  function strRight( index )
  {
    return _._strRightSingle( o.src, o.delimeter, undefined, index );
  }

}

strIsolate_body.defaults =
{
  src : null,
  delimeter : ' ',
  quoting : null,
  left : 1,
  times : 1,
  none : 1,
}

//

/**
 * Short-cut for strIsolate function.
 * Finds occurrence of delimeter( o.delimeter ) from begining of ( o.src ) and splits string in finded position by half.
 *
 * @param {wTools.toStrInhalfOptions} o - Contains data and options {@link wTools.toStrInhalfOptions}.
 * @returns {array} Returns array with separated parts of string( o.src ) or original string if nothing finded.
 *
 * @example
 * //returns [ 'sample', 'string' ]
 * _.strIsolateLeftOrNone( { src : 'sample, string', delimeter : [ ', ' ] } );
 *
 * @example
 * //returns [ 'sample', 'string' ]
 *_.strIsolateLeftOrNone( { src : 'sample string', delimeter : ' ' } )
 *
 * @example
 * //returns [ 'sample string, name', 'string' ]
 * _.strIsolateLeftOrNone( 'sample string, name string', ',' )
 *
 * @method strIsolateLeftOrNone
 * @throws { Exception } Throw an exception if no argument provided.
 * @throws { Exception } Throw an exception if( o ) is not a Map.
 * @throws { Exception } Throw an exception if( o.src ) is not a String.
 * @memberof wTools
 *
 */

function strIsolateLeftOrNone_body( o )
{
  o.left = 1;
  o.none = 1;
  let result = _.strIsolate.body( o );
  return result;
}

strIsolateLeftOrNone_body.defaults =
{
  src : null,
  delimeter : ' ',
  times : 1,
  quoting : null,
}

//

function strIsolateLeftOrAll_body( o )
{
  o.left = 1;
  o.none = 0;
  let result = _.strIsolate.body( o );
  return result;
}

strIsolateLeftOrAll_body.defaults =
{
  src : null,
  delimeter : ' ',
  times : 1,
  quoting : null,
}

//

/**
 * Short-cut for strIsolate function.
 * Finds occurrence of delimeter( o.delimeter ) from end of ( o.src ) and splits string in finded position by half.
 *
 * @param {wTools.toStrInhalfOptions} o - Contains data and options {@link wTools.toStrInhalfOptions}.
 * @returns {array} Returns array with separated parts of string( o.src ) or original string if nothing finded.
 *
 * @example
 * //returns [ 'sample', 'string' ]
 * _.strIsolateRightOrNone( { src : 'sample, string', delimeter : [ ',' ] } );
 *
 * @example
 * //returns [ 'sample', 'string' ]
 *_.strIsolateRightOrNone( { src : 'sample string', delimeter : ' ' } )
 *
 * @method strIsolateRightOrNone
 * @throws { Exception } Throw an exception if no argument provided.
 * @throws { Exception } Throw an exception if( o ) is not a Map.
 * @throws { Exception } Throw an exception if( o.src ) is not a String.
 * @memberof wTools
 *
 */

function strIsolateRightOrNone_body( o )
{
  o.left = 0;
  o.none = 1;
  let result = _.strIsolate.body( o );
  return result;
}

strIsolateRightOrNone_body.defaults =
{
  src : null,
  delimeter : ' ',
  times : 1,
  quoting : null,
}

//

function strIsolateRightOrAll_body( o )
{
  o.left = 0;
  o.none = 0;
  let result = _.strIsolate.body( o );
  return result;
}

strIsolateRightOrAll_body.defaults =
{
  src : null,
  delimeter : ' ',
  times : 1,
  quoting : null,
}

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

function strIsolateInsideOrNoneSingle( src, begin, end )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  let b = _.strLeft( src, begin );

  if( b.entry === undefined )
  return;

  let e = _.strRight( src, end );

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
    result[ s ] = _.strIsolateInsideOrNoneSingle( src[ s ], begin, end );
    return result;
  }
  else
  {
    return _.strIsolateInsideOrNoneSingle( src, begin, end );
  }

}

//

function strIsolateInsideOrAllSignle( src, begin, end )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  let b = _.strLeft( src, begin );

  if( b.entry === undefined )
  b = { entry : '', index : 0 }

  let e = _.strRight( src, end );

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
    result[ s ] = _.strIsolateInsideOrAllSignle( src[ s ], begin, end );
    return result;
  }
  else
  {
    return _.strIsolateInsideOrAllSignle( src, begin, end );
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

  strIsolate : _.routineFromPreAndBody( strIsolate_pre, strIsolate_body ),
  strIsolateLeftOrNone : _.routineFromPreAndBody( strIsolate_pre, strIsolateLeftOrNone_body ),
  strIsolateLeftOrAll : _.routineFromPreAndBody( strIsolate_pre, strIsolateLeftOrAll_body ),
  strIsolateRightOrNone : _.routineFromPreAndBody( strIsolate_pre, strIsolateRightOrNone_body ),
  strIsolateRightOrAll : _.routineFromPreAndBody( strIsolate_pre, strIsolateRightOrAll_body ),

  strIsolateInsideOrNoneSingle,
  strIsolateInsideOrNone,
  strIsolateInsideOrAllSignle,
  strIsolateInsideOrAll,

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
