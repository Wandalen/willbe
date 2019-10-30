( function _Uris_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  require( '../l5/Uris.s' );

}

var _global = _global_;
var _ = _global_.wTools;

/*
qqq : fix style problems and non-style problems in the test
*/

// --
//
// --

function refine( test )
{
  test.case = 'refine the uris';
  var srcs =
  [
    '/some/staging/index.html',
    '/some/staging/index.html/',
    '//some/staging/index.html',
    '//some/staging/index.html/',
    '///some/staging/index.html',
    '///some/staging/index.html/',
    'file:///some/staging/index.html',
    'file:///some/staging/index.html/',
    'http://some.come/staging/index.html',
    'http://some.come/staging/index.html/',
    'svn+https://user@subversion.com/svn/trunk',
    'svn+https://user@subversion.com/svn/trunk/',
    'complex+protocol://www.site.com:13/path/name/?query=here&and=here#anchor',
    'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor',
    'https://web.archive.org/web/*/http://www.heritage.org/index/ranking',
    'https://web.archive.org//web//*//http://www.heritage.org//index//ranking',
    '://www.site.com:13/path//name//?query=here&and=here#anchor',
    ':///www.site.com:13/path//name/?query=here&and=here#anchor',
  ]
  var expected =
  [
    '/some/staging/index.html',
    '/some/staging/index.html/',
    '//some/staging/index.html',
    '//some/staging/index.html/',
    '///some/staging/index.html',
    '///some/staging/index.html/',
    'file:///some/staging/index.html',
    'file:///some/staging/index.html/',
    'http://some.come/staging/index.html',
    'http://some.come/staging/index.html/',
    'svn+https://user@subversion.com/svn/trunk',
    'svn+https://user@subversion.com/svn/trunk/',
    'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor',
    'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor',
    'https://web.archive.org/web/*/http://www.heritage.org/index/ranking',
    'https://web.archive.org//web//*//http://www.heritage.org//index//ranking',
    '://www.site.com:13/path//name/?query=here&and=here#anchor',
    ':///www.site.com:13/path//name?query=here&and=here#anchor'
  ]
  var got = _.uri.s.refine( srcs );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.uris.refine() );
  test.shouldThrowErrorSync( () => _.uris.refine( [] ) );
  test.shouldThrowErrorSync( () => _.uris.refine( {} ) );
  test.shouldThrowErrorSync( () => _.uris.refine( [ '' ] ) );
  test.shouldThrowErrorSync( () => _.uris.refine( [ 1, 'http://some.com' ] ) );

}

//

function common( test )
{

  test.case = 'empty';

  var got = _.uri.s.common();
  test.identical( got, null );

  var got = _.uri.s.common([]);
  test.identical( got, [] );

  test.case = 'array';

  var got = _.uri.s.common([ '/a1/b2', '/a1/b' ]);
  test.identical( got, [ '/a1/b2', '/a1/b' ] );

  var got = _.uri.s.common( [ '/a1/b1/c', '/a1/b1/d' ], '/a1/b2' );
  test.identical( got, [ '/a1/', '/a1/' ] );

  test.case = 'other';

  var got = _.uri.s.common( 'npm:///wprocedure#0.3.19', 'npm:///wprocedure' );
  test.identical( got, 'npm:///wprocedure' );

  var got = _.uri.s.common( 'npm:///wprocedure', 'npm:///wprocedure#0.3.19' );
  test.identical( got, 'npm:///wprocedure' );

  var got = _.uri.s.common( 'npm:///wprocedure#0.3.19', 'npm:///wprocedure#' );
  test.identical( got, 'npm:///wprocedure' );

  var got = _.uri.s.common( 'npm:///wprocedure#', 'npm:///wprocedure#0.3.19' );
  test.identical( got, 'npm:///wprocedure' );

  var got = _.uri.s.common( 'git+https:///github.com/repo/wTools#bd9094b83', 'git+https:///github.com/repo/wTools#master' );
  test.identical( got, 'git+https:///github.com/repo/wTools' );

  var got = _.uri.s.common( '://a1/b2', '://some/staging/index.html' );
  test.identical( got, '://.' );

  var got = _.uri.s.common( '://some/staging/index.html', '://a1/b2' );
  test.identical( got, '://.' );

  var got = _.uri.s.common( '://some/staging/index.html', '://some/staging/' );
  test.identical( got, '://some/staging/' );

  var got = _.uri.s.common( '://some/staging/index.html', '://some/stagi' );
  test.identical( got, '://some/' );

  var got = _.uri.s.common( 'file:///some/staging/index.html', ':///some/stagi' );
  test.identical( got, ':///some/' );

  var got = _.uri.s.common( 'file://some/staging/index.html', '://some/stagi' );
  test.identical( got, '://some/' );

  var got = _.uri.s.common( 'file:///some/staging/index.html', '/some/stagi' );
  test.identical( got, ':///some/' );

  var got = _.uri.s.common( 'file:///some/staging/index.html', 'file:///some/staging' );
  test.identical( got, 'file:///some/staging' );

  var got = _.uri.s.common( 'http://some', 'some/staging' );
  test.identical( got, '://some' );

  var got = _.uri.s.common( 'some/staging', 'http://some' );
  test.identical( got, '://some' );

  var got = _.uri.s.common( 'http://some.come/staging/index.html', 'some/staging' );
  test.identical( got, '://.' );

  var got = _.uri.s.common( 'http:///some.come/staging/index.html', '/some/staging' );
  test.identical( got, ':///' );

  var got = _.uri.s.common( 'http://some.come/staging/index.html', 'file://some/staging' );
  test.identical( got, '' );

  var got = _.uri.s.common( 'http:///some.come/staging/index.html', 'file:///some/staging' );
  test.identical( got, '' );

  var got = _.uri.s.common( 'http:///some.come/staging/index.html', 'http:///some/staging/file.html' );
  test.identical( got, 'http:///' );

  var got = _.uri.s.common( 'http://some.come/staging/index.html', 'http://some.come/some/staging/file.html' );
  test.identical( got, 'http://some.come/' );

  // qqq !!! : implement
  var got = _.uri.s.common( 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor', 'complex+protocol://www.site.com:13/path' );
  test.identical( got, 'complex+protocol://www.site.com:13/path' );

  var got = _.uri.s.common( 'complex+protocol://www.site.com:13/path', 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor' );
  test.identical( got, 'complex+protocol://www.site.com:13/path' );

  var got = _.uri.s.common( 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor', 'complex+protocol://www.site.com:13/path?query=here' );
  test.identical( got, 'complex+protocol://www.site.com:13/path' );

  var got = _.uri.s.common( 'complex+protocol://www.site.com:13/path?query=here', 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor' );
  test.identical( got, 'complex+protocol://www.site.com:13/path' );

  var got = _.uri.s.common( 'https://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash', 'https://user:pass@sub.host.com:8080/p/a' );
  test.identical( got, 'https://user:pass@sub.host.com:8080/p/a' );

  var got = _.uri.s.common( '://some/staging/a/b/c', '://some/staging/a/b/c/index.html', '://some/staging/a/x' );
  test.identical( got, '://some/staging/a/' );

  var got = _.uri.s.common( 'http:///', 'http:///' );
  test.identical( got, 'http:///' );

  var got = _.uri.s.common( '/some/staging/a/b/c' );
  test.identical( got, '/some/staging/a/b/c' );

  test.case = 'combination of diff strcutures';

  var got = _.uri.s.common( [ 'http:///' ], [ 'http:///' ] )
  test.identical( got, [ 'http:///' ] );

  var got = _.uri.s.common( [ 'http:///x' ], [ 'http:///y' ] )
  test.identical( got, [ 'http:///' ] );

  var got = _.uri.s.common( [ 'http:///a/x' ], [ 'http:///a/y' ] )
  test.identical( got, [ 'http:///a/' ] );

  var got = _.uri.s.common( [ 'http:///a/x' ], 'http:///a/y' )
  test.identical( got, [ 'http:///a/' ] );

  var got = _.uri.s.common( 'http:///a/x', [ 'http:///a/y' ] )
  test.identical( got, [ 'http:///a/' ] );

  var got = _.uri.s.common( 'http:///a/x', 'http:///a/y' )
  test.identical( got, 'http:///a/' );

  var got = _.uri.s.common( [ [ 'http:///a/x' ], 'http:///a/y' ], 'http:///a/z' )
  test.identical( got, [ 'http:///a/', 'http:///a/' ] );

  /* */

  if( !Config.debug )
  return

  test.case = 'incorrect input';
  test.shouldThrowErrorOfAnyKind( () => _.uri.s.common( 1, 2 ) );

  test.case = 'different paths'
  test.shouldThrowErrorOfAnyKind( () => _.uri.s.common( 'http://some.come/staging/index.html', 'file:///some/staging' ) );
  test.shouldThrowErrorOfAnyKind( () => _.uri.s.common( 'http://some.come/staging/index.html', 'http:///some/staging/file.html' ) );

}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l4.Uri.S',
  silencing : 1,

  tests :
  {
    refine,
    common,
  },

}

Self = wTestSuite( Self );

if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self );

})();
