( function _OpenedModule_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.AbstractModule;
let Self = function wWillOpenedModule( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'OpenedModule';

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
  logger.log( module.nickName, 'finit.begin' );

  module.unform();
  module.about.finit();

  let finited = _.err( 'Finited' );
  finited.finited = true;
  module.stager.stageCancel( 'preformed' );
  module.stager.stageCancel( 'formed' );
  module.stager.stagesState( 'skipping', true );
  module.stager.stageError( 'formed', finited );

  _.assert( Object.keys( module.exportedMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.pathResourceMap ).length === 0 );
  _.assert( Object.keys( module.submoduleMap ).length === 0 );

  _.assert( _.instanceIsFinited( module.about ) );

  let result = Parent.prototype.finit.apply( module, arguments );

  if( will.verosity >= 5 )
  logger.log( module.nickName, 'finit.end' );

  return result;
}

//

function init( o )
{
  let module = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  module[ willfilesPathSymbol ] = null;
  module[ dirPathSymbol ] = null;
  module[ commonPathSymbol ] = null;
  module[ configNameSymbol ] = null;
  module[ willfileWithRoleMapSymbol ] = Object.create( null );
  module[ willfileArraySymbol ] = [];
  module.pathResourceMap = module.pathResourceMap || Object.create( null );

  Parent.prototype.init.apply( module, arguments );

  module.precopy( o );

  let will = o.will;
  let logger = will.logger;
  _.assert( !!will );

  module.stager = new _.Stager
  ({
    object : module,
    verbosity : Math.max( Math.min( will.verbosity, will.verboseStaging ), will.verbosity - 6 ),
    stageNames : [ 'preformed', 'picked', 'opened', 'submodulesFormed', 'resourcesFormed', 'formed' ],
    consequenceNames : [ 'preformReady', 'pickedReady', 'openedReady', 'submodulesFormReady', 'resourcesFormReady', 'ready' ],
    onPerform : [ module._preform, module._willfilesPicked, module._willfilesOpen, module._submodulesForm, module._resourcesForm, null ],
    onBegin : [ null, null, null, null, null, null ],
    onEnd : [ null, null, null, module._willfilesReadEnd, null, module._formEnd ],
  });

  module.stager.stageStatePausing( 'picked', 1 );
  module.stager.stageStateSkipping( 'resourcesFormed', 1 );

  module.predefinedForm();
  module.moduleWithNameMap = Object.create( null );

  _.assert( !!o );
  if( o )
  module.copy( o );

  if( module.willfilePath === null )
  module.willfilePath = _.select( module.willfilesArray, '*/filePath' );

  module._filePathChanged();
  module._nameChanged();

  if( will.verosity >= 5 )
  logger.log( module.nickName, 'init' );

  // /* */
  //
  // let accessors =
  // {
  //   get : function( module, k, proxy )
  //   {
  //     let result;
  //     if( module.openerModule && module.openerModule[ k ] !== undefined )
  //     result = module.openerModule[ k ];
  //     else if( module[ k ] !== undefined )
  //     result = module[ k ];
  //     else _.assert( 0, 'Module does not have field', k );
  //     if( k !== 'unwrappedOpenedModule' && result === module )
  //     return proxy;
  //     return result;
  //   },
  //   set : function( module, k, val, proxy )
  //   {
  //     if( module.openerModule && module.openerModule[ k ] !== undefined )
  //     module.openerModule[ k ] = val;
  //     else if( module[ k ] !== undefined )
  //     module[ k ] = val;
  //     else _.assert( 0, 'Module does not have field', k );
  //     return true;
  //   },
  // };
  //
  // let proxy = new Proxy( module, accessors );
  //
  // module.openedModule = proxy;
  // module.unwrappedOpenedModule = module;
  //
  // _.assert( module.openedModule === proxy );
  // _.assert( module.unwrappedOpenedModule === module );
  // _.assert( !!module.openerModule );
  // _.assert( proxy.openedModule === proxy );
  // _.assert( proxy.unwrappedOpenedModule === module );
  // _.assert( !!proxy.openerModule );
  //
  // return module;

}

//

function optionsForOpener()
{
  let module = this;

  _.assert( arguments.length === 0 );

  let Import =
  {

    will : null,
    willfilesArray : null,

    willfilesPath : null,
    localPath : null,
    remotePath : null,
    inPath : null,
    outPath : null,

    isRemote : null,
    isDownloaded : null,
    isUpToDate : null,

  }

  let result = _.mapOnly( module, Import );

  result.willfilesArray = _.entityShallowClone( result.willfilesArray );

  return result;
}

//

function openerMake()
{
  let module = this;
  let will = module.will;

  let o2 = module.optionsForOpener();
  o2.finding = 0;
  let opener = new will.OpenerModule( o2 );
  opener.moduleFind();

  return opener;
}

//

function releasedBy( user )
{
  let module = this;

  _.arrayRemoveOnceStrictly( module.userArray, user );

  if( !module.userArray.length )
  {
    module.finit();
    return true;
  }

  return false;
}

//

function usedBy( user )
{
  let module = this;

  _.arrayAppendOnceStrictly( module.userArray, user );

  return module;
}

//

function isUsedBy( user )
{
  let module = this;
  return _.arrayHas( module.userArray, user );
}

//

function precopy( o )
{
  let module = this;

  if( o.will )
  module.will = o.will;

  if( o.supermodules )
  module.supermodules = o.supermodules;

  if( o.original )
  module.original = o.original;

  if( !module.rootModule && !o.rootModule )
  o.rootModule = module;

  if( o.rootModule )
  module.rootModule = o.rootModule;

  // // debugger;
  // if( o.inPath !== undefined )
  // module.inPath = o.inPath;
  // if( o.outPath !== undefined )
  // module.outPath = o.outPath;
  // // debugger;

  return o;
}

//

function copy( o )
{
  let module = this;

  module.precopy( o );

  let result = _.Copyable.prototype.copy.apply( module, arguments );

  let names =
  {
    willfilesPath : null,
    inPath : null,
    outPath : null,
    localPath : null,
    remotePath : null,
  }

  for( let n in names )
  {
    if( o[ n ] !== undefined )
    module[ n ] = o[ n ];
  }

  _.assert( result.currentRemotePath === module.currentRemotePath );

  // debugger;

  return result;
}

//

function clone()
{
  let module = this;

  _.assert( arguments.length === 0 );

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

  let result = _.Copyable.prototype.cloneExtending.call( module, o );

  return result;
}

//

function unform()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );

  module.close();
  will.modulePathUnregister( module );

  _.assert( module.willfilesArray.length === 0 );
  _.assert( Object.keys( module.willfileWithRoleMap ).length === 0 );

  if( module.stager.stageStatePerformed( 'preformed' ) )
  {
    will.moduleIdUnregister( module );
  }

  _.assert( !_.arrayHas( _.mapVals( will.moduleWithIdMap ), module ) );
  _.assert( !_.arrayHas( _.mapVals( will.moduleWithPathMap ), module ) );
  _.assert( will.moduleWithIdMap[ module.id ] !== module );
  _.assert( !_.arrayHas( will.modulesArray, module ) );

  for( let i in module.pathResourceMap )
  module.pathResourceMap[ i ].finit();

  _.assert( Object.keys( module.exportedMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.pathResourceMap ).length === 0 );
  _.assert( Object.keys( module.pathMap ).length === 0 );
  _.assert( Object.keys( module.submoduleMap ).length === 0 );

  return module;
}

//

function preform()
{
  let module = this;
  let will = module.will;
  let con = new _.Consequence().take( null );

  _.assert( arguments.length === 0 );
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

  _.assert( arguments.length === 0 );
  _.assert( !!module.will );
  _.assert( _.strsAreAll( module.willfilesPath ) || _.strIs( module.dirPath ), 'Expects willfilesPath or dirPath' );

  if( module.pathResourceMap.in.path === null )
  module.pathResourceMap.in.path = '.';
  if( module.pathResourceMap.out.path === null )
  module.pathResourceMap.out.path = '.';

  // /* */
  //
  // module._filePathChanged();

  /* */

  will.moduleIdRegister( module );

  /* */

  _.assert( arguments.length === 0 );
  _.assert( !!module.will );
  _.assert( will.moduleWithIdMap[ module.id ] === module );
  _.assert( module.dirPath === null || _.strDefined( module.dirPath ) );
  _.assert( !!module.willfilesPath || !!module.dirPath );
  _.assert( module.rootModule instanceof will.OpenedModule );

  /* */

  return module;
}

//

function predefinedForm()
{
  let module = this;
  let will = module.will;
  let Predefined = will.Predefined;

  _.assert( arguments.length === 0 );
  _.assert( module.predefinedFormed === 0 );
  module.predefinedFormed = 1;

  /* */

  path
  ({
    name : 'in',
    path : '.',
    writable : 1,
    exportable : 1,
    importable : 1,
    criterion :
    {
      predefined : 0,
    },
  })

  path
  ({
    name : 'out',
    path : '.',
    writable : 1,
    exportable : 1,
    importable : 1,
    criterion :
    {
      predefined : 0,
    },
  })

  path
  ({
    name : 'module.willfiles',
    path : null,
    writable : 0,
    exportable : 1,
    importable : 0,
  })

  path
  ({
    name : 'module.original.willfiles',
    path : null,
    writable : 0,
    exportable : 1,
    importable : 1,
  })

  path
  ({
    name : 'module.dir',
    path : null,
    writable : 0,
    exportable : 0,
    importable : 0,
  })

  path
  ({
    name : 'module.common',
    path : null,
    writable : 0,
    exportable : 1,
    importable : 0,
  });

  path
  ({
    name : 'local',
    path : null,
    writable : 1,
    exportable : 1,
    importable : 1,
  })

  path
  ({
    name : 'remote',
    path : null,
    writable : 1,
    exportable : 1,
    importable : 1,
  })

  path
  ({
    name : 'current.remote',
    path : null,
    writable : 0,
    exportable : 0,
    importable : 0,
  })

  path
  ({
    name : 'will',
    path : _.path.join( __dirname, '../Exec' ),
    writable : 0,
    exportable : 0,
    importable : 0,
  })

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

  _.assert( !module.pathResourceMap['module.common'].importable );

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

  /* - */

  function path( o )
  {

    // if( module.pathResourceMap[ o.name ] )
    // return module.pathResourceMap[ o.name ].form1();

    let defaults =
    {
      module : module,
      writable : 0,
      exportable : 0,
      importable : 1,
      criterion :
      {
        predefined : 1,
      }
    }

    o.criterion = o.criterion || Object.create( null );

    _.mapSupplement( o, defaults );
    _.mapSupplement( o.criterion, defaults.criterion );

    _.assert( o.criterion !== defaults.criterion );
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
      result = new will.PathResource( o );
    }

    result.form1();

    _.assert( !!result.writable === !!o.writable );

    return result;
  }

  /* */

  function step( o )
  {
    if( module.stepMap[ o.name ] )
    return module.stepMap[ o.name ].form1();

    let defaults =
    {
      module : module,
      writable : 0,
      exportable : 0,
      importable : 0,
      criterion :
      {
        predefined : 1,
      }
    }

    o.criterion = o.criterion || Object.create( null );

    _.mapSupplement( o, defaults );
    _.mapSupplement( o.criterion, defaults.criterion );

    _.assert( o.criterion !== defaults.criterion );
    _.assert( arguments.length === 1 );

    let result = new will.Step( o ).form1();
    result.writable = 0;
    return result;
  }

  /* */

  function reflector( o )
  {
    if( module.reflectorMap[ o.name ] )
    return module.reflectorMap[ o.name ].form1();

    let defaults =
    {
      module : module,
      writable : 0,
      exportable : 0,
      importable : 0,
      criterion :
      {
        predefined : 1,
      }
    }

    o.criterion = o.criterion || Object.create( null );

    _.mapSupplement( o, defaults );
    _.mapSupplement( o.criterion, defaults.criterion );

    _.assert( o.criterion !== defaults.criterion );
    _.assert( arguments.length === 1 );

    let result = will.Reflector.MakeForEachCriterion( o );
    return result;
  }

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
  o.currentPath = module.pathResolve({ selector : o.currentPath, prefixlessAction : 'resolved', currentContext : o.currentContext });
  _.sure( o.currentPath === null || _.strIs( o.currentPath ) || _.strsAreAll( o.currentPath ), 'Current path should be string if defined' );

  /* */

  let ready = new _.Consequence().take( null );

  _.shell
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

  // _.assert( arguments.length === 0 );
  // _.assert( !!module.submoduleAssociation );
  // _.assert( !!module.submoduleAssociation.autoExporting );
  // _.assert( !module.pickedWillfileData );
  // _.assert( !module.pickedWillfilesPath );
  //
  // let autoWillfileData =
  // {
  //   'about' :
  //   {
  //     'name' : 'Extend',
  //     'version' : '0.1.0'
  //   },
  //   'path' :
  //   {
  //     'in' : '..',
  //     'out' : '.module',
  //     'remote' : 'git+https :///github.com/Wandalen/wProto.git',
  //     'local' : '.module/Extend',
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

// --
// opener
// --

function isOpened()
{
  let module = this;
  debugger;
  _.assert( 0, 'not tested' );
  return module.willfilesArray.length > 0 && module.stager.stageStateEnded( 'opened' );
}

//

function isValid()
{
  let module = this;
  return module.stager.isValid();
}

//

function close()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  /* */

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

  for( let i in module.submoduleMap )
  module.submoduleMap[ i ].finit();

  _.assert( Object.keys( module.exportedMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.submoduleMap ).length === 0 );

  for( let i = module.willfilesArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = module.willfilesArray[ i ];
    // _.assert( Object.keys( willf.submoduleMap ).length === 0 );
    // _.assert( Object.keys( willf.reflectorMap ).length === 0 );
    // _.assert( Object.keys( willf.stepMap ).length === 0 );
    // _.assert( Object.keys( willf.buildMap ).length === 0 );
    _.assert( willf.openedModule === module );
    module.willfileUnregister( willf );
    willf.openedModule = null;
    if( willf.openerModule === null )
    willf.finit();
    _.assert( willf.openedModule === null );
  }

  _.assert( module.willfilesArray.length === 0 );
  _.assert( Object.keys( module.willfileWithRoleMap ).length === 0 );

  module.stager.stageCancel( 'picked' );
  module.stager.stageCancel( 'opened' );
  module.stager.stageCancel( 'submodulesFormed' );
  module.stager.stageCancel( 'resourcesFormed' );
  module.stager.stageCancel( 'formed' );

}

//

function _formEnd()
{
  let module = this;
  return null;
}

//

function _willfilesPicked()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( module.willfilesArray.length > 0 );

  // debugger;
  let result = module.modulesAttachedOpen();
  // debugger;

  return result;
}

//

function willfilesOpen()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

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
  let time = _.timeNow();

  _.assert( arguments.length === 0 );
  _.sure( !!_.mapKeys( module.willfileWithRoleMap ).length && !!module.willfilesArray.length, () => 'Found no will file at ' + _.strQuote( module.dirPath ) );

  /* */

  for( let i = module.willfilesArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = module.willfilesArray[ i ];
    _.assert( willf.openedModule === null || willf.openedModule === module );
    willf.openedModule = module;
    _.assert( willf.openedModule === module );
  }

  /* */

  for( let i = 0 ; i < module.willfilesArray.length ; i++ )
  {
    let willfile = module.willfilesArray[ i ];

    _.assert( willfile.formed === 1 || willfile.formed === 2 || willfile.formed === 3, 'not expected' );

    if( willfile.formed === 3 )
    continue;

    con.then( ( arg ) => willfile.open() );
  }

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

function _willfilesReadBegin()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  will._moduleWillfilesReadBegin();
  // module.willfilesReadBeginTime = _.timeNow();

  return null;
}

//

function _willfilesReadEnd()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  will._moduleWillfilesReadEnd( module );

  // if( will.verbosity >= 2 )
  // if( module === module.rootModule && !module.original )
  // {
  //   if( !module.willfilesReadTimeReported )
  //   logger.log( ' . Read', module.willfilesResolve().length, 'willfile(s) in', _.timeSpent( module.willfilesReadBeginTime ), '\n' );
  //   module.willfilesReadTimeReported = 1;
  // }

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

  _.arrayRemoveElementOnceStrictly( module.willfilesArray, willf );

  if( willf.role )
  {
    _.assert( module.willfileWithRoleMap[ willf.role ] === willf )
    delete module.willfileWithRoleMap[ willf.role ];
  }

  _.assert( willf.openedModule === module || willf.openedModule === null );
  // willf.openedModule = null;
}

//

function willfileRegister( willf )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.arrayAppendOnceStrictly( module.willfilesArray, willf );

  if( willf.role )
  {
    _.assert( !module.willfileWithRoleMap[ willf.role ], 'Module already has willfile with role', willf.role )
    module.willfileWithRoleMap[ willf.role ] = willf;
  }

  _.assert( willf.openedModule === null || willf.openedModule === module );
  willf.openedModule = module;
}

//

function _willfilesExport()
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  module.willfileEach( handeWillFile );

  return result;

  function handeWillFile( willfile )
  {
    _.assert( _.objectIs( willfile.data ) );
    result[ willfile.filePath ] = willfile.data;
  }

}

//

function willfileEach( onEach )
{
  let module = this;
  let will = module.will;

  for( let w = 0 ; w < module.willfilesArray.length ; w++ )
  {
    let willfile = module.willfilesArray[ w ];
    onEach( willfile )
  }

  for( let s in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ s ];
    if( !submodule.opener )
    continue;

    for( let w = 0 ; w < submodule.opener.willfilesArray.length ; w++ )
    {
      let willfile = submodule.opener.willfilesArray[ w ];
      onEach( willfile )
    }

  }

}

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
  _.assert( src === null || src instanceof _.Will.OpenedModule );
  module[ rootModuleSymbol ] = src;
  return src;
}

//

function willfileArraySet( willfilesArray )
{
  let module = this;
  _.assert( _.arrayIs( willfilesArray ) );

  if( module.willfilesArray === willfilesArray )
  return module.willfilesArray;

  for( let w = module.willfilesArray.length-1 ; w >= 0 ; w-- )
  {
    // debugger;
    let willf = module.willfilesArray[ w ];
    module.willfileUnregister( willf );
  }

  for( let w = 0 ; w < willfilesArray.length ; w++ )
  {
    // debugger;
    let willf = willfilesArray[ w ];
    module.willfileRegister( willf );
  }

  return module.willfilesArray;
}

//

function submodulesAllAreDownloaded()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( module === module.rootModule );

  for( let n in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ n ].opener;
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
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( module === module.rootModule );

  for( let n in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ n ].opener;
    if( !submodule )
    continue;
    if( !submodule.isValid() )
    return false;
  }

  return true;
}

//

function submodulesClean()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 0 );

  let result = module.clean
  ({
    cleaningSubmodules : 1,
    cleaningOut : 0,
    cleaningTemp : 0,
  });

  return result;
}

//

function _submodulesDownload_pre( routine, args )
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

  return o;
}

function _submodulesDownload_body( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let downloadedNumber = 0;
  let remoteNumber = 0;
  let totalNumber = _.mapKeys( module.submoduleMap ).length;
  let time = _.timeNow();
  let con = new _.Consequence().take( null );

  o.downloaded = o.downloaded || Object.create( null );

  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( _submodulesDownload_body, arguments );

  logger.up();

  downloadAgain();

  con.finally( ( err, arg ) =>
  {
    logger.down();
    if( err )
    throw _.err( 'Failed to', ( o.updating ? 'update' : 'download' ), 'submodules of', module.decoratedNickName, '\n', err );
    logger.rbegin({ verbosity : -2 });
    if( o.dry )
    logger.log( ' + ' + downloadedNumber + '/' + totalNumber + ' submodule(s) of ' + module.decoratedNickName + ' will be ' + ( o.updating ? 'updated' : 'downloaded' ) );
    else
    logger.log( ' + ' + downloadedNumber + '/' + totalNumber + ' submodule(s) of ' + module.decoratedNickName + ' were ' + ( o.updating ? 'updated' : 'downloaded' ) + ' in ' + _.timeSpent( time ) );
    logger.rend({ verbosity : -2 });
    return arg;
  });

  return con;

  /* */

  function downloadAgain()
  {
    let remoteNumberWas;

    remoteNumberWas = remoteNumber;

    for( let n in module.submoduleMap )
    {
      let submodule = module.submoduleMap[ n ].opener;

      // debugger;
      // _.assert( !!submodule && submodule.stager.stageStatePerformed( 'preformed' ), 'Submodule', ( submodule ? submodule.nickName : n ), 'was not preformed' );
      _.assert( !!submodule && submodule.preformed, 'Submodule', ( submodule ? submodule.nickName : n ), 'was not preformed' );

      if( !submodule.isRemote )
      continue;

      con.then( () =>
      {

        if( o.downloaded[ submodule.remotePath ] )
        return null;

        remoteNumber += 1;

        let o2 = _.mapExtend( null, o );
        delete o2.downloaded;
        let r = _.Consequence.From( submodule._remoteDownload( o2 ) );
        return r.then( ( arg ) =>
        {
          _.assert( _.boolIs( arg ) );
          _.assert( _.strIs( submodule.remotePath ) );
          o.downloaded[ submodule.remotePath ] = submodule;

          if( arg )
          downloadedNumber += 1;

          return arg;
        });

      });

    }

  }

  /* */

  function downloadRecursive()
  {
    let remoteNumberWas;

    remoteNumberWas = remoteNumber;

    for( let n in module.submoduleMap )
    {
      let submodule = module.submoduleMap[ n ];

      if( !submodule.opener )
      {
        debugger;
        submodule.form();
      }

    }

  }

}

_submodulesDownload_body.defaults =
{
  updating : 0,
  forming : 1,
  recursive : 1,
  dry : 0,
  downloaded : null,
}

let _submodulesDownload = _.routineFromPreAndBody( _submodulesDownload_pre, _submodulesDownload_body );

//

let submodulesDownload = _.routineFromPreAndBody( _submodulesDownload_pre, _submodulesDownload_body, 'submodulesDownload' );
submodulesDownload.defaults.updating = 0;

//

let submodulesUpdate = _.routineFromPreAndBody( _submodulesDownload_pre, _submodulesDownload_body, 'submodulesUpdate' );
submodulesUpdate.defaults.updating = 1;

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
  _.assert( o.module  === null || o.module instanceof will.OpenedModule );
  _.assert( o.submodule === null || o.submodule instanceof will.Submodule );
  _.assert( o.module  === null || o.module.rootModule === o.module || _.arrayHas( o.module.supermodules, module ) );

  if( o.module )
  superModuleFixate( o.module );

  if( o.module )
  o.module.supermodules.forEach( ( supermodule ) =>
  {
  });

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
        superModule.remotePath = fixatedPath;
        _.assert( superModule.remotePath === fixatedPath );
        _.assert( remote.path === fixatedPath );
      }

    }

  }

  /* */

  function submoduleFixate( submodule )
  {

    if( submodule.opener && !submodule.opener.isRemote )
    return;

    let originalPath = submodule.path;
    let fixatedPath = resolve( originalPath )

    let o2 = _.mapExtend( null, o );
    o2.replacer = [ submodule.name, 'path' ];
    o2.originalPath = originalPath;
    o2.fixatedPath = fixatedPath;
    o2.willfilePath = submodule.willf.filePath;
    o2.report = report;

    module.moduleFixateAct( o2 );

    if( !o.dry && fixatedPath )
    {
      submodule.path = fixatedPath;
      if( submodule.opener )
      submodule.opener.remotePath = fixatedPath;
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
  _.assert( o.module  === null || o.module instanceof will.OpenedModule );
  _.assert( o.submodule === null || o.submodule instanceof will.Submodule );
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
        throw _.err( 'Willfile', willfilePath, 'does not have path', o.remotePath );
      }

      if( !_.strHas( code, o.replacer ) )
      {
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
      err = _.err( 'Failed to fixated ' + _.color.strFormat( willfilePath, 'path' ) + '\n', err );
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
      if( will.verbosity >= 4 )
      _.errLogOnce( _.errBriefly( err ) );
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

  let vcs = will.vcsFor( o.originalPath );

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
    return module._submodulesForm();
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

  _.assert( arguments.length === 0 );

  module.stager.stageStatePausing( 'submodulesFormed', 0 );
  module.stager.tick();

  return module.stager.stageConsequence( 'submodulesFormed' );
}

//

function _submodulesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.preformed );

  let con = _.Consequence().take( null );

  module._resourcesAllForm( will.Submodule, con );

  con.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  return con.split();
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

  let remoteProvider = fileProvider.providerForPath( module.commonPath );
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

function remoteIsDownloadedChanged()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.pathResourceMap[ 'current.remote' ] );

  /* */

  if( module.isDownloaded &&  module.remotePath )
  {

    let remoteProvider = fileProvider.providerForPath( module.remotePath );
    _.assert( !!remoteProvider.isVcs );

    let version = remoteProvider.versionLocalRetrive( module.localPath );
    if( version )
    {
      let remotePath = _.uri.parseConsecutive( module.remotePath );
      remotePath.hash = version;
      module.pathResourceMap[ 'current.remote' ].path = _.uri.str( remotePath );
    }
  }
  else
  {
    module.pathResourceMap[ 'current.remote' ].path = null;
  }

}

//

function remoteIsDownloadedSet( src )
{
  let module = this;

  // if( module.will )
  // if( module.nickName === "module::wTools" )
  // debugger;

  src = !!src;

  let changed = module[ isDownloadedSymbol ] !== undefined && module[ isDownloadedSymbol ] !== src;

  module[ isDownloadedSymbol ] = src;

  if( changed )
  module.remoteIsDownloadedChanged();

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
// resource
// --

function resourcesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

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

  // logger.log( module.absoluteName, '_resourcesForm' ); debugger;

  if( module.rootModule === module )
  if( module.submodulesAllAreDownloaded() && module.submodulesAllAreValid() )
  {

    con.then( () => module._resourcesFormAct() );

    con.then( ( arg ) =>
    {
      // if( !module.supermodule )
      // module._willfilesCacheSave();
      return arg;
    });

  }
  else
  {
    if( will.verbosity === 2 )
    logger.error( ' ! One or more submodules of ' + module.decoratedNickName + ' were not downloaded!'  );
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

  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.preformed );

  let con = _.Consequence().take( null );

  /* */

  module._resourcesAllForm( will.Submodule, con );
  module._resourcesAllForm( will.Exported, con );
  module._resourcesAllForm( will.PathResource, con );
  module._resourcesAllForm( will.Reflector, con );
  module._resourcesAllForm( will.Step, con );
  module._resourcesAllForm( will.Build, con );

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
  let result = will[ will.ResourceKindToClassName.forKey( resourceKind ) ];

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

  _.assert( module.rootModule instanceof will.OpenedModule );

  if( resourceKind === 'export' )
  result = module.buildMap;
  else if( resourceKind === 'about' )
  result = module.about.dataExport();
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
  let result = _.path.globFilterKeys( resources, resourceSelector );
  return result;
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

  // let resource = module.resolve
  // ({
  //   selector : resourceKind + '::' + resourceName,
  //   pathResolving : 0,
  //   pathUnwrapping : 0,
  //   missingAction : 'undefine',
  // });

  if( !resource )
  resource = module.resourceAllocate( resourceKind, resourceName );

  _.assert( resource instanceof will.Resource );
  if( resource instanceof will.PathResource )
  _.assert( module.pathResourceMap[ resource.name ] === resource );

  return resource;
}

//

function resourceAllocate( resourceKind, resourceName )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( resourceName ) );

  let resourceName2 = module.resourceNameAllocate( resourceKind, resourceName );
  let cls = module.resourceClassForKind( resourceKind );
  let resource = new cls({ module : module, name : resourceName2 }).form1();

  return resource;
}

//

function resourceNameAllocate( resourceKind, resourceName )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( resourceKind ) );
  _.assert( _.strIs( resourceName ) );

  let map = module.resourceMapForKind( resourceKind );

  if( map[ resourceName ] === undefined )
  return resourceName;

  let counter = 1;
  let resourceName2;

  let ends = /\.\d+$/;
  if( ends.test( resourceName ) )
  resourceName = resourceName.replace( ends, '' );

  do
  {
    resourceName2 = resourceName + '.' + counter;
    counter += 1;
  }
  while( map[ resourceName2 ] !== undefined );

  return resourceName2;
}

// --
// path
// --

function pathsRelative( basePath, filePath )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( _.mapIs( filePath ) )
  {
    for( let f in filePath )
    filePath[ f ] = module.pathsRelative( basePath, filePath[ f ] );
    return filePath;
  }

  _.assert( path.isAbsolute( basePath ) );

  if( !filePath )
  return filePath;

  if( !path.s.anyAreAbsolute( filePath ) )
  return filePath;

  filePath = path.filter( filePath, ( filePath ) =>
  {
    if( filePath )
    if( path.isAbsolute( filePath ) )
    return path.s.relative( basePath, filePath );
    return filePath;
  });

  return filePath;
}

//

function pathsRebase( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let Resolver = will.Resolver;

  o = _.routineOptions( pathsRebase, arguments );
  _.assert( path.isAbsolute( o.inPath ) );

  let inPathResource = module.resourceObtain( 'path', 'in' );
  if( inPathResource.path === null )
  inPathResource.path = '.';

  let inPath = path.normalizeCanonical( o.inPath );
  let exInPath = module.inPath;
  let relative = path.relative( inPath, exInPath );

  if( inPath === exInPath )
  {
    debugger;
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

    resource.pathsRebase
    ({
      relative : relative,
      exInPath : exInPath,
      inPath : inPath,
    });

  }

  module.inPath = inPath;

  _.assert( module.pathResourceMap[ inPathResource.name ] === inPathResource );
  _.assert( module.inPath === inPath );
  _.assert( path.isRelative( module.pathResourceMap.in.path ) );

  /* submodule */

  for( let p in module.submoduleMap )
  {
    let resource = module.submoduleMap[ p ];

    resource.pathsRebase
    ({
      relative : relative,
      exInPath : exInPath,
      inPath : inPath,
    });

  }

  /* reflector */

  for( let r in module.reflectorMap )
  {
    let resource = module.reflectorMap[ r ];

    resource.pathsRebase
    ({
      relative : relative,
      exInPath : exInPath,
      inPath : inPath,
    });

  }

}

pathsRebase.defaults =
{
  inPath : null,
}

//

function _filePathChange( willfilesPath )
{

  if( !this.will )
  return willfilesPath;

  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( module.willfilesPath )
  will.modulePathUnregister( module );

  if( willfilesPath )
  willfilesPath = path.s.normalizeTolerant( willfilesPath );

  let dirPath = willfilesPath;
  if( _.arrayIs( dirPath ) )
  dirPath = dirPath[ 0 ];
  if( _.strIs( dirPath ) )
  dirPath = path.dir( dirPath );
  if( dirPath === null )
  dirPath = module.dirPath;
  if( dirPath )
  dirPath = path.normalizeTolerant( dirPath );

  let commonPath = willfilesPath ? module.CommonPathFor( willfilesPath ) : null;

  _.assert( arguments.length === 1 );
  _.assert( dirPath === null || _.strDefined( dirPath ) );
  _.assert( dirPath === null || path.isAbsolute( dirPath ) );
  _.assert( dirPath === null || path.isNormalized( dirPath ) );
  _.assert( willfilesPath === null || path.s.allAreAbsolute( willfilesPath ) );

  module[ willfilesPathSymbol ] = willfilesPath;
  module[ configNameSymbol ] = commonPath ? path.fullName( commonPath ) : null;
  module._dirPathAssign( dirPath );
  module._commonPathAssign( commonPath );

  _.assert( module.commonPath === commonPath );

  if( module.willfilesPath )
  will.modulePathRegister( module );

  return willfilesPath;
}

//

function _filePathChanged()
{
  let module = this;

  _.assert( arguments.length === 0 );

  module._filePathChange( module.willfilesPath );

}

//

function inPathGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = path.s.join( module.dirPath, ( module.pathMap.in || '.' ) );

  if( result && _.strHas( result, '//' ) )
  debugger;

  return result;
}

//

function outPathGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return path.s.join( module.dirPath, ( module.pathMap.in || '.' ), ( module.pathMap.out || '.' ) );
}

//

function outfilePathGet()
{
  let module = this;
  let will = module.will;
  _.assert( arguments.length === 0 );
  return module.OutfilePathFor( module.outPath, module.about.name );
}

//

function cloneDirPathGet()
{
  let module = this;
  let will = module.will;
  let inPath = module.rootModule.inPath;
  _.assert( arguments.length === 0 );
  return module.CloneDirPathFor( inPath );
}

//

function predefinedPathGet_functor( fieldName, resourceName )
{

  return function predefinedPathGet()
  {
    let module = this;

    if( !module.will)
    return null;

    return module.pathMap[ resourceName ] || null;
  }

}

//

function predefinedPathAssign_functor( fieldName, resourceName, relativizing, forwarding )
{

  if( forwarding === undefined )
  forwarding = true;

  forwarding = !!forwarding;

  return function predefinedPathAssign( filePath )
  {
    let module = this;

    if( !module.will && !filePath )
    return filePath;

    filePath = _.entityShallowClone( filePath );

    if( !module.pathResourceMap[ resourceName ] )
    {
      let resource = new _.Will.PathResource({ module : module, name : resourceName }).form1();
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

      // if( _.path.s.anyAreAbsolute( filePath ) )
      // {
      //   let will = module.will;
      //   let fileProvider = will.fileProvider;
      //   let path = fileProvider.path;
      //   _.assert( path.isAbsolute( basePath ) );
      //   filePath = path.filterInplace( filePath, ( filePath ) =>
      //   {
      //     if( filePath )
      //     if( path.isAbsolute( filePath ) )
      //     return path.s.relative( basePath, filePath );
      //     debugger;
      //     return filePath;
      //   });
      // }

    }

    if( fieldName === 'willfilesPath' )
    filePath = module._filePathChange( filePath );
    module.pathResourceMap[ resourceName ].path = filePath;

    // if( forwarding )
    // module._filePathChanged();

    return filePath;
  }

}

//

function predefinedPathSet_functor( fieldName, resourceName )
{

  let assignMethodName = '_' + fieldName + 'Assign';
  _.assert( arguments.length === 2 );

  return function predefinedPathSet( filePath )
  {
    let module = this;

    module[ assignMethodName ]( filePath );
    module._filePathChanged();

    return filePath;
  }

}

//

let willfilesPathGet = predefinedPathGet_functor( 'willfilesPath', 'module.willfiles' );
let dirPathGet = predefinedPathGet_functor( 'dirPath', 'module.dir' );
let commonPathGet = predefinedPathGet_functor( 'commonPath', 'module.common' );
let localPathGet = predefinedPathGet_functor( 'localPath', 'local' );
let remotePathGet = predefinedPathGet_functor( 'remotePath', 'remote' );
let currentRemotePathGet = predefinedPathGet_functor( 'currentRemotePath', 'current.remote' );
let willPathGet = predefinedPathGet_functor( 'willPath', 'will' );

let _inPathAssign = predefinedPathAssign_functor( 'inPath', 'in', 'dirPath', 0 );
let _outPathAssign = predefinedPathAssign_functor( 'outPath', 'out', 'inPath', 0 );
let _willfilesPathAssign = predefinedPathAssign_functor( 'willfilesPath', 'module.willfiles', 0, 0 );
let _dirPathAssign = predefinedPathAssign_functor( 'dirPath', 'module.dir', 0, 0 );
let _commonPathAssign = predefinedPathAssign_functor( 'commonPath', 'module.common', 0, 0 );
let _localPathAssign = predefinedPathAssign_functor( 'localPath', 'local', 0, 0 );
let _remotePathAssign = predefinedPathAssign_functor( 'remotePath', 'remote', 0, 0 );

let inPathSet = predefinedPathSet_functor( 'inPath', 'in' );
let outPathSet = predefinedPathSet_functor( 'outPath', 'out' );
let willfilesPathSet = predefinedPathSet_functor( 'willfilesPath', 'module.willfiles' );
let localPathSet = predefinedPathSet_functor( 'localPath', 'local' );
let remotePathSet = predefinedPathSet_functor( 'remotePath', 'remote' );

// --
// name
// --

function nameGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let name = null;

  if( !name && module.about )
  name = module.about.name;

  if( !name && module.configName )
  name = module.configName;

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
  let rootModule = module.rootModule;

  /* */

  module._nameUnregister();
  module._nameRegister();

}

//

function _nameUnregister()
{
  let module = this;
  let will = module.will;
  let rootModule = module.rootModule;

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

function _nameRegister()
{
  let module = this;
  let will = module.will;

  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let name = null;
  let rootModule = module.rootModule;
  let c = 0;

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
  // if( module.configName )
  // if( !rootModule.moduleWithNameMap[ module.configName ] )
  // {
  //   c += 1;
  //   rootModule.moduleWithNameMap[ module.configName ] = module;
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

  // if( module.userArray.length )
  // debugger;

  for( let u = 0 ; u < module.userArray.length ; u++ )
  {
    let opener = module.userArray[ u ];
    _.assert( opener instanceof will.OpenerModule );

    if( opener.aliasName )
    _.arrayAppendElementOnce( result, opener.aliasName )

    if( opener.configName )
    _.arrayAppendElementOnce( result, opener.configName )

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
    return rootModule.nickName + ' / ' + 'f::duplicate';
    else
    return rootModule.nickName + ' / ' + module.nickName;
  }
  else
  return module.nickName;
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
// clean
// --

function cleanWhat( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let exps = module.exportsResolve();
  let filePaths = [];
  let result = Object.create( null );
  result[ '/' ] = filePaths;

  o = _.routineOptions( cleanWhat, arguments );

  /* submodules */

  if( o.cleaningSubmodules )
  {

    let submodulesCloneDirPath = module.cloneDirPathGet();
    find( submodulesCloneDirPath );

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
    let temp;

    temp = module.reflectorResolve
    ({
      selector : 'reflector::temp',
      pathResolving : 'in',
      missingAction : 'undefine',
    });

    if( temp )
    {
      let o2 = temp.optionsForFindExport();
      find( o2 );
    }

    if( !temp )
    {
      temp = module.pathResolve
      ({
        selector : 'path::temp',
        pathResolving : 'in',
        missingAction : 'undefine',
      });

      if( !temp )
      temp = [];

      temp = _.arrayAs( path.s.join( module.inPath, temp ) );

      for( let p = 0 ; p < temp.length ; p++ )
      {
        let filePath = temp[ p ];
        find( filePath );
      }

    }

  }

  filePaths.sort();

  return result;

  /* - */

  function find( op )
  {

    if( _.arrayIs( op ) || _.strIs( op ) )
    op = { filter : { filePath : op } }

    if( _.arrayIs( op.filter.filePath.length ) && !op.filter.filePath.length )
    return;

    let def =
    {
      verbosity : 0,
      allowingMissed : 1,
      recursive : 2,
      includingDirs : 1,
      includingTerminals : 1,
      maskPreset : 0,
      outputFormat : 'absolute',
      writing : 0,
      deletingEmptyDirs : 1,
    }

    _.mapSupplement( op, def );

    let found = fileProvider.filesDelete( op );
    _.assert( op.filter.formed === 5 );

    let r = path.group
    ({
      keys : op.filter.filePath,
      vals : found,
      result : result,
    });

  }

}

cleanWhat.defaults =
{
  cleaningSubmodules : 1,
  cleaningOut : 1,
  cleaningTemp : 1,
}

//

function cleanWhatReport( o )
{
  let module = this;
  let will = module.will;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let time = _.timeNow();

  o = _.routineOptions( cleanWhatReport, arguments );

  if( !o.report )
  {
    let o2 = _.mapExtend( null, o );
    delete o2.report;
    delete o2.explanation;
    delete o2.spentTime;
    o.report = module.cleanWhat( o2 );
  }

  if( !o.spentTime )
  o.spentTime = _.timeNow() - time;

  let textualReport = path.groupTextualReport
  ({
    explanation : o.explanation,
    groupsMap : o.report,
    verbosity : logger.verbosity,
    spentTime : o.spentTime,
  });

  logger.log( textualReport );

  return textualReport;
}

cleanWhatReport.defaults = Object.create( cleanWhat.defaults );
cleanWhatReport.defaults.report = null;
cleanWhatReport.defaults.explanation = ' . Clean will delete ';
cleanWhatReport.defaults.spentTime = null

//

function clean( o )
{
  let module = this;
  let will = module.will;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let time = _.timeNow();

  o = _.routineOptions( clean, arguments );
  let report = module.cleanWhat( o );

  _.assert( _.arrayIs( report[ '/' ] ) );

  for( let f = report[ '/' ].length-1 ; f >= 0 ; f-- )
  {
    let filePath = report[ '/' ][ f ];
    _.assert( path.isAbsolute( filePath ) );
    let res = fileProvider.fileDelete({ filePath : filePath, verbosity : 1, throwing : 0 });
  }

  time = _.timeNow() - time;

  let o2 = _.mapExtend( null, o );
  o2.explanation = ' - Clean deleted ';
  o2.spentTime = time;
  o2.report = report;

  let textualReport = module.cleanWhatReport( o2 );

  return report;
}

clean.defaults = Object.create( cleanWhat.defaults );

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

  _.Will.Resolver.resolve.pre.call( _.Will.Resolver, routine, args );

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( _.arrayHas( [ null, 0, false, 'in', 'out' ], o.pathResolving ), 'Unknown value of option path resolving', o.pathResolving );
  _.assert( _.arrayHas( [ 'undefine', 'throw', 'error' ], o.missingAction ), 'Unknown value of option missing action', o.missingAction );
  _.assert( _.arrayHas( [ 'default', 'resolved', 'throw', 'error' ], o.prefixlessAction ), 'Unknown value of option prefixless action', o.prefixlessAction );
  _.assert( _.arrayIs( o.visited ) );
  _.assert( !o.defaultResourceKind || !_.path.isGlob( o.defaultResourceKind ), 'Expects non glob {-defaultResourceKind-}' );

  return o;
}

//

function resolve_body( o )
{
  let module = this;
  let will = module.will;
  _.assert( o.baseModule === module );
  let result = will.Resolver.resolve.body.call( will.Resolver, o );
  return result;
}

_.routineExtend( resolve_body, _.Will.Resolver.resolve );

let resolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

//

let resolveMaybe = _.routineFromPreAndBody( resolve_pre, resolve_body );

_.routineExtend( resolveMaybe, _.Will.Resolver.resolveMaybe );

//

let pathResolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

_.routineExtend( pathResolve, _.Will.Resolver.pathResolve );

//

let resolveRaw = _.routineFromPreAndBody( resolve_pre, resolve_body );

_.routineExtend( resolveRaw, _.Will.Resolver.resolveRaw );

//

let submodulesResolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

_.routineExtend( submodulesResolve, _.Will.Resolver.submodulesResolve );

_.assert( _.Will.Resolver.submodulesResolve.defaults.defaultResourceKind === 'submodule' );
_.assert( submodulesResolve.defaults.defaultResourceKind === 'submodule' );

//

function reflectorResolve_body( o )
{
  let module = this;
  let will = module.will;
  _.assert( o.baseModule === module );
  let result = will.Resolver.reflectorResolve.body.call( will.Resolver, o );
  return result;
}

_.routineExtend( reflectorResolve_body, _.Will.Resolver.reflectorResolve );

let reflectorResolve = _.routineFromPreAndBody( resolve_pre, reflectorResolve_body );

_.assert( reflectorResolve.defaults.defaultResourceKind === 'reflector' );

// --
// other resolver
// --

function _buildsSelect_pre( routine, args )
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
  _.assert( _.arrayHas( [ 'build', 'export' ], o.resource ) );
  _.assert( _.arrayHas( [ 'default', 'more' ], o.preffering ) );
  _.assert( o.criterion === null || _.routineIs( o.criterion ) || _.mapIs( o.criterion ) );

  if( o.preffering === 'default' )
  o.preffering = 'default';

  return o;
}

//

function _buildsSelect_body( o )
{
  let module = this;
  let elements = module.buildMap;

  _.assertRoutineOptions( _buildsSelect_body, arguments );
  _.assert( arguments.length === 1 );

  if( o.name )
  {
    elements = _.mapVals( _.path.globFilterKeys( elements, o.name ) );
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

  if( o.resource === 'export' )
  elements = elements.filter( ( element ) => element.criterion && element.criterion.export );
  else if( o.resource === 'build' )
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
        if( build.criterion === null && Object.keys( template ).length )
        return;

        let satisfied = _.mapSatisfy
        ({
          template : template,
          src : build.criterion,
          levels : 1,
        });

        if( satisfied )
        return build;
      }

    }

    elements = _.entityFilter( elements, filter );

    return elements;
  }

}

_buildsSelect_body.defaults =
{
  resource : null,
  name : null,
  criterion : null,
  preffering : 'default',
}

let _buildsResolve = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );

//

let buildsResolve = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );
var defaults = buildsResolve.defaults;
defaults.resource = 'build';

//

let exportsResolve = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );
var defaults = exportsResolve.defaults;
defaults.resource = 'export';

//

function willfilesResolve()
{
  let module = this;
  let will = module.will;
  _.assert( arguments.length === 0 );

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
// exporter
// --

function _infoExport( o )
{
  let module = this;
  let will = module.will;
  let result = '';

  o = _.assertRoutineOptions( _infoExport, arguments );

  if( o.verbosity >= 1 )
  result += module.decoratedAbsoluteName;

  if( o.verbosity >= 3 )
  result += module.about.infoExport();

  if( o.verbosity >= 2 )
  {
    let fields = Object.create( null );
    fields.commonPath = module.commonPath;
    fields.willfilesPath = module.willfilesPath;
    fields.remotePath = module.remotePath;
    fields.localPath = module.localPath;

    fields = module.pathsRelative( module.dirPath, fields );

    result += '\n' + _.toStrNice( fields );
    // result += '\n' + _.toStrNice( fields ) + '\n';
  }

  if( o.verbosity >= 4 )
  {
    result += '\n';
    result += module.infoExportPaths( module.dirPath, module.pathMap );
    result += module.infoExportResource( module.submoduleMap );
    result += module.infoExportResource( module.reflectorMap );
    result += module.infoExportResource( module.stepMap );
    result += module.infoExportResource( module.buildsResolve({ preffering : 'more' }) );
    result += module.infoExportResource( module.exportsResolve({ preffering : 'more' }) );
    result += module.infoExportResource( module.exportedMap );
  }

  return result;
}

_infoExport.defaults =
{
  verbosity : 9,
}

//

function infoExport( o )
{
  let module = this;
  let will = module.will;
  o = _.routineOptions( _infoExport, arguments );
  return module._infoExport( o );
}

_.routineExtend( infoExport, _infoExport );

//

function infoExportPaths( paths )
{
  let module = this;
  paths = paths || module.pathMap;
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !Object.keys( paths ).length )
  return '';

  let result = _.color.strFormat( 'Paths', 'highlighted' );

  paths = module.pathsRelative( module.dirPath, paths )

  result += '\n' + _.toStrNice( paths ) + '';

  result += '\n\n';

  return result;
}

//

function infoExportResource( collection )
{
  let module = this;
  let will = module.will;
  let result = '';
  let modules = [];

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( collection ) || _.arrayIs( collection ) );

  _.each( collection, ( resource, r ) =>
  {
    if( resource && resource instanceof will.OpenedModule )
    {
      if( _.arrayHas( modules, resource ) )
      return;
      modules.push( resource );
      result += resource.infoExport({ verbosity : 2 });
      result += '\n\n';
    }
    else if( _.instanceIs( resource ) )
    {
      result += resource.infoExport();
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

  let sorted = will.modulesTopologicalSort();
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

function dataExport( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  o.dst = o.dst || Object.create( null );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = _.routineOptions( dataExport, arguments );

  o.module = module;

  if( !o.rootModule )
  o.rootModule = module;

  let o2 = _.mapExtend( null, o );
  delete o2.dst;

  o.dst.about = module.about.dataExport();

  o.dst.path = module.dataExportResources( module.pathResourceMap, o2 );
  o.dst.submodule = module.dataExportResources( module.submoduleMap, o2 );
  o.dst.reflector = module.dataExportResources( module.reflectorMap, o2 );
  o.dst.step = module.dataExportResources( module.stepMap, o2 );
  o.dst.build = module.dataExportResources( module.buildMap, o2 );
  o.dst.exported = module.dataExportResources( module.exportedMap, o2 );

  if( o.rootModule === module )
  {
    o.dst.module = module.dataExportModules( will.moduleWithPathMap, o2 );
  }

  return o.dst;
}

dataExport.defaults =
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
  rootModule : null,
}

//

function dataExportForModuleExport( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routineOptions( dataExportForModuleExport, arguments );
  _.assert( module.original === null );

  let o2 = module.optionsForOpener();
  o2.willfilesPath = o.willfilesPath;
  o2.willfilesArray = [];
  o2.inPath = path.relative( module.outPath, module.inPath );
  let opener2 = new will.OpenerModule( o2 );

  _.assert( opener2.supermodule === null );
  _.assert( opener2.rootModule === null );
  _.assert( opener2.openedModule === null );
  _.assert( opener2.willfilesArray.length === 0 );

  opener2.rootModule = module;
  opener2.original = module;

  // debugger;
  let module2 = opener2.moduleClone( module );
  // debugger;

  module2.pathsRebase({ inPath : module.outPath });

  _.assert( module2.dirPath === path.trail( module.outPath ) );
  _.assert( module2.original === module );
  _.assert( module2.rootModule === module );
  _.assert( module2.willfilesArray.length === 0 );
  _.assert( module2.pathResourceMap.in.path === '.' );

  _.assert( opener2.dirPath === path.trail( module.outPath ) );
  _.assert( opener2.original === module );
  _.assert( opener2.supermodule === null );
  _.assert( opener2.rootModule === module );
  _.assert( opener2.willfilesArray.length === 0 );

  module2.stager.stageStateSkipping( 'picked', 1 );
  module2.stager.stageStateSkipping( 'opened', 1 );
  module2.stager.stageStatePausing( 'picked', 0 );
  module2.stager.tick();

  _.assert( !!module2.ready.resourcesCount() );

  if( module2.ready.errorsCount() )
  module2.ready.sync();

  let data = Object.create( null );
  data.format = will.Willfile.FormatVersion;
  module2.dataExport({ dst : data });

  _.assert( !data.path || !!data.path[ 'module.willfiles' ] );
  _.assert( !data.path || !data.path[ 'module.dir' ] );
  _.assert( !data.path || data.path[ 'remote' ] !== undefined );
  _.assert( !data.path || !data.path[ 'current.remote' ] );
  _.assert( !data.path || !data.path[ 'will' ] );

  module2.finit();

  return data;
}

dataExportForModuleExport.defaults =
{
  willfilesPath : null,
}

//

function dataExportResources( resources, options )
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  _.assert( arguments.length === 2 );
  _.assert( _.mapIs( resources ) || _.arrayIs( resources ) );

  _.each( resources, ( resource, r ) =>
  {
    result[ r ] = resource.dataExport( options );
    if( result[ r ] === undefined )
    delete result[ r ];
  });

  return result;
}

//

function dataExportModules( modules, options )
{
  let module = this;
  let rootModule = options.rootModule;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  _.assert( arguments.length === 2 );
  _.assert( _.mapIs( modules ) );
  _.assert( rootModule instanceof will.OpenedModule );

  _.each( modules, ( module, absolute ) =>
  {
    let relative = absolute;
    if( !path.isGlobal( relative ) )
    relative = path.relative( rootModule.dirPath, relative );

    if( result[ relative ] )
    {
      debugger;
    }
    else if( absolute === rootModule.commonPath )
    {
      result[ relative ] = 'root';
    }
    else
    {
      result[ relative ] = module.dataExport( _.mapExtend( null, options ) );
    }

    if( result[ relative ] === undefined )
    delete result[ relative ];

  });

  return result;
}

//

function resourceImport( o )
{
  let module = this;
  let will = module.will;

  _.assert( _.mapIs( o ) );
  _.assert( arguments.length === 1 );
  _.assert( o.srcResource instanceof will.Resource );
  _.routineOptions( resourceImport, arguments );

  let srcModule = o.srcResource.module;

  _.assert( module instanceof will.OpenedModule );
  _.assert( srcModule === null || srcModule instanceof will.OpenedModule );

  if( o.srcResource.pathsRebase )
  {
    _.assert( o.srcResource.original === null );

    o.srcResource = o.srcResource.cloneDerivative();
    o.srcResource.pathsRebase
    ({
      exInPath : srcModule.inPath,
      inPath : module.inPath,
    });

  }

  let resourceData = o.srcResource.dataExport();

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
    });

    if( _.instanceIsStandard( value ) )
    {
      let o2 = _.mapExtend( null, o );
      o2.srcResource = value;
      let subresource = module.resourceImport( o2 );
      value = subresource.nickName;
    }

    resourceData[ k ] = value;
  }

  if( o.overriding )
  {
    let oldResource = module.resolveRaw
    ({
      selector : o.srcResource.KindName + '::' + o.srcResource.name,
      missingAction : 'undefine',
    });
    if( oldResource )
    {
      resourceData.writable = oldResource.writable;
      resourceData.exportable = oldResource.exportable;
      resourceData.importable = oldResource.importable;
      oldResource.finit();
    }
  }

  _.assert( _.mapIs( resourceData ) );

  resourceData.module = module;
  resourceData.name = module.resourceNameAllocate( o.srcResource.KindName, o.srcResource.name );

  let resource = new o.srcResource.Self( resourceData );
  resource.form1();
  _.assert( module.resolve({ selector : resource.nickName, pathUnwrapping : 0, pathResolving : 0 }).absoluteName === resource.absoluteName );

  return resource;
}

resourceImport.defaults =
{
  srcResource : null,
  overriding : 1,
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

      if( !resource.importable )
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
      // _.assert( resource.module === null );
      resource.module = module;
      resource.form1();
      _.assert( !_.instanceIsFinited( resource ) );
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
// relations
// --

let isDownloadedSymbol = Symbol.for( 'isDownloaded' );
let dirPathSymbol = Symbol.for( 'dirPath' );
let commonPathSymbol = Symbol.for( 'commonPath' );
let willfilesPathSymbol = Symbol.for( 'willfilesPath' );
let rootModuleSymbol = Symbol.for( 'rootModule' );
let willfileWithRoleMapSymbol = Symbol.for( 'willfileWithRoleMap' );
let willfileArraySymbol = Symbol.for( 'willfilesArray' );
let configNameSymbol = Symbol.for( 'configName' );

let Composes =
{

  willfilesPath : null,
  inPath : null,
  outPath : null,
  localPath : null,
  remotePath : null,

  isRemote : null,
  isDownloaded : null,
  isUpToDate : null,

  verbosity : 0,
  // willfilesReadBeginTime : null,

}

let Aggregates =
{

  about : _.define.instanceOf( _.Will.ParagraphAbout ),
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
  supermodules : _.define.own([]),
  original : null,
  willfilesArray : _.define.own([]),

}

let Medials =
{
}

let Restricts =
{

  id : null,
  stager : null,

  // willfilesReadTimeReported : 0,
  _registeredPath : null,

  pathMap : _.define.own({}),
  moduleWithNameMap : null,

  predefinedFormed : 0,
  preformed : 0,
  picked : 0,
  opened : 0,
  submodulesFormed : 0,
  resourcesFormed : 0,
  formed : 0,

  preformReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'preformReady' }) ),
  pickedReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'pickedReady' }) ),
  openedReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'openedReady' }) ),
  submodulesFormReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'submodulesFormReady' }) ),
  resourcesFormReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'resourcesFormReady' }) ),
  ready : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'ready' }) ),

}

let Statics =
{

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
  moduleWithPathMap : 'moduleWithPathMap',
  openedModule : 'openedModule',
  openerModule : 'openerModule',
  willfilesReadTimeReported : 'willfilesReadTimeReported',
  willfilesReadBeginTime : 'willfilesReadBeginTime',

}

let Accessors =
{

  about : { setter : _.accessor.setter.friend({ name : 'about', friendName : 'module', maker : _.Will.ParagraphAbout }) },
  rootModule : { getter : rootModuleGet, setter : rootModuleSet },
  isDownloaded : { setter : remoteIsDownloadedSet },
  willfilesArray : { setter : willfileArraySet },
  willfileWithRoleMap : { readOnly : 1 },

  submoduleMap : { setter : ResourceSetter_functor({ resourceName : 'Submodule', mapName : 'submoduleMap' }) },
  pathResourceMap : { setter : ResourceSetter_functor({ resourceName : 'PathResource', mapName : 'pathResourceMap' }) },
  reflectorMap : { setter : ResourceSetter_functor({ resourceName : 'Reflector', mapName : 'reflectorMap' }) },
  stepMap : { setter : ResourceSetter_functor({ resourceName : 'Step', mapName : 'stepMap' }) },
  buildMap : { setter : ResourceSetter_functor({ resourceName : 'Build', mapName : 'buildMap' }) },
  exportedMap : { setter : ResourceSetter_functor({ resourceName : 'Exported', mapName : 'exportedMap' }) },

  name : { getter : nameGet, readOnly : 1 },
  absoluteName : { getter : absoluteNameGet, readOnly : 1 },
  aliasNames : { getter : aliasNamesGet, readOnly : 1 },
  configName : { readOnly : 1 },

  willfilesPath : { getter : willfilesPathGet, setter : willfilesPathSet },
  inPath : { getter : inPathGet, setter : inPathSet },
  outPath : { getter : outPathGet, setter : outPathSet },
  localPath : { getter : localPathGet, setter : localPathSet },
  remotePath : { getter : remotePathGet, setter : remotePathSet },
  dirPath : { getter : dirPathGet, readOnly : 1 },
  commonPath : { getter : commonPathGet, readOnly : 1 },
  currentRemotePath : { getter : currentRemotePathGet, readOnly : 1 },
  willPath : { getter : willPathGet, readOnly : 1 },

}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,

  optionsForOpener,
  openerMake,
  releasedBy,
  usedBy,
  isUsedBy,

  precopy,
  copy,
  clone,
  cloneExtending,
  unform,
  preform,
  _preform,
  predefinedForm,

  // etc

  shell,
  exportAuto,

  // opener

  isOpened,
  isValid,
  close,
  _formEnd,

  _willfilesPicked,

  willfilesOpen,
  _willfilesOpen,

  _willfilesReadBegin,
  _willfilesReadEnd,

  willfileRegister,
  willfileUnregister,
  _willfilesExport,
  willfileEach,

  // submodule

  rootModuleGet,
  rootModuleSet,
  willfileArraySet,

  submodulesAllAreDownloaded,
  submodulesAllAreValid,
  submodulesClean,

  _submodulesDownload,
  submodulesDownload,
  submodulesUpdate,

  submodulesFixate,
  moduleFixate,
  moduleFixateAct,
  moduleFixatePathFor,

  submodulesReload,
  submodulesForm,
  _submodulesForm,

  // remote

  remoteIsUpdate,
  remoteIsUpToDateUpdate,

  remoteIsDownloadedUpdate,
  remoteIsDownloadedChanged,
  remoteIsDownloadedSet,

  remoteCurrentVersion,
  remoteLatestVersion,

  // resource

  resourcesForm,
  _resourcesForm,
  _resourcesFormAct,
  _resourcesAllForm,

  resourceClassForKind,
  resourceMapForKind,
  resourceMapsForKind,
  resourceMaps,
  resourceObtain,
  resourceAllocate,
  resourceNameAllocate,

  // path

  pathsRelative,
  pathsRebase,
  _filePathChange,
  _filePathChanged,

  inPathGet,
  outPathGet,
  outfilePathGet,
  cloneDirPathGet,

  willfilesPathGet,
  dirPathGet,
  commonPathGet,
  localPathGet,
  remotePathGet,
  currentRemotePathGet,
  willPathGet,

  _inPathAssign,
  _outPathAssign,
  _willfilesPathAssign,
  _dirPathAssign,
  _commonPathAssign,
  _localPathAssign,
  _remotePathAssign,

  inPathSet,
  outPathSet,
  willfilesPathSet,
  localPathSet,
  remotePathSet,

  // name

  nameGet,
  _nameChanged,
  _nameUnregister,
  _nameRegister,
  absoluteNameGet,
  shortNameArrayGet,

  // clean

  cleanWhat,
  cleanWhatReport,
  clean,

  // resolver

  resolve,

  resolveMaybe,
  resolveRaw,
  pathResolve,
  submodulesResolve,
  reflectorResolve,

  // other resolver

  _buildsResolve,
  buildsResolve,
  exportsResolve,
  willfilesResolve,

  // exporter

  _infoExport,
  infoExport,
  infoExportPaths,
  infoExportResource,
  infoExportModulesTopological,

  dataExport,
  dataExportForModuleExport,
  dataExportResources,
  dataExportModules,

  resourceImport,

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

// _.Copyable.mixin( Self );

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
