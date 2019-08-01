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

    let downGlob2 = self.relative( filePath, glob1 );
    result.push( downGlob2 );

    let globSplits = this.globSplit( glob2 );
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

  glob = this.join( filePath, glob );

  let related = this._relateForGlob( glob, filePath, basePath );
  let maybeHere = '';
  let hereEscapedStr = self._globSplitToRegexpSource( self._hereStr );
  let downEscapedStr = self._globSplitToRegexpSource( self._downStr );

  let cache = Object.create( null );
  let result = Object.create( null );
  result.transient = [];
  result.actual = [];

  for( let r = 0 ; r < related.length ; r++ )
  {

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

let _globsFullToRegexps = _.routineVectorize_functor
({
  routine : _globFullToRegexpSingle,
  select : 3,
});

//

function globsFullToRegexps()
{
  let r = _globsFullToRegexps.apply( this, arguments );
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
    r.actualAny = [];
    r.actualAll = [];
    r.transient = [];
    r.notActual = [];

    _.assert( _.strDefined( basePath ), 'No base path for', commonPath );

    for( let fileGlob in group )
    {
      let value = group[ fileGlob ];

      if( !path.isGlob( fileGlob ) )
      fileGlob = path.join( fileGlob, '**' );

      // debugger;
      let regexps = path._globFullToRegexpSingle( fileGlob, commonPath, basePath );
      // debugger;

      if( value || value === null || value === '' )
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
// path map
// --

//
//
// function pathMapIterate( o )
// {
//
//   if( arguments[ 1 ] !== undefined )
//   o = { filePath : arguments[ 0 ], onEach : arguments[ 1 ] }
//
//   _.routineOptions( pathMapIterate,o );
//   _.assert( arguments.length === 1 );
//   _.assert( o.filePath === null || _.strIs( o.filePath ) || _.arrayIs( o.filePath ) || _.mapIs( o.filePath ) );
//
//   let it = o.iteration = o.iteration || Object.create( null );
//   it.options = it.options;
//   it.value = o.filePath;
//   it.side = null;
//   it.continue = true;
//   it.result = true;
//   Object.preventExtensions( it );
//
//   if( o.filePath === null || _.strIs( o.filePath ) )
//   {
//     let r = o.onEach( it );
//     _.assert( r === undefined );
//     _.assert( it.value === null || _.strIs( it.value ) || _.boolLike( it.value ) || _.arrayIs( it.value ) );
//   }
//   else if( _.arrayIs( o.filePath ) )
//   {
//     for( let p = 0 ; p < o.filePath.length ; p++ )
//     {
//       it.value = o.filePath[ p ];
//       let r = o.onEach( it );
//       _.assert( r === undefined );
//       _.assert( _.strIs( it.value ) || _.boolLike( it.value ) );
//       if( o.writing )
//       o.filePath[ p ] = it.value;
//     }
//     it.value = o.filePath;
//   }
//   else if( _.mapIs( o.filePath ) )
//   for( let src in o.filePath )
//   {
//     let dst = o.filePath[ src ];
//
//     it.side = 'destination';
//     it.value = dst;
//     let r = o.onEach( it );
//     _.assert( r === undefined );
//
//     if( o.writing )
//     if( it.value !== dst )
//     {
//       o.filePath[ src ] = it.value;
//       dst = it.value;
//     }
//
//     it.side = 'source';
//     it.value = src;
//     r = o.onEach( it );
//     _.assert( r === undefined );
//     _.assert( _.strIs( it.value ) || _.arrayIs( it.value ) );
//
//     if( o.writing )
//     if( it.value !== src )
//     delete o.filePath[ src ];
//     if( _.arrayIs( it.value ) )
//     for( let i = 0 ; i < it.value.length ; i++ )
//     o.filePath[ it.value[ i ] ] = dst;
//     else
//     o.filePath[ it.value ] = dst;
//
//     it.value = o.filePath;
//   }
//   else _.assert( 0 );
//
//   return it.result;
// }
//
// pathMapIterate.defaults =
// {
//   iteration : null,
//   filePath : null,
//   onEach : null,
//   writing : 1,
// }

//

function filterInplace( filePath, onEach )
{

  _.assert( arguments.length === 2 );
  _.assert( filePath === null || _.strIs( filePath ) || _.arrayIs( filePath ) || _.mapIs( filePath ) );
  _.routineIs( onEach );

  let it = Object.create( null );

  if( filePath === null || _.strIs( filePath ) )
  {
    it.value = filePath;
    let r = onEach( it.value, it );
    if( r === undefined )
    return null;
    return r;
  }
  else if( _.arrayIs( filePath ) )
  {
    for( let p = 0 ; p < filePath.length ; p++ )
    {
      it.index = p;
      it.value = filePath[ p ];
      let r = onEach( it.value, it );
      if( r === undefined )
      {
        filePath.splice( p, 1 );
        p -= 1;
      }
      else
      {
        filePath[ p ] = r;
      }
    }
    return filePath;
  }
  else if( _.mapIs( filePath ) )
  {
    for( let src in filePath )
    {
      let dst = filePath[ src ];

      delete filePath[ src ];

      if( _.arrayIs( dst ) )
      {
        dst = dst.slice();
        for( let d = 0 ; d < dst.length ; d++ )
        {
          it.src = src;
          it.dst = dst[ d ];
          it.value = it.src;
          it.side = 'src';
          let srcResult = onEach( it.value, it );
          it.value = it.dst;
          it.side = 'dst';
          let dstResult = onEach( it.value, it );
          write( filePath, srcResult, dstResult );
        }
      }
      else
      {
        it.src = src;
        it.dst = dst;
        it.value = it.src;
        it.side = 'src';
        let srcResult = onEach( it.value, it );
        it.side = 'dst';
        it.value = it.dst;
        let dstResult = onEach( it.value, it );
        write( filePath, srcResult, dstResult );
      }

    }

    return filePath;
  }
  else _.assert( 0 );

  /* */

  function write( pathMap, src, dst )
  {

    _.assert( src === undefined || _.strIs( src ) || _.arrayIs( src ) );

    if( dst !== undefined )
    {
      if( _.arrayIs( src ) )
      {
        for( let s = 0 ; s < src.length ; s++ )
        if( src[ s ] !== undefined )
        pathMap[ src[ s ] ] = _.scalarAppend( pathMap[ src[ s ] ], dst );
      }
      else if( src !== undefined )
      {
        pathMap[ src ] = _.scalarAppend( pathMap[ src ], dst );
      }
    }

  }

}

//

function filter( filePath, onEach )
{

  _.assert( arguments.length === 2 );
  _.assert( filePath === null || _.strIs( filePath ) || _.arrayIs( filePath ) || _.mapIs( filePath ) );
  _.routineIs( onEach );

  let it = Object.create( null );

  if( filePath === null || _.strIs( filePath ) )
  {
    it.value = filePath;
    let r = onEach( it.value, it );
    if( r === undefined )
    return null;
    return r;
  }
  else if( _.arrayIs( filePath ) )
  {
    let result = [];
    for( let p = 0 ; p < filePath.length ; p++ )
    {
      it.index = p;
      it.value = filePath[ p ];
      let r = onEach( it.value, it );
      if( r !== undefined )
      result.push( r );
    }
    return result;
  }
  else if( _.mapIs( filePath ) )
  {
    let result = Object.create( null );
    for( let src in filePath )
    {
      let dst = filePath[ src ];

      if( _.arrayIs( dst ) )
      {
        dst = dst.slice();
        for( let d = 0 ; d < dst.length ; d++ )
        {
          it.src = src;
          it.dst = dst[ d ];
          it.value = it.src;
          it.side = 'src';
          let srcResult = onEach( it.value, it );
          it.value = it.dst;
          it.side = 'dst';
          let dstResult = onEach( it.value, it );
          write( result, srcResult, dstResult );
        }
      }
      else
      {
        it.src = src;
        it.dst = dst;
        it.value = it.src;
        it.side = 'src';
        let srcResult = onEach( it.value, it );
        it.value = it.dst;
        it.side = 'dst';
        let dstResult = onEach( it.value, it );
        write( result, srcResult, dstResult );
      }

    }

    return result;
  }
  else _.assert( 0 );

  /* */

  function write( pathMap, src, dst )
  {

    _.assert( src === undefined || _.strIs( src ) || _.arrayIs( src ) );

    if( dst !== undefined )
    {
      if( _.arrayIs( src ) )
      {
        for( let s = 0 ; s < src.length ; s++ )
        if( src[ s ] !== undefined )
        pathMap[ src[ s ] ] = _.scalarAppend( pathMap[ src[ s ] ], dst );
      }
      else if( src !== undefined )
      {
        pathMap[ src ] = _.scalarAppend( pathMap[ src ], dst );
      }
    }

  }

}

//

function all( filePath, onEach )
{

  _.assert( arguments.length === 2 );
  _.assert( filePath === null || _.strIs( filePath ) || _.arrayIs( filePath ) || _.mapIs( filePath ) );
  _.routineIs( onEach );

  let it = Object.create( null );

  if( filePath === null || _.strIs( filePath ) )
  {
    it.value = filePath;
    let r = onEach( it.value, it );
    if( !r )
    return false;
    return true;
  }
  else if( _.arrayIs( filePath ) )
  {
    for( let p = 0 ; p < filePath.length ; p++ )
    {
      it.index = p;
      it.value = filePath[ p ];
      let r = onEach( it.value, it );
      if( !r )
      return false;
    }
    return true;
  }
  else if( _.mapIs( filePath ) )
  {
    for( let src in filePath )
    {
      let dst = filePath[ src ];

      if( _.arrayIs( dst ) )
      {
        dst = dst.slice();
        for( let d = 0 ; d < dst.length ; d++ )
        {
          it.src = src;
          it.dst = dst[ d ];
          it.value = it.src;
          it.side = 'src';
          var r = onEach( it.value, it );
          if( !r )
          return false;
          it.value = it.dst;
          it.side = 'dst';
          var r = onEach( it.value, it );
          if( !r )
          return false;
        }
      }
      else
      {
        it.src = src;
        it.dst = dst;
        it.value = it.src;
        it.side = 'src';
        var r = onEach( it.value, it );
        if( !r )
        return false;
        it.value = it.dst;
        it.side = 'dst';
        var r = onEach( it.value, it );
        if( !r )
        return false;
      }

    }
    return true;
  }
  else _.assert( 0 );

}

//

function any( filePath, onEach )
{

  _.assert( arguments.length === 2 );
  _.assert( filePath === null || _.strIs( filePath ) || _.arrayIs( filePath ) || _.mapIs( filePath ) );
  _.routineIs( onEach );

  let it = Object.create( null );

  if( filePath === null || _.strIs( filePath ) )
  {
    it.value = filePath;
    let r = onEach( it.value, it );
    if( r )
    return true;
    return false;
  }
  else if( _.arrayIs( filePath ) )
  {
    for( let p = 0 ; p < filePath.length ; p++ )
    {
      it.index = p;
      it.value = filePath[ p ];
      let r = onEach( it.value, it );
      if( r )
      return true;
    }
    return false;
  }
  else if( _.mapIs( filePath ) )
  {
    for( let src in filePath )
    {
      let dst = filePath[ src ];

      if( _.arrayIs( dst ) )
      {
        dst = dst.slice();
        for( let d = 0 ; d < dst.length ; d++ )
        {
          it.src = src;
          it.dst = dst[ d ];
          it.value = it.src;
          it.side = 'src';
          var r = onEach( it.value, it );
          if( r )
          return true;
          it.value = it.dst;
          it.side = 'dst';
          var r = onEach( it.value, it );
          if( r )
          return true;
        }
      }
      else
      {
        it.src = src;
        it.dst = dst;
        it.value = it.src;
        it.side = 'src';
        var r = onEach( it.value, it );
        if( r )
        return true;
        it.value = it.dst;
        it.side = 'dst';
        var r = onEach( it.value, it );
        if( r )
        return true;
      }

    }
    return false;
  }
  else _.assert( 0 );

}

//

function none( filePath, onEach )
{
  return !this.any.apply( this, arguments )
}

//

/*
qqq : implement good tests for routine isEmpty
*/

function isEmpty( src )
{
  let self = this;

  _.assert( arguments.length === 1 );
  _.assert( src === null || _.arrayIs( src ) || _.strIs( src ) || _.mapIs( src ) );

  if( src === null || src === '' )
  return true;

  if( _.strIs( src ) )
  return false;

  if( _.arrayIs( src ) )
  {
    if( src.length === 0 )
    return true;
    if( src.length === 1 )
    if( src[ 0 ] === null || src[ 0 ] === '' || src[ 0 ] === '.' ) // qqq zzz : refactor to remove dot case
    return true;
    return false;
  }

  if( _.mapKeys( src ).length === 1 )
  if( src[ '.' ] === null || src[ '.' ] === '' || src[ '' ] === null || src[ '' ] === '' ) // qqq zzz : refactor to remove dot
  return true;

  return false;
}

//

/*
qqq : add support of hashes for mapExtend, extend tests
*/

function mapExtend( dstPathMap, srcPathMap, dstPath )
{
  let self = this;

  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( dstPathMap === null || _.strIs( dstPathMap ) || _.arrayIs( dstPathMap ) || _.mapIs( dstPathMap ) );
  _.assert( !_.mapIs( dstPath ) );

  /* normalize dstPath */

  dstPath = dstPathNormalize( dstPath );

  /* normalize dstPathMap */

  dstPathMap = dstPathMapNormalize( dstPathMap );
  _.assert( _.mapIs( dstPathMap ) );

  /* normalize srcPathMap */

  /*
    if no source map then
    to avoid adding record . : null
    return
    if destination path is null and destination map has any record
  */

  // if( srcPathMap === null )
  // if( dstPath === null || _.mapKeys( dstPathMap ).length )
  // return dstPathMap;

  if( srcPathMap === null )
  if( dstPath === null )
  return dstPathMap;

  srcPathMap = srcPathMapNormalize( srcPathMap );

  /* extend dstPathMap by srcPathMap */

  dstPathMapExtend( dstPathMap, srcPathMap, dstPath );

  /* */

  return dstPathMap;

  /* */

  function dstPathNormalize( dstPath )
  {
    if( _.boolLike( dstPath ) )
    dstPath = !!dstPath;
    if( _.arrayIs( dstPath ) && dstPath.length === 1 )
    dstPath = dstPath[ 0 ];
    if( dstPath === undefined || dstPath === null )
    dstPath = '';
    return dstPath;
  }

  /* */

  function dstPathMapNormalize( dstPathMap )
  {

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
    else if( _.arrayIs( dstPathMap ) )
    {
      let originalDstPath = dstPathMap;
      dstPathMap = Object.create( null );
      originalDstPath.forEach( ( p ) => dstPathMap[ p ] = dstPath );
    }
    else if( _.mapIs( dstPathMap ) )
    {
      if( srcPathMap === null || srcPathMap === '' ) // yyy
      for( let f in dstPathMap )
      {
        let val = dstPathMap[ f ];
        if( val === null || val === '' ) // yyy
        dstPathMap[ f ] = dstPath;
      }
    }

    /* remove . : null if map was dot-map */
    if( srcPathMap )
    if( !_.mapIs( srcPathMap ) || ( _.mapIs( srcPathMap ) && _.mapKeys( srcPathMap ).length ) )
    if( _.mapKeys( dstPathMap ).length === 1 )
    {
      if( dstPathMap[ '.' ] === null || dstPathMap[ '.' ] === '' ) // xxx
      delete dstPathMap[ '.' ];
      else if( dstPathMap[ '' ] === '' || dstPathMap[ '' ] === null ) // xxx
      delete dstPathMap[ '' ];
    }

    /* get dstPath from dstPathMap if it has empty key */

    if( dstPathMap[ '' ] !== undefined )
    {
      if( dstPath === null || dstPath === '' )
      {
        dstPath = dstPathMap[ '' ];
        delete dstPathMap[ '' ];
      }
      else
      {
        // debugger; xxx
      }
    }

    return dstPathMap;
  }

  /* */

  function srcPathMapNormalize( srcPathMap )
  {
    if( srcPathMap === null )
    srcPathMap = '';
    return srcPathMap;
  }

  /* */

  function dstPathMapExtend( dstPathMap, srcPathMap, dstPath )
  {

    if( _.strIs( srcPathMap ) )
    {
      if( srcPathMap || _.mapKeys( dstPathMap ).length === 0 )
      {
        srcPathMap = self.normalize( srcPathMap );
        dstPathMap[ srcPathMap ] = dstJoin( dstPathMap[ srcPathMap ], dstPath );
      }
      else
      {
        for( let src in dstPathMap )
        {
          if( dstPathMap[ src ] === null || dstPathMap[ src ] === '' )
          dstPathMap[ src ] = dstPath;
        }
      }
    }
    else if( _.mapIs( srcPathMap ) )
    {
      for( let g in srcPathMap )
      {
        let val = srcPathMap[ g ];

        if( ( val === null ) || ( val === '' ) )
        val = dstPath;

        self.mapExtend( dstPathMap, g, val );
      }
    }
    else if( _.arrayLike( srcPathMap ) )
    {
      for( let g = 0 ; g < srcPathMap.length ; g++ )
      self.mapExtend( dstPathMap, srcPathMap[ g ], dstPath );
    }
    else _.assert( 0, 'Expects srcPathMap' );

  }

  /* */

  function dstJoin( dst, src )
  {
    let r;

    _.assert( dst === undefined || dst === null || _.arrayIs( dst ) || _.strIs( dst ) || _.boolLike( dst ) || _.objectIs( dst ) );
    _.assert( src === null || _.arrayIs( src ) || _.strIs( src ) || _.boolLike( src ) || _.objectIs( src ) );

    // if( src === null ) yyy
    if( src === null || src === '' )
    {
      r = dst || '';
    }
    else if( src === false )
    {
      r = src;
    }
    // else if( dst === undefined || dst === null || dst === true ) yyy
    else if( dst === undefined || dst === null || dst === '' || dst === true )
    {
      r = src;
    }
    else if( _.boolLike( dst ) )
    {
      r = src;
    }
    else if( _.strIs( dst ) || _.objectIs( dst ) )
    {
      r = _.arrayAppendArraysOnce( [], [ dst, src ] );
    }
    else if( _.arrayIs( dst ) )
    {
      r = _.arrayAppendArraysOnce( [], [ dst, src ] );
    }
    else _.assert( 0 );

    if( _.arrayIs( r ) )
    {
      if( r.length > 1 )
      r = r.filter( ( e ) => !_.boolLike( e ) );
      if( r.length === 1 )
      r = r[ 0 ];
    }

    return r;
  }

}

//

function mapsPair( dstFilePath, srcFilePath )
{
  let self = this;
  // let srcPath1;
  // let srcPath2;
  // let dstPath1;
  // let dstPath2;

  _.assert( srcFilePath !== undefined );
  _.assert( dstFilePath !== undefined );
  _.assert( arguments.length === 2 );

  if( srcFilePath && dstFilePath )
  {

    // srcPath1 = self.mapSrcFromSrc( srcFilePath );
    // srcPath2 = self.mapSrcFromDst( dstFilePath );
    // dstPath1 = self.mapDstFromSrc( srcFilePath );
    // dstPath2 = self.mapDstFromDst( dstFilePath );

    // srcPath1 = self.mapSrcFromSrc( srcFilePath ).filter( ( e ) => e !== null );
    // srcPath2 = self.mapSrcFromDst( dstFilePath ).filter( ( e ) => e !== null );
    // dstPath1 = self.mapDstFromSrc( srcFilePath ).filter( ( e ) => e !== null );
    // dstPath2 = self.mapDstFromDst( dstFilePath ).filter( ( e ) => e !== null );

    if( _.mapIs( srcFilePath ) && _.mapIs( dstFilePath ) )
    {
      mapsVerify();
    }
    else
    {
      srcVerify();
      // dstVerify();
    }

    if( _.mapIs( dstFilePath ) )
    {
      dstFilePath = self.mapExtend( null, dstFilePath, null );
      srcFilePath = dstFilePath = self.mapExtend( dstFilePath, srcFilePath, null );
    }
    else
    {
      srcFilePath = dstFilePath = self.mapExtend( null, srcFilePath, dstFilePath );
    }

  }
  else if( srcFilePath )
  {
    if( self.isEmpty( srcFilePath ) )
    srcFilePath = dstFilePath = null;
    else
    srcFilePath = dstFilePath = self.mapExtend( null, srcFilePath, null );
  }
  else if( dstFilePath )
  {
    if( self.isEmpty( dstFilePath ) )
    srcFilePath = dstFilePath = null;
    else if( _.mapIs( dstFilePath ) )
    srcFilePath = dstFilePath = self.mapExtend( null, dstFilePath, null );
    else
    srcFilePath = dstFilePath = self.mapExtend( null, '', dstFilePath ); // yyy
  }
  else
  {
    srcFilePath = dstFilePath = null;
    // srcFilePath = dstFilePath = Object.create( null );
    // srcFilePath[ '.' ] = null;
  }

  return srcFilePath;

  /* */

  function mapsVerify()
  {
    _.assert
    (
      _.mapsAreIdentical( srcFilePath, dstFilePath ),
      () => 'File maps are inconsistent\n' + _.toStr( srcFilePath ) + '\n' + _.toStr( dstFilePath )
    );
  }

  /* */

  function srcVerify()
  {
    if( dstFilePath && srcFilePath && Config.debug )
    {
      let srcPath1 = self.mapSrcFromSrc( srcFilePath ).filter( ( e ) => e !== null );
      let srcPath2 = self.mapSrcFromDst( dstFilePath ).filter( ( e ) => e !== null );
      let srcFilteredPath1 = srcPath1.filter( ( e ) => !_.boolLike( e ) && e !== null );
      let srcFilteredPath2 = srcPath2.filter( ( e ) => !_.boolLike( e ) && e !== null );
      _.assert
      (
        srcFilteredPath1.length === 0 || srcFilteredPath2.length === 0 ||
        self.isEmpty( srcFilteredPath1 ) || self.isEmpty( srcFilteredPath2 ) ||
        _.arraySetIdentical( srcFilteredPath1, srcFilteredPath2 ),
        () => 'Source paths are inconsistent ' + _.toStr( srcFilteredPath1 ) + ' ' + _.toStr( srcFilteredPath2 )
      );
    }
  }

  // /* */
  //
  // function dstVerify()
  // {
  //   if( dstFilePath && srcFilePath && Config.debug )
  //   {
  //     let dstFilteredPath1 = dstPath1.filter( ( e ) => !_.boolLike( e ) && e !== null );
  //     let dstFilteredPath2 = dstPath2.filter( ( e ) => !_.boolLike( e ) && e !== null );
  //     _.assert
  //     (
  //       dstFilteredPath1.length === 0 || dstFilteredPath2.length === 0 ||
  //       _.arraySetIdentical( dstFilteredPath1, [ '.' ] ) || _.arraySetIdentical( dstFilteredPath2, [ '.' ] ) || _.arraySetIdentical( dstFilteredPath1, dstFilteredPath2 ),
  //       () => 'Destination paths are inconsistent ' + _.toStr( dstFilteredPath1 ) + ' ' + _.toStr( dstFilteredPath2 )
  //     );
  //   }
  // }

}

// function mapsPair( srcFilePath, dstFilePath )
// {
//   let path = this;
//   let srcPath1;
//   let srcPath2;
//   let dstPath1;
//   let dstPath2;
//
//   _.assert( srcFilePath !== undefined );
//   _.assert( dstFilePath !== undefined );
//   _.assert( arguments.length === 2 );
//
//   if( srcFilePath && dstFilePath )
//   {
//
//     srcPath1 = path.mapSrcFromSrc( srcFilePath );
//     srcPath2 = path.mapSrcFromDst( dstFilePath );
//     dstPath1 = path.mapDstFromSrc( srcFilePath );
//     dstPath2 = path.mapDstFromDst( dstFilePath );
//
//     if( _.mapIs( srcFilePath ) && _.mapIs( dstFilePath ) )
//     {
//       mapsVerify();
//     }
//     else
//     {
//       srcVerify();
//       dstVerify();
//     }
//
//     let dstPath = dstPath1.slice();
//     _.arrayAppendOnce( dstPath, dstPath2 );
//     if( dstPath.length > 1 )
//     _.arrayRemoveElement( dstPath, null );
//     // _.arrayRemoveAll( dstPath, null ); // yyy
//
//     if( _.arraySetIdentical( srcPath1, [ '.' ] ) && srcPath2.length )
//     {
//       // srcFilePath = path.mapExtend( null, srcPath2, dstPath1 );
//       srcFilePath = path.mapExtend( null, srcPath2, dstPath );
//     }
//     else if( _.arraySetIdentical( srcPath2, [ '.' ] ) && srcPath1.length )
//     {
//       // dstFilePath = path.mapExtend( null, srcPath1, dstPath2 );
//       dstFilePath = path.mapExtend( null, srcPath1, dstPath );
//     }
//
//     if( _.arraySetIdentical( dstPath1, [ '.' ] ) && srcPath1.length )
//     {
//       // srcFilePath = path.mapExtend( null, srcPath1, dstPath2 );
//       srcFilePath = path.mapExtend( null, srcPath1, dstPath );
//     }
//     else if( _.arraySetIdentical( dstPath2, [ '.' ] ) && srcPath2.length )
//     {
//       debugger;
//       // dstFilePath = path.mapExtend( null, srcPath2, dstPath1 );
//       dstFilePath = path.mapExtend( null, srcPath2, dstPath );
//     }
//
//     if( _.mapIs( dstFilePath ) )
//     srcFilePath = dstFilePath = path.mapExtend( null, _.mapExtend( null, srcFilePath, dstFilePath ), null );
//     else
//     srcFilePath = dstFilePath = path.mapExtend( null, srcFilePath, dstFilePath );
//
//   }
//   else if( srcFilePath )
//   {
//     srcFilePath = dstFilePath = path.mapExtend( null, srcFilePath, null );
//   }
//   else if( dstFilePath )
//   {
//     if( _.mapIs( dstFilePath ) )
//     srcFilePath = dstFilePath = path.mapExtend( null, dstFilePath, null );
//     else
//     srcFilePath = dstFilePath = path.mapExtend( null, '.', dstFilePath );
//   }
//
//   return srcFilePath;
//
//   /* */
//
//   function mapsVerify()
//   {
//     return _.mapsAreIdentical( srcFilePath, dstFilePath );
//   }
//
//   /* */
//
//   function srcVerify()
//   {
//     if( dstFilePath && srcFilePath && Config.debug )
//     {
//       // let srcPath1 = path.mapSrcFromSrc( srcFilePath );
//       // let srcPath2 = path.mapSrcFromDst( dstFilePath );
//       // _.assert( srcPath1.length === 0 || srcPath2.length === 0 || _.arraySetIdentical( srcPath1, srcPath2 ), () => 'Source paths are inconsistent ' + _.toStr( srcPath1 ) + ' ' + _.toStr( srcPath2 ) );
//       _.assert
//       (
//         srcPath1.length === 0 || srcPath2.length === 0 ||
//         _.arraySetIdentical( srcPath1, [ '.' ] ) || _.arraySetIdentical( srcPath2, [ '.' ] ) || _.arraySetIdentical( srcPath1, srcPath2 ),
//         () => 'Source paths are inconsistent ' + _.toStr( srcPath1 ) + ' ' + _.toStr( srcPath2 )
//       );
//     }
//   }
//
//   /* */
//
//   function dstVerify()
//   {
//     if( dstFilePath && srcFilePath && Config.debug )
//     {
//       let dstFilteredPath1 = dstPath1.filter( ( e ) => !_.boolLike( e ) && e !== null );
//       let dstFilteredPath2 = dstPath2.filter( ( e ) => !_.boolLike( e ) && e !== null );
//       // _.assert( dstPath1.length === 0 || dstPath2.length === 0 || _.arraySetIdentical( dstPath1, dstPath2 ), () => 'Destination paths are inconsistent ' + _.toStr( dstPath1 ) + ' ' + _.toStr( dstPath2 ) );
//       _.assert
//       (
//         dstFilteredPath1.length === 0 || dstFilteredPath2.length === 0 ||
//         _.arraySetIdentical( dstFilteredPath1, [ '.' ] ) || _.arraySetIdentical( dstFilteredPath2, [ '.' ] ) || _.arraySetIdentical( dstFilteredPath1, dstFilteredPath2 ),
//         () => 'Destination paths are inconsistent ' + _.toStr( dstFilteredPath1 ) + ' ' + _.toStr( dstFilteredPath2 )
//       );
//     }
//   }
//
// }

//

/*
qqq : make pathMap*From* optimal and add tests
*/

function mapDstFromSrc( pathMap )
{
  _.assert( arguments.length === 1 );

  // if( _.strIs( pathMap ) )
  // return [ null ];

  // if( !_.mapIs( pathMap ) ) // yyy
  // return [ null ];

  if( !_.mapIs( pathMap ) )
  if( pathMap === null )
  return [];
  else
  return [ null ];

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

function mapDstFromDst( pathMap )
{
  _.assert( arguments.length === 1 );

  if( !_.mapIs( pathMap ) )
  if( pathMap === null )
  return [];
  else
  return _.arrayAsShallowing( pathMap );

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

function mapSrcFromSrc( pathMap )
{
  _.assert( arguments.length === 1 );

  if( !_.mapIs( pathMap ) )
  if( pathMap === null )
  return [];
  else
  return _.arrayAsShallowing( pathMap );

  // if( !_.mapIs( pathMap ) )
  // return _.arrayAs( pathMap );

  pathMap = this.mapExtend( null, pathMap );

  return _.mapKeys( pathMap )
}

//

function mapSrcFromDst( pathMap )
{
  _.assert( arguments.length === 1 );

  if( !_.mapIs( pathMap ) )
  if( pathMap === null )
  return [];
  else
  return [ null ];

  // if( !_.mapIs( pathMap ) )
  // return [];

  return _.mapKeys( pathMap )
}

//

function mapGroupByDst( pathMap )
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

    if( _.strIs( dst ) )
    {
      extend( dst, src );
    }
    else
    {
      _.assert( _.arrayIs( dst ) );
      for( var d = 0 ; d < dst.length ; d++ )
      extend( dst[ d ], src );
    }

  }

  /* */

  for( let src in pathMap )
  {
    let dst = pathMap[ src ];

    if( !_.boolLike( dst ) )
    continue;

    for( var dst2 in result )
    {

      for( var src2 in result[ dst2 ]  )
      {
        if( path.isRelative( src ) ^ path.isRelative( src2 ) )
        {
          result[ dst2 ][ src ] = !!dst;
        }
        else
        {
          // if( path.begins( src2, path.fromGlob( src ) ) )
          if( path.begins( path.fromGlob( src ), path.fromGlob( src2 ) ) )
          result[ dst2 ][ src ] = !!dst;
        }
      }

    }

  }

  /* */

  return result;

  /* */

  function extend( dst, src )
  {
    dst = path.normalize( dst );
    result[ dst ] = result[ dst ] || Object.create( null );
    result[ dst ][ src ] = '';
  }

}

//

function areBasePathsEquivalent( basePath1, basePath2 )
{
  let path = this;

  let filePath1 = path.mapSrcFromDst( basePath1 );
  let filePath2 = path.mapSrcFromDst( basePath2 );

  basePath1 = path.mapDstFromDst( basePath1 );
  basePath2 = path.mapDstFromDst( basePath2 );

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

  // simple transformer

  _fromGlob,
  fromGlob : _.routineVectorize_functor( _fromGlob ),
  globNormalize,
  globSplit,
  _globSplitToRegexpSource,

  // short filter

  globSplitToRegexp,
  globsShortToRegexps : _.routineVectorize_functor( globSplitToRegexp ),
  globFilter,
  globFilterVals,
  globFilterKeys,

  // full filter

  _globRegexpSourceSplitsConcatWithSlashes,
  _globRegexpSourceSplitsJoinForTerminal,
  _globRegexpSourceSplitsJoinForDirectory,
  _relateForGlob,
  _globFullToRegexpSingle,
  _globsFullToRegexps,
  globsFullToRegexps,
  pathMapToRegexps,

  // path map

  /* xxx : move it out */

  filterInplace,
  filter,
  all,
  any,
  none,

  isEmpty,
  mapExtend,
  mapsPair,

  mapDstFromSrc,
  mapDstFromDst,
  mapSrcFromSrc,
  mapSrcFromDst,
  mapGroupByDst,

  areBasePathsEquivalent,

}

_.mapSupplement( Self, Fields );
_.mapSupplement( Self, Routines );

Self.Init();

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

if( typeof module !== 'undefined' )
{
  require( '../l3/Path.s' );
}

})();
