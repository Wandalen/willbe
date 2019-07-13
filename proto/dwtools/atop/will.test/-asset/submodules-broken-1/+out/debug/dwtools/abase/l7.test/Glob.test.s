( function _Glob_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );
  _.include( 'wTesting' );
  require( '../l3/Path.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
//
// --

function fromGlob( test )
{

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
  var expected = /^.*\/b(?:\/.*)?$/;
  test.identical( got, expected );

}

//

function relateForGlob( test )
{

  test.shouldThrowErrorSync( () =>
  {
    var expected = [ './file' ];
    var globPath = 'src1Terminal/file';
    var filePath = '/';
    var basePath = '/src1Terminal';
    var got = _.path._relateForGlob( globPath, filePath, basePath );
    test.identical( got, expected );
  });

  test.shouldThrowErrorSync( () =>
  {
    var expected = [ '../../b/c/f' ];
    var globPath = 'f';
    var filePath = '/a/b/c';
    var basePath = '/a/d/e';
    var got = _.path._relateForGlob( globPath, filePath, basePath );
    test.identical( got, expected );
  });

  /* */

  var got = _.path._relateForGlob( '/src1Terminal', '/', '/src1Terminal' )
  var expected = [ '.' ];
  test.identical( got, expected );

  /* */

  var got = _.path._relateForGlob( '/**/b/**', '/a', '/a/b/c' );
  var expected = [ '../**/b/**', '**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._relateForGlob( '/doubledir/d1/**', '/doubledir/d1', '/doubledir/d1/d11' );
  var expected = [ '**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._relateForGlob( '/doubledir/d1/**', '/doubledir', '/doubledir/d1/d11' );
  var expected = [ 'd1/**', '**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._relateForGlob( '/doubledir/d1/*', '/doubledir', '/doubledir/d1/d11' );
  var expected = [ 'd1/*', '**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._relateForGlob( '/src1/**', '/src2', '/src2' );
  var expected = [ '../src1/**' ];
  test.identical( got, expected );

  var got = _.path._relateForGlob( '/src2/**', '/src2', '/src2' );
  var expected = [ './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._relateForGlob( '/src1/**', '/src2', '/' );
  var expected = [ './src1/**' ];
  test.identical( got, expected );

  var got = _.path._relateForGlob( '/src2/**', '/src2', '/' );
  var expected = [ './src2/**' ];
  test.identical( got, expected );

  var got = _.path._relateForGlob( '/src1/**', '/', '/src2' );
  var expected = [ 'src1/**' ];
  test.identical( got, expected );

  var got = _.path._relateForGlob( '/src2/**', '/', '/src2' );
  var expected = [ './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path._relateForGlob( '/src1/**', '/src2', '/src1' );
  var expected = [ './**' ];
  test.identical( got, expected );

  var got = _.path._relateForGlob( '/src1/**', '/src1', '/src2' );
  var expected = [ '**' ];
  test.identical( got, expected );

}

// function relateForGlob( test )
// {
//
//   var expected = [ '../src1Terminal/file', './file' ];
//   var globPath = 'src1Terminal/file';
//   var filePath = '/';
//   var basePath = '/src1Terminal';
//   var got = _.path._relateForGlob( globPath, filePath, basePath );
//   test.identical( got, expected );
//
//   var expected = [ '../../b/c/f' ];
//   var globPath = 'f';
//   var filePath = '/a/b/c';
//   var basePath = '/a/d/e';
//   var got = _.path._relateForGlob( globPath, filePath, basePath );
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._relateForGlob( '/src1Terminal', '/', '/src1Terminal' )
//   var expected = [ '../src1Terminal', '.' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._relateForGlob( '**/b/**', '/a', '/a/b/c' );
//   var expected = [ '../../**/b/**', './**/b/**', './**' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._relateForGlob( '/doubledir/d1/**', '/doubledir/d1', '/doubledir/d1/d11' );
//   var expected = [ '../**', './**' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._relateForGlob( '/doubledir/d1/**', '/doubledir', '/doubledir/d1/d11' );
//   var expected = [ '../../d1/**', './**' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._relateForGlob( '/doubledir/d1/*', '/doubledir', '/doubledir/d1/d11' );
//   var expected = [ '../../d1/*', '.' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._relateForGlob( '/src1/**', '/src2', '/src2' );
//   var expected = [ '../src1/**' ];
//   test.identical( got, expected );
//
//   var got = _.path._relateForGlob( '/src2/**', '/src2', '/src2' );
//   var expected = [ './**' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._relateForGlob( '/src1/**', '/src2', '/' );
//   var expected = [ './src1/**' ];
//   test.identical( got, expected );
//
//   var got = _.path._relateForGlob( '/src2/**', '/src2', '/' );
//   var expected = [ './src2/**' ];
//   test.identical( got, expected );
//
//   var got = _.path._relateForGlob( '/src1/**', '/', '/src2' );
//   var expected = [ '../src1/**' ];
//   test.identical( got, expected );
//
//   var got = _.path._relateForGlob( '/src2/**', '/', '/src2' );
//   var expected = [ '../src2/**', './**' ];
//   test.identical( got, expected );
//
//   /* */
//
//   var got = _.path._relateForGlob( '/src1/**', '/src2', '/src1' );
//   var expected = [ '../src1/**' ];
//   test.identical( got, expected );
//
//   var got = _.path._relateForGlob( '/src1/**', '/src1', '/src2' );
//   var expected = [ '../src1/**' ];
//   test.identical( got, expected );
//
// }

//

function globFilter( test )
{
  let path = _.path;

  test.case = 'empt right glob';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, 'b*' );
  test.identical( got, expected );

  test.case = 'right glob';
  var expected = [ 'dbb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, 'd*' );
  test.identical( got, expected );

  test.case = 'empy left glob';
  var expected = [];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, '*a' );
  test.identical( got, expected );

  test.case = 'left glob';
  var expected = [ 'adb', 'dbb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, '*b' );
  test.identical( got, expected );

  test.case = 'mid glob';
  var expected = [ 'abc', 'abd', 'adb', 'dab' ];
  var src = [ 'abc', 'abd', 'adb', 'dbb', 'dab' ];
  var got = path.globFilter( src, '*a*' );
  test.identical( got, expected );

  test.case = 'not glob';
  var expected = [ 'abd' ];
  var src = [ 'abc', 'abd', 'adb' ];
  var got = path.globFilter( src, 'abd' );
  test.identical( got, expected );

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

  name : 'Tools/base/l3/path/Glob',
  silencing : 1,
  // verbosity : 7,
  // routine : 'relative',

  tests :
  {

    fromGlob,
    globSplitToRegexp,
    relateForGlob,

    globFilter,
    globFilterVals,
    globFilterKeys,

  },

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
