( function _AbstractModule_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillAbstractModule( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractModule';

// --
// inter
// --

function finit()
{
  let module = this;
  return _.Copyable.prototype.finit.apply( module, arguments );
}

//

function init()
{
  let module = this;

  module[ willfileWithRoleMapSymbol ] = Object.create( null );
  module[ willfileArraySymbol ] = [];
  module[ fileNameSymbol ] = null;

  module[ willfilesPathSymbol ] = null;
  // module[ dirPathSymbol ] = null;
  module[ commonPathSymbol ] = null;
  module[ willPathSymbol ] = _.path.join( __dirname, '../Exec' );

  _.workpiece.initFields( module );
  Object.preventExtensions( module );
  _.Will.ResourceCounter += 1;
  module.id = _.Will.ResourceCounter;
}

//

function optionsFormingForward( o )
{
  let module = this;

  _.assert( arguments.length === 1 );
  o = _.mapSupplementStructureless( o, optionsFormingForward.defaults );

  if( _.boolLike( o.all ) )
  {
    o.all = !!o.all;
    if( o.attachedWillfilesFormed === null )
    o.attachedWillfilesFormed = o.all;
    if( o.peerModulesFormed === null )
    o.peerModulesFormed = o.all;
    if( o.subModulesFormed === null )
    o.subModulesFormed = o.all;
    if( o.resourcesFormed === null )
    o.resourcesFormed = o.all;
  }

  return o;
}

optionsFormingForward.defaults =
{
  all : null,
  attachedWillfilesFormed : null,
  peerModulesFormed : null,
  subModulesFormed : null,
  resourcesFormed : null,
}

// --
// path
// --

function WillfilePathIs( filePath )
{
  let fname = _.path.fullName( filePath );
  let r = /\.will\.\w+/;
  if( _.strHas( fname, r ) )
  return true;
  return false;
}

//

function DirPathFromFilePaths( filePaths )
{
  let module = this;

  filePaths = _.arrayAs( filePaths );

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

    // if( parsed1 || parsed2 )
    // if( _.strEnds( filePath, '/' ) )
    // filePath = filePath + '.';

    return filePath;
  });

  let filePath = _.strCommonLeft.apply( _, _.arrayAs( filePaths ) );
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

  if( _.strHas( filePath, /(^|\.|\/)im\.will(\.|$)/ ) )
  role = 'import';
  else if( _.strHas( filePath, /(^|\.|\/)ex\.will(\.|$)/ ) )
  role = 'export';
  else
  role = 'single';

  return role;
}

// //
//
// function CommonPathFor( willfilesPath )
// {
//   return _.Will.CommonPathFor.apply( _.Will, arguments );
// }

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

  // let common = willfilesPath.replace( /\.will(\.\w+)?$/, '' );
  //
  // common = common.replace( /(\.im|\.ex)$/, '' );

  let common = willfilesPath.replace( /(\.)?((im|ex)\.)?(will\.)(out\.)?(\w+)?$/, '' );

  if( _.strEnds( common, [ '/im', '/ex' ] ) )
  {
    common = _.uri.trail( _.uri.dir( common ) );
    _.assert( _.uri.isTrailed( common ) );
  }

  return common;
}

//

function CloneDirPathFor( inPath )
{
  _.assert( arguments.length === 1 );
  return _.path.join( inPath, '.module' );
}

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

function _filePathChange( willfilesPath )
{
  let r = Object.create( null );
  r.willfilesPath = willfilesPath;

  if( _.arrayIs( r.willfilesPath ) )
  {
    if( r.willfilesPath.length === 1 )
    r.willfilesPath = r.willfilesPath[ 0 ];
    else if( r.willfilesPath.length === 0 )
    r.willfilesPath = null;
  }

  if( !this.will )
  return r;

  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( r.willfilesPath )
  r.willfilesPath = path.s.normalizeTolerant( r.willfilesPath );

  r.dirPath = r.willfilesPath;
  if( _.arrayIs( r.dirPath ) )
  r.dirPath = r.dirPath[ 0 ];
  if( _.strIs( r.dirPath ) )
  r.dirPath = path.dirFirst( r.dirPath );
  if( r.dirPath === null )
  r.dirPath = module.dirPath;
  // if( r.dirPath && path.isGlobal( r.dirPath ) )
  // debugger;
  if( r.dirPath )
  r.dirPath = path.canonize( r.dirPath );
  // r.dirPath = path.canonizeTolerant( r.dirPath );
  // if( r.willfilesPath )
  // debugger;

  r.commonPath = module.CommonPathFor( r.willfilesPath );

  _.assert( arguments.length === 1 );
  _.assert( r.dirPath === null || _.strDefined( r.dirPath ) );
  _.assert( r.dirPath === null || path.isAbsolute( r.dirPath ) );
  _.assert( r.dirPath === null || path.isNormalized( r.dirPath ) );
  _.assert( r.willfilesPath === null || path.s.allAreAbsolute( r.willfilesPath ) );

  if( r.commonPath !== null )
  module[ fileNameSymbol ] = path.fullName( r.commonPath );
  module[ willfilesPathSymbol ] = r.willfilesPath;

  return r;
}

//

function _filePathChanged()
{
  let module = this;

  _.assert( arguments.length === 0 );

  module._filePathChange( module.willfilesPath );

}

// --
// name
// --

function qualifiedNameGet()
{
  let module = this;
  let name = module.name;
  return 'module' + '::' + name;
}

//

function decoratedQualifiedNameGet()
{
  let module = this;
  let result = module.qualifiedName;
  return _.color.strFormat( result, 'entity' );
}

//

function decoratedAbsoluteNameGet()
{
  let module = this;
  let result = module.absoluteName;
  return _.color.strFormat( result, 'entity' );
}

// --
// willfile
// --

function willfileArraySet( willfilesArray )
{
  let module = this;
  _.assert( _.arrayIs( willfilesArray ) );

  if( module.willfilesArray === willfilesArray )
  return module.willfilesArray;

  for( let w = module.willfilesArray.length-1 ; w >= 0 ; w-- )
  {
    let willf = module.willfilesArray[ w ];
    module.willfileUnregister( willf );
  }

  for( let w = 0 ; w < willfilesArray.length ; w++ )
  {
    let willf = willfilesArray[ w ];
    module.willfileRegister( willf );
  }

  return module.willfilesArray;
}

//

function willfileUnregister( willf )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.arrayRemoveElementOnceStrictly( module.willfilesArray, willf );
  // _.arrayRemoveElementOnceStrictly( willf.openers, module );

  if( willf.role )
  {
    _.assert( module.willfileWithRoleMap[ willf.role ] === willf )
    delete module.willfileWithRoleMap[ willf.role ];
  }

  let willfilesPath = _.arrayFlatten( _.select( module.willfilesArray, '*/filePath' ) );
  module.willfilesPath = willfilesPath;

}

//

function willfileRegister( willf )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );

  if( _.arrayIs( willf ) )
  {
    debugger;
    willf.forEach( ( willf ) => module.willfileRegister( willf ) );
    return;
  }

  _.arrayAppendOnce( module.willfilesArray, willf );

  if( willf.role )
  {
    _.assert( !module.willfileWithRoleMap[ willf.role ] || module.willfileWithRoleMap[ willf.role ] === willf, 'Module already has willfile with role', willf.role )
    module.willfileWithRoleMap[ willf.role ] = willf;
  }

  _.assert( !!module.willfilesArray.length );

  let willfilesPath = _.arrayFlatten( _.select( module.willfilesArray, '*/filePath' ) );
  module.willfilesPath = willfilesPath;

  module.isOut = _.any( module.willfilesArray, ( wfile ) => wfile.isOut );

}

//

function _willfilesRelease( willfilesArray )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  willfilesArray = willfilesArray || opener.willfilesArray;
  willfilesArray = willfilesArray.slice();

  for( let i = willfilesArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = willfilesArray[ i ];
    opener.willfileUnregister( willf );
    _.assert( !willf.finitedIs() );
    if( !willf.isUsed() )
    willf.finit();
  }

}

// --
// remote
// --

function remoteIsUpdate()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.willfilesPath || !!module.dirPath );
  _.assert( arguments.length === 0 );

  // if( module.isRemote !== null )
  // return end( module.isRemote );

  let remotePath = module.remotePath ? path.common( module.remotePath ) : module.commonPath;
  let remoteProvider = fileProvider.providerForPath( remotePath );
  if( remoteProvider.isVcs )
  return end( true );

  return end( false );

  /* */

  function end( result )
  {
    module.isRemote = result;
    return result;
  }
}

//

function remoteIsDownloadedUpdate()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( module.localPath ) );
  _.assert( !!module.willfilesPath );
  _.assert( module.isRemote === true );

  let remoteProvider = fileProvider.providerForPath( module.remotePath );
  _.assert( !!remoteProvider.isVcs );

  let result = remoteProvider.isDownloaded
  ({
    localPath : module.localPath,
  });

  _.assert( !_.consequenceIs( result ) );

  if( !result )
  return end( result );

  return _.Consequence.From( result )
  .finally( ( err, arg ) =>
  {
    end( arg );
    if( err )
    throw err;
    return arg;
  });

  /* */

  function end( result )
  {
    module.isDownloaded = !!result;
    return result;
  }

}

//

function remoteIsUpToDateUpdate()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( module.localPath ) );
  _.assert( !!module.willfilesPath );
  _.assert( module.isRemote === true );

  let remoteProvider = fileProvider.providerForPath( module.remotePath );

  _.assert( !!remoteProvider.isVcs );

  debugger;
  let result = remoteProvider.isUpToDate
  ({
    remotePath : module.remotePath,
    localPath : module.localPath,
    verbosity : will.verbosity - 3,
  });

  if( !result )
  return end( result );

  return _.Consequence.From( result )
  .finally( ( err, arg ) =>
  {
    end( arg );
    if( err )
    throw err;
    return arg;
  });

  /* */

  function end( result )
  {
    module.isUpToDate = !!result;
    return result;
  }

}

//

function remoteCurrentVersion()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.willfilesPath || !!module.dirPath );
  _.assert( arguments.length === 0 );

  debugger;
  let remoteProvider = fileProvider.providerForPath( module.commonPath );
  debugger;
  return remoteProvider.versionLocalRetrive( module.localPath );
}

//

function remoteLatestVersion()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.willfilesPath || !!module.dirPath );
  _.assert( arguments.length === 0 );

  debugger;
  let remoteProvider = fileProvider.providerForPath( module.commonPath );
  debugger;
  return remoteProvider.versionRemoteLatestRetrive( module.localPath )
}

// --
// relations
// --

let willfileWithRoleMapSymbol = Symbol.for( 'willfileWithRoleMap' );
let willfileArraySymbol = Symbol.for( 'willfilesArray' );
let fileNameSymbol = Symbol.for( 'fileName' );

let willfilesPathSymbol = Symbol.for( 'willfilesPath' );
let commonPathSymbol = Symbol.for( 'commonPath' );
let willPathSymbol = Symbol.for( 'willPath' );

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
  will : null,
  peerModule : null,
}

let Medials =
{
}

let Restricts =
{

  id : null,

}

let Statics =
{

  WillfilePathIs,
  DirPathFromFilePaths,
  PrefixPathForRole,
  PrefixPathForRoleMaybe,
  PathToRole,

  CommonPathFor,
  CloneDirPathFor,
  OutfilePathFor,

}

let Forbids =
{

  mainOpener : 'mainOpener',
  exportMap : 'exportMap',
  exported : 'exported',
  export : 'export',
  downloaded : 'downloaded',
  formReady : 'formReady',
  filePath : 'filePath',
  errors : 'errors',
  associatedSubmodule : 'associatedSubmodule',
  execution : 'execution',
  allModuleMap : 'allModuleMap',
  opener : 'opener',
  Counter : 'Counter',
  moduleWithCommonPathMap : 'moduleWithCommonPathMap',
  supermoduleSubmodule : 'supermoduleSubmodule',
  configName : 'configName',
  superModules : 'superModules',

}

let Accessors =
{

  qualifiedName : { getter : qualifiedNameGet, combining : 'rewrite', readOnly : 1 },
  fileName : { readOnly : 1 },
  decoratedQualifiedName : { getter : decoratedQualifiedNameGet, combining : 'rewrite', readOnly : 1 },
  decoratedAbsoluteName : { getter : decoratedAbsoluteNameGet, readOnly : 1 },

  willfilesArray : { setter : willfileArraySet },
  willfileWithRoleMap : { readOnly : 1 },

}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,
  optionsFormingForward,

  // path

  WillfilePathIs,
  DirPathFromFilePaths,
  PrefixPathForRole,
  PrefixPathForRoleMaybe,

  CommonPathFor,
  CloneDirPathFor,
  OutfilePathFor,

  _filePathChange,
  _filePathChanged,

  // name

  qualifiedNameGet,
  decoratedQualifiedNameGet,
  decoratedAbsoluteNameGet,

  // willfile

  willfileArraySet,
  willfileUnregister,
  willfileRegister,

  _willfilesRelease,

  // remote

  remoteIsUpdate,
  remoteIsDownloadedUpdate,
  remoteIsUpToDateUpdate,

  remoteCurrentVersion,
  remoteLatestVersion,

  // relation

  Composes,
  Aggregates,
  Associates,
  Medials,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
