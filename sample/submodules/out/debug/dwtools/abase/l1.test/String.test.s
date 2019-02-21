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

function strFirst( test )
{

  /* - */

  test.open( 'string' );

  /* - */

  test.case = 'begin';

  var expected = { index : 0, entry : 'aa' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', 'aa' );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = { index : 6, entry : 'bb' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', 'bb' );
  test.identical( got, expected );

  test.case = 'end';

  var expected = { index : 12, entry : 'cc' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', 'cc' );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = { index : 0, entry : 'aa' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = { index : 0, entry : 'aa' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = { index : 6, entry : 'bb' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = { index : 6, entry : 'bb' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = { index : 12, entry : 'cc' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = { index : 12, entry : 'cc' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ { index : 0, entry : 'aa' },{ index : 6, entry : 'bb' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' },{ index : 6, entry : 'bb' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ { index : 6, entry : 'bb' },{ index : 0, entry : 'cc' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' },{ index : 0, entry : 'cc' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ { index : 12, entry : 'cc' },{ index : 0, entry : 'cc' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = [ { index : 12, entry : 'cc' },{ index : 0, entry : 'cc' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = { index : 17, entry : undefined }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = { index : 17, entry : undefined }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', 'dd' );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = { index : 0, entry : '' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', '' );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = { index : 0, entry : '' }
  var got = _.strFirst( '', '' );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = { index : 0, entry : undefined }
  var got = _.strFirst( '', 'aa' );
  test.identical( got, expected );

  /* - */

  test.close( 'string' );
  test.open( 'regexp' );

  /* - */

  test.case = 'begin';

  var expected = { index : 0, entry : 'aa' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', /a+/ );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = { index : 6, entry : 'bb' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', /b+/ );
  test.identical( got, expected );

  test.case = 'end';

  var expected = { index : 12, entry : 'cc' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', /c+/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin smeared';

  var expected = { index : 0, entry : 'xa' }
  var got = _.strFirst( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /\wa/ );
  test.identical( got, expected );

  test.case = 'middle smeared';

  var expected = { index : 10, entry : 'xb' }
  var got = _.strFirst( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /\wb/ );
  test.identical( got, expected );

  test.case = 'end ';

  var expected = { index : 20, entry : 'xc' }
  var got = _.strFirst( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /\wc/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = { index : 0, entry : 'aa' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = { index : 0, entry : 'aa' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = { index : 6, entry : 'bb' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = { index : 6, entry : 'bb' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = { index : 12, entry : 'cc' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = { index : 12, entry : 'cc' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ { index : 0, entry : 'aa' },{ index : 6, entry : 'bb' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 0, entry : 'aa' },{ index : 6, entry : 'bb' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ { index : 6, entry : 'bb' },{ index : 0, entry : 'cc' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 6, entry : 'bb' },{ index : 0, entry : 'cc' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ { index : 12, entry : 'cc' },{ index : 0, entry : 'cc' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 12, entry : 'cc' },{ index : 0, entry : 'cc' } ];
  var got = _.strFirst( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = { index : 17, entry : undefined }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = { index : 17, entry : undefined }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', /d+/ );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = { index : 0, entry : '' }
  var got = _.strFirst( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = { index : 0, entry : '' }
  var got = _.strFirst( '', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = { index : 0, entry : undefined }
  var got = _.strFirst( '', /a+/ );
  test.identical( got, expected );

  /* - */

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.shouldThrowErrorSync( () => _.strFirst( /a/, /a+/ ) );
  test.shouldThrowErrorSync( () => _.strFirst( 'abc', /a+/, '' ) );
  test.shouldThrowErrorSync( () => _.strFirst( 'abc' ) );
  test.shouldThrowErrorSync( () => _.strFirst( '123', 1 ) );
  test.shouldThrowErrorSync( () => _.strFirst( '123', [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.strFirst() );

  test.close( 'throwing' );

}

//

function strLast( test )
{

  /* - */

  test.open( 'string' );

  /* - */

  test.case = 'begin';

  var expected = { index : 3, entry : 'aa' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', 'aa' );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = { index : 9, entry : 'bb' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', 'bb' );
  test.identical( got, expected );

  test.case = 'end';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', 'cc' );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = { index : 9, entry : 'bb' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = { index : 9, entry : 'bb' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = { index : 15, entry : 'cc' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = { index : 15, entry : 'cc' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ { index : 9, entry : 'bb' },{ index : 15, entry : 'aa' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'aa', 'bb' ] );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' },{ index : 15, entry : 'aa' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'aa' ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ { index : 15, entry : 'cc' },{ index : 9, entry : 'bb' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'bb', 'cc' ] );
  test.identical( got, expected );
  var expected = [ { index : 15, entry : 'cc' },{ index : 9, entry : 'bb' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'bb' ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ { index : 15, entry : 'cc' },{ index : 3, entry : 'cc' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'cc', 'dd' ] );
  test.identical( got, expected );
  var expected = [ { index : 15, entry : 'cc' },{ index : 3, entry : 'cc' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ 'dd', 'cc' ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = { index : -1, entry : undefined }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = { index : -1, entry : undefined }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', 'dd' );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = { index : 17, entry : '' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', '' );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = { index : 0, entry : '' }
  var got = _.strLast( '', '' );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = { index : -1, entry : undefined }
  var got = _.strLast( '', 'aa' );
  test.identical( got, expected );

  /* - */

  test.close( 'string' );
  test.open( 'regexp' );

  /* - */

  test.case = 'begin';

  var expected = { index : 3, entry : 'aa' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', /a+/ );
  test.identical( got, expected );

  test.case = 'middle';

  var expected = { index : 9, entry : 'bb' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', /b+/ );
  test.identical( got, expected );

  test.case = 'end';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', /c+/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin smeared';

  var expected = { index : 7, entry : 'ax' }
  var got = _.strLast( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /a\w/ );
  test.identical( got, expected );

  test.case = 'middle smeared';

  var expected = { index : 17, entry : 'bx' }
  var got = _.strLast( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /b\w/ );
  test.identical( got, expected );

  test.case = 'end ';

  var expected = { index : 27, entry : 'cx' }
  var got = _.strLast( 'xaax_xaax_xbbx_xbbx_xccx_xccx', /c\w/ );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry';

  var expected = { index : 9, entry : 'bb' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = { index : 9, entry : 'bb' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = { index : 15, entry : 'cc' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry';

  var expected = { index : 15, entry : 'cc' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = { index : 15, entry : 'cc' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'begin, several entry, several sources';

  var expected = [ { index : 9, entry : 'bb' },{ index : 15, entry : 'aa' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /a+/, /b+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 9, entry : 'bb' },{ index : 15, entry : 'aa' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /a+/ ] );
  test.identical( got, expected );

  test.case = 'middle, several entry, several sources';

  var expected = [ { index : 15, entry : 'cc' },{ index : 9, entry : 'bb' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /b+/, /c+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 15, entry : 'cc' },{ index : 9, entry : 'bb' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /b+/ ] );
  test.identical( got, expected );

  test.case = 'end, several entry, several sources';

  var expected = [ { index : 15, entry : 'cc' },{ index : 3, entry : 'cc' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /c+/, /d+/ ] );
  test.identical( got, expected );
  var expected = [ { index : 15, entry : 'cc' },{ index : 3, entry : 'cc' } ];
  var got = _.strLast( [ 'aa_aa_bb_bb_cc_cc', 'cc_cc_bb_bb_aa_aa' ], [ /d+/, /c+/ ] );
  test.identical( got, expected );

  /* */

  test.case = 'no entry';

  var expected = { index : -1, entry : undefined }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', [] );
  test.identical( got, expected );

  test.case = 'not found';

  var expected = { index : -1, entry : undefined }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', /d+/ );
  test.identical( got, expected );

  test.case = 'empty entry';

  var expected = { index : 17, entry : '' }
  var got = _.strLast( 'aa_aa_bb_bb_cc_cc', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty entry, empty src';

  var expected = { index : 0, entry : '' }
  var got = _.strLast( '', new RegExp( '' ) );
  test.identical( got, expected );

  test.case = 'empty src';

  var expected = { index : -1, entry : undefined }
  var got = _.strLast( '', /a+/ );
  test.identical( got, expected );

  /* - */

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.shouldThrowErrorSync( () => _.strLast( /a/, /a+/ ) );
  test.shouldThrowErrorSync( () => _.strLast( 'abc', /a+/, '' ) );
  test.shouldThrowErrorSync( () => _.strLast( 'abc' ) );
  test.shouldThrowErrorSync( () => _.strLast( '123', 1 ) );
  test.shouldThrowErrorSync( () => _.strLast( '123', [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.strLast() );

  test.close( 'throwing' );

}

//

function strIsolateBeginOrNone( test )
{
  var got,expected;

  /* - */

  test.case = 'single delimeter';

  /**/

  got = _.strIsolateBeginOrNone( '', '' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( '', [ '' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abc', [ '' ] );
  expected = [ '', '', 'abc' ];
  test.identical( got, expected );

  /* empty delimeters array */

  got = _.strIsolateBeginOrNone( 'abca', [] );
  expected = [ '', '', 'abca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( '', 'a' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( '', [ 'a' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abca', 'a' );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abca', [ 'a' ] );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strIsolateBeginOrNone( 'abca', 'd' );
  expected = [ '', '', 'abca' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strIsolateBeginOrNone( 'abca', [ 'd' ] );
  expected = [ '', '', 'abca' ];
  test.identical( got, expected );

  /* - */

  test.case = 'single delimeter, number';

  got = _.strIsolateBeginOrNone( 'abca', '', 2 );
  expected = [ 'a', '', 'bca' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strIsolateBeginOrNone( 'abca', 'a', 2 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strIsolateBeginOrNone( 'abca', [ 'a' ], 2 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strIsolateBeginOrNone( 'abcaca', 'a', 3 );
  expected = [ 'abcac', 'a', '' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strIsolateBeginOrNone( 'abcaca', [ 'a' ], 3 );
  expected = [ 'abcac', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abcaca', 'a', 4 );
  expected = [ 'abcaca', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abcaca', [ 'a' ], 4 );
  expected = [ 'abcaca', 'a', '' ];
  test.identical( got, expected );

  /* - */

  test.case = 'several delimeters';

  /**/

  got = _.strIsolateBeginOrNone( 'abca', [ 'a', 'c' ] );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abca', [ 'c', 'a' ] );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abca', [ 'x', 'y' ] );
  expected = [ '', '', 'abca'  ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abca', [ 'x', 'y', 'a' ] );
  expected = [ '', 'a', 'bca'  ];
  test.identical( got, expected );

  /* - */

  test.case = 'several delimeters, number';

  /* empty delimeters array */

  got = _.strIsolateBeginOrNone( 'abca', [], 2 );
  expected = [ '', '', 'abca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abca', [ 'a', 'c' ], 2 );
  expected = [ 'ab', 'c', 'a' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abcbc', [ 'c', 'a' ], 2 );
  expected = [ 'ab', 'c', 'bc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'cbcbc', [ 'c', 'a' ], 3 );
  expected = [ 'cbcb', 'c', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'cbcbc', [ 'c', 'a' ], 4 );
  expected = [ 'cbcbc', 'c', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'jj', [ 'c', 'a' ], 4 );
  expected = [ 'jj', 'c', ''];
  test.identical( got, expected );

  /* - */

  test.case = 'one of delimeters contains other';

  /* - */

  got = _.strIsolateBeginOrNone( 'ab', [ 'a', 'ab' ] );
  expected = [ '', 'a', 'b' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'ab', [ 'ab', 'a' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'ab', [ 'b', 'ab' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'ab', [ 'ab', 'b' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateBeginOrNone( 'a b c', ' ', 1 );
  expected = [ 'a', ' ', 'b c' ];
  test.identical( got, expected );

  /* - */

  test.case = 'single delimeter'

  /* cut on first appear */

  got = _.strIsolateBeginOrNone( 'abca', 'a', 1 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got ,expected );

  /* no occurrences */

  got = _.strIsolateBeginOrNone( 'jj', 'a', 1 );
  expected = [ '', '', 'jj'];
  test.identical( got ,expected );

  /* cut on second appear */

  got = _.strIsolateBeginOrNone( 'abca', 'a', 2 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got ,expected );

  /* 5 attempts */

  got = _.strIsolateBeginOrNone( 'abca', 'a', 5 );
  expected = [ 'abca', 'a', '' ];
  test.identical( got ,expected );

  /* - */

  test.case = 'multiple delimeter'

  /**/

  got = _.strIsolateBeginOrNone( 'abca', [ 'a', 'c' ], 1 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got ,expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abca', [ 'a', 'c' ], 2 );
  expected = [ 'ab', 'c', 'a' ];
  test.identical( got ,expected );

  /**/

  got = _.strIsolateBeginOrNone( 'abca', [ 'a', 'c' ], 3 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got ,expected );

  /* no occurrences */

  got = _.strIsolateBeginOrNone( 'jj', [ 'a', 'c' ], 1 );
  expected = [ '', '', 'jj' ];
  test.identical( got ,expected );

  /* no occurrences */

  got = _.strIsolateBeginOrNone( 'jj', [ 'a' ], 1 );
  expected = [ '', '', 'jj' ];
  test.identical( got ,expected );

  /* - */

  test.case = 'options as map';

  /**/

  got = _.strIsolateBeginOrNone({ src : 'abca', delimeter : 'a', number : 1 });
  expected = [ '', 'a', 'bca' ];
  test.identical( got ,expected );

  /* number option is missing */

  got = _.strIsolateBeginOrNone({ src : 'abca', delimeter : 'a' });
  expected = [ '', 'a', 'bca' ];
  test.identical( got ,expected );

  /* - */

  test.case = 'number option check';

  /* number is zero */

  got = _.strIsolateBeginOrNone( 'abca', 'a', 0 );
  expected = [ '', '', 'abca' ];
  test.identical( got ,expected );

  /* number is negative */

  got = _.strIsolateBeginOrNone( 'abca', 'a', -1 );
  expected = [ '', '', 'abca' ];
  test.identical( got ,expected );

  if( !Config.debug )
  return;

  test.case = 'single argument but object expected';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateBeginOrNone( 'abc' );
  })

  test.case = 'invalid option';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateBeginOrNone({ src : 'abc', delimeter : 'a', query : 'a' });
  })

  test.case = 'changing of left option not allowed';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateBeginOrNone({ src : 'abc', delimeter : 'a', left : 0 });
  })

}

//

function strIsolateEndOrNone( test )
{
  var got,expected;

  /* - */

  test.case = 'single delimeter';

  /**/

  got = _.strIsolateEndOrNone( '', '' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( '', [ '' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /*!!!*/

  got = _.strIsolateEndOrNone( 'abc', [ '' ] );
  expected = [ 'ab', '', 'c' ];
  test.identical( got, expected );

  /* empty delimeters array */

  got = _.strIsolateEndOrNone( 'abca', [] );
  expected = [ 'abca', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( '', 'a' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( '', [ 'a' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'abca', 'a' );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'abca', [ 'a' ] );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strIsolateEndOrNone( 'abca', 'd' );
  expected = [ 'abca', '', '' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strIsolateEndOrNone( 'abca', [ 'd' ] );
  expected = [ 'abca', '', '' ];
  test.identical( got, expected );

  /* - */

  test.case = 'single delimeter, number';

  /*!!!*/

  got = _.strIsolateEndOrNone( 'abca', '', 2 );
  expected = [ 'ab', '', 'ca' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strIsolateEndOrNone( 'abca', 'a', 2 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strIsolateEndOrNone( 'abca', [ 'a' ], 2 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strIsolateEndOrNone( 'abcaca', 'a', 3 );
  expected = [ '', 'a', 'bcaca' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strIsolateEndOrNone( 'abcaca', [ 'a' ], 3 );
  expected = [ '', 'a', 'bcaca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'abcaca', 'a', 4 );
  expected = [ '', '', 'abcaca' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'abcaca', [ 'a' ], 4 );
  expected = [ '', '', 'abcaca' ];
  test.identical( got, expected );

  /* - */

  test.case = 'several delimeters';

  /**/

  got = _.strIsolateEndOrNone( 'abca', [ 'a', 'c' ] );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'abca', [ 'c', 'a' ] );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'abca', [ 'x', 'y' ] );
  expected = [ 'abca', '', ''  ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'abca', [ 'x', 'y', 'a' ] );
  expected = [ 'abc', 'a', ''  ];
  test.identical( got, expected );

  /* - */

  test.case = 'several delimeters, number';

  /* empty delimeters array */

  got = _.strIsolateEndOrNone( 'abca', [], 2 );
  expected = [ 'abca', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'abca', [ 'a', 'c' ], 2 );
  expected = [ 'ab', 'c', 'a' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'abcbc', [ 'c', 'a' ], 2 );
  expected = [ 'ab', 'c', 'bc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'cbcbc', [ 'c', 'a' ], 3 );
  expected = [ '', 'c', 'bcbc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'cbcbc', [ 'c', 'a' ], 4 );
  expected = [ '', '', 'cbcbc' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'jj', [ 'c', 'a' ], 4 );
  expected = [ '', 'c', 'jj' ];
  test.identical( got, expected );

  /* - */

  test.case = 'one of delimeters contains other';

  /* - */

  got = _.strIsolateEndOrNone( 'ab', [ 'a', 'ab' ] );
  expected = [ '', 'a', 'b' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'ab', [ 'ab', 'a' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'ab', [ 'b', 'ab' ] );
  expected = [ 'a', 'b', '' ];
  test.identical( got, expected );

  /**/

  got = _.strIsolateEndOrNone( 'ab', [ 'ab', 'b' ] );
  expected = [ 'a', 'b', '' ];
  test.identical( got, expected );

  /* - */

  test.case = 'defaults'

  /**/

  got = _.strIsolateEndOrNone( 'a b c', ' ', 1 );
  expected = [ 'a b', ' ', 'c' ];
  test.identical( got, expected );

  /* - */

  test.case = 'single delimeter'

  /* cut on first appear */

  got = _.strIsolateEndOrNone( 'abca', 'a', 1 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got ,expected );

  /* no occurrences */

  got = _.strIsolateEndOrNone( 'jj', 'a', 1 );
  expected = [ 'jj', '', '' ];
  test.identical( got ,expected );

  /* cut on second appear */

  got = _.strIsolateEndOrNone( 'abca', 'a', 2 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got ,expected );

  /**/

  got = _.strIsolateEndOrNone( 'abca', 'a', 5 );
  expected = [ '', '', 'abca' ];
  test.identical( got ,expected );

  /* - */

  test.case = 'multiple delimeter'

  /**/

  got = _.strIsolateEndOrNone( 'abca', [ 'a', 'c' ], 1 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got ,expected );

  /**/

  got = _.strIsolateEndOrNone( 'abca', [ 'a', 'c' ], 2 );
  expected = [ 'ab', 'c', 'a' ];
  test.identical( got ,expected );

  /**/

  got = _.strIsolateEndOrNone( 'abca', [ 'a', 'c' ], 3 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got ,expected );

  /* no occurrences */

  got = _.strIsolateEndOrNone( 'jj', [ 'a', 'c' ], 1 );
  expected = [ 'jj', '', '' ];
  test.identical( got ,expected );

  /* no occurrences */

  got = _.strIsolateEndOrNone( 'jj', [ 'a' ], 1 );
  expected = [ 'jj', '', '' ];
  test.identical( got ,expected );

  /* - */

  test.case = 'options as map';

  /**/

  got = _.strIsolateEndOrNone({ src : 'abca', delimeter : 'a', number : 1 });
  expected = [ 'abc', 'a', '' ];
  test.identical( got ,expected );

  /* number option is missing */

  got = _.strIsolateEndOrNone({ src : 'abca', delimeter : 'a' });
  expected = [ 'abc', 'a', '' ];
  test.identical( got ,expected );

  /* - */

  test.case = 'number option check';

  /* number is zero */

  got = _.strIsolateEndOrNone( 'abca', 'a', 0 );
  expected = [ 'abca', '', '' ];
  test.identical( got ,expected );

  /* number is negative */

  got = _.strIsolateEndOrNone( 'abca', 'a', -1 );
  expected = [ 'abca', '', '' ];
  test.identical( got ,expected );

  if( !Config.debug )
  return;

  test.case = 'single argument but object expected';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateEndOrNone( 'abc' );
  });

  test.case = 'invalid option';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateEndOrNone({ src : 'abc', delimeter : 'a', query : 'a' });
  });

  test.case = 'changing of left option not allowed';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateEndOrNone({ src : 'abc', delimeter : 'a', left : 0 });
  });

}

//

function strIsolateEndOrAll( test )
{
  var got, expected;

  test.case = 'cut in most right position';

  /* nothing */

  got = _.strIsolateEndOrAll( '', 'b' );
  expected = [ '', '', '' ];
  test.identical( got,expected );

  /* nothing */

  got = _.strIsolateEndOrAll( '', '' );
  expected = [ '', '', '' ];
  test.identical( got,expected );

  /**/

  got = _.strIsolateEndOrAll( 'ahpc', 'h' );
  expected = [ 'a', 'h', 'pc' ];
  test.identical( got,expected );

  /**/

  got = _.strIsolateEndOrAll( 'ahpc', 'c' );
  expected = [ 'ahp', 'c', '' ];
  test.identical( got,expected );

  /**/

  got = _.strIsolateEndOrAll( 'appbb', 'b' );
  expected = [ 'appb', 'b', '' ];
  test.identical( got,expected );

  /**/

  got = _.strIsolateEndOrAll( 'jj', 'a' );
  expected = [ '', '', 'jj' ];
  test.identical( got,expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'delimeter must be a String';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateEndOrAll( 'jj', 1 );
  })

  test.case = 'source must be a String';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateEndOrAll( 1, '1' );
  })

}

//

function strIsolateBeginOrAll( test )
{
  var got, expected;

  test.case = 'cut in most left position';

  /* nothing */

  got = _.strIsolateBeginOrAll( '', 'b' );
  expected = [ '', '', '' ];
  test.identical( got,expected );

  /* nothing */

  got = _.strIsolateBeginOrAll( '', '' );
  expected = [ '', '', '' ];
  test.identical( got,expected );

  /**/

  got = _.strIsolateBeginOrAll( 'appc', 'p' );
  expected = [ 'a', 'p', 'pc' ];
  test.identical( got,expected );

  /**/

  got = _.strIsolateBeginOrAll( 'appc', 'c' );
  expected = [ 'app', 'c', '' ];
  test.identical( got,expected );

  /**/

  got = _.strIsolateBeginOrAll( 'appc', 'a' );
  expected = [ '', 'a', 'ppc' ];
  test.identical( got,expected );

  /**/

  got = _.strIsolateBeginOrAll( 'jj', 'a' );
  expected = [ 'jj', '', '' ];
  test.identical( got,expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'delimeter must be a String';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateBeginOrAll( 'jj', 1 );
  });

  test.case = 'source must be a String';
  test.shouldThrowErrorSync( function()
  {
    _.strIsolateBeginOrAll( 1, '1' );
  });

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
  var got,expected;

  /**/

  test.case = 'strBeginOf';

  /**/

  got = _.strBeginOf( 'abc', '' );
  expected = '';
  test.identical( got,expected )

  /**/

  got = _.strBeginOf( 'abc', 'c' );
  expected = false;
  test.identical( got,expected )

  /**/

  got = _.strBeginOf( 'abc', 'bc' );
  expected = false;
  test.identical( got,expected )

  /**/

  got = _.strBeginOf( 'abc', ' c' );
  expected = false;
  test.identical( got,expected )

  /* end.length > src.length */

  got = _.strBeginOf( 'abc', 'abcd' );
  expected = false;
  test.identical( got,expected )

  /* same length, not equal*/

  got = _.strBeginOf( 'abc', 'cba' );
  expected = false;
  test.identical( got,expected )

  /* equal */

  got = _.strBeginOf( 'abc', 'abc' );
  expected = 'abc';
  test.identical( got,expected )

  /* array */

  got = _.strBeginOf( 'abc', [] );
  expected = false;
  test.identical( got,expected )

  /**/

  got = _.strBeginOf( 'abc', [ '' ] );
  expected = '';
  test.identical( got,expected )

  /**/

  got = _.strBeginOf( 'abccc', [ 'c', 'ccc' ] );
  expected = false;
  test.identical( got,expected )

  /**/

  got = _.strBeginOf( 'abc', [ 'a', 'ab', 'abc' ] );
  expected = 'a';
  test.identical( got,expected )

  /**/

  got = _.strBeginOf( 'abc', [ 'x', 'y', 'c' ] );
  expected = false;
  test.identical( got,expected )

  /**/

  got = _.strBeginOf( 'abc', [ 'x', 'y', 'z' ] );
  expected = false;
  test.identical( got,expected )

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
  var got,expected;

  //

  test.case = 'strEndOf';

  /**/

  got = _.strEndOf( 'abc', '' );
  expected = '';
  test.identical( got,expected )

  /**/

  got = _.strEndOf( 'abc', 'a' );
  expected = false;
  test.identical( got,expected )

  /**/

  got = _.strEndOf( 'abc', 'ab' );
  expected = false;
  test.identical( got,expected )

  /**/

  got = _.strEndOf( 'abc', ' a' );
  expected = false;
  test.identical( got,expected )

  /* end.length > src.length */

  got = _.strEndOf( 'abc', 'abcd' );
  expected = false;
  test.identical( got,expected )

  /* same length */

  got = _.strEndOf( 'abc', 'cba' );
  expected = false;
  test.identical( got,expected )

  /* equal */

  got = _.strEndOf( 'abc', 'abc' );
  expected = 'abc';
  test.identical( got,expected )

  /* array */

  got = _.strEndOf( 'abc', [] );
  expected = false;
  test.identical( got,expected )

  /**/

  got = _.strEndOf( 'abc', [ '' ] );
  expected = '';
  test.identical( got,expected )

  /**/

  got = _.strEndOf( 'abccc', [ 'a', 'ab' ] );
  expected = false;
  test.identical( got,expected )

  /**/

  got = _.strEndOf( 'abc', [ 'ab', 'abc' ] );
  expected = 'abc';
  test.identical( got,expected )

  /**/

  got = _.strEndOf( 'abc', [ 'x', 'y', 'a' ] );
  expected = false;
  test.identical( got,expected )

  /**/

  got = _.strEndOf( 'abc', [ 'x', 'y', 'z' ] );
  expected = false;
  test.identical( got,expected )

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

    strFirst : strFirst,
    strLast : strLast,

    strIsolateBeginOrNone : strIsolateBeginOrNone,
    strIsolateEndOrNone : strIsolateEndOrNone,
    strIsolateEndOrAll : strIsolateEndOrAll,
    strIsolateBeginOrAll : strIsolateBeginOrAll,
    strIsolateInsideOrNone : strIsolateInsideOrNone,
    strIsolateInsideOrAll : strIsolateInsideOrAll,

    strBeginOf : strBeginOf,
    strEndOf : strEndOf,

    strBegins : strBegins,
    strEnds : strEnds,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
