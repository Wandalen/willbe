( function _ModuleForTesting1_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  var _ = require( '../../Tools.s' );

  require( 'wTesting' );

}

// --
// test
// --

function trivial( test )
{
  test.case = 'sum of positive numbers';
  var got = _.sumOfNumbers( 1, 2 );
  test.identical( got, 3 );

  test.case = 'sum of negative numbers';
  var got = _.sumOfNumbers( -1, -2 );
  test.identical( got, -3 );

  test.case = 'sum of not a number values';
  var got = _.sumOfNumbers( 'a', 'b' );
  test.identical( got, NaN );
}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l1.ModuleForTesting1',
  silencing : 1,

  tests :
  {
    trivial,
  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
