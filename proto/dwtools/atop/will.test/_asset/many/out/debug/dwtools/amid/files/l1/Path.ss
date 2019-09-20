(function _Path_ss_() {

'use strict';

// let toBuffer = null;
// let Os = null;

if( typeof module !== 'undefined' )
{

  require( '../UseBase.s' );

  // Os = require( 'os' );

  let _ = _global_.wTools;

  _.include( 'wPathBasic' );

}

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools.path;

_.assert( _.objectIs( Self ) );

// --
// path
// --

/**
 * Returns path for main module (module that running directly by node).
 * @returns {String}
 * @function realMainFile
 * @memberof module:Tools/PathBasic.wTools.path
 */

let _pathRealMainFile;
function realMainFile()
{
  if( _pathRealMainFile ) return _pathRealMainFile;
  _pathRealMainFile = this.normalize( require.main.filename );
  return _pathRealMainFile;
}

//

/**
 * Returns path dir name for main module (module that running directly by node).
 * @returns {String}
 * @function realMainDir
 * @memberof module:Tools/PathBasic.wTools.path
 */

let _pathRealMainDir;
function realMainDir()
{
  if( _pathRealMainDir )
  return _pathRealMainDir;

  if( require.main )
  _pathRealMainDir = this.normalize( this.dir( require.main.filename ) );
  else
  return this.effectiveMainFile();

  return _pathRealMainDir;
}

//

/**
 * Returns absolute path for file running directly by node
 * @returns {String}
 * @throws {Error} If passed any argument.
 * @function effectiveMainFile
 * @memberof module:Tools/PathBasic.wTools.path
 */

let effectiveMainFile = ( function effectiveMainFile()
{
  let result = '';

  return function effectiveMainFile()
  {
    _.assert( !!this.fileProvider );
    _.assert( arguments.length === 0 );

    if( result )
    return result;

    if( process.argv[ 0 ] || process.argv[ 1 ] )
    {
      result = this.join( this.currentAtBegin, process.argv[ 1 ] || process.argv[ 0 ] );
      result = this.resolve( result );
    }

    if( !this.fileProvider.statResolvedRead( result ) )
    {
      debugger;
      console.error( 'process.argv :', process.argv.join( ', ' ) );
      console.error( 'currentAtBegin :', this.currentAtBegin );
      console.error( 'effectiveMainFile.raw :', this.join( this.currentAtBegin, process.argv[ 1 ] || process.argv[ 0 ] ) );
      console.error( 'effectiveMainFile :', result );
      result = this.realMainFile();
    }

    return result;
  }

})()

//

/**
 * Returns path dirname for file running directly by node
 * @returns {String}
 * @throws {Error} If passed any argument.
 * @function effectiveMainDir
 * @memberof module:Tools/PathBasic.wTools.path
 */

function effectiveMainDir()
{
  _.assert( arguments.length === 0 );

  let result = this.dir( this.effectiveMainFile() );

  return result;
}

//

function resolveTextLink( path )
{
  _.assert( !!this.fileProvider );
  return this.fileProvider.pathResolveTextLink.apply( this.fileProvider, arguments );
}

// //
//
// function _resolveTextLink( path )
// {
//   _.assert( !!this.fileProvider );
//   return this.fileProvider._pathResolveTextLink.apply( this.fileProvider, arguments );
// }

//

/**
 * Returns `home` directory. On depend from OS it's will be value of 'HOME' for posix systems or 'USERPROFILE'
 * for windows environment variables.
 * @returns {String}
 * @function userHome
 * @memberof module:Tools/PathBasic.wTools.path
 */

function dirUserHome()
{
  _.assert( arguments.length === 0 );
  _.assert( _.routineIs( this.fileProvider.pathDirUserHomeAct ) );
  if( this.userHomePath )
  return this.userHomePath;
  return this.fileProvider.pathDirUserHomeAct();
}

//

function dirTemp()
{
  _.assert( arguments.length === 0 );
  _.assert( _.routineIs( this.fileProvider.pathDirTempAct ), () => 'Provider ' + this.fileProvider.qualifiedName + ' does not support temp files' );
  if( this.tempPath )
  return this.tempPath;
  return this.fileProvider.pathDirTempAct();
}

//

function dirTempAt( o )
{

  _.assert( arguments.length <= 2 );

  if( _.mapIs( o ) )
  {
    o = arguments[ 0 ];
  }
  else
  {
    if( arguments[ 1 ] !== undefined )
    o =
    {
      packagePath : arguments[ 0 ],
      packageName : arguments[ 1 ],
    }
    else
    o =
    {
      packageName : arguments[ 0 ],
    }
  }

  o = _.routineOptions( dirTempAt, o );

  if( !o.packageName )
  o.packageName = _.idWithGuid();
  else
  o.packageName = o.packageName + '-' + _.idWithTime();

  if( !o.packagePath )
  o.packagePath = this.dirTemp();

  _.assert( this.isAbsolute( o.packagePath ) );
  _.assert( !this.isAbsolute( o.packageName ), () => 'Option {- o.packageName -} should be relative path, but is ' + o.packageName );

  o.fullPath = this.join( o.packagePath, 'tmp.tmp', o.packageName );

  return o.fullPath;
}

dirTempAt.defaults =
{
  packageName : null,
  packagePath : null
}

// //
//
// function dirTempAtOpen( packagePath, packageName )
// {
//   _.assert( !!this.fileProvider );
//   packagePath = this.dirTempAt.apply( this, arguments );
//   this.fileProvider.filesDelete({ filePath : packagePath, throwing : 0 });
//   this.fileProvider.dirMake( packagePath );
//   return packagePath;
// }
//
// //
//
// function dirTempAtClose( filePath )
// {
//   _.assert( arguments.length === 1 );
//   _.assert( !!this.fileProvider );
//   _.assert( this.isAbsolute( filePath ) );
//   _.sure( _.strHas( this.normalize( filePath ), '/tmp.tmp/' ), 'Path does not contain temporary directory:', filePath );
//   this.fileProvider.filesDelete({ filePath : filePath, throwing : 0 });
// }

//

function pathDirTempOpen( o )
{
  let self = this;

  if( !_.mapIs( arguments[ 0 ] ) )
  o = { filePath : arguments[ 0 ] }
  if( arguments[ 1 ] !== undefined )
  o.name = arguments[ 1 ];
  o.filePath = self.resolve( o.filePath );

  _.routineOptions( pathDirTempOpen, o );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( !!self.fileProvider );
  _.assert( self.isAbsolute( o.filePath ) );

  // o.filePath = self.normalize( o.filePath );

  if( !self.pathDirTempForMap )
  self.pathDirTempForMap = Object.create( null );

  let devicePath = devicePathGet( o.filePath );

  if( self.pathDirTempForMap[ devicePath ] )
  return self.pathDirTempForMap[ devicePath ];

  let result = self.pathDirTempMake( o );

  self.pathDirTempForMap[ devicePath ] = result;

  return result;

  /* */

  function devicePathGet( path )
  {
    return path.substring( 0, path.indexOf( '/', 1 ) )
  }

}

pathDirTempOpen.defaults =
{
  filePath : null,
  name : null,
}

//

function pathDirTempMake( o )
{
  let self = this;

  _.routineOptions( pathDirTempMake, arguments );
  _.assert( arguments.length === 1 );
  _.assert( !!self.fileProvider );
  _.assert( self.isAbsolute( o.filePath ) );
  _.assert( self.isNormalized( o.filePath ) );

  // debugger;
  let filePath2;
  var osTempDir = self.dirTemp();

  if( !o.name )
  o.name = 'tmp';
  o.name = o.name + '-' + _.idWithDate() + '.tmp';

  if( devicePathGet( osTempDir ) === devicePathGet( o.filePath ) )
  {
    filePath2 = self.join( osTempDir, o.name );
    self.fileProvider.dirMake({ filePath : filePath2, sync : 1 });
    return end();
  }

  let dirsPath = self.traceToRoot( o.filePath );
  let err;
  let tempPath = 'temp/' + o.name;

  for( let i = 0, l = dirsPath.length - 1 || dirsPath.length ; i < l ; i++ )
  {
    filePath2 = dirsPath[ i ] + '/' + tempPath;

    if( self.fileProvider.fileExists( filePath2 ) )
    return end();

    try
    {
      self.fileProvider.dirMake( filePath2 );
      return end();
    }
    catch( e )
    {
      err = e;
      // self.fileProvider.logger.log( 'Can`t create temp directory at :', filePath2 );
    }
  }

  if( err )
  throw _.err( 'Can`t create temp directory for:', o.filePath, '\n', err )

  return end();

  /* */

  function devicePathGet( filePath )
  {
    return filePath.substring( 0, filePath.indexOf( '/', 1 ) )
  }

  /* */

  function end()
  {
    _.process.exitHandlerOnce( () =>
    {
      debugger;
      self.pathDirTempClose()
    });
    debugger;
    logger.log( 'Open temp directory ' + filePath2 );
    return filePath2;
  }

}

pathDirTempMake.defaults =
{
  filePath : null,
  name : null,
}

//

function pathDirTempClose( tempDirPath )
{
  let self = this;

  _.assert( arguments.length <= 1 );
  _.assert( !!self.fileProvider );

  if( !self.pathDirTempForMap )
  return;

  if( !arguments.length )
  {
    for( let d in self.pathDirTempForMap )
    {
      close( d );
    }
  }
  else
  {
    _.assert( self.isAbsolute( tempDirPath ) );
    _.assert( self.isNormalized( tempDirPath ) );

    let devicePath = tempDirPath.substring( 0, tempDirPath.indexOf( '/', 1 ) );

    if( !self.pathDirTempForMap[ devicePath ] )
    throw _.err( 'Not found temp dir for device ' + devicePath );

    if( self.pathDirTempForMap[ devicePath ] !== tempDirPath )
    throw _.err
    (
        'Registered temp directory', self.pathDirTempForMap[ devicePath ]
      , '\nAttempt to unregister temp directory', tempDirPath
    );

    close( devicePath );

    // self.fileProvider.filesDelete({ filePath : tempDirPath, safe : 0, throwing : 1 });
    // _.assert( !self.fileProvider.fileExists( tempDirPath ) );
    // delete self.pathDirTempForMap[ devicePath ];

  }

  function close( keyPath )
  {
    let tempPath = self.pathDirTempForMap[ keyPath ];
    self.fileProvider.filesDelete
    ({
      filePath : tempPath,
      safe : 0,
      throwing : 0,
    });
    delete self.pathDirTempForMap[ keyPath ];
    _.assert( !self.fileProvider.fileExists( tempPath ) );
    debugger;
    logger.log( 'Close temp directory ' + tempPath );
  }

}


//

function forCopy_pre( routine, args )
{

  _.assert( args.length === 1 );

  let o = args[ 0 ];

  if( !_.mapIs( o ) )
  o = { filePath : o };

  _.routineOptions( routine, o );
  _.assert( _.strIs( o.filePath ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  return o;
}

//

function forCopy_body( o )
{
  let path = this;
  let fileProvider = this.fileProvider;

  _.assert( arguments.length === 1, 'Expects single argument' );

  let postfix = _.strPrependOnce( o.postfix, o.postfix ? '-' : '' );
  let file = fileProvider.recordFactory().record( o.filePath );
  let name = file.name;

  let parts = _.strSplitFast({ src : name, delimeter : '-', preservingEmpty : 0, preservingDelimeters : 0 });
  if( parts[ parts.length-1 ] === o.postfix )
  name = parts.slice( 0, parts.length-1 ).join( '-' );

  // !!! this condition (first if below) is not necessary, because if it fulfilled then previous fulfiled too, and has the
  // same effect as previous

  if( parts.length > 1 && parts[ parts.length-1 ] === o.postfix )
  name = parts.slice( 0, parts.length-1 ).join( '-' );
  else if( parts.length > 2 && parts[ parts.length-2 ] === o.postfix )
  name = parts.slice( 0, parts.length-2 ).join( '-' );

  /*file.absolute =  file.dir + '/' + file.name + file.extWithDot;*/

  let filePath = path.join( file.dir , name + postfix + file.extWithDot );
  if( !fileProvider.statResolvedRead({ filePath : filePath , sync : 1 }) )
  return filePath;

  let attempts = 1 << 13;
  let index = 1;

  while( attempts > 0 )
  {

    let filePath = path.join( file.dir , name + postfix + '-' + index + file.extWithDot );

    if( !fileProvider.statResolvedRead({ filePath : filePath , sync : 1 }) )
    return filePath;

    attempts -= 1;
    index += 1;

  }

  throw _.err( 'Cant make copy path for : ' + file.absolute );
}

forCopy_body.defaults =
{
  delimeter : '-',
  postfix : 'copy',
  filePath : null,
}

var having = forCopy_body.having = Object.create( null );
having.driving = 0;
having.aspect = 'body';

//

/**
 * Generate path string for copy of existing file passed into `o.path`. If file with generated path is exists now,
 * method try to generate new path by adding numeric index into tail of path, before extension.
 * @example
 * let str = 'foo/bar/baz.txt',
   let path = wTools.pathforCopy( {path : str } ); // 'foo/bar/baz-copy.txt'
 * @param {Object} o options argument
 * @param {string} o.path Path to file for create name for copy.
 * @param {string} [o.postfix='copy'] postfix for mark file copy.
 * @returns {string} path for copy.
 * @throws {Error} If missed argument, or passed more then one.
 * @throws {Error} If passed object has unexpected property.
 * @throws {Error} If file for `o.path` is not exists.
 * @function forCopy
 * @memberof module:Tools/PathBasic.wTools.path
 */

let forCopy = _.routineFromPreAndBody( forCopy_pre, forCopy_body );

forCopy.having.aspect = 'entry';

function _firstAvailable_pre( routine, args )
{

  _.assert( args.length === 1 );

  let o = args[ 0 ];

  if( !_.mapIs( o ) )
  o = { paths : o }

  _.routineOptions( routine, o );
  _.assert( _.arrayIs( o.paths ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  return o;
}

//

function _firstAvailable_body( o )
{
  let path = this;
  let fileProvdier = path.fileProvider;

  _.assert( arguments.length === 1, 'Expects single argument' );

  for( let p = 0 ; p < o.paths.length ; p++ )
  {
    let path = o.paths[ p ];
    if( fileProvdier.fileExists( o.onPath ? o.onPath.call( o, path, p ) : path ) )
    return path;
  }

  return undefined;
}

_firstAvailable_body.defaults =
{
  paths : null,
  onPath : null,
}

var having = _firstAvailable_body.having = Object.create( null );
having.driving = 0;
having.aspect = 'body';

let firstAvailable = _.routineFromPreAndBody( _firstAvailable_pre, _firstAvailable_body );
firstAvailable.having.aspect = 'entry';

// --
// declare
// --

let Proto =
{

  realMainFile,
  realMainDir,

  effectiveMainFile,
  effectiveMainDir,

  resolveTextLink,
  // _resolveTextLink,

  dirUserHome,
  dirTemp,

  /* qqq merge dirTempAtOpen + pathDirTempOpen and dirTempAtClose + pathDirTempClose */

  dirTempAt,
  // dirTempAtOpen,
  // dirTempAtClose,

  pathDirTempOpen,
  pathDirTempMake,
  pathDirTempClose,

  forCopy,
  firstAvailable,

}

_.mapExtend( Self, Proto );

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
