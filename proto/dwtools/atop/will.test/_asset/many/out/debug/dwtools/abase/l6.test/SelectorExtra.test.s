( function _SelectorExtra_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wLogger' );

  require( '../l6/SelectorExtra.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// tests
// --

function selectTrivial( test )
{

  var src = { a : [ 1,2,3 ], b : { b1 : 'x' }, c : 'test' }
  var expected = null;
  var got = _.entityProbe({ src });
  test.identical( got.report, 'Probe : 3\n' );

  var src = [ [ 1,2,3 ], { b1 : 'x' }, 'test' ]
  var expected = null;
  var got = _.entityProbe({ src });
  test.identical( got.report, 'Probe : 3\n' );

}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l6.Selector',
  silencing : 1,
  enabled : 1,

  context :
  {
  },

  tests :
  {
    selectTrivial,
  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
