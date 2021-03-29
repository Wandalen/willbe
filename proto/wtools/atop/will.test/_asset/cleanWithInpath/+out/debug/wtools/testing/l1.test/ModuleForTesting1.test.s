( function _ModuleForTesting1_test_s_()
{

'use strict';

let _;
if( typeof module !== 'undefined' )
{
  _ = require( '../Basic.s' );
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

const Proto =
{

  name : 'Tools.l1.ModuleForTesting1',
  silencing : 1,

  tests :
  {
    trivial,
  },

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
