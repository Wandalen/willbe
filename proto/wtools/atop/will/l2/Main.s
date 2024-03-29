( function _Main_s_()
{

'use strict';

/**
 * @classdesc Class wWill provides main functionality to work with modules, junctions, modules graphs, willfiles and other.
 * @class wWill
 * @module Tools/atop/willbe
 */

// --
// relations
// --

const _ = _global_.wTools;
const Parent = null;
const Self = wWill;
function wWill( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Will';

//

let UpformingDefaults =
{
  all : null,
  attachedWillfilesFormed : null,
  peerModulesFormed : null,
  subModulesFormed : null,
  resourcesFormed : null,
};

let ModuleFilterNulls =
{
  withOut : null,
  withIn : null,
  withEnabledModules : null,
  withDisabledModules : null,
  withValid : null,
  withInvalid : null,
  withKnown : null,
  withUnknown : null,
};

let ModuleFilterDefaults =
{
  withOut : 1,
  withIn : 1,
  withEnabledModules : 1,
  withDisabledModules : 0,
  withValid : 1,
  withInvalid : 1,
  withKnown : 1,
  withUnknown : 0,
};

let ModuleFilterOff =
{
  withOut : 0,
  withIn : 0,
  withEnabledModules : 0,
  withDisabledModules : 0,
  withValid : 0,
  withInvalid : 0,
  withKnown : 0,
  withUnknown : 0,
};

let ModuleFilterOn =
{
  withOut : 1,
  withIn : 1,
  withEnabledModules : 1,
  withDisabledModules : 1,
  withValid : 1,
  withInvalid : 1,
  withKnown : 1,
  withUnknown : 1,
};

let RelationFilterNulls =
{
  ... ModuleFilterNulls,
  withEnabledSubmodules : null,
  withDisabledSubmodules : null,
  withOptionalSubmodules : null,
  withMandatorySubmodules : null,
};

let RelationFilterDefaults =
{
  ... ModuleFilterDefaults,
  withEnabledSubmodules : 1,
  withDisabledSubmodules : 0,
  withOptionalSubmodules : 1,
  withMandatorySubmodules : 1,
};

let RelationFilterOff =
{
  ... ModuleFilterOff,
  withEnabledSubmodules : 0,
  withDisabledSubmodules : 0,
  withOptionalSubmodules : 0,
  withMandatorySubmodules : 0,
};

let RelationFilterOn =
{
  ... ModuleFilterOn,
  withEnabledSubmodules : 1,
  withDisabledSubmodules : 1,
  withOptionalSubmodules : 1,
  withMandatorySubmodules : 1,
};

let FilterFields =
{
  withEnabled : 1,
  withDisabled : 0,
  // ... _.mapBut_( null, ModuleFilterDefaults, { withEnabledModules : null, withDisabledModules : null } ),
  ... RelationFilterDefaults
};

//

let IntentionFields =
{
  attachedWillfilesFormedOfMain : true,
  peerModulesFormedOfMain : true,
  subModulesFormedOfMain : true,
  resourcesFormedOfMain : null,
  allOfMain : null,

  attachedWillfilesFormedOfSub : true,
  peerModulesFormedOfSub : true,
  subModulesFormedOfSub : true,
  resourcesFormedOfSub : null,
  allOfSub : null,
}

// --
// inter
// --

function finit()
{
  if( this.formed )
  this.unform();
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let will = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  let logger = will.logger = new _.Logger({ output : _global_.logger, name : 'will' });

  will._.hooks = null;
  // will._.withSubmodules = null;

  _.workpiece.initFields( will );
  Object.preventExtensions( will );

  _.assert( logger === will.logger );

  if( o )
  will.copy( o );

  if( will.transaction === null )
  will.transaction = _.will.Transaction /* qqq : for Vova : ? */
  ({
    isInitial : 1,
    /*verbosity : will.logger.verbosity, will */
    targetLogger : will.logger
  });

}

//

function unform()
{
  let will = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!will.formed );

  /* begin */

  /* end */

  will.formed = 0;
  return will;
}

//

function form()
{
  let will = this;

  if( will.formed >= 1 )
  return will;

  will.formAssociates();

  if( !will.environmentPath )
  will.environmentPath = will.environmentPathFind( will.fileProvider.path.current() );
  // if( !will.withPath )
  // will.withPath = will.fileProvider.path.join( will.fileProvider.path.current(), './' );

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !will.formed );
  _.assert( _.path.is( will.environmentPath ) );

  will.formed = 1;
  return will;
}

//

function formAssociates()
{
  let will = this;
  let logger = will.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !will.formed );
  _.assert( !!logger );
  _.assert( logger.verbosity === will.verbosity );

  if( !will.fileProvider )
  {

    let hub = _.FileProvider.System({ providers : [] });

    _.FileProvider.Git().providerRegisterTo( hub );
    _.FileProvider.Npm().providerRegisterTo( hub );
    _.FileProvider.Http().providerRegisterTo( hub );

    /* xxx : qqq : remove _.FileFilter.Image, use HD provider directly */
    // let defaultProvider = _.FileProvider.Default();
    // let image = _.FileFilter.Image({ originalFileProvider : defaultProvider });
    // let archive = new _.FilesGraphArchive({ imageFileProvider : image });
    // image.providerRegisterTo( hub );
    // hub.defaultProvider = image;

    let defaultProvider = _.FileProvider.Default();
    defaultProvider.providerRegisterTo( hub );
    hub.defaultProvider = defaultProvider;

    will.fileProvider = hub;

  }

  // if( !will.filesGraph )
  // will.filesGraph = _.FilesGraphOld({ fileProvider : will.fileProvider });

  let logger2 = new _.Logger({ output : logger, name : 'will.providers' });

  will.fileProvider.logger = logger2;
  for( var f in will.fileProvider.providersWithProtocolMap )
  {
    let fileProvider = will.fileProvider.providersWithProtocolMap[ f ];
    fileProvider.logger = logger2;
  }

  _.assert( will.fileProvider.logger === logger2 );
  _.assert( logger.verbosity === will.verbosity );
  _.assert( will.fileProvider.logger !== will.logger );

  will._verbosityChange();

  _.assert( logger2.verbosity <= logger.verbosity );
}

// --
// path
// --

function WillPathGet()
{
  return _.path.join( __dirname, '../entry/Exec' );
}

// //
//
// function PathIsOut( filePath )
// {
//   if( _.arrayIs( filePath ) )
//   filePath = filePath[ 0 ];
//   return _.strHas( filePath, /\.out(\.\w+)?(\.\w+)?$/ );
// }

//

function DirPathFromFilePaths( filePaths )
{
  let module = this;

  filePaths = _.array.as( filePaths );

  _.assert( _.strsAreAll( filePaths ) );
  _.assert( arguments.length === 1 );

  filePaths = filePaths.map( ( filePath ) =>
  {
    filePath = _.path.normalize( filePath );

    let r1 = /(.*)(?:\.will(?:\.|$))[^\/]*$/;
    let parsed1 = r1.exec( filePath );
    if( parsed1 )
    filePath = parsed1[ 1 ];

    let r2 = /(.*)(?:\.(?:im|ex)(?:\.|$))[^\/]*$/;
    let parsed2 = r2.exec( filePath );
    if( parsed2 )
    filePath = parsed2[ 1 ];

    return filePath;
  });

  let filePath = _.strCommonLeft.apply( _, _.array.as( filePaths ) );
  _.assert( filePath.length > 0 );
  return filePath;
}

//

function PrefixPathForRole( role, isOut )
{
  let cls = this;
  let result = cls.PrefixPathForRoleMaybe( role, isOut );

  _.assert( arguments.length === 2 );
  _.sure( _.strIs( result ), 'Unknown role', _.strQuote( role ) );

  return result;
}

//

function PrefixPathForRoleMaybe( role, isOut )
{
  let cls = this;
  let result = '';

  _.assert( arguments.length === 2 );

  if( role === 'import' )
  result += '.im';
  else if( role === 'export' )
  result += '.ex';
  else if( role === 'single' )
  result += '';
  else return null;

  result += isOut ? '.out' : '';
  result += '.will';

  return result;
}

//

function PathToRole( filePath )
{
  let role = null;

  if( _.argumentsArray.like( filePath ) )
  return _.container.map_( null, filePath, ( filePath ) => this.PathToRole( filePath ) );

  let isImport = _.strHas( filePath, /(^|\.|\/)im\.will(\.|$)/ );
  let isExport = _.strHas( filePath, /(^|\.|\/)ex\.will(\.|$)/ );

  if( isImport )
  role = 'import';
  else if( isExport )
  role = 'export';
  else
  role = 'single';

  return role;
}

//

function CommonPathFor( willfilesPath )
{

  if( _.arrayIs( willfilesPath ) )
  {
    if( !willfilesPath.length )
    return null;
    willfilesPath = willfilesPath[ 0 ];
  }

  _.assert( arguments.length === 1 );

  if( willfilesPath === null )
  return null;

  _.assert( _.strIs( willfilesPath ) );

  let common = willfilesPath;
  // let common2 = common.replace( /((\.|\/|^)(im|ex))?((\.|\/|^)will)(\.out)?(\.\w+)?$/, '' );
  // let common2 = common.replace( /((\.|\/|^)(im|ex))?(\.out)?((\.|\/|^)will)(\.\w+)?$/, '' );
  let common2 = common.replace( /((\.|\/|^)(im|ex))?((\.|\/|^)will)(\.\w+)?$/, '' );
  let removed = _.strRemoveBegin( common, common2 );
  if( removed[ 0 ] === '/' )
  common2 = common2 + '/';
  common = common2;

  return common;
}

//

function CommonPathNormalize( commonPath )
{
  let commonPath2 = commonPath;
  _.assert( !!commonPath && !!commonPath.replace );
  commonPath2 = commonPath.replace( /((\.|\/|^)(im|ex))?((\.|\/|^)will)(\.\w+)?$/, '' );
  return commonPath2;
}

//

function CloneDirPathFor( inPath )
{
  _.assert( arguments.length === 1 );
  _.assert( _.path.isAbsolute( inPath ) );

  let splits = _.path.split( inPath );
  let index = splits.indexOf( '.module' );

  if( index >= 0 )
  {
    return splits.slice( 0, index+1 ).join( '/' );
  }

  return _.path.join( inPath, '.module' );
}

//

// function DownloadPathFor( remotePath, alias )
// {
//   _.assert( arguments.length === 2 );
//
//   xxx
//
// }

//

function OutfilePathFor( outPath, name )
{
  _.assert( arguments.length === 2 );
  _.assert( _.path.isAbsolute( outPath ), 'Expects absolute path outPath' );
  _.assert( _.strDefined( name ), 'Module should have name, declare about::name' );
  name = _.strJoinPath( [ name, '.out.will.yml' ], '.' );
  return _.path.join( outPath, name );
}

//

function RemotePathAdjust( remotePath, relativePath )
{
  let remotePathParsed = _.uri.parseConsecutive( remotePath );

  if( !remotePathParsed.query )
  {
    return _.uri.join( remotePath, relativePath );
  }

  remotePathParsed.query = _.strWebQueryParse( remotePathParsed.query );

  if( !remotePathParsed.query.out )
  {
    return _.uri.join( remotePath, relativePath );
  }

  remotePathParsed.query.out = _.path.join( remotePathParsed.query.out, relativePath );

  return _.uri.str( remotePathParsed );
}

//

function HooksPathGet( environmentPath )
{
  return _.path.join( environmentPath, '.will/hook' );
}

//

function LocalPathNormalize( localPath )
{

  _.assert( arguments.length === 1, 'Expects no arguments' );

  /* xxx : find more robust solution */

  localPath = _.filter_( null, localPath, ( r ) =>
  {
    let splits = _.path.split( r );
    if( _.longCountElement( splits, '.module' ) > 1 )
    {
      let f = splits.indexOf( '.module' );
      let l = splits.lastIndexOf( '.module' );
      splits.splice( f, l-f );
      r = splits.join( '/' );
    }
    return r;
  });

  return localPath;
}

//

function IsModuleAt( filePath )
{
  let cls = this;
  return cls.WillfilesFind( filePath ).length > 0;
}

//

function pathIsRemote( remotePath )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1, 'Expects exactly one argument {-remotePath-}' );
  _.assert( _.strIs( remotePath ) );

  // if( remotePath === undefined )
  // remotePath = module.remotePath ? path.common( module.remotePath ) : module.commonPath;
  // let remoteProvider = fileProvider.providerForPath( remotePath );

  let remoteProvider = _.repo.providerForPath({ remotePath });

  _.assert( !!remoteProvider );

  return !_.longHasAny( [ 'hd', 'file' ], remoteProvider.name );
  // return !!remoteProvider.isVcs;
}

// function pathIsRemote( remotePath )
// {
//   let will = this;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( arguments.length === 1, 'Expects no arguments' );
//   _.assert( _.strIs( remotePath ) );
//
//   // if( remotePath === undefined )
//   // remotePath = module.remotePath ? path.common( module.remotePath ) : module.commonPath;
//   let remoteProvider = fileProvider.providerForPath( remotePath );
//
//   _.assert( !!remoteProvider );
//
//   return !!remoteProvider.isVcs;
// }

//

function hooksPathGet()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return will.HooksPathGet( will.environmentPath );
}

//

function environmentPathSet( src )
{
  let will = this;

  _.assert( src === null || _.strDefined( src ) );

  if( !src )
  {
    will._.environmentPath = src;
    return src;
  }

  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  src = path.canonize( src );

  _.assert( !path.isTrailed( src ) );
  _.assert( path.isAbsolute( src ) );

  will._.environmentPath = src;
  return src;
}

//

function environmentPathFind( dirPath )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return _.will.environmentPathFind({ fileProvider, dirPath });
}

// --
// etc
// --

function _verbosityChange()
{
  let will = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !will.fileProvider || will.fileProvider.logger !== will.logger );

  if( will.fileProvider )
  will.fileProvider.verbosity = will.verbosity-2;

}

//

// function verbosityGet()
// {
//   let will = this;
//   let transaction = will.transaction;
//   let logger = will.logger;

//   if( transaction )
//   return transaction.verbosity;

//   return logger.verbosity;
// }

//

function vcsProviderFor( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !_.mapIs( o ) )
  o = { filePath : o }

  _.assert( arguments.length === 1 );
  _.routine.options_( vcsProviderFor, o );
  _.assert( !!will.formed );

  if( _.arrayIs( o.filePath ) && o.filePath.length === 0 )
  return null;

  if( !o.filePath )
  return null;

  let result = fileProvider.providerForPath( o.filePath );

  if( !result )
  return null

  if( !result.isVcs )
  return null

  return result;
}

vcsProviderFor.defaults =
{
  filePath : null,
}

//

// function vcsToolsFor( o )
// {
//   let will = this;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;

//   if( !_.mapIs( o ) )
//   o = { filePath : o }

//   _.assert( arguments.length === 1 );
//   _.routine.options_( vcsToolsFor, o );
//   _.assert( !!will.formed );

//   if( _.arrayIs( o.filePath ) && o.filePath.length === 0 )
//   return null;

//   if( !o.filePath )
//   return null;

//   _.assert( _.strIs( o.filePath ) );
//   _.assert( path.isGlobal( o.filePath ) );

//   let parsed = path.parseFull( o.filePath );

//   if( _.longHasAny( parsed.protocols, _.git.protocols ) )
//   return _.git;
//   if( _.longHasAny( parsed.protocols, _.npm.protocols ) )
//   return _.npm;

//   return null;
// }

// vcsToolsFor.defaults =
// {
//   filePath : null,
// }

//

function repoFrom( o )
{
  let will = this;

  _.assert( _.mapIs( o ) );
  _.assert( arguments.length === 1 );

  o.will = will;

  let hash = _.will.Repository.Hash({ downloadPath : o.downloadPath, remotePath : o.remotePath });
  let repo = will.repoMap[ hash ];
  if( repo )
  return repo;

  repo = will.repoMap[ hash ] = new _.will.Repository( o );

  return repo;
}

//

function resourceWrap( o )
{
  let will = this;

  if( o && !_.mapIs( o ) )
  if( o instanceof _.will.Module )
  o = { module : o }
  else if( o instanceof _.will.ModuleOpener )
  o = { opener : o }
  else if( o instanceof _.will.ModuleJunction )
  o = { junction : o }

  return o;
}

//

function resourcesInfoExport( o )
{
  let will = this;
  let result = Object.create( null );

  o = _.routine.options_( resourcesInfoExport, arguments );

  let names =
  {
    openersArray : 'openers',
    modulesArray : 'modules',
    willfilesArray : 'willfiles',
  }

  for( let n in names )
  {
    if( n === 'willfilesArray' )
    result[ names[ n ] ] = _.filter_( null, will[ n ], ( willf ) => willf.filePath + ' # ' + willf.id );
    else
    result[ names[ n ] ] = _.filter_( null, will[ n ], ( e ) => e.commonPath + ' # ' + e.id );
  }

  result.openersErrors = _.filter_( null, will.openersErrorsArray, ( r ) => r.err.originalMessage || r.err.message );

  if( o.stringing )
  result = _.entity.exportStringNice( result );

  return result;
}

resourcesInfoExport.defaults =
{
  stringing : 1,
}

//

function _pathChanged( o )
{
  let will = this;
  let logger = will.transaction.logger;

  if( !Config.debug )
  return;

  o.ex = _.path.simplify( o.ex );
  o.val = _.path.simplify( o.val );
  if( o.isIdential === null )
  o.isIdentical = o.ex === o.val || _.entityIdentical( o.val, o.ex );
  /* qqq xxx : try _.entity.identical() */

  if( o.val )
  if( o.propName === 'currentRemotePath' || o.propName === 'currentRemote' )
  {
    logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.propName, _.entity.exportStringNice( o.val ) );
  }

  // if( o.val )
  // if( o.propName === 'remotePath' || o.propName === 'remote' )
  // if( o.object.id === 690 || o.object.id === 692 )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.propName, _.entity.exportStringNice( o.val ) );
  //   debugger;
  // }

  // if( o.val )
  // if( o.propName === 'remotePath' || o.propName === 'remote' )
  // if( o.object.id === 1086 )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.propName, _.entity.exportStringNice( o.val ) );
  //   debugger;
  // }

  // if( o.val )
  // if( o.propName === 'outPath' || o.propName === 'out' )
  // if( o.object.id === 209 || o.object.id === 84 )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.propName, _.entity.exportStringNice( o.val ) );
  //   debugger;
  // }

  // if( o.val )
  // if( o.propName === 'download' )
  // // if( o.object.isOut && !o.object.isRemote )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.propName, _.entity.exportStringNice( o.val ) );
  //   debugger;
  // }

  // if( o.propName === 'module.original.willfiles' )
  // if( o.object.isOut )
  // if( o.val )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.propName, _.entity.exportStringNice( o.val ) );
  //   debugger;
  // }

  // if( o.propName === 'willfilesPath' || o.propName === 'module.willfiles' )
  // if( _.strIs( o.val ) && _.strHas( o.val, 'wTools.out' ) )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.propName, _.entity.exportStringNice( o.val ) );
  //   // debugger;
  // }

  // if( o.propName === 'willfilesPath' || o.propName === 'module.willfiles' )
  // {
  //   logger.log( o.object.absoluteName, o.kind, o.propName, _.entity.exportStringNice( o.val ) );
  //   debugger;
  // }

  // if( _.strIs( o.ex ) && _.strEnds( o.ex, '/wTools.out.will' ) )
  // debugger;
  // if( _.strIs( o.val ) && _.strEnds( o.val, '/wTools.out.will' ) )
  // debugger;

  // if( !o.isIdential )
  // logger.log( o.object.absoluteName, o.kind, o.propName, _.entity.exportStringNice( o.val ) );

}

_pathChanged.defaults =
{
  val : null,
  ex : null,
  isIdentical : null,
  object : null,
  propName : null,
  kind : null,
}

//

function versionGet()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  let packageJsonPath = path.join( __dirname, '../../../../../package.json' );
  let packageJson =  fileProvider.fileRead({ filePath : packageJsonPath, encoding : 'json', logger : _.logger.relativeMaybe( will.transaction.logger, will.fileProviderVerbosityDelta ) });
  return packageJson.version
}

//

function versionIsUpToDate( o )
{
  let will = this;

  _.assert( arguments.length === 1 );
  _.routine.options_( versionIsUpToDate, o );

  let ready = _.process.start
  ({
    execPath : 'npm view willbe version',
    inputMirroring : 0,
    outputPiping : 0,
    outputCollecting : 1,
  });

  ready.finally( ( err, result ) =>
  {
    if( err )
    throw _.err( err, '\nFailed to check version of utility willbe' );

    let currentVersion = parse( will.versionGet() );
    let latestVersion = parse( _.strStrip( result.output ) );

    let upToDate = true;
    for( let i = 0; i < currentVersion.length; i++ )
    if( currentVersion[ i ] < latestVersion[ i ] )
    {
      upToDate = false;
      break;
    }

    if( upToDate )
    {
      logger.log( `Current version: ${ currentVersion.join( '.' ) }. Utility willbe is up to date.` );
    }
    else
    {
      let message =
      [
        '╔════════════════════════════════════════════════════════════╗',
        '║ Utility willbe is out of date!                             ║',
        `║ Current version: ${ currentVersion.join( '.' ) }`,
        `║ Latest: ${ latestVersion.join( '.' ) }`,
        '║ Please run: "npm r -g willbe && npm i -g willbe" to update.║',
        '╚════════════════════════════════════════════════════════════╝'
      ];

      message[ 2 ] = message[ 2 ] + _.strDup( ' ', message[ 4 ].length - message[ 2 ].length - 1 ) + '║';
      message[ 3 ] = message[ 3 ] + _.strDup( ' ', message[ 4 ].length - message[ 3 ].length - 1 ) + '║';

      message = message.join( '\n' );

      let coloredMessage = _.color.strBg( message, 'yellow' );

      if( !o.throwing )
      {
        logger.log( coloredMessage );
        return false;
      }

      throw _.errBrief( coloredMessage );
    }
    // if( !upToDate )
    // {
    //   let message =
    //   [
    //     '╔════════════════════════════════════════════════════════════╗',
    //     '║ Utility willbe is out of date!                             ║',
    //     `║ Current version: ${ currentVersion.join( '.' ) }`,
    //     `║ Latest: ${ latestVersion.join( '.' ) }`,
    //     '║ Please run: "npm r -g willbe && npm i -g willbe" to update.║',
    //     '╚════════════════════════════════════════════════════════════╝'
    //   ]
    //
    //   message[ 2 ] = message[ 2 ] + _.strDup( ' ', message[ 4 ].length - message[ 2 ].length - 1 ) + '║';
    //   message[ 3 ] = message[ 3 ] + _.strDup( ' ', message[ 4 ].length - message[ 3 ].length - 1 ) + '║';
    //
    //   message = message.join( '\n' )
    //
    //   let coloredMessage = _.color.strBg( message, 'yellow' );
    //
    //   if( !o.throwing )
    //   {
    //     logger.log( coloredMessage );
    //     return false;
    //   }
    //
    //   throw _.errBrief( coloredMessage );
    // }
    // else
    // {
    //   logger.log( `Current version: ${ currentVersion.join( '.' ) }. Utility willbe is up to date.` );
    // }

    return true;
  });

  return ready;

  function parse( src )
  {
    let parts = _.strSplitNonPreserving({ src, delimeter : '.' });
    return parts.map( ( p ) => parseInt( p ) );
  }
}

versionIsUpToDate.defaults =
{
  throwing : 1,
}

//

// function withSubmodulesGet()
// {
//   let will = this;

//   _.assert( arguments.length === 0 );

//   return will._.withSubmodules;
//   // let withSubmodules = will._.withSubmodules;
//   // if( withSubmodules !== null && withSubmodules !== undefined )
//   // {
//   //   return withSubmodules;
//   // }
//   //
//   // if( !will.subModulesFormedOfMain )
//   // return 0;
//   // else if( will.subModulesFormedOfSub )
//   // return 2;
//   // else
//   // return 1;
// }

//

// function withSubmodulesSet( src )
// {
//   let will = this;

//   _.assert( arguments.length === 1 );
//   _.assert( _.boolIs( src ) || _.numberIs( src ) || src === null );

//   if( _.boolIs( src ) )
//   src = src ? 1 : 0;

//   will._.withSubmodules = src;

//   if( src === null )
//   {
//   }
//   else if( src )
//   {
//     will.subModulesFormedOfMain = true;
//     if( src === 2 )
//     {
//       will.subModulesFormedOfSub = true;
//       return 2;
//     }
//     else
//     {
//       will.subModulesFormedOfSub = false;
//       return 1;
//     }
//   }
//   else
//   {
//     will.subModulesFormedOfMain = false;
//     will.subModulesFormedOfSub = false;
//     return 0;
//   }

// }

//

function recursiveValueDeduceFromBuild( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let result = null;

  _.routine.options_( recursiveValueDeduceFromBuild, arguments );

  if( will.transaction.withSubmodules !== null )
  return will.transaction.withSubmodules;

  o.modules = _.array.as( o.modules );

  _.all( o.modules, ( module ) =>
  {

    let builds = module._buildsResolve
    ({
      name : o.name,
      criterion : o.criterion,
      kind : o.kind,
    });

    if( builds.length === 1 )
    if( builds[ 0 ].withSubmodules !== null )
    {
      if( result )
      result = Math.max( result, builds[ 0 ].withSubmodules );
      else
      result = builds[ 0 ].withSubmodules;
      if( result === 2 )
      return false;
    }

    return true;
  });

  // logger.log( ` . recursiveValueDeduceFromBuild ${result}` );

  return result;
}

recursiveValueDeduceFromBuild.defaults =
{
  modules : null,
  name : null,
  criterion : null,
  kind : null,
}

// --
// defaults
// --

function filterDefaults( o )
{
  let will = this.form();

  _.assert( will.transaction instanceof _.will.Transaction );

  // if( o.withEnabledSubmodules === null && will.transaction.withEnabled !== undefined && will.transaction.withEnabled !== null )
  // o.withEnabledSubmodules = will.transaction.withEnabled;
  // if( o.withDisabledSubmodules === null && will.transaction.withDisabled !== undefined && will.transaction.withDisabled !== null )
  // o.withDisabledSubmodules = will.transaction.withDisabled;
  // if( o.withEnabledModules === null && will.transaction.withEnabled !== undefined && will.transaction.withEnabled !== null )
  // o.withEnabledModules = will.transaction.withEnabled;
  // if( o.withDisabledModules === null && will.transaction.withDisabled !== undefined && will.transaction.withDisabled !== null )
  // o.withDisabledModules = will.transaction.withDisabled;

  for( let n in _.Will.RelationFilterDefaults )
  {
    // if( o[ n ] === null && will[ n ] !== undefined && will[ n ] !== null )
    // o[ n ] = will[ n ];
    if( o[ n ] === null )
    {
      if( will.transaction[ n ] !== undefined && will.transaction[ n ] !== null )
      o[ n ] = will.transaction[ n ];
      else if( will[ n ] !== undefined && will[ n ] !== null )
      o[ n ] = will[ n ];
    }
  }

  return o;
}

//

function instanceDefaultsApply( o )
{
  let will = this;

  _.assert( arguments.length === 1 );

  for( let d in will.OpeningDefaults )
  {
    if( o[ d ] === null )
    // o[ d ] = will[ d ];
    o[ d ] = will.transaction[ d ];
  }

  return o;
}

//

function instanceDefaultsSupplement( o )
{
  let will = this;

  _.assert( arguments.length === 1 );

  // for( let d in will.OpeningDefaults )
  // {
  //   if( o[ d ] !== null && o[ d ] !== undefined )
  //   if( will[ d ] === null )
  //   will[ d ] = o[ d ];
  // }

  _.assert( 0, 'not tested' );

  let transaction = will.transaction;
  let transactionOpeningOpts = _.mapOnlyNulls( _.mapOnly_( null, transaction, will.OpeningDefaults ) );
  if( !_.map.isEmpty( transactionOpeningOpts ) )
  {
    _.props.supplement( transactionOpeningOpts, _.mapOnly_( null, o, will.OpeningDefaults ) );
    will.transaction = transaction.cloneExtending( transactionOpeningOpts );
    transaction.finit();
  }

  return will;
}

//

function instanceDefaultsExtend( o )
{
  let will = this;

  _.assert( arguments.length === 1 );

  // for( let d in will.OpeningDefaults )
  // {
  //   if( o[ d ] !== null && o[ d ] !== undefined )
  //   will[ d ] = o[ d ];
  // }

  let transaction = will.transaction;
  will.transaction = transaction.cloneExtending( _.mapOnly_( null, o, will.OpeningDefaults ) );
  transaction.finit();

  return will;
}

//

function instanceDefaultsReset()
{
  let will = this;
  let FieldsOfTightGroups = will.FieldsOfTightGroups;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  // for( let d in will.OpeningDefaults )
  // {
  //   _.assert( FieldsOfTightGroups[ d ] !== undefined );
  //   _.assert( _.primitiveIs( FieldsOfTightGroups[ d ] ) );
  //   will[ d ] = FieldsOfTightGroups[ d ];
  // }

  will.transaction.finit();
  will.transaction = _.will.Transaction({ isInitial : 1, targetLogger : will.logger })

  return will;
}

//

function prefer( o )
{
  let will = this;
  let ready = new _.Consequence();

  o = _.routine.options_( prefer, arguments );

  forward();
  will.instanceDefaultsApply( o );
  forward();
  will.instanceDefaultsExtend( o );

  return will;

  function forward()
  {

    if( _.boolLike( o.allOfMain ) )
    {
      o.allOfMain = !!o.allOfMain;
      if( o.attachedWillfilesFormedOfMain === null )
      o.attachedWillfilesFormedOfMain = o.allOfMain;
      if( o.peerModulesFormedOfMain === null )
      o.peerModulesFormedOfMain = o.allOfMain;
      if( o.subModulesFormedOfMain === null )
      o.subModulesFormedOfMain = o.allOfMain;
      if( o.resourcesFormedOfMain === null )
      o.resourcesFormedOfMain = o.allOfMain;
    }

    if( _.boolLike( o.allOfSub ) )
    {
      o.allOfSub = !!o.allOfSub;
      if( o.attachedWillfilesFormedOfSub === null )
      o.attachedWillfilesFormedOfSub = o.allOfSub;
      if( o.peerModulesFormedOfSub === null )
      o.peerModulesFormedOfSub = o.allOfSub;
      if( o.subModulesFormedOfSub === null )
      o.subModulesFormedOfSub = o.allOfSub;
      if( o.resourcesFormedOfSub === null )
      o.resourcesFormedOfSub = o.allOfSub;
    }

  }

}

prefer.defaults =
{

  attachedWillfilesFormedOfMain : null,
  peerModulesFormedOfMain : null,
  subModulesFormedOfMain : null,
  resourcesFormedOfMain : null,
  allOfMain : null,

  attachedWillfilesFormedOfSub : null,
  peerModulesFormedOfSub : null,
  subModulesFormedOfSub : null,
  resourcesFormedOfSub : null,
  allOfSub : null,

  verbosity : null,
  // recursiveExport : null,

}

// --
// module
// --

function moduleAt( willfilesPath )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );

  let commonPath = _.Will.CommonPathFor( willfilesPath );

  return will.moduleWithCommonPathMap[ commonPath ];
}

//

// function filterImplied()
// {
//   let will = this;
//   let result = Object.create( null );

//   result.withDisabledModules = will.transaction.withDisabled;
//   result.withEnabledModules = will.transaction.withEnabled;

//   for( let f in will.FilterFields )
//   {
//     if( f === 'withDisabled' )
//     continue;
//     if( f === 'withEnabled' )
//     continue;
//     result[ f ] = will[ f ];
//   }

//   return result;
// }

function filterImplied()
{
  let will = this;
  let result = Object.create( null );
  let transaction = will.transaction;

  _.assert( transaction instanceof _.will.Transaction );

  result.withDisabledModules = will.transaction.withDisabled; /* qqq : for Vova : ? */
  result.withEnabledModules = will.transaction.withEnabled;

  for( let f in will.FilterFields )
  {
    if( f === 'withDisabled' ) /* qqq : for Vova : ? */
    continue;
    if( f === 'withEnabled' )
    continue;
    _.assert( _.definedIs( transaction[ f ] ) )
    result[ f ] = transaction[ f ];
  }

  return result;
}

//

function moduleFit_head( routine, args )
{
  let module = this;

  let junction = args[ 0 ];
  let opts = args[ 1 ];
  opts = _.routine.options_( routine, opts );
  _.assert( args.length === 2 );

  return _.unroll.from([ junction, opts ]);
}

function moduleFit_body( object, opts )
{
  let will = this;
  let logger = will.transaction.logger;

  let junction = will.junctionFrom( object );
  let module = object.toModule();
  if( !module )
  module = junction.module;

  _.assert( arguments.length === 2 );
  _.assert( junction instanceof _.will.ModuleJunction );

  if( !opts.withKnown && junction.object )
  return false;

  if( !opts.withUnknown && !junction.object )
  return false;

  if( !opts.withValid && junction.object )
  if( junction.object.isValid() )
  {
    return false;
  }

  if( !opts.withInvalid && junction.object )
  if( !junction.object.isValid() )
  {
    return false;
  }

  if( !opts.withOut && junction.isOut !== null )
  if( junction.isOut )
  return false;

  if( !opts.withIn && junction.isOut !== null )
  if( !junction.isOut )
  return false;

  if( !opts.withEnabledModules && module )
  if( module.about.enabled )
  return false;

  if( !opts.withDisabledModules && module )
  if( !module.about.enabled )
  return false;

  return true;
}

var defaults = moduleFit_body.defaults = _.props.extend( null, ModuleFilterDefaults );

defaults.withStem = 0;
defaults.withPeers = 0;

let moduleFit = _.routine.uniteCloning_replaceByUnite( moduleFit_head, moduleFit_body );

//

function relationFit_body( object, opts )
{
  let will = this;
  let logger = will.transaction.logger;
  let junction = will.junctionFrom( object );
  let relation = object;

  if( !( object instanceof _.will.ModulesRelation ) )
  relation = junction.relation;

  _.assert( arguments.length === 2 );
  _.assert( will.ObjectIs( object ) || _.will.isJunction( object ) );

  let result = will.moduleFit.body.call( will, object, _.mapOnly_( null, opts, will.moduleFit.defaults ) );
  if( !result )
  return result;

  if( !opts.withOptionalSubmodules )
  if( !relation || relation.isOptional() )
  return false;

  if( !opts.withMandatorySubmodules && relation )
  if( !relation.isOptional() )
  return false;

  if( !opts.withEnabledSubmodules && relation )
  if( relation.enabled )
  return false;

  if( !opts.withDisabledSubmodules && relation )
  if( !relation.enabled )
  return false;

  return true;
}

var defaults = relationFit_body.defaults =
{

  ... moduleFit.defaults,
  ... RelationFilterDefaults,

}

let relationFit = _.routine.uniteCloning_replaceByUnite( moduleFit_head, relationFit_body );

//

function modulesFilter( junctions, o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let result = [];

  _.assert( arguments.length === 2 );
  _.assert( _.arrayIs( junctions ) );
  o = _.routine.options_( modulesFilter, o );

  junctions.forEach( ( module ) =>
  {
    let junction = module;
    junction = will.junctionFrom( module );
    if( will.moduleFit.body.call( will, junction, o ) )
    result.push( module );
  });

  return result;
}

modulesFilter.defaults = _.props.extend( null, moduleFit.defaults );

//

function relationsFilter( junctions, o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let result = [];

  _.assert( arguments.length === 2 );
  _.assert( _.arrayIs( junctions ) );
  o = _.routine.options_( relationsFilter, o );

  junctions.forEach( ( module ) =>
  {
    let junction = module;
    // if( !( junction instanceof _.will.ModuleJunction ) )
    junction = will.junctionFrom( module );
    if( will.relationFit.body.call( will, junction, o ) )
    result.push( module );
  });

  return result;
}

relationsFilter.defaults = _.props.extend( null, relationFit.defaults );
// relationsFilter.defaults.withDisabledStem = 0;

//

function moduleIdUnregister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 1 );
  _.assert( openedModule instanceof _.will.Module );
  _.assert( openedModule.id > 0 );

  _.assert( will.moduleWithIdMap[ openedModule.id ] === openedModule || will.moduleWithIdMap[ openedModule.id ] === undefined );
  delete will.moduleWithIdMap[ openedModule.id ];
  _.assert( _.longCountElement( _.props.vals( will.moduleWithIdMap ), openedModule ) === 0 );
  _.arrayRemoveOnceStrictly( will.modulesArray, openedModule );

}

//

function moduleIdRegister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( openedModule instanceof _.will.Module );
  _.assert( arguments.length === 1 );
  _.assert( openedModule.id > 0 );

  _.assert( will.moduleWithIdMap[ openedModule.id ] === openedModule || will.moduleWithIdMap[ openedModule.id ] === undefined );
  will.moduleWithIdMap[ openedModule.id ] = openedModule;
  _.assert( _.longCountElement( _.props.vals( will.moduleWithIdMap ), openedModule ) === 1 );
  _.arrayAppendOnceStrictly( will.modulesArray, openedModule );

}

//

function modulePathUnregister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 1 );
  _.assert( openedModule instanceof _.will.Module );
  _.assert( openedModule._registeredPath === null || openedModule._registeredPath === openedModule.commonPath );

  if( !openedModule._registeredPath )
  return;

  if( openedModule.commonPath )
  {
    let registered = will.moduleWithCommonPathMap[ openedModule._registeredPath ];
    _.assert( _.strIs( openedModule._registeredPath ) );
    // _.assert( registered === openedModule || !openedModule.isPreformed() );
    _.assert( registered === openedModule || registered === undefined );
    delete will.moduleWithCommonPathMap[ openedModule._registeredPath ];
    openedModule._registeredPath = null;
  }

  _.assert( _.longCountElement( _.props.vals( will.moduleWithCommonPathMap ), openedModule ) === 0 );

}

//

function modulePathRegister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  openedModule._registeredPath = openedModule.commonPath;

  _.assert( openedModule instanceof _.will.Module );
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( openedModule.commonPath ) );

  _.assert
  (
    will.moduleWithCommonPathMap[ openedModule.commonPath ] === openedModule
    || will.moduleWithCommonPathMap[ openedModule.commonPath ] === undefined,
    () => 'Different instance of ' + openedModule.constructor.name + ' is registered at ' + openedModule.commonPath
  );
  will.moduleWithCommonPathMap[ openedModule.commonPath ] = openedModule;
  _.assert( _.longCountElement( _.props.vals( will.moduleWithCommonPathMap ), openedModule ) === 1 );

}

//

function moduleNew( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.transaction.logger;

  o = _.routine.options_( moduleNew, arguments );

  if( o.localPath )
  o.localPath = path.join( path.current(), o.localPath );
  else
  o.localPath = path.join( path.current(), './' );

  if( !o.name )
  o.name = path.name( o.localPath );

  _.assert( _.strDefined( o.name ) );
  _.assert( _.longHas( [ 'throw', 'ignore' ], o.collision ) );

  let code =
`
about :

  name : ${o.name}

build :

  export :
    criterion :
      default : 1
      export : 1
    steps :
      step::module.export
`

  if( fileCheck( '.im.will.yml' ) )
  return o.localPath;
  if( fileCheck( '.ex.will.yml' ) )
  return o.localPath;
  if( fileCheck( '.will.yml' ) )
  return o.localPath;
  if( path.isTrailed( o.localPath ) )
  {
    if( fileCheck( 'im.will.yml' ) )
    return o.localPath;
    if( fileCheck( 'ex.will.yml' ) )
    return o.localPath;
    if( fileCheck( 'will.yml' ) )
    return o.localPath;
  }

  let filePath = path.isTrailed( o.localPath ) ? o.localPath + 'will.yml' : o.localPath + '.will.yml';

  _.assert( !fileProvider.fileExists( filePath ) );
  fileProvider.fileWrite( filePath, code );

  if( o.verbosity )
  logger.log( `Create module::${o.name} at ${o.localPath}` );

  return o.localPath;

  function fileCheck( postfix )
  {
    let filePath = o.localPath + postfix;
    if( fileProvider.fileExists( filePath ) )
    {
      if( o.collision === 'throw' )
      throw _.errBrief( `Cant make a new module::${o.name} at ${o.localPath}\nWillfile at ${filePath} already exists!` );
      else if( o.collision === 'ignore' )
      return o.localPath;
    }
  }

}

moduleNew.defaults =
{
  localPath : null,
  withPath : null,
  name : null,
  verbosity : 0,
  collision : 'throw', /* 'throw', 'ignore' */
}

//

function modulesFindEachAt( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.transaction.logger;
  let errs = [];

  _.sure( _.strDefined( o.selector ), 'Expects string' );
  _.assert( arguments.length === 1 );

  will.readingBegin();

  if( _.strEnds( o.selector, '::' ) )
  o.selector = o.selector + '*';

  /* */

  let opener = o.currentOpener;
  if( !opener )
  {
    opener = will._openerMake
    ({
      opener :
      {
        willfilesPath : path.trail( path.current() ),
        searching : 'strict',
        reason : 'each',
      }
    });
    opener.find();
  }
  opener.open();

  let op = Object.create( null );
  op.options = o;
  op.errs = [];
  op.openers = [];

  let con = opener.openedModule.ready.split()
  .then( () =>
  {
    let con2 = new _.Consequence();
    let resolved = opener.openedModule.submodulesResolve
    ({
      selector : o.selector,
      preservingIteration : 1,
      pathUnwrapping : 1,
    });

    if( !_.mapIs( resolved ) )
    resolved = _.array.as( resolved );

    _.each( resolved, ( it ) =>
    {
      _.assert( it.currentModule instanceof _.will.Module );
      _.assert( it.currentModule.userArray[ 0 ] instanceof _.will.ModuleOpener );
      _.arrayAppendOnce( op.openers, it.currentModule.userArray[ 0 ], ( e ) => e.openedModule );
      return it;
    })

    return op;
  })
  .finally( ( err, arg ) =>
  {
    if( err )
    {
      op.errs.push( _.err( err ) );
      if( o.onError )
      o.onError( err );
      throw err;
    }

    let filter = _.mapOnly_( null, o, will.modulesFilter.defaults );
    let openers2 = will.modulesFilter( op.openers, filter );
    if( !o.atLeastOne || openers2.length )
    op.openers = openers2;

    op.junctions = _.longOnce( will.junctionsFrom( op.openers ) );

    op.sortedOpeners = will.graphTopSort( op.openers );
    op.sortedOpeners.reverse();

    op.sortedOpeners = op.sortedOpeners.filter( ( object ) =>
    {
      _.assert( will.ObjectIs( object ) );
      if( _.longHas( op.openers, object ) )
      return object;
    });

    op.sortedOpeners.forEach( ( opener ) =>
    {
      _.assert( opener instanceof _.will.ModuleOpener );
    });

    return op;
  });

  return con;
}

modulesFindEachAt.defaults =
{
  currentOpener : null,
  selector : null,
  onBegin : null,
  onEnd : null,
}

//

function modulesFindWithAt( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.transaction.logger;
  let con;

  o = _.routine.options_( modulesFindWithAt, arguments );
  _.sure( _.strDefined( o.selector ), 'Expects string' );
  _.assert( arguments.length === 1 );

  will.filterDefaults( o );

  /* */

  will.readingBegin();
  con = _.take( null );

  let op = Object.create( null );
  op.options = o;
  op.errs = [];
  op.openers = [];

  let visitedFilesSet = new Set();
  let files;
  try
  {
    files = will.willfilesFind
    ({
      commonPath : o.selector,
      tracing : o.tracing,
      withIn : o.withIn,
      withOut : o.withOut,
      excludingUnderscore : 1,
    });
  }
  catch( err )
  {
    throw _.err( err );
  }

  /* xxx : replace by concurrent, maybe */
  files.forEach( ( file ) =>
  {
    let context = Object.create( null );
    context.file = file;
    context.opener = null;
    con
    .then( ( arg ) => moduleOpen( context ) )
    .finally( ( err, arg ) => moduleEnd( context, err, arg ) )
  });

  con.finally( ( err, arg ) => end( err, arg ) );

  return con;

  /* */

  function moduleOpen( context )
  {
    if( visitedFilesSet.has( context.file ) )
    return null;

    let selectedFiles = will.willfilesSelectPaired( context.file, files );
    let willfilesPath = selectedFiles.map( ( file ) =>
    {
      visitedFilesSet.add( file );
      return file.absolute;
    });

    context.opener = will._openerMake
    ({
      opener :
      {
        willfilesPath,
        searching : 'exact',
        reason : 'with',
      }
    });

    context.opener.find();
    // if( _.boolLike( will.transaction.withSubmodules ) && context.opener.openedModule )
    // {
    //   context.opener.openedModule.stager.stageStateSkipping( 'subModulesFormed', !will.transaction.withSubmodules );
    // }
    context.opener.open();

    return context.opener.openedModule.ready.split()
    .then( function( arg )
    {
      _.assert( context.opener.willfilesArray.length > 0 );
      let l = op.openers.length;
      _.arrayAppendOnce( op.openers, context.opener, ( e ) => e.openedModule );
      _.assert( l < op.openers.length );
      _.assert( !_.longHas( op.openers, null ) )
      return arg;
    })
  }

  /* */

  function moduleEnd( context, err, arg )
  {
    if( err )
    {
      err = _.err( err );
      op.errs.push( err );
      if( o.withInvalid && context.opener && context.opener.openedModule )
      {
        _.arrayAppendOnce( op.openers, context.opener );
      }
      else if( context.opener )
      {
        context.opener.finit();
      }
      logger.error( _.errOnce( err ) );
      return null;
    }
    return arg;
  }

  /* */

  function end( err, arg )
  {
    if( !op.openers.length )
    if( !err )
    err = op.errs[ 0 ];

    if( err )
    {
      _.arrayAppendOnce( op.errs, err );
      throw err;
    }

    {
      let filter = _.mapOnly_( null, o, will.modulesFilter.defaults );
      let openers2 = will.modulesFilter( op.openers, filter );
      if( !o.atLeastOne || openers2.length )
      op.openers = openers2;
    }

    op.junctions = _.longOnce( will.junctionsFrom( op.openers ) );
    // op.sortedJunctions = will.graphTopSort( op.junctions );
    // op.sortedJunctions.reverse();

    // op.sortedOpeners = op.openers.slice();
    // op.sortedOpeners.forEach( ( opener ) => _.assert( opener instanceof _.will.ModuleOpener ) );

    op.sortedOpeners = will.graphTopSort( op.openers );
    op.sortedOpeners.reverse();

    op.sortedOpeners = op.sortedOpeners.filter( ( object ) =>
    {
      _.assert( will.ObjectIs( object ) );
      // _.assert( opener instanceof _.will.ModuleOpener );
      // if( object instanceof _.will.ModuleOpener )
      if( _.longHas( op.openers, object ) )
      return object;
    });

    op.sortedOpeners.forEach( ( opener ) =>
    {
      _.assert( opener instanceof _.will.ModuleOpener );
    });

    // op.sortedOpeners = [];
    // op.sortedJunctions = _.filter_( null, op.sortedJunctions, ( junction ) =>
    // {
    //   let opener = _.arraySetIntersection( op.openers.slice(), junction.openers )[ 0 ];
    //   if( !opener )
    //   return;
    //   _.assert( !opener.superRelation );
    //   op.sortedOpeners.push( opener );
    //   return junction;
    // });

    return op;
  }

  /* */

}

var defaults = modulesFindWithAt.defaults = _.props.extend( null, ModuleFilterNulls );

defaults.withEnabledSubmodules = null;
defaults.withDisabledSubmodules = null;
defaults.selector = null;
defaults.tracing = null;
defaults.atLeastOne = 1;

//

function modulesOnlyRoots( modules )
{
  let will = this;
  let visitedContainer = _.containerAdapter.from( new Set );
  let junctionMap = will.junctionMap;

  if( modules === null || modules === undefined )
  modules = will.modulesArray;

  _.assert( _.longIs( modules ) );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  let filter =
  {
    withPeers : 1,
    withStem : 1,
    ... _.Will.RelationFilterOn,
  }

  let nodesGroup = will.graphGroupMake( _.mapOnly_( null, filter, will.graphGroupMake.defaults ) );

  /* first make junctions for each module */

  let o2 =
  {
    ... filter,
    modules,
    revisiting : 0,
    recursive : 2,
    outputFormat : '*/object',
    nodesGroup,
  }

  let objects = will.modulesEach( o2 );

  objects = will.objectsAllVariants( objects );
  // objects.forEach( ( object ) =>
  // {
  //   _.arrayAppendArrayOnce( objects, will.junctionFrom( object ).objects );
  // });

  /* then add in-roots of trees */

  let sources = nodesGroup.sourcesFromNodes( objects );

  /* xxx : temp fix */

  let o3 =
  {
    ... filter,
    modules : sources,
    revisiting : 0,
    withStem : 0,
    withPeers : 1,
    recursive : 2,
    outputFormat : '*/object',
    nodesGroup,
  }

  // let sourcesHasObjects = will.modulesEach( o3 );
  // let sourcesHasVariants = will.objectsToVariants( sourcesHasObjects );
  // sourcesHasObjects = will.objectsAllVariants( sourcesHasObjects );

  /* xxx : use only one variant instead of all
  */

  sources = _.longOnce( sources, ( object ) => will.junctionFrom( object ) );
  sources = sources.filter( ( object ) =>
  {
    let junction = will.junctionFrom( object );
    if( !junction.object )
    return false;
    if( !junction.isOut )
    return true;
    if( junction.peer && _.longHasAny( sources, junction.peer.objects ) )
    return false;
    // if( _.longHas( sourcesHasVariants, junction ) ) /* xxx : temp workaround */
    // {
    //   debugger; xxx
    //   return false;
    // }
    return true;
  });

  // sources = sources.filter( ( junction ) =>
  // {
  //   if( !junction.object )
  //   return false;
  //   if( !junction.isOut )
  //   return true;
  //   if( junction.peer && _.longHas( sources, junction.peer ) )
  //   return false;
  //   return true;
  // });

  return sources;
}

modulesOnlyRoots.defaults =
{
}

//

function modulesEach_head( routine, args )
{
  let will = this;

  let o = args[ 0 ]
  if( _.routineIs( args[ 0 ] ) )
  o = { onUp : args[ 0 ] };
  o = _.routine.options_( routine, o );
  _.assert( args.length === 0 || args.length === 1, () => `Expects optional argument, but got ${args.length} arguments` );
  _.assert( _.longHas( _.will.ModuleVariant, o.outputFormat ) ) /* xxx : add '* / junction' */

  return o;
}

function modulesEach_body( o )
{
  let will = this;
  let logger = will.transaction.logger;

  _.assert( !o.visitedContainer || !!o.nodesGroup, 'Expects nodesGroup if visitedContainer provided' );
  _.routine.assertOptions( modulesEach_body, o );

  if( !o.nodesGroup )
  o.nodesGroup = will.graphGroupMake( _.mapOnly_( null, o, will.graphGroupMake.defaults ) );

  if( !o.ownedObjects )
  o.ownedObjects = [];
  o.modules = _.array.as( o.modules );
  o.modules.forEach( objectAppend );
  _.assert( will.ObjectsAreAll( o.modules ) );

  /* */

  let nodes = _.array.as( o.modules );
  nodes = _.filter_( null, nodes, ( node ) =>
  {
    if( _.will.isJunction( node ) )
    return _.unroll.from( node.objects );
    return node;
  });

  if( o.withPeers )
  {
    let nodes2 = nodes.slice();
    nodes.forEach( ( object ) =>
    {
      if( object.peerModule )
      _.arrayAppendOnce( nodes2, o.nodesGroup.nodeFrom( object.peerModule ) );
    });
    nodes = nodes2;
  }

  _.each( nodes, ( node ) =>
  {
    _.assert( will.ObjectIs( node ) );
  });

  /* */

  let filter = _.mapOnly_( null, o, _.Will.prototype.relationFit.defaults );

  will.assertGraphGroup( o.nodesGroup, o );
  let o2 = _.mapOnly_( null, o, o.nodesGroup.each.defaults );
  o2.roots = nodes;
  o2.onUp = handleUp;
  o2.onDown = handleDown;
  _.assert( _.boolLike( o2.left ) );

  o.result = o.nodesGroup.each( o2 );
  o.result = _.longOnce( o.result.map( ( junction ) => outputFrom( junction ) ) );

  if( o.descriptive )
  return o;
  else
  return o.result;

  /* */

  function objectAppend( object )
  {

    _.assert( !!object );
    _.assert
    (
      object instanceof _.will.Module
      || object instanceof _.will.ModuleOpener
      || object instanceof _.will.ModulesRelation
      || object instanceof _.will.ModuleJunction
    );
    if( object instanceof _.will.ModuleJunction )
    _.arrayAppendOnce( o.ownedObjects, object.objects );
    else
    o.ownedObjects.push( object );
    return object;
  }

  /* */

  function handleUp( object, context )
  {

    _.assert( will.ObjectIs( object ) );
    let junction = will.junctionFrom( object );

    if( o.withDisabledStem && context.level === 0 )
    {
      let filter2 = _.props.extend( null, filter );
      filter2.withDisabledSubmodules = 1;
      filter2.withDisabledModules = 1;
      context.continueNode = will.relationFit( object, filter2 );
    }
    else
    {
      context.continueNode = will.relationFit( object, filter );
    }

    if( context.continueNode )
    {
      junction.objects.forEach( ( object ) =>
      {
        if( object.ownedBy( o.ownedObjects ) )
        objectAppend( object );
      });
    }

    if( o.onUp )
    o.onUp( outputFrom( object ), context );

  }

  /* */

  function handleDown( object, context )
  {
    if( o.onDown )
    o.onDown( outputFrom( object ), context );
  }

  /* */

  function outputFrom( object )
  {
    if( o.outputFormat === '*/module' )
    {
      return object.toModule();
    }
    else if( o.outputFormat === '*/relation' )
    {
      return object.toRelation();
    }
    else if( o.outputFormat === '*/object' )
    {
      _.assert( will.ObjectIs( object ) );
      return object;
    }
    else if( o.outputFormat === '*/handle' )
    {
      if( object instanceof _.will.ModuleHandle )
      return object;
      return _.will.ModuleHandle({ object, junction : will.junctionFrom( object ) });
    }
    else if( o.outputFormat === '/' )
    {
      if( object instanceof _.will.ModuleJunction )
      return object;
      return will.junctionFrom( object );
    }
    else _.assert( 0 );
  }

  /* */

}

var defaults = modulesEach_body.defaults =
{

  ... _.props.extend( null, _.graph.AbstractNodesGroup.prototype.each.defaults ),
  ... _.props.extend( null, relationFit.defaults ),

  withPeers : 0,
  withStem : 0,
  withoutDuplicates : 0,
  withDisabledStem : null,

  modules : null,
  ownedObjects : null,
  outputFormat : '*/module',
  descriptive : 0,
  onUp : null,
  onDown : null,
  recursive : 1,
  nodesGroup : null,

}

_.assert( defaults.withStem === 0 );
_.assert( defaults.withDisabledStem === null );
_.assert( defaults.withDisabledSubmodules === 0 );
_.assert( defaults.withDisabledModules === 0 );
_.assert( defaults.withPeers === 0 );

let modulesEach = _.routine.uniteCloning_replaceByUnite( modulesEach_head, modulesEach_body );
let modulesEachAll = _.routineDefaults( null, modulesEach, RelationFilterOn );

//

function modulesFor_head( routine, args )
{
  let module = this;

  _.assert( arguments.length === 2 );
  _.assert( args.length <= 2 );

  let o = args[ 0 ];

  o = _.routine.options_( routine, o );

  return o;
}

function modulesFor_body( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let visitedJunctionsSet = new Set;
  let visitedModulesSet = new Set;
  let visitedObjectSet = new Set;

  _.assert( arguments.length === 1 );
  _.routine.assertOptions( modulesFor_body, arguments );

  if( !o.nodesGroup )
  o.nodesGroup = will.graphGroupMake( _.mapOnly_( null, o, will.graphGroupMake.defaults ) );
  o.modules = _.array.as( o.modules );

  _.assert( _.arrayIs( o.modules ) );
  _.assert( will.ObjectsAreAll( o.modules ) );

  let rootJunctions = _.longOnce( will.junctionsFrom( o.modules ) );
  let objects = objectsEach( o.modules );

  return act( objects )
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err );
    return o;
  });

  /* */

  function act( objects )
  {
    let ready = _.take( null );

    ready.then( () =>
    {
      if( !o.onEachJunction )
      return null;
      let ready = _.take( null );
      let junctions = _.longOnce( will.junctionsFrom( objects ) );
      junctions.forEach( ( junction ) => ready.then( () => junctionAction( junction ) ) );
      return ready;
    });

    ready.then( () =>
    {
      if( !o.onEachVisitedObject && !o.onEachModule )
      return null;
      let ready = _.take( null );
      objects.forEach( ( object ) => ready.then( () => objectAction( object ) ) );
      return ready;
    });

    ready.then( () =>
    {
      let objects2 = objectsEach( objects );
      if( objects2.length > objects.length && o.recursive >= 2 )
      return act( objects2 );
      return o;
    });

    return ready;
  }

  /* */

  function objectsEach( objects )
  {
    let o2 = _.mapOnly_( null, o, will.modulesEach.defaults );
    o2.outputFormat = '*/object';
    o2.modules = objects;
    let result = will.modulesEach( o2 );
    return result;
  }

  /* */

  function objectAction( object )
  {
    _.assert( will.ObjectIs( object ) );
    let ready = _.take( null );
    let junction = object.toJunction();
    let isRoot = _.longHas( rootJunctions, junction );

    if( o.onEachVisitedObject )
    {
      let objects = [ object ];

      objects.forEach( ( object ) =>
      {
        if( visitedObjectSet.has( object ) )
        return null;
        visitedObjectSet.add( object );

        if( o.onEachVisitedObject )
        {
          let o3 = _.props.extend( null, o );
          o3.object = object;
          o3.isRoot = isRoot;
          ready.then( () => o.onEachVisitedObject( object, o3 ) );
        }

      });
    }

    if( o.onEachModule )
    {
      let objects2 = [ object ];
      _.arrayAppendArrayOnce( objects2, junction.modules );

      objects2.forEach( ( object ) =>
      {
        if( visitedModulesSet.has( object ) )
        return null;
        visitedModulesSet.add( object );

        if( object && object instanceof _.will.Module )
        {
          let o3 = _.props.extend( null, o );
          o3.module = object;
          o3.isRoot = isRoot;
          ready.then( () => o.onEachModule( object, o3 ) );
          ready.then( () =>
          {
            /* update module if it is reopened in build */
            for( let i = 0 ; i < objects.length ; i++ )
            if( objects[ i ] === object )
            objects[ i ] = _.resolve( will.moduleWithNameMap, object.name );
            return null;
          });
        }

      });
    }

    return ready;
  }

  /* */

  function junctionAction( junction )
  {
    _.assert( junction instanceof _.will.ModuleJunction );
    if( visitedJunctionsSet.has( junction ) )
    return null;
    let ready = _.take( null );
    visitedJunctionsSet.add( junction );
    let isRoot = _.longHas( rootJunctions, junction );

    if( o.onEachJunction )
    {
      let o3 = _.props.extend( null, o ); /* xxx : object inherit? */
      o3.junction = junction;
      o3.isRoot = isRoot;
      ready.then( () => o.onEachJunction( junction, o3 ) );
    }
    return ready;
  }

  /* */

}

var defaults = modulesFor_body.defaults = _.props.extend
(
  null,
  modulesEach.defaults,
  relationFit.defaults
);

defaults.recursive = 1;
defaults.withPeers = 1;
defaults.withStem = 1; /* yyy */
defaults.left = 1;
defaults.nodesGroup = null;
defaults.modules = null;
defaults.onEachJunction = null;
defaults.onEachModule = null;
defaults.onEachVisitedObject = null;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

_.assert( defaults.onEach === undefined );
_.assert( defaults.withDisabledSubmodules === 0 );
_.assert( defaults.withDisabledModules === 0 );

let modulesFor = _.routine.uniteCloning_replaceByUnite( modulesFor_head, modulesFor_body );

//

function modulesDownload_head( routine, args )
{
  let will = this;

  _.assert( arguments.length === 2 );
  _.assert( args.length <= 2 );

  let o = args[ 0 ];

  o = _.routine.options_( routine, o );
  _.assert( _.longHas( [ 'download', 'update', 'agree' ], o.mode ) );

  will.filterDefaults( o );

  return o;
}

function modulesDownload_body( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let time = _.time.now();
  let downloadedLengthWas = 0;

  if( !o.downloadedContainer )
  o.downloadedContainer = [];
  if( !o.localContainer )
  o.localContainer = [];
  if( !o.remoteContainer )
  o.remoteContainer = [];
  if( !o.doneContainer )
  o.doneContainer = [];
  if( !o.nodesGroup )
  o.nodesGroup = will.graphGroupMake( _.mapOnly_( null, o, will.graphGroupMake.defaults ) );

  _.routine.assertOptions( modulesDownload_body, arguments );
  o.modules = _.array.as( o.modules );
  _.assert( _.arrayIs( o.modules ) );
  _.assert( will.ObjectsAreAll( o.modules ) );
  _.assert( arguments.length === 1 );

  let filter = _.mapOnly_( null, o, _.Will.prototype.relationsFilter.defaults );
  filter.withOut = false;
  if( o.withDisabledStem )
  {
    filter.withDisabledSubmodules = 1;
    filter.withDisabledModules = 1;
  }
  o.modules = will.relationsFilter( o.modules, filter );

  if( !o.modules.length )
  return _.Consequence().take( o );

  let rootModule = o.modules.length === 1 ? o.modules[ 0 ] : null;
  let rootJunctions = _.array.as( will.junctionsFrom( o.modules ) );

  return objectsUpformAndDownload( o.modules )
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, '\nFailed to', ( o.mode ), 'submodules' );
    log();
    return o;
  });

  /* */

  function objectsUpformAndDownload( objects )
  {
    let ready = _.take( null );

    ready.then( () => renormalize() );

    ready.then( () => /* xxx : remove the stage? */
    {
      let o2 = _.mapOnly_( null, o, will.modulesUpform.defaults );
      o2.modules = objects;
      o2.recursive = o.recursive;
      o2.all = 0;
      if( o2.recursive === 2 )
      o2.subModulesFormed = 1;
      o2.withPeers = 1;
      return will.modulesUpform( o2 );
    });

    ready.then( ( arg ) =>
    {
      let o2 = _.mapOnly_( null, o, will.modulesEach.defaults );
      o2.outputFormat = '*/object';
      o2.modules = objects;
      o2.withPeers = 1; /* xxx */
      o2.withIn = 1;
      o2.withOut = 1;
      delete o2.nodesGroup;
      objects = will.modulesEach( o2 );
      downloadedLengthWas = o.downloadedContainer.length;
      return objectsDownload( objects );
    });

    ready.then( () =>
    {
      let d = o.downloadedContainer.length - downloadedLengthWas;
      if( d > 0 && o.recursive >= 2 )
      return objectsUpformAndDownload( objects );
      return o;
    });

    return ready;
  }

  /* */

  function log()
  {

    rootJunctions = rootJunctions.filter( ( junction ) =>
    {
      if( !junctionIsRoot( junction ) )
      return;
      if( junction.isOut && junction.peer )
      if( _.longHas( rootJunctions, junction.peer ) )
      return;
      return junction;
    });
    let remoteContainer = o.remoteContainer.filter( ( junction ) =>
    {
      if( junctionIsRoot( junction ) )
      return;
      if( !junction.module && junction.relation && !junction.relation.enabled )
      return;
      return !junction.isOut || !_.longHas( o.remoteContainer, junction.peer );
    });
    let localContainer = o.localContainer.filter( ( junction ) =>
    {
      if( junctionIsRoot( junction ) )
      return;
      if( !junction.module && junction.relation && !junction.relation.enabled )
      return;
      return !junction.isOut || !_.longHas( o.localContainer, junction.peer );
    });

    if( !o.downloadedContainer.length && !o.loggingNoChanges )
    return;

    let ofModule = rootModule ? ' of ' + ( rootModule.toModule() ? rootModule.toModule() : rootModule ).absoluteName : '';
    let total = ( remoteContainer.length + localContainer.length );
    logger.rbegin({ verbosity : -2 });
    let phrase = '';
    if( o.mode === 'update' )
    phrase = 'updated';
    else if( o.mode === 'agree' )
    phrase = 'agreed';
    else if( o.mode === 'download' )
    phrase = 'downloaded';
    if( o.dry )
    {
      logger.log( ' + ' + o.downloadedContainer.length + '/' + total + ' submodule(s)' + ofModule + ' will be ' + phrase );
    }
    else
    {
      logger.log( ' + ' + o.downloadedContainer.length + '/' + total + ' submodule(s)' + ofModule + ' were ' + phrase + ' in ' + _.time.spent( time ) );
    }
    logger.rend({ verbosity : -2 });

  }

  /* */

  function objectsDownload( objects )
  {
    let ready2 = _.take( null );

    _.assert( _.arrayIs( objects ) );
    let handles = _.longOnce_( null, will.handlesFrom( objects ), ( handle ) => handle.object );

    handles.forEach( ( handle ) => /* xxx : make it parallel */
    {
      let junction = handle.junction;

      // _.assert( _.will.isJunction( junction ) );

      if( !junction.object )
      {
        // debugger; /* xxx : check */
        return;
      }

      _.assert
      (
        !!junction.object,
        () => `No object for ${junction.localPath}`
      );

      if( _.longHas( o.doneContainer, junction ) )
      return null;

      _.assert
      (
        !!junction.opener,
        () => 'Submodule' + ( junction.relation ? junction.relation.qualifiedName : junction.module.qualifiedName ) + ' was not opened or downloaded'
      );

      _.assert
      (
        !!junction.opener && junction.opener.formed >= 2,
        () => 'Submodule' + ( junction.opener ? junction.opener.qualifiedName : n ) + ' was not preformed to download it'
      );

      if( junctionIsRoot( junction ) )
      return junctionLocalMaybe( junction );
      if( !junction.isRemote || !junction.relation )
      return junctionLocalMaybe( junction );
      // if( junction.relation && !junction.relation.enabled )
      if( junction.relation && !junction.relation.enabled && !o.withDisabledSubmodules )
      return junctionLocalMaybe( junction );

      ready2.then( () =>
      {
        return junctionDownload( junction );
      });

    });

    return ready2;
  }

  /* */

  function junctionDownload( junction )
  {

    if( _.longHas( o.localContainer, junction ) || _.longHas( o.localContainer, junction ) )
    {
      _.assert( 0, 'unexpected' );
    }

    if( _.longHas( o.doneContainer, junction ) )
    return junctionDone( junction );

    if( junction.peer )
    {
      if( _.longHas( o.doneContainer, junction.peer ) )
      {
        return junctionDone( junction );
      }
    }

    if( !junction.relation )
    {
      let junction2 = will.junctionMap[ junction.remotePath ];
      if( junction2 && junction2 !== junction )
      throw _.err
      (
        'Different versions of the same submodule are not allowed.',
        `\n${junction.name} -> ${junction.remotePath}`,
        `\n${junction2.name} -> ${junction2.remotePath}`
      )
    }

    _.assert( !!junction.relation && !!junction.relation.opener );
    let opener = junction.relation.opener;

    junctionRemote( junction );
    junctionDone( junction );
    if( junction.peer )
    {
      junctionDone( junction.peer );
    }

    if( o.mode === 'update' )
    if( o.to )
    junction.opener.remotePathChangeVersionTo( o.to );

    if( o.dry )
    {
      let statusOptions =
      {
        downloadRequired : o.mode === 'download',
        updateRequired : o.mode === 'update',
        agreeRequired : o.mode === 'agree',
      }

      return junction.opener.repo.status( statusOptions )
      .then( ( result ) =>
      {
        if( result.downloadRequired || result.updateRequired || result.agreeRequired )
        junctionDownloaded( junction );
        return null;
      })
    }
    else
    {
      let o2 = _.mapOnly_( null, o, opener._repoDownload.defaults );
      let r = _.Consequence.From( opener._repoDownload( o2 ) );
      return r.then( ( downloaded ) =>
      {
        _.assert( _.boolIs( downloaded ) );
        if( downloaded )
        junctionDownloaded( junction );
        return downloaded;
      });
    }

  }

  /* */

  function junctionIsRoot( junction )
  {
    // if( junction.isRemote ) /* Vova: root modules now have a remote path, isRemote can be true for a root module */
    // return false;
    if( _.longHas( rootJunctions, junction ) )
    return true;
    if( rootJunctions.some( ( rootJunction ) => rootJunction.peer === junction ) )
    return true;
    return false;
  }

  /* */

  function junctionDownloaded( junction )
  {
    _.arrayAppendOnceStrictly( o.downloadedContainer, junction );
  }

  /* */

  function junctionLocalMaybe( junction )
  {
    if( junction.isRemote )
    return junctionRemote( junction );

    if( junction.peer && junction.peer.object && junction.peer.isRemote )
    return junctionRemote( junction );

    junctionLocal( junction );
  }

  /* */

  function junctionRemote( junction )
  {
    _.assert( !!junction.remotePath );
    _.arrayAppendOnce( o.remoteContainer, junction );
    _.assert( !_.longHas( o.localContainer, junction ) );
    return null;
  }

  /* */

  function junctionLocal( junction )
  {
    if( junction.peer )
    {
      if( _.longHas( o.doneContainer, junction.peer ) )
      return junctionDone( junction );
    }

    if( _.longHas( o.doneContainer, junction ) )
    return null;

    _.assert( _.strIs( junction.localPath ) );
    _.arrayAppendOnce( o.localContainer, junction );

    return null;
  }

  /* */

  function junctionDone( junction )
  {
    _.arrayAppendOnce( o.doneContainer, junction );
    return null;
  }

  /* */

  function renormalize()
  {
    let ready = _.take( null );
    rootJunctions.forEach( ( junction ) =>
    {
      ready.then( () =>
      {
        let module = junction.module;
        let localPath = module.localPath;
        return module.repo.renormalize( localPath );
      });
    })
    return ready;
  }
}

var defaults = modulesDownload_body.defaults = _.props.extend
(
  null,
  modulesEach.defaults,
  relationFit.defaults
);

defaults.mode = 'download';
defaults.strict = 1;
defaults.dry = 0;
defaults.modules = null;
defaults.rootModulePath = null;
defaults.downloadedContainer = null;
defaults.localContainer = null;
defaults.remoteContainer = null;
defaults.doneContainer = null;

defaults.loggingNoChanges = 1;
defaults.recursive = 1;
defaults.withStem = 1;
defaults.withOut = 1;
defaults.withIn = 1;
defaults.withPeers = 1;
defaults.nodesGroup = null;

defaults.to = null;

delete defaults.withPeers;
delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

let modulesDownload = _.routine.uniteCloning_replaceByUnite( modulesDownload_head, modulesDownload_body );

//

function modulesUpform( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  o = _.routine.options_( modulesUpform, arguments );

  let o2 = _.mapOnly_( null, o, will.modulesFor.defaults );
  o2.onEachModule = handleEach;
  return will.modulesFor( o2 )
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, `\nFailed to upform modules` );
    return arg;
  });

  /* */

  function handleEach( module, op )
  {
    let will = module.will;
    let opener = module.toOpener();
    let isMain = opener.isMain;
    if( !isMain && opener.openedModule && will.mainOpener && will.mainOpener.openedModule === opener.openedModule )
    isMain = true;

    let subModulesFormed = isMain ? will.transaction.subModulesFormedOfMain : will.transaction.subModulesFormedOfSub

    let o3 = _.mapOnly_( null, o, module.upform.defaults ); /* xxx : not optimal */

    if( o3.subModulesFormed === null )
    o3.subModulesFormed = subModulesFormed;

    return module.upform( o3 );
  }

}

var defaults = modulesUpform.defaults = _.props.extend( null, UpformingDefaults, modulesFor.defaults );

defaults.recursive = 2;
defaults.withStem = 1;
defaults.withPeers = 1;
defaults.all = 1;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

//

function modulesClean( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let files = Object.create( null );
  let visitedObjectSet = new Set;

  o = _.routine.options_( modulesClean, arguments );

  if( o.beginTime === null )
  o.beginTime = _.time.now();

  let o2 = _.mapOnly_( null, o, will.modulesFor.defaults );
  o2.onEachVisitedObject = handleEach;

  return will.modulesFor( o2 )
  .then( ( arg ) =>
  {
    let o2 = _.mapOnly_( null, o, will.cleanDelete.defaults );
    o2.files = files;
    verifyNotDeleteItself();
    return will.cleanDelete( o2 );
  })
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, `\nFailed to clean modules` );

    let o2 = _.mapOnly_( null, o, will.cleanLog.defaults );
    o2.files = files;
    will.cleanLog( o2 );

    return arg;
  });

  /* */

  function handleEach( module, op )
  {
    module = module.toModule();
    if( !( module instanceof _.will.Module ) )
    return null;
    if( visitedObjectSet.has( module ) )
    return null;
    visitedObjectSet.add( module );
    let o3 = _.mapOnly_( null, o, module.cleanWhatSingle.defaults );
    o3.files = files;
    return module.cleanWhatSingle( o3 );
  }

  /* */

  function verifyNotDeleteItself()
  {
    let willfilesPath;

    _.each( o.modules, ( object ) =>
    {
      let module = object;

      if( object instanceof _.will.ModuleOpener )
      module = object.openedModule;

      const willfilesPath = _.array.as( module.willfilesPath );
      if( _.longHasAny( files[ '/' ], willfilesPath ) )
      {
        const msg = `${ module.qualifiedName } should not delete itself. Please, set correct {-path::out-} and {-path::temp-}`;
        throw _.errBrief( msg );
      }
    });
  }
}

var defaults = modulesClean.defaults = _.props.extend( null, modulesFor.defaults );

defaults.dry = 0;
defaults.fast = 0;
defaults.beginTime = null;
defaults.cleaningSubmodules = 1;
defaults.cleaningOut = 1;
defaults.cleaningTemp = 1;
defaults.asCommand = 0;

defaults.recursive = 0;
defaults.withStem = 1;
defaults.withPeers = 1;
defaults.force = 0;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

//

function modulesBuild_head( routine, args )
{
  let o = _.routine.options_( routine, args );
  if( o.doneContainer === null )
  o.doneContainer = [];
  return o;
}

function modulesBuild_body( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let ready = _.take( null );

  o = _.routine.assertOptions( modulesBuild_body, arguments );
  _.assert( _.arrayIs( o.doneContainer ) );

  let recursive = will.recursiveValueDeduceFromBuild( _.mapOnly_( null, o, will.recursiveValueDeduceFromBuild.defaults ) );

  ready.then( () =>
  {
    if( !o.downloading )
    return null;
    let o2 = _.mapOnly_( null, o, will.modulesDownload.defaults );
    o2.loggingNoChanges = 0;
    if( o2.recursive === 0 )
    {
      if( recursive === null )
      o2.recursive = 0;
      // o2.recursive = 1; /* Dmytro : by default module should not download submodules, use step `submodules.download` to download it */
      else
      o2.recursive = recursive;
    }
    o2.strict = 0;
    o2.withOut = 0;
    o2.withIn = 1;
    return will.modulesDownload( o2 );
  })

  ready.then( () =>
  {
    if( !o.upforming || o.downloading )
    return null;
    let o2 = _.mapOnly_( null, o, will.modulesUpform.defaults );
    o2.all = 0;
    if( o2.recursive === 0 )
    {
      if( recursive === null )
      {
        o2.recursive = 0;
      }
      else
      {
        o2.recursive = recursive;
      }
      if( o2.recursive )
      o2.subModulesFormed = 1;
      else
      o2.subModulesFormed = 0;
    }
    o2.peerModulesFormed = 1;
    o2.withOut = 0;
    o2.withIn = 1;
    return will.modulesUpform( o2 );
  })

  ready.then( () =>
  {
    let o2 = _.mapOnly_( null, o, will.modulesFor.defaults );
    o2.onEachModule = moduleBuild;
    o2.left = 0;
    o2.withOut = 0;
    o2.withIn = 1;
    return will.modulesFor( o2 );
  })

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, `\nFailed to ${o.kind}` );
    return arg;
  })

  return ready;

  /* */

  function moduleBuild( module, op )
  {
    let o3 = _.mapOnly_( null, o, module.moduleBuild.defaults );
    o3.isRoot = op.isRoot;
    _.assert( module instanceof _.will.Module );
    if( _.longHas( o.doneContainer, module ) )
    return null;
    o.doneContainer.push( module );
    return module.moduleBuild( o3 );
  }
}

var defaults = modulesBuild_body.defaults =
{
  ... _.props.extend( null, modulesFor.defaults ),

  name : null,
  criterion : null,
  kind : 'build',

  modules : null,
  implied : null,
  doneContainer : null,
  recursive : 0,
  withStem : 1,
  withDisabledStem : 1,
  withPeers : 1,
  upforming : 1,
  downloading : 1,
  purging : 0,
};

delete defaults.onEach;
delete defaults.onEachModule;
delete defaults.onEachJunction;
delete defaults.withOut;
delete defaults.withIn;

_.assert( defaults.outputFormat === undefined );
_.assert( defaults.withIn === undefined );
_.assert( defaults.onEach === undefined );
_.assert( defaults.withDisabledSubmodules === 0 );
_.assert( defaults.withDisabledModules === 0 );

let modulesBuild = _.routine.uniteCloning_replaceByUnite( modulesBuild_head, modulesBuild_body );
modulesBuild.defaults.kind = 'build';
modulesBuild.defaults.downloading = 1;

let modulesExport = _.routine.uniteCloning_replaceByUnite( modulesBuild_head, modulesBuild_body );
modulesExport.defaults.kind = 'export';
modulesExport.defaults.downloading = 1;

let modulesPublish = _.routine.uniteCloning_replaceByUnite( modulesBuild_head, modulesBuild_body );
modulesPublish.defaults.kind = 'publish';
modulesPublish.defaults.downloading = 0;

//

function modulesVerify_head( routine, args )
{
  let o = _.routine.options_( routine, args );
  return o;
}

function modulesVerify_body( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let ready = _.take( null );
  let verifiedNumber = 0;
  let totalNumber = 0;
  let time = _.time.now();

  o = _.routine.assertOptions( modulesVerify_body, arguments );

  logger.up();

  ready.then( () =>
  {
    let o2 = _.mapOnly_( null, o, will.modulesFor.defaults );
    o2.onEachVisitedObject = moduleVerify;
    return will.modulesFor( o2 );
  })

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, `\nFailed to verify` );

    if( o.asMap )
    return { verifiedNumber, totalNumber };

    let ofModule = ' ';
    if( o.modules.length === 1 )
    {
      let module = o.modules[ 0 ];
      module = module.toModule() || module.toOpener() || module;
      ofModule = ` of ${module.decoratedAbsoluteName} `;
    }

    logger.log( `${verifiedNumber} / ${totalNumber} submodule(s)${ofModule}were verified in ${_.time.spent( time )}` );
    logger.down();

    return arg;
  })

  return ready;

  /* */

  function moduleVerify( object, op )
  {
    if( object instanceof _.will.ModulesRelation )
    if( object.opener )
    object = object.opener;
    if( !( object instanceof _.will.Module || object instanceof _.will.ModuleOpener ) )
    return null;
    if( object instanceof _.will.ModuleOpener )
    if( object.openedModule )
    object = object.openedModule;
    let o3 = _.mapOnly_( null, o, object.repoVerify.defaults );
    _.assert( object instanceof _.will.Module || object instanceof _.will.ModuleOpener );
    return object.repoVerify( o3 ).then( ( verified ) =>
    {
      totalNumber += 1;
      if( verified )
      verifiedNumber += 1;
      return verified;
    });
  }

  /* */

}

var defaults = modulesVerify_body.defaults =
{

  ... _.props.extend( null, modulesFor.defaults ),

  recursive : 1,
  throwing : 1,
  asMap : 0,

  hasFiles : 1,
  isValid : 1,
  isRepository : 1,
  hasRemote : 1,
  isUpToDate : 1,
  hasRemoteVersion : 1

}

delete defaults.onEach;
delete defaults.onEachModule;
delete defaults.onEachJunction;

let modulesVerify = _.routine.uniteCloning_replaceByUnite( modulesVerify_head, modulesVerify_body );

// --
// object
// --

function ObjectIs( object )
{
  let will = this;

  _.assert( arguments.length === 1 );

  if( !object )
  return false;
  if( object instanceof _.will.Module )
  return true;
  if( object instanceof _.will.ModuleOpener )
  return true;
  if( object instanceof _.will.ModulesRelation )
  return true;

  return false;
}

let ObjectsAre = _.vectorize( ObjectIs );
let ObjectsAreAll = _.vectorizeAll( ObjectIs );
let ObjectsAreAny = _.vectorizeAny( ObjectIs );
let ObjectsAreNone = _.vectorizeNone( ObjectIs );

//

function ObjectsExportInfo( o )
{
  let cls = this;

  if( arguments.length === 2 )
  {
    o = arguments[ 1 ];
    o.objects = arguments[ 0 ];
  }
  else
  {
    if( !_.mapIs( o ) )
    {
      o = Object.create( null );
      o.objects = arguments[ 0 ];
    }
  }

  _.routine.options_( ObjectsExportInfo, o );

  if( _.Will.ObjectIs( o.objects ) )
  o.objects = [ o.objects ];

  _.assert( _.longIs( o.objects ) );
  return o.objects.map( ( object ) =>
  {
    _.assert( _.routineIs( object.exportString ) );
    return object.exportString({ verbosity : 2 })
  }).join( '\n' );
}

ObjectsExportInfo.defaults =
{
  objects : null,
  verbosity : 2,
}

//

function ObjectsLogInfo( o )
{
  let cls = this;

  if( arguments.length === 2 )
  {
    o = arguments[ 1 ];
    o.objects = arguments[ 0 ];
  }
  else
  {
    if( !_.mapIs( o ) )
    {
      o = Object.create( null );
      o.objects = arguments[ 0 ];
    }
  }

  _.routine.options_( ObjectsLogInfo, o );
  if( o.logger === null )
  o.logger = _global_.logger;

  let info = cls.ObjectsExportInfo( _.mapOnly_( null, o, cls.ObjectsExportInfo.defaults ) );
  o.logger.log( info );

}

ObjectsLogInfo.defaults =
{
  ... ObjectsExportInfo.defaults,
  logger : null,
}

//

function objectsExportInfo( o )
{
  let will = this;
  return will.ObjectsExportInfo( ... arguments );
}

objectsExportInfo.defaults =
{
  ... ObjectsExportInfo.defaults,
}

//

function objectsLogInfo( o )
{
  let will = this;
  let logger = will.transaction.logger;

  if( arguments.length === 2 )
  {
    o = arguments[ 1 ];
    o.objects = arguments[ 0 ];
  }
  else
  {
    if( !_.mapIs( o ) )
    {
      o = Object.create( null );
      o.objects = arguments[ 0 ];
    }
  }

  _.routine.options_( objectsLogInfo, o );

  let info = will.objectsExportInfo( o );
  logger.log( info );
  return will;
}

objectsLogInfo.defaults =
{
  ... objectsExportInfo.defaults,
}

//

function objectsAllVariants( objects )
{
  let will = this;
  let result = [];

  objects.forEach( ( object ) =>
  {
    _.arrayAppendArrayOnce( result, will.junctionFrom( object ).objects );
  });

  return result;
}

//

function objectsToVariants( objects )
{
  let will = this;
  return _.longOnce( objects.map( ( object ) => object.toJunction() ) );
}

// --
// junction
// --

function junctionReform( object )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.will.ModuleJunction.Reform( object, will );
}

//

function junctionsReform( objects )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.will.ModuleJunction.Reforms( objects, will );
}

//

function junctionFrom( object )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.will.ModuleJunction.JunctionFrom( object, will );
}

//

function junctionsFrom( objects )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.will.ModuleJunction.JunctionsFrom( objects, will );
}

//

function handlesFrom( objects )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.will.ModuleHandle.Froms( objects, will );
}

//

function junctionOf( object )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.will.ModuleJunction.Of( object, will );
}

//

function junctionsOf( objects )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.will.ModuleJunction.Ofs( objects, will );
}

//

function junctionWithId( id )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.any( will.junctionMap, ( junction ) => junction.id === id ? junction : undefined );
}

// //
//
// function junctionsWithId( id )
// {
//   let will = this;
//
//   for( let v in will.junctionMap )
//   {
//     let junction = will.junctionMap[ v ];
//     if( junction.id === id )
//     return junction;
//   }
//
//   return null;
// }

//

function junctionsInfoExport( junctions )
{
  let will = this;
  if( !junctions )
  {
    junctions = _.longOnce( _.props.vals( will.junctionMap ) );
    // junctions = junctions.filter( ( junction ) =>
    // {
    //   if( junction.relation && !junction.relation.enabled )
    //   return false;
    //   if( junction.isRemote === false )
    //   return false;
    //   return junction;
    // });
  }

  return _.container.map_( null, junctions, ( junction ) => junction.exportString() ).join( '\n' );
}

// --
// graph
// --

function assertGraphGroup( group, opts )
{
  if( !Config.debug )
  return true;
  for( let c in group.context )
  _.assert( group.context[ c ] === opts[ c ] || opts[ c ] === undefined );
  return true;
}

//

function graphGroupMake( o )
{
  let will = this;

  o = _.routine.options_( graphGroupMake, arguments );
  o.will = will;

  let sys = new _.graph.AbstractGraphSystem
  ({
    onNodeIs : isNode,
    onNodeFrom : nodeFrom,
    onNodeName : nodeName,
    onNodeOutNodes : nodeOut,
    onNodeJunction : nodeJunction,
  });

  let group = sys.nodesGroup();

  group.context = o;

  return group;

  /* */

  function nodeName( object )
  {
    return will.junctionFrom( object ).name;
  }

  /* */

  function nodeJunction( object )
  {
    return will.junctionFrom( object );
  }

  /* */

  function isNode( object )
  {
    return will.ObjectIs( object );
    // if( !junction )
    // return false;
    // if( junction instanceof _.will.Module )
    // return true;
    // if( junction instanceof _.will.ModuleOpener )
    // return true;
    // if( junction instanceof _.will.ModulesRelation )
    // return true;
    // return false;
    // return junction instanceof _.will.ModuleJunction;
  }

  /* */

  function nodeFrom( object )
  {
    _.assert( will.ObjectIs( object ) );
    return object;
    // let junction = will.junctionOf( object );
    // if( junction )
    // return junction;
    // _.assert( !( object instanceof _.will.ModuleJunction ) );
    // junction = will.junctionFrom( object );
    // return junction;
  }

  /* */

  function nodeOut( object )
  {
    _.assert( will.ObjectIs( object ) );

    /*
    "junction:: : #1448
      path::local : hd:///atop/will.test/_asset/hierarchyHdBug/.module/PathTools
      module::z / module::wPathTools / opener::wPathTools #1447 #1576
      module::z / module::wPathTools / relation::wPathTools #1446 #1575
    "
    will.junctionWithId( 922 ).exportString()
    "junction:: : #922
      path::local : hd:///atop/will.test/_asset/hierarchyHdBug/group1/group10/.module/PathTools
      module::z / module::wPathTools / opener::wPathTools #921 #1050
      module::z / module::wPathTools / relation::wPathTools #920 #1049
    */

    let result = object.submodulesRelationsFilter( _.mapOnly_( null, o, object.submodulesRelationsFilter.defaults ) );

    return result;
  }

  /* */

  function onNodeInNodes( module ) /* xxx : make it working */
  {
    if( module.superRelations )
    return module.superRelations;
    if( module.subRelation )
    return [ module.subRelation ];
    return [];
  }

}

var defaults = graphGroupMake.defaults = _.props.extend( null, RelationFilterDefaults );

defaults.withPeers = 1;
defaults.withoutDuplicates = 0;

//

function graphTopSort( modules )
{
  let will = this;

  _.assert( 0 <= arguments.length && arguments.length <= 2 )

  let group = will.graphGroupMake();

  modules = modules || will.modulesArray;
  modules = group.nodesFrom( modules );
  modules = group.rootsToAllReachable( modules );

  let sorted = group.topSort( modules );

  return sorted;
}

//

function graphExportTreeInfo( modules, o )
{
  let will = this;

  o = _.routine.options_( graphExportTreeInfo, o || null );
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 )

  if( o.onNodeName === null )
  o.onNodeName = junctionNameAndPath;
  if( o.onUp === null )
  o.onUp = junctionUp;

  let group = will.graphGroupMake( _.mapOnly_( null, o, will.graphGroupMake.defaults ) );

  modules = modules || will.modulesArray;
  modules = group.nodesFrom( modules );

  if( o.onlyRoots )
  modules = will.modulesOnlyRoots( modules );

  let o2 = _.mapOnly_( null, o, group.rootsExportInfoTree.defaults );
  o2.allVariants = 0;
  o2.allSiblings = 0;

  let info = group.rootsExportInfoTree( modules, o2 );

  return info;

  /* */

  function junctionUp( object, it )
  {
    return object;
  }

  function junctionNameAndPath( object )
  {
    _.assert( will.ObjectIs( object ) );
    let junction = will.junctionFrom( object );
    let result = junction.object instanceof _.will.ModuleOpener ? 'module::' + junction.opener.name : junction.object.qualifiedName;
    if( o.withLocalPath )
    result += ` - path::local:=${_.color.strFormat( junction.localPath, 'path' )}`;
    if( o.withRemotePath && junction.remotePath )
    result += ` - path::remote:=${_.color.strFormat( junction.remotePath, 'path' )}`;
    return result;
  }

}

var defaults = graphExportTreeInfo.defaults = _.props.extend
(
  null,
  _.graph.AbstractNodesGroup.prototype.rootsExportInfoTree.defaults,
  RelationFilterDefaults
);

defaults.withDisabledModules = 1;
defaults.withDisabledSubmodules = 1;
defaults.withoutDuplicates = 1;
defaults.withLocalPath = 0;
defaults.withRemotePath = 0;
defaults.withOut = 1;
defaults.onlyRoots = 1;

// --
// opener
// --

function _openerMake_head( routine, args )
{
  let module = this;
  let o = args[ 0 ];

  if( _.strIs( o ) || _.arrayIs( o ) )
  o = { selector : o }

  _.routine.options_( routine, o );
  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( !o.isMain || !o.mainOpener || !o.opener || o.mainOpener === o.opener );

  return o;
}

function _openerMake_body( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.transaction.logger;
  let madeOpener = null;

  _.assert( arguments.length === 1 );
  _.routine.assertOptions( _openerMake_body, arguments );

  try
  {

    if( !o.opener )
    o.opener = o.opener || Object.create( null );
    o.opener.will = will;

    if( !o.willfilesPath && !o.opener.willfilesPath )
    o.willfilesPath = o.willfilesPath || fileProvider.path.current();
    if( o.willfilesPath )
    o.opener.willfilesPath = o.willfilesPath;

    if( !( o.opener instanceof _.will.ModuleOpener ) )
    o.opener = madeOpener = _.will.ModuleOpener( o.opener );

    _.assert( o.opener instanceof _.will.ModuleOpener );

    if( o.searching )
    o.opener.searching = o.searching;

    if( !o.opener.will )
    o.opener.will = will;

    o.opener.preform()

    return o.opener;
  }
  catch( err )
  {
    if( o.throwing )
    throw _.err( err, `\nFailed to make module at ${o.opener.willfilesPath}` );

    return null;
  }
}

_openerMake_body.defaults =
{

  opener : null,
  throwing : 1,

}

let _openerMake = _.routine.uniteCloning_replaceByUnite( _openerMake_head, _openerMake_body );

//

function openerMakeManual( o )
{
  let will = this;

  o = _.routine.options_( openerMakeManual, arguments );
  o.opener = o.opener || Object.create( null );
  o.opener.reason = o.opener.reason || 'user';
  if( o.willfilesPath )
  o.opener.willfilesPath = o.willfilesPath;

  delete o.willfilesPath;
  return will._openerMake( o );
}

var defaults = openerMakeManual.defaults = Object.create( _openerMake.defaults );

defaults.willfilesPath = null;

//

function openersAdoptModule( module )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let result = 0;
  let commonPath = module.commonPath;

  _.assert( arguments.length === 1 );

  will.openersArray.forEach( ( opener ) =>
  {
    if( opener.commonPath !== commonPath )
    return;
    if( opener.openedModule === module )
    return;

    _.assert( opener.openedModule === null );
    opener.moduleAdopt( module );
    result += 1;

    // if( !opener.repo.isDownloaded )
    // {
    //   opener.repo.isDownloaded = true;
    // }

  });

  return result;
}

//

function openerUnregister( opener )
{
  let will = this;

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );
  delete will.openerModuleWithIdMap[ opener.id ];
  _.assert( _.longCountElement( _.props.vals( will.openerModuleWithIdMap ), opener ) === 0 );
  _.arrayRemoveOnceStrictly( will.openersArray, opener );

}

//

function openerRegister( opener )
{
  let will = this;

  _.assert( opener.id > 0 );
  will.openerModuleWithIdMap[ opener.id ] = opener;
  _.arrayAppendOnceStrictly( will.openersArray, opener );
  _.assert( _.longCountElement( _.props.vals( will.openerModuleWithIdMap ), opener ) === 1 );

}

//

function openersErrorsRemoveOf( opener )
{
  let will = this;

  _.assert( arguments.length === 1 );
  _.assert( opener instanceof _.will.ModuleOpener );

  will.openersErrorsArray = will.openersErrorsArray.filter( ( r ) =>
  {
    if( r.opener === opener )
    {
      delete will.openersErrorsMap[ r.localPath ];
      return false;
    }
  });

  return will;
}

//

function openersErrorsRemoveAll()
{
  let will = this;
  _.assert( arguments.length === 0, 'Expects no arguments' );
  will.openersErrorsArray.splice( 0, will.openersErrorsArray.length );
  _.mapDelete( will.openersErrorsMap );
}

// --
// willfile
// --

function readingReset()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  will.willfilesReadBeginTime = null;
  will.willfilesReadEndTime = null;

  return will;
}

//

function readingBegin()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  if( will.willfilesReadBeginTime )
  return will;

  will._willfilesReadBegin();

  return will;
}

//

function readingEnd()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!will.mainOpener );

  will._willfilesReadEnd( will.mainOpener ? will.mainOpener.openedModule : null );

  return will;
}

//

function _willfilesReadBegin()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( will.mainOpener === null || will.mainOpener instanceof _.will.ModuleOpener );

  will.willfilesReadBeginTime = will.willfilesReadBeginTime || _.time.now();

}

//

function _willfilesReadEnd( module )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 1 );
  _.assert( module instanceof _.will.Module );
  _.assert( will.mainOpener === null || will.mainOpener instanceof _.will.ModuleOpener );

  if( will.willfilesReadEndTime )
  return will;

  if( will.mainOpener && module === will.mainOpener.openedModule && !module.original )
  will._willfilesReadLog();

  return will;
}

//

function _willfilesReadLog()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !will.willfilesReadEndTime );

  will.willfilesReadEndTime = will.willfilesReadEndTime || _.time.now();

  // if( will.verbosity >= 2 )
  if( will.transaction.verbosity >= 2 )
  {
    let total = 0;
    will.willfilesArray.forEach( ( willf ) =>
    {
      total += _.arrayIs( willf.filePath ) ? willf.filePath.length : 1
    });
    let spent = _.time.spentFormat( will.willfilesReadEndTime - will.willfilesReadBeginTime );
    logger.log( ' . Read', total, 'willfile(s) in', spent, '\n' );
  }

}

//

// function WillfilePathIs( filePath )
// {
//   let fname = _.path.fullName( filePath );
//   let r = /\.will\.\w+/;
//   if( _.strHas( fname, r ) )
//   return true;
//   return false;
// }

//

function WillfilesFind( o )
{
  if( _.strIs( o ) )
  o = { commonPath : o };

  _.routine.options_( WillfilesFind, o );

  if( !o.fileProvider )
  o.fileProvider = _.fileSystem;
  if( !o.logger )
  o.logger = _global_.logger;

  _.assert( arguments.length === 1 );
  _.assert( _.boolIs( o.recursive ) );
  _.assert( o.recursive === false, 'not implemented' );

  const fileProvider = o.fileProvider;
  let path = fileProvider.path;
  let logger = o.logger;

  if( o.commonPath === '.' )
  o.commonPath = './';
  o.commonPath = path.normalize( o.commonPath );
  o.commonPath = _.strRemoveEnd( o.commonPath, '.' );
  o.commonPath = path.resolve( o.commonPath );

  const commonLocalPath = path.fromGlob( o.commonPath );

  _.assert( !path.isGlobal( commonLocalPath ), 'Expects local path.' );

  /* */

  let result;
  let o2 = _.mapOnly_( null, o, _.will.filesAt.defaults );

  if( !o.tracing )
  return end( _.will.filesAt( o2 ) );

  let commonPaths = path.traceToRoot( o2.commonPath );
  o2.commonPath = commonPaths[ commonPaths.length - 1 ];
  result = _.will.filesAt( o2 );
  if( result.length )
  return end( result );

  for( let d = commonPaths.length - 2 ; d >= 0 ; d-- )
  {
    o2.commonPath = path.trail( commonPaths[ d ] );
    result = _.will.filesAt( o2 );
    if( result.length )
    return end( result );
  }

  return [];

  /* */

  function end( result )
  {
    if( o.excludingUnderscore )
    result = pathsFilterUnderscores( result );

    result = outAndInWillfilesSort( result );

    if( o.outputFormat === 'descriptor' )
    return result;
    if( o.outputFormat === 'record' )
    return recordsMake( result );
    _.assert( 0, 'Unknown format of output records' );
  }

  /* */

  function pathsFilterUnderscores( paths )
  {
    let excludeRegexps = [ /(^|\/)_/, /(^|\/)-/, /(^|\/)\.will($|\/)/ ];
    return _.filter_( paths, paths, ( record ) =>
    {
      const found = _.any( excludeRegexps, ( regexp ) =>
      {
        return regexp.test( _.strRemoveBegin( record.filePath, commonLocalPath ) );
      });
      if( !found )
      return record;
    });
  }

  /* */

  function outAndInWillfilesSort( records )
  {
    let result = [];
    records.forEach( ( record ) =>
    {
      if( _.will.filePathIsOut( record.filePath ) )
      result.push( record );
    });
    records.forEach( ( record ) =>
    {
      if( !_.will.filePathIsOut( record.filePath ) )
      result.push( record );
    });
    return result;
  }

  /* */

  function recordsMake( records )
  {
    for( let i = 0 ; i < records.length ; i++ )
    records[ i ] = fileProvider.record( records[ i ].filePath );
    return records;
  }

  // if( _.strIs( o ) )
  // o = { commonPath : o };
  //
  // _.routineOptions( WillfilesFind, o );
  //
  // if( !o.fileProvider )
  // o.fileProvider = _.fileProvider;
  // if( !o.logger )
  // o.logger = _global_.logger;
  //
  // let fileProvider = o.fileProvider;
  // let path = fileProvider.path;
  // let logger = o.logger;
  //
  // if( o.commonPath === '.' )
  // o.commonPath = './';
  // o.commonPath = path.normalize( o.commonPath );
  // o.commonPath = _.strRemoveEnd( o.commonPath, '.' );
  // o.commonPath = path.resolve( o.commonPath );
  //
  // _.assert( arguments.length === 1 );
  // _.assert( _.boolIs( o.recursive ) );
  // _.assert( o.recursive === false );
  // _.assert( !path.isGlobal( path.fromGlob( o.commonPath ) ), 'Expects local path' );
  //
  // if( !o.tracing )
  // return findFor( o.commonPath );
  //
  // let commonPaths = path.traceToRoot( o.commonPath );
  //
  // {
  //   let result = findFor( commonPaths[ commonPaths.length-1 ] );
  //   if( result.length )
  //   return result;
  // }
  //
  // for( let d = commonPaths.length-1 ; d >= 0 ; d-- )
  // {
  //   let commonPath = commonPaths[ d ];
  //   let result = findFor( path.trail( commonPath ) );
  //   if( result.length )
  //   return result;
  // }
  //
  // return [];
  //
  // /* */
  //
  // function findFor( commonPath )
  // {
  //
  //   if( !path.isSafe( commonPath, 1 ) )
  //   return [];
  //
  //   let filter =
  //   {
  //     filePath : commonPath,
  //     maskTransientDirectory :
  //     {
  //     },
  //     maskDirectory :
  //     {
  //     },
  //     maskTerminal :
  //     {
  //       includeAny : /(\.|((^|\.|\/)will(\.[^.]*)?))$/,
  //       excludeAny :
  //       [
  //         /\.DS_Store$/,
  //         /(^|\/)-/,
  //       ],
  //       includeAll : []
  //     }
  //   };
  //
  //   if( o.excludingUnderscore && path.isGlob( commonPath ) )
  //   {
  //     filter.maskDirectory.excludeAny = [ /(^|\/)_/, /(^|\/)-/, /(^|\/)\.will($|\/)/ ];
  //     filter.maskTransientDirectory.excludeAny = [ /(^|\/)_/, /(^|\/)-/, /(^|\/)\.will($|\/)/ ];
  //   }
  //
  //   if( !o.withIn )
  //   filter.maskTerminal.includeAll.push( /(^|\.|\/)out(\.)/ )
  //   if( !o.withOut )
  //   filter.maskTerminal.excludeAny.push( /(^|\.|\/)out(\.)/ )
  //
  //   if( !path.isGlob( commonPath ) )
  //   filter.recursive = o.recursive ? 2 : 1;
  //
  //   let o2 =
  //   {
  //     filter,
  //     maskPreset : 0,
  //     mandatory : 0,
  //     safe : 0,
  //     mode : 'distinct',
  //   }
  //
  //   filter.filePath = path.mapExtend( filter.filePath );
  //   filter.filePath = path.filterPairs( filter.filePath, ( it ) =>
  //   {
  //     if( !_.strIs( it.dst ) )
  //     return { [ it.src ] : it.dst };
  //
  //     _.sure( !o.tracing || !path.isGlob( it.src ) )
  //
  //     let hasExt = /(^|\.|\/)will\.[^\.\/]+$/.test( it.src );
  //     let hasWill = /(^|\.|\/)will(\.)?[^\.\/]*$/.test( it.src );
  //     let hasImEx = /(^|\.|\/)(im|ex)[^\/]*$\./.test( it.src );
  //
  //     let postfix = '?(.)';
  //     if( !hasWill )
  //     {
  //       postfix += '?(im.|ex.)';
  //       if( !o.exact )
  //       if( o.withOut && o.withIn )
  //       {
  //         postfix += '?(out.)';
  //       }
  //       else if( o.withIn )
  //       {
  //         postfix += '';
  //       }
  //       else if( o.withOut )
  //       {
  //         postfix += 'out.';
  //       }
  //       postfix += 'will';
  //     }
  //
  //     if( !hasExt )
  //     postfix += '.*';
  //
  //     it.src += postfix;
  //
  //     return { [ it.src ] : it.dst };
  //   });
  //
  //   let files = fileProvider.filesFind( o2 );
  //
  //   let files2 = [];
  //   files.forEach( ( file ) =>
  //   {
  //     if( _.Will.PathIsOut( file.absolute ) )
  //     files2.push( file );
  //   });
  //   files.forEach( ( file ) =>
  //   {
  //     if( !_.Will.PathIsOut( file.absolute ) )
  //     files2.push( file );
  //   });
  //
  //   return files2;
  // }
}

WillfilesFind.defaults =
{
  commonPath : null,
  withIn : 1,
  withOut : 1,
  withExport : 1,
  withSingle : 1,
  withImport : 1,
  fileProvider : null,

  recursive : false,
  tracing : 0,
  excludingUnderscore : 0,
  outputFormat : 'record', /* Dmytro : introduced option outputFormat : [ 'record', 'descriptor' ], routines of utility looks for file records, not willfile descriptors. It saves back compatibility */
  logger : null, /* Dmytro : not used, maybe should be deleted */
};

// function WillfilesFind( o )
// {
//
//   if( _.strIs( o ) )
//   o = { commonPath : o }
//
//   _.routineOptions( WillfilesFind, o );
//
//   if( !o.fileProvider )
//   o.fileProvider = _.fileProvider;
//   if( !o.logger )
//   o.logger = _global_.logger;
//
//   const fileProvider = o.fileProvider;
//   let path = fileProvider.path;
//   let logger = o.logger;
//
//   if( o.commonPath === '.' )
//   o.commonPath = './';
//   o.commonPath = path.normalize( o.commonPath );
//   o.commonPath = _.strRemoveEnd( o.commonPath, '.' );
//   o.commonPath = path.resolve( o.commonPath );
//
//   _.assert( arguments.length === 1 );
//   _.assert( _.boolIs( o.recursive ) );
//   _.assert( o.recursive === false );
//   _.assert( !path.isGlobal( path.fromGlob( o.commonPath ) ), 'Expects local path' );
//
//   if( !o.tracing )
//   return findFor( o.commonPath );
//
//   let commonPaths = path.traceToRoot( o.commonPath );
//
//   {
//     let result = findFor( commonPaths[ commonPaths.length-1 ] );
//     if( result.length )
//     return result;
//   }
//
//   for( let d = commonPaths.length-1 ; d >= 0 ; d-- )
//   {
//     let commonPath = commonPaths[ d ];
//     let result = findFor( path.trail( commonPath ) );
//     if( result.length )
//     return result;
//   }
//
//   return [];
//
//   function findFor( commonPath )
//   {
//
//     if( !path.isSafe( commonPath, 1 ) )
//     return [];
//
//     let filter =
//     {
//       filePath : commonPath,
//       maskTransientDirectory :
//       {
//       },
//       maskDirectory :
//       {
//       },
//       maskTerminal :
//       {
//         includeAny : /(\.|((^|\.|\/)will(\.[^.]*)?))$/,
//         excludeAny :
//         [
//           /\.DS_Store$/,
//           /(^|\/)-/,
//         ],
//         includeAll : []
//       }
//     };
//
//     if( o.excludingUnderscore && path.isGlob( commonPath ) )
//     {
//       filter.maskDirectory.excludeAny = [ /(^|\/)_/, /(^|\/)-/, /(^|\/)\.will($|\/)/ ];
//       filter.maskTransientDirectory.excludeAny = [ /(^|\/)_/, /(^|\/)-/, /(^|\/)\.will($|\/)/ ];
//     }
//
//     if( !o.withIn )
//     filter.maskTerminal.includeAll.push( /(^|\.|\/)out(\.)/ )
//     if( !o.withOut )
//     filter.maskTerminal.excludeAny.push( /(^|\.|\/)out(\.)/ )
//
//     if( !path.isGlob( commonPath ) )
//     filter.recursive = o.recursive ? 2 : 1;
//
//     let o2 =
//     {
//       filter,
//       maskPreset : 0,
//       mandatory : 0,
//       safe : 0,
//       mode : 'distinct',
//     }
//
//     filter.filePath = path.mapExtend( filter.filePath );
//     filter.filePath = path.filterPairs( filter.filePath, ( it ) =>
//     {
//       if( !_.strIs( it.dst ) )
//       return { [ it.src ] : it.dst };
//
//       _.sure( !o.tracing || !path.isGlob( it.src ) )
//
//       let hasExt = /(^|\.|\/)will\.[^\.\/]+$/.test( it.src );
//       let hasWill = /(^|\.|\/)will(\.)?[^\.\/]*$/.test( it.src );
//       let hasImEx = /(^|\.|\/)(im|ex)[^\/]*$\./.test( it.src );
//
//       let postfix = '?(.)';
//       if( !hasWill )
//       {
//         postfix += '?(im.|ex.)';
//         if( !o.exact )
//         if( o.withOut && o.withIn )
//         {
//           postfix += '?(out.)';
//         }
//         else if( o.withIn )
//         {
//           postfix += '';
//         }
//         else if( o.withOut )
//         {
//           postfix += 'out.';
//         }
//         postfix += 'will';
//       }
//
//       if( !hasExt )
//       postfix += '.*';
//
//       it.src += postfix;
//
//       return { [ it.src ] : it.dst };
//     });
//
//     let files = fileProvider.filesFind( o2 );
//     // if( _.strEnds( o.commonPath, '/l2' ) )
//
//     let files2 = [];
//     files.forEach( ( file ) =>
//     {
//       if( _.will.filePathIsOut( file.absolute ) )
//       files2.push( file );
//     });
//     files.forEach( ( file ) =>
//     {
//       if( !_.will.filePathIsOut( file.absolute ) )
//       files2.push( file );
//     });
//
//     return files2;
//   }
// }
//
// WillfilesFind.defaults =
// {
//   commonPath : null,
//   withIn : 1,
//   withOut : 1,
//   exact : 0,
//   recursive : false,
//   tracing : 0,
//   excludingUnderscore : 0,
//   fileProvider : null,
//   logger : null,
// }

//

function willfilesFind( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  will.readingBegin();

  if( o.usingCache )
  {
    let result = [];
    for( let i = 0 ; i < will.willfilesArray.length ; i++ )
    {
      let willfile = will.willfilesArray[ i ];
      if( willfile.commonPath === o.commonPath )
      {
        _.each( willfile.filePath, ( filePath ) =>
        {
          result.push( fileProvider.record( filePath ) );
        });
      }
    }
    if( result.length )
    {
      return result;
    }
  }

  let o2 = _.props.extend( null, o );
  o2.logger = logger;
  o2.fileProvider = fileProvider;
  delete o2.usingCache;

  return will.WillfilesFind( o2 );
}

willfilesFind.defaults =
{
  ... _.mapBut_( null, WillfilesFind.defaults, [ 'logger', 'fileProvider' ] ),
  usingCache : 0,
};

//

function willfilesSelectPaired( record, records )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let result = [ record ];
  let commonPathMap = Object.create( null );

  _.assert( arguments.length === 2 );
  _.assert( record instanceof _.files.FileRecord );
  _.assert( _.arrayIs( records ) );

  records.forEach( ( record ) =>
  {
    let commonPath = _.Will.CommonPathFor( record.absolute );
    let array = commonPathMap[ commonPath ] = commonPathMap[ commonPath ] || [];
    _.arrayAppendOnce( array, record );
  });

  let commonPath = _.Will.CommonPathFor( record.absolute );
  let array = commonPathMap[ commonPath ] = commonPathMap[ commonPath ] || [];
  _.arrayAppendOnce( array, record );

  return array;
}

//

function willfileWithCommon( commonPath )
{
  let will = this;
  commonPath = _.Will.CommonPathFor( commonPath );
  let result = will.willfileWithCommonPathMap[ commonPath ];
  if( !result || !result.length )
  return null
  return result;
}

//

function _willfileWithFilePath( filePath )
{
  let will = this;
  let result = will.willfileWithFilePathPathMap[ filePath ];
  if( !result )
  return null
  return result;
}

//

let _willfileWithFilePath2 = _.vectorize( _willfileWithFilePath );
function willfileWithFilePath( filePath )
{
  let will = this;
  let result = _willfileWithFilePath2.apply( this, arguments );
  if( _.arrayIs( result ) )
  {
    result = result.filter( ( r ) => r !== null );
    if( !result.length )
    return null;
  }
  return result;
}

//

function willfileFor( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let r = Object.create( null );

  _.routine.options_( willfileFor, arguments );
  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o.willf ) );
  _.assert( _.longHas( [ false, 0, 'supplement' ], o.combining ) );

  o.willf.will = will;

  let willf = will.willfileWithFilePath( o.willf.filePath );
  if( willf )
  {
    r.willf = willf;
    r.new = false;
    if( o.combining === 'supplement' )
    return r;
    _.assert( !o.willf.data );
    _.assert( !o.willf.structure );
    _.array.as( willf ).forEach( ( willf ) =>
    {
      if( !o.combining )
      throw _.err( `Cant redefine willfile ${willf.filePath}, because {- o.combining -} is off` );
      willf.copy( o.willf );
    });
  }
  else
  {
    willf = new _.will.Willfile( o.willf ).preform();
    r.willf = willf;
    r.new = true;
  }

  return r;
}

willfileFor.defaults =
{
  willf : null,
  combining : false,
}

//

function willfileUnregister( willf )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.arrayRemoveOnceStrictly( will.willfileWithCommonPathMap[ willf.commonPath ], willf );
  if( !will.willfileWithCommonPathMap[ willf.commonPath ].length )
  delete will.willfileWithCommonPathMap[ willf.commonPath ];

  let filePath = _.array.as( willf.filePath );
  for( let f = 0 ; f < filePath.length ; f++ )
  {
    _.assert( will.willfileWithFilePathPathMap[ filePath[ f ] ] === willf );
    delete will.willfileWithFilePathPathMap[ filePath[ f ] ];
  }
  _.assert( _.longCountElement( _.props.vals( will.willfileWithFilePathPathMap ), willf ) === 0 );

  _.arrayRemoveOnceStrictly( will.willfilesArray, willf );

}

//

function willfileRegister( willf )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.arrayAppendOnceStrictly( will.willfilesArray, willf );

  let filePath = _.array.as( willf.filePath );
  for( let f = 0 ; f < filePath.length ; f++ )
  {
    _.assert( _.longHas( [ willf, undefined ], will.willfileWithFilePathPathMap[ filePath[ f ] ] ) );
    will.willfileWithFilePathPathMap[ filePath[ f ] ] = willf;
  }
  _.assert( _.longCountElement( _.props.vals( will.willfileWithFilePathPathMap ), willf ) === filePath.length );

  will.willfileWithCommonPathMap[ willf.commonPath ] = will.willfileWithCommonPathMap[ willf.commonPath ] || [];
  _.arrayAppendOnceStrictly( will.willfileWithCommonPathMap[ willf.commonPath ], willf );

}

// --
// convert
// --

function npmGenerateFromWillfile( o )
{
  _.assert( arguments.length === 1 );
  _.routine.options( npmGenerateFromWillfile, o );

  const will = this;
  const fileProvider = will.fileProvider;
  const path = fileProvider.path;
  const logger = _.logger.relativeMaybe( will.transaction.logger, o.logger );

  /* */

  const module = o.modules[ 0 ];
  const currentContext = o.currentContext;
  _.assert( o.modules.length === 1 );

  const packagePath = module.pathResolve
  ({
    selector : o.packagePath || '{path::out}/package.json',
    prefixlessAction : 'resolved',
    pathNativizing : 0,
    selectorIsPath : 1,
    currentContext,
  });

  const willfilesMap = _.will.fileReadAt( path.common( module.willfilesPath ) );
  const config = Object.create( null );
  for( let willfile in willfilesMap )
  _.will.transform.willfilesMerge
  ({
    dst : config,
    src : willfilesMap[ willfile ],
    onSection : _.map.extend.bind( _.map )
  });

  const data = _.will.transform.npmFromWillfile
  ({
    config,
    withDisabledSubmodules : o.withDisabledSubmodules,
  });

  if( o.entryPath )
  {
    const entryPath = module.pathResolve({ selector : o.entryPath, prefixlessAction : 'resolved', currentContext });
    data.main = path.relative( path.dir( packagePath ), entryPath );
  }
  if( o.filesPath )
  {
    const files = [];
    o.filesPath = _.array.as( o.filesPath );
    for( let i = 0 ; i < o.filesPath.length ; i++ )
    files.push( ... module.filesFromResource({ selector : o.filesPath[ i ], currentContext }) );
    data.files = path.s.relative( path.dir( packagePath ), files );
  }

  if( o.npmName )
  data.name = o.npmName;

  _.sure( !fileProvider.isDir( packagePath ), () => `${ packagePath } is dir, not safe to delete` );

  _.npm.fileFormat({ configPath : packagePath, config : data });

  return null;
}

npmGenerateFromWillfile.defaults =
{
  packagePath : null,
  entryPath : null,
  filesPath : null,
  npmName : null,

  modules : null,
  currentContext : null,
  withDisabledSubmodules : 0,

  logger : 2,
};

//

function willfileGenerateFromNpm( o )
{
  _.assert( arguments.length === 1 );
  _.routine.options( willfileGenerateFromNpm, o );

  const will = this;
  const fileProvider = will.fileProvider;
  const path = fileProvider.path;
  const logger = _.logger.relativeMaybe( will.transaction.logger, o.logger );
  const inPath = will.inPath ? will.inPath : path.current();

  /* */

  _.assert( o.modules === null || o.modules.length <= 1 );
  const module = o.modules ? o.modules[ 0 ] : o.modules;
  const packagePath = pathResolveConditional( o.packagePath, '{path::in}/package.json', 'package.json' );
  const willfilePath = pathResolveConditional( o.willfilePath, '{path::out}/will.yml', 'will.yml' );

  _.sure( !fileProvider.isDir( willfilePath ), () => `${ willfilePath } is dir, not safe to delete` );
  _.sure( !fileProvider.isTerminal( willfilePath ), () => `${ willfilePath } is exists, not safe to rewrite` );
  _.sure( _.will.filePathIs( willfilePath ), () => `Expexts path to willfile, but got : ${ willfilePath }` );

  const config = fileProvider.fileRead({ filePath : packagePath, encoding : 'json', logger })
  const data = _.will.transform.willfileFromNpm({ config });

  fileProvider.fileWrite
  ({
    filePath : willfilePath,
    data,
    encoding : 'yaml',
    logger,
  });

  return null;

  /* */

  function pathResolveConditional( src, alternative1, alternative2 )
  {
    if( module )
    return module.pathResolve
    ({
      selector : src || alternative1,
      prefixlessAction : 'resolved',
      pathNativizing : 0,
      selectorIsPath : 1,
      currentContext : o.currentContext || module,
    });
    else
    return path.join( inPath, src || alternative2 );
  }
}

willfileGenerateFromNpm.defaults =
{
  packagePath : null,
  willfilePath : null,

  modules : null,
  currentContext : null,
  logger : 2,
};

//

function _requestParsePathAndSelectors( o )
{
  const will = this;
  const fileProvider = will.fileProvider;
  const path = fileProvider.path;

  if( !o.request )
  return null;

  let selectorsString = o.request;
  if( !o.commonPath || fileProvider.isDir( o.commonPath ) )
  {
    let isolated = _.strIsolateLeftOrAll( o.request, /\s+/ );
    selectorsString = isolated[ 2 ];

    if( path.isGlob( isolated[ 0 ] ) )
    {
      o.commonPath = isolated[ 0 ];
    }
    else if( isolated[ 0 ] === '.' )
    {
      o.commonPath = './';
    }
    else
    {
      let firstKey = isolated[ 0 ].split( '/' )[ 0 ];
      if( _.longHas( [ 'about', 'build', 'path', 'reflector', 'step', 'submodule' ], firstKey ) )
      {
        selectorsString = o.request;
        if( !o.commonPath )
        o.commonPath = './';
      }
      else
      {
        o.commonPath = path.join( o.commonPath, isolated[ 0 ] );
      }
    }
  }

  if( _.strDefined( selectorsString ) )
  {
    let splits = selectorsString.split( /\s+/ );
    for( let i = 0 ; i < splits.length ; i++ )
    o.selectorsMap[ splits[ i ] ] = 1;
  }
}

//

function willfilePropertyGet( o )
{
  _.assert( arguments.length === 1 );
  _.routine.options( willfilePropertyGet, o );

  const will = this;
  const fileProvider = will.fileProvider;
  const path = fileProvider.path;
  const logger = will.transaction.logger;

  _requestParsePathAndSelectors.call( will, o );

  if( _.props.keys( o.selectorsMap ).length === 0 )
  o.selectorsMap = { about : 1, build : 1, path : 1, reflector : 1, step : 1, submodule : 1 };

  /* */

  let willfile = willfileFromConfigsRead( o.commonPath );
  const result = Object.create( null );
  for( let selector in o.selectorsMap )
  {
    _.assert
    (
      _.strBegins( selector, [ 'about', 'build', 'path', 'reflector', 'step', 'submodule' ] ),
      `Invalid property selector "${ selector }". Please, improve property selector.`
    );
    if( o.selectorsMap[ selector ] )
    result[ selector ] = _.select({ src : willfile, selector });
  }

  resultLog( result );

  return null;

  /* */

  function willfileFromConfigsRead( src )
  {
    src = path.join( will.inPath ? will.inPath : path.current(), src );
    const willfilesMap = _.will.fileReadAt( src );
    const willfile = Object.create( null );
    _.each( willfilesMap, ( config ) =>
    {
      _.will.transform.willfilesMerge({ dst : willfile, src : config, onSection : _.map.extend.bind( _.map ) })
    });
    return willfile;
  }

  /* */

  function resultLog( src )
  {
    for( let selector in src )
    if( src[ selector ] === undefined )
    {
      logger.log( `${ selector } :: {-undefined-}` );
    }
    else
    {
      let value = _.entity.exportStringNice( src[ selector ] );
      if( _.primitive.is( src[ selector ] ) )
      logger.log( `${ selector } :: ${ value }` );
      else
      logger.log( `${ selector } ::\n${ value }` );
    }
  }
}

willfilePropertyGet.defaults =
{
  commonPath : null,
  request : null,
  selectorsMap : null,
  logger : 3,
};

//

function willfilePropertySet( o )
{
  _.assert( arguments.length === 1 );
  _.routine.options( willfilePropertySet, o );

  const will = this;
  const fileProvider = will.fileProvider;
  const path = fileProvider.path;
  const logger = will.transaction.logger;

  /* */

  _requestParsePathAndSelectors.call( will, o );
  selectorsMapVerify();

  o.commonPath = o.commonPath === '.' ? './' : o.commonPath;
  const willfilesMap = _.will.fileReadAt( path.join( will.inPath || path.current(), o.commonPath || './' ) );
  const willfileSet = o.structureParse ? willfileSetParsed : willfileSetPrimitive;

  for( let selector in o.selectorsMap )
  willfileSet( o.selectorsMap[ selector ], selector, willfileGetBySelector( selector ) );

  _.each( willfilesMap, ( willfile, willfilePath ) =>
  {
    fileProvider.fileWriteUnknown({ filePath : willfilePath, data : willfile, logger });
  });

  return null;

  /* */

  function selectorsMapVerify()
  {
    let count = 0;
    for( let selector in o.selectorsMap )
    {
      ++count;
      break;
    }
    _.assert( count === 1, 'Expects options to set.' );
  }

  /* */

  function willfileSetParsed( set, selector, src )
  {
    _.selectSet
    ({
      src,
      selector,
      set : _.strStructureParse( set ),
    });
  }

  /* */

  function willfileSetPrimitive( set, selector, src )
  {
    _.selectSet({ src, selector, set });
  }

  /* */

  function willfileGetBySelector( selector )
  {
    _.assert
    (
      _.strBegins( selector, [ 'about', 'build', 'path', 'reflector', 'step', 'submodule' ] ),
      `Invalid property selector "${ selector }". Please, improve property selector.`
    );

    while( selector !== '.' )
    {
      const willfile = _.any( willfilesMap, ( willfile ) =>
      {
        if( _.select( willfile, selector ) !== undefined )
        return willfile;
      });
      if( willfile )
      return willfile;
      selector = path.dir( selector );
    }

    for( let willfile in willfilesMap )
    return willfilesMap[ willfile ];
  }
}

willfilePropertySet.defaults =
{
  commonPath : null,
  request : null,
  selectorsMap : null,
  structureParse : 0,
  logger : 3,
};

//

function willfilePropertyDelete( o )
{
  _.assert( arguments.length === 1 );
  _.routine.options( willfilePropertyDelete, o );

  const will = this;
  const fileProvider = will.fileProvider;
  const path = fileProvider.path;
  const logger = will.transaction.logger;
  const selectorsCache = Object.create( null );

  /* */

  _requestParsePathAndSelectors.call( will, o );

  if( _.props.keys( o.selectorsMap ).length === 0 )
  o.selectorsMap = { about : 1, build : 1, path : 1, reflector : 1, step : 1, submodule : 1 };

  const willfilesMap = _.will.fileReadAt( path.join( will.inPath || path.current(), o.commonPath || './' ) );

  selectorsCacheMake();

  _.each( willfilesMap, ( willfile, willfilePath ) =>
  {
    willfileDeleteProperties( willfile );
    fileProvider.fileWriteUnknown({ filePath : willfilePath, data : willfile, logger });
  });

  return null;

  /* */

  function selectorsCacheMake()
  {
    for( let selector in o.selectorsMap )
    {
      _.assert
      (
        _.strBegins( selector, [ 'about', 'build', 'path', 'reflector', 'step', 'submodule' ] ),
        `Invalid property selector "${ selector }". Please, improve property selector.`
      );
      if( o.selectorsMap[ selector ] )
      selectorsCache[ selector ] = o.selectorsMap[ selector ];
    }
  }

  /* */

  function willfileDeleteProperties( willfile )
  {
    for( let selector in selectorsCache )
    _.select
    ({
      src : willfile,
      selector,
      action : _.selector.Action.del,
    });
  }
}

willfilePropertyDelete.defaults =
{
  commonPath : null,
  request : null,
  selectorsMap : null,
  logger : 3,
};

//

function willfilePropertyExtend( o )
{
  _.assert( arguments.length === 1 );
  _.routine.options( willfilePropertyExtend, o );

  const will = this;
  const fileProvider = will.fileProvider;
  const path = fileProvider.path;
  const logger = will.transaction.logger;

  /* */

  _requestParsePathAndSelectors.call( will, o );
  selectorsMapVerify();

  o.commonPath = o.commonPath === '.' ? './' : o.commonPath;
  const willfilesMap = _.will.fileReadAt( path.join( will.inPath || path.current(), o.commonPath || './' ) );

  for( let selector in o.selectorsMap )
  {
    let [ willfile, property ] = willfileAndPropertyGetBySelector( selector );
    property = propertyExtend( property, o.selectorsMap[ selector ] );
    _.selectSet({ src : willfile, selector, set : property });
  }

  _.each( willfilesMap, ( willfile, willfilePath ) =>
  {
    fileProvider.fileWriteUnknown({ filePath : willfilePath, data : willfile, logger });
  });

  return null;

  /* */

  function selectorsMapVerify()
  {
    let count = 0;
    for( let selector in o.selectorsMap )
    {
      ++count;
      break;
    }
    _.assert( count === 1, 'Expects options to set.' );
  }

  /* */

  function willfileAndPropertyGetBySelector( selector )
  {
    _.assert
    (
      _.strBegins( selector, [ 'about', 'build', 'path', 'reflector', 'step', 'submodule' ] ),
      `Invalid property selector "${ selector }". Please, improve property selector.`
    );

    let property;
    const willfile = _.any( willfilesMap, ( willfile ) =>
    {
      property = _.select( willfile, selector );
      if( property !== undefined )
      return willfile;
    });
    if( willfile )
    return [ willfile, property ];
    selector = path.dir( selector );

    /* */

    selector = path.dir( selector );
    while( selector !== '.' )
    {
      const willfile = _.any( willfilesMap, ( willfile ) =>
      {
        if( _.select( willfile, selector ) !== undefined )
        return willfile;
      });
      if( willfile )
      return [ willfile, undefined ];
      selector = path.dir( selector );
    }

    for( let willfile in willfilesMap )
    return [ willfilesMap[ willfile ], undefined ];
  }

  /* */

  function propertyExtend( dst, src )
  {
    if( o.structureParse )
    src = _.strStructureParse({ src, parsingArrays : 1 });

    if( dst === undefined || dst === null )
    return src;
    if( _.array.is( dst ) )
    return _.arrayAppendArrayOnce( dst, src );
    if( _.primitive.is( dst ) || _.aux.is( dst ) )
    return o.onProperty( { el : dst }, { el : src } ).el;
    _.assert( false, 'Unexpected type of property' );
  }
}

willfilePropertyExtend.defaults =
{
  commonPath : null,
  request : null,
  selectorsMap : null,
  onProperty : null,
  structureParse : 0,
  logger : 3,
};

//

function willfileExtendWillfile( o )
{
  _.assert( arguments.length === 1 );
  _.routine.options( willfileExtendWillfile, o );

  const will = this;
  const fileProvider = will.fileProvider;
  const path = fileProvider.path;
  const logger = will.transaction.logger;

  /* */

  _.assert( o.modules.length <= 1 );
  const moduleDirPath = o.modules.length ? o.modules[ 0 ].dirPath : null;
  o.dirPath = o.dirPath || moduleDirPath || will.inPath || path.current();

  const splits = _.strSplit({ src : o.request, preservingEmpty : 0 });
  for( let i = 0 ; i < splits.length ; i++ )
  if( splits[ i ] === '.' )
  splits[ i ] = './';
  const configPaths = path.s.join( o.dirPath, splits );

  const dstWillfiles = dstFilesFind( configPaths[ 0 ] );
  if( o.format === 'json' )
  _.sure( dstWillfiles.length === 0, 'not implemented' );
  else
  _.sure( dstWillfiles.length <= 2, 'Please, improve selector, cannot choose willfiles.' );
  const commonDstPath = dstCommonPathGet( dstWillfiles );

  let willfile = Object.create( null );
  if( dstWillfiles.length === 1 )
  willfile = configRead( dstWillfiles[ 0 ].absolute );

  for( let i = 1 ; i < configPaths.length ; i++ )
  {
    let files = configFilesFind( configPaths[ i ] );
    _.sure( files.length !== 0, 'Source configuration file does not exist.' );

    for( let j = 0 ; j < files.length ; j++ )
    {
      _.sure
      (
        _.longHasAny( files[ j ].exts, [ 'yml', 'yaml', 'json' ] ),
        'Unexpected configuration files. Please, improve selector.'
      );

      const encoding = files[ j ].ext === 'json' ? 'json' : 'yaml';
      let config = configRead( files[ j ].absolute, encoding );
      if( !_.longHas( files[ j ].exts, 'will' ) )
      config = _.will.transform.willfileFromNpm({ config });

      willfilesMerge( willfile, config );
    }
  }

  if( o.submodulesDisabling )
  _.will.transform.submodulesSwitch( willfile.submodule, 0 );

  if( o.format === 'json' )
  {
    let data = _.will.transform.npmFromWillfile({ config : willfile });
    configWrite( commonDstPath, data, 'json' );
  }
  else if( dstWillfiles.length === 2 )
  {
    const exWillfile = configRead( dstWillfiles[ 0 ].absolute );
    const imWillfile = configRead( dstWillfiles[ 1 ].absolute );

    const [ exWillfileExtension, imWillfileExtension ] = splitWillfilesExtensionMake( exWillfile, imWillfile );

    willfilesMerge( exWillfile, exWillfileExtension );
    willfilesMerge( imWillfile, imWillfileExtension );

    configWrite( dstWillfiles[ 0 ].absolute, exWillfile );
    configWrite( dstWillfiles[ 1 ].absolute, imWillfile );
  }
  else
  {
    const filePath = dstWillfiles.length ? dstWillfiles[ 0 ].absolute : commonDstPath;
    configWrite( filePath, willfile );
  }
  return null;

  /* */

  function dstFilesFind( src )
  {
    _.assert( !path.isGlob( src ), 'Path to destination file should have not globs.' );

    return will.willfilesFind
    ({
      commonPath : src,
      withIn : 1,
      withOut : 0,
    });
  }

  /* */

  function dstCommonPathGet( files )
  {
    if( files.length === 1 )
    {
      return files[ 0 ].absolute;
    }
    else if( files.length === 2 )
    {
      return path.join( files[ 0 ].dir, _.strCommonLeft( files[ 0 ].fullName, files[ 1 ].fullName ) + '*' );
    }
    else
    {
      if( path.isTrailed( configPaths[ 0 ] ) )
      {
        const fileName = o.format === 'json' ? 'package.json' : 'will.yml';
        return path.join( configPaths[ 0 ], fileName );
      }
      else
      {
        const dir = path.dir( configPaths[ 0 ] );
        const name = _.strSplit( path.name( configPaths[ 0 ] ), '.' )[ 0 ];
        const exts = path.exts( configPaths[ 0 ] );
        _.arrayRemoveArrayOnce( exts, [ 'will', 'yml', 'yaml', 'json' ] );
        const extsArray = o.format === 'json' ? [ 'json' ] : [ 'will', 'yml' ];
        _.arrayAppendArray( exts, extsArray );
        return path.join( dir, `${ name }.${ exts.join( '.' ) }` );
      }
    }
  }

  /* */

  function configRead( filePath, encoding )
  {
    return fileProvider.fileRead({ filePath, encoding : encoding || 'yaml', logger });
  }

  /* */

  function configFilesFind( srcPath )
  {
    let filePath = srcPath;
    if( fileProvider.isTerminal( filePath ) )
    {
      if( dstWillfiles.length )
      if( _.longHasAny( _.select( dstWillfiles, '*/absolute' ), filePath ) )
      return [];
      return [ fileProvider.record( filePath ) ];
    }

    if( path.isTrailed( srcPath ) )
    return _.will.fileAt({ commonPath : srcPath });

    if( !path.isGlob( filePath ) )
    filePath = filePath + '*';

    let filter =
    {
      filePath : { [ filePath ] : true, [ commonDstPath ] : 0 },
      maskTerminal : { includeAny : /(.will){0,1}\.(yml|yaml|json)/ },
    };

    return fileProvider.filesFind
    ({
      filePath,
      withStem : 0,
      withDirs : 0,
      mode : 'distinct',
      mandatory : 0,
      filter,
    });
  }

  /* */

  function willfilesMerge( dst, src )
  {
    _.will.transform.willfilesMerge
    ({
      ... _.mapOnly_( null, o, _.will.transform.willfilesMerge.defaults ),
      dst,
      src,
    });
  }

  /* */

  function splitWillfilesExtensionMake( exWillfile, imWillfile )
  {
    const imWillfileExtension = Object.create( null );
    const exWillfileExtension = Object.create( null );
    for( let section in exWillfile )
    {
      if( ( section in imWillfile ) && ( section in willfile ) )
      {
        exWillfileExtension[ section ] = _.mapOnly_( null, willfile[ section ], exWillfile[ section ] );
        imWillfileExtension[ section ] = _.mapBut_( willfile[ section ], willfile[ section ], exWillfile[ section ] );
      }
      else if( section in willfile )
      {
        exWillfileExtension[ section ] = willfile[ section ];
      }
      delete willfile[ section ];
    }
    _.map.extend( imWillfileExtension, willfile );
    return [ exWillfileExtension, imWillfileExtension ];
  }

  /* */

  function configWrite( filePath, data, encoding )
  {
    fileProvider.fileWrite
    ({
      filePath,
      data,
      encoding : encoding || 'yaml',
      logger,
    });
  }
}

willfileExtendWillfile.defaults =
{
  'about' : 1,
  'build' : 1,
  'path' : 1,
  'reflector' : 1,
  'step' : 1,
  'submodule' : 1,

  'name' : 1,
  'version' : 1,
  'author' : 1,
  'enabled' : 1,
  'description' : 1,
  'contributors' : 1,
  'interpreters' : 1,
  'license' : 1,
  'keywords' : 1,
  'npm.name' : 1,
  'npm.scripts' : 1,

  'modules' : null,
  'dirPath' : null,
  'request' : null,
  'onSection' : null,
  'submodulesDisabling' : 0,
  'format' : 'willfile',
  'logger' : 3,
};

// --
// clean
// --

function cleanLog( o )
{
  let will = this;
  let logger = will.transaction.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routine.options_( cleanLog, arguments );

  _.assert( _.intIs( o.beginTime ) );
  _.assert( _.mapIs( o.files ) )

  if( o.explanation === null )
  if( o.dry )
  o.explanation = ' . Clean will delete ';
  else
  o.explanation = ' - Clean deleted ';

  if( !o.spentTime )
  {
    o.spentTime = _.time.now() - o.beginTime;
    if( o.asCommand )
    o.spentTime += will.willfilesReadEndTime - will.willfilesReadBeginTime
  }

  let textualReport = path.groupTextualReport
  ({
    explanation : o.explanation,
    groupsMap : o.files,
    verbosity : logger.verbosity,
    spentTime : o.spentTime,
  });

  // if( will.verbosity >= 2 )
  if( will.transaction.verbosity >= 2 )
  logger.log( textualReport );

  return textualReport;
}

var defaults = cleanLog.defaults =
{

  files : null,
  explanation : null,
  beginTime : null,
  spentTime : null,
  asCommand : 0,
  dry : 1,

}

//

function cleanDelete( o )
{
  let will = this;
  let logger = will.transaction.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routine.options_( cleanDelete, arguments );

  will.readingEnd();

  if( o.dry )
  {
    return null;
  }

  _.assert( _.mapIs( o.files ) );
  _.assert( _.arrayIs( o.files[ '/' ] ) );

  for( let f = o.files[ '/' ].length-1 ; f >= 0 ; f-- )
  {
    let filePath = o.files[ '/' ][ f ];
    _.assert( path.isAbsolute( filePath ) );

    if( o.fast )
    fileProvider.filesDelete
    ({
      filePath,
      verbosity : 0,
      throwing : 0,
      late : 1,
    });
    else
    fileProvider.fileDelete
    ({
      filePath,
      verbosity : 0,
      throwing : 0,
    });

  }

  return o.files;
}

var defaults = cleanDelete.defaults =
{

  dry : 0,
  fast : 0,
  files : null,

}

// --
// hooks
// --

function hooksReload()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let hooks = will._.hooks = will._.hooks || Object.create( null );

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( path.is( will.environmentPath ) );

  let hooksFiles = fileProvider.filesFind
  ({
    filePath : will.hooksPath + '/*',
    withDirs : 0,
    resolvingSoftLink : 1, /* xxx : comment out and investigate why returns non-empty list when path is link? */ /* xxx : cover */
  });

  hooksFiles.forEach( ( hookFile ) =>
  {
    let hook = Object.create( null );
    hook.name = path.name( hookFile.absolute );
    hook.file = hookFile;
    hook.call = function call( context )
    {
      _.assert( arguments.length === 1 );
      context = will.resourceWrap( context );
      let context2 = will.hookContextNew( context );
      context2.execPath = hook.file.absolute;
      context2 = will.hookContextFrom( context2 );
      return will.hookCall( context2 );
    }
    _.assert( !hooks[ hook.name ], () => `Redefinition of hook::${name}` );
    hooks[ hook.name ] = hook;
  });

}

//

function hooksList()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  for( let h in will.hooks )
  {
    let hook = will.hooks[ h ];
    logger.log( `${hook.name} at ${_.color.strFormat( hook.file.absolute, 'path' )}` );
  }

}

//

function hookContextNew( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  /* xxx : use recursive clone here */

  let o2 = _.props.extend( null, o );
  delete o2.execPath;
  delete o2.interpreterName;

  if( o2.request )
  o2.request = clone( o2.request );
  if( o2.request.map )
  o2.request.map = clone( o2.request.map );

  _.assert( !o2.request || o2.request !== o.request );
  _.assert( !o2.request || !o2.request.map || o2.request.map !== o.request.map );

  return o2;

  function clone( src )
  {
    if( _.mapIs( src ) )
    return _.props.extend( null, src );
    return src;
  }

}

//

function hookContextFrom( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  // let withPath = path.join( _.path.current(), will.withPath || './' );
  let withPath = path.join( _.path.current(), will.transaction.withPath || './' );

  o = will.resourceWrap( o );

  o = _.routine.options_( hookContextFrom, o );
  _.assert( arguments.length === 1 );

  if( o.opener && !o.module )
  o.module = o.opener.openedModule;
  o.openers = will.currentOpeners; /* xxx : currentOpeners is not available here! */
  if( !o.junction )
  o.junction = will.junctionFrom( o.opener );
  // o.junction = will.junctionFrom( opener );
  if( !o.opener )
  o.opener = o.junction.opener;
  if( !o.module )
  o.module = o.junction.module;

  _.assert( o.junction instanceof _.will.ModuleJunction );

  let relativeLocalPath = _.path.relative( o.junction.dirPath, o.junction.localPath );

  if( !o.will )
  o.will = will;
  if( !o.tools )
  o.tools = wTools;
  if( !o.path )
  o.path = path;
  if( !o.fileProvider )
  o.fileProvider = fileProvider;
  if( !o.ready )
  o.ready = _.take( null );
  if( !o.withPath )
  o.withPath = withPath;
  if( !o.logger )
  o.logger = logger;

  let delimeter;
  if( o.request === null )
  [ o.execPath, delimeter, o.request ] = _.strIsolateLeftOrAll( o.execPath, /\s+/ );
  if( o.request === null )
  o.request = '';
  if( _.strIs( o.request ) )
  o.request = _.strRequestParse( o.request );
  _.assert( !!o.request.map );

  if( !o.start )
  o.start = _.process.starter
  ({
    currentPath : o.junction.dirPath,
    outputCollecting : 1,
    outputGraying : 1,
    outputPiping : 1,
    inputMirroring : 1,
    // briefExitCode : 1,
    throwingExitCode : 'brief',
    sync : 0,
    deasync : 1,
    mode : 'shell',
    ready : o.ready
  });

  if( !o.startNonThrowing )
  o.startNonThrowing = _.process.starter
  ({
    currentPath : o.junction.dirPath,
    outputCollecting : 1,
    outputGraying : 1,
    outputPiping : 1,
    inputMirroring : 1,
    // briefExitCode : 1,
    // throwingExitCode : 'brief',
    throwingExitCode : 0,
    sync : 0,
    deasync : 1,
    mode : 'shell',
    ready : o.ready
  });

  if( !o.startWill )
  o.startWill = _.process.starter
  ({
    currentPath : o.junction.dirPath,
    execPath : `${will.WillPathGet()} .with ${relativeLocalPath} `,
    outputCollecting : 1,
    outputGraying : 1,
    outputPiping : 1,
    inputMirroring : 1,
    // briefExitCode : 1,
    throwingExitCode : 'brief',
    sync : 0,
    deasync : 1,
    mode : 'fork',
    ready : o.ready,
  });

  _.assert( _.strIs( o.withPath ) );
  _.assert( _.strIs( o.execPath ) );
  _.assert( _.arrayIs( o.openers ) );
  _.assert( o.will === will );

  return o;
}

hookContextFrom.defaults =
{

  will : null,
  junction : null,
  module : null,
  opener : null,
  openers : null,

  tools : null,
  path : null,
  fileProvider : null,
  ready : null,
  logger : null,

  withPath : null,
  execPath : null,
  request : null,
  interpreterName : null,
  sync : 1,

  start : null,
  startNonThrowing : null,
  startWill : null,

}

//

function hookCall( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  o = _.routine.options_( hookCall, arguments );
  _.assert( o.will === will );
  _.assert( !!o.junction );

  /* */

  if( o.module && o.withPath && _.will.resolver.Resolver.selectorIs( o.withPath ) )
  o.withPath = o.module.pathResolve
  ({
    selector : o.withPath,
    prefixlessAction : 'resolved',
  });

  _.sure( o.withPath === null || _.strIs( o.withPath ) || _.strsAreAll( o.withPath ), 'Current path should be string if defined' );

  if( o.module && o.withPath )
  o.withPath = path.s.join( o.module.inPath, path.fromGlob( o.withPath ) );
  else
  // o.withPath = path.s.join( o.will.withPath, o.withPath );
  o.withPath = path.s.join( o.will.transaction.withPath, path.fromGlob( o.withPath ) );

  /* */

  if( o.module && _.will.resolver.Resolver.selectorIs( o.execPath ) )
  o.execPath = o.module.resolve
  ({
    selector : o.execPath,
    prefixlessAction : 'resolved',
  });

  o.execPath = path.s.join( o.withPath, o.execPath );
  o.execPath = will.hookFindAt( o.execPath );

  /* */

  if( !o.interpreterName )
  {
    if( _.longHasAny( [ 'js', 'ss', 's' ], path.exts( o.execPath ) ) )
    o.interpreterName = 'js';
    else
    o.interpreterName = 'os';
  }

  /* */

  _.assert( path.isAbsolute( o.execPath ) );
  _.assert( _.strDefined( o.interpreterName ) );

  if( o.interpreterName === 'js' )
  return jsCall();
  else if( o.interpreterName === 'os' )
  return exeCall();
  else _.assert( 0, `Unknown interpreter of hook ${o.interpreterName}` );

  /* */

  function jsCall()
  {
    let ready = _.take( null );

    ready
    .then( () =>
    {
      /* qqq : cover hooks behind soft link */
      return require( _.fileProvider.path.nativize( _.fileProvider.pathResolveLinkFull( o.execPath ).absolutePath ) );
    })
    .then( ( routine ) =>
    {
      if( !_.routineIs( routine ) )
      throw _.errBrief( `Script file should export routine or consequence, but exports ${_.entity.strType( routine )}` );
      defaultsApply( routine );
      let r = routine.call( will, o );
      if( r === ready )
      return null;
      if( _.consequenceIs( r ) || _.promiseLike( r ) )
      return r;
      return null;
    })
    .then( ( arg ) =>
    {
      return o.ready;
    })
    .finally( ( err, arg ) =>
    {
      if( err )
      throw _.err( err, `\nFailed to ${o.execPath}` );
      return arg;
    })

    if( o.sync )
    {
      // return ready.deasync();
      ready.deasync();
      return ready.sync();
    }

    return ready;
    // return ready.split();
  }

  /* */

  function defaultsApply( routine )
  {
    if( routine.defaults )
    {
      _.routine.options_( routine, o.request.map );
    }
    else
    {
      if( o.request.map.v !== undefined )
      {
        o.request.map.verbosity = o.request.map.v;
        delete o.request.map.v;
      }
    }
  }

  /* */

  function exeCall()
  {
    _.assert( 0, 'not tested' );
    o.execPath = `${o.execPath} ${_.strRequestStr( o.request )} localPath:${o.junction.localPath}`;
    return _.process.start
    ({
      ready : o.ready,
      currentPath : o.withPath,
      execPath : o.execPath,
      outputCollecting : 1,
      outputGraying : 1,
      outputPiping : 1,
      inputMirroring : 1,
      mode : 'shell',
    });
  }

  /* */

}

hookCall.defaults = _.props.extend( null, hookContextFrom.defaults );

//

function hookFindAt( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  if( !_.mapIs( o ) )
  o = { execPath : o };

  _.assert( arguments.length === 1 );
  _.routine.options_( hookFindAt, o );

  if( fileProvider.isTerminal( o.execPath ) )
  return end( o.execPath );

  let filePath = `${o.execPath}.(${will.KnownHookExts.join( '|' )})`;
  let found = fileProvider.filesFind
  ({
    filePath,
    outputFormat : 'absolute',
    withDirs : 0,
    resolvingSoftLink : 1
  });
  return end( found );

  function end( found )
  {
    if( !o.single )
    return _.array.as( found );
    if( _.str.is( found ) )
    return found;

    _.assert( _.array.is( found ) );
    if( found.length === 1 )
    return found[ 0 ];
    if( found.length < 1 )
    throw _.errBrief( `Found none hook file at ${o.execPath}` );
    throw _.errBrief
    (
      `Found several ( ${found.length} ) hook file at ${o.execPath}, not clear which to use\n${found.join( '\n' )}`
    );

    // if( !o.single )
    // return _.array.as( found );
    // if( _.str.is( found ) )
    // return found;
    //
    // if( found.length )
    // return found[ 0 ];
    //
    // if( found.length > 0 )
    // throw _.errBrief( `Found several ( ${found.length} ) hook file at ${o.execPath}, not clear which to use\n${found.join( '\n' )}` );
    // else
    // throw _.errBrief( `Found none hook file at ${o.execPath}` );
    //
    // return found;
  }
}

hookFindAt.defaults =
{
  execPath : null,
  single : 1,
}

//

function hooksGet()
{
  let will = this;

  if( !will._.hooks )
  will.hooksReload();

  return will._.hooks;
}

// --
// npm
// --

function npmDepAdd( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger

  _.routine.options( npmDepAdd, o );

  if( !o.localPath )
  o.localPath = path.current();

  if( o.depPath === '.' )
  o.depPath = 'hd://.'

  let parsed = path.parse( o.depPath );
  if( parsed.protocol === 'hd' )
  o.depPath = path.join( path.current(), o.depPath );

  if( !o.as )
  if( parsed.protocol === 'hd' )
  o.as = _.npm.fileReadName({ localPath : path.localsFromGlobals( o.depPath ) });
  else
  o.as = _.npm.fileReadName({ localPath : path.current() });

  _.assert( _.boolLikeFalse( o.editing ), 'not implemented' );
  _.assert( _.boolLikeTrue( o.downloading ), 'not implemented' );
  _.assert( _.boolLikeTrue( o.linking ), 'not implemented' );
  _.assert( path.parse( o.depPath ).protocol === 'hd', 'not implemented' );

  o.logger = new _.Logger({ output : logger });
  o.logger.verbosity = o.verbosity;
  delete o.verbosity;

  return _.npm.depAdd( o );
}

npmDepAdd.defaults =
{
  as : null,
  localPath : null,
  depPath : null,
  editing : 1,
  downloading : 1,
  linking : 1,
  dry : 0,
  verbosity : 1,
}

// --
// relations
// --

let ResourceKindToClassName = new _.NameMapper({ leftName : 'resource kind', rightName : 'resource class name' }).set
({

  'submodule' : 'ModulesRelation',
  'step' : 'Step',
  'path' : 'PathResource',
  'reflector' : 'Reflector',
  'build' : 'Build',
  'about' : 'About',
  'execution' : 'Execution',
  'exported' : 'Exported',

});

let ResourceKindToMapName = new _.NameMapper({ leftName : 'resource kind', rightName : 'resource map name' }).set
({

  'about' : 'about',
  'module' : 'moduleWithNameMap',
  'submodule' : 'submoduleMap',
  'step' : 'stepMap',
  'path' : 'pathResourceMap',
  'reflector' : 'reflectorMap',
  'build' : 'buildMap',
  'exported' : 'exportedMap',

});

// let ResourceKind =
// [
//   'submodule',
//   'step',
//   'path',
//   'reflector',
//   'build',
//   'about',
//   'execution',
//   'exported',
// ];

let KnownHookExts =
[
  'js',
  's',
  'ss',
  'exe',
  'bat',
  'cmd',
  'sh',
  'bash',
]

let OpeningDefaults =
{

  attachedWillfilesFormedOfMain : null,
  peerModulesFormedOfMain : null,
  subModulesFormedOfMain : null,
  resourcesFormedOfMain : null,
  allOfMain : null,

  attachedWillfilesFormedOfSub : null,
  peerModulesFormedOfSub : null,
  subModulesFormedOfSub : null,
  resourcesFormedOfSub : null,
  allOfSub : null,

  // verbosity : null,

}

let Composes =
{

  verbosity : 3,
  // verboseStaging : 0,

  environmentPath : null,
  // withPath : null,
  // withSubmodules : null,

  // ... FilterFields,

  transaction : null

}

_.assert( Composes.withEnabledModules === undefined );

let Aggregates =
{

  // attachedWillfilesFormedOfMain : true,
  // peerModulesFormedOfMain : true,
  // subModulesFormedOfMain : true,
  // resourcesFormedOfMain : null,
  // allOfMain : null,

  // attachedWillfilesFormedOfSub : true,
  // peerModulesFormedOfSub : true,
  // subModulesFormedOfSub : true,
  // resourcesFormedOfSub : null,
  // allOfSub : null,

}

let Associates =
{

  fileProvider : null,
  logger : null,
  mainOpener : null,

}

let Restricts =
{

  formed : 0,
  willfilesReadBeginTime : null,
  willfilesReadEndTime : null,

  repoMap : _.define.own({}),
  junctionMap : _.define.own({}),
  objectToJunctionHash : _.define.own( new HashMap ),
  modulesArray : _.define.own([]),
  moduleWithIdMap : _.define.own({}),
  moduleWithCommonPathMap : _.define.own({}),
  moduleWithNameMap : _.define.own({}),
  openersArray : _.define.own([]),
  openerModuleWithIdMap : _.define.own({}),
  openersErrorsArray : _.define.own([]),
  openersErrorsMap : _.define.own({}),

  willfilesArray : _.define.own([]),
  willfileWithCommonPathMap : _.define.own({}),
  willfileWithFilePathPathMap : _.define.own({}),

  fileProviderVerbosityDelta : -2

}

let Medials =
{
  // withSubmodules : null,
}

let Statics =
{

  ResourceCounter : 0,
  ResourceKindToClassName,
  ResourceKindToMapName,
  // ResourceKind,
  KnownHookExts,
  OpeningDefaults,
  UpformingDefaults,
  ModuleFilterNulls,
  ModuleFilterDefaults,
  ModuleFilterOn,
  ModuleFilterOff,
  RelationFilterNulls,
  RelationFilterDefaults,
  RelationFilterOn,
  RelationFilterOff,
  FilterFields,
  IntentionFields,

  // path

  ObjectIs,
  ObjectsAre,
  ObjectsAreAll,
  ObjectsAreAny,
  ObjectsAreNone,
  ObjectsExportInfo,
  ObjectsLogInfo,
  WillPathGet,
  // WillfilePathIs,
  // PathIsOut,
  DirPathFromFilePaths,
  PrefixPathForRole,
  PrefixPathForRoleMaybe,
  PathToRole,
  CommonPathFor,
  CommonPathNormalize,
  CloneDirPathFor,
  // DownloadPathFor,
  OutfilePathFor,
  RemotePathAdjust,
  HooksPathGet,
  LocalPathNormalize,
  IsModuleAt,
  WillfilesFind,

}

let Forbids =
{
  mainModule : 'mainModule',
  recursiveExport : 'recursiveExport',
  graphGroup : 'graphGroup',
  graphSystem : 'graphSystem',
  filesGraph : 'filesGraph',

  withEnabled : 'withEnabled',
  withDisabled : 'withDisabled',
  withOut : 'withOut',
  withIn : 'withIn',
  withValid : 'withValid',
  withInvalid : 'withInvalid',
  withKnown : 'withKnown',
  withUnknown : 'withUnknown',

  withPath : 'withPath',

  withSubmodules : 'withSubmodules',

  attachedWillfilesFormedOfMain : 'attachedWillfilesFormedOfMain',
  peerModulesFormedOfMain : 'peerModulesFormedOfMain',
  subModulesFormedOfMain : 'subModulesFormedOfMain',
  resourcesFormedOfMain : 'resourcesFormedOfMain',
  allOfMain : 'allOfMain',

  attachedWillfilesFormedOfSub : 'attachedWillfilesFormedOfSub',
  peerModulesFormedOfSub : 'peerModulesFormedOfSub',
  subModulesFormedOfSub : 'subModulesFormedOfSub',
  resourcesFormedOfSub : 'resourcesFormedOfSub',
  allOfSub : 'allOfSub',
}

let Accessors =
{

  _ : { get : _.accessor.getter.withSymbol, writable : 0 },
  hooks : { get : hooksGet, writable : 0 },
  environmentPath : { set : environmentPathSet },
  hooksPath : { get : hooksPathGet, writable : 0 },
  // withSubmodules : {},

  // verbosity : { get : verbosityGet, writable : 0 },
  verboseStaging : { suite : _.accessor.suite.alias({ container : 'transaction', originalName : 'verboseStaging' }) },

}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,
  unform,
  form,
  formAssociates,

  // path

  WillPathGet,
  // PathIsOut,
  DirPathFromFilePaths,
  PrefixPathForRole,
  PrefixPathForRoleMaybe,
  PathToRole,
  CommonPathFor,
  CommonPathNormalize,
  CloneDirPathFor,
  // DownloadPathFor,
  OutfilePathFor,
  RemotePathAdjust,
  HooksPathGet,
  IsModuleAt,

  pathIsRemote,
  hooksPathGet,
  environmentPathSet,
  environmentPathFind,

  // etc

  _verbosityChange,
  // verbosityGet,

  vcsProviderFor,
  // vcsToolsFor,
  repoFrom,

  resourceWrap,
  resourcesInfoExport,
  _pathChanged,
  versionGet,
  versionIsUpToDate,

  // withSubmodulesGet,
  // withSubmodulesSet,
  recursiveValueDeduceFromBuild,

  // defaults

  filterDefaults,
  instanceDefaultsApply,
  instanceDefaultsSupplement,
  instanceDefaultsExtend,
  instanceDefaultsReset,
  prefer,

  // module

  moduleAt,
  moduleFit,
  filterImplied,
  relationFit,
  modulesFilter,
  relationsFilter,
  moduleIdUnregister,
  moduleIdRegister,
  modulePathUnregister,
  modulePathRegister,
  moduleNew,

  modulesFindEachAt,
  modulesFindWithAt,
  modulesOnlyRoots,
  modulesEach,
  modulesEachAll,
  modulesFor,

  modulesDownload,
  modulesUpform,
  modulesClean,
  modulesBuild,
  modulesExport,
  modulesPublish,
  modulesVerify,

  // object

  ObjectIs,
  ObjectsAre,
  ObjectsAreAll,
  ObjectsAreAny,
  ObjectsAreNone,

  ObjectsExportInfo,
  ObjectsLogInfo,
  objectsExportInfo,
  objectsLogInfo,
  objectsAllVariants,
  objectsToVariants,

  // junction

  // isJunction,
  junctionReform,
  junctionsReform,
  junctionFrom,
  junctionsFrom,
  handlesFrom,
  junctionOf,
  junctionsOf,
  junctionWithId,
  junctionsInfoExport,

  // graph

  assertGraphGroup,
  graphGroupMake,
  graphTopSort,
  graphExportTreeInfo,

  // opener

  _openerMake,
  openerMakeManual,
  openersAdoptModule,
  openerUnregister,
  openerRegister,
  openersErrorsRemoveOf,
  openersErrorsRemoveAll,

  // willfile

  readingReset,
  readingBegin,
  readingEnd,

  _willfilesReadBegin,
  _willfilesReadEnd,
  _willfilesReadLog,

  // WillfilePathIs,
  WillfilesFind,
  willfilesFind,
  willfilesSelectPaired,
  willfileWithCommon,
  _willfileWithFilePath,
  willfileWithFilePath,
  willfileFor,
  willfileUnregister,
  willfileRegister,

  // convert

  npmGenerateFromWillfile,
  willfileGenerateFromNpm,

  willfilePropertyGet,
  willfilePropertySet,
  willfilePropertyDelete,
  willfilePropertyExtend,
  willfileExtendWillfile,

  // clean

  cleanLog,
  cleanDelete,

  // hooks

  hooksReload,
  hooksList,
  hookContextNew,
  hookContextFrom,
  hookCall,
  hookFindAt,
  hooksGet,

  // npm

  npmDepAdd,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Medials,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extension,
});

_.Copyable.mixin( Self );
_.Verbal.mixin( Self ); /* xxx : qqq : for Vova : remove the mixin */
wTools[ Self.shortName ] = Self;

})();

