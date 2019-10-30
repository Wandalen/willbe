( function _PathTools_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );
  _.include( 'wTesting' );
  require( '../l5/PathTools.s' );

}

var _global = _global_;
var _ = _global_.wTools;
var o =
{
  fileProvider :   _.fileProvider,
  filter : null
};

// --
// path map
// --

function filterPairs( test )
{
  test.open( 'instance' );

  var constructor = function ( val )
  {
    this.value = val;
    return this;
  }
  var obj = new constructor;

  test.case = 'double';
  var src = { '/path' : obj };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected =
  {
    '/path/path' : '[object Object][object Object]',
    '/path' : { 'value' : undefined }
  };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'srcOnly1';
  var src = { '/path' : obj };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '/path';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'srcOnly2';
  var src = { '/path' : obj };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = { '/path' : { 'value' : undefined } };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'srcOnly3';
  var src = { '/path' : obj };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = { '/path' : { 'value' : undefined } };
  test.identical( src, src2 );
  test.identical( got, expected );

  var src = { '/path' : [ obj, obj ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = { '/path' : { 'value' : undefined } };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'dstOnly';
  var src = { '/path' : obj };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = { '' : { 'value' : undefined } };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'dstDouble';
  var src = { '/path' : obj };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = { '' : { 'value' : undefined } };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'nothing1';
  var src = { '/path' : obj };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'nothing2';
  var src = { '/path' : obj };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'nothing3';
  var src = { '/path' : obj };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'nothing4';
  var src = { '/path' : obj };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'instance' );

  /* - */

  test.open( 'double' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = [ '/a/b/a/b', '/a/b' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = [ '/a/b/a/b', '/a/b' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = [ '/a/b/a/b', '/a/b', '/cd/cd', '/cd' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = [ '/a/b/a/b', '/a/b', '/c/d/c/d', '/c/d' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = { '/src/src' : 'dstdst', '/src' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = [ '/src/src', '/src' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = { '/src/src' : 'dstdst', '/src' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = { '/src/src' : [ 'dst1dst1', 'dst2dst2' ], '/src' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = { '' : [ 'dstdst', 'dst' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = { '' : [ 'dstdst', 'dst' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = { '' : [ 'dst1dst1', 'dst1', 'dst2dst2', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected = [ '/src/src', '/src' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'double' );

  /* - */

  test.open( 'srcOnly1' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = [ '/a/b', '/cd' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = [ '/a/b', '/c/d' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'srcOnly1' );

  /* - */

  test.open( 'srcOnly2' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = [ '/a/b', '/cd' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = [ '/a/b', '/c/d' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = { '/src' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = { '/src' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = { '/src' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'srcOnly2' );

  /* - */

  test.open( 'srcOnly3' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = [ '/a/b', '/cd' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = [ '/a/b', '/c/d' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = { '/src' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = { '/src' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = { '/src' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'srcOnly3' );

  /* - */

  test.open( 'dstOnly' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'dstOnly' );

  /* - */

  test.open( 'dstDouble' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'dstDouble' );

  /* - */

  test.open( 'nothing1' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'nothing1' );

  /* - */

  test.open( 'nothing2' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'nothing2' );

  /* - */

  test.open( 'nothing3' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'nothing3' );

  /* - */

  test.open( 'nothing4' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'nothing4' );

  /* - */

  test.open( 'complex map' );

  var src =
  {
    '/true' : true,
    '/false' : false,
    '/string1' : '/dir1',
    '/string2' : '',
    '/null' : null,
    '' : '/dir2',
    null : '/dir3',
    '/array' : [ '/dir1', '/dir2' ],
    '' : [ '/dir1', '/dir2' ],
    '' : [ '' ],
    '/emptyArray' : [],
  };

  test.case = 'double';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, double );
  var expected =
  {
    '/true/true' : true, '/true' : true,
    '/false/false' : false, '/false' : false,
    '/string1/string1' : '/dir1/dir1',
    '/string1' : '/dir1',
    '/string2/string2' : '',
    '/string2' : '',
    '/null/null' : '',
    '/null' : '',
    'nullnull' : '/dir3/dir3',
    'null' : '/dir3',
    '/array/array' : [ '/dir1/dir1', '/dir2/dir2' ],
    '/array' : [ '/dir1', '/dir2' ],
    '/emptyArray/emptyArray' : '',
    '/emptyArray' : ''
  };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'srcOnly1';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly1 );
  var expected = [ '/true', '/false', '/string1', '/string2', '/null', 'null', '/array', '/emptyArray' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'srcOnly2';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly2 );
  var expected =
  {
    '/true' : true,
    '/false' : false,
    '/string1' : '/dir1',
    '/string2' : '',
    '/null' : '',
    'null' : '/dir3',
    '/array' : [ '/dir1', '/dir2' ],
    '/emptyArray' : ''
  };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'srcOnly3';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, srcOnly3 );
  var expected =
  {
    '/true' : true,
    '/false' : false,
    '/string1' : '/dir1',
    '/string2' : '',
    '/null' : '',
    'null' : '/dir3',
    '/array' : [ '/dir1', '/dir2' ],
    '/emptyArray' : ''
  };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'dstOnly';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstOnly );
  var expected =
  {
    '' : [ '/dir1', '/dir3', '/dir2' ]
  };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'dstDouble';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, dstDouble );
  var expected =
  {
    '' : [ '/dir1', '/dir3', '/dir2' ]
  };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'nothing1';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'nothing2';
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'nothing3'
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'nothing4'
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'complex map' );

  /* - */

  test.case = 'duplicates';
  var src = { '' : [ '/b', null, null, '', '', '/b' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, duplicates );
  var expected = { '' : '/b' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates, onEach return array';
  var src = [ '/b', null, null, '', '', '/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, ( it ) => [ it.src, '/file', '/dst', '', null, '', null, undefined ] );
  var expected = [ '/b', '/file', '/dst' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates, onEach return array';
  var src = { 'dir' : [ '/b', null, null, '', '', '/b' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, ( it ) => [ it.src, '/file', '/dst', '', null, '', null, undefined ] );
  var expected = { 'dir' : '/b', '/file' : '/b', '/dst' : '/b' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates';
  var src = { '/dir1' : '/dir2', '/a' : '/b' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, duplicates );
  var expected = { '/dir1' : '/dir2', '/a' : '/b' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in map';
  var src = { '/dir1' : '/dir2', '/a' : '/b', '/empty' : '', '' : '/file', '/null' : null };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, duplicates );
  var expected = { '/dir1' : '/dir2', '/a' : '/b', '/empty' : '', '' : '/file', '/null' : '' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in map';
  var src = { '/dir1' : '/dir2', '/a' : '/b', '/empty' : '',  '/null' : null };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, duplicates );
  var expected = { '/dir1' : '/dir2', '/a' : '/b', '/empty' : '', '/null' : '' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/dir1', '/a', null, '', '', null ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, duplicates2 );
  var expected = [ '1', '/dir1', '/dir11', '/a', '/a1' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  /* - */

  test.case = 'boolean values';
  var src = [ '/dir1', true, null, '', '', null ];
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, duplicates2 );
  var expected = [ '1', '/dir1', '/dir11' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'boolean values';
  var src = { '/dir' : true, '/a' : null, '/b' : '', '' : null };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, duplicates );
  var expected = { '/dir' : true, '/a' : '', '/b' : '' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'boolean in callback, bool and null values in src';
  var src = { '/dir' : true, '/a' : null, '/b' : '', '' : null };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, bool );
  var expected = { '/dir' : true, '/a' : true, '/b' : true, '' : true };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'boolean in callback, str value in src';
  var src = { '/dir' : false, '/a' : '/dir', '/b' : '', '' : null };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, bool );
  var expected = { '/dir' : true, '/a' : true, '/b' : true, '' : true };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'boolean in callback, bool and null values in src';
  var src = { '/dir' : true, '/a' : null, '/b' : '', '' : null };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, bool2 );
  var expected = { '/dir' : false, '/a' : false, '/b' : false, '' : false };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'boolean in callback, str value in src';
  var src = { '/dir' : false, '/a' : '/dir', '/b' : '', '' : null };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, bool2 );
  var expected = { '/dir' : false, '/a' : false, '/b' : false, '' : false };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'boolean in callback, str value in src';
  var src = { '/dir' : true, '/a' : false, '/b' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filterPairs( src, uncorrectMap );
  var expected = { '/dir' : '/dst', '/a' : false, '/b' : false };
  test.identical( src, src2 );
  test.identical( got, expected );

  /* - */

  if( Config.debug )
  {
    test.open( 'throwing' );

    test.case = 'without arguments';
    test.shouldThrowErrorSync( () => _.path.filterPairs() );

    test.case = 'extra arguments';
    test.shouldThrowErrorSync( () => _.path.filterPairs( '/src', double, nothing1 ) );

    test.case = 'onEach is not a routine';
    test.shouldThrowErrorSync( () => _.path.filterPairs( '/src', [ double ] ) );

    test.case = 'wrong type of filePath';
    test.shouldThrowErrorSync( () => _.path.filterPairs( 1, double ) );
    test.shouldThrowErrorSync( () => _.path.filterPairs( { '/path' : {} }, double ) );
    test.shouldThrowErrorSync( () => _.path.filterPairs( { '/path' : undefined }, double ) );

    test.case = 'wrong type of onEach';
    test.shouldThrowErrorSync( () => _.path.filterPairs( '/path', '/path' ) );

    test.close( 'throwing' );
  }

  /*  */

  /*
    qqq : use all callbacks in the test routine
    Dmytro : all callbacks is used
  */

  function duplicates2( it )
  {
    return [ it.src, it.src, it.src + 1, '', '', null, ];
  }

  function duplicates( it )
  {
    return { [ it.src ] : [ it.dst, it.dst, it.dst, '', '', null, ] };
  }

  function bool( it )
  {
    return { [ it.src ] : true };
  }

  function bool2( it )
  {
    return { [ it.src ] : false };
  }

  function uncorrectMap( it )
  {
    if( it.dst === true )
    return { [ it.src ] : [ true, false, '', null, true, false, '', null, '/dst', true ] };
    if( it.dst === false )
    return { [ it.src ] : [ true, false, '', null, true, false, '', null, '/dst', false ] };
    else
    return { [ it.src ] : [ true, false, '', null, true, false, '', null, '/dst', true, false ] };
  }

  function double( it )
  {
    if( it.src === null )
    _.assert( 0 );
    if( it.src === '' )
    return { [ it.src ] : [ it.dst + it.dst, it.dst ] }
    else
    return { [ it.src + it.src ] : it.dst + it.dst, [ it.src ] : it.dst }
  }

  function srcOnly1( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return { [ it.src ] : '' };
  }

  function srcOnly2( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return it.src;
  }

  function srcOnly3( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return [ it.src ];
  }

  function dstOnly( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return { '' : it.dst };
  }

  function dstDouble( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return { '' : [ it.dst, it.dst ] };
  }

  function nothing1( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return {};
  }

  function nothing2( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return [];
  }

  function nothing3( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return '';
  }

  function nothing4( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return null;
  }

}

//

function filterPairsInplace( test )
{
  test.open( 'instance' );

  var constructor = function ( val )
  {
    this.value = val;
    return this;
  }
  var obj = new constructor;

  test.case = 'double';
  var src = { '/path' : obj };
  var got = _.path.filterPairsInplace( src, double );
  var expected =
  {
    '/path/path' : '[object Object][object Object]',
    '/path' : { 'value' : undefined }
  };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'srcOnly1';
  var src = { '/path' : obj };
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = { '/path' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'srcOnly2';
  var src = { '/path' : obj };
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = { '/path' : { 'value' : undefined } };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'srcOnly3';
  var src = { '/path' : obj };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = { '/path' : { 'value' : undefined } };
  test.identical( got, expected );
  test.is( got === src );

  var src = { '/path' : [ obj, obj ] };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = { '/path' : { 'value' : undefined } };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'dstOnly';
  var src = { '/path' : obj };
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = { '' : { 'value' : undefined } };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'dstDouble';
  var src = { '/path' : obj };
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = { '' : { 'value' : undefined } };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'nothing1';
  var src = { '/path' : obj };
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'nothing2';
  var src = { '/path' : obj };
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'nothing3';
  var src = { '/path' : obj };
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'nothing4';
  var src = { '/path' : obj };
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'instance' );

  /* - */

  test.open( 'double' );

  test.case = 'null';
  var src = null;
  var got = _.path.filterPairsInplace( src, double );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var got = _.path.filterPairsInplace( src, double );
  var expected = '';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var got = _.path.filterPairsInplace( src, double );
  var expected = [ '/a/b/a/b', '/a/b' ];
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterPairsInplace( src, double );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterPairsInplace( src, double );
  var expected = [ '/a/b/a/b', '/a/b' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterPairsInplace( src, double );
  var expected = [ '/a/b/a/b', '/a/b', '/cd/cd', '/cd' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterPairsInplace( src, double );
  var expected = [ '/a/b/a/b', '/a/b', '/c/d/c/d', '/c/d' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterPairsInplace( src, double );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterPairsInplace( src, double );
  var expected = { '/src/src' : 'dstdst', '/src' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterPairsInplace( src, double );
  var expected = { '/src/src' : '', '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, double );
  var expected = { '/src/src' : 'dstdst', '/src' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, double );
  var expected = { '/src/src' : [ 'dst1dst1', 'dst2dst2' ], '/src' : [ 'dst1', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterPairsInplace( src, double );
  var expected = { '' : [ 'dstdst', 'dst' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterPairsInplace( src, double );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, double );
  var expected = { '' : [ 'dstdst', 'dst' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, double );
  var expected = { '' : [ 'dst1dst1', 'dst1', 'dst2dst2', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterPairsInplace( src, double );
  var expected = { '/src/src' : '', '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'double' );

  /* - */

  test.open( 'srcOnly1' );

  test.case = 'null';
  var src = null;
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = '';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = '/a/b';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = [ '/a/b' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = [ '/a/b', '/cd' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = [ '/a/b', '/c/d' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'srcOnly1' );

  /* - */

  test.open( 'srcOnly2' );

  test.case = 'null';
  var src = null;
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = '';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = '/a/b';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  debugger;
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = [ '/a/b' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = [ '/a/b', '/cd' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = [ '/a/b', '/c/d' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = { '/src' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = { '/src' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = { '/src' : [ 'dst1', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'srcOnly2' );

  /* - */

  test.open( 'srcOnly3' );

  test.case = 'null';
  var src = null;
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = '';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = '/a/b';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = [ '/a/b' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = [ '/a/b', '/cd' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = [ '/a/b', '/c/d' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = { '/src' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = { '/src' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = { '/src' : [ 'dst1', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'srcOnly3' );

  /* - */

  test.open( 'dstOnly' );

  test.case = 'null';
  var src = null;
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = '';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'dstOnly' );

  /* - */

  test.open( 'dstDouble' );

  test.case = 'null';
  var src = null;
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = '';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'dstDouble' );

  /* - */

  test.open( 'nothing1' );

  test.case = 'null';
  var src = null;
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = '';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'nothing1' );

  /* - */

  test.open( 'nothing2' );

  test.case = 'null';
  var src = null;
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = '';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'nothing2' );

  /* - */

  test.open( 'nothing3' );

  test.case = 'null';
  var src = null;
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = '';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'nothing3' );

  /* - */

  test.open( 'nothing4' );

  test.case = 'null';
  var src = null;
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = '';
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'nothing4' );

  /* - */

  test.open( 'complex map' );

  var srcMap =
  {
    '/true' : true,
    '/false' : false,
    '/string1' : '/dir1',
    '/string2' : '',
    '/null' : null,
    null : '/dir3',
    '/array' : [ '/dir1', '/dir2' ],
    '' : [ '/dir1', '/dir2', '', null ],
    '/emptyArray' : [],
  };

  test.case = 'double';
  var src = _.mapSupplement( {}, srcMap );
  var got = _.path.filterPairsInplace( src, double );
  var expected =
  {
    '/true/true' : true, '/true' : true,
    '/false/false' : false, '/false' : false,
    '/string1/string1' : '/dir1/dir1',
    '/string1' : '/dir1',
    '/string2/string2' : '',
    '/string2' : '',
    '/null/null' : '',
    '/null' : '',
     '' : [ '/dir1/dir1', '/dir1', '/dir2/dir2', '/dir2' ],
    'nullnull' : '/dir3/dir3',
    'null' : '/dir3',
    '/array/array' : [ '/dir1/dir1', '/dir2/dir2' ],
    '/array' : [ '/dir1', '/dir2' ],
    '/emptyArray/emptyArray' : '',
    '/emptyArray' : ''
  };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'srcOnly1';
  var src = _.mapSupplement( {}, srcMap );
  var got = _.path.filterPairsInplace( src, srcOnly1 );
  var expected =
  {
    '/true' : '',
    '/false' : '',
    '/string1' : '',
    '/string2' : '',
    '/null' : '',
    'null' : '',
    '/array' : '',
    '/emptyArray' : ''
  };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'srcOnly2';
  var src = _.mapSupplement( {}, srcMap );
  var got = _.path.filterPairsInplace( src, srcOnly2 );
  var expected =
  {
    '/true' : true,
    '/false' : false,
    '/string1' : '/dir1',
    '/string2' : '',
    '/null' : '',
    'null' : '/dir3',
    '/array' : [ '/dir1', '/dir2' ],
    '/emptyArray' : ''
  };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'srcOnly3';
  var src = _.mapSupplement( {}, srcMap );
  var got = _.path.filterPairsInplace( src, srcOnly3 );
  var expected =
  {
    '/true' : true,
    '/false' : false,
    '/string1' : '/dir1',
    '/string2' : '',
    '/null' : '',
    'null' : '/dir3',
    '/array' : [ '/dir1', '/dir2' ],
    '/emptyArray' : ''
  };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'dstOnly';
  var src = _.mapSupplement( {}, srcMap );
  var got = _.path.filterPairsInplace( src, dstOnly );
  var expected =
  {
    '' : [ '/dir1', '/dir2', '/dir3' ]
  };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'dstDouble';
  var src = _.mapSupplement( {}, srcMap );
  delete src[ '' ];
  var got = _.path.filterPairsInplace( src, dstDouble );
  var expected = { '' : [ '/dir1', '/dir3', '/dir2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'nothing1';
  var src = _.mapSupplement( {}, srcMap );
  var got = _.path.filterPairsInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'nothing2';
  var src = _.mapSupplement( {}, srcMap );
  var got = _.path.filterPairsInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'nothing3';
  var src = _.mapSupplement( {}, srcMap );
  var got = _.path.filterPairsInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'nothing4';
  var src = _.mapSupplement( {}, srcMap );
  var got = _.path.filterPairsInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'complex map' );

  /* - */

  test.case = 'duplicates';
  var src = { '' : [ '/b', null, null, '', '', '/b' ] };
  var got = _.path.filterPairsInplace( src, duplicates );
  var expected = { '' : '/b' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates, onEach return array';
  var src = [ '/b', null, null, '', '', '/b' ];
  var got = _.path.filterPairsInplace( src, ( it ) => [ it.src, '/file', '/dst', '', null, '', null, undefined ] );
  var expected = [ '/b', '/file', '/dst' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates, onEach return array';
  var src = { 'dir' : [ '/b', null, null, '', '', '/b' ] };
  var got = _.path.filterPairsInplace( src, ( it ) => [ it.src, '/file', '/dst', '', null, '', null, undefined ] );
  var expected = { 'dir' : '/b', '/file' : '/b', '/dst' : '/b' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates';
  var src = { '/dir1' : '/dir2', '/a' : '/b' };
  var got = _.path.filterPairsInplace( src, duplicates );
  var expected = { '/dir1' : '/dir2', '/a' : '/b' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in map';
  var src = { '/dir1' : '/dir2', '/a' : '/b', '/empty' : '', '' : '/file', '/null' : null };
  var got = _.path.filterPairsInplace( src, duplicates );
  var expected = { '/dir1' : '/dir2', '/a' : '/b', '/empty' : '', '' : '/file', '/null' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in map';
  var src = { '/dir1' : '/dir2', '/a' : '/b', '/empty' : '',  '/null' : null };
  var got = _.path.filterPairsInplace( src, duplicates );
  var expected = { '/dir1' : '/dir2', '/a' : '/b', '/empty' : '', '/null' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/dir1', '/a', null, '', '', null ];
  var got = _.path.filterPairsInplace( src, duplicates2 );
  var expected = [ '1', '/dir1', '/dir11', '/a', '/a1' ];
  test.identical( got, expected );
  test.is( got === src );

  /* - */

  test.case = 'boolean values';
  var src = [ '/dir1', true, null, '', '', null ];
  var got = _.path.filterPairsInplace( src, duplicates2 );
  var expected = [ '1', '/dir1', '/dir11' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'boolean values';
  var src = { '/dir' : true, '/a' : null, '/b' : '', '' : null };
  var got = _.path.filterPairsInplace( src, duplicates );
  var expected = { '/dir' : true, '/a' : '', '/b' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'boolean in callback, bool and null values in src';
  var src = { '/dir' : true, '/a' : null, '/b' : '', '' : null };
  var got = _.path.filterPairsInplace( src, bool );
  var expected = { '/dir' : true, '/a' : true, '/b' : true, '' : true };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'boolean in callback, str value in src';
  var src = { '/dir' : false, '/a' : '/dir', '/b' : '', '' : null };
  var got = _.path.filterPairsInplace( src, bool );
  var expected = { '/dir' : true, '/a' : true, '/b' : true, '' : true };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'boolean in callback, bool and null values in src';
  var src = { '/dir' : true, '/a' : null, '/b' : '', '' : null };
  var got = _.path.filterPairsInplace( src, bool2 );
  var expected = { '/dir' : false, '/a' : false, '/b' : false, '' : false };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'boolean in callback, str value in src';
  var src = { '/dir' : false, '/a' : '/dir', '/b' : '', '' : null };
  var got = _.path.filterPairsInplace( src, bool2 );
  var expected = { '/dir' : false, '/a' : false, '/b' : false, '' : false };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'boolean in callback, str value in src';
  var src = { '/dir' : true, '/a' : false, '/b' : '' };
  var got = _.path.filterPairsInplace( src, uncorrectMap );
  var expected = { '/dir' : '/dst', '/a' : false, '/b' : false };
  test.identical( got, expected );
  test.is( got === src );

  /* - */

  if( Config.debug )
  {
    test.open( 'throwing' );

    test.case = 'without arguments';
    test.shouldThrowErrorSync( () => _.path.filterPairsInplace() );

    test.case = 'extra arguments';
    test.shouldThrowErrorSync( () => _.path.filterPairsInplace( '/src', double, nothing1 ) );

    test.case = 'onEach is not a routine';
    test.shouldThrowErrorSync( () => _.path.filterPairsInplace( '/src', [ double ] ) );

    test.case = 'wrong type of filePath';
    test.shouldThrowErrorSync( () => _.path.filterPairsInplace( 1, double ) );
    test.shouldThrowErrorSync( () => _.path.filterPairsInplace( { '/path' : {} }, double ) );
    test.shouldThrowErrorSync( () => _.path.filterPairsInplace( { '/path' : undefined }, double ) );

    test.case = 'wrong type of onEach';
    test.shouldThrowErrorSync( () => _.path.filterPairsInplace( '/path', '/path' ) );

    test.close( 'throwing' );
  }

  /* - */

  function duplicates2( it )
  {
    return [ it.src, it.src, it.src + 1, '', '', null, ];
  }

  function duplicates( it )
  {
    return { [ it.src ] : [ it.dst, it.dst, it.dst, '', '', null, ] };
  }

  function bool( it )
  {
    return { [ it.src ] : true };
  }

  function bool2( it )
  {
    return { [ it.src ] : false };
  }

  function uncorrectMap( it )
  {
    if( it.dst === true )
    return { [ it.src ] : [ true, false, '', null, true, false, '', null, '/dst', true ] };
    if( it.dst === false )
    return { [ it.src ] : [ true, false, '', null, true, false, '', null, '/dst', false ] };
    else
    return { [ it.src ] : [ true, false, '', null, true, false, '', null, '/dst', true, false ] };
  }

  function double( it )
  {
    if( it.src === null )
    _.assert( 0 );
    if( it.src === '' )
    return { [ it.src ] : [ it.dst + it.dst, it.dst ] }
    else
    return { [ it.src + it.src ] : it.dst + it.dst, [ it.src ] : it.dst }
  }

  function srcOnly1( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return { [ it.src ] : '' };
  }

  function srcOnly2( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return it.src;
  }

  function srcOnly3( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return [ it.src ];
  }

  function dstOnly( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return { '' : it.dst };
  }

  function dstDouble( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return { '' : [ it.dst, it.dst ] };
  }

  function nothing1( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return {};
  }

  function nothing2( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return [];
  }

  function nothing3( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return '';
  }

  function nothing4( it )
  {
    if( it.src === null )
    _.assert( 0 );
    return null;
  }
}

//

function filterInplace( test )
{
  test.open( 'callback returns array' );

  test.case = 'null';
  var got = _.path.filterInplace( null, ( e, it ) => [ e ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty string';
  var got = _.path.filterInplace( '', ( e, it ) => [ e ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'not empty strings';
  var got = _.path.filterInplace( '/dir', ( e, it ) => [ e ] );
  var expected = '/dir';
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var got = _.path.filterInplace( src, ( e, it ) => [ e ] );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'array has one element';
  var src = [ '/dir' ];
  var got = _.path.filterInplace( src, ( e, it ) => [ e ] );
  var expected = [ '/dir' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'array has a few elements';
  var src = [ '/dir', '/dir2', '/dir2', '/dir3' ]
  var got = _.path.filterInplace( src, ( e, it ) => [ e ] );
  var expected = [ '/dir', '/dir2', '/dir3' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterInplace( src, ( e, it ) => [ e ] );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty dst in map';
  var src = { '/dir' : [] };
  var got = _.path.filterInplace( src, ( e, it ) => [ e ] );
  var expected = { '/dir' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'map, dst has one element';
  var src = { '/dir' : [ '/a/b' ] };
  var got = _.path.filterInplace( src, ( e, it ) => [ e ] );
  var expected = { '/dir' : '/a/b' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'map, map has a few elements';
  var src = { '/dir' : [ '/a/b', '/cd' ] };
  var got = _.path.filterInplace( src, ( e, it ) => [ e ] );
  var expected = { '/dir' : [ '/a/b', '/cd' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'callback returns array' );

  /* - */

  test.open( 'old tests' );

  test.case = 'drop string';
  var src = '/a/b/c';
  var got = _.path.filterInplace( src, drop );
  var expected = '';
  test.identical( got, expected );

  test.case = 'drop array';
  var src = [ '/dst' ];
  var got = _.path.filterInplace( src, drop );
  var expected = [];
  test.identical( got, expected );
  test.identical( got.length, 0 );

  test.case = 'drop map';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, drop );
  var expected = {};
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b/c';
  var got = _.path.filterInplace( src, onEach );
  var expected = '/prefix/a/b/c';
  test.identical( got, expected );

  test.case = 'array';
  var src = [ '/a', '/b' ];
  var got = _.path.filterInplace( src, onEach );
  var expected = [ '/prefix/a', '/prefix/b' ];
  test.identical( got, expected );
  test.identical( got, src );

  test.case = 'array filter';
  var src = [ '/a', 'b' ];
  var got = _.path.filterInplace( src, onEachFilter );
  var expected = [ '/a' ];
  test.identical( got, expected );

  test.case = 'map';
  var src = { '/src' : '/dst' };
  var got = _.path.filterInplace( src, onEach );
  var expected = { '/prefix/src' : '/prefix/dst' };
  test.identical( got, expected );

  test.case = 'map filter';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, onEachFilter );
  var expected = {};
  test.identical( got, expected );

  test.case = 'map filter';
  var src = { '/a' : [ '/b', 'c', null, undefined ] };
  var got = _.path.filterInplace( src, onEachStructure );
  var expected = { '/src/a' : [ '/dst/b','/dst/c', '/dst' ] };
  test.identical( got, expected );
  test.identical( src, expected );

  test.case = 'map filter keys, onEach returns array with undefined';
  var src = { '/a' : '/b' };
  var got = _.path.filterInplace( src, onEachStructureKeys );
  var expected = { '/src/a' : '/b' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'map with multiple keys';
  var original = { '/src1' : 'dst1', '/src2' : 'dst2' };
  var src = { '/src1' : 'dst1', '/src2' : 'dst2' };
  var got = _.path.filterInplace( src, onEach );
  var expected = { '/prefix/src1' : '/prefix/dst1', '/prefix/src2' : '/prefix/dst2' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'null';
  var src = null;
  var got = _.path.filterInplace( src, onEach );
  var expected = '/prefix';
  test.identical( got, expected );

  /*  */

  function drop( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    return;
  }

  function onEach( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    return _.path.reroot( '/prefix', filePath );
  }

  function onEachFilter( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    if( _.path.isAbsolute( filePath ) )
    return filePath;
  }

  function onEachStructure( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    if( _.arrayIs( filePath ) )
    return filePath.map( onPath );
    return onPath( filePath );

    function onPath( path )
    {
      let prefix = it.side === 'src' ? '/src' : '/dst';
      if( path === null || path === undefined )
      return prefix;
      return _.path.reroot( prefix, path );
    }
  }

  function onEachStructureKeys( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    if( it.side === 'src' )
    return _.path.reroot( '/src', filePath );
    return filePath;
  }

  test.close( 'old tests' );

  /* main tests */

  test.open( 'double' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, double );
  var expected = '/a/b/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, double );
  var expected = [];
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterInplace( src, double );
  var expected = [ '/a/b/a/b' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterInplace( src, double );
  var expected = [ '/a/b/a/b', '/cd/cd' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterInplace( src, double );
  var expected = [ '/a/b/a/b', '/c/d/c/d' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, double );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, double );
  var expected = { '/src/src' : 'dstdst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, double );
  var expected = { '/src/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, double );
  var expected = { '/src/src' : 'dstdst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, double );
  var expected = { '/src/src' : [ 'dst1dst1', 'dst2dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, double );
  var expected = { '' : 'dstdst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterInplace( src, double );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, double );
  var expected = { '' : 'dstdst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, double );
  var expected = { '' : [ 'dst1dst1', 'dst2dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, double );
  var expected = { '/src/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'double' );

  /* - */

  test.open( 'srcOnly2' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = [];
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = [ '/a/b' ];
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = [ '/a/b', '/cd' ];
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = [ '/a/b', '/c/d' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'srcOnly2' );

  /* - */

  test.open( 'srcOnly3' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = [];
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = [ '/a/b' ];
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = [ '/a/b', '/cd' ];
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = [ '/a/b', '/c/d' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'srcOnly3' );

  /* - */

  test.open( 'nothing2' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing2 );
  var expected = [];
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterInplace( src, nothing2 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterInplace( src, nothing2 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterInplace( src, nothing2 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'nothing2' );

  /* - */

  test.open( 'nothing3' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing3 );
  var expected = [];
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterInplace( src, nothing3 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterInplace( src, nothing3 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterInplace( src, nothing3 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'nothing3' );

  /* - */

  test.open( 'nothing4' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing4 );
  var expected = [];
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var got = _.path.filterInplace( src, nothing4 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var got = _.path.filterInplace( src, nothing4 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var got = _.path.filterInplace( src, nothing4 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'empty map';
  var src = {};
  var got = _.path.filterInplace( src, nothing4 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'nothing4' );

  /* - */

  test.open( 'complex map' );

  var srcMap =
  {
    '/true' : true,
    '/false' : false,
    '/null' : null,
    '/string1' : '/dir1',
    '/string2' : '',
    '' : '/dir2',
    null : '/dir3',
    '/array' : [ '/dir1', '/dir2' ],
    '' : [ '/dir1', '/dir2' ],
    '' : [ '' ],
    '/emptyArray' : [],
  };

  test.case = 'double';
  var src = _.entityMake( srcMap );
  var got = _.path.filterInplace( src, double );
  var expected =
  {
    '/true/true' : true,
    '/false/false' : '',
    '/null/null' : '',
    '/string1/string1' : '/dir1/dir1',
    '/string2/string2' : '',
    'nullnull' : '/dir3/dir3',
    '/array/array' : [ '/dir1/dir1', '/dir2/dir2' ],
    '/emptyArray/emptyArray' : ''
  };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'srcOnly2';
  var src = _.entityMake( srcMap );
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected =
  {
    '/true' : '',
    '/false' : '',
    '/null' : '',
    '/string2' : '',
    '/emptyArray' : '',
    '/string1' : '',
    'null' : '',
    '/array' : ''
  };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'srcOnly3';
  var src = _.entityMake( srcMap );
  var got = _.path.filterInplace( src, srcOnly3 );
  var expected =
  {
    '/true' : '',
    '/false' : '',
    '/null' : '',
    '/string1' : '',
    '/string2' : '',
    'null' : '',
    '/array' : '',
    '/emptyArray' : ''
  };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'nothing2';
  var src = _.entityMake( srcMap );
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'nothing3'
  var src = _.entityMake( srcMap );
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'complex map' );

  /* - */

  if( Config.debug )
  {
    test.case = 'without arguments';
    test.shouldThrowErrorSync( () => _.path.filterInplace() );

    test.case = 'one argument';
    test.shouldThrowErrorSync( () => _.path.filterInplace( '/path' ) );

    test.case = 'extra arguments';
    test.shouldThrowErrorSync( () => _.path.filterInplace( '/a/b', drop, 'abs' ) );

    test.case = 'wrong type of filePath';
    test.shouldThrowErrorSync( () => _.path.filterInplace( 1, double ) );

    test.case = 'wrong type of onEach';
    test.shouldThrowErrorSync( () => _.path.filterInplace( '/path', '/path' ) );
  }

  /* callbacks */

  function double( filePath )
  {
    if( filePath === null )
    _.assert( 0 );
    if( filePath )
    return filePath + filePath;
    else
    return '';
  }

  function srcOnly2( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'dst' )
    return '';
    return filePath;
  }

  function srcOnly3( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'dst' )
    return '';
    return [ filePath ];
  }

  function nothing2( filePath )
  {
    if( filePath === null )
    _.assert( 0 );
    return [];
  }

  function nothing3( filePath )
  {
    if( filePath === null )
    _.assert( 0 );
    return '';
  }

  function nothing4( filePath )
  {
    if( filePath === null )
    _.assert( 0 );
    return null;
  }

}

//

function filterInplaceExtends( test )
{
  test.open( 'double' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, double );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, double );
  var expected = { '/src/src' : 'dstdst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, double );
  var expected = { '/src/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, double );
  var expected = { '/src/src' : 'dstdst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, double );
  var expected = { '/src/src' : [ 'dst1dst1', 'dst2dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, double );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterInplace( src, double );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, double );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, double );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, double );
  var expected = { '/src/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'double' );

  /* srcOnly1 */

  test.open( 'srcOnly1' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly1 );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, srcOnly1 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, srcOnly1 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, srcOnly1 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, srcOnly1 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, srcOnly1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterInplace( src, srcOnly1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, srcOnly1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, srcOnly1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, srcOnly1 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'srcOnly1' );

  /* - */

  test.open( 'srcOnly2' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, srcOnly2 );
  var expected = { '/src' : '' };
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'srcOnly2' );

  /* - */

  test.open( 'dstOnly' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, dstOnly );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, dstOnly );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, dstOnly );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterInplace( src, dstOnly );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, dstOnly );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, dstOnly );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'dstOnly' );

  /* - */

  test.open( 'dstDouble' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, dstDouble );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, dstDouble );
  var expected = { '' : 'dstdst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, dstDouble );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, dstDouble );
  var expected = { '' : 'dstdst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, dstDouble );
  var expected = { '' : [ 'dst1dst1', 'dst2dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, dstDouble );
  var expected = { '' : 'dstdst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var got = _.path.filterInplace( src, dstDouble );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, dstDouble );
  var expected = { '' : 'dstdst' };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, dstDouble );
  var expected = { '' : [ 'dst1dst1', 'dst2dst2' ] };
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, dstDouble );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'dstDouble' );

  /* - */

  test.open( 'nothing1' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing1 );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, nothing1 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'nothing1' );

  /* - */

  test.open( 'nothing2' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, nothing2 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'nothing2' );

  /* - */

  test.open( 'nothing3' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( src, src2 );
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var got = _.path.filterInplace( src, nothing3 );
  var expected = {};
  test.identical( got, expected );
  test.is( got === src );

  test.close( 'nothing3' );

  /* callbacks */

  /*
    qqq : improve callbacks
    qqq : cover fields of it
  */

  function double( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'src' )
    return it.src + it.src;
    if( it.side === 'dst' && it.src !== '' )
    return it.dst + it.dst;
    if( filePath )
    return filePath;
    return '';
  }

  function srcOnly1( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'dst' )
    return '';
    return filePath;
  }

  function srcOnly2( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'dst' )
    return '';
    return [ filePath ];
  }

  function dstOnly( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'src' )
    return '';
    return filePath;
  }

  function dstDouble( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'src' )
    return '';
    return filePath + filePath;
  }

  function nothing1( filePath )
  {
    if( filePath === null )
    _.assert( 0 );
    return [];
  }

  function nothing2( filePath )
  {
    if( filePath === null )
    _.assert( 0 );
    return '';
  }

  function nothing3( filePath )
  {
    if( filePath === null )
    _.assert( 0 );
    return null;
  }

}

//

function filter( test )
{
  test.open( 'callback returns array' );

  test.case = 'empty string';
  var got = _.path.filter( '', ( e, it ) => [ e ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'not empty strings';
  var got = _.path.filter( '/dir', ( e, it ) => [ e ] );
  var expected = '/dir';
  test.identical( got, expected );

  test.case = 'empty array';
  var got = _.path.filter( [], ( e, it ) => [ e ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'array has one element';
  var got = _.path.filter( [ '/dir' ], ( e, it ) => [ e ] );
  var expected = '/dir';
  test.identical( got, expected );

  test.case = 'array has a few elements';
  var got = _.path.filter( [ '/dir', '/dir2', '/dir2', '/dir3' ], ( e, it ) => [ e ] );
  var expected = [ '/dir', '/dir2', '/dir3' ];
  test.identical( got, expected );

  test.case = 'empty map';
  var got = _.path.filter( {}, ( e, it ) => [ e ] );
  var expected = '';
  test.identical( got, expected );

  test.case = 'empty dst in map';
  var got = _.path.filter( { '/dir' : [] }, ( e, it ) => [ e ] );
  var expected = '/dir';
  test.identical( got, expected );

  test.case = 'map, dst has one element';
  var got = _.path.filter( { '/dir' : [ '/a/b' ] }, ( e, it ) => [ e ] );
  var expected = { '/dir' : '/a/b' };
  test.identical( got, expected );

  test.case = 'map, map has a few elements';
  var got = _.path.filter( { '/dir' : [ '/a/b', '/cd' ] }, ( e, it ) => [ e ] );
  var expected = { '/dir' : [ '/a/b', '/cd' ] };
  test.identical( got, expected );

  test.close( 'callback returns array' );

  test.open( 'old tests' );

  test.case = 'drop string';
  var src = '/a/b/c';
  var got = _.path.filter( src, drop );
  var expected = null;
  test.identical( got, expected );

  test.case = 'drop array';
  var src = [ '/dst' ];
  var got = _.path.filter( src, drop );
  var expected = '';
  test.identical( got, expected );

  test.case = 'drop map';
  var src = { '/src' : 'dst' };
  var got = _.path.filter( src, drop );
  var expected = '';
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b/c';
  var got = _.path.filter( src, onEach );
  var expected = '/prefix/a/b/c';
  test.identical( got, expected );

  test.case = 'array';
  var src = [ '/a', '/b' ];
  var got = _.path.filter( src, onEach );
  var expected = [ '/prefix/a', '/prefix/b' ];
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'array filter';
  var original = [ '/a', 'b' ];
  var src = [ '/a', 'b' ];
  var got = _.path.filter( src, onEachFilter );
  var expected = '/a';
  test.identical( got, expected );
  test.identical( src, original );

  test.case = 'map';
  var original = { '/src' : '/dst' };
  var src = { '/src' : '/dst' };
  var got = _.path.filter( src, onEach );
  var expected = { '/prefix/src' : '/prefix/dst' };
  test.identical( got, expected );
  test.identical( src, original );

  test.case = 'map filter';
  var src = { '/src' : 'dst' };
  var got = _.path.filter( src, onEachFilter );
  var expected = '';
  test.identical( got, expected );

  test.case = 'map with multiple keys';
  var original = { '/src1' : 'dst1', '/src2' : 'dst2' };
  var src = { '/src1' : 'dst1', '/src2' : 'dst2' };
  var got = _.path.filter( src, onEach );
  var expected = { '/prefix/src1' : '/prefix/dst1', '/prefix/src2' : '/prefix/dst2' };
  test.identical( got, expected );
  test.identical( src, original );
  test.is( got !== src );

  test.case = 'map filter';
  var src = { '/a' : [ '/b', 'c', null, undefined ] };
  var got = _.path.filter( src, onEachStructure );
  var expected =
  {
    '/src/a' : [ '/dst/b','/dst/c', '/dst' ]
  }
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'map filter keys, onEach returns array with undefined';
  var src = { '/a' : '/b' };
  var got = _.path.filter( src, onEachStructureKeys );
  var expected =
  {
    '/src/a' : '/b'
  }
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'null';
  var src = null;
  var got = _.path.filter( src, onEach );
  var expected = '/prefix';
  test.identical( got, expected );
  test.is( got !== src );

  /*  */

  function drop( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    return;
  }

  function onEach( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    return _.path.reroot( '/prefix', filePath );
  }

  function onEachFilter( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    if( _.path.isAbsolute( filePath ) )
    return filePath;
  }

  function onEachStructure( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    if( _.arrayIs( filePath ) )
    return filePath.map( onPath );
    return onPath( filePath );

    function onPath( path )
    {
      if( filePath === null )
      _.assert( 0 );
      let prefix = it.side === 'src' ? '/src' : '/dst';
      if( path === null || path === undefined )
      return prefix;
      return _.path.reroot( prefix, path );
    }
  }

  function onEachStructureKeys( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    if( it.side === 'src' )
    return [ _.path.reroot( '/src', filePath ), undefined ];
    return filePath;
  }

  test.close( 'old tests' );

  /* main tests */

  test.open( 'double' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '/a/b/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '/a/b/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = [ '/a/b/a/b', '/cd/cd' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = [ '/a/b/a/b', '/c/d/c/d' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '/src/src' : 'dstdst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
    debugger;
  var got = _.path.filter( src, double );
  var expected = '/src/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '/src/src' : 'dstdst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '/src/src' : [ 'dst1dst1', 'dst2dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '' : 'dstdst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '' : 'dstdst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '' : [ 'dst1dst1', 'dst2dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '/src/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'double' );

  /* - */

  test.open( 'srcOnly2' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = null;
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = null;
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = [ '/a/b', '/cd' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = [ '/a/b', '/c/d' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = { '/src' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = { '/src' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = { '/src' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'srcOnly2' );

  /* - */

  test.open( 'srcOnly3' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = null;
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = null;
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = '/a/b';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = [ '/a/b', '/cd' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = [ '/a/b', '/c/d' ];
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = { '/src' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = { '/src' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = { '/src' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'srcOnly3' );

  /* - */

  test.open( 'nothing2' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'nothing2' );

  /* - */

  test.open( 'nothing3' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'nothing3' );

  /* - */

  test.open( 'nothing4' );

  test.case = 'null';
  var src = null;
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty';
  var src = '';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'string';
  var src = '/a/b';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element array';
  var src = [ '/a/b' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'several elements array';
  var src = [ '/a/b', '/cd' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'duplicates in array';
  var src = [ '/a/b', '/a/b', '/c/d', '/c/d' ];
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing4 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'nothing4' );

  /* - */

  test.open( 'complex map' );

  var src =
  {
    '/true' : true,
    '/false' : false,
    '/null' : null,
    '/string1' : '/dir1',
    '/string2' : '',
    '' : '/dir2',
    null : '/dir3',
    '/array' : [ '/dir1', '/dir2' ],
    '' : [ '/dir1', '/dir2' ],
    '' : [ '' ],
    '/emptyArray' : [],
  };

  test.case = 'double';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected =
  {
    '/true/true' : true,
    '/false/false' : '',
    '/null/null' : '',
    '/string1/string1' : '/dir1/dir1',
    '/string2/string2' : '',
    'nullnull' : '/dir3/dir3',
    '/array/array' : [ '/dir1/dir1', '/dir2/dir2' ],
    '/emptyArray/emptyArray' : ''
  };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'srcOnly2';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected =
  {
    '/true' : true,
    '/string1' : '/dir1',
    'null' : '/dir3',
    '/array' : [ '/dir1', '/dir2' ],
  };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'srcOnly3';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly3 );
  var expected =
  {
    '/true' : true,
    '/string1' : '/dir1',
    'null' : '/dir3',
    '/array' : [ '/dir1', '/dir2' ],
  };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'nothing2';
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'nothing3'
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'complex map' );

  /* - */

  if( Config.debug )
  {
    test.case = 'without arguments';
    test.shouldThrowErrorSync( () => _.path.filter() );

    test.case = 'one argument';
    test.shouldThrowErrorSync( () => _.path.filter( '/path' ) );

    test.case = 'extra arguments';
    test.shouldThrowErrorSync( () => _.path.filter( '/a/b', drop, 'abs' ) );

    test.case = 'wrong type of filePath';
    test.shouldThrowErrorSync( () => _.path.filter( 1, double ) );

    test.case = 'wrong type of onEach';
    test.shouldThrowErrorSync( () => _.path.filter( '/path', '/path' ) );
  }

  /* callbacks */

  function double( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    if( filePath )
    return filePath + filePath;
    else
    return '';
  }

  function srcOnly2( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    if( filePath )
    return filePath;
  }

  function srcOnly3( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    if( filePath )
    return [ filePath ];
  }

  function nothing2( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    return [];
  }

  function nothing3( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    return '';
  }

  function nothing4( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );
    return null;
  }

}

function filterExtends( test )
{
  test.open( 'double' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '/src/src' : 'dstdst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '/src/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '/src/src' : 'dstdst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '/src/src' : [ 'dst1dst1', 'dst2dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, double );
  var expected = '/src/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'double' );

  /* srcOnly1 */

  test.open( 'srcOnly1' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly1 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly1 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly1 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly1 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly1 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'srcOnly1' );

  /* - */

  test.open( 'srcOnly2' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, srcOnly2 );
  var expected = '/src';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'srcOnly2' );

  /* - */

  test.open( 'dstOnly' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstOnly );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstOnly );
  var expected = { '' : 'dst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstOnly );
  var expected = { '' : [ 'dst1', 'dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstOnly );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'dstOnly' );

  /* - */

  test.open( 'dstDouble' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstDouble );
  var expected = { '' : 'dstdst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstDouble );
  var expected = { '' : 'dstdst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '/src' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstDouble );
  var expected = { '' : [ 'dst1dst1', 'dst2dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstDouble );
  var expected = { '' : 'dstdst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ '' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstDouble );
  var expected = { '' : 'dstdst' };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstDouble );
  var expected = { '' : [ 'dst1dst1', 'dst2dst2' ] };
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, dstDouble );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'dstDouble' );

  /* - */

  test.open( 'nothing1' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing1 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'nothing1' );

  /* - */

  test.open( 'nothing2' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing2 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'nothing2' );

  /* - */

  test.open( 'nothing3' );

  test.case = 'empty map';
  var src = {};
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst and src';
  var src = { '/src' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single empty array and src';
  var src = { '/src' : [] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in single element array and src';
  var src = { '/src' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with dst in multiple element array and src';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst';
  var src = { '' : 'dst' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in empty array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in single element array';
  var src = { '' : [ 'dst' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only dst in multiple element array';
  var src = { '' : [ 'dst1', 'dst2' ] };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.case = 'single element map with only src';
  var src = { '/src' : '' };
  var src2 = _.entityMake( src );
  var got = _.path.filter( src, nothing3 );
  var expected = '';
  test.identical( src, src2 );
  test.identical( got, expected );

  test.close( 'nothing3' );

  /* callbacks */

  /*
    qqq : improve callbacks
    qqq : cover fields of it
  */

  function double( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'src' )
    return it.src + it.src;
    if( it.side === 'dst' && it.src !== '' )
    return it.dst + it.dst;
    if( filePath )
    return filePath;
    return '';
  }

  function srcOnly1( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'dst' )
    return '';
    return filePath;
  }

  function srcOnly2( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'dst' )
    return '';
    return [ filePath ];
  }

  function dstOnly( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'src' )
    return '';
    return filePath;
  }

  function dstDouble( filePath, it )
  {
    if( filePath === null )
    _.assert( 0 );

    if( it.side === 'src' )
    return '';
    return filePath + filePath;
  }

  function nothing1( filePath )
  {
    if( filePath === null )
    _.assert( 0 );
    return [];
  }

  function nothing2( filePath )
  {
    if( filePath === null )
    _.assert( 0 );
    return '';
  }

  function nothing3( filePath )
  {
    if( filePath === null )
    _.assert( 0 );
    return null;
  }

}

//

/*
qqq : sync test cases
qqq : add single-argument test cases
*/

function mapExtend( test )
{
  let path = _.path;
  function constr( src )
  {
    this.value = src;
    return this;
  }
  let obj0 = new constr( 0 );
  let obj1 = new constr( 1 );
  let obj2 = new constr( 2 );

  /* extra */

  /* qqq : important case! */
  test.case = 'no override of empty string by boolean';
  var expected = { '.' : '', '**/.git/**' : false };
  var dstMap = { '.' : '' };
  var srcMap = '**/.git/**';
  var dstPath = false;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dst is map, src is null, dstPath is str';
  var expected = { '/src' : '/dst' };
  var dstMap = { '/src' : '/dst' };
  var srcMap = null;
  var dstPath = '/dst2';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dst is map with empty str in src, src is map with empty str in src, dstPath is str';
  var expected = { '/src' : '/dst', '' : '/dst3' };
  var dstMap = { '/src' : '/dst' };
  var srcMap = { '' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'single string';
  var expected = { '/src' : '' };
  var dstMap = '/src';
  var got = path.mapExtend( dstMap );
  test.identical( got, expected );

  test.case = 'single string';
  var expected = { '/src' : '' };
  var dstMap = { '/src' : null };
  var got = path.mapExtend( dstMap );
  test.identical( got, expected );

  /* - */

  test.case = 'dstMap=null, srcMap=null, dstPath=undefined';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = undefined;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=undefined';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = undefined;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=undefined';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = undefined;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=undefined';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = undefined;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=null';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=null';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=null';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=null';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=empty';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = '';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=empty';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = '';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=empty';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = '';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=empty';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = '';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* */

  test.case = 'dstMap=map with only src dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '', 'a' : true, 'b' : false };
  var dstMap = { '.' : '' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with only dst dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '' : '.', 'a' : true, 'b' : false };
  var dstMap = { '' : '.' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with only src and dst dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '.', 'a' : true, 'b' : false };
  var dstMap = { '.' : '.' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=is dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '', 'a' : true, 'b' : false };
  var dstMap = '.';
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=is empty, srcMap=map with bools, dstPath=undefined';
  var expected = { 'a' : true, 'b' : false };
  var dstMap = '';
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* */

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { '/dir/**' : '', '/dir/doubledir/d1/**' : '', '/dir/**/**b**' : false, '/dir/doubledir/d1/**/**b**' : false };
  var dstMap = { '/dir/**' : true, '/dir/doubledir/d1/**' : true, '/dir/**/**b**' : false, '/dir/doubledir/d1/**/**b**' : false };
  var srcMap = [ '/dir/**', '/dir/doubledir/d1/**' ];
  var dstPath = '';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { '/' : '/dst' }
  var dstMap = null;
  var srcMap = { '/' : '' };
  var dstPath = '/dst';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { 'a' : '', 'b' : '' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapExtend( dstMap, srcMap );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=null';
  var expected = { 'a' : '', 'b' : '' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapExtend( dstMap, srcMap, null );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=str';
  var expected = { 'a' : 'c', 'b' : 'c' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapExtend( dstMap, srcMap, 'c' );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=str';
  var expected = {}
  var dstMap = null;
  var srcMap = null;
  var dstPath = '/dst';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null in arr, dstPath=str';
  var expected = {}
  var dstMap = null;
  var srcMap = [ null ];
  var dstPath = '/dst';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=map, dstPath=null';
  var expected = { '/src' : '/dst' }
  var dstMap = null;
  var srcMap = { '/src' : '/dst' };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=map, srcMap=str, dstPath=null';
  // var expected = { '/src' : '/dst' }
  var expected = { '/src' : '' }
  var dstMap = { '/src' : '/dst' };
  var srcMap = '/src';
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  /* - */

  test.case = 'dstMap=map with dot in src, srcMap=map, dstPath=null';
  var expected = { '.' : '', 'x' : '', 'y' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '.' : null, 'x' : null, 'y' : '' };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with dot in src, srcMap=map, dstPath=null';
  var expected = { '.' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '.' : null };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty in src, srcMap=map, dstPath=null';
  var expected = { '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '' : null };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty in src and dst, srcMap=map, dstPath=null';
  var expected = { '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '' : '' };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=dot str, srcMap=map, dstPath=null';
  var expected = { '.' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = '.';
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* - */

  test.case = 'dstMap=map, srcMap=empty, dstPath=str';
  var expected = { '/src1' : '/dst', '/src2' : '/dst' };
  var dstMap = { '/src1' : null, '/src2' : '' };
  var srcMap = '';
  var dstPath = '/dst';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=str, dstPath=str, rewrite';
  var expected = { '/src1' : '/dst2', '/src2' : '/dst1' };
  var dstMap = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var srcMap = '/src1';
  var dstPath = '/dst2';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=map, dstPath=str, rewrite';
  var expected = { '/src1' : '/dst2', '/src2' : '/dst3' };
  var dstMap = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var srcMap = { '/src1' : null, '/src2' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=map, dstPath=str, rewrite';
  var expected = { '/src1' : '/dst2', '/src2' : '/dst3' };
  var dstMap = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var srcMap = { '/src1' : null, '/src2' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=null, dstPath=str';
  var expected = { '/src1' : '/dst', '/src2' : '/dst' };
  var dstMap = { '/src1' : null, '/src2' : '' };
  var srcMap = null;
  var dstPath = '/dst';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=null, dstPath=str';
  var expected = { "" : "/dst2" };
  var dstMap = { "" : "/dst2" };
  var srcMap = null;
  var dstPath = '/dst2';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=null, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = null;
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=string, dstPath=null';
  var expected = { "/src" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '/src';
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=array, dstPath=null';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = [ '/src1', '/src2' ];
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty array, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = [];
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty map, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = {};
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty str, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty str, dstPath=empty str';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = '';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=not normal empty map, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { "" : "" };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map with only src, dstPath=null';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : null, '/src2' : null };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=null';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=not normal empty map, dstPath=empty str';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { "" : "" };
  var dstPath = '';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map with only src, dstPath=empty str';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : null, '/src2' : null };
  var dstPath = '';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=empty str';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=str';
  var expected = { '/null' : '/dstx', '/str' : '/dst2', '/empty1' : '/dstx', '/empty2' : '/dstx', '/empty2' : '/dstx', '/true' : true, '/false' : false, '' : '/dst' };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '/dstx';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=str, same as in dst map';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '/dst';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=null';
  var expected = { "" : "/dst", "/src1" : "/dst1", "/src2" : "/dst2" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : '/dst1', '/src2' : '/dst2' };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=complex map, dstPath=null';
  var expected =
  {
    '/True' : true,
    '/False' : false,
    '/Zero' : false,
    '/One' : true,
    '/Null' : '/dst',
    '/String1' : '/dir1',
    '/String2' : '/dir2',
    '/Array' : [ '/dir1', '/dir2' ],
    '/Object' : { 'value' : 1 },
  }
  var dstMap = { "" : "/dst" };
  var srcMap =
  {
    '' : null,
    '/True' : true,
    '/False' : false,
    '/Zero' : 0,
    '/One' : 1,
    '/Null' : null,
    '/String1' : '/dir1',
    '/String2' : '/dir2',
    '/Array' : [ '/dir1', '/dir2' ],
    '/Object' : obj1,
  };
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=map with empty src, srcMap=string, dstPath=string';
  var expected = { '' : '/dst', '/src' : '/dst2' };
  var dstMap = { "" : "/dst" };
  var srcMap = '/src';
  var dstPath = '/dst2';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* - */

  test.open( 'src<>map, dst<>map' );

  test.case = 'src=str, dst=str, dstPath=null';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = '/b';
  var dstPath = null;
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=str, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = [ '/b' ];
  var dstPath = [ null ];
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=arr, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = [ '/a' ];
  var srcMap = [ '/b' ];
  var dstPath = [ null ];
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=str, dst=str, dstPath=null';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = '/b';
  var dstPath = '';
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=str, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = [ '/b' ];
  var dstPath = [ '' ];
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=arr, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = [ '/a' ];
  var srcMap = [ '/b' ];
  var dstPath = [ '' ];
  var got = path.mapExtend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.close( 'src<>map, dst<>map' );

  /* - */

  test.open( 'defaultDstPath:true' );

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : true }
  var got = path.mapExtend( null, '/a/b', true );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : true, '/c/d' : true }
  var got = path.mapExtend( null, [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var got = path.mapExtend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : true, '/a/b' : true }
  var got = path.mapExtend( '/z', '/a/b', true );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : true, '/a/b' : true, '/c/d' : true }
  var got = path.mapExtend( '/z', [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : true, '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var got = path.mapExtend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'no dstPath' );

  test.case = 'no orphan';
  var expected = { '/One' : false, '/Str' : 'str', '/EmptyString1' : '', '/EmptyString2' : '', '/Null1' : '', '/Null2' : '' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null }
  var got = path.mapExtend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'dst has orphan';
  var expected = { '/One' : false, '/Str' : 'str', '/EmptyString1' : '/dst', '/EmptyString2' : '/dst', '/Null1' : '/dst', '/Null2' : '/dst' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null, '' : '/dst' }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null }
  var got = path.mapExtend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src has orphan';
  var expected = { '/One' : false, '/Str' : 'str', '/EmptyString1' : '/dst', '/EmptyString2' : '/dst', '/Null1' : '/dst', '/Null2' : '/dst' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null, '' : '/dst' }
  var got = path.mapExtend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'dst has orphan, no place for it';
  var expected = { '/One' : false, '' : '/dst' }
  var dst = { '/One' : 1, '' : '/dst' }
  var src = { '/One' : 0 }
  var got = path.mapExtend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src has orphan, no place for it';
  var expected = { '/One' : false, '' : '/dst' }
  var dst = { '/One' : 1, }
  var src = { '/One' : 0, '' : '/dst' }
  var got = path.mapExtend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'no dstPath' )

  test.close( 'defaultDstPath:true' );

  /* */

  test.open( 'src:null' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapExtend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, null, null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, null, '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapExtend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapExtend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapExtend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, null, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, null, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ]
  var got = path.mapExtend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:null' )

  /* */

  test.open( 'src:empty str' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapExtend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, '', null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, '', '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapExtend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapExtend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapExtend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, '', true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' :  [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, '', false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ]
  var got = path.mapExtend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty str' )

  /* */

  test.open( 'src:empty arr' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapExtend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, [ '', null, '' ], null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, [ '', null, '' ], '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapExtend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapExtend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapExtend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, [ '', null, '' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, [ '', null, '' ], false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ];
  var got = path.mapExtend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty arr' )

  /* */

  test.open( 'src:empty map' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapExtend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, { '' : '' }, null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, { '' : '' }, '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapExtend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapExtend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapExtend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, { '' : '' }, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, { '' : '' }, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ];
  var got = path.mapExtend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty map' )

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, '/a/b', true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true, '/c/d' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : true, '/Zero' : false, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/One' : true, '/Zero' : false, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true, }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ 'dst1', 'dst2' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.open( 'defaultDstPath:false' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : false }
  var got = path.mapExtend( null, '/a/b', false );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : false, '/c/d' : false }
  var got = path.mapExtend( null, [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var got = path.mapExtend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : false, '/a/b' : false }
  var got = path.mapExtend( '/z', '/a/b', false );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : false, '/a/b' : false, '/c/d' : false }
  var got = path.mapExtend( '/z', [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : false, '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var got = path.mapExtend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, '/a/b', false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false, '/c/d' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapExtend( dst, null, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapExtend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false };
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/One' : true, '/Zero' : false, '/Object' : { 'value' : 1 }, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : ['/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.close( 'defaultDstPath:false' )
  test.open( 'defaultDstPath:array' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ] }
  var got = path.mapExtend( null, '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var got = path.mapExtend( null, [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var got = path.mapExtend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ] }
  var got = path.mapExtend( '/z', '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var got = path.mapExtend( '/z', [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var got = path.mapExtend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : [ '/dir1', '/dir2' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapExtend( dst, null, [ '/dir1', '/dir2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, only bools';
  var expected = { '/wasTrue' : true, '/wasFalse' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, null, [ '/dir1', '/dir2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] };
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapExtend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapExtend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var got = path.mapExtend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapExtend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : true, '/False' : false, '/One' : true, '/Zero' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapExtend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : true, '/False' : false, '/One' : true, '/Zero' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] };
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapExtend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : true, '/False' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1',  '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ],'/Object' : { 'value' : 1 }, '/One' : true, '/Zero' : false, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ] };
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.close( 'defaultDstPath:array' )
  test.open( 'defaultDstPath:obj' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : obj2 }
  var got = path.mapExtend( null, '/a/b', obj2 );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : obj2, '/c/d' : obj2 }
  var got = path.mapExtend( null, [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var got = path.mapExtend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : obj2, '/a/b' : obj2 }
  var got = path.mapExtend( '/z', '/a/b', obj2 );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : obj2, '/a/b' : obj2, '/c/d' : obj2 }
  var got = path.mapExtend( '/z', [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : obj2, '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var got = path.mapExtend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, '/a/b', obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2, '/c/d' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapExtend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapExtend( dst, null, obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 }, }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : true, '/False' : false, '/Null' : { 'value' : 2 }, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : true, '/False' : false, '/Null' : { 'value' : 2 }, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : true, '/False' : false, '/Null' : { 'value' : 2 }, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapExtend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is the same object';
  var exp = { '/True' : true, '/False' : false, '/Null' : obj0, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj0 }
  var dst = { '/True' : true, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj0 }
  var got = path.mapExtend( dst, src, obj0 );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  test.close( 'defaultDstPath:obj' )

  /* - */

  test.open( 'dstPath=map' );

  test.shouldThrowErrorSync( () => path.mapExtend( {}, {}, {} ) );

  // test.case = 'dstMap=null, srcMap=null, dstPath=map';
  // var expected = { '/True' : true, '/False' : false, '/Zero' : 0, '/One' : 1, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  // var dstMap = null;
  // var srcMap = null;
  // var dstPath = { '/True' : true, '/False' : false, '/Zero' : 0, '/One' : 1, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  // var got = path.mapExtend( dstMap, srcMap, dstPath );
  // test.identical( got, expected );
  // test.is( got !== dstMap )
  // test.is( got !== srcMap )
  // test.is( got !== dstPath )

  test.close( 'dstPath=map' );

  /* - */

  test.open( 'throwing' )

  test.case = 'dstMap=null, srcMap=null, dstPath=map';
  var dstMap = null;
  var srcMap = null;
  var dstPath = { '/True' : true, '/False' : false, '/Zero' : 0, '/One' : 1, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  test.shouldThrowErrorSync( () => path.mapExtend( dstMap, srcMap, dstPath ) );
  test.shouldThrowErrorSync( () => path.mapExtend( {}, {}, {} ) );

  test.close( 'throwing' )

}

//

function mapSupplement( test )
{
  let path = _.path;
  function constr( src )
  {
    this.value = src;
    return this;
  }
  let obj0 = new constr( 0 );
  let obj1 = new constr( 1 );
  let obj2 = new constr( 2 );

  /* - */

  test.case = 'dstMap=null, srcMap=null, dstPath=undefined';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = undefined;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=undefined';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = undefined;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=undefined';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = undefined;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=undefined';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = undefined;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=null';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=null';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=null';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=null';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=empty';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = '';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=empty';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = '';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=empty';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = '';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=empty';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = '';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* */

  test.case = 'dstMap=map with only src dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '', 'a' : true, 'b' : false };
  var dstMap = { '.' : '' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with only dst dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '' : '.', 'a' : true, 'b' : false };
  var dstMap = { '' : '.' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with only src and dst dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '.', 'a' : true, 'b' : false };
  var dstMap = { '.' : '.' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=is dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '', 'a' : true, 'b' : false };
  var dstMap = '.';
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=is empty, srcMap=map with bools, dstPath=undefined';
  var expected = { 'a' : true, 'b' : false };
  var dstMap = '';
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* */

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { '/dir/**' : true, '/dir/doubledir/d1/**' : true, '/dir/**/**b**' : false, '/dir/doubledir/d1/**/**b**' : false };
  var dstMap = { '/dir/**' : true, '/dir/doubledir/d1/**' : true, '/dir/**/**b**' : false, '/dir/doubledir/d1/**/**b**' : false };
  var srcMap = [ '/dir/**', '/dir/doubledir/d1/**' ];
  var dstPath = '';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { '/' : '/dst' }
  var dstMap = null;
  var srcMap = { '/' : '' };
  var dstPath = '/dst';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { 'a' : '', 'b' : '' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapSupplement( dstMap, srcMap );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=null';
  var expected = { 'a' : '', 'b' : '' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapSupplement( dstMap, srcMap, null );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=str';
  var expected = { 'a' : 'c', 'b' : 'c' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapSupplement( dstMap, srcMap, 'c' );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=str';
  var expected = {}
  var dstMap = null;
  var srcMap = null;
  var dstPath = '/dst';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null in arr, dstPath=str';
  var expected = {}
  var dstMap = null;
  var srcMap = [ null ];
  var dstPath = '/dst';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=map, dstPath=null';
  var expected = { '/src' : '/dst' }
  var dstMap = null;
  var srcMap = { '/src' : '/dst' };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=map, srcMap=str, dstPath=null';
  var expected = { '/src' : '/dst' }
  var dstMap = { '/src' : '/dst' };
  var srcMap = '/src';
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  /* - */

  test.case = 'dstMap=map with dot in src, srcMap=map, dstPath=null';
  var expected = { '.' : '', 'x' : '', 'y' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '.' : null, 'x' : null, 'y' : '' };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with dot in src, srcMap=map, dstPath=null';
  var expected = { '.' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '.' : null };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty in src, srcMap=map, dstPath=null';
  var expected = { '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '' : null };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty in src and dst, srcMap=map, dstPath=null';
  var expected = { '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '' : '' };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=dot str, srcMap=map, dstPath=null';
  var expected = { '.' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = '.';
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* - */

  test.case = 'dstMap=map, srcMap=empty, dstPath=str';
  var expected = { '/src1' : '/dst', '/src2' : '/dst' };
  var dstMap = { '/src1' : null, '/src2' : '' };
  var srcMap = '';
  var dstPath = '/dst';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=str, dstPath=str, rewrite';
  var expected = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var dstMap = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var srcMap = '/src1';
  var dstPath = '/dst2';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=map, dstPath=str, rewrite';
  var expected = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var dstMap = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var srcMap = { '/src1' : null, '/src2' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=map, dstPath=str, rewrite';
  var expected = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var dstMap = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var srcMap = { '/src1' : null, '/src2' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=null, dstPath=str';
  var expected = { '/src1' : '/dst', '/src2' : '/dst' };
  var dstMap = { '/src1' : null, '/src2' : '' };
  var srcMap = null;
  var dstPath = '/dst';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=null, dstPath=str';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = null;
  var dstPath = '/dst2';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=null, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = null;
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=string, dstPath=null';
  var expected = { "/src" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '/src';
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=array, dstPath=null';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = [ '/src1', '/src2' ];
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty array, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = [];
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty map, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = {};
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty str, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty str, dstPath=empty str';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = '';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=not normal empty map, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { "" : "" };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map with only src, dstPath=null';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : null, '/src2' : null };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=null';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=not normal empty map, dstPath=empty str';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { "" : "" };
  var dstPath = '';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map with only src, dstPath=empty str';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : null, '/src2' : null };
  var dstPath = '';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=empty str';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=str';
  var expected = { '/null' : '/dstx', '/str' : '/dst2', '/empty1' : '/dstx', '/empty2' : '/dstx', '/empty2' : '/dstx', '/true' : true, '/false' : false, '' : '/dst' };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '/dstx';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=str, same as in dst map';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '/dst';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=null';
  var expected = { "" : "/dst", "/src1" : "/dst1", "/src2" : "/dst2" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : '/dst1', '/src2' : '/dst2' };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=complex map, dstPath=null';
  var expected =
  {
    '/True' : true,
    '/False' : false,
    '/Zero' : false,
    '/One' : true,
    '/Null' : '/dst',
    '/String1' : '/dir1',
    '/String2' : '/dir2',
    '/Array' : [ '/dir1', '/dir2' ],
    '/Object' : { 'value' : 1 },
  }
  var dstMap = { "" : "/dst" };
  var srcMap =
  {
    '' : null,
    '/True' : true,
    '/False' : false,
    '/Zero' : 0,
    '/One' : 1,
    '/Null' : null,
    '/String1' : '/dir1',
    '/String2' : '/dir2',
    '/Array' : [ '/dir1', '/dir2' ],
    '/Object' : obj1,
  };
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=map with empty src, srcMap=string, dstPath=string';
  var expected = { '' : '/dst', '/src' : '/dst2' };
  var dstMap = { "" : "/dst" };
  var srcMap = '/src';
  var dstPath = '/dst2';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* - */

  test.open( 'src<>map, dst<>map' );

  test.case = 'src=str, dst=str, dstPath=null';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = '/b';
  var dstPath = null;
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=str, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = [ '/b' ];
  var dstPath = [ null ];
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=arr, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = [ '/a' ];
  var srcMap = [ '/b' ];
  var dstPath = [ null ];
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=str, dst=str, dstPath=null';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = '/b';
  var dstPath = '';
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=str, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = [ '/b' ];
  var dstPath = [ '' ];
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=arr, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = [ '/a' ];
  var srcMap = [ '/b' ];
  var dstPath = [ '' ];
  var got = path.mapSupplement( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.close( 'src<>map, dst<>map' );

  /* - */

  test.open( 'defaultDstPath:true' );

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : true }
  var got = path.mapSupplement( null, '/a/b', true );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : true, '/c/d' : true }
  var got = path.mapSupplement( null, [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var got = path.mapSupplement( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : true, '/a/b' : true }
  var got = path.mapSupplement( '/z', '/a/b', true );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : true, '/a/b' : true, '/c/d' : true }
  var got = path.mapSupplement( '/z', [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : true, '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var got = path.mapSupplement( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'no dstPath' );

  test.case = 'no orphan';
  var expected = { '/One' : true, '/Str' : 'str', '/EmptyString1' : '', '/EmptyString2' : '', '/Null1' : '', '/Null2' : '' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null }
  var got = path.mapSupplement( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'dst has orphan';
  var expected = { '/One' : true, '/Str' : 'str', '/EmptyString1' : '/dst', '/EmptyString2' : '/dst', '/Null1' : '/dst', '/Null2' : '/dst' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null, '' : '/dst' }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null }
  var got = path.mapSupplement( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src has orphan';
  var expected = { '/One' : true, '/Str' : 'str', '/EmptyString1' : '/dst', '/EmptyString2' : '/dst', '/Null1' : '/dst', '/Null2' : '/dst' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null, '' : '/dst' }
  var got = path.mapSupplement( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'dst has orphan, no place for it';
  var expected = { '/One' : true, '' : '/dst' }
  var dst = { '/One' : 1, '' : '/dst' }
  var src = { '/One' : 0 }
  var got = path.mapSupplement( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src has orphan, no place for it';
  var expected = { '/One' : true, '' : '/dst' }
  var dst = { '/One' : 1, }
  var src = { '/One' : 0, '' : '/dst' }
  var got = path.mapSupplement( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'no dstPath' )

  test.close( 'defaultDstPath:true' );

  /* */

  test.open( 'src:null' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapSupplement( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, null, null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, null, '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapSupplement( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapSupplement( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapSupplement( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, null, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, null, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ]
  var got = path.mapSupplement( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:null' )

  /* */

  test.open( 'src:empty str' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapSupplement( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, '', null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, '', '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapSupplement( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapSupplement( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapSupplement( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, '', true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' :  [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, '', false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ]
  var got = path.mapSupplement( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty str' )

  /* */

  test.open( 'src:empty arr' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapSupplement( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, [ '', null, '' ], null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, [ '', null, '' ], '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapSupplement( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapSupplement( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapSupplement( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, [ '', null, '' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, [ '', null, '' ], false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ];
  var got = path.mapSupplement( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty arr' )

  /* */

  test.open( 'src:empty map' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapSupplement( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, { '' : '' }, null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, { '' : '' }, '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapSupplement( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapSupplement( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapSupplement( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, { '' : '' }, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, { '' : '' }, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ];
  var got = path.mapSupplement( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty map' )

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, '/a/b', true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true, '/c/d' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [], '/EmptyArray2' : [], '/EmptyArray3' : [] }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' :true, '/Object' : true, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/One' : true, '/Zero' : false, '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2', '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ 'dst1', 'dst2' ], '/One' : true, '/Zero' : false, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true, }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ 'dst1', 'dst2' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.open( 'defaultDstPath:false' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : false }
  var got = path.mapSupplement( null, '/a/b', false );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : false, '/c/d' : false }
  var got = path.mapSupplement( null, [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var got = path.mapSupplement( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : false, '/a/b' : false }
  var got = path.mapSupplement( '/z', '/a/b', false );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : false, '/a/b' : false, '/c/d' : false }
  var got = path.mapSupplement( '/z', [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : false, '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var got = path.mapSupplement( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, '/a/b', false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false, '/c/d' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapSupplement( dst, null, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [], '/EmptyArray2' : [], '/EmptyArray3' : [], }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapSupplement( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false, '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false };
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2', '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/One' : true, '/Zero' : false, '/Object' : [ '/dir2', '/dir3' ], '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.close( 'defaultDstPath:false' )
  test.open( 'defaultDstPath:array' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ] }
  var got = path.mapSupplement( null, '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var got = path.mapSupplement( null, [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var got = path.mapSupplement( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ] }
  var got = path.mapSupplement( '/z', '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var got = path.mapSupplement( '/z', [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var got = path.mapSupplement( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : [ '/dir1', '/dir2' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapSupplement( dst, null, [ '/dir1', '/dir2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, only bools';
  var expected = { '/wasTrue' : true, '/wasFalse' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, null, [ '/dir1', '/dir2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [], '/EmptyArray2' : [], '/EmptyArray3' : [] };
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] };
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapSupplement( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapSupplement( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var got = path.mapSupplement( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : [ '/dir1', '/dir2' ], '/False' : [ '/dir1', '/dir2' ], '/Null' : [ '/dir1', '/dir2' ], '/String1' : [ '/dir1', '/dir2' ], '/String2' : [ '/dir1', '/dir2' ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : [ '/dir1', '/dir2' ], '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapSupplement( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : '/dir2', '/False' : '/dir2', '/One' : true, '/Zero' : false, '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2', '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapSupplement( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/One' : true, '/Zero' : false, '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ], '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] };
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapSupplement( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0,  '/String2' : obj0, '/Array' : obj0,'/Object' : obj0, '/One' : true, '/Zero' : false, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ] };
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.close( 'defaultDstPath:array' )
  test.open( 'defaultDstPath:obj' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : obj2 }
  var got = path.mapSupplement( null, '/a/b', obj2 );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : obj2, '/c/d' : obj2 }
  var got = path.mapSupplement( null, [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var got = path.mapSupplement( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : obj2, '/a/b' : obj2 }
  var got = path.mapSupplement( '/z', '/a/b', obj2 );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : obj2, '/a/b' : obj2, '/c/d' : obj2 }
  var got = path.mapSupplement( '/z', [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : obj2, '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var got = path.mapSupplement( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, '/a/b', obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2, '/c/d' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapSupplement( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapSupplement( dst, null, obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [], '/EmptyArray2' : [], '/EmptyArray3' : [] }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : obj2, '/EmptyArray2' : obj2, '/EmptyArray3' : obj2 }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : obj2, '/False' : obj2, '/Null' : obj2, '/String1' : obj2, '/String2' : obj2, '/Array' : obj2, '/Object' : obj2, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2', '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ], '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapSupplement( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is the same object';
  var exp = { '/True' : true, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0 }
  var dst = { '/True' : true, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj0 }
  var got = path.mapSupplement( dst, src, obj0 );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  test.close( 'defaultDstPath:obj' )

  /* - */

  test.open( 'throwing' )

  test.case = 'dstMap=null, srcMap=null, dstPath=map';
  var dstMap = null;
  var srcMap = null;
  var dstPath = { '/True' : true, '/False' : false, '/Zero' : 0, '/One' : 1, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  test.shouldThrowErrorSync( () => path.mapSupplement( dstMap, srcMap, dstPath ) );
  test.shouldThrowErrorSync( () => path.mapSupplement( {}, {}, {} ) );
  test.shouldThrowErrorSync( () => path.mapSupplement() );
  test.shouldThrowErrorSync( () => path.mapSupplement( dstMap, srcMap, dstPath, {} ) );

  test.close( 'throwing' )

}

//

function mapAppend( test )
{
  let path = _.path;
  function constr( src )
  {
    this.value = src;
    return this;
  }
  let obj0 = new constr( 0 );
  let obj1 = new constr( 1 );
  let obj2 = new constr( 2 );

  /* xxx */

  test.case = 'temp';
  var expected = { '/src' : '/dst' };
  var dstMap = { '/src' : '/dst' };
  var srcMap = null;
  var dstPath = '/dst2';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'temp';
  var expected = { '/src' : '/dst', '' : '/dst3' };
  var dstMap = { '/src' : '/dst' };
  var srcMap = { '' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* - */

  test.case = 'dstMap=null, srcMap=null, dstPath=undefined';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = undefined;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=undefined';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = undefined;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=undefined';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = undefined;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=undefined';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = undefined;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=null';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=null';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=null';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=null';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=empty';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = '';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=empty';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = '';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=empty';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = '';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=empty';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = '';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* */

  test.case = 'dstMap=map with only src dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '', 'a' : true, 'b' : false };
  var dstMap = { '.' : '' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with only dst dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '' : '.', 'a' : true, 'b' : false };
  var dstMap = { '' : '.' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with only src and dst dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '.', 'a' : true, 'b' : false };
  var dstMap = { '.' : '.' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=is dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '', 'a' : true, 'b' : false };
  var dstMap = '.';
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=is empty, srcMap=map with bools, dstPath=undefined';
  var expected = { 'a' : true, 'b' : false };
  var dstMap = '';
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* */

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { '/dir/**' : true, '/dir/doubledir/d1/**' : true, '/dir/**/**b**' : false, '/dir/doubledir/d1/**/**b**' : false };
  var dstMap = { '/dir/**' : true, '/dir/doubledir/d1/**' : true, '/dir/**/**b**' : false, '/dir/doubledir/d1/**/**b**' : false };
  var srcMap = [ '/dir/**', '/dir/doubledir/d1/**' ];
  var dstPath = '';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { '/' : '/dst' }
  var dstMap = null;
  var srcMap = { '/' : '' };
  var dstPath = '/dst';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { 'a' : '', 'b' : '' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapAppend( dstMap, srcMap );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=null';
  var expected = { 'a' : '', 'b' : '' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapAppend( dstMap, srcMap, null );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=str';
  var expected = { 'a' : 'c', 'b' : 'c' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapAppend( dstMap, srcMap, 'c' );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=str';
  var expected = {}
  var dstMap = null;
  var srcMap = null;
  var dstPath = '/dst';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null in arr, dstPath=str';
  var expected = {}
  var dstMap = null;
  var srcMap = [ null ];
  var dstPath = '/dst';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=map, dstPath=null';
  var expected = { '/src' : '/dst' }
  var dstMap = null;
  var srcMap = { '/src' : '/dst' };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=map, srcMap=str, dstPath=null';
  var expected = { '/src' : '/dst' }
  var dstMap = { '/src' : '/dst' };
  var srcMap = '/src';
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=str, dstPath=null';
  var expected = { '/src' : [ '/dst', '/dst2' ] };
  var dstMap = { '/src' : '/dst' };
  var srcMap = '/src';
  var dstPath = '/dst2';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  /* - */

  test.case = 'dstMap=map with dot in src, srcMap=map, dstPath=null';
  var expected = { '.' : '', 'x' : '', 'y' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '.' : null, 'x' : null, 'y' : '' };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with dot in src, srcMap=map, dstPath=null';
  var expected = { '.' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '.' : null };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty in src, srcMap=map, dstPath=null';
  var expected = { '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '' : null };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty in src and dst, srcMap=map, dstPath=null';
  var expected = { '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '' : '' };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=dot str, srcMap=map, dstPath=null';
  var expected = { '.' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = '.';
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* - */

  test.case = 'dstMap=map, srcMap=empty, dstPath=str';
  var expected = { '/src1' : '/dst', '/src2' : '/dst' };
  var dstMap = { '/src1' : null, '/src2' : '' };
  var srcMap = '';
  var dstPath = '/dst';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=str, dstPath=str, rewrite';
  var expected = { '/src1' : [ '/dst1', '/dst2'], '/src2' : '/dst1' };
  var dstMap = { '/src1' : [ '/dst1', '/dst2' ], '/src2' : '/dst1' };
  var srcMap = '/src1';
  var dstPath = '/dst2';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=src, dstPath=str, rewrite';
  var expected = { '/src1' : [ '/dst1', '/dst2'], '/src2' : '/dst1' };
  var dstMap = { '/src1' : [ '/dst1', '/dst2' ], '/src2' : '/dst1' };
  var srcMap = { '/src1' : [ '/dst1', '/dst2' ], '/src2' : '/dst1' };
  var dstPath = '/dst2';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=map, dstPath=str, rewrite';
  var expected = { '/src1' : [ '/dst1', '/dst2' ], '/src2' : [ '/dst1', '/dst3' ] };
  var dstMap = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var srcMap = { '/src1' : null, '/src2' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=map, dstPath=str, rewrite';
  var expected = { '/src1' : [ '/dst1', '/dst2' ], '/src2' : [ '/dst1', '/dst3' ] };
  var dstMap = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var srcMap = { '/src1' : null, '/src2' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=null, dstPath=str';
  var expected = { '/src1' : '/dst', '/src2' : '/dst' };
  var dstMap = { '/src1' : null, '/src2' : '' };
  var srcMap = null;
  var dstPath = '/dst';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=null, dstPath=str';
  var expected = { "" : "/dst2" };
  var dstMap = { "" : "/dst2" };
  var srcMap = null;
  var dstPath = '/dst2';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=null, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = null;
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=string, dstPath=null';
  var expected = { "/src" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '/src';
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=array, dstPath=null';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = [ '/src1', '/src2' ];
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty array, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = [];
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty map, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = {};
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty str, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty str, dstPath=empty str';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = '';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=not normal empty map, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { "" : "" };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map with only src, dstPath=null';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : null, '/src2' : null };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=null';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=not normal empty map, dstPath=empty str';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { "" : "" };
  var dstPath = '';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map with only src, dstPath=empty str';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : null, '/src2' : null };
  var dstPath = '';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=empty str';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=str';
  var expected = { '/null' : '/dstx', '/str' : '/dst2', '/empty1' : '/dstx', '/empty2' : '/dstx', '/empty2' : '/dstx', '/true' : true, '/false' : false, '' : '/dst' };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '/dstx';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=str, same as in dst map';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '/dst';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=null';
  var expected = { "" : "/dst", "/src1" : "/dst1", "/src2" : "/dst2" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : '/dst1', '/src2' : '/dst2' };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  // test.case = 'dstMap=map with empty src, srcMap=complex map, dstPath=null';
  // var expected = { "" : "/dst", '/True' : true, '/False' : false, '/Zero' : false, '/One' : true, '/Null' : '/dst', '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } };
  // var dstMap = { "" : "/dst" };
  // var srcMap = { '' : null, '/True' : true, '/False' : false, '/Zero' : 0, '/One' : 1, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  // var dstPath = null;
  // var got = path.mapAppend( dstMap, srcMap, dstPath );
  // test.identical( got, expected );

  test.case = 'dstMap=map with empty src, srcMap=string, dstPath=string';
  var expected = { '' : '/dst', '/src' : '/dst2' };
  var dstMap = { "" : "/dst" };
  var srcMap = '/src';
  var dstPath = '/dst2';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* - */

  test.open( 'src<>map, dst<>map' );

  test.case = 'src=str, dst=str, dstPath=null';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = '/b';
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=str, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = [ '/b' ];
  var dstPath = [ null ];
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=arr, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = [ '/a' ];
  var srcMap = [ '/b' ];
  var dstPath = [ null ];
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=str, dst=str, dstPath=null';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = '/b';
  var dstPath = '';
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=str, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = [ '/b' ];
  var dstPath = [ '' ];
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=arr, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = [ '/a' ];
  var srcMap = [ '/b' ];
  var dstPath = [ '' ];
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.close( 'src<>map, dst<>map' );

  /* - */

  test.open( 'defaultDstPath:true' );

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : true }
  var got = path.mapAppend( null, '/a/b', true );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : true, '/c/d' : true }
  var got = path.mapAppend( null, [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var got = path.mapAppend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : true, '/a/b' : true }
  var got = path.mapAppend( '/z', '/a/b', true );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : true, '/a/b' : true, '/c/d' : true }
  var got = path.mapAppend( '/z', [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : true, '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var got = path.mapAppend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'no dstPath' );

  test.case = 'no orphan';
  var expected = { '/One' : true, '/Str' : 'str', '/EmptyString1' : '', '/EmptyString2' : '', '/Null1' : '', '/Null2' : '' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null }
  var got = path.mapAppend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'dst has orphan';
  var expected = { '/One' : true, '/Str' : 'str', '/EmptyString1' : '/dst', '/EmptyString2' : '/dst', '/Null1' : '/dst', '/Null2' : '/dst' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null, '' : '/dst' }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null }
  var got = path.mapAppend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src has orphan';
  var expected = { '/One' : true, '/Str' : 'str', '/EmptyString1' : '/dst', '/EmptyString2' : '/dst', '/Null1' : '/dst', '/Null2' : '/dst' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null, '' : '/dst' }
  var got = path.mapAppend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'dst has orphan, no place for it';
  var expected = { '/One' : true, '' : '/dst' }
  var dst = { '/One' : 1, '' : '/dst' }
  var src = { '/One' : 0 }
  var got = path.mapAppend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src has orphan, no place for it';
  var expected = { '/One' : true, '' : '/dst' }
  var dst = { '/One' : 1, }
  var src = { '/One' : 0, '' : '/dst' }
  var got = path.mapAppend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'no dstPath' )

  test.close( 'defaultDstPath:true' );

  /* */

  test.open( 'src:null' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapAppend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, null, null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, null, '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapAppend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapAppend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapAppend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, null, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, null, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ]
  var got = path.mapAppend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:null' )

  /* */

  test.open( 'src:empty str' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapAppend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, '', null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, '', '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapAppend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapAppend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapAppend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, '', true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' :  [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, '', false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ]
  var got = path.mapAppend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty str' )

  /* */

  test.open( 'src:empty arr' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapAppend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, [ '', null, '' ], null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, [ '', null, '' ], '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapAppend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapAppend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapAppend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, [ '', null, '' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, [ '', null, '' ], false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ];
  var got = path.mapAppend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty arr' )

  /* */

  test.open( 'src:empty map' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapAppend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, { '' : '' }, null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, { '' : '' }, '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapAppend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapAppend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapAppend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, { '' : '' }, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, { '' : '' }, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ];
  var got = path.mapAppend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty map' )

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, '/a/b', true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true, '/c/d' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, [ '/wasTrue', '/wasFalse' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true, '/c/d' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, { '/a/b' : null, '/c/d' : null }, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [], '/EmptyArray2' : [], '/EmptyArray3' : [] }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 1, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : false, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/One' : true, '/Zero' : false, '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : [ '/dir2', '/dir1'], '/String2' : '/dir2', '/Array' : [ '/dir2', '/dir1'], '/Object' : [ '/dir2', obj1 ], '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3', '/dir1' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3', '/dir1'], '/Object' : [ 'dst1', 'dst2', obj1 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true, }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ 'dst1', 'dst2' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.open( 'defaultDstPath:false' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : false }
  var got = path.mapAppend( null, '/a/b', false );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : false, '/c/d' : false }
  var got = path.mapAppend( null, [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var got = path.mapAppend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : false, '/a/b' : false }
  var got = path.mapAppend( '/z', '/a/b', false );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : false, '/a/b' : false, '/c/d' : false }
  var got = path.mapAppend( '/z', [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : false, '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var got = path.mapAppend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, '/a/b', false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false, '/c/d' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapAppend( dst, null, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [], '/EmptyArray2' : [], '/EmptyArray3' : [] }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapAppend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false };
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : [ '/dir2', '/dir1' ], '/String2' : '/dir2', '/Array' : [ '/dir2', '/dir1' ], '/Object' : [ '/dir2', obj1 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3', '/dir1'], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3', '/dir1' ], '/One' : true, '/Zero' : false, '/Object' : [ '/dir2', '/dir3', obj1 ], '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : [ obj1, '/dir1' ], '/String2' : [ obj1, '/dir2' ], '/Array' : [ obj1, '/dir1', '/dir2' ], '/Object' : [ obj1, obj0 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.close( 'defaultDstPath:false' )
  test.open( 'defaultDstPath:array' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ] }
  var got = path.mapAppend( null, '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var got = path.mapAppend( null, [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var got = path.mapAppend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ] }
  var got = path.mapAppend( '/z', '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var got = path.mapAppend( '/z', [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var got = path.mapAppend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : [ '/dir1', '/dir2' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapAppend( dst, null, [ '/dir1', '/dir2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, only bools';
  var expected = { '/wasTrue' : true, '/wasFalse' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, null, [ '/dir1', '/dir2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] };
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapAppend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapAppend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var got = path.mapAppend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  // test.case = 'dst is null';
  // var exp = { '/True' : [ '/dir1', '/dir2' ], '/False' : [ '/dir1', '/dir2' ], '/Null' : [ '/dir1', '/dir2' ], '/String1' : [ '/dir1', '/dir2' ], '/String2' : [ '/dir1', '/dir2' ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : [ '/dir1', '/dir2', obj1 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ] };
  // var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  // var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  // var got = path.mapAppend( dst, src, [ '/dir1', '/dir2' ] );
  // test.identical( got, exp );
  // test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : '/dir2', '/False' : '/dir2', '/One' : true, '/Zero' : false, '/Null' : [ '/dir2', '/dir1' ], '/String1' : [ '/dir2', '/dir1' ], '/String2' : '/dir2', '/Array' : [ '/dir2', '/dir1' ], '/Object' : [ '/dir2', obj1 ], '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapAppend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/One' : true, '/Zero' : false, '/Null' : [ '/dir2', '/dir3', '/dir1' ], '/String1' :  [ '/dir2', '/dir3', '/dir1' ], '/String2' :  [ '/dir2', '/dir3' ], '/Array' :  [ '/dir2', '/dir3', '/dir1' ], '/Object' :  [ '/dir2', '/dir3', obj1 ], '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] };
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapAppend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : obj0, '/False' : obj0, '/Null' : [ obj0, '/dir1', '/dir2' ], '/String1' : [ obj0, '/dir1' ],  '/String2' : [ obj0, '/dir2' ], '/Array' : [ obj0, '/dir1', '/dir2' ],'/Object' : [ obj0, obj1 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ] };
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.close( 'defaultDstPath:array' )
  test.open( 'defaultDstPath:obj' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : obj2 }
  var got = path.mapAppend( null, '/a/b', obj2 );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : obj2, '/c/d' : obj2 }
  var got = path.mapAppend( null, [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var got = path.mapAppend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : obj2, '/a/b' : obj2 }
  var got = path.mapAppend( '/z', '/a/b', obj2 );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : obj2, '/a/b' : obj2, '/c/d' : obj2 }
  var got = path.mapAppend( '/z', [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : obj2, '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var got = path.mapAppend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, '/a/b', obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2, '/c/d' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapAppend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapAppend( dst, null, obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ obj2 ], '/EmptyArray2' : [ obj2 ], '/EmptyArray3' : [ obj2 ] }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ obj2 ], '/EmptyArray2' : [ obj2 ], '/EmptyArray3' : [ obj2 ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapAppend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : obj2, '/False' : obj2, '/Null' : obj2, '/String1' : [ obj2, '/dir1' ], '/String2' : [ obj2, '/dir2' ], '/Array' : [ obj2, '/dir1', '/dir2' ], '/Object' : [ obj2, obj1 ], '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : [ '/dir2', obj2 ], '/String1' : [ '/dir2', '/dir1' ], '/String2' : '/dir2', '/Array' : [ '/dir2', '/dir1' ], '/Object' : [ '/dir2', obj1 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3', obj1 ], '/String1' : [ '/dir2', '/dir3', '/dir1' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3', '/dir1' ], '/Object' : [ '/dir2', '/dir3', obj1 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : obj0, '/False' : obj0, '/Null' : [ obj0, obj1 ], '/String1' : [ obj0, '/dir1' ], '/String2' : [ obj0, '/dir2' ], '/Array' : [ obj0, '/dir1', '/dir2' ], '/Object' : [ obj0, obj1 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapAppend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is the same object';
  var exp = { '/True' : true, '/False' : obj0, '/Null' : obj0, '/String1' : [ obj0, '/dir1' ], '/String2' : [ obj0, '/dir2' ], '/Array' : [ obj0, '/dir1',   '/dir2' ], '/Object' : obj0 };
  var dst = { '/True' : true, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 };
  var src = { '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj0 };
  var got = path.mapAppend( dst, src, obj0 );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  test.close( 'defaultDstPath:obj' )

  /* - */

  test.open( 'throwing' )

  test.case = 'dstMap=null, srcMap=null, dstPath=map';
  var dstMap = null;
  var srcMap = null;
  var dstPath = { '/True' : true, '/False' : false, '/Zero' : 0, '/One' : 1, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  test.shouldThrowErrorSync( () => path.mapAppend( dstMap, srcMap, dstPath ) );
  test.shouldThrowErrorSync( () => path.mapAppend( {}, {}, {} ) );

  test.close( 'throwing' )

}

//

function mapAppendExperiment( test )
{
  let path = _.path;
  function constr( src )
  {
    this.value = src;
    return this;
  }
  let obj0 = new constr( 0 );

  //

  test.case = 'dstMap=map with empty src, srcMap=complex map, dstPath=null';
  var expected = { "" : "/dst", '/True' : '',  };
  var dstMap = { "" : "/dst" };
  var srcMap = { '' : null, '/True' : null };
  var dstPath = null;
  var got = path.mapAppend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  //

  test.case = 'object value replace all empty values';
  var exp = { '/Null' : [ '/dir1', '/dir2' ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : [ '/dir1', '/dir2', obj0 ] };
  var dst = { '/Null' : null, '/Array' : null, '/Object' : null }
  var src = { '/Null' : '/dir1', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj0 };
  var got = path.mapAppend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );
}
mapAppendExperiment.experimental = 1;

//

function mapPrepend( test )
{
  let path = _.path;
  function constr( src )
  {
    this.value = src;
    return this;
  }
  let obj0 = new constr( 0 );
  let obj1 = new constr( 1 );
  let obj2 = new constr( 2 );

  /* xxx */

  test.case = 'temp';
  var expected = { '/src' : '/dst' };
  var dstMap = { '/src' : '/dst' };
  var srcMap = null;
  var dstPath = '/dst2';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'temp';
  var expected = { '/src' : '/dst', '' : '/dst3' };
  var dstMap = { '/src' : '/dst' };
  var srcMap = { '' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* - */

  test.case = 'dstMap=null, srcMap=null, dstPath=undefined';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = undefined;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=undefined';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = undefined;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=undefined';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = undefined;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=undefined';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = undefined;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=null';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=null';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=null';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=null';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=empty';
  var expected = {};
  var dstMap = null;
  var srcMap = null;
  var dstPath = '';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=null, dstPath=empty';
  var expected = {};
  var dstMap = '';
  var srcMap = null;
  var dstPath = '';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=empty, dstPath=empty';
  var expected = {};
  var dstMap = null;
  var srcMap = '';
  var dstPath = '';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=empty, srcMap=empty, dstPath=empty';
  var expected = {};
  var dstMap = '';
  var srcMap = '';
  var dstPath = '';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* */

  test.case = 'dstMap=map with only src dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '', 'a' : true, 'b' : false };
  var dstMap = { '.' : '' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with only dst dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '' : '.', 'a' : true, 'b' : false };
  var dstMap = { '' : '.' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with only src and dst dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '.', 'a' : true, 'b' : false };
  var dstMap = { '.' : '.' };
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=is dot, srcMap=map with bools, dstPath=undefined';
  var expected = { '.' : '', 'a' : true, 'b' : false };
  var dstMap = '.';
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=is empty, srcMap=map with bools, dstPath=undefined';
  var expected = { 'a' : true, 'b' : false };
  var dstMap = '';
  var srcMap = { 'a' : true, 'b' : false };
  var dstPath = undefined;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* */

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { '/dir/**' : true, '/dir/doubledir/d1/**' : true, '/dir/**/**b**' : false, '/dir/doubledir/d1/**/**b**' : false };
  var dstMap = { '/dir/**' : true, '/dir/doubledir/d1/**' : true, '/dir/**/**b**' : false, '/dir/doubledir/d1/**/**b**' : false };
  var srcMap = [ '/dir/**', '/dir/doubledir/d1/**' ];
  var dstPath = '';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { '/' : '/dst' }
  var dstMap = null;
  var srcMap = { '/' : '' };
  var dstPath = '/dst';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=undefined';
  var expected = { 'a' : '', 'b' : '' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapPrepend( dstMap, srcMap );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=null';
  var expected = { 'a' : '', 'b' : '' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapPrepend( dstMap, srcMap, null );
  test.identical( got, expected );

  test.case = 'dstMap=str, srcMap=str, dstPath=str';
  var expected = { 'a' : 'c', 'b' : 'c' }
  var dstMap = 'a';
  var srcMap = 'b';
  var got = path.mapPrepend( dstMap, srcMap, 'c' );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null, dstPath=str';
  var expected = {}
  var dstMap = null;
  var srcMap = null;
  var dstPath = '/dst';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=null in arr, dstPath=str';
  var expected = {}
  var dstMap = null;
  var srcMap = [ null ];
  var dstPath = '/dst';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=null, srcMap=map, dstPath=null';
  var expected = { '/src' : '/dst' }
  var dstMap = null;
  var srcMap = { '/src' : '/dst' };
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'dstMap=map, srcMap=str, dstPath=null';
  var expected = { '/src' : '/dst' }
  var dstMap = { '/src' : '/dst' };
  var srcMap = '/src';
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=str, dstPath=null';
  var expected = { '/src' : [ '/dst2', '/dst' ] };
  var dstMap = { '/src' : '/dst' };
  var srcMap = '/src';
  var dstPath = '/dst2';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  /* - */

  test.case = 'dstMap=map with dot in src, srcMap=map, dstPath=null';
  var expected = { '.' : '', 'x' : '', 'y' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '.' : null, 'x' : null, 'y' : '' };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with dot in src, srcMap=map, dstPath=null';
  var expected = { '.' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '.' : null };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty in src, srcMap=map, dstPath=null';
  var expected = { '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '' : null };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty in src and dst, srcMap=map, dstPath=null';
  var expected = { '/a/b1' : '', '/a/b2' : '' };
  var dstMap = { '' : '' };
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=dot str, srcMap=map, dstPath=null';
  var expected = { '.' : '', '/a/b1' : '', '/a/b2' : '' };
  var dstMap = '.';
  var srcMap = { '/a/b1' : null, '/a/b2' : null };
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* - */

  test.case = 'dstMap=map, srcMap=empty, dstPath=str';
  var expected = { '/src1' : '/dst', '/src2' : '/dst' };
  var dstMap = { '/src1' : null, '/src2' : '' };
  var srcMap = '';
  var dstPath = '/dst';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=str, dstPath=str, rewrite';
  var expected = { '/src1' : [ '/dst1', '/dst2'], '/src2' : '/dst1' };
  var dstMap = { '/src1' : [ '/dst1', '/dst2' ], '/src2' : '/dst1' };
  var srcMap = '/src1';
  var dstPath = '/dst2';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=src, dstPath=str, rewrite';
  var expected = { '/src1' : [ '/dst1', '/dst2'], '/src2' : '/dst1' };
  var dstMap = { '/src1' : [ '/dst1', '/dst2' ], '/src2' : '/dst1' };
  var srcMap = { '/src1' : [ '/dst1', '/dst2' ], '/src2' : '/dst1' };
  var dstPath = '/dst2';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=map, dstPath=str, rewrite';
  var expected = { '/src1' : [ '/dst2', '/dst1' ], '/src2' : [ '/dst3', '/dst1' ] };
  var dstMap = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var srcMap = { '/src1' : null, '/src2' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=map, dstPath=str, rewrite';
  var expected = { '/src1' : [ '/dst2', '/dst1' ], '/src2' : [ '/dst3', '/dst1' ] };
  var dstMap = { '/src1' : '/dst1', '/src2' : '/dst1' };
  var srcMap = { '/src1' : null, '/src2' : '/dst3' };
  var dstPath = '/dst2';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map, srcMap=null, dstPath=str';
  var expected = { '/src1' : '/dst', '/src2' : '/dst' };
  var dstMap = { '/src1' : null, '/src2' : '' };
  var srcMap = null;
  var dstPath = '/dst';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=null, dstPath=str';
  var expected = { "" : "/dst2" };
  var dstMap = { "" : "/dst2" };
  var srcMap = null;
  var dstPath = '/dst2';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=null, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = null;
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=string, dstPath=null';
  var expected = { "/src" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '/src';
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=array, dstPath=null';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = [ '/src1', '/src2' ];
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty array, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = [];
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty map, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = {};
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty str, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=empty str, dstPath=empty str';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = '';
  var dstPath = '';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=not normal empty map, dstPath=null';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { "" : "" };
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map with only src, dstPath=null';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : null, '/src2' : null };
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=null';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=not normal empty map, dstPath=empty str';
  var expected = { "" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { "" : "" };
  var dstPath = '';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map with only src, dstPath=empty str';
  var expected = { "/src1" : "/dst", "/src2" : "/dst" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : null, '/src2' : null };
  var dstPath = '';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=empty str';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=str';
  var expected = { '/null' : '/dstx', '/str' : '/dst2', '/empty1' : '/dstx', '/empty2' : '/dstx', '/empty2' : '/dstx', '/true' : true, '/false' : false, '' : '/dst' };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '/dstx';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=str, same as in dst map';
  var expected = { '/null' : '/dst', '/str' : '/dst2', '/empty1' : '/dst', '/empty2' : '/dst', '/empty2' : '/dst', '/true' : true, '/false' : false };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/null' : null, '/str' : '/dst2', '/empty1' : '', '/empty2' : [], '/empty2' : [ '' ], '/true' : true, '/false' : false };
  var dstPath = '/dst';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  test.case = 'dstMap=map with empty src, srcMap=map, dstPath=null';
  var expected = { "" : "/dst", "/src1" : "/dst1", "/src2" : "/dst2" };
  var dstMap = { "" : "/dst" };
  var srcMap = { '/src1' : '/dst1', '/src2' : '/dst2' };
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );
  test.is( got === dstMap );

  // test.case = 'dstMap=map with empty src, srcMap=complex map, dstPath=null';
  // var expected = { "" : "/dst", '/True' : true, '/False' : false, '/Zero' : false, '/One' : true, '/Null' : '/dst', '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } };
  // var dstMap = { "" : "/dst" };
  // var srcMap = { '' : null, '/True' : true, '/False' : false, '/Zero' : 0, '/One' : 1, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  // var dstPath = null;
  // var got = path.mapPrepend( dstMap, srcMap, dstPath );
  // test.identical( got, expected );

  test.case = 'dstMap=map with empty src, srcMap=string, dstPath=string';
  var expected = { '' : '/dst', '/src' : '/dst2' };
  var dstMap = { "" : "/dst" };
  var srcMap = '/src';
  var dstPath = '/dst2';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  /* - */

  test.open( 'src<>map, dst<>map' );

  test.case = 'src=str, dst=str, dstPath=null';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = '/b';
  var dstPath = null;
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=str, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = [ '/b' ];
  var dstPath = [ null ];
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=arr, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = [ '/a' ];
  var srcMap = [ '/b' ];
  var dstPath = [ null ];
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=str, dst=str, dstPath=null';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = '/b';
  var dstPath = '';
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=str, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = '/a';
  var srcMap = [ '/b' ];
  var dstPath = [ '' ];
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.case = 'src=arr, dst=arr, dstPath=arr';
  var expected = { '/a' : '', '/b' : '' }
  var dstMap = [ '/a' ];
  var srcMap = [ '/b' ];
  var dstPath = [ '' ];
  var got = path.mapPrepend( dstMap, srcMap, dstPath );
  test.identical( got, expected );

  test.close( 'src<>map, dst<>map' );

  /* - */

  test.open( 'defaultDstPath:true' );

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : true }
  var got = path.mapPrepend( null, '/a/b', true );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : true, '/c/d' : true }
  var got = path.mapPrepend( null, [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var got = path.mapPrepend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : true, '/a/b' : true }
  var got = path.mapPrepend( '/z', '/a/b', true );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : true, '/a/b' : true, '/c/d' : true }
  var got = path.mapPrepend( '/z', [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : true, '/a/b' : true, '/c/d' : true, '/true' : true, '/false' : false }
  var got = path.mapPrepend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, true );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'no dstPath' );

  test.case = 'no orphan';
  var expected = { '/One' : true, '/Str' : 'str', '/EmptyString1' : '', '/EmptyString2' : '', '/Null1' : '', '/Null2' : '' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null }
  var got = path.mapPrepend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'dst has orphan';
  var expected = { '/One' : true, '/Str' : 'str', '/EmptyString1' : '/dst', '/EmptyString2' : '/dst', '/Null1' : '/dst', '/Null2' : '/dst' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null, '' : '/dst' }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null }
  var got = path.mapPrepend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src has orphan';
  var expected = { '/One' : true, '/Str' : 'str', '/EmptyString1' : '/dst', '/EmptyString2' : '/dst', '/Null1' : '/dst', '/Null2' : '/dst' }
  var dst = { '/One' : 1, '/EmptyString1' : '', '/Null1' : null }
  var src = { '/One' : 0, '/Str' : 'str', '/EmptyString2' : '', '/Null2' : null, '' : '/dst' }
  var got = path.mapPrepend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'dst has orphan, no place for it';
  var expected = { '/One' : true, '' : '/dst' }
  var dst = { '/One' : 1, '' : '/dst' }
  var src = { '/One' : 0 }
  var got = path.mapPrepend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src has orphan, no place for it';
  var expected = { '/One' : true, '' : '/dst' }
  var dst = { '/One' : 1, }
  var src = { '/One' : 0, '' : '/dst' }
  var got = path.mapPrepend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'no dstPath' )

  test.close( 'defaultDstPath:true' );

  /* */

  test.open( 'src:null' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapPrepend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, null, null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, null, '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapPrepend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapPrepend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapPrepend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, null, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, null, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ]
  var got = path.mapPrepend( dst, null, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:null' )

  /* */

  test.open( 'src:empty str' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapPrepend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, '', null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, '', '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapPrepend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapPrepend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : '', '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapPrepend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, '', true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' :  [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, '', false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Object' : { 'value' : 1 } }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ]
  var got = path.mapPrepend( dst, '', dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty str' )

  /* */

  test.open( 'src:empty arr' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapPrepend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, [ '', null, '' ], null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, [ '', null, '' ], '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapPrepend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapPrepend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapPrepend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, [ '', null, '' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, [ '', null, '' ], false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ];
  var got = path.mapPrepend( dst, [ '', null, '' ], dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty arr' )

  /* */

  test.open( 'src:empty map' )

  test.case = 'src:null, dstPath:str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '/dstx', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = '/dstx'
  var got = path.mapPrepend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:null';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, { '' : '' }, null );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty str';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, { '' : '' }, '' );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 1';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [];
  var got = path.mapPrepend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '', '' ];
  var got = path.mapPrepend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:empty array 2';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : '', '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ null, null ];
  var got = path.mapPrepend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:true';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, { '' : '' }, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:false';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, { '' : '' }, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, dstPath:array';
  var expected = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : false, '/Null' : [ '/a', '/b' ], '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dst = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var dstPath = [ '/a', '/b' ];
  var got = path.mapPrepend( dst, { '' : '' }, dstPath );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'src:empty map' )

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, '/a/b', true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true, '/c/d' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, [ '/a/b', '/c/d' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, [ '/wasTrue', '/wasFalse' ], true );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : true, '/c/d' : true }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, { '/a/b' : null, '/c/d' : null }, true );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [], '/EmptyArray2' : [], '/EmptyArray3' : [] }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 1, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : false, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/One' : true, '/Zero' : false, '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : [ '/dir1', '/dir2' ], '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : [ obj1, '/dir2' ], '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true }
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir1', '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir1', '/dir2', '/dir3' ], '/Object' : [ obj1, 'dst1', 'dst2' ], '/One' : true, '/Zero' : false, '/EmptyArray1' : true, '/EmptyArray2' : true, '/EmptyArray3' : true, }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ 'dst1', 'dst2' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, true );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.open( 'defaultDstPath:false' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : false }
  var got = path.mapPrepend( null, '/a/b', false );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : false, '/c/d' : false }
  var got = path.mapPrepend( null, [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var got = path.mapPrepend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : false, '/a/b' : false }
  var got = path.mapPrepend( '/z', '/a/b', false );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : false, '/a/b' : false, '/c/d' : false }
  var got = path.mapPrepend( '/z', [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : false, '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var got = path.mapPrepend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, '/a/b', false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false, '/c/d' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, [ '/a/b', '/c/d' ], false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : false, '/c/d' : false, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapPrepend( dst, null, false );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [], '/EmptyArray2' : [], '/EmptyArray3' : [] }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : true, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapPrepend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : { 'value' : 1 }, '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false };
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : false, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : [ '/dir1', '/dir2' ], '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : [ obj1, '/dir2' ], '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir1', '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir1', '/dir2', '/dir3' ], '/One' : true, '/Zero' : false, '/Object' : [ obj1, '/dir2', '/dir3' ], '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : [ '/dir1', obj1 ], '/String2' : [ '/dir2', obj1 ], '/Array' : [ '/dir1', '/dir2', obj1 ], '/Object' : [ obj0, obj1 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : false, '/EmptyArray2' : false, '/EmptyArray3' : false, }
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, false );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.close( 'defaultDstPath:false' )
  test.open( 'defaultDstPath:array' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ] }
  var got = path.mapPrepend( null, '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var got = path.mapPrepend( null, [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var got = path.mapPrepend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ] }
  var got = path.mapPrepend( '/z', '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var got = path.mapPrepend( '/z', [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : [ '/dir2', '/dir3' ], '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var got = path.mapPrepend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, '/a/b', [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, [ '/a/b', '/c/d' ], [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : [ '/dir2', '/dir3' ], '/c/d' : [ '/dir2', '/dir3' ], '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, [ '/dir2', '/dir3' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : [ '/dir1', '/dir2' ] }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapPrepend( dst, null, [ '/dir1', '/dir2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null, only bools';
  var expected = { '/wasTrue' : true, '/wasFalse' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, null, [ '/dir1', '/dir2' ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ '' ], '/EmptyArray2' : [], '/EmptyArray3' : [ null ] };
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapPrepend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapPrepend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], }
  var got = path.mapPrepend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  // test.case = 'dst is null';
  // var exp = { '/True' : [ '/dir1', '/dir2' ], '/False' : [ '/dir1', '/dir2' ], '/Null' : [ '/dir1', '/dir2' ], '/String1' : [ '/dir1', '/dir2' ], '/String2' : [ '/dir1', '/dir2' ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : [ '/dir1', '/dir2', obj1 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ] };
  // var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  // var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  // var got = path.mapPrepend( dst, src, [ '/dir1', '/dir2' ] );
  // test.identical( got, exp );
  // test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : '/dir2', '/False' : '/dir2', '/One' : true, '/Zero' : false, '/Null' : [ '/dir1', '/dir2' ], '/String1' : [ '/dir1', '/dir2' ], '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : [ obj1, '/dir2' ], '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapPrepend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/One' : true, '/Zero' : false, '/Null' : [ '/dir1', '/dir2', '/dir3' ], '/String1' :  [ '/dir1', '/dir2', '/dir3' ], '/String2' :  [ '/dir2', '/dir3' ], '/Array' :  [ '/dir1', '/dir2', '/dir3' ], '/Object' :  [ obj1, '/dir2', '/dir3' ], '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ], };
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] };
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapPrepend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : obj0, '/False' : obj0, '/Null' : [ '/dir1', '/dir2', obj0 ], '/String1' : [ '/dir1', obj0 ],  '/String2' : [ '/dir2', obj0 ], '/Array' : [ '/dir1', '/dir2', obj0 ],'/Object' : [ obj1, obj0, ], '/One' : true, '/Zero' : false, '/EmptyArray1' : [ '/dir1', '/dir2' ], '/EmptyArray2' : [ '/dir1', '/dir2' ], '/EmptyArray3' : [ '/dir1', '/dir2' ] };
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, [ '/dir1', '/dir2' ] );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  /* - */

  test.close( 'defaultDstPath:array' )
  test.open( 'defaultDstPath:obj' )

  /* - */

  test.open( 'dst:null' );

  test.case = 'src:string';
  var expected = { '/a/b' : obj2 }
  var got = path.mapPrepend( null, '/a/b', obj2 );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/a/b' : obj2, '/c/d' : obj2 }
  var got = path.mapPrepend( null, [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var got = path.mapPrepend( null, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );

  test.close( 'dst:null' );

  /* */

  test.open( 'dst:string' );

  test.case = 'src:string';
  var expected = { '/z' : obj2, '/a/b' : obj2 }
  var got = path.mapPrepend( '/z', '/a/b', obj2 );
  test.identical( got, expected );

  test.case = 'src:array';
  var expected = { '/z' : obj2, '/a/b' : obj2, '/c/d' : obj2 }
  var got = path.mapPrepend( '/z', [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );

  test.case = 'src:map with null';
  var expected = { '/z' : obj2, '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var got = path.mapPrepend( '/z', { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );

  test.close( 'dst:string' );

  /* */

  test.open( 'dst:map' );

  test.case = 'src:string';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, '/a/b', obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:array';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2, '/c/d' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, [ '/a/b', '/c/d' ], obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:map with null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/a/b' : obj2, '/c/d' : obj2, '/true' : true, '/false' : false }
  var dst = { '/wasTrue' : true, '/wasFalse' : false }
  var got = path.mapPrepend( dst, { '/a/b' : null, '/c/d' : null, '/true' : true, '/false' : false }, obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'src:null';
  var expected = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : obj2 }
  var dst = { '/wasTrue' : true, '/wasFalse' : false, '/wasNull' : null }
  var got = path.mapPrepend( dst, null, obj2 );
  test.identical( got, expected );
  test.is( got === dst );

  test.close( 'dst:map' );

  /* */

  test.open( 'dst:map, collision' );

  test.case = 'dst is true';
  var exp = { '/One' : false, '/Zero' : true, '/True' : true, '/False' : true, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : [ obj2 ], '/EmptyArray2' : [ obj2 ], '/EmptyArray3' : [ obj2 ] }
  var dst = { '/One' : 0, '/Zero' : 1, '/True' : true, '/False' : true, '/Null' : true, '/String1' : true, '/String2' : true, '/Array' : true, '/Object' : true, '/EmptyArray1' : [ obj2 ], '/EmptyArray2' : [ obj2 ], '/EmptyArray3' : [ obj2 ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  var got = path.mapPrepend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is false';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : false, '/False' : false, '/Null' : false, '/String1' : false, '/String2' : false, '/Array' : false, '/Object' : false }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 1';
  var exp = { '/One' : true, '/Zero' : false, '/True' : true, '/False' : true, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : 1, '/False' : 1, '/Null' : 1, '/String1' : 1, '/String2' : 1, '/Array' : 1, '/Object' : 1 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is 0';
  var exp = { '/One' : true, '/Zero' : false, '/True' : false, '/False' : false, '/Null' : obj2, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : 0, '/False' : 0, '/Null' : 0, '/String1' : 0, '/String2' : 0, '/Array' : 0, '/Object' : 0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is null';
  var exp = { '/One' : true, '/Zero' : false, '/True' : obj2, '/False' : obj2, '/Null' : obj2, '/String1' : [ '/dir1', obj2 ], '/String2' : [ '/dir2', obj2 ], '/Array' : [ '/dir1', '/dir2', obj2 ], '/Object' : [ obj1, obj2 ], '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : null, '/False' : null, '/Null' : null, '/String1' : null, '/String2' : null, '/Array' : null, '/Object' : null }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is string';
  var exp = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : [ obj2, '/dir2' ], '/String1' : [ '/dir1', '/dir2' ], '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : [ obj1, '/dir2' ], '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } };
  var dst = { '/True' : '/dir2', '/False' : '/dir2', '/Null' : '/dir2', '/String1' : '/dir2', '/String2' : '/dir2', '/Array' : '/dir2', '/Object' : '/dir2' }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is array';
  var exp = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ obj1, '/dir2', '/dir3' ], '/String1' : [ '/dir1', '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir1', '/dir2', '/dir3' ], '/Object' : [ obj1, '/dir2', '/dir3' ], '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : [ '/dir2', '/dir3' ], '/False' : [ '/dir2', '/dir3' ], '/Null' : [ '/dir2', '/dir3' ], '/String1' : [ '/dir2', '/dir3' ], '/String2' : [ '/dir2', '/dir3' ], '/Array' : [ '/dir2', '/dir3' ], '/Object' : [ '/dir2', '/dir3' ] }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is object';
  var exp = { '/True' : obj0, '/False' : obj0, '/Null' : [ obj0, obj1 ], '/String1' : [ '/dir1', obj0 ], '/String2' : [ '/dir2', obj0 ], '/Array' : [ '/dir1', '/dir2', obj0 ], '/Object' : [ obj1, obj0 ], '/One' : true, '/Zero' : false, '/EmptyArray1' : { 'value' : 2 }, '/EmptyArray2' : { 'value' : 2 }, '/EmptyArray3' : { 'value' : 2 } }
  var dst = { '/True' : obj0, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 }
  var src = { '/One' : 1, '/Zero' : 0, '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/EmptyArray1' : [], '/EmptyArray2' : [ '', '' ], '/EmptyArray3' : [ null, null ], '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 }
  var got = path.mapPrepend( dst, src, obj2 );
  test.identical( got, exp );
  test.is( got === dst );

  test.case = 'dst is the same object';
  var exp = { '/True' : true, '/False' : obj0, '/Null' : obj0, '/String1' : [ '/dir1', obj0 ], '/String2' : [ '/dir2', obj0 ], '/Array' : [ '/dir1',   '/dir2', obj0 ], '/Object' : obj0 };
  var dst = { '/True' : true, '/False' : obj0, '/Null' : obj0, '/String1' : obj0, '/String2' : obj0, '/Array' : obj0, '/Object' : obj0, '/Object' : obj0 };
  var src = { '/True' : true, '/False' : false, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj0 };
  var got = path.mapPrepend( dst, src, obj0 );
  test.identical( got, exp );
  test.is( got === dst );

  test.close( 'dst:map, collision' );

  test.close( 'defaultDstPath:obj' )

  /* - */

  test.open( 'throwing' )

  test.case = 'dstMap=null, srcMap=null, dstPath=map';
  var dstMap = null;
  var srcMap = null;
  var dstPath = { '/True' : true, '/False' : false, '/Zero' : 0, '/One' : 1, '/Null' : null, '/String1' : '/dir1', '/String2' : '/dir2', '/Array' : [ '/dir1', '/dir2' ], '/Object' : obj1 };
  test.shouldThrowErrorSync( () => path.mapPrepend( dstMap, srcMap, dstPath ) );
  test.shouldThrowErrorSync( () => path.mapPrepend( {}, {}, {} ) );

  test.close( 'throwing' )

}

//

function mapsPair( test )
{
  let path = _.path;

  test.case = 'dst=map with src=string, dst=string and src=string';
  var exp = { '/src' : '/dst' }
  var dst = { '/src' : '/dst' }
  var src = "/src";
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'dst=null, src=null';
  var exp = null;
  var dst = null;
  var src = null;
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );

  test.case = 'src=null, dst=dot to null';
  var exp = null;
  var dst = { '.' : null };
  var src = null;
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );

  test.case = 'dst=null, src=dot to null';
  var exp = null;
  var dst = null;
  var src = { '.' : null };
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );

  test.case = 'src=null, dst=empty to null';
  var exp = null;
  var dst = { '' : null };
  var src = null;
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );

  test.case = 'dst=null, src=empty to null';
  var exp = null;
  var dst = null;
  var src = { '' : null };
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );

  test.case = 'src=null, dst=empty to empty';
  var exp = null;
  var dst = { '' : '' };
  var src = null;
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );

  test.case = 'dst=null, src=empty to empty';
  var exp = null;
  var dst = null;
  var src = { '' : '' };
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );

  test.case = 'dst=str, src=null';
  var exp = { '' : 'dir' };
  var dst = 'dir';
  var src = null;
  debugger;
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );
  test.is( got !== dst );
  test.is( got !== src );
  debugger;

  test.case = 'dst=null, src=str';
  var exp = { 'dir' : '' };
  var dst = null;
  var src = 'dir';
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'dst=str, src=map with some str and null in dst';
  var exp = { 'c' : 'c2', 'd' : 'dir' };
  var dst = 'dir';
  var src = { 'c' : 'c2', 'd' : null };
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'dst=str, src=dot to null';
  var exp = { '.' : '/a/dst/file' }
  var dst = '/a/dst/file';
  var src = { '.' : null }
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'dst=dot, src=map';
  var exp = { 'c' : 'c2', 'd' : '.' }
  var dst = '.';
  var src = { 'c' : 'c2', 'd' : null }
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'dst=map with src=dot and dst=null, dst=map with src=dot and dst=null';
  var exp = { '.' : '' }
  var dst = { '.' : null }
  var src = { '.' : null }
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'dst=map with src=dot and dst=null, dst=map with src=dot and dst=null';
  var exp = { '/src' : '/dst' }
  var dst = { '/src' : '/dst' }
  var src = '/src'
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'dst=map with src=string, dst=empty and dst=string';
  var exp = { '/src' : '/dst' }
  var dst = { "" : "/dst" }
  var src = "/src";
  var got = path.mapsPair( dst, src );
  test.identical( got, exp );
  test.is( got !== dst );
  test.is( got !== src );

}

//

function simplify( test )
{
  /* simple tests, not a string, not an array, not a map */

  test.case = 'number';
  var got = _.path.simplify( 2 );
  test.identical( got, true );

  test.case = 'undefined';
  var got = _.path.simplify( undefined );
  test.identical( got, undefined );

  test.case = 'boolLike';
  var got = _.path.simplify( true );
  test.identical( got, true );

  test.case = 'instance of constructor';
  var constr = function( val )
  {
    this.value = val;
    return this;
  }
  var obj = new constr( '/dir' );
  var got = _.path.simplify( obj );
  test.identical( got, obj );
  test.is( got === obj );

  /* simple tests with null and strings */

  test.case = 'null';
  var got = _.path.simplify( null );
  test.identical( got, '' );

  test.case = 'string';
  var got = _.path.simplify( '' );
  test.identical( got, '' );

  var got = _.path.simplify( '/string' );
  test.identical( got, '/string' );

  /* tests with arrays of paths */

  test.case = 'empty array';
  var got = _.path.simplify( [] );
  test.identical( got, '' );

  test.case = 'array has one path';
  var src = [ '/dir1' ];
  var got = _.path.simplify( src );
  test.identical( got, '/dir1' );

  test.case = 'simple array of paths';
  var src = [ '/dir1', '/dir2', '/dir3' ];
  var got = _.path.simplify( src );
  var expected = [ '/dir1', '/dir2', '/dir3' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'array has duplicates';
  var src = [ '/dir1', '/dir2', '/dir3', '/dir2' ];
  var got = _.path.simplify( src );
  var expected = [ '/dir1', '/dir2', '/dir3' ];
  test.identical( got, expected );

  var src = [ '/dir1', '/dir2', '/dir3', '/dir2', '/dir3', '/dir2' ];
  var got = _.path.simplify( src );
  var expected = [ '/dir1', '/dir2', '/dir3' ];
  test.identical( got, expected );

  test.case = 'array has empty strings and null';
  var src = [ '/dir1', '', '/dir2', '', '/dir3', null, '', '/path' ];
  var got = _.path.simplify( src );
  var expected = [ '/dir1', '/dir2', '/dir3', '/path' ];
  test.identical( got, expected );

  test.case = 'array has empty strings and nulls, one argument in result';
  var src = [ '/dir1', '', null, '', null, '' ];
  var got = _.path.simplify( src );
  var expected = '/dir1';
  test.identical( got, expected );

  test.case = 'array with empty strings and nulls';
  var src = [ '', '', null, null, '' ];
  var got = _.path.simplify( src );
  var expected = '';
  test.identical( got, expected );

  /* tests with map of paths */

  test.case = 'empty map';
  var got = _.path.simplify( {} );
  test.identical( got, '' );

  test.case = 'key is empty string, value is empty string';
  var got = _.path.simplify( { '' : '' } );
  test.identical( got, '' );

  test.case = 'key is empty string';
  var src = { '' : '/dir' };
  var got = _.path.simplify( src );
  test.identical( got, { '' : '/dir' } );
  test.is( got === src );

  test.case = 'key, value is empty string';
  var got = _.path.simplify( { '/dir1' : '' } );
  test.identical( got, '/dir1' );

  var src = { '/dir1' : '', '' : '' };
  var got = _.path.simplify( src );
  test.identical( got, { '/dir1' : '' } );
  test.notIdentical( got, '/dir1' );
  test.is( got === src );

  test.case = 'key, value is array';
  var src = { '/dir1' : [ '/dir1', '/dir2' ], '/dir2' : '/a/b' };
  var got = _.path.simplify( src );
  test.identical( got, { '/dir1' : [ '/dir1', '/dir2' ], '/dir2' : '/a/b' } );
  test.is( got === src );

  var src = { '/dir1' : [ '/dir1', null, '', '/dir2', '' ], '/dir2' : '/a/b' };
  var got = _.path.simplify( src );
  test.identical( got, { '/dir1' : [ '/dir1', '/dir2' ], '/dir2' : '/a/b' } );
  test.is( got === src );

  test.case = 'complex map of paths';
  var constr = function( val )
  {
    this.value = val;
    return this;
  }
  var obj = new constr( '/dir' );
  var src =
  {
    '/false' : false, '/true' : true, '/undefined' : undefined,
    '/null' : null,
    '/string' : '/dir', '/emptyString' : '', '' : '',
    '/number' : 10,
    '/array' : [ '', '/', '/dir' ], '/emptyArray' : [],
    '/emptyMap' : {}, '/map' : { '/str' : '/dir2' },
    '/instance' : obj,
  };
  var got = _.path.simplify( src );
  test.identical( got, src );
  test.is( got === src );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.path.simplify() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.path.simplify( '', '' ) );
}

//

function simplifyInplace( test )
{
  /* simple tests, not a string, not an array, not a map */

  test.case = 'number';
  var got = _.path.simplifyInplace( 2 );
  test.identical( got, true );

  test.case = 'undefined';
  var got = _.path.simplifyInplace( undefined );
  test.identical( got, undefined );

  test.case = 'boolLike';
  var got = _.path.simplifyInplace( true );
  test.identical( got, true );

  test.case = 'instance of constructor';
  var constr = function( val )
  {
    this.value = val;
    return this;
  }
  var obj = new constr( '/dir' );
  var got = _.path.simplifyInplace( obj );
  test.identical( got, obj );
  test.is( got === obj );

  /* simple tests with null and strings */

  test.case = 'null';
  var got = _.path.simplifyInplace( null );
  test.identical( got, '' );

  test.case = 'string';
  var got = _.path.simplifyInplace( '' );
  test.identical( got, '' );

  var got = _.path.simplifyInplace( '/string' );
  test.identical( got, '/string' );

  /* tests with arrays of paths */

  test.case = 'empty array';
  var src = [];
  var got = _.path.simplifyInplace( src );
  test.identical( got, [] );
  test.is( got === src );

  test.case = 'array has one path';
  var src = [ '/dir1' ];
  var got = _.path.simplifyInplace( src );
  test.identical( got, [ '/dir1' ] );
  test.is( got === src );

  test.case = 'simple array of paths';
  var src = [ '/dir1', '/dir2', '/dir3' ];
  var got = _.path.simplifyInplace( src );
  var expected = [ '/dir1', '/dir2', '/dir3' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'array has duplicates';
  var src = [ '/dir1', '/dir2', '/dir3', '/dir2' ];
  var got = _.path.simplifyInplace( src );
  var expected = [ '/dir1', '/dir2', '/dir3' ];
  test.identical( got, expected );
  test.is( got === src );

  var src = [ '/dir1', '/dir2', '/dir3', '/dir2', '/dir3', '/dir2' ];
  var got = _.path.simplifyInplace( src );
  var expected = [ '/dir1', '/dir2', '/dir3' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'array has empty strings and null';
  var src = [ '/dir1', '', '/dir2', '', '/dir3', null, '', '/path' ];
  var got = _.path.simplifyInplace( src );
  var expected = [ '/dir1', '/dir2', '/dir3', '/path' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'array has empty strings and nulls, one argument in result';
  var src = [ '/dir1', '', null, '', null, '' ];
  var got = _.path.simplifyInplace( src );
  var expected = [ '/dir1' ];
  test.identical( got, expected );
  test.is( got === src );

  test.case = 'array with empty strings and nulls';
  var src = [ '', '', null, null, '' ];
  var got = _.path.simplifyInplace( src );
  var expected = [];
  test.identical( got, expected );
  test.is( got === src );

  /* tests with map of paths */

  test.case = 'empty map';
  var src = {};
  var got = _.path.simplifyInplace( src );
  test.identical( got, {} );
  test.is( got === src );

  test.case = 'key is empty string, value is empty string';
  var got = _.path.simplifyInplace( { '' : '' } );
  test.identical( got, { '' : '' } );

  test.case = 'key is empty string';
  var src = { '' : '/dir' };
  var got = _.path.simplifyInplace( src );
  test.identical( got, { '' : '/dir' } );
  test.is( got === src );

  test.case = 'key, value is empty string';
  var got = _.path.simplifyInplace( { '/dir1' : '' } );
  test.identical( got, { '/dir1' : '' } );

  var src = { '/dir1' : '', '' : '' };
  var got = _.path.simplifyInplace( src );
  test.identical( got, { '/dir1' : '', '' : '' } );
  test.notIdentical( got, '/dir1' );
  test.is( got === src );

  test.case = 'key, value is array';
  var src = { '/dir1' : [ '/dir1', '/dir2' ], '/dir2' : '/a/b' };
  var got = _.path.simplifyInplace( src );
  test.identical( got, { '/dir1' : [ '/dir1', '/dir2' ], '/dir2' : '/a/b' } );
  test.is( got === src );

  var src = { '/dir1' : [ '/dir1', null, '', '/dir2', '' ], '/dir2' : '/a/b' };
  var got = _.path.simplifyInplace( src );
  test.identical( got, { '/dir1' : [ '/dir1', '/dir2' ], '/dir2' : '/a/b' } );
  test.is( got === src );

  test.case = 'complex map of paths';
  var constr = function( val )
  {
    this.value = val;
    return this;
  }
  var obj = new constr( '/dir' );
  var src =
  {
    '/false' : false, '/true' : true, '/undefined' : undefined,
    '/null' : null,
    '/string' : '/dir', '/emptyString' : '', '' : '',
    '/number' : 10,
    '/array' : [ '', '/', '/dir' ], '/emptyArray' : [],
    '/emptyMap' : {}, '/map' : { '/str' : '/dir2' },
    '/instance' : obj,
  };
  var got = _.path.simplifyInplace( src );
  test.identical( got, src );
  test.is( got === src );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.path.simplifyInplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.path.simplifyInplace( '', '' ) );
}

//

function mapDstFromDst( test )
{
  let path = _.path;

  test.case = '.';
  var exp = [ '.' ];
  var src = '.';
  var got = path.mapDstFromDst( src );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'str';
  var exp = [ '/dst' ];
  var src = '/dst';
  var got = path.mapDstFromDst( src );
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'arr';
  var exp = [ '/dst1', '/dst2' ];
  var src = [ '/dst1', '/dst2' ];
  var got = path.mapDstFromDst( src );
  test.identical( got, exp );
  test.is( got !== src );

}

// --
// etc
// --

function mapGroupByDst( test )
{
  let path = _.path;

  /* */

  test.case = 'trivial';
  var exp =
  {
    '/dir2/Output.js' :
    {
      '/dir/**' : '',
      '/dir/Exec' : false,
    },
  }
  var src =
  {
    '/dir/**' : `/dir2/Output.js`,
    '/dir/Exec' : 0,
  }
  var got = path.mapGroupByDst( src );
  test.identical( got, exp );
  test.is( got !== src );

  /* */

  test.case = 'parent dir';
  var exp =
  {
    '/dst' :
    {
      '/src1/d**' : '',
      '/src2/d/**' : '',
      '/**/b' : false
    },
  }
  var src =
  {
    '/src1/d**' : '/dst',
    '/src2/d/**' : '/dst',
    '/**/b' : false
  }
  var got = path.mapGroupByDst( src );
  test.identical( got, exp );
  test.is( got !== src );

  /* */

}

//

function group( test )
{
  test.case = 'nothing common';
  var o =
  {
    keys : [ '.' ],
    vals : [ 'a', 'b', 'a/b' ]
  }
  var expected =
  {
    '/' : [ ],
    '.' : [ ]
  }
  var got = _.path.group( o );
  test.identical( got, expected )

  test.case = 'single key as string';
  var o =
  {
    keys : '/a',
    vals : [ '.', '/a', '/b', './a', '/a/b' ]
  }
  var expected =
  {
    '/' : [ '/a', '/b', '/a/b' ],
    '/a' : [ '/a', '/a/b' ]
  }
  var got = _.path.group( o );
  test.identical( got, expected )

  test.case = 'single key in array';
  var o =
  {
    keys : [ '/a' ],
    vals : [ '.', '/a', '/b', './a', '/a/b' ]
  }
  var expected =
  {
    '/' : [ '/a', '/b', '/a/b' ],
    '/a' : [ '/a', '/a/b' ]
  }
  var got = _.path.group( o );
  test.identical( got, expected )

  test.case = 'severals keys';
  var o =
  {
    keys : [ '/a', '/b', '.' ],
    vals : [ '.', '/a', '/b', './a', '/a/b' ]
  }
  var expected =
  {
    '/' : [ '/a', '/b', '/a/b' ],
    '/a' : [ '/a', '/a/b' ],
    '/b' : [ '/b' ],
    '.' : [ '.', './a' ]
  }
  var got = _.path.group( o );
  test.identical( got, expected )

  test.case = 'vals has inner arrays';
  var o =
  {
    keys : [ '/' ],
    vals : [ '.', '/a', '/b', './a', '/a/b' ]
  }
  var expected =
  {
    '/' : [ '/a', '/b', '/a/b' ],
  }
  var got = _.path.group( o );
  test.identical( got, expected )

  test.case = 'result is existing map'
  var o =
  {
    keys : [ '/' ],
    vals : [ '/a' ],
    result :
    {
      '/' : [ '/y' ]
    }
  }
  var expected =
  {
    '/' : [ '/y', '/a' ],
  }
  var got = _.path.group( o );
  test.identical( got, expected )

  test.case = 'vals has inner arrays';
  var o =
  {
    keys : [ '/' ],
    vals : [ '.', [ '/a', '/b' ], [ './a', '/a/b' ] ]
  }
  var expected =
  {
    '/' : [ '/a', '/b', '/a/b' ],
  }
  var got = _.path.group( o );
  test.identical( got, expected )

  test.case = 'keys as map';
  var o =
  {
    keys : { '/a' : true, '/b' : true, '.' : true },
    vals : [ '.', '/a', '/b', './a', '/a/b' ]
  }
  var expected =
  {
    '/' : [ '/a', '/b', '/a/b' ],
    '/a' : [ '/a', '/a/b' ],
    '/b' : [ '/b' ],
    '.' : [ '.', './a' ]
  }
  var got = _.path.group( o );
  test.identical( got, expected )

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.path.group({ vals : '/val', keys : '/' }))
}

//

function setOptimize( test )
{
  let path = _.path;

  /* - */

  test.open( 'all levels, relative' );

  test.case = 'direct order';
  var filePath =
  {
    "module1" : `.`,
    "module1/ami" : `.`,
    "module1/amid" : `.`,
    "module1/amid/dir" : `.`,
    "module1/amid/dir/terminal" : `.`,
    "module1/amid/dir2" : `.`,
    "module2" : `.`,
    "module2/amid" : `.`,
  }
  var expected = [ 'module1', 'module2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.case = 'revers order';
  var filePath =
  {
    "module2/amid" : `.`,
    "module2" : `.`,
    "module1/amid/dir2" : `.`,
    "module1/amid/dir/terminal" : `.`,
    "module1/amid/dir" : `.`,
    "module1/amid" : `.`,
    "module1/ami" : `.`,
    "module1" : `.`,
  }
  var expected = [ 'module1', 'module2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order';
  var filePath =
  {
    "module2/amid" : `.`,
    "module2" : `.`,
    "module1/amid" : `.`,
    "module1/amid/dir2" : `.`,
    "module1/amid/dir" : `.`,
    "module1/amid/dir/terminal" : `.`,
    "module1/ami" : `.`,
    "module1" : `.`,
  }
  var expected = [ 'module1', 'module2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.close( 'all levels, relative' );

  /* - */

  test.open( 'gap in levels, relative' );

  test.case = 'direct order';
  var filePath =
  {
    'a1' : '',
    'a1/b1/c1' : '',
    'a1/b1/c2' : '',
    'a1/b1/c3' : '',
    'a1/b1/c4/d1/e1/f1' : '',
    'a2' : '',
    'a2/b1/c1' : '',
    'a2/b1/c1/d1/e1/f1' : '',
    'a2/b1/c2' : '',
  }
  var expected = [ 'a1', 'a2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.case = 'revers order';
  var filePath =
  {
    'a1/b1/c4/d1/e1/f1' : '',
    'a1/b1/c3' : '',
    'a1/b1/c2' : '',
    'a1/b1/c1' : '',
    'a1' : '',
    'a2/b1/c2' : '',
    'a2/b1/c1/d1/e1/f1' : '',
    'a2/b1/c1' : '',
    'a2' : '',
  }
  var expected = [ 'a1', 'a2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order, simpler';
  var filePath =
  {
    'a2/b1/c1/d1/e1/f1' : '',
    'a2' : '',
    'a2/b1/c1' : '',
    'a2/b1/c2' : '',
  }
  var expected = [ 'a2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order';
  var filePath =
  {
    'a1/b1/c3' : '',
    'a1' : '',
    'a1/b1/c1' : '',
    'a1/b1/c2' : '',
    'a1/b1/c4/d1/e1/f1' : '',
    'a2/b1/c1/d1/e1/f1' : '',
    'a2' : '',
    'a2/b1/c1' : '',
    'a2/b1/c2' : '',
  }
  var expected = [ 'a1', 'a2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.close( 'gap in levels, relative' );

  /* - */

  test.open( 'all levels, absolute' );

  test.case = 'direct order';
  var filePath =
  {
    "/module1" : `.`,
    "/module1/ami" : `.`,
    "/module1/amid" : `.`,
    "/module1/amid/dir" : `.`,
    "/module1/amid/dir/terminal" : `.`,
    "/module1/amid/dir2" : `.`,
    "/module2" : `.`,
    "/module2/amid" : `.`,
  }
  var expected = [ '/module1', '/module2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.case = 'revers order';
  var filePath =
  {
    "/module2/amid" : `.`,
    "/module2" : `.`,
    "/module1/amid/dir2" : `.`,
    "/module1/amid/dir/terminal" : `.`,
    "/module1/amid/dir" : `.`,
    "/module1/amid" : `.`,
    "/module1/ami" : `.`,
    "/module1" : `.`,
  }
  var expected = [ '/module1', '/module2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order';
  var filePath =
  {
    "/module2/amid" : `.`,
    "/module2" : `.`,
    "/module1/amid" : `.`,
    "/module1/amid/dir2" : `.`,
    "/module1/amid/dir" : `.`,
    "/module1/amid/dir/terminal" : `.`,
    "/module1/ami" : `.`,
    "/module1" : `.`,
  }
  var expected = [ '/module1', '/module2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.close( 'all levels, absolute' );

  /* - */

  test.open( 'gap in levels, absolute' );

  test.case = 'direct order';
  var filePath =
  {
    '/a1' : '',
    '/a1/b1/c1' : '',
    '/a1/b1/c2' : '',
    '/a1/b1/c3' : '',
    '/a1/b1/c4/d1/e1/f1' : '',
    '/a2' : '',
    '/a2/b1/c1' : '',
    '/a2/b1/c1/d1/e1/f1' : '',
    '/a2/b1/c2' : '',
  }
  var expected = [ '/a1', '/a2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.case = 'revers order';
  var filePath =
  {
    '/a2/b1/c2' : '',
    '/a2/b1/c1/d1/e1/f1' : '',
    '/a2/b1/c1' : '',
    '/a2' : '',
    '/a1/b1/c4/d1/e1/f1' : '',
    '/a1/b1/c3' : '',
    '/a1/b1/c2' : '',
    '/a1/b1/c1' : '',
    '/a1' : '',
  }
  var expected = [ '/a1', '/a2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order, simpler';
  var filePath =
  {
    '/a2/b1/c1/d1/e1/f1' : '',
    '/a2' : '',
    '/a2/b1/c1' : '',
    '/a2/b1/c2' : '',
  }
  var expected = [ '/a2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order';
  var filePath =
  {
    '/a1/b1/c3' : '',
    '/a1' : '',
    '/a1/b1/c1' : '',
    '/a1/b1/c2' : '',
    '/a1/b1/c4/d1/e1/f1' : '',
    '/a2/b1/c1/d1/e1/f1' : '',
    '/a2' : '',
    '/a2/b1/c1' : '',
    '/a2/b1/c2' : '',
  }
  var expected = [ '/a1', '/a2' ];
  var got = path.setOptimize( filePath );
  test.identical( got, expected );

  test.close( 'gap in levels, absolute' );

  /* - */

} /* end of mapOptimize */

//

function mapOptimize( test )
{
  let path = _.path;

  /* - */

  test.open( 'all levels, relative' );

  test.case = 'direct order';
  var filePath =
  {
    "module1" : `.`,
    "module1/ami" : `.`,
    "module1/amid" : `.`,
    "module1/amid/dir" : `.`,
    "module1/amid/dir/terminal" : `.`,
    "module1/amid/dir2" : `.`,
    "module2" : `.`,
    "module2/amid" : `.`,
  }
  var expected =
  {
    'module1' : '.',
    'module2' : '.',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.case = 'revers order';
  var filePath =
  {
    "module2/amid" : `.`,
    "module2" : `.`,
    "module1/amid/dir2" : `.`,
    "module1/amid/dir/terminal" : `.`,
    "module1/amid/dir" : `.`,
    "module1/amid" : `.`,
    "module1/ami" : `.`,
    "module1" : `.`,
  }
  var expected =
  {
    'module1' : '.',
    'module2' : '.',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order';
  var filePath =
  {
    "module2/amid" : `.`,
    "module2" : `.`,
    "module1/amid" : `.`,
    "module1/amid/dir2" : `.`,
    "module1/amid/dir" : `.`,
    "module1/amid/dir/terminal" : `.`,
    "module1/ami" : `.`,
    "module1" : `.`,
  }
  var expected =
  {
    'module1' : '.',
    'module2' : '.',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.close( 'all levels, relative' );

  /* - */

  test.open( 'gap in levels, relative' );

  test.case = 'direct order';
  var filePath =
  {
    'a1' : '',
    'a1/b1/c1' : '',
    'a1/b1/c2' : '',
    'a1/b1/c3' : '',
    'a1/b1/c4/d1/e1/f1' : '',
    'a2' : '',
    'a2/b1/c1' : '',
    'a2/b1/c1/d1/e1/f1' : '',
    'a2/b1/c2' : '',
  }
  var expected =
  {
    'a1' : '',
    'a2' : '',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.case = 'revers order';
  var filePath =
  {
    'a1/b1/c4/d1/e1/f1' : '',
    'a1/b1/c3' : '',
    'a1/b1/c2' : '',
    'a1/b1/c1' : '',
    'a1' : '',
    'a2/b1/c2' : '',
    'a2/b1/c1/d1/e1/f1' : '',
    'a2/b1/c1' : '',
    'a2' : '',
  }
  var expected =
  {
    'a1' : '',
    'a2' : '',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order, simpler';
  var filePath =
  {
    'a2/b1/c1/d1/e1/f1' : '',
    'a2' : '',
    'a2/b1/c1' : '',
    'a2/b1/c2' : '',
  }
  var expected =
  {
    'a2' : '',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order';
  var filePath =
  {
    'a1/b1/c3' : '',
    'a1' : '',
    'a1/b1/c1' : '',
    'a1/b1/c2' : '',
    'a1/b1/c4/d1/e1/f1' : '',
    'a2/b1/c1/d1/e1/f1' : '',
    'a2' : '',
    'a2/b1/c1' : '',
    'a2/b1/c2' : '',
  }
  var expected =
  {
    'a1' : '',
    'a2' : '',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.close( 'gap in levels, relative' );

  /* - */

  test.open( 'all levels, absolute' );

  test.case = 'direct order';
  var filePath =
  {
    "/module1" : `.`,
    "/module1/ami" : `.`,
    "/module1/amid" : `.`,
    "/module1/amid/dir" : `.`,
    "/module1/amid/dir/terminal" : `.`,
    "/module1/amid/dir2" : `.`,
    "/module2" : `.`,
    "/module2/amid" : `.`,
  }
  var expected =
  {
    '/module1' : '.',
    '/module2' : '.',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.case = 'revers order';
  var filePath =
  {
    "/module2/amid" : `.`,
    "/module2" : `.`,
    "/module1/amid/dir2" : `.`,
    "/module1/amid/dir/terminal" : `.`,
    "/module1/amid/dir" : `.`,
    "/module1/amid" : `.`,
    "/module1/ami" : `.`,
    "/module1" : `.`,
  }
  var expected =
  {
    '/module1' : '.',
    '/module2' : '.',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order';
  var filePath =
  {
    "/module2/amid" : `.`,
    "/module2" : `.`,
    "/module1/amid" : `.`,
    "/module1/amid/dir2" : `.`,
    "/module1/amid/dir" : `.`,
    "/module1/amid/dir/terminal" : `.`,
    "/module1/ami" : `.`,
    "/module1" : `.`,
  }
  var expected =
  {
    '/module1' : '.',
    '/module2' : '.',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.close( 'all levels, absolute' );

  /* - */

  test.open( 'gap in levels, absolute' );

  test.case = 'direct order';
  var filePath =
  {
    '/a1' : '',
    '/a1/b1/c1' : '',
    '/a1/b1/c2' : '',
    '/a1/b1/c3' : '',
    '/a1/b1/c4/d1/e1/f1' : '',
    '/a2' : '',
    '/a2/b1/c1' : '',
    '/a2/b1/c1/d1/e1/f1' : '',
    '/a2/b1/c2' : '',
  }
  var expected =
  {
    '/a1' : '',
    '/a2' : '',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.case = 'revers order';
  var filePath =
  {
    '/a2/b1/c2' : '',
    '/a2/b1/c1/d1/e1/f1' : '',
    '/a2/b1/c1' : '',
    '/a2' : '',
    '/a1/b1/c4/d1/e1/f1' : '',
    '/a1/b1/c3' : '',
    '/a1/b1/c2' : '',
    '/a1/b1/c1' : '',
    '/a1' : '',
  }
  var expected =
  {
    '/a1' : '',
    '/a2' : '',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order, simpler';
  var filePath =
  {
    '/a2/b1/c1/d1/e1/f1' : '',
    '/a2' : '',
    '/a2/b1/c1' : '',
    '/a2/b1/c2' : '',
  }
  var expected =
  {
    '/a2' : '',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.case = 'no order';
  var filePath =
  {
    '/a1/b1/c3' : '',
    '/a1' : '',
    '/a1/b1/c1' : '',
    '/a1/b1/c2' : '',
    '/a1/b1/c4/d1/e1/f1' : '',
    '/a2/b1/c1/d1/e1/f1' : '',
    '/a2' : '',
    '/a2/b1/c1' : '',
    '/a2/b1/c2' : '',
  }
  var expected =
  {
    '/a1' : '',
    '/a2' : '',
  };
  var got = path.mapOptimize( filePath );
  test.identical( got, expected );

  test.close( 'gap in levels, absolute' );

  /* - */

}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l5.path.tools',
  silencing : 1,

  tests :
  {

    /* path map */

/*
qqq : similar test routines ( for example filterPairs and filterPairsInplace )
      should have exactly the same test cases
      in the same order
*/

    filterPairs,
    filterPairsInplace,
    filterInplace,
    filterInplaceExtends, /* qqq : ? */
    filter,
    filterExtends,

    mapExtend,
    mapSupplement,
    mapAppend,
    mapAppendExperiment,
    mapPrepend,
    mapsPair,
    simplify,
    simplifyInplace,
    mapDstFromDst,

    // etc

    mapGroupByDst,
    group,
    setOptimize,
    mapOptimize,

  },

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
