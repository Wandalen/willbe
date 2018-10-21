( function _MainTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wIm( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Im';

// --
// inter
// --

function finit()
{
  if( this.formed )
  this.unform();
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let im = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( im );
  Object.preventExtensions( im );

  if( o )
  im.copy( o );

}

//

function unform()
{
  let im = this;

  _.assert( arguments.length === 0 );
  _.assert( !!im.formed );

  /* begin */

  /* end */

  im.formed = 0;
  return im;
}

//

function form()
{
  let im = this;

  im.formAssociates();

  _.assert( arguments.length === 0 );
  _.assert( !im.formed );

  /* begin */

  /* end */

  im.formed = 1;
  return im;
}

//

function formAssociates()
{
  let im = this;
  let logger = im.logger;

  _.assert( arguments.length === 0 );
  _.assert( !im.formed );

  if( !im.logger )
  logger = im.logger = new _.Logger({ output : _global_.logger });

  if( !im.fileProvider )
  im.fileProvider = _.FileProvider.Default();

  if( !im.filesGraph )
  im.filesGraph = _.FilesGraph({ fileProvider : im.fileProvider });

}

// --
// exec
// --

function Exec()
{
  let im = new this.Self();
  return im.exec();
}

//

function exec()
{
  let im = this;

  im.formAssociates();

  _.assert( _.instanceIs( im ) );
  _.assert( arguments.length === 0 );

  let logger = im.logger;
  let fileProvider = im.fileProvider;
  let appArgs = _.appArgs();
  let ca = im.commandsMake();

  return ca.proceedApplicationArguments({ appArgs : appArgs });
}

//

function commandsMake()
{
  let im = this;
  let logger = im.logger;
  let fileProvider = im.fileProvider;
  let appArgs = _.appArgs();

  _.assert( _.instanceIs( im ) );
  _.assert( arguments.length === 0 );

  let commands =
  {

    'help' :              { e : _.routineJoin( im, im.commandHelp ),              h : 'Get help.' },

    'list' :              { e : _.routineJoin( im, im.commandList ),              h : 'List information about the current module.' },
    'reflectors list' :   { e : _.routineJoin( im, im.commandReflectorsList ),    h : 'List avaialable reflectors.' },
    'steps list' :        { e : _.routineJoin( im, im.commandStepsList ),         h : 'List avaialable steps.' },
    'builds list' :       { e : _.routineJoin( im, im.commandBuildsList ),        h : 'List avaialable builds.' },

    'exports list' :      { e : _.routineJoin( im, im.commandExportsList ),       h : 'List avaialable exports.' },
    'about list' :        { e : _.routineJoin( im, im.commandAboutList ),         h : 'List descriptive information about the module.' },
    'execution list' :    { e : _.routineJoin( im, im.commandExecutionList ),     h : 'List execution scenarios.' },
    'link list' :         { e : _.routineJoin( im, im.commandLinkList ),          h : 'List links to resources associated with the module.' },

    'build' :             { e : _.routineJoin( im, im.commandBuild ),             h : 'Build current module with spesified settings.' },
    'export' :            { e : _.routineJoin( im, im.commandExport ),            h : 'Export selected the module with spesified settings. Save output to output file and archive.' },

  }

  var ca = _.CommandsAggregator
  ({
    basePath : fileProvider.path.current(),
    commands : commands,
    commandPrefix : 'node ',
  })

  //im._commandsConfigAdd( ca );

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
    logger.log( 'Use ' + logger.colorFormat( '"im .help"', 'code' ) + ' to get help' );
  }

}

//
//
// function commandHelp( e )
// {
//   let im = this;
//   let fileProvider = im.fileProvider;
//   let logger = im.logger;
//
//   logger.log();
//   logger.log( e.ca.vocabulary.helpForSubjectAsString( '' ) );
//   logger.log();
//
//   //logger.log( 'Use ' + logger.colorFormat( '"im .init confPath:./conf" actionsPath:./actions', 'code' ) + ' to init the module' );
//   logger.log( 'Use ' + logger.colorFormat( '"im .help"', 'code' ) + ' to get help' );
//   // logger.log( 'Use ' + logger.colorFormat( '"im"', 'code' ) + '' );
//
//   return im;
// }

//

function _commandList( e, act )
{
  let im = this;

  _.assert( arguments.length === 2 );

  if( !im.formed )
  im.form();

  let logger = im.logger;
  let fileProvider = im.fileProvider;
  let dirPath = fileProvider.path.current();
  let module = im.Module({ im : im, dirPath : dirPath }).form();

  new im.InFile
  ({
    role : 'import',
    module : module,
  }).form();

  new im.InFile
  ({
    role : 'export',
    module : module,
  }).form1();

  if( module.inFileWithRoleMap.export.exists() )
  module.inFileWithRoleMap.export.form2();
  else
  module.inFileWithRoleMap.export.finit();

  act( module );

  module.finit();

  return im;
}

//

function commandList( e )
{
  let im = this;

  function act( module )
  {
    logger.log( module.info() );
  }

  im._commandList( e, act );

  return im;
}

//

function commandReflectorsList( e )
{
  let im = this;

  function act( module )
  {
    logger.log( module.infoForReflectors() );
  }

  im._commandList( e, act );

  return im;
}

//

function commandStepsList( e )
{
  let im = this;

  function act( module )
  {
    logger.log( module.infoForSteps() );
  }

  im._commandList( e, act );

  return im;
}

//

function commandBuildsList( e )
{
  let im = this;

  function act( module )
  {
    logger.log( module.infoForBuilds( module.buildsFor( e.subject, e.propertiesMap ) ) );
  }

  im._commandList( e, act );

  return im;
}

//

function commandExportsList( e )
{
  let im = this;

  function act( module )
  {
    logger.log( module.infoForExports( module.exportsFor( e.subject, e.propertiesMap ) ) );
  }

  im._commandList( e, act );

  return im;
}

//

function commandAboutList( e )
{
  let im = this;

  function act( module )
  {
    logger.log( module.about.info() );
  }

  im._commandList( e, act );

  return im;
}

//

function commandExecutionList( e )
{
  let im = this;

  function act( module )
  {
    logger.log( module.execution.info() );
  }

  im._commandList( e, act );

  return im;
}

//

function commandLinkList( e )
{
  let im = this;

  function act( module )
  {
    logger.log( module.link.info() );
  }

  im._commandList( e, act );

  return im;
}

//

function commandBuild( e )
{
  let im = this;

  if( !im.formed )
  im.form();

  let fileProvider = im.fileProvider;
  let logger = im.logger;
  let dirPath = fileProvider.path.current();
  let module = im.Module({ im : im, dirPath : dirPath }).form();

  new im.InFile
  ({
    role : 'import',
    module : module,
  }).form();

  let builds = module.buildsFor( e.subject, e.propertiesMap );

  logger.log( module.infoForBuilds( builds ) );

  if( builds.length !== 1 )
  {
    if( builds.length === 0 )
    throw _.errBriefly( 'To build please specify exactly one build, none satisfies passed arguments' );
    throw _.errBriefly( 'To build please specify exactly one build' );
  }

  let run = new im.BuildRun({ module : module }).form();

  return run.run( builds[ 0 ] )
  .doThen( ( err ) =>
  {
    run.finit();
    module.finit();
    if( err )
    throw _.errLogOnce( err );
  });
}

//

function commandExport( e )
{
  let im = this;

  if( !im.formed )
  im.form();

  let fileProvider = im.fileProvider;
  let logger = im.logger;
  let dirPath = fileProvider.path.current();
  let module = im.Module({ im : im, dirPath : dirPath }).form();

  new im.InFile
  ({
    role : 'import',
    module : module,
  }).form();

  new im.InFile
  ({
    role : 'export',
    module : module,
  }).form();

  let exports = module.exportsFor( e.subject, e.propertiesMap );

  logger.log( module.infoForBuilds( exports ) );

  if( exports.length !== 1 )
  {
    if( exports.length === 0 )
    throw _.errBriefly( 'To export please specify exactly one export, none satisfies passed arguments' );
    throw _.errBriefly( 'To export please specify exactly one export' );
  }

  // let run = new im.ExportRun({ module : module }).form();
  //
  // return run.run( exports[ 0 ] )
  // .doThen( ( err ) =>
  // {
  //   run.finit();
  //   if( err )
  //   throw _.errLogOnce( err );
  // });

  let expf = new im.OutFile({ module : module, export : exports[ 0 ] });

  return expf.form()
  .doThen( ( err ) =>
  {
    expf.finit();
    module.finit();
    if( err )
    throw _.errLogOnce( err );
  });

}

// --
// relations
// --

let Composes =
{
  verbosity : 3,
}

let Aggregates =
{
}

let Associates =
{

  fileProvider : null,
  filesGraph : null,
  logger : null,

  moduleArray : _.define.own([]),

}

let Restricts =
{
  formed : 0,
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

let Proto =
{

  // inter

  finit : finit,
  init : init,
  unform : unform,
  form : form,
  formAssociates : formAssociates,

  // exec

  Exec : Exec,
  exec : exec,

  commandsMake : commandsMake,
  commandHelp : commandHelp,

  _commandList : _commandList,
  commandList : commandList,
  commandReflectorsList : commandReflectorsList,
  commandStepsList : commandStepsList,
  commandBuildsList : commandBuildsList,
  commandExportsList : commandExportsList,

  commandAboutList : commandAboutList,
  commandExecutionList : commandExecutionList,
  commandLinkList : commandLinkList,

  commandBuild : commandBuild,
  commandExport : commandExport,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );
//_.EventHandler.mixin( Self );
//_.Instancing.mixin( Self );
// _.StateStorage.mixin( Self );
// _.StateSession.mixin( Self );
// _.CommandsConfig.mixin( Self );
_.Verbal.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = wTools;
_global_[ Self.name ] = wTools[ Self.shortName ] = Self;

if( typeof module !== 'undefined' )
{

  require( './IncludeTop.s' );

}

if( !module.parent )
Self.Exec();

})();
