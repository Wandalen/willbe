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

function moduleOnReady( onReady )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let logger = will.logger;
  let dirPath = fileProvider.path.current();

  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( onReady ) );

  if( !will.currentModule )
  {
    will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
    will.currentModule.willFilesFind();
    will.currentModule.willFilesOpen();
    will.currentModule.resourcesForm();
  }

  return will.currentModule.ready.split().ifNoErrorThen( function( arg )
  {
    let module = will.currentModule;
    let result = onReady( module );
    _.assert( result !== undefined );
    return result;
  })
  .doThen( ( err, arg ) =>
  {
    _.diagnosticBeep();
    will.currentModule.finit();
    if( err )
    throw _.errLogOnce( err );
    return arg;
  });

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

  // debugger;
  var ca = _.CommandsAggregator
  ({
    basePath : fileProvider.path.current(),
    commands : commands,
    commandPrefix : 'node ',
    logger : will.logger,
  })
  // debugger;

  _.assert( ca.logger === will.logger );
  _.assert( ca.verbosity === will.verbosity );

  // debugger;

  //will._commandsConfigAdd( ca );

  ca.form();

  return ca;
}


//

function commandHelp( e )
{
  let self = this;
  let ca = e.ca;
  let logger = self.logger;

  ca._commandHelp( e );

  if( !e.subject )
  {
    logger.log( 'Use ' + logger.colorFormat( '"will .help"', 'code' ) + ' to get help' );
  }

}

//
//
// function commandHelp( e )
// {
//   let will = this;
//   let fileProvider = will.fileProvider;
//   let logger = will.logger;
//
//   logger.log();
//   logger.log( e.ca.vocabulary.helpForSubjectAsString( '' ) );
//   logger.log();
//
//   //logger.log( 'Use ' + logger.colorFormat( '"will .init confPath:./conf" actionsPath:./actions', 'code' ) + ' to init the module' );
//   logger.log( 'Use ' + logger.colorFormat( '"will .help"', 'code' ) + ' to get help' );
//   // logger.log( 'Use ' + logger.colorFormat( '"will"', 'code' ) + '' );
//
//   return will;
// }

//

function _commandList( e, act )
{
  let will = this;

  _.assert( arguments.length === 2 );

  return will.moduleOnReady( function( module )
  {
    return act( module ) || null;
  });

  // if( !will.formed )
  // will.form();
  //
  // let logger = will.logger;
  // let fileProvider = will.fileProvider;
  // let dirPath = fileProvider.path.current();
  //
  // // if( !will.currentModule )
  // // will.currentModule = will.Module({ will : will, dirPath : dirPath }).form().willFilesFind();
  //
  // if( !will.currentModule )
  // {
  //   will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
  //   will.currentModule.willFilesFind();
  //   will.currentModule.willFilesOpen();
  //   will.currentModule.resourcesForm();
  // }
  //
  // return will.currentModule.ready.split().ifNoErrorThen( function( arg )
  // {
  //   logger.log();
  //   let result = act( will.currentModule );
  //   return result || null;
  // })
  // .doThen( function( err, arg )
  // {
  //   if( err )
  //   throw _.errLogOnce( err );
  //   if( will.currentModule )
  //   will.currentModule.finit();
  //   return arg;
  // });

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
  return will.moduleOnReady( function( module )
  {
    return module.submodulesDownload();
  });
}

//

function commandSubmodulesUpgrade( e )
{
  let will = this;
  return will.moduleOnReady( function( module )
  {
    return module.submodulesUpgrade();
  });
}

//

function commandSubmodulesClean( e )
{
  let will = this;
  return will.moduleOnReady( function( module )
  {
    return module.submodulesClean();
  });
}

//

function commandClean( e )
{
  let will = this;

  return will.moduleOnReady( function( module )
  {
    let logger = will.logger;
    return module.clean();
  });

  // if( !will.formed )
  // will.form();
  //
  // let fileProvider = will.fileProvider;
  // let logger = will.logger;
  // let dirPath = fileProvider.path.current();
  //
  // if( !will.currentModule )
  // {
  //   will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
  //   will.currentModule.willFilesFind();
  // }
  //
  // return will.currentModule.ready.split().ifNoErrorThen( function( arg )
  // {
  //   let module = will.currentModule;
  //
  //   logger.up();
  //   if( logger.verbosity >= 2 )
  //   {
  //     logger.log( 'Cleaning', module.nickName );
  //   }
  //
  //   module.clean();
  //   logger.down();
  //
  //   return arg;
  // });

}

//

function commandCleanWhat( e )
{
  let will = this;

  return will.moduleOnReady( function( module )
  {
    let filesPath = module.cleanWhat();
    logger.log();
    logger.log( _.toStr( filesPath, { multiline : 1, wrap : 0, levels : 2 } ) );
    logger.log( 'Clean will delete ' + filesPath.length + ' file(s)' );
    return filesPath;
  });

  // if( !will.formed )
  // will.form();
  //
  // let fileProvider = will.fileProvider;
  // let logger = will.logger;
  // let dirPath = fileProvider.path.current();
  //
  // if( !will.currentModule )
  // {
  //   will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
  //   will.currentModule.willFilesFind();
  // }
  //
  // return will.currentModule.ready.split().ifNoErrorThen( function( arg )
  // {
  //   let module = will.currentModule;
  //
  //   logger.up();
  //   if( logger.verbosity >= 2 )
  //   {
  //     logger.log( 'Cleaning', module.nickName );
  //   }
  //
  //   module.clean();
  //   logger.down();
  //
  //   return arg;
  // });

}

//

function commandBuild( e )
{
  let will = this;
  return will.moduleOnReady( function( module )
  {
    let builds = module.buildsSelect( e.subject, e.propertiesMap );

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
    return build.build()
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
    return build.build()
  });

  // xxx
  //
  // let will = this;
  //
  // if( !will.formed )
  // will.form();
  //
  // let fileProvider = will.fileProvider;
  // let logger = will.logger;
  // let dirPath = fileProvider.path.current();
  //
  // // if( !will.currentModule )
  // // will.currentModule = will.Module({ will : will, dirPath : dirPath }).form().willFilesFind();
  //
  // if( !will.currentModule )
  // {
  //   will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
  //   will.currentModule.willFilesFind();
  // }
  //
  // return will.currentModule.ready.split().ifNoErrorThen( function( arg )
  // {
  //
  //   let module = will.currentModule
  //   let exports = module.exportsSelect( e.subject, e.propertiesMap );
  //
  //   logger.up();
  //   if( logger.verbosity >= 2 )
  //   {
  //     if( exports.length === 1 )
  //     logger.log( 'Exporting', exports[ 0 ].name );
  //     else
  //     logger.log( module.infoExportResource( exports ) );
  //   }
  //
  //   if( exports.length !== 1 )
  //   {
  //     if( exports.length === 0 )
  //     throw _.errBriefly( 'To export please specify exactly one export, none satisfies passed arguments' );
  //     throw _.errBriefly( 'To export please specify exactly one export' );
  //   }
  //
  //   let run = new will.BuildFrame({ module : module }).form();
  //
  //   return run.run( exports[ 0 ] )
  //   .doThen( ( err ) =>
  //   {
  //     run.finit();
  //     module.finit();
  //
  //     if( err )
  //     throw _.errLogOnce( err );
  //
  //     if( logger.verbosity >= 2 )
  //     {
  //       logger.log( 'Exported', exports[ 0 ].name );
  //       logger.log();
  //     }
  //     logger.down();
  //
  //   });
  //
  // });

}

//

function commandWith( e )
{
  let will = this;
  let ca = e.ca;

  if( !will.formed )
  will.form();

  if( will.currentModule )
  will.currentModule.finit();

  _.sure( _.strDefined( e.subject ), 'Expects path to module' )

  let secondCommand, secondSubject, del;
  [ e.subject, del, secondCommand  ] = _.strIsolateBeginOrAll( e.subject, ' ' );
  [ secondCommand, del, secondSubject  ] = _.strIsolateBeginOrAll( secondCommand, ' ' );

  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let dirPath = path.resolve( e.subject );

  let module = will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
  will.currentModule.willFilesFind();

  return will.currentModule.ready.split().ifNoErrorThen( function( arg )
  {

    _.assert( module.willFileArray.length > 0 );
    return ca.proceedAct
    ({
      command : secondCommand,
      subject : secondSubject,
      propertiesMap : e.propertiesMap,
    });

  });

}

//

function commandEach( e )
{
  let will = this;
  let ca = e.ca;
  let con = new _.Consequence().give( null );

  if( !will.formed )
  will.form();

  if( will.currentModule )
  will.currentModule.finit();

  _.sure( _.strDefined( e.subject ), 'Expects path to module' )

  let secondCommand, secondSubject, del;
  [ e.subject, del, secondCommand  ] = _.strIsolateBeginOrAll( e.subject, ' ' );
  [ secondCommand, del, secondSubject  ] = _.strIsolateBeginOrAll( secondCommand, ' ' );

  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let dirPath = path.resolve( e.subject );

  let files = will.willFilesList
  ({
    dirPath : dirPath,
    includingInFiles : 1,
    includingOutFiles : 0,
    rerucrsive : 0,
  });

  for( let f = 0 ; f < files.length ; f++ ) con.ifNoErrorThen( ( arg ) => /* !!! replace by concurrent */
  {
    let file = files[ f ];
    let dirPath = will.Module.DirPathFromWillFilePath( file.absolute );

    if( will.moduleMap[ dirPath ] )
    return;

    let module = will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
    will.currentModule.willFilesFind();

    return will.currentModule.ready.split().ifNoErrorThen( function( arg )
    {
      _.assert( module.willFileArray.length > 0 );

      let result = ca.proceedAct
      ({
        command : secondCommand,
        subject : secondSubject,
        propertiesMap : _.mapExtend( null, e.propertiesMap ),
      });

      return result;
    });

  });

  return con;
}

// --
// relations
// --

let Composes =
{
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

  Exec : Exec,
  exec : exec,
  moduleOnReady : moduleOnReady,

  commandsMake : commandsMake,
  commandHelp : commandHelp,

  _commandList : _commandList,
  commandList : commandList,
  commandPathsList : commandPathsList,
  commandSubmodulesList : commandSubmodulesList,
  commandReflectorsList : commandReflectorsList,
  commandStepsList : commandStepsList,
  commandBuildsList : commandBuildsList,
  commandExportsList : commandExportsList,
  commandAboutList : commandAboutList,
  commandExecutionList : commandExecutionList,

  commandSubmodulesDownload : commandSubmodulesDownload,
  commandSubmodulesUpgrade : commandSubmodulesUpgrade,
  commandSubmodulesClean : commandSubmodulesClean,

  commandClean : commandClean,
  commandCleanWhat : commandCleanWhat,
  commandBuild : commandBuild,
  commandExport : commandExport,
  commandWith : commandWith,
  commandEach : commandEach,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,

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
