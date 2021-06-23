( function _Repository_s_()
{

'use strict';

/**
 * @classdesc Class wWillRepository implements interface for work with repository of module.
 * @class wWillRepository
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = null;
const Self = wWillRepository;
function wWillRepository( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Repository';

// --
// inter
// --

function finit()
{
  let repo = this;
  return _.Copyable.prototype.finit.apply( repo, arguments );
}

//

function init( o )
{
  let repo = this;

  repo._.downloadPath = null;
  repo._.remotePath = null;
  repo._.isRemote = null;

  repo.statusInvalidate({ all : 1 });

  _.workpiece.initFields( repo );
  Object.preventExtensions( repo );
  _.Will.ResourceCounter += 1;
  repo.id = _.Will.ResourceCounter;

  if( o )
  {
    if( o.downloadPath !== undefined )
    repo._.downloadPath = o.downloadPath;
    if( o.remotePath !== undefined )
    repo._.remotePath = o.remotePath;
    if( o.isRemote !== undefined )
    repo._.isRemote = o.isRemote;
    repo.copy( o );
  }

}

// --
// repo
// --

function statusInvalidate( o )
{
  let repo = this;

  o = _.routine.options_( statusInvalidate, arguments );

  for( let k in o )
  {
    if( o[ k ] === null )
    o[ k ] = o.all;
  }

  for( let k in o )
  {
    if( k === 'all' )
    continue;
    if( o[ k ] )
    repo._[ k ] = null;
  }

}

statusInvalidate.defaults =
{
  all : 1,
  dirExists : null,
  hasFiles : null,
  isRepository : null,
  hasLocalChanges : null,
  hasLocalUncommittedChanges : null,
  isUpToDate : null,
  remoteIsValid : null,
  safeToDelete : null,
  downloadRequired : null,
  updateRequired : null,
  agreeRequired : null,
}

//

function status( o )
{
  let repo = this;
  let will = repo.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );
  let ready = _.take( null );
  // let vcs = will.vcsToolsFor( repo.remotePath );
  let vcs = _.repo.vcsFor( repo.remotePath );
  let remoteProvider = will.vcsProviderFor( repo.remotePath );

  o = _.routine.options_( status, arguments );

  _.assert( _.boolIs( repo.isRemote ) );

  for( let k in o )
  {
    if( o[ k ] === null )
    o[ k ] = o.all;
  }

  if( o.downloadRequired )
  {
    o.hasFiles = true;
  }

  if( o.updateRequired || o.agreeRequired )
  {
    o.isRepository = true;
    o.isUpToDate = true;
    o.remoteIsValid = true;
  }

  if( o.safeToDelete )
  {
    o.hasLocalChanges = true;
    o.isRepository = true;
    o.hasFiles = true;
  }

  if( o.isUpToDate || o.remoteIsValid || o.hasLocalChanges || o.hasLocalUncommittedChanges )
  {
    o.isRepository = true;
  }

  if( repo.isRemote )
  {
    _.assert( !!vcs );
    _.assert( !!remoteProvider );
  }

  if( repo.isRemote === false || _.longHasNone( vcs.protocols, [ 'git', 'npm' ] ) )
  {

    for( let k in o )
    {
      if( k === 'all' || k === 'invalidating' )
      continue;
      if( o[ k ] )
      {
        _.assert( _.boolIs( repo.LocalDefaults[ k ] ) );
        repo._[ k ] = repo.LocalDefaults[ k ];
      }
    }

  }
  else
  {

    if( o.dirExists )
    if( o.invalidating || repo._.dirExists === null )
    ready.also( dirExistsReform );

    if( o.hasFiles )
    if( o.invalidating || repo._.hasFiles === null )
    ready.also( hasFilesReform );

    if( o.isRepository )
    if( o.invalidating || repo._.isRepository === null )
    ready.also( isRepositoryReform );

    if( o.hasLocalChanges || o.hasLocalUncommittedChanges )
    if( o.invalidating || repo._.hasLocalChanges === null || repo._.hasLocalUncommittedChanges === null )
    ready.also( hasLocalChangesReform );

    // if( o.hasLocalUncommittedChanges )
    // if( o.invalidating || repo._.hasLocalUncommittedChanges === null )
    // ready.also( hasLocalUncommittedChangesReform );

    if( o.isUpToDate )
    if( o.invalidating || repo._.isUpToDate === null )
    ready.also( isUpToDateReform );

    if( o.remoteIsValid )
    if( o.invalidating || repo._.remoteIsValid === null )
    ready.also( remoteIsValidReform );

    if( o.safeToDelete )
    if( o.invalidating || repo._.safeToDelete === null )
    ready.also( safeToDeleteReform );

    if( o.downloadRequired )
    if( o.invalidating || repo._.downloadRequired === null )
    ready.then( downloadRequiredReform );

    if( o.updateRequired )
    if( o.invalidating || repo._.updateRequired === null )
    ready.then( updateRequiredReform );

    if( o.agreeRequired )
    if( o.invalidating || repo._.agreeRequired === null )
    ready.then( agreeRequiredReform );

  }

  ready.finally( returnResult );
  return ready

  /* */

  function returnResult( err, arg )
  {
    if( err )
    throw _.err( err, `\nFailed to get status for repository at ${repo.downloadPath}` );
    for( let k in o )
    {
      if( k === 'all' || k === 'invalidating' )
      continue;
      if( o[ k ] )
      {
        result[ k ] = repo._[ k ];
        _.assert( _.boolIs( result[ k ] ) );
      }
    }
    return result;
  }

  /* */

  function dirExistsReform()
  {

    _.assert( _.strDefined( repo.downloadPath ) );
    _.assert( repo.isRemote === true );

    if( !fileProvider.isDir( repo.downloadPath ) )
    return end( false );

    return end( true );

    function end( result )
    {
      _.assert( _.boolLike( result ) );
      repo._.dirExists = result;
      return result;
    }

  }

  /* */

  function hasFilesReform()
  {

    _.assert( _.strDefined( repo.downloadPath ) );
    _.assert( repo.isRemote === true );

    if( !fileProvider.isDir( repo.downloadPath ) )
    return end( false );
    if( fileProvider.dirIsEmpty( repo.downloadPath ) )
    return end( false );

    return end( true );

    function end( result )
    {
      _.assert( _.boolLike( result ) );
      repo._.hasFiles = result;
      return result;
    }

  }

  /* */

  function hasLocalChangesReform()
  {

    _.assert( arguments.length === 0, 'Expects no arguments' );
    _.assert( _.boolIs( repo.isRepository ) );

    if( o.invalidating && o.isRepository )
    {
      if( !repo.isRepository )
      return end( false );
    }
    else
    {
      let isRepository = vcs.isRepository({ localPath : repo.downloadPath, sync : 1 });
      if( repo._.isRepository === null )
      repo._.isRepository = isRepository;
      if( !isRepository )
      return end( false );
    }

    let status = false;
    let o2 =
    {
      localPath : repo.downloadPath,
      uncommitted : 1,
      detailing : o.hasLocalUncommittedChanges,
      unpushed : o.hasLocalChanges,
      explaining : 0,
      sync : 1,
    };
    if( _.longHas( vcs.protocols, 'git' ) )
    status = vcs.statusLocal( o2 );
    else
    status = vcs.hasLocalChanges( o2 );

    return end( status );

    function end( result )
    {
      if( _.boolIs( result ) )
      {
        repo._.hasLocalChanges = result;
        if( o.hasLocalUncommittedChanges )
        repo._.hasLocalUncommittedChanges = result;
      }
      else
      {
        _.assert( _.object.isBasic( status ) );
        repo._.hasLocalChanges = result.status;
        repo._.hasLocalUncommittedChanges = result.uncommitted;
        result = result.status;
      }

      return result;
    }

  }

  /* */

  function hasLocalUncommittedChangesReform()
  {

    _.assert( arguments.length === 0, 'Expects no arguments' );
    _.assert( _.boolIs( repo.isRepository ) );

    if( o.invalidating && o.isRepository )
    {
      if( !repo.isRepository )
      return end( false );
    }
    else
    {
      let isRepository = vcs.isRepository({ localPath : repo.downloadPath, sync : 1 });
      if( repo._.isRepository === null )
      repo._.isRepository = isRepository;
      if( !isRepository )
      return end( false );
    }

    let result = vcs.hasLocalChanges
    ({
      localPath : repo.downloadPath,
      uncommitted : 1,
      unpushed : 0,
      sync : 1,
    });

    return end( result );

    function end( result )
    {
      _.assert( _.boolIs( result ) );
      repo._.hasLocalUncommittedChanges = result;
      return result;
    }

  }

  /* */

  function safeToDeleteReform()
  {

    _.assert( arguments.length === 0, 'Expects no arguments' );
    _.assert( _.boolIs( repo.isRepository ) );
    _.assert( _.boolIs( repo.hasLocalChanges ) );
    _.assert( _.boolIs( repo.hasFiles ) );

    if( repo.isRepository )
    return end( !repo.hasLocalChanges );
    else
    return end( !repo.hasFiles )

    function end( result )
    {
      _.assert( _.boolIs( result ) );
      repo._.safeToDelete = result;
      return result;
    }

  }

  /* */

  function isRepositoryReform()
  {

    // if( repo.downloadPath && _.strEnds( repo.downloadPath, 'ModuleForTesting1a' ) )
    // {
    //   logger.log( 'isRepositoryReform', repo.downloadPath );
    // }

    _.assert( _.strDefined( repo.downloadPath ) );
    _.assert( repo.isRemote === true );

    if( _.longHasNone( vcs.protocols, [ 'git', 'npm' ] ) ) /* xxx qqq : ? */
    return end( false );

    if( !repo.dirExists )
    return end( false );

    let result = vcs.isRepository
    ({
      localPath : repo.downloadPath,
      sync : 1,
    });

    _.assert( !_.consequenceIs( result ) );

    return end( result );

    function end( result )
    {
      _.assert( _.boolIs( result ) );
      repo._.isRepository = result;
      return result;
    }

  }

  /* */

  function isUpToDateReform()
  {

    _.assert( _.strDefined( repo.downloadPath ) );
    _.assert( repo.isRemote === true );
    _.assert( _.boolIs( repo.isRepository ) );

    if( !repo.isRepository )
    return end( false );

    _.assert( !!remoteProvider.isVcs );
    let result = remoteProvider.isUpToDate
    ({
      remotePath : repo.remotePath,
      localPath : repo.downloadPath,
      // logger : will.verbosity - 3,
      logger : will.transaction.verbosity - 3,
    });

    return _.Consequence.From( result )
    .finally( ( err, arg ) =>
    {
      if( err )
      throw err;
      return end( arg );
    });

    function end( result )
    {
      _.assert( _.boolIs( result ) )
      repo._.isUpToDate = result;
      return result;
    }

  }

  /* */

  function remoteIsValidReform()
  {

    _.assert( _.strDefined( repo.remotePath ) );
    _.assert( _.boolIs( repo.isRepository ) );

    if( !repo.isRepository )
    return end( false );

    let result = remoteProvider.hasRemote
    ({
      localPath : repo.downloadPath,
      remotePath : repo.remotePath
    });

    return end( result.remoteIsValid );

    function end( result )
    {
      _.assert( _.boolIs( result ) );
      repo._.remoteIsValid = result;
      return result;
    }
  }

  /* */

  function downloadRequiredReform()
  {
    _.assert( _.boolIs( repo.hasFiles ) );

    let result;

    if( o.invalidating && ( o.dirExists || o.hasFiles ) )
    {
      result = !repo.dirExists || !repo.hasFiles;
    }
    else
    {
      result = !fileProvider.isDir( repo.downloadPath );
      if( !result )
      result = fileProvider.dirIsEmpty( repo.downloadPath );
    }

    repo._.downloadRequired = result;

    return result;
  }

  /* */

  function updateRequiredReform()
  {
    _.assert( _.boolIs( repo.isRepository ) );
    _.assert( _.boolIs( repo.remoteIsValid ) );
    _.assert( _.boolIs( repo.isUpToDate ) );

    let result = !repo.dirExists || !repo.isRepository || !repo.remoteIsValid || !repo.isUpToDate;
    repo._.updateRequired = result;
    return result;
  }

  /* */

  function agreeRequiredReform()
  {
    _.assert( _.boolIs( repo.isRepository ) );
    _.assert( _.boolIs( repo.remoteIsValid ) );
    _.assert( _.boolIs( repo.isUpToDate ) );
    let result = !repo.dirExists || !repo.isRepository || !repo.remoteIsValid || !repo.isUpToDate;
    repo._.agreeRequired = result;
    return result;
  }

}

status.defaults =
{
  ... statusInvalidate.defaults,
  all : 0,
  invalidating : 0,
}

//

function _statusGetter_functor( propName )
{
  return function get()
  {
    let repo = this;

    _.assert( repo._[ propName ] === null || _.boolIs( repo._[ propName ] ) );

    if( repo._[ propName ] === null )
    repo.status({ all : 0, [ propName ] : 1 });

    return repo._[ propName ];
  }
}

// //
//
// function repoIsRemote( remotePath )
// {
//   let repo = this;
//   let will = repo.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( arguments.length === 1 );
//
//   if( remotePath === undefined )
//   remotePath = repo.remotePath ? repo.remotePath : repo.downloadPath;
//   let remoteProvider = will.vcsProviderFor( remotePath );
//
//   _.assert( !!remoteProvider );
//
//   return !!remoteProvider.isVcs;
// }

//

function repoLocalVersion()
{
  let repo = this;
  let will = repo.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  let remoteProvider = will.vcsProviderFor( repo.downloadPath );
  return remoteProvider.versionLocalRetrive( repo.downloadPath );
}

//

function repoLatestVersion()
{
  let repo = this;
  let will = repo.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  let remoteProvider = will.vcsProviderFor( repo.downloadPath );
  return remoteProvider.versionRemoteLatestRetrive( repo.downloadPath )
}

//

function renormalize( dirPath )
{
  let repo = this;
  let will = repo.will;

  _.assert( arguments.length === 1 );
  _.assert( _.strDefined( dirPath ) );

  let localPath = repo.downloadPath || dirPath;

  return true; /* xxx : check */

  if( !_.git.isRepository({ localPath }) )
  {
    return true;
  }

  return _.git.renormalize
  ({
    localPath,
    sync : 0,
    safe : 1,
    force : 0,
    throwing : 0,
    audit : 1
  })
}

//

function exportString()
{
  let repo = this;
  let will = repo.will;
  let result = '';
  // let vcs = will.vcsToolsFor( repo.remotePath );
  let vcs = _.repo.vcsFor( repo.remotePath );

  if( vcs )
  result += `${vcs.protocols[ 0 ]} repository ${repo.id}\n`;
  else
  result += `repository ${repo.id}\n`;

  result += `  remote path : ${repo.remotePath}\n`;
  result += `  download path : ${repo.downloadPath}\n`;
  result += `  isRemote : ${repo.isRemote}\n`;

  for( let f in repo.LocalDefaults )
  if( repo._[ f ] !== null )
  result += `  ${f} : ${repo._[ f ]}\n`;

  return result;
}

//

function Hash( o )
{
  o = _.routine.options_( Hash, o );
  _.assert( o.downloadPath === null || _.strIs( o.downloadPath ) );
  _.assert( o.remotePath === null || _.strIs( o.remotePath ) );
  return o.downloadPath + '-' + o.remotePath;
}

Hash.defaults =
{
  downloadPath : null,
  remotePath : null,
}

//

function remotePathChange( remotePath )
{
  let repo = this;
  _.assert( _.strDefined( remotePath ) );
  repo._.remotePath = remotePath;
}

// --
// relations
// --

let LocalDefaults =
{
  dirExists : true,
  hasFiles : true,
  isRepository : true,
  hasLocalChanges : false,
  hasLocalUncommittedChanges : false,
  isUpToDate : true,
  remoteIsValid : true,
  safeToDelete : false,
  downloadRequired : false,
  updateRequired : false,
  agreeRequired : false,
}

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
  will : null,
}

let Medials =
{

  remotePath : null,
  downloadPath : null,
  isRemote : null,

}

let Restricts =
{

  id : null,

}

let Statics =
{
  LocalDefaults,
  Hash,
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
  isOut : 'isOut',
  localPath : 'localPath',

}

let Accessors =
{

  _ : { get : _.accessor.getter.withSymbol, writable : 0, strict : 0 },

  dirExists : { get : _statusGetter_functor( 'dirExists' ), writable : 0 },
  hasFiles : { get : _statusGetter_functor( 'hasFiles' ), writable : 0 },
  isRepository : { get : _statusGetter_functor( 'isRepository' ), writable : 0 },
  hasLocalChanges : { get : _statusGetter_functor( 'hasLocalChanges' ), writable : 0 },
  hasLocalUncommittedChanges : { get : _statusGetter_functor( 'hasLocalUncommittedChanges' ), writable : 0 },
  remoteIsValid : { get : _statusGetter_functor( 'remoteIsValid' ), writable : 0 },
  isUpToDate : { get : _statusGetter_functor( 'isUpToDate' ), writable : 0 },
  safeToDelete : { get : _statusGetter_functor( 'safeToDelete' ), writable : 0 },
  downloadRequired : { get : _statusGetter_functor( 'downloadRequired' ), writable : 0 },
  updateRequired : { get : _statusGetter_functor( 'updateRequired' ), writable : 0 },
  agreeRequired : { get : _statusGetter_functor( 'agreeRequired' ), writable : 0 },

  remotePath : { writable : 0 },
  downloadPath : { writable : 0 },
  isRemote : { writable : 0 },

}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,

  // repo

  statusInvalidate,
  status,

  // repoIsRemote,
  repoLocalVersion,
  repoLatestVersion,

  renormalize,

  exportString,
  Hash,

  remotePathChange,

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

_.Copyable.mixin( Self );
_.will[ Self.shortName ] = Self;

})();

