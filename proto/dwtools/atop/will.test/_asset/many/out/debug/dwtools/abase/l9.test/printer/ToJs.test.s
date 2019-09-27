( function _ToJs_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../../l9/printer/top/ToJs.s' );

  var _ = wTools;

  _.include( 'wTesting' );

}

var _ = wTools;
var Parent = wTools.Testing;
var Self = {};

//

function writeToJs( test )
{
  test.case = 'case1';
  var loggerToJstructure  = new wPrinterToJs();
  loggerToJstructure.log( '123' );
  var got = loggerToJstructure.outputData;
  var expected = [ '123' ];
  test.identical( got, expected );

  test.case = 'case2';
  var loggerToJstructure  = new wPrinterToJs();
  loggerToJstructure.up( 2 );
  loggerToJstructure.log( '123' );
  var got = loggerToJstructure.outputData;
  var expected =
  [
    [
      [ '123' ]
    ]
  ];
  test.identical( got, expected );

  test.case = 'case3';
  var loggerToJstructure  = new wPrinterToJs();
  loggerToJstructure.log();
  var got = loggerToJstructure.outputData;
  // var expected = [ '' ];
  var expected = [];
  test.identical( got, expected );

  test.case = 'case4';
  var loggerToJstructure  = new wPrinterToJs();
  loggerToJstructure.log( '321');
  var got = loggerToJstructure.toJson();
  var expected = '[ "321" ]';
  test.identical( got, expected );

}

//

function chaining( test )
{
  let consoleWasBarred = _.Logger.consoleIsBarred( console );

  try
  {
    _chaining();
  }
  catch( err )
  {
    if( consoleWasBarred )
    test.suite.consoleBar( 1 );

    throw _.errLogOnce( err );
  }

  //

  function _chaining()
  {

    test.case = 'case1';
    var loggerToJstructure = new wPrinterToJs();
    var l = new _.Logger({ output : console });
    l.outputTo( loggerToJstructure, { combining : 'rewrite' } );
    l.log( 'msg' );
    var got = loggerToJstructure.outputData;
    var expected = [ 'msg' ];
    test.identical( got, expected );

    test.case = 'case2';
    var loggerToJstructure = new wPrinterToJs();
    var l = new _.Logger({ output : console });
    l.outputTo( loggerToJstructure, { combining : 'rewrite' } );
    l.up( 2 );
    l.log( 'msg' );
    var got = loggerToJstructure.outputData;
    var expected = [ '    msg' ];
    test.identical( got, expected );

    test.case = 'case3';
    var loggerToJstructure = new wPrinterToJs();
    var l = new _.Logger({ output : console });
    l.outputTo( loggerToJstructure, { combining : 'rewrite' } );
    loggerToJstructure.up( 2 );
    l.log( 'msg' );
    var got = loggerToJstructure.outputData;
    var expected =
    [
      [
        [ 'msg' ]
      ]
    ];
    test.identical( got, expected );

    // test.case = 'case4: Logger->LoggerToJs, leveling on';
    // var loggerToJstructure = new wPrinterToJs();
    // var l = new _.Logger({ output : console });
    // l.outputTo( loggerToJstructure, { combining : 'rewrite', leveling : 'delta' } );
    // l.log( 'msg' );
    // l.up( 2 );
    // l.log( 'msg2' );
    // var got = loggerToJstructure.outputData;
    // var expected =
    // [
    //   [
    //      [ '    msg2' ],
    //   ],
    //   'msg'
    // ];
    // test.identical( got, expected );

    test.case = 'case5 LoggerToJs->LoggerToJs';
    var loggerToJstructure = new wPrinterToJs();
    var loggerToJstructure2 = new wPrinterToJs();
    loggerToJstructure.outputTo( loggerToJstructure2, { combining : 'rewrite' } );
    loggerToJstructure.log( '1' );
    loggerToJstructure2.log( '2' );
    var got =
    [
      loggerToJstructure.outputData,
      loggerToJstructure2.outputData
    ];

    var expected =
    [
      [ '1' ],
      [ '1', '2' ]
    ];
    test.identical( got, expected );

    test.case = 'case6: LoggerToJs->Logger->LoggerToJs';
    var loggerToJstructure = new wPrinterToJs();
    var loggerToJstructure2 = new wPrinterToJs();
    var l = new _.Logger({ output : console });
    loggerToJstructure.outputTo( l, { combining : 'rewrite' } );
    l.outputTo( loggerToJstructure2, { combining : 'rewrite' } );
    l._prefix = '*';
    debugger
    loggerToJstructure.log( '1' );
    var got =
    [
      loggerToJstructure.outputData,
      loggerToJstructure2.outputData
    ];

    var expected =
    [
      [ '1' ],
      [ '*1' ]
    ];
    test.identical( got, expected );

    test.case = 'case7: input from console';
    var loggerToJstructure = new wPrinterToJs();
    test.suite.consoleBar( 0 );
    loggerToJstructure.inputFrom( console );
    console.log( 'abc' );
    loggerToJstructure.inputUnchain( console );
    if( consoleWasBarred )
    test.suite.consoleBar( 1 );
    var got = loggerToJstructure.outputData;
    var expected =
    [
      'abc'
    ];
    test.identical( got, expected );

    test.case = 'case8: input from console twice';
    var loggerToJstructure1 = new wPrinterToJs();
    var loggerToJstructure2 = new wPrinterToJs();
    test.suite.consoleBar( 0 );
    loggerToJstructure1.inputFrom( console );
    loggerToJstructure2.inputFrom( console );
    console.log( 'abc' )
    loggerToJstructure1.inputUnchain( console )
    loggerToJstructure2.inputUnchain( console )
    if( consoleWasBarred )
    test.suite.consoleBar( 1 );

    var got =
    [
      loggerToJstructure1.outputData,
      loggerToJstructure2.outputData
    ];

    var expected =
    [
      [ 'abc' ],
      [ 'abc' ]
    ];
    test.identical( got, expected );
  }
}

//

function leveling( test )
{
  var loggerToJstructure = new wPrinterToJs();
  loggerToJstructure.level = 5;
  test.identical( loggerToJstructure.level, 5 );
  loggerToJstructure.log( 1 );
  var got = loggerToJstructure.outputData;
  var expected =
  [
    [
      [
        [
          [
            [ '1' ]
          ]
        ]
      ]
    ]
  ]

  test.identical( got,expected )
  loggerToJstructure.level = 0;
  loggerToJstructure.log( 1 );
  expected.push( '1' );
  test.identical( got,expected )
  test.identical( loggerToJstructure.level, 0 );

  /**/

  var loggerToJstructure = new wPrinterToJs();
  loggerToJstructure.up( 5 );
  test.identical( loggerToJstructure.level, 5 );
  loggerToJstructure.log( 1 );
  var got = loggerToJstructure.outputData;
  var expected =
  [
    [
      [
        [
          [
            [ '1' ]
          ]
        ]
      ]
    ]
  ]

  test.identical( got,expected )
  loggerToJstructure.down( 5 );
  loggerToJstructure.log( 1 );
  expected.push( '1' );
  test.identical( got,expected );
  test.identical( loggerToJstructure.level, 0 );

  /**/

  var loggerToJstructure = new wPrinterToJs();
  loggerToJstructure._prefix = '*';
  loggerToJstructure.level = 2;
  loggerToJstructure.log( 1 );
  var got = loggerToJstructure.outputData;
  var expected = [ [ [ '*1' ] ] ];
  test.identical( got, expected )
}

//

var Proto =
{

  name : 'Tools.base.printer.ToJs',
  silencing : 1,

  tests :
  {

   writeToJs,
   chaining,
   leveling  : leveling

  },

}

//

_.mapExtend( Self,Proto );
Self = wTestSuite( Self )
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
