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
 * @memberof wTools.module:Tools/base/Path
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

  if( !this.isGlob( o.selector ) )
  {
    result = _.filter( o.src, ( e, k ) =>
    {
      return o.onEvaluate( e, k, o.src ) === o.selector ? e : undefined;
    });
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

  let splits = globRegexpSourceSplits.map( ( split, s ) =>
  {
    if( s > 0 )
    if( split == '.*' )
    split = '(?:(?:^|/)' + split + ')?';
    else
    split = '(?:^|/)' + split;
    return split;
  });

  result = splits.join( '' );
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

  // let globToFilePath = self.fromGlob( glob );
  // let onlyGlob = self.relative( globToFilePath, glob );
  // if( _.strBegins( filePath, globToFilePath ) )
  // {
  //   x
  // }

  let glob0 = this.globNormalize( glob );
  let glob1 = this.join( filePath, glob0 );
  // let r1 = this.relativeUndoted( basePath, filePath ); // xxx
  // let r2 = this.relativeUndoted( filePath, glob1 );
  // let downGlob1 = this.dot( this.normalize( this.join( r1, r2 ) ) );
  let downGlob2 = self.relative( filePath, glob1 );

  // result.push( downGlob ); // yyy

  /* */

  // if( !_.strBegins( basePath, filePath ) || basePath === filePath ) // yyy
  // return result;

  let common = this.common( glob1, basePath );
  let glob2 = this.relative( common, glob1 );
  let basePathRelativeCommon = this.relative( common, basePath );

  if( basePathRelativeCommon === '.' )
  {

    result.push( ( glob2 === '' || glob2 === '.' ) ? '.' : './' + glob2 );

  }
  else
  {

    result.push( downGlob2 );

    let globSplits = this.globSplit( glob2 );
    let globRegexpSourceSplits = globSplits.map( ( e, i ) => self._globSplitToRegexpSource( e ) );

    // debugger; // yyy
    let globPath = self.fromGlob( glob );
    let globPathRelativeFilePath = self.relative( globPath, filePath );
    let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits ) + '$' );
    if( globSliced.test( basePathRelativeCommon ) )
    {
      _.arrayAppendOnce( result, '**' );
      return result
    }
    // debugger; // yyy

    let s = 0;
    // debugger;
    // while( s < globSplits.length - 1 )
    while( s < globSplits.length ) // yyy
    {
      let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits.slice( 0, s+1 ) ) + '$' );
      if( globSliced.test( basePathRelativeCommon ) )
      {
        // let splits = _.strHas( globSplits[ s ], '**' ) ? globSplits.slice( s ) : globSplits.slice( s+1 ); // yyy
        let splits = _.strHas( globSplits[ s ], '**' ) ? globSplits.slice( s+1 ) : globSplits.slice( s+1 );
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

// --
// path map
// --

/*
qqq : add support of hashes for pathMapExtend, extend tests
*/

function pathMapExtend( dstPathMap, srcPathMap, dstPath )
{

  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( dstPathMap === null || _.strIs( dstPathMap ) || _.mapIs( dstPathMap ) );
  _.assert( !_.mapIs( dstPath ) );

  // if( dstPath === undefined )
  // dstPath = true;

  if( dstPath === undefined )
  dstPath = null;
  if( _.boolLike( dstPath ) )
  dstPath = !!dstPath;

  /* adjust dstPathMap */

  if( dstPathMap === null )
  {
    dstPathMap = Object.create( null );
  }
  else if( _.strIs( dstPathMap ) )
  {
    let originalDstPath = dstPathMap;
    dstPathMap = Object.create( null );
    dstPathMap[ originalDstPath ] = dstPath;
  }
  else if( _.mapIs( dstPathMap ) )
  {
    if( srcPathMap === null )
    for( let f in dstPathMap )
    {
      let val = dstPathMap[ f ];
      // if( ( val === true && dstPath !== false && dstPath !== null ) || ( val === null ) )
      if( val === null )
      dstPathMap[ f ] = dstPath;
    }
  }

  if( srcPathMap === null )
  return dstPathMap;

  /* extend dstPathMap by srcPathMap */

  if( _.strIs( srcPathMap ) )
  {
    srcPathMap = this.normalize( srcPathMap );
    let element = dstPathMap[ srcPathMap ];
    if( element === undefined || element === null || !dstPath )
    {
      dstPathMap[ srcPathMap ] = dstPath;
    }
    else if( _.boolLike( element ) )
    {
      dstPathMap[ srcPathMap ] = dstPath;
    }
    else if( _.strIs( element ) )
    {
      debugger;
      // if( dstPath === true || dstPath === 1 )
      // {}
      // else
      dstPathMap[ srcPathMap ] = _.arrayAppendArraysOnce( [], [ element, dstPath ] );
    }
    else if( _.arrayIs( element ) )
    {
      debugger;
      // if( dstPath === true || dstPath === 1 )
      // {}
      // else
      dstPathMap[ srcPathMap ] = _.arrayAppendArraysOnce( [], [ element, dstPath ] );
    }
    else
    {
      debugger;
      // if( dstPath === true || dstPath === 1 )
      // {}
      // else
      dstPathMap[ srcPathMap ] = _.arrayAppendArraysOnce( [], [ element, dstPath ] );
    }
    if( _.arrayIs( dstPathMap[ srcPathMap ] ) && dstPathMap[ srcPathMap ].length === 1 )
    dstPathMap[ srcPathMap ] = dstPathMap[ srcPathMap ][ 0 ];
  }
  else if( _.mapIs( srcPathMap ) )
  {
    for( let g in srcPathMap )
    {
      let val = srcPathMap[ g ];

      if( ( val === null ) )
      val = dstPath;

      // if( val === true && !_.boolLike( dstPath ) && dstPath !== null )
      // // if( dstPathMap[ g ] === undefined || dstPathMap[ g ] === null )
      // val = dstPath;

      this.pathMapExtend( dstPathMap, g, val );
    }
  }
  else if( _.arrayLike( srcPathMap ) )
  {
    for( let g = 0 ; g < srcPathMap.length ; g++ )
    {
      this.pathMapExtend( dstPathMap, srcPathMap[ g ], dstPath );
    }
  }
  else _.assert( 0, 'Expects srcPathMap' );

  /* */

  return dstPathMap;
}

//

function pathMapPairSrcAndDst( srcFilePath, dstFilePath )
{
  let path = this;

  _.assert( srcFilePath !== undefined );
  _.assert( dstFilePath !== undefined );
  _.assert( arguments.length === 2 );

  if( srcFilePath && dstFilePath )
  {

    srcVerify();
    dstVerify();

    if( _.mapIs( dstFilePath ) )
    srcFilePath = dstFilePath = path.pathMapExtend( null, _.mapExtend( null, srcFilePath, dstFilePath ), null );
    else
    srcFilePath = dstFilePath = path.pathMapExtend( null, srcFilePath, dstFilePath );

  }
  else if( srcFilePath )
  {
    srcFilePath = dstFilePath = path.pathMapExtend( null, srcFilePath, null );
  }
  else if( dstFilePath )
  {
    if( _.mapIs( dstFilePath ) )
    srcFilePath = dstFilePath = path.pathMapExtend( null, dstFilePath, null );
    else
    srcFilePath = dstFilePath = path.pathMapExtend( null, '', dstFilePath );
  }

  return srcFilePath;

  /* */

  function srcVerify()
  {
    if( dstFilePath && srcFilePath && Config.debug )
    {
      let srcPath1 = path.pathMapSrcFromSrc( srcFilePath );
      let srcPath2 = path.pathMapSrcFromDst( dstFilePath );
      _.assert( srcPath1.length === 0 || srcPath2.length === 0 || _.arraySetIdentical( srcPath1, srcPath2 ), () => 'Source paths are inconsistent ' + _.toStr( srcPath1 ) + ' ' + _.toStr( srcPath2 ) );
    }
  }

  /* */

  function dstVerify()
  {
    if( dstFilePath && srcFilePath && Config.debug )
    {
      let dstPath1 = path.pathMapDstFromSrc( srcFilePath ).filter( ( e ) => !_.boolLike( e ) && e !== null );
      let dstPath2 = path.pathMapDstFromDst( dstFilePath ).filter( ( e ) => !_.boolLike( e ) && e !== null );
      _.assert( dstPath1.length === 0 || dstPath2.length === 0 || _.arraySetIdentical( dstPath1, dstPath2 ), () => 'Destination paths are inconsistent ' + _.toStr( dstPath1 ) + ' ' + _.toStr( dstPath2 ) );
    }
  }

}

//

/*
qqq : make pathMap*From* optimal and add tests
*/

function pathMapDstFromSrc( pathMap )
{
  _.assert( arguments.length === 1 );

  if( !_.mapIs( pathMap ) )
  return [];

  let result = _.mapVals( pathMap );

  result = _.filter( result, ( e ) =>
  {
    if( _.arrayIs( e ) )
    return _.unrollFrom( e );
    return e;
  });

  result = _.arrayAppendArrayOnce( null, result );

  return result;
}

//

function pathMapDstFromDst( pathMap )
{
  _.assert( arguments.length === 1 );

  if( !_.mapIs( pathMap ) )
  return _.arrayAs( pathMap );

  let result = _.mapVals( pathMap );

  result = _.filter( result, ( e ) =>
  {
    if( _.arrayIs( e ) )
    return _.unrollFrom( e );
    return e;
  });

  result = _.arrayAppendArrayOnce( null, result );

  return result;
}

//

function pathMapSrcFromSrc( pathMap )
{
  _.assert( arguments.length === 1 );

  if( !_.mapIs( pathMap ) )
  return _.arrayAs( pathMap );

  pathMap = this.pathMapExtend( null, pathMap );

  return _.mapKeys( pathMap )
}

//

function pathMapSrcFromDst( pathMap )
{
  _.assert( arguments.length === 1 );

  if( !_.mapIs( pathMap ) )
  return [];

  return _.mapKeys( pathMap )
}

//

function pathMapGroupByDst( pathMap )
{
  let path = this;
  let result = Object.create( null );

  _.assert( arguments.length == 1 );
  _.assert( _.mapIs( pathMap ) );

  /* */

  for( let src in pathMap )
  {
    let normalizedSrc = path.fromGlob( src );
    let dst = pathMap[ src ];

    if( _.boolLike( dst ) )
    continue;

    // if( _.boolLike( dst ) && !dst )
    // continue;

    if( _.strIs( dst ) )
    {
      extend( dst, src );
    }
    // else if( _.boolLike( dst )
    // {
    //   if( !dst )
    //   continue;
    //   x
    // }
    else
    {
      // if( _.boolLike( dst ) && dst )
      // dst = [ '.' ];
      _.assert( _.arrayIs( dst ) );
      for( var d = 0 ; d < dst.length ; d++ )
      extend( dst[ d ], src );
      // {
      //   let dstPath = path.normalize( dst[ d ] );
      //   result[ dstPath ] = result[ dstPath ] || Object.create( null );
      //   result[ dstPath ][ src ] = true;
      // }
    }

  }

  /* */

  // debugger;
  for( let src in pathMap )
  {
    let dst = pathMap[ src ];

    if( !_.boolLike( dst ) )
    continue;

    // if( !_.boolLike( dst ) || dst )
    // continue;

    for( var dst2 in result )
    {

      for( var src2 in result[ dst2 ]  )
      {
        if( true ^ path.isRelative( src ) ^ path.isRelative( src2 ) )
        {
          if( path.begins( src2, path.fromGlob( src ) ) )
          result[ dst2 ][ src ] = !!dst;
        }
        else
        {
          result[ dst2 ][ src ] = !!dst;
        }
      }

    }

  }

  /* */

  // debugger;
  return result;

  /* */

  function extend( dst, src )
  {
    dst = path.normalize( dst );
    result[ dst ] = result[ dst ] || Object.create( null );
    result[ dst ][ src ] = null;
  }

}

//

function pathMapToRegexps( o )
{
  let path = this;

  if( arguments[ 1 ] !== undefined )
  o = { filePath : arguments[ 0 ], basePath : arguments[ 1 ] }

  _.routineOptions( pathMapToRegexps, o );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.mapIs( o.basePath ) );
  _.assert( _.mapIs( o.filePath ) )

  /* has only booleans */

  let hasOnlyBools = 1;
  for( let srcGlob in o.filePath )
  {
    let dstPath = o.filePath[ srcGlob ];
    if( !_.boolLike( dstPath ) )
    {
      hasOnlyBools = 0;
      break;
    }
  }

  if( hasOnlyBools )
  {
    for( let srcGlob in o.filePath )
    if( _.boolLike( o.filePath[ srcGlob ] ) && o.filePath[ srcGlob ] )
    o.filePath[ srcGlob ] = null;
  }

  /* unglob filePath */

  o.fileGlobToPathMap = Object.create( null );
  o.filePathToGlobMap = Object.create( null );
  o.unglobedFilePath = Object.create( null );
  for( let srcGlob in o.filePath )
  {
    let dstPath = o.filePath[ srcGlob ];
    _.assert( path.isAbsolute( srcGlob ), () => 'Expects absolute path, but ' + _.strQuote( srcGlob ) + ' is not' );

    let srcPath = path.fromGlob( srcGlob );

    o.fileGlobToPathMap[ srcGlob ] = srcPath;
    o.filePathToGlobMap[ srcPath ] = o.filePathToGlobMap[ srcPath ] || [];
    o.filePathToGlobMap[ srcPath ].push( srcGlob );
    let wasUnglobedFilePath = o.unglobedFilePath[ srcPath ];
    if( wasUnglobedFilePath === undefined || _.boolLike( wasUnglobedFilePath ) )
    if( !_.boolLike( dstPath ) || dstPath || wasUnglobedFilePath === undefined )
    {
      _.assert( wasUnglobedFilePath === undefined || _.boolLike( wasUnglobedFilePath ) || wasUnglobedFilePath === dstPath );
      o.unglobedFilePath[ srcPath ] = dstPath;
    }

    // if( !_.boolLike( dstPath ) )
    // hasOnlyBools = 0;

  }

  /* unglob basePath */

  o.unglobedBasePath = Object.create( null );
  for( let fileGlob in o.basePath )
  {
    _.assert( path.isAbsolute( fileGlob ) );
    _.assert( !path.isGlob( o.basePath[ fileGlob ] ) );

    let filePath;
    let basePath = o.basePath[ fileGlob ];
    if( o.filePath[ fileGlob ] === undefined )
    {
      filePath = fileGlob;
      fileGlob = o.filePathToGlobMap[ filePath ];
    }

    if( _.arrayIs( filePath ) )
    filePath.forEach( ( filePath ) => unglobedBasePathAdd( fileGlob, filePath, basePath ) );
    else
    unglobedBasePathAdd( fileGlob, filePath, basePath )

    // _.assert( o.filePath[ fileGlob ] !== undefined, () => 'No file path for file glob ' + g );
    //
    // if( _.boolLike( o.filePath[ fileGlob ] ) )
    // continue;
    //
    // // if( _.boolLike( o.filePath[ fileGlob ] ) && !o.filePath[ fileGlob ] )
    // // continue;
    //
    // if( !filePath )
    // filePath = path.fromGlob( fileGlob );
    //
    // _.assert( o.unglobedBasePath[ filePath ] === undefined || o.unglobedBasePath[ filePath ] === basePath );
    // o.unglobedBasePath[ filePath ] = basePath;

  }

  /* */

  function unglobedBasePathAdd( fileGlob, filePath, basePath )
  {
    _.assert( _.strIs( fileGlob ) );
    _.assert( filePath === undefined || _.strIs( filePath ) );
    _.assert( _.strIs( basePath ) );
    _.assert( o.filePath[ fileGlob ] !== undefined, () => 'No file path for file glob ' + g );

    if( _.boolLike( o.filePath[ fileGlob ] ) )
    return;

    // if( _.boolLike( o.filePath[ fileGlob ] ) && !o.filePath[ fileGlob ] )
    // continue;

    if( !filePath )
    filePath = path.fromGlob( fileGlob );

    _.assert( o.unglobedBasePath[ filePath ] === undefined || o.unglobedBasePath[ filePath ] === basePath );
    o.unglobedBasePath[ filePath ] = basePath;
  }

  /* group by path */

  o.redundantMap = _.mapExtend( null, o.filePath );
  o.groupedMap = Object.create( null );
  // debugger;
  for( let fileGlob in o.redundantMap )
  {

    let value = o.redundantMap[ fileGlob ];
    let filePath = o.fileGlobToPathMap[ fileGlob ];
    let group = { [ fileGlob ] : value };

    if( _.boolLike( value ) )
    {
      // if( !value || !hasOnlyBools )
      continue;
    }

    delete o.redundantMap[ fileGlob ];

    for( let fileGlob2 in o.redundantMap )
    {
      let value2 = o.redundantMap[ fileGlob2 ];
      let filePath2 = o.fileGlobToPathMap[ fileGlob2 ];
      let begin;

      _.assert( fileGlob !== fileGlob2 );

      // if( !_.boolLike( value2 ) )
      // continue;

      // // if( o.samePathOnly && value2 )
      // if( o.samePathOnly && ( _.boolLike( value2 ) && value2 ) )
      // {
      //   debugger;
      //   if( filePath === filePath2 )
      //   begin = filePath2;
      // }
      // else
      // {
      //   if( path.begins( filePath, filePath2 ) )
      //   begin = filePath2;
      //   else if( path.begins( filePath2, filePath ) )
      //   begin = filePath;
      // }

      if( path.begins( filePath, filePath2 ) )
      begin = filePath2;
      else if( path.begins( filePath2, filePath ) )
      begin = filePath;

      /* skip if different group */
      if( !begin )
      continue;

      if( _.boolLike( o.redundantMap[ fileGlob2 ] ) )
      {
        group[ fileGlob2 ] = value2;
      }
      else
      {
        if( filePath === filePath2 )
        {
          group[ fileGlob2 ] = value2;
          delete o.redundantMap[ fileGlob2 ];
        }
      }

    }

    // let commonPath = filePath;
    // for( let fileGlob2 in group )
    // {
    //   let value2 = o.redundantMap[ fileGlob2 ];
    //   if( !value2 ) // yyy
    //   continue;
    //   let filePath2 = o.fileGlobToPathMap[ fileGlob2 ];
    //   if( filePath2.length < commonPath.length )
    //   commonPath = filePath2;
    //   if( value2 )
    //   delete o.redundantMap[ fileGlob2 ];
    // }

    let commonPath = filePath;
    for( let fileGlob2 in group )
    {
      let value2 = o.filePath[ fileGlob2 ];
      // if( _.boolLike( value2 ) && !value2 ) // yyy
      // continue;

      // if( _.boolLike( value2 ) && !value2 ) // yyy
      // continue;

      if( _.boolLike( value2 ) ) // yyy
      continue;

      let filePath2 = o.fileGlobToPathMap[ fileGlob2 ];
      if( filePath2.length < commonPath.length )
      commonPath = filePath2;

      // if( value2 )
      // delete o.redundantMap[ fileGlob2 ];
    }

    _.assert( o.groupedMap[ commonPath ] === undefined );
    o.groupedMap[ commonPath ] = group;

  }
  // debugger;

  /* */

  o.regexpMap = Object.create( null );
  for( let commonPath in o.groupedMap )
  {
    let group = o.groupedMap[ commonPath ];
    let basePath = o.unglobedBasePath[ commonPath ];
    let r = o.regexpMap[ commonPath ] = Object.create( null );
    r.actualAny = [];
    r.actualAll = [];
    r.transient = [];
    r.notActual = [];

    _.assert( _.strDefined( basePath ), 'No base path for', commonPath );

    for( let fileGlob in group )
    {
      let value = group[ fileGlob ];

      if( !path.isGlob( fileGlob ) ) // xxx
      fileGlob = path.join( fileGlob, '**' );

      let regexps = path._globRegexpFor2( fileGlob, commonPath, basePath );

      if( value || value === null )
      {
        if( _.boolLike( value ) )
        r.actualAll.push( regexps.actual );
        else
        r.actualAny.push( regexps.actual );
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

pathMapToRegexps.defaults =
{
  filePath : null,
  basePath : null,
  samePathOnly : 1,
}

//

function basePathEquivalent( basePath1, basePath2 )
{
  let path = this;

  let filePath1 = path.pathMapSrcFromDst( basePath1 );
  let filePath2 = path.pathMapSrcFromDst( basePath2 );

  basePath1 = path.pathMapDstFromDst( basePath1 );
  basePath2 = path.pathMapDstFromDst( basePath2 );

  if( filePath1.length > 0 && filePath2.length > 0 )
  if( !_.entityIdentical( basePath1, basePath2 ) )
  return false;

  if( !_.entityIdentical( basePath1, basePath2 ) )
  return false;

  return true;
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

  // path map

  pathMapExtend,
  pathMapPairSrcAndDst,

  pathMapDstFromSrc,
  pathMapDstFromDst,
  pathMapSrcFromSrc,
  pathMapSrcFromDst,
  pathMapGroupByDst,
  pathMapToRegexps,
  basePathEquivalent,

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
