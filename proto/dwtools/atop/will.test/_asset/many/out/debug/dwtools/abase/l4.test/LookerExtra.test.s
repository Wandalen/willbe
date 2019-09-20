( function _LookerExtra_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( '../l4/LookerExtra.s' );

  _.include( 'wTesting' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// tests
// --

function entitySearch( test )
{

  test.case = 'trivial';
  var src = { a : 0, e : { d : 'something' } };
  var got = _.entitySearch( src, 'something' );
  var expected = { '/e/d' : 'something' };
  test.identical( got, expected );

}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l4.LookerExtra',
  silencing : 1,
  enabled : 1,

  context :
  {
  },

  tests :
  {

    entitySearch,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
