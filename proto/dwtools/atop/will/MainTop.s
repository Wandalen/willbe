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
  let path = will.fileProvider.path;
  let logger = will.logger;
  let dirPath = fileProvider.path.current();

  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( onReady ) );

  let module = will.currentModule;
  if( !module )
  {
    module = will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
    module.willFilesFind();
    module.willFilesOpen();
    module.resourcesForm();
  }

  return module.ready.split().ifNoErrorThen( function( arg )
  {
    let result = onReady( module );
    _.assert( result !== undefined );
    return result;
  })
  .doThen( ( err, arg ) =>
  {
    if( !will.topCommand )
    {
      _.diagnosticBeep();
      module.finit();
      if( module === will.currentModule )
      will.currentModule = null;
    }
    if( err )
    throw _.errLogOnce( err );
    return arg;
  });

}

//

function done( command )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  _.assert( _.routineIs( command ) );
  _.assert( arguments.length === 1 );
  _.assert( will.formed === 1 );

  if( will.topCommand === command )
  {
    _.diagnosticBeep();
    if( will.currentModule )
    will.currentModule.finit();
    will.currentModule = null;
    will.topCommand = null;
    return true;
  }

  return false;
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

  return module.ready.split().ifNoErrorThen( function( arg )
  {

    _.assert( module.willFileArray.length > 0 );

    return ca.proceedAct
    ({
      command : isolated.secondCommand,
      subject : isolated.secondSubject,
      propertiesMap : e.propertiesMap,
    });

  })
  .doThen( ( err, arg ) =>
  {
    will.done( commandWith );
    if( err )
    throw _.errLogOnce( err );
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
  let con = new _.Consequence().give( null );
  let files = will.willFilesList
  ({
    dirPath : dirPath,
    includingInFiles : 1,
    includingOutFiles : 0,
    rerucrsive : 0,
  });

  for( let f = 0 ; f < files.length ; f++ ) con.ifNoErrorThen( ( arg ) => /* !!! replace by concurrent, maybe */
  {
    let file = files[ f ];
    let dirPath = will.Module.DirPathFromWillFilePath( file.absolute );

    if( will.moduleMap[ dirPath ] )
    return;

    // let module = will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
    // module.willFilesFind();

    let module = will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
    module.willFilesFind();
    module.willFilesOpen();
    module.resourcesForm();

    return module.ready.split().ifNoErrorThen( function( arg )
    {

      _.assert( module.willFileArray.length > 0 );

      let r = ca.proceedAct
      ({
        command : isolated.secondCommand,
        subject : isolated.secondSubject,
        propertiesMap : e.propertiesMap,
      });

      _.assert( r !== undefined );

      return r;
    })
    .doThen( ( err, arg ) =>
    {
      module.finit();
      if( module === will.currentModule )
      will.currentModule = null;
      if( err )
      throw _.errLogOnce( err );
      return arg;
    });

  });

  con.doThen( ( err, arg ) =>
  {
    will.done( commandEach );
    if( err )
    throw _.errLogOnce( err );
    return arg;
  });

  return con;
}

// {
//   let will = this;
//   let ca = e.ca;
//   let con = new _.Consequence().give( null );
//
//   if( !will.formed )
//   will.form();
//
//   if( will.currentModule )
//   {
//     will.currentModule.finit();
//     will.currentModule = null;
//   }
//
//   _.sure( _.strDefined( e.subject ), 'Expects path to module' )
//
//   let secondCommand, secondSubject, del;
//   [ e.subject, del, secondCommand  ] = _.strIsolateBeginOrAll( e.subject, ' ' );
//   [ secondCommand, del, secondSubject  ] = _.strIsolateBeginOrAll( secondCommand, ' ' );
//
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//   let dirPath = path.resolve( e.subject );
//
//   let files = will.willFilesList
//   ({
//     dirPath : dirPath,
//     includingInFiles : 1,
//     includingOutFiles : 0,
//     rerucrsive : 0,
//   });
//
//   for( let f = 0 ; f < files.length ; f++ ) con.ifNoErrorThen( ( arg ) => /* !!! replace by concurrent */
//   {
//     let file = files[ f ];
//     let dirPath = will.Module.DirPathFromWillFilePath( file.absolute );
//
//     if( will.moduleMap[ dirPath ] )
//     return;
//
//     let module = will.currentModule = will.Module({ will : will, dirPath : dirPath }).form();
//     will.currentModule.willFilesFind();
//
//     return will.currentModule.ready.split().ifNoErrorThen( function( arg )
//     {
//       _.assert( module.willFileArray.length > 0 );
//
//       let result = ca.proceedAct
//       ({
//         command : secondCommand,
//         subject : secondSubject,
//         propertiesMap : _.mapExtend( null, e.propertiesMap ),
//       });
//
//       return result;
//     });
//
//   });
//
//   return con;
// }

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
  moduleOnReady,
  done,

  commandsMake,
  commandHelp,

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
