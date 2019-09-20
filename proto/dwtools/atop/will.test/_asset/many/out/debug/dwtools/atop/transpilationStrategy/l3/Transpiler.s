( function _Transpiler_s_() {

'use strict';

//

let _ = wTools;
let Parent = null;
let Self = function wTsTranspilerAbstract( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Abstract';

// --
//
// --

function form( stage )
{
  let self = this;
  let sys = stage.sys;

  _.assert( !self.single );
  _.assert( !self.multiple );
  _.assert( arguments.length === 1 );
  _.assert( stage instanceof sys.Stage );
  _.assert( stage.formed === 0 );

  let result = self._formAct( stage );

  _.assert( stage.formed === 1 );
  return result;
}

//

function perform( stage )
{
  let self = this;
  let sys = stage.sys;
  let single = stage.single;
  let multiple = stage.multiple;
  let fileProvider = multiple.fileProvider;
  let path = fileProvider.path;
  let logger = multiple.logger;
  let time = _.timeNow();
  let result;

  /* verify */

  _.assert( stage.formed === 1 );
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( stage.input.data ) );
  _.assert( stage.data === null );
  _.assert( _.numberIs( stage.index ) );

  /* */

  // self.form( stage );
  _.routinesCall( self, multiple.onBegin, [ self ] );

  /* verbal */

  // if( multiple.verbosity >= 2 )
  // logger.log( ' # Transpiling ' + multiple.outputFilePath + ' with strategy ' + self.constructor.shortName );

  let Fields =
  {

    inPath : null,
    outPath : null,
    tempPath : null,
    // mapFilePath : null,

    debug : null,
    optimization : null,
    minification : null,
    beautifing : null,

    writingTempFiles : null,
    sizeReporting : null,
    strategies : null,

  }

  if( multiple.verbosity >= 5 )
  {
    let fields = _.mapOnly( multiple, Fields );
    logger.log( _.toStr( fields, { levels : 2, multiline : 1, wrap : 0 } ) );
  }

  if( multiple.verbosity >= 5 )
  {
    logger.log( 'Settings' );
    logger.log( _.toStr( stage.settings, { levels : multiple.verbosity >= 6 ? 2 : 1, wrap : 0, multiline : 1 } ) );
  }

  // if( multiple.verbosity >= 5 )
  // logger.log( 'inputFilesPaths :', _.toStr( multiple.inputFilesPaths, { levels : 2, wrap : 0, multiline : 1 } ) );

  /* */

  try
  {
    result = _.Consequence.From( self._performAct( stage ) );
  }
  catch( err )
  {
    debugger;
    let err2 = _.err( 'Error executing ', self.Self.shortName, '\n', err );
    return _.Consequence().error( err2 );
  }

  /* result */

  result
  .ifNoErrorThen( function( arg )
  {

    _.assert( stage.error === null );
    _.assert( _.strIs( stage.input.data ) );
    _.assert( _.strIs( stage.data ) );

    if( multiple.writingTempFiles )
    single.tempWrite
    ({
      filePath : path.joinNames( path.fullName( single.outPath ), '-after-', String( stage.index ), '-', self.constructor.shortName ),
      data : stage.data,
    });

    // if( multiple.verbosity >= 2 )
    // logger.log( ' # Transpiled ' + single.outPath + ' with strategy ' + self.constructor.shortName, 'in', _.timeSpent( time ) );

    _.assert( stage.formed === 2 );
    return true;
  })
  .catch( function( err )
  {
    debugger;
    err = _.err( err )
    if( !stage.error )
    stage.error = err;
    throw err;
  });

  return result;
}

//

function proceed( stage )
{
  let self = this;
  self.form( stage );
  self.perform( stage );
  return self;
}

//

function proceedThen( stage )
{
  let self = this;
  self.form( stage );
  return self.perform( stage );
}

// --
// relationships
// --

let Composes =
{
  // terminatingOnError : 0, // xxx
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

let Forbids =
{

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
  mapFilePath : 'mapFilePath',
  writingTempFiles : 'writingTempFiles',
  off : 'off',
  verbosity : 'verbosity',
  command : 'command',
  fastest : 'fastest',
  debug : 'debug',
  pretty : 'pretty',
  tempPath : 'tempPath',
  outputFilePath : 'outputFilePath',
  inputFilesPaths : 'inputFilesPaths',
  onBegin : 'onBegin',
  onEnd : 'onEnd',
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
  strategy : 'strategy',
  input : 'input',
  output : 'output',
  session : 'session',
  stage : 'stage',
  settings : 'settings',
  formed : 'formed',

}

// --
// prototype
// --

let Proto =
{

  form,
  _formAct : null,

  perform,
  _performAct : null,

  proceed,
  proceedThen,

  /* */

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Forbids,

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

_.TranspilationStrategy.Transpiler[ Self.shortName ] = Self;

})();
