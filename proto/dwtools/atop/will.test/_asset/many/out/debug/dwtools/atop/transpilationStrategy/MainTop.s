( function _MainTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './MainBase.s' );
  require( './IncludeTop.s' );

}

//

let _ = wTools;
let Parent = _.TranspilationStrategy;
let Self = function wTranspilationStrategyCli( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'TranspilationStrategyCli';

// --
//
// --

let ConfigProperties =
{

  inPath : 'Path to terminal file or dirrectory with files to transpile.',
  outPath : 'Path to terminal file to store.',
  tempPath : 'Path to temporary directory to store intermediate results. Default : temp.tmp.',
  entryPath : 'Path to entry files. Files to launch among input files.',
  externalBeforePath : 'Path to external files. Files beyond input files to launch before entry files.',
  externalAfterPath : 'Path to external files. Files beyond input files to launch after entry files.',

  splittingStrategy : 'Strategy to handle multiple files. Known strategies: ManyToOne, OneToOne.',
  transpilingStrategy : 'Strategy to transpile code. Known strategies: Nop, Uglify, Babel and other. Could be combination.',

  // mapFilePath : 'Path to store map-file. Default : null.',

  debug : 'Level of debug, should be in range [ 0 .. 9 ]. Default : 0.',
  optimization : 'Level of optimization, should be in range [ 0 .. 9 ]. Default : 9.',
  minification : 'Level of minification, should be in range [ 0 .. 9 ]. Default : 5.',
  beautifing : 'Make output code readable. Default : 0',

  writingTempFiles : 'Switch on/off writing intermediate results of transpiling as temporary file. Default : 1.',
  sizeReporting : 'Switch on/off reporting of input/output/compressed size of file. Takes some extra time because of compressing. Default : 1.',
  verbosity : 'Set verbosity of the multiple.',
  v : 'Set verbosity of the multiple.',
  strategies : 'One or several strategies to use. Use .strategies.list to get list of available strategies.',

}

// --
// exec
// --

function Exec()
{
  let sys = new this.Self();
  return sys.exec();
}

//

function exec()
{
  let sys = this;

  if( !sys.formed )
  sys.form();

  _.assert( _.instanceIs( sys ) );
  _.assert( arguments.length === 0 );

  let logger = sys.logger;
  let fileProvider = sys.fileProvider;
  let appArgs = _.process.args();
  let ca = sys.commandsMake();

  return ca.appArgsPerform({ appArgs : appArgs });
}

//

function commandsMake()
{
  let sys = this;
  let logger = sys.logger;
  let fileProvider = sys.fileProvider;
  let appArgs = _.process.args();

  _.assert( _.instanceIs( sys ) );
  _.assert( arguments.length === 0 );

  let commands =
  {
    'help' :              { e : _.routineJoin( sys, sys.commandHelp ),                h : 'Get help' },
    'strategies list' :   { e : _.routineJoin( sys, sys.commandTranspilersList ),      h : 'List available strategies of transpilation' },
    'transpile' :         { e : _.routineJoin( sys, sys.commandTranspile ),                h : 'Transpile inPath file and store result at outPath' },
  }

  let ca = _.CommandsAggregator
  ({
    basePath : fileProvider.path.current(),
    commands : commands,
    commandPrefix : 'node ',
  })

  sys._commandsConfigAdd( ca );

  ca.form();

  return ca;
}

//

function commandHelp( e )
{
  let sys = this;
  let ca = e.ca;
  let fileProvider = sys.fileProvider;
  let logger = sys.logger;

  ca._commandHelp( e );

  if( !e.subject )
  debugger;
  // if( !e.subject )
  // logger.log( 'Use ' + logger.colorFormat( '"sys .help"', 'code' ) + ' to get help' );

  return sys;
}

//

function commandTranspilersList( e )
{
  let sys = this;
  let fileProvider = sys.fileProvider;
  let logger = sys.logger;

  debugger;
  logger.log( 'Available strategies' );
  logger.up();
  for( let s in sys.Transpiler )
  {
    let strategy = sys.Transpiler[ s ];
    logger.log( s, '-', strategy.name );
  }
  logger.down();

  return sys;
}

//

function commandTranspile( e )
{
  let sys = this;
  let fileProvider = sys.fileProvider;
  let path = fileProvider.path;
  let logger = sys.logger;

  e.propertiesMap.outPath = e.propertiesMap.outPath || path.current();

  _.sureMapHasOnly( e.propertiesMap, commandTranspile.commandProperties );
  _.sureBriefly( _.strIs( e.propertiesMap.inPath ), 'Expects path to file to transpile {-inPath-}' );
  _.sureBriefly( _.strIs( e.propertiesMap.outPath ), 'Expects path to file to save transpiled {-outPath-}' );

  let multiple = sys.Multiple
  ({
    sys : sys,
  });

  // sys.storageLoad(); // xxx

  _.process.argsReadTo
  ({
    dst : sys,
    only : 0,
    removing : 0,
    propertiesMap : sys.storage,
    namesMap :
    {
      'verbosity' : 'verbosity',
      'v' : 'verbosity',
    },
  });

  _.process.argsReadTo
  ({
    dst : sys,
    only : 0,
    propertiesMap : e.propertiesMap,
    namesMap :
    {
      'verbosity' : 'verbosity',
      'v' : 'verbosity',
    },
  });

  _.process.argsReadTo
  ({
    dst : multiple,
    only : 0,
    removing : 0,
    propertiesMap : sys.storage,
    namesMap :
    {
      'inPath' : 'inPath',
      'outPath' : 'outPath',
      'tempPath' : 'tempPath',
      'entryPath' : 'entryPath',
      'externalBeforePath' : 'externalBeforePath',
      'externalAfterPath' : 'externalAfterPath',

      'splittingStrategy' : 'splittingStrategy',
      'transpilingStrategy' : 'transpilingStrategy',

      'debug' : 'debug',
      'optimization' : 'optimization',
      'minification' : 'minification',
      'beautifing' : 'beautifing',
      'writingTempFiles' : 'writingTempFiles',
      'sizeReporting' : 'sizeReporting',
    },
  });

  _.process.argsReadTo
  ({
    dst : multiple,
    only : 1,
    propertiesMap : e.propertiesMap,
    namesMap :
    {
      'inPath' : 'inPath',
      'outPath' : 'outPath',
      'tempPath' : 'tempPath',
      'entryPath' : 'entryPath',
      'externalBeforePath' : 'externalBeforePath',
      'externalAfterPath' : 'externalAfterPath',

      'splittingStrategy' : 'splittingStrategy',
      'transpilingStrategy' : 'transpilingStrategy',

      'debug' : 'debug',
      'optimization' : 'optimization',
      'minification' : 'minification',
      'beautifing' : 'beautifing',
      'writingTempFiles' : 'writingTempFiles',
      'sizeReporting' : 'sizeReporting',
    },
  });

  if( !_.mapIs( multiple.inPath ) )
  multiple.inPath = { filePath : multiple.inPath }
  multiple.inPath.prefixPath = multiple.inPath.prefixPath || path.current();
  multiple.inPath.basePath = multiple.inPath.basePath || path.current();

  if( !_.mapIs( multiple.outPath ) )
  multiple.outPath = { filePath : multiple.outPath }
  multiple.outPath.prefixPath = multiple.outPath.prefixPath || path.current();
  multiple.outPath.basePath = multiple.outPath.basePath || path.current();

  multiple.verbosity = sys.verbosity;

  multiple.form();

  return multiple.perform()
  .finally( ( err, arg ) =>
  {
    if( err )
    {
      _.process.exitCode( -1 );
      _.errLogOnce( err );
    }
    multiple.finit();
    return null;
  });

}

commandTranspile.commandProperties = ConfigProperties

//

function storageIs( storage )
{
  let multiple = this;
  _.assert( arguments.length === 1 );
  if( !_.objectIs( storage ) )
  return false;
  if( !_.mapHasOnly( storage, multiple.ConfigProperties ) )
  return false;
  return true;
}

//

function storageDefaultGet()
{
  let multiple = this;
  debugger;
  return { storage : Object.create( null ) };
}

// --
// relations
// --

let Composes =
{
  storageFileName : '.wTranspStrat',
  storage : _.define.own({}),
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
  opened : 0,
}

let Statics =
{
  Exec,
  ConfigProperties,
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
  commandTranspilersList,
  commandTranspile,

  storageIs,
  storageDefaultGet,

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

// _.StateStorage.mixin( Self );
// _.StateSession.mixin( Self );
_.CommandsConfig.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
wTools[ Self.shortName ] = Self;

if( !module.parent )
Self.Exec();

})();
