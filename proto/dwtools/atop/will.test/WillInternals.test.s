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

function buildsResolve( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'super' );
  let modulesPath = _.path.join( routinePath, '.module' );
  let exportPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );
  let will = new _.Will;
  let path = _.fileProvider.path;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesDelete( exportPath );

  var module = will.moduleMake( modulePath );

  /* - */

  module.ready.thenKeep( ( arg ) =>
  {

    test.case = 'build::*'; /* */

    var resolved = module.resolve({ selector : 'build::*' });
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

    var resolved = module.resolve({ selector : 'build::*', criterion : { debug : 1 } });
    test.identical( resolved.length, 2 );

    var expected = [ 'debug', 'export.debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    test.case = 'build::*, current is build::export.'; /* */

    var build = module.resolve({ selector : 'build::export.' });
    test.is( build instanceof will.Build );
    test.identical( build.nickName, 'build::export.' );
    test.identical( build.absoluteName, 'module::super / build::export.' );

    var resolved = module.resolve({ selector : 'build::*', current : build, singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'release' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    var expected = { 'debug' : 0 };
    var got = resolved[ 0 ].criterion;
    test.identical( got, expected );

    test.case = 'build::*, current is build::export.debug'; /* */

    var build = module.resolve({ selector : 'build::export.debug' });
    var resolved = module.resolve({ selector : 'build::*', current : build, singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    var expected = { 'debug' : 1, 'default' : 1 };
    var got = resolved[ 0 ].criterion;
    test.identical( got, expected );

    test.case = 'build::*, current is build::export.debug, short-cut'; /* */

    var build = module.resolve({ selector : 'build::export.debug' });
    var resolved = build.resolve({ selector : 'build::*', singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    test.case = 'build::*, current is build::export.debug, short-cut, explicit criterion'; /* */

    var build = module.resolve({ selector : 'build::export.*', criterion : { debug : 1 } });
    var resolved = build.resolve({ selector : 'build::*', singleUnwrapping : 0, criterion : { debug : 0 } });
    test.identical( resolved.length, 2 );

    var expected = [ 'release', 'export.' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    return null;
  })

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

buildsResolve.timeOut = 130000;

//

function pathsResolve( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'super' );
  let modulesPath = _.path.join( routinePath, '.module' );
  let exportPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );
  let will = new _.Will;
  let path = _.fileProvider.path;

  function pin( filePath )
  {
    return path.s.join( routinePath, filePath );
  }

  function pout( filePath )
  {
    return path.s.join( routinePath, 'super.out', filePath );
  }

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesDelete( exportPath );

  var module = will.moduleMake( modulePath );

  /* - */

  // module.ready.thenKeep( ( arg ) =>
  // {
  //
  //   test.case = 'resolved, .';
  //   var resolved = module.resolve({ prefixlessAction : 'resolved', selector : '.' })
  //   var expected = '.';
  //   test.identical( resolved, expected );
  //
  //   return null;
  // })

  module.ready.thenKeep( ( arg ) =>
  {

    test.case = 'path::in*=1, pathResolving : 0';
    var resolved = module.resolve({ prefixlessAction : 'resolved', selector : 'path::in*=1', pathResolving : 0 })
    var expected = '..';
    test.identical( resolved, expected );

    test.case = 'path::in*=1';
    var resolved = module.resolve({ prefixlessAction : 'resolved', selector : 'path::in*=1' })
    var expected = routinePath;
    test.identical( resolved, expected );

    return null;
  })

  return module.ready; xxx

  /* - */

  module.ready.thenKeep( ( arg ) =>
  {

    test.case = 'path::* - implicit'; /* */
    var resolved = module.resolve({ selector : 'path::*' });
    test.identical( resolved.length, 6 );
    var expected = path.s.join( routinePath, [ './proto', '../super.out', '..', '../super.out', './super.out/debug', './super.out/release' ] );
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:1 pr:in'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 1,
      pathResolving : 'in',
    });
    test.identical( resolved.length, 6 );
    var expected = path.s.join( routinePath, [ './proto', '../super.out', '..', '../super.out', './super.out/debug', './super.out/release' ] );
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:1 pr:out'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 1,
      pathResolving : 'out',
    });
    test.identical( resolved.length, 6 );
    var expected = path.s.join( routinePath, 'super.out', [ './proto', '../super.out', '..', '../super.out', './super.out/debug', './super.out/release' ] );
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:1 pr:null'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 1,
      pathResolving : null,
    });
    test.identical( resolved.length, 6 );
    var expected = [ './proto', '../super.out', '..', '../super.out', './super.out/debug', './super.out/release' ];
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:0 mvu:0 pr:null'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 0,
      pathResolving : null,
    });
    var expected =
    {
      'proto' : './proto',
      'temp' : '../super.out',
      'in' : '..',
      'out' : '../super.out',
      'out.debug' : './super.out/debug',
      'out.release' : './super.out/release'
    }
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );
    _.any( resolved, ( e, k ) => test.is( e === module.pathObjMap[ k ] ) );
    _.any( resolved, ( e, k ) => test.is( e.module === module ) );

    test.case = 'path::* - pu:0 mvu:0 pr:in'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 0,
      pathResolving : 'in',
    });
    var expected =
    {
      'proto' : pin( './proto' ),
      'temp' : pin( '../super.out' ),
      'in' : pin( '..' ),
      'out' : pin( '../super.out' ),
      'out.debug' : pin( './super.out/debug' ),
      'out.release' : pin( './super.out/release' ),
    }
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );

    test.case = 'path::* - pu:0 mvu:0 pr:out'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 0,
      pathResolving : 'out',
    });
    var expected =
    {
      'proto' : pout( './proto' ),
      'temp' : pout( '../super.out' ),
      'in' : pout( '..' ),
      'out' : pout( '../super.out' ),
      'out.debug' : pout( './super.out/debug' ),
      'out.release' : pout( './super.out/release' ),
    }
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:0 pr:null'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 0,
      pathResolving : null,
    });
    var expected =
    {
      'proto' : './proto',
      'temp' : '../super.out',
      'in' : '..',
      'out' : '../super.out',
      'out.debug' : './super.out/debug',
      'out.release' : './super.out/release'
    }
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:0 pr:in'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 0,
      pathResolving : 'in',
    });
    var expected =
    {
      'proto' : pin( './proto' ),
      'temp' : pin( '../super.out' ),
      'in' : pin( '..' ),
      'out' : pin( '../super.out' ),
      'out.debug' : pin( './super.out/debug' ),
      'out.release' : pin( './super.out/release' ),
    }
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:0 pr:out'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 0,
      pathResolving : 'out',
    });
    var expected =
    {
      'proto' : pout( './proto' ),
      'temp' : pout( '../super.out' ),
      'in' : pout( '..' ),
      'out' : pout( '../super.out' ),
      'out.debug' : pout( './super.out/debug' ),
      'out.release' : pout( './super.out/release' ),
    }
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:0 mvu:1 pr:null'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : null,
    });
    var expected = [ './proto', '../super.out', '..', '../super.out', './super.out/debug', './super.out/release' ];
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );

    test.case = 'path::* - pu:0 mvu:1 pr:in'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : 'in',
    });
    var expected = pin([ './proto', '../super.out', '..', '../super.out', './super.out/debug', './super.out/release' ]);
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );

    test.case = 'path::* - pu:0 mvu:1 pr:out'; /* */
    var resolved = module.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : 'out',
    });
    var expected = pout([ './proto', '../super.out', '..', '../super.out', './super.out/debug', './super.out/release' ]);
    var got = _.select( resolved, '*/path' );
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

pathsResolve.timeOut = 130000;

//

function simple( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'simple' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, '.' );
  let modulesPath = _.path.join( routinePath, '.module' );
  let exportPath = _.path.join( routinePath, 'out' );
  let ready = new _.Consequence().take( null );
  let will = new _.Will;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesDelete( exportPath );

  var module = will.moduleMake( modulePath );

  return module.ready.split().then( () =>
  {

    var expected = [];
    var files = self.find( exportPath );

    let builds = module.buildsSelect();

    test.identical( builds.length, 1 );

    let build = builds[ 0 ];

    return build.perform()
    .finally( ( err, arg ) =>
    {

      var expected = [ '.', './debug', './debug/File.js' ];
      var files = self.find( exportPath );
      test.identical( files, expected );

      module.finit();
      if( err )
      throw err;
      return arg;
    });

  });
}

simple.timeOut = 130000;

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

    buildsResolve,
    pathsResolve,
    simple,

  }

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})( );
