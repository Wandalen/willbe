( function _Module_s_( ) {

'use strict';

/*

                                                              download update agree verify
  download directory is empty/not present ( - hasFiles )        d        d      d      -
  has files which are not repository( - isRepository )          e        e      rd     -
  origin is different( - hasRemote )                            -        e      rd     -
  module has local changes( - localChanges )                    -        e      e      .
  module is not valid( - isValid )                              e        e      rd     -
  module is on different branch( - isUpToDate )                 -        c      c      -
  module is not up to date( - isUpToDate )                      -        u      u      .

  d - downloads module
  r - removes module
  u - updates module
  c - changes branch
  e - error
  . - nothing
  - - false
  + - true

  Note: verify throws an error if result of check is false and throwing is enabled
*/

let _ = _global_.wTools;
let Parent = _.will.AbstractModule;
let Self = wWillModule;
function wWillModule( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Module';

// --
// inter
// --

function finit()
{
  let module = this;
  let will = module.will;
  let rootModule = module.rootModule;
  let logger = will.logger;

  if( will.verosity >= 5 )
  logger.log( module.qualifiedName, 'finit.begin' );

  _.assert( !module.isFinited() );

  // if( module.id === 1004 )
  // debugger;

  try
  {

    if( module.peerModule )
    {
      let peerModule = module.peerModule;
      _.assert( !peerModule.isFinited() );
      _.assert( peerModule.peerModule === module );
      peerModule.peerModule = null;
      module.peerModule = null;
      if( !peerModule.isUsedManually() )
      peerModule.finit();
    }

    let userArray = module.userArray.slice();
    userArray.forEach( ( opener ) =>
    {
      opener.openedModule = null;
    });
    _.assert( module.userArray.length === 0 );
    userArray.forEach( ( opener ) =>
    {
      /* xxx */
      if( opener.isUsedManually() || !opener.isAuto )
      opener.close();
      else
      opener.finit();
    });

    module.unform();

  }
  catch( err )
  {
    logger.error( _.errOnce( err ) );
    debugger;
  }

  try
  {

    module._nameUnregister();
    module.about.finit();

    let finited = _.err( 'Finited' );
    _.errAttend( finited );
    finited.finited = true;
    module.stager.cancel();
    module.stager.stagesState( 'skipping', true );
    module.stager.stageError( 'finalFormed', finited );

    if( module.peerModule )
    {
      let peerModule = module.peerModule;
      _.assert( peerModule.peerModule === module );
      peerModule.peerModule = null;
      module.peerModule = null;
      if( !peerModule.isUsedManually() )
      peerModule.finit();
    }

  }
  catch( err )
  {
    logger.error( _.errOnce( err ) );
    debugger;
  }

  _.assert( Object.keys( module.exportedMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.pathResourceMap ).length === 0 );
  _.assert( Object.keys( module.submoduleMap ).length === 0 );
  _.assert( _.workpiece.isFinited( module.about ) );

  let result = Parent.prototype.finit.apply( module, arguments );

  if( will.verosity >= 5 )
  logger.log( module.qualifiedName, 'finit.end' );

  return result;
}

//

function init( o )
{
  let module = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  module.pathResourceMap = module.pathResourceMap || Object.create( null );

  Parent.prototype.init.call( module );

  module.precopy1( o );

  let will = o.will;
  let logger = will.logger;
  _.assert( !!will );

  module.stager = new _.Stager
  ({
    object :            module,
    verbosity :         Math.max( Math.min( will.verbosity, will.verboseStaging ), will.verbosity - 6 ),
    stageNames :        [ 'preformed',        'opened',             'attachedWillfilesFormed',      'peerModulesFormed',        'subModulesFormed',                 'resourcesFormed',          'finalFormed' ],
    consequences :      [ 'preformReady',     'openedReady',        'attachedWillfilesFormReady',   'peerModulesFormReady',     'subModulesFormReady',              'resourcesFormReady',       'ready' ],
    onPerform :         [ '_preform',         '_willfilesOpen',     '_attachedWillfilesForm',       '_peerModulesForm',         '_subModulesForm',                  '_resourcesForm',           null ],
    onBegin :           [ '_performBegin',    null,                 null,                           null,                       null,                               null,                       null ],
    onEnd :             [ null,               '_willfilesOpenEnd',  null,                           null,                       null, /*module._willfilesReadEnd,*/ null,                       module._formEnd ],
  });

  module.stager.stageStatePausing( 'opened', 1 );
  module.stager.stageStateSkipping( 'resourcesFormed', 1 );

  module.predefinedForm();
  module.moduleWithNameMap = Object.create( null );

  _.assert( !!o );
  if( o )
  module.copy( o );

  if( module.willfilesPath === null )
  module.willfilesPath = _.select( module.willfilesArray, '*/filePath' );

  module._nameChanged();

  if( will.verosity >= 5 )
  logger.log( module.qualifiedName, 'init' );

}

//

function precopy1( o )
{
  let module = this;

  if( !module.rootModule && !o.rootModule )
  o.rootModule = module;

  if( o.will !== undefined )
  module.will = o.will;
  if( o.superRelations !== undefined )
  module.superRelations = o.superRelations;
  if( o.original !== undefined )
  module.original = o.original;
  if( o.rootModule !== undefined )
  module.rootModule = o.rootModule;

  return o;
}

//

function precopy2( o )
{
  let module = this;

  if( !module.rootModule && !o.rootModule )
  o.rootModule = module;

  if( o.will )
  module.will = o.will;
  if( o.repo )
  module.repo = o.repo;

  if( o.isOut !== undefined )
  module.isOut = o.isOut;
  if( o.inPath !== undefined )
  module.inPath = o.inPath;
  if( o.outPath !== undefined )
  module.outPath = o.outPath;

  if( o.about )
  module.about = o.about;
  if( o.pathResourceMap )
  module.pathResourceMap = o.pathResourceMap;

  if( o.localPath !== undefined )
  module._localPathPut( o.localPath );
  if( o.commonPath !== undefined )
  module._commonPathPut( o.commonPath );
  if( o.downloadPath !== undefined )
  module.downloadPath = o.downloadPath;
  if( o.remotePath !== undefined )
  module.remotePath = o.remotePath;
  if( o.willfilesPath !== undefined )
  module.willfilesPath = o.willfilesPath;

  o = _.mapExtend( null, o );

  delete o.isRemote;
  delete o.isOut;
  delete o.inPath;
  delete o.outPath;
  delete o.localPath;
  delete o.commonPath;
  delete o.downloadPath;
  delete o.remotePath;
  delete o.willfilesPath;
  delete o.pathResourceMap;

  return o;
}

//

function precopy( o )
{
  let module = this;

  o = module.precopy1( o );
  o = module.precopy2( o );

  return o;
}

//

function postcopy( o )
{
  let module = this;

  let names =
  {
  }

  for( let n in names )
  {
    if( o[ n ] !== undefined )
    module[ n ] = o[ n ];
  }

  return o;
}

//

function copy( o )
{
  let module = this;

  _.assert( arguments.length === 1 );

  o = module.precopy( o );

  let result = _.Copyable.prototype.copy.apply( module, [ o ] );

  module.postcopy( o );

  return result;
}

//

function clone()
{
  let module = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  let result = module.cloneExtending({});

  return result;
}

//

function cloneExtending( o )
{
  let module = this;

  _.assert( arguments.length === 1 );

  if( o.original === undefined )
  o.original = module.original || module;

  if( o.willfilesArray === undefined )
  o.willfilesArray = [];

  let result = _.Copyable.prototype.cloneExtending.call( module, o );

  _.assert( !result.superRelations || result.superRelations !== module.superRelations );

  return result;
}

//

function outModuleMake( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routineOptions( outModuleMake, arguments );

  _.assert( module.original === null );
  _.assert( !module.isOut );
  _.assert( !!module.pathMap[ 'module.original.willfiles' ] );
  _.assert( !!module.pathMap[ 'module.peer.willfiles' ] );
  _.assert( !!module.pathMap[ 'module.peer.in' ] );
  _.assert( !!module.pathMap[ 'module.willfiles' ] );
  _.assert( module.pathMap[ 'module.peer.willfiles' ] !== module.pathMap[ 'module.willfiles' ] );

  o.willfilesPath = o.willfilesPath || module.outfilePathGet();

  let moduleWas = will.moduleWithCommonPathMap[ _.Will.CommonPathFor( o.willfilesPath ) ];
  if( moduleWas )
  {
    debugger;
    _.assert( 0, 'not tested' );
    _.assert( moduleWas.peerModule === module );
    _.assert( moduleWas === module.peerModule );
    moduleWas.peerModule = null;
    _.assert( moduleWas.peerModule === null );
    _.assert( module.peerModule === null );
    moduleWas.finit();
    _.assert( moduleWas.isFinited() );
    _.assert( !module.isFinited() );
    moduleWas = null;
  }

  if( moduleWas )
  {
    _.assert( moduleWas.isValid() );
  }

  let opener2 = openerMake();

  /* */

  _.assert( opener2.original === null );

  let o3 = opener2.optionsForModuleExport();
  o3.original = null;
  _.assert( o3.superRelations === null );
  let rootModule = o3.rootModule = opener2.rootModule;
  let module2 = module.cloneExtending( o3 );

  _.assert( module2.original === null );
  _.assert( rootModule === opener2.rootModule );
  _.assert( rootModule === module2.rootModule );
  opener2.moduleAdopt( module2 );
  _.assert( rootModule === opener2.rootModule );
  _.assert( rootModule === opener2.openedModule.rootModule );
  _.assert( opener2.commonPath === opener2.localPath );
  _.assert( module2.commonPath === module2.localPath );

  /* */

  module2.pathsRebase({ inPath : module.outPath, exInPath : module.inPath });

  _.assert( module.outPath === module2.outPath );
  _.assert( module2.inPath === module2.outPath );
  _.assert( module2.dirPath === path.detrail( module.outPath ) );
  _.assert( module2.commonPath === module2.localPath );
  _.assert( module2.original === null );
  _.assert( module2.rootModule === module.rootModule );
  _.assert( module2.willfilesArray.length === 0 );
  _.assert( module2.pathResourceMap.in.path === '.' );
  _.assert( module2.peerModule === module );
  _.assert( module.peerModule === module2 );
  _.assert( opener2.peerModule === module );
  _.assert( opener2.dirPath === path.detrail( module.outPath ) );
  _.assert( opener2.superRelation === null );
  _.assert( opener2.willfilesArray.length === 0 );

  _.assert( !!module2.pathMap[ 'module.original.willfiles' ] );
  _.assert( !!module2.pathMap[ 'module.peer.willfiles' ] );
  _.assert( !!module2.pathMap[ 'module.peer.in' ] );
  _.assert( !!module2.pathMap[ 'module.willfiles' ] );
  _.assert( _.entityIdentical( module2.pathMap[ 'module.original.willfiles' ], module2.pathMap[ 'module.peer.willfiles' ] ) );
  _.assert( !_.entityIdentical( module2.pathMap[ 'module.willfiles' ], module2.pathMap[ 'module.peer.willfiles' ] ) );

  module2.stager.stageStateSkipping( 'opened', 1 );
  module2.stager.stageStatePausing( 'opened', 0 );
  module2.stager.tick();

  _.assert( !!module2.ready.resourcesCount() );

  if( module2.ready.errorsCount() )
  module2.ready.sync();

  will.openersAdoptModule( module2 );

  /* zzz : temp */
  module.assertIsValidIntegrity();
  module2.assertIsValidIntegrity();

  return module2;

  /* */

  function openerMake()
  {

    let o2 = module.optionsForOpenerExport();
    o2.willfilesPath = o.willfilesPath;
    o2.willfilesArray = [];
    o2.isOut = true;
    o2.peerModule = module;
    o2.searching = 'exact';
    o2.reason = 'export';
    o2.isAuto = 1;
    o2.remotePath = null; // xxx

    let opener2 = will._openerMake({ opener : o2 });
    _.assert( opener2.isOut === true );
    _.assert( opener2.superRelation === null );
    _.assert( opener2.rootModule === null );
    _.assert( opener2.openedModule === null );
    _.assert( opener2.willfilesArray.length === 0 );
    _.assert( opener2.peerModule === module );

    opener2.rootModule = module.rootModule || module;
    opener2.preform();

    return opener2;
  }

  /* */

}

outModuleMake.defaults =
{
  willfilesPath : null,
}

//

function outModuleOpen( o )
{
  let module = this;
  let will = module.will;

  o = _.routineOptions( outModuleOpen, arguments );
  o.willfilesPath = o.willfilesPath || module.outfilePathGet();

  let o2 =
  {
    willfilesPath : o.willfilesPath,
    rootModule : module.rootModule,
    searching : 'exact',
    reason : 'export',
    peerModule : module,
  }

  let opener2 = will._openerMake({ opener : o2 })
  opener2.preform();
  opener2.find({ throwing : 0 });

  return opener2.open({ throwing : 1, all : 0 })
  .then( ( module2 ) =>
  {

    if( opener2.error )
    throw opener2.error;

    _.assert( !!will.formed );
    _.assert( opener2.peerModule === module );
    _.assert( module2.peerModule === module );
    _.assert( module.peerModule === module2 );

    if( !opener2.openedModule.isValid() )
    {
      logger.log( _.errBrief( `Module ${opener2.absoluteName} was not valid` ) );
      return module2;
    }

    if( !opener2.openedModule.isConsistent() )
    {
      debugger;
      opener2.error = _.errBrief( `Module ${opener2.absoluteName} was not consistent, please export it` );
      logger.log( opener2.error );
      return module2;
    }

    return module2;
  })
  .finally( ( err, module2 ) =>
  {

    err = err || opener2.error;

    if( err )
    {
      err = _.err( err, `\nFailed to read exported out-willfile ${opener2.willfilesPath} to extend it` );
      let requireVerbosity = 5;
      /* xxx : refactor */
      if( _.strIs( err.originalMessage ) )
      if( !_.strHas( err.originalMessage, 'Found no willfile at' ) )
      if( !_.strHas( err.originalMessage, 'Found no out-willfile' ) )
      if( !_.strHas( err.originalMessage, 'Out-willfile is inconsistent with its in-willfiles' ) )
      requireVerbosity = 3;
      if( requireVerbosity <= will.verbosity )
      {
        if( !_.errIsLogged( err ) )
        {
          logger.up( 2 );
          logger.log( err );
          logger.down( 2 );
        }
      }
    }

    if( err && !opener2.isFinited() )
    {
      opener2.peerModule = null;
      if( opener2.openedModule )
      opener2.openedModule.peerModule = null;
      _.assert( opener2.peerModule === null );
      _.assert( opener2.openedModule === null || opener2.openedModule.peerModule === null );

      try
      {
        opener2.finit();
      }
      catch( err2 )
      {
        debugger;
        err2 = _.err( err2 );
        logger.log( _.errOnce( err2 ) );
        throw err2;
      }

      _.assert( !module.isFinited() );
    }

    if( err )
    _.errAttend( err );

    return module2 || null;
  })

}

outModuleOpen.defaults = _.mapExtend( null, outModuleMake.defaults );

//

function outModuleOpenOrMake( o )
{
  let module = this;
  let will = module.will;

  o = _.routineOptions( outModuleOpenOrMake, arguments );
  o.willfilesPath = o.willfilesPath || module.outfilePathGet();

  _.assert( !module.isFinited() );

  return module.outModuleOpen()
  .then( ( outModule ) =>
  {

    _.assert( outModule === null || outModule.isOut );
    _.assert( !module.isFinited() );

    if( !outModule )
    return module.outModuleMake( o );

    return outModule;
  });

}

outModuleOpenOrMake.defaults = _.mapExtend( null, outModuleOpen.defaults );

// --
// former
// --

function unform()
{
  let module = this;
  let will = module.will;

  // if( module.id === 1004 )
  // debugger;

  if( module.formed2 <= 0 ) /**/
  return;

  module.formed2 = -1;

  let junction = will.junctionOf( module );

  _.assert( arguments.length === 0, 'Expects no arguments' );

  if( module.peerModule )
  {
    let peerModule = module.peerModule;
    _.assert( !peerModule.isFinited() );
    _.assert( peerModule.peerModule === module );
    peerModule.peerModule = null;
    module.peerModule = null;
  }

  if( module.stager.stageStatePerformed( 'preformed' ) )
  {
    module.stager.cancel();
    _.assert( _.strIs( module.commonPath ) );
    will.moduleIdUnregister( module );
    if( junction )
    junction.remove( module );
  }

  module.close();
  will.modulePathUnregister( module );

  _.assert( module.willfilesArray.length === 0 );
  _.assert( Object.keys( module.willfileWithRoleMap ).length === 0 );

  _.assert( !_.longHas( _.mapVals( will.moduleWithIdMap ), module ) );
  _.assert( !_.longHas( _.mapVals( will.moduleWithCommonPathMap ), module ) );
  _.assert( will.moduleWithIdMap[ module.id ] !== module );
  _.assert( !_.longHas( will.modulesArray, module ) );

  for( let i in module.pathResourceMap )
  module.pathResourceMap[ i ].finit();

  _.assert( Object.keys( module.exportedMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.pathResourceMap ).length === 0 );
  _.assert( Object.keys( module.pathMap ).length === 0 );
  _.assert( Object.keys( module.submoduleMap ).length === 0 );

  module.formed2 = 0;

  return module;
}

//

function preform()
{
  let module = this;
  let will = module.will;
  let con = new _.Consequence().take( null );

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !module.preformReady.resourcesCount() )
  _.assert( !module.preformed );
  _.assert( !module.stager.stageStateEnded( 'preformed' ) );

  module.stager.stageStatePausing( 'preformed', 0 );
  module.stager.tick();

  _.assert( module.stager.stageStateEnded( 'preformed' ) );

  return module;
}

//

function _preform()
{
  let module = this;
  let will = module.will;

  /* */

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!module.will );
  _.assert( module.repo instanceof _.will.Repository );

  module.ready.tap( ( err, arg ) =>
  {
    if( err )
    for( let u = 0 ; u < module.userArray.length ; u++ )
    {
      let opener = module.userArray[ u ];
      _.assert( opener instanceof _.will.ModuleOpener );
      opener.error = opener.error || err;
    }
  });

  if( module.pathResourceMap.in.path === null )
  module.pathResourceMap.in.path = '.';
  if( module.pathResourceMap.out.path === null )
  module.pathResourceMap.out.path = '.';

  /* */

  will.moduleIdRegister( module );
  module._remoteChanged();
  module._peerChanged();
  module._pathRegister();
  /* xxx : forbid changing of some paths, maybe */

  /* */

  if( Config.debug )
  {

    module.assertIsValidIntegrity();

    _.assert( arguments.length === 0, 'Expects no arguments' );
    _.assert( !!module.will );
    _.assert( will.moduleWithIdMap[ module.id ] === module );
    _.assert( module.dirPath === null || _.strDefined( module.dirPath ) );
    _.assert( !!module.willfilesPath || !!module.dirPath );
    _.assert( module.rootModule instanceof _.will.Module );
    _.assert( _.strsAreAll( module.willfilesPath ) || _.strIs( module.dirPath ), 'Expects willfilesPath or dirPath' );

  }

  /* */

  return module;
}

//

function _performBegin()
{
  let module = this;
  _.assert( module.formed2 === 0 );
  module.formed2 = 1;
  return null;
}

//

function upform( o )
{
  let module = this;
  let will = module.will;

  o = _.routineOptions( upform, arguments );
  module.optionsFormingForward( o );

  // debugger;

  if( o.attachedWillfilesFormed )
  if( !module.stager.stageStatePerformed( 'attachedWillfilesFormed' ) )
  module.stager.stageReset( 'attachedWillfilesFormed' );

  if( o.peerModulesFormed )
  if( !module.stager.stageStatePerformed( 'peerModulesFormed' ) )
  module.stager.stageReset( 'peerModulesFormed' );

  if( o.subModulesFormed )
  if( !module.stager.stageStatePerformed( 'subModulesFormed' ) )
  module.stager.stageReset( 'subModulesFormed' );

  if( o.resourcesFormed )
  if( !module.stager.stageStatePerformed( 'resourcesFormed' ) )
  module.stager.stageReset( 'resourcesFormed' );

  module.stager.tick();
  return module.ready;
}

var defaults = upform.defaults = _.mapExtend( null, Parent.prototype.optionsFormingForward.defaults );
defaults.all = 1;

// {
//   all : 1,
//   attachedWillfilesFormed : null,
//   peerModulesFormed : null,
//   subModulesFormed : null,
//   resourcesFormed : null,
// }

//

function reform_( o ) /* xxx */
{
  let module = this;
  let will = module.will;

  o = _.routineOptions( reform_, arguments );
  module.optionsFormingForward( o );

  if( o.attachedWillfilesFormed )
  module.stager.stageReset( 'attachedWillfilesFormed' );

  if( o.peerModulesFormed )
  module.stager.stageReset( 'peerModulesFormed' );

  if( o.subModulesFormed )
  module.stager.stageReset( 'subModulesFormed' );

  if( o.resourcesFormed )
  module.stager.stageReset( 'resourcesFormed' );

  module.stager.tick();
  return module.ready;
}

var defaults = reform_.defaults = _.mapExtend( null, Parent.prototype.optionsFormingForward.defaults );
defaults.all = 0;

// --
// predefined
// --

function predefinedForm()
{
  let module = this;
  let will = module.will;
  let Predefined = _.will.Predefined;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( module.predefinedFormed === 0 );
  module.predefinedFormed = 1;

  /* */

  path
  ({
    name : 'in',
    path : '.',
    writable : 1,
    exportable : 1,
    importableFromIn : 1,
    importableFromOut : 1,
    predefined : 0,
  })

  path
  ({
    name : 'out',
    path : '.',
    writable : 1,
    exportable : 1,
    importableFromIn : 1,
    importableFromOut : 1,
    predefined : 0,
  })

  path
  ({
    name : 'module.willfiles',
    path : null,
    writable : 0,
    exportable : 1,
    importableFromIn : 0,
    importableFromOut : 0,
  })

  path
  ({
    name : 'module.original.willfiles',
    path : null,
    writable : 0,
    exportable : 1,
    importableFromIn : 0,
    importableFromOut : 1,
  })

  path
  ({
    name : 'module.peer.willfiles',
    path : null,
    writable : 0,
    exportable : 1,
    importableFromIn : 0,
    importableFromOut : 1,
  })

  path
  ({
    name : 'module.peer.in',
    path : null,
    writable : 0,
    exportable : 1,
    importableFromIn : 0,
    importableFromOut : 1,
  })

  path
  ({
    name : 'module.dir',
    path : null,
    writable : 0,
    exportable : 0,
    importableFromIn : 0,
    importableFromOut : 0,
  })

  path
  ({
    name : 'module.common',
    path : null,
    writable : 0,
    exportable : 1,
    importableFromIn : 0,
    importableFromOut : 0,
  });

  path
  ({
    name : 'download',
    path : null,
    writable : 1,
    exportable : 1,
    importableFromIn : 1,
    importableFromOut : 1,
  })

  path
  ({
    name : 'local',
    path : null,
    writable : 0,
    exportable : 0,
    importableFromIn : 0,
    importableFromOut : 0,
  })

  path
  ({
    name : 'remote',
    path : null,
    writable : 0,
    exportable : 0,
    importableFromIn : 0,
    importableFromOut : 0,
  })

  path
  ({
    name : 'current.remote',
    path : null,
    writable : 0,
    exportable : 0,
    importableFromIn : 0,
    importableFromOut : 0,
  })

  path
  ({
    name : 'will',
    path : _.path.join( __dirname, '../entry/Exec' ),
    writable : 0,
    exportable : 0,
    importableFromIn : 0,
    importableFromOut : 0,
  })
  _.assert( will.fileProvider.path.s.allAreAbsolute( module.pathResourceMap[ 'will' ].path ) );

  /* */

  step
  ({
    name : 'files.delete',
    stepRoutine : Predefined.stepRoutineDelete,
  })

  step
  ({
    name : 'files.reflect',
    stepRoutine : Predefined.stepRoutineReflect,
  })

  step
  ({
    name : 'timelapse.begin',
    stepRoutine : Predefined.stepRoutineTimelapseBegin,
  })

  step
  ({
    name : 'timelapse.end',
    stepRoutine : Predefined.stepRoutineTimelapseEnd,
  })

  step
  ({
    name : 'js.run',
    stepRoutine : Predefined.stepRoutineJs,
  })

  step
  ({
    name : 'echo.output',
    stepRoutine : Predefined.stepRoutineEcho,
  })

  step
  ({
    name : 'shell.run',
    stepRoutine : Predefined.stepRoutineShell,
  })

  step
  ({
    name : 'files.transpile',
    stepRoutine : Predefined.stepRoutineTranspile,
  })

  step
  ({
    name : 'file.view',
    stepRoutine : Predefined.stepRoutineView,
  })

  step
  ({
    name : 'npm.generate',
    stepRoutine : Predefined.stepRoutineNpmGenerate,
  })

  step
  ({
    name : 'willfile.generate',
    stepRoutine : Predefined.stepRoutineWillfileFromNpm,
  })

  step
  ({
    name : 'git.pull',
    stepRoutine : Predefined.stepRoutineGitPull,
  })

  step
  ({
    name : 'git.push',
    stepRoutine : Predefined.stepRoutineGitPush,
  })

  step
  ({
    name : 'git.reset',
    stepRoutine : Predefined.stepRoutineGitReset,
  })

  step
  ({
    name : 'git.status',
    stepRoutine : Predefined.stepRoutineGitStatus,
  })

  step
  ({
    name : 'git.sync',
    stepRoutine : Predefined.stepRoutineGitSync,
  })

  step
  ({
    name : 'git.tag',
    stepRoutine : Predefined.stepRoutineGitTag,
  })

  step
  ({
    name : 'submodules.download',
    stepRoutine : Predefined.stepRoutineSubmodulesDownload,
  })

  step
  ({
    name : 'submodules.update',
    stepRoutine : Predefined.stepRoutineSubmodulesUpdate,
  })

  step
  ({
    name : 'submodules.agree',
    stepRoutine : Predefined.stepRoutineSubmodulesAgree,
  })

  step
  ({
    name : 'submodules.are.updated',
    stepRoutine : Predefined.stepRoutineSubmodulesVersionsVerify,
  })

  step
  ({
    name : 'submodules.reload',
    stepRoutine : Predefined.stepRoutineSubmodulesReload,
  })

  step
  ({
    name : 'submodules.clean',
    stepRoutine : Predefined.stepRoutineSubmodulesClean,
  })

  step
  ({
    name : 'clean',
    stepRoutine : Predefined.stepRoutineClean,
  })

  step
  ({
    name : 'module.export',
    stepRoutine : Predefined.stepRoutineExport,
  })

  step
  ({
    name : 'willbe.version.check',
    stepRoutine : Predefined.stepRoutineWillbeIsUpToDate,
  })

  /* */

  reflector
  ({
    name : 'predefined.common',
    src :
    {
      maskAll :
      {
        excludeAny :
        [
          /(\W|^)node_modules(\W|$)/,
          /\.unique$/,
          /\.git$/,
          /\.svn$/,
          /\.hg$/,
          /\.DS_Store$/,
          /(^|\/)-/,
        ],
      }
    },
  });

  reflector
  ({
    name : 'predefined.debug.v1',
    src :
    {
      maskAll :
      {
        excludeAny : [ /\.release($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 1,
    },
  });

  reflector
  ({
    name : 'predefined.debug.v2',
    src :
    {
      maskAll :
      {
        excludeAny : [ /\.release($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 'debug',
    },
  });

  reflector
  ({
    name : 'predefined.release.v1',
    src :
    {
      maskAll :
      {
        excludeAny : [ /\.debug($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
        // excludeAny : [ /\.debug($|\.|\/)/i, /\.test($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 0,
    },
  });

  reflector
  ({
    name : 'predefined.release.v2',
    src :
    {
      maskAll :
      {
        excludeAny : [ /\.debug($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
        // excludeAny : [ /\.debug($|\.|\/)/i, /\.test($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 'release',
    },
  });

  // _.assert( module.pathResourceMap[ 'module.common' ].importable === undefined );
  _.assert( !module.pathResourceMap[ 'module.common' ].importableFromIn );
  _.assert( !module.pathResourceMap[ 'module.common' ].importableFromOut );

/*
  .predefined.common :
    src :
      maskAll :
        excludeAny :
        - !!js/regexp '/(^|\/)-/'

  .predefined.debug :
    inherit : .predefined.common
    src :
      maskAll :
        excludeAny :
        - !!js/regexp '/\.release($|\.|\/)/i'

  .predefined.release :
    inherit : .predefined.common
    src :
      maskAll :
        excludeAny :
        - !!js/regexp '/\.debug($|\.|\/)/i'
        - !!js/regexp '/\.test($|\.|\/)/i'
        - !!js/regexp '/\.experiment($|\.|\/)/i'
*/

  // /* - */
  //
  // function prepare( defaults, o )
  // {
  //
  //   let commonDefaults =
  //   {
  //     module : module,
  //     writable : 0,
  //     exportable : 0,
  //     importableFromIn : 0,
  //     importableFromOut : 0,
  //     predefined : 1,
  //   }
  //
  //   if( defaults === null )
  //   defaults = Object.create( null );
  //   _.mapSupplement( defaults, commonDefaults );
  //
  //   o.criterion = o.criterion || Object.create( null );
  //
  //   if( o.importable !== undefined && o.importable !== null )
  //   {
  //     if( o.importableFromIn === undefined || o.importableFromIn === null )
  //     o.importableFromIn = o.importable;
  //     if( o.importableFromOut === undefined || o.importableFromOut === null )
  //     o.importableFromOut = o.importable;
  //   }
  //
  //   _.mapSupplement( o, defaults );
  //   _.mapSupplement( o.criterion, defaults.criterion );
  //
  //   if( o.predefined )
  //   {
  //     o.criterion.predefined = 1;
  //   }
  //
  //   delete o.predefined;
  //   delete o.importable;
  //
  //   _.assert( o.criterion !== defaults.criterion );
  //   _.assert( arguments.length === 2 );
  //
  //   return o;
  // }

  /* */

  function path( o )
  {

    return module.predefinedPathMake( o );

    // let defaults =
    // {
    //   importableFromIn : 0,
    //   importableFromOut : 1,
    // }
    //
    // o = prepare( defaults, o );
    //
    // _.assert( arguments.length === 1 );
    //
    // let result = module.pathResourceMap[ o.name ];
    // if( result )
    // {
    //   let criterion = o.criterion;
    //   delete o.criterion;
    //   result.copy( o );
    //   _.mapExtend( result.criterion, criterion );
    // }
    // else
    // {
    //   result = new _.will.PathResource( o );
    // }
    //
    // result.form1();
    //
    // _.assert( !!result.writable === !!o.writable );
    //
    // return result;
  }

  /* */

  function step( o )
  {

    return module.predefinedStepMake( o );

    // if( module.stepMap[ o.name ] )
    // return module.stepMap[ o.name ].form1();
    //
    // o = prepare( null, o );
    //
    // _.assert( arguments.length === 1 );
    //
    // let result = new _.will.Step( o ).form1();
    // result.writable = 0;
    // return result;
  }

  /* */

  function reflector( o )
  {
    return module.predefinedReflectorMake( o );
    // if( module.reflectorMap[ o.name ] )
    // return module.reflectorMap[ o.name ].form1();
    //
    // let o2 = Object.create( null );
    // o2.resource = o;
    //
    // o = prepare( null, o2.resource );
    //
    // _.assert( !!o2.resource.criterion );
    // _.assert( arguments.length === 1 );
    //
    // let result = _.will.Reflector.MakeForEachCriterion( o2 );
    // return result;
  }

}

//

function _predefinedOptionsPrepare( defaults, o )
{
  let module = this;
  let will = module.will;

  let commonDefaults =
  {
    module : module,
    writable : 0,
    exportable : 0,
    importableFromIn : 0,
    importableFromOut : 0,
    predefined : 1,
  }

  if( defaults === null )
  defaults = Object.create( null );
  _.mapSupplement( defaults, commonDefaults );

  o.criterion = o.criterion || Object.create( null );

  if( o.importable !== undefined && o.importable !== null )
  {
    if( o.importableFromIn === undefined || o.importableFromIn === null )
    o.importableFromIn = o.importable;
    if( o.importableFromOut === undefined || o.importableFromOut === null )
    o.importableFromOut = o.importable;
  }

  _.mapSupplement( o, defaults );
  _.mapSupplement( o.criterion, defaults.criterion );

  if( o.predefined )
  {
    o.criterion.predefined = 1;
  }

  delete o.predefined;
  delete o.importable;

  _.assert( o.criterion !== defaults.criterion );
  _.assert( arguments.length === 2 );

  return o;
}

//

function predefinedPathMake( o )
{
  let module = this;
  let will = module.will;

  let defaults =
  {
    importableFromIn : 0,
    importableFromOut : 1,
  }

  o = module._predefinedOptionsPrepare( defaults, o );

  _.assert( arguments.length === 1 );

  let result = module.pathResourceMap[ o.name ];
  if( result )
  {
    let criterion = o.criterion;
    delete o.criterion;
    result.copy( o );
    _.mapExtend( result.criterion, criterion );
  }
  else
  {
    result = new _.will.PathResource( o );
  }

  result.form1();

  _.assert( !!result.writable === !!o.writable );

  return result;
}

//

function predefinedStepMake( o )
{
  let module = this;
  let will = module.will;

  // if( o.name === 'files.delete' )
  // debugger;

  if( module.stepMap[ o.name ] )
  return module.stepMap[ o.name ].form1();

  o = module._predefinedOptionsPrepare( null, o );

  _.assert( module === o.module );
  _.assert( arguments.length === 1 );

  // debugger;
  let result = new _.will.Step( o ).form1();
  result.writable = 0;
  return result;
}

//

function predefinedReflectorMake( o )
{
  let module = this;
  let will = module.will;

  if( module.reflectorMap[ o.name ] )
  return module.reflectorMap[ o.name ].form1();

  let o2 = Object.create( null );
  o2.resource = o;

  o = module._predefinedOptionsPrepare( null, o2.resource );
  // o = prepare( null, o2.resource );

  _.assert( !!o2.resource.criterion );
  _.assert( arguments.length === 1 );

  let result = _.will.Reflector.MakeForEachCriterion( o2 );
  return result;
}

// --
// relator
// --

function releasedBy( user )
{
  let module = this;

  _.arrayRemoveOnceStrictly( module.userArray, user );

  if( user instanceof _.will.ModuleOpener )
  {
    if( user.superRelation )
    module.superRelationsRemove( user.superRelation );
  }

  return true;
}

//

function usedBy( user )
{
  let module = this;
  let will = module.will;

  _.arrayAppendOnceStrictly( module.userArray, user );

  if( user instanceof _.will.ModuleOpener )
  {
    if( user.superRelation )
    module.superRelationsAppend( user.superRelation );

    _.assert( user.downloadPath === null || module.downloadPath === null || user.downloadPath === module.downloadPath );
    _.sure /* xxx : add test routine */
    (
      user.remotePath === null || module.remotePath === null || user.remotePath === module.remotePath,
      `Files namespace conflict. Two different versions:
      ${user.remotePath}
      ${module.remotePath}`
    );

    if( !user.remotePath && module.remotePath )
    {
      _.assert( _.strDefined( module.downloadPath ) );
      user.remotePathEachAdopt({ remotePath : module.remotePath, downloadPath : module.downloadPath });
    }
    else if( user.remotePath && !module.remotePath )
    {
      debugger;
      _.assert( _.strDefined( user.downloadPath ) );
      module.remotePathEachAdopt({ remotePath : user.remotePath, downloadPath : user.downloadPath });
    }

    _.assert( user.downloadPath === module.downloadPath );
    _.assert( user.remotePath === module.remotePath );
    _.assert( user.repo === module.repo );

  }

  return module;
}

//

function isUsedBy( user )
{
  let module = this;
  let will = module.will;
  if( user instanceof Self )
  return user.peerModule === module;
  return _.longHas( module.userArray, user );
}

//

function isUsed()
{
  let module = this;
  if( module.userArray.length )
  return true;
  if( module.peerModule && module.peerModule.userArray.length )
  return true;
  return false;
}

//

function usersGet()
{
  let module = this;
  return [ ... module.userArray, ... ( module.peerModule ? module.peerModule.userArray : [] ) ];
}

//

function own( object )
{
  let module = this;
  let will = module.will;

  _.assert( !!object );

  if( object instanceof _.will.ModulesRelation )
  {
    for( let name in module.submoduleMap )
    {
      let object2 = module.submoduleMap[ name ];
      if( object2 === object )
      return true;
    }
    for( let r = 0 ; r < module.superRelations.length ; r++ )
    {
      let object2 = module.superRelations[ r ];
      if( object2 === object )
      return true;
    }
  }
  else if( object instanceof _.will.Module )
  {
    if( object === module )
    return true;
    if( object === module.peerModule )
    return true;
    for( let name in module.submoduleMap )
    {
      if( !module.submoduleMap[ name ].opener )
      continue;
      let object2 = module.submoduleMap[ name ].opener.openedModule;
      if( object2 === object )
      return true;
    }
  }
  else if( object instanceof _.will.ModuleOpener )
  {
    for( let name in module.submoduleMap )
    {
      let object2 = module.submoduleMap[ name ].opener;
      if( object2 === object )
      return true;
    }
    for( let u = 0 ; u < module.userArray.length ; u++ )
    {
      let object2 = module.userArray[ u ];
      if( object2 === object )
      return true;
    }
  }
  else _.assert( 0, `Unknown type of object ${_.strType( object )}` );

  return false;
}

// --
// opener
// --

function isOpened()
{
  let module = this;
  return module.willfilesArray.length > 0 && module.stager.stageStateEnded( 'opened' );
}

//

function isValid()
{
  let module = this;
  return module.stager.isValid();
}

//

function isConsistent( o )
{
  let module = this;

  o = _.routineOptions( isConsistent, arguments );
  _.assert( o.recursive === 0 );

  let willfiles = module.willfilesEach({ recursive : o.recursive, withPeers : 0 });

  return willfiles.every( ( willfile ) =>
  {
    _.assert( _.boolLike( willfile.isOut ) );
    if( !willfile.isOut )
    return true;
    _.assert( willfile.openedModule instanceof module.Self );
    _.assert
    (
      !!willfile.openedModule.peerModule
      , () => `Peer module of ${module.absoluteName} at ${module.localPath} was not opened to check it consistency`
    );
    if( !willfile.openedModule.peerModule )
    return false;
    _.assert( !!willfile.openedModule.peerModule );
    if( willfile.openedModule.peerModule )
    return willfile.openedModule.peerModule.willfilesArray.every( ( willfile2 ) =>
    {
      return willfile.isConsistentWith( willfile2 );
    });
  });

}

isConsistent.defaults =
{
  recursive : 0,
}

//

function isFull( o )
{
  let module = this;
  if( !module.isOpened() )
  return false;

  o = _.routineOptions( isFull, arguments );
  o.only = o.only || Object.create( null );
  o.only.all = 1;
  o.only = module.optionsFormingForward( o.only );

  let states = module.stager.stagesState( 'performed' )
  _.mapSupplement( o.only, _.map( states, () => true ) );
  states = _.only( states, o.only ); /* xxx : review mapOnly / mapBut */

  return _.all( states );
}

var defaults = isFull.defaults = Object.create( null );
defaults.only = null;

//

function isAliveGet()
{
  let module = this;
  return module.formed2 >= 1;
  // return module.stager.stageStateBegun( 'preformed' );
}

//

function isPreformed()
{
  let module = this;
  if( !module.stager )
  return false;
  return module.stager.stageStatePerformed( 'preformed' );
}

//

function reopen()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let name = module.absoluteName;
  let commonPath = module.commonPath;

  _.assert( !module.isFinited() );
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let junction = will.junctionReform( module );
  if( junction.openers.length !== 1 )
  debugger;
  junction.openers.forEach( ( opener2 ) =>
  {
    ready.then( () => opener2.reopen() );
  });

  ready.finally( ( err, module2 ) =>
  {
    debugger;
    if( err )
    throw _.err( err, `\nFailed to reopen ${name} at ${commonPath}` );
    _.assert( module.isFinited() );
    _.assert( !module2.isFinited() );
    // module.finit();
    return module2;
  });

  return ready;
}

//

function close()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( !module.isFinited() );
  _.assert( arguments.length === 0, 'Expects no arguments' );

  // /* update openers first, maybe */
  //
  // openers.pathsFromModule( module );

  /*
    finit of submodules should goes first
  */

  for( let i in module.submoduleMap )
  module.submoduleMap[ i ].finit();

  /*
    then other resources
  */

  for( let i in module.exportedMap )
  module.exportedMap[ i ].finit();
  for( let i in module.buildMap )
  module.buildMap[ i ].finit();
  for( let i in module.stepMap )
  module.stepMap[ i ].finit();
  for( let i in module.reflectorMap )
  module.reflectorMap[ i ].finit();
  for( let i in module.pathResourceMap )
  {
    if( !module.pathResourceMap[ i ].criterion || !module.pathResourceMap[ i ].criterion.predefined )
    module.pathResourceMap[ i ].finit();
  }

  _.assert( Object.keys( module.exportedMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.submoduleMap ).length === 0 );

  /* */

  module._willfilesRelease( module.willfilesArray );
  module._willfilesRelease( module.storedWillfilesArray );

  /* */

  _.assert( module.willfilesArray.length === 0 );
  _.assert( Object.keys( module.willfileWithRoleMap ).length === 0 );

  module.stager.cancel({ but : [ 'preformed' ] });

}

//

function _formEnd()
{
  let module = this;
  return null;
}

// --
// willfiles
// --

function willfilesOpen()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  module.stager.stageStatePausing( 'opened', 0 );
  module.stager.tick();

  return module.stager.stageConsequence( 'opened' );
}

//

function _willfilesOpen()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let con = new _.Consequence().take( null );

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( _.boolLike( module.isOut ), 'Expects defined {- module.isOut -}' );
  _.sure
  (
    !!_.mapKeys( module.willfileWithRoleMap ).length && !!module.willfilesArray.length,
    () => 'Found no will file at ' + _.strQuote( module.dirPath )
  );

  /* */

  for( let i = module.willfilesArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = module.willfilesArray[ i ];
    _.assert( willf.openedModule === null || willf.openedModule === module );
    willf.openedModule = module;
    _.assert( willf.openedModule === module );
  }

  /* */

  // debugger;
  for( let i = 0 ; i < module.willfilesArray.length ; i++ )
  {
    let willfile = module.willfilesArray[ i ];
    _.assert( willfile.formed === 1 || willfile.formed === 2 || willfile.formed === 3, 'not expected' );
    con.then( ( arg ) => willfile.form() );
  }

  /* */

  con.then( ( arg ) =>
  {
    /* add default export step and build if defined none such */
    if( _.lengthOf( module.buildMap ) !== 0 )
    return arg;
    if( _.mapVals( module.stepMap ).filter( ( step ) => !step.criterion.predefined ).length !== 0 )
    return arg;

    let o2 =
    {
      module : module,
      name : 'export',
      criterion :
      {
        export : 1,
        default : 1,
      },
      steps : [ 'step::module.export' ],
    }
    let resource2 = new _.will.Build( o2 ).form1();

    if( module.pathResourceMap.export || module.reflectorMap.export )
    return arg;

    let o3 =
    {
      module : module,
      name : 'export',
      path : '**',
    }
    let resource3 = new _.will.PathResource( o3 ).form1();

    return arg;
  });

  /* */

  con.finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err );
    module._nameChanged();
    return arg;
  });

  /* */

  return con.split();
}

//

function _willfilesOpenEnd()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  if( module.stager.isValid() )
  {
    module.peerModuleFromJunction();
  }

  return null;
}

//

function _willfilesReadBegin()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  will._willfilesReadBegin();

  return null;
}

//

function _willfilesReadEnd()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  will._willfilesReadEnd( module );

  return null;
}

//

function willfileUnregister( willf )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( willf.openedModule === module || willf.openedModule === null );
  willf.openedModule = null;

  Parent.prototype.willfileUnregister.apply( module, arguments );
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

  _.assert( willf.openedModule === null || willf.openedModule === module );
  willf.openedModule = module;

  Parent.prototype.willfileRegister.apply( module, arguments );
}

//

function _willfilesExport()
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  module.willfilesEach( handeWillFile );

  return result;

  function handeWillFile( willfile )
  {
    _.assert( _.objectIs( willfile.data ) );
    result[ willfile.filePath ] = willfile.data;
  }

}

//

function willfilesEach( o )
{
  let module = this;
  let will = module.will;
  let result = []

  if( _.routineIs( arguments[ 0 ] ) )
  o = { onUp : arguments[ 0 ] }
  o = _.routineOptions( willfilesEach, o );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  let o2 = Object.create( null );
  o2.recursive = o.recursive;
  o2.withStem = o.withStem;
  o2.withPeers = o.withPeers;
  o2.onUp = handleUp;

  module.modulesEach( o2 );

  return result;

  function handleUp( module2 )
  {

    for( let w = 0 ; w < module2.willfilesArray.length ; w++ )
    {
      let willfile = module2.willfilesArray[ w ];
      if( o.onUp )
      o.onUp.call( module, willfile );
      result.push( willfile );
    }

  }

}

willfilesEach.defaults =
{
  recursive : 0,
  withStem : 1,
  withPeers : 0,
  onUp : null,
}

//

function willfilesSave()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( !module.isOut );
  _.assert( module.willfilesArray.length === 1, 'not implemented' );

  module.willfilesArray.forEach( ( willf ) =>
  {
    willf.save();
  });

  return null;
}

//

function _attachedWillfilesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.preformed );

  let con = _.Consequence().take( null );

  con.then( ( arg ) =>
  {
    return module._attachedWillfilesOpen();
  });

  con.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  return con.split();
}

//

function _attachedWillfilesOpen( o ) /* xxx : does this stage do anything useful? */
{
  let module = this;
  let will = module.will;

  o = _.routineOptions( _attachedWillfilesOpen, arguments );
  o.rootModule = o.rootModule || module.rootModule || module;
  o.willfilesArray = o.willfilesArray || module.willfilesArray;

  for( let f = 0 ; f < o.willfilesArray.length ; f++ )
  {
    let willfile = o.willfilesArray[ f ];

    if( !willfile.isOut )
    continue;

    if( !willfile.structure.format )
    continue;

    willfile._read();

    // debugger;
    for( let modulePath in willfile.structure.module )
    {
      let moduleStructure = willfile.structure.module[ modulePath ];

      if( _.longHas( willfile.structure.root, modulePath ) )
      continue;

      module._attachedWillfileOpen
      ({
        modulePath : modulePath,
        structure : moduleStructure,
        rootModule : o.rootModule,
        storagePath : willfile.filePath,
        storageWillfile : willfile,
      });

    }
    // debugger;

  }

  return null;
}

_attachedWillfilesOpen.defaults =
{
  willfilesArray : null,
  rootModule : null,
}

//

function _attachedWillfileOpen( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  o = _.routineOptions( _attachedWillfileOpen, arguments );

  let filePath = path.join( module.dirPath, o.modulePath );
  filePath = will.LocalPathNormalize( filePath )

  if( o.structure.path && o.structure.path[ 'module.willfiles' ] )
  {
    let moduleWillfilesPath = o.structure.path[ 'module.willfiles' ];
    if( _.mapIs( moduleWillfilesPath ) )
    moduleWillfilesPath = moduleWillfilesPath.path;
    if( moduleWillfilesPath )
    filePath = path.s.join( path.s.dirFirst( filePath ), moduleWillfilesPath );
  }

  let willfOptions =
  {
    filePath : filePath,
    structure : o.structure,
    storagePath : o.storagePath,
    storageWillfile : o.storageWillfile,
    // storageModule : module,
  }

  return will.willfileFor({ willf : willfOptions, combining : 'supplement' });
}

_attachedWillfileOpen.defaults =
{
  modulePath : null,
  storagePath : null,
  storageWillfile : null,
  structure : null,
  rootModule : null,
}

// --
// build / export
// --

function exportAuto()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let clonePath = module.cloneDirPathGet();

  debugger;
  _.assert( 'not implemented' );

  // _.assert( arguments.length === 0, 'Expects no arguments' );
  // _.assert( !!module.submoduleAssociation );
  // _.assert( !!module.submoduleAssociation.autoExporting );
  // _.assert( !module.pickedWillfileData );
  // _.assert( !module.pickedWillfilesPath );
  //
  // let autoWillfileData =
  // {
  //   'about' :
  //   {
  //     'name' : 'Extension',
  //     'version' : '0.1.0'
  //   },
  //   'path' :
  //   {
  //     'in' : '..',
  //     'out' : '.module',
  //     'remote' : 'git+https :///github.com/Wandalen/wProto.git',
  //     'local' : '.module/Extension',
  //     'export' : '{path::local}/proto'
  //   },
  //   'reflector' :
  //   {
  //     'download' :
  //     {
  //       'src' : 'path::remote',
  //       'dst' : 'path::local'
  //     }
  //   },
  //   'step' :
  //   {
  //     'export.common' :
  //     {
  //       'export' : 'path::export',
  //       'tar' : 0
  //     }
  //   },
  //   'build' :
  //   {
  //     'export' :
  //     {
  //       'criterion' :
  //       {
  //         'default' : 1,
  //         'export' : 1
  //       },
  //       'steps' :
  //       [
  //         'step::download',
  //         'step::export.common'
  //       ]
  //     }
  //   }
  // }
  //
  // module.pickedWillfileData = autoWillfileData;
  // module.pickedWillfilesPath = clonePath + module.aliasName;
  // module._willfilesFindPickedFile()
  //
  // debugger;

}

//

function moduleBuild_pre( routine, args )
{
  let o = _.routineOptions( routine, args );
  return o;
}

function moduleBuild_body( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let con = new _.Consequence().take( null );

  let builds = module._buildsResolve
  ({
    name : o.name,
    criterion : o.criterion,
    kind : o.kind,
  });

  if( builds.length !== 1 )
  throw module.errTooMany( builds, `${o.kind} scenario` );

  let build = builds[ 0 ];
  will._willfilesReadEnd( module );

  let run = new _.will.BuildRun
  ({
    build,
    recursive : 0,
    isRoot : o.isRoot,
    purging : o.purging,
  });

  return con
  .then( () =>
  {
    _.assert( !module.isOut );
    return module.modulesUpform
    ({
      all : 0,
      // subModulesFormed : 1, /* yyy2 */
      subModulesFormed : 0,
      peerModulesFormed : 1,
      recursive : 0,
      // recursive : 1, /* yyy2 */
    });
  })
  .then( () =>
  {
    if( !o.isRoot || !o.purging )
    return null;
    if( module.peerModule )
    module.peerModule.finit();
    _.assert( module.peerModule === null );
    _.assert( !module.isFinited() );
    return null;
  })
  .then( () => build.perform({ run }) )
  .then( () =>
  {
    _.assert( !module.peerModule || module.peerModule.isOut );
    return null;
  });
}

moduleBuild_body.defaults =
{
  name : null,
  criterion : null,
  kind : 'export',
  isRoot : null,
  purging : 0,
}

let moduleBuild = _.routineFromPreAndBody( moduleBuild_pre, moduleBuild_body );
moduleBuild.defaults.kind = 'build';
let moduleExport = _.routineFromPreAndBody( moduleBuild_pre, moduleBuild_body );
moduleExport.defaults.kind = 'export';

//

function exportedMake( o )
{
  let module = this;
  let outModule = module;
  let will = module.will;

  o = _.routineOptions( exportedMake, arguments );
  _.assert( o.build instanceof _.will.Build );
  _.assert( !module.isFinited() );

  if( !module.isOut )
  {
    _.assert( _.mapKeys( module.exportedMap ).length === 0 );
    _.assert( !module.isFinited() );

    if( module.peerModule && !module.peerModule.isValid() )
    {
      let peerModule = module.peerModule;
      module.peerModule = null;
      _.assert( module.peerModule === null );
      _.assert( peerModule.peerModule === null );
      peerModule.finit();
      _.assert( module.peerModule === null );
      _.assert( peerModule.peerModule === null );
    }

    _.assert( !module.isFinited() );
    // _.assert( _.boolLike( o.purging ), 'not tested' ); /* xxx : check */

    if( !module.peerModule )
    {
      if( o.purging )
      debugger;
      if( o.purging )
      return _.Consequence.From( module.outModuleMake() ).then( () => makeFromPeer() );
      else
      return module.outModuleOpenOrMake().then( () => makeFromPeer() );
    }

    return new _.Consequence().take( makeFromPeer() );
  }

  debugger
  return new _.Consequence().take( make() );

  /* */

  function make()
  {

    if( outModule.exportedMap[ o.build.name ] )
    {
      outModule.exportedMap[ o.build.name ].finit();
      _.assert( outModule.exportedMap[ o.build.name ] === undefined );
    }

    let exported = new _.will.Exported({ outModule : outModule, name : o.build.name }).form1();

    _.assert( outModule.exportedMap[ o.build.name ] === exported );

    return exported;

  }

  function makeFromPeer()
  {
    _.assert
    (
      module.peerModule && module.peerModule.isValid() && module.peerModule.isOut
      , () => `Out of ${module.peerModule ? module.peerModule.qualifiedName : 'the module'} is not valid`
    );
    outModule = module.peerModule;
    return make();
  }

}

exportedMake.defaults =
{
  build : null,
  purging : 0,
}

// --
// batcher
// --

function modulesEach_pre( routine, args )
{
  let module = this;

  let o = args[ 0 ]
  if( _.routineIs( args[ 0 ] ) )
  o = { onUp : args[ 0 ] };
  o = _.routineOptions( routine, o );
  _.assert( args.length === 0 || args.length === 1 );
  _.assert( _.longHas( _.will.ModuleVariant, o.outputFormat ) )

  return o;
}

function modulesEach_body( o )
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  let o2 = _.mapExtend( null, o );
  o2.modules = [ module ];

  return will.modulesEach.body.call( will, o2 );
}

var defaults = modulesEach_body.defaults = _.mapExtend
(
  null,
  _.Will.prototype.modulesEach.defaults
);

delete defaults.modules;

_.assert( defaults.withPeers === 0 );

let modulesEach = _.routineFromPreAndBody( modulesEach_pre, modulesEach_body );
let modulesEachAll = _.routineDefaults( null, modulesEach, _.Will.RelationFilterOn );

//

function modulesBuild_pre( routine, args )
{
  let o = _.routineOptions( routine, args );
  return o;
}

function modulesBuild_body( o )
{
  let module = this;
  let will = module.will;
  o.modules = [ module ];
  return will.modulesBuild( o );
}

var defaults = modulesBuild_body.defaults = _.mapExtend( null, _.mapBut( moduleBuild.defaults, [ 'isRoot' ] ), _.Will.prototype.modulesFor.defaults );

defaults.recursive = 0;
defaults.withStem = 1;
defaults.withDisabledStem = 1;
defaults.withPeers = 1;
defaults.upforming = 1;
defaults.downloading = 1;
defaults.doneContainer = null;

delete defaults.onEach;
delete defaults.onEachModule;
delete defaults.onEachJunction;
delete defaults.withOut;
delete defaults.withIn;

_.assert( defaults.outputFormat === undefined );
_.assert( defaults.withDisabledSubmodules === 0 );
_.assert( defaults.withDisabledModules === 0 );

let modulesBuild = _.routineFromPreAndBody( modulesBuild_pre, modulesBuild_body );
modulesBuild.defaults.kind = 'build';
modulesBuild.defaults.downloading = 1;

let modulesExport = _.routineFromPreAndBody( modulesBuild_pre, modulesBuild_body );
modulesExport.defaults.kind = 'export';
modulesExport.defaults.downloading = 1;

//

function modulesUpform( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  o = _.routineOptions( modulesUpform, arguments );

  let o2 = _.mapExtend( null, o );
  o2.modules = [ module ];
  return will.modulesUpform( o2 );
}

var defaults = modulesUpform.defaults = _.mapExtend( null, upform.defaults, modulesEach.defaults );

defaults.withDisabledStem = 1;
defaults.recursive = 2;
defaults.withStem = 1;
defaults.withPeers = 1;
// defaults.allowingMissing = 1;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

// --
// submodule
// --

function rootModuleGet()
{
  let module = this;
  return module[ rootModuleSymbol ];
}

//

function rootModuleSet( src )
{
  let module = this;
  let will = module.will;
  let oldRootModule = module.rootModule;

  if( oldRootModule === src )
  return src;

  module.rootModuleSetAct( src );

  _.each( module.userArray, ( opener ) =>
  {
    if( opener instanceof _.will.ModuleOpener )
    opener._.rootModule = src;
  });

  if( oldRootModule && src )
  {
    let modules = module.modulesEachAll
    ({
      outputFormat : '/',
      recursive : 2,
      withPeers : 1,
    });
    modules.forEach( ( junction ) =>
    {
      let module2 = junction.module || junction.opener;
      if( module2 === null )
      return;
      _.assert( module2.rootModule !== undefined );
      if( module2.rootModuleSetAct )
      module2.rootModuleSetAct( src );
      else
      module2.rootModule = src;
    });
  }

  return src;
}

//

function rootModuleSetAct( src )
{
  let module = this;
  let will = module.will;

  _.assert( src === null || src instanceof _.will.Module );
  _.assert( src === null || src.rootModule === src || src.rootModule === null );

  let oldRootModule = module.rootModule;

  if( oldRootModule === src )
  return src;

  // if( src && module[ rootModuleSymbol ] !== src )
  // {
  //   logger.log( `${module.absoluteName} got root ${src.absoluteName}` );
  // }

  module[ rootModuleSymbol ] = src;

  if( will )
  {
    let junction = will.junctionOf( module );
    if( junction )
    junction.reform();
  }

  return src;
}

//

function superRelationsSet( src )
{
  let module = this;

  _.assert( src === null || _.arrayIs( src ) );
  _.assert( src === null || src.every( ( superRelation ) => superRelation instanceof _.will.ModulesRelation ) );

  if( !module[ superRelationsSymbol ] )
  module[ superRelationsSymbol ] = [];

  if( src === null )
  _.arrayEmpty( module[ superRelationsSymbol ] );
  else
  _.arrayAppendArrayOnce( module[ superRelationsSymbol ], src );

  module.assertIsValidIntegrity(); /* zzz : temp */

  return module[ superRelationsSymbol ];
}

//

function superRelationsAppend( src )
{
  let module = this;

  if( _.arrayIs( src ) )
  {
    return _.map( src, ( src ) => module.supeRelationsAppend( src ) );
  }

  _.assert( src instanceof _.will.ModulesRelation );

  if( module[ superRelationsSymbol ] === null )
  module[ superRelationsSymbol ] = [];

  _.arrayAppendOnceStrictly( module[ superRelationsSymbol ], src );

  return src;
}

//

function superRelationsRemove( src )
{
  let module = this;

  if( _.arrayIs( src ) )
  {
    return _.map( src, ( src ) => module.superRelationsRemove( src ) );
  }

  _.assert( src instanceof _.will.ModulesRelation );

  if( module[ superRelationsSymbol ] )
  _.arrayRemoveOnceStrictly( module[ superRelationsSymbol ], src );

  return src;
}

//

function submodulesAreDownloaded( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  o = _.routineOptions( submodulesAreDownloaded, arguments );
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let o2 = _.mapExtend( null, o );
  o2.outputFormat = '*/relation';
  let relations = module.modulesEach( o2 );
  relations = _.index( relations, '*/commonPath' );

  return _.map( relations, ( relation ) =>
  {
    if( relation === null )
    return true;
    if( !relation.opener )
    return false;
    _.assert( _.boolLike( relation.opener.repo.isRepository ) );
    return relation.opener.repo.isRepository;
  });
}

var defaults = submodulesAreDownloaded.defaults = _.mapExtend( null, modulesEach.defaults );

defaults.withStem = 0;
defaults.withPeers = 0;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

//

function submodulesAllAreDownloaded( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  o = _.routineOptions( submodulesAllAreDownloaded, arguments );
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let o2 = _.mapExtend( null, o );
  o2.outputFormat = '*/relation';
  let relations = module.modulesEach( o2 );

  return relations.every( ( relation ) =>
  {
    if( !relation.opener )
    return false;
    _.assert( _.boolLike( relation.opener.repo.isRepository ) );
    return relation.opener.repo.isRepository;
  });
}

var defaults = submodulesAllAreDownloaded.defaults = _.mapExtend( null, submodulesAreDownloaded.defaults );

//

function submodulesAreValid( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  o = _.routineOptions( submodulesAreValid, arguments );
  // _.assert( module === module.rootModule );
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let o2 = _.mapExtend( null, o );
  o2.outputFormat = '*/relation';
  let relations = module.modulesEach( o2 );
  relations = _.index( relations, '*/absoluteName' );

  return _.map( relations, ( relation ) =>
  {
    if( relation === null )
    return true;
    if( !relation.opener )
    return false;
    if( !relation.opener.openedModule )
    return false;
    return relation.opener.openedModule.isValid();
  });

}

var defaults = submodulesAreValid.defaults = _.mapExtend( null, modulesEach.defaults );

defaults.withStem = 0;
defaults.withPeers = 0;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

//

function submodulesAllAreValid( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  o = _.routineOptions( submodulesAllAreValid, arguments );
  // _.assert( module === module.rootModule );
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let o2 = _.mapExtend( null, o );
  o2.outputFormat = '*/relation';
  let relations = module.modulesEach( o2 );

  return relations.every( ( relation ) =>
  {
    if( !relation.opener )
    return false;
    return relation.opener.isValid();
  });
}

var defaults = submodulesAllAreValid.defaults = _.mapExtend( null, submodulesAreValid.defaults );

//

function submodulesClean()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let result = module.clean
  ({
    cleaningSubmodules : 1,
    cleaningOut : 0,
    cleaningTemp : 0,
  });

  return result;
}

//

function _subModulesDownload_pre( routine, args )
{
  let module = this;

  _.assert( arguments.length === 2 );
  _.assert( args.length <= 2 );

  let o;
  o = args[ 0 ];

  o = _.routineOptions( routine, o );

  return o;
}

function _subModulesDownload_body( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  o.modules = module;

  return will.modulesDownload( o );
}

var defaults = _subModulesDownload_body.defaults = _.mapExtend( null, modulesEach.defaults );

defaults.mode = 'download';
defaults.dry = 0;
defaults.loggingNoChanges = 1;
defaults.recursive = 1;
defaults.withStem = 1;
defaults.withDisabledStem = 1;

delete defaults.withPeers;
delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

let _subModulesDownload = _.routineFromPreAndBody( _subModulesDownload_pre, _subModulesDownload_body );

//

let subModulesDownload = _.routineFromPreAndBody( _subModulesDownload_pre, _subModulesDownload_body, 'subModulesDownload' );
var defaults = subModulesDownload.defaults;
defaults.mode = 'download';

//

let subModulesUpdate = _.routineFromPreAndBody( _subModulesDownload_pre, _subModulesDownload_body, 'subModulesUpdate' );
var defaults = subModulesUpdate.defaults;
defaults.mode = 'update';

//

let subModulesAgree = _.routineFromPreAndBody( _subModulesDownload_pre, _subModulesDownload_body, 'subModulesAgree' );
var defaults = subModulesAgree.defaults;
defaults.mode = 'agree';

//

function submodulesFixate( o )
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = _.routineOptions( submodulesFixate, arguments );

  let o2 = _.mapExtend( null, o );
  o2.module = module;
  module.moduleFixate( o2 );

  for( let m in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ m ];

    if( !submodule.opener )
    continue;

    let o2 = _.mapExtend( null, o );
    o2.submodule = submodule;
    o2.module = submodule.opener.openedModule;
    module.moduleFixate( o2 );

  }

  return module;
}

submodulesFixate.defaults =
{
  dry : 0,
  upgrading : 0,
  reportingNegative : 0,
}

//

function moduleFixate( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let report = Object.create( null );
  let resolved = Object.create( null );

  if( !_.mapIs( o ) )
  o = { module : o }

  _.routineOptions( moduleFixate, o );
  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 1 );
  _.assert( _.boolLike( o.dry ) );
  _.assert( _.boolLike( o.upgrading ) );
  _.assert( o.module  === null || o.module instanceof _.will.Module );
  _.assert( o.submodule === null || o.submodule instanceof _.will.ModulesRelation );
  // _.assert( o.module  === null || o.module.rootModule === o.module || _.longHas( o.module.superRelations, module ) );

  if( o.module )
  superModuleFixate( o.module );

  if( o.submodule )
  submoduleFixate( o.submodule );

  /* */

  if( will.verbosity >= 2 )
  log();

  /* */

  return report;

  /* */

  function superModuleFixate( superModule )
  {
    let remote = superModule.pathResourceMap[ 'remote' ];
    if( remote && remote.path && remote.path.length && remote.willf && superModule.rootModule !== superModule )
    {

      if( _.arrayIs( remote.path ) && remote.path.length === 1 )
      remote.path = remote.path[ 0 ];

      _.assert( _.strIs( remote.path ) );

      let originalPath = remote.path;
      let fixatedPath = resolve( originalPath )

      let o2 = _.mapExtend( null, o );

      o2.replacer = [ 'remote', 'path' ];
      o2.originalPath = originalPath;
      o2.fixatedPath = fixatedPath;
      o2.report = report;

      o2.willfilePath = [ remote.willf.filePath ];
      let secondaryWillfilesPath = remote.module.pathResolve
      ({
        selector : 'path::module.original.willfiles',
        missingAction : 'undefine',
      });

      if( secondaryWillfilesPath )
      _.arrayAppendArraysOnce( o2.willfilePath, secondaryWillfilesPath );

      module.moduleFixateAct( o2 );

      if( !o.dry && fixatedPath )
      {
        debugger;
        superModule.remotePath = fixatedPath;
        superModule._currentRemotePathPut( fixatedPath );
        _.assert( superModule.remotePath === fixatedPath );
        _.assert( superModule.currentRemotePath === fixatedPath );
        _.assert( remote.path === fixatedPath );
      }

    }

  }

  /* */

  function submoduleFixate( submodule )
  {

    if( submodule.opener && !submodule.opener.repo.isRemote )
    return;

    let originalPath = submodule.path;
    let fixatedPath = resolve( originalPath ) /* Dmytro : submodule.fixatedPath has slash before hash, but submodule.longPath has not. It fails execution of command submodules.upgrade. See below */

    let o2 = _.mapExtend( null, o );
    o2.replacer = [ submodule.name, 'path' ];
    o2.originalPath = originalPath;
    o2.fixatedPath = fixatedPath;
    o2.willfilePath = submodule.willf.filePath;
    o2.report = report;

    module.moduleFixateAct( o2 );

    if( !o.dry && fixatedPath )
    {
      let opened = submodule.formed >= 3;
      if( opened )
      debugger;
      submodule.close();
      submodule.path = fixatedPath; /* Dmytro : I think, options path has proxy or setter that affects field longPath */
      if( submodule.opener )
      submodule.opener.remotePath = fixatedPath;
      if( opened )
      debugger;
      if( opened )
      submodule.form();
    }

  }

  /* */

  function log()
  {
    let grouped = Object.create( null );
    let result = '';

    debugger;
    if( _.mapKeys( report ).length === 0 )
    return;

    let fixated = o.upgrading ? 'was upgraded' : 'was fixated';
    if( o.dry )
    fixated = o.upgrading ? 'will be upgraded' : 'will be fixated';
    let nfixated = o.upgrading ? 'was not upgraded' : 'was not fixated';
    if( o.dry )
    nfixated = o.upgrading ? 'won\'t be upgraded' : 'won\'t be fixated';
    let skipped = 'was skipped';
    if( o.dry )
    skipped = 'will be skipped';

    let count = _.mapVals( report ).filter( ( r ) => r.performed ).length;
    let absoluteName = o.submodule ? o.submodule.decoratedAbsoluteName : o.module.decoratedAbsoluteName;
    // let absoluteName = o.module ? o.module.decoratedAbsoluteName : o.submodule.decoratedAbsoluteName;

    result += 'Remote paths of ' + absoluteName + ' ' + ( count ? fixated : nfixated ) + ( count ? ' to version' : '' );

    for( let r in report )
    {
      let line = report[ r ];
      let movePath = line.fixatedPath ? path.moveTextualReport( line.fixatedPath, line.originalPath ) : _.color.strFormat( line.originalPath, 'path' );
      if( !grouped[ movePath ] )
      grouped[ movePath ] = []
      grouped[ movePath ].push( line )
    }

    for( let move in grouped )
    {
      result += '\n  ' + move;
      for( let l in grouped[ move ] )
      {
        let line = grouped[ move ][ l ];
        if( line.performed )
        result += '\n   + ' + _.color.strFormat( line.willfilePath, 'path' ) + ' ' + fixated;
        else if( line.skipped )
        result += '\n   ! ' + _.color.strFormat( line.willfilePath, 'path' ) + ' ' + skipped;
        else
        result += '\n   ! ' + _.color.strFormat( line.willfilePath, 'path' ) + ' ' + nfixated;
      }
    }

    logger.log( result );

  }

  /* */

  function resolve( originalPath )
  {
    if( resolved[ originalPath ] )
    return resolved[ originalPath ];
    resolved[ originalPath ] = module.moduleFixatePathFor({ originalPath : originalPath, upgrading : o.upgrading });
    return resolved[ originalPath ];
  }

}

var defaults = moduleFixate.defaults = Object.create( submodulesFixate.defaults );
defaults.submodule = null;
defaults.module = null;

//

function moduleFixateAct( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( !_.mapIs( o ) )
  o = { submodule : o }

  _.routineOptions( moduleFixateAct, o );
  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 1 );
  _.assert( _.boolLike( o.dry ) );
  _.assert( _.boolLike( o.upgrading ) );
  _.assert( o.module  === null || o.module instanceof _.will.Module );
  _.assert( o.submodule === null || o.submodule instanceof _.will.ModulesRelation );
  _.assert( _.strIs( o.willfilePath ) || _.strsAreAll( o.willfilePath ) );
  _.assert( _.strIs( o.originalPath ) );
  _.assert( !o.fixatedPath || _.strIs( o.fixatedPath ) );

  o.willfilePath = _.arrayAs( o.willfilePath );
  o.report = o.report || Object.create( null );

  if( !o.fixatedPath )
  {
    if( o.reportingNegative )
    for( let f = 0 ; f < o.willfilePath.length ; f++ )
    {
      let willfilePath = o.willfilePath[ f ];
      let r = o.report[ willfilePath ] = Object.create( null );
      r.fixatedPath = o.fixatedPath;
      r.originalPath = o.originalPath;
      r.willfilePath = willfilePath;
      r.performed = 0;
      r.skipped = 1;
    }
    return 0;
  }

  if( _.arrayIs( o.replacer ) )
  {
    _.assert( o.replacer.length === 2, 'not tested' );
    // let e = '(?:\\s|.)*?';
    let e = '\\s*?.*?\\s*?.*?\\s*?.*?';
    let replacer = '';
    o.replacer = _.regexpsEscape( o.replacer );
    replacer += '(' + o.replacer[ 0 ] + '\\s*?:' + e + ')';
    o.replacer.splice( 0, 1 );
    replacer += '(' + o.replacer.join( '\\s*?:' + e + ')?(' ) + '\\s*:' + e + ')?';
    replacer += '(' + _.regexpEscape( o.originalPath ) + ')';
    o.replacer = new RegExp( replacer, '' );
  }

  _.assert( _.regexpIs( o.replacer ) );

  // if( o.willfilePath )
  for( let f = 0 ; f < o.willfilePath.length ; f++ )
  fileReplace( o.willfilePath[ f ] );

  return _.mapKeys( o.report ).length;

  /* */

  function fileReplace( willfilePath )
  {

    debugger;
    try
    {

      let code = fileProvider.fileRead( willfilePath );

      if( !_.strHas( code, o.originalPath ) )
      {
        // debugger;
        throw _.err( 'Willfile', willfilePath, 'does not have path', o.originalPath );
      }

      if( !_.strHas( code, o.replacer ) )
      {
        // debugger;
        throw _.err( 'Willfile', willfilePath, 'does not have path', o.originalPath );
      }

      if( !o.dry )
      {
        code = _.strReplaceAll( code, o.replacer, ( match, it ) =>
        {
          it.groups = it.groups.filter( ( e ) => !!e );
          it.groups[ it.groups.length-1 ] = o.fixatedPath;
          return it.groups.join( '' );
        });
        fileProvider.fileWrite( willfilePath, code );
      }

      let r = o.report[ willfilePath ] = Object.create( null );
      r.fixatedPath = o.fixatedPath;
      r.originalPath = o.originalPath;
      r.willfilePath = willfilePath;
      r.performed = 1;
      r.skipped = 0;

      return true;
    }
    catch( err )
    {
      debugger;
      err = _.err( err, '\nFailed to fixated ' + _.color.strFormat( willfilePath, 'path' ) );
      if( o.reportingNegative )
      {
        let r = o.report[ willfilePath ] = Object.create( null );
        r.fixatedPath = o.fixatedPath;
        r.originalPath = o.originalPath;
        r.willfilePath = willfilePath;
        r.performed = 0;
        r.skipped = 0;
        r.err = err;
      }
      // if( !o.dry )
      // throw err;
      if( will.verbosity >= 3 )
      logger.log( _.errOnce( _.errBrief( err ) ) );
      // _.errLogOnce( _.errBrief( err ) );
      // if( will.verbosity >= 2 )
      // o.log += '\n  in ' + _.color.strFormat( willfilePath, 'path' ) + ' was not found';
    }

  }

}

var defaults = moduleFixateAct.defaults = Object.create( moduleFixate.defaults );
defaults.willfilePath = null;
defaults.originalPath = null;
defaults.fixatedPath = null;
defaults.replacer = null;
defaults.report = null;

//

function moduleFixatePathFor( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 1 );
  _.assert( _.boolLike( o.upgrading ) );
  _.routineOptions( moduleFixatePathFor, o );

  if( !o.originalPath )
  return false;

  if( _.arrayIs( o.originalPath ) && o.originalPath.length === 0 )
  return false;

  let vcs = will.vcsProviderFor( o.originalPath );

  if( !vcs )
  return false;

  if( !o.upgrading )
  if( vcs.pathIsFixated( o.originalPath ) )
  return false;

  let fixatedPath = vcs.pathFixate( o.originalPath );

  if( !fixatedPath )
  return false;

  if( fixatedPath === o.originalPath )
  return false;

  return fixatedPath;
}

var defaults = moduleFixatePathFor.defaults = Object.create( null );
defaults.originalPath = null;
defaults.upgrading = null;

//

function submodulesVerify( o )
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  _.routineOptions( submodulesVerify, o );

  let o2 = _.mapExtend( null, o );
  o2.modules = _.mapVals( module.submoduleMap );
  o2.withStem = 1;
  return will.modulesVerify( o2 );
}

var defaults = submodulesVerify.defaults = _.mapExtend( null, _.Will.prototype.modulesFor.defaults );

defaults.recursive = 1;
defaults.throwing = 1;
defaults.asMap = 0;

defaults.hasFiles = 1;
defaults.isValid = 1;
defaults.isRepository = 1;
defaults.hasRemote = 1;
defaults.isUpToDate = 1

delete defaults.withStem;
delete defaults.onEach;
delete defaults.onEachModule;
delete defaults.onEachJunction;
// delete defaults.withOut;
// delete defaults.withIn;

_.assert( defaults.outputFormat === undefined );
_.assert( defaults.withDisabledSubmodules === 0 );
_.assert( defaults.withDisabledModules === 0 );

// var defaults  = submodulesVerify.defaults = Object.create( null );
//
// defaults.recursive = 1;
// defaults.throwing = 1;
// defaults.asMap = 0;
//
// defaults.hasFiles = 1;
// defaults.isValid = 1;
// defaults.isRepository = 1;
// defaults.hasRemote = 1;
// defaults.isUpToDate = 1

// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//   let totalNumber = _.mapKeys( module.submoduleMap ).length;
//   let verifiedNumber = 0;
//   let time = _.time.now();
//
//   _.assert( module.preformed > 0  );
//   _.assert( arguments.length === 1 );
//
//   _.routineOptions( submodulesVerify, o );
//
//   logger.up();
//
//   let modules = module.modulesEach({ outputFormat : '/', recursive : o.recursive, withDisabledStem : 1 });
//   let ready = new _.Consequence().take( null );
//
//   _.each( modules, ( r ) =>
//   {
//     // ready.then( () => reform( r ) )
//     ready.then( () => onEach( r ) );
//     ready.then( onEachEnd );
//   })
//
//   ready.then( () =>
//   {
//     if( o.asMap )
//     return { verifiedNumber, totalNumber };
//
//     logger.log( verifiedNumber + '/' + totalNumber + ' submodule(s) of ' + module.decoratedQualifiedName + ' were verified in ' + _.time.spent( time ) );
//     logger.down();
//     return verifiedNumber === totalNumber;
//   })
//
//   return ready;
//
//   /* */
//
//   function onEach( r )
//   {
//
//     // if( o.hasFiles )
//     // if( !r.opener.repo.hasFiles )
//     // {
//     //   if( o.throwing )
//     //   throw _.errBrief( '! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), 'does not have files' );
//     //   return false;
//     // }
//     //
//     // _.assert
//     // (
//     //   !!r.opener && r.opener.formed >= 2,
//     //   () => 'Submodule', ( r.opener ? r.opener.qualifiedName : n ), 'was not preformed to verify'
//     // );
//     //
//     // /* isValid */
//     //
//     // if( o.isValid )
//     // if( !r.opener.isValid() )
//     // throw _.err( opener.error, '\n! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), 'is downloaded, but it\'s not valid.' );
//     //
//     // /* is remote / enabled */
//     //
//     // if( !r.opener.repo.isRemote )
//     // return true;
//     // if( r.relation && !r.relation.enabled )
//     // return true;
//     //
//     // /* repository check */
//     //
//     // if( o.isRepository )
//     // if( !r.opener.repo.isRepository )
//     // {
//     //   if( o.throwing )
//     //   throw _.errBrief( '! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), `is downloaded, but it's not a repository` );
//     //   return false;
//     // }
//     //
//     // let remoteProvider = will.fileProvider.providerForPath( r.opener.repo.remotePath );
//     //
//     // /* origin check */
//     //
//     // if( o.hasRemote )
//     // {
//     //   let result = remoteProvider.hasRemote
//     //   ({
//     //     localPath : r.opener.repo.downloadPath,
//     //     remotePath : r.opener.repo.remotePath
//     //   });
//     //
//     //   if( !result.remoteIsValid )
//     //   {
//     //     if( o.throwing )
//     //     throw _.errBrief
//     //     (
//     //       '! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), 'has different origin url:',
//     //       _.color.strFormat( result.originVcsPath, 'path' ), ', expected url:', _.color.strFormat( result.remoteVcsPath, 'path' )
//     //     );
//     //
//     //     return false;
//     //   }
//     // }
//     //
//     // /* version check */
//     //
//     // if( o.isUpToDate )
//     // {
//     //   if( r.opener.repo.isUpToDate )
//     //   return true;
//     //
//     //   if( !o.throwing )
//     //   return false;
//     //
//     //   let remoteParsed = remoteProvider.pathParse( r.opener.repo.remotePath );
//     //   let remoteVersion = remoteParsed.hash || 'master';
//     //   let localVersion = remoteProvider.versionLocalRetrive( r.opener.repo.downloadPath );
//     //
//     //   if( remoteVersion === localVersion )
//     //   throw _.errBrief( '! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), 'is not up to date!' );
//     //
//     //   throw _.errBrief
//     //   (
//     //     '! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), 'has version different from that is specified in will-file!',
//     //     '\nCurrent:', localVersion,
//     //     '\nExpected:', remoteVersion
//     //   );
//     // }
//     //
//     // return true;
//   }
//
//   /*  */
//
//   function onEachEnd( verified )
//   {
//     if( verified )
//     verifiedNumber += 1;
//     return verified;
//   }
//
//   /*  */
//
//   // function reform( relation )
//   // {
//   //   let con = new _.Consequence().take( null );
//   //   con.then( () => relation.opener.repo.status({ all : 1, invalidating : 1 }) )
//   //   con.then( () => relation )
//   //   return con;
//   // }
//
// }
//
// var defaults  = submodulesVerify.defaults = Object.create( null );
//
// defaults.recursive = 1;
// defaults.throwing = 1;
// defaults.asMap = 0;
//
// defaults.hasFiles = 1;
// defaults.isValid = 1;
// defaults.isRepository = 1;
// defaults.hasRemote = 1;
// defaults.isUpToDate = 1

//

function submodulesRelationsFilter( o )
{
  let module = this;
  let will = module.will;

  o = _.routineOptions( submodulesRelationsFilter, arguments );

  // if( module.id === 178 )
  // debugger;

  // if( _global_.debugger )
  // debugger;

  let result = module.submodulesRelationsOwnFilter( o );
  let resultJunctions = will.junctionsFrom( result );

  let junction = will.junctionFrom( module );
  let junctions = junction.submodulesJunctionsFilter( _.mapOnly( o, junction.submodulesJunctionsFilter.defaults ) );

  // if( junctions.length )
  // debugger;
  // result = _.arrayAppendArraysOnce( result, junctions.map( ( junction ) => junction.objects ) );

  junctions.forEach( ( junction2 ) =>
  {
    if( _.longHas( resultJunctions, junction2 ) )
    return;
    if( !junction2.object )
    return;
    // debugger;
    _.arrayAppendOnceStrictly( result, junction2.object );
    _.arrayAppendOnceStrictly( resultJunctions, junction2 );
  });

  // if( o.withPeers )
  // if( module.peerModule )
  // moduleLook( module.peerModule );

  if( o.withoutDuplicates )
  result = result.filter( ( object2 ) =>
  {
    let junction2 = object2.toJunction();
    return !junction2.isOut || !junction2.peer || !_.longHas( resultJunctions, junction2.peer );
  });

  return result;
}

submodulesRelationsFilter.defaults =
{

  ... _.Will.RelationFilterDefaults,
  withPeers : 1,
  withoutDuplicates : 0,

}

//

function submodulesRelationsOwnFilter( o )
{
  let module = this;
  let will = module.will;
  let result = [];

  o = _.routineOptions( submodulesRelationsOwnFilter, arguments );

  let filter = _.mapOnly( o, will.relationFit.defaults );

  moduleLook( module );

  if( o.withPeers )
  if( module.peerModule )
  moduleLook( module.peerModule );

  if( o.withoutDuplicates )
  result = result.filter( ( module ) =>
  {
    return !module.isOut || !module.peerModule || !_.longHas( result, module.peerModule );
  });

  if( o.allVariants === 0 )
  if( result.length )
  result = _.longOnce( result, ( object ) => object.toJunction() );

  return result;

  /* */

  function moduleLook( module )
  {

    for( let s in module.submoduleMap )
    {
      let relation = module.submoduleMap[ s ];

      moduleAppendMaybe( relation );
      if( relation.opener )
      moduleAppendMaybe( relation.opener );
      if( relation.opener.openedModule )
      moduleAppendMaybe( relation.opener.openedModule );

      if( o.withPeers )
      if( relation.opener && relation.opener.peerModule )
      {
        moduleAppendMaybe( relation.opener.peerModule );
      }

    }

  }

  /* */

  function moduleAppendMaybe( module )
  {

    if( !will.relationFit( module, filter ) )
    return;

    // _.assert( module instanceof _.will.ModuleJunction );
    // _.assert( module instanceof _.will.ModulesRelation || module instanceof _.will.Module );
    _.assert( will.ObjectIs( module ) );
    _.arrayAppendOnce( result, module );

  }

  /* */

}

submodulesRelationsOwnFilter.defaults =
{

  ... _.Will.RelationFilterDefaults,
  withPeers : 1,
  withoutDuplicates : 0,
  allVariants : 0,

}

//

function submodulesAdd( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let counter = 0;

  o = _.routineOptions( submodulesAdd, arguments );

  let junctions = will.junctionsReform( o.modules );

  junctions.forEach( ( junction ) =>
  {
    _.assert( _.will.isJunction( junction ) );
    if( !junction.module )
    return;
    if( !junction.module.about.name )
    return;
    if( junction.module === module )
    return;

    if( _.any( module.submoduleMap, ( relation ) => will.junctionFrom( relation ) === junction ) )
    {
      debugger;
      return;
    }

    let o2 = Object.create( null );
    o2.module = module;
    o2.path = junction.remotePath || junction.localPath;
    o2.name = junction.module.originDirNameGet();
    let relation = new _.will.ModulesRelation( o2 );
    ready.then( () => relation.form() );
    ready.then( () => counter += 1 );

  });

  ready.then( ( arg ) =>
  {
    return module.willfilesSave();
  });

  ready.finally( ( err, arg ) =>
  {
    debugger;
    if( err )
    throw _.err( err, `\nFaield add new submodules to ${module.nameWithLocationGet()}` );
    return counter;
  });

  debugger;
  return ready;
}

submodulesAdd.defaults =
{
  modules : null,
}

//

function submodulesReload()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  return module.ready
  .then( function( arg )
  {
    return module._subModulesForm();
  })
  .split();

}

//

function submodulesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  module.stager.stageStatePausing( 'subModulesFormed', 0 );
  module.stager.tick();

  return module.stager.stageConsequence( 'subModulesFormed' );
}

//

function _subModulesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.preformed );

  let con = _.Consequence().take( null );

  // console.log( '_subModulesForm', module.absoluteName ); debugger; /* yyy */

  // debugger;
  module._resourcesAllForm( _.will.ModulesRelation, con );
  // debugger;

  con.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  return con.split();
}

// --
// peer
// --

function peerModuleOpen( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  o = _.routineOptions( peerModuleOpen, arguments );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( !!will.formed );
  _.assert( !!module.preformed );

  let con = _.Consequence().take( null );

  con.then( ( arg ) =>
  {
    if( module.peerModule )
    return module.peerModule;
    return open();
  });

  con.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  return con;

  /* */

  function open()
  {
    let peerWillfilesPath = module.peerWillfilesPathFromWillfiles();
    let localPath = _.Will.CommonPathFor( peerWillfilesPath );

    /*
    to avoid second attempt of opening of bad module during stage of opening modules
    */

    if( !will.willfilesReadEndTime && will.openersErrorsMap[ localPath ] )
    {
      return null;
    }

    if( module.isOut && !will.withIn )
    {
      return null;
    }

    if( !module.isOut && !will.withOut )
    {
      return null;
    }

    let o2 =
    {
      willfilesPath : peerWillfilesPath,
      rootModule : module.rootModule,
      peerModule : module,
      searching : 'exact',
      isAuto : 1,
      reason : 'peer',
    }

    if( module.isOut && module.rootModule === module )
    {
      // debugger;
      delete o2.rootModule;
    }

    let opener2 = will._openerMake
    ({
      throwing : 0,
      opener : o2,
    })

    _.assert( !!opener2 );
    _.assert( opener2.peerModule === module );

    return opener2.open({ throwing : 1 })
    .finally( ( err, peerModule ) =>
    {

      peerModule = peerModule || opener2.openedModule || null;
      _.assert( peerModule === null || peerModule.peerModule === module );

      if( err )
      {
        module.peerModule = null;
        opener2.openedModule = null;
        opener2.finit();
        if( peerModule && !peerModule.isUsedManually() )
        peerModule.finit();
        if( o.throwing )
        {
          throw err;
        }
        else
        {
          if( module.isOut )
          logger.log( _.errOnce( _.errBrief( err ) ) );
          _.errAttend( err );
        }
        return null;
      }
      else
      {
        if( module.isOut && module.rootModule === module )
        {
          // debugger;
          module.rootModule = peerModule.rootModule;
        }
      }

      module.peerModule = peerModule;
      return peerModule;
    });
  }

}

peerModuleOpen.defaults =
{
  throwing : 1,
}

//

function _peerModulesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!will.formed );
  _.assert( !!module.preformed );

  return module.peerModuleOpen({ throwing : 0 });
}

//

function _peerChanged()
{
  let module = this;
  let will = module.will;

  if( !will )
  return;
  if( !module.dirPath )
  return;

  if( module.isOut )
  {
    let originalWillfilesPath = module.originalWillfilesPath;
    module._peerWillfilesPathPut( originalWillfilesPath );
    if( module.peerModule )
    module._peerInPathPut( module.peerModule.inPath );
  }
  else
  {
    let outfilePath = null;
    if( module.about.name )
    outfilePath = module.outfilePathGet();
    module._originalWillfilesPathPut( module.willfilesPath );
    module._peerWillfilesPathPut( outfilePath );
    module._peerInPathPut( module.outPath );
  }

}

//

function peerModuleSet( src )
{
  let module = this;
  let will = module.will;

  _.assert( src === null || src instanceof _.will.Module );

  if( module.peerModule === src )
  return src;

  if( src && src.remotePath )
  {
    // debugger;
    let peerRemotePath = src.peerRemotePathGet();
    /*
      if peer module is not formed then peerRemotePath is not deducable
    */
    if( peerRemotePath )
    {
      _.assert( module.remotePath === null || module.remotePath === peerRemotePath );
      _.assert( module.downloadPath === null || module.downloadPath === src.downloadPath );
      module.remotePathEachAdopt({ remotePath : peerRemotePath, downloadPath : module.downloadPath });
    }
  }

  let was = module.peerModule;
  module[ peerModuleSymbol ] = src;

  if( src )
  {
    let fileProvider = will.fileProvider;
    let path = fileProvider.path;
    if( src.peerModule !== null && src.peerModule !== module )
    {
      debugger;
      throw _.err
      (
          'Several peer modules'
        + `\n  ${path.moveTextualReport( module.commonPath, path.common( module.peerWillfilesPath ) )}`
        + `\n  ${path.moveTextualReport( src.commonPath, path.common( src.peerWillfilesPath ) )}`
      );
    }
    src.peerModule = module;
  }
  else if( was )
  {
    was.peerModule = null;
  }

  _.assert( module.peerModule === null || module.peerModule.peerModule === module );

  return src;
}

//

function peerWillfilesPathFromWillfiles( willfilesArray )
{
  let module = this;
  let will = module.will;

  willfilesArray = willfilesArray || module.willfilesArray;
  willfilesArray = _.arrayAs( willfilesArray );

  let peerWillfilesPath = module.willfilesArray.map( ( willf ) =>
  {
    _.assert( willf instanceof _.will.Willfile );
    return willf.peerWillfilesPathGet();
  });

  peerWillfilesPath = _.longOnce( _.arrayFlatten( peerWillfilesPath ) );

  return peerWillfilesPath;
}

//

function submodulesPeersOpen_body( o )
{
  let module = this;
  let will = module.will;
  let ready = new _.Consequence().take( null );

  let o2 = _.mapExtend( null, o );
  delete o2.throwing;
  let modules = module.modulesEach.body.call( module, o2 );

  modules.forEach( ( module2 ) =>
  {
    if( module2 !== null )
    ready.then( () => module2.peerModuleOpen({ throwing : o.throwing }) );
  });

  return ready;
}

var defaults = submodulesPeersOpen_body.defaults = _.mapExtend( null, modulesEach.body.defaults );

defaults.throwing = 1;

let submodulesPeersOpen = _.routineFromPreAndBody( modulesEach_pre, submodulesPeersOpen_body );

//

function peerModuleFromJunction( junction )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( junction )
  junction.reform();
  else
  junction = will.junctionReform( module );

  if( !module.peerModule && junction.peer && junction.peer.modules.length )
  {
    let peerLocalPath = module.peerLocalPathGet();
    if( peerLocalPath )
    junction.peer.modules.some( ( module2 ) =>
    {
      if( module2.localPath === peerLocalPath )
      {
        _.assert
        (
          0
          , () => `Probably something wrong because modules should be aware of its peer.`
                + `\nBut ${module.absoluteName} at ${module.localPath} is not aware`
        );
        logger.error
        (
            `Probably something wrong because modules should be aware of its peer.`
          , `\nBut ${module.absoluteName} at ${module.localPath} is not aware`
        )
        module.peerModule = module2;
        _.assert( module.peerModule === module2 );
        _.assert( module2.peerModule === module );
        module.assertIsValidIntegrity();
        module2.assertIsValidIntegrity();
        return true;
      }
    });
  }

}

// --
// resource
// --

function resourcesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  module.stager.stageStatePausing( 'resourcesFormed', 0 );
  module.stager.tick();

  return module.stager.stageConsequence( 'resourcesFormed' );
}

//

function _resourcesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let con = new _.Consequence().take( null );

  if( module.submodulesAllAreDownloaded() && module.submodulesAllAreValid() )
  {

    con.then( () => module._resourcesFormAct() );

    con.then( ( arg ) =>
    {
      return arg;
    });

  }
  else
  {
    if( will.verbosity === 2 ) /* xxx : throw error instead? */
    logger.error( ' ! One or several submodules of ' + module.decoratedQualifiedName + ' were not downloaded!'  );
  }

  return con;
}

//

function _resourcesFormAct()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.preformed );

  let con = _.Consequence().take( null );

  /* */

  module._resourcesAllForm( _.will.ModulesRelation, con );
  module._resourcesAllForm( _.will.Exported, con );
  module._resourcesAllForm( _.will.PathResource, con );
  module._resourcesAllForm( _.will.Reflector, con );
  module._resourcesAllForm( _.will.Step, con );
  module._resourcesAllForm( _.will.Build, con );

  /* */

  con.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  return con.split();
}

//

function _resourcesAllForm( Resource, con )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.constructorIs( Resource ) );
  _.assert( arguments.length === 2 );

  for( let s in module[ Resource.MapName ] )
  {
    let resource = module[ Resource.MapName ][ s ];
    _.assert( !!resource.formed );
    con.then( ( arg ) => resource.form2() );
  }

  for( let s in module[ Resource.MapName ] )
  {
    let resource = module[ Resource.MapName ][ s ];
    con.then( ( arg ) => resource.form3() );
  }

}

//

function resourceClassForKind( resourceKind )
{
  let module = this;
  let will = module.will;
  let result;
  result = _.will[ will.ResourceKindToClassName.forKey( resourceKind ) ];
  // result = will[ will.ResourceKindToClassName.forKey( resourceKind ) ]; /* Dmytro : previous */

  _.assert( arguments.length === 1 );
  _.sure( _.routineIs( result ), () => 'Cant find class for resource kind ' + _.strQuote( resourceKind ) );

  return result;
}

//

function resourceMapForKind( resourceKind )
{
  let module = this;
  let will = module.will;
  let result;

  _.assert( module.rootModule instanceof _.will.Module );

  if( resourceKind === 'export' )
  result = module.buildMap;
  else if( resourceKind === 'about' )
  result = module.about.exportStructure();
  else if( resourceKind === 'module' )
  result = module.rootModule.moduleWithNameMap;
  else
  result = module[ will.ResourceKindToMapName.forKey( resourceKind ) ];

  _.assert( arguments.length === 1 );
  _.sure( _.objectIs( result ), () => 'Cant find resource map for resource kind ' + _.strQuote( resourceKind ) );

  return result;
}

//

function resourceMaps()
{
  let module = this;
  let will = module.will;

  let ResourcesNames =
  [
    'module',
    'submodule',
    'path',
    'reflector',
    'step',
    'build',
    'exported',
  ]

  let resources =
  {
    'module' : module.resourceMapForKind( 'module' ),
    'submodule' : module.resourceMapForKind( 'submodule' ),
    'path' : module.resourceMapForKind( 'path' ),
    'reflector' : module.resourceMapForKind( 'reflector' ),
    'step' : module.resourceMapForKind( 'step' ),
    'build' : module.resourceMapForKind( 'build' ),
    'exported' : module.resourceMapForKind( 'exported' ),
  }

  return resources;
}

//

function resourceMapsForKind( resourceSelector )
{
  let module = this;
  let will = module.will;

  if( !_.path.isGlob( resourceSelector ) )
  return module.resourceMapForKind( resourceSelector );

  let resources = module.resourceMaps();
  let result = _.path.globShortFilterKeys( resources, resourceSelector );
  return result;
}

//

function resourceGet( resourceKind, resourceName )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( resourceKind ) );
  _.assert( _.strIs( resourceName ) );

  let map = module.resourceMapForKind( resourceKind );

  return map[ resourceName ];
}

//

function resourceObtain( resourceKind, resourceName )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( resourceName ) );

  let resourceMap = module.resourceMapForKind( resourceKind );

  _.sure( !!resourceMap, 'No resource map of kind' + resourceKind );

  let resource = resourceMap[ resourceName ];

  if( !resource )
  resource = module.resourceAllocate( resourceKind, resourceName );

  _.assert( resource instanceof _.will.Resource );
  if( resource instanceof _.will.PathResource )
  _.assert( module.pathResourceMap[ resource.name ] === resource );

  return resource;
}

//

function resourceAllocate_pre( routine, args )
{
  let module = this;
  let will = module.will;

  let o = args[ 0 ];
  if( args.length === 2 )
  o = { resourceKind : args[ 0 ], resourceName : args[ 1 ] }

  o = _.routineOptions( routine, o );
  _.assert( args.length === 1 || args.length === 2 );
  _.assert( _.strIs( o.resourceName ) );

  return o;
}

function resourceAllocate_body( o )
{
  let module = this;
  let will = module.will;

  o = _.assertRoutineOptions( resourceAllocate, o );
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.resourceName ) );

  // if( o.resourceName === "exported.dir.proto.export" )
  // debugger;
  //
  // if( o.generating )
  // {
  //   let map = module.resourceMapForKind( o.resourceKind );
  //   let resource2 = map[ o.resourceName ];
  //   if( resource2 && resource2.criterion.generated )
  //   {
  //     return resource2;
  //   }
  // }

  let resourceName2 = module.resourceNameAllocate( o );
  let cls = module.resourceClassForKind( o.resourceKind );
  let resource;

  if( o.generating )
  {

    let map = module.resourceMapForKind( o.resourceKind );
    let resource2 = map[ resourceName2 ];
    if( resource2 && resource2.criterion.generated )
    {
      return resource2;
    }

  }

  let o2 = { module : module, name : resourceName2 };
  o2.criterion = { generated : 1 };
  resource = new cls( o2 ).form1();

  return resource;
}

resourceAllocate_body.defaults =
{
  resourceKind : null,
  resourceName : null,
  generating : 0,
}

let resourceAllocate = _.routineFromPreAndBody( resourceAllocate_pre, resourceAllocate_body );
let resourceGenerate = _.routineDefaults( null, resourceAllocate, { generating : 1 } );

//

function resourceNameAllocate_pre( routine, args )
{
  let module = this;
  let will = module.will;

  let o = args[ 0 ];
  if( args.length === 2 )
  o = { resourceKind : args[ 0 ], resourceName : args[ 1 ] }

  o = _.routineOptions( routine, o );
  _.assert( args.length === 1 || args.length === 2 );
  _.assert( _.strIs( o.resourceName ) );

  return o;
}

function resourceNameAllocate_body( o )
{
  let module = this;
  let will = module.will;

  o = _.assertRoutineOptions( resourceAllocate, o );
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.resourceName ) );

  let map = module.resourceMapForKind( o.resourceKind );
  let resource2 = map[ o.resourceName ];
  if( resource2 === undefined )
  return o.resourceName;

  if( o.generating )
  if( resource2.criterion.generated )
  {
    return o.resourceName;
  }

  let counter = 1;
  let resourceName2;

  let ends = /\.\d+$/;
  if( ends.test( o.resourceName ) )
  o.resourceName = o.resourceName.replace( ends, '' );

  do
  {
    resourceName2 = o.resourceName + '.' + counter;
    counter += 1;
    if( map[ resourceName2 ] === undefined )
    break;
    if( map[ resourceName2 ] !== undefined )
    {
      if( o.generating && map[ resourceName2 ].criterion.generated )
      break;
    }
  }
  while( true );

  return resourceName2;
}

resourceNameAllocate_body.defaults =
{
  resourceKind : null,
  resourceName : null,
  generating : 0,
}

let resourceNameAllocate = _.routineFromPreAndBody( resourceNameAllocate_pre, resourceNameAllocate_body );
let resourceNameGenerate = _.routineDefaults( null, resourceNameAllocate, { generating : 1 } );

// --
// clean
// --

function cleanWhatSingle( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let exps = module.exportsResolve();
  let filePaths = [];

  o = _.routineOptions( cleanWhatSingle, arguments );

  if( o.files === null )
  o.files = Object.create( null );
  o.files[ '/' ] = o.files[ '/' ] || [];

  // logger.log( 'cleanWhatSingle', module.commonPath );
  // if( _.strHas( module.commonPath, 'group10' ) )
  // debugger;

  /* submodules */

  if( o.cleaningSubmodules )
  {

    find( module.cloneDirPathGet() );
    if( module.rootModule !== module )
    find( module.cloneDirPathGet( module ) );

  }

  /* out */

  if( o.cleaningOut )
  {
    let files = [];

    if( module.about.name )
    {
      let outFilePath = module.outfilePathGet();
      _.arrayAppendArrayOnce( files, [ outFilePath ] );
    }
    for( let e = 0 ; e < exps.length ; e++ )
    {
      let exp = exps[ e ];
      let archiveFilePath = exp.archiveFilePathFor();
      _.arrayAppendArrayOnce( files, [ archiveFilePath ] );
    }

    find( files );
  }

  /* temp dir */

  if( o.cleaningTemp )
  {
    let resource = module.pathOrReflectorResolve( 'temp' );

    if( resource && resource instanceof _.will.Reflector )
    {
      let o2 = resource.optionsForFindExport();
      o2.mandatory = 0;
      find( o2 );
    }
    else if( resource && resource instanceof _.will.PathResource )
    {
      let filePath = resource.path;
      if( !filePath )
      filePath = [];
      filePath = _.arrayAs( path.s.join( module.inPath, filePath ) );
      find( filePath );
    }

  }

  filePaths.sort();

  return o.files;

  /* - */

  function find( op )
  {

    if( _.arrayIs( op ) || _.strIs( op ) )
    op = { filter : { filePath : op } }

    if( op === null )
    return;

    if( _.arrayIs( op.filter.filePath.length ) && !op.filter.filePath.length )
    return;

    let def =
    {
      verbosity : 0,
      allowingMissed : 1,
      withDirs : 1,
      withTerminals : 1,
      maskPreset : 0,
      outputFormat : 'absolute',
      writing : 0,
      deletingEmptyDirs : 1,
      visitingCertain : !o.fast,
    }

    _.mapSupplement( op, def );

    op.filter = op.filter || Object.create( null );
    op.filter.recursive = 2;

    let found = fileProvider.filesDelete( op );
    _.assert( op.filter.formed === 5 );

    let r = path.group
    ({
      keys : op.filter.filePath,
      vals : found,
      result : o.files,
    });

  }

}

cleanWhatSingle.defaults =
{
  cleaningSubmodules : 1,
  cleaningOut : 1,
  cleaningTemp : 1,
  fast : 0,
  files : null,
}

//

function cleanWhat( o )
{
  let module = this;
  let will = module.will;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.routineOptions( cleanWhat, arguments );

  if( o.files === null )
  o.files = Object.create( null );
  o.files[ '/' ] = o.files[ '/' ] || [];

  let modules = module.modulesEach
  ({
    recursive : o.recursive,
    withStem : 1,
    withDisabledStem : 1,
  });

  modules.forEach( ( module2 ) =>
  {
    if( module2 === null )
    return;
    let o2 = _.mapExtend( null, o );
    delete o2.recursive;
    module2.cleanWhatSingle( o2 );
  });

  return o.files;
}

var defaults = cleanWhat.defaults = Object.create( cleanWhatSingle.defaults );

defaults.recursive = 0;

//

function cleanLog( o )
{
  let module = this;
  let will = module.will;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let time = _.time.now();

  o = _.routineOptions( cleanLog, arguments );

  if( !o.files )
  {
    let o2 = _.mapExtend( null, o );
    delete o2.files;
    delete o2.explanation;
    delete o2.spentTime;
    o.files = module.cleanWhat( o2 );
  }

  debugger;
  let o3 = _.mapOnly( o, will.cleanLog.defaults );
  return will.cleanLog( o3 );
}

var defaults = cleanLog.defaults = Object.create( cleanWhat.defaults );

defaults.files = null;
defaults.explanation = ' . Clean will delete ';
defaults.beginTime = null;
defaults.spentTime = null;
defaults.asCommand = 0;

//

function clean( o )
{
  let module = this;
  let will = module.will;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routineOptions( clean, arguments );

  if( o.beginTime === null )
  o.beginTime = _.time.now();

  let o2 = _.mapOnly( o, module.cleanWhat.defaults );
  o.files = module.cleanWhat( o2 );

  debugger;

  let o3 = _.mapOnly( o, will.cleanDelete.defaults );
  will.cleanDelete( o3 );

  let o4 = _.mapOnly( o, will.cleanLog.defaults );
  will.cleanLog( o4 );

  return o.files;
}

var defaults = clean.defaults = Object.create( cleanWhat.defaults );

defaults.beginTime = null;
defaults.dry = 0;
defaults.asCommand = 0;

// --
// resolver
// --

function resolve_pre( routine, args )
{
  let module = this;
  let o = args[ 0 ];

  if( _.strIs( o ) || _.arrayIs( o ) )
  o = { selector : o }

  _.routineOptions( routine, o );

  if( o.visited === null )
  o.visited = [];

  o.baseModule = module;

  _.will.Resolver.resolve.pre.call( _.will.Resolver, routine, [ o ] );

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( _.arrayIs( o.visited ) );

  return o;
}

//

function resolve_body( o )
{
  let module = this;
  let will = module.will;
  _.assert( o.baseModule === module );
  let result = _.will.Resolver.resolve.body.call( _.will.Resolver, o );

  if( o.pathUnwrapping )
  _.assert( !result || !( result instanceof _.will.PathResource ) );

  return result;
}

_.routineExtend( resolve_body, _.will.Resolver.resolve );

let resolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

//

let resolveMaybe = _.routineFromPreAndBody( resolve_pre, resolve_body );

_.routineExtend( resolveMaybe, _.will.Resolver.resolveMaybe );

//

let resolveRaw = _.routineFromPreAndBody( resolve_pre, resolve_body );

_.routineExtend( resolveRaw, _.will.Resolver.resolveRaw );

//

let pathResolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

_.routineExtend( pathResolve, _.will.Resolver.pathResolve );

//

// function pathOrReflectorResolve( o )
// {
//   let module = this;
//   let will = module.will;
//   let resource;
//
//   if( _.strIs( o ) )
//   o = { selector : arguments[ 0 ] }
//   _.assert( _.strIs( o.selector ) );
//   _.routineOptions( pathOrReflectorResolve, o );
//
//   resource = module.reflectorResolve
//   ({
//     selector : 'reflector::' + o.selector,
//     pathResolving : 'in',
//     missingAction : 'undefine',
//   });
//
//   if( reflector )
//   return reflector;
//
//   resource = module.pathResolve
//   ({
//     selector : 'path::' + o.selector,
//     pathResolving : 'in',
//     missingAction : 'undefine',
//     pathUnwrapping : 0,
//   });
//
//   return resource;
// }
//
// pathOrReflectorResolve.defaults =
// {
//   selector : null,
// }

function pathOrReflectorResolve_body( o )
{
  let module = this;
  let will = module.will;
  _.assert( o.baseModule === module );
  _.assert( arguments.length === 1 );
  let result = _.will.Resolver.pathOrReflectorResolve.body.call( _.will.Resolver, o );
  return result;
}

_.routineExtend( pathOrReflectorResolve_body, _.will.Resolver.pathOrReflectorResolve );

let pathOrReflectorResolve = _.routineFromPreAndBody( resolve_pre, pathOrReflectorResolve_body );

//

function filesFromResource_pre( routine, args )
{
  let module = this;
  let o = args[ 0 ];

  if( _.strIs( o ) || _.arrayIs( o ) )
  o = { selector : o }

  _.routineOptions( routine, o );

  if( o.visited === null )
  o.visited = [];

  o.baseModule = module;

  _.will.Resolver.filesFromResource.pre.call( _.will.Resolver, routine, [ o ] );

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  // _.assert( _.longHas( [ null, 0, false, 'in', 'out' ], o.pathResolving ), 'Unknown value of option path resolving', o.pathResolving );
  // _.assert( _.longHas( [ 'undefine', 'throw', 'error' ], o.missingAction ), 'Unknown value of option missing action', o.missingAction );
  // _.assert( _.longHas( [ 'default', 'resolved', 'throw', 'error' ], o.prefixlessAction ), 'Unknown value of option prefixless action', o.prefixlessAction );
  _.assert( _.arrayIs( o.visited ) );
  // _.assert( !o.defaultResourceKind || !_.path.isGlob( o.defaultResourceKind ), 'Expects non glob {-defaultResourceKind-}' );

  return o;
}

function filesFromResource_body( o )
{
  let module = this;
  let will = module.will;
  _.assert( o.baseModule === module );
  let result = _.will.Resolver.filesFromResource.body.call( _.will.Resolver, o );
  return result;
}

_.routineExtend( filesFromResource_body, _.will.Resolver.filesFromResource );

let filesFromResource = _.routineFromPreAndBody( filesFromResource_pre, filesFromResource_body );

//

let submodulesResolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

_.routineExtend( submodulesResolve, _.will.Resolver.submodulesResolve );

_.assert( _.will.Resolver.submodulesResolve.defaults.defaultResourceKind === 'submodule' );
_.assert( submodulesResolve.defaults.defaultResourceKind === 'submodule' );

//

function reflectorResolve_body( o )
{
  let module = this;
  let will = module.will;
  _.assert( o.baseModule === module );
  let result = _.will.Resolver.reflectorResolve.body.call( _.will.Resolver, o );
  return result;
}

_.routineExtend( reflectorResolve_body, _.will.Resolver.reflectorResolve );

let reflectorResolve = _.routineFromPreAndBody( resolve_pre, reflectorResolve_body );

_.assert( reflectorResolve.defaults.defaultResourceKind === 'reflector' );

// --
// other resolver
// --

function _buildsResolve_pre( routine, args )
{
  let module = this;

  _.assert( arguments.length === 2 );
  _.assert( args.length <= 2 );

  let o;
  if( args[ 1 ] !== undefined )
  o = { name : args[ 0 ], criterion : args[ 1 ] }
  else
  o = args[ 0 ];

  o = _.routineOptions( routine, o );
  _.assert( _.longHas( [ 'build', 'export' ], o.kind ) );
  _.assert( _.longHas( [ 'default', 'more' ], o.preffering ) );
  _.assert( o.criterion === null || _.routineIs( o.criterion ) || _.mapIs( o.criterion ) );

  if( o.preffering === 'default' )
  o.preffering = 'default';

  return o;
}

//

function _buildsResolve_body( o )
{
  let module = this;
  let elements = module.buildMap;

  _.assertRoutineOptions( _buildsResolve_body, arguments );
  _.assert( arguments.length === 1 );

  if( o.name )
  {
    elements = _.mapVals( _.path.globShortFilterKeys( elements, o.name ) );
    if( !elements.length )
    return []
    if( o.criterion === null || Object.keys( o.criterion ).length === 0 )
    return elements;
  }
  else
  {
    elements = _.mapVals( elements );
  }

  let hasMapFilter = _.objectIs( o.criterion ) && Object.keys( o.criterion ).length > 0;
  if( _.routineIs( o.criterion ) || hasMapFilter )
  {

    _.assert( _.objectIs( o.criterion ), 'not tested' );

    elements = filterWith( elements, o.criterion );

  }
  else if( _.objectIs( o.criterion ) && Object.keys( o.criterion ).length === 0 && !o.name && o.preffering === 'default' )
  {

    elements = filterWith( elements, { default : 1 } );

  }

  if( o.kind === 'export' )
  elements = elements.filter( ( element ) => element.criterion && element.criterion.export );
  else if( o.kind === 'build' )
  elements = elements.filter( ( element ) => !element.criterion || !element.criterion.export );

  return elements;

  /* */

  function filterWith( elements, filter )
  {

    _.assert( _.objectIs( filter ), 'not tested' );

    if( _.objectIs( filter ) && Object.keys( filter ).length > 0 )
    {

      let template = filter;
      filter = function filter( build, k, c )
      {

        _.assert( _.mapIs( build.criterion ) );

        let satisfied = _.objectSatisfy
        ({
          template,
          src : build.criterion,
          levels : 1,
          strict : o.strictCriterion,
        });

        if( satisfied )
        return build;
      }

    }

    elements = _.entityFilter( elements, filter );

    return elements;
  }

}

_buildsResolve_body.defaults =
{
  kind : null,
  name : null,
  criterion : null,
  preffering : 'default',
  strictCriterion : 1,
}

let _buildsResolve = _.routineFromPreAndBody( _buildsResolve_pre, _buildsResolve_body );

//

let buildsResolve = _.routineFromPreAndBody( _buildsResolve_pre, _buildsResolve_body );
var defaults = buildsResolve.defaults;
defaults.kind = 'build';

//

let exportsResolve = _.routineFromPreAndBody( _buildsResolve_pre, _buildsResolve_body );
var defaults = exportsResolve.defaults;
defaults.kind = 'export';

//

function willfilesResolve()
{
  let module = this;
  let will = module.will;
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let result = module.willfilesArray.slice();
  for( let m in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ m ];
    if( !submodule.opener )
    continue;
    if( !submodule.opener.openedModule )
    continue;
    _.arrayAppendArrayOnce( result, submodule.opener.openedModule.willfilesResolve() );
  }

  return result;
}

// --
// path
// --

function pathsRelative( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( arguments.length === 2 )
  o = { basePath : arguments[ 0 ], filePath : arguments[ 1 ] }

  if( _.mapIs( o.filePath ) )
  {
    for( let f in o.filePath )
    o.filePath[ f ] = module.pathsRelative
    ({
      basePath : o.basePath,
      filePath : o.filePath[ f ],
      onlyLocal : o.onlyLocal,
    });
    return o.filePath;
  }

  o = _.routineOptions( pathsRelative, o );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( path.isAbsolute( o.basePath ) );

  if( !o.filePath )
  return o.filePath;

  if( !path.s.anyAreAbsolute( o.filePath ) )
  return o.filePath;

  o.filePath = path.filter( o.filePath, ( filePath ) =>
  {
    if( !filePath )
    return filePath;

    if( o.onlyLocal )
    if( path.isGlobal( filePath ) )
    return filePath

    if( path.isAbsolute( filePath ) )
    return path.s.relative( o.basePath, filePath );

    return filePath;
  });

  return o.filePath;
}

pathsRelative.defaults =
{
  basePath : null,
  filePath : null,
  onlyLocal : 0,
}

//

function pathsRebase( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let Resolver = _.will.Resolver;

  o = _.routineOptions( pathsRebase, arguments );
  _.assert( path.isAbsolute( o.inPath ) );

  let inPathResource = module.resourceObtain( 'path', 'in' );
  if( inPathResource.path === null )
  inPathResource.path = '.';

  o.inPath = path.canonize( o.inPath )
  if( !o.exInPath )
  o.exInPath = module.inPath;
  o.exInPath = path.canonize( o.exInPath )
  let relative = path.relative( o.inPath, o.exInPath );

  if( o.inPath === o.exInPath )
  {
    module.inPath = o.inPath
    return;
  }

  /* path */

  for( let p in module.pathResourceMap )
  {
    let resource = module.pathResourceMap[ p ];

    if( p === 'in' )
    continue;
    if( p === 'module.dir' )
    continue;
    if( p === 'download' )
    continue;

    resource.pathsRebase
    ({
      relative : relative,
      exInPath : o.exInPath,
      inPath : o.inPath,
    });

  }

  module.inPath = o.inPath;

  _.assert( module.pathResourceMap[ inPathResource.name ] === inPathResource );
  _.assert( module.inPath === o.inPath );
  _.assert( path.isRelative( module.pathResourceMap.in.path ) );

  /* submodule */

  for( let p in module.submoduleMap )
  {
    let resource = module.submoduleMap[ p ];

    resource.pathsRebase
    ({
      relative : relative,
      exInPath : o.exInPath,
      inPath : o.inPath,
    });

  }

  /* reflector */

  for( let r in module.reflectorMap )
  {
    let resource = module.reflectorMap[ r ];

    resource.pathsRebase
    ({
      relative : relative,
      exInPath : o.exInPath,
      inPath : o.inPath,
    });

  }

}

pathsRebase.defaults =
{
  inPath : null,
  exInPath : null,
}

//

function _pathChanged( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( o.val !== undefined );
  _.routineOptions( _pathChanged, arguments );

  if( o.isIdentical === null )
  o.isIdentical = o.ex === o.val || _.entityIdentical( o.ex, o.val );

  if( will && module.userArray )
  if( o.touching )
  if( !o.isIdentical )
  if( module.SharedPaths[ o.name ] !== undefined )
  {
    module.userArray.forEach( ( opener ) =>
    {
      if( !( opener instanceof _.will.ModuleOpener ) )
      return;
      let o2 = _.mapExtend( null, o );
      o2.touching = 0;
      if( o2.val )
      if( o2.name !== 'inPath' )
      o2.val = path.s.join( module.inPath, o2.val );
      else
      o2.val = path.s.join( module.dirPath, o2.val );
      opener._pathChanged( o2 );
      _.assert( _.identical( opener[ o2.name ], o2.val ) );
    });
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

function _pathResourceChanged( o )
{
  let module = this;
  let will = module.will;

  _.assert( o.val !== undefined );
  _.assert( _.strDefined( o.name ) );
  _.routineOptions( _pathResourceChanged, arguments );

  if( o.isIdentical === null )
  o.isIdentical = o.ex === o.val || _.entityIdentical( o.ex, o.val );

  if( module.ResourceToPathName.hasKey( o.name ) )
  {
    let o2 = _.mapExtend( null, o );
    o2.name = module.ResourceToPathName.forKey( o.name );
    module._pathChanged( o2 );
  }

  let o2 = _.mapExtend( null, o );
  o2.kind = 'resource.set';
  o2.object = module;
  o2.fieldName = o.name;
  delete o2.name;
  will._pathChanged( o2 );

  // will._pathChanged
  // ({
  //   object : module,
  //   fieldName : resource.name,
  //   val : src,
  //   ex,
  //   kind : 'resource.set',
  // });

}

_pathResourceChanged.defaults =
{
  name : null,
  ex : null,
  val : null,
  isIdentical : null,
}

//

/* xxx : use _pathChanged instead */
function _filePathChanged1( o )
{
  let module = this;

  _.assert( o.willfilesPath !== undefined );

  o = module._filePathChanged2( o );

  if( module.will )
  if( !o.isIdentical )
  module.userArray.forEach( ( opener ) =>
  {
    if( opener instanceof _.will.ModuleOpener )
    opener._filePathChanged2({ willfilesPath : o.willfilesPath });
  });

  return o;
}

_filePathChanged1.defaults = _.mapExtend( null, _.will.AbstractModule.prototype._filePathChanged1.defaults );

//

function _filePathChanged2( o )
{
  let module = this;

  if( !this.will )
  return willfilesPath;

  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  o = Parent.prototype._filePathChanged2.call( module, o );

  _.assert( _.boolIs( o.isIdentical ) );
  _.assert( _.strIs( o.localPath ) );
  _.assert( o.localPath === o.commonPath );

  module._dirPathPut( o.dirPath );

  if( o.willfilesPath !== null )
  {
    module._commonPathPut( o.commonPath );
    // if( module.isRemote === false ) /* xxx */
    // if( module.repo && module.repo.isRemote === false ) /* xxx */
    // _.assert( _.strIs( o.localPath ) && !path.isGlobal( o.localPath ) );

    if( o.localPath )
    // if( !path.isRemote( o.localPath ) )
    {
      _.assert( _.strIs( o.localPath ) && !path.isGlobal( o.localPath ) );
      module._localPathPut( o.localPath );
      _.assert( module.localPath === o.localPath );
      _.assert( module.localPath === module.commonPath );
    }
  }

  module._peerChanged();

  module._willfilesPathPut( o.willfilesPath );

  for( let s in module.submoduleMap )
  {
    let relation = module.submoduleMap[ s ];
    // if( relation.formed && relation.enabled ) /* ttt */
    if( relation.formed )
    will.junctionReform( relation );
  }

  _.assert( module.localPath === module.commonPath || module.localPath === null );
  _.assert
  (
    !module.stager || !module.stager.stageStatePerformed( 'preformed' ) || _.strDefined( module.commonPath ),
    `Each module requires commpnPath, but ${module.absoluteName} does not have`
  );

  return o;
}

_filePathChanged2.defaults = _.mapExtend( null, _.will.AbstractModule.prototype._filePathChanged2.defaults );

//

function _pathRegister()
{
  let module = this;
  let will = module.will;

  will.modulePathRegister( module );

  let junction = will.junctionReform( module );

  let o2 =
  {
    withPeers : 0,
    outputFormat : '/',
  }
  let junctions = module.modulesEachAll( o2 );

  _.assert( !!o2.withDisabledModules );
  _.assert( !!o2.withDisabledSubmodules );

  junctions.forEach( ( junction ) =>
  {
    _.assert( _.will.isJunction( junction ) );
    will.junctionsReform( junction.relations );
  });

}

//

function _pathUnregister()
{
  let module = this;
  let will = module.will;

  // will.modulePathRegister( module );
  will.modulePathUnregister( module );

}

//

function inPathGet()
{
  let module = this;
  let will = module.will;

  if( !will )
  return null;

  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = path.s.join( module.dirPath, ( module.pathMap.in || '.' ) );

  // if( result && _.strHas( result, '//' ) )
  // debugger;

  return result;
}

//

function outPathGet()
{
  let module = this;
  let will = module.will;

  if( !will )
  return null;

  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return path.s.join( module.dirPath, ( module.pathMap.in || '.' ), ( module.pathMap.out || '.' ) );
}

//

function outfilePathGet()
{
  let module = this;
  let will = module.will;
  _.assert( arguments.length === 0, 'Expects no arguments' );
  return _.Will.OutfilePathFor( module.outPath, module.about.name );
}

//

function cloneDirPathGet( rootModule )
{
  let module = this;
  let will = module.will;

  rootModule = module;
  rootModule = rootModule || module.rootModule;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( rootModule.isOut )
  {
    let inPath = rootModule.peerInPathGet();
    if( inPath )
    return _.Will.CloneDirPathFor( inPath );
    debugger;
    if( will.verbosity )
    logger.error( ` ! Out willfile of ${rootModule.localPath} does not have path::module.peer.in, but should` );
    return null;
  }

  _.assert( !rootModule.isOut );

  let inPath = rootModule.inPath;
  return _.Will.CloneDirPathFor( inPath );
}

//

function peerLocalPathGet()
{
  let module = this;
  let will = module.will;

  let peerWillfilesPath = module.pathMap[ 'module.peer.willfiles' ];
  if( !peerWillfilesPath )
  return null;

  _.assert( !!peerWillfilesPath );
  let localPath = _.Will.CommonPathFor( peerWillfilesPath );
  _.assert( !_.path.isGlobal( localPath ) );

  return localPath;
}

//

function peerRemotePathGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !module.remotePath )
  return null;
  let peerLocalPath = module.peerLocalPathGet();
  if( !peerLocalPath )
  return null;
  return _.Will.RemotePathAdjust( module.remotePath, path.relative( module.localPath, peerLocalPath ) );
}

//

function peerInPathGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  let result = module.pathMap[ 'module.peer.in' ];
  if( result )
  result = path.join( module.inPath, result );

  if( !result )
  {
    let localPath = module.peerLocalPathGet();
    if( localPath )
    {
      result = path.join( module.inPath, path.dirFirst( localPath ) );
    }
  }

  if( !result && module.peerModule )
  {
    result = module.peerModule.inPath;
  }

  if( result )
  _.assert( !_.path.isGlobal( result ) );

  return result || null;
}

//

function predefinedPathGet_functor( fieldName, resourceName, absolutize )
{

  return function predefinedPathGet()
  {
    let module = this;

    if( !module.will)
    return null;

    let result = module.pathMap[ resourceName ];
    if( result === undefined )
    result = null;

    if( result )
    if( _.will.Resolver.selectorIs( result ) )
    {
      result = module.pathResolve( result );
    }

    if( absolutize && result )
    {
      let will = module.will;
      let fileProvider = will.fileProvider;
      let path = fileProvider.path;
      result = path.join( module.inPath, result );
    }

    return result;
  }

}

//

function predefinedPathPut_functor( fieldName, resourceName, relativizing )
{

  return function predefinedPathPut( filePath )
  {
    let module = this;
    let will = module.will;

    if( !will && !filePath )
    return filePath;

    filePath = _.entityMake( filePath );

    let ex = module[ fieldName ];
    let isIdentical = false;
    isIdentical = ex === filePath || _.entityIdentical( _.path.simplify( ex ), _.path.simplify( filePath ) );
    /* xxx : optimize? */

    if( !module.pathResourceMap[ resourceName ] )
    {
      let resource = new _.will.PathResource({ module : module, name : resourceName }).form1();
      resource.criterion = resource.criterion || Object.create( null );
      resource.criterion.predefined = 1;
      resource.writable = 0;
    }

    _.assert( !!module.pathResourceMap[ resourceName ] );

    if( relativizing )
    {
      let basePath = module[ relativizing ];
      _.assert( basePath === null || _.strIs( basePath ) );
      if( filePath && basePath )
      filePath = module.pathsRelative( basePath, filePath );
    }

    if( fieldName === 'localPath' || fieldName === 'remotePath' ) /* xxx : move out to set */
    {
      module._pathUnregister();
    }

    module.pathResourceMap[ resourceName ].path = filePath;

    if( fieldName === 'localPath' || fieldName === 'remotePath' )
    if( module.isPreformed() )
    if( module.commonPath )
    {
      module._pathRegister();
    }

    if( will )
    will._pathChanged
    ({
      object : module,
      fieldName : fieldName,
      val : filePath,
      ex,
      isIdentical,
      kind : 'put',
    });

    return filePath;
  }

}

//

function decoratedPathGet_functor( fieldName )
{

  return function decoratedPathGet()
  {
    let module = this;
    let result = module[ fieldName ];
    if( result !== null )
    {
      let will = module.will;
      let fileProvider = will.fileProvider;
      let path = fileProvider.path;
      _.assert( _.strIs( result ) || _.arrayIs( result ) )
      result = path.filter( result, ( p ) => _.color.strFormat( p, 'path' ) );
    }
    return result;
  }

}

//

function predefinedPathSet_functor( fieldName, resourceName )
{

  let putName = '_' + fieldName + 'Put';
  _.assert( arguments.length === 2 );
  _.assert( resourceName !== 'remote' );
  _.assert( resourceName !== 'module.willfiles' );

  return function predefinedPathSet( filePath )
  {
    let module = this;
    let will = module.will;
    let ex = module[ fieldName ];

    _.assert( !!module[ putName ] );
    module[ putName ]( filePath );

    if( will )
    will._pathChanged
    ({
      object : module,
      fieldName : fieldName,
      val : filePath,
      ex,
      kind : 'set',
    });

    return filePath;
  }

}

//

function willfilesPathSet( filePath )
{
  let module = this;

  module._filePathChanged1
  ({
    willfilesPath : filePath,
  });

  return filePath;
}

//

function remotePathSet( filePath )
{
  let module = this;
  let will = module.will;
  let ex = module.remotePath;
  let isIdentical = ex === filePath || _.entityIdentical( _.path.simplify( ex ), _.path.simplify( filePath ) );

  module._remotePathPut( filePath );

  if( !isIdentical )
  module._remoteChanged();

  if( will )
  will._pathChanged
  ({
    object : module,
    fieldName : 'remotePath',
    val : filePath,
    ex,
    isIdentical,
    kind : 'set',
  });

  return filePath;
}

//

function remotePathEachAdoptAct( o )
{
  let module = this;
  let will = module.will;

  _.assertRoutineOptions( remotePathEachAdoptAct, o );

  moduleAdoptPath( module );

  return true;

  function moduleAdoptPath( module )
  {
    module.remotePathAdopt( o );
    module.userArray.forEach( ( opener2 ) =>
    {
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

let willfilesPathGet = predefinedPathGet_functor( 'willfilesPath', 'module.willfiles' );
let dirPathGet = predefinedPathGet_functor( 'dirPath', 'module.dir' );
let commonPathGet = predefinedPathGet_functor( 'commonPath', 'module.common' );
let localPathGet = predefinedPathGet_functor( 'localPath', 'local', 1 );
let downloadPathGet = predefinedPathGet_functor( 'downloadPath', 'download', 1 );
let remotePathGet = predefinedPathGet_functor( 'remotePath', 'remote' );
let currentRemotePathGet = predefinedPathGet_functor( 'currentRemotePath', 'current.remote' );
let willPathGet = predefinedPathGet_functor( 'willPath', 'will' );
let originalWillfilesPathGet = predefinedPathGet_functor( 'originalWillfilesPath', 'module.original.willfiles' );
let peerWillfilesPathGet = predefinedPathGet_functor( 'peerWillfilesPath', 'module.peer.willfiles' );

let decoratedWillfilesPathGet = decoratedPathGet_functor( 'willfilesPath' );
let decoratedInPathGet = decoratedPathGet_functor( 'inPath' );
let decoratedOutPathGet = decoratedPathGet_functor( 'outPath' );
let decoratedDirPathGet = decoratedPathGet_functor( 'dirPath' );
let decoratedCommonPathGet = decoratedPathGet_functor( 'commonPath' );
let decoratedDownloadPathGet = decoratedPathGet_functor( 'downloadPath' );
let decoratedLocalPathGet = decoratedPathGet_functor( 'localPath' );
let decoratedRemotePathGet = decoratedPathGet_functor( 'remotePath' );
let decoratedCurrentRemotePathGet = decoratedPathGet_functor( 'currentRemotePath' );
let decoratedWillPathGet = decoratedPathGet_functor( 'willPath' );
let decoratedOriginalWillfilesPathGet = decoratedPathGet_functor( 'originalWillfilesPath' );
let decoratedPeerWillfilesPathGet = decoratedPathGet_functor( 'peerWillfilesPath' );
let decoratedPeerInPathGet = decoratedPathGet_functor( 'peerInPath' );

let _inPathPut = predefinedPathPut_functor( 'inPath', 'in', 'dirPath' );
let _outPathPut = predefinedPathPut_functor( 'outPath', 'out', 'inPath' );
let _willfilesPathPut = predefinedPathPut_functor( 'willfilesPath', 'module.willfiles', 0 );
let _dirPathPut = predefinedPathPut_functor( 'dirPath', 'module.dir', 0 );
let _commonPathPut = predefinedPathPut_functor( 'commonPath', 'module.common', 0 );
let _localPathPut = predefinedPathPut_functor( 'localPath', 'local', 0 );
let _downloadPathPut = predefinedPathPut_functor( 'downloadPath', 'download', 0 );
let _remotePathPut = predefinedPathPut_functor( 'remotePath', 'remote', 0 );
let _currentRemotePathPut = predefinedPathPut_functor( 'currentRemotePath', 'current.remote', 0 );
let _originalWillfilesPathPut = predefinedPathPut_functor( 'originalWillfilesPath', 'module.original.willfiles', 0 );
let _peerWillfilesPathPut = predefinedPathPut_functor( 'peerWillfilesPath', 'module.peer.willfiles', 0 );
let _peerInPathPut = predefinedPathPut_functor( 'peerInPath', 'module.peer.in', 0 );

let inPathSet = predefinedPathSet_functor( 'inPath', 'in' );
let outPathSet = predefinedPathSet_functor( 'outPath', 'out' );
let localPathSet = predefinedPathSet_functor( 'localPath', 'local' );
let downloadPathSet = predefinedPathSet_functor( 'downloadPath', 'download' );

// --
// name
// --

function originGet()
{
  let module = this;
  let will = module.will;
  return 'wmodule:///' + module.originShortGet();
}

//

function originShortGet()
{
  let module = this;
  let will = module.will;
  return ( module.about.org || 'sole' ) + '/' + ( module.about.name || '' );
}

//

function originDirNameGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let origin = module.originGet();
  let parsed = _.uri.parseConsecutive( origin );
  let result = parsed.longPath;

  if( path.isAbsolute( result ) )
  result = path.relative( '/', result );

  result = _.strReplace( result, '/', '_' )
  result = _.strFilenameFor( result );

  return result;
}

//

function nameGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let name = null;

  if( !name && module.about )
  name = module.about.name;

  if( !name && module.fileName )
  name = module.fileName;

  // let aliasNames = module.aliasNames;
  // if( aliasNames && aliasNames.length )
  // name = aliasNames[ 0 ];

  if( !name && module.commonPath )
  name = path.fullName( module.commonPath );

  return name;
}

//

function _nameChanged()
{
  let module = this;
  let will = module.will;

  if( !will )
  return;

  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let name = null;

  /* */

  module._nameUnregister();
  module._nameRegister();
  module._peerChanged();

}

//

function _nameUnregister( rootModule )
{
  let module = this;
  let will = module.will;

  rootModule = rootModule || module.rootModule;

  /* remove from root */

  if( rootModule )
  for( let m in rootModule.moduleWithNameMap )
  {
    if( rootModule.moduleWithNameMap[ m ] === module )
    delete rootModule.moduleWithNameMap[ m ];
  }

  /* remove from system */

  for( let m in will.moduleWithNameMap )
  {
    if( will.moduleWithNameMap[ m ] === module )
    delete will.moduleWithNameMap[ m ];
  }

}

//

function _nameRegister( rootModule )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let name = null;
  let c = 0;

  rootModule = rootModule || module.rootModule;

  let aliasNames = module.aliasNames;
  if( aliasNames )
  for( let n = 0 ; n < aliasNames.length ; n++ )
  {
    let name = aliasNames[ n ];

    if( rootModule )
    if( !rootModule.moduleWithNameMap[ name ] )
    {
      c += 1;
      rootModule.moduleWithNameMap[ name ] = module;
    }

    if( !will.moduleWithNameMap[ name ] )
    {
      c += 1;
      will.moduleWithNameMap[ name ] = module;
    }

  }

  // if( module.aliasName )
  // if( !rootModule.moduleWithNameMap[ module.aliasName ] )
  // {
  //   c += 1;
  //   rootModule.moduleWithNameMap[ module.aliasName ] = module;
  // }
  //
  // if( module.fileName )
  // if( !rootModule.moduleWithNameMap[ module.fileName ] )
  // {
  //   c += 1;
  //   rootModule.moduleWithNameMap[ module.fileName ] = module;
  // }

  if( module.about && module.about.name )
  {

    if( rootModule )
    if( !rootModule.moduleWithNameMap[ module.about.name ] )
    {
      c += 1;
      rootModule.moduleWithNameMap[ module.about.name ] = module;
    }

    if( !will.moduleWithNameMap[ module.about.name ] )
    {
      c += 1;
      will.moduleWithNameMap[ module.about.name ] = module;
    }

  }

  return c;
}

//

function aliasNamesGet()
{
  let module = this;
  let will = module.will;
  let result = [];

  if( module.fileName )
  _.arrayAppendElementOnce( result, module.fileName )

  for( let u = 0 ; u < module.userArray.length ; u++ )
  {
    let opener = module.userArray[ u ];
    if( opener instanceof _.will.ModuleOpener )
    if( opener.aliasName )
    _.arrayAppendElementOnce( result, opener.aliasName )
  }

  return result;
}

//

function absoluteNameGet()
{
  let module = this;
  let rootModule = module.rootModule;
  if( rootModule && rootModule !== module )
  {
    if( rootModule === module.original )
    return rootModule.qualifiedName + ' / ' + 'f::duplicate';
    else
    return rootModule.qualifiedName + ' / ' + module.qualifiedName;
  }
  else
  {
    return module.qualifiedName;
  }
}

//

function shortNameArrayGet()
{
  let module = this;
  let rootModule = module.rootModule;
  if( rootModule === module )
  return [ module.name ];
  let result = rootModule.shortNameArrayGet();
  result.push( module.name );
  return result;
}

// --
// coercer
// --

function toModule()
{
  let module = this;
  let will = module.will;

  module.assertIsValidIntegrity(); /* zzz : temp */

  return module;
}

//

function toOpener()
{
  let module = this;
  let will = module.will;

  module.assertIsValidIntegrity(); /* zzz : temp */

  for( let u = 0 ; u < module.userArray.length ; u++ )
  {
    let opener = module.userArray[ u ];
    if( opener instanceof _.will.ModuleOpener )
    return opener;
  }

  return null;
}

//

function toRelation()
{
  let module = this;
  let will = module.will;

  module.assertIsValidIntegrity(); /* zzz : temp */

  return module.superRelations[ 0 ] || null;
}

//

function toJunction()
{
  let module = this;
  let will = module.will;
  return will.junctionFrom( module );
}

// --
// exporter
// --

function optionsForOpenerExport()
{
  let module = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  let fields =
  {

    will : null,
    willfilesArray : null,
    peerModule : null,

    willfilesPath : null,
    localPath : null,
    downloadPath : null,
    remotePath : null,

    repo : null,

    // isRemote : null,
    // isUpToDate : null,

  }

  let result = _.mapOnly( module, fields );

  // debugger; xxx
  // result.hasFiles = true;
  // result.isRepository = true;
  // result.repo = module.repo;

  result.willfilesArray = _.entityMake( result.willfilesArray );

  return result;
}

//

function exportString( o )
{
  let module = this;
  let will = module.will;
  let result = '';

  o = _.routineOptions( exportString, arguments );

  if( o.verbosity >= 1 )
  result += module.decoratedAbsoluteName + '#' + module.id;

  if( o.verbosity >= 3 )
  result += module.about.exportString();

  if( o.verbosity >= 2 )
  {
    let fields = Object.create( null );
    fields.remote = module.remotePath;
    fields.local = module.localPath;
    fields.download = module.downloadPath;
    result += '\n' + _.toStrNice( fields );
  }

  if( o.verbosity >= 4 )
  {
    result += '\n';
    result += module.infoExportPaths( module.pathMap );
    result += module.resourcesExportInfo( module.submoduleMap );
    result += module.resourcesExportInfo( module.reflectorMap );
    result += module.resourcesExportInfo( module.stepMap );
    result += module.resourcesExportInfo( module.buildsResolve({ preffering : 'more' }) );
    result += module.resourcesExportInfo( module.exportsResolve({ preffering : 'more' }) );
    result += module.resourcesExportInfo( module.exportedMap );
  }

  return result;
}

exportString.defaults =
{
  verbosity : 2,
}

//

function infoExportPaths( paths )
{
  let module = this;
  paths = paths || module.pathMap;
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !Object.keys( paths ).length )
  return '';

  let result = _.color.strFormat( 'Paths', 'highlighted' );

  // paths = module.pathsRelative({ basePath : module.dirPath, filePath : paths, onlyLocal : 1 });

  debugger;
  result += '\n' + _.toStrNice( paths ) + '';
  debugger;

  result += '\n\n';

  return result;
}

//

function resourcesExportInfo( collection )
{
  let module = this;
  let will = module.will;
  let result = '';
  let modules = [];

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( collection ) || _.arrayIs( collection ) );

  _.each( collection, ( resource, r ) =>
  {
    if( resource && resource instanceof _.will.Module )
    {
      if( _.longHas( modules, resource ) )
      return;
      modules.push( resource );
      result += resource.exportString({ verbosity : 2 });
      result += '\n\n';
    }
    else if( _.instanceIs( resource ) )
    {
      result += resource.exportString();
      result += '\n\n';
    }
    else
    {
      result = _.toStrNice( resource );
    }
  });

  return result;
}

//

function infoExportModulesTopological()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  let sorted = will.graphTopologicalSort();
  debugger;

  let result = sorted.map( ( modules ) =>
  {
    let names = modules.map( ( module ) => module.name );
    return names.join( ' ' )
  });

  result = result.join( '\n' );

  return result;
}

//

function exportStructure( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  o.dst = o.dst || Object.create( null );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = _.routineOptions( exportStructure, arguments );

  o.module = module;

  if( !o.exportModule )
  o.exportModule = module;

  let o2 = _.mapExtend( null, o );
  delete o2.dst;

  o.dst.about = module.about.exportStructure();
  o.dst.path = module.structureExportResources( module.pathResourceMap, o2 );
  o.dst.submodule = module.structureExportResources( module.submoduleMap, o2 );
  o.dst.reflector = module.structureExportResources( module.reflectorMap, o2 );
  o.dst.step = module.structureExportResources( module.stepMap, o2 );
  o.dst.build = module.structureExportResources( module.buildMap, o2 );
  if( o.module.isOut )
  o.dst.exported = module.structureExportResources( module.exportedMap, o2 );
  if( o.exportModule.isOut )
  o.dst.consistency = module.structureExportConsistency( o2 );

  if( !o.exportModule.isOut )
  {
    for( let f in o.dst )
    {
      if( _.mapIsEmpty( o.dst[ f ] ) )
      delete o.dst[ f ]
    }
  }

  if( o.exportModule.isOut )
  {
    _.assert( !!o.dst.path );
    _.assert( !!o.dst.path[ 'module.original.willfiles' ] );
    _.assert( !!o.dst.path[ 'module.original.willfiles' ].path );
    _.assert( !!o.dst.path[ 'module.peer.willfiles' ] );
    _.assert( !!o.dst.path[ 'module.peer.willfiles' ].path );
    _.assert( !!o.dst.path[ 'module.peer.in' ] );
    _.assert( !!o.dst.path[ 'module.peer.in' ].path );
    _.assert( !!o.dst.path[ 'module.willfiles' ] );
    _.assert( !!o.dst.path[ 'module.willfiles' ].path );
    _.assert( o.dst.path[ 'module.peer.willfiles' ].path !== o.dst.path[ 'module.willfiles' ].path );
    _.assert( !module.isOut ^ _.entityIdentical( o.dst.path[ 'module.original.willfiles' ].path, o.dst.path[ 'module.peer.willfiles' ].path ) );
    _.assert( !_.entityIdentical( o.dst.path[ 'module.willfiles' ].path, o.dst.path[ 'module.peer.willfiles' ].path ) );
  }

  return o.dst;
}

exportStructure.defaults =
{
  dst : null,
  compact : 1,
  formed : 0,
  copyingAggregates : 0,
  copyingNonExportable : 0,
  copyingNonWritable : 1,
  copyingPredefined : 1,
  strict : 1,
  module : null,
  exportModule : null,
  willf : null,
}

//

function structureExportOut( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = _.routineOptions( structureExportOut, arguments );

  o.module = module;
  if( !o.exportModule )
  o.exportModule = module;

  _.assert( o.exportModule === module )
  _.assert( o.exportModule.isOut );
  _.assert( !!module.peerModule );

  o.dst = o.dst || Object.create( null );
  // o.dst.format = will.willfile.FormatVersion; /* Dmytro : previous */
  o.dst.format = _.will.Willfile.FormatVersion;

  // // if( _.strHas( module.name, 'ModuleForTesting1b' ) )
  // // debugger;
  // if( _.strHas( module.commonPath, 'group1/.module/ModuleForTesting1b' ) )
  // {
  //   // _global_.debugger = 1;
  //   debugger;
  // }

  let found = module.modulesEach
  ({
    withPeers : 1,
    withStem : 1,
    withDisabledModules : 0,
    withDisabledSubmodules : 0,
    withDisabledStem : 1,
    recursive : 2,
    outputFormat : '*/handle',
    descriptive : 1,
  });

  found.result = _.longOnce( _.filter( found.result, ( handle ) =>
  {
    let junction = handle.toJunction();
    let module = handle.toModule();
    if( !module )
    {
      debugger;
      if( junction.relation && junction.relation.criterion.optional )
      return;
      throw _.err
      (
          `${junction.object.absoluteName} is not available. `
        + `\nRemote path is ${junction.remotePath}`
        + `\nLocal path is ${junction.localPath}`
      );
    }
    return module;
  }));

  let modules = [];
  found.result.forEach( ( module2 ) =>
  {
    if( !( module2 instanceof _.will.Module ) )
    {
      debugger;
      let junction = will.junctionFrom( module2 );
      throw _.err
      (
          `${junction.object.absoluteName} is not available. `
        + `\nRemote path is ${junction.remotePath}`
        + `\nLocal path is ${junction.localPath}`
      );
    }
    let c = 0;
    if( _.longHas( found.ownedObjects, module2 ) )
    {
      modules.push( module2 );
      c += 1;
    }
    _.assert( c === 1 ); /* xxx */
  });

  _.assert( modules.length >= 2, 'No module to export' );
  module.structureExportModules( modules, o );

  let rootModuleStructure = o.dst.module[ module.fileName ];
  _.assert( !!rootModuleStructure );
  _.assert( !rootModuleStructure.path || !!rootModuleStructure.path[ 'module.original.willfiles' ] );
  _.assert( !rootModuleStructure.path || !!rootModuleStructure.path[ 'module.peer.willfiles' ] );
  _.assert( !rootModuleStructure.path || !!rootModuleStructure.path[ 'module.peer.in' ] );
  _.assert( !rootModuleStructure.path || !!rootModuleStructure.path[ 'module.willfiles' ] );
  _.assert( !rootModuleStructure.path || !rootModuleStructure.path[ 'module.dir' ] );
  _.assert( !rootModuleStructure.path || !rootModuleStructure.path[ 'current.remote' ] );
  _.assert( !rootModuleStructure.path || !rootModuleStructure.path[ 'will' ] );
  _.assert( !rootModuleStructure.path || rootModuleStructure.path[ 'remote' ] === undefined );
  _.assert( !rootModuleStructure.path.remote || !rootModuleStructure.path.remote.path );

  return o.dst;
}

structureExportOut.defaults = Object.create( exportStructure.defaults );

//

function structureExportForModuleExport( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routineOptions( structureExportForModuleExport, arguments );
  _.assert( module.original === null );

  let module2 = module.outModuleMake({ willfilesPath : o.willfilesPath });
  let structure = module2.structureExportOut();

  debugger;
  if( !module2.isUsedManually() )
  debugger;
  if( !module2.isUsedManually() )
  module2.finit();

  return structure;

}

structureExportForModuleExport.defaults =
{
  willfilesPath : null,
}

//

function structureExportResources( resources, options )
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  _.assert( arguments.length === 2 );
  _.assert( _.mapIs( resources ) || _.arrayIs( resources ) );

  _.each( resources, ( resource, r ) =>
  {
    result[ r ] = resource.exportStructure( options );
    if( result[ r ] === undefined )
    delete result[ r ];
  });

  return result;
}

//

function structureExportModules( modules, op )
{
  let module = this;
  let exportModule = op.exportModule;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  op.dst = op.dst || Object.create( null );
  op.dst.root = [];
  op.dst.consistency = op.dst.consistency || Object.create( null );
  op.dst.module = op.dst.module || Object.create( null );

  _.assert( arguments.length === 2 );
  _.assert( exportModule instanceof _.will.Module );
  _.assert( exportModule.isOut );

  _.each( modules, ( module2 ) =>
  {
    _.assert( !!module2 );
    let absolute = module2.commonPath;
    let relative = absolute;
    if( !path.isGlobal( relative ) )
    relative = path.relative( exportModule.dirPath, relative );

    _.sure
    (
      module2.isOut || module.commonPath === module2.commonPath || ( module2.peerModule && module2.peerModule.isOut && module2.peerModule.isValid() ),
      () => `Submodules should be loaded from out-willfiles, but ${module2.decoratedAbsoluteName} is loaded from\n${module2.willfilesPath}`
    );

    if( op.dst.module[ relative ] )
    {
      debugger;
    }
    else
    {
      let o2 = _.mapExtend( null, op );
      delete o2.dst;
      let moduleStructure = op.dst.module[ relative ] = module2.exportStructure( o2 );
      consitencyAdd( moduleStructure.consistency );
    }

    if( absolute === module.commonPath )
    _.arrayAppendOnce( op.dst.root, relative );

    if( op.dst.module[ relative ] === undefined )
    delete op.dst.module[ relative ];

  });

  _.assert
  (
    op.dst.root.length === 1,
    () => `Failed to find exactly one root, found ${op.dst.root.length}`
        , `\n Common path : ${module.commonPath}`
  );

  return op.dst;

  /* */

  function consitencyAdd( consistency )
  {
    _.assert( _.mapIs( consistency ) );
    for( let rel in consistency )
    {
      let src = consistency[ rel ];
      let dst = op.dst.consistency[ rel ];
      if( dst )
      {
        if( dst.hash !== src.hash || dst.size !== src.size )
        throw _.err( `Attempt to put two insconsistent willfiles with the same path "${rel}" in out-file` );
      }
      else
      {
        op.dst.consistency[ rel ] = src;
      }
    }
  }

}

//

function structureExportConsistency( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  _.routineOptions( structureExportConsistency, arguments );
  _.assert( arguments.length === 1 );
  _.assert( o.exportModule.isOut );

  let willfiles = module.willfilesEach({ recursive : 0, withPeers : 1 });

  willfiles.forEach( ( willf ) =>
  {

    _.arrayAs( willf.filePath ).forEach( ( filePath ) =>
    {
      let r = willf.hashDescriptorGet( filePath );
      let relativePath = path.relative( o.exportModule.inPath, filePath );
      _.assert( result[ relativePath ] === undefined );
      result[ relativePath ] = r;
    });

  });

  return result;
}

structureExportConsistency.defaults = Object.create( exportStructure.defaults );

//

function resourceImport( o )
{
  let module = this;
  let will = module.will;

  _.assert( _.mapIs( o ) );
  _.assert( arguments.length === 1 );
  _.assert( o.srcResource instanceof _.will.Resource );
  _.routineOptions( resourceImport, arguments );

  let srcModule = o.srcResource.module;

  _.assert( module instanceof _.will.Module );
  _.assert( srcModule === null || srcModule instanceof _.will.Module );

  if( o.srcResource.pathsRebase )
  {
    if( o.srcResource.original )
    debugger;
    if( o.srcResource.original )
    o.srcResource = o.srcResource.original;

    _.assert( o.srcResource.original === null );

    o.srcResource = o.srcResource.cloneDerivative();

    // _.assert( o.srcResource.openedModule === srcModule )

    o.srcResource.pathsRebase
    ({
      exInPath : srcModule.inPath,
      inPath : module.inPath,
    });

  }

  let resourceData = o.srcResource.exportStructure();

  if( _.mapIs( resourceData ) )
  for( let k in resourceData )
  {
    let value = resourceData[ k ];

    if( _.strIs( value ) && srcModule )
    value = srcModule.resolveMaybe
    ({
      selector : value,
      prefixlessAction : 'resolved',
      pathUnwrapping : 0,
      pathResolving : 0,
      currentContext : o.srcResource,
    });

    if( _.instanceIsStandard( value ) )
    {
      let o2 = _.mapExtend( null, o );
      o2.srcResource = value;
      let subresource = module.resourceImport( o2 );
      value = subresource.qualifiedName;
    }

    resourceData[ k ] = value;
  }

  if( o.overriding )
  {
    let oldResource = module.resourceGet( o.srcResource.KindName, o.srcResource.name );
    if( oldResource )
    {
      let extra = oldResource.extraExport();
      _.mapExtend( resourceData, extra );
      oldResource.finit();
    }
  }

  _.assert( _.mapIs( resourceData ) );

  resourceData.module = module;
  resourceData.name = module.resourceNameAllocate( o.srcResource.KindName, o.srcResource.name );

  let resource = new o.srcResource.Self( resourceData );
  resource.form1();
  _.assert( module.resolve({ selector : resource.qualifiedName, pathUnwrapping : 0, pathResolving : 0 }).absoluteName === resource.absoluteName );

  return resource;
}

resourceImport.defaults =
{
  srcResource : null,
  overriding : 1,
}

//

function _npmGenerateFromWillfile( o )
{
  let will = this;
  let path = will.fileProvider.path;

  /* */

  let config = Object.create( null );
  if( o.srcConfig.about )
  {
    config.name = o.srcConfig.about.name;
    config.version = o.srcConfig.about.version;
    config.enabled = o.srcConfig.about.enabled;

    if( o.srcConfig.about.description )
    config.description = o.srcConfig.about.description;
    if( o.srcConfig.about.keywords )
    config.keywords = o.srcConfig.about.keywords;
    if( o.srcConfig.about.license )
    config.license = o.srcConfig.about.license;

    if( o.srcConfig.about.interpreters )
    {
      let interpreters = _.arrayAs( o.srcConfig.about.interpreters );
      interpreters.forEach( ( interpreter ) =>
      {
        if( _.strHas( interpreter, 'njs' ) )
        config.engine = _.strReplace( interpreter, 'njs', 'node' );
      });
    }

    if( o.srcConfig.about.author )
    config.author = o.srcConfig.about.author;
    if( o.srcConfig.about.contributors )
    config.contributors = o.srcConfig.about.contributors;

    for( let n in o.srcConfig.about )
    {
      if( !_.strBegins( n, 'npm.' ) )
      continue;
      config[ _.strRemoveBegin( n, 'npm.' ) ] = o.srcConfig.about[ n ];
    }
  }

  if( o.entryPath && o.entryPath.length )
  {
    config.main = _.scalarFrom( path.s.relative( path.dir( o.packagePath ), o.entryPath ) );
  }

  if( o.filesPath && o.filesPath.length )
  {
    config.files = path.s.relative( path.dir( o.packagePath ), o.filesPath );
  }

  if( o.srcConfig.path )
  {
    if( o.srcConfig.path.repository )
    config.repository = pathSimplify( o.srcConfig.path.repository );
    if( o.srcConfig.path.bugtracker )
    config.bugs = pathSimplify( o.srcConfig.path.bugtracker );
    if( o.srcConfig.path.entry )
    config.entry = o.srcConfig.path.entry;

    for( let n in o.srcConfig.path )
    {
      if( !_.strBegins( n, 'npm.' ) )
      continue;
      config[ _.strRemoveBegin( n, 'npm.' ) ] = o.srcConfig.path[ n ];
    }
  }

  if( o.srcConfig.submodule )
  {
    for( let s in o.srcConfig.submodule )
    {
      let submodule = o.srcConfig.submodule[ s ];
      let p = submodule.path;
      p = path.parseFull( p );

      _.assert
      (
        p.protocol === 'npm' || p.protocol === 'hd',
        () => 'Implemented only for "npm" and "hd" dependencies, but got ' + p.full
      );

      if( p.protocol === 'npm' )
      {
        depAdd( submodule, path.relative( '/', p.longPath ), p.hash );
      }
      else if( p.protocol === 'hd' )
      {
        depAdd( submodule, config.name ? config.name : submodule.name, 'file:' + p.longPath,  );
      }
      else _.assert( 0 );
    }
  }

  return config;

  /* */

  function pathSimplify( src )
  {
    let r = src;
    if( !_.strIs( r ) )
    return r;

    r = r.replace( '///', '//' );
    r = r.replace( 'npm://', '' );

    return r;
  }

  function depAdd( submodule, name, hash )
  {
    if( submodule.criterion )
    {
      if( submodule.criterion.optional )
      return _depAdd( 'optionalDependencies', name, hash );
      else if( submodule.criterion.development )
      return _depAdd( 'devDependencies', name, hash );
    }
    return _depAdd( 'dependencies', name, hash );
  }

  function _depAdd( section, name, hash )
  {
    config[ section ] = config[ section ] || Object.create( null );
    config[ section ][ name ] = hash ? hash : '';
  }

}

//

function npmGenerateFromWillfile( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, o );
  let verbosity = o.verbosity;
  // let about = module.about.exportStructure();

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( opts ) );

  let currentContext = o.currentContext ? o.currentContext : module;
  opts.packagePath = module.pathResolve
  ({
    selector : opts.packagePath || '{path::out}/package.json',
    prefixlessAction : 'resolved',
    pathNativizing : 0,
    selectorIsPath : 1,
    currentContext : currentContext,
  });
  // opts.packagePath = path.join( module.inPath, opts.packagePath );


  if( opts.entryPath )
  opts.entryPath = module.filesFromResource({ selector : opts.entryPath, currentContext : currentContext });
  if( opts.filesPath )
  opts.filesPath = module.filesFromResource({ selector : opts.filesPath, currentContext : currentContext });

  /* */

  let config = _.will.Module.prototype._npmGenerateFromWillfile.call( will,
  {
    srcConfig :
    {
      about : module.about.exportStructure(),
      path : module.pathMap,
      submodule : module.submoduleMap,
    },
    ... opts,
  });

  // let config = Object.create( null );
  // config.name = about.name;
  // config.version = about.version;
  // config.enabled = about.enabled;
  //
  // if( about.description )
  // config.description = about.description;
  // if( about.keywords )
  // config.keywords = about.keywords;
  // if( about.license )
  // config.license = about.license;
  //
  // if( about.interpreters )
  // {
  //   let interpreters = _.arrayAs( about.interpreters );
  //   interpreters.forEach( ( interpreter ) =>
  //   {
  //     if( _.strHas( interpreter, 'njs' ) )
  //     config.engine = _.strReplace( interpreter, 'njs', 'node' );
  //   });
  // }
  //
  // if( about.author )
  // config.author = about.author;
  // if( about.contributors )
  // config.contributors = about.contributors;
  //
  // for( let n in about )
  // {
  //   if( !_.strBegins( n, 'npm.' ) )
  //   continue;
  //   config[ _.strRemoveBegin( n, 'npm.' ) ] = about[ n ];
  // }
  //
  // if( opts.entryPath && opts.entryPath.length )
  // {
  //   config.main = _.scalarFrom( path.s.relative( path.dir( opts.packagePath ), opts.entryPath ) );
  // }
  //
  // if( opts.filesPath && opts.filesPath.length )
  // {
  //   config.files = path.s.relative( path.dir( opts.packagePath ), opts.filesPath );
  // }
  //
  // if( module.pathMap.repository )
  // config.repository = pathSimplify( module.pathMap.repository );
  // if( module.pathMap.bugtracker )
  // config.bugs = pathSimplify( module.pathMap.bugtracker );
  // if( module.pathMap.entry )
  // config.entry = module.pathMap.entry;
  //
  // for( let n in module.pathMap )
  // {
  //   if( !_.strBegins( n, 'npm.' ) )
  //   continue;
  //   config[ _.strRemoveBegin( n, 'npm.' ) ] = module.pathMap[ n ];
  // }
  //
  // for( let s in module.submoduleMap )
  // {
  //   let submodule = module.submoduleMap[ s ];
  //   let p = submodule.path;
  //   p = path.parseFull( p );
  //
  //   _.assert
  //   (
  //     p.protocol === 'npm' || p.protocol === 'hd',
  //     () => 'Implemented only for "npm" and "hd" dependencies, but got ' + p.full
  //   );
  //
  //   if( p.protocol === 'npm' )
  //   {
  //     depAdd( submodule, path.relative( '/', p.longPath ), p.hash );
  //   }
  //   else if( p.protocol === 'hd' )
  //   {
  //     depAdd( submodule, config.name ? config.name : submodule.name, 'file:' + p.longPath,  );
  //   }
  //   else _.assert( 0 );
  //
  // }

  _.sure( !fileProvider.isDir( opts.packagePath ), () => packagePath + ' is dir, not safe to delete' );

  fileProvider.fileWrite
  ({
    filePath : opts.packagePath,
    data : config,
    encoding : 'json.fine',
    verbosity : verbosity ? 5 : 0,
  });

  return null;

  /* */

  // function pathSimplify( src )
  // {
  //   let r = src;
  //   if( !_.strIs( r ) )
  //   return r;
  //
  //   r = r.replace( '///', '//' );
  //   r = r.replace( 'npm://', '' );
  //
  //   return r;
  // }
  //
  // function depAdd( submodule, name, hash )
  // {
  //   if( submodule.criterion.optional )
  //   _depAdd( 'optionalDependencies', name, hash );
  //   else if( submodule.criterion.development )
  //   _depAdd( 'devDependencies', name, hash );
  //   else
  //   _depAdd( 'dependencies', name, hash );
  // }
  //
  // function _depAdd( section, name, hash )
  // {
  //   config[ section ] = config[ section ] || Object.create( null );
  //   config[ section ][ name ] = hash ? hash : '';
  // }
}

npmGenerateFromWillfile.defaults =
{
  packagePath : 'package.json',
  entryPath : 'Index.js',
  filesPath : null,
  verbosity : null,
}

//

function _willfileGenerateFromNpm( o )
{
  let will = this;
  let fileProvider = will.fileProvider;

  /* */

  let config = o.srcConfig;
  let willfile = Object.create( null );
  willfile.about = Object.create( null );
  willfile.path = Object.create( null );
  willfile.path.origins = [];
  willfile.submodule = Object.create( null );

  /* */

  let propertiesMap =
  {
    name :          { propertyAdd : aboutPropertyAdd, name : 'name' },
    version :       { propertyAdd : aboutPropertyAdd, name : 'version' },
    enabled :       { propertyAdd : aboutPropertyAdd, name : 'enabled' },
    description :   { propertyAdd : aboutPropertyAdd, name : 'description' },
    keywords :      { propertyAdd : aboutPropertyAdd, name : 'keywords' },
    license :       { propertyAdd : aboutPropertyAdd, name : 'license' },
    author :        { propertyAdd : aboutPropertyAdd, name : 'author' },
    contributors :  { propertyAdd : aboutPropertyAdd, name : 'contributors' },
    scripts :       { propertyAdd : aboutPropertyAdd, name : 'npm.scripts' },
    interpreters :  { propertyAdd : interpretersAdd, name : 'interpreters' },
    engine :        { propertyAdd : interpretersAdd, name : 'interpreters' },
    repository :    { propertyAdd : pathPropertyAdd, name : 'repository' },
    bugs :          { propertyAdd : pathPropertyAdd, name : 'bugs' },
    main :          { propertyAdd : pathPropertyAdd, name : 'main' },
    files :         { propertyAdd : pathPropertyAdd, name : 'files' },
    dependencies :          { propertyAdd : submodulePropertyAdd, name : undefined },
    devDependencies :       { propertyAdd : submodulePropertyAdd, name : 'development' },
    optionalDependencies :  { propertyAdd : submodulePropertyAdd, name : 'optional' },
  };

  for( let property in propertiesMap )
  if( property in config )
  propertiesMap[ property ].propertyAdd( property, propertiesMap[ property ].name );

  if( willfile.about.name )
  {
    willfile.about[ 'npm.name' ] = willfile.about.name;
    willfile.path.origins.push( `npm:///${ willfile.about.name }` );
  }
  if( willfile.path.origins.length === 0 )
  {
    delete willfile.path.origins;
  }
  if( _.mapKeys( willfile.submodule ).length === 0 )
  {
    delete willfile.submodule;
  }
  if( _.mapKeys( willfile.path ).length === 0 )
  {
    delete willfile.path;
  }

  /* */

  // _.sure( !fileProvider.isDir( willfilePath ), () => `${ willfilePath } is dir, not safe to delete` );
  // _.sure( !fileProvider.isTerminal( willfilePath ), () => `${ willfilePath } is exists, not safe to rewrite` );

  return willfile;

  // fileProvider.fileWrite
  // ({
  //   filePath : willfilePath,
  //   data : willfile,
  //   encoding : 'yaml',
  //   verbosity : verbosity ? 5 : 0,
  // });
  //
  // return null;

  /* */

  function aboutPropertyAdd( property, name )
  {
    willfile.about[ name ] = config[ property ];
  }

  /* */

  function interpretersAdd( property, name )
  {
    if( _.strHas( config[ property ], 'node' ) )
    willfile.about[ name ] = _.strReplace( config[ property ], 'node', 'njs' );
    else
    willfile.about[ name ] = config[ property ];
  }

  /* */

  function pathPropertyAdd( property )
  {
    if( property === 'repository' )
    {
      willfile.path.repository = pathNormalize( config.repository );
      willfile.path.origins.push( willfile.path.repository );
    }
    if( property === 'bugs' )
    {
      willfile.path.bugtracker = pathNormalize( config.bugs );
    }
    if( property === 'main' )
    {
      willfile.path.entryPath = config.main;
    }
    if( property === 'files' )
    {
      willfile.path.export = path.common( config.files );
    }
  }

  /* */

  function submodulePropertyAdd( property, criterion )
  {
    addDependency( config[ property ], criterion );
  }

  /* */

  function pathNormalize( src )
  {
    if( _.strIs( src ) )
    {
      if( !_.strHas( src, '///' ) )
      return _.strReplace( src, '//', '///' );
      return str;
    }

    let result = src.type;
    result += '+' + src.url.replace( '//', '///' );
    return result;
  }

  /* */

  function addDependency( dependenciesMap, criterion )
  {
    for( let dependency in dependenciesMap )
    {
      if( _.strHas( dependenciesMap[ dependency ], /file:/ ) )
      willfile.submodule[ dependency ] = addHdDependency( dependenciesMap[ dependency ], criterion );
      else
      willfile.submodule[ dependency ] = addNpmDependency( dependency, dependenciesMap[ dependency ], criterion );
    }
  }

  /* */

  function addHdDependency( path, criterion )
  {
    let result = Object.create( null );
    result.path = `hd://${ _.strRemoveBegin( path, 'file:' ) }`;
    result.enabled = 1;
    if( criterion )
    {
      result.criterion = Object.create( null );
      result.criterion[ criterion ] = 1;
    }
    return result;
  }

  /* */

  function addNpmDependency( name, hash, criterion )
  {
    let result = Object.create( null );
    hash = hash === '' ? hash : `#${ hash }`;
    result.path = `npm:///${ name }${ hash }`;
    result.enabled = 1;
    if( criterion )
    {
      result.criterion = Object.create( null );
      result.criterion[ criterion ] = 1;
    }
    return result;
  }

}

_willfileGenerateFromNpm.defaults =
{
  packagePath : null,
  willfilePath : null,
  verbosity : null,
};

//

function willfileGenerateFromNpm( o )
{
  let module = this;
  let will = module.will ? module.will : module;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, o );
  let verbosity = o.verbosity;

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( opts ) );

  let packagePath = opts.packagePath ? opts.packagePath : 'package.json';
  let willfilePath = opts.willfilePath ? opts.willfilePath : '.will.yml';
  if( opts.currentContext )
  {
    packagePath = module.pathResolve
    ({
      selector : opts.packagePath || '{path::in}/package.json',
      prefixlessAction : 'resolved',
      pathNativizing : 0,
      selectorIsPath : 1,
      currentContext : opts.currentContext,
    });
    willfilePath = module.pathResolve
    ({
      selector : opts.willfilePath || '{path::out}/.will.yml',
      prefixlessAction : 'resolved',
      pathNativizing : 0,
      selectorIsPath : 1,
      currentContext : opts.currentContext,
    });
  }
  else
  {
    packagePath = path.join( will.inPath ? will.inPath : path.current(), packagePath );
    willfilePath = path.join( will.inPath ? will.inPath : path.current(), willfilePath );
  }

  /* */

  _.sure( !fileProvider.isDir( willfilePath ), () => `${ willfilePath } is dir, not safe to delete` );
  _.sure( !fileProvider.isTerminal( willfilePath ), () => `${ willfilePath } is exists, not safe to rewrite` );

  let srcConfig = fileProvider.fileRead({ filePath : packagePath, encoding : 'json' })
  let willfile = _.will.Module.prototype._willfileGenerateFromNpm.call( will, { srcConfig } );

  /* */

  fileProvider.fileWrite
  ({
    filePath : willfilePath,
    data : willfile,
    encoding : 'yaml',
    verbosity : o.verbosity ? 5 : 0,
  });

  return null;
}

//

function willfileExtend( o )
{
  let will = this.will ? this.will : this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let opts = _.routineOptions( willfileExtend, o );
  let request = opts.request.split( /\s+/ );

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( opts ) );

  let dstPath = dstPathFind( request[ 0 ] );
  let dstWillfiles = configFilesFind( dstPath, 1 );

  if( opts.format === 'json' )
  _.assert( dstWillfiles.length === 0, 'not implemented' );

  if( path.isGlob( dstPath ) && dstWillfiles.length === 0 )
  _.assert( 0, `Can't find file` );


  /* extension file creation */

  let sectionMap =
  {
    about : aboutSectionExtend,
    build : sectionExtend,
    path : sectionExtend,
    reflector : sectionExtend,
    step : sectionExtend,
    submodule : sectionExtend,
  };

  let willfile = Object.create( null );
  for( let sectionName in sectionMap )
  willfile[ sectionName ] = Object.create( null );

  for( let i = 1 ; i < request.length ; i++ )
  {
    let files = configFilesFind( request[ i ] );

    for( let j = 0 ; j < files.length ; j++ )
    {
      if( _.longHasNone( files[ j ].exts, [ 'yml', 'yaml', 'json' ] ) )
      continue;

      let srcEncoding = files[ j ].ext === 'json' ? 'json' : 'yaml';
      let srcConfig = fileProvider.fileRead({ filePath : files[ j ].absolute, encoding : srcEncoding });
      if( !_.longHas( files[ j ].exts, 'will' ) )
      srcConfig = _.will.Module.prototype._willfileGenerateFromNpm.call( will, { srcConfig });

      for( let sectionName in srcConfig )
      sectionMap[ sectionName ]( willfile, srcConfig, sectionName );
    }
  }

  if( opts.submodulesDisabling )
  for( let dependency in willfile.submodule )
  willfile.submodule[ dependency ].enabled = 0;

  for( let sectionName in sectionMap )
  if( _.mapKeys( willfile[ sectionName ] ).length === 0 )
  delete willfile[ sectionName ];


  /* write destination willfile */

  let dstEncoding = path.ext( dstPath ) === 'json' ? 'json.fine' : 'yaml';
  dstWillfilesWrite( dstWillfiles );

  /* */

  return null;

  /* */

  function dstPathFind( dstPath )
  {
    dstPath = path.join( will.inPath ? will.inPath : path.current(), dstPath );

    if( fileProvider.isTerminal( dstPath ) )
    return dstPath;

    if( fileProvider.isDir( dstPath ) )
    {
      dstPath = path.join( dstPath, opts.format === 'willfile' ? 'will.yml' : 'package.json' );
    }
    else if( !path.isGlob( dstPath ) )
    {
      let exts = path.exts( dstPath );
      if( exts.length === 0 )
      {
        let ext = opts.format === 'willfile' ? '.will.yml' : '.json';
        dstPath = dstPath + ext;
      }
      else
      {
        if( opts.format === 'json' && !_.longHas( exts, 'json' ) )
        {
          exts.push( 'json' );
        }
        else
        {
          if( !_.longHas( [ 'yml', 'json', 'yaml' ], path.ext( dstPath ) ) )
          exts.push( 'yml' );
          if( !_.longHas( exts ), 'will' )
          exts.splice( exts.length - 1, 0, 'will' );
        }

        dstPath = path.dir( dstPath ) + path.name( dstPath ) + '.' + exts.join( '.' );
      }
    }
    return dstPath;
  }

  /* */

  function configFilesFind( selector, findDst )
  {
    let filePath = selector;
    if( !path.isAbsolute( filePath ) )
    filePath = path.join( will.inPath ? will.inPath : path.current(), selector );

    if( fileProvider.isTerminal( filePath ) )
    {
      if( !findDst && dstWillfiles.length )
      {
        if( dstWillfiles[ 0 ].absolute === filePath )
        return [];
        if( dstWillfiles[ 1 ] && dstWillfiles[ 1 ].absolute === filePath )
        return [];
      }
      return [ fileProvider.record( filePath ) ];
    }

    if( !path.isGlob( filePath ) )
    {
      if( fileProvider.isDir( filePath ) )
      filePath = path.join( filePath, '*.(yml|yaml|json)' );
      else
      filePath = filePath + '*.(yml|yaml|json)';
    }

    let filter;
    if( findDst )
    filter = { filePath : { [ `${selector}*` ] : true } };
    else
    filter = { filePath : { [ `${selector}*` ] : true, [ dstPath ] : 0 } };

    return fileProvider.filesFind
    ({
      filePath : filePath,
      withStem : 0,
      withDirs : 0,
      mode : 'distinct',
      mandatory : 0,
      filter,
    });
  }

  /* */

  function aboutSectionExtend( dst, src, name )
  {
    if( !opts.about )
    return;

    let keys =
    [
      'name',
      'version',
      'enabled',
      'description',
      'license',
      'author',
      'npm.name',
    ];
    let extendingMap = Object.create( null );
    for( let i = 0 ; i < keys.length ; i++ )
    if( opts[ keys[ i ] ] && ( src.about[ keys[ i ] ] !== undefined ) )
    extendingMap[ keys[ i ] ] = src.about[ keys[ i ] ];

    opts.onSection( dst.about, extendingMap );

    /* */

    if( opts.keywords && src.about.keywords )
    {
      dst.about.keywords = _.scalarAppendOnce( dst.about.keywords, src.about.keywords );
    }
    if( opts.contributors && src.about.contributors )
    {
      dst.about.contributors = arrayPropertyParse( dst.about.contributors, _.strIsolateRightOrAll );
      src.about.contributors = arrayPropertyParse( src.about.contributors, _.strIsolateRightOrAll );
      opts.onSection( dst.about.contributors, src.about.contributors );
    }
    if( opts.interpreters && src.about.interpreters )
    {
      dst.about.interpreters = arrayPropertyParse( dst.about.interpreters, _.strIsolateLeftOrAll );
      src.about.interpreters = arrayPropertyParse( src.about.interpreters, _.strIsolateLeftOrAll );
      opts.onSection( dst.about.interpreters, src.about.interpreters );
    }
    if( opts[ 'npm.scripts' ] && src.about[ 'npm.scripts' ] )
    {
      if( dst.about[ 'npm.scripts' ] === undefined )
      dst.about[ 'npm.scripts' ] = Object.create( null );
      opts.onSection( dst.about[ 'npm.scripts' ], src.about[ 'npm.scripts' ] );
    }
  }

  /* */

  function arrayPropertyParse( src, parser )
  {
    let result = Object.create( null );
    if( _.longIs( src ) )
    {
      for( let i = 0 ; i < src.length ; i++ )
      {
        let splits = parser({ src : src[ i ] });
        result[ splits[ 0 ] ] = splits[ 2 ];
      }
      return result;
    }
    else if( src === undefined )
    {
      return result;
    }
    return src;
  }

  /* */

  function sectionExtend( dst, src, name )
  {
    if( !opts[ name ] )
    return;
    opts.onSection( dst[ name ], src[ name ] );
  }

  /* */

  function dstWillfilesWrite( dstWillfiles )
  {
    if( dstWillfiles.length !== 0 )
    {

      _.assert( dstWillfiles.length <= 2, 'Please, improve selector, cannot choose willfiles' );

      let config = fileProvider.fileRead({ filePath : dstWillfiles[ 0 ].absolute, encoding : dstEncoding });
      if( dstWillfiles.length === 2 )
      {
        let config2 = fileProvider.fileRead({ filePath : dstWillfiles[ 1 ].absolute, encoding : dstEncoding });
        for( let sectionName in config2 )
        {
          if( sectionName in willfile )
          {
            if( sectionName in config )
            {
              let screenMap = _.mapBut( willfile[ sectionName ], config[ sectionName ] );
              let srcMap = _.mapBut( willfile[ sectionName ], screenMap );
              opts.onSection( config[ sectionName ], srcMap );
              willfile[ sectionName ] = screenMap;
            }

            sectionMap[ sectionName ]( config2, willfile, sectionName );
            delete willfile[ sectionName ];
          }
        }
        willfileWrite( dstWillfiles[ 1 ].absolute, config2, dstEncoding );
      }

      for( let sectionName in willfile )
      {
        if( config[ sectionName ] === undefined )
        config[ sectionName ] = Object.create( null );
        sectionMap[ sectionName ]( config, willfile, sectionName );
      }
      willfileWrite( dstWillfiles[ 0 ].absolute, config, dstEncoding );

    }
    else
    {
      willfileWrite( dstPath, willfile, dstEncoding );
    }
  }

  /* */

  function willfileWrite( path, data, encoding )
  {
    if( data.about )
    {
      if( data.about.contributors )
      data.about.contributors = mapToArrayOfStrings( data.about.contributors );
      if( data.about.interpreters )
      data.about.interpreters = mapToArrayOfStrings( data.about.interpreters );
    }


    if( opts.format === 'json' )
    data = _.will.Module.prototype._npmGenerateFromWillfile.call( will,
    {
      srcConfig : data,
      packagePath : path,
    });

    fileProvider.fileWrite
    ({
      filePath : path,
      data,
      encoding,
      verbosity : opts.verbosity,
    });

  }

  function mapToArrayOfStrings( src )
  {
    if( _.longIs( src ) )
    return src;

    src = _.mapToArray( src );
    for( let i = 0 ; i < src.length ; i++ )
    src[ i ] = src[ i ].join( ' ' );
    return src;
  }
}

willfileExtend.defaults =
{
  about : 1,
  build : 1,
  path : 1,
  reflector : 1,
  step : 1,
  submodule : 1,

  name : 1,
  version : 1,
  author : 1,
  enabled : 1,
  description : 1,
  contributors : 1,
  interpreters : 1,
  license : 1,
  keywords : 1,
  'npm.name' : 1,
  'npm.scripts' : 1,

  request : null,
  onSection : null,
  submodulesDisabling : 0,
  format : 'willfile',
  verbosity : 3,
  v : null,
}

//

function ResourceSetter_functor( op )
{
  _.routineOptions( ResourceSetter_functor, arguments );

  let resourceName = op.resourceName;
  let mapName = op.mapName;
  let mapSymbol = Symbol.for( mapName );

  return function resourceSet( resourceMap2 )
  {
    let module = this;
    let resourceMap = module[ mapSymbol ] = module[ mapSymbol ] || Object.create( null );

    _.assert( arguments.length === 1 );
    _.assert( _.mapIs( resourceMap ) );
    _.assert( _.mapIs( resourceMap2 ) );

    for( let m in resourceMap )
    {
      let resource = resourceMap[ m ];
      _.assert( _.instanceIs( resource ) );
      _.assert( resource.module === module );

      if( !resource.importableFromIn && !resource.importableFromOut )
      continue;
      resource.finit();
      _.assert( resourceMap[ m ] === undefined );
    }

    if( resourceMap2 === null )
    return resourceMap;

    for( let m in resourceMap2 )
    {
      let resource = resourceMap2[ m ];

      _.assert( module.preformed === 0 );
      _.assert( _.instanceIs( resource ) );
      _.assert( resource.module !== module );

      if( resourceMap[ m ] )
      continue;

      if( resource.module !== null )
      resource = resource.clone();
      _.assert( resource.formed === 0 );
      resource.module = module;
      resource.form1();
      _.assert( !_.workpiece.isFinited( resource ) );
    }

    return resourceMap;
  }

}

ResourceSetter_functor.defaults =
{
  resourceName : null,
  mapName : null,
}

// --
// remote
// --

function _remoteChanged()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( !!module.pathResourceMap[ 'current.remote' ] );
  _.assert( module.commonPath === module.localPath );

  /* */

  if( module.remotePath )
  {
    module.remotePathEachAdoptCurrent();
  }

  /* */

  if( module.remotePath && module.downloadPath )
  {
    let remoteProvider = fileProvider.providerForPath( module.remotePath );
    _.assert( !!remoteProvider.isVcs );
    // let result = remoteProvider.versionLocalRetrive({ localPath : module.downloadPath, detailing : 1 });
    let result = remoteProvider.versionLocalRetrive({ localPath : module.downloadPath, verbosity : 1 });
    if( result.version )
    {
      let remotePath = _.uri.parseConsecutive( module.remotePath );
      if( result.isBranch )
      remotePath.tag = result.version;
      else
      remotePath.hash = result.version;
      module.pathResourceMap[ 'current.remote' ].path = _.uri.str( remotePath );
    }
  }
  else
  {
    module.pathResourceMap[ 'current.remote' ].path = null;
  }

  /* */

  if( module.peerModule && !module.peerModule.remotePath && module.remotePath )
  {

    _.assert( _.strDefined( module.downloadPath ) );
    module.peerModule.remotePathEachAdopt
    ({
      remotePath : module.peerRemotePathGet(),
      downloadPath : module.downloadPath,
    });

  }

  /* */

}

// --
// git
// --

function gitPull( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.routineOptions( gitPull, o );

  o.dirPath = module.pathResolve
  ({
    selector : o.dirPath || module.dirPath,
    prefixlessAction : 'resolved',
    pathNativizing : 0,
    selectorIsPath : 1,
    currentContext : module.stepMap[ 'git.pull' ],
  });

  let status = _.git.statusFull
  ({
    insidePath : o.dirPath,
    unpushed : 0,
    prs : 0,
    remote : 1,
  });

  if( !status.isRepository || !status.remote )
  return null;

  if( o.verbosity )
  logger.log( `Pulling ${module.nameWithLocationGet()}` );

  if( status.uncommitted )
  {
    throw _.errBrief( `${module.nameWithLocationGet()} has local changes!` );
    return null;
  }

  let config = fileProvider.configUserRead();
  let provider = _.FileFilter.Archive();
  provider.archive.basePath = will.currentOpener.dirPath;
  if( config && config.path && config.path.link )
  provider.archive.basePath = _.arrayAppendArraysOnce( _.arrayAs( provider.archive.basePath ), _.arrayAs( config.path.link ) );

  provider.archive.fileMapAutosaving = 1;

  if( o.verbosity )
  provider.archive.verbosity = 2;
  else
  provider.archive.verbosity = 0;

  provider.archive.allowingMissed = 1;
  provider.archive.allowingCycled = 1;
  provider.archive.restoreLinksBegin();

  let ready = new _.Consequence().take( null );

  _.process.start
  ({
    execPath : `git pull`,
    currentPath : o.dirPath,
    ready : ready,
  });

  ready.tap( () =>
  {
    provider.archive.restoreLinksEnd();
  });

  ready.catch( ( err ) =>
  {
    err = _.errBrief( err );
    logger.error( _.errOnce( err ) );
    throw err;
  });

  return ready;
}

gitPull.defaults =
{
  dirPath : null,
  v : null,
  verbosity : 2,
}

//

function gitPush( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.routineOptions( gitPush, o );

  o.dirPath = module.pathResolve
  ({
    selector : o.dirPath || module.dirPath,
    prefixlessAction : 'resolved',
    pathNativizing : 0,
    selectorIsPath : 1,
    currentContext : module.stepMap[ 'git.push' ],
  });

  let status = _.git.statusFull
  ({
    insidePath : o.dirPath,
    local : 0,
    uncommitted : 0,
    unpushed : 1,
    unpushedTags : 1,
    remote : 0,
    prs : 0,
  });

  if( !status.isRepository )
  return null;
  if( !status.unpushed )
  return null;

  if( o.verbosity )
  logger.log( `Pushing ${module.nameWithLocationGet()}` );

  let ready = new _.Consequence().take( null );
  let start = _.process.starter
  ({
    currentPath : o.dirPath,
    ready : ready,
  });

  start( `git push -u origin --all` );
  if( status.unpushedTags )
  start( `git push --tags -f` );

  ready.catch( ( err ) =>
  {
    err = _.errBrief( err );
    logger.error( _.errOnce( err ) );
    throw err;
  });

  return ready;
}

gitPush.defaults =
{
  dirPath : null,
  v : null,
  verbosity : 2,
}

//

function gitReset( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.routineOptions( gitReset, o );

  o.dirPath = module.pathResolve
  ({
    selector : o.dirPath || module.dirPath,
    prefixlessAction : 'resolved',
    pathNativizing : 0,
    selectorIsPath : 1,
    currentContext : module.stepMap[ 'git.reset' ],
  });

  if( !_.git.isRepository({ localPath : o.dirPath, sync : 1 }) )
  return null;

  if( o.dry )
  return null;

  if( o.verbosity )
  logger.log( `Resetting ${module.nameWithLocationGet()}` );

  _.git.reset
  ({
    localPath : o.dirPath,
    removingUntracked : o.removingUntracked,
    sync : 1,
  });

  return null;
}

gitReset.defaults =
{
  dry : null,
  removingUntracked : 0,
  dirPath : null,
  v : null,
  verbosity : 2,
}

//

function gitStatus( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.routineOptions( gitStatus, o );

  o.dirPath = module.pathResolve
  ({
    selector : o.dirPath || module.dirPath,
    prefixlessAction : 'resolved',
    pathNativizing : 0,
    selectorIsPath : 1,
    currentContext : module.stepMap[ 'git.status' ],
  });

  /* read stats to fix for windows to update edit time of hard linked files */
  if( process.platform === 'win32' )
  fileProvider.filesFind({ filePath : context.junction.dirPath + '**', safe : 0 });

  let config = fileProvider.configUserRead();
  let token = null;
  if( config !== null && config.about && config.about[ 'github.token' ] )
  token = config.about[ 'github.token' ];

  let o2 = _.mapOnly( o, _.git.statusFull.defaults );
  o2.insidePath = o.dirPath;
  if( !o2.token )
  o2.token = token;
  debugger;
  let got = _.git.statusFull( o2 );

  if( !got.status )
  return null;

  logger.log( module.nameWithLocationGet() );
  logger.log( got.status );
  return got;
}

gitStatus.defaults =
{
  local : 1,
  uncommittedIgnored : 0,
  remote : 1,
  remoteBranches : 0,
  prs : 1,
  v : null,
  verbosity : 1,
  uncommitted : null,
  uncommittedUntracked : null,
  uncommittedAdded : null,
  uncommittedChanged : null,
  uncommittedDeleted : null,
  uncommittedRenamed : null,
  uncommittedCopied : null,
  unpushed : null,
  unpushedCommits : null,
  unpushedTags : null,
  unpushedBranches : null,
  remoteCommits : null,
  remoteTags : null,
  token : null,
}

//

function gitSync( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.routineOptions( gitSync, o );

  o.dirPath = module.pathResolve
  ({
    selector : o.dirPath || module.dirPath,
    prefixlessAction : 'resolved',
    pathNativizing : 0,
    selectorIsPath : 1,
    currentContext : module.stepMap[ 'git.sync' ],
  });

  /* read stats to fix for windows to update edit time of hard linked files */
  if( process.platform === 'win32' )
  fileProvider.filesFind({ filePath : o.dirPath + '**', safe : 0 });

  let status = _.git.statusFull
  ({
    insidePath : o.dirPath,
  });

  if( o.dry )
  return null;

  /* */

  let ready =  new _.Consequence().take( null );
  ready.then( () =>
  {
    if( status.uncommitted )
    return gitCommit();
    return null;
  })
  .then( () =>
  {
    if( status.remote )
    return module.gitPull.call( module, _.mapBut( o, { commit : '.', dry : '.' } ) );
    return null;
  })
  .then( () =>
  {
    if( status.local )
    return module.gitPush.call( module, _.mapBut( o, { commit : '.', dry : '.' } ) );
    return null;
  })

  return ready;

  /* */

  function gitCommit()
  {
    let con =  new _.Consequence().take( null );
    let start = _.process.starter
    ({
      currentPath : o.dirPath,
      ready : con,
    });
    if( o.verbosity )
    logger.log( `Committing ${module.nameWithLocationGet()}` );

    start( `git add --all` );
    if( o.commit )
    start( `git commit ${o.commit}` );
    else
    start( 'git commit -am "."' );

    return con;
  }
}

gitSync.defaults =
{
  commit : '.',
  dirPath : null,
  dry : 0,
  v : null,
  verbosity : 1,
}

//

function gitTag( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.routineOptions( gitTag, o );

  o.dirPath = module.pathResolve
  ({
    selector : o.dirPath || module.dirPath,
    prefixlessAction : 'resolved',
    pathNativizing : 0,
    selectorIsPath : 1,
    currentContext : module.stepMap[ 'git.tag' ],
  });

  if( module.repo.remotePath || !module.about.name )
  {
    throw _.errBrief( 'Module should be local, opened and have name' );
  }

  if( !_.strDefined( o.name ) )
  {
    throw _.errBrief( 'Expects name of tag defined' );
  }

  if( o.description === null )
  o.description = o.name;

  let localPath = _.git.localPathFromInside( o.dirPath );

  if( !_.git.isRepository({ localPath }) )
  return null;

  if( o.dry )
  return null;

  if( o.verbosity )
  logger.log( `Creating tag ${o.name}` );

  _.git.tagMake
  ({
    localPath,
    tag : o.name,
    description : o.description || '',
    light : o.light,
    sync : 1,
  });

  return null;
}

gitTag.defaults =
{
  name : null,
  description : '',
  dry : 0,
  light : 0,
  v : null,
  verbosity : 1,
}

// --
// etc
// --

function shell( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !_.mapIs( arguments[ 0 ] ) )
  o = { execPath : arguments[ 0 ] }

  o = _.routineOptions( shell, o );
  _.assert( _.strIs( o.execPath ) );
  _.assert( arguments.length === 1 );
  _.assert( o.verbosity === null || _.numberIs( o.verbosity ) );

  /* */

  o.execPath = module.resolve
  ({
    selector : o.execPath,
    prefixlessAction : 'resolved',
    currentThis : o.currentThis,
    currentContext : o.currentContext,
    pathNativizing : 1,
    arrayFlattening : 0, /* required for f::this and feature make */
  });

  /* */

  if( o.currentPath )
  o.currentPath = module.pathResolve
  ({
    selector : o.currentPath,
    prefixlessAction : 'resolved',
    currentContext : o.currentContext,
  });
  _.sure
  (
      o.currentPath === null || _.strIs( o.currentPath ) || _.strsAreAll( o.currentPath )
    , 'Current path should be string if defined'
  );

  /* */

  let ready = new _.Consequence().take( null );

  _.process.start
  ({
    execPath : o.execPath,
    currentPath : o.currentPath,
    verbosity : o.verbosity !== null ? o.verbosity : will.verbosity - 1,
    ready : ready,
  });

  return ready;
}

shell.defaults =
{
  execPath : null,
  currentPath : null,
  currentThis : null,
  currentContext : null,
  verbosity : null,
}

//

function errTooMany( builds, what )
{
  let module = this;
  let will = module.will;
  let logger = will.logger;
  let prefix = '';
  let err;

  if( logger.verbosity >= 2 && builds.length > 1 )
  {
    prefix = module.resourcesExportInfo( builds );
  }

  if( builds.length !== 1 )
  {
    debugger;
    if( builds.length === 0 )
    err = _.errBrief( prefix, '\nPlease specify exactly one ' + what + ', none satisfies passed arguments' );
    else
    err = _.errBrief( prefix, '\nPlease specify exactly one ' + what + ', ' + builds.length + ' satisfy(s)' + '\nFound : ' + _.strQuote( _.select( builds, '*/name' ) ) );
    return err;
  }

  return false;
}

//

function assertIsValidIntegrity()
{
  let module = this;

  if( module.userArray )
  _.each( module.userArray, ( opener ) =>
  {
    if( !( opener instanceof _.will.ModuleOpener ) )
    return;
    _.assert( !opener.isFinited() );
    _.assert( opener.openedModule === module );
    _.assert( opener.peerModule === module.peerModule );
    _.assert( _.entityIdentical( opener.__.willfilesPath, module.willfilesPath ) );
    _.assert( opener.__.dirPath === module.dirPath );
    _.assert( opener.__.commonPath === module.commonPath );
    _.assert( opener.__.localPath === module.localPath );
    _.assert( opener.__.remotePath === module.remotePath );
    _.assert( module.commonPath === module.localPath );
    _.assert( opener.superRelation === null || _.longHas( module.superRelations, opener.superRelation ) );
  });

  if( module.superRelations )
  _.each( module.superRelations, ( relation ) =>
  {
    _.assert( !!relation.opener );
    _.assert( !relation.isFinited() );
    _.assert
    (
        _.longHas( module.userArray, relation.opener )
      , `${module.nameWithLocationGet()} does not have reference on its`
      + `\n${relation.opener.nameWithLocationGet}`
    );
  });

  return true;
}

// --
// relations
// --

let rootModuleSymbol = Symbol.for( 'rootModule' );
let peerModuleSymbol = Symbol.for( 'peerModule' );
let superRelationsSymbol = Symbol.for( 'superRelations' );

let SharedPaths =
{

  'localPath' : null,
  'remotePath' : null,
  'willfilesPath' : null,
  'commonPath' : null,
  'downloadPath' : null,
  'dirPath' : null,

};

let ResourceToPathName = new _.NameMapper().set
({

  'local' : 'localPath',
  'remote' : 'remotePath',
  'module.willfiles' : 'willfilesPath',
  'module.common' : 'commonPath',
  'download' : 'downloadPath',
  'module.dir' : 'dirPath',
  'in' : 'inPath',
  'out' : 'outPath',
  'current.remote' : 'currentRemotePath',
  'module.original.willfiles' : 'originalWillfilesPath',
  'module.peer.willfiles' : 'peerWillfilesPath',
  'module.peer.in' : 'peerInPath',

});

let Composes =
{

  willfilesPath : null,
  localPath : null,
  downloadPath : null,
  remotePath : null,

  verbosity : 0,

}

let Aggregates =
{

  about : _.define.instanceOf( _.will.ParagraphAbout ),
  submoduleMap : _.define.own({}),
  pathResourceMap : _.define.own({}),
  reflectorMap : _.define.own({}),
  stepMap : _.define.own({}),
  buildMap : _.define.own({}),
  exportedMap : _.define.own({}),

}

let Associates =
{

  will : null,
  rootModule : null,
  superRelations : _.define.own([]),
  original : null,
  willfilesArray : _.define.own([]),
  storedWillfilesArray : _.define.own([]),

}

let Medials =
{
}

let Restricts =
{

  id : null,
  stager : null,
  peerModuleIsOutdated : null,
  _registeredPath : null,

  pathMap : _.define.own({}),
  moduleWithNameMap : null,
  userArray : _.define.own([]),

  formed2 : 0,
  predefinedFormed : 0,
  preformed : 0,
  opened : 0,
  attachedWillfilesFormed : 0,
  peerModulesFormed : 0,
  subModulesFormed : 0,
  resourcesFormed : 0,
  finalFormed : 0,

  preformReady : _.define.own( _.Consequence({ capacity : 1, tag : 'preformReady' }) ),
  openedReady : _.define.own( _.Consequence({ capacity : 1, tag : 'openedReady' }) ),
  attachedWillfilesFormReady : _.define.own( _.Consequence({ capacity : 1, tag : 'attachedWillfilesFormReady' }) ),
  peerModulesFormReady : _.define.own( _.Consequence({ capacity : 1, tag : 'peerModulesFormReady' }) ),
  subModulesFormReady : _.define.own( _.Consequence({ capacity : 1, tag : 'subModulesFormReady' }) ),
  resourcesFormReady : _.define.own( _.Consequence({ capacity : 1, tag : 'resourcesFormReady' }) ),
  ready : _.define.own( _.Consequence({ capacity : 1, tag : 'ready' }) ),

}

let Statics =
{

  SharedPaths,
  ResourceToPathName,
  ResourceSetter_functor,

}

let Forbids =
{

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
  Counter : 'Counter',
  pickedWillfilesPath : 'pickedWillfilesPath',
  supermodule : 'supermodule',
  submoduleAssociation : 'submoduleAssociation',
  pickedWillfileData : 'pickedWillfileData',
  willfilesFound : 'willfilesFound',
  willfilesOpened : 'willfilesOpened',
  willfilesFindReady : 'willfilesFindReady',
  willfilesOpenReady : 'willfilesOpenReady',
  aliasName : 'aliasName',
  moduleWithCommonPathMap : 'moduleWithCommonPathMap',
  openedModule : 'openedModule',
  openerModule : 'openerModule',
  willfilesReadTimeReported : 'willfilesReadTimeReported',
  willfilesReadBeginTime : 'willfilesReadBeginTime',
  isDownloaded : 'isDownloaded',
  isOutFile : 'isOutFile',
  picked : 'picked',
  pickedReady : 'pickedReady',
  superRelation : 'superRelation',
  enabled : 'enabled',
  formed : 'formed',

}

let Accessors =
{

  about : { set : _.accessor.setter.friend({ name : 'about', friendName : 'module', maker : _.will.ParagraphAbout }) },
  rootModule : { get : rootModuleGet, set : rootModuleSet },
  peerModule : { set : peerModuleSet },

  submoduleMap : { set : ResourceSetter_functor({ resourceName : 'ModulesRelation', mapName : 'submoduleMap' }) },
  pathResourceMap : { set : ResourceSetter_functor({ resourceName : 'PathResource', mapName : 'pathResourceMap' }) },
  reflectorMap : { set : ResourceSetter_functor({ resourceName : 'Reflector', mapName : 'reflectorMap' }) },
  stepMap : { set : ResourceSetter_functor({ resourceName : 'Step', mapName : 'stepMap' }) },
  buildMap : { set : ResourceSetter_functor({ resourceName : 'Build', mapName : 'buildMap' }) },
  exportedMap : { set : ResourceSetter_functor({ resourceName : 'Exported', mapName : 'exportedMap' }) },
  superRelations : { set : superRelationsSet },

  name : { get : nameGet, readOnly : 1 },
  absoluteName : { get : absoluteNameGet, readOnly : 1 }, /* xxx : deprecate option readOnly */
  aliasNames : { get : aliasNamesGet, readOnly : 1 },

  willfilesPath : { get : willfilesPathGet, set : willfilesPathSet },
  inPath : { get : inPathGet, set : inPathSet },
  outPath : { get : outPathGet, set : outPathSet },
  localPath : { get : localPathGet, set : localPathSet },
  downloadPath : { get : downloadPathGet, set : downloadPathSet },
  remotePath : { get : remotePathGet, set : remotePathSet },
  dirPath : { get : dirPathGet, readOnly : 1 },
  commonPath : { get : commonPathGet, readOnly : 1 },
  currentRemotePath : { get : currentRemotePathGet, readOnly : 1 },
  willPath : { get : willPathGet, readOnly : 1 },
  originalWillfilesPath : { get : originalWillfilesPathGet, readOnly : 1 },
  peerWillfilesPath : { get : peerWillfilesPathGet, readOnly : 1 },
  peerInPath : { get : peerInPathGet, readOnly : 1 },

  decoratedWillfilesPath : { get : decoratedWillfilesPathGet, readOnly : 1, },
  decoratedInPath : { get : decoratedInPathGet, readOnly : 1, },
  decoratedOutPath : { get : decoratedOutPathGet, readOnly : 1, },
  decoratedLocalPath : { get : decoratedLocalPathGet, readOnly : 1, },
  decoratedDownloadPath : { get : decoratedDownloadPathGet, readOnly : 1, },
  decoratedRemotePath : { get : decoratedRemotePathGet, readOnly : 1, },
  decoratedDirPath : { get : decoratedDirPathGet, readOnly : 1 },
  decoratedCommonPath : { get : decoratedCommonPathGet, readOnly : 1 },
  decoratedCurrentRemotePath : { get : decoratedCurrentRemotePathGet, readOnly : 1 },
  decoratedWillPath : { get : decoratedWillPathGet, readOnly : 1 },
  decoratedOriginalWillfilesPath : { get : decoratedOriginalWillfilesPathGet, readOnly : 1 },
  decoratedPeerWillfilesPath : { get : decoratedPeerWillfilesPathGet, readOnly : 1 },
  decoratedPeerInPath : { get : decoratedPeerInPathGet, readOnly : 1 },

}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,

  precopy1,
  precopy2,
  precopy,
  postcopy,
  copy,
  clone,
  cloneExtending,

  outModuleMake,
  outModuleOpen,
  outModuleOpenOrMake,

  // former

  unform,
  preform,
  _preform,
  _performBegin,
  upform,
  reform_,

  // predefined

  predefinedForm,
  _predefinedOptionsPrepare,
  predefinedPathMake,
  predefinedStepMake,
  predefinedReflectorMake,

  // relator

  releasedBy,
  usedBy,
  isUsedBy,
  isUsed,
  usersGet,
  own,

  // opener

  isOpened,
  isValid,
  isConsistent,
  isFull,
  isAliveGet,
  isPreformed,
  reopen,
  close,
  _formEnd,

  // willfiles

  willfilesOpen,
  _willfilesOpen,
  _willfilesOpenEnd,

  _willfilesReadBegin,
  _willfilesReadEnd,

  willfileUnregister,
  willfileRegister,

  _willfilesExport,
  willfilesEach,

  willfilesSave,

  _attachedWillfilesForm,
  _attachedWillfilesOpen,
  _attachedWillfileOpen,

  // build / export

  exportAuto,
  moduleBuild,
  moduleExport,
  exportedMake,

  // batcher

  modulesEach,
  modulesEachAll,

  modulesBuild,
  modulesExport,
  modulesUpform,

  // submodule

  rootModuleGet,
  rootModuleSet,
  rootModuleSetAct,
  superRelationsSet,
  superRelationsAppend,
  superRelationsRemove,

  submodulesAreDownloaded,
  submodulesAllAreDownloaded,
  submodulesAreValid,
  submodulesAllAreValid,
  submodulesClean,

  _subModulesDownload,
  subModulesDownload,
  subModulesUpdate,
  subModulesAgree,

  submodulesFixate,
  moduleFixate,
  moduleFixateAct,
  moduleFixatePathFor,

  submodulesVerify,
  submodulesRelationsFilter,
  submodulesRelationsOwnFilter,

  submodulesAdd,
  submodulesReload,
  submodulesForm,
  _subModulesForm,

  // peer

  peerModuleOpen,
  _peerModulesForm,
  _peerChanged,
  peerModuleSet,
  peerWillfilesPathFromWillfiles,
  submodulesPeersOpen,
  peerModuleFromJunction,

  // resource

  resourcesForm,
  _resourcesForm,
  _resourcesFormAct,
  _resourcesAllForm,

  resourceClassForKind,
  resourceMapForKind,
  resourceMapsForKind,
  resourceMaps,
  resourceGet,
  resourceObtain,
  resourceAllocate,
  resourceGenerate,
  resourceNameAllocate,
  resourceNameGenerate,

  // clean

  cleanWhatSingle,
  cleanWhat,
  cleanLog,
  clean,

  // resolver

  resolve,

  resolveMaybe,
  resolveRaw,
  pathResolve,
  pathOrReflectorResolve,
  filesFromResource,
  submodulesResolve,
  reflectorResolve,

  // other resolver

  _buildsResolve,
  buildsResolve,
  exportsResolve,
  willfilesResolve,

  // path

  pathsRelative,
  pathsRebase,

  _pathChanged,
  _pathResourceChanged,
  _filePathChanged1,
  _filePathChanged2,
  _pathRegister,
  _pathUnregister,
  inPathGet,
  outPathGet,
  outfilePathGet,
  cloneDirPathGet,
  peerLocalPathGet,
  peerRemotePathGet,
  peerInPathGet,

  willfilesPathGet,
  dirPathGet,
  commonPathGet,
  localPathGet,
  remotePathGet,
  currentRemotePathGet,
  willPathGet,
  originalWillfilesPathGet,
  peerWillfilesPathGet,
  peerInPathGet,

  decoratedWillfilesPathGet,
  decoratedInPathGet,
  decoratedOutPathGet,
  decoratedDirPathGet,
  decoratedCommonPathGet,
  decoratedLocalPathGet,
  decoratedRemotePathGet,
  decoratedCurrentRemotePathGet,
  decoratedWillPathGet,
  decoratedOriginalWillfilesPathGet,
  decoratedPeerWillfilesPathGet,
  decoratedPeerInPathGet,

  _inPathPut,
  _outPathPut,
  _willfilesPathPut,
  _dirPathPut,
  _commonPathPut,
  _localPathPut,
  _downloadPathPut,
  _remotePathPut,
  _currentRemotePathPut,
  _originalWillfilesPathPut,
  _peerWillfilesPathPut,
  _peerInPathPut,

  inPathSet,
  outPathSet,
  willfilesPathSet,
  localPathSet,
  remotePathSet,
  remotePathEachAdoptAct,

  // name

  originGet,
  originShortGet,
  originDirNameGet,
  nameGet,
  _nameChanged,
  _nameUnregister,
  _nameRegister,
  absoluteNameGet,
  shortNameArrayGet,

  // coercer

  toModule,
  toOpener,
  toRelation,
  toOpener,
  toJunction,

  // exporter

  optionsForOpenerExport,

  exportString,
  infoExportPaths,
  resourcesExportInfo,
  infoExportModulesTopological,

  exportStructure,
  structureExportOut,
  structureExportForModuleExport,
  structureExportResources,
  structureExportModules,
  structureExportConsistency,

  resourceImport,

  _npmGenerateFromWillfile,
  npmGenerateFromWillfile,
  _willfileGenerateFromNpm,
  willfileGenerateFromNpm,
  willfileExtend,

  // remote

  _remoteChanged,

  // git

  gitPull,
  gitPush,
  gitReset,
  gitStatus,
  gitSync,
  gitTag,

  // etc

  shell,
  errTooMany,
  assertIsValidIntegrity,

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

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

/* aaa2 : move each class under namespace _.will */ /* Dmytro : moved. Main class `Will` is saved */

_.will[ Self.shortName ] = Self; /* aaa : uncomment */ /* Dmytro : done */

// _.staticDeclare /* aaa : comment out */ /* Dmytro : done */
// ({
//   prototype : _.Will.prototype,
//   name : Self.shortName,
//   value : Self,
// });

})();
