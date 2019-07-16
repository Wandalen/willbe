( function _String_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../Tools.s' );
  _.include( 'wTesting' );
}

var _global = _global_;
var _ = _global_.wTools;

// --
//
// --

function strLeft( test )
{

  /* - */

  test.open( 'string' );

  /* - */

  test.case = 'begin';

  var expected = { index : 0, entry : 'aa' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', 'aa' );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = { index : 6, entry : 'bb' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', 'bb' );
  test.identical( got, expected );

  test.case = 'end';

  var expected = { index : 12, entry : 'cc' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', 'cc' );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = { index : 0, entry : 'aa' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = { index : 0, entry : 'aa' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = { index : 6, entry : 'bb' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = { index : 6, entry : 'bb' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = { index : 12, entry : 'cc' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = { index : 12, entry : 'cc' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ { index : 6, entry : 'bb' }, { index : 0, entry : 'cc' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 0, entry : 'cc' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ { index : 12, entry : 'cc' }, { index : 0, entry : 'cc' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = [ { index : 12, entry : 'cc' }, { index : 0, entry : 'cc' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'with window';

  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -15 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 9, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -10 );
  test.identical( got, expected );
  var expected = [ { index : 17, entry : undefined }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -1 );
  test.identical( got, expected );
  var expected = [ { index : 17, entry : undefined }, { index : 15, entry : 'aa' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -2 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 1 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 3 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 6 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 9, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 7 );
  test.identical( got, expected );
  var expected = [ { index : 17, entry : undefined }, { index : 12, entry : 'aa' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 10 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17, -15 );
  test.identical( got, expected );
  var expected = [ { index : 17, entry : undefined }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17, -16 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17, -10 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17, -9 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -15, -12 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -15, -9 );
  test.identical( got, expected );
  var expected = [ { index : 17, entry : undefined }, { index : 15, entry : 'aa' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -2, 17 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, 2 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 1, 7 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 1, 8 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, -15 );
  test.identical( got, expected );
  var expected = [ { index : 17, entry : undefined }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, -16 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, -10 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, -9 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, -12 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, 17 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, 2 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, 7 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, 8 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, -15 );
  test.identical( got, expected );
  var expected = [ { index : 17, entry : undefined }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, -16 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, -10 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, -9 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, -12 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, 17 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, 2 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, 7 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, 8 );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = { index : 17, entry : undefined }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = { index : 17, entry : undefined }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', 'dd' );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = { index : 0, entry : '' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', '' );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = { index : 0, entry : '' }
  var got = _.strLeft( '', '' );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = { index : 0, entry : undefined }
  var got = _.strLeft( '', 'aa' );
  test.identical( got, expected );

  /* - */

  test.close( 'string' );
  test.open( 'regexp' );

  /* - */

  test.case = 'begin';

  var expected = { index : 0, entry : 'aa' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', /a+/ );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = { index : 6, entry : 'bb' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', /b+/ );
  test.identical( got, expected );

  test.case = 'end';

  var expected = { index : 12, entry : 'cc' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', /c+/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin smeared';

  var expected = { index : 0, entry : 'xa' }
  var got = _.strLeft( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /\wa/ );
  test.identical( got, expected );

  test.case = 'middle smeared';

  var expected = { index : 10, entry : 'xb' }
  var got = _.strLeft( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /\wb/ );
  test.identical( got, expected );

  test.case = 'end ';

  var expected = { index : 20, entry : 'xc' }
  var got = _.strLeft( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /\wc/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = { index : 0, entry : 'aa' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = { index : 0, entry : 'aa' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = { index : 6, entry : 'bb' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = { index : 6, entry : 'bb' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = { index : 12, entry : 'cc' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = { index : 12, entry : 'cc' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ { index : 6, entry : 'bb' }, { index : 0, entry : 'cc' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 0, entry : 'cc' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ { index : 12, entry : 'cc' }, { index : 0, entry : 'cc' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 12, entry : 'cc' }, { index : 0, entry : 'cc' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'with window, mixed';

  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -17 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -15 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 9, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -10 );
  test.identical( got, expected );
  var expected = [ { index : 17, entry : undefined }, { index : 16, entry : 'a' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -1 );
  test.identical( got, expected );
  var expected = [ { index : 17, entry : undefined }, { index : 15, entry : 'aa' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -2 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 0 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -17, -15 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 0, 2 );
  test.identical( got, expected );
  var expected = [ { index : 1, entry : 'a' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 1, 7 );
  test.identical( got, expected );
  var expected = [ { index : 1, entry : 'a' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 1, 8 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], undefined, -15 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'a' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], undefined, -16 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], undefined, 7 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], undefined, 8 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 17, entry : undefined } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 0, 7 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : 6, entry : 'bb' } ];
  var got = _.strLeft( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 0, 8 );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = { index : 17, entry : undefined }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = { index : 17, entry : undefined }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', /d+/ );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = { index : 0, entry : '' }
  var got = _.strLeft( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = { index : 0, entry : '' }
  var got = _.strLeft( '', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = { index : 0, entry : undefined }
  var got = _.strLeft( '', /a+/ );
  test.identical( got, expected );

  /* - */

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.shouldThrowErrorSync( () => _.strLeft( 'abc', 'b', -100 ) );
  test.shouldThrowErrorSync( () => _.strLeft( 'abc', 'b', 100 ) );
  test.shouldThrowErrorSync( () => _.strLeft( 'abc', 'b', 0, -100 ) );
  test.shouldThrowErrorSync( () => _.strLeft( 'abc', 'b', 0, 100 ) );
  test.shouldThrowErrorSync( () => _.strLeft( /a/, /a+/ ) );
  test.shouldThrowErrorSync( () => _.strLeft( 'abc', /a+/, '' ) );
  test.shouldThrowErrorSync( () => _.strLeft( 'abc' ) );
  test.shouldThrowErrorSync( () => _.strLeft( '123', 1 ) );
  test.shouldThrowErrorSync( () => _.strLeft( '123', [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.strLeft() );

  test.close( 'throwing' );

}

//

function strRight( test )
{

  /* - */

  test.open( 'string' );

  /* - */

  test.case = 'begin';

  var expected = { index : 3, entry : 'aa' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', 'aa' );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = { index : 9, entry : 'bb' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', 'bb' );
  test.identical( got, expected );

  test.case = 'end';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', 'cc' );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = { index : 9, entry : 'bb' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = { index : 9, entry : 'bb' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = { index : 15, entry : 'cc' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = { index : 15, entry : 'cc' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ { index : 15, entry : 'cc' }, { index : 9, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = [ { index : 15, entry : 'cc' }, { index : 9, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ { index : 15, entry : 'cc' }, { index : 3, entry : 'cc' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = [ { index : 15, entry : 'cc' }, { index : 3, entry : 'cc' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'with window';

  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -15 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -10 );
  test.identical( got, expected );
  var expected = [ { index : -1, entry : undefined }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -1 );
  test.identical( got, expected );
  var expected = [ { index : -1, entry : undefined }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -2 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 1 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 3 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 6 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 7 );
  test.identical( got, expected );
  var expected = [ { index : -1, entry : undefined }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 10 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17, -15 );
  test.identical( got, expected );
  var expected = [ { index : -1, entry : undefined }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17, -16 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17, -10 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -17, -9 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -15, -12 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -15, -9 );
  test.identical( got, expected );
  var expected = [ { index : -1, entry : undefined }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], -2, 17 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, 2 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 1, 7 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 1, 8 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, -15 );
  test.identical( got, expected );
  var expected = [ { index : -1, entry : undefined }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, -16 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, -10 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, -9 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, -12 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, 17 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, 2 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, 7 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], undefined, 8 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, -15 );
  test.identical( got, expected );
  var expected = [ { index : -1, entry : undefined }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, -16 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, -10 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, -9 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, -12 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, 17 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, 2 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, 7 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], 0, 8 );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = { index : -1, entry : undefined }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = { index : -1, entry : undefined }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', 'dd' );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = { index : 17, entry : '' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', '' );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = { index : 0, entry : '' }
  var got = _.strRight( '', '' );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = { index : -1, entry : undefined }
  var got = _.strRight( '', 'aa' );
  test.identical( got, expected );

  /* - */

  test.close( 'string' );
  test.open( 'regexp' );

  /* - */

  test.case = 'begin';

  var expected = { index : 3, entry : 'aa' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', /a+/ );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = { index : 9, entry : 'bb' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', /b+/ );
  test.identical( got, expected );

  test.case = 'end';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', /c+/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin smeared';

  var expected = { index : 7, entry : 'ax' }
  var got = _.strRight( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /a\w/ );
  test.identical( got, expected );

  test.case = 'middle smeared';

  var expected = { index : 17, entry : 'bx' }
  var got = _.strRight( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /b\w/ );
  test.identical( got, expected );

  test.case = 'end ';

  var expected = { index : 27, entry : 'cx' }
  var got = _.strRight( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = { index : 9, entry : 'bb' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = { index : 9, entry : 'bb' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = { index : 15, entry : 'cc' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = { index : 15, entry : 'cc' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ { index : 15, entry : 'cc' }, { index : 9, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 15, entry : 'cc' }, { index : 9, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ { index : 15, entry : 'cc' }, { index : 3, entry : 'cc' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 15, entry : 'cc' }, { index : 3, entry : 'cc' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'with window, mixed';

  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -17 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -15 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -10 );
  test.identical( got, expected );
  var expected = [ { index : -1, entry : undefined }, { index : 16, entry : 'a' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -1 );
  test.identical( got, expected );
  var expected = [ { index : -1, entry : undefined }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -2 );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' }, { index : 15, entry : 'aa' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 0 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], -17, -15 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 0, 2 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 1, 7 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 1, 8 );
  test.identical( got, expected );

  var expected = [ { index : 0, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], undefined, -15 );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'a' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], undefined, -16 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], undefined, 7 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], undefined, 8 );
  test.identical( got, expected );
  var expected = [ { index : 3, entry : 'aa' }, { index : -1, entry : undefined } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 0, 7 );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' }, { index : 6, entry : 'bb' } ];
  var got = _.strRight( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, 'bb' ], 0, 8 );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = { index : -1, entry : undefined }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = { index : -1, entry : undefined }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', /d+/ );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = { index : 17, entry : '' }
  var got = _.strRight( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = { index : 0, entry : '' }
  var got = _.strRight( '', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = { index : -1, entry : undefined }
  var got = _.strRight( '', /a+/ );
  test.identical( got, expected );

  /* - */

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.shouldThrowErrorSync( () => _.strRight( 'abc', 'b', -100 ) );
  test.shouldThrowErrorSync( () => _.strRight( 'abc', 'b', 100 ) );
  test.shouldThrowErrorSync( () => _.strRight( 'abc', 'b', 0, -100 ) );
  test.shouldThrowErrorSync( () => _.strRight( 'abc', 'b', 0, 100 ) );
  test.shouldThrowErrorSync( () => _.strRight( /a/, /a+/ ) );
  test.shouldThrowErrorSync( () => _.strRight( 'abc', /a+/, '' ) );
  test.shouldThrowErrorSync( () => _.strRight( 'abc' ) );
  test.shouldThrowErrorSync( () => _.strRight( '123', 1 ) );
  test.shouldThrowErrorSync( () => _.strRight( '123', [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.strRight() );

  test.close( 'throwing' );

}

//

function strEquivalent( test )
{

  /* - */

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

  /* - */

}

//

function strsEquivalent( test )
{

  /* - */

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

  /* - */

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

  test.open( 'vectors' );

  test.case = 'vector, vector';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = [ 'abc', 'abc', /\w+/, /\w+/ ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'vector, scalar';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'vector, vector';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/g ];
  var src2 = [ 'abc', 'abc', 'abc', /\s+/, /\w/, /\w+/, /\w+/, /\w+/gi ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'vector, vector';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/g ];
  var src2 = [ 'abc', 'abc', 'abc', /\s+/, /\w/, /\w+/, /\w+/, /\w+/g ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'vector, scalar';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/gi ];
  var src2 = 'abc';
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'vector, scalar';
  var src1 = [ 'abd', /\s+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'vector, scalar';
  var src1 = [ /\w+/g, /\w+/gi ];
  var src2 = 'abc';
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abd', /\s+/ ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentAll( src1, src2 );
  test.identical( got, true );

  test.close( 'vectors' );

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

  test.open( 'vectors' );

  test.case = 'vector, vector';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = [ 'abc', 'abc', /\w+/, /\w+/ ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'vector, scalar';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'vector, vector';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/g ];
  var src2 = [ 'abc', 'abc', 'abc', /\s+/, /\w/, /\w+/, /\w+/, /\w+/gi ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'vector, vector';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/g ];
  var src2 = [ 'abc', 'abc', 'abc', /\s+/, /\w/, /\w+/, /\w+/, /\w+/g ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'vector, scalar';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/gi ];
  var src2 = 'abc';
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'vector, scalar';
  var src1 = [ 'abd', /\s+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'vector, scalar';
  var src1 = [ /\w+/g, /\w+/gi ];
  var src2 = 'abc';
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abd', /\s+/ ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentAny( src1, src2 );
  test.identical( got, true );

  test.close( 'vectors' );

}

//

function strsEquivalentNone( test )
{

  /* - */

  test.open( 'scalar, not true' );

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

  test.close( 'scalar, not true' );

  /* - */

  test.open( 'scalar, not false' );

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

  test.close( 'scalar, not false' );

  /* - */

  test.open( 'vectors' );

  test.case = 'vector, vector';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = [ 'abc', 'abc', /\w+/, /\w+/ ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'vector, scalar';
  var src1 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abc', /\w+/, 'abc', /\w+/ ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'vector, vector';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/g ];
  var src2 = [ 'abc', 'abc', 'abc', /\s+/, /\w/, /\w+/, /\w+/, /\w+/gi ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'vector, vector';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/g ];
  var src2 = [ 'abc', 'abc', 'abc', /\s+/, /\w/, /\w+/, /\w+/, /\w+/g ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'vector, scalar';
  var src1 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/gi ];
  var src2 = 'abc';
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'vector, scalar';
  var src1 = [ 'abd', /\s+/ ];
  var src2 = 'abc';
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'vector, scalar';
  var src1 = [ /\w+/g, /\w+/gi ];
  var src2 = 'abc';
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abd', /\s+/, /\w/, 'abc', 'abc', /\w*/, /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ 'abd', /\s+/ ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, true );

  test.case = 'scalar, vector';
  var src1 = 'abc';
  var src2 = [ /\w+/g, /\w+/gi ];
  var got = _.strsEquivalentNone( src1, src2 );
  test.identical( got, false );

  test.close( 'vectors' );

}

//

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

function strIsolateInsideOrNone( test )
{

  /* - */

  test.open( 'string' );

  /* - */

  test.case = 'begin';

  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'aa', 'bb' );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'bb', 'cc' );
  test.identical( got, expected );

  test.case = 'end';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'cc', 'dd' );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'cc', '' );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'aa', 'bb' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'cc' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'bb' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'dd' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ], [ '', '' ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'cc' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'bb' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'dd' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ], [ '', 'cc', '_cc_bb_bb_aa_aa', '', '' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ], [ '', '' ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [], [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'dd', 'dd' );
  test.identical( got, expected );

  test.case = 'not found begin';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', 'dd', '' );
  test.identical( got, expected );

  test.case = 'not found end';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', '', 'dd' );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', '', '' );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = [ '', '', '', '', '' ];
  var got = _.strIsolateInsideOrNone( '', '', '' );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( '', 'aa', 'bb' );
  test.identical( got, expected );

  /* - */

  test.close( 'string' );
  test.open( 'regexp' );

  /* */

  test.case = 'begin smeared';

  var expected = [ 'x', 'aa', 'x_xaax_xbbx_xb', 'bx', '_xccx_xccx' ];
  var got = _.strIsolateInsideOrNone( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /a\w/, /b\w/ );
  test.identical( got, expected );

  test.case = 'middle smeared';

  var expected = [ 'xaax_xaax_x', 'bb', 'x_xbbx_xccx_xc', 'cx', '' ];
  var got = _.strIsolateInsideOrNone( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /b\w/, /c\w/ );
  test.identical( got, expected );

  test.case = 'end smeared';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/, /d\w/ );
  test.identical( got, expected );
  var expected = [ 'xaax_xaax_xbbx_xbbx_x', 'cc', 'x_xccx', '', '' ];
  var got = _.strIsolateInsideOrNone( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/, new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'begin';

  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /a+/, /b+/ );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /b+/, /c+/ );
  test.identical( got, expected );

  test.case = 'end';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /c+/, /d+/ );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /c+/, new RegExp( '' ) );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /a+/, /b+/ ], [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /b+/, /a+/ ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /b+/, /c+/ ], [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /c+/, /b+/ ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /c+/, /d+/ ], [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ], [ /d+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ], [ new RegExp( '' ), new RegExp( '' ) ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, /b+/ ], [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /a+/ ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /c+/ ], [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /b+/ ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /d+/ ], [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ], [ /d+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ], [ '', 'cc', '_cc_bb_bb_aa_aa', '', '' ] ];
  var got = _.strIsolateInsideOrNone( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ], [ new RegExp( '' ), new RegExp( '' ) ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', [], [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /d+/, /d+/ );
  test.identical( got, expected );

  test.case = 'not found begin';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', /d+/, new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'not found end';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ), /d+/ );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrNone( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ), new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = [ '', '', '', '', '' ];
  var got = _.strIsolateInsideOrNone( '', new RegExp( '' ), new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = undefined;
  var got = _.strIsolateInsideOrNone( '', /a+/, /b+/ );
  test.identical( got, expected );

  /* - */

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strIsolateInsideOrNone() );
  test.shouldThrowError( () => _.strIsolateInsideOrNone( '' ) );
  test.shouldThrowError( () => _.strIsolateInsideOrNone( '', '' ) );
  test.shouldThrowError( () => _.strIsolateInsideOrNone( '', '', '', '' ) );
  test.shouldThrowError( () => _.strIsolateInsideOrNone( 1, '', '' ) );
  test.shouldThrowError( () => _.strIsolateInsideOrNone( '123', 1, '' ) );
  test.shouldThrowError( () => _.strIsolateInsideOrNone( '123', '', 3 ) );

}

//

function strIsolateInsideOrAll( test )
{

  /* - */

  test.open( 'string' );

  /* - */

  test.case = 'begin';

  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', 'aa', 'bb' );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', 'bb', 'cc' );
  test.identical( got, expected );

  test.case = 'end';

  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', 'cc', 'dd' );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', 'cc', '' );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ 'aa', 'bb' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'cc' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'bb' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'dd' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ], [ '', '' ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'cc' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'bb' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'dd' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ], [ '', 'cc', '_cc_bb_bb_aa_aa', '', '' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ], [ '', '' ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [], [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', 'dd', 'dd' );
  test.identical( got, expected );

  test.case = 'not found begin';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', 'dd', '' );
  test.identical( got, expected );

  test.case = 'not found end';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', '', 'dd' );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', '', '' );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = [ '', '', '', '', '' ];
  var got = _.strIsolateInsideOrAll( '', '', '' );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = [ '', '', '', '', '' ];
  var got = _.strIsolateInsideOrAll( '', 'aa', 'bb' );
  test.identical( got, expected );

  /* - */

  test.close( 'string' );
  test.open( 'regexp' );

  /* */

  test.case = 'begin smeared';

  var expected = [ 'x', 'aa', 'x_xaax_xbbx_xb', 'bx', '_xccx_xccx' ];
  var got = _.strIsolateInsideOrAll( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /a\w/, /b\w/ );
  test.identical( got, expected );

  test.case = 'middle smeared';

  var expected = [ 'xaax_xaax_x', 'bb', 'x_xbbx_xccx_xc', 'cx', '' ];
  var got = _.strIsolateInsideOrAll( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /b\w/, /c\w/ );
  test.identical( got, expected );

  test.case = 'end smeared';

  var expected = [ 'xaax_xaax_xbbx_xbbx_x', 'cc', 'x_xccx', '', '' ];
  var got = _.strIsolateInsideOrAll( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/, /d\w/ );
  test.identical( got, expected );
  var expected = [ 'xaax_xaax_xbbx_xbbx_x', 'cc', 'x_xccx', '', '' ];
  var got = _.strIsolateInsideOrAll( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/, new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'begin';

  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', /a+/, /b+/ );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', /b+/, /c+/ );
  test.identical( got, expected );

  test.case = 'end';

  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', /c+/, /d+/ );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', /c+/, new RegExp( '' ) );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ /a+/, /b+/ ], [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ /b+/, /a+/ ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ /b+/, /c+/ ], [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ /c+/, /b+/ ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ /c+/, /d+/ ], [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ], [ /d+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ], [ new RegExp( '' ), new RegExp( '' ) ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, /b+/ ], [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = [ [ '', 'aa', '_aa_bb_', 'bb', '_cc_cc' ], [ 'cc_cc_', 'bb', '_bb_aa_', 'aa', '' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /a+/ ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /c+/ ], [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_', 'bb', '_bb_cc_', 'cc', '' ], [ '', 'cc', '_cc_bb_', 'bb', '_aa_aa' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /b+/ ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /d+/ ], [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_', 'cc', '' ], [ '', 'cc', '_', 'cc', '_bb_bb_aa_aa' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ], [ /d+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ [ 'aa_aa_bb_bb_', 'cc', '_cc', '', '' ], [ '', 'cc', '_cc_bb_bb_aa_aa', '', '' ] ];
  var got = _.strIsolateInsideOrAll( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ], [ new RegExp( '' ), new RegExp( '' ) ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', [], [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', /d+/, /d+/ );
  test.identical( got, expected );

  test.case = 'not found begin';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', /d+/, new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'not found end';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ), /d+/ );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = [ '', '', 'aa_aa_bb_bb_cc_cc', '', '' ];
  var got = _.strIsolateInsideOrAll( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ), new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = [ '', '', '', '', '' ];
  var got = _.strIsolateInsideOrAll( '', new RegExp( '' ), new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = [ '', '', '', '', '' ];
  var got = _.strIsolateInsideOrAll( '', /a+/, /b+/ );
  test.identical( got, expected );

  /* - */

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strIsolateInsideOrAll() );
  test.shouldThrowError( () => _.strIsolateInsideOrAll( '' ) );
  test.shouldThrowError( () => _.strIsolateInsideOrAll( '', '' ) );
  test.shouldThrowError( () => _.strIsolateInsideOrAll( '', '', '', '' ) );
  test.shouldThrowError( () => _.strIsolateInsideOrAll( 1, '', '' ) );
  test.shouldThrowError( () => _.strIsolateInsideOrAll( '123', 1, '' ) );
  test.shouldThrowError( () => _.strIsolateInsideOrAll( '123', '', 3 ) );

}

//

function strBeginOf( test )
{
  var got, expected;

  /**/

  test.case = 'strBeginOf';

  /**/

  got = _.strBeginOf( 'abc', '' );
  expected = '';
  test.identical( got, expected )

  /**/

  got = _.strBeginOf( 'abc', 'c' );
  expected = false;
  test.identical( got, expected )

  /**/

  got = _.strBeginOf( 'abc', 'bc' );
  expected = false;
  test.identical( got, expected )

  /**/

  got = _.strBeginOf( 'abc', ' c' );
  expected = false;
  test.identical( got, expected )

  /* end.length > src.length */

  got = _.strBeginOf( 'abc', 'abcd' );
  expected = false;
  test.identical( got, expected )

  /* same length, not equal*/

  got = _.strBeginOf( 'abc', 'cba' );
  expected = false;
  test.identical( got, expected )

  /* equal */

  got = _.strBeginOf( 'abc', 'abc' );
  expected = 'abc';
  test.identical( got, expected )

  /* array */

  got = _.strBeginOf( 'abc', [] );
  expected = false;
  test.identical( got, expected )

  /**/

  got = _.strBeginOf( 'abc', [ '' ] );
  expected = '';
  test.identical( got, expected )

  /**/

  got = _.strBeginOf( 'abccc', [ 'c', 'ccc' ] );
  expected = false;
  test.identical( got, expected )

  /**/

  got = _.strBeginOf( 'abc', [ 'a', 'ab', 'abc' ] );
  expected = 'a';
  test.identical( got, expected )

  /**/

  got = _.strBeginOf( 'abc', [ 'x', 'y', 'c' ] );
  expected = false;
  test.identical( got, expected )

  /**/

  got = _.strBeginOf( 'abc', [ 'x', 'y', 'z' ] );
  expected = false;
  test.identical( got, expected )

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strBeginOf( 1, '' ) );
  test.shouldThrowError( () => _.strBeginOf( 'abc', 1 ) );
  test.shouldThrowError( () => _.strBeginOf() );
  test.shouldThrowError( () => _.strBeginOf( undefined, undefined ) );
  test.shouldThrowError( () => _.strBeginOf( null, null ) );
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

  test.shouldThrowError( () => _.strEndOf( 1, '' ) );
  test.shouldThrowError( () => _.strEndOf( 'abc', 1 ) );
  test.shouldThrowError( () => _.strEndOf() );
  test.shouldThrowError( () => _.strEndOf( undefined, undefined ) );
  test.shouldThrowError( () => _.strEndOf( null, null ) );

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

  test.shouldThrowError( () => _.strBegins( 1, '' ) );
  test.shouldThrowError( () => _.strBegins( 'a', 1 ) );
  test.shouldThrowError( () => _.strBegins( 'abc', [ 1, 'b', 'a' ] ) );

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

  test.shouldThrowError( () => _.strEnds( 1, '' ) );
  test.shouldThrowError( () => _.strEnds( 'a', 1 ) );
}

//

var Self =
{

  name : 'Tools/base/l1/String',
  silencing : 1,

  tests :
  {

    strLeft,
    strRight,

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

    strIsolateLeftOrNone,
    strIsolateLeftOrAll,
    strIsolateRightOrNone,
    strIsolateRightOrAll,
    strIsolateInsideOrNone,
    strIsolateInsideOrAll,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
