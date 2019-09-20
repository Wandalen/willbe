( function _CommandsAggregator_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../Tools.s' );

  _.include( 'wTesting' );

  require( '../../l7/commands/CommandsAggregator.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
//
// --

function trivial( test )
{

  var done = 0;
  function execCommand1( e )
  {
    done = 1;
    console.log( 'execCommand1' );
  }

  var Commands =
  {
    'action1' : { e : execCommand1, h : 'Some action' },
    'action2' : 'Action2.s',
    'action3' : 'Action3.s',
  }

  var ca = _.CommandsAggregator
  ({
    basePath : __dirname,
    commands : Commands,
    commandPrefix : 'node ',
  }).form();

  var appArgs = Object.create( null );
  appArgs.subject = 'action1';
  appArgs.map = { action1 : true };
  appArgs.maps = [ appArgs.map ];
  appArgs.subjects = [ 'action1' ];
  done = 0;
  ca.appArgsPerform({ appArgs : appArgs, allowingDotless : 1 });
  test.identical( done, 1 );

  var appArgs = Object.create( null );
  appArgs.subject = 'help';
  appArgs.map = { help : true };
  appArgs.maps = [ appArgs.map ];
  appArgs.subjects = [ 'help' ];
  ca.appArgsPerform({ appArgs : appArgs, allowingDotless : 1 });
  test.identical( done, 1 );

  var appArgs = Object.create( null );
  appArgs.map = { action2 : true };
  appArgs.maps = [ appArgs.map ];
  appArgs.subject = 'action2';
  appArgs.subjects = [ 'action2' ];

  return ca.appArgsPerform({ appArgs : appArgs, allowingDotless : 1 })
  .finally( function( err, arg )
  {
    test.is( !err );
    test.is( !!arg );
    var appArgs = Object.create( null );
    appArgs.map = { '.action3' : true };
    appArgs.maps = [ appArgs.map ];
    appArgs.subject = '.action3';
    appArgs.subjects = [ '.action3' ];
    return ca.appArgsPerform({ appArgs : appArgs });
  })

  return result;
}

//

function perform( test )
{

  function commandWith( e )
  {

    test.description = 'integrity of the first event';
    test.identical( e.command, '.with path to dir .list all' );
    test.identical( e.subject, '.with' );
    test.identical( e.argument, 'path to dir .list all' );
    test.is( e.ca === ca );
    test.is( _.objectIs( e.subjectDescriptor ) );
    test.identical( e.subjectDescriptor.wholePhrase, 'with' );

    test.description = 'second command';
    let isolated = ca.commandIsolateSecondFromArgument( e.argument );
    test.identical( isolated.argument, 'path to dir' );
    test.identical( isolated.secondCommand, '.list all' );
    test.identical( isolated.secondSubject, '.list' );
    test.identical( isolated.secondArgument, 'all' );

    done = 1;

    e.ca.commandPerform
    ({
      command : isolated.secondCommand,
      propertiesMap : e.propertiesMap,
    });

  }

  function commandList( e )
  {
    let ca = e.ca;

    test.description = 'integrity of the second event';
    test.identical( e.command, '.list all' );
    test.identical( e.subject, '.list' );
    test.identical( e.argument, 'all' );
    test.is( e.ca === ca );
    test.is( _.objectIs( e.subjectDescriptor ) );
    test.identical( e.subjectDescriptor.wholePhrase, 'list' );

    done = 2;
  }

  var Commands =
  {
    'with' : { e : commandWith, h : 'With' },
    'list' : { e : commandList, h : 'List' },
  }

  var ca = _.CommandsAggregator
  ({
    commands : Commands,
    complexSyntax : 0,
  }).form();

  /* */

  test.case = 'appArgsPerform';
  var appArgs = Object.create( null );
  appArgs.subject = '.with path to dir .list all';
  done = 0;
  ca.appArgsPerform({ appArgs : appArgs });
  test.identical( done, 2 );

  /* */

  test.case = 'commandsPerform with empty propertiesMaps';
  done = 0;
  ca.commandsPerform
  ({
    commands : '.with path to dir .list all',
    propertiesMaps : {},
  });
  test.identical( done, 2 );

  /* */

  test.case = 'commandsPerform without propertiesMaps';
  done = 0;
  ca.commandsPerform
  ({
    commands : '.with path to dir .list all',
  });
  test.identical( done, 2 );

  /* */

  test.case = 'commandsPerform with string';
  done = 0;
  ca.commandsPerform( '.with path to dir .list all' );
  test.identical( done, 2 );

  /* */

  test.case = 'commandPerform with empty properties map';
  var done = 0;
  ca.commandPerform
  ({
    command : '.with path to dir .list all',
    propertiesMap : Object.create( null ),
  });
  test.identical( done, 2 );

  /* */

  test.case = 'commandPerform without peroperties map';
  var done = 0;
  ca.commandPerform
  ({
    command : '.with path to dir .list all',
  });
  test.identical( done, 2 );

  /* */

  test.case = 'commandPerform with string';
  var done = 0;
  ca.commandPerform( '.with path to dir .list all' );
  test.identical( done, 2 );

  /* */

  test.case = 'commandPerformParsed';
  var done = 0;
  ca.commandPerformParsed
  ({
    command : '.with path to dir .list all',
    subject : '.with',
    argument : 'path to dir .list all',
  });
  test.identical( done, 2 );

}

//

function commandIsolateSecondFromArgument( test )
{

  var Commands =
  {
  }

  var ca = _.CommandsAggregator
  ({
    commands : Commands,
  }).form();

  test.case = 'with dot';
  var expected =
  {
    'argument' : '.module',
    'secondSubject' : '.shell',
    'secondArgument' : 'git status',
    'secondCommand' : '.shell git status',
  }
  var got = ca.commandIsolateSecondFromArgument( '.module .shell git status' );
  test.identical( got, expected );

  test.case = 'no second';
  var expected = null;
  var got = ca.commandIsolateSecondFromArgument( 'module git status' );
  test.identical( got, expected );

  test.case = 'quoted doted argument';
  var expected = null;
  var got = ca.commandIsolateSecondFromArgument( '".module" git status' );
  test.identical( got, expected );

}

//

function help( test )
{
  let execCommand = () => {};
  let commandHelp = ( e ) => e.ca._commandHelp( e );

  var Commands =
  {
    'help' : { e : commandHelp, h : 'Get help.' },
    'action' : { e : execCommand, h :'action' },
    'action first' : { e : execCommand, h :'action first' },
  }

  let got = '';

  function onTransformEnd( o )
  {
    got += o.outputForTerminal[ 0 ];
  };

  let logger = new _.Logger({ output : console, onTransformEnd : onTransformEnd, outputRaw : 1 })

  var ca = _.CommandsAggregator
  ({
    commands : Commands,
    logger : logger,
  }).form();


  test.case = 'trivial help'
  got = '';
  ca.commandPerform({ command : '.help' });
  var expected =
  `  .help - Get help.
  .action - action
  .action.first - action first`
  test.identical( got, expected );

  test.case = 'exact dotless'
  got = '';
  ca.commandPerform({ command : '.help action' });
  var expected = '  .action - action';
  test.identical( got, expected );

  test.case = 'exact with dot'
  got = '';
  ca.commandPerform({ command : '.help action' });
  var expected = '  .action - action';
  test.identical( got, expected );

  test.case = 'exact, two words, dotless'
  got = '';
  ca.commandPerform({ command : '.help action first' });
  var expected = '  .action.first - action first';
  test.identical( got, expected );

  test.case = 'exact, two words, with dot'
  got = '';
  ca.commandPerform({ command : '.help .action.first' });
  var expected = '  .action.first - action first';
  test.identical( got, expected );

  test.case = 'part of phrase, dotless'
  got = '';
  ca.commandPerform({ command : '.help first' });
  var expected = '  .action.first - action first  No command first';
  test.identical( got, expected );

  test.case = 'part of phrase, with dot'
  got = '';
  ca.commandPerform({ command : '.help .first' });
  var expected = '  .action.first - action first  No command .first';
  test.identical( got, expected );
}

// --
//
// --

var Self =
{

  name : 'Tools.mid.CommandsAggregator',
  silencing : 1,

  tests :
  {

    trivial,
    perform,
    commandIsolateSecondFromArgument,
    help

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
