(function _StringTools_s_() {

'use strict';

/**
 * Collection of sophisticated routines for operations on Strings. StringsToolsExtra leverages analyzing, parsing and formatting of String for special purposes.
  @module Tools/base/l5/StringTools
*/

/**
 * @file StringTools.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wArraySorted' );
  _.include( 'wArraySparse' );

}

/**
 * Collection of sophisticated routines for operations on Strings.
  @namespace Tools( module::StringTools )
  @memberof module:Tools/base/l5/StringTools
  @augments wTools
*/

//

let Self = _global_.wTools;
let _ = _global_.wTools;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

// let __assert = _.assert;
let _arraySlice = _.longSlice;
let strType = _.strType;

_.assert( _.routineIs( _.sorted.addOnce ) );

// --
//
// --

// function strDecamelize( o )
// {
//
//
// }
//
// strDecamelize.defaults =
// {
//   src : null,
//   delimeter : '-',
// }

//

/**
 * Converts string to camelcase using special pattern.
 * If function finds character from this( '.','-','_','/' ) list before letter,
 * it replaces letter with uppercase version.
 * For example: '.an _example' or '/an -example', method converts string to( 'An Example' ). *
 *
 * @param {string} srcStr - Source string.
 * @returns {string} Returns camelcase version of string.
 *
 * @example
 * //returns aBCD
 * _.strCamelize( 'a-b_c/d' );
 *
 * @example
 * //returns testString
 * _.strCamelize( 'test-string' );
 *
 * @function  strCamelize
 * @throws { Exception } Throws a exception if( srcStr ) is not a String.
 * @throws { Exception } Throws a exception if no argument provided.
 * @memberof module:Tools/base/l5/StringTools.Tools( module::StringTools )
 *
 */

function strCamelize( srcStr )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( srcStr ) );

  let result = srcStr;
  let regexp = /\.\w|-\w|_\w|\/\w/g;

  result = result.replace( regexp,function( match )
  {
    return match[ 1 ].toUpperCase();
  });

  return result;
}

//

let _strToTitleRegexp1 = /(?<=\s|^)(?:_|\.)+|(?:_|\.)+(?=\s|$)|^\w(?=[A-Z])/g;
let _strToTitleRegexp2 = /(?:_|\.)+/g;
let _strToTitleRegexp3 = /(\s*[A-za-z][a-z]*)|(\s*[0-9]+)/g;
function strToTitle( srcStr )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( srcStr ) );

  let result = srcStr;

  result = result.replace( _strToTitleRegexp1, '' );
  result = result.replace( _strToTitleRegexp2, ' ' );
  result = result.replace( _strToTitleRegexp3, function( match, g1, g2, offset )
  {
    let g = match;
    if( offset > 0 )
    g = _.strDecapitalize( g );
    if( offset > 0 && g[ 0 ] !== ' ' )
    return ' ' + g;
    else
    return g;
  });

  return result;
}

//

/**
 * Removes invalid characters from filename passed as first( srcStr ) argument by replacing characters finded by
 * pattern with second argument( o ) property( o.delimeter ).If( o.delimeter ) is not defined,
 * function sets value to( '_' ).
 *
 * @param {string} srcStr - Source string.
 * @param {object} o - Object that contains o.
 * @returns {string} Returns string with result of replacements.
 *
 * @example
 * //returns _example_file_name.txt
 * _.strFilenameFor( "'example\\file?name.txt" );
 *
 * @example
 * //returns #example#file#name.js
 * let o = { 'delimeter':'#' };
 * _.strFilenameFor( "'example\\file?name.js",o );
 *
 * @function strFilenameFor
 * @throws { Exception } Throws a exception if( srcStr ) is not a String.
 * @throws { Exception } Throws a exception if( o ) is not a Map.
 * @throws { Exception } Throws a exception if no arguments provided.
 * @memberof module:Tools/base/l5/StringTools.Tools( module::StringTools )
 *
 */

function strFilenameFor( o )
{
  if( _.strIs( o ) )
  o = { srcString : o }

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.srcString ) );
  _.routineOptions( strFilenameFor,o );

  let regexp = /<|>|:|"|'|\/|\\|\||\&|\?|\*|\n|\s/g;
  let result = o.srcString.replace( regexp,function( match )
  {
    return o.delimeter;
  });

  return result;
}

strFilenameFor.defaults =
{
  srcString : null,
  delimeter : '_',
}

//

/**
 * Replaces invalid characters from variable name `o.src` with special character `o.delimeter`.
 *
 * @description
 * Accepts string as single arguments. In this case executes routine with default `o.delimeter`.
 *
 * @param {Object} o Options map.
 * @param {String} o.src Source string.
 * @param {String} o.delimeter='_' Replacer string.
 *
 * @example
 * _.strVarNameFor( 'some:var');//some_var
 *
 * @returns {String} Returns string with result of replacements.
 * @throws { Exception } Throws a exception if( srcStr ) is not a String.
 * @throws { Exception } Throws a exception if( o ) is not a Map.
 * @throws { Exception } Throws a exception if no arguments provided.
 * @function strVarNameFor
 * @memberof module:Tools/base/l5/StringTools.Tools( module::StringTools )
 *
 */

function strVarNameFor( o )
{
  if( _.strIs( o ) )
  o = { src : o }

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.src ) );
  _.routineOptions( strVarNameFor,o );

  let regexp = /\.|\-|\+|<|>|:|"|'|\/|\\|\||\&|\?|\*|\n|\s/g;
  let result = o.src.replace( regexp,function( match )
  {
    return o.delimeter;
  });

  return result;
}

strVarNameFor.defaults =
{
  src : null,
  delimeter : '_',
}

//

/**
 * @summary Html escape symbols map.
 * @enum {String} _strHtmlEscapeMap
 * @memberof module:Tools/base/l5/StringTools~
 */

let _strHtmlEscapeMap =
{
  '&' : '&amp;',
  '<' : '&lt;',
  '>' : '&gt;',
  '"' : '&quot;',
  '\'' : '&#39;',
  '/' : '&#x2F;'
}

/**
 * Replaces all occurrences of html escape symbols from map {@link module:Tools/base/l5/StringTools~_strHtmlEscapeMap}
 * in source( str ) with their code equivalent like( '&' -> '&amp;' ).
 * Returns result of replacements as new string or original if nothing replaced.
 *
 * @param {string} str - Source string to parse.
 * @returns {string} Returns string with result of replacements.
 *
 * @example
 * //returns &lt;&amp;test &amp;text &amp;here&gt;
 * _.strHtmlEscape( '<&test &text &here>' );
 *
 * @example
 * //returns 1 &lt; 2
 * _.strHtmlEscape( '1 < 2' );
 *
 * @example
 * //returns &#x2F;&#x2F;test&#x2F;&#x2F;
 * _.strHtmlEscape( '//test//' );
 *
 * @example
 * //returns &amp;,&lt;
 * _.strHtmlEscape( ['&','<'] );
 *
 * @example
 * //returns &lt;div class=&quot;cls&quot;&gt;&lt;&#x2F;div&gt;
 * _.strHtmlEscape('<div class="cls"></div>');
 *
 * @function  strHtmlEscape
 * @throws { Exception } Throws a exception if no argument provided.
 * @memberof module:Tools/base/l5/StringTools.Tools( module::StringTools )
 *
 */

function strHtmlEscape( str )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  return String( str ).replace( /[&<>"'\/]/g, function( s )
  {
    return _strHtmlEscapeMap[ s ];
  });
}

//
//
// function strToRegexpTolerating( src )
// {
//   let result = src;
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( src ) || _.regexpIs( src ) );
//
//   if( _.strIs( src ) )
//   {
//
//     let optionsExtract =
//     {
//       prefix : '>->',
//       postfix : '<-<',
//       src,
//     }
//
//     let strips = _.strExtractInlinedStereo( optionsExtract );
//
//     for( let s = 0 ; s < strips.length ; s++ )
//     {
//       let strip = strips[ s ];
//
//       if( s % 2 === 0 )
//       {
//         strip = _.regexpEscape( strip );
//         strip = strip.replace( /\s+/g,'\\s*' );
//       }
//
//       strips[ s ] = strip;
//     }
//
//     result = RegExp( strips.join( '' ),'g' );
//   }
//
//   return result;
// }
//
//
//
// function strToRegexp( src )
// {
//   let result = [];
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( src ) || _.regexpIs( src ) );
//
//   if( _.strIs( src ) )
//   {
//     src = _.regexpEscape( src );
//     src = RegExp( src,'g' );
//   }
//
//   return src;
// }
//
//

/*
qqq : tests required
*/

function strSearch( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( strSearch,o );

  /* */

  o.ins = _.arrayAs( o.ins );
  o.ins = _.regexpsMaybeFrom
  ({
    srcStr : o.ins,
    stringWithRegexp : o.stringWithRegexp,
    toleratingSpaces : o.toleratingSpaces,
  });

  if( _.arrayIs( o.excludingTokens ) || _.strIs( o.excludingTokens ) )
  {
    o.excludingTokens = _.path.globsShortToRegexps( o.excludingTokens );
    o.excludingTokens = _.regexpsAny( o.excludingTokens );
  }

  /* */

  let result = [];
  let found = _.strFindAll( o.src, o.ins );

  found.forEach( ( it ) =>
  {

    it.charsRange = it.range;
    it.charsRangeRight = [ o.src.length - it.charsRange[ 0 ], o.src.length - it.charsRange[ 1 ] ];

    let first;
    if( o.determiningLineNumber )
    {
      first = o.src.substring( 0,it.charsRange[ 0 ] ).split( '\n' ).length;
      it.linesRange = [ first, first+o.src.substring( it.charsRange[ 0 ], it.charsRange[ 1 ] ).split( '\n' ).length ];
    }

    if( o.nearestLines )
    debugger;
    if( o.nearestLines )
    it.nearest = _.strLinesNearest
    ({
      src : o.src,
      charsRange : it.charsRange,
      numberOfLines : o.nearestLines,
    }).splits;

    if( o.determiningLineNumber )
    it.linesOffsets = [ first - _.strLinesCount( it.nearest[ 0 ] ) + 1, first, first + _.strLinesCount( it.nearest[ 1 ] ) ];

    if( o.onTokenize )
    {
      let tokens = o.onTokenize( it.nearest.join( '' ) );

      let ranges = _.select( tokens, '*/range/0' );
      let range = [ it.nearest[ 0 ].length, it.nearest[ 0 ].length + it.nearest[ 1 ].length ];
      let having = _.sorted.lookUpIntervalHaving( ranges, range );

      _.assert( ranges[ having[ 0 ] ] <= range[ 0 ] );
      _.assert( having[ 1 ] === ranges.length || ranges[ having[ 1 ] ] >= range[ 1 ] );

      if( o.excludingTokens )
      {
        debugger;
        let tokenNames = _.select( tokens, '*/tokenName' );
        tokenNames = tokenNames.slice( having[ 0 ], having[ 1 ] );
        let pass = _.none( _.regexpTest( o.excludingTokens, tokenNames ) );
        if( !pass )
        return;
      }

    }

    if( !o.nearestSplitting )
    it.nearest.join( '' );

    result.push( it );
  });

  return result;
}

strSearch.defaults =
{
  src : null,
  ins : null,
  nearestLines : 3,
  nearestSplitting : 1,
  determiningLineNumber : 0,
  stringWithRegexp : 0,
  toleratingSpaces : 0,
  onTokenize : null,
  excludingTokens : null,
}

//

function strFindAll( src, ins )
{
  let o;

  if( arguments.length === 2 )
  {
    o = { src : arguments[ 0 ] , ins : arguments[ 1 ] };
  }
  else if( arguments.length === 1 )
  {
    o = arguments[ 0 ];
  }

  if( _.strIs( o.ins ) || _.regexpIs( o.ins ) )
  o.ins = [ o.ins ];

  /* */

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( o.src ) );
  _.assert( _.arrayLike( o.ins ) || _.objectIs( o.ins ) );
  _.routineOptions( strFindAll, o );

  /* */

  ins = o.ins;
  let tokenNames;
  if( _.mapIs( ins ) )
  {
    tokenNames = [];
    ins = [];
    let i = 0;
    for( var name in o.ins )
    {
      tokenNames[ i ] = name;
      ins[ i ] = o.ins[ name ];
      i += 1;
    }
  }

  let descriptorsArray = [];
  let execeds = [];
  let closests = [];
  let closestTokenId = -1;
  let closestIndex = o.src.length;
  let currentIndex = 0;

  /* */

  ins.forEach( ( ins, tokenId ) =>
  {
    _.assert( _.strIs( ins ) || _.regexpIs( ins ) );
    if( _.regexpIs( ins ) )
    _.assert( !ins.sticky );

    let found = find( o.src, ins, tokenId );
    closests[ tokenId ] = found;
    if( found < closestIndex )
    {
      closestIndex = found
      closestTokenId = tokenId;
    }
  });

  /* */

  while( closestIndex < o.src.length )
  {

    if( o.tokenizingUnknown && closestIndex > currentIndex )
    {
      descriptorFor( o.src, currentIndex, -1 );
    }

    descriptorFor( o.src, closestIndex, closestTokenId );

    closestIndex = o.src.length;
    closests.forEach( ( index, tokenId ) =>
    {
      if( index < currentIndex )
      index = closests[ tokenId ] = find( o.src, ins[ tokenId ], tokenId );

      _.assert( closests[ tokenId ] >= currentIndex );

      if( index < closestIndex )
      {
        closestIndex = index
        closestTokenId = tokenId;
      }
    });

    _.assert( closestIndex <= o.src.length );
  }

  if( o.tokenizingUnknown && closestIndex > currentIndex )
  {
    descriptorFor( o.src, currentIndex, -1 );
  }

  /* */

  return descriptorsArray;

  /* */

  function find( src, ins, tokenId )
  {
    let result;

    if( _.strIs( ins ) )
    {
      if( !ins.length )
      result = src.length;
      else
      result = findWithString( o.src, ins, tokenId );
    }
    else
    {
      result = findWithRegexp( o.src, ins, tokenId );
    }

    _.assert( result >= 0 );
    return result;
  }

  /* */

  function findWithString( src, ins )
  {

    if( !ins.length )
    return src.length;

    let index = src.indexOf( ins, currentIndex );

    if( index < 0 )
    return src.length;

    return index;
  }

  /* */

  function findWithRegexp( src, ins, tokenId )
  {
    let execed;
    let result = src.length;

    if( currentIndex === 0 || ins.global )
    {

      do
      {

        execed = ins.exec( src );
        if( execed )
        result = execed.index;
        else
        result = src.length;

      }
      while( result < currentIndex );

    }
    else
    {
      execed = ins.exec( src.substring( currentIndex ) );

      if( execed )
      result = execed.index + currentIndex;

    }

    if( execed )
    execeds[ tokenId ] = execed;

    return result;
  }

  /* */

  function descriptorFor( src, index, tokenId )
  {
    let originalIns = ins[ tokenId ];
    let foundIns;

    if( tokenId === -1 )
    originalIns = src.substring( index, closestIndex );

    if( o.fast )
    {
      let it = [];

      if( _.strIs( originalIns ) )
      {
        foundIns = originalIns;
      }
      else
      {
        let execed = execeds[ tokenId ];
        _.assert( !!execed );
        foundIns = execed[ 0 ];
      }

      it[ 0 ] = index;
      it[ 1 ] = index + foundIns.length;
      it[ 2 ] = tokenId;

      descriptorsArray.push( it );
    }
    else
    {
      let it = Object.create( null );
      let groups;

      if( _.strIs( originalIns ) )
      {
        foundIns = originalIns;
        groups = [];
      }
      else
      {
        let execed = execeds[ tokenId ];
        _.assert( !!execed );
        foundIns = execed[ 0 ];
        groups = _.longSlice( execed, 1, execed.length );
      }

      it.match = foundIns;
      it.groups = groups;
      it.tokenId = tokenId;
      it.range = [ index, index + foundIns.length ];
      it.counter = o.counter;
      it.input = src;

      if( tokenNames )
      it.tokenName = tokenNames[ tokenId ];

      descriptorsArray.push( it );
    }

    if( foundIns.length > 0 )
    currentIndex = index + foundIns.length;
    else
    currentIndex = index + 1;

    o.counter += 1;
  }

}

strFindAll.defaults =
{
  src : null,
  ins : null,
  fast : 0,
  counter : 0,
  tokenizingUnknown : 0,
}

//

function _strReplaceMapPrepare( o )
{

  /* verify */

  _.assertMapHasAll( o, _strReplaceMapPrepare.defaults );
  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( o.dictionary ) || _.longIs( o.dictionary ) || o.dictionary === null );
  _.assert( ( _.longIs( o.ins ) && _.longIs( o.sub ) ) || ( o.ins === null && o.sub === null ) );

  /* pre */

  if( o.dictionary )
  {

    o.ins = [];
    o.sub = [];

    if( _.objectIs( o.dictionary ) )
    {
      let i = 0;
      for( let d in o.dictionary )
      {
        o.ins[ i ] = d;
        o.sub[ i ] = o.dictionary[ d ];
        i += 1;
      }
    }
    else
    {
      let i = 0;
      o.dictionary.forEach( ( d ) =>
      {
        let ins = d[ 0 ];
        let sub = d[ 1 ];
        _.assert( d.length === 2 );
        _.assert( !( _.arrayIs( ins ) ^ _.arrayIs( sub ) ) );
        if( _.arrayIs( ins ) )
        {
          _.assert( ins.length === sub.length )
          for( let n = 0 ; n < ins.length ; n++ )
          {
            o.ins[ i ] = ins[ n ];
            o.sub[ i ] = sub[ n ];
            i += 1;
          }
        }
        else
        {
          o.ins[ i ] = ins;
          o.sub[ i ] = sub;
          i += 1;
        }
      });
    }

    o.dictionary = null;
  }

  /* verify */

  _.assert( !o.dictionary );
  _.assert( o.ins.length === o.sub.length );

  if( Config.debug )
  {
    o.ins.forEach( ( ins ) => _.assert( _.strIs( ins ) || _.regexpIs( ins ) ), 'Expects String or RegExp' );
    o.sub.forEach( ( sub ) => _.assert( _.strIs( sub ) || _.routineIs( sub ) ), 'Expects String or Routine' );
  }

  return o;
}

_strReplaceMapPrepare.defaults =
{
  dictionary : null,
  ins : null,
  sub : null,
}

//

/**
 * Replaces each occurrence of string( ins ) in source( src ) with string( sub ).
 * Returns result of replacements as new string or original string if no matches finded in source( src ).
 * Function can be called in three different ways:
 * - One argument: object that contains options: source( src ) and dictionary.
 * - Two arguments: source string( src ), map( dictionary ).
 * - Three arguments: source string( src ), pattern string( ins ), replacement( sub ).
 * @param {string} src - Source string to parse.
 * @param {string} ins - String to find in source( src ).
 * @param {string} sub - String that replaces finded occurrence( ins ).
 * @param {object} dictionary - Map that contains pattern/replacement pairs like ( { 'ins' : 'sub' } ).
 * @returns {string} Returns string with result of replacements.
 *
 * @example
 * //one argument
 * //returns xbc
 * _.strReplaceAll( { src : 'abc', dictionary : { 'a' : 'x' } } );
 *
 * @example
 * //two arguments
 * //returns a12
 * _.strReplaceAll( 'abc',{ 'a' : '1', 'b' : '2' } );
 *
 * @example
 * //three arguments
 * //returns axc
 * _.strReplaceAll( 'abc','b','x' );
 *
 * @function  strReplaceAll
 * @throws { Exception } Throws a exception if no arguments provided.
 * @throws { Exception } Throws a exception if( src ) is not a String.
 * @throws { Exception } Throws a exception if( ins ) is not a String.
 * @throws { Exception } Throws a exception if( sub ) is not a String.
 * @throws { Exception } Throws a exception if( dictionary ) is not a Object.
 * @throws { Exception } Throws a exception if( dictionary ) key value is not a String.
 * @memberof module:Tools/base/l5/StringTools.Tools( module::StringTools )
 *
 */

/*
qqq : extend coverage
*/

function strReplaceAll( src, ins, sub )
{
  let o;
  let foundArray = [];

  if( arguments.length === 3 )
  {
    o = { src };
    o.dictionary = [ [ ins, sub ] ]
  }
  else if( arguments.length === 2 )
  {
    o = { src : arguments[ 0 ] , dictionary : arguments[ 1 ] };
  }
  else if( arguments.length === 1 )
  {
    o = arguments[ 0 ];
  }

  /* verify */

  _.routineOptions( strReplaceAll, o );
  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  _.assert( _.strIs( o.src ) );

  _._strReplaceMapPrepare( o );

  /* */

  let found = _.strFindAll( o.src, o.ins );
  let result = [];
  let index = 0;

  found.forEach( ( it ) =>
  {
    let sub = o.sub[ it.tokenId ];
    let unknown = o.src.substring( index, it.range[ 0 ] );
    if( unknown )
    if( o.onUnknown )
    unknown = o.onUnknown( unknown, it, o );
    if( unknown !== '' )
    result.push( unknown );
    if( _.routineIs( sub ) )
    sub = sub.call( o, it.match, it );
    // _.assert( _.strIs( sub ) );
    if( sub !== '' )
    result.push( sub );
    index = it.range[ 1 ];
  });

  result.push( o.src.substring( index, o.src.length ) );

  if( o.joining )
  result = result.join( '' )

  return result;
}

strReplaceAll.defaults =
{
  src : null,
  dictionary : null,
  ins : null,
  sub : null,
  joining : 1,
  onUnknown : null,
  // counter : 0,
}

//

var JsTokensDefinition =
{
  'comment/multiline'     : /\/\*(?:\n|.)*?\*\//,
  'comment/singleline'    : /\/\/.*?(?=\n|$)/,
  'string/single'         : /'(?:\\\n|\\'|[^'\n])*?'/,
  'string/double'         : /"(?:\\\n|\\"|[^"\n])*?"/,
  'string/multiline'      : /`(?:\\\n|\\`|[^`])*?`/,
  'whitespace'            : /\s+/,
  'keyword'               : /\b(?:do|if|in|for|let|new|try|var|case|else|enum|eval|null|this|true|void|with|await|break|catch|class|const|false|super|throw|while|yield|delete|export|import|public|return|static|switch|typeof|default|extends|finally|package|private|continue|debugger|function|arguments|interface|protected|implements|instanceof)\b/,
  'regexp'                : /\/((?:\\\/|[^\/\n])+?)\/(\w*)/,
  'name'                  : /[a-z_\$][0-9a-z_\$]*/i,
  'number'                : /(?:0x(?:\d|[a-f])+|\d+(?:\.\d+)?(?:e[+-]?\d+)?)/i,
  'parenthes'             : /[\(\)]/,
  'curly'                 : /[{}]/,
  'square'                : /[\[\]]/,
  'punctuation'           : /;|,|\.\.\.|\.|\:|\?|=>|>=|<=|<|>|!==|===|!=|==|=|!|&|<<|>>|>>>|\+\+|--|\*\*|\+|-|\^|\||\/|\*|%|~|\!/,
}

function strTokenizeJs( o )
{
  if( _.strIs( o ) )
  o = { src : o }

  let result = _.strFindAll
  ({
    src : o.src,
    ins : JsTokensDefinition,
    tokenizingUnknown : o.tokenizingUnknown,
  });

  return result;
}

strTokenizeJs.defaults =
{
  src : null,
  tokenizingUnknown : 0,
}

//

var CppTokensDefinition =
{
  'comment/multiline'     : /\/\*.*?\*\//,
  'comment/singleline'    : /\/\/.*?(?=\n|$)/,
  'string/single'         : /'(?:\\\n|\\'|[^'\n])*?'/,
  'string/double'         : /"(?:\\\n|\\"|[^"\n])*?"/,
  'string/multiline'      : /`(?:\\\n|\\`|[^`])*?`/,
  'whitespace'            : /\s+/,
  'keyword'               : /\b(?:do|if|in|for|let|new|try|var|case|else|enum|eval|null|this|true|void|with|await|break|catch|class|const|false|super|throw|while|yield|delete|export|import|public|return|static|switch|typeof|default|extends|finally|package|private|continue|debugger|function|arguments|interface|protected|implements|instanceof)\b/,
  'regexp'                : /\/(?:\\\/|[^\/])*?\/(\w+)/,
  'name'                  : /[a-z_\$][0-9a-z_\$]*/i,
  'number'                : /(?:0x(?:\d|[a-f])+|\d+(?:\.\d+)?(?:e[+-]?\d+)?)/i,
  'parenthes'             : /[\(\)]/,
  'curly'                 : /[{}]/,
  'square'                : /[\[\]]/,
  'punctuation'           : /;|,|\.\.\.|\.|\:|\?|=>|>=|<=|<|>|!=|!=|==|=|!|&|<<|>>|\+\+|--|\*\*|\+|-|\^|\||\/|\*|%|~|\!/,
}

function strTokenizeCpp( o )
{
  if( _.strIs( o ) )
  o = { src : o }

  let result = _.strFindAll
  ({
    src : o.src,
    ins : JsTokensDefinition,
    tokenizingUnknown : o.tokenizingUnknown,
  });

  return result;
}

strTokenizeCpp.defaults =
{
  src : null,
  tokenizingUnknown : 0,
}

//

/**
 * @summary Splits string into a parts using ranges from ( sparce ) sparce array.
 * @param {String} srcStr - Source string to parse.
 * @param {Array} sparse - Sparse array with ranges.
 * @returns {Array} Returns array with parts of string.
 *
 * @example
 * _.strSubs( 'aabbcc', [  ] );//
 *
 * @function strSubs
 * @throws { Exception } If not enough argumets provided.
 * @throws { Exception } If ( srcStr ) is not a string.
 * @throws { Exception } If ( sparce ) is not a sparce array.
 * @memberof module:Tools/base/l5/StringTools.Tools( module::StringTools )
 *
 */

function strSubs( srcStr, sparse )
{
  var result = [];

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( srcStr ) );
  _.assert( _.sparse.is( sparse ) );

  debugger;

  _.sparse.eachRange( sparse, ( range ) =>
  {
    result.push( srcStr.substring( range[ 0 ], range[ 1 ] ) );
  });

  return result;
}

//

function strSorterParse( o )
{

  if( arguments.length === 1 )
  {
    if( _.strIs( o ) )
    o = { src : o }
  }

  if( arguments.length === 2 )
  {
    o =
    {
      src : arguments[ 0 ],
      fields : arguments[ 1 ]
    }
  }

  _.routineOptions( strSorterParse, o );
  _.assert( o.fields === null || _.objectLike( o.fields ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  let map =
  {
    '>' : 1,
    '<' : 0
  }

  let delimeters = _.mapOwnKeys( map );
  let splitted = _.strSplit
  ({
    src : o.src,
    delimeter : delimeters,
    stripping : 1,
    preservingDelimeters : 1,
    preservingEmpty : 0,
  });

  let parsed = [];

  if( splitted.length >= 2 )
  for( let i = 0; i < splitted.length; i+= 2 )
  {
    let field = splitted[ i ];
    let postfix = splitted[ i + 1 ];

    _.assert( o.fields ? o.fields[ field ] : true, 'Field: ', field, ' is not allowed.' );
    _.assert( _.strIs( postfix ), 'Field: ', field, ' doesn\'t have a postfix.' );

    let valueForPostfix = map[ postfix ];

    if( valueForPostfix !== undefined )
    {
      parsed.push( [ field,valueForPostfix ] )
    }
    else
    {
      _.assert( 0, 'unknown postfix: ', postfix )
    }
  }

  return parsed;
}

strSorterParse.defaults =
{
  src : null,
  fields : null,
}

//

// function jsonParse( o )
// {
//   let result;

//   if( _.strIs( o ) )
//   o = { src : o }
//   _.routineOptions( jsonParse, o );
//   _.assert( arguments.length === 1 );

//   debugger; /* xxx: implement via GDF */

//   try
//   {
//     result = JSON.parse( o.src );
//   }
//   catch( err )
//   {
//     let src = o.src;
//     let position = /at position (\d+)/.exec( err.message );
//     if( position )
//     position = Number( position[ 1 ] );
//     let first = 0;
//     if( !isNaN( position ) )
//     {
//       let nearest = _.strLinesNearest( src, position );
//       first = _.strLinesCount( src.substring( 0, nearest.spans[ 0 ] ) );
//       src = nearest.splits.join( '' );
//     }
//     let err2 = _.err( 'Error parsing JSON\n', err, '\n', _.strLinesNumber( src, first ) );
//     throw err2;
//   }

//   return result;
// }

function jsonParse( o )
{
  let result;

  if( _.strIs( o ) )
  o = { src : o }
  _.routineOptions( jsonParse, o );
  _.assert( arguments.length === 1 );

  let selected = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'json' });
  _.assert( selected.length === 1 );
  let jsonParser = selected[ 0 ];

  result = jsonParser.encode({ data : o.src });

  return result.data;
}

jsonParse.defaults =
{
  src : null,
}

// --
// format
// --

/**
 * Converts string( str ) to array of unsigned 8-bit integers.
 *
 * @param {string} str - Source string to convert.
 * @returns {typedArray} Returns typed array that represents string characters in 8-bit unsigned integers.
 *
 * @example
 * //returns [ 101, 120, 97, 109, 112, 108, 101 ]
 * _.strToBytes( 'example' );
 *
 * @function  strToBytes
 * @throws { Exception } Throws a exception if( src ) is not a String.
 * @throws { Exception } Throws a exception if no argument provided.
 * @memberof module:Tools/base/l5/StringTools.Tools( module::StringTools )
 *
 */

function strToBytes( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( src ) );

  let result = new Uint8Array( src.length );

  for( let s = 0, sl = src.length ; s < sl ; s++ )
  {
    result[ s ] = src.charCodeAt( s );
  }

  return result;
}

//

 /**
 * @summary Contains metric prefixes.
 * @enum {} _metrics
 * @memberof module:Tools/base/l5/StringTools~
 */

let _metrics =
{

  '24'  : { name : 'yotta', symbol : 'Y' , word : 'septillion' },
  '21'  : { name : 'zetta', symbol : 'Z' , word : 'sextillion' },
  '18'  : { name : 'exa'  , symbol : 'E' , word : 'quintillion' },
  '15'  : { name : 'peta' , symbol : 'P' , word : 'quadrillion' },
  '12'  : { name : 'tera' , symbol : 'T' , word : 'trillion' },
  '9'   : { name : 'giga' , symbol : 'G' , word : 'billion' },
  '6'   : { name : 'mega' , symbol : 'M' , word : 'million' },
  '3'   : { name : 'kilo' , symbol : 'k' , word : 'thousand' },
  '2'   : { name : 'hecto', symbol : 'h' , word : 'hundred' },
  '1'   : { name : 'deca' , symbol : 'da', word : 'ten' },

  '0'   : { name : ''     , symbol : ''  , word : '' },

  '-1'  : { name : 'deci' , symbol : 'd' , word : 'tenth' },
  '-2'  : { name : 'centi', symbol : 'c' , word : 'hundredth' },
  '-3'  : { name : 'milli', symbol : 'm' , word : 'thousandth' },
  '-6'  : { name : 'micro', symbol : 'μ' , word : 'millionth' },
  '-9'  : { name : 'nano' , symbol : 'n' , word : 'billionth' },
  '-12' : { name : 'pico' , symbol : 'p' , word : 'trillionth' },
  '-15' : { name : 'femto', symbol : 'f' , word : 'quadrillionth' },
  '-18' : { name : 'atto' , symbol : 'a' , word : 'quintillionth' },
  '-21' : { name : 'zepto', symbol : 'z' , word : 'sextillionth' },
  '-24' : { name : 'yocto', symbol : 'y' , word : 'septillionth' },

  range : [ -24,+24 ],

}

/**
 * Returns string that represents number( src ) with metric unit prefix that depends on options( o ).
 * If no options provided function start calculating metric with default options.
 * Example: for number ( 50000 ) function returns ( "50.0 k" ), where "k"- thousand.
 *
 * @param {(number|string)} src - Source object.
 * @param {object} o - conversion options.
 * @param {number} [ o.divisor=3 ] - Sets count of number divisors.
 * @param {number} [ o.thousand=1000 ] - Sets integer power of one thousand.
 * @param {boolean} [ o.fixed=1 ] - The number of digits to appear after the decimal point, example : [ '58912.001' ].
 * Number must be between 0 and 20.
 * @param {number} [ o.dimensions=1 ] - Sets exponent of a number.
 * @param {number} [ o.metric=0 ] - Sets the metric unit type from the map( _metrics ).
 * @returns {string} Returns number with metric prefix as a string.
 *
 * @example
 * //returns "1.0 M"
 * _.strMetricFormat( 1, { metric : 6 } );
 *
 * @example
 * //returns "100.0 "
 * _.strMetricFormat( "100m", { } );
 *
 * @example
 * //returns "100.0 T
 * _.strMetricFormat( "100m", { metric : 12 } );
 *
 * @example
 * //returns "2 k"
 * _.strMetricFormat( "1500", { fixed : 0 } );
 *
 * @example
 * //returns "1.0 M"
 * _.strMetricFormat( "1000000",{ divisor : 2, thousand : 100 } );
 *
 * @example
 * //returns "10.0 h"
 * _.strMetricFormat( "10000", { divisor : 2, thousand : 10, dimensions : 3 } );
 *
 * @function strMetricFormat
 * @memberof module:Tools/base/l5/StringTools.Tools( module::StringTools )
 *
 */

 /*
-  Dmytro : founded bug.
-  If divisor is used then check loop of number format transforms numbers:
-  0.000001 -> 0.0000009999 or 0.001 -> 0.000999 and so on. It is JavaScript feature.
-  So, this is cause of mistakes in result.
-  Test case with this kind of test is commented.
-
-  Also, assert
-
-  _.assert( _.numberIs( number ), '"number" should be Number' );
-
-  exists, but NaN has number type. Routine parseFloat() transforms regular strings
-  to NaN.
+qqq : cover routine strMetricFormat
 */
function strMetricFormat( number,o )
{

  if( _.strIs( number ) )
  number = parseFloat( number );

  o = _.routineOptions( strMetricFormat, o );

  if( o.metrics === null )
  o.metrics = _metrics;

  _.assert( _.numberIs( number ), '"number" should be Number' );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.objectIs( o ) || o === undefined,'Expects map {-o-}' );
  _.assert( _.numberIs( o.fixed ) );
  _.assert( o.fixed <= 20 );

  let original = number;

  if( o.dimensions !== 1 )
  o.thousand = Math.pow( o.thousand,o.dimensions );

  if( number !== 0 )
  {

    if( Math.abs( number ) >= o.thousand )
    {

      while( Math.abs( number ) >= o.thousand || !o.metrics[ String( o.metric ) ] )
      {

        if( o.metric + o.divisor > o.metrics.range[ 1 ] ) break;

        number /= o.thousand;
        o.metric += o.divisor;

      }

    }
    else if( Math.abs( number ) < 1 )
    {

      while( Math.abs( number ) < 1 || !o.metrics[ String( o.metric ) ] )
      {

        if( o.metric - o.divisor < o.metrics.range[ 0 ] ) break;

        number *= o.thousand;
        o.metric -= o.divisor;

      }

      if( number / o.thousand > 1 )
      return strMetricFormat( number, { thousand : o.thousand, metric : o.metric, fixed : o.fixed, divisor : o.divisor, metrics : o.metrics, dimensions : o.dimensions } );

    }

  }

  let result = '';

  if( o.metrics[ String( o.metric ) ] )
  {
    result = number.toFixed( o.fixed ) + ' ' + o.metrics[ String( o.metric ) ].symbol;
  }
  else
  {
    result = original.toFixed( o.fixed ) + ' ';
  }

  return result;
}

strMetricFormat.defaults =
{
  divisor : 3,
  thousand : 1000,
  fixed : 1,
  dimensions : 1,
  metric : 0,
  metrics : null,
}

//

/**
 * Short-cut for strMetricFormat() function.
 * Converts number( number ) to specific count of bytes with metric prefix.
 * Example: ( 2048 -> 2.0 kb).
 *
 * @param {string|number} str - Source number to  convert.
 * @param {object} o - conversion options.
 * @param {number} [ o.divisor=3 ] - Sets count of number divisors.
 * @param {number} [ o.thousand=1024 ] - Sets integer power of one thousand.
 * @see {@link wTools.strMetricFormat} Check out main function for more usage options and details.
 * @returns {string} Returns number of bytes with metric prefix as a string.
 *
 * @example
 * //returns "100.0 b"
 * _.strMetricFormatBytes( 100 );
 *
 * @example
 * //returns "4.0 kb"
 * _.strMetricFormatBytes( 4096 );
 *
 * @example
 * //returns "1024.0 Mb"
 * _.strMetricFormatBytes( Math.pow( 2, 30 ) );
 *
 * @function  strMetricFormatBytes
 * @memberof module:Tools/base/l5/StringTools.Tools( module::StringTools )
 *
 */

function strMetricFormatBytes( number,o )
{

  o = o || Object.create( null );
  let defaultOptions =
  {
    divisor : 3,
    thousand : 1024,
  };

  _.mapSupplement( o,defaultOptions );

  return _.strMetricFormat( number,o ) + 'b';
}

//

/**
 * Short-cut for strMetricFormat() function.
 * Converts number( number ) to specific count of seconds with metric prefix.
 * Example: ( 1000 (ms) -> 1.000 s).
 *
 * @param {number} str - Source number to  convert.
 * @param {number} [ o.fixed=3 ] - The number of digits to appear after the decimal point, example : [ '58912.001' ].
 * Can`t be changed.
 * @see {@link wTools.strMetricFormat} Check out main function for more usage options and details.
 * @returns {string} Returns number of seconds with metric prefix as a string.
 *
 * @example
 * //returns "1.000 s"
 * _.strTimeFormat( 1000 );
 *
 * @example
 * //returns "10.000 ks"
 * _.strTimeFormat( Math.pow( 10, 7 ) );
 *
 * @example
 * //returns "78.125 s"
 * _.strTimeFormat( Math.pow( 5, 7 ) );
 *
 * @function  strTimeFormat
 * @memberof module:Tools/base/l5/StringTools.Tools( module::StringTools )
 *
 */

function strTimeFormat( time )
{
  _.assert( arguments.length === 1 );
  time = _.timeFrom( time );
  let result = _.strMetricFormat( time*0.001,{ fixed : 3 } ) + 's';
  return result;
}

//

function strCsvFrom( src,o )
{

  let result = '';
  o = o || Object.create( null );

  debugger;

  if( !o.header )
  {

    o.header = [];

    _.look( _.entityValueWithIndex( src,0 ),function( e,k,i )
    {
      o.header.push( k );
    });

  }

  if( o.cellSeparator === undefined ) o.cellSeparator = ',';
  if( o.rowSeparator === undefined ) o.rowSeparator = '\n';
  if( o.substitute === undefined ) o.substitute = '';
  if( o.withHeader === undefined ) o.withHeader = 1;

  //console.log( 'o',o );

  if( o.withHeader )
  {
    _.look( o.header,function( e,k,i ){
      result += e + o.cellSeparator;
    });
    result = result.substr( 0,result.length-o.cellSeparator.length ) + o.rowSeparator;
  }

  _.each( src,function( row )
  {

    let rowString = '';

    _.each( o.header,function( key )
    {

      debugger;
      let element = _.entityWithKeyRecursive( row,key );
      if( element === undefined ) element = '';
      element = String( element );
      if( element.indexOf( o.rowSeparator ) !== -1 )
      element = _.strReplaceAll( element,o.rowSeparator,o.substitute );
      if( element.indexOf( o.cellSeparator ) !== -1 )
      element = _.strReplaceAll( element,o.cellSeparator,o.substitute );

      rowString += element + o.cellSeparator;

    });

    result += rowString.substr( 0,rowString.length-o.cellSeparator.length ) + o.rowSeparator;

  });

  return result;
}

//

function strToDom( xmlStr )
{

  let xmlDoc = null;
  let isIEParser = window.ActiveXObject || "ActiveXObject" in window;

  if( xmlStr === undefined ) return xmlDoc;

  if( window.DOMParser )
  {

    let parser = new window.DOMParser();
    let parsererrorNS = null;

    if( !isIEParser ) {

      try {
        parsererrorNS = parser.parseFromString( "INVALID", "text/xml" ).childNodes[0].namespaceURI;
      }
      catch( err ) {
        parsererrorNS = null;
      }
    }

    try
    {
      xmlDoc = parser.parseFromString( xmlStr, "text/xml" );
      if( parsererrorNS!= null && xmlDoc.getElementsByTagNameNS( parsererrorNS, "parsererror" ).length > 0 )
      {
        throw Error( 'Error parsing XML' );
        xmlDoc = null;
      }
    }
    catch( err )
    {
      throw Error( 'Error parsing XML' );
      xmlDoc = null;
    }
  }
  else
  {
    if( xmlStr.indexOf( "<?" )==0 )
    {
      xmlStr = xmlStr.substr( xmlStr.indexOf( "?>" ) + 2 );
    }
    xmlDoc = new ActiveXObject( "Microsoft.XMLDOM" );
    xmlDoc.async = "false";
    xmlDoc.loadXML( xmlStr );
  }

  return xmlDoc;
}

//

function strToConfig( src,o )
{
  let result = Object.create( null );
  if( !_.strIs( src ) )
  throw _.err( '_.strToConfig :','require string' );

  o = o || Object.create( null );
  if( o.delimeter === undefined ) o.delimeter = ' :';

  let splitted = src.split( '\n' );

  for( let s = 0 ; s < splitted.length ; s++ )
  {

    let row = splitted[ s ];
    let i = row.indexOf( o.delimeter );
    if( i === -1 ) continue;

    let key = row.substr( 0,i ).trim();
    let val = row.substr( i+1 ).trim();

    result[ key ] = val;

  }

  return result;
}

//

function strToNumberMaybe( src )
{
  _.assert( _.strIs( src ) || _.numberIs( src ) );
  if( _.numberIs( src ) )
  return src;

  let prased = parseFloat( src );
  if( !isNaN( prased ) )
  return prased;

  return src
}

//

/*
qqq : routine strStructureParse requires good coverage and extension
*/

function strStructureParse( o )
{

  if( _.strIs( o ) )
  o = { src : o }

  _.routineOptions( strStructureParse, o );
  _.assert( !!o.keyValDelimeter );
  _.assert( _.strIs( o.entryDelimeter ) );
  _.assert( _.strIs( o.src ) );
  _.assert( arguments.length === 1 );
  _.assert( _.arrayHas( [ 'map', 'array', 'string' ], o.defaultStructure ) );

  if( o.arrayElementsDelimeter === null )
  o.arrayElementsDelimeter = [ ' ', ',' ];

  let src = o.src.trim();

  if( o.parsingArrays )
  if( _.strIs( _.strInsideOf( src, o.arrayLeftDelimeter, o.arrayRightDelimeter ) ) )
  {
    let r = strToArrayMaybe( src );
    if( _.arrayIs( r ) )
    return r;
  }

  src = _.strSplit
  ({
    src,
    delimeter : o.keyValDelimeter,
    stripping : 1,
    quoting : o.quoting,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : o.quoting ? 0 : 1
  });

  let result = Object.create( null );
  for( let a = 1 ; a < src.length ; a++ )
  {
    let left = src[ a-1 ];
    let right = src[ a+0 ];
    let val = right;

    _.assert( _.strIs( left ) );
    _.assert( _.strIs( right ) );

    if( a < src.length - 1 )
    {
      let cuts = _.strIsolateRightOrAll( right, o.entryDelimeter );
      val = cuts[ 0 ];
      src[ a ] = cuts[ 2 ];
    }

    result[ left ] = val;

    if( o.toNumberMaybe )
    result[ left ] = _.strToNumberMaybe( result[ left ] );

    if( o.parsingArrays )
    result[ left ] = strToArrayMaybe( result[ left ] );

  }

  if( src.length === 1 && src[ 0 ] )
  return src[ 0 ];

  if( _.mapKeys( result ).length === 0 )
  {
    if( o.defaultStructure === 'map' )
    return result;
    else if( o.defaultStructure === 'array' )
    return [];
    else if( o.defaultStructure === 'string' )
    return '';
  }

  return result;

  /**/

  function strToArrayMaybe( str )
  {
    let result = str;
    if( !_.strIs( result ) )
    return result;
    let inside = _.strInsideOf( result, o.arrayLeftDelimeter, o.arrayRightDelimeter );
    if( inside !== false )
    {
      let splits = _.strSplit
      ({
        src : inside,
        delimeter : o.arrayElementsDelimeter,
        stripping : 1,
        quoting : 1,
        preservingDelimeters : 0,
        preservingEmpty : 0,
      });
      result = splits;
      if( o.toNumberMaybe )
      result = result.map( ( e ) => _.strToNumberMaybe( e ) );
    }
    return result;
  }

}

strStructureParse.defaults =
{
  src : null,
  keyValDelimeter : ':',
  entryDelimeter : ' ',
  arrayElementsDelimeter : null,
  arrayLeftDelimeter : '[',
  arrayRightDelimeter : ']',
  quoting : 1,
  parsingArrays : 0,
  toNumberMaybe : 1,
  defaultStructure : 'map', /* map / array / string */
}

//

/*
qqq : routine strWebQueryParse requires good coverage and extension
*/

function strWebQueryParse( o )
{

  if( _.strIs( o ) )
  o = { src : o }

  _.routineOptions( strWebQueryParse, o );
  _.assert( arguments.length === 1 );

  if( o.keyValDelimeter === null )
  o.keyValDelimeter = [ ':', '=' ];

  return _.strStructureParse( o );
}

var defaults = strWebQueryParse.defaults = Object.create( strStructureParse.defaults );

defaults.defaultStructure = 'map';
defaults.parsingArrays = 0;
defaults.keyValDelimeter = null; /* [ ':', '=' ] */
defaults.entryDelimeter = '&';

//

function strRequestParse( o )
{

  if( _.strIs( o ) )
  o = { src : o }
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.strIs( o.src ) );
  o = _.routineOptions( strRequestParse, o );

  let result = Object.create( null );

  result.subject = '';
  result.map = Object.create( null );
  result.subjects = [];
  result.maps = [];
  result.keyValDelimeter = o.keyValDelimeter;
  result.cmmandsDelimeter = o.cmmandsDelimeter;

  if( !o.src )
  return result;

  /* should be strSplit, but not strIsolateLeftOrAll because of quoting */

  let commands = _.strSplit
  ({
    src : o.src,
    delimeter : o.cmmandsDelimeter,
    stripping : 1,
    quoting : 1,
    preservingDelimeters : 0,
    preservingEmpty : 0,
  });

  /* */

  for( let c = 0 ; c < commands.length ; c++ )
  {

    let mapEntries = [ commands[ c ] ];
    if( o.keyValDelimeter )
    mapEntries = _.strSplit
    ({
      src : commands[ c ],
      delimeter : o.keyValDelimeter,
      stripping : 1,
      quoting : 1,
      preservingDelimeters : 1,
      preservingEmpty : 0,
    });

    let subject, map;
    if( mapEntries.length === 1 )
    {
      subject = mapEntries[ 0 ];
      map = Object.create( null );
    }
    else
    {
      let subjectAndKey = _.strIsolateRightOrAll( mapEntries[ 0 ], ' ' );
      subject = subjectAndKey[ 0 ];
      mapEntries[ 0 ] = subjectAndKey[ 2 ];

      map = _.strStructureParse
      ({
        src : mapEntries.join( '' ),
        keyValDelimeter : o.keyValDelimeter,
        parsingArrays : o.parsingArrays,
        quoting : o.quoting
      });

    }

    result.subjects.push( subject );
    result.maps.push( map );
  }

  if( result.subjects.length )
  result.subject = result.subjects[ 0 ];
  if( result.maps.length )
  result.map = result.maps[ 0 ];

  return result;
}

var defaults = strRequestParse.defaults = Object.create( null );
defaults.keyValDelimeter = ':';
defaults.cmmandsDelimeter = ';';
defaults.quoting = 1;
defaults.parsingArrays = 1;
defaults.src = null;

//

function strJoinMap( o )
{

  _.routineOptions( strJoinMap, o );
  _.assert( _.strIs( o.keyValDelimeter ) );
  _.assert( _.strIs( o.entryDelimeter ) );
  _.assert( _.objectIs( o.src ) );
  _.assert( arguments.length === 1 );

  let result = '';
  let c = 0;
  for( let s in o.src )
  {
    if( c > 0 )
    result += o.entryDelimeter;
    result += s + o.keyValDelimeter + o.src[ s ];
    c += 1;
  }

  return result;
}

strJoinMap.defaults =
{
  src : null,
  keyValDelimeter : ':',
  entryDelimeter : ' ',
}

// --
// strTable
// --

function strTable( o )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !_.objectIs( o ) )
  o = { data : o }
  _.routineOptions( strTable,o );
  _.assert( _.longIs( o.data ) );

  if( typeof module !== 'undefined' && module !== null )
  {
    if( !_.cliTable  )
    try
    {
      _.cliTable = require( 'cli-table2' );
    }
    catch( err )
    {
    }
  }

  if( _.cliTable == undefined )
  {
    if( !o.silent )
    throw _.err( 'version of strTable without support of cli-table2 is not implemented' );
    else
    return;
  }

  /* */

  function makeWidth( propertyName, def, len )
  {
    let property = o[ propertyName ];
    let _property = _.arrayFillTimes( [], len, def );
    if( property )
    {
      _.assert( _.mapIs( property ) || _.longIs( property ) , 'routine expects colWidths/rowWidths property as Object or Array-Like' );
      for( let k in property )
      {
        k = _.numberFrom( k );
        if( k < len )
        {
          _.assert( _.numberIs( property[ k ] ) );
          _property[ k ] = property[ k ];
        }
      }
    }
    o[ propertyName ] = _property;
  }

  //

  let isArrayOfArrays = true;
  let maxLen = 0;
  for( let i = 0; i < o.data.length; i++ )
  {
    if( !_.longIs( o.data[ i ] ) )
    {
      isArrayOfArrays = false;
      break;
    }

    maxLen = Math.max( maxLen, o.data[ i ].length );
  }

  let onCellGet = strTable.onCellGet;
  o.onCellGet = o.onCellGet || isArrayOfArrays ? onCellGet.ofArrayOfArray :  onCellGet.ofFlatArray ;
  o.onCellAfter = o.onCellAfter || strTable.onCellAfter;

  if( isArrayOfArrays )
  {
    o.rowsNumber = o.data.length;
    o.colsNumber = maxLen;
  }
  else
  {
    _.assert( _.numberIs( o.rowsNumber ) && _.numberIs( o.colsNumber ) );
  }

  //

  makeWidth( 'colWidths', o.colWidth, o.colsNumber );
  makeWidth( 'colAligns', o.colAlign, o.colsNumber );
  makeWidth( 'rowWidths', o.rowWidth, o.rowsNumber );
  makeWidth( 'rowAligns', o.rowAlign, o.rowsNumber );

  let tableOptions =
  {
    head : o.head,
    colWidths : o.colWidths,
    rowWidths : o.rowWidths,
    colAligns : o.colAligns,
    rowAligns : o.rowAligns,
    style :
    {
      compact : !!o.compact,
      'padding-left' : o.paddingLeft,
      'padding-right' : o.paddingRight,
    }
  }

  let table = new _.cliTable( tableOptions );

  //

  for( let y = 0; y < o.rowsNumber; y++ )
  {
    let row = [];
    table.push( row );

    for( let x = 0; x < o.colsNumber; x++ )
    {
      let index2d = [ y, x ];
      let cellData = o.onCellGet( o.data, index2d, o );
      let cellStr;

      if( cellData === undefined )
      cellData = cellStr = '';
      else
      cellStr = _.toStr( cellData, { wrap : 0, stringWrapper : '' } );

      cellStr = o.onCellAfter( cellStr, index2d, o );
      row.push( cellStr );
    }
  }

  return table.toString();
}

strTable.defaults =
{
  data : null,
  rowsNumber : null,
  colsNumber : null,

  head : null,

  rowWidth : 5,
  rowWidths : null,
  rowAlign : 'center',
  rowAligns : null,

  colWidth : 5,
  colWidths : null,
  colAlign : 'center',
  colAligns : null,

  compact : 1,
  silent : 1,

  paddingLeft : 0,
  paddingRight : 0,


  onCellGet : null,
  onCellAfter : null,
}

strTable.onCellGet =
{
  ofFlatArray : ( data, index2d, o  ) => data[ index2d[ 0 ] * o.colsNumber + index2d[ 1 ] ],
  ofArrayOfArray : ( data, index2d, o  ) => data[ index2d[ 0 ] ][ index2d[ 1 ] ]
}

strTable.onCellAfter = ( cellStr, index2d, o ) => cellStr

//

function strsSort( srcs )
{

  _.assert( _.strsAreAll( srcs ) );

  let result = srcs.sort( function( a, b )
  {
    if( a < b )
    return -1;
    if( a > b )
    return +1;
    return 0;
  });

  return result;
}

//

function strSimilarity( src1,src2 )
{
  _.assert( _.strIs( src1 ) );
  _.assert( _.strIs( src2 ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  debugger;

  let spectres = [ _.strLattersSpectre( src1 ),_.strLattersSpectre( src2 ) ];
  let result = _.strLattersSpectresSimilarity( spectres[ 0 ],spectres[ 1 ] );

  return result;
}

//

function strLattersSpectre( src )
{
  let total = 0;
  let result = new U32x( 257 );

  _.assert( arguments.length === 1 );

  for( let s = 0 ; s < src.length ; s++ )
  {
    let c = src.charCodeAt( s );
    result[ c & 0xff ] += 1;
    total += 1;
    c = c >> 8;
    if( c === 0 )
    continue;
    result[ c & 0xff ] += 1;
    total += 1;
    if( c === 0 )
    continue;
    result[ c & 0xff ] += 1;
    total += 1;
    if( c === 0 )
    continue;
    result[ c & 0xff ] += 1;
    total += 1;
  }

  result[ 256 ] = total;

  return result;
}

//

function strLattersSpectresSimilarity( src1, src2 )
{
  let result = 0;
  let minl = Math.min( src1[ 256 ], src2[ 256 ] );
  let maxl = Math.max( src1[ 256 ], src2[ 256 ] );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( src1.length === src2.length );

  for( let s = 0 ; s < src1.length-1 ; s++ )
  {
    result += Math.abs( src1[ s ] - src2[ s ] );
  }

  result = ( minl / maxl ) - ( 0.5 * result / maxl );

  if( result > 1 )
  debugger;

  result = _.numberClamp( result, [ 0,1 ] );

  return result;
}

//
//
// function lattersSpectreComparison( src1,src2 )
// {
//
//   let same = 0;
//
//   if( src1.length === 0 && src2.length === 0 ) return 1;
//
//   for( let l in src1 )
//   {
//     if( l === 'length' ) continue;
//     if( src2[ l ] ) same += Math.min( src1[ l ],src2[ l ] );
//   }
//
//   return same / Math.max( src1.length,src2.length );
// }

// --
// declare
// --

let Extend =
{

  // strDecamelize,
  strCamelize,
  strToTitle,

  strFilenameFor,
  strVarNameFor,
  strHtmlEscape,

  // strToRegexpTolerating,
  // strToRegexp,

  strSearch,
  strFindAll,

  _strReplaceMapPrepare,
  strReplaceAll, /* document me */
  strTokenizeJs,
  strTokenizeCpp,

  strSubs,

  strSorterParse,
  jsonParse,

  // format

  strToBytes,
  strMetricFormat,
  strMetricFormatBytes,

  strTimeFormat,

  strCsvFrom, /* experimental */
  strToDom, /* experimental */ // !!! move out
  strToConfig, /* experimental */

  strToNumberMaybe,
  strStructureParse, /* qqq : cover it by tests */
  strWebQueryParse, /* qqq : cover it by tests */
  strRequestParse,

  strJoinMap, /* qqq : cover it by tests */

  strTable,
  strsSort,

  strSimilarity, /* experimental */
  strLattersSpectre, /* experimental */
  strLattersSpectresSimilarity,
  // lattersSpectreComparison, /* experimental */

}

_.mapExtend( Self, Extend );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
