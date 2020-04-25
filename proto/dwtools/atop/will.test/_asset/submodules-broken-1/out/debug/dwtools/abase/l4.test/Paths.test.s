( function _Paths_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../dwtools/Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wStringer' );
  _.include( 'wColor' );

  // _.include( 'wFiles' );

  require( '../l3/PathsBasic.s' );

}

var _global = _global_;
var _ = _global_.wTools;

/*
qqq : fix style problems and non-style problems in the test | Dmytro : fixed
*/

// --
//
// --

function refine( test )
{
  test.case = 'posix path';
  var src =
  [
    '/foo/bar//baz/asdf/quux/..',
    '/foo/bar//baz/asdf/quux/../',
    '//foo/bar//baz/asdf/quux/..//',
    'foo/bar//baz/asdf/quux/..//.',
  ];
  var expected =
  [
    '/foo/bar//baz/asdf/quux/..',
    '/foo/bar//baz/asdf/quux/../',
    '//foo/bar//baz/asdf/quux/..//',
    'foo/bar//baz/asdf/quux/..//.'
  ];
  test.identical( _.paths.refine( src ), expected );

  /* */

  test.case = 'windows path';
  var src =
  [
    'C:\\temp\\\\foo\\bar\\..\\',
    'C:\\temp\\\\foo\\bar\\..\\\\',
    'C:\\temp\\\\foo\\bar\\..\\\\.',
    'C:\\temp\\\\foo\\bar\\..\\..\\',
    'C:\\temp\\\\foo\\bar\\..\\..\\.'
  ];
  var expected =
  [
    '/C/temp//foo/bar/../',
    '/C/temp//foo/bar/..//',
    '/C/temp//foo/bar/..//.',
    '/C/temp//foo/bar/../../',
    '/C/temp//foo/bar/../../.'
  ];
  test.identical( _.paths.refine( src ), expected );

  /* */

  test.case = 'empty path';
  var src =
  [
    '',
    '/',
    '//',
    '///',
    '/.',
    '/./.',
    '.',
    './.'
  ];
  var expected =
  [
    '',
    '/',
    '//',
    '///',
    '/.',
    '/./.',
    '.',
    './.'
  ];
  test.identical( _.paths.refine( src ), expected );

  /* */

  test.case = 'path with "." in the middle';
  var src =
  [
    'foo/./bar/baz',
    'foo/././bar/baz/',
    'foo/././bar/././baz/',
    '/foo/././bar/././baz/'
  ];
  var expected =
  [
    'foo/./bar/baz',
    'foo/././bar/baz/',
    'foo/././bar/././baz/',
    '/foo/././bar/././baz/'
  ];
  test.identical( _.paths.refine( src ), expected );

  /* */

  test.case = 'path with "." in the beginning';
  var src =
  [
    './foo/bar',
    '././foo/bar/',
    './/.//foo/bar/',
    '/.//.//foo/bar/',
    '.x/foo/bar',
    '.x./foo/bar'
  ];
  var expected =
  [
    './foo/bar',
    '././foo/bar/',
    './/.//foo/bar/',
    '/.//.//foo/bar/',
    '.x/foo/bar',
    '.x./foo/bar'
  ];
  test.identical( _.paths.refine( src ), expected );

  /* */

  test.case = 'path with "." in the end';
  var src =
  [
    'foo/bar.',
    'foo/.bar.',
    'foo/bar/.',
    'foo/bar/./.',
    'foo/bar/././',
    '/foo/bar/././'
  ];
  var expected =
  [
    'foo/bar.',
    'foo/.bar.',
    'foo/bar/.',
    'foo/bar/./.',
    'foo/bar/././',
    '/foo/bar/././'
  ];
  test.identical( _.paths.refine( src ), expected );

  /* */

  test.case = 'path with ".." in the middle';
  var src =
  [
    'foo/../bar/baz',
    'foo/../../bar/baz/',
    'foo/../../bar/../../baz/',
    '/foo/../../bar/../../baz/',
  ];
  var expected =
  [
    'foo/../bar/baz',
    'foo/../../bar/baz/',
    'foo/../../bar/../../baz/',
    '/foo/../../bar/../../baz/'
  ];
  test.identical( _.paths.refine( src ), expected );

  /* */

  test.case = 'path with ".." in the beginning';
  var src =
  [
    '../foo/bar',
    '../../foo/bar/',
    '..//..//foo/bar/',
    '/..//..//foo/bar/',
    '..x/foo/bar',
    '..x../foo/bar'
  ];
  var expected =
  [
    '../foo/bar',
    '../../foo/bar/',
    '..//..//foo/bar/',
    '/..//..//foo/bar/',
    '..x/foo/bar',
    '..x../foo/bar'
  ];
  test.identical( _.paths.refine( src ), expected );

  /* */

  test.case = 'path with ".." in the end';
  var src =
  [
    'foo/bar..',
    'foo/..bar..',
    'foo/bar/..',
    'foo/bar/../..',
    'foo/bar/../../',
    '/foo/bar/../../'
  ];
  var expected =
  [
    'foo/bar..',
    'foo/..bar..',
    'foo/bar/..',
    'foo/bar/../..',
    'foo/bar/../../',
    '/foo/bar/../../'
  ];
  test.identical( _.paths.refine( src ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.paths.refine() );
  test.shouldThrowErrorSync( () => _.paths.refine( [ 'C:\\' ], [ 'foo/bar/./' ] ) );
  test.shouldThrowErrorSync( () => _.paths.refine( [ 1, 2 ] ) );
}

//

function normalize( test )
{
  test.case = 'posix path';
  var src =
  [
    '/foo/bar//baz/asdf/quux/..',
    '/foo/bar//baz/asdf/quux/../',
    '//foo/bar//baz/asdf/quux/..//',
    'foo/bar//baz/asdf/quux/..//.'
  ];
  var expected =
  [
    '/foo/bar//baz/asdf',
    '/foo/bar//baz/asdf/',
    '//foo/bar//baz/asdf//',
    'foo/bar//baz/asdf/'
  ];
  test.identical( _.paths.normalize( src ), expected );

  /* */

  test.case = 'windows path';
  var src =
  [
    'C:\\temp\\\\foo\\bar\\..\\',
    'C:\\temp\\\\foo\\bar\\..\\\\',
    'C:\\temp\\\\foo\\bar\\..\\..\\',
    'C:\\temp\\\\foo\\bar\\..\\..\\.'
  ];
  var expected =
  [
    '/C/temp//foo/',
    '/C/temp//foo//',
    '/C/temp//',
    '/C/temp/'
  ];
  test.identical( _.paths.normalize( src ), expected );

  /* */

  test.case = 'empty path';
  var src =
  [
    '',
    '/',
    '//',
    '///',
    '/.',
    '/./.',
    '.',
    './.'
  ];
  var expected =
  [
    '',
    '/',
    '//',
    '///',
    '/',
    '/',
    '.',
    '.'
  ];
  test.identical( _.paths.normalize( src ), expected );

  /* */

  test.case = 'path with "." in the middle';
  var src =
  [
    'foo/./bar/baz',
    'foo/././bar/baz/',
    'foo/././bar/././baz/',
    '/foo/././bar/././baz/',
    '/foo/.x./baz/'
  ];
  var expected =
  [
    'foo/bar/baz',
    'foo/bar/baz/',
    'foo/bar/baz/',
    '/foo/bar/baz/',
    '/foo/.x./baz/'
  ];
  test.identical( _.paths.normalize( src ), expected );

  /* */

  test.case = 'path with combination of "." and ".." in the middle';
  var src =
  [
    'foo/./bar/../baz',
    'foo/././bar/baz/../',
    'foo/././bar/././baz/../asdf/',
    '/foo/././../bar/././baz/',
    '/foo/.x../baz/'
  ];
  var expected =
  [
    'foo/baz',
    'foo/bar/',
    'foo/bar/asdf/',
    '/bar/baz/',
    '/foo/.x../baz/'
  ];
  test.identical( _.paths.normalize( src ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.paths.normalize() );
  test.shouldThrowErrorSync( () => _.paths.normalize( [ 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.paths.normalize( [ 'foo/bar' ], [ 'foo' ] ) );
}

//

function dot( test )
{
  test.case = 'add ./ prefix to path';
  var src = [ '', 'a', '.', '.a', './a', '..', '..a', '../a'  ];
  var expected = [ './', './a', '.', './.a', './a', '..', './..a', '../a' ];
  test.identical( _.paths.dot( src ), expected );

  test.case = 'add ./ prefix to key';
  var src = [ './', './a', '.', './.a', './a', '..', './..a', '../a', 'a', '/a' ];
  var expected = [ './', 'a', '.', '.a', 'a', '..', '..a', '../a', 'a', '/a' ];
  test.identical( _.paths.undot( src ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.paths.dot() );
  test.shouldThrowErrorSync( () => _.paths.dot( [ 'a/', 'b' ], [ 'c/.' ] ) );
  test.shouldThrowErrorSync( () => _.paths.dot( [ '/' ] ) );
  test.shouldThrowErrorSync( () => _.paths.dot( [ '/a' ] ) );
}

//

function undot( test )
{
  test.case = 'rm ./ prefix from path';
  var src = [ './', './a', '.', './.a', './a', '..', './..a', '../a', 'a', '/a' ];
  var expected = [ './', 'a', '.', '.a', 'a', '..', '..a', '../a', 'a', '/a' ];
  test.identical( _.paths.undot( src ), expected );

  test.case = 'rm ./ prefix from path';
  var src = { './' : 1, './a' : 1, '.' : 1, './.a' : 1, './a' : 1, '..' : 1, './..a' : 1, '../a' : 1 };
  var expected = { './' : 1, 'a' : 1, '.' : 1, '.a': 1, '..': 1, '..a': 1, '../a': 1 };
  test.identical( _.paths.undot( src ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.paths.undot() );
  test.shouldThrowErrorSync( () => _.paths.undot( [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.paths.undot( true ) );
}

//

function dir( test )
{
  test.case = 'simple absolute path';
  test.identical( _.paths.dir( [ '/foo' ] ), [ '/' ] );

  test.case = 'absolute path : nested dirs';
  var src =
  [
    '/foo/bar/baz/text.txt',
    '/aa/bb',
    '/aa/bb/',
    '/aa',
    '/'
  ];
  var expected =
  [
    '/foo/bar/baz',
    '/aa',
    '/aa/',
    '/',
    '/..'
  ];
  test.identical( _.paths.dir( src ), expected );

  test.case = 'relative path : nested dirs';
  var src =
  [
    'aa/bb',
    'aa',
    '.',
    '..'
  ];
  var expected =
  [
    'aa',
    '.',
    '..',
    '../..'
  ];
  test.identical( _.paths.dir( src ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorOfAnyKind( () => _.paths.dir() );

  test.case = 'inner array';
  test.shouldThrowErrorOfAnyKind( () => _.paths.dir( [ './a/../b', [ 'a/b/c' ] ]) );

  test.case = 'two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.paths.dir( [ '/aa/b' ], [ 'b/c' ] ) );

  test.case = 'not a string, empty string';
  test.shouldThrowErrorOfAnyKind( () => _.paths.dir( [ 'aa/bb', 1 ] ) );
  test.shouldThrowErrorOfAnyKind( () => _.paths.dir( [ '' ] ) );
}

//

function prefixGet( test )
{
  test.case = 'get path without ext';
  var src =
  [
    '',
    'some.txt',
    '/foo/bar/baz.asdf',
    '/foo/bar/.baz',
    '/foo.coffee.md',
    '/foo/bar/baz'
  ];
  var expected =
  [
    '',
    'some',
    '/foo/bar/baz',
    '/foo/bar/',
    '/foo',
    '/foo/bar/baz'
  ];
  test.identical( _.paths.prefixGet( src ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.paths.prefixGet() );
  test.shouldThrowErrorSync( () => _.paths.prefixGet( [ 'aa/bb/file.txt',  1 ] ) );

  test.case = 'inner array';
  test.shouldThrowErrorSync( () => _.paths.prefixGet( [ 'a/b/file.txt', [ '/a/d/file.js' ] ] ) );

  test.case = 'two arguments';
  test.shouldThrowErrorSync( () => _.paths.prefixGet( [ 'a/b/file.txt' ], [ 'a/c/file.js' ] ) );
}

//

function name( test )
{
  test.case = 'get paths name';
  var src =
  [
    '',
    'some.txt',
    '/foo/bar/baz.asdf',
    '/foo/bar/.baz',
    '/foo.coffee.md',
    '/foo/bar/baz'
  ];
  var expected =
  [
    '',
    'some',
    'baz',
    '',
    'foo.coffee',
    'baz'
  ];
  test.identical( _.paths.name( src ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.paths.name() );
  test.shouldThrowErrorSync( () => _.paths.name( [ 'aa/bb/file.txt',  1 ] ) );

  test.case = 'inner array';
  test.shouldThrowErrorSync( () => _.paths.name( [ 'a/b/file.txt', [ '/a/d/file.js' ] ] ) );

  test.case = 'two arguments';
  test.shouldThrowErrorSync( () => _.paths.name( [ 'a/b/file.txt' ], [ 'a/c/file.js' ] ) );
}

//

function fullName( test )
{
  test.case = 'get paths name with extension';
  var src =
  [
    '',
    'some.txt',
    '/foo/bar/baz.asdf',
    '/foo/bar/.baz',
    '/foo.coffee.md',
    '/foo/bar/baz'
  ];
  var expected =
  [
    '',
    'some.txt',
    'baz.asdf',
    '.baz',
    'foo.coffee.md',
    'baz'
  ];
  test.identical( _.paths.fullName( src ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.paths.fullName() );
  test.shouldThrowErrorSync( () => _.paths.fullName( [ 'aa/bb/file.txt',  1 ] ) );

  test.case = 'inner array';
  test.shouldThrowErrorSync( () => _.paths.fullName( [ 'a/b/file.txt', [ '/a/d/file.js' ] ] ) );

  test.case = 'two arguments';
  test.shouldThrowErrorSync( () => _.paths.fullName( [ 'a/b/file.txt' ], [ 'a/c/file.js' ] ) );
}

//

function ext( test )
{
  test.case = 'absolute path : nested dirs';
  var src =
  [
    'some.txt',
    '/foo/bar/baz.asdf',
    '/foo/bar/.baz',
    '/foo.coffee.md',
    '/foo/bar/baz',
    '/foo/bar/baz/'
  ];
  var expected =
  [
    'txt',
    'asdf',
    '',
    'md',
    '',
    ''
  ];
  test.identical( _.paths.ext( src ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.paths.ext() );
  test.shouldThrowErrorSync( () => _.paths.ext( [ 'aa/bb/file',  1 ] ) );

  test.case = 'inner array';
  test.shouldThrowErrorSync( () => _.paths.ext( [ 'file.txt', [ 'file.js' ] ] ) );

  test.case = 'two arguments';
  test.shouldThrowErrorSync( () => _.paths.ext( [ 'file.txt' ], [ 'file.js' ] ) );
}

//

function withoutExt( test )
{
  test.case = 'get paths without extension';
  var src =
  [
    '',
    'some.txt',
    '/foo/bar/baz.asdf',
    '/foo/bar/.baz',
    '/foo.coffee.md',
    '/foo/bar/baz',
    './foo/.baz',
    './.baz',
    '.baz.txt',
    './baz.txt',
    './foo/baz.txt',
    './foo/',
    'baz',
    'baz.a.b'
  ];
  var expected =
  [
    '',
    'some',
    '/foo/bar/baz',
    '/foo/bar/.baz',
    '/foo.coffee',
    '/foo/bar/baz',
    './foo/.baz',
    './.baz',
    '.baz',
    './baz',
    './foo/baz',
    './foo/',
    'baz',
    'baz.a'
  ];
  test.identical( _.paths.withoutExt( src ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.paths.withoutExt() );
  test.shouldThrowErrorSync( () => _.paths.withoutExt( [ 'aa/bb/file.txt',  1 ] ) );

  test.case = 'inner array';
  test.shouldThrowErrorSync( () => _.paths.withoutExt( [ 'a/b/file.txt', [ '/a/d/file.js' ] ] ) );

  test.case = 'two arguments';
  test.shouldThrowErrorSync( () => _.paths.withoutExt( [ 'a/b/file.txt' ], [ 'a/c/file.js' ] ) );
}

//

function changeExt( test )
{
  test.case = 'change paths extension ';
  var src =
  [
    'some.txt',
    'some.txt',
    '/foo/bar/baz.asdf',
    '/foo/bar/.baz',
    '/foo.coffee.md',
    '/foo/bar/baz',
    '/foo/baz.bar/some.md',
    './foo/.baz',
    './.baz',
    '.baz',
    './baz',
    './foo/baz',
    './foo/'
  ];
  var ext =
  [
    '',
    'json',
    'txt',
    'sh',
    'min',
    'txt',
    'txt',
    'txt',
    'txt',
    'txt',
    'txt',
    'txt',
    'txt'
  ];
  var expected =
  [
    'some',
    'some.json',
    '/foo/bar/baz.txt',
    '/foo/bar/.baz.sh',
    '/foo.coffee.min',
    '/foo/bar/baz.txt',
    '/foo/baz.bar/some.txt',
    './foo/.baz.txt',
    './.baz.txt',
    '.baz.txt',
    './baz.txt',
    './foo/baz.txt',
    './foo/.txt'
  ];
  test.identical( _.paths.changeExt( src, ext ), expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'not argument';
  test.shouldThrowErrorSync( () => _.paths.changeExt() );

  test.case = 'argument is not string';
  test.shouldThrowErrorSync( () => _.paths.changeExt( [ 1 ], [ 'txt' ] ) );
  test.shouldThrowErrorSync( () => _.paths.changeExt( [ 'a/b/file.txt' ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.paths.changeExt( [ 'a/b/file.txt' ], [ 'txt' ], [ 1 ] ) );

  test.case = 'many arguments';
  test.shouldThrowErrorSync( () => _.paths.changeExt( [ 'a/b/file.txt' ], [ 'txt' ], [ 'sh' ], [ 'arg' ] ) );

  test.case = 'inner array';
  test.shouldThrowErrorSync( () => _.paths.changeExt( [ 'a/b.txt', [ 'ab.txt'] ], [ 'txt' ] ) );
}

//

function join( test )
{
  test.case = 'join windows os paths';

  var got = _.paths.join( '/a', [ 'c:\\', 'foo\\', 'bar\\' ] );
  var expected = [ '/c', '/a/foo/', '/a/bar/' ];
  test.identical( got, expected );

  var got = _.paths.join( '/a', [ 'c:\\', 'foo\\', 'bar\\' ], 'd' );
  var expected = [ '/c/d', '/a/foo/d', '/a/bar/d' ];
  test.identical( got, expected );

  var got = _.paths.join( 'c:\\', [ 'a', 'b', 'c' ], 'd' );
  var expected = [ '/c/a/d', '/c/b/d', '/c/c/d' ];
  test.identical( got, expected );

  var got = _.paths.join( 'c:\\', [ '../a', './b', '..c' ] );
  var expected = [ '/a', '/c/b', '/c/..c' ];
  test.identical( got, expected );

  test.case = 'join unix os paths';

  var got = _.paths.join( '/a', [ 'b', 'c' ], 'd', 'e' );
  var expected = [ '/a/b/d/e', '/a/c/d/e' ];
  test.identical( got, expected );

  var got = _.paths.join( [ '/a', '/b', '/c' ], 'e' );
  var expected = [ '/a/e', '/b/e', '/c/e' ];
  test.identical( got, expected );

  var got = _.paths.join( [ '/a', '/b', '/c' ], [ '../a', '../b', '../c' ], [ './a', './b', './c' ] );
  var expected = [ '/a/a', '/b/b', '/c/c' ];
  test.identical( got, expected );

  var got = _.paths.join( [ 'a', 'b', 'c' ], [ 'a1', 'b1', 'c1' ], [ 'a2', 'b2', 'c2' ] );
  var expected = [ 'a/a1/a2', 'b/b1/b2', 'c/c1/c2' ];
  test.identical( got, expected );

  var got = _.paths.join( [ '/a', '/b', '/c' ], [ '../a', '../b', '../c' ], [ './a', './b', './c' ] );
  var expected = [ '/a/a', '/b/b', '/c/c' ];
  test.identical( got, expected );

  var got = _.paths.join( [ '/', '/a', '//a' ], [ '//', 'a//', 'a//a' ], 'b' );
  var expected = [ '//b', '/a/a//b', '//a/a//a/b' ];
  test.identical( got, expected );

  //

  test.case = 'works like join';

  var got = _.paths.join( '/a' );
  var expected = _.path.join( '/a' );
  test.identical( got, expected );

  var got = _.paths.join( '/a', 'd', 'e' );
  var expected = _.path.join( '/a', 'd', 'e' );
  test.identical( got, expected );

  var got = _.paths.join( '/a', '../a', './c' );
  var expected = _.path.join( '/a', '../a', './c' );
  test.identical( got, expected );

  //

  test.case = 'scalar + array with single argument';

  var got = _.paths.join( '/a', [ 'b' ] );
  var expected = [ '/a/b' ];
  test.identical( got, expected );

  test.case = 'array + array with single arguments';

  var got = _.paths.join( [ '/a' ], [ 'b' ] );
  var expected = [ '/a/b' ];
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'arrays with different length';
  test.shouldThrowErrorOfAnyKind( () => _.paths.join( [ '/b', '.c' ], [ '/b' ] ) );

  test.case = 'numbers';
  test.shouldThrowErrorOfAnyKind( () => _.paths.join( [ 1, 2 ] ) );

  // test.case = 'nothing passed';
  // test.shouldThrowErrorSync( () => _.paths.join( ) );
  //
  // test.case = 'object passed';
  // test.shouldThrowErrorSync( () => _.paths.join( {} ) );

  test.case = 'inner arrays';
  test.shouldThrowErrorOfAnyKind( () => _.paths.join( [ '/b', '.c' ], [ '/b', [ 'x' ] ] ) );
}

//

function reroot( test )
{
  test.case = 'paths reroot';

  var got = _.paths.reroot( 'a', [ '/a', 'b' ] );
  var expected = [ 'a/a', 'a/b' ];
  test.identical( got, expected );

  var got = _.paths.reroot( [ '/a', '/b' ], [ '/a', '/b' ] );
  var expected = [ '/a/a', '/b/b' ];
  test.identical( got, expected );

  var got = _.paths.reroot( '../a', [ '/b', '.c' ], './d' );
  var expected = [ '../a/b/d', '../a/.c/d' ]
  test.identical( got, expected );

  var got = _.paths.reroot( [ '/a' , '/a' ] );
  var expected = [ '/a' , '/a' ];
  test.identical( got, expected );

  var got = _.paths.reroot( '.', '/', './', [ 'a', 'b' ] );
  var expected = [ './a', './b' ];
  test.identical( got, expected );

  //

  test.case = 'scalar + scalar';

  var got = _.paths.reroot( '/a', '/a' );
  var expected = '/a/a';
  test.identical( got, expected );

  test.case = 'scalar + array with single argument';

  var got = _.paths.reroot( '/a', [ '/b' ] );
  var expected = [ '/a/b' ];
  test.identical( got, expected );

  test.case = 'array + array with single arguments';

  var got = _.paths.reroot( [ '/a' ], [ '/b' ] );
  var expected = [ '/a/b' ];
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'arrays with different length';
  test.shouldThrowErrorOfAnyKind( () => _.paths.reroot( [ '/b', '.c' ], [ '/b' ] ) );

  test.case = 'inner arrays';
  test.shouldThrowErrorOfAnyKind( () => _.paths.reroot( [ '/b', '.c' ], [ '/b', [ 'x' ] ] ) );

  test.case = 'numbers';
  test.shouldThrowErrorOfAnyKind( () => _.paths.reroot( [ 1, 2 ] ) );
}

//

function resolve( test )
{

  test.case = 'paths resolve';

  var got = _.paths.resolve( 'c', [ '/a', 'b' ] );
  var expected = [ '/a', _.path.join( _.path.current(), 'c/b' ) ];
  test.identical( got, expected );

  var got = _.paths.resolve( [ '/a', '/b' ], [ '/a', '/b' ] );
  var expected = [ '/a', '/b' ];
  test.identical( got, expected );

  var got = _.paths.resolve( '../a', [ 'b', '.c' ] );
  var expected = [ _.path.dirFirst( _.path.current() ) + 'a/b', _.path.dirFirst( _.path.current() ) + 'a/.c' ]
  test.identical( got, expected );

  var got = _.paths.resolve( '../a', [ '/b', '.c' ], './d' );
  var expected = [ '/b/d', _.path.dirFirst( _.path.current() ) + 'a/.c/d' ];
  test.identical( got, expected );

  var got = _.paths.resolve( [ '/a', '/a' ],[ 'b', 'c' ] );
  var expected = [ '/a/b' , '/a/c' ];
  test.identical( got, expected );

  var got = _.paths.resolve( [ '/a', '/a' ],[ 'b', 'c' ], 'e' );
  var expected = [ '/a/b/e' , '/a/c/e' ];
  test.identical( got, expected );

  var got = _.paths.resolve( [ '/a', '/a' ],[ 'b', 'c' ], '/e' );
  var expected = [ '/e' , '/e' ];
  test.identical( got, expected );

  var got = _.paths.resolve( '.', '../', './', [ 'a', 'b' ] );
  var expected = [ _.path.dirFirst( _.path.current() ) + 'a', _.path.dirFirst( _.path.current() ) + 'b' ];
  test.identical( got, expected );

  //

  test.case = 'works like resolve';

  var got = _.paths.resolve( '/a', 'b', 'c' );
  var expected = _.path.resolve( '/a', 'b', 'c' );
  test.identical( got, expected );

  var got = _.paths.resolve( '/a', 'b', 'c' );
  var expected = _.path.resolve( '/a', 'b', 'c' );
  test.identical( got, expected );

  var got = _.paths.resolve( '../a', '.c' );
  var expected = _.path.resolve( '../a', '.c' );
  test.identical( got, expected );

  var got = _.paths.resolve( '/a' );
  var expected = _.path.resolve( '/a' );
  test.identical( got, expected );

  var got = _.paths.resolve( 'b' );
  var expected = _.path.join( _.path.current(), 'b' );
  test.identical( got, expected );

  var got = _.paths.resolve( './b' );
  var expected = _.path.join( _.path.current(), 'b' );
  test.identical( got, expected );

  var got = _.paths.resolve( '../b' );
  var expected = _.path.join( _.path.dir( _.path.current() ), 'b' );
  test.identical( got, expected );

  var got = _.paths.resolve( '..' );
  var expected = _.path.join( _.path.current(), '..' );
  test.identical( got, expected );

  // if( _.module.isIncluded( 'wFiles' ) )
  // {
  //   var got = _.paths.resolve( '..' );
  //   var expected = '/..';
  //   test.identical( got, expected );
  // }
  // else
  // {
  //   var got = _.paths.resolve( '..' );
  //   var expected = '/..';
  //   test.identical( got, expected );
  // }

  /* */

  test.case = 'scalar + array with single argument';
  var got = _.paths.resolve( '/a', [ 'b/..' ] );
  var expected = [ '/a' ];
  test.identical( got, expected );

  test.case = 'array + array with single arguments';
  var got = _.paths.resolve( [ '/a' ], [ 'b/../' ] );
  var expected = [ '/a/' ];
  test.identical( got, expected );

  test.case = 'single array';
  var got = _.paths.resolve( [ '/a', 'b', './b', '../b', '..' ] );
  var expected =
  [
    '/a',
    _.path.join( _.path.current(), 'b' ),
    _.path.join( _.path.current(), 'b' ),
    _.path.join( _.path.dir( _.path.current() ), 'b' ),
    _.path.dir( _.path.current() ),
  ];
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return

  test.case = 'arrays with different length';
  test.shouldThrowErrorOfAnyKind( () => _.paths.resolve( [ '/b', '.c' ], [ '/b' ] ) );

  test.case = 'empty';
  test.shouldThrowErrorOfAnyKind( () => _.paths.resolve() );

  test.case = 'inner arrays';
  test.shouldThrowErrorOfAnyKind( () => _.paths.resolve( [ '/b', '.c' ], [ '/b', [ 'x' ] ] ) );
}

//

////
// path transformer
////

function from( test )
{
  test.case = 'scalar';
  var expected = 'a/b';
  var got = _.path.s.from( 'a/b' );
  test.identical( got, expected );

  test.case = 'array';
  var expected = [ 'a/b', '/c/d' ];
  var got = _.path.s.from( [ 'a/b', '/c/d' ] );
  test.identical( got, expected );

  test.case = 'empty array';
  var expected = [];
  var got = _.path.s.from( [] );
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.path.s.from() );
  test.shouldThrowErrorSync( () => _.path.s.from( [ 0 ] ) );
  test.shouldThrowErrorSync( () => _.path.s.from( [ 'a/b' ], [ 'b/c'] ) );
  test.shouldThrowErrorSync( () => _.path.s.from( null ) );
}

//

function relative( test )
{
  test.case = 'relative to array of paths';
  var from = '/foo/bar/baz/asdf/quux/dir1/dir2';
  var to =
  [
    '/foo/bar/baz/asdf/quux/dir1/dir2',
    '/foo/bar/baz/asdf/quux/dir1/',
    '/foo/bar/baz/asdf/quux/',
    '/foo/bar/baz/asdf/quux/dir1/dir2/dir3',
  ];
  var expected = [ '.', '../', '../../', 'dir3' ];
  test.identical( _.paths.relative( from, to), expected );

  /* */

  test.case = 'works like relative';

  var got = _.paths.relative( '/aa/bb/cc', '/aa/bb/cc' );
  var expected = _.path.relative( '/aa/bb/cc', '/aa/bb/cc' );
  test.identical( got, expected );

  var got = _.paths.relative( '/foo/bar/baz/asdf/quux', '/foo/bar/baz/asdf/quux/new1' );
  var expected = _.path.relative( '/foo/bar/baz/asdf/quux', '/foo/bar/baz/asdf/quux/new1' );
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  /* */

  test.case = 'relative to array of paths, one of paths is relative, resolving off';
  var from = '/foo/bar/baz/asdf/quux/dir1/dir2';
  var to =
  [
    '/foo/bar/baz/asdf/quux/dir1/',
    './foo/bar/baz/asdf/quux/',
    '/foo/bar/baz/asdf/quux/dir1/dir2/dir3',
  ];
  test.shouldThrowErrorSync( () => _.paths.relative( from, to ) );

  test.case = 'only relative';
  test.shouldThrowErrorSync( () => _.paths.relative( '/foo/bar/baz/asdf/quux' ) );
  test.shouldThrowErrorSync( () => _.paths.relative( { relative : '/foo/bar/baz/asdf/quux'} ) );

  /* */

  test.case = 'using map options';
  var from = '/foo/bar/baz/asdf/quux/dir1/dir2';
  var to =
  [
    '/foo/bar/baz/asdf/quux/dir1/dir2',
    '/foo/bar/baz/asdf/quux/dir1/',
    '/foo/bar/baz/asdf/quux/dir1/dir2/dir3',
  ];
  test.shouldThrowErrorSync( () => _.paths.relative( [ { basePath : from, filePath : to } ] ) );

  test.case = 'different length';
  test.shouldThrowErrorSync( () => _.paths.relative( [ '/a1/b' ], [ '/a1','/a2' ] ) );
}

//

function common( test )
{
  test.case = 'empty';

  var got = _.path.s.common();
  test.identical( got, null );

  var got = _.path.s.common([]);
  test.identical( got, [] );

  test.case = 'array';

  var got = _.path.s.common([ '/a1/b2', '/a1/b' ]);
  test.identical( got, [ '/a1/b2', '/a1/b' ] );

  var got = _.path.s.common( [ '/a1/b1/c', '/a1/b1/d' ], '/a1/b2' );
  test.identical( got, [ '/a1/', '/a1/' ] );

  test.case = 'absolute-absolute';

  var got = _.path.s.common( '/a1/b2', '/a1/b' );
  test.identical( got, '/a1/' );

  var got = _.path.s.common( '/a1/b2', '/a1/b1' );
  test.identical( got, '/a1/' );

  var got = _.path.s.common( '/a1/x/../b1', '/a1/b1' );
  test.identical( got, '/a1/b1' );

  var got = _.path.s.common( '/a1/b1/c1', '/a1/b1/c' );
  test.identical( got, '/a1/b1/' );

  var got = _.path.s.common( '/a1/../../b1/c1', '/a1/b1/c1' );
  test.identical( got, '/' );

  var got = _.path.s.common( '/abcd', '/ab' );
  test.identical( got, '/' );

  var got = _.path.s.common( '/.a./.b./.c.', '/.a./.b./.c' );
  test.identical( got, '/.a./.b./' );

  var got = _.path.s.common( '//a//b//c', '/a/b' );
  test.identical( got, '/' );

  var got = _.path.s.common( '/a//b', '/a//b' );
  test.identical( got, '/a//b' );

  var got = _.path.s.common( '/a//', '/a//' );
  test.identical( got, '/a//' );

  var got = _.path.s.common( '/./a/./b/./c', '/a/b' );
  test.identical( got, '/a/b' );

  var got = _.path.s.common( '/A/b/c', '/a/b/c' );
  test.identical( got, '/' );

  var got = _.path.s.common( '/', '/x' );
  test.identical( got, '/' );

  var got = _.path.s.common( '/a', '/x'  );
  test.identical( got, '/' );

  test.case = 'array';

  var got = _.path.s.common([ '/a1/b2', '/a1/b' ]);
  test.identical( got, [ '/a1/b2', '/a1/b' ] );

  var got = _.path.s.common( [ '/a1/b2', '/a1/b' ], '/a1/c' );
  test.identical( got, [ '/a1/', '/a1/' ] );

  var got = _.path.s.common( [ './a1/b2', './a1/b' ], './a1/c' );
  test.identical( got, [ 'a1/', 'a1/' ] );

  test.case = 'absolute-relative'

  var got = _.path.s.common( '/', '..' );
  test.identical( got, '/' );

  var got = _.path.s.common( '/', '.' );
  test.identical( got, '/' );

  var got = _.path.s.common( '/', 'x' );
  test.identical( got, '/' );

  var got = _.path.s.common( '/', '../..' );
  test.identical( got, '/' );

  test.case = 'relative-relative'

  var got = _.path.s.common( 'a1/b2', 'a1/b' );
  test.identical( got, 'a1/' );

  var got = _.path.s.common( 'a1/b2', 'a1/b1' );
  test.identical( got, 'a1/' );

  var got = _.path.s.common( 'a1/x/../b1', 'a1/b1' );
  test.identical( got, 'a1/b1' );

  var got = _.path.s.common( './a1/x/../b1', 'a1/b1' );
  test.identical( got,'a1/b1' );

  var got = _.path.s.common( './a1/x/../b1', './a1/b1' );
  test.identical( got, 'a1/b1');

  var got = _.path.s.common( './a1/x/../b1', '../a1/b1' );
  test.identical( got, '..');

  var got = _.path.s.common( '.', '..' );
  test.identical( got, '..' );

  var got = _.path.s.common( './b/c', './x' );
  test.identical( got, '.' );

  var got = _.path.s.common( './././a', './a/b' );
  test.identical( got, 'a' );

  var got = _.path.s.common( './a/./b', './a/b' );
  test.identical( got, 'a/b' );

  var got = _.path.s.common( './a/./b', './a/c/../b' );
  test.identical( got, 'a/b' );

  var got = _.path.s.common( '../b/c', './x' );
  test.identical( got, '..' );

  var got = _.path.s.common( '../../b/c', '../b' );
  test.identical( got, '../..' );

  var got = _.path.s.common( '../../b/c', '../../../x' );
  test.identical( got, '../../..' );

  var got = _.path.s.common( '../../b/c/../../x', '../../../x' );
  test.identical( got, '../../..' );

  var got = _.path.s.common( './../../b/c/../../x', './../../../x' );
  test.identical( got, '../../..' );

  var got = _.path.s.common( '../../..', './../../..' );
  test.identical( got, '../../..' );

  var got = _.path.s.common( './../../..', './../../..' );
  test.identical( got, '../../..' );

  var got = _.path.s.common( '../../..', '../../..' );
  test.identical( got, '../../..' );

  var got = _.path.s.common( '../b', '../b' );
  test.identical( got, '../b' );

  var got = _.path.s.common( '../b', './../b' );
  test.identical( got, '../b' );

  test.case = 'several absolute paths'

  var got = _.path.s.common( '/a/b/c', '/a/b/c', '/a/b/c' );
  test.identical( got, '/a/b/c' );

  var got = _.path.s.common( '/a/b/c', '/a/b/c', '/a/b' );
  test.identical( got, '/a/b' );

  var got = _.path.s.common( '/a/b/c', '/a/b/c', '/a/b1' );
  test.identical( got, '/a/' );

  var got = _.path.s.common( '/a/b/c', '/a/b/c', '/a' );
  test.identical( got, '/a' );

  var got = _.path.s.common( '/a/b/c', '/a/b/c', '/x' );
  test.identical( got, '/' );

  var got = _.path.s.common( '/a/b/c', '/a/b/c', '/' );
  test.identical( got, '/' );

  test.case = 'several relative paths';

  var got = _.path.s.common( 'a/b/c', 'a/b/c', 'a/b/c' );
  test.identical( got, 'a/b/c' );

  var got = _.path.s.common( 'a/b/c', 'a/b/c', 'a/b' );
  test.identical( got, 'a/b' );

  var got = _.path.s.common( 'a/b/c', 'a/b/c', 'a/b1' );
  test.identical( got, 'a/' );

  var got = _.path.s.common( 'a/b/c', 'a/b/c', '.' );
  test.identical( got, '.' );

  var got = _.path.s.common( 'a/b/c', 'a/b/c', 'x' );
  test.identical( got, '.' );

  var got = _.path.s.common( 'a/b/c', 'a/b/c', './' );
  test.identical( got, '.' );

  var got = _.path.s.common( '../a/b/c', 'a/../b/c', 'a/b/../c' );
  test.identical( got, '..' );

  var got = _.path.s.common( './a/b/c', '../../a/b/c', '../../../a/b' );
  test.identical( got, '../../..' );

  var got = _.path.s.common( '.', './', '..' );
  test.identical( got, '..' );

  var got = _.path.s.common( '.', './../..', '..' );
  test.identical( got, '../..' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'two arguments';
  test.shouldThrowErrorOfAnyKind( () => _.path.s.common( '/a', '..' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.s.common( '/a', '.' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.s.common( '/a', 'x' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.s.common( '/a', '../..' ) );

  test.case = 'three arguments'
  test.shouldThrowErrorOfAnyKind( () => _.path.s.common( '/a/b/c', '/a/b/c', './' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.s.common( '/a/b/c', '/a/b/c', '.' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.s.common( 'x', '/a/b/c', '/a' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.s.common( '/a/b/c', '..', '/a' ) );
  test.shouldThrowErrorOfAnyKind( () => _.path.s.common( '../..', '../../b/c', '/a' ) );
}

//

function commonVectors( test )
{
  test.case = 'simple';
  var src = [ '/a1/b2', '/a1/b' , '/a1/b2/c' ];
  test.identical( _.paths.common.apply( _.paths, src ), '/a1/' );

  test.case = 'with array';
  var src = [ '/a1/b2', [ '/a1/b' , '/a1/b2/c' ] ];
  test.identical( _.paths.common.apply( _.paths, src ), [ '/a1/' , '/a1/b2' ] );

  test.case = 'two arrays';
  var src = [ [ '/a1/b' , '/a1/b2/c' ], [ '/a1/b' , '/a1/b2/c' ] ];
  test.identical( _.paths.common.apply( _.paths, src ), [ '/a1/b' , '/a1/b2/c' ] );

  test.case = 'mixed';
  var src = [ '/a1', [ '/a1/b' , '/a1/b2/c' ], [ '/a1/b1' , '/a1/b2/c' ], '/a1' ];
  test.identical( _.paths.common.apply( _.paths, src ), [ '/a1' , '/a1' ] );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'arrays with different length';
  test.shouldThrowErrorSync( () => _.paths.common.apply( _.paths, [ [ '/a1/b' , '/a1/b2/c' ], [ '/a1/b1'  ] ] ) );

  test.case = 'incorrect argument';
  test.shouldThrowErrorSync( () => _.paths.common.apply( _.paths, 'ab' ) );
}

// --
// textual reporter
// --

function groupTextualReport( test )
{
  let defaults =
  {
    explanation : '',
    groupsMap : null,
    verbosity : 3,
    spentTime : null,
  }

  test.case = 'defaults';
  var got = _.path.groupTextualReport( _.mapExtend( null,defaults ) );
  var expected = '0 file(s)';
  test.identical( got,expected );

  test.case = 'explanation only';
  var o =
  {
    explanation : '- Deleted '
  }
  var got = _.path.groupTextualReport( _.mapExtend( null,defaults, o ) );
  var expected = '- Deleted 0 file(s)';
  test.identical( got,expected );

  test.case = 'spentTime only';
  var o =
  {
    spentTime : 5000
  }
  var got = _.path.groupTextualReport( _.mapExtend( null,defaults, o ) );
  var expected = '0 file(s), in 5.000s';
  test.identical( got,expected );

  test.open( 'locals' )

  test.case = 'groupsMap only';
  var o =
  {
    groupsMap :
    {
      '/' : [ '/a', '/a/b', '/b', '/b/c', ],
      '/a' : [ '/a', '/a/b' ],
      '/b' : [ '/b', '/b/c' ]
    }
  }
  var got = _.path.groupTextualReport( _.mapExtend( null,defaults, o ) );
  var expected =
  [
    '   4 at /',
    '   2 at ./a',
    '   2 at ./b',
    '4 file(s), at /'
  ].join( '\n' )
  test.identical( got,expected );

  test.case = 'explanation + groupsMap + spentTime, verbosity : 3';
  var o =
  {
    groupsMap :
    {
      '/' : [ '/a', '/a/b', '/b', '/b/c', ],
      '/a' : [ '/a', '/a/b' ],
      '/b' : [ '/b', '/b/c' ]
    },
    spentTime : 5000,
    explanation : '- Deleted ',
    verbosity : 3
  }
  var got = _.path.groupTextualReport( _.mapExtend( null,defaults, o ) );
  var expected =
  [
    '   4 at /',
    '   2 at ./a',
    '   2 at ./b',
    '- Deleted 4 file(s), at /, in 5.000s'
  ].join( '\n' )
  test.identical( got,expected );

  test.case = 'explanation + groupsMap + spentTime, verbosity : 5';
  var o =
  {
    groupsMap :
    {
      '/' : [ '/a', '/a/b', '/b', '/b/c', ],
      '/a' : [ '/a', '/a/b' ],
      '/b' : [ '/b', '/b/c' ]
    },
    spentTime : 5000,
    explanation : '- Deleted ',
    verbosity : 5
  }

  var got = _.path.groupTextualReport( _.mapExtend( null, defaults, o ) );
  var expected =
`
  '/a'
  '/a/b'
  '/b'
  '/b/c'
   4 at /
   2 at ./a
   2 at ./b
- Deleted 4 file(s), at /, in 5.000s`;
  test.equivalent( got, expected );

  test.case = 'relative, explanation + groupsMap + spentTime, verbosity : 5';
  var o =
  {
    groupsMap :
    {
      '/' : [ './a', './a/b', './b','./b/c', ],
      './a' : [ './a', './a/b' ],
      './b' : [ './b', './b/c' ]
    },
    spentTime : 5000,
    explanation : '- Deleted ',
    verbosity : 5
  }
  var got = _.path.groupTextualReport( _.mapExtend( null,defaults, o ) );
  var expected =
`
  './a'
  './a/b'
  './b'
  './b/c'
   4 at .
   2 at ./a
   2 at ./b
- Deleted 4 file(s), at ., in 5.000s
`
  test.equivalent( got, expected );

  test.close( 'locals' );
}

//

function commonTextualReport( test )
{
  test.open( 'locals' );

  test.case = 'single';
  var filePath = [ '/wprocedure#0.3.19' ];
  var expected = filePath[ 0 ];
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, same';
  var filePath = [ '/wprocedure#0.3.19', '/wprocedure#0.3.19' ];
  var expected = '( /wprocedure#0.3.19 + [ . , . ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, same protocol and path, diffent hash';
  var filePath = [ '/wprocedure#0.3.19', '/wprocedure#0.3.18' ];
  var expected = '( / + [ wprocedure#0.3.19 , wprocedure#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = [ '/wprocedure#0.3.19', '/wfiles#0.3.19' ];
  var expected = '( / + [ wprocedure#0.3.19 , wfiles#0.3.19 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = [ '/wprocedure#0.3.19', '/wfiles#0.3.18' ];
  var expected = '( / + [ wprocedure#0.3.19 , wfiles#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = [ '/wprocedure', '/wfiles#0.3.18' ];
  var expected = '( / + [ wprocedure , wfiles#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = [ '/wprocedure', '/a/b/c' ];
  var expected = '( / + [ wprocedure , a/b/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'three, commot part of path';
  var filePath = [ '/wprocedure', '/a/b/c', '/wfiles' ];
  var expected = '( / + [ wprocedure , a/b/c , wfiles ] )'
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, part of path is diffent';
  var filePath = [ '/a/b/c', '/a/x/c' ];
  var expected = '( /a/ + [ ./b/c , ./x/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two relatives, common part of path';
  var filePath = [ 'a/b/c', 'a/x/c' ];
  var expected = '( a/ + [ ./b/c , ./x/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two different relatives';
  var filePath = [ 'a/b', 'c/d' ];
  var expected = '[ a/b , c/d ]';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.close( 'locals' );

  /* - */

  test.open( 'map' );

  test.case = 'single';
  var filePath = { '/wprocedure#0.3.19' :1 };
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, '/wprocedure#0.3.19' );

  test.case = 'two, same protocol and path, diffent hash';
  var filePath = { '/wprocedure#0.3.19' : 1, '/wprocedure#0.3.18' : 1 };
  var expected = '( / + [ wprocedure#0.3.19 , wprocedure#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = { '/wprocedure#0.3.19' : 1, '/wfiles#0.3.19' : 1 };
  var expected = '( / + [ wprocedure#0.3.19 , wfiles#0.3.19 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath =  { '/wprocedure#0.3.19' : 1, '/wfiles#0.3.18' : 1 };
  var expected = '( / + [ wprocedure#0.3.19 , wfiles#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = { '/wprocedure' : 1, '/wfiles#0.3.18' : 1 };
  var expected = '( / + [ wprocedure , wfiles#0.3.18 ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, different';
  var filePath = { '/wprocedure' : 1, '/a/b/c' : 1 };
  var expected = '( / + [ wprocedure , a/b/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'three, commot part of path';
  var filePath = { '/wprocedure' : 1, '/a/b/c' : 1, '/wfiles' : 1 };
  var expected = '( / + [ wprocedure , a/b/c , wfiles ] )'
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two, part of path is diffent';
  var filePath = { '/a/b/c' : 1, '/a/x/c' : 0 };
  var expected = '( /a/ + [ ./b/c , ./x/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two relatives, common part of path';
  var filePath = { 'a/b/c' : 1, 'a/x/c' : 0 };
  var expected = '( a/ + [ ./b/c , ./x/c ] )';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.case = 'two different relatives';
  var filePath = { 'a/b' : 'a/b/c', 'c/d' : 'a/b' };
  var expected = '[ a/b , c/d ]';
  var got = _.path.commonTextualReport( filePath );
  test.identical( got, expected );

  test.close( 'map' );

  /* - */

  if( !Config.debug )
  return

  test.shouldThrowErrorSync( () => _.path.commonTextualReport( null ) )
  test.shouldThrowErrorSync( () => _.path.commonTextualReport([ '/a/b/c', null ]) )
  test.shouldThrowErrorSync( () => _.path.commonTextualReport([ '/a/b/c', './c/d'  ]) )
}

//

function moveTextualReport( test )
{
  test.open( 'locals' );

  test.case = 'same, absolute';
  var expected = '/a : . <- .';
  var dst = '/a';
  var src = '/a';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, absolute, with common';
  var expected = '/a/ : ./dst <- ./src';
  var dst = '/a/dst';
  var src = '/a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, absolute, without common';
  var expected = '/b/dst <- /a/src';
  var dst = '/b/dst';
  var src = '/a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'same, relative';
  var expected = 'a/src : . <- .';
  var dst = 'a/src';
  var src = 'a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, relative, with common';
  var expected = 'a/ : ./dst <- ./src';
  var dst = 'a/dst';
  var src = 'a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, relative, without common';
  var expected = 'b/dst <- a/src';
  var dst = 'b/dst';
  var src = 'a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'same, relative dotted';
  var expected = 'a/src : . <- .';
  var dst = './a/src';
  var src = './a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, relative dotted, with common';
  var expected = 'a/ : ./dst <- ./src';
  var dst = './a/dst';
  var src = './a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'different, relative dotted, without common';
  var expected = './b/dst <- ./a/src';
  var dst = './b/dst';
  var src = './a/src';
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.close( 'locals' );

  /* - */

  test.open( 'null' );

  test.case = 'both null';
  var expected = '{null} : . <- .';
  var dst = null;
  var src = null;
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'dst relative, src null';
  var expected = './a/dst <- {null}';
  var dst = './a/dst';
  var src = null;
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'src relative, dst null';
  var expected = '{null} <- ./a/src';
  var src = './a/src';
  var dst = null;
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'src absolute, dst null';
  var expected = '/{null} <- /a/src';
  var src = '/a/src';
  var dst = null;
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.case = 'dst absolute, src null';
  var expected = '/a/dst <- /{null}';
  var dst = '/a/dst';
  var src = null;
  var got = _.path.moveTextualReport( dst, src );
  test.identical( _.ct.strip( got ), expected );

  test.close( 'null' );
}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l3.path.basic.S',
  silencing : 1,

  tests :
  {

    refine,
    normalize,

    dot,
    undot,

    dir,
    prefixGet,
    name,
    fullName,
    ext,
    withoutExt,
    changeExt,

    join,
    reroot,
    resolve,

    from,
    relative,
    common,
    commonVectors,

    // textual reporter

    groupTextualReport,
    commonTextualReport,
    moveTextualReport

  },

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
