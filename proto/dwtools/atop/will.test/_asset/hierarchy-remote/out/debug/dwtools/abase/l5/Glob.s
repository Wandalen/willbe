( function _Glob_s_() {

'use strict';

/**
 * @file Glob.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );
  _.include( 'wPathBasic' );
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

let _pathIsGlobRegexpSource = '';
_pathIsGlobRegexpSource += '(?:[?*]+)'; /* asterix, question mark */
_pathIsGlobRegexpSource += '|(?:([!?*@+]*)\\((.*?(?:\\|(.*?))*)\\))'; /* parentheses */
_pathIsGlobRegexpSource += '|(?:\\[(.+?)\\])'; /* square brackets */
_pathIsGlobRegexpSource += '|(?:\\{(.*)\\})'; /* curly brackets */
_pathIsGlobRegexpSource += '\\(\\)|\\0'; /* zero */

let _pathIsGlobRegexp = new RegExp( _pathIsGlobRegexpSource );

function _fromGlob( glob )
{
  let self = this;
  let result;

  _.assert( _.strIs( glob ), () => 'Expects string {-glob-}, but got ' + _.strType( glob ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( glob === '' || glob === null )
  return glob;

  let i = glob.search( _pathIsGlobRegexp );

  if( i >= 0 )
  {

    while( i >= 0 && glob[ i ] !== self._upStr )
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

  result = self.detrail( result || self._hereStr );
  // result = self.detrail( result );

  _.assert( !self.isGlob( result ) );

  return result;
}

//

function globNormalize( glob )
{
  let self = this;
  let result = _.strReplaceAll( glob, { '()' : '', '*()' : '', '\0' : '' } ); /* xxx : cover */
  if( result !== glob )
  result = self.canonize( result );
  return result;
}

//

let _globSplitToRegexpSource = (function functor()
{

  let _globRegexpSourceCache = Object.create( null )

  let _transformation0 =
  [
    [ /\[(.+?)\]/g, handlePass ], /* square brackets */
    [ /\.\./g, handlePass ], /* dual dot */
    [ /\./g, handlePass ], /* dot */
    [ /\(\)|\0/g, handlePass ], /* empty parentheses or zero */
    [ /([!?*@+]*)\((.*?(?:\|(.*?))*)\)/g, handlePass ], /* parentheses */
    [ /\*\*\*/g, handlePass, ], /* triple asterix */
    [ /\*\*/g, handlePass, ], /* dual asterix */
    [ /(\*)/g, handlePass ], /* single asterix */
    [ /(\?)/g, handlePass ], /* question mark */
  ]

  let _transformation1 =
  [
    [ /\[(.+?)\]/g, handleSquareBrackets ], /* square brackets */
    [ /\{(.*)\}/g, handleCurlyBrackets ], /* curly brackets */
  ]

  let _transformation2 =
  [
    [ /\.\./g, '\\.\\.' ], /* dual dot */
    [ /\./g, '\\.' ], /* dot */
    [ /\(\)|\0/g, '' ], /* empty parentheses or zero */
    [ /([!?*@+]?)\((.*?(?:\|(.*?))*)\)/g, hanleParentheses ], /* parentheses */
    // [ /\/\*\*/g, '(?:\/.*)?', ], /* slash + dual asterix */
    [ /\*\*\*/g, '(?:.*)', ], /* triple asterix */
    [ /\*\*/g, '.*', ], /* dual asterix */
    [ /(\*)/g, '[^\/]*' ], /* single asterix */
    [ /(\?)/g, '[^\/]' ], /* question mark */
  ]

  /* */

  return function _globSplitToRegexpSource( src )
  {

    _.assert( _.strIs( src ) );
    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assert( !_.strHas( src, /(^|\/)\.\.(\/|$)/ ) || src === this._downStr, 'glob should not has splits with ".." combined with something' );

    let result;

    result = _globRegexpSourceCache[ src ];

    if( result )
    return result;

    result = transform( src );

    _globRegexpSourceCache[ src ] = result;

    return result;
  }

  /* */

  function transform( src )
  {
    let result = src;

    result = _.strReplaceAll
    ({
      src : result,
      dictionary : _transformation0,
      joining : 1,
      onUnknown : handleUnknown,
    });

    result = _.strReplaceAll( result, _transformation1 );
    result = _.strReplaceAll( result, _transformation2 );

    return result;
  }

  /* */

  function handleUnknown( src )
  {
    return _.regexpEscape( src );
  }

  /* */

  function handlePass( src )
  {
    return src;
  }

  /* */

  function handleCurlyBrackets( src, it )
  {
    debugger;
    throw _.err( 'Glob with curly brackets is not allowed ', src );
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
    return [ '[' + inside + ']' ];
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

    // inside = inside.map( ( i ) => _.regexpEscape( i ) );
    inside = inside.map( ( i ) => _globSplitToRegexpSource( i ) );

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

})();

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

let _removeExtraDoubleAsterisk = new RegExp( '\\*\\*' + '(?:' + Self._upRegSource + '\\*\\*' + ')+' );

function _globAnalogs1( glob )
{
  let self = this;
  let splits = self.split( glob );
  let counter = 0;

  _.assert( _.strIs( glob ), 'Expects string {-glob-}' );

  /* separate dual asterisks */

  for( let s = splits.length-1 ; s >= 0 ; s-- )
  {
    let split = splits[ s ];

    if( split === '**' || split === '***' )
    continue;

    if( !_.strHas( split, '**' ) )
    continue;

    counter += 1;
    split = _.strSplitFast({ src : split, delimeter : [ '***', '**' ], preservingEmpty : 0 });

    for( let e = split.length-1 ; e >= 0 ; e-- )
    {
      let element = split[ e ];
      if( element === '**' || element === '***' )
      {
        element = '***';
        split[ e ] = element;
        continue;
      }

      if( !element )
      {
        debugger;
        split.splice( e, 1 );
        continue;
      }

      if( e > 0 )
      element = '*' + element;
      if( e < split.length-1 )
      element = element + '*';

      split[ e ] = element;
    }
    _.longButInplace( splits, [ s, s+1 ], split );
  }

  /* concat */

  let result = splits.join( self._upStr );

  /* remove duplicates of dual asterisks */

  for( let r = result.length-1 ; r >= 0 ; r-- )
  {
    let res = result[ r ];
    do
    {
      res = res.replace( _removeExtraDoubleAsterisk, self._upStr );
      if( res === result[ r ] )
      break;
      else
      result[ r ] = res;
    }
    while( true );
  }

  // for( let s = result.length-2 ; s >= 0 ; s-- )
  // {
  //   let split = result[ s ];
  //   if( split !== '**' || result[ s+1 ] !== '**' )
  //   continue;
  //   debugger;
  //   longBut( result, [ s, s+1 ], split );
  // }

  /* */

  return result;
}

//

function _globAnalogs2( glob, stemPath, basePath )
{
  let self = this;

  if( _.arrayIs( glob ) )
  {
    return glob.map( ( glob ) => self._globAnalogs2( glob, stemPath, basePath ) );
  }

  _.assert( arguments.length === 3, 'Expects exactly four arguments' );
  _.assert( _.strIs( glob ), 'Expects string {-glob-}' );
  _.assert( _.strIs( stemPath ), 'Expects string' );
  _.assert( _.strIs( basePath ) );
  _.assert( !self.isRelative( glob ) ^ self.isRelative( stemPath ), 'Expects both relative path either absolute' );

  // glob = self.globNormalize( glob );
  // glob = self.join( stemPath, glob );

  _.assert( self.isGlob( glob ), () => 'Expects glob, but got ' + glob );

  let result = [];
  let globDir = self.fromGlob( glob );

  let globRelativeBase = self.relative( basePath, glob );
  let globDirRelativeBase = self.relative( basePath, globDir );
  let stemRelativeBase = self.relative( basePath, stemPath );

  let baseRelativeGlobDir = self.relative( globDir, basePath );
  let baseRelativeStem = self.relative( stemPath, basePath );

  let globRelativeStem = self.relative( stemPath, glob );
  let globDirRelativeStem = self.relative( stemPath, globDir );
  let stemRelativeGlobDir = self.relative( globDir, stemPath );
  let globRelativeGlobDir = self.relative( globDir, glob );

  if( globDirRelativeBase === self._hereStr && stemRelativeBase === self._hereStr )
  {

    result.push( self.dot( globRelativeBase ) );

  }
  else
  {

    if( isDotted( stemRelativeGlobDir ) )
    {
      if( self.begins( stemPath, globDir ) || self.begins( globDir, stemPath ) )
      handleInside();
      else
      handleNever();
    }
    else
    {
      handleOutside();
    }

  }

  return result;

  /* */

  function handleInside()
  {

    let globSplits = globRelativeGlobDir

    let glob3 = globSplits;
    if( globDirRelativeStem !== self._hereStr )
    glob3 = globDirRelativeStem + self._upStr + glob3;
    if( stemRelativeGlobDir === self._hereStr )
    {
      glob3 = globDirRelativeBase + self._upStr + glob3;
    }
    else
    {
      glob3 = self.join( stemRelativeBase, glob3 );
      // if( stemRelativeBase !== self._hereStr )
      // glob3 = stemRelativeBase + self._upStr + glob3;
    }
    _.arrayAppendOnce( result, self.dot( glob3 ) );

    if( self.begins( globDir, basePath ) || self.begins( basePath, globDir ) )
    {
      let glob4 = globSplits;
      if( !isDotted( globDirRelativeBase ) )
      glob4 = globDirRelativeBase + self._upStr + glob4;
      _.arrayAppendOnce( result, self.dot( glob4 ) );
    }

  }

  /* */

  function handleOutside()
  {

    let globSplits = globRelativeGlobDir.split( self._upStr );
    let globRegexpSourceSplits = globSplits.map( ( e, i ) => self._globSplitToRegexpSource( e ) );

    if( handleCertain( globSplits, globRegexpSourceSplits ) )
    return;

    let s = 0;
    let firstAny = globSplits.length;
    while( s < globSplits.length )
    {
      let split = globSplits[ s ];
      if( split === '**' || split === '***' )
      {
        firstAny = s;
      }
      let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits.slice( 0, s+1 ) ) + '$' );
      if( globSliced.test( stemRelativeGlobDir ) )
      {

        let splits3 = firstAny < globSplits.length ? globSplits.slice( firstAny ) : globSplits.slice( s+1 );
        if( stemRelativeBase !== self._hereStr )
        {
          if( isDotted( stemRelativeGlobDir ) )
          _.arrayPrependArray( splits3, self.split( baseRelativeStem ) );
          _.arrayPrependArray( splits3, self.split( stemRelativeBase ) );
          let glob3 = splits3.join( self._upStr );
          _.arrayAppendOnce( result, self.dot( glob3 ) );
        }

        let splits4 = firstAny < globSplits.length ? globSplits.slice( firstAny ) : globSplits.slice( s+1 );
        let glob4 = splits4.join( self._upStr );
        _.arrayAppendOnce( result, self.dot( glob4 ) );

        // if( firstAny < globSplits.length )
        // break;

      }
      s += 1;
    }

  }

  /* */

  function handleCertain( globSplits, globRegexpSourceSplits )
  {

    if( globSplits.length === 1 )
    if( globSplits[ 0 ] === '**' || globSplits[ 0 ] === '***' )
    {
      _.assert( result.length === 0 );
      result.push( '**' );
      return true;
    }

    if( globSplits[ globSplits.length - 1 ] !== '**' && globSplits[ globSplits.length - 1 ] !== '***' )
    return false;

    let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits ) + '$' );
    if( !globSliced.test( stemRelativeGlobDir ) )
    return false;

    _.assert( result.length === 0 );
    result.push( '**' );
    return true;
  }

  /* */

  function handleNever()
  {
  }

  /* */

  function isDotted( filePath )
  {
    return filePath === self._hereStr || filePath === self._downStr || _.strBegins( filePath, self._downStr );
  }

  /* */

  function isUp( filePath )
  {
    return filePath === self._downStr || _.strBegins( filePath, self._downStr );
  }

  /* */

}

//

// function _globAnalogs2( glob, stemPath, basePath )
// {
//   let self = this;
//   let result = [];
//
//   _.assert( arguments.length === 3, 'Expects exactly three arguments' );
//   _.assert( _.strIs( glob ), 'Expects string {-glob-}' );
//   _.assert( _.strIs( stemPath ), 'Expects string' );
//   _.assert( _.strIs( basePath ) );
//   _.assert( !self.isRelative( glob ) ^ self.isRelative( stemPath ), 'Expects both relative path either absolute' );
//
//   glob = this.globNormalize( glob );
//   glob = this.join( stemPath, glob );
//   let globDir = this.fromGlob( glob );
//   let common = this.common( glob, basePath );
//
//   let globRelativeBase = this.relative( basePath, glob );
//   let globDirRelativeBase = this.relative( basePath, globDir );
//   let stemRelativeBase = this.relative( basePath, stemPath );
//
//   let baseRelativeGlob = this.relative( glob, basePath );
//   let baseRelativeGlobDir = this.relative( globDir, basePath );
//   let baseRelativeStem = this.relative( stemPath, basePath );
//
//   let globRelativeStem = this.relative( stemPath, glob );
//   let globDirRelativeStem = this.relative( stemPath, globDir );
//   let stemRelativeGlobDir = this.relative( globDir, stemPath );
//   // let baseRelativeStem = this.relative( stemPath, basePath );
//
//   let globRelativeCommon = this.relative( common, glob );
//   let baseRelativeCommon = this.relative( common, basePath );
//
//   // debugger;
//
//   if( globDirRelativeBase === self._hereStr && stemRelativeBase === self._hereStr )
//   // if( baseRelativeCommon === '.' )
//   {
//
//     result.push( self.dot( globRelativeBase ) );
//     // result.push( ( globRelativeBase === '' || globRelativeBase === '.' ) ? '.' : './' + globRelativeBase );
//
//   }
//   else
//   {
//
//     // debugger;
//     // if( 0 )
//     // if( baseRelativeStem !== '.' )
//     // {
//     //   // debugger;
//     //   let downGlob2 = self.relative( stemPath, glob ); // yyy
//     //   result.push( downGlob2 );
//     // }
//
//     let globSplits = this._globAnalogs1( globRelativeCommon );
//     let globRegexpSourceSplits = globSplits.map( ( e, i ) => self._globSplitToRegexpSource( e ) );
//
//     // let globPath = self.fromGlob( glob );
//     // let globPathRelativeFilePath = self.relative( globPath, stemPath );
//     // let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits ) + '$' );
//     // if( globSliced.test( baseRelativeStem ) )
//     // {
//     //   debugger;
//     //   _.arrayAppendOnce( result, '**' );
//     //   return result;
//     // }
//
//     debugger;
//     if( !isDotted( baseRelativeStem ) )
//     {
//
//       // let downGlob2 = self.relative( basePath, glob );
//       // result.push( downGlob2 );
//
//       // if( isDotted( baseRelativeGlobDir ) )
//       // {
//       //   debugger;
//       //   let downGlob2 = self.dot( self.relative( basePath, glob ) );
//       //   result.push( downGlob2 );
//       // }
//
//       _.assert( _.strBegins( stemRelativeBase, '..' ), 'not tested' );
//       let s = 0;
//       let firstAny = globSplits.length;
//       while( s < globSplits.length )
//       {
//         if( globSplits[ s ] === '**' )
//         {
//           firstAny = s;
//         }
//         let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits.slice( 0, s+1 ) ) + '$' );
//         if( globSliced.test( baseRelativeStem ) )
//         {
//
//           let splits3 = firstAny < globSplits.length ? globSplits.slice( firstAny ) : globSplits.slice( s+1 );
//           if( isDotted( stemRelativeGlobDir ) )
//           _.arrayPrependArray( splits3, self.split( baseRelativeStem ) );
//           _.arrayPrependArray( splits3, self.split( stemRelativeBase ) );
//           let glob3 = splits3.join( self._upStr );
//           _.arrayAppendOnce( result, self.dot( glob3 ) );
//
//           let splits4 = firstAny < globSplits.length ? globSplits.slice( firstAny ) : globSplits.slice( s+1 );
//           let glob4 = splits4.join( self._upStr );
//           _.arrayAppendOnce( result, self.dot( glob4 ) );
//
//           if( firstAny < globSplits.length )
//           break;
//         }
//         s += 1;
//       }
//
//     }
//     else
//     {
//
//       if( isDotted( baseRelativeGlobDir ) )
//       {
//         debugger;
//         let downGlob2 = self.dot( self.relative( basePath, glob ) );
//         result.push( downGlob2 );
//       }
//       else
//       {
//
//         let s = 0;
//         let firstAny = globSplits.length;
//         while( s < globSplits.length )
//         {
//           if( globSplits[ s ] === '**' )
//           {
//             firstAny = s;
//           }
//           let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits.slice( 0, s+1 ) ) + '$' );
//           if( globSliced.test( baseRelativeGlobDir ) )
//           {
//
//             let splits3 = firstAny < globSplits.length ? globSplits.slice( firstAny ) : globSplits.slice( s+1 );
//             _.arrayPrependArray( splits3, self.split( baseRelativeGlobDir ) );
//             _.arrayPrependArray( splits3, self.split( globDirRelativeBase ) );
//             let glob3 = splits3.join( self._upStr );
//             _.arrayAppendOnce( result, self.dot( glob3 ) );
//
//             let splits4 = firstAny < globSplits.length ? globSplits.slice( firstAny ) : globSplits.slice( s+1 );
//             let glob4 = splits4.join( self._upStr );
//             _.arrayAppendOnce( result, self.dot( glob4 ) );
//
//             if( firstAny < globSplits.length )
//             break;
//           }
//           s += 1;
//         }
//
//       }
//
//       // let s = 0;
//       // let firstAny = globSplits.length;
//       // while( s < globSplits.length )
//       // {
//       //   if( globSplits[ s ] === '**' )
//       //   {
//       //     firstAny = s;
//       //   }
//       //   let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits.slice( 0, s+1 ) ) + '$' );
//       //   if( globSliced.test( baseRelativeStem ) )
//       //   {
//       //     let splits = firstAny < globSplits.length ? globSplits.slice( firstAny ) : globSplits.slice( s+1 );
//       //     let glob3 = splits.join( self._upStr );
//       //     _.arrayAppendOnce( result, glob3 === '' ? '.' : './' + glob3  );
//       //     if( firstAny < globSplits.length )
//       //     break;
//       //   }
//       //   s += 1;
//       // }
//
//     }
//
//   }
//
//   return result;
//
//   function isDotted( filePath )
//   {
//     return filePath === self._hereStr || filePath === self._downStr || _.strBegins( filePath, self._downStr );
//   }
//
//   function isUp( filePath )
//   {
//     return filePath === self._downStr || _.strBegins( filePath, self._downStr );
//   }
//
// }

// function _globAnalogs2( glob, stemPath, basePath )
// {
//   let self = this;
//   let result = [];
//
//   _.assert( arguments.length === 3, 'Expects exactly three arguments' );
//   _.assert( _.strIs( glob ), 'Expects string {-glob-}' );
//   _.assert( _.strIs( stemPath ), 'Expects string' );
//   _.assert( _.strIs( basePath ) );
//   _.assert( !self.isRelative( glob ) ^ self.isRelative( stemPath ), 'Expects both relative path either absolute' );
//
//   debugger;
//
//   glob = this.globNormalize( glob );
//   glob = this.join( stemPath, glob );
//   let common = this.common( glob, basePath );
//   let glob2 = this.relative( common, glob );
//   let baseRelativeCommon = this.relative( common, basePath );
//
//   if( baseRelativeCommon === '.' )
//   {
//
//     result.push( ( glob2 === '' || glob2 === '.' ) ? '.' : './' + glob2 );
//
//   }
//   else
//   {
//
//     debugger;
//     let downGlob2 = self.relative( stemPath, glob );
//     result.push( downGlob2 );
//
//     let globSplits = this._globAnalogs1( glob2 );
//     let globRegexpSourceSplits = globSplits.map( ( e, i ) => self._globSplitToRegexpSource( e ) );
//
//     // let globPath = self.fromGlob( glob );
//     // let globPathRelativeFilePath = self.relative( globPath, stemPath );
//     // let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits ) + '$' );
//     // if( globSliced.test( baseRelativeCommon ) )
//     // {
//     //   debugger;
//     //   _.arrayAppendOnce( result, '**' );
//     //   return result;
//     // }
//
//     let s = 0;
//     let firstAny = globSplits.length;
//     while( s < globSplits.length )
//     {
//       if( globSplits[ s ] === '**' )
//       {
//         firstAny = s;
//       }
//       let globSliced = new RegExp( '^' + self._globRegexpSourceSplitsJoinForTerminal( globRegexpSourceSplits.slice( 0, s+1 ) ) + '$' );
//       if( globSliced.test( baseRelativeCommon ) )
//       {
//         let splits = firstAny < globSplits.length ? globSplits.slice( firstAny ) : globSplits.slice( s+1 );
//         let glob3 = splits.join( self._upStr );
//         _.arrayAppendOnce( result, glob3 === '' ? '.' : './' + glob3  );
//         if( firstAny < globSplits.length )
//         break;
//       }
//       s += 1;
//     }
//
//   }
//
//   return result;
// }

//

function _globRegexpSourceSplitsConcatWithSlashes( globRegexpSourceSplits )
{
  let result = [];

  /*
    asterisk and dual-asterisk are optional elements of pattern
    so them could be missing
  */

  let isPrevTriAsterisk = false;
  for( let s = 0 ; s < globRegexpSourceSplits.length ; s++ )
  {
    let split = globRegexpSourceSplits[ s ];

    let isTriAsterisk = split === '(?:.*)'; /* *** */
    let isDualAsterisk = split === '.*'; /* ** */
    let isAsterisk = split === '[^\/]*'; /* * */

    if( isTriAsterisk )
    split = '(?:(?:^|/)' + split + ')?';
    else if( isDualAsterisk )
    split = '(?:(?:^|/)' + split + ')?';
    else if( isAsterisk )
    split = '(?:(?:^|/)' + split + ')?';
    else if( s > 0 )
    {
      if( isPrevTriAsterisk )
      split = '(?:^|/)?' + split;
      else
      split = '(?:^|/)' + split;
    }

    isPrevTriAsterisk = isTriAsterisk;
    result[ s ] = split;
  }

  return result;
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

let _globFullToRegexpSingleCache = Object.create( null ); /* xxx : try */
function _globFullToRegexpSingle( glob, stemPath, basePath, isPositive )
{
  let self = this;

  if( isPositive === undefined )
  isPositive = true;

  _.assert( _.strIs( glob ), 'Expects string {-glob-}' );
  _.assert( _.strIs( stemPath ) && !self.isGlob( stemPath ) );
  _.assert( _.strIs( basePath ) && !self.isGlob( basePath ) );
  _.assert( arguments.length === 3 || arguments.length === 4 );

  glob = self.join( stemPath, glob );

  _.assert( self.isGlob( glob ) );

  let analogs1 = self._globAnalogs1( glob );
  let analogs2 = self._globAnalogs2( analogs1, stemPath, basePath );
  // debugger;

  let maybeHere = '';
  let hereEscapedStr = self._globSplitToRegexpSource( self._hereStr );
  let downEscapedStr = self._globSplitToRegexpSource( self._downStr );

  let result = Object.create( null );
  result.transient = [];
  result.actual = [];
  result.certainly = [];

  for( let r = 0 ; r < analogs2.length ; r++ )
  {
    let analog = analogs2[ r ];
    let splits = self.split( analog );

    let certainlySplits;
    if( splits[ splits.length - 1 ] === '**' || splits[ splits.length - 1 ] === '***' )
    certainlySplits = splits.slice();

    let sources = splits.map( ( e, i ) => toSource( e ) );
    if( certainlySplits )
    certainlySplits = certainlySplits.map( ( e, i ) => toSource( e ) );

    result.actual.push( self._globRegexpSourceSplitsJoinForTerminal( sources ) );
    result.transient.push( self._globRegexpSourceSplitsJoinForDirectory( sources ) );
    if( certainlySplits )
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

  function toSource( split )
  {
    // if( cache[ split ] )
    // return cache[ split ];
    // cache[ split ] = self._globSplitToRegexpSource( split );
    // return cache[ split ];
    return self._globSplitToRegexpSource( split );
  }

}

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
  let self = this;
  let regexps = Object.create( null );

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
    o.filePath[ srcGlob ] = '';
  }

  /* unglob filePath */

  fileUnglob();
  o.optimizedUnglobedFilePath = _.mapExtend( null, o.unglobedFilePath );

  /* unglob basePath */

  o.unglobedBasePath = baseUnglob();
  o.optimizedUnglobedBasePath = _.mapExtend( null, o.unglobedBasePath );

  /* group by path */

  o.groupsMap = groupBySrc( 0 );
  o.optimalGroupsMap = groupBySrc( 1 );

  /* */

  o.optimalRegexpsMap = Object.create( null );
  for( let stemPath in o.optimalGroupsMap )
  {
    let r = o.optimalRegexpsMap[ stemPath ] = regexpsMapFor( stemPath, o.optimalGroupsMap[ stemPath ] );
  }

  o.regexpsMap = Object.create( null );
  for( let stemPath in o.groupsMap )
  {
    let r = o.regexpsMap[ stemPath ] = regexpsMapFor( stemPath, o.groupsMap[ stemPath ] );
  }

  /* */

  return o;

  /* */

  function regexpsMapFor( stemPath, group )
  {

    let basePath = o.unglobedBasePath[ stemPath ];
    let r = Object.create( null );
    r.certainlyHash = new Map;
    r.transient = [];
    r.actualAny = [];
    r.actualAny2 = [];
    r.actualAll = [];
    r.actualNone = [];

    _.assert( _.strDefined( basePath ), 'No base path for', stemPath );

    for( let fileGlob in group )
    {
      let value = group[ fileGlob ];

      fileGlob = self.globNormalize( fileGlob );

      if( !self.isGlob( fileGlob ) )
      {
        if( stemPath !== fileGlob || _.boolLike( value ) )
        fileGlob = self.join( fileGlob, '**' );
        else
        continue;
      }

      _.assert( self.isGlob( fileGlob ) );

      let isPositive = ( _.boolLike( value ) && !value ) ? false : true;
      let regexps = regexpsFor( fileGlob, stemPath, basePath, isPositive );

      if( regexps.certainly )
      r.certainlyHash.set( regexps.actual, regexps.certainly )

      if( value || value === null || value === '' )
      {
        if( _.boolLike( value ) )
        {
          // r.actualAny2.push( regexps.actual );
          r.actualAll.push( regexps.actual );
        }
        else
        {
          // r.actualAll.push( regexps.actual );
          r.actualAny.push( regexps.actual );
        }
        r.transient.push( regexps.transient )
      }
      else
      {
        r.actualNone.push( regexps.actual );
      }

    }

    return r;
  }

  /* */

  function regexpsFor( fileGlob, stemPath, basePath, isPositive )
  {
    let hash = fileGlob + '\0' + stemPath + '\0' + basePath + '\0' + isPositive;
    let result = regexps[ hash ];
    if( !result )
    result = regexps[ hash ] = self._globFullToRegexpSingle( fileGlob, stemPath, basePath, isPositive );
    return result;
  }

  /* */

  function unglobedBasePathAdd( unglobedBasePath, fileGlob, filePath, basePath )
  {
    _.assert( _.strIs( fileGlob ) );
    _.assert( filePath === undefined || _.strIs( filePath ) );
    _.assert( _.strIs( basePath ) );
    _.assert( o.filePath[ fileGlob ] !== undefined, () => 'No file path for file glob ' + g );

    if( _.boolLike( o.filePath[ fileGlob ] ) )
    return;

    if( !filePath )
    filePath = self.fromGlob( fileGlob );

    _.assert
    (
      unglobedBasePath[ filePath ] === undefined || unglobedBasePath[ filePath ] === basePath,
      () => 'The same file path ' + _.strQuote( filePath ) + ' has several different base paths:' +
      '\n - ' + _.strQuote( unglobedBasePath[ filePath ] ),
      '\n - ' + _.strQuote( basePath )
    );
    unglobedBasePath[ filePath ] = basePath;
  }

  /* */

  function fileUnglob()
  {
    o.fileGlobToPathMap = Object.create( null );
    o.filePathToGlobMap = Object.create( null );
    o.unglobedFilePath = Object.create( null );
    for( let srcGlob in o.filePath )
    {
      let dstPath = o.filePath[ srcGlob ];

      if( dstPath === null )
      dstPath = '';

      _.assert( self.isAbsolute( srcGlob ), () => 'Expects absolute path, but ' + _.strQuote( srcGlob ) + ' is not' );

      let srcPath = self.fromGlob( srcGlob );

      o.fileGlobToPathMap[ srcGlob ] = srcPath;
      o.filePathToGlobMap[ srcPath ] = o.filePathToGlobMap[ srcPath ] || [];
      o.filePathToGlobMap[ srcPath ].push( srcGlob );
      let wasUnglobedFilePath = o.unglobedFilePath[ srcPath ];
      if( wasUnglobedFilePath === undefined || _.boolLike( wasUnglobedFilePath ) )
      if( !_.boolLike( dstPath ) )
      {
        _.assert( wasUnglobedFilePath === undefined || _.boolLike( wasUnglobedFilePath ) || wasUnglobedFilePath === dstPath );
        o.unglobedFilePath[ srcPath ] = dstPath;
      }

    }

  }

  /* */

  function baseUnglob()
  {

    let unglobedBasePath = Object.create( null );
    for( let fileGlob in o.basePath )
    {
      _.assert( self.isAbsolute( fileGlob ) );
      _.assert( !self.isGlob( o.basePath[ fileGlob ] ) );

      let filePath;
      let basePath = o.basePath[ fileGlob ];
      if( o.filePath[ fileGlob ] === undefined )
      {
        filePath = fileGlob;
        fileGlob = o.filePathToGlobMap[ filePath ];
      }

      if( _.arrayIs( filePath ) )
      filePath.forEach( ( filePath ) => unglobedBasePathAdd( unglobedBasePath, fileGlob, filePath, basePath ) );
      else
      unglobedBasePathAdd( unglobedBasePath, fileGlob, filePath, basePath )
    }

    return unglobedBasePath;
  }

  /* */

  function groupBySrc( optimal )
  {

    let groupsMap = Object.create( null );
    let redundantArray = o.redundantArray = Object.keys( o.filePath );
    redundantArray.sort();

    /*
    sorted, so paths with the same base are neighbours now
    */

    for( let f = 0 ; f < redundantArray.length ; f++ )
    {
      let fileGlob = redundantArray[ f ];
      let value = o.filePath[ fileGlob ];
      let filePath = o.fileGlobToPathMap[ fileGlob ];
      let group = { [ fileGlob ] : value };

      if( _.boolLike( value ) )
      continue;

      redundantArray.splice( f, 1 );
      f -= 1;

      for( let f2 = f+1 ; f2 < redundantArray.length ; f2++ )
      {
        let fileGlob2 = redundantArray[ f2 ];
        let value2 = o.filePath[ fileGlob2 ];
        let filePath2 = o.fileGlobToPathMap[ fileGlob2 ];
        let begin;

        if( _.boolLike( value2 ) )
        continue;

        _.assert( fileGlob !== fileGlob2 );

        if( self.begins( filePath2, filePath ) )
        begin = filePath;

        /* skip if different group */
        if( !begin )
        break;

        if( _.boolLike( value2 ) )
        {
          group[ fileGlob2 ] = value2;
        }
        else
        {
          if( filePath === filePath2 )
          {
            group[ fileGlob2 ] = value2;
            redundantArray.splice( f2, 1 );
            f2 -= 1;
          }
          else
          {
            if( optimal )
            if( o.basePath[ fileGlob2 ] === o.basePath[ fileGlob ] )
            {
              group[ fileGlob2 ] = value2;
              redundantArray.splice( f2, 1 );
              f2 -= 1;
              delete o.optimizedUnglobedFilePath[ filePath2 ];
              delete o.optimizedUnglobedBasePath[ filePath2 ];
            }
          }
        }

      }

      let commonPath = filePath;

      /* */

      if( optimal )
      for( let fileGlob2 in group )
      {
        let value2 = o.filePath[ fileGlob2 ];

        if( _.boolLike( value2 ) )
        continue;

        let filePath2 = o.fileGlobToPathMap[ fileGlob2 ];
        if( filePath2.length < commonPath.length )
        {
          _.assert( 0 );
          commonPath = filePath2;
        }

      }

      /* */

      for( let f2 = f ; f2 >= 0 ; f2-- )
      {
        let fileGlob2 = redundantArray[ f2 ];
        let value2 = o.filePath[ fileGlob2 ];
        let filePath2 = o.fileGlobToPathMap[ fileGlob2 ];
        let begin;

        if( !_.boolLike( value2 ) )
        continue;

        _.assert( fileGlob !== fileGlob2 );

        if( self.begins( filePath, filePath2 ) )
        begin = filePath;

        /* skip if different group */
        if( !begin )
        continue;

        group[ fileGlob2 ] = value2;
      }

      /* */

      for( let f2 = f+1 ; f2 < redundantArray.length ; f2++ )
      {
        let fileGlob2 = redundantArray[ f2 ];
        let value2 = o.filePath[ fileGlob2 ];
        let filePath2 = o.fileGlobToPathMap[ fileGlob2 ];
        let begin;

        if( !_.boolLike( value2 ) )
        continue;

        _.assert( fileGlob !== fileGlob2 );

        if( self.begins( filePath2, filePath ) )
        begin = filePath;

        /* skip if different group */
        if( !begin )
        break;

        group[ fileGlob2 ] = value2;
      }

      _.assert( groupsMap[ commonPath ] === undefined );
      groupsMap[ commonPath ] = group;

    }

    return groupsMap;
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
  fromGlob : _vectorize( _fromGlob ),
  globNormalize,
  _globSplitToRegexpSource,

  // short filter

  globSplitToRegexp,
  globsShortToRegexps : _vectorize( globSplitToRegexp ),
  globFilter,
  globFilterVals,
  globFilterKeys,

  // full filter

  _globAnalogs1,
  _globAnalogs2,

  _globRegexpSourceSplitsConcatWithSlashes,
  _globRegexpSourceSplitsJoinForTerminal,
  _globRegexpSourceSplitsJoinForDirectory,
  _globFullToRegexpSingle,
  _globsFullToRegexps : _vectorize( _globFullToRegexpSingle, 4 ),

  globsFullToRegexps,
  pathMapToRegexps,

}

_.mapSupplement( Self, Fields );
_.mapSupplement( Self, Routines );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
