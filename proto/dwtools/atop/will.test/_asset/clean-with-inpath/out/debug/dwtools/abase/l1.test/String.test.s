( function _Str_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer2.s' );

  _.include( 'wTesting' );

  // _.include( 'wStringer' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
//
// --

function strLeft( test )
{
  test.open( 'string' );

  test.case = 'begin';
  var expected = { index : 0, entry : 'aa', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', 'aa' );
  test.identical( got, expected );

  test.case = 'middle';
  var expected = { index : 6, entry : 'bb', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', 'bb' );
  test.identical( got, expected );

  test.case = 'end';
  var expected = { index : 12, entry : 'cc', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', 'cc' );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';
  var expected = { index : 0, entry : 'aa', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'aa', 'bb' ] );
  test.identical( got, expected );

  var expected = { index : 0, entry : 'aa', instanceIndex : 1 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';
  var expected = { index : 6, entry : 'bb', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'cc' ] );
  test.identical( got, expected );

  var expected = { index : 6, entry : 'bb', instanceIndex : 1 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry';
  var expected = { index : 12, entry : 'cc', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'dd' ] );

  test.identical( got, expected );
  var expected = { index : 12, entry : 'cc', instanceIndex : 1 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';
  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';
  var expected = [ { index : 6, entry : 'bb', instanceIndex : 0 }, { index : 0, entry : 'cc', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 0, entry : 'cc', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';
  var expected = [ { index : 12, entry : 'cc', instanceIndex : 0 }, { index : 0, entry : 'cc', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );

  var expected = [ { index : 12, entry : 'cc', instanceIndex : 1 }, { index : 0, entry : 'cc', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'with window';

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17 );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -15 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 9, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -10 );
  test.identical( got, expected );

  var expected = [ { index : 17, entry : undefined, instanceIndex : -1 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -1 );
  test.identical( got, expected );

  var expected = [ { index : 17, entry : undefined, instanceIndex : -1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -2 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0 );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 1 );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 3 );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 6 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 9, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 7 );
  test.identical( got, expected );

  var expected = [ { index : 17, entry : undefined, instanceIndex : -1 }, { index : 12, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 10 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -17, -15 ] );
  test.identical( got, expected );

  var expected = [ { index : 17, entry : undefined, instanceIndex : -1 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -17, -16 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -17, -10 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -17, -9 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -15, -12 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -15, -9 ] );
  test.identical( got, expected );

  var expected = [ { index : 17, entry : undefined, instanceIndex : -1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -2, 17 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, 2 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 1, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 1, 8 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, -15 ] );
  test.identical( got, expected );

  var expected = [ { index : 17, entry : undefined, instanceIndex : -1 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, -16 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, -10 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, -9 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, -12 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, 17 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, 2 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, 8 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, -15 ] );
  test.identical( got, expected );

  var expected = [ { index : 17, entry : undefined, instanceIndex : -1 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, -16 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, -10 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, -9 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, -12 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, 17 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, 2 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, 8 ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';
  var expected = { index : 17, entry : undefined, instanceIndex : -1 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';
  var expected = { index : 17, entry : undefined, instanceIndex : -1 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', 'dd' );
  test.identical( got, expected );

  test.case = 'empty entry';
  var expected = { index : 0, entry : '', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', '' );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';
  var expected = { index : 0, entry : '', instanceIndex : 0 }
  var got = _.strLeft( '', '' );
  test.identical( got, expected );

  test.case = 'empty src';
  var expected = { index : 0, entry : undefined, instanceIndex : -1 }
  var got = _.strLeft( '', 'aa' );
  test.identical( got, expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp' );

  test.case = 'begin';
  var expected = { index : 0, entry : 'aa', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', /a+/ );
  test.identical( got, expected );

  test.case = 'middle';
  var expected = { index : 6, entry : 'bb', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', /b+/ );
  test.identical( got, expected );

  test.case = 'end';
  var expected = { index : 12, entry : 'cc', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', /c+/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin smeared';
  var expected = { index : 0, entry : 'xa', instanceIndex : 0 }
  var got = _.strLeft( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /\wa/ );
  test.identical( got, expected );

  test.case = 'middle smeared';
  var expected = { index : 10, entry : 'xb', instanceIndex : 0 }
  var got = _.strLeft( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /\wb/ );
  test.identical( got, expected );

  test.case = 'end ';
  var expected = { index : 20, entry : 'xc', instanceIndex : 0 }
  var got = _.strLeft( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /\wc/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';
  var expected = { index : 0, entry : 'aa', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /a+/, /b+/ ] );
  test.identical( got, expected );

  var expected = { index : 0, entry : 'aa', instanceIndex : 1 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';
  var expected = { index : 6, entry : 'bb', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /b+/, /c+/ ] );
  test.identical( got, expected );

  var expected = { index : 6, entry : 'bb', instanceIndex : 1 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry';
  var expected = { index : 12, entry : 'cc', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /c+/, /d+/ ] );
  test.identical( got, expected );

  var expected = { index : 12, entry : 'cc', instanceIndex : 1 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';
  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, /b+/ ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';
  var expected = [ { index : 6, entry : 'bb', instanceIndex : 0 }, { index : 0, entry : 'cc', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /c+/ ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 0, entry : 'cc', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';
  var expected = [ { index : 12, entry : 'cc', instanceIndex : 0 }, { index : 0, entry : 'cc', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /d+/ ] );
  test.identical( got, expected );

  var expected = [ { index : 12, entry : 'cc', instanceIndex : 1 }, { index : 0, entry : 'cc', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'with window, mixed';

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -17 );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -15 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 9, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -10 );
  test.identical( got, expected );

  var expected = [ { index : 17, entry : undefined, instanceIndex : -1 }, { index : 16, entry : 'a', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -1 );
  test.identical( got, expected );

  var expected = [ { index : 17, entry : undefined, instanceIndex : -1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -2 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 0 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ -17, -15 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ 0, 2 ] );
  test.identical( got, expected );

  var expected = [ { index : 1, entry : 'a', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ 1, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 1, entry : 'a', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ 1, 8 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ undefined, -15 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'a', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ undefined, -16 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ undefined, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [undefined, 8] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 17, entry : undefined, instanceIndex : -1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ 0, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ 0, 8 ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';
  var expected = { index : 17, entry : undefined, instanceIndex : -1 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';
  var expected = { index : 17, entry : undefined, instanceIndex : -1 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', /d+/ );
  test.identical( got, expected );

  test.case = 'empty entry';
  var expected = { index : 0, entry : '', instanceIndex : 0 }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';
  var expected = { index : 0, entry : '', instanceIndex : 0 }
  var got = _.strLeft( '', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty src';
  var expected = { index : 0, entry : undefined, instanceIndex : -1 }
  var got = _.strLeft( '', /a+/ );
  test.identical( got, expected );

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.case = 'wrong first index';
  test.shouldThrowErrorSync( () => _.strLeft( 'abc', 'b', -100 ) );
  test.shouldThrowErrorSync( () => _.strLeft( 'abc', 'b', 100 ) );

  test.case = 'wrong lalt index';
  test.shouldThrowErrorSync( () => _.strLeft( 'abc', 'b', 0, -100 ) );
  test.shouldThrowErrorSync( () => _.strLeft( 'abc', 'b', 0, 100 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strLeft( /a/, /a+/ ) );

  test.case = 'wrong type of first index'
  test.shouldThrowErrorSync( () => _.strLeft( 'abc', /a+/, 'a' ) );

  test.case = 'wrong type of last index'
  test.shouldThrowErrorSync( () => _.strLeft( 'abc', /a+/, 1, '' ) );

  test.case = 'wrong type of ins'
  test.shouldThrowErrorSync( () => _.strLeft( '123', 1 ) );
  test.shouldThrowErrorSync( () => _.strLeft( '123', [ 1 ] ) );

  test.case = 'without argument';
  test.shouldThrowErrorSync( () => _.strLeft() );

  test.case = 'one argument';
  test.shouldThrowErrorSync( () => _.strLeft( 'abc' ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strLeft( 'abcd', 'a', 0, 2, 'extra' ) );

  test.close( 'throwing' );
}

//

function strRight( test )
{
  test.open( 'string' );

  test.case = 'begin';
  var expected = { index : 3, entry : 'aa', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', 'aa' );
  test.identical( got, expected );

  test.case = 'middle';
  var expected = { index : 9, entry : 'bb', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', 'bb' );
  test.identical( got, expected );

  test.case = 'end';
  var expected = { index : 15, entry : 'cc', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', 'cc' );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';
  var expected = { index : 9, entry : 'bb', instanceIndex : 1 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'aa', 'bb' ] );
  test.identical( got, expected );

  var expected = { index : 9, entry : 'bb', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';
  var expected = { index : 15, entry : 'cc', instanceIndex : 1 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'cc' ] );
  test.identical( got, expected );

  var expected = { index : 15, entry : 'cc', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry';
  var expected = { index : 15, entry : 'cc', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'dd' ] );
  test.identical( got, expected );

  var expected = { index : 15, entry : 'cc', instanceIndex : 1 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';
  var expected = [ { index : 9, entry : 'bb', instanceIndex :  1}, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 0 }, { index : 15, entry : 'aa', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';
  var expected = [ { index : 15, entry : 'cc', instanceIndex : 1 }, { index : 9, entry : 'bb', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );

  var expected = [ { index : 15, entry : 'cc', instanceIndex : 0 }, { index : 9, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';
  var expected = [ { index : 15, entry : 'cc', instanceIndex : 0 }, { index : 3, entry : 'cc', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );

  var expected = [ { index : 15, entry : 'cc', instanceIndex : 1 }, { index : 3, entry : 'cc', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'with window';

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -15 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -10 );
  test.identical( got, expected );

  var expected = [ { index : -1, entry : undefined, instanceIndex : -1 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -1 );
  test.identical( got, expected );

  var expected = [ { index : -1, entry : undefined, instanceIndex : -1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -2 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 1 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 3 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 6 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 7 );
  test.identical( got, expected );

  var expected = [ { index : -1, entry : undefined, instanceIndex : -1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 10 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -17, -15 ] );
  test.identical( got, expected );

  var expected = [ { index : -1, entry : undefined, instanceIndex : -1 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -17, -16 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -17, -10 ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -17, -9 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -15, -12 ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -15, -9 ] );
  test.identical( got, expected );

  var expected = [ { index : -1, entry : undefined, instanceIndex : -1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ -2, 17 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, 2 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 1, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 1, 8 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, -15 ] );
  test.identical( got, expected );

  var expected = [ { index : -1, entry : undefined, instanceIndex : -1 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, -16 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, -10 ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, -9 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, -12 ] );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, 17 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, 2 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ undefined, 8 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, -15 ] );
  test.identical( got, expected );

  var expected = [ { index : -1, entry : undefined, instanceIndex : -1 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, -16 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, -10 ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, -9 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, -12 ] );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, 17 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, 2 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 0, 8 ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';
  var expected = { index : -1, entry : undefined, instanceIndex : -1 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';
  var expected = { index : -1, entry : undefined, instanceIndex : -1 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', 'dd' );
  test.identical( got, expected );

  test.case = 'empty entry';
  var expected = { index : 17, entry : '', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', '' );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';
  var expected = { index : 0, entry : '', instanceIndex : 0 }
  var got = _.strRight( '', '' );
  test.identical( got, expected );

  test.case = 'empty src';
  var expected = { index : -1, entry : undefined, instanceIndex : -1 }
  var got = _.strRight( '', 'aa' );
  test.identical( got, expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp' );

  test.case = 'begin';
  var expected = { index : 3, entry : 'aa', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', /a+/ );
  test.identical( got, expected );

  test.case = 'middle';
  var expected = { index : 9, entry : 'bb', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', /b+/ );
  test.identical( got, expected );

  test.case = 'end';
  var expected = { index : 15, entry : 'cc', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', /c+/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin smeared';
  var expected = { index : 7, entry : 'ax', instanceIndex : 0 }
  var got = _.strRight( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /a\w/ );
  test.identical( got, expected );

  test.case = 'middle smeared';
  var expected = { index : 17, entry : 'bx', instanceIndex : 0 }
  var got = _.strRight( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /b\w/ );
  test.identical( got, expected );

  test.case = 'end ';
  var expected = { index : 27, entry : 'cx', instanceIndex : 0 }
  var got = _.strRight( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';
  var expected = { index : 9, entry : 'bb', instanceIndex : 1 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /a+/, /b+/ ] );
  test.identical( got, expected );

  var expected = { index : 9, entry : 'bb', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';
  var expected = { index : 15, entry : 'cc', instanceIndex : 1 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = { index : 15, entry : 'cc', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry';
  var expected = { index : 15, entry : 'cc', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = { index : 15, entry : 'cc', instanceIndex : 1 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';
  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, /b+/ ] );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 0 }, { index : 15, entry : 'aa', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';
  var expected = [ { index : 15, entry : 'cc', instanceIndex : 1 }, { index : 9, entry : 'bb', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /c+/ ] );
  test.identical( got, expected );

  var expected = [ { index : 15, entry : 'cc', instanceIndex : 0 }, { index : 9, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';
  var expected = [ { index : 15, entry : 'cc', instanceIndex : 0 }, { index : 3, entry : 'cc', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /d+/ ] );
  test.identical( got, expected );

  var expected = [ { index : 15, entry : 'cc', instanceIndex : 1 }, { index : 3, entry : 'cc', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'with window, mixed';

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -17 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -15 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -10 );
  test.identical( got, expected );

  var expected = [ { index : -1, entry : undefined, instanceIndex : -1 }, { index : 16, entry : 'a', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -1 );
  test.identical( got, expected );

  var expected = [ { index : -1, entry : undefined, instanceIndex : -1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -2 );
  test.identical( got, expected );

  var expected = [ { index : 9, entry : 'bb', instanceIndex : 1 }, { index : 15, entry : 'aa', instanceIndex : 0 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 0 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ -17, -15 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ 0, 2 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ 1, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ 1, 8 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ undefined, -15 ] );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'a', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ undefined, -16 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ undefined, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ undefined, 8 ] );
  test.identical( got, expected );

  var expected = [ { index : 3, entry : 'aa', instanceIndex : 0 }, { index : -1, entry : undefined, instanceIndex : -1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ 0, 7 ] );
  test.identical( got, expected );

  var expected = [ { index : 6, entry : 'bb', instanceIndex : 1 }, { index : 6, entry : 'bb', instanceIndex : 1 } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], [ 0, 8 ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';
  var expected = { index : -1, entry : undefined, instanceIndex : -1 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';
  var expected = { index : -1, entry : undefined, instanceIndex : -1 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', /d+/ );
  test.identical( got, expected );

  test.case = 'empty entry';
  var expected = { index : 17, entry : '', instanceIndex : 0 }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';
  var expected = { index : 0, entry : '', instanceIndex : 0 }
  var got = _.strRight( '', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty src';
  var expected = { index : -1, entry : undefined, instanceIndex : -1 }
  var got = _.strRight( '', /a+/ );
  test.identical( got, expected );

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

 test.open( 'throwing' );

  test.case = 'wrong first index';
  test.shouldThrowErrorSync( () => _.strRight( 'abc', 'b', -100 ) );
  test.shouldThrowErrorSync( () => _.strRight( 'abc', 'b', 100 ) );

  test.case = 'wrong lalt index';
  test.shouldThrowErrorSync( () => _.strRight( 'abc', 'b', 0, -100 ) );
  test.shouldThrowErrorSync( () => _.strRight( 'abc', 'b', 0, 100 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strRight( /a/, /a+/ ) );

  test.case = 'wrong type of first index'
  test.shouldThrowErrorSync( () => _.strRight( 'abc', /a+/, '' ) );

  test.case = 'wrong type of last index'
  test.shouldThrowErrorSync( () => _.strRight( 'abc', /a+/, 1, '' ) );

  test.case = 'wrong type of ins'
  test.shouldThrowErrorSync( () => _.strRight( '123', 1 ) );
  test.shouldThrowErrorSync( () => _.strRight( '123', [ 1 ] ) );

  test.case = 'without argument';
  test.shouldThrowErrorSync( () => _.strRight() );

  test.case = 'one argument';
  test.shouldThrowErrorSync( () => _.strRight( 'abc' ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strRight( 'abcd', 'a', 0, 2, 'extra' ) );

  test.close( 'throwing' );
}

//

function strEquivalent( test )
{
  test.open( 'true' );

  test.case = 'strings';
  var got = _.strEquivalent( 'abc', 'abc' );
  test.identical( got, true );

  test.case = 'regexp and string';
  var got = _.strEquivalent( /\w+/, 'abc' );
  test.identical( got, true );

  test.case = 'string and regexp';
  var got = _.strEquivalent( 'abc', /\w+/ );
  test.identical( got, true );

  test.case = 'regexp and regexp';
  var got = _.strEquivalent( /\w+/, /\w+/ );
  test.identical( got, true );

  test.close( 'true' );

  /* - */

  test.open( 'false' );

  test.case = 'strings';
  var got = _.strEquivalent( 'abd', 'abc' );
  test.identical( got, false );

  test.case = 'regexp and string';
  var got = _.strEquivalent( /\s+/, 'abc' );
  test.identical( got, false );

  test.case = 'regexp and string';
  var got = _.strEquivalent( /\w/, 'abc' );
  test.identical( got, false );

  test.case = 'string and regexp';
  var got = _.strEquivalent( 'abc', /\s+/ );
  test.identical( got, false );

  test.case = 'string and regexp';
  var got = _.strEquivalent( 'abc', /\w/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strEquivalent( /\w*/, /\w+/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strEquivalent( /\w+/g, /\w+/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strEquivalent( /\w+/g, /\w+/gi );
  test.identical( got, false );

  test.close( 'false' );
}

//

function strsEquivalent( test )
{
  test.open( 'scalar, true' );

  test.case = 'strings';
  var got = _.strsEquivalent( 'abc', 'abc' );
  test.identical( got, true );

  test.case = 'regexp and string';
  var got = _.strsEquivalent( /\w+/, 'abc' );
  test.identical( got, true );

  test.case = 'string and regexp';
  var got = _.strsEquivalent( 'abc', /\w+/ );
  test.identical( got, true );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalent( /\w+/, /\w+/ );
  test.identical( got, true );

  test.close( 'scalar, true' );

  /* - */

  test.open( 'scalar, false' );

  test.case = 'strings';
  var got = _.strsEquivalent( 'abd', 'abc' );
  test.identical( got, false );

  test.case = 'regexp and string';
  var got = _.strsEquivalent( /\s+/, 'abc' );
  test.identical( got, false );

  test.case = 'regexp and string';
  var got = _.strsEquivalent( /\w/, 'abc' );
  test.identical( got, false );

  test.case = 'string and regexp';
  var got = _.strsEquivalent( 'abc', /\s+/ );
  test.identical( got, false );

  test.case = 'string and regexp';
  var got = _.strsEquivalent( 'abc', /\w/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalent( /\w*/, /\w+/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalent( /\w+/g, /\w+/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalent( /\w+/g, /\w+/gi );
  test.identical( got, false );

  test.close( 'scalar, false' );

  /* - */

  test.open( 'vector, true' );

  test.case = 'vector, vector';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = [ 'abc', 'abc', /\w+/, /\w+/ ];
  var got = _.strsEquivalent( src1, src2 );
  test.identical( got, [ true, true, true, true ] );

  test.case = 'vector, scalar';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalent( src1, src2 );
  test.identical( got, [ true, true, true, true ] );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalent( src1, src2 );
  test.identical( got, [ true, true, true, true ] );

  test.close( 'vector, true' );

  /* - */

  test.open( 'vector, false' );

  test.case = 'vector, vector';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/g ];
  var src2 = [ 'abc', 'abc', 'abc', /\s+/, /\w/, /\w+/, /\w+/, /\w+/gi ];
  var got = _.strsEquivalent( src1, src2 );
  test.identical( got, [ false, false, false, false, false, false, false, false ] );

  test.case = 'vector, scalar';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/gi ];
  var src2 = 'abc';
  var got = _.strsEquivalent( src1, src2 );
  test.identical( got, [ false, false, false, true, true, true, true, true ] );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/gi ];
  var got = _.strsEquivalent( src1, src2 );
  test.identical( got, [ false, false, false, true, true, true, true, true ] );

  test.close( 'vector, false' );
}

//

function strsEquivalentAll( test )
{
  test.open( 'scalar, true' );

  test.case = 'strings';
  var got = _.strsEquivalentAll( 'abc', 'abc' );
  test.identical( got, true );

  test.case = 'regexp and string';
  var got = _.strsEquivalentAll( /\w+/, 'abc' );
  test.identical( got, true );

  test.case = 'string and regexp';
  var got = _.strsEquivalentAll( 'abc', /\w+/ );
  test.identical( got, true );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentAll( /\w+/, /\w+/ );
  test.identical( got, true );

  test.close( 'scalar, true' );

  /* - */

  test.open( 'scalar, false' );

  test.case = 'strings';
  var got = _.strsEquivalentAll( 'abd', 'abc' );
  test.identical( got, false );

  test.case = 'regexp and string';
  var got = _.strsEquivalentAll( /\s+/, 'abc' );
  test.identical( got, false );

  test.case = 'regexp and string';
  var got = _.strsEquivalentAll( /\w/, 'abc' );
  test.identical( got, false );

  test.case = 'string and regexp';
  var got = _.strsEquivalentAll( 'abc', /\s+/ );
  test.identical( got, false );

  test.case = 'string and regexp';
  var got = _.strsEquivalentAll( 'abc', /\w/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentAll( /\w*/, /\w+/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentAll( /\w+/g, /\w+/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentAll( /\w+/g, /\w+/gi );
  test.identical( got, false );

  test.close( 'scalar, false' );

  /* - */

  test.open( 'vectors, true' );

  test.case = 'mixed vector, scalar - string';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'mixed vector, scalar - regexp';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = /\w+/;
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - string, mixed vector';
  var src1 = 'abc';
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - regexp, mixed vector';
  var src1 = /\w+/;
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of regexp, scalar - string';
  var src1 = [ /\w+/g, /\w+/gi ];
  var src2 = 'abc';
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of regexp, scalar - regexp';
  var src1 = [ /\w+/g, /\w+/g ];
  var src2 = /\w+/g;
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - string, vector of regexp';
  var src1 = 'abc';
  var src2 = [ /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - regexp, vector of regexp';
  var src1 = /\w+/g;
  var src2 = [ /\w+/g, /\w+/g ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of strings, vector of strings';
  var src1 = [ 'abc', 'abc', 'aaa', 'bbb' ];
  var src2 = [ 'abc', 'abc', 'aaa', 'bbb' ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of regexp, vector of strings';
  var src1 = [ /\w+/, /\w+/gi, /\w+/g, /\w+/ ];
  var src2 = [ 'abc', 'abc', 'aaa', 'bbb' ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of strings, vector of regexp';
  var src1 = [ 'abc', 'abc', 'aaa', 'bbb' ];
  var src2 = [ /\w+/, /\w+/gi, /\w+/g, /\w+/ ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'mixed vector, mixed vector';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = [ 'abc', 'abc', /\w+/, /\w+/ ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.close( 'vectors, true' );

  /* - */

  test.open( 'vectors, false' );

  test.case = 'mixed vector, scalar - string';
  var src1 = [ 'abc', /\w+/, 'ab', /\w+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'mixed vector, scalar - regexp';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/g ];
  var src2 = /\w+/;
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - string, mixed vector';
  var src1 = 'abc d';
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - regexp, mixed vector';
  var src1 = /\w+/g;
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of regexp, scalar - string';
  var src1 = [ /\w+/g, /\w+/gi ];
  var src2 = 'abc d';
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of regexp, scalar - regexp';
  var src1 = [ /\w+/g, /\w+/g ];
  var src2 = /\w+/gi;
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - string, vector of regexp';
  var src1 = 'abc d';
  var src2 = [ /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - regexp, vector of regexp';
  var src1 = /\w+/gi;
  var src2 = [ /\w+/g, /\w+/g ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of strings, vector of strings';
  var src1 = [ 'abc', 'abc', 'bbb', 'aaa' ];
  var src2 = [ 'abc', 'abc', 'aaa', 'bbb' ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of regexp, vector of strings';
  var src1 = [ /\w+/, /\w+/gi, /\w+/g, /\w+/ ];
  var src2 = [ 'abc d', 'abc', 'aaa', 'bbb' ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of strings, vector of regexp';
  var src1 = [ 'abc d', 'abc', 'aaa', 'bbb' ];
  var src2 = [ /\w+/, /\w+/gi, /\w+/g, /\w+/ ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'mixed vector, mixed vector';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = [ 'abc', 'abc', /\w+/, /\w+/gi ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.close( 'vectors, false' );
}

//

function strsEquivalentAny( test )
{

  /* - */

  test.open( 'scalar, true' );

  test.case = 'strings';
  var got = _.strsEquivalentAny( 'abc', 'abc' );
  test.identical( got, true );

  test.case = 'regexp and string';
  var got = _.strsEquivalentAny( /\w+/, 'abc' );
  test.identical( got, true );

  test.case = 'string and regexp';
  var got = _.strsEquivalentAny( 'abc', /\w+/ );
  test.identical( got, true );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentAny( /\w+/, /\w+/ );
  test.identical( got, true );

  test.close( 'scalar, true' );

  /* - */

  test.open( 'scalar, false' );

  test.case = 'strings';
  var got = _.strsEquivalentAny( 'abd', 'abc' );
  test.identical( got, false );

  test.case = 'regexp and string';
  var got = _.strsEquivalentAny( /\s+/, 'abc' );
  test.identical( got, false );

  test.case = 'regexp and string';
  var got = _.strsEquivalentAny( /\w/, 'abc' );
  test.identical( got, false );

  test.case = 'string and regexp';
  var got = _.strsEquivalentAny( 'abc', /\s+/ );
  test.identical( got, false );

  test.case = 'string and regexp';
  var got = _.strsEquivalentAny( 'abc', /\w/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentAny( /\w*/, /\w+/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentAny( /\w+/g, /\w+/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentAny( /\w+/g, /\w+/gi );
  test.identical( got, false );

  test.close( 'scalar, false' );

  /* - */

  test.open( 'vectors, true' );

  test.case = 'mixed vector, scalar - string';
  var src1 = [ 'ab', /\w+/, 'ab', /\w+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'mixed vector, scalar - regexp';
  var src1 = [ 'abc d', /\w+/g, 'abc d', /\w+/ ];
  var src2 = /\w+/;
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - string, mixed vector';
  var src1 = 'abc d';
  var src2 = [ 'abc', /\w+/, 'abc d', /\w+/ ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - regexp, mixed vector';
  var src1 = /\w+/;
  var src2 = [ 'abc d', /\w+/g, 'abc d', /\w+/ ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of regexp, scalar - string';
  var src1 = [ /\w+\s\w/g, /\w+/gi ];
  var src2 = 'abc d';
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of regexp, scalar - regexp';
  var src1 = [ /\w+/, /\w+/g ];
  var src2 = /\w+/g;
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - string, vector of regexp';
  var src1 = 'abc';
  var src2 = [ /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - regexp, vector of regexp';
  var src1 = /\w+/g;
  var src2 = [ /\w+/gi, /\w+/g ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of strings, vector of strings';
  var src1 = [ 'abc', 'abc', 'aaa', 'bbb' ];
  var src2 = [ 'ab', 'ab', 'aa', 'bbb' ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of regexp, vector of strings';
  var src1 = [ /\w+/, /\w+/gi, /\w+/g, /\w+/ ];
  var src2 = [ 'abc', 'abc d', 'aaa d', 'bbb d' ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of strings, vector of regexp';
  var src1 = [ 'abc d', 'abc d', 'aaa d', 'bbb' ];
  var src2 = [ /\w+/, /\w+/gi, /\w+/g, /\w+/ ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'mixed vector, mixed vector';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = [ 'ab', 'abc', /\w+/, /\w+/ ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.close( 'vectors, true' );

  /* - */

  test.open( 'vectors, false' );

  test.case = 'mixed vector, scalar - string';
  var src1 = [ 'abc', /\w+/, 'ab', /\w+/ ];
  var src2 = 'abc d';
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'mixed vector, scalar - regexp';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/g ];
  var src2 = /\w+\s/;
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - string, mixed vector';
  var src1 = 'abc d';
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - regexp, mixed vector';
  var src1 = /\w+\s/g;
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of regexp, scalar - string';
  var src1 = [ /\w+/g, /\w+/gi ];
  var src2 = 'abc d';
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of regexp, scalar - regexp';
  var src1 = [ /\w+/g, /\w+/g ];
  var src2 = /\w+/gi;
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - string, vector of regexp';
  var src1 = 'abc d';
  var src2 = [ /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - regexp, vector of regexp';
  var src1 = /\w+/gi;
  var src2 = [ /\w+/g, /\w+/g ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of strings, vector of strings';
  var src1 = [ 'abc', 'abc', 'bbb', 'aaa' ];
  var src2 = [ 'ab', 'ab', 'aa', 'bb' ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of regexp, vector of strings';
  var src1 = [ /\w+/, /\w+/gi, /\w+/g, /\w+/ ];
  var src2 = [ 'abc d', 'abc d', 'aaa d', 'bbb d' ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of strings, vector of regexp';
  var src1 = [ 'abc d', 'abc', 'aaa', 'bbb d' ];
  var src2 = [ /\w+/, /\w+\s/gi, /\w+\s/g, /\w+/ ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'mixed vector, mixed vector';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = [ 'ab', 'abc d', /\w+\s/, /\w+/gi ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.close( 'vectors, false' );
}

//

function strsEquivalentNone( test )
{

  /* - */

  test.open( 'scalar, false' );

  test.case = 'strings';
  var got = _.strsEquivalentNone( 'abc', 'abc' );
  test.identical( got, false );

  test.case = 'regexp and string';
  var got = _.strsEquivalentNone( /\w+/, 'abc' );
  test.identical( got, false );

  test.case = 'string and regexp';
  var got = _.strsEquivalentNone( 'abc', /\w+/ );
  test.identical( got, false );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentNone( /\w+/, /\w+/ );
  test.identical( got, false );

  test.close( 'scalar, false' );

  /* - */

  test.open( 'scalar, true' );

  test.case = 'strings';
  var got = _.strsEquivalentNone( 'abd', 'abc' );
  test.identical( got, true );

  test.case = 'regexp and string';
  var got = _.strsEquivalentNone( /\s+/, 'abc' );
  test.identical( got, true );

  test.case = 'regexp and string';
  var got = _.strsEquivalentNone( /\w/, 'abc' );
  test.identical( got, true );

  test.case = 'string and regexp';
  var got = _.strsEquivalentNone( 'abc', /\s+/ );
  test.identical( got, true );

  test.case = 'string and regexp';
  var got = _.strsEquivalentNone( 'abc', /\w/ );
  test.identical( got, true );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentNone( /\w*/, /\w+/ );
  test.identical( got, true );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentNone( /\w+/g, /\w+/ );
  test.identical( got, true );

  test.case = 'regexp and regexp';
  var got = _.strsEquivalentNone( /\w+/g, /\w+/gi );
  test.identical( got, true );

  test.close( 'scalar, true' );

  /* - */

  test.open( 'vectors, true' );

  test.case = 'mixed vector, scalar - string';
  var src1 = [ 'abc', /\w+/, 'ab', /\w+/ ];
  var src2 = 'abc d';
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'mixed vector, scalar - regexp';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/g ];
  var src2 = /\w+\s/;
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - string, mixed vector';
  var src1 = 'abc d';
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - regexp, mixed vector';
  var src1 = /\w+\s/g;
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of regexp, scalar - string';
  var src1 = [ /\w+/g, /\w+/gi ];
  var src2 = 'abc d';
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of regexp, scalar - regexp';
  var src1 = [ /\w+/g, /\w+/g ];
  var src2 = /\w+/gi;
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - string, vector of regexp';
  var src1 = 'abc d';
  var src2 = [ /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar - regexp, vector of regexp';
  var src1 = /\w+/gi;
  var src2 = [ /\w+/g, /\w+/g ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of strings, vector of strings';
  var src1 = [ 'abc', 'abc', 'bbb', 'aaa' ];
  var src2 = [ 'ab', 'ab', 'aa', 'bb' ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of regexp, vector of strings';
  var src1 = [ /\w+/, /\w+/gi, /\w+/g, /\w+/ ];
  var src2 = [ 'abc d', 'abc d', 'aaa d', 'bbb d' ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'vector of strings, vector of regexp';
  var src1 = [ 'abc d', 'abc', 'aaa', 'bbb d' ];
  var src2 = [ /\w+/, /\w+\s/gi, /\w+\s/g, /\w+/ ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'mixed vector, mixed vector';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = [ 'ab', 'abc d', /\w+\s/, /\w+/gi ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.close( 'vectors, true' );

  /* - */

  test.open( 'vectors, false' );

  test.case = 'mixed vector, scalar - string';
  var src1 = [ 'ab', /\w+/, 'ab', /\w+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'mixed vector, scalar - regexp';
  var src1 = [ 'abc d', /\w+/g, 'abc d', /\w+/ ];
  var src2 = /\w+/;
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - string, mixed vector';
  var src1 = 'abc d';
  var src2 = [ 'abc', /\w+/, 'abc d', /\w+/ ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - regexp, mixed vector';
  var src1 = /\w+/;
  var src2 = [ 'abc d', /\w+/g, 'abc d', /\w+/ ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of regexp, scalar - string';
  var src1 = [ /\w+\s\w/g, /\w+/gi ];
  var src2 = 'abc d';
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of regexp, scalar - regexp';
  var src1 = [ /\w+/, /\w+/g ];
  var src2 = /\w+/g;
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - string, vector of regexp';
  var src1 = 'abc';
  var src2 = [ /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar - regexp, vector of regexp';
  var src1 = /\w+/g;
  var src2 = [ /\w+/gi, /\w+/g ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of strings, vector of strings';
  var src1 = [ 'abc', 'abc', 'aaa', 'bbb' ];
  var src2 = [ 'ab', 'ab', 'aa', 'bbb' ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of regexp, vector of strings';
  var src1 = [ /\w+/, /\w+/gi, /\w+/g, /\w+/ ];
  var src2 = [ 'abc', 'abc d', 'aaa d', 'bbb d' ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'vector of strings, vector of regexp';
  var src1 = [ 'abc d', 'abc d', 'aaa d', 'bbb' ];
  var src2 = [ /\w+/, /\w+/gi, /\w+/g, /\w+/ ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'mixed vector, mixed vector';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = [ 'ab', 'abc', /\w+/, /\w+/ ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.close( 'vectors, false' );
}

//

function strBeginOf( test )
{
  test.case = 'begin - empty string';
  var got = _.strBeginOf( 'abc', '' );
  var expected = '';
  test.identical( got, expected )

  test.case = 'begin - char';
  var got = _.strBeginOf( 'abc', 'c' );
  var expected = false;
  test.identical( got, expected )

  test.case = 'begin - two chars';
  var got = _.strBeginOf( 'abc', 'bc' );
  var expected = false;
  test.identical( got, expected )

  test.case = 'begin.length > src.length';
  var got = _.strBeginOf( 'abc', 'abcd' );
  var expected = false;
  test.identical( got, expected )

  test.case = 'begin.length === src.length, not equal';
  var got = _.strBeginOf( 'abc', 'cba' );
  var expected = false;
  test.identical( got, expected )

  test.case = 'begin.length === src.length, equal';
  var got = _.strBeginOf( 'abc', 'abc' );
  var expected = 'abc';
  test.identical( got, expected )

  test.case = 'begin - empty array';
  var got = _.strBeginOf( 'abc', [] );
  var expected = false;
  test.identical( got, expected )

  test.case = 'begin - array with empty string';
  var got = _.strBeginOf( 'abc', [ '' ] );
  var expected = '';
  test.identical( got, expected )

  test.case = 'begin - array strings, not begins';
  var got = _.strBeginOf( 'abccc', [ 'c', 'ccc' ] );
  var expected = false;
  test.identical( got, expected )

  test.case = 'begin - array strings, begins';
  var got = _.strBeginOf( 'abc', [ 'a', 'ab', 'abc' ] );
  var expected = 'a';
  test.identical( got, expected )

  test.case = 'begin - array strings, not begins';
  var got = _.strBeginOf( 'abc', [ 'x', 'y', 'c' ] );
  var expected = false;
  test.identical( got, expected )

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strBeginOf() );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strBeginOf( 1, '' ) );

  test.case = 'wrong type of begin';
  test.shouldThrowErrorSync( () => _.strBeginOf( 'abc', 1 ) );

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( () => _.strBeginOf( undefined, undefined ) );
  test.shouldThrowErrorSync( () => _.strBeginOf( null, null ) );
}

//

function strEndOf( test )
{
  var got, expected;

  //

  test.case = 'strEndOf';

  /**/

  got = _.strEndOf( 'abc', '' );
  expected = '';
  test.identical( got, expected )

  /**/

  got = _.strEndOf( 'abc', 'a' );
  expected = false;
  test.identical( got, expected )

  /**/

  got = _.strEndOf( 'abc', 'ab' );
  expected = false;
  test.identical( got, expected )

  /**/

  got = _.strEndOf( 'abc', ' a' );
  expected = false;
  test.identical( got, expected )

  /* end.length > src.length */

  got = _.strEndOf( 'abc', 'abcd' );
  expected = false;
  test.identical( got, expected )

  /* same length */

  got = _.strEndOf( 'abc', 'cba' );
  expected = false;
  test.identical( got, expected )

  /* equal */

  got = _.strEndOf( 'abc', 'abc' );
  expected = 'abc';
  test.identical( got, expected )

  /* array */

  got = _.strEndOf( 'abc', [] );
  expected = false;
  test.identical( got, expected )

  /**/

  got = _.strEndOf( 'abc', [ '' ] );
  expected = '';
  test.identical( got, expected )

  /**/

  got = _.strEndOf( 'abccc', [ 'a', 'ab' ] );
  expected = false;
  test.identical( got, expected )

  /**/

  got = _.strEndOf( 'abc', [ 'ab', 'abc' ] );
  expected = 'abc';
  test.identical( got, expected )

  /**/

  got = _.strEndOf( 'abc', [ 'x', 'y', 'a' ] );
  expected = false;
  test.identical( got, expected )

  /**/

  got = _.strEndOf( 'abc', [ 'x', 'y', 'z' ] );
  expected = false;
  test.identical( got, expected )

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.strEndOf( 1, '' ) );
  test.shouldThrowErrorSync( () => _.strEndOf( 'abc', 1 ) );
  test.shouldThrowErrorSync( () => _.strEndOf() );
  test.shouldThrowErrorSync( () => _.strEndOf( undefined, undefined ) );
  test.shouldThrowErrorSync( () => _.strEndOf( null, null ) );

}

//

function strBegins( test )
{
  var got, expected;

  //

  test.case = 'strBegins';

  /**/

  got = _.strBegins( '', '' );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strBegins( 'a', '' );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strBegins( 'a', 'a' );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strBegins( 'a', 'b' );
  expected = false;
  test.identical( got, expected );

  /**/

  got = _.strBegins( 'abc', 'ab' );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strBegins( 'abc', 'abc' );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strBegins( 'abc', ' a' );
  expected = false;
  test.identical( got, expected );

  /**/

  got = _.strBegins( 'abc', [ 'x', 'y', 'ab' ] );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strBegins( 'abc', [ '' ] );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strBegins( 'abc', [] );
  expected = false;
  test.identical( got, expected );

  /**/

  got = _.strBegins( 'abc', [ '1', 'b', 'a' ] );
  expected = true;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.strBegins( 1, '' ) );
  test.shouldThrowErrorSync( () => _.strBegins( 'a', 1 ) );
  test.shouldThrowErrorSync( () => _.strBegins( 'abc', [ 1, 'b', 'a' ] ) );

}

//

function strEnds( test )
{
  var got, expected;

  //

  test.case = 'strEnds';

  /**/

  got = _.strEnds( '', '' );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strEnds( 'a', '' );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strEnds( 'a', 'a' );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strEnds( 'a', 'b' );
  expected = false;
  test.identical( got, expected );

  /**/

  got = _.strEnds( 'abc', 'bc' );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strEnds( 'abc', 'abc' );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strEnds( 'abc', [ 'x', 'y', 'bc' ] );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strEnds( 'abc', [ '' ] );
  expected = true;
  test.identical( got, expected );

  /**/

  got = _.strEnds( 'abc', [] );
  expected = false;
  test.identical( got, expected );

  /**/

  got = _.strEnds( 'abc', [ '1', 'b', 'c' ] );
  expected = true;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.strEnds( 1, '' ) );
  test.shouldThrowErrorSync( () => _.strEnds( 'a', 1 ) );
}

// --
// converter
// --

function strShort( test )
{

  test.case = 'undefined';
  var src = undefined;
  var expected = 'undefined';
  var got = _.strShort( src );
  test.identical( got, expected );

  test.case = 'null';
  var src = null;
  var expected = 'null';
  var got = _.strShort( src );
  test.identical( got, expected );

  test.case = 'number';
  var src = 13;
  var expected = '13';
  var got = _.strShort( src );
  test.identical( got, expected );

  test.case = 'boolean';
  var src = false;
  var expected = 'false';
  var got = _.strShort( src );
  test.identical( got, expected );

  test.case = 'string';
  var src = 'abc';
  var expected = 'abc';
  var got = _.strShort( src );
  test.identical( got, expected );

}

//

function strPrimitive( test )
{

  test.case = 'undefined';
  var src = undefined;
  var expected = undefined;
  var got = _.strPrimitive( src );
  test.identical( got, expected );

  test.case = 'null';
  var src = null;
  var expected = undefined;
  var got = _.strPrimitive( src );
  test.identical( got, expected );

  test.case = 'number';
  var src = 13;
  var expected = '13';
  var got = _.strPrimitive( src );
  test.identical( got, expected );

  test.case = 'boolean';
  var src = false;
  var expected = 'false';
  var got = _.strPrimitive( src );
  test.identical( got, expected );

  test.case = 'string';
  var src = 'abc';
  var expected = 'abc';
  var got = _.strPrimitive( src );
  test.identical( got, expected );

}

//

function strQuote( test )
{
  test.open( 'default quote' );

  test.case = 'src - empty string';
  var got = _.strQuote( '' );
  test.identical( got, '""' );

  test.case = 'src - number';
  var got = _.strQuote( 1 );
  test.identical( got, '"1"' );

  test.case = 'src - null';
  var got = _.strQuote( null );
  test.identical( got, '"null"' );

  test.case = 'src - undefined';
  var got = _.strQuote( undefined );
  test.identical( got, '"undefined"' );

  test.case = 'src - boolean';
  var got = _.strQuote( false );
  test.identical( got, '"false"' );

  test.case = 'src - string';
  var got = _.strQuote( 'str' );
  test.identical( got, '"str"' );

  // test.case = 'src - map';
  // var got = _.strQuote( { src : {} } );
  // test.identical( got, '"[object Object] "' );
  //
  // test.case = 'src - Set';
  // var got = _.strQuote( new Set() );
  // test.identical( got, '"[object Set] "' );
  //
  // test.case = 'src - BufferRaw';
  // var got = _.strQuote( new BufferRaw( 10 ) );
  // test.identical( got, '"[object ArrayBuffer] "' );

  test.case = 'src - empty array';
  var got = _.strQuote( [] );
  test.identical( got, [] );

  test.case = 'src - array with elements';
  var got = _.strQuote( [ 0, '', undefined, null, true, 'str' ] );
  test.identical( got, [ '"0"', '""', '"undefined"', '"null"', '"true"', '"str"' ] );

  test.case = 'src - array with elements, quote - null';
  var got = _.strQuote( [ 0, '', undefined, null, true, 'str' ] );
  test.identical( got, [ '"0"', '""', '"undefined"', '"null"', '"true"', '"str"' ] );

  //

  test.case = 'src - empty string';
  var got = _.strQuote( { src : '' } );
  test.identical( got, '""' );

  test.case = 'src - number';
  var got = _.strQuote( { src : 1 } );
  test.identical( got, '"1"' );

  test.case = 'src - null';
  var got = _.strQuote( { src : null } );
  test.identical( got, '"null"' );

  test.case = 'src - undefined';
  var got = _.strQuote( { src : undefined } );
  test.identical( got, '"undefined"' );

  test.case = 'src - boolean';
  var got = _.strQuote( { src : false } );
  test.identical( got, '"false"' );

  test.case = 'src - string';
  var got = _.strQuote( { src : 'str' } );
  test.identical( got, '"str"' );

  test.case = 'src - empty array';
  var got = _.strQuote( { src : [] } );
  test.identical( got, [] );

  test.case = 'src - array with elements';
  var got = _.strQuote( { src : [ 0, '', undefined, null, true, 'str' ] } );
  test.identical( got, [ '"0"', '""', '"undefined"', '"null"', '"true"', '"str"' ] );

  test.case = 'src - array with elements, quote - null';
  var got = _.strQuote( { src : [ 0, '', undefined, null, true, 'str' ], quote : null } );
  test.identical( got, [ '"0"', '""', '"undefined"', '"null"', '"true"', '"str"' ] );

  test.close( 'default quote' );

  /* - */

  test.open( 'passed quote' );

  test.case = 'src - empty string';
  var got = _.strQuote( '', '`' );
  test.identical( got, '``' );

  test.case = 'src - number';
  var got = _.strQuote( 1, '--' );
  test.identical( got, '--1--' );

  test.case = 'src - null';
  var got = _.strQuote( null, '**' );
  test.identical( got, '**null**' );

  test.case = 'src - undefined';
  var got = _.strQuote( undefined, '||' );
  test.identical( got, '||undefined||' );

  test.case = 'src - boolean';
  var got = _.strQuote( false, '' );
  test.identical( got, 'false' );

  test.case = 'src - string';
  var got = _.strQuote( 'str', '_' );
  test.identical( got, '_str_' );

  test.case = 'src - empty array';
  var got = _.strQuote( [], 'a' );
  test.identical( got, [] );

  test.case = 'src - array with elements';
  var got = _.strQuote( [ 0, '', undefined, null, true, 'str' ], '"' );
  test.identical( got, [ '"0"', '""', '"undefined"', '"null"', '"true"', '"str"' ] );

  //

  test.case = 'src - empty string';
  var got = _.strQuote( { src : '', quote : '\'' } );
  test.identical( got, "''" );

  test.case = 'src - number';
  var got = _.strQuote( { src : 1, quote : '``' } );
  test.identical( got, '``1``' );

  test.case = 'src - null';
  var got = _.strQuote( { src : null, quote : '**' } );
  test.identical( got, '**null**' );

  test.case = 'src - undefined';
  var got = _.strQuote( { src : undefined, quote : '|' } );
  test.identical( got, '|undefined|' );

  test.case = 'src - boolean';
  var got = _.strQuote( { src : false, quote : '\'' } );
  test.identical( got, "'false'" );

  test.case = 'src - string';
  var got = _.strQuote( { src : 'str', quote : '""' } );
  test.identical( got, '""str""' );

  test.case = 'src - empty array';
  var got = _.strQuote( { src : [], quote : '"' } );
  test.identical( got, [] );

  test.case = 'src - array with elements';
  var got = _.strQuote( { src : [ 0, '', undefined, null, true, 'str' ], quote : '"' } );
  test.identical( got, [ '"0"', '""', '"undefined"', '"null"', '"true"', '"str"' ] );

  test.close( 'passed quote' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strQuote() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strQuote( 'a', '"', 'extra' ) );

  test.case = 'unnacessary fields in options map';
  test.shouldThrowErrorSync( () => _.strQuote( { src : 'a', quote : '"', dst : [] } ) );
}

//

function strUnquote( test )
{
  test.open( 'default quote' );

  test.case = 'src - empty string';
  var got = _.strUnquote( '' );
  test.identical( got, '' );

  test.case = 'src - not quoted string';
  var got = _.strUnquote( 'abc' );
  test.identical( got, 'abc' );

  test.case = 'src - single quote';
  var got = _.strUnquote( '"abc' );
  test.identical( got, '"abc' );

  test.case = 'src - string with quotes';
  var got = _.strUnquote( '"", `abc` \'\'' );
  test.identical( got, '"", `abc` \'\'' );

  test.case = 'src - quoted string';
  var got = _.strUnquote( '"abc"' );
  test.identical( got, 'abc' );

  test.case = 'src - twice quoted string';
  var got = _.strUnquote( '""abc""' );
  test.identical( got, '"abc"' );

  test.case = 'src - empty array';
  var got = _.strUnquote( [] );
  test.identical( got, [] );

  test.case = 'src - array of strings';
  var got = _.strUnquote( [ 'a', '"b"', '`c`', "'d'", '""abc""' ] );
  test.identical( got, [ 'a', 'b', 'c', 'd', '"abc"' ] );

  test.case = 'src - array of strings, quote - null';
  var got = _.strUnquote( [ 'a', '"b"', '`c`', "'d'", '""abc""' ], null );
  test.identical( got, [ 'a', 'b', 'c', 'd', '"abc"' ] );

  /* */

  test.case = 'src - empty string';
  var got = _.strUnquote( { src : '' } );
  test.identical( got, '' );

  test.case = 'src - not quoted string';
  var got = _.strUnquote( { src : 'abc' } );
  test.identical( got, 'abc' );

  test.case = 'src - single quote';
  var got = _.strUnquote( { src : '"abc' } );
  test.identical( got, '"abc' );

  test.case = 'src - string with quotes';
  var got = _.strUnquote( { src : '"", `abc` \'\'' } );
  test.identical( got, '"", `abc` \'\'' );

  test.case = 'src - quoted string';
  var got = _.strUnquote( { src : '"abc"' } );
  test.identical( got, 'abc' );

  test.case = 'src - twice quoted string';
  var got = _.strUnquote( { src : '""abc""' } );
  test.identical( got, '"abc"' );

  test.case = 'src - empty array';
  var got = _.strUnquote( { src : [] } );
  test.identical( got, [] );

  test.case = 'src - array of strings';
  var got = _.strUnquote( { src : [ 'a', '"b"', '`c`', "'d'", '""abc""' ] } );
  test.identical( got, [ 'a', 'b', 'c', 'd', '"abc"' ] );

  test.case = 'src - array of strings, quote - null';
  var got = _.strUnquote( { src : [ 'a', '"b"', '`c`', "'d'", '""abc""' ], quote : null } );
  test.identical( got, [ 'a', 'b', 'c', 'd', '"abc"' ] );

  test.close( 'default quote' );

  /* - */

  test.open( 'passed quote' );

  test.case = 'src - empty string';
  var got = _.strUnquote( '', '*' );
  test.identical( got, '' );

  test.case = 'src - not quoted string';
  var got = _.strUnquote( 'abc', '' );
  test.identical( got, 'abc' );

  test.case = 'src - single quote';
  var got = _.strUnquote( '"abc', '`' );
  test.identical( got, '"abc' );

  test.case = 'src - string with quotes';
  var got = _.strUnquote( '**"", `abc` \'\'**', '**' );
  test.identical( got, '"", `abc` \'\'' );

  test.case = 'src - quoted string';
  var got = _.strUnquote( '"abc"', '\'' );
  test.identical( got, '"abc"' );

  test.case = 'src - twice quoted string';
  var got = _.strUnquote( '""abc""', '`' );
  test.identical( got, '""abc""' );

  test.case = 'src - empty array';
  var got = _.strUnquote( [], '|' );
  test.identical( got, [] );

  test.case = 'src - array of strings';
  var got = _.strUnquote( [ 'a', '"b"', '`c`', "'d'", '""abc""' ], '`' );
  test.identical( got, [ 'a', '"b"', 'c', "'d'", '""abc""' ] );

  /* */

  test.case = 'src - empty string';
  var got = _.strUnquote( { src : '', quote : '""' } );
  test.identical( got, '' );

  test.case = 'src - not quoted string';
  var got = _.strUnquote( { src : 'abc', quote : '' } );
  test.identical( got, 'abc' );

  test.case = 'src - single quote';
  var got = _.strUnquote( { src : '"abc', quote : '"' } );
  test.identical( got, '"abc' );

  test.case = 'src - string with quotes';
  var got = _.strUnquote( { src : '"", `abc` \'\'', quote : '\'' } );
  test.identical( got, '"", `abc` \'\'' );

  test.case = 'src - quoted string';
  var got = _.strUnquote( { src : '"abc"', quote : '`' } );
  test.identical( got, '"abc"' );

  test.case = 'src - twice quoted string';
  var got = _.strUnquote( { src : '""abc""', quote : '""' } );
  test.identical( got, 'abc' );

  test.case = 'src - empty array';
  var got = _.strUnquote( { src : [], quote : '""' } );
  test.identical( got, [] );

  test.case = 'src - array of strings';
  var got = _.strUnquote( { src : [ 'a', '"b"', '`c`', "'d'", '""abc""' ], quote : '`' } );
  test.identical( got, [ 'a', '"b"', 'c', "'d'", '""abc""' ] );

  test.close( 'passed quote' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strUnquote() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strUnquote( '"str"', '"', 'extra' ) );

  test.case = 'unnacessary fields in options map';
  test.shouldThrowErrorSync( () => _.strUnquote( { src : '"abc"', quote : '"', dst : [] } ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strUnquote( 1 ) );
  test.shouldThrowErrorSync( () => _.strUnquote( { src : 1, quote : '"', dst : [] } ) );
}

//

function strQuotePairsNormalize( test )
{
  test.case = 'quote - true';
  var got = _.strQuotePairsNormalize( true );
  var expected =
  [
    [ '"', '"' ],
    [ '`', '`' ],
    [ '\'', '\'' ]
  ];
  test.identical( got, expected );

  test.case = 'quote - boolLike';
  var got = _.strQuotePairsNormalize( 2 );
  var expected =
  [
    [ '"', '"' ],
    [ '`', '`' ],
    [ '\'', '\'' ]
  ];
  test.identical( got, expected );

  test.case = 'quote - empty string';
  var got = _.strQuotePairsNormalize( '' );
  var expected = [ [ '', '' ] ];
  test.identical( got, expected );

  test.case = 'quote - space';
  var got = _.strQuotePairsNormalize( ' ' );
  var expected = [ [ ' ', ' ' ] ];
  test.identical( got, expected );

  test.case = 'quote - new line symbol';
  var got = _.strQuotePairsNormalize( '\n' );
  var expected = [ [ '\n', '\n' ] ];
  test.identical( got, expected );

  test.case = 'quote - string';
  var got = _.strQuotePairsNormalize( 'str' );
  var expected = [ [ 'str', 'str' ] ];
  test.identical( got, expected );

  test.case = 'quote - array with strings';
  var got = _.strQuotePairsNormalize( [ '', ' ', '\n', 'str' ] );
  var expected =
  [
    [ '', '' ],
    [ ' ', ' ' ],
    [ '\n', '\n' ],
    [ 'str', 'str' ]
  ];
  test.identical( got, expected );

  test.case = 'quote - array with duplicated strings';
  var got = _.strQuotePairsNormalize( [ '', '', ' ',  ' ', '\n', '\n', 'str', 'str' ] );
  var expected =
  [
    [ '', '' ], [ '', '' ],
    [ ' ', ' ' ], [ ' ', ' ' ],
    [ '\n', '\n' ], [ '\n', '\n' ],
    [ 'str', 'str' ], [ 'str', 'str' ]
  ];
  test.identical( got, expected );

  test.case = 'quote - array with quete pairs';
  var got = _.strQuotePairsNormalize( [ [ '', '' ], [ ' ',  ' ' ], [ '\n', '\n' ], [ 'str', 'str' ] ] );
  var expected =
  [
    [ '', '' ],
    [ ' ', ' ' ],
    [ '\n', '\n' ],
    [ 'str', 'str' ]
  ];
  test.identical( got, expected );

  test.case = 'quote - mixed array with quete pairs and strings';
  var got = _.strQuotePairsNormalize( [ [ '', '' ], '', [ ' ',  ' ' ], '""', [ '\n', '\n' ], '\t', [ 'str', 'str' ], 'src' ] );
  var expected =
  [
    [ '', '' ], [ '', '' ],
    [ ' ', ' ' ], [ '""', '""' ],
    [ '\n', '\n' ], [ '\t', '\t' ],
    [ 'str', 'str' ], [ 'src', 'src' ]
  ];
  test.identical( got, expected );

  test.case = 'quote - array with mixed quete pairs';
  var got = _.strQuotePairsNormalize( [ [ '', '""' ], [ ' ',  '\t' ], [ '\n', '\r' ], [ 'str', 'src' ] ] );
  var expected =
  [
    [ '', '""' ],
    [ ' ', '\t' ],
    [ '\n', '\r' ],
    [ 'str', 'src' ]
  ];
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strQuotePairsNormalize() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strQuotePairsNormalize( '"', 'extra' ) );

  test.case = 'wrong type of quete';
  test.shouldThrowErrorSync( () => _.strQuotePairsNormalize( { '' : '' } ) );
  test.shouldThrowErrorSync( () => _.strQuotePairsNormalize( null ) );

  test.case = 'wrong type of quete in array';
  test.shouldThrowErrorSync( () => _.strQuotePairsNormalize( [ ',', 1 ] ) );
  test.shouldThrowErrorSync( () => _.strQuotePairsNormalize( [ '""', [ ',', {} ] ] ) );

  test.case = 'quote pair is not pair';
  test.shouldThrowErrorSync( () => _.strQuotePairsNormalize( [ [ '', '', 'str' ] ] ) );

  test.case = 'boolLike argument - false';
  test.shouldThrowErrorSync( () => _.strQuotePairsNormalize( false ) );
  test.shouldThrowErrorSync( () => _.strQuotePairsNormalize( 0 ) );
}

//

function strQuoteAnalyze( test )
{

  test.case = 'empty';
  var expected =
  {
    ranges : [],
    quotes : [],
  };
  var got = _.strQuoteAnalyze( '' );
  test.identical( got, expected );

  test.case = 'no quote';
  var expected =
  {
    ranges : [],
    quotes : [],
  };
  var got = _.strQuoteAnalyze( 'a b c' );
  test.identical( got, expected );

  test.case = 'left "';
  var expected =
  {
    ranges : [ 0, 4 ],
    quotes : [ '"' ],
  };
  var got = _.strQuoteAnalyze( '"a b" c' );
  test.identical( got, expected );

  test.case = 'mid "';
  var expected =
  {
    ranges : [ 1, 5 ],
    quotes : [ '"' ],
  };
  var got = _.strQuoteAnalyze( 'a" b "c' );
  test.identical( got, expected );

  test.case = 'right "';
  var expected =
  {
    ranges : [ 2, 6 ],
    quotes : [ '"' ],
  };
  var got = _.strQuoteAnalyze( 'a "b c"' );
  test.identical( got, expected );

  test.case = 'several';
  var expected =
  {
    ranges : [ 0, 3, 4, 8 ],
    quotes : [ '`', '"' ],
  };
  var got = _.strQuoteAnalyze( '`a `"b c"`' );
  test.identical( got, expected );

  test.case = 'several empty';
  var expected =
  {
    ranges : [ 0, 1, 2, 5, 6, 7, 8, 12, 13, 14, 15, 16 ],
    quotes : [ '"', '`', '"', '"', '`', '"' ],
  };
  var got = _.strQuoteAnalyze( '""`a `"""b c"``""' );
  test.identical( got, expected );

  test.case = 'src = string, quote - null ';
  var expected =
  {
    ranges : [ 1, 5, 6, 9 ],
    quotes : [ "'", "`" ]
  };
  var got = _.strQuoteAnalyze( "a', b'`,c` \"", null );
  test.identical( got, expected );

  test.case = 'src = string, quote - "\'" ';
  var expected =
  {
    ranges : [ 1, 5 ],
    quotes : [ "'" ]
  };
  var got = _.strQuoteAnalyze( "a', b'`,c` \"", "'" );
  test.identical( got, expected );

  test.case = 'src = string, quote - array with quotes';
  var expected =
  {
    ranges : [ 1, 5, 6, 9 ],
    quotes : [ "'", "`" ]
  };
  var got = _.strQuoteAnalyze( "a', b'`,c` \"", [ '\'', '`' ] );
  test.identical( got, expected );

  test.case = 'src = string, quote - array with pairs of quotes';
  var expected =
  {
    ranges : [ 1, 5, 6, 9 ],
    quotes : [ "'", "`" ]
  };
  var got = _.strQuoteAnalyze( "a', b'`,c` \"", [ [ '\'', '\'' ], '`' ] );
  test.identical( got, expected );

  test.case = 'src = string, quote - string';
  var expected =
  {
    ranges : [ 0, 4, 7, 11 ],
    quotes : [ '--', '--' ]
  };
  var got = _.strQuoteAnalyze( "--aa-- --bb--``''\"\",,cc,,", '--' );
  test.identical( got, expected );

  test.case = 'src = string, quote - pairs of different strings';
  var expected =
  {
    ranges : [ 0, 4 ],
    quotes : [ '**' ]
  };
  var got = _.strQuoteAnalyze( "**aa--- --bb--``''\"\",,cc,,", [ [ '**', '---' ] ] );
  test.identical( got, expected );

  test.case = 'options map "';
  var expected =
  {
    ranges : [ 1, 5 ],
    quotes : [ '"' ],
  };
  var got = _.strQuoteAnalyze({ src : 'a" b "c', quote : [ '"', '`', '\'' ] });
  test.identical( got, expected );

  test.case = 'options map quote:``';
  var expected =
  {
    ranges : [ 1, 6 ],
    quotes : [ '``' ],
  };
  var got = _.strQuoteAnalyze({ src : 'a`` b ``c', quote : [ '"', '``', '\'' ] });
  test.identical( got, expected );

  test.case = 'options map quote:1';
  var expected =
  {
    ranges : [ 1, 4, 5, 8 ],
    quotes : [ '`', '"' ],
  };
  var got = _.strQuoteAnalyze({ src : 'a` b`" c"', quote : 1 });
  test.identical( got, expected );

  test.case = 'pair';
  var expected =
  {
    ranges : [ 1, 6 ],
    quotes : [ '``' ],
  };
  var got = _.strQuoteAnalyze({ src : 'a`` b ""c', quote : [ '"', [ '``', '""' ], '\'' ] });
  test.identical( got, expected );

  test.case = 'pair reverted';
  var expected =
  {
    ranges : [ 1, 2 ],
    quotes : [ '"' ],
  };
  var got = _.strQuoteAnalyze({ src : 'a"" b ``c', quote : [ '"', [ '``', '""' ], '\'' ] });
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strQuoteAnalyze() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strQuoteAnalyze( '\'a\'"b"`c`', null, 'extra' ) );

  test.case = 'wrong types of quote';
  test.shouldThrowErrorSync( () => _.strQuoteAnalyze( '\'a\'"b"`c`', {} ) );
}

//

function strInsideOf( test )
{
  test.open( 'string' );

  test.case = 'src - empty string, begin - empty string, end - empty string';
  var got = _.strInsideOf( '', '', '' );
  test.identical( got, '' );

  test.case = 'src - empty string, begin - empty string, end - !!!';
  var got = _.strInsideOf( '', '', '!!!' );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - empty string';
  var got = _.strInsideOf( '', '!!!', '' );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - !!!';
  var got = _.strInsideOf( '', '!!!', '!!!' );
  test.identical( got, false );

  /* */

  test.case = 'src - string, begin - empty string, end - empty string';
  var got = _.strInsideOf( 'str', '', '' );
  test.identical( got, 'str' );

  test.case = 'src - string, begin - empty string, end - !!!, not equal';
  var got = _.strInsideOf( 'str', '', '!!!' );
  test.identical( got, false );

  test.case = 'src - string, begin - !!!, not equal, end - empty string';
  var got = _.strInsideOf( 'str', '!!!', '' );
  test.identical( got, false );

  test.case = 'src - string, begin - !!!, not equal, end - !!!, not equal';
  var got = _.strInsideOf( 'str', '!!!', '!!!' );
  test.identical( got, false );

  /* */

  test.case = 'src - string, almost equal, begin - empty string, end - !!!';
  var got = _.strInsideOf( '!!!str!!!', '', '!!!' );
  test.identical( got, '!!!str' );

  test.case = 'src - string, almost equal, begin - !!!, end - empty string';
  var got = _.strInsideOf( '!!!str!!!', '!!!', '' );
  test.identical( got, 'str!!!' );

  test.case = 'src - string, almost equal, begin - !!!, end - !!!';
  var got = _.strInsideOf( '!!!str!!!', '!!!', '!!!' );
  test.identical( got, 'str' );

  /* */

  test.case = 'src - string, little difference, begin - empty string, end - !!!';
  var got = _.strInsideOf( '!!str!!', '', '!!!' );
  test.identical( got, false );

  test.case = 'src - string, little difference, begin - !!!, end - empty string';
  var got = _.strInsideOf( '!!str!!', '!!!', '' );
  test.identical( got, false );

  test.case = 'src - string, little difference, begin - !!!, end - !!!';
  var got = _.strInsideOf( '!!str!!', '!!!', '!!!' );
  test.identical( got, false );

  /* */

  test.case = 'src - string, equals inside string, begin - empty string, end - !!!';
  var got = _.strInsideOf( 'str!!!str!!!str', '', '!!!' );
  test.identical( got, false );

  test.case = 'src - string, equals inside string, begin - !!!, end - empty string';
  var got = _.strInsideOf( 'str!!!str!!!str', '!!!', '' );
  test.identical( got, false );

  test.case = 'src - string, equals inside string, begin - !!!, end - !!!';
  var got = _.strInsideOf( 'str!!!str!!!str', '!!!', '!!!' );
  test.identical( got, false );

  test.close( 'string' );

  /* - */

  test.open( 'array' );

  test.case = 'src - empty string, begin - empty strings, end - empty strings';
  var got = _.strInsideOf( '', [ '', '', '' ], [ '', '', '' ] );
  test.identical( got, '' );

  test.case = 'src - empty string, begin - empty strings, end - !!!';
  var got = _.strInsideOf( '', [ '', '' ], [ '!!!', '!!!' ] );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - empty strings';
  var got = _.strInsideOf( '', [ '!!!', '!!!' ], [ '', '' ] );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - !!!';
  var got = _.strInsideOf( '', [ '!!!', '!!!' ], [ '!!!', '!!!' ] );
  test.identical( got, false );

  /* */

  test.case = 'src - string, begin - empty strings, end - empty strings';
  var got = _.strInsideOf( 'str', [ '', '', '' ], [ '', '', '' ] );
  test.identical( got, 'str' );

  test.case = 'src - string, begin - empty string, end - mixed, not equal';
  var got = _.strInsideOf( 'str', [ '' ], [ '!!!', 'q', 'b' ] );
  test.identical( got, false );

  test.case = 'src - string, begin - mixed, not equal, end - empty string';
  var got = _.strInsideOf( 'str', [ '!!!', 'q', 'b' ], [ '' ] );
  test.identical( got, false );

  test.case = 'src - string, begin - mixed, not equal, end - mixed, not equal';
  var got = _.strInsideOf( 'str', [ '!!!', 'q', 'b' ], [ '!!!', 'q', 'b' ] );
  test.identical( got, false );

  /* */

  test.case = 'src - string, almost equal, begin - empty string, end - mix';
  var got = _.strInsideOf( '!!!str!!!', [ '' ], [ '!', '!!', '!!!' ] );
  test.identical( got, '!!!str!!' );

  test.case = 'src - string, almost equal, begin - mixed, end - empty string';
  var got = _.strInsideOf( '!!!str!!!', [ '!', '!!', '!!!' ], [ '' ] );
  test.identical( got, '!!str!!!' );

  test.case = 'src - string, almost equal, begin - mixed, end - mixed';
  var got = _.strInsideOf( '!!!str!!!', [ '!', '!!', '!!!' ], [ '!', '!!', '!!!' ] );
  test.identical( got, '!!str!!' );

  /* */

  test.case = 'src - string, little difference, begin - empty string, end - mixed';
  var got = _.strInsideOf( '!!str!!', [ '' ], [ '!!!', '!!' ] );
  test.identical( got, '!!str' );

  test.case = 'src - string, little difference, begin - mixed, end - empty string';
  var got = _.strInsideOf( '!!str!!', [ '!!!', '!!' ], [ '' ] );
  test.identical( got, 'str!!' );

  test.case = 'src - string, little difference, begin - mixed, end - mixed';
  var got = _.strInsideOf( '!!str!!', [ '!!!', '!!' ], [ '!!!', '!!' ] );
  test.identical( got, 'str' );

  /* */

  test.case = 'src - string, equals inside string, begin - empty string, end - mixed';
  var got = _.strInsideOf( 'str!!!str!!!str', [ '' ], [ '!!!', 'str' ] );
  test.identical( got, 'str!!!str!!!' );

  test.case = 'src - string, equals inside string, begin - mixed, end - empty string';
  var got = _.strInsideOf( 'str!!!str!!!str', [ '!!!', 'str' ], [ '' ] );
  test.identical( got, '!!!str!!!str' );

  test.case = 'src - string, equals inside string, begin - mixed, end - mixed';
  var got = _.strInsideOf( 'str!!!str!!!str', [ '!!!', 'str' ], [ '!!!', 'str' ] );
  test.identical( got, '!!!str!!!' );

  test.close( 'array' );

  /* - */

  test.open( 'mixed' );

  test.case = 'src - empty string, begin - empty strings, end - empty strings';
  var got = _.strInsideOf( '', [ '', '', '' ], '' );
  test.identical( got, '' );

  test.case = 'src - empty string, begin - empty string, end - !!!';
  var got = _.strInsideOf( '', '', [ '!!!', '!!!' ] );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - empty string';
  var got = _.strInsideOf( '', [ '!!!', '!!!' ], '' );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - !!!';
  var got = _.strInsideOf( '', [ '!!!', '!!!' ], '!!!' );
  test.identical( got, false );

  /* */

  test.case = 'src - string, begin - empty string, end - mixed, not equal';
  var got = _.strInsideOf( 'str', '', [ '!!!', 'q', 'b' ] );
  test.identical( got, false );

  test.case = 'src - string, begin - mixed, not equal, end - empty string';
  var got = _.strInsideOf( 'str', [ '!!!', 'q', 'b' ], '' );
  test.identical( got, false );

  test.case = 'src - string, begin - mixed, not equal, end - string, not equal';
  var got = _.strInsideOf( 'str', [ '!!!', 'q', 'b' ], 'q' );
  test.identical( got, false );

  /* */

  test.case = 'src - string, almost equal, begin - empty string, end - mix';
  var got = _.strInsideOf( '!!!str!!!', '', [ '!', '!!', '!!!' ] );
  test.identical( got, '!!!str!!' );

  test.case = 'src - string, almost equal, begin - mixed, end - empty string';
  var got = _.strInsideOf( '!!!str!!!', [ '!', '!!', '!!!' ], '' );
  test.identical( got, '!!str!!!' );

  test.case = 'src - string, almost equal, begin - string, end - mixed';
  var got = _.strInsideOf( '!!!str!!!', '!!!', [ '!', '!!', '!!!' ] );
  test.identical( got, 'str!!' );

  /* */

  test.case = 'src - string, little difference, begin - empty string, end - mixed';
  var got = _.strInsideOf( '!!str!!', '', [ '!!!', '!!' ] );
  test.identical( got, '!!str' );

  test.case = 'src - string, little difference, begin - mixed, end - empty string';
  var got = _.strInsideOf( '!!str!!', [ '!!!', '!!' ], '' );
  test.identical( got, 'str!!' );

  test.case = 'src - string, little difference, begin - mixed, end - string';
  var got = _.strInsideOf( '!!str!!', [ '!!!', '!!' ], '!!' );
  test.identical( got, 'str' );

  /* */

  test.case = 'src - string, equals inside string, begin - empty string, end - mixed';
  var got = _.strInsideOf( 'str!!!str!!!str', '', [ '!!!', 'str' ] );
  test.identical( got, 'str!!!str!!!' );

  test.case = 'src - string, equals inside string, begin - mixed, end - empty string';
  var got = _.strInsideOf( 'str!!!str!!!str', [ '!!!', 'str' ], '' );
  test.identical( got, '!!!str!!!str' );

  test.case = 'src - string, equals inside string, begin - mixed, end - string';
  var got = _.strInsideOf( 'str!!!str!!!str', [ '!!!', 'str' ], '!!!' );
  test.identical( got, false );

  test.close( 'mixed' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strInsideOf() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.strInsideOf( 'str' ) );
  test.shouldThrowErrorSync( () => _.strInsideOf( 'str', 's' ) );

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( () => _.strInsideOf( 1, '', '' ) );
  test.shouldThrowErrorSync( () => _.strInsideOf( 'str', 1, '' ) );
  test.shouldThrowErrorSync( () => _.strInsideOf( 'str', '', 1 ) );
}

//

function strOutsideOf( test )
{
  test.open( 'string' );

  test.case = 'src - empty string, begin - empty string, end - empty string';
  var got = _.strOutsideOf( '', '', '' );
  test.identical( got, '' );

  test.case = 'src - empty string, begin - empty string, end - !!!';
  var got = _.strOutsideOf( '', '', '!!!' );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - empty string';
  var got = _.strOutsideOf( '', '!!!', '' );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - !!!';
  var got = _.strOutsideOf( '', '!!!', '!!!' );
  test.identical( got, false );

  /* */

  test.case = 'src - string, begin - empty string, end - empty string';
  var got = _.strOutsideOf( 'str', '', '' );
  test.identical( got, '' );

  test.case = 'src - string, begin - empty string, end - !!!, not equal';
  var got = _.strOutsideOf( 'str', '', '!!!' );
  test.identical( got, false );

  test.case = 'src - string, begin - !!!, not equal, end - empty string';
  var got = _.strOutsideOf( 'str', '!!!', '' );
  test.identical( got, false );

  test.case = 'src - string, begin - !!!, not equal, end - !!!, not equal';
  var got = _.strOutsideOf( 'str', '!!!', '!!!' );
  test.identical( got, false );

  /* */

  test.case = 'src - string, almost equal, begin - empty string, end - !!!';
  var got = _.strOutsideOf( '!!!str!!!', '', '!!!' );
  test.identical( got, '!!!' );

  test.case = 'src - string, almost equal, begin - !!!, end - empty string';
  var got = _.strOutsideOf( '!!!str!!!', '!!!', '' );
  test.identical( got, '!!!' );

  test.case = 'src - string, almost equal, begin - !!!, end - !!!';
  var got = _.strOutsideOf( '!!!str!!!', '!!!', '!!!' );
  test.identical( got, '!!!!!!' );

  /* */

  test.case = 'src - string, little difference, begin - empty string, end - !!!';
  var got = _.strOutsideOf( '!!str!!', '', '!!!' );
  test.identical( got, false );

  test.case = 'src - string, little difference, begin - !!!, end - empty string';
  var got = _.strOutsideOf( '!!str!!', '!!!', '' );
  test.identical( got, false );

  test.case = 'src - string, little difference, begin - !!!, end - !!!';
  var got = _.strOutsideOf( '!!str!!', '!!!', '!!!' );
  test.identical( got, false );

  /* */

  test.case = 'src - string, equals inside string, begin - empty string, end - !!!';
  var got = _.strOutsideOf( 'str!!!str!!!str', '', '!!!' );
  test.identical( got, false );

  test.case = 'src - string, equals inside string, begin - !!!, end - empty string';
  var got = _.strOutsideOf( 'str!!!str!!!str', '!!!', '' );
  test.identical( got, false );

  test.case = 'src - string, equals inside string, begin - !!!, end - !!!';
  var got = _.strOutsideOf( 'str!!!str!!!str', '!!!', '!!!' );
  test.identical( got, false );

  test.close( 'string' );

  /* - */

  test.open( 'array' );

  test.case = 'src - empty string, begin - empty strings, end - empty strings';
  var got = _.strOutsideOf( '', [ '', '', '' ], [ '', '', '' ] );
  test.identical( got, '' );

  test.case = 'src - empty string, begin - empty strings, end - !!!';
  var got = _.strOutsideOf( '', [ '', '' ], [ '!!!', '!!!' ] );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - empty strings';
  var got = _.strOutsideOf( '', [ '!!!', '!!!' ], [ '', '' ] );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - !!!';
  var got = _.strOutsideOf( '', [ '!!!', '!!!' ], [ '!!!', '!!!' ] );
  test.identical( got, false );

  /* */

  test.case = 'src - string, begin - empty strings, end - empty strings';
  var got = _.strOutsideOf( 'str', [ '', '', '' ], [ '', '', '' ] );
  test.identical( got, '' );

  test.case = 'src - string, begin - empty string, end - mixed, not equal';
  var got = _.strOutsideOf( 'str', [ '' ], [ '!!!', 'q', 'b' ] );
  test.identical( got, false );

  test.case = 'src - string, begin - mixed, not equal, end - empty string';
  var got = _.strOutsideOf( 'str', [ '!!!', 'q', 'b' ], [ '' ] );
  test.identical( got, false );

  test.case = 'src - string, begin - mixed, not equal, end - mixed, not equal';
  var got = _.strOutsideOf( 'str', [ '!!!', 'q', 'b' ], [ '!!!', 'q', 'b' ] );
  test.identical( got, false );

  /* */

  test.case = 'src - string, almost equal, begin - empty string, end - mix';
  var got = _.strOutsideOf( '!!!str!!!', [ '' ], [ '!', '!!', '!!!' ] );
  test.identical( got, '!' );

  test.case = 'src - string, almost equal, begin - mixed, end - empty string';
  var got = _.strOutsideOf( '!!!str!!!', [ '!', '!!', '!!!' ], [ '' ] );
  test.identical( got, '!' );

  test.case = 'src - string, almost equal, begin - mixed, end - mixed';
  var got = _.strOutsideOf( '!!!str!!!', [ '!', '!!', '!!!' ], [ '!', '!!', '!!!' ] );
  test.identical( got, '!!' );

  /* */

  test.case = 'src - string, little difference, begin - empty string, end - mixed';
  var got = _.strOutsideOf( '!!str!!', [ '' ], [ '!!!', '!!' ] );
  test.identical( got, '!!' );

  test.case = 'src - string, little difference, begin - mixed, end - empty string';
  var got = _.strOutsideOf( '!!str!!', [ '!!!', '!!' ], [ '' ] );
  test.identical( got, '!!' );

  test.case = 'src - string, little difference, begin - mixed, end - mixed';
  var got = _.strOutsideOf( '!!str!!', [ '!!!', '!!' ], [ '!!!', '!!' ] );
  test.identical( got, '!!!!' );

  /* */

  test.case = 'src - string, equals inside string, begin - empty string, end - mixed';
  var got = _.strOutsideOf( 'str!!!str!!!str', [ '' ], [ '!!!', 'str' ] );
  test.identical( got, 'str' );

  test.case = 'src - string, equals inside string, begin - mixed, end - empty string';
  var got = _.strOutsideOf( 'str!!!str!!!str', [ '!!!', 'str' ], [ '' ] );
  test.identical( got, 'str' );

  test.case = 'src - string, equals inside string, begin - mixed, end - mixed';
  var got = _.strOutsideOf( 'str!!!str!!!str', [ '!!!', 'str' ], [ '!!!', 'str' ] );
  test.identical( got, 'strstr' );

  test.close( 'array' );

  /* - */

  test.open( 'mixed' );

  test.case = 'src - empty string, begin - empty strings, end - empty strings';
  var got = _.strOutsideOf( '', [ '', '', '' ], '' );
  test.identical( got, '' );

  test.case = 'src - empty string, begin - empty string, end - !!!';
  var got = _.strOutsideOf( '', '', [ '!!!', '!!!' ] );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - empty string';
  var got = _.strOutsideOf( '', [ '!!!', '!!!' ], '' );
  test.identical( got, false );

  test.case = 'src - empty string, begin - !!!, end - !!!';
  var got = _.strOutsideOf( '', [ '!!!', '!!!' ], '!!!' );
  test.identical( got, false );

  /* */

  test.case = 'src - string, begin - empty string, end - mixed, not equal';
  var got = _.strOutsideOf( 'str', '', [ '!!!', 'q', 'b' ] );
  test.identical( got, false );

  test.case = 'src - string, begin - mixed, not equal, end - empty string';
  var got = _.strOutsideOf( 'str', [ '!!!', 'q', 'b' ], '' );
  test.identical( got, false );

  test.case = 'src - string, begin - mixed, not equal, end - string, not equal';
  var got = _.strOutsideOf( 'str', [ '!!!', 'q', 'b' ], 'q' );
  test.identical( got, false );

  /* */

  test.case = 'src - string, almost equal, begin - empty string, end - mix';
  var got = _.strOutsideOf( '!!!str!!!', '', [ '!', '!!', '!!!' ] );
  test.identical( got, '!' );

  test.case = 'src - string, almost equal, begin - mixed, end - empty string';
  var got = _.strOutsideOf( '!!!str!!!', [ '!', '!!', '!!!' ], '' );
  test.identical( got, '!' );

  test.case = 'src - string, almost equal, begin - string, end - mixed';
  var got = _.strOutsideOf( '!!!str!!!', '!!!', [ '!', '!!', '!!!' ] );
  test.identical( got, '!!!!' );

  /* */

  test.case = 'src - string, little difference, begin - empty string, end - mixed';
  var got = _.strOutsideOf( '!!str!!', '', [ '!!!', '!!' ] );
  test.identical( got, '!!' );

  test.case = 'src - string, little difference, begin - mixed, end - empty string';
  var got = _.strOutsideOf( '!!str!!', [ '!!!', '!!' ], '' );
  test.identical( got, '!!' );

  test.case = 'src - string, little difference, begin - mixed, end - string';
  var got = _.strOutsideOf( '!!str!!', [ '!!!', '!!' ], '!!' );
  test.identical( got, '!!!!' );

  /* */

  test.case = 'src - string, equals inside string, begin - empty string, end - mixed';
  var got = _.strOutsideOf( 'str!!!str!!!str', '', [ '!!!', 'str' ] );
  test.identical( got, 'str' );

  test.case = 'src - string, equals inside string, begin - mixed, end - empty string';
  var got = _.strOutsideOf( 'str!!!str!!!str', [ '!!!', 'str' ], '' );
  test.identical( got, 'str' );

  test.case = 'src - string, equals inside string, begin - mixed, end - string';
  var got = _.strOutsideOf( 'str!!!str!!!str', [ '!!!', 'str' ], '!!!' );
  test.identical( got, false );

  test.close( 'mixed' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strOutsideOf() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.strOutsideOf( 'str' ) );
  test.shouldThrowErrorSync( () => _.strOutsideOf( 'str', 's' ) );

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( () => _.strOutsideOf( 1, '', '' ) );
  test.shouldThrowErrorSync( () => _.strOutsideOf( 'str', 1, '' ) );
  test.shouldThrowErrorSync( () => _.strOutsideOf( 'str', '', 1 ) );
}

//--
// replacers
//--

function strRemoveBegin( test )
{
  test.open( 'src - string, begin - string' );

  test.case = 'empty string : empty string';
  var got = _.strRemoveBegin( '', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : x';
  var got = _.strRemoveBegin( '', 'x' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty string';
  var got = _.strRemoveBegin( 'abc', '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'include begin';
  var got = _.strRemoveBegin( 'abc', 'a' );
  var expected = 'bc';
  test.identical( got, expected );

  test.case = 'include begin, begin.length < src.length';
  var got = _.strRemoveBegin( 'abc', 'ab' );
  var expected = 'c';
  test.identical( got, expected );

  test.case = 'include begin, begin.length === src.length';
  var got = _.strRemoveBegin( 'abc', 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'not include begin';
  var got = _.strRemoveBegin( 'abc', 'd' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strRemoveBegin( 'abc', 'bc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, begin - string' );

  /* - */

  test.open( 'src - string, begin - array of strings' );

  test.case = 'empty string : empty strings';
  var got = _.strRemoveBegin( '', [ '', '', '' ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : strings';
  var got = _.strRemoveBegin( '', [ 'x', 'a', 'abc' ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty strings';
  var got = _.strRemoveBegin( 'abc', [ '', '', '' ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'include one of begins';
  var got = _.strRemoveBegin( 'abc', [ 'd', 'bc', 'a' ] );
  var expected = 'bc';
  test.identical( got, expected );

  test.case = 'include one of begins, begin.length < src.length';
  var got = _.strRemoveBegin( 'abc', [ 'bc', 'ab', 'da' ] );
  var expected = 'c';
  test.identical( got, expected );

  test.case = 'include one of begins, begin.length === src.length';
  var got = _.strRemoveBegin( 'abc', [ 'cba', 'dba', 'abc' ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'include none of begins';
  var got = _.strRemoveBegin( 'abc', [ 'd', 'b', 'c' ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strRemoveBegin( 'abc', [ 'c', 'bc' ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, begin - array of strings' );

  /* - */

  test.open( 'src - array of strings, begin - string' );

  test.case = 'empty strings : empty string';
  var got = _.strRemoveBegin( [ '', '', '' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : string';
  var got = _.strRemoveBegin( [ '', '', '' ], 'x' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty string';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], 'bc' );
  var expected = [ 'abc', 'a', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, begin.length < src.length';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], 'ab' );
  var expected = [ 'c', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'src includes begin, begin.length === src.length';
  var got = _.strRemoveBegin( [ 'abc', 'cab', 'bca', 'cab' ], 'cab' );
  var expected = [ 'abc', '', 'bca', '' ];
  test.identical( got, expected );

  test.case = 'src include none of begin';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], 'd' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strRemoveBegin( [ 'abc', 'bac', 'cab' ], 'bc' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, begin - string' );

  /* - */

  test.open( 'src - array of strings, begin - array of strings' );

  test.case = 'empty strings : empty strings';
  var got = _.strRemoveBegin( [ '', '', '' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings';
  var got = _.strRemoveBegin( [ '', '', '' ], [ 'x', 'a', 'b' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], [ '', '', '' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ] );
  var expected = [ 'c', 'a', 'b' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, begin.length < src.length';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', 'a', 'ca' ] );
  var expected = [ 'bc', 'a', 'b' ];
  test.identical( got, expected );

  test.case = 'src includes begin, begin.length === src.length';
  var got = _.strRemoveBegin( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', 'bca' ] );
  var expected = [ '', '', '', '' ];
  test.identical( got, expected );

  test.case = 'src include none of begins';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', 'h' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strRemoveBegin( [ 'abc', 'bda', 'cab' ], [ 'bc', 'da' ] );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, begin - array of strings' );

  /* - */

  test.open( 'src - string, begin - RegExp' );

  test.case = 'empty string : RegExp';
  var got = _.strRemoveBegin( '', /\w/ );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp';
  var got = _.strRemoveBegin( '', /\w/ );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : RegExp';
  var got = _.strRemoveBegin( 'abc', /\w/ );
  var expected = 'bc';
  test.identical( got, expected );

  test.case = 'include begin';
  var got = _.strRemoveBegin( 'abc', /\w{2}/ );
  var expected = 'c';
  test.identical( got, expected );

  test.case = 'include begin, begin.length < src.length';
  var got = _.strRemoveBegin( 'abc', /\w/ );
  var expected = 'bc';
  test.identical( got, expected );

  test.case = 'include begin, begin.length === src.length';
  var got = _.strRemoveBegin( 'abc', /\w*/ );
  var expected = '';
  test.identical( got, expected );

  test.case = 'not include begin';
  var got = _.strRemoveBegin( 'abc', /\w\s/ );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strRemoveBegin( 'abc', /\sw/ );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, begin - RegExp' );

  /* - */

  test.open( 'src - string, begin - array of strings and RegExp' );

  test.case = 'empty string : empty strings and RegExp';
  var got = _.strRemoveBegin( '', [ '', /\w/, '' ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp';
  var got = _.strRemoveBegin( '', [ /\w\s/, /\w+/, /\w*/ ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty strings and RegExp';
  var got = _.strRemoveBegin( 'abc', [ '', '', /\w$/ ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'include one of begins';
  var got = _.strRemoveBegin( 'abc', [ 'd', 'bc', /a/ ] );
  var expected = 'bc';
  test.identical( got, expected );

  test.case = 'include one of begins, begin.length < src.length';
  var got = _.strRemoveBegin( 'abc', [ 'bc', /ab/, 'da' ] );
  var expected = 'c';
  test.identical( got, expected );

  test.case = 'include one of begins, begin.length === src.length';
  var got = _.strRemoveBegin( 'abc', [ 'cba', 'dba', /\w+/ ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'include none of begins';
  var got = _.strRemoveBegin( 'abc', [ 'd', 'b', /c/ ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strRemoveBegin( 'abc', [ 'c', /\s+/ ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, begin - array of strings and RegExp' );

  /* - */

  test.open( 'src - array of strings, begin - RegExp' );

  test.case = 'empty strings : RegExp';
  var got = _.strRemoveBegin( [ '', '', '' ], /\s/ );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp';
  var got = _.strRemoveBegin( [ '', '', '' ], /\w/ );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : RegExp';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], /\s*/ );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], /bc/ );
  var expected = [ 'abc', 'a', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, begin.length < src.length';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], /a\w/ );
  var expected = [ 'c', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'src includes begin, begin.length === src.length';
  var got = _.strRemoveBegin( [ 'abc', 'cab', 'bca', 'cab' ], /ca\w/ );
  var expected = [ 'abc', '', 'bca', '' ];
  test.identical( got, expected );

  test.case = 'src include none of begin';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], /\wd/ );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strRemoveBegin( [ 'abc', 'bac', 'cab' ], /[efk]/ );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, begin - RegExp' );

  /* - */

  test.open( 'src - array of strings, begin - array of strings and RegExp' );

  test.case = 'empty strings : empty strings and RegExp';
  var got = _.strRemoveBegin( [ '', '', '' ], [ '', '', /\w\s/ ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp';
  var got = _.strRemoveBegin( [ '', '', '' ], [ 'x', /\d\D/, 'b' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], [ '', /\D/, '' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', /[abc]/, 'ca' ] );
  var expected = [ 'bc', 'a', 'ab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, begin.length < src.length';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', /\w/, 'ca' ] );
  var expected = [ 'bc', 'a', 'ab' ];
  test.identical( got, expected );

  test.case = 'src includes begin, begin.length === src.length';
  var got = _.strRemoveBegin( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', /\w+$/ ] );
  var expected = [ '', '', '', '' ];
  test.identical( got, expected );

  test.case = 'src include none of begins';
  var got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', /\w\s/ ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strRemoveBegin( [ 'abc', 'bda', 'cab' ], [ 'bc', /\w\s/ ] );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, begin - array of strings and RegExp' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strRemoveBegin() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strRemoveBegin( 'abcd','a','a' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strRemoveBegin( 1, '' ) );
  test.shouldThrowErrorSync( () => _.strRemoveBegin( /\w*/,'2' ) );
  test.shouldThrowErrorSync( () => _.strRemoveBegin( [ 'str', 1 ], '2' ) );
  test.shouldThrowErrorSync( () => _.strRemoveBegin( [ 'str', /ex/ ], '2' ) );

  test.case = 'wrong type of begin';
  test.shouldThrowErrorSync( () => _.strRemoveBegin( 'a', 1 ) );
  test.shouldThrowErrorSync( () => _.strRemoveBegin( 'a', null ) );
  test.shouldThrowErrorSync( () => _.strRemoveBegin( 'aa', [ ' a', 2 ] ) );

  test.case = 'invalid type of arguments';
  test.shouldThrowErrorSync( () => _.strRemoveBegin( undefined, undefined ) );
  test.shouldThrowErrorSync( () => _.strRemoveBegin( null, null ) );
}

//

function strRemoveEnd( test )
{
  test.open( 'src - string, end - string' );

  test.case = 'empty string : empty string';
  var got = _.strRemoveEnd( '', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : x';
  var got = _.strRemoveEnd( '', 'x' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty string';
  var got = _.strRemoveEnd( 'abc', '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'include end';
  var got = _.strRemoveEnd( 'abc', 'c' );
  var expected = 'ab';
  test.identical( got, expected );

  test.case = 'include end, end.length < src.length';
  var got = _.strRemoveEnd( 'abc', 'bc' );
  var expected = 'a';
  test.identical( got, expected );

  test.case = 'include end, end.length === src.length';
  var got = _.strRemoveEnd( 'abc', 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'not include end';
  var got = _.strRemoveEnd( 'abc', 'd' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strRemoveEnd( 'abc', 'ab' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, end - string' );

  /* - */

  test.open( 'src - string, end - array of strings' );

  test.case = 'empty string : empty strings';
  var got = _.strRemoveEnd( '', [ '', '', '' ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : strings';
  var got = _.strRemoveEnd( '', [ 'x', 'a', 'abc' ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty strings';
  var got = _.strRemoveEnd( 'abc', [ '', '', '' ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'include one of ends';
  var got = _.strRemoveEnd( 'abc', [ 'd', 'ab', 'c' ] );
  var expected = 'ab';
  test.identical( got, expected );

  test.case = 'include one of ends, end.length < src.length';
  var got = _.strRemoveEnd( 'abc', [ 'bc', 'ab', 'da' ] );
  var expected = 'a';
  test.identical( got, expected );

  test.case = 'include one of ends, end.length === src.length';
  var got = _.strRemoveEnd( 'abc', [ 'cba', 'dba', 'abc' ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'include none of ends';
  var got = _.strRemoveEnd( 'abc', [ 'd', 'b', 'a' ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strRemoveEnd( 'abc', [ 'a', 'ab' ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, end - array of strings' );

  /* - */

  test.open( 'src - array of strings, end - string' );

  test.case = 'empty strings : empty string';
  var got = _.strRemoveEnd( [ '', '', '' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : string';
  var got = _.strRemoveEnd( [ '', '', '' ], 'x' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty string';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes end';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], 'bc' );
  var expected = [ 'a', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, end.length < src.length';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], 'ab' );
  var expected = [ 'abc', 'bca', 'c' ];
  test.identical( got, expected );

  test.case = 'src includes end, end.length === src.length';
  var got = _.strRemoveEnd( [ 'abc', 'cab', 'bca', 'cab' ], 'cab' );
  var expected = [ 'abc', '', 'bca', '' ];
  test.identical( got, expected );

  test.case = 'src include none of end';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], 'd' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strRemoveEnd( [ 'abc', 'bac', 'cab' ], 'ba' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, end - string' );

  /* - */

  test.open( 'src - array of strings, end - array of strings' );

  test.case = 'empty strings : empty strings';
  var got = _.strRemoveEnd( [ '', '', '' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings';
  var got = _.strRemoveEnd( [ '', '', '' ], [ 'x', 'a', 'b' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], [ '', '', '' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes end';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ] );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, end.length < src.length';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', 'a', 'ca' ] );
  var expected = [ 'a', 'bc', 'cab' ];
  test.identical( got, expected );

  test.case = 'src includes end, end.length === src.length';
  var got = _.strRemoveEnd( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', 'bca' ] );
  var expected = [ '', '', '', '' ];
  test.identical( got, expected );

  test.case = 'src include none of ends';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', 'h' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strRemoveEnd( [ 'abc', 'bda', 'cab' ], [ 'cb', 'dc' ] );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, end - array of strings' );

  /* - */

  test.open( 'src - string, end - RegExp' );

  test.case = 'empty string : RegExp';
  var got = _.strRemoveEnd( '', /\w/ );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp';
  var got = _.strRemoveEnd( '', /\w/ );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : RegExp';
  var got = _.strRemoveEnd( 'abc', /\w/ );
  var expected = 'ab';
  test.identical( got, expected );

  test.case = 'include end';
  var got = _.strRemoveEnd( 'abc', /\w{2}/ );
  var expected = 'a';
  test.identical( got, expected );

  test.case = 'include end, end.length < src.length';
  var got = _.strRemoveEnd( 'abc', /\w/ );
  var expected = 'ab';
  test.identical( got, expected );

  test.case = 'include end, end.length === src.length';
  var got = _.strRemoveEnd( 'abc', /\w*/ );
  var expected = '';
  test.identical( got, expected );

  test.case = 'not include end';
  var got = _.strRemoveEnd( 'abc', /\w\s/ );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strRemoveEnd( 'abc', /\sw/ );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, end - RegExp' );

  /* - */

  test.open( 'src - string, end - array of strings and RegExp' );

  test.case = 'empty string : empty strings and RegExp';
  var got = _.strRemoveEnd( '', [ '', /\w/, '' ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp';
  var got = _.strRemoveEnd( '', [ /\w\s/, /\w+/, /\w*/ ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty strings and RegExp';
  var got = _.strRemoveEnd( 'abc', [ '', '', /\w$/ ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'include one of ends';
  var got = _.strRemoveEnd( 'abc', [ 'd', 'ba', /c/ ] );
  var expected = 'ab';
  test.identical( got, expected );

  test.case = 'include one of ends, end.length < src.length';
  var got = _.strRemoveEnd( 'abc', [ 'ba', /bc/, 'da' ] );
  var expected = 'a';
  test.identical( got, expected );

  test.case = 'include one of ends, end.length === src.length';
  var got = _.strRemoveEnd( 'abc', [ 'cba', 'dba', /\w+/ ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'include none of ends';
  var got = _.strRemoveEnd( 'abc', [ 'd', 'b', /a/ ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strRemoveEnd( 'abc', [ 'a', /\s+/ ] );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, end - array of strings and RegExp' );

  /* - */

  test.open( 'src - array of strings, end - RegExp' );

  test.case = 'empty strings : RegExp';
  var got = _.strRemoveEnd( [ '', '', '' ], /\s/ );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp';
  var got = _.strRemoveEnd( [ '', '', '' ], /\w/ );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : RegExp';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], /\s*/ );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes end';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], /bc/ );
  var expected = [ 'a', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, end.length < src.length';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], /a\w/ );
  var expected = [ 'abc', 'bca', 'c' ];
  test.identical( got, expected );

  test.case = 'src includes end, end.length === src.length';
  var got = _.strRemoveEnd( [ 'abc', 'cab', 'bca', 'cab' ], /ca\w/ );
  var expected = [ 'abc', '', 'bca', '' ];
  test.identical( got, expected );

  test.case = 'src include none of end';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], /\wd/ );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strRemoveEnd( [ 'abc', 'bac', 'cab' ], /[efk]/ );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, end - RegExp' );

  /* - */

  test.open( 'src - array of strings, end - array of strings and RegExp' );

  test.case = 'empty strings : empty strings and RegExp';
  var got = _.strRemoveEnd( [ '', '', '' ], [ '', '', /\w\s/ ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp';
  var got = _.strRemoveEnd( [ '', '', '' ], [ 'x', /\d\D/, 'b' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], [ '', /\D/, '' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes end';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', /[abc]/, 'ca' ] );
  var expected = [ 'a', 'bc', 'ca' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, end.length < src.length';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', /\w/, 'ca' ] );
  var expected = [ 'a', 'bc', 'ca' ];
  test.identical( got, expected );

  test.case = 'src includes end, end.length === src.length';
  var got = _.strRemoveEnd( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', /\w+$/ ] );
  var expected = [ '', '', '', '' ];
  test.identical( got, expected );

  test.case = 'src include none of ends';
  var got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', /\w\s/ ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strRemoveEnd( [ 'abc', 'bda', 'cab' ], [ 'ba', /\w\s/ ] );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, end - array of strings and RegExp' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strRemoveEnd() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strRemoveEnd( 'abcd','a','a' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strRemoveEnd( 1, '' ) );
  test.shouldThrowErrorSync( () => _.strRemoveEnd( /\w*/,'2' ) );
  test.shouldThrowErrorSync( () => _.strRemoveEnd( [ 'str', 1 ], '2' ) );
  test.shouldThrowErrorSync( () => _.strRemoveEnd( [ 'str', /ex/ ], '2' ) );

  test.case = 'wrong type of end';
  test.shouldThrowErrorSync( () => _.strRemoveEnd( 'a', 1 ) );
  test.shouldThrowErrorSync( () => _.strRemoveEnd( 'a', null ) );
  test.shouldThrowErrorSync( () => _.strRemoveEnd( 'aa', [ ' a', 2 ] ) );

  test.case = 'invalid type of arguments';
  test.shouldThrowErrorSync( () => _.strRemoveEnd( undefined, undefined ) );
  test.shouldThrowErrorSync( () => _.strRemoveEnd( null, null ) );
}

//

function strReplaceBegin( test )
{
  test.open( 'src - string, begin - string' );

  test.case = 'empty string : empty string : empty string';
  var got = _.strReplaceBegin( '', '', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : empty string : string';
  var got = _.strReplaceBegin( '', '', 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'empty string : string : empty string';
  var got = _.strReplaceBegin( '', 'x', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : string : string';
  var got = _.strReplaceBegin( '', 'x', 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty string : empty string';
  var got = _.strReplaceBegin( 'abc', '', '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty string : string';
  var got = _.strReplaceBegin( 'abc', '', 'abc' );
  var expected = 'abcabc';
  test.identical( got, expected );

  test.case = 'include begin, ins - empty string';
  var got = _.strReplaceBegin( 'abc', 'a', '' );
  var expected = 'bc';
  test.identical( got, expected );

  test.case = 'include begin, ins - string';
  var got = _.strReplaceBegin( 'abc', 'a', 'd' );
  var expected = 'dbc';
  test.identical( got, expected );

  test.case = 'include begin, begin.length === src.length';
  var got = _.strReplaceBegin( 'abc', 'abc', 'cba' );
  var expected = 'cba';
  test.identical( got, expected );

  test.case = 'not include begin';
  var got = _.strReplaceBegin( 'abc', 'd', 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strReplaceBegin( 'abc', 'bc', 'ab' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, begin - string' );

  /* - */

  test.open( 'src - string, begin - array of strings' );

  test.case = 'empty string : empty strings : empty string';
  var got = _.strReplaceBegin( '', [ '', '', '' ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : empty strings : string';
  var got = _.strReplaceBegin( '', [ '', '', '' ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'empty string : strings : empty string';
  var got = _.strReplaceBegin( '', [ 'x', 'a', 'abc' ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : strings : string';
  var got = _.strReplaceBegin( '', [ 'x', 'a', 'abc' ], 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty strings : empty string';
  var got = _.strReplaceBegin( 'abc', [ '', '', '' ], '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty strings : string';
  var got = _.strReplaceBegin( 'abc', [ '', '', '' ], 'abc' );
  var expected = 'abcabc';
  test.identical( got, expected );

  test.case = 'include one of begins, ins - empty string';
  var got = _.strReplaceBegin( 'abc', [ 'd', 'bc', 'a' ], '' );
  var expected = 'bc';
  test.identical( got, expected );

  test.case = 'include one of begins, begin.length < src.length';
  var got = _.strReplaceBegin( 'abc', [ 'bc', 'ab', 'da' ], 'cb' );
  var expected = 'cbc';
  test.identical( got, expected );

  test.case = 'include one of begins, begin.length === src.length';
  var got = _.strReplaceBegin( 'abc', [ 'cba', 'dba', 'abc' ], 'cba' );
  var expected = 'cba';
  test.identical( got, expected );

  test.case = 'include none of begins';
  var got = _.strReplaceBegin( 'abc', [ 'd', 'b', 'c' ], 'cb' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strReplaceBegin( 'abc', [ 'c', 'bc' ], 'ba' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, begin - array of strings' );

  /* - */

  test.open( 'src - array of strings, begin - string' );

  test.case = 'empty strings : empty string : empty string';
  var got = _.strReplaceBegin( [ '', '', '' ], '', '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty string : string';
  var got = _.strReplaceBegin( [ '', '', '' ], '', 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : string : empty string';
  var got = _.strReplaceBegin( [ '', '', '' ], 'abc', '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : string : string';
  var got = _.strReplaceBegin( [ '', '', '' ], 'abc', 'abc' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty string : empty string';
  var got = _.strReplaceBegin( [ 'abc', 'bac', 'cab' ], '', '' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty string : string';
  var got = _.strReplaceBegin( [ 'abc', 'bac', 'cab' ], '', 'abc' );
  var expected = [ 'abcabc', 'abcbac', 'abccab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, ins - empty string';
  var got = _.strReplaceBegin( [ 'abc', 'bac', 'cab' ], 'a', '' );
  var expected = [ 'bc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, begin.length < src.length';
  var got = _.strReplaceBegin( [ 'abc', 'bac', 'cab' ], 'ab', 'cb' );
  var expected = [ 'cbc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'include one of begins, begin.length === src.length';
  var got = _.strReplaceBegin( [ 'abc', 'bac', 'cab' ], 'abc', 'cba' );
  var expected = [ 'cba', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'include none of begins';
  var got = _.strReplaceBegin( [ 'abc', 'bac', 'cab' ], 'd', 'cb' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strReplaceBegin( [ 'abc', 'bac', 'cab' ], 'bc', 'ba' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, begin - string' );

  /* - */

  test.open( 'src - array of strings, begin - array of strings' );

  test.case = 'empty strings : empty strings : empty string';
  var got = _.strReplaceBegin( [ '', '', '' ], [ '', '', '' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings : string';
  var got = _.strReplaceBegin( [ '', '', '' ], [ '', '', '' ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : empty string';
  var got = _.strReplaceBegin( [ '', '', '' ], [ 'x', 'a', 'b' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : string';
  var got = _.strReplaceBegin( [ '', '', '' ], [ 'x', 'a', 'b' ], 'abc' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : empty string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], 'abc' );
  var expected = [ 'abcabc', 'abcbca', 'abccab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, ins - empty string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], '' );
  var expected = [ 'c', 'a', 'b' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, ins - string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], 'abc' );
  var expected = [ 'abcc', 'abca', 'abcb' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, begin.length < src.length, ins - string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', 'a', 'ca' ], 'abc ' );
  var expected = [ 'abc bc', 'abc a', 'abc b' ];
  test.identical( got, expected );

  test.case = 'src includes begin, begin.length === src.length, ins - string';
  var got = _.strReplaceBegin( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', 'bca' ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of begins';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', 'h' ], 'abc' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strReplaceBegin( [ 'abc', 'bda', 'cab' ], [ 'bc', 'da' ], 'abc' );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, begin - array of strings' );

  /* - */

  test.open( 'src - array of strings, begin - array of strings, ins - array of strings' );

  test.case = 'empty strings : empty strings : empty strings';
  var got = _.strReplaceBegin( [ '', '', '' ], [ '', '', '' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings : strings';
  var got = _.strReplaceBegin( [ '', '', '' ], [ '', '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : empty strings';
  var got = _.strReplaceBegin( [ '', '', '' ], [ 'x', 'a', 'b' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : strings';
  var got = _.strReplaceBegin( [ '', '', '' ], [ 'x', 'a', 'b' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : empty strings';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], [ '', '', '' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abcabc', 'abcbca', 'abccab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, ins - empty strings';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], [ '', '', '' ] );
  var expected = [ 'c', 'a', 'b' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, ins - string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bacc', 'abca', 'cabb' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, begin.length < src.length, ins - string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', 'a', 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bacbc', 'abca', 'cabb' ];
  test.identical( got, expected );

  test.case = 'src includes begin, begin.length === src.length, ins - string';
  var got = _.strReplaceBegin( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', 'bca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bac', 'abc', 'cab', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of begins';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', 'h' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strReplaceBegin( [ 'abc', 'bda', 'cab' ], [ 'bc', 'da' ], [ 'abc', 'bac' ] );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, begin - array of strings, ins - array of strings' );

  /* - */

  test.open( 'src - string, begin - RegExp' );

  test.case = 'empty string : RegExp : empty string';
  var got = _.strReplaceBegin( '', /\w/, '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : string';
  var got = _.strReplaceBegin( '', /\w/, 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : empty string';
  var got = _.strReplaceBegin( '', /\w/, '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : string';
  var got = _.strReplaceBegin( '', /\w/, 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : RegExp : empty string';
  var got = _.strReplaceBegin( 'abc', /\w/, '' );
  var expected = 'bc';
  test.identical( got, expected );

  test.case = 'string : RegExp : string';
  var got = _.strReplaceBegin( 'abc', /\w/, 'abc' );
  var expected = 'abcbc';
  test.identical( got, expected );

  test.case = 'include begin, ins - empty string';
  var got = _.strReplaceBegin( 'abc', /\w{2}/, '' );
  var expected = 'c';
  test.identical( got, expected );

  test.case = 'include begin, ins - string';
  var got = _.strReplaceBegin( 'abc', /\w{2}/, 'abc' );
  var expected = 'abcc';
  test.identical( got, expected );

  test.case = 'include begin, begin.length < src.length';
  var got = _.strReplaceBegin( 'abc', /\w/, 'abc' );
  var expected = 'abcbc';
  test.identical( got, expected );

  test.case = 'include begin, begin.length === src.length';
  var got = _.strReplaceBegin( 'abc', /\w*/, 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'not include begin';
  var got = _.strReplaceBegin( 'abc', /\w\s/, 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strReplaceBegin( 'abc', /\sw/, 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, begin - RegExp' );

  /* - */

  test.open( 'src - string, begin - array of strings and RegExp' );

  test.case = 'empty string : empty strings and RegExp : empty string';
  var got = _.strReplaceBegin( '', [ '', /\w/, '' ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : empty strings and RegExp : string';
  var got = _.strReplaceBegin( '', [ '', /\w/, '' ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : empty string';
  var got = _.strReplaceBegin( '', [ /\w\s/, /\w+/, /\w*/ ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : string';
  var got = _.strReplaceBegin( '', [ /\w\s/, /\w+/, /\w*/ ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty strings and RegExp : empty string';
  var got = _.strReplaceBegin( 'abc', [ '', '', /\w$/ ], '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty strings and RegExp : string';
  var got = _.strReplaceBegin( 'abc', [ '', '', /\w$/ ], 'abc' );
  var expected = 'abcabc';
  test.identical( got, expected );

  test.case = 'include one of begins';
  var got = _.strReplaceBegin( 'abc', [ 'd', 'bc', /a/ ], 'abc' );
  var expected = 'abcbc';
  test.identical( got, expected );

  test.case = 'include one of begins, begin.length < src.length';
  var got = _.strReplaceBegin( 'abc', [ 'bc', /ab/, 'da' ], 'abc' );
  var expected = 'abcc';
  test.identical( got, expected );

  test.case = 'include one of begins, begin.length === src.length';
  var got = _.strReplaceBegin( 'abc', [ 'cba', 'dba', /\w+/ ], 'bca' );
  var expected = 'bca';
  test.identical( got, expected );

  test.case = 'include none of begins';
  var got = _.strReplaceBegin( 'abc', [ 'd', 'b', /c/ ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strReplaceBegin( 'abc', [ 'c', /\s+/ ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, begin - array of strings and RegExp' );

  /* - */

  test.open( 'src - array of strings, begin - RegExp' );

  test.case = 'empty strings : RegExp : empty string';
  var got = _.strReplaceBegin( [ '', '', '' ], /\s/, '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp : string';
  var got = _.strReplaceBegin( [ '', '', '' ], /\s/, 'abc' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp : empty string';
  var got = _.strReplaceBegin( [ '', '', '' ], /\w/, '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp : string';
  var got = _.strReplaceBegin( [ '', '', '' ], /\s*/, 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'strings : RegExp : empty string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], /\s*/, '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : RegExp : string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], /\s*/, 'abc' );
  var expected = [ 'abcabc', 'abcbca', 'abccab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], /bc/, 'abc' );
  var expected = [ 'abc', 'abca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, begin.length < src.length';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], /a\w/, 'bca' );
  var expected = [ 'bcac', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'src includes begin, begin.length === src.length';
  var got = _.strReplaceBegin( [ 'abc', 'cab', 'bca', 'cab' ], /ca\w/, 'abc' );
  var expected = [ 'abc', 'abc', 'bca', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of begin';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], /\wd/, 'abc' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strReplaceBegin( [ 'abc', 'bac', 'cab' ], /[efk]/, 'abc' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, begin - RegExp' );

  /* - */

  test.open( 'src - array of strings, begin - array of strings and RegExp' );

  test.case = 'empty strings : empty strings and RegExp : empty string';
  var got = _.strReplaceBegin( [ '', '', '' ], [ '', '', /\w\s/ ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings and RegExp : string';
  var got = _.strReplaceBegin( [ '', '', '' ], [ '', '', /\w\s/ ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : empty string';
  var got = _.strReplaceBegin( [ '', '', '' ], [ 'x', /\d\D/, 'b' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : string';
  var got = _.strReplaceBegin( [ '', '', '' ], [ 'x', /\d\D/, 'b' ], 'abc' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : empty string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ '', /\D/, '' ], '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ '', /\D/, '' ], 'abc' );
  var expected = [ 'abcabc', 'abcbca', 'abccab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', /[abc]/, 'ca' ], 'abc' );
  var expected = [ 'abcbc', 'abca', 'abcab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, begin.length < src.length';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', /\w/, 'ca' ], 'abc' );
  var expected = [ 'abcbc', 'abca', 'abcab' ];
  test.identical( got, expected );

  test.case = 'src includes begin, begin.length === src.length';
  var got = _.strReplaceBegin( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', /\w+$/ ], 'bca' );
  var expected = [ 'bca', 'bca', 'bca', 'bca' ];
  test.identical( got, expected );

  test.case = 'src include none of begins';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', /\w\s/ ], 'abc' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strReplaceBegin( [ 'abc', 'bda', 'cab' ], [ 'bc', /\w\s/ ], 'abc' );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, begin - array of strings and RegExp' );

  /* - */

  test.open( 'src - array of strings, begin - array of strings and RegExp, ins - array of strings' );

  test.case = 'empty strings : empty strings and RegExp : empty strings';
  var got = _.strReplaceBegin( [ '', '', '' ], [ /\s*/, '', '' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings and RegExp : strings';
  var got = _.strReplaceBegin( [ '', '', '' ], [ /\w*/, '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : empty strings';
  var got = _.strReplaceBegin( [ '', '', '' ], [ 'x', /\w*/, 'b' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : strings';
  var got = _.strReplaceBegin( [ '', '', '' ], [ 'x', /\s*/, 'b' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bac', 'bac', 'bac' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : empty strings';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ '', /\w+/, '' ], [ '', '', '' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ /\w/, '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abcbc', 'abcca', 'abcab' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, ins - empty strings';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ /[bc]a/, 'ab', 'ca' ], [ '', '', '' ] );
  var expected = [ 'c', 'bca', 'b' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, ins - string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', /\w*/, 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bac', 'abca', 'bac' ];
  test.identical( got, expected );

  test.case = 'one of src includes begin, begin.length < src.length, ins - string';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'bc', /[afk]/, 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bacbc', 'abca', 'cabb' ];
  test.identical( got, expected );

  test.case = 'src includes begin, begin.length === src.length, ins - string';
  var got = _.strReplaceBegin( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', /\w+/ ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bac', 'abc', 'cab', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of begins';
  var got = _.strReplaceBegin( [ 'abc', 'bca', 'cab' ], [ 'd', /\s+/, 'h' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'begin equal to end, not include';
  var got = _.strReplaceBegin( [ 'abc', 'bda', 'cab' ], [ 'bc', /[dhg]/ ], [ 'abc', 'bac' ] );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, begin - array of strings and RegExp, ins - array of strings' );


  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strReplaceBegin() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strReplaceBegin( 'abcd','a','a', 'extra' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strReplaceBegin( 1, '' ) );
  test.shouldThrowErrorSync( () => _.strReplaceBegin( /\w*/,'2' ) );
  test.shouldThrowErrorSync( () => _.strReplaceBegin( [ 'str', 1 ], '2' ) );
  test.shouldThrowErrorSync( () => _.strReplaceBegin( [ 'str', /ex/ ], '2' ) );

  test.case = 'wrong type of begin';
  test.shouldThrowErrorSync( () => _.strReplaceBegin( 'a', 1 ) );
  test.shouldThrowErrorSync( () => _.strReplaceBegin( 'a', null ) );
  test.shouldThrowErrorSync( () => _.strReplaceBegin( 'aa', [ ' a', 2 ] ) );

  test.case = 'invalid type of arguments';
  test.shouldThrowErrorSync( () => _.strReplaceBegin( undefined, undefined ) );
  test.shouldThrowErrorSync( () => _.strReplaceBegin( null, null ) );
}

//

function strReplaceEnd( test )
{
  test.open( 'src - string, end - string' );

  test.case = 'empty string : empty string : empty string';
  var got = _.strReplaceEnd( '', '', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : empty string : string';
  var got = _.strReplaceEnd( '', '', 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'empty string : string : empty string';
  var got = _.strReplaceEnd( '', 'x', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : string : string';
  var got = _.strReplaceEnd( '', 'x', 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty string : empty string';
  var got = _.strReplaceEnd( 'abc', '', '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty string : string';
  var got = _.strReplaceEnd( 'abc', '', 'abc' );
  var expected = 'abcabc';
  test.identical( got, expected );

  test.case = 'include end, ins - empty string';
  var got = _.strReplaceEnd( 'abc', 'c', '' );
  var expected = 'ab';
  test.identical( got, expected );

  test.case = 'include end, ins - string';
  var got = _.strReplaceEnd( 'abc', 'c', 'd' );
  var expected = 'abd';
  test.identical( got, expected );

  test.case = 'include end, end.length === src.length';
  var got = _.strReplaceEnd( 'abc', 'abc', 'cba' );
  var expected = 'cba';
  test.identical( got, expected );

  test.case = 'not include end';
  var got = _.strReplaceEnd( 'abc', 'd', 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strReplaceEnd( 'abc', 'ac', 'ab' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, end - string' );

  /* - */

  test.open( 'src - string, end - array of strings' );

  test.case = 'empty string : empty strings : empty string';
  var got = _.strReplaceEnd( '', [ '', '', '' ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : empty strings : string';
  var got = _.strReplaceEnd( '', [ '', '', '' ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'empty string : strings : empty string';
  var got = _.strReplaceEnd( '', [ 'x', 'a', 'abc' ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : strings : string';
  var got = _.strReplaceEnd( '', [ 'x', 'a', 'abc' ], 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty strings : empty string';
  var got = _.strReplaceEnd( 'abc', [ '', '', '' ], '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty strings : string';
  var got = _.strReplaceEnd( 'abc', [ '', '', '' ], 'abc' );
  var expected = 'abcabc';
  test.identical( got, expected );

  test.case = 'include one of ends, ins - empty string';
  var got = _.strReplaceEnd( 'abc', [ 'd', 'bc', 'c' ], '' );
  var expected = 'a';
  test.identical( got, expected );

  test.case = 'include one of ends, end.length < src.length';
  var got = _.strReplaceEnd( 'abc', [ 'bc', 'ab', 'da' ], 'cb' );
  var expected = 'acb';
  test.identical( got, expected );

  test.case = 'include one of ends, end.length === src.length';
  var got = _.strReplaceEnd( 'abc', [ 'cba', 'dba', 'abc' ], 'cba' );
  var expected = 'cba';
  test.identical( got, expected );

  test.case = 'include none of ends';
  var got = _.strReplaceEnd( 'abc', [ 'd', 'b', 'a' ], 'cb' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strReplaceEnd( 'abc', [ 'd', 'ac' ], 'ba' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, end - array of strings' );

  /* - */

  test.open( 'src - array of strings, end - string' );

  test.case = 'empty strings : empty string : empty string';
  var got = _.strReplaceEnd( [ '', '', '' ], '', '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty string : string';
  var got = _.strReplaceEnd( [ '', '', '' ], '', 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : string : empty string';
  var got = _.strReplaceEnd( [ '', '', '' ], 'abc', '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : string : string';
  var got = _.strReplaceEnd( [ '', '', '' ], 'abc', 'abc' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty string : empty string';
  var got = _.strReplaceEnd( [ 'abc', 'bac', 'cab' ], '', '' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty string : string';
  var got = _.strReplaceEnd( [ 'abc', 'bac', 'cab' ], '', 'abc' );
  var expected = [ 'abcabc', 'bacabc', 'cababc' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, ins - empty string';
  var got = _.strReplaceEnd( [ 'abc', 'bac', 'cab' ], 'c', '' );
  var expected = [ 'ab', 'ba', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, end.length < src.length';
  var got = _.strReplaceEnd( [ 'abc', 'bac', 'cab' ], 'ab', 'cb' );
  var expected = [ 'abc', 'bac', 'ccb' ];
  test.identical( got, expected );

  test.case = 'include one of ends, end.length === src.length';
  var got = _.strReplaceEnd( [ 'abc', 'bac', 'cab' ], 'abc', 'cba' );
  var expected = [ 'cba', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'include none of ends';
  var got = _.strReplaceEnd( [ 'abc', 'bac', 'cab' ], 'd', 'cb' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strReplaceEnd( [ 'abc', 'bac', 'cab' ], 'cb', 'ba' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, end - string' );

  /* - */

  test.open( 'src - array of strings, end - array of strings' );

  test.case = 'empty strings : empty strings : empty string';
  var got = _.strReplaceEnd( [ '', '', '' ], [ '', '', '' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings : string';
  var got = _.strReplaceEnd( [ '', '', '' ], [ '', '', '' ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : empty string';
  var got = _.strReplaceEnd( [ '', '', '' ], [ 'x', 'a', 'b' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : string';
  var got = _.strReplaceEnd( [ '', '', '' ], [ 'x', 'a', 'b' ], 'abc' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : empty string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], 'abc' );
  var expected = [ 'abcabc', 'bcaabc', 'cababc' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, ins - empty string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], '' );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, ins - string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], 'abc' );
  var expected = [ 'aabc', 'babc', 'cabc' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, end.length < src.length, ins - string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', 'a', 'ca' ], 'abc ' );
  var expected = [ 'aabc ', 'bcabc ', 'cab' ];
  test.identical( got, expected );

  test.case = 'src includes end, end.length === src.length, ins - string';
  var got = _.strReplaceEnd( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', 'bca' ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of ends';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', 'h' ], 'abc' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strReplaceEnd( [ 'abc', 'bda', 'cab' ], [ 'ca', 'dc' ], 'abc' );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, end - array of strings' );

  /* - */

  test.open( 'src - array of strings, end - array of strings, ins - array of strings' );

  test.case = 'empty strings : empty strings : empty strings';
  var got = _.strReplaceEnd( [ '', '', '' ], [ '', '', '' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings : strings';
  var got = _.strReplaceEnd( [ '', '', '' ], [ '', '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : empty strings';
  var got = _.strReplaceEnd( [ '', '', '' ], [ 'x', 'a', 'b' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : strings';
  var got = _.strReplaceEnd( [ '', '', '' ], [ 'x', 'a', 'b' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : empty strings';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], [ '', '', '' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abcabc', 'bcaabc', 'cababc' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, ins - empty strings';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], [ '', '', '' ] );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, ins - string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'aabc', 'bcab', 'cbac' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, end.length < src.length, ins - string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', 'a', 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'aabc', 'bcbac', 'cab' ];
  test.identical( got, expected );

  test.case = 'src includes end, end.length === src.length, ins - string';
  var got = _.strReplaceEnd( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', 'bca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bac', 'abc', 'cab', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of ends';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', 'h' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strReplaceEnd( [ 'abc', 'bda', 'cab' ], [ 'ba', 'dc' ], [ 'abc', 'bac' ] );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, end - array of strings, ins - array of strings' );

  /* - */

  test.open( 'src - string, end - RegExp' );

  test.case = 'empty string : RegExp : empty string';
  var got = _.strReplaceEnd( '', /\w/, '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : string';
  var got = _.strReplaceEnd( '', /\w/, 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : empty string';
  var got = _.strReplaceEnd( '', /\w/, '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : string';
  var got = _.strReplaceEnd( '', /\w/, 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : RegExp : empty string';
  var got = _.strReplaceEnd( 'abc', /\w/, '' );
  var expected = 'ab';
  test.identical( got, expected );

  test.case = 'string : RegExp : string';
  var got = _.strReplaceEnd( 'abc', /\w/, 'abc' );
  var expected = 'ababc';
  test.identical( got, expected );

  test.case = 'include end, ins - empty string';
  var got = _.strReplaceEnd( 'abc', /\w{2}/, '' );
  var expected = 'a';
  test.identical( got, expected );

  test.case = 'include end, ins - string';
  var got = _.strReplaceEnd( 'abc', /\w{2}/, 'abc' );
  var expected = 'aabc';
  test.identical( got, expected );

  test.case = 'include end, end.length < src.length';
  var got = _.strReplaceEnd( 'abc', /\w/, 'abc' );
  var expected = 'ababc';
  test.identical( got, expected );

  test.case = 'include end, end.length === src.length';
  var got = _.strReplaceEnd( 'abc', /\w*/, 'cab' );
  var expected = 'cab';
  test.identical( got, expected );

  test.case = 'not include end';
  var got = _.strReplaceEnd( 'abc', /\w\s/, 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strReplaceEnd( 'abc', /\sw/, 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, end - RegExp' );

  /* - */

  test.open( 'src - string, end - array of strings and RegExp' );

  test.case = 'empty string : empty strings and RegExp : empty string';
  var got = _.strReplaceEnd( '', [ '', /\w/, '' ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : empty strings and RegExp : string';
  var got = _.strReplaceEnd( '', [ '', /\w/, '' ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : empty string';
  var got = _.strReplaceEnd( '', [ /\w\s/, /\w+/, /\w*/ ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : string';
  var got = _.strReplaceEnd( '', [ /\w\s/, /\w+/, /\w*/ ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty strings and RegExp : empty string';
  var got = _.strReplaceEnd( 'abc', [ '', '', /\w$/ ], '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty strings and RegExp : string';
  var got = _.strReplaceEnd( 'abc', [ '', '', /\w$/ ], 'abc' );
  var expected = 'abcabc';
  test.identical( got, expected );

  test.case = 'include one of ends';
  var got = _.strReplaceEnd( 'abc', [ 'd', 'bc', /a/ ], 'abc' );
  var expected = 'aabc';
  test.identical( got, expected );

  test.case = 'include one of ends, end.length < src.length';
  var got = _.strReplaceEnd( 'abc', [ /bc/, /ab/, 'da' ], 'abc' );
  var expected = 'aabc';
  test.identical( got, expected );

  test.case = 'include one of ends, end.length === src.length';
  var got = _.strReplaceEnd( 'abc', [ 'cba', 'dba', /\w+/ ], 'bca' );
  var expected = 'bca';
  test.identical( got, expected );

  test.case = 'include none of ends';
  var got = _.strReplaceEnd( 'abc', [ 'd', 'b', /a/ ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strReplaceEnd( 'abc', [ 'a', /\s+/ ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, end - array of strings and RegExp' );

  /* - */

  test.open( 'src - array of strings, end - RegExp' );

  test.case = 'empty strings : RegExp : empty string';
  var got = _.strReplaceEnd( [ '', '', '' ], /\s/, '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp : string';
  var got = _.strReplaceEnd( [ '', '', '' ], /\s/, 'abc' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp : empty string';
  var got = _.strReplaceEnd( [ '', '', '' ], /\w/, '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp : string';
  var got = _.strReplaceEnd( [ '', '', '' ], /\s*/, 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'strings : RegExp : empty string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], /\s*/, '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : RegExp : string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], /\s*/, 'abc' );
  var expected = [ 'abcabc', 'bcaabc', 'cababc' ];
  test.identical( got, expected );

  test.case = 'one of src includes end';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], /bc/, 'abc' );
  var expected = [ 'aabc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, end.length < src.length';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], /a\w/, 'bca' );
  var expected = [ 'abc', 'bca', 'cbca' ];
  test.identical( got, expected );

  test.case = 'src includes end, end.length === src.length';
  var got = _.strReplaceEnd( [ 'abc', 'cab', 'bca', 'cab' ], /ca\w/, 'abc' );
  var expected = [ 'abc', 'abc', 'bca', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of end';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], /\wd/, 'abc' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strReplaceEnd( [ 'abc', 'bac', 'cab' ], /[efk]/, 'abc' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, end - RegExp' );

  /* - */

  test.open( 'src - array of strings, end - array of strings and RegExp' );

  test.case = 'empty strings : empty strings and RegExp : empty string';
  var got = _.strReplaceEnd( [ '', '', '' ], [ '', '', /\w\s/ ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings and RegExp : string';
  var got = _.strReplaceEnd( [ '', '', '' ], [ '', '', /\w\s/ ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : empty string';
  var got = _.strReplaceEnd( [ '', '', '' ], [ 'x', /\d\D/, 'b' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : string';
  var got = _.strReplaceEnd( [ '', '', '' ], [ 'x', /\s*/, 'b' ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : empty string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ '', /\D/, '' ], '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ /\w*/, /\D/, '' ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'one of src includes end';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', /[abc]/, 'ca' ], 'abc' );
  var expected = [ 'aabc', 'bcabc', 'caabc' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, end.length < src.length';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', /\w/, 'ca' ], 'abc' );
  var expected = [ 'aabc', 'bcabc', 'caabc' ];
  test.identical( got, expected );

  test.case = 'src includes end, end.length === src.length';
  var got = _.strReplaceEnd( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', /\w+$/ ], 'bca' );
  var expected = [ 'bca', 'bca', 'bca', 'bca' ];
  test.identical( got, expected );

  test.case = 'src include none of ends';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', /\w\s/ ], 'abc' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strReplaceEnd( [ 'abc', 'bda', 'cab' ], [ 'ba', /\w\s/ ], 'abc' );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, end - array of strings and RegExp' );

  /* - */

  test.open( 'src - array of strings, end - array of strings and RegExp, ins - array of strings' );

  test.case = 'empty strings : empty strings and RegExp : empty strings';
  var got = _.strReplaceEnd( [ '', '', '' ], [ /\s*/, '', '' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings and RegExp : strings';
  var got = _.strReplaceEnd( [ '', '', '' ], [ /\w*/, '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : empty strings';
  var got = _.strReplaceEnd( [ '', '', '' ], [ 'x', /\w*/, 'b' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : strings';
  var got = _.strReplaceEnd( [ '', '', '' ], [ 'x', /\s*/, 'b' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bac', 'bac', 'bac' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : empty strings';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ '', /\w+/, '' ], [ '', '', '' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ /\w/, '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'ababc', 'bcabc', 'caabc' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, ins - empty strings';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ /[bc]a/, 'ab', 'ca' ], [ '', '', '' ] );
  var expected = [ 'abc', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, ins - string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', /\w*/, 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'aabc', 'bac', 'bac' ];
  test.identical( got, expected );

  test.case = 'one of src includes end, end.length < src.length, ins - string';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'bc', /[afk]/, 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'aabc', 'bcbac', 'cab' ];
  test.identical( got, expected );

  test.case = 'src includes end, end.length === src.length, ins - string';
  var got = _.strReplaceEnd( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', /\w+/ ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bac', 'abc', 'cab', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of ends';
  var got = _.strReplaceEnd( [ 'abc', 'bca', 'cab' ], [ 'd', /\s+/, 'h' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'end equal to begin, not include';
  var got = _.strReplaceEnd( [ 'abc', 'bda', 'cab' ], [ 'ba', /[dhg]/ ], [ 'abc', 'bac' ] );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, end - array of strings and RegExp, ins - array of strings' );


  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strReplaceEnd() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strReplaceEnd( 'abcd','a','a', 'extra' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strReplaceEnd( 1, '' ) );
  test.shouldThrowErrorSync( () => _.strReplaceEnd( /\w*/,'2' ) );
  test.shouldThrowErrorSync( () => _.strReplaceEnd( [ 'str', 1 ], '2' ) );
  test.shouldThrowErrorSync( () => _.strReplaceEnd( [ 'str', /ex/ ], '2' ) );

  test.case = 'wrong type of end';
  test.shouldThrowErrorSync( () => _.strReplaceEnd( 'a', 1 ) );
  test.shouldThrowErrorSync( () => _.strReplaceEnd( 'a', null ) );
  test.shouldThrowErrorSync( () => _.strReplaceEnd( 'aa', [ ' a', 2 ] ) );

  test.case = 'invalid type of arguments';
  test.shouldThrowErrorSync( () => _.strReplaceEnd( undefined, undefined ) );
  test.shouldThrowErrorSync( () => _.strReplaceEnd( null, null ) );
}

//

function strReplace( test )
{
  test.open( 'src - string, insStr - string' );

  test.case = 'empty string : empty string : empty string';
  var got = _.strReplace( '', '', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : empty string : string';
  var got = _.strReplace( '', '', 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'empty string : string : empty string';
  var got = _.strReplace( '', 'x', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : string : string';
  var got = _.strReplace( '', 'x', 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty string : empty string';
  var got = _.strReplace( 'abc', '', '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty string : string';
  var got = _.strReplace( 'abc', '', 'abc' );
  var expected = 'abcabc';
  test.identical( got, expected );

  test.case = 'include insStr, ins - empty string';
  var got = _.strReplace( 'abcd', 'c', '' );
  var expected = 'abd';
  test.identical( got, expected );

  test.case = 'include insStr, ins - string';
  var got = _.strReplace( 'abcd', 'c', 'd' );
  var expected = 'abdd';
  test.identical( got, expected );

  test.case = 'include insStr, insStr.length === src.length';
  var got = _.strReplace( 'abc', 'abc', 'cba' );
  var expected = 'cba';
  test.identical( got, expected );

  test.case = 'not include insStr';
  var got = _.strReplace( 'abc', 'd', 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'not include';
  var got = _.strReplace( 'abc', 'ac', 'ab' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, insStr - string' );

  /* - */

  test.open( 'src - string, insStr - array of strings' );

  test.case = 'empty string : empty strings : empty string';
  var got = _.strReplace( '', [ '', '', '' ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : empty strings : string';
  var got = _.strReplace( '', [ '', '', '' ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'empty string : strings : empty string';
  var got = _.strReplace( '', [ 'x', 'a', 'abc' ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : strings : string';
  var got = _.strReplace( '', [ 'x', 'a', 'abc' ], 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : empty strings : empty string';
  var got = _.strReplace( 'abc', [ '', '', '' ], '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty strings : string';
  var got = _.strReplace( 'abc', [ '', '', '' ], 'abc' );
  var expected = 'abcabc';
  test.identical( got, expected );

  test.case = 'include one of insStrs, ins - empty string';
  var got = _.strReplace( 'abc', [ 'd', 'bc', 'c' ], '' );
  var expected = 'a';
  test.identical( got, expected );

  test.case = 'include one of insStrs, insStr.length < src.length';
  var got = _.strReplace( 'abc', [ 'bc', 'ab', 'da' ], 'cb' );
  var expected = 'acb';
  test.identical( got, expected );

  test.case = 'include one of insStrs, insStr.length === src.length';
  var got = _.strReplace( 'abc', [ 'cba', 'dba', 'abc' ], 'cba' );
  var expected = 'cba';
  test.identical( got, expected );

  test.case = 'include none of insStrs';
  var got = _.strReplace( 'abc', [ 'd', 'b', 'a' ], 'cb' );
  var expected = 'acbc';
  test.identical( got, expected );

  test.case = 'not include';
  var got = _.strReplace( 'abc', [ 'd', 'ac' ], 'ba' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, insStr - array of strings' );

  /* - */

  test.open( 'src - array of strings, insStr - string' );

  test.case = 'empty strings : empty string : empty string';
  var got = _.strReplace( [ '', '', '' ], '', '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty string : string';
  var got = _.strReplace( [ '', '', '' ], '', 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : string : empty string';
  var got = _.strReplace( [ '', '', '' ], 'abc', '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : string : string';
  var got = _.strReplace( [ '', '', '' ], 'abc', 'abc' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty string : empty string';
  var got = _.strReplace( [ 'abc', 'bac', 'cab' ], '', '' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty string : string';
  var got = _.strReplace( [ 'abc', 'bac', 'cab' ], '', 'abc' );
  var expected = [ 'abcabc', 'abcbac', 'abccab' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, ins - empty string';
  var got = _.strReplace( [ 'abc', 'bac', 'cab' ], 'c', '' );
  var expected = [ 'ab', 'ba', 'ab' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, insStr.length < src.length';
  var got = _.strReplace( [ 'abc', 'bac', 'cab' ], 'c', 'cb' );
  var expected = [ 'abcb', 'bacb', 'cbab' ];
  test.identical( got, expected );

  test.case = 'include one of insStrs, insStr.length === src.length';
  var got = _.strReplace( [ 'abc', 'bac', 'cab' ], 'abc', 'cba' );
  var expected = [ 'cba', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'include none of insStrs';
  var got = _.strReplace( [ 'abc', 'bac', 'cab' ], 'd', 'cb' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.case = 'not include';
  var got = _.strReplace( [ 'abc', 'bac', 'cab' ], 'cb', 'ba' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, insStr - string' );

  /* - */

  test.open( 'src - array of strings, insStr - array of strings' );

  test.case = 'empty strings : empty strings : empty string';
  var got = _.strReplace( [ '', '', '' ], [ '', '', '' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings : string';
  var got = _.strReplace( [ '', '', '' ], [ '', '', '' ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : empty string';
  var got = _.strReplace( [ '', '', '' ], [ 'x', 'a', 'b' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : string';
  var got = _.strReplace( [ '', '', '' ], [ 'x', 'a', 'b' ], 'abc' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : empty string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], 'abc' );
  var expected = [ 'abcabc', 'abcbca', 'abccab' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, ins - empty string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], '' );
  var expected = [ 'a', 'a', 'c' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, ins - string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], 'abc' );
  var expected = [ 'aabc', 'abca', 'cabc' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, insStr.length < src.length, ins - string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'bc', 'a', 'ca' ], 'abc ' );
  var expected = [ 'aabc ', 'abc a', 'cabc b' ];
  test.identical( got, expected );

  test.case = 'src includes insStr, insStr.length === src.length, ins - string';
  var got = _.strReplace( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', 'bca' ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of insStrs';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', 'h' ], 'abc' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'not include';
  var got = _.strReplace( [ 'abc', 'bda', 'cab' ], [ 'cb', 'dc' ], 'abc' );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, insStr - array of strings' );

  /* - */

  test.open( 'src - array of strings, insStr - array of strings, ins - array of strings' );

  test.case = 'empty strings : empty strings : empty strings';
  var got = _.strReplace( [ '', '', '' ], [ '', '', '' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings : strings';
  var got = _.strReplace( [ '', '', '' ], [ '', '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : empty strings';
  var got = _.strReplace( [ '', '', '' ], [ 'x', 'a', 'b' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings : strings';
  var got = _.strReplace( [ '', '', '' ], [ 'x', 'a', 'b' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : empty strings';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], [ '', '', '' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings : string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ '', '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abcabc', 'abcbca', 'abccab' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, ins - empty strings';
  var got = _.strReplace( [ 'aaabc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], [ '', '', '' ] );
  var expected = [ 'aaa', 'a', 'c' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, ins - string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'bc', 'ab', 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'aabc', 'abca', 'cbac' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, insStr.length < src.length, ins - string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'bc', 'a', 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'aabc', 'abca', 'cbacb' ];
  test.identical( got, expected );

  test.case = 'src includes insStr, insStr.length === src.length, ins - string';
  var got = _.strReplace( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', 'bca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bac', 'abc', 'cab', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of insStrs';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', 'h' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'not include';
  var got = _.strReplace( [ 'abc', 'bda', 'cab' ], [ 'ba', 'dc' ], [ 'abc', 'bac' ] );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, insStr - array of strings, ins - array of strings' );

  /* - */

  test.open( 'src - string, insStr - RegExp' );

  test.case = 'empty string : RegExp : empty string';
  var got = _.strReplace( '', /\w/, '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : string';
  var got = _.strReplace( '', /\w/, 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : empty string';
  var got = _.strReplace( '', /\w/, '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : string';
  var got = _.strReplace( '', /\w/, 'abc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string : RegExp : empty string';
  var got = _.strReplace( 'abc', /\w/, '' );
  var expected = 'bc';
  test.identical( got, expected );

  test.case = 'string : RegExp : string';
  var got = _.strReplace( 'abc', /\w/, 'abc' );
  var expected = 'abcbc';
  test.identical( got, expected );

  test.case = 'include insStr, ins - empty string';
  var got = _.strReplace( 'abc', /\w{2}/, '' );
  var expected = 'c';
  test.identical( got, expected );

  test.case = 'include insStr, ins - string';
  var got = _.strReplace( 'abc', /\w{2}/, 'abc' );
  var expected = 'abcc';
  test.identical( got, expected );

  test.case = 'include insStr, insStr.length < src.length';
  var got = _.strReplace( 'abc', /\w/, 'abc' );
  var expected = 'abcbc';
  test.identical( got, expected );

  test.case = 'include insStr, insStr.length === src.length';
  var got = _.strReplace( 'abc', /\w*/, 'cab' );
  var expected = 'cab';
  test.identical( got, expected );

  test.case = 'not include insStr';
  var got = _.strReplace( 'abc', /\w\s/, 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'not include';
  var got = _.strReplace( 'abc', /\sw/, 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, insStr - RegExp' );

  /* - */

  test.open( 'src - string, insStr - array of strings and RegExp' );

  test.case = 'empty string : empty strings and RegExp : empty string';
  var got = _.strReplace( '', [ '', /\w/, '' ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : empty strings and RegExp : string';
  var got = _.strReplace( '', [ '', /\w/, '' ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : empty string';
  var got = _.strReplace( '', [ /\w\s/, /\w+/, /\w*/ ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string : RegExp : string';
  var got = _.strReplace( '', [ /\w\s/, /\w+/, /\w*/ ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty strings and RegExp : empty string';
  var got = _.strReplace( 'abc', [ '', '', /\w$/ ], '' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'string : empty strings and RegExp : string';
  var got = _.strReplace( 'abc', [ '', '', /\w$/ ], 'abc' );
  var expected = 'abcabc';
  test.identical( got, expected );

  test.case = 'include one of insStrs';
  var got = _.strReplace( 'abc', [ 'd', 'bc', /a/ ], 'abc' );
  var expected = 'aabc';
  test.identical( got, expected );

  test.case = 'include one of insStrs, insStr.length < src.length';
  var got = _.strReplace( 'abc', [ /bc/, /ab/, 'da' ], 'abc' );
  var expected = 'aabc';
  test.identical( got, expected );

  test.case = 'include one of insStrs, insStr.length === src.length';
  var got = _.strReplace( 'abc', [ 'cba', 'dba', /\w+/ ], 'bca' );
  var expected = 'bca';
  test.identical( got, expected );

  test.case = 'include none of insStrs';
  var got = _.strReplace( 'abc', [ 'd', 'f', /\s+/ ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'not include';
  var got = _.strReplace( 'abc', [ 'd', /\s+/ ], 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.close( 'src - string, insStr - array of strings and RegExp' );

  /* - */

  test.open( 'src - array of strings, insStr - RegExp' );

  test.case = 'empty strings : RegExp : empty string';
  var got = _.strReplace( [ '', '', '' ], /\s/, '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp : string';
  var got = _.strReplace( [ '', '', '' ], /\s/, 'abc' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp : empty string';
  var got = _.strReplace( [ '', '', '' ], /\w/, '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : RegExp : string';
  var got = _.strReplace( [ '', '', '' ], /\s*/, 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'strings : RegExp : empty string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], /\s*/, '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : RegExp : string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], /\s*/, 'abc' );
  var expected = [ 'abcabc', 'abcbca', 'abccab' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr';
  var got = _.strReplace( [ 'aabc', 'abca', 'cab' ], /bc/, 'abc' );
  var expected = [ 'aaabc', 'aabca', 'cab' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, insStr.length < src.length';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], /a\w/, 'bca' );
  var expected = [ 'bcac', 'bca', 'cbca' ];
  test.identical( got, expected );

  test.case = 'src includes insStr, insStr.length === src.length';
  var got = _.strReplace( [ 'abc', 'cab', 'bca', 'cab' ], /ca\w/, 'abc' );
  var expected = [ 'abc', 'abc', 'bca', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of insStr';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], /\wd/, 'abc' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'not include';
  var got = _.strReplace( [ 'abc', 'bac', 'cab' ], /[efk]/, 'abc' );
  var expected = [ 'abc', 'bac', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, insStr - RegExp' );

  /* - */

  test.open( 'src - array of strings, insStr - array of strings and RegExp' );

  test.case = 'empty strings : empty strings and RegExp : empty string';
  var got = _.strReplace( [ '', '', '' ], [ '', '', /\w\s/ ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings and RegExp : string';
  var got = _.strReplace( [ '', '', '' ], [ '', '', /\w\s/ ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : empty string';
  var got = _.strReplace( [ '', '', '' ], [ 'x', /\d\D/, 'b' ], '' );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : string';
  var got = _.strReplace( [ '', '', '' ], [ 'x', /\s*/, 'b' ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : empty string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ '', /\D/, '' ], '' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ /\w*/, /\D/, '' ], 'abc' );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'bc', /[abc]/, 'ca' ], 'abc' );
  var expected = [ 'aabc', 'abca', 'abcab' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, insStr.length < src.length';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'bc', /\w/, 'ca' ], 'abc' );
  var expected = [ 'aabc', 'abca', 'abcab' ];
  test.identical( got, expected );

  test.case = 'src includes insStr, insStr.length === src.length';
  var got = _.strReplace( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', /\w+$/ ], 'bca' );
  var expected = [ 'bca', 'bca', 'bca', 'bca' ];
  test.identical( got, expected );

  test.case = 'src include none of insStrs';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'd', 'j', /\w\s/ ], 'abc' );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'not include';
  var got = _.strReplace( [ 'abc', 'bda', 'cab' ], [ 'ba', /\w\s/ ], 'abc' );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, insStr - array of strings and RegExp' );

  /* - */

  test.open( 'src - array of strings, insStr - array of strings and RegExp, ins - array of strings' );

  test.case = 'empty strings : empty strings and RegExp : empty strings';
  var got = _.strReplace( [ '', '', '' ], [ /\s*/, '', '' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : empty strings and RegExp : strings';
  var got = _.strReplace( [ '', '', '' ], [ /\w*/, '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'abc', 'abc' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : empty strings';
  var got = _.strReplace( [ '', '', '' ], [ 'x', /\w*/, 'b' ], [ '', '', '' ] );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'empty strings : strings and RegExp : strings';
  var got = _.strReplace( [ '', '', '' ], [ 'x', /\s*/, 'b' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bac', 'bac', 'bac' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : empty strings';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ '', /\w+/, '' ], [ '', '', '' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'strings : empty strings and RegExp : string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ /\w/, '', '' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abcbc', 'abcca', 'abcab' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, ins - empty strings';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ /[bc]a/, 'ab', 'ca' ], [ '', '', '' ] );
  var expected = [ 'c', 'b', 'b' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, ins - string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'bc', /\w*/, 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'aabc', 'abca', 'bac' ];
  test.identical( got, expected );

  test.case = 'one of src includes insStr, insStr.length < src.length, ins - string';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'bc', /[afk]/, 'ca' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'aabc', 'abca', 'cbacb' ];
  test.identical( got, expected );

  test.case = 'src includes insStr, insStr.length === src.length, ins - string';
  var got = _.strReplace( [ 'abc', 'cab', 'bca', 'cab' ], [ 'cab', 'abc', /\w+/ ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'bac', 'abc', 'cab', 'abc' ];
  test.identical( got, expected );

  test.case = 'src include none of insStrs';
  var got = _.strReplace( [ 'abc', 'bca', 'cab' ], [ 'd', /\s+/, 'h' ], [ 'abc', 'bac', 'cab' ] );
  var expected = [ 'abc', 'bca', 'cab' ];
  test.identical( got, expected );

  test.case = 'not include';
  var got = _.strReplace( [ 'abc', 'bda', 'cab' ], [ 'ba', /[fhg]/ ], [ 'abc', 'bac' ] );
  var expected = [ 'abc', 'bda', 'cab' ];
  test.identical( got, expected );

  test.close( 'src - array of strings, insStr - array of strings and RegExp, ins - array of strings' );


  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strReplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strReplace( 'abcd','a','a', 'extra' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strReplace( 1, '' ) );
  test.shouldThrowErrorSync( () => _.strReplace( /\w*/,'2' ) );
  test.shouldThrowErrorSync( () => _.strReplace( [ 'str', 1 ], '2' ) );
  test.shouldThrowErrorSync( () => _.strReplace( [ 'str', /ex/ ], '2' ) );

  test.case = 'wrong type of insStr';
  test.shouldThrowErrorSync( () => _.strReplace( 'a', 1 ) );
  test.shouldThrowErrorSync( () => _.strReplace( 'a', null ) );
  test.shouldThrowErrorSync( () => _.strReplace( 'aa', [ ' a', 2 ] ) );

  test.case = 'invalid type of arguments';
  test.shouldThrowErrorSync( () => _.strReplace( undefined, undefined ) );
  test.shouldThrowErrorSync( () => _.strReplace( null, null ) );
}

//

function strIsolateLeftOrNone( test )
{
  var got, expected;

  /* - */

  test.case = 'single delimeter';

  /**/

  got = _.strIsolateLeftOrNone( '', '' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( '', [ '' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abc', [ '' ] );
  expected = [ '', '', 'abc' ];
  test.identical( got, expected );

  /* empty delimeters array */

  got = _.strIsolateLeftOrNone( 'abca', [] );
  expected = [ '', undefined, 'abca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( '', 'a' );
  expected = [ '', undefined, '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( '', [ 'a' ] );
  expected = [ '', undefined, '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abca', 'a' );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abca', [ 'a' ] );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strIsolateLeftOrNone( 'abca', 'd' );
  expected = [ '', undefined, 'abca' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strIsolateLeftOrNone( 'abca', [ 'd' ] );
  expected = [ '', undefined, 'abca' ];
  test.identical( got, expected );

  /* - */

  test.case = 'single delimeter, number';

  got = _.strIsolateLeftOrNone( 'abca', '', 2 );
  expected = [ 'a', '', 'bca' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strIsolateLeftOrNone( 'abca', 'a', 2 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strIsolateLeftOrNone( 'abca', [ 'a' ], 2 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strIsolateLeftOrNone( 'abcaca', 'a', 3 );
  expected = [ 'abcac', 'a', '' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strIsolateLeftOrNone( 'abcaca', [ 'a' ], 3 );
  expected = [ 'abcac', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abcaca', 'a', 4 );
  expected = [ 'abcaca', undefined, '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abcaca', [ 'a' ], 4 );
  expected = [ 'abcaca', undefined, '' ];
  test.identical( got, expected );

  /* - */

  test.case = 'several delimeters';

  /**/

  got = _.strIsolateLeftOrNone( 'abca', [ 'a', 'c' ] );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abca', [ 'c', 'a' ] );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abca', [ 'x', 'y' ] );
  expected = [ '', undefined, 'abca'  ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abca', [ 'x', 'y', 'a' ] );
  expected = [ '', 'a', 'bca'  ];
  test.identical( got, expected );

  /* - */

  test.case = 'several delimeters, number';

  /* empty delimeters array */

  got = _.strIsolateLeftOrNone( 'abca', [], 2 );
  expected = [ '', undefined, 'abca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abca', [ 'a', 'c' ], 2 );
  expected = [ 'ab', 'c', 'a' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abcbc', [ 'c', 'a' ], 2 );
  expected = [ 'ab', 'c', 'bc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'cbcbc', [ 'c', 'a' ], 3 );
  expected = [ 'cbcb', 'c', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'cbcbc', [ 'c', 'a' ], 4 );
  expected = [ 'cbcbc', undefined, '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'jj', [ 'c', 'a' ], 4 );
  expected = [ '', undefined, 'jj' ];
  test.identical( got, expected );

  /* - */

  test.case = 'one of delimeters contains other';

  /* - */

  got = _.strIsolateLeftOrNone( 'ab', [ 'a', 'ab' ] );
  expected = [ '', 'a', 'b' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'ab', [ 'ab', 'a' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'ab', [ 'b', 'ab' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'ab', [ 'ab', 'b' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrNone( 'a b c', ' ', 1 );
  expected = [ 'a', ' ', 'b c' ];
  test.identical( got, expected );

  /* - */

  test.case = 'single delimeter'

  /* cut on first appear */

  got = _.strIsolateLeftOrNone( 'abca', 'a', 1 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got , expected );

  /* no occurrences */

  got = _.strIsolateLeftOrNone( 'jj', 'a', 1 );
  expected = [ '', undefined, 'jj'];
  test.identical( got , expected );

  /* cut on second appear */

  got = _.strIsolateLeftOrNone( 'abca', 'a', 2 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got , expected );

  /* 5 attempts */

  got = _.strIsolateLeftOrNone( 'abca', 'a', 5 );
  expected = [ 'abca', undefined, '' ];
  test.identical( got , expected );

  /* - */

  test.case = 'multiple delimeter'

  /**/

  got = _.strIsolateLeftOrNone( 'abca', [ 'a', 'c' ], 1 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got , expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abca', [ 'a', 'c' ], 2 );
  expected = [ 'ab', 'c', 'a' ];
  test.identical( got , expected );

  /**/

  got = _.strIsolateLeftOrNone( 'abca', [ 'a', 'c' ], 3 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got , expected );

  /* no occurrences */

  got = _.strIsolateLeftOrNone( 'jj', [ 'a', 'c' ], 1 );
  expected = [ '', undefined, 'jj' ];
  test.identical( got , expected );

  /* no occurrences */

  got = _.strIsolateLeftOrNone( 'jj', [ 'a' ], 1 );
  expected = [ '', undefined, 'jj' ];
  test.identical( got , expected );

  /* - */

  test.case = 'options as map';

  /**/

  got = _.strIsolateLeftOrNone({ src : 'abca', delimeter : 'a', times : 1 });
  expected = [ '', 'a', 'bca' ];
  test.identical( got , expected );

  /* number option is missing */

  got = _.strIsolateLeftOrNone({ src : 'abca', delimeter : 'a' });
  expected = [ '', 'a', 'bca' ];
  test.identical( got , expected );

  /* - */

  test.case = 'number option check';

  /* number is zero */

  got = _.strIsolateLeftOrNone( 'abca', 'a', 0 );
  expected = [ '', undefined, 'abca' ];
  test.identical( got , expected );

  /* number is negative */

  got = _.strIsolateLeftOrNone( 'abca', 'a', -1 );
  expected = [ '', undefined, 'abca' ];
  test.identical( got , expected );

  /* - */

  test.open( 'abaaca with strings' )

  got = _.strIsolateLeftOrNone( 'abaaca', 'a', 0 );
  expected = [ '', undefined, 'abaaca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abaaca', 'a', 1 );
  expected = [ '', 'a', 'baaca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abaaca', 'a', 2 );
  expected = [ 'ab', 'a', 'aca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abaaca', 'a', 3 );
  expected = [ 'aba', 'a', 'ca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abaaca', 'a', 4 );
  expected = [ 'abaac', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abaaca', 'a', 5 );
  expected = [ 'abaaca', undefined, '' ];
  test.identical( got, expected );

  test.close( 'abaaca with strings' )
  test.open( 'abababa with strings' )

  got = _.strIsolateLeftOrNone( 'abababa', 'aba', 1 );
  expected = [ '', 'aba', 'baba' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abababa', 'aba', 2 );
  expected = [ 'ab', 'aba', 'ba' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abababa', 'aba', 3 );
  expected = [ 'abab', 'aba', '' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abababa', 'aba', 4 );
  expected = [ 'abababa', undefined, '' ];
  test.identical( got, expected );

  test.close( 'abababa with strings' )

  /* - */

  test.open( 'abaaca with regexp' )

  got = _.strIsolateLeftOrNone( 'abaaca', /a+/, 0 );
  expected = [ '', undefined, 'abaaca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abaaca', /a+/, 1 );
  expected = [ '', 'a', 'baaca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abaaca', /a+/, 2 );
  expected = [ 'ab', 'aa', 'ca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abaaca', /a+/, 3 );
  expected = [ 'aba', 'a', 'ca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abaaca', /a+/, 4 );
  expected = [ 'abaac', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abaaca', /a+/, 5 );
  expected = [ 'abaaca', undefined, '' ];
  test.identical( got, expected );

  test.close( 'abaaca with regexp' )
  test.open( 'abababa with regexp' )

  got = _.strIsolateLeftOrNone( 'abababa', /aba/, 1 );
  expected = [ '', 'aba', 'baba' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abababa', /aba/, 2 );
  expected = [ 'ab', 'aba', 'ba' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abababa', /aba/, 3 );
  expected = [ 'abab', 'aba', '' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrNone( 'abababa', /aba/, 4 );
  expected = [ 'abababa', undefined, '' ];
  test.identical( got, expected );

  test.close( 'abababa with regexp' )

  /* - */

  test.open( 'quoting' ); /* qqq : extend the group | Dmytro : extended */

  test.case = 'quote - 0';
  var got = _.strIsolateLeftOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 0 } );
  var expected = [ '"a', ' ', 'b" c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 0, times - 3';
  var got = _.strIsolateLeftOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 0, times : 3 } );
  var expected = [ '"a b" c', ' ', '"d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 0';
  var got = _.strIsolateLeftOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 0 } );
  var expected = [ '', undefined, '"a b" c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 1';
  var got = _.strIsolateLeftOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 1 } );
  var expected = [ '"a b"', ' ', 'c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 2';
  var got = _.strIsolateLeftOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 2 } );
  var expected = [ '"a b" c', ' ', '"d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 3';
  var got = _.strIsolateLeftOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 3 } );
  var expected = [ '"a b" c "d e"', undefined, '' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 4';
  var got = _.strIsolateLeftOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 4 } );
  var expected = [ '"a b" c "d e"', undefined, '' ];
  test.identical( got, expected );

  test.close( 'quoting' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'single argument but object expected';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateLeftOrNone( 'abc' );
  })

  test.case = 'invalid option';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateLeftOrNone({ src : 'abc', delimeter : 'a', x : 'a' });
  })

  test.case = 'changing of left option not allowed';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateLeftOrNone({ src : 'abc', delimeter : 'a', left : 0 });
  })

}

//

function strIsolateLeftOrAll( test )
{
  var got, expected;

  test.case = 'cut in most left position';

  /* nothing */

  got = _.strIsolateLeftOrAll( '', 'b' );
  expected = [ '', undefined, '' ];
  test.identical( got, expected );

  /* nothing */

  got = _.strIsolateLeftOrAll( '', '' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrAll( 'appc', 'p' );
  expected = [ 'a', 'p', 'pc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrAll( 'appc', 'c' );
  expected = [ 'app', 'c', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrAll( 'appc', 'a' );
  expected = [ '', 'a', 'ppc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateLeftOrAll( 'jj', 'a' );
  expected = [ 'jj', undefined, '' ];
  test.identical( got, expected );

  /* - */

  test.open( 'abaaca with strings' )

  got = _.strIsolateLeftOrAll( 'abaaca', 'a', 0 );
  expected = [ '', undefined, 'abaaca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abaaca', 'a', 1 );
  expected = [ '', 'a', 'baaca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abaaca', 'a', 2 );
  expected = [ 'ab', 'a', 'aca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abaaca', 'a', 3 );
  expected = [ 'aba', 'a', 'ca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abaaca', 'a', 4 );
  expected = [ 'abaac', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abaaca', 'a', 5 );
  expected = [ 'abaaca', undefined, '' ];
  test.identical( got, expected );

  test.close( 'abaaca with strings' )
  test.open( 'abababa with strings' )

  got = _.strIsolateLeftOrAll( 'abababa', 'aba', 1 );
  expected = [ '', 'aba', 'baba' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abababa', 'aba', 2 );
  expected = [ 'ab', 'aba', 'ba' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abababa', 'aba', 3 );
  expected = [ 'abab', 'aba', '' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abababa', 'aba', 4 );
  expected = [ 'abababa', undefined, '' ];
  test.identical( got, expected );

  test.close( 'abababa with strings' )

  /* - */

  test.open( 'abaaca with regexp' )

  got = _.strIsolateLeftOrAll( 'abaaca', /a+/, 0 );
  expected = [ '', undefined, 'abaaca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abaaca', /a+/, 1 );
  expected = [ '', 'a', 'baaca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abaaca', /a+/, 2 );
  expected = [ 'ab', 'aa', 'ca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abaaca', /a+/, 3 );
  expected = [ 'aba', 'a', 'ca' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abaaca', /a+/, 4 );
  expected = [ 'abaac', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abaaca', /a+/, 5 );
  expected = [ 'abaaca', undefined, '' ];
  test.identical( got, expected );

  test.close( 'abaaca with regexp' )
  test.open( 'abababa with regexp' )

  got = _.strIsolateLeftOrAll( 'abababa', /aba/, 1 );
  expected = [ '', 'aba', 'baba' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abababa', /aba/, 2 );
  expected = [ 'ab', 'aba', 'ba' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abababa', /aba/, 3 );
  expected = [ 'abab', 'aba', '' ];
  test.identical( got, expected );

  got = _.strIsolateLeftOrAll( 'abababa', /aba/, 4 );
  expected = [ 'abababa', undefined, '' ];
  test.identical( got, expected );

  test.close( 'abababa with regexp' )

  /* - */

  test.open( 'quoting' ); /* qqq : extend the group | Dmytro : extended */

  test.case = 'quote - 0';
  var got = _.strIsolateLeftOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 0 } );
  var expected = [ '"a', ' ', 'b" c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 0, times - 3';
  var got = _.strIsolateLeftOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 0, times : 3 } );
  var expected = [ '"a b" c', ' ', '"d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 0';
  var got = _.strIsolateLeftOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 0 } );
  var expected = [ '', undefined, '"a b" c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 1';
  var got = _.strIsolateLeftOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 1 } );
  var expected = [ '"a b"', ' ', 'c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 2';
  var got = _.strIsolateLeftOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 2 } );
  var expected = [ '"a b" c', ' ', '"d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 3';
  var got = _.strIsolateLeftOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 3 } );
  var expected = [ '"a b" c "d e"', undefined, '' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 4';
  var got = _.strIsolateLeftOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 4 } );
  var expected = [ '"a b" c "d e"', undefined, '' ];
  test.identical( got, expected );

  test.close( 'quoting' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'delimeter must be a String';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateLeftOrAll( 'jj', 1 );
  });

  test.case = 'source must be a String';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateLeftOrAll( 1, '1' );
  });

}

//

function strIsolateRightOrNone( test )
{
  var got, expected;

  /* - */

  test.case = 'single delimeter';

  /**/

  got = _.strIsolateRightOrNone( '', '' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( '', [ '' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abc', [ '' ] );
  expected = [ 'abc', '', '' ];
  test.identical( got, expected );

  /* empty delimeters array */

  got = _.strIsolateRightOrNone( 'abca', [] );
  expected = [ 'abca', undefined, '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( '', 'a' );
  expected = [ '', undefined, '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( '', [ 'a' ] );
  expected = [ '', undefined, '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'abca', 'a' );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'abca', [ 'a' ] );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strIsolateRightOrNone( 'abca', 'd' );
  expected = [ 'abca', undefined, '' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strIsolateRightOrNone( 'abca', [ 'd' ] );
  expected = [ 'abca', undefined, '' ];
  test.identical( got, expected );

  /* - */

  test.case = 'single delimeter, number';

  got = _.strIsolateRightOrNone( 'abca', '', 2 );
  expected = [ 'abc', '', 'a' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strIsolateRightOrNone( 'abca', 'a', 2 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strIsolateRightOrNone( 'abca', [ 'a' ], 2 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strIsolateRightOrNone( 'abcaca', 'a', 3 );
  expected = [ '', 'a', 'bcaca' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strIsolateRightOrNone( 'abcaca', [ 'a' ], 3 );
  expected = [ '', 'a', 'bcaca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'abcaca', 'a', 4 );
  expected = [ '', undefined, 'abcaca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'abcaca', [ 'a' ], 4 );
  expected = [ '', undefined, 'abcaca' ];
  test.identical( got, expected );

  /* - */

  test.case = 'several delimeters';

  /**/

  got = _.strIsolateRightOrNone( 'abca', [ 'a', 'c' ] );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'abca', [ 'c', 'a' ] );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'abca', [ 'x', 'y' ] );
  expected = [ 'abca', undefined, ''  ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'abca', [ 'x', 'y', 'a' ] );
  expected = [ 'abc', 'a', ''  ];
  test.identical( got, expected );

  /* - */

  test.case = 'several delimeters, number';

  /* empty delimeters array */

  got = _.strIsolateRightOrNone( 'abca', [], 2 );
  expected = [ 'abca', undefined, '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'abca', [ 'a', 'c' ], 1 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abca', [ 'a', 'c' ], 2 );
  expected = [ 'ab', 'c', 'a' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'abcbc', [ 'c', 'a' ], 2 );
  expected = [ 'ab', 'c', 'bc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'cbcbc', [ 'c', 'a' ], 3 );
  expected = [ '', 'c', 'bcbc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'cbcbc', [ 'c', 'a' ], 4 );
  expected = [ '', undefined, 'cbcbc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'jj', [ 'c', 'a' ], 4 );
  expected = [ 'jj', undefined, '' ];
  test.identical( got, expected );

  /* - */

  test.case = 'one of delimeters contains other';

  /* - */

  got = _.strIsolateRightOrNone( 'ab', [ 'a', 'ab' ] );
  expected = [ '', 'a', 'b' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'ab', [ 'ab', 'a' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'ab', [ 'b', 'ab' ] );
  expected = [ 'a', 'b', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrNone( 'ab', [ 'ab', 'b' ] );
  expected = [ 'a', 'b', '' ];
  test.identical( got, expected );

  /* - */

  test.case = 'defaults'

  /**/

  got = _.strIsolateRightOrNone( 'a b c', ' ', 1 );
  expected = [ 'a b', ' ', 'c' ];
  test.identical( got, expected );

  /* - */

  test.case = 'single delimeter'

  /* cut on first appear */

  got = _.strIsolateRightOrNone( 'abca', 'a', 1 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got , expected );

  /* no occurrences */

  got = _.strIsolateRightOrNone( 'jj', 'a', 1 );
  expected = [ 'jj', undefined, '' ];
  test.identical( got , expected );

  /* cut on second appear */

  got = _.strIsolateRightOrNone( 'abca', 'a', 2 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got , expected );

  /**/

  got = _.strIsolateRightOrNone( 'abca', 'a', 5 );
  expected = [ '', undefined, 'abca' ];
  test.identical( got , expected );

  /* - */

  test.case = 'multiple delimeter'

  /**/

  got = _.strIsolateRightOrNone( 'abca', [ 'a', 'c' ], 1 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got , expected );

  /**/

  got = _.strIsolateRightOrNone( 'abca', [ 'a', 'c' ], 2 );
  expected = [ 'ab', 'c', 'a' ];
  test.identical( got , expected );

  /**/

  got = _.strIsolateRightOrNone( 'abca', [ 'a', 'c' ], 3 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got , expected );

  /* no occurrences */

  got = _.strIsolateRightOrNone( 'jj', [ 'a', 'c' ], 1 );
  expected = [ 'jj', undefined, '' ];
  test.identical( got , expected );

  /* no occurrences */

  got = _.strIsolateRightOrNone( 'jj', [ 'a' ], 1 );
  expected = [ 'jj', undefined, '' ];
  test.identical( got , expected );

  /* - */

  test.case = 'options as map';

  /**/

  got = _.strIsolateRightOrNone({ src : 'abca', delimeter : 'a', times : 1 });
  expected = [ 'abc', 'a', '' ];
  test.identical( got , expected );

  /* number option is missing */

  got = _.strIsolateRightOrNone({ src : 'abca', delimeter : 'a' });
  expected = [ 'abc', 'a', '' ];
  test.identical( got , expected );

  /* - */

  test.case = 'number option check';

  /* number is zero */

  got = _.strIsolateRightOrNone( 'abca', 'a', 0 );
  expected = [ 'abca', undefined, '' ];
  test.identical( got , expected );

  /* number is negative */

  got = _.strIsolateRightOrNone( 'abca', 'a', -1 );
  expected = [ 'abca', undefined, '' ];
  test.identical( got , expected );

  /* */

  got = _.strIsolateRightOrNone( 'acbca', [ 'a', 'c' ], 1 );
  expected = [ 'acbc', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'acbca', [ 'a', 'c' ], 2 );
  expected = [ 'acb', 'c', 'a' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abababa', 'aba', 1 );
  expected = [ 'abab', 'aba', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abababa', 'aba', 2 );
  expected = [ 'ab', 'aba', 'ba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abababa', 'aba', 3 );
  expected = [ '', 'aba', 'baba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abababa', 'aba', 4 );
  expected = [ '', undefined, 'abababa' ];
  test.identical( got, expected );

  /* - */

  test.open( 'abaaca with strings' )

  got = _.strIsolateRightOrNone( 'abaaca', 'a', 0 );
  expected = [ 'abaaca', undefined, '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abaaca', 'a', 1 );
  expected = [ 'abaac', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abaaca', 'a', 2 );
  expected = [ 'aba', 'a', 'ca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abaaca', 'a', 3 );
  expected = [ 'ab', 'a', 'aca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abaaca', 'a', 4 );
  expected = [ '', 'a', 'baaca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abaaca', 'a', 5 );
  expected = [ '', undefined, 'abaaca' ];
  test.identical( got, expected );

  test.close( 'abaaca with strings' )
  test.open( 'abababa with strings' )

  got = _.strIsolateRightOrNone( 'abababa', 'aba', 1 );
  expected = [ 'abab', 'aba', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abababa', 'aba', 2 );
  expected = [ 'ab', 'aba', 'ba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abababa', 'aba', 3 );
  expected = [ '', 'aba', 'baba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abababa', 'aba', 4 );
  expected = [ '', undefined, 'abababa' ];
  test.identical( got, expected );

  test.close( 'abababa with strings' )

  /* - */

  test.open( 'abaaca with regexp' )

  got = _.strIsolateRightOrNone( 'abaaca', /a+/, 0 );
  expected = [ 'abaaca', undefined, '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abaaca', /a+/, 1 );
  expected = [ 'abaac', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abaaca', /a+/, 2 );
  expected = [ 'ab', 'aa', 'ca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abaaca', /a+/, 3 );
  expected = [ 'ab', 'a', 'aca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abaaca', /a+/, 4 );
  expected = [ '', 'a', 'baaca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abaaca', /a+/, 5 );
  expected = [ '', undefined, 'abaaca' ];
  test.identical( got, expected );

  test.close( 'abaaca with regexp' )
  test.open( 'abababa with regexp' )

  got = _.strIsolateRightOrNone( 'abababa', /aba/, 1 );
  expected = [ 'abab', 'aba', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abababa', /aba/, 2 );
  expected = [ 'ab', 'aba', 'ba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abababa', /aba/, 3 );
  expected = [ '', 'aba', 'baba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrNone( 'abababa', /aba/, 4 );
  expected = [ '', undefined, 'abababa' ];
  test.identical( got, expected );

  test.close( 'abababa with regexp' )

  /* - */

  test.open( 'quoting' ); /* qqq : extend the group | Dmytro : extended */

  test.case = 'quote - 0';
  var got = _.strIsolateRightOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 0 } );
  var expected = [ '"a b" c "d', ' ', 'e"' ];
  test.identical( got, expected );

  test.case = 'quote - 0, times - 3';
  var got = _.strIsolateRightOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 0, times : 4 } );
  var expected = [ '"a', ' ', 'b" c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 0';
  var got = _.strIsolateRightOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 0 } );
  var expected = [ '"a b" c "d e"', undefined, '' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 1';
  var got = _.strIsolateRightOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 1 } );
  var expected = [ '"a b" c', ' ', '"d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 2';
  var got = _.strIsolateRightOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 2 } );
  var expected = [ '"a b"', ' ', 'c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 3';
  var got = _.strIsolateRightOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 3 } );
  var expected = [ '', undefined, '"a b" c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 4';
  var got = _.strIsolateRightOrNone( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 4 } );
  var expected = [ '', undefined, '"a b" c "d e"' ];
  test.identical( got, expected );

  test.close( 'quoting' );

  /* */

  if( !Config.debug )
  return;

  test.case = 'single argument but object expected';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateRightOrNone( 'abc' );
  });

  test.case = 'invalid option';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateRightOrNone({ src : 'abc', delimeter : 'a', x : 'a' });
  });

  test.case = 'changing of left option not allowed';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateRightOrNone({ src : 'abc', delimeter : 'a', left : 0 });
  });

}

//

function strIsolateRightOrAll( test )
{
  var got, expected;

  test.case = 'cut in most right position';

  /* nothing */

  got = _.strIsolateRightOrAll( '', '' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /* nothing */

  got = _.strIsolateRightOrAll( '', 'b' );
  expected = [ '', undefined, '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrAll( 'ahpc', 'h' );
  expected = [ 'a', 'h', 'pc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrAll( 'ahpc', 'c' );
  expected = [ 'ahp', 'c', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrAll( 'appbb', 'b' );
  expected = [ 'appb', 'b', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateRightOrAll( 'jj', 'a' );
  expected = [ '', undefined, 'jj' ];
  test.identical( got, expected );

  /* */

  got = _.strIsolateRightOrAll( 'acbca', [ 'a', 'c' ], 1 );
  expected = [ 'acbc', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'acbca', [ 'a', 'c' ], 2 );
  expected = [ 'acb', 'c', 'a' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abababa', 'aba', 1 );
  expected = [ 'abab', 'aba', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abababa', 'aba', 2 );
  expected = [ 'ab', 'aba', 'ba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abababa', 'aba', 3 );
  expected = [ '', 'aba', 'baba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abababa', 'aba', 4 );
  expected = [ '', undefined, 'abababa' ];
  test.identical( got, expected );

  /* - */

  test.open( 'abaaca with strings' )

  got = _.strIsolateRightOrAll( 'abaaca', 'a', 0 );
  expected = [ 'abaaca', undefined, '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abaaca', 'a', 1 );
  expected = [ 'abaac', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abaaca', 'a', 2 );
  expected = [ 'aba', 'a', 'ca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abaaca', 'a', 3 );
  expected = [ 'ab', 'a', 'aca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abaaca', 'a', 4 );
  expected = [ '', 'a', 'baaca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abaaca', 'a', 5 );
  expected = [ '', undefined, 'abaaca' ];
  test.identical( got, expected );

  test.close( 'abaaca with strings' )
  test.open( 'abababa with strings' )

  got = _.strIsolateRightOrAll( 'abababa', 'aba', 1 );
  expected = [ 'abab', 'aba', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abababa', 'aba', 2 );
  expected = [ 'ab', 'aba', 'ba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abababa', 'aba', 3 );
  expected = [ '', 'aba', 'baba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abababa', 'aba', 4 );
  expected = [ '', undefined, 'abababa' ];
  test.identical( got, expected );

  test.close( 'abababa with strings' )

  /* - */

  test.open( 'abaaca with regexp' )

  got = _.strIsolateRightOrAll( 'abaaca', /a+/, 0 );
  expected = [ 'abaaca', undefined, '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abaaca', /a+/, 1 );
  expected = [ 'abaac', 'a', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abaaca', /a+/, 2 );
  expected = [ 'ab', 'aa', 'ca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abaaca', /a+/, 3 );
  expected = [ 'ab', 'a', 'aca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abaaca', /a+/, 4 );
  expected = [ '', 'a', 'baaca' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abaaca', /a+/, 5 );
  expected = [ '', undefined, 'abaaca' ];
  test.identical( got, expected );

  test.close( 'abaaca with regexp' )
  test.open( 'abababa with regexp' )

  got = _.strIsolateRightOrAll( 'abababa', /aba/, 1 );
  expected = [ 'abab', 'aba', '' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abababa', /aba/, 2 );
  expected = [ 'ab', 'aba', 'ba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abababa', /aba/, 3 );
  expected = [ '', 'aba', 'baba' ];
  test.identical( got, expected );

  got = _.strIsolateRightOrAll( 'abababa', /aba/, 4 );
  expected = [ '', undefined, 'abababa' ];
  test.identical( got, expected );

  test.close( 'abababa with regexp' )

  /* - */

  test.open( 'quoting' ); /* qqq : extend the group | Dmytro : extended */

  test.case = 'quote - 0';
  var got = _.strIsolateRightOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 0 } );
  var expected = [ '"a b" c "d', ' ', 'e"' ];
  test.identical( got, expected );

  test.case = 'quote - 0, times - 3';
  var got = _.strIsolateRightOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 0, times : 4 } );
  var expected = [ '"a', ' ', 'b" c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 0';
  var got = _.strIsolateRightOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 0 } );
  var expected = [ '"a b" c "d e"', undefined, '' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 1';
  var got = _.strIsolateRightOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 1 } );
  var expected = [ '"a b" c', ' ', '"d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 2';
  var got = _.strIsolateRightOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 2 } );
  var expected = [ '"a b"', ' ', 'c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 3';
  var got = _.strIsolateRightOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 3 } );
  var expected = [ '', undefined, '"a b" c "d e"' ];
  test.identical( got, expected );

  test.case = 'quote - 1, times - 4';
  var got = _.strIsolateRightOrAll( { src : '"a b" c "d e"', delimeter : ' ', quote : 1, times : 4 } );
  var expected = [ '', undefined, '"a b" c "d e"' ];
  test.identical( got, expected );

  test.close( 'quoting' );

  /* */

  if( !Config.debug )
  return;

  test.case = 'delimeter must be a String';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateRightOrAll( 'jj', 1 );
  })

  test.case = 'source must be a String';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateRightOrAll( 1, '1' );
  })

}

//
//
// function strIsolateInsideOrNone( test )
// {
//
//   /* - */
//
//   test.open( 'string' );
//
//   /* - */
//
//   test.case = 'begin';
//
//   var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'aa', 'bb' );
//   test.identical( got, expected );
//
//   test.case = 'middle';
//
//   var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'bb', 'cc' );
//   test.identical( got, expected );
//
//   test.case = 'end';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'cc', 'dd' );
//   test.identical( got, expected );
//   var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'cc', '' );
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'begin, several entry';
//
//   var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'aa', 'bb' ], [ 'aa', 'bb' ] );
//   test.identical( got, expected );
//   var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'aa' ], [ 'bb', 'aa' ] );
//   test.identical( got, expected );
//
//   test.case = 'middle, several entry';
//
//   var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'cc' ], [ 'bb', 'cc' ] );
//   test.identical( got, expected );
//   var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'bb' ], [ 'cc', 'bb' ] );
//   test.identical( got, expected );
//
//   test.case = 'end, several entry';
//
//   var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'dd' ], [ 'cc', 'dd' ] );
//   test.identical( got, expected );
//   var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ], [ 'dd', 'cc' ] );
//   test.identical( got, expected );
//   var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ], [ '', '' ] );
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'begin, several entry, several sources';
//
//   var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 'aa', 'bb' ] );
//   test.identical( got, expected );
//   var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'aa' ], [ 'bb', 'aa' ] );
//   test.identical( got, expected );
//
//   test.case = 'middle, several entry, several sources';
//
//   var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'cc' ], [ 'bb', 'cc' ] );
//   test.identical( got, expected );
//   var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'bb' ], [ 'cc', 'bb' ] );
//   test.identical( got, expected );
//
//   test.case = 'end, several entry, several sources';
//
//   var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'dd' ], [ 'cc', 'dd' ] );
//   test.identical( got, expected );
//   var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ], [ 'dd', 'cc' ] );
//   test.identical( got, expected );
//   var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ], [ '', 'cc', '_cc_bb_bb_aa_aa', '', '' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ], [ '', '' ] );
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'no entry';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [], [] );
//   test.identical( got, expected );
//
//   test.case = 'not found';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'dd', 'dd' );
//   test.identical( got, expected );
//
//   test.case = 'not found begin';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'dd', '' );
//   test.identical( got, expected );
//
//   test.case = 'not found end';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', '', 'dd' );
//   test.identical( got, expected );
//
//   test.case = 'empty entry';
//
//   var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', '', '' );
//   test.identical( got, expected );
//
//   test.case = 'empty entry, empty src';
//
//   var expected = [ '', '', '', '', '' ];
//   var got = _.strIsolateInsideOrNone( '', '', '' );
//   test.identical( got, expected );
//
//   test.case = 'empty src';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( '', 'aa', 'bb' );
//   test.identical( got, expected );
//
//   /* - */
//
//   test.close( 'string' );
//   test.open( 'regexp' );
//
//   /* */
//
//   test.case = 'begin smeared';
//
//   var expected = [ 'x', 'aa', 'x_xaax_xbbx_xb', 'bx', '_xccx_xccx' ];
//   var got = _.strIsolateInsideOrNone( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /a\w/, /b\w/ );
//   test.identical( got, expected );
//
//   test.case = 'middle smeared';
//
//   var expected = [ 'xaax_xaax_x', 'bb', 'x_xbbx_xccx_xc', 'cx', '' ];
//   var got = _.strIsolateInsideOrNone( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /b\w/, /c\w/ );
//   test.identical( got, expected );
//
//   test.case = 'end smeared';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/, /d\w/ );
//   test.identical( got, expected );
//   var expected = [ 'xaax_xaax_xbbx_xbbx_x', 'cc', 'x_xccx', '', '' ];
//   var got = _.strIsolateInsideOrNone( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/, new RegExp( '' ) );
//   test.identical( got, expected );
//
//   test.case = 'begin';
//
//   var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /a+/, /b+/ );
//   test.identical( got, expected );
//
//   test.case = 'middle';
//
//   var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /b+/, /c+/ );
//   test.identical( got, expected );
//
//   test.case = 'end';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /c+/, /d+/ );
//   test.identical( got, expected );
//   var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /c+/, new RegExp( '' ) );
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'begin, several entry';
//
//   var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /a+/, /b+/ ], [ /a+/, /b+/ ] );
//   test.identical( got, expected );
//   var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /b+/, /a+/ ], [ /b+/, /a+/ ] );
//   test.identical( got, expected );
//
//   test.case = 'middle, several entry';
//
//   var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /b+/, /c+/ ], [ /b+/, /c+/ ] );
//   test.identical( got, expected );
//   var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /c+/, /b+/ ], [ /c+/, /b+/ ] );
//   test.identical( got, expected );
//
//   test.case = 'end, several entry';
//
//   var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /c+/, /d+/ ], [ /c+/, /d+/ ] );
//   test.identical( got, expected );
//   var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ], [ /d+/, /c+/ ] );
//   test.identical( got, expected );
//   var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ], [ new RegExp( '' ), new RegExp( '' ) ] );
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'begin, several entry, several sources';
//
//   var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, /b+/ ], [ /a+/, /b+/ ] );
//   test.identical( got, expected );
//   var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /a+/ ], [ /b+/, /a+/ ] );
//   test.identical( got, expected );
//
//   test.case = 'middle, several entry, several sources';
//
//   var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /c+/ ], [ /b+/, /c+/ ] );
//   test.identical( got, expected );
//   var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /b+/ ], [ /c+/, /b+/ ] );
//   test.identical( got, expected );
//
//   test.case = 'end, several entry, several sources';
//
//   var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /d+/ ], [ /c+/, /d+/ ] );
//   test.identical( got, expected );
//   var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ], [ /d+/, /c+/ ] );
//   test.identical( got, expected );
//   var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ], [ '', 'cc', '_cc_bb_bb_aa_aa', '', '' ] ];
//   var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ], [ new RegExp( '' ), new RegExp( '' ) ] );
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'no entry';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [], [] );
//   test.identical( got, expected );
//
//   test.case = 'not found';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /d+/, /d+/ );
//   test.identical( got, expected );
//
//   test.case = 'not found begin';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /d+/, new RegExp( '' ) );
//   test.identical( got, expected );
//
//   test.case = 'not found end';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ), /d+/ );
//   test.identical( got, expected );
//
//   test.case = 'empty entry';
//
//   var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
//   var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ), new RegExp( '' ) );
//   test.identical( got, expected );
//
//   test.case = 'empty entry, empty src';
//
//   var expected = [ '', '', '', '', '' ];
//   var got = _.strIsolateInsideOrNone( '', new RegExp( '' ), new RegExp( '' ) );
//   test.identical( got, expected );
//
//   test.case = 'empty src';
//
//   var expected = undefined;
//   var got = _.strIsolateInsideOrNone( '', /a+/, /b+/ );
//   test.identical( got, expected );
//
//   /* - */
//
//   test.close( 'regexp' );
//
//   /* - */
//
//   if( !Config.debug )
//   return;
//
//   test.shouldThrowErrorSync( () => _.strIsolateInsideOrNone() );
//   test.shouldThrowErrorSync( () => _.strIsolateInsideOrNone( '' ) );
//   test.shouldThrowErrorSync( () => _.strIsolateInsideOrNone( '', '' ) );
//   test.shouldThrowErrorSync( () => _.strIsolateInsideOrNone( '', '', '', '' ) );
//   test.shouldThrowErrorSync( () => _.strIsolateInsideOrNone( 1, '', '' ) );
//   test.shouldThrowErrorSync( () => _.strIsolateInsideOrNone( '123', 1, '' ) );
//   test.shouldThrowErrorSync( () => _.strIsolateInsideOrNone( '123', '', 3 ) );
//
// }

//

function strIsolateInsideLeft( test )
{
  test.open( 'string' );

  test.case = 'begin';
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', 'aa', 'bb' );
  test.identical( got, expected );

  test.case = 'middle';
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', 'bb', 'cc' );
  test.identical( got, expected );

  test.case = 'end';
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', 'cc', '' );
  test.identical( got, expected );

  test.case = 'nothing found';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', 'cc', 'dd' );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ 'aa', 'bb' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'cc' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'bb' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry';
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'dd' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ], [ '', '' ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';
  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';
  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'cc' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'bb' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'dd' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ], [ '', 'cc', '_cc_bb_bb_aa_aa', '', '' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ], [ '', '' ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [], [] );
  test.identical( got, expected );

  test.case = 'not found';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', 'dd', 'dd' );
  test.identical( got, expected );

  test.case = 'not found begin';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', 'dd', '' );
  test.identical( got, expected );

  test.case = 'not found end';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', '', 'dd' );
  test.identical( got, expected );

  test.case = 'empty entry';
  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', '', '' );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';
  var expected = [ '', '', '', '', '' ];
  var got = _.strIsolateInsideLeft( '', '', '' );
  test.identical( got, expected );

  test.case = 'empty src';
  var expected = [ '', undefined, '', undefined, '' ];
  var got = _.strIsolateInsideLeft( '', 'aa', 'bb' );
  test.identical( got, expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp' );

  test.case = 'begin smeared';
  var expected = [ 'x', 'aa', 'x_xaax_xbbx_xb', 'bx', '_xccx_xccx' ];
  var got = _.strIsolateInsideLeft( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /a\w/, /b\w/ );
  test.identical( got, expected );

  test.case = 'middle smeared';
  var expected = [ 'xaax_xaax_x', 'bb', 'x_xbbx_xccx_xc', 'cx', '' ];
  var got = _.strIsolateInsideLeft( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /b\w/, /c\w/ );
  test.identical( got, expected );

  test.case = 'end smeared';
  var expected = [ '', undefined, 'xaax_xaax_xbbx_xbbx_xccx_xccx', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/, /d\w/ );
  test.identical( got, expected );
  var expected = [ 'xaax_xaax_xbbx_xbbx_x', 'cc', 'x_xccx', '', '' ];
  var got = _.strIsolateInsideLeft( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/, new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'begin';
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', /a+/, /b+/ );
  test.identical( got, expected );

  test.case = 'middle';
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', /b+/, /c+/ );
  test.identical( got, expected );

  test.case = 'end';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', /c+/, /d+/ );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', /c+/, new RegExp( '' ) );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ /a+/, /b+/ ], [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ /b+/, /a+/ ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ /b+/, /c+/ ], [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ /c+/, /b+/ ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry';
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ /c+/, /d+/ ], [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ], [ /d+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ], [ new RegExp( '' ), new RegExp( '' ) ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';
  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, /b+/ ], [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /a+/ ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';
  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /c+/ ], [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /b+/ ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /d+/ ], [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ], [ /d+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ], [ '', 'cc', '_cc_bb_bb_aa_aa', '', '' ] ];
  var got = _.strIsolateInsideLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ], [ new RegExp( '' ), new RegExp( '' ) ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [], [] );
  test.identical( got, expected );

  test.case = 'not found';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', /d+/, /d+/ );
  test.identical( got, expected );

  test.case = 'not found begin';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', /d+/, new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'not found end';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ), /d+/ );
  test.identical( got, expected );

  test.case = 'empty entry';
  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ), new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';
  var expected = [ '', '', '', '', '' ];
  var got = _.strIsolateInsideLeft( '', new RegExp( '' ), new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty src';
  var expected = [ '', undefined, '', undefined, '' ];
  var got = _.strIsolateInsideLeft( '', /a+/, /b+/ );
  test.identical( got, expected );

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strIsolateInsideLeft() );

  test.case = 'one argument';
  test.shouldThrowErrorSync( () => _.strIsolateInsideLeft( '' ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strIsolateInsideLeft( '', '', '', '' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strIsolateInsideLeft( 1, '', '' ) );

  test.case = 'wrong type of begin';
  test.shouldThrowErrorSync( () => _.strIsolateInsideLeft( '', 3 ) );
  test.shouldThrowErrorSync( () => _.strIsolateInsideLeft( '123', 1, '' ) );

  test.case = 'wrong type of end';
  test.shouldThrowErrorSync( () => _.strIsolateInsideLeft( '123', '', 3 ) );
}

//

function strIsolateInsideLeftPairs( test )
{

  /* */

  test.case = 'string';
  var expected = [ '', 'aa', '_', 'aa', '_bb_bb_cc_cc' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', 'aa' );
  test.identical( got, expected );

  test.case = 'string, nothing found';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', 'aaa' );
  test.identical( got, expected );

  test.case = 'all empty';
  var expected = [ '', '', '', '', '' ];
  var got = _.strIsolateInsideLeft( '', '' );
  test.identical( got, expected );

  test.case = 'empty str delimeter';
  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', '' );
  test.identical( got, expected );

  test.case = 'empty array delimeter';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'begin';
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ [ 'aa', 'bb' ], [ 'bb', 'cc' ] ] );
  test.identical( got, expected );

  test.case = 'middle';
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ [ 'bb', 'cc' ], [ 'cc', 'cc' ] ] );
  test.identical( got, expected );

  test.case = 'end';
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ [ 'cc', '' ], [ 'bb', '' ] ] );
  test.identical( got, expected );

  test.case = 'nothing found';
  var expected = [ '', undefined, 'aa_aa_bb_bb_cc_cc', undefined, '' ];
  var got = _.strIsolateInsideLeft( 'aa_aa_bb_bb_cc_cc', [ [ 'cc', 'dd' ], [ 'aa', 'dd' ] ] );
  test.identical( got, expected );

  /* */

}

// --
// splitter
// --

function strSplitsCoupledGroup( test )
{

  test.open( 'trivial' );

  test.case = 'empty';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', '<<-', 'dd' ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ 'aa', [ '>>', '<<-' ], 'dd' ];
  test.identical( got, expected );

  test.case = 'middle';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', 'bb', 'cc', '<<-', 'dd' ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ 'aa', [ '>>', 'bb', 'cc', '<<-' ], 'dd' ];
  test.identical( got, expected );

  test.case = 'left';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ '>>', 'bb', 'cc', '<<-', 'dd' ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ [ '>>', 'bb', 'cc', '<<-' ], 'dd' ];
  test.identical( got, expected );

  test.case = 'right';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', 'bb', 'cc', '<<-' ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ 'aa', [ '>>', 'bb', 'cc', '<<-' ] ];
  test.identical( got, expected );

  /* - */

  test.close( 'trivial' );
  test.open( 'several' );

  /* - */

  test.case = 'empty';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', '<<-', '>>', '<<-', 'dd' ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ 'aa', [ '>>', '<<-' ], [ '>>', '<<-' ], 'dd' ];
  test.identical( got, expected );

  test.case = 'middle';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', 'bb', 'cc', '<<-', 'dd', '>>', 'ee', 'ff', '<<-', 'gg' ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ 'aa', [ '>>', 'bb', 'cc', '<<-' ], 'dd', [ '>>', 'ee', 'ff', '<<-' ], 'gg' ];
  test.identical( got, expected );

  test.case = 'left';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ '>>', 'bb', 'cc', '<<-', '>>', 'ee', 'ff', '<<-', 'gg' ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ [ '>>', 'bb', 'cc', '<<-' ], [ '>>', 'ee', 'ff', '<<-' ], 'gg' ];
  test.identical( got, expected );

  test.case = 'right';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', 'bb', 'cc', '<<-', '>>', 'ee', 'ff', '<<-' ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ 'aa', [ '>>', 'bb', 'cc', '<<-' ], [ '>>', 'ee', 'ff', '<<-' ] ];
  test.identical( got, expected );

  test.close( 'several' );
  test.open( 'recursion' );

  /* - */

  test.case = 'empty';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', '>>', '<<=', '<<-', 'dd' ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ 'aa', [ '>>', [ '>>', '<<=' ], '<<-' ], 'dd' ];
  test.identical( got, expected );

  test.case = 'middle';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', 'bb', '>>', 'cc', 'dd', '<<=', 'ee', '<<-', 'ff',  ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ 'aa', [ '>>', 'bb', [ '>>', 'cc', 'dd', '<<=' ], 'ee', '<<-' ], 'ff' ];
  test.identical( got, expected );

  test.case = 'left';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ '>>', '>>', 'cc', 'dd', '<<=', 'ee', '<<-', 'ff',  ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ [ '>>', [ '>>', 'cc', 'dd', '<<=' ], 'ee', '<<-' ], 'ff' ];
  test.identical( got, expected );

  test.case = 'right';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', 'bb', '>>', 'cc', 'dd', '<<=', '<<-'  ],
    prefix : '>>',
    postfix : /^<</,
  });
  var expected = [ 'aa', [ '>>', 'bb', [ '>>', 'cc', 'dd', '<<=' ], '<<-' ] ];
  test.identical( got, expected );

  test.close( 'recursion' );
  test.open( 'uncoupled prefix' );

  /* - */

  test.case = 'empty';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', '>>', '<<-', 'dd' ],
    prefix : '>>',
    postfix : /^<</,
    allowingUncoupledPrefix : 1,
  });
  var expected = [ 'aa', '>>', [ '>>', '<<-' ], 'dd' ];
  test.identical( got, expected );

  test.case = 'middle';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', 'bb', '>>', 'cc', '>>', 'dd', '<<=', 'ee', 'ff',  ],
    prefix : '>>',
    postfix : /^<</,
    allowingUncoupledPrefix : 1,
  });
  var expected = [ 'aa', 'bb', '>>', 'cc', [ '>>', 'dd', '<<=' ], 'ee', 'ff' ];
  test.identical( got, expected );

  test.case = 'left';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ '>>', '>>', 'dd', '<<=', 'ee', 'ff',  ],
    prefix : '>>',
    postfix : /^<</,
    allowingUncoupledPrefix : 1,
  });
  var expected = [ '>>', [ '>>', 'dd', '<<=' ], 'ee', 'ff' ];
  test.identical( got, expected );

  test.case = 'right';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', 'bb', '>>', 'cc', '>>', '<<=' ],
    prefix : '>>',
    postfix : /^<</,
    allowingUncoupledPrefix : 1,
  });
  var expected = [ 'aa', 'bb', '>>', 'cc', [ '>>', '<<=' ] ];
  test.identical( got, expected );

  /* - */

  test.close( 'uncoupled prefix' );
  test.open( 'uncoupled postfix' );

  /* - */

  test.case = 'empty';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', '>>', '<<=', '<<-', 'dd' ],
    prefix : '>>',
    postfix : /^<</,
    allowingUncoupledPostfix : 1,
  });
  var expected = [ 'aa', [ '>>', '<<=' ], '<<-', 'dd' ];
  test.identical( got, expected );

  test.case = 'middle';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', 'bb', '>>', 'cc', 'dd', '<<=', 'ee', '<<-', 'ff',  ],
    prefix : '>>',
    postfix : /^<</,
    allowingUncoupledPostfix : 1,
  });
  var expected = [ 'aa', 'bb', [ '>>', 'cc', 'dd', '<<=' ], 'ee', '<<-', 'ff' ];
  test.identical( got, expected );

  test.case = 'left';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ '>>', 'cc', 'dd', '<<=', 'ee', '<<-', 'ff',  ],
    prefix : '>>',
    postfix : /^<</,
    allowingUncoupledPostfix : 1,
  });
  var expected = [ [ '>>', 'cc', 'dd', '<<=' ], 'ee', '<<-', 'ff' ];
  test.identical( got, expected );

  test.case = 'right';

  var got = _.strSplitsCoupledGroup
  ({
    splits : [ 'aa', 'bb', '>>', 'cc', 'dd', '<<=', '<<-'  ],
    prefix : '>>',
    postfix : /^<</,
    allowingUncoupledPostfix : 1,
  });
  var expected = [ 'aa', 'bb', [ '>>', 'cc', 'dd', '<<=' ], '<<-'  ];
  test.identical( got, expected );

  /* - */

  test.close( 'uncoupled postfix' );
  test.open( 'throwing' )

  /* - */

  test.case = 'uncoupled postfix';
  test.shouldThrowErrorSync( () =>
  {
    _.strSplitsCoupledGroup
    ({
      splits : [ 'aa', '>>', '<<=', '<<-', 'dd' ],
      prefix : '>>',
      postfix : /^<</,
    });
  });

  test.case = 'uncoupled prefix';
  test.shouldThrowErrorSync( () =>
  {
    _.strSplitsCoupledGroup
    ({
      splits : [ 'aa', '>>', '>>', '<<=', 'dd' ],
      prefix : '>>',
      postfix : /^<</,
    });
  });

  test.close( 'throwing' );

}

//

function strSplitsDropEmpty( test )
{
  test.case = 'empty splits array';
  var got = _.strSplitsDropEmpty( { splits : [] } );
  test.identical( got, [] );

  test.case = 'splits array has elements';
  var got = _.strSplitsDropEmpty( { splits : [ '1', '2', '3' ] } );
  test.identical( got, [ '1', '2', '3' ] );

  test.case = 'splits array has elements : null, undefined, false';
  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', null ] } );
  test.identical( got, [ '1', 'str' ] );

  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', undefined ] } );
  test.identical( got, [ '1', 'str' ] );

  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', false ] } );
  test.identical( got, [ '1', 'str' ] );

  var got = _.strSplitsDropEmpty( { splits : [ null, false, undefined ] } );
  test.identical( got, [] );

  test.case = 'splits array has elements in container';
  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', [ '2' ] ] } );
  test.identical( got, [ '1', 'str', [ '2' ] ] );

  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', { a : '2' } ] } );
  test.identical( got, [ '1', 'str', { a : '2' } ] );

  test.case = 'splits array has elements in container : null, undefined, false';
  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', [ null ] ] } );
  test.identical( got, [ '1', 'str', [ null ] ] );

  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', [ undefined ] ] } );
  test.identical( got, [ '1', 'str', [ undefined ] ] );

  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', [ false ] ] } );
  test.identical( got, [ '1', 'str', [ false ] ] );

  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', { a : null } ] } );
  test.identical( got, [ '1', 'str', { a : null } ] );

  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', { a : undefined } ] } );
  test.identical( got, [ '1', 'str', { a : undefined } ] );

  var got = _.strSplitsDropEmpty( { splits : [ '1', 'str', { a : false } ] } );
  test.identical( got, [ '1', 'str', { a : false } ] );

  /* - */

  test.case = 'splits is unroll, empty';
  var splits = _.unrollFrom( [] );
  var got = _.strSplitsDropEmpty( { splits : splits } );
  test.identical( got, [] );
  test.is( _.unrollIs( got ) );

  test.case = 'splits is unroll, no undefines';
  var splits = _.unrollFrom( [ '1', '3', 'str' ] );
  var got = _.strSplitsDropEmpty( { splits : splits } );
  test.identical( got, [ '1', '3', 'str' ] );
  test.is( _.unrollIs( got ) );

  test.case = 'splits is unroll, has undefines';
  var splits = _.unrollFrom( [ '1', 'str', null ] );
  var got = _.strSplitsDropEmpty( { splits : splits } );
  test.identical( got, [ '1', 'str' ] );
  test.is( _.unrollIs( got ) );

  var splits = _.unrollFrom( [ null, false, undefined ] );
  var got = _.strSplitsDropEmpty( { splits : splits } );
  test.identical( got, [] );
  test.is( _.unrollIs( got ) );

  test.case = 'unroll contains another unroll';
  var splits = _.unrollFrom( [ '1', 'str', _.unrollMake( [ '0' ] ) ] );
  var got = _.strSplitsDropEmpty( { splits : splits } );
  test.identical( got, [ '1', 'str', '0' ] );
  test.is( _.unrollIs( got ) );

  test.case = 'unroll contains another unroll, undefines';
  var splits = _.unrollFrom( [ '1', 'str', _.unrollMake( [ null, undefined, false ] ) ] );
  var got = _.strSplitsDropEmpty( { splits : splits } );
  test.identical( got, [ '1', 'str' ] );
  test.is( _.unrollIs( got ) );

  var splits = _.unrollFrom( [ '1', 'str', _.unrollMake( [ [ null, undefined, false ] ] ) ] );
  var got = _.strSplitsDropEmpty( { splits : splits } );
  test.identical( got, [ '1', 'str', [ null, undefined, false ] ] );
  test.is( _.unrollIs( got ) );

  /* - */

  test.case = 'another arrayLike objects in splits';
  var src = _.argumentsArrayMake( [ '0', 'str', false ] );
  var splits = _.arrayFrom( src );
  var got = _.strSplitsDropEmpty( { splits : splits } );
  test.identical( got, [ '0', 'str' ] );

  var splits = new Array( '0', 'str', undefined );
  var got = _.strSplitsDropEmpty( { splits : splits } );
  test.identical( got, [ '0', 'str' ] );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strSplitsDropEmpty() );
  test.shouldThrowErrorSync( () => _.strSplitsDropEmpty( {} ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strSplitsDropEmpty( { splits : [ '1', '2' ] }, 1 ) );

  test.case = 'extra option';
  var src = { splits : [ 1, 2, 3 ], delimeter : '/' };
  test.shouldThrowErrorSync( () => _.strSplitsDropEmpty( src ) );

  test.case = 'invalid arguments';
  test.shouldThrowErrorSync( () => _.strSplitsDropEmpty( 1 ) );
  test.shouldThrowErrorSync( () => _.strSplitsDropEmpty( 'str' ) );
  test.shouldThrowErrorSync( () => _.strSplitsDropEmpty( null ) );
  test.shouldThrowErrorSync( () => _.strSplitsDropEmpty( NaN ) );
  test.shouldThrowErrorSync( () => _.strSplitsDropEmpty( [ 1, 'str' ] ) );
}

//

function strSplitFast( test )
{

  test.case = 'trivial';

  var got = _.strSplitFast( '', '' );
  var expected = [];
  test.identical( got, expected );

  var got = _.strSplitFast( 'abc', '' );
  var expected = [ 'a', '', 'b', '', 'c' ];
  test.identical( got, expected );

  var got = _.strSplitFast( '', 'a' );
  var expected = [ '' ];
  test.identical( got, expected );

  var got = _.strSplitFast( 'test test test' );
  var expected = [ 'test', ' ', 'test', ' ', 'test' ];
  test.identical( got, expected );

  test.case = 'split string into an array of strings';
  var got = _.strSplitFast( ' test   test   test ' );
  var expected = [ '', ' ', 'test', ' ', '', ' ', '', ' ', 'test', ' ', '', ' ', '', ' ', 'test', ' ', '' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var got = _.strSplitFast( ' test   test   test ', 'something' );
  var expected = [ ' test   test   test ' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var got = _.strSplitFast( ' test <delimteter>  test<delimteter>   test ', '<delimteter>' );
  var expected = [ ' test ', '<delimteter>', '  test', '<delimteter>', '   test ' ];
  test.identical( got, expected );

  test.case = 'simple string, default options';
  var got = _.strSplitFast( 'a b c d' );
  var expected = [ 'a', ' ', 'b', ' ', 'c', ' ', 'd' ];
  test.identical( got, expected );

  /*
    preservingEmpty : 1,
    preservingDelimeters : 0,
  */

  var op =
  {
    preservingEmpty : 1,
    preservingDelimeters : 0,
  }

  /* */

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = '';
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = '';
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = 'a';
  var got = _.strSplitFast( o );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'has empty element in result';
  var o = _.mapExtend( null, op );
  o.src = 'a b  c';
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', '', 'c' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var o = _.mapExtend( null, op );
  o.src = 'test test test';
  var got = _.strSplitFast( o );
  var expected = [ 'test', 'test', 'test' ];
  test.identical( got, expected );

  test.case = 'split string into an array of strings';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ';
  var got = _.strSplitFast( o );
  var expected = [ '', 'test', '', '', 'test', '', '', 'test', '' ];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = 'x';
  var got = _.strSplitFast( o );
  var expected = [ ' test   test   test ' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = '<delimteter>';
  var got = _.strSplitFast( o );
  var expected = [ ' test ', '  test', '   test ' ];
  test.identical( got, expected );

  test.case = 'simple string, default options';
  var o = _.mapExtend( null, op );
  o.src = 'a b c d';
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = ',';
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ ',', '.' ];
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'zero delimeter length';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [];
  var got = _.strSplitFast( o );
  var expected = [ 'a,b.c.d' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ ',' ];
  var got = _.strSplitFast( o );
  var expected = [ '    a', 'b', 'c', 'd   ' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ '.','#' ];
  var got = _.strSplitFast( o )
  var expected = [ '', 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ '.','#' ];
  var got = _.strSplitFast( o )
  var expected = [ 'content', '' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'Aa', '', '', '', '', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<' ];
  var expected = [ 'Aa ', ' ', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<' ];
  var expected = [ 'Aa ', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'a1', 'a2', 'a3', '', '', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ '.' ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /**/

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ ',', '.' ];
  var expected = [ 'a ', '', ' b ', '', ' c ', '', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = ',';
  var expected = [ 'a ', ' b ', ' c ', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = ',';
  var expected = [ '', '' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = ',';
  var expected = [ '', '', '', '' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /* */

  test.case = 'quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c"';
  o.delimeter = [ '"' ];
  var got = _.strSplitFast( o );
  var expected = [ '', 'a b', ' ', '', ' c', '' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', '" ""', '' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"' ];
  var got = _.strSplitFast( o );
  var expected = [ '', '', '', '', '', '', '', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c', '"', ' ' ];
  var got = _.strSplitFast( o );
  var expected = [ '', '', '', '', '', '', '', '' ];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ '', 'a b', ' ', '', ' c' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a', ' ', 'b', '"', ' ', '"', '"', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"', '' ];
  var got = _.strSplitFast( o );
  var expected = [ '', '', '', '', 'x', '', '', '', '', 'c' ];
  test.identical( got, expected );

  /*
    preservingEmpty : 0,
    preservingDelimeters : 0,
  */

  var op =
  {
    preservingEmpty : 0,
    preservingDelimeters : 0,
  }

  /* */

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = '';
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = '';
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = 'a';
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'has empty element in result';
  var o = _.mapExtend( null, op );
  o.src = 'a b  c';
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var o = _.mapExtend( null, op );
  o.src = 'test test test';
  var got = _.strSplitFast( o );
  var expected = [ 'test', 'test', 'test' ];
  test.identical( got, expected );

  test.case = 'split string into an array of strings';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ';
  var got = _.strSplitFast( o );
  var expected = [ 'test', 'test', 'test' ];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = 'x';
  var got = _.strSplitFast( o );
  var expected = [ ' test   test   test ' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = '<delimteter>';
  var got = _.strSplitFast( o );
  var expected = [ ' test ', '  test', '   test ' ];
  test.identical( got, expected );

  test.case = 'simple string, default options';
  var o = _.mapExtend( null, op );
  o.src = 'a b c d';
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = ',';
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ ',', '.' ];
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'zero delimeter length';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [];
  var got = _.strSplitFast( o );
  var expected = [ 'a,b.c.d' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ ',' ];
  var got = _.strSplitFast( o );
  var expected = [ '    a', 'b', 'c', 'd   ' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ '.','#' ];
  var got = _.strSplitFast( o )
  var expected = ['content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ '.','#' ];
  var got = _.strSplitFast( o )
  var expected = [ 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'Aa', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<', ];
  var expected = [ 'Aa ', ' ', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<' ];
  var expected = [ 'Aa ', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'a1', 'a2', 'a3', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ '.' ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /**/

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ ',', '.' ];
  var expected = [ 'a ', ' b ', ' c ', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = ',';
  var expected = [ 'a ', ' b ', ' c ', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = ',';
  var expected = [];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = ',';
  var expected = [];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /* */

  test.case = 'quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c"';
  o.delimeter = [ '"' ];
  var got = _.strSplitFast( o );
  var expected = [ 'a b', ' ', ' c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', '" ""' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"' ];
  var got = _.strSplitFast( o );
  var expected = [ 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c', '"', ' ' ];
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ '', 'a b', ' ', '', ' c' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a', ' ', 'b', '"', ' ', '"', '"', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"', '' ];
  var got = _.strSplitFast( o );
  var expected = [ 'x', 'c' ];
  test.identical( got, expected );

  /*
    preservingEmpty : 1,
    preservingDelimeters : 1,
  */

  var op =
  {
    preservingEmpty : 1,
    preservingDelimeters : 1,
  }

  /* */

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = '';
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = '';
  var got = _.strSplitFast( o );
  var expected = [ 'a', '', 'b', '', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = 'a';
  var got = _.strSplitFast( o );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'has empty element in result';
  var o = _.mapExtend( null, op );
  o.src = 'a b  c';
  var got = _.strSplitFast( o );
  var expected = [ 'a', ' ', 'b', ' ', '', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var o = _.mapExtend( null, op );
  o.src = 'test test test';
  var got = _.strSplitFast( o );
  var expected = [ 'test', ' ', 'test', ' ', 'test' ];
  test.identical( got, expected );

  test.case = 'split string into an array of strings';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ';
  var got = _.strSplitFast( o );
  var expected = [ '', ' ', 'test', ' ', '', ' ', '', ' ', 'test', ' ', '', ' ', '', ' ', 'test', ' ', '' ];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = 'x';
  var got = _.strSplitFast( o );
  var expected = [ ' test   test   test ' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = '<delimteter>';
  var got = _.strSplitFast( o );
  var expected = [ ' test ', '<delimteter>', '  test', '<delimteter>', '   test ' ];
  test.identical( got, expected );

  test.case = 'simple string, default options';
  var o = _.mapExtend( null, op );
  o.src = 'a b c d';
  var got = _.strSplitFast( o );
  var expected = [ 'a', ' ', 'b', ' ', 'c', ' ', 'd' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = ',';
  var got = _.strSplitFast( o );
  var expected = [ 'a', ',', 'b', ',', 'c', ',', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ ',', '.' ];
  var got = _.strSplitFast( o );
  var expected = [ 'a', ',', 'b', '.', 'c', '.', 'd' ];
  test.identical( got, expected );

  test.case = 'zero delimeter length';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [];
  var got = _.strSplitFast( o );
  var expected = [ 'a,b.c.d' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ ',' ];
  var got = _.strSplitFast( o );
  var expected = [ '    a', ',', 'b', ',', 'c', ',', 'd   ' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ '.','#' ];
  var got = _.strSplitFast( o )
  var expected = [ '', '.', 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ '.','#' ];
  var got = _.strSplitFast( o )
  var expected = [ 'content', '.', '' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'Aa', ' ', '', '<<!', '', ' ', '', '<<-', '', ' ', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<', ];
  var expected = [ 'Aa ', '<<!', ' ', '<<-', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<' ];
  var expected = [ 'Aa ', '<<<-', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'a1', ' ', 'a2', ' ', 'a3', ' ', '', '<<<-', '', ' ', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ '.' ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /**/

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ ',', '.' ];
  var expected = [ 'a ', '.', '', ',', ' b ', '.', '', ',', ' c ', '.', '', ',', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = ',';
  var expected = [ 'a ', ',' , ' b ', ',', ' c ', ',', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = ',';
  var expected = [ '', ',', '' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = ',';
  var expected = [ '', ',', '', ',', '', ',', '' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /* */

  test.case = 'quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c"';
  o.delimeter = [ '"' ];
  var got = _.strSplitFast( o );
  var expected = [ '', '"', 'a b', '"', ' ', '"', '', '"', ' c', '"', '' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '" ""', ' c', '' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"' ];
  var got = _.strSplitFast( o );
  var expected = [ '', '"', '', 'a b', '', '"', '', ' ', '', '"', '', '"', '', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c', '"', ' ' ];
  var got = _.strSplitFast( o );
  var expected = [ '', '"', '', 'a b', '', '"', '', ' ', '', '"', '', '"', '', ' c', '' ];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ '', 'a b', ' ', '', ' c' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', '', 'a', '', ' ', '', 'b', '', '"', '', ' ', '', '"', '', '"', '', ' ', '', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"', '' ];
  var got = _.strSplitFast( o );
  var expected = [ '', '"', '', 'a b', '', '"', '', ' ', 'x', '', '', ' ', '', '"', '', '"', '', ' ', 'c' ];
  test.identical( got, expected );

  /*
    preservingEmpty : 0,
    preservingDelimeters : 1,
  */

  var op =
  {
    preservingEmpty : 0,
    preservingDelimeters : 1,
  }

  /* */

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = '';
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = '';
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = 'a';
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'has empty element in result';
  var o = _.mapExtend( null, op );
  o.src = 'a b  c';
  var got = _.strSplitFast( o );
  var expected = [ 'a', ' ', 'b', ' ', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var o = _.mapExtend( null, op );
  o.src = 'test test test';
  var got = _.strSplitFast( o );
  var expected = [ 'test', ' ', 'test', ' ', 'test' ];
  test.identical( got, expected );

  test.case = 'split string into an array of strings';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ';
  var got = _.strSplitFast( o );
  var expected = [ ' ', 'test', ' ', ' ', ' ', 'test', ' ', ' ', ' ', 'test', ' ' ];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = 'x';
  var got = _.strSplitFast( o );
  var expected = [ ' test   test   test ' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = '<delimteter>';
  var got = _.strSplitFast( o );
  var expected = [ ' test ', '<delimteter>', '  test', '<delimteter>', '   test ' ];
  test.identical( got, expected );

  test.case = 'simple string, default options';
  var o = _.mapExtend( null, op );
  o.src = 'a b c d';
  var got = _.strSplitFast( o );
  var expected = [ 'a', ' ', 'b', ' ', 'c', ' ', 'd' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = ',';
  var got = _.strSplitFast( o );
  var expected = [ 'a', ',', 'b', ',', 'c', ',', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ ',', '.' ];
  var got = _.strSplitFast( o );
  var expected = [ 'a', ',', 'b', '.', 'c', '.', 'd' ];
  test.identical( got, expected );

  test.case = 'zero delimeter length';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [];
  var got = _.strSplitFast( o );
  var expected = [ 'a,b.c.d' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ ',' ];
  var got = _.strSplitFast( o );
  var expected = [ '    a', ',', 'b', ',', 'c', ',', 'd   ' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ '.','#' ];
  var got = _.strSplitFast( o )
  var expected = [ '.', 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ '.','#' ];
  var got = _.strSplitFast( o )
  var expected = [ 'content', '.' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'Aa', ' ', '<<!', ' ', '<<-', ' ', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<', ];
  var expected = [ 'Aa ', '<<!', ' ', '<<-', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<' ];
  var expected = [ 'Aa ', '<<<-', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'a1', ' ', 'a2', ' ', 'a3', ' ', '<<<-', ' ', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ '.' ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /**/

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ ',', '.' ];
  var expected = [ 'a ', '.', ',', ' b ', '.', ',', ' c ', '.', ',', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = ',';
  var expected = [ 'a ', ',' , ' b ', ',', ' c ', ',', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = ',';
  var expected = [ ',' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = ',';
  var expected = [ ',', ',', ',' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /* */

  test.case = 'quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c"';
  o.delimeter = [ '"' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '"', ' ', '"', '"', ' c', '"' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '" ""', ' c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '"', ' ', '"', '"', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c', '"', ' ' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '"', ' ', '"', '"', ' c' ];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ '', 'a b', ' ', '', ' c' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a', ' ', 'b', '"', ' ', '"', '"', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"', '' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '"', ' ', 'x', ' ', '"', '"', ' ', 'c' ];
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function( )
  {
    _.strSplitFast( );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowErrorSync( function( )
  {
    _.strSplitFast( [  ] );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowErrorSync( function( )
  {
    _.strSplitFast( 13 );
  } );

  test.case = 'invalid arguments count';
  test.shouldThrowErrorSync( function()
  {
    _.strSplitFast( '1', '2', '3' );
  });

  test.case = 'invalid argument type';
  test.shouldThrowErrorSync( function()
  {
    _.strSplitFast( 123 );
  });

  test.case = 'invalid option type';
  test.shouldThrowErrorSync( function()
  {
    _.strSplitFast( { src : 3 } );
  });

  test.case = 'invalid option defined';
  test.shouldThrowErrorSync( function()
  {
    _.strSplitFast( { src : 'word', delimeter : 0, left : 1 } );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.strSplitFast();
  });

}

//

function strSplitFastRegexp( test )
{

  test.case = 'trivial';

  var got = _.strSplitFast( 'a b c', new RegExp( ' ' ) );
  var expected = [ 'a', ' ', 'b', ' ', 'c' ];
  test.identical( got, expected );

  var got = _.strSplitFast( 'abc', new RegExp( '' ) );
  var expected = [ 'a', '', 'b', '', 'c' ];
  test.identical( got, expected );

  var got = _.strSplitFast( '', new RegExp( '' ) );
  var expected = [];
  test.identical( got, expected );

  var got = _.strSplitFast( '', 'a' );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var got = _.strSplitFast( ' test <delimteter>  test<delimteter>   test ', /<delimteter>/ );
  var expected = [ ' test ', '<delimteter>', '  test', '<delimteter>', '   test ' ];
  test.identical( got, expected );

  /*
    preservingEmpty : 1,
    preservingDelimeters : 0,
  */

  var op =
  {
    preservingEmpty : 1,
    preservingDelimeters : 0,
  }

  /* */

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = new RegExp( '' );
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = new RegExp( '' );
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = /a/;
  var got = _.strSplitFast( o );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = /x/;
  var got = _.strSplitFast( o );
  var expected = [ ' test   test   test ' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = /<delimteter>/;
  var got = _.strSplitFast( o );
  var expected = [ ' test ', '  test', '   test ' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = /,/;
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ /,/, /\./ ];
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ /,/ ];
  var got = _.strSplitFast( o );
  var expected = [ '    a', 'b', 'c', 'd   ' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ /\./, /#/ ];
  var got = _.strSplitFast( o )
  var expected = [ '', 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ /\./, /#/ ];
  var got = _.strSplitFast( o )
  var expected = [ 'content', '' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</,/ / ];
  var expected = [ 'Aa', '', '', '', '', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</ ];
  var expected = [ 'Aa ', ' ', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</ ];
  var expected = [ 'Aa ', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</,/ / ];
  var expected = [ 'a1', 'a2', 'a3', '', '', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ /\./ ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /**/

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ /,/, /\./ ];
  var expected = [ 'a ', '', ' b ', '', ' c ', '', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = /,/;
  var expected = [ 'a ', ' b ', ' c ', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = /,/;
  var expected = [ '', '' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = /,/;
  var expected = [ '', '', '', '' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /* */

  test.case = 'quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c"';
  o.delimeter = [ /"/ ];
  var got = _.strSplitFast( o );
  var expected = [ '', 'a b', ' ', '', ' c', '' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / c/ ];
  var got = _.strSplitFast( o );
  var expected = [ '"', '" ""', '' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / /, / c/, /"/ ];
  var got = _.strSplitFast( o );
  var expected = [ '', '', '', '', '', '', '', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / c/, /"/, / / ];
  var got = _.strSplitFast( o );
  var expected = [ '', '', '', '', '', '', '', '' ];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ new RegExp(), /a b/, / /, '', ' c' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a', ' ', 'b', '"', ' ', '"', '"', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ /a b/, / /, ' c', '"', '' ];
  var got = _.strSplitFast( o );
  var expected = [ '', '', '', '', 'x', '', '', '', '', 'c' ];
  test.identical( got, expected );

  /*
    preservingEmpty : 0,
    preservingDelimeters : 0,
  */

  var op =
  {
    preservingEmpty : 0,
    preservingDelimeters : 0,
  }

  /* */

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = new RegExp( '' );
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = new RegExp( '' );
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = /a/;
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = /x/;
  var got = _.strSplitFast( o );
  var expected = [ ' test   test   test ' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = /<delimteter>/;
  var got = _.strSplitFast( o );
  var expected = [ ' test ', '  test', '   test ' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = /,/;
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ /,/, /\./ ];
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ /,/ ];
  var got = _.strSplitFast( o );
  var expected = [ '    a', 'b', 'c', 'd   ' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ '.',/#/ ];
  var got = _.strSplitFast( o )
  var expected = ['content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ '.',/#/ ];
  var got = _.strSplitFast( o )
  var expected = [ 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</,/ / ];
  var expected = [ 'Aa', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</ ];
  var expected = [ 'Aa ', ' ', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</ ];
  var expected = [ 'Aa ', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</,/ / ];
  var expected = [ 'a1', 'a2', 'a3', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ /\./ ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /**/

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ /,/, /\./ ];
  var expected = [ 'a ', ' b ', ' c ', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = /,/;
  var expected = [ 'a ', ' b ', ' c ', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = /,/;
  var expected = [];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = /,/;
  var expected = [];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /* */

  test.case = 'quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c"';
  o.delimeter = [ /"/ ];
  var got = _.strSplitFast( o );
  var expected = [ 'a b', ' ', ' c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / c/ ];
  var got = _.strSplitFast( o );
  var expected = [ '"', '" ""' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / /, / c/, /"/ ];
  var got = _.strSplitFast( o );
  var expected = [ 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / c/, /"/, / / ];
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ '', /a b/, / /, new RegExp( '' ), / c/ ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a', ' ', 'b', '"', ' ', '"', '"', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ /a b/, / /, / c/, /"/, '' ];
  var got = _.strSplitFast( o );
  var expected = [ 'x', 'c' ];
  test.identical( got, expected );

  /*
    preservingEmpty : 1,
    preservingDelimeters : 1,
  */

  var op =
  {
    preservingEmpty : 1,
    preservingDelimeters : 1,
  }

  /* */

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = new RegExp( '' );
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = new RegExp( '' );
  var got = _.strSplitFast( o );
  var expected = [ 'a', '', 'b', '', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = /a/;
  var got = _.strSplitFast( o );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = /x/;
  var got = _.strSplitFast( o );
  var expected = [ ' test   test   test ' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = /<delimteter>/;
  var got = _.strSplitFast( o );
  var expected = [ ' test ', '<delimteter>', '  test', '<delimteter>', '   test ' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = /,/;
  var got = _.strSplitFast( o );
  var expected = [ 'a', ',', 'b', ',', 'c', ',', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ /,/, /\./ ];
  var got = _.strSplitFast( o );
  var expected = [ 'a', ',', 'b', '.', 'c', '.', 'd' ];
  test.identical( got, expected );

  test.case = 'zero delimeter length';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [];
  var got = _.strSplitFast( o );
  var expected = [ 'a,b.c.d' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ /,/ ];
  var got = _.strSplitFast( o );
  var expected = [ '    a', ',', 'b', ',', 'c', ',', 'd   ' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ '.',/#/ ];
  var got = _.strSplitFast( o )
  var expected = [ '', '.', 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ '.',/#/ ];
  var got = _.strSplitFast( o )
  var expected = [ 'content', '.', '' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</,/ / ];
  var expected = [ 'Aa', ' ', '', '<<!', '', ' ', '', '<<-', '', ' ', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</ ];
  var expected = [ 'Aa ', '<<!', ' ', '<<-', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</ ];
  var expected = [ 'Aa ', '<<<-', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</,/ / ];
  var expected = [ 'a1', ' ', 'a2', ' ', 'a3', ' ', '', '<<<-', '', ' ', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ /\./ ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /**/

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ /,/, /\./ ];
  var expected = [ 'a ', '.', '', ',', ' b ', '.', '', ',', ' c ', '.', '', ',', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = /,/;
  var expected = [ 'a ', ',' , ' b ', ',', ' c ', ',', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = /,/;
  var expected = [ '', ',', '' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = /,/;
  var expected = [ '', ',', '', ',', '', ',', '' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /* */

  test.case = 'quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c"';
  o.delimeter = [ /"/ ];
  var got = _.strSplitFast( o );
  var expected = [ '', '"', 'a b', '"', ' ', '"', '', '"', ' c', '"', '' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / c/ ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '" ""', ' c', '' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / /, / c/, /"/ ];
  var got = _.strSplitFast( o );
  var expected = [ '', '"', '', 'a b', '', '"', '', ' ', '', '"', '', '"', '', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / c/, /"/, / / ];
  var got = _.strSplitFast( o );
  var expected = [ '', '"', '', 'a b', '', '"', '', ' ', '', '"', '', '"', '', ' c', '' ];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ '', /a b/, / /, new RegExp( '' ), / c/ ];
  var got = _.strSplitFast( o );
  var expected = [ '"', '', 'a', '', ' ', '', 'b', '', '"', '', ' ', '', '"', '', '"', '', ' ', '', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ /a b/, / /, / c/, /"/, '' ];
  var got = _.strSplitFast( o );
  var expected = [ '', '"', '', 'a b', '', '"', '', ' ', 'x', '', '', ' ', '', '"', '', '"', '', ' ', 'c' ];
  test.identical( got, expected );

  /*
    preservingEmpty : 0,
    preservingDelimeters : 1,
  */

  var op =
  {
    preservingEmpty : 0,
    preservingDelimeters : 1,
  }

  /* */

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = new RegExp( '' );
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = new RegExp( '' );
  var got = _.strSplitFast( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = /a/;
  var got = _.strSplitFast( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'has empty element in result';
  var o = _.mapExtend( null, op );
  o.src = 'a b  c';
  var got = _.strSplitFast( o );
  var expected = [ 'a', ' ', 'b', ' ', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var o = _.mapExtend( null, op );
  o.src = 'test test test';
  var got = _.strSplitFast( o );
  var expected = [ 'test', ' ', 'test', ' ', 'test' ];
  test.identical( got, expected );

  test.case = 'split string into an array of strings';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ';
  var got = _.strSplitFast( o );
  var expected = [ ' ', 'test', ' ', ' ', ' ', 'test', ' ', ' ', ' ', 'test', ' ' ];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = /x/;
  var got = _.strSplitFast( o );
  var expected = [ ' test   test   test ' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = /<delimteter>/;
  var got = _.strSplitFast( o );
  var expected = [ ' test ', '<delimteter>', '  test', '<delimteter>', '   test ' ];
  test.identical( got, expected );

  test.case = 'simple string, default options';
  var o = _.mapExtend( null, op );
  o.src = 'a b c d';
  var got = _.strSplitFast( o );
  var expected = [ 'a', ' ', 'b', ' ', 'c', ' ', 'd' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = /,/;
  var got = _.strSplitFast( o );
  var expected = [ 'a', ',', 'b', ',', 'c', ',', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ /,/, /\./ ];
  var got = _.strSplitFast( o );
  var expected = [ 'a', ',', 'b', '.', 'c', '.', 'd' ];
  test.identical( got, expected );

  test.case = 'zero delimeter length';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [];
  var got = _.strSplitFast( o );
  var expected = [ 'a,b.c.d' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ /,/ ];
  var got = _.strSplitFast( o );
  var expected = [ '    a', ',', 'b', ',', 'c', ',', 'd   ' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ '.',/#/ ];
  var got = _.strSplitFast( o )
  var expected = [ '.', 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ '.',/#/ ];
  var got = _.strSplitFast( o )
  var expected = [ 'content', '.' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</,/ / ];
  var expected = [ 'Aa', ' ', '<<!', ' ', '<<-', ' ', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</ ];
  var expected = [ 'Aa ', '<<!', ' ', '<<-', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</ ];
  var expected = [ 'Aa ', '<<<-', ' Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ /->>>/,/<<<-/,/->>/,/<<-/,/!>>/,/<<!/,/>>/,/<</,/ / ];
  var expected = [ 'a1', ' ', 'a2', ' ', 'a3', ' ', '<<<-', ' ', 'Bb' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ /\./ ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /**/

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ /,/, /\./ ];
  var expected = [ 'a ', '.', ',', ' b ', '.', ',', ' c ', '.', ',', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = /,/;
  var expected = [ 'a ', ',' , ' b ', ',', ' c ', ',', ' d' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = /,/;
  var expected = [ ',' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = /,/;
  var expected = [ ',', ',', ',' ];
  var got = _.strSplitFast( o );
  test.identical( got, expected );

  /* */

  test.case = 'quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c"';
  o.delimeter = [ /"/ ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '"', ' ', '"', '"', ' c', '"' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / c/ ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '" ""', ' c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / /, / c/, /"/ ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '"', ' ', '"', '"', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ /a b/, / c/, /"/, / / ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '"', ' ', '"', '"', ' c' ];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ '', /a b/, / /, new RegExp( '' ), / c/ ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a', ' ', 'b', '"', ' ', '"', '"', ' ', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ /a b/, / /, / c/, /"/, '' ];
  var got = _.strSplitFast( o );
  var expected = [ '"', 'a b', '"', ' ', 'x', ' ', '"', '"', ' ', 'c' ];
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowErrorSync( function()
  {
    _.strSplitFast( /1/, /2/, '3' );
  });

}

//

function strSplit( test )
{

  /* - */

  test.open( 'empty' );

  debugger;
  var got = _.strSplit( '', '' );
  var expected = [];
  test.identical( got, expected );

  var got = _.strSplit( 'abc', '' );
  var expected = [ 'a', '', 'b', '', 'c' ];
  test.identical( got, expected );

  var got = _.strSplit
  ({
    src : 'abc',
    delimeter : '',
    preservingEmpty : 1,
    preservingDelimeters : 1,
    stripping : 0,
    quoting : 0,
  });
  var expected = [ 'a', '', 'b', '', 'c' ];
  test.identical( got, expected );

  var got = _.strSplit
  ({
    src : 'abc',
    delimeter : '',
    preservingEmpty : 1,
    preservingDelimeters : 0,
    stripping : 0,
    quoting : 0,
  });
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  var got = _.strSplit
  ({
    src : 'abc',
    delimeter : '',
    preservingEmpty : 0,
    preservingDelimeters : 0,
    stripping : 0,
    quoting : 0,
  });
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  var got = _.strSplit
  ({
    src : 'abc',
    delimeter : '',
    preservingEmpty : 0,
    preservingDelimeters : 0,
    stripping : 0,
    quoting : 1,
  });
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  var got = _.strSplit
  ({
    src : 'abc',
    delimeter : '',
    preservingEmpty : 0,
    preservingDelimeters : 0,
    stripping : 1,
    quoting : 0,
  });
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  var got = _.strSplit
  ({
    src : 'abc',
    delimeter : '',
    preservingEmpty : 0,
    preservingDelimeters : 0,
    stripping : 1,
    quoting : 1,
  });
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  var got = _.strSplit( '', 'a' );
  var expected = [ '' ];
  test.identical( got, expected );

  test.close( 'empty' );

  /* - */

  test.open( 'trivial' );

  var got = _.strSplit( 'test test test' );
  var expected = [ 'test', '', 'test', '', 'test' ];
  test.identical( got, expected );

  var got = _.strSplit( ' test   test   test ' );
  var expected = [ '', '', 'test', '', '', '', '', '', 'test', '', '', '', '', '', 'test', '', '' ];
  test.identical( got, expected );

  var got = _.strSplit( ' test   test   test ', 'something' );
  var expected = [ 'test   test   test' ];
  test.identical( got, expected );

  var got = _.strSplit( ' test <delimteter>  test<delimteter>   test ', '<delimteter>' );
  var expected = [ 'test', '<delimteter>', 'test', '<delimteter>', 'test' ];
  test.identical( got, expected );

  var got = _.strSplit( 'a b c d' );
  var expected = [ 'a', '', 'b', '', 'c', '', 'd' ];
  test.identical( got, expected );

  test.close( 'trivial' );

  /* - */

  test.open( 'trivial, pe:0' );

  var got = _.strSplit({ src : 'test test test', preservingEmpty : 0 });
  var expected = [ 'test', 'test', 'test' ];
  test.identical( got, expected );

  var got = _.strSplit({ src : ' test   test   test ', preservingEmpty : 0 });
  var expected = [ 'test', 'test', 'test' ];
  test.identical( got, expected );

  var got = _.strSplit({ src : ' test   test   test ', delimeter : 'something', preservingEmpty : 0 });
  var expected = [ 'test   test   test' ];
  test.identical( got, expected );

  var got = _.strSplit({ src : ' test <delimteter>  test<delimteter>   test ', delimeter : '<delimteter>', preservingEmpty : 0 });
  var expected = [ 'test', '<delimteter>', 'test', '<delimteter>', 'test' ];
  test.identical( got, expected );

  var got = _.strSplit({ src : 'a b c d', preservingEmpty : 0 });
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.close( 'trivial, pe:0' );

  /* - */

  test.open( 'd:" " trivial' );

  test.case = ' space at the beginning'; /**/
  var got = _.strSplit( ' aa b#b cc', ' ' );
  var expected = [ '', '', 'aa', '', 'b#b', '', 'cc' ];
  test.identical( got, expected );

  test.case = 'space in the end';  /**/
  var got = _.strSplit( 'aa b#b cc ', ' ' );
  var expected = [ 'aa', '', 'b#b', '', 'cc', '', '' ];
  test.identical( got, expected );

  test.case = 'space on the beginning and the end';  /**/
  var got = _.strSplit( ' aa b#b cc ', ' ' );
  var expected = [ '', '', 'aa', '', 'b#b', '', 'cc', '', '' ];
  test.identical( got, expected );

  test.close( 'd:" " trivial' );

  /* - */

  test.open( 'd:"#" trivial' );

  test.case = ' space at the beginning'; /**/
  var got = _.strSplit( ' aa b#b cc', '#' );
  var expected = [ 'aa b', '#', 'b cc' ];
  test.identical( got, expected );

  test.case = 'space in the end';  /**/
  var got = _.strSplit( 'aa b#b cc ', '#' );
  var expected = [ 'aa b', '#', 'b cc' ];
  test.identical( got, expected );

  test.case = 'space on the beginning and the end';  /**/
  var got = _.strSplit( ' aa b#b cc ', '#' );
  var expected = [ 'aa b', '#', 'b cc' ];
  test.identical( got, expected );

  test.close( 'd:"#" trivial' );

  /* - */

  test.open( 's:1 q:0 pe:0' );

  var op =
  {
    stripping : 1,
    quoting : 0,
    preservingEmpty : 0,
  }

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = '';
  var got = _.strSplit( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = '';
  var got = _.strSplit( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = 'a';
  var got = _.strSplit( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'has empty element in result';
  var o = _.mapExtend( null, op );
  o.src = 'a b  c';
  var got = _.strSplit( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var o = _.mapExtend( null, op );
  o.src = 'test test test';
  var got = _.strSplit( o );
  var expected = [ 'test', 'test', 'test' ];
  test.identical( got, expected );

  test.case = 'split string into an array of strings';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ';
  var got = _.strSplit( o );
  var expected = [ 'test', 'test', 'test' ];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = 'x';
  var got = _.strSplit( o );
  var expected = [ 'test   test   test' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = '<delimteter>';
  var got = _.strSplit( o );
  var expected = [ 'test', '<delimteter>', 'test', '<delimteter>', 'test' ];
  test.identical( got, expected );

  test.case = 'simple string, default options';
  var o = _.mapExtend( null, op );
  o.src = 'a b c d';
  var got = _.strSplit( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = ',';
  var got = _.strSplit( o );
  var expected = [ 'a', ',', 'b', ',', 'c', ',', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ ',', '.' ];
  var got = _.strSplit( o );
  var expected = [ 'a', ',', 'b', '.', 'c', '.', 'd' ];
  test.identical( got, expected );

  test.case = 'zero delimeter length';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [];
  var got = _.strSplit( o );
  var expected = [ 'a,b.c.d' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ ',' ];
  var got = _.strSplit( o );
  var expected = [ 'a', ',', 'b', ',', 'c', ',', 'd' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ '.','#' ];
  var got = _.strSplit( o )
  var expected = [ '.', 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ '.','#' ];
  var got = _.strSplit( o )
  var expected = [ 'content', '.' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'Aa', '<<!', '<<-', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<', ];
  var expected = [ 'Aa', '<<!', '<<-', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<' ];
  var expected = [ 'Aa', '<<<-', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'a1', 'a2', 'a3', '<<<-', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ '.' ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  /* */

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ ',', '.' ];
  var expected = [ 'a', '.', ',', 'b', '.', ',', 'c', '.', ',', 'd' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = ',';
  var expected = [ 'a', ',' , 'b', ',', 'c', ',', 'd' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = ',';
  var expected = [ ',' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = ',';
  var expected = [ ',', ',', ',' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  /* */

  test.case = 'quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c"';
  o.delimeter = [ '"' ];
  var got = _.strSplit( o );
  var expected = [ '"', 'a b', '"', '"','"', 'c', '"' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c' ];
  var got = _.strSplit( o );
  var expected = [ '"', 'a b', '" ""', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"' ];
  var got = _.strSplit( o );
  var expected = [ '"', 'a b', '"', '"', '"', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c', '"', ' ' ];
  var got = _.strSplit( o );
  var expected = [ '"', 'a b', '"', '"', '"', 'c' ];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ '', 'a b', ' ', '', ' c' ];
  var got = _.strSplit( o );
  var expected = [ '"', 'a', 'b', '"', '"', '"', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"', '' ];
  var got = _.strSplit( o );
  var expected = [ '"', 'a b', '"', 'x', '"', '"', 'c' ];
  test.identical( got, expected );

  test.close( 's:1 q:0 pe:0' );

  /* - */

  test.open( 's:1 q:0 pe:1' );

  var op =
  {
    stripping : 1,
    quoting : 0,
    preservingEmpty : 1,
  }

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = '';
  var got = _.strSplit( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = '';
  var got = _.strSplit( o );
  var expected = [ 'a', '', 'b', '', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = 'a';
  var got = _.strSplit( o );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'has empty element in result';
  var o = _.mapExtend( null, op );
  o.src = 'a b  c';
  var got = _.strSplit( o );
  var expected = [ 'a', '', 'b', '', '', '', 'c' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var o = _.mapExtend( null, op );
  o.src = 'test test test';
  var got = _.strSplit( o );
  var expected = [ 'test', '', 'test', '', 'test' ];
  test.identical( got, expected );

  test.case = 'split string into an array of strings';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ';
  var got = _.strSplit( o );
  var expected = [ '', '', 'test', '', '', '', '', '', 'test', '', '', '', '', '', 'test', '', '' ];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = 'x';
  var got = _.strSplit( o );
  var expected = [ 'test   test   test' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = '<delimteter>';
  var got = _.strSplit( o );
  var expected = [ 'test', '<delimteter>', 'test', '<delimteter>', 'test' ];
  test.identical( got, expected );

  test.case = 'simple string, default options';
  var o = _.mapExtend( null, op );
  o.src = 'a b c d';
  var got = _.strSplit( o );
  var expected = [ 'a', '', 'b', '', 'c', '', 'd' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = ',';
  var got = _.strSplit( o );
  var expected = [ 'a', ',', 'b', ',', 'c', ',', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ ',', '.' ];
  var got = _.strSplit( o );
  var expected = [ 'a', ',', 'b', '.', 'c', '.', 'd' ];
  test.identical( got, expected );

  test.case = 'zero delimeter length';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [];
  var got = _.strSplit( o );
  var expected = [ 'a,b.c.d' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ ',' ];
  var got = _.strSplit( o );
  var expected = [ 'a', ',', 'b', ',', 'c', ',', 'd' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ '.','#' ];
  var got = _.strSplit( o )
  var expected = [ '', '.', 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ '.','#' ];
  var got = _.strSplit( o )
  var expected = [ 'content', '.', '' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'Aa', '', '', '<<!', '', '', '', '<<-', '', '', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<', ];
  var expected = [ 'Aa', '<<!', '', '<<-', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<' ];
  var expected = [ 'Aa', '<<<-', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'a1', '', 'a2', '', 'a3', '', '', '<<<-', '', '', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ '.' ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  /* */

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ ',', '.' ];
  var expected = [ 'a', '.', '', ',', 'b', '.', '', ',', 'c', '.', '', ',', 'd' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = ',';
  var expected = [ 'a', ',' , 'b', ',', 'c', ',', 'd' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = ',';
  var expected = [ '', ',', '' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = ',';
  var expected = [ '', ',', '', ',', '', ',', '' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  /* */

  test.case = 'quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c"';
  o.delimeter = [ '"' ];
  var got = _.strSplit( o );
  var expected = [ '', '"', 'a b', '"', '', '"', '', '"', 'c', '"', '' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c' ];
  var got = _.strSplit( o );
  var expected = [ '"', 'a b', '" ""', 'c', '' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"' ];
  var got = _.strSplit( o );
  var expected = [ '', '"', '', 'a b', '', '"', '', '', '', '"', '', '"', '', '', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c', '"', ' ' ];
  var got = _.strSplit( o );
  var expected = [ '', '"', '', 'a b', '', '"', '', '', '', '"', '', '"', '', 'c', '' ];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ '', 'a b', ' ', '', ' c' ];
  var got = _.strSplit( o );
  var expected = [ '"', '', 'a', '', '', '', 'b', '', '"', '', '', '', '"', '', '"', '', '', '', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ '', '"', '', 'a b', '', '"', '', '', 'x', '', '', '', '', '"', '', '"', '', '', 'c' ];
  var got = _.strSplit( o );
  var expected = [ '"', '', 'a', '', '', '', 'b', '', '"', '', '', '', 'x', '', '', '', '"', '', '"', '', '', '', 'c' ];
  test.identical( got, expected );

  test.close( 's:1 q:0 pe:1' );

  /* - */

  test.open( 's:1 q:1 pe:0' );

  var op =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 0,
  }

  test.case = 'empty both';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = '';
  var got = _.strSplit( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty delimeter';
  var o = _.mapExtend( null, op );
  o.src = 'abc';
  o.delimeter = '';
  var got = _.strSplit( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'empty src';
  var o = _.mapExtend( null, op );
  o.src = '';
  o.delimeter = 'a';
  var got = _.strSplit( o );
  var expected = [];
  test.identical( got, expected );

  test.case = 'has empty element in result';
  var o = _.mapExtend( null, op );
  o.src = 'a b  c';
  var got = _.strSplit( o );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'returns an array of strings';
  var o = _.mapExtend( null, op );
  o.src = 'test test test';
  var got = _.strSplit( o );
  var expected = [ 'test', 'test', 'test' ];
  test.identical( got, expected );

  test.case = 'split string into an array of strings';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ';
  var got = _.strSplit( o );
  var expected = [ 'test', 'test', 'test' ];
  test.identical( got, expected );

  test.case = 'split with delimeter which src does not have';
  var o = _.mapExtend( null, op );
  o.src = ' test   test   test ', 'something';
  o.delimeter = 'x';
  var got = _.strSplit( o );
  var expected = [ 'test   test   test' ];
  test.identical( got, expected );

  test.case = 'custom delimeter';
  var o = _.mapExtend( null, op );
  o.src = ' test <delimteter>  test<delimteter>   test ', '<delimteter>';
  o.delimeter = '<delimteter>';
  var got = _.strSplit( o );
  var expected = [ 'test', '<delimteter>', 'test', '<delimteter>', 'test' ];
  test.identical( got, expected );

  test.case = 'simple string, default options';
  var o = _.mapExtend( null, op );
  o.src = 'a b c d';
  var got = _.strSplit( o );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got, expected );

  test.case = 'arguments as map';
  var o = _.mapExtend( null, op );
  o.src = 'a,b,c,d';
  o.delimeter = ',';
  var got = _.strSplit( o );
  var expected = [ 'a', ',', 'b', ',', 'c', ',', 'd' ];
  test.identical( got, expected );

  test.case = 'delimeter as array';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [ ',', '.' ];
  var got = _.strSplit( o );
  var expected = [ 'a', ',', 'b', '.', 'c', '.', 'd' ];
  test.identical( got, expected );

  test.case = 'zero delimeter length';
  var o = _.mapExtend( null, op );
  o.src = 'a,b.c.d';
  o.delimeter = [];
  var got = _.strSplit( o );
  var expected = [ 'a,b.c.d' ];
  test.identical( got, expected );

  test.case = 'stripping off';
  var o = _.mapExtend( null, op );
  o.src = '    a,b,c,d   ';
  o.delimeter = [ ',' ];
  var got = _.strSplit( o );
  var expected = [ 'a', ',', 'b', ',', 'c', ',', 'd' ];
  test.identical( got, expected );

  /* */

  test.case = 'many delimeters, delimeter on the begin';
  var o = _.mapExtend( null, op );
  o.src = '.content';
  o.delimeter = [ '.','#' ];
  var got = _.strSplit( o )
  var expected = [ '.', 'content' ];
  test.identical( got, expected );

  test.case = 'many delimeters, delimeter on the end';
  var o = _.mapExtend( null, op );
  o.src = 'content.';
  o.delimeter = [ '.','#' ];
  var got = _.strSplit( o )
  var expected = [ 'content', '.' ];
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'Aa', '<<!', '<<-', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'many delimeters having common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<! <<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<' ];
  var expected = [ 'Aa', '<<!', '<<-', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'having long common';
  var o = _.mapExtend( null, op );
  o.src = 'Aa <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<' ];
  var expected = [ 'Aa', '<<<-', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'having long common 2';
  var o = _.mapExtend( null, op );
  o.src = 'a1 a2 a3 <<<- Bb';
  o.delimeter = [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ];
  var expected = [ 'a1', 'a2', 'a3', '<<<-', 'Bb' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'delimeter not exist in src';

  var o = _.mapExtend( null, op );
  o.src = 'a,b,c';
  o.delimeter = [ '.' ];
  var expected = [ 'a,b,c' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  /**/

  test.case = 'several delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a ., b ., c ., d';
  o.delimeter = [ ',', '.' ];
  var expected = [ 'a', '.', ',', 'b', '.', ',', 'c', '.', ',', 'd' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'one delimeters';
  var o = _.mapExtend( null, op );
  o.src = 'a , b , c , d';
  o.delimeter = ',';
  var expected = [ 'a', ',' , 'b', ',', 'c', ',', 'd' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'delimeters equal src';
  var o = _.mapExtend( null, op );
  o.src = ',';
  o.delimeter = ',';
  var expected = [ ',' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'src is triplet of delimeter';
  var o = _.mapExtend( null, op );
  o.src = ',,,';
  o.delimeter = ',';
  var expected = [ ',', ',', ',' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  /* */

  test.case = 'complex quoted at edges';
  var o = _.mapExtend( null, op );
  o.src = '"a b" " c"';
  o.delimeter = [ '"' ];
  var got = _.strSplit( o );
  var expected = [ '"a b" " c"' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c' ];
  var got = _.strSplit( o );
  var expected = [ '"a b" ""', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space first';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"' ];
  var got = _.strSplit( o );
  var expected = [ '"a b"', '""', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle with space last';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ 'a b', ' c', '"', ' ' ];
  var got = _.strSplit( o );
  var expected = [ '"a b"', '""', 'c' ];
  test.identical( got, expected );

  test.case = 'delimeter with empty string at the beginning of array';
  var o = _.mapExtend( null, op );
  o.src = '"a b" "" c';
  o.delimeter = [ '', 'a b', ' ', '', ' c' ];
  var got = _.strSplit( o );
  var expected = [ '"a b"', '""', 'c' ];
  test.identical( got, expected );

  test.case = 'quoted in the middle';
  var o = _.mapExtend( null, op );
  o.src = '"a b" x "" c';
  o.delimeter = [ 'a b', ' ', ' c', '"', '' ];
  var got = _.strSplit( o );
  var expected = [ '"a b"', 'x', '""', 'c' ];
  test.identical( got, expected );

  /* special quoting tests */

  test.case = 'quoted at edges, delimeter : #';
  var o = _.mapExtend( null, op );
  o.src = '"aa"bb"cc"';
  o.delimeter = [ '#' ];
  var got = _.strSplit( o );
  var expected = [ '"aa"bb"cc"' ];
  test.identical( got, expected );

  test.close( 's:1 q:1 pe:0' );

  /* - */

  test.open( 's:1 q:1 pe:0 pq:1 iq:0 delimeter:#' );

  var op =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 0,
    preservingQuoting : 1,
    inliningQuoting : 0,
    delimeter : '#',
  }

  test.case = 'quoted at edges"';
  var o = _.mapExtend( null, op );
  o.src = '"aa"bb"cc"';
  var got = _.strSplit( o );
  var expected = [ '"aa"', 'bb', '"cc"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with extra quote inside "';
  var o = _.mapExtend( null, op );
  o.src = '"aa"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ '"aa"', 'bb', '""', 'cc"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with # inside the first quoted text"';
  var o = _.mapExtend( null, op );
  o.src = '"a#a"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ '"a#a"', 'bb', '""', 'cc"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with # inside not quoted text"';
  var o = _.mapExtend( null, op );
  o.src = '"aa"b#b""cc"';
  var got = _.strSplit( o );
  var expected = [ '"aa"', 'b', '#', 'b', '""', 'cc"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with # inside the last quoted text"';
  var o = _.mapExtend( null, op );
  o.src = '"aa"bb""c#c"';
  var got = _.strSplit( o );
  var expected = [ '"aa"', 'bb', '""', 'c', '#', 'c"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with # inside all 3 text splits"';
  var o = _.mapExtend( null, op );
  o.src = '"a#a"b#b""c#c"';
  var got = _.strSplit( o );
  var expected = [ '"a#a"', 'b', '#', 'b', '""', 'c', '#', 'c"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with extra spaces on edges';
  var o = _.mapExtend( null, op );
  o.src = ' "aa"bb"cc" ';
  var got = _.strSplit( o );
  var expected = [ '"aa"', 'bb', '"cc"' ];
  test.identical( got, expected );

  test.close( 's:1 q:1 pe:0 pq:1 iq:0 delimeter:#' );

  /* - */

  test.open( 's:1 q:1 pe:0 pq:0 iq:1 delimeter:#' );

  var op =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 0,
    preservingQuoting : 0,
    inliningQuoting : 1,
    delimeter : '#',
  }

  test.case = 'quoted at edges"';
  var o = _.mapExtend( null, op );
  o.src = '"aa"bb"cc"';
  var got = _.strSplit( o );
  var expected = [ 'aabbcc' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with extra quote inside "';
  var o = _.mapExtend( null, op );
  o.src = '"aa"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ 'aabbcc"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with # inside the first quoted text"';
  var o = _.mapExtend( null, op );
  o.src = '"a#a"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ 'a#abbcc"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with # inside not quoted text"';
  var o = _.mapExtend( null, op );
  o.src = '"aa"b#b""cc"';
  var got = _.strSplit( o );
  var expected = [ 'aab', '#', 'bcc"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with # inside the last quoted text"';
  var o = _.mapExtend( null, op );
  o.src = '"aa"bb""c#c"';
  var got = _.strSplit( o );
  var expected = [ 'aabbc', '#', 'c"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with # inside all 3 text splits"';
  var o = _.mapExtend( null, op );
  o.src = '"a#a"b#b""c#c"';
  var got = _.strSplit( o );
  var expected = [ 'a#ab', '#', 'bc', '#', 'c"' ];
  test.identical( got, expected );

  test.case = 'quoted at edges with extra spaces on edges';
  var o = _.mapExtend( null, op );
  o.src = ' "aa"bb"cc" ';
  var got = _.strSplit( o );
  var expected = [ 'aabbcc' ];
  test.identical( got, expected );

  test.close( 's:1 q:1 pe:0 pq:0 iq:1 delimeter:#' );

  /* - */

  test.open( 'complex' );

  var src = 'Test check // ( Tools/base/l2/String / strSplit / delimeter:" " > space on the beginning and the end <  ) # 3 ... failed';

  test.case = 's:0 q:1 pe:1 pd:1 pq:0 iq:0';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    preservingQuoting : 0,
    inliningQuoting : 0,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', '/', '', '/', ' ( Tools', '/', 'base', '/', 'l2', '/', 'String ', '/', ' strSplit ', '/', ' delimeter:', ' ', '', ' > ', 'space on the beginning and the end', ' < ', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:1 pe:1 pd:1 pq:1 iq:0';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    preservingQuoting : 1,
    inliningQuoting : 0,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', '/', '', '/', ' ( Tools', '/', 'base', '/', 'l2', '/', 'String ', '/', ' strSplit ', '/', ' delimeter:', '" "', '', ' > ', 'space on the beginning and the end', ' < ', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:1 pe:1 pd:1 pq:0 iq:1';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    preservingQuoting : 0,
    inliningQuoting : 1,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', '/', '', '/', ' ( Tools', '/', 'base', '/', 'l2', '/', 'String ', '/', ' strSplit ', '/', ' delimeter: ', ' > ', 'space on the beginning and the end', ' < ', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:1 pe:1 pd:1 pq:1 iq:1';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    preservingQuoting : 1,
    inliningQuoting : 1,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', '/', '', '/', ' ( Tools', '/', 'base', '/', 'l2', '/', 'String ', '/', ' strSplit ', '/', ' delimeter:" "', ' > ', 'space on the beginning and the end', ' < ', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:0 pe:0 pd:0';

  var o =
  {
    stripping : 0,
    quoting : 0,
    preservingEmpty : 0,
    preservingDelimeters : 0,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', ' ( Tools', 'base', 'l2', 'String ', ' strSplit ', ' delimeter:" "', 'space on the beginning and the end', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:0 pe:0 pd:1';

  var o =
  {
    stripping : 0,
    quoting : 0,
    preservingEmpty : 0,
    preservingDelimeters : 1,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', '/', '/', ' ( Tools', '/', 'base', '/', 'l2', '/', 'String ', '/', ' strSplit ', '/', ' delimeter:" "', ' > ', 'space on the beginning and the end', ' < ', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:0 pe:1 pd:0';

  var o =
  {
    stripping : 0,
    quoting : 0,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', '', ' ( Tools', 'base', 'l2', 'String ', ' strSplit ', ' delimeter:" "', 'space on the beginning and the end', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:0 pe:1 pd:1';

  var o =
  {
    stripping : 0,
    quoting : 0,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', '/', '', '/', ' ( Tools', '/', 'base', '/', 'l2', '/', 'String ', '/', ' strSplit ', '/', ' delimeter:" "', ' > ', 'space on the beginning and the end', ' < ', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:1 pe:0 pd:0';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 0,
    preservingDelimeters : 0,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', ' ( Tools', 'base', 'l2', 'String ', ' strSplit ', ' delimeter:" "', 'space on the beginning and the end', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:1 pe:0 pd:1';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 0,
    preservingDelimeters : 1,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', '/', '/', ' ( Tools', '/', 'base', '/', 'l2', '/', 'String ', '/', ' strSplit ', '/', ' delimeter:" "', ' > ', 'space on the beginning and the end', ' < ', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:1 pe:0 pd:1 pq:1';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 0,
    preservingDelimeters : 1,
    preservingQuoting : 1,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', '/', '/', ' ( Tools', '/', 'base', '/', 'l2', '/', 'String ', '/', ' strSplit ', '/', ' delimeter:" "', ' > ', 'space on the beginning and the end', ' < ', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:0 q:1 pe:1 pd:0';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check ', '', ' ( Tools', 'base', 'l2', 'String ', ' strSplit ', ' delimeter:" "', 'space on the beginning and the end', ' ) # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:1 q:0 pe:0 pd:0';

  var o =
  {
    stripping : 1,
    quoting : 0,
    preservingEmpty : 0,
    preservingDelimeters : 0,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check', '( Tools', 'base', 'l2', 'String', 'strSplit', 'delimeter:" "', 'space on the beginning and the end', ') # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:1 q:0 pe:0 pd:1';

  var o =
  {
    stripping : 1,
    quoting : 0,
    preservingEmpty : 0,
    preservingDelimeters : 1,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check', '/', '/', '( Tools', '/', 'base', '/', 'l2', '/', 'String', '/', 'strSplit', '/', 'delimeter:" "', '>', 'space on the beginning and the end', '<', ') # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:1 q:0 pe:1 pd:0';

  var o =
  {
    stripping : 1,
    quoting : 0,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check', '', '( Tools', 'base', 'l2', 'String', 'strSplit', 'delimeter:" "', 'space on the beginning and the end', ') # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:1 q:0 pe:1 pd:1';

  var o =
  {
    stripping : 1,
    quoting : 0,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check', '/', '', '/', '( Tools', '/', 'base', '/', 'l2', '/', 'String', '/', 'strSplit', '/', 'delimeter:" "', '>', 'space on the beginning and the end', '<', ') # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:1 q:1 pe:0 pd:0';

  var o =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 0,
    preservingDelimeters : 0,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check', '( Tools', 'base', 'l2', 'String', 'strSplit', 'delimeter:" "', 'space on the beginning and the end', ') # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:1 q:1 pe:0 pd:1';

  var o =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 0,
    preservingDelimeters : 1,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check', '/', '/', '( Tools', '/', 'base', '/', 'l2', '/', 'String', '/', 'strSplit', '/', 'delimeter:" "', '>', 'space on the beginning and the end', '<', ') # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:1 q:1 pe:1 pd:0';

  var o =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check', '', '( Tools', 'base', 'l2', 'String', 'strSplit', 'delimeter:" "', 'space on the beginning and the end', ') # 3 ... failed' ];
  test.identical( got, expected );

  test.case = 's:1 q:1 pe:1 pd:1'; /* */

  var o =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    delimeter : [ ' > ', ' < ', '/' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ 'Test check', '/', '', '/', '( Tools', '/', 'base', '/', 'l2', '/', 'String', '/', 'strSplit', '/', 'delimeter:" "', '>', 'space on the beginning and the end', '<', ') # 3 ... failed' ];
  test.identical( got, expected );

  var src =
`
= Org

- Q: "Where?"
- A1: "Here."

- A2: "There."
`

  test.case = 's:1 q:1 pe:1 pd:0 pq:1 iq:1'; /* */

  var o =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 1,
    inliningQuoting : 1,
    delimeter : [ '\n' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ '', '= Org', '', '- Q: "Where?"', '- A1: "Here."', '', '- A2: "There."', '' ];
  test.identical( got, expected );

  test.case = 's:1 q:1 pe:1 pd:0 pq:1 iq:0';

  var o =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 1,
    inliningQuoting : 0,
    delimeter : [ '\n' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ '', '= Org', '', '- Q:', '"Where?"', '', '- A1:', '"Here."', '', '', '- A2:', '"There."', '', '' ];
  test.identical( got, expected );

  test.case = 's:1 q:1 pe:1 pd:0 pq:0 iq:1'; /* */

  var o =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 0,
    inliningQuoting : 1,
    delimeter : [ '\n' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ '', '= Org', '', '- Q: Where?', '- A1: Here.', '', '- A2: There.', '' ];
  test.identical( got, expected );

  test.case = 's:1 q:1 pe:1 pd:0 pq:0 iq:0'; /* */

  var o =
  {
    stripping : 1,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 0,
    inliningQuoting : 0,
    delimeter : [ '\n' ],
    src,
  }
  var got = _.strSplit( o );
  var expected = [ '', '= Org', '', '- Q:', 'Where?', '', '- A1:', 'Here.', '', '', '- A2:', 'There.', '', '' ];
  test.identical( got, expected );

  test.case = 'quoted at edges, s:1 q:1 pe:1 pd:0 pq:0 iq:0'; /**/

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 0,
    inliningQuoting : 0,
    delimeter : [ '"' ],
  }

  o.src = '"a b" " c"';
  var expected = [ '', 'a b', ' ', ' c', '' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'quoted at edges, s:1 q:1 pe:1 pd:0 pq:0 iq:1'; /**/

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 0,
    inliningQuoting : 1,
    delimeter : [ '"' ],
  }

  o.src = '"a b" " c"';
  var expected = [ 'a b  c' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'quoted at edges, s:1 q:1 pe:1 pd:0 pq:1 iq:0'; /**/

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 1,
    inliningQuoting : 0,
    delimeter : [ '"' ],
  }

  o.src = '"a b" " c"';
  var expected = [ '', '"a b"', ' ', '" c"', '' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'quoted at edges, s:1 q:1 pe:1 pd:0 pq:1 iq:1'; /**/

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 1,
    inliningQuoting : 1,
    delimeter : [ '"' ],
  }

  o.src = '"a b" " c"';
  var expected = [ '"a b" " c"' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'quoted in the middle, s:1 q:1 pe:1 pd:0 pq:1 iq:1'; /**/

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 1,
    inliningQuoting : 1,
    delimeter : [ '"' ],
  }

  o.src = '"a b" """x" c';
  var expected = [ '"a b" """x" c' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'quoted in the middle, s:1 q:1 pe:1 pd:0 pq:1 iq:0'; /**/

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 1,
    inliningQuoting : 0,
    delimeter : [ '"' ],
  }

  o.src = '"a b" """x" c';
  var expected = [ '', '"a b"', ' ', '""', '', '"x"', ' c' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'quoted in the middle, s:1 q:1 pe:1 pd:0 pq:0 iq:1'; /**/

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 0,
    inliningQuoting : 1,
    delimeter : [ '"' ],
  }

  o.src = '"a b" """x" c';
  var expected = [ 'a b x c' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  test.case = 'quoted in the middle, s:1 q:1 pe:1 pd:0 pq:0 iq:0'; /**/

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 0,
    inliningQuoting : 0,
    delimeter : [ '"' ],
  }

  o.src = '"a b" """x" c';
  var expected = [ '', 'a b', ' ', '', '', 'x', ' c' ];
  var got = _.strSplit( o );
  test.identical( got, expected );

  /* */

  test.case = 'extra quote, s:1 q:1 pe:1 pd:0 pq:1 iq:1';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 1,
    inliningQuoting : 1,
    delimeter : [ '#' ],
  }

  o.src = '"aa"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ '"aa"bb""cc"' ];
  test.identical( got, expected );

  test.case = 'extra quote, s:1 q:1 pe:1 pd:0 pq:0 iq:1';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 0,
    inliningQuoting : 1,
    delimeter : [ '#' ],
  }

  o.src = '"aa"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ 'aabbcc"' ];
  test.identical( got, expected );

  test.case = 'extra quote, s:1 q:1 pe:1 pd:0 pq:1 iq:0';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 1,
    inliningQuoting : 0,
    delimeter : [ '#' ],
  }

  o.src = '"aa"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ '', '"aa"', 'bb', '""', 'cc"' ];
  test.identical( got, expected );

  test.case = 'extra quote, s:1 q:1 pe:1 pd:0 pq:0 iq:0';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
    preservingQuoting : 0,
    inliningQuoting : 0,
    delimeter : [ '#' ],
  }

  o.src = '"aa"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ '', 'aa', 'bb', '', 'cc"' ];
  test.identical( got, expected );

  /* */

  test.case = 'extra quote as delimeter, s:1 q:1 pe:1 pd:1 pq:1 iq:1';

  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    preservingQuoting : 1,
    inliningQuoting : 1,
    delimeter : [ '#', '"' ],
  }

  o.src = '"aa"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ '"aa"bb""cc', '"', '' ];
  test.identical( got, expected );

  test.case = 'extra quote as delimeter, s:1 q:1 pe:1 pd:1 pq:0 iq:1';
  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    preservingQuoting : 0,
    inliningQuoting : 1,
    delimeter : [ '#', '"' ],
  }

  o.src = '"aa"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ 'aabbcc', '"', '' ];
  test.identical( got, expected );

  test.case = 'extra quote as delimeter, s:1 q:1 pe:1 pd:1 pq:1 iq:0';
  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    preservingQuoting : 1,
    inliningQuoting : 0,
    delimeter : [ '#', '"' ],
  }

  o.src = '"aa"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ '', '"aa"', 'bb', '""', 'cc', '"', '' ];
  test.identical( got, expected );

  test.case = 'extra quote as delimeter, s:1 q:1 pe:1 pd:1 pq:0 iq:0';
  var o =
  {
    stripping : 0,
    quoting : 1,
    preservingEmpty : 1,
    preservingDelimeters : 1,
    preservingQuoting : 0,
    inliningQuoting : 0,
    delimeter : [ '#', '"' ],
  }

  o.src = '"aa"bb""cc"';
  var got = _.strSplit( o );
  var expected = [ '', 'aa', 'bb', '', 'cc', '"', '' ];
  test.identical( got, expected );

  test.close( 'complex' );
}

//

function strSplitInlinedDefaultOptions( test )
{
  test.open( 'arguments' );

  test.case = 'srcStr - empty string';
  var srcStr = '';
  var got = _.strSplitInlined( srcStr );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'srcStr - without default delimeter, delimeter - default';
  var srcStr = 'a b c d e';
  var got = _.strSplitInlined( srcStr );
  var expected = [ 'a b c d e' ];
  test.identical( got, expected );

  test.case = 'srcStr - without default delimeter, delimeter - space';
  var srcStr = 'a b c d e';
  var got = _.strSplitInlined( srcStr, ' ' );
  var expected = [ 'a', [ 'b' ], 'c', [ 'd' ], 'e' ];
  test.identical( got, expected );

  test.case = 'srcStr - without default delimeter, delimeter - space, not closed delimeter';
  var srcStr = 'a b c d';
  var got = _.strSplitInlined( srcStr, ' ' );
  var expected = [ 'a', [ 'b' ], 'c d' ];
  test.identical( got, expected );

  test.case = 'srcStr - string with default delimeter, delimeter - default';
  var srcStr = 'ab#cd#ef';
  var got = _.strSplitInlined( srcStr );
  var expected = [ 'ab', [ 'cd' ], 'ef' ];
  test.identical( got, expected );

  test.case = 'srcStr - string with default delimeter, delimeter - default, not closed delimeter';
  var srcStr = 'ab#cd#ef#gh';
  var got = _.strSplitInlined( srcStr );
  var expected = [ 'ab', [ 'cd' ], 'ef#gh' ];
  test.identical( got, expected );

  test.case = 'srcStr - string with default delimeter, delimeter - space';
  var srcStr = 'ab#cd#ef';
  var got = _.strSplitInlined( srcStr, ' ' );
  var expected = [ 'ab#cd#ef' ];
  test.identical( got, expected );

  test.close( 'arguments' );

  /* - */

  test.open( 'default' );

  test.case = 'full split, closing delimeter';
  var srcStr = 'this #background:red#is#background:default# text and is not';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    'this ', [ 'background:red' ], 'is', [ 'background:default' ], ' text and is not'
  ];
  test.identical( got, expected );

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this #background:red#is#background:default# text and # is not';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    'this ', [ 'background:red' ], 'is', [ 'background:default' ], ' text and # is not'
  ];
  test.identical( got, expected );

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = '#simple # text #background:red#is#background:default# text and # is not#';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '', [ 'simple ' ], ' text ', [ 'background:red' ], 'is', [ 'background:default' ], ' text and ', [ ' is not' ], ''
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = '#background:red#i#s#background:default##text';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '', [ 'background:red' ], 'i', [ 's' ], 'background:default', [ '' ], 'text'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and the end';
  var srcStr = '#background:red#i#s#background:default#';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '', [ 'background:red' ], 'i', [ 's' ], 'background:default#',
  ];
  test.identical( got, expected );

  test.case = 'empty string left';
  var srcStr = '##ordinary#inline2#';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '', [ '' ], 'ordinary', [ 'inline2' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty string right';
  var srcStr = '#inline1#ordinary##';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '', [ 'inline1' ], 'ordinary', [ '' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty string middle';
  var srcStr = '#inline1##inline2#';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '', [ 'inline1' ], '', [ 'inline2' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty all';
  var srcStr = '####';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected = [ '', [ '' ], '', [ '' ], '' ];
  test.identical( got, expected );

  test.close( 'default' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strSplitInlined() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strSplitInlined( 'abc', '##','extra' ) );

  test.case = 'wrong type of srcStr';
  test.shouldThrowErrorSync( () => _.strSplitInlined( [ 'abc' ], '' ) );
  test.shouldThrowErrorSync( () => _.strSplitInlined( { 'a' : 'b' }, '' ) );

  test.case = 'wrong type of delimeter';
  test.shouldThrowErrorSync( () => _.strSplitInlined( 'abc', new U8x() ) );
  test.shouldThrowErrorSync( () => _.strSplitInlined( 'abc', {} ) );

  test.case = 'wrong type of map o';
  test.shouldThrowErrorSync( () => _.strSplitInlined( [ 'abc', '' ] ) );
  test.shouldThrowErrorSync( () => _.strSplitInlined( { 'abc' : '' } ) );
}

//

function strSplitInlinedOptionDelimeter( test ) 
{
  test.case = 'full split, closing delimeter';
  var srcStr = 'this background:red is background:default text and is not';
  var got = _.strSplitInlined( { src : srcStr, delimeter : ' ' } );
  var expected =
  [
    'this', [ 'background:red' ], 'is', [ 'background:default' ], 'text', [ 'and' ], 'is not'
  ];
  test.identical( got, expected );

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this background:red is background:default text and is not ';
  var got = _.strSplitInlined( { src : srcStr, delimeter : ' ' } );
  var expected =
  [
    'this', [ 'background:red' ], 'is', [ 'background:default' ], 'text', [ 'and' ], 'is', [ 'not' ], ''
  ];
  test.identical( got, expected );

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = ' simple text background:red is background:default text and is not ';
  var got = _.strSplitInlined( { src : srcStr, delimeter : ' ' } );
  var expected =
  [
    '', [ 'simple' ], 'text', [ 'background:red' ], 'is', [ 'background:default' ], 'text', [ 'and' ], 'is', [ 'not' ], ''
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = ' background:red i s background:default  text';
  var got = _.strSplitInlined( { src : srcStr, delimeter : ' ' } );
  var expected =
  [
    '', [ 'background:red' ], 'i', [ 's' ], 'background:default', [ '' ], 'text'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and the end';
  var srcStr = ' background:red i s background:default ';
  var got = _.strSplitInlined( { src : srcStr, delimeter : ' ' } );
  var expected =
  [
    '', [ 'background:red' ], 'i', [ 's' ], 'background:default ',
  ];
  test.identical( got, expected );

  test.case = 'empty string left';
  var srcStr = '  ordinary inline2 ';
  var got = _.strSplitInlined( { src : srcStr, delimeter : ' ' } );
  var expected =
  [
    '', [ '' ], 'ordinary', [ 'inline2' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty string right';
  var srcStr = ' inline1 ordinary  ';
  var got = _.strSplitInlined( { src : srcStr, delimeter : ' ' } );
  var expected =
  [
    '', [ 'inline1' ], 'ordinary', [ '' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty string middle';
  var srcStr = ' inline1  inline2 ';
  var got = _.strSplitInlined( { src : srcStr, delimeter : ' ' } );
  var expected =
  [
    '', [ 'inline1' ], '', [ 'inline2' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty all';
  var srcStr = '    ';
  var got = _.strSplitInlined( { src : srcStr, delimeter : ' ' } );
  var expected = [ '', [ '' ], '', [ '' ], '' ];
  test.identical( got, expected );
}

//

function strSplitInlinedOptionStripping( test )
{
  test.open( 'stripping - 0' );

  test.case = 'full split, closing delimeter';
  var srcStr = 'this  # \nbackground:red\t# is # background:default   #  text  and  is not \n';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    'this  ', [ ' \nbackground:red\t' ], ' is ', [ ' background:default   ' ], '  text  and  is not \n'
  ];
  test.identical( got, expected );

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this  # \nbackground:red\t# is # background:default   #  text  and  #  is not\n';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    'this  ', [ ' \nbackground:red\t' ], ' is ', [ ' background:default   ' ], '  text  and  #  is not\n'
  ];
  test.identical( got, expected );

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = '\n#\n\t simple  # \n\t\rtext #  background:red  #  is  #  background:default  # text and # is not   #';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '\n', [ '\n\t simple  ' ], ' \n\t\rtext ', [ '  background:red  ' ], '  is  ', [ '  background:default  ' ], ' text and ', [ ' is not   ' ], ''
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = '   # \t\tbackground:red  # \n\ni  #  s  #background:default  #\n\r\t  #  text\n';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '   ', [ ' \t\tbackground:red  ' ], ' \n\ni  ', [ '  s  ' ], 'background:default  ', [ '\n\r\t  ' ], '  text\n'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and the end';
  var srcStr = '  #  background:red  #  i  #  s  #   background:default  #  ';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '  ', [ '  background:red  ' ], '  i  ', [ '  s  ' ], '   background:default  #  ',
  ];
  test.identical( got, expected );

  test.case = 'empty string left';
  var srcStr = '  #  #\n\nordinary\t\t#\ninline2 # ';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '  ', [ '  ' ], '\n\nordinary\t\t', [ '\ninline2 ' ], ' '
  ];
  test.identical( got, expected );

  test.case = 'empty string right';
  var srcStr = '\t#\ninline1\r#\tordinary\n#\r#\t';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '\t', [ '\ninline1\r' ], '\tordinary\n', [ '\r' ], '\t'
  ];
  test.identical( got, expected );

  test.case = 'empty string middle';
  var srcStr = '  #  inline1  #  #  inline2  #';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '  ', [ '  inline1  ' ], '  ', [ '  inline2  ' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty all';
  var srcStr = '\n#\n#\n#\n#\r';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected = [ '\n', [ '\n' ], '\n', [ '\n' ], '\r' ];
  test.identical( got, expected );

  test.close( 'stripping - 0' );

  /* - */
  
  test.open( 'stripping - 1' );

  test.case = 'full split, closing delimeter';
  var srcStr = 'this  # \nbackground:red\t# is # background:default   #  text  and  is not \n';
  var got = _.strSplitInlined( { src : srcStr, stripping : 1 } );
  var expected =
  [
    'this', [ 'background:red' ], 'is', [ 'background:default' ], 'text  and  is not'
  ];
  test.identical( got, expected );

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this  # \nbackground:red\t# is # background:default   #  text  and  #  is not\n';
  var got = _.strSplitInlined( { src : srcStr, stripping : 1 } );
  var expected =
  [
    'this', [ 'background:red' ], 'is', [ 'background:default' ], 'text  and#is not'
  ];
  test.identical( got, expected );

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = '\n#\n\t simple  # \n\t\rtext #  background:red  #  is  #  background:default  # text and # is not   #';
  var got = _.strSplitInlined( { src : srcStr, stripping : 1 } );
  var expected =
  [
    '', [ 'simple' ], 'text', [ 'background:red' ], 'is', [ 'background:default' ], 'text and', [ 'is not' ], ''
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = '   # \t\tbackground:red  # \n\ni  #  s  #background:default  #\n\r\t  #  text\n';
  var got = _.strSplitInlined( { src : srcStr, stripping : 1 } );
  var expected =
  [
    '', [ 'background:red' ], 'i', [ 's' ], 'background:default', [ '' ], 'text'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and the end';
  var srcStr = '  #  background:red  #  i  #  s  #   background:default  #  ';
  var got = _.strSplitInlined( { src : srcStr, stripping : 1 } );
  var expected =
  [
    '', [ 'background:red' ], 'i', [ 's' ], 'background:default#',
  ];
  test.identical( got, expected );

  test.case = 'empty string left';
  var srcStr = '  #  #\n\nordinary\t\t#\ninline2 # ';
  var got = _.strSplitInlined( { src : srcStr, stripping : 1 } );
  var expected =
  [
    '', [ '' ], 'ordinary', [ 'inline2' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty string right';
  var srcStr = '\t#\ninline1\r#\tordinary\n#\r#\t';
  var got = _.strSplitInlined( { src : srcStr, stripping : 1 } );
  var expected =
  [
    '', [ 'inline1' ], 'ordinary', [ '' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty string middle';
  var srcStr = '  #  inline1  #  #  inline2  #';
  var got = _.strSplitInlined( { src : srcStr, stripping : 1 } );
  var expected =
  [
    '', [ 'inline1' ], '', [ 'inline2' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty all';
  var srcStr = '\n#\n#\n#\n#\r';
  var got = _.strSplitInlined( { src : srcStr, stripping : 1 } );
  var expected = [ '', [ '' ], '', [ '' ], '' ];
  test.identical( got, expected );

  test.close( 'stripping - 1' );
}

//

function strSplitInlinedOptionQuoting( test )
{
  test.open( 'quoting - 0' );

  test.case = 'full split, closing delimeter';
  var srcStr = 'this "#"background:red"#"is"#"background:default"#" text and is not';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    'this "', [ '"background:red"' ], '"is"', [ '"background:default"' ], '" text and is not'
  ];
  test.identical( got, expected );

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this "#"background:red"#"is"#"background:default"#" text and "#" is not';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    'this "', [ '"background:red"' ], '"is"', [ '"background:default"' ], '" text and "#" is not'
  ];
  test.identical( got, expected );

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = '"#"simple "#" text "#"background:red"#"is"#"background:default"#" text and "#" is not"#"';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '"', [ '"simple "' ], '" text "', [ '"background:red"' ], '"is"', [ '"background:default"' ], '" text and "', [ '" is not"' ], '"'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = '"#"background:red"#"i"#"s"#"background:default"#""#"text';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '"', [ '"background:red"' ], '"i"', [ '"s"' ], '"background:default"', [ '""' ], '"text'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and the end';
  var srcStr = '"#"background:red"#"i"#"s"#"background:default"#"';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '"', [ '"background:red"' ], '"i"', [ '"s"' ], '"background:default"#"',
  ];
  test.identical( got, expected );

  test.case = 'empty string left';
  var srcStr = '"#""#"ordinary"#"inline2"#"';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '"', [ '""' ], '"ordinary"', [ '"inline2"' ], '"'
  ];
  test.identical( got, expected );

  test.case = 'empty string right';
  var srcStr = '"#"inline1"#"ordinary"#""#"';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '"', [ '"inline1"' ], '"ordinary"', [ '""' ], '"'
  ];
  test.identical( got, expected );

  test.case = 'empty string middle';
  var srcStr = '"#"inline1"#""#"inline2"#"';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected =
  [
    '"', [ '"inline1"' ], '""', [ '"inline2"' ], '"'
  ];
  test.identical( got, expected );

  test.case = 'empty all';
  var srcStr = '"#""#""#""#"';
  var got = _.strSplitInlined( { src : srcStr } );
  var expected = [ '"', [ '""' ], '""', [ '""' ], '"' ];
  test.identical( got, expected );

  test.close( 'quoting - 0' );

  /* - */
  
  test.open( 'quoting - 1' );

  test.case = 'full split, closing delimeter';
  var srcStr = 'this "#"background:red"#"is"#"background:default"#" text and is not';
  var got = _.strSplitInlined( { src : srcStr, quoting : 1 } );
  var expected =
  [
   'this "#"background:red"#"is"#"background:default"#" text and is not' 
  ];
  test.identical( got, expected );

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this "#"background:red"#"is"#"background:default"#" text and "#" is not';
  var got = _.strSplitInlined( { src : srcStr, quoting : 1 } );
  var expected =
  [
   'this "#"background:red"#"is"#"background:default"#" text and "#" is not' 
  ];
  test.identical( got, expected );

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = '"#"simple "#" text "#"background:red"#"is"#"background:default"#" text and "#" is not"#"';
  var got = _.strSplitInlined( { src : srcStr, quoting : 1 } );
  var expected =
  [
   '"#"simple "#" text "#"background:red"#"is"#"background:default"#" text and "#" is not"#"' 
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = '"#"background:red"#"i"#"s"#"background:default"#""#"text';
  var got = _.strSplitInlined( { src : srcStr, quoting : 1 } );
  var expected =
  [
   '"#"background:red"#"i"#"s"#"background:default"#""#"text' 
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and the end';
  var srcStr = '"#"background:red"#"i"#"s"#"background:default"#"';
  var got = _.strSplitInlined( { src : srcStr, quoting : 1 } );
  var expected =
  [
    '"#"background:red"#"i"#"s"#"background:default"#"',
  ];
  test.identical( got, expected );

  test.case = 'empty string left';
  var srcStr = '"#""#"ordinary"#"inline2"#"';
  var got = _.strSplitInlined( { src : srcStr, quoting : 1 } );
  var expected =
  [
   '"#""#"ordinary"#"inline2"#"' 
  ];
  test.identical( got, expected );

  test.case = 'empty string right';
  var srcStr = '"#"inline1"#"ordinary"#""#"';
  var got = _.strSplitInlined( { src : srcStr, quoting : 1 } );
  var expected =
  [
   '"#"inline1"#"ordinary"#""#"' 
  ];
  test.identical( got, expected );

  test.case = 'empty string middle';
  var srcStr = '"#"inline1"#""#"inline2"#"';
  var got = _.strSplitInlined( { src : srcStr, quoting : 1 } );
  var expected =
  [
   '"#"inline1"#""#"inline2"#"' 
  ];
  test.identical( got, expected );

  test.case = 'empty all';
  var srcStr = '"#""#""#""#"';
  var got = _.strSplitInlined( { src : srcStr, quoting : 1 } );
  var expected = [ '"#""#""#""#"' ];
  test.identical( got, expected );

  test.close( 'quoting - 1' );
}

//

function strSplitInlinedOptionPreservingEmpty( test ) 
{
  test.case = 'full split, closing delimeter';
  var srcStr = 'this #background:red#is#background:default# text and is not';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0 } );
  var expected =
  [
    'this ', [ 'background:red' ], 'is', [ 'background:default' ], ' text and is not'
  ];
  test.identical( got, expected );

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this #background:red#is#background:default# text and # is not';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0 } );
  var expected =
  [
    'this ', [ 'background:red' ], 'is', [ 'background:default' ], ' text and # is not'
  ];
  test.identical( got, expected );

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = '#simple # text #background:red#is#background:default# text and # is not#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0 } );
  var expected =
  [
    [ 'simple ' ], ' text ', [ 'background:red' ], 'is', [ 'background:default' ], ' text and ', [ ' is not' ]
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = '#background:red#i#s#background:default##text';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0 } );
  var expected =
  [
    [ 'background:red' ], 'i', [ 's' ], 'background:default', [ '' ], 'text'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and the end';
  var srcStr = '#background:red#i#s#background:default#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0 } );
  var expected =
  [
    [ 'background:red' ], 'i', [ 's' ], 'background:default#',
  ];
  test.identical( got, expected );

  test.case = 'empty string left';
  var srcStr = '##ordinary#inline2#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0 } );
  var expected =
  [
    [ '' ], 'ordinary', [ 'inline2' ],
  ];
  test.identical( got, expected );

  test.case = 'empty string right';
  var srcStr = '#inline1#ordinary##';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0 } );
  var expected =
  [
    [ 'inline1' ], 'ordinary', [ '' ]
  ];
  test.identical( got, expected );

  test.case = 'empty string middle';
  var srcStr = '#inline1##inline2#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0 } );
  var expected =
  [
    [ 'inline1' ], [ 'inline2' ],
  ];
  test.identical( got, expected );

  test.case = 'empty all';
  var srcStr = '####';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0 } );
  var expected = [ [ '' ], [ '' ] ];
  test.identical( got, expected );
}

//

function strSplitInlinedOptionOnInlined( test ) 
{
  var onInlined = function( part )
  {
    var temp = part.split( ':' );

    if( temp.length === 2 )
    return temp;

    return undefined;
  };

  /* - */

  test.case = 'full split, closing delimeter';
  var srcStr = 'this #background:red#is#background:default# text and is not';
  var got = _.strSplitInlined( { src : srcStr, onInlined : onInlined } );
  var expected =
  [
    'this ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and is not'
  ];
  test.identical( got, expected );

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this #background:red#is#background:default# text and # is not';
  var got = _.strSplitInlined( { src : srcStr, onInlined : onInlined } );
  var expected =
  [
    'this ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and # is not'
  ];
  test.identical( got, expected );

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = '#simple # text #background:red#is#background:default# text and # is not#';
  var got = _.strSplitInlined( { src : srcStr, onInlined : onInlined } );
  var expected =
  [
    '#simple # text ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and # is not#'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = '#background:red#i#s#background:default##text';
  var got = _.strSplitInlined( { src : srcStr, onInlined : onInlined } );
  var expected =
  [
    '', [ 'background', 'red' ], 'i#s', [ 'background', 'default' ], '#text'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and the end';
  var srcStr = '#background:red#i#s#background:default#';
  var got = _.strSplitInlined( { src : srcStr, onInlined : onInlined } );
  var expected =
  [
    '', [ 'background', 'red' ], 'i#s', [ 'background', 'default' ], ''
  ];
  test.identical( got, expected );

  test.case = 'empty string left';
  var srcStr = '##ordinary#inline2#';
  var got = _.strSplitInlined( { src : srcStr, onInlined : onInlined } );
  var expected =
  [
    '##ordinary#inline2#'
  ];
  test.identical( got, expected );

  test.case = 'empty string right';
  var srcStr = '#inline1#ordinary##';
  var got = _.strSplitInlined( { src : srcStr, onInlined : onInlined } );
  var expected =
  [
    '#inline1#ordinary##'
  ];
  test.identical( got, expected );

  test.case = 'empty string middle';
  var srcStr = '#inline1##inline2#';
  var got = _.strSplitInlined( { src : srcStr, onInlined : onInlined } );
  var expected =
  [
    '#inline1##inline2#'
  ];
  test.identical( got, expected );

  test.case = 'empty all';
  var srcStr = '####';
  var got = _.strSplitInlined( { src : srcStr, onInlined : onInlined } );
  var expected = [ '####' ];
  test.identical( got, expected );
}

//

function strSplitInlinedCombineOnInlinedAndPreservingEmpty( test ) 
{
  var onInlined = function( part )
  {
    var temp = part.split( ':' );

    if( temp.length === 2 )
    return temp;

    return undefined;
  };

  /* - */

  test.open( 'preservingEmpty - 0, onInlined' );

  test.case = 'full split, closing delimeter';
  var srcStr = 'this #background:red#is#background:default# text and is not';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : onInlined } );
  var expected =
  [
    'this ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and is not'
  ];
  test.identical( got, expected );

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this #background:red#is#background:default# text and # is not';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : onInlined } );
  var expected =
  [
    'this ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and # is not'
  ];
  test.identical( got, expected );

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = '#simple # text #background:red#is#background:default# text and # is not#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : onInlined } );
  var expected =
  [
    '#simple # text ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and # is not#'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = '#background:red#i#s#background:default##text';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : onInlined } );
  var expected =
  [
    [ 'background', 'red' ], 'i#s', [ 'background', 'default' ], '#text'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and the end';
  var srcStr = '#background:red#i#s#background:default#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : onInlined } );
  var expected =
  [
    [ 'background', 'red' ], 'i#s', [ 'background', 'default' ],
  ];
  test.identical( got, expected );

  test.case = 'empty string left';
  var srcStr = '##ordinary#inline2#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : onInlined } );
  var expected =
  [
    '##ordinary#inline2#',
  ];
  test.identical( got, expected );

  test.case = 'empty string right';
  var srcStr = '#inline1#ordinary##';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : onInlined } );
  var expected =
  [
    '#inline1#ordinary##'
  ];
  test.identical( got, expected );

  test.case = 'empty string middle';
  var srcStr = '#inline1##inline2#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : onInlined } );
  var expected =
  [
    '#inline1##inline2#'
  ];
  test.identical( got, expected );

  test.case = 'empty all';
  var srcStr = '####';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : onInlined } );
  var expected = [ '####' ];
  test.identical( got, expected );

  test.close( 'preservingEmpty - 0, onInlined' );

  /* - */

  test.open( 'preservingEmpty - 0, onInlined - null' );

  test.case = 'full split, closing delimeter';
  var srcStr = 'this #background:red#is#background:default# text and is not';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : null } );
  var expected =
  [
    'this ', 'background:red', 'is', 'background:default', ' text and is not'
  ];
  test.identical( got, expected );

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this #background:red#is#background:default# text and # is not';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : null } );
  var expected =
  [
    'this ', 'background:red', 'is', 'background:default', ' text and # is not'
  ];
  test.identical( got, expected );

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = '#simple # text #background:red#is#background:default# text and # is not#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : null } );
  var expected =
  [
    'simple ', ' text ', 'background:red', 'is', 'background:default', ' text and ', ' is not'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = '#background:red#i#s#background:default##text';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : null } );
  var expected =
  [
    'background:red', 'i', 's', 'background:default', 'text'
  ];
  test.identical( got, expected );

  test.case = 'inlined at the beginning and the end';
  var srcStr = '#background:red#i#s#background:default#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : null } );
  var expected =
  [
    'background:red', 'i', 's', 'background:default#'
  ];
  test.identical( got, expected );

  test.case = 'empty string left';
  var srcStr = '##ordinary#inline2#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : null } );
  var expected =
  [
    'ordinary', 'inline2',
  ];
  test.identical( got, expected );

  test.case = 'empty string right';
  var srcStr = '#inline1#ordinary##';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : null } );
  var expected =
  [
    'inline1', 'ordinary'
  ];
  test.identical( got, expected );

  test.case = 'empty string middle';
  var srcStr = '#inline1##inline2#';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : null } );
  var expected =
  [
    'inline1', 'inline2'
  ];
  test.identical( got, expected );

  test.case = 'empty all';
  var srcStr = '####';
  var got = _.strSplitInlined( { src : srcStr, preservingEmpty : 0, onInlined : null } );
  var expected = [];
  test.identical( got, expected );

  test.close( 'preservingEmpty - 0, onInlined - null' );
}

//

function strSplitInlinedStereo( test )
{
  var got, expected;

  test.case = 'default';

  /* nothing */

  got = _.strSplitInlinedStereo( '' );
  expected = [ '' ];
  test.identical( got, expected );

  /* prefix/postfix # by default */

  debugger;
  got = _.strSplitInlinedStereo( '#abc#' );
  debugger;
  expected = [ '', 'abc', '' ];
  test.identical( got, expected );

  /* - */

  test.case = 'with options';

  /* pre/post are same */

  got = _.strSplitInlinedStereo( { prefix : '/', postfix : '/', src : '/abc/' } );
  expected = [ '', 'abc', '' ];
  test.identical( got, expected );

  /**/

  got = _.strSplitInlinedStereo( { prefix : '/', postfix : '/', src : '//abc//' } );
  expected = [ '', '', 'abc', '', '' ];
  test.identical( got, expected );

  /* different pre/post */

  got = _.strSplitInlinedStereo( { prefix : '/#', postfix : '#', src : '/#abc#' } );
  expected = [ 'abc' ];
  test.identical( got, expected );

  /* postfix appears in source two times */
  got = _.strSplitInlinedStereo( { prefix : '/', postfix : '#', src : '/ab#c#' } );
  expected = [ 'ab', 'c#' ];
  test.identical( got, expected );

  /* onInlined #1 */
  function onInlined1( strip )
  {
    if( strip.length )
    return strip;
  }
  got = _.strSplitInlinedStereo( { onInlined : onInlined1, src : '#abc#' } );
  expected = [ '#abc#' ];
  test.identical( got, expected );

  /* onInlined #2 */
  function onInlined2( strip )
  {
    return strip + strip;
  }
  got = _.strSplitInlinedStereo( { prefix : '/', postfix : '#', onInlined : onInlined2, src : '/abc#' } );
  expected = [ 'abcabc' ];
  test.identical( got, expected );

}

// --
// test suite
// --

var Self =
{

  name : 'Tools.base.Str',
  silencing : 1,

  tests :
  {

    //

    strLeft, /* qqq : update | Dmytro : updated, new option implemented */
    strRight, /* qqq : update | Dmytro : updated, new option implemented */

    strEquivalent,
    strsEquivalent,
    strsEquivalentAll,
    strsEquivalentAny,
    strsEquivalentNone,

    strBeginOf,
    strEndOf,
    strBegins,
    strEnds,

    // converter

    strShort,
    strPrimitive,

    strQuote,
    strUnquote,
    strQuotePairsNormalize,
    strQuoteAnalyze,

    strInsideOf,
    strOutsideOf,

    strRemoveBegin,
    strRemoveEnd,
    strReplaceBegin,
    strReplaceEnd,
    strReplace,

    strIsolateLeftOrNone,
    strIsolateLeftOrAll,
    strIsolateRightOrNone,
    strIsolateRightOrAll,
    // strIsolateInsideOrNone,
    strIsolateInsideLeft,
    strIsolateInsideLeftPairs,

    // splitter

    strSplitsCoupledGroup,
    strSplitsDropEmpty,

    strSplitFast,
    strSplitFastRegexp,
    strSplit,

    strSplitInlinedDefaultOptions,
    strSplitInlinedOptionDelimeter,
    strSplitInlinedOptionStripping,
    strSplitInlinedOptionQuoting,
    strSplitInlinedOptionPreservingEmpty,
    strSplitInlinedOptionOnInlined,
    strSplitInlinedCombineOnInlinedAndPreservingEmpty,

    strSplitInlinedStereo,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
