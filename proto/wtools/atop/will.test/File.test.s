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
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );

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
  test.identical( got, [] );

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
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );

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
  test.identical( got, [] );

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
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );

  test.case = 'path to dir, withIn - 1, withOut - 0, withSingle - 0, withImport - 1, withExport - 1';
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 3 );
  var got = _.will.fileAt({ commonPath : a.abs( './' ), withIn : 1, withOut : 0, withSingle : 0 });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );

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
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './.out.will.yml' ) );

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
  test.identical( got.length, 1 );
  test.identical( got[ 0 ].filePath, a.abs( './Author.out.will.yml' ) );

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
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );

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
  test.identical( got[ 2 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './.ex.will.yml' ) );

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
  test.identical( got[ 2 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 4 ].filePath, a.abs( './will.json' ) );
  test.identical( got[ 5 ].filePath, a.abs( './.will.json' ) );
  test.identical( got[ 6 ].filePath, a.abs( './.im.will.json' ) );
  test.identical( got[ 7 ].filePath, a.abs( './.ex.will.json' ) );

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
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );
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
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );

  /* */

  test.case = 'path to dir, withAllNamed - 1, willfiles in subdirectory';
  a.reflect();
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'proto/' ) } });
  var got = _.will.fileAt({ commonPath : a.abs( './' ) });
  test.identical( got.length, 2 );
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );
}

//

function filesAtFilePathWithoutGlobs( test )
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
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );

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
  test.identical( got, [] );

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
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );

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
  test.identical( got, [] );

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

function filesAtFilePathWithGlobs( test )
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

filesAtFilePathWithGlobs.rapidity = -1;
filesAtFilePathWithGlobs.timeOut = 3e5;

//

function filesAtFilePathWithGlobsWithTrailedPath( test )
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
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.im.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.ex.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt({ commonPath : a.abs( '*/' ) });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.im.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.ex.will.yml' ) );

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
  test.identical( got[ 0 ].filePath, a.abs( './.im.will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.ex.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.im.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.ex.will.yml' ) );

  test.case = 'path to dir with unnamed willfiles, renamed willfiles';
  a.fileProvider.fileRename({ srcPath : a.abs( './.ex.will.yml' ), dstPath : a.abs( 'will.yml' ) });
  a.fileProvider.fileRename({ srcPath : a.abs( './.im.will.yml' ), dstPath : a.abs( '.will.yml' ) });
  var got = _.will.filesAt({ commonPath : a.abs( '*/**/' ) });
  test.identical( got.length, 4 );
  test.identical( got[ 0 ].filePath, a.abs( './will.yml' ) );
  test.identical( got[ 1 ].filePath, a.abs( './.will.yml' ) );
  test.identical( got[ 2 ].filePath, a.abs( './proto/.im.will.yml' ) );
  test.identical( got[ 3 ].filePath, a.abs( './proto/.ex.will.yml' ) );

  test.case = 'path to directory named as willfile';
  var got = _.will.filesAt({ commonPath : a.abs( '*/Author/' ) });
  test.identical( got, [] );

  test.close( 'glob - */**/' );
}

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

    fileAt,
    fileAtWithOptions,
    fileAtWillfilesWithDifferentExtensions,
    fileAtWillfilesInSubdirectories,

    filesAtFilePathWithoutGlobs,
    filesAtFilePathWithGlobs,
    filesAtFilePathWithGlobsWithTrailedPath,

    filePathIs,

  }

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
