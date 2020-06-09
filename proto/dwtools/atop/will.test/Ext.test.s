( function _WillExternals_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../dwtools/Tools.s' );

  _.include( 'wTesting' );;
  _.include( 'wAppBasic' );
  _.include( 'wFiles' );

  require( '../will/include/Top.s' );

}

/* Desirable :

- Test check line is short. Use variables to reach that.

    var outfile = _.fileProvider.configRead( outFilePath );
    var exp = [ 'disabled.out', '../', '../.module/Tools/', '../.module/Tools/out/wTools.out', '../.module/PathBasic/', '../.module/PathBasic/out/wPathBasic.out' ];
    var got = _.mapKeys( outfile.module );
    test.identical( got, exp );

- Name return of _.process.start "op".

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return op;
  })

- Use routine assetFor to setup environment for a test routine.

function exportCourruptedSubmodulesDisabled( test )
{
  let self = this;
  let a = self.assetFor( test, 'corrupted-submodules-disabled' );
  let outPath = a.abs( 'super.out' );
  ...

*/

/*
qqq : fix npm submodules tests
*/

var _global = _global_;
var _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;
  self.suiteTempPath = _.path.pathDirTempOpen( _.path.join( __dirname, '../..'  ), 'willbe' );
  self.assetsOriginalPath = _.path.join( __dirname, '_asset' );
  self.repoDirPath = _.path.join( self.assetsOriginalPath, '_repo' );
  self.willPath = _.path.nativize( _.Will.WillPathGet() );
  self.find = _.fileProvider.filesFinder
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

  self.findAll = _.fileProvider.filesFinder
  ({
    withTerminals : 1,
    withDirs : 1,
    withStem : 1,
    withTransient : 1,
    allowingMissed : 1,
    maskPreset : 0,
    outputFormat : 'relative',
  });

  let reposDownload = require( './ReposDownload.s' );
  return reposDownload().then( () =>
  {
    _.assert( _.fileProvider.isDir( _.path.join( self.repoDirPath, 'ModuleForTesting1' ) ) );
    return null;
  })
}

//

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.suiteTempPath, '/willbe-' ) )
  _.path.pathDirTempClose( self.suiteTempPath );
}

//

function assetFor( test, name )
{
  let self = this;
  let a = Object.create( null );

  if( !name )
  name = test.name;

  a.test = test;
  a.name = name;
  a.originalAssetPath = _.path.join( self.assetsOriginalPath, name );
  a.originalAbs = self.abs_functor( a.originalAssetPath );
  a.originalRel = self.rel_functor( a.originalAssetPath );
  a.routinePath = _.path.join( self.suiteTempPath, test.name );
  a.abs = self.abs_functor( a.routinePath );
  a.rel = self.rel_functor( a.routinePath );
  a.will = new _.Will;
  a.fileProvider = _.fileProvider;
  a.path = _.fileProvider.path;
  a.ready = _.Consequence().take( null );

  a.reflect = function reflect()
  {
    _.fileProvider.filesDelete( a.routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.routinePath } });
    // _.fileProvider.filesReflect({ reflectMap : { [ self.repoDirPath ] : a.path.join( self.suiteTempPath, '_repo' ) } });
    try
    {
      _.fileProvider.filesReflect({ reflectMap : { [ self.repoDirPath ] : a.path.join( self.suiteTempPath, '_repo' ) } });
    }
    catch( err )
    {
      _.Consequence().take( null ).timeOut( 3000 ).deasync();
      _.fileProvider.filesDelete( a.path.join( self.suiteTempPath, '_repo' ) ); /* Dmytro : temporary, clean _repo directory before copying files, prevents fails in *nix systems */
      _.fileProvider.filesReflect({ reflectMap : { [ self.repoDirPath ] : a.path.join( self.suiteTempPath, '_repo' ) } });
    }
  }

  a.shell = _.process.starter
  ({
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'shell',
  })

  a.start = _.process.starter
  ({
    execPath : self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'fork',
  })

  a.startNonThrowing = _.process.starter
  ({
    execPath : self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    throwingExitCode : 0,
    ready : a.ready,
    mode : 'fork',
  })

  _.assert( a.fileProvider.isDir( a.originalAssetPath ) );

  return a;
}

//

function abs_functor( routinePath )
{
  _.assert( _.strIs( routinePath ) );
  _.assert( arguments.length === 1 );
  return function abs( filePath )
  {
    if( arguments.length === 1 && filePath === null )
    return filePath;
    let args = _.longSlice( arguments );
    args.unshift( routinePath );
    return _.uri.s.join.apply( _.uri.s, args );
  }
}

//

function rel_functor( routinePath )
{
  _.assert( _.strIs( routinePath ) );
  _.assert( arguments.length === 1 );
  return function rel( filePath )
  {
    _.assert( arguments.length === 1 );
    if( filePath === null )
    return filePath;
    if( _.arrayIs( filePath ) || _.mapIs( filePath ) )
    {
      return _.filter( filePath, ( filePath ) => rel( filePath ) );
    }
    if( _.uri.isRelative( filePath ) && !_.uri.isRelative( routinePath ) )
    return filePath;
    return _.uri.s.relative.apply( _.uri.s, [ routinePath, filePath ] );
  }
}

// --
// tests
// --

function preCloneRepos( test )
{
  let self = this;
  let a = self.assetFor( test, '_repo' );

  a.ready.then( () =>
  {
    test.is( _.fileProvider.isDir( _.path.join( self.repoDirPath, 'ModuleForTesting1' ) ) );
    return null;
  })

  return a.ready;
}

//

function singleModuleWithSpaceTrivial( test )
{
  let self = this;
  let a = self.assetFor( test, 'single with space' );
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.abs( 'single with space' ) } });

  a.start({ execPath : '.with "single with space/" .resources.list' })

  .then( ( got ) =>
  {
    test.case = '.with "single with space/" .resources.list';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `name : 'single with space'` ) );
    test.is( _.strHas( got.output, `description : 'Module for testing'` ) );
    test.is( _.strHas( got.output, `version : '0.0.1'` ) );
    return null;
  })

  return a.ready;
}

// --
// tests
// --

function build( test )
{
  let self = this;
  let a = self.assetFor( test, 'make' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with v1 .build'
    a.fileProvider.filesDelete( a.abs( 'out/Produced.js2' ) );
    a.fileProvider.filesDelete( a.abs( 'out/Produced.txt2' ) );
    return null;
  })

  a.start({ execPath : '.with v1 .build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( _.strHas( got.output, `node ${ a.path.nativize( 'file/Produce.js' )}` ) );
    if( process.platform === 'win32' )
    {
      test.identical( _.strCount( got.output, 'out\\Produced.txt2' ), 1 );
      test.identical( _.strCount( got.output, 'out\\Produced.js2' ), 1 );
    }
    else
    {
      test.identical( _.strCount( got.output, 'out/Produced.txt2' ), 1 );
      test.identical( _.strCount( got.output, 'out/Produced.js2' ), 1 );
    }
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( a.routinePath );
    var exp =
    [
      '.',
      './v1.will.yml',
      './v2.will.yml',
      './file',
      './file/File.js',
      './file/File.test.js',
      './file/Produce.js',
      './file/Src1.txt',
      './file/Src2.txt',
      './out',
      './out/Produced.js2',
      './out/Produced.txt2',
      './out/shouldbe.txt'
    ];
    test.identical( files, exp );
    return null;
  })

  a.start({ execPath : '.with v1 .build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( !_.strHas( got.output, 'node file/Produce.js' ) );
    if( process.platform === 'win32' )
    {
      test.identical( _.strCount( got.output, 'out\\Produced.txt2' ), 0 );
      test.identical( _.strCount( got.output, 'out\\Produced.js2' ), 0 );
    }
    else
    {
      test.identical( _.strCount( got.output, 'out/Produced.txt2' ), 0 );
      test.identical( _.strCount( got.output, 'out/Produced.js2' ), 0 );
    }
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( a.routinePath );
    var exp =
    [
      '.',
      './v1.will.yml',
      './v2.will.yml',
      './file',
      './file/File.js',
      './file/File.test.js',
      './file/Produce.js',
      './file/Src1.txt',
      './file/Src2.txt',
      './out',
      './out/Produced.js2',
      './out/Produced.txt2',
      './out/shouldbe.txt'
    ];
    test.identical( files, exp );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with v2 .build'
    a.fileProvider.filesDelete( a.abs( 'out/Produced.js2' ) );
    a.fileProvider.filesDelete( a.abs( 'out/Produced.txt2' ) );
    return null;
  })

  a.start({ execPath : '.with v2 .build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( _.strHas( got.output, `node ${ a.path.nativize( 'file/Produce.js' )}` ) );
    if( process.platform === 'win32' )
    {
      test.identical( _.strCount( got.output, 'out\\Produced.txt2' ), 1 );
      test.identical( _.strCount( got.output, 'out\\Produced.js2' ), 1 );
    }
    else
    {
      test.identical( _.strCount( got.output, 'out/Produced.txt2' ), 1 );
      test.identical( _.strCount( got.output, 'out/Produced.js2' ), 1 );
    }
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( a.routinePath );
    var exp =
    [
      '.',
      './v1.will.yml',
      './v2.will.yml',
      './file',
      './file/File.js',
      './file/File.test.js',
      './file/Produce.js',
      './file/Src1.txt',
      './file/Src2.txt',
      './out',
      './out/Produced.js2',
      './out/Produced.txt2',
      './out/shouldbe.txt'
    ];
    test.identical( files, exp );
    return null;
  })

  a.start({ execPath : '.with v2 .build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( !_.strHas( got.output, 'node file/Produce.js' ) );
    if( process.platform === 'win32' )
    {
      test.identical( _.strCount( got.output, 'out\\Produced.txt2' ), 0 );
      test.identical( _.strCount( got.output, 'out\\Produced.js2' ), 0 );
    }
    else
    {
      test.identical( _.strCount( got.output, 'out/Produced.txt2' ), 0 );
      test.identical( _.strCount( got.output, 'out/Produced.js2' ), 0 );
    }
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( a.routinePath );
    var exp =
    [
      '.',
      './v1.will.yml',
      './v2.will.yml',
      './file',
      './file/File.js',
      './file/File.test.js',
      './file/Produce.js',
      './file/Src1.txt',
      './file/Src2.txt',
      './out',
      './out/Produced.js2',
      './out/Produced.txt2',
      './out/shouldbe.txt'
    ];
    test.identical( files, exp );
    return null;
  })

  /* - */

  return a.ready;
}

//

/*
Test transpilation of JS files.
*/

function transpile( test )
{
  let self = this;
  let a = self.assetFor( test, 'transpile' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build debug'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })
  a.start({ execPath : '.build debug' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    var exp =
    [
      '.',
      './debug',
      './debug/dir1',
      './debug/dir1/Text.txt',
      './debug/dir2',
      './debug/dir2/File.js',
      './debug/dir2/File.test.js',
      './debug/dir2/File1.debug.js',
      './debug/dir2/File2.debug.js',
      './debug/dir3.test',
      './debug/dir3.test/File.js',
      './debug/dir3.test/File.test.js'
    ];
    test.identical( files, exp );
    a.fileProvider.isTerminal( a.path.join( a.abs( 'out' ), 'debug/dir3.test/File.js' ) );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build compiled.debug'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })
  a.start({ execPath : '.build compiled.debug' })
  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    var exp =
    [
      '.',
      './compiled.debug',
      './compiled.debug/Main.s',
      './tests.compiled.debug',
      './tests.compiled.debug/Tests.s'
    ];
    test.identical( files, exp );
    a.fileProvider.isTerminal( a.path.join( a.abs( 'out' ), 'compiled.debug/Main.s' ) );
    a.fileProvider.isTerminal( a.path.join( a.abs( 'out' ), 'tests.compiled.debug/Tests.s' ) );

    var read = a.fileProvider.fileRead( a.path.join( a.abs( 'out' ), 'compiled.debug/Main.s' ) );
    test.is( !_.strHas( read, 'dir2/-Ecluded.js' ) );
    test.is( _.strHas( read, 'dir2/File.js' ) );
    test.is( !_.strHas( read, 'dir2/File.test.js' ) );
    test.is( _.strHas( read, 'dir2/File1.debug.js' ) );
    test.is( !_.strHas( read, 'dir2/File1.release.js' ) );
    test.is( _.strHas( read, 'dir2/File2.debug.js' ) );
    test.is( !_.strHas( read, 'dir2/File2.release.js' ) );

    var read = a.fileProvider.fileRead( a.path.join( a.abs( 'out' ), 'tests.compiled.debug/Tests.s' ) );
    test.is( !_.strHas( read, 'dir2/-Ecluded.js' ) );
    test.is( !_.strHas( read, 'dir2/File.js' ) );
    test.is( _.strHas( read, 'dir2/File.test.js' ) );
    test.is( !_.strHas( read, 'dir2/File1.debug.js' ) );
    test.is( !_.strHas( read, 'dir2/File1.release.js' ) );
    test.is( !_.strHas( read, 'dir2/File2.debug.js' ) );
    test.is( !_.strHas( read, 'dir2/File2.release.js' ) );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build raw.release'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })
  a.start({ execPath : '.build raw.release' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    var exp =
    [
      '.',
      './raw.release',
      './raw.release/dir1',
      './raw.release/dir1/Text.txt',
      './raw.release/dir2',
      './raw.release/dir2/File.js',
      './raw.release/dir2/File.test.js',
      './raw.release/dir2/File1.release.js',
      './raw.release/dir2/File2.release.js',
      './raw.release/dir3.test',
      './raw.release/dir3.test/File.js',
      './raw.release/dir3.test/File.test.js'
    ];
    test.identical( files, exp );
    a.fileProvider.isTerminal( a.path.join( a.abs( 'out' ), './raw.release/dir3.test/File.test.js' ) );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build release';
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })
  a.start({ execPath : '.build release' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    var exp =
    [
      '.',
      './release',
      './release/Main.s',
      './tests.compiled.release',
      './tests.compiled.release/Tests.s'
    ];
    test.identical( files, exp );
    a.fileProvider.isTerminal( a.path.join( a.abs( 'out' ), './release/Main.s' ) );
    a.fileProvider.isTerminal( a.path.join( a.abs( 'out' ), './tests.compiled.release/Tests.s' ) );

    var read = a.fileProvider.fileRead( a.path.join( a.abs( 'out' ), './release/Main.s' ) );
    test.is( _.strHas( read, 'dir2/File.js' ) );
    test.is( !_.strHas( read, 'dir2/File1.debug.js' ) );
    test.is( _.strHas( read, 'dir2/File1.release.js' ) );
    test.is( !_.strHas( read, 'dir2/File2.debug.js' ) );
    test.is( _.strHas( read, 'dir2/File2.release.js' ) );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build all'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })
  a.start({ execPath : '.build all' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    var exp =
    [
      '.',
      './compiled.debug',
      './compiled.debug/Main.s',
      './debug',
      './debug/dir1',
      './debug/dir1/Text.txt',
      './debug/dir2',
      './debug/dir2/File.js',
      './debug/dir2/File.test.js',
      './debug/dir2/File1.debug.js',
      './debug/dir2/File2.debug.js',
      './debug/dir3.test',
      './debug/dir3.test/File.js',
      './debug/dir3.test/File.test.js',
      './raw.release',
      './raw.release/dir1',
      './raw.release/dir1/Text.txt',
      './raw.release/dir2',
      './raw.release/dir2/File.js',
      './raw.release/dir2/File.test.js',
      './raw.release/dir2/File1.release.js',
      './raw.release/dir2/File2.release.js',
      './raw.release/dir3.test',
      './raw.release/dir3.test/File.js',
      './raw.release/dir3.test/File.test.js',
      './release',
      './release/Main.s',
      './tests.compiled.debug',
      './tests.compiled.debug/Tests.s',
      './tests.compiled.release',
      './tests.compiled.release/Tests.s'
    ];
    test.identical( files, exp );
    return null;
  })

  /* - */

  return a.ready;
}

//

function transpileWithOptions( test )
{
  let self = this;
  let a = self.assetFor( test, 'transpile-options' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'minify, raw mode, max compression'
    test.description =
    `Options:\
     \n transpilingStrategy : [ 'Uglify' ]\
     \n optimization : 9\
     \n minification : 9\
     \n diagnosing : 0\
     \n beautifing : 1
    `
    _.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })
  a.start({ execPath : '.build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './File.min.js' ] );
    let file = _.fileProvider.fileRead( a.abs( 'out/File.min.js') );
    let lines = _.strLinesCount( file );
    test.identical( lines, 1 );
    return null;
  })

  /* - */

  return a.ready;
}

//

function transpileExperiment( test )
{
  let self = this;
  let a = self.assetFor( test, 'transpile' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build debug'
    return null;
  })
  a.start({ execPath : '.build compiled.debug' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    console.log( got.output );
    return null;
  })

  return a.ready;
}

transpileExperiment.experimental = 1;

//

function moduleNewDotless( test )
{
  let self = this;
  let a = self.assetFor( test, 'two-dotless-exported' );

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  });
  a.startNonThrowing({ execPath : '.module.new', currentPath : a.routinePath })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './ex.will.yml',
      './im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/ex.will.yml',
      './sub/im.will.yml'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new module::moduleNewDotless at' ), 1 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 1 );
    test.identical( _.strCount( got.output, 'already exists!' ), 1 );

    return null;
  })

  /* - */
  a.ready
  .then( () =>
  {
    test.case = '.module.new some'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new some' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './ex.will.yml',
      './im.will.yml',
      './some.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/ex.will.yml',
      './sub/im.will.yml'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with some .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new some/'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new some/' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './ex.will.yml',
      './im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './some',
      './some/will.yml',
      './sub',
      './sub/ex.will.yml',
      './sub/im.will.yml'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })

  a.startNonThrowing({ execPath : '.with some/ .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new ../dir1/dir2/some/'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new ../dir1/dir2/some/' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './ex.will.yml',
      './im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/ex.will.yml',
      './sub/im.will.yml'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    var exp = [ '.', './dir2', './dir2/some', './dir2/some/will.yml' ]
    var files = self.find( a.abs( '../dir1' ) );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with ../dir1/dir2/some/ .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    a.fileProvider.filesDelete( a.abs( '../dir1' ) );
    return null;
  })

  /* - */

  return a.ready;
}

//

function moduleNewDotlessSingle( test )
{
  let self = this;
  let a = self.assetFor( test, 'two-dotless-single-exported' );

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/will.yml'
    ];
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new module::moduleNewDotlessSingle at' ), 1 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 1 );
    test.identical( _.strCount( got.output, 'already exists!' ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new some'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new some' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './some.will.yml',
      './will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/will.yml'
    ];
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with some .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new some/'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new some/' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './some',
      './some/will.yml',
      './sub',
      './sub/will.yml'
    ];
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with some/ .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new ../dir1/dir2/some/'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new ../dir1/dir2/some/' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/will.yml'
    ];
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    var exp = [ '.', './dir2', './dir2/some', './dir2/some/will.yml' ]
    var files = self.find( a.abs( '../dir1' ) );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with ../dir1/dir2/some/ .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    a.fileProvider.filesDelete( a.abs( '../dir1' ) );
    return null;
  })

  /* - */

  return a.ready;
}

//

function moduleNewNamed( test )
{
  let self = this;
  let a = self.assetFor( test, 'two-exported' )

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new super'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new super' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new module::super at' ), 1 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 1 );
    test.identical( _.strCount( got.output, 'already exists!' ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with some .module.new'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.with some .module.new' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './some.will.yml',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with some .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with some/ .module.new'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.with some/ .module.new' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './some',
      './some/will.yml'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with some/ .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with some .module.new some2'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.with some .module.new some2' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './some',
      './some/some2.will.yml'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some2 at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with some/some2 .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some2'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::moduleNewNamed at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with . .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'moduleNewNamed'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new super/'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new super/' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './super',
      './super/will.yml'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::super at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with super/ .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'super'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new some'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new some' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './some.will.yml',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with some .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new some/'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new some/' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './some',
      './some/will.yml'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with some/ .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.module.new ../dir1/dir2/some/'
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.module.new ../dir1/dir2/some/' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    var exp =
    [
      '.',
      './dir2',
      './dir2/some',
      './dir2/some/will.yml'
    ]
    var files = self.find( a.abs( '../dir1' ) );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, 'Cant make a new' ), 0 );
    test.identical( _.strCount( got.output, 'already exists!' ), 0 );
    test.identical( _.strCount( got.output, 'Create module::some at' ), 1 );

    return null;
  })
  a.startNonThrowing({ execPath : '.with ../dir1/dir2/some/ .about.list' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled error' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught error' ), 0 );
    test.identical( _.strCount( got.output, `name : 'some'` ), 1 );

    a.fileProvider.filesDelete( a.abs( '../dir1' ) );
    return null;
  })

  /* - */

  return a.ready;
}

//

function openWith( test )
{
  let self = this;
  let a = self.assetFor( test, 'open' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './submodule.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with . .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.with . .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './submodule.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with doc .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.with doc .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with doc .export -- deleted doc.will.yml'
    a.reflect();
    a.fileProvider.fileDelete( a.abs( 'doc.ex.will.yml' ) );
    a.fileProvider.fileDelete( a.abs( 'doc.im.will.yml' ) );
    return null;
  })

  a.startNonThrowing({ execPath : '.with doc .export' })

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    a.reflect();

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with doc. .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.with doc. .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with doc/. .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.with doc/. .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with do .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.startNonThrowing({ execPath :'.with do .export' })

  .then( ( got ) =>
  {
    test.ni( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'uncaught error' ), 0 );
    test.identical( _.strCount( got.output, '====' ), 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with docx .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.startNonThrowing({ execPath : '.with docx .export' })

  .then( ( got ) =>
  {
    test.ni( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'uncaught error' ), 0 );
    test.identical( _.strCount( got.output, '====' ), 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with doc/ .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.with doc/ .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [ '.', './submodule.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with doc/ .export -- deleted doc/.will.yml'

    a.reflect();
    a.fileProvider.fileDelete( a.abs( 'doc/.ex.will.yml' ) );
    a.fileProvider.fileDelete( a.abs( 'doc/.im.will.yml' ) );

    return null;
  })

  a.start({ execPath : '.clean' })
  a.startNonThrowing({ execPath : '.with doc/ .export' })

  .then( ( got ) =>
  {
    test.ni( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'uncaught error' ), 0 );
    test.identical( _.strCount( got.output, '====' ), 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    a.reflect();

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with doc/doc .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.with doc/doc .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with doc/doc. .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.with doc/doc. .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );

    return null;
  })

  /* - */

  return a.ready;
}

openWith.timeOut = 300000;

//

function openEach( test )
{
  let self = this;
  let a = self.assetFor( test, 'open' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.each . .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.each . .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './submodule.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.each doc/ .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.each doc/. .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( a.abs( 'doc/out' ) );
    test.identical( files, [ '.', './submodule.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( a.abs( 'doc/doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );

    return null;
  })

  /* - */

  return a.ready;
}

openEach.timeOut = 300000;

//

function withMixed( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-mixed' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with module .build'
    return null;
  })

  a.startNonThrowing({ execPath : '.with module .build' })
  .then( ( got ) =>
  {
    test.is( got.exitCode !== 0 );
    test.is( _.strHas( got.output, 'No module sattisfy criteria.' ) );
    test.identical( _.strCount( got.output, 'uncaught error' ), 0 );
    test.identical( _.strCount( got.output, '====' ), 0 );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with . .build'
    return null;
  })

  a.startNonThrowing({ execPath : '.with . .export' })
  .then( ( got ) =>
  {
    test.is( got.exitCode === 0 );
    test.identical( _.strCount( got.output, /Exported .*module::submodules-mixed \/ build::proto.export.* in/ ), 1 );
    return null;
  })

  /* - */

  return a.ready;
}

withMixed.timeOut = 300000;

//

function eachMixed( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-git' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.each submodule::*/path::download .shell "git status"'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build' })
  a.start({ execPath : '.each submodule::*/path::download .shell "git status"' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'git status' ) );
    /*
    test.is( _.strHas( got.output, `Your branch is up to date with 'origin/master'.` ) );
    // no such string on older git
    */
    test.identical( _.strCount( got.output, 'git status' ), 1 );
    test.identical( _.strCount( got.output, 'git "status"' ), 4 );
    test.identical( _.strCount( got.output, /nothing to commit, working .* clean/ ), 4 );

    test.is( _.strHas( got.output, /eachMixed\/\.module\/Tools\/out\/wTools\.out\.will\.yml[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/\.module\/Tools[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/\.module\/PathBasic\/out\/wPathBasic\.out\.will\.yml[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/\.module\/PathBasic[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/out\/UriBasic\.informal\.out\.will\.yml[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/out\/UriBasic[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/out\/Proto\.informal\.out\.will\.yml[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/out\/Proto\.informal\.out\.will\.yml[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/out\/Proto[^d]/ ) );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.each submodule:: .shell ls'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build' })
  a.start({ execPath : '.each submodule:: .shell ls -al' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'ls -al' ), 1 );
    test.identical( _.strCount( got.output, 'ls "-al"' ), 4 );
    test.identical( _.strCount( got.output, 'Module at' ), 4 );

    test.identical( _.strCount( got.output, '.module/Tools/out/wTools.out.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '.module/PathBasic/out/wPathBasic.out.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'out/UriBasic.informal.out.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'out/Proto.informal.out.will.yml' ), 1 );

    test.identical( _.strCount( got.output, '.module/Tools/out/wTools' ), 2 );
    test.identical( _.strCount( got.output, '.module/PathBasic/out/wPathBasic' ), 2 );
    test.identical( _.strCount( got.output, 'out/UriBasic.informal' ), 2 );
    test.identical( _.strCount( got.output, 'out/Proto.informal' ), 2 );

    return null;
  })

  /* - */

  return a.ready;
}

eachMixed.timeOut = 300000;

//

function withList( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-with-submodules' );
  a.reflect();

  /* - */

  a.start({ args : '.with . .resources.list about::name' })
  .finally( ( err, got ) =>
  {
    test.case = '.with . .resources.list about::name';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'withList/.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'module-' ), 1 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    return null;
  })

  /* - */

  a.start({ args : '.with . .resources.list about::description' })
  .finally( ( err, got ) =>
  {
    test.case = '.with . .resources.list about::description';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'withList/.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'Module for testing' ), 1 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    return null;
  })

  /* - */

  a.start({ args : '.with . .resources.list path::module.dir' })
  .finally( ( err, got ) =>
  {
    test.case = '.with . .resources.list path::module.dir';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'withList/.will.yml' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath ), 2 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    return null;
  })

  /* - */

  return a.ready;
}

//

function eachList( test )
{
  let self = this;
  let a = self.assetFor( test, 'each-list' );
  a.reflect();

  /* - */

  a.start({ args : '.clean' })

  a.start({ args : '.each . .resources.list about::name' })
  .finally( ( err, got ) =>
  {
    test.case = '.each . .resources.list about::name';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'Module at' ), 6 );
    test.identical( _.strCount( got.output, 'module-' ), 6 );

    test.identical( _.strCount( got.output, 'eachList/.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'module-x' ), 1 );
    test.identical( _.strCount( got.output, 'eachList/ab-named.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'module-ab-named' ), 1 );
    test.identical( _.strCount( got.output, 'eachList/a.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'module-a' ), 2 );
    test.identical( _.strCount( got.output, 'eachList/b.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'module-b' ), 2 );
    test.identical( _.strCount( got.output, 'eachList/bc-named.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'module-bc-named' ), 1 );
    test.identical( _.strCount( got.output, 'eachList/c.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'module-c' ), 1 );

    return null;
  })

  /* - */

  a.start({ args : '.imply v:1 ; .each . .resources.list about::name' })
  .finally( ( err, got ) =>
  {
    test.case = '.imply v:1 ; .each . .resources.list about::name';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'Module at' ), 0 );
    test.identical( _.strCount( got.output, 'module-' ), 6 );
    test.identical( _.strLinesCount( got.output ), 8 );

    test.identical( _.strCount( got.output, 'eachList/.will.yml' ), 0 );
    test.identical( _.strCount( got.output, 'module-x' ), 1 );
    test.identical( _.strCount( got.output, 'eachList/a.will.yml' ), 0 );
    test.identical( _.strCount( got.output, 'module-a' ), 2 );
    test.identical( _.strCount( got.output, 'eachList/ab-named.will.yml' ), 0 );
    test.identical( _.strCount( got.output, 'module-ab-named' ), 1 );
    test.identical( _.strCount( got.output, 'eachList/b.will.yml' ), 0 );
    test.identical( _.strCount( got.output, 'module-b' ), 2 );
    test.identical( _.strCount( got.output, 'eachList/bc-named.will.yml' ), 0 );
    test.identical( _.strCount( got.output, 'module-bc-named' ), 1 );
    test.identical( _.strCount( got.output, 'eachList/c.will.yml' ), 0 );
    test.identical( _.strCount( got.output, 'module-c' ), 1 );

    return null;
  })

  /* - */

  a.start({ args : '.imply v:1 ; .each . .resources.list path::module.common' })
  .finally( ( err, got ) =>
  {
    test.case = '.imply v:1 ; .each . .resources.list path::module.common';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'Module at' ), 0 );
    test.identical( _.strCount( got.output, a.routinePath ), 6 );
    test.identical( _.strLinesCount( got.output ), 8 );

    test.identical( _.strCount( got.output, a.routinePath + '/' ), 6 );
    test.identical( _.strCount( got.output, a.routinePath + '/a' ), 2 );
    test.identical( _.strCount( got.output, a.routinePath + '/ab-named' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath + '/b' ), 2 );
    test.identical( _.strCount( got.output, a.routinePath + '/bc-named' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath + '/c' ), 1 );

    return null;
  })

  /* - */

  a.start({ args : '.imply v:1 ; .each * .resources.list path::module.common' })
  .finally( ( err, got ) =>
  {
    test.case = '.imply v:1 ; .each * .resources.list path::module.common';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'Module at' ), 0 );
    test.identical( _.strCount( got.output, a.routinePath ), 6 );
    test.identical( _.strLinesCount( got.output ), 8 );

    test.identical( _.strCount( got.output, a.routinePath + '/' ), 6 );
    test.identical( _.strCount( got.output, a.routinePath + '/a' ), 2 );
    test.identical( _.strCount( got.output, a.routinePath + '/ab-named' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath + '/b' ), 2 );
    test.identical( _.strCount( got.output, a.routinePath + '/bc-named' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath + '/c' ), 1 );

    return null;
  })

  /* - */

  a.start({ args : '.imply v:1 ; .each */* .resources.list path::module.common' })
  .finally( ( err, got ) =>
  {
    test.case = '.imply v:1 ; .each */* .resources.list path::module.common';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'Module at' ), 0 );
    test.identical( _.strCount( got.output, a.routinePath ), 9 );
    test.identical( _.strLinesCount( got.output ), 11 );

    test.identical( _.strCount( got.output, a.routinePath + '/' ), 9 );
    test.identical( _.strCount( got.output, a.routinePath + '/a' ), 5 );
    test.identical( _.strCount( got.output, a.routinePath + '/ab-named' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath + '/b' ), 2 );
    test.identical( _.strCount( got.output, a.routinePath + '/bc-named' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath + '/c' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath + '/aabc' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath + '/ab' ), 3 );
    test.identical( _.strCount( got.output, a.routinePath + '/abac' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
}

eachList.timeOut = 300000;

//

function eachBrokenIll( test )
{
  let self = this;
  let a = self.assetFor( test, 'each-broken' );
  a.reflect();

  /* - */

  a.startNonThrowing({ args : '.imply v:1 ; .each */* .resources.list path::module.common' })
  .finally( ( err, got ) =>
  {
    test.case = '.imply v:1 ; .each */* .resources.list path::module.common';
    test.is( !err );
    test.notIdentical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'Failed to resolve' ), 0 );
    test.identical( _.strCount( got.output, 'eachBrokenIll/' ), 6 );
    test.identical( _.strCount( got.output, 'Failed to open willfile' ), 1 );
    return null;
  })

  /* - */

  return a.ready;
}

eachBrokenIll.description =
`
if one or several willfiles are broken .each should pass it and output error
`

//

/*
utility should not try to open non-willfiles
*/

function eachBrokenNon( test )
{
  let self = this;
  let a = self.assetFor( test, 'open-non-willfile' );
  a.reflect();

  /* - */

  a.startNonThrowing({ args : '.each */* .paths.list' })
  .finally( ( err, got ) =>
  {
    test.case = '.each */* .paths.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'Read 1 willfile' ), 1 );
    test.identical( _.strCount( got.output, 'Module at' ), 1 );
    test.identical( _.strCount( got.output, 'Paths' ), 1 );
    return null;
  })

  /* - */

  return a.ready;
}

//

/*
utility should handle properly illformed second command
tab should not be accumulated in the output
*/

function eachBrokenCommand( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-with-submodules-few' );
  a.reflect();
  a.fileProvider.filesDelete({ filePath : a.abs( 'out' ) });

  /* - */

  a.startNonThrowing( `.each */* .resource.list path::module.common` )
  .finally( ( err, got ) =>
  {
    test.case = '.each */* .resource.list path::module.common';
    test.is( !err );
    test.notIdentical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'Unknown command ".resource.list"' ), 1 );
    test.identical( _.strCount( got.output, 'Module at' ), 3 );
    test.identical( _.strCount( got.output, '      ' ), 0 );
    return null;
  })

  /* - */

  return a.ready;
} /* end of function eachBrokenCommand */

//

function commandsSeveral( test )
{
  let self = this;
  let a = self.assetFor( test, 'open' );
  a.reflect();
  a.fileProvider.filesDelete({ filePath : a.abs( 'out' ) });

  /* - */

  a.start( '".with . .export ; .clean"' )
  .then( ( got ) =>
  {
    test.case = '.with . .export ; .clean';
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Command .*\.with \. \.export ; \.clean.*/ ), 1 );
    test.identical( _.strCount( got.output, /Exported .*module::submodule \/ build::export.*/ ), 1 );
    test.identical( _.strCount( got.output, 'Clean deleted 5 file' ), 1 );

    var exp =
    [
      '.',
      './.ex.will.yml',
      './.im.will.yml',
      './doc.ex.will.yml',
      './doc.im.will.yml',
      './doc',
      './doc/.ex.will.yml',
      './doc/.im.will.yml',
      './doc/doc.ex.will.yml',
      './doc/doc.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js'
    ]
    var got = self.find( a.routinePath );
    test.identical( got, exp );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function commandsSeveral */

commandsSeveral.description =
`
- check internal stat of will
- several commands separated with ";"" should works
`

//

function implyWithSubmodulesModulesList( test )
{
  let self = this;
  let a = self.assetFor( test, '4LevelsLocal' );

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'default withSubmodules';
    a.reflect();
    return null;
  })
  a.start( '".with l4 .modules.list"' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'error' ), 0 );

    test.identical( _.strCount( got.output, 'module::' ), 7 );
    test.identical( _.strCount( got.output, 'remote : null' ), 4 );
    test.identical( _.strCount( got.output, 'module::l4' ), 4 );
    test.identical( _.strCount( got.output, 'module::l3' ), 1 );
    test.identical( _.strCount( got.output, 'module::l2' ), 1 );
    test.identical( _.strCount( got.output, 'module::l1' ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'withSubmodules:0';
    a.reflect();
    return null;
  })
  a.start( '".imply withSubmodules:0 ; .with l4 .modules.list"' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'error' ), 0 );

    test.identical( _.strCount( got.output, 'module::' ), 1 );
    test.identical( _.strCount( got.output, 'remote : null' ), 1 );
    test.identical( _.strCount( got.output, 'module::l4' ), 1 );

    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = 'withSubmodules:1';
    a.reflect();
    return null;
  })
  a.start( '".imply withSubmodules:1 ; .with l4 .modules.list"' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'error' ), 0 );

    test.identical( _.strCount( got.output, 'module::' ), 3 );
    test.identical( _.strCount( got.output, 'remote : null' ), 2 );
    test.identical( _.strCount( got.output, 'module::l4' ), 2 );
    test.identical( _.strCount( got.output, 'module::l3' ), 1 );

    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = 'withSubmodules:2';
    a.reflect();
    return null;
  })
  a.start( '".imply withSubmodules:2 ; .with l4 .modules.list"' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'error' ), 0 );

    test.identical( _.strCount( got.output, 'module::' ), 7 );
    test.identical( _.strCount( got.output, 'remote : null' ), 4 );
    test.identical( _.strCount( got.output, 'module::l4' ), 4 );
    test.identical( _.strCount( got.output, 'module::l3' ), 1 );
    test.identical( _.strCount( got.output, 'module::l2' ), 1 );
    test.identical( _.strCount( got.output, 'module::l1' ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'withSubmodules:0';
    a.reflect();
    return null;
  })
  a.start( '.imply withSubmodules:0 .with l4 .modules.list' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'error' ), 0 );

    test.identical( _.strCount( got.output, 'module::' ), 1 );
    test.identical( _.strCount( got.output, 'remote : null' ), 1 );
    test.identical( _.strCount( got.output, 'module::l4' ), 1 );

    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = 'withSubmodules:1';
    a.reflect();
    return null;
  })
  a.start( '.imply withSubmodules:1 .with l4 .modules.list' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'error' ), 0 );

    test.identical( _.strCount( got.output, 'module::' ), 3 );
    test.identical( _.strCount( got.output, 'remote : null' ), 2 );
    test.identical( _.strCount( got.output, 'module::l4' ), 2 );
    test.identical( _.strCount( got.output, 'module::l3' ), 1 );

    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = 'withSubmodules:2';
    a.reflect();
    return null;
  })
  a.start( '.imply withSubmodules:2 .with l4 .modules.list' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'error' ), 0 );

    test.identical( _.strCount( got.output, 'module::' ), 7 );
    test.identical( _.strCount( got.output, 'remote : null' ), 4 );
    test.identical( _.strCount( got.output, 'module::l4' ), 4 );
    test.identical( _.strCount( got.output, 'module::l3' ), 1 );
    test.identical( _.strCount( got.output, 'module::l2' ), 1 );
    test.identical( _.strCount( got.output, 'module::l1' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
}

implyWithSubmodulesModulesList.description =
`
- imply withSubmodules:0 cause to open no submodules
- imply withSubmodules:1 cause to open only submodules of the main module
- imply withSubmodules:2 cause to open all submodules recursively
- no error are thowen
`

// --
// reflect
// --

function reflectNothingFromSubmodules( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-nothing-from-submodules' );
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'out/debug' ) );

  /* - */

  a.ready.then( () =>
  {
    test.case = '.export'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  /*
    Module has unused reflector and step : "reflect.submodules"
    Throws error if none submodule is defined
  */

  a.start({ execPath : '.export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflected 2 file(s)' ) );
    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, /Exported module::reflect-nothing-from-submodules \/ build::proto.export with 2 file\(s\) in/ ) );

    var files = self.find( a.abs( 'out/debug' ) );
    test.identical( files, [ '.', './Single.s' ] );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './reflect-nothing-from-submodules.out.will.yml', './debug', './debug/Single.s' ] );

    test.is( a.fileProvider.fileExists( a.abs( 'out/reflect-nothing-from-submodules.out.will.yml' ) ) )
    var outfile = a.fileProvider.configRead( a.abs( 'out/reflect-nothing-from-submodules.out.will.yml' ) );

    outfile = outfile.module[ 'reflect-nothing-from-submodules.out' ]

    var reflector = outfile.reflector[ 'exported.files.proto.export' ];
    var expectedFilePath =
    {
      '.' : '',
      'Single.s' : ''
    }
    test.identical( reflector.src.basePath, '.' );
    test.identical( reflector.src.prefixPath, 'path::exported.dir.proto.export' );
    test.identical( reflector.src.filePath, { 'path::exported.files.proto.export' : '' } );

    var expectedReflector =
    {
      "reflect.proto" :
      {
        "src" :
        {
          "filePath" : { "path::proto" : "path::out.*=1" }
        },
        'criterion' : { 'debug' : 1 },
        "mandatory" : 1,
        "inherit" : [ "predefined.*" ],
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "reflect.submodules1" :
      {
        "dst" : { "basePath" : ".", "prefixPath" : "path::out.debug" },
        "criterion" : { "debug" : 1 },
        "mandatory" : 1,
        "inherit" :
        [
          "submodule::*/exported::*=1/reflector::exported.files*=1"
        ],
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "reflect.submodules2" :
      {
        "src" :
        {
          "filePath" : { "submodule::*/exported::*=1/path::exported.dir*=1" : "path::out.*=1" },
          "prefixPath" : ''
        },
        "dst" : { "prefixPath" : '' },
        "criterion" : { "debug" : 1 },
        "mandatory" : 1,
        "inherit" : [ "predefined.*" ],
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "exported.proto.export" :
      {
        "src" :
        {
          "filePath" : { "**" : "" },
          "prefixPath" : "../proto"
        },
        "criterion" : { "default" : 1, "export" : 1, "generated" : 1 },
        "mandatory" : 1,
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "exported.files.proto.export" :
      {
        "src" : { "filePath" : { 'path::exported.files.proto.export' : '' }, "basePath" : ".", "prefixPath" : "path::exported.dir.proto.export", 'recursive' : 0 },
        "criterion" : { "default" : 1, "export" : 1, "generated" : 1 },
        "recursive" : 0,
        "mandatory" : 1,
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      }
    }
    test.identical( outfile.reflector, expectedReflector );
    // logger.log( _.toJson( outfile.reflector ) );

    return null;
  })

  return a.ready;
}

//

function reflectGetPath( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-get-path' );
  a.reflect();

  /* - */

  a.ready.then( () =>
  {
    test.case = '.build debug1'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build debug1' })
  .then( ( arg ) => validate( arg ) )

  /* - */

  a.ready.then( () =>
  {
    test.case = '.build debug2'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build debug2' })
  .then( ( arg ) => validate( arg ) )

  /* - */

  a.ready.then( () =>
  {
    test.case = '.build debug3'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build debug3' })
  .then( ( arg ) => validate( arg ) )

  /* - */

  return a.ready;

  function validate( arg )
  {
    test.identical( arg.exitCode, 0 );

    var expected =
    [
      '.',
      './debug',
      './debug/dwtools',
      './debug/dwtools/Tools.s',
      './debug/dwtools/abase',
      './debug/dwtools/abase/l3',
      './debug/dwtools/abase/l3/testing12',
      './debug/dwtools/abase/l3/testing12/Include.s',
      './debug/dwtools/abase/l3/testing12/ModuleForTesting12.s',
      './debug/dwtools/abase/l3.test',
      './debug/dwtools/abase/l3.test/ModuleForTesting12.test.s'
    ]
    var files = self.find( a.abs( 'out' ) );
    test.gt( files.length, 4 );
    test.identical( files, expected );

    return null;
  }

}

//

function reflectSubdir( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-subdir' );

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'setup';
    a.reflect();
    return null;
  })
  a.start({ execPath : '.each module .export' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.isTerminal( a.abs( 'submodule.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'out' ) ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.build variant:1'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  });
  a.start({ execPath : '.build variant:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.isTerminal( a.abs( './module/proto/File1.s' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( './out/debug/proto/File1.s' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( 'submodule.out.will.yml' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( 'out' ) ) );

    var expected =
    [
      '.',
      './.ex.will.yml',
      './.im.will.yml',
      './submodule.out.will.yml',
      './module',
      './module/submodule.will.yml',
      './module/proto',
      './module/proto/File1.s',
      './module/proto/File2.s',
      './out',
      './out/debug',
      './out/debug/proto',
      './out/debug/proto/File1.s',
      './out/debug/proto/File2.s',
    ]
    var got = self.find( a.routinePath );
    test.identical( got, expected );

    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.build variant:2'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  });
  a.start({ execPath : '.build variant:2' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.isTerminal( a.abs( './module/proto/File1.s' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( './out/debug/proto/File1.s' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( 'submodule.out.will.yml' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( 'out' ) ) );

    var expected =
    [
      '.',
      './.ex.will.yml',
      './.im.will.yml',
      './submodule.out.will.yml',
      './module',
      './module/submodule.will.yml',
      './module/proto',
      './module/proto/File1.s',
      './module/proto/File2.s',
      './out',
      './out/debug',
      './out/debug/proto',
      './out/debug/proto/File1.s',
      './out/debug/proto/File2.s',
    ]
    var got = self.find( a.routinePath );
    test.identical( got, expected );

    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.build variant:3'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  });
  a.start({ execPath : '.build variant:3' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.isTerminal( a.abs( './module/proto/File1.s' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( './out/debug/proto/File1.s' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( 'submodule.out.will.yml' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( 'out' ) ) );

    var expected =
    [
      '.',
      './.ex.will.yml',
      './.im.will.yml',
      './submodule.out.will.yml',
      './module',
      './module/submodule.will.yml',
      './module/proto',
      './module/proto/File1.s',
      './module/proto/File2.s',
      './out',
      './out/debug',
      './out/debug/proto',
      './out/debug/proto/File1.s',
      './out/debug/proto/File2.s',
    ]
    var got = self.find( a.routinePath );
    test.identical( got, expected );

    return null;
  })

  return a.ready;
}

//

function reflectSubmodulesWithBase( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-submodules-with-base' );

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'setup';
    a.reflect();
    return null;
  })

  /* */

  a.start({ execPath : '.each module .export' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.isTerminal( a.abs( 'submodule1.out.will.yml' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( 'submodule2.out.will.yml' ) ) );
    return got;
  })

  /* */

  a.ready.then( () =>
  {
    test.case = 'variant 0, src basePath : ../..'
    a.fileProvider.filesDelete( a.abs( 'out' ) )
    return null;
  });

  a.start({ execPath : '.build variant:0' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var expected =
    [
      '.',
      './debug',
      './debug/reflectSubmodulesWithBase',
      './debug/reflectSubmodulesWithBase/module',
      './debug/reflectSubmodulesWithBase/module/proto',
      './debug/reflectSubmodulesWithBase/module/proto/File1.s',
      './debug/reflectSubmodulesWithBase/module/proto/File2.s'
    ]
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, expected );
    return got;
  })

  /* */

  a.ready.then( () =>
  {
    test.case = 'variant 1, src basePath : "{submodule::*/exported::*=1/path::exported.dir*=1}/../.."'
    a.fileProvider.filesDelete( a.abs( 'out' ) )
    return null;
  });

  a.start({ execPath : '.build variant:1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var expected =
    [
      '.',
      './debug',
      './debug/module',
      './debug/module/proto',
      './debug/module/proto/File1.s',
      './debug/module/proto/File2.s'
    ];
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, expected );
    return got;
  })

  /* */

  return a.ready;
}

reflectSubmodulesWithBase.timeOut = 150000;

//

function reflectComposite( test )
{
  let self = this;
  let a = self.assetFor( test, 'composite-reflector' );
  a.reflect();

  /* */

  a.ready.then( () =>
  {
    test.case = '.build out* variant:0'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build out* variant:0' })
  .then( ( arg ) =>
  {
    var expected =
    [
      '.',
      './debug',
      './debug/dir1',
      './debug/dir1/for-git.txt',
      './debug/dir2',
      './debug/dir2/File.js',
      './debug/dir2/File.test.js',
      './debug/dir2/File1.debug.js',
      './debug/dir2/File2.debug.js'
    ]
    var files = self.find( a.abs( 'out' ) );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  a.ready.then( () =>
  {
    test.case = '.build out* variant:1'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build out* variant:1' })
  .then( ( arg ) =>
  {
    var expected =
    [
      '.',
      './debug',
      './debug/dir1',
      './debug/dir1/for-git.txt',
      './debug/dir2',
      './debug/dir2/File.js',
      './debug/dir2/File.test.js',
      './debug/dir2/File1.debug.js',
      './debug/dir2/File2.debug.js'
    ]
    var files = self.find( a.abs( 'out' ) );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  a.ready.then( () =>
  {
    test.case = '.build out* variant:2'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build out* variant:2' })
  .then( ( arg ) =>
  {
    var expected =
    [
      '.',
      './debug',
      './debug/dir1',
      './debug/dir1/for-git.txt',
      './debug/dir2',
      './debug/dir2/File.js',
      './debug/dir2/File.test.js',
      './debug/dir2/File1.debug.js',
      './debug/dir2/File2.debug.js'
    ]
    var files = self.find( a.abs( 'out' ) );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  a.ready.then( () =>
  {
    test.case = '.build out* variant:3'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build out* variant:3' })
  .then( ( arg ) =>
  {
    var expected =
    [
      '.',
      './debug',
      './debug/dir1',
      './debug/dir1/for-git.txt',
      './debug/dir2',
      './debug/dir2/File.js',
      './debug/dir2/File.test.js',
      './debug/dir2/File1.debug.js',
      './debug/dir2/File2.debug.js'
    ]
    var files = self.find( a.abs( 'out' ) );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  a.ready.then( () =>
  {
    test.case = '.build out* variant:4'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build out* variant:4' })
  .then( ( arg ) =>
  {
    var expected =
    [ '.', './debug', './debug/dir1', './debug/dir1/File.js', './debug/dir1/File.test.js', './debug/dir1/File1.debug.js', './debug/dir1/File2.debug.js' ]
    var files = self.find( a.abs( 'out' ) );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  a.ready.then( () =>
  {
    test.case = '.build out* variant:5'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build out* variant:5' })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.js', './debug/dir1/File.test.js', './debug/dir1/File1.debug.js', './debug/dir1/File2.debug.js' ];
    var files = self.find( a.abs( 'out' ) );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  a.ready.then( () =>
  {
    test.case = '.build out* variant:6'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build out* variant:6' })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.test.js' ];
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  a.ready.then( () =>
  {
    test.case = '.build out* variant:7'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build out* variant:7' })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.test.js' ]
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  return a.ready;
}

//

function reflectRemoteGit( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-remote-git' );
  a.reflect();

  let local1Path = a.abs( 'ModuleForTesting2a' );
  let local2Path = a.abs( 'ModuleForTesting1b' );
  let local3Path = a.abs( 'ModuleForTesting12' );

  /* - */

  a.ready.then( () =>
  {
    test.case = '.build download.* variant:1'
    a.fileProvider.filesDelete( local1Path );
    return null;
  })

  a.start({ execPath : '.build download.* variant:1' })
  .then( ( arg ) => validate1( arg ) )

  /* */

  .then( () =>
  {
    test.case = '.build download.* variant:2'
    a.fileProvider.filesDelete( local1Path );
    return null;
  })

  a.start({ execPath : '.build download.* variant:2' })
  .then( ( arg ) => validate1( arg ) )

  /* */

  .then( () =>
  {
    test.case = '.build download.* variant:3'
    a.fileProvider.filesDelete( local1Path );
    return null;
  })

  a.start({ execPath : '.build download.* variant:3' })
  .then( ( arg ) => validate1( arg ) )

  /* */

  .then( () =>
  {
    test.case = '.build download.* variant:4'
    a.fileProvider.filesDelete( local1Path );
    return null;
  })

  a.start({ execPath : '.build download.* variant:4' })
  .then( ( arg ) => validate1( arg ) )

  /* */

  .then( () =>
  {
    test.case = '.build download.* variant:5'
    a.fileProvider.filesDelete( local1Path );
    return null;
  })

  a.start({ execPath : '.build download.* variant:5' })
  .then( ( arg ) => validate1( arg ) )

  /* */

  .then( () =>
  {
    test.case = '.build download.* variant:6'
    a.fileProvider.filesDelete( local1Path );
    return null;
  })

  a.start({ execPath : '.build download.* variant:6' })
  .then( ( arg ) => validate1( arg ) )

  /* */

  .then( () =>
  {
    test.case = '.build download.* variant:7'
    a.fileProvider.filesDelete( local1Path );
    return null;
  })

  a.start({ execPath : '.build download.* variant:7' })
  .then( ( arg ) => validate2( arg ) )

  /* */

  .then( () =>
  {
    a.fileProvider.filesDelete( local1Path );
    a.fileProvider.filesDelete( local2Path );
    a.fileProvider.filesDelete( local3Path );
    return null;
  })

  /* */

  return a.ready;

  /* */

  function validate1( arg )
  {
    test.identical( arg.exitCode, 0 );
    var files = self.find( local1Path );
    test.ge( files.length, 10 );
    return null;
  }

  /* */

  function validate2( arg )
  {
    test.identical( arg.exitCode, 0 );

    var files = self.find( local1Path );
    test.ge( files.length, 10 );
    var files = self.find( local2Path );
    test.ge( files.length, 10 );
    var files = self.find( local3Path );
    test.ge( files.length, 10 );

    return null;
  }

}

//

function reflectRemoteHttp( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-remote-http' );
  a.reflect();

  /* - */

  a.ready.then( () =>
  {
    test.case = '.build download'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build download' })
  .then( ( arg ) =>
  {
    test.is( a.fileProvider.isTerminal( a.abs( 'out/ModuleForTesting1.s' ) ) );
    test.gt( a.fileProvider.fileSize( a.abs( 'out/ModuleForTesting1.s' ) ), 200 );
    return null;
  })

  return a.ready;
}

//

function reflectWithOptions( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-with-options' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with mandatory .build variant1';
    return null;
  })

  a.startNonThrowing({ execPath : '.with mandatory .clean' })
  a.startNonThrowing({ execPath : '.with mandatory .build variant1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ reflector::reflect.proto1 reflected 3 file\(s\) .+\/reflectWithOptions\/.* : .*out\/debug.* <- .*proto.* in/ ) );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/File.js', './debug/File.test.js' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with mandatory .build variant2';
    return null;
  })

  a.startNonThrowing({ execPath : '.with mandatory .clean' })
  a.startNonThrowing({ execPath : '.with mandatory .build variant2' })
  .finally( ( err, got ) =>
  {
    test.is( !err );
    test.is( !!got.exitCode );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, '====' ), 0 );
    test.is( _.strHas( got.output, /Failed .*module::.+ \/ step::reflect\.proto2/ ) );
    test.is( _.strHas( got.output, /No file found at .+/ ) );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with mandatory .build variant3';
    return null;
  })

  a.startNonThrowing({ execPath : '.with mandatory .clean' })
  a.startNonThrowing({ execPath : '.with mandatory .build variant3' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ reflector::reflect.proto3 reflected 0 file\(s\) .+\/reflectWithOptions\/.* : .*out\/debug.* <- .*proto.* in/ ) );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [] );
    return null;
  })

  /* - */

  return a.ready;
}

//

function reflectWithOptionDstRewriting( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-with-options-dst-rewriting' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'reflect file, break hardlink and try to reflect again';
    return null;
  })

  a.startNonThrowing({ execPath : '.clean' })

  a.startNonThrowing({ execPath : '.build variant1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/File.js' ] );

    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js'), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, true );
    a.fileProvider.fileDelete( a.abs( 'proto/File.js') )
    a.fileProvider.fileWrite( a.abs( 'proto/File.js'), 'console.log( "File2.js" )' )
    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js' ), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, false );

    a.fileProvider.fileWrite( a.abs( 'proto/File.js' ), `console.log( '123' );` );

    return null;
  })

  a.startNonThrowing({ execPath : '.build variant1' })
  .finally( ( err, got ) =>
  {
    test.is( !err );
    test.is( !!got.exitCode );
    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js' ), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, false );
    return null;
  })

  /* xxx for Vova : adjust styles */
  //

  a.ready.then( () =>
  {
    test.case = 'reflect file with dstRewritingOnlyPreserving : 0, hard link should be restored';
    return null;
  })

  a.startNonThrowing({ execPath : '.build variant2' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js' ), a.abs( 'out/debug/File.js' ) ])
    var read = a.fileProvider.fileRead( a.abs( 'proto/File.js') );
    test.identical( read, `console.log( '123' );` )
    var read = a.fileProvider.fileRead( a.abs( 'out/debug/File.js' ) );
    test.identical( read, `console.log( '123' );` )
    test.identical( linked, true );

    return null;
  })

  .then( () =>
  {
    test.case = 'unlink out file and try to restore';
    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js'), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, true );
    a.fileProvider.fileDelete( a.abs( 'out/debug/File.js' ) )
    a.fileProvider.fileWrite( a.abs( 'out/debug/File.js' ), 'console.log( "Unlinked.js" )' )
    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js'), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, false );
    return null;
  })

  a.startNonThrowing({ execPath : '.build variant1' })
  .finally( ( err, got ) =>
  {
    test.is( !err );
    test.is( !!got.exitCode );
    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js' ), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, false );
    return null;
  })

  a.startNonThrowing({ execPath : '.build variant2' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js' ), a.abs( 'out/debug/File.js' ) ])
    var read = a.fileProvider.fileRead( a.abs( 'proto/File.js') );
    test.identical( read, `console.log( '123' );` )
    var read = a.fileProvider.fileRead( a.abs( 'out/debug/File.js' ) );
    test.identical( read, `console.log( '123' );` )
    test.identical( linked, true );

    return null;
  })

  /* - */

  return a.ready;
}

//

function reflectWithOptionLinking( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-with-options-linking' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'reflect file using hardlinking';
    return null;
  })

  a.startNonThrowing({ execPath : '.build variant1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/File.js' ] );

    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js'), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, true );

    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = 'linking : fileCopy, other options default, should throw error';
    return null;
  })

  a.startNonThrowing({ execPath : '.build variant2' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );

    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js'), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, true );

    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = 'linking : fileCopy,dstRewritingOnlyPreserving : 0, breakingDstHardLink : 1';
    return null;
  })

  a.startNonThrowing({ execPath : '.build variant3' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/File.js' ] );

    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js'), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, false );

    let write = 'console.log( "File2.js" )';
    a.fileProvider.fileWrite( a.abs( 'proto/File.js'), write );
    let read = a.fileProvider.fileRead( a.abs( 'out/debug/File.js') );
    test.notIdentical( write, read );

    return null;
  })

  /* - */

  return a.ready;
}

//

function reflectorFromPredefinedWithOptions( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflector-with-options-from-predefined' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'reflector without explicit inherit property';
    return null;
  })

  a.startNonThrowing({ execPath : '.build variant1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/File.js' ] );

    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js'), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, false );

    var read1 = a.fileProvider.fileRead( a.abs( 'proto/File.js' ) );
    var read2 = a.fileProvider.fileRead( a.abs( 'out/debug/File.js' ) );

    test.notIdentical( read1, read2 )

    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = 'same reflector but has explicit inherit from predefined reflector';
    return null;
  })
  a.startNonThrowing({ execPath : '.build variant2' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/File.js' ] );

    var linked = a.fileProvider.filesAreHardLinked([ a.abs( 'proto/File.js'), a.abs( 'out/debug/File.js' ) ])
    test.identical( linked, false );

    var read1 = a.fileProvider.fileRead( a.abs( 'proto/File.js' ) );
    var read2 = a.fileProvider.fileRead( a.abs( 'out/debug/File.js' ) );

    test.notIdentical( read1, read2 )

    return null;
  })

  /* - */

  return a.ready;
}

//

function reflectWithSelectorInDstFilter( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-selecting-dst' );
  a.reflect();

  /*
    reflect.proto:
      filePath :
        path::proto : .
      dst :
        basePath : .
        prefixPath : path::out.*=1 #<-- doesn't work
        # prefixPath : "{path::out.*=1}" #<-- this works
      criterion :
        debug : [ 0,1 ]
  */

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build debug';
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build debug' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/Single.s' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build release';
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build release' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './release', './release/Single.s' ] );
    return null;
  })

  /* - */

  return a.ready;
}

//

function reflectSubmodulesWithCriterion( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-with-criterion' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'setup'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    return null;
  })

  a.start({ execPath : '.with module/A .export' })
  a.start({ execPath : '.with module/B .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.routinePath );
    var expected =
    [
      '.',
      './.ex.will.yml',
      './.im.will.yml',
      './module',
      './module/A.out.will.yml',
      './module/A.will.yml',
      './module/B.out.will.yml',
      './module/B.will.yml',
      './module/A',
      './module/A/A.js',
      './module/B',
      './module/B/B.js'
    ]
    test.identical( files, expected );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'reflect only A'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    return null;
  })

  a.start({ execPath : '.build A' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out/debug' ) );
    var expected = [ '.', './A.js' ];
    test.identical( files, expected );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'reflect only B'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    return null;
  })

  a.start({ execPath : '.build B' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out/debug' ) );
    var expected = [ '.', './B.js' ];
    test.identical( files, expected );
    return null;
  })

  /* - */

  return a.ready;
}

//

function reflectSubmodulesWithPluralCriterionManualExport( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-submodules-with-plural-criterion' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'reflect informal submodule, manual export'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.each module .export' })

  // fails with error on first run

  a.start({ execPath : '.build variant1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    var expected = [ '.', './debug', './debug/File.s' ];
    test.identical( files, expected );
    return null;
  })

  return a.ready;
}

//

function reflectSubmodulesWithPluralCriterionEmbeddedExport( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-submodules-with-plural-criterion' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'reflect informal submodule exported using steps, two builds in a row'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  // first run works

  a.start({ execPath : '.build variant2' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    var expected = [ '.', './debug', './debug/File.s' ];
    test.identical( files, expected );
    return null;
  })

  // second run fails

  a.start({ execPath : '.build variant2' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    var expected = [ '.', './debug', './debug/File.s' ];
    test.identical( files, expected );
    return null;
  })

  return a.ready;
}

reflectSubmodulesWithPluralCriterionEmbeddedExport.timeOut = 300000;

//

function reflectNpmModules( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-npm-modules' );

  /* - */

  a.ready

  .then( () =>
  {
    a.reflect();
    return null;
  })

  /* */

  a.start( '.build' )
  .then( ( got ) =>
  {
    test.case = 'reflect exported npm modules';

    test.identical( got.exitCode, 0 );

    var exp =
    [
      '.',
      './out',
      './out/wModuleForTesting12ab.out.will.yml',
      './out/wModuleForTesting2a.out.will.yml',
      './proto',
      './proto/dwtools',
      './proto/dwtools/Tools.s',
      './proto/dwtools/abase',
      './proto/dwtools/abase/l3',
      './proto/dwtools/abase/l3/testing2a',
      './proto/dwtools/abase/l3/testing2a/Include.s',
      './proto/dwtools/abase/l3/testing2a/ModuleForTesting2a.s',
      './proto/dwtools/abase/l4',
      './proto/dwtools/abase/l4/Include.s',
      './proto/dwtools/abase/l4/l4',
      './proto/dwtools/abase/l4/l4/ModuleForTesting12ab.s'
    ]
    var files = self.find( a.abs( 'out' ) )
    test.identical( files, exp );

    return null;
  })

  /*  */

  return a.ready;
}

reflectNpmModules.timeOut = 150000;

//

/*
  moduleA exports:
  proto
    amid
      Tools.s

  moduleB exports:
    proto
      amid

  proto/amid of moduleB doesn't exist on hard drive, but its listed in out file

  main module reflects files of these modules, when assert fails
*/

function relfectSubmodulesWithNotExistingFile( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-reflect-with-not-existing' );
  a.reflect();
  _.assert( a.fileProvider.fileExists( a.abs( 'module/moduleB/proto/amid/File.txt' ) ) );
  a.fileProvider.fileDelete( a.abs( 'module/moduleB/proto/amid/File.txt' ) );

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'setup';
    return null;
  })

  a.start({ execPath : '.clean recursive:2' })
  a.start({ execPath : '.with module/moduleA/ .export' })
  a.start({ execPath : '.with module/moduleB/ .export' })

  /* - */

  a.ready
  // .finally( ( err, arg ) => / Dmytro : got is not defined, so `arg` replaced to `got` */
  .finally( ( err, got ) =>
  {
    test.is( err === undefined );
    if( err )
    logger.log( err );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    return got || null;
  })

  .then( () =>
  {
    test.case = 'reflect submodules'

    let exp =
    [
      '.',
      './.will.yml',
      './module',
      './module/moduleA.out.will.yml',
      './module/moduleB.out.will.yml',
      './module/moduleA',
      './module/moduleA/.will.yml',
      './module/moduleA/out',
      './module/moduleA/out/debug',
      './module/moduleA/out/debug/amid',
      './module/moduleA/out/debug/amid/Tools.s',
      './module/moduleA/proto',
      './module/moduleA/proto/amid',
      './module/moduleA/proto/amid/Tools.s',
      './module/moduleB',
      './module/moduleB/.will.yml',
      './module/moduleB/out',
      './module/moduleB/out/debug',
      './module/moduleB/out/debug/amid',
      './module/moduleB/proto',
      './module/moduleB/proto/amid'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    return null;
  })

  a.start({ execPath : '.build' })

  a.ready
  .finally( ( err, got ) =>
  {
    test.is( _.errIs( err ) );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    logger.log( err );
    if( err )
    throw err;
    return got;
  })

  return test.shouldThrowErrorAsync( a.ready );
}

//

function reflectInherit( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-inherit' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build reflect.proto1'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build reflect.proto1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, ' + reflector::reflect.proto1 reflected 6 file(s)' ) );
    test.is( _.strHas( got.output, /.*out\/debug1.* <- .*proto.*/ ) );
    var files = self.find( a.routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug1', './out/debug1/File.js', './out/debug1/File.s', './out/debug1/File.test.js', './out/debug1/some.test', './out/debug1/some.test/File2.js', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build reflect.proto2'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build reflect.proto2' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, ' + reflector::reflect.proto2 reflected 6 file(s)' ) );
    test.is( _.strHas( got.output, /.*out\/debug2.* <- .*proto.*/ ) );
    var files = self.find( a.routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug2', './out/debug2/File.js', './out/debug2/File.s', './out/debug2/File.test.js', './out/debug2/some.test', './out/debug2/some.test/File2.js', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build reflect.proto3'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build reflect.proto3' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, ' + reflector::reflect.proto3 reflected 6 file(s)' ) );
    test.is( _.strHas( got.output, /.*out\/debug1.* <- .*proto.*/ ) );
    var files = self.find( a.routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug1', './out/debug1/File.js', './out/debug1/File.s', './out/debug1/File.test.js', './out/debug1/some.test', './out/debug1/some.test/File2.js', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build reflect.proto4'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build reflect.proto4' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, ' + reflector::reflect.proto4 reflected 6 file(s)' ) );
    test.is( _.strHas( got.output, /.*out\/debug2.* <- .*proto.*/ ) );
    var files = self.find( a.routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug2', './out/debug2/File.js', './out/debug2/File.s', './out/debug2/File.test.js', './out/debug2/some.test', './out/debug2/some.test/File2.js', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build reflect.proto5'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build reflect.proto5' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, ' + reflector::reflect.proto5 reflected 6 file(s)' ) );
    test.is( _.strHas( got.output, /.*out\/debug2.* <- .*proto.*/ ) );
    var files = self.find( a.routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug2', './out/debug2/File.js', './out/debug2/File.s', './out/debug2/File.test.js', './out/debug2/some.test', './out/debug2/some.test/File2.js', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build not1'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build not1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, ' + reflector::reflect.not.test.only.js.v1 reflected 4 file(s)' ) );
    test.is( _.strHas( got.output, /.*out.* <- .*proto.*/ ) );
    var exp =
    [
      '.',
      './.will.yml',
      './out',
      './out/debug1',
      './out/debug1/File.js',
      './out/debug2',
      './out/debug2/File.js',
      './proto',
      './proto/File.js',
      './proto/File.s',
      './proto/File.test.js',
      './proto/some.test',
      './proto/some.test/File2.js'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build reflect.files1'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build reflect.files1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, / \+ reflector::reflect.files1 reflected 2 file\(s\) .*:.*out.*<-.*proto/ ), 1 );
    test.identical( _.strCount( got.output, /.*out.* <- .*proto.*/ ), 1 );
    var files = self.find( a.routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/File.js', './out/File.s', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build reflect.files2'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build reflect.files2' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, / \+ reflector::reflect.files2 reflected 2 file\(s\) .*:.*out.*<-.*proto/ ), 1 );
    test.identical( _.strCount( got.output, /.*out.* <- .*proto.*/ ), 1 );
    var files = self.find( a.routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/File.js', './out/File.s', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build reflect.files3'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build reflect.files3' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, / \+ reflector::reflect\.files3 reflected 2 file\(s\) .*:.*out.*<-.*proto/ ), 1 );
    test.identical( _.strCount( got.output, /.*out.* <- .*proto.*/ ), 1 );
    var files = self.find( a.routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/File.js', './out/File.s', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  return a.ready;
}

reflectInherit.timeOut = 300000;

//

/*
  Check reflector inheritance from multiple ancestors.
  Check exporting single file with custom base.
  Check importing single file with custom base.
*/

function reflectInheritSubmodules( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflect-inherit-submodules' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'setup'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.each module .export' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.routinePath );
    test.identical( files, [ '.', './a.will.yml', './b.will.yml', './c.will.yml', './submodule1.out.will.yml', './submodule2.out.will.yml', './submodule3.out.will.yml', './submodule4.out.will.yml', './module', './module/submodule1.will.yml', './module/submodule2.will.yml', './module/submodule3.will.yml', './module/submodule4.will.yml', './module/proto', './module/proto/File1.s', './module/proto/File2.s', './module/proto1', './module/proto1/File1.s', './module/proto2', './module/proto2/File2.s' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with a .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.with a .build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/File1.s', './debug/File2.s' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with b .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.with b .build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/f1', './debug/f2' ] );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with c .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.with c .build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/File1.s', './debug/File2.s' ] );
    return null;
  })

  /* - */

  return a.ready;
}

//

function reflectComplexInherit( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-with-submodules' );

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with ab/ .build';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.with a .export' })
  a.start({ execPath : '.with b .export' })
  a.start({ execPath : '.with ab/ .build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ reflector::files.all reflected 21 file(s)' ) );
    var exp =
    [
      '.',
      './module-a.out.will.yml',
      './module-b.out.will.yml',
      './ab',
      './ab/files',
      './ab/files/a',
      './ab/files/a/File.js',
      './ab/files/b',
      './ab/files/b/-Excluded.js',
      './ab/files/b/File.js',
      './ab/files/b/File.test.js',
      './ab/files/b/File1.debug.js',
      './ab/files/b/File1.release.js',
      './ab/files/b/File2.debug.js',
      './ab/files/b/File2.release.js',
      './ab/files/dir3.test',
      './ab/files/dir3.test/File.js',
      './ab/files/dir3.test/File.test.js'
    ]
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, exp );
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with abac/ .build';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.with a .export' })
  a.start({ execPath : '.with b .export' })
  a.start({ execPath : '.with c .export' })
  a.start({ execPath : '.with ab/ .export' })
  a.start({ execPath : '.with abac/ .build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ reflector::files.all reflected 24 file(s)' ) );
    var exp =
    [
      '.',
      './module-a.out.will.yml',
      './module-b.out.will.yml',
      './module-c.out.will.yml',
      './ab',
      './ab/module-ab.out.will.yml',
      './abac',
      './abac/files',
      './abac/files/a',
      './abac/files/a/File.js',
      './abac/files/b',
      './abac/files/b/-Excluded.js',
      './abac/files/b/File.js',
      './abac/files/b/File.test.js',
      './abac/files/b/File1.debug.js',
      './abac/files/b/File1.release.js',
      './abac/files/b/File2.debug.js',
      './abac/files/b/File2.release.js',
      './abac/files/c',
      './abac/files/c/File.js',
      './abac/files/dir3.test',
      './abac/files/dir3.test/File.js',
      './abac/files/dir3.test/File.test.js'
    ]
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, exp );
    return null;
  })

  /* - */

  return a.ready;
} /* end of function reflectComplexInherit */

reflectComplexInherit.timeOut = 300000;

//

function reflectorMasks( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflector-masks' );
  a.reflect();

  /* - */

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build copy.' })

  .then( ( got ) =>
  {
    test.case = 'mask directory';

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './release', './release/proto.two' ] );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, new RegExp( `\\+ reflector::reflect.copy. reflected ${files.length-1} file\\(s\\) .* in .*` ) ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build copy.debug' })

  .then( ( got ) =>
  {
    test.case = 'mask terminal';

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/build.txt.js', './debug/manual.md', './debug/package.json', './debug/tutorial.md' ] );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, new RegExp( `\\+ reflector::reflect.copy.debug reflected ${files.length -1} file\\(s\\) .* in .*` ) ) );

    return null;
  })

  /* - */

  return a.ready;
}

//

function reflectorsCommonPrefix( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflectors-common-prefix' );
  a.reflect();

  /* - */

  a.start({ execPath : '.build' })

  .then( ( got ) =>
  {
    test.case = 'use two reflectors with common prefix in name';

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './debug', './debug/Source.js' ] );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, new RegExp( `\\+ reflector::reflect.copy reflected 1 file\\(s\\) .* in .*` ) ) );
    test.is( _.strHas( got.output, new RegExp( `\\+ reflector::reflect.copy.second reflected 1 file\\(s\\) .* in .*` ) ) );

    return null;
  })

  /* - */

  return a.ready;
}

//

function reflectorOptionStep( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflector-option-step' );
  a.reflect();

  /* - */

  a.start({ execPath : '.build' })

  .then( ( got ) =>
  {
    test.case = 'copy proto and then use reflector to remote it';

    test.is( !_.fileProvider.fileExists( a.abs( 'out' ) ) );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, new RegExp( `\\+ reflector::reflector.proto reflected 2 file\\(s\\) .* in .*` ) ) );
    test.is( _.strHas( got.output, new RegExp( `\\- step::reflector.delete deleted 2 file\\(s\\), at .* in .*` ) ) );

    return null;
  })

  /* - */

  return a.ready;
}

//

function reflectorOptionStepThrowing( test )
{
  let self = this;
  let a = self.assetFor( test, 'reflector-option-step-throwing' );
  a.reflect();

  /* - */

  a.startNonThrowing({ execPath : '.build' })

  .then( ( got ) =>
  {
    test.case = 'try to create reflector with name of existing step using option step, should throw error';
    test.notIdentical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, 'step::reflector.delete deleted 0 file' ) );

    return null;
  })

  /* - */

  return a.ready;
}

// --
// with do
// --

function withDoInfo( test )
{
  let self = this;
  let a = self.assetFor( test, 'dos' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    mode : 'spawn',
    outputGraying : 1,
    throwingExitCode : 1,
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.start( '.clean' )
  a.start( '.export' )
  .then( ( got ) =>
  {
    test.case = 'setup';
    a.fileProvider.fileAppend( a.abs( 'will.yml' ), '\n' );

    test.is( a.fileProvider.fileExists( a.abs( 'out/proto' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( 'out/dos.out.will.yml' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12' ) ) );

    return null;
  })

  /* - */

  a.start( '.hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 10 );
    test.identical( _.strCount( got.output, '! Outdated' ), 1 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 0 );
    test.identical( _.strCount( got.output, 'local :' ), 1 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );
    return null;
  })

  /* - */

  a.start( '.with . .hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.with . .hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 10 );
    test.identical( _.strCount( got.output, '! Outdated' ), 1 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 0 );
    test.identical( _.strCount( got.output, 'local :' ), 1 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );
    return null;
  })

  /* - */

  a.start( '.with * .hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.with . .hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 10 );
    test.identical( _.strCount( got.output, '! Outdated' ), 1 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 0 );
    test.identical( _.strCount( got.output, 'local :' ), 1 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );
    return null;
  })

  /* - */

  a.start( '.with ** .hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.with . .hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 12 );
    test.identical( _.strCount( got.output, '! Outdated' ), 1 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 1 );
    test.identical( _.strCount( got.output, 'local :' ), 7 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );
    return null;
  })

  /* - */

  a.start( '.imply withOut:0 ; .with ** .hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.imply withOut:0 ; .with ** .hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 9 );
    test.identical( _.strCount( got.output, '! Outdated' ), 0 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 1 );
    test.identical( _.strCount( got.output, 'local :' ), 7 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );
    return null;
  })

  /* - */

  a.start( '.imply withIn:0 ; .with ** .hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.imply withIn:0 ; .with ** .hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 3 );
    test.identical( _.strCount( got.output, '! Outdated' ), 1 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 0 );
    test.identical( _.strCount( got.output, 'local :' ), 4 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function withDoInfo */

withDoInfo.timeOut = 300000;
withDoInfo.description =
`
- do execute js script
- filtering option withIn works
- filtering option withOut works
- only one attempt to open outdate outfile
- action info works properly
- message with time printed afterwards
`

//

function withDoStatus( test )
{
  let self = this;
  let a = self.assetFor( test, 'dos' );
  a.start = _.process.starter // Dmytro : not exists in assetFor
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    mode : 'spawn',
    outputCollecting : 1,
    outputGraying : 1,
    throwingExitCode : 1,
    ready : a.ready,
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = 'setup';
    a.reflect();
    a.shell({ execPath : 'git init', currentPath : a.abs( 'disabled' ) });

    return null;
  })

  /* - */

  a.start( '.clean' )
  a.start( '.export' )
  .then( ( got ) =>
  {
    test.case = 'setup';

    test.is( a.fileProvider.fileExists( a.abs( 'out/proto' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( 'out/dos.out.will.yml' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12' ) ) );

    return null;
  })

  /* - */

  a.start( '.hooks.list' )
  .then( ( got ) =>
  {
    test.case = 'hooks list';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '/status.js' ), 1 );
    return null;
  })

  /* - */

  a.start( '.with ** .do .will/hook/status.js' )
  .then( ( got ) =>
  {
    test.case = 'no changes';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 13 );
    test.identical( _.strCount( got.output, '! Outdated' ), 0 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 1 );
    return null;
  })

  /* - */

  .then( ( got ) =>
  {
    test.case = 'changes';
    a.fileProvider.fileAppend( a.abs( '.module/ModuleForTesting1/README.md' ), '\n' );
    a.fileProvider.fileAppend( a.abs( '.module/ModuleForTesting2a/README.md' ), '\n' );
    a.fileProvider.fileAppend( a.abs( '.module/ModuleForTesting12/LICENSE' ), '\n' );
    return null;
  })

  a.start( '.with ** .do .will/hook/status.js' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 13 );
    test.identical( _.strCount( got.output, '! Outdated' ), 0 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 1 );
    test.identical( _.strCount( got.output, /module::\w+ at / ), 3 );
    test.identical( _.strCount( got.output, 'module at' ), 2 );

    test.identical( _.strCount( got.output, 'M ' ), 3 );
    return null;
  })

  /* - */

  return a.ready;
} /* end of function withDoStatus */

withDoStatus.timeOut = 300000;
withDoStatus.description =
`
- it.shell exposed for action
- it.shell has proper current path
- errorors are brief
`

//

function withDoCommentOut( test )
{
  let self = this;
  let a = self.assetFor( test, 'dos' );

  /* - */

  a.ready
  .then( ( got ) =>
  {
    a.reflect();
    var outfile = a.fileProvider.configRead( a.abs( 'execution_section/will.yml' ) );
    test.is( !!outfile.execution );
    return null;
  })
  a.start( '.with ** .do .will/hook/WillfCommentOut.js execution' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'Comment out "execution" in module::execution_section at' ), 1 );
    var outfile = a.fileProvider.configRead( a.abs( 'execution_section/will.yml' ) );
    test.is( !outfile.execution );
    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    a.reflect();
    var outfile = a.fileProvider.configRead( a.abs( 'execution_section/will.yml' ) );
    test.is( !!outfile.execution );
    return null;
  })
  a.start( '.with ** .do .will/hook/WillfCommentOut.js execution dry:1' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'Comment out "execution" in module::execution_section at' ), 1 );
    var outfile = a.fileProvider.configRead( a.abs( 'execution_section/will.yml' ) );
    test.is( !!outfile.execution );
    return null;
  })

  /* - */

  return a.ready;
} /* end of function withDoCommentOut */

withDoCommentOut.timeOut = 300000;
withDoCommentOut.description =
`
- commenting out works
- arguments passing to action works
`

//

function hookCallInfo( test )
{
  let self = this;
  let a = self.assetFor( test, 'dos' );
  // aaa : modules for testing are still broken !!! /* Dmytro : fixed */
  // aaa : ?? /* Dmytro : a.start - mode : 'fork'; a.shell - mode : 'shell' */
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    mode : 'spawn',
    outputCollecting : 1,
    outputGraying : 1,
    throwingExitCode : 1,
    ready : a.ready,
  });

  a.reflect();

  /* - */

  a.start( '.clean' )
  a.start( '.export' )
  .then( ( got ) =>
  {
    test.case = 'setup';
    a.fileProvider.fileAppend( a.abs( 'will.yml' ), '\n' );

    test.is( a.fileProvider.fileExists( a.abs( 'out/proto' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( 'out/dos.out.will.yml' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12' ) ) );

    return null;
  })

  /* - */

  a.start( '.hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 10 );
    test.identical( _.strCount( got.output, '! Outdated' ), 1 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 0 );
    test.identical( _.strCount( got.output, 'local :' ), 1 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );
    return null;
  })

  /* - */

  a.start( '.with . .hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.with . .hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 10 );
    test.identical( _.strCount( got.output, '! Outdated' ), 1 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 0 );
    test.identical( _.strCount( got.output, 'local :' ), 1 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );
    return null;
  })

  /* - */

  a.start( '.with * .hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.with . .hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 10 );
    test.identical( _.strCount( got.output, '! Outdated' ), 1 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 0 );
    test.identical( _.strCount( got.output, 'local :' ), 1 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );
    return null;
  })

  /* - */

  a.start( '.with ** .hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.with . .hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 12 );
    test.identical( _.strCount( got.output, '! Outdated' ), 1 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 1 );
    test.identical( _.strCount( got.output, 'local :' ), 7 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );
    return null;
  })

  /* - */

  a.start( '.imply withOut:0 ; .with ** .hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.imply withOut:0 ; .with ** .hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 9 );
    test.identical( _.strCount( got.output, '! Outdated' ), 0 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 1 );
    test.identical( _.strCount( got.output, 'local :' ), 7 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );
    return null;
  })

  /* - */

  a.start( '.imply withIn:0 ; .with ** .hook.call info.js' )
  .then( ( got ) =>
  {
    test.case = '.imply withIn:0 ; .with ** .hook.call info.js';
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 3 );
    test.identical( _.strCount( got.output, '! Outdated' ), 1 );
    test.identical( _.strCount( got.output, 'Willfile should not have section' ), 0 );
    test.identical( _.strCount( got.output, 'local :' ), 4 );
    test.identical( _.strCount( got.output, 'Done hook::info.js in' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function hookCallInfo */

hookCallInfo.timeOut = 300000;
hookCallInfo.description =
`
- do execute js script
- filtering option withIn works
- filtering option withOut works
- only one attempt to open outdate outfile
- action info works properly
- message with time printed afterwards
`

//

function hookGitMake( test )
{
  let self = this;
  let a = self.assetFor( test, 'dos' );
  a.reflect();

  /* - */

  test.is( true );

  let config = a.fileProvider.configUserRead();
  if( !config || !config.about || !config.about[ 'github.token' ] )
  return null;
  let user = config.about.user;


  /* - */

  a.start({ execPath : '.module.new New2/' })

  .then( ( got ) =>
  {
    var exp = [ '.', './will.yml' ];
    var files = self.find( a.abs( 'New2' ) );
    test.identical( files, exp );

    return _.git.repositoryDelete
    ({
      remotePath : `https://github.com/${user}/New2`,
      token : config.about[ 'github.token' ],
    });
  })

  a.start({ execPath : '.with New2/ .hook.call GitMake v:3' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, `Making repository for module::New2 at` ), 1 );
    test.identical( _.strCount( got.output, `localPath :` ), 1 );
    test.identical( _.strCount( got.output, `remotePath : https://github.com/${user}/New2.git` ), 1 );
    test.identical( _.strCount( got.output, `Making remote repository git+https:///github.com/${user}/New2.git` ), 1 );
    test.identical( _.strCount( got.output, `Making a new local repository at` ), 1 );
    test.identical( _.strCount( got.output, `git init .` ), 1 );
    test.identical( _.strCount( got.output, `git remote add origin https://github.com/${user}/New2.git` ), 1 );
    test.identical( _.strCount( got.output, `> ` ), 2 );

    var exp = [ '.', './will.yml' ];
    var files = self.find( a.abs( 'New2' ) );
    test.identical( files, exp );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function hookGitMake */

hookGitMake.timeOut = 300000;

//

function hookPrepare( test )
{
  let self = this;
  let a = self.assetFor( test, 'dos' );
  a.reflect();

  test.is( true );

  let config = a.fileProvider.configUserRead();
  if( !config || !config.about || !config.about[ 'github.token' ] )
  return null;
  let user = config.about.user;

  /* - */

  a.ready
  .then( ( got ) =>
  {
    var exp = [];
    var files = self.find( a.abs( 'New2' ) );
    test.identical( files, exp );
    return _.git.repositoryDelete
    ({
      remotePath : `https://github.com/${user}/New2`,
      token : config.about[ 'github.token' ],
    });
  })

  start({ execPath : '.with New2/ .module.new.with prepare v:3' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, `Making repository for module::New2 at` ), 1 );
    test.identical( _.strCount( got.output, `localPath :` ), 1 );
    test.identical( _.strCount( got.output, `remotePath : https://github.com/${user}/New2.git` ), 1 );
    test.identical( _.strCount( got.output, `Making remote repository git+https:///github.com/${user}/New2.git` ), 1 );
    test.identical( _.strCount( got.output, `Making a new local repository at` ), 1 );
    test.identical( _.strCount( got.output, `git init .` ), 1 );
    test.identical( _.strCount( got.output, `git remote add origin https://github.com/${user}/New2.git` ), 1 );
    test.identical( _.strCount( got.output, `git push -u origin --all --follow-tags` ), 1 );
    test.identical( _.strCount( got.output, `> ` ), 10 );

    var exp =
    [
      '.',
      './-will.yml',
      './.ex.will.yml',
      './.gitattributes',
      './.gitignore',
      './.im.will.yml',
      './.travis.yml',
      './LICENSE',
      './README.md',
      './was.package.json',
      './proto',
      './proto/dwtools',
      './proto/dwtools/Tools.s',
      './proto/dwtools/abase',
      './proto/dwtools/amid',
      './proto/dwtools/atop',
      './sample',
      './sample/Sample.html',
      './sample/Sample.js'
    ]
    var files = self.find( a.abs( 'New2' ) );
    test.identical( files, exp );

    return null;
  })

  .then( ( got ) =>
  {
    debugger;
    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    var exp = [];
    var files = self.find( a.abs( 'New3/New4' ) );
    test.identical( files, exp );
    return _.git.repositoryDelete
    ({
      remotePath : `https://github.com/${user}/New4`,
      token : config.about[ 'github.token' ],
    });
  })

  a.start({ execPath : '.with New3/New4 .module.new.with prepare v:3' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, `Making repository for module::New4 at` ), 1 );
    test.identical( _.strCount( got.output, `localPath :` ), 1 );
    test.identical( _.strCount( got.output, `remotePath : https://github.com/${user}/New4.git` ), 1 );
    test.identical( _.strCount( got.output, `Making remote repository git+https:///github.com/${user}/New4.git` ), 1 );
    test.identical( _.strCount( got.output, `Making a new local repository at` ), 1 );
    test.identical( _.strCount( got.output, `git init .` ), 1 );
    test.identical( _.strCount( got.output, `git remote add origin https://github.com/${user}/New4.git` ), 1 );
    test.identical( _.strCount( got.output, `git push -u origin --all --follow-tags` ), 1 );
    test.identical( _.strCount( got.output, `> ` ), 10 );

    var exp =
    [
      '.',
      './-New4.will.yml',
      './.ex.will.yml',
      './.gitattributes',
      './.gitignore',
      './.im.will.yml',
      './.travis.yml',
      './LICENSE',
      './README.md',
      './was.package.json',
      './proto',
      './proto/dwtools',
      './proto/dwtools/Tools.s',
      './proto/dwtools/abase',
      './proto/dwtools/amid',
      './proto/dwtools/atop',
      './sample',
      './sample/Sample.html',
      './sample/Sample.js'
    ]
    var files = self.find( a.abs( 'New3' ) );
    test.identical( files, exp );

    return null;
  })

  .then( ( got ) =>
  {
    debugger;
    return null;
  })

  /* - */

  return a.ready;

} /* end of function hookPrepare */

hookPrepare.timeOut = 300000;

//

function hookHlink( test )
{
  let self = this;
  let a = self.assetFor( test, 'git-conflict' );

  let originalShell = _.process.starter
  ({
    currentPath : a.abs( 'original' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'shell',
  })

  let cloneShell = _.process.starter
  ({
    currentPath : a.abs( 'clone' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'shell',
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    a.reflect();
    a.fileProvider.filesReflect({ reflectMap : { [ a.path.join( self.assetsOriginalPath, 'dos/.will' ) ] : a.abs( '.will' ) } });
    a.fileProvider.fileAppend( a.abs( 'original/f1.txt' ), '\ncopy' );
    a.fileProvider.fileAppend( a.abs( 'original/f2.txt' ), '\ncopy' );
    return null;
  })

  originalShell( 'git init' );
  originalShell( 'git add --all' );
  originalShell( 'git commit -am first' );
  a.shell( `git clone original clone` );

  a.start( '.with original/ .call hlink beeping:0' )
  .then( ( got ) =>
  {
    test.case = '.with original/ .call hlink beeping:0';

    test.identical( _.strHas( got.output, '+ hardLink' ), true );
    test.is( a.fileProvider.filesAreHardLinked( a.abs( 'original/f1.txt' ), a.abs( 'original/f2.txt' ) ) );
    test.is( !a.fileProvider.filesAreHardLinked( a.abs( 'clone/f1.txt' ), a.abs( 'original/f1.txt' ) ) );
    test.is( !a.fileProvider.filesAreHardLinked( a.abs( 'clone/f1.txt' ), a.abs( 'clone/f2.txt' ) ) );

    return null;
  })

  a.start( '.with clone/ .call hlink beeping:0' )
  .then( ( got ) =>
  {
    test.case = '.with clone/ .call hlink beeping:0';

    test.identical( _.strHas( got.output, '+ hardLink' ), true );
    test.is( a.fileProvider.filesAreHardLinked( a.abs( 'original/f1.txt' ), a.abs( 'original/f2.txt' ) ) );
    test.is( !a.fileProvider.filesAreHardLinked( a.abs( 'clone/f1.txt' ), a.abs( 'original/f1.txt' ) ) );
    test.is( a.fileProvider.filesAreHardLinked( a.abs( 'clone/f1.txt' ), a.abs( 'clone/f2.txt' ) ) );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function hookHlink */

hookHlink.description =
`
- same files are hardlinked
- same files from different modules are not hardlinked
`
hookHlink.timeOut = 300000;

//

function hookGitPullConflict( test )
{
  let self = this;
  let a = self.assetFor( test, 'git-conflict' );

  let originalShell = _.process.starter
  ({
    currentPath : a.abs( 'original' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'shell',
  })

  let cloneShell = _.process.starter
  ({
    currentPath : a.abs( 'clone' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'shell',
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    a.reflect();
    a.fileProvider.filesReflect({ reflectMap : { [ a.path.join( self.assetsOriginalPath, 'dos/.will' ) ] : a.abs( '.will' ) } });
    a.fileProvider.fileAppend( a.abs( 'original/f1.txt' ), 'copy\n' );
    a.fileProvider.fileAppend( a.abs( 'original/f2.txt' ), 'copy\n' );
    return null;
  })

  originalShell( 'git init' );
  originalShell( 'git add --all' );
  originalShell( 'git commit -am first' );
  a.shell( `git clone original clone` );

  a.start( '.with clone/ .call hlink beeping:0' )

  .then( ( got ) =>
  {
    test.description = 'hardlink';

    test.is( !a.fileProvider.filesAreHardLinked( a.abs( 'original/f1.txt' ), a.abs( 'original/f2.txt' ) ) );
    test.is( a.fileProvider.filesAreHardLinked( a.abs( 'clone/f1.txt' ), a.abs( 'clone/f2.txt' ) ) );

    a.fileProvider.fileAppend( a.abs( 'clone/f1.txt' ), 'clone\n' );
    a.fileProvider.fileAppend( a.abs( 'original/f1.txt' ), 'original\n' );

    var exp =
`
original/f.txt
copy
original
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'original/f1.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'original/f2.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
clone
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'clone/f1.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
clone
`
    var orignalRead2 = a.fileProvider.fileRead( a.abs( 'clone/f2.txt' ) );
    test.equivalent( orignalRead2, exp );

    return null;
  })

  originalShell( 'git commit -am second' );

  a.startNonThrowing( '.with clone/ .call GitPull v:5' )
  .then( ( got ) =>
  {
    test.description = 'has local changes';
    test.notIdentical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'has local changes' ), 1 );

    test.is( !a.fileProvider.filesAreHardLinked( a.abs( 'original/f1.txt' ), a.abs( 'original/f2.txt' ) ) );
    test.is( a.fileProvider.filesAreHardLinked( a.abs( 'clone/f1.txt' ), a.abs( 'clone/f2.txt' ) ) );

    var exp =
`
original/f.txt
copy
original
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'original/f1.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'original/f2.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
clone
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'clone/f1.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
clone
`
    var orignalRead2 = a.fileProvider.fileRead( a.abs( 'clone/f2.txt' ) );
    test.equivalent( orignalRead2, exp );

    return null;
  })

  cloneShell( 'git commit -am second' );

  a.startNonThrowing( '.with clone/ .call GitPull v:5' )
  .then( ( got ) =>
  {
    test.description = 'conflict';
    test.notIdentical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'has local changes' ), 0 );
    test.identical( _.strCount( got.output, 'CONFLICT (content): Merge conflict in f1.txt' ), 1 );
    test.identical( _.strCount( got.output, 'Restored 1 hardlinks' ), 1 );

    test.is( !a.fileProvider.filesAreHardLinked( a.abs( 'original/f1.txt' ), a.abs( 'original/f2.txt' ) ) );
    test.is( a.fileProvider.filesAreHardLinked( a.abs( 'clone/f1.txt' ), a.abs( 'clone/f2.txt' ) ) );

    var exp =
`
original/f.txt
copy
original
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'original/f1.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'original/f2.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
 <<<<<<< HEAD
clone
=======
original
 >>>>>>>
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'clone/f1.txt' ) );
    orignalRead1 = orignalRead1.replace( />>>> .+/, '>>>>' );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
 <<<<<<< HEAD
clone
=======
original
 >>>>>>>
`
    var orignalRead2 = a.fileProvider.fileRead( a.abs( 'clone/f2.txt' ) );
    orignalRead2 = orignalRead2.replace( />>>> .+/, '>>>>' );
    test.equivalent( orignalRead2, exp );
    return null;
  })

  /* - */

  return a.ready;
} /* end of function hookGitPullConflict */

hookGitPullConflict.timeOut = 300000;
hookGitPullConflict.description =
`
- pull done
- conflict is not obstacle to relink files
- if conflict then application returns error code
`

//

function hookGitSyncColflict( test )
{
  let self = this;
  let a = self.assetFor( test, 'git-conflict' );

  let originalShell = _.process.starter
  ({
    currentPath : a.abs( 'original' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'shell',
  })

  let cloneShell = _.process.starter
  ({
    currentPath : a.abs( 'clone' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'shell',
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    a.reflect();
    a.fileProvider.filesReflect({ reflectMap : { [ a.path.join( self.assetsOriginalPath, 'dos/.will' ) ] : a.abs( '.will' ) } });
    a.fileProvider.fileAppend( a.abs( 'original/f1.txt' ), 'copy\n' );
    a.fileProvider.fileAppend( a.abs( 'original/f2.txt' ), 'copy\n' );
    return null;
  })

  originalShell( 'git init' );
  originalShell( 'git add --all' );
  originalShell( 'git commit -am first' );
  a.shell( `git clone original clone` );

  a.start( '.with clone/ .call hlink beeping:0' )

  .then( ( got ) =>
  {
    test.description = 'hardlink';

    test.is( !a.fileProvider.filesAreHardLinked( a.abs( 'original/f1.txt' ), a.abs( 'original/f2.txt' ) ) );
    test.is( a.fileProvider.filesAreHardLinked( a.abs( 'clone/f1.txt' ), a.abs( 'clone/f2.txt' ) ) );

    a.fileProvider.fileAppend( a.abs( 'clone/f1.txt' ), 'clone\n' );
    a.fileProvider.fileAppend( a.abs( 'original/f1.txt' ), 'original\n' );

    var exp =
`
original/f.txt
copy
original
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'original/f1.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'original/f2.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
clone
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'clone/f1.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
clone
`
    var orignalRead2 = a.fileProvider.fileRead( a.abs( 'clone/f2.txt' ) );
    test.equivalent( orignalRead2, exp );

    return null;
  })

  originalShell( 'git commit -am second' );

  a.startNonThrowing( '.with clone/ .call GitSync -am "second"' )
  .then( ( got ) =>
  {
    test.description = 'conflict';
    test.notIdentical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'has local changes' ), 0 );
    test.identical( _.strCount( got.output, 'CONFLICT (content): Merge conflict in f1.txt' ), 1 );
    test.identical( _.strCount( got.output, 'Restored 1 hardlinks' ), 1 );
    test.identical( _.strCount( got.output, '> git add' ), 1 );
    test.identical( _.strCount( got.output, '> git commit' ), 1 );
    test.identical( _.strCount( got.output, '> git push' ), 0 );

    test.is( !a.fileProvider.filesAreHardLinked( a.abs( 'original/f1.txt' ), a.abs( 'original/f2.txt' ) ) );
    test.is( a.fileProvider.filesAreHardLinked( a.abs( 'clone/f1.txt' ), a.abs( 'clone/f2.txt' ) ) );

    var exp =
`
original/f.txt
copy
original
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'original/f1.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'original/f2.txt' ) );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
 <<<<<<< HEAD
clone
=======
original
 >>>>>>>
`
    var orignalRead1 = a.fileProvider.fileRead( a.abs( 'clone/f1.txt' ) );
    orignalRead1 = orignalRead1.replace( />>>> .+/, '>>>>' );
    test.equivalent( orignalRead1, exp );

    var exp =
`
original/f.txt
copy
 <<<<<<< HEAD
clone
=======
original
 >>>>>>>
`
    var orignalRead2 = a.fileProvider.fileRead( a.abs( 'clone/f2.txt' ) );
    orignalRead2 = orignalRead2.replace( />>>> .+/, '>>>>' );
    test.equivalent( orignalRead2, exp );
    return null;
  })

  /* - */

  return a.ready;
} /* end of function hookGitSyncColflict */

hookGitSyncColflict.timeOut = 300000;
hookGitSyncColflict.description =
`
- pull done
- conflict is not obstacle to relink files
- if conflict then application returns error code
`

//

function hookGitSyncArguments( test )
{
  let self = this;
  let a = self.assetFor( test, 'git-conflict' );

  let originalShell = _.process.starter
  ({
    currentPath : a.abs( 'original' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'shell',
  })

  let cloneShell = _.process.starter
  ({
    currentPath : a.abs( 'clone' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'shell',
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    a.reflect();
    a.fileProvider.filesReflect({ reflectMap : { [ a.path.join( self.assetsOriginalPath, 'dos/.will' ) ] : a.abs( '.will' ) } });
    a.fileProvider.fileAppend( a.abs( 'original/f1.txt' ), 'copy\n' );
    a.fileProvider.fileAppend( a.abs( 'original/f2.txt' ), 'copy\n' );
    return null;
  })

  originalShell( 'git init' );
  originalShell( 'git add --all' );
  originalShell( 'git commit -am first' );
  a.shell( `git clone original clone` );

  a.ready.then( ( got ) =>
  {
    test.description = 'hardlink';
    a.fileProvider.fileAppend( a.abs( 'clone/f1.txt' ), 'clone\n' );
    a.fileProvider.fileAppend( a.abs( 'original/f1.txt' ), 'original\n' );
    return null;
  })

  originalShell( 'git commit -am second' );

  a.startNonThrowing( '.with clone/ .call GitSync -am "second commit"' )
  .then( ( got ) =>
  {
    test.description = 'conflict';
    test.notIdentical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'has local changes' ), 0 );
    test.identical( _.strCount( got.output, 'CONFLICT (content): Merge conflict in f1.txt' ), 1 );
    test.identical( _.strCount( got.output, '> git add' ), 1 );
    test.identical( _.strCount( got.output, '> git commit' ), 1 );
    test.identical( _.strCount( got.output, '> git push' ), 0 );
    return null;
  })

  /* - */

  return a.ready;
} /* end of function hookGitSyncArguments */

hookGitSyncArguments.timeOut = 300000;
hookGitSyncArguments.description =
`
- quoted argument passed to git through willbe properly
`

//

function verbositySet( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.ready
  a.start({ execPath : '.clean' })
  a.start({ execPath : '.imply verbosity:3 ; .build' })
  .finally( ( err, got ) =>
  {
    test.case = '.imply verbosity:3 ; .build';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )

    test.is( _.strHas( got.output, '.imply verbosity:3 ; .build' ) );
    test.is( _.strHas( got.output, / \. Opened .+\/\.im\.will\.yml/ ) );
    test.is( _.strHas( got.output, / \. Opened .+\/\.ex\.will\.yml/ ) );
    test.is( _.strHas( got.output, 'Failed to open module::submodules / relation::ModuleForTesting1' ) );
    test.is( _.strHas( got.output, 'Failed to open module::submodules / relation::ModuleForTesting2a' ) );
    test.is( _.strHas( got.output, '. Read 2 willfile(s) in' ) );

    test.is( _.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, ' + 2/2 submodule(s) of module::submodules were downloaded' ) );
    test.is( _.strHas( got.output, ' + 0/2 submodule(s) of module::submodules were downloaded' ) );
    test.identical( _.strCount( got.output, 'submodule(s)' ), 2 );
    test.is( _.strHas( got.output, / - .*step::delete.out.debug.* deleted 0 file\(s\)/ ) );
    test.is( _.strHas( got.output, ' + reflector::reflect.proto.debug reflected 2 file(s)' ) );
    test.is( _.strHas( got.output, ' + reflector::reflect.submodules reflected' ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.imply verbosity:2 ; .build' })
  .finally( ( err, got ) =>
  {
    test.case = '.imply verbosity:2 ; .build';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )

    test.is( _.strHas( got.output, '.imply verbosity:2 ; .build' ) );
    test.is( !_.strHas( got.output, / \. Opened .+\/\.im\.will\.yml/ ) );
    test.is( !_.strHas( got.output, / \. Opened .+\/\.ex\.will\.yml/ ) );
    test.is( !_.strHas( got.output, 'Failed to open relation::ModuleForTesting1' ) );
    test.is( !_.strHas( got.output, 'Failed to open relation::ModuleForTesting2a' ) );
    test.is( _.strHas( got.output, '. Read 2 willfile(s) in' ) );

    test.is( _.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, ' + 2/2 submodule(s) of module::submodules were downloaded' ) );
    test.is( _.strHas( got.output, ' + 0/2 submodule(s) of module::submodules were downloaded' ) );
    test.identical( _.strCount( got.output, 'submodule(s)' ), 2 );
    test.is( _.strHas( got.output, / - .*step::delete.out.debug.* deleted 0 file\(s\)/ ) );
    test.is( _.strHas( got.output, ' + reflector::reflect.proto.debug reflected 2 file(s)' ) );
    test.is( _.strHas( got.output, ' + reflector::reflect.submodules reflected' ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.imply verbosity:1 ; .build' })
  .finally( ( err, got ) =>
  {
    test.case = '.imply verbosity:1 ; .build';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )

    test.is( _.strHas( got.output, '.imply verbosity:1 ; .build' ) );
    test.is( !_.strHas( got.output, / \. Opened .+\/\.im\.will\.yml/ ) );
    test.is( !_.strHas( got.output, / \. Opened .+\/\.ex\.will\.yml/ ) );
    test.is( !_.strHas( got.output, ' ! Failed to open relation::ModuleForTesting1' ) );
    test.is( !_.strHas( got.output, ' ! Failed to open relation::ModuleForTesting2a' ) );
    test.is( !_.strHas( got.output, '. Read 2 willfile(s) in' ) );

    test.is( !_.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( !_.strHas( got.output, ' + 2/2 submodule(s) of module::submodules were downloaded' ) );
    test.is( !_.strHas( got.output, ' + 0/2 submodule(s) of module::submodules were downloaded' ) );
    test.identical( _.strCount( got.output, 'submodule(s)' ), 0 );
    test.is( !_.strHas( got.output, ' - Deleted' ) );
    test.is( !_.strHas( got.output, ' + reflect.proto.debug reflected 2 file(s) ' ) );
    test.is( !_.strHas( got.output, ' + reflect.submodules reflected' ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    return null;
  })

  /* - */

  return a.ready;
}

verbositySet.timeOut = 300000;

//

/*
  Check verbosity field of step::files.delete.
  Check logging of step::files.delete.
*/

function verbosityStepDelete( test )
{
  let self = this;
  let a = self.assetFor( test, 'verbosity-step-delete' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.build files.delete.vd';
    a.reflect();
    return null;
  })

  a.start({ execPath : '.build files.delete.vd' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( a.abs( 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.vd.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\// ), 1 );

    var files = self.find( a.abs( 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.build files.delete.v0';
    a.reflect();
    return null;
  })

  a.start({ execPath : '.build files.delete.v0' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( a.abs( 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v0.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, 'Deleted' ), 0 );

    var files = self.find( a.abs( 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.build files.delete.v1';
    a.reflect();
    return null;
  })

  a.start({ execPath : '.build files.delete.v1' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( a.abs( 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v1.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\// ), 1 );

    var files = self.find( a.abs( 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.build files.delete.v3';
    a.reflect();
    return null;
  })

  a.start({ execPath : '.build files.delete.v3' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( a.abs( 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 1 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 1 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 1 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v3.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\// ), 1 );

    var files = self.find( a.abs( 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.imply v:0 ; .build files.delete.vd';
    a.reflect();
    return null;
  })

  a.start({ execPath : '.imply v:0 ; .build files.delete.vd' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( a.abs( 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.vd.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.is( 2 <=_.strLinesCount( got.output ) && _.strLinesCount( got.output ) <= 3 );

    var files = self.find( a.abs( 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.imply v:8 ; .build files.delete.v0';
    a.reflect();
    return null;
  })

  a.start({ execPath : '.imply v:8 ; .build files.delete.v0' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( a.abs( 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v0.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\// ), 0 );

    var files = self.find( a.abs( 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.imply v:9 ; .build files.delete.v0';
    a.reflect();
    return null;
  })

  a.start({ execPath : '.imply v:9 ; .build files.delete.v0' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( a.abs( 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 1 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 1 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 1 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v0.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\// ), 1 );

    var files = self.find( a.abs( 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.imply v:1 ; .build files.delete.v3';
    a.reflect();
    return null;
  })

  a.start({ execPath : '.imply v:1 ; .build files.delete.v3' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( a.abs( 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v3.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\// ), 1 );

    var files = self.find( a.abs( 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.imply v:2 ; .build files.delete.v3';
    a.reflect();
    return null;
  })

  a.start({ execPath : '.imply v:2 ; .build files.delete.v3' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( a.abs( 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 1 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 1 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 1 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v3.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\// ), 1 );

    var files = self.find( a.abs( 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  return a.ready;
}

//

/*
  Checks printing name of step before it execution
*/

function verbosityStepPrintName( test )
{
  let self = this;
  let a = self.assetFor( test, 'verbosity-step-print-name' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })

  /* - */

  a.ready
  .then( ( arg ) =>
  {
    a.reflect();
    return arg;
  })

  a.start({ execPath : '.imply v:4 ; .build' })

  .then( ( got ) =>
  {
    test.description = '.imply v:4 ; .build';

    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Building .*module::verbosityStepPrintName \/ build::debug/ ), 1 );
    test.identical( _.strCount( got.output, /: .*reflector::reflect.file.*/ ), 1 );
    test.identical( _.strCount( got.output, '+ reflector::reflect.file reflected 1 file(s)' ), 1 );
    test.identical( _.strCount( got.output, '/verbosityStepPrintName/ : ./out <- ./file in' ), 1 );
    test.identical( _.strCount( got.output, /.*>.*node -e "console.log\( 'shell.step' \)"/ ), 1 );
    test.identical( _.strCount( got.output, /at.* .*verbosityStepPrintName/ ), 3 );
    test.identical( _.strCount( got.output, 'shell.step' ), 2 );
    test.identical( _.strCount( got.output, /: .*step::delete.step.*/ ), 1 );
    test.identical( _.strCount( got.output, /1 at .*\/out/ ), 1 );
    test.identical( _.strCount( got.output, /1 at \./ ), 1 );
    test.identical( _.strCount( got.output, /- .*step::delete.step.* deleted 1 file\(s\), at .*verbosityStepPrintName\/out.*/ ), 1 );
    test.identical( _.strCount( got.output, /Built .*module::verbosityStepPrintName \/ build::debug.* in / ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( ( arg ) =>
  {
    a.reflect();
    return arg;
  })

  a.start({ execPath : '.imply v:3 ; .build' })

  .then( ( got ) =>
  {
    test.description = '.imply v:3 ; .build';

    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Building .*module::verbosityStepPrintName \/ build::debug/ ), 1 );
    test.identical( _.strCount( got.output, /: .*reflector::reflect.file.*/ ), 0 );
    test.identical( _.strCount( got.output, '+ reflector::reflect.file reflected 1 file(s)' ), 1 );
    test.identical( _.strCount( got.output, '/verbosityStepPrintName/ : ./out <- ./file' ), 1 );
    test.identical( _.strCount( got.output, /.*>.*node -e "console.log\( 'shell.step' \)"/ ), 1 );
    test.identical( _.strCount( got.output, /at.* .*verbosityStepPrintName/ ), 1 );
    test.identical( _.strCount( got.output, 'shell.step' ), 2 );
    test.identical( _.strCount( got.output, /: .*step::delete.step.*/ ), 0 );
    test.identical( _.strCount( got.output, /1 at .*\/out/ ), 0 );
    test.identical( _.strCount( got.output, /1 at \./ ), 0 );
    test.identical( _.strCount( got.output, /- .*step::delete.step.* deleted 1 file\(s\), at .*verbosityStepPrintName\/out.*/ ), 1 );
    test.identical( _.strCount( got.output, /Built .*module::verbosityStepPrintName \/ build::debug.* in / ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( ( arg ) =>
  {
    a.reflect();
    return arg;
  })

  a.start({ execPath : '.imply v:2 ; .build' })

  .then( ( got ) =>
  {
    test.description = '.imply v:2 ; .build';

    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Building .*module::verbosityStepPrintName \/ build::debug/ ), 1 );
    test.identical( _.strCount( got.output, /: .*reflector::reflect.file.*/ ), 0 );
    test.identical( _.strCount( got.output, ' + reflector::reflect.file reflected 1 file(s)' ), 1 );
    test.identical( _.strCount( got.output, '/verbosityStepPrintName/ : ./out <- ./file in' ), 1 );
    test.identical( _.strCount( got.output, /.*>.*node -e "console.log\( 'shell.step' \)"/ ), 1 );
    test.identical( _.strCount( got.output, /at.* .*verbosityStepPrintName/ ), 1 );
    test.identical( _.strCount( got.output, 'shell.step' ), 1 );
    test.identical( _.strCount( got.output, /: .*step::delete.step.*/ ), 0 );
    test.identical( _.strCount( got.output, /1 at .*\/out/ ), 0 );
    test.identical( _.strCount( got.output, /1 at \./ ), 0 );
    test.identical( _.strCount( got.output, /- .*step::delete.step.* deleted 1 file\(s\), at .*verbosityStepPrintName\/out.*/ ), 1 );
    test.identical( _.strCount( got.output, /Built .*module::verbosityStepPrintName \/ build::debug.* in / ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( ( arg ) =>
  {
    a.reflect();
    return arg;
  })

  a.start({ execPath : '.imply v:1 ; .build' })

  .then( ( got ) =>
  {
    test.description = '.imply v:1 ; .build';

    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Building .*module::verbosityStepPrintName \/ build::debug/ ), 0 );
    test.identical( _.strCount( got.output, /: .*reflector::reflect.file.*/ ), 0 );
    test.identical( _.strCount( got.output, ' + reflector::reflect.file.* reflected 1 file(s) .* : .*out.* <- .*file.* in ' ), 0 );
    test.identical( _.strCount( got.output, /.*>.*node -e "console.log\( 'shell.step' \)"/ ), 0 );
    test.identical( _.strCount( got.output, /at.* .*verbosityStepPrintName/ ), 0 );
    test.identical( _.strCount( got.output, 'shell.step' ), 0 );
    test.identical( _.strCount( got.output, /: .*step::delete.step.*/ ), 0 );
    test.identical( _.strCount( got.output, /1 at .*\/out/ ), 0 );
    test.identical( _.strCount( got.output, /1 at \./ ), 0 );
    test.identical( _.strCount( got.output, /- .*step::delete.step.* deleted 1 file\(s\), at .*verbosityStepPrintName\/out.*/ ), 0 );
    test.identical( _.strCount( got.output, /Built .*module::verbosityStepPrintName \/ build::debug.* in / ), 1 );

    return null;
  })

  /* - */

/*
  Building module::verbosity-step-print-name / build::debug
   : reflector::reflect.file
   + reflector::reflect.file reflected 1 file(s) /C/pro/web/Dave/git/trunk/builder/include/dwtools/atop/will.test/asset/verbosity-step-print-name/ : out <- file in 0.290s
 > node -e "console.log( 'shell.step' )"
   at /C/pro/web/Dave/git/trunk/builder/include/dwtools/atop/will.test/asset/verbosity-step-print-name
shell.step
   : step::delete.step
     1 at /C/pro/web/Dave/git/trunk/builder/include/dwtools/atop/will.test/asset/verbosity-step-print-name/out
     1 at .
   - step::delete.step deleted 1 file(s), at /C/pro/web/Dave/git/trunk/builder/include/dwtools/atop/will.test/asset/verbosity-step-print-name/out0.017s
  Built module::verbosity-step-print-name / build::debug in 0.643s
*/

  return a.ready;
} /* end of function verbosityStepPrintName */

//

function modulesTreeDotless( test )
{
  let self = this;
  let a = self.assetFor( test, 'two-dotless-single-exported' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply v:1 ; .modules.tree withLocalPath:1';
    return null;
  })

  a.start({ execPath : '.imply v:1 ; .modules.tree withLocalPath:1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, '+-- module::' ), 2 );
    test.identical( _.strCount( got.output, 'modulesTreeDotless/' ), 2 );
    test.identical( _.strCount( got.output, 'modulesTreeDotless/sub' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.modules.tree withLocalPath:1'
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    return null;
  })

  a.start({ execPath : '.modules.tree withLocalPath:1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, '+-- module::' ), 2 );
    test.identical( _.strCount( got.output, 'modulesTreeDotless/' ), 4 );
    test.identical( _.strCount( got.output, 'modulesTreeDotless/sub' ), 2 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function modulesTreeDotless */

//

function modulesTreeLocal( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-with-submodules' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply v:1 ; .with */* .modules.tree';
    return null;
  })

  a.start({ execPath : '.imply v:1 ; .with */* .modules.tree' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '-- module::' ), 19 );

    let exp =
`
Command ".imply v:1 ; .with */* .modules.tree"
 +-- module::module-x
 |
 +-- module::module-ab-named
 | +-- module::module-a
 | +-- module::module-b
 |
 +-- module::module-bc-named
 | +-- module::module-b
 | +-- module::module-c
 |
 +-- module::module-aabc
 | +-- module::module-a
 | +-- module::module-ab
 | | +-- module::module-a
 | | +-- module::module-b
 | +-- module::module-c
 |
 +-- module::module-abac
   +-- module::module-ab
   | +-- module::module-a
   | +-- module::module-b
   +-- module::module-a
   +-- module::module-c
`

    test.equivalent( got.output, exp );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function modulesTreeLocal */

//

function modulesTreeHierarchyRemote( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })
  a.reflect();
  a.fileProvider.filesDelete( a.abs( '.module' ) );

  /* - */

  a.start({ execPath : '.with * .modules.tree' })

  .then( ( got ) =>
  {
    test.case = '.with * .modules.tree';
    test.identical( got.exitCode, 0 );

    let exp =
`
 +-- module::z
   +-- module::a
   | +-- module::ModuleForTesting1
   | +-- module::ModuleForTesting1b
   | +-- module::a0
   |   +-- module::ModuleForTesting1
   |   +-- module::ModuleForTesting2a
   +-- module::b
   | +-- module::ModuleForTesting1b
   | +-- module::ModuleForTesting12
   +-- module::c
   | +-- module::a0
   | | +-- module::ModuleForTesting1
   | | +-- module::ModuleForTesting2a
   | +-- module::ModuleForTesting12ab
   +-- module::ModuleForTesting1b
`

    test.identical( _.strCount( got.output, exp ), 1 );
    test.identical( _.strCount( got.output, '+-- module::' ), 16 );
    test.identical( _.strCount( got.output, '+-- module::z' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::a' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::a0' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::b' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::c' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1' ), 8 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1b' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting2a' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12ab' ), 1 );

    return null;
  })

  /* - */

  a.start({ execPath : '.with * .modules.tree withRemotePath:1' })

  .then( ( got ) =>
  {
    test.case = '.with * .modules.tree withRemotePath:1';
    test.identical( got.exitCode, 0 );

    let exp =
`
 +-- module::z
   +-- module::a
   | +-- module::ModuleForTesting1 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1.git/
   | +-- module::ModuleForTesting1b - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1b.git/
   | +-- module::a0
   |   +-- module::ModuleForTesting1 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1.git/
   |   +-- module::ModuleForTesting2a - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting2a.git/
   +-- module::b
   | +-- module::ModuleForTesting1b - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1b.git/
   | +-- module::ModuleForTesting12 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting12.git/out/wModuleForTesting12.out
   +-- module::c
   | +-- module::a0
   | | +-- module::ModuleForTesting1 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1.git/
   | | +-- module::ModuleForTesting2a - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting2a.git/
   | +-- module::ModuleForTesting12ab - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting2b.git/out/wModuleForTesting12ab.out
   +-- module::ModuleForTesting1b - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1b.git/
`

    test.identical( _.strCount( got.output, exp ), 1 );
    test.identical( _.strCount( got.output, '+-- module::' ), 16 );
    test.identical( _.strCount( got.output, '+-- module::z' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::a' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::a0' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::b' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::c' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1' ), 8 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1b' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting2a' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12ab' ), 1 );

    return null;
  })

  /* - */

  a.start({ execPath : '.with * .modules.tree withLocalPath:1' })

  .then( ( got ) =>
  {
    test.case = '.with * .modules.tree withLocalPath:1';
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, '+-- module::' ), 16 );
    test.identical( _.strCount( got.output, '+-- module::z' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::a' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::a0' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::b' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::c' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1' ), 8 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1b' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting2a' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12ab' ), 1 );

    return null;
  })

  /* - */

  a.start({ execPath : '.with ** .modules.tree' })

  .then( ( got ) =>
  {
    test.case = '.with ** .modules.tree';
    test.identical( got.exitCode, 0 );

    let exp =
`
 +-- module::z
   +-- module::a
   | +-- module::ModuleForTesting1
   | +-- module::ModuleForTesting1b
   | +-- module::a0
   |   +-- module::ModuleForTesting1
   |   +-- module::ModuleForTesting2a
   +-- module::b
   | +-- module::ModuleForTesting1b
   | +-- module::ModuleForTesting12
   +-- module::c
   | +-- module::a0
   | | +-- module::ModuleForTesting1
   | | +-- module::ModuleForTesting2a
   | +-- module::ModuleForTesting12ab
   +-- module::ModuleForTesting1b
`
    test.identical( _.strCount( got.output, exp ), 1 );
    test.identical( _.strCount( got.output, '+-- module::' ), 16 );
    test.identical( _.strCount( got.output, '+-- module::z' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::a' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::a0' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::b' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::c' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1' ), 8 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1b' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting2a' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12ab' ), 1 );

    return null;
  })

  /* - */

  a.start({ execPath : '.with ** .modules.tree withRemotePath:1' })

  .then( ( got ) =>
  {
    test.case = '.with ** .modules.tree withRemotePath:1';
    test.identical( got.exitCode, 0 );

    let exp =
`
 +-- module::z
   +-- module::a
   | +-- module::ModuleForTesting1 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1.git/
   | +-- module::ModuleForTesting1b - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1b.git/
   | +-- module::a0
   |   +-- module::ModuleForTesting1 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1.git/
   |   +-- module::ModuleForTesting2a - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting2a.git/
   +-- module::b
   | +-- module::ModuleForTesting1b - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1b.git/
   | +-- module::ModuleForTesting12 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting12.git/out/wModuleForTesting12.out
   +-- module::c
   | +-- module::a0
   | | +-- module::ModuleForTesting1 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1.git/
   | | +-- module::ModuleForTesting2a - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting2a.git/
   | +-- module::ModuleForTesting12ab - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting2b.git/out/wModuleForTesting12ab.out
   +-- module::ModuleForTesting1b - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1b.git/
`
    test.identical( _.strCount( got.output, exp ), 1 );
    test.identical( _.strCount( got.output, '+-- module::' ), 16 );
    test.identical( _.strCount( got.output, '+-- module::z' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::a' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::a0' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::b' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::c' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1' ), 8 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1b' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting2a' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12ab' ), 1 );

    return null;
  })

  /* - */

  a.start({ execPath : '.with ** .modules.tree withLocalPath:1' })

  .then( ( got ) =>
  {
    test.case = '.with ** .modules.tree withLocalPath:1';
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, '+-- module::' ), 16 );
    test.identical( _.strCount( got.output, '+-- module::z' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::a' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::a0' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::b' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::c' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1' ), 8 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting1b' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting2a' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::ModuleForTesting12ab' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function modulesTreeHierarchyRemote */

modulesTreeHierarchyRemote.timeOut = 300000;

//

function modulesTreeHierarchyRemoteDownloaded( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })
  a.reflect();
  a.fileProvider.filesDelete( a.abs( '.module' ) );

  /* - */

  a.start({ execPath : '.with * .submodules.clean recursive:2' })
  a.start({ execPath : '.with * .submodules.download recursive:2' })

  /* - */

  a.start({ execPath : '.with * .modules.tree withRemotePath:1' })

  .then( ( got ) =>
  {
    test.case = '.with * .modules.tree withRemotePath:1';
    test.identical( got.exitCode, 0 );

    let exp =
`
 +-- module::z
   +-- module::a
   | +-- module::wTools - path::remote:=git+https:///github.com/Wandalen/wTools.git/
   | | +-- module::wFiles - path::remote:=npm:///wFiles
   | | +-- module::wCloner - path::remote:=npm:///wcloner
   | | +-- module::wStringer - path::remote:=npm:///wstringer
   | | +-- module::wTesting - path::remote:=npm:///wTesting
   | | +-- module::wSelector - path::remote:=npm:///wselector
   | | +-- module::wTools
   | +-- module::wPathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
   | | +-- module::wTools - path::remote:=npm:///wTools
   | | +-- module::wPathBasic - path::remote:=npm:///wpathbasic
   | | +-- module::wArraySorted - path::remote:=npm:///warraysorted
   | | +-- module::wPathTools
   | | +-- module::wFiles - path::remote:=npm:///wFiles
   | | +-- module::wTesting - path::remote:=npm:///wTesting
   | +-- module::a0
   |   +-- module::wPathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
   |   | +-- module::wTools - path::remote:=npm:///wTools
   |   | +-- module::wPathBasic - path::remote:=npm:///wpathbasic
   |   | +-- module::wArraySorted - path::remote:=npm:///warraysorted
   |   | +-- module::wPathTools
   |   | +-- module::wFiles - path::remote:=npm:///wFiles
   |   | +-- module::wTesting - path::remote:=npm:///wTesting
   |   +-- module::wPathBasic - path::remote:=git+https:///github.com/Wandalen/wPathBasic.git/
   |     +-- module::wTools - path::remote:=npm:///wTools
   |     +-- module::wFiles - path::remote:=npm:///wFiles
   |     +-- module::wTesting - path::remote:=npm:///wTesting
   +-- module::b
   | +-- module::wPathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
   | | +-- module::wTools - path::remote:=npm:///wTools
   | | +-- module::wPathBasic - path::remote:=npm:///wpathbasic
   | | +-- module::wArraySorted - path::remote:=npm:///warraysorted
   | | +-- module::wPathTools
   | | +-- module::wFiles - path::remote:=npm:///wFiles
   | | +-- module::wTesting - path::remote:=npm:///wTesting
   | +-- module::wProto - path::remote:=git+https:///github.com/Wandalen/wProto.git/
   |   +-- module::wTools - path::remote:=npm:///wTools
   |   +-- module::Self
   |   +-- module::wEqualer - path::remote:=npm:///wequaler
   |   +-- module::wTesting - path::remote:=npm:///wTesting
   +-- module::c
   | +-- module::a0
   | | +-- module::wPathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
   | | | +-- module::wTools - path::remote:=npm:///wTools
   | | | +-- module::wPathBasic - path::remote:=npm:///wpathbasic
   | | | +-- module::wArraySorted - path::remote:=npm:///warraysorted
   | | | +-- module::wPathTools
   | | | +-- module::wFiles - path::remote:=npm:///wFiles
   | | | +-- module::wTesting - path::remote:=npm:///wTesting
   | | +-- module::wPathBasic - path::remote:=git+https:///github.com/Wandalen/wPathBasic.git/
   | |   +-- module::wTools - path::remote:=npm:///wTools
   | |   +-- module::wFiles - path::remote:=npm:///wFiles
   | |   +-- module::wTesting - path::remote:=npm:///wTesting
   | +-- module::wUriBasic - path::remote:=git+https:///github.com/Wandalen/wUriBasic.git/
   |   +-- module::wTools - path::remote:=npm:///wTools
   |   +-- module::wPathBasic - path::remote:=npm:///wpathbasic
   |   +-- module::wUriBasic
   |   +-- module::wFiles - path::remote:=npm:///wFiles
   |   +-- module::wTesting - path::remote:=npm:///wTesting
   +-- module::wPathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
     +-- module::wTools - path::remote:=npm:///wTools
     +-- module::wPathBasic - path::remote:=npm:///wpathbasic
     +-- module::wArraySorted - path::remote:=npm:///warraysorted
     +-- module::wPathTools
     +-- module::wFiles - path::remote:=npm:///wFiles
     +-- module::wTesting - path::remote:=npm:///wTesting
`

    test.identical( _.strCount( got.output, exp ), 1 );
    test.identical( _.strCount( got.output, '+-- module::' ), 67 );
    test.identical( _.strCount( got.output, '+-- module::z' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::a' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::a0' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::b' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::c' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::wTools' ), 11 );
    test.identical( _.strCount( got.output, '+-- module::wPathTools' ), 10 );
    test.identical( _.strCount( got.output, '+-- module::wPathBasic' ), 8 );
    test.identical( _.strCount( got.output, '+-- module::wUriBasic' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::wProto' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function modulesTreeHierarchyRemoteDownloaded */

modulesTreeHierarchyRemoteDownloaded.timeOut = 300000;

//

/*
cls && local-will .with group1/group10/a0 .clean recursive:2 && local-will .with group1/group10/a0 .export && local-debug-will .with group1/a .export
*/

function modulesTreeHierarchyRemotePartiallyDownloaded( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })
  a.reflect();
  a.fileProvider.filesDelete( a.abs( '.module' ) );

  /* - */

  a.start({ execPath : '.with group1/group10/a0 .export' })
  a.start({ execPath : '.with group1/a .export' })
  a.start({ execPath : '.with * .modules.tree withRemotePath:1' })

  .then( ( got ) =>
  {
    test.case = '.with * .modules.tree withRemotePath:1';
    test.identical( got.exitCode, 0 );

    let exp =
// `
//  +-- module::z
//    +-- module::a
//    | +-- module::Tools - path::remote:=git+https:///github.com/Wandalen/wTools.git/
//    | +-- module::PathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
//    | +-- module::a0
//    |   +-- module::PathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
//    |   +-- module::PathBasic - path::remote:=git+https:///github.com/Wandalen/wPathBasic.git/
//    +-- module::b
//    | +-- module::PathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/out/wPathTools.out
//    | +-- module::Proto - path::remote:=git+https:///github.com/Wandalen/wProto.git/
//    +-- module::c
//    | +-- module::a0
//    | | +-- module::PathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
//    | | +-- module::PathBasic - path::remote:=git+https:///github.com/Wandalen/wPathBasic.git/
//    | +-- module::UriBasic - path::remote:=git+https:///github.com/Wandalen/wUriBasic.git/out/wUriBasic.out
//    +-- module::PathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
// `
`
 +-- module::z
   +-- module::a
   | +-- module::wTools - path::remote:=git+https:///github.com/Wandalen/wTools.git/
   | | +-- module::wFiles - path::remote:=npm:///wFiles
   | | +-- module::wCloner - path::remote:=npm:///wcloner
   | | +-- module::wStringer - path::remote:=npm:///wstringer
   | | +-- module::wTesting - path::remote:=npm:///wTesting
   | | +-- module::wSelector - path::remote:=npm:///wselector
   | | +-- module::wTools
   | +-- module::wPathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
   | | +-- module::wTools - path::remote:=npm:///wTools
   | | +-- module::wPathBasic - path::remote:=npm:///wpathbasic
   | | +-- module::wArraySorted - path::remote:=npm:///warraysorted
   | | +-- module::wPathTools
   | | +-- module::wFiles - path::remote:=npm:///wFiles
   | | +-- module::wTesting - path::remote:=npm:///wTesting
   | +-- module::a0
   |   +-- module::wPathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
   |   | +-- module::wTools - path::remote:=npm:///wTools
   |   | +-- module::wPathBasic - path::remote:=npm:///wpathbasic
   |   | +-- module::wArraySorted - path::remote:=npm:///warraysorted
   |   | +-- module::wPathTools
   |   | +-- module::wFiles - path::remote:=npm:///wFiles
   |   | +-- module::wTesting - path::remote:=npm:///wTesting
   |   +-- module::wPathBasic - path::remote:=git+https:///github.com/Wandalen/wPathBasic.git/
   |     +-- module::wTools - path::remote:=npm:///wTools
   |     +-- module::wFiles - path::remote:=npm:///wFiles
   |     +-- module::wTesting - path::remote:=npm:///wTesting
   +-- module::b
   | +-- module::wPathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
   | | +-- module::wTools - path::remote:=npm:///wTools
   | | +-- module::wPathBasic - path::remote:=npm:///wpathbasic
   | | +-- module::wArraySorted - path::remote:=npm:///warraysorted
   | | +-- module::wPathTools
   | | +-- module::wFiles - path::remote:=npm:///wFiles
   | | +-- module::wTesting - path::remote:=npm:///wTesting
   | +-- module::Proto - path::remote:=git+https:///github.com/Wandalen/wProto.git/
   +-- module::c
   | +-- module::a0
   | | +-- module::wPathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
   | | | +-- module::wTools - path::remote:=npm:///wTools
   | | | +-- module::wPathBasic - path::remote:=npm:///wpathbasic
   | | | +-- module::wArraySorted - path::remote:=npm:///warraysorted
   | | | +-- module::wPathTools
   | | | +-- module::wFiles - path::remote:=npm:///wFiles
   | | | +-- module::wTesting - path::remote:=npm:///wTesting
   | | +-- module::wPathBasic - path::remote:=git+https:///github.com/Wandalen/wPathBasic.git/
   | |   +-- module::wTools - path::remote:=npm:///wTools
   | |   +-- module::wFiles - path::remote:=npm:///wFiles
   | |   +-- module::wTesting - path::remote:=npm:///wTesting
   | +-- module::UriBasic - path::remote:=git+https:///github.com/Wandalen/wUriBasic.git/out/wUriBasic.out
   +-- module::wPathTools - path::remote:=git+https:///github.com/Wandalen/wPathTools.git/
     +-- module::wTools - path::remote:=npm:///wTools
     +-- module::wPathBasic - path::remote:=npm:///wpathbasic
     +-- module::wArraySorted - path::remote:=npm:///warraysorted
     +-- module::wPathTools
     +-- module::wFiles - path::remote:=npm:///wFiles
     +-- module::wTesting - path::remote:=npm:///wTesting
`

    test.identical( _.strCount( got.output, exp ), 1 );
    test.identical( _.strCount( got.output, '+-- module::' ), 58 );
    test.identical( _.strCount( got.output, '+-- module::z' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::a' ), 3 );
    test.identical( _.strCount( got.output, '+-- module::a0' ), 2 );
    test.identical( _.strCount( got.output, '+-- module::b' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::c' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::wTools' ), 9 );
    test.identical( _.strCount( got.output, '+-- module::wPathTools' ), 10 );
    test.identical( _.strCount( got.output, '+-- module::wPathBasic' ), 7 );
    test.identical( _.strCount( got.output, '+-- module::wUriBasic' ), 0 ); /* xxx */
    test.identical( _.strCount( got.output, '+-- module::wProto' ), 0 );
    test.identical( _.strCount( got.output, '+-- module::Tools' ), 0 );
    test.identical( _.strCount( got.output, '+-- module::PathTools' ), 0 );
    test.identical( _.strCount( got.output, '+-- module::PathBasic' ), 0 );
    test.identical( _.strCount( got.output, '+-- module::UriBasic' ), 1 );
    test.identical( _.strCount( got.output, '+-- module::Proto' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function modulesTreeHierarchyRemotePartiallyDownloaded */

modulesTreeHierarchyRemotePartiallyDownloaded.timeOut = 300000;

//

function modulesTreeDisabledAndCorrupted( test )
{
  let self = this;
  let a = self.assetFor( test, 'many-few' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.submodules.download' })
  a.start({ execPath : '.with ** .modules.tree withRemotePath:1' })

  .then( ( got ) =>
  {
    test.case = '.with * .modules.tree withRemotePath:1';
    test.identical( got.exitCode, 0 );

    let exp =

`
 +-- module::many
 | +-- module::wModuleForTesting1 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1.git@gamma
 | | +-- module::Testing - path::remote:=npm:///wTesting
 | +-- module::wModuleForTesting2 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting2.git@gamma
 | | +-- module::wModuleForTesting1 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1.git@gamma
 | | | +-- module::Testing - path::remote:=npm:///wTesting
 | | +-- module::Testing - path::remote:=npm:///wTesting
 | +-- module::wModuleForTesting12 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting12.git@gamma
 |   +-- module::wModuleForTesting1 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting1.git@gamma
 |   +-- module::wModuleForTesting2 - path::remote:=git+https:///github.com/Wandalen/wModuleForTesting2.git@gamma
 |   +-- module::Testing - path::remote:=npm:///wTesting
 |
 +-- module::corrupted
`

    test.identical( _.strStripCount( got.output, exp ), 1 );
    test.identical( _.strCount( got.output, '+-- module::' ), 12 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function modulesTreeDisabledAndCorrupted */

modulesTreeDisabledAndCorrupted.timeOut = 300000;

//

function help( test )
{
  let self = this;
  let a = self.assetFor( test, 'single' ); /* Dmytro : uses real asset to prevent exception */
  // let a = self.assetFor( test, '' );
  /* Dmytro : not needs currentPath in starter */
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    throwingExitCode : 0,
  })

  /* */

  a.ready
  .then( ( got ) =>
  {
    test.case = 'simple run without args'
    return null;
  })

  a.start( '' )

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 1 );
    test.is( got.output.length >= 1 );
    test.identical( _.strCount( got.output, /.*.help.* - Get help/ ), 1 );
    return null;
  })

  /* */

  a.ready
  .then( ( got ) =>
  {
    test.case = 'simple run without args'
    return null;
  })

  a.start( '.' )

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 1 );
    test.is( got.output.length >= 1 );
    test.identical( _.strCount( got.output, /.*.help.* - Get help/ ), 1 );
    return null;
  })

  /* */

  a.start({ execPath : '.help' })
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.ge( _.strLinesCount( op.output ), 24 );
    return op;
  })

  /* */

  a.start({ execPath : '.' })
  .then( ( op ) =>
  {
    test.notIdentical( op.exitCode, 0 );
    test.ge( _.strLinesCount( op.output ), 24 );
    return op;
  })

  /* */

  a.start({ args : [] })
  .then( ( op ) =>
  {
    test.notIdentical( op.exitCode, 0 );
    test.ge( _.strLinesCount( op.output ), 24 );
    return op;
  })

  return a.ready;
}

//

function listSingleModule( test )
{
  let self = this;
  let a = self.assetFor( test, 'single' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.start({ execPath : '.resources.list' })
  .then( ( got ) =>
  {
    test.case = 'list';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `name : 'single'` ) );
    test.is( _.strHas( got.output, `description : 'Module for testing'` ) );
    test.is( _.strHas( got.output, `version : '0.0.1'` ) );
    return null;
  })

  /* - */

  a.start({ execPath : '.about.list' })
  .then( ( got ) =>
  {
    test.case = '.about.list'

    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, `name : 'single'` ));
    test.is( _.strHas( got.output, `description : 'Module for testing'` ));
    test.is( _.strHas( got.output, `version : '0.0.1'` ));
    test.is( _.strHas( got.output, `enabled : 1` ));
    test.is( _.strHas( got.output, `interpreters :` ));
    test.is( _.strHas( got.output, `'nodejs >= 8.0.0'` ));
    test.is( _.strHas( got.output, `'chrome >= 60.0.0'` ));
    test.is( _.strHas( got.output, `'firefox >= 60.0.0'` ));
    test.is( _.strHas( got.output, `'nodejs >= 8.0.0'` ));
    test.is( _.strHas( got.output, `keywords :` ));
    test.is( _.strHas( got.output, `'wModuleForTesting1'` ));

    return null;
  })

  /* - */

  a.start({ execPath : '.paths.list' })
  .then( ( got ) =>
  {
    test.case = '.paths.list';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, `proto : proto` ) );
    test.is( _.strHas( got.output, `in : .` ) );
    test.is( _.strHas( got.output, `out : out` ) );
    test.is( _.strHas( got.output, `out.debug : out/debug` ) );
    test.is( _.strHas( got.output, `out.release : out/release` ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.paths.list predefined:1' })
  .then( ( got ) =>
  {
    test.case = '.paths.list predefined:1';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, `module.willfiles :` ) );
    test.is( _.strHas( got.output, `module.peer.willfiles :` ) );
    test.is( _.strHas( got.output, `module.dir : /` ) );
    test.is( _.strHas( got.output, `module.common : /` ) );
    test.is( _.strHas( got.output, `local : /` ) );
    test.is( _.strHas( got.output, `will :` ) );
    test.is( !_.strHas( got.output, `proto : proto` ) );
    test.is( !_.strHas( got.output, `in : .` ) );
    test.is( !_.strHas( got.output, `out : out` ) );
    test.is( !_.strHas( got.output, `out.debug : out/debug` ) );
    test.is( !_.strHas( got.output, `out.release : out/release` ) );
    test.identical( _.strCount( got.output, ':' ), 12 );

    return null;
  })

  /* - */

  a.start({ execPath : '.paths.list predefined:0' })
  .then( ( got ) =>
  {
    test.case = '.paths.list predefined:0';
    test.identical( got.exitCode, 0 );

    test.is( !_.strHas( got.output, `module.willfiles :` ) );
    test.is( !_.strHas( got.output, `module.peer.willfiles :` ) );
    test.is( !_.strHas( got.output, `module.dir : .` ) );
    test.is( !_.strHas( got.output, `module.common : ./` ) );
    test.is( !_.strHas( got.output, `local : .` ) );
    test.is( !_.strHas( got.output, `will :` ) );
    test.is( _.strHas( got.output, `proto : proto` ) );
    test.is( _.strHas( got.output, `in : .` ) );
    test.is( _.strHas( got.output, `out : out` ) );
    test.is( _.strHas( got.output, `out.debug : out/debug` ) );
    test.is( _.strHas( got.output, `out.release : out/release` ) );
    test.identical( _.strCount( got.output, ':' ), 6 );

    return null;
  })

  /* - */

  a.start({ execPath : '.submodules.list' })
  .then( ( got ) =>
  {
    test.case = 'submodules list'
    test.identical( got.exitCode, 0 );
    test.is( got.output.length >= 1 );
    return null;
  })

  /* - */

  a.start({ execPath : '.reflectors.list' })
  .then( ( got ) =>
  {
    test.case = 'reflectors.list'
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'reflector::reflect.proto.' ) );
    test.is( _.strHas( got.output, `path::proto : path::out.*=1` ) );
    test.is( _.strHas( got.output, `reflector::reflect.proto.debug` ) );
    test.is( _.strHas( got.output, `path::proto : path::out.*=1` ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.steps.list' })
  .then( ( got ) =>
  {
    test.case = 'steps.list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'step::reflect.proto.' ))
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ))
    test.is( _.strHas( got.output, 'step::reflect.proto.raw' ))
    test.is( _.strHas( got.output, 'step::reflect.proto.debug.raw' ))
    test.is( _.strHas( got.output, 'step::export.proto' ))

    return null;
  })

  /* - */

  a.start({ execPath : '.builds.list' })
  .then( ( got ) =>
  {
    test.case = '.builds.list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'build::debug.raw' ));
    test.is( _.strHas( got.output, 'build::debug.compiled' ));
    test.is( _.strHas( got.output, 'build::release.raw' ));
    test.is( _.strHas( got.output, 'build::release.compiled' ));
    test.is( _.strHas( got.output, 'build::all' ));

    return null;
  })

  /* - */

  a.start({ execPath : '.exports.list' })
  .then( ( got ) =>
  {
    test.case = '.exports.list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'build::proto.export' ));
    test.is( _.strHas( got.output, 'steps : ' ));
    test.is( _.strHas( got.output, 'build::debug.raw' ));
    test.is( _.strHas( got.output, 'step::export.proto' ));

    return null;
  })

  /* - */ /* To test output by command with glob and criterion args*/

  a.start({ execPath : '.resources.list *a* predefined:0' })
  .then( ( got ) =>
  {
    test.case = 'resources list globs negative';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'path::out.release' ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.raw' ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug.raw' ) );
    test.is( _.strHas( got.output, 'build::debug.raw' ) );
    test.is( _.strHas( got.output, 'build::release.raw' ) );
    test.is( _.strHas( got.output, 'build::release.compiled' ) );
    test.is( _.strHas( got.output, 'build::all' ) );
    test.identical( _.strCount( got.output, '::' ), 21 );

    return null;
  })

  a.start({ execPath : '.resources.list *p* debug:1' })
  .then( ( got ) =>
  {
    test.case = 'resources list globs negative';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflector::predefined.debug.v1'  ) );
    test.is( !_.strHas( got.output, 'reflector::predefined.debug.v2'  ) );
    test.is( _.strHas( got.output, 'reflector::reflect.proto.debug' ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug.raw' ) );
    test.is( _.strHas( got.output, 'step::export.proto' ) );
    test.is( _.strHas( got.output, 'build::debug.compiled' ) );
    test.is( _.strHas( got.output, 'build::proto.export' ) );
    test.identical( _.strCount( got.output, '::' ), 22 );

    return null;
  })

  /* Glob using positive test */
  a.start({ execPath : '.resources.list *proto*' })
  .then( ( got ) =>
  {
    test.case = '.resources.list *proto*';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'reflector::reflect.proto.'  ) );

    test.is( _.strHas( got.output, 'step::reflect.proto.'  ) );
    test.is( _.strHas( got.output, `files.reflect` ) );

    test.is( _.strHas( got.output, 'build::proto.export'  ) );
    test.is( _.strHas( got.output, `step::export.proto` ) );

    return null;
  })

  /* Glob and criterion using negative test */
  a.start({ execPath : '.resources.list *proto* debug:0' })
  .then( ( got ) =>
  {
    test.case = 'globs and criterions negative';
    test.identical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, `out.debug : './out/debug'` ) );
    test.is( !_.strHas( got.output, `reflector::reflect.proto.debug` ) );
    test.is( !_.strHas( got.output, 'step::reflect.proto.debug'  ) );
    test.is( !_.strHas( got.output, 'build::debug.raw'  ) );

    return null;
  })

  /* Glob and criterion using positive test */
  a.start({ execPath : '.resources.list *proto* debug:0 predefined:0' })
  .then( ( got ) =>
  {
    test.case = 'globs and criterions positive';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'path::proto'  ) );

    test.is( _.strHas( got.output, 'reflector::reflect.proto.'  ) );

    test.is( _.strHas( got.output, 'step::reflect.proto.'  ) );
    test.is( _.strHas( got.output, `files.reflect` ) );

    test.identical( _.strCount( got.output, '::' ), 12 );

    return null;
  })

  /* Glob and two criterions using negative test */
  a.start({ execPath : '.resources.list * debug:1 raw:0 predefined:0' })
  .then( ( got ) =>
  {
    test.case = '.resources.list * debug:1 raw:0 predefined:0';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, `path::out.debug` ) );
    test.is( _.strHas( got.output, `reflector::reflect.proto.debug` ) );
    test.is( _.strHas( got.output, `step::reflect.proto.debug` ) );
    test.is( _.strHas( got.output, `step::export.proto` ) );
    test.is( _.strHas( got.output, `build::debug.compiled` ) );
    test.is( _.strHas( got.output, `build::proto.export` ) );
    test.identical( _.strCount( got.output, '::' ), 20 );

    return null;
  })

  /* Glob and two criterion using positive test */
  a.start({ execPath : '.resources.list * debug:0 raw:1' })
  .then( ( got ) =>
  {
    test.case = '.resources.list * debug:0 raw:1';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'step::reflect.proto.raw'  ) );
    test.is( _.strHas( got.output, 'build::release.raw'  ) );
    test.identical( _.strCount( got.output, '::' ), 7 );

    return null;
  })

  return a.ready;
}

//

function listWithSubmodulesSimple( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules' );
  a.reflect();

  a.start({ execPath : '.resources.list' })

  .then( ( got ) =>
  {
    test.case = '.resources.list';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `name : 'submodules'` ) );
    test.is( _.strHas( got.output, `description : 'Module for testing'` ) );
    test.is( _.strHas( got.output, `version : '0.0.1'` ) );
    return null;
  })

  return a.ready;
}

//

function listWithSubmodules( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules' );
  a.reflect();

  /* - */

  a.start({ execPath : '.submodules.list' })

  .then( ( got ) =>
  {
    test.case = '.submodules.list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'relation::ModuleForTesting1' ) );
    test.is( _.strHas( got.output, 'relation::ModuleForTesting2a' ) );
    return null;
  })

  /* - */

  a.start({ execPath : '.reflectors.list' })

  .then( ( got ) =>
  {
    test.case = 'reflectors.list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflector::reflect.proto.' ))
    test.is( _.strHas( got.output, `reflector::reflect.proto.debug` ))
    return null;
  })

  /* - */

  a.start({ execPath : '.steps.list' })

  .then( ( got ) =>
  {
    test.case = 'steps.list'
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'step::delete.out.debug' ))
    test.is( _.strHas( got.output, 'step::reflect.proto.' ))
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ))
    test.is( _.strHas( got.output, 'step::reflect.submodules' ))
    test.is( _.strHas( got.output, 'step::export.proto' ))

    return null;
  })

  /* - */

  a.start({ execPath : '.builds.list' })

  .then( ( got ) =>
  {
    test.case = '.builds.list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'build::debug.raw' ));
    test.is( _.strHas( got.output, 'build::debug.compiled' ));
    test.is( _.strHas( got.output, 'build::release.raw' ));
    test.is( _.strHas( got.output, 'build::release.compiled' ));

    return null;
  })

  /* - */

  a.start({ execPath : '.exports.list' })

  .then( ( got ) =>
  {
    test.case = '.exports.list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'build::proto.export' ));
    test.is( _.strHas( got.output, 'steps : ' ));
    test.is( _.strHas( got.output, 'build::debug.raw' ));
    test.is( _.strHas( got.output, 'step::export.proto' ));

    return null;
  })

  /* - */

  a.start({ execPath : '.about.list' })

  .then( ( got ) =>
  {
    test.case = '.about.list'

    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, `name : 'submodules'` ));
    test.is( _.strHas( got.output, `description : 'Module for testing'` ));
    test.is( _.strHas( got.output, `version : '0.0.1'` ));
    test.is( _.strHas( got.output, `enabled : 1` ));
    test.is( _.strHas( got.output, `interpreters :` ));
    test.is( _.strHas( got.output, `'nodejs >= 8.0.0'` ));
    test.is( _.strHas( got.output, `'chrome >= 60.0.0'` ));
    test.is( _.strHas( got.output, `'firefox >= 60.0.0'` ));
    test.is( _.strHas( got.output, `'nodejs >= 8.0.0'` ));
    test.is( _.strHas( got.output, `keywords :` ));
    test.is( _.strHas( got.output, `'wModuleForTesting1'` ));

    return null;
  })

  return a.ready;
} /* end of function listWithSubmodules */

//

function listSteps( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.ready

  a.start({ execPath : '.steps.list' })
  .finally( ( err, got ) =>
  {
    test.case = '.steps.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )

    test.is( _.strHas( got.output, 'step::delete.out.debug' ) );
    test.is( _.strHas( got.output, /step::reflect\.proto\.[^d]/ ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ) );
    test.is( _.strHas( got.output, 'step::reflect.submodules' ) );
    test.is( _.strHas( got.output, 'step::export.proto' ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.steps.list *' })
  .finally( ( err, got ) =>
  {
    test.case = '.steps.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 )
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );

    test.is( _.strHas( got.output, 'step::delete.out.debug' ) );
    test.is( _.strHas( got.output, /step::reflect\.proto\.[^d]/ ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ) );
    test.is( _.strHas( got.output, 'step::reflect.submodules' ) );
    test.is( _.strHas( got.output, 'step::export.proto' ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.steps.list *proto*' })
  .finally( ( err, got ) =>
  {
    test.case = '.steps.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 )
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );

    test.is( !_.strHas( got.output, 'step::delete.out.debug' ) );
    test.is( _.strHas( got.output, /step::reflect\.proto\.[^d]/ ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ) );
    test.is( !_.strHas( got.output, 'step::reflect.submodules' ) );
    test.is( _.strHas( got.output, 'step::export.proto' ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.steps.list *proto* debug:1' })
  .finally( ( err, got ) =>
  {
    test.case = '.steps.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 )
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );

    test.is( !_.strHas( got.output, 'step::delete.out.debug' ) );
    test.is( !_.strHas( got.output, /step::reflect\.proto\.[^d]/ ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ) );
    test.is( !_.strHas( got.output, 'step::reflect.submodules' ) );
    test.is( _.strHas( got.output, 'step::export.proto' ) );

    return null;
  })

  /* - */

  return a.ready;
}

// --
// clean
// --

function clean( test )
{
  let self = this;
  let a = self.assetFor( test, 'clean' );
  let submodulesPath = a.abs( '.module' );
  a.reflect();

  /* - */

  a.start({ args : [ '.with NoTemp .build' ] });

  var files;
  a.ready
  .then( () =>
  {
    files = self.findAll( submodulesPath );
    test.gt( files.length, 20 );
    return files;
  })

  a.start({ execPath : '.with NoTemp .clean' })
  .then( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted ' + files.length + ' file(s)' ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) ); /* phantom problem ? */
    return null;
  })

  a.start({ execPath : '.with NoTemp .clean' })
  .then( ( got ) =>
  {
    test.case = '.with NoTemp .clean -- second';
    test.identical( got.exitCode, 0 );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) );
    return null;
  })

  /* - */

  var files = [];
  a.ready
  .then( () =>
  {
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    a.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  a.start({ execPath : '.with NoBuild .clean' })
  .then( ( got ) =>
  {
    test.case = '.with NoBuild .clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted ' + 0 + ' file(s)' ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) );
    return null;
  })

  /* - */

  var files = [];
  a.ready
  .then( () =>
  {
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    a.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  a.start({ execPath : '.with Build .build' })
  a.start({ execPath : '.with Vector .clean' })
  .then( ( got ) =>
  {
    test.case = '.with NoBuild .clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '- Clean deleted 2 file(s)' ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'out' ) ) );
    return null;
  })

  /* - */

  return a.ready;
}

clean.timeOut = 300000;

//

function cleanSingleModule( test )
{
  let self = this;
  let a = self.assetFor( test, 'single' );
  a.reflect();

  /* - */

  a.start({ execPath : [ '.build', '.clean' ] })

  .then( ( got ) =>
  {
    test.case = '.clean '
    test.identical( got[ 0 ].exitCode, 0 );
    test.identical( got[ 1 ].exitCode, 0 );
    test.is( _.strHas( got[ 1 ].output, 'Clean deleted 0 file(s)' ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) )
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) )
    return null;
  })

  /* - */

  a.start({ execPath : [ '.build', '.clean dry:1' ] })

  .then( ( got ) =>
  {
    test.case = '.clean dry:1'
    test.identical( got[ 0 ].exitCode, 0 );
    test.identical( got[ 1 ].exitCode, 0 );
    test.is( _.strHas( got[ 1 ].output, 'Clean will delete 0 file(s)' ) );
    return null;
  })

  /* - */

  return a.ready;
}

//

function cleanBroken1( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-broken-1' );
  a.reflect();

  test.description = 'should handle currputed willfile properly';

  /* - */

  a.ready

  .then( ( got ) =>
  {
    test.case = '.clean ';
    var files = self.find( a.abs( '.module' ) );
    test.identical( files.length, 4 );

    return null;
  })

  /* - */

  a.start({ execPath : '.clean dry:1' })

  .then( ( got ) =>
  {
    test.case = '.clean dry:1';

    var files = self.find( a.abs( '.module' ) );
    test.identical( files.length, 4 );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, String( files.length ) + ' at ' ) );
    test.is( _.strHas( got.output, 'Clean will delete ' + String( files.length ) + ' file(s)' ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.clean' })

  .then( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted' ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) ); /* filesDelete issue? */
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) );
    return null;
  })

  /* */

  a.start({ execPath : '.export' })
  .then( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

    var files = self.find( a.abs( 'out/debug' ) );
    test.gt( files.length, 9 );

    var files = a.fileProvider.dirRead( a.abs( 'out' ) );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    a.reflect();
    return null;
  });

  /* */

  a.start({ execPath : '.export' })
  .then( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

    var files = self.find( a.abs( 'out/debug' ) );
    test.gt( files.length, 9 );

    var files = a.fileProvider.dirRead( a.abs( 'out' ) );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  return a.ready;
}

//

function cleanBroken2( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-broken-2' );
  a.reflect();

  test.description = 'should handle currputed willfile properly';

  /* - */

  a.ready

  .then( ( got ) =>
  {
    test.case = '.clean ';
    var files = self.find( a.abs( '.module' ) );
    test.identical( files.length, 4 );

    return null;
  })

  /* - */

  a.start({ execPath : '.clean dry:1' })

  .then( ( got ) =>
  {
    test.case = '.clean dry:1';

    var files = self.find( a.abs( '.module' ) );
    test.identical( files.length, 4 );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, String( files.length ) ) );
    test.is( a.fileProvider.fileExists( a.abs( '.module' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.clean' })

  .then( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted' ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) ); /* filesDelete issue? */
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) );
    return null;
  })

  /* */

  a.start({ execPath : '.export' })
  .then( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

    var files = self.find( a.abs( 'out/debug' ) );
    test.gt( files.length, 9 );

    var files = a.fileProvider.dirRead( a.abs( 'out' ) );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    a.reflect();
    return null;
  });

  /* */

  a.start({ execPath : '.export', throwingExitCode : 0 })
  .then( ( got ) =>
  {
    test.case = '.export';

    test.will = 'update should throw error if submodule is not downloaded but download path exists';

    test.notIdentical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );
    test.is( _.strHas( got.output, `Module module::submodules / opener::ModuleForTesting2 is downloaded, but it's not a git repository` ) );

    // var files = self.find( a.abs( 'out/debug' ) );
    // test.gt( files.length, 9 );

    // var files = a.fileProvider.dirRead( a.abs( 'out' ) );
    // test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    var files = self.find( a.abs( 'out/debug' ) );
    test.identical( files.length, 0 );

    var files = a.fileProvider.dirRead( a.abs( 'out' ) );
    test.identical( files, null );

    return null;
  })

  /* */

  a.ready
  .then( ( got ) =>
  {
    a.reflect();
    return null;
  });

  a.start({ execPath : '.submodules.versions.agree' })
  a.start({ execPath : '.export', throwingExitCode : 0 })
  .then( ( got ) =>
  {
    test.case = '.export agree1';
    test.will = 'update should not throw error because submodule was updated by agree';

    test.identical( got.exitCode, 0 );

    /* agree/update/download should not count as update of module if no change was done */
    test.identical( _.strCount( got.output, 'was updated' ), 0 );
    test.identical( _.strCount( got.output, 'to version' ), 0 );
    test.is( !_.strHas( got.output, /Module module::submodules \/ opener::ModuleForTesting2 is not downloaded, but file at .*/ ) );
    test.is( _.strHas( got.output, '+ 0/1 submodule(s) of module::submodules were updated' ) );
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

    var files = self.find( a.abs( 'out/debug' ) );
    test.gt( files.length, 9 );

    var files = a.fileProvider.dirRead( a.abs( 'out' ) );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  return a.ready;
}

//

function cleanBrokenSubmodules( test )
{
  let self = this;
  let a = self.assetFor( test, 'clean-broken-submodules' );

  /* - */

  a.ready

  .then( ( got ) =>
  {
    test.case = 'setup';
    a.reflect();
    var files = self.find( a.abs( '.module' ) );
    test.identical( files.length, 4 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files.length, 2 );

    return null;
  })

  /* - */

  a.start({ execPath : '.clean dry:1' })
  .then( ( got ) =>
  {
    test.case = '.clean dry:1';

    var files = self.find( a.abs( '.module' ) );
    test.identical( files.length, 4 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files.length, 2 );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '/.module' ) );
    test.is( _.strHas( got.output, '/out' ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.clean' })
  .then( ( got ) =>
  {
    test.case = '.clean';

    var files = self.find( a.abs( '.module' ) );
    test.identical( files.length, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files.length, 0 );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '6 file(s)' ) );

    return null;
  })

  /* - */

  return a.ready;
}

//

function cleanHdBug( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-hd-bug' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with z .clean recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with z .clean recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ '.', './z.will.yml', './group1', './group1/a.will.yml', './group1/group10', './group1/group10/a0.will.yml' ];
    var files = self.find( a.abs( '.' ) );
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Opened' ), 3 );
    test.identical( _.strCount( got.output, 'Clean deleted' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function cleanHdBug */

//

function cleanNoBuild( test )
{
  let self = this;
  let a = self.assetFor( test, 'clean' );
  a.reflect();

  /* - */

  a.startNonThrowing({ execPath : '.with NoBuild .clean' })
  .then( ( got ) =>
  {
    test.case = '.clean -- second';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted ' + 0 + ' file(s)' ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) ); /* phantom problem ? */
    return null;
  })

  a.startNonThrowing({ execPath : '.with NoBuild .clean' })
  .then( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) );
    return null;
  })

  /* - */

  a.startNonThrowing({ execPath : '.with NoBuild .clean -- badarg' })
  .then( ( got ) =>
  {
    test.case = '.clean -- badarg';
    test.notIdentical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, 'Clean deleted' ) );
    return null;
  })

  /* - */

  return a.ready;
}

//

function cleanDry( test )
{
  let self = this;
  let a = self.assetFor( test, 'clean' );
  a.reflect();

  /* - */

  a.start({ args : [ '.with NoTemp .submodules.update' ] })

  .then( ( got ) =>
  {
    test.is( _.strHas( got.output, '+ 2/2 submodule(s) of module::submodules were updated' ) );
    var files = self.find( a.abs( '.module' ) );
    test.gt( files.length, 50 );
    return null;
  })

  a.start({ args : [ '.with NoTemp .build' ] })
  .then( ( got ) =>
  {
    test.is( _.strHas( got.output, '+ 0/2 submodule(s) of module::submodules were downloaded in' ) );
    return got;
  })

  var wasFiles;

  a.start({ execPath : '.with NoTemp .clean dry:1' })

  .then( ( got ) =>
  {
    test.case = '.clean dry:1';

    var files = self.findAll( a.abs( 'out' ) );
    test.gt( files.length, 15 );
    var files = wasFiles = self.findAll( a.abs( '.module' ) );
    test.gt( files.length, 50 );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, String( files.length ) + ' at ' ) );
    test.is( _.strHas( got.output, 'Clean will delete ' + String( files.length ) + ' file(s)' ) );
    test.is( a.fileProvider.isDir( a.abs( '.module' ) ) ); /* phantom problem ? */
    test.is( a.fileProvider.isDir( a.abs( 'out' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) );

    return null;
  })

  /* - */

  return a.ready;
}

cleanDry.timeOut = 300000;

//

function cleanSubmodules( test )
{
  let self = this;
  let a = self.assetFor( test, 'clean' );
  a.reflect();

  /* */

  a.start({ execPath : '.with NoTemp .submodules.update' })
  .then( ( got ) =>
  {
    test.case = '.submodules.update'
    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( a.path.join( a.abs( '.module' ), 'ModuleForTesting1' ) ) )
    test.is( a.fileProvider.fileExists( a.path.join( a.abs( '.module' ), 'ModuleForTesting2' ) ) )
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) )

    var files = self.find( a.path.join( a.abs( '.module' ), 'ModuleForTesting1' ) );
    test.is( files.length >= 1 );

    var files = self.find( a.path.join( a.abs( '.module' ), 'ModuleForTesting2' ) );
    test.is( files.length >= 1 );

    return null;
  })

  /* */

  var files;
  a.ready
  .then( () =>
  {
    files = self.findAll( a.abs( '.module' ) );
    return null;
  })

  /* */

  a.start({ execPath : '.with NoTemp .submodules.clean' })
  .then( ( got ) =>
  {
    test.case = '.submodules.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `${files.length}` ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) ); /* phantom problem ? */
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) );
    return null;
  })

  /* - */

  return a.ready;
}

cleanSubmodules.timeOut = 300000;

//

function cleanMixed( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-mixed' );
  a.reflect();

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.clean';
    return null;
  })

  a.start({ execPath : '.build' })
  a.start({ execPath : '.clean' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '- Clean deleted' ) ); debugger;

    test.is( !a.fileProvider.fileExists( a.abs( 'out' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) );

    var expected = [ '.', './ModuleForTesting12.informal.will.yml', './ModuleForTesting12ab.informal.will.yml' ];
    var files = self.find( a.abs( 'module' ) );
    test.identical( files, expected );

    return null;
  })

  /* - */

  return a.ready;
}

//

function cleanWithInPath( test )
{
  let self = this;
  let a = self.assetFor( test, 'clean-with-inpath' );

  /* - */

  var hadFiles;
  a.ready
  .then( ( got ) =>
  {
    test.case = '.with module/ModuleForTesting12 .clean';
    a.reflect();
    hadFiles = self.find( a.abs( 'out' ) ).length + self.find( a.abs( '.module' ) ).length;

    return null;
  })

  a.start({ execPath : '.with module/ModuleForTesting12 .clean' })
  a.ready.then( ( got ) =>
  {

    var expectedFiles =
    [
      '.',
      './module',
      './module/ModuleForTesting12.will.yml',
      './module/.module',
      './module/.module/ForGit.txt',
      './module/out',
      './module/out/ForGit.txt',
      './proto',
      './proto/WithSubmodules.s'
    ]
    var files = self.find({ filePath : { [ a.routinePath ] : '', '+**' : 0 } });
    test.identical( files, expectedFiles );

    test.identical( got.exitCode, 0 ); debugger;
    test.identical( _.strCount( got.output, '- Clean deleted ' + hadFiles + ' file(s)' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
}

//

/*
  check there is no annoying information about lack of remote submodules of submodules
*/

function cleanRecursive( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'spawn',
    ready : a.ready,
  })
  /* Dmytro : new implementation of assetFor().reflect copies _repo, it affects results */
  a.fileProvider.filesDelete( a.routinePath );
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.routinePath } });

  /* - */

  a.ready

  .then( () =>
  {
    test.case = 'export first'
    return null;
  })

  a.start( '.with ** .clean' )
  a.start( '.with group1/group10/a0 .export' )
  a.start( '.with group1/a .export' )
  a.start( '.with group1/b .export' )
  a.start( '.with group2/c .export' )
  a.start( '.with z .export' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'Failed to open' ), 1 );
    test.identical( _.strCount( got.output, '. Opened .' ), 31 );
    test.identical( _.strCount( got.output, '+ 1/4 submodule(s) of module::z were downloaded' ), 1 );
    test.identical( _.strCount( got.output, '+ 0/4 submodule(s) of module::z were downloaded' ), 1 );

    return null;
  })

  a.start( '.with z .clean recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 31 );

    var exp =
    [
      '.',
      './z.will.yml',
      './group1',
      './group1/a.will.yml',
      './group1/b.will.yml',
      './group1/group10',
      './group1/group10/a0.will.yml',
      './group2',
      './group2/c.will.yml'
    ]
    var files = self.find( a.routinePath );
    test.identical( files, exp );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function cleanRecursive */

cleanRecursive.timeOut = 500000;

//

function cleanDisabledModule( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-disabled-module' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.clean';
    a.reflect();
    return null;
  })

  a.start( '.export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var exp = [ '.module', 'out', 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );
    test.identical( _.strCount( op.output, 'Exported module::disabled / build::proto.export' ), 1 );

    return null;
  })

  a.start( '.clean' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var exp = [ 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );
    test.identical( _.strCount( op.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with . .clean';
    a.reflect();
    return null;
  })

  a.start( '.export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var exp = [ '.module', 'out', 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );
    test.identical( _.strCount( op.output, 'Exported module::disabled / build::proto.export' ), 1 );

    return null;
  })

  a.start( '.with . .clean' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var exp = [ 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );
    test.identical( _.strCount( op.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .clean';
    a.reflect();
    return null;
  })

  a.start( '.export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var exp = [ '.module', 'out', 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );
    test.identical( _.strCount( op.output, 'Exported module::disabled / build::proto.export' ), 1 );

    return null;
  })

  a.startNonThrowing( '.with * .clean' )

  .then( ( op ) =>
  {
    test.notIdentical( op.exitCode, 0 );

    var exp = [ '.module', 'out', 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );
    test.identical( _.strCount( op.output, '- Clean deleted' ), 0 );
    test.identical( _.strCount( op.output, 'No module sattisfy criteria' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withDisabled:1 ; .with * .clean';
    a.reflect();
    return null;
  })

  a.start( '.export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var exp = [ '.module', 'out', 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );
    test.identical( _.strCount( op.output, 'Exported module::disabled / build::proto.export' ), 1 );

    return null;
  })

  a.start( '.imply withDisabled:1 ; .with * .clean' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var exp = [ 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );
    test.identical( _.strCount( op.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function cleanDisabledModule */

cleanDisabledModule.timeOut = 300000;
cleanDisabledModule.description =
`
- disabled module should be cleaned if picked explicitly
- disabled module should not be cleaned if picked with glob
`

//

function cleanHierarchyRemote( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );

  /* aaa : problems with willfiles // Dmytro : fixed

about :
  name : a
  version : '0.0.0'

submodule :
  ModuleForTesting1 : git+https:///github.com/Wandalen/wModuleForTesting1.git/
  ModuleForTesting1 : git+https:///github.com/Wandalen/wModuleForTesting1.git/
  a0 : group10/a0

   */

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with z .clean';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with z .clean' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 1 );
    test.identical( _.strCount( got.output, ' at ' ), 3 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .clean';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .clean' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 1 );
    test.identical( _.strCount( got.output, ' at ' ), 3 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .clean recursive:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .clean recursive:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 7 );
    test.identical( _.strCount( got.output, ' at ' ), 9 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .clean recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .clean recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 24 );
    test.identical( _.strCount( got.output, ' at ' ), 26 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .clean recursive:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with ** .clean recursive:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 24 );
    test.identical( _.strCount( got.output, ' at ' ), 26 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .clean recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with ** .clean recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 24 );
    test.identical( _.strCount( got.output, ' at ' ), 26 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function cleanHierarchyRemote */

cleanHierarchyRemote.timeOut = 1000000;

//

function cleanHierarchyRemoteDry( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with z .clean dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with z .clean dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 1 );
    test.identical( _.strCount( got.output, ' at ' ), 3 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .clean dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .clean dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 1 );
    test.identical( _.strCount( got.output, ' at ' ), 3 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .clean recursive:1 dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .clean recursive:1 dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 7 );
    test.identical( _.strCount( got.output, ' at ' ), 9 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .clean recursive:2 dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .clean recursive:2 dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 24 );
    test.identical( _.strCount( got.output, ' at ' ), 26 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .clean recursive:1 dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with ** .clean recursive:1 dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 24 );
    test.identical( _.strCount( got.output, ' at ' ), 26 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .clean recursive:2 dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with ** .clean recursive:2 dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 24 );
    test.identical( _.strCount( got.output, ' at ' ), 26 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function cleanHierarchyRemoteDry */

cleanHierarchyRemoteDry.timeOut = 1000000;

//

function cleanSubmodulesHierarchyRemote( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with z .submodules.clean';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with z .submodules.clean' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 1 );
    test.identical( _.strCount( got.output, ' at ' ), 3 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .submodules.clean';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .submodules.clean' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 1 );
    test.identical( _.strCount( got.output, ' at ' ), 3 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .submodules.clean recursive:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .submodules.clean recursive:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'PathBasic', 'PathTools' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 4 );
    test.identical( _.strCount( got.output, ' at ' ), 6 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .submodules.clean recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .submodules.clean recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 9 );
    test.identical( _.strCount( got.output, ' at ' ), 11 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .submodules.clean recursive:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with ** .submodules.clean recursive:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 9 );
    test.identical( _.strCount( got.output, ' at ' ), 11 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .submodules.clean recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with ** .submodules.clean recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 9 );
    test.identical( _.strCount( got.output, ' at ' ), 11 );
    test.identical( _.strCount( got.output, '- Clean deleted' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function cleanSubmodulesHierarchyRemote */

cleanSubmodulesHierarchyRemote.timeOut = 1000000;

//

function cleanSubmodulesHierarchyRemoteDry( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with z .submodules.clean dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with z .submodules.clean dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 1 );
    test.identical( _.strCount( got.output, ' at ' ), 3 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .submodules.clean dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .submodules.clean dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 1 );
    test.identical( _.strCount( got.output, ' at ' ), 3 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .submodules.clean recursive:1 dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .submodules.clean recursive:1 dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 4 );
    test.identical( _.strCount( got.output, ' at ' ), 6 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .submodules.clean recursive:2 dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with * .submodules.clean recursive:2 dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 9 );
    test.identical( _.strCount( got.output, ' at ' ), 11 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .submodules.clean recursive:1 dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with ** .submodules.clean recursive:1 dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 9 );
    test.identical( _.strCount( got.output, ' at ' ), 11 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .submodules.clean recursive:2 dry:1';
    a.reflect();
    return null;
  })

  a.start( '.with ** .submodules.download recursive:2' )
  a.start( '.with ** .submodules.clean recursive:2 dry:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '. Read 26 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, ' at .' ), 9 );
    test.identical( _.strCount( got.output, ' at ' ), 11 );
    test.identical( _.strCount( got.output, '. Clean will delete' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function cleanSubmodulesHierarchyRemoteDry */

cleanSubmodulesHierarchyRemoteDry.timeOut = 1000000;

//


function cleanSpecial( test )
{
  let self = this;
  let a = self.assetFor( test, 'clean-special' );
  a.reflect();

  var files = a.fileProvider.dirRead( a.abs( 'out' ) );
  var expected = [ '#dir2','@dir1' ];
  test.identical( files, expected )

  /* - */

  a.start({ execPath : '.clean' })
  .then( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( !a.fileProvider.fileExists( a.abs( 'out' ) ) );

    return null;
  })

  return a.ready;
}

cleanSpecial.timeOut = 300000;

//

function buildSingleModule( test )
{
  let self = this;
  let a = self.assetFor( test, 'single' );
  a.reflect();

  /* - */

  a.ready.then( () =>
  {
    test.case = '.build'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    return null;
  })

  a.start({ execPath : '.build' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .*module::single \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, 'reflected 2 file(s)' ) );
    test.is( _.strHas( got.output, /Built .*module::single \/ build::debug\.raw.* in/ ) );

    var files = self.find( a.abs( 'out/debug' ) );
    test.identical( files, [ '.', './Single.s' ] );

    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = '.build debug.raw'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    return null;
  })

  a.start({ execPath : '.build debug.raw' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .*module::single \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, 'reflected 2 file(s)' ) );
    test.is( _.strHas( got.output, /Built .*module::single \/ build::debug\.raw.* in/ ) );

    var files = self.find( a.abs( 'out/debug' ) );
    test.identical( files, [ '.', './Single.s' ] );

    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = '.build release.raw'
    a.fileProvider.filesDelete( a.abs( 'out/release' ) );
    return null;
  })

  a.start({ execPath : '.build release.raw' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .*module::single \/ build::release\.raw.*/ ) );
    test.is( _.strHas( got.output, 'reflected 2 file(s)' ) );
    test.is( _.strHas( got.output, /Built .*module::single \/ build::release\.raw.* in/ ) );

    var files = self.find( a.abs( 'out/debug' ) );
    test.identical( files, [ '.', './Single.s' ] );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build wrong'
    let buildOutDebugPath = a.abs( 'out/debug' );
    let buildOutReleasePath = a.abs( 'out/release' );
    a.fileProvider.filesDelete( buildOutDebugPath );
    a.fileProvider.filesDelete( buildOutReleasePath );
    var o =
    {
      args : [ '.build wrong' ],
      ready : null,
    }
    return test.shouldThrowErrorOfAnyKind( () => a.start( o ) )
    .then( ( got ) =>
    {
      test.is( o.exitCode !== 0 );
      test.is( o.output.length >= 1 );
      test.is( !a.fileProvider.fileExists( buildOutDebugPath ) )
      test.is( !a.fileProvider.fileExists( buildOutReleasePath ) )

      return null;
    })
  })

  /* - */

  return a.ready;
}

//

function buildSingleStep( test )
{
  let self = this;
  let a = self.assetFor( test, 'step-shell' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.build debug1'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build debug1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.build debug2'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build debug2' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    return null;
  })

  /* - */

  return a.ready;
}

//

function buildSubmodules( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = 'build withoud submodules'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build' })
  .finally( ( err, got ) =>
  {
    test.is( !err );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 )
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    var files = self.find( a.abs( 'out' ) );
    test.gt( files.length, 10 );
    return null;
  })

  /* - */

  a.start({ execPath : '.submodules.update' })
  .then( () =>
  {
    test.case = '.build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    var files = self.find( a.abs( 'out' ) );
    test.gt( files.length, 15 );

    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = '.build wrong'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  .then( () =>
  {

    var o =
    {
      execPath : 'node ' + self.willPath,
      currentPath : a.routinePath,
      outputCollecting : 1,
      outputGraying : 1,
      args : [ '.build wrong' ]
    }

    return test.shouldThrowErrorOfAnyKind( _.process.start( o ) )
    .then( ( got ) =>
    {
      test.is( o.exitCode !== 0 );
      test.is( o.output.length >= 1 );
      test.is( !a.fileProvider.fileExists( a.abs( 'out' ) ) );
      test.is( !a.fileProvider.fileExists( a.abs( 'out/debug' ) ) );
      test.is( !a.fileProvider.fileExists( a.abs( 'out/release' ) ) );

      return null;
    })

  });

  return a.ready;
}

buildSubmodules.timeOut = 300000;

//

function buildOptionWithSubmodules( test )
{
  let self = this;
  let a = self.assetFor( test, 'buildOptionWithSubmodules' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with withSubmodulesDef .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.with withSubmodulesDef .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 4 );
    test.identical( _.strCount( got.output, '/withSubmodulesDef.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with withSubmodules2 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.with withSubmodules2 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 4 );
    test.identical( _.strCount( got.output, '/withSubmodules2.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with withSubmodules1 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.with withSubmodules1 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 2 );
    test.identical( _.strCount( got.output, '/withSubmodules1.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 0 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with withSubmodules0 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.with withSubmodules0 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 1 );
    test.identical( _.strCount( got.output, '/withSubmodules0.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 0 );

    return null;
  })

  /* - */

  return a.ready;
}

buildOptionWithSubmodules.timeOut = 300000;

//

function buildOptionWithSubmodulesExplicitRunOption( test )
{
  let self = this;
  let a = self.assetFor( test, 'buildOptionWithSubmodules' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:0 ; .with withSubmodulesDef .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:0 ; .with withSubmodulesDef .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 1 );
    test.identical( _.strCount( got.output, '/withSubmodulesDef.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 0 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:0 ; .with withSubmodules2 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:0 ; .with withSubmodules2 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 1 );
    test.identical( _.strCount( got.output, '/withSubmodules2.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 0 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:0 ; .with withSubmodules1 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:0 ; .with withSubmodules1 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 1 );
    test.identical( _.strCount( got.output, '/withSubmodules1.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 0 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:0 ; .with withSubmodules0 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:0 ; .with withSubmodules0 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 1 );
    test.identical( _.strCount( got.output, '/withSubmodules0.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 0 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:1 ; .with withSubmodulesDef .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:1 ; .with withSubmodulesDef .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 2 );
    test.identical( _.strCount( got.output, '/withSubmodulesDef.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 0 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:1 ; .with withSubmodules2 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:1 ; .with withSubmodules2 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 2 );
    test.identical( _.strCount( got.output, '/withSubmodules2.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 0 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:1 ; .with withSubmodules1 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:1 ; .with withSubmodules1 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 2 );
    test.identical( _.strCount( got.output, '/withSubmodules1.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 0 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:1 ; .with withSubmodules0 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:1 ; .with withSubmodules0 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 2 );
    test.identical( _.strCount( got.output, '/withSubmodules0.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 0 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 0 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:2 ; .with withSubmodulesDef .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:2 ; .with withSubmodulesDef .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 4 );
    test.identical( _.strCount( got.output, '/withSubmodulesDef.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:2 ; .with withSubmodules2 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:2 ; .with withSubmodules2 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 4 );
    test.identical( _.strCount( got.output, '/withSubmodules2.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:2 ; .with withSubmodules1 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:2 ; .with withSubmodules1 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 4 );
    test.identical( _.strCount( got.output, '/withSubmodules1.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withSubmodules:2 ; .with withSubmodules0 .build'
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.imply withSubmodules:2 ; .with withSubmodules0 .build' })
  .finally( ( err, got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'echo1' ), 1 );

    test.identical( _.strCount( got.output, '. Opened .' ), 4 );
    test.identical( _.strCount( got.output, '/withSubmodules0.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l3.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l2.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '/l1.will.yml' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
}

buildOptionWithSubmodulesExplicitRunOption.timeOut = 300000;

//

function buildDetached( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-detached' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, /\+ .*module::wModuleForTesting1.* was downloaded version .*master.* in/ ) );
    test.is( _.strHas( got.output, /\+ .*module::wPathBasic.* was downloaded version .*622fb3c259013f3f6e2aeec73642645b3ce81dbc.* in/ ) );
    test.is( _.strHas( got.output, /\.module\/ModuleForTesting2a\.informal <- npm:\/\/wprocedure/ ) );
    test.is( _.strHas( got.output, /\.module\/ModuleForTesting12\.informal <- git\+https:\/\/github\.com\/Wandalen\/wModuleForTesting12\.git#13d24b7b6527a1ad83715b12b7bb6f5df5313e90/ ) );
    test.is( _.strHas( got.output, /\.module\/ModuleForTesting12ab\.informal <- git\+https:\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git/ ) );

    var files = _.fileProvider.dirRead( a.path.join( a.routinePath, '.module' ) );
    test.identical( files, [ 'ModuleForTesting1', 'ModuleForTesting12.informal', 'ModuleForTesting12ab.informal', 'ModuleForTesting2a.informal', 'ModuleForTesting2b' ] );

    var files = _.fileProvider.dirRead( a.path.join( a.routinePath, 'out' ) );
    test.identical( files, [ 'debug', 'ModuleForTesting12.informal.out.will.yml', 'ModuleForTesting12ab.informal.out.will.yml', 'ModuleForTesting2a.informal.out.will.yml' ] );

    return null;
  })

  /* - */

  return a.ready;
}

buildDetached.timeOut = 300000;

//

function exportSingle( test )
{
  let self = this;
  let a = self.assetFor( test, 'single' );
  // let outPath = a.abs( 'out' ); [> aaa : ? */ /* Dmytro : use `a.abs` <]
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'out/debug' ) );

  /* - */

  a.ready.then( () =>
  {
    test.case = '.export'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflected 2 file(s)' ) );
    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, 'Exported module::single / build::proto.export with 2 file(s) in') );

    var files = self.find( a.abs( 'out/debug' ) );
    test.identical( files, [ '.', './Single.s' ] );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './single.out.will.yml', './debug', './debug/Single.s' ] );

    test.is( a.fileProvider.fileExists( a.abs( 'out/single.out.will.yml' ) ) )
    var outfile = a.fileProvider.configRead( a.abs( 'out/single.out.will.yml' ) );
    outfile = outfile.module[ outfile.root[ 0 ] ];

    let reflector = outfile.reflector[ 'exported.files.proto.export' ];
    test.identical( reflector.src.basePath, '.' );
    test.identical( reflector.src.prefixPath, 'path::exported.dir.proto.export' );
    test.identical( reflector.src.filePath, { 'path::exported.files.proto.export' : '' } );

    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = '.export.proto'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.export proto.export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exported .*module::single \/ build::proto.export.* in/ ) );
    test.is( _.strHas( got.output, 'reflected 2 file(s)' ) );
    test.is( _.strHas( got.output, 'Exported module::single / build::proto.export with 2 file(s) in' ) );

    var files = self.find( a.abs( 'out/debug' ) );
    test.identical( files, [ '.', './Single.s' ] );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './single.out.will.yml', './debug', './debug/Single.s'  ] );

    test.is( a.fileProvider.fileExists( a.abs( 'out/single.out.will.yml' ) ) )
    var outfile = a.fileProvider.configRead( a.abs( 'out/single.out.will.yml' ) );
    outfile = outfile.module[ outfile.root[ 0 ] ];

    let reflector = outfile.reflector[ 'exported.files.proto.export' ];
    let expectedFilePath =
    {
      '.' : '',
      'Single.s' : '',
    }
    test.identical( reflector.src.basePath, '.' );
    test.identical( reflector.src.prefixPath, 'path::exported.dir.proto.export' );
    test.identical( reflector.src.filePath, { 'path::exported.files.proto.export' : '' } );

    return null;
  })

  return a.ready;
}

//

function exportItself( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-itself' );
  a.reflect();

  /* - */

  a.ready.then( () =>
  {
    test.case = '.export';
    return null;
  })

  a.start( '.with v1 .clean' )
  a.start( '.with v1 .submodules.download' )
  a.start( '.with v1 .export' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.routinePath );
    test.gt( files.length, 50 );

    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, /Exported module::experiment \/ build::export with .* file\(s\) in/ ) );

    return null;
  })

  /* */

  return a.ready;
}

//

/*
  Submodule Submodule is deleted, so exporting should fail.
*/

function exportNonExportable( test )
{
  let self = this;
  let a = self.assetFor( test, 'two-exported' );
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'out' ) );
  a.fileProvider.filesDelete( a.abs( 'super.out' ) );

  /* - */

  a.start({ execPath : '.with super .clean' })
  a.start({ args : [ '.with super .export debug:1' ], throwingExitCode : 0 })

  .then( ( got ) =>
  {
    test.is( got.exitCode !== 0 );

    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'rror' ), 1 );
    test.identical( _.strCount( got.output, '====' ), 0 );

    test.identical( _.strCount( got.output, 'module::supermodule / relation::Submodule is not opened' ), 1 );
    test.identical( _.strCount( got.output, 'Failed module::supermodule / step::reflect.submodules.debug' ), 1 );

    // test.identical( _.strCount( got.output, /Exporting is impossible because .*module::supermodule \/ submodule::Submodule.* is broken!/ ), 1 );
    // test.identical( _.strCount( got.output, /Failed .*module::supermodule \/ step::export.*/ ), 1 );

    return null;
  })

  return a.ready;
}

//

function exportPurging( test )
{
  let self = this;
  let a = self.assetFor( test, 'exportMinimal' );
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'out' ) );
  a.fileProvider.filesDelete( a.abs( 'super.out' ) );

  /* - */

  a.start({ execPath : '.export' })
  .then( ( got ) =>
  {
    test.is( got.exitCode === 0 );

    var outfile = a.fileProvider.configRead( a.abs( './out/ExportMinimal.out.will.yml' ) );
    test.identical( outfile.module[ 'ExportMinimal.out' ].about.version, '0.0.0' );
    outfile.module[ 'ExportMinimal.out' ].about.version = '3.3.3';

    a.fileProvider.fileWrite
    ({
      filePath : a.abs( './out/ExportMinimal.out.will.yml' ),
      data : outfile,
      encoding : 'yml',
    });

    var outfile = a.fileProvider.configRead( a.abs( './out/ExportMinimal.out.will.yml' ) );
    test.identical( outfile.module[ 'ExportMinimal.out' ].about.version, '3.3.3' );

    return null;
  })

  a.start({ execPath : '.export' })
  .then( ( got ) =>
  {
    test.description = 'second .export';
    test.is( got.exitCode === 0 );

    var outfile = a.fileProvider.configRead( a.abs( './out/ExportMinimal.out.will.yml' ) );
    test.identical( outfile.module[ 'ExportMinimal.out' ].about.version, '3.3.3' );

    return null;
  })

  a.start({ execPath : '.export.purging' })
  .then( ( got ) =>
  {
    test.description = '.export.purging';
    test.is( got.exitCode === 0 );

    var outfile = a.fileProvider.configRead( a.abs( './out/ExportMinimal.out.will.yml' ) );
    test.identical( outfile.module[ 'ExportMinimal.out' ].about.version, '0.0.0' );

    return null;
  })

  /* - */

  return a.ready;
}

//

function exportStringrmal( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-mixed' );
  let outPath = a.abs( 'out' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with module/ModuleForTesting12.informal .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.with module/ModuleForTesting12.informal .export' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /Exported .*module::ModuleForTesting12.informal \/ build::export.* in/ ), 1 );

    var files = self.find( outPath );
    test.identical( files, [ '.', './ModuleForTesting12.informal.out.will.yml' ] );

    var outfile = a.fileProvider.configRead( a.path.join( outPath, './ModuleForTesting12.informal.out.will.yml' ) );
    outfile = outfile.module[ 'ModuleForTesting12.informal.out' ];
    var expected =
    {
      "module.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `ModuleForTesting12.informal.out.will.yml`
      },
      "module.common" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `ModuleForTesting12.informal.out`
      },
      "module.original.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `../module/ModuleForTesting12.informal.will.yml`
      },
      "module.peer.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `../module/ModuleForTesting12.informal.will.yml`
      },
      "in" :
      {
        "path" : `.`
      },
      "out" :
      {
        "path" : `.`
      },
      // "remote" :
      // {
      //   "criterion" : { "predefined" : 1 }
      // },
      "download" : { "path" : `../.module/ModuleForTesting12`, "criterion" : { "predefined" : 1 } },
      "export" : { "path" : `{path::download}/proto/**` },
      "exported.dir.export" :
      {
        "criterion" : { "default" : 1, "export" : 1, "generated" : 1 },
        "path" : `../.module/ModuleForTesting12/proto`
      },
      'module.peer.in' :
      {
        'criterion' : { 'predefined' : 1 },
        'path' : '..'
      },
    }
    delete outfile.path[ 'exported.files.export' ];
    test.identical( outfile.path, expected );
    test.identical( outfile.path.download.path, '../.module/ModuleForTesting12' );
    test.identical( outfile.path.remote.path, undefined );
    // test.identical( outfile.path.remote.path, 'git+https:///github.com/Wandalen/wModuleForTesting12.git' );
    // logger.log( _.toJson( outfile.path ) );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with module/ModuleForTesting12.informal .export -- second'
    return null;
  })

  a.start({ execPath : '.with module/ModuleForTesting12.informal .export' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /Exported .*module::ModuleForTesting12.informal \/ build::export.* in/ ), 1 );

    var files = self.find( outPath );
    test.identical( files, [ '.', './ModuleForTesting12.informal.out.will.yml' ] );

    var outfile = a.fileProvider.configRead( a.path.join( outPath, './ModuleForTesting12.informal.out.will.yml' ) );
    outfile = outfile.module[ 'ModuleForTesting12.informal.out' ];
    var expected =
    {
      "module.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `ModuleForTesting12.informal.out.will.yml`
      },
      "module.common" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `ModuleForTesting12.informal.out`
      },
      "module.original.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `../module/ModuleForTesting12.informal.will.yml`
      },
      "module.peer.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `../module/ModuleForTesting12.informal.will.yml`
      },
      "in" :
      {
        "path" : `.`
      },
      "out" :
      {
        "path" : `.`
      },
      // "remote" :
      // {
      //   "criterion" : { "predefined" : 1 }
      // },
      "download" : { "path" : `../.module/ModuleForTesting12`, "criterion" : { "predefined" : 1 } },
      "export" : { "path" : `{path::download}/proto/**` },
      "exported.dir.export" :
      {
        "criterion" : { "default" : 1, "export" : 1, "generated" : 1 },
        "path" : `../.module/ModuleForTesting12/proto`
      },
      'module.peer.in' :
      {
        'criterion' : { 'predefined' : 1 },
        'path' : '..'
      },
    }
    delete outfile.path[ 'exported.files.export' ];
    test.identical( outfile.path, expected );
    test.identical( outfile.path.download.path, '../.module/ModuleForTesting12' );
    test.identical( outfile.path.remote.path, undefined );
    // test.identical( outfile.path.remote.path, 'git+https:///github.com/Wandalen/wModuleForTesting12.git' );
    // logger.log( _.toJson( outfile.path ) );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.with module/ModuleForTesting12ab.informal .export'
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.with module/ModuleForTesting12ab.informal .export' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /Exported .*module::ModuleForTesting12ab.informal \/ build::export.* in/ ), 1 );

    var files = self.find( outPath );
    test.identical( files, [ '.', './ModuleForTesting12ab.informal.out.will.yml' ] );

    var outfile = a.fileProvider.configRead( a.path.join( outPath, './ModuleForTesting12ab.informal.out.will.yml' ) );
    outfile = outfile.module[ 'ModuleForTesting12ab.informal.out' ];
    var expected =
    {
      "module.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `ModuleForTesting12ab.informal.out.will.yml`
      },
      "module.common" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `ModuleForTesting12ab.informal.out`
      },
      "module.original.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `../module/ModuleForTesting12ab.informal.will.yml`
      },
      "module.peer.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `../module/ModuleForTesting12ab.informal.will.yml`
      },
      "in" :
      {
        "path" : `.`
      },
      "out" :
      {
        "path" : `.`
      },
      // "remote" :
      // {
      //   "criterion" : { "predefined" : 1 }
      // },
      "download" : { "path" : `../.module/ModuleForTesting12ab`, "criterion" : { "predefined" : 1 } },
      "export" : { "path" : `{path::download}/proto/**` },
      "exported.dir.export" :
      {
        "criterion" : { "default" : 1, "export" : 1, "generated" : 1 },
        "path" : `../.module/ModuleForTesting12ab/proto`
      },
      'module.peer.in' :
      {
        'criterion' : { 'predefined' : 1 },
        'path' : '..'
      }
    }
    delete outfile.path[ 'exported.files.export' ];
    test.identical( outfile.path, expected );
    test.identical( outfile.path.download.path, '../.module/ModuleForTesting12ab' );
    test.identical( outfile.path.remote.path, undefined );
    // test.identical( outfile.path.remote.path, 'npm:///wmodulefortesting12ab' );
    // logger.log( _.toJson( outfile.path ) );

    return null;
  })

  /* - */

  return a.ready;
}

exportStringrmal.timeOut = 300000;
exportStringrmal.description =
`
- local path and remote path of exported informal module should be preserved and in proper form
- second export should work properly
`

//

function exportWithReflector( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-with-reflector' );
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'out/debug' ) );

  /* - */

  a.ready.then( () =>
  {
    test.case = '.export'
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    return null;
  })

  a.start({ execPath : '.export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './export-with-reflector.out.will.yml' ] );

    var outfile = a.fileProvider.configRead( a.abs( 'out/export-with-reflector.out.will.yml' ) );

    return null;
  })

  return a.ready;
}

//

function exportToRoot( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-to-root' );
  a.reflect();

  /* - */

  a.start({ execPath : '.export' })

  .then( ( got ) =>
  {
    test.case = '.export'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exporting .*module::export-to-root \/ build::proto\.export.*/ ) );
    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, /Exported .*module::export-to-root \/ build::proto\.export.* in/ ) );
    test.is( a.fileProvider.fileExists( a.abs( 'export-to-root.out.will.yml' ) ) )
    return null;
  })

  return a.ready;
}

//

function exportMixed( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-mixed' );
  let outPath = a.abs( 'out' );
  let modulePath = a.abs( 'module' );
  a.reflect();

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.each module .export';
    return null;
  })

  a.start({ execPath : '.each module .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exporting .*module::ModuleForTesting12ab\.informal \/ build::export.*/ ) );
    test.is( _.strHas( got.output, ' + reflector::download reflected' ) );
    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, /Exported .*module::ModuleForTesting12ab\.informal \/ build::export.* in/ ) );
    test.is( _.strHas( got.output, 'out/ModuleForTesting12.informal.out.will.yml' ) );
    test.is( _.strHas( got.output, 'out/ModuleForTesting12ab.informal.out.will.yml' ) );

    test.is( a.fileProvider.isTerminal( a.abs( 'out/ModuleForTesting12.informal.out.will.yml' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( 'out/ModuleForTesting12ab.informal.out.will.yml' ) ) );

    var files = self.find( modulePath );
    test.identical( files, [ '.', './ModuleForTesting12.informal.will.yml', './ModuleForTesting12ab.informal.will.yml' ] );
    var files = self.find( outPath );
    test.identical( files, [ '.', './ModuleForTesting12.informal.out.will.yml', './ModuleForTesting12ab.informal.out.will.yml' ] );

    var expected = [ 'ModuleForTesting12.informal.will.yml', 'ModuleForTesting12ab.informal.will.yml' ];
    var files = a.fileProvider.dirRead( modulePath );
    test.identical( files, expected );

    var outfile = a.fileProvider.configRead( a.path.join( routinePath, 'out/ModuleForTesting12.informal.out.will.yml' ) );
    outfile = outfile.module[ 'ModuleForTesting12.informal.out' ];
    var expected =
    {
      'download' :
      {
        'src' : { 'prefixPath' : 'path::remote', 'filePath' : { '.' : '.' } },
        'dst' : { 'prefixPath' : 'path::download' },
        'mandatory' : 1,
      },
      'exported.export' :
      {
        'src' :
        {
          'filePath' : { '**' : '' },
          'prefixPath' : '../.module/ModuleForTesting12/proto'
        },
        'criterion' : { 'export' : 1, 'default' : 1, 'generated' : 1 },
        'mandatory' : 1,
      },
      'exported.files.export' :
      {
        'recursive' : 0,
        'mandatory' : 1,
        'src' : { 'filePath' : { 'path::exported.files.export' : '' }, 'basePath' : '.', 'prefixPath' : 'path::exported.dir.export', 'recursive' : 0 },
        'criterion' : { 'default' : 1, 'export' : 1, 'generated' : 1 }
      }
    }
    test.identical( outfile.reflector, expected );
    test.identical( outfile.reflector[ 'exported.files.export' ], expected[ 'exported.files.export' ] );

    var expected =
    {
      "module.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `ModuleForTesting12.informal.out.will.yml`
      },
      "module.common" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `ModuleForTesting12.informal.out`
      },
      "module.original.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `../module/ModuleForTesting12.informal.will.yml`
      },
      "module.peer.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `../module/ModuleForTesting12.informal.will.yml`,
      },
      'module.peer.in' :
      {
        'criterion' : { 'predefined' : 1 },
        'path' : '..',
      },
      "in" :
      {
        "path" : `.`
      },
      "out" :
      {
        "path" : `.`
      },
      // "remote" :
      // {
      //   "criterion" : { "predefined" : 1 }
      // },
      "download" : { "path" : `../.module/ModuleForTesting12`/*, "criterion" : { "predefined" : 1 }*/ },
      "export" : { "path" : `{path::download}/proto/**` },
      "exported.dir.export" :
      {
        "criterion" : { "default" : 1, "export" : 1, "generated" : 1 },
        "path" : `../.module/ModuleForTesting12/proto`
      },
      "exported.files.export" :
      {
        "criterion" : { "default" : 1, "export" : 1, "generated" : 1 },
        "path" :
        [
          `../.module/ModuleForTesting12/proto`,
          `../.module/ModuleForTesting12/proto/dwtools`,
          `../.module/ModuleForTesting12/proto/dwtools/Tools.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto/Include.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto/l1`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto/l1/Define.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto/l1/ModuleForTesting12.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto/l1/Workpiece.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto/l3`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto/l3/Accessor.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto/l3/Class.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto/l3/Complex.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto/l3/Like.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto.test`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto.test/Class.test.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto.test/Complex.test.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto.test/Like.test.s`,
          `../.module/ModuleForTesting12/proto/dwtools/abase/l3_proto.test/ModuleForTesting12.test.s`
        ]
      }
    }
    test.identical( outfile.path, expected );
    // logger.log( _.toJson( outfile.path ) );

    var expected =
    {
      'export' :
      {
        'version' : '0.1.0',
        'recursive' : 0,
        'withIntegrated' : 2,
        'tar' : 0,
        'criterion' : { 'default' : 1, 'export' : 1 },
        'exportedReflector' : 'reflector::exported.export',
        'exportedFilesReflector' : 'reflector::exported.files.export',
        'exportedDirPath' : 'path::exported.dir.export',
        'exportedFilesPath' : 'path::exported.files.export',
      }
    }
    test.identical( outfile.exported, expected );

    var expected =
    {
      'export.common' :
      {
        'opts' : { 'export' : 'path::export', 'tar' : 0 },
        'inherit' : [ 'module.export' ]
      },
      'download' :
      {
        'opts' : { 'reflector' : 'reflector::download*', 'verbosity' : null },
        'inherit' : [ 'files.reflect' ]
      }
    }
    test.identical( outfile.step, expected );

    var expected =
    {
      'export' :
      {
        'criterion' : { 'default' : 1, 'export' : 1 },
        'steps' : [ 'step::download', 'step::export.common' ]
      }
    }
    test.identical( outfile.build, expected );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.build';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build' })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exporting .*module::ModuleForTesting12ab.informal.* \/ build::export/ ) );
    test.is( _.strHas( got.output, /\+ reflector::download reflected .* file\(s\)/ ) );
    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, /Exported .*module::ModuleForTesting12ab.informal.* \/ build::export/ ) );
    test.is( _.strHas( got.output, 'out/ModuleForTesting12.informal.out.will.yml' ) );
    test.is( _.strHas( got.output, 'out/ModuleForTesting12ab.informal.out.will.yml' ) );
    test.is( _.strHas( got.output, 'Reloading submodules' ) );

    test.is( _.strHas( got.output, /- .*step::delete.out.debug.* deleted 0 file\(s\), at/ ) );
    test.is( _.strHas( got.output, ' + reflector::reflect.proto.debug reflected' ) );
    test.is( _.strHas( got.output, ' + reflector::reflect.submodules reflected' ) );

    test.identical( _.strCount( got.output, ' ! Failed to open' ), 4 );

    test.is( a.fileProvider.isTerminal( a.abs( 'out/ModuleForTesting12.informal.out.will.yml' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( 'out/ModuleForTesting12ab.informal.out.will.yml' ) ) );

    var files = self.find( modulePath );
    test.identical( files, [ '.', './ModuleForTesting12.informal.will.yml', './ModuleForTesting12ab.informal.will.yml' ] );
    var files = self.find( outPath );
    test.gt( files.length, 70 );

    var expected = [ 'ModuleForTesting12.informal.will.yml', 'ModuleForTesting12ab.informal.will.yml' ];
    var files = a.fileProvider.dirRead( modulePath );
    test.identical( files, expected );

    var expected = [ 'dwtools', 'WithSubmodules.s' ];
    var files = a.fileProvider.dirRead( a.abs( 'out/debug' ) );
    test.identical( files, expected );

    return null;
  })

  /* - */

  return a.ready;
}

exportMixed.timeOut = 300000;

//

function exportSecond( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-second' );
  a.reflect();

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.export';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, '+ Write out willfile' ), 2 );
    test.identical( _.strCount( got.output, 'Exported module::ExportSecond / build::export with 6 file(s) in' ), 1 );

    test.is( a.fileProvider.isTerminal( a.abs( 'out/ExportSecond.out.will.yml' ) ) );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './ExportSecond.out.will.yml', './debug', './debug/.NotExecluded.js', './debug/File.js' ] );

    var outfile = a.fileProvider.configRead( a.abs( 'out/ExportSecond.out.will.yml' ) );

    outfile = outfile.module[ 'ExportSecond.out' ]

    var expected =
    {
      "reflect.proto." :
      {
        "src" :
        {
          "filePath" : { "path::proto" : "path::out.*=1" },
          "prefixPath" : ""
        },
        "dst" : { "prefixPath" : "" },
        "mandatory" : 1,
        "criterion" : { "debug" : 0 },
        "inherit" : [ "predefined.*" ],
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "reflect.proto.debug" :
      {
        "src" :
        {
          "filePath" : { "path::proto" : "path::out.*=1" }
        },
        "mandatory" : 1,
        "criterion" : { "debug" : 1 },
        "inherit" : [ "predefined.*" ],
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "exported.doc.export" :
      {
        "src" :
        {
          "filePath" : { "**" : "" },
          "prefixPath" : "../doc"
        },
        "mandatory" : 1,
        "criterion" : { "doc" : 1, "export" : 1, 'generated' : 1 },
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "exported.files.doc.export" :
      {
        "src" :
        {
          "filePath" : { "path::exported.files.doc.export" : "" },
          "basePath" : ".",
          "prefixPath" : "path::exported.dir.doc.export",
          "recursive" : 0
        },
        "recursive" : 0,
        "mandatory" : 1,
        "criterion" : { "doc" : 1, "export" : 1, 'generated' : 1 },
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "exported.proto.export" :
      {
        "src" :
        {
          "filePath" : { "**" : "" },
          "prefixPath" : "../proto"
        },
        "mandatory" : 1,
        "criterion" : { "proto" : 1, "export" : 1, 'generated' : 1 },
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "exported.files.proto.export" :
      {
        "src" :
        {
          "filePath" : { "path::exported.files.proto.export" : "" },
          "basePath" : ".",
          "prefixPath" : "path::exported.dir.proto.export",
          "recursive" : 0
        },
        "recursive" : 0,
        "mandatory" : 1,
        "criterion" : { "proto" : 1, "export" : 1, 'generated' : 1 },
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      }
    }
    test.identical( outfile.reflector, expected );
    // logger.log( _.toJson( outfile.reflector ) ); debugger;

    var expected =
    {
      "module.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : "ExportSecond.out.will.yml"
      },
      "module.common" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : "ExportSecond.out"
      },
      "module.original.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : [ "../.ex.will.yml", "../.im.will.yml" ]
      },
      "module.peer.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : [ "../.ex.will.yml", "../.im.will.yml" ]
      },
      "download" :
      {
        "criterion" : { "predefined" : 1 }
      },
      // "remote" :
      // {
      //   "criterion" : { "predefined" : 1 }
      // },
      "in" :
      {
        "path" : "."
      },
      "temp" : { "path" : "." },
      "out" :
      {
        "path" : "."
      },
      "out.debug" :
      {
        "criterion" : { "debug" : 1 },
        "path" : "debug/*"
      },
      "out.release" :
      {
        "criterion" : { "debug" : 0 },
        "path" : "release/*"
      },
      "proto" : { "path" : "../proto/**" },
      "doc" : { "path" : "../doc/**" },
      "exported.dir.doc.export" :
      {
        "criterion" : { "doc" : 1, "export" : 1, "generated" : 1 },
        "path" : "../doc"
      },
      "exported.files.doc.export" :
      {
        "criterion" : { "doc" : 1, "export" : 1, 'generated' : 1 },
        "path" : [ "../doc", "../doc/File.md" ]
      },
      "exported.dir.proto.export" :
      {
        "criterion" : { "proto" : 1, "export" : 1, 'generated' : 1 },
        "path" : "../proto"
      },
      "exported.files.proto.export" :
      {
        "criterion" : { "proto" : 1, "export" : 1, 'generated' : 1 },
        "path" : [ "../proto", "../proto/-NotExecluded.js", "../proto/.NotExecluded.js", "../proto/File.js" ]
      },
      'module.peer.in' :
      {
        'criterion' : { 'predefined' : 1 },
        'path' : '..'
      }
    }
    test.identical( outfile.path, expected );
    // logger.log( _.toJson( outfile.path ) ); debugger;

    var expected =
    {
      'doc.export' :
      {
        version : '0.0.0',
        recursive : 0,
        withIntegrated : 2,
        tar : 0,
        criterion : { doc : 1, export : 1 },
        exportedReflector : 'reflector::exported.doc.export',
        exportedFilesReflector : 'reflector::exported.files.doc.export',
        exportedDirPath : 'path::exported.dir.doc.export',
        exportedFilesPath : 'path::exported.files.doc.export',
      },
      'proto.export' :
      {
        version : '0.0.0',
        recursive : 0,
        withIntegrated : 2,
        tar : 0,
        criterion : { proto : 1, export : 1 },
        exportedReflector : 'reflector::exported.proto.export',
        exportedFilesReflector : 'reflector::exported.files.proto.export',
        exportedDirPath : 'path::exported.dir.proto.export',
        exportedFilesPath : 'path::exported.files.proto.export',
      }
    }
    test.identical( outfile.exported, expected );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.export';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, '+ Write out willfile' ), 2 );
    test.identical( _.strCount( got.output, 'Exported module::ExportSecond / build::export with 6 file(s) in' ), 1 );

    test.is( a.fileProvider.isTerminal( a.abs( 'out/ExportSecond.out.will.yml' ) ) );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './ExportSecond.out.will.yml', './debug', './debug/.NotExecluded.js', './debug/File.js' ] );

    var outfile = a.fileProvider.configRead( a.abs( 'out/ExportSecond.out.will.yml' ) );

    outfile = outfile.module[ 'ExportSecond.out' ]

    var expected =
    {
      "reflect.proto." :
      {
        "src" :
        {
          "filePath" : { "path::proto" : "path::out.*=1" },
          "prefixPath" : ""
        },
        "dst" : { "prefixPath" : "" },
        "mandatory" : 1,
        "criterion" : { "debug" : 0 },
        "inherit" : [ "predefined.*" ],
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "reflect.proto.debug" :
      {
        "src" :
        {
          "filePath" : { "path::proto" : "path::out.*=1" }
        },
        "mandatory" : 1,
        "criterion" : { "debug" : 1 },
        "inherit" : [ "predefined.*" ],
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "exported.doc.export" :
      {
        "src" :
        {
          "filePath" : { "**" : "" },
          "prefixPath" : "../doc"
        },
        "mandatory" : 1,
        "criterion" : { "doc" : 1, "export" : 1, "generated" : 1 },
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "exported.files.doc.export" :
      {
        "src" :
        {
          "filePath" : { "path::exported.files.doc.export" : "" },
          "basePath" : ".",
          "prefixPath" : "path::exported.dir.doc.export",
          "recursive" : 0
        },
        "recursive" : 0,
        "mandatory" : 1,
        "criterion" : { "doc" : 1, "export" : 1, "generated" : 1 },
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "exported.proto.export" :
      {
        "src" :
        {
          "filePath" : { "**" : "" },
          "prefixPath" : "../proto"
        },
        "mandatory" : 1,
        "criterion" : { "proto" : 1, "export" : 1, "generated" : 1 },
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      },
      "exported.files.proto.export" :
      {
        "src" :
        {
          "filePath" : { "path::exported.files.proto.export" : "" },
          "basePath" : ".",
          "prefixPath" : "path::exported.dir.proto.export",
          "recursive" : 0
        },
        "recursive" : 0,
        "mandatory" : 1,
        "criterion" : { "proto" : 1, "export" : 1, "generated" : 1 },
        "dstRewritingOnlyPreserving" : 1,
        "linking" : "hardLinkMaybe",
      }
    }
    test.identical( outfile.reflector, expected );
    // logger.log( _.toJson( outfile.reflector ) ); debugger;

    var expected =
    {
      "module.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : "ExportSecond.out.will.yml"
      },
      "module.common" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : "ExportSecond.out"
      },
      "module.original.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : [ "../.ex.will.yml", "../.im.will.yml" ]
      },
      "module.peer.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : [ "../.ex.will.yml", "../.im.will.yml" ]
      },
      "download" :
      {
        "criterion" : { "predefined" : 1 }
      },
      // "remote" :
      // {
      //   "criterion" : { "predefined" : 1 }
      // },
      "in" :
      {
        "path" : "."
      },
      "temp" : { "path" : "." },
      "out" :
      {
        "path" : "."
      },
      "out.debug" :
      {
        "criterion" : { "debug" : 1 },
        "path" : "debug/*"
      },
      "out.release" :
      {
        "criterion" : { "debug" : 0 },
        "path" : "release/*"
      },
      "proto" : { "path" : "../proto/**" },
      "doc" : { "path" : "../doc/**" },
      "exported.dir.doc.export" :
      {
        "criterion" : { "doc" : 1, "export" : 1, "generated" : 1 },
        "path" : "../doc"
      },
      "exported.files.doc.export" :
      {
        "criterion" : { "doc" : 1, "export" : 1, "generated" : 1 },
        "path" : [ "../doc", "../doc/File.md" ]
      },
      "exported.dir.proto.export" :
      {
        "criterion" : { "proto" : 1, "export" : 1, "generated" : 1 },
        "path" : "../proto"
      },
      "exported.files.proto.export" :
      {
        "criterion" : { "proto" : 1, "export" : 1, "generated" : 1 },
        "path" : [ "../proto", "../proto/-NotExecluded.js", "../proto/.NotExecluded.js", "../proto/File.js" ]
      },
      'module.peer.in' :
      {
        'criterion' : { 'predefined' : 1 },
        'path' : '..'
      }
    }
    test.identical( outfile.path, expected );
    // logger.log( _.toJson( outfile.path ) ); debugger;

    var expected =
    {
      'doc.export' :
      {
        version : '0.0.0',
        recursive : 0,
        withIntegrated : 2,
        tar : 0,
        criterion : { doc : 1, export : 1 },
        exportedReflector : 'reflector::exported.doc.export',
        exportedFilesReflector : 'reflector::exported.files.doc.export',
        exportedDirPath : 'path::exported.dir.doc.export',
        exportedFilesPath : 'path::exported.files.doc.export',
      },
      'proto.export' :
      {
        version : '0.0.0',
        recursive : 0,
        withIntegrated : 2,
        tar : 0,
        criterion : { proto : 1, export : 1 },
        exportedReflector : 'reflector::exported.proto.export',
        exportedFilesReflector : 'reflector::exported.files.proto.export',
        exportedDirPath : 'path::exported.dir.proto.export',
        exportedFilesPath : 'path::exported.files.proto.export',
      }
    }
    test.identical( outfile.exported, expected );

    return null;
  })

  /* - */

  return a.ready;
}

exportSecond.timeOut = 300000;

//

function exportSubmodules( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules' );
  let outPath = a.abs( 'out' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.export'
    a.fileProvider.filesDelete( outPath );
    return null;
  })

  return a.start({ execPath : '.export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( a.fileProvider.isTerminal( a.abs( 'out/debug/dwtools/abase/l1/testing1/ModuleForTesting1.s' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( 'out/debug/dwtools/abase/l3/testing2a/ModuleForTesting2a.s' ) ) );
    test.is( a.fileProvider.isTerminal( a.abs( 'out/submodules.out.will.yml' ) ) );
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

    var files = self.find( outPath );
    test.is( files.length > 10 );

    var files = a.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  return a.ready;
}

//

function exportMultiple( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-multiple' );
  let outPath = a.abs( 'out' );
  let outWillPath = a.path.join( outPath, 'submodule.out.will.yml' );
  a.reflect();

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.export debug:1';
    a.reflect();
    a.fileProvider.filesDelete( outPath );

    return null;
  })

  a.start({ execPath : '.export debug:1' })

  .then( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js' ] );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'Read 2 willfile(s) in' ) );
    test.is( _.strHas( got.output, /Exported module::submodule \/ build::export.debug with 2 file\(s\) in .*/ ) );
    test.is( _.strHas( got.output, 'Write out archive' ) );
    test.is( _.strHas( got.output, 'Write out willfile' ) );
    test.is( _.strHas( got.output, 'submodule.debug.out.tgs' ) );
    test.is( _.strHas( got.output, 'out/submodule.out.will.yml' ) );

    var outfile = a.fileProvider.configRead( outWillPath );

    outfile = outfile.module[ 'submodule.out' ];

    var exported =
    {
      'export.debug' :
      {
        version : '0.0.1',
        recursive : 0,
        withIntegrated : 2,
        tar : 1,
        criterion :
        {
          default : 1,
          debug : 1,
          raw : 1,
          export : 1
        },
        exportedReflector : 'reflector::exported.export.debug',
        exportedFilesReflector : 'reflector::exported.files.export.debug',
        exportedDirPath : 'path::exported.dir.export.debug',
        exportedFilesPath : 'path::exported.files.export.debug',
        archiveFilePath : 'path::archiveFile.export.debug',
      }
    }

    test.identical( outfile.exported, exported );

    var exportedReflector =
    {
      // src : { filePath : { '.' : '' }, prefixPath : 'debug' },
      src : { filePath : { '**' : '' }, prefixPath : 'debug' },
      mandatory : 1,
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1,
        generated : 1,
      },
      dstRewritingOnlyPreserving : 1,
      linking : 'hardLinkMaybe',
    }
    test.identical( outfile.reflector[ 'exported.export.debug' ], exportedReflector );
    // logger.log( _.toJson( outfile.reflector ) );

    var exportedReflectorFiles =
    {
      recursive : 0,
      mandatory : 1,
      src :
      {
        filePath : { 'path::exported.files.export.debug' : '' },
        basePath : '.',
        prefixPath : 'path::exported.dir.export.debug',
        recursive : 0,
      },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1,
        generated : 1,
      },
      dstRewritingOnlyPreserving : 1,
      linking : 'hardLinkMaybe',
    }

    test.identical( outfile.reflector[ 'exported.files.export.debug' ], exportedReflectorFiles );

    let outfilePath =
    {
      "module.willfiles" :
      {
        "path" : "submodule.out.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.original.willfiles" :
      {
        "path" : [ "../.ex.will.yml", "../.im.will.yml" ],
        "criterion" : { "predefined" : 1 }
      },
      "module.peer.willfiles" :
      {
        "path" : [ "../.ex.will.yml", "../.im.will.yml" ],
        "criterion" : { "predefined" : 1 }
      },
      "download" :
      {
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "submodule.out",
        "criterion" : { "predefined" : 1 }
      },
      // "remote" :
      // {
      //   "criterion" : { "predefined" : 1 }
      // },
      "proto" : { "path" : "../proto" },
      "temp" : { "path" : "." },
      "in" :
      {
        "path" : ".",
      },
      "out" :
      {
        "path" : ".",
      },
      "out.debug" :
      {
        "path" : "debug",
        "criterion" : { "debug" : 1 }
      },
      "out.release" :
      {
        "path" : "release",
        "criterion" : { "debug" : 0 }
      },
      "exported.dir.export.debug" :
      {
        "path" : "debug",
        "criterion" :
        {
          "default" : 1,
          "debug" : 1,
          "raw" : 1,
          "export" : 1,
          "generated" : 1,
        }
      },
      "exported.files.export.debug" :
      {
        "path" : [ "debug", "debug/File.debug.js" ],
        "criterion" :
        {
          "default" : 1,
          "debug" : 1,
          "raw" : 1,
          "export" : 1,
          'generated' : 1,
        }
      },
      "archiveFile.export.debug" :
      {
        "path" : "submodule.debug.out.tgs",
        "criterion" :
        {
          "default" : 1,
          "debug" : 1,
          "raw" : 1,
          "export" : 1,
          "generated" : 1,
        }
      },
      'module.peer.in' :
      {
        'criterion' : { 'predefined' : 1 },
        'path' : '..'
      }
    }
    test.identical( outfile.path, outfilePath );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.export debug:1';
    a.reflect();
    a.fileProvider.filesDelete( outPath );

    return null;
  })

  a.start({ execPath : '.export debug:1' })
  a.start({ execPath : '.export debug:0' })
  a.start({ execPath : '.export debug:0' })

  .then( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'Read 3 willfile(s) in' ) );
    test.is( _.strHas( got.output, /Exported module::submodule \/ build::export. with 2 file\(s\) in .*/ ) );
    test.is( _.strHas( got.output, 'Write out archive' ) );
    test.is( _.strHas( got.output, 'Write out willfile' ) );
    test.is( _.strHas( got.output, 'submodule.out.tgs' ) );
    test.is( _.strHas( got.output, 'out/submodule.out.will.yml' ) );

    var outfileData = a.fileProvider.fileRead( outWillPath );
    test.is( outfileData.length > 1000 );
    test.is( !_.strHas( outfileData, a.abs( '../..' ) ) );
    test.is( !_.strHas( outfileData, a.path.nativize( a.abs( '../..' ) ) ) );

    var outfile = a.fileProvider.configRead( outWillPath );
    outfile = outfile.module[ 'submodule.out' ]
    var exported =
    {
      'export.debug' :
      {
        version : '0.0.1',
        recursive : 0,
        withIntegrated : 2,
        tar : 1,
        criterion :
        {
          default : 1,
          debug : 1,
          raw : 1,
          export : 1
        },
        exportedReflector : 'reflector::exported.export.debug',
        exportedFilesReflector : 'reflector::exported.files.export.debug',
        exportedDirPath : 'path::exported.dir.export.debug',
        exportedFilesPath : 'path::exported.files.export.debug',
        archiveFilePath : 'path::archiveFile.export.debug',
      },
      'export.' :
      {
        version : '0.0.1',
        recursive : 0,
        withIntegrated : 2,
        tar : 1,
        criterion :
        {
          default : 1,
          debug : 0,
          raw : 1,
          export : 1
        },
        exportedReflector : 'reflector::exported.export.',
        exportedFilesReflector : 'reflector::exported.files.export.',
        exportedDirPath : 'path::exported.dir.export.',
        exportedFilesPath : 'path::exported.files.export.',
        archiveFilePath : 'path::archiveFile.export.',
      },
    }
    test.identical( outfile.exported, exported );

    var exportedReflector =
    {
      'mandatory' : 1,
      'src' :
      {
        'filePath' : { '**' : '' },
        'prefixPath' : 'debug',
      },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1,
        generated : 1,
      },
      dstRewritingOnlyPreserving : 1,
      linking : 'hardLinkMaybe',
    }
    test.identical( outfile.reflector[ 'exported.export.debug' ], exportedReflector );
    // logger.log( _.toJson( outfile.reflector[ 'exported.export.debug' ] ) );

    var exportedReflector =
    {
      'mandatory' : 1,
      src :
      {
        // 'filePath' : { '.' : '' },
        'filePath' : { '**' : '' },
        'prefixPath' : 'release'
      },
      criterion :
      {
        default : 1,
        debug : 0,
        raw : 1,
        export : 1,
        generated : 1,
      },
      dstRewritingOnlyPreserving : 1,
      linking : 'hardLinkMaybe',
    }
    // logger.log( _.toJson( outfile.reflector[ 'exported.export.' ] ) );
    test.identical( outfile.reflector[ 'exported.export.' ], exportedReflector );

    var exportedReflectorFiles =
    {
      recursive : 0,
      mandatory : 1,
      src :
      {
        filePath : { 'path::exported.files.export.debug' : '' },
        basePath : '.',
        prefixPath : 'path::exported.dir.export.debug',
        recursive : 0,
      },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1,
        generated : 1,
      },
      dstRewritingOnlyPreserving : 1,
      linking : 'hardLinkMaybe',
    }

    test.identical( outfile.reflector[ 'exported.files.export.debug' ], exportedReflectorFiles );

    var exportedReflectorFiles =
    {
      recursive : 0,
      mandatory : 1,
      src :
      {
        filePath : { 'path::exported.files.export.' : '' },
        basePath : '.',
        prefixPath : 'path::exported.dir.export.',
        recursive : 0,
      },
      criterion :
      {
        default : 1,
        debug : 0,
        raw : 1,
        export : 1,
        generated : 1,
      },
      dstRewritingOnlyPreserving : 1,
      linking : 'hardLinkMaybe',
    }

    test.identical( outfile.reflector[ 'exported.files.export.' ], exportedReflectorFiles );

    let outfilePath =
    {
      "module.willfiles" :
      {
        "path" : "submodule.out.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.original.willfiles" :
      {
        "path" : [ "../.ex.will.yml", "../.im.will.yml" ],
        "criterion" : { "predefined" : 1 }
      },
      "module.peer.willfiles" :
      {
        "path" : [ "../.ex.will.yml", "../.im.will.yml" ],
        "criterion" : { "predefined" : 1 }
      },
      "download" :
      {
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "submodule.out",
        "criterion" : { "predefined" : 1 }
      },
      // "remote" :
      // {
      //   "criterion" : { "predefined" : 1 }
      // },
      "proto" : { "path" : "../proto" },
      "temp" : { "path" : "." },
      "in" :
      {
        "path" : ".",
      },
      "out" :
      {
        "path" : ".",
      },
      "out.debug" :
      {
        "path" : "debug",
        "criterion" : { "debug" : 1 }
      },
      "out.release" :
      {
        "path" : "release",
        "criterion" : { "debug" : 0 }
      },
      "exported.dir.export.debug" :
      {
        "path" : "debug",
        "criterion" :
        {
          "default" : 1,
          "debug" : 1,
          "raw" : 1,
          "export" : 1,
          "generated" : 1,
        }
      },
      "exported.files.export.debug" :
      {
        "path" : [ "debug", "debug/File.debug.js" ],
        "criterion" :
        {
          "default" : 1,
          "debug" : 1,
          "raw" : 1,
          "export" : 1,
          "generated" : 1,
        }
      },
      "archiveFile.export.debug" :
      {
        "path" : "submodule.debug.out.tgs",
        "criterion" :
        {
          "default" : 1,
          "debug" : 1,
          "raw" : 1,
          "export" : 1,
          "generated" : 1,
        }
      },
      "exported.dir.export." :
      {
        "path" : "release",
        "criterion" :
        {
          "default" : 1,
          "debug" : 0,
          "raw" : 1,
          "export" : 1,
          "generated" : 1,
        }
      },
      "exported.files.export." :
      {
        "path" : [ "release", "release/File.release.js" ],
        "criterion" :
        {
          "default" : 1,
          "debug" : 0,
          "raw" : 1,
          "export" : 1,
          "generated" : 1,
        }
      },
      "archiveFile.export." :
      {
        "path" : "submodule.out.tgs",
        "criterion" :
        {
          "default" : 1,
          "debug" : 0,
          "raw" : 1,
          "export" : 1,
          "generated" : 1,
        }
      },
      'module.peer.in' :
      {
        'criterion' : { 'predefined' : 1 },
        'path' : '..'
      },
    }
    test.identical( outfile.path, outfilePath );
    // logger.log( _.toJson( outfile.path ) );

    return null;
  })

  /* - */

  return a.ready;
}

//

function exportImportMultiple( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-multiple' );
  let out2Path = a.abs( 'super.out' );

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = 'export submodule';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );

    return null;
  })

  a.start({ execPath : '.with . .export debug:0' })
  a.start({ execPath : '.with . .export debug:1' })

  .then( ( got ) =>
  {

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exported module::submodule / build::export.debug with 2 file(s)' ) );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.with super .export debug:0';
    a.fileProvider.filesDelete( out2Path );

    return null;
  })

  a.start({ execPath : '.with super .export debug:0' })

  .then( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [ '.', './supermodule.out.tgs', './supermodule.out.will.yml', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exported module::supermodule / build::export. with 2 file(s)' ) );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.with super .clean dry:1';
    return null;
  })

  a.start({ execPath : '.with super .clean dry:1' })

  .then( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [ '.', './supermodule.out.tgs', './supermodule.out.will.yml', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '5 at ' ) );
    test.is( _.strHas( got.output, 'Clean will delete 5 file(s)' ) );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.with super .clean';
    return null;
  })

  a.start({ execPath : '.with super .clean' })

  .then( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted 5 file(s)' ) );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.with super .export debug:0 ; .with super .export debug:1';

    a.fileProvider.filesDelete( out2Path );

    return null;
  })

  a.start({ execPath : '.with super .export debug:0' })
  a.start({ execPath : '.with super .export debug:1' })

  .then( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [ '.', './supermodule.debug.out.tgs', './supermodule.out.tgs', './supermodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exported module::supermodule / build::export.debug with 2 file(s)' ) );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.with super .clean dry:1';
    return null;
  })

  a.start({ execPath : '.with super .clean dry:1' })

  .then( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [ '.', './supermodule.debug.out.tgs', './supermodule.out.tgs', './supermodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '8 at ' ) );
    test.is( _.strHas( got.output, 'Clean will delete 8 file(s)' ) );

    return null;
  })

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.with super .clean';
    return null;
  })

  a.start({ execPath : '.with super .clean' })

  .then( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted 8 file(s)' ) );

    return null;
  })

  /* - */

  return a.ready;
}

//

function exportBroken( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-multiple-broken' );
  let outPath = a.abs( 'out' );
  let outWillPath = a.path.join( outPath, 'submodule.out.will.yml' );

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.export debug:1';
    a.reflect();

    return null;
  })

  a.start({ execPath : '.export debug:1' })

  .then( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( _.path.join( outPath, 'debug' ) ) );
    test.is( !a.fileProvider.fileExists( _.path.join( outPath, 'release' ) ) );

    test.is( _.strHas( got.output, 'submodule.debug.out.tgs' ) );
    test.is( _.strHas( got.output, 'out/submodule.out.will.yml' ) );

    var outfile = a.fileProvider.configRead( outWillPath );
    outfile = outfile.module[ 'submodule.out' ];

    var exported =
    {
      'export.debug' :
      {
        version : '0.0.1',
        recursive : 0,
        withIntegrated : 2,
        tar : 1,
        criterion :
        {
          default : 1,
          debug : 1,
          raw : 1,
          export : 1
        },
        exportedReflector : 'reflector::exported.export.debug',
        exportedFilesReflector : 'reflector::exported.files.export.debug',
        exportedDirPath : 'path::exported.dir.export.debug',
        exportedFilesPath : 'path::exported.files.export.debug',
        archiveFilePath : 'path::archiveFile.export.debug',
      }
    }

    test.identical( outfile.exported, exported );

    var exportedReflector =
    {
      'mandatory' : 1,
      src :
      {
        // filePath : { '.' : '' },
        filePath : { '**' : '' },
        prefixPath : 'debug'
      },
      criterion :
      {
        generated : 1,
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      },
      dstRewritingOnlyPreserving : 1,
      linking : 'hardLinkMaybe',
    }
    test.identical( outfile.reflector[ 'exported.export.debug' ], exportedReflector );

    var exportedReflectorFiles =
    {
      recursive : 0,
      mandatory : 1,
      src :
      {
        filePath : { 'path::exported.files.export.debug' : '' },
        basePath : '.',
        prefixPath : 'path::exported.dir.export.debug',
        recursive : 0,
      },
      criterion :
      {
        generated : 1,
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      },
      dstRewritingOnlyPreserving : 1,
      linking : 'hardLinkMaybe',
    }

    test.identical( outfile.reflector[ 'exported.files.export.debug' ], exportedReflectorFiles );

    return null;
  })

  return a.ready;
}

//

function exportDoc( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-multiple-doc' );

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = 'export submodule';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    a.fileProvider.filesDelete( a.abs( 'doc.out' ) );

    return null;
  })

  a.start({ execPath : '.with . .export export.doc' })
  a.start({ execPath : '.with . .export export.debug' })
  a.start({ execPath : '.with . .export export.' })
  a.start({ execPath : '.with doc .build doc:1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './submodule.default-debug-raw.out.tgs', './submodule.default-raw.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );

    var files = self.find( a.abs( 'doc.out' ) );
    test.identical( files, [ '.', './file.md' ] );

    return null;
  })

  /* - */

  return a.ready;
}

//

function exportImport( test )
{
  let self = this;
  let a = self.assetFor( test, 'two-exported' );
  let outPath = a.abs( 'super.out' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.export'
    a.fileProvider.filesDelete( outPath );
    return null;
  })

  a.start({ execPath : '.with super .export debug:0' })
  a.start({ execPath : '.with super .export debug:1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = a.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'release', 'supermodule.out.will.yml' ] );

    return null;
  })

  return a.ready;
}

//

function exportBrokenNoreflector( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-broken-noreflector' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with submodule .reflectors.list predefined:0'
    return null;
  })

  a.start({ execPath : '.with submodule .reflectors.list predefined:0' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::' ), 2 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::reflect.proto' ), 1 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::exported.files.export' ), 1 );
    return null;
  })

  a.start({ execPath : '.with module/submodule .export' })
  a.start({ execPath : '.with submodule .reflectors.list predefined:0' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::' ), 3 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::reflect.proto' ), 1 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::exported.export' ), 1 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::exported.files.export' ), 1 );
    return null;
  })

  return a.ready;
} /* end of function exportBrokenNoreflector */

exportBrokenNoreflector.description =
`
removed reflector::exported.export is not obstacle to list out file
`

exportBrokenNoreflector.timeOut = 500000;

//

function exportCourrputedOutfileUnknownSection( test )
{
  let self = this;
  let a = self.assetFor( test, 'corrupted-outfile-unknown-section' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with sub .export debug:1';
    return null;
  })

  a.start( '.with sub .export debug:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'sub.out' ) );
    test.identical( files, [ '.', './sub.out.will.yml' ] );

    var outfile = a.fileProvider.configRead( a.abs( 'sub.out/sub.out.will.yml' ) );
    outfile = outfile.module[ 'sub.out' ];
    var exported = _.setFrom( _.mapKeys( _.select( outfile, 'exported/*' ) ) );
    var exp = _.setFrom( [ 'export.debug' ] );
    test.identical( exported, exp );

    test.identical( _.strCount( got.output, '. Read 2 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, '! Failed to open .' ), 2 );
    test.identical( _.strCount( got.output, 'Failed to open willfile' ), 1 );
    test.identical( _.strCount( got.output, 'Out-willfile should not have section(s) : "unknown_section"' ), 1 );
    test.identical( _.strCount( got.output, /Exported module::sub \/ build::export.debug with .* file\(s\) in .*/ ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportCourrputedOutfileUnknownSection */

//

function exportCourruptedOutfileSyntax( test )
{
  let self = this;
  let a = self.assetFor( test, 'corrupted-outfile-syntax' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with sub .export debug:1';
    return null;
  })

  a.start( '.with sub .export debug:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'sub.out' ) );
    test.identical( files, [ '.', './sub.out.will.yml' ] );

    var outfile = a.fileProvider.configRead( a.abs( 'sub.out/sub.out.will.yml' ) );
    outfile = outfile.module[ 'sub.out' ]
    var exported = _.setFrom( _.mapKeys( _.select( outfile, 'exported/*' ) ) );
    var exp = _.setFrom( [ 'export.debug' ] );
    test.identical( exported, exp );

    test.identical( _.strCount( got.output, '. Read 2 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, '! Failed to open .' ), 2 );
    test.identical( _.strCount( got.output, 'Failed to open willfile' ), 1 );
    test.identical( _.strCount( got.output, 'Failed to convert from "string" to "structure" by encoder yaml-string->structure' ), 1 );
    test.identical( _.strCount( got.output, /Exported .*module::sub \/ build::export.debug.*/ ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportCourruptedOutfileSyntax */

//

function exportCourruptedSubmodulesDisabled( test )
{
  let self = this;
  let a = self.assetFor( test, 'corrupted-submodules-disabled' );

  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with super .export debug:1';
    return null;
  })

  a.start( '.with super .export debug:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'super.out' ) );
    test.identical( files, [ '.', './supermodule.out.will.yml' ] );

    var outfile = a.fileProvider.configRead( a.abs( 'super.out/supermodule.out.will.yml' ) );
    var exported = _.setFrom( _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) ) );
    var exp = _.setFrom( [ 'export.debug' ] );
    test.identical( exported, exp );

    test.identical( _.strCount( got.output, '. Read 2 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::supermodule / build::export.debug with 3 file(s) in' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function exportCourruptedSubmodulesDisabled */

//

function exportDisabledModule( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-disabled-module' );
  let outFilePath = a.abs( 'out/disabled.out.will.yml' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.export';
    a.reflect();
    return null;
  })

  a.start( '.export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var exp = [ '.module', 'out', 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );

    var outfile = a.fileProvider.configRead( outFilePath );
    var exp = _.setFrom( [ 'disabled.out', '../', '../.module/ModuleForTesting1/', '../.module/ModuleForTesting1/out/wModuleForTesting1.out', '../.module/ModuleForTesting2/', '../.module/ModuleForTesting2/out/wModuleForTesting2.out' ] );
    var got = _.setFrom( _.mapKeys( outfile.module ) );
    test.identical( got, exp );

    test.identical( _.strCount( op.output, 'Exported module::disabled / build::proto.export' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with . .export';
    a.reflect();
    return null;
  })

  a.start( '.with . .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var exp = [ '.module', 'out', 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );

    var outfile = a.fileProvider.configRead( outFilePath );
    var exp = _.setFrom( [ 'disabled.out', '../', '../.module/ModuleForTesting1/', '../.module/ModuleForTesting1/out/wModuleForTesting1.out', '../.module/ModuleForTesting2/', '../.module/ModuleForTesting2/out/wModuleForTesting2.out' ] );
    var got = _.setFrom( _.mapKeys( outfile.module ) );
    test.identical( got, exp );

    test.identical( _.strCount( op.output, 'Exported module::disabled / build::proto.export' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with * .export';
    a.reflect();
    return null;
  })

  a.startNonThrowing( '.with * .export' )

  .then( ( op ) =>
  {
    test.notIdentical( op.exitCode, 0 );

    var exp = [ 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );

    test.identical( _.strCount( op.output, 'No module sattisfy' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withDisabled:1; .with * .export';
    a.reflect();
    return null;
  })

  a.startNonThrowing( '.imply withDisabled:1; .with * .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var exp = [ '.module', 'out', 'will.yml' ];
    var files = a.fileProvider.dirRead( a.routinePath );
    test.identical( files, exp );

    var outfile = a.fileProvider.configRead( outFilePath );
    var exp = _.setFrom( [ 'disabled.out', '../', '../.module/ModuleForTesting1/', '../.module/ModuleForTesting1/out/wModuleForTesting1.out', '../.module/ModuleForTesting2/', '../.module/ModuleForTesting2/out/wModuleForTesting2.out' ] );
    var got = _.setFrom( _.mapKeys( outfile.module ) );
    test.identical( got, exp );

    test.identical( _.strCount( op.output, 'Exported module::disabled / build::proto.export' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function exportDisabledModule */

exportDisabledModule.timeOut = 300000;
exportDisabledModule.description =
`
- disabled module should be exported if picked explicitly
- disabled module should not be exported if picked with glob
`

//

function exportOutdated( test )
{
  let self = this;
  let a = self.assetFor( test, 'inconsistent-outfile' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with sub .export debug:1';
    return null;
  })

  a.start( '.with sub .export debug:1' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'sub.out' ) );
    test.identical( files, [ '.', './sub.out.will.yml' ] );

    var outfile = a.fileProvider.configRead( a.abs( 'sub.out/sub.out.will.yml' ) );
    outfile = outfile.module[ 'sub.out' ];
    var exported = _.setFrom( _.mapKeys( _.select( outfile, 'exported/*' ) ) );
    var exp = _.setFrom( [ 'export.debug' ] );
    test.identical( exported, exp );

    test.identical( _.strCount( got.output, '. Read 2 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, /Exported .*module::sub \/ build::export.debug.*/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export release, but input willfile is changed';
    a.fileProvider.fileAppend( a.abs( 'sub.ex.will.yml' ), '\n' );
    return null;
  })

  a.start( '.with sub .export debug:0' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( a.abs( 'sub.out' ) );
    test.identical( files, [ '.', './sub.out.will.yml' ] );

    var outfile = a.fileProvider.configRead( a.abs( 'sub.out/sub.out.will.yml' ) );
    outfile = outfile.module[ 'sub.out' ];
    var exported = _.setFrom( _.mapKeys( _.select( outfile, 'exported/*' ) ) );
    var exp = _.setFrom( [ 'export.' ] );
    test.identical( exported, exp );

    test.identical( _.strCount( got.output, '. Read 2 willfile(s)' ), 1 );
    test.identical( _.strCount( got.output, '! Outdated .' ), 2 );
    test.identical( _.strCount( got.output, 'Failed to open willfile' ), 0 );
    test.identical( _.strCount( got.output, 'Out-willfile is inconsistent with its in-willfiles' ), 0 );
    test.identical( _.strCount( got.output, /Exported .*module::sub \/ build::export.*/ ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportOutdated */

//

function exportWholeModule( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-whole' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = 'export whole module using in path'
    return null;
  })

  a.start({ execPath : '.with module/ .export' })
  a.start({ execPath : '.build' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, [ '.', './.will.yml', './proto', './proto/File1.s', './proto/dir', './proto/dir/File2.s' ] );
    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportWholeModule */

//

function exportRecursive( test )
{
  let self = this;
  let a = self.assetFor( test, 'resolve-path-of-submodules-exported' );
  let outDirPath = a.abs( 'out' );
  a.reflect();
  a.fileProvider.filesDelete( outDirPath );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ab/ .export.recursive -- first'
    return null;
  })

  a.start({ execPath : '.with ab/ .export.recursive' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp = [ '.', './module-a.out.will.yml', './module-b.out.will.yml', './ab', './ab/module-ab.out.will.yml' ];
    var files = self.find( outDirPath );
    test.identical( files, exp )

    test.identical( _.strCount( got.output, 'Exported module::module-ab / module::module-a / build::proto.export with 2 file(s) in' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::module-ab / module::module-b / build::proto.export with 8 file(s) in' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::module-ab / build::proto.export with 13 file(s) in' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ab/ .export.recursive -- second'
    return null;
  })

  a.start({ execPath : '.with ab/ .export.recursive' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp = [ '.', './module-a.out.will.yml', './module-b.out.will.yml', './ab', './ab/module-ab.out.will.yml' ];
    var files = self.find( outDirPath );
    test.identical( files, exp )

    test.identical( _.strCount( got.output, 'Exported module::module-ab / module::module-a / build::proto.export with 2 file(s) in' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::module-ab / module::module-b / build::proto.export with 8 file(s) in' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::module-ab / build::proto.export with 13 file(s) in' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportRecursive */

//

function exportRecursiveUsingSubmodule( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-multiple-exported' );
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'super.out' ) );
  a.fileProvider.filesDelete( a.abs( 'sub.out' ) );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with super .export.recursive debug:1 -- first'
    return null;
  })

  a.start({ execPath : '.with super .export.recursive debug:1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp =
    [
      '.',
      './.ex.will.yml',
      './.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub.out',
      './sub.out/submodule.debug.out.tgs',
      './sub.out/submodule.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './super.out',
      './super.out/supermodule.debug.out.tgs',
      './super.out/supermodule.out.will.yml',
      './super.out/debug',
      './super.out/debug/File.debug.js'
    ]
    var files = self.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported module::supermodule / module::submodule / build::export.debug with 2 file(s)' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::supermodule / build::export.debug with 2 file(s) in' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with super .export.recursive debug:1 -- second'
    return null;
  })

  a.start({ execPath : '.with super .export.recursive debug:1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp =
    [
      '.',
      './.ex.will.yml',
      './.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub.out',
      './sub.out/submodule.debug.out.tgs',
      './sub.out/submodule.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './super.out',
      './super.out/supermodule.debug.out.tgs',
      './super.out/supermodule.out.will.yml',
      './super.out/debug',
      './super.out/debug/File.debug.js'
    ]
    var files = self.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported module::supermodule / module::submodule / build::export.debug with 2 file(s)' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::supermodule / build::export.debug with 2 file(s) in' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with super .export.recursive debug:0 -- first'
    return null;
  })

  a.start({ execPath : '.with super .export.recursive debug:0' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp =
    [
      '.',
      './.ex.will.yml',
      './.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub.out',
      './sub.out/submodule.debug.out.tgs',
      './sub.out/submodule.out.tgs',
      './sub.out/submodule.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './sub.out/release',
      './sub.out/release/File.release.js',
      './super.out',
      './super.out/supermodule.debug.out.tgs',
      './super.out/supermodule.out.tgs',
      './super.out/supermodule.out.will.yml',
      './super.out/debug',
      './super.out/debug/File.debug.js',
      './super.out/release',
      './super.out/release/File.release.js'
    ]
    var files = self.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported module::supermodule / module::submodule / build::export. with 2 file(s)' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::supermodule / build::export. with 2 file(s) in' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with super .export.recursive debug:0 -- second'
    return null;
  })

  a.start({ execPath : '.with super .export.recursive debug:0' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp =
    [
      '.',
      './.ex.will.yml',
      './.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub.out',
      './sub.out/submodule.debug.out.tgs',
      './sub.out/submodule.out.tgs',
      './sub.out/submodule.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './sub.out/release',
      './sub.out/release/File.release.js',
      './super.out',
      './super.out/supermodule.debug.out.tgs',
      './super.out/supermodule.out.tgs',
      './super.out/supermodule.out.will.yml',
      './super.out/debug',
      './super.out/debug/File.debug.js',
      './super.out/release',
      './super.out/release/File.release.js'
    ]
    var files = self.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported module::supermodule / module::submodule / build::export. with 2 file(s)' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::supermodule / build::export. with 2 file(s) in' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportRecursiveUsingSubmodule */

exportRecursiveUsingSubmodule.timeOut = 300000;

//

function exportRecursiveLocal( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-with-submodules' );
  a.reflect();

  /* - */

  a.start({ execPath : '.with */* .clean' })
  a.start({ execPath : '.with */* .export' })

  .finally( ( err, got ) =>
  {
    test.case = 'first';

    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'Exported module::' ), 9 );
    return null;
  })

  a.start({ execPath : '.with ab/ .resources.list' })
  .finally( ( err, got ) =>
  {
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );

    test.identical( _.strCount( got.output, 'About' ), 1 );
    test.identical( _.strCount( got.output, 'module::module-ab / path::export' ), 1 );
    test.identical( _.strCount( got.output, 'module::module-ab /' ), 53 );

    return null;
  })

  /* - */

  a.start({ execPath : '.with */* .export' })
  .finally( ( err, got ) =>
  {
    test.case = 'second';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'Exported module::' ), 9 );
    // test.identical( _.strCount( got.output, 'Exported module::' ), 15 );
    return null;
  })

  a.start({ execPath : '.with ab/ .resources.list' })
  .finally( ( err, got ) =>
  {
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );

    test.identical( _.strCount( got.output, 'About' ), 1 );
    test.identical( _.strCount( got.output, 'module::module-ab / path::export' ), 1 );
    test.identical( _.strCount( got.output, 'module::module-ab /' ), 53 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportRecursiveLocal */

exportRecursiveLocal.timeOut = 300000;

//

function exportDotless( test )
{
  let self = this;
  let a = self.assetFor( test, 'two-dotless-exported' );
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'super.out' ) );
  a.fileProvider.filesDelete( a.abs( 'sub.out' ) );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.export.recursive debug:1'
    return null;
  })

  a.start({ execPath : '.export.recursive debug:1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp =
    [
      '.',
      './ex.will.yml',
      './im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/ex.will.yml',
      './sub/im.will.yml',
      './sub.out',
      './sub.out/sub.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './super.out',
      './super.out/supermodule.out.will.yml',
      './super.out/debug',
      './super.out/debug/File.debug.js',
      './super.out/debug/File.release.js'
    ]
    var files = self.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported module::supermodule / module::sub / build::export.debug with 2 file(s) in' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::supermodule / build::export.debug with 3 file(s) in' ), 1 );

    return null;
  })

  .then( () =>
  {
    test.case = '.with . .export.recursive debug:0'
    return null;
  })

  a.start({ execPath : '.with . .export.recursive debug:0' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp =
    [
      '.',
      './ex.will.yml',
      './im.will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/ex.will.yml',
      './sub/im.will.yml',
      './sub.out',
      './sub.out/sub.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './sub.out/release',
      './sub.out/release/File.release.js',
      './super.out',
      './super.out/supermodule.out.will.yml',
      './super.out/debug',
      './super.out/debug/File.debug.js',
      './super.out/debug/File.release.js',
      './super.out/release',
      './super.out/release/File.debug.js',
      './super.out/release/File.release.js'
    ]
    var files = self.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported module::supermodule / module::sub / build::export. with 2 file(s) in' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::supermodule / build::export. with 3 file(s) in' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportDotless */

exportDotless.timeOut = 300000;

//

function exportDotlessSingle( test )
{
  let self = this;
  let a = self.assetFor( test, 'two-dotless-single-exported' );
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'super.out' ) );
  a.fileProvider.filesDelete( a.abs( 'sub.out' ) );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.export.recursive debug:1'
    return null;
  })

  a.start({ execPath : '.export.recursive debug:1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp =
    [
      '.',
      './will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/will.yml',
      './sub.out',
      './sub.out/sub.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './super.out',
      './super.out/supermodule.out.will.yml',
      './super.out/debug',
      './super.out/debug/File.debug.js',
      './super.out/debug/File.release.js'
    ]
    var files = self.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported module::supermodule / module::sub / build::export.debug with 2 file(s) in' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::supermodule / build::export.debug with 3 file(s) in' ), 1 );

    return null;
  })

  .then( () =>
  {
    test.case = '.with . .export.recursive debug:0'
    return null;
  })

  a.start({ execPath : '.with . .export.recursive debug:0' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp =
    [
      '.',
      './will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/will.yml',
      './sub.out',
      './sub.out/sub.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './sub.out/release',
      './sub.out/release/File.release.js',
      './super.out',
      './super.out/supermodule.out.will.yml',
      './super.out/debug',
      './super.out/debug/File.debug.js',
      './super.out/debug/File.release.js',
      './super.out/release',
      './super.out/release/File.debug.js',
      './super.out/release/File.release.js'
    ]
    var files = self.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported module::supermodule / module::sub / build::export. with 2 file(s) in' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::supermodule / build::export. with 3 file(s) in' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportDotlessSingle */

exportDotlessSingle.timeOut = 300000;

//

function exportTracing( test )
{
  let self = this;
  let a = self.assetFor( test, 'two-dotless-single-exported' );
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'super.out' ) );
  a.fileProvider.filesDelete( a.abs( 'sub.out' ) );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.export.recursive debug:1'
    return null;
  })

  a.startNonThrowing({ execPath : '.export.recursive debug:1', currentPath : a.routinePath + '/proto' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.description = 'files';
    var exp =
    [
      '.',
      './will.yml',
      './proto',
      './proto/File.debug.js',
      './proto/File.release.js',
      './sub',
      './sub/will.yml',
      './sub.out',
      './sub.out/sub.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './super.out',
      './super.out/supermodule.out.will.yml',
      './super.out/debug',
      './super.out/debug/File.debug.js',
      './super.out/debug/File.release.js'
    ]
    var files = self.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported module::supermodule / module::sub / build::export.debug with 2 file(s) in' ), 1 );
    test.identical( _.strCount( got.output, 'Exported module::supermodule / build::export.debug with 3 file(s) in' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with . .export.recursive debug:1'
    return null;
  })

  a.startNonThrowing({ execPath : '.with . .export.recursive debug:1', currentPath : a.routinePath + '/proto' })

  .finally( ( err, op ) =>
  {
    test.notIdentical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'nhandled' ), 0 );
    test.identical( _.strCount( op.output, 'No module sattisfy criteria' ), 1 );
    _.errAttend( err );
    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportTracing */

exportTracing.timeOut = 300000;

//

function exportRewritesOutFile( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-rewrites-out-file' );
  let outFilePath = a.abs( 'out/export-rewrites-out-file.out.will.yml' );
  a.reflect();
  a.fileProvider.fileCopy( a.abs( 'copy.will.yml' ), a.abs( '.will.yml' ) );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = 'export module with two exports'
    return null;
  })

  a.start({ execPath : '.export export1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( outFilePath ) );
    let outFile = a.fileProvider.fileRead({ filePath : outFilePath, encoding : 'yaml' });
    let build = outFile.module[ outFile.root[ 0 ] ].build;
    test.identical( _.mapKeys( build ), [ 'export1', 'export2' ] );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'remove second export build then export again';
    a.fileProvider.fileCopy( a.abs( '.will.yml' ), a.abs( '.will.single-export.yml' ) )
    return null;
  })

  a.start({ execPath : '.export export1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( outFilePath ) );
    let outFile = a.fileProvider.fileRead({ filePath : outFilePath, encoding : 'yaml' });
    let build = outFile.module[ outFile.root[ 0 ] ].build;
    test.identical( _.mapKeys( build ), [ 'export1' ] );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'restore second export, then export again';
    a.fileProvider.fileCopy( a.abs( '.will.yml' ), a.abs( 'copy.will.yml' ) )
    return null;
  })

  a.start({ execPath : '.export export1' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( a.fileProvider.fileExists( outFilePath ) );
    let outFile = a.fileProvider.fileRead({ filePath : outFilePath, encoding : 'yaml' });
    let build = outFile.module[ outFile.root[ 0 ] ].build;
    test.identical( _.mapKeys( build ), [ 'export1', 'export2' ] );
    return null;
  })

  /* - */

  return a.ready;
}

//

function exportWithRemoteSubmodules( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = 'export'
    return null;
  })

  a.start( '.with group1/group10/a0 .clean' )
  a.start( '.with group1/a .clean' )
  a.start( '.with group1/b .clean' )
  a.start( '.with group2/c .clean' )
  a.start( '.with group1/group10/a0 .export' )
  a.start( '.with group1/a .export' )
  a.start( '.with group1/b .export' )
  a.start( '.with group2/c .export' )
  a.start( '.with z .export' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'Failed to open' ), 1 );
    test.identical( _.strCount( got.output, '. Opened .' ), 31 );
    test.identical( _.strCount( got.output, '+ 1/4 submodule(s) of module::z were downloaded' ), 1 );
    test.identical( _.strCount( got.output, '+ 0/4 submodule(s) of module::z were downloaded' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportWithRemoteSubmodules */

exportWithRemoteSubmodules.timeOut = 400000;
exportWithRemoteSubmodules.description =
`
check there is no annoying information about lack of remote submodules of submodules
`

//

function exportDiffDownloadPathsRegular( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-diff-download-paths-regular' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with c .export.recursive';
    a.reflect();
    return null;
  })

  a.start( '.with c .clean recursive:2' )
  a.start( '.with c .export.recursive' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2b' ];
    // var exp = [ 'Color', 'PathBasic', 'PathTools', 'UriBasic' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( 'a/.module' ) )
    test.identical( files, exp );

    var exp = [ 'a.out.will.yml', 'c.out.will.yml', 'debug' ];
    var files = a.fileProvider.dirRead( a.abs( 'out' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 4 );
    test.identical( _.strCount( got.output, '. Opened .' ), 36 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 6 );
    test.identical( _.strCount( got.output, 'Exported module::' ), 10 );
    test.identical( _.strCount( got.output, '+ 6/7 submodule(s) of module::c were downloaded' ), 1 );

    return null;
  })

  a.start( '.with c .export.recursive' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( 'a/.module' ) )
    test.identical( files, exp );

    var exp = [ 'a.out.will.yml', 'c.out.will.yml', 'debug' ];
    var files = a.fileProvider.dirRead( a.abs( 'out' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 38 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, 'Exported module::' ), 10 );
    test.identical( _.strCount( got.output, 'submodule(s) of' ), 0 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function exportDiffDownloadPathsRegular */

exportDiffDownloadPathsRegular.timeOut = 300000;

//

function exportHierarchyRemote( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with z .export.recursive';
    a.reflect();
    return null;
  })

  a.start( '.with z .clean recursive:2' )
  a.start( '.with z .export.recursive' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );
    var exp = [ 'debug', 'z.out.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( 'out' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );
    var exp = [ 'a.out.will.yml', 'b.out.will.yml', 'debug' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/out' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );
    var exp = [ 'a0.out.will.yml', 'debug' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/out' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );
    var exp = [ 'c.out.will.yml', 'debug' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/out' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 1 );
    test.identical( _.strCount( got.output, '. Opened .' ), 38 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 5 );
    test.identical( _.strCount( got.output, 'Exported module::' ), 12 );
    test.identical( _.strCount( got.output, '+ 5/9 submodule(s) of module::z were downloaded' ), 1 );
    test.identical( _.strCount( got.output, 'module::z were downloaded' ), 2 );
    test.identical( _.strCount( got.output, 'were downloaded' ), 6 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .export.recursive';
    a.reflect();
    return null;
  })

  a.start( '.with ** .clean recursive:2' )
  a.start( '.with ** .export.recursive' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );
    var exp = [ 'debug', 'z.out.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( 'out' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );
    var exp = [ 'a.out.will.yml', 'b.out.will.yml', 'debug' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/out' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );
    var exp = [ 'a0.out.will.yml', 'debug' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/out' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );
    var exp = [ 'c.out.will.yml', 'debug' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/out' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 1 );
    test.identical( _.strCount( got.output, '. Opened .' ), 38 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 5 );
    test.identical( _.strCount( got.output, 'Exported module::' ), 12 );
    test.identical( _.strCount( got.output, 'module::z were downloaded' ), 1 );
    test.identical( _.strCount( got.output, 'were downloaded' ), 9 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function exportHierarchyRemote */

exportHierarchyRemote.timeOut = 300000;
exportHierarchyRemote.description =
`
- "with module .export.recursive" should export the same number of modules as "with ** .export.recursive"
- each format of recursive export command should export each instance of each module exactly one time
- each instance of a module is exported once even if module has several instances in different location
`

//

function exportWithDisabled( test )
{
  let self = this;
  let a = self.assetFor( test, 'broken-out' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withDisabled:1 ; .with */* .export.recursive';
    a.reflect();
    return null;
  })

  a.start( '.imply withDisabled:1 ; .with */* .export.recursive' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp =
    [
      '.',
      './module1',
      './module1/.ex.will.yml',
      './module1/.im.will.yml',
      './module1/out',
      './module1/out/module1.out.will.yml',
      './module1/proto',
      './module1/proto/File1.txt',
      './module2',
      './module2/will.yml',
      './module2/out',
      './module2/out/module2.out.will.yml'
    ];
    var files = self.find( a.abs( '.' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported' ), 2 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strHas( got.output, '! Outdated' ), true );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withDisabled:0 ; .with */* .export.recursive';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'module1/out' ) );
    return null;
  })

  a.start( '.imply withDisabled:0 ; .with */* .export.recursive' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp =
    [
      '.',
      './module1',
      './module1/.ex.will.yml',
      './module1/.im.will.yml',
      './module1/proto',
      './module1/proto/File1.txt',
      './module2',
      './module2/will.yml',
      './module2/out',
      './module2/out/module2.out.will.yml'
    ];
    var files = self.find( a.abs( '.' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported' ), 1 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strHas( got.output, '! Outdated' ), false );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.imply withDisabled:0 ; .with */* .export';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'module1/out' ) );
    return null;
  })

  a.start( '.imply withDisabled:0 ; .with */* .export' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp =
    [
      '.',
      './module1',
      './module1/.ex.will.yml',
      './module1/.im.will.yml',
      './module1/proto',
      './module1/proto/File1.txt',
      './module2',
      './module2/will.yml',
      './module2/out',
      './module2/out/module2.out.will.yml'
    ];
    var files = self.find( a.abs( '.' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported' ), 1 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strHas( got.output, '! Outdated' ), false );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with */* .export.recursive';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'module1/out' ) );
    return null;
  })

  a.start( '.with */* .export.recursive' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp =
    [
      '.',
      './module1',
      './module1/.ex.will.yml',
      './module1/.im.will.yml',
      './module1/proto',
      './module1/proto/File1.txt',
      './module2',
      './module2/will.yml',
      './module2/out',
      './module2/out/module2.out.will.yml'
    ];
    var files = self.find( a.abs( '.' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, 'Exported' ), 1 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 );
    test.identical( _.strHas( got.output, '! Outdated' ), false );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function exportWithDisabled */

exportWithDisabled.timeOut = 300000;

//

function exportOutResourceWithoutGeneratedCriterion( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-out-resource-without-generated-criterion' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with c .submodules.download';
    a.reflect();
    return null;
  })

  a.start( '.export' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'ncaught' ), 0 )
    test.identical( _.strCount( got.output, 'nhandled' ), 0 );
    test.identical( _.strCount( got.output, 'Exported module::' ), 1 );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'debug', 'wChangeTransactor.out.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( 'out' ) )
    test.identical( files, exp );

    var outfile = a.fileProvider.configRead( a.abs( 'out/wChangeTransactor.out.will.yml' ) );
    var exp =
    [
      'module.willfiles',
      'module.common',
      'module.original.willfiles',
      'module.peer.willfiles',
      'module.peer.in',
      'download',
      'repository',
      'origins',
      'bugs',
      'in',
      'temp',
      'out',
      'out.debug',
      'out.release',
      'proto',
      'export',
      'exported.dir.proto.export',
      'exported.files.proto.export',
      // 'exported.dir.proto.export.1',
      // 'exported.files.proto.export.1'
    ]
    var got = _.mapKeys( outfile.module[ 'wChangeTransactor.out' ].path );
    test.identical( _.setFrom( got ), _.setFrom( exp ) );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function exportOutResourceWithoutGeneratedCriterion */

//

function exportImplicit( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-implicit' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with explicit/ .export';
    a.reflect();
    return null;
  })

  a.start( '.with explicit/ .clean' )
  a.start( '.with explicit/ .export' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'Exported module::explicit / build::export with 4 file(s)' ), 1 );

    var exp = [ '.', './explicit.out.will.yml', './will.yml', './proto', './proto/File.js' ];
    var files = self.find( a.abs( 'explicit' ) );
    test.identical( files, exp );

    var outfile = a.fileProvider.configRead( a.abs( 'explicit/explicit.out.will.yml' ) );

    /* */

    var exp = [ 'export' ];
    var got = _.mapKeys( outfile.module[ './' ].build );
    test.identical( got, exp );
    var exp = [];
    var got = _.mapKeys( outfile.module[ './' ].step );
    test.identical( got, exp );
    var exp =
    [
      'in',
      'out',
      'module.willfiles',
      'module.original.willfiles',
      'module.peer.willfiles',
      'module.peer.in',
      'module.common',
      'download',
      'export'
    ];
    var got = _.mapKeys( outfile.module[ './' ].path );
    test.identical( got, exp );
    var exp = [];
    var got = _.mapKeys( outfile.module[ './' ].reflector );
    test.identical( got, exp );

    /* */

    var exp = [ 'export' ];
    var got = _.mapKeys( outfile.module[ 'explicit.out' ].exported );
    test.identical( got, exp );
    var exp = [ 'export' ];
    var got = _.mapKeys( outfile.module[ 'explicit.out' ].build );
    test.identical( got, exp );
    var exp = [];
    var got = _.mapKeys( outfile.module[ 'explicit.out' ].step );
    test.identical( got, exp );
    var exp =
    [
      'module.willfiles',
      'module.common',
      'in',
      'out',
      'module.original.willfiles',
      'module.peer.willfiles',
      'module.peer.in',
      'download',
      'export',
      'exported.dir.export',
      'exported.files.export'
    ];
    var got = _.mapKeys( outfile.module[ 'explicit.out' ].path );
    test.identical( got, exp );
    var exp = [ 'exported.export', 'exported.files.export' ];
    var got = _.mapKeys( outfile.module[ 'explicit.out' ].reflector );
    test.identical( got, exp );

    /* */

    var exp = [ '.', 'will.yml', 'proto', 'proto/File.js' ];
    var got = outfile.module[ 'explicit.out' ].path[ 'exported.files.export' ].path;
    test.identical( got, exp );

    /* */

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with implicit/ .export';
    a.reflect();
    return null;
  })

  a.start( '.with implicit/ .clean' )
  a.start( '.with implicit/ .export' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'Exported module::implicit / build::export with 4 file(s)' ), 1 );

    var exp = [ '.', './implicit.out.will.yml', './will.yml', './proto', './proto/File.js' ];
    var files = self.find( a.abs( 'implicit' ) );
    test.identical( files, exp );

    var outfile = a.fileProvider.configRead( a.abs( 'implicit/implicit.out.will.yml' ) );
    debugger;

    /* */

    var exp = [ 'export' ];
    var got = _.mapKeys( outfile.module[ './' ].build );
    test.identical( got, exp );
    var exp = [];
    var got = _.mapKeys( outfile.module[ './' ].step );
    test.identical( got, exp );
    var exp =
    [
      'in',
      'out',
      'module.willfiles',
      'module.original.willfiles',
      'module.peer.willfiles',
      'module.peer.in',
      'module.common',
      'download',
      'export'
    ];
    var got = _.mapKeys( outfile.module[ './' ].path );
    test.identical( got, exp );
    var exp = [];
    var got = _.mapKeys( outfile.module[ './' ].reflector );
    test.identical( got, exp );

    /* */

    var exp = [ 'export' ];
    var got = _.mapKeys( outfile.module[ 'implicit.out' ].exported );
    test.identical( got, exp );
    var exp = [ 'export' ];
    var got = _.mapKeys( outfile.module[ 'implicit.out' ].build );
    test.identical( got, exp );
    var exp = [];
    var got = _.mapKeys( outfile.module[ 'implicit.out' ].step );
    test.identical( got, exp );
    var exp =
    [
      'module.willfiles',
      'module.common',
      'in',
      'out',
      'module.original.willfiles',
      'module.peer.willfiles',
      'module.peer.in',
      'download',
      'export',
      'exported.dir.export',
      'exported.files.export'
    ];
    var got = _.mapKeys( outfile.module[ 'implicit.out' ].path );
    test.identical( got, exp );
    var exp = [ 'exported.export', 'exported.files.export' ];
    var got = _.mapKeys( outfile.module[ 'implicit.out' ].reflector );
    test.identical( got, exp );

    /* */

    var exp = [ '.', 'will.yml', 'proto', 'proto/File.js' ];
    var got = outfile.module[ 'implicit.out' ].path[ 'exported.files.export' ].path;
    test.identical( got, exp );

    /* */

    return null;
  })

  /* - */

  return a.ready;

} /* end of function exportImplicit */

exportImplicit.timeOut = 300000;

//

function exportAuto( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-auto' );
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = 'export'
    return null;
  })

  a.start( '.clean' )
  a.start( '.with submodule/* .export' )
  a.start( '.with manual .export' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp =
    [
      '.',
      './auto.will.yml',
      './manual.will.yml',
      './will.yml',
      './.module',
      './.module/LocalModule.manual.out.will.yml',
      './.module/RemoteModule.manual.out.will.yml',
      './.module/RemoteModule.manual',
      './.module/RemoteModule.manual/README.md',
      './.module/RemoteModule.manual/dir',
      './.module/RemoteModule.manual/dir/SecondFile.md',
      './local',
      './local/LocalFile.txt',
      './out',
      './out/manual.out.will.yml',
      './out/files',
      './out/files/LocalFile.txt',
      './out/files/README.md',
      './out/files/dir',
      './out/files/dir/SecondFile.md',
      './submodule',
      './submodule/local.will.yml',
      './submodule/remote.will.yml'
    ]
    var files = self.find( a.routinePath );
    test.contains( files, exp );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = 'export'
    return null;
  })

  a.start( '.clean' )
  a.start( '.with auto .export.recursive' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp =
    [
      '.',
      './auto.will.yml',
      './manual.will.yml',
      './will.yml',
      './.module',
      './.module/LocalModule.manual.out.will.yml',
      './.module/RemoteModule.manual.out.will.yml',
      './.module/RemoteModule.manual',
      './.module/RemoteModule.manual/README.md',
      './.module/RemoteModule.manual/dir',
      './.module/RemoteModule.manual/dir/SecondFile.md',
      './local',
      './local/LocalFile.txt',
      './out',
      './out/manual.out.will.yml',
      './out/files',
      './out/files/LocalFile.txt',
      './out/files/README.md',
      './out/files/dir',
      './out/files/dir/SecondFile.md',
      './submodule',
      './submodule/local.will.yml',
      './submodule/remote.will.yml'
    ]
    var files = self.find( a.routinePath );
    test.contains( files, exp );

    return null;
  })

  /* - */

  return a.ready;
} /* end of function exportAuto */

exportAuto.timeOut = 300000;
exportAuto.description =
`
- auto export works similar to manual export
`

//

function exportOutdated2( test )
{
  let self = this;
  let a = self.assetFor( test, 'exportWithSubmoduleThatHasModuleDirDeleted' ); /* qqq xxx : assets naming transition is required. ask */

  /* - */

  a.ready
  a.reflect();

  a.start( '.with module/mand/ .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'rror' ), 0 );
    test.identical( _.strCount( op.output, 'ncaught' ), 0 );
    test.identical( _.strCount( op.output, 'nhandled' ), 0 );
    test.identical( _.strCount( op.output, 'Exported module::' ), 1 );
    test.is( a.fileProvider.fileExists( a.abs( 'module/mand/out/mand.out.will.yml' ) ) );
    var read = a.fileProvider.fileRead( a.abs( 'module/mand/.im.will.yml' ) );
    read += '\n\n';
    a.fileProvider.fileWrite( a.abs( 'module/mand/.im.will.yml' ), read );
    return null;
  })

  a.start( '.with module/mand/ .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'rror' ), 0 );
    test.identical( _.strCount( op.output, 'ncaught' ), 0 );
    test.identical( _.strCount( op.output, 'nhandled' ), 0 );
    test.identical( _.strCount( op.output, 'Exported module::' ), 1 );
    test.is( a.fileProvider.fileExists( a.abs( 'module/mand/out/mand.out.will.yml' ) ) );
    return null;
  })

  /* - */

  return a.ready;
}/* end of function exportOutdated2 */

exportOutdated2.description =
`
- Exporting of module with outdated outfile throws no error.
`

//

function exportWithSubmoduleThatHasModuleDirDeleted( test )
{
  let self = this;
  let a = self.assetFor( test, 'exportWithSubmoduleThatHasModuleDirDeleted' );

  /* - */

  a.ready

  .then( ( op ) =>
  {
    test.case = 'optional';
    a.reflect();
    test.is( !a.fileProvider.fileExists( a.abs( 'module/opt/out/opt.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'out/Optional.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'module/opt/.module' ) ) );
    return op;
  })

  a.start( '.with module/opt/ .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'rror' ), 0 );
    test.identical( _.strCount( op.output, 'ncaught' ), 0 );
    test.identical( _.strCount( op.output, 'nhandled' ), 0 );
    test.identical( _.strCount( op.output, 'Exported module::' ), 1 );
    return null;
  })

  .then( ( op ) =>
  {
    a.fileProvider.filesDelete( a.abs( 'module/opt/.module' ) )
    test.is( a.fileProvider.fileExists( a.abs( 'module/opt/out/opt.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'out/Optional.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'module/opt/.module' ) ) );
    return null;
  })

  a.start( '.with Optional .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'rror' ), 0 );
    test.identical( _.strCount( op.output, 'ncaught' ), 0 );
    test.identical( _.strCount( op.output, 'nhandled' ), 0 );
    test.identical( _.strCount( op.output, 'Exported module::' ), 1 );
    test.is( a.fileProvider.fileExists( a.abs( 'module/opt/out/opt.out.will.yml' ) ) );
    test.is( a.fileProvider.fileExists( a.abs( 'out/Optional.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'module/opt/.module' ) ) );

    var exp =
    [
      'Optional.out',
      '../Optional',
      '../module/opt/',
      '../module/opt/out/opt.out',
      '../module/opt/.module/ModuleForTesting2/',
      '../module/opt/.module/ModuleForTesting2/out/wModuleForTesting2.out',
      '../module/opt/.module/ModuleForTesting1/',
      '../module/opt/.module/ModuleForTesting1/out/wModuleForTesting1.out'
    ];
    var outfile = a.fileProvider.configRead( a.abs( 'out/Optional.out.will.yml' ) );
    test.identical( _.mapKeys( outfile.module ), exp );

    return null;
  })

  /* - */

  a.ready

  .then( ( op ) =>
  {
    test.case = 'mandatory';
    a.reflect();
    test.is( !a.fileProvider.fileExists( a.abs( 'module/mand/out/mand.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'out/Mandatory.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'module/mand/.module' ) ) );
    return op;
  })

  a.start( '.with module/mand/ .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'rror' ), 0 );
    test.identical( _.strCount( op.output, 'ncaught' ), 0 );
    test.identical( _.strCount( op.output, 'nhandled' ), 0 );
    test.identical( _.strCount( op.output, 'Exported module::' ), 1 );
    return null;
  })

  .then( ( op ) =>
  {
    a.fileProvider.filesDelete( a.abs( 'module/mand/.module' ) );
    test.is( a.fileProvider.fileExists( a.abs( 'module/mand/out/mand.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'out/Mandatory.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'module/mand/.module' ) ) );
    return null;
  })

  a.startNonThrowing( '.with Mandatory .export' )

  .then( ( op ) =>
  {
    test.ni( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'module::Mandatory / module::mand / opener::ModuleForTesting2 is not available' ), 1 );
    test.identical( _.strCount( op.output, 'ModuleForTesting2 is not available' ), 1 );
    test.identical( _.strCount( op.output, 'Exported module::' ), 0 );
    test.is( a.fileProvider.fileExists( a.abs( 'module/mand/out/mand.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'out/Mandatory.out.will.yml' ) ) );
    test.is( !a.fileProvider.fileExists( a.abs( 'module/mand/.module' ) ) );
    return null;
  })

  /* - */

  return a.ready;
}/* end of function exportWithSubmoduleThatHasModuleDirDeleted */

exportWithSubmoduleThatHasModuleDirDeleted.timeOut = 150000;
exportWithSubmoduleThatHasModuleDirDeleted.description =
`
Supermodule has single submodule. Submodule has own dependency too.
Expected behaviour:
- Submodule exports own files and submodule
- Export of supermodule works even if submodules are not downloaded recursively.
`

//

function exportWithoutSubSubModules( test )
{
  let self = this;
  let a = self.assetFor( test, '4LevelsLocal' );

  a.reflect();
  a.start( '.with * .clean' );

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with l1 .export';
    return null;
  })

  a.start( '.with l1 .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '/l1.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l1.out.will.yml\n' ), 2 );
    var exp = [ '.', './l1.out.will.yml', './l1.will.yml', './l2.will.yml', './l3.will.yml', './l4.will.yml' ];
    var got = self.find( a.abs( '.' ) );
    test.identical( got, exp );
    return op;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with l2 .export';
    return null;
  })

  a.start( '.with l2 .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '/l1.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l1.out.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l2.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l2.out.will.yml\n' ), 2 );
    var exp = [ '.', './l1.out.will.yml', './l1.will.yml', './l2.out.will.yml', './l2.will.yml', './l3.will.yml', './l4.will.yml' ];
    var got = self.find( a.abs( '.' ) );
    test.identical( got, exp );
    return op;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with l3 .export';
    a.fileProvider.fileDelete( a.abs( 'l1.out.will.yml' ) );
    return null;
  })

  a.start( '.with l3 .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '/l1.will.yml\n' ), 0 );
    test.identical( _.strCount( op.output, '/l1.out.will.yml\n' ), 0 );
    test.identical( _.strCount( op.output, '/l1.will.yml from ../l2.out.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l1.out.will.yml from ../l2.out.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l2.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l2.out.will.yml\n' ), 3 );
    test.identical( _.strCount( op.output, '/l3.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l3.out.will.yml\n' ), 2 );
    var exp = [ '.', './l1.will.yml', './l2.out.will.yml', './l2.will.yml', './l3.out.will.yml', './l3.will.yml', './l4.will.yml' ];
    var got = self.find( a.abs( '.' ) );
    test.identical( got, exp );
    return op;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with l4 .export';
    a.fileProvider.fileDelete( a.abs( 'l2.out.will.yml' ) );
    return null;
  })

  a.start( '.with l4 .export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '/l1.will.yml\n' ), 0 );
    test.identical( _.strCount( op.output, '/l1.out.will.yml\n' ), 0 );
    test.identical( _.strCount( op.output, '/l1.will.yml from ../l3.out.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l1.out.will.yml from ../l3.out.will.yml\n' ), 1 );

    test.identical( _.strCount( op.output, '/l2.will.yml\n' ), 0 );
    test.identical( _.strCount( op.output, '/l2.out.will.yml\n' ), 0 );
    test.identical( _.strCount( op.output, '/l2.will.yml from ../l3.out.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l2.out.will.yml from ../l3.out.will.yml\n' ), 1 );

    test.identical( _.strCount( op.output, '/l3.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l3.out.will.yml\n' ), 5 );
    test.identical( _.strCount( op.output, '/l4.will.yml\n' ), 1 );
    test.identical( _.strCount( op.output, '/l4.out.will.yml\n' ), 2 );
    var exp = [ '.', './l1.will.yml', './l2.will.yml', './l3.out.will.yml', './l3.will.yml', './l4.out.will.yml', './l4.will.yml' ];
    var got = self.find( a.abs( '.' ) );
    test.identical( got, exp );
    return op;
  });

  /* - */

  return a.ready;
}

exportWithoutSubSubModules.timeOut = 300000;

//

function exportWithSubmoduleWithNotDownloadedSubmodule( test )
{
  let self = this;
  let a = self.assetFor( test );

  a.reflect();

  var exp = [ '.', './will.yml' ];
  var got = self.find( a.abs( '.' ) );
  test.identical( got, exp );

  /* - */

  a.ready.then( () =>
  {
    test.case = '.export';
    return null;
  })

  a.start( '.export' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'Exported module::l1 / build::export with 3 file(s)' ), 1 );
    var exp =
    [
      '.',
      './l1.out.will.yml',
      './will.yml',
      './.module',
      './.module/ModuleForTesting12',
      './.module/ModuleForTesting12/.ex.will.yml',
      './.module/ModuleForTesting12/.gitattributes',
      './.module/ModuleForTesting12/.gitignore',
      './.module/ModuleForTesting12/.im.will.yml',
      './.module/ModuleForTesting12/.travis.yml',
      './.module/ModuleForTesting12/LICENSE',
      './.module/ModuleForTesting12/package.json',
      './.module/ModuleForTesting12/README.md',
      './.module/ModuleForTesting12/was.package.json',
      './.module/ModuleForTesting12/doc',
      './.module/ModuleForTesting12/doc/ModuleForTesting12.md',
      './.module/ModuleForTesting12/doc/README.md',
      './.module/ModuleForTesting12/out',
      './.module/ModuleForTesting12/out/wModuleForTesting12.out.will.yml',
      './.module/ModuleForTesting12/proto',
      './.module/ModuleForTesting12/proto/dwtools',
      './.module/ModuleForTesting12/proto/dwtools/Tools.s',
      './.module/ModuleForTesting12/proto/dwtools/abase',
      './.module/ModuleForTesting12/proto/dwtools/abase/l3',
      './.module/ModuleForTesting12/proto/dwtools/abase/l3/testing12',
      './.module/ModuleForTesting12/proto/dwtools/abase/l3/testing12/Include.s',
      './.module/ModuleForTesting12/proto/dwtools/abase/l3/testing12/ModuleForTesting12.s',
      './.module/ModuleForTesting12/proto/dwtools/abase/l3.test',
      './.module/ModuleForTesting12/proto/dwtools/abase/l3.test/ModuleForTesting12.test.s',
      './.module/ModuleForTesting12/sample',
      './.module/ModuleForTesting12/sample/Sample.js'
    ]
    var got = self.find( a.abs( '.' ) );
    test.identical( got, exp );
    return op;
  });

  /* - */

  return a.ready;
}

//

/*
Import out file with non-importable path local.
Test importing of non-valid out files.
Test redownloading of currupted remote submodules.
*/

function importPathLocal( test )
{
  let self = this;
  let a = self.assetFor( test, 'import-path-local' );

  /* xxx : replace _.path.join( modulePath */

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = 'export submodule';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );

    return null;
  })

  a.start({ execPath : '.build' })
  .then( ( got ) =>
  {

    var files = self.find( a.abs( 'out' ) );
    test.contains( files, [ '.', './debug', './debug/WithSubmodules.s', './debug/dwtools', './debug/dwtools/Tools.s' ] );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /Built .*module::submodules \/ build::debug\.raw.* in/ ), 1 );

    return null;
  })

  /* - */

  return a.ready;
}

//

function importLocalRepo( test )
{
  let self = this;
  let a = self.assetFor( test, 'import-auto' );
  let modulePath = a.abs( '.module' ); /* qqq */
  a.reflect();

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = '.with module/ModuleForTesting12 .export';
    a.reflect();

    return null;
  })

  a.start({ execPath : '.with module/ModuleForTesting12 .clean' })
  a.start({ execPath : '.with module/ModuleForTesting12 .export' })

  .then( ( got ) =>
  {

    var files = a.fileProvider.dirRead( modulePath );
    test.identical( files, [ 'ModuleForTesting12', 'ModuleForTesting12.out.will.yml' ] );

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /\+ reflector::download reflected .* file\(s\)/ ), 1 );
    test.identical( _.strCount( got.output, /Write out willfile .*\/.module\/ModuleForTesting12.out.will.yml/ ), 1 );

    var outfile = a.fileProvider.configRead( a.path.join( modulePath, 'ModuleForTesting12.out.will.yml' ) ); /* qqq xxx */
    outfile = outfile.module[ 'ModuleForTesting12.out' ];

    var expectedReflector =
    {
      "download" :
      {
        "src" :
        {
          "filePath" : { "." : `.` },
          "prefixPath" : `path::remote`
        },
        "dst" : { "prefixPath" : `path::download` },
        "mandatory" : 1
      },
      "exported.export" :
      {
        "src" :
        {
          "filePath" : { "**" : `` },
          "prefixPath" : `ModuleForTesting12/proto`
        },
        "mandatory" : 1,
        "criterion" : { "default" : 1, "export" : 1, 'generated' : 1 }
      },
      "exported.files.export" :
      {
        "src" :
        {
          "filePath" : { "path::exported.files.export" : `` },
          "basePath" : `.`,
          "prefixPath" : `path::exported.dir.export`,
          "recursive" : 0
        },
        "recursive" : 0,
        "mandatory" : 1,
        "criterion" : { "default" : 1, "export" : 1, "generated" : 1 }
      }
    }
    test.identical( outfile.reflector, expectedReflector );

    var expectedPath =
    {
      "module.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `ModuleForTesting12.out.will.yml`
      },
      "module.common" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `ModuleForTesting12.out`
      },
      "module.original.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `../module/ModuleForTesting12.will.yml`
      },
      "module.peer.willfiles" :
      {
        "criterion" : { "predefined" : 1 },
        "path" : `../module/ModuleForTesting12.will.yml`
      },
      "in" :
      {
        "path" : `.`
      },
      "out" :
      {
        "path" : `.`
      },
      // "remote" :
      // {
      //   "criterion" : { "predefined" : 1 }
      // },
      "download" : { "path" : `ModuleForTesting12` },
      "export" : { "path" : `{path::download}/proto/**` },
      "temp" : { "path" : `../out` },
      "exported.dir.export" :
      {
        "criterion" : { "default" : 1, "export" : 1, "generated" : 1 },
        "path" : `ModuleForTesting12/proto`
      },
      "module.peer.in" :
      {
        'criterion' : { 'predefined' : 1 },
        'path' : '..'
      },
      "exported.files.export" :
      {
        "criterion" : { "default" : 1, "export" : 1, "generated" : 1 },
        "path" :
        [
          `ModuleForTesting12/proto`,
          `ModuleForTesting12/proto/dwtools`,
          `ModuleForTesting12/proto/dwtools/Tools.s`,
          `ModuleForTesting12/proto/dwtools/abase`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto/Include.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto/l1`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto/l1/Define.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto/l1/ModuleForTesting12.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto/l1/Workpiece.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto/l3`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto/l3/Accessor.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto/l3/Class.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto/l3/Complex.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto/l3/Like.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto.test`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto.test/Class.test.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto.test/Complex.test.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto.test/Like.test.s`,
          `ModuleForTesting12/proto/dwtools/abase/l3_proto.test/ModuleForTesting12.test.s`
        ]
      }
    }
    test.identical( outfile.path, expectedPath );
    // logger.log( _.toJs( outfile.path ) );

    return null;
  })

  /* - */

  return a.ready;
}

//

/*
 - check caching of modules in out-willfiles
*/

function importOutWithDeletedSource( test )
{
  let self = this;
  let a = self.assetFor( test, 'export-with-submodules' );

  /* - */

  a.ready
  .then( ( got ) =>
  {
    test.case = 'export first';
    a.reflect();

    return null;
  })

  a.start({ args : '.clean' })
  a.start({ args : '.with a .export' })
  a.start({ args : '.with b .export' })
  a.start({ args : '.with ab-named .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ '.', './module-a.out.will.yml', './module-ab-named.out.will.yml', './module-b.out.will.yml' ];
    var files = self.find( a.abs( 'out' ) );
    test.identical( files, exp );

    a.fileProvider.filesDelete( a.abs( 'a.will.yml' ) );
    a.fileProvider.filesDelete( a.abs( 'b.will.yml' ) );
    a.fileProvider.filesDelete( a.abs( 'ab' ) );
    a.fileProvider.filesDelete( a.abs( 'ab-named.will.yml' ) );

    return null;
  })

  a.start({ args : '.with out/module-ab-named .modules.list' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, '. Opened .' ), 6 );
    test.identical( _.strCount( got.output, ' from ' ), 5 );
    test.identical( _.strCount( got.output, 'module::module-ab-named' ), 5 );
    test.identical( _.strCount( got.output, 'module::module-ab-named / module::module-a' ), 2 );
    test.identical( _.strCount( got.output, 'module::module-ab-named / module::module-b' ), 2 );
    test.identical( _.strCount( got.output, 'module::' ), 9 );

    return null;
  })

  /* - */

  return a.ready;
}

//

function shellWithCriterion( test )
{
  let self = this;
  let a = self.assetFor( test, 'step-shell-with-criterion' );
  a.reflect();

  /* Checks if start step supports plural criterion and which path is selected using current value of criterion */

  /* - */

  a.start({ execPath : '.build A' })

  .then( ( got ) =>
  {
    test.description = 'should execute file A.js';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Executed-A.js' ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.build B' })

  .then( ( got ) =>
  {
    test.description = 'should execute file B.js';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Executed-B.js' ) );

    return null;
  })

  /* - */

  return a.ready;
}

//

/*
  Checks amount of output from start step depending on value of verbosity option
*/

function shellVerbosity( test )
{
  let self = this;
  let a = self.assetFor( test, 'step-shell-verbosity' );
  a.reflect();

  /* - */

  a.start({ execPath : '.build verbosity.0' })

  .then( ( got ) =>
  {
    test.case = '.build verbosity.0';

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'node -e "console.log( \'message from shell\' )"' ), 0 );
    test.identical( _.strCount( got.output, a.routinePath ), 1 );
    test.identical( _.strCount( got.output, 'message from shell' ), 0 );
    test.identical( _.strCount( got.output, 'Process returned error code 0' ), 0 );

    return null;
  })

  /* - */

  a.start({ execPath : '.build verbosity.1' })

  .then( ( got ) =>
  {
    test.case = '.build verbosity.1';

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'node -e "console.log( \'message from shell\' )"' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath ), 1 );
    test.identical( _.strCount( got.output, 'message from shell' ), 1 );
    test.identical( _.strCount( got.output, 'Process returned error code 0' ), 0 );

    return null;
  })

  /* - */

  a.start({ execPath : '.build verbosity.2' })

  .then( ( got ) =>
  {
    test.case = '.build verbosity.2';

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'node -e "console.log( \'message from shell\' )"' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath ), 1 );
    test.identical( _.strCount( got.output, 'message from shell' ), 2 );
    test.identical( _.strCount( got.output, 'Process returned error code 0' ), 0 );

    return null;
  })

  /* - */

  a.start({ execPath : '.build verbosity.3' })

  .then( ( got ) =>
  {
    test.case = '.build verbosity.3';

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'node -e "console.log( \'message from shell\' )"' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath ), 2 );
    test.identical( _.strCount( got.output, 'message from shell' ), 2 );
    test.identical( _.strCount( got.output, 'Process returned error code 0' ), 0 );

    return null;
  })

  /* - */

  a.start({ execPath : '.build verbosity.5' })

  .then( ( got ) =>
  {
    test.case = 'verbosity:5';

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'node -e "console.log( \'message from shell\' )"' ), 1 );
    test.identical( _.strCount( got.output, a.routinePath ), 2 );
    test.identical( _.strCount( got.output, 'message from shell' ), 2 );
    test.identical( _.strCount( got.output, 'Process returned error code 0' ), 1 );

    return null;
  })

  /* - */

  return a.ready;
}

//

function functionStringsJoin( test )
{
  let self = this;
  let a = self.assetFor( test, 'function-strings-join' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build strings.join'
    return null;
  })
  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build strings.join' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'node' ), 1 );
    test.identical( _.strCount( got.output, 'File2.js' ), 1 );
    test.identical( _.strCount( got.output, 'File3.js' ), 1 );
    test.identical( _.strCount( got.output, 'File1.js' ), 1 );
    test.identical( _.strCount( got.output, 'out1.js' ), 1 );

    var expected =
`console.log( 'File2.js' );
console.log( 'File3.js' );
console.log( 'File1.js' );
`
    var read = a.fileProvider.fileRead( a.abs( 'out1.js' ) );
    test.identical( read, expected );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build multiply'
    return null;
  })
  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build multiply' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'node' ), 2 );
    test.identical( _.strCount( got.output, 'File2.js' ), 1 );
    test.identical( _.strCount( got.output, 'File3.js' ), 1 );
    test.identical( _.strCount( got.output, 'File1.js' ), 2 );
    test.identical( _.strCount( got.output, 'out2.js' ), 2 );

    var expected =
`console.log( 'File3.js' );
console.log( 'File1.js' );
`
    var read = a.fileProvider.fileRead( a.abs( 'out2.js' ) );
    test.identical( read, expected );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build echo1'
    return null;
  })
  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build echo1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'node' ), 6 );
    test.identical( _.strCount( got.output, 'File2.js' ), 4 );
    test.identical( _.strCount( got.output, 'File3.js' ), 4 );
    test.identical( _.strCount( got.output, 'File3.js op2' ), 2 );
    test.identical( _.strCount( got.output, 'File3.js op3' ), 2 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build echo2'
    return null;
  })
  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build echo2' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'node' ), 6 );
    test.identical( _.strCount( got.output, 'Echo.js op2 op3 op1' ), 2 );
    test.identical( _.strCount( got.output, 'Echo.js op2 op3 op2' ), 2 );

    return null;
  })

  /* - */

  return a.ready;
}

//

function functionPlatform( test )
{
  let self = this;
  let a = self.assetFor( test, 'function-platform' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.build'
    return null;
  })
  a.start({ execPath : '.clean' })
  a.start({ execPath : '.build' })
  .then( ( got ) =>
  {
    var Os = require( 'os' );
    let platform = 'posix';

    if( Os.platform() === 'win32' )
    platform = 'windows'
    if( Os.platform() === 'darwin' )
    platform = 'osx'

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '+ reflector::copy reflected 2 file(s)' ), 1 );
    test.identical( _.strCount( got.output, `./out/dir.${platform} <- ./proto in` ), 1 );

    var files = self.find( a.abs( 'out' ) );

    test.identical( files, [ '.', `./dir.${platform}`, `./dir.${platform}/File.js` ] );

    return null;
  })

  /* - */

  return a.ready;
}

//

/*
  Checks resolving selector with criterion.
*/

function functionThisCriterion( test )
{
  let self = this;
  let a = self.assetFor( test, 'step-shell-using-criterion-value' );
  a.reflect();

  /* - */

  a.start({ execPath : '.build debug' })

  .then( ( got ) =>
  {
    test.description = 'should print debug:1';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'debug:1' ) );

    return null;
  })

  /* - */

  a.start({ execPath : '.build release' })

  .then( ( got ) =>
  {
    test.description = 'should print debug:0';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'debug:0' ) );

    return null;
  })

  /* - */

  return a.ready;
}

//

function submodulesDownloadSingle( test )
{
  let self = this;
  let a = self.assetFor( test, 'single' );
  a.reflect();

  /* - */

  a.start({ execPath : '.submodules.download' })

  .then( ( got ) =>
  {
    test.case = '.submodules.download';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 0/0 submodule(s) of module::single were downloaded in' ) );
    return null;
  })

  /* - */

  a.start({ execPath : '.submodules.download' })

  .then( ( got ) =>
  {
    test.case = '.submodules.download'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 0/0 submodule(s) of module::single were downloaded in' ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) )
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) )
    return null;
  })

  /* - */

  a.start({ execPath : '.submodules.update' })

  .then( ( got ) =>
  {
    test.case = '.submodules.update'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 0/0 submodule(s) of module::single were updated in' ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) )
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) )
    return null;
  })

  /* - */

  a.start({ execPath : '.submodules.clean' })

  .then( ( got ) =>
  {
    test.case = '.submodules.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted 0 file(s)' ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) )
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) )
    return null;
  })

  return a.ready;

}

//

function submodulesDownloadUpdate( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules' );
  let submodulesPath = a.abs( '.module' );
  a.reflect();

  /* */

  a.ready

  /* */

  .then( () =>
  {
    test.case = '.submodules.download - first time';
    a.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  a.start({ execPath : '.submodules.download' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 2/2 submodule(s) of module::submodules were downloaded' ) );

    var files = self.find( submodulesPath );

    test.is( files.length > 30 );

    test.is( a.fileProvider.fileExists( a.path.join( submodulesPath, 'ModuleForTesting1' ) ) )
    test.is( a.fileProvider.fileExists( a.path.join( submodulesPath, 'ModuleForTesting2a' ) ) )
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.submodules.download - again';
    return null;
  })
  a.start({ execPath : '.submodules.download' })
  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 0/2 submodule(s) of module::submodules were downloaded' ) );
    test.is( a.fileProvider.fileExists( a.path.join( submodulesPath, 'ModuleForTesting1' ) ) )
    test.is( a.fileProvider.fileExists( a.path.join( submodulesPath, 'ModuleForTesting2a' ) ) )
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) )

    var files = self.find( a.path.join( submodulesPath, 'ModuleForTesting1' ) );
    test.is( files.length > 3 );

    var files = self.find( a.path.join( submodulesPath, 'ModuleForTesting2a' ) );
    test.is( files.length > 3 );

    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.submodules.update - first time';
    a.fileProvider.filesDelete( submodulesPath );
    return null;
  })
  a.start({ execPath : '.submodules.update' })
  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 2/2 submodule(s) of module::submodules were updated' ) );
    test.is( a.fileProvider.fileExists( a.path.join( submodulesPath, 'ModuleForTesting1' ) ) )
    test.is( a.fileProvider.fileExists( a.path.join( submodulesPath, 'ModuleForTesting2a' ) ) )
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) )

    var files = self.find( a.path.join( submodulesPath, 'ModuleForTesting1' ) );
    test.is( files.length >= 1 );

    var files = self.find( a.path.join( submodulesPath, 'ModuleForTesting2a' ) );
    test.is( files.length >= 1 );

    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.submodules.update - again';
    return null;
  })
  a.start({ execPath : '.submodules.update' })
  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 0/2 submodule(s) of module::submodules were updated in' ) );
    test.is( a.fileProvider.fileExists( a.path.join( submodulesPath, 'ModuleForTesting1' ) ) )
    test.is( a.fileProvider.fileExists( a.path.join( submodulesPath, 'ModuleForTesting2a' ) ) )
    test.is( !a.fileProvider.fileExists( a.abs( 'modules' ) ) )

    var files = self.find( a.path.join( submodulesPath, 'ModuleForTesting1' ) );
    test.is( files.length >= 1 );

    var files = self.find( a.path.join( submodulesPath, 'ModuleForTesting2a' ) );
    test.is( files.length >= 1 );

    return null;
  })

  /* */

  var files;

  a.ready
  .then( () =>
  {
    test.case = '.submodules.clean';
    files = self.findAll( submodulesPath );
    return files;
  })

  a.start({ execPath : '.submodules.clean' })
  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `${files.length}` ) );
    test.is( !a.fileProvider.fileExists( a.abs( '.module' ) ) ); /* phantom problem ? */

    return null;
  })

  /* */

  return a.ready;
}

submodulesDownloadUpdate.timeOut = 300000;

//

function submodulesDownloadUpdateDry( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-detached' );
  let submodulesPath = a.abs( '.module' );
  a.reflect();

  /* */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.download dry:1';
    a.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  a.start({ execPath : '.submodules.download dry:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    // test.is( _.strHas( got.output, / \+ .*module::ModuleForTesting1.* will be downloaded version .*/ ) );
    // test.is( _.strHas( got.output, / \+ .*module::ModuleForTesting2.* will be downloaded version .*8031560ec22fd955b0b57430b5d6d96b042fbd99.*/ ) );
    // test.is( _.strHas( got.output, / \+ .*module::ModuleForTesting1a.* will be downloaded version .*$.$.$$$.*/ ) );
    test.is( _.strHas( got.output, '+ 2/5 submodule(s) of module::submodules-detached will be downloaded' ) );
    var files = self.find( submodulesPath );
    test.is( files.length === 0 );
    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.download dry:1 -- after download';
    a.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  a.start({ execPath : '.submodules.download' })
  a.start({ execPath : '.submodules.download dry:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '0/5 submodule(s) of module::submodules-detached will be downloaded' ) );
    var files = self.find( submodulesPath );
    test.gt( files.length, 50 );
    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.update dry:1';
    a.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  a.start({ execPath : '.submodules.update dry:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    // test.is( _.strHas( got.output, / \+ .*module::Tools.* will be updated to version .*/ ) );
    // test.is( _.strHas( got.output, / \+ .*module::PathBasic.* will be updated to version .*622fb3c259013f3f6e2aeec73642645b3ce81dbc.*/ ) );
    // test.is( _.strHas( got.output, / \+ .*module::Color.* will be updated to version .*0.3.115.*/ ) );
    test.is( _.strHas( got.output, '+ 2/5 submodule(s) of module::submodules-detached will be updated' ) );
    var files = self.find( submodulesPath );
    test.is( files.length === 0 );
    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.update dry:1 -- after update';
    a.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  a.start({ execPath : '.submodules.update' })
  a.start({ execPath : '.submodules.update dry:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 0/5 submodule(s) of module::submodules-detached will be updated' ) );
    var files = self.find( submodulesPath );
    test.gt( files.length, 50 );
    return null;
  })

  /* */

  return a.ready;
}

submodulesDownloadUpdateDry.timeOut = 300000;

//

function submodulesDownloadSwitchBranch( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-update-switch-branch' );
  let willfilePath = a.abs( '.will.yml' );
  let submodulesPath = a.abs( '.module' );
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'setup repo';

    let con = new _.Consequence().take( null );
    let repoPath = a.abs( 'experiment' );
    let repoSrcFiles = a.abs( 'src' );
    let clonePath = a.abs( 'cloned' );
    a.fileProvider.dirMake( repoPath );

    let start = _.process.starter
    ({
      currentPath : a.routinePath,
      outputCollecting : 1,
      ready : con,
    })

    start( 'git -C experiment init --bare' )
    start( 'git clone experiment cloned' )

    .then( () =>
    {
      return a.fileProvider.filesReflect({ reflectMap : { [ repoSrcFiles ] : clonePath } })
    })

    start( 'git -C cloned add -fA .' )
    start( 'git -C cloned commit -m init' )
    start( 'git -C cloned push' )
    start( 'git -C cloned checkout -b dev' )
    start( 'git -C cloned commit --allow-empty -m test' )
    start( 'git -C cloned push origin dev' )

    return con;
  })

  .then( () =>
  {
    test.case = 'download master branch';
    return null;
  })

  a.start({ execPath : '.submodules.download' })

  .then( () =>
  {
    debugger
    let currentVersion = a.fileProvider.fileRead( a.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })

  .then( () =>
  {
    test.case = 'switch master to dev';
    let willFile = a.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    // willFile.submodule[ 'willbe-experiment' ] = _.strReplaceAll( willFile.submodule[ 'willbe-experiment' ], '@master', '#dev' );
    willFile.submodule[ 'willbe-experiment' ] = _.strReplaceAll( willFile.submodule[ 'willbe-experiment' ], '@master', '@dev' );
    a.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    debugger;
    return null;
  })

  a.start({ execPath : '.submodules.download' })

  .then( () =>
  {
    let currentVersion = a.fileProvider.fileRead( a.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })

  .then( () =>
  {
    test.case = 'switch dev to detached state';
    let willFile = a.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule[ 'willbe-experiment' ] = _.strReplaceAll( willFile.submodule[ 'willbe-experiment' ], '#dev', '#9ce409887df0754760a1cbdce249b0fa5f08152e' );
    a.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    return null;
  })

  a.start({ execPath : '.submodules.download' })

  .then( () =>
  {
    let currentVersion = a.fileProvider.fileRead( a.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })

  .then( () =>
  {
    test.case = 'switch detached state to master';
    let willFile = a.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule[ 'willbe-experiment' ] = _.strReplaceAll( willFile.submodule[ 'willbe-experiment' ], '#9ce409887df0754760a1cbdce249b0fa5f08152e', '@master' );
    a.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    return null;
  })

  a.start({ execPath : '.submodules.download' })

  .then( () =>
  {
    let currentVersion = a.fileProvider.fileRead( a.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })

  return a.ready;
}

submodulesDownloadSwitchBranch.timeOut = 300000;

// //
//
// function submodulesDownloadRecursive( test )
// {
//   let self = this;
//   let a = self.assetFor( test, 'hierarchy-remote' );
//
//   // let a = self.assetFor( test, 'hierarchy-diff-download-paths-regular' );
//   // let originalAssetPath = _.path.join( self.assetsOriginalPath, 'hierarchy-remote' );
//   // let routinePath = _.path.join( self.suiteTempPath, test.name );
//   // let abs = self.abs_functor( routinePath );
//   // let rel = self.rel_functor( routinePath );
//   // let submodulesPath = _.path.join( routinePath, '.module' );
//   //
//   // let ready = new _.Consequence().take( null );
//   //
//   // let start = _.process.starter
//   // ({
//   //   execPath : 'node ' + self.willPath,
//   //   currentPath : routinePath,
//   //   outputCollecting : 1,
//   //   outputGraying : 1,
//   //   outputGraying : 1,
//   //   mode : 'spawn',
//   //   ready : ready,
//   // })
//   //
//   // _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
//
//   /* - */
//
//   a.ready
//
//   .then( () =>
//   {
//     test.case = '.with * .submodules.download recursive:2';
//     a.reflect();
//     // _.fileProvider.filesDelete( a.abs( '.module' ) );
//     return null;
//   })
//
//   a.start({ execPath : '.with * .submodules.download recursive:2' })
//
//   .then( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//
//     var exp = [ 'ModuleForTesting2b' ];
//     var files = _.fileProvider.dirRead( a.abs( '.module' ) );
//     test.identical( files, exp )
//
//     var exp = null;
//     var files = _.fileProvider.dirRead( a.abs( 'group1/.module' ) );
//     test.identical( files, exp )
//
//     test.identical( _.strCount( got.output, '! Failed to open' ), 4 );
//     test.identical( _.strCount( got.output, '. Read 2 willfile(s) in' ), 1 );
//     test.identical( _.strCount( got.output, 'willfile(s) in' ), 1 );
//
//     test.identical( _.strCount( got.output, '+ 6/7 submodule(s) of module::c were downloaded in' ), 1 );
//     test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );
//     test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
//
//     return null;
//   })
//
//   a.start({ execPath : '.with * .submodules.download recursive:2' })
//
//   .then( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b', 'ModuleForTesting2b', 'ModuleForTesting12ab' ];
//     var files = _.fileProvider.dirRead( a.abs( '.module' ) );
//     test.identical( files, exp )
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b', 'ModuleForTesting12', 'Tools' ];
//     var files = _.fileProvider.dirRead( a.abs( 'a/.module' ) );
//     test.identical( files, exp )
//
//     test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
//     test.identical( _.strCount( got.output, '. Read 26 willfile(s) in' ), 1 );
//     test.identical( _.strCount( got.output, 'willfile(s) in' ), 1 );
//
//     test.identical( _.strCount( got.output, '+ 0/7 submodule(s) of module::c were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );
//     test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
//
//     return null;
//   })
//
//   /* - */
//
//   a.ready
//
//   .then( () =>
//   {
//     test.case = '.with ** .submodules.download recursive:2';
//     // _.fileProvider.filesDelete( a.abs( '.module' ) );
//     a.reflect();
//     return null;
//   })
//
//   a.start({ execPath : '.with ** .submodules.download recursive:2' })
//
//   .then( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b', 'ModuleForTesting2b', 'ModuleForTesting12ab' ];
//     var files = _.fileProvider.dirRead( a.abs( '.module' ) );
//     test.identical( files, exp )
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b', 'ModuleForTesting12', 'Tools' ];
//     var files = _.fileProvider.dirRead( a.abs( 'a/.module' ) );
//     test.identical( files, exp )
//
//     test.identical( _.strCount( got.output, '! Failed to open' ), 4 );
//     test.identical( _.strCount( got.output, '. Read 2 willfile(s) in' ), 1 );
//     test.identical( _.strCount( got.output, 'willfile(s) in' ), 1 );
//
//     test.identical( _.strCount( got.output, '+ 6/7 submodule(s) of module::c were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );
//     test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
//
//     return null;
//   })
//
//   a.start({ execPath : '.with ** .submodules.download recursive:2' })
//
//   .then( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b', 'ModuleForTesting2b', 'ModuleForTesting12ab' ];
//     var files = _.fileProvider.dirRead( a.abs( '.module' ) );
//     test.identical( files, exp )
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b', 'ModuleForTesting12', 'Tools' ];
//     var files = _.fileProvider.dirRead( a.abs( 'a/.module' ) );
//     test.identical( files, exp )
//
//     test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
//     test.identical( _.strCount( got.output, '. Read 26 willfile(s) in' ), 1 );
//     test.identical( _.strCount( got.output, 'willfile(s) in' ), 1 );
//
//     // test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::z / module::wModuleForTesting1b were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::wModuleForTesting12ab were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::z / module::wModuleForTesting12 were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z / module::a0 were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::z / module::wTools were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/4 submodule(s) of module::z / module::c were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::z / module::wModuleForTesting2b were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z / module::b were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/4 submodule(s) of module::z / module::a were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/9 submodule(s) of module::z were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/7 submodule(s) of module::c were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );
//     test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
//
//     return null;
//   })
//
//   /* - */
//
//   a.ready
//
//   .then( () =>
//   {
//     test.case = '.with * .submodules.download recursive:1';
//     // _.fileProvider.filesDelete( a.abs( '.module' ) );
//     a.reflect();
//     return null;
//   })
//
//   a.start({ execPath : '.with * .submodules.download recursive:1' })
//
//   .then( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b', 'ModuleForTesting2b', 'ModuleForTesting12ab' ];
//     var files = _.fileProvider.dirRead( a.abs( '.module' ) );
//     test.identical( files, exp )
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b' ];
//     var files = _.fileProvider.dirRead( a.abs( 'a/.module' ) );
//     test.identical( files, exp )
//
//     test.identical( _.strCount( got.output, '! Failed to open' ), 4 );
//     test.identical( _.strCount( got.output, '. Read 2 willfile(s) in' ), 1 );
//     test.identical( _.strCount( got.output, 'willfile(s) in' ), 1 );
//
//     test.identical( _.strCount( got.output, '+ 4/5 submodule(s) of module::c were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );
//     test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
//
//     return null;
//   })
//
//   a.start({ execPath : '.with * .submodules.download recursive:1' })
//
//   .then( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b', 'ModuleForTesting2b', 'ModuleForTesting12ab' ];
//     var files = _.fileProvider.dirRead( a.abs( '.module' ) );
//     test.identical( files, exp )
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b' ];
//     var files = _.fileProvider.dirRead( a.abs( 'a/.module' ) );
//     test.identical( files, exp )
//
//     test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
//     test.identical( _.strCount( got.output, '. Read 20 willfile(s) in' ), 1 );
//     test.identical( _.strCount( got.output, 'willfile(s) in' ), 1 );
//
//     test.identical( _.strCount( got.output, '+ 0/5 submodule(s) of module::c were downloaded in' ), 1 );
//     test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );
//     test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
//
//     return null;
//   })
//
//   /* - */
//
//   a.ready
//
//   .then( () =>
//   {
//     test.case = '.with ** .submodules.download recursive:1';
//     // _.fileProvider.filesDelete( a.abs( '.module' ) );
//     a.reflect();
//     return null;
//   })
//
//   a.start({ execPath : '.with ** .submodules.download recursive:1' })
//
//   .then( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b', 'ModuleForTesting2b', 'ModuleForTesting12ab' ];
//     var files = _.fileProvider.dirRead( a.abs( '.module' ) );
//     test.identical( files, exp )
//
//     var exp = [ 'ModuleForTesting2a', 'ModuleForTesting1b', 'ModuleForTesting2b', 'ModuleForTesting12ab' ];
//     var files = _.fileProvider.dirRead( a.abs( 'a/.module' ) );
//     test.identical( files, exp )
//
//     test.identical( _.strCount( got.output, '! Failed to open' ), 4 );
//     test.identical( _.strCount( got.output, '. Read 5 willfile(s) in' ), 1 );
//     test.identical( _.strCount( got.output, 'willfile(s) in' ), 1 );
//
//     test.identical( _.strCount( got.output, '+ 2/2 submodule(s) of module::z / module::a0 were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 1/2 submodule(s) of module::z / module::c were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 1/2 submodule(s) of module::z / module::b were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 1/3 submodule(s) of module::z / module::a were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/4 submodule(s) of module::z were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, 'submodule(s)' ), 5 );
//     test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
//
//     return null;
//   })
//
//   a.start({ execPath : '.with ** .submodules.download recursive:1' })
//
//   .then( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//
//     var exp = [ 'ModuleForTesting2b' ];
//     var files = _.fileProvider.dirRead( a.abs( '.module' ) );
//     test.identical( files, exp )
//
//     var exp = [ 'ModuleForTesting2b' ];
//     var files = _.fileProvider.dirRead( a.abs( 'a/.module' ) );
//     test.identical( files, exp )
//
//     test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
//     test.identical( _.strCount( got.output, '. Read 20 willfile(s) in' ), 1 );
//     test.identical( _.strCount( got.output, 'willfile(s) in' ), 1 );
//
//     test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::z / module::wModuleForTesting1b were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::wModuleForTesting12ab were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::z / module::wModuleForTesting12 were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z / module::a0 were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::z / module::wTools were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z / module::c were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::z / module::wModuleForTesting2b were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z / module::b were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/3 submodule(s) of module::z / module::a were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, '+ 0/4 submodule(s) of module::z were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, 'submodule(s)' ), 10 );
//     test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
//
//     // test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::wModuleForTesting1b / module::wModuleForTesting1b were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::wModuleForTesting12ab / module::wModuleForTesting12ab were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::wModuleForTesting12 / module::wModuleForTesting12 were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z / module::a0 were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::wTools / module::wTools were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z / module::c were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::wModuleForTesting2b / module::wModuleForTesting2b were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z / module::b were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/3 submodule(s) of module::z / module::a were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, '+ 0/4 submodule(s) of module::z were downloaded' ), 1 );
//     // test.identical( _.strCount( got.output, 'submodule(s)' ), 10 );
//
//     return null;
//   })
//
//   /* - */
//
//   a.ready
//
//   .then( () =>
//   {
//     test.case = '.with * .submodules.download recursive:0';
//     // _.fileProvider.filesDelete( a.abs( '.module' ) );
//     a.reflect();
//     return null;
//   })
//
//   a.start({ execPath : '.with * .submodules.download recursive:0' })
//
//   .then( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//
//     var exp = null;
//     var files = _.fileProvider.dirRead( a.abs( '.module' ) );
//     test.identical( files, exp )
//
//     var exp = [ 'ModuleForTesting2b' ];
//     var files = _.fileProvider.dirRead( a.abs( 'a/.module' ) );
//     test.identical( files, exp )
//
//     test.identical( _.strCount( got.output, '! Failed to open' ), 1 );
//     test.identical( _.strCount( got.output, '. Read 5 willfile(s) in' ), 1 );
//     test.identical( _.strCount( got.output, 'willfile(s) in' ), 1 );
//
//     test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of module::z were downloaded' ), 1 );
//     test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );
//     test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
//
//     return null;
//   })
//
//   /* - */
//
//   a.ready
//
//   .then( () =>
//   {
//     test.case = '.with ** .submodules.download recursive:0';
//     // _.fileProvider.filesDelete( a.abs( '.module' ) );
//     a.reflect();
//     return null;
//   })
//
//   a.start({ execPath : '.with ** .submodules.download recursive:0' })
//
//   .then( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//
//     var exp = null;
//     var files = _.fileProvider.dirRead( a.abs( '.module' ) );
//     test.identical( files, exp )
//
//     var exp = [ 'ModuleForTesting2b' ];
//     var files = _.fileProvider.dirRead( a.abs( 'a/.module' ) );
//     test.identical( files, exp )
//
//     test.identical( _.strCount( got.output, '! Failed to open' ), 1 );
//     test.identical( _.strCount( got.output, '. Read 5 willfile(s) in' ), 1 );
//     test.identical( _.strCount( got.output, 'willfile(s) in' ), 1 );
//
//     test.identical( _.strCount( got.output, '+ 0/0 submodule(s) of' ), 5 );
//     test.identical( _.strCount( got.output, 'submodule(s)' ), 5 );
//     test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
//
//     return null;
//   })
//
//   /* - */
//
//   return a.ready;
// } /* end of function submodulesDownloadRecursive */
//
// submodulesDownloadRecursive.timeOut = 500000;
// xxx

//

function submodulesDownloadThrowing( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-download-errors' );
  let downloadPath = a.abs( '.module/ModuleForTesting2a' );
  let filePath = a.path.join( downloadPath, 'file' );
  let filesBefore;
  a.startNonThrowing2 = _.process.starter
  ({
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    throwingExitCode : 0,
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = 'error on download, new directory should not be made';
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    return null;
  })
  a.startNonThrowing({ execPath : '.with bad .submodules.download' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `fatal: unable to access 'https://githu.com/Wandalen/wModuleForTesting2a.git/` ) );
    test.is( _.strHas( got.output, 'Failed to download module' ) );
    test.is( !a.fileProvider.fileExists( downloadPath ) )
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'error on download, existing empty directory should be preserved';
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    a.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.startNonThrowing({ execPath : '.with bad .submodules.download' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `fatal: unable to access 'https://githu.com/Wandalen/wModuleForTesting2a.git/` ) );
    test.is( _.strHas( got.output, 'Failed to download module' ) );
    test.is( a.fileProvider.fileExists( downloadPath ) )
    test.identical( a.fileProvider.dirRead( downloadPath ), [] );
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'no error if download path exists and its an empty dir';
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    a.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.startNonThrowing({ execPath : '.with good .submodules.download' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, 'Failed to download module' ) );
    test.is( _.strHas( got.output, 'module::wModuleForTesting2a was downloaded version master in' ) );
    test.is( _.strHas( got.output, '1/1 submodule(s) of module::submodules-download-errors-good were downloaded' ) );

    let files = self.find( downloadPath );
    // test.gt( files.length, 10 );
    test.ge( files.length, 1 );

    return null;
  })

  //

  .then( () =>
  {
    test.case = 'error if download path exists and it is not a empty dir';
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    a.fileProvider.dirMake( downloadPath );
    a.fileProvider.fileWrite( filePath, filePath );
    return null;
  })
  a.startNonThrowing({ execPath : '.with bad .submodules.download' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `Module module::submodules-download-errors-bad / opener::ModuleForTesting2a is downloaded, but it's not a git repository` ) );
    test.is( _.strHas( got.output, 'Failed to download module' ) );
    test.is( a.fileProvider.fileExists( downloadPath ) )
    test.identical( a.fileProvider.dirRead( downloadPath ), [ 'file' ] );
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'error if download path exists and its terminal';
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    a.fileProvider.fileWrite( downloadPath, downloadPath );
    return null;
  })
  a.startNonThrowing({ execPath : '.with bad .submodules.download' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `Module module::submodules-download-errors-bad / opener::ModuleForTesting2a is not downloaded, but file at` ) );
    test.is( _.strHas( got.output, 'Failed to download module' ) );
    test.is( a.fileProvider.isTerminal( downloadPath ) )
    return null;
  })

  //

  // .then( () =>
  // {
  //   test.case = 'no error if download path exists and it has other git repo';
  //   a.fileProvider.filesDelete( a.abs( '.module' ) );
  //   a.fileProvider.dirMake( downloadPath );
  //   return null;
  // })
  .then( () =>
  {
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    return null;
  })
  a.startNonThrowing2({ execPath : 'git clone https://github.com/Wandalen/wModuleForTesting1.git .module/ModuleForTesting2a' })
  .then( () =>
  {
    filesBefore = self.find( downloadPath );
    return null;
  })
  a.startNonThrowing({ execPath : '.with good .submodules.download' })
  .then( ( got ) =>
  {
    debugger;
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '0/1 submodule(s) of module::submodules-download-errors-good were downloaded' ) );
    test.is( a.fileProvider.fileExists( downloadPath ) )
    let filesAfter = self.find( downloadPath );
    test.identical( filesAfter, filesBefore );

    return null;
  })

  //

  a.ready
  .then( () =>
  {
    test.case = 'downloaded, change in file to make module not valid, error expected';
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    a.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.startNonThrowing({ execPath : '.with good .submodules.download' })
  .then( () =>
  {
    let inWillFilePath = a.path.join( downloadPath, '.im.will.yml' );
    let inWillFile = a.fileProvider.configRead( inWillFilePath );
    inWillFile.section = { field : 'value' };
    a.fileProvider.fileWrite({ filePath : inWillFilePath, data : inWillFile,encoding : 'yml' });
    return null;
  })
  .then( () =>
  {
    filesBefore = self.find( downloadPath );
    return null;
  })
  a.startNonThrowing({ execPath : '.with good .submodules.download' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Willfile should not have section(s) : "section"' ) );
    let filesAfter = self.find( downloadPath );
    test.identical( filesAfter, filesBefore )
    return null;
  })

  /* - */

  return a.ready;
}

submodulesDownloadThrowing.timeOut = 300000;

//

function submodulesDownloadStepAndCommand( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-download' );
  a.startNonThrowing2 = _.process.starter
  ({
    currentPath : a.abs( 'module' ),
    outputCollecting : 1,
    outputGraying : 1,
    throwingExitCode : 0,
    ready : a.ready,
  })
  a.reflect();

  /* submodules.download step downloads submodules recursively, but should not */

  a.ready

  .then( () =>
  {
    test.case = 'download using step::submodules.download'
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    return null;
  })
  a.startNonThrowing2( 'git init' )
  a.startNonThrowing2( 'git add .' )
  a.startNonThrowing2( 'git commit -m init' )
  a.startNonThrowing({ execPath : '.build' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    let files = self.find( a.abs( '.module' ) );
    test.is( !_.longHas( files, './ModuleForTesting1' ) )
    test.is( !_.longHas( files, './ModuleForTesting2a' ) )
    test.is( _.longHas( files, './submodule' ) )
    return null;
  })

  /* submodules.download command downloads only own submodule, as expected */

  .then( () =>
  {
    test.case = 'download using command submodules.download'
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    return null;
  })
  a.startNonThrowing2( 'git init' )
  a.startNonThrowing2( 'git add .' )
  a.startNonThrowing2( 'git commit -m init' )
  a.startNonThrowing({ execPath : '.submodules.download' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    let files = self.find( a.abs( '.module' ) );
    test.is( !_.longHas( files, './ModuleForTesting1' ) )
    test.is( !_.longHas( files, './ModuleForTesting2a' ) )
    test.is( _.longHas( files, './submodule' ) )
    return null;
  })

  /*  */

  return a.ready;
}

//

function submodulesDownloadDiffDownloadPathsRegular( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-diff-download-paths-regular' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with c .submodules.download';
    a.reflect();
    return null;
  })

  a.start( '.with c .clean recursive:2' )
  a.start( '.with c .submodules.download' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( 'a/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 4 );
    test.identical( _.strCount( got.output, '. Opened .' ), 20 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 4 );
    test.identical( _.strCount( got.output, '+ 4/5 submodule(s) of module::c were downloaded' ), 1 );

    return null;
  })

  a.start( '.with c .submodules.download' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( 'a/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 20 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/5 submodule(s) of module::c were downloaded' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with c .submodules.download recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with c .clean recursive:2' )
  a.start( '.with c .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( 'a/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 4 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 6 );
    test.identical( _.strCount( got.output, '+ 6/7 submodule(s) of module::c were downloaded' ), 1 );

    return null;
  })

  a.start( '.with c .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( 'a/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/7 submodule(s) of module::c were downloaded' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function submodulesDownloadDiffDownloadPathsRegular */

submodulesDownloadDiffDownloadPathsRegular.timeOut = 300000;

//

function submodulesDownloadDiffDownloadPathsIrregular( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-diff-download-paths-irregular' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with c .submodules.download';
    a.reflect();
    return null;
  })

  a.start( '.with c .clean recursive:2' )
  a.start( '.with c .submodules.download' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting12', 'ModuleForTesting12ab', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12', 'ModuleForTesting12ab', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( 'a/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 4 );
    test.identical( _.strCount( got.output, '. Opened .' ), 32 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 4 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 4 );
    test.identical( _.strCount( got.output, '+ 4/5 submodule(s) of module::c were downloaded' ), 1 );

    return null;
  })

  a.start( '.with c .submodules.download' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting12', 'ModuleForTesting12ab', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12', 'ModuleForTesting12ab', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( 'a/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 32 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/5 submodule(s) of module::c were downloaded' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with c .submodules.download recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with c .clean recursive:2' )
  a.start( '.with c .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting12', 'ModuleForTesting12ab', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12', 'ModuleForTesting12ab', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( 'a/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 4 );
    test.identical( _.strCount( got.output, '. Opened .' ), 32 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 4 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 4 );
    test.identical( _.strCount( got.output, '+ 4/5 submodule(s) of module::c were downloaded' ), 1 );

    return null;
  })

  a.start( '.with c .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting12', 'ModuleForTesting12ab', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12', 'ModuleForTesting12ab', 'ModuleForTesting1a', 'ModuleForTesting2' ];
    var files = a.fileProvider.dirRead( a.abs( 'a/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 32 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/5 submodule(s) of module::c were downloaded' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function submodulesDownloadDiffDownloadPathsIrregular */

submodulesDownloadDiffDownloadPathsIrregular.timeOut = 300000;

//

function submodulesDownloadHierarchyRemote( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-remote' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with z .submodules.download';
    a.reflect();
    return null;
  })

  a.start( '.with z .clean recursive:2' )
  a.start( '.with z .submodules.download' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 1 );
    test.identical( _.strCount( got.output, '. Opened .' ), 14 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 1 );
    test.identical( _.strCount( got.output, '+ 1/4 submodule(s) of module::z were downloaded' ), 1 );

    return null;
  })

  a.start( '.with z .submodules.download' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = null;
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 14 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/4 submodule(s) of module::z were downloaded' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with z .submodules.download recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with z .clean recursive:2' )
  a.start( '.with z .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 1 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 5 );
    test.identical( _.strCount( got.output, '+ 5/9 submodule(s) of module::z were downloaded' ), 1 );

    return null;
  })

  a.start( '.with z .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/9 submodule(s) of module::z were downloaded' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .submodules.download recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with z .clean recursive:2' )
  a.start( '.with ** .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 1 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 2 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 5 );
    test.identical( _.strCount( got.output, '+ 5/9 submodule(s) of module::z were downloaded' ), 1 );

    return null;
  })

  a.start( '.with z .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1b' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting12', 'ModuleForTesting1a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1b', 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/group10/.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting12ab' ];
    var files = a.fileProvider.dirRead( a.abs( 'group2/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 26 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/9 submodule(s) of module::z were downloaded' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function submodulesDownloadHierarchyRemote */

submodulesDownloadHierarchyRemote.timeOut = 300000;

//

function submodulesDownloadHierarchyDuplicate( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-duplicate' );

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with z .submodules.download';
    a.reflect();
    return null;
  })

  a.start( '.with z .clean recursive:2' )
  a.start( '.with z .submodules.download' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 1 );
    test.identical( _.strCount( got.output, '. Opened .' ), 8 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 1 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 1 );
    test.identical( _.strCount( got.output, '+ 1/2 submodule(s) of module::z were downloaded' ), 1 );
    test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );

    return null;
  })

  a.start( '.with z .submodules.download' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 8 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z were downloaded' ), 1 );
    test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with z .submodules.download recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with z .clean recursive:2' )
  a.start( '.with z .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 1 );
    test.identical( _.strCount( got.output, '. Opened .' ), 8 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 1 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 1 );
    test.identical( _.strCount( got.output, '+ 1/2 submodule(s) of module::z were downloaded' ), 1 );
    test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );

    return null;
  })

  a.start( '.with z .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 8 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z were downloaded' ), 1 );
    test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );

    return null;
  })

  /* - */

  a.ready

  .then( () =>
  {
    test.case = '.with ** .submodules.download recursive:2';
    a.reflect();
    return null;
  })

  a.start( '.with z .clean recursive:2' )
  a.start( '.with ** .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );


    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 1 );
    test.identical( _.strCount( got.output, '. Opened .' ), 8 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 1 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 1 );
    test.identical( _.strCount( got.output, '+ 1/2 submodule(s) of module::z were downloaded' ), 1 );
    test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );

    return null;
  })

  a.start( '.with z .submodules.download recursive:2' )

  .then( ( got ) =>
  {
    test.case = 'second';
    test.identical( got.exitCode, 0 );


    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    var exp = [ 'ModuleForTesting1' ];
    var files = a.fileProvider.dirRead( a.abs( 'group1/.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 8 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/2 submodule(s) of module::z were downloaded' ), 1 );
    test.identical( _.strCount( got.output, 'submodule(s)' ), 1 );

    return null;
  })

  /* - */

  return a.ready;

} /* end of function submodulesDownloadHierarchyDuplicate */

submodulesDownloadHierarchyDuplicate.timeOut = 300000;

//

function submodulesDownloadNpm( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-download-npm' );
  let versions = {}
  let willFilePath = a.abs( '.will.yml' )
  let filesBefore = null;

  /* - */

  a.ready

  .then( () =>
  {
    versions[ 'ModuleForTesting1' ] = _.npm.versionRemoteRetrive( 'npm:///wmodulefortesting1' );
    versions[ 'ModuleForTesting2a' ] = _.npm.versionRemoteRetrive( 'npm:///wmodulefortesting2a@alpha' );
    versions[ 'ModuleForTesting12ab' ] = _.npm.versionRemoteCurrentRetrive( 'npm:///wmodulefortesting12ab#0.0.31' );

    a.reflect();

    return null;
  })

  /* */

  a.start( '.submodules.download' )

  .then( ( got ) =>
  {
    test.case = 'download npm modules';

    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting1.will.yml', 'ModuleForTesting12ab', 'ModuleForTesting12ab.will.yml', 'ModuleForTesting2a', 'ModuleForTesting2a.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 3 );
    test.identical( _.strCount( got.output, '. Opened .' ), 7 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 3 );
    test.identical( _.strCount( got.output, '+ 3/3 submodule(s) of module::supermodule were downloaded' ), 1 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was downloaded version ${versions['ModuleForTesting1']}` ), 1 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was downloaded version ${versions['ModuleForTesting2a']}` ), 1 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was downloaded version ${versions['ModuleForTesting12ab']}` ), 1 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 2 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 1 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 1 );

    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( version, versions[ 'ModuleForTesting1' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting12ab' ) );
    test.identical( version, versions[ 'ModuleForTesting12ab' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting2a' ) );
    test.identical( version, versions[ 'ModuleForTesting2a' ] )

    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1/ModuleForTesting1.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12ab/ModuleForTesting12ab.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a/ModuleForTesting2a.out.will.yml' ) ) )

    return null;
  })

  /*  */

  a.start( '.submodules.download' )

  .then( ( got ) =>
  {
    test.case = 'second run of .submodules.download';

    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting1.will.yml', 'ModuleForTesting12ab', 'ModuleForTesting12ab.will.yml', 'ModuleForTesting2a', 'ModuleForTesting2a.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 7 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'was downloaded' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/3 submodule(s) of module::supermodule were downloaded' ), 1 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was downloaded version ${versions['ModuleForTesting1']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was downloaded version ${versions['ModuleForTesting2a']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was downloaded version ${versions['ModuleForTesting12ab']}` ), 0 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 0 );

    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( version, versions[ 'ModuleForTesting1' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting12ab' ) );
    test.identical( version, versions[ 'ModuleForTesting12ab' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting2a' ) );
    test.identical( version, versions[ 'ModuleForTesting2a' ] )

    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1/ModuleForTesting1.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12ab/ModuleForTesting12ab.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a/ModuleForTesting2a.out.will.yml' ) ) )

    return null;
  })

  /*  */

  .then( () =>
  {
    test.case = 'change origin of first submodule and run .submodules.download';

    let willFile = a.fileProvider.fileRead( willFilePath );
    willFile = _.strReplace( willFile, 'npm:///wmodulefortesting1 ', 'npm:///wmodulefortesting2b' );
    a.fileProvider.fileWrite( willFilePath, willFile );

    filesBefore = self.find( a.abs( '.module/ModuleForTesting1' ) );

    return null;
  })

  a.start( '.submodules.download' )

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting1.will.yml', 'ModuleForTesting12ab', 'ModuleForTesting12ab.will.yml', 'ModuleForTesting2a', 'ModuleForTesting2a.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 7 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/3 submodule(s) of module::supermodule were downloaded' ), 1 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was downloaded version ${versions['ModuleForTesting1']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was downloaded version ${versions['ModuleForTesting2a']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was downloaded version ${versions['ModuleForTesting12ab']}` ), 0 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 0 );

    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( version, versions[ 'ModuleForTesting1' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting12ab' ) );
    test.identical( version, versions[ 'ModuleForTesting12ab' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting2a' ) );
    test.identical( version, versions[ 'ModuleForTesting2a' ] )

    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1/ModuleForTesting1.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12ab/ModuleForTesting12ab.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a/ModuleForTesting2a.out.will.yml' ) ) )

    var files = self.find( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( files,filesBefore );

    return null;
  })
  .then( () =>
  {
    let willFile = a.fileProvider.fileRead( willFilePath );
    willFile = _.strReplace( willFile, 'npm:///wmoduleforTesting2b', 'npm:///wmodulefortesting1' );
    a.fileProvider.fileWrite( willFilePath, willFile );

    return null;
  })

  /*  */

  return a.ready;
}

submodulesDownloadNpm.timeOut = 300000;

//

function submodulesDownloadUpdateNpm( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-download-npm' );
  let versions = {}
  let willFilePath = a.abs( '.will.yml' );
  let filesBefore = null;

  /* - */

  a.ready

  .then( () =>
  {
    versions[ 'ModuleForTesting1' ] = _.npm.versionRemoteRetrive( 'npm:///wmodulefortesting1' );
    versions[ 'ModuleForTesting2a' ] = _.npm.versionRemoteRetrive( 'npm:///wmodulefortesting2a@alpha' );
    versions[ 'ModuleForTesting12ab' ] = _.npm.versionRemoteCurrentRetrive( 'npm:///wmodulefortesting12ab#0.0.31' );

    a.reflect();

    return null;
  })

  /* */

  a.start( '.submodules.update' )

  .then( ( got ) =>
  {
    test.case = 'download npm modules';

    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting1.will.yml', 'ModuleForTesting12ab', 'ModuleForTesting12ab.will.yml', 'ModuleForTesting2a', 'ModuleForTesting2a.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 3 );
    test.identical( _.strCount( got.output, '. Opened .' ), 7 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'were updated' ), 1 );
    test.identical( _.strCount( got.output, '+ 3/3 submodule(s) of module::supermodule were updated' ), 1 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was updated to version ${versions['ModuleForTesting1']}` ), 1 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was updated to version ${versions['ModuleForTesting2a']}` ), 1 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was updated to version ${versions['ModuleForTesting12ab']}` ), 1 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 2 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 1 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 1 );

    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( version, versions[ 'ModuleForTesting1' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting12ab' ) );
    test.identical( version, versions[ 'ModuleForTesting12ab' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting2a' ) );
    test.identical( version, versions[ 'ModuleForTesting2a' ] )

    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1/ModuleForTesting1.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12ab/ModuleForTesting12ab.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a/ModuleForTesting2a.out.will.yml' ) ) )

    return null;
  })

  /*  */

  .then( ( got ) =>
  {
    let willFile = a.fileProvider.fileRead( willFilePath );
    willFile = _.strReplace( willFile, '@alpha', '@beta' );
    willFile = _.strReplace( willFile, '@0.0.31', '@0.0.32 ' ); /* Dmytro : need to test writer, it appends zero to last number */
    a.fileProvider.fileWrite( willFilePath, willFile );

    versions[ 'ModuleForTesting2a' ] = _.npm.versionRemoteRetrive( 'npm:///wmodulefortesting2a@beta' );
    versions[ 'ModuleForTesting12ab' ] = '0.0.32'

    return null;
  })

  a.start( '.submodules.update' )

  .then( ( got ) =>
  {
    test.case = 'second run of .submodules.update';

    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting1.will.yml', 'ModuleForTesting12ab', 'ModuleForTesting12ab.will.yml', 'ModuleForTesting2a', 'ModuleForTesting2a.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 11 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'were updated' ), 1 );
    test.identical( _.strCount( got.output, '+ 2/3 submodule(s) of module::supermodule were updated' ), 1 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was updated to version ${versions['ModuleForTesting1']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was updated to version ${versions['ModuleForTesting2a']}` ), 1 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was updated to version ${versions['ModuleForTesting12ab']}` ), 1 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 1 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 1 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 1 );

    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( version, versions[ 'ModuleForTesting1' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting12ab' ) );
    test.identical( version, versions[ 'ModuleForTesting12ab' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting2a' ) );
    test.identical( version, versions[ 'ModuleForTesting2a' ] )

    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1/ModuleForTesting1.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12ab/ModuleForTesting12ab.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a/ModuleForTesting2a.out.will.yml' ) ) )

    return null;
  })

  /*  */

  a.start( '.submodules.update' )

  .then( ( got ) =>
  {
    test.case = 'third run of .submodules.update';

    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting1.will.yml', 'ModuleForTesting12ab', 'ModuleForTesting12ab.will.yml', 'ModuleForTesting2a', 'ModuleForTesting2a.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 7 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'were updated' ), 1 );
    test.identical( _.strCount( got.output, '+ 0/3 submodule(s) of module::supermodule were updated' ), 1 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was updated to version ${versions['ModuleForTesting1']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was updated to version ${versions['ModuleForTesting2a']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was updated to version ${versions['ModuleForTesting12ab']}` ), 0 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 0 );

    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( version, versions[ 'ModuleForTesting1' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting12ab' ) );
    test.identical( version, versions[ 'ModuleForTesting12ab' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting2a' ) );
    test.identical( version, versions[ 'ModuleForTesting2a' ] )

    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1/ModuleForTesting1.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12ab/ModuleForTesting12ab.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a/ModuleForTesting2a.out.will.yml' ) ) )

    return null;
  })

  /*  */

  .then( () =>
  {
    test.case = 'change origin of first submodule and run .submodules.update';

    let willFile = a.fileProvider.fileRead( willFilePath );
    willFile = _.strReplace( willFile, 'npm:///wmodulefortesting1', 'npm:///wmodulefortesting2b' );
    a.fileProvider.fileWrite( willFilePath, willFile );

    filesBefore = self.find( a.abs( '.module' ) );

    return null;
  })

  a.startNonThrowing( '.submodules.update' )

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 1 );

    var files = self.find( a.abs( '.module' ) );
    test.identical( files,filesBefore );

    test.identical( _.strCount( got.output, 'opener::ModuleForTesting1 is already downloaded, but has different origin url: wmodulefortesting1 , expected url: wmodulefortesting2b' ), 1 );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 7 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/3 submodule(s) of module::supermodule were updated' ), 0 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was updated to version ${versions['ModuleForTesting1']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was updated to version ${versions['ModuleForTesting2a']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was updated to version ${versions['ModuleForTesting12ab']}` ), 0 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 0 );

    return null;
  })

  .then( () =>
  {
    let willFile = a.fileProvider.fileRead( willFilePath );
    willFile = _.strReplace( willFile, 'npm:///wmoduleforTesting2b', 'npm:///wmodulefortesting1' );
    a.fileProvider.fileWrite( willFilePath, willFile );
    return null;
  })

  return a.ready;
}

submodulesDownloadUpdateNpm.timeOut = 300000;

//

function submodulesUpdateThrowing( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-download-errors' );
  let submodulesPath = _.path.join( a.routinePath, '.module' );
  let downloadPath = _.path.join( a.routinePath, '.module/ModuleForTesting2a' );
  let filePath = _.path.join( downloadPath, 'file' );
  let filesBefore;
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    throwingExitCode : 0,
    mode : 'spawn',
    ready : a.ready,
  });
  a.startNonThrowing = _.process.starter
  ({
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    throwingExitCode : 0,
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = 'error on update, new directory should not be made';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })
  a.start({ execPath : '.with bad .submodules.update' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `fatal: unable to access 'https://githu.com/Wandalen/wModuleForTesting2a.git/` ) );
    test.is( _.strHas( got.output, 'Failed to update module' ) );

    test.is( !_.fileProvider.fileExists( downloadPath ) )
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'error on update, existing empty directory should be preserved';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.start({ execPath : '.with bad .submodules.update' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `fatal: unable to access 'https://githu.com/Wandalen/wModuleForTesting2a.git/` ) );
    test.is( _.strHas( got.output, 'Failed to update module' ) );
    test.is( _.fileProvider.fileExists( downloadPath ) )
    test.identical( _.fileProvider.dirRead( downloadPath ), [] );
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'no error if download path exists and its an empty dir';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.update' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, 'Failed to download update' ) );
    test.is( _.strHas( got.output, 'module::wModuleForTesting2a was updated to version master in' ) );
    test.is( _.strHas( got.output, '1/1 submodule(s) of module::submodules-download-errors-good were updated in' ) );

    let files = self.find( downloadPath );
    test.ge( files.length, 1 );

    return null;
  })

  //

  .then( () =>
  {
    test.case = 'error if download path exists and it is not a empty dir';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    _.fileProvider.fileWrite( filePath,filePath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.update' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `Module module::submodules-download-errors-good / opener::ModuleForTesting2a is downloaded, but it's not a git repository` ) );
    test.is( _.strHas( got.output, 'Failed to update module' ) );
    test.is( _.fileProvider.fileExists( downloadPath ) )
    test.identical( _.fileProvider.dirRead( downloadPath ), [ 'file' ] );
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'error if download path exists and its terminal';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.fileWrite( downloadPath,downloadPath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.update' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Module module::submodules-download-errors-good / opener::ModuleForTesting2a is not downloaded, but file at' ) );
    test.is( _.strHas( got.output, 'Failed to update submodules' ) );
    test.is( _.fileProvider.isTerminal( downloadPath ) )
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'error if download path exists and it has other git repo, repo should be preserved';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.startNonThrowing({ execPath : 'git clone https://github.com/Wandalen/wModuleForTesting1.git .module/ModuleForTesting2a' })
  .then( () =>
  {
    filesBefore = self.find( downloadPath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.update' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'opener::ModuleForTesting2a is already downloaded, but has different origin url') );
    test.is( _.strHas( got.output, 'Failed to update submodules' ) );
    test.is( _.fileProvider.fileExists( downloadPath ) )
    let filesAfter = self.find( downloadPath );
    test.identical( filesBefore.length, filesAfter.length );

    return null;
  })

  //

  a.ready
  .then( () =>
  {
    test.case = 'downloaded, change in file to make module not valid, error expected';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.update' })
  .then( () =>
  {
    let inWillFilePath = _.path.join( downloadPath, '.im.will.yml' );
    let inWillFile = _.fileProvider.configRead( inWillFilePath );
    inWillFile.section = { field : 'value' };
    _.fileProvider.fileWrite({ filePath : inWillFilePath, data : inWillFile, encoding : 'yml' });
    return null;
  })
  .then( () =>
  {
    filesBefore = self.find( downloadPath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.update' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Willfile should not have section(s) : "section"' ) );
    let filesAfter = self.find( downloadPath );
    test.identical( filesAfter, filesBefore )
    return null;
  })

  /* - */

  return a.ready;
}

submodulesUpdateThrowing.timeOut = 300000;

//

function submodulesAgreeThrowing( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-download-errors' );
  let submodulesPath = _.path.join( a.routinePath, '.module' );
  let downloadPath = _.path.join( a.routinePath, '.module/ModuleForTesting2a' );
  let filePath = _.path.join( downloadPath, 'file' );
  let filesBefore;
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    throwingExitCode : 0,
    mode : 'spawn',
    ready : a.ready,
  });
  a.startNonThrowing = _.process.starter
  ({
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    throwingExitCode : 0,
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.ready

  .then( () =>
  {
    test.case = 'error on agree, new directory should not be made';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })
  a.start({ execPath : '.with bad .submodules.versions.agree' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Failed to agree module' ) );
    test.is( !_.fileProvider.fileExists( downloadPath ) )
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'error on download, existing empty directory will be deleted ';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.start({ execPath : '.with bad .submodules.versions.agree' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Failed to agree module' ) );
    test.is( !_.fileProvider.fileExists( downloadPath ) );
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'existing empty directory will be deleted ';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.versions.agree' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, 'Failed to agree module' ) );
    test.is( _.strHas( got.output, 'module::wModuleForTesting2a was agreed with version master' ) );
    test.is( _.strHas( got.output, '1/1 submodule(s) of module::submodules-download-errors-good were agreed' ) );
    let files = self.find( downloadPath );
    test.gt( files.length, 10 );

    return null;
  })

  //

  .then( () =>
  {
    test.case = 'error on download, dir with terminal at download path, download path will be deleted';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    _.fileProvider.fileWrite( filePath,filePath );
    return null;
  })
  a.start({ execPath : '.with bad .submodules.versions.agree' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Failed to agree module' ) );
    test.is( !_.fileProvider.fileExists( downloadPath ) );

    return null;
  })

  //

  .then( () =>
  {
    test.case = 'dir with terminal at download path, download path will be deleted';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    _.fileProvider.fileWrite( filePath,filePath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.versions.agree' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, 'Failed to agree module' ) );
    test.is( _.strHas( got.output, 'module::wModuleForTesting2a was agreed with version master' ) );
    test.is( _.strHas( got.output, '1/1 submodule(s) of module::submodules-download-errors-good were agreed' ) );
    let files = self.find( downloadPath );
    test.gt( files.length, 10 );

    return null;
  })

  //

  .then( () =>
  {
    test.case = 'error on download, download path exists and its terminal, file will be removed';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.fileWrite( downloadPath,downloadPath );
    return null;
  })
  a.start({ execPath : '.with bad .submodules.versions.agree' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Failed to agree module' ) );
    test.is( !_.fileProvider.fileExists( downloadPath ) );
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'download path exists and its terminal, file will be removed';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.fileWrite( downloadPath,downloadPath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.versions.agree' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, 'Failed to agree module' ) );
    test.is( _.strHas( got.output, 'module::wModuleForTesting2a was agreed with version master' ) );
    test.is( _.strHas( got.output, '1/1 submodule(s) of module::submodules-download-errors-good were agreed in' ) );
    let files = self.find( downloadPath );
    test.gt( files.length, 10 );
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'donwloaded repo has different origin, should be deleted and downloaded again';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.startNonThrowing({ execPath : 'git clone https://github.com/Wandalen/wModuleForTesting1.git .module/ModuleForTesting2a' })
  a.start({ execPath : '.with good .submodules.versions.agree' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '1/1 submodule(s) of module::submodules-download-errors-good were agreed' ) );
    test.is( _.fileProvider.fileExists( downloadPath ) )
    let files = self.find( downloadPath );
    test.gt( files.length, 10 );

    return null;
  })



  .then( () =>
  {
    test.case = 'donwloaded repo has uncommitted change, error expected';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.versions.agree' })
  a.startNonThrowing( 'git -C .module/ModuleForTesting2a reset --hard HEAD~1' )
  .then( () =>
  {
    _.fileProvider.fileWrite( _.path.join( downloadPath, 'was.package.json' ), 'was.package.json' );
    return null;
  })
  a.start({ execPath : '.with good .submodules.versions.agree' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Module at module::submodules-download-errors-good / opener::ModuleForTesting2a needs to be updated, but has local changes' ) );
    test.is( _.strHas( got.output, 'Failed to agree module::submodules-download-errors-good / opener::ModuleForTesting2a' ) );
    return null;
  })

  //

  .then( () =>
  {
    test.case = 'donwloaded repo has unpushed change and wrong origin, error expected';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    return null;
  })
  a.start({ execPath : '.with good .submodules.versions.agree' })
  a.startNonThrowing( 'git -C .module/ModuleForTesting2a reset --hard HEAD~1' )
  a.startNonThrowing( 'git -C .module/ModuleForTesting2a commit -m unpushed --allow-empty' )
  a.startNonThrowing( 'git -C .module/ModuleForTesting2a remote remove origin' )
  a.startNonThrowing( 'git -C .module/ModuleForTesting2a remote add origin https://github.com/Wandalen/wModuleForTesting1.git' )
  a.start({ execPath : '.with good .submodules.versions.agree' })
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'needs to be deleted, but has local changes' ) );
    test.is( _.strHas( got.output, 'Failed to agree module::submodules-download-errors-good / opener::ModuleForTesting2a' ) );
    return null;
  })

  /* - */

  return a.ready;
}

submodulesAgreeThrowing.timeOut = 300000;

//

function submodulesVersionsAgreeWrongOrigin( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-download-errors' );
  let submodulesPath = _.path.join( a.routinePath, '.module' );
  let downloadPath = _.path.join( a.routinePath, '.module/ModuleForTesting2a' );
  let filePath = _.path.join( downloadPath, 'file' );
  a.startNonThrowing2 = _.process.starter
  ({
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    throwingExitCode : 0,
    ready : a.ready,
  });
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'donwloaded repo has different origin, should be deleted and downloaded again';
    _.fileProvider.filesDelete( submodulesPath );
    _.fileProvider.dirMake( downloadPath );
    return null;
  })

  a.startNonThrowing2({ execPath : 'git clone https://github.com/Wandalen/wModuleForTesting1.git .module/ModuleForTesting2a' })
  a.startNonThrowing({ execPath : '.with good .submodules.versions.agree' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 1/1 submodule(s) of module::submodules-download-errors-good were agreed' ) );
    test.is( _.fileProvider.fileExists( downloadPath ) )
    let files = self.find( downloadPath );
    test.gt( files.length, 10 );

    return null;
  })

  /* - */

  return a.ready;
}

submodulesVersionsAgreeWrongOrigin.timeOut = 300000;

//

/*
  Informal module has submodule willbe-experiment@master
  Supermodule has informal module and willbe-experiment#dev in submodules list
  First download of submodules works fine.
  After updating submodules of supermodule, branch dev of willbe-experiment is changed to master.
  This is wrong, because willbe-experiment should stay on branch dev as its defined in willfile of supermodule.
*/

function submodulesDownloadedUpdate( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-downloaded-update' );
  a.reflect();

//   let self = this;
//   let originalAssetPath = _.path.join( self.assetsOriginalPath, 'submodules-downloaded-update' );
//   let routinePath = _.path.join( self.suiteTempPath, test.name );
//   let abs = self.abs_functor( routinePath );
//   let rel = self.rel_functor( routinePath );
//   let submodulesPath = _.path.join( routinePath, '.module' );
//
//
//   let ready = new _.Consequence().take( null )
//   let start = _.process.starter
//   ({
//     execPath : 'node ' + self.willPath,
//     currentPath : routinePath,
//     outputCollecting : 1,
//     outputGraying : 1,
//     ready : ready,
//   })
//
//   _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

  /* */

  a.ready
  .then( () =>
  {
    test.case = 'setup';
    return null;
  })

  a.start({ execPath : '.each module .export' })
  a.start({ execPath : '.submodules.download' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ 1\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );
    return got;
  })

  /* */

  .then( () =>
  {
    test.case = 'check module branch after download';
    return null;
  })

  _.process.start
  ({
    execPath : 'git -C .module/willbe-experiment rev-parse --abbrev-ref HEAD',
    currentPath : a.routinePath,
    ready : a.ready,
    outputCollecting : 1,
    outputGraying : 1,
  })

  .then( ( got ) =>
  {
    test.will = 'submodule of supermodule should stay on dev';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'dev' ) );
    return got;
  })

  _.process.start
  ({
    execPath : 'git -C module/.module/willbe-experiment rev-parse --abbrev-ref HEAD',
    currentPath : a.routinePath,
    ready : a.ready,
    outputCollecting : 1,
    outputGraying : 1,
  })

  .then( ( got ) =>
  {
    test.will = 'submodule of informal submodule should stay on master';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'master' ) );
    return got;
  })

  /* */

  .then( ( got ) =>
  {
    test.case = 'update downloaded module and check branch';
    return got;
  })

  a.start({ execPath : '.submodules.update' })

  _.process.start
  ({
    execPath : 'git -C .module/willbe-experiment rev-parse --abbrev-ref HEAD',
    currentPath : a.routinePath,
    ready : a.ready,
    outputCollecting : 1,
    outputGraying : 1,
  })

  .then( ( got ) =>
  {
    test.will = 'submodule of supermodule should stay on dev';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'dev' ) );
    return got;
  })

  _.process.start
  ({
    execPath : 'git -C module/.module/willbe-experiment rev-parse --abbrev-ref HEAD',
    currentPath : a.routinePath,
    ready : a.ready,
    outputCollecting : 1,
    outputGraying : 1,
  })

  .then( ( got ) =>
  {
    test.will = 'submodule of informal submodule should stay on master';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'master' ) );
    return got;
  })

  return a.ready;
}

//

function subModulesUpdate( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-update' );
  a.reflect();

//   let self = this;
//   let originalAssetPath = _.path.join( self.assetsOriginalPath, 'submodules-update' );
//   let routinePath = _.path.join( self.suiteTempPath, test.name );
//   let abs = self.abs_functor( routinePath );
//   let rel = self.rel_functor( routinePath );
//   let submodulesPath = _.path.join( routinePath, '.module' );
//
//
//   let ready = new _.Consequence().take( null )
//   let start = _.process.starter
//   ({
//     execPath : 'node ' + self.willPath,
//     currentPath : routinePath,
//     outputCollecting : 1,
//     outputGraying : 1,
//     ready : ready,
//   })
//
//   _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

  /* */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.update';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.submodules.update' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ module::wModuleForTesting1 was updated to version 64c96412c81266f119210e7af71e300cce5b2ebd in' ) );
    test.is( _.strHas( got.output, '+ module::wModuleForTesting2a was updated to version master in' ) );
    test.is( _.strHas( got.output, '+ module::wModuleForTesting12ab was updated to version b3499c8f6756cad511bb42559e6c3d501ed15061 in' ) );
    test.is( _.strHas( got.output, '+ 3/3 submodule(s) of module::submodules were updated in' ) );
    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.update -- second';
    return null;
  })

  a.start({ execPath : '.submodules.update' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, /module::ModuleForTesting1/ ) );
    test.is( !_.strHas( got.output, /module::ModuleForTesting2a/ ) );
    test.is( !_.strHas( got.output, /module::ModuleForTesting12ab/ ) );
    test.is( _.strHas( got.output, '+ 0/3 submodule(s) of module::submodules were updated in' ) );
    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.update -- after patch';
    var read = _.fileProvider.fileRead( _.path.join( a.routinePath, '.im.will.yml' ) );
    read = _.strReplace( read, '#64c96412c81266f119210e7af71e300cce5b2ebd', '@master' )
    _.fileProvider.fileWrite( _.path.join( a.routinePath, '.im.will.yml' ), read );
    return null;
  })

  a.start({ execPath : '.submodules.update' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    // test.is( _.strHas( got.output, / \+ .*module::Tools.* was updated to version .*master.* in/ ) );
    test.is( !_.strHas( got.output, /module::ModuleForTesting2a/ ) );
    test.is( !_.strHas( got.output, /module::ModuleForTesting12ab/ ) );
    test.is( _.strHas( got.output, '+ 1/3 submodule(s) of module::submodules were updated in' ) );
    return null;
  })

  /* */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.update -- second';
    return null;
  })

  a.start({ execPath : '.submodules.update' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, /module::ModuleForTesting1/ ) );
    test.is( !_.strHas( got.output, /module::ModuleForTesting2a/ ) );
    test.is( !_.strHas( got.output, /module::ModuleForTesting12ab/ ) );
    test.is( _.strHas( got.output, '+ 0/3 submodule(s) of module::submodules were updated in' ) );
    return null;
  })

  /* */

  return a.ready;
}

subModulesUpdate.timeOut = 300000;

//

function subModulesUpdateSwitchBranch( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-update-switch-branch' );
  let submodulesPath = a.abs( '.module' );
  let willfilePath = a.abs( '.will.yml' );
  let experimentModulePath = _.path.join( submodulesPath, 'willbe-experiment' );
  let detachedVersion;

  /* */

  begin()

  .then( () =>
  {
    test.case = 'download master branch';
    return null;
  })

  a.start({ execPath : '.submodules.update' })

  .then( () =>
  {
    let currentVersion = a.fileProvider.fileRead( _.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })

  .then( () =>
  {
    test.case = 'switch master to dev';
    let willFile = a.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule[ 'willbe-experiment' ]= _.strReplaceAll( willFile.submodule[ 'willbe-experiment' ], '@master', '@dev' );
    a.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    return null;
  })

  a.start({ execPath : '.submodules.update' })

  .then( () =>
  {
    let currentVersion = a.fileProvider.fileRead( _.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/dev' ) );
    return null;
  })

  .then( () =>
  {
    test.case = 'switch dev to detached state';
    let willFile = a.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule[ 'willbe-experiment' ] = _.strReplaceAll( willFile.submodule[ 'willbe-experiment' ], '@dev', '#' + detachedVersion );
    a.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    return null;
  })

  a.start({ execPath : '.submodules.update' })

  .then( () =>
  {
    let currentVersion = a.fileProvider.fileRead( _.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, detachedVersion ) );
    return null;
  })

  .then( () =>
  {
    test.case = 'switch detached state to master';
    let willFile = a.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule[ 'willbe-experiment' ] = _.strReplaceAll( willFile.submodule[ 'willbe-experiment' ], '#' + detachedVersion, '@master' );
    a.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    return null;
  })

  a.start({ execPath : '.submodules.update' })

  .then( () =>
  {
    let currentVersion = a.fileProvider.fileRead( _.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })

  .then( () =>
  {
    test.case = 'master has local change, cause conflict when switch to dev';
    let willFile = a.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule[ 'willbe-experiment' ] = _.strReplaceAll( willFile.submodule[ 'willbe-experiment' ], '@master', '@dev' );
    a.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    let filePath = _.path.join( submodulesPath, 'willbe-experiment/File.js' );
    a.fileProvider.fileWrite({ filePath, data : 'master' });
    return null;
  })

  .then( () =>
  {
    let con = a.start({ execPath : '.submodules.update', ready : null });
    return test.shouldThrowErrorAsync( con );
  })

  _.process.start
  ({
    execPath : 'git status',
    currentPath : experimentModulePath,
    ready : a.ready,
    outputCollecting : 1
  })

  .then( ( got ) =>
  {
    test.is( _.strHas( got.output, 'modified:   File.js' ) )

    let currentVersion = a.fileProvider.fileRead( _.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })

  /**/

  a.ready.then( () =>
  {
    test.case = 'master has new commit, changing branch to dev';
    return null;
  })

  begin()

  a.start({ execPath : '.submodules.update' })

  _.process.start
  ({
    execPath : 'git commit --allow-empty -m commitofmaster',
    currentPath : experimentModulePath,
    ready : a.ready
  })
  .then( () =>
  {
    let willFile = a.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule[ 'willbe-experiment' ] = _.strReplaceAll( willFile.submodule[ 'willbe-experiment' ], '@master', '@dev' );
    a.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    return null;
  })

  a.start({ execPath : '.submodules.update' })

  .then( () =>
  {
    let currentVersion = a.fileProvider.fileRead( _.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/dev' ) );
    return null;
  })

  /**/

  a.ready.then( () =>
  {
    test.case = 'master and remote master have new commits';
    return null;
  })

  begin()

  a.start({ execPath : '.submodules.update' })

  _.process.start
  ({
    execPath : 'git commit --allow-empty -m emptycommit',
    currentPath : experimentModulePath,
    ready : a.ready
  })

  // start2( 'git -C cloned checkout master' )
  // start2( 'git -C cloned commit --allow-empty -m test' )
  // start2( 'git -C cloned push' )
  a.shell( 'git -C cloned checkout master' )
  a.shell( 'git -C cloned commit --allow-empty -m test' )
  a.shell( 'git -C cloned push' )

  a.start({ execPath : '.submodules.update' })

  _.process.start
  ({
    execPath : 'git status',
    currentPath : experimentModulePath,
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
  })

  .then( ( got ) =>
  {
    test.is( _.strHas( got.output, `Your branch is ahead of 'origin/master' by 2 commits` ) );

    let currentVersion = a.fileProvider.fileRead( _.path.join( submodulesPath, 'willbe-experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })

  return a.ready;

  /* */

  function begin()
  {
    a.ready
    .then( () =>
    {
      test.case = 'setup repo';

      let con = new _.Consequence().take( null );
      let repoPath = a.abs( 'experiment' );
      let repoSrcFiles = a.abs( 'src' );
      let clonePath = a.abs( 'cloned' );

      a.reflect();

      a.fileProvider.dirMake( repoPath );

      let start = _.process.starter
      ({
        currentPath : a.routinePath,
        outputCollecting : 1,
        ready : con,
      })

      start( 'git -C experiment init --bare' )
      start( 'git clone experiment cloned' )

      .then( () =>
      {
        return a.fileProvider.filesReflect({ reflectMap : { [ repoSrcFiles ] : clonePath } })
      })

      start( 'git -C cloned add -fA .' )
      start( 'git -C cloned commit -m init' )
      start( 'git -C cloned push' )
      start( 'git -C cloned checkout -b dev' )
      start( 'git -C cloned commit --allow-empty -m test' )
      start( 'git -C cloned commit --allow-empty -m test2' )
      start( 'git -C cloned push origin dev' )
      start( 'git -C cloned rev-parse HEAD~1' )

      .then( ( got ) =>
      {
        detachedVersion = _.strStrip( got.output );
        test.is( _.strDefined( detachedVersion ) );
        return null;
      })

      return con;
    })

    return a.ready;
  }

}

subModulesUpdateSwitchBranch.timeOut = 300000;

//

/* qqq : improve test coverage of submodulesVerify */
function submodulesVerify( test )
{
  let self = this;
  let a = self.assetFor( test, 'command-versions-verify' );
  a.start2 = _.process.starter
  ({
    currentPath : a.abs( 'module' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
  });
  a.start3 = _.process.starter
  ({
    currentPath : a.abs( '.module/local' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
  });
  a.reflect();

  /* - */

  a.ready.then( () =>
  {
    test.case = 'setup';
    return null;
  })

  a.startNonThrowing( '.with ./module/ .export' )
  a.start2( 'git init' )
  a.start2( 'git add -fA .' )
  a.start2( 'git commit -m init' )

  /* */

  .then( () =>
  {
    test.case = 'verify not downloaded';
    return null;
  })

  a.startNonThrowing( '.submodules.versions.verify' )

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '! Submodule opener::local does not have files' ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'first verify after download';
    return null;
  })

  a.startNonThrowing( '.submodules.download' )
  a.startNonThrowing( '.submodules.versions.verify' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '1 / 1 submodule(s) of module::submodules / module::local were verified' ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'second verify';
    return null;
  })

  a.startNonThrowing( '.submodules.versions.verify' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '1 / 1 submodule(s) of module::submodules / module::local were verified' ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'new commit on local copy, try to verify';
    return null;
  })

  a.start3( 'git commit --allow-empty -m test' )

  a.startNonThrowing( '.submodules.versions.verify' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '1 / 1 submodule(s) of module::submodules / module::local were verified' ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'change branch';
    return null;
  })

  a.start3( 'git checkout -b testbranch' )

  a.startNonThrowing( '.submodules.versions.verify' )

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Submodule module::local has version different from that is specified in will-file' ) );
    return null;
  })

  return a.ready;
}

//

function versionsAgree( test )
{
  let self = this;
  let a = self.assetFor( test, 'command-versions-agree' );
  a.start2 = _.process.starter
  ({
    currentPath : a.abs( 'module' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
  })

  a.start3 = _.process.starter
  ({
    currentPath : a.abs( '.module/local' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.ready.then( () =>
  {
    test.case = 'setup';
    return null;
  })

  a.startNonThrowing( '.with ./module/ .export' )
  a.start2( 'git init' )
  a.start2( 'git add -fA .' )
  a.start2( 'git commit -m init' )

  /* */

  .then( () =>
  {
    test.case = 'agree not downloaded';
    return null;
  })

  a.startNonThrowing( '.submodules.versions.agree' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 1/1 submodule(s) of module::submodules were agreed in' ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'agree after download';
    return null;
  })

  a.start( '.submodules.versions.agree' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 0/1 submodule(s) of module::submodules were agreed in' ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'local is up to date with remote but has local commit';
    return null;
  })

  a.start3( 'git commit --allow-empty -m test' )
  a.startNonThrowing( '.submodules.versions.agree' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ 0/1 submodule(s) of module::submodules were agreed in' ) );
    return null;
  })
  a.start3( 'git status' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Your branch is ahead of \'origin\/master\' by 1 commit/ ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'local is not up to date with remote but has local commit';
    return null;
  })

  a.start2( 'git commit --allow-empty -m test' )
  a.startNonThrowing( '.submodules.versions.agree' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'module::local was agreed with version master in' ) );
    test.is( _.strHas( got.output, '+ 1/1 submodule(s) of module::submodules were agreed in' ) );
    return null;
  })
  a.start3( 'git status' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `Your branch is ahead of 'origin/master' by 2 commits` ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'local is not up to date with remote, no local changes';
    return null;
  })

  a.start3( 'git reset --hard origin' )
  a.start2( 'git commit --allow-empty -m test2' )
  a.startNonThrowing( '.submodules.versions.agree' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, '+ 1/1 submodule(s) of module::submodules were agreed in' ) );
    return null;
  })
  a.start3( 'git status' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Your branch is up to date/ ) );
    return null;
  })

  return a.ready;
}

//

function versionsAgreeNpm( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-download-npm' );
  let versions = {}
  let willFilePath = a.abs( '.will.yml' );
  let filesBefore = null;

  /* - */

  a.ready

  .then( () =>
  {
    versions[ 'ModuleForTesting1' ] = _.npm.versionRemoteRetrive( 'npm:///wmodulefortesting1' );
    versions[ 'ModuleForTesting2a' ] = _.npm.versionRemoteRetrive( 'npm:///wmodulefortesting2a@alpha' );
    versions[ 'ModuleForTesting12ab' ] = _.npm.versionRemoteCurrentRetrive( 'npm:///wmodulefortesting12ab#0.0.31' );

    a.reflect();

    return null;
  })

  /* */

  a.start( '.submodules.versions.agree' )

  .then( ( got ) =>
  {
    test.case = 'agree npm modules';

    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting1.will.yml', 'ModuleForTesting12ab', 'ModuleForTesting12ab.will.yml', 'ModuleForTesting2a', 'ModuleForTesting2a.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 3 );
    test.identical( _.strCount( got.output, '. Opened .' ), 7 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, 'were agreed' ), 1 );
    test.identical( _.strCount( got.output, '+ 3/3 submodule(s) of module::supermodule were agreed' ), 1 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was agreed with version ${versions['ModuleForTesting1']}` ), 1 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was agreed with version ${versions['ModuleForTesting2a']}` ), 1 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was agreed with version ${versions['ModuleForTesting12ab']}` ), 1 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 2 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 1 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 1 );

    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( version, versions[ 'ModuleForTesting1' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting12ab' ) );
    test.identical( version, versions[ 'ModuleForTesting12ab' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting2a' ) );
    test.identical( version, versions[ 'ModuleForTesting2a' ] )

    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1/ModuleForTesting1.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12ab/ModuleForTesting12ab.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a/ModuleForTesting2a.out.will.yml' ) ) )

    return null;
  })

  /*  */

  .then( ( got ) =>
  {
    let willFile = a.fileProvider.fileRead( willFilePath );
    willFile = _.strReplace( willFile, '@alpha', '@beta' );
    willFile = _.strReplace( willFile, '@0.0.31', '@0.0.34' );
    a.fileProvider.fileWrite( willFilePath, willFile );

    versions[ 'ModuleForTesting2a' ] = _.npm.versionRemoteRetrive( 'npm:///wmodulefortesting2a@beta' );
    versions[ 'ModuleForTesting12ab' ] = '0.0.34'

    return null;
  })

  a.start( '.submodules.versions.agree' )

  .then( ( got ) =>
  {
    test.case = 'second run of .submodules.versions.agree';

    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting1.will.yml', 'ModuleForTesting12ab', 'ModuleForTesting12ab.will.yml', 'ModuleForTesting2a', 'ModuleForTesting2a.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 11 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, '+ 2/3 submodule(s) of module::supermodule were agreed' ), 1 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was agreed with version ${versions['ModuleForTesting1']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was agreed with version ${versions['ModuleForTesting2a']}` ), 1 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was agreed with version ${versions['ModuleForTesting12ab']}` ), 1 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 1 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 1 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 1 );

    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( version, versions[ 'ModuleForTesting1' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting12ab' ) );
    test.identical( version, versions[ 'ModuleForTesting12ab' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting2a' ) );
    test.identical( version, versions[ 'ModuleForTesting2a' ] )

    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1/ModuleForTesting1.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12ab/ModuleForTesting12ab.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a/ModuleForTesting2a.out.will.yml' ) ) )

    return null;
  })

  /*  */

  a.start( '.submodules.versions.agree' )

  .then( ( got ) =>
  {
    test.case = 'third run of .submodules.versions.agree';

    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting1.will.yml', 'ModuleForTesting12ab', 'ModuleForTesting12ab.will.yml', 'ModuleForTesting2a', 'ModuleForTesting2a.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 7 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, '+ 0/3 submodule(s) of module::supermodule were agreed' ), 1 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was agreed with version ${versions['ModuleForTesting1']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was agreed with version ${versions['ModuleForTesting2a']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was agreed with version ${versions['ModuleForTesting12ab']}` ), 0 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 0 );

    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( version, versions[ 'ModuleForTesting1' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting12ab' ) );
    test.identical( version, versions[ 'ModuleForTesting12ab' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting2a' ) );
    test.identical( version, versions[ 'ModuleForTesting2a' ] )

    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1/ModuleForTesting1.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12ab/ModuleForTesting12ab.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a/ModuleForTesting2a.out.will.yml' ) ) )

    return null;
  })

  /*  */

  .then( () =>
  {
    test.case = 'change origin of first submodule and run .submodules.versions.agree';

    let willFile = a.fileProvider.fileRead( willFilePath );
    willFile = _.strReplace( willFile, 'npm:///wmodulefortesting1\n', 'npm:///wmodulefortesting2b\n' );
    a.fileProvider.fileWrite( willFilePath, willFile );

    versions[ 'ModuleForTesting2b' ] = _.npm.versionRemoteRetrive( 'npm:///wmodulefortesting2b' );

    return null;
  })

  a.start( '.submodules.versions.agree' )

  .then( ( got ) =>
  {
    test.case = 'third run of .submodules.versions.agree';

    test.identical( got.exitCode, 0 );

    var exp = [ 'ModuleForTesting1', 'ModuleForTesting1.will.yml', 'ModuleForTesting12ab', 'ModuleForTesting12ab.will.yml', 'ModuleForTesting2a', 'ModuleForTesting2a.will.yml' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );

    test.identical( _.strCount( got.output, '! Failed to open' ), 0 );
    test.identical( _.strCount( got.output, '. Opened .' ), 9 );
    test.identical( _.strCount( got.output, '+ Reflected' ), 0 );
    test.identical( _.strCount( got.output, '+ 1/3 submodule(s) of module::supermodule were agreed' ), 1 );

    test.identical( _.strCount( got.output, `module::ModuleForTesting1 was agreed with version ${versions['ModuleForTesting2b']}` ), 1 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting2a was agreed with version ${versions['ModuleForTesting2a']}` ), 0 );
    test.identical( _.strCount( got.output, `module::ModuleForTesting12ab was agreed with version ${versions['ModuleForTesting12ab']}` ), 0 );

    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting1` ), 1 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting2a` ), 0 );
    test.identical( _.strCount( got.output, `Exported module::supermodule / module::ModuleForTesting12ab` ), 0 );

    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting1' ) );
    test.identical( version, versions[ 'ModuleForTesting2b' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting12ab' ) );
    test.identical( version, versions[ 'ModuleForTesting12ab' ] )
    var version = _.npm.versionLocalRetrive( a.abs( '.module/ModuleForTesting2a' ) );
    test.identical( version, versions[ 'ModuleForTesting2a' ] )

    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting1/ModuleForTesting1.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting12ab/ModuleForTesting12ab.out.will.yml' ) ) )
    test.is( a.fileProvider.fileExists( a.abs( '.module/ModuleForTesting2a/ModuleForTesting2a.out.will.yml' ) ) )

    var exp =
    [
      '.',
      './dwtools',
      './dwtools/abase',
      './dwtools/abase/l2',
      './dwtools/abase/l2/Include.s',
      './dwtools/abase/l2/l2',
      './dwtools/abase/l2/l2/ModuleForTesting2b.s'
    ];
    var files = self.find( a.abs( '.module/ModuleForTesting1/proto' ) );
    test.identical( files,exp );

    return null;
  })

  /*  */

  return a.ready;
}

versionsAgreeNpm.timeOut = 300000;

//

function stepSubmodulesDownload( test )
{
  let self = this;
  let a = self.assetFor( test, 'step-submodules-download' );
  a.start = _.process.starter
  ({
    execPath : 'node ' + self.willPath,
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    verbosity : 3,
    ready : a.ready
  })
  a.reflect();

  /* - */

  a.start({ execPath : '.resources.list' })

  .then( ( got ) =>
  {
    test.case = 'list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `git+https:///github.com/Wandalen/wModuleForTesting1.git/out/wModuleForTesting1.out.will@master` ) );
    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = 'build'
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    return null;
  })

  a.start({ execPath : '.build' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.gt( self.find( a.abs( '.module/ModuleForTesting1' ) ).length, 8 );
    test.gt( self.find( a.abs( 'out/debug' ) ).length, 8 );
    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = 'export'
    a.fileProvider.filesDelete( a.abs( '.module' ) );
    a.fileProvider.filesDelete( a.abs( 'out/debug' ) );
    a.fileProvider.filesDelete( a.abs( 'out/Download.out.will.yml' ) );
    return null;
  })

  a.start({ execPath : '.export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.gt( self.find( a.abs( '.module/ModuleForTesting1' ) ).length, 8 );
    test.gt( self.find( a.abs( 'out/debug' ) ).length, 8 );
    test.is( a.fileProvider.isTerminal( a.abs( 'out/Download.out.will.yml' ) ) );
    return null;
  })

  /* - */

  return a.ready;
}

stepSubmodulesDownload.timeOut = 300000;

//

function stepWillbeVersionCheck( test )
{
  let self = this;
  let a = self.assetFor( test, 'step-willbe-version-check' );

  let assetDstPath = a.abs( 'asset' );
  let willbeRootPath = a.path.join( __dirname, '../../../..' );
  let willbeDstPath = a.abs( 'willbe' );
  let nodeModulesSrcPath = a.path.join( willbeRootPath, 'node_modules' );
  let nodeModulesDstPath = a.path.join( willbeDstPath, 'node_modules' );

  if( !a.fileProvider.fileExists( a.path.join( willbeRootPath, 'package.json' ) ) )
  {
    test.is( true );
    return;
  }

  a.fileProvider.filesReflect
  ({
    reflectMap :
    {
      'proto/dwtools/Tools.s' : 'proto/dwtools/Tools.s',
      'proto/dwtools/atop/will' : 'proto/dwtools/atop/will',
      'package.json' : 'package.json',
    },
    src : { prefixPath : willbeRootPath },
    dst : { prefixPath : willbeDstPath },
  })
  a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : assetDstPath } });
  a.fileProvider.softLink( nodeModulesDstPath, nodeModulesSrcPath );

  let execPath = a.path.nativize( a.path.join( willbeDstPath, 'proto/dwtools/atop/will/entry/Exec' ) );
  a.start = _.process.starter
  ({
    execPath : 'node ' + execPath,
    currentPath : assetDstPath,
    outputCollecting : 1,
    throwingExitCode : 0,
    verbosity : 3,
    ready : a.ready
  })

  /* - */

  a.start( '.build' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Built .+ \/ build::debug/ ) );
    return null;
  })

  .then( ( ) =>
  {
    let packageJsonPath = _.path.join( willbeDstPath, 'package.json' );
    let packageJson = a.fileProvider.fileRead({ filePath : packageJsonPath, encoding : 'json' });
    packageJson.version = '0.0.0';
    a.fileProvider.fileWrite({ filePath : packageJsonPath, encoding : 'json', data : packageJson });
    return null;
  })

  a.start( '.build' )
  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'npm r -g willbe && npm i -g willbe' ) );
    test.is( _.strHas( got.output, /Failed .+ \/ step::willbe.version.check/ ) );
    return null;
  })

  return a.ready;
}

stepWillbeVersionCheck.timeOut = 40000;

//

function stepSubmodulesAreUpdated( test )
{
  let self = this;
  let a = self.assetFor( test, 'step-submodules-are-updated' );
  a.start2 = _.process.starter
  ({
    currentPath : a.abs( 'module' ),
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
  })
  a.reflect();

  /* - */

  a.ready.then( () =>
  {
    test.case = 'setup';
    return null;
  })

  a.startNonThrowing( '.with ./module/ .export' )
  a.start2( 'git init' )
  a.start2( 'git add -fA .' )
  a.start2( 'git commit -m init' )
  a.start2( 'git commit --allow-empty -m test' )

  /* */

  .then( () =>
  {
    test.case = 'first build';
    return null;
  })

  a.startNonThrowing( '.build' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '1/1 submodule(s) of module::submodules were downloaded in' ) );
    test.is( _.strHas( got.output, '1/1 submodule(s) of module::submodules are up to date' ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'second build';
    return null;
  })

  a.startNonThrowing( '.build' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '0/1 submodule(s) of module::submodules were downloaded in' ) );
    test.is( _.strHas( got.output, '1/1 submodule(s) of module::submodules are up to date' ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'new commit on remote, try to build';
    return null;
  })

  a.start2( 'git commit --allow-empty -m test' )

  a.startNonThrowing( '.build' )

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '0/1 submodule(s) of module::submodules were downloaded in' ) );
    test.is( _.strHas( got.output, '! Submodule module::local is not up to date' ) );
    // test.is( _.strHas( got.output, '0/1 submodule(s) of module::submodules are up to date' ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'module is not downloaded';
    return null;
  })

  a.startNonThrowing( '.build debug2' )

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '! Submodule module::local does not have files' ) );
    // test.is( _.strHas( got.output, '0/1 submodule(s) of module::submodules are up to date' ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'download path does not contain git repo';
    return null;
  })

  a.startNonThrowing( '.build debug3' )

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '! Submodule module::local does not have files' ) );
    // test.is( _.strHas( got.output, '0/1 submodule(s) of module::submodules are up to date' ) );
    return null;
  })

  /*  */

  .then( () =>
  {
    test.case = 'module is downloaded from different origin';
    return null;
  })

  a.startNonThrowing( '.build debug4' )

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '! Submodule module::local has different origin url' ) );
    // test.is( _.strHas( got.output, '0/1 submodule(s) of module::submodules are up to date' ) );
    return null;
  })

  /*  */

  .then( () =>
  {
    test.case = 'module is in detached state';
    return null;
  })

  a.startNonThrowing( '.build debug5' )

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '! Submodule module::local is not up to date' ) );
    // test.is( _.strHas( got.output, '0/1 submodule(s) of module::submodules are up to date' ) );
    return null;
  })

  /*  */

  .then( () =>
  {
    test.case = 'module is ahead remote';
    return null;
  })

  a.startNonThrowing( '.build debug6' )

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '1/1 submodule(s) of module::submodules are up to date' ) );
    return null;
  })

  return a.ready;
}

stepSubmodulesAreUpdated.timeOut = 300000;

//

function stepBuild( test )
{
  let self = this;
  let a = self.assetFor( test );
  a.reflect();

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with basic .build build1';
    return null;
  })

  a.start( '.with basic .build build1' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'echo step1' ), 1 );
    return op;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with basic .build step1';
    return null;
  })

  a.startNonThrowing( '.with basic .build step1' )

  .then( ( op ) =>
  {
    test.ni( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'echo step1' ), 0 );
    test.identical( _.strCount( op.output, 'echo' ), 0 );
    test.identical( _.strCount( op.output, 'Please specify exactly one build scenario, none satisfies passed arguments' ), 1 );
    return op;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with basic .build step2';
    return null;
  })

  a.start( '.with basic .build step2' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'echo step2' ), 1 );
    return op;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with basic .build step3a';
    return null;
  })

  a.start( '.with basic .build step3a' )

  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'echo step3' ), 1 );
    return op;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with basic .build step3';
    return null;
  })

  a.startNonThrowing( '.with basic .build step3' )

  .then( ( op ) =>
  {
    test.ni( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'echo step3' ), 0 );
    test.identical( _.strCount( op.output, 'echo' ), 0 );
    test.identical( _.strCount( op.output, 'Please specify exactly one build scenario, none satisfies passed arguments' ), 1 );
    return op;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with bad1 .resources.list';
    return null;
  })

  a.startNonThrowing( '.with bad1 .resources.list' )

  .then( ( op ) =>
  {
    test.ni( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'echo' ), 0 );
    test.identical( _.strCount( op.output, 'Instance build::step2 already exists' ), 1 );
    test.identical( _.strCount( op.output, 'Failed to make resource build::step2' ), 1 );
    return op;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = '.with bad2 .resources.list';
    return null;
  })

  a.startNonThrowing( '.with bad2 .resources.list' )

  .then( ( op ) =>
  {
    test.ni( op.exitCode, 0 );
    logger.log( 'op.exitCode', op.exitCode );
    test.identical( _.strCount( op.output, 'echo' ), 0 );
    test.identical( _.strCount( op.output, 'Instance build::step3 already exists' ), 1 );
    test.identical( _.strCount( op.output, 'Failed to make resource build::step3' ), 1 );
    return op;
  });

  /* - */

  return a.ready;
}

//

function upgradeDryDetached( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-detached' );
  a.reflect();

  // let self = this;
  // let originalAssetPath = a.path.join( self.assetsOriginalPath, 'submodules-detached' );
  // let routinePath = a.path.join( self.suiteTempPath, test.name );
  // let abs = self.abs_functor( routinePath );
  // let rel = self.rel_functor( routinePath );
  // let filePath = a.path.join( routinePath, 'file' );
  // let modulePath = a.path.join( routinePath, '.module' );
  // let outPath = a.path.join( routinePath, 'out' );
  //
  // let ready = new _.Consequence().take( null );
  //
  // let start = _.process.starter
  // ({
  //   execPath : 'node ' + self.willPath,
  //   currentPath : routinePath,
  //   outputCollecting : 1,
  //   outputGraying : 1,
  //   ready : ready,
  // });
  //
  // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:1 negative:1 -- after full update';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.export' })
  a.start({ execPath : '.submodules.upgrade dry:1 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.* : .* <- .*\.#13d24b7b6527a1ad83715b12b7bb6f5df5313e90.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 2 );

    // test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* will be upgraded to version/ ), 1 );
    // test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* won't be upgraded/ ), 1 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    // test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12\.git.* : .* <- .*\.#332f0fc961cd47a278a2b56f5b625cf5fa7fbae2.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting12\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting12\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* will be upgraded/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:1 negative:0 -- after full update';
    return null;
  })

  a.start({ execPath : '.submodules.upgrade dry:1 negative:0' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.* : .* <- .*\.#13d24b7b6527a1ad83715b12b7bb6f5df5313e90.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 2 );

    // test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* will be upgraded to version/ ), 1 );
    // test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* won't be upgraded/ ), 0 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    // test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12\.git.* : .* <- .*\.#332f0fc961cd47a278a2b56f5b625cf5fa7fbae2.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting12\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting12\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* will be upgraded/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:1 negative:1 -- after informal update';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.each module .export' })
  a.start({ execPath : '.submodules.upgrade dry:1 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.* : .* <- .*\.#13d24b7b6527a1ad83715b12b7bb6f5df5313e90.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 2 );

    // test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* will be upgraded to version/ ), 1 );
    // test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* won't be upgraded/ ), 0 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    // test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12\.git.* : .* <- .*\.#332f0fc961cd47a278a2b56f5b625cf5fa7fbae2.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting12\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting12\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* will be upgraded/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:1 negative:1 -- after formal update';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.submodules.update' })
  a.start({ execPath : '.submodules.upgrade dry:1 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.* : .* <- .*\.#13d24b7b6527a1ad83715b12b7bb6f5df5313e90.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 2 );

    // test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* will be upgraded to version/ ), 1 );
    // test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* won't be upgraded/ ), 1 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    // test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    // test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* will be upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* will be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* will be upgraded/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12.* will be upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12\.git.* : .* <- .*\.#332f0fc961cd47a278a2b56f5b625cf5fa7fbae2.*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting12\.informal\.out\.will\.yml.* will be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting12\.informal\.will\.yml.* will be upgraded/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* will be upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* will be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* will be upgraded/ ), 0 );

    return null;
  })

  /* - */

  return a.ready;
}

upgradeDryDetached.timeOut = 500000;

//

function upgradeDetached( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-detached' );
  a.reflect();

  // let self = this;
  // let originalAssetPath = a.path.join( self.assetsOriginalPath, 'submodules-detached' );
  // let routinePath = a.path.join( self.suiteTempPath, test.name );
  // let abs = self.abs_functor( routinePath );
  // let rel = self.rel_functor( routinePath );
  // let filePath = a.path.join( routinePath, 'file' );
  // let modulePath = a.path.join( routinePath, '.module' );
  // let outPath = a.path.join( routinePath, 'out' );
  //
  // let ready = new _.Consequence().take( null );
  //
  // let start = _.process.starter
  // ({
  //   execPath : 'node ' + self.willPath,
  //   currentPath : routinePath,
  //   outputCollecting : 1,
  //   outputGraying : 1,
  //   ready : ready,
  // });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:1 -- after full update';
    a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.export' })
  a.start({ execPath : '.submodules.upgrade dry:0 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.* : .* <- .*\.#13d24b7b6527a1ad83715b12b7bb6f5df5313e90.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#332f0fc961cd47a278a2b56f5b625cf5fa7fbae2.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was upgraded/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:0 -- after full update';

    a.reflect();
    // a.fileProvider.filesDelete({ filePath : routinePath })
    // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })

    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.export' })
  a.start({ execPath : '.submodules.upgrade dry:0 negative:0' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.* : .* <- .*\.#13d24b7b6527a1ad83715b12b7bb6f5df5313e90.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#332f0fc961cd47a278a2b56f5b625cf5fa7fbae2.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was upgraded/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:1 -- after full update, second';
    return null;
  })

  a.start({ execPath : '.submodules.upgrade dry:0 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was skipped/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:0 -- after full update, second';
    return null;
  })

  a.start({ execPath : '.submodules.upgrade dry:0 negative:0' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths/ ), 0 );
    test.identical( _.strCount( got.output, /was upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /will be upgraded/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was skipped/ ), 0 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:1 -- after informal update';

    a.reflect();
    // a.fileProvider.filesDelete({ filePath : routinePath })
    // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })

    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.each module .export' })
  a.start({ execPath : '.submodules.upgrade dry:0 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.* : .* <- .*\.#13d24b7b6527a1ad83715b12b7bb6f5df5313e90.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#332f0fc961cd47a278a2b56f5b625cf5fa7fbae2.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was upgraded/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:1 -- after formal update';

    a.reflect();
    // a.fileProvider.filesDelete({ filePath : routinePath })
    // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })

    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.submodules.update' })
  a.start({ execPath : '.submodules.upgrade dry:0 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.* : .* <- .*\.#13d24b7b6527a1ad83715b12b7bb6f5df5313e90.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was upgraded/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#332f0fc961cd47a278a2b56f5b625cf5fa7fbae2.*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was upgraded/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was upgraded/ ), 0 );

    return null;
  })

  /* - */

  return a.ready;
}

upgradeDetached.timeOut = 500000;

//

function upgradeDetachedExperiment( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-detached-single' );

  // let self = this;
  // let originalAssetPath = a.path.join( self.assetsOriginalPath, 'submodules-detached-single' );
  // let routinePath = a.path.join( self.suiteTempPath, test.name );
  //
  // let ready = new _.Consequence().take( null );
  //
  // let start = _.process.starter
  // ({
  //   execPath : 'node ' + self.willPath,
  //   currentPath : routinePath,
  //   outputCollecting : 1,
  //   outputGraying : 1,
  //   ready : ready,
  // });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:1 -- after download';
    a.reflect();
    // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })
    return null;
  })

  a.start({ execPath : '.submodules.download' })
  a.start({ execPath : '.submodules.upgrade dry:0 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 1 );

    return null;
  })

  return a.ready;
}

upgradeDetachedExperiment.experimental = 1;

//

function fixateDryDetached( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-detached' );
  a.reflect();

  // let self = this;
  // let originalAssetPath = a.path.join( self.assetsOriginalPath, 'submodules-detached' );
  // let routinePath = a.path.join( self.suiteTempPath, test.name );
  // let abs = self.abs_functor( routinePath );
  // let rel = self.rel_functor( routinePath );
  // let filePath = a.path.join( routinePath, 'file' );
  // let modulePath = a.path.join( routinePath, '.module' );
  // let outPath = a.path.join( routinePath, 'out' );
  //
  // let ready = new _.Consequence().take( null );
  //
  // let start = _.process.starter
  // ({
  //   execPath : 'node ' + self.willPath,
  //   currentPath : routinePath,
  //   outputCollecting : 1,
  //   outputGraying : 1,
  //   ready : ready,
  // });
  //
  // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:1 negative:1 -- after full update';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.export' })
  a.start({ execPath : '.submodules.fixate dry:1 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/\.im\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/module\/Proto\.informal\.will\.yml.* will be skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* will be fixated/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:1 negative:0 -- after full update';
    return null;
  })

  a.start({ execPath : '.submodules.fixate dry:1 negative:0' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/\.im\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/module\/Proto\.informal\.will\.yml.* will be skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* will be fixated/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:1 negative:1 -- after informal update';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.each module .export' })
  a.start({ execPath : '.submodules.fixate dry:1 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/\.im\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/module\/Proto\.informal\.will\.yml.* will be skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* will be fixated/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:1 negative:1 -- after formal update';
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.submodules.update' })
  a.start({ execPath : '.submodules.fixate dry:1 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/\.im\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* will be fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* will be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* will be fixated/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/module\/Proto\.informal\.will\.yml.* will be skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* will be fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* will be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* will be fixated/ ), 0 );

    return null;
  })

  /* - */

  return a.ready;
}

fixateDryDetached.timeOut = 500000;

//

function fixateDetached( test )
{
  let self = this;
  let a = self.assetFor( test, 'submodules-detached' );

  // let self = this;
  // let originalAssetPath = a.path.join( self.assetsOriginalPath, 'submodules-detached' );
  // let routinePath = a.path.join( self.suiteTempPath, test.name );
  // let abs = self.abs_functor( routinePath );
  // let rel = self.rel_functor( routinePath );
  // let filePath = a.path.join( routinePath, 'file' );
  // let modulePath = a.path.join( routinePath, '.module' );
  // let outPath = a.path.join( routinePath, 'out' );
  //
  // let ready = new _.Consequence().take( null );
  //
  // let start = _.process.starter
  // ({
  //   execPath : 'node ' + self.willPath,
  //   currentPath : routinePath,
  //   outputCollecting : 1,
  //   outputGraying : 1,
  //   ready : ready,
  // });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:1 -- after full update';
    a.reflect();
    // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })
    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.export' })
  a.start({ execPath : '.submodules.fixate dry:0 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/\.im\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was fixated/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:0 -- after full update';

    a.reflect();
    // a.fileProvider.filesDelete({ filePath : routinePath })
    // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })

    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.export' })
  a.start({ execPath : '.submodules.fixate dry:0 negative:0' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/\.im\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was fixated/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:1 -- after full update, second';
    return null;
  })

  a.start({ execPath : '.submodules.fixate dry:0 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was skipped/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:0 -- after full update, second';
    return null;
  })

  a.start({ execPath : '.submodules.fixate dry:0 negative:0' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths/ ), 0 );
    test.identical( _.strCount( got.output, /was fixated/ ), 0 );
    test.identical( _.strCount( got.output, /will be fixated/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/\.im\.will\.yml.* was fixated/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was fixated/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was fixated/ ), 0 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:1 -- after informal update';

    a.reflect();
    // a.fileProvider.filesDelete({ filePath : routinePath })
    // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })

    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.each module .export' })
  a.start({ execPath : '.submodules.fixate dry:0 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/\.im\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was fixated/ ), 1 );

    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:1 -- after formal update';

    a.reflect();
    // a.fileProvider.filesDelete({ filePath : routinePath })
    // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })

    return null;
  })

  a.start({ execPath : '.clean' })
  a.start({ execPath : '.submodules.update' })
  a.start({ execPath : '.submodules.fixate dry:0 negative:1' })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will.* : .* <- .*\.@master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/out\/wModuleForTesting1\.out\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1\/\.im\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/\.im\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2a.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting2a\.git\/out\/wModuleForTesting2a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/out\/wModuleForTesting2a\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting2a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting1a.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/out\/wModuleForTesting1a\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/ModuleForTesting1a\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting12ab.* was fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting12ab\.git.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/ModuleForTesting12ab\.informal\.out\.will\.yml.* was fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/ModuleForTesting12ab\.informal\.will\.yml.* was fixated/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::Proto.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ relation::ModuleForTesting2b.* was fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/ModuleForTesting2b\.informal\.out\.will\.yml.* was fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/ModuleForTesting2b\.informal\.will\.yml.* was fixated/ ), 0 );

    return null;
  })

  /* - */

  return a.ready;
}

fixateDetached.timeOut = 500000;

//

/*
  runWillbe checks if willbe can be terminated on early start from terminal when executed as child process using ExecUnrestricted script
*/

function runWillbe( test )
{

  let self = this;
  let a = self.assetFor( test, 'run-willbe' );
  let execUnrestrictedPath = a.path.nativize( a.path.join( __dirname, '../will/ExecUnrestricted' ) );

  a.fork = _.process.starter
  ({
    // execPath : 'node',
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    ready : a.ready,
    mode : 'fork',
  });
  a.start = _.process.starter
  ({
    currentPath : a.routinePath,
    outputCollecting : 1,
    outputGraying : 1,
    mode : 'fork',
    ready : a.ready,
    mode : 'shell',
  });

//   let self = this;
//   let originalAssetPath = a.path.join( self.assetsOriginalPath, 'run-willbe' );
//   let routinePath = a.path.join( self.suiteTempPath, test.name );
//   let abs = self.abs_functor( routinePath );
//   let rel = self.rel_functor( routinePath );
//
//   let execUnrestrictedPath = a.path.nativize( a.path.join( __dirname, '../will/ExecUnrestricted' ) );
//   let ready = new _.Consequence().take( null );
//
//   let fork = _.process.starter
//   ({
//     // execPath : 'node',
//     currentPath : routinePath,
//     outputCollecting : 1,
//     outputGraying : 1,
//     ready : ready,
//     mode : 'fork',
//   });
//
//   let start = _.process.starter
//   ({
//     currentPath : routinePath,
//     outputCollecting : 1,
//     outputGraying : 1,
//     mode : 'fork',
//     ready : ready,
//     mode : 'shell',
//   });

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    // a.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } })
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = 'execUnrestricted: terminate utility during heavy load of will files, should be terminated';
    let o = { args : [ execUnrestrictedPath, '.submodules.list' ], ready : null };

    let con = a.fork( o );

    o.process.stdout.on( 'data', ( data ) =>
    {
      if( _.bufferAnyIs( data ) )
      data = _.bufferToStr( data );
      if( _.strHas( data, 'wTools.out.will.yml' ) )
      {
        console.log( 'Terminating willbe...' );
        o.process.kill( 'SIGINT' )
        // o.process.stdin.write( '\x03\n' ); /* CTRL+C */
        // o.process.stdin.write( '~^C\n' ); /* CTRL+C */
      }
    });

    return test.shouldThrowErrorAsync( con )
    .then( () =>
    {
      if( process.platform === 'win32' )
      test.identical( o.exitCode, null );
      else
      test.identical( o.exitCode, 255 );
      test.identical( o.exitSignal, 'SIGINT' );
      test.is( _.strHas( o.output, 'wTools.out.will.yml' ) );
      test.is( !_.strHas( o.output, 'wLogger.out.will.yml' ) );
      test.is( !_.strHas( o.output, 'wLoggerToJs.out.will.yml' ) );
      test.is( !_.strHas( o.output, 'wConsequence.out.will.yml' ) );
      test.is( !_.strHas( o.output, 'wInstancing.out.will.yml' ) );

      return null;
    })
  })

  /* */

  .then( () =>
  {
    test.case = 'Exec: terminate utility during heavy load of will files, should fail'
    let o = { execPath : 'node', args : [ execPath, '.submodules.list' ], ready : null };
    let con = a.start( o );

    o.process.stdout.on( 'data', ( data ) =>
    {
      if( _.bufferAnyIs( data ) )
      data = _.bufferToStr( data );
      if( _.strHas( data, 'wTools.out.will.yml' ) )
      {
        console.log( 'Terminating willbe...' );
        // debugger;
        // o.process.kill( 'SIGTERM' );
        // o.process.kill( 'SIGINT' );
        o.process.kill( 'SIGINT' );
        // o.process.kill( 'SIGKILL' );
      }
    });

    return test.shouldThrowErrorAsync( con )
    .then( () =>
    {
      if( process.platform === 'win32' )
      test.identical( o.exitCode, null );
      else
      test.identical( o.exitCode, 255 );
      test.identical( o.exitSignal, 'SIGINT' );
      test.is( _.strHas( o.output, 'module::runWillbe / submodule::Tools' ) );
      test.is( _.strHas( o.output, 'module::runWillbe / submodule::Logger' ) );
      test.is( _.strHas( o.output, 'module::runWillbe / submodule::LoggerToJs' ) );
      return null;
    })

  })

  /* */

  return a.ready;
}

//

/*

Performance issue. Related with
- path map handling
- file filter forming
Disappeared as mystically as appeared.

*/

function resourcesFormReflectorsExperiment( test )
{
  let self = this;
  let a = self.assetFor( test, 'performance2' );
  a.reflect()

  // let originalAssetPath = _.path.join( self.assetsOriginalPath, 'performance2' );
  // let routinePath = _.path.join( self.suiteTempPath, test.name );
  // let abs = self.abs_functor( routinePath );
  // let rel = self.rel_functor( routinePath );

  let moduleOldPath = _.path.join( routinePath, './old-out-file/' );
  let moduleNewPath = _.path.join( routinePath, './new-out-file/' );

  // _.fileProvider.filesDelete( routinePath );
  // _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
  //
  // let ready = new _.Consequence().take( null )

  /* */

  a.ready.then( () =>
  {
    /* This case uses out file of Starter that cause slow forming of reflector reflect.submodules from supermode */

    test.case = 'old version of out file from Starter module, works really slow';
    let o2 =
    {
      execPath : execPath,
      currentPath : moduleOldPath,
      args : [ '.submodules.list' ],
      mode : 'fork',
      outputCollecting : 1
    };

    let con = _.process.start( o2 );
    let t = _.time.out( 10000, () =>
    {
      o2.process.kill( 'SIGKILL' );
      throw _.err( 'TimeOut:10000, resources forming takes too long' );
    });

    return con.orKeepingSplit( t );
  })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'module::old-out-file / submodule::Starter' ) );
    test.is( _.strHas( got.output, 'path : git+https:///github.com/Wandalen/wStarter.git/out/wStarter@master' ) );
    test.is( _.strHas( got.output, 'autoExporting : 0' ) );
    test.is( _.strHas( got.output, 'enabled : 1' ) );
    test.is( _.strHas( got.output, "Exported builds : [ 'proto.export' ]" ) );
    test.is( _.strHas( got.output, "isDownloaded : false" ) );
    test.is( _.strHas( got.output, "isAvailable : false" ) );

    return null;
  })

  /* */

  a.ready.then( () =>
  {
    /* This case uses new out file of Starter forming of reflector reflect.submodules from supermode is fast */

    test.case = 'new version of out file from Starter module, works fast';

    let o2 =
    {
      execPath : execPath,
      currentPath : moduleNewPath,
      args : [ '.submodules.list' ],
      mode : 'fork',
      outputCollecting : 1
    };

    let con = _.process.start( o2 );
    let t = _.time.out( 10000, () =>
    {
      o2.process.kill( 'SIGKILL' );
      throw _.err( 'TimeOut : 10000, resources forming takes too long' );
    });

    return con.orKeepingSplit( t );
  })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'module::new-out-file / submodule::Starter' ) );
    test.is( _.strHas( got.output, 'path : git+https:///github.com/Wandalen/wStarter.git/out/wStarter@master' ) );
    test.is( _.strHas( got.output, 'autoExporting : 0' ) );
    test.is( _.strHas( got.output, 'enabled : 1' ) );
    test.is( _.strHas( got.output, "Exported builds : [ 'proto.export' ]" ) );
    test.is( _.strHas( got.output, "isDownloaded : false" ) );
    test.is( _.strHas( got.output, "isAvailable : false" ) );

    return null;
  })

  /* */

  return a.ready;
}

// --
// declare
// --

var Self =
{

  name : 'Tools.atop.Willbe.Ext',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,
  routineTimeOut : 300000,

  context :
  {
    suiteTempPath : null,
    assetsOriginalPath : null,
    repoDirPath : null,
    willPath : null,
    find : null,
    findAll : null,
    assetFor,
    abs_functor,
    rel_functor,
  },

  tests :
  {

    preCloneRepos,
    singleModuleWithSpaceTrivial,
    build,
    transpile,
    transpileWithOptions,
    transpileExperiment,
    moduleNewDotless,
    moduleNewDotlessSingle,
    moduleNewNamed,

    openWith,
    openEach,
    // withMixed, /* xxx : later */
    // eachMixed, // xxx : later
    withList,
    // eachList, // xxx : later
    eachBrokenIll,
    eachBrokenNon,
    eachBrokenCommand,

    // CUI

    commandsSeveral,
    implyWithSubmodulesModulesList, /* qqq : cover all implies. ask how to */

    // reflect

    reflectNothingFromSubmodules,
    reflectGetPath,
    reflectSubdir,
    reflectSubmodulesWithBase,
    reflectComposite,
    reflectRemoteGit,
    reflectRemoteHttp,
    reflectWithOptions,
    reflectWithOptionDstRewriting,
    reflectWithOptionLinking,
    reflectorFromPredefinedWithOptions,
    reflectWithSelectorInDstFilter,
    reflectSubmodulesWithCriterion,
    reflectSubmodulesWithPluralCriterionManualExport,
    reflectSubmodulesWithPluralCriterionEmbeddedExport,
    reflectNpmModules,
    // relfectSubmodulesWithNotExistingFile, // zzz : uncomment after final transition to willbe
    reflectInherit,
    reflectInheritSubmodules,
    reflectComplexInherit,
    reflectorMasks,
    reflectorsCommonPrefix,
    reflectorOptionStep,
    reflectorOptionStepThrowing,

    // with do

    withDoInfo,
    withDoStatus,
    withDoCommentOut,

    hookCallInfo,
    hookGitMake,
    hookPrepare,
    hookHlink,
    hookGitPullConflict,
    hookGitSyncColflict,
    hookGitSyncArguments,
    // hookPublish, // Vova aaa : doesn't exist

    // output

    verbositySet,
    verbosityStepDelete,
    verbosityStepPrintName,
    modulesTreeDotless,
    modulesTreeLocal,
    modulesTreeHierarchyRemote,
    // modulesTreeHierarchyRemoteDownloaded, /* xxx : later */
    // modulesTreeHierarchyRemotePartiallyDownloaded, /* xxx : later */
    modulesTreeDisabledAndCorrupted,

    help,
    listSingleModule,
    listWithSubmodulesSimple,
    listWithSubmodules,
    listSteps,

    // clean

    clean,
    cleanSingleModule,
    cleanBroken1,
    cleanBroken2,
    cleanBrokenSubmodules,
    cleanHdBug,
    cleanNoBuild,
    cleanDry,
    cleanSubmodules,
    cleanMixed,
    cleanWithInPath,
    cleanRecursive,
    cleanDisabledModule,
    cleanHierarchyRemote,
    cleanHierarchyRemoteDry,
    cleanSubmodulesHierarchyRemote,
    cleanSubmodulesHierarchyRemoteDry,
    cleanSpecial,

    buildSingleModule,
    buildSingleStep,
    buildSubmodules,
    buildOptionWithSubmodules, /* xxx : fix */
    buildOptionWithSubmodulesExplicitRunOption,
    /* xxx : write test routine exportOptionWithSubmodules */
    // buildDetached, /* xxx : later */

    exportSingle,
    exportItself,
    exportNonExportable,
    exportPurging, /* yyy */
    // exportStringrmal, /* xxx : later */
    exportWithReflector,
    exportToRoot,
    // exportMixed, /* xxx : later */
    exportSecond,
    exportSubmodules,
    exportMultiple,
    exportImportMultiple,
    exportBroken,
    exportDoc,
    exportImport,
    exportBrokenNoreflector,
    exportCourrputedOutfileUnknownSection,
    exportCourruptedOutfileSyntax,
    exportCourruptedSubmodulesDisabled,
    exportDisabledModule,
    exportOutdated,
    exportWholeModule,
    exportRecursive,
    exportRecursiveUsingSubmodule,
    exportRecursiveLocal,
    exportDotless,
    exportDotlessSingle,
    exportTracing,
    exportRewritesOutFile,
    exportWithRemoteSubmodules,
    exportDiffDownloadPathsRegular,
    exportHierarchyRemote,
    exportWithDisabled,
    exportOutResourceWithoutGeneratedCriterion,
    exportImplicit,
    /* xxx : implement same test for hierarchy-remote and irregular */
    /* xxx : implement clean tests */
    /* xxx : refactor ** clean */
    // exportAuto, // xxx : later
    exportOutdated2,
    exportWithSubmoduleThatHasModuleDirDeleted,
    exportWithoutSubSubModules,
    exportWithSubmoduleWithNotDownloadedSubmodule,

    importPathLocal,
    // importLocalRepo, /* xxx : later */
    importOutWithDeletedSource,

    shellWithCriterion,
    shellVerbosity,

    functionStringsJoin,
    functionPlatform,
    functionThisCriterion,

    submodulesDownloadSingle,
    submodulesDownloadUpdate,
    submodulesDownloadUpdateDry,
    submodulesDownloadSwitchBranch,
    // submodulesDownloadRecursive, /* xxx */
    submodulesDownloadThrowing,
    submodulesDownloadStepAndCommand,
    submodulesDownloadDiffDownloadPathsRegular,
    submodulesDownloadDiffDownloadPathsIrregular,
    submodulesDownloadHierarchyRemote,
    submodulesDownloadHierarchyDuplicate,
    submodulesDownloadNpm,
    submodulesDownloadUpdateNpm,

    submodulesUpdateThrowing,
    submodulesAgreeThrowing,
    submodulesVersionsAgreeWrongOrigin,
    submodulesDownloadedUpdate,
    subModulesUpdate,
    subModulesUpdateSwitchBranch,
    submodulesVerify,
    versionsAgree,
    versionsAgreeNpm,

    stepSubmodulesDownload,
    stepWillbeVersionCheck,
    stepSubmodulesAreUpdated,
    stepBuild,

    /* xxx : cover "will .module.new.with prepare" */

    // upgradeDryDetached, // xxx : look later
    // upgradeDetached, // xxx : look later
    // upgradeDetachedExperiment, // xxx : look later
    // fixateDryDetached, // xxx : look later
    // fixateDetached, // xxx : look later

    // runWillbe, // zzz : help to fix, please

    // resourcesFormReflectorsExperiment, // xxx : look

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
