( function _WillExternals_test_s_( ) {

'use strict';

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
  self.assetDirPath = _.path.join( __dirname, 'asset' );
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
  debugger;
  _.assert( _.strHas( self.tempDir, '/dwtools/tmp.tmp' ) )
  _.fileProvider.filesDelete( self.tempDir );
}

/*

  .help - Get help.
  .list - List information about the current module.
  .paths.list - List paths of the current module.
  .submodules.list - List submodules of the current module.
  .reflectors.list - List avaialable reflectors.
  .steps.list - List avaialable steps.
  .builds.list - List avaialable builds.
  .exports.list - List avaialable exports.
  .about.list - List descriptive information about the module.
  .execution.list - List execution scenarios.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.upgrade - Upgrade each submodule, checking for available updates for such.
  .submodules.clean - Delete all downloaded submodules.
  .clean - Clean current module. Delete genrated artifacts, temp files and downloaded submodules.
  .clean.what - Find out which files will be deleted by clean command.
  .build - Build current module with spesified criterion.
  .export - Export selected the module with spesified criterion. Save output to output file and archive.
  .with - Use "with" to select a module.
  .each - Use "each" to iterate each module in a directory.

*/

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  test.case = 'simple run without args'

  shell()

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( got.output.length );
    return null;
  })

  return ready;
}

singleModuleSimplest.timeOut = 130000;

//

function singleModuleList( test )
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  shell({ args : [ '.list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = 'list';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `name : 'single'` ) );
    test.is( _.strHas( got.output, `description : 'Module for testing'` ) );
    test.is( _.strHas( got.output, `version : '0.0.1'` ) );
    return null;
  })

  /* - */

  shell({ args : [ '.paths.list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = 'module info'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `proto : './proto'` ) );
    test.is( _.strHas( got.output, `in : '.'` ) );
    test.is( _.strHas( got.output, `out : 'out'` ) );
    test.is( _.strHas( got.output, `out.debug : './out/debug'` ) ); debugger;
    test.is( _.strHas( got.output, `out.release : './out/release'` ) );
    return null;
  })


  shell({ args : [ '.submodules.list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = 'submodules list'
    test.identical( got.exitCode, 0 );
    test.is( got.output.length );
    return null;
  })

  /* - */

  shell({ args : [ '.reflectors.list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = 'reflectors.list'
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'reflector::reflect.proto.' ) );
    test.is( _.strHas( got.output, `. : '.'` ) );
    test.is( _.strHas( got.output, `prefixPath : 'out/release'` ) );
    test.is( _.strHas( got.output, `prefixPath : 'proto'` ) );

    test.is( _.strHas( got.output, `reflector::reflect.proto.debug` ) );
    test.is( _.strHas( got.output, `. : '.'` ) );
    test.is( _.strHas( got.output, `prefixPath : 'out/debug'` ) );
    test.is( _.strHas( got.output, `prefixPath : 'proto'` ) );

    return null;
  })

  /* - */

  shell({ args : [ '.steps.list' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( ( got ) =>
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

  .thenKeep( ( got ) =>
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

  .thenKeep( ( got ) =>
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

  shell({ args : [ '.execution.list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.execution.list'
    test.identical( got.exitCode, 0 );
    test.is( got.output.length );
    return null;
  })

  return ready;
}

singleModuleList.timeOut = 130000;

//

function singleModuleSubmodules( test )
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  shell({ args : [ '.submodules.download' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.submodules.download'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '0/0 submodule(s) of module::single were downloaded in' ) );
    return null;
  })

  /* - */

  shell({ args : [ '.submodules.download' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.submodules.download'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '0/0 submodule(s) of module::single were downloaded in' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )
    return null;
  })

  /* - */

  shell({ args : [ '.submodules.upgrade' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.submodules.upgrade'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '0/0 submodule(s) of module::single were upgraded in' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )
    return null;
  })

  /* - */

  shell({ args : [ '.submodules.clean' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.submodules.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted 0 file(s) in' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )
    return null;
  })

  return ready;

}

singleModuleSubmodules.timeOut = 130000;

//

function singleModuleClean( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'single' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  /* - */

  shell({ execPath : [ '.build', '.clean' ] })

  .thenKeep( ( got ) =>
  {
    debugger;
    test.case = '.clean '
    test.identical( got[ 0 ].exitCode, 0 );
    test.identical( got[ 1 ].exitCode, 0 );
    test.is( _.strHas( got[ 1 ].output, 'Clean deleted 0 file(s) in' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) )
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )
    return null;
  })

  /* - */

  shell({ execPath : [ '.build', '.clean.what' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.clean.what '
    test.identical( got[ 0 ].exitCode, 0 );
    test.identical( got[ 1 ].exitCode, 0 );
    test.is( _.strHas( got[ 1 ].output, 'Clean will delete 0 file(s)' ) );
    return null;
  })

  return ready;
}

singleModuleClean.timeOut = 130000;

//

function singleModuleBuild( test )
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready.thenKeep( () =>
  {
    test.case = '.build'
    _.fileProvider.filesDelete( outDebugPath );
    return null;
  })

  debugger;
  shell({ args : [ '.build' ] })

  .thenKeep( ( got ) =>
  {
    debugger;
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Building debug.raw' ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, 'Built debug.raw in' ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );

    return null;
  })

  /* - */

  .thenKeep( () =>
  {
    test.case = '.build debug.raw'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    _.fileProvider.filesDelete( outDebugPath );
    return null;
  })

  shell({ args : [ '.build debug.raw' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Building debug.raw' ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, 'Built debug.raw in' ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );

    return null;
  })

  /* - */

  .thenKeep( () =>
  {
    test.case = '.build release.raw'
    let outDebugPath = _.path.join( routinePath, 'out/release' );
    _.fileProvider.filesDelete( outDebugPath );
    return null;
  })

  shell({ args : [ '.build release.raw' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Building release.raw' ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, 'Built release.raw in' ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );

    return null;
  })

  /* - */

  .thenKeep( () =>
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
    .thenKeep( ( got ) =>
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

singleModuleBuild.timeOut = 130000;

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  shell({ args : [ '.with "single with space" .list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = 'module info'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `name : 'single with space'` ) );
    test.is( _.strHas( got.output, `description : 'Module for testing'` ) );
    test.is( _.strHas( got.output, `version : '0.0.1'` ) );
    return null;
  })

  return ready;
}

singleModuleWithSpaceTrivial.timeOut = 130000;

//

function singleStep( test )
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

  /* Vova : step::list.dir does not have {- stepRoutine -}. Failed to deduce it, try specifying "inherit" field explicitly */

  ready

  .thenKeep( () =>
  {
    test.case = '.build'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    let outPath = _.path.join( routinePath, 'out' );
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    return null;
  })

  return ready;
}

singleStep.timeOut = 30000;

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
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })
  _.fileProvider.filesDelete( outDebugPath );


  /* - */

  ready.thenKeep( () =>
  {
    test.case = '.export'
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.export' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, '+ Write out will-file' ) );
    test.is( _.strHas( got.output, 'Exported proto.export with 2 files in' ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );
    var files = self.find( outPath );
    test.identical( files, [ '.', './single.out.will.yml', './debug', './debug/Single.s' ] );

    test.is( _.fileProvider.fileExists( outWillPath ) )
    var outfile = _.fileProvider.fileConfigRead( outWillPath );

    let reflector = outfile.reflector[ 'exportedFiles.proto.export' ];
    let expectedFilePath =
    {
      '.' : null,
      'Single.s' : null
    }
    test.identical( reflector.src.basePath, '.' );
    test.identical( reflector.src.prefixPath, 'proto' );
    test.identical( reflector.src.filePath, expectedFilePath );

    return null;
  })

  /* - */

  .thenKeep( () =>
  {
    test.case = '.export.proto'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    let outPath = _.path.join( routinePath, 'out' );
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.export proto.export' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exporting proto.export' ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, 'Exported proto.export with 2 files' ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );
    var files = self.find( outPath );
    test.identical( files, [ '.', './single.out.will.yml', './debug', './debug/Single.s'  ] );

    test.is( _.fileProvider.fileExists( outWillPath ) )
    var outfile = _.fileProvider.fileConfigRead( outWillPath );

    let reflector = outfile.reflector[ 'exportedFiles.proto.export' ];
    let expectedFilePath =
    {
      '.' : null,
      'Single.s' : null
    }
    test.identical( reflector.src.basePath, '.' );
    test.identical( reflector.src.prefixPath, 'proto' );
    test.identical( reflector.src.filePath, expectedFilePath )

    return null;
  })

  return ready;
}

exportSingle.timeOut = 130000;

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })
  _.fileProvider.filesDelete( outDebugPath );

  /* - */

  ready.thenKeep( () =>
  {
    test.case = '.export'
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.export' ] })

  .thenKeep( ( got ) =>
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

exportWithReflector.timeOut = 130000;

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })


  /* - */

  shell({ args : [ '.export' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.export'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exporting proto.export' ) );
    test.is( _.strHas( got.output, '+ Write out will-file' ) );
    test.is( _.strHas( got.output, 'Exported proto.export with 2 files in' ) );

    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'export-to-root.out.will.yml' ) ) )

    return null;
  })

  return ready;
}

exportToRoot.timeOut = 130000;

//

function submodulesInfo( test )
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  shell({ args : [ '.list' ] })

  .thenKeep( ( got ) =>
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

submodulesInfo.timeOut = 200000;

//

function submodulesList( test )
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  shell({ args : [ '.submodules.list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = 'submodules list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'submodule::Tools' ) );
    test.is( _.strHas( got.output, 'submodule::PathFundamentals' ) );
    return null;
  })

  /* - */

  shell({ args : [ '.reflectors.list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = 'reflectors.list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflector::reflect.proto.' ))
    test.is( _.strHas( got.output, `reflector::reflect.proto.debug` ))
    return null;
  })

  /* - */

  shell({ args : [ '.steps.list' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( ( got ) =>
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

  .thenKeep( ( got ) =>
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

  .thenKeep( ( got ) =>
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

  /* - */

  shell({ args : [ '.execution.list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.execution.list'
    test.identical( got.exitCode, 0 );
    test.is( got.output.length );
    return null;
  })

  return ready;
}

submodulesList.timeOut = 130000;

//

function submodulesDownloadUpgrade( test )
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

  .thenKeep( () =>
  {
    test.case = '.submodules.download - first time';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  shell({ args : [ '.submodules.download' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '2/2 submodule(s) of module::submodules were downloaded in' ) );

    var files = self.find( submodulesPath );

    test.is( files.length > 30 );

    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'Tools' ) ) )
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'PathFundamentals' ) ) )
    return null;
  })

  // /* */
  //
  // .thenKeep( () =>
  // {
  //   test.case = '.submodules.download - again';
  //   return null;
  // })
  // shell({ args : [ '.submodules.download' ] })
  // .thenKeep( ( got ) =>
  // {
  //
  //   test.identical( got.exitCode, 0 );
  //   test.is( _.strHas( got.output, '0/2 submodule(s) of module::submodules were downloaded in' ) );
  //   test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'Tools' ) ) )
  //   test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'PathFundamentals' ) ) )
  //   test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) )
  //
  //   var files = self.find( _.path.join( submodulesPath, 'Tools' ) );
  //   test.is( files.length > 3 );
  //
  //   var files = self.find( _.path.join( submodulesPath, 'PathFundamentals' ) );
  //   test.is( files.length > 3 );
  //
  //   return null;
  // })

  /* */

  .thenKeep( () =>
  {
    test.case = '.submodules.upgrade - first time';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })
  shell({ args : [ '.submodules.upgrade' ] })
  .thenKeep( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '2/2 submodule(s) of module::submodules were upgraded in' ) );
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

  .thenKeep( () =>
  {
    test.case = '.submodules.upgrade - again';
    return null;
  })
  shell({ args : [ '.submodules.upgrade' ] })
  .thenKeep( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '0/2 submodule(s) of module::submodules were upgraded in' ) );
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
  .thenKeep( () =>
  {
    test.case = '.submodules.clean';
    files = self.find( submodulesPath );
    return files;
  })

  shell({ args : [ '.submodules.clean' ] })
  .thenKeep( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `${files.length}` ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* xxx : phantom problem ? */

    return null;
  })

  /* */

  return ready;
}

submodulesDownloadUpgrade.timeOut = 300000;

//

function submodulesBuild( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  let ready = new _.Consequence().take( null );
  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  ready

  /* - */

  .thenKeep( () =>
  {
    test.case = 'build withoud submodules'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    _.fileProvider.filesDelete( outDebugPath );
    return null;
  })

  shell({ args : [ '.build' ] })
  .finally( ( err, got ) =>
  {
    test.is( !err );
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    var files = _.fileProvider.dirRead( outDebugPath );
    test.identical( files.length, 2 );
    debugger;
    return null;
  })

  /* - */

  shell({ args : [ '.submodules.upgrade' ] })
  .thenKeep( () =>
  {
    test.case = '.build'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    _.fileProvider.filesDelete( outDebugPath );
    return null;
  })

  shell({ args : [ '.build' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'Building debug.raw' ) );
    test.is( _.strHas( got.output, 'Built debug.raw in' ) );

    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    var files = self.find( outDebugPath );

    test.is( files.length > 10 );

    return null;
  })

  /* - */

  .thenKeep( () =>
  {
    test.case = '.build wrong'
    let buildOutDebugPath = _.path.join( routinePath, 'out/debug' );
    let buildOutReleasePath = _.path.join( routinePath, 'out/release' );
    _.fileProvider.filesDelete( buildOutDebugPath );
    _.fileProvider.filesDelete( buildOutReleasePath );
    return null;
  })

  .thenKeep( () =>
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
    .thenKeep( ( got ) =>
    {
      test.is( o.exitCode !== 0 );
      test.is( o.output.length );
      test.is( !_.fileProvider.fileExists( buildOutDebugPath ) )
      test.is( !_.fileProvider.fileExists( buildOutReleasePath ) )

      return null;
    })

  });

  return ready;
}

submodulesBuild.timeOut = 130000;

//

function submodulesExport( test )
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready

  .thenKeep( () =>
  {
    test.case = '.export'
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  return shell({ args : [ '.export' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exporting proto.export' ) );

    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/debug/dwtools/abase/l0/aPredefined.s' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/debug/dwtools/abase/l3/Path.s' ) ) );

    var files = self.find( outDebugPath );
    test.is( files.length > 60 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  return ready;
}

submodulesExport.timeOut = 130000;

//

function submodulesDownload( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodule-download' );
  let routinePath = _.path.join( self.tempDir, test.name );

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })
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

  .thenKeep( ( got ) =>
  {
    test.case = 'simple run without args'
    test.identical( got.exitCode, 0 );
    test.is( got.output.length );
    return null;
  })

  /* - */

  shell({ args : [ '.list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = 'list'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `git+https:///github.com/Wandalen/wTools.git/out/wTools#master` ) );
    return null;
  })

  /* - */

  .thenKeep( () =>
  {
    test.case = 'build'
    _.fileProvider.filesDelete( _.path.join( routinePath, '.module' ) );
    _.fileProvider.filesDelete( _.path.join( routinePath, 'out/debug' ) );
    return null;
  })

  shell({ args : [ '.build' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.gt( _.fileProvider.dirRead( _.path.join( routinePath, '.module/Tools' ) ).length, 0 );
    test.gt( _.fileProvider.dirRead( _.path.join( routinePath, 'out/debug' ) ).length, 0 );
    return null;
  })

  /* - */

  .thenKeep( () =>
  {
    test.case = 'export'
    _.fileProvider.filesDelete( _.path.join( routinePath, '.module' ) );
    _.fileProvider.filesDelete( _.path.join( routinePath, 'out/debug' ) );
    _.fileProvider.filesDelete( _.path.join( routinePath, 'out/Download.out.will.yml' ) );
    return null;
  })

  shell({ args : [ '.export' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.gt( _.fileProvider.dirRead( _.path.join( routinePath, '.module/Tools' ) ).length, 0 );
    test.gt( _.fileProvider.dirRead( _.path.join( routinePath, 'out/debug' ) ).length, 0 );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/Download.out.will.yml' ) ) );
    return null;
  })

  /* - */

  return ready;
}

submodulesDownload.timeOut = 130000;

//

function submodulesBrokenClean1( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-broken-1' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let outDebugPath = _.path.join( routinePath, 'out/debug' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  test.description = 'should handle currputed will-file properly';

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

  .thenKeep( ( got ) =>
  {
    test.case = '.clean ';

    var files = self.find( submodulesPath );
    test.identical( files.length, 4 );

    return null;
  })

  /* - */

  shell({ args : [ '.clean.what' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.clean.what';

    var files = self.find( submodulesPath );

    test.identical( files.length, 4 );

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, String( files.length ) + ' at ' ) );
    test.is( _.strHas( got.output, 'Clean will delete ' + String( files.length ) + ' file(s) in total, found in ' ) );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) );

    return null;
  })

  /* - */

  shell({ args : [ '.clean' ] })

  .thenKeep( ( got ) =>
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
  .thenKeep( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exporting proto.export' ) );

    var files = self.find( outDebugPath );
    test.is( files.length > 10 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  ready
  .thenKeep( ( got ) =>
  {

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  });

  /* */

  shell({ args : [ '.export' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exporting proto.export' ) );

    var files = self.find( outDebugPath );
    test.is( files.length > 10 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  return ready;
}

submodulesBrokenClean1.timeOut = 130000;

//

function submodulesBrokenClean2( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-broken-2' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let outDebugPath = _.path.join( routinePath, 'out/debug' );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );

  test.description = 'should handle currputed will-file properly';

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

  .thenKeep( ( got ) =>
  {
    test.case = '.clean ';

    var files = self.find( submodulesPath );

    test.identical( files.length, 4 );

    return null;
  })

  /* - */

  shell({ args : [ '.clean.what' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.clean.what';

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

  .thenKeep( ( got ) =>
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
  .thenKeep( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exporting proto.export' ) );

    var files = self.find( outDebugPath );
    test.is( files.length > 10 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  ready
  .thenKeep( ( got ) =>
  {

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  });

  /* */

  shell({ args : [ '.export' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.export';

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exporting proto.export' ) );

    var files = self.find( outDebugPath );
    test.is( files.length > 10 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'submodules.out.will.yml' ] );

    return null;
  })

  /* - */

  return ready;
}

submodulesBrokenClean2.timeOut = 130000;

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
    execPath : 'node ' + execPath + ' .with NoTemp',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  /* - */

  shell
  ({
    args : [ '.build' ]
  })

  var files;
  ready
  .thenKeep( () =>
  {
    files = self.find( submodulesPath );
    debugger;
    test.is( files.length > 50 );
    return files;
  })

  shell({ args : [ '.clean' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted ' + files.length + ' file(s)' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* xxx : phantom problem ? */
    return null;
  })

  shell({ args : [ '.clean -- second' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    return null;
  })

  /* - */

  var files = [];
  ready
  .thenKeep( () =>
  {
    _.fileProvider.filesDelete( outPath );
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  shell({ args : [ '.clean' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted ' + 0 + ' file(s)' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* xxx : phantom problem ? */
    return null;
  })

  shell({ args : [ '.clean -- second' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    return null;
  })

  /* - */

  return ready;
}

clean.timeOut = 130000;

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
  .thenKeep( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted ' + 0 + ' file(s)' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* xxx : phantom problem ? */
    return null;
  })

  shell({ args : [ '.clean -- second' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    return null;
  })

  /* - */

  return ready;
}

cleanNoBuild.timeOut = 130000;

//

function cleanWhat( test )
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
    args : [ '.submodules.upgrade' ],
  })

  .thenKeep( ( got ) =>
  {
    test.is( _.strHas( got.output, '2/2 submodule(s) of module::submodules were upgraded in' ) );
    var files = self.find( submodulesPath );
    test.is( files.length > 100 );
    return null;
  })

  shell
  ({
    args : [ '.build' ],
  })
  .thenKeep( ( got ) =>
  {
    test.is( _.strHas( got.output, '0/2 submodule(s) of module::submodules were downloaded in' ) );
    return got;
  })

  var wasFiles;

  shell({ args : [ '.clean.what' ] })

  .thenKeep( ( got ) =>
  {
    test.case = '.clean.what';

    debugger;
    var files = self.find( outPath );
    test.is( files.length > 25 );
    var files = wasFiles = self.find( submodulesPath );
    test.is( files.length > 100 );
    debugger;

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, String( files.length ) + ' at ' ) );
    test.is( _.strHas( got.output, 'Clean will delete ' + String( files.length ) + ' file(s) in total, found in' ) );
    test.is( _.fileProvider.isDir( _.path.join( routinePath, '.module' ) ) ); /* xxx : phantom problem ? */
    test.is( _.fileProvider.isDir( _.path.join( routinePath, 'out' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) );

    return null;
  })

  /* - */

  return ready;
}

cleanWhat.timeOut = 130000;

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

  shell({ args : [ '.submodules.upgrade' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.submodules.upgrade'
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
  .thenKeep( () =>
  {
    files = self.find( submodulesPath );
    return null;
  })

  /* */

  shell({ args : [ '.submodules.clean' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.submodules.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `${files.length}` ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* xxx : phantom problem ? */
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'modules' ) ) );
    return null;
  })

  /* - */

  return ready;
}

cleanSubmodules.timeOut = 130000;

//

function multipleExports( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports' );
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
  .thenKeep( ( got ) =>
  {
    test.case = '.export debug:1';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( outPath );

    return null;
  })

  shell({ args : [ '.export debug:1' ] })

  .thenKeep( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js' ] );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'Exported export.debug with 2 files in' ) );
    test.is( _.strHas( got.output, 'Read 2 will-files in' ) );
    test.is( _.strHas( got.output, 'Exported export.debug in' ) );
    test.is( _.strHas( got.output, 'Write out archive' ) );
    test.is( _.strHas( got.output, 'Write out will-file' ) );
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
        exportedFilesReflector : 'reflector::exportedFiles.export.debug',
        exportedDirPath : 'path::exportedDir.export.debug',
        exportedFilesPath : 'path::exportedFiles.export.debug',
        archiveFilePath : 'path::archiveFile.export.debug'
      }
    }

    test.identical( outfile.exported, exported );

    var exportedReflector =
    {
      src : { filePath : { '.' : null }, prefixPath : 'out/debug' },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }
    debugger;
    test.identical( outfile.reflector[ 'exported.export.debug' ], exportedReflector );
    debugger;

    var exportedReflectorFiles =
    {
      recursive : 0,
      src :
      {
        filePath : { '.' : null, 'File.debug.js' : null },
        basePath : '.',
        prefixPath : 'out/debug'
      },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }

    test.identical( outfile.reflector[ 'exportedFiles.export.debug' ], exportedReflectorFiles );

    let outfilePath =
    {
      proto : { path : './proto' },
      temp : { path : 'out' },
      in : { path : '..' },
      out : { path : 'out' },
      'out.debug' :
      {
        path : './out/debug',
        criterion : { debug : 1 }
      },
      'out.release' :
      {
        path : './out/release',
        criterion : { debug : 0 }
      },
      'exportedDir.export.debug' :
      {
        path : './out/debug',
        criterion :
        {
          default : 1,
          debug : 1,
          raw : 1,
          export : 1
        }
      },
      'exportedFiles.export.debug' :
      {
        path : [ 'out/debug', 'out/debug/File.debug.js' ],
        criterion :
        {
          default : 1,
          debug : 1,
          raw : 1,
          export : 1
        }
      },
      'archiveFile.export.debug' :
      {
        path : './out/submodule.debug.out.tgs',
        criterion :
        {
          default : 1,
          debug : 1,
          raw : 1,
          export : 1
        }
      }
    }

    test.identical( outfile.path, outfilePath );

    return null;
  })

  /* - */

  ready
  .thenKeep( ( got ) =>
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

  .thenKeep( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'Exported export. with 2 files in' ) );
    test.is( _.strHas( got.output, 'Read 2 will-files in' ) );
    test.is( _.strHas( got.output, 'Exported export. in' ) );
    test.is( _.strHas( got.output, 'Write out archive' ) );
    test.is( _.strHas( got.output, 'Write out will-file' ) );
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
        exportedFilesReflector : 'reflector::exportedFiles.export.debug',
        exportedDirPath : 'path::exportedDir.export.debug',
        exportedFilesPath : 'path::exportedFiles.export.debug',
        archiveFilePath : 'path::archiveFile.export.debug'
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
        exportedFilesReflector : 'reflector::exportedFiles.export.',
        exportedDirPath : 'path::exportedDir.export.',
        exportedFilesPath : 'path::exportedFiles.export.',
        archiveFilePath : 'path::archiveFile.export.'
      },
    }

    test.identical( outfile.exported, exported );

    var exportedReflector =
    {
      src : { filePath : { '.' : null }, prefixPath : 'out/debug' },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }
    test.identical( outfile.reflector[ 'exported.export.debug' ], exportedReflector );

    var exportedReflector =
    {
      src : { filePath : { '.' : null }, prefixPath : 'out/release' },
      criterion :
      {
        default : 1,
        debug : 0,
        raw : 1,
        export : 1
      }
    }
    test.identical( outfile.reflector[ 'exported.export.' ], exportedReflector );

    var exportedReflectorFiles =
    {
      recursive : 0,
      src :
      {
        filePath : { '.' : null, 'File.debug.js' : null },
        basePath : '.',
        prefixPath : 'out/debug'
      },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }

    test.identical( outfile.reflector[ 'exportedFiles.export.debug' ], exportedReflectorFiles );

    var exportedReflectorFiles =
    {
      recursive : 0,
      src :
      {
        filePath : { '.' : null, 'File.release.js' : null },
        basePath : '.',
        prefixPath : 'out/release'
      },
      criterion :
      {
        default : 1,
        debug : 0,
        raw : 1,
        export : 1
      }
    }

    test.identical( outfile.reflector[ 'exportedFiles.export.' ], exportedReflectorFiles );

    let outfilePath =
    {
      proto : { path : './proto' },
      temp : { path : 'out' },
      in : { path : '..' },
      out : { path : 'out' },
      'out.debug' :
      {
        path : './out/debug',
        criterion : { debug : 1 }
      },
      'out.release' :
      {
        path : './out/release',
        criterion : { debug : 0 }
      },
      'exportedDir.export.debug' :
      {
        path : './out/debug',
        criterion :
        {
          default : 1,
          debug : 1,
          raw : 1,
          export : 1
        }
      },
      'exportedFiles.export.debug' :
      {
        path : [ 'out/debug', 'out/debug/File.debug.js' ],
        criterion :
        {
          default : 1,
          debug : 1,
          raw : 1,
          export : 1
        }
      },
      'archiveFile.export.debug' :
      {
        path : './out/submodule.debug.out.tgs',
        criterion :
        {
          default : 1,
          debug : 1,
          raw : 1,
          export : 1
        }
      },
      'exportedDir.export.' :
      {
        path : './out/release',
        criterion :
        {
          default : 1,
          debug : 0,
          raw : 1,
          export : 1
        }
      },
      'exportedFiles.export.' :
      {
        path : [ 'out/release', 'out/release/File.release.js' ],
        criterion :
        {
          default : 1,
          debug : 0,
          raw : 1,
          export : 1
        }
      },
      'archiveFile.export.' :
      {
        path : './out/submodule.out.tgs',
        criterion :
        {
          default : 1,
          debug : 0,
          raw : 1,
          export : 1
        }
      }
    }

    test.identical( outfile.path, outfilePath );

    return null;
  })

  /* - */

  return ready;
}

multipleExports.timeOut = 130000;

//

function multipleExportsImport( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports' );
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
  .thenKeep( ( got ) =>
  {
    test.case = 'export submodule';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( outPath );

    return null;
  })

  shell({ args : [ '.with . .export debug:0' ] })
  shell({ args : [ '.with . .export debug:1' ] })

  .thenKeep( ( got ) =>
  {

    var files = self.find( outPath );
    test.identical( files, [ '.', './submodule.debug.out.tgs', './submodule.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exported export.debug with 2 files in' ) );

    return null;
  })

  /* - */

  ready
  .thenKeep( ( got ) =>
  {
    test.case = '.with super .export debug:0';

    _.fileProvider.filesDelete( out2Path );

    return null;
  })

  shell({ args : [ '.with super .export debug:0' ] })

  .thenKeep( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [ '.', './super.out.tgs', './super.out.will.yml', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exported export. with 2 files in' ) );

    return null;
  })

  /* - */

  ready
  .thenKeep( ( got ) =>
  {
    test.case = '.with super .clean.what';
    return null;
  })

  shell({ args : [ '.with super .clean.what' ] })

  .thenKeep( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [ '.', './super.out.tgs', './super.out.will.yml', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '5 at ' ) );
    test.is( _.strHas( got.output, 'Clean will delete 5 file(s) in total, found in' ) );

    return null;
  })

  /* - */

  ready
  .thenKeep( ( got ) =>
  {
    test.case = '.with super .clean';
    return null;
  })

  shell({ args : [ '.with super .clean' ] })

  .thenKeep( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted 5 file(s) in' ) );

    return null;
  })

  /* - */

  ready
  .thenKeep( ( got ) =>
  {
    test.case = '.with super .export debug:0 ; .with super .export debug:1';

    _.fileProvider.filesDelete( out2Path );

    return null;
  })

  shell({ args : [ '.with super .export debug:0' ] })
  shell({ args : [ '.with super .export debug:1' ] })

  .thenKeep( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [ '.', './super.debug.out.tgs', './super.out.tgs', './super.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Exported export.debug with 2 files in' ) );

    debugger;
    return null;
  })

  /* - */

  ready
  .thenKeep( ( got ) =>
  {
    test.case = '.with super .clean.what';
    return null;
  })

  shell({ args : [ '.with super .clean.what' ] })

  .thenKeep( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [ '.', './super.debug.out.tgs', './super.out.tgs', './super.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '8 at ' ) );
    test.is( _.strHas( got.output, 'Clean will delete 8 file(s) in total, found in' ) );

    return null;
  })

  /* - */

  ready
  .thenKeep( ( got ) =>
  {
    test.case = '.with super .clean';
    return null;
  })

  shell({ args : [ '.with super .clean' ] })

  .thenKeep( ( got ) =>
  {

    var files = self.find( out2Path );
    test.identical( files, [] );
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted 8 file(s) in' ) );

    return null;
  })

  /* - */

  return ready;
}

multipleExportsImport.timeOut = 130000;

//

function multipleExportsBroken( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports-broken' );
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
  .thenKeep( ( got ) =>
  {
    test.case = '.export debug:1';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  })

  debugger;
  shell({ args : [ '.export debug:1' ] })

  .thenKeep( ( got ) =>
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
        exportedFilesReflector : 'reflector::exportedFiles.export.debug',
        exportedDirPath : 'path::exportedDir.export.debug',
        exportedFilesPath : 'path::exportedFiles.export.debug',
        archiveFilePath : 'path::archiveFile.export.debug'
      }
    }

    test.identical( outfile.exported, exported );

    var exportedReflector =
    {
      src : { filePath : { '.' : null }, prefixPath : 'out/debug' },
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
      src :
      {
        filePath : { '.' : null, 'File.debug.js' : null },
        basePath : '.',
        prefixPath : 'out/debug'
      },
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }

    test.identical( outfile.reflector[ 'exportedFiles.export.debug' ], exportedReflectorFiles );

    return null;
  })

  return ready;
}

multipleExportsBroken.timeOut = 30000;

//

function multipleExportsDoc( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports-doc' );
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
  .thenKeep( ( got ) =>
  {
    test.case = 'export submodule';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( subOutPath );
    _.fileProvider.filesDelete( supOutPath );

    return null;
  })

  /* qqq : replace args -> path, maybe */

  shell({ args : [ '.with . .export export.doc' ] })
  shell({ args : [ '.with . .export export.debug' ] })
  shell({ args : [ '.with . .export export.' ] })
  shell({ args : [ '.with doc .build doc:1' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = self.find( subOutPath );
    test.identical( files, [ '.', './submodule.default-debug-raw.out.tgs', './submodule.default-raw.out.tgs', './submodule.out.will.yml', './debug', './debug/File.debug.js', './release', './release/File.release.js' ] );

    debugger;
    var files = self.find( supOutPath );
    test.identical( files, [ '.', './file.md' ] );
    debugger;

    return null;
  })

  return ready;
}

multipleExportsDoc.timeOut = 130000;

//

function importInExport( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'import-in' );
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready

  .thenKeep( () =>
  {
    test.case = '.export'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.export debug:0' ] })
  shell({ args : [ '.export debug:1' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var files = _.fileProvider.dirRead( outPath );
    test.identical( files, [ 'debug', 'release', 'submodule.debug.out.tgs', 'submodule.out.tgs', 'submodule.out.will.yml' ] );

    return null;
  })

  return ready;
}

importInExport.timeOut = 130000;

// //
//
// function reflectSubmoduleNone( test )
// {
//   let self = this;
//   let originalDirPath = _.path.join( self.assetDirPath, 'reflect-submodules-none' );
//   let routinePath = _.path.join( self.tempDir, test.name );
//   let submodulesPath = _.path.join( routinePath, 'module' );
//   let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
//   let outPath = _.path.join( routinePath, 'out' );
//   let ready = new _.Consequence().take( null )
//
//   let shell = _.sheller
//   ({
//     execPath : 'node ' + execPath,
//     currentPath : routinePath,
//     outputCollecting : 1,
//     ready : ready
//   })
//
//   _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })
//
//   /* - */
//
//   ready.thenKeep( () =>
//   {
//     test.case = '.build'
//     _.fileProvider.filesDelete( outPath );
//     return null;
//   })
//
//   shell({ args : [ '.build' ] })
//
//   .thenKeep( ( got ) =>
//   {
//     test.identical( got.exitCode, 0 );
//     var files = self.find( outPath );
//     test.identical( files, [ '.', './debug', './debug/File.js' ] );
//
//     return null;
//   })
//
//   return ready;
// }
//
// reflectSubmoduleNone.timeOut = 130000;

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })
  _.fileProvider.filesDelete( outDebugPath );


  /* - */

  ready.thenKeep( () =>
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

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, '+ Write out will-file' ) );
    test.is( _.strHas( got.output, 'Exported proto.export with 2 files in' ) );

    var files = self.find( outDebugPath );
    test.identical( files, [ '.', './Single.s' ] );
    var files = self.find( outPath );
    test.identical( files, [ '.', './reflect-nothing-from-submodules.out.will.yml', './debug', './debug/Single.s' ] );

    test.is( _.fileProvider.fileExists( outWillPath ) )
    var outfile = _.fileProvider.fileConfigRead( outWillPath );

    var reflector = outfile.reflector[ 'exportedFiles.proto.export' ];
    var expectedFilePath =
    {
      '.' : null,
      'Single.s' : null
    }
    test.identical( reflector.src.basePath, '.' );
    test.identical( reflector.src.prefixPath, 'proto' );
    test.identical( reflector.src.filePath, expectedFilePath );

    var expectedReflector =
    {
      'reflect.proto' :
      {
        src :
        {
          filePath : { '.' : '.' },
          prefixPath : 'proto',
          maskAll :
          {
            excludeAny :
            [
              /(\W|^)node_modules(\W|$)/,
              /\.unique$/,
              /\.git$/,
              /\.svn$/,
              /\.hg$/,
              /\.DS_Store$/,
              /(^|\/)-/,
              /\.release($|\.|\/)/i,
              /\.debug($|\.|\/)/i,
              /\.test($|\.|\/)/i,
              /\.experiment($|\.|\/)/i
            ]
          }
        },
        dst : { prefixPath : 'out/debug' },
        criterion : { debug : 1 },
        inherit : [ 'predefined.*' ]
      },
      'reflect.submodules1' :
      {
        dst : { filePath : '.', basePath : '.', prefixPath : 'out/debug' },
        criterion : { debug : 1 },
        inherit :
        [
          'submodule::*/exported::*=1/reflector::exportedFiles*=1'
        ]
      },
      'reflect.submodules2' :
      {
        src :
        {
          maskAll :
          {
            excludeAny :
            [
              /(\W|^)node_modules(\W|$)/,
              /\.unique$/,
              /\.git$/,
              /\.svn$/,
              /\.hg$/,
              /\.DS_Store$/,
              /(^|\/)-/,
              /\.release($|\.|\/)/i
            ]
          }
        },
        criterion : { debug : 1 },
        inherit : [ 'predefined.*' ]
      },
      'exported.proto.export' :
      {
        src :
        {
          filePath : { '.' : null },
          prefixPath : 'proto'
        },
        criterion : { default : 1, export : 1 }
      },
      'exportedFiles.proto.export' :
      {
        recursive : 0,
        src :
        {
          filePath : { '.' : null, 'Single.s' : null },
          basePath : '.',
          prefixPath : 'proto'
        },
        criterion : { default : 1, export : 1 }
      }
    }
    test.identical( outfile.reflector, expectedReflector );
    debugger;

    return null;
  })

  return ready;
}

reflectNothingFromSubmodules.timeOut = 130000;

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready.thenKeep( () =>
  {
    test.case = '.build debug1'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug1' ] })
  .thenKeep( ( arg ) => validate( arg ) )

  /* - */

  ready.thenKeep( () =>
  {
    test.case = '.build debug2'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug2' ] })
  .thenKeep( ( arg ) => validate( arg ) )

  /* - */

  ready.thenKeep( () =>
  {
    test.case = '.build debug3'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug3' ] })
  .thenKeep( ( arg ) => validate( arg ) )

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
      './debug/dwtools/abase/l4',
      './debug/dwtools/abase/l4/Paths.s',
      './debug/dwtools/abase/l7',
      './debug/dwtools/abase/l7/Glob.s'
    ]

    var files = self.find( outPath );
    test.is( files.length > 10 );
    test.identical( files, expected );

    return null;
  }
}

reflectGetPath.timeOut = 130000;

//

function reflectSubdir( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-subdir' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = 'setup'
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })
    return null;
  })
  shell({ args : [ '.each module .export' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'submodule.out.will.yml' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'out' ) ) );
    return null;
  })

  /* */

  .thenKeep( () =>
  {
    test.case = '.build variant:0'
    _.fileProvider.filesDelete( outPath );
    return null;
  });
  shell({ args : [ '.build variant:0' ] })
  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.build variant:1'
    _.fileProvider.filesDelete( outPath );
    return null;
  });
  shell({ args : [ '.build variant:1' ] })
  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.build variant:2'
    _.fileProvider.filesDelete( outPath );
    return null;
  });
  shell({ args : [ '.build variant:2' ] })
  .thenKeep( ( got ) =>
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

reflectSubdir.timeOut = 130000;

//

function reflectSubmodulesWithBase( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-submodules-with-base' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let outPath = _.path.join( routinePath, 'out' );
  let submodule1OutFilePath = _.path.join( routinePath, 'submodule1.out.will.yml' );
  let submodule2OutFilePath = _.path.join( routinePath, 'submodule1.out.will.yml' );
  let ready = new _.Consequence().take( null )

  let shell = _.sheller
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  })

  ready
  .thenKeep( () =>
  {
    test.case = 'setup'
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })
    return null;
  })

  /* */

  shell({ args : [ '.each module .export' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.isTerminal( submodule1OutFilePath ) );
    test.is( _.fileProvider.isTerminal( submodule2OutFilePath ) );
    return got;
  })

  /* */

  ready.thenKeep( () =>
  {
    test.case = 'variant 0, src basePath : ../..'
    _.fileProvider.filesDelete( outPath )
    return null;
  });

  shell({ args : [ '.build variant:0' ] })

  .thenKeep( ( got ) =>
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

  ready.thenKeep( () =>
  {
    test.case = 'variant 1, src basePath : "{submodule::*/exported::*=1/path::exportedDir*=1}/../.."'
    _.fileProvider.filesDelete( outPath )
    return null;
  });

  shell({ args : [ '.build variant:1' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    var expected =
    [ '.', './debug', './debug/proto', './debug/proto/File1.s', './debug/proto/File2.s' ]

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* */

  ready.thenKeep( () =>
  {
    test.case = '.build out* variant:0'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:0' ] })
  .thenKeep( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.thenKeep( () =>
  {
    test.case = '.build out* variant:1'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:1' ] })
  .thenKeep( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.thenKeep( () =>
  {
    test.case = '.build out* variant:2'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:2' ] })
  .thenKeep( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.thenKeep( () =>
  {
    test.case = '.build out* variant:3'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:3' ] })
  .thenKeep( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.thenKeep( () =>
  {
    test.case = '.build out* variant:4'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:4' ] })
  .thenKeep( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.js', './debug/dir1/File.test.js', './debug/dir1/File1.debug.js', './debug/dir1/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.thenKeep( () =>
  {
    test.case = '.build out* variant:5'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:5' ] })
  .thenKeep( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.js', './debug/dir1/File.test.js', './debug/dir1/File1.debug.js', './debug/dir1/File2.debug.js' ];
    var files = self.find( outPath );
    test.is( files.length > 5 );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.thenKeep( () =>
  {
    test.case = '.build out* variant:6'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:6' ] })
  .thenKeep( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.test.js' ];
    var files = self.find( outPath );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  /* */

  ready.thenKeep( () =>
  {
    test.case = '.build out* variant:7'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build out* variant:7' ] })
  .thenKeep( ( arg ) =>
  {
    var expected = [ '.', './debug', './debug/dir1', './debug/dir1/File.test.js' ];
    var files = self.find( outPath );
    test.identical( files, expected );
    test.identical( arg.exitCode, 0 );
    return null;
  })

  return ready;
}

reflectComposite.timeOut = 130000;

//

function reflectRemote( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'reflect-remote' );
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

  ready.thenKeep( () =>
  {
    test.case = '.build download.* variant:1'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:1' ] })
  .thenKeep( ( arg ) => validate1( arg ) )

  //

  .thenKeep( () =>
  {
    test.case = '.build download.* variant:2'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:2' ] })
  .thenKeep( ( arg ) => validate1( arg ) )

  //

  .thenKeep( () =>
  {
    test.case = '.build download.* variant:3'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:3' ] })
  .thenKeep( ( arg ) => validate1( arg ) )

  //

  .thenKeep( () =>
  {
    test.case = '.build download.* variant:4'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:4' ] })
  .thenKeep( ( arg ) => validate1( arg ) )

  //

  .thenKeep( () =>
  {
    test.case = '.build download.* variant:5'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:5' ] })
  .thenKeep( ( arg ) => validate1( arg ) )

  //

  .thenKeep( () =>
  {
    test.case = '.build download.* variant:6'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:6' ] })
  .thenKeep( ( arg ) => validate1( arg ) )

  //

  .thenKeep( () =>
  {
    test.case = '.build download.* variant:7'
    _.fileProvider.filesDelete( local1Path );
    return null;
  })

  shell({ args : [ '.build download.* variant:7' ] })
  .thenKeep( ( arg ) => validate2( arg ) )

  //

  .thenKeep( () =>
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
    test.identical( files.length, 92 );
    return null;
  }

  /* */

  function validate2( arg )
  {
    test.identical( arg.exitCode, 0 );

    var files = self.find( local1Path );
    test.identical( files.length, 92 );
    var files = self.find( local2Path );
    test.identical( files.length, 72 );
    var files = self.find( local3Path );
    test.identical( files.length, 77 );

    return null;
  }

}

reflectRemote.timeOut = 130000;

//

function helpCommand( test )
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
  .thenKeep( ( arg ) =>
  {
    test.identical( arg.exitCode, 0 );
    test.ge( _.strLinesCount( arg.output ), 24 );
    return arg;
  })

  //

  shell({ args : [ '.' ] })
  .thenKeep( ( arg ) =>
  {
    test.identical( arg.exitCode, 0 );
    test.ge( _.strLinesCount( arg.output ), 24 );
    return arg;
  })

  //

  shell({ args : [] })
  .thenKeep( ( arg ) =>
  {
    test.identical( arg.exitCode, 0 );
    test.ge( _.strLinesCount( arg.output ), 24 );
    return arg;
  })

  return ready;
}

//

var Self =
{

  name : 'Tools/atop/WillExternals',
  silencing : 1,

  onSuiteBegin : onSuiteBegin,
  onSuiteEnd : onSuiteEnd,
  routineTimeOut : 30000,

  context :
  {
    tempDir : null,
    assetDirPath : null,
    find : null,
  },

  tests :
  {

    singleModuleSimplest,
    singleModuleList,
    singleModuleSubmodules,
    singleModuleClean,
    singleModuleBuild,
    singleModuleWithSpaceTrivial,

    exportSingle,
    exportWithReflector,
    exportToRoot,

    singleStep,

    submodulesInfo,
    submodulesList,
    submodulesDownloadUpgrade,
    submodulesBuild,
    submodulesExport,
    submodulesDownload,
    submodulesBrokenClean1,
    submodulesBrokenClean2,

    clean,
    cleanNoBuild,
    cleanWhat,
    cleanSubmodules,

    multipleExports,
    multipleExportsImport,
    multipleExportsBroken,
    multipleExportsDoc,

    importInExport,

    reflectNothingFromSubmodules,
    reflectGetPath,
    reflectSubdir,
    reflectSubmodulesWithBase,
    reflectComposite,
    reflectRemote,

    helpCommand

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
