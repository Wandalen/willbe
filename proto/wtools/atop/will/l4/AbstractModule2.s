( function _AbstractModule2_s_()
{

'use strict';

/**
 * @classdesc Class wWillAbstractModule provides common interface modules.
 * @class wWillAbstractModule
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = _.will.AbstractModule1;
const Self = wWillAbstractModule2;
function wWillAbstractModule2( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractModule2';

_.assert( _.routineIs( Parent ) );

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
  module[ commonPathSymbol ] = null;
  module[ willPathSymbol ] = _.path.join( __dirname, '../Exec' );

  _.workpiece.initFields( module );
  Object.preventExtensions( module );
  _.Will.ResourceCounter += 1;
  module.id = _.Will.ResourceCounter;
}

// --
// relator
// --

function isUsedManually()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  // xxx yyy
  // if( !module.isAuto )
  // return true;

  let found = [];
  let sys = new _.graph.AbstractGraphSystem
  ({
    onNodeIs : nodeIs,
    onNodeName : nodeName,
    onNodeOutNodes : nodeOutNodes,
  });
  let group = sys.nodesGroup();

  group.each({ roots : [ module ], onUp });

  return found.length > 0;

  /* */

  function onUp( node )
  {
    if( node.isAuto )
    return;
    if( node === module )
    return;
    if( module instanceof _.will.Module )
    if( node instanceof _.will.Module )
    return;
    found.push( node );
  }

  /* */

  function nodeIs( node )
  {
    return _.instanceIs( node );
  }

  /* */

  function nodeName( node )
  {
    return node.qualifiedName;
  }

  /* */

  function nodeOutNodes( node )
  {
    if( !node.usersGet )
    return [];
    _.assert( _.routineIs( node.usersGet ) )
    return node.usersGet();
  }

}

// --
// etc
// --

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

optionsFormingForward.defaults = _.mapExtend( null, _.Will.UpformingDefaults );

// --
// name
// --

// function nameWithLocationGet( moduleName, moduleLocation )
// {
//   let module = this;
//   moduleName = moduleName || module.qualifiedName;
//   moduleLocation = moduleLocation || module._shortestModuleDirPathGet();
//   return module._NameWithLocationFormat( moduleName, moduleLocation );
// }

//

function _NameWithLocationFormat( moduleName, moduleLocation )
{
  return `${ _.ct.format( moduleName, 'entity' ) } at ${ _.ct.format( moduleLocation, 'path' ) }`;
}

// --
// path
// --

function _shortestModuleDirPathGet()
{
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let self = this;
  let path = self.will.fileProvider.path;

  let modulePath = path.canonize( self.pathMap[ 'module.common' ] );
  let moduleInPath = path.canonize( self.pathMap[ 'module.peer.in' ] );

  if( modulePath && moduleInPath )
  return modulePath.length < moduleInPath.length ? modulePath : moduleInPath;

  if( modulePath )
  return modulePath;
  else if( moduleInPath )
  return moduleInPath;
  else
  _.assert( 0, 'Unknown module path.' );
}

//

function _filePathSet( willfilesPath )
{
  let module = this;
  let r = Object.create( null );
  r.willfilesPath = willfilesPath;
  return module._filePathChanged1( r ).willfilesPath;
}

//

function _filePathChanged1( o )
{
  let module = this;
  return module._filePathChanged2( o );
}

_filePathChanged1.defaults =
{
  willfilesPath : null,
  exWillfilesPath : null,
  isIdentical : null,
  dirPath : null,
  localPath : null,
  commonPath : null,
}

//

function _filePathChanged2( o )
{
  let module = this;

  if( !o )
  {
    o = Object.create( null );
    o.willfilesPath = module.willfilesPath;
    o.exWillfilesPath = _.unknown;
    o.isIdentical = false;
  }

  if( !o.exWillfilesPath )
  o.exWillfilesPath = module.willfilesPath;

  _.routineOptions( _filePathChanged2, o );

  if( _.arrayIs( o.willfilesPath ) )
  {
    if( o.willfilesPath.length === 1 )
    o.willfilesPath = o.willfilesPath[ 0 ];
    else if( o.willfilesPath.length === 0 )
    o.willfilesPath = null;
  }

  if( !this.will )
  return o;

  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  if( o.willfilesPath )
  o.willfilesPath = path.s.normalizeTolerant( o.willfilesPath );

  o.dirPath = o.willfilesPath;
  if( _.arrayIs( o.dirPath ) )
  o.dirPath = o.dirPath[ 0 ];
  if( _.strIs( o.dirPath ) )
  o.dirPath = path.dirFirst( o.dirPath );
  if( o.dirPath === null )
  o.dirPath = module.dirPath;
  if( o.dirPath )
  o.dirPath = path.canonize( o.dirPath );

  if( o.isIdentical === undefined || o.isIdentical === null )
  o.isIdentical =
  (
    o.willfilesPath === this.willfilesPath
    // || _.entityIdentical( path.simplify( o.willfilesPath ), path.simplify( this.willfilesPath ) )
    || _.path.map.identical( path.simplify( o.willfilesPath ), path.simplify( this.willfilesPath ) )
  );
  /* yyy */

  if( o.willfilesPath && o.willfilesPath.length )
  o.commonPath = _.Will.CommonPathFor( o.willfilesPath );
  else
  o.commonPath = module.commonPath;

  o.localPath = null;
  if( !path.isGlobal( o.commonPath ) )
  o.localPath = o.commonPath;

  _.assert( arguments.length === 1 );
  _.boolIs( o.isIdentical );
  _.assert( o.dirPath === null || _.strDefined( o.dirPath ) );
  _.assert( o.dirPath === null || path.isAbsolute( o.dirPath ) );
  _.assert( o.dirPath === null || path.isNormalized( o.dirPath ) );
  _.assert( o.willfilesPath === null || path.s.allAreAbsolute( o.willfilesPath ) );
  _.assert
  (
    !module.isPreformed() || _.strDefined( o.commonPath ),
    () => `Each module requires commonPath, but ${module.absoluteName} does not have`
  );

  if( o.commonPath !== null )
  module[ fileNameSymbol ] = path.fullName( o.commonPath );

  will._pathChanged
  ({
    object : module,
    propName : 'willfilesPath',
    val : o.willfilesPath,
    ex : o.exWillfilesPath,
    isIdentical : o.isIdentical,
    kind : 'set',
  });

  will._pathChanged
  ({
    object : module,
    propName : 'dirPath',
    val : o.dirPath,
    ex : module.dirPath,
    kind : 'set',
  });

  will._pathChanged
  ({
    object : module,
    propName : 'commonPath',
    val : o.commonPath,
    ex : module.commonPath,
    kind : 'set',
  });

  will._pathChanged
  ({
    object : module,
    propName : 'localPath',
    val : o.localPath,
    ex : module.localPath,
    kind : 'set',
  });

  return o;
}

_filePathChanged2.defaults = _.mapExtend( null, _filePathChanged1.defaults );

//

function _remotePathAdopt()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( _.strDefined( module.remotePath ) );
  _.assert( _.strDefined( module.downloadPath ) );
  _.assert( _.strBegins( module.localPath, module.downloadPath ) );

  if( module.downloadPath !== module.repo.downloadPath || module.remotePath !== module.repo.remotePath )
  {
    module.repo = will.repoFrom
    ({
      isRemote : !!module.remotePath,
      downloadPath : module.downloadPath,
      remotePath : module.remotePath,
    });
  }

  return true;
}

//

function remotePathAdopt( o )
{
  let module = this;
  let will = module.will;

  if( _.strIs( arguments[ 0 ] ) )
  o = { remotePath : arguments[ 0 ] }
  o = _.routineOptions( remotePathAdopt, o );
  _.assert( arguments.length === 1 );

  if( module.remotePath === o.remotePath )
  return false;

  if( o.downloadPath === null )
  o.downloadPath = module.downloadPath;

  _.assert( _.strDefined( o.downloadPath ) );
  if( o.downloadPath )
  module._downloadPathPut( o.downloadPath );
  _.assert( _.strDefined( o.remotePath ) );
  module.remotePathSet( o.remotePath );

  _.assert( module.remotePath === o.remotePath );

  module._remotePathAdopt();

  return true;
}

remotePathAdopt.defaults =
{
  remotePath : null,
  downloadPath : null,
}

//

function remotePathEachAdopt( o )
{
  let module = this;
  let will = module.will;

  if( _.strIs( arguments[ 0 ] ) )
  o = { remotePath : arguments[ 0 ] }
  o = _.routineOptions( remotePathAdopt, o );
  _.assert( arguments.length === 1 );

  if( module.remotePath === o.remotePath )
  return false;

  let result = module.remotePathEachAdoptAct( o );

  _.assert( module.remotePath === o.remotePath );

  return result;
}

remotePathEachAdopt.defaults =
{
  ... remotePathAdopt.defaults,
}

//

function remotePathEachAdoptCurrent()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  module._remotePathAdopt();

  let o2 = Object.create( null );
  o2.remotePath = module.remotePath;
  o2.downloadPath = module.downloadPath;

  return module.remotePathEachAdoptAct( o2 );
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
  let logger = will.transaction.logger;

  _.arrayRemoveElementOnceStrictly( module.willfilesArray, willf );

  if( willf.role )
  {
    _.each( willf.role, ( role ) =>
    {
      _.assert( module.willfileWithRoleMap[ role ] === willf )
      delete module.willfileWithRoleMap[ role ];
    });
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
  let logger = will.transaction.logger;

  _.assert( arguments.length === 1 );

  if( _.arrayIs( willf ) )
  {
    willf.forEach( ( willf ) => module.willfileRegister( willf ) );
    return;
  }

  _.arrayAppendOnce( module.willfilesArray, willf );

  if( willf.role )
  {
    _.each( willf.role, ( role ) =>
    {
      _.assert( !module.willfileWithRoleMap[ role ] || module.willfileWithRoleMap[ role ] === willf, 'Module already has willfile with role', role )
      module.willfileWithRoleMap[ role ] = willf;
    });
  }

  _.assert( !!module.willfilesArray.length );

  let willfilesPath = _.arrayFlatten( _.select( module.willfilesArray, '*/filePath' ) );
  module.willfilesPath = willfilesPath;

  module.isOut = !!_.any( module.willfilesArray, ( wfile ) => wfile.isOut );

}

//

function willfileAttach( filePath )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( filePath ) );

  let o2 = Object.create( null );
  o2.filePath = filePath;

  let got = will.willfileFor({ willf : o2, combining : 'supplement' });

  module.willfileRegister( got.willf );

  return got.willf;
}

//

function _willfilesRelease( willfilesArray )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  willfilesArray = willfilesArray || module.willfilesArray;
  willfilesArray = willfilesArray.slice();

  for( let i = willfilesArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = willfilesArray[ i ];
    module.willfileUnregister( willf );
    _.assert( !willf.isFinited() );
    if( !willf.isUsed() )
    willf.finit();
  }

}

// //
//
// function repoIsRemote( remotePath )
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( !!module.willfilesPath || !!module.dirPath );
//   _.assert( arguments.length === 0, 'Expects no arguments' );
//
//   if( remotePath === undefined )
//   remotePath = module.remotePath ? path.common( module.remotePath ) : module.commonPath;
//   let remoteProvider = fileProvider.providerForPath( remotePath );
//
//   _.assert( !!remoteProvider );
//
//   return !!remoteProvider.isVcs;
// }

//

/* qqq : for Vova : refactor, discusss first */
function repoVerify( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( module.isPreformed() );
  _.assert( arguments.length === 1 );
  _.routineOptions( repoVerify, o );

  let ready = _.take( null );

  ready.then( () => reform( module ) )
  ready.then( () => act( module ) )

  return ready;

  /* */

  function act( module )
  {

    if( o.hasFiles )
    if( !module.repo.hasFiles )
    {
      if( o.throwing )
      throw _.errBrief( '! Submodule', ( module.qualifiedName ), 'does not have files' );
      return false;
    }

    // _.assert /* Dmytro : used option `formed2` as alternative option for class `Module` */
    // (
    //   !!module && module.formed >= 2,
    //   () => 'Submodule', ( module ? module.qualifiedName : n ), 'was not preformed to verify'
    // );

    // _.assert
    // (
    //   !!module && ( module instanceof _.will.Module ) ? module.formed2 : module.formed,
    //   () => 'Submodule', ( module ? module.qualifiedName : '' ), 'was not preformed to verify'
    // );

    _.assert
    (
      !!module && module.isPreformed(),
      () => '! Submodule', ( module ? module.qualifiedName : '' ), 'was not preformed'
    );

    /* isValid */

    if( o.isValid )
    if( !module.isValid() )
    throw _.err( module.errorGet(), '\n! Submodule', ( module.qualifiedName ), 'is downloaded, but it\'s not valid.' );

    /* is remote / enabled */

    if( !module.repo.isRemote )
    return true;
    // if( r.relation && !r.relation.enabled )
    // return true;

    /* repository check */

    if( o.isRepository )
    if( !module.repo.isRepository )
    {
      if( o.throwing )
      throw _.errBrief( '! Submodule', ( module.qualifiedName ), `is downloaded, but it's not a repository` );
      return false;
    }

    let remoteProvider = will.fileProvider.providerForPath( module.repo.remotePath );

    /* origin check */

    if( o.hasRemote )
    {
      let result = remoteProvider.hasRemote
      ({
        localPath : module.repo.downloadPath,
        remotePath : module.repo.remotePath
      });

      if( !result.remoteIsValid )
      {
        if( o.throwing )
        throw _.errBrief
        (
          '! Submodule', ( module.qualifiedName ), 'has different origin url:',
          _.color.strFormat( result.originVcsPath, 'path' ), ', expected url:', _.color.strFormat( result.remoteVcsPath, 'path' )
        );

        return false;
      }
    }

    /* version check */

    if( o.isUpToDate )
    {
      if( module.repo.isUpToDate )
      return true;

      if( !o.throwing )
      return false;

      let remoteParsed = remoteProvider.pathParse( module.repo.remotePath );
      let remoteVersion = remoteParsed.hash || 'master';
      let localVersion = remoteProvider.versionLocalRetrive( module.repo.downloadPath );

      if( remoteVersion === localVersion )
      throw _.errBrief( '! Submodule', ( module.qualifiedName ), 'is not up to date!' );

      throw _.errBrief
      (
        '! Submodule', ( module.qualifiedName ), 'has version different from that is specified in will-file!',
        '\nCurrent:', localVersion,
        '\nExpected:', remoteVersion
      );
    }

    return true;
  }

  /* */

  function reform( module )
  {
    let con = _.take( null );
    con.then( () => module.repo.status({ all : 1, invalidating : 1 }) )
    con.then( () => module )
    return con;
  }

  /* */

}

var defaults = repoVerify.defaults = Object.create( null );

defaults.throwing = 1;
defaults.asMap = 0;
defaults.hasFiles = 1;
defaults.hasRemote = 1;
defaults.isValid = 1;
defaults.isRepository = 1;
defaults.isUpToDate = 1

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

  isOut : null,

}

let Aggregates =
{
}

let Associates =
{
  will : null,
  peerModule : null,
  repo : null,
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

  _NameWithLocationFormat,

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
  willfilePath : 'willfilePath',
  isGitRepository : 'isGitRepository',
  isDownloaded : 'isDownloaded',

  hasFiles : 'hasFiles',
  isRepository : 'isRepository',
  remoteIsValid : 'remoteIsValid',
  hasLocalChanges : 'hasLocalChanges',
  isUpToDate : 'isUpToDate',
  downloadRequired : 'downloadRequired',
  updateRequired : 'updateRequired',
  agreeRequired : 'agreeRequired',
  LocalRepoDefaults : 'LocalRepoDefaults',
  isRemote : 'isRemote',

}

let Accessors =
{

  fileName : { writable : 0 },
  // nameWithLocation : { writable : 0 },

  willfilesArray : { set : willfileArraySet },
  willfileWithRoleMap : { writable : 0 },

}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,

  // relator

  isUsedManually,

  // etc

  optionsFormingForward,

  // name

  // nameWithLocationGet,
  _NameWithLocationFormat,

  // path

  _shortestModuleDirPathGet,

  _filePathSet,
  _filePathChanged1,
  _filePathChanged2,

  _remotePathAdopt,
  remotePathAdopt,
  remotePathEachAdopt,
  remotePathEachAdoptCurrent,

  // willfile

  willfileArraySet,
  willfileUnregister,
  willfileRegister,
  willfileAttach,

  _willfilesRelease,

  // repo

  // repoIsRemote,
  repoVerify,

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
  extend : Extension,
});

_.will[ Self.shortName ] = Self;

})();
