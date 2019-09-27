( function _gRegexp_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

let _ArrayIndexOf = Array.prototype.indexOf;
let _ArrayLastIndexOf = Array.prototype.lastIndexOf;
let _ArraySlice = Array.prototype.slice;
let _ArraySplice = Array.prototype.splice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _ObjectPropertyIsEumerable = Object.propertyIsEnumerable;
let _ceil = Math.ceil;
let _floor = Math.floor;

// --
// regexp
// --

// function regexpIs( src )
// {
//   return _ObjectToString.call( src ) === '[object RegExp]';
// }
//
// //
//
// function regexpObjectIs( src )
// {
//   if( !_.RegexpObject )
//   return false;
//   return src instanceof _.RegexpObject;
// }
//
// //
//
// function regexpLike( src )
// {
//   if( _.regexpIs( src ) || _.strIs( src ) )
//   return true;
//   return false;
// }
//
// //
//
// function regexpsLike( srcs )
// {
//   if( !_.arrayIs( srcs ) )
//   return false;
//   for( let s = 0 ; s < srcs.length ; s++ )
//   if( !_.regexpLike( srcs[ s ] ) )
//   return false;
//   return true;
// }
//
// //
//
// function regexpIdentical( src1,src2 )
// {
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//
//   if( !_.regexpIs( src1 ) || !_.regexpIs( src2 ) )
//   return false;
//
//   return src1.source === src2.source && src1.flags === src2.flags;
// }
//
// //
//
// function _regexpTest( regexp, str )
// {
//   _.assert( arguments.length === 2 );
//   _.assert( _.regexpLike( regexp ) );
//   _.assert( _.strIs( str ) );
//
//   if( _.strIs( regexp ) )
//   return regexp === str;
//   else
//   return regexp.test( str );
//
// }
//
// //
//
// function regexpTest( regexp, strs )
// {
//   _.assert( arguments.length === 2 );
//   _.assert( _.regexpLike( regexp ) );
//
//   if( _.strIs( strs ) )
//   return _._regexpTest( regexp, strs );
//   else if( _.arrayLike( strs ) )
//   return strs.map( ( str ) => _._regexpTest( regexp, str ) )
//   else _.assert( 0 );
//
// }
//
// //
//
// function regexpTestAll( regexp, strs )
// {
//   _.assert( arguments.length === 2 );
//   _.assert( _.regexpLike( regexp ) );
//
//   if( _.strIs( strs ) )
//   return _._regexpTest( regexp, strs );
//   else if( _.arrayLike( strs ) )
//   return strs.every( ( str ) => _._regexpTest( regexp, str ) )
//   else _.assert( 0 );
//
// }
//
// //
//
// function regexpTestAny( regexp, strs )
// {
//   _.assert( arguments.length === 2 );
//   _.assert( _.regexpLike( regexp ) );
//
//   if( _.strIs( strs ) )
//   return _._regexpTest( regexp, strs );
//   else if( _.arrayLike( strs ) )
//   return strs.some( ( str ) => _._regexpTest( regexp, str ) )
//   else _.assert( 0 );
//
// }
//
// //
//
// function regexpTestNone( regexp, strs )
// {
//   _.assert( arguments.length === 2 );
//   _.assert( _.regexpLike( regexp ) );
//
//   if( _.strIs( strs ) )
//   return !_._regexpTest( regexp, strs );
//   else if( _.arrayLike( strs ) )
//   return !strs.some( ( str ) => _._regexpTest( regexp, str ) )
//   else _.assert( 0 );
//
// }
//
// //
//
// function regexpsTestAll( regexps, strs )
// {
//   _.assert( arguments.length === 2 );
//
//   if( !_.arrayIs( regexps ) )
//   return _.regexpTestAll( regexps, strs );
//
//   _.assert( _.regexpsLike( regexps ) );
//
//   return regexps.every( ( regexp ) => _.regexpTestAll( regexp, strs ) );
// }
//
// //
//
// function regexpsTestAny( regexps, strs )
// {
//   _.assert( arguments.length === 2 );
//
//   if( !_.arrayIs( regexps ) )
//   return _.regexpTestAny( regexps, strs );
//
//   _.assert( _.regexpsLike( regexps ) );
//
//   return regexps.some( ( regexp ) => _.regexpTestAny( regexp, strs ) );
// }
//
// //
//
// function regexpsTestNone( regexps, strs )
// {
//   _.assert( arguments.length === 2 );
//
//   if( !_.arrayIs( regexps ) )
//   return _.regexpTestNone( regexps, strs );
//
//   _.assert( _.regexpsLike( regexps ) );
//
//   return regexps.every( ( regexp ) => _.regexpTestNone( regexp, strs ) );
// }

//

/**
 * Escapes special characters with a slash ( \ ). Supports next set of characters : .*+?^=! :${}()|[]/\
 *
 * @example
 * _.regexpEscape( 'Hello. How are you?' );
 * // returns "Hello\. How are you\?"
 *
 * @param {String} src Regexp string
 * @returns {String} Escaped string
 * @function regexpEscape
 * @memberof wTools
 */

function regexpEscape( src )
{
  _.assert( _.strIs( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return src.replace( /([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1" );
}

//

let regexpsEscape = null;

//

/**
 * Make regexp from string.
 *
 * @example
 * _.regexpFrom( 'Hello. How are you?' );
 * // returns /Hello\. How are you\?/
 *
 * @param {RegexpLike} src - string or regexp
 * @returns {String} Regexp
 * @throws {Error} Throw error with message 'unknown type of expression, expects regexp or string, but got' error
 if src not string-like ( string or regexp )
 * @function regexpFrom
 * @memberof wTools
 */

function regexpFrom( src, flags )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( flags === undefined || _.strIs( flags ) );

  if( _.regexpIs( src ) )
  return src;

  _.assert( _.strIs( src ) );

  return new RegExp( _.regexpEscape( src ),flags );
}

//

function regexpMaybeFrom( o )
{
  if( !_.mapIs( o ) )
  o = { srcStr : arguments[ 0 ] }

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.srcStr ) || _.regexpIs( o.srcStr ) );
  _.routineOptions( regexpMaybeFrom, o );

  let result = o.srcStr;

  if( _.strIs( result ) )
  {

    // let optionsExtract =
    // {
    //   prefix : '//',
    //   postfix : '//',
    //   src : result,
    // }
    // let strips = _.strExtractInlinedStereo( optionsExtract );

    if( o.stringWithRegexp )
    {

      let optionsExtract =
      {
        delimeter : '//',
        src : result,
      }
      let strips = _.strExtractInlined( optionsExtract );

      // if( strips.length > 1 )
      // debugger;

    }
    else
    {
      let strips = [ result ];
    }

    for( let s = 0 ; s < strips.length ; s++ )
    {
      let strip = strips[ s ];

      if( s % 2 === 0 )
      {
        strip = _.regexpEscape( strip );
        if( o.toleratingSpaces )
        strip = strip.replace( /\s+/g,'\\s*' );
      }

      strips[ s ] = strip;
    }

    result = RegExp( strips.join( '' ), o.flags );
  }

  return result;
}

regexpMaybeFrom.defaults =
{
  srcStr : null,
  stringWithRegexp : 1,
  toleratingSpaces : 1,
  flags : 'g',
}

//

let regexpsMaybeFrom = null;

//

function regexpsSources( o )
{
  if( _.arrayIs( arguments[ 0 ] ) )
  {
    o = Object.create( null );
    o.sources = arguments[ 0 ];
  }

  // o.sources = o.sources ? _.longSlice( o.sources ) : [];
  o.sources = _.longSlice( o.sources );
  if( o.flags === undefined )
  o.flags = null;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( regexpsSources, o );

  /* */

  for( let s = 0 ; s < o.sources.length ; s++ )
  {
    let src = o.sources[ s ];
    if( _.regexpIs( src ) )
    {
      o.sources[ s ] = src.source;
      _.assert( o.flags === null || src.flags === o.flags, () => 'All RegExps should have flags field with the same value ' + _.strQuote( src.flags ) + ' != ' + _.strQuote( o.flags ) );
      if( o.flags === null )
      o.flags = src.flags;
    }
    else
    {
      if( o.escaping )
      o.sources[ s ] = _.regexpEscape( src );
    }
    _.assert( _.strIs( o.sources[ s ] ) );
  }

  /* */

  return o;
}

regexpsSources.defaults =
{
  sources : null,
  flags : null,
  escaping : 0,
}

//

function regexpsJoin( o )
{
  if( !_.mapIs( o ) )
  o = { sources : o }

  _.routineOptions( regexpsJoin, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  let src = o.sources[ 0 ];
  o = _.regexpsSources( o );
  if( o.sources.length === 1 && _.regexpIs( src ) )
  return src;

  let result = o.sources.join( '' );

  return new RegExp( result, o.flags || '' );
}

regexpsJoin.defaults =
{
  flags : null,
  sources : null,
  escaping : 0,
}

//

function regexpsJoinEscaping( o )
{
  if( !_.mapIs( o ) )
  o = { sources : o }

  _.routineOptions( regexpsJoinEscaping, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !!o.escaping );

  return _.regexpsJoin( o );
}

var defaults = regexpsJoinEscaping.defaults = Object.create( regexpsJoin.defaults );

defaults.escaping = 1;

//

function regexpsAtLeastFirst( o )
{

  if( !_.mapIs( o ) )
  o = { sources : o }

  _.routineOptions( regexpsAtLeastFirst, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  let src = o.sources[ 0 ];
  o = _.regexpsSources( o );
  if( o.sources.length === 1 && _.regexpIs( src ) )
  return src;

  let result = '';
  let prefix = '';
  let postfix = '';

  for( let s = 0 ; s < o.sources.length ; s++ )
  {
    let src = o.sources[ s ];

    if( s === 0 )
    {
      prefix = prefix + src;
    }
    else
    {
      prefix = prefix + '(?:' + src;
      postfix =  ')?' + postfix
    }

  }

  result = prefix + postfix;
  return new RegExp( result, o.flags || '' );
}

regexpsAtLeastFirst.defaults =
{
  flags : null,
  sources : null,
  escaping : 0,
}

//

function regexpsAtLeastFirstOnly( o )
{

  if( !_.mapIs( o ) )
  o = { sources : o }

  _.routineOptions( regexpsAtLeastFirst, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  let src = o.sources[ 0 ];
  o = _.regexpsSources( o );
  if( o.sources.length === 1 && _.regexpIs( src ) )
  return src;

  let result = '';

  if( o.sources.length === 1 )
  {
    result = o.sources[ 0 ]
  }
  else for( let s = 0 ; s < o.sources.length ; s++ )
  {
    let src = o.sources[ s ];
    if( s < o.sources.length-1 )
    result += '(?:' + o.sources.slice( 0, s+1 ).join( '' ) + '$)|';
    else
    result += '(?:' + o.sources.slice( 0, s+1 ).join( '' ) + ')';
  }

  return new RegExp( result, o.flags || '' );
}

regexpsAtLeastFirst.defaults =
{
  flags : null,
  sources : null,
  escaping : 0,
}

//

/**
 *  Generates "but" regular expression pattern. Accepts a list of words, which will be used in regexp.
 *  The result regexp matches the strings that do not contain any of those words.
 *
 * @example
 * _.regexpsNone( 'yellow', 'red', 'green' );
 * // returns /^(?:(?!yellow|red|green).)+$/
 *
 * let options =
 * {
 *    but : [ 'yellow', 'red', 'green' ],
 *    atLeastOnce : false
 * };
 * _.regexpsNone(options);
 * // returns /^(?:(?!yellow|red|green).)*$/
 *
 * @param {Object} [options] options for generate regexp. If this argument omitted then default options will be used
 * @param {String[]} [options.but=null] a list of words,from each will consist regexp
 * @param {boolean} [options.atLeastOne=true] indicates whether search matches at least once
 * @param {...String} [words] a list of words, from each will consist regexp. This arguments can be used instead
 * options object.
 * @returns {RegExp} Result regexp
 * @throws {Error} If passed arguments are not strings or options object.
 * @throws {Error} If options contains any different from 'but' or 'atLeastOnce' properties.
 * @function regexpsNone
 * @memberof wTools
 */

function regexpsNone( o )
{
  if( !_.mapIs( o ) )
  o = { sources : o }

  _.routineOptions( regexpsNone, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  o = _.regexpsSources( o );

  /* ^(?:(?!(?:abc)).)+$ */

  let result = '^(?:(?!(?:';
  result += o.sources.join( ')|(?:' );
  result += ')).)+$';

  return new RegExp( result, o.flags || '' );
}

regexpsNone.defaults =
{
  flags : null,
  sources : null,
  escaping : 0,
}

//

function regexpsAny( o )
{
  if( !_.mapIs( o ) )
  o = { sources : o }

  _.routineOptions( regexpsAny, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.regexpIs( o.sources ) )
  {
    _.assert( o.sources.flags === o.flags || o.flags === null );
    return o.sources;
  }

  _.assert( !!o.sources );
  let src = o.sources[ 0 ];
  o = _.regexpsSources( o );
  if( o.sources.length === 1 && _.regexpIs( src ) )
  return src;

  let result = '(?:';
  result += o.sources.join( ')|(?:' );
  result += ')';

  return new RegExp( result, o.flags || '' );
}

regexpsAny.defaults =
{
  flags : null,
  sources : null,
  escaping : 0,
}

//

function regexpsAll( o )
{
  if( !_.mapIs( o ) )
  o = { sources : o }

  _.routineOptions( regexpsAll, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.regexpIs( o.sources ) )
  {
    _.assert( o.sources.flags === o.flags || o.flags === null );
    return o.sources;
  }

  let src = o.sources[ 0 ];
  o = _.regexpsSources( o );
  if( o.sources.length === 1 && _.regexpIs( src ) )
  return src;

  let result = ''

  if( o.sources.length > 0 )
  {

    if( o.sources.length > 1 )
    {
      result += '(?=';
      result += o.sources.slice( 0, o.sources.length-1 ).join( ')(?=' );
      result += ')';
    }

    result += '(?:';
    result += o.sources[ o.sources.length-1 ];
    result += ')';

  }

  return new RegExp( result, o.flags || '' );
}

regexpsAll.defaults =
{
  flags : null,
  sources : null,
  escaping : 0,
}

//

/**
 * Wraps regexp(s) into array and returns it. If in `src` passed string - turn it into regexp
 *
 * @example
 * _.regexpArrayMake( ['red', 'white', /[a-z]/] );
 * // returns [ /red/, /white/, /[a-z]/ ]
 *
 * @param {String[]|String} src - array of strings/regexps or single string/regexp
 * @returns {RegExp[]} Array of regexps
 * @throw {Error} if `src` in not string, regexp, or array
 * @function regexpArrayMake
 * @memberof wTools
 */

function regexpArrayMake( src )
{

  _.assert( _.regexpLike( src ) || _.arrayLike( src ), 'Expects array/regexp/string, got ' + _.strType( src ) );

  src = _.arrayFlatten( [], _.arrayAs( src ) );

  for( let k = src.length-1 ; k >= 0 ; k-- )
  {
    let e = src[ k ]

    if( e === null )
    {
      src.splice( k,1 );
      continue;
    }

    src[ k ] = _.regexpFrom( e );

  }

  return src;
}

//

/**
 * Routine regexpArrayIndex() returns the index of the first regular expression that matches substring
 * Otherwise, it returns -1.
 *
 * @example
 * let str = "The RGB color model is an additive color model in which red, green, and blue light are added together in various ways to reproduce a broad array of colors";
 * let regArr1 = [/white/, /green/, /blue/];
 * _.regexpArrayIndex(regArr1, str);
 * // returns 1
 *
 * @param {RegExp[]} arr Array for regular expressions.
 * @param {String} ins String, inside which will be execute search
 * @returns {number} Index of first matching or -1.
 * @throws {Error} If first argument is not array.
 * @throws {Error} If second argument is not string.
 * @throws {Error} If element of array is not RegExp.
 * @function regexpArrayIndex
 * @memberof wTools
 */

function regexpArrayIndex( arr,ins )
{
  _.assert( _.arrayIs( arr ) );
  _.assert( _.strIs( ins ) );

  for( let a = 0 ; a < arr.length ; a++ )
  {
    let regexp = arr[ a ];
    _.assert( _.regexpIs( regexp ) );
    if( regexp.test( ins ) )
    return a;
  }

  return -1;
}

//

/**
 * Checks if any regexp passed in `arr` is found in string `ins`
 * If match was found - returns match index
 * If no matches found and regexp array is not empty - returns false
 * If regexp array is empty - returns some default value passed in the `ifEmpty` input param
 *
 * @example
 * let str = "The RGB color model is an additive color model in which red, green, and blue light are added together in various ways to reproduce a broad array of colors";
 * let regArr2 = [/yellow/, /blue/, /red/];
 * _.regexpArrayAny(regArr2, str, false);
 * // returns 1
 *
 * @example
 * let regArr3 = [/yellow/, /white/, /greey/]
 * _.regexpArrayAny(regArr3, str, false);
 * // returns false
 *
 * @param {String[]} arr Array of regular expressions strings
 * @param {String} ins - string that is tested by regular expressions passed in `arr` parameter
 * @param {*} none - Default return value if array is empty
 * @returns {*} Returns the first match index, false if input array of regexp was empty or default value otherwise
 * @thows {Error} If missed one of arguments
 * @function regexpArrayAny
 * @memberof wTools
 */

function regexpArrayAny( arr, ins, ifEmpty )
{

  _.assert( _.arrayIs( arr ) || _.regexpIs( src ) );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  arr = _.arrayAs( arr );
  for( let m = 0 ; m < arr.length ; m++ )
  {
    _.assert( _.routineIs( arr[ m ].test ) );
    if( arr[ m ].test( ins ) )
    return m;
  }

  return arr.length ? false : ifEmpty;
}

//

/**
 * Checks if all regexps passed in `arr` are found in string `ins`
 * If any of regex was not found - returns match index
 * If regexp array is not empty and all regexps passed test - returns true
 * If regexp array is empty - returns some default value passed in the `ifEmpty` input param
 *
 * @example
 * let str = "The RGB color model is an additive color model in which red, green, and blue light are added together in various ways to reproduce a broad array of colors";
 * let regArr1 = [/red/, /green/, /blue/];
 * _.regexpArrayAll(regArr1, str, false);
 * // returns true
 *
 * @example
 * let regArr2 = [/yellow/, /blue/, /red/];
 * _.regexpArrayAll(regArr2, str, false);
 * // returns 0
 *
 * @param {String[]} arr Array of regular expressions strings
 * @param {String} ins - string that is tested by regular expressions passed in `arr` parameter
 * @param {*} none - Default return value if array is empty
 * @returns {*} Returns the first match index, false if input array of regexp was empty or default value otherwise
 * @thows {Error} If missed one of arguments
 * @function regexpArrayAll
 * @memberof wTools
 */

function regexpArrayAll( arr, ins, ifEmpty )
{
  _.assert( _.arrayIs( arr ) || _.regexpIs( src ) );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  arr = _.arrayAs( arr );
  for( let m = 0 ; m < arr.length ; m++ )
  {
    if( !arr[ m ].test( ins ) )
    return m;
  }

  return arr.length ? true : ifEmpty;
}

//

function regexpArrayNone( arr, ins, ifEmpty )
{

  _.assert( _.arrayIs( arr ) || _.regexpIs( src ) );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  arr = _.arrayAs( arr );
  for( let m = 0 ; m < arr.length ; m++ )
  {
    _.assert( _.routineIs( arr[ m ].test ) );
    if( arr[ m ].test( ins ) )
    return false;
  }

  return arr.length ? true : ifEmpty;
}

// --
// fields
// --

let Fields =
{

  // regexpIdentationRegexp : /(\s*\n(\s*))/g,

}

// --
// routines
// --

let Routines =
{

  // regexp

  regexpEscape,
  regexpsEscape : _.routineVectorize_functor( regexpEscape ),

  regexpArrayMake,
  regexpFrom,

  regexpMaybeFrom,
  regexpsMaybeFrom : _.routineVectorize_functor({ routine : regexpMaybeFrom, select : 'srcStr' }),

  regexpsSources,
  regexpsJoin,
  regexpsJoinEscaping,
  regexpsAtLeastFirst,
  regexpsAtLeastFirstOnly,

  regexpsNone,
  regexpsAny,
  regexpsAll,

  regexpArrayMake,
  regexpArrayIndex,
  regexpArrayAny,
  regexpArrayAll,
  regexpArrayNone,

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
