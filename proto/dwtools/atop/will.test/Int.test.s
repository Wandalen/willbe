( function _WillInternals_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );;
  _.include( 'wAppBasic' );
  _.include( 'wFiles' );

  require( '../will/MainBase.s' );

}

var _global = _global_;
var _ = _global_.wTools;

/*
qqq : implement test checking "will .call link" links files ".dot1" ".dot2"
xxx : should work
  > local-will .imply withOut:0 .with * .call GitStatus
  not only
  > local-will .imply withOut:0 ; .with * .call GitStatus
xxx : find solution
  > git push --tags
  fatal: TaskCanceledException encountered.
  A task was canceled.
  bash: /dev/tty: No such device or address
*/

// --
// context
// --

function onSuiteBegin()
{
  let self = this;

  self.suiteTempPath = _.path.pathDirTempOpen( _.path.join( __dirname, '../..'  ), 'willbe' );
  self.suiteAssetsOriginalPath = _.path.join( __dirname, '_asset' );
  self.repoDirPath = _.path.join( self.suiteAssetsOriginalPath, '_repo' );

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

  a.test = test;
  a.name = name;
  a.originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, name );
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
  }

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

    if( _.arrayIs( filePath ) || _.mapIs( filePath ) )
    {
      return _.filter( filePath, ( filePath ) => abs( filePath, ... args.slice( 2, args.length ) ) );
    }

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

// //
//
// function ReplaceSetsAreIdentical()
// {
//   _.include( 'wIntrospector' );
//
//   let file = _.introspector.thisFile().refine();
//
//   logger.log( file.productExportInfo() );
//
//   debugger;
//   file.product.nodes.map( null, ( node ) =>
//   {
//     let found = file.nodeSearch( node, 'setsAreIdentical' );
//     if( _.mapKeys( found ).length )
//     debugger;
//   });
//   debugger;
//
//   file.arrange();
// }
//
// // ReplaceSetsAreIdentical();

// --
// tests
// --

function preCloneRepos( test )
{
  let self = this;
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), '../will/Exec' ) );
  let ready = new _.Consequence().take( null )

  let reposDownload = require( './ReposDownload.s' );

  ready.then( () => reposDownload() )
  ready.then( () =>
  {
    test.is( _.fileProvider.isDir( _.path.join( self.repoDirPath, 'Tools' ) ) );
    return null;
  })

  return ready;
}

//

function buildSimple( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'simple' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( './' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
  _.fileProvider.filesDelete( outDirPath );

  var opener = will.openerMakeManual({ willfilesPath : modulePath });
  opener.find();

  return opener.open().split().then( () =>
  {

    var expected = [];
    var files = self.find( outDirPath );
    let builds = opener.openedModule.buildsResolve();

    test.identical( builds.length, 1 );

    let build = builds[ 0 ];

    return build.perform()
    .finally( ( err, arg ) =>
    {

      test.description = 'files';
      var expected = [ '.', './debug', './debug/File.js' ];
      var files = self.find( outDirPath );
      test.identical( files, expected );

      opener.finit();

      test.description = 'no garbage left';
      test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

      if( err )
      throw err;
      return arg;
    });

  });
}

//

function openNamedFast( test )
{
  let self = this;
  let assetName = 'two-exported/super';
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'super' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

  will.prefer
  ({
    allOfMain : 0,
    allOfSub : 0,
  });

  var opener1 = will.openerMakeManual({ willfilesPath : modulePath });
  let ready1 = opener1.open();

  var opener2 = will.openerMakeManual({ willfilesPath : modulePath });
  let ready2 = opener2.open();

  /* - */

  ready1.then( ( arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    check( opener1 );
    return null;
  })

  /* - */

  ready1.finally( ( err, arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    test.is( err === undefined );
    if( err )
    throw err;
    return arg;
  });

  /* - */

  ready2.then( ( arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    check( opener2 );
    return null;
  })

  /* - */

  ready2.finally( ( err, arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    test.is( err === undefined );
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake([ ready1, ready2 ])
  .finally( ( err, arg ) =>
  {
    if( err )
    throw err;

    test.is( opener1.openedModule === opener2.openedModule );

    var exp = [ 'super' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );

    var exp = [ 'super.ex.will.yml', 'super.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( _.mapKeys( will.willfileWithFilePathPathMap ), abs( exp ) );
    var exp = [ 'super' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

    opener1.finit();

    var exp = [ 'super' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'sub.out/sub.out', 'super' ];
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

    opener2.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return arg;
  });

  /* - */

  function check( opener )
  {

    let pathMap =
    {

      'proto' : 'proto',
      'temp' : [ 'super.out', 'sub.out' ],
      'in' : '.',
      'out' : 'super.out',
      'out.debug' : 'super.out/debug',
      'out.release' : 'super.out/release',

      'local' : abs( 'super' ),
      'remote' : null,
      'current.remote' : null,
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : abs( '.' ),
      'module.willfiles' : abs( [ 'super.ex.will.yml', 'super.im.will.yml' ] ),
      'module.peer.willfiles' : abs( 'super.out/supermodule.out.will.yml' ),
      'module.peer.in' : abs( 'super.out' ),
      'module.original.willfiles' : abs( [ 'super.ex.will.yml', 'super.im.will.yml' ] ),
      'module.common' : abs( 'super' ),
      'download' : null,

    }

    test.identical( opener.qualifiedName, 'opener::supermodule' );
    test.identical( opener.absoluteName, 'opener::supermodule' );
    test.identical( opener.fileName, 'super' );
    test.identical( opener.aliasName, null );
    test.identical( opener.localPath, abs( './super' ) );
    test.identical( opener.remotePath, null );
    test.identical( opener.dirPath, abs( '.' ) );
    test.identical( opener.commonPath, abs( 'super' ) );
    test.identical( opener.willfilesPath, abs( [ './super.ex.will.yml', './super.im.will.yml' ] ) );
    test.identical( opener.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.mapKeys( opener.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.identical( opener.openedModule.qualifiedName, 'module::supermodule' );
    test.identical( opener.openedModule.absoluteName, 'module::supermodule' );
    test.identical( opener.openedModule.inPath, routinePath );
    test.identical( opener.openedModule.dirPath, abs( '.' ) );
    test.identical( opener.openedModule.localPath, abs( 'super' ) );
    test.identical( opener.openedModule.remotePath, null );
    test.identical( opener.openedModule.currentRemotePath, null );
    test.identical( opener.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );
    test.identical( opener.openedModule.outPath, abs( 'super.out' ) );
    test.identical( opener.openedModule.commonPath, abs( 'super' ) );
    test.identical( opener.openedModule.willfilesPath, abs( [ './super.ex.will.yml', './super.im.will.yml' ] ) );
    test.identical( opener.openedModule.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.is( !!opener.openedModule.about );
    test.identical( opener.openedModule.about.name, 'supermodule' );
    test.identical( opener.openedModule.pathMap, pathMap );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.submoduleMap ) ), _.setFrom( [ 'Submodule' ] ) );
    var got = _.filter( _.mapKeys( opener.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e );
    test.identical( _.setFrom( got ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug' ] ) );

    let steps = _.select( opener.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( _.setFrom( steps ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug', 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.buildMap ) ), _.setFrom( [ 'debug', 'release', 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.exportedMap ) ), _.setFrom( [] ) );

  }

} /* end of function openNamedFast */

//

function openNamedForming( test )
{
  let self = this;
  let assetName = 'two-exported/super';
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'super' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

  will.prefer
  ({
    allOfMain : 0,
    allOfSub : 0,
    peerModulesFormedOfMain : 1,
    peerModulesFormedOfSub : 1,
  });

  let opener1 = will.openerMakeManual({ willfilesPath : modulePath });
  let ready1 = opener1.open({ all : 1 });

  test.case = 'skipping of stages of module';
  var stager = opener1.openedModule.stager;
  test.identical( stager.stageStateSkipping( 'preformed' ), false );
  test.identical( stager.stageStateSkipping( 'opened' ), false );
  test.identical( stager.stageStateSkipping( 'attachedWillfilesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'peerModulesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'subModulesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'resourcesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'formed' ), false );

  let opener2 = will.openerMakeManual({ willfilesPath : modulePath });
  let ready2 = opener2.open();

  test.case = 'skipping of stages of module';
  var stager = opener1.openedModule.stager;
  test.identical( stager.stageStateSkipping( 'preformed' ), false );
  test.identical( stager.stageStateSkipping( 'opened' ), false );
  test.identical( stager.stageStateSkipping( 'attachedWillfilesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'peerModulesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'subModulesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'resourcesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'formed' ), false );

  test.case = 'structure consistency';
  test.is( will.mainOpener === opener1 );
  test.is( opener1.openedModule === opener2.openedModule );

  /* - */

  ready1.then( ( arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    check( opener1 );
    return null;
  })

  /* - */

  ready1.finally( ( err, arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    test.is( err === undefined );
    if( err )
    throw err;
    return arg;
  });

  /* - */

  ready2.then( ( arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    check( opener2 );
    return null;
  })

  /* - */

  ready2.finally( ( err, arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    test.is( err === undefined );
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake([ ready1, ready2 ])
  .finally( ( err, arg ) =>
  {
    if( err )
    throw err;

    test.is( opener1.openedModule === opener2.openedModule );

    test.case = 'stages';
    var stager = opener1.openedModule.stager;
    test.identical( stager.stageStatePerformed( 'preformed' ), true );
    test.identical( stager.stageStatePerformed( 'opened' ), true );
    test.identical( stager.stageStatePerformed( 'attachedWillfilesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'peerModulesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'subModulesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'resourcesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'formed' ), true );

    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

    debugger;
    opener1.finit();

    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

    debugger;
    opener2.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return arg;
  });

  /* - */

  function check( opener )
  {

    let pathMap =
    {

      'proto' : 'proto',
      'temp' : [ 'super.out', 'sub.out' ],
      'in' : '.',
      'out' : 'super.out',
      'out.debug' : 'super.out/debug',
      'out.release' : 'super.out/release',

      'local' : abs( 'super' ),
      'remote' : null,
      'current.remote' : null,
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : abs( '.' ),
      'module.willfiles' : abs( [ 'super.ex.will.yml', 'super.im.will.yml' ] ),
      'module.original.willfiles' : abs( [ 'super.ex.will.yml', 'super.im.will.yml' ] ),
      'module.peer.willfiles' : abs( 'super.out/supermodule.out.will.yml' ),
      'module.peer.in' : abs( 'super.out' ),
      'module.common' : abs( 'super' ),
      'download' : null,

    }

    test.identical( opener.qualifiedName, 'opener::supermodule' );
    test.identical( opener.absoluteName, 'opener::supermodule' );
    test.identical( opener.fileName, 'super' );
    test.identical( opener.aliasName, null );
    test.identical( opener.localPath, abs( './super' ) );
    test.identical( opener.remotePath, null );
    test.identical( opener.dirPath, abs( '.' ) );
    test.identical( opener.commonPath, abs( 'super' ) );
    test.identical( opener.willfilesPath, abs( [ './super.ex.will.yml', './super.im.will.yml' ] ) );
    test.identical( opener.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.mapKeys( opener.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.identical( opener.openedModule.qualifiedName, 'module::supermodule' );
    test.identical( opener.openedModule.absoluteName, 'module::supermodule' );
    test.identical( opener.openedModule.inPath, routinePath );
    test.identical( opener.openedModule.dirPath, abs( '.' ) );
    test.identical( opener.openedModule.localPath, abs( 'super' ) );
    test.identical( opener.openedModule.remotePath, null );
    test.identical( opener.openedModule.currentRemotePath, null );
    test.identical( opener.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );
    test.identical( opener.openedModule.outPath, abs( 'super.out' ) );
    test.identical( opener.openedModule.commonPath, abs( 'super' ) );
    test.identical( opener.openedModule.willfilesPath, abs( [ './super.ex.will.yml', './super.im.will.yml' ] ) );
    test.identical( opener.openedModule.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.is( !!opener.openedModule.about );
    test.identical( opener.openedModule.about.name, 'supermodule' );
    test.identical( opener.openedModule.pathMap, pathMap );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.submoduleMap ) ), _.setFrom( [ 'Submodule' ] ) );
    test.identical( _.setFrom( _.filter( _.mapKeys( opener.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ) ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug' ] ) );

    let steps = _.select( opener.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( _.setFrom( steps ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug', 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.buildMap ) ), _.setFrom( [ 'debug', 'release', 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.exportedMap ) ), _.setFrom( [] ) );

  }

} /* end of function openNamedForming */

//

function openSkippingSubButAttachedWillfilesSkippingMainPeers( test )
{
  let self = this;
  let assetName = 'two-exported/super';
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'super' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener1;
  let ready1;
  let opener2;
  let ready2;

  /* - */

  ready
  .then( () =>
  {
    test.description = 'first run';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

    will.prefer
    ({
      allOfMain : 1,
      peerModulesFormedOfMain : 0,
      attachedWillfilesFormedOfSub : 1,
      // peerModulesFormedOfSub : 0,
    });

    opener1 = will.openerMakeManual({ willfilesPath : modulePath })
    ready1 = opener1.open();
    opener2 = will.openerMakeManual({ willfilesPath : modulePath });
    ready2 = opener2.open({});

    return _.Consequence.AndTake([ ready1, ready2 ])
  })

  .finally( ( err, arg ) => check( err, arg ) );

  /* - */

  ready
  .then( () =>
  {
    test.description = 'second run';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

    will.instanceDefaultsReset();

    will.prefer
    ({
      allOfMain : 1,
      peerModulesFormedOfMain : 0,
      attachedWillfilesFormedOfSub : 1,
      // peerModulesFormedOfSub : 0,
    });

    opener1 = will.openerMakeManual({ willfilesPath : modulePath })
    ready1 = opener1.open();
    opener2 = will.openerMakeManual({ willfilesPath : modulePath });
    ready2 = opener2.open({});

    return _.Consequence.AndTake([ ready1, ready2 ])
  })

  .finally( ( err, arg ) => check( err, arg ) );

  /* - */

  return ready;

  /* - */

  function check( err, arg )
  {
    if( err )
    throw err;

    test.case = 'skipping of stages of module';
    var stager = opener1.openedModule.stager;
    test.identical( stager.stageStateSkipping( 'preformed' ), false );
    test.identical( stager.stageStateSkipping( 'opened' ), false );
    test.identical( stager.stageStateSkipping( 'attachedWillfilesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'peerModulesFormed' ), true );
    test.identical( stager.stageStateSkipping( 'subModulesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'resourcesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'formed' ), false );

    test.case = 'structure consistency';
    test.is( will.mainOpener === opener1 );
    test.is( opener1.openedModule === opener2.openedModule );

    var exp = [ 'super', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    var exp = [ 'super', 'sub.out/sub.out', 'sub' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );

    opener1.finit();

    var exp = [ 'super', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'sub.out/sub.out', 'sub', 'super' ];
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'sub.out/sub.out', 'sub' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );
    opener2.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return arg;
  }

} /* end of function openSkippingSubButAttachedWillfilesSkippingMainPeers */

//

function openSkippingSubButAttachedWillfiles( test )
{
  let self = this;
  let assetName = 'two-exported/super';
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'super' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener1;
  let ready1;
  let opener2;
  let ready2;

  /* - */

  ready
  .then( () =>
  {
    test.description = 'first run';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

    will.prefer
    ({
      allOfMain : 1,
      attachedWillfilesFormedOfSub : 1,
      subModulesFormedOfSub : 0,
    });

    opener1 = will.openerMakeManual({ willfilesPath : modulePath })
    ready1 = opener1.open();
    opener2 = will.openerMakeManual({ willfilesPath : modulePath });
    ready2 = opener2.open();

    return _.Consequence.AndTake([ ready1, ready2 ])
  })
  .finally( ( err, arg ) => check( err, arg ) );

  /* - */

  ready
  .then( () =>
  {
    test.description = 'second run';

    will.instanceDefaultsReset();

    will.prefer
    ({
      allOfMain : 1,
      subModulesFormedOfSub : 0,
    });

    opener1 = will.openerMakeManual({ willfilesPath : modulePath })
    ready1 = opener1.open();
    opener2 = will.openerMakeManual({ willfilesPath : modulePath });
    ready2 = opener2.open();

    return _.Consequence.AndTake([ ready1, ready2 ])
  })
  .finally( ( err, arg ) => check( err, arg ) );

  /* - */

  return ready;

  /* - */

  function check( err, arg )
  {
    if( err )
    throw err;

    test.case = 'skipping of stages of module';
    var stager = opener1.openedModule.stager;
    test.identical( stager.stageStateSkipping( 'preformed' ), false );
    test.identical( stager.stageStateSkipping( 'opened' ), false );
    test.identical( stager.stageStateSkipping( 'attachedWillfilesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'peerModulesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'subModulesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'resourcesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'formed' ), false );
    test.identical( stager.stageStatePerformed( 'preformed' ), true );
    test.identical( stager.stageStatePerformed( 'opened' ), true );
    test.identical( stager.stageStatePerformed( 'attachedWillfilesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'peerModulesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'subModulesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'resourcesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'formed' ), true );

    test.case = 'skipping of stages of module';
    var stager = will.moduleWithNameMap.Submodule.stager;
    test.identical( stager.stageStateSkipping( 'preformed' ), false );
    test.identical( stager.stageStateSkipping( 'opened' ), false );
    test.identical( stager.stageStateSkipping( 'attachedWillfilesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'peerModulesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'subModulesFormed' ), true );
    test.identical( stager.stageStateSkipping( 'resourcesFormed' ), true );
    test.identical( stager.stageStateSkipping( 'formed' ), false );

    test.identical( stager.stageStatePerformed( 'preformed' ), true );
    test.identical( stager.stageStatePerformed( 'opened' ), true );
    test.identical( stager.stageStatePerformed( 'attachedWillfilesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'peerModulesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'subModulesFormed' ), false );
    test.identical( stager.stageStatePerformed( 'resourcesFormed' ), false );
    test.identical( stager.stageStatePerformed( 'formed' ), true );

    test.case = 'structure consistency';
    test.is( will.mainOpener === opener1 );
    test.is( opener1.openedModule === opener2.openedModule );

    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super', 'sub.out/sub.out', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub', 'super' ];
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

    opener1.finit();

    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'sub.out/sub.out', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub', 'super' ];
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

    opener2.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return arg;
  }

} /* end of function openSkippingSubButAttachedWillfiles */

//

function openAnon( test )
{
  let self = this;
  let assetName = 'two-anon-exported/.';
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-anon-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( './' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );

  /* */

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
  var opener1 = will.openerMakeManual({ willfilesPath : modulePath });
  let ready1 = opener1.open();
  var opener2 = will.openerMakeManual({ willfilesPath : modulePath + '/' });
  let ready2 = opener2.open();

  /* - */

  ready1.then( ( arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    check( opener1 );
    return null;
  })

  /* - */

  ready1.finally( ( err, arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    test.is( err === undefined );
    opener1.finit();
    if( err )
    throw err;
    return arg;
  });

  /* - */

  ready2.then( ( arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    check( opener2 );
    return null;
  })

  /* - */

  ready2.finally( ( err, arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    test.is( err === undefined );
    opener2.finit();
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake([ ready1, ready2 ])
  .finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  /* - */

  function check( opener )
  {

    let pathMap =
    {
      'current.remote' : null,
      'will' : path.join( __dirname, '../will/Exec' ),
      'local' : abs( './' ),
      'remote' : null,
      'proto' : 'proto',
      'temp' : [ 'super.out', 'sub.out' ],
      'in' : '.',
      'out' : 'super.out',
      'out.debug' : 'super.out/debug',
      'out.release' : 'super.out/release',
      'module.willfiles' : abs([ '.ex.will.yml', '.im.will.yml' ]),
      'module.dir' : abs( '.' ),
      'module.common' : abs( './' ),
      'module.original.willfiles' : abs([ '.ex.will.yml', '.im.will.yml' ]),
      'module.peer.willfiles' : abs( 'super.out/supermodule.out.will.yml' ),
      'module.peer.in' : abs( 'super.out' ),
      'download' : null,
    }

    test.identical( opener.qualifiedName, 'opener::supermodule' );
    test.identical( opener.absoluteName, 'opener::supermodule' );
    test.identical( opener.dirPath, abs( '.' ) );
    test.identical( opener.commonPath, abs( '.' ) + '/' );
    test.identical( _.setFrom( opener.willfilesPath ), _.setFrom( abs([ '.im.will.yml', '.ex.will.yml' ]) ) );
    test.identical( opener.fileName, 'openAnon' );
    test.identical( opener.aliasName, null );
    test.identical( opener.localPath, abs( './' ) );
    test.identical( opener.remotePath, null );
    test.identical( opener.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.mapKeys( opener.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.identical( opener.openedModule.qualifiedName, 'module::supermodule' );
    test.identical( opener.openedModule.absoluteName, 'module::supermodule' );
    test.identical( opener.openedModule.inPath, abs( '.' ) );
    test.identical( opener.openedModule.dirPath, abs( '.' ) );
    test.identical( opener.openedModule.outPath, abs( 'super.out' ) );
    test.identical( opener.openedModule.commonPath, abs( './' ) );
    test.identical( _.setFrom( opener.openedModule.willfilesPath ), _.setFrom( abs([ '.im.will.yml', '.ex.will.yml' ]) ) );
    test.identical( opener.openedModule.localPath, abs( './' ) );
    test.identical( opener.openedModule.remotePath, null );
    test.identical( opener.openedModule.currentRemotePath, null );
    test.identical( opener.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );
    test.identical( opener.openedModule.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.is( !!opener.openedModule.about );
    test.identical( opener.openedModule.about.name, 'supermodule' );
    test.identical( opener.openedModule.pathMap, pathMap );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.submoduleMap ) ), _.setFrom( [ 'Submodule' ] ) );
    test.identical( _.setFrom( _.filter( _.mapKeys( opener.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ) ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug' ] ) );

    let steps = _.select( opener.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( _.setFrom( steps ), _.setFrom( [ 'export.', 'export.debug', 'reflect.submodules.', 'reflect.submodules.debug' ] ) );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.buildMap ) ), _.setFrom( [ 'export.', 'export.debug', 'debug', 'release' ] ) );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.exportedMap ) ), _.setFrom( [] ) );

  }

}

//

function openOutNamed( test )
{
  let self = this;
  let assetName = 'two-exported/super.out/supermodule';
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let moduleDirPath = abs( 'super.out' );
  let moduleFilePath = abs( 'super.out/supermodule' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

  var opener1 = will.openerMakeManual({ willfilesPath : moduleFilePath });
  let ready1 = opener1.open();
  var opener2 = will.openerMakeManual({ willfilesPath : moduleFilePath + '.out' });
  let ready2 = opener2.open();

  /* - */

  ready1.then( ( arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    check( opener1 );
    return null;
  })

  ready1.finally( ( err, arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    test.is( err === undefined );
    opener1.finit();
    if( err )
    throw err;
    return arg;
  });

  /* - */

  ready2.then( ( arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    check( opener2 );
    return null;
  })

  ready2.finally( ( err, arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    test.is( err === undefined );
    opener2.finit();
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake([ ready1, ready2 ])
  .finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  /* - */

  function check( opener )
  {

    let pathMap =
    {
      'current.remote' : null,
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.original.willfiles' :
      [
        abs( './super.ex.will.yml' ),
        abs( './super.im.will.yml' ),
      ],
      'local' : abs( './super.out/supermodule.out' ),
      'remote' : null,
      'proto' : '../proto',
      'temp' : [ '.', '../sub.out' ],
      'in' : '.',
      'out' : '.',
      'out.debug' : 'debug',
      'out.release' : 'release',
      'exported.dir.export.' : 'release',
      'exported.files.export.' : [ 'release', 'release/File.debug.js', 'release/File.release.js' ],
      'exported.dir.export.debug' : 'debug',
      'exported.files.export.debug' : [ 'debug', 'debug/File.debug.js', 'debug/File.release.js' ],
      'module.willfiles' : abs( './super.out/supermodule.out.will.yml' ),
      'module.dir' : abs( './super.out' ),
      'module.common' : abs( './super.out/supermodule.out' ),
      'download' : null,
      'module.peer.in' : abs( '.' ),
      'module.peer.willfiles' :
      [
        abs( './super.ex.will.yml' ),
        abs( './super.im.will.yml' )
      ]
    }

    test.identical( opener.qualifiedName, 'opener::supermodule' );
    test.identical( opener.absoluteName, 'opener::supermodule' );
    test.identical( opener.dirPath, abs( './super.out' ) );
    test.identical( opener.localPath, abs( './super.out/supermodule.out' ) );
    test.identical( opener.willfilesPath, abs( './super.out/supermodule.out.will.yml' ) );
    test.identical( opener.commonPath, abs( 'super.out/supermodule.out' ) );
    test.identical( opener.fileName, 'supermodule.out' );
    test.identical( opener.aliasName, null );

    test.identical( opener.openedModule.qualifiedName, 'module::supermodule' );
    test.identical( opener.openedModule.absoluteName, 'module::supermodule / module::supermodule' );
    test.identical( opener.openedModule.dirPath, abs( './super.out' ) );
    test.identical( opener.openedModule.localPath, abs( './super.out/supermodule.out' ) );
    test.identical( opener.openedModule.willfilesPath, abs( './super.out/supermodule.out.will.yml' ) );
    test.identical( opener.openedModule.commonPath, abs( 'super.out/supermodule.out' ) );
    test.identical( opener.openedModule.fileName, 'supermodule.out' );

    test.is( !!opener.openedModule.about );
    test.identical( opener.openedModule.about.name, 'supermodule' );

    test.identical( opener.openedModule.pathMap, pathMap );
    test.identical( opener.openedModule.willfilesArray.length, 1 );
    test.identical( _.mapKeys( opener.openedModule.willfileWithRoleMap ), [ 'single' ] );
    test.identical( _.mapKeys( opener.openedModule.submoduleMap ), [ 'Submodule' ] );
    test.identical( _.setFrom( _.filter( _.mapKeys( opener.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ) ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug', 'exported.export.debug', 'exported.files.export.debug', 'exported.export.', 'exported.files.export.' ] ) );

    let steps = _.select( opener.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( _.setFrom( steps ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug', 'export.', 'export.debug', 'exported.export.debug', 'exported.files.export.debug', 'exported.export.', 'exported.files.export.' ] ) );

    test.identical( _.setFrom( _.mapKeys( opener.openedModule.buildMap ) ), _.setFrom( [ 'debug', 'release', 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.exportedMap ) ), _.setFrom( [ 'export.', 'export.debug' ] ) );

  }

} /* end of function openOutNamed */

//

function openCurruptedUnknownField( test )
{
  let self = this;
  let assetName = 'corrupted-infile-unknown-field/sub';
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'corrupted-infile-unknown-field' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'sub' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready.then( ( arg ) =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open({ all : 1 });
  })

  /* - */

  .finally( ( err, arg ) =>
  {
    test.is( _.errIs( err ) );
    _.errAttend( err );

    check( opener );

    var exp = [ 'sub' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'sub' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

    opener.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  })

  /* - */

  .finally( ( err, arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    test.is( err === undefined );
    if( err )
    throw err;
    return arg;
  });

  /* - */

  function check( opener )
  {

    let pathMap =
    {

      'in' : '.',
      'out' : 'sub.out',
      'temp' : [ 'sub.out' ],

      'remote' : null,
      'current.remote' : null,
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : abs( '.' ),
      'local' : abs( 'sub' ),
      'module.willfiles' : abs( [ './sub.ex.will.yml', './sub.im.will.yml' ] ),
      'module.original.willfiles' : abs( [ './sub.ex.will.yml', './sub.im.will.yml' ] ),
      'module.peer.willfiles' : abs( 'sub.out.will.yml' ),
      'module.peer.in' : abs( '.' ),
      'module.common' : abs( 'sub' ),
      'download' : null,

    }

    test.identical( opener.qualifiedName, 'opener::sub' );
    test.identical( opener.absoluteName, 'opener::sub' );
    test.identical( opener.fileName, 'sub' );
    test.identical( opener.aliasName, null );
    test.identical( opener.remotePath, null );
    test.identical( opener.dirPath, abs( '.' ) );
    test.identical( opener.commonPath, abs( 'sub' ) );
    test.identical( opener.willfilesPath, abs( [ './sub.ex.will.yml', './sub.im.will.yml' ] ) );
    test.identical( opener.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.mapKeys( opener.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.identical( opener.openedModule.qualifiedName, 'module::sub' );
    test.identical( opener.openedModule.absoluteName, 'module::sub' );
    test.identical( opener.openedModule.inPath, routinePath );
    test.identical( opener.openedModule.dirPath, abs( '.' ) );
    test.identical( opener.openedModule.remotePath, null );
    test.identical( opener.openedModule.currentRemotePath, null );
    test.identical( opener.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );
    test.identical( opener.openedModule.outPath, abs( 'sub.out' ) );
    test.identical( opener.openedModule.commonPath, abs( 'sub' ) );
    test.identical( opener.openedModule.willfilesPath, abs( [ './sub.ex.will.yml', './sub.im.will.yml' ] ) );
    test.identical( opener.openedModule.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.is( !opener.isValid() );
    test.is( !opener.openedModule.isValid() );

    test.is( !!opener.openedModule.about );
    test.identical( opener.openedModule.about.name, 'sub' );
    test.identical( opener.openedModule.pathMap, pathMap );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.submoduleMap ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.filter( _.mapKeys( opener.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ) ), _.setFrom( [] ) );

    let steps = _.select( opener.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( _.setFrom( steps ), _.setFrom( [ 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.buildMap ) ), _.setFrom( [ 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.mapKeys( opener.openedModule.exportedMap ) ), _.setFrom( [] ) );

  }

} /* end of function openCurruptedUnknownField */

//

function openerClone( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'super' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.description = 'open';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open();
  })

  ready.then( ( arg ) =>
  {
    test.case = 'clone';

    test.description = 'paths of module';
    test.identical( rel( opener.openedModule.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.openedModule.dirPath ), '.' );
    test.identical( rel( opener.openedModule.commonPath ), 'super' );
    test.identical( rel( opener.openedModule.inPath ), '.' );
    test.identical( rel( opener.openedModule.outPath ), 'super.out' );
    test.identical( rel( opener.openedModule.localPath ), 'super' );
    test.identical( rel( opener.openedModule.remotePath ), null );
    test.identical( opener.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );

    test.description = 'paths of original opener';
    test.identical( rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.dirPath ), '.' );
    test.identical( rel( opener.commonPath ), 'super' );
    test.identical( rel( opener.localPath ), 'super' );
    test.identical( rel( opener.remotePath ), null );

    var opener2 = opener.clone();

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.mapKeys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.is( !!opener.openedModule );
    test.is( opener2.openedModule === null );

    test.description = 'paths of original opener';
    test.identical( rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.dirPath ), '.' );
    test.identical( rel( opener.commonPath ), 'super' );
    test.identical( rel( opener.localPath ), 'super' );
    test.identical( rel( opener.remotePath ), null );
    test.identical( opener.formed, 5 );

    test.description = 'paths of opener2';
    test.identical( rel( opener2.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener2.dirPath ), '.' );
    test.identical( rel( opener2.commonPath ), 'super' );
    test.identical( rel( opener2.localPath ), 'super' );
    test.identical( rel( opener2.remotePath ), null );
    test.identical( opener2.formed, 0 );

    opener2.close();

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.mapKeys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.is( !!opener.openedModule );
    test.is( opener2.openedModule === null );

    test.description = 'paths of original opener';
    test.identical( rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.dirPath ), '.' );
    test.identical( rel( opener.commonPath ), 'super' );
    test.identical( rel( opener.localPath ), 'super' );
    test.identical( rel( opener.remotePath ), null );

    test.description = 'paths of opener2';
    test.identical( rel( opener2.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener2.dirPath ), '.' );
    test.identical( rel( opener2.commonPath ), 'super' );
    test.identical( rel( opener2.localPath ), 'super' );
    test.identical( rel( opener2.remotePath ), null );

    opener2.find();

    test.case = 'compare elements';
    test.is( opener.openedModule === opener2.openedModule );
    test.identical( opener.qualifiedName, opener2.qualifiedName );
    test.identical( opener.absoluteName, opener2.absoluteName );
    test.is( opener.openedModule.about === opener2.openedModule.about );
    test.is( opener.openedModule.pathMap === opener2.openedModule.pathMap );
    test.identical( opener.openedModule.pathMap, opener2.openedModule.pathMap );
    test.is( opener.willfilesArray !== opener2.willfilesArray );
    test.is( opener.willfileWithRoleMap !== opener2.willfileWithRoleMap );

    test.case = 'finit';
    opener2.finit();
    return null;
  })

  ready.then( ( arg ) =>
  {
    test.case = 'clone extending';

    test.description = 'paths of module';
    test.identical( rel( opener.openedModule.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.openedModule.dirPath ), '.' );
    test.identical( rel( opener.openedModule.commonPath ), 'super' );
    test.identical( rel( opener.openedModule.inPath ), '.' );
    test.identical( rel( opener.openedModule.outPath ), 'super.out' );
    test.identical( rel( opener.openedModule.localPath ), 'super' );
    test.identical( rel( opener.openedModule.remotePath ), null );
    test.identical( opener.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );

    test.description = 'paths of original opener';
    test.identical( rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.dirPath ), '.' );
    test.identical( rel( opener.commonPath ), 'super' );
    test.identical( rel( opener.localPath ), 'super' );
    test.identical( rel( opener.remotePath ), null );

    opener.peerModule.finit();
    var opener2 = opener.cloneExtending({ willfilesPath : abs( 'sub' ) });

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.mapKeys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.is( !!opener.openedModule );
    test.is( opener2.openedModule === null );

    test.description = 'paths of original opener';
    test.identical( rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.dirPath ), '.' );
    test.identical( rel( opener.commonPath ), 'super' );
    test.identical( rel( opener.localPath ), 'super' );
    test.identical( rel( opener.remotePath ), null );

    test.description = 'paths of opener2';
    test.identical( opener2.formed, 0 );
    test.identical( rel( opener2.willfilesPath ), 'sub' );
    test.identical( rel( opener2.dirPath ), '.' );
    test.identical( rel( opener2.commonPath ), 'sub' );
    test.identical( rel( opener2.localPath ), 'sub' );
    test.identical( rel( opener2.downloadPath ), null );
    test.identical( rel( opener2.remotePath ), null );

    opener2.preform();

    test.description = 'paths of opener2';
    test.identical( rel( opener2.willfilesPath ), 'sub' );
    test.identical( rel( opener2.dirPath ), '.' );
    test.identical( rel( opener2.commonPath ), 'sub' );
    test.identical( rel( opener2.localPath ), 'sub' );
    test.identical( rel( opener2.downloadPath ), null );
    test.identical( rel( opener2.remotePath ), null );

    opener2.close();

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.mapKeys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.is( !!opener.openedModule );
    test.is( opener2.openedModule === null );

    test.description = 'paths of original opener';
    test.identical( rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.dirPath ), '.' );
    test.identical( rel( opener.commonPath ), 'super' );
    test.identical( rel( opener.localPath ), 'super' );
    test.identical( rel( opener.remotePath ), null );

    test.description = 'paths of opener2';
    test.identical( rel( opener2.willfilesPath ), 'sub' );
    test.identical( rel( opener2.dirPath ), '.' );
    test.identical( rel( opener2.commonPath ), 'sub' );
    test.identical( rel( opener2.localPath ), 'sub' );
    test.identical( rel( opener2.remotePath ), null );

    opener2.find();

    test.description = 'paths of opener2';
    test.identical( rel( opener2.willfilesPath ), [ 'sub.ex.will.yml', 'sub.im.will.yml' ] );
    test.identical( rel( opener2.dirPath ), '.' );
    test.identical( rel( opener2.commonPath ), 'sub' );
    test.identical( rel( opener2.localPath ), 'sub' );
    test.identical( rel( opener2.remotePath ), null );

    test.case = 'compare elements';
    test.is( opener.openedModule !== opener2.openedModule );
    test.identical( opener2.qualifiedName, 'opener::sub' );
    test.identical( opener2.absoluteName, 'opener::sub' );
    test.is( opener.willfilesArray !== opener2.willfilesArray );
    test.is( opener.willfileWithRoleMap !== opener2.willfileWithRoleMap );

    test.case = 'finit';
    opener2.finit();
    return null;
  })

  /* - */

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );

    opener.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return arg;
  });

  return ready;

} /* end of function openerClone */

openerClone.timeOut = 130000;

//

function moduleClone( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'super' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.description = 'open';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open();
  })

  ready.then( ( arg ) =>
  {
    test.case = 'clone';

    test.description = 'paths of module';
    test.identical( rel( opener.openedModule.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.openedModule.dirPath ), '.' );
    test.identical( rel( opener.openedModule.commonPath ), 'super' );
    test.identical( rel( opener.openedModule.inPath ), '.' );
    test.identical( rel( opener.openedModule.outPath ), 'super.out' );
    test.identical( rel( opener.openedModule.localPath ), 'super' );
    test.identical( rel( opener.openedModule.remotePath ), null );
    test.identical( opener.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );

    test.description = 'paths of original opener';
    test.identical( rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.dirPath ), '.' );
    test.identical( rel( opener.commonPath ), 'super' );
    test.identical( rel( opener.localPath ), 'super' );
    test.identical( rel( opener.remotePath ), null );

    var module = opener.openedModule;
    var opener2 = opener.clone();
    opener2.close();

    var module2 = opener.openedModule.cloneExtending({ willfilesPath : abs( 'super2.out/super.out.will.yml' ), peerModule : null });
    module2.preform();

    mapsCheck( module, module2 )

    test.description = 'stages';
    var stager = module2.stager;
    test.identical( stager.stageStatePerformed( 'preformed' ), true );
    test.identical( stager.stageStatePerformed( 'opened' ), false );
    test.identical( stager.stageStatePerformed( 'attachedWillfilesFormed' ), false );
    test.identical( stager.stageStatePerformed( 'peerModulesFormed' ), false );
    test.identical( stager.stageStatePerformed( 'subModulesFormed' ), false );
    test.identical( stager.stageStatePerformed( 'resourcesFormed' ), false );
    test.identical( stager.stageStatePerformed( 'formed' ), false );

    test.description = 'paths of module2';
    test.identical( rel( module2.willfilesPath ), 'super2.out/super.out.will.yml' );
    test.identical( rel( module2.dirPath ), 'super2.out' );
    test.identical( rel( module2.commonPath ), 'super2.out/super.out' );
    test.identical( rel( module2.inPath ), 'super2.out' );
    test.identical( rel( module2.outPath ), 'super2.out/super.out' );
    test.identical( rel( module2.localPath ), 'super2.out/super.out' );
    test.identical( rel( module2.remotePath ), null );
    test.identical( module2.willPath, path.join( __dirname, '../will/Exec' ) );

    opener2.moduleAdopt( module2 );

    test.description = 'instances';
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub', 'super2.out/super.out' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super', 'sub.out/sub.out', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub', 'super2.out/sub.out/sub.out', 'super2.out/super.out' ];
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.mapKeys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.is( opener.openedModule instanceof _.Will.Module );
    test.is( opener2.openedModule instanceof _.Will.Module );
    test.is( opener.openedModule !== opener2.openedModule );
    test.is( !module.isFinited() );
    test.is( !opener.isFinited() );
    test.is( !module2.isFinited() );
    test.is( !opener2.isFinited() );
    test.is( module.isUsed() );
    test.is( opener.isUsed() );
    test.is( module2.isUsed() );
    test.is( opener2.isUsed() );

    test.description = 'paths of original module';
    test.identical( rel( opener.openedModule.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.openedModule.dirPath ), '.' );
    test.identical( rel( opener.openedModule.commonPath ), 'super' );
    test.identical( rel( opener.openedModule.inPath ), '.' );
    test.identical( rel( opener.openedModule.outPath ), 'super.out' );
    test.identical( rel( opener.openedModule.localPath ), 'super' );
    test.identical( rel( opener.openedModule.remotePath ), null );
    test.identical( opener.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );

    test.description = 'paths of original opener';
    test.identical( rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.dirPath ), '.' );
    test.identical( rel( opener.commonPath ), 'super' );
    test.identical( rel( opener.localPath ), 'super' );
    test.identical( rel( opener.remotePath ), null );

    test.description = 'paths of module2';
    test.identical( rel( opener2.openedModule.willfilesPath ), 'super2.out/super.out.will.yml' );
    test.identical( rel( opener2.openedModule.dirPath ), 'super2.out' );
    test.identical( rel( opener2.openedModule.commonPath ), 'super2.out/super.out' );
    test.identical( rel( opener2.openedModule.inPath ), 'super2.out' );
    test.identical( rel( opener2.openedModule.outPath ), 'super2.out/super.out' );
    test.identical( rel( opener2.openedModule.localPath ), 'super2.out/super.out' );
    test.identical( rel( opener2.openedModule.remotePath ), null );
    test.identical( opener2.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );

    test.description = 'paths of opener2';
    test.identical( rel( opener2.willfilesPath ), 'super2.out/super.out.will.yml' );
    test.identical( rel( opener2.dirPath ), 'super2.out' );
    test.identical( rel( opener2.commonPath ), 'super2.out/super.out' );
    test.identical( rel( opener2.localPath ), 'super2.out/super.out' );
    test.identical( rel( opener2.remotePath ), null );

    opener2.close();

    test.description = 'instances';
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super', 'sub.out/sub.out', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub', 'super2.out/super.out' ];
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.mapKeys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.is( opener.openedModule instanceof _.Will.Module );
    test.is( opener2.openedModule === null );
    test.is( opener.openedModule !== opener2.openedModule );
    test.is( !module.isFinited() );
    test.is( !opener.isFinited() );
    test.is( module2.isFinited() );
    test.is( !opener2.isFinited() );
    test.is( module.isUsed() );
    test.is( opener.isUsed() );
    test.is( !module2.isUsed() );
    test.is( !opener2.isUsed() );

    test.description = 'paths of original module';
    test.identical( rel( opener.openedModule.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.openedModule.dirPath ), '.' );
    test.identical( rel( opener.openedModule.commonPath ), 'super' );
    test.identical( rel( opener.openedModule.inPath ), '.' );
    test.identical( rel( opener.openedModule.outPath ), 'super.out' );
    test.identical( rel( opener.openedModule.localPath ), 'super' );
    test.identical( rel( opener.openedModule.remotePath ), null );
    test.identical( opener.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );

    test.description = 'paths of original opener';
    test.identical( rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.dirPath ), '.' );
    test.identical( rel( opener.commonPath ), 'super' );
    test.identical( rel( opener.localPath ), 'super' );
    test.identical( rel( opener.remotePath ), null );

    test.description = 'paths of opener2';
    test.identical( rel( opener2.willfilesPath ), 'super2.out/super.out.will.yml' );
    test.identical( rel( opener2.dirPath ), 'super2.out' );
    test.identical( rel( opener2.commonPath ), 'super2.out/super.out' );
    test.identical( rel( opener2.localPath ), 'super2.out/super.out' );
    test.identical( rel( opener2.remotePath ), null );

    debugger;
    opener2.finit();
    debugger;
    opener.openedModule = null;

    test.description = 'instances';
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super', 'sub.out/sub.out', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.mapKeys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.is( opener.openedModule === null );
    test.is( opener2.openedModule === null );
    test.is( !module.isFinited() );
    test.is( !opener.isFinited() );
    test.is( module2.isFinited() );
    test.is( opener2.isFinited() );
    test.is( module.isUsed() );
    test.is( !opener.isUsed() );
    test.is( !module2.isUsed() );
    test.is( !opener2.isUsed() );

    test.description = 'paths of original opener';
    test.identical( rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( rel( opener.dirPath ), '.' );
    test.identical( rel( opener.commonPath ), 'super' );
    test.identical( rel( opener.localPath ), 'super' );
    test.identical( rel( opener.remotePath ), null );

    test.description = 'paths of opener2';
    test.identical( rel( opener2.willfilesPath ), 'super2.out/super.out.will.yml' );
    test.identical( rel( opener2.dirPath ), 'super2.out' );
    test.identical( rel( opener2.commonPath ), 'super2.out/super.out' );
    test.identical( rel( opener2.localPath ), 'super2.out/super.out' );
    test.identical( rel( opener2.remotePath ), null );

    test.case = 'finit';
    debugger;
    opener.finit();
    module.finit();
    debugger;
    return null;
  })

  /* - */

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return arg;
  });

  return ready;

  /* */

  function mapsCheck( module1, module2 )
  {

    test.is( module1 !== module2 );
    if( module1 === module2 )
    {
      debugger;
      return;
    }

    mapCheck( module1, module2, 'stepMap' );
    mapCheck( module1, module2, 'buildMap' );
    mapCheck( module1, module2, 'pathResourceMap' );
    mapCheck( module1, module2, 'submoduleMap' );
    mapCheck( module1, module2, 'reflectorMap' );
    mapCheck( module1, module2, 'submoduleMap' );
    mapCheck( module1, module2, 'submoduleMap' );

  }

  /* */

  function mapCheck( module1, module2, mapName )
  {
    test.description = mapName;

    test.is( module1 !== module2 );
    test.is( module1[ mapName ] !== module2[ mapName ] );
    test.identical( _.setFrom( _.mapKeys( module1[ mapName ] ) ), _.setFrom( _.mapKeys( module2[ mapName ] ) ) );
    for( var k in module1[ mapName ] )
    {
      var resource1 = module1[ mapName ][ k ];
      var resource2 = module2[ mapName ][ k ];
      test.is( !!resource1 );
      test.is( !!resource2 );
      if( !resource1 || !resource2 )
      continue;
      if( resource1 === resource2 )
      debugger;
      test.is( resource1 !== resource2 );
      test.is( resource1.module === module1 );
      test.is( resource2.module === module2 );
      if( resource1 instanceof will.Resource )
      {
        test.is( !!resource1.willf || ( resource1.criterion && !!resource1.criterion.predefined ) );
        test.is( resource1.willf === resource2.willf );
      }
    }

  }

} /* end of function moduleClone */

moduleClone.timeOut = 130000;

//

/*
test
  - following exports preserves followed export
  - openers should throw 2 openning errors
*/

function exportSeveralExports( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'inconsistent-outfile' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let subInPath = abs( 'sub' );
  let subOutFilePath = abs( 'sub.out/sub.out.will.yml' );
  let subOutPath = abs( 'sub.out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export debug';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( subOutPath );
    opener = will.openerMakeManual({ willfilesPath : subInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = self.find( subOutPath );
    test.identical( files, exp )

    test.description = 'finit';
    module.finit();
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    test.description = 'should be only 1 error, because 1 attempt to open corrupted outwillfile, 2 times in the list, because for different openers';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 2 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = 'second export debug';
    opener = will.openerMakeManual({ willfilesPath : subInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = self.find( subOutPath );
    test.identical( files, exp )

    test.description = 'finit';
    module.finit();
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export release';
    opener = will.openerMakeManual({ willfilesPath : subInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = self.find( subOutPath );
    test.identical( files, exp )

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = 'second export release';
    opener = will.openerMakeManual({ willfilesPath : subInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = self.find( subOutPath );
    test.identical( files, exp )

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;

} /* end of function exportSeveralExports */

//

function exportSuper( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let superInPath = abs( 'super' );
  let subInPath = abs( 'sub' );
  let superOutFilePath = abs( 'super.out/supermodule.out.will.yml' );
  let subOutFilePath = abs( 'sub.out/sub.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'setup';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( abs( 'super.out' ) );
    _.fileProvider.filesDelete( abs( 'sub.out' ) );

    test.description = 'files';
    var files = self.find( { filePath : { [ routinePath ] : '' } });
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
    ]
    test.identical( files, exp );

    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export sub, first';

    opener = will.openerMakeManual({ willfilesPath : subInPath });

    will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    will.readingBegin();
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'path/*' ) );
    var exp =
    [
      'module.willfiles',
      'module.common',
      'module.original.willfiles',
      'module.peer.willfiles',
      'module.peer.in',
      'download',
      'proto',
      'in',
      'out',
      'out.debug',
      'out.release',
      'temp',
      'exported.dir.export.debug',
      'exported.files.export.debug',
      'exported.dir.export.',
      'exported.files.export.'
    ]
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.mapKeys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'sub.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
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
      './sub.out',
      './sub.out/sub.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './sub.out/release',
      './sub.out/release/File.release.js'
    ]
    test.identical( files, exp );

    opener.finit();
    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export super debug';

    opener = will.openerMakeManual({ willfilesPath : superInPath });

    will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    return opener.open({ subModulesFormed : 1 });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( superOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( _.mapKeys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
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
      './super.out/debug/File.release.js'
    ]
    test.identical( files, exp );

    return null;
  })

  .then( () =>
  {
    let builds = opener.openedModule.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( () =>
  {
    let builds = opener.openedModule.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( superOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( _.mapKeys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
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
    test.identical( files, exp );

    opener.finit();
    return null;
  })

  /* - */

  ready
  .then( ( arg ) =>
  {

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;

} /* end of function exportSuper */

//

function exportSuperIn( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-in-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let superInPath = abs( 'super' );
  let subInPath = abs( 'sub' );
  let superOutFilePath = abs( 'super.out/supermodule.out.will.yml' );
  let subOutFilePath = abs( 'sub.out/sub.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export super debug, without out, without recursion, without peers';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( abs( 'super.out' ) );
    _.fileProvider.filesDelete( abs( 'sub.out' ) );

    opener = will.openerMakeManual({ willfilesPath : superInPath });

    will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    return opener.open({ subModulesFormed : 1 });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    return module.moduleExport({ criterion : { debug : 1 } });
  })

  .finally( ( err, arg ) =>
  {
    var module = opener.openedModule;

    test.is( _.errIs( err ) );
    test.identical( _.strCount( err.message, 'Exporting is impossible because found no out-willfile' ), 1 );
    test.identical( _.strCount( err.message, 'module::supermodule / exported::export.debug' ), 1 );

    test.description = 'files';
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
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
      './super.out',
      './super.out/debug',
      './super.out/debug/File.debug.js',
      './super.out/debug/File.release.js'
    ]
    test.identical( files, exp );

    test.description = 'no error';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 4 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    opener.finit();
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export super debug, without out, without recursion, with peers';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( abs( 'super.out' ) );
    _.fileProvider.filesDelete( abs( 'sub.out' ) );

    opener = will.openerMakeManual({ willfilesPath : superInPath });

    will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
      peerModulesFormedOfMain : 1,
      peerModulesFormedOfSub : 1,
    });

    return opener.open({ subModulesFormed : 1 });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .finally( ( err, arg ) =>
  {
    var module = opener.openedModule;

    test.is( _.errIs( err ) );
    test.identical( _.strCount( err.message, 'Exporting is impossible because found no out-willfile' ), 1 );
    test.identical( _.strCount( err.message, 'module::supermodule / exported::export.debug' ), 1 );

    test.description = 'files';
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
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
      './super.out',
      './super.out/debug',
      './super.out/debug/File.debug.js',
      './super.out/debug/File.release.js'
    ]
    test.identical( files, exp );

    test.description = '1st - attempt to open super.out on opening peer, 2nd - attempt to open super.out on opening peer';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 4 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    opener.finit();
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export sub, then super';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( abs( 'super.out' ) );
    _.fileProvider.filesDelete( abs( 'sub.out' ) );
    opener = will.openerMakeManual({ willfilesPath : subInPath });

    will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    will.readingBegin();
    return opener.open({ subModulesFormed : 1 });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = opener.openedModule.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = opener.openedModule.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = opener.openedModule.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.mapKeys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'sub.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
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
      './sub.out',
      './sub.out/sub.out.will.yml',
      './sub.out/debug',
      './sub.out/debug/File.debug.js',
      './sub.out/release',
      './sub.out/release/File.release.js'
    ]
    test.identical( files, exp );

    test.description = 'two attempts to open out file';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 1 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    opener.finit();
    return null;
  });

  ready
  .then( () =>
  {
    opener = will.openerMakeManual({ willfilesPath : superInPath });
    will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    return opener.open({ subModulesFormed : 1 });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    return module.modulesExport({ criterion : { debug : 1 } });
  })

  .finally( ( err, arg ) =>
  {
    var module = opener.openedModule;
    test.description = 'no error';
    test.is( !_.errIs( err ) );

    test.description = 'files';
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
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
      './super.out/debug/File.release.js'
    ]
    test.identical( files, exp );

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( superOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( _.mapKeys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'two attempts to open super.out';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 2 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    opener.finit();
    return null;
  })

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export super debug, without out and without recursion';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( abs( 'super.out' ) );
    _.fileProvider.filesDelete( abs( 'sub.out' ) );
    opener = will.openerMakeManual({ willfilesPath : superInPath });

    will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    return opener.open({ subModulesFormed : 0 });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    return module.modulesExport({ criterion : { debug : 0 }, recursive : 2 });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    return module.modulesExport({ criterion : { debug : 1 }, recursive : 2 });
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( superOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( _.mapKeys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
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
    test.identical( files, exp );

    test.description = 'errors';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 4 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    opener.finit();
    return null;
  })

  /* - */

  ready
  .then( ( arg ) =>
  {

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;
} /* end of function exportSuperIn */

//

/*
test
  - step module.export use path::export if not defined other
*/

function exportDefaultPath( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'export-default-path' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export willfile with default path';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : abs( 'path' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( _.path.join( outDirPath, 'path.out.will' ) );
    var modulePaths = _.select( outfile.module[ outfile.root[ 0 ] ], 'path/exported.files.export.debug/path' );
    var exp = [ '..', '../File.txt', '../nofile.will.yml', '../nonglob.will.yml', '../nopath.will.yml', '../path.will.yml', '../reflector.will.yml' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    /* zzz : should include out willfile? */

    test.description = 'files';
    var exp = [ '.', './path.out.will.yml' ]
    var files = self.find( outDirPath );
    test.identical( files, exp )

    opener.finit();
    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export willfile with default reflector';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : abs( 'reflector' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( _.path.join( outDirPath, 'reflector.out.will' ) );
    var modulePaths = _.select( outfile.module[ outfile.root[ 0 ] ], 'path/exported.files.export.debug/path' );
    var exp = [ '..', '../File.txt', '../nofile.will.yml', '../nonglob.will.yml', '../nopath.will.yml', '../path.will.yml', '../reflector.will.yml' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './reflector.out.will.yml' ]
    var files = self.find( outDirPath );
    test.identical( files, exp )

    opener.finit();
    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export willfile with no default export path';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : abs( 'nopath' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .finally( ( err, arg ) =>
  {
    var module = opener.openedModule;

    test.is( _.errIs( err ) );
    test.identical( _.strCount( String( err ), 'Failed to export' ), 1 );
    test.identical( _.strCount( String( err ), 'module::nopath / exported::export.debug' ), 1 );
    test.identical( _.strCount( String( err ), 'step::module.export' ), 2 );
    test.identical( _.strCount( String( err ), 'should have defined path or reflector to export. Alternatively module could have defined path::export or reflecotr::export' ), 1 );

    test.description = 'files';
    var exp = []
    var files = self.find( outDirPath );
    test.identical( files, exp )

    opener.finit();
    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export willfile with default export path, no file found';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : abs( 'nofile' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .finally( ( err, arg ) =>
  {
    var module = opener.openedModule;

    test.is( _.errIs( err ) );
    test.identical( _.strCount( String( err ), 'Failed to export' ), 1 );
    test.identical( _.strCount( String( err ), 'module::nofile / exported::export.debug' ), 1 );
    test.identical( _.strCount( String( err ), 'No file found at' ), 1 );

    test.description = 'files';
    var exp = []
    var files = self.find( outDirPath );
    test.identical( files, exp )

    opener.finit();
    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export willfile with default nonglob export path';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : abs( 'nonglob' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .finally( ( err, arg ) =>
  {
    var module = opener.openedModule;

    test.is( err === undefined );

    test.description = 'files';
    var exp = [ '.', './nonglob.out.will.yml' ];
    var files = self.find( outDirPath );
    test.identical( files, exp );

    opener.finit();
    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;

} /* end of function exportDefaultPath */

exportDefaultPath.timeOut = 300000;

//

/*
test
  - outdate outfile should not used to preserve its content
*/

function exportOutdated( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'inconsistent-outfile' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let subInPath = abs( 'sub' );
  let subOutFilePath = abs( 'sub.out/sub.out.will.yml' );
  let subOutPath = abs( 'sub.out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export debug';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( subOutPath );
    opener = will.openerMakeManual({ willfilesPath : subInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = self.find( subOutPath );
    test.identical( files, exp )

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    test.description = '1st attempt to open sub.out on opening, 2nd attempt to open sub.out on exporing';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 2 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export release, but input willfile is changed';
    _.fileProvider.fileAppend( abs( 'sub.ex.will.yml' ), '\n' );
    opener = will.openerMakeManual({ willfilesPath : subInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = self.find( subOutPath );
    test.identical( files, exp )

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    test.description = 'first attempt on opening, second attempt on exporting';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 2 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;

} /* end of function exportOutdated */

//

/*
test
  - recursive exporting generate proper out-willfiels for each module
*/

function exportRecursive( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'resolve-path-of-submodules-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let inPath = abs( 'ab/' );
  let outTerminalPath = abs( 'out/ab/module-ab.out.will.yml' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export debug';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outDirPath );
    opener = will.openerMakeManual({ willfilesPath : inPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    let run = new will.BuildRun
    ({
      build,
      recursive : 2,
      withIntegrated : 2,
    });
    return build.perform({ run });
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( outTerminalPath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'module-ab.out', '../../a', '../module-a.out', '../../b', '../module-b.out', '../../ab/' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'proto.export' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './module-a.out.will.yml', './module-b.out.will.yml', './ab', './ab/module-ab.out.will.yml' ];
    var files = self.find( outDirPath );
    test.identical( files, exp )

    test.description = 'no garbage left';
    opener.finit();
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;

} /* end of function exportRecursive */

//

/*
test
  - dotless anonimous coupled naming works
*/

function exportDotless( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-dotless-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let inPath = abs( './' );
  let outSuperDirPath = abs( 'super.out' );
  let outSubDirPath = abs( 'sub.out' );
  let outSuperTerminalPath = abs( 'super.out/supermodule.out.will.yml' );
  let outSubTerminalPath = abs( 'sub.out/sub.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export debug';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outSuperDirPath );
    _.fileProvider.filesDelete( outSubDirPath );
    opener = will.openerMakeManual({ willfilesPath : inPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    return module.modulesExport({ recursive : 2, kind : 'export', criterion : { debug : 1 } });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    return module.modulesExport({ recursive : 2, kind : 'export', criterion : { debug : 0 } });
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'in-willfile';
    var module = opener.openedModule;
    test.is( !module.isOut );

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
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'super outfile';
    var outfile = _.fileProvider.fileConfigRead( outSuperTerminalPath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'supermodule.out', '../sub/', '../sub.out/sub.out', '../' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'sub outfile';
    var outfile = _.fileProvider.fileConfigRead( outSubTerminalPath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub/' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    will.openersErrorsRemoveAll();
    opener.finit();
    test.description = 'no grabage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );
    return null;
  });

  /* - */

  return ready;

} /* end of function exportDotless */

//

/*
test
  - dotless anonimous single-file naming works
*/

function exportDotlessSingle( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-dotless-single-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let inPath = abs( './' );
  let outSuperDirPath = abs( 'super.out' );
  let outSubDirPath = abs( 'sub.out' );
  let outSuperTerminalPath = abs( 'super.out/supermodule.out.will.yml' );
  let outSubTerminalPath = abs( 'sub.out/sub.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export debug';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outSuperDirPath );
    _.fileProvider.filesDelete( outSubDirPath );
    opener = will.openerMakeManual({ willfilesPath : inPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    return module.modulesExport({ recursive : 2, kind : 'export', criterion : { debug : 1 } });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    return module.modulesExport({ recursive : 2, kind : 'export', criterion : { debug : 0 } });
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'in-willfile';
    var module = opener.openedModule;
    test.is( !module.isOut );

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
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'super outfile';
    var outfile = _.fileProvider.fileConfigRead( outSuperTerminalPath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'supermodule.out', '../sub/', '../sub.out/sub.out', '../' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'sub outfile';
    var outfile = _.fileProvider.fileConfigRead( outSubTerminalPath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub/' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    will.openersErrorsRemoveAll();
    opener.finit();
    test.description = 'no grabage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );
    return null;
  });

  /* - */

  return ready;

} /* end of function exportDotlessSingle */

//

/*
test
  - opts of step are exported and imported properly
*/

function exportStepOpts( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'export-step-opts' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let inPath = abs( 'a' );
  let outTerminalPath = abs( 'out/module-a.out.will.yml' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export debug';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outDirPath );
    opener = will.openerMakeManual({ willfilesPath : inPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'in-willfile';
    var module = opener.openedModule;
    test.is( !module.isOut );
    var exp =
    {
      export : '{path::in}/**',
      tar : 1,
    };
    var got = module.resolve
    ({
      selector : 'step::export.proto',
    });
    test.identical( got.opts, exp );

    test.description = 'out-willfile';
    var module = opener.openedModule.peerModule;
    test.is( !!module.isOut );
    var exp =
    {
      export : '{path::in}/**',
      tar : 1,
    };
    var got = module.resolve
    ({
      selector : 'step::export.proto',
    });
    test.identical( got.opts, exp );

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( outTerminalPath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'module-a.out', '../a' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'proto.export' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var exp =
    {
      'opts' : { 'export' : '{path::in}/**', 'tar' : 1 },
      'inherit' : [ 'module.export' ]
    }
    var got = outfile.module[ 'module-a.out' ].step[ 'export.proto' ];
    test.identical( got, exp );
    var exp =
    {
      'opts' : { 'export' : '{path::in}/**', 'tar' : 1 },
      'inherit' : [ 'module.export' ]
    }
    var got = outfile.module[ '../a' ].step[ 'export.proto' ];
    test.identical( got, exp );

    test.description = 'files';
    var exp = [ '.', './module-a.out.tgs', './module-a.out.will.yml' ];
    var files = self.find( outDirPath );
    test.identical( files, exp )

    opener.finit();
    return null;
  });

  ready
  .then( () =>
  {
    test.case = 'reopen';
    opener = will.openerMakeManual({ willfilesPath : outTerminalPath });
    return opener.open({ all : 1 });
  })

  .then( ( arg ) =>
  {

    test.description = 'out-willfile';
    var module = opener.openedModule;
    test.is( !!module.isOut );
    var exp =
    {
      export : '{path::in}/**',
      tar : 1,
    };
    var got = module.resolve
    ({
      selector : 'step::export.proto',
    });
    test.identical( got.opts, exp );

    test.description = 'in-willfile';
    var module = opener.openedModule.peerModule;
    test.is( !module.isOut );
    var exp =
    {
      export : '{path::in}/**',
      tar : 1,
    };
    var got = module.resolve
    ({
      selector : 'step::export.proto',
    });
    test.identical( got.opts, exp );

    test.description = 'no garbage left';
    opener.finit();
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;

} /* end of function exportStepOpts */

//

/*
test
  - recursive export produce out-willfiles for each module
  - supermodule can use submodule's resources after submodule was exported.
*/

function exportRecursiveUsingSubmodule( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'export-multiple-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let inPath = abs( 'super' );
  let outSuperDirPath = abs( 'super.out' );
  let outSubDirPath = abs( 'sub.out' );
  let outSuperTerminalPath = abs( 'super.out/supermodule.out.will.yml' );
  let outSubTerminalPath = abs( 'sub.out/submodule.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export debug';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outSuperDirPath );
    _.fileProvider.filesDelete( outSubDirPath );
    opener = will.openerMakeManual({ willfilesPath : inPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    return module.modulesExport({ recursive : 2, kind : 'export', criterion : { debug : 1 } });
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'in-willfile';
    var module = opener.openedModule;
    test.is( !module.isOut );

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
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'super outfile';
    var outfile = _.fileProvider.fileConfigRead( outSuperTerminalPath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'supermodule.out', '../', '../sub.out/submodule.out', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'sub outfile';
    var outfile = _.fileProvider.fileConfigRead( outSubTerminalPath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'submodule.out', '../' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    will.openersErrorsRemoveAll();
    opener.finit();
    test.description = 'no grabage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );
    return null;
  });

  /* - */

  return ready;

} /* end of function exportRecursiveUsingSubmodule */

//

function exportSteps( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'export-multiple-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let inPath = abs( 'super' );
  let outSuperDirPath = abs( 'super.out' );
  let outSubDirPath = abs( 'sub.out' );
  let outSuperTerminalPath = abs( 'super.out/supermodule.out.will.yml' );
  let outSubTerminalPath = abs( 'sub.out/submodule.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export debug';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outSuperDirPath );
    _.fileProvider.filesDelete( outSubDirPath );
    opener = will.openerMakeManual({ willfilesPath : inPath });
    return opener.open();
  })

  .then( () =>
  {
    var module = opener.openedModule;
    return module.modulesExport({ recursive : 2, kind : 'export', criterion : { debug : 1 } });
    /* zzz : make possible drop criterion to export multiple exports */
  })

  .then( () =>
  {
    var module = opener.openedModule;
    return module.modulesExport({ recursive : 2, kind : 'export', criterion : { debug : 0 } });
  })

  .then( () =>
  {
    var module = opener.openedModule;
    return module.peerModule.upform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

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
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'super outfile';
    var outfile = _.fileProvider.fileConfigRead( outSuperTerminalPath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'supermodule.out', '../', '../sub.out/submodule.out', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var steps = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'step/*' ) );
    var exp = [ 'export.', 'export.debug', 'reflect.submodules.', 'reflect.submodules.debug' ];
    test.identical( _.setFrom( steps ), _.setFrom( exp ) );

    test.description = 'sub outfile';
    var outfile = _.fileProvider.fileConfigRead( outSubTerminalPath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'submodule.out', '../' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var steps = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'step/*' ) );
    var exp = [ 'export.', 'export.debug', 'reflect.proto.', 'reflect.proto.debug' ];
    test.identical( _.setFrom( steps ), _.setFrom( exp ) );

    test.description = 'in-willfile';
    var module = opener.openedModule;
    test.is( !module.isOut );
    var got = module.resolve
    ({
      selector : 'step::*export*',
    });
    var exp = [ 'step::module.export', 'step::export.', 'step::export.debug' ];
    var names = _.select( got, '*/qualifiedName' )
    test.identical( names, exp );
    var exp =
    [
      { "export" : null, "tar" : 0 },
      { "export" : `{path::out.*=1}/**`, "tar" : 1 },
      { "export" : `{path::out.*=1}/**`, "tar" : 1 },
    ]
    var opts = _.select( got, '*/opts' )
    test.identical( opts, exp );

    test.description = 'out-willfile';
    var module = opener.openedModule.peerModule;
    test.is( !!module.isOut );
    var got = module.resolve
    ({
      selector : 'step::*export*',
    });
    var exp = [ 'step::module.export', 'step::export.', 'step::export.debug' ];
    var names = _.select( got, '*/qualifiedName' )
    test.identical( names, exp );
    var exp =
    [
      { "export" : null, "tar" : 0 },
      { "export" : `{path::out.*=1}/**`, "tar" : 1 },
      { "export" : `{path::out.*=1}/**`, "tar" : 1 },
    ]
    var opts = _.select( got, '*/opts' )
    test.identical( opts, exp );

    will.openersErrorsRemoveAll();
    opener.finit();
    return null;
  });

  /* - */

  return ready;

} /* end of function exportSteps */

//

/*
test
  - corrupted outfile is not a problem to reexport a module
  - try to open corrupted out file only 1 time
  - does not try to open corrupted file during reset opening options
*/

function exportCourrputedOutfileUnknownSection( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'corrupted-outfile-unknown-section' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let subInPath = abs( 'sub' );
  let subOutFilePath = abs( 'sub.out/sub.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export sub';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

    opener = will.openerMakeManual({ willfilesPath : subInPath });

    will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    will.readingBegin();

    return opener.open({ all : 0, peerModulesFormed : 1 });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    return opener.open({ all : 1 });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.mapKeys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'sub.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    test.description = '1st attempt to open sub.out on opening, 2nd attempt to open sub.out on exporing';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 2 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;

} /* end of function exportCourrputedOutfileUnknownSection */

//

/*
test
  - corrupted outfile with syntax error is not a problem to reexport a module
  - try to open corrupted out file only 1 time
  - does not try to open corrupted file during reset opening options
*/

function exportCourruptedOutfileSyntax( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'corrupted-outfile-syntax' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let subInPath = abs( 'sub' );
  let subOutFilePath = abs( 'sub.out/sub.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export sub';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

    opener = will.openerMakeManual({ willfilesPath : subInPath });

    will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    will.readingBegin();

    return opener.open({ all : 0, peerModulesFormed : 1 });
  })

  .then( () =>
  {
    return opener.open({ all : 1 });
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.mapKeys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'sub.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    test.description = '1st attempt to open sub.out on opening, 2nd attempt to open sub.out on exporing';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 2 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;

} /* end of function exportCourruptedOutfileSyntax */

//

/*
test
  - exporing of module with disabled corrupted submodules works
  - Disabled modules are not in default submodules
*/

function exportCourruptedSubmodulesDisabled( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'corrupted-submodules-disabled' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let superInPath = abs( 'super' );
  let superOutFilePath = abs( 'super.out/supermodule.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export super';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });

    opener = will.openerMakeManual({ willfilesPath : superInPath });

    will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    will.readingBegin();

    return opener.open({ all : 0, peerModulesFormed : 1 });
  })

  .then( () =>
  {
    return opener.open({ all : 1 });
  })

  .then( () =>
  {
    let module = opener.openedModule;

    test.case = 'modulesEach';
    var exp = [];
    var got = opener.openedModule.modulesEach({ outputFormat : '/' });
    var commonPath = _.filter( got, ( e ) => e.opener ? e.opener.commonPath : e.module.commonPath );
    test.identical( commonPath, exp );

    test.case = 'modulesEach, withDisabled';
    var got = opener.openedModule.modulesEach({ outputFormat : '/', withDisabledSubmodules : 1 });
    // var exp = [];
    var exp =
    [
      '.module/Submodule1/',
      '.module/Submodule2/',
      '.module/Submodule3/',
    ];
    var localPath = _.filter( got, ( e ) => e.localPath );
    test.identical( localPath, abs( exp ) );
    var got = opener.openedModule.modulesEach({ outputFormat : '/', withDisabledSubmodules : 1 });
    // var exp = [];
    var exp =
    [
      '.module/Submodule1',
      '.module/Submodule2',
      '.module/Submodule3',
    ];
    var localPath = _.filter( got, ( e ) => e.opener.downloadPath );
    test.identical( localPath, abs( exp ) );
    // var exp = [];
    var exp =
    [
      'git+https:///github.com/X1/X1.git#master',
      'git+https:///github.com/X2/X2.git#master',
      'git+https:///github.com/X3/X3.git#master',
    ];
    var remotePath = _.filter( got, ( e ) => e.remotePath );
    test.identical( remotePath, exp );

    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( superOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'supermodule.out', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    test.description = '1st attempt to open sub.out on opening, 2nd attempt to open sub.out on exporing';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 2 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;
} /* end of function exportCourruptedSubmodulesDisabled */

//

function exportCourrputedSubmoduleOutfileUnknownSection( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'corrupted-submodule-outfile-unknown-section' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let superInPath = abs( 'super' );
  let subInPath = abs( 'sub' );
  let superOutFilePath = abs( 'super.out/supermodule.out.will.yml' );
  let subOutFilePath = abs( 'sub.out/sub.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export super';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : superInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .finally( ( err, arg ) =>
  {
    var module = opener.openedModule;

    test.is( _.errIs( err ) );

    test.description = 'files';
    var exp = [ '.', './sub.ex.will.yml', './sub.im.will.yml', './super.ex.will.yml', './super.im.will.yml', './sub.out', './sub.out/sub.out.will.yml' ]
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    test.description = 'should be only 2 errors, 1 attempt to open corrupted sub.out and 2 attempts to open super.out which does not exist';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 3 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export super, recursive : 2';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : superInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    let run = new will.BuildRun
    ({
      build,
      recursive : 2,
      withIntegrated : 2,
    });
    return build.perform({ run });
  })

  .finally( ( err, arg ) =>
  {
    var module = opener.openedModule;

    test.is( err === undefined );

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.mapKeys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'sub.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './sub.out',
      './sub.out/sub.out.will.yml',
      './super.out',
      './super.out/supermodule.out.will.yml'
    ]
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    test.description = '2 attempts to open super.out, 2 attempts to open sub.out, but the same instance';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 4 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;

} /* end of function exportCourrputedSubmoduleOutfileUnknownSection */

exportCourrputedSubmoduleOutfileUnknownSection.description =
`
  - no extra errors made
  - corrupted outfile of submodule is not a problem
  - recursive export works
`

//

/*
test
  - no extra errors made
  - outfile of submodule with not-supported version of format is not a problem
  - recursive export works
*/

function exportCourrputedSubmoduleOutfileFormatVersion( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'corrupted-submodule-outfile-format-version' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let superInPath = abs( 'super' );
  let subInPath = abs( 'sub' );
  let superOutFilePath = abs( 'super.out/supermodule.out.will.yml' );
  let subOutFilePath = abs( 'sub.out/sub.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export super';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : superInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .finally( ( err, arg ) =>
  {
    var module = opener.openedModule;

    test.is( _.errIs( err ) );

    test.description = 'files';
    var exp = [ '.', './sub.ex.will.yml', './sub.im.will.yml', './super.ex.will.yml', './super.im.will.yml', './sub.out', './sub.out/sub.out.will.yml' ]
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    test.description = '2 attempts to open corrupted sub.out and 2 attempts to open super.out which does not exist';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 4 );
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* */

  ready
  .then( () =>
  {
    test.case = 'export super, recursive : 2';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : superInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    let run = new will.BuildRun
    ({
      build,
      recursive : 2,
      withIntegrated : 2,
    });
    return build.perform({ run });
  })

  .finally( ( err, arg ) =>
  {
    var module = opener.openedModule;
    test.description = 'no error';
    test.is( err === undefined );

    test.description = 'outfile';
    var outfile = _.fileProvider.fileConfigRead( subOutFilePath );
    var modulePaths = _.mapKeys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.mapKeys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.mapKeys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.mapKeys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'sub.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './sub.out',
      './sub.out/sub.out.will.yml',
      './super.out',
      './super.out/supermodule.out.will.yml'
    ]
    var files = self.find({ filePath : { [ routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    test.description = 'unique errors';
    test.identical( _.longOnce( _.select( will.openersErrorsArray, '*/err' ) ).length, 5 );
    /*
      1 - attempt to open super.out on opening
      2 - attempt to open sub.out on opening
      3 - attempt to open sub.out on _performSubmodulesPeersOpen
      5 - attempt to open sub.out on _performReadExported
      6 - attempt to open super.out on _performReadExported
    */
    will.openersErrorsRemoveAll();
    test.identical( will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return ready;

} /* end of function exportCourrputedSubmoduleOutfileFormatVersion */

//

function exportsResolve( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'corrupted-submodule-outfile-unknown-section' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let superInPath = abs( 'super' );
  let subInPath = abs( 'sub' );
  let superOutFilePath = abs( 'super.out/supermodule.out.will.yml' );
  let subOutFilePath = abs( 'sub.out/sub.out.will.yml' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : subInPath });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;

    test.case = 'default';
    var builds = module.exportsResolve();
    test.identical( _.setFrom( _.select( builds, '*/name' ) ), _.setFrom( [ 'export.', 'export.debug' ] ) );

    test.case = 'debug : 1';
    var builds = module.exportsResolve({ criterion : { debug : 1 } });
    test.identical( _.setFrom( _.select( builds, '*/name' ) ), _.setFrom( [ 'export.debug' ] ) );

    test.case = 'raw : 1, strictCriterion : 1';
    var builds = module.exportsResolve({ criterion : { raw : 1 }, strictCriterion : 1 });
    test.identical( _.setFrom( _.select( builds, '*/name' ) ), _.setFrom( [] ) );

    test.case = 'raw : 1, strictCriterion : 0';
    var builds = module.exportsResolve({ criterion : { raw : 1 }, strictCriterion : 0 });
    test.identical( _.setFrom( _.select( builds, '*/name' ) ), _.setFrom( [ 'export.', 'export.debug' ] ) );

    opener.finit();
    return null;
  })

  /* - */

  return ready;

} /* end of function exportsResolve */

//

function buildsResolve( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'export-multiple' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'super' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outDirPath );
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open();
  })

  ready.then( ( arg ) =>
  {

    test.case = 'build::*'; /* */

    var resolved = opener.openedModule.resolve({ selector : 'build::*' });
    test.identical( resolved.length, 4 );

    var expected = [ 'debug', 'release', 'export.', 'export.debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( _.setFrom( got ), _.setFrom( expected ) );

    var expected =
    [
      [ 'build::*=1', 'step::export*=1' ],
      [ 'build::*=1', 'step::export*=1' ],
      [ 'step::submodules.download', 'step::reflect.submodules.*=1' ],
      [ 'step::submodules.download', 'step::reflect.submodules.*=1' ],
    ];
    var got = _.select( resolved, '*/steps' );
    test.identical( got, expected );

    test.case = 'build::*, with criterion'; /* */

    var resolved = opener.openedModule.resolve({ selector : 'build::*', criterion : { debug : 1 } });
    test.identical( resolved.length, 2 );

    var expected = [ 'debug', 'export.debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( _.setFrom( got ), _.setFrom( expected ) );

    test.case = 'build::*, currentContext is build::export.'; /* */

    var build = opener.openedModule.resolve({ selector : 'build::export.' });
    test.is( build instanceof will.Build );
    test.identical( build.qualifiedName, 'build::export.' );
    test.identical( build.absoluteName, 'module::supermodule / build::export.' );

    var resolved = opener.openedModule.resolve({ selector : 'build::*', currentContext : build, singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'release' ];
    var got = _.select( resolved, '*/name' );
    test.identical( _.setFrom( got ), _.setFrom( expected ) );

    var expected = { 'debug' : 0 };
    var got = resolved[ 0 ].criterion;
    test.identical( got, expected );

    test.case = 'build::*, currentContext is build::export.debug'; /* */

    var build = opener.openedModule.resolve({ selector : 'build::export.debug' });
    var resolved = opener.openedModule.resolve({ selector : 'build::*', currentContext : build, singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    var expected = { 'debug' : 1, 'default' : 1 };
    var got = resolved[ 0 ].criterion;
    test.identical( got, expected );

    test.case = 'build::*, currentContext is build::export.debug, short-cut'; /* */

    var build = opener.openedModule.resolve({ selector : 'build::export.debug' });
    var resolved = build.resolve({ selector : 'build::*', singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    test.case = 'build::*, short-cut, explicit criterion'; /* */

    var build = opener.openedModule.resolve({ selector : 'build::export.*', criterion : { debug : 1 } });
    var resolved = build.resolve({ selector : 'build::*', singleUnwrapping : 0, criterion : { debug : 0 } });
    test.identical( resolved.length, 2 );

    var expected = [ 'release', 'export.' ];
    var got = _.select( resolved, '*/name' );
    test.identical( _.setFrom( got ), _.setFrom( expected ) );

    return null;
  })

  /* - */

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  return ready;
} /* end of function buildsResolve */

buildsResolve.timeOut = 130000;

//

function trivialResolve( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'make' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'v1' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    return abs( '', filePath );
  }

  function pout( filePath )
  {
    return abs( 'out', filePath );
  }

  /* - */

  ready
  .then( () =>
  {
    test.case = 'export super';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open();
  })

  .then( () =>
  {

    test.case = 'array of numbers';
    var module = opener.openedModule;
    var got = module.resolve
    ({
      selector : [ 1, 3 ],
      prefixlessAction : 'resolved',
    });
    var expected = [ 1, 3 ];
    test.identical( got, expected );

    return null;
  })

  .finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    var module = opener.openedModule;
    opener.finit();
    return arg;
  })

  /* - */

  return ready;
} /* end of function trivialResolve */

//

function detailedResolve( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let inPath = abs( 'super' );
  let outSuperDirPath = abs( 'super.out' );
  let outSubDirPath = abs( 'sub.out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : inPath });
    return opener.open({ all : 1 });
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.case = 'step::*export*';
    var exp =
    [
      'module::supermodule / step::module.export',
      'module::supermodule / step::export.',
      'module::supermodule / step::export.debug'
    ];
    var got = module.resolve( 'step::*export*' );
    test.identical( _.setFrom( _.select( got, '*/absoluteName' ) ), _.setFrom( exp ) );

    test.case = 'step::*export*/absoluteName';
    var exp =
    [
      'module::supermodule / step::module.export',
      'module::supermodule / step::export.',
      'module::supermodule / step::export.debug'
    ];
    var got = module.resolve( 'step::*export*/absoluteName' );
    test.identical( _.setFrom( got ), _.setFrom( exp ) );

    will.openersErrorsRemoveAll();
    opener.finit();
    return null;
  });

  /* - */

  return ready;

} /* end of function detailedResolve */

//

function reflectorResolve( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'composite-reflector' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( './' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    return abs( filePath );
  }

  function pout( filePath )
  {
    return abs( 'super.out', filePath );
  }

  // _.fileProvider.filesDelete( routinePath );
  // _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
  // _.fileProvider.filesDelete( outDirPath );
  //
  // var module = will.openerMakeManual({ willfilesPath : modulePath });

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outDirPath );
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open();
  })

  ready.then( ( arg ) =>
  {

    test.case = 'reflector::reflect.proto.0.debug formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.0.debug' )
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'maskAll' : { 'excludeAny' : true },
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out/debug' },
      'criterion' : { 'debug' : 1, 'variant' : 0 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1
    }
    resolved.form();
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.0.debug';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.0.debug' )
    var expected =
    {
      'src' :
      {
        'filePath' : { 'path::proto' : 'path::out.*=1' }
      },
      'criterion' : { 'debug' : 1, 'variant' : 0 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1
    }
    resolved.form();
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.1.debug formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.1.debug' )
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'maskAll' : { 'excludeAny' : true },
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out/debug' },
      'criterion' : { 'debug' : 1, 'variant' : 1 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1,
    }
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.1.debug';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.1.debug' )
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { 'path::proto' : 'path::out.*=1' }
      },
      'criterion' : { 'debug' : 1, 'variant' : 1 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1,
    }

    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.2.debug formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.2.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'maskAll' : { 'excludeAny' : true },
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out/debug' },
      'criterion' : { 'debug' : 1, 'variant' : 2 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1,
    }
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.2.debug';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.2.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { 'path::proto' : 'path::out.*=1' }
      },
      'criterion' : { 'debug' : 1, 'variant' : 2 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1,
    }
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.3.debug formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.3.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'maskAll' : { 'excludeAny' : true },
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out/debug' },
      'criterion' : { 'debug' : 1, 'variant' : 3 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1,
    }
    var resolvedData = resolved.exportStructure({ formed:1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.3.debug';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.3.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { '{path::proto}' : '{path::out.*=1}' }
      },
      'criterion' : { 'debug' : 1, 'variant' : 3 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1,
    }
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.4.debug formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.4.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'maskAll' : { 'excludeAny' : true },
        'prefixPath' : 'proto/dir2',
      },
      'dst' : { 'prefixPath' : 'out/debug/dir1' },
      'criterion' : { 'debug' : 1, 'variant' : 4 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1,
    }
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1' ) );

    test.case = 'reflector::reflect.proto.4.debug';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.4.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { '{path::proto}/{path::dir2}' : '{path::out.*=1}/{path::dir1}' }
      },
      'criterion' : { 'debug' : 1, 'variant' : 4 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1,
    }
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1' ) );

    test.case = 'reflector::reflect.proto.5.debug formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.5.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'maskAll' : { 'excludeAny' : true },
        'prefixPath' : 'proto/dir2',
      },
      'dst' : { 'prefixPath' : 'out/debug/dir1' },
      'criterion' : { 'debug' : 1, 'variant' : 5 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1
    }
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1' ) );

    test.case = 'reflector::reflect.proto.5.debug';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.5.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'prefixPath' : '{path::proto}/{path::dir2}'
      },
      'dst' : { 'prefixPath' : '{path::out.*=1}/{path::dir1}' },
      'criterion' : { 'debug' : 1, 'variant' : 5 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1
    }
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1' ) );

    test.case = 'reflector::reflect.proto.6.debug formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.6.debug' );
    resolved.form();
    var expected =
    {
      'src' : { 'prefixPath' : 'proto/dir2/File.test.js' },
      'dst' : { 'prefixPath' : 'out/debug/dir1/File.test.js' },
      'criterion' : { 'debug' : 1, 'variant' : 6 },
      'mandatory' : 1
    }
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1/File.test.js' ) );

    test.case = 'reflector::reflect.proto.6.debug';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.6.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'prefixPath' : '{path::proto}/{path::dir2}/{path::testFile}'
      },
      'dst' :
      {
        'prefixPath' : '{path::out.*=1}/{path::dir1}/{path::testFile}'
      },
      'criterion' : { 'debug' : 1, 'variant' : 6 },
      'mandatory' : 1
    }
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1/File.test.js' ) );

    test.case = 'reflector::reflect.proto.7.debug formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.7.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'prefixPath' : 'proto/dir2/File.test.js',
      },
      'dst' : { 'prefixPath' : 'out/debug/dir1/File.test.js' },
      'criterion' : { 'debug' : 1, 'variant' : 7 },
      'mandatory' : 1,
    }
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1/File.test.js' ) );

    test.case = 'reflector::reflect.proto.7.debug';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.7.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' :
        {
          '{path::proto}/{path::dir2}/{path::testFile}' : '{path::out.*=1}/{path::dir1}/{path::testFile}'
        }
      },
      'criterion' : { 'debug' : 1, 'variant' : 7 },
      'mandatory' : 1,
    }
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1/File.test.js' ) );

    return null;
  });

  /* - */

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  return ready;
}

//

function reflectorInheritedResolve( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'reflect-inherit' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( './' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    return abs( filePath );
  }

  function pout( filePath )
  {
    return abs( 'super.out', filePath );
  }

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outDirPath );
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open();
  })

  ready.then( ( arg ) =>
  {

    test.case = 'reflector::reflect.proto1 formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto1' )
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out/debug1' },
      'mandatory' : 1
    }
    resolved.form();
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto2 formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto2' )
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out/debug2' },
      'mandatory' : 1,
      'inherit' : [ 'reflect.proto1' ]
    }
    resolved.form();
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto3 formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto3' )
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out/debug1' },
      'mandatory' : 1,
      'inherit' : [ 'reflect.proto1' ]
    }
    resolved.form();
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto4 formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto4' )
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out/debug2' },
      'mandatory' : 1,
      'inherit' : [ 'reflect.proto1' ]
    }
    resolved.form();
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto5 formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto5' )
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out/debug2' },
      'mandatory' : 1,
      'inherit' : [ 'reflect.proto1' ]
    }
    resolved.form();
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.not.test.only.js.v1 formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.not.test.only.js.v1' )
    var expected =
    {
      'src' :
      {
        'filePath' :
        {
          '.' : [ 'debug1', 'debug2' ],
          '../**.js' : true,
          '../**.test**' : false,
        },
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out' },
      'mandatory' : 1,
      'inherit' : [ 'not.test', 'only.js' ]
    }
    resolved.form();
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.files1 formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.files1' )
    var expected =
    {
      'src' :
      {
        'filePath' : { 'File.js' : '.', 'File.s' : '.' },
        'basePath' : '.',
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out' },
      'mandatory' : 1,
      'inherit' : [ 'reflector::files3' ]
    }
    resolved.form();
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.files2 formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.files2' )
    var expected =
    {
      'src' :
      {
        'filePath' : { 'File.js' : '.', 'File.s' : '.' },
        'basePath' : '.',
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out' },
      'mandatory' : 1,
      'inherit' : [ 'reflector::files3' ]
    }
    resolved.form();
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.files3 formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.files3' )
    var expected =
    {
      'src' :
      {
        'filePath' : { 'File.js' : '.', 'File.s' : '.' },
        'basePath' : '.',
        'prefixPath' : 'proto'
      },
      'dst' : { 'prefixPath' : 'out' },
      'mandatory' : 1,
      'inherit' : [ 'reflector::files3' ]
    }
    resolved.form();
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    return null;
  });

  /* - */

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  return ready;
}

//

function superResolve( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-in-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'super' );
  let submodulesPath = abs( '.module' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    // _.fileProvider.filesDelete( abs( 'super.out' ) );
    // _.fileProvider.filesDelete( abs( 'sub.out' ) );
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    // debugger;
    return opener.open({ all : 1 });
  })

  ready.then( ( arg ) =>
  {

    test.case = 'build::*';
    var resolved = opener.openedModule.resolve( 'build::*' ); debugger;
    test.identical( resolved.length, 4 );

    test.case = '*::*a*';
    debugger;
    var resolved = opener.openedModule.resolve
    ({
      selector : '*::*a*',
      pathUnwrapping : 0,
      missingAction : 'undefine',
    });
    debugger;
    test.identical( resolved.length, 18 );
    debugger;

    test.case = '*::*a*/qualifiedName';
    var exp =
    [
      'path::module.original.willfiles',
      'path::download',
      'path::local',
      'path::out.release',
      'reflector::predefined.release.v1',
      'reflector::predefined.release.v2',
      'step::timelapse.begin',
      'step::timelapse.end',
      'step::files.transpile',
      'step::npm.generate',
      'step::submodules.download',
      'step::submodules.update',
      'step::submodules.agree',
      'step::submodules.are.updated',
      'step::submodules.reload',
      'step::submodules.clean',
      'step::clean',
      'build::release'
    ]
    var resolved = opener.openedModule.resolve
    ({
      selector : '*::*a*/qualifiedName',
      pathUnwrapping : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      missingAction : 'undefine',
    });
    test.identical( _.setFrom( resolved ), _.setFrom( exp ) );

    test.case = '*';
    var resolved = opener.openedModule.resolve
    ({
      selector : '*',
      pathUnwrapping : 1,
      pathResolving : 0
    });
    test.identical( resolved, '*' );

    test.case = '*::*';
    var resolved = opener.openedModule.resolve
    ({
      selector : '*::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : 0,
    });
    test.ge( resolved.length, 40 );

    test.case = '* + defaultResourceKind';
    var resolved = opener.openedModule.resolve
    ({
      selector : '*',
      defaultResourceKind : 'path',
      prefixlessAction : 'default',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : 0,
    });
    test.ge( resolved.length, 13 );

    return null;
  })

  /* - */

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  return ready;
}

superResolve.timeOut = 130000;

//

function pathsResolve( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'export-multiple' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'super' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let execPath = _.path.join( __dirname, '../will/Exec' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    if( _.arrayIs( filePath ) )
    return filePath.map( ( e ) => abs( e ) );
    return abs( filePath );
  }

  function pout( filePath )
  {
    if( _.arrayIs( filePath ) )
    return filePath.map( ( e ) => abs( 'super.out', e ) );
    return abs( 'super.out', filePath );
  }

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outDirPath );
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open();
  })

  ready.then( ( arg ) =>
  {

    test.case = 'resolved, .';
    var resolved = opener.openedModule.resolve({ prefixlessAction : 'resolved', selector : '.' })
    var expected = '.';
    test.identical( resolved, expected );

    return null;
  })

  ready.then( ( arg ) =>
  {

    test.case = 'path::in*=1, pathResolving : 0';
    var resolved = opener.openedModule.resolve({ prefixlessAction : 'resolved', selector : 'path::in*=1', pathResolving : 0 })
    var expected = '.';
    test.identical( resolved, expected );

    test.case = 'path::in*=1';
    var resolved = opener.openedModule.resolve({ prefixlessAction : 'resolved', selector : 'path::in*=1' })
    var expected = routinePath;
    test.identical( resolved, expected );

    test.case = 'path::out.debug';
    var resolved = opener.openedModule.resolve( 'path::out.debug' )
    var expected = pin( 'super.out/debug' );
    test.identical( resolved, expected );

    test.case = '[ path::out.debug, path::out.release ]';
    var resolved = opener.openedModule.resolve( [ 'path::out.debug', 'path::out.release' ] );
    var expected = pin([ 'super.out/debug', 'super.out/release' ]);
    test.identical( resolved, expected );

    test.case = '{path::in*=1}/proto, pathNativizing : 1';
    var resolved = opener.openedModule.resolve({ selector : '{path::in*=1}/proto', pathNativizing : 1, selectorIsPath : 1 });
    var expected = _.path.nativize( pin( 'proto' ) );
    test.identical( resolved, expected );

    test.case = '{path::in*=1}/proto, pathNativizing : 1';
    var resolved = opener.openedModule.resolve({ selector : '{path::in*=1}/proto', pathNativizing : 1, selectorIsPath : 0 });
    var expected = _.path.nativize( pin( '.' ) ) + '/proto';
    test.identical( resolved, expected );

    return null;
  })

  /* - */

  ready.then( ( arg ) =>
  {

    test.case = 'nativizing'; /* */
    var resolved = opener.openedModule.resolve({ selector : 'path::*', pathNativizing : 1, selectorIsPath : 0 });
    var expected =
    [
      'super.ex.will.yml',
      'super.im.will.yml',
      'super.ex.will.yml',
      'super.im.will.yml',
      'super.out/supermodule.out.will.yml',
      'super.out',
      '.',
      'super',
      null,
      'super',
      null,
      null,
      rel( execPath ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = resolved;
    test.identical( _.setFrom( got ), _.setFrom( _.filter( abs( expected ), ( p ) => p ? _.path.s.nativize( p ) : p ) ) );

    test.case = 'path::* - implicit'; /* */
    var resolved = opener.openedModule.resolve( 'path::*' );
    var expected =
    [
      'super.ex.will.yml',
      'super.im.will.yml',
      'super.ex.will.yml',
      'super.im.will.yml',
      'super.out/supermodule.out.will.yml',
      'super.out',
      '.',
      'super',
      null,
      'super',
      null,
      null,
      rel( execPath ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = resolved;
    test.identical( _.setFrom( rel( got ) ), _.setFrom( expected ) );

    test.case = 'path::* - pu:1 mvu:1 pr:in'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
      pathResolving : 'in',
    });
    var expected =
    [
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'super.out/supermodule.out.will.yml',
      'super.out',
      '.',
      'super',
      null,
      'super',
      null,
      null,
      rel( execPath ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = resolved;
    test.identical( rel( got ), expected );

    test.case = 'path::* - pu:1 mvu:1 pr:out'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
      pathResolving : 'out',
    });
    var expected =
    [
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'super.out/supermodule.out.will.yml',
      'super.out',
      '.',
      'super',
      null,
      'super',
      null,
      null,
      rel( execPath ),
      'super.out/proto',
      'super.out/super.out',
      'super.out',
      'super.out',
      'super.out/super.out/debug',
      'super.out/super.out/release'
    ]
    var got = resolved;
    test.identical( rel( got ), expected );

    test.case = 'path::* - pu:1 mvu:1 pr:null'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
      pathResolving : null,
    });
    var expected =
    [
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'super.out/supermodule.out.will.yml',
      'super.out',
      '.',
      'super',
      null,
      'super',
      null,
      null,
      rel( execPath ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = resolved;
    test.identical( rel( got ), expected );

    test.case = 'path::* - pu:0 mvu:0 pr:null'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
      pathResolving : null,
    });
    var expected =
    {
      'proto' : 'proto',
      'temp' : 'super.out',
      'in' : '.',
      'out' : 'super.out',
      'out.debug' : 'super.out/debug',
      'out.release' : 'super.out/release',
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : abs( '.' ),
      'module.willfiles' : abs([ 'super.ex.will.yml', 'super.im.will.yml' ]),
      'module.peer.willfiles' : abs( 'super.out/supermodule.out.will.yml' ),
      'module.common' : abs( 'super' ),
      'module.peer.in' : abs( 'super.out' ),
      'module.original.willfiles' : abs([ 'super.ex.will.yml', 'super.im.will.yml' ]),
      'local' : abs( 'super' ),
      'download' : null,
      'remote' : null,
      'current.remote' : null,
    }
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );
    // _.any( resolved, ( e, k ) => test.is( e.identicalWith( opener.openedModule.pathResourceMap[ k ] ) ) );
    _.any( resolved, ( e, k ) => test.identical( e.path, opener.openedModule.pathResourceMap[ k ].path ) );
    _.any( resolved, ( e, k ) => test.is( e.module === module || e.module === opener.openedModule ) );
    _.any( resolved, ( e, k ) => test.is( !!e.original ) );
    test.is( _.path.isAbsolute( got.will ) );

    test.case = 'path::* - pu:0 mvu:0 pr:in'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 0,
      pathResolving : 'in',
    });
    var expected =
    {
      'proto' : ( 'proto' ),
      'temp' : ( 'super.out' ),
      'in' : ( '.' ),
      'out' : ( 'super.out' ),
      'out.debug' : ( 'super.out/debug' ),
      'out.release' : ( 'super.out/release' ),
      'will' : rel( execPath ),
      'module.dir' : '.',
      'module.willfiles' : [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'module.common' : 'super',
      'module.original.willfiles' : [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'local' : 'super',
      'remote' : null,
      'current.remote' : null,
      'download' : null,
      'module.peer.willfiles' : 'super.out/supermodule.out.will.yml',
      'module.peer.in' : 'super.out',
    }
    var got = _.select( resolved, '*/path' );
    test.identical( rel( got ), expected );

    test.case = 'path::* - pu:0 mvu:0 pr:out'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 0,
      pathResolving : 'out',
    });
    var expected =
    {
      'module.willfiles' : [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'module.original.willfiles' : [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'module.peer.willfiles' : 'super.out/supermodule.out.will.yml',
      'module.peer.in' : 'super.out',
      'module.dir' : '.',
      'module.common' : 'super',
      'local' : 'super',
      'remote' : null,
      'current.remote' : null,
      'will' : rel( execPath ),
      'proto' : 'super.out/proto',
      'temp' : 'super.out/super.out',
      'download' : null,
      'in' : 'super.out',
      'out' : 'super.out',
      'out.debug' : 'super.out/super.out/debug',
      'out.release' : 'super.out/super.out/release'
    }
    var got = _.select( resolved, '*/path' );
    test.identical( rel( got ), expected );

    test.case = 'path::* - pu:1 mvu:0 pr:null'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 0,
      pathResolving : null,
    });
    var expected =
    {
      'module.willfiles' : [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'module.original.willfiles' : [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'module.peer.willfiles' : 'super.out/supermodule.out.will.yml',
      'module.peer.in' : 'super.out',
      'module.dir' : '.',
      'module.common' : 'super',
      'download' : null,
      'local' : 'super',
      'remote' : null,
      'current.remote' : null,
      'will' : rel( execPath ),
      'proto' : 'proto',
      'temp' : 'super.out',
      'in' : '.',
      'out' : 'super.out',
      'out.debug' : 'super.out/debug',
      'out.release' : 'super.out/release'
    }
    var got = resolved;
    test.identical( rel( got ), expected );

    test.case = 'path::* - pu:1 mvu:0 pr:in'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 0,
      pathResolving : 'in',
    });
    var expected =
    {
      'module.willfiles' : [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'module.original.willfiles' : [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'module.peer.willfiles' : 'super.out/supermodule.out.will.yml',
      'module.peer.in' : 'super.out',
      'module.dir' : '.',
      'module.common' : 'super',
      'download' : null,
      'local' : 'super',
      'remote' : null,
      'current.remote' : null,
      'will' : rel( execPath ),
      'proto' : 'proto',
      'temp' : 'super.out',
      'in' : '.',
      'out' : 'super.out',
      'out.debug' : 'super.out/debug',
      'out.release' : 'super.out/release'
    }
    var got = resolved;
    test.identical( rel( got ), expected );

    test.case = 'path::* - pu:1 mvu:0 pr:out'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 0,
      pathResolving : 'out',
    });
    var expected =
    {
      'module.willfiles' : [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'module.original.willfiles' : [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'module.peer.willfiles' : 'super.out/supermodule.out.will.yml',
      'module.peer.in' : 'super.out',
      'module.dir' : '.',
      'module.common' : 'super',
      'download' : null,
      'local' : 'super',
      'remote' : null,
      'current.remote' : null,
      'will' : rel( execPath ),
      'proto' : 'super.out/proto',
      'temp' : 'super.out/super.out',
      'in' : 'super.out',
      'out' : 'super.out',
      'out.debug' : 'super.out/super.out/debug',
      'out.release' : 'super.out/super.out/release'
    }
    var got = resolved;
    test.identical( rel( got ), expected );

    test.case = 'path::* - pu:0 mvu:1 pr:null'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : null,
    });
    var expected =
    [
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'super.out/supermodule.out.will.yml',
      'super.out',
      '.',
      'super',
      null,
      'super',
      null,
      null,
      rel( execPath ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = _.select( resolved, '*/path' );
    test.identical( rel( got ), expected );

    test.case = 'path::* - pu:0 mvu:1 pr:in'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : 'in',
    });
    var expected =
    [
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'super.out/supermodule.out.will.yml',
      'super.out',
      '.',
      'super',
      null,
      'super',
      null,
      null,
      rel( execPath ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = _.select( resolved, '*/path' );
    test.identical( rel( got ), expected );

    test.case = 'path::* - pu:0 mvu:1 pr:out'; /* */
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : 'out',
    });
    var expected =
    [
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      [ 'super.ex.will.yml', 'super.im.will.yml' ],
      'super.out/supermodule.out.will.yml',
      'super.out',
      '.',
      'super',
      null,
      'super',
      null,
      null,
      rel( execPath ),
      'super.out/proto',
      'super.out/super.out',
      'super.out',
      'super.out',
      'super.out/super.out/debug',
      'super.out/super.out/release'
    ]
    var got = _.select( resolved, '*/path' );
    test.identical( rel( got ), expected );

    return null;
  });

  /* - */

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  return ready;
}

pathsResolve.timeOut = 130000;

//

function pathsResolveImportIn( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'two-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'super' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    return abs( filePath );
  }

  function sout( filePath )
  {
    return abs( 'super.out', filePath );
  }

  function pout( filePath )
  {
    return abs( 'out', filePath );
  }

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open({ all : 1 });
  })

  ready.then( ( arg ) =>
  {

    test.case = 'submodule::*/path::in*=1, default';
    var resolved = opener.openedModule.resolve( 'submodule::*/path::in*=1' )
    var expected = ( 'sub.out' );
    test.identical( rel( resolved ), expected );

    test.case = 'submodule::*/path::in*=1, pathResolving : 0';
    var resolved = opener.openedModule.resolve({ prefixlessAction : 'resolved', selector : 'submodule::*/path::in*=1', pathResolving : 0 })
    var expected = '.';
    test.identical( resolved, expected );

    test.case = 'submodule::*/path::in*=1, strange case';
    var resolved = opener.openedModule.resolve
    ({
      selector : 'submodule::*/path::in*=1',
      mapValsUnwrapping : 1,
      singleUnwrapping : 1,
      mapFlattening : 1,
    });
    var expected = ( 'sub.out' );
    test.identical( rel( resolved ), expected );

    return null;
  });

  ready.then( ( arg ) =>
  {

/*
  pathUnwrapping : 1,
  pathResolving : 0,
  mapFlattening : 1,
  singleUnwrapping : 1,
  mapValsUnwrapping : 1,
*/

    /* - */

    test.open( 'in' );

    test.open( 'pathUnwrapping : 1' );

    test.open( 'pathResolving : 0' );

    test.open( 'mapFlattening : 1' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = '.';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = '.';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ '.' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
    });
    var expected = { 'Submodule/in' : '.' };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = '.';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = '.';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      singleUnwrapping : 0,
      mapFlattening : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ '.' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
    });
    var expected =
    {
      'Submodule' : { 'in' : '.' }
    }
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 0' );

    test.close( 'pathResolving : 0' );

    test.open( 'pathResolving : in' );

    test.open( 'mapFlattening : 1' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';

    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = ( 'sub.out' );
    test.identical( rel( resolved ), expected );

    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = ( 'sub.out' );
    test.identical( rel( resolved ), expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      singleUnwrapping : 0,
      mapFlattening : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ pin( 'sub.out' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
    });
    var expected = { 'Submodule/in' : pin( 'sub.out' ) };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = ( 'sub.out' );
    test.identical( rel( resolved ), expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = ( 'sub.out' );
    test.identical( rel( resolved ), expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      singleUnwrapping : 0,
      mapFlattening : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ pin( 'sub.out' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
    });
    var expected =
    {
      'Submodule' : { 'in' : pin( 'sub.out' ) }
    }
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 0' );

    test.close( 'pathResolving : in' );

    test.close( 'pathUnwrapping : 1' );

    test.close( 'in' );

    /* - */

    test.open( 'proto' );

    test.open( 'pathUnwrapping : 1' );

    test.open( 'pathResolving : 0' );

    test.open( 'mapFlattening : 1' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = '../proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = '../proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      mapValsUnwrapping : 1,
      singleUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = [ [ '../proto' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
    });
    var expected = { 'Submodule/proto' : '../proto' };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = '../proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = '../proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      singleUnwrapping : 0,
      mapFlattening : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ '../proto' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
    });
    var expected =
    {
      'Submodule' : { 'proto' : '../proto' }
    }
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 0' );

    test.close( 'pathResolving : 0' );

    test.open( 'pathResolving : in' );

    test.open( 'mapFlattening : 1' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';

    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = pin( 'proto' );
    test.identical( resolved, expected );

    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = pin( 'proto' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      mapValsUnwrapping : 1,
      singleUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = [ [ pin( 'proto' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
    });
    var expected = { 'Submodule/proto' : pin( 'proto' ) };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = pin( 'proto' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = pin( 'proto' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ pin( 'proto' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected =
    {
      'Submodule' : { 'proto' : pin( 'proto' ) }
    }
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 0' );

    test.close( 'pathResolving : in' );

    test.close( 'pathUnwrapping : 1' );

    test.close( 'proto' );

    return null;
  })

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return ready;
}

pathsResolveImportIn.timeOut = 130000;

//

function pathsResolveOfSubmodules( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'submodules-local-repos' );
  let repoPath = _.path.join( self.suiteTempPath, '_repo' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesDelete( repoPath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesReflect({ reflectMap : { [ self.repoDirPath ] : repoPath } });
    _.fileProvider.filesDelete( outDirPath );
    opener = will.openerMakeManual({ willfilesPath : abs( './' ) });
    return opener.open({ all : 1 });
  })

  ready.then( ( arg ) =>
  {
    let module = opener.openedModule;
    // let builds = opener.openedModule.buildsResolve({ name : 'debug.raw' });
    // test.identical( builds.length, 1 );
    // let build = builds[ 0 ];
    // return build.perform();
    return module.modulesBuild({ criterion : { debug : 1 }, downloading : 1 });
  })

  ready.then( ( arg ) =>
  {

    test.case = 'resolve submodules';
    var submodules = opener.openedModule.submodulesResolve({ selector : '*' });
    test.identical( submodules.length, 2 );

    test.case = 'path::in, supermodule';
    var resolved = opener.openedModule.resolve( 'path::in' );
    var expected = path.join( routinePath );
    test.identical( resolved, expected );

    test.case = 'path::in, wTools';
    var submodule = submodules[ 0 ];
    var resolved = submodule.resolve( 'path::in' );
    var expected = path.join( submodulesPath, 'Tools/out' );
    test.identical( resolved, expected );

    test.case = 'path::in, wTools, through opener';
    var submodule = submodules[ 0 ].opener;
    var resolved = submodule.openedModule.resolve( 'path::in' );
    var expected = path.join( submodulesPath, 'Tools/out' );
    test.identical( resolved, expected );

    test.case = 'path::out, wTools';
    var submodule = submodules[ 0 ];
    var resolved = submodule.resolve( 'path::out' );
    var expected = path.join( submodulesPath, 'Tools/out' );
    test.identical( resolved, expected );

    test.case = 'path::out, wTools, through opener';
    var submodule = submodules[ 0 ].opener;
    var resolved = submodule.openedModule.resolve( 'path::out' );
    var expected = path.join( submodulesPath, 'Tools/out' );
    test.identical( resolved, expected );

    return null;
  })

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  })

  /* - */

  return ready;
}

pathsResolveOfSubmodules.timeOut = 130000;

//

function pathsResolveOfSubmodulesAndOwn( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'resolve-path-of-submodules-exported' );
  let repoPath = _.path.join( self.suiteTempPath, '_repo' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let submodulesPath = abs( '.module' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    return abs( filePath );
  }

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : abs( './ab/' ) });
    return opener.open({ all : 1 });
  })

  ready.then( ( arg ) =>
  {

    test.case = 'path::export';
    let resolved = opener.openedModule.pathResolve
    ({
      selector : 'path::export',
      currentContext : null,
      pathResolving : 'in',
    });
    var expected =
    [
      'proto/a/**',
      'proto/a/File.js/**',
      'proto/b/**',
      'proto/b/-Excluded.js/**',
      'proto/b/File.js/**',
      'proto/b/File.test.js/**',
      'proto/b/File1.debug.js/**',
      'proto/b/File1.release.js/**',
      'proto/b/File2.debug.js/**',
      'proto/b/File2.release.js/**',
      'proto/dir3.test/**'
    ]
    test.identical( rel( resolved ), expected );

    return null;
  })

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  })

  /* - */

  return ready;
}

pathsResolveOfSubmodulesAndOwn.timeOut = 300000;

//

function pathsResolveOutFileOfExports( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'export-multiple-exported' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let outSuperDirPath = abs( 'super.out' );
  let outSubDirPath = abs( 'sub.out' );
  let outSuperTerminalPath = abs( 'super.out/supermodule.out.will.yml' );
  let outSubTerminalPath = abs( 'sub.out/submodule.out.will.yml' );
  let modulePath = abs( 'super.out/supermodule' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    return abs( filePath );
  }

  function pout( filePath )
  {
    return abs( 'out', filePath );
  }

  function sout( filePath )
  {
    return abs( 'super.out', filePath );
  }

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open({ all : 1 });
  })

  ready.then( ( arg ) =>
  {

    test.open( 'without export' );

    test.case = 'submodule::*/path::in*=1, default';
    var resolved = opener.openedModule.resolve( 'submodule::*/path::in*=1' );
    var expected = abs( 'sub.out' );
    test.identical( resolved, expected );

    test.case = 'submodule::*/path::in*=1, pathResolving : 0';
    var resolved = opener.openedModule.resolve({ prefixlessAction : 'resolved', selector : 'submodule::*/path::in*=1', pathResolving : 0 });
    var expected = '.';
    test.identical( resolved, expected );

    test.case = 'submodule::*/path::in*=1, strange case';
    var resolved = opener.openedModule.resolve
    ({
      selector : 'submodule::*/path::in*=1',
      mapValsUnwrapping : 1,
      singleUnwrapping : 1,
      mapFlattening : 1,
    });
    var expected = abs( 'sub.out' );
    test.identical( resolved, expected );

    test.close( 'without export' );

    /* - */

    test.open( 'with export' );

    test.case = 'submodule::*/exported::*=1debug/path::in*=1, default';
    var resolved = opener.openedModule.resolve( 'submodule::*/exported::*=1debug/path::in*=1' );
    var expected = abs( 'sub.out' );
    test.identical( resolved, expected );

    test.case = 'submodule::*/exported::*=1debug/path::in*=1, pathResolving : 0';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/exported::*=1debug/path::in*=1',
      pathResolving : 0,
    })
    var expected = '.';
    test.identical( resolved, expected );

    test.case = 'submodule::*/exported::*=1debug/path::in*=1, strange case';
    var resolved = opener.openedModule.resolve
    ({
      selector : 'submodule::*/exported::*=1debug/path::in*=1',
      mapValsUnwrapping : 1,
      singleUnwrapping : 1,
      mapFlattening : 1,
    });
    var expected = abs( 'sub.out' );
    test.identical( resolved, expected );

    test.close( 'with export' );

    return null;
  });

  ready.then( ( arg ) =>
  {

/*
  pathUnwrapping : 1,
  pathResolving : 0,
  mapFlattening : 1,
  singleUnwrapping : 1,
  mapValsUnwrapping : 1,
*/

    /* - */

    test.open( 'in' );

    test.open( 'pathUnwrapping : 1' );

    test.open( 'pathResolving : 0' );

    test.open( 'mapFlattening : 1' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = '.';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = '.';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      mapValsUnwrapping : 1,
      singleUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = [ [ '.' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = { 'Submodule/in' : '.' };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = '.';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = '.';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ '.' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected =
    {
      'Submodule' : { 'in' : '.' }
    }
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 0' );

    test.close( 'pathResolving : 0' );

    test.open( 'pathResolving : in' );

    test.open( 'mapFlattening : 1' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';

    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = abs( 'sub.out' );
    test.identical( resolved, expected );

    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = abs( 'sub.out' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ abs( 'sub.out' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = { 'Submodule/in' : abs( 'sub.out' ) };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = abs( 'sub.out' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = abs( 'sub.out' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ abs( 'sub.out' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected =
    {
      'Submodule' : { 'in' : abs( 'sub.out' ) }
    }
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 0' );

    test.close( 'pathResolving : in' );

    test.close( 'pathUnwrapping : 1' );

    test.close( 'in' );

    /* - */

    test.open( 'proto' );

    test.open( 'pathUnwrapping : 1' );

    test.open( 'pathResolving : 0' );

    test.open( 'mapFlattening : 1' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = '../proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = '../proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ '../proto' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = { 'Submodule/proto' : '../proto' };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = '../proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = '../proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ '../proto' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected =
    {
      'Submodule' : { 'proto' : '../proto' }
    }
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 0' );

    test.close( 'pathResolving : 0' );

    test.open( 'pathResolving : in' );

    test.open( 'mapFlattening : 1' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';

    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = pin( 'proto' );
    test.identical( resolved, expected );

    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = pin( 'proto' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ pin( 'proto' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = { 'Submodule/proto' : pin( 'proto' ) };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = pin( 'proto' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected = pin( 'proto' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
    });
    var expected = [ [ pin( 'proto' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = opener.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
    });
    var expected =
    {
      'Submodule' : { 'proto' : pin( 'proto' ) }
    }
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 0' );

    test.close( 'pathResolving : in' );

    test.close( 'pathUnwrapping : 1' );

    test.close( 'proto' );

    return null;
  })

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    debugger;
    opener.finit();
    debugger;
    return arg;
  });

  /* - */

  return ready;
}

pathsResolveOutFileOfExports.timeOut = 130000;

//

function pathsResolveComposite( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'composite-path' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( './' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    return abs( 'in', filePath );
  }

  function pout( filePath )
  {
    return abs( 'out', filePath );
  }

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open({ all : 1 });
  })

  ready.then( ( arg ) =>
  {

    test.case = 'path::protoDir1';
    var resolved = opener.openedModule.resolve( 'path::protoDir1' )
    var expected = pin( 'proto/dir' );
    test.identical( resolved, expected );

    test.case = 'path::protoDir2';
    var resolved = opener.openedModule.resolve( 'path::protoDir2' )
    var expected = pin( 'protodir' );
    test.identical( resolved, expected );

    test.case = 'path::protoDir3';
    var resolved = opener.openedModule.resolve( 'path::protoDir3' )
    var expected = pin( 'prefix/proto/dir/dir2' );
    test.identical( resolved, expected );

    test.case = 'path::protoDir4';
    var resolved = opener.openedModule.resolve( 'path::protoDir4' )
    var expected = pin( '../prefix/aprotobdirc/dir2' );
    test.identical( resolved, expected );

    test.case = 'path::protoDir4b';
    var resolved = opener.openedModule.resolve( 'path::protoDir4b' )
    var expected = pin( '../prefix/aprotobdirc/dir2/proto' );
    test.identical( resolved, expected );

    test.case = 'path::protoMain';
    debugger;
    var resolved = opener.openedModule.resolve( 'path::protoMain' );
    debugger;
    var expected = pin( 'proto/Main.s' );
    test.identical( resolved, expected );

    test.case = 'path::protoMain with options defaultResourceKind';
    var resolved = opener.openedModule.resolve
    ({
      selector : 'path::protoMain',
      defaultResourceKind : 'path',
      prefixlessAction : 'default',
      pathResolving : 'in',
    })
    var expected = pin( 'proto/Main.s' );
    test.identical( resolved, expected );

    test.case = '{path::proto}/Main.s';
    var resolved = opener.openedModule.resolve( '{path::proto}/Main.s' )
    var expected = pin( 'proto/Main.s' );
    test.identical( resolved, expected );

    test.case = '{path::proto}/Main.s with options defaultResourceKind';
    var resolved = opener.openedModule.resolve
    ({
      selector : '{path::proto}/Main.s',
      defaultResourceKind : 'path',
      prefixlessAction : 'default',
      pathResolving : 'in',
    })
    var expected = pin( 'proto/Main.s' );
    test.identical( resolved, expected );

    return null;
  });

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return ready;
}

pathsResolveComposite.timeOut = 130000;

//

function pathsResolveComposite2( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'path-composite' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'Proto' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    return abs( 'in', filePath );
  }

  function pout( filePath )
  {
    return abs( 'out', filePath );
  }

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open({ all : 1 });
  })

  ready.then( ( arg ) =>
  {
    test.case = 'path::export';
    debugger;
    var resolved = opener.openedModule.resolve({ selector : 'path::export', pathResolving : 0 });
    debugger;
    var expected = '.module/Proto/proto/**';
    test.identical( resolved, expected );
    return null;
  });

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return ready;
}

pathsResolveComposite2.timeOut = 130000;

//

function pathsResolveArray( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'make' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'v1' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    return abs( '', filePath );
  }

  function pout( filePath )
  {
    return abs( 'out', filePath );
  }

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open({ all : 1 });
  })

  ready.then( ( arg ) =>
  {

    test.case = 'path::produced.js';
    var got = opener.openedModule.pathResolve
    ({
      selector : 'path::produced.js',
      pathResolving : 'in',
      missingAction : 'undefine',
    });
    var expected = pin( 'file/Produced.js2' );
    test.identical( got, expected );

    test.case = 'path::temp';
    var got = opener.openedModule.pathResolve
    ({
      selector : 'path::temp',
      pathResolving : 'in',
      missingAction : 'undefine',
    });
    var expected = pin
    ([
      'out/Produced.txt2',
      'out/Produced.js2',
      'file/Produced.txt2',
      'file/Produced.js2',
      'Produced.txt2',
      'Produced.js2'
    ]);
    test.identical( got, expected );

    return null;
  });

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return ready;
}

//

function pathsResolveResolvedPath( test )
{
  let self = this;
  let a = self.assetFor( test, 'make' );
  let modulePath = a.abs( 'v1' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open({ all : 1 });
  })

  a.ready.then( ( arg ) =>
  {
    let module = opener.openedModule;

    var src = 'path::produced.txt';
    test.case = src;
    var exp = a.abs( 'file/Produced.txt2' );
    var got = module.pathResolve
    ({
      selector : src,
      prefixlessAction : 'resolved',
      pathResolving : 'in',
    });
    test.identical( got, exp );

    var src = 'path::file';
    test.case = src;
    var exp = a.abs( 'file' );
    var got = module.pathResolve
    ({
      selector : src,
      prefixlessAction : 'resolved',
      pathResolving : 'in',
    });
    test.identical( got, exp );

    var src = 'some';
    test.case = src;
    var exp = 'some';
    var got = module.pathResolve
    ({
      selector : src,
      prefixlessAction : 'resolved',
      pathResolving : 'in',
      selectorIsPath : 0,
    });
    test.identical( got, exp );

    var src = 'some';
    test.case = src;
    var exp = 'some';
    var got = module.resolve
    ({
      selector : src,
      prefixlessAction : 'resolved',
      pathResolving : 'in',
    });
    test.identical( got, exp );

    var src = 'some';
    test.case = src;
    var exp = a.abs( 'some' );
    var got = module.pathResolve
    ({
      selector : src,
      prefixlessAction : 'resolved',
      pathResolving : 'in',
    });
    test.identical( got, exp );

    var src = 'some';
    test.case = src;
    var exp = a.abs( 'some' );
    var got = module.pathResolve
    ({
      selector : src,
      prefixlessAction : 'resolved',
      pathResolving : 'in',
      defaultResourceKind : 'path',
    });
    test.identical( got, exp );

    var src = 'some';
    test.case = src;
    var exp = a.abs( 'some' );
    var got = module.pathResolve
    ({
      selector : src,
      prefixlessAction : 'resolved',
      pathResolving : 'in',
      selectorIsPath : 1,
    });
    test.identical( got, exp );

    test.case = 'empty str';
    var src = '';
    var exp = null;
    var got = module.pathResolve
    ({
      selector : src,
      prefixlessAction : 'resolved',
      pathResolving : 'in',
      defaultResourceKind : 'path',
      selectorIsPath : 1,
    });
    test.identical( got, exp );

    test.case = 'null';
    var src = null;
    var exp = null;
    var got = module.pathResolve
    ({
      selector : src,
      prefixlessAction : 'resolved',
      pathResolving : 'in',
      defaultResourceKind : 'path',
      selectorIsPath : 1,
    });
    test.identical( got, exp );

    return null;
  });

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return a.ready;
}

pathsResolveResolvedPath.description =
`
relative resolved path absolutized if pathResolving:1
`

//

/*
  path::path::export cant be resolved
  so error should be throwen
  but as it's composite and deep
  bug could appear here
*/

function pathsResolveFailing( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'export-with-submodules' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( 'ab/' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;
  let ready = _.Consequence().take( null );
  let opener;

  function pin( filePath )
  {
    return abs( '', filePath );
  }

  function pout( filePath )
  {
    return abs( 'out', filePath );
  }

  /* - */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesDelete( outDirPath );
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open({ all : 1 });
  })

  ready.then( ( arg ) =>
  {

    test.case = 'path::entry.*=1: null';
    var got = opener.openedModule.pathResolve
    ({
      selector : { 'path::entry.*=1' : null },
      missingAction : 'undefine',
      mapValsUnwrapping : 0,
      singleUnwrapping : 0,
    });
    var expected = { 'path::entry.*=1' : null };
    test.identical( got, expected );

    test.case = 'path::entry.*=1: null';
    var got = opener.openedModule.pathResolve
    ({
      selector : { 'path::entry.*=1' : null },
      missingAction : 'undefine',
      mapValsUnwrapping : 1,
    });
    var expected = null;
    test.identical( got, expected );

    test.case = 'path::entry.*=1: null';
    var got = opener.openedModule.pathResolve
    ({
      selector : { 'path::entry.*=1' : null },
      missingAction : 'undefine',
      prefixlessAction : 'resolved',
      pathResolving : 0,
      pathNativizing : 0,
      selectorIsPath : 1,
      mapValsUnwrapping : 0,
      singleUnwrapping : 0,
    });
    var expected = { 'path::entry.*=1' : null };
    test.identical( got, expected );

    test.case = 'path::proto';
    var got = opener.openedModule.pathResolve
    ({
      selector : 'path::proto',
      pathResolving : 0,
      missingAction : 'undefine',
    });
    var expected = '../proto';
    test.identical( got, expected );

    test.case = 'path::export';
    test.shouldThrowErrorSync( () =>
    {
      var got = opener.openedModule.pathResolve
      ({
        selector : 'path::*',
        pathResolving : 0,
        missingAction : 'throw',
        prefixlessAction : 'throw',
      });
    });

    return null;
  });

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return ready;
}

//

function modulesEach( test )
{
  let self = this;
  let a = self.assetFor( test, 'two-in-exported' );
  let modulePath = a.abs( './super' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'all : 0';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : modulePath });

    a.will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
      peerModulesFormedOfSub : 1,
    });

    return opener.open({ all : 0, subModulesFormed : 1, peerModulesFormed : 1 });
  })

  .then( () =>
  {

    /* */

    test.description = 'withPeers : 1, withStem : 1, recursive : 2';
    logger.log( 'withPeers : 1, withStem : 1, recursive : 2' );
    var got = opener.openedModule.modulesEach({ withPeers : 1, withStem : 1, recursive : 2, outputFormat : '/' })

    var exp =
    [
      'module::supermodule',
      'module::supermodule / module::supermodule',
      'module::supermodule / relation::Submodule',
      'module::supermodule / module::sub'
    ]
    var got3 = _.index( got, ( e ) => e.relation ? e.relation.absoluteName : e.module.absoluteName );
    test.identical( a.rel( _.mapKeys( got3 ) ), exp );

    var exp = [ 'super', 'super.out/supermodule.out', 'sub', 'sub.out/sub.out' ];
    var commonPath = _.index( got, ( e ) => e.opener ? e.opener.commonPath : e.module.commonPath );
    test.identical( a.rel( _.mapKeys( commonPath ) ), exp );

    /* */

    test.description = 'peer, withPeers : 1, withStem : 1, recursive : 2';
    logger.log( 'peer, withPeers : 1, withStem : 1, recursive : 2' );
    var got = opener.openedModule.peerModule.modulesEach({ withPeers : 1, withStem : 1, recursive : 2, outputFormat : '/' })

    var exp =
    [
      'module::supermodule / module::supermodule',
      'module::supermodule',
      'module::supermodule / relation::Submodule',
      'module::supermodule / module::sub',
    ]
    var got3 = _.index( got, ( e ) => e.relation ? e.relation.absoluteName : e.module.absoluteName );
    test.identical( a.rel( _.mapKeys( got3 ) ), exp );

    var exp = [ 'super.out/supermodule.out', 'super', 'sub', 'sub.out/sub.out' ];
    var commonPath = _.index( got, ( e ) => e.opener ? e.opener.commonPath : e.module.commonPath );
    test.identical( a.rel( _.mapKeys( commonPath ) ), exp );

    /* */

    opener.finit();
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'all : 1';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : modulePath });

    a.will.prefer
    ({
      allOfMain : 1,
      allOfSub : 1,
    });

    return opener.open();
  })

  .then( () =>
  {

    test.description = 'withPeers : 1, withStem : 1, recursive : 2';
    var exp = [ 'super', 'sub', 'sub.out/sub.out', 'super.out/supermodule.out' ];
    var got = opener.openedModule.modulesEach({ withPeers : 1, withStem : 1, recursive : 2 })
    test.identical( _.setFrom( a.rel( _.select( got, '*/commonPath' ) ) ), _.setFrom( exp ) );

    test.description = 'peerModule, withPeers : 1, withStem : 1, recursive : 2';
    var exp = [ 'super', 'sub', 'sub.out/sub.out', 'super.out/supermodule.out' ];
    var got = opener.openedModule.peerModule.modulesEach({ withPeers : 1, withStem : 1, recursive : 2 })
    test.identical( _.setFrom( a.rel( _.select( got, '*/commonPath' ) ) ), _.setFrom( exp ) );

    opener.finit();
    return null;
  })

  /* - */

  return a.ready;
} /* end of function modulesEach */

//

function modulesEachDuplicates( test )
{
  let self = this;
  let a = self.assetFor( test, 'hierarchy-duplicate' );
  let modulePath = a.abs( './z' );
  let opener;

  /* - */

  a.ready

  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open();
  })

  .then( () =>
  {
    return a.will.modulesDownload({ modules : [ opener ], recursive : 2 })
  })

  .then( () =>
  {

    /* */

    test.description = 'root, recursive:1';

    var ups = [];
    var o2 = Object.create( null );
    o2.recursive = 1;
    o2.withStem = 1;
    o2.withPeers = 1;
    o2.onUp = handleUp;
    o2.outputFormat = '*/module';
    var got = opener.openedModule.modulesEach( o2 );

    test.is( ups.length === got.length );
    test.is( ups[ 0 ] === got[ 0 ] );

    var exp =
    [
      'z',
      'group1/a',
      '.module/Tools/',
      '.module/Tools/out/wTools.out',
    ]
    var got = _.select( got, '*/localPath' );
    test.identical( got, a.abs( exp ) );

    /* */

    test.description = 'submodule, recursive:1';

    var ups = [];
    var o2 = Object.create( null );
    o2.recursive = 1;
    o2.withStem = 1;
    o2.withPeers = 1;
    o2.onUp = handleUp;
    o2.outputFormat = '*/module';
    _global_.debugger = 1;
    debugger;
    var got = opener.openedModule.submoduleMap.a.opener.openedModule.modulesEach( o2 )
    debugger;
    test.is( ups.length === got.length );
    test.is( ups[ 0 ] === got[ 0 ] );

    var exp =
    [
      'group1/a',
      'group1/.module/Tools/',
      'group1/.module/Tools/out/wTools.out',
    ]
    var got = _.select( got, '*/localPath' );
    test.identical( got, a.abs( exp ) );

    /* */

    opener.finit();
    return null;

    function handleUp( object, it )
    {
      ups.push( object );
    }

  })

  /* - */

  return a.ready;
} /* end of function modulesEachDuplicates */

//

function submodulesResolve( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'submodules-local-repos' );
  let repoPath = _.path.join( self.suiteTempPath, '_repo' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( './' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let ready = new _.Consequence().take( null );
  let opener;

  /* - */

  ready
  .then( () =>
  {
  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesDelete( repoPath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
  _.fileProvider.filesReflect({ reflectMap : { [ self.repoDirPath ] : repoPath } });
  _.fileProvider.filesDelete( outDirPath );
    opener = will.openerMakeManual({ willfilesPath : modulePath });

    will.prefer
    ({
      allOfSub : 1,
    });

    return opener.open({ all : 1, resourcesFormed : 0 });
  })

  .then( () =>
  {
    test.open( 'not downloaded' );

    test.case = 'trivial';
    var submodule = opener.openedModule.submoduleMap.Tools;
    test.is( submodule instanceof will.ModulesRelation );

    test.is( !!submodule.opener );
    test.identical( submodule.name, 'Tools' );
    test.identical( submodule.opener.openedModule, null );
    test.identical( submodule.opener.willfilesPath, abs( '.module/Tools/out/wTools.out.will' ) );
    test.identical( submodule.opener.dirPath, abs( '.module/Tools/out' ) );
    test.identical( submodule.opener.localPath, abs( '.module/Tools/out/wTools.out' ) );
    test.identical( submodule.opener.commonPath, abs( '.module/Tools/out/wTools.out' ) );
    test.identical( submodule.opener.remotePath, _.uri.join( repoPath, 'git+hd://Tools?out=out/wTools.out.will#master' ) );

    // test.is( !submodule.hasFiles );
    test.is( !submodule.opener.repo.hasFiles );
    test.is( !submodule.opener.openedModule );

    test.close( 'not downloaded' );
    return null;
  })

  /* */

  .then( () =>
  {
    return opener.openedModule.subModulesDownload();
  })

  .then( () =>
  {
    test.open( 'downloaded' );

    test.case = 'trivial';
    var submodule = opener.openedModule.submodulesResolve({ selector : 'Tools' });
    test.is( submodule instanceof will.ModulesRelation );
    // test.is( submodule.hasFiles );
    test.is( submodule.opener.repo.hasFiles );
    test.is( submodule.opener.repo === submodule.opener.openedModule.repo );
    test.is( !!submodule.opener );
    test.identical( submodule.name, 'Tools' );

    test.identical( submodule.opener.name, 'Tools' );
    test.identical( submodule.opener.aliasName, 'Tools' );
    test.identical( submodule.opener.fileName, 'wTools.out' );
    test.identical( submodule.opener.willfilesPath, abs( '.module/Tools/out/wTools.out.will.yml' ) );
    test.identical( submodule.opener.dirPath, abs( '.module/Tools/out' ) );
    test.identical( submodule.opener.localPath, abs( '.module/Tools/out/wTools.out' ) );
    test.identical( submodule.opener.commonPath, abs( '.module/Tools/out/wTools.out' ) );
    test.identical( submodule.opener.remotePath, _.uri.join( repoPath, 'git+hd://Tools?out=out/wTools.out.will#master' ) );

    test.identical( submodule.opener.openedModule.name, 'wTools' );
    test.identical( submodule.opener.openedModule.resourcesFormed, 8 );
    test.identical( submodule.opener.openedModule.subModulesFormed, 8 );
    test.identical( submodule.opener.openedModule.willfilesPath, abs( '.module/Tools/out/wTools.out.will.yml' ) );
    test.identical( submodule.opener.openedModule.dirPath, abs( '.module/Tools/out' ) );
    test.identical( submodule.opener.openedModule.localPath, abs( '.module/Tools/out/wTools.out' ) );
    test.identical( submodule.opener.openedModule.commonPath, abs( '.module/Tools/out/wTools.out' ) );
    test.identical( submodule.opener.openedModule.remotePath, _.uri.join( repoPath, 'git+hd://Tools?out=out/wTools.out.will#master' ) );
    test.identical( submodule.opener.openedModule.currentRemotePath, _.uri.join( repoPath, 'git+hd://Tools?out=out/wTools.out.will#master' ) );
    debugger;

    test.case = 'mask, single module';
    var submodule = opener.openedModule.submodulesResolve({ selector : 'T*' });
    test.is( submodule instanceof will.ModulesRelation );
    test.identical( submodule.name, 'Tools' );

    test.case = 'mask, two modules';
    var submodules = opener.openedModule.submodulesResolve({ selector : '*s*' });
    test.identical( submodules.length, 2 );
    test.is( submodules[ 0 ] instanceof will.ModulesRelation );
    test.identical( submodules[ 0 ].name, 'Tools' );
    test.is( submodules[ 1 ] instanceof will.ModulesRelation );
    test.identical( submodules[ 1 ].name, 'PathBasic' );

    test.close( 'downloaded' );
    return null;
  })

  /* */

  return ready;
} /* end of function submodulesResolve */

submodulesResolve.timeOut = 300000;

//

function submodulesDeleteAndDownload( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'submodules-del-download' );
  let repoPath = _.path.join( self.suiteTempPath, '_repo' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( './' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let will = new _.Will;
  let ready = new _.Consequence().take( null );
  let opener;

  /* */

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesDelete( repoPath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    _.fileProvider.filesReflect({ reflectMap : { [ self.repoDirPath ] : repoPath } });
    _.fileProvider.filesDelete( outDirPath );
    opener = will.openerMakeManual({ willfilesPath : modulePath });
    return opener.open();
  })

  ready
  .then( () =>
  {

    let builds = opener.openedModule.buildsResolve({ name : 'build' });
    test.identical( builds.length, 1 );

    let build = builds[ 0 ];
    let con = build.perform();

    con.then( ( arg ) =>
    {
      var files = self.find( submodulesPath );
      test.is( _.longHas( files, './Tools' ) );
      test.is( _.longHas( files, './PathBasic' ) );
      test.gt( files.length, 250 );
      return arg;
    })

    con.then( () => build.perform() )

    con.then( ( arg ) =>
    {
      var files = self.find( submodulesPath );
      test.is( _.longHas( files, './Tools' ) );
      test.is( _.longHas( files, './PathBasic' ) );
      test.gt( files.length, 250 );
      return arg;
    })

    con.finally( ( err, arg ) =>
    {

      var exp = [ './', '.module/Tools/out/wTools.out', '.module/Tools/', '.module/PathBasic/out/wPathBasic.out', '.module/PathBasic/' ];
      test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
      test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );

      test.identical( _.mapKeys( will.moduleWithIdMap ).length, exp.length );
      var willfilesArray =
      [
        '.will.yml',
        '.module/Tools/out/wTools.out.will.yml',
        [
          '.module/Tools/.ex.will.yml',
          '.module/Tools/.im.will.yml'
        ],
        '.module/PathBasic/out/wPathBasic.out.will.yml',
        [
          '.module/PathBasic/.ex.will.yml',
          '.module/PathBasic/.im.will.yml'
        ]
      ]
      test.identical( _.select( will.willfilesArray, '*/filePath' ), abs( willfilesArray ) ); debugger;

      var exp =
      [
        '.will.yml',
        '.module/Tools/out/wTools.out.will.yml',
        '.module/Tools/.ex.will.yml',
        '.module/Tools/.im.will.yml',
        '.module/PathBasic/out/wPathBasic.out.will.yml',
        '.module/PathBasic/.ex.will.yml',
        '.module/PathBasic/.im.will.yml'
      ]
      test.identical( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ), exp );
      test.identical( _.mapKeys( will.willfileWithFilePathPathMap ), abs( exp ) );
      var exp = [ './', '.module/Tools/out/wTools.out', '.module/Tools/', '.module/PathBasic/out/wPathBasic.out', '.module/PathBasic/' ]
      test.identical( rel( _.mapKeys( will.willfileWithCommonPathMap ) ), exp );

      // var exp =
      // [
      //   './',
      //   './.module/Tools/out/wTools.out',
      //   './.module/PathBasic/out/wPathBasic.out',
      //   './.module/wFiles',
      //   './.module/wCloner',
      //   './.module/wStringer',
      //   './.module/wTesting',
      //   './.module/wSelector',
      //   'hd://./.module/Tools',
      //   './.module/Tools/',
      //   './.module/wFiles',
      //   './.module/wCloner',
      //   './.module/wStringer',
      //   './.module/wTesting',
      //   './.module/wSelector',
      //   'hd://./.module/Tools',
      //   './.module/PathBasic/'
      // ]
      // test.identical( _.setFrom( _.select( will.openersArray, '*/commonPath' ) ), _.setFrom( abs( exp ) ) );
      //
      // var exp =
      // [
      //   './',
      //   './.module/Tools/out/wTools.out',
      //   './.module/PathBasic/out/wPathBasic.out',
      //   './.module/wFiles',
      //   './.module/wCloner',
      //   './.module/wStringer',
      //   './.module/wTesting',
      //   './.module/wSelector',
      //   'hd://./.module/Tools',
      //   './.module/Tools/',
      //   './.module/wFiles',
      //   './.module/wCloner',
      //   './.module/wStringer',
      //   './.module/wTesting',
      //   './.module/wSelector',
      //   'hd://./.module/Tools',
      //   './.module/PathBasic/'
      // ]
      // test.identical( _.setFrom( _.select( will.openersArray, '*/localPath' ) ), _.setFrom( abs( exp ) ) );
      //
      // var exp =
      // [
      //   null,
      //   'git+hd://../_repo/Tools?out=out/wTools.out.will#master',
      //   'git+hd://../_repo/PathBasic?out=out/wPathBasic.out.will#master',
      //   'npm:///wFiles',
      //   'npm:///wcloner',
      //   'npm:///wstringer',
      //   'npm:///wTesting',
      //   'npm:///wselector',
      //   null, /* xxx : should be not null */
      //   'git+hd://../_repo/Tools?out:./#master',
      //   'npm:///wFiles',
      //   'npm:///wcloner',
      //   'npm:///wstringer',
      //   'npm:///wTesting',
      //   'npm:///wselector',
      //   null, /* xxx : should be not null */
      //   'git+hd://../_repo/PathBasic?out:./#master'
      // ]
      // var remotePath = _.select( will.openersArray, '*/remotePath' );
      // // test.is( _.strHas( remotePath[ 1 ], '/_repo/Tools?out=out/wTools.out.will#master' ) );
      // // test.is( _.strHas( remotePath[ 2 ], '/_repo/PathBasic?out=out/wPathBasic.out.will#master' ) );
      // exp[ 1 ] = remotePath[ 1 ];
      // exp[ 2 ] = remotePath[ 2 ];
      // test.identical( _.setFrom( remotePath ), _.setFrom( abs( exp ) ) );
      // debugger;
      //
      // will.openersArray.map( ( opener ) =>
      // {
      //   logger.log( opener.absoluteName, '#' + opener.id, ' - ', opener.localPath, ' - ', opener.remotePath );
      // });
      //
      // test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, exp.length );
      // var expected =
      // [
      //   './.will.yml',
      //   './.module/Tools/out/wTools.out.will.yml',
      //   './.module/PathBasic/out/wPathBasic.out.will.yml',
      //   './.module/wFiles',
      //   './.module/wCloner',
      //   './.module/wStringer',
      //   './.module/wTesting',
      //   './.module/wSelector',
      //   'hd://./.module/Tools',
      //   [
      //     './.module/Tools/.ex.will.yml',
      //     './.module/Tools/.im.will.yml'
      //   ],
      //   './.module/wFiles',
      //   './.module/wCloner',
      //   './.module/wStringer',
      //   './.module/wTesting',
      //   './.module/wSelector',
      //   'hd://./.module/Tools',
      //   [
      //     './.module/PathBasic/.ex.will.yml',
      //     './.module/PathBasic/.im.will.yml'
      //   ]
      // ]
      // var got = _.select( will.openersArray, '*/willfilesPath' )
      // test.identical( got, abs( expected ) );

      opener.finit();

      test.description = 'no garbage left';
      test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

      if( err )
      throw err;
      return arg;
    })

    return con;
  })

  /* - */

  return ready;
}

submodulesDeleteAndDownload.timeOut = 300000;

//

function customLogger( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'simple' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let modulePath = abs( './' );
  let submodulesPath = abs( '.module' );
  let outDirPath = abs( 'out' );
  let logger = new _.Logger({ output : null, name : 'willCustomLogger', onTransformEnd, verbosity : 2 });
  let loggerOutput = [];
  let will = new _.Will({ logger });

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
  _.fileProvider.filesDelete( outDirPath );

  var opener = will.openerMakeManual({ willfilesPath : modulePath });
  opener.find();

  return opener.open().split().then( () =>
  {

    var expected = [];
    var files = self.find( outDirPath );
    let builds = opener.openedModule.buildsResolve();

    test.identical( builds.length, 1 );

    let build = builds[ 0 ];

    return build.perform()
    .finally( ( err, arg ) =>
    {

      test.description = 'files';
      var expected = [ '.', './debug', './debug/File.js' ];
      var files = self.find( outDirPath );
      test.identical( files, expected );

      opener.finit();

      test.description = 'no garbage left';
      test.identical( _.setFrom( rel( _.select( will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.select( _.mapVals( will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.mapKeys( will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.select( will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.select( _.mapVals( will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.arrayFlatten( _.select( will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( rel( _.mapKeys( will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( _.mapKeys( will.moduleWithNameMap ) ), _.setFrom( [] ) );

      let output = loggerOutput.join( '\n' );
      test.is( _.strHas( output, /Building .*module::customLogger \/ build::debug.*/ ) );
      test.is( _.strHas( output, / - .*step::delete.out.debug.* deleted 0 file\(s\)/ ) );
      test.is( _.strHas( output, / \+ .*reflector::reflect.proto.* reflected 2 file\(s\)/ ) );
      test.is( _.strHas( output, /Built .*module::customLogger \/ build::debug.*/ ) );

      if( err )
      throw err;
      return arg;
    });

  });

  /*  */

  function onTransformEnd( o )
  {
    loggerOutput.push( o.outputForPrinter[ 0 ] )
  }
}

//

function resourcePathRemote( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'export-informal' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let rel = self.rel_functor( routinePath );
  let informalPath = abs( './module/' );
  let supermodulePath = abs( './' );
  let will = new _.Will({});
  let ready = new _.Consequence().take( null )

  let opener;

  ready
  .then( () =>
  {
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : informalPath });
    return opener.open();
  })
  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    return build.perform()
  })
  .then( () =>
  {
    let module = opener.openedModule;
    test.description = 'finit';
    opener.finit();
    test.is( module.isFinited() );
    test.is( opener.isFinited() );

    return null;
  })

  .then( () =>
  {
    opener = will.openerMakeManual({ willfilesPath : supermodulePath });
    return opener.open();
  })
  .then( () =>
  {
    let module = opener.openedModule;
    let informalOpener =  module.submoduleMap[ 'UriBasic' ].opener;
    let informalOpened = informalOpener.openedModule;
    let informalPathRemoteResource = informalOpened.pathResourceMap[ 'remote' ];

    test.identical( informalPathRemoteResource.path, null );
    // test.identical( informalPathRemoteResource.path, 'git+https:///github.com/Wandalen/wUriBasic.git' );

    return null;
  })


  return ready;
}

//

function moduleIsNotValid( test )
{
  let self = this;
  let originalAssetPath = _.path.join( self.suiteAssetsOriginalPath, 'submodules-download-errors' );
  let routinePath = _.path.join( self.suiteTempPath, test.name );
  let abs = self.abs_functor( routinePath );
  let modulePath = abs( './good' );
  let downloadPath = abs( './.module/PathBasic' );
  let will = new _.Will();
  let opener;
  let ready = new  _.Consequence().take( null );

  ready
  .then( () =>
  {
    test.case = 'download submodule';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalAssetPath ] : routinePath } });
    opener = will.openerMakeManual({ willfilesPath : modulePath });

    will.prefer
    ({
      allOfSub : 1,
    });

    return opener.open({ all : 1, resourcesFormed : 0 });
  })

  .then( () => opener.openedModule.subModulesDownload() )

  .then( () =>
  {
    test.case = 'change out will-file';

    opener.close();

    let outWillFilePath = _.path.join( downloadPath, 'out/wPathBasic.out.will.yml' );
    let outWillFile = _.fileProvider.fileConfigRead( outWillFilePath );
    outWillFile.section = { field : 'value' };
    _.fileProvider.fileWrite({ filePath : outWillFilePath, data : outWillFile, encoding : 'yml' });

    return null;
  })

  .then( () =>
  {
    test.case = 'repopen module';
    let outWillFilePath = _.path.join( downloadPath, 'out/wPathBasic.out.will.yml' );
    debugger;
    opener = will.openerMakeManual({ willfilesPath : outWillFilePath });
    return opener.open({ all : 1, resourcesFormed : 0 });
  })

  .finally( ( err, arg ) =>
  {
    test.case = 'check if module is valid';
    if( err )
    _.errAttend( err );
    test.is( _.errIs( err ) );
    debugger;
    test.identical( opener.isValid(), false );
    test.identical( opener.openedModule.isValid(), false );
    opener.close();
    return null;
  })

  return ready;
}

// --
// define class
// --

var Self =
{

  name : 'Tools.atop.WillInternals',
  silencing : 1,

  onSuiteBegin : onSuiteBegin,
  onSuiteEnd : onSuiteEnd,
  routineTimeOut : 60000,

  context :
  {
    suiteTempPath : null,
    suiteAssetsOriginalPath : null,
    repoDirPath : null,
    find : null,
    findAll : null,
    assetFor,
    abs_functor,
    rel_functor
  },

  tests :
  {

    preCloneRepos,

    buildSimple,
    openNamedFast,
    openNamedForming,
    openSkippingSubButAttachedWillfilesSkippingMainPeers,
    openSkippingSubButAttachedWillfiles,
    openAnon,
    openOutNamed,
    openCurruptedUnknownField,
    openerClone,
    moduleClone,

    exportSeveralExports,
    exportSuper,
    exportSuperIn,
    exportDefaultPath,
    exportOutdated,
    exportRecursive,
    exportDotless,
    exportDotlessSingle,
    exportStepOpts,
    exportRecursiveUsingSubmodule,
    exportSteps,
    exportCourrputedOutfileUnknownSection,
    exportCourruptedOutfileSyntax,
    exportCourruptedSubmodulesDisabled,
    exportCourrputedSubmoduleOutfileUnknownSection,
    exportCourrputedSubmoduleOutfileFormatVersion,

    exportsResolve,
    buildsResolve,

    trivialResolve,
    detailedResolve,
    reflectorResolve,
    reflectorInheritedResolve,
    superResolve,
    pathsResolve,
    pathsResolveImportIn,
    pathsResolveOfSubmodules,
    pathsResolveOfSubmodulesAndOwn,
    pathsResolveOutFileOfExports,
    pathsResolveComposite,
    pathsResolveComposite2,
    pathsResolveArray,
    pathsResolveResolvedPath,
    pathsResolveFailing,

    modulesEach,
    modulesEachDuplicates,
    submodulesResolve,
    submodulesDeleteAndDownload,

    customLogger,
    resourcePathRemote,
    moduleIsNotValid

  }

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
