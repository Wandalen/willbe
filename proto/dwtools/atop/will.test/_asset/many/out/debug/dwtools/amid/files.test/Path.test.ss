( function _Path_test_ss_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  if( !_global_.wTools.FileProvider )
  require( '../files/UseTop.s' );
  var Path = require( 'path' );
  var Process = require( 'process' );

  _.include( 'wTesting' );

}

//

var _ = _global_.wTools;
var Parent = wTester;

//

function onSuiteBegin()
{
  this.isBrowser = typeof module === 'undefined';

  if( !this.isBrowser )
  this.suitePath = _.path.pathDirTempOpen( _.path.join( __dirname, '../..' ), 'Path' );
  else
  this.suitePath = _.path.current();
}

//

function onSuiteEnd()
{
  if( !this.isBrowser )
  {
    _.assert( _.strHas( this.suitePath, '.tmp' ), this.suitePath );
    _.path.pathDirTempClose( this.suitePath );
  }
}

// --
// routines
// --

function createTestsDirectory( path, rmIfExists )
{
  if( rmIfExists && _.fileProvider.statResolvedRead( path ) )
  _.fileProvider.filesDelete( path );
  return _.fileProvider.dirMake( path );
}

//

function createInTD( path )
{
  return this.createTestsDirectory( _.path.join( this.suitePath, path ) );
}

//

function createTestFile( path, data, decoding )
{
  if( data === undefined )
  data = path;

  var dataToWrite = ( decoding === 'json' ) ? JSON.stringify( data ) : data;
  _.fileProvider.fileWrite({ filePath : _.path.join( this.suitePath, path ), data : dataToWrite })
}

//

function createTestSymLink( path, target, type, data )
{
  var origin,
    typeOrigin;

  if( target === void 0 )
  {
    origin = Path.parse( path )
    origin.name = origin.name + '_orig';
    origin.base = origin.name + origin.ext;
    origin = Path.format( origin );
  }
  else
  {
    origin = target;
  }

  if( 'sf' === type )
  {
    typeOrigin = 'file';
    data = data || 'test origin';
    this.createTestFile( origin, data );
  }
  else if( 'sd' === type )
  {
    typeOrigin = 'dir';
    this.createInTD( origin );
  }
  else throw new Error( 'unexpected type' );

  path = _.path.join( this.suitePath, path );
  origin = _.path.resolve( _.path.join( this.suitePath, origin ) );

  if( _.fileProvider.statResolvedRead( path ) )
  _.fileProvider.filesDelete( path );
  _.fileProvider.softLink( path, origin );
}

//

function createTestResources( cases, dir )
{
  if( !Array.isArray( cases ) ) cases = [ cases ];

  var l = cases.length,
    testCheck,
    paths;

  while ( l-- )
  {
    testCheck = cases[ l ];
    switch( testCheck.type )
    {
      case 'f' :
        paths = Array.isArray( testCheck.path ) ? testCheck.path : [ testCheck.path ];
        paths.forEach( ( path, i ) => {
          path = dir ? Path.join( dir, path ) : path;
          if( testCheck.createResource !== void 0 )
          {
            let res =
              ( Array.isArray( testCheck.createResource ) && testCheck.createResource[i] ) || testCheck.createResource;
            this.createTestFile( path, res );
          }
          this.createTestFile( path );
        } );
        break;

      case 'd' :
        paths = Array.isArray( testCheck.path ) ? testCheck.path : [ testCheck.path ];
        paths.forEach( ( path, i ) =>
        {
          path = dir ? Path.join( dir, path ) : path;
          this.createInTD( path );
          if ( testCheck.folderContent )
          {
            var res = Array.isArray( testCheck.folderContent ) ? testCheck.folderContent : [ testCheck.folderContent ];
            this.createTestResources( res, path );
          }
        } );
        break;

      case 'sd' :
      case 'sf' :
        let path, target;
        if( Array.isArray( testCheck.path ) )
        {
          path = dir ? Path.join( dir, testCheck.path[0] ) : testCheck.path[0];
          target = dir ? Path.join( dir, testCheck.path[1] ) : testCheck.path[1];
        }
        else
        {
          path = dir ? Path.join( dir, testCheck.path ) : testCheck.path;
          target = dir ? Path.join( dir, testCheck.linkTarget ) : testCheck.linkTarget;
        }
        this.createTestSymLink( path, target, testCheck.type, testCheck.createResource );
        break;
    }
  }
}

// --
// test
// --

function from( test )
{
  var str1 = '/foo/bar/baz',
      str2 = 'tmp/get/test.txt',
    expected = str1,
    expected2 = _.path.resolve( _.path.join( test.context.suitePath,str2 ) ),
    got,
    fileRecord;

  test.context.createTestFile( str2 );
  fileRecord = _.fileProvider.recordFactory().record( _.path.resolve( _.path.join( test.context.suitePath,str2 ) ) );

  test.case = 'string argument';
  got = _.path.from( str1 );
  test.identical( got, expected );

  test.case = 'file record argument';
  got = _.path.from( fileRecord );
  test.identical( got, expected2 );

  if( Config.debug )
  {
    test.case = 'missed arguments';
    test.shouldThrowErrorSync( function( )
    {
      _.path.from( );
    } );

    test.case = 'extra arguments';
    test.shouldThrowErrorSync( function( )
    {
      _.path.from( 'temp/sample.txt', 'hello' );
    } );

    test.case = 'path is not string/or file record';
    test.shouldThrowErrorSync( function( )
    {
      _.path.from( 3 );
    } );
  }
};

//

function forCopy( test )
{

  var defaults =
    {
      postfix : 'copy',
      srcPath : null
    },
    path1 = 'tmp/forCopy/test_original.txt',
    expected1 = { path :  _.path.resolve( _.path.join( test.context.suitePath,'tmp/forCopy/test_original-copy.txt' ) ), error : false },
    path2 = 'tmp/forCopy/test_original2',
    expected2 = { path : _.path.resolve( _.path.join( test.context.suitePath,'tmp/forCopy/test_original2-backup-2' ) ), error : false },
    got = { path : void 0, error : void 0 };

  test.context.createTestFile( path1 );
  test.context.createTestFile( path2 );

  test.case = 'simple existing file path';
  try
  {
    got.path = _.path.forCopy( { filePath : _.path.resolve( _.path.join( test.context.suitePath,path1 ) ) } );
  }
  catch( err )
  {
    _.errLogOnce( err )
    got.error = !!err;
  }
  got.error = !!got.error;
  test.identical( got, expected1 );

  test.case = 'generate names for several copies';
  try
  {
    var path_tmp = _.path.forCopy( { filePath : _.path.resolve( _.path.join( test.context.suitePath,path2 ) ), postfix : 'backup' } );
    test.context.createTestFile( path_tmp );
    path_tmp = _.path.forCopy( { filePath : path_tmp, postfix : 'backup' } );
    test.context.createTestFile( path_tmp );
    got.path = _.path.forCopy( { filePath : path_tmp, postfix : 'backup' } );
  }
  catch( err )
  {
    _.errLogOnce( err )
    got.error = !!err;
  }
  got.error = !!got.error;
  test.identical( got, expected2 );


  if( Config.debug )
  {
    test.case = 'missed arguments';
    test.shouldThrowErrorSync( function( )
    {
      _.path.forCopy( );
    } );

    test.case = 'extra arguments';
    test.shouldThrowErrorSync( function( )
    {
      _.path.forCopy( { srcPath : _.path.join( test.context.suitePath,path1 ) }, { srcPath : _.path.join( test.context.suitePath,path2 ) } );
    } );

    test.case = 'unexisting file';
    test.shouldThrowErrorSync( function( )
    {
      _.path.forCopy( { srcPath : 'temp/sample.txt' } );
    } );
  }

}

//

function pathResolve( test )
{

  var provider = _.fileProvider;

  test.case = 'join windows os paths';
  var paths = [ 'c:\\', 'foo\\', 'bar\\' ];
  var expected = '/c/foo/bar/';
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  test.case = 'join unix os paths';
  var paths = [ '/bar/', '/baz', 'foo/', '.' ];
  var expected = '/baz/foo';
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  test.case = 'here cases'; /* */

  var paths = [ 'aa','.','cc' ];
  var expected = _.path.join( _.path.current(), 'aa/cc' );
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  var paths = [  'aa','cc','.' ];
  var expected = _.path.join( _.path.current(), 'aa/cc' );
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  var paths = [  '.','aa','cc' ];
  var expected = _.path.join( _.path.current(), 'aa/cc' );
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  test.case = 'down cases'; /* */

  var paths = [  '.','aa','cc','..' ];
  var expected = _.path.join( _.path.current(), 'aa' );
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  var paths = [  '.','aa','cc','..','..' ];
  var expected = _.path.current();
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  console.log( '_.path.current()',_.path.current() );
  var paths = [  'aa','cc','..','..','..' ];
  var expected = _.strIsolateRightOrNone( _.path.current(),'/' )[ 0 ];
  if( _.path.current() === '/' )
  expected = '/..';
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  test.case = 'like-down or like-here cases'; /* */

  var paths = [  '.x.','aa','bb','.x.' ];
  var expected = _.path.join( _.path.current(), '.x./aa/bb/.x.' );
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  var paths = [  '..x..','aa','bb','..x..' ];
  var expected = _.path.join( _.path.current(), '..x../aa/bb/..x..' );
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  test.case = 'period and double period combined'; /* */

  var paths = [  '/abc','./../a/b' ];
  var expected = '/a/b';
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  var paths = [  '/abc','a/.././a/b' ];
  var expected = '/abc/a/b';
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  var paths = [  '/abc','.././a/b' ];
  var expected = '/a/b';
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  var paths = [  '/abc','./.././a/b' ];
  var expected = '/a/b';
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  var paths = [  '/abc','./../.' ];
  var expected = '/';
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  var paths = [  '/abc','./../../.' ];
  var expected = '/..';
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  var paths = [  '/abc','./../.' ];
  var expected = '/';
  var got = provider.path.resolve.apply( provider.path, paths );
  test.identical( got, expected );

  if( !Config.debug ) //
  return;

  test.case = 'nothing passed';
  test.shouldThrowErrorSync( function()
  {
    provider.path.resolve();
  });

  test.case = 'non string passed';
  test.shouldThrowErrorSync( function()
  {
    provider.path.resolve( {} );
  });
}

//

function pathsResolve( test )
{
  var provider = _.fileProvider;
  var currentPath = _.path.current();

  test.case = 'paths resolve';

  var got = provider.path.s.resolve( 'c', [ '/a', 'b' ] );
  var expected = [ '/a', _.path.join( currentPath, 'c/b' ) ];
  test.identical( got, expected );

  var got = provider.path.s.resolve( [ '/a', '/b' ], [ '/a', '/b' ] );
  var expected = [ '/a', '/b' ];
  test.identical( got, expected );

  var got = provider.path.s.resolve( '../a', [ 'b', '.c' ] );
  var expected = [ _.path.dir( currentPath ) + 'a/b', _.path.dir( currentPath ) + 'a/.c' ]
  test.identical( got, expected );

  var got = provider.path.s.resolve( '../a', [ '/b', '.c' ], './d' );
  var expected = [ '/b/d', _.path.dir( currentPath ) + 'a/.c/d' ];
  test.identical( got, expected );

  var got = provider.path.s.resolve( [ '/a', '/a' ],[ 'b', 'c' ] );
  var expected = [ '/a/b' , '/a/c' ];
  test.identical( got, expected );

  var got = provider.path.s.resolve( [ '/a', '/a' ],[ 'b', 'c' ], 'e' );
  var expected = [ '/a/b/e' , '/a/c/e' ];
  test.identical( got, expected );

  var got = provider.path.s.resolve( [ '/a', '/a' ],[ 'b', 'c' ], '/e' );
  var expected = [ '/e' , '/e' ];
  test.identical( got, expected );

  var got = provider.path.s.resolve( '.', '../', './', [ 'a', 'b' ] );
  var expected = [ _.path.dir( currentPath ) + 'a', _.path.dir( currentPath ) + 'b' ];
  test.identical( got, expected );

  //

  test.case = 'works like path resolve';

  var got = provider.path.s.resolve( '/a', 'b', 'c' );
  var expected = provider.path.resolve( '/a', 'b', 'c' );
  test.identical( got, expected );

  var got = provider.path.s.resolve( '/a', 'b', 'c' );
  var expected = provider.path.resolve( '/a', 'b', 'c' );
  test.identical( got, expected );

  var got = provider.path.s.resolve( '../a', '.c' );
  var expected = provider.path.resolve( '../a', '.c' );
  test.identical( got, expected );

  var got = provider.path.s.resolve( '/a' );
  var expected = provider.path.resolve( '/a' );
  test.identical( got, expected );

  //

  test.case = 'scalar + array with single argument'

  var got = provider.path.s.resolve( '/a', [ 'b/..' ] );
  var expected = [ '/a' ];
  test.identical( got, expected );

  test.case = 'array + array with single arguments'

  var got = provider.path.s.resolve( [ '/a' ], [ 'b/../' ] );
  var expected = [ '/a/' ];
  test.identical( got, expected );

  test.case = 'single array';

  var got = _.path.s.resolve( [ '/a', 'b', './b', '../b', '../' ] );
  var expected =
  [
    '/a',
    _.path.join( currentPath, 'b' ),
    _.path.join( currentPath, 'b' ),
    _.path.join( _.path.dir( currentPath ), 'b' ),

    _.path.normalize( _.path.dir( currentPath ) )
    //_.path.normalize( _.path.dir( currentPath ) ),
    // routine normalizeStrict does not exist now
    // _.path.normalizeStrict( _.path.dir( currentPath ) )

  ];
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return

  test.case = 'empty str'
  test.shouldThrowErrorSync( function()
  {
    rovider.path.s.resolve( '' )
  });

  test.case = 'no arguments'
  test.shouldThrowErrorSync( function()
  {
    rovider.path.s.resolve()
  });

  // test.case = 'without arguments';
  // test.shouldThrowErrorSync( () =>
  // {
  //   debugger;
  //   provider.path.s.resolve();
  //   debugger;
  // });

  test.case = 'arrays with different length'
  test.shouldThrowErrorSync( function()
  {
    provider.path.s.resolve( [ '/b', '.c' ], [ '/b' ] );
  });

  test.case = 'inner arrays'
  test.shouldThrowErrorSync( function()
  {
    provider.path.s.resolve( [ '/b', '.c' ], [ '/b', [ 'x' ] ] );
  });
}

//

function regexpMakeSafe( test )
{

  test.case = 'only default safe paths'; /* */
  var expected1 =
  {
    includeAny : [],
    includeAll : [],
    excludeAny :
    [
      /\.(?:unique|git|svn|hg|DS_Store|tmp)(?:$|\/)/,
      /(^|\/)-/,
    ],
    excludeAll : []
  };
  var got = _.files.regexpMakeSafe();
  // logger.log( 'got',_.toStr( got,{ levels : 3 } ) );
  // logger.log( 'expected1',_.toStr( expected1,{ levels : 3 } ) );
  test.identical( got.includeAny, expected1.includeAny );
  test.identical( got.includeAll, expected1.includeAll );
  test.identical( got.excludeAny, expected1.excludeAny );
  test.identical( got.excludeAll, expected1.excludeAll );

  test.case = 'single path for include any mask'; /* */
  var path2 = 'foo/bar';
  var expected2 =
  {
    includeAny : [ /foo\/bar/ ],
    includeAll : [],
    excludeAny :
    [
      /\.(?:unique|git|svn|hg|DS_Store|tmp)(?:$|\/)/,
      /(^|\/)-/,
    ],
    excludeAll : []
  };
  var got = _.files.regexpMakeSafe( path2 );
  test.identical( got.includeAny, expected2.includeAny );
  test.identical( got.includeAll, expected2.includeAll );
  test.identical( got.excludeAny, expected2.excludeAny );
  test.identical( got.excludeAll, expected2.excludeAll );

  test.case = 'array of paths for include any mask'; /* */
  var path3 = [ 'foo/bar', 'foo2/bar2/baz', 'some.txt' ];
  var expected3 =
  {
    includeAny : [ /foo\/bar/, /foo2\/bar2\/baz/, /some\.txt/ ],
    includeAll : [],
    excludeAny :
    [
      /\.(?:unique|git|svn|hg|DS_Store|tmp)(?:$|\/)/,
      /(^|\/)-/,
    ],
    excludeAll : []
  };
  var got = _.files.regexpMakeSafe( path3 );
  test.identical( got.includeAny, expected3.includeAny );
  test.identical( got.includeAll, expected3.includeAll );
  test.identical( got.excludeAny, expected3.excludeAny );
  test.identical( got.excludeAll, expected3.excludeAll );

  test.case = 'regex object passed as mask for include any mask'; /* */
  var paths4 =
  {
    includeAny : [ 'foo/bar', 'foo2/bar2/baz', 'some.txt' ],
    includeAll : [ 'index.js' ],
    excludeAny : [ 'aa.js', 'bb.js' ],
    excludeAll : [ 'package.json', 'bower.json' ]
  };
  var expected4 =
  {
    includeAny : [ /foo\/bar/, /foo2\/bar2\/baz/, /some\.txt/ ],
    includeAll : [ /index\.js/ ],
    excludeAny :
    [
      /\.(?:unique|git|svn|hg|DS_Store|tmp)(?:$|\/)/,
      /(^|\/)-/,
      /aa\.js/,
      /bb\.js/
    ],
    excludeAll : [ /package\.json/, /bower\.json/ ]
  };
  var got = _.files.regexpMakeSafe( paths4 );
  test.identical( got.includeAny, expected4.includeAny );
  test.identical( got.includeAll, expected4.includeAll );
  test.identical( got.excludeAny, expected4.excludeAny );
  test.identical( got.excludeAll, expected4.excludeAll );

  /* - */

  if( Config.debug )
  {
    test.case = 'extra arguments';
    test.shouldThrowErrorSync( function( )
    {
      _.files.regexpMakeSafe( 'package.json', 'bower.json' );
    });
  }

}

//

function realMainFile( test )
{
  if( require.main === module )
  var expected1 = __filename;
  else
  var expected1 = require.main.filename;

  test.case = 'compare with __filename path for main file';
  var got = _.fileProvider.path.nativize( _.path.realMainFile( ) );
  test.identical( got, expected1 );
};

//

function realMainDir( test )
{

  if( require.main === module )
  var file = __filename;
  else
  var file = require.main.filename;

  var expected1 = _.path.dir( file );

  test.case = 'compare with __filename path dir';
  var got = _.fileProvider.path.nativize( _.path.realMainDir( ) );
  test.identical( _.path.normalize( got ), _.path.normalize( expected1 ) );

  test.case = 'absolute paths'; /* */
  var from = _.path.realMainDir();
  var to = _.path.realMainFile();
  var expected = _.path.name({ path : _.path.realMainFile(), full : 1 });
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  test.case = 'absolute paths, from === to'; /* */
  var from = _.path.realMainDir();
  var to = _.path.realMainDir();
  var expected = './';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

}

//

function effectiveMainFile( test )
{
  if( require.main === module )
  var expected1 = __filename;
  else
  var expected1 = process.argv[ 1 ];

  test.case = 'compare with __filename path for main file';
  var got = _.fileProvider.path.nativize( _.path.effectiveMainFile( ) );
  test.identical( got, expected1 );

  if( Config.debug )
  {
    test.case = 'extra arguments';
    test.shouldThrowErrorSync( function( )
    {
      _.path.effectiveMainFile( 'package.json' );
    } );
  }
};

//

function effectiveMainDir( test )
{
  if( require.main === module )
  var file = __filename;
  else
  var file = process.argv[ 1 ];

  var expected1 = _.path.dir( file );

  test.case = 'compare with __filename path dir';
  var got = _.fileProvider.path.nativize( _.path.effectiveMainDir( ) );
  test.identical( _.path.normalize( got ), _.path.normalize( expected1 ) );

  if( Config.debug )
  {
    test.case = 'extra arguments';
    test.shouldThrowErrorSync( function( )
    {
      _.path.effectiveMainDir( 'package.json' );
    } );
  }
};

//

function pathCurrent( test )
{
  var path1 = 'tmp/pathCurrent/foo',
    expected = Process.cwd( ),
    expected1 = _.fileProvider.path.nativize( _.path.resolve( _.path.join( test.context.suitePath,path1 ) ) );

  test.case = 'get pathCurrent working directory';
  var got = _.fileProvider.path.nativize( _.path.current( ) );
  test.identical( got, expected );

  test.case = 'set new pathCurrent working directory';
  test.context.createInTD( path1 );
  var before = _.path.current();
  _.path.current( _.path.normalize( _.path.join( test.context.suitePath,path1 ) ) );
  var got = Process.cwd( );
  _.path.current( before );
  test.identical( got, expected1 );

  if( !Config.debug )
  return;

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( function( )
  {
    _.path.current( 'tmp/pathCurrent/foo', 'tmp/pathCurrent/foo' );
  } );

  test.case = 'unexist directory';
  test.shouldThrowErrorSync( function( )
  {
    _.path.current( _.path.join( test.context.suitePath, 'tmp/pathCurrent/bar' ) );
  });

}

//

function pathCurrent2( test )
{
  var got, expected;

  test.case = 'get pathCurrent working dir';

  if( test.context.isBrowser )
  {
    /*default*/

    got = _.path.current();
    expected = '.';
    test.identical( got, expected );

    /*incorrect arguments count*/

    test.shouldThrowErrorSync( function()
    {
      _.path.current( 0 );
    })

  }
  else
  {
    /*default*/

    if( _.fileProvider )
    {

      got = _.path.current();
      expected = _.path.normalize( process.cwd() );
      test.identical( got,expected );

      /*empty string*/

      expected = _.path.normalize( process.cwd() );
      got = _.path.current( '' );
      test.identical( got,expected );

      /*changing cwd*/

      got = _.path.current( './proto' );
      expected = _.path.normalize( process.cwd() );
      test.identical( got,expected );

      /*try change cwd to terminal file*/

      // got = _.path.current( './dwtools/amid/files/alayer1/Path.ss' );
      got = _.path.current( _.path.normalize( __filename ) );
      expected = _.path.normalize( process.cwd() );
      test.identical( got,expected );

    }

    /*incorrect path*/

    test.shouldThrowErrorSync( function()
    {
      got = _.path.current( './incorrect_path' );
      expected = _.path.normalize( process.cwd() );
      test.identical( got,expected );
    });

    if( Config.debug )
    {
      /*incorrect arguments length*/

      test.shouldThrowErrorSync( function()
      {
        _.path.current( '.', '.' );
      })

      /*incorrect argument type*/

      test.shouldThrowErrorSync( function()
      {
        _.path.current( 123 );
      })
    }

  }

}

//

function relative( test )
{
  test.case = 'path and record';

  var from = _.fileProvider.recordFactory().record( _.path.current() );
  var to = _.path.dir( _.path.current() );
  var expected = '../';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  var from = _.fileProvider.recordFactory().record( _.path.current() );
  var to = _.path.join( _.path.dir( _.path.current() ), 'a' )
  var expected = '../a';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  var from = _.path.dir( _.path.current() );
  var to = _.fileProvider.recordFactory().record( _.path.current() );
  var expected = _.path.name({ path : to.absolute, full : 1 });
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  var from = _.fileProvider.recordFactory().record( _.path.current() );
  var to = _.fileProvider.recordFactory().record( _.path.dir( _.path.current() ) );
  var expected = '../';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  _.fileProvider.fieldPush( 'safe', 0 );

  var from = _.fileProvider.recordFactory().record( '/a/b/c');
  var to = _.fileProvider.recordFactory().record( '/a' );
  var expected = '../..';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  var from = _.fileProvider.recordFactory().record( '/a/b/c' );
  var to = '/a'
  var expected = '../..';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  var from = '/a'
  var to = _.fileProvider.recordFactory().record( '/a/b/c' );
  var expected = 'b/c';
  var got = _.path.relative( from, to );
  test.identical( got, expected );

  // _.path.relative accepts only two arguments

  // test.case = 'both relative, long, not direct, resolving : 1'; /* */
  // var from = 'a/b/xx/yy/zz';
  // var to = 'a/b/files/x/y/z.txt';
  // var expected = '../../../files/x/y/z.txt';
  // var got = _.path.relative({ relative : from, path : to, resolving : 1 });
  // test.identical( got, expected );

  // test.case = 'both relative, long, not direct,resolving 1'; /* */
  // var from = 'a/b/xx/yy/zz';
  // var to = 'a/b/files/x/y/z.txt';
  // var expected = '../../../files/x/y/z.txt';
  // var o =
  // {
  //   relative :  from,
  //   path : to,
  //   resolving : 1
  // }
  // var got = _.path.s.relative( o );
  // test.identical( got, expected );

  _.fileProvider.fieldPop( 'safe', 0 );
}

//

// function pathDirTempForTrivial( test )
// {
//   test.case = 'file is on same device with os temp';
//   var filePath = _.path.join( _.path.dirTemp(), 'file' );
//   var tempPath = _.path.pathDirTempOpen( filePath );
//   test.identical( pathDeviceGet( tempPath ), pathDeviceGet( filePath ) )
//   test.is( _.path.fileProvider.isDir( tempPath ) );
//   test.will = 'second call should return same temp dir path';
//   var tempPath2 = _.path.pathDirTempOpen( filePath );
//   test.identical( pathDeviceGet( tempPath2 ), pathDeviceGet( filePath ) )
//   test.identical( tempPath, tempPath2 );
//   _.path.pathDirTempClose( tempPath );
//   test.is( !_.path.fileProvider.fileExists( tempPath ) );
//   test.shouldThrowErrorSync( () => _.path.pathDirTempClose( filePath ) )

//   test.case = 'file is on different device';
//   var filePath = _.path.normalize( __filename );
//   var tempPath = _.path.pathDirTempOpen( filePath );
//   test.identical( pathDeviceGet( tempPath ), pathDeviceGet( filePath ) )
//   test.is( _.path.fileProvider.isDir( tempPath ) );
//   _.path.pathDirTempClose( tempPath );
//   test.is( !_.path.fileProvider.fileExists( tempPath ) );

//   test.case = 'same temp path each call'
//   var filePath = _.path.normalize( __filename );
//   var tempPath = _.path.pathDirTempOpen( filePath );
//   var tempPath2 = _.path.pathDirTempOpen( filePath );
//   test.identical( pathDeviceGet( tempPath ), pathDeviceGet( tempPath2 ) )
//   test.identical( tempPath,tempPath2 );
//   test.is( _.path.fileProvider.isDir( tempPath ) );
//   _.path.fileProvider.fileDelete({ filePath : tempPath, safe : 0 });
//   _.path.fileProvider.filesDelete({ filePath : tempPath2, safe : 0 });

//   test.case = 'new temp path each call'
//   var filePath = _.path.normalize( __filename );
//   var tempPath = _.path.pathDirTempMake( filePath );
//   var tempPath2 = _.path.pathDirTempMake( filePath );
//   test.is( _.path.fileProvider.isDir( tempPath ) );
//   test.is( _.path.fileProvider.isDir( tempPath2 ) );
//   test.notIdentical( tempPath,tempPath2 );
//   _.path.fileProvider.fileDelete({ filePath : tempPath, safe : 0 });
//   _.path.fileProvider.fileDelete({ filePath : tempPath2, safe : 0 });

//   test.case = 'path to root of device';
//   var filePath = pathDeviceGet( _.path.normalize( __filename ) );
//   var possiblePath = _.path.join( filePath, 'tmp-' + _.idWithGuid() + '.tmp' );
//   var shouldThrowErrorSync = false;
//   try
//   {
//     _.path.fileProvider.dirMake( possiblePath );
//     _.path.fileProvider.fileDelete({ filePath : possiblePath, safe : 0 });
//   }
//   catch( err )
//   {
//     shouldThrowErrorSync = true;
//   }
//   if( shouldThrowErrorSync )
//   {
//     test.shouldThrowErrorSync( () =>
//     {
//       _.path.pathDirTempMake( possiblePath );
//       // routine pathDirTempMake make correct filePath
//       // _.path.pathDirTempMake( filePath );
//     })
//   }
//   else
//   {
//     var tempPath = _.path.pathDirTempMake( filePath );
//     test.is( _.path.fileProvider.isDir( tempPath ) );
//     _.path.fileProvider.fileDelete({ filePath : tempPath, safe : 0 });
//   }


//   test.case = 'close removes only temp dirs made by open';
//   var filePath = _.path.normalize( __filename );
//   var tempPath = _.path.pathDirTempOpen( filePath );
//   _.path.pathDirTempClose( tempPath );
//   test.is( !_.path.fileProvider.fileExists( tempPath ) );
//   test.will = 'repeat close call on same temp dir path, should throw error'
//   test.shouldThrowErrorSync( () => _.path.pathDirTempClose( tempPath ) );
//   test.will = 'try to close other dir, should throw error'
//   test.shouldThrowErrorSync( () => _.path.pathDirTempClose( _.path.dir( filePath ) ) );

//   //

//   // var filePath = _.path.join( _.path.dirTemp(), 'file' );
//   // var t1 = _.timeNow();
//   // var tempPath;
//   // for( var i = 0; i < 100; i++ )
//   // {
//   //   tempPath = _.path.pathDirTempOpen( filePath );
//   // }
//   // var t2 = _.timeNow();
//   // logger.log( 'pathDirTempOpen:', t2 - t1 )
//   // _.path.pathDirTempClose( tempPath );

//   //

//   // var filePath = _.path.join( _.path.dirTemp(), 'file' );
//   // var t1 = _.timeNow();
//   // var paths = [];
//   // for( var i = 0; i < 100; i++ )
//   // {
//   //   paths.push( _.path.pathDirTempMake( filePath ) );
//   // }
//   // var t2 = _.timeNow();
//   // logger.log( 'pathDirTempMake:', t2 - t1 )
//   // _.each( paths, ( p ) =>
//   // {
//   //   _.path.fileProvider.fileDelete( p );
//   // })

//   /* */

//   function pathDeviceGet( filePath )
//   {
//     return filePath.substring( 0, filePath.indexOf( '/', 1 ) );
//   }
// }

//

function pathDirTemp( test )
{
  let filesTree = Object.create( null );
  let extract = new _.FileProvider.Extract({ filesTree })
  var name = 'pathDirTempOpenTest';

  let cache = extract.path.PathDirTempForMap[ extract.id ] = Object.create( null );
  let count = extract.path.PathDirTempCountMap[ extract.id ] = Object.create( null );

  test.notIdentical( extract.id, _.fileProvider.id );

  //

  test.open( 'same drive' );

  var filePath1 = '/dir1'
  var got1 = extract.path.pathDirTempOpen({ filePath : filePath1, name });
  test.identical( cache[ filePath1 ], got1 );
  test.is( _.strHas( got1, name ) );
  test.is( extract.isDir( got1 ) );

  var filePath2 = '/dir1/dir2'
  var got2 = extract.path.pathDirTempOpen({ filePath : filePath2, name });
  test.identical( cache[ filePath2 ], got1 );
  test.is( _.strHas( got2, name ) );
  test.identical( got2, got1 );
  test.is( extract.isDir( got2 ) );

  var got1 = extract.path.pathDirTempOpen({ filePath : filePath1, name });
  var got2 = extract.path.pathDirTempOpen({ filePath : filePath2, name });
  test.identical( got2, got1 );
  test.is( extract.isDir( got1 ) );
  test.identical( cache[ filePath1 ], got1 );
  test.identical( cache[ filePath2 ], got2 );

  extract.path.pathDirTempClose( filePath1 );
  extract.path.pathDirTempClose( filePath2 );
  test.identical( cache[ filePath1 ], got1 );
  test.identical( cache[ filePath2 ], got2 );
  test.is( extract.isDir( got1 ) );
  test.is( extract.isDir( got2 ) );

  extract.path.pathDirTempClose( filePath1 );
  test.identical( cache[ filePath1 ], undefined );
  test.identical( cache[ filePath2 ], got2 );
  test.is( extract.isDir( got1 ) );
  test.is( extract.isDir( got2 ) );
  extract.path.pathDirTempClose( filePath2 );
  test.identical( cache[ filePath1 ], undefined );
  test.identical( cache[ filePath2 ], undefined );
  test.is( !extract.isDir( got1 ) );
  test.is( !extract.isDir( got2 ) );

  test.identical( count[ got1 ], undefined );
  test.identical( count[ got2 ], undefined );

  var got1 = extract.path.pathDirTempOpen({ filePath : filePath1, name });
  var got2 = extract.path.pathDirTempOpen({ filePath : filePath2, name });
  test.identical( got2, got1 );
  test.is( extract.isDir( got1 ) );
  test.identical( cache[ filePath1 ], got1 );
  test.identical( cache[ filePath2 ], got2 );
  debugger
  extract.path.pathDirTempClose();
  test.identical( cache[ filePath1 ], undefined );
  test.identical( cache[ filePath2 ], undefined );
  test.is( !extract.isDir( got1 ) );
  test.is( !extract.isDir( got2 ) );

  test.identical( count[ got1 ], undefined );
  test.identical( count[ got2 ], undefined );

  test.close( 'same drive' );

  /* */

  test.open( 'different drive' );

  var filePath1 = '/dir1'
  var filePath2 = '/dir1/dir2'

  extract.dirMake( filePath1 );
  extract.dirMake( filePath2 );

  extract.extraStats[ filePath1 ] = { dev : 1 }
  extract.extraStats[ filePath2 ] = { dev : 2 }

  var got1 = extract.path.pathDirTempOpen({ filePath : filePath1, name });
  var got2 = extract.path.pathDirTempOpen({ filePath : filePath2, name });
  test.notIdentical( got1, got2 );
  test.identical( extract.path.common( got2, filePath2 ), filePath2 )
  test.is( extract.isDir( got1 ) );
  test.is( extract.isDir( got2 ) );
  test.identical( cache[ filePath1 ], got1 );
  test.identical( cache[ filePath2 ], got2 );

  extract.path.pathDirTempClose( filePath1 );
  test.identical( cache[ filePath1 ], undefined );
  test.identical( cache[ filePath2 ], got2 );
  test.is( extract.isDir( got2 ) );
  extract.path.pathDirTempClose( filePath2 );
  test.identical( cache[ filePath1 ], undefined );
  test.identical( cache[ filePath2 ], undefined );
  test.is( !extract.isDir( got2 ) );

  test.close( 'different drive' );

  //

  test.open( 'os path' )

  var filePath1 = extract.path.dir( extract.path.dirTemp() );
  var got1 = extract.path.pathDirTempOpen({ filePath: filePath1, name });
  test.is( extract.isDir( got1 ) );
  test.is( _.strBegins( got1, '/temp' ) )
  test.identical( cache[ filePath1 ], got1 );

  var filePath2 = '/'
  var got2 = extract.path.pathDirTempOpen({ filePath : filePath2, name });
  test.is( extract.isDir( got2 ) );
  test.identical( got1,got2 );
  test.is( _.strBegins( got2, '/temp' ) );
  test.identical( cache[ filePath2 ], got2 );

  test.case = 'should return os temp path in case of error'

  var filePath3 = '/dir3'
  let originalDirMake = extract.dirMake;
  extract.dirMake = function dirMake( filePath )
  {
    if( _.strHas( filePath,'/dir3' ) )
    throw _.err( 'Test err');
    return originalDirMake.apply( extract, arguments );
  }
  var got2;
  test.mustNotThrowError( () =>
  {
    got2 = extract.path.pathDirTempOpen({ filePath : filePath3, name });
  })
  extract.dirMake = _.routineJoin( extract, originalDirMake )
  test.is( extract.isDir( got2 ) );
  test.is( _.strBegins( got2, extract.path.dirTemp() ) );
  test.identical( cache[ filePath3 ], got2 );

  test.close( 'os path' )

  //

  var filePath1 = '/dir1/dir3'
  test.shouldThrowErrorSync( () => extract.path.pathDirTempClose( filePath1 ) )

  //

  test.case = 'several runs of pathDirTempClose'
  test.mustNotThrowError( () =>
  {
    extract.path.pathDirTempClose();
    extract.path.pathDirTempClose();
  })
  test.identical( _.mapKeys( cache ).length, 0 );

  test.case = 'no args';
  var got = extract.path.pathDirTempOpen();
  test.is( _.strHas( got, '/tmp-' ) );
  test.is( extract.isDir( got ) );
  extract.path.pathDirTempClose( got );
  test.is( !extract.fileExists( got ) );

  test.case = 'single arg';
  var got = extract.path.pathDirTempOpen( 'packageName' );
  test.is( _.strHas( got, 'packageName' ) );
  test.is( extract.isDir( got ) );
  extract.path.pathDirTempClose( got );
  test.is( !extract.fileExists( got ) );

  test.case = 'single arg';
  var got = extract.path.pathDirTempOpen( 'someDir/packageName' );
  test.is( _.strHas( got, '/someDir/Temp' ) );
  test.is( extract.isDir( got ) );
  extract.path.pathDirTempClose( got );
  test.is( !extract.fileExists( got ) );

  test.case = 'two args';
  var got = extract.path.pathDirTempOpen( '/dir', 'packageName' );
  test.is( _.strHas( got, '/dir/Temp' ) );
  test.is( _.strHas( got, 'packageName' ) );
  test.is( extract.isDir( got ) );
  extract.path.pathDirTempClose( got );
  test.is( !extract.fileExists( got ) );

}


// --
// declare
// --

var Self =
{

  name : 'Tools.mid.files.Paths',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    suitePath : null,
    isBrowser : null,

    createTestsDirectory,
    createInTD,
    createTestFile,
    createTestSymLink,
    createTestResources
  },

  tests :
  {

    from,
    forCopy,

    pathResolve,
    pathsResolve,

    regexpMakeSafe,

    realMainFile,
    realMainDir,
    effectiveMainFile,
    effectiveMainDir,

    pathCurrent,
    pathCurrent2,

    relative,

    // pathDirTempForTrivial,

    pathDirTemp

  },

}

//

Self = wTestSuite( Self )
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
