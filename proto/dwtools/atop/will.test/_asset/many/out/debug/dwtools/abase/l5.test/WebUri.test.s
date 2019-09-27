( function _WebUri_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  require( '../l5/WebUri.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
//
// --

function join( test )
{

  test.case = 'join different protocols';

  var got = _.weburi.join( 'file://www.site.com:13','a','http:///dir','b' );
  var expected = 'http:///dir/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'file:///d','a','http:///dir','b' );
  var expected = 'http:///dir/b';
  test.identical( got, expected );

  test.case = 'join same protocols';

  var got = _.weburi.join( 'http://www.site.com:13','a','http:///dir','b' );
  var expected = 'http://www.site.com:13/dir/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http:///www.site.com:13','a','http:///dir','b' );
  var expected = 'http:///dir/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http://server1','a','http://server2','b' );
  var expected = 'http://server2/a/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http:///server1','a','http://server2','b' );
  var expected = 'http://server2/server1/a/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http://server1','a','http:///server2','b' );
  var expected = 'http://server1/server2/b';
  test.identical( got, expected );

  test.case = 'join protocol with protocol-less';

  var got = _.weburi.join( 'http://www.site.com:13','a',':///dir','b' );
  var expected = 'http://www.site.com:13/dir/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http:///www.site.com:13','a','://dir','b' );
  var expected = 'http://dir/www.site.com:13/a/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http:///www.site.com:13','a',':///dir','b' );
  var expected = 'http:///dir/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http://www.site.com:13','a','://dir','b' );
  var expected = 'http://dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http://dir:13','a','://dir','b' );
  var expected = 'http://dir:13/a/b';
  test.identical( got, expected );

  var got = _.weburi.join( 'http://www.site.com:13','a','://:14','b' );
  var expected = 'http://www.site.com:14/a/b';
  test.identical( got, expected );

  /**/

  var got = _.weburi.join( 'a','://dir1/x','b','http://dir2/y','c' );
  var expected = 'http://dir2/y/c';
  test.identical( got, expected );

  var got = _.weburi.join( 'a',':///dir1/x','b','http://dir2/y','c' );
  var expected = 'http://dir2/y/c';
  test.identical( got, expected );

  var got = _.weburi.join( 'a','://dir1/x','b','http:///dir2/y','c' );
  var expected = 'http://dir1/dir2/y/c';
  test.identical( got, expected );

  var got = _.weburi.join( 'a',':///dir1/x','b','http:///dir2/y','c' );
  var expected = 'http:///dir2/y/c';
  test.identical( got, expected );

  /* */

  test.case = 'server join absolute path 1';
  var got = _.weburi.join( 'http://www.site.com:13','/x','/y','/z' );
  test.identical( got, 'http://www.site.com:13/z' );

  test.case = 'server join absolute path 2';
  var got = _.weburi.join( 'http://www.site.com:13/','x','/y','/z' );
  test.identical( got, 'http://www.site.com:13/z' );

  test.case = 'server join absolute path 2';
  var got = _.weburi.join( 'http://www.site.com:13/','x','y','/z' );
  test.identical( got, 'http://www.site.com:13/z' );

  test.case = 'server join absolute path';
  var got = _.weburi.join( 'http://www.site.com:13/','x','/y','z' );
  test.identical( got, 'http://www.site.com:13/y/z' );

  test.case = 'server join relative path';
  var got = _.weburi.join( 'http://www.site.com:13/','x','y','z' );
  test.identical( got, 'http://www.site.com:13/x/y/z' );

  test.case = 'server with path join absolute path 2';
  var got = _.weburi.join( 'http://www.site.com:13/ab','/y','/z' );
  test.identical( got, 'http://www.site.com:13/z' );

  test.case = 'server with path join absolute path 2';
  var got = _.weburi.join( 'http://www.site.com:13/ab','/y','z' );
  test.identical( got, 'http://www.site.com:13/y/z' );

  test.case = 'server with path join absolute path 2';
  var got = _.weburi.join( 'http://www.site.com:13/ab','y','z' );
  test.identical( got, 'http://www.site.com:13/ab/y/z' );

  test.case = 'add relative to uri with no localWebPath';
  var got = _.weburi.join( 'https://some.domain.com/','something/to/add' );
  test.identical( got, 'https://some.domain.com/something/to/add' );

  test.case = 'add relative to uri with localWebPath';
  var got = _.weburi.join( 'https://some.domain.com/was','something/to/add' );
  test.identical( got, 'https://some.domain.com/was/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( 'https://some.domain.com/was','/something/to/add' );
  test.identical( got, 'https://some.domain.com/something/to/add' );

  /* */

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '//some.domain.com/was','/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '://some.domain.com/was','/something/to/add' );
  test.identical( got, '://some.domain.com/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '//some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '://some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '://some.domain.com/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '//some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '/something/to/add/x' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '://some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '://some.domain.com/something/to/add/x' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '//some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '/x' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '://some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '://some.domain.com/x' );

  /* */

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '/some/staging/index.html','/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '/some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '/some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '/some/staging/index.html','/something/to/add', '/y' );
  test.identical( got, '/y' );

  /* */

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '///some/staging/index.html','/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( ':///some/staging/index.html','/something/to/add' );
  test.identical( got, ':///something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( ':///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, ':///something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( ':///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, ':///something/to/add/y' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '///some/staging/index.html','/something/to/add', '/y' );
  test.identical( got, '/y' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( ':///some/staging/index.html','/something/to/add', '/y' );
  test.identical( got, ':///y' );

  /* */

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( 'svn+https://user@subversion.com/svn/trunk','/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add', 'y' );
  test.identical( got, 'svn+https://user@subversion.com/something/to/add/y' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( 'svn+https://user@subversion.com/svn/trunk','/something/to/add', '/y' );
  test.identical( got, 'svn+https://user@subversion.com/y' );

  /* */

  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var parsed = _.weburi.parse( uri );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( uri,'/something/to/add' );
  test.identical( got, parsed.origin + '/something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( uri, 'x', '/something/to/add' );
  test.identical( got, parsed.origin + '/something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( uri, 'x', '/something/to/add', 'y' );
  test.identical( got, parsed.origin + '/something/to/add/y' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( uri,'/something/to/add', '/y' );
  test.identical( got, parsed.origin + '/y' + '?query=here&and=here#anchor' );

  /* */

  test.case = 'several queries and hashes'
  var uri1 = '://user:pass@sub.host.com:8080/p/a/t/h?query1=string1#hash1';
  var uri2 = '://user:pass@sub.host.com:8080/p/a/t/h?query2=string2#hash2';
  var got = _.weburi.join( uri1, uri2, '/x//y//z'  );
  var expected = '://user:pass@sub.host.com:8080/x//y//z?query1=string1&query2=string2#hash2';
  test.identical( got, expected );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( '://some.domain.com/was','/something/to/add' );
  test.identical( got, '://some.domain.com/something/to/add' );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, 'x'  );
  var expected = '://user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, 'x', '/y'  );
  var expected = '://user:pass@sub.host.com:8080/y?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, '/x//y//z'  );
  var expected = '://user:pass@sub.host.com:8080/x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p//a//t//h?query=string#hash';
  var got = _.weburi.join( uri, 'x'  );
  var expected = '://user:pass@sub.host.com:8080/p//a//t//h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, 'x'  );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, 'x', '/y'  );
  var expected = ':///y?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, '/x//y//z'  );
  var expected = ':///x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.join( uri, 'x'  );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.join( 'file:///some/file','/something/to/add' );
  test.identical( got, 'file:///something/to/add' );

  /* */

  test.case = 'add uris';

  var got = _.weburi.join( '//a', '//b', 'c' );
  test.identical( got, '//b/c' )

  var got = _.weburi.join( 'b://c', 'd://e', 'f' );
  test.identical( got, 'd://e/f' );

  var got = _.weburi.join( 'a://b', 'c://d/e', '//f/g' );
  test.identical( got, 'c://d//f/g' )

  /* */

  test.case = 'works like join';
  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = _.weburi.join.apply( _.weburi, paths );
  test.identical( got, expected );

  test.case = 'join unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo';
  var got = _.weburi.join.apply( _.weburi, paths );
  test.identical( got, expected );

  test.case = 'more complicated cases'; /* */

  /* qqq */

  var paths = [  '/aa', 'bb//', 'cc' ];
  var expected = '/aa/bb//cc';
  var got = _.weburi.join.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/aa', 'bb//', 'cc','.' ];
  var expected = '/aa/bb//cc';
  var got = _.weburi.join.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/','a', '//b', '././c', '../d', '..e' ];
  var expected = '//b/d/..e';
  var got = _.weburi.join.apply( _.weburi, paths );
  test.identical( got, expected );

/*
  _.weburi.join( 'https://some.domain.com/','something/to/add' ) -> 'https://some.domain.com/something/to/add'
  _.weburi.join( 'https://some.domain.com/was','something/to/add' ) -> 'https://some.domain.com/was/something/to/add'
  _.weburi.join( 'https://some.domain.com/was','/something/to/add' ) -> 'https://some.domain.com/something/to/add'

  _.weburi.join( '//some.domain.com/was','/something/to/add' ) -> '//some.domain.com/something/to/add'
  _.weburi.join( '://some.domain.com/was','/something/to/add' ) -> '://some.domain.com/something/to/add'

/some/staging/index.html
//some/staging/index.html
///some/staging/index.html
file:///some/staging/index.html
http://some.come/staging/index.html
svn+https://user@subversion.com/svn/trunk
complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor

*/

}

//

function joinRaw( test )
{
  test.case = 'join different protocols';

  var got = _.weburi.joinRaw( 'file://www.site.com:13','a','http:///dir','b' );
  var expected = 'http:///dir/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'file:///d','a','http:///dir','b' );
  var expected = 'http:///dir/b';
  test.identical( got, expected );

  test.case = 'joinRaw same protocols';

  var got = _.weburi.joinRaw( 'http://www.site.com:13','a','http:///dir','b' );
  var expected = 'http://www.site.com:13/dir/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http:///www.site.com:13','a','http:///dir','b' );
  var expected = 'http:///dir/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http://server1','a','http://server2','b' );
  var expected = 'http://server2/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http:///server1','a','http://server2','b' );
  var expected = 'http://server2/server1/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http://server1','a','http:///server2','b' );
  var expected = 'http://server1/server2/b';
  test.identical( got, expected );

  test.case = 'joinRaw protocol with protocol-less';

  var got = _.weburi.joinRaw( 'http://www.site.com:13','a',':///dir','b' );
  var expected = 'http://www.site.com:13/dir/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http:///www.site.com:13','a','://dir','b' );
  var expected = 'http://dir/www.site.com:13/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http:///www.site.com:13','a',':///dir','b' );
  var expected = 'http:///dir/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http://www.site.com:13','a','://dir','b' );
  var expected = 'http://dir/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http://dir:13','a','://dir','b' );
  var expected = 'http://dir:13/a/b';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'http://www.site.com:13','a','://:14','b' );
  var expected = 'http://www.site.com:14/a/b';
  test.identical( got, expected );

  /**/

  var got = _.weburi.joinRaw( 'a','://dir1/x','b','http://dir2/y','c' );
  var expected = 'http://dir2/y/c';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'a',':///dir1/x','b','http://dir2/y','c' );
  var expected = 'http://dir2/y/c';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'a','://dir1/x','b','http:///dir2/y','c' );
  var expected = 'http://dir1/dir2/y/c';
  test.identical( got, expected );

  var got = _.weburi.joinRaw( 'a',':///dir1/x','b','http:///dir2/y','c' );
  var expected = 'http:///dir2/y/c';
  test.identical( got, expected );

  /* */

  test.case = 'server joinRaw absolute path 1';
  var got = _.weburi.joinRaw( 'http://www.site.com:13','/x','/y','/z' );
  test.identical( got, 'http://www.site.com:13/z' );

  test.case = 'server joinRaw absolute path 2';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/','x','/y','/z' );
  test.identical( got, 'http://www.site.com:13/z' );

  test.case = 'server joinRaw absolute path 2';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/','x','y','/z' );
  test.identical( got, 'http://www.site.com:13/z' );

  test.case = 'server joinRaw absolute path';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/','x','/y','z' );
  test.identical( got, 'http://www.site.com:13/y/z' );

  test.case = 'server joinRaw relative path';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/','x','y','z' );
  test.identical( got, 'http://www.site.com:13/x/y/z' );

  test.case = 'server with path joinRaw absolute path 2';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/ab','/y','/z' );
  test.identical( got, 'http://www.site.com:13/z' );

  test.case = 'server with path joinRaw absolute path 2';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/ab','/y','z' );
  test.identical( got, 'http://www.site.com:13/y/z' );

  test.case = 'server with path joinRaw absolute path 2';
  var got = _.weburi.joinRaw( 'http://www.site.com:13/ab','y','z' );
  test.identical( got, 'http://www.site.com:13/ab/y/z' );

  test.case = 'add relative to uri with no localWebPath';
  var got = _.weburi.joinRaw( 'https://some.domain.com/','something/to/add' );
  test.identical( got, 'https://some.domain.com/something/to/add' );

  test.case = 'add relative to uri with localWebPath';
  var got = _.weburi.joinRaw( 'https://some.domain.com/was','something/to/add' );
  test.identical( got, 'https://some.domain.com/was/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( 'https://some.domain.com/was','/something/to/add' );
  test.identical( got, 'https://some.domain.com/something/to/add' );

  /* */

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '//some.domain.com/was','/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '://some.domain.com/was','/something/to/add' );
  test.identical( got, '://some.domain.com/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '//some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '://some.domain.com/was', 'x', '/something/to/add' );
  test.identical( got, '://some.domain.com/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '//some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '/something/to/add/x' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '://some.domain.com/was', '/something/to/add', 'x' );
  test.identical( got, '://some.domain.com/something/to/add/x' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '//some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '/x' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '://some.domain.com/was', '/something/to/add', '/x' );
  test.identical( got, '://some.domain.com/x' );

  /* */

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '/some/staging/index.html','/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '/some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '/some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '/some/staging/index.html','/something/to/add', '/y' );
  test.identical( got, '/y' );

  /* */

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '///some/staging/index.html','/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( ':///some/staging/index.html','/something/to/add' );
  test.identical( got, ':///something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, '/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( ':///some/staging/index.html', 'x', '/something/to/add' );
  test.identical( got, ':///something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, '/something/to/add/y' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( ':///some/staging/index.html', 'x', '/something/to/add', 'y' );
  test.identical( got, ':///something/to/add/y' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '///some/staging/index.html','/something/to/add', '/y' );
  test.identical( got, '/y' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( ':///some/staging/index.html','/something/to/add', '/y' );
  test.identical( got, ':///y' );

  /* */

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( 'svn+https://user@subversion.com/svn/trunk','/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add' );
  test.identical( got, 'svn+https://user@subversion.com/something/to/add' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( 'svn+https://user@subversion.com/svn/trunk', 'x', '/something/to/add', 'y' );
  test.identical( got, 'svn+https://user@subversion.com/something/to/add/y' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( 'svn+https://user@subversion.com/svn/trunk','/something/to/add', '/y' );
  test.identical( got, 'svn+https://user@subversion.com/y' );

  /* */

  var uri = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var parsed = _.weburi.parse( uri );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( uri,'/something/to/add' );
  test.identical( got, parsed.origin + '/something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( uri, 'x', '/something/to/add' );
  test.identical( got, parsed.origin + '/something/to/add' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( uri, 'x', '/something/to/add', 'y' );
  test.identical( got, parsed.origin + '/something/to/add/y' + '?query=here&and=here#anchor' );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( uri,'/something/to/add', '/y' );
  test.identical( got, parsed.origin + '/y' + '?query=here&and=here#anchor' );

  /* */

  test.case = 'several queries and hashes'
  var uri1 = '://user:pass@sub.host.com:8080/p/a/t/h?query1=string1#hash1';
  var uri2 = '://user:pass@sub.host.com:8080/p/a/t/h?query2=string2#hash2';
  var got = _.weburi.joinRaw( uri1, uri2, '/x//y//z'  );
  var expected = '://user:pass@sub.host.com:8080/x//y//z?query1=string1&query2=string2#hash2';
  test.identical( got, expected );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( '://some.domain.com/was','/something/to/add' );
  test.identical( got, '://some.domain.com/something/to/add' );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x'  );
  var expected = '://user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x', '/y'  );
  var expected = '://user:pass@sub.host.com:8080/y?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, '/x//y//z'  );
  var expected = '://user:pass@sub.host.com:8080/x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = '://user:pass@sub.host.com:8080/p//a//t//h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x'  );
  var expected = '://user:pass@sub.host.com:8080/p//a//t//h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x'  );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x', '/y'  );
  var expected = ':///y?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, '/x//y//z'  );
  var expected = ':///x//y//z?query=string#hash'
  test.identical( got, expected );

  var uri = ':///user:pass@sub.host.com:8080/p/a/t/h?query=string#hash';
  var got = _.weburi.joinRaw( uri, 'x'  );
  var expected = ':///user:pass@sub.host.com:8080/p/a/t/h/x?query=string#hash'
  test.identical( got, expected );

  test.case = 'add absolute to uri with localWebPath';
  var got = _.weburi.joinRaw( 'file:///some/file','/something/to/add' );
  test.identical( got, 'file:///something/to/add' );

  /* */

  test.case = 'add uris';

  var got = _.weburi.joinRaw( '//a', '//b', 'c' );
  test.identical( got, '//b/c' )

  var got = _.weburi.joinRaw( 'b://c', 'd://e', 'f' );
  test.identical( got, 'd://e/f' );

  var got = _.weburi.joinRaw( 'a://b', 'c://d/e', '//f/g' );
  test.identical( got, 'c://d//f/g' )

  /* */

  test.case = 'works like joinRaw';
  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

  test.case = 'joinRaw unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo/.';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

  test.case = 'more complicated cases'; /* */

  /* qqq */

  var paths = [  '/aa', 'bb//', 'cc' ];
  var expected = '/aa/bb//cc';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/aa', 'bb//', 'cc','.' ];
  var expected = '/aa/bb//cc/.';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/aa', 'bb//', 'cc','.' ];
  var expected = '/aa/bb//cc/.';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/','a', '//b', '././c', '../d', '..e' ];
  var expected = '//b/././c/../d/..e';
  var got = _.weburi.joinRaw.apply( _.weburi, paths );
  test.identical( got, expected );

}

//

function resolve( test )
{

  var current = _.strPrependOnce( _.weburi.current(), '/' );

  var got = _.weburi.resolve( 'http://www.site.com:13','a' );
  test.identical( got, 'http://www.site.com:13/a' );

  var got = _.weburi.resolve( 'http://www.site.com:13/','a' );
  test.identical( got, 'http://www.site.com:13/a' );

  var got = _.weburi.resolve( 'http://www.site.com:13','a', '/b' );
  test.identical( got, 'http://www.site.com:13/b' );

  var got = _.weburi.resolve( 'http://www.site.com:13','a', '/b', 'c' );
  test.identical( got, 'http://www.site.com:13/b/c' );

  var got = _.weburi.resolve( 'http://www.site.com:13','/a/', '/b/', 'c/', '.' );
  test.identical( got, 'http://www.site.com:13/b/c' );

  var got = _.weburi.resolve( 'http://www.site.com:13','a', '.', 'b' );
  test.identical( got, 'http://www.site.com:13/a/b' );

  var got = _.weburi.resolve( 'http://www.site.com:13/','a', '.', 'b' );
  test.identical( got, 'http://www.site.com:13/a/b' );

  var got = _.weburi.resolve( 'http://www.site.com:13','a', '..', 'b' );
  test.identical( got, 'http://www.site.com:13/b' );

  var got = _.weburi.resolve( 'http://www.site.com:13','a', '..', '..', 'b' );
  test.identical( got, 'http://www.site.com:13/../b' );

  var got = _.weburi.resolve( 'http://www.site.com:13','.a.', 'b','.c.' );
  test.identical( got, 'http://www.site.com:13/.a./b/.c.' );

  var got = _.weburi.resolve( 'http://www.site.com:13/','.a.', 'b','.c.' );
  test.identical( got, 'http://www.site.com:13/.a./b/.c.' );

  var got = _.weburi.resolve( 'http://www.site.com:13','a/../' );
  test.identical( got, 'http://www.site.com:13/' );

  var got = _.weburi.resolve( 'http://www.site.com:13/','a/../' );
  test.identical( got, 'http://www.site.com:13/' );

  /* */

  var got = _.weburi.resolve( '://www.site.com:13','a' );
  test.identical( got, '://www.site.com:13/a' );

  var got = _.weburi.resolve( '://www.site.com:13/','a' );
  test.identical( got, '://www.site.com:13/a' );

  var got = _.weburi.resolve( '://www.site.com:13','a', '/b' );
  test.identical( got, '://www.site.com:13/b' );

  var got = _.weburi.resolve( '://www.site.com:13','a', '/b', 'c' );
  test.identical( got, '://www.site.com:13/b/c' );

  var got = _.weburi.resolve( '://www.site.com:13','/a/', '/b/', 'c/', '.' );
  test.identical( got, '://www.site.com:13/b/c' );

  var got = _.weburi.resolve( '://www.site.com:13','a', '.', 'b' );
  test.identical( got, '://www.site.com:13/a/b' );

  var got = _.weburi.resolve( '://www.site.com:13/','a', '.', 'b' );
  test.identical( got, '://www.site.com:13/a/b' );

  var got = _.weburi.resolve( '://www.site.com:13','a', '..', 'b' );
  test.identical( got, '://www.site.com:13/b' );

  var got = _.weburi.resolve( '://www.site.com:13','a', '..', '..', 'b' );
  test.identical( got, '://www.site.com:13/../b' );

  var got = _.weburi.resolve( '://www.site.com:13','.a.', 'b','.c.' );
  test.identical( got, '://www.site.com:13/.a./b/.c.' );

  var got = _.weburi.resolve( '://www.site.com:13/','.a.', 'b','.c.' );
  test.identical( got, '://www.site.com:13/.a./b/.c.' );

  var got = _.weburi.resolve( '://www.site.com:13','a/../' );
  test.identical( got, '://www.site.com:13/' );

  var got = _.weburi.resolve( '://www.site.com:13/','a/../' );
  test.identical( got, '://www.site.com:13/' );

  /* */

  var got = _.weburi.resolve( ':///www.site.com:13','a' );
  test.identical( got, ':///www.site.com:13/a' );

  var got = _.weburi.resolve( ':///www.site.com:13/','a' );
  test.identical( got, ':///www.site.com:13/a' );

  var got = _.weburi.resolve( ':///www.site.com:13','a', '/b' );
  test.identical( got, ':///b' );

  var got = _.weburi.resolve( ':///www.site.com:13','a', '/b', 'c' );
  test.identical( got, ':///b/c' );

  var got = _.weburi.resolve( ':///www.site.com:13','/a/', '/b/', 'c/', '.' );
  test.identical( got, ':///b/c' );

  var got = _.weburi.resolve( ':///www.site.com:13','a', '.', 'b' );
  test.identical( got, ':///www.site.com:13/a/b' );

  var got = _.weburi.resolve( ':///www.site.com:13/','a', '.', 'b' );
  test.identical( got, ':///www.site.com:13/a/b' );

  var got = _.weburi.resolve( ':///www.site.com:13','a', '..', 'b' );
  test.identical( got, ':///www.site.com:13/b' );

  var got = _.weburi.resolve( ':///www.site.com:13','a', '..', '..', 'b' );
  test.identical( got, ':///b' );

  var got = _.weburi.resolve( ':///www.site.com:13','.a.', 'b','.c.' );
  test.identical( got, ':///www.site.com:13/.a./b/.c.' );

  var got = _.weburi.resolve( ':///www.site.com:13/','.a.', 'b','.c.' );
  test.identical( got, ':///www.site.com:13/.a./b/.c.' );

  var got = _.weburi.resolve( ':///www.site.com:13','a/../' );
  test.identical( got, ':///www.site.com:13/' );

  var got = _.weburi.resolve( ':///www.site.com:13/','a/../' );
  test.identical( got, ':///www.site.com:13/' );

  /* */

  var got = _.weburi.resolve( '/some/staging/index.html','a' );
  test.identical( got, '/some/staging/index.html/a' );

  var got = _.weburi.resolve( '/some/staging/index.html','.' );
  test.identical( got, '/some/staging/index.html' );

  var got = _.weburi.resolve( '/some/staging/index.html/','a' );
  test.identical( got, '/some/staging/index.html/a' );

  var got = _.weburi.resolve( '/some/staging/index.html','a', '/b' );
  test.identical( got, '/b' );

  var got = _.weburi.resolve( '/some/staging/index.html','a', '/b', 'c' );
  test.identical( got, '/b/c' );

  var got = _.weburi.resolve( '/some/staging/index.html','/a/', '/b/', 'c/', '.' );
  test.identical( got, '/b/c' );

  var got = _.weburi.resolve( '/some/staging/index.html','a', '.', 'b' );
  test.identical( got, '/some/staging/index.html/a/b' );

  var got = _.weburi.resolve( '/some/staging/index.html/','a', '.', 'b' );
  test.identical( got, '/some/staging/index.html/a/b' );

  var got = _.weburi.resolve( '/some/staging/index.html','a', '..', 'b' );
  test.identical( got, '/some/staging/index.html/b' );

  var got = _.weburi.resolve( '/some/staging/index.html','a', '..', '..', 'b' );
  test.identical( got, '/some/staging/b' );

  var got = _.weburi.resolve( '/some/staging/index.html','.a.', 'b','.c.' );
  test.identical( got, '/some/staging/index.html/.a./b/.c.' );

  var got = _.weburi.resolve( '/some/staging/index.html/','.a.', 'b','.c.' );
  test.identical( got, '/some/staging/index.html/.a./b/.c.' );

  var got = _.weburi.resolve( '/some/staging/index.html/','a/../' );
  test.identical( got, '/some/staging/index.html/' );

  var got = _.weburi.resolve( '/some/staging/index.html/','a/../' );
  test.identical( got, '/some/staging/index.html/' );

  var got = _.weburi.resolve( '//some/staging/index.html', '.', 'a' );
  test.identical( got, '//some/staging/index.html/a' );

  var got = _.weburi.resolve( '///some/staging/index.html', 'a', '.', 'b', '..' );
  test.identical( got, '///some/staging/index.html/a' );

  var got = _.weburi.resolve( 'file:///some/staging/index.html', '../..' );
  test.identical( got, 'file:///some' );

  var got = _.weburi.resolve( 'svn+https://user@subversion.com/svn/trunk', '../a', 'b', '../c' );
  test.identical( got, 'svn+https://user@subversion.com/svn/a/c' );

  var got = _.weburi.resolve( 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor', '../../path/name' );
  test.identical( got, 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor' )

  var got = _.weburi.resolve( 'https://web.archive.org/web/*\/http://www.heritage.org/index/ranking', '../../../a.com' );
  test.identical( got, 'https://web.archive.org/web/*\/http://a.com' )

  var got = _.weburi.resolve( '127.0.0.1:61726', '../path'  );
  test.identical( got, _.weburi.join( _.weburi.current(), 'path' ) )

  // '127.0.0.1:///C/pro/web/Dave/git/trunk/path'

  var got = _.weburi.resolve( 'http://127.0.0.1:61726', '../path'  );
  test.identical( got, 'http://127.0.0.1:61726/../path' )

  /* */

  test.case = 'works like resolve';

  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo';
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  'aa','.','cc' ];
  var expected = _.weburi.join( _.weburi.current(),'aa/cc' );
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  'aa','cc','.' ];
  var expected = _.weburi.join( _.weburi.current(),'aa/cc' )
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '.','aa','cc' ];
  var expected = _.weburi.join( _.weburi.current(),'aa/cc' )
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '.','aa','cc','..' ];
  var expected = _.weburi.join( _.weburi.current(),'aa' )
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '.','aa','cc','..','..' ];
  var expected = _.weburi.current();
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  'aa','cc','..','..','..' ];
  var expected = _.weburi.resolve( _.weburi.current(),'..' );
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '.x.','aa','bb','.x.' ];
  var expected = _.weburi.join( _.weburi.current(),'.x./aa/bb/.x.' );
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '..x..','aa','bb','..x..' ];
  var expected = _.weburi.join( _.weburi.current(),'..x../aa/bb/..x..' );
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/abc','./../a/b' ];
  var expected = '/a/b';
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/abc','a/.././a/b' ];
  var expected = '/abc/a/b';
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/abc','.././a/b' ];
  var expected = '/a/b';
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/abc','./.././a/b' ];
  var expected = '/a/b';
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/abc','./../.' ];
  var expected = '/';
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/abc','./../../.' ];
  var expected = '/..';
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );

  var paths = [  '/abc','./../.' ];
  var expected = '/';
  var got = _.weburi.resolve.apply( _.weburi, paths );
  test.identical( got, expected );
}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l4.WebUriFundamentals',
  silencing : 1,

  tests :
  {

    join,
    joinRaw,
    resolve,

  },

}

Self = wTestSuite( Self );

if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self );

})();
