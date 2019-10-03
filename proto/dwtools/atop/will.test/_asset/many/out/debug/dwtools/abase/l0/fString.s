( function _fString_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

// let _ArraySlice = Array.prototype.slice;
// let _FunctionBind = Function.prototype.bind;
// // let Object.prototype.toString = Object.prototype.toString;
// let Object.hasOwnProperty = Object.hasOwnProperty;

// --
// str
// --

/**
 * Function strIs checks incoming param whether it is string.
 * Returns "true" if incoming param is string. Othervise "false" returned
 *
 * @example
 * _.strIsIs( 'song' );
 * // returns true
 *
 * @example
 * _.strIs( 5 );
 * // returns false
 *
 * @param {*} src.
 * @return {Boolean}.
 * @function strIs.
 * @memberof wTools
 */

function strIs( src )
{
  let result = Object.prototype.toString.call( src ) === '[object String]';
  return result;
}

//

function strsAreAll( src )
{
  _.assert( arguments.length === 1 );

  if( _.arrayLike( src ) )
  {
    for( let s = 0 ; s < src.length ; s++ )
    if( !_.strIs( src[ s ] ) )
    return false;
    return true;
  }

  return strIs( src );
}

//

function strLike( src )
{
  if( _.strIs( src ) )
  return true;
  if( _.regexpIs( src ) )
  return true;
  return false
}

//

function strsLikeAll( src )
{
  _.assert( arguments.length === 1 );

  if( _.arrayLike( src ) )
  {
    for( let s = 0 ; s < src.length ; s++ )
    if( !_.strLike( src[ s ] ) )
    return false;
    return true;
  }

  return strLike( src );
}

//

function strDefined( src )
{
  if( !src )
  return false;
  let result = Object.prototype.toString.call( src ) === '[object String]';
  return result;
}

//

function strsDefined( src )
{
  if( _.arrayLike( src ) )
  {
    for( let s = 0 ; s < src.length ; s++ )
    if( !_.strDefined( src[ s ] ) )
    return false;
    return true;
  }
  return false;
}

// --
// converter
// --

function toStr( src, opts )
{
  let result = '';

  _.assert( arguments.length === 1 || arguments.length === 2 );

  result = _.str( src );

  return result;
}

toStr.fields = toStr;
toStr.routines = toStr;

//

/**
 * Return in one string value of all arguments.
 *
 * @example
 * let args = _.str( 'test2' );
 *
 * @return {string}
 * If no arguments return empty string
 * @function str
 * @memberof wTools
 */

function str()
{
  let result = '';
  let line;

  if( !arguments.length )
  return result;

  for( let a = 0 ; a < arguments.length ; a++ )
  {
    let src = arguments[ a ];

    if( src && src.toStr && !Object.hasOwnProperty.call( src, 'constructor' ) )
    line = src.toStr();
    else try
    {
      line = String( src );
    }
    catch( err )
    {
      line = _.strType( src );
    }

    result += line + ' ';
  }

  return result;
}

//

function strShort( src )
{
  let result = '';

  _.assert( arguments.length === 1, 'Expects exactly one argument' );

  try
  {

    if( _.primitiveIs( src ) )
    {
      return String( src );
    }
    else if( _.vectorAdapterIs( src ) )
    {
      result += '[ Vector with ' + src.length + ' elements' + ' ]';
    }
    else if( src && !_.objectIs( src ) && _.numberIs( src.length ) )
    {
      result += '[ ' + _.strType( src ) + ' with ' + src.length + ' elements ]';
    }
    else if( _.objectIs( src ) || _.objectLike( src ) )
    {
      result += '[ ' + _.strType( src ) + ' with ' + _.entityLength( src ) + ' elements' + ' ]';
    }
    else if( src instanceof Date )
    {
      result += src.toISOString();
    }
    else
    {
      result += String( src );
    }

  }
  catch( err )
  {
    throw err;
  }

  return result;
}

//

function strPrimitive( src )
{
  let result = '';

  _.assert( arguments.length === 1, 'Expects exactly one argument' );

  if( src === null || src === undefined )
  return;

  if( _.primitiveIs( src ) )
  return String( src );

  return;
}

//

/**
 * Return type of src.
 *
 * @example
 * let str = _.strType( 'testing' );
 *
 * @param {*} src
 *
 * @return {string}
 * string name of type src
 * @function strType
 * @memberof wTools
 */

function strType( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !_.primitiveIs( src ) )
  if( src.constructor && src.constructor.name )
  return src.constructor.name;

  let result = _.strPrimitiveType( src );

  if( result === 'Object' )
  {
    if( Object.getPrototypeOf( src ) === null )
    result = 'Map:Pure';
    else if( src.__proto__ !== Object.__proto__ )
    result = 'Object:Special';
  }

  return result;
}

//

/**
 * Return primitive type of src.
 *
 * @example
 * let str = _.strPrimitiveType( 'testing' );
 *
 * @param {*} src
 *
 * @return {string}
 * string name of type src
 * @function strPrimitiveType
 * @memberof wTools
 */

function strPrimitiveType( src )
{

  let name = Object.prototype.toString.call( src );
  let result = /\[(\w+) (\w+)\]/.exec( name );

  if( !result )
  throw _.err( 'strType :', 'unknown type', name );
  return result[ 2 ];
}

// --
// decorator
// --

function strQuote( o )
{

  if( !_.mapIs( o ) )
  o = { src : o };

  if( o.quote === undefined || o.quote === null )
  o.quote = strQuote.defaults.quote;

  _.assertMapHasOnly( o, strQuote.defaults );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.arrayIs( o.src ) )
  {
    let result = [];
    for( let s = 0 ; s < o.src.length ; s++ )
    result.push( _.strQuote({ src : o.src[ s ], quote : o.quote }) );
    return result;
  }

  let src = o.src;

  if( !_.primitiveIs( src ) )
  src = _.toStr( src );

  _.assert( _.primitiveIs( src ) );

  let result = o.quote + String( src ) + o.quote;

  return result;
}

strQuote.defaults =
{
  src : null,
  quote : '"',
}

// --
//
// --

function _strLeftSingle( src, ins, first, last )
{

  _.assert( arguments.length === 2 || arguments.length === 3 || arguments.length === 4 );
  _.assert( _.strIs( src ) );
  _.assert( first === undefined || _.numberIs( first ) );
  _.assert( last === undefined || _.numberIs( last ) );

  ins = _.arrayAs( ins );

  let olength = src.length;
  let result = Object.create( null );
  result.index = olength;
  result.entry = undefined;

  if( first !== undefined || last !== undefined )
  {
    if( first === undefined )
    first = 0;
    if( last === undefined )
    last = src.length;
    if( first < 0 )
    first = src.length + first;
    if( last < 0 )
    last = src.length + last;
    _.assert( 0 <= first && first <= src.length );
    _.assert( 0 <= last && last <= src.length );
    src = src.substring( first, last );
  }

  for( let k = 0, len = ins.length ; k < len ; k++ )
  {
    let entry = ins[ k ];
    if( _.strIs( entry ) )
    {
      let found = src.indexOf( entry );
      if( found >= 0 && ( found < result.index || result.entry === undefined ) )
      {
        result.index = found;
        result.entry = entry;
      }
    }
    else if( _.regexpIs( entry ) )
    {
      let found = src.match( entry );
      if( found && ( found.index < result.index || result.entry === undefined ) )
      {
        result.index = found.index;
        result.entry = found[ 0 ];
      }
    }
    else _.assert( 0, 'Expects string-like ( string or regexp )' );
  }

  if( first !== undefined && result.index !== olength )
  result.index += first;

  return result;
}

//

function strLeft( src, ins, first, last )
{

  _.assert( arguments.length === 2 || arguments.length === 3 || arguments.length === 4 );

  if( _.arrayLike( src ) )
  {
    let result = [];
    for( let s = 0 ; s < src.length ; s++ )
    result[ s ] = _._strLeftSingle( src[ s ], ins, first, last );
    return result;
  }
  else
  {
    return _._strLeftSingle( src, ins, first, last );
  }

}

//

/*

(bb)(?!(?=.).*(?:bb))
aaa_bbb_|bb|b_ccc_ccc

.*(bb)
aaa_bbb_b|bb|_ccc_ccc

(b+)(?!(?=.).*(?:b+))
aaa_bbb_|bbb|_ccc_ccc

.*(b+)
aaa_bbb_bb|b|_ccc_ccc

*/

function _strRightSingle( src, ins, first, last )
{

  _.assert( arguments.length === 2 || arguments.length === 3 || arguments.length === 4 );
  _.assert( _.strIs( src ) );
  _.assert( first === undefined || _.numberIs( first ) );
  _.assert( last === undefined || _.numberIs( last ) );

  ins = _.arrayAs( ins );

  let olength = src.length;
  let result = Object.create( null );
  result.index = -1;
  result.entry = undefined;

  if( first !== undefined || last !== undefined )
  {
    if( first === undefined )
    first = 0;
    if( last === undefined )
    last = src.length;
    if( first < 0 )
    first = src.length + first;
    if( last < 0 )
    last = src.length + last;
    _.assert( 0 <= first && first <= src.length );
    _.assert( 0 <= last && last <= src.length );
    src = src.substring( first, last );
  }

  for( let k = 0, len = ins.length ; k < len ; k++ )
  {
    let entry = ins[ k ];
    if( _.strIs( entry ) )
    {
      let found = src.lastIndexOf( entry );
      if( found >= 0 && found > result.index )
      {
        result.index = found;
        result.entry = entry;
      }
    }
    else if( _.regexpIs( entry ) )
    {

      // entry = _.regexpsJoin([ entry, '(?!(?=.).*(?:))' ]);
      // debugger;

      let regexp1 = _.regexpsJoin([ '.*', '(', entry, ')' ]); // xxx
      let match1 = src.match( regexp1 );
      if( !match1 )
      continue;

      let regexp2 = _.regexpsJoin([ entry, '(?!(?=.).*', entry, ')' ]);
      let match2 = src.match( regexp2 );
      _.assert( !!match2 );

      let found;
      let found1 = match1[ 1 ];
      let found2 = match2[ 0 ];
      let index;
      let index1 = match1.index + match1[ 0 ].length;
      let index2 = match2.index + match2[ 0 ].length;

      if( index1 === index2 )
      {
        if( found1.length < found2.length )
        {
          debugger;
          found = found2;
          index = index2 - found.length;
        }
        else
        {
          found = found1;
          index = index1 - found.length;
        }
      }
      else if( index1 < index2 )
      {
        found = found2;
        index = index2 - found.length;
      }
      else
      {
        debugger;
        found = found1;
        index = index1 - found.length;
      }

      if( index > result.index )
      {
        result.index = index;
        result.entry = found;
      }

    }
    else _.assert( 0, 'Expects string-like ( string or regexp )' );
  }

  if( first !== undefined && result.index !== -1 )
  result.index += first;

  return result;
}

//

function strRight( src, ins, first, last )
{

  _.assert( arguments.length === 2 || arguments.length === 3 || arguments.length === 4 );

  if( _.arrayLike( src ) )
  {
    let result = [];
    for( let s = 0 ; s < src.length ; s++ )
    result[ s ] = _._strRightSingle( src[ s ], ins, first, last );
    return result;
  }
  else
  {
    return _._strRightSingle( src, ins, first, last );
  }

}

// //
//
// function _strCutOff_pre( routine, args )
// {
//   let o;
//
//   if( args.length > 1 )
//   {
//     o = { src : args[ 0 ], delimeter : args[ 1 ], number : args[ 2 ] };
//   }
//   else
//   {
//     o = args[ 0 ];
//     _.assert( args.length === 1, 'Expects single argument' );
//   }
//
//   _.routineOptions( routine, o );
//   _.assert( args.length === 1 || args.length === 2 || args.length === 3 );
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( _.strIs( o.src ) );
//   _.assert( _.strIs( o.delimeter ) || _.arrayIs( o.delimeter ) );
//
//   return o;
// }

//

function strEquivalent( src1, src2 )
{
  let strIs1 = _.strIs( src1 );
  let strIs2 = _.strIs( src2 );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( !strIs1 && strIs2 )
  return _.strEquivalent( src2, src1 );

  _.assert( _.strLike( src1 ), 'Expects string-like ( string or regexp )' );
  _.assert( _.strLike( src1 ), 'Expects string-like ( string or regexp )' );

  if( strIs1 && strIs2 )
  {
    return src1 === src2;
  }
  else if( strIs1 )
  {
    debugger;
    let matched = src2.exec( src1 );
    debugger;
    if( !matched )
    return false;
    if( matched[ 0 ].length !== src1.length )
    return false;
    return true;
  }
  else
  {
    return _.regexpIdentical( src1, src2 );
  }

  return false;
}

//

function strsEquivalent( src1, src2 )
{

  _.assert( _.strIs( src1 ) || _.regexpIs( src1 ) || _.longIs( src1 ), 'Expects string/regexp or array of strings/regexps {-src1-}' );
  _.assert( _.strIs( src2 ) || _.regexpIs( src2 ) || _.longIs( src2 ), 'Expects string/regexp or array of strings/regexps {-src2-}' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let isLong1 = _.longIs( src1 );
  let isLong2 = _.longIs( src2 );

  if( isLong1 && isLong2 )
  {
    _.assert( src1.length === src2.length );
    for( let i = 0, len = src1.length ; i < len; i++ )
    {
      let result = [];
      result[ i ] = _.strEquivalent( src1[ i ], src2[ i ] );
      return result;
    }
  }
  else if( !isLong1 && isLong2 )
  {
    for( let i = 0, len = src2.length ; i < len; i++ )
    {
      let result = [];
      result[ i ] = _.strEquivalent( src1, src2[ i ] );
      return result;
    }
  }
  else if( isLong1 && !isLong2 )
  {
    for( let i = 0, len = src1.length ; i < len; i++ )
    {
      let result = [];
      result[ i ] = _.strEquivalent( src1[ i ], src2 );
      return result;
    }
  }
  else
  {
    return _.strEquivalent( src1[ i ], src2 );
  }

}

//

function _strBeginOf( src, begin )
{

  _.assert( _.strIs( src ), 'Expects string' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( _.strIs( begin ) )
  {
    if( src.lastIndexOf( begin, 0 ) === 0 )
    return begin;
  }
  else if( _.regexpIs( begin ) )
  {
    let matched = begin.exec( src );
    if( matched && matched.index === 0 )
    return matched[ 0 ];
  }
  else _.assert( 0, 'Expects string-like ( string or regexp )' );

  return false;
}

//

function _strEndOf( src, end )
{

  _.assert( _.strIs( src ), 'Expects string' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( _.strIs( end ) )
  {
    if( src.indexOf( end, src.length - end.length ) !== -1 )
    return end;
  }
  else if( _.regexpIs( end ) )
  {
    // let matched = end.exec( src );
    let newEnd = RegExp( end.toString().slice(1, -1) + '$' );
    let matched = newEnd.exec( src );
    debugger;
    //if( matched && matched.index === 0 )
    if( matched && matched.index + matched[ 0 ].length === src.length )
    return matched[ 0 ];
  }
  else _.assert( 0, 'Expects string-like ( string or regexp )' );

  return false;
}

//

/**
 * Compares two strings.
 *
 * @param { String } src - Source string.
 * @param { String } begin - String to find at begin of source.
 *
 * @example
 * let scr = _.strBegins( "abc", "a" );
 * // returns true
 *
 * @example
 * let scr = _.strBegins( "abc", "b" );
 * // returns false
 *
 * @returns { Boolean } Returns true if param( begin ) is match with first chars of param( src ), otherwise returns false.
 * @function strBegins
 * @throws { Exception } If one of arguments is not a String.
 * @throws { Exception } If( arguments.length ) is not equal 2.
 * @memberof wTools
 */

function strBegins( src, begin )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( _.strIs( begin ) || _.regexpIs( begin ) || _.longIs( begin ), 'Expects string/regexp or array of strings/regexps {-begin-}' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( !_.longIs( begin ) )
  {
    let result = _._strBeginOf( src, begin );
    return result === false ? result : true;
  }

  for( let b = 0, blen = begin.length ; b < blen; b++ )
  {
    let result = _._strBeginOf( src, begin[ b ] );
    if( result !== false )
    return true;
  }

  return false;
}

//

/**
 * Compares two strings.
 *
 * @param { String } src - Source string.
 * @param { String } end - String to find at end of source.
 *
 * @example
 * let scr = _.strEnds( "abc", "c" );
 * // returns true
 *
 * @example
 * let scr = _.strEnds( "abc", "b" );
 * // returns false
 *
 * @return { Boolean } Returns true if param( end ) is match with last chars of param( src ), otherwise returns false.
 * @function strEnds
 * @throws { Exception } If one of arguments is not a String.
 * @throws { Exception } If( arguments.length ) is not equal 2.
 * @memberof wTools
 */

function strEnds( src, end )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( _.strIs( end ) || _.regexpIs( end ) || _.longIs( end ), 'Expects string/regexp or array of strings/regexps {-end-}' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( !_.longIs( end ) )
  {
    let result = _._strEndOf( src, end );
    return result === false ? result : true;
  }

  for( let b = 0, blen = end.length ; b < blen; b++ )
  {
    let result = _._strEndOf( src, end[ b ] );
    if( result !== false )
    return true;
  }

  return false;
}

//

/**
 * Finds occurrence of( end ) at the end of source( src ) and removes it if exists.
 * Returns begin part of a source string if occurrence was finded or empty string if arguments are equal, otherwise returns undefined.
 *
 * @param { String } src - The source string.
 * @param { String } end - String to find.
 *
 * @example
 * _.strBeginOf( 'abc', 'c' );
 * // returns 'ab'
 *
 * @example
 * _.strBeginOf( 'abc', 'x' );
 * // returns undefined
 *
 * @returns { String } Returns part of source string without tail( end ) or undefined.
 * @throws { Exception } If all arguments are not strings;
 * @throws { Exception } If ( argumets.length ) is not equal 2.
 * @function strBeginOf
 * @memberof wTools
 */

function strBeginOf( src, begin )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( _.strIs( begin ) || _.regexpIs( begin ) || _.longIs( begin ), 'Expects string/regexp or array of strings/regexps {-begin-}' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( !_.longIs( begin ) )
  {
    let result = _._strBeginOf( src, begin );
    return result;
  }

  for( let b = 0, blen = begin.length ; b < blen; b++ )
  {
    let result = _._strBeginOf( src, begin[ b ] );
    if( result !== false )
    return result;
  }

  return false;
}

//

/**
 * Finds occurrence of( begin ) at the begining of source( src ) and removes it if exists.
 * Returns end part of a source string if occurrence was finded or empty string if arguments are equal, otherwise returns undefined.
 * otherwise returns undefined.
 *
 * @param { String } src - The source string.
 * @param { String } begin - String to find.
 *
 * @example
 * _.strEndOf( 'abc', 'a' );
 * // returns 'bc'
 *
 * @example
 * _.strEndOf( 'abc', 'c' );
 * // returns undefined
 *
 * @returns { String } Returns part of source string without head( begin ) or undefined.
 * @throws { Exception } If all arguments are not strings;
 * @throws { Exception } If ( argumets.length ) is not equal 2.
 * @function strEndOf
 * @memberof wTools
 */

function strEndOf( src, end )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( _.strIs( end ) || _.regexpIs( end ) || _.longIs( end ), 'Expects string/regexp or array of strings/regexps {-end-}' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( !_.longIs( end ) )
  {
    let result = _._strEndOf( src, end );
    return result;
  }

  for( let b = 0, blen = end.length ; b < blen; b++ )
  {
    let result = _._strEndOf( src, end[ b ] );
    if( result !== false )
    return result;
  }

  return false;
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
 * _.strInsideOf( 'abcd', 'a', 'd' );
 * // returns 'bc'
 *
 * @example
 * _.strInsideOf( 'aabcc', 'a', 'c' );
 * // returns 'aabcc'
 *
 * @example
 * _.strInsideOf( 'aabcc', 'a', 'a' );
 * // returns 'a'
 *
 * @example
 * _.strInsideOf( 'abc', 'a', 'a' );
 * // returns undefined
 *
 * @example
 * _.strInsideOf( 'abcd', 'x', 'y' )
 * // returns undefined
 *
 * @example
 * // index of begin is bigger then index of end
 * _.strInsideOf( 'abcd', 'c', 'a' )
 * // returns undefined
 *
 * @returns { string } Returns part of source string between ( begin ) and ( end ) or undefined.
 * @throws { Exception } If all arguments are not strings;
 * @throws { Exception } If ( argumets.length ) is not equal 3.
 * @function strInsideOf
 * @memberof wTools
 */

function strInsideOf( src, begin, end )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  let beginOf, endOf;

  beginOf = _.strBeginOf( src, begin );
  if( beginOf === false )
  return false;

  endOf = _.strEndOf( src, end );
  if( endOf === false )
  return false;

  let result = src.substring( beginOf.length, src.length - endOf.length );

  return result;
}

//

function strOutsideOf( src, begin, end )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  let beginOf, endOf;

  beginOf = _.strBeginOf( src, begin );
  if( beginOf === false )
  return false;

  endOf = _.strEndOf( src, end );
  if( endOf === false )
  return false;

  let result = beginOf + endOf;

  return result;
}

//

/**
 * Finds substring prefix ( begin ) occurrence from the very begining of source ( src ) and removes it.
 * Returns original string if source( src ) does not have occurrence of ( prefix ).
 *
 * @param { String } src - Source string to parse.
 * @param { String } prefix - String that is to be dropped.
 * @returns { String } Returns string with result of prefix removement.
 *
 * @example
 * _.strRemoveBegin( 'example', 'exa' );
 * // returns mple
 *
 * @example
 * _.strRemoveBegin( 'example', 'abc' );
 * // returns example
 *
 * @function strRemoveBegin
 * @throws { Exception } Throws a exception if( src ) is not a String.
 * @throws { Exception } Throws a exception if( prefix ) is not a String.
 * @throws { Exception } Throws a exception if( arguments.length ) is not equal 2.
 * @memberof wTools
 *
 */

function strRemoveBegin( src, begin )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( _.strIs( begin ) || _.regexpIs( begin ), 'Expects string/regexp {-begin-}'  );

  let result = src;
  let beginOf = _._strBeginOf( result, begin );
  if( beginOf !== false )
  result = result.substr( beginOf.length, result.length );
  return result;
}

//

/**
 * Removes occurrence of postfix ( end ) from the very end of string( src ).
 * Returns original string if no occurrence finded.
 * @param { String } src - Source string to parse.
 * @param { String } postfix - String that is to be dropped.
 * @returns { String } Returns string with result of postfix removement.
 *
 * @example
 * _.strRemoveEnd( 'example', 'le' );
 * // returns examp
 *
 * @example
 * _.strRemoveEnd( 'example', 'abc' );
 * // returns example
 *
 * @function strRemoveEnd
 * @throws { Exception } Throws a exception if( src ) is not a String.
 * @throws { Exception } Throws a exception if( postfix ) is not a String.
 * @throws { Exception } Throws a exception if( arguments.length ) is not equal 2.
 * @memberof wTools
 *
 */

function strRemoveEnd( src, end )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( _.strIs( end ) || _.regexpIs( end ), 'Expects string/regexp {-end-}' );

  let result = src;
  let endOf = _._strEndOf( result, end );
  if( endOf !== false )
  result = result.substr( 0, result.length - endOf.length );

  return result;
}

//

/**
 * Finds substring or regexp ( insStr ) first occurrence from the source string ( srcStr ) and removes it.
 * Returns original string if source( src ) does not have occurrence of ( insStr ).
 *
 * @param { String } srcStr - Source string to parse.
 * @param { String } insStr - String/RegExp that is to be dropped.
 * @returns { String } Returns string with result of substring removement.
 *
 * @example
 * _.strRemove( 'source string', 's' );
 * // returns ource tring
 *
 * @example
 * _.strRemove( 'example', 's' );
 * // returns example
 *
 * @function strRemove
 * @throws { Exception } Throws a exception if( srcStr ) is not a String.
 * @throws { Exception } Throws a exception if( insStr ) is not a String or a RegExp.
 * @throws { Exception } Throws a exception if( arguments.length ) is not equal 2.
 * @memberof wTools
 *
 */

function strRemove( srcStr, insStr )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( srcStr ), 'Expects string {-src-}' );
  _.assert( _.strIs( insStr ) || _.regexpIs( insStr ), 'Expects string/regexp {-begin-}' );

  let result = srcStr;
  debugger;

  result = result.replace( insStr, '' );

  return result;
}

//

function strReplaceBegin( src, begin, ins )
{
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.strIs( ins ), 'Expects {-ins-} as string' );
  _.assert( _.strIs( src ) );

  let result = src;
  if( _.strBegins( result , begin ) )
  {
    let prefix = ins;
    result = prefix + _.strRemoveBegin( result, begin );
  }

  return result;
}

//

function strReplaceEnd( src, end, ins )
{
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.strIs( ins ), 'Expects {-ins-} as string' );
  _.assert( _.strIs( src ) );

  let result = src;
  if( _.strEnds( result, end ) )
  {
    let postfix = ins;
    result = _.strRemoveEnd( result , end ) + postfix;
  }

  return result;
}

//

function strReplace( srcStr, insStr, subStr )
{
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.strIs( srcStr ), 'Expects string {-src-}' );
  _.assert( _.strIs( subStr ), 'Expects string {-sub-}' );

  let result = srcStr;
  debugger;

  result = result.replace( insStr, subStr );

  return result;
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

  strIs,
  strsAreAll,
  strLike,
  strsLikeAll,
  strDefined,
  strsDefined,

  // converter

  toStr,
  toStrShort : toStr,
  strFrom : toStr,

  str,
  strShort,
  strPrimitive,
  strType,
  strPrimitiveType,

  // decorator

  strQuote,

  //

  _strLeftSingle,
  strLeft,
  _strRightSingle,
  strRight,

  strEquivalent,
  strsEquivalent : _.vectorize( strEquivalent, 2 ),
  strsEquivalentAll : _.vectorizeAll( strEquivalent, 2 ),
  strsEquivalentAny : _.vectorizeAny( strEquivalent, 2 ),
  strsEquivalentNone : _.vectorizeNone( strEquivalent, 2 ),

  _strBeginOf,
  _strEndOf,

  strBegins,
  strEnds,

  strBeginOf,
  strEndOf,

  strInsideOf,
  strOutsideOf,

  strRemoveBegin,
  strRemoveEnd,
  strRemove,

  strReplaceBegin,
  strReplaceEnd,
  strReplace,

  /* qqq : check coverage of each routine of the file fString.s */

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
