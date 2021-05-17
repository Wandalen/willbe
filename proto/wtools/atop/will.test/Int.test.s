( function _WillInternals_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );
  _.include( 'wProcess' );
  _.include( 'wFiles' );

  require( '../will/include/Mid.s' );
}

const _global = _global_;
const _ = _global_.wTools;

/* xxx2 : qqq2 :

should throw error instead of deleting itself!

> will .clean

willfile :

  path :
    proto : proto
    temp :
      - '{path::out}'
      - '{path::proto}'

*/

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
  })
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
      /* Dmytro : all default values for option `sync` is `null`, so each routine checks the option and applies `null`. Last time, the routine `_fileCopyDo` run async copy and throw error */
      a.fileProvider.filesReflect({ reflectMap : { [ context.repoDirPath ] : a.abs( context.suiteTempPath, '-repo' ) } });
    }
    catch( err )
    {
      _.errAttend( err );
      /* Dmytro : temporary, clean -repo directory before copying files, prevents fails in *nix systems */
      _.take( null )
      .delay( 3000 )
      .deasync();
      a.fileProvider.filesDelete( a.abs( context.suiteTempPath, '-repo' ) );
      a.fileProvider.filesReflect({ reflectMap : { [ context.repoDirPath ] : a.abs( context.suiteTempPath, '-repo' ) } });
    }
  }

  _.assert( a.fileProvider.isDir( a.originalAssetPath ) );

  return a;
}

// --
// tests
// --

function preCloneRepos( test )
{
  let context = this;
  let a = context.assetFor( test, '-repo' );

  a.ready.then( () =>
  {
    test.true( a.fileProvider.isDir( a.abs( context.repoDirPath, 'ModuleForTesting1' ) ) );
    return null;
  })

  return a.ready;
}

// --
// open
// --

function buildSimple( test )
{
  let context = this;
  let a = context.assetFor( test, 'simple' );
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'out' ) );

  var opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
  opener.find();

  return opener.open().split()
  .then( () =>
  {

    var expected = [];
    var files = /*context.find*/a.find( a.abs( 'out' ) );
    let builds = opener.openedModule.buildsResolve();

    test.identical( builds.length, 1 );

    let build = builds[ 0 ];

    return build.perform()
    .finally( ( err, arg ) =>
    {

      test.description = 'files';
      var expected = [ '.', './debug', './debug/File.js' ];
      var files = /*context.find*/a.find( a.abs( 'out' ) );
      test.identical( files, expected );

      opener.finit();

      test.description = 'no garbage left';
      test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

      if( err )
      throw err;
      return arg;
    });

  });
}

//

function openNamedFast( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoExported' );
  a.reflect()

  a.will.prefer
  ({
    allOfMain : 0,
    allOfSub : 0,
  });

  var opener1 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
  let ready1 = opener1.open();

  var opener2 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
  let ready2 = opener2.open();

  /* - */

  ready1.then( ( arg ) =>
  {
    test.case = 'opened filePath : twoExported/super';
    check( opener1 );
    return null;
  })

  /* - */

  ready1.finally( ( err, arg ) =>
  {
    test.case = 'opened filePath : twoExported/super';
    test.true( err === undefined );
    if( err )
    throw err;
    return arg;
  });

  /* - */

  ready2.then( ( arg ) =>
  {
    test.case = 'opened dirPath : twoExported/super';
    check( opener2 );
    return null;
  })

  /* - */

  ready2.finally( ( err, arg ) =>
  {
    test.case = 'opened dirPath : twoExported/super';
    test.true( err === undefined );
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake( ready1, ready2 )
  .finally( ( err, arg ) =>
  {
    if( err )
    throw err;

    test.true( opener1.openedModule === opener2.openedModule );

    var exp = [ 'super' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );

    var exp = [ 'super.ex.will.yml', 'super.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( _.props.keys( a.will.willfileWithFilePathPathMap ), a.abs( exp ) );
    var exp = [ 'super' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

    opener1.finit();

    var exp = [ 'super' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'sub.out/sub.out', 'super' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

    opener2.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

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

      'local' : a.abs( 'super' ),
      'remote' : null,
      'current.remote' : null,
      'will' : a.abs( __dirname, '../will/entry/Exec' ),
      'module.dir' : a.abs( '.' ),
      'module.willfiles' : a.abs( [ 'super.ex.will.yml', 'super.im.will.yml' ] ),
      'module.peer.willfiles' : a.abs( 'super.out/supermodule.out.will.yml' ),
      'module.peer.in' : a.abs( 'super.out' ),
      'module.original.willfiles' : a.abs( [ 'super.ex.will.yml', 'super.im.will.yml' ] ),
      'module.common' : a.abs( 'super' ),
      'download' : null,

    }

    test.identical( opener.qualifiedName, 'opener::supermodule' );
    test.identical( opener.absoluteName, 'opener::supermodule' );
    test.identical( opener.fileName, 'super' );
    test.identical( opener.aliasName, null );
    test.identical( opener.localPath, a.abs( './super' ) );
    test.identical( opener.remotePath, null );
    test.identical( opener.dirPath, a.abs( '.' ) );
    test.identical( opener.commonPath, a.abs( 'super' ) );
    test.identical( opener.willfilesPath, a.abs( [ './super.ex.will.yml', './super.im.will.yml' ] ) );
    test.identical( opener.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.props.keys( opener.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.identical( opener.openedModule.qualifiedName, 'module::supermodule' );
    test.identical( opener.openedModule.absoluteName, 'module::supermodule' );
    test.identical( opener.openedModule.inPath, a.routinePath );
    test.identical( opener.openedModule.dirPath, a.abs( '.' ) );
    test.identical( opener.openedModule.localPath, a.abs( 'super' ) );
    test.identical( opener.openedModule.remotePath, null );
    test.identical( opener.openedModule.currentRemotePath, null );
    test.identical( opener.openedModule.willPath, a.abs( __dirname, '../will/entry/Exec' ) );
    test.identical( opener.openedModule.outPath, a.abs( 'super.out' ) );
    test.identical( opener.openedModule.commonPath, a.abs( 'super' ) );
    test.identical( opener.openedModule.willfilesPath, a.abs( [ './super.ex.will.yml', './super.im.will.yml' ] ) );
    test.identical( opener.openedModule.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.true( !!opener.openedModule.about );
    test.identical( opener.openedModule.about.name, 'supermodule' );
    test.identical( opener.openedModule.pathMap, pathMap );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.submoduleMap ) ), _.setFrom( [ 'Submodule' ] ) );
    var got = _.filter_( null, _.props.keys( opener.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e );
    test.identical( _.setFrom( got ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug' ] ) );

    let steps = _.select( opener.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( _.setFrom( steps ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug', 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.buildMap ) ), _.setFrom( [ 'debug', 'release', 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.exportedMap ) ), _.setFrom( [] ) );

  }

} /* end of function openNamedFast */

//

function openNamedForming( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoExported' );
  a.reflect();

  a.will.prefer
  ({
    allOfMain : 0,
    allOfSub : 0,
    peerModulesFormedOfMain : 1,
    peerModulesFormedOfSub : 1,
  });

  let opener1 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
  let ready1 = opener1.open({ all : 1 });

  test.case = 'skipping of stages of module';
  var stager = opener1.openedModule.stager;
  test.identical( stager.stageStateSkipping( 'preformed' ), false );
  test.identical( stager.stageStateSkipping( 'opened' ), false );
  test.identical( stager.stageStateSkipping( 'attachedWillfilesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'peerModulesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'subModulesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'resourcesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'finalFormed' ), false );

  let opener2 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
  let ready2 = opener2.open();

  test.case = 'skipping of stages of module';
  var stager = opener1.openedModule.stager;
  test.identical( stager.stageStateSkipping( 'preformed' ), false );
  test.identical( stager.stageStateSkipping( 'opened' ), false );
  test.identical( stager.stageStateSkipping( 'attachedWillfilesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'peerModulesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'subModulesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'resourcesFormed' ), false );
  test.identical( stager.stageStateSkipping( 'finalFormed' ), false );

  test.case = 'structure consistency';
  test.true( a.will.mainOpener === opener1 );
  test.true( opener1.openedModule === opener2.openedModule );

  /* - */

  ready1.then( ( arg ) =>
  {
    test.case = 'opened filePath : twoExported/super';
    check( opener1 );
    return null;
  })

  /* - */

  ready1.finally( ( err, arg ) =>
  {
    test.case = 'opened filePath : twoExported/super';
    test.true( err === undefined );
    if( err )
    throw err;
    return arg;
  });

  /* - */

  ready2.then( ( arg ) =>
  {
    test.case = 'opened dirPath : twoExported/super';
    check( opener2 );
    return null;
  })

  /* - */

  ready2.finally( ( err, arg ) =>
  {
    test.case = 'opened dirPath : twoExported/super';
    test.true( err === undefined );
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake( ready1, ready2 )
  .finally( ( err, arg ) =>
  {
    if( err )
    throw err;

    test.true( opener1.openedModule === opener2.openedModule );

    test.case = 'stages';
    var stager = opener1.openedModule.stager;
    test.identical( stager.stageStatePerformed( 'preformed' ), true );
    test.identical( stager.stageStatePerformed( 'opened' ), true );
    test.identical( stager.stageStatePerformed( 'attachedWillfilesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'peerModulesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'subModulesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'resourcesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'finalFormed' ), true );

    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

    opener1.finit();

    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

    opener2.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

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

      'local' : a.abs( 'super' ),
      'remote' : null,
      'current.remote' : null,
      'will' : a.abs( __dirname, '../will/entry/Exec' ),
      'module.dir' : a.abs( '.' ),
      'module.willfiles' : a.abs( [ 'super.ex.will.yml', 'super.im.will.yml' ] ),
      'module.original.willfiles' : a.abs( [ 'super.ex.will.yml', 'super.im.will.yml' ] ),
      'module.peer.willfiles' : a.abs( 'super.out/supermodule.out.will.yml' ),
      'module.peer.in' : a.abs( 'super.out' ),
      'module.common' : a.abs( 'super' ),
      'download' : null,

    }

    test.identical( opener.qualifiedName, 'opener::supermodule' );
    test.identical( opener.absoluteName, 'opener::supermodule' );
    test.identical( opener.fileName, 'super' );
    test.identical( opener.aliasName, null );
    test.identical( opener.localPath, a.abs( './super' ) );
    test.identical( opener.remotePath, null );
    test.identical( opener.dirPath, a.abs( '.' ) );
    test.identical( opener.commonPath, a.abs( 'super' ) );
    test.identical( opener.willfilesPath, a.abs( [ './super.ex.will.yml', './super.im.will.yml' ] ) );
    test.identical( opener.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.props.keys( opener.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.identical( opener.openedModule.qualifiedName, 'module::supermodule' );
    test.identical( opener.openedModule.absoluteName, 'module::supermodule' );
    test.identical( opener.openedModule.inPath, a.routinePath );
    test.identical( opener.openedModule.dirPath, a.abs( '.' ) );
    test.identical( opener.openedModule.localPath, a.abs( 'super' ) );
    test.identical( opener.openedModule.remotePath, null );
    test.identical( opener.openedModule.currentRemotePath, null );
    test.identical( opener.openedModule.willPath, a.abs( __dirname, '../will/entry/Exec' ) );
    test.identical( opener.openedModule.outPath, a.abs( 'super.out' ) );
    test.identical( opener.openedModule.commonPath, a.abs( 'super' ) );
    test.identical( opener.openedModule.willfilesPath, a.abs( [ './super.ex.will.yml', './super.im.will.yml' ] ) );
    test.identical( opener.openedModule.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.true( !!opener.openedModule.about );
    test.identical( opener.openedModule.about.name, 'supermodule' );
    test.identical( opener.openedModule.pathMap, pathMap );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.submoduleMap ) ), _.setFrom( [ 'Submodule' ] ) );
    test.identical( _.setFrom( _.filter_( null, _.props.keys( opener.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ) ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug' ] ) );

    let steps = _.select( opener.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( _.setFrom( steps ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug', 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.buildMap ) ), _.setFrom( [ 'debug', 'release', 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.exportedMap ) ), _.setFrom( [] ) );

  }

} /* end of function openNamedForming */

//

function openSkippingSubButAttachedWillfilesSkippingMainPeers( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoExported' );
  let opener1, ready1, opener2, ready2;
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.description = 'first run';

    a.reflect();

    a.will.prefer
    ({
      allOfMain : 1,
      peerModulesFormedOfMain : 0,
      attachedWillfilesFormedOfSub : 1,
      // peerModulesFormedOfSub : 0,
    });

    opener1 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) })
    ready1 = opener1.open();
    opener2 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    ready2 = opener2.open({});

    return _.Consequence.AndTake( ready1, ready2 )
  })

  .finally( ( err, arg ) => check( err, arg ) );

  /* - */

  a.ready
  .then( () =>
  {
    test.description = 'second run';
    a.reflect();

    a.will.instanceDefaultsReset();

    a.will.prefer
    ({
      allOfMain : 1,
      peerModulesFormedOfMain : 0,
      attachedWillfilesFormedOfSub : 1,
      // peerModulesFormedOfSub : 0,
    });

    opener1 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) })
    ready1 = opener1.open();
    opener2 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    ready2 = opener2.open({});

    return _.Consequence.AndTake( ready1, ready2 )
  })

  .finally( ( err, arg ) => check( err, arg ) );

  /* - */

  return a.ready;

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
    test.identical( stager.stageStateSkipping( 'finalFormed' ), false );

    test.case = 'structure consistency';
    test.true( a.will.mainOpener === opener1 );
    test.true( opener1.openedModule === opener2.openedModule );

    var exp = [ 'super', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    var exp = [ 'super', 'sub.out/sub.out', 'sub' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );

    opener1.finit();

    var exp = [ 'super', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'sub.out/sub.out', 'sub', 'super' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'sub.out/sub.out', 'sub' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );
    opener2.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return arg;
  }

} /* end of function openSkippingSubButAttachedWillfilesSkippingMainPeers */

//

function openSkippingSubButAttachedWillfiles( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoExported' );
  let opener1, ready1, opener2, ready2;
  a.reflect();

  /* - */

  a.ready
  .then( () =>
  {
    test.description = 'first run';
    a.reflect();

    a.will.prefer
    ({
      allOfMain : 1,
      attachedWillfilesFormedOfSub : 1,
      subModulesFormedOfSub : 0,
    });

    opener1 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) })
    ready1 = opener1.open();
    opener2 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    ready2 = opener2.open();

    return _.Consequence.AndTake( ready1, ready2 )
  })
  .finally( ( err, arg ) => check( err, arg ) );

  /* - */

  a.ready
  .then( () =>
  {
    test.description = 'second run';

    a.will.instanceDefaultsReset();

    a.will.prefer
    ({
      allOfMain : 1,
      subModulesFormedOfSub : 0,
    });

    opener1 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) })
    ready1 = opener1.open();
    opener2 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    ready2 = opener2.open();

    return _.Consequence.AndTake( ready1, ready2 )
  })
  .finally( ( err, arg ) => check( err, arg ) );

  /* - */

  return a.ready;

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
    test.identical( stager.stageStateSkipping( 'finalFormed' ), false );
    test.identical( stager.stageStatePerformed( 'preformed' ), true );
    test.identical( stager.stageStatePerformed( 'opened' ), true );
    test.identical( stager.stageStatePerformed( 'attachedWillfilesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'peerModulesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'subModulesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'resourcesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'finalFormed' ), true );

    test.case = 'skipping of stages of module';
    var stager = a.will.moduleWithNameMap.Submodule.stager;
    test.identical( stager.stageStateSkipping( 'preformed' ), false );
    test.identical( stager.stageStateSkipping( 'opened' ), false );
    test.identical( stager.stageStateSkipping( 'attachedWillfilesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'peerModulesFormed' ), false );
    test.identical( stager.stageStateSkipping( 'subModulesFormed' ), true );
    test.identical( stager.stageStateSkipping( 'resourcesFormed' ), true );
    test.identical( stager.stageStateSkipping( 'finalFormed' ), false );

    test.identical( stager.stageStatePerformed( 'preformed' ), true );
    test.identical( stager.stageStatePerformed( 'opened' ), true );
    test.identical( stager.stageStatePerformed( 'attachedWillfilesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'peerModulesFormed' ), true );
    test.identical( stager.stageStatePerformed( 'subModulesFormed' ), false );
    test.identical( stager.stageStatePerformed( 'resourcesFormed' ), false );
    test.identical( stager.stageStatePerformed( 'finalFormed' ), true );

    test.case = 'structure consistency';
    test.true( a.will.mainOpener === opener1 );
    test.true( opener1.openedModule === opener2.openedModule );

    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super', 'sub.out/sub.out', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub', 'super' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

    opener1.finit();

    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'sub.out/sub.out', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub', 'super' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

    opener2.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return arg;
  }

} /* end of function openSkippingSubButAttachedWillfiles */

//

function openAnon( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoAnonExported' );
  a.reflect();

  /* */


  var opener1 = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
  let ready1 = opener1.open();
  var opener2 = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) + '/' });
  let ready2 = opener2.open();

  /* - */

  ready1.then( ( arg ) =>
  {
    test.case = 'opened filePath : twoAnonExported/.';
    check( opener1 );
    return null;
  })

  /* - */

  ready1.finally( ( err, arg ) =>
  {
    test.case = 'opened filePath : twoAnonExported/.';
    test.true( err === undefined );
    opener1.finit();
    if( err )
    throw err;
    return arg;
  });

  /* - */

  ready2.then( ( arg ) =>
  {
    test.case = 'opened dirPath : twoAnonExported/.';
    check( opener2 );
    return null;
  })

  /* - */

  ready2.finally( ( err, arg ) =>
  {
    test.case = 'opened dirPath : twoAnonExported/.';
    test.true( err === undefined );
    opener2.finit();
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake( ready1, ready2 )
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
      'will' : a.abs( __dirname, '../will/entry/Exec' ),
      'local' : a.abs( './' ),
      'remote' : null,
      'proto' : 'proto',
      'temp' : [ 'super.out', 'sub.out' ],
      'in' : '.',
      'out' : 'super.out',
      'out.debug' : 'super.out/debug',
      'out.release' : 'super.out/release',
      'module.willfiles' : a.abs([ '.ex.will.yml', '.im.will.yml' ]),
      'module.dir' : a.abs( '.' ),
      'module.common' : a.abs( './' ),
      'module.original.willfiles' : a.abs([ '.ex.will.yml', '.im.will.yml' ]),
      'module.peer.willfiles' : a.abs( 'super.out/supermodule.out.will.yml' ),
      'module.peer.in' : a.abs( 'super.out' ),
      'download' : null,
    }

    test.identical( opener.qualifiedName, 'opener::supermodule' );
    test.identical( opener.absoluteName, 'opener::supermodule' );
    test.identical( opener.dirPath, a.abs( '.' ) );
    test.identical( opener.commonPath, a.abs( '.' ) + '/' );
    test.identical( _.setFrom( opener.willfilesPath ), _.setFrom( a.abs([ '.im.will.yml', '.ex.will.yml' ]) ) );
    test.identical( opener.fileName, 'openAnon' );
    test.identical( opener.aliasName, null );
    test.identical( opener.localPath, a.abs( './' ) );
    test.identical( opener.remotePath, null );
    test.identical( opener.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.props.keys( opener.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.identical( opener.openedModule.qualifiedName, 'module::supermodule' );
    test.identical( opener.openedModule.absoluteName, 'module::supermodule' );
    test.identical( opener.openedModule.inPath, a.abs( '.' ) );
    test.identical( opener.openedModule.dirPath, a.abs( '.' ) );
    test.identical( opener.openedModule.outPath, a.abs( 'super.out' ) );
    test.identical( opener.openedModule.commonPath, a.abs( './' ) );
    test.identical( _.setFrom( opener.openedModule.willfilesPath ), _.setFrom( a.abs([ '.im.will.yml', '.ex.will.yml' ]) ) );
    test.identical( opener.openedModule.localPath, a.abs( './' ) );
    test.identical( opener.openedModule.remotePath, null );
    test.identical( opener.openedModule.currentRemotePath, null );
    test.identical( opener.openedModule.willPath, a.abs( __dirname, '../will/entry/Exec' ) );
    test.identical( opener.openedModule.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.true( !!opener.openedModule.about );
    test.identical( opener.openedModule.about.name, 'supermodule' );
    test.identical( opener.openedModule.pathMap, pathMap );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.submoduleMap ) ), _.setFrom( [ 'Submodule' ] ) );
    test.identical( _.setFrom( _.filter_( null, _.props.keys( opener.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ) ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug' ] ) );

    let steps = _.select( opener.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( _.setFrom( steps ), _.setFrom( [ 'export.', 'export.debug', 'reflect.submodules.', 'reflect.submodules.debug' ] ) );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.buildMap ) ), _.setFrom( [ 'export.', 'export.debug', 'debug', 'release' ] ) );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.exportedMap ) ), _.setFrom( [] ) );
  }

}

//

function openOutNamed( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoExported' );
  a.reflect();

  var opener1 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super.out/supermodule' ) });
  let ready1 = opener1.open();
  var opener2 = a.will.openerMakeManual({ willfilesPath : a.abs( 'super.out/supermodule.out' ) });
  let ready2 = opener2.open();

  /* - */

  ready1.then( ( arg ) =>
  {
    test.case = 'opened filePath : twoExported/super.out/supermodule';
    check( opener1 );
    return null;
  })

  ready1.finally( ( err, arg ) =>
  {
    test.case = 'opened filePath : twoExported/super.out/supermodule';
    test.true( err === undefined );
    opener1.finit();
    if( err )
    throw err;
    return arg;
  });

  /* - */

  ready2.then( ( arg ) =>
  {
    test.case = 'opened dirPath : twoExported/super.out/supermodule';
    check( opener2 );
    return null;
  })

  ready2.finally( ( err, arg ) =>
  {
    test.case = 'opened dirPath : twoExported/super.out/supermodule';
    test.true( err === undefined );
    opener2.finit();
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake( ready1, ready2 )
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
      'will' : a.abs( __dirname, '../will/entry/Exec' ),
      'module.original.willfiles' :
      [
        a.abs( './super.ex.will.yml' ),
        a.abs( './super.im.will.yml' ),
      ],
      'local' : a.abs( './super.out/supermodule.out' ),
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
      'module.willfiles' : a.abs( './super.out/supermodule.out.will.yml' ),
      'module.dir' : a.abs( './super.out' ),
      'module.common' : a.abs( './super.out/supermodule.out' ),
      'download' : null,
      'module.peer.in' : a.abs( '.' ),
      'module.peer.willfiles' :
      [
        a.abs( './super.ex.will.yml' ),
        a.abs( './super.im.will.yml' )
      ]
    }

    test.identical( opener.qualifiedName, 'opener::supermodule' );
    test.identical( opener.absoluteName, 'opener::supermodule' );
    test.identical( opener.dirPath, a.abs( './super.out' ) );
    test.identical( opener.localPath, a.abs( './super.out/supermodule.out' ) );
    test.identical( opener.willfilesPath, a.abs( './super.out/supermodule.out.will.yml' ) );
    test.identical( opener.commonPath, a.abs( 'super.out/supermodule.out' ) );
    test.identical( opener.fileName, 'supermodule.out' );
    test.identical( opener.aliasName, null );

    test.identical( opener.openedModule.qualifiedName, 'module::supermodule' );
    test.identical( opener.openedModule.absoluteName, 'module::supermodule / module::supermodule' );
    test.identical( opener.openedModule.dirPath, a.abs( './super.out' ) );
    test.identical( opener.openedModule.localPath, a.abs( './super.out/supermodule.out' ) );
    test.identical( opener.openedModule.willfilesPath, a.abs( './super.out/supermodule.out.will.yml' ) );
    test.identical( opener.openedModule.commonPath, a.abs( 'super.out/supermodule.out' ) );
    test.identical( opener.openedModule.fileName, 'supermodule.out' );

    test.true( !!opener.openedModule.about );
    test.identical( opener.openedModule.about.name, 'supermodule' );

    test.identical( opener.openedModule.pathMap, pathMap );
    test.identical( opener.openedModule.willfilesArray.length, 1 );
    test.identical( _.props.keys( opener.openedModule.willfileWithRoleMap ), [ 'single' ] );
    test.identical( _.props.keys( opener.openedModule.submoduleMap ), [ 'Submodule' ] );
    test.identical( _.setFrom( _.filter_( null, _.props.keys( opener.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ) ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug', 'exported.export.debug', 'exported.files.export.debug', 'exported.export.', 'exported.files.export.' ] ) );

    let steps = _.select( opener.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( _.setFrom( steps ), _.setFrom( [ 'reflect.submodules.', 'reflect.submodules.debug', 'export.', 'export.debug', 'exported.export.debug', 'exported.files.export.debug', 'exported.export.', 'exported.files.export.' ] ) );

    test.identical( _.setFrom( _.props.keys( opener.openedModule.buildMap ) ), _.setFrom( [ 'debug', 'release', 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.exportedMap ) ), _.setFrom( [ 'export.', 'export.debug' ] ) );

  }

} /* end of function openOutNamed */

//

function openCurruptedUnknownField( test )
{
  let context = this;
  let a = context.assetFor( test, 'corruptedInfileUnknownField' );
  let opener;

  /* - */

  a.ready.then( ( arg ) =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });
    return opener.open({ all : 1 });
  })

  /* - */

  .finally( ( err, arg ) =>
  {
    test.true( _.errIs( err ) );
    _.errAttend( err );

    check( opener );

    var exp = [ 'sub' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'sub' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

    opener.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  })

  /* - */

  .finally( ( err, arg ) =>
  {
    test.case = 'opened dirPath : corruptedInfileUnknownField/sub';
    test.true( err === undefined );
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
      'will' : a.abs( __dirname, '../will/entry/Exec' ),
      'module.dir' : a.abs( '.' ),
      'local' : a.abs( 'sub' ),
      'module.willfiles' : a.abs( [ './sub.ex.will.yml', './sub.im.will.yml' ] ),
      'module.original.willfiles' : a.abs( [ './sub.ex.will.yml', './sub.im.will.yml' ] ),
      'module.peer.willfiles' : a.abs( 'sub.out.will.yml' ),
      'module.peer.in' : a.abs( '.' ),
      'module.common' : a.abs( 'sub' ),
      'download' : null,

    }

    test.identical( opener.qualifiedName, 'opener::sub' );
    test.identical( opener.absoluteName, 'opener::sub' );
    test.identical( opener.fileName, 'sub' );
    test.identical( opener.aliasName, null );
    test.identical( opener.remotePath, null );
    test.identical( opener.dirPath, a.abs( '.' ) );
    test.identical( opener.commonPath, a.abs( 'sub' ) );
    test.identical( opener.willfilesPath, a.abs( [ './sub.ex.will.yml', './sub.im.will.yml' ] ) );
    test.identical( opener.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.props.keys( opener.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.identical( opener.openedModule.qualifiedName, 'module::sub' );
    test.identical( opener.openedModule.absoluteName, 'module::sub' );
    test.identical( opener.openedModule.inPath, a.routinePath );
    test.identical( opener.openedModule.dirPath, a.abs( '.' ) );
    test.identical( opener.openedModule.remotePath, null );
    test.identical( opener.openedModule.currentRemotePath, null );
    test.identical( opener.openedModule.willPath, a.abs( __dirname, '../will/entry/Exec' ) );
    test.identical( opener.openedModule.outPath, a.abs( 'sub.out' ) );
    test.identical( opener.openedModule.commonPath, a.abs( 'sub' ) );
    test.identical( opener.openedModule.willfilesPath, a.abs( [ './sub.ex.will.yml', './sub.im.will.yml' ] ) );
    test.identical( opener.openedModule.willfilesArray.length, 2 );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.willfileWithRoleMap ) ), _.setFrom( [ 'import', 'export' ] ) );

    test.true( !opener.isValid() );
    test.true( !opener.openedModule.isValid() );

    test.true( !!opener.openedModule.about );
    test.identical( opener.openedModule.about.name, 'sub' );
    test.identical( opener.openedModule.pathMap, pathMap );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.submoduleMap ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.filter_( null, _.props.keys( opener.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ) ), _.setFrom( [] ) );

    let steps = _.select( opener.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( _.setFrom( steps ), _.setFrom( [ 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.buildMap ) ), _.setFrom( [ 'export.', 'export.debug' ] ) );
    test.identical( _.setFrom( _.props.keys( opener.openedModule.exportedMap ) ), _.setFrom( [] ) );

  }

} /* end of function openCurruptedUnknownField */

//

function openerClone( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.description = 'open';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    return opener.open();
  })

  a.ready.then( ( arg ) =>
  {
    test.case = 'clone';

    test.description = 'paths of module';
    test.identical( a.rel( opener.openedModule.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.openedModule.dirPath ), '.' );
    test.identical( a.rel( opener.openedModule.commonPath ), 'super' );
    test.identical( a.rel( opener.openedModule.inPath ), '.' );
    test.identical( a.rel( opener.openedModule.outPath ), 'super.out' );
    test.identical( a.rel( opener.openedModule.localPath ), 'super' );
    test.identical( a.rel( opener.openedModule.remotePath ), null );
    test.identical( opener.openedModule.willPath, a.abs( __dirname, '../will/entry/Exec' ) );

    test.description = 'paths of original opener';
    test.identical( a.rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.dirPath ), '.' );
    test.identical( a.rel( opener.commonPath ), 'super' );
    test.identical( a.rel( opener.localPath ), 'super' );
    test.identical( a.rel( opener.remotePath ), null );

    var opener2 = opener.clone();

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.props.keys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.true( !!opener.openedModule );
    test.true( opener2.openedModule === null );

    test.description = 'paths of original opener';
    test.identical( a.rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.dirPath ), '.' );
    test.identical( a.rel( opener.commonPath ), 'super' );
    test.identical( a.rel( opener.localPath ), 'super' );
    test.identical( a.rel( opener.remotePath ), null );
    test.identical( opener.formed, 5 );

    test.description = 'paths of opener2';
    test.identical( a.rel( opener2.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener2.dirPath ), '.' );
    test.identical( a.rel( opener2.commonPath ), 'super' );
    test.identical( a.rel( opener2.localPath ), 'super' );
    test.identical( a.rel( opener2.remotePath ), null );
    test.identical( opener2.formed, 0 );

    opener2.close();

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.props.keys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.true( !!opener.openedModule );
    test.true( opener2.openedModule === null );

    test.description = 'paths of original opener';
    test.identical( a.rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.dirPath ), '.' );
    test.identical( a.rel( opener.commonPath ), 'super' );
    test.identical( a.rel( opener.localPath ), 'super' );
    test.identical( a.rel( opener.remotePath ), null );

    test.description = 'paths of opener2';
    test.identical( a.rel( opener2.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener2.dirPath ), '.' );
    test.identical( a.rel( opener2.commonPath ), 'super' );
    test.identical( a.rel( opener2.localPath ), 'super' );
    test.identical( a.rel( opener2.remotePath ), null );

    opener2.find();

    test.case = 'compare elements';
    test.true( opener.openedModule === opener2.openedModule );
    test.identical( opener.qualifiedName, opener2.qualifiedName );
    test.identical( opener.absoluteName, opener2.absoluteName );
    test.true( opener.openedModule.about === opener2.openedModule.about );
    test.true( opener.openedModule.pathMap === opener2.openedModule.pathMap );
    test.identical( opener.openedModule.pathMap, opener2.openedModule.pathMap );
    test.true( opener.willfilesArray !== opener2.willfilesArray );
    test.true( opener.willfileWithRoleMap !== opener2.willfileWithRoleMap );

    test.case = 'finit';
    opener2.finit();
    return null;
  })

  a.ready.then( ( arg ) =>
  {
    test.case = 'clone extending';

    test.description = 'paths of module';
    test.identical( a.rel( opener.openedModule.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.openedModule.dirPath ), '.' );
    test.identical( a.rel( opener.openedModule.commonPath ), 'super' );
    test.identical( a.rel( opener.openedModule.inPath ), '.' );
    test.identical( a.rel( opener.openedModule.outPath ), 'super.out' );
    test.identical( a.rel( opener.openedModule.localPath ), 'super' );
    test.identical( a.rel( opener.openedModule.remotePath ), null );
    test.identical( opener.openedModule.willPath, a.abs( __dirname, '../will/entry/Exec' ) );

    test.description = 'paths of original opener';
    test.identical( a.rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.dirPath ), '.' );
    test.identical( a.rel( opener.commonPath ), 'super' );
    test.identical( a.rel( opener.localPath ), 'super' );
    test.identical( a.rel( opener.remotePath ), null );

    opener.peerModule.finit();
    var opener2 = opener.cloneExtending({ willfilesPath : a.abs( 'sub' ) });

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.props.keys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.true( !!opener.openedModule );
    test.true( opener2.openedModule === null );

    test.description = 'paths of original opener';
    test.identical( a.rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.dirPath ), '.' );
    test.identical( a.rel( opener.commonPath ), 'super' );
    test.identical( a.rel( opener.localPath ), 'super' );
    test.identical( a.rel( opener.remotePath ), null );

    test.description = 'paths of opener2';
    test.identical( opener2.formed, 0 );
    test.identical( a.rel( opener2.willfilesPath ), 'sub' );
    test.identical( a.rel( opener2.dirPath ), '.' );
    test.identical( a.rel( opener2.commonPath ), 'sub' );
    test.identical( a.rel( opener2.localPath ), 'sub' );
    test.identical( a.rel( opener2.downloadPath ), null );
    test.identical( a.rel( opener2.remotePath ), null );

    opener2.preform();

    test.description = 'paths of opener2';
    test.identical( a.rel( opener2.willfilesPath ), 'sub' );
    test.identical( a.rel( opener2.dirPath ), '.' );
    test.identical( a.rel( opener2.commonPath ), 'sub' );
    test.identical( a.rel( opener2.localPath ), 'sub' );
    test.identical( a.rel( opener2.downloadPath ), null );
    test.identical( a.rel( opener2.remotePath ), null );

    opener2.close();

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.props.keys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.true( !!opener.openedModule );
    test.true( opener2.openedModule === null );

    test.description = 'paths of original opener';
    test.identical( a.rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.dirPath ), '.' );
    test.identical( a.rel( opener.commonPath ), 'super' );
    test.identical( a.rel( opener.localPath ), 'super' );
    test.identical( a.rel( opener.remotePath ), null );

    test.description = 'paths of opener2';
    test.identical( a.rel( opener2.willfilesPath ), 'sub' );
    test.identical( a.rel( opener2.dirPath ), '.' );
    test.identical( a.rel( opener2.commonPath ), 'sub' );
    test.identical( a.rel( opener2.localPath ), 'sub' );
    test.identical( a.rel( opener2.remotePath ), null );

    opener2.find();

    test.description = 'paths of opener2';
    test.identical( a.rel( opener2.willfilesPath ), [ 'sub.ex.will.yml', 'sub.im.will.yml' ] );
    test.identical( a.rel( opener2.dirPath ), '.' );
    test.identical( a.rel( opener2.commonPath ), 'sub' );
    test.identical( a.rel( opener2.localPath ), 'sub' );
    test.identical( a.rel( opener2.remotePath ), null );

    test.case = 'compare elements';
    test.true( opener.openedModule !== opener2.openedModule );
    test.identical( opener2.qualifiedName, 'opener::sub' );
    test.identical( opener2.absoluteName, 'opener::sub' );
    test.true( opener.willfilesArray !== opener2.willfilesArray );
    test.true( opener.willfileWithRoleMap !== opener2.willfileWithRoleMap );

    test.case = 'finit';
    opener2.finit();
    return null;
  })

  /* - */

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );

    opener.finit();

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return arg;
  });

  return a.ready;

} /* end of function openerClone */

//

function moduleClone( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.description = 'open';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    return opener.open();
  })

  a.ready.then( ( arg ) =>
  {
    test.case = 'clone';

    test.description = 'paths of module';
    test.identical( a.rel( opener.openedModule.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.openedModule.dirPath ), '.' );
    test.identical( a.rel( opener.openedModule.commonPath ), 'super' );
    test.identical( a.rel( opener.openedModule.inPath ), '.' );
    test.identical( a.rel( opener.openedModule.outPath ), 'super.out' );
    test.identical( a.rel( opener.openedModule.localPath ), 'super' );
    test.identical( a.rel( opener.openedModule.remotePath ), null );
    test.identical( opener.openedModule.willPath, a.abs( __dirname, '../will/entry/Exec' ) );

    test.description = 'paths of original opener';
    test.identical( a.rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.dirPath ), '.' );
    test.identical( a.rel( opener.commonPath ), 'super' );
    test.identical( a.rel( opener.localPath ), 'super' );
    test.identical( a.rel( opener.remotePath ), null );

    var module = opener.openedModule;
    var opener2 = opener.clone();
    opener2.close();

    var module2 = opener.openedModule.cloneExtending({ willfilesPath : a.abs( 'super2.out/super.out.will.yml' ), peerModule : null });
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
    test.identical( stager.stageStatePerformed( 'finalFormed' ), false );

    test.description = 'paths of module2';
    test.identical( a.rel( module2.willfilesPath ), 'super2.out/super.out.will.yml' );
    test.identical( a.rel( module2.dirPath ), 'super2.out' );
    test.identical( a.rel( module2.commonPath ), 'super2.out/super.out' );
    test.identical( a.rel( module2.inPath ), 'super2.out' );
    test.identical( a.rel( module2.outPath ), 'super2.out/super.out' );
    test.identical( a.rel( module2.localPath ), 'super2.out/super.out' );
    test.identical( a.rel( module2.remotePath ), null );
    test.identical( module2.willPath, a.abs( __dirname, '../will/entry/Exec' ) );

    opener2.moduleAdopt( module2 );

    test.description = 'instances';
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub', 'super2.out/super.out' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super', 'sub.out/sub.out', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub', 'super2.out/sub.out/sub.out', 'super2.out/super.out' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.props.keys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.true( opener.openedModule instanceof _.will.Module );
    test.true( opener2.openedModule instanceof _.will.Module );
    test.true( opener.openedModule !== opener2.openedModule );
    test.true( !module.isFinited() );
    test.true( !opener.isFinited() );
    test.true( !module2.isFinited() );
    test.true( !opener2.isFinited() );
    test.true( module.isUsed() );
    test.true( opener.isUsed() );
    test.true( module2.isUsed() );
    test.true( opener2.isUsed() );

    test.description = 'paths of original module';
    test.identical( a.rel( opener.openedModule.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.openedModule.dirPath ), '.' );
    test.identical( a.rel( opener.openedModule.commonPath ), 'super' );
    test.identical( a.rel( opener.openedModule.inPath ), '.' );
    test.identical( a.rel( opener.openedModule.outPath ), 'super.out' );
    test.identical( a.rel( opener.openedModule.localPath ), 'super' );
    test.identical( a.rel( opener.openedModule.remotePath ), null );
    test.identical( opener.openedModule.willPath, a.abs( __dirname, '../will/entry/Exec' ) );

    test.description = 'paths of original opener';
    test.identical( a.rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.dirPath ), '.' );
    test.identical( a.rel( opener.commonPath ), 'super' );
    test.identical( a.rel( opener.localPath ), 'super' );
    test.identical( a.rel( opener.remotePath ), null );

    test.description = 'paths of module2';
    test.identical( a.rel( opener2.openedModule.willfilesPath ), 'super2.out/super.out.will.yml' );
    test.identical( a.rel( opener2.openedModule.dirPath ), 'super2.out' );
    test.identical( a.rel( opener2.openedModule.commonPath ), 'super2.out/super.out' );
    test.identical( a.rel( opener2.openedModule.inPath ), 'super2.out' );
    test.identical( a.rel( opener2.openedModule.outPath ), 'super2.out/super.out' );
    test.identical( a.rel( opener2.openedModule.localPath ), 'super2.out/super.out' );
    test.identical( a.rel( opener2.openedModule.remotePath ), null );
    test.identical( opener2.openedModule.willPath, a.abs( __dirname, '../will/entry/Exec' ) );

    test.description = 'paths of opener2';
    test.identical( a.rel( opener2.willfilesPath ), 'super2.out/super.out.will.yml' );
    test.identical( a.rel( opener2.dirPath ), 'super2.out' );
    test.identical( a.rel( opener2.commonPath ), 'super2.out/super.out' );
    test.identical( a.rel( opener2.localPath ), 'super2.out/super.out' );
    test.identical( a.rel( opener2.remotePath ), null );

    opener2.close();

    test.description = 'instances';
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super', 'sub.out/sub.out', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub', 'super2.out/super.out' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.props.keys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.true( opener.openedModule instanceof _.will.Module );
    test.true( opener2.openedModule === null );
    test.true( opener.openedModule !== opener2.openedModule );
    test.true( !module.isFinited() );
    test.true( !opener.isFinited() );
    test.true( module2.isFinited() );
    test.true( !opener2.isFinited() );
    test.true( module.isUsed() );
    test.true( opener.isUsed() );
    test.true( !module2.isUsed() );
    test.true( !opener2.isUsed() );

    test.description = 'paths of original module';
    test.identical( a.rel( opener.openedModule.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.openedModule.dirPath ), '.' );
    test.identical( a.rel( opener.openedModule.commonPath ), 'super' );
    test.identical( a.rel( opener.openedModule.inPath ), '.' );
    test.identical( a.rel( opener.openedModule.outPath ), 'super.out' );
    test.identical( a.rel( opener.openedModule.localPath ), 'super' );
    test.identical( a.rel( opener.openedModule.remotePath ), null );
    test.identical( opener.openedModule.willPath, a.abs( __dirname, '../will/entry/Exec' ) );

    test.description = 'paths of original opener';
    test.identical( a.rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.dirPath ), '.' );
    test.identical( a.rel( opener.commonPath ), 'super' );
    test.identical( a.rel( opener.localPath ), 'super' );
    test.identical( a.rel( opener.remotePath ), null );

    test.description = 'paths of opener2';
    test.identical( a.rel( opener2.willfilesPath ), 'super2.out/super.out.will.yml' );
    test.identical( a.rel( opener2.dirPath ), 'super2.out' );
    test.identical( a.rel( opener2.commonPath ), 'super2.out/super.out' );
    test.identical( a.rel( opener2.localPath ), 'super2.out/super.out' );
    test.identical( a.rel( opener2.remotePath ), null );

    opener2.finit();
    opener.openedModule = null;

    test.description = 'instances';
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
    var exp = [ 'super', 'sub.out/sub.out', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
    test.identical( _.props.keys( a.will.openerModuleWithIdMap ).length, exp.length );
    var exp = [ 'super.ex.will.yml', 'super.im.will.yml', 'super.out/supermodule.out.will.yml', 'sub.out/sub.out.will.yml', 'sub.ex.will.yml', 'sub.im.will.yml' ];
    test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
    test.identical( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ), exp );
    var exp = [ 'super', 'super.out/supermodule.out', 'sub.out/sub.out', 'sub' ];
    test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

    test.description = 'elements';
    test.identical( opener2.willfilesArray.length, 0 );
    test.identical( _.setFrom( _.props.keys( opener2.willfileWithRoleMap ) ), _.setFrom( [] ) );
    test.true( opener.openedModule === null );
    test.true( opener2.openedModule === null );
    test.true( !module.isFinited() );
    test.true( !opener.isFinited() );
    test.true( module2.isFinited() );
    test.true( opener2.isFinited() );
    test.true( module.isUsed() );
    test.true( !opener.isUsed() );
    test.true( !module2.isUsed() );
    test.true( !opener2.isUsed() );

    test.description = 'paths of original opener';
    test.identical( a.rel( opener.willfilesPath ), [ 'super.ex.will.yml', 'super.im.will.yml' ] );
    test.identical( a.rel( opener.dirPath ), '.' );
    test.identical( a.rel( opener.commonPath ), 'super' );
    test.identical( a.rel( opener.localPath ), 'super' );
    test.identical( a.rel( opener.remotePath ), null );

    test.description = 'paths of opener2';
    test.identical( a.rel( opener2.willfilesPath ), 'super2.out/super.out.will.yml' );
    test.identical( a.rel( opener2.dirPath ), 'super2.out' );
    test.identical( a.rel( opener2.commonPath ), 'super2.out/super.out' );
    test.identical( a.rel( opener2.localPath ), 'super2.out/super.out' );
    test.identical( a.rel( opener2.remotePath ), null );

    test.case = 'finit';
    opener.finit();
    module.finit();
    return null;
  })

  /* - */

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return arg;
  });

  return a.ready;

  /* */

  function mapsCheck( module1, module2 )
  {

    test.true( module1 !== module2 );
    if( module1 === module2 )
    {
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

    test.true( module1 !== module2 );
    test.true( module1[ mapName ] !== module2[ mapName ] );
    test.identical( _.setFrom( _.props.keys( module1[ mapName ] ) ), _.setFrom( _.props.keys( module2[ mapName ] ) ) );
    for( var k in module1[ mapName ] )
    {
      var resource1 = module1[ mapName ][ k ];
      var resource2 = module2[ mapName ][ k ];
      test.true( !!resource1 );
      test.true( !!resource2 );
      if( !resource1 || !resource2 )
      continue;
      if( resource1 === resource2 )
      debugger;
      test.true( resource1 !== resource2 );
      test.true( resource1.module === module1 );
      test.true( resource2.module === module2 );
      if( resource1 instanceof _.will.Resource )
      {
        test.true( !!resource1.willf || ( resource1.criterion && !!resource1.criterion.predefined ) );
        test.true( resource1.willf === resource2.willf );
      }
    }

  }

} /* end of function moduleClone */

//

function modulesUpform( test )
{
  let context = this;
  let a = context.assetFor( test, 'modulesUpform' );
  let openers;

  /* - */

  begin({ selector : a.abs( './a' ), transaction : { withSubmodules : 0 } })
  .then( () =>
  {
    test.case = 'module with nested submodules, withSubmodules:0';
    let o2 =
    {
      modules : openers,
    }
    var exp = [ 'module::a' ]
    test.identical( _.select( a.will.modulesArray, '*/qualifiedName' ), exp );

    a.will.transaction.extend({ withSubmodules : 0 })

    return a.will.modulesUpform( o2 )
    .then( ( op ) =>
    {
      var exp = [ 'module::a' ]
      test.identical( _.select( a.will.modulesArray, '*/qualifiedName' ), exp );

      return op;
    })
  })
  end()

  /* - */

  begin({ selector : a.abs( './a' ), transaction : { withSubmodules : 0 } })
  .then( () =>
  {
    test.case = 'module with nested submodules, withSubmodules:1';
    let o2 =
    {
      modules : openers,
    }
    var exp = [ 'module::a' ]
    test.identical( _.select( a.will.modulesArray, '*/qualifiedName' ), exp );

    a.will.transaction.extend({ withSubmodules : 1 })

    return a.will.modulesUpform( o2 )
    .then( ( op ) =>
    {
      var exp = [ 'module::a', 'module::b' ]
      test.identical( _.select( a.will.modulesArray, '*/qualifiedName' ), exp );

      return op;
    })
  })
  end()

  /* - */

  begin({ selector : a.abs( './a' ), transaction : { withSubmodules : 0 } })
  .then( () =>
  {
    test.case = 'module with nested submodules, withSubmodules:2';
    let o2 =
    {
      modules : openers,
    }
    var exp = [ 'module::a' ]
    test.identical( _.select( a.will.modulesArray, '*/qualifiedName' ), exp );

    a.will.transaction.extend({ withSubmodules : 2 })

    return a.will.modulesUpform( o2 )
    .then( ( op ) =>
    {
      var exp = [ 'module::a', 'module::b', 'module::c', 'module::d' ]
      test.identical( _.select( a.will.modulesArray, '*/qualifiedName' ), exp );

      return op;
    })
  })
  end()

  /* - */

  return a.ready;

  /* - */

  function begin( o2 )
  {
    a.ready.then( () =>
    {
      a.fileProvider.filesDelete( a.abs( '.' ) );
      a.reflect();

      a.will.transaction.finit();
      a.will.transaction = _.will.Transaction({ targetLogger : a.will.logger, ... o2.transaction || {} });

      let opener = a.will.openerMakeManual({ willfilesPath : o2.selector });
      openers = [ opener ];

      return opener.open();
    })

    return a.ready;
  }

  /* - */

  function end()
  {
    return a.ready.then( () =>
    {
      _.each( openers, ( opener ) => opener.finit() )
      return null;
    });
  }
}

// --
// export
// --

function exportModuleAndCheckDefaultPathsSimple( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportWithDefaultPaths' );
  let opener;
  a.reflect();

  /* - */

  a.ready.then( () =>
  {
    test.case = 'export';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    a.will.prefer({ allOfMain : 0, allOfSub : 0 });
    a.will.readingBegin();
    return opener.open();
  });

  a.ready.then( () =>
  {
    let module = opener.openedModule;
    test.identical( module.pathResourceMap.download.path, null );
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    return build.perform();
  });

  a.ready.then( ( op ) =>
  {
    test.case = 'check export file';
    let config = a.fileProvider.fileReadUnknown( a.abs( 'out/ExportWithDefaultPaths.out.will.yml' ) )

    let path = config.module[ 'ExportWithDefaultPaths.out' ].path;
    let expected =
    {
      'criterion' : { 'predefined' : 1 }
    }
    test.identical( path.download, expected );

    opener.finit();
    return null;
  });

  /* */

  a.ready.then( () =>
  {
    test.case = 'reexport';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    a.will.prefer({ allOfMain : 0, allOfSub : 0 });
    a.will.readingBegin();
    return opener.open();
  });

  a.ready.then( () =>
  {
    let module = opener.openedModule;
    test.identical( module.pathResourceMap.download.path, null );
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    return build.perform();
  });

  a.ready.then( ( op ) =>
  {
    test.case = 'check reexported file';
    let config = a.fileProvider.fileReadUnknown( a.abs( 'out/ExportWithDefaultPaths.out.will.yml' ) )

    let path = config.module[ 'ExportWithDefaultPaths.out' ].path;
    let expected =
    {
      'criterion' : { 'predefined' : 1 }
    }
    test.identical( path.download, expected );

    opener.finit();
    return null;
  });

  /* */

  a.ready.then( () =>
  {
    test.case = 'change downloadPath in runtime';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    a.will.prefer({ allOfMain : 0, allOfSub : 0 });
    a.will.readingBegin();
    return opener.open();
  });

  a.ready.then( () =>
  {
    let module = opener.openedModule;
    test.identical( module.pathResourceMap.download.path, null );
    module.downloadPath = '../';
    test.identical( module.pathResourceMap.download.path, '../' );
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    return build.perform();
  });

  a.ready.then( ( op ) =>
  {
    test.case = 'check reexported file';
    let config = a.fileProvider.configRead( a.abs( 'out/ExportWithDefaultPaths.out.will.yml' ) )

    let path = config.module[ 'ExportWithDefaultPaths.out' ].path;
    let expected =
    {
      'criterion' : { 'predefined' : 1 }
    }
    test.identical( path.download, expected );

    opener.finit();
    return null;
  });

  /* - */

  return a.ready;
}

//

function exportGitModuleAndCheckDefaultPathsSimple( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportWithDefaultPaths' );
  let opener;
  a.reflect();

  a.shell( 'git init' );

  /* - */

  a.ready.then( () =>
  {
    test.case = 'export';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    a.will.prefer({ allOfMain : 0, allOfSub : 0 });
    a.will.readingBegin();
    return opener.open();
  });

  a.ready.then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    return build.perform();
  });

  a.ready.then( ( op ) =>
  {
    test.case = 'check export file';
    let config = a.fileProvider.fileReadUnknown( a.abs( 'out/ExportWithDefaultPaths.out.will.yml' ) )

    let path = config.module[ 'ExportWithDefaultPaths.out' ].path;
    test.identical( path.download.criterion, { predefined : 1 } );
    test.identical( path.download.path, '..' );

    opener.finit();
    return null;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = 'reexport';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    a.will.prefer({ allOfMain : 0, allOfSub : 0 });
    a.will.readingBegin();
    return opener.open();
  });

  a.ready.then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    return build.perform();
  });

  a.ready.then( ( op ) =>
  {
    test.case = 'check reexported file';
    let config = a.fileProvider.fileReadUnknown( a.abs( 'out/ExportWithDefaultPaths.out.will.yml' ) )

    let path = config.module[ 'ExportWithDefaultPaths.out' ].path;
    test.identical( path.download.criterion, { predefined : 1 } );
    test.identical( path.download.path, '..' );

    opener.finit();
    return null;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = 'open';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    a.will.prefer({ allOfMain : 0, allOfSub : 0 });
    a.will.readingBegin();
    return opener.open();
  });

  a.ready.then( () =>
  {
    let module = opener.openedModule;
    test.identical( module.downloadPath, a.abs( '.' ) );
    test.false( a.fileProvider.path.isTrailed( module.downloadPath ) );
    let pathMap = module.resourceMapForKind( 'path' );
    test.identical( pathMap.download.path, a.abs( '.' ) );

    let junction = module.toJunction();
    test.identical( junction.openers.length, 1 );
    test.identical( junction.openers[ 0 ], opener );

    test.identical( opener.isMain, true );
    test.identical( opener.downloadPath, a.abs( '.' ) )

    opener.finit();

    return null;

  });

  /* - */

  return a.ready;
}

//

function reexportGitModule( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportWithDefaultPaths' );
  let opener;
  a.reflect();

  a.shell( 'git init' );

  /* - */

  a.ready.then( () =>
  {
    test.case = 'export main module as a git repository twice';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    a.will.prefer({ allOfMain : 0, allOfSub : 0 });
    a.will.readingBegin();
    return opener.open();
  });

  a.ready.then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    return build.perform();
  });

  a.ready.then( ( op ) =>
  {
    let config = a.fileProvider.configRead( a.abs( 'out/ExportWithDefaultPaths.out.will.yml' ) )

    let path = config.module[ 'ExportWithDefaultPaths.out' ].path;
    test.identical( path.download.criterion, { predefined : 1 } );
    test.identical( path.download.path, '..' );

    path.download.path = path.download.path + '/';

    a.fileProvider.fileWrite
    ({
      filePath : a.abs( 'out/ExportWithDefaultPaths.out.will.yml' ),
      data : config,
      encoding : 'yaml'
    });

    opener.finit();
    return null;
  });

  a.ready.then( () =>
  {
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    a.will.prefer({ allOfMain : 0, allOfSub : 0 });
    a.will.readingBegin();
    return opener.open();
  });

  a.ready.then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    return build.perform();
  });

  a.ready.then( ( op ) =>
  {
    let config = a.fileProvider.configRead( a.abs( 'out/ExportWithDefaultPaths.out.will.yml' ) )

    let path = config.module[ 'ExportWithDefaultPaths.out' ].path;
    test.identical( path.download.criterion, { predefined : 1 } );
    test.identical( path.download.path, '..' );

    opener.finit();
    return null;
  });

  /* - */

  return a.ready;
}

//

/*
test
  - following exports preserves followed export
  - openers should throw 2 openning errors
*/

function exportSeveralExports( test )
{
  let context = this;
  let a = context.assetFor( test, 'inconsistentOutfile' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export debug';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    a.will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = /*context.find*/a.find( a.abs( 'sub.out' ) );
    test.identical( files, exp )

    test.description = 'finit';
    module.finit();
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    test.description = 'should be only 1 error, because 1 attempt to open corrupted outwillfile, 2 times in the list, because for different openers';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 2 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'second export debug';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    a.will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = /*context.find*/a.find( a.abs( 'sub.out' ) );
    test.identical( files, exp )

    test.description = 'finit';
    module.finit();
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export release';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    a.will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = /*context.find*/a.find( a.abs( 'sub.out' ) );
    test.identical( files, exp )

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'second export release';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    a.will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = /*context.find*/a.find( a.abs( 'sub.out' ) );
    test.identical( files, exp )

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;

} /* end of function exportSeveralExports */

//

function exportSuper( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'setup';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );

    test.description = 'files';
    var files = /*context.find*/a.find( { filePath : { [ a.routinePath ] : '' } });
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

  a.ready
  .then( () =>
  {
    test.case = 'export sub, first';

    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });

    a.will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    a.will.readingBegin();
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    a.will.readingEnd();
    return build.perform();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    a.will.readingEnd();
    return build.perform();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    a.will.readingEnd();
    return build.perform();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    a.will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'path/*' ) );
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

    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.props.keys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'sub.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
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

  a.ready
  .then( () =>
  {
    test.case = 'export super debug';

    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });

    a.will.prefer
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
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'super.out/supermodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( _.props.keys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
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
    a.will.readingEnd();
    return build.perform();
  })

  .then( () =>
  {
    let builds = opener.openedModule.exportsResolve({ criterion : { debug : 0 } });
    let build = builds[ 0 ];
    a.will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'super.out/supermodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( _.props.keys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
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

  a.ready
  .then( ( arg ) =>
  {

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;

} /* end of function exportSuper */

//

function exportSuperIn( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoInExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export super debug, without out, without recursion, without peers';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );

    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });

    a.will.prefer
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

    test.true( _.errIs( err ) );
    test.identical( _.strCount( err.message, 'Exporting is impossible because found no out-willfile' ), 1 );
    test.identical( _.strCount( err.message, 'module::supermodule / exported::export.debug' ), 1 );

    test.description = 'files';
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
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
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 3 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    opener.finit();
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export super debug, without out, without recursion, with peers';

    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );

    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });

    a.will.prefer
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

    test.true( _.errIs( err ) );
    test.identical( _.strCount( err.message, 'Exporting is impossible because found no out-willfile' ), 1 );
    test.identical( _.strCount( err.message, 'module::supermodule / exported::export.debug' ), 1 );

    test.description = 'files';
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
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
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 4 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    opener.finit();
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export sub, then super';

    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });

    a.will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    a.will.readingBegin();
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
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.props.keys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'sub.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
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
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 1 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    opener.finit();
    return null;
  });

  a.ready
  .then( () =>
  {
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    a.will.prefer
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
    test.true( !_.errIs( err ) );

    test.description = 'files';
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
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
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'super.out/supermodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( _.props.keys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'two attempts to open super.out';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 2 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    opener.finit();
    return null;
  })

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export super debug, without out and without recursion';

    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });

    a.will.prefer
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
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'super.out/supermodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug', 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out', '../sub.out/sub.out', '../sub', '../super' ];
    test.identical( _.setFrom( _.props.keys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'files';
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
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
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 4 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    opener.finit();
    return null;
  })

  /* - */

  a.ready
  .then( ( arg ) =>
  {

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;
} /* end of function exportSuperIn */

exportSuperIn.rapidity = -1;

//

/*
test
  - step module.export use path::export if not defined other
*/

function exportDefaultPath( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportDefaultPath' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export willfile with default path';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'path' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return test.mustNotThrowError( build.perform() );
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'out/path.out.will.yml' ) );
    var modulePaths = _.select( outfile.module[ outfile.root[ 0 ] ], 'path/exported.files.export.debug/path' );
    var exp = [ '..', '../File.txt', '../nofile.will.yml', '../nonglob.will.yml', '../nopath.will.yml', '../path.will.yml', '../reflector.will.yml' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    /* zzz : should include out willfile? */

    test.description = 'files';
    var exp = [ '.', './path.out.will.yml' ]
    var files = /*context.find*/a.find( a.abs( 'out' ) );
    test.identical( files, exp )

    opener.finit();
    return null;
  });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export willfile with default reflector';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'reflector' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return test.mustNotThrowError( build.perform() );
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'out/reflector.out.will.yml' ) );
    var modulePaths = _.select( outfile.module[ outfile.root[ 0 ] ], 'path/exported.files.export.debug/path' );
    var exp = [ '..', '../File.txt', '../nofile.will.yml', '../nonglob.will.yml', '../nopath.will.yml', '../path.will.yml', '../reflector.will.yml' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './reflector.out.will.yml' ]
    var files = /*context.find*/a.find( a.abs( 'out' ) );
    test.identical( files, exp )

    opener.finit();
    return null;
  });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export willfile with no default export path';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'nopath' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return test.shouldThrowErrorAsync( build.perform() );
  })

  .then( ( err ) =>
  {
    var module = opener.openedModule;
    test.true( _.errIs( err ) );
    test.identical( _.strCount( String( err ), 'Failed to export' ), 1 );
    test.identical( _.strCount( String( err ), 'module::nopath / exported::export.debug' ), 1 );
    test.identical( _.strCount( String( err ), 'step::module.export' ), 2 );
    test.identical( _.strCount( String( err ), 'should have defined path or reflector to export. Alternatively module could have defined path::export or reflecotr::export' ), 1 );

    test.description = 'files';
    var exp = []
    var files = /*context.find*/a.find( a.abs( 'out' ) );
    test.identical( files, exp )

    opener.finit();
    return null;
  });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export willfile with default export path, no file found';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'nofile' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return test.shouldThrowErrorAsync( build.perform() );
  })

  .then( ( err ) =>
  {
    var module = opener.openedModule;

    test.true( _.errIs( err ) );
    test.identical( _.strCount( String( err ), 'Failed to export' ), 1 );
    test.identical( _.strCount( String( err ), 'module::nofile / exported::export.debug' ), 1 );
    test.identical( _.strCount( String( err ), 'No file found at' ), 1 );

    test.description = 'files';
    var exp = []
    var files = /*context.find*/a.find( a.abs( 'out' ) );
    test.identical( files, exp )

    opener.finit();
    return null;
  });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export willfile with default nonglob export path';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'nonglob' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return test.mustNotThrowError( build.perform() );
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'files';
    var exp = [ '.', './nonglob.out.will.yml' ];
    var files = /*context.find*/a.find( a.abs( 'out' ) );
    test.identical( files, exp );

    opener.finit();
    return null;
  });

  /* - */

  a.ready
  .then( () =>
  {
    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;

} /* end of function exportDefaultPath */

exportDefaultPath.rapidity = -1;

//

/*
test
  - outdate outfile should not used to preserve its content
*/

function exportOutdated( test )
{
  let context = this;
  let a = context.assetFor( test, 'inconsistentOutfile' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export debug';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });
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
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = /*context.find*/a.find( a.abs( 'sub.out' ) );
    test.identical( files, exp )

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    test.description = '1st attempt to open sub.out on opening, 2nd attempt to open sub.out on exporing';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 2 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export release, but input willfile is changed';
    a.fileProvider.fileAppend( a.abs( 'sub.ex.will.yml' ), '\n' );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });
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
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './sub.out.will.yml' ];
    var files = /*context.find*/a.find( a.abs( 'sub.out' ) );
    test.identical( files, exp )

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    test.description = 'first attempt on opening, second attempt on exporting';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 2 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;

} /* end of function exportOutdated */

//

/*
test
  - recursive exporting generate proper out-willfiels for each module
*/

function exportRecursive( test )
{
  let context = this;
  let a = context.assetFor( test, 'resolvePathOfSubmodulesExported' );
  let opener;

  /* - */

  begin().then( () =>
  {
    test.case = 'export debug';
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'ab/' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve();
    let build = builds[ 0 ];
    let run = new _.will.BuildRun
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
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'out/ab/module-ab.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'module-ab.out', '../../a', '../module-a.out', '../../b', '../module-b.out', '../../ab/' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'proto.export' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'files';
    var exp = [ '.', './module-a.out.will.yml', './module-b.out.will.yml', './ab', './ab/module-ab.out.will.yml' ];
    var files = /*context.find*/a.find( a.abs( 'out' ) );
    test.identical( files, exp )

    test.description = 'no garbage left';
    opener.finit();
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    return a.ready.then( () =>
    {
      a.reflect();
      a.fileProvider.fileWrite( a.abs( 'proto/b/-Excluded.js' ), 'console.log( \'b/-Ecluded.js\' );' );
      return null;
    });
  }
}

//

/*
test
  - dotless anonimous coupled naming works
*/

function exportDotless( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoDotlessExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export debug';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
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
    test.true( !module.isOut );

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
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'super outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'super.out/supermodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'supermodule.out', '../sub/', '../sub.out/sub.out', '../' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'sub outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub/' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    a.will.openersErrorsRemoveAll();
    opener.finit();
    test.description = 'no grabage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );
    return null;
  });

  /* - */

  return a.ready;

} /* end of function exportDotless */

//

/*
test
  - dotless anonimous single-file naming works
*/

function exportDotlessSingle( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoDotlessSingleExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export debug';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
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
    test.true( !module.isOut );

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
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'super outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'super.out/supermodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'supermodule.out', '../sub/', '../sub.out/sub.out', '../' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'sub outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub/' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    a.will.openersErrorsRemoveAll();
    opener.finit();
    test.description = 'no grabage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );
    return null;
  });

  /* - */

  return a.ready;

} /* end of function exportDotlessSingle */

//

/*
test
  - opts of step are exported and imported properly
*/

function exportStepOpts( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportStepOpts' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export debug';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'a' ) });
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
    test.true( !module.isOut );
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
    test.true( !!module.isOut );
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
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'out/module-a.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'module-a.out', '../a' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
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
    var files = /*context.find*/a.find( a.abs( 'out' ) );
    test.identical( files, exp )

    opener.finit();
    return null;
  });

  a.ready
  .then( () =>
  {
    test.case = 'reopen';
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'out/module-a.out.will.yml' ) });
    return opener.open({ all : 1 });
  })

  .then( ( arg ) =>
  {

    test.description = 'out-willfile';
    var module = opener.openedModule;
    test.true( !!module.isOut );
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
    test.true( !module.isOut );
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
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;

} /* end of function exportStepOpts */

//

/*
test
  - recursive export produce out-willfiles for each module
  - supermodule can use submodule's resources after submodule was exported.
*/

function exportRecursiveUsingSubmodule( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportMultipleExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export debug';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
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
    test.true( !module.isOut );

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
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'super outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'super.out/supermodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'supermodule.out', '../', '../sub.out/submodule.out', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    test.description = 'sub outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/submodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'submodule.out', '../' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );

    a.will.openersErrorsRemoveAll();
    opener.finit();
    test.description = 'no grabage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );
    return null;
  });

  /* - */

  return a.ready;

} /* end of function exportRecursiveUsingSubmodule */

//

function exportSteps( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportMultipleExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export debug';
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'super.out' ) );
    a.fileProvider.filesDelete( a.abs( 'sub.out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
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
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'super outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'super.out/supermodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'supermodule.out', '../', '../sub.out/submodule.out', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var steps = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'step/*' ) );
    var exp = [ 'export.', 'export.debug', 'reflect.submodules.', 'reflect.submodules.debug' ];
    test.identical( _.setFrom( steps ), _.setFrom( exp ) );

    test.description = 'sub outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/submodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'submodule.out', '../' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.', 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var steps = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'step/*' ) );
    var exp = [ 'export.', 'export.debug', 'reflect.proto.', 'reflect.proto.debug' ];
    test.identical( _.setFrom( steps ), _.setFrom( exp ) );

    test.description = 'in-willfile';
    var module = opener.openedModule;
    test.true( !module.isOut );
    var got = module.resolve
    ({
      selector : 'step::*export*',
    });
    var exp = [ 'step::module.export', 'step::export.', 'step::export.debug' ];
    var names = _.select( got, '*/qualifiedName' )
    test.identical( names, exp );
    var exp =
    [
      { 'export' : null, 'tar' : 0 },
      { 'export' : `{path::out.*=1}/**`, 'tar' : 1 },
      { 'export' : `{path::out.*=1}/**`, 'tar' : 1 },
    ]
    var opts = _.select( got, '*/opts' )
    test.identical( opts, exp );

    test.description = 'out-willfile';
    var module = opener.openedModule.peerModule;
    test.true( !!module.isOut );
    var got = module.resolve
    ({
      selector : 'step::*export*',
    });
    var exp = [ 'step::module.export', 'step::export.', 'step::export.debug' ];
    var names = _.select( got, '*/qualifiedName' )
    test.identical( names, exp );
    var exp =
    [
      { 'export' : null, 'tar' : 0 },
      { 'export' : `{path::out.*=1}/**`, 'tar' : 1 },
      { 'export' : `{path::out.*=1}/**`, 'tar' : 1 },
    ]
    var opts = _.select( got, '*/opts' )
    test.identical( opts, exp );

    a.will.openersErrorsRemoveAll();
    opener.finit();
    return null;
  });

  /* - */

  return a.ready;

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
  let context = this;
  let a = context.assetFor( test, 'corruptedOutfileUnknownSection' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export sub';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });

    a.will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    a.will.readingBegin();

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
    a.will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.props.keys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'sub.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    test.description = '1st attempt to open sub.out on opening, 2nd attempt to open sub.out on exporing';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 2 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;

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
  let context = this;
  let a = context.assetFor( test, 'corruptedOutfileSyntax' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export sub';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });

    a.will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    a.will.readingBegin();

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
    a.will.readingEnd();
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.props.keys( outfile.module ) ), _.setFrom( exp ) );
    var exp = [ 'sub.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    test.description = '1st attempt to open sub.out on opening, 2nd attempt to open sub.out on exporing';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 2 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;

} /* end of function exportCourruptedOutfileSyntax */

//

/*
test
  - exporting of module with disabled corrupted submodules works
  - Disabled modules are not in default submodules
*/

function exportCourruptedSubmodulesDisabled( test )
{
  let context = this;
  let a = context.assetFor( test, 'corruptedSubmodulesDisabled' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export super';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });

    a.will.prefer
    ({
      allOfMain : 0,
      allOfSub : 0,
    });

    a.will.readingBegin();

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
    var commonPath = _.filter_( null, got, ( e ) => e.opener ? e.opener.commonPath : e.module.commonPath );
    test.identical( commonPath, exp );

    test.case = 'modulesEach, withDisabled';
    var got = opener.openedModule.modulesEach({ outputFormat : '/', withDisabledSubmodules : 1 });
    var exp =
    [
      '.module/Submodule1/',
      '.module/Submodule2/',
      '.module/Submodule3/',
    ];
    var localPath = _.filter_( null, got, ( e ) => e.localPath );
    test.identical( localPath, a.abs( exp ) );
    var got = opener.openedModule.modulesEach({ outputFormat : '/', withDisabledSubmodules : 1 });
    var exp =
    [
      '.module/Submodule1',
      '.module/Submodule2',
      '.module/Submodule3',
    ];
    var localPath = _.filter_( null, got, ( e ) => e.opener.downloadPath );
    test.identical( localPath, a.abs( exp ) );
    var exp =
    [
      'git+https:///github.com/X1/X1.git!master',
      'git+https:///github.com/X2/X2.git!master',
      'git+https:///github.com/X3/X3.git!master',
    ];
    var remotePath = _.filter_( null, got, ( e ) => e.remotePath );
    test.identical( remotePath, exp );

    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    return build.perform();
  })

  .then( ( arg ) =>
  {
    var module = opener.openedModule;

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'super.out/supermodule.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'supermodule.out', '../super' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'supermodule.out' ];
    test.identical( _.setFrom( outfile.root ), _.setFrom( exp ) );

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    test.description = '1st attempt to open sub.out on opening, 2nd attempt to open sub.out on exporing';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 2 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;
} /* end of function exportCourruptedSubmodulesDisabled */

//

function exportCourrputedSubmoduleOutfileUnknownSection( test )
{
  let context = this;
  let a = context.assetFor( test, 'corruptedSubmoduleOutfileUnknownSection' );
  let opener;

  /* - */

  a.ready.then( () =>
  {
    test.case = 'export super';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
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

    test.true( _.errIs( err ) );

    test.description = 'files';
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './sub.out',
      './sub.out/sub.out.will.yml'
    ];
    var files = a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    test.description = 'should be only 2 errors, 1 attempt to open corrupted sub.out and 2 attempts to open super.out which does not exist';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 3 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = 'export super, recursive : 2';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    let run = new _.will.BuildRun
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

    test.true( err === undefined );

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.props.keys( outfile.module ) ), _.setFrom( exp ) );
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
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    test.description = '2 attempts to open super.out, 2 attempts to open sub.out, but the same instance';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 4 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;
}

exportCourrputedSubmoduleOutfileUnknownSection.description =
`
  - no extra errors made
  - corrupted outfile of submodule is not a problem
  - recursive export works
`

//

function exportCourrputedSubmoduleOutfileFormatVersion( test )
{
  let context = this;
  let a = context.assetFor( test, 'corruptedSubmoduleOutfileFormatVersion' );
  let opener;

  /* - */

  a.ready.then( () =>
  {
    test.case = 'export super';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
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

    test.true( _.errIs( err ) );

    test.description = 'files';
    var exp =
    [
      '.',
      './sub.ex.will.yml',
      './sub.im.will.yml',
      './super.ex.will.yml',
      './super.im.will.yml',
      './sub.out',
      './sub.out/sub.out.will.yml'
    ];
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    test.description = '2 attempts to open corrupted sub.out and 2 attempts to open super.out which does not exist';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 4 );
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* */

  a.ready.then( () =>
  {
    test.case = 'export super, recursive : 2';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    return opener.open();
  })

  .then( () =>
  {
    let module = opener.openedModule;
    let builds = module.exportsResolve({ criterion : { debug : 1 } });
    let build = builds[ 0 ];
    let run = new _.will.BuildRun
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
    test.true( err === undefined );

    test.description = 'outfile';
    var outfile = a.fileProvider.fileReadUnknown( a.abs( 'sub.out/sub.out.will.yml' ) );
    var modulePaths = _.props.keys( outfile.module );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( modulePaths ), _.setFrom( exp ) );
    var exported = _.props.keys( _.select( outfile.module[ outfile.root[ 0 ] ], 'exported/*' ) );
    var exp = [ 'export.debug' ];
    test.identical( _.setFrom( exported ), _.setFrom( exp ) );
    var sections = _.props.keys( outfile );
    var exp = [ 'format', 'root', 'consistency', 'module' ];
    test.identical( _.setFrom( sections ), _.setFrom( exp ) );
    var exp = [ 'sub.out', '../sub' ];
    test.identical( _.setFrom( _.props.keys( outfile.module ) ), _.setFrom( exp ) );
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
    var files = /*context.find*/a.find({ filePath : { [ a.routinePath ] : '', '**/+**' : 0 } });
    test.identical( files, exp );

    test.description = 'finit';
    opener.finit();
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    test.description = 'unique errors';
    test.identical( _.longOnce( _.select( a.will.openersErrorsArray, '*/err' ) ).length, 5 );
    /*
      1 - attempt to open super.out on opening
      2 - attempt to open sub.out on opening
      3 - attempt to open sub.out on _performSubmodulesPeersOpen
      5 - attempt to open sub.out on _performReadExported
      6 - attempt to open super.out on _performReadExported
    */
    a.will.openersErrorsRemoveAll();
    test.identical( a.will.openersErrorsArray.length, 0 );

    test.description = 'no garbage left';
    test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
    test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

    return null;
  });

  /* - */

  return a.ready;
}

exportCourrputedSubmoduleOutfileFormatVersion.description =
`
  - no extra errors made
  - outfile of submodule with not-supported version of format is not a problem
  - recursive export works
`

// --
// etc
// --

function framePerform( test )
{
  let context = this;
  let a = context.assetFor( test, 'make' );
  a.reflect();

  var opener = a.will.openerMakeManual({ willfilesPath : a.abs( './v1' ) });
  opener.find();

  return opener.open().split()
  .then( () =>
  {

    var expected = [];
    var files = a.find( a.abs( 'out' ) );
    let builds = opener.openedModule.buildsResolve();

    test.identical( builds.length, 1 );

    let build = builds[ 0 ];
    build.form();
    let run = new _.will.BuildRun({ build });
    run.form();
    let frame = run.frameUp( build );
    let steps = build.stepsEach();
    let step = steps[ 0 ];
    step.opts.currentPath = a.routinePath;

    /* */

    let frame2 = frame.frameUp( step );
    step.form();

    return step.framePerform( frame2 )
    .finally( ( err, arg ) =>
    {
      test.description = 'files';

      var files = a.find( a.routinePath );
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

      opener.finit();
      frame2.finit();

      if( err )
      throw err;
      return arg;
    });

  });
}

//

function customLogger( test )
{
  let context = this;
  let a = context.assetFor( test, 'simple' );
  // let logger = new _.Logger({ output : null, name : 'willCustomLogger', onTransformEnd, verbosity : 2 });
  let logger = new _.Logger({ output : console, name : 'willCustomLogger', onTransformEnd, verbosity : 2 });
  let loggerOutput = [];
  a.will = new _.Will({ logger });
  a.reflect();
  a.fileProvider.filesDelete( a.abs( 'out' ) );

  var opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
  opener.find();

  return opener.open().split()
  .then( () =>
  {

    var expected = [];
    var files = /*context.find*/a.find( a.abs( 'out' ) );
    let builds = opener.openedModule.buildsResolve();

    test.identical( builds.length, 1 );

    let build = builds[ 0 ];

    return build.perform()
    .finally( ( err, arg ) =>
    {

      test.description = 'files';
      var expected = [ '.', './debug', './debug/File.js' ];
      var files = /*context.find*/a.find( a.abs( 'out' ) );
      test.identical( files, expected );

      opener.finit();

      test.description = 'no garbage left';
      test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

      let output = loggerOutput.join( '\n' );
      test.true( _.strHas( output, /Building .*module::customLogger \/ build::debug.*/ ) );
      test.true( _.strHas( output, / - .*step::delete.out.debug.* deleted 0 file\(s\)/ ) );
      test.true( _.strHas( output, / \+ .*reflector::reflect.proto.* reflected 2 file\(s\)/ ) );
      test.true( _.strHas( output, /Built .*module::customLogger \/ build::debug.*/ ) );

      if( err )
      throw err;
      return arg;
    });

  });

  /*  */

  function onTransformEnd( o )
  {
    loggerOutput.push( o._outputForTerminal[ 0 ] )
    // loggerOutput.push( o._outputForPrinter[ 0 ] )
  }
}

//

function moduleIsNotValid( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodulesDownloadErrors' );
  let opener;

  a.ready.then( () =>
  {
    test.case = 'download submodule';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './good' ) });

    a.will.prefer({ allOfSub : 1 });

    return opener.open({ all : 1, resourcesFormed : 0 });
  });

  a.ready.then( () => opener.openedModule.subModulesDownload() )
  .then( () =>
  {
    test.case = 'change out will-file';

    opener.close();

    let outWillFilePath = a.abs( './.module/ModuleForTesting2a/out/wModuleForTesting2a.out.will.yml' );
    let outWillFile = a.fileProvider.fileReadUnknown( outWillFilePath );
    outWillFile.section = { field : 'value' };
    a.fileProvider.fileWrite({ filePath : outWillFilePath, data : outWillFile, encoding : 'yml' });

    return null;
  })

  .then( () =>
  {
    test.case = 'repopen module';
    let outWillFilePath = a.abs( './.module/ModuleForTesting2a/out/wModuleForTesting2a.out.will.yml' );
    opener = a.will.openerMakeManual({ willfilesPath : outWillFilePath });
    return opener.open({ all : 1, resourcesFormed : 0 });
  })

  .finally( ( err, arg ) =>
  {
    test.case = 'check if module is valid';
    if( err )
    _.errAttend( err );
    test.true( _.errIs( err ) );
    test.identical( opener.isValid(), false );
    test.identical( opener.openedModule.isValid(), false );
    opener.close();
    return null;
  })

  return a.ready;
}

// --
// resolve
// --

function exportsResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'corruptedSubmoduleOutfileUnknownSection' );
  let opener;

  /* - */

  a.ready.then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'sub' ) });
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
  });

  /* - */

  return a.ready;
}

//

function buildsResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportMultiple' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    return opener.open();
  })

  a.ready.then( ( arg ) =>
  {

    /* */

    test.case = 'build::*';

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

    /* */

    test.case = 'build::*, with criterion';

    var resolved = opener.openedModule.resolve({ selector : 'build::*', criterion : { debug : 1 } });
    test.identical( resolved.length, 2 );

    var expected = [ 'debug', 'export.debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( _.setFrom( got ), _.setFrom( expected ) );

    /* */

    test.case = 'build::*, currentContext is build::export.';

    var build = opener.openedModule.resolve({ selector : 'build::export.' });
    test.true( build instanceof _.will.Build );
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

    /* */

    test.case = 'build::*, currentContext is build::export.debug';

    var build = opener.openedModule.resolve({ selector : 'build::export.debug' });
    var resolved = opener.openedModule.resolve({ selector : 'build::*', currentContext : build, singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    var expected = { 'debug' : 1, 'default' : 1 };
    var got = resolved[ 0 ].criterion;
    test.identical( got, expected );

    /* */

    test.case = 'build::*, currentContext is build::export.debug, short-cut';

    var build = opener.openedModule.resolve({ selector : 'build::export.debug' });
    var resolved = build.resolve({ selector : 'build::*', singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    /* */

    test.case = 'build::*, short-cut, explicit criterion';

    var build = opener.openedModule.resolve({ selector : 'build::export.*', criterion : { debug : 1 } });
    var resolved = build.resolve({ selector : 'build::*', singleUnwrapping : 0, criterion : { debug : 0 } });
    test.identical( resolved.length, 2 );

    var expected = [ 'release', 'export.' ];
    var got = _.select( resolved, '*/name' );
    test.identical( _.setFrom( got ), _.setFrom( expected ) );

    return null;
  })

  /* - */

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  return a.ready;
} /* end of function buildsResolve */

//

function moduleResolveSimple( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportWithSubmodulesResolve' );
  let opener;

  /* - */

  a.ready.then( () =>
  {
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'a' ) });
    return opener.open();
  });

  a.ready.then( ( arg ) =>
  {
    let module = opener.openedModule;
    let o =
    {
      arrayWrapping : 1,
      criterion : {},
      currentExcluding : 0,
      defaultResourceKind : null,
      mapValsUnwrapping : 0,
      pathResolving : 0,
      pathUnwrapping : 0,
      prefixlessAction : "throw",
      selector : "*::*",
      strictCriterion : 1,
    };

    let resolve = module.resolve( o );
    test.true( _.aux.is( resolve ) );
    test.true( 'step/files.delete' in resolve );
    test.true( 'step/files.reflect' in resolve );
    test.true( 'path/in' in resolve );
    return null;
  });

  /* - */

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  return a.ready;
}

moduleResolveSimple.description =
`
Test routine checks that module resolves all resources.
`;

//

function moduleResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportWithSubmodulesResolve' );
  let opener;

  /* - */

  a.ready.then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'b/' ) });
    return opener.open({ all : 1 });
  });

  a.ready.then( ( arg ) =>
  {
    test.case = 'resolve concrete resource from submodule';
    let module = opener.openedModule;
    let resolve = module.resolve( 'submodule::sub-a/path::exported.files.proto.export' );
    test.true( _.longIs( resolve ) );
    test.true( resolve.length === 2 );
    return null;
  });

  /* */

  a.ready.then( ( arg ) =>
  {
    test.case = 'resolve all resources from module, including submodule paths';
    let module = opener.openedModule;
    let resolve = module.resolve( '*::*' );
    test.true( _.arrayIs( resolve ) );
    test.true( resolve[ 0 ] instanceof _.will.Module );
    test.true( resolve[ resolve.length - 1 ] instanceof _.will.Build );
    return null;
  });

  /* */

  a.ready.then( ( arg ) =>
  {
    test.case = 'resolve all resources from module, including submodule paths, pathResolving - 0';
    let module = opener.openedModule;
    let o =
    {
      arrayWrapping : 1,
      criterion : {},
      currentExcluding : 0,
      defaultResourceKind : null,
      mapValsUnwrapping : 0,
      pathResolving : 0,
      pathUnwrapping : 0,
      prefixlessAction : 'throw',
      selector : '*::*',
      strictCriterion : 1,
    };

    let resolve = module.resolve( o );
    test.true( _.aux.is( resolve ) );
    test.true( 'step/files.delete' in resolve );
    test.true( 'step/files.reflect' in resolve );
    test.true( 'path/in' in resolve );
    return null;
  });

  /* - */

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  return a.ready;
}

moduleResolve.description =
`
Test routine checks that module resolves the own export resources.
Resource is export paths map with paths from submodule.
Submodules are exported willfiles.
`;

//

function moduleResolveWithFunctionThisInSelector( test )
{
  let context = this;
  let a = context.assetFor( test, 'stepShellUsingCriterionValue' );
  let opener;

  a.ready.then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open({ all : 1, resourcesFormed : 1 });
  });

  /* - */

  a.ready.then( ( arg ) =>
  {
    test.case = 'currentThis is not specified';
    let module = opener.openedModule;
    let resolved = module.resolve
    ({
      selector : 'node -e "console.log( \'debug:{f::this/criterion/debug}\' )"',
      prefixlessAction : 'resolved',
      currentContext : module.stepMap[ 'print.criterion.value.' ],
      pathNativizing : 1,
      arrayFlattening : 0,
    });
    test.true( _.strIs( resolved ) );
    test.identical( resolved, 'node -e "console.log( \'debug:0\' )"' );
    return null;
  });

  /* - */


  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  return a.ready;
}

moduleResolveWithFunctionThisInSelector.description =
`
Test routine checks that module resolves resources when the selector contains part f::this.
`;

//

function trivialResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'make' );
  let opener;

  function pin( filePath )
  {
    return a.abs( '', filePath );
  }

  function pout( filePath )
  {
    return a.abs( 'out', filePath );
  }

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'export super';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'v1' ) });
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
    test.true( err === undefined );
    var module = opener.openedModule;
    opener.finit();
    return arg;
  })

  /* - */

  return a.ready;
} /* end of function trivialResolve */

//

function detailedResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
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

    a.will.openersErrorsRemoveAll();
    opener.finit();
    return null;
  });

  /* - */

  return a.ready;

} /* end of function detailedResolve */

//

function reflectorResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'compositeReflector' );
  let opener;

  /* - */

  begin().then( () =>
  {
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  });

  a.ready.then( ( arg ) =>
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
      'mandatory' : 1,
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
    };
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
    };
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
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe'
    };
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
    };

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
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
    };
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
    };
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
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
    };
    var resolvedData = resolved.exportStructure({ formed : 1 });
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
    };
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
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
    };
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, a.abs( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, a.abs( 'out/debug/dir1' ) );

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
    };
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, a.abs( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, a.abs( 'out/debug/dir1' ) );

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
      'mandatory' : 1,
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
    };
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, a.abs( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, a.abs( 'out/debug/dir1' ) );

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
    };
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, a.abs( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, a.abs( 'out/debug/dir1' ) );

    test.case = 'reflector::reflect.proto.6.debug formed:1';
    var resolved = opener.openedModule.resolve( 'reflector::reflect.proto.6.debug' );
    resolved.form();
    var expected =
    {
      'src' : { 'prefixPath' : 'proto/dir2/File.test.js' },
      'dst' : { 'prefixPath' : 'out/debug/dir1/File.test.js' },
      'criterion' : { 'debug' : 1, 'variant' : 6 },
      'mandatory' : 1,
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
    };
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, a.abs( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, a.abs( 'out/debug/dir1/File.test.js' ) );

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
    };
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, a.abs( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, a.abs( 'out/debug/dir1/File.test.js' ) );

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
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
    };
    var resolvedData = resolved.exportStructure({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, a.abs( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, a.abs( 'out/debug/dir1/File.test.js' ) );

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
    };
    var resolvedData = resolved.exportStructure();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, a.abs( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, a.abs( 'out/debug/dir1/File.test.js' ) );

    return null;
  });

  /* - */

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  return a.ready;

  /* */

  function begin()
  {
    return a.ready.then( () =>
    {
      a.reflect();
      a.fileProvider.fileWrite( a.abs( 'proto/dir2/-Excluded.js' ), 'console.log( \'dir2/-Ecluded.js\' );' );
      return null;
    });
  }
}

//

function reflectorInheritedResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'reflectInherit' );
  let opener;

  function pin( filePath )
  {
    return a.abs( filePath );
  }

  function pout( filePath )
  {
    return a.abs( 'super.out', filePath );
  }

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })

  a.ready.then( ( arg ) =>
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
      'mandatory' : 1,
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
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
      'inherit' : [ 'reflect.proto1' ],
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
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
      'inherit' : [ 'reflect.proto1' ],
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
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
      'inherit' : [ 'reflect.proto1' ],
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
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
      'inherit' : [ 'reflect.proto1' ],
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
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
      'inherit' : [ 'not.test', 'only.js' ],
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
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
      'inherit' : [ 'reflector::files3' ],
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
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
      'inherit' : [ 'reflector::files3' ],
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
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
      'inherit' : [ 'reflector::files3' ],
      'dstRewritingOnlyPreserving' : 1,
      'linking' : 'hardLinkMaybe',
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

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  return a.ready;
}

//

function superResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoInExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    return opener.open({ all : 1 });
  })

  a.ready.then( ( arg ) =>
  {

    test.case = 'build::*';
    var resolved = opener.openedModule.resolve( 'build::*' );
    test.identical( resolved.length, 4 );

    test.case = '*::*a*';
    var resolved = opener.openedModule.resolve
    ({
      selector : '*::*a*',
      pathUnwrapping : 0,
      missingAction : 'undefine',
    });
    test.identical( resolved.length, 22 );

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
      'step::willfile.generate',
      'step::git.status',
      'step::git.tag',
      'step::modules.update',
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

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  return a.ready;
}

//

function pathsResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportMultiple' );
  let opener;

  function pin( filePath )
  {
    if( _.arrayIs( filePath ) )
    return filePath.map( ( e ) => a.abs( e ) );
    return a.abs( filePath );
  }

  function pout( filePath )
  {
    if( _.arrayIs( filePath ) )
    return filePath.map( ( e ) => a.abs( 'super.out', e ) );
    return a.abs( 'super.out', filePath );
  }

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    return opener.open();
  })

  a.ready.then( ( arg ) =>
  {

    test.case = 'resolved, .';
    var resolved = opener.openedModule.resolve({ prefixlessAction : 'resolved', selector : '.' })
    var expected = '.';
    test.identical( resolved, expected );

    return null;
  })

  a.ready.then( ( arg ) =>
  {

    test.case = 'path::in*=1, pathResolving : 0';
    var resolved = opener.openedModule.resolve({ prefixlessAction : 'resolved', selector : 'path::in*=1', pathResolving : 0 })
    var expected = '.';
    test.identical( resolved, expected );

    test.case = 'path::in*=1';
    var resolved = opener.openedModule.resolve({ prefixlessAction : 'resolved', selector : 'path::in*=1' })
    var expected = a.routinePath;
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
    var expected = a.path.nativize( pin( 'proto' ) );
    test.identical( resolved, expected );

    test.case = '{path::in*=1}/proto, pathNativizing : 1';
    var resolved = opener.openedModule.resolve({ selector : '{path::in*=1}/proto', pathNativizing : 1, selectorIsPath : 0 });
    var expected = a.path.nativize( pin( '.' ) ) + '/proto';
    test.identical( resolved, expected );

    return null;
  })

  /* - */

  a.ready.then( ( arg ) =>
  {

    /* */

    test.case = 'nativizing';
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
      a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = resolved;
    test.identical( _.setFrom( got ), _.setFrom( _.filter_( null, a.abs( expected ), ( p ) => p ? a.path.s.nativize( p ) : p ) ) );

    /* */

    test.case = 'path::* - implicit';
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
      a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = resolved;
    test.identical( _.setFrom( a.rel( got ) ), _.setFrom( expected ) );

    /* */

    test.case = 'path::* - pu:1 mvu:1 pr:in';
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
      a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = resolved;
    test.identical( a.rel( got ), expected );

    /* */

    test.case = 'path::* - pu:1 mvu:1 pr:out';
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
      a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'super.out/proto',
      'super.out/super.out',
      'super.out',
      'super.out',
      'super.out/super.out/debug',
      'super.out/super.out/release'
    ]
    var got = resolved;
    test.identical( a.rel( got ), expected );

    /* */

    test.case = 'path::* - pu:1 mvu:1 pr:null';
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
      a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = resolved;
    test.identical( a.rel( got ), expected );

    /* */

    test.case = 'path::* - pu:0 mvu:0 pr:null';
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
      'will' : a.abs( __dirname, '../will/entry/Exec' ),
      'module.dir' : a.abs( '.' ),
      'module.willfiles' : a.abs([ 'super.ex.will.yml', 'super.im.will.yml' ]),
      'module.peer.willfiles' : a.abs( 'super.out/supermodule.out.will.yml' ),
      'module.common' : a.abs( 'super' ),
      'module.peer.in' : a.abs( 'super.out' ),
      'module.original.willfiles' : a.abs([ 'super.ex.will.yml', 'super.im.will.yml' ]),
      'local' : a.abs( 'super' ),
      'download' : null,
      'remote' : null,
      'current.remote' : null,
    }
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );
    // _.any( resolved, ( e, k ) => test.true( e.identicalWith( opener.openedModule.pathResourceMap[ k ] ) ) );
    _.any( resolved, ( e, k ) => test.identical( e.path, opener.openedModule.pathResourceMap[ k ].path ) );
    _.any( resolved, ( e, k ) => test.true( e.module === module || e.module === opener.openedModule ) );
    _.any( resolved, ( e, k ) => test.true( !!e.original ) );
    test.true( a.path.isAbsolute( got.will ) );

    /* */

    test.case = 'path::* - pu:0 mvu:0 pr:in';
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
      'will' : a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
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
    test.identical( a.rel( got ), expected );

    /* */

    test.case = 'path::* - pu:0 mvu:0 pr:out';
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
      'will' : a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'proto' : 'super.out/proto',
      'temp' : 'super.out/super.out',
      'download' : null,
      'in' : 'super.out',
      'out' : 'super.out',
      'out.debug' : 'super.out/super.out/debug',
      'out.release' : 'super.out/super.out/release'
    }
    var got = _.select( resolved, '*/path' );
    test.identical( a.rel( got ), expected );

    /* */

    test.case = 'path::* - pu:1 mvu:0 pr:null';
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
      'will' : a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'proto' : 'proto',
      'temp' : 'super.out',
      'in' : '.',
      'out' : 'super.out',
      'out.debug' : 'super.out/debug',
      'out.release' : 'super.out/release'
    }
    var got = resolved;
    test.identical( a.rel( got ), expected );

    /* */

    test.case = 'path::* - pu:1 mvu:0 pr:in';
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
      'will' : a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'proto' : 'proto',
      'temp' : 'super.out',
      'in' : '.',
      'out' : 'super.out',
      'out.debug' : 'super.out/debug',
      'out.release' : 'super.out/release'
    }
    var got = resolved;
    test.identical( a.rel( got ), expected );

    /* */

    test.case = 'path::* - pu:1 mvu:0 pr:out';
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
      'will' : a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'proto' : 'super.out/proto',
      'temp' : 'super.out/super.out',
      'in' : 'super.out',
      'out' : 'super.out',
      'out.debug' : 'super.out/super.out/debug',
      'out.release' : 'super.out/super.out/release'
    }
    var got = resolved;
    test.identical( a.rel( got ), expected );

    /* */

    test.case = 'path::* - pu:0 mvu:1 pr:null';
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
      a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = _.select( resolved, '*/path' );
    test.identical( a.rel( got ), expected );

    /* */

    test.case = 'path::* - pu:0 mvu:1 pr:in';
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
      a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'proto',
      'super.out',
      '.',
      'super.out',
      'super.out/debug',
      'super.out/release'
    ]
    var got = _.select( resolved, '*/path' );
    test.identical( a.rel( got ), expected );

    /* */

    test.case = 'path::* - pu:0 mvu:1 pr:out';
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
      a.rel( a.abs( __dirname, '../will/entry/Exec' ) ),
      'super.out/proto',
      'super.out/super.out',
      'super.out',
      'super.out',
      'super.out/super.out/debug',
      'super.out/super.out/release'
    ]
    var got = _.select( resolved, '*/path' );
    test.identical( a.rel( got ), expected );

    return null;
  });

  /* - */

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  return a.ready;
}

//

function pathsResolveImportIn( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoExported' );
  let opener;

  function pin( filePath )
  {
    return a.abs( filePath );
  }

  function sout( filePath )
  {
    return a.abs( 'super.out', filePath );
  }

  function pout( filePath )
  {
    return a.abs( 'out', filePath );
  }

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super' ) });
    return opener.open({ all : 1 });
  })

  a.ready.then( ( arg ) =>
  {

    debugger;
    test.case = 'submodule::*/path::in*=1, default';
    var resolved = opener.openedModule.resolve( 'submodule::*/path::in*=1' )
    var expected = ( 'sub.out' );
    test.identical( a.rel( resolved ), expected );

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
    test.identical( a.rel( resolved ), expected );

    return null;
  });

  a.ready.then( ( arg ) =>
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
    test.identical( a.rel( resolved ), expected );

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
    test.identical( a.rel( resolved ), expected );
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
    test.identical( a.rel( resolved ), expected );
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
    test.identical( a.rel( resolved ), expected );
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

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return a.ready;
}

//

function pathsResolveOfSubmodulesLocal( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodulesLocalRepos' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open({ all : 1 });
  })

  a.ready.then( ( arg ) =>
  {
    let module = opener.openedModule;
    return module.modulesBuild({ criterion : { debug : 1 }, downloading : 1 });
  })

  a.ready.then( ( arg ) =>
  {

    test.case = 'resolve submodules';
    var submodules = opener.openedModule.submodulesResolve({ selector : '*' });
    test.identical( submodules.length, 2 );

    test.case = 'path::in, supermodule';
    var resolved = opener.openedModule.resolve( 'path::in' );
    var expected = a.abs( '.' );
    test.identical( resolved, expected );

    test.case = 'path::in, wModuleForTesting1';
    var submodule = submodules[ 0 ];
    var resolved = submodule.resolve( 'path::in' );
    var expected = a.abs( '.module', 'ModuleForTesting1/out' );
    test.identical( resolved, expected );

    test.case = 'path::in, wModuleForTesting1, through opener';
    var submodule = submodules[ 0 ].opener;
    var resolved = submodule.openedModule.resolve( 'path::in' );
    var expected = a.abs( '.module', 'ModuleForTesting1/out' );
    test.identical( resolved, expected );

    test.case = 'path::out, wModuleForTesting1';
    var submodule = submodules[ 0 ];
    var resolved = submodule.resolve( 'path::out' );
    var expected = a.abs( '.module', 'ModuleForTesting1/out' );
    test.identical( resolved, expected );

    test.case = 'path::out, wModuleForTesting1, through opener';
    var submodule = submodules[ 0 ].opener;
    var resolved = submodule.openedModule.resolve( 'path::out' );
    var expected = a.abs( '.module', 'ModuleForTesting1/out' );
    test.identical( resolved, expected );

    return null;
  })

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  })

  /* - */

  return a.ready;
}

//

function pathsResolveOfSubmodulesRemote( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodulesRemoteRepos' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open({ all : 1 });
  })

  a.ready.then( ( arg ) =>
  {
    let module = opener.openedModule;
    return module.modulesBuild({ criterion : { debug : 1 }, downloading : 1 });
  })

  a.ready.then( ( arg ) =>
  {

    test.case = 'resolve submodules';
    var submodules = opener.openedModule.submodulesResolve({ selector : '*' });
    test.identical( submodules.length, 2 );

    test.case = 'path::in, supermodule';
    var resolved = opener.openedModule.resolve( 'path::in' );
    var expected = a.abs( '.' );
    test.identical( resolved, expected );

    test.case = 'path::in, wModuleForTesting1';
    var submodule = submodules[ 0 ];
    var resolved = submodule.resolve( 'path::in' );
    var expected = a.abs( '.module/ModuleForTesting1/out' );
    test.identical( resolved, expected );

    test.case = 'path::in, wModuleForTesting1, through opener';
    var submodule = submodules[ 0 ].opener;
    var resolved = submodule.openedModule.resolve( 'path::in' );
    var expected = a.abs( '.module/ModuleForTesting1/out' );
    test.identical( resolved, expected );

    test.case = 'path::out, wModuleForTesting1';
    var submodule = submodules[ 0 ];
    var resolved = submodule.resolve( 'path::out' );
    var expected = a.abs( '.module/ModuleForTesting1/out' );
    test.identical( resolved, expected );

    test.case = 'path::out, wModuleForTesting1, through opener';
    var submodule = submodules[ 0 ].opener;
    var resolved = submodule.openedModule.resolve( 'path::out' );
    var expected = a.abs( '.module/ModuleForTesting1/out' );
    test.identical( resolved, expected );

    return null;
  })

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  })

  /* - */

  return a.ready;
}

//

function pathsResolveOfSubmodulesAndOwn( test )
{
  let context = this;
  let a = context.assetFor( test, 'resolvePathOfSubmodulesExported' );
  let opener;

  function pin( filePath )
  {
    return a.abs( filePath );
  }

  /* - */

  begin().then( () =>
  {
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './ab/' ) });
    return opener.open({ all : 1 });
  });

  a.ready.then( ( arg ) =>
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
    ];
    test.identical( a.rel( resolved ), expected );

    return null;
  });

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    return a.ready.then( () =>
    {
      a.reflect();
      a.fileProvider.fileWrite( a.abs( 'proto/b/-Excluded.js' ), 'console.log( \'b/-Ecluded.js\' );' );
      return null;
    });
  }
}

//

function pathsResolveOutFileOfExports( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportMultipleExported' );
  let opener;

  function pin( filePath )
  {
    return a.abs( filePath );
  }

  function pout( filePath )
  {
    return a.abs( 'out', filePath );
  }

  function sout( filePath )
  {
    return a.abs( 'super.out', filePath );
  }

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'super.out/supermodule' ) });
    return opener.open({ all : 1 });
  })

  a.ready.then( ( arg ) =>
  {

    test.open( 'without export' );

    test.case = 'submodule::*/path::in*=1, default';
    var resolved = opener.openedModule.resolve( 'submodule::*/path::in*=1' );
    var expected = a.abs( 'sub.out' );
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
    var expected = a.abs( 'sub.out' );
    test.identical( resolved, expected );

    test.close( 'without export' );

    /* - */

    test.open( 'with export' );

    test.case = 'submodule::*/exported::*=1debug/path::in*=1, default';
    var resolved = opener.openedModule.resolve( 'submodule::*/exported::*=1debug/path::in*=1' );
    var expected = a.abs( 'sub.out' );
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
    var expected = a.abs( 'sub.out' );
    test.identical( resolved, expected );

    test.close( 'with export' );

    return null;
  });

  a.ready.then( ( arg ) =>
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
    var expected = a.abs( 'sub.out' );
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
    var expected = a.abs( 'sub.out' );
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
    var expected = [ [ a.abs( 'sub.out' ) ] ];
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
    var expected = { 'Submodule/in' : a.abs( 'sub.out' ) };
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
    var expected = a.abs( 'sub.out' );
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
    var expected = a.abs( 'sub.out' );
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
    var expected = [ [ a.abs( 'sub.out' ) ] ];
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
      'Submodule' : { 'in' : a.abs( 'sub.out' ) }
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

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return a.ready;
}

//

function pathsResolveComposite( test )
{
  let context = this;
  let a = context.assetFor( test, 'compositePath' );
  let opener;

  function pin( filePath )
  {
    return a.abs( 'in', filePath );
  }

  function pout( filePath )
  {
    return a.abs( 'out', filePath );
  }

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open({ all : 1 });
  })

  a.ready.then( ( arg ) =>
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
    var resolved = opener.openedModule.resolve( 'path::protoMain' );
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

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return a.ready;
}

//

function pathsResolveComposite2( test )
{
  let context = this;
  let a = context.assetFor( test, 'pathComposite' );
  let opener;

  function pin( filePath )
  {
    return a.abs( 'in', filePath );
  }

  function pout( filePath )
  {
    return a.abs( 'out', filePath );
  }

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'Module1' ) });
    return opener.open({ all : 1 });
  })

  a.ready.then( ( arg ) =>
  {
    test.case = 'path::export';
    var resolved = opener.openedModule.resolve({ selector : 'path::export', pathResolving : 0 });
    var expected = '.module/ModuleForTesting12/proto/**';
    test.identical( resolved, expected );
    return null;
  });

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return a.ready;
}

//

function pathsResolveArray( test )
{
  let context = this;
  let a = context.assetFor( test, 'make' );
  let opener;

  function pin( filePath )
  {
    return a.abs( '', filePath );
  }

  function pout( filePath )
  {
    return a.abs( 'out', filePath );
  }

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'v1' ) });
    return opener.open({ all : 1 });
  })

  a.ready.then( ( arg ) =>
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

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return a.ready;
}

//

function pathsResolveResolvedPath( test )
{
  let context = this;
  let a = context.assetFor( test, 'make' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'v1' ) });
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
    // var exp = 'some'; /* yyy */
    var exp = a.abs( 'some' );
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
    test.true( err === undefined );
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
  let context = this;
  let a = context.assetFor( test, 'exportWithSubmodules' );
  let opener;

  function pin( filePath )
  {
    return a.abs( '', filePath );
  }

  function pout( filePath )
  {
    return a.abs( 'out', filePath );
  }

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( 'ab/' ) });
    return opener.open({ all : 1 });
  })

  a.ready.then( ( arg ) =>
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

  a.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.true( err === undefined );
    opener.finit();
    return arg;
  });

  /* - */

  return a.ready;
}

//

function resourcePathRemote( test )
{
  let context = this;
  let a = context.assetFor( test, 'exportInformal' );
  let opener;

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './module/' ) });
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
    test.true( module.isFinited() );
    test.true( opener.isFinited() );

    return null;
  })

  .then( () =>
  {
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })
  .then( () =>
  {
    let module = opener.openedModule;
    // let informalOpener =  module.submoduleMap[ 'UriBasic' ].opener;
    let informalOpener =  module.submoduleMap[ 'ModuleForTesting2b' ].opener;
    let informalOpened = informalOpener.openedModule;
    let informalPathRemoteResource = informalOpened.pathResourceMap[ 'remote' ];

    test.identical( informalPathRemoteResource.path, null );
    // test.identical( informalPathRemoteResource.path, 'git+https:///github.com/Wandalen/wUriBasic.git' );

    return null;
  })


  return a.ready;
}

//

function filesFromResource( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodulesRemoteRepos' );
  let opener;

  /* - */

  a.ready.then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open({ all : 1, resourcesFormed : 1 });
  });

  a.ready.then( () =>
  {
    test.case = 'resolve resource - directory does not exist';
    let module = opener.openedModule;
    let got = module.filesFromResource({ selector : '{path::out}', currentContext : module });
    test.identical( got, a.abs([ 'out' ]) );
    return null;
  });

  a.ready.then( () =>
  {
    test.case = 'resolve resource - directory exists';
    let module = opener.openedModule;
    let got = module.filesFromResource({ selector : '{path::proto}', currentContext : module });
    test.identical( got, a.abs([ 'proto' ]) );
    return null;
  });

  a.ready.then( () =>
  {
    test.case = 'resolve with criterion';
    let module = opener.openedModule;
    let got = module.filesFromResource({ selector : '{path::out.*=1}', criterion : { debug : 1 }, currentContext : module });
    test.identical( got, a.abs([ './out/debug' ]) );
    return null;
  });

  a.ready.then( () =>
  {
    test.case = 'resolve directory from absolute path';
    let module = opener.openedModule;
    let selector = a.abs( 'proto/' );
    let got = module.filesFromResource({ selector, currentContext : module });
    test.identical( got, a.abs([ './proto' ]) );
    return null;
  });

  a.ready.then( () =>
  {
    test.case = 'resolve directory from relative path';
    let module = opener.openedModule;
    let selector = './proto/';
    let got = module.filesFromResource({ selector, currentContext : module });
    test.identical( got, a.abs([ './proto' ]) );
    return null;
  });

  /* - */

  return a.ready;
}

// --
// each module
// --

function modulesEach( test )
{
  let context = this;
  let a = context.assetFor( test, 'twoInExported' );
  let opener;

  /* - */

  a.ready
  .then( () =>
  {
    test.case = 'all : 0';
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './super' ) });

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
    test.identical( a.rel( _.props.keys( got3 ) ), exp );

    var exp = [ 'super', 'super.out/supermodule.out', 'sub', 'sub.out/sub.out' ];
    var commonPath = _.index( got, ( e ) => e.opener ? e.opener.commonPath : e.module.commonPath );
    test.identical( a.rel( _.props.keys( commonPath ) ), exp );

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
    test.identical( a.rel( _.props.keys( got3 ) ), exp );

    var exp = [ 'super.out/supermodule.out', 'super', 'sub', 'sub.out/sub.out' ];
    var commonPath = _.index( got, ( e ) => e.opener ? e.opener.commonPath : e.module.commonPath );
    test.identical( a.rel( _.props.keys( commonPath ) ), exp );

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
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './super' ) });

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
  let context = this;
  let a = context.assetFor( test, 'hierarchyDuplicate' );
  let opener;

  /* - */

  a.ready

  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './z' ) });
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

    test.true( ups.length === got.length );
    test.true( ups[ 0 ] === got[ 0 ] );

    var exp =
    [
      'z',
      'group1/a',
      '.module/ModuleForTesting1/',
      '.module/ModuleForTesting1/out/wModuleForTesting1.out',
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
    var got = opener.openedModule.submoduleMap.a.opener.openedModule.modulesEach( o2 )
    test.true( ups.length === got.length );
    test.true( ups[ 0 ] === got[ 0 ] );

    var exp =
    [
      'group1/a',
      'group1/.module/ModuleForTesting1/',
      'group1/.module/ModuleForTesting1/out/wModuleForTesting1.out',
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

function modulesFindEachAt( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodulesRemoteRepos' );
  let opener, o;

  a.ready.then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    a.will.prefer({ allOfSub : 1, });
    return opener.open({ all : 1, resourcesFormed : 0 });
  });

  /* - */

  a.ready.then( () =>
  {
    test.case = 'select all submodules from module without downloaded submodules';
    o =
    {
      selector : _.strUnquote( 'submodule::*' ),
      currentOpener : opener,
    };
    return a.will.modulesFindEachAt( o );
  });
  a.ready.then( ( op ) =>
  {
    test.true( true );
    test.true( op.options === o );
    test.identical( op.openers.length, 1 );
    test.true( op.openers[ 0 ] === opener );
    test.identical( op.sortedOpeners.length, 1 );
    test.true( op.sortedOpeners[ 0 ] === opener );
    test.identical( op.junctions.length, 1 );
    return null;
  });

  /* */

  a.ready.then( () => opener.openedModule.subModulesDownload() );

  /* */

  a.ready.then( () =>
  {
    test.case = 'select all submodules from module with downloaded submodules';
    o =
    {
      selector : _.strUnquote( 'submodule::*' ),
      currentOpener : opener,
    };
    return a.will.modulesFindEachAt( o );
  });
  a.ready.then( ( op ) =>
  {
    test.true( op.options === o );
    test.identical( op.openers.length, 2 );
    test.true( op.openers[ 0 ] !== opener );
    test.true( op.openers[ 1 ] !== opener );
    test.identical( op.openers[ 0 ].name, 'ModuleForTesting1' );
    test.identical( op.openers[ 1 ].name, 'ModuleForTesting2' );
    test.identical( op.sortedOpeners.length, 2 );
    test.true( op.sortedOpeners[ 0 ] !== opener );
    test.true( op.sortedOpeners[ 1 ] !== opener );
    test.true( op.openers[ 0 ] === op.sortedOpeners[ 0 ] );
    test.true( op.openers[ 1 ] === op.sortedOpeners[ 1 ] );
    test.identical( op.junctions.length, 2 );
    return null;
  });

  /* */

  a.ready.then( () =>
  {
    test.case = 'select submodule by pattern from module with downloaded submodules';
    o =
    {
      selector : _.strUnquote( '*Testing1' ),
      currentOpener : opener,
    };
    return a.will.modulesFindEachAt( o );
  });
  a.ready.then( ( op ) =>
  {
    test.true( op.options === o );
    test.identical( op.openers.length, 1 );
    test.true( op.openers[ 0 ] !== opener );
    test.identical( op.openers[ 0 ].name, 'ModuleForTesting1' );
    test.identical( op.sortedOpeners.length, 1 );
    test.true( op.sortedOpeners[ 0 ] !== opener );
    test.identical( op.junctions.length, 1 );
    return null;
  });

  /* - */

  return a.ready;
}

//

function modulesForOpeners( test )
{
  let context = this;
  let a = context.assetFor( test, 'hierarchyDuplicate' );
  let opener;
  let onEachModules, onEachJunctions, onEachVisitedObjects;

  a.ready.then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './z' ) });
    return opener.open();
  })

  /* - */

  a.ready.then( () =>
  {
    test.case = 'withStem : 1';
    clean();
    let o2 =
    {
      withPeers : 0,
      withStem : 1,
      modules : [ opener ],
      onEachModule : onEachModule,
      onEachJunction : onEachJunction,
      onEachVisitedObject : onEachVisitedObject,
      onBegin : onBegin,
      onEnd : onEnd,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {

      test.description = 'onEachModules';
      var exp = [ a.abs( 'z' ), a.abs( 'group1/a' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::z', 'module::a' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp = [ a.abs( 'z' ), a.abs( 'group1/a' ), a.abs( '.module/ModuleForTesting1/' ) ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::z )',
        'junction::( module::z / module::a )',
        'junction::( module::z / opener::ModuleForTesting1 )',
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp = [ a.abs( 'z' ), a.abs( 'group1/a' ), a.abs( '.module/ModuleForTesting1/' ) ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp = [ 'opener::z', 'relation::a', 'relation::ModuleForTesting1' ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })

  /* - */

  a.ready.then( () =>
  {
    test.case = 'withStem : 0';
    clean();
    let o2 =
    {
      withPeers : 0,
      withStem : 0,
      modules : [ opener ],
      onEachModule : onEachModule,
      onEachJunction : onEachJunction,
      onEachVisitedObject : onEachVisitedObject,
      onBegin : onBegin,
      onEnd : onEnd,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      var exp = [ a.abs( 'group1/a' ) ];
      test.identical( _.select( onEachModules, '*/commonPath' ), exp );
      var exp = [ 'wWillModule' ];
      test.identical( onEachModules.map( ( e ) => _.entity.strTypeWithoutTraits( e ) ), exp );
      return op;
    });
  })

  /* - */

  return a.ready.then( () =>
  {
    opener.finit();
    return null;
  });

  /* - */

  function onEachModule( module, op )
  {
    onEachModules.push( module );
    return null;
  }

  /* - */

  function onEachJunction( junction, op )
  {
    onEachJunctions.push( junction );
    return null;
  }

  /* - */

  function onEachVisitedObject( object, op )
  {
    onEachVisitedObjects.push( object );
    return null;
  }

  /* - */

  function onBegin( object, op )
  {
    debugger;
    return null;
  }

  /* - */

  function onEnd( object, op )
  {
    debugger;
    return null;
  }

  /* - */

  function clean()
  {
    onEachModules = [];
    onEachJunctions = [];
    onEachVisitedObjects = [];
  }

  /* - */

}

//

function modulesFor( test )
{
  let context = this;
  let a = context.assetFor( test, 'modulesFor' );
  let onEachModules, onEachJunctions, onEachVisitedObjects;
  let openers;

  let defaults =
  {
    withBranches : 1,
    withDisabledModules : 0,
    withDisabledStem : null,
    withDisabledSubmodules : 0,
    withEnabledModules : 1,
    withEnabledSubmodules : 1,
    withIn : 1,
    withInvalid : 1,
    withKnown : 1,
    withMandatorySubmodules : 1,
    withOptionalSubmodules : 1,
    withOut : 1,
    withPeers : 1,
    withStem : 1,
    withTerminals : 1,
    withUnknown : 0,
    withValid : 1,
    withoutDuplicates : 0,

    onEachModule : onEachModule,
    onEachJunction : onEachJunction,
    onEachVisitedObject : onEachVisitedObject,
    onBegin : onBegin,
    onEnd : onEnd,
  }

  /* - */

  begin({ selector : a.abs( './' ) })
  .then( () =>
  {
    test.case = 'single module, no submodules';
    let o2 =
    {
      ... defaults,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::default' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp = [ a.abs( './' ) ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp = [ 'junction::( module::default )' ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp = [ a.abs( './' ) ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp = [ 'opener::default' ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './group1/b' ) })
  .then( () =>
  {
    test.case = 'single module, with submodules, recursive:0';
    let o2 =
    {
      ... defaults,
      recursive : 0,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './group1/b' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::b' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp = [ a.abs( './group1/b' ) ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp = [ 'junction::( module::b )' ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp = [ a.abs( './group1/b' ) ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp = [ 'opener::b' ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './group1/b' ) })
  .then( () =>
  {
    test.case = 'single module, with submodules, recursive:1';
    let o2 =
    {
      ... defaults,
      recursive : 1,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './group1/b' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::b' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp = [ a.abs( './group1/b' ), a.abs( './group1/.module/ModuleForTesting1/' ) ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp = [ 'junction::( module::b )', 'junction::( module::b / opener::ModuleForTesting1 )' ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp = [ a.abs( './group1/b' ), a.abs( './group1/.module/ModuleForTesting1/' ) ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp = [ 'opener::b', 'relation::ModuleForTesting1' ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './group1/b' ) })
  .then( () =>
  {
    test.case = 'single module, with submodules, recursive:2';
    let o2 =
    {
      ... defaults,
      recursive : 2,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './group1/b' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::b' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp = [ a.abs( './group1/b' ), a.abs( './group1/.module/ModuleForTesting1/' ) ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp = [ 'junction::( module::b )', 'junction::( module::b / opener::ModuleForTesting1 )' ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp = [ a.abs( './group1/b' ), a.abs( './group1/.module/ModuleForTesting1/' ) ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp = [ 'opener::b', 'relation::ModuleForTesting1' ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './a' ) })
  .then( () =>
  {
    test.case = 'single module, with nested submodules, recursive:1';
    let o2 =
    {
      ... defaults,
      recursive : 1,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './a' ), a.abs( './group1/b' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::a', 'module::b' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( './a' ),
        a.abs( './group1/b' ),
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::a )',
        'junction::( module::a / module::b )',
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( './a' ),
        a.abs( './group1/b' ),
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'opener::a',
        'relation::b',
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './a' ) })
  .then( () =>
  {
    test.case = 'single module, with nested submodules, recursive:2';
    let o2 =
    {
      ... defaults,
      recursive : 2,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './a' ), a.abs( './group1/b' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::a', 'module::b' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( './a' ),
        a.abs( './group1/b' ),
        a.abs( './group1/.module/ModuleForTesting1/' )
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::a )',
        'junction::( module::a / module::b )',
        'junction::( module::a / module::b / opener::ModuleForTesting1 )'
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( './a' ),
        a.abs( './group1/b' ),
        a.abs( './group1/.module/ModuleForTesting1/' )
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'opener::a',
        'relation::b',
        'relation::ModuleForTesting1'
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  return a.ready;


  /* - */

  function onEachModule( module, op )
  {
    onEachModules.push( module );
    return null;
  }

  /* - */

  function onEachJunction( junction, op )
  {
    onEachJunctions.push( junction );
    return null;
  }

  /* - */

  function onEachVisitedObject( object, op )
  {
    onEachVisitedObjects.push( object );
    return null;
  }

  /* - */

  function onBegin( object, op )
  {
    return null;
  }

  /* - */

  function onEnd( object, op )
  {
    return null;
  }

  /* - */

  function clean()
  {
    onEachModules = [];
    onEachJunctions = [];
    onEachVisitedObjects = [];
  }

  /* - */

  function begin( o2 )
  {
    a.ready.then( () =>
    {
      clean();
      a.fileProvider.filesDelete( a.abs( '.' ) );
      a.reflect();

      if( o2.tracing === undefined )
      o2.tracing = a.path.isGlob( o2.selector );

      return a.will.modulesFindWithAt( o2 )
      .then( ( it ) =>
      {
        openers = it.openers;
        return null;
      })
    })

    return a.ready;
  }

  /* - */

  function end()
  {
    return a.ready.then( () =>
    {
      _.each( openers, ( opener ) => opener.finit() )
      return null;
    });
  }
}

//

function modulesForWithOptionsWith( test )
{
  let context = this;
  let a = context.assetFor( test, 'modulesFor' );
  let onEachModules, onEachJunctions, onEachVisitedObjects;
  let openers;

  let defaults =
  {
    withBranches : 1,
    withDisabledModules : 0,
    withDisabledStem : null,
    withDisabledSubmodules : 0,
    withEnabledModules : 1,
    withEnabledSubmodules : 1,
    withIn : 1,
    withInvalid : 1,
    withKnown : 1,
    withMandatorySubmodules : 1,
    withOptionalSubmodules : 1,
    withOut : 1,
    withPeers : 1,
    withStem : 1,
    withTerminals : 1,
    withUnknown : 0,
    withValid : 1,
    withoutDuplicates : 0,

    onEachModule : onEachModule,
    onEachJunction : onEachJunction,
    onEachVisitedObject : onEachVisitedObject,
    onBegin : onBegin,
    onEnd : onEnd,
  }

  /* - */

  begin({ selector : a.abs( './a' ) })
  .then( () =>
  {
    test.case = 'single module, with nested submodules, withEnabledSubmodules:0 recursive:2';
    let o2 =
    {
      ... defaults,
      recursive : 2,
      withEnabledSubmodules : 0,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './a' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::a' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( './a' ),
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::a )',
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( './a' ),
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'opener::a',
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './a' ) })
  .then( () =>
  {
    test.case = 'single module, withEnabledModules:0';
    let o2 =
    {
      ... defaults,
      withEnabledModules : 0,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp = [];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp = [];
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp = [];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp = [];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './a' ) })
  .then( () =>
  {
    test.case = 'single module, with nested submodules, withStem : 0';
    let o2 =
    {
      ... defaults,
      withStem : 0,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './group1/b' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::b' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( './group1/b' ),
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::a / module::b )',
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( './group1/b' ),
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'relation::b',
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './group2/c' ) })
  .then( () =>
  {
    test.case = 'exported module, withIn : 0';
    let o2 =
    {
      ... defaults,
      withIn : 0,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './group2/out/c.out' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::c' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( './group2/out/c.out' )
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::c / module::c )',
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( './group2/out/c.out' )
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'module::c'
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './group2/c' ) })
  .then( () =>
  {
    test.case = 'exported module, withOut : 0';
    let o2 =
    {
      ... defaults,
      withOut : 0,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './group2/c' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::c' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( './group2/c' )
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::c )',
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( './group2/c' )
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'opener::c'
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './group2/c' ) })
  .then( () =>
  {
    test.case = 'exported module, withIn : 0, withOut : 0';
    let o2 =
    {
      ... defaults,
      withIn : 0,
      withOut : 0,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp = [];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp = [];
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp = [];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp = [];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './group2/c' ) })
  .then( () =>
  {
    test.case = 'exported module, withPeers : 0';
    let o2 =
    {
      ... defaults,
      withPeers : 0,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './group2/c' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::c' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( './group2/c' )
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::c )',
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( './group2/c' )
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'opener::c'
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './group1/b' ) })
  .then( () =>
  {
    test.case = 'module with single termninal, withTerminals : 0';
    let o2 =
    {
      ... defaults,
      withTerminals : 0,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( 'group1/b' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::b' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( 'group1/b' )
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::b )'
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( 'group1/b' )
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'opener::b'
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './a' ) })
  .then( () =>
  {
    test.case = 'single module, with nested submodules, recursive:2, withBranches:0';
    let o2 =
    {
      ... defaults,
      withBranches : 0,
      recursive : 2,
      modules : openers,
    }
    return a.will.moduleWithNameMap.b.subModulesDownload()
    .then( () => a.will.modulesFor( o2 ) )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp =
      [
        a.abs( 'group1/.module/ModuleForTesting1/' ),
        a.abs( 'group1/.module/ModuleForTesting1/out/wModuleForTesting1.out' )
      ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp =
      [
        'module::wModuleForTesting1',
        'module::wModuleForTesting1'
      ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );
      var exp = [ false, true ];
      test.identical( _.select( onEachModules, '*/isOut' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( './group1/.module/ModuleForTesting1/' ),
        a.abs( './group1/.module/ModuleForTesting1/out/wModuleForTesting1.out' )
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::a / module::wModuleForTesting1 )',
        'junction::( module::a / module::wModuleForTesting1 )'
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( './group1/.module/ModuleForTesting1/' ),
        a.abs( './group1/.module/ModuleForTesting1/out/wModuleForTesting1.out' )
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'relation::ModuleForTesting1',
        'module::wModuleForTesting1'
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  return a.ready;


  /* - */

  function onEachModule( module, op )
  {
    onEachModules.push( module );
    return null;
  }

  /* - */

  function onEachJunction( junction, op )
  {
    onEachJunctions.push( junction );
    return null;
  }

  /* - */

  function onEachVisitedObject( object, op )
  {
    onEachVisitedObjects.push( object );
    return null;
  }

  /* - */

  function onBegin( object, op )
  {
    return null;
  }

  /* - */

  function onEnd( object, op )
  {
    return null;
  }

  /* - */

  function clean()
  {
    onEachModules = [];
    onEachJunctions = [];
    onEachVisitedObjects = [];
  }

  /* - */

  function begin( o2 )
  {
    a.ready.then( () =>
    {
      clean();
      a.fileProvider.filesDelete( a.abs( '.' ) );
      a.reflect();

      if( o2.tracing === undefined )
      o2.tracing = a.path.isGlob( o2.selector );

      return a.will.modulesFindWithAt( o2 )
      .then( ( it ) =>
      {
        openers = it.openers;
        return null;
      })
    })

    return a.ready;
  }

  /* - */

  function end()
  {
    return a.ready.then( () =>
    {
      _.each( openers, ( opener ) => opener.finit() )
      return null;
    });
  }
}

modulesFor.rapidity = -1;
modulesFor.routineTimeOut = 1500000;

//

function modulesForWithSubmodules( test )
{
  let context = this;
  let a = context.assetFor( test, 'modulesFor' );
  let onEachModules, onEachJunctions, onEachVisitedObjects;
  let openers;

  let defaults =
  {
    withBranches : 1,
    withDisabledModules : 0,
    withDisabledStem : null,
    withDisabledSubmodules : 0,
    withEnabledModules : 1,
    withEnabledSubmodules : 1,
    withIn : 1,
    withInvalid : 1,
    withKnown : 1,
    withMandatorySubmodules : 1,
    withOptionalSubmodules : 1,
    withOut : 1,
    withPeers : 1,
    withStem : 1,
    withTerminals : 1,
    withUnknown : 0,
    withValid : 1,
    withoutDuplicates : 0,

    onEachModule : onEachModule,
    onEachJunction : onEachJunction,
    onEachVisitedObject : onEachVisitedObject,
    onBegin : onBegin,
    onEnd : onEnd,
  }

  /* - */

  begin({ selector : a.abs( './group1/b' ) })
  .then( () =>
  {
    test.case = 'submodules is not opened';
    let o2 =
    {
      ... defaults,
      modules : openers,
    }
    return a.will.modulesFor( o2 )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp = [ a.abs( './group1/b' ) ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp = [ 'module::b' ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( './group1/b' ),
        a.abs( './group1/.module/ModuleForTesting1/' )
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::b )',
        'junction::( module::b / opener::ModuleForTesting1 )'
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( './group1/b' ),
        a.abs( './group1/.module/ModuleForTesting1/' )
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'opener::b',
        'relation::ModuleForTesting1'
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  begin({ selector : a.abs( './group1/b' ) })
  .then( () =>
  {
    test.case = 'submodules is opened';
    let o2 =
    {
      ... defaults,
      modules : openers,
    }

    return a.will.moduleWithNameMap.b.subModulesDownload()
    .then( () => a.will.modulesFor( o2 ) )
    .then( ( op ) =>
    {
      test.description = 'onEachModules';
      var exp =
      [
        a.abs( './group1/b' ),
        a.abs( './group1/.module/ModuleForTesting1/' ),
        a.abs( './group1/.module/ModuleForTesting1/out/wModuleForTesting1.out' )
      ];
      test.identical( _.select( onEachModules, '*/localPath' ), exp );
      var exp =
      [
        'module::b',
        'module::wModuleForTesting1',
        'module::wModuleForTesting1'
      ];
      test.identical( _.select( onEachModules, '*/qualifiedName' ), exp );

      test.description = 'onEachJunctions';
      var exp =
      [
        a.abs( './group1/b' ),
        a.abs( './group1/.module/ModuleForTesting1/' ),
        a.abs( './group1/.module/ModuleForTesting1/out/wModuleForTesting1.out' )
      ];
      test.identical( _.select( onEachJunctions, '*/localPath' ), exp );
      var exp =
      [
        'junction::( module::b )',
        'junction::( module::b / module::wModuleForTesting1 )',
        'junction::( module::b / module::wModuleForTesting1 )'
      ]
      test.identical( _.select( onEachJunctions, '*/qualifiedName' ), exp );

      test.description = 'onEachVisitedObjects';
      var exp =
      [
        a.abs( './group1/b' ),
        a.abs( './group1/.module/ModuleForTesting1/' ),
        a.abs( './group1/.module/ModuleForTesting1/out/wModuleForTesting1.out' )
      ];
      test.identical( _.select( onEachVisitedObjects, '*/localPath' ), exp );
      var exp =
      [
        'opener::b',
        'relation::ModuleForTesting1',
        'module::wModuleForTesting1'
      ];
      test.identical( _.select( onEachVisitedObjects, '*/qualifiedName' ), exp );

      return op;
    });
  })
  end()

  /* - */

  return a.ready;


  /* - */

  function onEachModule( module, op )
  {
    onEachModules.push( module );
    return null;
  }

  /* - */

  function onEachJunction( junction, op )
  {
    onEachJunctions.push( junction );
    return null;
  }

  /* - */

  function onEachVisitedObject( object, op )
  {
    onEachVisitedObjects.push( object );
    return null;
  }

  /* - */

  function onBegin( object, op )
  {
    return null;
  }

  /* - */

  function onEnd( object, op )
  {
    return null;
  }

  /* - */

  function clean()
  {
    onEachModules = [];
    onEachJunctions = [];
    onEachVisitedObjects = [];
  }

  /* - */

  function begin( o2 )
  {
    a.ready.then( () =>
    {
      clean();
      a.fileProvider.filesDelete( a.abs( '.' ) );
      a.reflect();

      if( o2.tracing === undefined )
      o2.tracing = a.path.isGlob( o2.selector );

      return a.will.modulesFindWithAt( o2 )
      .then( ( it ) =>
      {
        openers = it.openers;
        return null;
      })
    })

    return a.ready;
  }

  /* - */

  function end()
  {
    return a.ready.then( () =>
    {
      _.each( openers, ( opener ) => opener.finit() )
      return null;
    });
  }
}

// --
// submodule
// --

function submodulesRemoteResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodulesRemoteRepos' );
  let opener, config;

  /* - */

  a.ready.then( () =>
  {
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    config = a.fileProvider.fileReadUnknown({ filePath : a.abs( '.im.will.yml' ) });
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });

    a.will.prefer({ allOfSub : 1 });

    return opener.open({ all : 1, resourcesFormed : 0 });
  });

  a.ready.then( () =>
  {
    test.open( 'not downloaded' );

    test.case = 'trivial';
    var submodule = opener.openedModule.submoduleMap.ModuleForTesting1;
    test.true( submodule instanceof _.will.ModulesRelation );

    test.true( !!submodule.opener );
    test.identical( submodule.name, 'ModuleForTesting1' );
    test.identical( submodule.opener.openedModule, null );
    test.identical( submodule.opener.willfilesPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out.will' ) );
    test.identical( submodule.opener.dirPath, a.abs( '.module/ModuleForTesting1/out' ) );
    test.identical( submodule.opener.localPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.commonPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    // test.identical( submodule.opener.remotePath, _.uri.join( a.abs( '../-repo' ), 'git+hd://ModuleForTesting1?out=out/wModuleForTesting1.out.will!gamma' ) );
    test.identical( submodule.opener.remotePath, `${ config.submodule.ModuleForTesting1 }` );

    test.true( !submodule.opener.repo.hasFiles );
    test.true( !submodule.opener.openedModule );

    test.close( 'not downloaded' );
    return null;
  });

  /* */

  a.ready.then( () =>
  {
    return opener.openedModule.subModulesDownload();
  });

  a.ready.then( () =>
  {
    test.open( 'downloaded' );

    test.case = 'trivial';
    var submodule = opener.openedModule.submodulesResolve({ selector : 'ModuleForTesting1' });
    test.true( submodule instanceof _.will.ModulesRelation );
    test.true( submodule.opener.repo.hasFiles );
    test.true( submodule.opener.repo === submodule.opener.openedModule.repo );
    test.true( !!submodule.opener );
    test.identical( submodule.name, 'ModuleForTesting1' );

    test.identical( submodule.opener.name, 'ModuleForTesting1' );
    test.identical( submodule.opener.aliasName, 'ModuleForTesting1' );
    test.identical( submodule.opener.fileName, 'wModuleForTesting1.out' );
    test.identical( submodule.opener.willfilesPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out.will.yml' ) );
    test.identical( submodule.opener.dirPath, a.abs( '.module/ModuleForTesting1/out' ) );
    test.identical( submodule.opener.localPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.commonPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.remotePath, `${ config.submodule.ModuleForTesting1 }` );

    test.identical( submodule.opener.openedModule.name, 'wModuleForTesting1' );
    test.identical( submodule.opener.openedModule.resourcesFormed, 8 );
    test.identical( submodule.opener.openedModule.subModulesFormed, 8 );
    test.identical( submodule.opener.openedModule.willfilesPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out.will.yml' ) );
    test.identical( submodule.opener.openedModule.dirPath, a.abs( '.module/ModuleForTesting1/out' ) );
    test.identical( submodule.opener.openedModule.localPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.openedModule.commonPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.remotePath, `${ config.submodule.ModuleForTesting1 }` );
    test.true( _.strHas( submodule.opener.openedModule.currentRemotePath, /git\+https:\/\/\/github\.com\/Wandalen\/wModuleForTesting1\.git\/out\/wModuleForTesting1\.out\.will#.*/ ) );
    // test.identical( submodule.opener.openedModule.currentRemotePath, null );

    test.case = 'mask, single module';
    var submodule = opener.openedModule.submodulesResolve({ selector : '*Testing1' });
    test.true( submodule instanceof _.will.ModulesRelation );
    test.identical( submodule.name, 'ModuleForTesting1' );

    test.case = 'mask, two modules';
    var submodules = opener.openedModule.submodulesResolve({ selector : '*s*' });
    test.identical( submodules.length, 2 );
    test.true( submodules[ 0 ] instanceof _.will.ModulesRelation );
    test.identical( submodules[ 0 ].name, 'ModuleForTesting1' );
    test.true( submodules[ 1 ] instanceof _.will.ModulesRelation );
    test.identical( submodules[ 1 ].name, 'ModuleForTesting2' );

    test.close( 'downloaded' );
    return null;
  });

  /* */

  return a.ready;
}

//

function submodulesRemoteResolveNotDownloaded( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodulesRemoteRepos' );
  let opener;

  /* - */

  a.ready.then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    a.will.prefer({ allOfSub : 1, });
    return opener.open({ all : 1, resourcesFormed : 0 });
  });
  a.ready.then( () =>
  {
    let module = opener.openedModule;

    test.case = 'resolve all submodules, default options';
    var submodules = module.submodulesResolve({ selector : 'submodule::*' });
    test.true( _.arrayIs( submodules ) );
    test.true( submodules[ 0 ] instanceof _.will.ModulesRelation );
    test.true( submodules[ 1 ] instanceof _.will.ModulesRelation );
    test.identical( submodules[ 0 ].name, 'ModuleForTesting1' );
    test.identical( submodules[ 1 ].name, 'ModuleForTesting2' );

    test.case = 'resolve all submodules, pathUnwrapping - 0, preservingIteration - 0';
    var submodules = module.submodulesResolve
    ({
      selector : 'submodule::*',
      preservingIteration : 0,
      pathUnwrapping : 0,
    });
    test.true( _.arrayIs( submodules ) );
    test.true( submodules[ 0 ] instanceof _.will.ModulesRelation );
    test.true( submodules[ 1 ] instanceof _.will.ModulesRelation );
    test.identical( submodules[ 0 ].name, 'ModuleForTesting1' );
    test.identical( submodules[ 1 ].name, 'ModuleForTesting2' );

    test.case = 'resolve all submodules, pathUnwrapping - 1, preservingIteration - 0';
    var submodules = module.submodulesResolve
    ({
      selector : 'submodule::*',
      preservingIteration : 0,
      pathUnwrapping : 1,
    });
    test.true( _.arrayIs( submodules ) );
    test.true( submodules[ 0 ] instanceof _.will.ModulesRelation );
    test.true( submodules[ 1 ] instanceof _.will.ModulesRelation );
    test.identical( submodules[ 0 ].name, 'ModuleForTesting1' );
    test.identical( submodules[ 1 ].name, 'ModuleForTesting2' );

    test.case = 'resolve all submodules, pathUnwrapping - 0, preservingIteration - 1';
    var submodules = module.submodulesResolve
    ({
      selector : 'submodule::*',
      preservingIteration : 1,
      pathUnwrapping : 0,
    });
    test.true( _.arrayIs( submodules ) );
    test.true( submodules[ 0 ].currentModule instanceof _.will.Module );
    test.true( submodules[ 1 ].currentModule instanceof _.will.Module );
    test.true( submodules[ 0 ].currentModule.userArray[ 0 ] instanceof _.will.ModuleOpener );
    test.true( submodules[ 1 ].currentModule.userArray[ 0 ] instanceof _.will.ModuleOpener );

    test.case = 'resolve all submodules, pathUnwrapping - 1, preservingIteration - 1';
    var submodules = module.submodulesResolve
    ({
      selector : 'submodule::*',
      preservingIteration : 1,
      pathUnwrapping : 1,
    });
    test.true( _.arrayIs( submodules ) );
    test.true( submodules[ 0 ].currentModule instanceof _.will.Module );
    test.true( submodules[ 1 ].currentModule instanceof _.will.Module );
    test.true( submodules[ 0 ].currentModule.userArray[ 0 ] instanceof _.will.ModuleOpener );
    test.true( submodules[ 1 ].currentModule.userArray[ 0 ] instanceof _.will.ModuleOpener );

    return null;
  });

  /* - */

  return a.ready;
}

//

function submodulesLocalResolve( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodulesLocalRepos' );
  let opener, tag;

  /* - */

  a.ready.then( () =>
  {
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    let config = a.fileProvider.fileReadUnknown({ filePath : a.abs( '.im.will.yml' ) });
    tag = _.git.path.parse({ remotePath : config.submodule.ModuleForTesting1 }).tag;
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });

    a.will.prefer({ allOfSub : 1 });

    return opener.open({ all : 1, resourcesFormed : 0 });
  });

  a.ready.then( () =>
  {
    test.open( 'not downloaded' );

    test.case = 'trivial';
    var submodule = opener.openedModule.submoduleMap.ModuleForTesting1;
    test.true( submodule instanceof _.will.ModulesRelation );

    test.true( !!submodule.opener );
    test.identical( submodule.name, 'ModuleForTesting1' );
    test.identical( submodule.opener.openedModule, null );
    test.identical( submodule.opener.willfilesPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out.will' ) );
    test.identical( submodule.opener.dirPath, a.abs( '.module/ModuleForTesting1/out' ) );
    test.identical( submodule.opener.localPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.commonPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.remotePath, _.uri.join( a.abs( `../-repo` ), `git+hd://ModuleForTesting1?out=out/wModuleForTesting1.out.will!${ tag }` ) );

    test.true( !submodule.opener.repo.hasFiles );
    test.true( !submodule.opener.openedModule );

    test.close( 'not downloaded' );
    return null;
  });

  /* */

  a.ready.then( () =>
  {
    return opener.openedModule.subModulesDownload();
  });

  a.ready.then( () =>
  {
    test.open( 'downloaded' );

    test.case = 'trivial';
    var submodule = opener.openedModule.submodulesResolve({ selector : 'ModuleForTesting1' });
    test.true( submodule instanceof _.will.ModulesRelation );
    test.true( submodule.opener.repo.hasFiles );
    test.true( submodule.opener.repo === submodule.opener.openedModule.repo );
    test.true( !!submodule.opener );
    test.identical( submodule.name, 'ModuleForTesting1' );

    test.identical( submodule.opener.name, 'ModuleForTesting1' );
    test.identical( submodule.opener.aliasName, 'ModuleForTesting1' );
    test.identical( submodule.opener.fileName, 'wModuleForTesting1.out' );
    test.identical( submodule.opener.willfilesPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out.will.yml' ) );
    test.identical( submodule.opener.dirPath, a.abs( '.module/ModuleForTesting1/out' ) );
    test.identical( submodule.opener.localPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.commonPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.remotePath, _.uri.join( a.abs( `../-repo` ), `git+hd://ModuleForTesting1?out=out/wModuleForTesting1.out.will!${ tag }` ) );

    test.identical( submodule.opener.openedModule.name, 'wModuleForTesting1' );
    test.identical( submodule.opener.openedModule.resourcesFormed, 8 );
    test.identical( submodule.opener.openedModule.subModulesFormed, 8 );
    test.identical( submodule.opener.openedModule.willfilesPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out.will.yml' ) );
    test.identical( submodule.opener.openedModule.dirPath, a.abs( '.module/ModuleForTesting1/out' ) );
    test.identical( submodule.opener.openedModule.localPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.openedModule.commonPath, a.abs( '.module/ModuleForTesting1/out/wModuleForTesting1.out' ) );
    test.identical( submodule.opener.openedModule.remotePath, _.uri.join( a.abs( `../-repo` ), `git+hd://ModuleForTesting1?out=out/wModuleForTesting1.out.will!${ tag }` ) );
    test.true( _.strHas( submodule.opener.openedModule.currentRemotePath, /git\+hd:\/\/\/.*\/ModuleForTesting1\?out=out\/wModuleForTesting1\.out\.will#.*/ ) );
    // test.identical( submodule.opener.openedModule.currentRemotePath, null );

    test.case = 'mask, single module';
    var submodule = opener.openedModule.submodulesResolve({ selector : '*Testing1' });
    test.true( submodule instanceof _.will.ModulesRelation );
    test.identical( submodule.name, 'ModuleForTesting1' );

    test.case = 'mask, two modules';
    var submodules = opener.openedModule.submodulesResolve({ selector : '*s*' });
    test.identical( submodules.length, 2 );
    test.true( submodules[ 0 ] instanceof _.will.ModulesRelation );
    test.identical( submodules[ 0 ].name, 'ModuleForTesting1' );
    test.true( submodules[ 1 ] instanceof _.will.ModulesRelation );
    test.identical( submodules[ 1 ].name, 'ModuleForTesting2' );

    test.close( 'downloaded' );
    return null;
  });

  /* */

  return a.ready;
}

//

function submodulesDeleteAndDownload( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodulesDelDownload' );
  let opener;

  /* */

  a.ready
  .then( () =>
  {
    a.reflect();
    a.fileProvider.filesDelete( a.abs( 'out' ) );
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })

  a.ready
  .then( () =>
  {

    let builds = opener.openedModule.buildsResolve({ name : 'build' });
    test.identical( builds.length, 1 );

    let build = builds[ 0 ];
    let con = build.perform();

    con.then( ( arg ) =>
    {
      var files = /*context.find*/a.find( a.abs( '.module' ) );
      test.true( _.longHas( files, './ModuleForTesting1' ) );
      test.true( _.longHas( files, './ModuleForTesting12ab' ) );
      test.ge( files.length, 54 );
      return arg;
    })

    con.then( () => build.perform() )

    con.then( ( arg ) =>
    {
      var files = /*context.find*/a.find( a.abs( '.module' ) );
      test.true( _.longHas( files, './ModuleForTesting1' ) );
      test.true( _.longHas( files, './ModuleForTesting12ab' ) );
      test.ge( files.length, 54 );
      return arg;
    })

    con.finally( ( err, arg ) =>
    {

      var exp = [ './', '.module/ModuleForTesting1/out/wModuleForTesting1.out', '.module/ModuleForTesting1/', '.module/ModuleForTesting12ab/out/wModuleForTesting12ab.out', '.module/ModuleForTesting12ab/' ];
      test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( exp ) );
      test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( exp ) );

      test.identical( _.props.keys( a.will.moduleWithIdMap ).length, exp.length );
      var willfilesArray =
      [
        '.will.yml',
        '.module/ModuleForTesting1/out/wModuleForTesting1.out.will.yml',
        [
          '.module/ModuleForTesting1/.ex.will.yml',
          '.module/ModuleForTesting1/.im.will.yml'
        ],
        '.module/ModuleForTesting12ab/out/wModuleForTesting12ab.out.will.yml',
        [
          '.module/ModuleForTesting12ab/.ex.will.yml',
          '.module/ModuleForTesting12ab/.im.will.yml'
        ]
      ]
      test.identical( _.select( a.will.willfilesArray, '*/filePath' ), a.abs( willfilesArray ) );

      var exp =
      [
        '.will.yml',
        '.module/ModuleForTesting1/out/wModuleForTesting1.out.will.yml',
        '.module/ModuleForTesting1/.ex.will.yml',
        '.module/ModuleForTesting1/.im.will.yml',
        '.module/ModuleForTesting12ab/out/wModuleForTesting12ab.out.will.yml',
        '.module/ModuleForTesting12ab/.ex.will.yml',
        '.module/ModuleForTesting12ab/.im.will.yml'
      ]
      test.identical( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ), exp );
      test.identical( _.props.keys( a.will.willfileWithFilePathPathMap ), a.abs( exp ) );
      var exp = [ './', '.module/ModuleForTesting1/out/wModuleForTesting1.out', '.module/ModuleForTesting1/', '.module/ModuleForTesting12ab/out/wModuleForTesting12ab.out', '.module/ModuleForTesting12ab/' ]
      test.identical( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ), exp );

      opener.finit();

      test.description = 'no garbage left';
      test.identical( _.setFrom( a.rel( _.select( a.will.modulesArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.moduleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.props.keys( a.will.moduleWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.select( a.will.openersArray, '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.select( _.props.vals( a.will.openerModuleWithIdMap ), '*/commonPath' ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.arrayFlatten( _.select( a.will.willfilesArray, '*/filePath' ) ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithCommonPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( a.rel( _.props.keys( a.will.willfileWithFilePathPathMap ) ) ), _.setFrom( [] ) );
      test.identical( _.setFrom( _.props.keys( a.will.moduleWithNameMap ) ), _.setFrom( [] ) );

      if( err )
      throw err;
      return arg;
    })

    return con;
  })

  /* - */

  return a.ready;
}

// --
// repo
// --

function isRepositoryReformSeveralTimes( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodules' );
  let opener;

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })

  .then( () => opener.openedModule.subModulesDownload() )

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting2a.opener.repo;
    return repo.status({ all : 1, invalidating : 0 });
  })

  .then( ( status ) =>
  {

    test.description = 'status of repo::ModuleForTesting2a'
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : false,
      'hasLocalUncommittedChanges' : false,
      'isUpToDate' : true,
      'remoteIsValid' : true,
      'safeToDelete' : true,
      'downloadRequired' : false,
      'updateRequired' : false,
      'agreeRequired' : false
    }
    test.identical( status, exp );

    return null;
  })

  .finally( ( err, arg ) =>
  {
    test.identical( err, undefined );
    opener.close();
    return null;
  })

  return a.ready;
}

//

function repoStatus( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodules' );
  let opener;

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })

  .then( () => opener.openedModule.subModulesDownload() )

  /* status after donwloading repo::ModuleForTesting1 */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 1, invalidating : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'dirExists' : true,
        'hasFiles' : true,
        'isRepository' : true,
        'hasLocalChanges' : false,
        'hasLocalUncommittedChanges' : false,
        'isUpToDate' : true,
        'remoteIsValid' : true,
        'safeToDelete' : true,
        'downloadRequired' : false,
        'updateRequired' : false,
        'agreeRequired' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, dirExists : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'dirExists' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, hasFiles : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'hasFiles' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, isRepository : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'isRepository' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, hasLocalChanges : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'isRepository' : true,
        'hasLocalChanges' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, hasLocalUncommittedChanges : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'isRepository' : true,
        'hasLocalUncommittedChanges' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, isUpToDate : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'isRepository' : true,
        'isUpToDate' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, remoteIsValid : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'isRepository' : true,
        'remoteIsValid' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, safeToDelete : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'hasLocalChanges' : false,
        'isRepository' : true,
        'hasFiles' : true,
        'safeToDelete' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, downloadRequired : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'hasFiles' : true,
        'downloadRequired' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, updateRequired : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'isRepository' : true,
        'isUpToDate' : true,
        'remoteIsValid' : true,
        'updateRequired' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 1, agreeRequired : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of repo::ModuleForTesting1'
      var exp =
      {
        'isRepository' : true,
        'isUpToDate' : true,
        'remoteIsValid' : true,
        'agreeRequired' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* status after deleting repo::ModuleForTesting1 */

  .then( () =>
  {
    a.fileProvider.filesDelete( a.abs( '.module/ModuleForTesting1' ) );
    var exp = [ 'ModuleForTesting2a' ];
    var files = a.fileProvider.dirRead( a.abs( '.module' ) )
    test.identical( files, exp );
    return null;
  })

  .then( () =>
  {
    test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 1, invalidating : 0 })
    .then( ( status ) =>
    {
      var exp =
      {
        'dirExists' : true,
        'hasFiles' : true,
        'isRepository' : true,
        'hasLocalChanges' : false,
        'hasLocalUncommittedChanges' : false,
        'isUpToDate' : true,
        'remoteIsValid' : true,
        'safeToDelete' : true,
        'downloadRequired' : false,
        'updateRequired' : false,
        'agreeRequired' : false
      }
      test.identical( status, exp );

      return null;
    })
  })

  //

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, dirExists : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'dirExists' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, hasFiles : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'hasFiles' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, isRepository : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'isRepository' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, hasLocalChanges : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'isRepository' : true,
        'hasLocalChanges' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, hasLocalUncommittedChanges : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'isRepository' : true,
        'hasLocalUncommittedChanges' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, isUpToDate : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'isRepository' : true,
        'isUpToDate' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, remoteIsValid : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'isRepository' : true,
        'remoteIsValid' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, safeToDelete : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'hasLocalChanges' : false,
        'isRepository' : true,
        'hasFiles' : true,
        'safeToDelete' : true
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, downloadRequired : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'hasFiles' : true,
        'downloadRequired' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, updateRequired : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'isRepository' : true,
        'isUpToDate' : true,
        'remoteIsValid' : true,
        'updateRequired' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  /* */

  .then( () =>
  {
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 0, invalidating : 0, agreeRequired : 1 })
    .then( ( status ) =>
    {

      test.description = 'status of deleted repo::ModuleForTesting1, invalidating off'
      var exp =
      {
        'isRepository' : true,
        'isUpToDate' : true,
        'remoteIsValid' : true,
        'agreeRequired' : false
      }
      test.identical( status, exp );
      return null;
    })
  })

  //

  .then( () =>
  {
    test.case = 'status of deleted repo::ModuleForTesting1, invalidating on'
    var repo = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo.status({ all : 1, invalidating : 1 })
    .then( ( status ) =>
    {

      var exp =
      {
        'dirExists' : false,
        'hasFiles' : false,
        'isRepository' : false,
        'hasLocalChanges' : false,
        'hasLocalUncommittedChanges' : false,
        'isUpToDate' : false,
        'remoteIsValid' : false,
        'safeToDelete' : true,
        'downloadRequired' : true,
        'updateRequired' : true,
        'agreeRequired' : true
      }
      test.identical( status, exp );

      return null;
    })
  })

  /* */

  .finally( ( err, arg ) =>
  {
    test.identical( err, undefined );
    opener.close();
    return null;
  })

  return a.ready;
}

//

function repoStatusForDeletedRepo( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodules' );
  let opener;

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })

  .then( () => opener.openedModule.subModulesDownload() )

  /*  */

  .then( () =>
  {
    test.description = 'delete repo::ModuleForTesting1 and call status with invalidating:0'
    a.fileProvider.filesDelete( a.abs( '.module/ModuleForTesting1' ) );

    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    var status =
    {
      'dirExists' : repo1._.dirExists,
      'hasFiles' : repo1._.hasFiles,
      'isRepository' :  repo1._.isRepository,
      'hasLocalChanges' :  repo1._.hasLocalChanges,
      'hasLocalUncommittedChanges' :  repo1._.hasLocalUncommittedChanges,
      'isUpToDate' :  repo1._.isUpToDate,
      'remoteIsValid' :  repo1._.remoteIsValid,
      'safeToDelete' :  repo1._.safeToDelete,
      'downloadRequired' :  repo1._.downloadRequired,
      'updateRequired' :  repo1._.updateRequired,
      'agreeRequired' :  repo1._.agreeRequired
    }
    var expected =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : null,
      'hasLocalUncommittedChanges' : null,
      'isUpToDate' : null,
      'remoteIsValid' : null,
      'safeToDelete' : null,
      'downloadRequired' : null,
      'updateRequired' : null,
      'agreeRequired' : null
    };
    test.identical( status, expected )

    return repo1.status({ all : 1, invalidating : 0 })
    .then( ( status ) =>
    {
      var exp =
      {
        'dirExists' : true,
        'hasFiles' : true,
        'isRepository' : true,
        'hasLocalChanges' : false,
        'hasLocalUncommittedChanges' : false,
        'isUpToDate' : false,
        'remoteIsValid' : false,
        'safeToDelete' : true,
        'downloadRequired' : true,
        'updateRequired' : true,
        'agreeRequired' : true
      }
      test.identical( status, exp );

      return null;
    })
  })

  /* */

  .then( () =>
  {
    test.description = 'delete repo::ModuleForTesting2a and call status with invalidating:1'
    a.fileProvider.filesDelete( a.abs( '.module/ModuleForTesting2a' ) );

    var repo1a = opener.openedModule.submoduleMap.ModuleForTesting2a.opener.repo;
    var status =
    {
      'dirExists' : repo1a._.dirExists,
      'hasFiles' : repo1a._.hasFiles,
      'isRepository' :  repo1a._.isRepository,
      'hasLocalChanges' :  repo1a._.hasLocalChanges,
      'hasLocalUncommittedChanges' :  repo1a._.hasLocalUncommittedChanges,
      'isUpToDate' :  repo1a._.isUpToDate,
      'remoteIsValid' :  repo1a._.remoteIsValid,
      'safeToDelete' :  repo1a._.safeToDelete,
      'downloadRequired' :  repo1a._.downloadRequired,
      'updateRequired' :  repo1a._.updateRequired,
      'agreeRequired' :  repo1a._.agreeRequired
    }
    var expected =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : null,
      'hasLocalUncommittedChanges' : null,
      'isUpToDate' : null,
      'remoteIsValid' : null,
      'safeToDelete' : null,
      'downloadRequired' : null,
      'updateRequired' : null,
      'agreeRequired' : null
    };
    test.identical( status, expected )

    return repo1a.status({ all : 1, invalidating : 1 })
    .then( ( status ) =>
    {
      var exp =
      {
        'dirExists' : false,
        'hasFiles' : false,
        'isRepository' : false,
        'hasLocalChanges' : false,
        'hasLocalUncommittedChanges' : false,
        'isUpToDate' : false,
        'remoteIsValid' : false,
        'safeToDelete' : true,
        'downloadRequired' : true,
        'updateRequired' : true,
        'agreeRequired' : true
      }
      test.identical( status, exp );

      return null;
    })
  })

  /* */

  .finally( ( err, arg ) =>
  {
    test.identical( err, undefined );
    opener.close();
    return null;
  })

  return a.ready;
}

//

function repoStatusForOutdatedRepo( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodules' );
  let opener;

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })

  /* remote path refers to master, local repo is in detached state */

  .tap( () => test.open( 'repo is not up to date' ) )

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not up to date'
    a.fileProvider.filesDelete( a.abs( '.module/ModuleForTesting1' ) );
    let con = opener.openedModule.subModulesDownload();
    con.then( () =>
    {
      var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
      return repo1.status({ all : 1, invalidating : 1 })
    })
    _.process.start
    ({
      execPath : 'git checkout HEAD~1',
      currentPath : a.abs( '.module/ModuleForTesting1' ),
      outputPiping : 0,
      ready : con,
    })
    return con;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not up to date, all:1, invalidating:0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : false,
      'hasLocalUncommittedChanges' : false,
      'isUpToDate' : true,
      'remoteIsValid' : true,
      'safeToDelete' : true,
      'downloadRequired' : false,
      'updateRequired' : false,
      'agreeRequired' : false
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not up to date, all:1, invalidating:1'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : false,
      'hasLocalUncommittedChanges' : false,
      'isUpToDate' : false,
      'remoteIsValid' : true,
      'safeToDelete' : true,
      'downloadRequired' : false,
      'updateRequired' : true,
      'agreeRequired' : true
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not up to date, all:1, invalidating:0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : false,
      'hasLocalUncommittedChanges' : false,
      'isUpToDate' : false,
      'remoteIsValid' : true,
      'safeToDelete' : true,
      'downloadRequired' : false,
      'updateRequired' : true,
      'agreeRequired' : true
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not up to date, all:0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp = {}
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not up to date, all:0, invalidating:0, isUpToDate:1'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 0, isUpToDate : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'isRepository' : true,
      'isUpToDate' : false
    }
    test.identical( status, exp );

    return null;
  })

  .tap( () => test.close( 'repo is not up to date' ) )

  /* */

  .finally( ( err, arg ) =>
  {
    test.identical( err, undefined );
    opener.close();
    return null;
  })

  return a.ready;
}

//

function repoStatusForInvalidRepo( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodules' );
  let opener;

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })

  /* origin of repo is changed, repo is not longer valid */

  .tap( () => test.open( 'repo is valid' ) )

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not valid'
    a.fileProvider.filesDelete( a.abs( '.module/ModuleForTesting1' ) );
    let con = opener.openedModule.subModulesDownload();
    con.then( () =>
    {
      var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
      return repo1.status({ all : 1, invalidating : 1 })
    })
    _.process.start
    ({
      execPath : 'git remote remove origin',
      currentPath : a.abs( '.module/ModuleForTesting1' ),
      outputPiping : 0,
      ready : con,
    })
    return con;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not valid, all:1, invalidating:0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : false,
      'hasLocalUncommittedChanges' : false,
      'isUpToDate' : true,
      'remoteIsValid' : true,
      'safeToDelete' : true,
      'downloadRequired' : false,
      'updateRequired' : false,
      'agreeRequired' : false
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not valid, all:1, invalidating:1'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : true,
      'hasLocalUncommittedChanges' : false,
      'isUpToDate' : false,
      'remoteIsValid' : false,
      'safeToDelete' : false,
      'downloadRequired' : false,
      'updateRequired' : true,
      'agreeRequired' : true
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not valid, all:1, invalidating:0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : true,
      'hasLocalUncommittedChanges' : false,
      'isUpToDate' : false,
      'remoteIsValid' : false,
      'safeToDelete' : false,
      'downloadRequired' : false,
      'updateRequired' : true,
      'agreeRequired' : true
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not valid, all:0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp = {}
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not valid, all:0, invalidating:0, remoteIsValid:1'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 0, remoteIsValid : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'isRepository' : true,
      'remoteIsValid' : false
    }
    test.identical( status, exp );

    return null;
  })

  .tap( () => test.close( 'repo is valid' ) )

  /* */

  .finally( ( err, arg ) =>
  {
    test.identical( err, undefined );
    opener.close();
    return null;
  })

  return a.ready;
}

//

function repoStatusLocalChanges( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodules' );
  let opener;

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })

  /* remote path refers to master, repo has local changes */

  .tap( () => test.open( 'repo has local changes' ) )

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 has local changes'
    a.fileProvider.filesDelete( a.abs( '.module/ModuleForTesting1' ) );
    let con = opener.openedModule.subModulesDownload();
    con.then( () =>
    {
      var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
      return repo1.status({ all : 1, invalidating : 1 })
    })
    con.then( () =>
    {
      a.fileProvider.fileWrite({ filePath : a.abs( '.module/ModuleForTesting1/sample/Sample.s' ), data : '' })
      return null;
    });
    return con;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 has local changes, all:1, invalidating:0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : false,
      'hasLocalUncommittedChanges' : false,
      'isUpToDate' : true,
      'remoteIsValid' : true,
      'safeToDelete' : true,
      'downloadRequired' : false,
      'updateRequired' : false,
      'agreeRequired' : false
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 has local changes, all:1, invalidating:1'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : true,
      'hasLocalUncommittedChanges' : true,
      'isUpToDate' : true,
      'remoteIsValid' : true,
      'safeToDelete' : false,
      'downloadRequired' : false,
      'updateRequired' : false,
      'agreeRequired' : false
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 has local changes, all:1, invalidating:0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : true,
      'hasLocalUncommittedChanges' : true,
      'isUpToDate' : true,
      'remoteIsValid' : true,
      'safeToDelete' : false,
      'downloadRequired' : false,
      'updateRequired' : false,
      'agreeRequired' : false
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not up to date, all:0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp = {}
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not up to date, all:0, invalidating:0, hasLocalChanges:1'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 0, hasLocalChanges : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'isRepository' : true,
      'hasLocalChanges' : true
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not up to date, all:0, invalidating:0, hasLocalUncommittedChanges:1'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 0, hasLocalUncommittedChanges : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'isRepository' : true,
      'hasLocalUncommittedChanges' : true
    }
    test.identical( status, exp );

    return null;
  })

  //

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 is not up to date, all:0, invalidating:0, hasLocalUncommittedChanges:1'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 0, hasLocalChanges : 1, hasLocalUncommittedChanges : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'isRepository' : true,
      'hasLocalChanges' : true,
      'hasLocalUncommittedChanges' : true
    }
    test.identical( status, exp );

    return null;
  })

  .tap( () => test.close( 'repo has local changes' ) )

  /* */

  .finally( ( err, arg ) =>
  {
    test.identical( err, undefined );
    opener.close();
    return null;
  })

  return a.ready;
}

//

function repoStatusLocalUncommittedChanges( test )
{
  let context = this;
  let a = context.assetFor( test, 'submodules' );
  let opener;

  a.ready
  .then( () =>
  {
    a.reflect();
    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })

  /*  */

  .tap( () => test.open( 'repo has local uncommitted changes' ) )

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 has local uncommitted changes'
    a.fileProvider.filesDelete( a.abs( '.module/ModuleForTesting1' ) );
    let con = opener.openedModule.subModulesDownload();
    con.then( () =>
    {
      var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
      return repo1.status({ all : 1, invalidating : 1 })
    })
    con.then( () =>
    {
      a.fileProvider.fileWrite({ filePath : a.abs( '.module/ModuleForTesting1/sample/Sample.s' ), data : '' })
      return null;
    })
    _.process.start
    ({
      execPath : 'git add sample/Sample.s',
      currentPath : a.abs( '.module/ModuleForTesting1' ),
      outputPiping : 0,
      ready : con,
    })
    return con;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 has local uncommitted changes, all:1, invalidating:0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : false,
      'hasLocalUncommittedChanges' : false,
      'isUpToDate' : true,
      'remoteIsValid' : true,
      'safeToDelete' : true,
      'downloadRequired' : false,
      'updateRequired' : false,
      'agreeRequired' : false
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'invalidating:0, check only for uncommitted changes'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 0, hasLocalUncommittedChanges : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'isRepository' : true,
      'hasLocalUncommittedChanges' : false
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'invalidating:1, check only for uncommitted changes'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 1, hasLocalUncommittedChanges : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'isRepository' : true,
      'hasLocalUncommittedChanges' : true
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'repo::ModuleForTesting1 has local uncommitted changes, all:1, invalidating:1'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 1, invalidating : 1 })
  })
  .then( ( status ) =>
  {
    var exp =
    {
      'dirExists' : true,
      'hasFiles' : true,
      'isRepository' : true,
      'hasLocalChanges' : true,
      'hasLocalUncommittedChanges' : true,
      'isUpToDate' : true,
      'remoteIsValid' : true,
      'safeToDelete' : false,
      'downloadRequired' : false,
      'updateRequired' : false,
      'agreeRequired' : false
    }
    test.identical( status, exp );

    return null;
  })

  //

  .then( () =>
  {
    test.description = 'all : 0, invalidating : 0'
    var repo1 = opener.openedModule.submoduleMap.ModuleForTesting1.opener.repo;
    return repo1.status({ all : 0, invalidating : 0 })
  })
  .then( ( status ) =>
  {
    var exp = {}
    test.identical( status, exp );

    return null;
  })

  .tap( () => test.close( 'repo has local uncommitted changes' ) )

  /* */

  .finally( ( err, arg ) =>
  {
    test.identical( err, undefined );
    opener.close();
    return null;
  })

  return a.ready;
}

//

function remotePathOfMainGitRepo( test )
{
  let context = this;
  let a = context.assetFor( test, 'remotePathOfMain' );
  let opener;

  a.shell.predefined.sync = 1;
  a.shell.predefined.deasync = 0;
  a.shell.predefined.ready = null;

  /* - */

  a.ready
  .then( () =>
  {
    a.reflect();
    a.shell( 'git init' )
    a.shell( 'git remote add origin https://github.com/test/TestRepo.git' )

    opener = a.will.openerMakeManual({ willfilesPath : a.abs( './' ) });
    return opener.open();
  })

  /* - */

  a.ready.then( () =>
  {
    test.identical( opener.remotePath, 'git+https:///github.com/test/TestRepo.git/' );
    return null;
  })

  /* - */

  a.ready.finally( ( err, arg ) =>
  {
    test.identical( err, undefined );
    opener.close();
    return null;
  })

  /* - */

  return a.ready;
}

remotePathOfMainGitRepo.description =
`
Checks remotePath of the main module as a git repository.
`

// --
// define class
// --

const Proto =
{

  name : 'Tools.Willbe.Int',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,
  routineTimeOut : 300000,

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

    preCloneRepos,

    // open

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
    modulesUpform,

    // export

    exportModuleAndCheckDefaultPathsSimple,
    exportGitModuleAndCheckDefaultPathsSimple,
    reexportGitModule,
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

    // etc

    framePerform,
    customLogger,
    moduleIsNotValid,

    // resolve

    exportsResolve,
    buildsResolve,
    moduleResolveSimple,
    moduleResolve,
    moduleResolveWithFunctionThisInSelector,
    trivialResolve,
    detailedResolve,
    reflectorResolve,
    reflectorInheritedResolve,
    superResolve,
    pathsResolve,
    pathsResolveImportIn,
    // pathsResolveOfSubmodulesLocal, /* xxx : make it working */
    pathsResolveOfSubmodulesRemote,
    pathsResolveOfSubmodulesAndOwn,
    pathsResolveOutFileOfExports,
    pathsResolveComposite,
    pathsResolveComposite2,
    pathsResolveArray,
    pathsResolveResolvedPath,
    pathsResolveFailing,
    resourcePathRemote,
    filesFromResource,

    // each module

    modulesEach,
    modulesEachDuplicates,
    modulesFindEachAt,
    modulesForOpeners,
    modulesFor,
    modulesForWithOptionsWith,
    modulesForWithSubmodules,

    // submodule

    submodulesRemoteResolve,
    submodulesRemoteResolveNotDownloaded,
    submodulesLocalResolve,
    submodulesDeleteAndDownload,

    // repo

    isRepositoryReformSeveralTimes,
    repoStatus,
    repoStatusForDeletedRepo,
    repoStatusForOutdatedRepo,
    repoStatusForInvalidRepo,
    repoStatusLocalChanges,
    repoStatusLocalUncommittedChanges,
    remotePathOfMainGitRepo,

  }

}

// --
// export
// --

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
