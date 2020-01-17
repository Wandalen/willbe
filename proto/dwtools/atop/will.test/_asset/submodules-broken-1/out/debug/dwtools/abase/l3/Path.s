( function _PathBasic_s_() {

'use strict';

/**
 * Collection of routines to operate paths reliably and consistently. Path leverages parsing,joining,extracting,normalizing,nativizing,resolving paths. Use the module to get uniform experience from playing with paths on different platforms.
  @module Tools/base/Path
*/

/**
 * @file Path.s.
 */

/**
 * @summary Collection of routines to operate paths reliably and consistently.
 * @namespace "wTools.path"
 * @memberof module:Tools/PathBasic
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

}

//

let _global = _global_;
let _ = _global_.wTools;
_.assert( !!_.path );
let Self = _.path = _.path || Object.create( null );

// // --
// // meta
// // --
//
// function Init()
// {
//   let self = this;
//
//   _.assert( _.strIs( self._rootStr ) );
//   _.assert( _.strIs( self._upStr ) );
//   _.assert( _.strIs( self._hereStr ) );
//   _.assert( _.strIs( self._downStr ) );
//
//   if( !self._downUpStr )
//   self._downUpStr = self._downStr + self._upStr; /* ../ */
//   if( !self._hereUpStr )
//   self._hereUpStr = self._hereStr + self._upStr; /* ./ */
//
//   self._rootRegSource = _.regexpEscape( self._rootStr );
//   self._upRegSource = _.regexpEscape( self._upStr );
//   self._downRegSource = _.regexpEscape( self._downStr );
//   self._hereRegSource = _.regexpEscape( self._hereStr );
//   self._downUpRegSource = _.regexpEscape( self._downUpStr );
//   self._hereUpRegSource = _.regexpEscape( self._hereUpStr );
//
//   let root = self._rootRegSource;
//   let up = self._upRegSource;
//   let down = self._downRegSource;
//   let here = self._hereRegSource;
//
//   let beginOrChar = '(?:.|^)';
//   let butUp = `(?:(?!${up}).)+`;
//   let notDownUp = `(?!${down}(?:${up}|$))`;
//   let upOrBegin = `(?:^|${up})`;
//   let upOrEnd = `(?:${up}|$)`;
//   let splitOrUp = `(?:(?:${up}${up})|((${upOrBegin})${notDownUp}${butUp}${up}))`; /* split or / */
//
//   self._delDownRegexp = new RegExp( `(${beginOrChar})${splitOrUp}${down}(${upOrEnd})`, '' );
//   self._delHereRegexp = new RegExp( up + here + '(' + up + '|$)' );
//   self._delUpDupRegexp = /\/{2,}/g;
//
// }
//
// //
//
// function CloneExtending( o )
// {
//   _.assert( arguments.length === 1 );
//   let result = Object.create( this )
//   _.mapExtend( result, Parameters,o );
//   result.Init();
//   return result;
// }

// --
// checker
// --

// function is( path )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   return _.strIs( path );
// }
//
// //
//
// function are( paths )
// {
//   let self = this;
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   if( _.mapIs( paths ) )
//   return true;
//   if( !_.arrayIs( paths ) )
//   return false;
//   return paths.every( ( path ) => self.is( path ) );
// }

//

/* xxx : make new version in module Files */
function like( path )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( this.is( path ) )
  return true;
  if( _.FileRecord )
  if( path instanceof _.FileRecord )
  return true;
  return false;
}

//

function isElement( pathElement )
{
  return pathElement === null || _.strIs( pathElement ) || _.arrayIs( pathElement ) || _.mapIs( pathElement ) || _.boolLike( pathElement ) || _.regexpIs( pathElement );
}

//

/**
 * Checks if string is correct possible for current OS path and represent file/directory that is safe for modification
 * (not hidden for example).
 * @param {String} filePath Source path for check
 * @returns {boolean}
 * @function isSafe
 * @memberof module:Tools/PathBasic.wTools.path
 */

function isSafe( filePath,level )
{
  filePath = this.normalize( filePath );

  if( level === undefined )
  level = 1;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIs( level ), 'Expects number {- level -}' );

  if( level >= 1 )
  {
    if( this.isAbsolute( filePath ) )
    {
      let parts = filePath.split( this._upStr ).filter( ( p ) => p.trim() );
      if( process.platform === 'win32' && parts.length && parts[ 0 ].length === 1 )
      parts.splice( 0, 1 );
      if( parts.length <= 1 )
      return false;
      if( level >= 2 && parts.length <= 2 )
      return false;
      return true;
    }
  }

  if( level >= 2 && process.platform === 'win32' )
  {
    if( _.strHas( filePath, 'Windows' ) )
    return false;
    if( _.strHas( filePath, 'Program Files' ) )
    return false;
  }

  if( level >= 2 )
  if( /(^|\/)\.(?!$|\/|\.)/.test( filePath ) )
  return false;

  if( level >= 3 )
  if( /(^|\/)node_modules($|\/)/.test( filePath ) )
  return false;

  return true;
}

// //
//
// /**
//  * Checks if string path is refined ( checks that the string doesn´t contain left( \\ ) or double slashes ( // ) ), and it also
//  * returns true when the path has slash ( / ) in the end .
//  * @param {String} filePath Source path for check
//  * @returns {boolean}
//  * @function isRefined
//  * @memberof module:Tools/PathBasic.wTools.path
//  */
//
// function isRefined( path )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( path ), 'Expects string {-path-}, but got', _.strType( path ) );
//
//   if( path[ 1 ] === ':' && path[ 2 ] === '\\' )
//   return false;
//
//   let leftSlash = /\\/g;
//   let doubleSlash = /\/\//g;
//
//   if( leftSlash.test( path ) )
//   return false;
//
//   return true;
// }
//
// // //
// //
// // /**
// //  * Checks if string path is refined: checks that the string doesn´t contain left( \\ ) or double slashes ( // ) ), and that it is not trailed
// //  * @param {String} filePath Source path for check
// //  * @returns {boolean}
// //  * @function isRefined
// //  * @memberof module:Tools/PathBasic.wTools.path
// //  */
// //
// // function isRefined( path )
// // {
// //   _.assert( arguments.length === 1, 'Expects single argument' );
// //   _.assert( _.strIs( path ), 'Expects string {-path-}, but got', _.strType( path ) );
// //
// //   if( !this.isRefined( path ) )
// //   return false;
// //
// //   return true;
// // }
//
// //
//
// /**
//  * Checks if string path is normalized, and maybe trailed ( ends with a slash ( / ) ).
//  * @param {String} filePath Source path for check
//  * @returns {boolean}
//  * @function isNormalized
//  * @memberof module:Tools/PathBasic.wTools.path
//  */
//
// function isNormalized( filePath )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( filePath ), 'Expects string' );
//   let normalizedPath = this.normalize( filePath )
//   let trailedPath = this.trail( normalizedPath );
//   return normalizedPath === filePath || trailedPath === filePath;
// }
//
// //
//
// /**
//  * Checks if string path is normalized.
//  * @param {String} filePath Source path for check
//  * @returns {boolean}
//  * @function isNormalized
//  * @memberof module:Tools/PathBasic.wTools.path
//  */
//
// function isNormalized( filePath )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( filePath ), 'Expects string' );
//   let normalizedPath = this.normalize( filePath )
//   return normalizedPath === filePath;
// }
//
// //
//
// function isAbsolute( filePath )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( filePath ), 'Expects string {-filePath-}, but got', _.strType( filePath ) );
//   filePath = this.refine( filePath );
//   return _.strBegins( filePath, this._upStr );
// }
//
// //
//
// function isRelative( filePath )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( filePath ), 'Expects string {-filePath-}, but got', _.strType( filePath ) );
//   return !this.isAbsolute( filePath );
// }
//
// //
//
// function isGlobal( filePath )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( filePath ), 'Expects string' );
//   return _.strHas( filePath, '://' );
// }
//
// //
//
// function isRoot( filePath )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( filePath ), 'Expects string {-filePath-}, but got', _.strType( filePath ) );
//   if( filePath === this._rootStr )
//   return true;
//   if( this.isRelative( filePath ) )
//   return false;
//   if( this.normalize( filePath ) === this._rootStr )
//   return true;
//
//   return false;
// }
//
// //
//
// function _isDotted( srcPath )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   if( srcPath === this._hereStr )
//   return true;
//   if( srcPath === this._downStr )
//   return true;
//   if( _.strBegins( srcPath, this._hereStr + this._upStr ) )
//   return true;
//   if( _.strBegins( srcPath, this._downStr + this._upStr ) )
//   return true;
//   return false;
// }
//
// //
//
// function isDotted( srcPath )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   if( this._isDotted( srcPath ) )
//   return true;
//   /* qqq : cover all casess */
//   if( _.strBegins( srcPath, this._hereStr + '\\' ) )
//   return true;
//   if( _.strBegins( srcPath, this._downStr + '\\' ) )
//   return true;
//   return false;
// }
//
// //
//
// function isTrailed( srcPath )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   if( srcPath === this._rootStr )
//   return false;
//   return _.strEnds( srcPath,this._upStr );
// }

//

function isGlob( src )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( src ) );

  if( self.fileProvider && !self.fileProvider.globing )
  {
    return false;
  }

  if( !self._pathIsGlobRegexp )
  _setup();

  return self._pathIsGlobRegexp.test( src );

  function _setup()
  {
    let _pathIsGlobRegexpStr = '';
    _pathIsGlobRegexpStr += '(?:[?*]+)'; /* asterix,question mark */
    _pathIsGlobRegexpStr += '|(?:([!?*@+]*)\\((.*?(?:\\|(.*?))*)\\))'; /* parentheses */
    _pathIsGlobRegexpStr += '|(?:\\[(.+?)\\])'; /* square brackets */
    _pathIsGlobRegexpStr += '|(?:\\{(.*)\\})'; /* curly brackets */
    _pathIsGlobRegexpStr += '|(?:\0)'; /* zero */
    self._pathIsGlobRegexp = new RegExp( _pathIsGlobRegexpStr );
  }

}

//

function hasSymbolBase( srcPath )
{
  return _.strHasAny( srcPath, [ '\0', '()' ] );
}

// // //
// //
// // function begins( srcPath,beginPath )
// // {
// //   _.assert( arguments.length === 2, 'Expects two arguments' );
// //   _.assert( _.strIs( srcPath ), 'Expects string {-srcPath-}, but got', _.strType( srcPath ) );
// //   _.assert( _.strIs( beginPath ), 'Expects string {-beginPath-}, but got', _.strType( beginPath ) );
// //   if( srcPath === beginPath )
// //   return true;
// //   return _.strBegins( srcPath,this.trail( beginPath ) );
// // }
// //
// // //
// //
// // function ends( srcPath,endPath )
// // {
// //   _.assert( arguments.length === 2, 'Expects two arguments' );
// //   endPath = this.undot( endPath );
// //
// //   if( !_.strEnds( srcPath,endPath ) )
// //   return false;
// //
// //   let begin = _.strRemoveEnd( srcPath,endPath );
// //   if( begin === '' || _.strEnds( begin,this._upStr ) || _.strEnds( begin,this._hereStr ) )
// //   return true;
// //
// //   return false;
// // }
//
// // --
// // reformer
// // --
//
// /**
//   * The routine refine() regularize a Windows paths to posix path format by replacing left slashes to slash ( \\ to / ).
//   * If the path has a disk label, the routine puts slash '/' before and after the disk label.
//   * If the path is an empty string, method returns ''. Otherwise, routine returns original path.
//   *
//   * @param {string} src - path for refinement.
//   *
//   * @example
//   *  // returns '/foo//bar/../';
//   *  let path = '\\foo\\\\bar\\..\\';
//   *  path = wTools.refine( path );
//   *
//   * @example
//   *  // returns '/C/temp//foo/bar/../';
//   *  let path = 'C:\\temp\\\\foo\\bar\\..\\';
//   *  path = wTools.refine( path );
//   *
//   * @example
//   *  // returns '';
//   *  let path = '';
//   *  path = wTools.refine( path );
//   *
//   * @example
//   *  // returns '/foo/bar/';
//   *  let path = '/foo/bar/';
//   *  path = wTools.refine( path );
//   *
//   * @returns {string} Returns refined path.
//   * @throws {Error} If {-arguments.length-} is less or more then one.
//   * @throws {Error} If passed argument is not a string.
//   * @function refine
//   * @memberof module:Tools/PathBasic.wTools.path
//   */
//
// function refine( src )
// {
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( src ) );
//
//   let result = src;
//
//   if( result[ 1 ] === ':' )
//   {
//     if( result[ 2 ] === '\\' || result[ 2 ] === '/' )
//     {
//       if( result.length > 3 )
//       result = '/' + result[ 0 ] + '/' + result.substring( 3 );
//       else
//       result = '/' + result[ 0 ]
//     }
//     else if( result.length === 2 )
//     {
//       result = '/' + result[ 0 ];
//     }
//   }
//
//   result = result.replace( /\\/g, '/' );
//
//   return result;
// }
//
// //
//
// function _normalize( o )
// {
//   // let debug = 0;
//   // if( 0 )
//   // debug = 1;
//
//   _.assertRoutineOptions( _normalize, arguments );
//   _.assert( _.strIs( o.src ), 'Expects string' );
//
//   if( !o.src.length )
//   return '';
//
//   let result = o.src;
//
//   result = this.refine( result );
//
//   // if( debug )
//   // console.log( 'normalize.refined : ' + result );
//
//   /* detrailing */
//
//   if( o.tolerant )
//   {
//     /* remove "/" duplicates */
//     result = result.replace( this._delUpDupRegexp, this._upStr );
//   }
//
//   let endsWithUp = false;
//   let beginsWithHere = false;
//
//   /* remove right "/" */
//
//   if( result !== this._upStr && !_.strEnds( result, this._upStr + this._upStr ) && _.strEnds( result, this._upStr ) )
//   {
//     endsWithUp = true;
//     result = _.strRemoveEnd( result, this._upStr );
//   }
//
//   /* undoting */
//
//   while( !_.strBegins( result, this._hereUpStr + this._upStr ) && _.strBegins( result, this._hereUpStr ) )
//   {
//     beginsWithHere = true;
//     result = _.strRemoveBegin( result, this._hereUpStr );
//   }
//
//   /* remove second "." */
//
//   if( result.indexOf( this._hereStr ) !== -1 )
//   {
//
//     while( this._delHereRegexp.test( result ) )
//     result = result.replace( this._delHereRegexp, function( match, postSlash )
//     {
//       return postSlash || '';
//     });
//     if( result === '' )
//     result = this._upStr;
//
//   }
//
//   /* remove .. */
//
//   if( result.indexOf( this._downStr ) !== -1 )
//   {
//
//     while( this._delDownRegexp.test( result ) )
//     result = result.replace( this._delDownRegexp, ( match, notBegin, split, preSlash, postSlash ) =>
//     {
//       if( preSlash === '' )
//       return notBegin;
//       if( !notBegin )
//       return notBegin + preSlash;
//       else
//       return notBegin + ( postSlash || '' );
//     });
//
//   }
//
//   /* nothing left */
//
//   if( !result.length )
//   result = '.';
//
//   /* dot and trail */
//
//   if( o.detrailing )
//   if( result !== this._upStr && !_.strEnds( result, this._upStr + this._upStr ) )
//   result = _.strRemoveEnd( result, this._upStr );
//
//   if( !o.detrailing && endsWithUp )
//   if( result !== this._rootStr )
//   result = result + this._upStr;
//
//   if( !o.undoting && beginsWithHere )
//   result = this._dot( result );
//
//   // if( debug )
//   // console.log( 'normalize.result : ' + result );
//
//   return result;
// }
//
// _normalize.defaults =
// {
//   src : null,
//   tolerant : false,
//   detrailing : false,
//   undoting : false,
// }
//
// //
//
// /**
//  * Regularize a path by collapsing redundant delimeters and resolving '..' and '.' segments,so A//B,A/./B and
//     A/foo/../B all become A/B. This string manipulation may change the meaning of a path that contains symbolic links.
//     On Windows,it converts forward slashes to backward slashes. If the path is an empty string,method returns '.'
//     representing the current working directory.
//  * @example
//    let path = '/foo/bar//baz1/baz2//some/..'
//    path = wTools.normalize( path ); // /foo/bar/baz1/baz2
//  * @param {string} src path for normalization
//  * @returns {string}
//  * @function normalize
//  * @memberof module:Tools/PathBasic.wTools.path
//  */
//
// function normalize( src )
// {
//   let result = this._normalize({ src, tolerant : false, detrailing : false, undoting : false });
//
//   _.assert( _.strIs( src ), 'Expects string' );
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( result.lastIndexOf( this._upStr + this._hereStr + this._upStr ) === -1 );
//   _.assert( !_.strEnds( result, this._upStr + this._hereStr ) );
//
//   if( Config.debug )
//   {
//     let i = result.lastIndexOf( this._upStr + this._downStr + this._upStr );
//     _.assert( i === -1 || !/\w/.test( result.substring( 0, i ) ) );
//   }
//
//   return result;
// }
//
// //
//
// function normalizeTolerant( src )
// {
//   _.assert( _.strIs( src ),'Expects string' );
//
//   let result = this._normalize({ src, tolerant : true, detrailing : false, undoting : false });
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( result === this._upStr || _.strEnds( result, this._upStr ) || !_.strEnds( result, this._upStr + this._upStr ) );
//   _.assert( result.lastIndexOf( this._upStr + this._hereStr + this._upStr ) === -1 );
//   _.assert( !_.strEnds( result, this._upStr + this._hereStr ) );
//
//   if( Config.debug )
//   {
//     _.assert( !this._delUpDupRegexp.test( result ) );
//   }
//
//   return result;
// }
//
// //
//
// function canonize( src )
// {
//   let result = this._normalize({ src, tolerant : false, detrailing : true, undoting : true });
//
//   _.assert( _.strIs( src ), 'Expects string' );
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( result === this._upStr || _.strEnds( result, this._upStr + this._upStr ) || !_.strEnds( result, this._upStr ) );
//   _.assert( result.lastIndexOf( this._upStr + this._hereStr + this._upStr ) === -1 );
//   _.assert( !_.strEnds( result, this._upStr + this._hereStr ) );
//
//   if( Config.debug )
//   {
//     let i = result.lastIndexOf( this._upStr + this._downStr + this._upStr );
//     _.assert( i === -1 || !/\w/.test( result.substring( 0, i ) ) );
//   }
//
//   return result;
// }
//
// //
//
// function canonizeTolerant( src )
// {
//   _.assert( _.strIs( src ),'Expects string' );
//
//   let result = this._normalize({ src, tolerant : true, detrailing : true, undoting : true });
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( result === this._upStr || _.strEnds( result, this._upStr ) || !_.strEnds( result, this._upStr + this._upStr ) );
//   _.assert( result.lastIndexOf( this._upStr + this._hereStr + this._upStr ) === -1 );
//   _.assert( !_.strEnds( result, this._upStr + this._hereStr ) );
//
//   if( Config.debug )
//   {
//     _.assert( !this._delUpDupRegexp.test( result ) );
//   }
//
//   return result;
// }
//
// //
//
// function _nativizeWindows( filePath )
// {
//   let self = this;
//   _.assert( _.strIs( filePath ), 'Expects string' ) ;
//   let result = filePath.replace( /\//g, '\\' );
//
//   if( result[ 0 ] === '\\' )
//   if( result.length === 2 || result[ 2 ] === ':' || result[ 2 ] === '\\' )
//   result = result[ 1 ] + ':' + result.substring( 2 );
//
//   return result;
// }
//
// //
//
// function _nativizePosix( filePath )
// {
//   let self = this;
//   _.assert( _.strIs( filePath ), 'Expects string' );
//   return filePath;
// }
//
// //
//
// function nativize()
// {
//   if( _global.process && _global.process.platform === 'win32' )
//   this.nativize = this._nativizeWindows;
//   else
//   this.nativize = this._nativizePosix;
//   return this.nativize.apply( this, arguments );
// }

// --
// transformer
// --


//
// //
//
// function _dot( filePath )
// {
//
//   if( !this._isDotted( filePath ) )
//   {
//     _.assert( !_.strBegins( filePath, this._upStr ) );
//     filePath = this._hereUpStr + filePath;
//   }
//
//   return filePath;
// }
//
// //
//
// function dot( filePath )
// {
//
//   /*
//     cant use isAbsolute
//   */
//
//   _.assert( !_.strBegins( filePath, this._upStr ) );
//   _.assert( arguments.length === 1 );
//
//   /*
//     not .
//     not begins with ./
//     not ..
//     not begins with ../
//   */
//
//   // if( filePath !== this._hereStr && !_.strBegins( filePath, this._hereUpStr ) && filePath !== this._downStr && !_.strBegins( filePath, this._downUpStr ) )
//   if( !this.isDotted( filePath ) )
//   {
//     _.assert( !_.strBegins( filePath, this._upStr ) );
//     filePath = this._hereUpStr + filePath;
//   }
//
//   return filePath;
// }
//
// //
//
// function undot( filePath )
// {
//   return _.strRemoveBegin( filePath, this._hereUpStr );
// }
//
// //
//
// function trail( srcPath )
// {
//   _.assert( this.is( srcPath ) );
//   _.assert( arguments.length === 1 );
//
//   if( !_.strEnds( srcPath,this._upStr ) )
//   return srcPath + this._upStr;
//
//   return srcPath;
// }
//
// //
//
// function detrail( path )
// {
//   _.assert( this.is( path ) );
//   _.assert( arguments.length === 1 );
//
//   if( path !== this._rootStr )
//   return _.strRemoveEnd( path,this._upStr );
//
//   return path;
// }
//
// //
//
// /**
//  * Returns the directory name of `path`.
//  * @example
//  * let path = '/foo/bar/baz/text.txt'
//  * wTools.dir( path ); // '/foo/bar/baz'
//  * @param {string} path path string
//  * @returns {string}
//  * @throws {Error} If argument is not string
//  * @function dir
//  * @memberof module:Tools/PathBasic.wTools.path
//  */
//
// function dir_pre( routine, args )
// {
//   let o = args[ 0 ];
//   if( _.strIs( o ) )
//   o = { filePath : args[ 0 ], depth : args[ 1 ] };
//
//   _.routineOptions( routine, o );
//   _.assert( args.length === 1 || args.length === 2 );
//   _.assert( arguments.length === 2 );
//   _.assert( _.intIs( o.depth ) );
//   _.assert( _.strDefined( o.filePath ), 'Expects not empty string {- o.filePath -}' );
//
//   return o;
// }
//
// function dir_body( o )
// {
//   let self = this;
//   let isTrailed = this.isTrailed( o.filePath );
//
//   _.assertRoutineOptions( dir_body, arguments );
//
//   if( o.first )
//   o.filePath = this.normalize( o.filePath );
//   else
//   o.filePath = this.canonize( o.filePath );
//
//   if( o.first )
//   if( isTrailed )
//   return o.filePath;
//
//   if( o.filePath === this._rootStr )
//   {
//     return o.filePath + this._downStr + ( o.first ? this._upStr : '' );
//   }
//
//   if( _.strEnds( o.filePath, this._upStr + this._downStr ) || o.filePath === this._downStr )
//   {
//     return o.filePath + this._upStr + this._downStr + ( o.first ? this._upStr : '' );
//   }
//
//   let i = o.filePath.lastIndexOf( this._upStr );
//
//   if( i === 0 )
//   {
//     return this._rootStr;
//   }
//
//   if( i === -1 )
//   {
//     if( o.first )
//     {
//       if( o.filePath === this._hereStr )
//       return this._downStr + this._upStr;
//       else
//       return this._hereStr + this._upStr;
//     }
//     else
//     {
//       if( o.filePath === this._hereStr )
//       return this._downStr + ( isTrailed ? this._upStr : '' );
//       else
//       return this._hereStr + ( isTrailed ? this._upStr : '' );
//     }
//   }
//
//   let result;
//
//   if( o.first )
//   result = o.filePath.substr( 0, i + self._upStr.length );
//   else
//   result = o.filePath.substr( 0, i );
//
//   if( !o.first )
//   if( isTrailed )
//   result = _.strAppendOnce( result, self._upStr );
//
//   _.assert( !!result.length )
//
//   return result;
// }
//
// dir_body.defaults =
// {
//   filePath : null,
//   first : 0,
//   depth : 1,
// }
//
// let dir = _.routineFromPreAndBody( dir_pre, dir_body );
// dir.defaults.first = 0;
//
// let dirFirst = _.routineFromPreAndBody( dir_pre, dir_body );
// dirFirst.defaults.first = 1;
//
// /* qqq2 : implement and cover option depth. ask how */

//

/**
 * Returns dirname + filename without extension
 * @example
 * _.path.prefixGet( '/foo/bar/baz.ext' ); // '/foo/bar/baz'
 * @param {string} path Path string
 * @returns {string}
 * @throws {Error} If passed argument is not string.
 * @function prefixGet
 * @memberof module:Tools/PathBasic.wTools.path
 */

function prefixGet( path )
{

  _.assert( _.strIs( path ), 'Expects string as path' );

  let n = path.lastIndexOf( '/' );
  if( n === -1 ) n = 0;

  let parts = [ path.substr( 0, n ),path.substr( n ) ];

  n = parts[ 1 ].indexOf( '.' );
  if( n === -1 )
  n = parts[ 1 ].length;

  let result = parts[ 0 ] + parts[ 1 ].substr( 0,n );

  return result;
}

//

/**
 * Returns path name (file name).
 * @example
 * wTools.name( '/foo/bar/baz.asdf' ); // 'baz'
 * @param {string|object} path|o Path string,or options
 * @param {boolean} o.full if this parameter set to true method return name with extension.
 * @returns {string}
 * @throws {Error} If passed argument is not string
 * @function name
 * @memberof module:Tools/PathBasic.wTools.path
 */

function name_pre( routine, args )
{
  let o = args[ 0 ];
  if( _.strIs( o ) )
  o = { path : o };

  _.routineOptions( routine, o );
  _.assert( args.length === 1 );
  _.assert( arguments.length === 2 );
  _.assert( _.strIs( o.path ), 'Expects string {-o.path-}' );

  return o;
}

function name_body( o )
{

  if( _.strIs( o ) )
  o = { path : o };

  _.assertRoutineOptions( name, arguments );

  o.path = this.canonize( o.path );

  let i = o.path.lastIndexOf( '/' );
  if( i !== -1 )
  o.path = o.path.substr( i+1 );

  if( !o.full )
  {
    let i = o.path.lastIndexOf( '.' );
    if( i !== -1 ) o.path = o.path.substr( 0, i );
  }

  return o.path;
}

name_body.defaults =
{
  path : null,
  full : 0,
}

let name = _.routineFromPreAndBody( name_pre, name_body );
name.defaults.full = 0;

let fullName = _.routineFromPreAndBody( name_pre, name_body );
fullName.defaults.full = 1;

//

/**
 * Return path without extension.
 * @example
 * wTools.withoutExt( '/foo/bar/baz.txt' ); // '/foo/bar/baz'
 * @param {string} path String path
 * @returns {string}
 * @throws {Error} If passed argument is not string
 * @function withoutExt
 * @memberof module:Tools/PathBasic.wTools.path
 */

function withoutExt( path )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( path ), 'Expects string' );

  let name = _.strIsolateRightOrNone( path,'/' )[ 2 ] || path;

  let i = name.lastIndexOf( '.' );
  if( i === -1 || i === 0 )
  return path;

  let halfs = _.strIsolateRightOrNone( path,'.' );
  return halfs[ 0 ];
}

//

/**
 * Returns file extension of passed `path` string.
 * If there is no '.' in the last portion of the path returns an empty string.
 * @example
 * _.path.ext( '/foo/bar/baz.ext' ); // 'ext'
 * @param {string} path path string
 * @returns {string} file extension
 * @throws {Error} If passed argument is not string.
 * @function ext
 * @memberof module:Tools/PathBasic.wTools.path
 */

function ext( path )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( path ), 'Expects string {-path-}, but got', _.strType( path ) );

  let index = path.lastIndexOf( '/' );
  if( index >= 0 )
  path = path.substr( index+1, path.length-index-1  );

  index = path.lastIndexOf( '.' );
  if( index === -1 || index === 0 )
  return '';

  index += 1;

  return path.substr( index, path.length-index ).toLowerCase();
}

//

/*
qqq : not covered by tests | Dmytro : covered
*/

function exts( path )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( path ), 'Expects string {-path-}, but got', _.strType( path ) );

  path = this.name({ path,full : 1 });

  let exts = path.split( '.' );
  exts.splice( 0, 1 );
  exts = _.entityFilter( exts , ( e ) => !e ? undefined : e.toLowerCase() );

  return exts;
}

//

/**
 * Replaces existing path extension on passed in `ext` parameter. If path has no extension,adds passed extension
    to path.
 * @example
 * wTools.changeExt( '/foo/bar/baz.txt', 'text' ); // '/foo/bar/baz.text'
 * @param {string} path Path string
 * @param {string} ext
 * @returns {string}
 * @throws {Error} If passed argument is not string
 * @function changeExt
 * @memberof module:Tools/PathBasic.wTools.path
 */

// qqq : extend tests | Dmytro : coverage is extended

function changeExt( path, ext )
{

  if( arguments.length === 2 )
  {
    _.assert( _.strIs( ext ) );
  }
  else if( arguments.length === 3 )
  {
    let sub = arguments[ 1 ];
    // let ext = arguments[ 2 ]; // Dmytro : it's local variable, uses in assertion below and has no sense in routine
    ext = arguments[ 2 ];

    _.assert( _.strIs( sub ) );
    _.assert( _.strIs( ext ) );

    let cext = this.ext( path );

    if( cext !== sub )
    return path;
  }
  else
  {
    _.assert( 0, 'Expects 2 or 3 arguments' );
  }

  if( ext === '' )
  return this.withoutExt( path );
  else
  return this.withoutExt( path ) + '.' + ext;

}

//

function _pathsChangeExt( src )
{
  _.assert( _.longIs( src ) );
  _.assert( src.length === 2 );

  return changeExt.apply( this,src );
}

// --
// joiner
// --

/**
 * Joins filesystem paths fragments or urls fragment into one path/url. Uses '/' level delimeter.
 * @param {Object} o join o.
 * @param {String[]} p.paths - Array with paths to join.
 * @param {boolean} [o.reroot=false] If this parameter set to false (by default), method joins all elements in
 * `paths` array,starting from element that begins from '/' character,or '* :', where '*' is any drive name. If it
 * is set to true,method will join all elements in array. Result
 * @returns {string}
 * @private
 * @throws {Error} If missed arguments.
 * @throws {Error} If elements of `paths` are not strings
 * @throws {Error} If o has extra parameters.
 * @function join_body
 * @memberof module:Tools/PathBasic.wTools.path
 */

function join_pre( routine, args )
{
  _.assert( args.length > 0, 'Expects argument' )
  let o = { paths : args };

  _.routineOptions( routine, o );
  //_.assert( o.paths.length > 0 );
  _.assert( _.boolLike( o.reroot ) );
  _.assert( _.boolLike( o.allowingNull ) );
  _.assert( _.boolLike( o.raw ) );

  return o;
}

function join_body( o )
{
  let self = this;
  let result = null;
  let prepending = true;

  /* */

  if( Config.debug )
  for( let a = o.paths.length-1 ; a >= 0 ; a-- )
  {
    let src = o.paths[ a ];
    _.assert( _.strIs( src ) || src === null, () => 'Expects strings as path arguments, but #' + a + ' argument is ' + _.strType( src ) );
  }

  /* */

  for( let a = o.paths.length-1 ; a >= 0 ; a-- )
  {
    let src = o.paths[ a ];

    if( o.allowingNull )
    if( src === null )
    break;

    if( result === null )
    result = '';

    _.assert( _.strIs( src ), () => `Expects strings as path arguments, but #${a} argument is ${_.strType( src )}` );

    if( !prepend( src ) )
    break;

  }

  /* */

  if( !o.raw && result !== null )
  result = self.normalize( result );

  return result;

  /* */

  function prepend( src )
  {
    let trailed = false;
    let endsWithUp = false;

    if( src )
    src = self.refine( src );

    if( !src )
    return true;

    // src = src.replace( /\\/g, self._upStr );

    // if( result )
    if( _.strEnds( src, self._upStr ) )
    // if( _.strEnds( src, self._upStr ) && !_.strEnds( src, self._upStr + self._upStr ) )
    // if( src.length > 1 || result[ 0 ] === self._upStr )
    {
      if( src.length > 1 )
      {
        if( result )
        src = src.substr( 0, src.length-1 );
        trailed = true;

        if( result === self._downStr )
        result = self._hereStr;
        else if( result === self._downUpStr )
        result = self._hereUpStr;
        else
        result = _.strRemoveBegin( result, self._downUpStr );

      }
      else
      {
        endsWithUp = true;
      }
    }

    if( src && result )
    if( !endsWithUp && !_.strBegins( result, self._upStr ) )
    result = self._upStr + result;

    result = src + result;

    if( !o.reroot )
    {
      if( _.strBegins( result, self._rootStr ) )
      return false;
    }

    return true;
  }

}

join_body.defaults =
{
  paths : null,
  reroot : 0,
  allowingNull : 1,
  raw : 0,
}

//

/**
 * Method joins all `paths` together,beginning from string that starts with '/', and normalize the resulting path.
 * @example
 * let res = wTools.join( '/foo', 'bar', 'baz', '.');
 * // '/foo/bar/baz'
 * @param {...string} paths path strings
 * @returns {string} Result path is the concatenation of all `paths` with '/' directory delimeter.
 * @throws {Error} If one of passed arguments is not string
 * @function join
 * @memberof module:Tools/PathBasic.wTools.path
 */

let join = _.routineFromPreAndBody( join_pre, join_body );

//

let joinRaw = _.routineFromPreAndBody( join_pre, join_body );
joinRaw.defaults.raw = 1;

// function join()
// {
//
//   let result = this.join_body
//   ({
//     paths : arguments,
//     reroot : 0,
//     allowingNull : 1,
//     raw : 0,
//   });
//
//   return result;
// }

//

// function joinRaw_body( o )
// {
//   let result = this.join.body( o );
//
//   return result;
// }
//
// joinRaw_body.defaults =
// {
//   paths : null,
//   reroot : 0,
//   allowingNull : 1,
//   raw : 1,
// }

// function joinRaw()
// {
//
//   let result = this.join_body
//   ({
//     paths : arguments,
//     reroot : 0,
//     allowingNull : 1,
//     raw : 1,
//   });
//
//   return result;
// }

//

function joinIfDefined()
{
  let args = _.filter( arguments, ( arg ) => arg );
  if( !args.length )
  return;
  return this.join.apply( this,args );
}

//

function joinCross()
{

  if( _.longHasDepth( arguments ) )
  {
    let result = [];

    let samples = _.eachSample( arguments );
    for( var s = 0 ; s < samples.length ; s++ )
    result.push( this.join.apply( this,samples[ s ] ) );
    return result;

  }

  return this.join.apply( this,arguments );
}

//

/**
 * Method joins all `paths` strings together.
 * @example
 * let res = wTools.reroot( '/foo', '/bar/', 'baz', '.');
 * // '/foo/bar/baz/.'
 * @param {...string} paths path strings
 * @returns {string} Result path is the concatenation of all `paths` with '/' directory delimeter.
 * @throws {Error} If one of passed arguments is not string
 * @function reroot
 * @memberof module:Tools/PathBasic.wTools.path
 */

let reroot = _.routineFromPreAndBody( join_pre, join_body );
reroot.defaults =
{
  paths : arguments,
  reroot : 1,
  allowingNull : 1,
  raw : 0,
}

// function reroot()
// {
//   let result = this.join_body
//   ({
//     paths : arguments,
//     reroot : 1,
//     allowingNull : 1,
//     raw : 0,
//   });
//   return result;
// }

//

/**
 * Method resolves a sequence of paths or path segments into an absolute path.
 * The given sequence of paths is processed from right to left,with each subsequent path prepended until an absolute
 * path is constructed. If after processing all given path segments an absolute path has not yet been generated,
 * the current working directory is used.
 * @example
 * let absPath = wTools.resolve('work/wFiles'); // '/home/user/work/wFiles';
 * @param [...string] paths A sequence of paths or path segments
 * @returns {string}
 * @function resolve
 * @memberof module:Tools/PathBasic.wTools.path
 */

function resolve()
{
  let path;

  _.assert( arguments.length > 0 );

  path = this.join.apply( this, arguments );

  if( path === null )
  return path;
  else if( !this.isAbsolute( path ) )
  path = this.join( this.current(), path );

  path = this.normalize( path );

  _.assert( path.length > 0 );

  return path;
}

//

function joinNames()
{

  // Variables

  let prefixs = [];         // Prefixes array
  let names = [];           // Names array
  let exts = [];            // Extensions array
  let extsBool = false;     // Check if there are extensions
  let prefixBool = false;   // Check if there are prefixes
  let start = -1;           // Index of the starting prefix
  let numStarts = 0;        // Number of starting prefixes
  let numNull = 0;          // Number of null prefixes
  let longerI = -1;         // Index of the longest prefix
  let maxPrefNum = 0;       // Length of the longest prefix

  // Check input elements are strings
  if( Config.debug )
  for( let a = arguments.length-1 ; a >= 0 ; a-- )
  {
    let src = arguments[ a ];
    _.assert( _.strIs( src ) || src === null );
  }

  for( let a = arguments.length-1 ; a >= 0 ; a-- ) // Loop over the arguments ( starting by the end )
  {
    let src = arguments[ a ];

    if( src === null )  // Null arg,break loop
    {
      prefixs.splice( 0,a + 1 );
      numNull = numNull + a + 1;
      break;
    }

    src = this.normalize(  src );

    let prefix = this.prefixGet( src );

    if( prefix.charAt( 0 ) === '/' )   // Starting prefix
    {
      prefixs[ a ] = src + '/';
      names[ a ] = '';
      exts[ a ] = '';
      start = a;
      numStarts = numStarts + 1;
    }
    else
    {
      names[ a ] = this.name( src );
      prefixs[ a ] = prefix.substring( 0,prefix.length - ( names[ a ].length + 1 ) );
      prefix = prefix.substring( 0,prefix.length - ( names[ a ].length ) );
      exts[ a ] = this.ext( src );

      if( prefix.substring( 0,2 ) === './')
      {
        prefixs[ a ] = prefixs[ a ].substring( 2 );
      }

      prefixs[ a ] = prefixs[ a ].split("/");

      let prefNum = prefixs[ a ].length;

      if( maxPrefNum < prefNum )
      {
        maxPrefNum = prefNum;
        longerI = a;
      }

      let empty = prefixs[ a ][ 0 ] === '' && names[ a ] === '' && exts[ a ] === '';

      if( empty && src.charAt( 0 ) === '.' )
      exts[ a ] = src.substring( 1 );

    }

    if( exts[ a ] !== '' )
    extsBool = true;

    if( prefix !== '' )
    prefixBool = true;

  }

  longerI = longerI - numStarts - numNull;

  let result = names.join( '' );

  if( prefixBool === true )
  {
    if( start !== -1 )
    {
      logger.log( prefixs,start)
      var first = prefixs.splice( start,1 );
    }

    for( let p = 0; p < maxPrefNum; p++ )
    {
      for( let j = prefixs.length - 1; j >= 0; j-- )
      {
        let pLong = prefixs[ longerI ][ maxPrefNum - 1 - p ];
        let pj = prefixs[ j ][ prefixs[ j ].length - 1 - p ];
        if( j !== longerI )
        {
          if( pj !== undefined && pLong !== undefined )
          {

            if( j < longerI )
            {
              prefixs[ longerI ][ maxPrefNum - 1 - p ] =  this.joinNames.apply( this, [ pj,pLong ] );
            }
            else
            {
              prefixs[ longerI ][ maxPrefNum - 1 - p ] =  this.joinNames.apply( this, [ pLong,pj ] );
            }
          }
          else if( pLong === undefined  )
          {
            prefixs[ longerI ][ maxPref - 1 - p ] =  pj;
          }
          else if( pj === undefined  )
          {
            prefixs[ longerI ][ maxPrefNum - 1 - p ] =  pLong;
          }
        }
      }
    }

    let pre = this.join.apply( this,prefixs[ longerI ] );
    result = this.join.apply( this, [ pre,result ] );

    if( start !== -1 )
    {
      result =  this.join.apply( this, [ first[ 0 ], result ] )
    }

  }

  if( extsBool === true )
  {
    result = result + '.' + exts.join( '' );
  }

  // qqq : what is normalize for?
  result = this.normalize( result );

  return result;
}

/*
function joinNames()
{
  let names = [];
  let exts = [];

  if( Config.debug )
  for( let a = arguments.length-1 ; a >= 0 ; a-- )
  {
    let src = arguments[ a ];
    _.assert( _.strIs( src ) || src === null );
  }

  for( let a = arguments.length-1 ; a >= 0 ; a-- )
  {
    let src = arguments[ a ];
    if( src === null )
    break;
    names[ a ] = this.name( src );
    exts[ a ] = src.substring( names[ a ].length );
  }

  let result = names.join( '' ) + exts.join( '' );

  return result;
}
*/

//

function _split( path )
{
  return path.split( this._upStr );
}

//

function split( path )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( path ), 'Expects string' )
  let result = this._split( this.refine( path ) );
  return result;
}

// --
// stater
// --

function current()
{
  _.assert( arguments.length === 0 );
  // return this._hereStr;
  return this._upStr;
}

//

function from( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.strIs( src ) )
  return src;
  else
  _.assert( 0, 'Expects string, but got ' + _.strType( src ) );

}

// --
// relator
// --

/**
* Returns a relative path to `path` from an `relative` path. This is a path computation : the filesystem is not
* accessed to confirm the existence or nature of path or start.

* * If `o.relative` and `o.path` each resolve to the same path method returns `.`.
* * If `o.resolving` is enabled -- paths `o.relative` and `o.path` are resolved before computation, uses result of {@link module:Tools/PathBasic.Path.current _.path.current} as base.
* * If `o.resolving` is disabled -- paths `o.relative` and `o.path` are not resolved and must be both relative or absolute.
*
* **Examples of how result is computed and how to chech the result:**
*
* Result is checked by a formula : from + result === to, where '+' means join operation {@link module:Tools/PathBasic.Path.join _.path.join}
*
* **Note** :
* * `from` -- `o.relative`
* * `to` -- `o.path`
* * `cd` -- current directory
*
* *Example #1*
*   ```
*   from : /a
*   to : /b
*   result : ../b
*   from + result = to : /a + ../b = /b
*   ```
* *Example #2*
*   ```
*   from : /
*   to : /b
*   result : ./b
*   from + result = to : / + ./b = /b
*   ```
* *Example #3*
*   ```
*   resolving : 0
*   from : ..
*   to : .
*   result : .
*   from + result = to : .. + . != .. <> . -- error because result doesn't satisfy the final check
*   from + result = to : .. + .. != ../.. <> . -- error because result doesn't satisfy the final check
*   ```
*
* *Example #4*
*   ```
*   resolving : 1
*   cd : /d -- current dir
*   from : .. -> /
*   to : . -> /d
*   result : ./d
*   from + result = to : / + ./d === /d
*   ```
*
* *Example #5*
*   ```
*   resolving : 0
*   from : ../a/b
*   to : ../c/d
*   result : ../../c/d
*   from + result = to : ../a/b + ../../c/d === ../c/d
*   ```
*
* *Example #6*
*   ```
*   resolving : 1
*   cd : /
*   from : ../a/b -> /../a/b
*   to : ../c/d -> /../c/d
*   from + result = to : /../a/b + /../../c/d === /../c/d -- error resolved "from" leads out of file system
*   ```
*
* *Example #7*
*   ```
*   resolving : 0
*   from : ..
*   to : ./a
*   result : ../a
*   from + result = to : .. + ../a != ./a -- error because result doesn't satisfy the final check
*   ```
* *Example #8*
*   ```
*   resolving : 1
*   cd : /
*   from : .. -> /..
*   to : ./a -> /a
*   result : /../a
*   from + result = to : .. + ../a != ./a -- error resolved "from" leads out of file system
*   ```
*
* @param {Object} [o] Options map.
* @param {String|wFileRecord} [o.relative] Start path.
* @param {String|String[]} [o.path] Targer path(s).
* @param {String|String[]} [o.resolving=0] Resolves {o.relative} and {o.path} before computation.
* @param {String|String[]} [o.dotted=1] Allows '.' as the result, otherwise returns empty string.
* @returns {String|String[]} Returns relative path as String or array of Strings.
* @throws {Exception} If {o.resolving} is enabled and {o.relative} or {o.path} leads out of file system.
* @throws {Exception} If result of computation doesn't satisfy formula: o.relative + result === o.path.
* @throws {Exception} If {o.relative} is not a string or wFileRecord instance.
* @throws {Exception} If {o.path} is not a string or array of strings.
* @throws {Exception} If both {o.relative} and {path} are not relative or absolute.
*
* @example
* let from = '/a';
* let to = '/b'
* _.path._relative({ relative : from, path : to, resolving : 0 });
* //'../b'
*
* @example
* let from = '../a/b';
* let to = '../c/d'
* _.path._relative({ relative : from, path : to, resolving : 0 });
* //'../../c/d'
*
* @example
* //resolving, assume that cd is : '/d'
* let from = '..';
* let to = '.'
* _.path._relative({ relative : from, path : to, resolving : 1 });
* //'./d'
*
* @function _relative
* @memberof module:Tools/PathBasic.wTools.path
*/

function _relative( o )
{
  let self = this;
  let result = '';
  // let basePath = this.from( o.basePath );
  // let filePath = this.from( o.filePath );

  o.basePath = this.from( o.basePath );
  o.filePath = this.from( o.filePath );

  _.assert( _.strIs( o.basePath ),'Expects string {-o.basePath-}, but got', _.strType( o.basePath ) );
  _.assert( _.strIs( o.filePath ) || _.arrayIs( o.filePath ) );
  _.assertRoutineOptions( _relative, arguments );

  if( o.resolving )
  {
    o.basePath = this.resolve( o.basePath );
    o.filePath = this.resolve( o.filePath );
  }
  else
  {
    o.basePath = this.normalize( o.basePath );
    o.filePath = this.normalize( o.filePath );
  }

  let basePath = o.basePath;
  let filePath = o.filePath;
  let baseIsAbsolute = self.isAbsolute( basePath );
  let fileIsAbsolute = self.isAbsolute( filePath );
  let baseIsTrailed = self.isTrailed( basePath );

  /* makes common style for relative paths, each should begin from './' */

  if( o.resolving )
  {

    basePath = this.resolve( basePath );
    filePath = this.resolve( filePath );

    _.assert( this.isAbsolute( basePath ) );
    _.assert( this.isAbsolute( filePath ) );

    _.assert
    (
        !_.strBegins( basePath, this._upStr + this._downStr )
      , 'Resolved o.basePath:', basePath, 'leads out of file system.'
    );
    _.assert
    (
        !_.strBegins( filePath, this._upStr + this._downStr )
      , 'Resolved o.filePath:', filePath, 'leads out of file system.'
    );

  }
  else
  {
    basePath = this.normalize( basePath );
    filePath = this.normalize( filePath );

    let baseIsAbsolute = this.isAbsolute( basePath );
    let fileIsAbsolute = this.isAbsolute( filePath );

    /* makes common style for relative paths, each should begin with './' */

    // if( !baseIsAbsolute && basePath !== this._hereStr )
    // basePath = _.strPrependOnce( basePath, this._hereUpStr );
    // if( !fileIsAbsolute && filePath !== this._hereStr )
    // filePath = _.strPrependOnce( filePath, this._hereUpStr );

    if( !baseIsAbsolute )
    basePath = _.strRemoveBegin( basePath, this._hereUpStr );
    if( !fileIsAbsolute )
    filePath = _.strRemoveBegin( filePath, this._hereUpStr );

    while( beginsWithDown( basePath ) )
    {
      if( !beginsWithDown( filePath ) )
      break;
      basePath = removeBeginDown( basePath );
      filePath = removeBeginDown( filePath );
    }

    _.assert
    (
        ( baseIsAbsolute && fileIsAbsolute ) || ( !baseIsAbsolute && !fileIsAbsolute )
      , 'Both paths must be either absolute or relative.'
    );

    _.assert
    (
        // basePath !== this._hereUpStr + this._downStr && !_.strBegins( basePath, this._hereUpStr + this._downUpStr )
        !beginsWithDown( basePath )
      , `Cant get path relative base path "${o.basePath}", it begins with "${this._downStr}"`
    );

    if( !baseIsAbsolute && basePath !== this._hereStr )
    basePath = _.strPrependOnce( basePath, this._hereUpStr );
    if( !fileIsAbsolute && filePath !== this._hereStr )
    filePath = _.strPrependOnce( filePath, this._hereUpStr );

  }

  _.assert( basePath.length > 0 );
  _.assert( filePath.length > 0 );

  /* extracts common filePath and checks if its a intermediate dir, otherwise cuts filePath and repeats the check*/

  let common = _.strCommonLeft( basePath, filePath );
  let commonTrailed = _.strAppendOnce( common, this._upStr );
  if
  (
        !_.strBegins( _.strAppendOnce( basePath, this._upStr ), commonTrailed )
    ||  !_.strBegins( _.strAppendOnce( filePath, this._upStr ), commonTrailed )
  )
  {
    common = this.dir( common );
  }

  /* - */

  /* gets count of up steps required to get to common dir */
  basePath = _.strRemoveBegin( basePath, common );
  filePath = _.strRemoveBegin( filePath, common );

  let basePath2 = _.strRemoveBegin( _.strRemoveEnd( basePath, this._upStr ), this._upStr );
  let count = _.strCount( basePath2, this._upStr );

  if( basePath === this._upStr || !basePath )
  count = 0;
  else
  count += 1;

  if( !_.strBegins( filePath, this._upStr + this._upStr ) && common !== this._upStr )
  filePath = _.strRemoveBegin( filePath, this._upStr );

  /* prepends up steps */
  if( filePath || count === 0 )
  result = _.strDup( this._downUpStr, count ) + filePath;
  else
  result = _.strDup( this._downUpStr, count-1 ) + this._downStr;

  /* removes redundant slash at the end */
  if( _.strEnds( result, this._upStr ) )
  _.assert( result.length > this._upStr.length );

  if( result === '' )
  result = this._hereStr;

  if( _.strEnds( o.filePath, this._upStr ) && !_.strEnds( result, this._upStr ) )
  if( o.basePath !== this._rootStr )
  result = result + this._upStr;

  if( baseIsTrailed )
  {
    if( result === this._hereStr )
    result = this._hereStr;
    else if( result === this._hereUpStr )
    result = this._hereUpStr;
    else
    result = this._hereUpStr + result;
  }

  /* checks if result is normalized */

  _.assert( result.length > 0 );
  _.assert( result.lastIndexOf( this._upStr + this._hereStr + this._upStr ) === -1 );
  _.assert( !_.strEnds( result, this._upStr + this._hereStr ) );

  if( Config.debug )
  {
    let i = result.lastIndexOf( this._upStr + this._downStr + this._upStr );
    _.assert( i === -1 || !/\w/.test( result.substring( 0, i ) ) );
    if( o.resolving )
    _.assert
    (
        this.undot( this.resolve( o.basePath, result ) ) === this.undot( o.filePath )
      , () => o.basePath + ' + ' + result + ' <> ' + o.filePath
    );
    else
    _.assert
    (
        this.undot( this.join( o.basePath, result ) ) === this.undot( o.filePath )
      , () => o.basePath + ' + ' + result + ' <> ' + o.filePath
    );
  }

  return result;

  function beginsWithDown( filePath )
  {
    return filePath === self._downStr || _.strBegins( filePath, self._downUpStr );
  }

  function removeBeginDown( filePath )
  {
    if( filePath === self._downStr )
    return self._hereStr;
    return _.strRemoveBegin( filePath, self._downUpStr );
  }

}

_relative.defaults =
{
  basePath : null,
  filePath : null,
  resolving : 0,
}

//

/**
* Short-cut for routine relative {@link module:Tools/PathBasic.Path._relative _.path._relative}.
* Returns a relative path to `path` from an `relative`. Does not resolve paths {o.relative} and {o.path} before computation.
*
* @param {string|wFileRecord} relative Start path.
* @param {string|string[]} path Target path(s).
* @returns {string|string[]} Returns relative path as String or array of Strings.
* For more details please see {@link module:Tools/PathBasic.Path._relative _.path._relative}.
*
* @example
* let from = '/a';
* let to = '/b'
* _.path.relative( from, to );
* //'../b'
*
* @example
* let from = '/';
* let to = '/b'
* _.path.relative( from, to );
* //'./b'
*
* @example
* let from = '/a/b';
* let to = '/c'
* _.path.relative( from, to );
* //'../../c'
*
* @example
* let from = '/a';
* let to = './b'
* _.path.relative( from, to ); // throws an error paths have different type
*
* @example
* let from = '.';
* let to = '..'
* _.path.relative( from, to );
* //'..'
*
* @example
* let from = '..';
* let to = '..'
* _.path.relative( from, to );
* //'.'
*
* @example
* let from = '../a/b';
* let to = '../c/d'
* _.path.relative( from, to );
* //'../../c/d'
*
* @function relative
* @memberof module:Tools/PathBasic.wTools.path
*/

function relative_pre( routine, args )
{
  let o = args[ 0 ];
  if( args[ 1 ] !== undefined )
  o = { basePath : args[ 0 ], filePath : args[ 1 ] }

  _.routineOptions( routine, o );
  _.assert( args.length === 1 || args.length === 2 );
  _.assert( arguments.length === 2 );

  return o;
}

//

function relative_body( o )
{
  return this._relative( o );
}

relative_body.defaults = Object.create( _relative.defaults );

let relative = _.routineFromPreAndBody( relative_pre, relative_body );

//

function relativeCommon()
{
  let commonPath = this.common( filePath );
  let relativePath = [];

  for( let i = 0 ; i < filePath.length ; i++ )
  relativePath[ i ] = this.relative( commonPath,filePath[ i ] );

  return relativePath;
}

//

function _commonPair( src1, src2 )
{
  let self = this;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( src1 ) && _.strIs( src2 ) );

  let result = [];
  let first = parsePath( src1 );
  let second = parsePath( src2 );

  let needToSwap = first.isRelative && second.isAbsolute;
  if( needToSwap )
  {
    let tmp = second;
    second = first;
    first = tmp;
  }

  let bothAbsolute = first.isAbsolute && second.isAbsolute;
  let bothRelative = first.isRelative && second.isRelative;
  let absoluteAndRelative = first.isAbsolute && second.isRelative;

  if( absoluteAndRelative )
  {
    if( first.splitted.length > 3 || first.splitted[ 0 ] !== '' || first.splitted[ 2 ] !== '' || first.splitted[ 1 ] !== '/' )
    {
      debugger;
      throw _.err( 'Incompatible paths.' );
    }
    else
    return '/';
  }

  if( bothAbsolute )
  {
    getCommon();

    result = result.join('');

    if( !result.length )
    result = '/';
  }

  if( bothRelative )
  {

    if( first.levelsDown === second.levelsDown )
    getCommon();

    result = result.join('');

    let levelsDown = Math.max( first.levelsDown,second.levelsDown );

    if( levelsDown > 0 )
    {
      debugger;
      let prefix = _.longFill( [], self._downStr, levelsDown );
      // let prefix = _.longFillTimes( [], levelsDown,self._downStr );
      prefix = prefix.join( '/' );
      result = prefix + result;
    }

    if( !result.length )
    {
      if( first.isRelativeHereThen && second.isRelativeHereThen )
      result = self._hereStr;
      else
      result = '.';
    }
  }

  return result;

  /* - */

  function getCommon()
  {
    let length = Math.min( first.splitted.length,second.splitted.length );
    for( let i = 0; i < length; i++ )
    {
      if( first.splitted[ i ] === second.splitted[ i ] )
      {
        if( first.splitted[ i ] === self._upStr && first.splitted[ i + 1 ] === self._upStr )
        break;
        else
        result.push( first.splitted[ i ] );
      }
      else
      break;
    }
  }

  function parsePath( path )
  {
    let result =
    {
      isRelativeDown : false,
      isRelativeHereThen : false,
      isRelativeHere : false,
      levelsDown : 0,
    };

    // result.normalized = self.normalizeTolerant( path );
    result.normalized = self.normalize( path );
    result.splitted = split( result.normalized );
    result.isAbsolute = self.isAbsolute( result.normalized );
    result.isRelative = !result.isAbsolute;

    if( result.isRelative )
    if( result.splitted[ 0 ] === self._downStr )
    {
      result.levelsDown = _.longCountElement( result.splitted,self._downStr );
      debugger;
      let substr = _.longFill( [], self._downStr, result.levelsDown ).join( '/' );
      // let substr = _.longFillTimes( [], result.levelsDown,self._downStr ).join( '/' );
      let withoutLevels = _.strRemoveBegin( result.normalized,substr );
      result.splitted = split( withoutLevels );
      result.isRelativeDown = true;
    }
    else if( result.splitted[ 0 ] === '.' )
    {
      result.splitted = result.splitted.splice( 2 );
      result.isRelativeHereThen = true;
    }
    else
    result.isRelativeHere = true;

    return result;
  }

  function split( src )
  {
    return _.strSplitFast( { src,delimeter : [ '/' ], preservingDelimeters : 1,preservingEmpty : 1 } );
  }

}

//

/*
qqq : teach common to work with path maps and cover it by tests
*/

function common()
{

  let paths = _.arrayFlatten( null, arguments );

  for( let s = 0 ; s < paths.length ; s++ )
  {
    if( _.mapIs( paths[ s ] ) )
    paths.splice( s, 1, _.mapKeys( paths[ s ] ) );
  }

  _.assert( _.strsAreAll( paths ) );

  if( !paths.length )
  return null;

  paths.sort( function( a,b )
  {
    return b.length - a.length;
  });

  let result = paths.pop();

  for( let i = 0, len = paths.length ; i < len ; i++ )
  result = this._commonPair( paths[ i ], result );

  return result;
}

//

function rebase( filePath, oldPath, newPath )
{

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  filePath = this.normalize( filePath );
  if( oldPath )
  oldPath = this.normalize( oldPath );
  newPath = this.normalize( newPath );

  if( oldPath )
  {
    let commonPath = this.common( filePath, oldPath );
    filePath = _.strRemoveBegin( filePath, commonPath );
  }

  filePath = this.reroot( newPath, filePath )

  return filePath;
}

// --
// exception
// --

function _onErrorNotSafe( prefix, filePath, level )
{
  _.assert( arguments.length === 3 );
  _.assert( _.strIs( prefix ) );
  _.assert( _.strIs( filePath ) || _.arrayIs( filePath ), 'Expects string or strings' );
  _.assert( _.numberIs( level ) );
  let args =
  [
    prefix + ( prefix ? '. ' : '' ),
    'Not safe to use file ' + _.strQuote( filePath ) + '.',
    `Please decrease safity level explicitly if you know what you do, current safity level is ${level}`
  ];
  return args;
}

let ErrorNotSafe = _.error_functor( 'ErrorNotSafe', _onErrorNotSafe );

// --
// fields
// --

let Parameters =
{

  _rootStr : '/',
  _upStr : '/',
  _hereStr : '.',
  _downStr : '..',
  _hereUpStr : null, /* ./ */
  _downUpStr : null, /* ../ */

  _rootRegSource : null,
  _upRegSource : null,
  _downRegSource : null,
  _hereRegSource : null,
  _downUpRegSource : null,
  _hereUpRegSource : null,

  _delHereRegexp : null,
  _delDownRegexp : null,
  _delUpDupRegexp : null,
  _pathIsGlobRegexp : null,

}

let Fields =
{

  Parameters,

  fileProvider : null,
  path : Self,
  single : Self,
  s : null,

}

// --
// routines
// --

let Routines =
{

  // // meta
  //
  // Init,
  // CloneExtending,

  // checker

  // is,
  // are,
  like,
  isElement,

  isSafe,
  // isRefined,
  // isNormalized,
  // isAbsolute,
  // isRelative,
  // isGlobal,
  // isRoot,
  // _isDotted,
  // isDotted,
  // isTrailed,
  isGlob,

  hasSymbolBase,

  // begins,
  // ends,

  // // reformer
  //
  // refine,
  // _normalize,
  // normalize,
  // normalizeTolerant,
  // canonize,
  // canonizeTolerant,
  //
  // _nativizeWindows,
  // _nativizePosix,
  // nativize,

  // transformer


  // _dot,
  // dot,
  // undot,
  // trail,
  // detrail,
  //
  // dir,
  // dirFirst,

  prefixGet,
  name,
  fullName,

  ext,
  exts,
  withoutExt,
  changeExt,

  // joiner

  join,
  joinRaw,
  joinIfDefined,
  joinCross,
  reroot,
  resolve,
  joinNames,

  _split,
  split,

  // stater

  current,

  // relator

  from,
  _relative,
  relative,
  relativeCommon,

  _commonPair,
  common,
  rebase,

  // exception

  ErrorNotSafe,

}

_.mapSupplement( Self, Parameters );
_.mapSupplement( Self, Fields );
_.mapSupplement( Self, Routines );

Self.Init();

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
