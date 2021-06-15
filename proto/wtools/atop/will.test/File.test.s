( function _File_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );

  require( '../will/include/Mid.s' );
}

let _global = _global_;
let _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let context = this;

  context.suiteTempPath = _.path.tempOpen( _.path.join( __dirname, '../..'  ), 'willbe' );
  context.assetsOriginalPath = _.path.join( __dirname, '_asset' );
  context.repoDirPath = _.path.join( context.assetsOriginalPath, '-repo' );

  let reposDownload = require( './ReposDownload.s' );
  return reposDownload().then( () =>
  {
    _.assert( _.fileProvider.isDir( _.path.join( context.repoDirPath, 'ModuleForTesting1' ) ) );
    return null;
  });
}

//

function onSuiteEnd()
{
  let context = this;
  _.assert( _.strHas( context.suiteTempPath, '/willbe-' ) )
  _.path.tempClose( context.suiteTempPath );
}

//

function assetFor( test, name )
{
  let context = this;

  if( !name )
  name = test.name;

  let a = test.assetFor( name );

  a.will = new _.Will;

  a.find = a.fileProvider.filesFinder
  ({
    withTerminals : 1,
    withDirs : 1,
    withStem : 1,
    allowingMissed : 1,
    maskPreset : 0,
    outputFormat : 'relative',
    filter :
    {
      recursive : 2,
      maskAll :
      {
        excludeAny : [ /(^|\/)\.git($|\/)/, /(^|\/)\+/ ],
      },
      maskTransientAll :
      {
        excludeAny : [ /(^|\/)\.git($|\/)/, /(^|\/)\+/ ],
      },
    },
  });


  a.findNoModules = a.fileProvider.filesFinder
  ({
    withTerminals : 1,
    withDirs : 1,
    withStem : 1,
    allowingMissed : 1,
    maskPreset : 0,
    outputFormat : 'relative',
    filter :
    {
      recursive : 2,
      maskAll :
      {
        excludeAny : [ /(^|\/)\.git($|\/)/, /(^|\/)\+/, /(^|\/)\.module\/.*/ ],
      },
      maskTransientAll :
      {
        excludeAny : [ /(^|\/)\.git($|\/)/, /(^|\/)\+/, /(^|\/)\.module\/.*/ ],
      },
    },
  });

  a.reflect = function reflect()
  {
    a.fileProvider.filesDelete( a.routinePath );
    a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.routinePath } });
    try
    {
      a.fileProvider.filesReflect({ reflectMap : { [ context.repoDirPath ] : a.abs( context.suiteTempPath, '_repo' ) } });
    }
    catch( err )
    {
      _.errAttend( err );
      _.Consequence().take( null )
      .delay( 3000 )
      .deasync();
      a.fileProvider.filesDelete( a.abs( context.suiteTempPath, '_repo' ) );
      a.fileProvider.filesReflect({ reflectMap : { [ context.repoDirPath ] : a.abs( context.suiteTempPath, '_repo' ) } });
    }
  }

  _.assert( a.fileProvider.isDir( a.originalAssetPath ) );

  return a;
}

// --
// tests
// --

function fileClassify( test )
{
  test.case = 'root - /';
  var got = _.will.fileClassify( '/' );
  test.identical( got, { filePath : '/' } );

  test.case = 'not willfile';
  var got = _.will.fileClassify( '/a/abc' );
  test.identical( got, { filePath : '/a/abc' } );

  /* */

  test.case = 'will.yml';
  var got = _.will.fileClassify( '/a/will.yml' );
  test.identical( got, { filePath : '/a/will.yml', role : 'single', out : false } );

  test.case = '.will.yml';
  var got = _.will.fileClassify( '/a/.will.yml' );
  test.identical( got, { filePath : '/a/.will.yml', role : 'single', out : false } );

  test.case = '.ex.will.yml';
  var got = _.will.fileClassify( '/a/.ex.will.yml' );
  test.identical( got, { filePath : '/a/.ex.will.yml', role : 'export', out : false } );

  test.case = '.im.will.yml';
  var got = _.will.fileClassify( '/a/.im.will.yml' );
  test.identical( got, { filePath : '/a/.im.will.yml', role : 'import', out : false } );

  test.case = '.out.will.yml';
  var got = _.will.fileClassify( '/a/.out.will.yml' );
  test.identical( got, { filePath : '/a/.out.will.yml', role : 'single', out : true } );

  /* */

  test.case = 'Namedwill.yml';
  var got = _.will.fileClassify( '/a/Namedwill.yml' );
  test.identical( got, { filePath : '/a/Namedwill.yml' } );

  test.case = 'Named.will.yml';
  var got = _.will.fileClassify( '/a/Named.will.yml' );
  test.identical( got, { filePath : '/a/Named.will.yml', role : 'single', out : false } );

  test.case = 'Named.ex.will.yml';
  var got = _.will.fileClassify( '/a/Named.ex.will.yml' );
  test.identical( got, { filePath : '/a/Named.ex.will.yml', role : 'export', out : false } );

  test.case = 'Named.im.will.yml';
  var got = _.will.fileClassify( '/a/Named.im.will.yml' );
  test.identical( got, { filePath : '/a/Named.im.will.yml', role : 'import', out : false } );

  test.case = 'Named.out.will.yml';
  var got = _.will.fileClassify( '/a/Named.out.will.yml' );
  test.identical( got, { filePath : '/a/Named.out.will.yml', role : 'single', out : true } );

  /* */

  test.case = 'another valid extension - will.json';
  var got = _.will.fileClassify( '/a/will.json' );
  test.identical( got, { filePath : '/a/will.json', role : 'single', out : false } );

  test.case = 'another valid extension - .will.json';
  var got = _.will.fileClassify( '/a/.will.json' );
  test.identical( got, { filePath : '/a/.will.json', role : 'single', out : false } );

  test.case = 'another not valid extension - will.txt';
  var got = _.will.fileClassify( '/a/will.txt' );
  test.identical( got, { filePath : '/a/will.txt' } );

  test.case = 'another valid extension - .will.txt';
  var got = _.will.fileClassify( '/a/.will.txt' );
  test.identical( got, { filePath : '/a/.will.txt' } );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.fileClassify() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.fileClassify( '/', '/.will.yml' ) );

  test.case = 'not absolute path';
  test.shouldThrowErrorSync( () => _.will.fileClassify( './.will.yml' ) );
  test.shouldThrowErrorSync( () => _.will.fileClassify( 'hd:///.will.yml' ) );
}

//

function fileAt( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );
  a.fileProvider.dirMake( a.abs( '.' ) );

  /* */

  test.case = 'directory without willfiles';
  var got = _.will.fileAt( a.abs( '.' ) );
  test.identical( got, [] );

  test.case = 'path to unnamed willfile, willfile does not exist';
  var got = _.will.fileAt( a.abs( './.im.will.yml' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, willfile does not exist';
  var got = _.will.fileAt( a.abs( './Author.will.yml' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, not full path';
  var got = _.will.fileAt( a.abs( './Author' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.fileAt( a.abs( './Author.will' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.will.fileAt( a.abs( './.im' ) );
  test.identical( got, [] );

  test.case = 'path to directory named as willfile';
  var got = _.will.fileAt( a.abs( './Author/' ) );
  test.identical( got, [] );

  /* */

  a.reflect();

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.fileAt( a.abs( './' ) );
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.fileAt( a.abs( './' ) );
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.will.fileAt( a.abs( './.im.will.yml' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.will.fileAt( a.abs( './Author.will.yml' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.will.fileAt( a.abs( './Author' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.fileAt( a.abs( './Author.will' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.will.fileAt( a.abs( './.im' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.fileAt( a.abs( './Author/' ) );
  test.identical( got, [] );

  /* */

  a.reflect();

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.will.fileAt({ commonPath : a.abs( './.im.will.yml' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.will.fileAt({ commonPath : a.abs( './Author.will.yml' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.fileAt({ commonPath : a.abs( './Author.will' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.will.fileAt({ commonPath : a.abs( './.im' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.fileAt({ commonPath : a.abs( './Author/' ) });
  test.identical( got, [] );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.fileAt() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.fileAt( a.abs( './' ), a.abs( './' ) ) );

  test.case = 'commonPath is terminal file, not willfile';
  test.shouldThrowErrorSync( () => _.will.fileAt( a.abs( './proto/File.s' ) ) );

  test.case = 'commonPath is global path';
  test.shouldThrowErrorSync( () => _.will.fileAt( a.abs( 'hd:///home/' ) ) );

  test.case = 'commonPath is path with glob';
  test.shouldThrowErrorSync( () => _.will.fileAt( a.abs( './**' ) ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.will.fileAt([ a.abs( './' ) ]) );

  test.case = 'unknown option in options map';
  test.shouldThrowErrorSync( () => _.will.fileAt({ commonPath : a.abs( './' ), unknown : 1 }) );

  test.case = 'withIn - 0 and withOut - 0';
  test.shouldThrowErrorSync( () => _.will.fileAt({ commonPath : a.abs( './' ), withIn : 0, withOut : 0 }) );
}

//

function fileAtWithOptions( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* */

  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( '.out.will.yml' ) });

  test.case = 'path to dir, withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withIn : 1, withOut : 0 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir, withIn - 1, withOut - 0, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withIn : 1, withOut : 0, withSingle : 0 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir, withIn - 1, withOut - 0, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withIn : 1, withOut : 0, withImport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );

  test.case = 'path to dir, withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withIn : 1, withOut : 0, withExport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  /* */

  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( '.out.will.yml' ) });

  test.case = 'path to dir, withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withIn : 0, withOut : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.out.will.yml' ) );

  test.case = 'path to dir, withIn - 0, withOut - 1, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withIn : 0, withOut : 1, withSingle : 0 });
  test.identical( got, [] );

  test.case = 'path to dir, withIn - 0, withOut - 1, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withIn : 0, withOut : 1, withImport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.out.will.yml' ) );

  test.case = 'path to dir, withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withIn : 0, withOut : 1, withExport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.out.will.yml' ) );

  /* */

  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'Author.out.will.yml' ) });

  test.case = 'path to named willfile, withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ), withIn : 1, withOut : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, withIn - 1, withOut - 0, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ), withIn : 1, withOut : 0, withSingle : 0 });
  test.identical( got, [] );

  test.case = 'path to named willfile, withIn - 1, withOut - 0, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ), withIn : 1, withOut : 0, withImport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ), withIn : 1, withOut : 0, withExport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  /* */

  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'Author.out.will.yml' ) });

  test.case = 'path to named willfile, withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ), withIn : 0, withOut : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.out.will.yml' ) );

  test.case = 'path to named willfile, withIn - 0, withOut - 1, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ), withIn : 0, withOut : 1, withSingle : 0 });
  test.identical( got, [] );

  test.case = 'path to named willfile, withIn - 0, withOut - 1, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ), withIn : 0, withOut : 1, withImport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.out.will.yml' ) );

  test.case = 'path to named willfile, withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.fileAt({ commonPath : a.abs( './Author' ), withIn : 0, withOut : 1, withExport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.out.will.yml' ) );

  /* */

  test.case = 'path to dir, fileProvider - _.fileProvider';
  a.reflect();
  var got = _.will.fileAt({ commonPath : a.abs( './' ), fileProvider : _.fileProvider });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  /* */

  test.case = 'path to dir, withSingle - 0, has single files';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withSingle : 1 });
  test.identical( got.length, 2 );
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withSingle : 0 });
  test.identical( got.length, 0 );
}

fileAtWithOptions.rapidity = -1;
fileAtWithOptions.timeOut = 200000;

//

function fileAtWillfilesWithDifferentExtensions( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* */

  test.case = 'path to dir, standard exetensions';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( './Author.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './Version.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './.im.will.yml' ) );

  /* */

  test.case = 'path to dir, not standard exetensions';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( './Author.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './Contributors.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './Keywords.will.yml' ), dstPath : a.abs( 'will.json' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './License.will.yml' ), dstPath : a.abs( '.will.json' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './Name.will.yml' ), dstPath : a.abs( '.im.will.json' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './Version.will.yml' ), dstPath : a.abs( '.ex.will.json' ) });
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 8 );
  test.identical( got[ 0 ].filePath, a.abs( './will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 4 ].filePath, a.abs( './will.json' ) );
  test.identical( got[ 5 ].filePath, a.abs( './.will.json' ) );
  test.identical( got[ 6 ].filePath, a.abs( './.ex.will.json' ) );
  test.identical( got[ 7 ].filePath, a.abs( './.im.will.json' ) );

  /* */

  test.case = 'path to dir, not supported exetensions';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( './Author.will.yml' ), dstPath : a.abs( 'will.bson' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './Contributors.will.yml' ), dstPath : a.abs( '.will.bson' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './Keywords.will.yml' ), dstPath : a.abs( 'will.cson' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './License.will.yml' ), dstPath : a.abs( '.will.cson' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './Name.will.yml' ), dstPath : a.abs( '.im.will.cson' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './Version.will.yml' ), dstPath : a.abs( '.ex.will.cson' ) });
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
}

//

function fileAtWillfilesInSubdirectories( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* */

  test.case = 'path to dir, no willfiles in subdirectory';
  a.reflect();
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  /* */

  test.case = 'path to dir, withAllNamed - 1, willfiles in subdirectory';
  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
}

//

function filesAtCommonPathWithoutGlobs( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );
  a.fileProvider.dirMake( a.abs( '.' ) );

  /* */

  test.case = 'directory without willfiles';
  var got = _.will.filesAt( a.abs( '.' ) );
  test.identical( got, [] );

  test.case = 'path to unnamed willfile, willfile does not exist';
  var got = _.will.filesAt( a.abs( './.im.will.yml' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, willfile does not exist';
  var got = _.will.filesAt( a.abs( './Author.will.yml' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, not full path';
  var got = _.will.filesAt( a.abs( './Author' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.filesAt( a.abs( './Author.will' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.will.filesAt( a.abs( './.im' ) );
  test.identical( got, [] );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt( a.abs( './Author/' ) );
  test.identical( got, [] );

  /* */

  a.reflect();

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.filesAt( a.abs( './' ) );
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt( a.abs( './' ) );
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.will.filesAt( a.abs( './.im.will.yml' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.will.filesAt( a.abs( './Author.will.yml' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.will.filesAt( a.abs( './Author' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.filesAt( a.abs( './Author.will' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.will.filesAt( a.abs( './.im' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt( a.abs( './Author/' ) );
  test.identical( got, [] );

  /* */

  a.reflect();

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.filesAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.will.filesAt({ commonPath : a.abs( './.im.will.yml' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.will.filesAt({ commonPath : a.abs( './Author.will.yml' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.filesAt({ commonPath : a.abs( './Author.will' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.will.filesAt({ commonPath : a.abs( './.im' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt({ commonPath : a.abs( './Author/' ) });
  test.identical( got, [] );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.filesAt() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.filesAt( a.abs( './' ), a.abs( './' ) ) );

  test.case = 'commonPath is terminal file, not willfile';
  test.shouldThrowErrorSync( () => _.will.filesAt( a.abs( './proto/File.s' ) ) );

  test.case = 'commonPath is path with glob, recursive - 0';
  test.shouldThrowErrorSync( () => _.will.filesAt({ commonPath : a.abs( './**' ), recursive : 0 }) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.will.filesAt([ a.abs( './' ) ]) );

  test.case = 'unknown option in options map';
  test.shouldThrowErrorSync( () => _.will.filesAt({ commonPath : a.abs( './' ), unknown : 1 }) );

  test.case = 'withIn - 0 and withOut - 0';
  test.shouldThrowErrorSync( () => _.will.filesAt({ commonPath : a.abs( './' ), withIn : 0, withOut : 0 }) );
}

//

function filesAtCommonPathWithGlobs( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* - */

  test.open( 'no willfiles' );

  test.case = 'directory without willfiles';
  var got = _.will.filesAt( a.abs( './*' ) );
  test.identical( got, [] );

  test.case = 'path to unnamed willfile, willfile does not exist';
  var got = _.will.filesAt( a.abs( './.im.will.yml*' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, willfile does not exist';
  var got = _.will.filesAt( a.abs( './Author.will.yml*' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, not full path';
  var got = _.will.filesAt( a.abs( './Author*' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.filesAt( a.abs( './Author.will*' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.will.filesAt( a.abs( './.im*' ) );
  test.identical( got, [] );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt( a.abs( './Author/*' ) );
  test.identical( got, [] );

  test.close( 'no willfiles' );

  /* - */

  test.open( 'glob - ./*' );

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.filesAt( a.abs( './*' ) );
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt( a.abs( './*' ) );
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.will.filesAt( a.abs( './.im.will.yml*' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.will.filesAt( a.abs( './Author.will.yml*' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.will.filesAt( a.abs( './Author*' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.filesAt( a.abs( './Author.will*' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.will.filesAt( a.abs( './.im*' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt( a.abs( './Author/*' ) );
  test.identical( got, [] );

  /* */

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.filesAt({ commonPath : a.abs( './*' ) });
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt({ commonPath : a.abs( './*' ) });
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.will.filesAt({ commonPath : a.abs( './.im.will.yml' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.will.filesAt({ commonPath : a.abs( './Author.will.yml*' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.will.filesAt({ commonPath : a.abs( './Author*' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.filesAt({ commonPath : a.abs( './Author.will*' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.will.filesAt({ commonPath : a.abs( './.im*' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt({ commonPath : a.abs( './Author/*' ) });
  test.identical( got, [] );

  test.close( 'glob - ./*' );

  /* - */

  test.open( 'glob - ./**' );

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.filesAt({ commonPath : a.abs( './**' ) });
  test.identical( got.length, 34 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 17 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 18 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt({ commonPath : a.abs( './**' ) });
  test.identical( got.length, 34 );
  test.identical( got[ 0 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 17 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 18 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.will.filesAt({ commonPath : a.abs( './Author.will.yml**' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.will.filesAt({ commonPath : a.abs( './Author**' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.filesAt({ commonPath : a.abs( './Author.will**' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  a.reflect();
  var got = _.will.filesAt({ commonPath : a.abs( './.im**' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt({ commonPath : a.abs( './Author/**' ) });
  test.identical( got, [] );

  test.close( 'glob - ./**' );

  /* - */

  test.open( 'glob - */*' );

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.filesAt({ commonPath : a.abs( '*/*' ) });
  test.identical( got.length, 34 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 17 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 18 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt({ commonPath : a.abs( '*/*' ) });
  test.identical( got.length, 34 );
  test.identical( got[ 0 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 17 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 18 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author.will.yml*' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author*' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author.will*' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });
  var got = _.will.filesAt({ commonPath : a.abs( '*/.im*' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author/*' ) });
  test.identical( got, [] );

  test.close( 'glob - */*' );

  /* - */

  test.open( 'glob - */**' );

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.filesAt({ commonPath : a.abs( '*/**' ) });
  test.identical( got.length, 34 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 17 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 18 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt({ commonPath : a.abs( '*/**' ) });
  test.identical( got.length, 34 );
  test.identical( got[ 0 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 17 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 18 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author.will.yml**' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author**' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author.will**' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });
  var got = _.will.filesAt({ commonPath : a.abs( '*/.im**' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author/**' ) });
  test.identical( got, [] );

  test.close( 'glob - */**' );
}

filesAtCommonPathWithGlobs.rapidity = -1;
filesAtCommonPathWithGlobs.timeOut = 3e5;

//

function filesAtCommonPathWithGlobsWithTrailedPath( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* - */

  test.open( 'glob - */' );

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.filesAt({ commonPath : a.abs( '*/' ) });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt({ commonPath : a.abs( '*/' ) });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author/' ) });
  test.identical( got, [] );

  test.close( 'glob - */' );

  /* - */

  test.open( 'glob - */**/' );

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.will.filesAt({ commonPath : a.abs( '*/**/' ) });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt({ commonPath : a.abs( '*/**/' ) });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author/' ) });
  test.identical( got, [] );

  test.close( 'glob - */**/' );
}

//

function filesAtCommonPathWithoutGlobsWithOptions( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* */

  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( '.out.will.yml' ) });

  test.case = 'path to dir, withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.filesAt({ commonPath : a.abs( './' ), withIn : 1, withOut : 0 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir, withIn - 1, withOut - 0, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.filesAt({ commonPath : a.abs( './' ), withIn : 1, withOut : 0, withSingle : 0 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir, withIn - 1, withOut - 0, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.filesAt({ commonPath : a.abs( './' ), withIn : 1, withOut : 0, withImport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );

  test.case = 'path to dir, withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.filesAt({ commonPath : a.abs( './' ), withIn : 1, withOut : 0, withExport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );

  /* */

  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( '.out.will.yml' ) });

  test.case = 'path to dir, withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.filesAt({ commonPath : a.abs( './' ), withIn : 0, withOut : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.out.will.yml' ) );

  test.case = 'path to dir, withIn - 0, withOut - 1, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.filesAt({ commonPath : a.abs( './' ), withIn : 0, withOut : 1, withSingle : 0 });
  test.identical( got, [] );

  test.case = 'path to dir, withIn - 0, withOut - 1, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.filesAt({ commonPath : a.abs( './' ), withIn : 0, withOut : 1, withImport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.out.will.yml' ) );

  test.case = 'path to dir, withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.filesAt({ commonPath : a.abs( './' ), withIn : 0, withOut : 1, withExport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.out.will.yml' ) );

  /* */

  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'Author.out.will.yml' ) });

  test.case = 'path to named willfile, withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ), withIn : 1, withOut : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, withIn - 1, withOut - 0, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ), withIn : 1, withOut : 0, withSingle : 0 });
  test.identical( got, [] );

  test.case = 'path to named willfile, withIn - 1, withOut - 0, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ), withIn : 1, withOut : 0, withImport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ), withIn : 1, withOut : 0, withExport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.will.yml' ) );

  /* */

  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'Author.out.will.yml' ) });

  test.case = 'path to named willfile, withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ), withIn : 0, withOut : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.out.will.yml' ) );

  test.case = 'path to named willfile, withIn - 0, withOut - 1, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ), withIn : 0, withOut : 1, withSingle : 0 });
  test.identical( got, [] );

  test.case = 'path to named willfile, withIn - 0, withOut - 1, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ), withIn : 0, withOut : 1, withImport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.out.will.yml' ) );

  test.case = 'path to named willfile, withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.will.filesAt({ commonPath : a.abs( './Author' ), withIn : 0, withOut : 1, withExport : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.out.will.yml' ) );

  /* */

  test.case = 'path to dir, fileProvider - _.fileProvider';
  a.reflect();
  var got = _.will.filesAt({ commonPath : a.abs( './' ), fileProvider : _.fileProvider });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  /* */

  test.case = 'path to dir, withSingle - 0, has single files';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt({ commonPath : a.abs( './' ), withSingle : 1 });
  test.identical( got.length, 2 );
  var got = _.will.filesAt({ commonPath : a.abs( './' ), withSingle : 0 });
  test.identical( got.length, 0 );
}

filesAtCommonPathWithoutGlobsWithOptions.rapidity = -1;
filesAtCommonPathWithoutGlobsWithOptions.timeOut = 3e5;

//

function filesAtCommonPathWithGlobsWithOptions( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* - */

  test.open( 'glob - ./*' );

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });
  a.fileProvider.fileRename({ srcPath : a.abs( './Version.will.yml' ), dstPath : a.abs( 'Version.out.will.yml' ) });

  test.case = 'withIn - 1, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( './*' ),
    withIn : 1,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( './*' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Version.out.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( './*' ),
    withIn : 0,
    withOut : 1,
    withSingle : 0,
    withImport : 1,
    withExport : 1
  });
  test.identical( got, [] );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( './*' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 0,
    withExport : 1
  });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Version.out.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( './*' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 0
  });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Version.out.will.yml' ) );

  /* */

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( './*' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 16 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( './*' ),
    withIn : 1,
    withOut : 0,
    withSingle : 0,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( './*' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 0,
    withExport : 1
  });
  test.identical( got.length, 15 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './Author.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( './*' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 1,
    withExport : 0
  });
  test.identical( got.length, 15 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './Author.will.yml' ) );

  test.close( 'glob - ./*' );

  /* - */

  test.open( 'glob - */**' );

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });
  a.fileProvider.fileRename({ srcPath : a.abs( './Version.will.yml' ), dstPath : a.abs( 'Version.out.will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './proto/Version.will.yml' ), dstPath : a.abs( 'proto/Version.out.will.yml' ) });

  test.case = 'withIn - 1, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/**' ),
    withIn : 1,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 34 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 17 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 18 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/**' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './Version.out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/Version.out.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/**' ),
    withIn : 0,
    withOut : 1,
    withSingle : 0,
    withImport : 1,
    withExport : 1
  });
  test.identical( got, [] );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/**' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 0,
    withExport : 1
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './Version.out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/Version.out.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/**' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 0
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './Version.out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/Version.out.will.yml' ) );

  /* */

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/**' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 32 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 16 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 17 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/**' ),
    withIn : 1,
    withOut : 0,
    withSingle : 0,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/**' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 0,
    withExport : 1
  });
  test.identical( got.length, 30 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 15 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 16 ].filePath, a.abs( './proto/Author.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/**' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 1,
    withExport : 0
  });
  test.identical( got.length, 30 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './Author.will.yml' ) );
  test.identical( got[ 15 ].filePath, a.abs( './proto/.im.will.yml' ) );
  test.identical( got[ 16 ].filePath, a.abs( './proto/Author.will.yml' ) );

  test.close( 'glob - */**' );
}

filesAtCommonPathWithGlobsWithOptions.rapidity = -1;

//

function filesAtCommonPathWithGlobsWithTrailedPathWithOptions( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* - */

  test.open( 'glob - */' );

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });
  a.fileProvider.fileRename({ srcPath : a.abs( './Version.will.yml' ), dstPath : a.abs( 'out.will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './proto/Version.will.yml' ), dstPath : a.abs( 'proto/out.will.yml' ) });

  test.case = 'withIn - 1, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/' ),
    withIn : 1,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 6 );
  test.identical( got[ 0 ].filePath, a.abs( './out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/out.will.yml' ) );
  test.identical( got[ 4 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 5 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/out.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/' ),
    withIn : 0,
    withOut : 1,
    withSingle : 0,
    withImport : 1,
    withExport : 1
  });
  test.identical( got, [] );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 0,
    withExport : 1
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/out.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 0
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/out.will.yml' ) );

  /* */

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/' ),
    withIn : 1,
    withOut : 0,
    withSingle : 0,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 0,
    withExport : 1
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/.ex.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '*/' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 1,
    withExport : 0
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.close( 'glob - */' );

  /* - */

  test.open( 'glob - **/' );

  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });
  a.fileProvider.fileRename({ srcPath : a.abs( './Version.will.yml' ), dstPath : a.abs( 'out.will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './proto/Version.will.yml' ), dstPath : a.abs( 'proto/out.will.yml' ) });

  test.case = 'withIn - 1, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '**/' ),
    withIn : 1,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 6 );
  test.identical( got[ 0 ].filePath, a.abs( './out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/out.will.yml' ) );
  test.identical( got[ 4 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 5 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '**/' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/out.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '**/' ),
    withIn : 0,
    withOut : 1,
    withSingle : 0,
    withImport : 1,
    withExport : 1
  });
  test.identical( got, [] );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '**/' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 0,
    withExport : 1
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/out.will.yml' ) );

  test.case = 'withIn - 0, withOut - 1, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '**/' ),
    withIn : 0,
    withOut : 1,
    withSingle : 1,
    withImport : 1,
    withExport : 0
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './out.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/out.will.yml' ) );

  /* */

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '**/' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '**/' ),
    withIn : 1,
    withOut : 0,
    withSingle : 0,
    withImport : 1,
    withExport : 1
  });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.ex.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 0, withExport - 1';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '**/' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 0,
    withExport : 1
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/.ex.will.yml' ) );

  test.case = 'withIn - 1, withOut - 0, withSingle - 1, withImport - 1, withExport - 0';
  var got = _.will.filesAt
  ({
    commonPath : a.abs( '**/' ),
    withIn : 1,
    withOut : 0,
    withSingle : 1,
    withImport : 1,
    withExport : 0
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './proto/.im.will.yml' ) );

  test.close( 'glob - **/' );
}

filesAtCommonPathWithGlobsWithTrailedPathWithOptions.rapidity = -1;

//

function filePathIs( test )
{
  test.case = 'empty string';
  var got = _.will.filePathIs( '' );
  test.identical( got, false );

  test.case = 'simple string';
  var got = _.will.filePathIs( 'abc' );
  test.identical( got, false );

  /* */

  test.case = 'will';
  var got = _.will.filePathIs( 'will' );
  test.identical( got, false );

  test.case = 'will.';
  var got = _.will.filePathIs( 'will.' );
  test.identical( got, false );

  test.case = '.will';
  var got = _.will.filePathIs( '.will' );
  test.identical( got, false );

  test.case = '.will.';
  var got = _.will.filePathIs( '.will.' );
  test.identical( got, false );

  test.case = 'will.yml';
  var got = _.will.filePathIs( 'will.yml' );
  test.identical( got, true );

  test.case = 'will.json';
  var got = _.will.filePathIs( 'will.yml' );
  test.identical( got, true );

  test.case = '.will.yml';
  var got = _.will.filePathIs( '.will.yml' );
  test.identical( got, true );

  test.case = '.will.json';
  var got = _.will.filePathIs( '.will.yml' );
  test.identical( got, true );

  /* */

  test.case = 'out.will';
  var got = _.will.filePathIs( 'out.will' );
  test.identical( got, false );

  test.case = 'out.will.';
  var got = _.will.filePathIs( 'out.will.' );
  test.identical( got, false );

  test.case = 'out.will.yml';
  var got = _.will.filePathIs( 'out.will.yml' );
  test.identical( got, true );

  test.case = '.im.will';
  var got = _.will.filePathIs( '.im.will' );
  test.identical( got, false );

  test.case = '.im.will.';
  var got = _.will.filePathIs( '.im.will.' );
  test.identical( got, false );

  test.case = '.im.will.yml';
  var got = _.will.filePathIs( '.im.will.yml' );
  test.identical( got, true );

  test.case = '.ex.will';
  var got = _.will.filePathIs( '.ex.will' );
  test.identical( got, false );

  test.case = '.ex.will.';
  var got = _.will.filePathIs( '.ex.will.' );
  test.identical( got, false );

  test.case = '.ex.will.yml';
  var got = _.will.filePathIs( '.ex.will.yml' );
  test.identical( got, true );

  /* */

  test.case = '/will.yml';
  var got = _.will.filePathIs( '/will.yml' );
  test.identical( got, true );

  test.case = '/.will.yml';
  var got = _.will.filePathIs( '/.will.yml' );
  test.identical( got, true );

  test.case = '/.im.will.yml';
  var got = _.will.filePathIs( '/.im.will.yml' );
  test.identical( got, true );

  test.case = '/.ex.will.yml';
  var got = _.will.filePathIs( '/.ex.will.yml' );
  test.identical( got, true );

  test.case = '/out.will.yml';
  var got = _.will.filePathIs( '/out.will.yml' );
  test.identical( got, true );

  /* */
  test.case = '/a/will.yml';
  var got = _.will.filePathIs( '/a/will.yml' );
  test.identical( got, true );

  test.case = '/a/.will.yml';
  var got = _.will.filePathIs( '/a/.will.yml' );
  test.identical( got, true );

  test.case = '/a/.im.will.yml';
  var got = _.will.filePathIs( '/a/.im.will.yml' );
  test.identical( got, true );

  test.case = '/a/.ex.will.yml';
  var got = _.will.filePathIs( '/a/.ex.will.yml' );
  test.identical( got, true );

  test.case = '/a/out.will.yml';
  var got = _.will.filePathIs( '/a/out.will.yml' );
  test.identical( got, true );

  /* */

  test.case = './will.yml';
  var got = _.will.filePathIs( './will.yml' );
  test.identical( got, true );

  test.case = './.will.yml';
  var got = _.will.filePathIs( './.will.yml' );
  test.identical( got, true );

  test.case = './.im.will.yml';
  var got = _.will.filePathIs( './.im.will.yml' );
  test.identical( got, true );

  test.case = './.ex.will.yml';
  var got = _.will.filePathIs( './.ex.will.yml' );
  test.identical( got, true );

  test.case = './out.will.yml';
  var got = _.will.filePathIs( './out.will.yml' );
  test.identical( got, true );

  /* */

  test.case = '/a/Named.will.yml';
  var got = _.will.filePathIs( '/a/Named.will.yml' );
  test.identical( got, true );

  test.case = '/a/Named.out.will.yml';
  var got = _.will.filePathIs( '/a/Named.out.will.yml' );
  test.identical( got, true );
}

//

function fileReadResource( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );
  a.reflect();

  /* - */

  test.case = 'commonPath - path to dir, resourceKind - about, resourceName - name';
  var got = _.will.fileReadResource
  ({
    commonPath : a.abs( './' ),
    resourceKind : 'about',
    resourceName : 'name',
  });
  test.identical( got, 'NpmFromWillfile' );

  test.case = 'commonPath - path with name of file, resourceKind - path, resourceName - proto';
  var got = _.will.fileReadResource
  ({
    commonPath : a.abs( './PathMain' ),
    resourceKind : 'path',
    resourceName : 'proto',
  });
  test.identical( got, { path : 'proto' } );

  test.case = 'commonPath - path with full name of file, resourceKind - reflector, resourceName - proto.debug';
  var got = _.will.fileReadResource
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'reflector',
    resourceName : 'proto.debug',
  });
  var exp =
  {
    inherit : 'predefined.*',
    criterion : { 'debug' : 1 },
    filePath : { 'path::proto' : '{path::out.*=1}/source' },
  };
  test.identical( got, exp );

  test.case = 'commonPath - path to dir, resourceKind - step, resourceName - unknown - resource not exists';
  var got = _.will.fileReadResource
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'step',
    resourceName : 'unknown',
  });
  test.identical( got, undefined );

  test.case = 'commonPath - path to file, file not exists, throwing - 0';
  var got = _.will.fileReadResource
  ({
    commonPath : a.abs( './Unknown.will.yml' ),
    resourceKind : 'path',
    resourceName : 'proto',
    throwing : 0,
  });
  test.identical( got, undefined );

  /* - */

  test.open( 'undefines in values of properties' );

  test.case = 'resourceKind - about, resourceName - enabled, boolLikeFalse - 0';
  var got = _.will.fileReadResource
  ({
    commonPath : a.abs( './Enabled.will.yml' ),
    resourceKind : 'about',
    resourceName : 'enabled',
  });
  test.identical( got, 0 );

  /* */

  test.case = 'resourceKind - about, resourceName - enabled, boolLikeFalse - false';
  _.will.fileWriteResource
  ({
    commonPath : a.abs( './Enabled.will.yml' ),
    resourceKind : 'about',
    resourceName : 'enabled',
    val : false,
  });

  var got = _.will.fileReadResource
  ({
    commonPath : a.abs( './Enabled.will.yml' ),
    resourceKind : 'about',
    resourceName : 'enabled',
  });
  test.identical( got, false );

  /* */

  test.case = 'resourceKind - about, resourceName - name, empty string';
  var got = _.will.fileReadResource
  ({
    commonPath : a.abs( './' ),
    resourceKind : 'about',
    resourceName : 'name',
  });
  test.identical( got, 'NpmFromWillfile' );

  _.will.fileWriteResource
  ({
    commonPath : a.abs( './' ),
    resourceKind : 'about',
    resourceName : 'name',
    val : '',
  });

  var got = _.will.fileReadResource
  ({
    commonPath : a.abs( './' ),
    resourceKind : 'about',
    resourceName : 'name',
  });
  test.identical( got, '' );

  test.close( 'undefines in values of properties' );

  /* - */

  if( !Config.debug )
  return;

  a.reflect();

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.fileReadResource() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.fileReadResource( a.abs( './' ), 'in', 'in' ) );

  test.case = 'resourceKind is not defined';
  test.shouldThrowErrorSync( () => _.will.fileReadResource({ commonPath : a.abs( './' ), resourceName : 'in' }) );

  test.case = 'common path has no willfiles';
  test.shouldThrowErrorSync( () => _.will.fileReadResource({ commonPath : a.abs( 'proto' ), resourceName : 'in' }) );

  test.case = 'common path has willfiles but options for searching allows no read';
  test.shouldThrowErrorSync( () =>
  {
    return _.will.fileReadResource
    ({
      commonPath : a.abs( './PathMain' ),
      resourceKind : 'path',
      resourceName : 'proto',
      withSingle : 0,
    });
  });
}

//

function fileReadPath( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );
  a.reflect();

  /* - */

  test.case = 'commonPath - path to dir, resourceName - out.debug - call with arguments';
  var got = _.will.fileReadPath( a.abs( './' ), 'out.debug' );
  var exp =
  {
    path : 'out/debug',
    criterion : { debug : 1 },
  };
  test.identical( got, exp );

  /* */

  test.case = 'commonPath - path to dir, resourceName - out.debug';
  var got = _.will.fileReadPath
  ({
    commonPath : a.abs( './' ),
    resourceName : 'out.debug',
  });
  var exp =
  {
    path : 'out/debug',
    criterion : { debug : 1 },
  };
  test.identical( got, exp );

  test.case = 'commonPath - path with name of file, resourceName - proto';
  var got = _.will.fileReadPath
  ({
    commonPath : a.abs( './PathMain' ),
    resourceName : 'proto',
  });
  test.identical( got, { path : 'proto' } );

  test.case = 'commonPath - path with full name of file, resourceName - in';
  var got = _.will.fileReadPath
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceName : 'in',
  });
  test.identical( got, '.' );

  test.case = 'commonPath - path to dir, resourceKind - step - hack, resourceName - clean.debug';
  var got = _.will.fileReadPath
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'step',
    resourceName : 'clean.debug',
  });
  var exp =
  {
    inherit : 'files.delete',
    filePath : 'path::out.*=1',
    criterion : { debug : 1 },
  };
  test.identical( got, exp );

  test.case = 'commonPath - path to dir, resourceName - unknown - resource not exists';
  var got = _.will.fileReadPath
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceName : 'unknown',
  });
  test.identical( got, undefined );

  test.case = 'commonPath - path to file, file not exists, throwing - 0';
  var got = _.will.fileReadPath
  ({
    commonPath : a.abs( './Unknown.will.yml' ),
    resourceName : 'in',
    throwing : 0,
  });
  test.identical( got, undefined );

  /* - */

  if( !Config.debug )
  return;

  a.reflect();

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.fileReadPath() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.fileReadPath( a.abs( './' ), 'in', 'in' ) );

  test.case = 'common path has no willfiles';
  test.shouldThrowErrorSync( () => _.will.fileReadPath({ commonPath : a.abs( 'proto' ), resourceName : 'in' }) );

  test.case = 'common path has willfiles but options for searching allows no read';
  test.shouldThrowErrorSync( () =>
  {
    return _.will.fileReadPath
    ({
      commonPath : a.abs( './PathMain' ),
      resourceName : 'proto',
      withSingle : 0,
    });
  });
}

//

function fileWriteResource( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );
  a.reflect();

  /* - */

  test.case = 'commonPath - path to dir, resourceKind - about, resourceName - name, exists, val - not defined';
  var read = _.will.fileReadResource
  ({
    commonPath : a.abs( './' ),
    resourceKind : 'about',
    resourceName : 'name',
  });
  test.identical( read, 'NpmFromWillfile' );

  var got = _.will.fileWriteResource
  ({
    commonPath : a.abs( './' ),
    resourceKind : 'about',
    resourceName : 'name',
  });
  test.identical( got.filePath, a.abs( './.ex.will.yml' ) );

  var read = _.will.fileReadResource
  ({
    commonPath : a.abs( './' ),
    resourceKind : 'about',
    resourceName : 'name',
  });
  test.identical( read, null );

  /* */

  test.case = 'commonPath - path with name of file, resourceKind - path, exists, resourceName - proto, val - map';
  var read = _.will.fileReadResource
  ({
    commonPath : a.abs( './PathMain' ),
    resourceKind : 'path',
    resourceName : 'proto',
  });
  test.identical( read, { path : 'proto' } );

  var got = _.will.fileWriteResource
  ({
    commonPath : a.abs( './PathMain' ),
    resourceKind : 'path',
    resourceName : 'proto',
    val : { path : 'out/proto' },
  });
  test.identical( got.filePath, a.abs( './PathMain.will.yml' ) );

  var read = _.will.fileReadResource
  ({
    commonPath : a.abs( './PathMain' ),
    resourceKind : 'path',
    resourceName : 'proto',
  });
  test.identical( read, { path : 'out/proto' } );

  /* */

  test.case = 'commonPath - path with full name of file, resourceKind - reflector, resourceName - proto.debug';
  var read = _.will.fileReadResource
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'reflector',
    resourceName : 'proto.debug',
  });
  var exp =
  {
    inherit : 'predefined.*',
    criterion : { 'debug' : 1 },
    filePath : { 'path::proto' : '{path::out.*=1}/source' },
  };
  test.identical( read, exp );

  var got = _.will.fileWriteResource
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'reflector',
    resourceName : 'proto.debug',
    val : { filePath : { 'path::proto' : '{path::out.*=1}/source' } },
  });
  test.identical( got.filePath, a.abs( './.im.will.yml' ) );

  var read = _.will.fileReadResource
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'reflector',
    resourceName : 'proto.debug',
  });
  test.identical( read, { filePath : { 'path::proto' : '{path::out.*=1}/source' } } );

  /* */

  test.case = 'commonPath - path to dir, resourceKind - step, resourceName - unknown - resource not exists';
  var read = _.will.fileReadResource
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'step',
    resourceName : 'unknown',
  });
  test.identical( read, undefined );

  var got = _.will.fileWriteResource
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'step',
    resourceName : 'unknown',
    val : 'unknown'
  });
  test.identical( got.filePath, a.abs( './.im.will.yml' ) );

  var read = _.will.fileReadResource
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'step',
    resourceName : 'unknown',
  });
  test.identical( read, 'unknown' );

  /* */

  test.case = 'commonPath - path to file, file not exists, throwing - 0';
  var got = _.will.fileWriteResource
  ({
    commonPath : a.abs( './Unknown.will.yml' ),
    resourceKind : 'path',
    resourceName : 'proto',
    val : { path : 'proto' },
    throwing : 0,
  });
  test.identical( got, undefined );

  var read = _.will.fileReadResource
  ({
    commonPath : a.abs( './Unknown.will.yml' ),
    resourceKind : 'path',
    resourceName : 'proto',
    throwing : 0,
  });
  test.identical( read, undefined );

  /* - */

  if( !Config.debug )
  return;

  a.reflect();

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.fileWriteResource() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.fileWriteResource( a.abs( './' ), 'in', 'in' ) );

  test.case = 'resourceKind is not defined';
  test.shouldThrowErrorSync( () => _.will.fileWriteResource({ commonPath : a.abs( './' ), resourceName : 'in' }) );

  test.case = 'common path has no willfiles';
  test.shouldThrowErrorSync( () => _.will.fileWriteResource({ commonPath : a.abs( 'proto' ), resourceName : 'in' }) );

  test.case = 'common path has willfiles but options for searching allows no read';
  test.shouldThrowErrorSync( () =>
  {
    return _.will.fileWriteResource
    ({
      commonPath : a.abs( './PathMain' ),
      resourceKind : 'path',
      resourceName : 'proto',
      withSingle : 0,
    });
  });
}

//

function fileWritePath( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );
  a.reflect();

  /* - */

  test.case = 'commonPath - path to dir, resourceName - in, exists, val - not defined, call with arguments';
  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './' ),
    resourceName : 'in',
  });
  test.identical( read, '.' );

  var got = _.will.fileWritePath( a.abs( './' ), 'in' );
  test.identical( got.filePath, a.abs( './.im.will.yml' ) );

  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './' ),
    resourceName : 'in',
  });
  test.identical( read, null );

  /* */

  a.reflect();

  test.case = 'commonPath - path to dir, resourceName - in, exists, val - not defined';
  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './' ),
    resourceName : 'in',
  });
  test.identical( read, '.' );

  var got = _.will.fileWritePath
  ({
    commonPath : a.abs( './' ),
    resourceName : 'in',
  });
  test.identical( got.filePath, a.abs( './.im.will.yml' ) );

  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './' ),
    resourceName : 'in',
  });
  test.identical( read, null );

  /* */

  test.case = 'commonPath - path with name of file, resourceName - proto, val - map';
  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './PathMain' ),
    resourceName : 'proto',
  });
  test.identical( read, { path : 'proto' } );

  var got = _.will.fileWritePath
  ({
    commonPath : a.abs( './PathMain' ),
    resourceName : 'proto',
    val : { path : 'out/proto' },
  });
  test.identical( got.filePath, a.abs( './PathMain.will.yml' ) );

  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './PathMain' ),
    resourceName : 'proto',
  });
  test.identical( read, { path : 'out/proto' } );

  /* */

  test.case = 'commonPath - path with full name of file, resourceKind - reflector - hack, resourceName - proto.debug';
  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'reflector',
    resourceName : 'proto.debug',
  });
  var exp =
  {
    inherit : 'predefined.*',
    criterion : { 'debug' : 1 },
    filePath : { 'path::proto' : '{path::out.*=1}/source' },
  };
  test.identical( read, exp );

  var got = _.will.fileWritePath
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'reflector',
    resourceName : 'proto.debug',
    val : { filePath : { 'path::proto' : '{path::out.*=1}/source' } },
  });
  test.identical( got.filePath, a.abs( './.im.will.yml' ) );

  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceKind : 'reflector',
    resourceName : 'proto.debug',
  });
  test.identical( read, { filePath : { 'path::proto' : '{path::out.*=1}/source' } } );

  /* */

  test.case = 'commonPath - path to dir, resourceName - unknown - resource not exists';
  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceName : 'unknown',
  });
  test.identical( read, undefined );

  var got = _.will.fileWritePath
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceName : 'unknown',
    val : 'unknown'
  });
  test.identical( got.filePath, a.abs( './.im.will.yml' ) );

  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './.im.will.yml' ),
    resourceName : 'unknown',
  });
  test.identical( read, 'unknown' );

  /* */

  test.case = 'commonPath - path to file, file not exists, throwing - 0';
  var got = _.will.fileWritePath
  ({
    commonPath : a.abs( './Unknown.will.yml' ),
    resourceName : 'proto',
    val : { path : 'proto' },
    throwing : 0,
  });
  test.identical( got, undefined );

  var read = _.will.fileReadPath
  ({
    commonPath : a.abs( './Unknown.will.yml' ),
    resourceName : 'proto',
    throwing : 0,
  });
  test.identical( read, undefined );

  /* - */

  if( !Config.debug )
  return;

  a.reflect();

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.fileWritePath() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.fileWritePath( a.abs( './' ), 'in', 'in' ) );

  test.case = 'common path has no willfiles';
  test.shouldThrowErrorSync( () => _.will.fileWritePath({ commonPath : a.abs( 'proto' ), resourceName : 'in' }) );

  test.case = 'common path has willfiles but options for searching allows no read';
  test.shouldThrowErrorSync( () =>
  {
    return _.will.fileWritePath
    ({
      commonPath : a.abs( './PathMain' ),
      resourceKind : 'path',
      resourceName : 'proto',
      withSingle : 0,
    });
  });
}

// --
// declare
// --

let Self =
{

  name : 'Tools.Willbe.File',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,
  routineTimeOut : 100000,

  context :
  {
    suiteTempPath : null,
    assetsOriginalPath : null,
    appJsPath : null,
    repoDirPath : null,
    assetFor,
  },

  tests :
  {

    fileClassify,

    fileAt,
    fileAtWithOptions,
    fileAtWillfilesWithDifferentExtensions,
    fileAtWillfilesInSubdirectories,

    filesAtCommonPathWithoutGlobs,
    filesAtCommonPathWithGlobs,
    filesAtCommonPathWithGlobsWithTrailedPath,
    filesAtCommonPathWithoutGlobsWithOptions,
    filesAtCommonPathWithGlobsWithOptions,
    filesAtCommonPathWithGlobsWithTrailedPathWithOptions,

    filePathIs,

    fileReadResource,
    fileReadPath,
    fileWriteResource,
    fileWritePath,

  }

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
