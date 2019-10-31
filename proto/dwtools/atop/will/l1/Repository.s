( function _Repository_s_( ) {

'use strict';

if( typeof repo !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = _global_.wTools;
let Parent = null;
let Self = function wWillRepository( o )
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

  // if( repo.id === 339 )
  // debugger;

}

// --
// repo
// --

function statusInvalidate( o )
{
  let repo = this;

  o = _.routineOptions( statusInvalidate, arguments );

  for( let k in o )
  {
    if( o[ k ] === null )
    o[ k ] = o.all;
  }

  // if( repo.isRemote === false )
  // {
  //   for( let k in o )
  //   {
  //     if( k === 'all' )
  //     continue;
  //     if( o[ k ] )
  //     // repo._repoStatusPut( k, repo.LocalDefaults[ k ] );
  //     repo._[ k ] = repo.LocalDefaults[ k ];
  //   }
  // }
  // else
  // {
    for( let k in o )
    {
      if( k === 'all' )
      continue;
      if( o[ k ] )
      // repo._repoStatusPut( k, null );
      repo._[ k ] = null;
    }
  // }

}

statusInvalidate.defaults =
{
  all : 1,
  dirExists : null,
  hasFiles : null,
  isRepository : null,
  hasLocalChanges : null,
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
  let ready = new _.Consequence().take( null );
  let vcs = will.vcsToolsFor( repo.remotePath );
  let remoteProvider = will.vcsProviderFor( repo.remotePath );

  o = _.routineOptions( status, arguments );

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

  if( o.isUpToDate || o.remoteIsValid || o.hasLocalChanges )
  {
    o.isRepository = true;
  }

  if( repo.isRemote )
  {
    _.assert( !!vcs );
    _.assert( !!remoteProvider );
  }

  if( repo.isRemote === false || !_.arrayHas( vcs.protocols, 'git' ) )
  {

    for( let k in o )
    {
      if( k === 'all' || k === 'reset' )
      continue;
      if( o[ k ] )
      {
        _.assert( _.boolIs( repo.LocalDefaults[ k ] ) );
        repo._[ k ] = repo.LocalDefaults[ k ];
      }
      // repo._repoStatusPut( k, repo.LocalDefaults[ k ] );
    }

  }
  else
  {

    if( o.dirExists )
    if( o.reset || repo.dirExists === null )
    ready.also( dirExistsReform );

    if( o.hasFiles )
    if( o.reset || repo.hasFiles === null )
    ready.also( hasFilesReform );

    if( o.isRepository )
    if( o.reset || repo.isRepository === null )
    ready.also( isRepositoryReform );

    if( o.hasLocalChanges )
    if( o.reset || repo.hasLocalChanges === null )
    ready.also( hasLocalChangesReform );

    if( o.isUpToDate )
    if( o.reset || repo.isUpToDate === null )
    ready.also( isUpToDateReform );

    if( o.remoteIsValid )
    if( o.reset || repo.remoteIsValid === null )
    ready.also( remoteIsValidReform );

    if( o.safeToDelete )
    if( o.reset || repo.safeToDelete === null )
    ready.also( safeToDeleteReform );

    if( o.downloadRequired )
    if( o.reset || repo.downloadRequired === null )
    ready.then( downloadRequiredReform );

    if( o.updateRequired )
    if( o.reset || repo.updateRequired === null )
    ready.then( updateRequiredReform );

    if( o.agreeRequired )
    if( o.reset || repo.agreeRequired === null )
    ready.then( agreeRequiredReform );

  }

  ready.finally( returnResult );
  return ready

  /* */

  function returnResult( err, arg )
  {
    if( err )
    debugger;
    if( err )
    throw _.err( err, `\nFailed to get status for repository at ${repo.downloadPath}` );
    for( let k in o )
    {
      if( k === 'all' || k === 'reset' )
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
    // _.assert( !!repo.willfilesPath );
    _.assert( repo.isRemote === true );

    // let remoteProvider = will.vcsProviderFor( repo.remotePath );
    // _.assert( !!remoteProvider.isVcs );

    // let result = remoteProvider.hasFiles
    // ({
    //   localPath : repo.downloadPath,
    // });

    if( !fileProvider.isDir( repo.downloadPath ) )
    return end( false );

    // _.assert( !_.consequenceIs( result ) );

    return end( true );

    function end( result )
    {
      _.assert( _.boolLike( result ) );
      // result = !!result;
      // repo._repoStatusPut( 'hasFiles', result );
      repo._.dirExists = result;
      return result;
    }

  }

  /* */

  function hasFilesReform()
  {

    _.assert( _.strDefined( repo.downloadPath ) );
    // _.assert( !!repo.willfilesPath );
    _.assert( repo.isRemote === true );

    // let remoteProvider = will.vcsProviderFor( repo.remotePath );
    // _.assert( !!remoteProvider.isVcs );

    // let result = remoteProvider.hasFiles
    // ({
    //   localPath : repo.downloadPath,
    // });

    if( !fileProvider.isDir( repo.downloadPath ) )
    return end( false );
    if( fileProvider.dirIsEmpty( repo.downloadPath ) )
    return end( false );

    // _.assert( !_.consequenceIs( result ) );

    return end( true );

    function end( result )
    {
      _.assert( _.boolLike( result ) );
      // result = !!result;
      // repo._repoStatusPut( 'hasFiles', result );
      repo._.hasFiles = result;
      return result;
    }

  }

  /* */

  function hasLocalChangesReform()
  {

    // _.assert( !!repo.willfilesPath || !!repo.dirPath );
    _.assert( arguments.length === 0 );
    _.assert( _.boolIs( repo.isRepository ) );

    if( !repo.isRepository )
    return end( false );

    // let vcs = will.vcsToolsFor( repo.remotePath );
    // if( !_.arrayHas( vcs.protocols, 'git' ) )
    // return end( false );

    // qqq : use remoteProvider
    // let remoteProvider = will.vcsProviderFor( repo.remotePath );
    // return remoteProvider.hasLocalChanges( repo.downloadPath );
    let result = vcs.hasLocalChanges
    ({
      localPath : repo.downloadPath,
      unpushed : 1,
      sync : 1,
    });

    return end( result );

    function end( result )
    {
      _.assert( _.boolIs( result ) );
      repo._.hasLocalChanges = result;
      return result;
    }

  }

  /* */

  function safeToDeleteReform()
  {

    _.assert( arguments.length === 0 );
    _.assert( _.boolIs( repo.isRepository ) );
    _.assert( _.boolIs( repo.hasLocalChanges ) );
    _.assert( _.boolIs( repo.hasFiles ) );

    if( repo.isRepository )
    return end( repo.hasLocalChanges );
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

    _.assert( _.strDefined( repo.downloadPath ) );
    // _.assert( !!repo.willfilesPath );
    _.assert( repo.isRemote === true );

    // let remoteProvider = will.vcsProviderFor( repo.remotePath );
    // _.assert( !!remoteProvider.isVcs );

    // let vcs = will.vcsToolsFor( repo.remotePath );
    if( !_.arrayHas( vcs.protocols, 'git' ) ) /* xxx qqq */
    return end( false );

    let result = vcs.isRepository
    ({
      localPath : repo.downloadPath,
      sync : 1,
    });

    // let result = _.git.isRepository
    // ({
    //   localPath : repo.downloadPath,
    // });

    _.assert( !_.consequenceIs( result ) );

    return end( result );

    // if( !result )
    // return end( result );

    // return _.Consequence.From( result )
    // .finally( ( err, arg ) =>
    // {
    //   end( arg );
    //   if( err )
    //   throw err;
    //   return arg;
    // });

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
    // _.assert( !!repo.willfilesPath );
    _.assert( repo.isRemote === true );
    _.assert( _.boolIs( repo.isRepository ) );

    if( !repo.isRepository )
    return end( false );

    // let remoteProvider = will.vcsProviderFor( repo.remotePath );

    _.assert( !!remoteProvider.isVcs );
    let result = remoteProvider.isUpToDate
    ({
      remotePath : repo.remotePath,
      localPath : repo.downloadPath,
      verbosity : will.verbosity - 3,
    });

    // if( !result )
    // return end( result );

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
      // repo._repoStatusPut( 'isUpToDate', result );
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

    // let remoteProvider = repo.will.vcsProviderFor( repo.remotePath );
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
      // repo._repoStatusPut( 'remoteIsValid', result );
      return result;
    }
  }

  /* */

  function downloadRequiredReform()
  {
    _.assert( _.boolIs( repo.hasFiles ) );
    let result = !repo.hasFiles;
    repo._.downloadRequired = result;
    // repo._repoStatusPut( 'downloadRequired', !repo.hasFiles );
    return result;
  }

  /* */

  function updateRequiredReform()
  {
    _.assert( _.boolIs( repo.isRepository ) );
    _.assert( _.boolIs( repo.remoteIsValid ) );
    _.assert( _.boolIs( repo.isUpToDate ) );
    let result = !repo.isRepository || !repo.remoteIsValid || !repo.isUpToDate;
    repo._.updateRequired = result;
    // repo._repoStatusPut( 'updateRequired', !repo.isRepository || !repo.remoteIsValid || !repo.isUpToDate );
    return result;
  }

  /* */

  function agreeRequiredReform()
  {
    _.assert( _.boolIs( repo.isRepository ) );
    _.assert( _.boolIs( repo.remoteIsValid ) );
    _.assert( _.boolIs( repo.isUpToDate ) );
    let result = !repo.isRepository || !repo.remoteIsValid || !repo.isUpToDate;
    repo._.agreeRequired = result;
    // repo._repoStatusPut( 'agreeRequired', !repo.isRepository || !repo.remoteIsValid || !repo.isUpToDate );
    return result;
  }

  // function _repoIsFresh( o )
  // {
  //   let opener = this;
  //   let ready = _.Consequence().take( null );
  //
  //   ready
  //   .then( () =>
  //   {
  //     if( o.mode === 'download' )
  //     return hasFilesRepositoryReform();
  //     else if( o.mode === 'update' )
  //     return isUpdatedRepositoryReform();
  //     else if( o.mode === 'agree' )
  //     return isUpdatedRepositoryReform();
  //   })
  //   .then( function()
  //   {
  //     let downloading = false;
  //     if( o.mode === 'download' )
  //     downloading = !opener.hasFiles;
  //     else if( o.mode === 'update' )
  //     downloading = !opener.isUpToDate || !opener.isRepository;
  //     else if( o.mode === 'agree' )
  //     downloading = !opener.isUpToDate || !opener.isRepository;
  //     _.assert( _.boolLike( downloading ) );
  //     return !!downloading;
  //   })
  //   .then( ( downloading ) =>
  //   {
  //     if( !downloading )
  //     if( o.mode === 'update' || o.mode === 'agree' )
  //     {
  //       let gitProvider = opener.will.will.vcsProviderFor( opener.remotePath );
  //       let result = gitProvider.hasRemote
  //       ({
  //         localPath : opener.downloadPath,
  //         remotePath : opener.remotePath
  //       });
  //       downloading = !result.remoteIsValid;
  //     }
  //     return !downloading;
  //   })
  //
  //   return ready;
  //
  //   /*  */
  //
  //   function isUpdatedRepositoryReform()
  //   {
  //     let con = new _.Consequence().take( null );
  //     con.then( () => opener.repoIsGoodReform() )
  //     con.then( () => opener.repoIsUpToDateReform() )
  //     return con;
  //   }
  //
  //   /* */
  //
  //   function hasFilesRepositoryReform()
  //   {
  //     let con = new _.Consequence().take( null );
  //     con.then( () => opener.repoHasFilesReform() )
  //     return con;
  //   }
  //
  // }

}

status.defaults =
{
  ... statusInvalidate.defaults,
  all : 0,
  reset : 0,
}

//

function _statusGetter_functor( fieldName )
{
  return function get()
  {
    let repo = this;

    _.assert( repo._[ fieldName ] === null || _.boolIs( repo._[ fieldName ] ) );

    if( repo._[ fieldName ] === null )
    repo.status({ all : 0, [ fieldName ] : 1 });

    return repo._[ fieldName ];
  }
}

// //
//
// function _repoStatusPut( fieldName, src )
// {
//   let repo = this;
//   debugger;
//   repo._[ fieldName ] = src;
//   return src;
// }

//

function repoIsRemote( remotePath )
{
  let repo = this;
  let will = repo.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  // _.assert( !!repo.willfilesPath || !!repo.dirPath );
  _.assert( arguments.length === 1 );

  // if( !repo.superRelation )
  // return end( false );

  if( remotePath === undefined )
  remotePath = repo.remotePath ? repo.remotePath : repo.downloadPath;
  let remoteProvider = will.vcsProviderFor( remotePath );

  _.assert( !!remoteProvider );

  return !!remoteProvider.isVcs;

  // if( remoteProvider.isVcs )
  // return end( true );
  //
  // return end( false );

  /* */

  // function end( result )
  // {
  //   repo.isRemote = result;
  //   return result;
  // }
}

//
// //
//
// function repoIsGoodReform()
// {
//   let repo = this;
//   let will = repo.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( _.strDefined( repo.downloadPath ) );
//   _.assert( !!repo.willfilesPath );
//   _.assert( repo.isRemote === true );
//
//   // let remoteProvider = will.vcsProviderFor( repo.remotePath );
//   // _.assert( !!remoteProvider.isVcs );
//
//   let result = _.git.isRepository
//   ({
//     localPath : repo.downloadPath,
//   });
//
//   _.assert( !_.consequenceIs( result ) );
//
//   // if( !result )
//   // return end( result );
//
//   return _.Consequence.From( result )
//   .finally( ( err, arg ) =>
//   {
//     end( arg );
//     if( err )
//     throw err;
//     return arg;
//   });
//
//   /* */
//
//   function end( result )
//   {
//     repo.isRepository = !!result;
//     return result;
//   }
//
// }

// //
//
// function repoIsUpToDateReform()
// {
//   let repo = this;
//   let will = repo.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( _.strDefined( repo.downloadPath ) );
//   _.assert( !!repo.willfilesPath );
//   _.assert( repo.isRemote === true );
//
//   let remoteProvider = will.vcsProviderFor( repo.remotePath );
//
//   _.assert( !!remoteProvider.isVcs );
//
//   let result = remoteProvider.isUpToDate
//   ({
//     remotePath : repo.remotePath,
//     localPath : repo.downloadPath,
//     verbosity : will.verbosity - 3,
//   });
//
//   // if( !result )
//   // return end( result );
//
//   return _.Consequence.From( result )
//   .finally( ( err, arg ) =>
//   {
//     end( arg );
//     if( err )
//     throw err;
//     return arg;
//   });
//
//   /* */
//
//   function end( result )
//   {
//     repo.isUpToDate = !!result;
//     return result;
//   }
//
// }

// //
//
// function repoHasLocalChanges()
// {
//   let repo = this;
//   let will = repo.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( !!repo.willfilesPath || !!repo.dirPath );
//   _.assert( arguments.length === 0 );
//
//   // let remoteProvider = will.vcsProviderFor( repo.remotePath );
//   // return remoteProvider.hasLocalChanges( repo.downloadPath );
//   return _.git.hasLocalChanges
//   ({
//     localPath : repo.downloadPath,
//     unpushed : 1,
//     sync : 1,
//   });
// }

// //
//
// function repoHasFilesReform()
// {
//   let repo = this;
//   let will = repo.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( _.strDefined( repo.downloadPath ) );
//   _.assert( !!repo.willfilesPath );
//   _.assert( repo.isRemote === true );
//
//   let remoteProvider = will.vcsProviderFor( repo.remotePath );
//   _.assert( !!remoteProvider.isVcs );
//
//   let result = remoteProvider.hasFiles
//   ({
//     localPath : repo.downloadPath,
//   });
//
//   _.assert( !_.consequenceIs( result ) );
//
//   if( _.boolLike( result ) )
//   return end( result );
//
//   return _.Consequence.From( result )
//   .finally( ( err, arg ) =>
//   {
//     end( arg );
//     if( err )
//     throw err;
//     return arg;
//   });
//
//   /* */
//
//   function end( result )
//   {
//     _.assert( _.boolLike( result ) );
//     result = !!result;
//     repo.hasFiles = result;
//     return result;
//   }
//
// }

//

// function _repoIsFresh( o )
// {
//   let opener = this;
//   let ready = _.Consequence().take( null );
//
//   ready
//   .then( () =>
//   {
//     if( o.mode === 'download' )
//     return hasFilesRepositoryReform();
//     else if( o.mode === 'update' )
//     return isUpdatedRepositoryReform();
//     else if( o.mode === 'agree' )
//     return isUpdatedRepositoryReform();
//   })
//   .then( function()
//   {
//     let downloading = false;
//     if( o.mode === 'download' )
//     downloading = !opener.hasFiles;
//     else if( o.mode === 'update' )
//     downloading = !opener.isUpToDate || !opener.isRepository;
//     else if( o.mode === 'agree' )
//     downloading = !opener.isUpToDate || !opener.isRepository;
//     _.assert( _.boolLike( downloading ) );
//     return !!downloading;
//   })
//   .then( ( downloading ) =>
//   {
//     if( !downloading )
//     if( o.mode === 'update' || o.mode === 'agree' )
//     {
//       let gitProvider = opener.will.will.vcsProviderFor( opener.remotePath );
//       let result = gitProvider.hasRemote
//       ({
//         localPath : opener.downloadPath,
//         remotePath : opener.remotePath
//       });
//       downloading = !result.remoteIsValid;
//     }
//
//     return !downloading;
//   })
//
//   /*  */
//
//   function isUpdatedRepositoryReform()
//   {
//     let con = new _.Consequence().take( null );
//     con.then( () => opener.repoIsGoodReform() )
//     con.then( () => opener.repoIsUpToDateReform() )
//     return con;
//   }
//
//   /* */
//
//   function hasFilesRepositoryReform()
//   {
//     let con = new _.Consequence().take( null );
//     con.then( () => opener.repoHasFilesReform() )
//     /* qqq : check */
//     // con.then( () => opener.repoIsGoodReform() )
//     return con;
//   }
//
//   return ready;
// }
//
// _repoIsFresh.defaults =
// {
//   mode : 'download',
// }

//

function repoLocalVersion()
{
  let repo = this;
  let will = repo.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  // _.assert( !!repo.willfilesPath || !!repo.dirPath );
  _.assert( arguments.length === 0 );

  debugger;
  let remoteProvider = will.vcsProviderFor( repo.downloadPath );
  debugger;
  return remoteProvider.versionLocalRetrive( repo.downloadPath );
}

//

function repoLatestVersion()
{
  let repo = this;
  let will = repo.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  // _.assert( !!repo.willfilesPath || !!repo.dirPath );
  _.assert( arguments.length === 0 );

  debugger;
  let remoteProvider = will.vcsProviderFor( repo.downloadPath );
  debugger;
  return remoteProvider.versionRemoteLatestRetrive( repo.downloadPath )
}

//

function infoExport()
{
  let repo = this;
  let will = repo.will;
  let result = '';
  let vcs = will.vcsToolsFor( repo.remotePath );

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
  o = _.routineOptions( Hash, o );
  _.assert( o.downloadPath === null || _.strIs( o.downloadPath ) );
  _.assert( o.remotePath === null || _.strIs( o.remotePath ) );
  return o.downloadPath + '-' + o.remotePath;
}

Hash.defaults =
{
  downloadPath : null,
  remotePath : null,
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
  isUpToDate : true,
  remoteIsValid : true,
  safeToDelete : false,
  downloadRequired : false,
  updateRequired : false,
  agreeRequired : false,
}

let Composes =
{

  // hasFiles : null,
  // isRepository : null,
  // remoteIsValid : null,
  // hasLocalChanges : null,
  // isUpToDate : null,
  // downloadRequired : null,
  // updateRequired : null,
  // agreeRequired : null,

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

  _ : { getter : _.accessor.getter.withSymbol, readOnly : 1, strict : 0 },

  dirExists : { getter : _statusGetter_functor( 'dirExists' ), readOnly : 1 },
  hasFiles : { getter : _statusGetter_functor( 'hasFiles' ), readOnly : 1 },
  isRepository : { getter : _statusGetter_functor( 'isRepository' ), readOnly : 1 },
  hasLocalChanges : { getter : _statusGetter_functor( 'hasLocalChanges' ), readOnly : 1 },
  remoteIsValid : { getter : _statusGetter_functor( 'remoteIsValid' ), readOnly : 1 },
  isUpToDate : { getter : _statusGetter_functor( 'isUpToDate' ), readOnly : 1 },
  safeToDelete : { getter : _statusGetter_functor( 'safeToDelete' ), readOnly : 1 },
  downloadRequired : { getter : _statusGetter_functor( 'downloadRequired' ), readOnly : 1 },
  updateRequired : { getter : _statusGetter_functor( 'updateRequired' ), readOnly : 1 },
  agreeRequired : { getter : _statusGetter_functor( 'agreeRequired' ), readOnly : 1 },

  remotePath : { readOnly : 1 },
  downloadPath : { readOnly : 1 },
  isRemote : { readOnly : 1 },

}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,

  // repo

  statusInvalidate,
  status,
  // _repoStatusPut,

  repoIsRemote,
  // repoIsGoodReform,
  // repoIsUpToDateReform,
  // repoHasLocalChanges,
  // repoHasFilesReform,
  // _repoIsFresh,

  repoLocalVersion,
  repoLatestVersion,

  infoExport,
  Hash,

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
