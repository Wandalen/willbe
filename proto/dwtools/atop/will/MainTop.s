( function _MainTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './MainBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = _.Will;

// --
// exec
// --

function Exec()
{
  let will = new this.Self();
  return will.exec();
}

//

function exec()
{
  let will = this;

  will.formAssociates();

  _.assert( _.instanceIs( will ) );
  _.assert( arguments.length === 0 );

  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let appArgs = _.appArgs();
  let ca = will.commandsMake();

  return ca.proceedApplicationArguments({ appArgs : appArgs });
}

//

function _moduleOnReady( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let dirPath = fileProvider.path.current();

  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( o.onReady ) );
  _.routineOptions( _moduleOnReady, arguments );

  if( !will.topCommand )
  will.topCommand = o.onReady;

  // debugger;

  let module = will.currentModule;
  if( !module )
  {
    module = will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
    module.willFilesFind();
    module.willFilesOpen();
    if( o.formingResources )
    module.resourcesForm();
    else
    module.resourcesFormSkip();
  }

  return module.ready.split().keep( function( arg )
  {
    let result = o.onReady( module );
    _.assert( result !== undefined );
    return result;
  })
  .finally( ( err, arg ) => will.moduleDone({ error : err || null, command : will.topCommand }) )
  ;

  // .finally( ( err, arg ) =>
  // {
  //   xxx
  //   if( !will.topCommand )
  //   {
  //     if( will.beeping )
  //     _.diagnosticBeep();
  //     if( module === will.currentModule )
  //     will.currentModule = null;
  //     module.finit();
  //   }
  //   if( err )
  //   throw err;
  //   return arg;
  // })
  // .finally( ( err, arg ) =>
  // {
  //   if( err )
  //   {
  //     if( !will.topCommand )
  //     _.appExitCode( -1 );
  //     throw _.errLogOnce( err );
  //   }
  //   return arg;
  // });

}

_moduleOnReady.defaults =
{
  onReady : null,
  formingResources : null,
}

//

function moduleOnReady( onReady )
{
  let will = this.form();
  _.assert( arguments.length === 1 );
  return will._moduleOnReady
  ({
    onReady : onReady,
    formingResources : 1,
  });
}

//

function moduleOnReadyNonForming( onReady )
{
  let will = this.form();
  _.assert( arguments.length === 1 );
  return will._moduleOnReady
  ({
    onReady : onReady,
    formingResources : 0,
  });
}

//

function moduleDone( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( moduleDone, arguments );
  _.assert( _.routineIs( o.command ) );
  _.assert( _.routineIs( will.topCommand ) );
  _.assert( arguments.length === 1 );
  _.assert( will.formed === 1 );

  if( o.err )
  {
    _.appExitCode( -1 );
    _.errLogOnce( o.err );
  }

  try
  {

    if( will.topCommand === o.command )
    {
      if( will.beeping )
      _.diagnosticBeep();
      will.currentModule = null;
      will.topCommand = null;
      let currentModule = will.currentModule;
      if( currentModule )
      currentModule.finit();
      debugger;
      _.procedure.terminationBegin();
      return true;
    }

  }
  catch( err )
  {
    _.appExitCode( -1 );
    _.errLogOnce( err );
    will.currentModule = null;
    will.topCommand = null;
    return true;
  }

/*
  .finally( ( err, arg ) =>
  {
    xxx
    if( !will.topCommand )
    {
      if( will.beeping )
      _.diagnosticBeep();
      if( module === will.currentModule )
      will.currentModule = null;
      module.finit();
    }
    if( err )
    throw err;
    return arg;
  })
  .finally( ( err, arg ) =>
  {
    if( err )
    {
      if( !will.topCommand )
      _.appExitCode( -1 );
      throw _.errLogOnce( err );
    }
    return arg;
  });
*/

  return false;
}

moduleDone.defaults =
{
  error : null,
  command : null,
}

//

function commandsMake()
{
  let will = this;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let appArgs = _.appArgs();

  _.assert( _.instanceIs( will ) );
  _.assert( arguments.length === 0 );

  let commands =
  {

    'help' :                    { e : _.routineJoin( will, will.commandHelp ),                  h : 'Get help.' },
    'set' :                     { e : _.routineJoin( will, will.commandSet ),                   h : 'Command set.' },

    'list' :                    { e : _.routineJoin( will, will.commandList ),                  h : 'List information about the current module.' },
    'paths list' :              { e : _.routineJoin( will, will.commandPathsList ),             h : 'List paths of the current module.' },
    'submodules list' :         { e : _.routineJoin( will, will.commandSubmodulesList ),        h : 'List submodules of the current module.' },
    'reflectors list' :         { e : _.routineJoin( will, will.commandReflectorsList ),        h : 'List avaialable reflectors.' },
    'steps list' :              { e : _.routineJoin( will, will.commandStepsList ),             h : 'List avaialable steps.' },
    'builds list' :             { e : _.routineJoin( will, will.commandBuildsList ),            h : 'List avaialable builds.' },
    'exports list' :            { e : _.routineJoin( will, will.commandExportsList ),           h : 'List avaialable exports.' },
    'about list' :              { e : _.routineJoin( will, will.commandAboutList ),             h : 'List descriptive information about the module.' },
    'execution list' :          { e : _.routineJoin( will, will.commandExecutionList ),         h : 'List execution scenarios.' },

    'submodules download' :     { e : _.routineJoin( will, will.commandSubmodulesDownload ),    h : 'Download each submodule if such was not downloaded so far.' },
    'submodules upgrade' :      { e : _.routineJoin( will, will.commandSubmodulesUpgrade ),     h : 'Upgrade each submodule, checking for available updates for such.' },
    'submodules clean' :        { e : _.routineJoin( will, will.commandSubmodulesClean ),       h : 'Delete all downloaded submodules.' },

    'clean' :                   { e : _.routineJoin( will, will.commandClean ),                 h : 'Clean current module. Delete genrated artifacts, temp files and downloaded submodules.' },
    'clean what' :              { e : _.routineJoin( will, will.commandCleanWhat ),             h : 'Find out which files will be deleted by clean command.' },
    'build' :                   { e : _.routineJoin( will, will.commandBuild ),                 h : 'Build current module with spesified criterion.' },
    'export' :                  { e : _.routineJoin( will, will.commandExport ),                h : 'Export selected the module with spesified criterion. Save output to output file and archive.' },
    'with' :                    { e : _.routineJoin( will, will.commandWith ),                  h : 'Use "with" to select a module.' },
    'each' :                    { e : _.routineJoin( will, will.commandEach ),                  h : 'Use "each" to iterate each module in a directory.' },

  }

  let ca = _.CommandsAggregator
  ({
    basePath : fileProvider.path.current(),
    commands : commands,
    commandPrefix : 'node ',
    logger : will.logger,
  })

  _.assert( ca.logger === will.logger );
  _.assert( ca.verbosity === will.verbosity );

  //will._commandsConfigAdd( ca );

  ca.form();

  return ca;
}


//

function commandHelp( e )
{
  let will = this;
  let ca = e.ca;
  let logger = will.logger;

  ca._commandHelp( e );

  if( !e.subject )
  {
    logger.log( 'Use ' + logger.colorFormat( '"will .help"', 'code' ) + ' to get help' );
  }

}

//

function commandSet( e )
{
  let will = this;
  let ca = e.ca;
  let logger = will.logger;

  // logger.log( e.propertiesMap ); debugger;

  let namesMap =
  {
    v : 'verbosity',
    verbosity : 'verbosity',
    beeping : 'beeping',
  }

  _.appArgsReadTo
  ({
    dst : will,
    propertiesMap : e.propertiesMap,
    namesMap : namesMap,
  });

  // appArgsReadTo.defaults =
  // {
  //   dst : null,
  //   propertiesMap : null,
  //   namesMap : null,
  //   removing : 1,
  //   only : 1,
  // }

}

//

function _commandList( e, act )
{
  let will = this;

  _.assert( arguments.length === 2 );

  return will.moduleOnReady( function( module )
  {
    return act( module ) || null;
  });

}

//

function commandList( e )
{
  let will = this;

  function act( module )
  {
    let logger = will.logger;
    logger.log( module.infoExport() );
  }

  return will._commandList( e, act );
}

//

function commandPathsList( e )
{
  let will = this;

  function act( module )
  {
    let logger = will.logger;
    logger.log( module.infoExportPaths() );
  }

  return will._commandList( e, act );
}

//

function commandSubmodulesList( e )
{
  let will = this;

  function act( module )
  {
    let logger = will.logger;
    logger.log( module.infoExportResource( module.submoduleMap ) );
  }

  return will._commandList( e, act );
}

//

function commandReflectorsList( e )
{
  let will = this;

  function act( module )
  {
    let logger = will.logger;
    logger.log( module.infoExportResource( module.reflectorMap ) );
  }

  return will._commandList( e, act );
}

//

function commandStepsList( e )
{
  let will = this;

  function act( module )
  {
    let logger = will.logger;
    logger.log( module.infoExportResource( module.stepMap ) );
  }

  return will._commandList( e, act );
}

//

function commandBuildsList( e )
{
  let will = this;

  function act( module )
  {
    let logger = will.logger;
    let builds = module.buildsSelect
    ({
      name : e.subject,
      criterion : e.propertiesMap,
      preffering : 'more',
    });
    logger.log( module.infoExportResource( builds ) );
  }

  will._commandList( e, act );

  return will;
}

//

function commandExportsList( e )
{
  let will = this;

  function act( module )
  {
    let logger = will.logger;
    let builds = module.exportsSelect
    ({
      name : e.subject,
      criterion : e.propertiesMap,
      preffering : 'more',
    });
    logger.log( module.infoExportResource( builds ) );
  }

  will._commandList( e, act );

  return will;
}

//

function commandAboutList( e )
{
  let will = this;

  function act( module )
  {
    let logger = will.logger;
    logger.log( module.about.infoExport() );
  }

  will._commandList( e, act );

  return will;
}

//

function commandExecutionList( e )
{
  let will = this;

  function act( module )
  {
    let logger = will.logger;
    logger.log( module.execution.infoExport() );
  }

  will._commandList( e, act );

  return will;
}

//

function commandSubmodulesDownload( e )
{
  let will = this;
  return will.moduleOnReadyNonForming( function( module )
  {
    return module.submodulesDownload();
  });
}

//

function commandSubmodulesUpgrade( e )
{
  let will = this;
  return will.moduleOnReadyNonForming( function( module )
  {
    return module.submodulesUpgrade();
  });
}

//

function commandSubmodulesClean( e )
{
  let will = this;
  return will.moduleOnReadyNonForming( function( module )
  {
    return module.submodulesClean();
  });
}

//

function commandClean( e )
{
  let will = this;

  return will.moduleOnReadyNonForming( function( module )
  {
    let logger = will.logger;
    return module.clean();
  });

}

//

function commandCleanWhat( e )
{
  let will = this;

  return will.moduleOnReadyNonForming( function( module )
  {
    let time = _.timeNow();
    let filesPath = module.cleanWhat();
    let logger = will.logger;
    logger.log();

    if( logger.verbosity >= 4 )
    logger.log( _.toStr( filesPath[ '/' ], { multiline : 1, wrap : 0, levels : 2 } ) );

    if( logger.verbosity >= 2 )
    {
      let details = _.filter( filesPath, ( filesPath, basePath ) =>
      {
        if( basePath === '/' )
        return;
        if( !filesPath.length )
        return;
        if( filesPath.length === 1 )
        return filesPath[ 0 ];
        return filesPath.length + ' at ' + basePath;
      });
      logger.log( _.mapVals( details ).join( '\n' ) );
    }

    logger.log( 'Clean will delete ' + filesPath[ '/' ].length + ' file(s) in total, found in ' + _.timeSpent( time ) );

    return filesPath;
  });

}

//

function commandBuild( e )
{
  let will = this;
  return will.moduleOnReady( function( module )
  {
    let builds = module.buildsSelect( e.subject, e.propertiesMap );
    let logger = will.logger;

    // logger.log( 'logger.verbosity', logger.verbosity );
    // logger.log( 'will.verbosity', will.verbosity );

    if( logger.verbosity >= 2 && builds.length > 1 )
    {
      logger.up();
      logger.log( module.infoExportResource( builds ) );
      logger.down();
    }

    if( builds.length !== 1 )
    {
      if( builds.length === 0 )
      throw _.errBriefly( 'To build please specify exactly one build scenario, none satisfies passed arguments' );
      throw _.errBriefly( 'To build please specify exactly one build scenario, ' + builds.length + ' satisfy(s) passed arguments' );
    }

    let build = builds[ 0 ];
    return build.proceed()
  });
}

//

function commandExport( e )
{
  let will = this;
  return will.moduleOnReady( function( module )
  {
    let builds = module.exportsSelect( e.subject, e.propertiesMap );

    if( logger.verbosity >= 2 && builds.length > 1 )
    {
      logger.up();
      logger.log( module.infoExportResource( builds ) );
      logger.down();
    }

    if( builds.length !== 1 )
    {
      if( builds.length === 0 )
      throw _.errBriefly( 'To export please specify exactly one export scenario, none satisfies passed arguments' );
      throw _.errBriefly( 'To export please specify exactly one export scenario, ' + builds.length + ' satisfy(s) passed arguments' );
    }

    let build = builds[ 0 ];
    return build.proceed()
  });
}

//

function commandWith( e )
{
  let will = this.form();
  let ca = e.ca;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  if( will.currentModule )
  {
    will.currentModule.finit();
    will.currentModule = null;
  }

  _.sure( _.strDefined( e.subject ), 'Expects path to module' )
  _.assert( arguments.length === 1 );

  if( will.topCommand === null )
  will.topCommand = commandWith;

  let isolated = ca.isolateSecond( e.subject );
  let dirPath = path.resolve( isolated.subject );

  let module = will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
  module.willFilesFind();
  module.willFilesOpen();
  module.resourcesForm();

  return module.ready.split().keep( function( arg )
  {

    _.assert( module.willFileArray.length > 0 );

    return ca.proceedCommand
    ({
      command : isolated.secondCommand,
      subject : isolated.secondSubject,
      propertiesMap : e.propertiesMap,
    });

  })
  .finally( ( err, arg ) =>
  {
    debugger;
    // let isTop = will.topCommand === commandWith;
    will.moduleDone({ error : err || null, command : commandWith });
    if( err )
    {
      // if( isTop )
      // _.appExitCode( -1 );
      throw _.errLogOnce( err );
    }
    return arg;
  });

}

//

function commandEach( e )
{
  let will = this.form();
  let ca = e.ca;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  if( will.currentModule )
  {
    will.currentModule.finit();
    will.currentModule = null;
  }

  _.sure( _.strDefined( e.subject ), 'Expects path to module' )
  _.assert( arguments.length === 1 );

  if( will.topCommand === null )
  will.topCommand = commandEach;

  let isolated = ca.isolateSecond( e.subject );
  let dirPath = path.resolve( isolated.subject );
  let con = new _.Consequence().take( null );
  let files = will.willFilesList
  ({
    dirPath : dirPath,
    includingInFiles : 1,
    includingOutFiles : 0,
    rerucrsive : 0,
  });

  let dirPaths = Object.create( null );

  for( let f = 0 ; f < files.length ; f++ ) con.keep( ( arg ) => /* !!! replace by concurrent, maybe */
  {
    let file = files[ f ];

    // debugger;

    let dirPath = will.Module.DirPathFromWillFilePath( file.absolute );

    if( dirPaths[ dirPath ] )
    return true;
    dirPaths[ dirPath ] = 1;

    if( will.currentModule )
    {
      will.currentModule.finit();
      will.currentModule = null;
    }

    if( will.moduleMap[ dirPath ] )
    return true;

    let module = will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
    module.willFilesFind();
    module.willFilesOpen();
    module.resourcesForm();

    return module.ready.split().keep( function( arg )
    {

      _.assert( module.willFileArray.length > 0 );

      // debugger;
      let r = ca.proceedCommand
      ({
        command : isolated.secondCommand,
        subject : isolated.secondSubject,
        propertiesMap : e.propertiesMap,
      });

      _.assert( r !== undefined );

      return r;
    })

  });

  con.finally( ( err, arg ) =>
  {
    debugger;
    // let isTop = will.topCommand === commandEach;
    // will.moduleDone( commandEach );
    will.moduleDone({ error : err || null, command : commandEach });
    if( err )
    {
      // if( isTop )
      // _.appExitCode( -1 );
      throw _.errLogOnce( err );
    }
    return arg;
  });

  return con;
}

// --
// relations
// --

let Composes =
{
  beeping : 0,
}

let Aggregates =
{
}

let Associates =
{
  currentModule : null,
}

let Restricts =
{
  topCommand : null,
}

let Statics =
{
  Exec : Exec,
}

let Forbids =
{
}

// --
// declare
// --

let Extend =
{

  // exec

  Exec,
  exec,
  _moduleOnReady,
  moduleOnReady,
  moduleOnReadyNonForming,
  moduleDone,

  commandsMake,
  commandHelp,
  commandSet,

  _commandList,
  commandList,
  commandPathsList,
  commandSubmodulesList,
  commandReflectorsList,
  commandStepsList,
  commandBuildsList,
  commandExportsList,
  commandAboutList,
  commandExecutionList,

  commandSubmodulesDownload,
  commandSubmodulesUpgrade,
  commandSubmodulesClean,

  commandClean,
  commandCleanWhat,
  commandBuild,
  commandExport,

  commandWith,
  commandEach,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

}

//

_.classExtend
({
  cls : Self,
  extend : Extend,
});

//_.EventHandler.mixin( Self );
//_.Instancing.mixin( Self );
//_.StateStorage.mixin( Self );
//_.StateSession.mixin( Self );
//_.CommandsConfig.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_global_[ Self.name ] = wTools[ Self.shortName ] = Self;

if( !module.parent )
Self.Exec();

})();
