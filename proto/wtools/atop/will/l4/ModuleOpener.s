( function _ModuleOpener_s_()
{

'use strict';

/**
 * @classdesc Class wWillModuleOpener allows to keep all parts of module as single instance. Interface keeps data with module paths, willfiles, cli and other.
 * @class wWillModuleOpener
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = _.will.AbstractModule2;
const Self = wWillModuleOpener;
function wWillModuleOpener( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ModuleOpener';

_.assert( _.routineIs( Parent ) );

// --
// inter
// --

function finit()
{
  let opener = this;
  let will = opener.will;

  _.assert( !opener.isFinited() );

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

  if( o )
  opener.precopy( o );

  Parent.prototype.init.apply( opener, arguments );

  if( o )
  opener.copy( o );

  _.assert( !!o );
  _.assert( opener.unwrappedModuleOpener !== undefined );
  _.assert( opener.openedModule !== undefined );
  _.assert( opener.original !== undefined );
  _.assert( _.longHas( [ 'user', 'each', 'with', 'peer', 'sub', 'export' ], opener.reason ), 'Reason is not defined' );

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
    repo : null,
    willfilesArray : null,

    willfilesPath : null,
    localPath : null,
    commonPath : null,
    downloadPath : null,
    remotePath : null,

    isOut : null,

  }

  let result = _.mapOnly_( null, opener, Import );

  result.superRelations = null;
  result.willfilesArray = _.entity.make( result.willfilesArray );

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
  let o2 = _.mapOnly_( null, o, read );
  _.mapExtend( opener._, o2 );

  o = _.mapBut_( null, o, read );
  let result = _.Copyable.prototype.copy.apply( opener, [ o ] );

  return result;
}

//

function clone()
{
  let opener = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );

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

  let result = _.Copyable.prototype.cloneExtending.call( opener, o );

  return result;
}

// --
// former
// --

function unform()
{
  let opener = this;
  let will = opener.will;

  if( opener.formed <= 0 )
  return opener;

  _.assert( opener.superRelation === null );

  opener.formed = -1;

  // let junction = will.junctionOf( opener ); /* yyy */
  // /* xxx : can be false? */
  // if( junction && junction.own( opener ) )
  // junction.remove( opener );

  if( opener.openedModule )
  {
    let openedModule = opener.openedModule;
    opener.openedModule = null;
    if( !openedModule.isUsedManually() )
    openedModule.finit();
  }

  let junction = will.junctionOf( opener ); /* yyy */
  /* xxx : can be false? */
  if( junction && junction.own( opener ) )
  junction.remove( opener );

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

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!opener.will );
  _.assert( _.strsAreAll( opener.willfilesPath ) || _.strIs( opener.dirPath ), 'Expects willfilesPath or dirPath' );
  _.assert( opener.formed === 0 );

  /* */

  if( !will.mainOpener )
  opener.isMain = true;
  _.assert( will.mainOpener instanceof _.will.ModuleOpener );

  will.openerRegister( opener );
  will._willfilesReadBegin();

  if( opener.isOut === null && opener.willfilesPath )
  opener.isOut = _.will.filePathIsOut( opener.willfilesPath );

  /* */

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!opener.will );
  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );
  _.assert( opener.dirPath === null || _.strDefined( opener.dirPath ) );
  _.assert( !!opener.willfilesPath || !!opener.dirPath );
  _.assert( _.boolLike( opener.isOut ) );

  /* */

  opener.formed = 1;
  return end();

  /* */

  function end()
  {
    opener._repoForm();
    _.assert( opener.formed >= 2 );
    return opener;
  }
}

// --
// relator
// --

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

//

function own( object )
{
  let opener = this;
  let will = opener.will;

  _.assert( !!object );

  if( object instanceof _.will.ModulesRelation )
  {
    if( object === opener.superRelation )
    return true;
    if( opener.openedModule )
    for( let r = 0 ; r < opener.openedModule.superRelations.length ; r++ )
    {
      let object2 = opener.openedModule.superRelations[ r ];
      if( object2 === object )
      return true;
    }
  }
  else if( object instanceof _.will.ModuleOpener )
  {
    return object === opener;
  }
  else
  {
    if( opener.openedModule )
    return opener.openedModule.own( object );
  }

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

  _.arrayRemoveElementOnceStrictly( willf.openers, opener );

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
  let records;

  o = _.routineOptions( _willfilesFindAct, arguments );
  o.willfilesPath = o.willfilesPath || opener.willfilesPath;

  _.assert( opener.willfilesArray.length === 0, 'not tested' );
  _.assert( _.longHas( [ 'smart', 'exact', 'strict' ], opener.searching ) );

  if( opener.searching === 'smart' )
  o.willfilesPath = _.Will.CommonPathFor( o.willfilesPath );

  if( opener.searching === 'exact' )
  {
    o.willfilesPath = _.arrayAs( o.willfilesPath );
    records = o.willfilesPath.map( ( willfilePath ) => fileProvider.record( willfilePath ) );
  }
  else
  {
    // if( _.strEnds( o.willfilesPath, '/l2' ) )
    // debugger;
    records = will.willfilesFind
    ({
      commonPath : o.willfilesPath,
      withIn : o.withIn,
      withOut : o.withOut,
      exact : !!opener.superRelation,
      usingCache : 1,
    });
  }

  for( let r = 0 ; r < records.length ; r++ )
  {
    let record = records[ r ];

    let willfOptions =
    {
      filePath : record.absolute,
    }
    let got = will.willfileFor({ willf : willfOptions, combining : 'supplement' });
    opener.willfileRegister( got.willf );

  }

}

_willfilesFindAct.defaults =
{
  willfilesPath : null,
  withIn : 1,
  withOut : 1,
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

  _.assert( arguments.length === 0, 'Expects no arguments' );

  try
  {

    result = opener._willfilesFindAct();
    _.assert( !_.consequenceIs( result ) );
    if( opener.willfilesArray.length )
    _.assert( !!opener.willfilesPath && !!opener.dirPath );

  }
  catch( err )
  {
    let error = _.err( err, '\nError looking for will files for', opener.qualifiedName, 'at', _.strQuote( opener.commonPath ) );
    opener.error = opener.error || error;
  }

  if( !opener.error )
  if( opener.willfilesArray.length === 0 )
  {
    let err;
    if( opener.superRelation )
    err = _.errBrief( 'Found no out-willfile for',  opener.superRelation.qualifiedName, 'at', _.strQuote( opener.commonPath ) );
    else
    err = _.errBrief( 'Found no willfile at', _.strQuote( opener.commonPath ) );
    opener.error = opener.error || err;
  }

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

  _.assert( !opener.isFinited() );
  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( opener.formed >= 0 );

  if( module )
  {
    _.assert( _.longHas( module.userArray, opener ) );
    opener.openedModule = null;
    _.assert( !_.longHas( module.userArray, opener ) );
    module.finit();
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
    opener._repoForm();
  }

}

//

function find( o )
{
  let opener = this;
  let will = opener.will;

  o = _.routineOptions( find, arguments );
  _.assert( _.longHas( [ 'smart', 'strict', 'exact' ], opener.searching ) );
  _.assert( opener.formed <= 2 );

  if( opener.openedModule )
  return opener.openedModule;

  try
  {

    opener.preform();

    _.assert( opener.formed >= 2 );
    if( opener.formed < 3 )
    opener.formed = 3;

    let openedModule = opener.openedModule;
    if( !openedModule )
    openedModule = will.moduleAt( opener.willfilesPath );

    /* */

    // debugger;

    if( !openedModule || !openedModule.willfilesArray.length )
    {

      opener._willfilesFind();

      if( !opener.error )
      if( !opener.willfilesArray.length )
      {
        opener.error = _.err( 'Found no will file at ' + _.strQuote( opener.dirPath ) );
      }

      /* get module from opened willfile, maybe */

      if( opener.willfilesArray.length )
      if( opener.willfilesArray[ 0 ].openedModule )
      {
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

      _.assert
      (
        !opener.willfilesArray.length
        || !openedModule.willfilesArray.length
        || _.longIdentical( opener.willfilesArray, openedModule.willfilesArray )
      );
      if( opener.willfilesArray.length )
      openedModule.willfilesArray = _.entity.make( opener.willfilesArray );
      else
      opener.willfilesArray = _.entity.make( openedModule.willfilesArray );

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
      openedModule = opener.openedModule = new _.will.Module( o2 );
      if( openedModule.rootModule === null )
      openedModule.rootModule = openedModule;
      openedModule.preform();

    }

    _.assert( _.longIdentical( opener.willfilesArray, opener.openedModule.willfilesArray ) );
    _.assert( _.longIdentical( _.mapVals( opener.willfileWithRoleMap ), _.mapVals( opener.openedModule.willfileWithRoleMap ) ) );

    if( !opener.openedModule.isUsedBy( opener ) )
    opener.openedModule.usedBy( opener );

    opener.formed = 4;

    return opener.openedModule;
  }
  catch( err )
  {
    let error = _.err( err, `\nError looking for willfiles for module at ${opener.commonPath}` );
    opener.error = opener.error || error;
    if( o.throwing )
    throw error;
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

    // debugger;

    let processing = stager.stageStateBegun( 'opened' ) && !stager.stageStateEnded( 'finalFormed' );
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

    // if( o.attachedWillfilesFormed === null )
    // o.attachedWillfilesFormed = isMain ? will.attachedWillfilesFormedOfMain : will.attachedWillfilesFormedOfSub;
    // if( o.peerModulesFormed === null )
    // o.peerModulesFormed = isMain ? will.peerModulesFormedOfMain : will.peerModulesFormedOfSub;
    // if( o.subModulesFormed === null )
    // o.subModulesFormed = isMain ? will.subModulesFormedOfMain : will.subModulesFormedOfSub;
    // if( o.resourcesFormed === null )
    // o.resourcesFormed = isMain ? will.resourcesFormedOfMain : will.resourcesFormedOfSub;

    if( o.attachedWillfilesFormed === null )
    o.attachedWillfilesFormed = isMain ? will.transaction.attachedWillfilesFormedOfMain : will.transaction.attachedWillfilesFormedOfSub;
    if( o.peerModulesFormed === null )
    o.peerModulesFormed = isMain ? will.transaction.peerModulesFormedOfMain : will.transaction.peerModulesFormedOfSub;
    if( o.subModulesFormed === null )
    o.subModulesFormed = isMain ? will.transaction.subModulesFormedOfMain : will.transaction.subModulesFormedOfSub;
    if( o.resourcesFormed === null )
    o.resourcesFormed = isMain ? will.transaction.resourcesFormedOfMain : will.transaction.resourcesFormedOfSub;

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

  _.assert( !opener.isFinited() );
  opener.close();
  _.assert( !opener.isFinited() );
  opener.willfilesPath = willfilesPath;
  _.assert( opener.error === null );
  // _.assert( opener.searching !== 'exact' || _.entityIdentical( opener.willfilesPath, willfilesPath ) );
  _.assert( opener.searching !== 'exact' || _.path.map.identical( opener.willfilesPath, willfilesPath ) );
  _.assert( !_.longHas( will.willfilesArray, willf ) );

  opener.find();
  _.assert( opener.openedModule !== module );

  return opener.open();
}

//

function isOpened()
{
  let opener = this;
  return !!opener.openedModule && opener.openedModule.stager.stageStatePerformed( 'finalFormed' );
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

// --
// module
// --

function moduleAdopt( module )
{
  let opener = this;
  let will = opener.will;

  _.assert( !module.isFinited() );
  _.assert( opener.openedModule === null );
  _.assert( arguments.length === 1 );
  _.assert( module instanceof _.will.Module );
  _.assert( !opener.isFinited() );
  _.assert( !module.isFinited() );

  if( opener && !opener.isValid() )
  {
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
  _.assert( _.longHas( module.userArray, opener ) );
  _.assert( opener.repo === module.repo );

  return module;
}

//

function openedModuleSet( module )
{
  let opener = this;

  _.assert( arguments.length === 1 );
  _.assert( module === null || module instanceof _.will.Module )

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

  if( module )
  module.assertIsValidIntegrity(); /* zzz : temp */

  return module;
}

//

function moduleUsePaths( module )
{
  let opener = this;

  _.assert( arguments.length === 1 );
  _.assert( module instanceof _.will.Module );

  opener._.dirPath = module.dirPath;
  opener._.commonPath = module.commonPath;

  opener.willfilesPath = module.willfilesPath;

  opener._.downloadPath = module.downloadPath;
  opener._.localPath = module.localPath;
  opener._.remotePath = module.remotePath;

}

//

function moduleUseError( module )
{
  let opener = this;

  _.assert( arguments.length === 1 );
  _.assert( module instanceof _.will.Module );

  if( module.ready.errorsCount() )
  opener.error = opener.error || module.ready.errorsGet()[ 0 ];

}

//

function submodulesRelationsFilter( o )
{
  let opener = this;

  _.assert( arguments.length === 1 );

  if( opener.openedModule )
  return opener.openedModule.submodulesRelationsFilter( o );

  return [];
}

// {
//   let opener = this;
//   let will = opener.will;
//
//   o = _.routineOptions( submodulesRelationsFilter, arguments );
//
//   let result = opener.submodulesRelationsOwnFilter( o );
//   let junction = will.junctionFrom( opener );
//   let junctions = junction.submodulesJunctionsFilter( _.mapOnly_( null, o, junction.submodulesJunctionsFilter ) );
//
//   result = _.arrayAppendArraysOnce( result, junctions.map( ( junction ) => junction.objects ) );
//
//   return result;
// }

submodulesRelationsFilter.defaults =
{

  ... _.Will.RelationFilterDefaults,
  withPeers : 1,
  withoutDuplicates : 0,

}

//

function submodulesRelationsOwnFilter( o )
{
  let opener = this;

  _.assert( arguments.length === 1 );

  if( opener.openedModule )
  return opener.openedModule.submodulesRelationsOwnFilter( o );

  return [];
}

submodulesRelationsOwnFilter.defaults =
{

  ... _.Will.RelationFilterDefaults,
  withPeers : 1,
  withoutDuplicates : 0,
  allVariants : 0,

}

_.assert( submodulesRelationsOwnFilter.defaults.withStem === undefined );

// --
// submodule
// --

function sharedFieldGet_functor( propName )
{
  let symbol = Symbol.for( propName );

  return function sharedFieldGet()
  {
    let opener = this;
    let openedModule = opener.openedModule;
    let will = opener.will;

    if( openedModule )
    return openedModule[ propName ];

    let result = opener[ symbol ];

    return result;
  }

}

//

function sharedFieldSet_functor( propName )
{
  let symbol = Symbol.for( propName );

  return function sharedModuleSet( src )
  {
    let opener = this;
    let openedModule = opener.openedModule;

    _.assert( src === null || src instanceof _.will.Module );

    opener[ symbol ] = src;

    if( openedModule && openedModule[ propName ] !== src )
    openedModule[ propName ] = src;

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
  let will = opener.will;
  let openedModule = opener.openedModule;

  _.assert( src === null || src instanceof _.will.Module );
  _.assert( src === null || src.rootModule === src || src.rootModule === null );

  opener[ rootModuleSymbol ] = src;

  if( openedModule && openedModule[ propName ] !== src )
  openedModule[ propName ] = src;

  if( will )
  {
    let junction = will.junctionOf( opener );
    if( junction )
    junction.reform();
  }

  return src;
}

//

function superRelationGet()
{
  let opener = this;
  _.assert
  (
    opener[ superRelationSymbol ] === undefined
    || opener[ superRelationSymbol ] === null
    || opener[ superRelationSymbol ] instanceof _.will.ModulesRelation
  );
  return opener[ superRelationSymbol ];
}

//

function superRelationSet( src )
{
  let opener = this;
  let will = opener.will;

  _.assert( src === null || src instanceof _.will.ModulesRelation );
  _.assert( src === null || src.opener === null || src.opener === opener )

  if( opener.openedModule && opener.superRelation )
  {
    opener.openedModule.superRelationsRemove( opener.superRelation );
  }

  opener[ superRelationSymbol ] = src;
  // opener._.superRelation = src; /* xxx */

  if( opener.openedModule && opener.superRelation )
  {
    opener.openedModule.superRelationsAppend( opener.superRelation );
  }

  return src;
}

// --
// remote
// --

function _repoForm()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( opener.formed >= 1 );
  _.assert( opener.formed <= 2 );
  _.assert( opener.openedModule === null );

  let downloadPath, remotePath;
  let isRemote = will.pathIsRemote( opener.remotePath ? path.common( opener.remotePath ) : opener.commonPath );
  // let isRemote = opener.repoIsRemote();

  // if( opener.id === 1 )
  // debugger;

  if( opener.peerModule && opener.remotePath === null && opener.peerModule.remotePath )
  {
    if( !opener._.localPath )
    opener._.localPath = opener.commonPath;
    downloadPath = opener._.downloadPath = opener.peerModule.downloadPath;
    remotePath = opener._.remotePath = opener.peerModule.peerRemotePathGet();
    // isRemote = opener.repoIsRemote();
    isRemote = will.pathIsRemote( opener.remotePath ? path.common( opener.remotePath ) : opener.commonPath );
    _.assert( isRemote === true );
    /*
      xxx qqq :
        make it working for case when remote path is local
        for example : "git+hd:///module/-repo/Tools?out=out/wTools.out.will#master"
    */
  }

  if( isRemote && opener.superRelation )
  {
    opener._repoFormFormal();
  }
  else
  {
    opener._.localPath = opener.commonPath;

    if( opener.remotePath === null )
    {
      if( opener.isOut && opener.peerModule && opener.peerModule.remotePath )
      {
        downloadPath = opener._.downloadPath = opener.peerModule.downloadPath;
        remotePath = opener._.remotePath = opener.peerModule.peerRemotePathGet()
        // isRemote = opener.repoIsRemote();
        isRemote = will.pathIsRemote( opener.remotePath ? path.common( opener.remotePath ) : opener.commonPath );
      }
      else if( opener.isMain )
      {
        let localPath = fileProvider.path.localFromGlobal( opener.localPath )
        if( _.git.isRepository({ localPath }) )
        {
          downloadPath = opener._.downloadPath = fileProvider.path.detrail( opener._.localPath );
          let remotePathFromLocal = _.git.remotePathFromLocal({ localPath : opener.localPath });
          if( remotePathFromLocal !== null ) /* Dmytro : routine _.git.remotePathFromLocal returns null if no remote path exists */
          remotePathFromLocal = _.git.path.trail( remotePathFromLocal );
          remotePath = opener._.remotePath = remotePathFromLocal;
          // isRemote = opener.repoIsRemote();
          isRemote = will.pathIsRemote( opener.remotePath ? path.common( opener.remotePath ) : opener.commonPath );
        }
      }

      if( downloadPath )
      _.assert( !fileProvider.path.isTrailed( downloadPath ), `Download path of the ${opener.absoluteName} shouldn't have trailing slash.` );
    }

    if( !opener.repo || opener.repo.remotePath !== opener._.remotePath || opener.repo.downloadPath !== opener._.downloadPath )
    opener.repo = will.repoFrom
    ({
      isRemote,
      downloadPath : opener.downloadPath,
      remotePath : opener.remotePath,
    });
  }

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );
  _.assert( downloadPath === undefined || downloadPath === opener._.downloadPath );
  _.assert( remotePath === undefined || remotePath === opener._.remotePath );
  _.assert( opener.repo instanceof _.will.Repository );

  // if( opener.id === 1 )
  // debugger;

  if( opener.formed < 2 )
  opener.formed = 2;

  /*
    should goes after setting formed
  */

  will.junctionReform( opener );

  return opener;
}

//

function _repoFormFormal()
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

  let cloneDirPath = opener.superRelation.module.cloneDirPathGet();
  let parsed = remoteProvider.pathParse( willfilesPath );

  opener._.remotePath = willfilesPath;
  // opener._.downloadPath = path.resolve( cloneDirPath, opener.aliasName + fileProvider.path.upToken ); /* xxx : qqq : for Dmytro : investigate and find better way to solve problem with opener.downloadPath and module.downloadPath difference */
  opener._.downloadPath = path.resolve( cloneDirPath, opener.aliasName );

  let willfilesPath2 = path.resolve( cloneDirPath, opener.aliasName, parsed.localVcsPath );
  opener._.localPath = _.Will.CommonPathFor( willfilesPath2 );
  opener._filePathChanged2({ willfilesPath : willfilesPath2 });

  if( opener.peerModule && opener.peerModule.remotePath === null )
  {
    debugger;
    _.assert( 0, 'not tested' );
    _.assert( !!opener.peerModule.localPath );
    _.assert( !!opener.peerModule.opener );
    opener.peerModule.opener._.downloadPath = opener.downloadPath;
    opener.peerModule.opener._.remotePath =
    _.Will.RemotePathAdjust( opener.remotePath, path.relative( opener.localPath, opener.peerModule.localPath ) );
  }

  if( !opener.repo || opener.repo.remotePath !== opener._.remotePath || opener.repo.downloadPath !== opener._.downloadPath )
  opener.repo = will.repoFrom
  ({
    isRemote : true,
    remotePath : opener._.remotePath,
    downloadPath : opener._.downloadPath,
  });

  opener.repo.status({ all : 0, invalidating : 1, hasFiles : 1, isRepository : 1 });

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );

  return opener;
}

//

function _repoDownload( o )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let time = _.time.now();
  let downloading = null;
  let origin = null;
  let hasLocalChanges = null;
  let hasLocalUncommittedChanges = null;
  let isValid = null;
  let reopened = [];
  let dirStatusMap = Object.create( null );
  let status;
  let ready = _.take( null );
  let reflected = Object.create( null );
  let vcsTool = null;

  _.routineOptions( _repoDownload, o );
  _.assert( arguments.length === 1 );
  _.assert( opener.formed >= 2 );
  _.assert( !!opener.willfilesPath );
  _.assert( !o.strict || _.strDefined( opener.aliasName ) );
  _.assert( _.strDefined( opener.remotePath ) );
  _.assert( _.strDefined( opener.downloadPath ) );
  _.assert( _.strDefined( opener.localPath ) );
  _.assert( !o.strict || !!opener.superRelation );
  _.assert( _.longHas( [ 'download', 'update', 'agree' ], o.mode ) );

  return ready
  // .then( () => opener.repo.status({ all : 1, invalidating : 1 }) )
  .then( () =>
  {
    return opener.repo.status
    ({
      all : 1,
      invalidating : 1,
      isUpToDate : o.mode !== 'download',
      downloadRequired : o.mode === 'download',
      updateRequired : o.mode === 'update',
      agreeRequired : o.mode === 'agree',
    })
  })
  .then( function( arg )
  {
    status = arg;

    if( o.mode === 'download' )
    downloading = status.downloadRequired;
    else if( o.mode === 'update' )
    downloading = status.updateRequired;
    else if( o.mode === 'agree' )
    downloading = status.agreeRequired;

    _.assert( _.mapIs( status ) );
    _.assert( _.boolIs( downloading ) );

    if( o.mode === 'download' )
    {
      if( o.strict )
      {
        if( !opener.repo.hasFiles )
        filesCheck();
        if( opener.repo.hasFiles )
        repositoryCheck();
        if( opener.repo.hasFiles )
        moduleCheck();
      }
    }
    else if( o.mode === 'update' )
    {

      if( !opener.repo.hasFiles )
      filesCheck();
      if( opener.repo.hasFiles )
      repositoryCheck();
      if( opener.repo.hasFiles )
      moduleCheck();

      if( !downloading )
      return downloading;

      if( opener.repo.hasFiles && opener.repo.isRepository )
      originCheck();
      if( opener.repo.hasFiles && opener.repo.isRepository )
      localChangesCheck();

    }
    else if( o.mode === 'agree' )
    {
      if( !downloading )
      return downloading;

      // Vova: agree should delete module if origin is different, but not throw an error
      // if( opener.repo.hasFiles && opener.repo.isRepository )
      // originCheck();
      if( opener.repo.hasFiles && opener.repo.isRepository )
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
    /*
      create will module for npm module after download
    */

    vcsTool = will.vcsToolsFor( opener.repo.remotePath );
    if( downloading && !o.dry && vcsTool === _.npm )
    moduleNpmCreate();

    /* qqq : make optimal status updating after module is downloaded */
    if( downloading && !o.dry )
    openersReform();

    /*
      first reopen modules with the same local path
    */

    if( o.opening && !o.dry && downloading )
    return modulesReopen( 1 )
    return null;
  })
  .then( function( arg )
  {
    /*
      export npm module after download
    */

    if( downloading && !o.dry && vcsTool === _.npm )
    return opener.openedModule.moduleExport();
    return null;
  })
  .then( function( arg )
  {

    /*
      then copy files for modules with the different local paths
    */

    if( downloading && !o.dry )
    return modulesCopy();
    return null;
  })
  .then( function( arg )
  {

    /*
      then reopen modules with the different local paths
    */

    if( o.opening && !o.dry && downloading )
    return modulesReopen( 0 );
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
    _.assert( opener.repo.hasFiles === true );
    if( !opener.repo.isRepository )
    throw _.err
    (
      `Module ${opener.decoratedAbsoluteName} is downloaded, but it's not a git repository or npm module.\n`,
      'Rename/remove path:', _.color.strFormat( opener.downloadPath, 'path' ), 'and try again.'
    );
  }

  /* */

  function moduleCheck()
  {
    _.assert( opener.repo.hasFiles );
    if( !isValidReform() )
    throw _.err( opener.error, `\nModule ${opener.decoratedAbsoluteName} is downloaded, but it's not valid` );
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

    _.assert( downloading === true );
    _.assert( opener.repo.hasFiles === true );
    _.assert( opener.repo.isRepository === true );

    if( hasLocalUncommittedChangesReform() )
    throw _.errBrief
    (
      'Module at', opener.decoratedAbsoluteName, 'needs to be updated, but has local changes.',
      '\nPlease commit your local changes or stash them and merge manually after update.'
    );

  }

  /* */

  function hasLocalUncommittedChangesReform() /* xxx */
  {
    if( hasLocalUncommittedChanges !== null )
    return hasLocalUncommittedChanges;
    // hasLocalChanges = opener.repoHasLocalChanges();
    hasLocalUncommittedChanges = opener.repo.hasLocalUncommittedChanges;
    _.assert( _.boolIs( hasLocalUncommittedChanges ) );
    return hasLocalUncommittedChanges;
  }

  /* */

  function originCheck()
  {

    _.assert( downloading === true );
    _.assert( opener.repo.hasFiles === true );
    _.assert( opener.repo.isRepository === true );

    remoteIsValidReform();

    if( !origin.remoteIsValid )
    throw _.err
    (
      'Module', opener.decoratedAbsoluteName, 'is already downloaded, but has different origin url:',
      _.color.strFormat( origin.originVcsPath, 'path' ), ', expected url:', _.color.strFormat( origin.remoteVcsPath, 'path' )
    );

  }

  /* */

  function remoteIsValidReform()
  {

    if( origin !== null )
    return origin;

    let gitProvider = will.fileProvider.providerForPath( opener.remotePath );

    origin = gitProvider.hasRemote
    ({
      localPath : opener.downloadPath,
      remotePath : _.strRemoveEnd( opener.remotePath, path.upToken ),
      // remotePath : opener.remotePath,
    });

    return origin;
  }

  /* */

  function filesCheck()
  {
    _.assert( opener.repo.hasFiles === false );

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

    _.assert( downloading === true );

    let isRepository = opener.repo.isRepository;
    _.assert( _.boolIs( isRepository ) );
    if( !isRepository )
    return end( true );

    let isValid = isValidReform();
    _.assert( _.boolIs( isValid ) );
    if( !isValid )
    return end( true );

    remoteIsValidReform();
    _.assert( _.boolIs( origin.remoteIsValid ) );
    if( !origin.remoteIsValid )
    return end( true );

    return end( false );

    function end( deleting )
    {
      _.assert( _.boolIs( deleting ) );
      if( deleting )
      {
        safeToDeleteCheck();
        fileProvider.filesDelete({ filePath : opener.downloadPath, throwing : 0, sync : 1 });
      }
      return deleting;
    }

    function safeToDeleteCheck()
    {
      if( opener.repo.isRepository )
      if( !opener.repo.safeToDelete )
      {
        _.assert( opener.repo.hasLocalChanges === true );
        throw _.errBrief
        (
          'Module at', opener.decoratedAbsoluteName, `needs to be deleted, but has local changes.`,
          '\nPlease commit and push your local changes and try again.'
        );
      }

      _.assert( opener.repo.hasLocalChanges === false );
    }

  }

  /* */

  function filesDownload()
  {

    let o2 =
    {
      reflectMap : { [ opener.remotePath ] : opener.downloadPath },
      verbosity : will.verbosity - 5,
      extra :
      {
        fetching : 0
      },
    }

    if( o.mode === 'update' )
    {
      let vscTools = will.vcsToolsFor( opener.remotePath );
      _.assert( !!vscTools )
      if( _.longHas( vscTools.protocols, 'git' ) )
      o2.extra.fetchingTags = 1;
    }

    if( downloading && !o.dry )
    return _.will.Predefined.filesReflect.call( fileProvider, o2 );

    return null;
  }

  /* */

  function openersReform()
  {
    _.assert( !o.dry );
    _.assert( !!downloading );

    let junction = will.junctionReform( opener );
    junction.openers.forEach( ( opener2 ) =>
    {
      opener2.repo.statusInvalidate({ all : 1 });
      // if( downloading && !o.dry )
      // {
      // opener2.repo._.hasFiles = true;
      // opener2.repo.statusInvalidate({ all : 1, hasFiles : 1 });
      // }
    });

    return null;
  }

  /* */

  function modulesCopy()
  {
    let ready = _.take( null );
    let junction = will.junctionFrom( opener );

    junction.openers.forEach( ( opener2 ) =>
    {
      ready.also( moduleCopy( opener2 ) );
    });

    if( junction.peer )
    junction.peer.openers.forEach( ( opener2 ) =>
    {
      ready.also( moduleCopy( opener2 ) );
    });

    ready.finally( ( err, arg ) =>
    {
      if( err )
      throw err;
      return arg;
    });

    return ready;
  }

  /* */

  function moduleCopy( opener2 )
  {

    _.assert( _.strIs( opener.downloadPath ) );
    _.assert( _.strIs( opener2.downloadPath ) );

    if( opener2.downloadPath === opener.downloadPath )
    return null;

    return dirStatus( opener2 ).then( ( status ) =>
    {
      _.assert( _.boolIs( status.required ) );
      _.assert( _.boolIs( status.safeToDelete ) );
      if( reflected[ opener2.downloadPath ] )
      return null;
      if( !status.required )
      return null;
      if( !status.safeToDelete )
      throw _.err
      (
        `Can't ${o.mode} ${module.qualifiedName} at ${module.localPath}, because it has local changes.`,
        ` Please commit changes or delete it manually.`
      );
      reflected[ opener2.downloadPath ] = true;
      if( will.verbosity >= 3 )
      logger.log( ` + Reflected ${path.moveTextualReport( opener2.downloadPath, opener.downloadPath )}` );
      let filter = { filePath : { [ opener.downloadPath ] : opener2.downloadPath } }
      return fileProvider.filesReflect({ filter, dstRewritingOnlyPreserving : 1, linking : 'hardLink' });
    });
  }

  /* */

  function modulesReopen( same )
  {
    let ready = _.take( null );
    let junction = will.junctionFrom( opener );
    _.assert( !junction.isFinited() );

    junction.reform();

    junction.openers.forEach( ( opener2 ) =>
    {
      ready.then( () => moduleReopenMaybe( opener2, same ) );
    });

    if( junction.peer )
    junction.peer.openers.forEach( ( opener2 ) =>
    {
      ready.then( () => moduleReopenMaybe( opener2, same ) );
    });

    return ready;
  }

  /* */

  function moduleReopenMaybe( opener2, same )
  {

    if( ( opener2.downloadPath === opener.downloadPath ) ^ same )
    return null;

    if( _.longHas( reopened, opener2 ) )
    return null;

    if( same )
    return moduleReopen( opener2 );
    else
    return dirStatus( opener2 ).then( ( status ) =>
    {
      _.assert( _.boolIs( status.required ) )
      if( !status.required )
      return null;
      return moduleReopen( opener2 );
      return null;
    });

  }

  /* */

  function moduleReopen( opener2 )
  {
    return opener2.reopen().then( ( arg ) =>
    {
      _.arrayAppendOnce( reopened, opener2 );
      opener2.openedModule.userArray.forEach( ( opener3 ) =>
      {
        _.arrayAppendOnce( reopened, opener3 );
      });
      if( opener2.openedModule.peerModule )
      opener2.openedModule.peerModule.userArray.forEach( ( opener3 ) =>
      {
        _.arrayAppendOnce( reopened, opener3 );
      });
      return arg;
    })
  }

  /* */

  function moduleNpmCreate()
  {
    let willFilePath = path.join( path.dir( opener.repo.downloadPath ), opener.aliasName + '.will.yml' );

    let packageJsonPath = path.join( opener.repo.downloadPath, 'package.json' );
    let packageJson = fileProvider.fileRead({ filePath : packageJsonPath, encoding : 'json' });
    let includeAny = path.s.dot( packageJson.files );

    let willFile =
`
about :

  name : ${opener.aliasName}

path :

  in : ${opener.aliasName}

reflector :

  files :
     src :
       filePath : path::in
       maskAll :
         includeAny : [ ${includeAny.join( ', ' )} ]

step :

  export :
    inherit : module.export
    export : reflector::files
    tar : 0

build :

  export :
    criterion :
      default : 1
      export : 1
    steps :
      step::export
`
    fileProvider.fileWrite( willFilePath, willFile ); debugger; /* xxx */
  }

  /* */

  function dirStatus( opener2 )
  {

    _.assert( _.strIs( opener2.downloadPath ) );

    if( dirStatusMap[ opener2.downloadPath ] )
    return new _.Consequence().take( dirStatusMap[ opener2.downloadPath ] );

    let ready = _.take( null );

    ready.then( ( arg ) =>
    {
      return opener2.repo.status({ all : 1, invalidating : 1, isRepository : 1 });
    });
    ready.then( ( status ) =>
    {

      if( o.mode === 'download' )
      status.required = status.downloadRequired;
      else if( o.mode === 'update' )
      status.required = status.updateRequired;
      else if( o.mode === 'agree' )
      status.required = status.agreeRequired;
      status.downloadPath = opener2.downloadPath;

      dirStatusMap[ opener2.downloadPath ] = status;
      return status;
    });

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
        phrase = 'updated to';
        else if( o.mode === 'agree' )
        phrase = 'agreed with';
        else if( o.mode === 'download' )
        phrase = 'downloaded';
        logger.log( ` + ${module.decoratedQualifiedName} will be ${phrase} ${_.color.strFormat( version, 'path' )} in ${_.time.spent( time )}` );
        // logger.log( ' + ' + module.decoratedQualifiedName + ' will be ' + ( o.mode + phrase ) + ' version ' + _.color.strFormat( version, 'path' ) );
      }
      else
      {
        let remoteProvider = fileProvider.providerForPath( opener.remotePath );
        let version = remoteProvider.versionLocalRetrive( opener.downloadPath );
        let phrase = '';
        if( o.mode === 'update' )
        phrase = 'was updated to version';
        else if( o.mode === 'agree' )
        phrase = 'was agreed with version';
        else if( o.mode === 'download' )
        phrase = 'was downloaded version';
        logger.log( ` + ${module.decoratedQualifiedName} ${phrase} ${_.color.strFormat( version, 'path' )} in ${_.time.spent( time )}` );
      }
    }
  }

  /* */
}

_repoDownload.defaults =
{
  mode : 'download',
  dry : 0,
  opening : 1,
  recursive : 0,
  strict : 1
}

//

function repoDownload( o )
{
  let opener = this;
  let will = opener.will;
  o = o || Object.create( null );
  _.routineOptions( repoDownload, o );
  return opener._repoDownload( o );
}

var defaults = repoDownload.defaults = _.mapExtend( null, _repoDownload.defaults );
defaults.mode = 'download';

//

function repoUpdate( o )
{
  let opener = this;
  let will = opener.will;
  o = o || Object.create( null );
  _.routineOptions( repoUpdate, o );
  return opener._repoDownload( o );
}

var defaults = repoUpdate.defaults = _.mapExtend( null, _repoDownload.defaults );
defaults.mode = 'update';

// --
// path
// --

function _pathChanged( o )
{
  let opener = this;
  let will = opener.will;

  _.assert( o.val !== undefined );
  _.routineOptions( _pathChanged, arguments );

  if( o.isIdentical === null )
  o.isIdentical = o.ex === o.val || _.path.map.identical( o.ex, o.val );
  // o.isIdentical = o.ex === o.val || _.entityIdentical( o.ex, o.val );

  _.assert( opener.__[ o.name ] !== undefined );
  opener.__[ o.name ] = o.val;

  if( will && opener.openedModule )
  if( o.touching )
  if( !o.isIdentical )
  {
    debugger;
    let o2 = _.mapExtend( null, o );
    o2.touching = 0;
    opener.openedModule._pathChanged( o2 );
  }

}

_pathChanged.defaults =
{
  name : null,
  ex : null,
  val : null,
  isIdentical : null,
  touching : 9,
}

//

function _filePathChanged1( o )
{
  let opener = this;

  if( !this.will )
  return o;

  _.assert( o.willfilesPath !== undefined );
  o = opener._filePathChanged2( o );

  if( !o.isIdentical )
  if( opener.formed && opener.formed < 3 )
  {
    opener._repoForm();
  }

  if( opener.openedModule && !o.isIdentical )
  debugger;
  if( opener.openedModule && !o.isIdentical )
  opener.openedModule._filePathChanged2({ willfilesPath : o.willfilesPath });

  return o;
}

_filePathChanged1.defaults = _.mapExtend( null, Parent.prototype._filePathChanged1.defaults );

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

    if( o.localPath )
    {
      _.assert( _.strIs( o.localPath ) && !path.isGlobal( o.localPath ) );
      opener._.localPath = o.localPath;
    }
  }

  if( !o.isIdentical )
  if( opener.willfilesPath && opener.commonPath && opener.formed >= 2 )
  {
    will.junctionReform( opener );
  }

  return o;
}

_filePathChanged2.defaults = _.mapExtend( null, Parent.prototype._filePathChanged2.defaults );

//

function willfilesPathSet( filePath )
{
  let opener = this;
  let module = opener.openedModule;
  let will = opener.will;

  opener._filePathChanged1({ willfilesPath : filePath });

}

//

function remotePathSet( src )
{
  let opener = this;
  let module = opener.openedModule;
  let will = opener.will;

  if( opener.__.remotePath === src )
  {
    _.assert( !opener.openedModule || opener.openedModule.remotePath === src );
    return;
  }

  opener.remotePathPut( src );
  if( opener.openedModule )
  {
    opener.openedModule.remotePath = src;
    _.assert( opener.openedModule.remotePath === src );
  }

}

//

function remotePathPut( val )
{
  let opener = this;
  let will = opener.will;
  let module = opener.openedModule;
  let ex = opener.__.remotePath;

  if( val === ex )
  return val;

  opener.__.remotePath = val;

  // _.assert( !module || module.remotePath === val );

  if( will )
  will._pathChanged
  ({
    object : opener,
    propName : 'remotePath',
    val,
    ex,
    kind : 'put',
  });

  return val;
}

//

function remotePathEachAdoptAct( o )
{
  let opener = this;
  let will = opener.will;
  // let junction = will.junctionOf( module ); /* xxx : optimize junctionFrom */
  // if( !junction )
  // junction = will.junctionFrom( module );
  //
  // _.assertRoutineOptions( remotePathEachAdoptAct, o );
  //
  // junction.modules.forEach( ( module ) => module.remotePathAdopt( o ) );
  // junction.openers.forEach( ( opener ) => opener.remotePathAdopt( o ) );
  // junction.reform();

  _.assertRoutineOptions( remotePathEachAdoptAct, o );

  opener.remotePathAdopt( o );

  if( opener.openedModule )
  moduleAdoptPath( opener.openedModule );

  // if( opener.peerModule )
  // moduleAdoptPath( opener.peerModule );

  return true;

  function moduleAdoptPath( module )
  {
    debugger;
    module.remotePathAdopt( o );
    module.userArray.forEach( ( opener2 ) =>
    {
      if( opener2 === opener )
      return;
      if( !( opener2 instanceof _.will.ModuleOpener ) )
      return;
      opener2.remotePathAdopt( o );
    });
  }
}

remotePathEachAdoptAct.defaults =
{
  ... Parent.prototype.remotePathAdopt.defaults,
}

//

function remotePathChangeVersionTo( to )
{
  let opener = this;
  let will = opener.will;

  _.assert( arguments.length === 1 );
  _.assert( _.strDefined( to ) );
  _.sure( _.strBegins( to, '!' ) || _.strBegins( to, '#' ), `Argument "to" should begins with "!" or "#" Got:${to}` )

  var vcs = will.vcsToolsFor( opener.remotePath );
  // var remoteParsed = vcs.pathParse( opener.remotePath )
  var remoteParsed = vcs.path.parse({ remotePath : opener.remotePath, full : 1, atomic : 0 })

  var globalTo = vcs.path.globalFromPreferred( to );
  // var toParsed = vcs.pathParse( globalTo );
  var toParsed = vcs.path.parse({ remotePath : globalTo, full : 1, atomic : 0 })

  if( toParsed.tag )
  {
    remoteParsed.tag = toParsed.tag;
    remoteParsed.hash = null;
  }
  else if( toParsed.hash )
  {
    remoteParsed.tag = null;
    remoteParsed.hash = toParsed.hash;
  }
  else
  {
    throw _.err( `Argument "to" should be either tag or version. Got:${to}` );
  }

  /*
     Dmytro : new path namespaces _.git and _.npm parse and change not paths
     _.[git|npm].path.str( _.[git|npm]path.parse( src ) ) === src
     but old realization used changed paths

     We need to remove last slash to get untrailed remote path
     git+https:///github.com/user/repo.git/!tag => git+hd:///local/repo!tag
  */
  remoteParsed.longPath = _.strRemoveEnd( remoteParsed.longPath, vcs.path.upToken );

  let remotePathNew = vcs.path.str( remoteParsed );

  opener.remotePathSet( remotePathNew );
  opener.repo.remotePathChange( remotePathNew );

  return true;
}

//

function sharedFieldPut_functor( propName )
{
  let symbol = Symbol.for( propName );

  return function put( val )
  {
    let opener = this;
    let will = opener.will;
    let module = opener.openedModule;
    let ex = opener[ symbol ];

    opener[ symbol ] = val;

    _.assert( !module || module[ propName ] === val );

    if( will )
    will._pathChanged
    ({
      object : opener,
      propName,
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

let _willfilesPathPut = sharedFieldPut_functor( 'willfilesPath' );
let _dirPathPut = sharedFieldPut_functor( 'dirPath' );
let _commonPathPut = sharedFieldPut_functor( 'commonPath' );
let _downloadPathPut = sharedFieldPut_functor( 'downloadPath' );
let _localPathPut = sharedFieldPut_functor( 'localPath' );

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

function errorGet()
{
  let opener = this;
  return opener[ errorSymbol ];
}

//

function errorSet( err )
{
  let opener = this;
  let will = opener.will;

  if( opener.error === err )
  return;

  // if( err && opener.commonPath && _.strHas( opener.commonPath, 'ModuleForTesting12ab' ) )
  // debugger;
  // if( err )
  // debugger;

  opener[ errorSymbol ] = err; /* xxx qqq : replace */

  if( will && err )
  {
    let r = Object.create( null );
    r.err = err;
    r.opener = opener;
    r.localPath = opener.localPath;
    will.openersErrorsArray.push( r );
    will.openersErrorsMap[ r.localPath ] = r;
  }

  return err;
}

//

function isAliveGet()
{
  let opener = this;
  return opener.formed >= 1;
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

  if( src )
  will.mainOpener = opener;
  else if( will.mainOpener === opener )
  will.mainOpener = null;

  return src;
}

//

function accessorGet_functor( propName )
{
  let symbol = Symbol.for( propName );

  return function accessorGet()
  {
    let opener = this;
    let openedModule = opener.openedModule;

    if( openedModule )
    return openedModule[ propName ];

    let result = opener[ symbol ];

    return result;
  }

}

//

function accessorSet_functor( propName )
{
  let symbol = Symbol.for( propName );

  return function accessorSet( val )
  {
    let opener = this;
    let openedModule = opener.openedModule;

    _.assert( _.boolIs( val ) || val === null );

    opener[ symbol ] = val;
    if( openedModule )
    openedModule[ propName ] = val;

    return val;
  }

}

let isOutGet = accessorGet_functor( 'isOut' );
let isOutSet = accessorSet_functor( 'isOut' );

// --
// coercer
// --

function toModuleForResolver()
{
  let opener = this;
  return opener.toModule();
}

//

function toModule()
{
  let opener = this;
  let will = opener.will;
  if( opener.openedModule )
  return opener.openedModule;
  return null;
}

//

function toOpener()
{
  let opener = this;
  let will = opener.will;
  return opener;
}

//

function toRelation()
{
  let opener = this;
  let will = opener.will;
  return opener.superRelation;
}

//

function toJunction()
{
  let opener = this;
  let will = opener.will;
  return will.junctionFrom( opener );
}

// --
// export
// --

/* qqq : write test */
function exportString( o )
{
  let opener = this;
  let will = opener.will;
  let result = '';

  o = _.routineOptions( exportString, arguments );

  if( o.verbosity >= 1 )
  result += opener.decoratedAbsoluteName + '#' + opener.id;

  if( o.verbosity >= 2 )
  {
    let fields = Object.create( null );
    fields.remote = opener.remotePath;
    fields.local = opener.localPath;
    fields.download = opener.downloadPath;
    result += '\n' + _.entity.exportStringNice( fields );
  }

  return result;
}

exportString.defaults =
{
  verbosity : 2,
  it : null,
}

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

  isMain : null,
  isAuto : null,

  reason : null,
  searching : 'strict', /* 'smart', 'strict', 'exact' */

}

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
_.assert( !!_.accessor.getter.toStructure.identity.functor );

let Accessors =
{

  _ : { get : _.accessor.getter.toStructure, writable : 0, strict : 0 },

  willfilesPath : { get : willfilesPathGet, set : willfilesPathSet },
  dirPath : { get : dirPathGet, writable : 0 },
  commonPath : { get : commonPathGet, writable : 0 },
  localPath : { get : localPathGet, writable : 0 },
  downloadPath : { get : downloadPathGet, writable : 0 },
  remotePath : { get : remotePathGet, set : remotePathSet },

  name : { get : nameGet, writable : 0 },
  aliasName : { set : aliasNameSet },
  absoluteName : { get : absoluteNameGet, writable : 0 },
  qualifiedName : { get : qualifiedNameGet, combining : 'rewrite', writable : 0 },

  isOut : { get : isOutGet, set : isOutSet },
  isMain : { get : isMainGet, set : isMainSet },

  superRelation : {},
  rootModule : {},
  openedModule : {},
  peerModule : {},

  error : { set : errorSet, get : errorGet, },

}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,

  optionsForModuleExport,
  precopy,
  copy,
  clone,
  cloneExtending,

  // former

  unform,
  preform,

  // relator

  isUsed,
  usersGet,
  own,

  // willfile

  willfileUnregister,
  willfileRegister,
  _willfilesFindAct,
  _willfilesFind,

  // opener

  /* xxx : split looking for the willfiles algorithm into a separate module */

  close,
  find,
  open,
  reopen,

  isOpened,
  isValid,

  // module

  moduleAdopt,
  openedModuleSet,
  moduleUsePaths,
  moduleUseError,
  submodulesRelationsFilter,
  submodulesRelationsOwnFilter,

  // submodule

  peerModuleGet,
  peerModuleSet,
  rootModuleGet,
  rootModuleSet,
  superRelationGet,
  superRelationSet,

  // repo

  _repoForm,
  _repoFormFormal,
  _repoDownload,
  repoDownload,
  repoUpdate,

  // path

  _pathChanged,
  _filePathChanged1,
  _filePathChanged2,

  willfilesPathGet,
  dirPathGet,
  commonPathGet,

  downloadPathGet,
  localPathGet,
  remotePathGet,

  willfilesPathSet,
  remotePathSet,

  _willfilesPathPut,
  _dirPathPut,
  _commonPathPut,
  _downloadPathPut,
  _localPathPut,
  remotePathPut,
  remotePathEachAdoptAct,
  remotePathChangeVersionTo,

  // name

  nameGet,
  _nameChanged,
  aliasNameSet,
  absoluteNameGet,
  shortNameArrayGet,

  // other accessor

  errorGet,
  errorSet,

  isAliveGet,
  isPreformed,
  isMainGet,
  isMainSet,
  isOutGet,
  isOutSet,

  // coercer

  toModuleForResolver,
  toModule,
  toOpener,
  toRelation,
  toJunction,

  // export

  exportString,

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
