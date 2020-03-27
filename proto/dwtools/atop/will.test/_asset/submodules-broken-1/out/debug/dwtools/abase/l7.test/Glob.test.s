( function _Glob_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../../dwtools/Tools.s' );
  _.include( 'wTesting' );
  require( '../l5/PathTools.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// tests
// --

function fromGlob( test )
{

  test.case = 'trailed';
  var expected = '/a/b/';
  var got = _.path.fromGlob( '/a/b/' );
  test.identical( got, expected );

  test.case = 'doted';
  var expected = './a/b';
  var got = _.path.fromGlob( './a/b' );
  test.identical( got, expected );

  var expected = '/a/b';
  var got = _.path.fromGlob( '/a/b/**' );
  test.identical( got, expected );

  var expected = '/a';
  var got = _.path.fromGlob( '/a/b**' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/(src1|src2)/**' );
  test.identical( got, expected );

  var expected = '/a';
  var got = _.path.fromGlob( '/a/(src1|src2)/**' );
  test.identical( got, expected );

  /* - */

  test.open( 'base marker *()' );

  var expected = '/';
  var got = _.path.fromGlob( '/src1*()' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/*()src1' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/src1*()/src2' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/*()src1/src2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/sr*()c2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/src2*()' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/*()src2' );
  test.identical( got, expected );

  test.close( 'base marker *()' );

  /* - */

  test.open( 'base marker ()' );

  var expected = '/';
  var got = _.path.fromGlob( '/src1()' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/()src1' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/src1()/src2' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/()src1/src2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/sr()c2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/src2()' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/()src2' );
  test.identical( got, expected );

  test.close( 'base marker ()' );

  /* - */

  test.open( 'base marker \\0' );

  var expected = '/';
  var got = _.path.fromGlob( '/src1\0' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/\0src1' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/src1\0/src2' );
  test.identical( got, expected );

  var expected = '/';
  var got = _.path.fromGlob( '/\0src1/src2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/sr\0c2' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/src2\0' );
  test.identical( got, expected );

  var expected = '/src1';
  var got = _.path.fromGlob( '/src1/\0src2' );
  test.identical( got, expected );

  test.close( 'base marker \\0' );

  /* - */

}

//

function globSplitToRegexp( test )
{

  var got = _.path.globSplitToRegexp( '**/b/**' );
  var expected = /^.*\/b\/.*$/;
  test.identical( got, expected );

}

//

function _globAnalogs1( test )
{

  test.case = '**proto**dir2**';
  var src = '**proto**dir2**';
  var expected = '***/*proto*/***/*dir2*/***';
  var got = _.path._globAnalogs1( src );
  test.identical( got, expected );

  test.case = '**proto/**/dir2**';
  var src = '**proto/**/dir2**';
  var expected = '***/*proto/**/dir2*/***';
  var got = _.path._globAnalogs1( src );
  test.identical( got, expected );

}

//

function _globAnalogs2( test )
{

  /* */

  var got = _.path._globAnalogs2( '/**/b/**', '/a', '/a/b/c' );
  var expected = [ '../../**/b/**', './**/b/**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/doubledir/d1/**', '/doubledir/d1', '/doubledir/d1/d11' );
  var expected = [ '../**', './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/doubledir/d1/**', '/doubledir', '/doubledir/d1/d11' );
  var expected = [ '../../d1/**', './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/doubledir/d1/*', '/doubledir', '/doubledir/d1/d11' );
  var expected = [ '../../d1/*', './*' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/doubledir/d1/*', '/doubledir2', '/doubledir2/d1/d11' );
  var expected = [];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/src1/**', '/src2', '/src2' );
  var expected = [];
  test.identical( got, expected );

  var got = _.path._globAnalogs2( '/src2/**', '/src2', '/src2' );
  var expected = [ './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/src1/**', '/src2', '/' );
  var expected = [];
  test.identical( got, expected );

  var got = _.path._globAnalogs2( '/src2/**', '/src2', '/' );
  var expected = [ './src2/**' ];
  test.identical( got, expected );

  var got = _.path._globAnalogs2( '/src1/**', '/', '/src2' );
  var expected = [ '../src1/**' ];
  test.identical( got, expected );

  var got = _.path._globAnalogs2( '/src2/**', '/', '/src2' );
  var expected = [ '../src2/**', './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._globAnalogs2( '/src1/**', '/src2', '/src1' );
  var expected = [];
  test.identical( got, expected );

  var got = _.path._globAnalogs2( '/src1/**', '/src1', '/src2' );
  var expected = [ '../src1/**' ];
  test.identical( got, expected );

  /* - */

  test.shouldThrowErrorSync( () =>
  {
    var expected = [ './file' ];
    var globPath = 'src1Terminal/file';
    var filePath = '/';
    var basePath = '/src1Terminal';
    var got = _.path._globAnalogs2( globPath, filePath, basePath );
    test.identical( got, expected );
  });

  test.shouldThrowErrorSync( () =>
  {
    var expected = [ '../../b/c/f' ];
    var globPath = 'f';
    var filePath = '/a/b/c';
    var basePath = '/a/d/e';
    var got = _.path._globAnalogs2( globPath, filePath, basePath );
    test.identical( got, expected );
  });

  test.shouldThrowErrorSync( () =>
  {
    var got = _.path._globAnalogs2( '/src1Terminal', '/', '/src1Terminal' )
    var expected = [ '.' ];
    test.identical( got, expected );
  });

}

// function _globAnalogs2( test )
// {
//
//   var expected = [ '../src1Terminal/file', './file' ];
//   var globPath = 'src1Terminal/file';
//   var filePath = '/';
//   var basePath = '/src1Terminal';
//   var got = _.path._globAnalogs2( globPath, filePath, basePath );
//   test.identical( got, expected );
//
//   var expected = [ '../../b/c/f' ];
//   var globPath = 'f';
//   var filePath = '/a/b/c';
//   var basePath = '/a/d/e';
//   var got = _.path._globAnalogs2( globPath, filePath, basePath );
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._globAnalogs2( '/src1Terminal', '/', '/src1Terminal' )
//   var expected = [ '../src1Terminal', '.' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._globAnalogs2( '**/b/**', '/a', '/a/b/c' );
//   var expected = [ '../../**/b/**', './**/b/**', './**' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._globAnalogs2( '/doubledir/d1/**', '/doubledir/d1', '/doubledir/d1/d11' );
//   var expected = [ '../**', './**' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._globAnalogs2( '/doubledir/d1/**', '/doubledir', '/doubledir/d1/d11' );
//   var expected = [ '../../d1/**', './**' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._globAnalogs2( '/doubledir/d1/*', '/doubledir', '/doubledir/d1/d11' );
//   var expected = [ '../../d1/*', '.' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._globAnalogs2( '/src1/**', '/src2', '/src2' );
//   var expected = [ '../src1/**' ];
//   test.identical( got, expected );
//
//   var got = _.path._globAnalogs2( '/src2/**', '/src2', '/src2' );
//   var expected = [ './**' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._globAnalogs2( '/src1/**', '/src2', '/' );
//   var expected = [ './src1/**' ];
//   test.identical( got, expected );
//
//   var got = _.path._globAnalogs2( '/src2/**', '/src2', '/' );
//   var expected = [ './src2/**' ];
//   test.identical( got, expected );
//
//   var got = _.path._globAnalogs2( '/src1/**', '/', '/src2' );
//   var expected = [ '../src1/**' ];
//   test.identical( got, expected );
//
//   var got = _.path._globAnalogs2( '/src2/**', '/', '/src2' );
//   var expected = [ '../src2/**', './**' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._globAnalogs2( '/src1/**', '/src2', '/src1' );
//   var expected = [ '../src1/**' ];
//   test.identical( got, expected );
//
//   var got = _.path._globAnalogs2( '/src1/**', '/src1', '/src2' );
//   var expected = [ '../src1/**' ];
//   test.identical( got, expected );
//
// }

//

function globFilter( test )
{
  let path = _.path;

  // *
  test.case = 'empty right glob';
  test.description = 'empty selector';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, '' );
  test.identical( got, expected );

  test.case = 'mandatory single char followed by * that should never be found';
  test.description = 'selector out of league';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, 'z*' );
  test.identical( got, expected );

  test.case = '* followed by mandatory char that should never be found';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, '*a' );
  test.identical( got, expected );

  test.case = 'mandatory double char followed by * that should never be found';
  test.description = 'selector starts with double out of league chars';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, 'za*' );
  test.identical( got, expected );

  test.case = '* followed by mandatory double char that should never be found';
  test.description = 'selector ends with double out of league chars';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, '*az' );
  test.identical( got, expected );

  test.case = 'plain mandatory string that should never be found';
  test.description = 'selector string length overflow';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, 'dbba' );
  test.identical( got, expected );

  test.case = 'plain mandatory string that should be found';
  test.description = 'selector string length overflow';
  var expected = [ 'dbb' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, 'dbb' );
  test.identical( got, expected );

  test.case = 'mandatory char followed by * that should be found';
  test.description = 'selector string starts with d';
  var expected = [ 'dbb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, 'd*' );
  test.identical( got, expected );

  test.case = '* followed by mandatory char that should be found';
  var expected = [ 'adb', 'dbb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, '*b' );
  test.identical( got, expected );

  test.case = 'mid glob';
  var expected = [ 'abc', 'abd', 'adb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, '*a*' );
  test.identical( got, expected );

  test.case = 'mid glob double';
  var expected = [ 'dbb', 'dbba' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab', 'dbba' ];
  var got = path.globFilter( src, '*bb*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = [ 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globFilter( src, 'abd' );
  test.identical( got, expected );

  test.case = 'any glob';
  var expected = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, '*' );
  test.identical( got, expected );

  // ?
  test.case = 'glob match exact 1 char with string len=3';
  var expected = [ 'dbb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab', 'dbba' ];
  var got = path.globFilter( src, 'd?b' );
  test.identical( got, expected );

  test.case = 'glob match exact 1 char with string len=2';
  var expected = [ 'ab', 'ad', 'ac' ];
  var src = [ 'ab', 'ad', 'ac', 'abc', 'adb', 'acb' ];
  var got = path.globFilter( src, 'a?' );
  test.identical( got, expected );

  // ? & *
  test.case = 'right glob len = atleast 2 chars';
  var expected = [ 'ab', 'ad', 'ac', 'abc', 'adb', 'acb' ];
  var src = [ 'ab', 'ad', 'ac', 'abc', 'adb', 'acb' ];
  var got = path.globFilter( src, 'a?*' );
  test.identical( got, expected );

  // (...)
  test.case = 'empty char glob for a group of digits';
  var expected = [ ];
  var src = [ 1, 2, 3, 4, 5, 123, 456, 123456, 7890];
  var got = path.globFilter( src, '+([a-g])' );
  test.identical( got, expected );

  test.case = 'glob range group of chars';
  var expected = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a' ];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a', 1, 'xyz', 'abcdefghij' ];
  var got = path.globFilter( src, '+([a-g])' );
  test.identical( got, expected );

  test.case = 'glob range group of chars and must have more trailing';
  var expected = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'abcdefghij'];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a', 1, 'xyz', 'abcdefghij' ];
  var got = path.globFilter( src, '+([a-g])+([a-z])' );
  test.identical( got, expected );

  test.case = 'glob range group of chars and may have more trailing';
  var expected = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a', 'abcdefghij'];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a', 1, 'xyz', 'abcdefghij' ];
  var got = path.globFilter( src, '+([a-g])*([a-z])' );
  test.identical( got, expected );

  test.case = 'glob range skip - (!)';
  var expected = [ 1, 'xyz', 'abcdefghij' ];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a', 1, 'xyz', 'abcdefghij' ];
  var got1 = path.globFilter( src, '*[!a-g]' );
  var got2 = path.globFilter( src, '*[^a-g]' );
  test.identical( got1, expected );
  test.identical( got2, expected );

  // |
  test.case = 'pattern match = none';
  var expected = [ ];
  var src = [ 'a', 'b', 'bb' ];
  var got = path.globFilter( src, 'a(b|bb|bc)' );
  test.identical( got, expected );

  test.case = 'pattern match = all ending with c';
  var expected = [ 'abcc' ];
  var src = [ 'abcc', 'bc', 'ac' ];
  var got = path.globFilter( src, '(ab|bb|abc)c' );
  test.identical( got, expected );

  test.case = '2 chars starting with either a or b but ending with c';
  var expected = [ 'ac' ];
  var src = [ 'ac', 'abc', 'cc' ];
  var got = path.globFilter( src, '(a|b)c' );
  test.identical( got, expected );

  // +(|)
  test.case = 'pattern with single group';
  var expected = [ 'axyzz' ];
  var src = [ 'axyzz', 'adefz', 'azyxz' ];
  var got = path.globFilter( src, 'a+(xyz)z' );
  test.identical( got, expected );

  test.case = 'pattern with 2 groups';
  var expected = [ 'axyzz', 'adefz' ];
  var src = [ 'abz', 'acz', 'zzz', 'axyzz', 'adefz' ];
  var got = path.globFilter( src, 'a+(xyz|def)z' );
  test.identical( got, expected );

  test.case = 'empty digit glob for group of unexpected chars';
  var expected = [ ];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a' ];
  var got = path.globFilter( src, '+([0-9])' );
  test.identical( got, expected );

  test.case = 'digit glob for group of digits';
  var expected = [ 1, 2, 3, 4, 5, 123, 456, 123456, 7890 ];
  var src = [ 1, 2, 3, 4, 5, 123, 456, 123456, 7890, 'a', 'abc' ];
  var got = path.globFilter( src, '+([0-9])' );
  test.identical( got, expected );

  // *(|)
  test.case = 'empty digit glob for group of unexpected chars';
  var expected = [ ];
  var src = [ 'abc', 'abcd', 'abcde', 'abcdef', 'abcdefg', 'a' ];
  var got = path.globFilter( src, '*([0-9])' );
  test.identical( got, expected );

  test.case = 'all strings that owns a car';
  var expected = [ 'car', 'cart', 'carting', 'cariter' ];
  var src = [ 'car', 'cart', 'carting', 'cariter' ];
  var got = path.globFilter( src, 'car*(t|ting|iter)' );
  test.identical( got, expected );

  // !(|)
  test.case = 'not pattern match = none';
  var expected = [ ];
  var src = [ 'ab', 'ac' ];
  var got1 = path.globFilter( src, 'a!(b|c)' );
  test.identical( got1, expected );

  test.case = '3 chars starting with a, skip b-k, end with z';
  var expected = [ 'azz' ];
  var src = [ 'abz', 'acz', 'azz' ];
  var got = path.globFilter( src, 'a!(b|c|d|e|f|g|h|i|j|k)z' );
  test.identical( got, expected );

  test.case = 'any 3 chars, no z in the middle';
  var expected = [ 'abz', 'acz' ];
  var src = [ 'abz', 'acz', 'zzz' ];
  var got = path.globFilter( src, 'a!(z)z' );
  test.identical( got, expected );

  test.case = 'any 3 chars, no xyz in the middle';
  var expected = [ 'abz', 'acz' ];
  var src = [ 'abz', 'acz', 'zzz' ];
  var got = path.globFilter( src, 'a!(xyz)z' );
  test.identical( got, expected );

  test.case = 'skip a group of chars';
  var expected = [ 'car', 'cat', 'carpool', 'ca' ];
  var src = [ 'car', 'cat', 'catastrophic', 'carnage', 'carpool', 'ca' ];
  var got = path.globFilter( src, 'ca!(tastrophic|rnage)' );
  test.identical( got, expected );

  // @
  test.case = 'match exactly one of the patterns';
  var expected = [ 'catastrophic', 'carnage' ];
  var src = [ 'car', 'cat', 'catastrophic', 'carnage', 'carpool', 'ca' ];
  var got = path.globFilter( src, 'ca@(tastrophic|rnage)' );
  test.identical( got, expected );

  // // FIXME: Everything below this line
  // test.case = 'must throw errors';
  // var src = [ 'car', 'cat', 'catastrophic', 'carnage', 'carpool', 'ca' ];
  // test.shouldThrowErrorSync(path.globFilter());
  // test.shouldThrowErrorSync(path.globFilter( src ));
  // test.shouldThrowErrorSync(path.globFilter( src, null ));
  // test.shouldThrowErrorSync(path.globFilter( null, 'lorem' ));
  // test.shouldThrowErrorSync(path.globFilter( null, null ));
  //
  // test.case = 'plain numbers as glob must fail';
  // var src = [ 0, 1, 2, 3, 4 ];
  // test.shouldThrowErrorSync( path.globFilter( src, 0 ) );

}

//

function globFilterVals( test )
{
  let path = _.path;

  /* - */

  test.open( 'from array' );

  test.case = 'trivial glob';
  var expected = [ 'abc', 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globFilterVals( src, 'ab*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = [ 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globFilterVals( src, 'abd' );
  test.identical( got, expected );

  test.close( 'from array' );

  /* - */

  test.open( 'map by element' );

  test.case = 'trivial glob';
  var expected = { a : 'abc', b : 'abd' };
  var src = { a : 'abc', b : 'abd', c : 'adb' };
  var got = path.globFilterVals( src, 'ab*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = { b : 'abd' };
  var src = { a : 'abc', b : 'abd', c : 'adb' };
  var got = path.globFilterVals( src, 'abd' );
  test.identical( got, expected );

  test.close( 'map by element' );

  /* - */

}

//

function globFilterKeys( test )
{
  let path = _.path;

  /* - */

  test.open( 'from array' );

  test.case = 'trivial glob';
  var expected = [ 'abc', 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globFilterKeys( src, 'ab*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = [ 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globFilterKeys( src, 'abd' );
  test.identical( got, expected );

  test.close( 'from array' );

  /* - */

  test.open( 'map by element' );

  test.case = 'trivial glob';
  var expected = { abc : 'a', abd : 'b' };
  var src = { abc : 'a', abd : 'b', adb : 'c' };
  var got = path.globFilterKeys( src, 'ab*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = { abd : 'b' };
  var src = { abc : 'a', abd : 'b', adb : 'c' };
  var got = path.globFilterKeys( src, 'abd' );
  test.identical( got, expected );

  test.close( 'map by element' );

  /* - */

}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l3.path.Glob',
  silencing : 1,
  // verbosity : 7,
  // routine : 'relative',

  tests :
  {

    fromGlob,
    globSplitToRegexp,

    _globAnalogs1,
    _globAnalogs2,

    globFilter,
    globFilterVals,
    globFilterKeys,

  },

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
