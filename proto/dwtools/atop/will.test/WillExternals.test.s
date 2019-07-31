( function _WillExternals_test_s_( ) {

'use strict'; debugger;

if( typeof module !== 'undefined' )
{
  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );;
  _.include( 'wExternalFundamentals' );
  _.include( 'wFiles' );

}

var _global = _global_;
var _ = _global_.wTools;

//

function onSuiteBegin()
{
  let self = this;

  self.tempDir = _.path.dirTempOpen( _.path.join( __dirname, '../..'  ), 'Will' );
  self.assetDirPath = _.path.join( __dirname, '_asset' );
  self.repoDirPath = _.path.join( self.assetDirPath, '_repo' );
  self.find = _.fileProvider.filesFinder
  ({
    recursive : 2,
    includingTerminals : 1,
    includingDirs : 1,
    includingTransient : 1,
    allowingMissed : 1,
    outputFormat : 'relative',
  });

}

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.tempDir, '/dwtools/tmp.tmp' ) )
  _.fileProvider.filesDelete( self.tempDir );
}

//

function preCloneRepos( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    currentPath : self.repoDirPath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.dirMake( self.repoDirPath );

  /* - */

  clone( 'Color', '2d408bf82b168a39a29aa1261bf13face8bd3e95' );
  clone( 'PathFundamentals', '95b741c8820a6d6234f59f1fa549c6b59f2d5a5c' );
  clone( 'Procedure', '829ea81d342db66df60edf80c99687a1cd011a96' );
  clone( 'Proto', 'f4c04dbe078f3c00c84ff13edcc67478d320fddf' );
  clone( 'Tools', 'e58dc6a1637603c2151840f5bfb5729eb71d4e34' );
  clone( 'UriFundamentals', '3686d72cc0b8f6573217c947a4b379c38b02e39b' );

  ready
  .then( () =>
  {
    test.is( _.fileProvider.isDir( _.path.join( self.repoDirPath, 'Tools' ) ) );
    return null;
  })

  return ready;

  function clone( name, version )
  {

    if( !_.fileProvider.isDir( _.path.join( self.repoDirPath, name ) ) )
    shell( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name );
    debugger;
    shell({ args : 'git checkout ' + version, currentPath : _.path.join( self.repoDirPath, name ) });
    debugger;

  }

}

//

function singleModuleSimplest( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'single' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  test.case = 'simple run without args'

  shell()

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( got.output.length );
    return null;
  })

  return ready;
}

singleModuleSimplest.timeOut = 200000;

//

function singleModuleWithSpaceTrivial( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'single with space' );
  let routinePath = _.path.join( self.tempDir, test.name, 'single with space' );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : _.path.dir( routinePath ),
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  shell({ args : [ '.with "single with space/" .resources.list' ] })

  .then( ( got ) =>
  {
    test.case = '.with "single with space/" .resources.list';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `name : 'single with space'` ) );
    test.is( _.strHas( got.output, `description : 'Module for testing'` ) );
    test.is( _.strHas( got.output, `version : '0.0.1'` ) );
    return null;
  })

  return ready;
}

singleModuleWithSpaceTrivial.timeOut = 200000;

//

function make( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'make' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let filePath = _.path.join( routinePath, 'file' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with v1 .build'
    _.fileProvider.filesDelete( _.fileProvider.path.join( filePath, './Produced.js2' ) );
    _.fileProvider.filesDelete( _.fileProvider.path.join( filePath, './Produced.txt2' ) );
    return null;
  })

  shell({ args : [ '.with v1 .build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( _.strHas( got.output, 'node file/Produce.js' ) );
    if( process.platform === 'win32' )
    {
      test.identical( _.strCount( got.output, 'file\\Produced.txt2' ), 1 );
      test.identical( _.strCount( got.output, 'file\\Produced.js2' ), 1 );
    }
    else
    {
      test.identical( _.strCount( got.output, 'file/Produced.txt2' ), 1 );
      test.identical( _.strCount( got.output, 'file/Produced.js2' ), 1 );
    }
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( filePath );
    test.identical( files, [ '.', './File.js', './File.test.js', './Produce.js', './Produced.js2', './Produced.txt2', './Src1.txt', './Src2.txt' ] );
    return null;
  })

  shell({ args : [ '.with v1 .build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( !_.strHas( got.output, 'node file/Produce.js' ) );
    if( process.platform === 'win32' )
    {
      test.identical( _.strCount( got.output, 'file\\Produced.txt2' ), 0 );
      test.identical( _.strCount( got.output, 'file\\Produced.js2' ), 0 );
    }
    else
    {
      test.identical( _.strCount( got.output, 'file/Produced.txt2' ), 0 );
      test.identical( _.strCount( got.output, 'file/Produced.js2' ), 0 );
    }
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( filePath );
    test.identical( files, [ '.', './File.js', './File.test.js', './Produce.js', './Produced.js2', './Produced.txt2', './Src1.txt', './Src2.txt' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with v2 .build'
    _.fileProvider.fileDelete( _.fileProvider.path.join( filePath, './Produced.js2' ) );
    _.fileProvider.fileDelete( _.fileProvider.path.join( filePath, './Produced.txt2' ) );
    return null;
  })

  shell({ args : [ '.with v2 .build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( _.strHas( got.output, 'node file/Produce.js' ) );
    if( process.platform === 'win32' )
    {
      test.identical( _.strCount( got.output, 'file\\Produced.txt2' ), 1 );
      test.identical( _.strCount( got.output, 'file\\Produced.js2' ), 1 );
    }
    else
    {
      test.identical( _.strCount( got.output, 'file/Produced.txt2' ), 1 );
      test.identical( _.strCount( got.output, 'file/Produced.js2' ), 1 );
    }
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( filePath );
    test.identical( files, [ '.', './File.js', './File.test.js', './Produce.js', './Produced.js2', './Produced.txt2', './Src1.txt', './Src2.txt' ] );
    return null;
  })

  shell({ args : [ '.with v2 .build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( !_.strHas( got.output, 'node file/Produce.js' ) );
    if( process.platform === 'win32' )
    {
      test.identical( _.strCount( got.output, 'file\\Produced.txt2' ), 0 );
      test.identical( _.strCount( got.output, 'file\\Produced.js2' ), 0 );
    }
    else
    {
      test.identical( _.strCount( got.output, 'file/Produced.txt2' ), 0 );
      test.identical( _.strCount( got.output, 'file/Produced.js2' ), 0 );
    }
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( filePath );
    test.identical( files, [ '.', './File.js', './File.test.js', './Produce.js', './Produced.js2', './Produced.txt2', './Src1.txt', './Src2.txt' ] );
    return null;
  })

  /* - */

  return ready;
}

//

/*
Test transpilation of JS files.
*/

function transpile( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'transpile' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build debug'
    _.fileProvider.filesDelete( outPath );
    return null;
  })
  shell({ args : [ '.build debug' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js', './debug/dir3.test', './debug/dir3.test/File.js', './debug/dir3.test/File.test.js' ] );
    _.fileProvider.isTerminal( _.path.join( outPath, 'debug/dir3.test/File.js' ) );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build compiled.debug'
    _.fileProvider.filesDelete( outPath );
    return null;
  })
  shell({ args : [ '.build compiled.debug' ] })
  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './compiled.debug', './compiled.debug/Main.s', './tests.compiled.debug', './tests.compiled.debug/Tests.s' ] );
    _.fileProvider.isTerminal( _.path.join( outPath, 'compiled.debug/Main.s' ) );
    _.fileProvider.isTerminal( _.path.join( outPath, 'tests.compiled.debug/Tests.s' ) );

    var read = _.fileProvider.fileRead( _.path.join( outPath, 'compiled.debug/Main.s' ) );
    test.is( !_.strHas( read, 'dir2/-Ecluded.js' ) );
    test.is( _.strHas( read, 'dir2/File.js' ) );
    test.is( !_.strHas( read, 'dir2/File.test.js' ) );
    test.is( _.strHas( read, 'dir2/File1.debug.js' ) );
    test.is( !_.strHas( read, 'dir2/File1.release.js' ) );
    test.is( _.strHas( read, 'dir2/File2.debug.js' ) );
    test.is( !_.strHas( read, 'dir2/File2.release.js' ) );

    var read = _.fileProvider.fileRead( _.path.join( outPath, 'tests.compiled.debug/Tests.s' ) );
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

  ready
  .then( () =>
  {
    test.case = '.build raw.release'
    _.fileProvider.filesDelete( outPath );
    return null;
  })
  shell({ args : [ '.build raw.release' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './raw.release', './raw.release/dir2', './raw.release/dir2/File.js', './raw.release/dir2/File.test.js', './raw.release/dir2/File1.release.js', './raw.release/dir2/File2.release.js', './raw.release/dir3.test', './raw.release/dir3.test/File.js', './raw.release/dir3.test/File.test.js' ] );
    _.fileProvider.isTerminal( _.path.join( outPath, './raw.release/dir3.test/File.test.js' ) );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build release';
    _.fileProvider.filesDelete( outPath );
    return null;
  })
  shell({ args : [ '.build release' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './release', './release/Main.s', './tests.compiled.release', './tests.compiled.release/Tests.s' ] );
    _.fileProvider.isTerminal( _.path.join( outPath, './release/Main.s' ) );
    _.fileProvider.isTerminal( _.path.join( outPath, './tests.compiled.release/Tests.s' ) );

    var read = _.fileProvider.fileRead( _.path.join( outPath, './release/Main.s' ) );
    test.is( _.strHas( read, 'dir2/File.js' ) );
    test.is( !_.strHas( read, 'dir2/File1.debug.js' ) );
    test.is( _.strHas( read, 'dir2/File1.release.js' ) );
    test.is( !_.strHas( read, 'dir2/File2.debug.js' ) );
    test.is( _.strHas( read, 'dir2/File2.release.js' ) );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build all'
    _.fileProvider.filesDelete( outPath );
    return null;
  })
  shell({ args : [ '.build all' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './compiled.debug', './compiled.debug/Main.s', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js', './debug/dir3.test', './debug/dir3.test/File.js', './debug/dir3.test/File.test.js', './raw.release', './raw.release/dir2', './raw.release/dir2/File.js', './raw.release/dir2/File.test.js', './raw.release/dir2/File1.release.js', './raw.release/dir2/File2.release.js', './raw.release/dir3.test', './raw.release/dir3.test/File.js', './raw.release/dir3.test/File.test.js', './release', './release/Main.s', './tests.compiled.debug', './tests.compiled.debug/Tests.s', './tests.compiled.release', './tests.compiled.release/Tests.s' ] );
    return null;
  })

  /* - */

  return ready;
}

transpile.timeOut = 200000;

//

function openWith( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'open' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, 'module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* - */

  ready

  .then( () =>
  {
    test.case = '.export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [ '.', './submodule.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with . .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with . .export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [ '.', './submodule.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with doc .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc .export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with doc .export -- deleted doc.will.yml'
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.fileDelete( _.path.join( routinePath, 'doc.ex.will.yml' ) );
    _.fileProvider.fileDelete( _.path.join( routinePath, 'doc.im.will.yml' ) );
    return null;
  })

  shell({ args : [ '.with doc .export' ], throwingExitCode : 0 })

  .then( ( got ) =>
  {
    test.notIdentical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with doc. .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc. .export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with doc/. .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc/. .export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with do .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with do .export' ], throwingExitCode : 0 })

  .then( ( got ) =>
  {
    test.ni( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'unhandled errorr' ), 0 );
    test.identical( _.strCount( got.output, '====' ), 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with docx .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with docx .export' ], throwingExitCode : 0 })

  .then( ( got ) =>
  {
    test.ni( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'unhandled errorr' ), 0 );
    test.identical( _.strCount( got.output, '====' ), 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with doc/ .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc/ .export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [ '.', './submodule.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with doc/ .export -- deleted doc/.will.yml'

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.fileDelete( _.path.join( routinePath, 'doc/.ex.will.yml' ) );
    _.fileProvider.fileDelete( _.path.join( routinePath, 'doc/.im.will.yml' ) );

    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc/ .export' ], throwingExitCode : 0 })

  .then( ( got ) =>
  {
    test.ni( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'unhandled errorr' ), 0 );
    test.identical( _.strCount( got.output, '====' ), 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with doc/doc .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc/doc .export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with doc/doc. .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc/doc. .export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );

    return null;
  })

  /* - */

  return ready;
}

openWith.timeOut = 300000;

//

function openEach( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'open' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, 'module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.each . .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.each . .export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [ '.', './submodule.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [] );

    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.each doc/. .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.each doc/. .export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc.out' ) );
    test.identical( files, [] );
    var files = self.find( _.path.join( routinePath, 'doc/out' ) );
    test.identical( files, [ '.', './submodule.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );
    var files = self.find( _.path.join( routinePath, 'doc/doc.out' ) );
    test.identical( files, [ '.', './super.out.will.yml', './debug', './debug/File.debug.js', './debug/File.release.js' ] );

    return null;
  })

  /* - */

  return ready;
}

openEach.timeOut = 300000;

//

function withMixed( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-mixed' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let filePath = _.path.join( routinePath, 'file' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with module .build'
    return null;
  })

  shell({ args : [ '.with module .build' ] })
  .then( ( got ) =>
  {
    test.is( got.exitCode !== 0 );
    test.is( _.strHas( got.output, 'Found no willfile' ) );
    test.identical( _.strCount( got.output, 'unhandled errorr' ), 0 );
    test.identical( _.strCount( got.output, '====' ), 0 );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with . .build'
    return null;
  })

  shell({ args : [ '.with . .export' ] })
  .then( ( got ) =>
  {
    test.is( got.exitCode === 0 );
    test.identical( _.strCount( got.output, /Exported .*module::submodules-mixed \/ build::proto.export.* in/ ), 1 );
    return null;
  })

  /* - */

  return ready;
}

withMixed.timeOut = 300000;

//

function eachMixed( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-git' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let filePath = _.path.join( routinePath, 'file' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.each submodule::*/path::local .shell "git status"'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build' ] })
  shell({ args : [ '.each submodule::*/path::local .shell "git status"' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'git status' ) );
    test.is( _.strHas( got.output, 'On branch master' ) );
    test.is( _.strHas( got.output, `Your branch is up to date with 'origin/master'.` ) );

    test.is( _.strHas( got.output, /eachMixed\/\.module\/Tools\/out\/wTools\.out\.will\.yml[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/\.module\/Tools[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/\.module\/PathFundamentals[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/out\/UriFundamentals\.informal\.out\.will\.yml[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/out\/UriFundamentals[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/out\/Proto\.informal\.out\.will\.yml[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/out\/Proto\.informal\.out\.will\.yml[^d]/ ) );
    test.is( _.strHas( got.output, /eachMixed\/out\/Proto[^d]/ ) );

    test.identical( _.strCount( got.output, 'git status' ), 5 );
    test.identical( _.strCount( got.output, 'nothing to commit, working tree clean' ), 4 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.each submodule:: .shell ls'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build' ] })
  shell({ args : [ '.each submodule:: .shell ls -al' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'ls -al' ), 5 );
    test.identical( _.strCount( got.output, 'Module at' ), 4 );

    test.identical( _.strCount( got.output, '.module/Tools/out/wTools.out.will.yml' ), 1 );
    test.identical( _.strCount( got.output, '.module/PathFundamentals/out/wPathFundamentals.out.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'out/UriFundamentals.informal.out.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'out/Proto.informal.out.will.yml' ), 1 );

    test.identical( _.strCount( got.output, '.module/Tools/out/wTools' ), 2 );
    test.identical( _.strCount( got.output, '.module/PathFundamentals/out/wPathFundamentals' ), 2 );
    test.identical( _.strCount( got.output, 'out/UriFundamentals.informal' ), 2 );
    test.identical( _.strCount( got.output, 'out/Proto.informal' ), 2 );

    return null;
  })

  /* - */

  return ready;
}

eachMixed.timeOut = 300000;

//

function withList( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-with-submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  shell({ args : '.with . .resources.list about::name' })
  .finally( ( err, got ) =>
  {
    test.case = '.with . .resources.list about::name';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'withList/.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'module-' ), 1 );
    return null;
  })

  /* - */

  shell({ args : '.with . .resources.list about::description' })
  .finally( ( err, got ) =>
  {
    test.case = '.with . .resources.list about::description';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'withList/.will.yml' ), 1 );
    test.identical( _.strCount( got.output, 'Module for testing' ), 1 );
    return null;
  })

  /* - */

  shell({ args : '.with . .resources.list path::module.dir' })
  .finally( ( err, got ) =>
  {
    test.case = '.with . .resources.list path::module.dir';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'withList/.will.yml' ), 1 );
    test.identical( _.strCount( got.output, routinePath + '/' ), 2 );
    return null;
  })

  /* - */

  return ready;
}

//

function eachList( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'each-list' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  shell({ args : '.clean' })

  /* - */

  shell({ args : '.each . .resources.list about::name' })
  .finally( ( err, got ) =>
  {
    test.case = '.each . .resources.list about::name';
    test.is( !err );
    test.identical( got.exitCode, 0 );
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

  shell({ args : '".imply v:1 ; .each . .resources.list about::name"' })
  .finally( ( err, got ) =>
  {
    test.case = '".imply v:1 ; .each . .resources.list about::name"';
    test.is( !err );
    test.identical( got.exitCode, 0 );
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

  shell({ args : '".imply v:1 ; .each . .resources.list path::module.common"' })
  .finally( ( err, got ) =>
  {
    test.case = '".imply v:1 ; .each . .resources.list path::module.common"';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'Module at' ), 0 );
    test.identical( _.strCount( got.output, routinePath ), 6 );
    test.identical( _.strLinesCount( got.output ), 8 );

    test.identical( _.strCount( got.output, routinePath + '/' ), 6 );
    test.identical( _.strCount( got.output, routinePath + '/a' ), 2 );
    test.identical( _.strCount( got.output, routinePath + '/ab-named' ), 1 );
    test.identical( _.strCount( got.output, routinePath + '/b' ), 2 );
    test.identical( _.strCount( got.output, routinePath + '/bc-named' ), 1 );
    test.identical( _.strCount( got.output, routinePath + '/c' ), 1 );

    return null;
  })

  /* - */

  shell({ args : '".imply v:1 ; .each * .resources.list path::module.common"' })
  .finally( ( err, got ) =>
  {
    test.case = '".imply v:1 ; .each * .resources.list path::module.common"';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'Module at' ), 0 );
    test.identical( _.strCount( got.output, routinePath ), 6 );
    test.identical( _.strLinesCount( got.output ), 8 );

    test.identical( _.strCount( got.output, routinePath + '/' ), 6 );
    test.identical( _.strCount( got.output, routinePath + '/a' ), 2 );
    test.identical( _.strCount( got.output, routinePath + '/ab-named' ), 1 );
    test.identical( _.strCount( got.output, routinePath + '/b' ), 2 );
    test.identical( _.strCount( got.output, routinePath + '/bc-named' ), 1 );
    test.identical( _.strCount( got.output, routinePath + '/c' ), 1 );

    return null;
  })

  /* - */

  shell({ args : '".imply v:1 ; .each */* .resources.list path::module.common"' })
  .finally( ( err, got ) =>
  {
    test.case = '".imply v:1 ; .each */* .resources.list path::module.common"';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'Module at' ), 0 );
    test.identical( _.strCount( got.output, routinePath ), 9 );
    test.identical( _.strLinesCount( got.output ), 11 );

    test.identical( _.strCount( got.output, routinePath + '/' ), 9 );
    test.identical( _.strCount( got.output, routinePath + '/a' ), 5 );
    test.identical( _.strCount( got.output, routinePath + '/ab-named' ), 1 );
    test.identical( _.strCount( got.output, routinePath + '/b' ), 2 );
    test.identical( _.strCount( got.output, routinePath + '/bc-named' ), 1 );
    test.identical( _.strCount( got.output, routinePath + '/c' ), 1 );
    test.identical( _.strCount( got.output, routinePath + '/aabc' ), 1 );
    test.identical( _.strCount( got.output, routinePath + '/ab' ), 3 );
    test.identical( _.strCount( got.output, routinePath + '/abac' ), 1 );

    return null;
  })

  /* - */

  return ready;
}

eachList.timeOut = 300000;

//

/*
if one or several willfiles are broken .each should go past and output error
*/

function eachBrokenIll( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'each-broken' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  shell({ args : '.imply v:1 ; .each */* .resources.list path::module.common' })
  .finally( ( err, got ) =>
  {
    test.case = '.imply v:1 ; .each */* .resources.list path::module.common';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'Failed to resolve' ), 0 );
    test.identical( _.strCount( got.output, 'eachBrokenIll/' ), 5 );

    return null;
  })

  // /* - */
  //
  // shell({ args : '.imply v:1 ; .each */* .resources.list path::module.common' })
  // .finally( ( err, got ) =>
  // {
  //   test.case = '.imply v:1 ; .each */* .resources.list path::module.common';
  //   test.is( !err );
  //   test.notIdentical( got.exitCode, 0 );
  //   test.identical( _.strCount( got.output, 'Failed to resolve' ), 1 );
  //   test.identical( _.strCount( got.output, 'eachBrokenIll/' ), 4 );
  //
  //   return null;
  // })

  /* - */

  return ready;
}

//

/*
utility should not try to open non-willfiles
*/

function eachBrokenNon( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'open-non-willfile' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  shell({ args : '.each */* .paths.list' })
  .finally( ( err, got ) =>
  {
    test.case = '.each */* .paths.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'Read 1 willfile' ), 1 );
    test.identical( _.strCount( got.output, 'Module at' ), 1 );
    test.identical( _.strCount( got.output, 'Paths' ), 1 );
    return null;
  })

  /* - */

  return ready;
}

//

/*
utility should handle properly illformed second command
tab should not be accumulated in the output
*/

function eachBrokenCommand( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-with-submodules-few' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
  _.fileProvider.filesDelete({ filePath : outPath })

  /* - */

  shell({ args : '.each */* .resource.list path::module.common' })
  .finally( ( err, got ) =>
  {
    test.case = '.each */* .resource.list path::module.common';
    test.is( !err );
    test.notIdentical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'Unknown subject ".resource.list"' ), 1 );
    test.identical( _.strCount( got.output, 'Module at' ), 3 );
    test.identical( _.strCount( got.output, '      ' ), 0 );
    return null;
  })

  /* - */

  return ready;
}

//

function verbositySet( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  ready

  /* - */

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.imply verbosity:3 ; .build' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.imply verbosity:3 ; .build';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, '.imply verbosity:3 ; .build' ) );
    test.is( _.strHas( got.output, / \. Read .+\/\.im\.will\.yml/ ) );
    test.is( _.strHas( got.output, / \. Read .+\/\.ex\.will\.yml/ ) );
    test.is( _.strHas( got.output, / .*!.* Failed to read .+submodule::Tools.+/ ) );
    test.is( _.strHas( got.output, / .*!.* Failed to read .+submodule::PathFundamentals.+/ ) );
    test.is( _.strHas( got.output, '. Read 2 willfile(s) in' ) );

    test.is( _.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, / \+ 2\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );
    test.is( _.strHas( got.output, / - .*step::delete.out.debug.* deleted 0 file\(s\)/ ) );
    test.is( _.strHas( got.output, / \+ .*reflector::reflect.proto.debug.* reflected 2 files/ ) );
    test.is( _.strHas( got.output, / \+ .*reflector::reflect.submodules.* reflected/ ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    return null;
  })

  /* - */

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.imply verbosity:2 ; .build' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.imply verbosity:2 ; .build';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, '.imply verbosity:2 ; .build' ) );
    test.is( !_.strHas( got.output, / \. Read .+\/\.im\.will\.yml/ ) );
    test.is( !_.strHas( got.output, / \. Read .+\/\.ex\.will\.yml/ ) );
    test.is( !_.strHas( got.output, / .*!.* Failed to read .+submodule::Tools.+/ ) );
    test.is( !_.strHas( got.output, / .*!.* Failed to read .+submodule::PathFundamentals.+/ ) );
    test.is( _.strHas( got.output, '. Read 2 willfile(s) in' ) );

    test.is( _.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, / \+ 2\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );
    test.is( _.strHas( got.output, / - .*step::delete.out.debug.* deleted 0 file\(s\)/ ) );
    test.is( _.strHas( got.output, / \+ .*reflector::reflect.proto.debug.* reflected 2 files/ ) );
    test.is( _.strHas( got.output, / \+ .*reflector::reflect.submodules.* reflected/ ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    return null;
  })

  /* - */

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.imply verbosity:1 ; .build' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.imply verbosity:1 ; .build';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, '.imply verbosity:1 ; .build' ) );
    test.is( !_.strHas( got.output, / \. Read .+\/\.im\.will\.yml/ ) );
    test.is( !_.strHas( got.output, / \. Read .+\/\.ex\.will\.yml/ ) );
    test.is( !_.strHas( got.output, / .*!.* Failed to read .+submodule::Tools.+/ ) );
    test.is( !_.strHas( got.output, / .*!.* Failed to read .+submodule::PathFundamentals.+/ ) );
    test.is( !_.strHas( got.output, '. Read 2 willfile(s) in' ) );

    test.is( !_.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( !_.strHas( got.output, / \+ 2\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );
    test.is( !_.strHas( got.output, ' - Deleted' ) );
    test.is( !_.strHas( got.output, ' + reflect.proto.debug reflected 2 files ' ) );
    test.is( !_.strHas( got.output, ' + reflect.submodules reflected' ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    return null;
  })

  /* - */

  return ready;
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
  let originalDirPath = _.path.join( self.assetDirPath, 'verbosity-step-delete' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let modulePath = _.path.join( routinePath, 'module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.build files.delete.vd';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })

  shell({ args : [ '.build files.delete.vd' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.vd.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\/, found in / ), 1 );

    var files = self.find( _.path.join( routinePath, 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.build files.delete.v0';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })

  shell({ args : [ '.build files.delete.v0' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v0.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\/, found in / ), 0 );
    test.identical( _.strCount( got.output, 'Deleted' ), 0 );

    var files = self.find( _.path.join( routinePath, 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.build files.delete.v1';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })

  shell({ args : [ '.build files.delete.v1' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v1.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\/, found in / ), 1 );

    var files = self.find( _.path.join( routinePath, 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.build files.delete.v3';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })

  shell({ args : [ '.build files.delete.v3' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 1 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 1 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 1 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v3.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\/, found in / ), 1 );

    var files = self.find( _.path.join( routinePath, 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '".imply v:0 ; .build files.delete.vd"';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })

  shell({ args : [ '".imply v:0 ; .build files.delete.vd"' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.vd.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\/, found in / ), 0 );
    test.identical( _.strLinesCount( got.output ), 2 );

    var files = self.find( _.path.join( routinePath, 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '".imply v:8 ; .build files.delete.v0"';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })

  shell({ args : [ '".imply v:8 ; .build files.delete.v0"' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v0.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\/, found in / ), 0 );

    var files = self.find( _.path.join( routinePath, 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '".imply v:9 ; .build files.delete.v0"';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })

  shell({ args : [ '".imply v:9 ; .build files.delete.v0"' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 1 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 1 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 1 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v0.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\/, found in / ), 1 );

    var files = self.find( _.path.join( routinePath, 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '".imply v:1 ; .build files.delete.v3"';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })

  shell({ args : [ '".imply v:1 ; .build files.delete.v3"' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 0 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 0 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 0 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v3.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\/, found in / ), 1 );

    var files = self.find( _.path.join( routinePath, 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '".imply v:2 ; .build files.delete.v3"';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })

  shell({ args : [ '".imply v:2 ; .build files.delete.v3"' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'proto' ) ) );

    test.identical( _.strCount( got.output, /3 at .*\/verbosityStepDelete\/proto\// ), 1 );
    test.identical( _.strCount( got.output, '2 at ./A' ), 1 );
    test.identical( _.strCount( got.output, '1 at ./B' ), 1 );
    test.identical( _.strCount( got.output, /- .*step::files.delete.v3.* deleted 3 file\(s\), at .*\/verbosityStepDelete\/proto\/, found in / ), 1 );

    var files = self.find( _.path.join( routinePath, 'proto' ) );
    test.identical( files, [ '.' ] );

    return null;
  })

  /* - */

  return ready;
}

verbosityStepDelete.timeOut = 200000;

//

/*
  Checks printing name of step before it execution
*/

function verbosityStepPrintName( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'verbosity-step-print-name' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready
  .then( ( arg ) =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return arg;
  })

  shell({ args : [ '".imply v:4 ; .build"' ] })

  .then( ( got ) =>
  {
    test.description = '".imply v:4 ; .build"';

    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Building .*module::verbosityStepPrintName \/ build::debug/ ), 1 );
    test.identical( _.strCount( got.output, /: .*reflector::reflect.file.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*reflector::reflect.file.* reflected 1 files .* : .*out.* <- .*file.* in / ), 1 );
    test.identical( _.strCount( got.output, /.*>.*node -e "console.log\( 'shell.step' \)"/ ), 1 );
    test.identical( _.strCount( got.output, /at.* .*verbosityStepPrintName/ ), 3 );
    test.identical( _.strCount( got.output, 'shell.step' ), 2 );
    test.identical( _.strCount( got.output, /: .*step::delete.step.*/ ), 1 );
    test.identical( _.strCount( got.output, /1 at .*\/out/ ), 1 );
    test.identical( _.strCount( got.output, /1 at \./ ), 1 );
    test.identical( _.strCount( got.output, /- .*step::delete.step.* deleted 1 file\(s\), at .*verbosityStepPrintName\/out.*, found in/ ), 1 );
    test.identical( _.strCount( got.output, /Built .*module::verbosityStepPrintName \/ build::debug.* in / ), 1 );

    return null;
  })

  /* - */

  ready
  .then( ( arg ) =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return arg;
  })

  shell({ args : [ '".imply v:3 ; .build"' ] })

  .then( ( got ) =>
  {
    test.description = '".imply v:3 ; .build"';

    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Building .*module::verbosityStepPrintName \/ build::debug/ ), 1 );
    test.identical( _.strCount( got.output, /: .*reflector::reflect.file.*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*reflector::reflect.file.* reflected 1 files .* : .*out.* <- .*file.* in / ), 1 );
    test.identical( _.strCount( got.output, /.*>.*node -e "console.log\( 'shell.step' \)"/ ), 1 );
    test.identical( _.strCount( got.output, /at.* .*verbosityStepPrintName/ ), 1 );
    test.identical( _.strCount( got.output, 'shell.step' ), 2 );
    test.identical( _.strCount( got.output, /: .*step::delete.step.*/ ), 0 );
    test.identical( _.strCount( got.output, /1 at .*\/out/ ), 0 );
    test.identical( _.strCount( got.output, /1 at \./ ), 0 );
    test.identical( _.strCount( got.output, /- .*step::delete.step.* deleted 1 file\(s\), at .*verbosityStepPrintName\/out.*, found in/ ), 1 );
    test.identical( _.strCount( got.output, /Built .*module::verbosityStepPrintName \/ build::debug.* in / ), 1 );

    return null;
  })

  /* - */

  ready
  .then( ( arg ) =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return arg;
  })

  shell({ args : [ '".imply v:2 ; .build"' ] })

  .then( ( got ) =>
  {
    test.description = '".imply v:2 ; .build"';

    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Building .*module::verbosityStepPrintName \/ build::debug/ ), 1 );
    test.identical( _.strCount( got.output, /: .*reflector::reflect.file.*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*reflector::reflect.file.* reflected 1 files .* : .*out.* <- .*file.* in / ), 1 );
    test.identical( _.strCount( got.output, /.*>.*node -e "console.log\( 'shell.step' \)"/ ), 1 );
    test.identical( _.strCount( got.output, /at.* .*verbosityStepPrintName/ ), 1 );
    test.identical( _.strCount( got.output, 'shell.step' ), 1 );
    test.identical( _.strCount( got.output, /: .*step::delete.step.*/ ), 0 );
    test.identical( _.strCount( got.output, /1 at .*\/out/ ), 0 );
    test.identical( _.strCount( got.output, /1 at \./ ), 0 );
    test.identical( _.strCount( got.output, /- .*step::delete.step.* deleted 1 file\(s\), at .*verbosityStepPrintName\/out.*, found in/ ), 1 );
    test.identical( _.strCount( got.output, /Built .*module::verbosityStepPrintName \/ build::debug.* in / ), 1 );

    return null;
  })

  /* - */

  ready
  .then( ( arg ) =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return arg;
  })

  shell({ args : [ '".imply v:1 ; .build"' ] })

  .then( ( got ) =>
  {
    test.description = '".imply v:1 ; .build"';

    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Building .*module::verbosityStepPrintName \/ build::debug/ ), 0 );
    test.identical( _.strCount( got.output, /: .*reflector::reflect.file.*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*reflector::reflect.file.* reflected 1 files .* : .*out.* <- .*file.* in / ), 0 );
    test.identical( _.strCount( got.output, /.*>.*node -e "console.log\( 'shell.step' \)"/ ), 0 );
    test.identical( _.strCount( got.output, /at.* .*verbosityStepPrintName/ ), 0 );
    test.identical( _.strCount( got.output, 'shell.step' ), 0 );
    test.identical( _.strCount( got.output, /: .*step::delete.step.*/ ), 0 );
    test.identical( _.strCount( got.output, /1 at .*\/out/ ), 0 );
    test.identical( _.strCount( got.output, /1 at \./ ), 0 );
    test.identical( _.strCount( got.output, /- .*step::delete.step.* deleted 1 file\(s\), at .*verbosityStepPrintName\/out.*, found in/ ), 0 );
    test.identical( _.strCount( got.output, /Built .*module::verbosityStepPrintName \/ build::debug.* in / ), 1 );

    return null;
  })

  /* - */

/*
  Building module::verbosity-step-print-name / build::debug
   : reflector::reflect.file
   + reflector::reflect.file reflected 1 files /C/pro/web/Dave/git/trunk/builder/include/dwtools/atop/will.test/asset/verbosity-step-print-name/ : out <- file in 0.290s
 > node -e "console.log( 'shell.step' )"
   at /C/pro/web/Dave/git/trunk/builder/include/dwtools/atop/will.test/asset/verbosity-step-print-name
shell.step
   : step::delete.step
     1 at /C/pro/web/Dave/git/trunk/builder/include/dwtools/atop/will.test/asset/verbosity-step-print-name/out
     1 at .
   - step::delete.step deleted 1 file(s), at /C/pro/web/Dave/git/trunk/builder/include/dwtools/atop/will.test/asset/verbosity-step-print-name/out, found in 0.017s
  Built module::verbosity-step-print-name / build::debug in 0.643s
*/

  return ready;
}

//

function help( test )
{
  let self = this;
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    outputCollecting : 1,
    ready : ready
  })

  /* */

  shell({ args : [ '.help' ] })
  .then( ( arg ) =>
  {
    test.identical( arg.exitCode, 0 );
    test.ge( _.strLinesCount( arg.output ), 24 );
    return arg;
  })

  //

  shell({ args : [ '.' ] })
  .then( ( arg ) =>
  {
    test.identical( arg.exitCode, 0 );
    test.ge( _.strLinesCount( arg.output ), 24 );
    return arg;
  })

  //

  shell({ args : [] })
  .then( ( arg ) =>
  {
    test.identical( arg.exitCode, 0 );
    test.ge( _.strLinesCount( arg.output ), 24 );
    return arg;
  })

  return ready;
}

//

function listSingleModule( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'single' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  shell({ args : [ '.resources.list' ] })
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

  shell({ args : [ '.about.list' ] })
  .then( ( got ) =>
  {
    test.case = '.about.list'

    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, `name : 'single'` ));
    test.is( _.strHas( got.output, `description : 'Module for testing'` ));
    test.is( _.strHas( got.output, `version : '0.0.1'` ));
    test.is( _.strHas( got.output, `enabled : 1` ));
    test.is( _.strHas( got.output, `interpreters :` ));
    test.is( _.strHas( got.output, `'nodejs >= 6.0.0'` ));
    test.is( _.strHas( got.output, `'chrome >= 60.0.0'` ));
    test.is( _.strHas( got.output, `'firefox >= 60.0.0'` ));
    test.is( _.strHas( got.output, `'nodejs >= 6.0.0'` ));
    test.is( _.strHas( got.output, `keywords :` ));
    test.is( _.strHas( got.output, `'wTools'` ));

    return null;
  })

  /* - */

  shell({ args : [ '.paths.list' ] })
  .then( ( got ) =>
  {
    test.case = 'module info'
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, `proto : ./proto` ) );
    test.is( _.strHas( got.output, `in : .` ) );
    test.is( _.strHas( got.output, `out : out` ) );
    test.is( _.strHas( got.output, `out.debug : ./out/debug` ) );
    test.is( _.strHas( got.output, `out.release : ./out/release` ) );

    // test.is( _.strHas( got.output, `proto : './proto'` ) );
    // test.is( _.strHas( got.output, `in : '.'` ) );
    // test.is( _.strHas( got.output, `out : 'out'` ) );
    // test.is( _.strHas( got.output, `out.debug : './out/debug'` ) );
    // test.is( _.strHas( got.output, `out.release : './out/release'` ) );

    return null;
  })

  shell({ args : [ '.submodules.list' ] })
  .then( ( got ) =>
  {
    test.case = 'submodules list'
    test.identical( got.exitCode, 0 );
    test.is( got.output.length );
    return null;
  })

  /* - */

  shell({ args : [ '.reflectors.list' ] })
  .then( ( got ) =>
  {
    test.case = 'reflectors.list'
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'reflector::reflect.proto.' ) );
    test.is( _.strHas( got.output, `. : .` ) );
    test.is( _.strHas( got.output, `prefixPath : proto` ) );
    test.is( _.strHas( got.output, `prefixPath : out/release` ) );

    test.is( _.strHas( got.output, `reflector::reflect.proto.debug` ) );
    test.is( _.strHas( got.output, `. : .` ) );
    test.is( _.strHas( got.output, `prefixPath : proto` ) );
    test.is( _.strHas( got.output, `prefixPath : out/debug` ) );

    return null;
  })

  /* - */

  shell({ args : [ '.steps.list' ] })
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

  shell({ args : [ '.builds.list' ] })
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

  shell({ args : [ '.exports.list' ] })
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

  shell({ args : [ '.resources.list *a* predefined:0' ] })
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

  shell({ args : [ '.resources.list *p* debug:1' ] })
  .then( ( got ) =>
  {
    test.case = 'resources list globs negative';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflector::predefined.debug.v1'  ) );
    test.is( _.strHas( got.output, 'reflector::reflect.proto.debug' ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug.raw' ) );
    test.is( _.strHas( got.output, 'step::export.proto' ) );
    test.is( _.strHas( got.output, 'build::debug.compiled' ) );
    test.is( _.strHas( got.output, 'build::proto.export' ) );
    test.identical( _.strCount( got.output, '::' ), 20 );

    return null;
  })

  /* Glob using positive test */
  shell({ args : [ '.resources.list *proto*' ] })
  .then( ( got ) =>
  {
    test.case = 'resources list globs';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'reflector::reflect.proto.'  ) );
    test.is( _.strHas( got.output, `. : .` ) );

    test.is( _.strHas( got.output, 'step::reflect.proto.'  ) );
    test.is( _.strHas( got.output, `files.reflect` ) );

    test.is( _.strHas( got.output, 'build::proto.export'  ) );
    test.is( _.strHas( got.output, `step::export.proto` ) );

    return null;
  })

  /* Glob and criterion using negative test */
  shell({ args : [ '.resources.list *proto* debug:0' ] })
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
  shell({ args : [ '.resources.list *proto* debug:0 predefined:0' ] })
  .then( ( got ) =>
  {
    test.case = 'globs and criterions positive';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'path::proto'  ) );

    test.is( _.strHas( got.output, 'reflector::reflect.proto.'  ) );
    test.is( _.strHas( got.output, `. : .` ) );

    test.is( _.strHas( got.output, 'step::reflect.proto.'  ) );
    test.is( _.strHas( got.output, `files.reflect` ) );

    test.identical( _.strCount( got.output, '::' ), 10 );

    return null;
  })

  /* Glob and two criterions using negative test */
  shell({ args : [ '.resources.list * debug:1 raw:0 predefined:0' ] })
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
    test.identical( _.strCount( got.output, '::' ), 18 );

    return null;
  })

  /* Glob and two criterion using positive test */
  shell({ args : [ '.resources.list * debug:0 raw:1' ] })
  .then( ( got ) =>
  {
    test.case = '.resources.list * debug:0 raw:1';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'step::reflect.proto.raw'  ) );
    test.is( _.strHas( got.output, 'build::release.raw'  ) );
    test.identical( _.strCount( got.output, '::' ), 7 );

    return null;
  })

  return ready;
}

listSingleModule.timeOut = 200000;

//

function listWithSubmodulesSimple( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  shell({ args : [ '.resources.list' ] })

  .then( ( got ) =>
  {
    test.case = 'module info';
    debugger;
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `name : 'submodules'` ) );
    test.is( _.strHas( got.output, `description : 'Module for testing'` ) );
    test.is( _.strHas( got.output, `version : '0.0.1'` ) );
    return null;
  })

  return ready;
}

listWithSubmodulesSimple.timeOut = 200000;

//

function listWithSubmodules( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  shell({ args : [ '.submodules.list' ] })

  .then( ( got ) =>
  {
    test.case = 'submodules list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'submodule::Tools' ) );
    test.is( _.strHas( got.output, 'submodule::PathFundamentals' ) );
    return null;
  })

  /* - */

  shell({ args : [ '.reflectors.list' ] })

  .then( ( got ) =>
  {
    test.case = 'reflectors.list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflector::reflect.proto.' ))
    test.is( _.strHas( got.output, `reflector::reflect.proto.debug` ))
    return null;
  })

  /* - */

  shell({ args : [ '.steps.list' ] })

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

  shell({ args : [ '.builds.list' ] })

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

  shell({ args : [ '.exports.list' ] })

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

  shell({ args : [ '.about.list' ] })

  .then( ( got ) =>
  {
    test.case = '.about.list'

    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, `name : 'submodules'` ));
    test.is( _.strHas( got.output, `description : 'Module for testing'` ));
    test.is( _.strHas( got.output, `version : '0.0.1'` ));
    test.is( _.strHas( got.output, `enabled : 1` ));
    test.is( _.strHas( got.output, `interpreters :` ));
    test.is( _.strHas( got.output, `'nodejs >= 6.0.0'` ));
    test.is( _.strHas( got.output, `'chrome >= 60.0.0'` ));
    test.is( _.strHas( got.output, `'firefox >= 60.0.0'` ));
    test.is( _.strHas( got.output, `'nodejs >= 6.0.0'` ));
    test.is( _.strHas( got.output, `keywords :` ));
    test.is( _.strHas( got.output, `'wTools'` ));

    return null;
  })

  // /* - */
  //
  // shell({ args : [ '.execution.list' ] })
  //
  // .then( ( got ) =>
  // {
  //   test.case = '.execution.list'
  //   test.identical( got.exitCode, 0 );
  //   test.is( got.output.length );
  //   return null;
  // })

  return ready;
}

listWithSubmodules.timeOut = 200000;

//

function listSteps( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  ready

  /* - */

  shell({ args : [ '.steps.list' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.steps.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'step::delete.out.debug' ) );
    test.is( _.strHas( got.output, /step::reflect\.proto\.[^d]/ ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ) );
    test.is( _.strHas( got.output, 'step::reflect.submodules' ) );
    test.is( _.strHas( got.output, 'step::export.proto' ) );

    return null;
  })

  /* - */

  shell({ args : [ '.steps.list *' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.steps.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'step::delete.out.debug' ) );
    test.is( _.strHas( got.output, /step::reflect\.proto\.[^d]/ ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ) );
    test.is( _.strHas( got.output, 'step::reflect.submodules' ) );
    test.is( _.strHas( got.output, 'step::export.proto' ) );

    return null;
  })

  /* - */

  shell({ args : [ '.steps.list *proto*' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.steps.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.is( !_.strHas( got.output, 'step::delete.out.debug' ) );
    test.is( _.strHas( got.output, /step::reflect\.proto\.[^d]/ ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ) );
    test.is( !_.strHas( got.output, 'step::reflect.submodules' ) );
    test.is( _.strHas( got.output, 'step::export.proto' ) );

    return null;
  })

  /* - */

  shell({ args : [ '.steps.list *proto* debug:1' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.steps.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.is( !_.strHas( got.output, 'step::delete.out.debug' ) );
    test.is( !_.strHas( got.output, /step::reflect\.proto\.[^d]/ ) );
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ) );
    test.is( !_.strHas( got.output, 'step::reflect.submodules' ) );
    test.is( _.strHas( got.output, 'step::export.proto' ) );

    return null;
  })

  /* - */

  return ready;
}

//

function listComplexPaths( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-with-submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  shell({ args : [ '.each */* .export' ] })
  shell({ args : [ '.with ab/ .resources.list' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.with ab/ .resources.list';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'About' ), 1 );
    test.identical( _.strCount( got.output, 'module::module-ab / path::export' ), 1 );
    test.identical( _.strCount( got.output, 'module::module-ab /' ), 43 );

    return null;
  })

  /* - */

  return ready;
}

//

function clean( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'clean' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath + '',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* - */

  shell
  ({
    args : [ '.with NoTemp .build' ]
  })

  var files;
  ready
  .then( () =>
  {
    files = self.find( submodulesPath );
    test.is( files.length > 50 );
    return files;
  })

  shell({ args : [ '.with NoTemp .clean' ] })
  .then( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted ' + files.length + ' file(s)' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* phantom problem ? */
    return null;
  })

  shell({ args : [ '.with NoTemp .clean' ] })
  .then( ( got ) =>
  {
    test.case = '.with NoTemp .clean -- second';
    test.identical( got.exitCode, 0 );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    return null;
  })

  /* - */

  var files = [];
  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( outPath );
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  shell({ args : [ '.with NoBuild .clean' ] })
  .then( ( got ) =>
  {
    test.case = '.with NoBuild .clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted ' + 0 + ' file(s)' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    return null;
  })

  /* - */

  var files = [];
  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( outPath );
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  shell({ args : [ '.with Build .build' ] })
  shell({ args : [ '.with Vector .clean' ] })
  .then( ( got ) =>
  {
    test.case = '.with NoBuild .clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '- Clean deleted 2 file(s)' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'out' ) ) );
    return null;
  })

  /* - */

  return ready;
}

clean.timeOut = 300000;

//

function cleanSingleModule( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'single' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  /* - */

  shell({ execPath : [ '.build', '.clean' ] })

  .then( ( got ) =>
  {
    debugger;
    test.case = '.clean '
    test.identical( got[ 0 ].exitCode, 0 );
    test.identical( got[ 1 ].exitCode, 0 );
    test.is( _.strHas( got[ 1 ].output, 'Clean deleted 0 file(s)' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )
    return null;
  })

  /* - */

  shell({ execPath : [ '.build', '.clean dry:1' ] })

  .then( ( got ) =>
  {
    test.case = '.clean dry:1'
    test.identical( got[ 0 ].exitCode, 0 );
    test.identical( got[ 1 ].exitCode, 0 );
    test.is( _.strHas( got[ 1 ].output, 'Clean will delete 0 file(s)' ) );
    return null;
  })

  /* - */

  return ready;
}

cleanSingleModule.timeOut = 200000;

//

function cleanBroken1( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-broken-1' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let outDebugPath = _.path.join( routinePath, 'out/debug' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  test.description = 'should handle currputed willfile properly';

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  ready

  /* - */

  .then( ( got ) =>
  {
    test.case = '.clean ';

    var files = self.find( submodulesPath );
    test.identical( files.length, 4 );

    return null;
  })

  /* - */

  shell({ args : [ '.clean dry:1' ] })

  .then( ( got ) =>
  {
    test.case = '.clean dry:1';

    var files = self.find( submodulesPath );

    test.identical( files.length, 4 );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, String( files.length ) + ' at ' ) );
    test.is( _.strHas( got.output, 'Clean will delete ' + String( files.length ) + ' file(s)' ) );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) );

    return null;
  })

  /* - */

  shell({ args : [ '.clean' ] })

  .then( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* filesDelete issue? */
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) );
    return null;
  })

  /* */

  shell({ args : [ '.export' ] })
  .then( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

    var files = self.find( outDebugPath );
    test.is( files.length > 10 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  });

  /* */

  shell({ args : [ '.export' ] })
  .then( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

    var files = self.find( outDebugPath );
    test.is( files.length > 10 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  return ready;
}

cleanBroken1.timeOut = 200000;

//

function cleanBroken2( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-broken-2' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let outDebugPath = _.path.join( routinePath, 'out/debug' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  test.description = 'should handle currputed willfile properly';

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  ready

  /* - */

  .then( ( got ) =>
  {
    test.case = '.clean ';

    var files = self.find( submodulesPath );

    test.identical( files.length, 4 );

    return null;
  })

  /* - */

  shell({ args : [ '.clean dry:1' ] })

  .then( ( got ) =>
  {
    test.case = '.clean dry:1';

    var files = self.find( submodulesPath );

    test.identical( files.length, 4 );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, String( files.length ) ) );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) );

    return null;
  })

  /* - */

  shell({ args : [ '.clean' ] })

  .then( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* filesDelete issue? */
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) );
    return null;
  })

  /* */

  shell({ args : [ '.export' ] })
  .then( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

    var files = self.find( outDebugPath );
    test.is( files.length > 10 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  });

  /* */

  shell({ args : [ '.export' ] })
  .then( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

    var files = self.find( outDebugPath );
    test.is( files.length > 10 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  return ready;
}

cleanBroken2.timeOut = 200000;

//

function cleanBrokenSubmodules( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'clean-broken-submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready

  /* - */

  .then( ( got ) =>
  {
    test.case = 'setup';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    var files = self.find( submodulesPath );
    test.identical( files.length, 4 );
    var files = self.find( outPath );
    test.identical( files.length, 2 );

    return null;
  })

  /* - */

  shell({ args : [ '.clean dry:1' ] })
  .then( ( got ) =>
  {
    test.case = '.clean dry:1';

    var files = self.find( submodulesPath );
    test.identical( files.length, 4 );
    var files = self.find( outPath );
    test.identical( files.length, 2 );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '/.module' ) );
    test.is( _.strHas( got.output, '/out' ) );

    return null;
  })

  /* - */

  shell({ args : [ '.clean' ] })
  .then( ( got ) =>
  {
    test.case = '.clean';

    var files = self.find( submodulesPath );
    test.identical( files.length, 0 );
    var files = self.find( outPath );
    test.identical( files.length, 0 );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '6 file(s)' ) );

    return null;
  })

  /* - */

  return ready;
}

cleanBrokenSubmodules.timeOut = 200000;


//

function cleanNoBuild( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'clean' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath + ' .with NoBuild',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* - */

  shell({ args : [ '.clean' ] })
  .then( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted ' + 0 + ' file(s)' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* phantom problem ? */
    return null;
  })

  shell({ args : [ '.clean -- second' ] })
  .then( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    return null;
  })

  /* - */

  return ready;
}

cleanNoBuild.timeOut = 200000;

//

function cleanDry( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'clean' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath + ' .with NoTemp',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* - */

  shell
  ({
    args : [ '.submodules.update' ],
  })

  .then( ( got ) =>
  {
    test.is( _.strHas( got.output, /2\/2 submodule\(s\) of .*module::submodules.* were updated in/ ) );
    var files = self.find( submodulesPath );
    test.is( files.length > 100 );
    return null;
  })

  shell
  ({
    args : [ '.build' ],
  })
  .then( ( got ) =>
  {
    test.is( _.strHas( got.output, /0\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );
    return got;
  })

  var wasFiles;

  shell({ args : [ '.clean dry:1' ] })

  .then( ( got ) =>
  {
    test.case = '.clean dry:1';

    debugger;
    var files = self.find( outPath );
    test.is( files.length > 25 );
    var files = wasFiles = self.find( submodulesPath );
    test.is( files.length > 100 );
    debugger;

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, String( files.length ) + ' at ' ) );
    test.is( _.strHas( got.output, 'Clean will delete ' + String( files.length ) + ' file(s)' ) );
    test.is( _.fileProvider.isDir( _.path.join( routinePath, '.module' ) ) ); /* phantom problem ? */
    test.is( _.fileProvider.isDir( _.path.join( routinePath, 'out' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) );

    return null;
  })

  /* - */

  return ready;
}

cleanDry.timeOut = 300000;

//

function cleanSubmodules( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'clean' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath + ' .with NoTemp',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* */

  shell({ args : [ '.submodules.update' ] })
  .then( ( got ) =>
  {
    test.case = '.submodules.update'
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'Tools' ) ) )
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'PathFundamentals' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )

    var files = self.find( _.path.join( submodulesPath, 'Tools' ) );
    test.is( files.length );

    var files = self.find( _.path.join( submodulesPath, 'PathFundamentals' ) );
    test.is( files.length );

    return null;
  })

  /* */

  var files;
  ready
  .then( () =>
  {
    files = self.find( submodulesPath );
    return null;
  })

  /* */

  shell({ args : [ '.submodules.clean' ] })
  .then( ( got ) =>
  {
    test.case = '.submodules.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `${files.length}` ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* phantom problem ? */
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) );
    return null;
  })

  /* - */

  return ready;
}

cleanSubmodules.timeOut = 300000;

//

function cleanMixed( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-mixed' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let modulePath = _.path.join( routinePath, 'module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.clean';
    return null;
  })

  shell({ args : [ '.build' ] })
  shell({ args : [ '.clean' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '- Clean deleted' ) ); debugger;

    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'out' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );

    var expected = [ '.', './Proto.informal.will.yml', './UriFundamentals.informal.will.yml' ];
    var files = self.find( _.path.join( routinePath, 'module' ) );
    test.identical( files, expected );

    return null;
  })

  /* - */

  return ready;
}

cleanMixed.timeOut = 200000;

//

function cleanWithInPath( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'clean-with-inpath' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let modulePath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.with module/Proto .clean';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  })


  shell({ args : [ '.with module/Proto .clean' ] })

  .then( ( got ) =>
  {

    var expectedFiles =
    [
      '.',
      './+.module',
      './+.module/Proto.out.will.yml',
      './+.module/Proto',
      './+.module/Proto/.ex.will.yml',
      './+.module/Proto/.gitattributes',
      './+.module/Proto/.im.will.yml',
      './+.module/Proto/.travis.yml',
      './+.module/Proto/appveyor.yml',
      './+.module/Proto/LICENSE',
      './+.module/Proto/package.json',
      './+.module/Proto/README.md',
      './+.module/Proto/proto',
      './+.module/Proto/proto/dwtools',
      './+.module/Proto/proto/dwtools/Tools.s',
      './+.module/Proto/proto/dwtools/abase',
      './+.module/Proto/proto/dwtools/abase/l3',
      './+.module/Proto/proto/dwtools/abase/l3/Proto.s',
      './+.module/Proto/proto/dwtools/abase/l3/ProtoAccessor.s',
      './+.module/Proto/proto/dwtools/abase/l3/ProtoLike.s',
      './+.module/Proto/proto/dwtools/abase/l3.test',
      './+.module/Proto/proto/dwtools/abase/l3.test/Proto.test.s',
      './+.module/Proto/proto/dwtools/abase/l3.test/ProtoLike.test.s',
      './+.module/Proto/sample',
      './+.module/Proto/sample/Sample.html',
      './+.module/Proto/sample/Sample.js',
      './+.module/Tools',
      './+out',
      './+out/debug',
      './+out/debug/WithSubmodules.s',
      './+out/debug/dwtools',
      './+out/debug/dwtools/Tools.s',
      './+out/debug/dwtools/abase',
      './+out/debug/dwtools/abase/Layer0.s',
      './+out/debug/dwtools/abase/Layer1.s',
      './+out/debug/dwtools/abase/Layer2.s',
      './+out/debug/dwtools/abase/l0',
      './+out/debug/dwtools/abase/l0/aPredefined.s',
      './+out/debug/dwtools/abase/l0/aSetup.s',
      './+out/debug/dwtools/abase/l0/bPremature.s',
      './+out/debug/dwtools/abase/l0/fBool.s',
      './+out/debug/dwtools/abase/l0/fChecker.s',
      './+out/debug/dwtools/abase/l0/fEntity.s',
      './+out/debug/dwtools/abase/l0/fErr.s',
      './+out/debug/dwtools/abase/l0/fLong.s',
      './+out/debug/dwtools/abase/l0/fMap.s',
      './+out/debug/dwtools/abase/l0/fNumber.s',
      './+out/debug/dwtools/abase/l0/fRange.s',
      './+out/debug/dwtools/abase/l0/fRegexp.s',
      './+out/debug/dwtools/abase/l0/fRoutine.s',
      './+out/debug/dwtools/abase/l0/fString.s',
      './+out/debug/dwtools/abase/l0/fTime.s',
      './+out/debug/dwtools/abase/l0/iArrayDescriptor.s',
      './+out/debug/dwtools/abase/l0/iCompose.s',
      './+out/debug/dwtools/abase/l0/iField.s',
      './+out/debug/dwtools/abase/l1',
      './+out/debug/dwtools/abase/l1/cErr.s',
      './+out/debug/dwtools/abase/l1/gBool.s',
      './+out/debug/dwtools/abase/l1/gEntity.s',
      './+out/debug/dwtools/abase/l1/gLong.s',
      './+out/debug/dwtools/abase/l1/gMap.s',
      './+out/debug/dwtools/abase/l1/gNumber.s',
      './+out/debug/dwtools/abase/l1/gRange.s',
      './+out/debug/dwtools/abase/l1/gRegexp.s',
      './+out/debug/dwtools/abase/l1/gRoutine.s',
      './+out/debug/dwtools/abase/l1/gString.s',
      './+out/debug/dwtools/abase/l1/gTime.s',
      './+out/debug/dwtools/abase/l1/rFundamental.s',
      './+out/debug/dwtools/abase/l1/zSetup.s',
      './+out/debug/dwtools/abase/l1.test',
      './+out/debug/dwtools/abase/l1.test/Array.test.s',
      './+out/debug/dwtools/abase/l1.test/Diagnostics.test.s',
      './+out/debug/dwtools/abase/l1.test/Entity.test.s',
      './+out/debug/dwtools/abase/l1.test/Map.test.s',
      './+out/debug/dwtools/abase/l1.test/Regexp.test.s',
      './+out/debug/dwtools/abase/l1.test/Routine.test.s',
      './+out/debug/dwtools/abase/l1.test/String.test.s',
      './+out/debug/dwtools/abase/l1.test/Typing.test.s',
      './+out/debug/dwtools/abase/l2',
      './+out/debug/dwtools/abase/l2/IncludeTools.s',
      './+out/debug/dwtools/abase/l2/ModulesRegistry.s',
      './+out/debug/dwtools/abase/l2/NameTools.s',
      './+out/debug/dwtools/abase/l2/StringTools.s',
      './+out/debug/dwtools/abase/l2.test',
      './+out/debug/dwtools/abase/l2.test/StringTools.test.s',
      './module',
      './module/Proto.will.yml',
      './module/+.module',
      './module/+out',
      './module/.module',
      './module/out',
      './proto',
      './proto/WithSubmodules.s'
    ]
    var files = self.find( routinePath );
    test.identical( files, expectedFiles );

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, '- Clean deleted 84 file(s)' ), 1 );

    return null;
  })

  /* - */

  return ready;
}

cleanWithInPath.timeOut = 200000;

//

function buildSingleModule( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'single' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outDebugPath = _.path.join( routinePath, 'out/debug' );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready.then( () =>
  {
    test.case = '.build'
    _.fileProvider.filesDelete( outDebugPath );
    return null;
  })

  shell({ args : [ '.build' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .*module::single \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, /Built .*module::single \/ build::debug\.raw.* in/ ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );

    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = '.build debug.raw'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    _.fileProvider.filesDelete( outDebugPath );
    return null;
  })

  shell({ args : [ '.build debug.raw' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .*module::single \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, /Built .*module::single \/ build::debug\.raw.* in/ ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );

    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = '.build release.raw'
    let outDebugPath = _.path.join( routinePath, 'out/release' );
    _.fileProvider.filesDelete( outDebugPath );
    return null;
  })

  shell({ args : [ '.build release.raw' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .*module::single \/ build::release\.raw.*/ ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, /Built .*module::single \/ build::release\.raw.* in/ ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );

    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = '.build wrong'
    let buildOutDebugPath = _.path.join( routinePath, 'out/debug' );
    let buildOutReleasePath = _.path.join( routinePath, 'out/release' );
    _.fileProvider.filesDelete( buildOutDebugPath );
    _.fileProvider.filesDelete( buildOutReleasePath );
    var o =
    {
      args : [ '.build wrong' ],
      ready : null,
    }
    return test.shouldThrowError( shell( o ) )
    .then( ( got ) =>
    {
      debugger;
      test.is( o.exitCode !== 0 );
      test.is( o.output.length );
      test.is( !_.fileProvider.fileExists( buildOutDebugPath ) )
      test.is( !_.fileProvider.fileExists( buildOutReleasePath ) )

      return null;
    })
  })

  /* - */

  return ready;
}

buildSingleModule.timeOut = 200000;

//

function buildSingleStep( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'step-shell' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, 'module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.build debug1'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    let outPath = _.path.join( routinePath, 'out' );
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug1' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    return null;
  })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.build debug2'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    let outPath = _.path.join( routinePath, 'out' );
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug2' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    return null;
  })

  /* - */

  return ready;
}

//

function buildSubmodules( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  ready

  /* - */

  .then( () =>
  {
    test.case = 'build withoud submodules'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build' ] })
  .finally( ( err, got ) =>
  {
    test.is( !err );
    var files = self.find( outPath );
    test.gt( files.length, 70 );
    return null;
  })

  /* - */

  shell({ args : [ '.submodules.update' ] })
  .then( () =>
  {
    test.case = '.build'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    var files = self.find( outPath );
    test.gt( files.length, 15 );

    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = '.build wrong'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  .then( () =>
  {

    var o =
    {
      execPath : 'node ' + execPath,
      currentPath : routinePath,
      outputCollecting : 1,
      args : [ '.build wrong' ]
    }

    let buildOutDebugPath = _.path.join( routinePath, 'out/debug' );
    let buildOutReleasePath = _.path.join( routinePath, 'out/release' );

    return test.shouldThrowError( _.shell( o ) )
    .then( ( got ) =>
    {
      test.is( o.exitCode !== 0 );
      test.is( o.output.length );
      test.is( !_.fileProvider.fileExists( outPath ) );
      test.is( !_.fileProvider.fileExists( buildOutDebugPath ) );
      test.is( !_.fileProvider.fileExists( buildOutReleasePath ) );

      return null;
    })

  });

  return ready;
}

buildSubmodules.timeOut = 300000;

//

function buildDetached( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-detached' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let filePath = _.path.join( routinePath, 'file' );
  let modulePath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, /\+ .*module::Tools.* was downloaded version .*master.* in/ ) );
    test.is( _.strHas( got.output, /\+ .*module::PathFundamentals.* was downloaded version .*c94e0130358ba54fc47237e15bac1ab18024c0a9.* in/ ) );
    test.is( _.strHas( got.output, /\+ .*module::Color.* was downloaded version .*0.3.115.* in/ ) );
    test.is( _.strHas( got.output, /\.module\/Procedure\.informal.+ <- .+npm:\/\/wprocedure/ ) );
    test.is( _.strHas( got.output, /\.module\/Proto\.informal.+ <- .+git\+https:\/\/github\.com\/Wandalen\/wProto\.git#f4c04dbe078f3c00c84ff13edcc67478d320fddf/ ) );
    test.is( _.strHas( got.output, /\.module\/UriFundamentals\.informal.+ <- .+git\+https:\/\/github\.com\/Wandalen\/wUriFundamentals\.git/ ) );

    var files = _.fileProvider.dirRead( modulePath );
    test.identical( files, [ 'Color', 'PathFundamentals', 'Procedure.informal', 'Proto.informal', 'Tools', 'UriFundamentals.informal' ] );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'Procedure.informal.out.will.yml', 'Proto.informal.out.will.yml', 'UriFundamentals.informal.out.will.yml' ] );

    return null;
  })

  /* - */

  return ready;
}

buildDetached.timeOut = 300000;

//

function exportSingle( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'single' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outDebugPath = _.path.join( routinePath, 'out/debug' );
  let outPath = _.path.join( routinePath, 'out' );
  let outWillPath = _.path.join( routinePath, 'out/single.out.will.yml' );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesDelete( outDebugPath );

  /* - */

  ready.then( () =>
  {
    test.case = '.export'
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, /\+ Exported .*exported::proto.export.* with 2 files in/ ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );
    var files = self.find( outPath );
    test.identical( files, [ '.', './single.out.will.yml', './debug', './debug/Single.s' ] );

    test.is( _.fileProvider.fileExists( outWillPath ) )
    var outfile = _.fileProvider.fileConfigRead( outWillPath );

    let reflector = outfile.reflector[ 'exported.files.proto.export' ];
    test.identical( reflector.src.basePath, '.' );
    test.identical( reflector.src.prefixPath, 'path::exported.dir.proto.export' );
    test.identical( reflector.src.filePath, { 'path::exported.files.proto.export' : null } );

    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = '.export.proto'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    let outPath = _.path.join( routinePath, 'out' );
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.export proto.export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exported .*module::single \/ build::proto.export.* in/ ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, / \+ Exported .*exported::proto\.export.* with 2 files/ ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );
    var files = self.find( outPath );
    test.identical( files, [ '.', './single.out.will.yml', './debug', './debug/Single.s'  ] );

    test.is( _.fileProvider.fileExists( outWillPath ) )
    var outfile = _.fileProvider.fileConfigRead( outWillPath );

    let reflector = outfile.reflector[ 'exported.files.proto.export' ];
    let expectedFilePath =
    {
      '.' : null,
      'Single.s' : null
    }
    test.identical( reflector.src.basePath, '.' );
    test.identical( reflector.src.prefixPath, 'path::exported.dir.proto.export' );
    test.identical( reflector.src.filePath, { 'path::exported.files.proto.export' : null } );

    return null;
  })

  return ready;
}

exportSingle.timeOut = 200000;

//

/*
  Submodule Submodule is deleted, so exporting should fail.
*/

function exportNonExportable( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'import-in-exported' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
  _.fileProvider.filesDelete( _.path.join( routinePath, 'out' ) );
  _.fileProvider.filesDelete( _.path.join( routinePath, 'super.out' ) );

  /* - */

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with super .export debug:1' ], throwingExitCode : 0 })

  .then( ( got ) =>
  {
    test.is( got.exitCode !== 0 );

    test.identical( _.strCount( got.output, 'unhandled errorr' ), 0 );
    test.identical( _.strCount( got.output, '====' ), 0 );

    test.identical( _.strCount( got.output, /.*module::supermodule \/ submodule::Submodule.* is broken/ ), 1 );
    test.identical( _.strCount( got.output, /Exporting is impossible because .*module::supermodule \/ submodule::Submodule.* is broken!/ ), 1 );
    test.identical( _.strCount( got.output, /Failed .*module::supermodule \/ step::export.*/ ), 1 );

    return null;
  })

  return ready;
}

//

/*
- local path and remote path of exported informal module should be preserved and in proper form
- second export should work properly
*/

function exportInformal( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-mixed' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with module/Proto.informal .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with module/Proto.informal .export' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /Exported .*module::Proto.informal \/ build::export.* in/ ), 1 );

    var files = self.find( outPath );
    test.identical( files, [ '.', './Proto.informal.out.will.yml' ] );

    var outfile = _.fileProvider.fileConfigRead( _.path.join( outPath, './Proto.informal.out.will.yml' ) );
    var expected =
    {
      "module.willfiles" :
      {
        "path" : "Proto.informal.out.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.original.willfiles" :
      {
        "path" : "../module/Proto.informal.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "Proto.informal.out",
        "criterion" : { "predefined" : 1 }
      },
      "in" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "out" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "remote" :
      {
        "path" : "git+https:///github.com/Wandalen/wProto.git",
        "criterion" : { "predefined" : 1 }
      },
      "local" :
      {
        "path" : "../.module/Proto",
        "criterion" : { "predefined" : 1 }
      },
      "export" : { "path" : "{path::local}/proto" },
      "exported.dir.export" :
      {
        "path" : "../.module/Proto/proto",
        "criterion" : { "default" : 1, "export" : 1 }
      }
    }
    delete outfile.path[ 'exported.files.export' ];
    test.identical( outfile.path, expected );
    test.identical( outfile.path.local.path, '../.module/Proto' );
    test.identical( outfile.path.remote.path, 'git+https:///github.com/Wandalen/wProto.git' );
    // logger.log( _.toJson( outfile.path ) );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with module/Proto.informal .export -- second'
    return null;
  })

  shell({ args : [ '.with module/Proto.informal .export' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /Exported .*module::Proto.informal \/ build::export.* in/ ), 1 );

    var files = self.find( outPath );
    test.identical( files, [ '.', './Proto.informal.out.will.yml' ] );

    var outfile = _.fileProvider.fileConfigRead( _.path.join( outPath, './Proto.informal.out.will.yml' ) );

    var expected =
    {
      "module.willfiles" :
      {
        "path" : "Proto.informal.out.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.original.willfiles" :
      {
        "path" : "../module/Proto.informal.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "Proto.informal.out",
        "criterion" : { "predefined" : 1 }
      },
      "in" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "out" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "remote" :
      {
        "path" : "git+https:///github.com/Wandalen/wProto.git",
        "criterion" : { "predefined" : 1 }
      },
      "local" :
      {
        "path" : "../.module/Proto",
        "criterion" : { "predefined" : 1 }
      },
      "export" : { "path" : "{path::local}/proto" },
      "exported.dir.export" :
      {
        "path" : "../.module/Proto/proto",
        "criterion" : { "default" : 1, "export" : 1 }
      }
    }
    delete outfile.path[ 'exported.files.export' ];
    test.identical( outfile.path, expected );
    test.identical( outfile.path.local.path, '../.module/Proto' );
    test.identical( outfile.path.remote.path, 'git+https:///github.com/Wandalen/wProto.git' );
    // logger.log( _.toJson( outfile.path ) );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with module/UriFundamentals.informal .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with module/UriFundamentals.informal .export' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /Exported .*module::UriFundamentals.informal \/ build::export.* in/ ), 1 );

    var files = self.find( outPath );
    test.identical( files, [ '.', './UriFundamentals.informal.out.will.yml' ] );

    var outfile = _.fileProvider.fileConfigRead( _.path.join( outPath, './UriFundamentals.informal.out.will.yml' ) );
    var expected =
    {
      "module.willfiles" :
      {
        "path" : "UriFundamentals.informal.out.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.original.willfiles" :
      {
        "path" : "../module/UriFundamentals.informal.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "UriFundamentals.informal.out",
        "criterion" : { "predefined" : 1 }
      },
      "in" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "out" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "remote" :
      {
        "path" : "npm:///wurifundamentals",
        "criterion" : { "predefined" : 1 }
      },
      "local" :
      {
        "path" : "../.module/UriFundamentals",
        "criterion" : { "predefined" : 1 }
      },
      "export" : { "path" : "{path::local}/proto" },
      "exported.dir.export" :
      {
        "path" : "../.module/UriFundamentals/proto",
        "criterion" : { "default" : 1, "export" : 1 }
      }
    }
    delete outfile.path[ 'exported.files.export' ];
    test.identical( outfile.path, expected );
    test.identical( outfile.path.local.path, '../.module/UriFundamentals' );
    test.identical( outfile.path.remote.path, 'npm:///wurifundamentals' );
    // logger.log( _.toJson( outfile.path ) );

    return null;
  })

  /* - */

  return ready;
}

exportInformal.timeOut = 300000;

//

function exportWithReflector( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-with-reflector' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outDebugPath = _.path.join( routinePath, 'out/debug' );
  let outPath = _.path.join( routinePath, 'out' );
  let outWillPath = _.path.join( routinePath, 'out/export-with-reflector.out.will.yml' );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
  _.fileProvider.filesDelete( outDebugPath );

  /* - */

  ready.then( () =>
  {
    test.case = '.export'
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( outPath );
    test.identical( files, [ '.', './export-with-reflector.out.will.yml' ] );

    // var reflectors =

    var outfile = _.fileProvider.fileConfigRead( outWillPath );

    debugger;

    return null;
  })

  return ready;
}

exportWithReflector.timeOut = 200000;

//

function exportToRoot( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-to-root' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  shell({ args : [ '.export' ] })

  .then( ( got ) =>
  {
    test.case = '.export'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exporting .+module::export-to-root \/ build::proto\.export.+/ ) );
    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, /Exported .+module::export-to-root \/ build::proto\.export.+ in/ ) );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'export-to-root.out.will.yml' ) ) )
    return null;
  })

  return ready;
}

exportToRoot.timeOut = 200000;

//

function exportMixed( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-mixed' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let modulePath = _.path.join( routinePath, 'module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.each module .export';
    return null;
  })

  shell({ args : [ '.each module .export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exporting .*module::UriFundamentals\.informal \/ build::export.*/ ) );
    test.is( _.strHas( got.output, /\+ .*reflector::download.* reflected/ ) );
    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, /Exported .*module::UriFundamentals\.informal \/ build::export.* in/ ) );
    test.is( _.strHas( got.output, 'out/Proto.informal.out.will.yml' ) );
    test.is( _.strHas( got.output, 'out/UriFundamentals.informal.out.will.yml' ) );

    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/Proto.informal.out.will.yml' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/UriFundamentals.informal.out.will.yml' ) ) );

    var files = self.find( _.path.join( routinePath, 'module' ) );
    test.identical( files, [ '.', './Proto.informal.will.yml', './UriFundamentals.informal.will.yml' ] );
    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [ '.', './Proto.informal.out.will.yml', './UriFundamentals.informal.out.will.yml' ] );

    var expected = [ 'Proto.informal.will.yml', 'UriFundamentals.informal.will.yml' ];
    var files = _.fileProvider.dirRead( modulePath );
    test.identical( files, expected );

    var outfile = _.fileProvider.fileConfigRead( _.path.join( routinePath, 'out/Proto.informal.out.will.yml' ) );

    var expected =
    {
      'download' :
      {
        'src' : { 'prefixPath' : 'path::remote', 'filePath' : { '.' : '.' } },
        'dst' : { 'prefixPath' : 'path::local' },
        'mandatory' : 1,
      },
      'exported.export' :
      {
        'src' :
        {
          'filePath' : { '.' : null },
          'prefixPath' : '../.module/Proto/proto'
        },
        'criterion' : { 'export' : 1, 'default' : 1 },
        'mandatory' : 1,
      },
      'exported.files.export' :
      {
        'recursive' : 0,
        'mandatory' : 1,
        'src' : { 'filePath' : { 'path::exported.files.export' : null }, 'basePath' : '.', 'prefixPath' : 'path::exported.dir.export' },
        'criterion' : { 'default' : 1, 'export' : 1 }
      }
    }
    test.identical( outfile.reflector, expected );
    test.identical( outfile.reflector[ 'exported.files.export' ], expected[ 'exported.files.export' ] );

    var expected =
    {
      "module.willfiles" :
      {
        "path" : "Proto.informal.out.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.original.willfiles" :
      {
        "path" : "../module/Proto.informal.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "Proto.informal.out",
        "criterion" : { "predefined" : 1 }
      },
      "in" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "out" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "remote" :
      {
        "path" : "git+https:///github.com/Wandalen/wProto.git",
        "criterion" : { "predefined" : 1 }
      },
      "local" :
      {
        "path" : "../.module/Proto",
        "criterion" : { "predefined" : 1 }
      },
      "export" : { "path" : "{path::local}/proto" },
      "exported.dir.export" :
      {
        "path" : "../.module/Proto/proto",
        "criterion" : { "default" : 1, "export" : 1 }
      },
      "exported.files.export" :
      {
        "path" :
        [
          "../.module/Proto/proto",
          "../.module/Proto/proto/dwtools",
          "../.module/Proto/proto/dwtools/Tools.s",
          "../.module/Proto/proto/dwtools/abase",
          "../.module/Proto/proto/dwtools/abase/l3",
          "../.module/Proto/proto/dwtools/abase/l3/Proto.s",
          "../.module/Proto/proto/dwtools/abase/l3/ProtoAccessor.s",
          "../.module/Proto/proto/dwtools/abase/l3/ProtoLike.s",
          "../.module/Proto/proto/dwtools/abase/l3.test",
          "../.module/Proto/proto/dwtools/abase/l3.test/Proto.test.s",
          "../.module/Proto/proto/dwtools/abase/l3.test/ProtoLike.test.s"
        ],
        "criterion" : { "default" : 1, "export" : 1 }
      }
    }
    test.identical( outfile.path, expected );
    // logger.log( _.toJson( outfile.path ) );

    var expected =
    {
      'export' :
      {
        'version' : '0.1.0',
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
        'opts' : { 'reflector' : 'reflector::download*' },
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

  ready
  .then( ( got ) =>
  {
    test.case = '.build';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build' ] })

  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exporting .*module::UriFundamentals.informal.* \/ build::export/ ) );
    test.is( _.strHas( got.output, /\+ .*reflector::download.* reflected/ ) );
    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, /Exported .*module::UriFundamentals.informal.* \/ build::export/ ) );
    test.is( _.strHas( got.output, 'out/Proto.informal.out.will.yml' ) );
    test.is( _.strHas( got.output, 'out/UriFundamentals.informal.out.will.yml' ) );
    test.is( _.strHas( got.output, 'Reloading submodules' ) );

    test.is( _.strHas( got.output, /- .*step::delete.out.debug.* deleted 0 file\(s\), at/ ) );
    test.is( _.strHas( got.output, /\+ .*reflector::reflect.proto.debug.* reflected 2 files/ ) );
    test.is( _.strHas( got.output, /\+ .*reflector::reflect.submodules.* reflected/ ) );

    test.is( _.strHas( got.output, /.*!.* Failed to read .+submodule::Tools.+/ ) );
    test.is( _.strHas( got.output, /.*!.* Failed to read .+submodule::PathFundamentals.+/ ) );
    test.is( _.strHas( got.output, /.*!.* Failed to read .+submodule::UriFundamentals.+/ ) );
    test.is( _.strHas( got.output, /.*!.* Failed to read .+submodule::Proto.+/ ) );

    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/Proto.informal.out.will.yml' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/UriFundamentals.informal.out.will.yml' ) ) );

    var files = self.find( _.path.join( routinePath, 'module' ) );
    test.identical( files, [ '.', './Proto.informal.will.yml', './UriFundamentals.informal.will.yml' ] ); debugger;
    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.gt( files.length, 80 );

    var expected = [ 'Proto.informal.will.yml', 'UriFundamentals.informal.will.yml' ];
    var files = _.fileProvider.dirRead( modulePath );
    test.identical( files, expected );

    var expected = [ 'dwtools', 'WithSubmodules.s' ];
    var files = _.fileProvider.dirRead( _.path.join( routinePath, 'out/debug' ) );
    test.identical( files, expected );

    return null;
  })

  /* - */

  return ready;
}

exportMixed.timeOut = 300000;

//

function exportSecond( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-second' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let modulePath = _.path.join( routinePath, 'module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.export';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, '+ Write out willfile' ), 2 );
    test.identical( _.strCount( got.output, / \+ Exported .*exported::proto.export.* with 4 files in/ ), 1 );
    test.identical( _.strCount( got.output, / \+ Exported .*exported::doc.export.* with 2 files in/ ), 1 );

    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/ExportSecond.out.will.yml' ) ) );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [ '.', './ExportSecond.out.will.yml' ] );

    var outfile = _.fileProvider.fileConfigRead( _.path.join( routinePath, 'out/ExportSecond.out.will.yml' ) );

    var expected =
    {
      "reflect.proto." :
      {
        "src" :
        {
          "filePath" : { "path::proto" : "path::out.*=1" }
        },
        "criterion" : { "debug" : 0 },
        "mandatory" : 1,
        "inherit" : [ "predefined.*" ]
      },
      "reflect.proto.debug" :
      {
        "src" :
        {
          "filePath" : { "path::proto" : "path::out.*=1" }
        },
        "criterion" : { "debug" : 1 },
        "mandatory" : 1,
        "inherit" : [ "predefined.*" ]
      },
      "exported.proto.export" :
      {
        'src' : { 'prefixPath' : '../proto' },
        "criterion" : { "proto" : 1, "export" : 1 },
        "mandatory" : 1
      },
      "exported.files.proto.export" :
      {
        "src" : { "filePath" : { 'path::exported.files.proto.export' : null }, "basePath" : ".", "prefixPath" : "path::exported.dir.proto.export" },
        "criterion" : { "proto" : 1, "export" : 1 },
        "recursive" : 0,
        "mandatory" : 1
      },
      "exported.doc.export" :
      {
        "src" :
        {
          "filePath" : { "." : null },
          "prefixPath" : "../doc"
        },
        "criterion" : { "doc" : 1, "export" : 1 },
        "mandatory" : 1
      },
      "exported.files.doc.export" :
      {
        "src" : { "filePath" : { 'path::exported.files.doc.export' : null }, "basePath" : ".", "prefixPath" : "path::exported.dir.doc.export" },
        "criterion" : { "doc" : 1, "export" : 1 },
        "recursive" : 0,
        "mandatory" : 1
      }
    }
    test.identical( outfile.reflector, expected );
    // logger.log( _.toJson( outfile.reflector ) );

    var expected =
    {
      "module.willfiles" :
      {
        "path" : "ExportSecond.out.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.original.willfiles" :
      {
        "path" : [ "../.im.will.yml", "../.ex.will.yml" ],
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "ExportSecond.out",
        "criterion" : { "predefined" : 1 }
      },
      "local" :
      {
        "criterion" : { "predefined" : 1 }
      },
      "remote" :
      {
        "criterion" : { "predefined" : 1 }
      },
      "in" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "temp" : { "path" : "." },
      "out" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
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
      "proto" : { "path" : "../proto" },
      "doc" : { "path" : "../doc" },
      "exported.dir.proto.export" :
      {
        "path" : "../proto",
        "criterion" : { "proto" : 1, "export" : 1 }
      },
      "exported.files.proto.export" :
      {
        "path" : [ "../proto", "../proto/-NotExecluded.js", "../proto/.NotExecluded.js", "../proto/File.js" ],
        "criterion" : { "proto" : 1, "export" : 1 }
      },
      "exported.dir.doc.export" :
      {
        "path" : "../doc",
        "criterion" : { "doc" : 1, "export" : 1 }
      },
      "exported.files.doc.export" :
      {
        "path" : [ "../doc", "../doc/File.md" ],
        "criterion" : { "doc" : 1, "export" : 1 }
      }
    }
    test.identical( outfile.path, expected );
    // logger.log( _.toJson( outfile.reflector ) );

    var expected =
    {
      'doc.export' :
      {
        version : '0.0.0',
        criterion : { doc : 1, export : 1 },
        exportedReflector : 'reflector::exported.doc.export',
        exportedFilesReflector : 'reflector::exported.files.doc.export',
        exportedDirPath : 'path::exported.dir.doc.export',
        exportedFilesPath : 'path::exported.files.doc.export',
      },
      'proto.export' :
      {
        version : '0.0.0',
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

  shell({ args : [ '.export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, '+ Write out willfile' ), 2 );
    test.identical( _.strCount( got.output, / \+ Exported .*exported::doc.export.* with 2 files in/ ), 1 );
    test.identical( _.strCount( got.output, / \+ Exported .*exported::proto.export.* with 4 files in/ ), 1 );

    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/ExportSecond.out.will.yml' ) ) );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.identical( files, [ '.', './ExportSecond.out.will.yml' ] );

    var outfile = _.fileProvider.fileConfigRead( _.path.join( routinePath, 'out/ExportSecond.out.will.yml' ) );

    var expected =
    {
      "reflect.proto." :
      {
        "src" :
        {
          "filePath" : { "path::proto" : "path::out.*=1" }
        },
        "criterion" : { "debug" : 0 },
        "mandatory" : 1,
        "inherit" : [ "predefined.*" ]
      },
      "reflect.proto.debug" :
      {
        "src" :
        {
          "filePath" : { "path::proto" : "path::out.*=1" }
        },
        "criterion" : { "debug" : 1 },
        "mandatory" : 1,
        "inherit" : [ "predefined.*" ]
      },
      "exported.proto.export" :
      {
        "src" :
        {
          "filePath" : { "." : null },
          "prefixPath" : "../proto"
        },
        "criterion" : { "proto" : 1, "export" : 1 },
        "mandatory" : 1
      },
      "exported.files.proto.export" :
      {
        "src" : { "filePath" : { 'path::exported.files.proto.export' : null }, "basePath" : ".", "prefixPath" : "path::exported.dir.proto.export" },
        "criterion" : { "proto" : 1, "export" : 1 },
        "recursive" : 0,
        "mandatory" : 1
      },
      "exported.doc.export" :
      {
        "src" :
        {
          "filePath" : { "." : null },
          "prefixPath" : "../doc"
        },
        "criterion" : { "doc" : 1, "export" : 1 },
        "mandatory" : 1
      },
      "exported.files.doc.export" :
      {
        "src" : { "filePath" : { 'path::exported.files.doc.export' : null }, "basePath" : ".", "prefixPath" : "path::exported.dir.doc.export" },
        "criterion" : { "doc" : 1, "export" : 1 },
        "recursive" : 0,
        "mandatory" : 1
      }
    }
    test.identical( outfile.reflector, expected );
    // logger.log( _.toJson( outfile.reflector ) );

    var expected =
    {
      "module.willfiles" :
      {
        "path" : "ExportSecond.out.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.original.willfiles" :
      {
        "path" : [ "../.im.will.yml", "../.ex.will.yml" ],
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "ExportSecond.out",
        "criterion" : { "predefined" : 1 }
      },
      "local" :
      {
        "criterion" : { "predefined" : 1 }
      },
      "remote" :
      {
        "criterion" : { "predefined" : 1 }
      },
      "in" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "temp" : { "path" : "." },
      "out" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
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
      "proto" : { "path" : "../proto" },
      "doc" : { "path" : "../doc" },
      "exported.dir.proto.export" :
      {
        "path" : "../proto",
        "criterion" : { "proto" : 1, "export" : 1 }
      },
      "exported.files.proto.export" :
      {
        "path" : [ "../proto", "../proto/-NotExecluded.js", "../proto/.NotExecluded.js", "../proto/File.js" ],
        "criterion" : { "proto" : 1, "export" : 1 }
      },
      "exported.dir.doc.export" :
      {
        "path" : "../doc",
        "criterion" : { "doc" : 1, "export" : 1 }
      },
      "exported.files.doc.export" :
      {
        "path" : [ "../doc", "../doc/File.md" ],
        "criterion" : { "doc" : 1, "export" : 1 }
      }
    }
    test.identical( outfile.path, expected );
    // logger.log( _.toJson( outfile.path ) );

    var expected =
    {
      'doc.export' :
      {
        version : '0.0.0',
        criterion : { doc : 1, export : 1 },
        exportedReflector : 'reflector::exported.doc.export',
        exportedFilesReflector : 'reflector::exported.files.doc.export',
        exportedDirPath : 'path::exported.dir.doc.export',
        exportedFilesPath : 'path::exported.files.doc.export',
      },
      'proto.export' :
      {
        version : '0.0.0',
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

  return ready;
}

exportSecond.timeOut = 300000;

//

function exportSubmodules( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outDebugPath = _.path.join( routinePath, 'out/debug' );
  let outPath = _.path.join( routinePath, 'out' );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.export'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  return shell({ args : [ '.export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/debug/dwtools/abase/l0/aPredefined.s' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/debug/dwtools/abase/l3/Path.s' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/submodules.out.will.yml' ) ) );
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

    var files = self.find( outPath );
    test.is( files.length > 60 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  return ready;
}

exportSubmodules.timeOut = 200000;

//

function exportMultiple( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-multiple' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let outWillPath = _.path.join( outPath, 'submodule.out.will.yml' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.export debug:1';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( outPath );

    return null;
  })

  shell({ args : [ '.export debug:1' ] })

  .then( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js' ] );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, / \+ Exported .*exported::export.debug.* with 2 files in/ ) );
    test.is( _.strHas( got.output, 'Read 2 willfile(s) in' ) );
    test.is( _.strHas( got.output, /Exported .*module::submodule \/ build::export.debug.*/ ) );
    test.is( _.strHas( got.output, 'Write out archive' ) );
    test.is( _.strHas( got.output, 'Write out willfile' ) );
    test.is( _.strHas( got.output, 'submodule.debug.out.tgs' ) );
    test.is( _.strHas( got.output, 'out/submodule.out.will.yml' ) );

    var outfile = _.fileProvider.fileConfigRead( outWillPath );
    var exported =
    {
      'export.debug' :
      {
        version : '0.0.1',
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
      src : { filePath : { '.' : null }, prefixPath : 'debug' },
      mandatory : 1,
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }
    test.identical( outfile.reflector[ 'exported.export.debug' ], exportedReflector );
    // logger.log( _.toJson( outfile.reflector ) );

    var exportedReflectorFiles =
    {
      recursive : 0,
      mandatory : 1,
      src :
      {
        filePath : { 'path::exported.files.export.debug' : null },
        basePath : '.',
        prefixPath : 'path::exported.dir.export.debug',
      },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
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
        "path" : [ "../.im.will.yml", "../.ex.will.yml" ],
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "submodule.out",
        "criterion" : { "predefined" : 1 }
      },
      "local" :
      {
        "criterion" : { "predefined" : 1 }
      },
      "remote" :
      {
        "criterion" : { "predefined" : 1 }
      },
      "proto" : { "path" : "../proto" },
      "temp" : { "path" : "." },
      "in" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "out" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
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
          "export" : 1
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
          "export" : 1
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
          "export" : 1
        }
      }
    }
    test.identical( outfile.path, outfilePath );
    // logger.log( _.toJson( outfile.path ) );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.export debug:1';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( outPath );

    return null;
  })

  shell({ args : [ '.export debug:1' ] })
  shell({ args : [ '.export debug:0' ] })
  shell({ args : [ '.export debug:0' ] })

  .then( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, / \+ Exported .*exported::export\..* with 2 files in/ ) );
    test.is( _.strHas( got.output, 'Read 2 willfile(s) in' ) );
    test.is( _.strHas( got.output, /Exported .*module::submodule \/ build::export\..* in/ ) );
    test.is( _.strHas( got.output, 'Write out archive' ) );
    test.is( _.strHas( got.output, 'Write out willfile' ) );
    test.is( _.strHas( got.output, 'submodule.out.tgs' ) );
    test.is( _.strHas( got.output, 'out/submodule.out.will.yml' ) );

    var outfileData = _.fileProvider.fileRead( outWillPath );
    test.is( outfileData.length > 1000 );
    test.is( !_.strHas( outfileData, _.path.join( routinePath, '../..' ) ) );
    test.is( !_.strHas( outfileData, _.path.nativize( _.path.join( routinePath, '../..' ) ) ) );

    var outfile = _.fileProvider.fileConfigRead( outWillPath );
    var exported =
    {
      'export.debug' :
      {
        version : '0.0.1',
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
        // 'filePath' : { '.' : null },
        'prefixPath' : 'debug',
      },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }
    test.identical( outfile.reflector[ 'exported.export.debug' ], exportedReflector );
    // logger.log( _.toJson( outfile.reflector[ 'exported.export.debug' ] ) );

    var exportedReflector =
    {
      'mandatory' : 1,
      src :
      {
        'filePath' : { '.' : null },
        'prefixPath' : 'release'
      },
      criterion :
      {
        default : 1,
        debug : 0,
        raw : 1,
        export : 1
      }
    }
    // logger.log( _.toJson( outfile.reflector[ 'exported.export.' ] ) );
    test.identical( outfile.reflector[ 'exported.export.' ], exportedReflector );

    var exportedReflectorFiles =
    {
      recursive : 0,
      mandatory : 1,
      src :
      {
        filePath : { 'path::exported.files.export.debug' : null },
        basePath : '.',
        prefixPath : 'path::exported.dir.export.debug',
      },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }

    test.identical( outfile.reflector[ 'exported.files.export.debug' ], exportedReflectorFiles );

    var exportedReflectorFiles =
    {
      recursive : 0,
      mandatory : 1,
      src :
      {
        filePath : { 'path::exported.files.export.' : null },
        basePath : '.',
        prefixPath : 'path::exported.dir.export.'
      },
      criterion :
      {
        default : 1,
        debug : 0,
        raw : 1,
        export : 1
      }
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
        "path" : [ "../.im.will.yml", "../.ex.will.yml" ],
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "submodule.out",
        "criterion" : { "predefined" : 1 }
      },
      "local" :
      {
        "criterion" : { "predefined" : 1 }
      },
      "remote" :
      {
        "criterion" : { "predefined" : 1 }
      },
      "proto" : { "path" : "../proto" },
      "temp" : { "path" : "." },
      "in" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "out" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
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
          "export" : 1
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
          "export" : 1
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
          "export" : 1
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
          "export" : 1
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
          "export" : 1
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
          "export" : 1
        }
      }
    }
    test.identical( outfile.path, outfilePath );
    // logger.log( _.toJson( outfile.path ) );

    return null;
  })

  /* - */

  return ready;
}

exportMultiple.timeOut = 200000;

//

function exportImportMultiple( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-multiple' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let out2Path = _.path.join( routinePath, 'super.out' );
  let outWillPath = _.path.join( outPath, 'submodule.out.will.yml' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = 'export submodule';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( outPath );

    debugger;

    return null;
  })

  shell({ args : [ '.with . .export debug:0' ] })
  shell({ args : [ '.with . .export debug:1' ] })

  .then( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ Exported .*exported::export.debug.* with 2 files in/ ) );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.with super .export debug:0';

    _.fileProvider.filesDelete( out2Path );

    return null;
  })

  shell({ args : [ '.with super .export debug:0' ] })

  .then( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [ '.', './supermodule.out.tgs', './supermodule.out.will.yml', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ Exported .*exported::export\..* with 2 files in/ ) );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.with super .clean dry:1';
    return null;
  })

  shell({ args : [ '.with super .clean dry:1' ] })

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

  ready
  .then( ( got ) =>
  {
    test.case = '.with super .clean';
    return null;
  })

  shell({ args : [ '.with super .clean' ] })

  .then( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted 5 file(s)' ) );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.with super .export debug:0 ; .with super .export debug:1';

    _.fileProvider.filesDelete( out2Path );

    return null;
  })

  shell({ args : [ '.with super .export debug:0' ] })
  shell({ args : [ '.with super .export debug:1' ] })

  .then( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [ '.', './supermodule.debug.out.tgs', './supermodule.out.tgs', './supermodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ Exported .*exported::export.debug.* with 2 files in/ ) );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.with super .clean dry:1';
    return null;
  })

  shell({ args : [ '.with super .clean dry:1' ] })

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

  ready
  .then( ( got ) =>
  {
    test.case = '.with super .clean';
    return null;
  })

  shell({ args : [ '.with super .clean' ] })

  .then( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted 8 file(s)' ) );

    return null;
  })

  /* - */

  return ready;
}

exportImportMultiple.timeOut = 200000;

//

function exportBroken( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-multiple-broken' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let outWillPath = _.path.join( outPath, 'submodule.out.will.yml' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.export debug:1';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  })

  debugger;
  shell({ args : [ '.export debug:1' ] })

  .then( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( outPath, 'debug' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( outPath, 'release' ) ) );

    test.is( _.strHas( got.output, 'submodule.debug.out.tgs' ) );
    test.is( _.strHas( got.output, 'out/submodule.out.will.yml' ) );

    var outfile = _.fileProvider.fileConfigRead( outWillPath );
    var exported =
    {
      'export.debug' :
      {
        version : '0.0.1',
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
      src : { filePath : { '.' : null }, prefixPath : 'debug' },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }
    test.identical( outfile.reflector[ 'exported.export.debug' ], exportedReflector );

    var exportedReflectorFiles =
    {
      recursive : 0,
      mandatory : 1,
      src :
      {
        filePath : { 'path::exported.files.export.debug' : null },
        basePath : '.',
        prefixPath : 'path::exported.dir.export.debug',
      },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }

    test.identical( outfile.reflector[ 'exported.files.export.debug' ], exportedReflectorFiles );

    return null;
  })

  return ready;
}

//

function exportDoc( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-multiple-doc' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let subOutPath = _.path.join( routinePath, 'out' );
  let supOutPath = _.path.join( routinePath, 'doc.out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = 'export submodule';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( subOutPath );
    _.fileProvider.filesDelete( supOutPath );

    return null;
  })

  shell({ args : [ '.with . .export export.doc' ] })
  shell({ args : [ '.with . .export export.debug' ] })
  shell({ args : [ '.with . .export export.' ] })
  shell({ args : [ '.with doc .build doc:1' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( subOutPath );
    test.identical( files, [ '.', './submodule.default-debug-raw.out.tgs', './submodule.default-raw.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );

    var files = self.find( supOutPath );
    test.identical( files, [ '.', './file.md' ] );

    return null;
  })

  /* - */

  return ready;
}

exportDoc.timeOut = 200000;

//

function exportImport( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'import-in-exported' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.export'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.export debug:0' ] })
  shell({ args : [ '.export debug:1' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'release', 'submodule.out.will.yml' ] );

    return null;
  })

  return ready;
}

exportImport.timeOut = 200000;

//

function exportBrokenNoreflector( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-broken-noreflector' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready

  .then( () =>
  {
    test.case = '.with submodule .reflectors.list predefined:0'
    return null;
  })

  shell({ args : [ '.with submodule .reflectors.list predefined:0' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::' ), 2 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::reflect.proto' ), 1 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::exported.files.export' ), 1 );
    return null;
  })

  shell({ args : [ '.with module/submodule .export' ] })
  shell({ args : [ '.with submodule .reflectors.list predefined:0' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::' ), 3 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::reflect.proto' ), 1 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::exported.export' ), 1 );
    test.identical( _.strCount( got.output, 'module::submodule / reflector::exported.files.export' ), 1 );
    return null;
  })

  return ready;
}

//

function exportWholeModule( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-whole' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready

  .thenKeep( () =>
  {
    test.case = 'export whole module using in path'
    return null;
  })

  shell({ args : [ '.export' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'export-whole.out.will.yml' ) ) )
    return null;
  })

  return ready;
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
  let originalDirPath = _.path.join( self.assetDirPath, 'import-path-local' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = 'export submodule';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( outPath );

    return null;
  })

  shell({ args : [ '.build' ] })

  .then( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/WithSubmodules.s', './debug/dwtools', './debug/dwtools/Tools.s' ] );
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /Built .*module::submodules \/ build::debug\.raw.* in/ ), 1 );

    return null;
  })

  /* - */

  return ready;
}

importPathLocal.timeOut = 200000;

//

function importLocalRepo( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'import-auto' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let repoPath = _.path.join( self.tempDir, 'repo' );
  let outPath = _.path.join( routinePath, 'out' );
  let modulePath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.with module/Proto .export';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesReflect({ reflectMap : { [ self.repoDirPath ] : repoPath } });

    return null;
  })

  shell({ args : [ '.with module/Proto .clean' ] })
  shell({ args : [ '.with module/Proto .export' ] })

  .then( ( got ) =>
  {

    var files = _.fileProvider.dirRead( modulePath );
    test.identical( files, [ 'Proto', 'Proto.out.will.yml' ] );

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /.*download.* reflected .* files .*importLocalRepo\/\.module\/Proto.* <- .*git\+hd:\/\/repo\/Proto.* in/ ), 1 );
    test.identical( _.strCount( got.output, /Write out willfile .*\/.module\/Proto.out.will.yml/ ), 1 );

    var outfile = _.fileProvider.fileConfigRead( _.path.join( modulePath, 'Proto.out.will.yml' ) );

    var expectedReflector =
    {
      'download' :
      {
        'src' : { 'filePath' : { '.' : '.' }, 'prefixPath' : 'path::remote' },
        'dst' : { 'prefixPath' : 'path::local' },
        'mandatory' : 1,
      },
      'exported.export' :
      {
        'src' :
        {
          'filePath' : { '.' : null },
          'prefixPath' : 'Proto/proto'
        },
        'criterion' : { 'default' : 1, 'export' : 1 },
        'mandatory' : 1
      },
      'exported.files.export' :
      {
        'src' : { 'filePath' : { 'path::exported.files.export' : null }, 'basePath' : '.', 'prefixPath' : 'path::exported.dir.export' },
        'criterion' : { 'default' : 1, 'export' : 1 },
        'recursive' : 0,
        'mandatory' : 1
      }
    }
    test.identical( outfile.reflector, expectedReflector );

    var expectedPath =
    {
      "module.willfiles" :
      {
        "path" : "Proto.out.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.original.willfiles" :
      {
        "path" : "../module/Proto.will.yml",
        "criterion" : { "predefined" : 1 }
      },
      "module.common" :
      {
        "path" : "Proto.out",
        "criterion" : { "predefined" : 1 }
      },
      "in" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "out" :
      {
        "path" : ".",
        "criterion" : { "predefined" : 0 }
      },
      "remote" :
      {
        "path" : "git+hd://../../repo/Proto",
        "criterion" : { "predefined" : 1 }
      },
      "local" :
      {
        "path" : "Proto",
        "criterion" : { "predefined" : 1 }
      },
      "export" : { "path" : "{path::local}/proto" },
      "temp" : { "path" : "../out" },
      "exported.dir.export" :
      {
        "path" : "Proto/proto",
        "criterion" : { "default" : 1, "export" : 1 }
      },
      "exported.files.export" :
      {
        "path" :
        [
          "Proto/proto",
          "Proto/proto/dwtools",
          "Proto/proto/dwtools/Tools.s",
          "Proto/proto/dwtools/abase",
          "Proto/proto/dwtools/abase/l3",
          "Proto/proto/dwtools/abase/l3/Proto.s",
          "Proto/proto/dwtools/abase/l3/ProtoAccessor.s",
          "Proto/proto/dwtools/abase/l3/ProtoLike.s",
          "Proto/proto/dwtools/abase/l3.test",
          "Proto/proto/dwtools/abase/l3.test/Proto.test.s",
          "Proto/proto/dwtools/abase/l3.test/ProtoLike.test.s"
        ],
        "criterion" : { "default" : 1, "export" : 1 }
      }
    }
    test.identical( outfile.path, expectedPath );
    // logger.log( _.toJson( outfile.path ) );

    return null;
  })

  /* - */

  return ready;
}

importLocalRepo.timeOut = 200000;

//

/*
 - check caching of modules in out-willfiles
*/

function importOutWithDeletedSource( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-with-submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let modulePath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = 'export first';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  })

  shell({ args : '.clean' })
  shell({ args : '.with a .export' })
  shell({ args : '.with b .export' })
  shell({ args : '.with ab-named .export' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( outPath );
    test.identical( files, [ '.', './module-a.out.will.yml', './module-ab-named.out.will.yml', './module-b.out.will.yml' ] );

    _.fileProvider.filesDelete( _.path.join( routinePath, 'a.will.yml' ) );
    _.fileProvider.filesDelete( _.path.join( routinePath, 'b.will.yml' ) );
    _.fileProvider.filesDelete( _.path.join( routinePath, 'ab' ) );
    _.fileProvider.filesDelete( _.path.join( routinePath, 'ab-named.will.yml' ) );

    return null;
  })

  shell({ args : '.with out/module-ab-named .modules.list' })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, '. Read .' ), 1 );
    test.identical( _.strCount( got.output, '. Read from cache .' ), 3 );
    test.identical( _.strCount( got.output, 'module::module-ab-named' ), 3 );
    test.identical( _.strCount( got.output, 'module::module-ab-named / module::module-a' ), 1 );
    test.identical( _.strCount( got.output, 'module::module-ab-named / module::module-b' ), 1 );
    test.identical( _.strCount( got.output, 'module::' ), 5 );
    test.identical( _.strCount( got.output, 'module' ), 21 );

    return null;
  })

  /* - */

  return ready;
}

importOutWithDeletedSource.timeOut = 200000;

//

function reflectNothingFromSubmodules( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-nothing-from-submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outDebugPath = _.path.join( routinePath, 'out/debug' );
  let outPath = _.path.join( routinePath, 'out' );
  let outWillPath = _.path.join( routinePath, 'out/reflect-nothing-from-submodules.out.will.yml' );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
  _.fileProvider.filesDelete( outDebugPath );

  /* - */

  ready.then( () =>
  {
    test.case = '.export'
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  /*
    Module has unused reflector and step : "reflect.submodules"
    Throws error if none submodule is defined
  */

  shell({ args : [ '.export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, '+ Write out willfile' ) );
    test.is( _.strHas( got.output, / \+ Exported .*exported::proto.export.* with 2 files in/ ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );
    var files = self.find( outPath );
    test.identical( files, [ '.', './reflect-nothing-from-submodules.out.will.yml', './debug', './debug/Single.s' ] );

    test.is( _.fileProvider.fileExists( outWillPath ) )
    var outfile = _.fileProvider.fileConfigRead( outWillPath );

    var reflector = outfile.reflector[ 'exported.files.proto.export' ];
    var expectedFilePath =
    {
      '.' : null,
      'Single.s' : null
    }
    test.identical( reflector.src.basePath, '.' );
    test.identical( reflector.src.prefixPath, 'path::exported.dir.proto.export' );
    test.identical( reflector.src.filePath, { 'path::exported.files.proto.export' : null } );

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
        "inherit" : [ "predefined.*" ]
      },
      "reflect.submodules1" :
      {
        "dst" : { "basePath" : ".", "prefixPath" : "path::out.debug" },
        "criterion" : { "debug" : 1 },
        "mandatory" : 1,
        "inherit" :
        [
          "submodule::*/exported::*=1/reflector::exported.files*=1"
        ]
      },
      "reflect.submodules2" :
      {
        "src" :
        {
          "filePath" : { "submodule::*/exported::*=1/path::exported.dir*=1" : "path::out.*=1" }
        },
        "criterion" : { "debug" : 1 },
        "mandatory" : 1,
        "inherit" : [ "predefined.*" ]
      },
      "exported.proto.export" :
      {
        "src" :
        {
          "filePath" : { "." : null },
          "prefixPath" : "../proto"
        },
        "criterion" : { "default" : 1, "export" : 1 },
        "mandatory" : 1
      },
      "exported.files.proto.export" :
      {
        "src" : { "filePath" : { 'path::exported.files.proto.export' : null }, "basePath" : ".", "prefixPath" : "path::exported.dir.proto.export" },
        "criterion" : { "default" : 1, "export" : 1 },
        "recursive" : 0,
        "mandatory" : 1
      }
    }
    test.identical( outfile.reflector, expectedReflector );
    // logger.log( _.toJson( outfile.reflector ) );

    return null;
  })

  return ready;
}

reflectNothingFromSubmodules.timeOut = 200000;

//

function reflectGetPath( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-get-path' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, 'module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready.then( () =>
  {
    test.case = '.build debug1'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug1' ] })
  .then( ( arg ) => validate( arg ) )

  /* - */

  ready.then( () =>
  {
    test.case = '.build debug2'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug2' ] })
  .then( ( arg ) => validate( arg ) )

  /* - */

  ready.then( () =>
  {
    test.case = '.build debug3'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug3' ] })
  .then( ( arg ) => validate( arg ) )

  /* - */

  return ready;

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
      './debug/dwtools/abase/l3/Path.s',
      './debug/dwtools/abase/l3.test',
      './debug/dwtools/abase/l3.test/Path.test.html',
      './debug/dwtools/abase/l3.test/Path.test.s',
      './debug/dwtools/abase/l4',
      './debug/dwtools/abase/l4/Paths.s',
      './debug/dwtools/abase/l4.test',
      './debug/dwtools/abase/l4.test/Paths.test.s',
      './debug/dwtools/abase/l7',
      './debug/dwtools/abase/l7/Glob.s',
      './debug/dwtools/abase/l7.test',
      './debug/dwtools/abase/l7.test/Glob.test.s'
    ]
    var files = self.find( outPath );
    test.is( files.length > 10 );
    test.identical( files, expected );

    return null;
  }

}

reflectGetPath.timeOut = 200000;

//

function reflectSubdir( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-subdir' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = 'setup'
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    return null;
  })
  shell({ args : [ '.each module .export' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'submodule.out.will.yml' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'out' ) ) );
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.build variant:1'
    _.fileProvider.filesDelete( outPath );
    return null;
  });
  shell({ args : [ '.build variant:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, './module/proto/File1.s' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, './out/debug/proto/File1.s' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'submodule.out.will.yml' ) ) );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'out' ) ) );

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
    var got = self.find( routinePath );
    test.identical( got, expected );

    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.build variant:2'
    _.fileProvider.filesDelete( outPath );
    return null;
  });
  shell({ args : [ '.build variant:2' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, './module/proto/File1.s' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, './out/debug/proto/File1.s' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'submodule.out.will.yml' ) ) );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'out' ) ) );

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
    var got = self.find( routinePath );
    test.identical( got, expected );

    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.build variant:3'
    _.fileProvider.filesDelete( outPath );
    return null;
  });
  shell({ args : [ '.build variant:3' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, './module/proto/File1.s' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, './out/debug/proto/File1.s' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'submodule.out.will.yml' ) ) );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'out' ) ) );

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
    var got = self.find( routinePath );
    test.identical( got, expected );

    return null;
  })

  return ready;
}

reflectSubdir.timeOut = 200000;

//

function reflectSubmodulesWithBase( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-submodules-with-base' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let submodule1OutFilePath = _.path.join( routinePath, 'submodule1.out.will.yml' );
  let submodule2OutFilePath = _.path.join( routinePath, 'submodule2.out.will.yml' );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  ready
  .then( () =>
  {
    test.case = 'setup'
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    return null;
  })

  /* */

  shell({ args : [ '.each module .export' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.isTerminal( submodule1OutFilePath ) );
    test.is( _.fileProvider.isTerminal( submodule2OutFilePath ) );
    return got;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'variant 0, src basePath : ../..'
    _.fileProvider.filesDelete( outPath )
    return null;
  });

  shell({ args : [ '.build variant:0' ] })

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
    var files = self.find( outPath );
    test.identical( files, expected );
    return got;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'variant 1, src basePath : "{submodule::*/exported::*=1/path::exported.dir*=1}/../.."'
    _.fileProvider.filesDelete( outPath )
    return null;
  });

  shell({ args : [ '.build variant:1' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var expected =
    [ '.', './debug', './debug/module', './debug/module/proto', './debug/module/proto/File1.s', './debug/module/proto/File2.s' ];
    // [ '.', './debug', './debug/proto', './debug/proto/File1.s', './debug/proto/File2.s' ]

    var files = self.find( outPath );
    test.identical( files, expected );
    return got;
  })

  /* */

  return ready;
}

reflectSubmodulesWithBase.timeOut = 150000;

//

function reflectComposite( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'composite-reflector' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* */

  ready.then( () =>
  {
    test.case = '.build out* variant:0'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:0' ] })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.then( () =>
  {
    test.case = '.build out* variant:1'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:1' ] })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.then( () =>
  {
    test.case = '.build out* variant:2'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:2' ] })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.then( () =>
  {
    test.case = '.build out* variant:3'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:3' ] })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.then( () =>
  {
    test.case = '.build out* variant:4'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:4' ] })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.js', './debug/dir1/File.test.js', './debug/dir1/File1.debug.js', './debug/dir1/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.then( () =>
  {
    test.case = '.build out* variant:5'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:5' ] })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.js', './debug/dir1/File.test.js', './debug/dir1/File1.debug.js', './debug/dir1/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.then( () =>
  {
    test.case = '.build out* variant:6'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:6' ] })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.test.js' ];
    var files = self.find( outPath );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.then( () =>
  {
    test.case = '.build out* variant:7'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:7' ] })
  .then( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.test.js' ];
    var files = self.find( outPath );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  return ready;
}

reflectComposite.timeOut = 200000;

//

function reflectRemoteGit( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-remote-git' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, 'module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )
  let local1Path = _.path.join( routinePath, 'PathFundamentals' );
  let local2Path = _.path.join( routinePath, 'Looker' );
  let local3Path = _.path.join( routinePath, 'Proto' );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  ready.then( () =>
  {
    test.case = '.build download.* variant:1'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:1' ] })
  .then( ( arg ) => validate1( arg ) )

  //

  .then( () =>
  {
    test.case = '.build download.* variant:2'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:2' ] })
  .then( ( arg ) => validate1( arg ) )

  //

  .then( () =>
  {
    test.case = '.build download.* variant:3'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:3' ] })
  .then( ( arg ) => validate1( arg ) )

  //

  .then( () =>
  {
    test.case = '.build download.* variant:4'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:4' ] })
  .then( ( arg ) => validate1( arg ) )

  //

  .then( () =>
  {
    test.case = '.build download.* variant:5'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:5' ] })
  .then( ( arg ) => validate1( arg ) )

  //

  .then( () =>
  {
    test.case = '.build download.* variant:6'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:6' ] })
  .then( ( arg ) => validate1( arg ) )

  //

  .then( () =>
  {
    test.case = '.build download.* variant:7'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:7' ] })
  .then( ( arg ) => validate2( arg ) )

  //

  .then( () =>
  {
    _.fileProvider.filesDelete( local1Path );
    _.fileProvider.filesDelete( local2Path );
    _.fileProvider.filesDelete( local3Path );
    return null;
  })

  return ready;

  /* */

  function validate1( arg )
  {
    test.identical( arg.exitCode, 0 );
    var files = self.find( local1Path );
    test.gt( files.length, 90 );
    return null;
  }

  /* */

  function validate2( arg )
  {
    test.identical( arg.exitCode, 0 );

    var files = self.find( local1Path );
    test.gt( files.length, 90 );
    var files = self.find( local2Path );
    test.gt( files.length, 70 );
    var files = self.find( local3Path );
    test.gt( files.length, 75 );

    return null;
  }

}

reflectRemoteGit.timeOut = 200000;

//

function reflectRemoteHttp( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-remote-http' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, 'module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )
  let outPath = _.path.join( routinePath, 'out' );
  let localFilePath = _.path.join( routinePath, 'out/Tools.s' );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  ready.then( () =>
  {
    test.case = '.build download'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  // debugger;
  // shell({ args : [ '.builds.list' ] })
  shell({ args : [ '.build download' ] })
  .then( ( arg ) =>
  {
    debugger;
    test.is( _.fileProvider.isTerminal( localFilePath ) );
    test.gt( _.fileProvider.fileSize( localFilePath ), 200 );
    return null;
  })

  return ready;
}

reflectRemoteHttp.timeOut = 200000;

//

function reflectWithOptions( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-with-options' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let filePath = _.path.join( routinePath, 'file' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with mandatory .build variant1';
    return null;
  })

  shell({ args : [ '.with mandatory .clean' ] })
  shell({ args : [ '.with mandatory .build variant1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /\+ .*reflector::reflect\.proto1.* reflected 3 files .+\/reflectWithOptions\/.* : .*out\/debug.* <- .*proto.* in/ ) );
    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/File.js', './debug/File.test.js' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with mandatory .build variant2';
    return null;
  })

  shell({ args : [ '.with mandatory .clean' ] })
  shell({ args : [ '.with mandatory .build variant2' ] })
  .finally( ( err, got ) =>
  {
    test.is( !err );
    test.is( !!got.exitCode );
    test.identical( _.strCount( got.output, 'unhandled errorr' ), 0 );
    test.identical( _.strCount( got.output, '====' ), 0 );
    test.is( _.strHas( got.output, /Failed .*module::.+ \/ step::reflect\.proto2/ ) );
    test.is( _.strHas( got.output, /Error\. No file moved : .+reflectWithOptions.* : .*out\/debug.* <- .*proto2.*/ ) );
    var files = self.find( outPath );
    test.identical( files, [] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with mandatory .build variant3';
    return null;
  })

  shell({ args : [ '.with mandatory .clean' ] })
  shell({ args : [ '.with mandatory .build variant3' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /\+ .*reflector::reflect\.proto3.* reflected 0 files .+\/reflectWithOptions\/.* : .*out\/debug.* <- .*proto.* in/ ) );
    var files = self.find( outPath );
    test.identical( files, [] );
    return null;
  })

  /* - */

  return ready;
}

//

function reflectWithSelectorInDstFilter( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-selecting-dst' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let filePath = _.path.join( routinePath, 'file' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

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

  ready
  .then( () =>
  {
    test.case = '.build debug';
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/Single.s' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build release';
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build release' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './release', './release/Single.s' ] );
    return null;
  })

  /* - */

  return ready;
}

//

function reflectSubmodulesWithCriterion( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-with-criterion' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out/debug' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = 'reflect only A'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build A' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    var expected = [ '.', './A.js' ];
    test.identical( files, expected );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = 'reflect only B'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build B' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    var expected = [ '.', './B.js' ];
    test.identical( files, expected );
    return null;
  })

  /* - */

  return ready;
}

//

function reflectSubmodulesWithPluralCriterionManualExport( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-submodules-with-plural-criterion' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = 'reflect informal submodule, manual export'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.each module .export' ] })

  // fails with error on first run

  shell({ args : [ '.build variant1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    var expected = [ '.', './debug', './debug/File.s' ];
    test.identical( files, expected );
    return null;
  })

  return ready;
}

//

function reflectSubmodulesWithPluralCriterionAutoExport( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-submodules-with-plural-criterion' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = 'reflect informal submodule exported using steps, two builds in a row'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  //first run works

  shell({ args : [ '.build variant2' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    var expected = [ '.', './debug', './debug/File.s' ];
    test.identical( files, expected );
    return null;
  })

  //second run fails

  shell({ args : [ '.build variant2' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    var expected = [ '.', './debug', './debug/File.s' ];
    test.identical( files, expected );
    return null;
  })

  return ready;
}

reflectSubmodulesWithPluralCriterionAutoExport.timeOut = 300000;


//

function reflectInherit( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-inherit' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build reflect.proto1'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build reflect.proto1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /\+ .*reflector::reflect.proto1.* reflected 6 files/ ) );
    test.is( _.strHas( got.output, /.*out\/debug1.* <- .*proto.*/ ) );
    var files = self.find( routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug1', './out/debug1/File.js', './out/debug1/File.s', './out/debug1/File.test.js', './out/debug1/some.test', './out/debug1/some.test/File2.js', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build reflect.proto2'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build reflect.proto2' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /\+ .*reflector::reflect.proto2.* reflected 6 files/ ) );
    test.is( _.strHas( got.output, /.*out\/debug2.* <- .*proto.*/ ) );
    var files = self.find( routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug2', './out/debug2/File.js', './out/debug2/File.s', './out/debug2/File.test.js', './out/debug2/some.test', './out/debug2/some.test/File2.js', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build reflect.proto3'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build reflect.proto3' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /\+ .*reflector::reflect.proto3.* reflected 6 files/ ) );
    test.is( _.strHas( got.output, /.*out\/debug1.* <- .*proto.*/ ) );
    var files = self.find( routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug1', './out/debug1/File.js', './out/debug1/File.s', './out/debug1/File.test.js', './out/debug1/some.test', './out/debug1/some.test/File2.js', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build reflect.proto4'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build reflect.proto4' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /\+ .*reflector::reflect.proto4.* reflected 6 files/ ) );
    test.is( _.strHas( got.output, /.*out\/debug2.* <- .*proto.*/ ) );
    var files = self.find( routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug2', './out/debug2/File.js', './out/debug2/File.s', './out/debug2/File.test.js', './out/debug2/some.test', './out/debug2/some.test/File2.js', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build reflect.proto5'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build reflect.proto5' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /\+ .*reflector::reflect.proto5.* reflected 6 files/ ) );
    test.is( _.strHas( got.output, /.*out\/debug2.* <- .*proto.*/ ) );
    var files = self.find( routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug2', './out/debug2/File.js', './out/debug2/File.s', './out/debug2/File.test.js', './out/debug2/some.test', './out/debug2/some.test/File2.js', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build not1'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build not1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /\+ .*reflector::reflect\.not\.test\.only\.js\.v1.* reflected 6 files/ ) );
    test.is( _.strHas( got.output, /.*out.* <- .*proto.*/ ) );
    var files = self.find( routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/debug1', './out/debug1/File.js', './out/debug1/File.s', './out/debug2', './out/debug2/File.js', './out/debug2/File.s', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build reflect.files1'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build reflect.files1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /\+ .*reflector::reflect\.files1.* reflected 2 files .*:.*out.*<-.*proto/ ), 1 );
    test.identical( _.strCount( got.output, /.*out.* <- .*proto.*/ ), 1 );
    var files = self.find( routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/File.js', './out/File.s', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build reflect.files2'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build reflect.files2' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /\+ .*reflector::reflect\.files2.* reflected 2 files .*:.*out.*<-.*proto/ ), 1 );
    test.identical( _.strCount( got.output, /.*out.* <- .*proto.*/ ), 1 );
    var files = self.find( routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/File.js', './out/File.s', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build reflect.files3'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build reflect.files3' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /\+ .*reflector::reflect\.files3.* reflected 2 files .*:.*out.*<-.*proto/ ), 1 );
    test.identical( _.strCount( got.output, /.*out.* <- .*proto.*/ ), 1 );
    var files = self.find( routinePath );
    test.identical( files, [ '.', './.will.yml', './out', './out/File.js', './out/File.s', './proto', './proto/File.js', './proto/File.s', './proto/File.test.js', './proto/some.test', './proto/some.test/File2.js' ] );
    return null;
  })

  /* - */

  return ready;
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
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-inherit-submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = 'setup'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.each module .export' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( routinePath );
    test.identical( files, [ '.', './a.will.yml', './b.will.yml', './c.will.yml', './submodule1.out.will.yml', './submodule2.out.will.yml', './submodule3.out.will.yml', './submodule4.out.will.yml', './module', './module/submodule1.will.yml', './module/submodule2.will.yml', './module/submodule3.will.yml', './module/submodule4.will.yml', './module/proto', './module/proto/File1.s', './module/proto/File2.s', './module/proto1', './module/proto1/File1.s', './module/proto2', './module/proto2/File2.s' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with a .build'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.with a .build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/File1.s', './debug/File2.s' ] );
    // var read = _.fileProvider.fileRead( _.path.join( outPath, 'debug' ) );
    // test.equivalent( read, 'console.log( \'File2.s\' );' );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with b .build'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.with b .build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/f1', './debug/f2' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with c .build'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.with c .build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/File1.s', './debug/File2.s' ] );
    return null;
  })

  /* - */

  return ready;
}

//

function reflectComplexInherit( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'export-with-submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with ab/ .build';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.with a .export' ] })
  shell({ args : [ '.with b .export' ] })
  shell({ args : [ '.with ab/ .build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ .*reflector::files\.all.* reflected 11 files .*\/.* : .*out\/ab\/files.* <- .*proto.* in/ ) );
    var files = self.find( outPath );
    test.identical( files, [ '.', './module-a.out.will.yml', './module-b.out.will.yml', './ab', './ab/files', './ab/files/a', './ab/files/a/File.js', './ab/files/b', './ab/files/b/-Excluded.js', './ab/files/b/File.js', './ab/files/b/File.test.js', './ab/files/b/File1.debug.js', './ab/files/b/File1.release.js', './ab/files/b/File2.debug.js', './ab/files/b/File2.release.js', './ab/files/dir3.test' ] );
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.with abac/ .build';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.with a .export' ] })
  shell({ args : [ '.with b .export' ] })
  shell({ args : [ '.with c .export' ] })
  shell({ args : [ '.with ab/ .export' ] })
  shell({ args : [ '.with abac/ .build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ .*reflector::files\.all.* reflected 13 files .*\/.* : .*out\/abac\/files.* <- .*proto.* in/ ) );
    var files = self.find( outPath );
    test.identical( files, [ '.', './module-a.out.will.yml', './module-b.out.will.yml', './module-c.out.will.yml', './ab', './ab/module-ab.out.will.yml', './abac', './abac/files', './abac/files/a', './abac/files/a/File.js', './abac/files/b', './abac/files/b/-Excluded.js', './abac/files/b/File.js', './abac/files/b/File.test.js', './abac/files/b/File1.debug.js', './abac/files/b/File1.release.js', './abac/files/b/File2.debug.js', './abac/files/b/File2.release.js', './abac/files/c', './abac/files/c/File.js', './abac/files/dir3.test' ] );
    return null;
  })

  /* - */

  return ready;
}

//

function reflectorMasks( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflector-masks' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  test.description = 'should handle correct files';

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* - */

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build copy.' ] })

  .then( ( got ) =>
  {
    test.case = 'mask directory';

    var files = self.find( outPath );
    test.identical( files, [ '.', './release', './release/proto.two' ] );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, new RegExp( '\\+ .*.reflector::reflect\\.copy\\..* reflected ' + String( files.length - 1 ) + ' files ' ) ) );
    debugger;

    return null;
  })

  /* - */

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build copy.debug' ] })

  .then( ( got ) =>
  {
    test.case = 'mask terminal';

    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/build.txt.js', './debug/manual.md', './debug/package.json', './debug/tutorial.md' ] );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, new RegExp( '\\+ .*.reflector::reflect\\.copy\\..* reflected ' + String( files.length - 1 ) + ' files ' ) ) );

    return null;
  })

  /* - */

  return ready;
}

reflectorMasks.timeOut = 200000;

//

function shellWithCriterion( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'step-shell-with-criterion' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  /* Checks if shell step supports plural criterion and which path is selected using current value of criterion */

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* - */

  shell({ args : [ '.build A' ] })

  .then( ( got ) =>
  {
    test.description = 'should execute file A.js';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Executed-A.js' ) );

    return null;
  })

  /* - */

  shell({ args : [ '.build B' ] })

  .then( ( got ) =>
  {
    test.description = 'should execute file B.js';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Executed-B.js' ) );

    return null;
  })

  /* - */

  return ready;
}

shellWithCriterion.timeOut = 200000;

//

/*
  Checks amount of output from shell step depending on value of verbosity option
*/

function shellVerbosity( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'step-shell-verbosity' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* - */

  shell({ args : [ '.build verbosity.0' ] })

  .then( ( got ) =>
  {
    test.case = '.build verbosity.0';

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'node -e "console.log( \'message from shell\' )"' ), 0 );
    test.identical( _.strCount( got.output, routinePath ), 1 );
    test.identical( _.strCount( got.output, 'message from shell' ), 0 );
    test.identical( _.strCount( got.output, 'Process returned error code 0' ), 0 );

    return null;
  })

  /* - */

  shell({ args : [ '.build verbosity.1' ] })

  .then( ( got ) =>
  {
    test.case = '.build verbosity.1';

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'node -e "console.log( \'message from shell\' )"' ), 1 );
    test.identical( _.strCount( got.output, routinePath ), 1 );
    test.identical( _.strCount( got.output, 'message from shell' ), 1 );
    test.identical( _.strCount( got.output, 'Process returned error code 0' ), 0 );

    return null;
  })

  /* - */

  shell({ args : [ '.build verbosity.2' ] })

  .then( ( got ) =>
  {
    test.case = '.build verbosity.2';

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'node -e "console.log( \'message from shell\' )"' ), 1 );
    test.identical( _.strCount( got.output, routinePath ), 1 );
    test.identical( _.strCount( got.output, 'message from shell' ), 2 );
    test.identical( _.strCount( got.output, 'Process returned error code 0' ), 0 );

    return null;
  })

  /* - */

  shell({ args : [ '.build verbosity.3' ] })

  .then( ( got ) =>
  {
    test.case = '.build verbosity.3';

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'node -e "console.log( \'message from shell\' )"' ), 1 );
    test.identical( _.strCount( got.output, routinePath ), 2 );
    test.identical( _.strCount( got.output, 'message from shell' ), 2 );
    test.identical( _.strCount( got.output, 'Process returned error code 0' ), 0 );

    return null;
  })

  /* - */

  shell({ args : [ '.build verbosity.5' ] })

  .then( ( got ) =>
  {
    test.case = 'verbosity:5';

    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'node -e "console.log( \'message from shell\' )"' ), 1 );
    test.identical( _.strCount( got.output, routinePath ), 2 );
    test.identical( _.strCount( got.output, 'message from shell' ), 2 );
    test.identical( _.strCount( got.output, 'Process returned error code 0' ), 1 );

    return null;
  })

  /* - */

  return ready;
}

//

function functionStringsJoin( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'function-strings-join' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build strings.join'
    return null;
  })
  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build strings.join' ] })
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
    var read = _.fileProvider.fileRead( _.path.join( routinePath, 'out1.js' ) );
    test.identical( read, expected );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build multiply'
    return null;
  })
  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build multiply' ] })
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
    var read = _.fileProvider.fileRead( _.path.join( routinePath, 'out2.js' ) );
    test.identical( read, expected );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build echo1'
    return null;
  })
  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build echo1' ] })
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

  ready
  .then( () =>
  {
    test.case = '.build echo2'
    return null;
  })
  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build echo2' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, 'node' ), 6 );
    test.identical( _.strCount( got.output, 'Echo.js op2 op3 op1' ), 2 );
    test.identical( _.strCount( got.output, 'Echo.js op2 op3 op2' ), 2 );

    return null;
  })

  /* - */

  return ready;
}

//

function functionPlatform( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'function-platform' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.build'
    return null;
  })
  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, /\+ .*reflector::copy.* reflected 2 files .*functionPlatform\/.* : .*out\/dir\.windows.* <- .*proto.* in/ ), 1 );

    var Os = require( 'os' );
    var files = self.find( outPath );

    if( Os.platform() === 'win32' )
    test.identical( files, [ '.', './dir.windows', './dir.windows/File.js' ] );
    else if( Os.platform() === 'darwin' )
    test.identical( files, [ '.', './dir.osx', './dir.osx/File.js' ] );
    else
    test.identical( files, [ '.', './dir.posix', './dir.posix/File.js' ] );

    return null;
  })

  /* - */

  return ready;
}

//

/*
  Checks resolving selector with criterion.
*/

function fucntionThisCriterion( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'step-shell-using-criterion-value' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* - */

  shell({ args : [ '.build debug' ] })

  .then( ( got ) =>
  {
    test.description = 'should print debug:1';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'debug:1' ) );

    return null;
  })

  /* - */

  shell({ args : [ '.build release' ] })

  .then( ( got ) =>
  {
    test.description = 'should print debug:0';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'debug:0' ) );

    return null;
  })

  /* - */

  return ready;
}

fucntionThisCriterion.timeOut = 200000;

//

function submodulesDownloadSingle( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'single' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  shell({ args : [ '.submodules.download' ] })

  .then( ( got ) =>
  {
    test.case = '.submodules.download';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /0\/0 submodule\(s\) of .*module::single.* were downloaded in/ ) );
    return null;
  })

  /* - */

  shell({ args : [ '.submodules.download' ] })

  .then( ( got ) =>
  {
    test.case = '.submodules.download'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /0\/0 submodule\(s\) of .*module::single.* were downloaded in/ ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )
    return null;
  })

  /* - */

  shell({ args : [ '.submodules.update' ] })

  .then( ( got ) =>
  {
    test.case = '.submodules.update'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /0\/0 submodule\(s\) of .*module::single.* were updated in/ ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )
    return null;
  })

  /* - */

  shell({ args : [ '.submodules.clean' ] })

  .then( ( got ) =>
  {
    test.case = '.submodules.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted 0 file(s)' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )
    return null;
  })

  return ready;

}

submodulesDownloadSingle.timeOut = 200000;

//

function submodulesDownloadUpdate( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null )
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* */

  ready

  /* */

  .then( () =>
  {
    test.case = '.submodules.download - first time';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  shell({ args : [ '.submodules.download' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /2\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );

    var files = self.find( submodulesPath );

    test.is( files.length > 30 );

    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'Tools' ) ) )
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'PathFundamentals' ) ) )
    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.submodules.download - again';
    return null;
  })
  shell({ args : [ '.submodules.download' ] })
  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /0\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'Tools' ) ) )
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'PathFundamentals' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )

    var files = self.find( _.path.join( submodulesPath, 'Tools' ) );
    test.is( files.length > 3 );

    var files = self.find( _.path.join( submodulesPath, 'PathFundamentals' ) );
    test.is( files.length > 3 );

    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.submodules.update - first time';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })
  shell({ args : [ '.submodules.update' ] })
  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /2\/2 submodule\(s\) of .*module::submodules.* were updated in/ ) );
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'Tools' ) ) )
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'PathFundamentals' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )

    var files = self.find( _.path.join( submodulesPath, 'Tools' ) );
    test.is( files.length );

    var files = self.find( _.path.join( submodulesPath, 'PathFundamentals' ) );
    test.is( files.length );

    return null;
  })

  /* */

  .then( () =>
  {
    test.case = '.submodules.update - again';
    return null;
  })
  shell({ args : [ '.submodules.update' ] })
  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /0\/2 submodule\(s\) of .*module::submodules.* were updated in/ ) );
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'Tools' ) ) )
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'PathFundamentals' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )

    var files = self.find( _.path.join( submodulesPath, 'Tools' ) );
    test.is( files.length );

    var files = self.find( _.path.join( submodulesPath, 'PathFundamentals' ) );
    test.is( files.length );

    return null;
  })

  /* */

  var files;

  ready
  .then( () =>
  {
    test.case = '.submodules.clean';
    files = self.find( submodulesPath );
    return files;
  })

  shell({ args : [ '.submodules.clean' ] })
  .then( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `${files.length}` ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* phantom problem ? */

    return null;
  })

  /* */

  return ready;
}

submodulesDownloadUpdate.timeOut = 300000;

//

function submodulesDownloadUpdateDry( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-detached' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null )
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* */

  ready
  .then( () =>
  {
    test.case = '.submodules.download dry:1';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  shell({ args : [ '.submodules.download dry:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ .*module::Tools.* will be downloaded version .*/ ) );
    test.is( _.strHas( got.output, / \+ .*module::PathFundamentals.* will be downloaded version .*c94e0130358ba54fc47237e15bac1ab18024c0a9.*/ ) );
    test.is( _.strHas( got.output, / \+ .*module::Color.* will be downloaded version .*0.3.115.*/ ) );
    test.is( _.strHas( got.output, / \+ 3\/6 submodule\(s\) of .*module::submodules-detached.* will be downloaded/ ) );
    var files = self.find( submodulesPath );
    test.is( files.length === 0 );
    return null;
  })

  /* */

  ready
  .then( () =>
  {
    test.case = '.submodules.download dry:1 -- after download';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  shell({ args : [ '.submodules.download' ] })
  shell({ args : [ '.submodules.download dry:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ 0\/6 submodule\(s\) of .*module::submodules-detached.* will be downloaded/ ) );
    var files = self.find( submodulesPath );
    test.gt( files.length, 150 );
    return null;
  })

  /* */

  ready
  .then( () =>
  {
    test.case = '.submodules.update dry:1';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  shell({ args : [ '.submodules.update dry:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ .*module::Tools.* will be updated to version .*/ ) );
    test.is( _.strHas( got.output, / \+ .*module::PathFundamentals.* will be updated to version .*c94e0130358ba54fc47237e15bac1ab18024c0a9.*/ ) );
    test.is( _.strHas( got.output, / \+ .*module::Color.* will be updated to version .*0.3.115.*/ ) );
    test.is( _.strHas( got.output, / \+ 3\/6 submodule\(s\) of .*module::submodules-detached.* will be update/ ) );
    var files = self.find( submodulesPath );
    test.is( files.length === 0 );
    return null;
  })

  /* */

  ready
  .then( () =>
  {
    test.case = '.submodules.update dry:1 -- after update';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  shell({ args : [ '.submodules.update' ] })
  shell({ args : [ '.submodules.update dry:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ 0\/6 submodule\(s\) of .*module::submodules-detached.* will be updated/ ) );
    var files = self.find( submodulesPath );
    test.gt( files.length, 150 );
    return null;
  })

  /* */

  return ready;
}

submodulesDownloadUpdateDry.timeOut = 300000;

//

function submodulesUpdate( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-update' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null )
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* */

  ready
  .then( () =>
  {
    test.case = '.submodules.update';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.submodules.update' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ .*module::Tools.* was updated to version .*fc457abd063cb49edc857e46b74b4769da7124e3.* in/ ) );
    test.is( _.strHas( got.output, / \+ .*module::PathFundamentals.* was updated to version .*master.* in/ ) );
    test.is( _.strHas( got.output, / \+ .*module::UriFundamentals.* was updated to version .*3686d72cc0b8f6573217c947a4b379c38b02e39b.* in/ ) );
    test.is( _.strHas( got.output, / \+ 3\/3 submodule\(s\) of .*module::submodules.* were updated in/ ) );
    return null;
  })

  /* */

  ready
  .then( () =>
  {
    test.case = '.submodules.update -- second';
    return null;
  })

  shell({ args : [ '.submodules.update' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, /module::Tools/ ) );
    test.is( !_.strHas( got.output, /module::PathFundamentals/ ) );
    test.is( !_.strHas( got.output, /module::UriFundamentals/ ) );
    test.is( _.strHas( got.output, / \+ 0\/3 submodule\(s\) of .*module::submodules.* were updated in/ ) );
    return null;
  })

  /* */

  ready
  .then( () =>
  {
    test.case = '.submodules.update -- after patch';
    var read = _.fileProvider.fileRead( _.path.join( routinePath, '.im.will.yml' ) );
    read = _.strReplace( read, 'fc457abd063cb49edc857e46b74b4769da7124e3', 'master' )
    _.fileProvider.fileWrite( _.path.join( routinePath, '.im.will.yml' ), read );
    return null;
  })

  shell({ args : [ '.submodules.update' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, / \+ .*module::Tools.* was updated to version .*master.* in/ ) );
    test.is( !_.strHas( got.output, /module::PathFundamentals/ ) );
    test.is( !_.strHas( got.output, /module::UriFundamentals/ ) );
    test.is( _.strHas( got.output, / \+ 1\/3 submodule\(s\) of .*module::submodules.* were updated in/ ) );
    return null;
  })

  /* */

  ready
  .then( () =>
  {
    test.case = '.submodules.update -- second';
    return null;
  })

  shell({ args : [ '.submodules.update' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( !_.strHas( got.output, /module::Tools/ ) );
    test.is( !_.strHas( got.output, /module::PathFundamentals/ ) );
    test.is( !_.strHas( got.output, /module::UriFundamentals/ ) );
    test.is( _.strHas( got.output, / \+ 0\/3 submodule\(s\) of .*module::submodules.* were updated in/ ) );
    return null;
  })

  /* */

  return ready;
}

submodulesUpdate.timeOut = 300000;

//

function submodulesUpdateSwitchBranch( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-update-switch-branch' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let experimentModulePath = _.path.join( submodulesPath, 'experiment' );
  let willfilePath = _.path.join( routinePath, '.will.yml' );
  
  let ready = new _.Consequence().take( null )
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  
  ready
  .then( () =>
  {
    test.case = 'download master branch';
    return null;
  })
  
  shell({ args : [ '.submodules.update' ] })
  
  .then( () => 
  {
    let currentVersion = _.fileProvider.fileRead( _.path.join( submodulesPath, 'experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })
  
  .then( () =>
  {
    test.case = 'switch master to dev';
    let willFile = _.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule.experiment = _.strReplaceAll( willFile.submodule.experiment, '#master', '#dev' );
    _.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    return null;
  })
  
  shell({ args : [ '.submodules.update' ] })
  
  .then( () => 
  {
    let currentVersion = _.fileProvider.fileRead( _.path.join( submodulesPath, 'experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/dev' ) );
    return null;
  })
  
  .then( () =>
  {
    test.case = 'switch dev to detached state';
    let willFile = _.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule.experiment = _.strReplaceAll( willFile.submodule.experiment, '#dev', '#cfaa3c7782b9ff59cdcd28cb0f25d421e67f99ce' );
    _.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    return null;
  })
  
  shell({ args : [ '.submodules.update' ] })
  
  .then( () => 
  {
    let currentVersion = _.fileProvider.fileRead( _.path.join( submodulesPath, 'experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'cfaa3c7782b9ff59cdcd28cb0f25d421e67f99ce' ) );
    return null;
  })
  
  .then( () =>
  {
    test.case = 'switch detached state to master';
    let willFile = _.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule.experiment = _.strReplaceAll( willFile.submodule.experiment, '#cfaa3c7782b9ff59cdcd28cb0f25d421e67f99ce', '#master' );
    _.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    return null;
  })
  
  shell({ args : [ '.submodules.update' ] })
  
  .then( () => 
  {
    let currentVersion = _.fileProvider.fileRead( _.path.join( submodulesPath, 'experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })
  
  .then( () =>
  {
    test.case = 'master has local change, cause conflict when switch to dev';
    let willFile = _.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule.experiment = _.strReplaceAll( willFile.submodule.experiment, '#master', '#dev' );
    _.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    let readmePath = _.path.join( submodulesPath, 'experiment/README.md' );
    _.fileProvider.fileWrite({ filePath : readmePath, data : 'master' });
    return null;
  })
  
  .then( () => 
  { 
    let con = shell({ args : [ '.submodules.update' ], ready : null });
    return test.shouldThrowErrorAsync( con );
  })
  
  _.shell
  ({ 
    execPath : 'git status', 
    currentPath : experimentModulePath,
    ready : ready, 
    outputCollecting : 1 
  })
  
  .then( ( got ) => 
  { 
    test.is( _.strHas( got.output, 'both modified:   README.md' ) )
    
    let currentVersion = _.fileProvider.fileRead( _.path.join( submodulesPath, 'experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/dev' ) );
    return null;
  })
  
  /**/
  
  ready.then( () => 
  { 
    test.case = 'master has new commit, changing branch to dev';
    _.fileProvider.filesDelete( routinePath ); 
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })
  
  shell({ args : [ '.submodules.update' ] })
  
  _.shell
  ({ 
    execPath : 'git commit --allow-empty -m commitofmaster', 
    currentPath : experimentModulePath, 
    ready : ready 
  })
  .then( () =>
  {
    let willFile = _.fileProvider.fileRead({ filePath : willfilePath, encoding : 'yml' });
    willFile.submodule.experiment = _.strReplaceAll( willFile.submodule.experiment, '#master', '#dev' );
    _.fileProvider.fileWrite({ filePath : willfilePath, data : willFile, encoding : 'yml' });
    return null;
  })
  
  shell({ args : [ '.submodules.update' ] })
  
  .then( () =>
  {
    let currentVersion = _.fileProvider.fileRead( _.path.join( submodulesPath, 'experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/dev' ) );
    return null;
  })
  
  /**/
  
  ready.then( () => 
  { 
    test.case = 'master and remote master have new commits';
    _.fileProvider.filesDelete( routinePath ); 
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })
  
  shell({ args : [ '.submodules.update' ] })
  
  _.shell
  ({
    execPath : 'git reset --hard HEAD~1',
    currentPath : experimentModulePath,
    ready : ready
  })
  
  _.shell
  ({
    execPath : 'git commit --allow-empty -m emptycommit',
    currentPath : experimentModulePath,
    ready : ready
  })
  
  shell({ args : [ '.submodules.update' ] })
  
  _.shell
  ({
    execPath : 'git status',
    currentPath : experimentModulePath,
    outputCollecting : 1,
    ready : ready
  })
  
  .then( ( got ) => 
  {
    test.is( _.strHas( got.output, `Your branch is ahead of 'origin/master' by 2 commits` ) );
    
    let currentVersion = _.fileProvider.fileRead( _.path.join( submodulesPath, 'experiment/.git/HEAD' ) );
    test.is( _.strHas( currentVersion, 'ref: refs/heads/master' ) );
    return null;
  })
  
  return ready;
}

//

function stepSubmodulesDownload( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'step-submodules-download' );
  let routinePath = _.path.join( self.tempDir, test.name );

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
  _.fileProvider.filesDelete( _.path.join( routinePath, '.module' ) );
  _.fileProvider.filesDelete( _.path.join( routinePath, 'out/debug' ) );

  let execPath = _.path.nativize( _.path.join( __dirname, '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    verbosity : 3,
    ready : ready
  })

  /* - */

  shell()

  .then( ( got ) =>
  {
    test.case = 'simple run without args'
    test.identical( got.exitCode, 0 );
    test.is( got.output.length );
    return null;
  })

  /* - */

  shell({ args : [ '.resources.list' ] })

  .then( ( got ) =>
  {
    test.case = 'list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `git+https:///github.com/Wandalen/wTools.git/out/wTools.out.will#master` ) );
    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = 'build'
    _.fileProvider.filesDelete( _.path.join( routinePath, '.module' ) );
    _.fileProvider.filesDelete( _.path.join( routinePath, 'out/debug' ) );
    return null;
  })

  shell({ args : [ '.build' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.gt( self.find( _.path.join( routinePath, '.module/Tools' ) ).length, 70 );
    test.gt( self.find( _.path.join( routinePath, 'out/debug' ) ).length, 50 );
    return null;
  })

  /* - */

  .then( () =>
  {
    test.case = 'export'
    _.fileProvider.filesDelete( _.path.join( routinePath, '.module' ) );
    _.fileProvider.filesDelete( _.path.join( routinePath, 'out/debug' ) );
    _.fileProvider.filesDelete( _.path.join( routinePath, 'out/Download.out.will.yml' ) );
    return null;
  })

  shell({ args : [ '.export' ] })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.gt( self.find( _.path.join( routinePath, '.module/Tools' ) ).length, 90 );
    test.gt( self.find( _.path.join( routinePath, 'out/debug' ) ).length, 50 );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/Download.out.will.yml' ) ) );
    return null;
  })

  /* - */

  return ready;
}

stepSubmodulesDownload.timeOut = 300000;

//

function upgradeDryDetached( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-detached' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let filePath = _.path.join( routinePath, 'file' );
  let modulePath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:1 negative:1 -- after full update';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.export' ] })
  shell({ args : [ '.submodules.upgrade dry:1 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.* : .* <- .*\.#c94e0130358ba54fc47237e15bac1ab18024c0a9.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/UriFundamentals\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#f4c04dbe078f3c00c84ff13edcc67478d320fddf.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/Proto\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/Procedure\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/Procedure\.informal\.will\.yml.* will be upgraded/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:1 negative:0 -- after full update';
    return null;
  })

  shell({ args : [ '.submodules.upgrade dry:1 negative:0' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.* : .* <- .*\.#c94e0130358ba54fc47237e15bac1ab18024c0a9.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/UriFundamentals\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#f4c04dbe078f3c00c84ff13edcc67478d320fddf.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/Proto\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/Procedure\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/Procedure\.informal\.will\.yml.* will be upgraded/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:1 negative:1 -- after informal update';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.each module .export' ] })
  shell({ args : [ '.submodules.upgrade dry:1 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.* : .* <- .*\.#c94e0130358ba54fc47237e15bac1ab18024c0a9.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/\.im\.will\.yml.* won't be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/UriFundamentals\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#f4c04dbe078f3c00c84ff13edcc67478d320fddf.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/Proto\.informal\.will\.yml.* will be upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/Procedure\.informal\.out\.will\.yml.* will be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/Procedure\.informal\.will\.yml.* will be upgraded/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:1 negative:1 -- after formal update';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.submodules.update' ] })
  shell({ args : [ '.submodules.upgrade dry:1 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.* : .* <- .*\.#c94e0130358ba54fc47237e15bac1ab18024c0a9.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* will be upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDryDetached\/\.module\/Color\/\.im\.will\.yml.* won't be upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/\.im\.will\.yml.* will be upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* will be upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* will be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/UriFundamentals\.informal\.will\.yml.* will be upgraded/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* will be upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#f4c04dbe078f3c00c84ff13edcc67478d320fddf.*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/Proto\.informal\.will\.yml.* will be upgraded/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* will be upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/out\/Procedure\.informal\.out\.will\.yml.* will be upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDryDetached\/module\/Procedure\.informal\.will\.yml.* will be upgraded/ ), 0 );

    return null;
  })

  /* - */

  return ready;
}

upgradeDryDetached.timeOut = 500000;

//

function upgradeDetached( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-detached' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let filePath = _.path.join( routinePath, 'file' );
  let modulePath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:1 -- after full update';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.export' ] })
  shell({ args : [ '.submodules.upgrade dry:0 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.* : .* <- .*\.#c94e0130358ba54fc47237e15bac1ab18024c0a9.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/UriFundamentals\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#f4c04dbe078f3c00c84ff13edcc67478d320fddf.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Procedure\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Procedure\.informal\.will\.yml.* was upgraded/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:0 -- after full update';

    _.fileProvider.filesDelete({ filePath : routinePath })
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.export' ] })
  shell({ args : [ '.submodules.upgrade dry:0 negative:0' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.* : .* <- .*\.#c94e0130358ba54fc47237e15bac1ab18024c0a9.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/UriFundamentals\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#f4c04dbe078f3c00c84ff13edcc67478d320fddf.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Procedure\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Procedure\.informal\.will\.yml.* was upgraded/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:1 -- after full update, second';
    return null;
  })

  shell({ args : [ '.submodules.upgrade dry:0 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/UriFundamentals\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/Procedure\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/Procedure\.informal\.will\.yml.* was skipped/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:0 -- after full update, second';
    return null;
  })

  shell({ args : [ '.submodules.upgrade dry:0 negative:0' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths/ ), 0 );
    test.identical( _.strCount( got.output, /was upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /will be upgraded/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/UriFundamentals\.informal\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/out\/Procedure\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/module\/Procedure\.informal\.will\.yml.* was skipped/ ), 0 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:1 -- after informal update';

    _.fileProvider.filesDelete({ filePath : routinePath })
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.each module .export' ] })
  shell({ args : [ '.submodules.upgrade dry:0 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.* : .* <- .*\.#c94e0130358ba54fc47237e15bac1ab18024c0a9.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was not upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/UriFundamentals\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#f4c04dbe078f3c00c84ff13edcc67478d320fddf.*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was upgraded/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Procedure\.informal\.out\.will\.yml.* was upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Procedure\.informal\.will\.yml.* was upgraded/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.upgrade dry:0 negative:1 -- after formal update';

    _.fileProvider.filesDelete({ filePath : routinePath })
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.submodules.update' ] })
  shell({ args : [ '.submodules.upgrade dry:0 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Tools\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.* : .* <- .*\.#c94e0130358ba54fc47237e15bac1ab18024c0a9.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was upgraded to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.* : .* <- .*\.#0.3.115.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /! .*upgradeDetached\/\.module\/Color\/\.im\.will\.yml.* was not upgraded/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/\.im\.will\.yml.* was upgraded/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/UriFundamentals\.informal\.will\.yml.* was upgraded/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.* : .* <- .*\.#f4c04dbe078f3c00c84ff13edcc67478d320fddf.*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Proto\.informal\.out\.will\.yml.* was upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Proto\.informal\.will\.yml.* was upgraded/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was upgraded to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/out\/Procedure\.informal\.out\.will\.yml.* was upgraded/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*upgradeDetached\/module\/Procedure\.informal\.will\.yml.* was upgraded/ ), 0 );

    return null;
  })

  /* - */

  return ready;
}

upgradeDetached.timeOut = 500000;

//

function fixateDryDetached( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-detached' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let filePath = _.path.join( routinePath, 'file' );
  let modulePath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:1 negative:1 -- after full update';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.export' ] })
  shell({ args : [ '.submodules.fixate dry:1 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/\.im\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/UriFundamentals\.informal\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/module\/Proto\.informal\.will\.yml.* will be skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/Procedure\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/Procedure\.informal\.will\.yml.* will be fixated/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:1 negative:0 -- after full update';
    return null;
  })

  shell({ args : [ '.submodules.fixate dry:1 negative:0' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/\.im\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/UriFundamentals\.informal\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/module\/Proto\.informal\.will\.yml.* will be skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/Procedure\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/Procedure\.informal\.will\.yml.* will be fixated/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:1 negative:1 -- after informal update';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.each module .export' ] })
  shell({ args : [ '.submodules.fixate dry:1 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/\.im\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/\.im\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/UriFundamentals\.informal\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/module\/Proto\.informal\.will\.yml.* will be skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/Procedure\.informal\.out\.will\.yml.* will be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/Procedure\.informal\.will\.yml.* will be fixated/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:1 negative:1 -- after formal update';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.submodules.update' ] })
  shell({ args : [ '.submodules.fixate dry:1 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* will be fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Tools\/\.im\.will\.yml.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/\.im\.will\.yml.* will be fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* won't be fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.module\/Color\/\.im\.will\.yml.* will be skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/\.im\.will\.yml.* will be skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* will be fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* will be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/UriFundamentals\.informal\.will\.yml.* will be fixated/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* won't be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/out\/Proto\.informal\.out\.will\.yml.* will be skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDryDetached\/module\/Proto\.informal\.will\.yml.* will be skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* will be fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/out\/Procedure\.informal\.out\.will\.yml.* will be fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDryDetached\/module\/Procedure\.informal\.will\.yml.* will be fixated/ ), 0 );

    return null;
  })

  /* - */

  return ready;
}

fixateDryDetached.timeOut = 500000;

//

function fixateDetached( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-detached' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let filePath = _.path.join( routinePath, 'file' );
  let modulePath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null );

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:1 -- after full update';
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.export' ] })
  shell({ args : [ '.submodules.fixate dry:0 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/\.im\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/UriFundamentals\.informal\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/Procedure\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/Procedure\.informal\.will\.yml.* was fixated/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:0 -- after full update';

    _.fileProvider.filesDelete({ filePath : routinePath })
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.export' ] })
  shell({ args : [ '.submodules.fixate dry:0 negative:0' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/\.im\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/UriFundamentals\.informal\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/Procedure\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/Procedure\.informal\.will\.yml.* was fixated/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:1 -- after full update, second';
    return null;
  })

  shell({ args : [ '.submodules.fixate dry:0 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 3 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/UriFundamentals\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Procedure\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Procedure\.informal\.will\.yml.* was skipped/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:0 -- after full update, second';
    return null;
  })

  shell({ args : [ '.submodules.fixate dry:0 negative:0' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths/ ), 0 );
    test.identical( _.strCount( got.output, /was fixated/ ), 0 );
    test.identical( _.strCount( got.output, /will be fixated/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/\.im\.will\.yml.* was fixated/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/UriFundamentals\.informal\.will\.yml.* was fixated/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/Procedure\.informal\.out\.will\.yml.* was fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/Procedure\.informal\.will\.yml.* was fixated/ ), 0 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:1 -- after informal update';

    _.fileProvider.filesDelete({ filePath : routinePath })
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.each module .export' ] })
  shell({ args : [ '.submodules.fixate dry:0 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/\.im\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/UriFundamentals\.informal\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/Procedure\.informal\.out\.will\.yml.* was fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/Procedure\.informal\.will\.yml.* was fixated/ ), 1 );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = '.submodules.fixate dry:0 negative:1 -- after formal update';

    _.fileProvider.filesDelete({ filePath : routinePath })
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.submodules.update' ] })
  shell({ args : [ '.submodules.fixate dry:0 negative:1' ] })
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Tools.* was fixated to version/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wTools\.git\/out\/wTools\.out\.will.* : .* <- .*\.#master.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/out\/wTools\.out\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Tools\/\.im\.will\.yml.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/\.im\.will\.yml.* was fixated/ ), 1 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::PathFundamentals.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/out\/wPathFundamentals\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/PathFundamentals\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Color.* was not fixated/ ), 1 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wColor\/out\/wColor\.out\.will.*/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/out\/wColor\.out\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.module\/Color\/\.im\.will\.yml.* was skipped/ ), 1 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/\.im\.will\.yml.* was skipped/ ), 2 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::UriFundamentals.* was fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wUriFundamentals\.git.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/UriFundamentals\.informal\.out\.will\.yml.* was fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/UriFundamentals\.informal\.will\.yml.* was fixated/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Proto.* was not fixated/ ), 0 );
    test.identical( _.strCount( got.output, /.*git\+https:\/\/\/github\.com\/Wandalen\/wProto\.git.*/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/out\/Proto\.informal\.out\.will\.yml.* was skipped/ ), 0 );
    test.identical( _.strCount( got.output, /! .*fixateDetached\/module\/Proto\.informal\.will\.yml.* was skipped/ ), 0 );

    test.identical( _.strCount( got.output, /Remote paths of .*module::submodules-detached \/ submodule::Procedure.* was fixated to version/ ), 0 );
    test.identical( _.strCount( got.output, /.*npm:\/\/\/wprocedure.* : .* <- .*\..*/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/out\/Procedure\.informal\.out\.will\.yml.* was fixated/ ), 0 );
    test.identical( _.strCount( got.output, /\+ .*fixateDetached\/module\/Procedure\.informal\.will\.yml.* was fixated/ ), 0 );

    return null;
  })

  /* - */

  return ready;
}

fixateDetached.timeOut = 500000;

//

function execWillbe( test )
{ 
  
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'execWillbe' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let execUnrestrictedPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/ExecUnrestricted' ) );
  let ready = new _.Consequence().take( null );
  
  /* This test routine checks if willbe can be terminated on early start from terminal when executed as child process using ExecUnrestricted script */
  
  let shell = _.sheller
  ({
    execPath : 'node',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });
  
  ready
  .then( () =>
  { 
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    return null;
  })
  
  .then( () => 
  { 
    test.case = 'execUnrestricted: terminate utility during heavy load of will files, should be terminated'
    let o = { args : [ execUnrestrictedPath, '.submodules.list' ], ready : null };
    
    let con = shell( o );
    
    o.process.stdout.on( 'data', ( data ) => 
    {
      if( _.bufferAnyIs( data ) )
      data = _.bufferToStr( data );
      
      if( _.strHas( data, 'wTools.out.will.yml' ) )
      { 
        console.log( 'Terminating willbe...' );
        o.process.kill( 'SIGINT' )
      }
    });
    
    return test.shouldThrowErrorAsync( con )
    .then( () => 
    {
      test.identical( o.exitCode, 255 );
      test.is( !_.strHas( o.output, 'wLogger.out.will.yml' ) )
      test.is( !_.strHas( o.output, 'wLoggerToJs.out.will.yml' ) )
      test.is( !_.strHas( o.output, 'wConsequence.out.will.yml' ) )
      test.is( !_.strHas( o.output, 'wInstancing.out.will.yml' ) )
      return null;
    })
  })
  
  /* */
  
  .then( () => 
  { 
    test.case = 'Exec: terminate utility during heavy load of will files, should fail'
    let o = { args : [ execPath, '.submodules.list' ], ready : null };
    
    let con = shell( o );
    
    o.process.stdout.on( 'data', ( data ) => 
    {
      if( _.bufferAnyIs( data ) )
      data = _.bufferToStr( data );
      
      if( _.strHas( data, 'wTools.out.will.yml' ) )
      { 
        console.log( 'Terminating willbe...' );
        o.process.kill( 'SIGINT' )
      }
    });
    
    return test.mustNotThrowError( con )
    .then( () => 
    {
      test.identical( o.exitCode, 0 );
      test.is( _.strHas( o.output, 'wLogger.out.will.yml' ) )
      test.is( _.strHas( o.output, 'wLoggerToJs.out.will.yml' ) )
      test.is( _.strHas( o.output, 'wConsequence.out.will.yml' ) )
      test.is( _.strHas( o.output, 'wInstancing.out.will.yml' ) )
      return null;
    })
  })
  
  return ready;
}

// --
//
// --

var Self =
{

  name : 'Tools/atop/WillExternals',
  silencing : 1,

  onSuiteBegin : onSuiteBegin,
  onSuiteEnd : onSuiteEnd,
  routineTimeOut : 60000,

  context :
  {
    tempDir : null,
    assetDirPath : null,
    find : null,
  },

  tests :
  {

    preCloneRepos,
    singleModuleSimplest,
    singleModuleWithSpaceTrivial,
    make,
    transpile,

    openWith,
    openEach,
    withMixed,
    eachMixed,
    withList,
    eachList,
    eachBrokenIll,
    eachBrokenNon,
    eachBrokenCommand,

    verbositySet,
    verbosityStepDelete,
    verbosityStepPrintName,

    help,
    listSingleModule,
    listWithSubmodulesSimple,
    listWithSubmodules,
    listSteps,
    // listComplexPaths, // xxx

    clean,
    cleanSingleModule,
    cleanBroken1,
    cleanBroken2,
    cleanBrokenSubmodules,
    cleanNoBuild,
    cleanDry,
    cleanSubmodules,
    cleanMixed,
    cleanWithInPath,

    buildSingleModule,
    buildSingleStep,
    buildSubmodules,
    buildDetached,

    exportSingle,
    exportNonExportable,
    exportInformal,
    exportWithReflector,
    exportToRoot,
    exportMixed,
    exportSecond,
    exportSubmodules,
    exportMultiple,
    exportImportMultiple,
    exportBroken,
    exportDoc,
    exportImport,
    exportBrokenNoreflector,
    exportWholeModule,
    importPathLocal,
    importLocalRepo,
    importOutWithDeletedSource,

    reflectNothingFromSubmodules,
    reflectGetPath,
    reflectSubdir,
    reflectSubmodulesWithBase,
    reflectComposite,
    reflectRemoteGit,
    reflectRemoteHttp,
    reflectWithOptions,
    reflectWithSelectorInDstFilter,
    reflectSubmodulesWithCriterion,
    reflectSubmodulesWithPluralCriterionManualExport,
    reflectSubmodulesWithPluralCriterionAutoExport,
    reflectInherit,
    reflectInheritSubmodules,
    // reflectComplexInherit, // xxx
    reflectorMasks,

    shellWithCriterion,
    shellVerbosity,

    functionStringsJoin,
    functionPlatform,
    fucntionThisCriterion,

    submodulesDownloadSingle,
    submodulesDownloadUpdate,
    submodulesDownloadUpdateDry,
    submodulesUpdate,
    submodulesUpdateSwitchBranch,
    stepSubmodulesDownload,
    upgradeDryDetached,
    upgradeDetached,
    fixateDryDetached,
    fixateDetached,
    
    execWillbe

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
