( function _MainTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './MainBase.s' );
  require( './IncludeTop.s' );

}

/*
cls && local-starter .html.for builder/include/dwtools/amid/starter/processes.experiment/**
cls && local-starter .serve .
*/

//

let _ = wTools;
let Parent = _.Starter;
let Self = function wStarterCli( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'StarterCli';

// --
// exec
// --

function Exec()
{
  let starter = new this.Self();
  return starter.exec();
}

//

function exec()
{
  let starter = this;

  if( !starter.formed )
  starter.form();

  _.assert( _.instanceIs( starter ) );
  _.assert( arguments.length === 0 );

  let logger = starter.logger;
  let fileProvider = starter.fileProvider;
  let appArgs = _.process.args();
  let ca = starter.commandsMake();

  return _.Consequence
  .Try( () =>
  {
    return ca.appArgsPerform({ appArgs });
  })
  .catch( ( err ) =>
  {
    _.process.exitCode( -1 );
    return _.errLogOnce( err );
  });
}

//

function commandsMake()
{
  let starter = this;
  let logger = starter.logger;
  let fileProvider = starter.fileProvider;
  let appArgs = _.process.args();

  _.assert( _.instanceIs( starter ) );
  _.assert( arguments.length === 0 );

  let commands =
  {
    'help' :              { e : _.routineJoin( starter, starter.commandHelp ),                h : 'Get help.' },
    'imply' :             { e : _.routineJoin( starter, starter.commandImply ),               h : 'Change state or imply value of a variable.' },
    'html for' :          { e : _.routineJoin( starter, starter.commandHtmlFor ),             h : 'Generate HTML for specified files.' },
    'sources join' :      { e : _.routineJoin( starter, starter.commandSourcesJoin ),         h : 'Join source files found at specified directory.' },
    'http open' :         { e : _.routineJoin( starter, starter.commandHttpOpen ),            h : 'Run HTTP server to serve files in a specified directory.' },
    'start' :             { e : _.routineJoin( starter, starter.commandStart ),               h : 'Run executable file. By default in browser.' },
  }

  let ca = _.CommandsAggregator
  ({
    basePath : fileProvider.path.current(),
    commands : commands,
    commandPrefix : 'node ',
  })

  // starter._commandsConfigAdd( ca );

  ca.form();

  return ca;
}

//

function commandHelp( e )
{
  let starter = this;
  let ca = e.ca;
  let fileProvider = starter.fileProvider;
  let logger = starter.logger;

  ca._commandHelp( e );

  return starter;
}

//

function commandImply( e )
{
  let starter = this;
  let ca = e.ca;
  let logger = starter.logger;

  let namesMap =
  {
    v : 'verbosity',
    verbosity : 'verbosity',
  }

  let request = starter.Resolver.strRequestParse( e.argument );

  _.process.argsReadTo
  ({
    dst : starter,
    propertiesMap : request.map,
    namesMap : namesMap,
  });

}

//

function commandHtmlFor( e )
{
  let starter = this.form();
  let ca = e.ca;
  let fileProvider = starter.fileProvider;
  let path = starter.fileProvider.path;
  let logger = starter.logger;
  let request = _.strRequestParse( e.argument );

  request.subject = _.strStructureParse({ src : request.subject, parsingArrays : 1, defaultStructure : 'string' })

  let o2 = _.mapExtend( null, e.propertiesMap );
  o2.inPath = o2.inPath || request.subject;

  let html = starter.htmlFor( o2 );

  if( starter.verbosity > 3 )
  logger.log( html );

  if( starter.verbosity )
  logger.log( ' + html saved to ' + _.color.strFormat( o2.outPath, 'path' ) )

  return null;
}

commandHtmlFor.commandProperties =
{
  inPath : 'Path to files to include into HTML file to generate.',
  outPath : 'Path to save generated HTML file.',
}

//

function commandSourcesJoin( e )
{
  let starter = this.form();
  let ca = e.ca;
  let fileProvider = starter.fileProvider;
  let path = starter.fileProvider.path;
  let logger = starter.logger;
  let request = _.strRequestParse( e.argument );

  let o2 = _.mapExtend( null, e.propertiesMap );
  o2.inPath = o2.inPath || request.subject;

  if( !o2.inPath )
  throw _.errBriefly
  (
    'Please specify where to look for source file.\nFor example: '
    + _.color.strFormat( 'starter .files.wrap ./proto', 'code' )
  );

  let r = starter.sourcesJoin( o2 );

  if( starter.verbosity )
  logger.log( ' + sourcesJoin to ' + _.color.strFormat( o2.outPath, 'path' ) )

  return r;
}

commandSourcesJoin.commandProperties =
{
  inPath : 'Path to files to use for merging and wrapping.',
  outPath : 'Path to save merged file.',
}

//

function commandHttpOpen( e )
{
  let starter = this.form();
  let ca = e.ca;
  let fileProvider = starter.fileProvider;
  let path = starter.fileProvider.path;
  let logger = starter.logger;
  let request = _.strRequestParse( e.argument );

  let o2 = _.mapExtend( null, e.propertiesMap );
  o2.basePath = o2.basePath || request.subject;

  if( !o2.basePath )
  throw _.errBriefly
  (
    'Please specify what directory to serve.\nFor example: '
    + _.color.strFormat( 'starter .http.open ./proto', 'code' )
  );

  starter.httpOpen( o2 );

  return null;
}

commandHttpOpen.commandProperties =
{
  basePath : 'Path to make available over HTTP.',
  allowedPath : 'Restrict access of client-side to files in specified directory. Default : "/".',
}

//

function commandStart( e )
{
  let starter = this.form();
  let ca = e.ca;
  let fileProvider = starter.fileProvider;
  let path = starter.fileProvider.path;
  let logger = starter.logger;
  let request = _.strRequestParse( e.argument );

  let o2 = _.mapExtend( null, e.propertiesMap );
  o2.entryPath = o2.entryPath || request.subject;

  if( !o2.entryPath )
  throw _.errBriefly
  (
    'Please specify where to look for source file.\nFor example: '
    + _.color.strFormat( 'starter .start Index.js', 'code' )
  );

  starter.start( o2 );

  return null;
}

commandStart.commandProperties =
{
  entryPath : 'Path to enty source file to launch.',
  basePath : 'Path to make available over HTTP.',
  allowedPath : 'Restrict access of client-side to files in specified directory. Default : "/".',
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
}

let Restricts =
{
}

let Statics =
{
  Exec,
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

  commandsMake,
  commandHelp,
  commandImply,
  commandHtmlFor,
  commandSourcesJoin,
  commandHttpOpen,
  commandStart,

  // relations

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
wTools[ Self.shortName ] = Self;

if( !module.parent )
Self.Exec();

})();
