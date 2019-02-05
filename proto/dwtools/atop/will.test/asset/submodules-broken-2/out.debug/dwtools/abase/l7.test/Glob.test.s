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

function globToRegexp( test )
{

  var got = _.path.globToRegexp( '**/b/**' );
  var expected = /^.*\/b(?:\/.*)?$/;
  test.identical( got, expected );

}

//

function relateForGlob( test )
{

  var expected = [ '../src1Terminal/file', './file' ];
  var filePath = 'src1Terminal/file';
  var oldPath = '/';
  var newPath = '/src1Terminal';
  var got = _.path.relateForGlob( filePath, oldPath, newPath );
  test.identical( got, expected );

  var expected = [ '../../b/c/f' ];
  var filePath = 'f';
  var oldPath = '/a/b/c';
  var newPath = '/a/d/e';
  var got = _.path.relateForGlob( filePath, oldPath, newPath );
  test.identical( got, expected );

  /* */

  var got = _.path.relateForGlob( '/src1Terminal', '/', '/src1Terminal' )
  var expected = [ '../src1Terminal', '.' ];
  test.identical( got, expected );

  /* */

  var got = _.path.relateForGlob( '**/b/**', '/a', '/a/b/c' );
  var expected = [ '../../**/b/**', './**/b/**', './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path.relateForGlob( '/doubledir/d1/**', '/doubledir/d1', '/doubledir/d1/d11' );
  var expected = [ '../**', './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path.relateForGlob( '/doubledir/d1/**', '/doubledir', '/doubledir/d1/d11' );
  var expected = [ '../../d1/**', './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path.relateForGlob( '/doubledir/d1/*', '/doubledir', '/doubledir/d1/d11' );
  var expected = [ '../../d1/*', '.' ];
  test.identical( got, expected );

  /* */

  var got = _.path.relateForGlob( '/src1/**', '/src2', '/src2' );
  var expected = [ '../src1/**' ];
  test.identical( got, expected );

  var got = _.path.relateForGlob( '/src2/**', '/src2', '/src2' );
  var expected = [ './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path.relateForGlob( '/src1/**', '/src2', '/' );
  var expected = [ './src1/**' ];
  test.identical( got, expected );

  var got = _.path.relateForGlob( '/src2/**', '/src2', '/' );
  var expected = [ './src2/**' ];
  test.identical( got, expected );

  var got = _.path.relateForGlob( '/src1/**', '/', '/src2' );
  var expected = [ '../src1/**' ];
  test.identical( got, expected );

  var got = _.path.relateForGlob( '/src2/**', '/', '/src2' );
  var expected = [ '../src2/**', './**' ];
  test.identical( got, expected );

  /* */

  var got = _.path.relateForGlob( '/src1/**', '/src2', '/src1' );
  var expected = [ '../src1/**' ];
  test.identical( got, expected );

  var got = _.path.relateForGlob( '/src1/**', '/src1', '/src2' );
  var expected = [ '../src1/**' ];
  test.identical( got, expected );

}

//

function fileMapExtend( test )
{
  let path = _.path;

  test.open( 'value:true' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : true }
  var got = path.fileMapExtend( null, '/a/b', true );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : true, '/c/d' : true }
  var got = path.fileMapExtend( null, [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var got = path.fileMapExtend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : true, '/a/b' : true }
  var got = path.fileMapExtend( '/z', '/a/b', true );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : true, '/a/b' : true, '/c/d' : true }
  var got = path.fileMapExtend( '/z', [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : true, '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var got = path.fileMapExtend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.fileMapExtend( dst, '/a/b', true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true, '/c/d' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.fileMapExtend( dst, [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.fileMapExtend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* - */

  test.close( 'value:true' )
  test.open( 'value:false' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : false }
  var got = path.fileMapExtend( null, '/a/b', false );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : false, '/c/d' : false }
  var got = path.fileMapExtend( null, [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var got = path.fileMapExtend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : false, '/a/b' : false }
  var got = path.fileMapExtend( '/z', '/a/b', false );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : false, '/a/b' : false, '/c/d' : false }
  var got = path.fileMapExtend( '/z', [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : false, '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var got = path.fileMapExtend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.fileMapExtend( dst, '/a/b', false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false, '/c/d' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.fileMapExtend( dst, [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.fileMapExtend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* - */

  test.close( 'value:false' )
  test.open( 'value:array' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : [ '/dst1', '/dst2' ] }
  var got = path.fileMapExtend( null, '/a/b', [ '/dst1', '/dst2' ] );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : [ '/dst1', '/dst2' ], '/c/d' : [ '/dst1', '/dst2' ] }
  var got = path.fileMapExtend( null, [ '/a/b', '/c/d' ], [ '/dst1', '/dst2' ] );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : [ '/dst1', '/dst2' ], '/c/d' : [ '/dst1', '/dst2' ], '/true' : [ '/dst1', '/dst2' ], '/false' : false }
  var got = path.fileMapExtend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dst1', '/dst2' ] );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : [ '/dst1', '/dst2' ], '/a/b' : [ '/dst1', '/dst2' ] }
  var got = path.fileMapExtend( '/z', '/a/b', [ '/dst1', '/dst2' ] );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : [ '/dst1', '/dst2' ], '/a/b' : [ '/dst1', '/dst2' ], '/c/d' : [ '/dst1', '/dst2' ] }
  var got = path.fileMapExtend( '/z', [ '/a/b', '/c/d' ], [ '/dst1', '/dst2' ] );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : [ '/dst1', '/dst2' ], '/a/b' : [ '/dst1', '/dst2' ], '/c/d' : [ '/dst1', '/dst2' ], '/true' : [ '/dst1', '/dst2' ], '/false' : false }
  var got = path.fileMapExtend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dst1', '/dst2' ] );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : [ '/dst1', '/dst2' ], '/wasFalse' : false, '/a/b' : [ '/dst1', '/dst2' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.fileMapExtend( dst, '/a/b', [ '/dst1', '/dst2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : [ '/dst1', '/dst2' ], '/wasFalse' : false, '/a/b' : [ '/dst1', '/dst2' ], '/c/d' : [ '/dst1', '/dst2' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.fileMapExtend( dst, [ '/a/b', '/c/d' ], [ '/dst1', '/dst2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : [ '/dst1', '/dst2' ], '/wasFalse' : false, '/a/b' : [ '/dst1', '/dst2' ], '/c/d' : [ '/dst1', '/dst2' ], '/true' : [ '/dst1', '/dst2' ], '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.fileMapExtend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dst1', '/dst2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* - */

  test.close( 'value:array' )

}

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

//
//
// function globRegexpsFor( test )
// {
//
//   test.open( 'relative undoted' );
//
//   var glob = '.';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.$/,
//     terminal : /^\.$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = '..';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:\.\.)?$/,
//     terminal : /^\.?\.\.$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = '../a';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:(?:\.\.$)?|(?:\.\.\/a)?)?)?$/,
//     terminal : /^\.?(?:\.\.\/a)?$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = '../a/b';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:(?:(?:\.\.$)?|(?:\.\.\/a)?)?$)?|(?:(?:(?:\.\.$)?|(?:\.\.\/a)?)?\/b)?)?$/,
//     terminal : /^\.?(?:\.\.\/a)?\/b$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = '../../a/b';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:(?:\.\.$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?\/b)?)?)?$/,
//     terminal : /^\.?(?:\.\.(?:\/\.\.\/a)?\/b)?$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = '../../a/b/c';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:(?:(?:\.\.$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?\/b)?)?$)?|(?:(?:(?:\.\.$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?\/b)?)?\/c)?)?$/,
//     terminal : /^\.?(?:\.\.(?:\/\.\.\/a)?\/b)?\/c$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = '../..';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:\.\.$)?|(?:\.\.\/\.\.)?)?$/,
//     terminal : /^\.?\.\.\/\.\.$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = 'a';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:\/a)?$/,
//     terminal : /^\.?\/a$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = 'a/b';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:\/a$)?|(?:\/a\/b)?)?$/,
//     terminal : /^\.?\/a\/b$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
// /*
// {.|(/..(/../a/)?(/../b)?/c)?)}/d/e/f/../../g
// */
//
//   var glob = '../../a/../b/c/d/e/f/../../g';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:(?:(?:\.\.$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?\/c)?)?$)?|(?:(?:(?:\.\.$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?\/c)?)?\/d$)?|(?:(?:(?:\.\.$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?\/c)?)?\/d(?:(?:\/e$)?|(?:\/e(?:(?:\/f$)?|(?:\/f\/\.\.)?)?$)?|(?:\/e(?:(?:\/f$)?|(?:\/f\/\.\.)?)?\/\.\.)?)?$)?|(?:(?:(?:\.\.$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?$)?|(?:\.\.(?:(?:\/\.\.$)?|(?:\/\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?\/c)?)?\/d(?:(?:\/e$)?|(?:\/e(?:(?:\/f$)?|(?:\/f\/\.\.)?)?$)?|(?:\/e(?:(?:\/f$)?|(?:\/f\/\.\.)?)?\/\.\.)?)?\/g)?)?$/,
//     terminal : /^\.?(?:\.\.(?:\/\.\.\/a)?(?:\/\.\.\/b)?\/c)?\/d(?:\/e(?:\/f\/\.\.)?\/\.\.)?\/g$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
// /*
// (a/(b/(c/..)/..)/(d/..)/..)/e/f/g/h
// */
//
//   var glob = 'a/b/c/../../d/../../e/f';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:(?:(?:\/a$)?|(?:\/a(?:(?:\/b$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?\/\.\.)?)?$)?|(?:\/a(?:(?:\/b$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?\/\.\.)?)?(?:(?:\/d$)?|(?:\/d\/\.\.)?)?$)?|(?:\/a(?:(?:\/b$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?\/\.\.)?)?(?:(?:\/d$)?|(?:\/d\/\.\.)?)?\/\.\.)?)?$)?|(?:(?:(?:\/a$)?|(?:\/a(?:(?:\/b$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?\/\.\.)?)?$)?|(?:\/a(?:(?:\/b$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?\/\.\.)?)?(?:(?:\/d$)?|(?:\/d\/\.\.)?)?$)?|(?:\/a(?:(?:\/b$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?\/\.\.)?)?(?:(?:\/d$)?|(?:\/d\/\.\.)?)?\/\.\.)?)?\/e$)?|(?:(?:(?:\/a$)?|(?:\/a(?:(?:\/b$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?\/\.\.)?)?$)?|(?:\/a(?:(?:\/b$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?\/\.\.)?)?(?:(?:\/d$)?|(?:\/d\/\.\.)?)?$)?|(?:\/a(?:(?:\/b$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?$)?|(?:\/b(?:(?:\/c$)?|(?:\/c\/\.\.)?)?\/\.\.)?)?(?:(?:\/d$)?|(?:\/d\/\.\.)?)?\/\.\.)?)?\/e\/f)?)?$/,
//     terminal : /^\.?(?:\/a(?:\/b(?:\/c\/\.\.)?\/\.\.)?(?:\/d\/\.\.)?\/\.\.)?\/e\/f$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = 'a/..';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:(?:\/a$)?|(?:\/a\/\.\.)?)?)?$/,
//     terminal : /^\.?(?:\/a\/\.\.)?$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = 'a/../..';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:(?:(?:\/a$)?|(?:\/a\/\.\.)?)?$)?|(?:(?:(?:\/a$)?|(?:\/a\/\.\.)?)?\/\.\.)?)?$/,
//     terminal : /^\.?(?:\/a\/\.\.)?\/\.\.$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   /**/
//
//   var glob = '../a/../b/../c/../..';
//   test.case = glob;
//
//   var expected =
//   {
//     directory : /^\.?(?:(?:(?:(?:\.\.$)?|(?:\.\.\/a)?)?$)?|(?:(?:(?:\.\.$)?|(?:\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?$)?|(?:(?:(?:\.\.$)?|(?:\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/c)?)?$)?|(?:(?:(?:\.\.$)?|(?:\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/c)?)?\/\.\.$)?|(?:(?:(?:\.\.$)?|(?:\.\.\/a)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/b)?)?(?:(?:\/\.\.$)?|(?:\/\.\.\/c)?)?\/\.\.\/\.\.)?)?$/,
//     terminal : /^\.?(?:\.\.\/a)?(?:\/\.\.\/b)?(?:\/\.\.\/c)?\/\.\.\/\.\.$/
//   }
//   var got = _.path.globRegexpsFor( glob );
//   test.identical( got, expected );
//
//   test.close( 'relative undoted' );
//
// }
//
//
//
// function globRegexpsForTerminal( test )
// {
//   var glob = '*'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/[^\/]*$/;
//   test.identical( got, expected );
//
//   var glob = 'dir/**';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/dir\/.*$/;
//   test.identical( got, expected );
//
//   var glob = 'dir**';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/dir.*$/;
//   test.identical( got, expected );
//
//   var glob = 'a.txt';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/a\.txt$/;
//   test.identical( got, expected );
//
//   var glob = '*.txt'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/[^\/]*\.txt$/;
//   test.identical( got, expected );
//
//   var glob = 'a/*.txt'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/a\/[^\/]*\.txt$/;
//   test.identical( got, expected );
//
//   var glob = 'a*.txt';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/a[^\/]*\.txt$/;
//   test.identical( got, expected );
//
//   var glob = '*.*'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/[^\/]*\.[^\/]*$/;
//   test.identical( got, expected );
//
//   var glob = '??.txt'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/..\.txt$/;
//   test.identical( got, expected );
//
//   var glob = 'a/**/b'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/a\/.*b$/;
//   test.identical( got, expected );
//
//   var glob = '**/a'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/.*a$/;
//   test.identical( got, expected );
//
//   var glob = 'a/a*/b_?.txt'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/a\/a[^\/]*\/b_.\.txt$/;
//   test.identical( got, expected );
//
//   var glob = '[a.txt]';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/[a\.txt]$/;
//   test.identical( got, expected );
//
//   var glob = '[abc]/b'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/[abc]\/b$/;
//   test.identical( got, expected );
//
//   var glob = '[!abc]/b'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/[^abc]\/b$/;
//   test.identical( got, expected );
//
//   var glob = '[a-c]/b'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/[a-c]\/b$/;
//   test.identical( got, expected );
//
//   var glob = '[!a-c]/b'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/[^a-c]\/b$/;
//   test.identical( got, expected );
//
//   var glob = '[[{}]]/b'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/[\[{}\]]\/b$/;
//   test.identical( got, expected );
//
//   var glob = 'a/{*.txt,*.js}'
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/a\/([^\/]*\.txt|[^\/]*\.js)$/;
//   test.identical( got, expected );
//
//   var glob = 'a(*+)txt';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/a\([^\/]*\+\)txt$/;
//   test.identical( got, expected );
//
//   var glob = 's.js';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/s\.js$/;
//   debugger;
//   test.identical( got, expected );
//
//   var glob = 'ab/c/.js';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/ab\/c\/\.js$/;
//   test.identical( got, expected );
//
//   var glob = 'a$b';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/a\$b$/;
//   test.identical( got, expected );
//
//   var glob = '**/[a[bc]]';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/.*[a\[bc\]]$/;
//   test.identical( got, expected );
//
//   var glob = '**/{*.js,{*.ss,*.s}}';
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/.*([^\/]*\.js|([^\/]*\.ss|[^\/]*\.s))$/;
//   test.identical( got, expected );
//
//   var glob = [ '*', 'a.txt' ];
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/([^\/]*)|(a\.txt)$/;
//   test.identical( got, expected );
//
//   var glob = [ '*' ];
//   var got = _.path.globRegexpsForTerminal( glob );
//   var expected = /^\.\/[^\/]*$/;
//   test.identical( got, expected );
//
//   /* moved from globRegexpsForTerminal test routine */
//
//   var globSample1 = '*.txt';
//   var expected1 = /^\.\/[^\/]*\.txt$/;
//   test.case = 'pattern for all .txt files in directory';
//   var got = _.path.globRegexpsForTerminal( globSample1 );
//   test.identical( got, expected1 );
//
//   var globSample2 = '*.*';
//   var expected2 = /^\.\/[^\/]*\.[^\/]*$/;
//   test.case = 'pattern for all files in directory';
//   var got = _.path.globRegexpsForTerminal( globSample2 );
//   test.identical( got, expected2 );
//
//   var globSample3 = '??';
//   var expected3 = /^\.\/..$/;
//   test.case = 'pattern for exactly two characters in length file names';
//   var got = _.path.globRegexpsForTerminal( globSample3 );
//   test.identical( got, expected3 );
//
//   var globSample4 = '**';
//   var expected4 = /^\.\/.*$/;
//   test.case = 'pattern for all files and dirs';
//   var got = _.path.globRegexpsForTerminal( globSample4 );
//   test.identical( got, expected4 );
//
//   var globSample5 = 'subdir/img*/th_?';
//   var expected5 = /^\.\/subdir\/img[^\/]*\/th_.$/;
//   test.case = 'complex pattern';
//   var got = _.path.globRegexpsForTerminal( globSample5 );
//   test.identical( got, expected5 );
//
//   var globSample6 = 'dwtools/l3/**/*.s';
//   var expected5 = /^\.\/dwtools\/abase\/l3\/.*\.s$/;
//   test.description = 'complex pattern';
//   var got = _.path.globRegexpsForTerminal( globSample5 );
//   test.identical( got, expected5 );
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'missing arguments';
//   test.shouldThrowErrorSync( function()
//   {
//     _.path.globRegexpsForTerminal();
//   });
//
//   test.case = 'argument is not string';
//   test.shouldThrowErrorSync( function()
//   {
//     _.path.globRegexpsForTerminal( {} );
//   });
// }

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
    globToRegexp,
    relateForGlob,
    fileMapExtend,

    globFilter,
    globFilterVals,
    globFilterKeys,

    // globRegexpsFor : globRegexpsFor,
    // globRegexpsForTerminal : globRegexpsForTerminal,

  },

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

if( 0 )
if( typeof module === 'undefined' )
_.timeReady( function()
{

  wTester.verbosity = 99;
  wTester.logger = wPrinterToJs({ outputGray : 0, writingToHtml : 1 });
  wTester.test( Self.name,'PathUrlTest' )
  .finally( function()
  {
    var book = wTester.loggerToBook();
  });

});

})();
