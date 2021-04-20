( function _ModuleForTesting12_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  var _ = require( '../l3/testing12/Include.s' );

  require( 'wTesting' );

}



// --
// test
// --

function trivial( test )
{
  test.case = 'square of positive numbers';
  var got = _.divideMulOnSum( 4, 4 );
  test.identical( got, 2 );

  test.case = 'square of negative numbers';
  var got = _.divideMulOnSum( -4, -4 );
  test.identical( got, -2 );

  test.case = 'square of not a number values';
  var got = _.divideMulOnSum( 'a', 'b' );
  test.identical( got, NaN );
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.base.l3.ModuleForTesting12',
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
