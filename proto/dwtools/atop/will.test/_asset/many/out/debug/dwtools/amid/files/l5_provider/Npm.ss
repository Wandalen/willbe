( function _Npm_ss_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../Tools.s' );
  if( !_.FileProvider )
  require( '../UseMid.s' );

  var Tar;

  try
  {
    Tar = require( 'tar' );
  }
  catch( err )
  {
  }

}

let _global = _global_;
let _ = _global_.wTools;

//

/**
 @class wFileProviderNpm
 @memberof module:Tools/mid/Files.wTools.FileProvider
*/

let Parent = _.FileProvider.Partial;
let Self = function wFileProviderNpm( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Npm';

_.assert( !_.FileProvider.Npm );

// --
// inter
// --

function finit()
{
  let self = this;
  if( self.claimMap )
  self.claimEnd();
  Parent.prototype.finit.call( self );
}

//

function init( o )
{
  let self = this;
  Parent.prototype.init.call( self,o );
}

// --
// path
// --

/**
 * @typedef {Object} RemotePathComponents
 * @property {String} protocol
 * @property {String} hash
 * @property {String} longPath
 * @property {String} localVcsPath
 * @property {String} remoteVcsPath
 * @property {String} longerRemoteVcsPath
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm
 */

/**
 * @summary Parses provided `remotePath` and returns object with components {@link module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm.RemotePathComponents}.
 * @param {String} remotePath Remote path.
 * @function pathParse
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm#
 */

function pathParse( remotePath )
{
  let self = this;
  let path = self.path;
  let result = Object.create( null );

  if( _.mapIs( remotePath ) )
  return remotePath;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( remotePath ) );
  _.assert( path.isGlobal( remotePath ) )

  /* */

  let parsed1 = path.parseConsecutive( remotePath );
  _.mapExtend( result, parsed1 );

  let p = pathIsolateGlobalAndLocal( parsed1.longPath );
  result.localVcsPath = p[ 1 ];

  /* */

  let parsed2 = _.mapExtend( null, parsed1 );
  parsed2.protocol = null;
  parsed2.hash = null;
  parsed2.longPath = p[ 0 ];
  result.remoteVcsPath = path.str( parsed2 );

  /* */

  let parsed3 = _.mapExtend( null, parsed1 );
  parsed3.longPath = parsed2.longPath;
  parsed3.protocol = null;
  parsed3.hash = null;
  result.longerRemoteVcsPath = path.str( parsed3 );
  if( parsed1.hash )
  result.longerRemoteVcsPath += '@' + parsed1.hash;

  /* */

  result.isFixated = self.pathIsFixated( result );

  return result

/*

  remotePath : 'npm:///wColor/out/wColor#0.3.100'

  protocol : 'npm',
  hash : '0.3.100',
  longPath : '/wColor/out/wColor',
  localVcsPath : 'out/wColor',
  remoteVcsPath : 'wColor',
  longerRemoteVcsPath : 'wColor@0.3.100'

*/

  /* */

  function pathIsolateGlobalAndLocal( longPath )
  {
    let parsed = path.parseConsecutive( longPath );
    let splits = _.strIsolateLeftOrAll( parsed.longPath, /^\/?\w+\/?/ );
    parsed.longPath = _.strRemoveEnd( _.strRemoveBegin( splits[ 1 ], '/' ), '/' );
    let globalPath = path.str( parsed );
    return [ globalPath, splits[ 2 ] ];
  }

}

//

/**
 * @summary Returns true if remote path `filePath` has fixed version of npm package.
 * @param {String} filePath Global path.
 * @function pathIsFixated
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm#
 */

function pathIsFixated( filePath )
{
  let self = this;
  let path = self.path;
  let parsed = self.pathParse( filePath );

  if( !parsed.hash )
  return false;

  return true;
}

//

/**
 * @summary Changes version of package specified in path `o.remotePath` to latest available.
 * @param {Object} o Options map.
 * @param {String} o.remotePath Remote path.
 * @param {Number} o.verbosity=0 Level of verbosity.
 * @function pathIsFixated
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm#
 */

function pathFixate( o )
{
  let self = this;
  let path = self.path;

  if( !_.mapIs( o ) )
  o = { remotePath : o }
  _.routineOptions( pathFixate, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  let parsed = self.pathParse( o.remotePath );
  let latestVersion = self.versionRemoteLatestRetrive
  ({
    remotePath : o.remotePath,
    verbosity : o.verbosity,
  });

  let result = path.str
  ({
    protocol : parsed.protocol,
    longPath : parsed.longPath,
    hash : latestVersion,
  });

  return result;
}

var defaults = pathFixate.defaults = Object.create( null );
defaults.remotePath = null;
defaults.verbosity = 0;

//

/**
 * @summary Returns version of npm package located at `o.localPath`.
 * @param {Object} o Options map.
 * @param {String} o.localPath Path to npm package on hard drive.
 * @param {Number} o.verbosity=0 Level of verbosity.
 * @function versionLocalRetrive
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm#
 */

function versionLocalRetrive( o )
{
  let self = this;
  let path = self.path;

  if( !_.mapIs( o ) )
  o = { localPath : o }

  _.routineOptions( versionLocalRetrive, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !!self.system );

  if( !self.isDownloaded( o ) )
  return '';

  let localProvider = self.system.providerForPath( o.localPath );

  _.assert( localProvider instanceof _.FileProvider.HardDrive || localProvider.originalFileProvider instanceof _.FileProvider.HardDrive, 'Support only downloading on hard drive' );

  let currentVersion;
  try
  {
    let read = localProvider.fileRead({ filePath : path.join( o.localPath, 'package.json' ), encoding : 'json' });
    currentVersion = read.version;
  }
  catch( err )
  {
    debugger;
    return null;
  }

  return currentVersion || null;
}

var defaults = versionLocalRetrive.defaults = Object.create( null );
defaults.localPath = null;
defaults.verbosity = 0;

//

/**
 * @summary Returns latest version of npm package using its remote path `o.remotePath`.
 * @param {Object} o Options map.
 * @param {String} o.remotePath Remote path.
 * @param {Number} o.verbosity=0 Level of verbosity.
 * @function versionRemoteLatestRetrive
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm#
 */

function versionRemoteLatestRetrive( o )
{
  let self = this;
  let path = self.path;

  if( !_.mapIs( o ) )
  o = { remotePath : o }

  _.routineOptions( versionRemoteLatestRetrive, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !!self.system );

  let parsed = self.pathParse( o.remotePath );
  let shell = _.process.starter
  ({
    verbosity : o.verbosity - 1,
    outputCollecting : 1,
    sync : 1,
    deasync : 0,
  });

  let got = shell( 'npm show ' + parsed.remoteVcsPath );
  let latestVersion = /latest.*?:.*?([0-9\.][0-9\.][0-9\.]+)/.exec( got.output );

  if( !latestVersion )
  {
    debugger;
    throw _.err( 'Failed to get information about NPM package', parsed.remoteVcsPath );
  }

  latestVersion = latestVersion[ 1 ];

  return latestVersion;
}

var defaults = versionRemoteLatestRetrive.defaults = Object.create( null );
defaults.remotePath = null;
defaults.verbosity = 0;

//

/**
 * @summary Returns current version of npm package using its remote path `o.remotePath`.
 * @description Returns latest version if no version specified in remote path.
 * @param {Object} o Options map.
 * @param {String} o.remotePath Remote path.
 * @param {Number} o.verbosity=0 Level of verbosity.
 * @function versionRemoteCurrentRetrive
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm#
 */

function versionRemoteCurrentRetrive( o )
{
  let self = this;
  let path = self.path;

  if( !_.mapIs( o ) )
  o = { remotePath : o }

  _.routineOptions( versionRemoteCurrentRetrive, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !!self.system );

  let parsed = self.pathParse( o.remotePath );
  if( parsed.isFixated )
  return parsed.hash;

  return self.versionRemoteLatestRetrive( o );
}

var defaults = versionRemoteCurrentRetrive.defaults = Object.create( null );
defaults.remotePath = null;
defaults.verbosity = 0;

//

/**
 * @summary Returns true if local copy of package `o.localPath` is up to date with remote version `o.remotePath`.
 * @param {Object} o Options map.
 * @param {String} o.localPath Local path to package.
 * @param {String} o.remotePath Remote path to package.
 * @param {Number} o.verbosity=0 Level of verbosity.
 * @function isUpToDate
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm#
 */

function isUpToDate( o )
{
  let self = this;
  let path = self.path;

  _.routineOptions( isUpToDate, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !!self.system );

  let parsed = self.pathParse( o.remotePath );

  let currentVersion = self.versionLocalRetrive
  ({
    localPath : o.localPath,
    verbosity : o.verbosity,
  });

  if( !currentVersion )
  return false;

  if( parsed.hash === currentVersion )
  return true;

  let latestVersion = self.versionRemoteLatestRetrive
  ({
    remotePath : o.remotePath,
    verbosity : o.verbosity,
  });

  return currentVersion === latestVersion;
}

var defaults = isUpToDate.defaults = Object.create( null );
defaults.localPath = null;
defaults.remotePath = null;
defaults.verbosity = 0;

//

/**
 * @summary Returns true if path `o.localPath` contains a package.
 * @param {Object} o Options map.
 * @param {String} o.localPath Local path to package.
 * @param {Number} o.verbosity=0 Level of verbosity.
 * @function isDownloaded
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm#
 */

function isDownloaded( o )
{
  let self = this;
  let path = self.path;

  _.routineOptions( isDownloaded, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !!self.system );

  let srcCurrentPath;
  let localProvider = self.system.providerForPath( o.localPath );

  _.assert( localProvider instanceof _.FileProvider.HardDrive || localProvider.originalFileProvider instanceof _.FileProvider.HardDrive, 'Support only downloading on hard drive' );

  if( !localProvider.fileExists( o.localPath ) )
  return false;

  // if( !localProvider.isDir( path.join( o.localPath, 'node_modules' ) ) )
  // return false;

  if( !localProvider.isTerminal( path.join( o.localPath, 'package.json' ) ) )
  return false;

  return true;
}

var defaults = isDownloaded.defaults = Object.create( null );
defaults.localPath = null;
defaults.verbosity = 0;

// --
// etc
// --

function filesReflectSingle_body( o )
{
  let self = this;
  let path = self.path;

  o.extra = o.extra || Object.create( null );
  _.routineOptions( filesReflectSingle_body, o.extra, filesReflectSingle_body.extra );

  _.assertRoutineOptions( filesReflectSingle_body, o );
  // _.assert( o.mandatory === undefined )
  _.assert( arguments.length === 1, 'Expects single argument' );

  _.assert( _.routineIs( o.onUp ) && o.onUp.composed && o.onUp.composed.elements.length === 0, 'Not supported options' );
  _.assert( _.routineIs( o.onDown ) && o.onDown.composed && o.onDown.composed.elements.length === 0, 'Not supported options' );
  _.assert( _.routineIs( o.onWriteDstUp ) && o.onWriteDstUp.composed && o.onWriteDstUp.composed.elements.length === 0, 'Not supported options' );
  _.assert( _.routineIs( o.onWriteDstDown ) && o.onWriteDstDown.composed && o.onWriteDstDown.composed.elements.length === 0, 'Not supported options' );
  _.assert( _.routineIs( o.onWriteSrcUp ) && o.onWriteSrcUp.composed && o.onWriteSrcUp.composed.elements.length === 0, 'Not supported options' );
  _.assert( _.routineIs( o.onWriteSrcDown ) && o.onWriteSrcDown.composed && o.onWriteSrcDown.composed.elements.length === 0, 'Not supported options' );
  // _.assert( o.outputFormat === 'record' || o.outputFormat === 'nothing', 'Not supported options' );
  _.assert( o.outputFormat === undefined );
  _.assert( o.linking === 'fileCopy' || o.linking === 'hardLinkMaybe' || o.linking === 'softLinkMaybe', 'Not supported options' );
  _.assert( !o.src.hasFiltering(), 'Not supported options' );
  _.assert( !o.dst.hasFiltering(), 'Not supported options' );
  _.assert( o.src.formed === 3 );
  _.assert( o.dst.formed === 3 );
  _.assert( o.srcPath === undefined );
  // _.assert( o.filter === null || !o.filter.hasFiltering(), 'Not supported options' );
  _.assert( o.filter === undefined );
  // _.assert( !!o.recursive, 'Not supported options' );

  defaults.dstRewriting = 1;
  defaults.dstRewritingByDistinct = 1;
  defaults.dstRewritingOnlyPreserving = 0;

  /* */

  let localProvider = o.dst.providerForPath();
  let srcPath = o.src.filePathSimplest();
  let dstPath = o.dst.filePathSimplest();

  // if( _.mapIs( srcPath ) )
  // {
  //   _.assert( _.mapVals( srcPath ).length === 1 );
  //   _.assert( _.mapVals( srcPath )[ 0 ] === true || _.mapVals( srcPath )[ 0 ] === dstPath );
  //   srcPath = _.mapKeys( srcPath )[ 0 ];
  // }

  let parsed = self.pathParse( srcPath );

  /* */

  _.sure( _.strIs( srcPath ) );
  _.sure( _.strIs( dstPath ) );
  _.assert( localProvider instanceof _.FileProvider.HardDrive || localProvider.originalFileProvider instanceof _.FileProvider.HardDrive, 'Support only downloading on hard drive' );
  _.sure( !o.src || !o.src.hasFiltering(), 'Does not support filtering, but {o.src} is not empty' );
  _.sure( !o.dst || !o.dst.hasFiltering(), 'Does not support filtering, but {o.dst} is not empty' );
  // _.sure( !o.filter || !o.filter.hasFiltering(), 'Does not support filtering, but {o.filter} is not empty' );

  /* */

  let result = [];
  let shell = _.process.starter
  ({
    verbosity : o.verbosity - 1,
    sync : 1,
    deasync : 0,
    outputCollecting : 1,
  });

  if( !localProvider.fileExists( path.dir( dstPath ) ) )
  localProvider.dirMake( path.dir( dstPath ) );

  let exists = localProvider.fileExists( dstPath );
  let isDir = localProvider.isDir( dstPath );
  if( exists && !isDir )
  throw occupiedErr();

  /* */

  if( exists )
  {
    if( localProvider.dirRead( dstPath ).length === 0 )
    {
      localProvider.fileDelete( dstPath );
      exists = false;
    }
  }

  if( exists )
  {

    let packageFilePath = path.join( dstPath, 'package.json' );
    if( !localProvider.isTerminal( packageFilePath ) )
    throw occupiedErr( '. Directory is occupied!' );

    try
    {
      let read = localProvider.fileRead({ filePath : packageFilePath, encoding : 'json' });
      if( !read || read.name !== parsed.remoteVcsPath )
      throw _.err( 'Directory is occupied!' );
    }
    catch( err )
    {
      throw _.err( occupiedErr( '' ), err );
    }

    localProvider.filesDelete( dstPath );

  }

  /* */

  let tmpPath = dstPath + '-' + _.idWithGuid();
  let tmpEssentialPath = path.join( tmpPath, 'node_modules', parsed.remoteVcsPath );

  if( o.extra.usingNpm )
  {
    let npmArgs =
    [
      '--no-package-lock',
      '--legacy-bundling',
      '--prefix',
      localProvider.path.nativize( tmpPath ),
      parsed.longerRemoteVcsPath
    ];
    let got = shell({ execPath : 'npm install', args : npmArgs });
    _.assert( got.exitCode === 0 );


    localProvider.fileRename( dstPath, tmpEssentialPath )
    localProvider.fileDelete( path.dir( tmpEssentialPath ) );
    localProvider.fileDelete( path.dir( path.dir( tmpEssentialPath ) ) );

    return recordsMake();
  }
  else
  {
    _.assert( Tar !== undefined, 'o.extra.usingNpm:0 mode can\'t be used without package "tar"' );

    let providerHttp = _.FileProvider.Http();
    let tmpPackagePath = localProvider.path.join( tmpEssentialPath, 'package' );
    let version = parsed.hash || 'latest';
    let registryUrl = `https://registry.npmjs.org/${parsed.remoteVcsPath}/${version}`;
    let tarballDstPath;

    let ready = providerHttp.fileRead({ filePath : registryUrl, sync : 0 })
    .then( ( response ) =>
    {
      response = JSON.parse( response );
      let fileName = providerHttp.path.name({ path : response.dist.tarball, full : 1 });
      tarballDstPath = localProvider.path.join( tmpEssentialPath, fileName );
      return providerHttp.fileCopyToHardDrive({ url : response.dist.tarball, filePath : tarballDstPath });
    })
    .then( () =>
    {
      Tar.x
      ({
        file : localProvider.path.nativize( tarballDstPath ),
        cwd : localProvider.path.nativize( tmpEssentialPath ),
        sync : 1
      });
      localProvider.fileRename( dstPath, tmpPackagePath );
      localProvider.filesDelete( tmpPath );
      return null;
    })
    .finally( ( err, got ) =>
    {
      if( err )
      throw _.err( occupiedErr( '' ), err );
      return recordsMake();
    })

    return ready;
  }

  /* */

  function recordsMake()
  {
    /* xxx : fast solution to return some records instead of empty arrray */
    o.result = localProvider.filesReflectEvaluate
    ({
      src : { filePath : dstPath },
      dst : { filePath : dstPath },
    });
    return o.result;
  }

  /* */

  function occupiedErr( msg )
  {
    debugger;
    return _.err( 'Cant download NPM package ' + _.color.strFormat( parsed.longerRemoteVcsPath, 'path' ) + ' to ' + _.color.strFormat( dstPath, 'path' ) + ( msg || '' ) )
  }

}

_.routineExtend( filesReflectSingle_body, _.FileProvider.Find.prototype.filesReflectSingle );

var extra = filesReflectSingle_body.extra = Object.create( null );
extra.fetching = 0;
extra.usingNpm = 1;

var defaults = filesReflectSingle_body.defaults;

let filesReflectSingle = _.routineFromPreAndBody( _.FileProvider.Find.prototype.filesReflectSingle.pre, filesReflectSingle_body );

// --
// relationship
// --

/**
 * @typedef {Object} Fields
 * @property {Boolean} safe=0
 * @property {String[]} protocols=[ 'npm' ]
 * @property {Boolean} resolvingSoftLink=0
 * @property {Boolean} resolvingTextLink=0
 * @property {Boolean} limitedImplementation=1
 * @property {Boolean} isVcs=1
 * @property {Boolean} usingGlobalPath=1
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderNpm
*/

let Composes =
{

  safe : 0,
  protocols : _.define.own([ 'npm' ]),

  resolvingSoftLink : 0,
  resolvingTextLink : 0,
  limitedImplementation : 1,
  isVcs : 1,
  usingGlobalPath : 1,

}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  Path : _.uri.CloneExtending({ fileProvider : Self }),
}

let Forbids =
{
}

// --
// declare
// --

let Proto =
{

  finit,
  init,


  // vcs

  pathParse,
  pathIsFixated,
  pathFixate,
  versionLocalRetrive,
  versionRemoteLatestRetrive,
  versionRemoteCurrentRetrive,
  isUpToDate,
  isDownloaded,

  // etc

  filesReflectSingle,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.FileProvider.Find.mixin( Self );
_.FileProvider.Secondary.mixin( Self );

//

_.FileProvider[ Self.shortName ] = Self;

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})( );
