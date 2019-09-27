( function _Stage_s_() {

'use strict';

let Zlib;

//

let _ = wTools;
let Parent = null;
let Self = function wTsStage( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Stage';

// --
// inter
// --

function finit()
{
  let stage = this;
  Parent.prototype.finit.call( stage );
}

//

function init( o )
{
  let stage = this;
  _.Copyable.prototype.init.call( stage, o );
  Object.preventExtensions( stage );
}

//

function outputMake( o )
{
  let stage = this;

  _.assert( stage.output === null );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  stage.output = stage.clone();
  stage.output.data = null;
  stage.output.rawData = null;
  stage.output.index += 1;
  stage.output.input = stage;
  stage.output.isFirst = false;

  if( o )
  _.mapExtend( stage.output, o )

  return stage.output;
}

//

function errorHandle( err )
{
  let stage = this;
  let result = null;

  debugger;

  let code = '';
  let line = err.line;
  if( err.location && line === undefined )
  line = err.location.line;

  if( _.numberIs( line ) && stage.input.data )
  {
    code = _.strLinesSelect
    ({
      src : stage.input.data,
      line : line,
      number : 1,
    });
  }

  err = _.errLogOnce( '--\n' + code + '\n--\n', err );

  // if( self.terminatingOnError ) // xxx
  // _.process.exitWithBeep( -1 );

  if( !stage.error )
  stage.error = err;

  return err;
}

// --
// relationships
// --

let Composes =
{

  index : null,
  isFirst : false,
  isLast : false,

}

let Aggregates =
{

}

let Associates =
{

  sys : null,
  multiple : null,
  single : null,
  input : null,
  output : null,
  strategy : null,

  error : null,
  data :  null,
  rawData : null,
  sourceMap : null,
  settings : null,

}

let Restricts =
{
  formed : 0,
}

let Forbids =
{

  inputFilesPaths : 'inputFilesPaths',
  outputFilePath : 'outputFilePath',
  command : 'command',
  fileReport : 'fileReport',
  separateProcess : 'separateProcess',
  silent : 'silent',
  fastest : 'fastest',
  pretty : 'pretty',
  _options : '_options',
  outputFilesPath : 'outputFilesPath',
  infoEnabled : 'infoEnabled',
  off : 'off',
  settings : 'settings',
  minimization : 'minimization',
  usingBabel : 'usingBabel',
  settingsOfBabel : 'settingsOfBabel',
  usingButternut : 'usingButternut',
  settingsOfButternut : 'settingsOfButternut',
  usingBabili : 'usingBabili',
  settingsOfBabili : 'settingsOfBabili',
  usingPrepack : 'usingPrepack',
  settingsOfPrepack : 'settingsOfPrepack',
  usingClosure : 'usingClosure',
  settingsOfClosure : 'settingsOfClosure',
  usingUglify : 'usingUglify',
  settingsOfUglify : 'settingsOfUglify',
  transpiler : 'transpiler',
  strategies : 'strategies',
  fileProvider : 'fileProvider',
  logger : 'logger',
  debug : 'debug',
  optimization : 'optimization',
  minification : 'minification',
  beautifing : 'beautifing',
  writingTempFiles : 'writingTempFiles',
  sizeReporting : 'sizeReporting',
  inPath : 'inPath',
  outPath : 'outPath',
  tempPath : 'temp.tmp',
  mapFilePath : 'mapFilePath',
  verbosity : 'verbosity',
  onBegin : 'onBegin',
  onEnd : 'onEnd',
  session : 'session',

}

let Accessors =
{
}

// --
// prototype
// --

let Proto =
{

  finit,
  init,

  outputMake,
  errorHandle,

  /* */

  Composes,
  Aggregates,
  Associates,
  Restricts,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.staticDeclare
({
  prototype : _.TranspilationStrategy.prototype,
  name : Self.shortName,
  value : Self,
});

})();
