( function _ModuleOpener_s_( ) {

'use strict';

if( typeof opener !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.AbstractModule;
let Self = function wWillModuleOpener( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ModuleOpener';

// --
// inter
// --

function finit()
{
  let opener = this;
  let will = opener.will;

  opener.unform();

  if( will && will.mainOpener === opener )
  will.mainOpener = null;

  // will.openersErrorsRemoveOf( opener );

  return Parent.prototype.finit.apply( opener, arguments );
}

//

function init( o )
{
  let opener = this;

  opener[ dirPathSymbol ] = null;

  if( o )
  opener.precopy( o );

  Parent.prototype.init.apply( opener, arguments );

  if( o )
  opener.copy( o );

  _.assert( !!o );
  _.assert( opener.unwrappedModuleOpener !== undefined );
  _.assert( opener.openedModule !== undefined );

  return opener;
}

//

function unform()
{
  let opener = this;
  let will = opener.will;

  if( !opener.formed )
  return opener;

  _.assert( opener.supermodule === null );

  if( opener.openedModule )
  {
    let openedModule = opener.openedModule;
    opener.openedModule = null;
    openedModule.finitMaybe();
  }

  opener._willfilesRelease();
  will.openerUnregister( opener );

  opener.formed = 0;
  return opener;
}

//

function preform()
{
  let opener = this;
  let will = opener.will;

  if( opener.formed )
  return opener;

  /* */

  _.assert( arguments.length === 0 );
  _.assert( !!opener.will );
  _.assert( _.strsAreAll( opener.willfilesPath ) || _.strIs( opener.dirPath ), 'Expects willfilesPath or dirPath' );
  _.assert( opener.formed === 0 );

  /* */

  opener._filePathChanged();
  will.openerRegister( opener );
  will._willfilesReadBegin();

  /* */

  _.assert( arguments.length === 0 );
  _.assert( !!opener.will );
  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );
  _.assert( opener.dirPath === null || _.strDefined( opener.dirPath ) );
  _.assert( !!opener.willfilesPath || !!opener.dirPath );

  /* */

  opener.formed = 1;
  return opener;
}

//

function optionsForModuleExport()
{
  let opener = this;

  let Import =
  {

    will : null,
    rootModule : null,
    peerModule : null,
    // mainOpener : null,
    willfilesArray : null,

    willfilesPath : null,
    localPath : null,
    remotePath : null,
    // inPath : null,
    // outPath : null,

    isRemote : null,
    isDownloaded : null,
    isUpToDate : null,
    isOut : null,

  }

  let result = _.mapOnly( opener, Import );

  if( opener.supermodule )
  result.supermodules = [ opener.supermodule ];

  result.willfilesArray = _.entityShallowClone( result.willfilesArray );

  _.assert( _.boolLike( opener.isOut ), 'Expects defined {- opener.isOut -}' );

  return result;
}

// //
//
// function optionsForSecondModule()
// {
//   let opener = this;
//
//   let Import =
//   {
//     will : null,
//     rootModule : null,
//     // willfilesReadBeginTime : null,
//   }
//
//   let result = _.mapOnly( opener, Import );
//
//   // if( opener.supermodule )
//   // result.supermodules = [ opener.supermodule ];
//
//   return result;
// }

//

function precopy( o )
{
  let opener = this;
  if( o.will )
  opener.will = o.will;
  if( o.supermodules )
  opener.supermodules = o.supermodules;
  if( o.original )
  opener.original = o.original;
  if( o.rootModule )
  opener.rootModule = o.rootModule;
  return o;
}

//

function copy( o )
{
  let opener = this;
  opener.precopy( o );
  let result = _.Copyable.prototype.copy.apply( opener, arguments );
  return result;
}

//

function clone()
{
  let opener = this;

  _.assert( arguments.length === 0 );

  let result = opener.cloneExtending({});

  return result;
}

//

function cloneExtending( o )
{
  let opener = this;

  _.assert( arguments.length === 1 );

  if( o.original === undefined )
  o.original = opener.original;
  if( opener.isMain && o.isMain === undefined )
  o.isMain = false;
  if( o.willfilesArray === undefined )
  o.willfilesArray = [];
  // if( o.moduleWithCommonPathMap === undefined )
  // o.moduleWithCommonPathMap = opener.moduleWithCommonPathMap;

  let result = _.Copyable.prototype.cloneExtending.call( opener, o );

  return result;
}

// --
// module
// --

// function moduleClone( module )
// {
//   let opener = this;
//   let will = opener.will;
//
//   _.assert( !module.finitedIs() );
//   _.assert( arguments.length === 1 );
//   _.assert( module instanceof _.Will.OpenedModule );
//
//   opener.preform();
//   opener.remoteForm();
//
//   let o2 = opener.optionsForModuleExport();
//   let rootModule = o2.rootModule = opener.rootModule;
//   let module2 = module.cloneExtending( o2 );
//   opener.moduleAdopt( module2 );
//   _.assert( rootModule === opener.rootModule );
//   _.assert( rootModule === opener.openedModule.rootModule );
//
//   return module2;
// }

//

function moduleAdopt( module )
{
  let opener = this;
  let will = opener.will;

  _.assert( !module.finitedIs() );
  _.assert( opener.openedModule === null );
  _.assert( arguments.length === 1 );
  _.assert( module instanceof _.Will.OpenedModule );

  let o2 = module.optionsForOpenerExport();
  _.mapExtend( opener, o2 );

  opener.preform();
  opener.remoteForm();

  opener.openedModule = module;

  if( opener.supermodule )
  opener.supermodule._moduleAdoptEnd();

  _.assert( opener.openedModule === module );
  _.assert( _.arrayHas( module.userArray, opener ) );

  return module;
}

//

function openedModuleSet( module )
{
  let opener = this;

  _.assert( arguments.length === 1 );
  _.assert( module === null || module instanceof _.Will.OpenedModule )

  if( opener.openedModule === module )
  return module ;

  if( opener.openedModule )
  opener.openedModule.releasedBy( opener );

  if( module )
  {
    module.usedBy( opener );
    opener.moduleUsePaths( module );
    opener.moduleUseError( module );
  }

  opener[ openedModuleSymbol ] = module;

  return module;
}

//

function moduleUsePaths( module )
{
  let opener = this;

  _.assert( arguments.length === 1 );
  _.assert( module instanceof _.Will.OpenedModule );

  opener[ dirPathSymbol ] = module.dirPath;
  opener[ commonPathSymbol ] = module.commonPath;

  opener.willfilesPath = module.willfilesPath;
  // opener.dirPath = module.dirPath;
  // opener.commonPath = module.commonPath;
  opener.localPath = module.localPath;
  opener.remotePath = module.remotePath;

}

//

function moduleUseError( module )
{
  let opener = this;

  _.assert( arguments.length === 1 );
  _.assert( module instanceof _.Will.OpenedModule );

  if( module.ready.errorsCount() )
  opener.error = opener.error || module.ready.errorsGet()[ 0 ];

}

// --
// opener
// --

function close()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  if( opener.openedModule )
  opener.openedModule.close();

  if( opener.error )
  opener.error = null

  opener._willfilesRelease();

  if( opener.supermodule )
  opener.supermodule._closeEnd();

}

//

function find( o )
{
  let opener = this;
  let will = opener.will;

  o = _.routineOptions( find, arguments );
  _.assert( _.arrayHas( [ 'smart', 'strict', 'exact' ], opener.searching ) );
  _.assert( opener.formed <= 2 );

  if( opener.openedModule )
  return opener.openedModule;

  try
  {

    opener.preform();
    opener.remoteForm();

    _.assert( opener.formed >= 2 );

    let openedModule = opener.openedModule;
    if( !openedModule )
    openedModule = will.moduleAt( opener.willfilesPath );

    /* */

    // if( _.arrayHas( [ 'smart', 'strict' ], opener.searching ) )
    if( !openedModule || !openedModule.willfilesArray.length )
    {

      opener._willfilesFind();

      if( !opener.error )
      if( !opener.willfilesArray.length )
      {
        debugger;
        opener.error = _.err( 'Found no will file at ' + _.strQuote( opener.dirPath ) );
      }

      /* get module from opened willfile, maybe */

      if( opener.willfilesArray.length )
      if( opener.willfilesArray[ 0 ].openedModule )
      openedModule = opener.willfilesArray[ 0 ].openedModule;

    }

    // if( openedModule && opener.isMain )
    // openedModule.mainOpener = opener;

    /* */

    if( opener.error )
    {
      throw opener.error;
    }

    /* */

    if( openedModule )
    {

      _.assert( openedModule.rootModule === opener.rootModule || opener.rootModule === null );
      _.assert( opener.openedModule === openedModule || opener.openedModule === null );
      opener.openedModule = openedModule;

      _.assert( !opener.willfilesArray.length || !openedModule.willfilesArray.length || _.arraysAreIdentical( opener.willfilesArray, openedModule.willfilesArray ) );
      if( opener.willfilesArray.length )
      openedModule.willfilesArray = _.entityShallowClone( opener.willfilesArray );
      else
      opener.willfilesArray = _.entityShallowClone( openedModule.willfilesArray );

    }
    else
    {

      _.assert( opener.openedModule === null );
      let o2 = opener.optionsForModuleExport();
      // debugger;
      openedModule = opener.openedModule = new will.OpenedModule( o2 );
      // debugger;
      if( openedModule.rootModule === null )
      openedModule.rootModule = openedModule;
      openedModule.preform();

      // opener.modulesAttachedOpen();

    }

    _.assert( _.arraysAreIdentical( opener.willfilesArray, opener.openedModule.willfilesArray ) );
    _.assert( _.arraysAreIdentical( _.mapVals( opener.willfileWithRoleMap ), _.mapVals( opener.openedModule.willfileWithRoleMap ) ) );

    if( !opener.openedModule.isUsedBy( opener ) )
    opener.openedModule.usedBy( opener );

    opener.formed = 3;

    return opener.openedModule;
  }
  catch( err )
  {
    err = _.err( err, `\nError looking for willfiles for module at ${opener.commonPath}` );
    opener.error = opener.error || err;
    if( o.throwing )
    throw err;
    return null;
  }

}

find.defaults =
{
  throwing : 1,
}

//

function open( o )
{
  let opener = this;
  let will = opener.will;
  let ready = new _.Consequence();

  o = _.routineOptions( open, arguments );

  try
  {

    _.assert( opener.formed <= 3 );

    if( opener.error )
    throw opener.error;

    if( !opener.openedModule )
    opener.find();

    defaultsApply( o );

    _.assert( opener.formed === 3 );

    if( opener.error )
    throw opener.error;

    let stager = opener.openedModule.stager;
    let rerun = false;

    let skipping = Object.create( null );
    skipping.attachedWillfilesFormed = !o.formingAttachedWillfiles;
    skipping.peerModulesFormed = !o.formingPeerModules;
    skipping.subModulesFormed = !o.formingSubModules;
    skipping.resourcesFormed = !o.formingResources;

    let processing = stager.stageStateBegun( 'opened' ) || ( stager.stageStateEnded( 'opened' ) && !stager.stageStateEnded( 'formed' ) );

    for( let s in skipping )
    if( stager.stageStatePerformed( s ) )
    skipping[ s ] = false;
    else
    rerun = rerun || !skipping[ s ];

    if( !stager.stageStateEnded( 'opened' ) || rerun )
    {

      stager.stageStatePausing( 'picked', 0 );

      for( let s in skipping )
      {
        stager.stageStateSkipping( s, skipping[ s ] );
        if( !processing )
        if( !skipping[ s ] )
        if( stager.stageStateEnded( s ) && !stager.stageStatePerformed( s ) )
        stager.stageReset( s );
      }

      stager.tick();

    }

    if( processing )
    {
      if( opener.formed === 3 )
      opener.formed = 4;
      ready.take( opener.openedModule );
    }
    else
    opener.openedModule.ready.finally( ( err, arg ) =>
    {
      if( err )
      {
        handleError( err );
        throw err;
      }
      if( opener.formed === 3 )
      opener.formed = 4;
      ready.take( opener.openedModule );
      return arg;
    });

  }
  catch( err )
  {
    handleError( err );
    return ready;
  }

  return ready;

  /* */

  function handleError( err )
  {

    if( !err || !_.strIs( err.originalMessage ) || !_.strHas( err.originalMessage, 'Failed to open module at' ) )
    {
      err = _.err( err, `\nFailed to open module at ${opener.commonPath}` );
    }
    opener.error = opener.error || err;

    if( !o.throwing )
    _.errAttend( err );

    if( o.throwing )
    ready.error( err );
    else
    ready.take( null );

  }

  /* */

  function defaultsApply( o )
  {

    will.instanceDefaultsApply( o );

    let isMain = opener.isMain;

    if( !isMain && opener.openedModule && will.mainOpener && will.mainOpener.openedModule === opener.openedModule )
    isMain = true;

    if( _.boolLike( o.forming ) )
    {
      o.forming = !!o.forming;
      if( o.formingAttachedWillfiles === null )
      o.formingAttachedWillfiles = o.forming;
      if( o.formingPeerModules === null )
      o.formingPeerModules = o.forming;
      if( o.formingSubModules === null )
      o.formingSubModules = o.forming;
      if( o.formingResources === null )
      o.formingResources = o.forming;
    }

    if( o.formingAttachedWillfiles === null )
    o.formingAttachedWillfiles = isMain ? will.formingAttachedWillfilesOfMain : will.formingAttachedWillfilesOfSub;
    if( o.formingPeerModules === null )
    o.formingPeerModules = isMain ? will.formingPeerModulesOfMain : will.formingPeerModulesOfSub;
    if( o.formingSubModules === null )
    o.formingSubModules = isMain ? will.formingSubModulesOfMain : will.formingSubModulesOfSub;
    if( o.formingResources === null )
    o.formingResources = isMain ? will.formingResourcesOfMain : will.formingResourcesOfSub;

    o.formingAttachedWillfiles = !!o.formingAttachedWillfiles;
    o.formingPeerModules = !!o.formingPeerModules;
    o.formingSubModules = !!o.formingSubModules;
    o.formingResources = !!o.formingResources;

    return o;
  }

}

open.defaults =
{

  throwing : 1,
  formingAttachedWillfiles : null,
  formingPeerModules : null,
  formingSubModules : null,
  formingResources : null,
  forming : null,

}

//

function isOpened()
{
  let opener = this;
  return !!opener.openedModule && opener.openedModule.stager.stageStatePerformed( 'formed' );
}

//

function isValid()
{
  let opener = this;
  if( opener.error )
  return false;
  if( opener.openedModule )
  return opener.openedModule.stager.isValid();
  return true;
}

//

function isUsed()
{
  let opener = this;

  if( opener.openedModule )
  return true;
  if( opener.supermodule )
  return true;

  return false;
}

// --
// willfiles
// --

function willfileUnregister( willf )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  // _.arrayRemoveElementOnceStrictly( opener.willfilesArray, willf );
  _.arrayRemoveElementOnceStrictly( willf.openers, opener );

  // if( willf.role )
  // {
  //   _.assert( opener.willfileWithRoleMap[ willf.role ] === willf )
  //   delete opener.willfileWithRoleMap[ willf.role ];
  // }

  Parent.prototype.willfileUnregister.apply( opener, arguments );
}

//

function willfileRegister( willf )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );

  if( _.arrayIs( willf ) )
  {
    debugger;
    willf.forEach( ( willf ) => opener.willfileRegister( willf ) );
    return;
  }

  _.arrayAppendOnce( willf.openers, opener );

  Parent.prototype.willfileRegister.apply( opener, arguments );
}

//

function _willfilesFindSmart( o )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let filePaths;
  let records;

  o = _.routineOptions( _willfilesFindSmart, arguments );
  o.willfilesPath = o.willfilesPath || opener.willfilesPath;

  _.assert( opener.willfilesArray.length === 0, 'not tested' );

  if( opener.searching = 'smart' )
  o.willfilesPath = _.Will.AbstractModule.CommonPathFor( o.willfilesPath );

  if( opener.searching === 'exact' )
  {
    debugger;
    records = fileProvider.record({ filePath : o.willfilesPath });
    records = _.arrayAs( records );
    debugger;
  }
  else
  {
    records = will.willfilesList
    ({
      dirPath : o.willfilesPath,
      includingInFiles : o.includingInFiles,
      includingOutFiles : o.includingOutFiles,
    });
  }

  for( let r = 0 ; r < records.length ; r++ )
  {
    let record = records[ r ];

    let willfOptions =
    {
      filePath : record.absolute,
      // dirPath : opener.dirPath,
    }
    let got = will.willfileFor({ willf : willfOptions, combining : 'supplement' });
    opener.willfileRegister( got.willf );

  }

}

_willfilesFindSmart.defaults =
{
  willfilesPath : null,
  includingInFiles : 1,
  includingOutFiles : 1,
}

//

// function _willfilesFindPicked()
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//   let result = [];
//
//   _.assert( arguments.length === 0 );
//   _.assert( !!opener.willfilesPath );
//   _.assert( 0, 'deprecated' );
//
//   let willfilesPath = _.arrayAs( opener.willfilesPath );
//   _.assert( _.strsAreAll( willfilesPath ) );
//
//   willfilesPath.forEach( ( filePath ) =>
//   {
//
//     let willfOptions =
//     {
//       filePath : filePath,
//       willfilesPath : opener.dirPath,
//       role : 'single',
//     }
//     let r = will.willfileFor({ willf : willfOptions });
//
//     opener.willfileRegister( r.willfile );
//
//     if( willfile.exists() )
//     result.push( willfile );
//     else
//     willfile.finit();
//
//   });
//
//   if( result.length )
//   {
//     let willfilesPath = _.select( result, '*/filePath' );
//     opener._filePathChange( willfilesPath );
//   }
//
//   return result;
// }

//

function _willfilesFind()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = [];

  _.assert( arguments.length === 0 );

  /* */

  try
  {

    // debugger;
    // if( opener.submoduleAssociation && opener.submoduleAssociation.autoExporting ) // xxx
    // {
    //   result = opener.exportAuto();
    // }
    // else
    // if( opener.pickedWillfilesPath )

    // if( opener.searching === 'picked' )
    // {
    //   result = opener._willfilesFindPicked(); /* xxx : remove maybe the routine? */
    // }
    // else
    // {
    //   // result = opener._willfilesFindSmart({ isOut : !!opener.supermodule });
      result = opener._willfilesFindSmart();
    // }

    _.assert( !_.consequenceIs( result ) );

    if( opener.willfilesArray.length )
    _.assert( !!opener.willfilesPath && !!opener.dirPath );

  }
  catch( err )
  {
    err = _.err( err, '\nError looking for will files for', opener.qualifiedName, 'at', _.strQuote( opener.commonPath ) );
    opener.error = opener.error || err;
  }

  if( !opener.error )
  if( opener.willfilesArray.length === 0 )
  {
    let err;
    if( opener.supermodule )
    err = _.errBrief( 'Found no .out.will file for',  opener.supermodule.qualifiedName, 'at', _.strQuote( opener.commonPath ) );
    else
    err = _.errBrief( 'Found no willfile at', _.strQuote( opener.commonPath ) );
    opener.error = opener.error || err;
    // debugger;
  }

}

// --
// submodule
// --

function sharedFieldGet_functor( fieldName )
{
  let symbol = Symbol.for( fieldName );

  return function sharedFieldGet()
  {
    let opener = this;
    let openedModule = opener.openedModule;
    let will = opener.will;

    if( openedModule )
    return openedModule[ fieldName ];

    let result = opener[ symbol ];

    return result;
  }

}

//

function sharedModuleSet_functor( fieldName )
{
  let symbol = Symbol.for( fieldName );

  return function sharedModuleSet( src )
  {
    let opener = this;
    let openedModule = opener.openedModule;

    _.assert( src === null || src instanceof _.Will.OpenedModule );

    opener[ symbol ] = src;

    if( openedModule )
    openedModule[ fieldName ] = src;

    return src;
  }

}

let peerModuleGet = sharedFieldGet_functor( 'peerModule' );
let peerModuleSet = sharedModuleSet_functor( 'peerModule' );

let rootModuleGet = sharedFieldGet_functor( 'rootModule' );
let rootModuleSet = sharedModuleSet_functor( 'rootModule' );

//

function supermoduleGet()
{
  let opener = this;
  _.assert( opener[ supermoduleSymbol ] === null || opener[ supermoduleSymbol ] instanceof _.Will.Submodule );
  return opener[ supermoduleSymbol ];
}

//

function supermoduleSet( src )
{
  let opener = this;
  // _.assert( src === null || src instanceof _.Will.OpenedModule );
  _.assert( src === null || src instanceof _.Will.Submodule );

  _.assert( src === null || src.opener === null || src.opener === opener )

  opener[ supermoduleSymbol ] = src;
  return src;
}

// //
//
// function rootModuleGet()
// {
//   let opener = this;
//   if( opener.openedModule )
//   return opener.openedModule.rootModule;
//   return opener[ rootModuleSymbol ];
// }
//
// //
//
// function rootModuleSet( src )
// {
//   let opener = this;
//   _.assert( src === null || src instanceof _.Will.OpenedModule );
//   opener[ rootModuleSymbol ] = src;
//   return src;
// }

//

function submodulesAllAreDownloaded()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !opener.supermodule );

  for( let n in opener.submoduleMap )
  {
    let submodule = opener.submoduleMap[ n ].opener;
    if( !submodule )
    return false;
    if( !submodule.isDownloaded )
    return false;
  }

  return true;
}

//

function submodulesAllAreValid()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !opener.supermodule );

  for( let n in opener.submoduleMap )
  {
    let submodule = opener.submoduleMap[ n ].opener;
    if( !submodule )
    continue;
    if( !submodule.isValid() )
    return false;
  }

  return true;
}

// --
// remote
// --

// function remoteIsUpdate()
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( !!opener.willfilesPath || !!opener.dirPath );
//   _.assert( arguments.length === 0 );
//
//   // if( opener.aliasName === null ) // xxx
//   // return end( false );
//
//   let remoteProvider = fileProvider.providerForPath( opener.remotePath || opener.commonPath );
//   if( remoteProvider.isVcs )
//   return end( true );
//
//   return end( false );
//
//   /* */
//
//   function end( result )
//   {
//     opener.isRemote = result;
//     return result;
//   }
//
// }
//
// //
//
// function remoteIsUpToDateUpdate()
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( _.strDefined( opener.localPath ) );
//   _.assert( !!opener.willfilesPath );
//   _.assert( opener.isRemote === true );
//
//   let remoteProvider = fileProvider.providerForPath( opener.remotePath );
//
//   _.assert( !!remoteProvider.isVcs );
//
//   debugger;
//   let result = remoteProvider.isUpToDate
//   ({
//     remotePath : opener.remotePath,
//     localPath : opener.localPath,
//     verbosity : will.verbosity - 3,
//   });
//
//   if( !result )
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
//     opener.isUpToDate = !!result;
//     return result;
//   }
//
// }

// //
//
// function remoteIsDownloadedUpdate()
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( _.strDefined( opener.localPath ) );
//   _.assert( !!opener.willfilesPath );
//   _.assert( opener.isRemote === true );
//
//   let remoteProvider = fileProvider.providerForPath( opener.remotePath );
//   _.assert( !!remoteProvider.isVcs );
//
//   let result = remoteProvider.isDownloaded
//   ({
//     localPath : opener.localPath,
//   });
//
//   _.assert( !_.consequenceIs( result ) );
//
//   if( !result )
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
//     opener.isDownloaded = !!result;
//     return result;
//   }
//
// }
//
// //
//
// function remoteIsDownloadedChanged()
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( !!opener.pathResourceMap[ 'current.remote' ] );
//
//   /* */
//
//   if( opener.isDownloaded &&  opener.remotePath )
//   {
//
//     let remoteProvider = fileProvider.providerForPath( opener.remotePath );
//     _.assert( !!remoteProvider.isVcs );
//
//     let version = remoteProvider.versionLocalRetrive( opener.localPath );
//     if( version )
//     {
//       let remotePath = _.uri.parseConsecutive( opener.remotePath );
//       remotePath.hash = version;
//       opener.pathResourceMap[ 'current.remote' ].path = _.uri.str( remotePath );
//     }
//   }
//   else
//   {
//     opener.pathResourceMap[ 'current.remote' ].path = null;
//   }
//
// }
//
// //
//
// function remoteIsDownloadedSet( src )
// {
//   let opener = this;
//
//   src = !!src;
//
//   let changed = opener[ isDownloadedSymbol ] !== undefined && opener[ isDownloadedSymbol ] !== src;
//
//   opener[ isDownloadedSymbol ] = src;
//
//   if( changed )
//   opener.remoteIsDownloadedChanged();
//
// }

//

function remoteForm()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  opener.remoteIsUpdate();

  if( opener.isRemote )
  {
    opener._remoteFormAct();
  }
  else
  {
    opener.localPath = path.detrail( path.common( opener.willfilesPath ) );
    opener.isDownloaded = null;
  }

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );

  opener.formed = 2;
  return opener;
}

//

function _remoteFormAct()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let willfilesPath = opener.remotePath || opener.willfilesPath;

  _.assert( _.strDefined( opener.aliasName ) );
  _.assert( !!opener.supermodule );
  _.assert( _.strIs( willfilesPath ) );

  let remoteProvider = fileProvider.providerForPath( opener.remotePath || opener.commonPath );

  _.assert( remoteProvider.isVcs && _.routineIs( remoteProvider.pathParse ), () => 'Seems file provider ' + remoteProvider.qualifiedName + ' does not have version control system features' );

  let submodulesDir = opener.supermodule.cloneDirPathGet();
  let parsed = remoteProvider.pathParse( willfilesPath );

  opener.remotePath = willfilesPath;
  opener.localPath = path.resolve( submodulesDir, opener.aliasName );

  let willfilesPath2 = path.resolve( opener.localPath, parsed.localVcsPath );
  opener._filePathChange( willfilesPath2 );
  opener.remoteIsDownloadedUpdate();

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );

  return opener;
}

//

function _remoteDownload( o )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let time = _.timeNow();
  let downloading = false;
  let con = _.Consequence().take( null );

  _.routineOptions( _remoteDownload, o );
  _.assert( arguments.length === 1 );
  _.assert( opener.formed >= 2 );
  _.assert( !!opener.willfilesPath );
  _.assert( _.strDefined( opener.aliasName ) );
  _.assert( _.strDefined( opener.remotePath ) );
  _.assert( _.strDefined( opener.localPath ) );
  _.assert( !!opener.supermodule );

  return con
  .then( () =>
  {
    if( o.updating )
    return opener.remoteIsUpToDateUpdate();
    else
    return opener.remoteIsDownloadedUpdate();
  })
  .then( function( arg )
  {

    if( o.updating )
    downloading = !opener.isUpToDate;
    else
    downloading = !opener.isDownloaded;

    /*
    delete old remote opener if it has a critical error or downloaded files are corrupted
    */

    if( !o.dry )
    if( !opener.isValid() || !opener.isDownloaded )
    {
      fileProvider.filesDelete({ filePath : opener.localPath, throwing : 0, sync : 1 });
    }

    return arg;
  })
  .then( () =>
  {

    let o2 =
    {
      reflectMap : { [ opener.remotePath ] : opener.localPath },
      verbosity : will.verbosity - 5,
      extra : { fetching : 0 },
    }

    if( downloading && !o.dry )
    return will.Predefined.filesReflect.call( fileProvider, o2 );

    return null;
  })
  .then( function( arg )
  {
    opener.isDownloaded = true;
    if( downloading && !o.dry )
    opener.isUpToDate = true;
    if( o.opening && !o.dry && downloading )
    {

      debugger;
      let willf = opener.willfilesArray[ 0 ];
      opener.close();
      _.assert( !_.arrayHas( will.willfilesArray, willf ) );
      opener.find();

      // opener.openedModule.stager.stageStatePausing( 'picked', 0 );
      // opener.openedModule.stager.stageStateSkipping( 'peerModulesFormed', 1 );
      // opener.openedModule.stager.stageStateSkipping( 'subModulesFormed', 1 );
      // opener.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
      // opener.openedModule.stager.tick();

      // return opener.openedModule.ready
      // .finallyGive( function( err, arg )
      // {
      //   this.take( err, arg );
      // })
      // .split();

      return opener.open();
    }
    return null;
  })
  .finally( function( err, arg )
  {
    if( err )
    throw _.err( err, '\nFailed to', ( o.updating ? 'update' : 'download' ), opener.decoratedAbsoluteName );
    if( will.verbosity >= 3 && downloading )
    {
      if( o.dry )
      {
        let remoteProvider = fileProvider.providerForPath( opener.remotePath );
        let version = remoteProvider.versionRemoteCurrentRetrive( opener.remotePath );
        logger.log( ' + ' + opener.decoratedQualifiedName + ' will be ' + ( o.updating ? 'updated to' : 'downloaded' ) + ' version ' + _.color.strFormat( version, 'path' ) );
      }
      else
      {
        let remoteProvider = fileProvider.providerForPath( opener.remotePath );
        let version = remoteProvider.versionLocalRetrive( opener.localPath );
        logger.log( ' + ' + opener.decoratedQualifiedName + ' was ' + ( o.updating ? 'updated to' : 'downloaded' ) + ' version ' + _.color.strFormat( version, 'path' ) + ' in ' + _.timeSpent( time ) );
      }
    }
    return downloading;
  });

}

_remoteDownload.defaults =
{
  updating : 0,
  dry : 0,
  opening : 1,
  recursive : 0,
}

//

function remoteDownload()
{
  let opener = this;
  let will = opener.will;
  return opener._remoteDownload({ updating : 0 });
}

//

function remoteUpgrade()
{
  let opener = this;
  let will = opener.will;
  return opener._remoteDownload({ updating : 1 });
}

//

function remoteCurrentVersion()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!opener.willfilesPath || !!opener.dirPath );
  _.assert( arguments.length === 0 );

  debugger;
  let remoteProvider = fileProvider.providerForPath( opener.commonPath );
  debugger;
  return remoteProvider.versionLocalRetrive( opener.localPath );
}

//

function remoteLatestVersion()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!opener.willfilesPath || !!opener.dirPath );
  _.assert( arguments.length === 0 );

  debugger;
  let remoteProvider = fileProvider.providerForPath( opener.commonPath );
  debugger;
  return remoteProvider.versionRemoteLatestRetrive( opener.localPath )
}

// --
// path
// --

function _filePathChange( willfilesPath )
{

  if( !this.will )
  return willfilesPath;

  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  let r = Parent.prototype._filePathChange.call( opener, willfilesPath );

  opener[ dirPathSymbol ] = r.dirPath;

  if( r.commonPath )
  {
    opener[ commonPathSymbol ] = r.commonPath;
  }

  if( opener.openedModule )
  opener.openedModule._filePathChange( r.willfilesPath );

  return r.willfilesPath;
}

//

function sharedPathSet_functor( fieldName )
{
  let symbol = Symbol.for( fieldName );

  return function sharedPathSet( filePath )
  {
    let opener = this;
    let openedModule = opener.openedModule;

    filePath = _.entityShallowClone( filePath );
    opener[ symbol ] = filePath;

    opener._filePathChanged();

    if( openedModule )
    openedModule[ fieldName ] = filePath;

  }

}

//

let willfilesPathGet = sharedFieldGet_functor( 'willfilesPath' );
let dirPathGet = sharedFieldGet_functor( 'dirPath' );
let commonPathGet = sharedFieldGet_functor( 'commonPath' );
// let inPathGet = sharedFieldGet_functor( 'inPath' );
// let outPathGet = sharedFieldGet_functor( 'outPath' );
let localPathGet = sharedFieldGet_functor( 'localPath' );
let remotePathGet = sharedFieldGet_functor( 'remotePath' );
// let willPathGet = sharedFieldGet_functor( 'willPath' );

let willfilesPathSet = sharedPathSet_functor( 'willfilesPath' );
// let inPathSet = sharedPathSet_functor( 'inPath' );
// let outPathSet = sharedPathSet_functor( 'outPath' );
let localPathSet = sharedPathSet_functor( 'localPath' );
let remotePathSet = sharedPathSet_functor( 'remotePath' );

// --
// name
// --

function nameGet()
{
  let opener = this;
  let name = null;

  if( !name && opener.aliasName )
  return opener.aliasName;

  if( !name && opener.openedModule && opener.openedModule.about && opener.openedModule.about.name )
  return opener.openedModule.about.name;

  if( !name && opener.fileName )
  return opener.fileName;

  if( !name && opener.openedModule )
  return opener.openedModule.name;

  if( !name && opener.commonPath )
  return _.uri.fullName( opener.commonPath );

  return null;
}

//

function _nameChanged()
{
  let opener = this;
  let will = opener.will;
  let openedModule = opener.openedModule;

  if( openedModule )
  openedModule._nameChanged();

}

//

function aliasNameSet( src )
{
  let opener = this;
  opener[ aliasNameSymbol ] = src;
  opener._nameChanged();
}

//

function absoluteNameGet()
{
  let opener = this;
  let supermodule = opener.supermodule;
  if( supermodule )
  return supermodule.qualifiedName + ' / ' + opener.qualifiedName;
  else
  return opener.qualifiedName;
}

//

function shortNameArrayGet()
{
  let opener = this;
  let supermodule = opener.openedModule.supermodule;
  if( !supermodule )
  return [ opener.name ];
  let result = supermodule.shortNameArrayGet();
  result.push( opener.name );
  return result;
}

// --
// other accessor
// --

function errorSet( err )
{
  let opener = this;
  let will = opener.will;

  if( opener.error === err )
  return;

  opener[ errorSymbol ] = err;

  // if( will && err )
  // debugger;
  if( will && err )
  will.openersErrorsArray.push({ err : err, opener : opener });

  return err;
}

//

function isMainGet()
{
  let opener = this;
  let will = opener.will;
  return will.mainOpener === opener;
}

//

function isMainSet( src )
{
  let opener = this;
  let will = opener.will;

  if( !will )
  return src;

  _.assert( src === null || _.boolLike( src ) );
  _.assert( will.mainOpener === null || will.mainOpener === opener || !src );

  if( src )
  will.mainOpener = opener;
  else if( will.mainOpener === opener )
  will.mainOpener = null;

  return src;
  // return opener.mainOpener === opener;
}

//

function accessorGet_functor( fieldName )
{
  let symbol = Symbol.for( fieldName );

  return function accessorGet()
  {
    let opener = this;
    let openedModule = opener.openedModule;

    if( openedModule )
    return openedModule[ fieldName ];

    let result = opener[ symbol ];

    return result;
  }

}

//

function accessorSet_functor( fieldName )
{
  let symbol = Symbol.for( fieldName );

  return function accessorSet( filePath )
  {
    let opener = this;
    let openedModule = opener.openedModule;

    opener[ symbol ] = filePath;
    if( openedModule )
    openedModule[ fieldName ] = filePath;

    return filePath;
  }

}

let isRemoteGet = accessorGet_functor( 'isRemote' );
let isDownloadedGet = accessorGet_functor( 'isDownloaded' );
let isUpToDateGet = accessorGet_functor( 'isUpToDate' );
let isOutGet = accessorGet_functor( 'isOut' );

let isRemoteSet = accessorSet_functor( 'isRemote' );
let isDownloadedSet = accessorSet_functor( 'isDownloaded' );
let isUpToDateSet = accessorSet_functor( 'isUpToDate' );
let isOutSet = accessorSet_functor( 'isOut' );

// --
// relations
// --

// let outPathSymbol = Symbol.for( 'outPath' );
// let inPathSymbol = Symbol.for( 'inPath' );
let dirPathSymbol = Symbol.for( 'dirPath' );
let commonPathSymbol = Symbol.for( 'commonPath' );
let aliasNameSymbol = Symbol.for( 'aliasName' );
let supermoduleSymbol = Symbol.for( 'supermodule' );
let rootModuleSymbol = Symbol.for( 'rootModule' );
let openedModuleSymbol = Symbol.for( 'openedModule' );
let errorSymbol = Symbol.for( 'error' );

let Composes =
{

  aliasName : null,

  willfilesPath : null,
  // inPath : null,
  // outPath : null,
  localPath : null,
  remotePath : null,

  isRemote : null,
  isDownloaded : null,
  isUpToDate : null,
  isOut : null,
  isMain : null,

  searching : 'strict', // 'smart', 'strict', 'exact'
  // searching : 'smart',

}

let Aggregates =
{
}

let Associates =
{

  original : null,
  will : null,

  rootModule : null,
  supermodule : null,
  // supermoduleSubmodule : null,

  willfilesArray : _.define.own([]),

}

let Medials =
{
  moduleWithCommonPathMap : null,
}

let Restricts =
{

  id : null,
  // preformed : 0,
  formed : 0,
  found : 0,
  error : null,

  openedModule : null,
  unwrappedModuleOpener : null,

}

let Statics =
{
}

let Forbids =
{
  moduleWithCommonPathMap : 'moduleWithCommonPathMap',
  allSubmodulesMap : 'allSubmodulesMap',
  moduleWithNameMap : 'moduleWithNameMap',
  willfilesReadTimeReported : 'willfilesReadTimeReported',
  submoduleAssociation : 'submoduleAssociation',
  currentRemotePath : 'currentRemotePath',
  opened : 'opened',
  pickedWillfileData : 'pickedWillfileData',
  pickedWillfilesPath : 'pickedWillfilesPath',
  willfilesReadBeginTime : 'willfilesReadBeginTime',
  willfilesReadTimeReported : 'willfilesReadTimeReported',
  finding : 'finding',
  inPath : 'inPath',
  outPath : 'outPath',
  // localPath : 'localPath',
  // remotePath : 'remotePath',
  willPath : 'willPath',
  preformed : 'preformed',
}

let Accessors =
{

  willfilesPath : { getter : willfilesPathGet, setter : willfilesPathSet },
  dirPath : { getter : dirPathGet, readOnly : 1 },
  commonPath : { getter : commonPathGet, readOnly : 1 },
  // inPath : { getter : inPathGet, setter : inPathSet },
  // outPath : { getter : outPathGet, setter : outPathSet },
  localPath : { getter : localPathGet, setter : localPathSet },
  remotePath : { getter : remotePathGet, setter : remotePathSet },
  // willPath : { getter : willPathGet, readOnly : 1 },

  name : { getter : nameGet, readOnly : 1 },
  aliasName : { setter : aliasNameSet },
  // configName : { readOnly : 1 },
  absoluteName : { getter : absoluteNameGet, readOnly : 1 },

  isRemote : { getter : isRemoteGet, setter : isRemoteSet },
  isDownloaded : { getter : isDownloadedGet, setter : isDownloadedSet },
  isUpToDate : { getter : isUpToDateGet, setter : isUpToDateSet },
  isOut : { getter : isOutGet, setter : isOutSet },
  isMain : { getter : isMainGet, setter : isMainSet },

  supermodule : {},
  rootModule : {},
  openedModule : {},
  peerModule : {},

  error : { setter : errorSet },

}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,
  unform,
  preform,

  optionsForModuleExport,
  // optionsForSecondModule,
  precopy,
  copy,
  clone,
  cloneExtending,

  // [ Symbol.toStringTag ] : Object.prototype.toString,

  // module

  // moduleClone,
  moduleAdopt,
  openedModuleSet,
  moduleUsePaths,
  moduleUseError,

  // opener

  close,
  find,
  open,

  isOpened,
  isValid,
  isUsed,

  // willfile

  willfileUnregister,
  willfileRegister,
  _willfilesFindSmart,
  _willfilesFind,

  // submodule

  peerModuleGet,
  peerModuleSet,
  rootModuleGet,
  rootModuleSet,
  supermoduleGet,
  supermoduleSet,

  submodulesAllAreDownloaded,
  submodulesAllAreValid,

  // remote

  // remoteIsUpdate,
  // remoteIsUpToDateUpdate,

  // remoteIsDownloadedUpdate,
  // remoteIsDownloadedChanged,
  // remoteIsDownloadedSet,

  remoteForm,
  _remoteFormAct,
  _remoteDownload,
  remoteDownload,
  remoteUpgrade,
  remoteCurrentVersion,
  remoteLatestVersion,

  // path

  _filePathChange,

  willfilesPathGet,
  dirPathGet,
  commonPathGet,

  // inPathGet,
  // outPathGet,
  localPathGet,
  remotePathGet,
  // willPathGet,

  willfilesPathSet,
  // inPathSet,
  // outPathSet,
  localPathSet,
  remotePathSet,

  // name

  nameGet,
  _nameChanged,
  aliasNameSet,
  absoluteNameGet,
  shortNameArrayGet,

  // other accessor

  errorSet,

  isMainGet,
  isMainSet,
  isRemoteGet,
  isDownloadedGet,
  isUpToDateGet,
  isOutGet,

  isRemoteSet,
  isDownloadedSet,
  isUpToDateSet,
  isOutSet,

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

Self.prototype[ Symbol.toStringTag ] = Object.prototype.toString;

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
