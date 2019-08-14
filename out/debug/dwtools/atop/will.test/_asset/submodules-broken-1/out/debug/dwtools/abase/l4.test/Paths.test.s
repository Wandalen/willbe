( function _PathsBasic_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  require( '../l4/PathsBasic.s' );

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

  //

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

  //

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
  var expected = [ '', 'a', '.', '.a', 'a', '..', '..a', '../a', 'a', '/a' ];
  test.identical( _.paths.undot( src ), expected );

  //

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
  var expected = [ '', 'a', '.', '.a', 'a', '..', '..a', '../a', 'a', '/a' ];
  test.identical( _.paths.undot( src ), expected );

  test.case = 'rm ./ prefix from path';
  var src = { './' : 1, './a' : 1, '.' : 1, './.a' : 1, './a' : 1, '..' : 1, './..a' : 1, '../a' : 1 };
  var expected = { '' : 1, 'a' : 1, '.' : 1, '.a': 1, '..': 1, '..a': 1, '../a': 1 };
  test.identical( _.paths.undot( src ), expected );

  //

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.paths.undot() );
  test.shouldThrowErrorSync( () => _.paths.undot( [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.paths.undot( true ) );
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

  //

  if( !Config.debug )
  return;

  test.case = 'arrays with different length';
  test.shouldThrowError( () => _.paths.join( [ '/b', '.c' ], [ '/b' ] ) );

  test.case = 'numbers';
  test.shouldThrowError( () => _.paths.join( [ 1, 2 ] ) );

  // test.case = 'nothing passed';
  // test.shouldThrowErrorSync( () => _.paths.join( ) );
  //
  // test.case = 'object passed';
  // test.shouldThrowErrorSync( () => _.paths.join( {} ) );

  test.case = 'inner arrays';
  test.shouldThrowError( () => _.paths.join( [ '/b', '.c' ], [ '/b', [ 'x' ] ] ) );
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

  //

  if( !Config.debug )
  return;

  test.case = 'arrays with different length';
  test.shouldThrowError( () => _.paths.reroot( [ '/b', '.c' ], [ '/b' ] ) );

  test.case = 'inner arrays';
  test.shouldThrowError( () => _.paths.reroot( [ '/b', '.c' ], [ '/b', [ 'x' ] ] ) );

  test.case = 'numbers';
  test.shouldThrowError( () => _.paths.reroot( [ 1, 2 ] ) );
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
  var expected = [ _.path.dir( _.path.current() ) + 'a/b', _.path.dir( _.path.current() ) + 'a/.c' ]
  test.identical( got, expected );

  var got = _.paths.resolve( '../a', [ '/b', '.c' ], './d' );
  var expected = [ '/b/d', _.path.dir( _.path.current() ) + 'a/.c/d' ];
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
  var expected = [ _.path.dir( _.path.current() ) + 'a', _.path.dir( _.path.current() ) + 'b' ];
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
  var expected = '/..';
  test.identical( got, expected );

  //

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
    '/..'
  ];
  test.identical( got, expected );

  //

  if( !Config.debug )
  return

  test.case = 'arrays with different length';
  test.shouldThrowError( () => _.paths.resolve( [ '/b', '.c' ], [ '/b' ] ) );

  // test.case = 'empty';
  // test.shouldThrowError( () => _.paths.resolve() );

  test.case = 'inner arrays';
  test.shouldThrowError( () => _.paths.resolve( [ '/b', '.c' ], [ '/b', [ 'x' ] ] ) );
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
    '/foo/bar/baz/',
    '/aa/',
    '/aa/',
    '/',
    '/../'
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
    'aa/',
    './',
    '../',
    '../../'
  ];
  test.identical( _.paths.dir( src ), expected );

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowError( () => _.paths.dir() );

  test.case = 'inner array';
  test.shouldThrowError( () => _.paths.dir( [ './a/../b', [ 'a/b/c' ] ]) );

  test.case = 'two arguments';
  test.shouldThrowError( () => _.paths.dir( [ '/aa/b' ], [ 'b/c' ] ) );

  test.case = 'not a string, empty string';
  test.shouldThrowError( () => _.paths.dir( [ 'aa/bb', 1 ] ) );
  test.shouldThrowError( () => _.paths.dir( [ '' ] ) );

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

  //

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

  //

  if( !Config.debug )
  return;

  test.case = 'incorrect input';
  test.shouldThrowErrorSync( () => _.path.s.from() );
  test.shouldThrowErrorSync( () => _.path.s.from( [ 0 ] ) );
  test.shouldThrowErrorSync( () => _.path.s.from( [ 'a/b' ], [ 'b/c'] ) );
  test.shouldThrowErrorSync( () => _.path.s.from( null ) );
  //test.shouldThrowErrorSync( () => _.path.s.from( {} ) );
}

//

function relative( test )
{
  test.case = 'relative to array of paths'; /* */
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

  //

  test.case = 'works like relative';

  var got = _.paths.relative( '/aa/bb/cc', '/aa/bb/cc' );
  var expected = _.path.relative( '/aa/bb/cc', '/aa/bb/cc' );
  test.identical( got, expected );

  var got = _.paths.relative( '/foo/bar/baz/asdf/quux', '/foo/bar/baz/asdf/quux/new1' );
  var expected = _.path.relative( '/foo/bar/baz/asdf/quux', '/foo/bar/baz/asdf/quux/new1' );
  test.identical( got, expected );

  //

  if( !Config.debug )
  return;

  test.case = 'relative to array of paths, one of paths is relative, resolving off'; /* */
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

  test.case = 'using map options'; /* */
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

  if( !Config.debug )
  return;

  test.case = 'two arguments';
  test.shouldThrowError( () => _.path.s.common( '/a', '..' ) );
  test.shouldThrowError( () => _.path.s.common( '/a', '.' ) );
  test.shouldThrowError( () => _.path.s.common( '/a', 'x' ) );
  test.shouldThrowError( () => _.path.s.common( '/a', '../..' ) );

  test.case = 'three arguments'
  test.shouldThrowError( () => _.path.s.common( '/a/b/c', '/a/b/c', './' ) );
  test.shouldThrowError( () => _.path.s.common( '/a/b/c', '/a/b/c', '.' ) );
  test.shouldThrowError( () => _.path.s.common( 'x', '/a/b/c', '/a' ) );
  test.shouldThrowError( () => _.path.s.common( '/a/b/c', '..', '/a' ) );
  test.shouldThrowError( () => _.path.s.common( '../..', '../../b/c', '/a' ) );
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

  //

  if( !Config.debug )
  return;

  test.case = 'arrays with different length';
  test.shouldThrowErrorSync( () => _.paths.common.apply( _.paths, [ [ '/a1/b' , '/a1/b2/c' ], [ '/a1/b1'  ] ] ) );

  test.case = 'incorrect argument';
  test.shouldThrowErrorSync( () => _.paths.common.apply( _.paths, 'ab' ) );
}

// --
// declare
// --

var Self =
{

  name : 'Tools/base/l4/path/basic/S',
  silencing : 1,
  // verbosity : 7,
  // routine : 'relative',

  tests :
  {

    refine,
    normalize,

    dot,
    undot,

    join,
    reroot,
    resolve,

    dir,
    prefixGet,
    name,
    fullName,
    withoutExt,
    changeExt,
    ext,

    from,
    relative,
    common,
    commonVectors,

  },
}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
