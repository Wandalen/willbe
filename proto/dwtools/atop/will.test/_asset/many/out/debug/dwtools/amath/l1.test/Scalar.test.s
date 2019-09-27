( function _Scalar_test_s_( ) {

'use strict'; 

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wTesting' );

  require( '../l1/Scalar.s' );

}

//

var _ = _global_.wTools.withArray.Float32;
var Parent = wTester;

// --
// test
// --

function fract( test )
{

  test.case = 'half';
  test.equivalent( _.fract( 1.5 ) , 0.5 );

  test.case = 'less than half';
  test.equivalent( _.fract( 2.1 ) , 0.1 );

  test.case = 'more then half';
  test.equivalent( _.fract( 3.9 ) , 0.9 );

  test.case = 'exactly';
  test.equivalent( _.fract( 4.0 ) , 0.0 );

  test.case = 'negative half';
  test.equivalent( _.fract( -1.5 ) , 0.5 );

  test.case = 'negative less than half';
  test.equivalent( _.fract( -2.1 ) , 0.9 );

  test.case = 'negative more then half';
  test.equivalent( _.fract( -3.9 ) , 0.1 );

  test.case = 'negative exactly';
  test.equivalent( _.fract( -4.0 ) , 0.0 );

  test.case = 'zero';
  test.equivalent( _.fract( 0 ) , 0.0 );

  test.case = 'two decimals';
  test.equivalent( _.fract( 2.15 ) , 0.15 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.fract();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.fract( 'x' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.fract( [] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.fract( 1,3 );
  });

}

//

function factorial( test )
{

  test.case = '1!';
  test.equivalent( _.factorial( 1 ) , 1 );

  test.case = '2!';
  test.equivalent( _.factorial( 2 ) , 2 );

  test.case = '3!';
  test.equivalent( _.factorial( 3 ) , 6 );

  test.case = '4!';
  test.equivalent( _.factorial( 4 ) , 24 );

  test.case = '5!';
  test.equivalent( _.factorial( 5 ) , 120 );

  test.case = '10!';
  test.equivalent( _.factorial( 10 ) , 3628800 );

  test.case = 'zero';
  test.equivalent( _.factorial( 0 ), 1 );


  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.factorial();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.factorial( 'x' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.factorial( [] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.factorial( 1,3 );
  });

  test.case = 'negative argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.factorial( -4 );
  });

  test.case = 'not integer, lower 1';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.factorial( 0.3 );
  });

  test.case = 'not integer, more 1';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.factorial( 1.3 );
  });

}

//

function roundToPowerOfTwo( test )
{

  test.case = 'roundToPowerOfTwo: 1';
  test.equivalent( _.roundToPowerOfTwo( 1 ) , 1 );

  test.case = 'roundToPowerOfTwo: 127';
  test.equivalent( _.roundToPowerOfTwo( 127 ) , 128 );

  test.case = 'roundToPowerOfTwo: 127.5';
  test.equivalent( _.roundToPowerOfTwo( 127.5 ) , 128 );

  test.case = 'roundToPowerOfTwo: 11';
  test.equivalent( _.roundToPowerOfTwo( 11 ) , 8 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.roundToPowerOfTwo();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.roundToPowerOfTwo( 'x' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.roundToPowerOfTwo( [] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.roundToPowerOfTwo( 1,3 );
  });

  test.case = 'negative argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.roundToPowerOfTwo( -4 );
  });

}

//

function ceilToPowerOfTwo( test )
{

  test.case = 'ceilToPowerOfTwo: 127';
  test.equivalent( _.ceilToPowerOfTwo( 127 ) , 128 );

  test.case = 'ceilToPowerOfTwo: 127.5';
  test.equivalent( _.ceilToPowerOfTwo( 127.5 ) , 128 );

  test.case = 'ceilToPowerOfTwo: 15';
  test.equivalent( _.ceilToPowerOfTwo( 15 ) , 16 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.ceilToPowerOfTwo();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.ceilToPowerOfTwo( 'x' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.ceilToPowerOfTwo( [] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.ceilToPowerOfTwo( 1,3 );
  });

  test.case = 'negative argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.ceilToPowerOfTwo( -4 );
  });

}

//

function floorToPowerOfTwo( test )
{

  test.case = 'floorToPowerOfTwo: 19';
  test.equivalent( _.floorToPowerOfTwo( 19 ) , 16 );

  test.case = 'floorToPowerOfTwo: 31.9';
  test.equivalent( _.floorToPowerOfTwo( 31.9 ) , 16 );

  test.case = 'floorToPowerOfTwo: 0';
  test.equivalent( _.floorToPowerOfTwo( 0 ) , 0 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.floorToPowerOfTwo();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.floorToPowerOfTwo( 'x' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.floorToPowerOfTwo( [] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.floorToPowerOfTwo( 1,3 );
  });

  test.case = 'negative argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.floorToPowerOfTwo( -4 );
  });

}

//

function experiment( test )
{
  /*
   *  Why does it show an error for the decimal argument if there i no requirement in the code for it to be integer (even if it should)?
   */

  if( !Config.debug )
  return;

  test.case = 'decimal argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    debugger;
    _.factorial( 2.5 )
  });

}

// --
// declare
// --

var Self =
{

  name : 'Tools.Math.Scalar',
  silencing : 1,
  // verbosity : 7,
  // debug : 1,

  tests :
  {

    fract : fract,
    factorial : factorial,

    roundToPowerOfTwo : roundToPowerOfTwo,
    ceilToPowerOfTwo : ceilToPowerOfTwo,
    floorToPowerOfTwo : floorToPowerOfTwo,

    experiment : experiment,

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
