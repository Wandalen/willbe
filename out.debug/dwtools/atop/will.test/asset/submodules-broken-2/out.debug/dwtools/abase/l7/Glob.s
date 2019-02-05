( function _Glob_s_() {

'use strict';

/**
 * @file Glob.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( '../l3/Path.s' );

  _.include( 'wStringsExtra' );

}

//

let _global = _global_;
let _ = _global_.wTools;
let Self = _.path = _.path || Object.create( null );

// --
// glob
// --

/*
(\*\*)| -- **
([?*])| -- ?*
(\[[!^]?.*\])| -- [!^]
([+!?*@]\(.*\))| -- @+!?*()
(\{.*\}) -- {}
(\(.*\)) -- ()
*/

// let transformation1 =
// [
//   [ /\[(.+?)\]/g, handleSquareBrackets ], /* square brackets */
//   [ /\{(.*)\}/g, handleCurlyBrackets ], /* curly brackets */
// ]
//
// let transformation2 =
// [
//   [ /\.\./g, '\\.\\.' ], /* double dot */
//   [ /\./g, '\\.' ], /* dot */
//   [ /([!?*@+]*)\((.*?(?:\|(.*?))*)\)/g, hanleParentheses ], /* parentheses */
//   [ /\/\*\*/g, '(?:\/.*)?', ], /* slash + double asterix */
//   [ /\*\*/g, '.*', ], /* double asterix */
//   [ /(\*)/g, '[^\/]*' ], /* single asterix */
//   [ /(\?)/g, '.', ], /* question mark */
// ]


// let _pathIsGlobRegexp = /(\*\*)|([?*])|(\[[!^]?.*\])|([+!?*@]?)|\{.*\}|(\(.*\))/;

let _pathIsGlobRegexpStr = '';
_pathIsGlobRegexpStr += '(?:[?*]+)'; /* asterix, question mark */
_pathIsGlobRegexpStr += '|(?:([!?*@+]*)\\((.*?(?:\\|(.*?))*)\\))'; /* parentheses */
_pathIsGlobRegexpStr += '|(?:\\[(.+?)\\])'; /* square brackets */
_pathIsGlobRegexpStr += '|(?:\\{(.*)\\})'; /* curly brackets */
_pathIsGlobRegexpStr += '|(?:\0)'; /* zero */

let _pathIsGlobRegexp = new RegExp( _pathIsGlobRegexpStr );

function _fromGlob( glob )
{
  let result;

  // glob = this.globNormalize( glob );

  _.assert( _.strIs( glob ), 'Expects string {-glob-}' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  // if( glob === 'dst:///' )
  // debugger;
  // if( glob === '**b**' )
  // debugger;
  // result = _.strReplaceAll( glob, _pathIsGlobRegexp, '' );

  let i = glob.search( _pathIsGlobRegexp );

  if( i >= 0 )
  {

    while( i >= 0 && glob[ i ] !== this._upStr )
    i -= 1;

    if( i === -1 )
    result = '';
    else
    result = glob.substr( 0, i+1 );

  }
  else
  {
    result = glob;
  }

  result = this.detrail( result || '.' );

  _.assert( !this.isGlob( result ) );

  return result;
}

//

function globNormalize( glob )
{
  let result = _.strReplaceAll( glob, { '*()' : '', '\0' : '' } );
  return result;
}

//

function globSplit( glob )
{
  _.assert( _.strIs( glob ), 'Expects string {-glob-}' );

  let splits = this.split( glob );

  for( let s = splits.length-1 ; s >= 0 ; s-- )
  {
    let split = splits[ s ];
    if( split === '**' || !_.strHas( split, '**' ) )
    continue;

    // if( _.strEnds( split, '**' ) )
    // {
    //   split = _.strRemoveEnd( split, '**' ) + '*';
    //   _.arrayCutin( splits, [ s,s+1 ], [ split, '**' ] );
    // }
    //
    // if( _.strBegins( split, '**' ) )
    // {
    //   split = '*' + _.strRemoveBegin( split, '**' );
    //   _.arrayCutin( splits, [ s,s+1 ], [ '**', split ] );
    // }

    split = _.strSplitFast({ src : split, delimeter : '**', preservingEmpty : 0 });
    for( let i = 0 ; i < split.length ; i++ )
    {
      if( split[ i ] === '**' )
      continue;
      if( i > 0 )
      split[ i ] = '*' + split[ i ];
      if( i < split.length-1 )
      split[ i ] = split[ i ] + '*';
    }
    // debugger;
    _.arrayCutin( splits, [ s,s+1 ], split );
    // debugger;

  }

  return splits;
}

//

/**
 * Turn a *-wildcard style _glob into a regular expression
 * @example
 * let _glob = '* /www/*.js';
 * wTools.globRegexpsForTerminalSimple( _glob );
 * // /^.\/[^\/]*\/www\/[^\/]*\.js$/m
 * @param {String} _glob *-wildcard style _glob
 * @returns {RegExp} RegExp that represent passed _glob
 * @throw {Error} If missed argument, or got more than one argumet
 * @throw {Error} If _glob is not string
 * @function globRegexpsForTerminalSimple
 * @memberof wTools
 */

function globRegexpsForTerminalSimple( _glob )
{

  function strForGlob( _glob )
  {

    let result = '';
    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assert( _.strIs( _glob ), 'Expects string {-glob-}' );

    let w = 0;
    _glob.replace( /(\*\*[\/\\]?)|\?|\*/g, function( matched,a,offset,str )
    {

      result += _.regexpEscape( _glob.substr( w,offset-w ) );
      w = offset + matched.length;

      if( matched === '?' )
      result += '.';
      else if( matched === '*' )
      result += '[^\\\/]*';
      else if( matched.substr( 0,2 ) === '**' )
      result += '.*';
      else _.assert( 0,'unexpected' );

    });

    result += _.regexpEscape( _glob.substr( w,_glob.length-w ) );
    if( result[ 0 ] !== '^' )
    {
      result = _.strPrependOnce( result,'./' );
      result = _.strPrependOnce( result,'^' );
    }
    result = _.strAppendOnce( result,'$' );

    return result;
  }

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( _glob ) || _.strsAreAll( _glob ) );

  if( _.strIs( _glob ) )
  _glob = [ _glob ];

  let result = _.entityMap( _glob,( _glob ) => strForGlob( _glob ) );
  result = RegExp( '(' + result.join( ')|(' ) + ')','m' );

  return result;
}

//

function globRegexpsForTerminalOld( src )
{

  _.assert( _.strIs( src ) || _.strsAreAll( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

/*
  (\*\*\\\/|\*\*)|
  (\*)|
  (\?)|
  (\[.*\])
*/

  let map =
  {
    0 : '.*', /* doubleAsterix */
    1 : '[^\/]*', /* singleAsterix */
    2 : '.', /* questionMark */
    3 : handleSquareBrackets, /* handleSquareBrackets */
    '{' : '(',
    '}' : ')',
  }

  /* */

  let result = '';

  if( _.strIs( src ) )
  {
    result = adjustGlobStr( src );
  }
  else
  {
    if( src.length > 1 )
    for( let i = 0; i < src.length; i++ )
    {
      let r = adjustGlobStr( src[ i ] );
      result += `(${r})`;
      if( i + 1 < src.length )
      result += '|'
    }
    else
    {
      result = adjustGlobStr( src[ 0 ] );
    }
  }

  result = _.strPrependOnce( result,'\\/' );
  result = _.strPrependOnce( result,'\\.' );

  result = _.strPrependOnce( result,'^' );
  result = _.strAppendOnce( result,'$' );

  return RegExp( result );

  /* */

  function handleSquareBrackets( src )
  {
    debugger;
    src = _.strInsideOf( src, '[', ']' );
    // src = _.strIsolateInsideOrNone( src, '[', ']' );
    /* escape inner [] */
    src = src.replace( /[\[\]]/g, ( m ) => '\\' + m );
    /* replace ! -> ^ at the beginning */
    src = src.replace( /^\\!/g, '^' );
    return '[' + src + ']';
  }

  function curlyBrackets( src )
  {
    debugger;
    src = src.replace( /[\}\{]/g, ( m ) => map[ m ] );
    /* replace , with | to separate regexps */
    src = src.replace( /,+(?![^[|(]*]|\))/g, '|' );
    return src;
  }

  function _globToRegexp()
  {
    let args = _.longSlice( arguments );
    let i = args.indexOf( args[ 0 ], 1 ) - 1;

    /* i - index of captured group from regexp is equivalent to key from map  */

    if( _.strIs( map[ i ] ) )
    return map[ i ];
    else if( _.routineIs( map[ i ] ) )
    return map[ i ]( args[ 0 ] );
    else _.assert( 0 );
  }

  function adjustGlobStr( src )
  {
    _.assert( !_.path.isAbsolute( src ) );

    /* espace simple text */
    src = src.replace( /[^\*\[\]\{\}\?]+/g, ( m ) => _.regexpEscape( m ) );
    /* replace globs with regexps from map */
    src = src.replace( /(\*\*\\\/|\*\*)|(\*)|(\?)|(\[.*\])/g, _globToRegexp );
    /* replace {} -> () and , -> | to make proper regexp */
    src = src.replace( /\{.*\}/g, curlyBrackets );
    // src = src.replace( /\{.*\}+(?![^[]*\])/g, curlyBrackets );

    return src;
  }

}

//

function _globRegexpForTerminal( glob, filePath, basePath )
{
  let self = this;
  _.assert( arguments.length === 3 );
  if( basePath === null )
  basePath = filePath;
  if( filePath === null )
  filePath = basePath;
  if( basePath === null )
  basePath = filePath = this.fromGlob( glob );
  return self._globRegexpFor2.apply( self, [ glob, filePath, basePath ] ).actual;
}

//

let _globRegexpsForTerminal = _.routineVectorize_functor
({
  routine : _globRegexpForTerminal,
  select : 3,
});

function globRegexpsForTerminal()
{
  let result = _globRegexpsForTerminal.apply( this, arguments );
  return _.regexpsAny( result );
}

//

function _globRegexpForDirectory( glob, filePath, basePath )
{
  let self = this;
  _.assert( arguments.length === 3 );
  if( basePath === null )
  basePath = filePath;
  if( filePath === null )
  filePath = basePath;
  if( basePath === null )
  basePath = filePath = this.fromGlob( glob );
  return self._globRegexpFor2.apply( self, [ glob, filePath, basePath ] ).transient;
}

//

let _globRegexpsForDirectory = _.routineVectorize_functor
({
  routine : _globRegexpForDirectory,
  select : 3,
});

function globRegexpsForDirectory()
{
  let result = _globRegexpsForDirectory.apply( this, arguments );
  return _.regexpsAny( result );
}

//

function _globRegexpFor2( glob, filePath, basePath )
{
  let self = this;

  _.assert( _.strIs( glob ), 'Expects string {-glob-}' );
  _.assert( _.strIs( filePath ) && !_.path.isGlob( filePath ) );
  _.assert( _.strIs( basePath ) && !_.path.isGlob( basePath ) );
  _.assert( arguments.length === 3 );

  glob = this.join( filePath, glob );

  // debugger;
  let related = this.relateForGlob( glob, filePath, basePath );
  // debugger;
  let maybeHere = '';
  let hereEscapedStr = self._globSplitToRegexpSource( self._hereStr );
  let downEscapedStr = self._globSplitToRegexpSource( self._downStr );

  let cache = Object.create( null );
  let result = Object.create( null );
  result.transient = [];
  result.actual = [];

  for( let r = 0 ; r < related.length ; r++ )
  {

    // related[ r ] = this.globSplit( related[ r ] );
    // related[ r ] = related[ r ].map( ( e, i ) => self._globSplitToRegexpSource( e ) );

    let transientSplits = this.globSplit( related[ r ] );
    let actualSplits = this.split( related[ r ] );

    transientSplits = transientSplits.map( ( e, i ) => toRegexp( e ) );
    actualSplits = actualSplits.map( ( e, i ) => toRegexp( e ) );

    result.transient.push( self._globRegexpSourceSplitsJoinForDirectory( transientSplits ) );
    result.actual.push( self._globRegexpSourceSplitsJoinForTerminal( actualSplits ) );

  }

  result.transient = '(?:(?:' + result.transient.join( ')|(?:' ) + '))';
  result.transient = _.regexpsJoin([ '^', result.transient, '$' ]);
  result.actual = '(?:(?:' + result.actual.join( ')|(?:' ) + '))';
  result.actual = _.regexpsJoin([ '^', result.actual, '$' ]);

  return result;

  /* - */

  function toRegexp( split )
  {
    if( cache[ split ] )
    return cache[ split ];
    cache[ split ] = self._globSplitToRegexpSource( split );
    return cache[ split ];
  }

}

//

let _globRegexpsFor2 = _.routineVectorize_functor
({
  routine : _globRegexpFor2,
  select : 3,
});

//

function globRegexpsFor2()
{
  let r = _globRegexpsFor2.apply( this, arguments );
  if( _.arrayIs( r ) )
  {
    let result = Object.create( null );
    result.actual = r.map( ( e ) => e.actual );
    result.transient = r.map( ( e ) => e.transient );
    return result;
  }
  return r;
}

//

function globToRegexp( glob )
{

  _.assert( _.strIs( glob ) || _.regexpIs( glob ) );
  _.assert( arguments.length === 1 );

  if( _.regexpIs( glob ) )
  return glob;

  let str = this._globSplitToRegexpSource( glob );

  let result = new RegExp( '^' + str + '$' );

  return result;
}

//

function globFilter_pre( routine, args )
{
  let result;

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 || args.length === 2 );

  let o = args[ 0 ];
  if( args[ 1 ] !== undefined )
  o = { src : args[ 0 ], selector : args[ 1 ] }

  o = _.routineOptions( routine, o );

  if( o.onEvaluate === null )
  o.onEvaluate = function byVal( e, k, src )
  {
    return e;
  }

  return o;
}

//

function globFilter_body( o )
{
  let result;

  _.assert( arguments.length === 1 );

  // if( !_.arrayIs( o.src ) && !_.mapIs( o.src ) )
  // o.src = [ o.src ];

  if( !this.isGlob( o.selector ) )
  {
    debugger;
    result = _.filter( o.src, ( e, k ) =>
    {
      return o.onEvaluate( e, k, o.src ) === o.selector ? e : undefined;
    });
    debugger;
  }
  else
  {
    let regexp = this.globsToRegexp( o.selector );
    result = _.filter( o.src, ( e, k ) =>
    {
      return regexp.test( o.onEvaluate( e, k, o.src ) ) ? e : undefined;
    });
  }

  return result;
}

globFilter_body.defaults =
{
  src : null,
  selector : null,
  onEvaluate : null,
}

let globFilter = _.routineFromPreAndBody( globFilter_pre, globFilter_body );

let globFilterVals = _.routineFromPreAndBody( globFilter_pre, globFilter_body );
globFilterVals.defaults.onEvaluate = function byVal( e, k, src )
{
  return e;
}

let globFilterKeys = _.routineFromPreAndBody( globFilter_pre, globFilter_body );
globFilterKeys.defaults.onEvaluate = function byKey( e, k, src )
{
  return _.arrayIs( src ) ? e : k;
}

//

function _globSplitsToRegexpSourceGroups( globSplits )
{
  let self = this;

  _.assert( _.arrayIs( globSplits ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( globSplits.length >= 1 );

  let s = 0;
  let depth = 0;
  let hereEscapedStr = self._globSplitToRegexpSource( self._hereStr );
  let downEscapedStr = self._globSplitToRegexpSource( self._downStr );
  let levels = levelsEval( globSplits );

  for( let s = 0 ; s < globSplits.length ; s++ )
  {
    let split = globSplits[ s ];
    if( _.strHas( split, '.*' ) )
    {
      let level = levels[ s ];
      if( level < 0 )
      {
        for( let i = s ; i < globSplits.length ; i++ )
        levels[ i ] += 1;
        levels.splice( s, 0, level );
        globSplits.splice( s, 0, '[^\/]*' );
      }
      else
      {
        while( levels.indexOf( level, s+1 ) !== -1 )
        {
          _.assert( 0, 'not tested' ); xxx
          levels.splice( s+1, 0, level );
          globSplits.splice( s+1, 0, '[^\/]*' );
          for( let i = s+1 ; i < globSplits.length ; i++ )
          levels[ i ] += 1;
        }
      }
    }
  }

  let groups = groupWithLevels( globSplits.slice(), levels, 0 );

  return groups;

  /* - */

  function levelsEval()
  {
    let result = [];
    let level = 0;
    for( let s = 0 ; s < globSplits.length ; s++ )
    {
      split = globSplits[ s ];
      if( split === downEscapedStr )
      level -= 1;
      result[ s ] = level;
      if( split !== downEscapedStr )
      level += 1;
    }
    return result;
  }

  /* - */

  function groupWithLevels( globSplits, levels, first )
  {
    let result = [];

    for( let b = first ; b < globSplits.length-1 ; b++ )
    {
      let level = levels[ b ];
      let e = levels.indexOf( level, b+1 );

      if( e === -1 /*|| ( b === 0 && e === globSplits.length-1 )*/ )
      {
        continue;
      }
      else
      {
        let inside = globSplits.splice( b, e-b+1, null );
        globSplits[ b ] = inside;
        inside = levels.splice( b, e-b+1, null );
        levels[ b ] = inside;
        groupWithLevels( globSplits[ b ], levels[ b ], 1 );
      }

    }

    return globSplits;
  }

}

//

function _globSplitToRegexpSource( src )
{

  _.assert( _.strIs( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !_.strHas( src, this._downStr ) || src === this._downStr, 'glob should not has splits with ".." combined with something' );

  let transformation1 =
  [
    [ /\[(.+?)\]/g, handleSquareBrackets ], /* square brackets */
    [ /\{(.*)\}/g, handleCurlyBrackets ], /* curly brackets */
  ]

  let transformation2 =
  [
    [ /\.\./g, '\\.\\.' ], /* double dot */
    [ /\./g, '\\.' ], /* dot */
    [ /([!?*@+]*)\((.*?(?:\|(.*?))*)\)/g, hanleParentheses ], /* parentheses */
    [ /\/\*\*/g, '(?:\/.*)?', ], /* slash + double asterix */
    [ /\*\*/g, '.*', ], /* double asterix */
    [ /(\*)/g, '[^\/]*' ], /* single asterix */
    [ /(\?)/g, '.', ], /* question mark */
  ]

  let result = adjustGlobStr( src );

  return result;

  /* */

  function handleCurlyBrackets( src, it )
  {
    throw _.err( 'Globs with curly brackets are not supported' );
  }

  /* */

  function handleSquareBrackets( src, it )
  {
    let inside = it.groups[ 1 ];
    /* escape inner [] */
    inside = inside.replace( /[\[\]]/g, ( m ) => '\\' + m );
    /* replace ! -> ^ at the beginning */
    inside = inside.replace( /^!/g, '^' );
    if( inside[ 0 ] === '^' )
    inside = inside + '\/';
    return '[' + inside + ']';
  }

  /* */

  function hanleParentheses( src, it )
  {

    let inside = it.groups[ 2 ].split( '|' );
    let multiplicator = it.groups[ 1 ];
    multiplicator = _.strReverse( multiplicator );
    if( multiplicator === '*' )
    multiplicator += '?';

    _.assert( _.strCount( multiplicator, '!' ) === 0 || multiplicator === '!' );
    _.assert( _.strCount( multiplicator, '@' ) === 0 || multiplicator === '@' );

    let result = '(?:' + inside.join( '|' ) + ')';
    if( multiplicator === '@' )
    result = result;
    else if( multiplicator === '!' )
    result = '(?:(?!(?:' + result + '|\/' + ')).)*?';
    else
    result += multiplicator;

    /* (?:(?!(?:abc)).)+ */

    return result;
  }

  // /* */
  //
  // function curlyBrackets( src )
  // {
  //   debugger;
  //   src = src.replace( /[\}\{]/g, ( m ) => map[ m ] );
  //   /* replace , with | to separate regexps */
  //   src = src.replace( /,+(?![^[|(]*]|\))/g, '|' );
  //   return src;
  // }

  /* */

  function adjustGlobStr( src )
  {
    let result = src;

    // _.assert( !_.path.isAbsolute( result ) );

    result = _.strReplaceAll( result, transformation1 );
    result = _.strReplaceAll( result, transformation2 );

    // /* espace ordinary text */
    // result = result.replace( /[^\*\+\[\]\{\}\?\@\!\^\(\)]+/g, ( m ) => _.regexpEscape( m ) );

    // /* replace globs with regexps from map */
    // result = result.replace( /(\*\*\\\/|\*\*)|(\*)|(\?)|(\[.*\])/g, globToRegexp );

    // /* replace {} -> () and , -> | to make proper regexp */
    // result = result.replace( /\{.*\}/g, curlyBrackets );
    // result = result.replace( /\{.*\}+(?![^[]*\])/g, curlyBrackets );

    return result;
  }

}

//

function _globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits )
{
  let result = '';
  // debugger;
  let splits = globRegexpSourceSplits.map( ( split, s ) =>
  {
    if( s > 0 )
    if( split == '.*' )
    split = '(?:(?:^|/)' + split + ')?';
    else
    split = '(?:^|/)' + split;
    return split;
  });

  // for( let g = 0 ; g < globRegexpSourceSplits.length ; g++ )
  // {
  //   let split = globRegexpSourceSplits[ g ];
  //   if( g > 0 && split !== '.*' && globRegexpSourceSplits[ g-1 ] !== '.*' )
  //   result += '/';
  //   result += split;
  // }

  result = splits.join( '' );
  // result = '^' + splits.join( '' ) + '$';
  return result;
}

//

function _globRegexpSourceSplitsJoinForDirectory( globRegexpSourceSplits )
{
  let result = '';
  let splits = globRegexpSourceSplits.map( ( split, s ) =>
  {
    if( s > 0 )
    if( split == '.*' )
    split = '(?:(?:^|/)' + split + ')?';
    else
    split = '(?:^|/)' + split;
    return split;
  });
  result = _.regexpsAtLeastFirst( splits ).source;
  return result;
}

//

function relateForGlob( glob, filePath, basePath )
{
  let self = this;
  let result = [];

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.strIs( glob ), 'Expects string {-glob-}' );
  _.assert( _.strIs( filePath ), 'Expects string' );
  _.assert( _.strIs( basePath ) );

  let glob0 = this.globNormalize( glob );
  let glob1 = this.join( filePath, glob0 );
  let r1 = this.relativeUndoted( basePath, filePath );
  let r2 = this.relativeUndoted( filePath, glob1 );
  let downGlob = this.dot( this.normalize( this.join( r1, r2 ) ) );

  result.push( downGlob );

  /* */

  if( !_.strBegins( basePath, filePath ) || basePath === filePath )
  return result;

  let common = this.common( glob1, basePath );
  let glob2 = this.relative( common, glob1 );
  basePath = this.relative( common, basePath );

  if( basePath === '.' )
  {

    result.push( ( glob2 === '' || glob2 === '.' ) ? '.' : './' + glob2 );

  }
  else
  {

    let globSplits = this.globSplit( glob2 );
    let globRegexpSourceSplits = globSplits.map( ( e, i ) => self._globSplitToRegexpSource( e ) );
    let s = 0;
    while( s < globSplits.length )
    {
      let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits.slice( 0, s+1 ) ) + '$' );
      if( globSliced.test( basePath ) )
      {
        let splits = _.strHas( globSplits[ s ], '**' ) ? globSplits.slice( s ) : globSplits.slice( s+1 );
        let glob3 = splits.join( '/' );
        result.push( glob3 === '' ? '.' : './' + glob3  );
      }

      s += 1;
    }

  }

  /* */

  return result;
}

//

function pathsRelateForGlob( filePath, oldPath, newPath )
{
  let length;

  let multiplied = _.multipleAll([ filePath, oldPath, newPath ]);

  filePath = multiplied[ 0 ];
  oldPath = multiplied[ 1 ];
  newPath = multiplied[ 2 ];

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  if( _.arrayIs( filePath ) )
  {
    let result = [];
    for( let f = 0 ; f < filePath.length ; f++ )
    result[ f ] = this.relateForGlob( filePath[ f ], oldPath[ f ], newPath[ f ] );
    return result;
  }

  return this.relateForGlob( filePath, oldPath, newPath );
}

//

function fileMapExtend( fileMap, filePath, value )
{

  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( fileMap === null || _.strIs( fileMap ) || _.mapIs( fileMap ) );

  if( value === undefined )
  value = true;
  if( _.boolLike( value ) )
  value = !!value;

  /* */

  if( fileMap === null )
  {
    fileMap = Object.create( null );
  }
  else if( _.strIs( fileMap ) )
  {
    let originalFilePath = fileMap;
    fileMap = Object.create( null );
    fileMap[ originalFilePath ] = value;
  }
  else if( _.mapIs( fileMap ) )
  {
    for( let f in fileMap )
    {
      let val = fileMap[ f ];
      if( ( val === true && value !== false && value !== null ) || ( val === null ) )
      fileMap[ f ] = value;
    }
  }

  /* */

  if( filePath === null )
  return fileMap;

  if( _.strIs( filePath ) )
  {
    filePath = this.normalize( filePath );
    let element = fileMap[ filePath ];
    if( element === undefined || !value )
    fileMap[ filePath ] = value;
    else if( _.boolLike( element ) )
    fileMap[ filePath ] = value;
    else if( _.strIs( element ) )
    {
      if( _.arayIs( value ) )
      fileMap[ filePath ] = _.arrayAppend( value.slice(), element );
      else
      fileMap[ filePath ] = [ element, value ];
    }
    else if( _.arrayIs( element ) )
    {
      if( _.arayIs( value ) )
      fileMap[ filePath ] = _.arrayAppendArray( value.slice(), element );
      else
      fileMap[ filePath ].push( value );
    }
    else _.assert( 0 );
  }
  else if( _.mapIs( filePath ) )
  {
    for( let g in filePath )
    {
      let val = filePath[ g ];

      if( ( val === true && value !== false && value !== null ) || ( val === null ) )
      val = value;

      this.fileMapExtend( fileMap, g, val );
    }
  }
  else if( _.arrayLike( filePath ) )
  {
    for( let g = 0 ; g < filePath.length ; g++ )
    {
      this.fileMapExtend( fileMap, filePath[ g ], value );
    }
  }
  else _.assert( 0, 'Expects filePath' );

  /* */

  return fileMap;
}

//

function fileMapGroupByDst( filePath )
{
  let path = this;
  let result = Object.create( null );

  _.assert( arguments.length == 1 );
  _.assert( _.mapIs( filePath ) );

  /* */

  for( let src in filePath )
  {
    let dst = filePath[ src ];
    if( dst === false )
    continue;

    if( _.strIs( dst ) )
    {
      dst = path.normalize( dst );
      result[ dst ] = result[ dst ] || Object.create( null );
      result[ dst ][ src ] = true;
    }
    else
    {
      if( dst === true )
      dst = [ '.' ];
      _.assert( _.arrayIs( dst ) );
      for( var d = 0 ; d < dst.length ; d++ )
      {
        let dstPath = path.normalize( dst[ d ] );
        result[ dstPath ] = result[ dstPath ] || Object.create( null );
        result[ dstPath ][ src ] = true;
      }
    }

  }

  /* */

  for( let src in filePath )
  {
    let dst = filePath[ src ];
    if( dst !== false )
    continue;
    for( var r in result )
    result[ r ][ src ] = false;
  }

  return result;
}

//

function fileMapToRegexps( o )
{
  let path = this;

  if( arguments[ 1 ] !== undefined )
  o = { filePath : arguments[ 0 ], basePath : arguments[ 1 ] }

  _.routineOptions( fileMapToRegexps, o );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.mapIs( o.basePath ) );
  _.assert( _.mapIs( o.filePath ) )

  /* unglob filePath */

  o.fileGlobToPathMap = Object.create( null );
  o.filePathToGlobMap = Object.create( null );
  for( let fileGlob in o.filePath )
  {
    _.assert( path.isAbsolute( fileGlob ) );
    _.assert( _.boolLike( o.filePath[ fileGlob ] ) );

    let filePath = this.fromGlob( fileGlob );

    o.fileGlobToPathMap[ fileGlob ] = filePath;
    o.filePathToGlobMap[ filePath ] = fileGlob;
  }

  /* unglob basePath */

  // debugger;
  o.unglobedBasePath = Object.create( null );
  for( let g in o.basePath )
  {
    _.assert( path.isAbsolute( g ) );
    _.assert( !path.isGlob( o.basePath[ g ] ) );

    let filePath;
    let fileGlob = g;
    let basePath = o.basePath[ fileGlob ];
    if( o.filePath[ fileGlob ] === undefined )
    {
      filePath = fileGlob;
      fileGlob = o.filePathToGlobMap[ filePath ];
      // basePath = o.basePath[ fileGlob ];
    }

    _.assert( o.filePath[ fileGlob ] !== undefined, () => 'No file path for file glob ' + g );

    if( !o.filePath[ fileGlob ] )
    continue;

    if( !filePath )
    filePath = this.fromGlob( fileGlob );

    _.assert( o.unglobedBasePath[ filePath ] === undefined || o.unglobedBasePath[ filePath ] === basePath );
    o.unglobedBasePath[ filePath ] = basePath;

  }

  /* group by path */

  // debugger;
  o.redundantMap = _.mapExtend( null, o.filePath );
  o.groupedMap = Object.create( null );
  for( let g in o.redundantMap )
  {
    let value = o.redundantMap[ g ];
    let globPath = o.fileGlobToPathMap[ g ];
    let group = { [ g ] : value };

    if( !value )
    continue;

    delete o.redundantMap[ g ];

    for( let g2 in o.redundantMap )
    {
      let value2 = o.redundantMap[ g2 ];
      let globPath2 = o.fileGlobToPathMap[ g2 ];
      let begin;

      _.assert( g !== g2 );
      // if( g === g2 )
      // continue;

      if( o.samePathOnly && value2 )
      {
        _.assert( globPath !== globPath2, 'not tested' );
        if( globPath === globPath2 )
        begin = globPath2;
      }
      else
      {
        if( path.begins( globPath, globPath2 ) )
        begin = globPath2;
        else if( path.begins( globPath2, globPath ) )
        begin = globPath;
      }

      if( !begin )
      continue;

      group[ g2 ] = value2;
    }

    let common = globPath;
    for( let g2 in group )
    {
      let value2 = o.redundantMap[ g2 ];
      if( !value2 )
      continue;
      let globPath2 = o.fileGlobToPathMap[ g2 ];
      if( globPath2.length < common.length )
      common = globPath2;
      if( value2 )
      delete o.redundantMap[ g2 ];
    }

    o.groupedMap[ common ] = group;

  }

  /* */

  // debugger;
  o.regexpMap = Object.create( null );
  for( let p in o.groupedMap )
  {
    let group = o.groupedMap[ p ];
    let basePath = o.unglobedBasePath[ p ];
    let r = o.regexpMap[ p ] = Object.create( null );
    r.actual = [];
    r.transient = [];
    r.notActual = [];

    _.assert( _.strDefined( basePath ), 'No base path for', p );

    for( let g in group )
    {
      let value = group[ g ];
      let regexps = this._globRegexpFor2( g, p, basePath );
      if( value )
      {
        r.actual.push( regexps.actual );
        r.transient.push( regexps.transient );
      }
      else
      {
        r.notActual.push( regexps.actual );
      }
    }

  }

  return o;
}

fileMapToRegexps.defaults =
{
  filePath : null,
  basePath : null,
  samePathOnly : 1,
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

  // glob

  _fromGlob,
  fromGlob : _.routineVectorize_functor( _fromGlob ),
  globNormalize,
  globSplit,

  globRegexpsForTerminalSimple,
  globRegexpsForTerminalOld,

  _globRegexpForTerminal,
  _globRegexpsForTerminal,
  globRegexpsForTerminal,

  _globRegexpForDirectory,
  _globRegexpsForDirectory,
  globRegexpsForDirectory,

  _globRegexpFor2,
  _globRegexpsFor2,
  globRegexpsFor2,

  globToRegexp,
  globsToRegexp : _.routineVectorize_functor( globToRegexp ),
  globFilter,
  globFilterVals,
  globFilterKeys,

  _globSplitsToRegexpSourceGroups,
  _globSplitToRegexpSource,
  _globRegexpSourceSplitsJoinForTerminal,
  _globRegexpSourceSplitsJoinForDirectory,

  relateForGlob,
  pathsRelateForGlob,

  fileMapExtend,
  fileMapGroupByDst,
  fileMapToRegexps,

}

_.mapSupplement( Self, Fields );
_.mapSupplement( Self, Routines );

Self.Init();

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

if( typeof module !== 'undefined' )
{

  require( '../l3/Path.s' );

}

})();
