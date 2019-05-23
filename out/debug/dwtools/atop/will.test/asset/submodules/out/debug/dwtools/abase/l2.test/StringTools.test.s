( function _StringTools_test_s_() {

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

function strRemoveBegin( test )
{
  var got, expected;

  /* - */

  test.case = 'returns string with removed occurrence from start';
  var got = _.strRemoveBegin( 'example','exa' );
  var expected = 'mple';
  test.identical( got, expected );

  test.case = 'returns original if no occurrence found';
  var got = _.strRemoveBegin( 'mple','exa' );
  var expected = 'mple';
  test.identical( got, expected );

  test.case = 'returns original if occurence is not at the beginning';
  var got = _.strRemoveBegin( 'example','ple' );
  var expected = 'example';
  test.identical( got, expected );

  /* - */

  test.case = 'other';

  /**/

  got = _.strRemoveBegin( '', '' );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( '', 'x' );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'abc', 'a' );
  expected = 'bc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'abc', 'ab' );
  expected = 'c';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'abc', 'x' );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'abc', 'abc' );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'abc', '' );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'abc', [ 'a', 'b', 'c' ] );
  expected = 'bc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'abc', [ 'b', 'c', 'a' ] );
  expected = 'bc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'aabbcc', [ 'a', 'b', 'c' ] );
  expected = 'abbcc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'abcabc', [ 'a', 'b', 'c' ] );
  expected = 'bcabc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'abc', [ '', 'a' ] );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'abc', [ 'abc', 'a' ] );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], [ 'a', 'd' ] );
  expected = [ 'bc', 'bca', 'cab' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( [ 'abc', 'bca', 'cab' ], [ 'a', 'b', 'c' ] );
  expected = [ 'bc', 'ca', 'ab' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( [ 'abcabc', 'bcabca', 'cabcab' ], [ 'a', 'b', 'c' ] );
  expected = [ 'bcabc', 'cabca', 'abcab' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( [ 'abcabc', 'bcabca', 'cabcab' ], [ 'b', 'c', 'a' ] );
  expected = [ 'bcabc', 'cabca', 'abcab' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( [ 'a', 'b', 'c' ], [ 'x' ] );
  expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( [ 'a', 'b', 'c' ], [ 'a', 'b', 'c' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( [ 'a', 'b', 'c' ], [ ] );
  expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  /* - */

  test.case = 'RegExp';

  /**/

  got = _.strRemoveBegin( 'example', /ex/ );
  expected = 'ample';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( [ 'example', 'examplex' ] , /ex\z/ );
  expected = [ 'example', 'examplex' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( [ 'example', '1example', 'example2', 'exam3ple' ], /\d/ );
  expected = [ 'example', 'example', 'example2', 'exam3ple' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'example', [ /am/ ] );
  expected = 'example';
  test.identical( got, expected );


  /**/

  got = _.strRemoveBegin( 'example', [ /ex/, /\w/ ] );
  expected = 'ample';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'example', [ /\w/, /ex/ ] );
  expected = 'xample';
  test.identical( got, expected );


  /**/

  got = _.strRemoveBegin( 'example', /[axe]/ );
  expected = 'xample';
  test.identical( got, expected );

  /**/

  got = _.strRemoveBegin( 'example', /\w{4}/ );
  expected = 'ple';
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strRemoveBegin( 1, '' ) );
  test.shouldThrowError( () => _.strRemoveBegin( 'a', 1 ) );
  test.shouldThrowError( () => _.strRemoveBegin() );
  test.shouldThrowError( () => _.strRemoveBegin( undefined, undefined ) );
  test.shouldThrowError( () => _.strRemoveBegin( null, null ) );

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strRemoveBegin( 'abcd','a','a' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strRemoveBegin( );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.strRemoveBegin( 1,'2' );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.strRemoveBegin( '1',2 );
  });

  test.case = 'second argument is array with wrong element';
  test.shouldThrowError( function()
  {
    _.strRemoveBegin( '1', [ ' a', 2 ] );
  });


}

//

function strRemoveEnd( test )
{
  var got, expected;

  test.case = 'returns string with removed occurrence from end';
  var got = _.strRemoveEnd( 'example','mple' );
  var expected = 'exa';
  test.identical( got, expected );

  test.case = 'returns original if no occurrence found ';
  var got = _.strRemoveEnd( 'example','' );
  var expected = 'example';
  test.identical( got, expected );

  test.case = 'returns original if occurrence is not at the end ';
  var got = _.strRemoveEnd( 'example','exa' );
  var expected = 'example';
  test.identical( got, expected );

  /* - */

  test.case = 'other';

  /**/

  got = _.strRemoveEnd( '', '' );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( '', 'x' );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'abc', 'c' );
  expected = 'ab';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'abc', 'bc' );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'abc', 'x' );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'abc', 'abc' );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'abc', '' );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'abc', [ 'a', 'b', 'c' ] );
  expected = 'ab';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'abc', [ '', 'a' ] );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'abc', [ '', 'c' ] );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'abc', [ 'abc', 'a' ] );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], [ 'a', 'd' ] );
  expected = [ 'abc', 'bc', 'cab' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( [ 'abc', 'bca', 'cab' ], [ 'a', 'b', 'c' ] );
  expected = [ 'ab', 'bc', 'ca' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( [ 'a', 'b', 'c' ], [ 'x' ] );
  expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( [ 'a', 'b', 'c' ], [ 'a', 'b', 'c' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( [ 'a', 'b', 'c' ], [ ] );
  expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  /* - */

  test.case = 'RegExp';

  /**/

  got = _.strRemoveEnd( 'example', /ple/ );
  expected = 'exam';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'example', /le$/ );
  expected = 'examp';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'example', /^le/ );
  expected = 'example';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'example', /\d/ );
  expected = 'example';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'example', /am/ );
  expected = 'example';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'example', /[axe]/ );
  expected = 'exampl';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( 'example', /\w{4}/ );
  expected = 'exa';
  test.identical( got, expected );

  /**/

  got = _.strRemoveEnd( [ 'example', '1example', 'example2', 'exam3ple' ], [ /\d/, /e/, /^3/ ] );
  expected = [ 'exampl', '1exampl', 'example', 'exam3pl' ];
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strRemoveEnd( 1, '' ) );
  test.shouldThrowError( () => _.strRemoveEnd( 'a', 1 ) );
  test.shouldThrowError( () => _.strRemoveEnd() );
  test.shouldThrowError( () => _.strRemoveEnd( undefined, undefined ) );
  test.shouldThrowError( () => _.strRemoveEnd( null, null ) );

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strRemoveEnd( 'one','two','three' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strRemoveEnd( );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.strRemoveEnd( 1,'second' );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.strRemoveEnd( 'first',2 );
  });

}

//

function strRemove( test )
{
  var got, expected;

  test.case = 'returns string with removed occurrence at the beggining';
  var got = _.strRemove( 'One example','On' );
  var expected = 'e example';
  test.identical( got, expected );

  test.case = 'returns string with removed occurrence at the end';
  var got = _.strRemove( 'One example','ple' );
  var expected = 'One exam';
  test.identical( got, expected );

  test.case = 'returns string with removed occurrence in the middle';
  var got = _.strRemove( 'One example','ne examp' );
  var expected = 'Ole';
  test.identical( got, expected );

  test.case = 'returns string with removed first occurrence';
  var got = _.strRemove( 'One example','e' );
  var expected = 'On example';
  test.identical( got, expected );

  test.case = 'returns original if no occurrence found ';
  var got = _.strRemove( 'example','y' );
  var expected = 'example';
  test.identical( got, expected );

  test.case = 'returns original if no occurrence found ';
  var got = _.strRemove( 'example','ma' );
  var expected = 'example';
  test.identical( got, expected );

  /* - */

  test.case = 'other';

  /**/

  got = _.strRemove( '', '' );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemove( '', 'x' );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'cacbc', 'c' );
  expected = 'acbc';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'abca', 'bc' );
  expected = 'aa';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'abc', 'x' );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'abcabc', 'abc' );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'abc', '' );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'abc', [ 'a', 'b', 'c' ] );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'bcabca', [ '', 'a' ] );
  expected = 'bcbca';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'abc', [ 'abc', 'a' ] );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strRemove( [ 'abc', 'bca', 'cab' ], [ 'a', 'd' ] );
  expected = [ 'bc', 'bc', 'cb' ];
  test.identical( got, expected );

  /**/

  got = _.strRemove( [ 'abc', 'bca', 'cab' ], [ 'a', 'b', 'c' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strRemove( [ 'a', 'b', 'c' ], [ 'x' ] );
  expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  /**/

  got = _.strRemove( [ 'a', 'b', 'c' ], [ ] );
  expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  /* - */

  test.case = 'RegExp';

  /**/

  got = _.strRemove( 'One example', /e/ );
  expected = 'On example';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'le example', /le$/ );
  expected = 'le examp';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'example', /^le/ );
  expected = 'example';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'example', /\d/ );
  expected = 'example';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'ex1am2pl3e4', /\d/ );
  expected = 'exam2pl3e4';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'example', /[axe]/ );
  expected = 'xample';
  test.identical( got, expected );

  /**/

  got = _.strRemove( 'example', /[a-z]/ );
  expected = 'xample';
  test.identical( got, expected );

  /**/

  got = _.strRemove( [ 'example', '1example', 'example2', 'xam3ple' ], [ /\d/, /e/, /^3/ ] );
  expected = [ 'xample', 'xample', 'xample', 'xampl' ];
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strRemove( 1, '' ) );
  test.shouldThrowError( () => _.strRemove( 'a', 1 ) );
  test.shouldThrowError( () => _.strRemove() );
  test.shouldThrowError( () => _.strRemove( undefined, undefined ) );
  test.shouldThrowError( () => _.strRemove( null, null ) );

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strRemove( 'one','two','three' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strRemove( );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.strRemove( 1,'second' );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.strRemove( 'first',2 );
  });

}

//

function strReplaceBegin( test )
{
  /**/

  var got, expected;

  got = _.strReplaceBegin( '', '', '' );
  expected = '';
  test.identical( got, expected );

  got = _.strReplaceBegin( '', '', 'a' );
  expected = 'a';
  test.identical( got, expected );

  got = _.strReplaceBegin( 'a', 'a', 'b' );
  expected = 'b';
  test.identical( got, expected );

  got = _.strReplaceBegin( 'a', 'x', 'b' );
  expected = 'a';
  test.identical( got, expected );

  got = _.strReplaceBegin( 'abc', 'ab', 'c' );
  expected = 'cc';
  test.identical( got, expected );

  got = _.strReplaceBegin( 'abc', '', 'c' );
  expected = 'cabc';
  test.identical( got, expected );

  got = _.strReplaceBegin( [], '', '' );
  expected = [];
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'a', 'b', 'c' ], 'a', 'c' );
  expected = [ 'c', 'b', 'c' ];
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'a', 'b', 'c' ], [ 'a', 'b', 'c' ], 'c' );
  expected = [ 'c', 'c', 'c' ];
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'a', 'b', 'c' ], [ 'a', 'b', 'c' ], [ 'x', 'y', 'z' ] );
  expected = [ 'x', 'y', 'z' ];
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'aa', 'bb', 'cc' ], [ 'a', 'b', 'c' ], [ 'x', 'y', 'z' ] );
  expected = [ 'xa', 'yb', 'zc' ];
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'aa', 'bb', 'cc' ], [ 'y', 'z', 'c' ], [ 'x', 'y', 'z' ] );
  expected = [ 'aa', 'bb', 'zc' ];
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'a', 'b', 'c' ], [ 'x', 'y', 'z' ], 'c' );
  expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'a', 'ab', 'ac' ], 'a', [ 'x', 'y', 'z' ] );
  expected = [ 'x', 'xb', 'xc' ];
  test.identical( got, expected );  /* - */

  /**/

  test.case = 'RegExp';

  /**/

  got = _.strReplaceBegin( 'example', /exa/, 'si' );
  expected = 'simple';
  test.identical( got, expected );

  got = _.strReplaceBegin( 'example', /ex$/, 'no' );
  expected = 'example';
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'example', 'lexical' ], [ /^le/, /ex$/, /\w{3}/ ], [ 'a', 'b', 'si' ]  );
  expected = [ 'simple', 'axical' ];
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'example', 'lexical' ], [ /^le/, /ex$/, /\w{3}/ ], 'si' );
  expected = [ 'simple', 'sixical' ];
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'example1', '3example', 'exam4ple' ], /\d/, '2' );
  expected = [ 'example1', '2example', 'exam4ple' ];
  test.identical( got, expected );

  got = _.strReplaceBegin( [ 'example', '1example', 'example2', 'exam3ple' ], [ /\d/, /e/, /^3/ ], [ '3', '2', '1' ]  );
  expected = [ '2xample', '3example', '2xample2', '2xam3ple' ];
  test.identical( got, expected );

  /**/

  test.case = 'Null';

  /**/

  got = _.strReplaceBegin( null, /exa/, 'si' );
  expected = [];
  test.identical( got, expected );

  got = _.strReplaceBegin( 'example', null, 'no' );
  expected = 'example';
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strReplaceBegin() );
  test.shouldThrowError( () => _.strReplaceBegin( 1, '', '' ) );
  test.shouldThrowError( () => _.strReplaceBegin( '' ) );
  test.shouldThrowError( () => _.strReplaceBegin( 1, '', '', '' ) );
  test.shouldThrowError( () => _.strReplaceBegin( 'a', 1, '' ) );
  test.shouldThrowError( () => _.strReplaceBegin( 'a', 'a', 1 ) );
  test.shouldThrowError( () => _.strReplaceBegin( 'a', [ 'x', 1 ], 'a' ) );
  test.shouldThrowError( () => _.strReplaceBegin( 'a', [ 'b', 'a' ], [ 'x', 1 ] ) );
  test.shouldThrowError( () => _.strReplaceBegin( 'a', [ 'a' ], [ 'x', '1' ] ) );
  test.shouldThrowError( () => _.strReplaceBegin( 'string', 'begin', null ) );
  test.shouldThrowError( () => _.strReplaceBegin( 'string', 'begin', undefined ) );
  test.shouldThrowError( () => _.strReplaceBegin( 'string', undefined, 'ins' ) );
  test.shouldThrowError( () => _.strReplaceBegin( undefined, 'begin', 'ins' ) );
}

//

function strReplaceEnd( test )
{
  /**/

  var got, expected;

  got = _.strReplaceEnd( '', '', '' );
  expected = '';
  test.identical( got, expected );

  got = _.strReplaceEnd( '', '', 'a' );
  expected = 'a';
  test.identical( got, expected );

  got = _.strReplaceEnd( 'a', 'a', 'b' );
  expected = 'b';
  test.identical( got, expected );

  got = _.strReplaceEnd( 'a', 'x', 'b' );
  expected = 'a';
  test.identical( got, expected );

  got = _.strReplaceEnd( 'abc', 'bc', 'c' );
  expected = 'ac';
  test.identical( got, expected );

  got = _.strReplaceEnd( 'abc', '', 'c' );
  expected = 'abcc';
  test.identical( got, expected );

  got = _.strReplaceEnd( [], '', '' );
  expected = [];
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'a', 'b', 'c' ], 'a', 'c' );
  expected = [ 'c', 'b', 'c' ];
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'a', 'b', 'c' ], [ 'a', 'b', 'c' ], 'c' );
  expected = [ 'c', 'c', 'c' ];
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'a', 'b', 'c' ], [ 'a', 'b', 'c' ], [ 'x', 'y', 'z' ] );
  expected = [ 'x', 'y', 'z' ];
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'aa', 'bb', 'cc' ], [ 'a', 'b', 'c' ], [ 'x', 'y', 'z' ] );
  expected = [ 'ax', 'by', 'cz' ];
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'aa', 'bb', 'cc' ], [ 'y', 'z', 'c' ], [ 'x', 'y', 'z' ] );
  expected = [ 'aa', 'bb', 'cz' ];
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'a', 'b', 'c' ], [ 'x', 'y', 'z' ], 'c' );
  expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'a', 'ab', 'ca' ], 'a', [ 'x', 'y', 'z' ] );
  expected = [ 'x', 'ab', 'cx' ];
  test.identical( got, expected );

  /**/

  test.case = 'RegExp';

  /**/

  got = _.strReplaceEnd( 'example', /ple/, 'en' );
  expected = 'examen';
  test.identical( got, expected );

  got = _.strReplaceEnd( 'example', /^le/, 'no' );
  expected = 'example';
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'example', 'lexical' ], [ /^le/, /ex$/, /\w{3}/ ], [ 'a', 'b', 'en' ]  );
  expected = [ 'examen', 'lexien' ];
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'example', 'lexical' ], [ /al$/, /ex$/, /\w{3}/ ], 'en' );
  expected = [ 'examen', 'lexien' ];
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'example1', '3example', 'exam4ple' ], /\d/, '2' );
  expected = [ 'example2', '3example', 'exam4ple' ];
  test.identical( got, expected );

  got = _.strReplaceEnd( [ 'example', '1example', 'example2', 'exam2ple' ], [ /\d/, /e/, /^3/ ], [ '3', '2', '1' ]  );
  expected = [ 'exampl2', '1exampl2', 'example3', 'exam2pl2' ];
  test.identical( got, expected );

  /**/

  test.case = 'Null';

  /**/

  got = _.strReplaceEnd( null, /le/, 'si' );
  expected = [];
  test.identical( got, expected );

  got = _.strReplaceEnd( 'example', null, 'no' );
  expected = 'example';
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strReplaceEnd() );
  test.shouldThrowError( () => _.strReplaceEnd( 1, '', '' ) );
  test.shouldThrowError( () => _.strReplaceEnd( '' ) );
  test.shouldThrowError( () => _.strReplaceEnd( 1, '', '', '' ) );
  test.shouldThrowError( () => _.strReplaceEnd( 'a', 1, '' ) );
  test.shouldThrowError( () => _.strReplaceEnd( 'a', 'a', 1 ) );
  test.shouldThrowError( () => _.strReplaceEnd( 'a', [ 'x', 1 ], 'a' ) );
  test.shouldThrowError( () => _.strReplaceEnd( 'a', [ 'a' ], [ 1 ] ) );
  test.shouldThrowError( () => _.strReplaceEnd( 'a', [ 'b', 'c' ], [ 'c' ] ) );
  test.shouldThrowError( () => _.strReplaceEnd( 'string', 'end', null ) );
  test.shouldThrowError( () => _.strReplaceEnd( 'string', 'end', undefined ) );
  test.shouldThrowError( () => _.strReplaceEnd( 'string', undefined, 'ins' ) );
  test.shouldThrowError( () => _.strReplaceEnd( undefined, 'end', 'ins' ) );
}

//

function strReplace( test )
{
  /**/

  var got, expected;

  got = _.strReplace( '', '', '' );
  expected = '';
  test.identical( got, expected );

  got = _.strReplace( '', '', 'a' );
  expected = 'a';
  test.identical( got, expected );

  got = _.strReplace( 'a', 'a', 'b' );
  expected = 'b';
  test.identical( got, expected );

  got = _.strReplace( 'a', 'x', 'b' );
  expected = 'a';
  test.identical( got, expected );

  got = _.strReplace( 'bcabcabc', 'bc', 'c' );
  expected = 'cabcabc';
  test.identical( got, expected );

  got = _.strReplace( [], '', '' );
  expected = [];
  test.identical( got, expected );

  got = _.strReplace( [ 'aaa', 'ba', 'c' ], 'a', 'c' );
  expected = [ 'caa', 'bc', 'c' ];
  test.identical( got, expected );

  got = _.strReplace( [ 'abc', 'cab', 'cba' ], [ 'a', 'b', 'c' ], [ 'c', 'c', 'c' ] );
  expected = [ 'ccc', 'ccc', 'ccc' ];
  test.identical( got, expected );

  got = _.strReplace( [ 'a', 'b', 'c' ], [ 'a', 'b', 'c' ], [ 'x', 'y', 'z' ] );
  expected = [ 'x', 'y', 'z' ];
  test.identical( got, expected );

  got = _.strReplace( [ 'ab', 'bc', 'ca' ], [ 'a', 'b', 'c' ], [ 'x', 'y', 'z' ] );
  expected = [ 'xy', 'yz', 'zx' ];
  test.identical( got, expected );

  got = _.strReplace( [ 'aa', 'bb', 'cc' ], [ 'y', 'z', 'c' ], [ 'x', 'y', 'z' ] );
  expected = [ 'aa', 'bb', 'zc' ];
  test.identical( got, expected );

  got = _.strReplace( [ 'a', 'b', 'c' ], [ 'x', 'y', 'z' ], [ '1', '2', '3' ] );
  expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  got = _.strReplace( [ 'a', 'bab', 'ca' ], 'a', 'x' );
  expected = [ 'x', 'bxb', 'cx' ];
  test.identical( got, expected );

  /**/

  test.case = 'RegExp';

  /**/

  got = _.strReplace( 'example', /ple/, 'en' );
  expected = 'examen';
  test.identical( got, expected );

  got = _.strReplace( 'example', /^le/, 'no' );
  expected = 'example';
  test.identical( got, expected );

  got = _.strReplace( [ 'example', 'lex11ical' ], [ /^le/, /ex$/, /\d{2}/ ], [ 'a', 'b', 'en' ]  );
  expected = [ 'example', 'axenical' ];
  test.identical( got, expected );

  got = _.strReplace( [ 'example', 'lexical' ], [ /al$/, /^ex/ ], [ '1', '2' ] );
  expected = [ '2ample', 'lexic1' ];
  test.identical( got, expected );

  got = _.strReplace( [ 'example1', '3example', 'exam4ple' ], /\d/, '2' );
  expected = [ 'example2', '2example', 'exam2ple' ];
  test.identical( got, expected );

  got = _.strReplace( [ '3example', '1example', 'example2', 'exam2ple' ], [ /\d/, /e/, /^3/ ], [ '3', '2', '1' ]  );
  expected = [ '12xample', '12xample', '2xample3', '2xam3ple' ];
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strReplace() );
  test.shouldThrowError( () => _.strReplace( 1, '', '' ) );
  test.shouldThrowError( () => _.strReplace( '' ) );
  test.shouldThrowError( () => _.strReplace( 1, '', '', '' ) );
  test.shouldThrowError( () => _.strReplace( 'a', 1, '' ) );
  test.shouldThrowError( () => _.strReplace( 'a', 'a', 1 ) );
  test.shouldThrowError( () => _.strReplace( 'a', [ 'x', 1 ], 'a' ) );
  test.shouldThrowError( () => _.strReplace( 'a', [ 'a' ], [ 1 ] ) );
  test.shouldThrowError( () => _.strReplace( 'a', [ 'b', 'c' ], [ 'c' ] ) );
  test.shouldThrowError( () => _.strReplace( 'string', 'sub', null ) );
  test.shouldThrowError( () => _.strReplace( 'string', 'sub', undefined ) );
  test.shouldThrowError( () => _.strReplace( 'string', null, 'ins' ) );
  test.shouldThrowError( () => _.strReplace( 'string', undefined, 'ins' ) );
  test.shouldThrowError( () => _.strReplace( null, 'sub', 'ins' ) );
  test.shouldThrowError( () => _.strReplace( undefined, 'sub', 'ins' ) );
}

//

function strPrependOnce( test )
{
  var got, expected;

  /* - */

  test.case = 'strPrependOnce';

  /**/

  got = _.strPrependOnce( '', '' );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strPrependOnce( '', 'a' );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strPrependOnce( 'ab', 'a' );
  expected = 'ab';
  test.identical( got, expected );

  /**/

  got = _.strPrependOnce( 'ab', 'ab' );
  expected = 'ab';
  test.identical( got, expected );

  /**/

  got = _.strPrependOnce( 'ab', 'x' );
  expected = 'xab';
  test.identical( got, expected );

  /**/

  got = _.strPrependOnce( 'ab', '' );
  expected = 'ab';
  test.identical( got, expected );

  /**/

  got = _.strPrependOnce( 'morning', 'Good ' );
  expected = 'Good morning';
  test.identical( got, expected );

  /**/

  got = _.strPrependOnce( 'Good morning', 'Good ' );
  expected = 'Good morning';
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strPrependOnce() );
  test.shouldThrowError( () => _.strPrependOnce( null, '' ) );
  test.shouldThrowError( () => _.strPrependOnce( '', null ) );
  test.shouldThrowError( () => _.strPrependOnce( NaN, '' ) );
  test.shouldThrowError( () => _.strPrependOnce( '', NaN ) );
  test.shouldThrowError( () => _.strPrependOnce( 3, '' ) );
  test.shouldThrowError( () => _.strPrependOnce( '', 3 ) );
  test.shouldThrowError( () => _.strPrependOnce( [], '' ) );
  test.shouldThrowError( () => _.strPrependOnce( '', [] ) );

}

//

function strAppendOnce( test )
{
  var got, expected;

  /* - */

  test.case = 'strAppendOnce';

  /**/

  got = _.strAppendOnce( '', '' );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strAppendOnce( '', 'a' );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strAppendOnce( 'ab', 'a' );
  expected = 'aba';
  test.identical( got, expected );

  /**/

  got = _.strAppendOnce( 'ab', 'ab' );
  expected = 'ab';
  test.identical( got, expected );

  /**/

  got = _.strAppendOnce( 'ab', 'x' );
  expected = 'abx';
  test.identical( got, expected );

  /**/

  got = _.strAppendOnce( 'ab', '' );
  expected = 'ab';
  test.identical( got, expected );

  /**/

  got = _.strAppendOnce( 'Good ', 'morning' );
  expected = 'Good morning';
  test.identical( got, expected );

  /**/

  got = _.strAppendOnce( 'Good morning', 'morning' );
  expected = 'Good morning';
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.strAppendOnce() );
  test.shouldThrowError( () => _.strAppendOnce( null, '' ) );
  test.shouldThrowError( () => _.strAppendOnce( '', null ) );
  test.shouldThrowError( () => _.strAppendOnce( NaN, '' ) );
  test.shouldThrowError( () => _.strAppendOnce( '', NaN ) );
  test.shouldThrowError( () => _.strAppendOnce( 3, '' ) );
  test.shouldThrowError( () => _.strAppendOnce( '', 3 ) );
  test.shouldThrowError( () => _.strAppendOnce( [], '' ) );
  test.shouldThrowError( () => _.strAppendOnce( '', [] ) );

}

// --
//
// --

function strForRange( test )
{

  test.case = 'returns string representing the range of numbers';
  var got = _.strForRange( [ 1, 10 ] );
  var expected = '[ 1..10 ]';
  test.identical( got, expected );

  test.case = 'returns string representing the range of symbols';
  var got = _.strForRange( [ 'a', 'z' ] );
  var expected = '[ a..z ]';
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function( )
  {
    _.strForRange( );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strForRange( 'wrong argument' );
  } );

  test.case = 'too many arguments';
  test.shouldThrowError( function( )
  {
    _.strForRange( [ 1, 10 ], 'redundant argument' );
  } );

};

//

function strCapitalize( test )
{

  test.case = 'first letter is upper case';
  var got = _.strCapitalize( 'object' );
  var expected = 'Object';
  test.identical( got, expected );

  test.case = 'single word';
  var got = _.strCapitalize( 'one' );
  var expected = 'One';
  test.identical( got, expected );

  test.case = 'two words';
  var got = _.strCapitalize( 'one two' );
  var expected = 'One two';
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments length';
  test.shouldThrowError( function()
  {
    _.strCapitalize( 'first','wrond argument' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.strCapitalize( 777 );
  });

  test.case = 'no argument provided';
  test.shouldThrowError( function()
  {
    _.strCapitalize();
  });

  test.case = 'no arguments';
  test.shouldThrowError( function( )
  {
    _.strCapitalize( );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strCapitalize( 33 );
  } );

  test.case = 'too many arguments';
  test.shouldThrowError( function( )
  {
    _.strCapitalize( 'object', 'redundant argument' );
  } );

}

//

function strIndentation( test )
{
  var got, expected;

  /* - */

  test.case = 'single line';

  /**/

  got = _.strIndentation( '', '_' );
  expected = '_';
  test.identical( got, expected );

  /* no new lines, returns tab + source */

  got = _.strIndentation( 'abc', '_' );
  expected = '_abc';
  test.identical( got, expected );

  /* - */

  test.case = 'multiline';

  /**/

  got = _.strIndentation( 'a\nb', '_' );
  expected = '_a\n_b';
  test.identical( got, expected );

  /* tab before first and each new line */

  got = _.strIndentation( '\na\nb\nc', '_' );
  expected = '_\n_a\n_b\n_c';
  test.identical( got, expected );

  /* tabs count = new lines count + 1 for first line */

  got = _.strIndentation( '\n\n\n', '_' );
  expected = '_\n_\n_\n_';
  test.identical( got, expected );

  /**/

  got = _.strIndentation( 'a\nb\nc','\t' );
  expected = '\ta\n\tb\n\tc';
  test.identical( got, expected );

  /* - */

  test.case = 'array';

  /**/

  got = _.strIndentation( [ 'a', 'b', 'c' ],'_' );
  expected = '_a\n_b\n_c';
  test.identical( got, expected );

  /* join array to string */

  var arr = [ 'a\nb', 'b\nc', 'c\nd' ];
  got = _.strIndentation( arr.join( '\n' ), '_' );
  expected = '_a\n_b\n_b\n_c\n_c\n_d';
  test.identical( got, expected );


  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strIndentation( 'one','two','three' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strIndentation( );
  });

  test.case = 'first argument type is wrong';
  test.shouldThrowError( function()
  {
    _.strIndentation( 123,'second' );
  });

  test.case = 'second argument type is wrong';
  test.shouldThrowError( function()
  {
    _.strIndentation( 'first', 321 );
  });

}

//

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
  test.shouldThrowError( () =>
  {
    _.strSplitsCoupledGroup
    ({
      splits : [ 'aa', '>>', '<<=', '<<-', 'dd' ],
      prefix : '>>',
      postfix : /^<</,
    });
  });

  test.case = 'uncoupled prefix';
  test.shouldThrowError( () =>
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
  test.shouldThrowError( function( )
  {
    _.strSplitFast( );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strSplitFast( [  ] );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strSplitFast( 13 );
  } );

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strSplitFast( '1', '2', '3' );
  });

  test.case = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strSplitFast( 123 );
  });

  test.case = 'invalid option type';
  test.shouldThrowError( function()
  {
    _.strSplitFast( { src : 3 } );
  });

  test.case = 'invalid option defined';
  test.shouldThrowError( function()
  {
    _.strSplitFast( { src : 'word', delimeter : 0, left : 1 } );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.strSplitFast( /1/, /2/, '3' );
  });

}

//

function strSplit( test )
{

  /* - */

  test.open( 'empty' );

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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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
    src : src,
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

  /* - */

  test.close( 'complex' );

}

// //
//
// function strSplitNaive( test )
// {
//
//   test.case = 'returns an array of strings';
//   debugger;
//   var got = _.strSplitNaive( 'test test test' );
//   debugger;
//   var expected = [ 'test', 'test', 'test' ];
//   test.identical( got, expected );
//
//   test.case = 'split string into an array of strings';
//   var got = _.strSplitNaive( ' test   test   test ' );
//   var expected = [ 'test', 'test', 'test' ];
//   test.identical( got, expected );
//
//   test.case = 'returns an array of strings';
//   var got = _.strSplitNaive( ' test   test   test ', 'redundant argument' );
//   var expected = [ 'test   test   test' ];
//   test.identical( got, expected );
//
//   test.case = 'returns an array of strings';
//   var got = _.strSplitNaive( ' test <delimteter>  test<delimteter>   test ', '<delimteter>' );
//   var expected = [ 'test', 'test', 'test' ];
//   test.identical( got, expected );
//
//   test.case = 'simple string, default options';
//   var got = _.strSplitNaive( 'a b c d' );
//   var expected = [ 'a', 'b', 'c', 'd' ];
//   test.identical( got, expected );
//
//   test.case = 'arguments as map';
//   var got = _.strSplitNaive( { src : 'a,b,c,d', delimeter : ','  } );
//   var expected = [ 'a', 'b', 'c', 'd' ];
//   test.identical( got, expected );
//
//   test.case = 'delimeter as array';
//   var got = _.strSplitNaive( { src : 'a,b.c.d', delimeter : [ ',', '.' ]  } );
//   var expected = [ 'a', 'b', 'c', 'd' ];
//   test.identical( got, expected );
//
//   test.case = 'zero delimeter length';
//   var got = _.strSplitNaive( { src : 'a,b.c.d', delimeter : []  } );
//   var expected = [ 'a,b.c.d' ];
//   test.identical( got, expected );
//
//   test.case = 'stripping off';
//   var got = _.strSplitNaive( { src : '    a,b,c,d   ', delimeter : [ ',' ], stripping : 0  } );
//   var expected = [ '    a', 'b', 'c', 'd   ' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'preserving delimeters, many delimeters, delimeter on the begin';
//   var got = _.strSplitNaive({ src : '.content', preservingDelimeters : 1, delimeter : [ '.','#' ] })
//   var expected = [ '.','content' ];
//   test.identical( got, expected );
//
//   test.case = 'preserving delimeters, many delimeters, delimeter on the end';
//   var got = _.strSplitNaive({ src : 'content.', preservingDelimeters : 1, delimeter : [ '.','#' ] })
//   var expected = [ 'content','.' ];
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'many delimeters having common, preserving empty';
//   var src = 'Aa <<! <<- Bb';
//   var expected = [ 'Aa',' ','','<<!','',' ','','<<-','',' ','Bb' ];
//   var got = _.strSplitNaive
//   ({
//     src : src,
//     delimeter : [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ],
//     preservingEmpty : 1,
//     preservingDelimeters : 1,
//     stripping : 0,
//   });
//
//   test.identical( got, expected );
//   test.case = 'many delimeters having common, removing empty';
//   var src = 'Aa <<! <<- Bb';
//   var expected = [ 'Aa',' ','<<!',' ','<<-',' ','Bb' ];
//   var got = _.strSplitNaive
//   ({
//     src : src,
//     delimeter : [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ],
//     preservingEmpty : 0,
//     preservingDelimeters : 1,
//     stripping : 0,
//   });
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'having long common';
//   var src = 'Aa <<<- Bb';
//   var expected = [ 'Aa',' ','','<<<-','',' ','Bb' ];
//   var got = _.strSplitNaive
//   ({
//     src : src,
//     delimeter : [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ],
//     preservingEmpty : 1,
//     preservingDelimeters : 1,
//     stripping : 0,
//   });
//   test.identical( got, expected );
//
//   /* */
//
//   test.case = 'having long common 2';
//   var src = 'a1 a2 a3 <<<- Bb';
//   var expected = [ 'a1',' ','a2',' ','a3',' ','','<<<-','',' ','Bb' ];
//   var got = _.strSplitNaive
//   ({
//     src : src,
//     delimeter : [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ],
//     preservingEmpty : 1,
//     preservingDelimeters : 1,
//     stripping : 0,
//   });
//   test.identical( got, expected );
//
//   /*delimeter not exist in src*/
//
//   var src = 'a,b,c';
//   var expected = [ 'a,b,c' ];
//   var got = _.strSplitNaive
//   ({
//     src : src,
//     delimeter : [ '.' ],
//     preservingDelimeters : 1
//   });
//   test.identical( got, expected );
//
//   /*delimeter not exist in src*/
//
//   var src = 'a,b,c';
//   var expected = [ 'a,b,c' ];
//   var got = _.strSplitNaive
//   ({
//     src : src,
//     delimeter : [ '.' ],
//     preservingDelimeters : 1
//   });
//   test.identical( got, expected );
//
//   /**/
//
//   test.case = 'preservingEmpty';
//
//   var src = 'a ., b ., c ., d';
//   var expected = [ 'a', '', 'b', '', 'c', '', 'd' ];
//   var got = _.strSplitNaive
//   ({
//     src : src,
//     delimeter : [ ',', '.' ],
//     preservingEmpty : 1
//   });
//   test.identical( got, expected );
//
//   /**/
//
//   var src = 'a , b , c , d';
//   var expected = [ 'a', 'b', 'c', 'd' ];
//   var got = _.strSplitNaive
//   ({
//     src : src,
//     delimeter : ',',
//     preservingEmpty : 1
//   });
//   test.identical( got, expected );
//
//
//   /**/
//
//   var src = ',';
//   var expected = [ '', '' ];
//   var got = _.strSplitNaive
//   ({
//     src : src,
//     delimeter : ',',
//     preservingEmpty : 1
//   });
//   test.identical( got, expected );
//
//   /**/
//
//   var src = ',,,';
//   var expected = [];
//   var got = _.strSplitNaive
//   ({
//     src : src,
//     delimeter : ',',
//     preservingEmpty : 0
//   });
//   test.identical( got, expected );
//
//   /* take into acount text inside " " */
//
//   test.case = 'take into acount text inside ""';
//
//   var o =
//   {
//     src : '"/path/with space/" a b c',
//     quoting : 1,
//     preservingEmpty : 1,
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ '/path/with space/', '', 'a', '', 'b', '', 'c' ];
//   test.identical( got, expected );
//
//   test.case = 'take into acount text inside ""';
//
//   var o =
//   {
//     src : '"/path/with space/" a b c',
//     quoting : 1,
//     preservingEmpty : 0,
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ '/path/with space/', 'a', 'b', 'c' ];
//   test.identical( got, expected );
//
//   /**/
//
//   var o =
//   {
//     src : 'a "/path with/empty space/" a',
//     quoting : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ 'a', '/path with/empty space/', 'a' ];
//   test.identical( got, expected );
//
//   /**/
//
//   var o =
//   {
//     src : '"a b c" "a b c" "a b c"',
//     quoting : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ 'a b c', 'a b c', 'a b c' ];
//   test.identical( got, expected );
//
//   /**/
//
//   var o =
//   {
//     src : '"a b c" "a b c" "a b c"',
//     quoting : 1,
//     preservingEmpty : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ 'a b c', '', 'a b c', '', 'a b c' ];
//   test.identical( got, expected );
//
//   /**/
//
//   var o =
//   {
//     src : '"a b c"x"a b c"x"a b c"',
//     quoting : 1,
//     delimeter : [ 'x' ],
//     preservingEmpty : 1,
//     preservingDelimeters : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ 'a b c', 'x', 'a b c', 'x', 'a b c' ];
//   test.identical( got, expected );
//
//   /**/
//
//   var o =
//   {
//     src : '"a b" "" c"',
//     quoting : 0,
//     delimeter : [ '"' ],
//     stripping : 1,
//     preservingEmpty : 1,
//     preservingDelimeters : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ '', '\"', 'a b', '\"', '', '\"', '', '\"', 'c', '\"', '' ]
//   test.identical( got, expected );
//
//   /**/
//
//   var o =
//   {
//     src : '"a b" "" c',
//     quoting : 0,
//     delimeter : [ '"' ],
//     stripping : 0,
//     preservingEmpty : 1,
//     preservingDelimeters : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ '', '\"', 'a b', '\"', ' ', '\"', '', '\"', ' c' ];
//   test.identical( got, expected );
//
//   var o =
//   {
//     src : '"a b" "" c',
//     quoting : 1,
//     delimeter : [ '"' ],
//     stripping : 0,
//     preservingEmpty : 1,
//     preservingDelimeters : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ 'a b', ' ', '', ' c' ];
//   test.identical( got, expected );
//
//   /**/
//
//   var o =
//   {
//     src : '"a b" "" c',
//     quoting : 1,
//     delimeter : [ '"' ],
//     stripping : 0,
//     preservingEmpty : 1,
//     preservingDelimeters : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ 'a b', ' ', '', ' c' ];
//   test.identical( got, expected );
//
//   /**/
//
//   var o =
//   {
//     src : '"a b" "" c',
//     quoting : 1,
//     delimeter : [ '"' ],
//     stripping : 1,
//     preservingEmpty : 1,
//     preservingDelimeters : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ 'a b', '', '', 'c' ];
//   test.identical( got, expected );
//
//   /**/
//
//   var o =
//   {
//     src : '"a b" "" c"',
//     quoting : 1,
//     delimeter : [ '"' ],
//     stripping : 1,
//     preservingEmpty : 1,
//     preservingDelimeters : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ 'a b', '', '', 'c' ];
//   test.identical( got, expected );
//
//   /**/
//
//   var o =
//   {
//     src : '"a b" "" c"',
//     quoting : 1,
//     delimeter : [ '"' ],
//     stripping : 0,
//     preservingEmpty : 1,
//     preservingDelimeters : 1
//   }
//   var got = _.strSplitNaive( o );
//   var expected = [ 'a b', ' ', '', ' c' ];
//   test.identical( got, expected );
//
//   /*
//     stripping : 1,
//     quoting : 1,
//     preservingEmpty : 0,
//   */
//
//   var op =
//   {
//     stripping : 1,
//     quoting : 1,
//     preservingEmpty : 0,
//   }
//
//   /* */
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no arguments';
//   test.shouldThrowError( function( )
//   {
//     _.strSplitNaive( );
//   } );
//
//   test.case = 'argument is wrong';
//   test.shouldThrowError( function( )
//   {
//     _.strSplitNaive( [  ] );
//   } );
//
//   test.case = 'argument is wrong';
//   test.shouldThrowError( function( )
//   {
//     _.strSplitNaive( 13 );
//   } );
//
//   test.case = 'invalid arguments count';
//   test.shouldThrowError( function()
//   {
//     _.strSplitNaive( '1', '2', '3' );
//   });
//
//   test.case = 'invalid argument type';
//   test.shouldThrowError( function()
//   {
//     _.strSplitNaive( 123 );
//   });
//
//   test.case = 'invalid option type';
//   test.shouldThrowError( function()
//   {
//     _.strSplitNaive( { src : 3 } );
//   });
//
//   test.case = 'invalid option defined';
//   test.shouldThrowError( function()
//   {
//     _.strSplitNaive( { src : 'word', delimeter : 0, left : 1 } );
//   });
//
//   test.case = 'no arguments';
//   test.shouldThrowError( function()
//   {
//     _.strSplitNaive();
//   });
//
// }

//

function strSplitStrNumber( test )
{

  test.case = 'returns object with one property';
  var got = _.strSplitStrNumber( 'abcdef' );
  var expected = { str : 'abcdef' };
  test.identical( got, expected );

  test.case = 'returns object with two properties';
  var got = _.strSplitStrNumber( 'abc3def' );
  var expected = { str : 'abc', number : 3 };
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function( )
  {
    _.strSplitStrNumber( );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strSplitStrNumber( [  ] );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strSplitStrNumber( 13 );
  } );

  test.case = 'too many arguments';
  test.shouldThrowError( function( )
  {
    _.strSplitStrNumber( 'abc3', 'redundant argument' );
  } );

}

//

function strStrip( test )
{

  test.case = 'simple string, default options';
  var got = _.strStrip( '\nabc  ' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'arguments as map';
  var got = _.strStrip( { src : 'xaabaax', stripper : [ 'a', 'x' ] } );
  var expected = 'b';
  test.identical( got, expected );

  test.case = 'nothing to remove';
  var got = _.strStrip( 'test' );
  var expected = 'test';
  test.identical( got, expected );

  test.case = 'removes whitespace from both ends of a string';
  var got = _.strStrip( ' test ' );
  var expected = 'test';
  test.identical( got, expected );

  test.case = 'Empty array';
  var got = _.strStrip( [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'Array with single string';
  var got = _.strStrip( [ '' ] );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'vectorized input';
  var got = _.strStrip( [ '\nab  ', ' cd\s', ' ef  ' ] );
  var expected = [ 'ab', 'cd', 'ef' ];
  test.identical( got, expected );

  test.case = 'vectorized input - map argument';
  var got = _.strStrip( { src : [ '\nab  ', ' cd\s', ' ef  ' ], stripper : [ 'a', 'f' ] }  );
  var expected = [ 'b', 'cd', 'f' ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strStrip( '1', '2', '3' );
  });

  test.case = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strStrip( 123 );
  });

  test.case = 'invalid property type';
  test.shouldThrowError( function()
  {
    _.strStrip( { src : ' word ', delimeter : 0 } );
  });

  test.case = 'invalid property defined';
  test.shouldThrowError( function()
  {
    _.strStrip( { src : ' word ', delimeter : ' ', left : 1 } );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strStrip();
  });

  test.case = 'null argument';
  test.shouldThrowError( function( )
  {
    _.strStrip( null );
  } );

  test.case = 'NaN argument';
  test.shouldThrowError( function( )
  {
    _.strStrip( NaN );
  } );

  test.case = 'too many arguments';
  test.shouldThrowError( function( )
  {
    _.strStrip( ' test ', 'redundant argument' );
  } );

}

//

/* qqq : uncover it please */

function strStrip( test )
{
  var cases =
  [
    { description : 'defaults, src is a string' },
    { src : '', expected : '' },
    { src : 'a', expected : 'a' },
    { src : '   a   ', expected : 'a' },
    { src : ' \0 a \0 ', expected : 'a' },
    { src : '\r\n\t\f\v a \v\r\n\t\f', expected : 'a' },
    { src : '\r\n\t\f\v hello world \v\r\n\t\f', expected : 'hello world' },

    { description : 'stripper contains regexp special symbols' },
    { src : { src : '\\s\\s', stripper : '\\s' } , expected : '' },
    { src : { src : '(x)(x)', stripper : '(x)' } , expected : '' },
    { src : { src : 'abc', stripper : '[abc]' } , expected : 'abc' },
    { src : { src : '[abc]', stripper : '[abc]' } , expected : '' },
    { src : { src : 'abc', stripper : '[^abc]' } , expected : 'abc' },
    { src : { src : 'abc', stripper : '[a-c]' } , expected : 'abc' },
    { src : { src : '[a-c]', stripper : '[a-c]' } , expected : '' },
    { src : { src : 'ab(a|b)', stripper : '(a|b)' } , expected : 'ab' },
    { src : { src : 'gp', stripper : 'a+' } , expected : 'gp' },
    { src : { src : 'hp', stripper : 'b{3}' } , expected : 'hp' },
    { src : { src : 'acbc', stripper : '^[ab]c$' } , expected : 'acbc' },

    { description : 'stripper is regexp' },
    { src : { src : ' abc', stripper : /[abc]/ } , expected : ' bc' },
    { src : { src : 'abc', stripper : /\D/ } , expected : 'bc' },
    { src : { src : 'abc', stripper : /[abc]$/ } , expected : 'ab' },
    { src : { src : 'abc', stripper : /abc/ } , expected : '' },
    { src : { src : 'hello', stripper : /lo?/ } , expected : 'helo' },

    {
      description : 'defaults, src is an array',
      src :
      [
        '',
        'a',
        '   a   ',
        ' \0 a \0 ',
        '\r\n\t\f\v a \v\r\n\t\f'
      ],
      expected :
      [
        '',
        'a',
        'a',
        'a',
        'a'
      ]
    },
    {
      description : 'src array of strings, custom stripper',
      src :
      {
        src :
        [
          '',
          'a',
          ' a ',
          '  a  ',
          ' \n ',
          ' a b c ',
        ],
        stripper : ' '
      },
      expected :
      [
        '',
        'a',
        'a',
        'a',
        '\n',
        'abc'
      ]
    },
    {
      description : 'src array of strings, custom stripper as regexp',
      src :
      {
        src :
        [
          'x',
          'xx',
          'axbxc',
          'x\nx'
        ],
        stripper : new RegExp( 'x' ),
      },
      expected :
      [
        '',
        'x',
        'abxc',
        '\nx'
      ]
    },
    {
      description : 'src array of strings, custom stripper as regexp',
      src :
      {
        src :
        [
          'abc',
          'acb',
          'bac',
          'cab',
        ],
        stripper : /abc|[abc]/,
      },
      expected :
      [
        '',
        'cb',
        'ac',
        'ab'
      ]
    },
    {
      description : 'src array of strings, custom stripper as regexp',
      src :
      {
        src :
        [
          'abc',
          'acb',
          'bac',
          'bca',
          'cba',
          'cab',
        ],
        stripper : /[abc]/g,
      },
      expected : [ '','','', '', '', '' ]
    },
    {
      description : 'src string, stripper array of strings',
      src :
      {
        src : 'xxyy',
        stripper :
        [
          'x',
          'y',
        ]
      },
      expected : ''
    },
    {
      src :
      {
        src : 'jjkk',
        stripper :
        [
          'x',
          'y',
        ]
      },
      expected : 'jjkk'
    },
    {
      description : 'invalid type',
      args : 0,
      err : true
    },
    {
      description : 'too many arguments',
      args : [ 'a', '' ],
      err : true
    },
    {
      description : 'null argument',
      args : [ null ],
      err : true
    },
    {
      description : 'NaN arguments',
      args : [ NaN ],
      err : true
    },
    {
      description : 'one string has invalid type',
      args : [ [ 'a', 0, 'b' ] ],
      err : true
    },
    {
      description : 'stripper has invalid type',
      args : [ { src : 'a', stripper : 0 } ],
      err : true
    },
    {
      description : 'stripper has invalid type',
      args : [ { src : 'a', stripper : [ 'a', 0 ] } ],
      err : true
    },
    {
      description : 'null stripper',
      args : [ { src : [ 'a', 'b' ], stripper : null } ],
      err : true
    },
    {
      description : 'NaN stripper',
      args : [ { src : [ 'a', 'b' ], stripper : NaN } ],
      err : true
    },

  ]

  /**/

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];

    if( c.description )
    test.case = c.description;

    if( c.err )
    test.shouldThrowError( () => _.strStrip.apply( _, _.arrayAs( c.args ) ) );

    if( c.src )
    {
      var identical = test.identical( _.strStrip( c.src ), c.expected );
      if( !identical )
      {
        debugger;
        test.identical( _.strStrip( c.src ), c.expected )
        debugger;
      }
    }

  }

}

//

function strStripLeft( test )
{
  var cases =
  [
    { description : 'defaults, src is a string' },
    { src : '   a   ', expected : 'a   ' },
    { src : ' \0 a \0 ', expected : 'a \u0000 ' },
    { src : '\r\v a \v\r\n\t\f', expected : 'a \u000b\r' },
    { src : '\0 hello world \0', expected : 'hello world \u0000' },

    {
      description : 'defaults, src is an array',
      src :
      [
        '',
        'a',
        '   a   ',
        ' \0 a \0 ',
        '\r\n\t\f\v a \v\r'
      ],
      expected :
      [
        '',
        'a',
        'a   ',
        'a \u0000 ',
        'a \u000b\r'
      ]
    },
    {
      description : 'invalid type',
      args : 0,
      err : true
    },
    {
      description : 'too many arguments',
      args : [ 'a', '' ],
      err : true
    },
    {
      description : 'null argument',
      args : [ null ],
      err : true
    },
    {
      description : 'NaN arguments',
      args : [ NaN ],
      err : true
    },
    {
      description : 'one string has invalid type',
      args : [ [ 'a', 0, 'b' ] ],
      err : true
    },

  ]

  /**/

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];

    if( c.description )
    test.case = c.description;

    if( c.err )
    test.shouldThrowError( () => _.strStripLeft.apply( _, _.arrayAs( c.args ) ) );

    if( c.src )
    {
      var identical = test.identical( _.strStripLeft( c.src ), c.expected );
      if( !identical )
      {
        debugger;
        test.identical( _.strStripLeft( c.src ), c.expected )
        debugger;
      }
    }

  }

}

//

function strStripRight( test )
{
  var cases =
  [
    { description : 'defaults, src is a string' },
    { src : '   ul   ', expected : '   ul' },
    { src : ' \0 om \0 ', expected : ' \u0000 om' },
    { src : '\r\v a \v\n\t\f\r', expected : '\r\u000b a' },
    { src : '\0 hello world \0', expected : '\u0000 hello world' },

    {
      description : 'defaults, src is an array',
      src :
      [
        '',
        'a',
        '   a   ',
        ' \0 a \0 ',
        '\r\v a \v\n\t\f\r'
      ],
      expected :
      [
        '',
        'a',
        '   a',
        ' \u0000 a',
        '\r\u000b a'
      ]
    },
    {
      description : 'invalid type',
      args : 0,
      err : true
    },
    {
      description : 'too many arguments',
      args : [ 'a', '' ],
      err : true
    },
    {
      description : 'null argument',
      args : [ null ],
      err : true
    },
    {
      description : 'NaN arguments',
      args : [ NaN ],
      err : true
    },
    {
      description : 'one string has invalid type',
      args : [ [ 'a', 0, 'b' ] ],
      err : true
    },

  ]

  /**/

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];

    if( c.description )
    test.case = c.description;

    if( c.err )
    test.shouldThrowError( () => _.strStripRight.apply( _, _.arrayAs( c.args ) ) );

    if( c.src )
    {
      var identical = test.identical( _.strStripRight( c.src ), c.expected );
      if( !identical )
      {
        debugger;
        test.identical( _.strStripRight( c.src ), c.expected )
        debugger;
      }
    }

  }

}


//

function strRemoveAllSpaces( test )
{

  test.case = 'removes the spaces from the borders';
  var got = _.strRemoveAllSpaces( '  abcdef  ' );
  var expected = 'abcdef';
  test.identical( got, expected );

  test.case = 'removes the spaces from the given string';
  var got = _.strRemoveAllSpaces( 'a b c d e f' );
  var expected = 'abcdef';
  test.identical( got, expected );

  test.case = 'replaces the all spaces with the commas';
  var got = _.strRemoveAllSpaces( 'a b c d e f', ',' );
  var expected = 'a,b,c,d,e,f';
  test.identical( got, expected );

  test.case = 'simple string, default options';
  var got = _.strRemoveAllSpaces( 'a b c d e' );
  var expected = 'abcde';
  test.identical( got, expected );

  test.case = 'sub defined';
  var got = _.strRemoveAllSpaces( 'a b c d e', ', ' );
  var expected = 'a, b, c, d, e';
  test.identical( got, expected );

  test.case = 'empty string';
  var got = _.strRemoveAllSpaces( ' ' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'sub as word';
  var got = _.strRemoveAllSpaces( 'a b c', ' and ' );
  var expected = 'a and b and c';
  test.identical( got, expected );

  test.case = 'sub as number';
  var got = _.strRemoveAllSpaces( 'a b c', 0 );
  var expected = 'a0b0c';
  test.identical( got, expected );

  test.case = 'sub as array';
  var got = _.strRemoveAllSpaces( 'a b c d e', [ 5, 6 ] );
  var expected = 'a5,6b5,6c5,6d5,6e';
  test.identical( got, expected );

  test.case = 'sub as null';
  var got = _.strRemoveAllSpaces( 'a b c d e', null );
  var expected = 'anullbnullcnulldnulle';
  test.identical( got, expected );

  test.case = 'sub as NaN';
  var got = _.strRemoveAllSpaces( 'a b c d e', NaN );
  var expected = 'aNaNbNaNcNaNdNaNe';
  test.identical( got, expected );

  test.case = 'sub as regexp';
  var got = _.strRemoveAllSpaces( 'a b c d e', /a$/ );
  var expected = 'a/a$/b/a$/c/a$/d/a$/e';
  test.identical( got, expected );

  test.case = 'vectorized input';
  var got = _.strRemoveAllSpaces( [ '  a b ', 'c  d ', ' e f ' ] );
  var expected = [ 'ab', 'cd', 'ef' ];
  test.identical( got, expected );

  test.case = 'vectorized input';
  var got = _.strRemoveAllSpaces( [ '  a b ', 'c  d ', ' e f ' ], '-' );
  var expected = [ '--a-b-', 'c--d-', '-e-f-' ];
  test.identical( got, expected );

  test.case = 'vectorized input';
  var got = _.strRemoveAllSpaces( [ '  a b ', 'c  d ', ' e f ' ], 3 );
  var expected = [ '33a3b3', 'c33d3', '3e3f3' ];
  test.identical( got, expected );

  test.case = 'vectorized input';
  var got = _.strRemoveAllSpaces( [ 'a b', 'cd ', ' ef' ], [ 0, 1 ] );
  var expected = [ 'a0,1b', 'cd0,1', '0,1ef' ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strRemoveAllSpaces( '1', '2', '3' );
  });

  test.case = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strRemoveAllSpaces( 123 );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strRemoveAllSpaces();
  });

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strRemoveAllSpaces( 13 );
  } );

  test.case = 'too many arguments';
  test.shouldThrowError( function( )
  {
    _.strRemoveAllSpaces( 'a b c d e f', ',', 'redundant argument' );
  } );

  test.case = 'Null argument';
  test.shouldThrowError( function( )
  {
    _.strRemoveAllSpaces( null );
  } );

  test.case = 'NaN argument';
  test.shouldThrowError( function( )
  {
    _.strRemoveAllSpaces( NaN );
  } );

  test.case = 'Regexp argument';
  test.shouldThrowError( function( )
  {
    _.strRemoveAllSpaces( /^a/ );
  } );

}

//

function strStripEmptyLines( test )
{

  test.case = 'simple string';
  var got = _.strStripEmptyLines( 'line_one\n\nline_two' );
  var expected = 'line_one\nline_two';
  test.identical( got, expected );

  test.case = 'empty string';
  var got = _.strStripEmptyLines( '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'single line';
  var got = _.strStripEmptyLines( 'b' );
  var expected = 'b';
  test.identical( got, expected );

  test.case = 'multiple breaklines';
  var got = _.strStripEmptyLines( '\n\na\n\nb\n\n\n' );
  var expected = 'a\nb';
  test.identical( got, expected );

  test.case = 'Lines with spaces';
  var got = _.strStripEmptyLines( ' line one\n\n line two \n\n line 3 \n' );
  var expected = ' line one\n line two \n line 3 ';
  test.identical( got, expected );

  test.case = 'Lines with spaces and tabs';
  var got = _.strStripEmptyLines( ' line one\n\t\n\n line \t two \n\n line 3 \n' );
  var expected = ' line one\n line \t two \n line 3 ';
  test.identical( got, expected );

  test.case = 'Array input';
  var got = _.strStripEmptyLines( [ '  a \n\n b ', ' \nc  d \n\n\n ' ] );
  var expected = [ '  a \n b ', 'c  d ' ];
  test.identical( got, expected );

  test.case = 'Empty array input';
  var got = _.strStripEmptyLines( [ ] );
  var expected = [ ];
  test.identical( got, expected );


  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strStripEmptyLines( '1', '2', '3' );
  });

  test.case = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strStripEmptyLines( 123 );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strStripEmptyLines();
  });

  test.case = 'null argument';
  test.shouldThrowError( function()
  {
    _.strStripEmptyLines( null );
  });

  test.case = 'NaN argument';
  test.shouldThrowError( function()
  {
    _.strStripEmptyLines( NaN );
  });

  test.case = 'Regexp argument';
  test.shouldThrowError( function()
  {
    _.strStripEmptyLines( /a?$/ );
  });

  test.case = 'Array with wrong arguments';
  test.shouldThrowError( function()
  {
    _.strStripEmptyLines( [ null, NaN, 3, /a?$/ ] );
  });

}

//

function strSub( test )
{

  test.case = 'simple string - get all';
  var got = _.strSub( 'Hello', [ 0, 5 ] );
  var expected = 'Hello';
  test.identical( got, expected );

  test.case = 'simple string - range bigger than length';
  var got = _.strSub( 'Hello', [ 0, 8 ] );
  var expected = 'Hello';
  test.identical( got, expected );

  test.case = 'simple string - get subString';
  var got = _.strSub( 'Hello', [ 0, 4 ] );
  var expected = 'Hell';
  test.identical( got, expected );

  test.case = 'simple string - get end of string';
  var got = _.strSub( 'Hello', [ 3, 5 ] );
  var expected = 'lo';
  test.identical( got, expected );

  test.case = 'simple string - range reversed';
  var got = _.strSub( 'Hello', [ 4, 0 ] );
  var expected = 'Hell';
  test.identical( got, expected );

  test.case = 'simple string - range in the middle of the string';
  var got = _.strSub( 'Hello', [ 2, 3 ] );
  var expected = 'l';
  test.identical( got, expected );

  test.case = 'empty string';
  var got = _.strSub( '', [ 2, 3 ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'Input array';
  var got = _.strSub( [ 'Hello', 'World'], [ 3, 4 ] );
  var expected = [ 'l', 'l' ];
  test.identical( got, expected );


  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strSub();
  });

  test.case = 'Too many arguments';
  test.shouldThrowError( function()
  {
    _.strSub( '1', '2', '3' );
  });

  test.case = 'Too many ranges';
  test.shouldThrowError( function()
  {
    _.strSub( 'Hello world', [ 0, 1 ], [ 2, 3 ] );
  });

  test.case = 'Not enough arguments';
  test.shouldThrowError( function()
  {
    _.strSub( '1' );
  });

  test.case = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strSub( 123, [ 0, 1 ] );
  });

  test.case = 'null argument';
  test.shouldThrowError( function()
  {
    _.strSub( null, [ 0, 1 ] );
  });

  test.case = 'NaN argument';
  test.shouldThrowError( function()
  {
    _.strSub( NaN, [ 0, 1 ] );
  });

  test.case = 'Regexp argument';
  test.shouldThrowError( function()
  {
    _.strSub( /a?$/, [ 0, 1 ] );
  });

  test.case = 'invalid argument range';
  test.shouldThrowError( function()
  {
    _.strSub( 'hi ', 123 );
  });

  test.case = 'null range';
  test.shouldThrowError( function()
  {
    _.strSub( 'good morning', null );
  });

  test.case = 'NaN range';
  test.shouldThrowError( function()
  {
    _.strSub( 'good afternoon', NaN );
  });

  test.case = 'Regexp range';
  test.shouldThrowError( function()
  {
    _.strSub( 'good night', /a?$/ );
  });

  test.case = 'Array with wrong arguments';
  test.shouldThrowError( function()
  {
    _.strSub( [ null, NaN, 3, /a?$/ ], [ 0, 1 ] );
  });

  test.case = 'Range array with wrong arguments';
  test.shouldThrowError( function()
  {
    _.strSub( [ 'Hello', 'world' ], [ null, NaN ] );
  });

  test.case = 'Range array empty';
  test.shouldThrowError( function()
  {
    _.strSub( [ 'Hello', 'world' ], [ ] );
  });

  test.case = 'Range array with not enough arguments';
  test.shouldThrowError( function()
  {
    _.strSub( [ 'Hello', 'world' ], [ 2 ] );
  });

  test.case = 'Range array with too many arguments';
  test.shouldThrowError( function()
  {
    _.strSub( [ 'Hello', 'world' ], [ 2, 3, 4 ] );
  });

}

//

function strReplaceWords( test )
{

  test.case = 'simple string';
  var got = _.strReplaceWords( 'a b c d',[ 'b', 'c' ], [ 'x', 'y' ] );
  var expected = 'a x y d';
  test.identical( got, expected );

  test.case = 'escaping string';
  var got = _.strReplaceWords( '\na b \n c d',[ 'b', 'c' ], [ 'x', 'y' ] );
  var expected = '\na x \n y d';
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strReplaceWords( '1', '2');
  });

  test.case = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strReplaceWords( 123,[],[] );
  });

  test.case = 'invalid arrays length';
  test.shouldThrowError( function()
  {
    _.strReplaceWords( 'one two',[ 'one' ],[ 'one', 'two' ] );
  });

  test.case = 'invalid second arg type';
  test.shouldThrowError( function()
  {
    _.strReplaceWords( 'one two',5,[ 'one', 'two' ] );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strReplaceWords();
  });

}

//

function strJoin( test )
{

  /* - */

  test.open( 'single argument' );

  test.case = 'join nothing';
  var got = _.strJoin([]);
  var expected = [];
  test.identical( got, expected );

  test.case = 'join empty vector';
  var got = _.strJoin([ [] ]);
  var expected = [];
  test.identical( got, expected );

  test.case = 'join empty vectors';
  var got = _.strJoin([ [], [] ]);
  var expected = [];
  test.identical( got, expected );

  test.case = 'join empty vector and string';
  var got = _.strJoin([ [], 'abc' ]);
  var expected = [];
  test.identical( got, expected );

  // test.case = 'join empty vector and strings';
  // var got = _.strJoin([ [], [ 'abc', 'def' ] ]);
  // var expected = [];
  // test.identical( got, expected );

  test.case = 'join numbers';
  var got = _.strJoin([ 1, 2, 3 ]);
  var expected = '123';
  test.identical( got, expected );

  test.case = 'join strings';
  var got = _.strJoin([ '1', '2', '3' ]);
  var expected = '123';
  test.identical( got, expected );

  test.case = 'join two arrays';
  var got = _.strJoin([ [ 'b', 'c' ], [ 'x', 'y' ] ]);
  var expected = [ 'bx', 'cy' ];
  test.identical( got, expected );

  test.case = 'join string + number';
  var got = _.strJoin([ 1, 2, '3' ]);
  var expected = '123';
  test.identical( got, expected );

  test.case = 'join array + string';
  var got = _.strJoin([ [ 1, 2 ], '3' ]);
  var expected = [ '13', '23' ];
  test.identical( got, expected );

  test.case = 'join array + number';
  var got = _.strJoin([ [ 1, 2 ], 3 ]);
  var expected = [ '13', '23' ];
  test.identical( got, expected );

  test.case = 'one argument';
  var got = _.strJoin([ '1' ]);
  var expected = '1';
  test.identical( got, expected );

  test.case = 'NaN argument';
  var got = _.strJoin([ '1', NaN ]);
  var expected = '1NaN';
  test.identical( got, expected );

  test.case = 'different types';
  var got = _.strJoin([ 1, '2', [ '3', 4 ], 5, '6' ]);
  var expected = [ "12356", "12456" ];
  test.identical( got, expected );

  test.case = 'different types with two arrays';
  var got = _.strJoin([ '1', 2, [ 3, 4, 5 ], [ 6, 7, 8 ] ]);
  var expected = [ "1236", "1247", "1258" ];
  test.identical( got, expected );

  test.close( 'single argument' );

  /* - */

  test.open( 'two arguments' );

  test.case = 'join number array with joiner';
  var got = _.strJoin( [ 1, 2 ], '3' );
  var expected = '132';
  test.identical( got, expected );

  test.case = 'join string array with joiner';
  var got = _.strJoin( [ 'b', 'c' ], '0' );
  var expected = 'b0c';
  test.identical( got, expected );

  test.case = 'join string array with joiner';
  var got = _.strJoin( [ 'Hello', 'world', '!' ], ' ' );
  var expected = 'Hello world !';
  test.identical( got, expected );

  test.case = 'join array and joiner';
  var got = _.strJoin( [ 0, [ '1', '2' ] ], '3' );
  var expected = [ '031', '032' ];
  test.identical( got, expected );

  test.case = 'join arrays and joiner';
  var got = _.strJoin( [ 0, [ '1', '2' ], [ 'a', 'b'] ], '-' );
  var expected = [ '0-1-a', '0-2-b' ];
  test.identical( got, expected );

  test.case = 'join umber arrays and joiner';
  var got = _.strJoin( [ [ 0, 3, 6 ], [ 1, 4, 7 ], [ 2, 5, 8 ] ], 'x' );
  var expected = [ '0x1x2', '3x4x5', '6x7x8' ];
  test.identical( got, expected );

  test.case = 'join array + string + joiner';
  var got = _.strJoin([ [ 1, 2 ], '3' ], '__');
  var expected = [ '1__3', '2__3' ];
  test.identical( got, expected );

  test.case = 'Undefined joiner';
  var got = _.strJoin([ [ 1, 2 ], '3' ], undefined );
  var expected = [ '13', '23' ];
  test.identical( got, expected );

  test.close( 'two arguments' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowError( function()
  {
    _.strJoin( );
  });

  test.case = 'Too many arguments';
  test.shouldThrowError( function()
  {
    _.strJoin( '1', '2', '3' );
  });

  test.case = 'Empty arguments';
  test.shouldThrowError( function()
  {
    _.strJoin( [ ], [ ] );
  });

  test.case = 'invalid argument type in array';
  test.shouldThrowError( function()
  {
    _.strJoin([ { a : 1 }, [ 1 ], [ 2 ] ]);
  });

  test.case = 'null argument in array';
  test.shouldThrowError( function()
  {
    _.strJoin([ '1', null ]);
  });

  test.case = 'null argument in array';
  test.shouldThrowError( function()
  {
    _.strJoin([ '1', undefined ]);
  });

  test.case = 'RegExp argument in array';
  test.shouldThrowError( function()
  {
    _.strJoin([ '1', /a?/ ]);
  });

  test.case = 'arrays with different lengths in array';
  test.shouldThrowError( function()
  {
    _.strJoin([ [ 1, 2 ], [ 1 ], [ 2 ] ]);
  });

  test.case = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strJoin( { a : 1 }, [ 1 ] );
  });

  test.case = 'null argument';
  test.shouldThrowError( function()
  {
    _.strJoin( [ '1' ], null, null );
  });

  test.case = 'NaN argument';
  test.shouldThrowError( function()
  {
    _.strJoin( [ '1' ], NaN );
  });

  test.case = 'Wrong argument';
  test.shouldThrowError( function()
  {
    _.strJoin( '1', 2 );
  });

  test.case = 'RegExp argument';
  test.shouldThrowError( function()
  {
    _.strJoin( '1', /a?/ );
  });

  test.case = 'arrays with different length';
  test.shouldThrowError( function()
  {
    _.strJoin( [ 1, 2 ], [ 1 ] );
  });

}

//

function strJoinPath( test )
{
  // Simple
  test.case = 'Empty';
  var got = _.strJoinPath( [ ], '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'join string array with joiner';
  var got = _.strJoinPath( [ 'b', 'c' ], '0' );
  var expected = 'b0c';
  test.identical( got, expected );

  test.case = 'join string array with joiner';
  var got = _.strJoinPath( [ 'Hello', 'world', '!' ], ' ' );
  var expected = 'Hello world !';
  test.identical( got, expected );

  test.case = 'join array with joiner';
  var got = _.strJoinPath( [ '1', '2', '4' ], '/' );
  var expected = '1/2/4';
  test.identical( got, expected );

  test.case = 'join array with joiner ( only numbers )';
  var got = _.strJoinPath( [ 1, 2, 4 ], '/' );
  var expected = '1/2/4';
  test.identical( got, expected );

  test.case = 'join array with joiner ( string and numbers )';
  var got = _.strJoinPath( [ 1, '4 is smaller than 2', 4 ], '/' );
  var expected = '1/4 is smaller than 2/4';
  test.identical( got, expected );


  test.case = 'join array and joiner';
  var got = _.strJoinPath( [ '0', [ '1', '2' ] ], '3' );
  var expected = [ '031', '032' ];
  test.identical( got, expected );

  test.case = 'join arrays and joiner';
  var got = _.strJoinPath( [ '0', [ '1', '2' ], [ 'a', 'b'] ], '-' );
  var expected = [ '0-1-a', '0-2-b' ];
  test.identical( got, expected );

  test.case = 'join arrays and joiner';
  var got = _.strJoinPath( [ [ '0', '3', '6' ], [ '1', '4', '7' ], [ '2', '5', '8' ] ], 'x' );
  var expected = [ '0x1x2', '3x4x5', '6x7x8' ];
  test.identical( got, expected );

  test.case = 'join array + string + joiner';
  var got = _.strJoinPath([ [ '1', '2' ], '3' ], '__');
  var expected = [ '1__3', '2__3' ];
  test.identical( got, expected );

  test.case = 'join array + string + joiner ( with numbers )';
  var got = _.strJoinPath([ [ 1, 2 ], 3, 'string' ], '__');
  var expected = [ '1__3__string', '2__3__string' ];
  test.identical( got, expected );

  //Joiner in src strings

  test.case = 'String does not end with joiner';
  var got = _.strJoinPath( [ 'Hi,', 'world' ], '/' );
  var expected = 'Hi,/world';
  test.identical( got, expected );

  test.case = 'String ends with joiner';
  var got = _.strJoinPath( [ 'Hi,', 'world' ], ',' );
  var expected = 'Hi,world';
  test.identical( got, expected );

  test.case = 'String ends with joiner';
  var got = _.strJoinPath( [ 'Hi,', 'world', 2 ], ',' );
  var expected = 'Hi,world,2';
  test.identical( got, expected );

  test.case = 'String does not begin with joiner';
  var got = _.strJoinPath( [ 'Hi', ',world' ], '/' );
  var expected = 'Hi/,world';
  test.identical( got, expected );

  test.case = 'String begins with joiner';
  var got = _.strJoinPath( [ 'Hi', ',world' ], ',' );
  var expected = 'Hi,world';
  test.identical( got, expected );

  test.case = 'String begins and ends with joiner';
  var got = _.strJoinPath( [ '/1/', '/2/', '/3/', 4, '/5/' ], '/' );
  var expected = '/1/2/3/4/5/';
  test.identical( got, expected );

  test.case = 'String begins and ends with joiner';
  var got = _.strJoinPath( [ '/1//', '/2//', '//4/' ], '/' );
  var expected = '/1//2///4/';
  test.identical( got, expected );


  /**/

  if( !Config.debug )
  return;

  test.case = 'No arguments';
  test.shouldThrowError( function()
  {
    _.strJoinPath( );
  });

  test.case = 'Too few arguments';
  test.shouldThrowError( function()
  {
    _.strJoinPath( [ '1' ] );
  });

  test.case = 'Too many arguments';
  test.shouldThrowError( function()
  {
    _.strJoinPath( [ '1' ], '2', '3' );
  });

  test.case = 'invalid argument type in array';
  test.shouldThrowError( function()
  {
    _.strJoinPath([ { a : 1 }, [ '1' ], [ '2' ] ], '/' );
  });

  test.case = 'null argument in array';
  test.shouldThrowError( function()
  {
    _.strJoinPath([ '1', null ], '/' );
  });

  test.case = 'null argument in array';
  test.shouldThrowError( function()
  {
    _.strJoinPath([ '1', undefined ], '/' );
  });

  test.case = 'RegExp argument in array';
  test.shouldThrowError( function()
  {
    _.strJoinPath([ '1', /a?/ ], '/' );
  });

  test.case = 'arrays with different lengths in array';
  test.shouldThrowError( function()
  {
    _.strJoinPath([ [ 1, 2 ], [ 1 ], [ 2 ] ], '/' );
  });

  test.case = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strJoinPath( { a : 1 }, [ 1 ] );
  });

  test.case = 'null argument';
  test.shouldThrowError( function()
  {
    _.strJoinPath( [ '1' ], null );
  });

  test.case = 'NaN argument';
  test.shouldThrowError( function()
  {
    _.strJoinPath( [ '1' ], NaN );
  });

  test.case = 'Wrong argument';
  test.shouldThrowError( function()
  {
    _.strJoinPath( '1', 2 );
  });

  test.case = 'RegExp argument';
  test.shouldThrowError( function()
  {
    _.strJoinPath( '1', /a?/ );
  });

  test.case = 'arrays with different length';
  test.shouldThrowError( function()
  {
    _.strJoinPath( [ [ 1, 2 ], [ 1 ] ], '/' );
  });

}

//

function strUnjoin( test )
{
  var any = _.strUnjoin.any;

  test.case = 'case 1';
  var got = _.strUnjoin( 'prefix_something_postfix',[ 'prefix', any, 'postfix' ] );
  var expected = [ "prefix", "_something_", "postfix" ];
  test.identical( got, expected );

  test.case = 'case 2a';
  var got = _.strUnjoin( 'prefix_something_postfix',[ any, 'something', 'postfix' ] );
  var expected = undefined;
  test.identical( got, expected );

  test.case = 'case 2b';
  var got = _.strUnjoin( 'prefix_something_postfix',[ any, 'something', any, 'postfix' ] );
  var expected = [ "prefix_", "something", '_', "postfix" ];
  test.identical( got, expected );

  test.case = 'case 3a';
  var got = _.strUnjoin( 'prefix_something_postfix', [ 'something', 'postfix', any ] );
  var expected = undefined;
  test.identical( got, expected );

  test.case = 'case 3b';
  var got = _.strUnjoin( 'prefix_something_postfix', [ any, 'something', any, 'postfix', any ] );
  var expected = [ "prefix_","something","_", "postfix", "" ];
  test.identical( got, expected );

  test.case = 'case 4';
  var got = _.strUnjoin( 'abc', [ any ] );
  var expected = [ "abc" ];
  test.identical( got, expected );

  test.case = 'case 5';
  var got = _.strUnjoin( 'abc', [ 'a', any ] );
  var expected = [ "a", "bc" ];
  test.identical( got, expected );

  test.case = 'case 5b';
  var got = _.strUnjoin( 'abc', [ any, 'a'  ] );
  var expected = undefined;
  test.identical( got, expected );

  test.case = 'case 6';
  var got = _.strUnjoin( 'abc', [ 'b', any ] );
  var expected = undefined;
  test.identical( got, expected );

  test.case = 'case 6b';
  var got = _.strUnjoin( 'abc', [ any, 'b' ] );
  var expected = undefined;
  test.identical( got, expected );

  test.case = 'case 7';
  var got = _.strUnjoin( 'abc', [ any, 'c' ] );
  var expected = [ "ab", "c" ];
  test.identical( got, expected );

  test.case = 'case 7b';
  var got = _.strUnjoin( 'abc', [ 'c', any ] );
  var expected = undefined;
  test.identical( got, expected );

  test.case = 'case 8';
  var got = _.strUnjoin( 'abc', [ 'a', any, 'c' ] );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'case 9';
  var got = _.strUnjoin( 'abc', [ any, 'b', any ] );
  var expected = [ 'a', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'case 9b';
  var got = _.strUnjoin( 'abc', [ any, 'c', any ] );
  var expected = [ 'ab', 'c', '' ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strUnjoin();
  });

  test.case = 'Not enough arguments';
  test.shouldThrowError( function()
  {
    _.strUnjoin( '1' );
  });

  test.case = 'Too many arguments';
  test.shouldThrowError( function()
  {
    _.strUnjoin( '1', '2', '3' );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( 123, [] );
  });

  test.case = 'invalid second arg type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( 'one two', 123 );
  });

  test.case = 'invalid array element type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( 'one two', [ 1, 'two' ] );
  });

  test.case = 'null first argument type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( null, [] );
  });

  test.case = 'null second arg type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( 'one two', null );
  });

  test.case = 'null array element type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( 'one two', [ null, 'two' ] );
  });

  test.case = 'NaN first argument type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( NaN, [] );
  });

  test.case = 'NaN second arg type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( 'one two', NaN );
  });

  test.case = 'NaN array element type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( 'one two', [ NaN, 'two' ] );
  });

  test.case = 'RegExp first argument type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( /\d$/, [] );
  });

  test.case = 'RegExp second arg type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( 'one two', /\D$/ );
  });

  test.case = 'RegExp array element type';
  test.shouldThrowError( function()
  {
    _.strUnjoin( 'one two', [ /^\d/, 'two' ] );
  });

}

//

function strUnicodeEscape( test )
{

  test.case = 'simple string';
  var got = _.strUnicodeEscape( 'prefix' );
  var expected = "\\u0070\\u0072\\u0065\\u0066\\u0069\\u0078";
  test.identical( got, expected );

  test.case = 'escaping';
  var got = _.strUnicodeEscape( '\npostfix//' );
  var expected = "\\u000a\\u0070\\u006f\\u0073\\u0074\\u0066\\u0069\\u0078\\u002f\\u002f";
  test.identical( got, expected );

  test.case = 'empty string';
  var got = _.strUnicodeEscape( '' );
  var expected = "";
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strUnicodeEscape( '1', '2', '3' );
  });

  test.case = 'invalid  argument type';
  test.shouldThrowError( function()
  {
    _.strUnicodeEscape( 123 );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strUnicodeEscape();
  });

}

//

function strCount( test )
{

  test.open( 'string' );

  test.case = 'none';
  var got = _.strCount( 'abc', 'z' );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'nl';
  var got = _.strCount( 'abc\ndef\nghi', '\n' );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'simple string';
  var got = _.strCount( 'ababacabacabaaba','aba' );
  var expected = 4;
  test.identical( got, expected );

  test.case = 'empty src';
  var got = _.strCount( '', 'abc' );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'empty ins';
  var got = _.strCount( 'abc', '' );
  var expected = 3;
  test.identical( got, expected );

  test.close( 'string' );

  /* */

  test.open( 'regexp' );

  test.case = 'none';
  var got = _.strCount( 'abc', /z/ );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'nl';
  var got = _.strCount( 'abc\ndef\nghi', /\n/m );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'simple string';
  var got = _.strCount( 'ababacabacabaaba', /aba/ );
  var expected = 4;
  test.identical( got, expected );

  test.case = 'empty src';
  var got = _.strCount( '', /a/ );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'empty ins';
  var got = _.strCount( 'abc', RegExp( '' ) );
  var expected = 3;
  test.identical( got, expected );

  test.close( 'regexp' );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function( )
  {
    _.strCount( );
  } );

  test.case = 'first argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strCount( [  ], '\n' );
  } );

  test.case = 'second argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strCount( 'abc\ndef\nghi', 13 );
  } );

  test.case = 'not enough arguments';
  test.shouldThrowError( function( )
  {
    _.strCount( 'abc\ndef\nghi' );
  } );

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strCount( '1', '2', '3' );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strCount( 123, '1' );
  });

  test.case = 'invalid second arg type';
  test.shouldThrowError( function()
  {
    _.strCount( 'one two', 123 );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strCount();
  });

}

//

function strDup( test )
{

  test.case = 'srcString  and number of times remain unchanged';
  var srcString = 'Hi, ';
  var times = 3;
  var got = _.strDup( srcString, times );

  var expected = 'Hi, Hi, Hi, ';
  test.identical( got, expected );

  var oldSrcString = 'Hi, ';
  test.identical( srcString, oldSrcString );

  var oldTimes = 3;
  test.identical( times, oldTimes );

  test.case = 'concatenation test';
  var got = _.strDup( 'a', 2 );
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'simple string';
  var got = _.strDup( 'ab', 2 );
  var expected = 'abab';
  test.identical( got, expected );

  test.case = 'invalid times value';
  var got = _.strDup( 'a', -2 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'zero times';
  var got = _.strDup( 'a', 0 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'returns the empty string';
  var got = _.strDup( 'abc ', 0 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'Second argument NaN';
  var got = _.strDup( 'abc', NaN );
  var expected = '';
  test.identical( got, expected );

  test.case = 'Two words with a spaces';
  var got = _.strDup( 'Hi world ', 2 );
  var expected = 'Hi world Hi world ';
  test.identical( got, expected );

  test.case = 'one space';
  var got = _.strDup( ' ', 2 );
  var expected = '  ';
  test.identical( got, expected );

  test.case = 'returns the first copy of the given string';
  var got = _.strDup( 'abc', 1 );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'copies and concatenates first argument three times';
  var got = _.strDup( 'abc', 3 );
  var expected = 'abcabcabc';
  test.identical( got, expected );

  test.case = 'copies and concatenates first argument 10 times';
  var got = _.strDup( '1', 10 );
  var expected = '1111111111';
  test.identical( got, expected );

  test.case = 'vectorized input concatenated negative times';
  var got = _.strDup( [ 'ab', 'cd', 'ef' ], - 2 );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'vectorized input concatenated zero times';
  var got = _.strDup( [ 'ab', 'cd', 'ef' ], 0 );
  var expected = [ '', '', '' ];
  test.identical( got, expected );

  test.case = 'vectorized input concatenated one time';
  var got = _.strDup( [ 'ab', 'cd', 'ef' ], 1 );
  var expected = [ 'ab', 'cd', 'ef' ];
  test.identical( got, expected );

  test.case = 'vectorized input concatenated 3 times';
  var got = _.strDup( [ 'ab', 'cd', 'ef' ], 3 );
  var expected = [ 'ababab', 'cdcdcd', 'efefef' ];
  test.identical( got, expected );

  test.case = 'Empty vectorized input';
  var got = _.strDup( [ ], 3 );
  var expected = [];
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strDup();
  });

  test.case = 'second argument is not provided';
  test.shouldThrowError( function( )
  {
    _.strDup( 'a' );
  } );

  test.case = 'first argument is not provided';
  test.shouldThrowError( function( )
  {
    _.strDup( 3 );
  } );

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strDup( '1' );
  });

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strDup( '1', '2', 3 );
  });

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strDup( '1', '2', '3' );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strDup( 123, 1 );
  });

  test.case = 'times is not number';
  test.shouldThrowError( function()
  {
    _.strDup( 'ab', [ 3, 4 ] );
  });

  test.case = 'invalid second arg type';
  test.shouldThrowError( function()
  {
    _.strDup( 'one', 'two'  );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strDup( 'a', 'wrong argument' );
  } );

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strDup( 1, 2 );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strDup( [ 1, 2 ], 2 );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strDup( [ '1', 2 ], 2 );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.strDup( '1', '2' );
  });

  test.case = 'null argument';
  test.shouldThrowError( function()
  {
    _.strDup( null, 2 );
  });

  test.case = 'null second argument';
  test.shouldThrowError( function()
  {
    _.strDup( '2', null );
  });

  test.case = 'undefined argument';
  test.shouldThrowError( function()
  {
    _.strDup( undefined, 2 );
  });

  test.case = 'undefined second argument';
  test.shouldThrowError( function()
  {
    _.strDup( '2', undefined );
  });

  test.case = 'NaN argument';
  test.shouldThrowError( function()
  {
    _.strDup( NaN, 2 );
  });

  test.case = 'Regexp argument';
  test.shouldThrowError( function()
  {
    _.strDup( /^\d/, 2 );
  });

  test.case = 'regExp second argument';
  test.shouldThrowError( function()
  {
    _.strDup( '2', /^\d/ );
  });


}

//

function strLinesSelect( test )
{
  var got, expected;
  var src = 'a\nb\nc\nd';

  /* */

  test.case = 'single line selection';

  /**/

  got = _.strLinesSelect( '', 1 );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( 'abc', 1 );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( 'abc', 0 );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, 1 );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, 2 );
  expected = 'b';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, -1 );
  expected = '';
  test.identical( got, expected );

  /* line number bigger then actual count of lines */

  got = _.strLinesSelect( src, 99 );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, 1, 2 );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 1, 2 ] );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ -1, 2 ] );
  expected = 'a';
  test.identical( got, expected );

  /* - */

  test.case = 'multiline selection';

  /**/

  got = _.strLinesSelect( src, [ -1, -1 ] );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( '', [ 1, 3 ] );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 1, 3 ] );
  expected = 'a\nb';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ -1, 2 ] );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 1, 4 ] );
  expected = 'a\nb\nc';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 99, 4 ] );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 1, 99 ] );
  expected = src;
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 2, 5 ] );
  expected = 'b\nc\nd';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect({ src : src, range : [ 2, 5 ], zero : 4 });
  expected = 'a';
  test.identical( got, expected );

  /* - */

  test.case = 'selection without range provided, selectMode : center';

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 2,
    numberOfLines : 3,
    selectMode : 'center',
    zero : 1
  });
  expected = 'a\nb\nc';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 3,
    selectMode : 'center',
    zero : 1
  });
  expected = 'a\nb';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 1,
    selectMode : 'center',
    zero : 1
  });
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 99,
    selectMode : 'center',
    zero : 1
  });
  expected = src;
  test.identical( got, expected );

  /**/

  var src = 'a\nb\nc\nd';
  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : -1,
    selectMode : 'center',
    zero : 1
  });
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 0,
    numberOfLines : 1,
    selectMode : 'center',
    zero : 1
  });
  expected = '';
  test.identical( got, expected );

  got = _.strLinesSelect
  ({
    src : '',
    line : 1,
    numberOfLines : 1,
    selectMode : 'center',
    zero : 1
  });
  expected = '';
  test.identical( got, expected );

  /* - */

  test.case = 'selection without range provided, selectMode : begin';

  /*two lines from begining of the string*/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 2,
    selectMode : 'begin',
    zero : 1
  });
  expected = 'a\nb';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : -1,
    numberOfLines : 2,
    selectMode : 'begin',
    zero : 1
  });
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 0,
    selectMode : 'begin',
    zero : 1
  });
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 99,
    selectMode : 'begin',
    zero : 1
  });
  expected = src;
  test.identical( got, expected );

  /* zero > range[ 0 ] */

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 5,
    selectMode : 'begin',
    zero : 2
  });
  expected = src;
  test.identical( got, expected );

  /* - */

  test.case = 'selection without range provided, selectMode : end';

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 4,
    numberOfLines : 2,
    selectMode : 'end'
  });
  expected = 'c\nd';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : -1,
    numberOfLines : 2,
    selectMode : 'end'
  });
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 0,
    selectMode : 'end'
  });
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 99,
    selectMode : 'end'
  });
  expected = 'a';
  test.identical( got, expected );

  /* zero > range[ 0 ] */

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 5,
    selectMode : 'end',
    zero : 2
  });
  expected = '';
  test.identical( got, expected );

  /* - */

  test.case = 'custom new line'
  var src2 = 'a b c d'

  /**/

  got = _.strLinesSelect
  ({
    src : src2,
    range : [ 1, 3 ],
    delimteter : ' '
  });
  expected = 'a b';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src2,
    range : [ 1, 3 ],
    delimteter : 'x'
  });
  expected = src2;
  test.identical( got, expected );

  /* - */

  test.case = 'number'

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    range : [ 1, 3 ],
    number : 1
  });
  expected = '1 : a\n2 : b';
  test.identical( got, expected );

  /* - */

  var src =
  `Lorem
  ipsum dolor
  sit amet,
  consectetur
  adipisicing
  elit`;

  /* - */

  test.case = 'first line';
  var got = _.strLinesSelect( src, 1 );
  var expected = 'Lorem';
  test.identical( got, expected );

  /* - */

  test.case = 'first two lines';
  var got = _.strLinesSelect( src, 1, 3 );
  var expected =
  `Lorem
  ipsum dolor`;
  test.identical( got, expected );

  /* - */

  test.case = 'range as array';
  var got = _.strLinesSelect( src, [ 1, 3 ] );
  var expected =
  `Lorem
  ipsum dolor`;
  test.identical( got, expected );



  test.case = 'custom new line';
  var src2 ='Lorem||ipsum dolor||sit amet||consectetur'
  var got = _.strLinesSelect( { src : src2, range : [ 3, 5 ], zero : 1, delimteter : '||' } );
  var expected = `sit amet||consectetur`;
  test.identical( got, expected );

  /* - */

  test.case = 'empty line, out of range';
  var got = _.strLinesSelect( { src : '', range : [ 1, 1 ] } );
  var expected = '';
  test.identical( got, expected );

  /* - */

  test.case = 'empty line';
  var got = _.strLinesSelect( { src : '', range : [ 0, 1 ] } );
  var expected = '';
  test.identical( got, expected );

  /* - */

  test.case = 'incorrect range';
  var got = _.strLinesSelect( { src :  src, range : [ 2, 1 ] } );
  var expected = '';
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strLinesSelect( 1, 1 );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.strLinesSelect( 'lorem\nipsum\n', 'second'  );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strLinesSelect( );
  });

  test.case = 'unknown property provided';
  test.shouldThrowError( function()
  {
    _.strLinesSelect( { src : 'lorem\nipsum\n', range : [ 0, 1 ], x : 1 } );
  });

}

//

function strLinesStrip( test )
{
  test.case = 'Argument is only one string';

  test.case = 'Src stays unchanged';
  var srcString = '\na\n\nbc\ndef\n';
  var got = _.strLinesStrip( srcString );

  var expected = 'a\nbc\ndef';
  test.identical( got, expected );

  var oldSrcString = '\na\n\nbc\ndef\n';
  test.identical( srcString, oldSrcString );

  test.case = 'Empty string';
  var got = _.strLinesStrip( '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'Only escape sequences';
  var got = _.strLinesStrip( '\n\t\r' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'String without escape sequences and begin/end spaces';
  var got = _.strLinesStrip( 'Hello world' );
  var expected = 'Hello world';
  test.identical( got, expected );

  test.case = 'String with begin/end spaces';
  var got = _.strLinesStrip( '  Hello world   ' );
  var expected = 'Hello world';
  test.identical( got, expected );

  test.case = 'String with begin/end escape sequences';
  var got = _.strLinesStrip( '\t\r\nHello world\r\n\t' );
  var expected = 'Hello world';
  test.identical( got, expected );

  test.case = 'String with escape sequences';
  var got = _.strLinesStrip( '\n\tHello\r\n\tworld\r\n' );
  var expected = 'Hello\nworld';
  test.identical( got, expected );

  test.case = 'String with escape sequences';
  var got = _.strLinesStrip( '\n\tHello\r\n\t\t\r\nworld\r\n'  );
  var expected = 'Hello\nworld';
  test.identical( got, expected );

  test.case = 'String with escape sequences and spaces';
  var got = _.strLinesStrip( '\n\tHello  \r\n\t\t\r\n World \t\r\n! \r\n\t'  );
  var expected = 'Hello\nWorld\n!';
  test.identical( got, expected );

  //

  test.case = 'Argument is only one array';

  test.case = 'Src stays unchanged';
  var srcArray = [ '\na\n\nbc\ndef\n' ];
  var got = _.strLinesStrip( srcArray );

  var expected = [ 'a\n\nbc\ndef' ];
  test.identical( got, expected );

  var oldSrcArray = [ '\na\n\nbc\ndef\n' ];
  test.identical( srcArray, oldSrcArray );

  test.case = 'Empty array';
  var got = _.strLinesStrip( [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'Empty array with empty string';
  var got = _.strLinesStrip( [ '' ] );
  var expected = [ ];
  test.identical( got, expected );

  test.case = 'Only escape sequences';
  var got = _.strLinesStrip( [ '', '\t\r\n' ] );
  var expected = [ ];
  test.identical( got, expected );

  test.case = 'String without escape sequences and begin/end spaces';
  var got = _.strLinesStrip( [ 'Hello world', '', '\t\r\n' ] );
  var expected = [ 'Hello world' ];
  test.identical( got, expected );

  test.case = 'String with begin/end spaces';
  var got = _.strLinesStrip( [ '  Hello ', ' world   ' ] );
  var expected = [ 'Hello', 'world' ];
  test.identical( got, expected );

  test.case = 'String with begin/end escape sequences';
  var got = _.strLinesStrip( [ '\t\r\nHello  ', '  world\r\n\t' ] );
  var expected = [ 'Hello', 'world' ];
  test.identical( got, expected );

  test.case = 'String with escape sequences';
  var got = _.strLinesStrip( [ '\n\tHello\r\n\tworld\r\n' ] );
  var expected = [ 'Hello\r\n\tworld' ];
  test.identical( got, expected );

  test.case = 'String with escape sequences';
  var got = _.strLinesStrip( '\n\tHello\r\n\t\t\r\nworld\r\n'  );
  var expected = 'Hello\nworld';
  test.identical( got, expected );

  test.case = 'String with escape sequences and spaces';
  var got = _.strLinesStrip( [ '\n\tHello  \r\n\t\t\r\n World \t\r\n! \r\n\t', '  \nHow are you?  \r  \n  \t  ' ] );
  var expected = [ 'Hello  \r\n\t\t\r\n World \t\r\n!', 'How are you?' ] ;
  test.identical( got, expected );

  //

  test.case = 'Several arguments';

  test.case = 'Several strings';
  var got = _.strLinesStrip( '\n\tHello  \r\n\t\t\r\n',' World \t\r\n! \r\n\t', ' \nHow are you?  ' );
  var expected = [ 'Hello', 'World\n!', 'How are you?' ] ;
  test.identical( got, expected );

  test.case = 'Several arrays';
  var got = _.strLinesStrip( [ '\n\tHello  \r\n\t\t\r\n', ' World \t\r\n! \r\n\t' ], [ ' \n\nHow  ', ' \r\nare\t', ' you \n ?  \r' ], [ '  \n\r\t ' ]  );
  var expected = [ [ 'Hello', 'World \t\r\n!' ], [ 'How', 'are', 'you \n ?' ], [ ] ];
  test.identical( got, expected );

  test.case = 'Several strings and arrays';
  var got = _.strLinesStrip( '\n\tHello  \r\n\t\t\r\n', [ ' World \t\r\n ', ' ! \r\n\t' ], [ ' \n\nHow  ', ' \r\nare\t', ' you \n ?  \r' ], ' I am \n\r\t good \n\n ' );
  var expected = [ 'Hello', [ 'World', '!' ], [ 'How', 'are', 'you \n ?' ], 'I am\ngood' ];
  test.identical( got, expected );

  //

  test.case = 'Compare input string and input array';

  test.case = 'Input String';
  var str = '\n\tHello  \r\n\t\t\r\n World \t\r\n! \r\n\t\nHow are you?  ';
  var gotStr = _.strLinesStrip( str );
  var expected = [ 'Hello', 'World', '!', 'How are you?'];
  test.identical( gotStr.split( '\n'), expected );

  test.case = 'Input Array';
  var str = '\n\tHello  \r\n\t\t\r\n World \t\r\n! \r\n\t\nHow are you?  ';
  var arrStr = str.split( '\n' );
  var gotArr = _.strLinesStrip( arrStr );
  var expected = [ 'Hello', 'World', '!', 'How are you?'];
  test.identical( gotArr, expected );

  test.case = 'Input one line string and array'
  var str = '\tHello  World \t! \r';
  var arrStr = [ str ];

  var gotStr = _.strLinesStrip( str );
  var gotArr = _.strLinesStrip( arrStr );
  test.identical( gotArr[ 0 ], gotStr );

  test.case = 'Input string and array'
  var str = '\n\tHello  \r\n\t\t\r\n World \t\r\n! \r\n\t';
  var arrStr = str.split( '\n' );

  var gotStr = _.strLinesStrip( str );
  var gotArr = _.strLinesStrip( arrStr );
  test.identical( gotArr, gotStr.split( '\n' ) );

  test.case = 'Several Inputs string and array'
  var strOne = '\n\tHello  \r\n\t\t\r\n World \t\r\n! \r\n\t';
  var arrStrOne = strOne.split( '\n' );

  var strTwo = '  How \n\n Are \r\n\t you   today \t\r\n? \r\n';
  var arrStrTwo = strTwo.split( '\n' );

  var strThree = '\n\t  I \t am \r\n\t \t\r\n Great ! ';
  var arrStrThree = strThree.split( '\n' );

  var gotStr = _.strLinesStrip( strOne, strTwo, strThree );
  var gotArr = _.strLinesStrip( arrStrOne, arrStrTwo, arrStrThree );
  test.identical( gotArr[ 0 ], gotStr[ 0 ].split( '\n' ) );
  test.identical( gotArr[ 1 ], gotStr[ 1 ].split( '\n' ) );
  test.identical( gotArr[ 2 ], gotStr[ 2 ].split( '\n' ) );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( () =>  _.strLinesStrip() );

  test.case = 'Wrong type of argument';
  test.shouldThrowError( () =>  _.strLinesStrip( null ) );
  test.shouldThrowError( () =>  _.strLinesStrip( undefined ) );
  test.shouldThrowError( () =>  _.strLinesStrip( NaN ) );
  test.shouldThrowError( () =>  _.strLinesStrip( 3 ) );
  test.shouldThrowError( () =>  _.strLinesStrip( [ 3 ] ) );
  test.shouldThrowError( () =>  _.strLinesStrip( /^a/ ) );

}

//

function strLinesNumber( test )
{
  var got, expected;

  test.case = 'trivial';

  test.case = 'returns the object';
  var got = _.strLinesNumber( 'abc\ndef\nghi' );
  var expected = '1 : abc\n2 : def\n3 : ghi';
  test.identical( got, expected );

  test.case = 'returns the object';
  var got = _.strLinesNumber( [] );
  var expected = '';
  test.identical( got, expected );

  /* - */

  test.case = 'string';

  /**/

  got = _.strLinesNumber( '' );
  expected = '1 : ';
  test.identical( got, expected );

  /**/

  got = _.strLinesNumber( 'a' );
  expected = '1 : a';
  test.identical( got, expected );

  /**/

  got = _.strLinesNumber( 'a\nb' );
  expected = '1 : a\n2 : b';
  test.identical( got, expected );

  /**/

  got = _.strLinesNumber( 'a\nb', 2 );
  expected = '2 : a\n3 : b';
  test.identical( got, expected );

  /**/

  got = _.strLinesNumber( 'line1\nline2\nline3' );
  expected =
  [
    '1 : line1',
    '2 : line2',
    '3 : line3',
  ].join( '\n' );
  test.identical( got, expected );

  /**/

  got = _.strLinesNumber( '\n\n' );
  var expected =
  [
    '1 : ',
    '2 : ',
    '3 : ',
  ].join( '\n' );
  test.identical( got, expected );

  /* - */

  test.case = 'array';

  /**/

  got = _.strLinesNumber( [ 'line1', 'line2', 'line3' ] );
  expected =
  [
    '1 : line1',
    '2 : line2',
    '3 : line3',
  ].join( '\n' );

  /**/

  got = _.strLinesNumber( [ 'line', 'line', 'line' ], 2 );
  expected =
  [
    '2 : line',
    '3 : line',
    '4 : line',
  ].join( '\n' );

  /**/

  got = _.strLinesNumber( [ 'line\n', 'line\n', 'line\n' ] );
  expected =
  [
    '1 : line\n',
    '2 : line\n',
    '3 : line\n',
  ].join( '\n' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function( )
  {
    _.strLinesNumber();
  } );

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strLinesNumber( 13 );
  } );

  test.case = 'invalid  argument type';
  test.shouldThrowError( function()
  {
    _.strLinesNumber( 123 );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strLinesNumber();
  });

}

//

function strLinesCount( test )
{

  test.case = 'returns 1';
  var func = 'function( x, y ) { return x + y; }';
  var got = _.strLinesCount( func );
  var expected = 1;
  test.identical( got, expected );

  test.case = 'returns 4';
  var func = 'function( x, y ) \n { \n   return x + y; \n }';
  var got = _.strLinesCount( func );
  var expected = 4;
  test.identical( got, expected );

  test.case = 'one line string test';
  var got = _.strLinesCount( 'one line' );
  var expected = 1;
  test.identical( got, expected );

  test.case = 'multiline string test';
  var got = _.strLinesCount( 'first line\nsecond line\nthird line' );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'multiline  text test';
  var got = _.strLinesCount( `one
                             two
                             three`
                          );
  var expected = 3;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strLinesCount( '1', '2' );
  });

  test.case = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strLinesCount( 123 );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strLinesCount();
  });

  test.case = 'no arguments';
  test.shouldThrowError( function( )
  {
    _.strLinesCount( );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strLinesCount( [ 1, '\n', 2 ] );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strLinesCount( 13 );
  } );

  test.case = 'too many arguments';
  test.shouldThrowError( function( )
  {
    _.strLinesCount( 'function( x, y ) \n { \n   return x + y; \n }', 'redundant argument' );
  } );

}

//

function strLinesNearest( test )
{

  var srcStr =
`
a
bc
def
ghij

`
;

  /* - */

  test.open( 'Range is a number' );

  /*  */

  test.open( 'numberOfLines : 0' );

  var crange = 6;
  var sub = _.strSub( srcStr, [ crange, crange + 1 ] );

  var expectedSplits =
  [
    '',
    'd',
    '',
  ];
  var expectedSpans = [ 6, 6, 7, 7 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 0,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'd' );

  test.close( 'numberOfLines : 0' );

  /*  */

  test.open( 'numberOfLines : 1' );

  var crange = 6;

  var expectedSplits =
  [
    '',
    'd',
    'ef',
  ];
  var expectedSpans = [ 6, 6, 7, 9 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 1,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );

  test.close( 'numberOfLines : 1' );

  /*  */

  test.open( 'numberOfLines : 2' );

  var crange = 6;

  var expectedSplits =
  [
    'bc\n',
    'd',
    'ef',
  ];
  var expectedSpans = [ 3, 6, 7, 9 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 2,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );

  test.close( 'numberOfLines : 2' );

  /*  */

  test.open( 'numberOfLines : 8 ( > all lines )' );

  var crange = 6;

  var expectedSplits =
  [
    '\na\nbc\n',
    'd',
    'ef\nghij\n\n',
  ];
  var expectedSpans = [ 0, 6, 7, 16 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 8,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );

  test.close( 'numberOfLines : 8 ( > all lines )' );

  /*  */

  test.open( 'NaN range' );

  var crange = NaN;

  var expectedSplits =
  [
    '',
    '',
    '',
  ];
  var expectedSpans = [ NaN, NaN, NaN, NaN ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 8,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );

  test.close( 'NaN range' );

  /*  */

  test.close( 'Range is a number' );

  /* - */

  test.open( 'aligned range, single line' );

  /*  */

  test.open( 'numberOfLines not defined ( = 3 )' );

  var crange = [ 3, 5 ];

  var expectedSplits =
  [
    'a\n',
    'bc',
    '\ndef',
  ];
  var expectedSpans = [ 1, 3, 5, 9 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : undefined,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );

  test.close( 'numberOfLines not defined ( = 3 )' );

  /*  */

  test.open( 'numberOfLines : NaN' );

  var crange = [ 3, 5 ];

  var expectedSplits =
  [
    '\na\n',
    'bc',
    '\ndef\nghij\n\n',
  ];
  var expectedSpans = [ undefined, 3, 5, undefined ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : NaN,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );

  test.close( 'numberOfLines : NaN' );

  /*  */

  test.open( 'numberOfLines : null' );

  var crange = [ 3, 5 ];

  var expectedSplits =
  [
    '',
    'bc',
    'bc',
  ];
  var expectedSpans = [ 3, 3, 5, 3 ];  // Could be wrong?

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : null,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );

  test.close( 'numberOfLines : null' );

  /*  */

  test.open( 'numberOfLines : 0' );

  var crange = [ 6,9 ];
  var sub = _.strSub( srcStr,crange );

  var expectedSplits =
  [
    '',
    'def',
    '',
  ];
  var expectedSpans = [ 6, 6, 9, 9 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 0,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'def' );

  test.close( 'numberOfLines : 0' );

  /*  */

  test.open( 'numberOfLines : 1' );

  var crange = [ 6,9 ];
  var sub = _.strSub( srcStr,crange );

  var expectedSplits =
  [
    '',
    'def',
    '',
  ];
  var expectedSpans = [ 6, 6, 9, 9 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 1,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'def' );

  test.close( 'numberOfLines : 1' );

  /* */

  test.open( 'numberOfLines : 2' );

  var crange = [ 6,9 ];
  var sub = _.strSub( srcStr,crange );

  var expectedSplits =
  [
    'bc\n',
    'def',
    '',
  ];
  var expectedSpans = [ 3, 6, 9, 9 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 2,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'def' );

  test.close( 'numberOfLines : 2' );

  /* */

  test.open( 'numberOfLines : 3' );

  var crange = [ 6,9 ];
  var sub = _.strSub( srcStr,crange );

  var expectedSplits =
  [
    'bc\n',
    'def',
    '\nghij',
  ];
  var expectedSpans = [ 3, 6, 9, 14 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 3,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'def' );

  test.close( 'numberOfLines : 3' );

  /* */

  test.open( 'numberOfLines : 4' );

  var crange = [ 6,9 ];
  var sub = _.strSub( srcStr,crange );

  var expectedSplits =
  [
    'a\nbc\n',
    'def',
    '\nghij',
  ];
  var expectedSpans = [ 1, 6, 9, 14 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 4,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'def' );

  test.close( 'numberOfLines : 4' );

  /* - */

  test.close( 'aligned range, single line' );

  /* - */

  test.open( 'not aligned range, several lines' );

  /*  */

  test.open( 'numberOfLines : 0' );

  var crange = [ 4,11 ];
  var sub = _.strSub( srcStr,crange );

  var expectedSplits =
  [
    '',
    'c\ndef\ng',
    '',
  ];
  var expectedSpans = [ 4, 4, 11, 11 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 0,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'c\ndef\ng' );

  test.close( 'numberOfLines : 0' );

  /*  */

  test.open( 'numberOfLines : 1' );

  var crange = [ 4,11 ];
  var sub = _.strSub( srcStr,crange );

  var expectedSplits =
  [
    'b',
    'c\ndef\ng',
    'hij',
  ];
  var expectedSpans = [ 3, 4, 11, 14 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 1,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'c\ndef\ng' );

  test.close( 'numberOfLines : 1' );

  /* */

  test.open( 'numberOfLines : 2' );

  var crange = [ 4,11 ];
  var sub = _.strSub( srcStr,crange );

  var expectedSplits =
  [
    'a\nb',
    'c\ndef\ng',
    'hij',
  ];
  var expectedSpans = [ 1, 4, 11, 14 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 2,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'c\ndef\ng' );

  test.close( 'numberOfLines : 2' );

  /* */

  test.open( 'numberOfLines : 3' );

  var crange = [ 4,11 ];
  var sub = _.strSub( srcStr,crange );

  var expectedSplits =
  [
    'a\nb',
    'c\ndef\ng',
    'hij\n',
  ];
  var expectedSpans = [ 1, 4, 11, 15 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 3,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'c\ndef\ng' );

  test.close( 'numberOfLines : 3' );

  /* */

  test.open( 'numberOfLines : 4' );

  var crange = [ 4,11 ];
  var sub = _.strSub( srcStr,crange );

  var expectedSplits =
  [
    '\na\nb',
    'c\ndef\ng',
    'hij\n',
  ];
  var expectedSpans = [ 0, 4, 11, 15 ];

  var got = _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 4,
  });

  test.will = 'check strLinesNearest';
  test.identical( got.splits, expectedSplits );
  test.identical( got.spans, expectedSpans );
  test.will = 'check strSub';
  test.identical( sub, 'c\ndef\ng' );

  test.close( 'numberOfLines : 4' );

  /* - */

  test.close( 'not aligned range, several lines' );

  debugger;

  console.log( 'done1' );
  logger.log( 'done2' );

  /* */

  if( !Config.debug )
  return;

  test.open( 'Wrong range' );

  var crange = [ 4, 11, 12 ];
  test.shouldThrowErrorSync( () =>  _.strLinesNearest
  ({
    src : srcStr,
    charsRange : crange,
    numberOfLines : 4,
  }));

  test.shouldThrowErrorSync( () =>  _.strLinesNearest
  ({
    src : srcStr,
    charsRange : null,
    numberOfLines : 4,
  }));

  test.shouldThrowErrorSync( () =>  _.strLinesNearest
  ({
    src : srcStr,
    charsRange : 'crange',
    numberOfLines : 4,
  }));

  test.shouldThrowErrorSync( () =>  _.strLinesNearest
  ({
    src : srcStr,
    numberOfLines : 4,
  }));

  test.close( 'Wrong range' );

  /*  */

  test.open( 'Wrong src' );

  var crange = [ 4, 11 ];
  test.shouldThrowErrorSync( () =>  _.strLinesNearest
  ({
    charsRange : crange,
    numberOfLines : 4,
  }));

  test.shouldThrowErrorSync( () =>  _.strLinesNearest
  ({
    src : null,
    charsRange : crange,
    numberOfLines : 4,
  }));

  test.shouldThrowErrorSync( () =>  _.strLinesNearest
  ({
    src : NaN,
    charsRange : crange,
    numberOfLines : 4,
  }));

  test.shouldThrowErrorSync( () =>  _.strLinesNearest
  ({
    src : undefined,
    charsRange : crange,
    numberOfLines : 4,
  }));

  test.shouldThrowErrorSync( () =>  _.strLinesNearest
  ({
    src : 3,
    charsRange : crange,
    numberOfLines : 4,
  }));

  test.shouldThrowErrorSync( () =>  _.strLinesNearest
  ({
    src : [ 'abd', 'ef' ],
    charsRange : crange,
    numberOfLines : 4,
  }));

  test.close( 'Wrong src' );

  /*  */

  test.open( 'Wrong arg' );

  test.shouldThrowErrorSync( () =>  _.strLinesNearest( 3 ));
  test.shouldThrowErrorSync( () =>  _.strLinesNearest( [ 3, 4 ] ));
  test.shouldThrowErrorSync( () =>  _.strLinesNearest( null ));
  test.shouldThrowErrorSync( () =>  _.strLinesNearest( undefined ));
  test.shouldThrowErrorSync( () =>  _.strLinesNearest( NaN ));
  test.shouldThrowErrorSync( () =>  _.strLinesNearest( 'args' ));

  let o =
  {
    src : [ 'abd', 'ef' ],
    charsRange : crange,
    numberOfLines : 4,
  };
  test.shouldThrowErrorSync( () =>  _.strLinesNearest(  ));
  test.shouldThrowErrorSync( () =>  _.strLinesNearest( o, o ));


  test.close( 'Wrong arg' );

}

//

function strLinesRangeWithCharRange( test )
{

  test.open( 'embraced by empty lines' );

  var srcStr =
`
a
bc
def
ghij

`
;

  test.case = 'single line in the middle'; /* */

  var crange = [ 3,5 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 2,3 ] );
  test.identical( sub, 'bc' );

  test.case = 'line in the middle with NL'; /* */

  var crange = [ 3,6 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 2,4 ] );
  test.identical( sub, 'bc\n' );

  test.case = 'single line in the beginning'; /* */

  var crange = [ 1,2 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 1,2 ] );
  test.identical( sub, 'a' );

  test.case = 'line in the beginning with NL'; /* */

  var crange = [ 1,3 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 1,3 ] );
  test.identical( sub, 'a\n' );

  test.case = 'single line in the end'; /* */

  var crange = [ 10,14 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 4,5 ] );
  test.identical( sub, 'ghij' );

  test.case = 'line in the end with NL'; /* */

  var crange = [ 10,15 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 4,6 ] );
  test.identical( sub, 'ghij\n' );

  test.case = 'not aligned range with multiple lines'; /* */

  var crange = [ 4,11 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 2,5 ] );
  test.identical( sub, 'c\ndef\ng' );

  test.case = 'empty line in the beginning'; /* */

  var crange = [ 0,0 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 0,1 ] );
  test.identical( sub, '' );

  test.case = 'empty line in the end'; /* */

  var crange = [ 15,15 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 5,6 ] );
  test.identical( sub, '' );

  test.close( 'embraced by empty lines' );

  /* */

  test.open( 'not embraced by empty lines' );

  var srcStr =
`a
bc
def
ghij`
;

  test.case = 'single line in the middle'; /* */

  var crange = [ 2,4 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 1,2 ] );
  test.identical( sub, 'bc' );

  test.case = 'line in the middle with NL'; /* */

  var crange = [ 2,5 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 1,3 ] );
  test.identical( sub, 'bc\n' );

  test.case = 'single line in the beginning'; /* */

  var crange = [ 0,1 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 0,1 ] );
  test.identical( sub, 'a' );

  test.case = 'line in the beginning with NL'; /* */

  var crange = [ 0,2 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 0,2 ] );
  test.identical( sub, 'a\n' );

  test.case = 'single line in the end'; /* */

  var crange = [ 9,13 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 3,4 ] );
  test.identical( sub, 'ghij' );

  test.case = 'line in the end with NL'; /* */

  var crange = [ 9,14 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 3,4 ] );
  test.identical( sub, 'ghij' );

  test.case = 'not aligned range with multiple lines'; /* */

  var crange = [ 3,10 ];
  var sub = _.strSub( srcStr,crange );
  var lrange = _.strLinesRangeWithCharRange( srcStr, crange );
  test.identical( lrange, [ 1,4 ] );
  test.identical( sub, 'c\ndef\ng' );

  test.close( 'not embraced by empty lines' );

}

//

function strStrShort( test )
{

  test.case = 'simple string';
  var got = _.strStrShort( 'string', 4 );
  var expected = '\'st\' ... \'ng\'';
  test.identical( got, expected );

  test.case = 'string with escaping';
  var got = _.strStrShort( 's\ntring', 4 );
  var expected = '\'s\' ... \'ng\'';
  test.identical( got, expected );

  test.case = 'limit 0';
  var got = _.strStrShort( 'string', 0 );
  var expected = 'string';
  test.identical( got, expected );

  test.case = 'limit 1';
  var got = _.strStrShort( 'string', 1 );
  var expected = '\'s\'';
  test.identical( got, expected );

  test.case = 'string wih spaces';
  var got = _.strStrShort( 'source and', 5 );
  var expected = '\'sou\' ... \'nd\'';
  test.identical( got, expected );

  test.case = 'one argument call';
  var got = _.strStrShort( { src : 'string', limit : 4, wrap : "'" } );
  var expected = "'st' ... 'ng'";
  test.identical( got, expected );

  test.case = 'string with whitespaces';
  var got = _.strStrShort( { src : '  simple string   ', limit : 4, wrap : "'" } );
  var expected = "'  ' ... '  '";
  test.identical( got, expected );

  test.case = 'wrap 0';
  var got = _.strStrShort( { src : 'simple', limit : 4, wrap : 0 } );
  var expected = "si ... le";
  test.identical( got, expected );

  test.case = 'escaping 0';
  var got = _.strStrShort( { src : 'si\x01mple', limit : 5, wrap : '"',escaping : 0  } );
  var expected = '"si\x01" ... "le"';
  test.identical( got, expected );

  test.case = 'escaping 1';
  var got = _.strStrShort( { src : 's\u001btring', limit : 4, wrap : '"' } );
  var expected = '"s" ... "ng"';
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strStrShort( 1, 5 );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.strStrShort( 'string', '0' );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strStrShort();
  });

  test.case = 'unknown property provided';
  test.shouldThrowError( function()
  {
    _.strStrShort( { src : 'string', limit : 4, wrap : 0, fixed : 5 } );
  });

}

//

function strCommonLeft( test )
{
  test.case = 'no args';
  var got = _.strCommonLeft( );
  var expected = '';
  test.identical( got, expected );

  test.case = 'one argument';
  var got = _.strCommonLeft( 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'ins is empty string';
  var got = _.strCommonLeft( '', 'a', 'b' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'one string is empty';
  var got = _.strCommonLeft( 'abc', '', 'abc', 'ada' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'no match';
  var got = _.strCommonLeft( 'abcd', 'abc', 'd' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'several strings';
  var got = _.strCommonLeft( 'abc', 'abd', 'abc', 'ada' );
  var expected = 'a';
  test.identical( got, expected );

  test.case = 'several strings';
  var got = _.strCommonLeft( 'abcd', 'ab', 'abc', 'a' );
  var expected = 'a';
  test.identical( got, expected );

  test.case = 'Several character string';
  var got = _.strCommonLeft( 'abc', 'abcd', 'abcde', 'abcdef' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'Several character string';
  var got = _.strCommonLeft( 'abcdef', 'abcd', 'abcde', 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'Several character string';
  var got = _.strCommonLeft( 'abcd', 'abc', 'abcd' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'One arg is not a string';
  var got = _.strCommonLeft( 'abcd', 'abc', 3 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'One arg is not a string';
  var got = _.strCommonLeft( 'abcd', 'abc', NaN );
  var expected = '';
  test.identical( got, expected );

  test.case = 'One arg is not a string';
  var got = _.strCommonLeft( 'abcd', 'ab', 'abc', [ 3 ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'One arg is not a string';
  var got = _.strCommonLeft( 'abcd', 'ab', 'abc', /a/ );
  var expected = '';
  test.identical( got, expected );

  test.case = 'One arg is not a string';
  var got = _.strCommonLeft( 'abcd', 'ab', 'abc', [ 'abc' ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'no match case';
  var got = _.strCommonLeft( 'abcd', 'ab', 'Abc' );
  var expected = '';
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'ins is array';
  test.shouldThrowError( function( )
  {
    _.strCommonLeft( ['a','b','c'], 'abd', 'abc', 'ada' );
  });

  test.case = 'ins is number';
  test.shouldThrowError( function( )
  {
    _.strCommonLeft( 3, 'abd', 'abc', 'ada' );
  });

  test.case = 'ins is regExp';
  test.shouldThrowError( function( )
  {
    _.strCommonLeft( /^a/, 'abd', 'abc', 'ada' );
  });

  test.case = 'ins is NaN';
  test.shouldThrowError( function( )
  {
    _.strCommonLeft( NaN, 'abd', 'abc', 'ada' );
  });

  test.case = 'ins is null';
  test.shouldThrowError( function( )
  {
    _.strCommonLeft( null, 'abd', 'abc', 'ada' );
  });

  test.case = 'One arg null';
  test.shouldThrowError( function( )
  {
    _.strCommonLeft( 'abd', 'abc', 'ada', null );
  });

  test.case = 'ins is undefined';
  test.shouldThrowError( function( )
  {
    _.strCommonLeft( undefined, 'abd', 'abc', 'ada' );
  });

  test.case = 'One arg undefined';
  test.shouldThrowError( function( )
  {
    _.strCommonLeft( 'abd', 'abc', 'ada', undefined );
  });

}

//

function strCommonRight( test )
{
  test.case = 'no args';
  var got = _.strCommonRight( );
  var expected = '';
  test.identical( got, expected );

  test.case = 'one argument';
  var got = _.strCommonRight( 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.case = 'ins is empty string';
  var got = _.strCommonRight( '', 'ab', 'b' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'one string is empty';
  var got = _.strCommonRight( 'abc', '', 'abc', 'bc' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'no match';
  var got = _.strCommonRight( 'abcd', 'abc', 'd' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'several strings';
  var got = _.strCommonRight( 'a', 'cba', 'dba', 'ada' );
  var expected = 'a';
  test.identical( got, expected );

  test.case = 'several strings';
  var got = _.strCommonRight( 'abcd', 'cd', 'abcd', 'd' );
  var expected = 'd';
  test.identical( got, expected );

  test.case = 'Several character string';
  var got = _.strCommonRight( 'cdef', 'abcdef', 'def', 'bcdef' );
  var expected = 'def';
  test.identical( got, expected );

  test.case = 'Several character string';
  var got = _.strCommonRight( 'abcdef', 'bcdef', 'cdef', 'def' );
  var expected = 'def';
  test.identical( got, expected );

  test.case = 'Several character string';
  var got = _.strCommonRight( 'abcd', 'bcd', 'abcd' );
  var expected = 'bcd';
  test.identical( got, expected );

  test.case = 'One arg is not a string';
  var got = _.strCommonRight( 'abc', 'abc', 3 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'One arg is not a string';
  var got = _.strCommonRight( 'acde', 'bcde', NaN );
  var expected = '';
  test.identical( got, expected );

  test.case = 'One arg is not a string';
  var got = _.strCommonRight( 'abcd', 'abd', 'ad', [ 3 ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'One arg is not a string';
  var got = _.strCommonRight( 'c', 'bc', 'abc', /c/ );
  var expected = '';
  test.identical( got, expected );

  test.case = 'One arg is not a string';
  var got = _.strCommonRight( 'abcd', 'cd', 'bcd', [ 'abcd' ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'no match case';
  var got = _.strCommonRight( 'abcd', 'cD', 'AbcD' );
  var expected = '';
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'ins is array';
  test.shouldThrowError( function( )
  {
    _.strCommonRight( ['a','b','c'], 'abd', 'abc', 'ada' );
  });

  test.case = 'ins is number';
  test.shouldThrowError( function( )
  {
    _.strCommonRight( 3, 'abd', 'abc', 'ada' );
  });

  test.case = 'ins is regExp';
  test.shouldThrowError( function( )
  {
    _.strCommonRight( /^a/, 'abd', 'abc', 'ada' );
  });

  test.case = 'ins is NaN';
  test.shouldThrowError( function( )
  {
    _.strCommonRight( NaN, 'abd', 'abc', 'ada' );
  });

  test.case = 'ins is null';
  test.shouldThrowError( function( )
  {
    _.strCommonRight( null, 'abd', 'abc', 'ada' );
  });

  test.case = 'One arg null';
  test.shouldThrowError( function( )
  {
    _.strCommonRight( 'abd', 'abc', 'ada', null );
  });

  test.case = 'ins is undefined';
  test.shouldThrowError( function( )
  {
    _.strCommonRight( undefined, 'abd', 'abc', 'ada' );
  });

  test.case = 'One arg undefined';
  test.shouldThrowError( function( )
  {
    _.strCommonRight( 'abd', 'abc', 'ada', undefined );
  });

}

//

function strExtractInlined( test )
{

  function onInlined( part )
  {
    var temp = part.split( ':' )
    if( temp.length === 2 )
    {
      return temp;
    }
    return undefined;
  }

  /* */

  test.case = 'empty';
  var srcStr = '';
  var got = _.strExtractInlined( srcStr );
  var expected = [ '' ];
  test.identical( got, expected );

  /* */

  test.case = 'without inlined text';
  var srcStr = 'a';
  var got = _.strExtractInlined( srcStr );
  var expected = [ 'a' ];
  test.identical( got, expected );

  /* */

  test.case = 'default options';
  var srcStr = 'ab#cd#ef';
  var got = _.strExtractInlined( srcStr );
  var expected = [ 'ab', [ 'cd' ], 'ef' ];
  test.identical( got, expected );

  /* */

  test.case = 'trivial case';
  var srcStr = 'this #background:red#is#background:default# text and is not';
  var got = _.strExtractInlined({ src : srcStr, onInlined : onInlined,  });
  var expected =
  [
    'this ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and is not'
  ];
  test.identical( got, expected );

  /* */

  test.case = 'openning delimeter # does not have closing';
  var srcStr = 'this #background:red#is#background:default# text and # is not';
  var got = _.strExtractInlined({ src : srcStr, onInlined : onInlined,  });
  var expected =
  [
    'this ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and # is not'
  ];
  test.identical( got, expected );

  /* */

  test.case = 'two inlined substrings is not in fact inlined';
  var srcStr = '#simple # text #background:red#is#background:default# text and # is not#';
  var got = _.strExtractInlined({ src : srcStr, onInlined : onInlined,  });
  var expected =
  [
    '#simple # text ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and # is not#'
  ];
  test.identical( got, expected );

  /* */

  test.case = 'inlined at the beginning and false inlined';
  var srcStr = '#background:red#i#s#background:default##text';
  var got = _.strExtractInlined({ src : srcStr, onInlined : onInlined,  });
  var expected =
  [
    '', [ 'background', 'red' ], 'i#s', [ 'background', 'default' ], '#text'
  ];
  test.identical( got, expected );

  /* */

  test.case = 'inlined at the beginning and the end';
  var srcStr = '#background:red#i#s#background:default#';
  var got = _.strExtractInlined({ src : srcStr, onInlined : onInlined,  });
  var expected =
  [
    '', [ 'background', 'red' ], 'i#s', [ 'background', 'default' ], ''
  ];
  test.identical( got, expected );

  /* */

  test.case = 'inlined at the beginning and the end with preservingEmpty:0';
  var srcStr = '#background:red#i#s#background:default#';
  var got = _.strExtractInlined({ src : srcStr, onInlined : onInlined, preservingEmpty : 0 });
  var expected =
  [
    [ 'background', 'red' ], 'i#s', [ 'background', 'default' ],
  ];
  test.identical( got, expected );

  /* */

  test.case = 'wrapped by inlined text';
  var srcStr = '#background:red#text#background:default#';
  var got = _.strExtractInlined({ src : srcStr, onInlined : onInlined,  } );
  var expected =
  [
    '', [ 'background', 'red' ], 'text', [ 'background', 'default' ], '',
  ];
  test.identical( got, expected );

  /* */ //

  test.case = 'preservingEmpty:0, no empty';
  var srcStr = '#inline1#ordinary#inline2#';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0 });
  var expected =
  [
    [ 'inline1' ], 'ordinary', [ 'inline2' ],
  ];
  test.identical( got, expected );

  /* */

  test.case = 'preservingEmpty:0, empty left';
  var srcStr = '##ordinary#inline2#';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0 });
  var expected =
  [
    [ '' ], 'ordinary', [ 'inline2' ],
  ];
  test.identical( got, expected );

  /* */

  test.case = 'preservingEmpty:0, empty right';
  var srcStr = '#inline1#ordinary##';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0 });
  var expected =
  [
    [ 'inline1' ], 'ordinary', [ '' ],
  ];
  test.identical( got, expected );

  /* */

  test.case = 'preservingEmpty:0, empty middle';
  var srcStr = '#inline1##inline2#';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0 });
  var expected =
  [
    [ 'inline1' ], [ 'inline2' ],
  ];
  test.identical( got, expected );

  /* */

  test.case = 'preservingEmpty:0, empty all';
  var srcStr = '####';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0 });
  var expected = [ [ '' ],[ '' ] ];
  test.identical( got, expected );

  /* */

  test.case = 'preservingEmpty:0, empty all';
  var srcStr = '';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0 });
  var expected = [];
  test.identical( got, expected );

  /* */ //

  test.case = 'preservingEmpty:0, onInlined:null no empty';
  var srcStr = '#inline1#ordinary#inline2#';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0, onInlined:null });
  var expected =
  [
    'inline1', 'ordinary', 'inline2',
  ];
  test.identical( got, expected );

  /* */

  test.case = 'preservingEmpty:0, onInlined:null, empty left';
  var srcStr = '##ordinary#inline2#';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0, onInlined:null });
  var expected =
  [
    'ordinary', 'inline2',
  ];
  test.identical( got, expected );

  /* */

  test.case = 'preservingEmpty:0, onInlined:null, empty right';
  var srcStr = '#inline1#ordinary##';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0, onInlined:null });
  var expected =
  [
    'inline1', 'ordinary',
  ];
  test.identical( got, expected );

  /* */

  test.case = 'preservingEmpty:0, onInlined:null, empty middle';
  var srcStr = '#inline1##inline2#';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0, onInlined:null });
  var expected =
  [
    'inline1', 'inline2',
  ];
  test.identical( got, expected );

  /* */

  test.case = 'preservingEmpty:0, onInlined:null, empty all';
  var srcStr = '####';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0, onInlined:null });
  var expected = [];
  test.identical( got, expected );

  /* */

  test.case = 'preservingEmpty:0, onInlined:null, empty all';
  var srcStr = '';
  var got = _.strExtractInlined({ src : srcStr, preservingEmpty : 0, onInlined:null });
  var expected = [];
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'too many arguments';
  test.shouldThrowError( () => { debugger; _.strExtractInlined( '',{},'' ) } );

}

//

function strExtractInlinedStereo( test )
{
  var got, expected;

  test.case = 'default';

  /* nothing */

  got = _.strExtractInlinedStereo( '' );
  expected = [ '' ];
  test.identical( got, expected );

  /* prefix/postfix # by default*/

  debugger;
  got = _.strExtractInlinedStereo( '#abc#' );
  debugger;
  expected = [ '', 'abc', '' ];
  test.identical( got, expected );

  /* - */

  test.case = 'with options';

  /* pre/post are same*/

  got = _.strExtractInlinedStereo( { prefix : '/', postfix : '/', src : '/abc/' } );
  expected = [ '', 'abc', '' ];
  test.identical( got, expected );

  /**/

  got = _.strExtractInlinedStereo( { prefix : '/', postfix : '/', src : '//abc//' } );
  expected = [ '', '', 'abc', '', '' ];
  test.identical( got, expected );

  /* different pre/post */

  got = _.strExtractInlinedStereo( { prefix : '/#', postfix : '#', src : '/#abc#' } );
  expected = [ 'abc' ];
  test.identical( got, expected );

  /* postfix appears in source two times */
  got = _.strExtractInlinedStereo( { prefix : '/', postfix : '#', src : '/ab#c#' } );
  expected = [ 'ab', 'c#' ];
  test.identical( got, expected );

  /* onInlined #1 */
  function onInlined1( strip )
  {
    if( strip.length )
    return strip;
  }
  got = _.strExtractInlinedStereo( { onInlined : onInlined1, src : '#abc#' } );
  expected = [ '#abc#' ];
  test.identical( got, expected );

  /* onInlined #2 */
  function onInlined2( strip )
  {
    return strip + strip;
  }
  got = _.strExtractInlinedStereo( { prefix : '/', postfix : '#', onInlined : onInlined2, src : '/abc#' } );
  expected = [ 'abcabc' ];
  test.identical( got, expected );

}

//

var Self =
{

  name : 'Tools/base/l2/String',
  silencing : 1,
  enabled : 1,

  tests :
  {

    strRemoveBegin,
    strRemoveEnd,
    strRemove,

    strReplaceBegin,
    strReplaceEnd,
    strReplace,

    strPrependOnce,
    strAppendOnce,

    /* - */

    strForRange,
    strCapitalize,

    strIndentation,

    strSplitsCoupledGroup,

    strSplitFast,
    strSplitFastRegexp,
    strSplit,
    // strSplitNaive,

    strSplitStrNumber,

    strStrip,
    strStripLeft,
    strStripRight,
    strRemoveAllSpaces,
    strStripEmptyLines,
    strSub,
    strReplaceWords,
    strJoin,
    strJoinPath,
    strUnjoin,
    strUnicodeEscape,
    strCount,
    strDup,

    strLinesSelect,
    strLinesStrip,
    strLinesNumber,
    strLinesCount,

    strLinesNearest,
    strLinesRangeWithCharRange,

    strStrShort,
    strCommonLeft,
    strCommonRight,

    strExtractInlined,
    strExtractInlinedStereo,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
