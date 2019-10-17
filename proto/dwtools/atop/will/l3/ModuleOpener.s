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

  _.assert( !opener.finitedIs() );

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

  _.assert( opener.dirPath === undefined );
  _.assert( opener._.dirPath === undefined );
  opener._.dirPath = null;
  opener._.localPath = null;
  opener._.downloadPath = null;
  opener._.remotePath = null;
  _.assert( opener.dirPath === null );
  _.assert( opener._.dirPath === null );

  // debugger;

  if( o )
  opener.precopy( o );

  Parent.prototype.init.apply( opener, arguments );

  if( o )
  opener.copy( o );

  _.assert( !!o );
  _.assert( opener.unwrappedModuleOpener !== undefined );
  _.assert( opener.openedModule !== undefined );
  _.assert( opener.original !== undefined );
  _.assert( _.arrayHas( [ 'user', 'each', 'with', 'peer', 'sub', 'export' ], opener.reason ), 'Reason is not defined' );

  return opener;
}

//

function unform()
{
  let opener = this;
  let will = opener.will;

  if( !opener.formed )
  return opener;

  // if( opener.superRelation )
  // debugger;
  // if( opener.superRelation )
  // opener.superRelation.close();

  _.assert( opener.superRelation === null );

  if( opener.openedModule )
  {
    let openedModule = opener.openedModule;
    opener.openedModule = null;
    if( !openedModule.isUsedManually() )
    openedModule.finit();
  }

  let variant = will.variantOf( opener );
  if( variant && variant.has( opener ) )
  variant.remove( opener );

  opener.formed = 0;

  opener._willfilesRelease();
  will.openerUnregister( opener );

  return opener;
}

//

function preform()
{
  let opener = this;
  let will = opener.will;

  if( opener.formed )
  {
    return opener;
  }

  /* */

  _.assert( arguments.length === 0 );
  _.assert( !!opener.will );
  _.assert( _.strsAreAll( opener.willfilesPath ) || _.strIs( opener.dirPath ), 'Expects willfilesPath or dirPath' );
  _.assert( opener.formed === 0 );

  /* */

  // debugger;
  if( !will.mainOpener )
  opener.isMain = true;
  _.assert( will.mainOpener instanceof _.Will.ModuleOpener );

  // opener._filePathChanged1(); // ttt
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
  return end();

  /* */

  function end()
  {
    opener._remoteForm();
    _.assert( opener.formed >= 2 );
    return opener;
  }
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
    willfilesArray : null,

    willfilesPath : null,
    localPath : null,
    commonPath : null,
    downloadPath : null,
    remotePath : null,

    isRemote : null,
    isUpToDate : null,
    isOut : null,

  }

  let result = _.mapOnly( opener, Import );

  // if( opener.superRelation )
  // result.superRelations = [ opener.superRelation ]; // xxx

  result.willfilesArray = _.entityMake( result.willfilesArray );

  _.assert( _.boolLike( opener.isOut ), 'Expects defined {- opener.isOut -}' );

  return result;
}

//

function precopy( o )
{
  let opener = this;
  if( o.will )
  opener.will = o.will;
  if( o.superRelation )
  opener.superRelation = o.superRelation;
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

  _.assert( arguments.length === 1 );

  let read =
  {
    dirPath : null,
    localPath : null,
    downloadPath : null,
    remotePath : null,
  }
  let o2 = _.mapOnly( o, read );
  _.mapExtend( opener._, o2 );

  o = _.mapBut( o, read );
  let result = _.Copyable.prototype.copy.apply( opener, [ o ] );

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

function moduleAdopt( module )
{
  let opener = this;
  let will = opener.will;

  _.assert( !module.finitedIs() );
  _.assert( opener.openedModule === null );
  _.assert( arguments.length === 1 );
  _.assert( module instanceof _.Will.OpenedModule );
  _.assert( !opener.finitedIs() );
  _.assert( !module.finitedIs() );

  if( opener && !opener.isValid() )
  {
    // debugger;
    _.assert( opener.openedModule === null, 'not tested' );
    opener.close();
  }

  let o2 = module.optionsForOpenerExport();
  opener.copy( o2 );

  opener.preform();

  opener.openedModule = module;

  if( opener.superRelation )
  opener.superRelation._moduleAdoptEnd();

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

  // if( opener.id === 397 )
  // debugger;

  if( opener.openedModule === module )
  return module ;

  // if( opener.id === 128 )
  // debugger;

  // if( opener.superRelation && opener.openedModule )
  // opener.openedModule.superRelationsRemove( opener.superRelation );

  if( opener.openedModule )
  opener.openedModule.releasedBy( opener );

  // if( opener.superRelation && module )
  // module.superRelationsAppend( opener.superRelation );

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

  opener._.dirPath = module.dirPath;
  opener._.commonPath = module.commonPath;
  // opener[ dirPathSymbol ] = module.dirPath;
  // opener[ commonPathSymbol ] = module.commonPath;

  opener.willfilesPath = module.willfilesPath;
  // opener.downloadPath = module.downloadPath;
  // opener.localPath = module.localPath;
  // opener.remotePath = module.remotePath;

opener._.downloadPath = module.downloadPath;
opener._.localPath = module.localPath;
opener._.remotePath = module.remotePath;

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
  let module = opener.openedModule;

  _.assert( !opener.finitedIs() );
  _.assert( arguments.length === 0 );
  _.assert( opener.formed >= 0 );

  // let variant = will.variantOf( opener );
  // if( variant && variant.has( opener ) )
  // variant.remove( opener );

  if( module )
  {
    module.finit();
    // module.close();
    // _.assert( module.isUsedBy( opener ) );
    // opener.openedModule = null;
    _.assert( opener.openedModule === null );
    _.assert( !module.isUsedBy( opener ) );
  }

  if( opener.error )
  opener.error = null

  opener._willfilesRelease();

  if( opener.superRelation )
  opener.superRelation._closeEnd();

  if( opener.formed > 1 )
  {
    opener.formed = 1;
    opener._remoteForm();
  }

  // if( module )
  // {
  //   module.finit();
  // }

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

    _.assert( opener.formed >= 2 );
    if( opener.formed < 3 )
    opener.formed = 3;

    /*
      xxx : check
        import module
        import module.out
        import module.out.will
    */
    let openedModule = opener.openedModule;
    if( !openedModule )
    openedModule = will.moduleAt( opener.willfilesPath );

    /* */

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
      {
        debugger;
        openedModule = opener.willfilesArray[ 0 ].openedModule;
      }

    }

    /* */

    if( opener.error )
    {
      throw opener.error;
    }

    /* */

    if( openedModule )
    {

      if( openedModule.rootModule !== opener.rootModule && !!opener.rootModule )
      if( openedModule.rootModule === openedModule )
      {
        openedModule.rootModule = opener.rootModule;
      }

      _.assert( !opener.willfilesArray.length || !openedModule.willfilesArray.length || _.arraysAreIdentical( opener.willfilesArray, openedModule.willfilesArray ) );
      if( opener.willfilesArray.length )
      openedModule.willfilesArray = _.entityMake( opener.willfilesArray );
      else
      opener.willfilesArray = _.entityMake( openedModule.willfilesArray );

      let o2 = opener.optionsForModuleExport();
      for( let f in o2 )
      {
        if( o2[ f ] !== null && openedModule[ f ] === null )
        {
          openedModule[ f ] = o2[ f ];
        }
      }

      _.assert( opener.openedModule === openedModule || opener.openedModule === null );
      opener.openedModule = openedModule;

    }
    else
    {

      _.assert( opener.openedModule === null );
      let o2 = opener.optionsForModuleExport();
      openedModule = opener.openedModule = new will.OpenedModule( o2 );
      if( openedModule.rootModule === null )
      openedModule.rootModule = openedModule;
      openedModule.preform();

    }

    _.assert( _.arraysAreIdentical( opener.willfilesArray, opener.openedModule.willfilesArray ) );
    _.assert( _.arraysAreIdentical( _.mapVals( opener.willfileWithRoleMap ), _.mapVals( opener.openedModule.willfileWithRoleMap ) ) );

    if( !opener.openedModule.isUsedBy( opener ) )
    opener.openedModule.usedBy( opener );

    opener.formed = 4;

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

    // _.assert( opener.formed <= 3, () => `${opener.absoluteName} was already opened` );

    if( opener.error )
    throw opener.error;

    if( !opener.openedModule )
    opener.find();

    defaultsApply( o );

    _.assert( opener.formed >= 4 );

    if( opener.error )
    throw opener.error;

    let stager = opener.openedModule.stager;
    let rerun = false;

    let skipping = Object.create( null );
    skipping.attachedWillfilesFormed = !o.attachedWillfilesFormed;
    skipping.peerModulesFormed = !o.peerModulesFormed;
    skipping.subModulesFormed = !o.subModulesFormed;
    skipping.resourcesFormed = !o.resourcesFormed;

    // let processing = stager.stageStateBegun( 'opened' ) || ( stager.stageStateEnded( 'opened' ) && !stager.stageStateEnded( 'formed' ) );
    let processing = stager.stageStateBegun( 'opened' ) && !stager.stageStateEnded( 'formed' );
    _.assert( !processing, 'not tested' );

    for( let s in skipping )
    if( stager.stageStatePerformed( s ) )
    skipping[ s ] = false;
    else
    rerun = rerun || !skipping[ s ];

    if( !stager.stageStateEnded( 'opened' ) || rerun )
    {

      stager.stageStatePausing( 'opened', 0 );

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

    opener.openedModule.ready.finally( ( err, arg ) =>
    {
      if( err )
      {
        handleError( err );
        throw err;
      }
      if( opener.formed === 4 )
      opener.formed = 5;
      _.assert( opener.formed === 5 );
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

    opener.optionsFormingForward( o );

    if( o.attachedWillfilesFormed === null )
    o.attachedWillfilesFormed = isMain ? will.attachedWillfilesFormedOfMain : will.attachedWillfilesFormedOfSub;
    if( o.peerModulesFormed === null )
    o.peerModulesFormed = isMain ? will.peerModulesFormedOfMain : will.peerModulesFormedOfSub;
    if( o.subModulesFormed === null )
    o.subModulesFormed = isMain ? will.subModulesFormedOfMain : will.subModulesFormedOfSub;
    if( o.resourcesFormed === null )
    o.resourcesFormed = isMain ? will.resourcesFormedOfMain : will.resourcesFormedOfSub;

    o.attachedWillfilesFormed = !!o.attachedWillfilesFormed;
    o.peerModulesFormed = !!o.peerModulesFormed;
    o.subModulesFormed = !!o.subModulesFormed;
    o.resourcesFormed = !!o.resourcesFormed;

    return o;
  }

}

open.defaults =
{

  throwing : 1,
  attachedWillfilesFormed : null,
  peerModulesFormed : null,
  subModulesFormed : null,
  resourcesFormed : null,
  all : null,

}

//

function reopen()
{
  let opener = this;
  let will = opener.will;
  let module = opener.openedModule;
  let willfilesPath = _.make( opener.willfilesPath );
  let willf = opener.willfilesArray[ 0 ];

  debugger;

  opener.close();
  opener.willfilesPath = willfilesPath;
  _.assert( opener.error === null );
  _.assert( opener.searching !== 'exact' || _.entityIdentical( opener.willfilesPath, willfilesPath ) );
  _.assert( !_.arrayHas( will.willfilesArray, willf ) );

  debugger;

  opener.find();
  _.assert( opener.openedModule !== module );

  return opener.open();
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
  if( opener.superRelation )
  return true;

  return false;
}

//

function usersGet()
{
  let opener = this;
  let result = [];
  if( opener.openedModule )
  result.push( opener.openedModule );
  if( opener.superRelation )
  result.push( opener.superRelation );
  return result;
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

function _willfilesFindAct( o )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let filePaths;
  let records;

  o = _.routineOptions( _willfilesFindAct, arguments );
  o.willfilesPath = o.willfilesPath || opener.willfilesPath;

  _.assert( opener.willfilesArray.length === 0, 'not tested' );

  if( opener.searching === 'smart' )
  o.willfilesPath = _.Will.CommonPathFor( o.willfilesPath );

  if( opener.searching === 'exact' )
  {
    o.willfilesPath = _.arrayAs( o.willfilesPath );
    records = o.willfilesPath.map( ( willfilePath ) => fileProvider.record( willfilePath ) );
  }
  else
  {
    records = will.willfilesFind
    ({
      dirPath : o.willfilesPath,
      includingInFiles : o.includingInFiles,
      includingOutFiles : o.includingOutFiles,
      exact : !!opener.superRelation,
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

_willfilesFindAct.defaults =
{
  willfilesPath : null,
  includingInFiles : 1,
  includingOutFiles : 1,
}

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

    result = opener._willfilesFindAct();
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
    if( opener.superRelation )
    err = _.errBrief( 'Found no out-willfile file for',  opener.superRelation.qualifiedName, 'at', _.strQuote( opener.commonPath ) );
    else
    err = _.errBrief( 'Found no willfile at', _.strQuote( opener.commonPath ) );
    opener.error = opener.error || err;
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

function sharedFieldSet_functor( fieldName )
{
  let symbol = Symbol.for( fieldName );

  return function sharedModuleSet( src )
  {
    let opener = this;
    let openedModule = opener.openedModule;

    _.assert( src === null || src instanceof _.Will.OpenedModule );

    if( opener.id === 304 )
    if( fieldName === 'peerModule' && src )
    debugger;

    opener[ symbol ] = src;

    if( openedModule && openedModule[ fieldName ] !== src )
    openedModule[ fieldName ] = src;

    return src;
  }

}

let peerModuleGet = sharedFieldGet_functor( 'peerModule' );
let peerModuleSet = sharedFieldSet_functor( 'peerModule' );

let rootModuleGet = sharedFieldGet_functor( 'rootModule' );

//

function rootModuleSet( src )
{
  let opener = this;
  let openedModule = opener.openedModule;

  _.assert( src === null || src instanceof _.Will.OpenedModule );
  _.assert( src === null || src.rootModule === src || src.rootModule === null );

  opener[ rootModuleSymbol ] = src;

  if( openedModule && openedModule[ fieldName ] !== src )
  openedModule[ fieldName ] = src;

  return src;
}

//

function superRelationGet()
{
  let opener = this;
  _.assert( opener[ superRelationSymbol ] === undefined || opener[ superRelationSymbol ] === null || opener[ superRelationSymbol ] instanceof _.Will.ModulesRelation );
  return opener[ superRelationSymbol ];
}

//

function superRelationSet( src )
{
  let opener = this;
  let will = opener.will;

  _.assert( src === null || src instanceof _.Will.ModulesRelation );
  _.assert( src === null || src.opener === null || src.opener === opener )

  if( opener.openedModule && opener.superRelation )
  {
    opener.openedModule.superRelationsRemove( opener.superRelation );
  }

  opener[ superRelationSymbol ] = src;
  // opener._.superRelation = src;

  if( opener.openedModule && opener.superRelation )
  {
    opener.openedModule.superRelationsAppend( opener.superRelation );
  }

  return src;
}

// --
// remote
// --

function _remoteForm()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( opener.formed >= 1 );
  _.assert( opener.formed <= 2 );

  opener.remoteIsReform();

  if( opener.isRemote && opener.superRelation )
  {
    opener._remoteFormFormal();
  }
  else
  {
    opener._.localPath = opener.commonPath;
    opener.isDownloaded = true;
  }

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );

  if( opener.peerModule && opener.remotePath === null && opener.peerModule.remotePath && opener.peerModule.isRemote )
  {
    opener._.downloadPath = opener.peerModule.downloadPath;
    opener._.remotePath = _.Will.RemotePathAdjust( opener.peerModule.remotePath, path.relative( opener.peerModule.localPath, opener.localPath ) );
    /*
      xxx qqq :
        make it working for case when remote path is local
        for example : "git+hd:///module/_repo/Tools?out=out/wTools.out.will#master"
    */
  }

  if( opener.formed < 2 )
  opener.formed = 2;

  /*
    should goes after setting formed
  */

  if( !opener.superRelation || opener.superRelation.enabled ) /* ttt */
  will.variantFrom( opener );

  return opener;
}

//

function _remoteFormFormal()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let willfilesPath = opener.remotePath || opener.willfilesPath;

  _.assert( _.strDefined( opener.aliasName ) );
  _.assert( !!opener.superRelation );
  _.assert( _.strIs( willfilesPath ) );
  _.assert( opener.formed <= 2 );
  _.assert( opener.openedModule === null );

  let remoteProvider = fileProvider.providerForPath( opener.remotePath || opener.commonPath );

  _.assert( remoteProvider.isVcs && _.routineIs( remoteProvider.pathParse ), () => 'Seems file provider ' + remoteProvider.qualifiedName + ' does not have version control system features' );

  let submodulesDir = opener.superRelation.module.cloneDirPathGet();
  let parsed = remoteProvider.pathParse( willfilesPath );

  opener._.remotePath = willfilesPath;
  opener._.downloadPath = path.resolve( submodulesDir, opener.aliasName );

  let willfilesPath2 = path.resolve( submodulesDir, opener.aliasName, parsed.localVcsPath );
  opener._.localPath = _.Will.CommonPathFor( willfilesPath2 );
  opener._filePathChanged2({ willfilesPath : willfilesPath2 });

  if( opener.peerModule )
  debugger;
  if( opener.peerModule && opener.peerModule.remotePath === null )
  {
    debugger;
    _.assert( 0, 'not tested' );
    _.assert( !!opener.peerModule.localPath );
    _.assert( !!opener.peerModule.opener );
    opener.peerModule.opener._.downloadPath = opener.downloadPath;
    opener.peerModule.opener._.remotePath = path.join( opener.remotePath, path.relative( opener.localPath, opener.peerModule.localPath ) );
  }

  opener.remoteIsDownloadedReform();
  opener.remoteIsGoodRepositoryReform();

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );

  return opener;
}

//

function _remoteFormInformal()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let willfilesPath = opener.remotePath || opener.willfilesPath;

  _.assert( opener.aliasName === null );
  _.assert( opener.superRelation === null );
  _.assert( _.strIs( willfilesPath ) );
  _.assert( opener.formed <= 2 );
  _.assert( opener.openedModule === null );

  let remoteProvider = fileProvider.providerForPath( opener.remotePath || opener.commonPath );

  _.assert( remoteProvider.isVcs && _.routineIs( remoteProvider.pathParse ), () => 'Seems file provider ' + remoteProvider.qualifiedName + ' does not have version control system features' );

  if( !opener.downloadPath || !opener.remotePath )
  {
    debugger;
    throw _.err( 'Module should have both path::download, path:remote defined either none' );
  }

  if( opener.peerModule )
  debugger;
  if( opener.peerModule && opener.peerModule.remotePath === null )
  {
    debugger;
    _.assert( 0, 'not tested' );
    _.assert( !!opener.peerModule.localPath );
    _.assert( !!opener.peerModule.opener );
    opener.peerModule.opener._.downloadPath = opener.downloadPath;
    opener.peerModule.opener._.remotePath = path.join( opener.remotePath, path.relative( opener.localPath, opener.peerModule.localPath ) );
  }

  opener.remoteIsDownloadedReform();
  opener.remoteIsGoodRepositoryReform();

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );

  return opener;
}

//

/*

qqq : investigate please, fix and cover here and in wFiles
  - for download :
  -- if error then new directory should no be made
  -- if error and directory ( possibly empty ) existed then it should not be deleted
  - for other modules : investigate is it applicable to other modes

 = Message
    Process returned exit code 128
    Launched as "git clone https://github.com/Wandalen/wPathBasic.git ."
     -> Stderr
     -  Cloning into '.'...
     -  fatal: unable to access 'https://github.com/Wandalen/wPathBasic.git/': Could not resolve host: github.com
     -
     -< Stderr
    Failed to download module::reflect-get-path / opener::PathBasic
    Failed to download submodules

*/

function _remoteDownload( o )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let time = _.timeNow();
  let downloading = null;
  let origin = null;
  let hasLocalChanges = null;
  let isValid = null;
  let ready = _.Consequence().take( null );

  _.routineOptions( _remoteDownload, o );
  _.assert( arguments.length === 1 );
  _.assert( opener.formed >= 2 );
  _.assert( !!opener.willfilesPath );
  _.assert( _.strDefined( opener.aliasName ) );
  _.assert( _.strDefined( opener.remotePath ) );
  _.assert( _.strDefined( opener.downloadPath ) );
  _.assert( _.strDefined( opener.localPath ) );
  _.assert( !!opener.superRelation );
  _.assert( _.arrayHas( [ 'download', 'update', 'agree' ], o.mode ) );

  return ready
  .then( () => opener._remoteIsUpToDate({ mode : o.mode }) )
  .then( function( arg )
  {
    downloading = arg;

    _.assert( _.boolIs( downloading ) );

    debugger;
    // if( !downloading )
    // return downloading;

    if( o.mode === 'download' )
    {
      if( o.strict )
      {
        if( !opener.isDownloaded )
        filesCheck();
        if( opener.isDownloaded )
        repositoryCheck();
        if( opener.isDownloaded )
        moduleCheck();
      }
    }
    else if( o.mode === 'update' )
    {

      if( !opener.isDownloaded )
      filesCheck();
      if( opener.isDownloaded )
      repositoryCheck();
      if( opener.isDownloaded )
      moduleCheck();

      if( !downloading )
      return downloading;

      if( opener.isDownloaded && opener.isRepository )
      originCheck();
      if( opener.isDownloaded && opener.isRepository )
      localChangesCheck();

    }
    else if( o.mode === 'agree' )
    {
      if( !downloading )
      return downloading;

      if( opener.isDownloaded && opener.isRepository )
      originCheck();
      if( opener.isDownloaded && opener.isRepository )
      localChangesCheck();

      filesDeleteMaybe();

    }
    else _.assert( 0 );

    /*
    should goes after ifs
    */
    opener.error = null;

    return arg;
  })
  .then( () =>
  {
    return filesDownload();
  })
  .then( function( arg )
  {

    if( downloading && !o.dry )
    {
      opener.isDownloaded = true;
      opener.isUpToDate = true;
    }

    if( o.opening && !o.dry && downloading )
    moduleReopen();

    return null;
  })
  .finally( function( err, arg )
  {
    if( err )
    throw _.err( err, '\nFailed to', o.mode, opener.decoratedAbsoluteName );
    log();
    return downloading;
  });

  /* */

   function repositoryCheck()
   {
     _.assert( opener.isDownloaded === true );

     if( !opener.isRepository )
     throw _.err
     (
       'Module', opener.decoratedAbsoluteName, 'is downloaded, but its not a git repository.\n',
       'Rename/remove path:', _.color.strFormat( opener.downloadPath, 'path' ), 'and try again.'
     );
   }

  /* */

  function moduleCheck()
  {
    // qqq : should not be here
    // if( !opener.isDownloaded )
    // return;

    _.assert( opener.isDownloaded );

    // if( !opener.isValid() )
    if( !isValidReform() )
    throw _.err( 'Module', opener.decoratedAbsoluteName, 'is downloaded, but its not valid. Reason:', opener.error );
  }

  /* */

  function isValidReform()
  {
    if( isValid !== null )
    return isValid;
    isValid = opener.isValid();
    return isValid;
  }

  /* */

  function localChangesCheck()
  {

    /*
    if local repo has any changes then throw error with invitation to commit changes first
    */

    // if( !opener.isDownloaded )
    // return;
    //
    // // qqq : check
    // // if( !opener.isRepository && o.mode === 'agree' )
    // if( !opener.isRepository )
    // return;

    _.assert( downloading === true );
    _.assert( opener.isDownloaded === true );
    _.assert( opener.isRepository === true );

    if( hasLocalChangesReform() )
    throw _.errBrief
    (
      'Module at', opener.decoratedAbsoluteName, 'needs to be updated, but has local changes.',
      '\nPlease commit your local changes or stash them and merge manually after update.'
    );

  }

  /* */

  function hasLocalChangesReform()
  {
    if( hasLocalChanges !== null )
    return hasLocalChanges;
    hasLocalChanges = opener.remoteHasLocalChanges();
    return hasLocalChanges;
  }

  /* */

  function originCheck()
  {

    // if( !opener.isDownloaded )
    // return;

    _.assert( downloading === true );
    _.assert( opener.isDownloaded === true );
    _.assert( opener.isRepository === true );

    hasGoodOriginReform();

    if( !origin.downloadedFromRemote )
    throw _.err
    (
      'Module', opener.decoratedAbsoluteName, 'is already downloaded, but has different origin url:',
      _.color.strFormat( origin.originVcsPath, 'path' ), ', expected url:', _.color.strFormat( origin.remoteVcsPath, 'path' )
    );

  }

  /* */

  function hasGoodOriginReform()
  {

    if( origin !== null )
    return origin;

    let gitProvider = will.fileProvider.providerForPath( opener.remotePath );

    origin = gitProvider.isDownloadedFromRemote
    ({
      localPath : opener.downloadPath,
      remotePath : opener.remotePath
    });

    return origin;
  }

  /* */

  function filesCheck()
  {
    _.assert( opener.isDownloaded === false );

    if( fileProvider.fileExists( opener.downloadPath ) && !fileProvider.dirIsEmpty( opener.downloadPath ) )
    {
      debugger;
      throw _.err
      (
        'Module', opener.decoratedAbsoluteName, 'is not downloaded, but file at', _.color.strFormat( opener.downloadPath, 'path' ), 'exits.',
        'Rename/remove path:', _.color.strFormat( opener.downloadPath, 'path' ), 'and try again.'
      )
    }
  }

  /* */

  function filesDeleteMaybe()
  {

    if( o.dry )
    return null;

    /*
      delete old remote opener if:
      - it has a critical error or downloaded files are corrupted
      - module origin is different
    */

    // qqq : check
    // if( !downloading )
    // return;

    _.assert( downloading === true );

    let isRepository = opener.isRepository;
    _.assert( _.boolIs( isRepository ) );
    if( !isRepository )
    return end( true );

    let isValid = isValidReform();
    _.assert( _.boolIs( isValid ) );
    if( !isValid )
    return end( true );

    hasGoodOriginReform();
    _.assert( _.boolIs( origin.downloadedFromRemote ) );
    if( !origin.downloadedFromRemote )
    return end( true );

    return end( false );

    function end( deleting )
    {
      _.assert( _.boolIs( deleting ) );
      if( deleting )
      {
        // debugger;
        fileProvider.filesDelete({ filePath : opener.downloadPath, throwing : 0, sync : 1 });
      }
      return deleting;
    }

    // let remove = !opener.isValid() || !opener.isRepository;
    //
    // if( !remove )
    // {
    //   let gitProvider = will.fileProvider.providerForPath( opener.remotePath );
    //   let result = gitProvider.isDownloadedFromRemote
    //   ({
    //     localPath : opener.downloadPath,
    //     remotePath : opener.remotePath
    //   });
    //   remove = !result.downloadedFromRemote;
    // }
    //
    // if( remove )
    // {
    //   if( fileProvider.fileExists( opener.downloadPath ) )
    //   debugger;
    //   fileProvider.filesDelete({ filePath : opener.downloadPath, throwing : 0, sync : 1 });
    // }

  }

  /* */

  function filesDownload()
  {

    let o2 =
    {
      reflectMap : { [ opener.remotePath ] : opener.downloadPath },
      verbosity : will.verbosity - 5,
      extra : { fetching : 0 },
    }

    if( downloading && !o.dry )
    return will.Predefined.filesReflect.call( fileProvider, o2 );

    return null;
  }

  /* */

  function moduleReopen()
  {
    let ready = new _.Consequence().take( null );

    let variant = will.variantFrom( opener );
    variant.openers.forEach( ( opener2 ) =>
    {
      ready.then( () => opener2.reopen() );
    });

    debugger;
    return ready;
  }

  /* */

  function log()
  {
    let module = opener.openedModule ? opener.openedModule : opener;
    if( will.verbosity >= 3 && downloading )
    {
      if( o.dry )
      {
        let remoteProvider = fileProvider.providerForPath( opener.remotePath );
        let version = remoteProvider.versionRemoteCurrentRetrive( opener.remotePath );
        let phrase = '';
        if( o.mode === 'update' )
        phrase = ' to';
        else if( o.mode === 'agree' )
        phrase = ' with';
        logger.log( ' + ' + module.decoratedQualifiedName + ' will be ' + ( o.mode + phrase ) + ' version ' + _.color.strFormat( version, 'path' ) );
      }
      else
      {
        let remoteProvider = fileProvider.providerForPath( opener.remotePath );
        let version = remoteProvider.versionLocalRetrive( opener.downloadPath );
        let phrase = '';
        if( o.mode === 'update' )
        phrase = ' was updated to version ';
        else if( o.mode === 'agree' )
        phrase = ' was agreed with version ';
        else if( o.mode === 'download' )
        phrase = ' was downloaded version ';
        logger.log( ' + ' + module.decoratedQualifiedName + phrase + _.color.strFormat( version, 'path' ) + ' in ' + _.timeSpent( time ) );
      }
    }
  }

  /* */
}

_remoteDownload.defaults =
{
  mode : 'download',
  dry : 0,
  opening : 1,
  recursive : 0,
  strict : 1
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

function remoteIsDownloadedReform()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( module.downloadPath ) );
  _.assert( !!module.willfilesPath );
  _.assert( module.isRemote === true );

  let remoteProvider = fileProvider.providerForPath( module.remotePath );
  _.assert( !!remoteProvider.isVcs );

  let result = remoteProvider.isDownloaded
  ({
    localPath : module.downloadPath,
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

function remoteIsGoodRepositoryReform()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( module.downloadPath ) );
  _.assert( !!module.willfilesPath );
  _.assert( module.isRemote === true );

  // let remoteProvider = fileProvider.providerForPath( module.remotePath );
  // _.assert( !!remoteProvider.isVcs );

  let result = _.git.isRepository
  ({
    localPath : module.downloadPath,
  });

  _.assert( !_.consequenceIs( result ) );

  // if( !result )
  // return end( result );

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
    module.isRepository = !!result;
    return result;
  }

}

//

function _remoteIsUpToDate( o )
{
  let opener = this;
  let ready = _.Consequence().take( null );

  ready
  .then( () =>
  {
    if( o.mode === 'download' )
    return isDownloadedRepositoryReform();
    else if( o.mode === 'update' )
    return isUpdatedRepositoryReform();
    else if( o.mode === 'agree' )
    return isUpdatedRepositoryReform();
  })
  .then( function()
  {
    let downloading = false;
    // debugger
    /* qqq : check */
    if( o.mode === 'download' )
    downloading = !opener.isDownloaded;
    // downloading = opener.isDownloaded && opener.isRepository;
    else if( o.mode === 'update' )
    downloading = !opener.isUpToDate || !opener.isRepository;
    // downloading = opener.isUpToDate;
    else if( o.mode === 'agree' )
    downloading = !opener.isUpToDate || !opener.isRepository;
    // downloading = opener.isUpToDate;
    _.assert( _.boolLike( downloading ) );
    /* qqq */
    return !!downloading;
  })
  .then( ( downloading ) =>
  {
    if( !downloading )
    if( o.mode === 'update' || o.mode === 'agree' )
    {
      let gitProvider = opener.will.fileProvider.providerForPath( opener.remotePath );
      let result = gitProvider.isDownloadedFromRemote
      ({
        localPath : opener.downloadPath,
        remotePath : opener.remotePath
      });

      downloading = !result.downloadedFromRemote;
    }

    return downloading;
  })

  /*  */

  function isUpdatedRepositoryReform()
  {
    let con = new _.Consequence().take( null );
    con.then( () => opener.remoteIsGoodRepositoryReform() )
    con.then( () => opener.remoteIsUpToDateReform() )
    return con;
  }

  /* */

  function isDownloadedRepositoryReform()
  {
    let con = new _.Consequence().take( null );
    con.then( () => opener.remoteIsDownloadedReform() )
    /* qqq : check */
    // con.then( () => opener.remoteIsGoodRepositoryReform() )
    return con;
  }

  return ready;
}

_remoteIsUpToDate.defaults =
{
  mode : 'download',
}

// --
// path
// --

function _filePathChanged1( o )
{
  let opener = this;

  if( !this.will )
  return o;

  _.assert( o.willfilesPath !== undefined ); // ttt
  // if( o.willfilesPath === opener.willfilesPath )
  // return;

  o = opener._filePathChanged2( o );

  if( !o.isIdentical )
  if( opener.formed && opener.formed < 3 ) // ttt
  // if( opener.formed )
  {
    opener._remoteForm();
  }

  if( opener.openedModule && !o.isIdentical )
  debugger;
  if( opener.openedModule && !o.isIdentical )
  opener.openedModule._filePathChanged2({ willfilesPath : o.willfilesPath });

  return o;
}

_filePathChanged1.defaults = _.mapExtend( null, _.Will.AbstractModule.prototype._filePathChanged1.defaults );

//

function _filePathChanged2( o )
{
  let opener = this;

  if( !this.will )
  return o;

  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = Parent.prototype._filePathChanged2.call( opener, o );

  _.assert( _.boolIs( o.isIdentical ) );

  opener._.willfilesPath = o.willfilesPath;
  opener._.dirPath = o.dirPath;

  if( o.commonPath )
  {
    opener._.commonPath = o.commonPath;
    if( opener.isRemote === false )
    opener._.localPath = o.commonPath;
  }

  if( !o.isIdentical )
  if( opener.willfilesPath && opener.commonPath && opener.formed >= 2 )
  {
    if( !opener.superRelation || opener.superRelation.enabled ) /* ttt */
    will.variantFrom( opener );
  }

  return o;
}

_filePathChanged2.defaults = _.mapExtend( null, _.Will.AbstractModule.prototype._filePathChanged2.defaults );

//

function willfilesPathSet( filePath )
{
  let opener = this;
  let module = opener.openedModule;
  let will = opener.will;

  opener._filePathChanged1({ willfilesPath : filePath });

}

//

function sharedFieldPut_functor( fieldName )
{
  let symbol = Symbol.for( fieldName );

  return function put( val )
  {
    let opener = this;
    let will = opener.will;
    let module = opener.openedModule;
    let ex = opener[ symbol ]

    opener[ symbol ] = val;

    _.assert( !module || module[ fieldName ] === val );

    if( will )
    will._pathChanged
    ({
      object : opener,
      fieldName : fieldName,
      val,
      ex,
      kind : 'put',
    });

    return val;
  }

}

//

let willfilesPathGet = sharedFieldGet_functor( 'willfilesPath' );
let dirPathGet = sharedFieldGet_functor( 'dirPath' );
let commonPathGet = sharedFieldGet_functor( 'commonPath' );
let downloadPathGet = sharedFieldGet_functor( 'downloadPath' );
let localPathGet = sharedFieldGet_functor( 'localPath' );
let remotePathGet = sharedFieldGet_functor( 'remotePath' );

let willfilesPathPut = sharedFieldPut_functor( 'willfilesPath' );
let dirPathPut = sharedFieldPut_functor( 'dirPath' );
let commonPathPut = sharedFieldPut_functor( 'commonPath' );
let downloadPathPut = sharedFieldPut_functor( 'downloadPath' );
let localPathPut = sharedFieldPut_functor( 'localPath' );
let remotePathPut = sharedFieldPut_functor( 'remotePath' );

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
  // opener._.aliasName = src;
  opener._nameChanged();
}

//

function qualifiedNameGet()
{
  let opener = this;
  let name = opener.name;
  return 'opener' + '::' + name;
}

//

function absoluteNameGet()
{
  let opener = this;
  let superRelation = opener.superRelation;
  if( superRelation )
  return superRelation.module.absoluteName + ' / ' + opener.qualifiedName;
  else
  return opener.qualifiedName;
}

//

function shortNameArrayGet()
{
  let opener = this;
  let superRelation = opener.openedModule.superRelation;
  if( !superRelation )
  return [ opener.name ];
  let result = superRelation.shortNameArrayGet();
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

function isPreformed()
{
  let opener = this;
  return opener.formed >= 1;
}

//

function isMainGet()
{
  let opener = this;
  let will = opener.will;
  if( !will )
  return null;
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

  // if( src )
  // debugger;

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
let isUpToDateGet = accessorGet_functor( 'isUpToDate' );
let isRepositoryGet = accessorGet_functor( 'isRepository' );
let isOutGet = accessorGet_functor( 'isOut' );

let isRemoteSet = accessorSet_functor( 'isRemote' );
let isUpToDateSet = accessorSet_functor( 'isUpToDate' );
let isRepositorySet = accessorGet_functor( 'isRepository' );
let isOutSet = accessorSet_functor( 'isOut' );

// --
// relations
// --

let aliasNameSymbol = Symbol.for( 'aliasName' );
let superRelationSymbol = Symbol.for( 'superRelation' );
let rootModuleSymbol = Symbol.for( 'rootModule' );
let openedModuleSymbol = Symbol.for( 'openedModule' );
let errorSymbol = Symbol.for( 'error' );

let Composes =
{

  aliasName : null,
  willfilesPath : null,

  isRemote : null,
  isDownloaded : null,
  isRepository : null,
  isUpToDate : null,
  isOut : null,
  isMain : null,
  isAuto : null,

  reason : null,
  searching : 'strict', /* 'smart', 'strict', 'exact' */

}

// _.assert( Composes.downloadPath === undefined );

let Aggregates =
{
}

let Associates =
{

  original : null,
  will : null,
  rootModule : null,
  superRelation : null,
  willfilesArray : _.define.own([]),

}

let Medials =
{
  moduleWithCommonPathMap : null,
}

let Restricts =
{

  id : null,
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
  willPath : 'willPath',
  preformed : 'preformed',
  supermoduleSubmodule : 'supermoduleSubmodule',
  supermodule : 'supermodule',
}

_.assert( _.routineIs( _.accessor.getter.toStructure ) );
_.assert( _.arrayHas( _.accessor.getter.toStructure.rubrics, 'functor' ) );

let Accessors =
{

  _ : { getter : _.accessor.getter.toStructure },

  willfilesPath : { getter : willfilesPathGet, setter : willfilesPathSet },
  dirPath : { getter : dirPathGet, readOnly : 1 },
  commonPath : { getter : commonPathGet, readOnly : 1 },
  localPath : { getter : localPathGet, readOnly : 1, },
  downloadPath : { getter : downloadPathGet, readOnly : 1 },
  remotePath : { getter : remotePathGet, readOnly : 1 },

  name : { getter : nameGet, readOnly : 1 },
  aliasName : { setter : aliasNameSet },
  absoluteName : { getter : absoluteNameGet, readOnly : 1 },
  qualifiedName : { getter : qualifiedNameGet, combining : 'rewrite', readOnly : 1 },

  isRemote : { getter : isRemoteGet, setter : isRemoteSet },
  isUpToDate : { getter : isUpToDateGet, setter : isUpToDateSet },
  isOut : { getter : isOutGet, setter : isOutSet },
  isMain : { getter : isMainGet, setter : isMainSet },

  superRelation : {},
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
  precopy,
  copy,
  clone,
  cloneExtending,

  // module

  moduleAdopt,
  openedModuleSet,
  moduleUsePaths,
  moduleUseError,

  // opener

  close,
  find,
  open,
  reopen,

  isOpened,
  isValid,
  isUsed,
  usersGet,

  // willfile

  willfileUnregister,
  willfileRegister,
  _willfilesFindAct,
  _willfilesFind,

  // submodule

  peerModuleGet,
  peerModuleSet,
  rootModuleGet,
  rootModuleSet,
  superRelationGet,
  superRelationSet,

  // remote

  _remoteForm,
  _remoteFormFormal,
  _remoteFormInformal,
  _remoteDownload,
  remoteDownload,
  remoteUpgrade,
  remoteIsDownloadedReform,
  remoteIsGoodRepositoryReform,
  _remoteIsUpToDate,

  // path

  _filePathChanged1,
  _filePathChanged2,

  willfilesPathGet,
  dirPathGet,
  commonPathGet,

  downloadPathGet,
  localPathGet,
  remotePathGet,

  willfilesPathSet,

  willfilesPathPut,
  dirPathPut,
  commonPathPut,
  downloadPathPut,
  localPathPut,
  remotePathPut,

  // name

  nameGet,
  _nameChanged,
  aliasNameSet,
  absoluteNameGet,
  shortNameArrayGet,

  // other accessor

  errorSet,

  isPreformed,
  isMainGet,
  isMainSet,
  isRemoteGet,
  isUpToDateGet,
  isRepositoryGet,
  isOutGet,

  isRemoteSet,
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
