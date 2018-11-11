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

    'help' :              { e : _.routineJoin( will, will.commandHelp ),              h : 'Get help.' },

    'list' :              { e : _.routineJoin( will, will.commandList ),              h : 'List information about the current module.' },
    'paths list' :        { e : _.routineJoin( will, will.commandPathsList ),         h : 'List paths of the current module.' },
    'submodules list' :   { e : _.routineJoin( will, will.commandSubmodulesList ),    h : 'List submodules of the current module.' },
    'reflectors list' :   { e : _.routineJoin( will, will.commandReflectorsList ),    h : 'List avaialable reflectors.' },
    'steps list' :        { e : _.routineJoin( will, will.commandStepsList ),         h : 'List avaialable steps.' },
    'builds list' :       { e : _.routineJoin( will, will.commandBuildsList ),        h : 'List avaialable builds.' },
    'exports list' :      { e : _.routineJoin( will, will.commandExportsList ),       h : 'List avaialable exports.' },
    'about list' :        { e : _.routineJoin( will, will.commandAboutList ),         h : 'List descriptive information about the module.' },
    'execution list' :    { e : _.routineJoin( will, will.commandExecutionList ),     h : 'List execution scenarios.' },

    'clean' :             { e : _.routineJoin( will, will.commandClean ),             h : 'Clean current module. Delete genrated artifacts.' },
    'build' :             { e : _.routineJoin( will, will.commandBuild ),             h : 'Build current module with spesified criterion.' },
    'export' :            { e : _.routineJoin( will, will.commandExport ),            h : 'Export selected the module with spesified criterion. Save output to output file and archive.' },
    'with' :              { e : _.routineJoin( will, will.commandWith ),              h : 'Use "with" to select a module' },
    'each' :              { e : _.routineJoin( will, will.commandEach ),              h : 'Use "each" to iterate each module in a directory' },

  }

  var ca = _.CommandsAggregator
  ({
    basePath : fileProvider.path.current(),
    commands : commands,
    commandPrefix : 'node ',
  })

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

  if( !will.formed )
  will.form();

  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let dirPath = fileProvider.path.current();

  if( !will.currentModule )
  will.currentModule = will.Module({ will : will, dirPath : dirPath }).form().willFilesLoad();
  let module = will.currentModule;

  act( module );

  module.finit();

  return will;
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

  will._commandList( e, act );

  return will;
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

  will._commandList( e, act );

  return will;
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

  will._commandList( e, act );

  return will;
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

  will._commandList( e, act );

  return will;
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

  will._commandList( e, act );

  return will;
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

function commandClean( e )
{
  let will = this;

  if( !will.formed )
  will.form();

  let fileProvider = will.fileProvider;
  let logger = will.logger;
  let dirPath = fileProvider.path.current();
  if( !will.currentModule )
  will.currentModule = will.Module({ will : will, dirPath : dirPath }).form().willFilesLoad();
  let module = will.currentModule;

  logger.up();
  if( logger.verbosity >= 2 )
  {
    logger.log( 'Cleaning', module.nickName );
  }

  module.clean();
  logger.down();
}

//

function commandBuild( e )
{
  let will = this;

  if( !will.formed )
  will.form();

  let fileProvider = will.fileProvider;
  let logger = will.logger;
  let dirPath = fileProvider.path.current();
  if( !will.currentModule )
  will.currentModule = will.Module({ will : will, dirPath : dirPath }).form().willFilesLoad();
  let module = will.currentModule;

  let builds = module.buildsSelect( e.subject, e.propertiesMap );

  logger.up();
  if( logger.verbosity >= 2 )
  {
    if( builds.length === 1 )
    logger.log( 'Building', builds[ 0 ].name );
    else
    logger.log( module.infoExportResource( builds ) );
  }

  if( builds.length !== 1 )
  {
    if( builds.length === 0 )
    throw _.errBriefly( 'To build please specify exactly one build scenario, none satisfies passed arguments' );
    throw _.errBriefly( 'To build please specify exactly one build scenario, ' + builds.length + ' satisfy(s) passed arguments' );
  }

  let run = new will.BuildRun({ module : module }).form();

  return run.run( builds[ 0 ] )
  .doThen( ( err ) =>
  {
    run.finit();
    module.finit();
    if( err )
    throw _.errLogOnce( err );

    if( logger.verbosity >= 2 )
    {
      logger.log( 'Built', builds[ 0 ].name );
      logger.log();
    }
    logger.down();

  });

}

//

function commandExport( e )
{
  let will = this;

  if( !will.formed )
  will.form();

  let fileProvider = will.fileProvider;
  let logger = will.logger;
  let dirPath = fileProvider.path.current();
  if( !will.currentModule )
  will.currentModule = will.Module({ will : will, dirPath : dirPath }).form().willFilesLoad();
  let module = will.currentModule;

  let exports = module.exportsSelect( e.subject, e.propertiesMap );

  logger.up();
  if( logger.verbosity >= 2 )
  {
    if( exports.length === 1 )
    logger.log( 'Exporting', exports[ 0 ].name );
    else
    logger.log( module.infoExportResource( exports ) );
  }

  if( exports.length !== 1 )
  {
    if( exports.length === 0 )
    throw _.errBriefly( 'To export please specify exactly one export, none satisfies passed arguments' );
    throw _.errBriefly( 'To export please specify exactly one export' );
  }

  let run = new will.BuildRun({ module : module }).form();

  return run.run( exports[ 0 ] )
  .doThen( ( err ) =>
  {
    run.finit();
    module.finit();

    if( err )
    throw _.errLogOnce( err );

    if( logger.verbosity >= 2 )
    {
      logger.log( 'Exported', exports[ 0 ].name );
      logger.log();
    }
    logger.down();

  });

  // let expf = new will.OutFile({ module : module, export : exports[ 0 ] });
  //
  // return expf.form()
  // .doThen( ( err ) =>
  // {
  //   expf.finit();
  //   module.finit();
  //   if( err )
  //   throw _.errLogOnce( err );
  //
  //   if( logger.verbosity >= 2 )
  //   {
  //     logger.log( 'Exported', exports[ 0 ].name );
  //     logger.log();
  //   }
  //   logger.down();
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
  let module = will.currentModule = will.Module({ will : will, dirPath : dirPath })
  .form()
  .willFilesLoad();

  if( module.inFileArray.length === 0 )
  {
    debugger;
    throw _.errBriefly( 'Found no will-file at', _.strQuote( module.dirPath ) );
  }

  return ca.proceedAct
  ({
    command : secondCommand,
    subject : secondSubject,
    propertiesMap : e.propertiesMap,
  });

}

//

function commandEach( e )
{
  let will = this;
  let ca = e.ca;
  let con = new _.Consequence().give();

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

  // logger.log( _.select( files, '*/absolute' ) );

  for( let f = 0 ; f < files.length ; f++ ) con.ifNoErrorThen( () => /* !!! replace by concurrent */
  {
    let file = files[ f ];
    let dirPath = will.Module.DirPathFromWillFilePath( file.absolute );

    if( will.moduleMap[ dirPath ] )
    return;

    let module = will.currentModule = will.Module({ will : will, dirPath : dirPath })
    .form()
    .willFilesLoad()
    ;

    if( module.inFileArray.length === 0 )
    {
      debugger;
      throw _.errBriefly( 'Failed load will-file at', _.strQuote( file.absolute ) );
    }

    let result = ca.proceedAct
    ({
      command : secondCommand,
      subject : secondSubject,
      propertiesMap : _.mapExtend( null, e.propertiesMap ),
    });

    return result;
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

  commandClean : commandClean,
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
