( function _Glob_s_() {

'use strict';

/**
 * @file Glob.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );
  _.include( 'wPathFundamentals' );
  _.include( 'wStringsExtra' );

}

//

let _global = _global_;
let _ = _global_.wTools;
let Self = _.path = _.path || Object.create( null );

// --
// functor
// --

function _vectorize( routine, select )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  select = select || 1;
  return _.routineVectorize_functor
  ({
    routine : routine,
    vectorizingArray : 1,
    vectorizingMapVals : 0,
    vectorizingMapKeys : 1,
    select,
  });
}

// --
// simple transformer
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

  _.assert( _.strIs( glob ), () => 'Expects string {-glob-}, but got ' + _.strType( glob ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( glob === '' || glob === null )
  return glob;

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
  // result = this.detrail( result );

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

function _globSplit( glob )
{
  let self = this;

  _.assert( _.strIs( glob ), 'Expects string {-glob-}' );

  let splits = self.split( glob );

  for( let s = splits.length-1 ; s >= 0 ; s-- )
  {
    let split = splits[ s ];
    if( split === '**' || !_.strHas( split, '**' ) )
    continue;

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

    _.arrayCutin( splits, [ s, s+1 ], split );

  }

  return splits;
}

//

function _certainlySplitsFromActual( splits )
{
  let self = this;

  _.assert( _.arrayIs( splits ) );

  splits = splits.slice();

  let i = splits.length - 1;
  while( i >= 0 )
  {
    let split = splits[ i ];
    if( split !== '**' && split !== '*' )
    break;
    i -= 1;
  }

  return splits.slice( 0, i+1 );
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
    debugger;
    throw _.err( 'Globs with curly brackets are not supported' );
  }

  /* */

  function handleSquareBrackets( src, it )
  {
    let inside = it.groups[ 0 ];
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

    let inside = it.groups[ 1 ].split( '|' );
    let multiplicator = it.groups[ 0 ];

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

  /* */

  function adjustGlobStr( src )
  {
    let result = src;

    result = _.strReplaceAll( result, transformation1 );
    result = _.strReplaceAll( result, transformation2 );

    return result;
  }

}

// --
// short filter
// --

function globSplitToRegexp( glob )
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
    let regexp = this.globsShortToRegexps( o.selector );
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

// --
// full filter
// --

function _globRegexpSourceSplitsConcatWithSlashes( globRegexpSourceSplits )
{
  let result = '';

  /*
    asterisk and double-asterisk are optional elements of pattern
    so them could be missing
  */

  let splits = globRegexpSourceSplits.map( ( split, s ) =>
  {
    if( s > 0 )
    if( split === '.*' )
    split = '(?:(?:^|/)' + split + ')?';
    else if( split === '[^\/]*' )
    split = '(?:(?:^|/)' + split + ')?';
    else
    split = '(?:^|/)' + split;
    return split;
  });

  return splits;
}

//

function _globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits )
{
  let self = this;
  let splits = self._globRegexpSourceSplitsConcatWithSlashes( globRegexpSourceSplits );
  let result = splits.join( '' );
  return result;
}

//

function _globRegexpSourceSplitsJoinForDirectory( globRegexpSourceSplits )
{
  let self = this;
  let splits = self._globRegexpSourceSplitsConcatWithSlashes( globRegexpSourceSplits );
  let result = _.regexpsAtLeastFirst( splits ).source;
  return result;
}

//

function _relateForGlob( glob, filePath, basePath )
{
  let self = this;
  let result = [];

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.strIs( glob ), 'Expects string {-glob-}' );
  _.assert( _.strIs( filePath ), 'Expects string' );
  _.assert( _.strIs( basePath ) );
  _.assert( !self.isRelative( glob ) ^ self.isRelative( filePath ), 'Expects both relative path either absolute' );

  let glob0 = this.globNormalize( glob );
  let glob1 = this.join( filePath, glob0 );
  let common = this.common( glob1, basePath );
  let glob2 = this.relative( common, glob1 );
  let basePathRelativeCommon = this.relative( common, basePath );

  if( basePathRelativeCommon === '.' )
  {

    result.push( ( glob2 === '' || glob2 === '.' ) ? '.' : './' + glob2 );

  }
  else
  {

    debugger;
    let downGlob2 = self.relative( filePath, glob1 );
    result.push( downGlob2 );

    let globSplits = this._globSplit( glob2 );
    let globRegexpSourceSplits = globSplits.map( ( e, i ) => self._globSplitToRegexpSource( e ) );

    let globPath = self.fromGlob( glob );
    let globPathRelativeFilePath = self.relative( globPath, filePath );
    let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits ) + '$' );
    if( globSliced.test( basePathRelativeCommon ) )
    {
      _.arrayAppendOnce( result, '**' );
      return result;
    }

    let s = 0;
    while( s < globSplits.length )
    {
      let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits.slice( 0, s+1 ) ) + '$' );
      if( globSliced.test( basePathRelativeCommon ) )
      {
        let splits = _.strHas( globSplits[ s ], '**' ) ? globSplits.slice( s+1 ) : globSplits.slice( s+1 );
        let glob3 = splits.join( '/' );
        result.push( glob3 === '' ? '.' : './' + glob3  );
      }
      s += 1;
    }

  }

  return result;
}

//

function _globFullToRegexpSingle( glob, filePath, basePath )
{
  let self = this;

  _.assert( _.strIs( glob ), 'Expects string {-glob-}' );
  _.assert( _.strIs( filePath ) && !_.path.isGlob( filePath ) );
  _.assert( _.strIs( basePath ) && !_.path.isGlob( basePath ) );
  _.assert( arguments.length === 3 );

  glob = self.join( filePath, glob );

  let related = self._relateForGlob( glob, filePath, basePath );
  let maybeHere = '';
  let hereEscapedStr = self._globSplitToRegexpSource( self._hereStr );
  let downEscapedStr = self._globSplitToRegexpSource( self._downStr );

  let cache = Object.create( null );
  let result = Object.create( null );
  result.transient = [];
  result.actual = [];
  result.certainly = [];

  for( let r = 0 ; r < related.length ; r++ )
  {

    let actualSplits = self.split( related[ r ] );
    let transientSplits = self._globSplit( related[ r ] );
    let certainlySplits = self._certainlySplitsFromActual( actualSplits );
    if( certainlySplits.length === actualSplits.length )
    certainlySplits = [];

    actualSplits = actualSplits.map( ( e, i ) => toRegexp( e ) );
    transientSplits = transientSplits.map( ( e, i ) => toRegexp( e ) );
    certainlySplits = certainlySplits.map( ( e, i ) => toRegexp( e ) );

    result.actual.push( self._globRegexpSourceSplitsJoinForTerminal( actualSplits ) );
    result.transient.push( self._globRegexpSourceSplitsJoinForDirectory( transientSplits ) );
    if( certainlySplits.length )
    result.certainly.push( self._globRegexpSourceSplitsJoinForTerminal( certainlySplits ) );

  }

  result.transient = '(?:(?:' + result.transient.join( ')|(?:' ) + '))';
  result.transient = _.regexpsJoin([ '^', result.transient, '$' ]);

  result.actual = '(?:(?:' + result.actual.join( ')|(?:' ) + '))';
  result.actual = _.regexpsJoin([ '^', result.actual, '$' ]);

  if( result.certainly.length )
  {
    result.certainly = '(?:(?:' + result.certainly.join( ')|(?:' ) + '))';
    result.certainly = _.regexpsJoin([ '^', result.certainly, '$' ]);
  }
  else
  {
    result.certainly = null;
  }

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

// debugger;
// let _globsFullToRegexps = _.routineVectorize_functor
// // let _globsFullToRegexps = _.path.s._vectorize
// ({
//   routine : _globFullToRegexpSingle,
//   select : 3,
// });

//

function globsFullToRegexps()
{
  let r = this._globsFullToRegexps.apply( this, arguments );
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

    if( dstPath === null )
    dstPath = '';

    _.assert( path.isAbsolute( srcGlob ), () => 'Expects absolute path, but ' + _.strQuote( srcGlob ) + ' is not' );

    let srcPath = path.fromGlob( srcGlob );

    o.fileGlobToPathMap[ srcGlob ] = srcPath;
    o.filePathToGlobMap[ srcPath ] = o.filePathToGlobMap[ srcPath ] || [];
    o.filePathToGlobMap[ srcPath ].push( srcGlob );
    let wasUnglobedFilePath = o.unglobedFilePath[ srcPath ];
    if( wasUnglobedFilePath === undefined || _.boolLike( wasUnglobedFilePath ) )
    // if( !_.boolLike( dstPath ) || dstPath || wasUnglobedFilePath === undefined ) // yyy
    if( !_.boolLike( dstPath ) )
    {
      _.assert( wasUnglobedFilePath === undefined || _.boolLike( wasUnglobedFilePath ) || wasUnglobedFilePath === dstPath );
      o.unglobedFilePath[ srcPath ] = dstPath;
    }

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

  }

  /* group by path */

  o.redundantMap = _.mapExtend( null, o.filePath );
  o.groupedMap = Object.create( null );
  for( let fileGlob in o.redundantMap )
  {

    let value = o.redundantMap[ fileGlob ];
    let filePath = o.fileGlobToPathMap[ fileGlob ];
    let group = { [ fileGlob ] : value };

    if( _.boolLike( value ) )
    {
      continue;
    }

    delete o.redundantMap[ fileGlob ];

    for( let fileGlob2 in o.redundantMap )
    {
      let value2 = o.redundantMap[ fileGlob2 ];
      let filePath2 = o.fileGlobToPathMap[ fileGlob2 ];
      let begin;

      _.assert( fileGlob !== fileGlob2 );

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

    let commonPath = filePath;
    for( let fileGlob2 in group )
    {
      let value2 = o.filePath[ fileGlob2 ];

      if( _.boolLike( value2 ) )
      continue;

      let filePath2 = o.fileGlobToPathMap[ fileGlob2 ];
      if( filePath2.length < commonPath.length )
      commonPath = filePath2;

    }

    _.assert( o.groupedMap[ commonPath ] === undefined );
    o.groupedMap[ commonPath ] = group;

  }

  /* */

  o.regexpMap = Object.create( null );
  for( let commonPath in o.groupedMap )
  {
    let group = o.groupedMap[ commonPath ];
    let basePath = o.unglobedBasePath[ commonPath ];
    let r = o.regexpMap[ commonPath ] = Object.create( null );
    r.certainlyHash = new Map;
    r.transient = [];
    r.actualAny = [];
    r.actualAll = [];
    r.actualNone = [];

    _.assert( _.strDefined( basePath ), 'No base path for', commonPath );

    for( let fileGlob in group )
    {
      let value = group[ fileGlob ];

      if( !path.isGlob( fileGlob ) )
      fileGlob = path.join( fileGlob, '**' );

      // debugger;
      let regexps = path._globFullToRegexpSingle( fileGlob, commonPath, basePath );
      // debugger;

      if( regexps.certainly )
      r.certainlyHash.set( regexps.actual, regexps.certainly )

      if( value || value === null || value === '' )
      {
        if( _.boolLike( value ) )
        {
          r.actualAll.push( regexps.actual );
        }
        else
        {
          r.actualAny.push( regexps.actual );
        }
        r.transient.push( regexps.transient )
      }
      else
      {
        r.actualNone.push( regexps.actual );
      }

    }

  }

  return o;

  /* */

  function unglobedBasePathAdd( fileGlob, filePath, basePath )
  {
    _.assert( _.strIs( fileGlob ) );
    _.assert( filePath === undefined || _.strIs( filePath ) );
    _.assert( _.strIs( basePath ) );
    _.assert( o.filePath[ fileGlob ] !== undefined, () => 'No file path for file glob ' + g );

    if( _.boolLike( o.filePath[ fileGlob ] ) )
    return;

    if( !filePath )
    filePath = path.fromGlob( fileGlob );

    _.assert
    (
      o.unglobedBasePath[ filePath ] === undefined || o.unglobedBasePath[ filePath ] === basePath,
      () => 'The same file path ' + _.strQuote( filePath ) + ' has several different base paths:' +
      '\n - ' + _.strQuote( o.unglobedBasePath[ filePath ] ),
      '\n - ' + _.strQuote( basePath )
    );
    o.unglobedBasePath[ filePath ] = basePath;
  }

}

pathMapToRegexps.defaults =
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

  // simple transformer

  _fromGlob,
  // fromGlob : _.routineVectorize_functor( _fromGlob ),
  fromGlob : _vectorize( _fromGlob ),
  globNormalize,
  _globSplit,
  _certainlySplitsFromActual,
  _globSplitToRegexpSource,

  // short filter

  globSplitToRegexp,
  // globsShortToRegexps : _.routineVectorize_functor( globSplitToRegexp ),
  globsShortToRegexps : _vectorize( globSplitToRegexp ),
  globFilter,
  globFilterVals,
  globFilterKeys,

  // full filter

  _globRegexpSourceSplitsConcatWithSlashes,
  _globRegexpSourceSplitsJoinForTerminal,
  _globRegexpSourceSplitsJoinForDirectory,
  _relateForGlob,
  _globFullToRegexpSingle,

  _globsFullToRegexps : _vectorize( _globFullToRegexpSingle, 3 ),

  globsFullToRegexps,
  pathMapToRegexps,

}

_.mapSupplement( Self, Fields );
_.mapSupplement( Self, Routines );

// Self.Init();

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

// if( typeof module !== 'undefined' )
// {
//   require( '../l3/PathBasic.s' );
// }

})();
