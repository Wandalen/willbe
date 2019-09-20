( function _CommandsAggregator_s_() {

'use strict';

/**
 * Class aggregating several applications into single CLI. It can aggregate external binary applications as well as JS functions. Use it to expose CLI.
  @module Tools/mid/CommandsAggregator
*/

/**
 * @file CommandsAggregator.s.
 */


if( typeof module !== 'undefined' )
{

  let _ = require( '../../../Tools.s' );

  _.include( 'wCopyable' );
  _.include( 'wVocabulary' );
  _.include( 'wPathBasic' );
  _.include( 'wAppBasic' );
  _.include( 'wFiles' );
  _.include( 'wVerbal' );

}

/**
 * @classdesc Class aggregating several applications into single CLI.
 * @class wCommandsAggregator
 * @memberof module:Tools/mid/CommandsAggregator
 */

//

let _ = _global_.wTools;
let Parent = null;
let Self = function wCommandsAggregator()
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'CommandsAggregator';

//

function init( o )
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  self.logger = new _.Logger({ output : _global_.logger });

  _.workpiece.initFields( self );
  Object.preventExtensions( self )

  if( o )
  self.copy( o );

  // if( self.logger === null )
  // self.logger = new _.Logger({ output : _global_.logger });

}

//

function form()
{
  let self = this;

  _.assert( !self.formed );
  _.assert( _.objectIs( self.commands ) );
  _.assert( arguments.length === 0 );

  self.basePath = _.path.resolve( self.basePath );

  if( self.supplementingByHelp && !self.commands.help )
  {
    self.commands.help = { e : self._commandHelp.bind( self ), h : 'Get help' };
  }

  self._formVocabulary();

  self.vocabulary.onPhraseDescriptorMake = self._onPhraseDescriptorMake.bind( self ),

  self.commandsAdd( self.commands );

  self.formed = 1;
  return self;
}

//

function _formVocabulary()
{
  let self = this;
  _.assert( arguments.length === 0 );
  self.vocabulary = self.vocabulary || _.Vocabulary();
  self.vocabulary.addingDelimeter = self.addingDelimeter;
  self.vocabulary.lookingDelimeter = self.lookingDelimeter;
}

//

/**
 * @summary Reads app arguments and performs specified commands.
 * @function exec
 * @memberof module:Tools/mid/CommandsAggregator.wCommandsAggregator#
 */

function exec()
{
  let self = this;
  let appArgs = _.process.args();
  return self.appArgsPerform({ appArgs : appArgs });
}

//

/**
 * @summary Normalizes application arguments.
 * @description
 * Checks if arguments object doesn't have redundant fields.
 * Supplements object with missing fields.
 * @param {Object} appArgs Application arguments.
 * @function appArgsNormalize
 * @memberof module:Tools/mid/CommandsAggregator.wCommandsAggregator#
 */

function appArgsNormalize( appArgs )
{
  let self = this;

  _.mapSupplement( appArgs, appArgsNormalize.defaults );
  _.assertMapHasOnly( appArgs, appArgsNormalize.defaults );

  appArgs.map = appArgs.map || Object.create( null );

  if( !appArgs.subjects )
  appArgs.subjects = _.strIs( appArgs.subject ) ? [ appArgs.subject ] : [];

  if( !appArgs.maps )
  appArgs.maps = _.mapIs( appArgs.map ) ? [ appArgs.map ] : [];

  return appArgs;
}

appArgsNormalize.defaults =
{
  subject : null,
  subjects : null,
  map : null,
  maps : null,
  interpreterPath : null,
  mainPath : null,
  interpreterArgs : null,
  scriptArgs : null,
  scriptString : null,

  keyValDelimeter : null,
  cmmandsDelimeter : null,

}

//

/**
 * @summary Reads provided application arguments and performs specified commands.
 * @description Parses application arguments if they were not provided through options.
 * @param {Object} o Options map.
 * @param {Object} o.appArgs Parsed arguments.
 * @param {Boolean} [o.printingEcho=1] Print command before execution.
 * @param {Boolean} [o.allowingDotless=0] Allows to provide command without dot at the beginning.
 * @function appArgsPerform
 * @memberof module:Tools/mid/CommandsAggregator.wCommandsAggregator#
 */

function appArgsPerform( o )
{
  let self = this;

  _.assert( _.instanceIs( self ) );
  _.assert( !!self.formed );
  _.assert( arguments.length === 1 );
  _.routineOptions( appArgsPerform, o );

  if( o.appArgs === null )
  o.appArgs = _.process.args();
  o.appArgs = self.appArgsNormalize( o.appArgs );

  _.assert( _.arrayIs( o.appArgs.subjects ) );
  _.assert( _.arrayIs( o.appArgs.maps ) );

  /* */

  if( !o.allowingDotless )
  if( !_.strBegins( o.appArgs.subject, '.' ) || _.strBegins( o.appArgs.subject, './' ) || _.strBegins( o.appArgs.subject, '.\\' ) )
  {
    self.onSyntaxError( o );
    // self.logger.error( 'Illformed request', self.logger.colorFormat( _.strQuote( o.appArgs.subject ), 'code' ) );
    // self.onGetHelp();
    return null;
  }

  if( o.printingEcho )
  {
    self.logger.rbegin({ verbosity : -1 });
    self.logger.log( 'Command', self.logger.colorFormat( _.strQuote( o.appArgs.subjects.join( ' ; ' ) ), 'code' ) );
    self.logger.rend({ verbosity : -1 });
  }

  /* */

  return self.commandsPerform
  ({
    commands : o.appArgs.subjects,
    propertiesMaps : o.appArgs.maps,
  });

}

appArgsPerform.defaults =
{
  printingEcho : 1,
  allowingDotless : 0,
  appArgs : null,
}

//

/**
 * @summary Perfroms requested command(s) one by one.
 * @description Multiple commands in one string should be separated by semicolon.
 * @param {Object} o Options map.
 * @param {Array|String} o.commands Command(s) to execute.
 * @param {Array} o.propertiesMaps Array of maps with options for commands.
 * @function commandsPerform
 * @memberof module:Tools/mid/CommandsAggregator.wCommandsAggregator#
 */

function commandsPerform( o )
{
  let self = this;
  let con = new _.Consequence().take( null );
  let commands = [];

  if( _.strIs( o ) || _.arrayIs( o ) )
  o = { commands : o };

  _.routineOptions( commandsPerform, o );
  _.assert( _.strIs( o.commands ) || _.arrayIs( o.commands ) );
  _.assert( !!self.formed );
  _.assert( arguments.length === 1 );

  o.commands = _.arrayFlatten( null, _.arrayAs( o.commands ) );

  if( o.propertiesMaps === null || o.propertiesMaps.length === 0 )
  {
    o.propertiesMaps = _.dup( Object.create( null ), o.commands.length );
  }
  else
  {
    o.propertiesMaps = _.arrayFlatten( null, _.arrayAs( o.propertiesMaps ) );
  }

  for( let c = 0 ; c < o.commands.length ; c++ )
  {
    let command = o.commands[ c ];
    _.arrayAppendArray( commands, _.strSplitNonPreserving( command, ';' ) );
  }

  o.commands = _.arrayFlatten( null, commands );

  _.assert( o.commands.length === o.propertiesMaps.length );
  _.assert( o.commands.length !== 0, 'not tested' );

  for( let c = 0 ; c < o.commands.length ; c++ )
  {
    let command = o.commands[ c ];
    _.assert( command.trim() === command );
    con.then( () => self.commandPerform
    ({
      command : command,
      propertiesMap : o.propertiesMaps[ c ],
    }));
  }

  return con.syncMaybe();
}

commandsPerform.defaults =
{
  commands : null,
  propertiesMaps : null,
}

//

/**
 * @summary Perfroms requested command.
 * @param {Object} o Options map.
 * @param {String} o.command Command to execute.
 * @param {Array} o.propertiesMap Options for provided command.
 * @function commandPerform
 * @memberof module:Tools/mid/CommandsAggregator.wCommandsAggregator#
 */

function commandPerform( o )
{
  let self = this;

  if( _.strIs( o ) || _.arrayIs( o ) )
  o = { command : o };

  _.routineOptions( commandPerform, o );
  _.assert( _.strIs( o.command ) );
  _.assert( !!self.formed );
  _.assert( arguments.length === 1 );

  let splits = _.strIsolateLeftOrAll( o.command, ' ' );
  let subject = splits[ 0 ];
  let argument = splits[ 2 ];

  o.propertiesMap = o.propertiesMap || Object.create( null );

  /* */

  let result = self.commandPerformParsed
  ({
    command : o.command,
    subject : subject,
    argument : argument,
    propertiesMap : o.propertiesMap,
  });

  return result;
}

commandPerform.defaults =
{
  command : null,
  propertiesMap : null,
}

//

/**
 * @descriptionNeeded
 * @param {Object} o Options map.
 * @param {String} o.command Command to execute.
 * @param {String} o.subject
 * @param {String} o.argument
 * @param {Array} o.propertiesMap Options for provided command.
 * @function commandPerformParsed
 * @memberof module:Tools/mid/CommandsAggregator.wCommandsAggregator#
 */

function commandPerformParsed( o )
{
  let self = this;
  let result;

  _.routineOptions( commandPerformParsed, o );
  _.assert( _.strIs( o.command ) );
  _.assert( _.strIs( o.subject ) );
  _.assert( _.strIs( o.argument ) );
  _.assert( o.propertiesMap === null || _.objectIs( o.propertiesMap ) );
  _.assert( _.instanceIs( self ) );
  _.assert( !!self.formed );
  _.assert( arguments.length === 1 );

  o.propertiesMap = o.propertiesMap || Object.create( null );

  /* */

  let subjectDescriptors = self.vocabulary.subjectDescriptorFor( o.subject );
  let filteredSubjectDescriptors;

  /* */

  if( !subjectDescriptors.length )
  {
    self.onUnknownCommandError( o );
    // let s = 'Unknown command ' + _.strQuote( o.subject );
    // if( self.vocabulary.descriptorMap[ 'help' ] )
    // s += '\nTry ".help"';
    // throw _.errBrief( s );
    return null;
  }
  else
  {
    filteredSubjectDescriptors = self.vocabulary.subjectsFilter( subjectDescriptors, { wholePhrase : o.subject } );
    if( filteredSubjectDescriptors.length !== 1 )
    {
      let e = _.mapExtend( null, o );
      e.filteredSubjectDescriptors = filteredSubjectDescriptors;
      self.onAmbiguity( e );
      // self.logger.log( 'Ambiguity. Did you mean?' );
      // self.logger.log( self.vocabulary.helpForSubjectAsString( o.subject ) );
      // self.logger.log( '' );
    }
    if( filteredSubjectDescriptors.length !== 1 )
    return null;
  }

  /* */

  let subjectDescriptor = filteredSubjectDescriptors[ 0 ];
  let executable = subjectDescriptor.phraseDescriptor.executable;
  if( _.routineIs( executable ) )
  {
    result = executable
    ({
      command : o.command,
      subject : o.subject,
      argument : o.argument,
      propertiesMap : o.propertiesMap,
      ca : self,
      subjectDescriptor : subjectDescriptor,
    });
  }
  else
  {
    executable = _.path.nativize( executable );
    let mapStr = _.strJoinMap({ src : o.propertiesMap });
    let execPath = self.commandPrefix + executable + ' ' + o.subject + ' ' + mapStr;
    let o2 = Object.create( null );
    o2.execPath = execPath;
    result = _.process.start( o2 );
  }

  if( result === undefined )
  result = null;

  return result;
}

commandPerformParsed.defaults =
{

  command : null,
  subject : null,
  argument : null,
  propertiesMap : null,

}

//

/**
 * @summary Adds commands to the vocabulary.
 * @param {Array} commands Array with commands to add.
 * @function commandsAdd
 * @memberof module:Tools/mid/CommandsAggregator.wCommandsAggregator#
*/

function commandsAdd( commands )
{
  let self = this;

  _.assert( !self.formed );
  _.assert( arguments.length === 1 );

  self._formVocabulary();

  self.vocabulary.phrasesAdd( commands );

  return self;
}

//

/**
 * @summary Separates second command from provided string.
 * @param {String} command Commands string to parse.
 * @function commandIsolateSecondFromArgument
 * @memberof module:Tools/mid/CommandsAggregator.wCommandsAggregator#
*/

function commandIsolateSecondFromArgument( command )
{
  let ca = this;
  let result = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( command ) );

  [ result.argument, result.secondSubject, result.secondArgument  ] = _.strIsolateRightOrAll( command, /\s+\.\w[^ ]*\s*/ );

  if( !result.secondSubject )
  return null;

  result.secondSubject = result.secondSubject.trim();
  result.secondCommand = result.secondSubject + ' ' + result.secondArgument;

  return result;
}

//

function commandIsolateSecondFromArgumentDeprecated( subject )
{
  let ca = this;
  let result = Object.create( null );

  _.assert( arguments.length === 1 );

  [ result.subject, result.del1, result.secondCommand  ] = _.strIsolateLeftOrAll( subject, ' ' );
  [ result.secondCommand, result.del2, result.secondSubject  ] = _.strIsolateLeftOrAll( result.secondCommand, ' ' );

  return result;
}

//

/*
  .help - Prints list of available commands with description
  .help subject
    - Exact match - Prints description of command and properties.
    - Partial match - Prints list of commands that have provided subject.
    - No match - Prints No command found.
*/

function _commandHelp( e )
{
  let self = this;
  let ca = e.ca;
  let logger = self.logger || ca.logger || _global_.logger;

  if( e.argument )
  {
    logger.log();
    logger.log( e.ca.vocabulary.helpForSubjectAsString( e.argument ) );
    logger.up();

    let subject = e.ca.vocabulary.subjectDescriptorFor({ phrase : e.argument, exact : 1 });

    if( !subject )
    {
      logger.log( 'No command', e.argument );
    }
    else
    {
      debugger;
      if( subject.phraseDescriptor.executable && subject.phraseDescriptor.executable.commandProperties )
      {
        let properties = subject.phraseDescriptor.executable.commandProperties;
        logger.log( _.toStr( properties, { levels : 2, wrap : 0, multiline : 1, wrap : 0, stringWrapper : '' } ) );
      }
    }

    logger.down();
    logger.log();

  }
  else
  {

    logger.log();
    logger.log( e.ca.vocabulary.helpForSubjectAsString( '' ) );
    logger.log();

  }

  return self;
}

//

function onAmbiguity( o )
{
  let self = this;
  /* qqq : cover the case. check appExitCode. test should use _.process.start to launch app */
  _.process.exitCode( -1 );

  self.logger.log( 'Ambiguity. Did you mean?' );
  self.logger.log( self.vocabulary.helpForSubjectAsString( o.subject ) );
  self.logger.log( '' );

}

onAmbiguity.defaults = Object.create( appArgsPerform.defaults );

//

function onUnknownCommandError( o )
{
  let self = this;
  /* qqq : cover the case. check appExitCode. test should use _.process.start to launch app */
  _.process.exitCode( -1 );
  let s = 'Unknown command ' + _.strQuote( o.subject );
  if( self.vocabulary.descriptorMap[ 'help' ] )
  s += '\nTry ".help"';
  throw _.errBrief( s );
}

onUnknownCommandError.defaults = Object.create( commandPerformParsed.defaults );

//

function onSyntaxError( o )
{
  let self = this;
  /* qqq : cover the case. check appExitCode. test should use _.process.start to launch app */
  _.process.exitCode( -1 );
  self.logger.error( 'Illformed command', self.logger.colorFormat( _.strQuote( o.appArgs.subject ), 'code' ) );
  self.onGetHelp();
}

onSyntaxError.defaults = Object.create( appArgsPerform.defaults );

//

function onGetHelp()
{
  let self = this;

  _.assert( arguments.length === 0 );

  if( self.vocabulary.subjectDescriptorFor( '.help' ).length )
  {
    self.commandPerform({ command : '.help' });
  }
  else
  {
    self._commandHelp({ ca : self });
  }

}

//

function onPrintCommands()
{
  let self = this;

  _.assert( arguments.length === 0 );

  self.logger.log();
  self.logger.log( self.vocabulary.helpForSubjectAsString( '' ) );
  self.logger.log();

}

//

function _onPhraseDescriptorMake( src )
{

  _.assert(  _.strIs( src ) || _.arrayIs( src ) );
  _.assert( arguments.length === 1 );

  let self = this;
  let result = Object.create( null );
  let phrase = src;
  let executable = null;

  if( phrase )
  {
    _.assert( phrase.length === 2 );
    executable = phrase[ 1 ];
    phrase = phrase[ 0 ];
  }

  let hint = phrase;

  if( _.objectIs( executable ) )
  {
    _.assertMapHasOnly( executable, { e : null, h : null } );
    hint = executable.h;
    executable = executable.e;
  }

  result.phrase = phrase;
  result.hint = hint;

  if( _.routineIs( executable ) )
  {
    result.executable = executable;
  }
  else
  {
    result.executable = _.path.resolve( self.basePath, executable );
    _.sure( !!_.fileProvider.statResolvedRead( result.executable ), () => 'Application not found at ' + _.strQuote( result.executable ) );
  }

  return result;
}

// --
//
// --

let Composes =
{
  basePath : null,
  commandPrefix : '',
  addingDelimeter : ' ',
  lookingDelimeter : _.define.own([ '.' ]),
  complexSyntax : 0,
  supplementingByHelp : 1,
}

let Aggregates =
{
  onSyntaxError,
  onAmbiguity,
  onUnknownCommandError,
  onGetHelp,
  onPrintCommands,
}

let Associates =
{
  logger : null,
  commands : null,
  vocabulary : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
}

let Forbids =
{
}

let Accessors =
{
}

let Medials =
{
}

// --
// prototype
// --

let Extend =
{

  init,
  form,
  _formVocabulary,
  exec,

  appArgsNormalize,
  appArgsPerform,

  commandsPerform,
  commandPerform,
  commandPerformParsed,

  commandsAdd,

  commandIsolateSecondFromArgument,
  commandIsolateSecondFromArgumentDeprecated,

  _commandHelp,

  onSyntaxError,
  onAmbiguity,
  onGetHelp,
  onPrintCommands,
  _onPhraseDescriptorMake,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Medials,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );
_.Verbal.mixin( Self );

//

_[ Self.shortName ] = Self;
if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
