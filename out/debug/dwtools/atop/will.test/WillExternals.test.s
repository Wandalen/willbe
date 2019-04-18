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
  // debugger;
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
  .submodules.update - Upgrade each submodule, checking for available updates for such.
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

  shell({ args : [ '.resources.list' ] })
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

  shell({ args : [ '.paths.list' ] })
  .thenKeep( ( got ) =>
  {
    test.case = 'module info'
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, `proto : './proto'` ) );
    test.is( _.strHas( got.output, `in : '.'` ) );
    test.is( _.strHas( got.output, `out : 'out'` ) );
    test.is( _.strHas( got.output, `out.debug : './out/debug'` ) );
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

  /* - */ /* To test output by command with glob and criterion args*/

  shell({ args : [ '.resources.list *a* predefined:0' ] })
  .thenKeep( ( got ) =>
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
    test.identical( _.strCount( got.output, '::' ), 14 );

    return null;
  })

  shell({ args : [ '.resources.list *p* debug:1' ] })
  .thenKeep( ( got ) =>
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
    test.identical( _.strCount( got.output, '::' ), 13 );

    return null;
  })

  /* Glob using positive test */
  shell({ args : [ '.resources.list *proto*' ] })
  .thenKeep( ( got ) =>
  {
    test.case = 'resources list globs';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'reflector::reflect.proto.'  ) );
    test.is( _.strHas( got.output, `. : '.'` ) );

    test.is( _.strHas( got.output, 'step::reflect.proto.'  ) );
    test.is( _.strHas( got.output, `predefined.reflect` ) );

    test.is( _.strHas( got.output, 'build::proto.export'  ) );
    test.is( _.strHas( got.output, `step::export.proto` ) );

    return null;
  })

  /* Glob and criterion using negative test */
  shell({ args : [ '.resources.list *proto* debug:0' ] })
  .thenKeep( ( got ) =>
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
  .thenKeep( ( got ) =>
  {
    test.case = 'globs and criterions positive';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'path::proto'  ) );

    test.is( _.strHas( got.output, 'reflector::reflect.proto.'  ) );
    test.is( _.strHas( got.output, `. : '.'` ) );

    test.is( _.strHas( got.output, 'step::reflect.proto.'  ) );
    test.is( _.strHas( got.output, `predefined.reflect` ) );

    test.identical( _.strCount( got.output, '::' ), 6 );

    return null;
  })

  /* Glob and two criterions using negative test */
  shell({ args : [ '.resources.list * debug:1 raw:0 predefined:0' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.resources.list * debug:1 raw:0 predefined:0';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, `path::out.debug` ) );
    test.is( _.strHas( got.output, `reflector::reflect.proto.debug` ) );
    test.is( _.strHas( got.output, `step::reflect.proto.debug` ) );
    test.is( _.strHas( got.output, `step::export.proto` ) );
    test.is( _.strHas( got.output, `build::debug.compiled` ) );
    test.is( _.strHas( got.output, `build::proto.export` ) );
    test.identical( _.strCount( got.output, '::' ), 11 );

    return null;
  })

  /* Glob and two criterion using positive test */
  shell({ args : [ '.resources.list * debug:0 raw:1' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.resources.list * debug:0 raw:1';
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, 'step::reflect.proto.raw'  ) );
    test.is( _.strHas( got.output, 'build::release.raw'  ) );
    test.identical( _.strCount( got.output, '::' ), 4 );

    return null;
  })

  // /* - */
  //
  // shell({ args : [ '.execution.list' ] })
  //
  // .thenKeep( ( got ) =>
  // {
  //   test.case = '.execution.list'
  //   test.identical( got.exitCode, 0 );
  //   test.is( got.output.length );
  //   return null;
  // })

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
    test.case = '.submodules.download';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /0\/0 submodule\(s\) of .*module::single.* were downloaded in/ ) );
    return null;
  })

  /* - */

  shell({ args : [ '.submodules.download' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( ( got ) =>
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

  /* - */

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

  shell({ args : [ '.build' ] })

  .thenKeep( ( got ) =>
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
    test.is( _.strHas( got.output, /Building .*module::single \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, /Built .*module::single \/ build::debug\.raw.* in/ ) );

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
    test.is( _.strHas( got.output, /Building .*module::single \/ build::release\.raw.*/ ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, /Built .*module::single \/ build::release\.raw.* in/ ) );

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

  shell({ args : [ '.with "single with space" .resources.list' ] })

  .thenKeep( ( got ) =>
  {
    test.case = 'module info';
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

function open( test )
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

  .thenKeep( () =>
  {
    test.case = '.export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.export' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.with . .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with . .export' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.with doc .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc .export' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.with doc. .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc. .export' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.with doc/. .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc/. .export' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.with doc/doc .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc/doc .export' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.with doc/doc. .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.with doc/doc. .export' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.each . .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.each . .export' ] })

  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.each . .export'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.each doc/. .export' ] })

  .thenKeep( ( got ) =>
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

open.timeOut = 300000;

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, /module::Tools.+ version master/ ) );
    test.is( _.strHas( got.output, /module::PathFundamentals.+ version c8dadf139a49d70ccae2cac4f91845ecd0a925e0/ ) );
    test.is( _.strHas( got.output, /module::Color.+ version 0.3.102/ ) );
    test.is( _.strHas( got.output, /\.module\/Procedure\.informal.+ <- .+npm:\/\/wprocedure/ ) );
    test.is( _.strHas( got.output, /\.module\/Proto\.informal.+ <- .+git\+https:\/\/github\.com\/Wandalen\/wProto\.git#5500fe0c9540dde7bc7fbeccbe44c657a2862c30/ ) );
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.submodules.upgrade.refs dry:1';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.each module .export' ] })
  shell({ args : [ '.submodules.upgrade.refs dry:1' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, /module::Tools.* will be fixated/ ) );
    test.is( _.strHas( got.output, /git\+https:\/\/\/github.com\/Wandalen\/wTools\.git\/out\/wTools.* : .*\.#\w+.* <- .*\.#master/ ) );
    test.identical( _.strCount( got.output, 'fixateDetached/.im.will.yml' ), 4 );

    test.is( _.strHas( got.output, /module::PathFundamentals.* will be fixated/ ) );
    test.is( _.strHas( got.output, /git\+https:\/\/\/github.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals.* : .*\.#\w+.* <- .*\.#c8dadf139a49d70ccae2cac4f91845ecd0a925e0/ ) );
    test.identical( _.strCount( got.output, 'fixateDetached/.im.will.yml' ), 4 );

    test.is( _.strHas( got.output, /module::Color.* will be fixated/ ) );
    test.is( _.strHas( got.output, /npm:\/\/\/wColor\/out\/wColor.* : .*\.\w+.* <- .*\.#0\.3\.102/ ) );
    test.identical( _.strCount( got.output, 'fixateDetached/.im.will.yml' ), 4 );

    test.is( _.strHas( got.output, /module::UriFundamentals.* will be fixated/ ) );
    test.is( _.strHas( got.output, /wUriFundamentals\.git.* : .*\.#\w+.* <- .*\./ ) );
    test.is( _.strHas( got.output, /in .+\/fixateDetached\/out\/UriFundamentals\.informal\.out\.will\.yml/ ) );
    test.is( _.strHas( got.output, /in .+\/fixateDetached\/module\/UriFundamentals\.informal\.will\.yml/ ) );

    test.is( _.strHas( got.output, /module::Proto.* will be fixated/ ) );
    test.is( _.strHas( got.output, /wProto\.git.* : .*\.#\w+.* <- .*\.#5500fe0c9540dde7bc7fbeccbe44c657a2862c30/ ) );
    test.is( _.strHas( got.output, /in .+\/fixateDetached\/out\/Proto\.informal\.out\.will\.yml/ ) );
    test.is( _.strHas( got.output, /in .+\/fixateDetached\/module\/Proto\.informal\.will\.yml/ ) );

    test.is( _.strHas( got.output, /module::Procedure.* will be fixated/ ) );
    test.is( _.strHas( got.output, /npm:\/\/\/wprocedure.* : .*\.#\w+.* <- .*\./ ) );
    test.is( _.strHas( got.output, /in .+\/fixateDetached\/out\/Procedure\.informal\.out\.will\.yml/ ) );
    test.is( _.strHas( got.output, /in .+\/fixateDetached\/module\/Procedure\.informal\.will\.yml/ ) );

    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.submodules.fixate dry:1';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.each module .export' ] })
  shell({ args : [ '.submodules.fixate dry:1' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, /module::Tools.* will be fixated/ ) );
    test.is( _.strHas( got.output, /git\+https:\/\/\/github.com\/Wandalen\/wTools\.git\/out\/wTools.* : .*\.#\w+.* <- .*\.#master/ ) );
    test.identical( _.strCount( got.output, 'fixateDetached/.im.will.yml' ), 2 );

    test.is( !_.strHas( got.output, /module::PathFundamentals.* will be fixated/ ) );
    test.is( !_.strHas( got.output, /git\+https:\/\/\/github.com\/Wandalen\/wPathFundamentals\.git\/out\/wPathFundamentals.* : .*\.#\w+.* <- .*\.#c8dadf139a49d70ccae2cac4f91845ecd0a925e0/ ) );
    // test.identical( _.strCount( got.output, 'fixateDetached/.im.will.yml' ), 4 );

    test.is( !_.strHas( got.output, /module::Color.* will be fixated/ ) );
    test.is( !_.strHas( got.output, /npm:\/\/\/wColor\/out\/wColor.* : .*\.\w+.* <- .*\.#0\.3\.102/ ) );
    // test.identical( _.strCount( got.output, 'fixateDetached/.im.will.yml' ), 4 );

    test.is( _.strHas( got.output, /module::UriFundamentals.* will be fixated/ ) );
    test.is( _.strHas( got.output, /wUriFundamentals\.git.* : .*\.#\w+.* <- .*\./ ) );
    test.is( _.strHas( got.output, /in .+\/fixateDetached\/out\/UriFundamentals\.informal\.out\.will\.yml/ ) );
    test.is( _.strHas( got.output, /in .+\/fixateDetached\/module\/UriFundamentals\.informal\.will\.yml/ ) );

    test.is( !_.strHas( got.output, /module::Proto.* will be fixated/ ) );
    test.is( !_.strHas( got.output, /wProto\.git.* : .*\.#\w+.* <- .*\.#5500fe0c9540dde7bc7fbeccbe44c657a2862c30/ ) );
    test.is( !_.strHas( got.output, /in .+\/fixateDetached\/out\/Proto\.informal\.out\.will\.yml/ ) );
    test.is( !_.strHas( got.output, /in .+\/fixateDetached\/module\/Proto\.informal\.will\.yml/ ) );

    test.is( _.strHas( got.output, /module::Procedure.* will be fixated/ ) );
    test.is( _.strHas( got.output, /npm:\/\/\/wprocedure.* : .*\.#\w+.* <- .*\./ ) );
    test.is( _.strHas( got.output, /in .+\/fixateDetached\/out\/Procedure\.informal\.out\.will\.yml/ ) );
    test.is( _.strHas( got.output, /in .+\/fixateDetached\/module\/Procedure\.informal\.will\.yml/ ) );

    return null;
  })

  /* - */

  return ready;
}

fixateDetached.timeOut = 300000;

//

function eachMixed( test )
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
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.each submodule::*/path::predefined.local .shell "git status"'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build' ] })
  shell({ args : [ '.each submodule::*/path::predefined.local .shell "git status"' ] })
  .thenKeep( ( got ) =>
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

    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.each submodule:: .shell ls'
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build' ] })
  shell({ args : [ '.each submodule:: .shell ls' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, [ 'debug', 'wTools.out.will.yml', 'wTools.proto.export.out.tgs' ].join( '\n' ) ) );
    test.is( _.strHas( got.output, [ 'debug', 'wPathFundamentals.out.will.yml' ].join( '\n' ) ) );
    test.is( _.strHas( got.output, [ 'Proto.informal.out.will.yml', 'UriFundamentals.informal.out.will.yml', 'debug' ].join( '\n' ) ) );

    return null;
  })

  /* - */

  return ready;
}

eachMixed.timeOut = 300000;

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.with module .build'
    return null;
  })

  shell({ args : [ '.with module .build' ] })
  .thenKeep( ( got ) =>
  {
    test.is( got.exitCode !== 0 );
    test.is( _.strHas( got.output, 'Found no will-file' ) );
    return null;
  })

  /* - */

  return ready;
}

withMixed.timeOut = 300000;

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

  /* - */

  ready

  .thenKeep( () =>
  {
    test.case = '.build debug1'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    let outPath = _.path.join( routinePath, 'out' );
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug1' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    return null;
  })

  /* - */

  ready

  .thenKeep( () =>
  {
    test.case = '.build debug2'
    let outDebugPath = _.path.join( routinePath, 'out/debug' );
    let outPath = _.path.join( routinePath, 'out' );
    _.fileProvider.filesDelete( outDebugPath );
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug2' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    return null;
  })

  /* - */

  return ready;
}

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  });
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
    test.identical( reflector.src.prefixPath, 'path::exportedDir.proto.export' );
    test.identical( reflector.src.filePath, 'path::exportedFiles.proto.export' );

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
    test.is( _.strHas( got.output, /Exported .*module::single \/ build::proto.export.* in/ ) );
    test.is( _.strHas( got.output, 'reflected 2 files' ) );
    test.is( _.strHas( got.output, /Exported proto\.export with 2 files/ ) );

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
    test.identical( reflector.src.prefixPath, 'path::exportedDir.proto.export' );
    test.identical( reflector.src.filePath, 'path::exportedFiles.proto.export' );

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
    test.is( _.strHas( got.output, /Exporting .+module::export-to-root \/ build::proto\.export.+/ ) );
    test.is( _.strHas( got.output, '+ Write out will-file' ) );
    test.is( _.strHas( got.output, /Exported .+module::export-to-root \/ build::proto\.export.+ in/ ) );
    test.is( _.fileProvider.fileExists( _.path.join( routinePath, 'export-to-root.out.will.yml' ) ) )
    return null;
  })

  return ready;
}

exportToRoot.timeOut = 130000;

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( ( got ) =>
  {
    test.case = '.each module .export';
    return null;
  })

  shell({ args : [ '.each module .export' ] })

  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exporting .*module::UriFundamentals\.informal \/ build::export.*/ ) );
    test.is( _.strHas( got.output, '+ download reflected' ) );
    test.is( _.strHas( got.output, '+ Write out will-file' ) );
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
        'src' :
        {
          'filePath' : { 'git+https://.' : '.' },
          'prefixPath' : 'git+https:///github.com/Wandalen/wProto.git'
        },
        'dst' : { 'prefixPath' : '.module/Proto' },
        'mandatory' : 1,
      },
      'exported.export' :
      {
        'src' :
        {
          'filePath' : { '.' : null },
          'prefixPath' : '.module/Proto/proto'
        },
        'criterion' : { 'default' : 1, 'export' : 1 },
        'mandatory' : 1,
      },
      'exportedFiles.export' :
      {
        'recursive' : 0,
        'mandatory' : 1,
        'src' : { 'filePath' : 'path::exportedFiles.export', 'basePath' : '.', 'prefixPath' : 'path::exportedDir.export' },
        'criterion' : { 'default' : 1, 'export' : 1 }
      }
    }
    test.identical( outfile.reflector, expected );

    var expected =
    {
      'predefined.remote' :
      {
        'path' : 'git+https:///github.com/Wandalen/wProto.git'
      },
      'predefined.local' : { 'path' : '.module/Proto' },
      'export' : { 'path' : '{path::predefined.local}/proto' },
      'exportedDir.export' :
      {
        'path' : './.module/Proto/proto',
        'criterion' : { 'default' : 1, 'export' : 1 }
      },
      'exportedFiles.export' :
      {
        'path' :
        [
          '.module/Proto/proto',
          '.module/Proto/proto/dwtools',
          '.module/Proto/proto/dwtools/Tools.s',
          '.module/Proto/proto/dwtools/abase',
          '.module/Proto/proto/dwtools/abase/l3',
          '.module/Proto/proto/dwtools/abase/l3/Proto.s',
          '.module/Proto/proto/dwtools/abase/l3/ProtoAccessor.s',
          '.module/Proto/proto/dwtools/abase/l3/ProtoLike.s',
          '.module/Proto/proto/dwtools/abase/l3.test',
          '.module/Proto/proto/dwtools/abase/l3.test/Proto.test.s',
          '.module/Proto/proto/dwtools/abase/l3.test/ProtoLike.test.s'
        ],
        'criterion' : { 'default' : 1, 'export' : 1 }
      },
      'original.will.files' : { 'path' : 'module/Proto.informal.will.yml' },
      'in' : { 'path' : '..' },
      'out' : { 'path' : 'out' }
    }
    test.identical( outfile.path, expected );

    var expected =
    {
      'export' :
      {
        'version' : '0.1.0',
        'criterion' : { 'default' : 1, 'export' : 1 },
        'exportedReflector' : 'reflector::exported.export',
        'exportedFilesReflector' : 'reflector::exportedFiles.export',
        'exportedDirPath' : 'path::exportedDir.export',
        'exportedFilesPath' : 'path::exportedFiles.export',
        'originalWillFilesPath' : 'path::original.will.files',
      }
    }
    test.identical( outfile.exported, expected );

    var expected =
    {
      'export.common' :
      {
        'opts' : { 'export' : 'path::export', 'tar' : 0 },
        'inherit' : [ 'predefined.export' ]
      },
      'download' :
      {
        'opts' : { 'reflector' : 'reflector::download*' },
        'inherit' : [ 'predefined.reflect' ]
      }
    }
    test.identical( outfile.step, expected ); debugger;

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
  .thenKeep( ( got ) =>
  {
    test.case = '.build';
    return null;
  })

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build' ] })

  .thenKeep( ( got ) =>
  {

    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Exporting .*module::UriFundamentals.informal.* \/ build::export/ ) );
    test.is( _.strHas( got.output, '+ download reflected' ) );
    test.is( _.strHas( got.output, '+ Write out will-file' ) );
    test.is( _.strHas( got.output, /Exported .*module::UriFundamentals.informal.* \/ build::export/ ) );
    test.is( _.strHas( got.output, 'out/Proto.informal.out.will.yml' ) );
    test.is( _.strHas( got.output, 'out/UriFundamentals.informal.out.will.yml' ) );
    test.is( _.strHas( got.output, 'Reloading submodules' ) );

    test.is( _.strHas( got.output, '- filesDelete 0 files at' ) );
    test.is( _.strHas( got.output, '+ reflect.proto.debug reflected 2 files' ) );
    test.is( _.strHas( got.output, '+ reflect.submodules reflected' ) );

    test.is( _.strHas( got.output, /! Failed to read .+submodule::Tools.+/ ) );
    test.is( _.strHas( got.output, /! Failed to read .+submodule::PathFundamentals.+/ ) );
    test.is( _.strHas( got.output, /! Failed to read .+submodule::UriFundamentals.+/ ) );
    test.is( _.strHas( got.output, /! Failed to read .+submodule::Proto.+/ ) );

    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/Proto.informal.out.will.yml' ) ) );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/UriFundamentals.informal.out.will.yml' ) ) );

    var files = self.find( _.path.join( routinePath, 'module' ) );
    test.identical( files, [ '.', './Proto.informal.will.yml', './UriFundamentals.informal.will.yml' ] );
    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.gt( files.length, 80 );

    var expected = [ 'Proto.informal.will.yml', 'UriFundamentals.informal.will.yml' ];
    var files = _.fileProvider.dirRead( modulePath );
    test.identical( files, expected );

    var expected = [ 'dwtools', 'WithSubmodules.s' ];
    var files = _.fileProvider.dirRead( _.path.join( routinePath, 'out/debug' ) );
    test.identical( files, expected );

    var files = self.find( _.path.join( routinePath, 'out' ) );
    test.gt( files.length, 80 );

    return null;
  })

  /* - */

  return ready;
}

exportMixed.timeOut = 300000;

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

  shell({ args : [ '.resources.list' ] })

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

    test.is( _.strHas( got.output, 'step::delete.out.debug' ))
    test.is( _.strHas( got.output, 'step::reflect.proto.' ))
    test.is( _.strHas( got.output, 'step::reflect.proto.debug' ))
    test.is( _.strHas( got.output, 'step::reflect.submodules' ))
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

  // /* - */
  //
  // shell({ args : [ '.execution.list' ] })
  //
  // .thenKeep( ( got ) =>
  // {
  //   test.case = '.execution.list'
  //   test.identical( got.exitCode, 0 );
  //   test.is( got.output.length );
  //   return null;
  // })

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
    test.is( _.strHas( got.output, /2\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );

    var files = self.find( submodulesPath );

    test.is( files.length > 30 );

    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'Tools' ) ) )
    test.is( _.fileProvider.fileExists( _.path.join( submodulesPath, 'PathFundamentals' ) ) )
    return null;
  })

  /* xxx */

  .thenKeep( () =>
  {
    test.case = '.submodules.download - again';
    return null;
  })
  shell({ args : [ '.submodules.download' ] })
  .thenKeep( ( got ) =>
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

  /* xxx */

  .thenKeep( () =>
  {
    test.case = '.submodules.update - first time';
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })
  shell({ args : [ '.submodules.update' ] })
  .thenKeep( ( got ) =>
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

  .thenKeep( () =>
  {
    test.case = '.submodules.update - again';
    return null;
  })
  shell({ args : [ '.submodules.update' ] })
  .thenKeep( ( got ) =>
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

  ready

  /* - */

  .thenKeep( () =>
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
    debugger;
    return null;
  })

  /* - */

  shell({ args : [ '.submodules.update' ] })
  .thenKeep( () =>
  {
    test.case = '.build'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    // let outPath = _.path.join( routinePath, 'out/debug' );
    // var files = self.find( outPath );
    var files = self.find( outPath );

    test.is( files.length > 10 );

    return null;
  })

  /* - */

  .thenKeep( () =>
  {
    test.case = '.build wrong'
    _.fileProvider.filesDelete( outPath );
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
      test.is( !_.fileProvider.fileExists( outPath ) );
      test.is( !_.fileProvider.fileExists( buildOutDebugPath ) );
      test.is( !_.fileProvider.fileExists( buildOutReleasePath ) );

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
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  return shell({ args : [ '.export' ] })

  .thenKeep( ( got ) =>
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

  shell({ args : [ '.resources.list' ] })

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
    test.gt( self.find( _.path.join( routinePath, '.module/Tools' ) ).length, 70 );
    test.gt( self.find( _.path.join( routinePath, 'out/debug' ) ).length, 50 );
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
    test.gt( self.find( _.path.join( routinePath, '.module/Tools' ) ).length, 90 );
    test.gt( self.find( _.path.join( routinePath, 'out/debug' ) ).length, 50 );
    test.is( _.fileProvider.isTerminal( _.path.join( routinePath, 'out/Download.out.will.yml' ) ) );
    return null;
  })

  /* - */

  return ready;
}

submodulesDownload.timeOut = 300000;

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
  .thenKeep( () =>
  {
    files = self.find( submodulesPath );
    debugger;
    test.is( files.length > 50 );
    return files;
  })

  shell({ args : [ '.with NoTemp .clean' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'Clean deleted ' + files.length + ' file(s)' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) ); /* xxx : phantom problem ? */
    return null;
  })

  shell({ args : [ '.with NoTemp .clean' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.with NoTemp .clean -- second';
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

  shell({ args : [ '.with NoBuild .clean' ] })
  .thenKeep( ( got ) =>
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
  .thenKeep( () =>
  {
    _.fileProvider.filesDelete( outPath );
    _.fileProvider.filesDelete( submodulesPath );
    return null;
  })

  shell({ args : [ '.with Build .build' ] })
  shell({ args : [ '.with Vector .clean' ] })
  .thenKeep( ( got ) =>
  {
    test.case = '.with NoBuild .clean';
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '- Clean deleted 2 file(s) in' ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, '.module' ) ) );
    test.is( !_.fileProvider.fileExists( _.path.join( routinePath, 'out' ) ) );
    return null;
  })

  /* - */

  return ready;
}

clean.timeOut = 130000;

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
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

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

cleanBroken1.timeOut = 130000;

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
    test.is( _.strHas( got.output, /Exported .*module::submodules \/ build::proto\.export.* in/ ) );

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

cleanBroken2.timeOut = 130000;

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
    args : [ '.submodules.update' ],
  })

  .thenKeep( ( got ) =>
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
  .thenKeep( ( got ) =>
  {
    test.is( _.strHas( got.output, /0\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );
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

  shell({ args : [ '.submodules.update' ] })
  .thenKeep( ( got ) =>
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( ( got ) =>
  {
    test.case = '.clean';
    return null;
  })

  shell({ args : [ '.build' ] })
  shell({ args : [ '.clean' ] })

  .thenKeep( ( got ) =>
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

cleanMixed.timeOut = 130000;

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
    test.is( _.strHas( got.output, /Exported .*module::submodule \/ build::export.debug.*/ ) );
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
        archiveFilePath : 'path::archiveFile.export.debug',
        originalWillFilesPath : 'path::original.will.files'
      }
    }

    test.identical( outfile.exported, exported );

    var exportedReflector =
    {
      src : { filePath : { '.' : null }, prefixPath : 'out/debug' },
      mandatory : 1,
      criterion :
      {
        default : 1,
        debug : 1,
        raw : 1,
        export : 1
      }
    }
    test.identical( outfile.reflector[ 'exported.export.debug' ], exportedReflector ); // xxx

    var exportedReflectorFiles =
    {
      recursive : 0,
      mandatory : 1,
      src :
      {
        filePath : 'path::exportedFiles.export.debug',
        basePath : '.',
        prefixPath : 'path::exportedDir.export.debug',
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
      },
      'original.will.files' :
      {
        'path' : [ '.im.will.yml', '.ex.will.yml' ]
      },
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
    test.is( _.strHas( got.output, /Exported .*module::submodule \/ build::export\..* in/ ) );
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
        archiveFilePath : 'path::archiveFile.export.debug',
        originalWillFilesPath : 'path::original.will.files',
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
        archiveFilePath : 'path::archiveFile.export.',
        originalWillFilesPath : 'path::original.will.files',
      },
    }
    test.identical( outfile.exported, exported );

    var exportedReflector =
    {
      'mandatory' : 1,
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
      'mandatory' : 1,
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
      mandatory : 1,
      src :
      {
        filePath : 'path::exportedFiles.export.debug',
        basePath : '.',
        prefixPath : 'path::exportedDir.export.debug',
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
      mandatory : 1,
      src :
      {
        filePath : 'path::exportedFiles.export.',
        basePath : '.',
        prefixPath : 'path::exportedDir.export.'
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
      },
      'original.will.files' :
      {
        'path' : [ '.im.will.yml', '.ex.will.yml' ]
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

    debugger;

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
        archiveFilePath : 'path::archiveFile.export.debug',
        originalWillFilesPath : 'path::original.will.files',
      }
    }

    test.identical( outfile.exported, exported );

    var exportedReflector =
    {
      'mandatory' : 1,
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
      mandatory : 1,
      src :
      {
        filePath : 'path::exportedFiles.export.debug',
        // filePath : { '.' : null, 'File.debug.js' : null },
        basePath : '.',
        // prefixPath : 'out/debug'
        prefixPath : 'path::exportedDir.export.debug',
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

  /* - */

  return ready;
}

multipleExportsDoc.timeOut = 130000;

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
    test.identical( reflector.src.prefixPath, 'path::exportedDir.proto.export' );
    test.identical( reflector.src.filePath, 'path::exportedFiles.proto.export' );

    var expectedReflector =
    {
      'reflect.proto' :
      {
        'mandatory' : 1,
        src :
        {
          filePath : { 'path::proto' : 'path::out.*=1' },
        },
        inherit : [ 'predefined.*' ],
      },
      'reflect.submodules1' :
      {
        'mandatory' : 1,
        'dst' : { 'basePath' : '.', 'prefixPath' : 'path::out.debug' },
        criterion : { debug : 1 },
        inherit :
        [
          'submodule::*/exported::*=1/reflector::exportedFiles*=1'
        ]
      },
      'reflect.submodules2' :
      {
        'mandatory' : 1,
        src :
        {
          'filePath' : { 'submodule::*/exported::*=1/path::exportedDir*=1' : 'path::out.*=1' }
        },
        criterion : { debug : 1 },
        inherit : [ 'predefined.*' ]
      },
      'exported.proto.export' :
      {
        'mandatory' : 1,
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
        mandatory : 1,
        src :
        {
          'filePath' : 'path::exportedFiles.proto.export',
          'prefixPath' : 'path::exportedDir.proto.export',
          // filePath : { '.' : null, 'Single.s' : null },
          basePath : '.',
          // prefixPath : 'proto'
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

reflectGetPath.timeOut = 130000;

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

  /* */

  .thenKeep( () =>
  {
    test.case = '.build variant:3'
    _.fileProvider.filesDelete( outPath );
    return null;
  });
  shell({ args : [ '.build variant:3' ] })
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

reflectRemoteGit.timeOut = 130000;

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

  ready.thenKeep( () =>
  {
    test.case = '.build download'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  // debugger;
  // shell({ args : [ '.builds.list' ] })
  shell({ args : [ '.build download' ] })
  .thenKeep( ( arg ) =>
  {
    debugger;
    test.is( _.fileProvider.isTerminal( localFilePath ) );
    test.gt( _.fileProvider.fileSize( localFilePath ), 200 );
    return null;
  })

  return ready;
}

reflectRemoteHttp.timeOut = 130000;

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
  .thenKeep( () =>
  {
    test.case = '.with mandatory .build variant1';
    return null;
  })

  shell({ args : [ '.with mandatory .clean' ] })
  shell({ args : [ '.with mandatory .build variant1' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /\+ reflect\.proto1 reflected 3 files .+\/reflectWithOptions\/.* : .*out\/debug.* <- .*proto.* in/ ) );
    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/File.js', './debug/File.test.js' ] );
    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
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
    test.is( _.strHas( got.output, /Failed .*module::.+ \/ step::reflect\.proto2/ ) );
    test.is( _.strHas( got.output, /Error\. No file moved : .+reflectWithOptions.* : .*out\/debug.* <- .*proto2.*/ ) );
    var files = self.find( outPath );
    test.identical( files, [] );
    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.with mandatory .build variant3';
    return null;
  })

  shell({ args : [ '.with mandatory .clean' ] })
  shell({ args : [ '.with mandatory .build variant3' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /\+ reflect\.proto3 reflected 0 files .+\/reflectWithOptions\/.* : .*out\/debug.* <- .*proto.* in/ ) );
    var files = self.find( outPath );
    test.identical( files, [] );
    return null;
  })

  /* - */

  return ready;
}

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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  // ready
  // .thenKeep( () =>
  // {
  //   test.case = '.build debug1'
  //   _.fileProvider.filesDelete( outPath );
  //   return null;
  // })
  //
  // shell({ args : [ '.build debug1' ] })
  // .thenKeep( ( got ) =>
  // {
  //   test.identical( got.exitCode, 0 );
  //   test.is( _.strHas( got.output, '+ reflect.proto1 reflected 6 files' ) );
  //   test.is( _.strHas( got.output, /.*out\/debug1.* <- .*proto.*/ ) );
  //   var files = self.find( outPath );
  //   test.identical( files, [ '.', './debug1', './debug1/File.js', './debug1/File.s', './debug1/File.test.js', './debug1/some.test', './debug1/some.test/File2.js' ] );
  //   return null;
  // })
  //
  // /* - */
  //
  // ready
  // .thenKeep( () =>
  // {
  //   test.case = '.build debug2'
  //   _.fileProvider.filesDelete( outPath );
  //   return null;
  // })
  //
  // shell({ args : [ '.build debug2' ] })
  // .thenKeep( ( got ) =>
  // {
  //   test.identical( got.exitCode, 0 );
  //   test.is( _.strHas( got.output, '+ reflect.proto2 reflected 6 files' ) );
  //   test.is( _.strHas( got.output, /.*out\/debug2.* <- .*proto.*/ ) );
  //   var files = self.find( outPath );
  //   test.identical( files, [ '.', './debug2', './debug2/File.js', './debug2/File.s', './debug2/File.test.js', './debug2/some.test', './debug2/some.test/File2.js' ] );
  //   return null;
  // })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build debug3'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug3' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, '+ reflect.not.test.only.js.v1 reflected 6 files' ) );
    test.is( _.strHas( got.output, /.*out.* <- .*proto.*/ ) );
    var files = self.find( outPath );
    test.identical( files, [ '.', './debug1', './debug1/File.js', './debug1/File.s', './debug2', './debug2/File.js', './debug2/File.s' ] );
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
    throwingExitCode : 0,
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
  .thenKeep( () =>
  {
    test.case = 'reflect to out/debug';
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build debug' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/Single.s' ] );
    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = 'reflect to out/release';
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build release' ] })
  .thenKeep( ( got ) =>
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

//function reflectInherit( test )
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.with v1 .build'
    _.fileProvider.filesDelete( _.fileProvider.path.join( filePath, './Produced.js2' ) );
    _.fileProvider.filesDelete( _.fileProvider.path.join( filePath, './Produced.txt2' ) );
    return null;
  })

  shell({ args : [ '.with v1 .build' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( _.strHas( got.output, 'node file/Produce.js' ) );
    test.is( _.strHas( got.output, 'file\\Produced.txt2' ) );
    test.is( _.strHas( got.output, 'file\\Produced.js2' ) );
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( filePath );
    test.identical( files, [ '.', './File.js', './File.test.js', './Produce.js', './Produced.js2', './Produced.txt2', './Src1.txt', './Src2.txt' ] );
    return null;
  })

  shell({ args : [ '.with v1 .build' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( !_.strHas( got.output, 'node file/Produce.js' ) );
    test.is( !_.strHas( got.output, 'file\\Produced.txt2' ) );
    test.is( !_.strHas( got.output, 'file\\Produced.js2' ) );
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( filePath );
    test.identical( files, [ '.', './File.js', './File.test.js', './Produce.js', './Produced.js2', './Produced.txt2', './Src1.txt', './Src2.txt' ] );
    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.with v2 .build'
    _.fileProvider.fileDelete( _.fileProvider.path.join( filePath, './Produced.js2' ) );
    _.fileProvider.fileDelete( _.fileProvider.path.join( filePath, './Produced.txt2' ) );
    return null;
  })

  shell({ args : [ '.with v2 .build' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( _.strHas( got.output, 'node file/Produce.js' ) );
    test.is( _.strHas( got.output, 'file\\Produced.txt2' ) );
    test.is( _.strHas( got.output, 'file\\Produced.js2' ) );
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( filePath );
    test.identical( files, [ '.', './File.js', './File.test.js', './Produce.js', './Produced.js2', './Produced.txt2', './Src1.txt', './Src2.txt' ] );
    return null;
  })

  shell({ args : [ '.with v2 .build' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, /Building .+ \/ build::shell1/ ) );
    test.is( !_.strHas( got.output, 'node file/Produce.js' ) );
    test.is( !_.strHas( got.output, 'file\\Produced.txt2' ) );
    test.is( !_.strHas( got.output, 'file\\Produced.js2' ) );
    test.is( _.strHas( got.output, /Built .+ \/ build::shell1/ ) );

    var files = self.find( filePath );
    test.identical( files, [ '.', './File.js', './File.test.js', './Produce.js', './Produced.js2', './Produced.txt2', './Src1.txt', './Src2.txt' ] );
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = 'reflect only A'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build A' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    var expected = [ '.', './A.js' ];
    test.identical( files, expected );
    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = 'reflect only B'
    _.fileProvider.filesDelete( outPath );
    return null;
  })

  shell({ args : [ '.build B' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    var expected = [ '.', './B.js' ];
    test.identical( files, expected );
    return null;
  })


  return ready;
}

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

//

function setVerbosity( test )
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  ready

  /* - */

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.set verbosity:3 ; .build' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.set verbosity:3 ; .build';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, '.set verbosity:3 ; .build' ) );
    test.is( _.strHas( got.output, / \. Read .+\/\.im\.will\.yml/ ) );
    test.is( _.strHas( got.output, / \. Read .+\/\.ex\.will\.yml/ ) );
    test.is( _.strHas( got.output, / ! Failed to read .+submodule::Tools.+/ ) );
    test.is( _.strHas( got.output, / ! Failed to read .+submodule::PathFundamentals.+/ ) );
    test.is( _.strHas( got.output, '. Read 2 will-files in' ) );

    test.is( _.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, / \+ 2\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );
    test.is( _.strHas( got.output, ' - filesDelete' ) );
    test.is( _.strHas( got.output, ' + reflect.proto.debug reflected 2 files ' ) );
    test.is( _.strHas( got.output, ' + reflect.submodules reflected' ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    return null;
  })

  /* - */

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.set verbosity:2 ; .build' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.set verbosity:2 ; .build';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, '.set verbosity:2 ; .build' ) );
    test.is( !_.strHas( got.output, / \. Read .+\/\.im\.will\.yml/ ) );
    test.is( !_.strHas( got.output, / \. Read .+\/\.ex\.will\.yml/ ) );
    test.is( !_.strHas( got.output, / ! Failed to read .+submodule::Tools.+/ ) );
    test.is( !_.strHas( got.output, / ! Failed to read .+submodule::PathFundamentals.+/ ) );
    test.is( _.strHas( got.output, '. Read 2 will-files in' ) );

    test.is( _.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( _.strHas( got.output, / \+ 2\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );
    test.is( _.strHas( got.output, ' - filesDelete' ) );
    test.is( _.strHas( got.output, ' + reflect.proto.debug reflected 2 files ' ) );
    test.is( _.strHas( got.output, ' + reflect.submodules reflected' ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    return null;
  })

  /* - */

  shell({ args : [ '.clean' ] })
  shell({ args : [ '.set verbosity:1 ; .build' ] })
  .finally( ( err, got ) =>
  {
    test.case = '.set verbosity:1 ; .build';
    test.is( !err );
    test.identical( got.exitCode, 0 );

    test.is( _.strHas( got.output, '.set verbosity:1 ; .build' ) );
    test.is( !_.strHas( got.output, / \. Read .+\/\.im\.will\.yml/ ) );
    test.is( !_.strHas( got.output, / \. Read .+\/\.ex\.will\.yml/ ) );
    test.is( !_.strHas( got.output, / ! Failed to read .+submodule::Tools.+/ ) );
    test.is( !_.strHas( got.output, / ! Failed to read .+submodule::PathFundamentals.+/ ) );
    test.is( !_.strHas( got.output, '. Read 2 will-files in' ) );

    test.is( !_.strHas( got.output, /Building .*module::submodules \/ build::debug\.raw.*/ ) );
    test.is( !_.strHas( got.output, / \+ 2\/2 submodule\(s\) of .*module::submodules.* were downloaded in/ ) );
    test.is( !_.strHas( got.output, ' - filesDelete' ) );
    test.is( !_.strHas( got.output, ' + reflect.proto.debug reflected 2 files ' ) );
    test.is( !_.strHas( got.output, ' + reflect.submodules reflected' ) );
    test.is( _.strHas( got.output, /Built .*module::submodules \/ build::debug\.raw.*/ ) );

    return null;
  })

  /* - */

  return ready;
}

setVerbosity.timeOut = 300000;

//

function stepsList( test )
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

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

/*
qqq : investigate
(node:595912) MaxListenersExceededWarning: Possible EventEmitter memory leak detected. 11 exit listeners added. Use emitter.setMaxListeners() to increase limit
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build debug'
    _.fileProvider.filesDelete( outPath );
    return null;
  })
  shell({ args : [ '.build debug' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js', './debug/dir3.test', './debug/dir3.test/File.js', './debug/dir3.test/File.test.js' ] );
    _.fileProvider.isTerminal( _.path.join( outPath, 'debug/dir3.test/File.js' ) );
    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build compiled.debug'
    _.fileProvider.filesDelete( outPath );
    return null;
  })
  shell({ args : [ '.build compiled.debug' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './compiled.debug', './compiled.debug/Main.s', './tests.compiled.debug', './tests.compiled.debug/Tests.s' ] );
    _.fileProvider.isTerminal( _.path.join( outPath, 'compiled.debug/Main.s' ) );
    _.fileProvider.isTerminal( _.path.join( outPath, 'tests.compiled.debug/Tests.s' ) );

    let read = _.fileProvider.fileRead( _.path.join( outPath, 'compiled.debug/Main.s' ) );
    test.is( _.strHas( read, 'dir2/File.js' ) );
    test.is( _.strHas( read, 'dir2/File1.debug.js' ) );
    test.is( !_.strHas( read, 'dir2/File1.release.js' ) );
    test.is( _.strHas( read, 'dir2/File2.debug.js' ) );
    test.is( !_.strHas( read, 'dir2/File2.release.js' ) );

    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build raw.release'
    _.fileProvider.filesDelete( outPath );
    return null;
  })
  shell({ args : [ '.build raw.release' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './raw.release', './raw.release/dir2', './raw.release/dir2/File.js', './raw.release/dir2/File.test.js', './raw.release/dir2/File1.release.js', './raw.release/dir2/File2.release.js', './raw.release/dir3.test', './raw.release/dir3.test/File.js', './raw.release/dir3.test/File.test.js' ] );
    _.fileProvider.isTerminal( _.path.join( outPath, './raw.release/dir3.test/File.test.js' ) );
    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build release';
    _.fileProvider.filesDelete( outPath );
    return null;
  })
  shell({ args : [ '.build release' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './release', './release/Main.s', './tests.compiled.release', './tests.compiled.release/Tests.s' ] );
    _.fileProvider.isTerminal( _.path.join( outPath, './release/Main.s' ) );
    _.fileProvider.isTerminal( _.path.join( outPath, './tests.compiled.release/Tests.s' ) );

    let read = _.fileProvider.fileRead( _.path.join( outPath, './release/Main.s' ) );
    test.is( _.strHas( read, 'dir2/File.js' ) );
    test.is( !_.strHas( read, 'dir2/File1.debug.js' ) );
    test.is( _.strHas( read, 'dir2/File1.release.js' ) );
    test.is( !_.strHas( read, 'dir2/File2.debug.js' ) );
    test.is( _.strHas( read, 'dir2/File2.release.js' ) );

    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build all'
    _.fileProvider.filesDelete( outPath );
    return null;
  })
  shell({ args : [ '.build all' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    var files = self.find( outPath );
    test.identical( files, [ '.', './compiled.debug', './compiled.debug/Main.s', './debug', './debug/dir1', './debug/dir2', './debug/dir2/File.js', './debug/dir2/File.test.js', './debug/dir2/File1.debug.js', './debug/dir2/File2.debug.js', './debug/dir3.test', './debug/dir3.test/File.js', './debug/dir3.test/File.test.js', './raw.release', './raw.release/dir2', './raw.release/dir2/File.js', './raw.release/dir2/File.test.js', './raw.release/dir2/File1.release.js', './raw.release/dir2/File2.release.js', './raw.release/dir3.test', './raw.release/dir3.test/File.js', './raw.release/dir3.test/File.test.js', './release', './release/Main.s', './tests.compiled.debug', './tests.compiled.debug/Tests.s', './tests.compiled.release', './tests.compiled.release/Tests.s' ] );
    return null;
  })

  /* - */

  return ready;
}

transpile.timeOut = 130000;

//

function shellArgs( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'shell-args' );
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build debug1, args option'
    return null;
  })
  shell({ args : [ '.build debug1' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'script.js' ) )
    test.is( _.strHas( got.output, 'somePath' ) )
    test.is( _.strHas( got.output, 'arg1' ) )
    test.is( _.strHas( got.output, 'arg2' ) )
    return null;
  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build debug2, args in shell option'
    return null;
  })
  shell({ args : [ '.build debug2' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.is( _.strHas( got.output, 'script.js' ) )
    test.is( _.strHas( got.output, 'somePath' ) )
    test.is( _.strHas( got.output, 'arg1' ) )
    test.is( _.strHas( got.output, 'arg2' ) )
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build strings.join'
    return null;
  })
  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build strings.join' ] })
  .thenKeep( ( got ) =>
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
  .thenKeep( () =>
  {
    test.case = '.build multiply'
    return null;
  })
  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build multiply' ] })
  .thenKeep( ( got ) =>
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
  .thenKeep( () =>
  {
    test.case = '.build echo1'
    return null;
  })
  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build echo1' ] })
  .thenKeep( ( got ) =>
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
  .thenKeep( () =>
  {
    test.case = '.build echo2'
    return null;
  })
  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build echo2' ] })
  .thenKeep( ( got ) =>
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

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath }  })

  /* - */

  ready
  .thenKeep( () =>
  {
    test.case = '.build'
    return null;
  })
  shell({ args : [ '.clean' ] })
  shell({ args : [ '.build' ] })
  .thenKeep( ( got ) =>
  {
    test.identical( got.exitCode, 0 );
    test.identical( _.strCount( got.output, 'copy reflected 2 files' ), 1 );

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

    singleModuleSimplest,
    singleModuleList,
    singleModuleSubmodules,
    singleModuleClean,
    singleModuleBuild,
    singleModuleWithSpaceTrivial,

    exportSingle,
    exportWithReflector,
    exportToRoot,
    exportMixed,

    open,
    buildDetached,
    fixateDetached,
    eachMixed,
    withMixed,
    singleStep,

    submodulesInfo,
    submodulesList,
    submodulesDownloadUpgrade,
    submodulesBuild,
    submodulesExport,
    submodulesDownload,

    clean,
    cleanBroken1,
    cleanBroken2,
    cleanNoBuild,
    cleanWhat,
    cleanSubmodules,
    cleanMixed,

    multipleExports,
    multipleExportsImport,
    multipleExportsBroken,
    multipleExportsDoc,

    reflectNothingFromSubmodules,
    reflectGetPath,
    reflectSubdir,
    reflectSubmodulesWithBase,
    reflectComposite,
    reflectRemoteGit,
    reflectRemoteHttp,
    reflectWithOptions,
    reflectWithSelectorInDstFilter,
    reflectInherit,
    reflectSubmodulesWithCriterion,

    make,
    importInExport,
    setVerbosity,
    stepsList,
    help,
    transpile,
    // shellArgs,

    functionStringsJoin,
    functionPlatform,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
