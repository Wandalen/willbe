( function _Willfile_test_s_()
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
  context.repoDirPath = _.path.join( context.assetsOriginalPath, '_repo' );

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

function WillfilesFindAtDir( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );
  a.fileProvider.dirMake( a.abs( '.' ) );

  /* */

  test.case = 'directory without willfiles';
  var got = _.Will.WillfilesFindAtDir( a.abs( '.' ) );
  test.identical( got, [] );

  test.case = 'path to unnamed willfile, willfile does not exist';
  var got = _.Will.WillfilesFindAtDir( a.abs( './.im.will.yml' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, willfile does not exist';
  var got = _.Will.WillfilesFindAtDir( a.abs( './Author.will.yml' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, not full path';
  var got = _.Will.WillfilesFindAtDir( a.abs( './Author' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.Will.WillfilesFindAtDir( a.abs( './Author.will' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.Will.WillfilesFindAtDir( a.abs( './.im' ) );
  test.identical( got, [] );

  test.case = 'path to directory named as willfile';
  var got = _.Will.WillfilesFindAtDir( a.abs( './Author/' ) );
  test.identical( got, [] );

  /* */

  a.reflect();

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.Will.WillfilesFindAtDir( a.abs( './' ) );
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.Will.WillfilesFindAtDir( a.abs( './' ) );
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.Will.WillfilesFindAtDir( a.abs( './.im.will.yml' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.Will.WillfilesFindAtDir( a.abs( './Author.will.yml' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.Will.WillfilesFindAtDir( a.abs( './Author' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.Will.WillfilesFindAtDir( a.abs( './Author.will' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.Will.WillfilesFindAtDir( a.abs( './.im' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.Will.WillfilesFindAtDir( a.abs( './Author/' ) );
  test.identical( got, [] );

  /* */

  a.reflect();

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './.im.will.yml' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './Author.will.yml' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './Author' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './Author.will' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './.im' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './Author/' ) });
  test.identical( got, [] );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindAtDir() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindAtDir( a.abs( './' ), a.abs( './' ) ) );

  test.case = 'filePath is terminal file, not willfile';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindAtDir( a.abs( './proto/File.s' ) ) );

  test.case = 'filePath is global path';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindAtDir( a.abs( 'hd:///home/' ) ) );

  test.case = 'filePath is path with glob';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindAtDir( a.abs( './**' ) ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindAtDir([ a.abs( './' ) ]) );

  test.case = 'unknown option in options map';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), unknown : 1 }) );

  test.case = 'withIn - 0 and withOut - 0';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), withIn : 0, withOut : 0 }) );
}

//

function WillfilesFindAtDirWithOptions( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* */

  test.case = 'path to dir, withAllNamed - 1';
  a.reflect();
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), withAllNamed : 1 });
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to file, withAllNamed - 1';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'AuthorSecond.ex.will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( '.im.will.yml' ), dstPath : a.abs( 'AuthorSecond.im.will.yml' ) });
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './Author' ), withAllNamed : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );


  /* */

  test.case = 'path to dir, withIn - 1, withOut - 0';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( '.out.will.yml' ) });
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), withIn : 1, withOut : 0 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir, withIn - 0, withOut - 1';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( '.out.will.yml' ) });
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), withIn : 0, withOut : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.out.will.yml' ) );

  /* */

  test.case = 'path to named willfile, withIn - 1, withOut - 0';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'Author.out.will.yml' ) });
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './Author' ), withIn : 1, withOut : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to dir, withIn - 0, withOut - 1';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'Author.out.will.yml' ) });
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './Author' ), withIn : 0, withOut : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.out.will.yml' ) );

  /* */

  test.case = 'path to dir, fileProvider - _.fileProvider';
  a.reflect();
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), fileProvider : _.fileProvider });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  /* */

  test.case = 'path to dir, exact - 1';
  a.reflect();
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), exact : 1 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );
}

WillfilesFindAtDirWithOptions.rapidity = -1;

//

function WillfilesFindAtDirWillfilesWithDifferentExtensions( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* */

  test.case = 'path to dir, withAllNamed - 1, standard exetensions';
  a.reflect();
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), withAllNamed : 1 });
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  /* */

  test.case = 'path to dir, withAllNamed - 1, not standard exetensions';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( 'Author.will.yaml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( 'Keywords.will.yml' ), dstPath : a.abs( 'Keywords.will.bson' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( 'Name.will.yml' ), dstPath : a.abs( 'Name.will.cson' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( 'Version.will.yml' ), dstPath : a.abs( 'Version.out.will.json' ) });
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), withAllNamed : 1 });
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].absolute, a.abs( './Version.out.will.json' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.ex.will.yml' ) );
}

//

function WillfilesFindAtDirWillfilesInSubdirectories( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* */

  test.case = 'path to dir, withAllNamed - 1, no willfiles in subdirectory';
  a.reflect();
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), withAllNamed : 1 });
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  /* */

  test.case = 'path to dir, withAllNamed - 1, willfiles in subdirectory';
  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });
  var got = _.Will.WillfilesFindAtDir({ filePath : a.abs( './' ), withAllNamed : 1 });
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );
}

//

function WillfilesFindWithGlobFilePathWithoutGlobs( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );
  a.fileProvider.dirMake( a.abs( '.' ) );

  /* */

  test.case = 'directory without willfiles';
  var got = _.Will.WillfilesFindWithGlob( a.abs( '.' ) );
  test.identical( got, [] );

  test.case = 'path to unnamed willfile, willfile does not exist';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './.im.will.yml' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, willfile does not exist';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author.will.yml' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, not full path';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author.will' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './.im' ) );
  test.identical( got, [] );

  test.case = 'path to directory named as willfile';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author/' ) );
  test.identical( got, [] );

  /* */

  a.reflect();

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './' ) );
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob( a.abs( './' ) );
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.Will.WillfilesFindWithGlob( a.abs( './.im.will.yml' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author.will.yml' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author.will' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './.im' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author/' ) );
  test.identical( got, [] );

  /* */

  a.reflect();

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './.im.will.yml' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author.will.yml' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author.will' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './.im' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author/' ) });
  test.identical( got, [] );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindWithGlob() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindWithGlob( a.abs( './' ), a.abs( './' ) ) );

  test.case = 'filePath is terminal file, not willfile';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindWithGlob( a.abs( './proto/File.s' ) ) );

  test.case = 'filePath is path with glob, recursive - 0';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), recursive : 0 }) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindWithGlob([ a.abs( './' ) ]) );

  test.case = 'unknown option in options map';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), unknown : 1 }) );

  test.case = 'withIn - 0 and withOut - 0';
  test.shouldThrowErrorSync( () => _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), withIn : 0, withOut : 0 }) );
}

//

function WillfilesFindWithGlobFilePathWithGlobs( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* */

  test.case = 'directory without willfiles';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './*' ) );
  test.identical( got, [] );

  test.case = 'path to unnamed willfile, willfile does not exist';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './.im.will.yml*' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, willfile does not exist';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author.will.yml*' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, not full path';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author*' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author.will*' ) );
  test.identical( got, [] );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './.im*' ) );
  test.identical( got, [] );

  test.case = 'path to directory named as willfile';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author/*' ) );
  test.identical( got, [] );

  /* */

  a.reflect();

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './*' ) );
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob( a.abs( './*' ) );
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.Will.WillfilesFindWithGlob( a.abs( './.im.will.yml*' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author.will.yml*' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author*' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author.will*' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './.im*' ) );
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.Will.WillfilesFindWithGlob( a.abs( './Author/*' ) );
  test.identical( got, [] );

  /* */

  a.reflect();

  test.case = 'path to dir with unnamed split willfiles';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './will.yml' ) );

  test.case = 'path to willfile, willfile exists';
  a.reflect();
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './.im.will.yml' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to named willfile, willfile exists';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author.will.yml*' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, not full path, willfile exists';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author*' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has will, not full path';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author.will*' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to named willfile, has im, not full path';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './.im*' ) });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author/*' ) });
  test.identical( got, [] );
}

//

function WillfilesFindWithGlobWithOptionsWithoutGlobs( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* */

  test.case = 'path to dir, withAllNamed - 1';
  a.reflect();
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), withAllNamed : 1 });
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to file, withAllNamed - 1';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'AuthorSecond.ex.will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( '.im.will.yml' ), dstPath : a.abs( 'AuthorSecond.im.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author' ), withAllNamed : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );


  /* */

  test.case = 'path to dir, withIn - 1, withOut - 0';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( '.out.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), withIn : 1, withOut : 0 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir, withIn - 0, withOut - 1';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( '.out.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), withIn : 0, withOut : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.out.will.yml' ) );

  /* */

  test.case = 'path to named willfile, withIn - 1, withOut - 0';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'Author.out.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author' ), withIn : 1, withOut : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to dir, withIn - 0, withOut - 1';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'Author.out.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author' ) });
  test.identical( got.length, 2 );
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author' ), withIn : 0, withOut : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.out.will.yml' ) );

  /* */

  test.case = 'path to dir, fileProvider - _.fileProvider';
  a.reflect();
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), fileProvider : _.fileProvider });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  /* */

  test.case = 'path to dir, exact - 1';
  a.reflect();
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), exact : 1 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );
}

WillfilesFindWithGlobWithOptionsWithoutGlobs.rapidity = -1;

//

function WillfilesFindWithGlobWithOptionsWithGlobs( test )
{
  let context = this;
  let a = context.assetFor( test, 'npmFromWillfile' );

  /* */

  test.case = 'path to dir, withAllNamed - 1';
  a.reflect();
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), withAllNamed : 1 });
  test.identical( got.length, 17 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to file, withAllNamed - 1';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'AuthorSecond.ex.will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( '.im.will.yml' ), dstPath : a.abs( 'AuthorSecond.im.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author**' ), withAllNamed : 1 });
  test.identical( got.length, 3 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './AuthorSecond.ex.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( './AuthorSecond.im.will.yml' ) );


  /* */

  test.case = 'path to dir, withIn - 1, withOut - 0';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( '.out.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ) });
  test.identical( got.length, 3 );
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), withIn : 1, withOut : 0 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  test.case = 'path to dir, withIn - 0, withOut - 1';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( 'Author.will.yml' ), dstPath : a.abs( '.out.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ) });
  test.identical( got.length, 3 );
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), withIn : 0, withOut : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './.out.will.yml' ) );

  /* */

  test.case = 'path to named willfile, withIn - 1, withOut - 0';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'Author.out.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author**' ) });
  test.identical( got.length, 2 );
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author**' ), withIn : 1, withOut : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.will.yml' ) );

  test.case = 'path to dir, withIn - 0, withOut - 1';
  a.reflect();
  a.fileProvider.fileRename({ srcPath : a.abs( '.ex.will.yml' ), dstPath : a.abs( 'Author.out.will.yml' ) });
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author**' ) });
  test.identical( got.length, 2 );
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './Author**' ), withIn : 0, withOut : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( './Author.out.will.yml' ) );

  /* */

  test.case = 'path to dir, fileProvider - _.fileProvider';
  a.reflect();
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), fileProvider : _.fileProvider });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );

  /* */

  test.case = 'path to dir, exact - 1';
  a.reflect();
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), exact : 1 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( './.im.will.yml' ) );
}

WillfilesFindWithGlobWithOptionsWithGlobs.rapidity = -1;

//

function WillfilesFindWithGlobWithOptionRecursive( test )
{
  let context = this;
  let a = context.assetFor( test, 'hierarchyRemote' );

  /* */

  test.case = 'path to file, recursive - 0';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( 'z.will.yml' ), recursive : 0 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );

  /* - */

  test.open( 'without unnamed willfiles' );

  a.reflect();

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, no glob';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), recursive : 1, withAllNamed : 0 });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, no glob';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), recursive : 1, withAllNamed : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, glob - not recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*' ), recursive : 1, withAllNamed : 0 });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, glob - not recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*' ), recursive : 1, withAllNamed : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, glob - not recursive, search in dirs';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*/*' ), recursive : 1, withAllNamed : 0 });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, glob - not recursive, search in dirs';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*/*' ), recursive : 1, withAllNamed : 1 });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/a.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/b.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group1/group10/a0.will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/c.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), recursive : 1, withAllNamed : 0 });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), recursive : 1, withAllNamed : 1 });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/a.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/b.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group1/group10/a0.will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/c.will.yml' ) );

  /* */

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, no glob';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), recursive : 2, withAllNamed : 0 });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, no glob';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), recursive : 2, withAllNamed : 1 });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/a.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/b.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group1/group10/a0.will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/c.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, glob - not recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*' ), recursive : 2, withAllNamed : 0 });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, glob - not recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*' ), recursive : 2, withAllNamed : 1 });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/a.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/b.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group2/c.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, glob - not recursive, search in dirs';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*/*' ), recursive : 2, withAllNamed : 0 });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, glob - not recursive, search in dirs';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*/*' ), recursive : 2, withAllNamed : 1 });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/a.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/b.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group1/group10/a0.will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/c.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), recursive : 2, withAllNamed : 0 });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), recursive : 2, withAllNamed : 1 });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/a.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/b.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group1/group10/a0.will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/c.will.yml' ) );

  test.close( 'without unnamed willfiles' );

  /* - */

  test.open( 'with unnamed willfiles' );

  a.reflect();
  a.fileProvider.fileRename( a.abs( 'group1/.ex.will.yml' ), a.abs( 'group1/a.will.yml' ) );
  a.fileProvider.fileRename( a.abs( 'group1/.im.will.yml' ), a.abs( 'group1/b.will.yml' ) );
  a.fileProvider.fileRename( a.abs( 'group1/group10/will.yml' ), a.abs( 'group1/group10/a0.will.yml' ) );
  a.fileProvider.fileRename( a.abs( 'group2/.will.yml' ), a.abs( 'group2/c.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, no glob';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), recursive : 1, withAllNamed : 0 });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, no glob';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), recursive : 1, withAllNamed : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, glob - not recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*' ), recursive : 1, withAllNamed : 0 });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, glob - not recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*' ), recursive : 1, withAllNamed : 1 });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, glob - not recursive, search in dirs';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*/*' ), recursive : 1, withAllNamed : 0 });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/group10/will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, glob - not recursive, search in dirs';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*/*' ), recursive : 1, withAllNamed : 1 });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group1/group10/will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), recursive : 1, withAllNamed : 0 });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/group10/will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), recursive : 1, withAllNamed : 1 });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group1/group10/will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/.will.yml' ) );

  /* */

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, no glob';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), recursive : 2, withAllNamed : 0 });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/group10/will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, no glob';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './' ), recursive : 2, withAllNamed : 1 });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group1/group10/will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, glob - not recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*' ), recursive : 2, withAllNamed : 0 });
  test.identical( got.length, 3 );
  test.identical( got[ 0 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, glob - not recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*' ), recursive : 2, withAllNamed : 1 });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, glob - not recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*/*' ), recursive : 2, withAllNamed : 0 });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/group10/will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, glob - not recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './*/*' ), recursive : 2, withAllNamed : 1 });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group1/group10/will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), recursive : 2, withAllNamed : 0 });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/group10/will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob({ filePath : a.abs( './**' ), recursive : 2, withAllNamed : 1 });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group1/.ex.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( 'group1/.im.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( 'group1/group10/will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/.will.yml' ) );

  test.close( 'with unnamed willfiles' );
}

//

function WillfilesFindWithGlobWithOptionExcludingUnderscore( test )
{
  let context = this;
  let a = context.assetFor( test, 'hierarchyRemote' );

  a.reflect();
  a.fileProvider.fileRename( a.abs( '_group1' ), a.abs( 'group1' ) );

  /* - */

  test.open( 'excludingUnderscore - 0' );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, no glob';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './' ),
    recursive : 1,
    withAllNamed : 0,
    excludingUnderscore : 0,
  });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, no glob';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './' ),
    recursive : 1,
    withAllNamed : 1,
    excludingUnderscore : 0,
  });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './**' ),
    recursive : 1,
    withAllNamed : 0,
    excludingUnderscore : 0,
  });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './**' ),
    recursive : 1,
    withAllNamed : 1,
    excludingUnderscore : 0,
  });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( '_group1/a.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( '_group1/b.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( '_group1/group10/a0.will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/c.will.yml' ) );

  /* */

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, no glob';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './' ),
    recursive : 2,
    withAllNamed : 0,
    excludingUnderscore : 0,
  });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, no glob';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './' ),
    recursive : 2,
    withAllNamed : 1,
    excludingUnderscore : 0,
  });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( '_group1/a.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( '_group1/b.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( '_group1/group10/a0.will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/c.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './**' ),
    recursive : 2,
    withAllNamed : 0,
    excludingUnderscore : 0,
  });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './**' ),
    recursive : 2,
    withAllNamed : 1,
    excludingUnderscore : 0,
  });
  test.identical( got.length, 5 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( '_group1/a.will.yml' ) );
  test.identical( got[ 2 ].absolute, a.abs( '_group1/b.will.yml' ) );
  test.identical( got[ 3 ].absolute, a.abs( '_group1/group10/a0.will.yml' ) );
  test.identical( got[ 4 ].absolute, a.abs( 'group2/c.will.yml' ) );

  test.close( 'excludingUnderscore - 0' );

  /* - */

  test.open( 'excludingUnderscore - 1' );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, no glob';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './' ),
    recursive : 1,
    withAllNamed : 0,
    excludingUnderscore : 1,
  });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, no glob';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './' ),
    recursive : 1,
    withAllNamed : 1,
    excludingUnderscore : 1,
  });
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 1, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './**' ),
    recursive : 1,
    withAllNamed : 0,
    excludingUnderscore : 1,
  });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 1, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './**' ),
    recursive : 1,
    withAllNamed : 1,
    excludingUnderscore : 1,
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group2/c.will.yml' ) );

  /* */

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, no glob';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './' ),
    recursive : 2,
    withAllNamed : 0,
    excludingUnderscore : 1,
  });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, no glob';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './' ),
    recursive : 2,
    withAllNamed : 1,
    excludingUnderscore : 1,
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group2/c.will.yml' ) );

  test.case = 'path to main dir, withAllNamed - 0, recursive - 2, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './**' ),
    recursive : 2,
    withAllNamed : 0,
    excludingUnderscore : 1,
  });
  test.identical( got.length, 0 );

  test.case = 'path to main dir, withAllNamed - 1, recursive - 2, glob - recursive';
  var got = _.Will.WillfilesFindWithGlob
  ({
    filePath : a.abs( './**' ),
    recursive : 2,
    withAllNamed : 1,
    excludingUnderscore : 1,
  });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].absolute, a.abs( 'z.will.yml' ) );
  test.identical( got[ 1 ].absolute, a.abs( 'group2/c.will.yml' ) );

  test.close( 'excludingUnderscore - 1' );
}

// --
// declare
// --

let Self =
{

  name : 'Tools.Willbe.Willfile',
  silencing : 1,
  enabled : 0,

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

    WillfilesFindAtDir,
    WillfilesFindAtDirWithOptions,
    WillfilesFindAtDirWillfilesWithDifferentExtensions,
    WillfilesFindAtDirWillfilesInSubdirectories,

    WillfilesFindWithGlobFilePathWithoutGlobs,
    WillfilesFindWithGlobFilePathWithGlobs,
    WillfilesFindWithGlobWithOptionsWithoutGlobs,
    WillfilesFindWithGlobWithOptionsWithGlobs,
    WillfilesFindWithGlobWithOptionRecursive,
    WillfilesFindWithGlobWithOptionExcludingUnderscore,

  }

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
