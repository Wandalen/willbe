( function _Time_test_s_( ) {

'use strict'; 

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer2.s' );
  _.include( 'wTesting' );
}

var _ = wTools;

// --
// tests
// --

function timeReadyJoin( test )
{
  let t = 0;
  let con = _testerGlobal_.wTools.Consequence();

  function r1()
  {
    t += 1;
    console.log( arguments );

    if( t === 1 )
    test.equivalent( arguments, [ 'arg1', 'arg2' ] );
    else if( t === 2 )
    test.equivalent( arguments, [ 'arg1', 'arg3', 'arg4' ] );
    else if( t === 3 )
    test.equivalent( arguments, [ 'arg5', 'arg6', 'arg7', 'arg8' ] );
    else if( t === 4 )
    test.equivalent( arguments, [ 'arg5', 'arg6', 'arg9' ] );

    if( t === 4 )
    con.take( t );

    return arguments;
  }

  let f1 = _.timeReadyJoin( undefined, r1, [ 'arg1' ] );
  f1( 'arg2' );
  f1( 'arg3', 'arg4' );

  let f2 = _.timeReadyJoin( undefined, r1, [ 'arg5', 'arg6' ] );
  f2( 'arg7', 'arg8' );
  f2( 'arg9' );

  return con;
}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l1.Time',
  silencing : 1,

  tests :
  {

    timeReadyJoin,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
