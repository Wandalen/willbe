( function _WillInternals_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );;
  _.include( 'wExternalFundamentals' );
  _.include( 'wFiles' );

  require( '../will/MainBase.s' );

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

function resolve( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let moduleMapth = _.path.join( routinePath, 'super' );
  let modulesPath = _.path.join( routinePath, '.module' );
  let exportPath = _.path.join( routinePath, 'out' );
  let outWillPath = _.path.join( exportPath, 'super.out.will.yml' );
  let willExecPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec2' ) );
  let ready = new _.Consequence().take( null );
  let will = new _.Will;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesDelete( exportPath );

  var module = will.moduleMake( moduleMapth );

  /* - */

  module.ready.thenKeep( ( arg ) =>
  {

    test.case = 'build::*'; /* */

    var resolved = module.resolve({ query : 'build::*' });
    test.identical( resolved.length, 4 );

    var expected = [ 'debug', 'release', 'export.', 'export.debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    var expected =
    [
      [ 'step::submodules.download', 'step::reflect.submodules.*=1' ],
      [ 'step::submodules.download', 'step::reflect.submodules.*=1' ],
      [ 'build::*=1', 'step::export*=1' ],
      [ 'build::*=1', 'step::export*=1' ]
    ];
    var got = _.select( resolved, '*/steps' );
    test.identical( got, expected );

    test.case = 'build::*, with criterion'; /* */

    var resolved = module.resolve({ query : 'build::*', criterion : { debug : 1 } });
    test.identical( resolved.length, 2 );

    var expected = [ 'debug', 'export.debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    return null;
  });

  /* - */

  module.ready.thenKeep( ( arg ) =>
  {

    test.case = 'build::*, current is build::export.'; /* */

    var build = module.resolve({ query : 'build::export.' });
    test.is( build instanceof will.Build );
    test.identical( build.nickName, 'build::export.' );
    test.identical( build.absoluteName, 'module::super / build::export.' );

    var resolved = module.resolve({ query : 'build::*', current : build, unwrappingSingle : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'release' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    var expected = { 'debug' : 0 };
    var got = resolved[ 0 ].criterion;
    test.identical( got, expected );

    test.case = 'build::*, current is build::export.debug'; /* */

    var build = module.resolve({ query : 'build::export.debug' });
    var resolved = module.resolve({ query : 'build::*', current : build, unwrappingSingle : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    var expected = { 'debug' : 1, 'default' : 1 };
    var got = resolved[ 0 ].criterion;
    test.identical( got, expected );

    test.case = 'build::*, current is build::export.debug, short-cut'; /* */

    var build = module.resolve({ query : 'build::export.debug' });
    var resolved = build.resolve({ query : 'build::*', unwrappingSingle : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    test.case = 'build::*, current is build::export.debug, short-cut, explicit criterion'; /* */

    var build = module.resolve({ query : 'build::export.*', criterion : { debug : 1 } });
    var resolved = build.resolve({ query : 'build::*', unwrappingSingle : 0, criterion : { debug : 0 } });
    test.identical( resolved.length, 2 );

    var expected = [ 'release', 'export.' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    return null;
  });

  /* - */

  module.ready.finallyKeep( ( err, arg ) =>
  {

    debugger;
    test.is( err === undefined );
    module.finit();

    if( err )
    throw err;
    return arg;
  });
  return module.ready.split();
}

resolve.timeOut = 130000;

// --
// define class
// --

var Self =
{

  name : 'Tools/atop/WillInternals',
  silencing : 1,

  onSuiteBegin : onSuiteBegin,
  onSuiteEnd : onSuiteEnd,

  context :
  {
    tempDir : null,
    assetDirPath : null
  },

  tests :
  {

    resolve,

  }

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})( );
