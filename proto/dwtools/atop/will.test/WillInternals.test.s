( function _WillInternals_test_s_( ) {

'use strict';

/*

!!! add test routine openning out-willfile

*/

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

//

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.tempDir, '/dwtools/tmp.tmp' ) )
  _.fileProvider.filesDelete( self.tempDir );
}

// --
// tests
// --

function buildSimple( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'simple' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, '.' );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let will = new _.Will;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesDelete( outPath );

  var module = will.moduleMake({ willfilesPath : modulePath });

  return module.openedModule.ready.split().then( () =>
  {

    var expected = [];
    var files = self.find( outPath );

    let builds = module.openedModule.buildsResolve();

    test.identical( builds.length, 1 );

    let build = builds[ 0 ];

    return build.perform()
    .finally( ( err, arg ) =>
    {

      var expected = [ '.', './debug', './debug/File.js' ];
      var files = self.find( outPath );
      test.identical( files, expected );

      debugger;
      module.finit();
      debugger;

      test.identical( will.moduleArray.length, 0 );
      test.identical( _.mapKeys( will.moduleWithIdMap ).length, 0 );
      test.identical( _.mapKeys( will.moduleWithPathMap ).length, 0 );
      test.identical( will.openerModuleArray.length, 0 );
      test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, 0 );
      test.identical( will.willfileArray.length, 0 );
      test.identical( _.mapKeys( will.willfileWithPathMap ).length, 0 );

      if( err )
      throw err;
      return arg;
    });

  });
}

//

function makeNamed( test )
{
  let self = this;
  let assetName = 'import-in/super';
  let originalDirPath = _.path.join( self.assetDirPath, 'import-in-exported' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'super' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  var module1 = will.moduleMake({ willfilesPath : modulePath });
  let ready1 = module1.openedModule.ready;

  var module2 = will.moduleMake({ willfilesPath : modulePath });
  let ready2 = module2.openedModule.ready;

  /* - */

  module1.openedModule.ready.thenKeep( ( arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    check( module1 );
    return null;
  })

  /* - */

  module1.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    test.is( err === undefined );
    // module1.finit();
    if( err )
    throw err;
    return arg;
  });

  /* - */

  module2.openedModule.ready.thenKeep( ( arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    check( module2 );
    return null;
  })

  /* - */

  module2.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    test.is( err === undefined );
    // module2.finit();
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake([ ready1, ready2 ])
  // return _.Consequence.AndTake([ ready1 ])
  .finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;

    test.is( module1.openedModule === module2.openedModule );

    test.identical( will.moduleArray.length, 2 );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, 2 );
    test.identical( _.mapKeys( will.moduleWithPathMap ).length, 2 );
    test.identical( will.openerModuleArray.length, 3 );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, 3 );
    test.identical( will.willfileArray.length, 3 );
    test.identical( _.mapKeys( will.willfileWithPathMap ).length, 3 );

    module1.finit();

    test.identical( will.moduleArray.length, 2 );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, 2 );
    test.identical( _.mapKeys( will.moduleWithPathMap ).length, 2 );
    test.identical( will.openerModuleArray.length, 2 );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, 2 );
    test.identical( will.willfileArray.length, 3 );
    test.identical( _.mapKeys( will.willfileWithPathMap ).length, 3 );

    module2.finit();

    test.identical( will.moduleArray.length, 0 );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, 0 );
    test.identical( _.mapKeys( will.moduleWithPathMap ).length, 0 );
    test.identical( will.openerModuleArray.length, 0 );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, 0 );
    test.identical( will.willfileArray.length, 0 );
    test.identical( _.mapKeys( will.willfileWithPathMap ).length, 0 );

    return arg;
  });

  /* - */

  function check( module )
  {

    let pathMap =
    {

      'proto' : './proto',
      'temp' : [ './super.out', './out' ],
      'in' : '.',
      'out' : './super.out',
      'out.debug' : './super.out/debug',
      'out.release' : './super.out/release',

      // 'local' : path.join( routinePath, '.' ),
      'local' : null,
      'remote' : null,
      'current.remote' : null,
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : path.join( routinePath, '.' ),
      'module.willfiles' : path.s.join( routinePath, [ './super.im.will.yml', './super.ex.will.yml' ] ),
      'module.original.willfiles' : null,
      'module.common' : path.join( routinePath, 'super' ),

    }

    test.identical( module.nickName, 'module::supermodule' );
    test.identical( module.absoluteName, 'module::supermodule' );
    test.identical( module.inPath, routinePath );
    test.identical( module.outPath, routinePath + '/super.out' );
    test.identical( module.configName, 'super' );
    test.identical( module.localPath, null );
    test.identical( module.remotePath, null );
    // test.identical( module.currentRemotePath, null );
    test.identical( module.willPath, path.join( __dirname, '../will/Exec' ) );
    test.identical( module.dirPath, path.join( routinePath, '.' ) );
    test.identical( module.commonPath, path.join( routinePath, 'super' ) );
    test.identical( module.willfilesPath, path.s.join( routinePath, [ './super.im.will.yml', './super.ex.will.yml' ] ) );
    test.identical( module.willfileArray.length, 2 );
    test.identical( _.mapKeys( module.willfileWithRoleMap ), [ 'import', 'export' ] );

    test.identical( module.openedModule.nickName, 'module::supermodule' );
    test.identical( module.openedModule.absoluteName, 'module::supermodule' );
    test.identical( module.openedModule.inPath, routinePath );
    test.identical( module.openedModule.outPath, routinePath + '/super.out' );
    test.identical( module.openedModule.configName, 'super' );
    test.identical( module.openedModule.localPath, null );
    test.identical( module.openedModule.remotePath, null );
    test.identical( module.openedModule.currentRemotePath, null );
    test.identical( module.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );
    test.identical( module.openedModule.dirPath, path.join( routinePath, '.' ) );
    test.identical( module.openedModule.commonPath, path.join( routinePath, 'super' ) );
    test.identical( module.openedModule.willfilesPath, path.s.join( routinePath, [ './super.im.will.yml', './super.ex.will.yml' ] ) );
    test.identical( module.openedModule.willfileArray.length, 2 );
    test.identical( _.mapKeys( module.openedModule.willfileWithRoleMap ), [ 'import', 'export' ] );

    test.is( !!module.openedModule.about );
    test.identical( module.openedModule.about.name, 'supermodule' );
    test.identical( module.openedModule.pathMap, pathMap );
    test.identical( _.mapKeys( module.openedModule.submoduleMap ), [ 'Submodule' ] );
    test.identical( _.filter( _.mapKeys( module.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ), [ 'reflect.submodules.', 'reflect.submodules.debug' ] );

    let steps = _.select( module.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( steps, [ 'reflect.submodules.', 'reflect.submodules.debug', 'export.', 'export.debug' ] );
    test.identical( _.mapKeys( module.openedModule.buildMap ), [ 'debug', 'release', 'export.', 'export.debug' ] );
    test.identical( _.mapKeys( module.openedModule.exportedMap ), [] );

  }

}

//

function makeAnon( test )
{
  let self = this;
  let assetName = 'import-in/.';
  let originalDirPath = _.path.join( self.assetDirPath, 'import-in-exported' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, '' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  var module1 = will.moduleMake({ willfilesPath : modulePath });
  let ready1 = module1.openedModule.ready;

  var module2 = will.moduleMake({ willfilesPath : modulePath + '/' });
  let ready2 = module2.openedModule.ready;

  /* - */

  module1.openedModule.ready.thenKeep( ( arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    check( module1 );
    return null;
  })

  /* - */

  module1.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    test.is( err === undefined );
    module1.finit();
    if( err )
    throw err;
    return arg;
  });

  /* - */

  module2.openedModule.ready.thenKeep( ( arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    check( module2 );
    return null;
  })

  /* - */

  module2.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    test.is( err === undefined );
    module2.finit();
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake([ ready1, ready2 ])
  .finallyKeep( ( err, arg ) =>
  {
    debugger;
    if( err )
    throw err;
    return arg;
  });

  /* - */

  function check( module )
  {

    let pathMap =
    {

      'proto' : '.',
      'in' : 'proto',
      'out' : '../out',
      'out.debug' : '../out/debug',
      'out.release' : '../out/release',

      // 'local' : path.join( routinePath, '.' ),
      'local' : null,
      'remote' : null,
      'current.remote' : null,
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : routinePath,
      'module.willfiles' : [ routinePath + '/.im.will.yml', routinePath + '/.ex.will.yml' ],
      'module.original.willfiles' : null,
      'temp' : [ '../out', '../super.out' ],
      'module.common' : path.join( routinePath ) + '/',

    }

    test.identical( module.nickName, 'module::submodule' );
    test.identical( module.absoluteName, 'module::submodule' );
    test.identical( module.inPath, routinePath + '/proto' );
    test.identical( module.outPath, routinePath + '/out' );
    test.identical( module.dirPath, routinePath );
    test.identical( module.commonPath, path.join( routinePath, '.' ) + '/' );
    test.identical( module.willfilesPath, [ routinePath + '/.im.will.yml', routinePath + '/.ex.will.yml' ] );
    test.identical( module.configName, 'makeAnon' );
    test.identical( module.localPath, null );
    test.identical( module.remotePath, null );
    // test.identical( module.currentRemotePath, null );
    test.identical( module.willPath, path.join( __dirname, '../will/Exec' ) );
    test.identical( module.willfileArray.length, 2 );
    test.identical( _.mapKeys( module.willfileWithRoleMap ), [ 'import', 'export' ] );

    test.identical( module.openedModule.nickName, 'module::submodule' );
    test.identical( module.openedModule.absoluteName, 'module::submodule' );
    test.identical( module.openedModule.inPath, routinePath + '/proto' );
    test.identical( module.openedModule.outPath, routinePath + '/out' );
    test.identical( module.openedModule.dirPath, routinePath );
    test.identical( module.openedModule.commonPath, path.join( routinePath, '.' ) + '/' );
    test.identical( module.openedModule.willfilesPath, [ routinePath + '/.im.will.yml', routinePath + '/.ex.will.yml' ] );
    test.identical( module.openedModule.configName, 'makeAnon' );
    test.identical( module.openedModule.localPath, null );
    test.identical( module.openedModule.remotePath, null );
    test.identical( module.openedModule.currentRemotePath, null );
    test.identical( module.openedModule.willPath, path.join( __dirname, '../will/Exec' ) );
    test.identical( module.openedModule.willfileArray.length, 2 );
    test.identical( _.mapKeys( module.openedModule.willfileWithRoleMap ), [ 'import', 'export' ] );

    test.is( !!module.openedModule.about );
    test.identical( module.openedModule.about.name, 'submodule' );
    test.identical( module.openedModule.pathMap, pathMap );
    test.identical( _.mapKeys( module.openedModule.submoduleMap ), [] );
    test.identical( _.filter( _.mapKeys( module.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ), [ 'reflect.proto.', 'reflect.proto.debug' ] );

    let steps = _.select( module.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( steps, [ 'reflect.proto.', 'reflect.proto.debug', 'reflect.proto.raw', 'reflect.proto.debug.raw', 'export.', 'export.debug' ] );
    test.identical( _.mapKeys( module.openedModule.buildMap ), [ 'debug.raw', 'release.raw', 'export.', 'export.debug' ] );
    test.identical( _.mapKeys( module.openedModule.exportedMap ), [] );

  }

}

//

function makeOutNamed( test )
{
  let self = this;
  let assetName = 'import-in/super.out/supermodule';
  let originalDirPath = _.path.join( self.assetDirPath, 'import-in-exported' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let moduleDirPath = _.path.join( routinePath, 'super.out' );
  let moduleFilePath = _.path.join( routinePath, 'super.out/supermodule' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  var module1 = will.moduleMake({ willfilesPath : moduleFilePath });
  let ready1 = module1.openedModule.ready;
  var module2 = will.moduleMake({ willfilesPath : moduleFilePath });
  let ready2 = module2.openedModule.ready;

  /* - */

  module1.openedModule.ready.thenKeep( ( arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    check( module1 );
    return null;
  })

  module1.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    test.case = 'opened filePath : ' + assetName;
    test.is( err === undefined );
    module1.finit();
    if( err )
    throw err;
    return arg;
  });

  /* - */

  module2.openedModule.ready.thenKeep( ( arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    check( module2 );
    return null;
  })

  module2.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    test.case = 'opened dirPath : ' + assetName;
    test.is( err === undefined );
    module2.finit();
    if( err )
    throw err;
    return arg;
  });

  return _.Consequence.AndTake([ ready1, ready2 ])
  .finallyKeep( ( err, arg ) =>
  {
    debugger;
    if( err )
    throw err;
    return arg;
  });

  /* - */

  function check( module )
  {

    let pathMap =
    {

      'proto' : './proto',
      'temp' : [ './super.out', './out' ],
      'out' : './super.out',
      'out.debug' : './super.out/debug',
      'out.release' : './super.out/release',
      'in' : '..',
      'exported.dir.export.debug' : './super.out/debug',
      'exported.files.export.debug' : [ 'super.out/debug', 'super.out/debug/File.debug.js', 'super.out/debug/File.release.js' ],
      // 'archiveFile.export.debug' : './super.out/supermodule.debug.out.tgs',
      'exported.dir.export.' : './super.out/release',
      'exported.files.export.' : [ 'super.out/release', 'super.out/release/File.debug.js', 'super.out/release/File.release.js' ],
      // 'archiveFile.export.' : './super.out/supermodule.out.tgs',

      // 'local' : routinePath + '/super.out',
      'local' : null,
      'remote' : null,
      'current.remote' : null,
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : routinePath + '/super.out',
      'module.willfiles' : routinePath + '/super.out/supermodule.out.will.yml',
      'module.original.willfiles' : _.path.s.join( routinePath, [ 'super.im.will.yml', 'super.ex.will.yml' ] ),
      'module.common' : path.join( routinePath ) + '/super.out/supermodule.out',

    }

    test.identical( module.nickName, 'module::supermodule' );
    test.identical( module.absoluteName, 'module::supermodule' );
    test.identical( module.inPath, routinePath );
    test.identical( module.outPath, routinePath + '/super.out' );
    test.identical( module.dirPath, routinePath + '/super.out' );
    test.identical( module.localPath, null );
    // test.identical( module.localPath, routinePath + '/super.out' );
    test.identical( module.willfilesPath, routinePath + '/super.out/supermodule.out.will.yml' );
    test.identical( module.commonPath, path.join( routinePath, 'super.out/supermodule.out' ) );
    test.identical( module.configName, 'supermodule.out' );

    test.is( !!module.openedModule.about );
    test.identical( module.openedModule.about.name, 'supermodule' );

    test.identical( module.openedModule.pathMap, pathMap );
    test.identical( module.openedModule.willfileArray.length, 1 );
    test.identical( _.mapKeys( module.openedModule.willfileWithRoleMap ), [ 'single' ] );
    test.identical( _.mapKeys( module.openedModule.submoduleMap ), [ 'Submodule' ] );
    test.identical( _.filter( _.mapKeys( module.openedModule.reflectorMap ), ( e, k ) => _.strHas( e, 'predefined.' ) ? undefined : e ), [ 'reflect.submodules.', 'reflect.submodules.debug', 'exported.export.debug', 'exported.files.export.debug', 'exported.export.', 'exported.files.export.' ] );

    let steps = _.select( module.openedModule.resolve({ selector : 'step::*', criterion : { predefined : 0 } }), '*/name' );
    test.identical( steps, [ 'reflect.submodules.', 'reflect.submodules.debug', 'export.', 'export.debug', 'exported.export.debug', 'exported.files.export.debug', 'exported.export.', 'exported.files.export.' ] );

    test.identical( _.mapKeys( module.openedModule.buildMap ), [ 'debug', 'release', 'export.', 'export.debug' ] );
    test.identical( _.mapKeys( module.openedModule.exportedMap ), [ 'export.', 'export.debug' ] );

  }

}

//

function clone( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'import-in-exported' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'super' );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  function checkMap( module2, mapName )
  {
    test.open( mapName );

    test.is( module.openedModule[ mapName ] !== module2.openedModule[ mapName ] );
    test.identical( _.mapKeys( module.openedModule[ mapName ] ), _.mapKeys( module2.openedModule[ mapName ] ) );
    for( var k in module.openedModule[ mapName ] )
    {
      var resource1 = module.openedModule[ mapName ][ k ];
      var resource2 = module2.openedModule[ mapName ][ k ];
      test.is( !!resource1 );
      test.is( !!resource2 );
      if( !resource1 || !resource2 )
      continue;
      test.is( resource1 !== resource2 );
      test.is( resource1.module === module.openedModule );
      test.is( resource2.module === module2.openedModule );
      if( resource1 instanceof will.Resource )
      {
        test.is( !!resource1.willf || ( resource1.criterion && resource1.criterion.predefined ) );
        test.is( !resource2.willf );
      }
    }

    test.close( mapName );
  }

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  var module = will.moduleMake({ willfilesPath : modulePath });

  /* - */

  module.openedModule.ready.thenKeep( ( arg ) =>
  {
    test.case = 'clone';

    var module2 = module.clone();

    test.identical( module2.willfileArray.length, 2 );
    test.identical( _.mapKeys( module2.willfileWithRoleMap ), [ 'import', 'export' ] );
    test.identical( module2.name, 'super' );
    test.identical( module2.nickName, 'module::super' );
    test.identical( module2.absoluteName, 'module::super' );
    test.identical( module2.inPath, module2.inPath );
    test.identical( module2.outPath, module2.outPath );

    module2.close();

    test.identical( module2.willfileArray.length, 0 );
    test.identical( _.mapKeys( module2.willfileWithRoleMap ), [] );

    module2.open();

    test.case = 'compare elements';

    test.is( module.openedModule === module2.openedModule );
    test.identical( module.nickName, module2.nickName );
    test.identical( module.absoluteName, module2.absoluteName );
    test.identical( module.inPath, module2.inPath );
    test.identical( module.outPath, module2.outPath );
    test.is( module.openedModule.about === module2.openedModule.about );
    test.is( module.openedModule.pathMap === module2.openedModule.pathMap );
    test.identical( module.openedModule.pathMap, module2.openedModule.pathMap );

    test.is( module.willfileArray !== module2.willfileArray );
    test.is( module.willfileWithRoleMap !== module2.willfileWithRoleMap );

    test.case = 'finit';

    module2.finit();

    return null;
  })

  /* - */

  module.openedModule.ready.thenKeep( ( arg ) =>
  {
    test.case = 'clone extending';

    let newPath = _.path.join( routinePath, 'new' );
    var module2 = module.cloneExtending({ willfilesPath : newPath });

    test.identical( module2.willfileArray.length, 2 );
    test.identical( _.mapKeys( module2.willfileWithRoleMap ), [ 'import', 'export' ] );
    test.identical( module2.name, 'super' );
    test.identical( module2.nickName, 'module::super' );
    test.identical( module2.absoluteName, 'module::super' );
    test.identical( module2.inPath, module2.inPath );
    test.identical( module2.outPath, module2.outPath );

    module2.close();

    test.identical( module2.willfileArray.length, 0 );
    test.identical( _.mapKeys( module2.willfileWithRoleMap ), [] );

    debugger;
    module2.openCloning( module.openedModule );
    debugger;

    test.case = 'compare elements';

    test.is( module.openedModule !== module2.openedModule );
    test.identical( module.nickName, module2.nickName );
    test.identical( module.absoluteName, module2.absoluteName );
    test.identical( module.inPath, module2.inPath );
    test.identical( module.outPath, module2.outPath );
    test.is( module.openedModule.about !== module2.openedModule.about );
    test.is( module.openedModule.pathMap !== module2.openedModule.pathMap );

    test.is( module.willfileArray !== module2.willfileArray );
    test.is( module.willfileWithRoleMap !== module2.willfileWithRoleMap );

    checkMap( module2, 'submoduleMap' );
    checkMap( module2, 'pathResourceMap' );
    checkMap( module2, 'reflectorMap' );
    checkMap( module2, 'stepMap' );
    checkMap( module2, 'buildMap' );
    checkMap( module2, 'exportedMap' );

    test.case = 'finit';

    module2.finit();

    return null;
  })

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();

    test.identical( will.moduleArray.length, 0 );
    test.identical( _.mapKeys( will.moduleWithIdMap ).length, 0 );
    test.identical( _.mapKeys( will.moduleWithPathMap ).length, 0 );
    test.identical( will.openerModuleArray.length, 0 );
    test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, 0 );
    test.identical( will.willfileArray.length, 0 );
    test.identical( _.mapKeys( will.willfileWithPathMap ).length, 0 );

    return arg;
  });

  return ready.split();
}

clone.timeOut = 130000;

//

function reflectorResolve( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'composite-reflector' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, '.' );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
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
  _.fileProvider.filesDelete( outPath );

  var module = will.moduleMake({ willfilesPath : modulePath });

  /* - */

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.case = 'reflector::reflect.proto.0.debug formed:1';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.0.debug' )
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
    var resolvedData = resolved.dataExport({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.0.debug';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.0.debug' )
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
    var resolvedData = resolved.dataExport();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.1.debug formed:1';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.1.debug' )
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
    var resolvedData = resolved.dataExport({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.1.debug';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.1.debug' )
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

    var resolvedData = resolved.dataExport();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.2.debug formed:1';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.2.debug' );
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
    var resolvedData = resolved.dataExport({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.2.debug';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.2.debug' );
    resolved.form();
    var expected =
    {
      'dst' :
      {
        'filePath' : { 'path::proto' : 'path::out.*=1' }
      },
      'criterion' : { 'debug' : 1, 'variant' : 2 },
      'inherit' : [ 'predefined.*' ],
      'mandatory' : 1,
    }
    var resolvedData = resolved.dataExport();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.3.debug formed:1';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.3.debug' );
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
    var resolvedData = resolved.dataExport({ formed:1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.3.debug';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.3.debug' );
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
    var resolvedData = resolved.dataExport();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );

    test.case = 'reflector::reflect.proto.4.debug formed:1';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.4.debug' );
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
    var resolvedData = resolved.dataExport({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1' ) );

    test.case = 'reflector::reflect.proto.4.debug';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.4.debug' );
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
    var resolvedData = resolved.dataExport();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1' ) );

    test.case = 'reflector::reflect.proto.5.debug formed:1';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.5.debug' );
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
    var resolvedData = resolved.dataExport({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1' ) );

    test.case = 'reflector::reflect.proto.5.debug';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.5.debug' );
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
    var resolvedData = resolved.dataExport();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1' ) );

    test.case = 'reflector::reflect.proto.6.debug formed:1';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.6.debug' );
    resolved.form();
    var expected =
    {
      'src' :
      {
        'filePath' : { '.' : '.' },
        'prefixPath' : 'proto/dir2/File.test.js',
      },
      'dst' : { 'prefixPath' : 'out/debug/dir1/File.test.js' },
      'criterion' : { 'debug' : 1, 'variant' : 6 },
      'mandatory' : 1
    }
    var resolvedData = resolved.dataExport({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1/File.test.js' ) );

    test.case = 'reflector::reflect.proto.6.debug';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.6.debug' );
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
    var resolvedData = resolved.dataExport();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1/File.test.js' ) );

    test.case = 'reflector::reflect.proto.7.debug formed:1';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.7.debug' );
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
    var resolvedData = resolved.dataExport({ formed : 1 });
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1/File.test.js' ) );

    test.case = 'reflector::reflect.proto.7.debug';
    var resolved = module.openedModule.resolve( 'reflector::reflect.proto.7.debug' );
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
    var resolvedData = resolved.dataExport();
    if( resolvedData.src && resolvedData.src.maskAll )
    resolvedData.src.maskAll.excludeAny = !!resolvedData.src.maskAll.excludeAny;
    test.identical( resolved.formed, 3 );
    test.identical( resolvedData, expected );
    test.identical( resolved.src.prefixPath, pin( 'proto/dir2/File.test.js' ) );
    test.identical( resolved.dst.prefixPath, pin( 'out/debug/dir1/File.test.js' ) );

    return null;
  });

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();
    return arg;
  }).split();

  return ready.split();
}

//

function superResolve( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'super' );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesDelete( outPath );

  var module = will.moduleMake({ willfilesPath : modulePath });

  /* - */

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    debugger;

    test.case = 'build::*';
    var resolved = module.openedModule.resolve( 'build::*' );
    test.identical( resolved.length, 4 );

    test.case = '*::*a*';
    var resolved = module.openedModule.resolve
    ({
      selector : '*::*a*',
      pathUnwrapping : 0,
      missingAction : 'undefine',
    });
    test.identical( resolved.length, 15 );

    test.case = '*::*a*/nickName';
    var resolved = module.openedModule.resolve
    ({
      selector : '*::*a*/nickName',
      pathUnwrapping : 0,
      singleUnwrapping : 0,
      mapValsUnwrapping : 1,
      missingAction : 'undefine',
    });
    test.identical( resolved, [ 'path::module.original.willfiles', 'path::local', 'path::out.release', 'reflector::predefined.release.v1', 'reflector::predefined.release.v2', 'step::timelapse.begin', 'step::timelapse.end', 'step::files.transpile', 'step::npm.generate', 'step::submodules.download', 'step::submodules.update', 'step::submodules.reload', 'step::submodules.clean', 'step::clean', 'build::release' ] );

    test.case = '*';
    var resolved = module.openedModule.resolve
    ({
      selector : '*',
      pathUnwrapping : 1,
      pathResolving : 0
    });
    test.identical( resolved, '*' );

    test.case = '*::*';
    var resolved = module.openedModule.resolve
    ({
      selector : '*::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : 0,
    });
    test.identical( resolved.length, 45 );

    test.case = '* + defaultResourceName';
    var resolved = module.openedModule.resolve
    ({
      selector : '*',
      defaultResourceName : 'path',
      prefixlessAction : 'default',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : 0,
    });
    test.identical( resolved.length, 14 );

    return null;
  })

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();
    return arg;
  });

  return ready.split();
  // return module.openedModule.ready.split();
}

superResolve.timeOut = 130000;

//

function buildsResolve( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'super' );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesDelete( outPath );

  var module = will.moduleMake({ willfilesPath : modulePath });

  /* - */

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.case = 'build::*'; /* */

    var resolved = module.openedModule.resolve({ selector : 'build::*' });
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

    var resolved = module.openedModule.resolve({ selector : 'build::*', criterion : { debug : 1 } });
    test.identical( resolved.length, 2 );

    var expected = [ 'debug', 'export.debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    test.case = 'build::*, currentContext is build::export.'; /* */

    var build = module.openedModule.resolve({ selector : 'build::export.' });
    test.is( build instanceof will.Build );
    test.identical( build.nickName, 'build::export.' );
    test.identical( build.absoluteName, 'module::supermodule / build::export.' );

    var resolved = module.openedModule.resolve({ selector : 'build::*', currentContext : build, singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'release' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    var expected = { 'debug' : 0 };
    var got = resolved[ 0 ].criterion;
    test.identical( got, expected );

    test.case = 'build::*, currentContext is build::export.debug'; /* */

    var build = module.openedModule.resolve({ selector : 'build::export.debug' });
    var resolved = module.openedModule.resolve({ selector : 'build::*', currentContext : build, singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    var expected = { 'debug' : 1, 'default' : 1 };
    var got = resolved[ 0 ].criterion;
    test.identical( got, expected );

    test.case = 'build::*, currentContext is build::export.debug, short-cut'; /* */

    var build = module.openedModule.resolve({ selector : 'build::export.debug' });
    var resolved = build.resolve({ selector : 'build::*', singleUnwrapping : 0 });
    test.identical( resolved.length, 1 );

    var expected = [ 'debug' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    test.case = 'build::*, short-cut, explicit criterion'; /* */

    var build = module.openedModule.resolve({ selector : 'build::export.*', criterion : { debug : 1 } });
    var resolved = build.resolve({ selector : 'build::*', singleUnwrapping : 0, criterion : { debug : 0 } });
    test.identical( resolved.length, 2 );

    var expected = [ 'release', 'export.' ];
    var got = _.select( resolved, '*/name' );
    test.identical( got, expected );

    return null;
  })

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();
    return arg;
  });

  return ready.split();
}

buildsResolve.timeOut = 130000;

//

function pathsResolve( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'super' );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.join( __dirname, '../will/Exec' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  function pin( filePath )
  {
    if( _.arrayIs( filePath ) )
    return filePath.map( ( e ) => path.s.join( routinePath, e ) );
    return path.s.join( routinePath, filePath );
  }

  function pout( filePath )
  {
    if( _.arrayIs( filePath ) )
    return filePath.map( ( e ) => path.s.join( routinePath, 'super.out', e ) );
    return path.s.join( routinePath, 'super.out', filePath );
  }

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesDelete( outPath );

  var module = will.moduleMake({ willfilesPath : modulePath });

  /* - */

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.case = 'resolved, .';
    var resolved = module.openedModule.resolve({ prefixlessAction : 'resolved', selector : '.' })
    var expected = '.';
    test.identical( resolved, expected );

    return null;
  })

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.case = 'path::in*=1, pathResolving : 0';
    var resolved = module.openedModule.resolve({ prefixlessAction : 'resolved', selector : 'path::in*=1', pathResolving : 0 })
    var expected = '.';
    test.identical( resolved, expected );

    test.case = 'path::in*=1';
    var resolved = module.openedModule.resolve({ prefixlessAction : 'resolved', selector : 'path::in*=1' })
    var expected = routinePath;
    test.identical( resolved, expected );

    test.case = 'path::out.debug';
    var resolved = module.openedModule.resolve( 'path::out.debug' )
    var expected = pin( 'super.out/debug' );
    test.identical( resolved, expected );

    test.case = '[ path::out.debug, path::out.release ]';
    var resolved = module.openedModule.resolve( [ 'path::out.debug', 'path::out.release' ] );
    var expected = pin([ 'super.out/debug', 'super.out/release' ]);
    test.identical( resolved, expected );

    test.case = '{path::in*=1}/proto, pathNativizing : 1';
    var resolved = module.openedModule.resolve({ selector : '{path::in*=1}/proto', pathNativizing : 1, selectorIsPath : 1 })
    var expected = _.path.nativize( pin( 'proto' ) );
    test.identical( resolved, expected );

    test.case = '{path::in*=1}/proto, pathNativizing : 1';
    var resolved = module.openedModule.resolve({ selector : '{path::in*=1}/proto', pathNativizing : 1, selectorIsPath : 0 })
    var expected = _.path.nativize( pin( '.' ) ) + '/proto';
    test.identical( resolved, expected );

    return null;
  })

  /* - */

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.case = 'path::* - implicit'; /* */
    var resolved = module.openedModule.resolve( 'path::*' );
    var expected = pin([ './super.im.will.yml', './super.ex.will.yml', '.', path.join( __dirname, '../will/Exec' ), './proto', './super.out', '.', './super.out', './super.out/debug', './super.out/release' ]);

    var expected = pin
    ([
      './super.im.will.yml',
      './super.ex.will.yml',
      null,
      '.',
      'super',
      null,
      null,
      null,
      execPath,
      './proto',
      './super.out',
      '.',
      './super.out',
      './super.out/debug',
      './super.out/release'
    ]);

    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:1 pr:in'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
      pathResolving : 'in',
    });
    var expected = pin
    ([
      [
        './super.im.will.yml',
        './super.ex.will.yml'
      ],
      null,
      '.',
      'super',
      null,
      null,
      null,
      execPath,
      './proto',
      './super.out',
      '.',
      './super.out',
      './super.out/debug',
      './super.out/release',
    ]);
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:1 pr:out'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
      pathResolving : 'out',
    });
    var expected = pout
    ([
        pin
        ([
          './super.im.will.yml',
          './super.ex.will.yml'
        ]),
        null,
        pin( '.' ),
        pin( 'super' ),
        null,
        null,
        null,
        execPath,
        './proto',
        './super.out',
        '.',
        '.',
        './super.out/debug',
        './super.out/release'
    ]);
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:1 pr:null'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 1,
      arrayFlattening : 0,
      pathResolving : null,
    });
    var expected =
    [
      [
        pin( './super.im.will.yml' ),
        pin( './super.ex.will.yml' ),
      ],
      null,
      pin( '.' ),
      pin( 'super' ),
      null,
      null,
      null,
      execPath,
      './proto',
      './super.out',
      '.',
      './super.out',
      './super.out/debug',
      './super.out/release'
    ];
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:0 mvu:0 pr:null'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 0,
      arrayFlattening : 0,
      pathResolving : null,
    });
    var expected =
    {
      'proto' : './proto',
      'temp' : './super.out',
      'in' : '.',
      'out' : './super.out',
      'out.debug' : './super.out/debug',
      'out.release' : './super.out/release',
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : routinePath + '',
      'module.willfiles' : [ routinePath + '/super.im.will.yml', routinePath + '/super.ex.will.yml' ],
      'module.common' : routinePath + '/super',
      'module.original.willfiles' : null,
      'local' : null,
      'remote' : null,
      'current.remote' : null
    }
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );
    _.any( resolved, ( e, k ) => test.is( e.identicalWith( module.openedModule.pathResourceMap[ k ] ) ) );
    _.any( resolved, ( e, k ) => test.is( e.module === module || e.module === module.openedModule ) );
    _.any( resolved, ( e, k ) => test.is( !e.original ) );

    test.case = 'path::* - pu:0 mvu:0 pr:in'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 0,
      pathResolving : 'in',
    });
    var expected =
    {
      'proto' : pin( './proto' ),
      'temp' : pin( './super.out' ),
      'in' : pin( '.' ),
      'out' : pin( './super.out' ),
      'out.debug' : pin( './super.out/debug' ),
      'out.release' : pin( './super.out/release' ),
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : routinePath + '',
      'module.willfiles' : [ routinePath + '/super.im.will.yml', routinePath + '/super.ex.will.yml' ],
      'module.common' : routinePath + '/super',
      'module.original.willfiles' : null,
      'local' : null,
      'remote' : null,
      'current.remote' : null,
    }
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );

    test.case = 'path::* - pu:0 mvu:0 pr:out'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 0,
      pathResolving : 'out',
    });
    var expected =
    {
      'proto' : pout( './proto' ),
      'temp' : pout( './super.out' ),
      'in' : pout( '.' ),
      'out' : pout( '.' ),
      'out.debug' : pout( './super.out/debug' ),
      'out.release' : pout( './super.out/release' ),
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : routinePath + '',
      'module.willfiles' : [ routinePath + '/super.im.will.yml', routinePath + '/super.ex.will.yml' ],
      'module.common' : routinePath + '/super',
      'module.original.willfiles' : null,
      'local' : null,
      'remote' : null,
      'current.remote' : null
    }
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:0 pr:null'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 0,
      pathResolving : null,
    });
    var expected =
    {
      'proto' : './proto',
      'temp' : './super.out',
      'in' : '.',
      'out' : './super.out',
      'out.debug' : './super.out/debug',
      'out.release' : './super.out/release',
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : routinePath + '',
      'module.willfiles' : [ routinePath + '/super.im.will.yml', routinePath + '/super.ex.will.yml' ],
      'module.common' : routinePath + '/super',
      'module.original.willfiles' : null,
      'local' : null,
      'remote' : null,
      'current.remote' : null
    }
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:0 pr:in'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 0,
      pathResolving : 'in',
    });
    var expected =
    {
      'proto' : pin( './proto' ),
      'temp' : pin( './super.out' ),
      'in' : pin( '.' ),
      'out' : pin( './super.out' ),
      'out.debug' : pin( './super.out/debug' ),
      'out.release' : pin( './super.out/release' ),
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : routinePath + '',
      'module.willfiles' : [ routinePath + '/super.im.will.yml', routinePath + '/super.ex.will.yml' ],
      'module.common' : routinePath + '/super',
      'module.original.willfiles' : null,
      'local' : null,
      'remote' : null,
      'current.remote' : null
    }
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:1 mvu:0 pr:out'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 1,
      mapValsUnwrapping : 0,
      pathResolving : 'out',
    });
    var expected =
    {
      'proto' : pout( './proto' ),
      'temp' : pout( './super.out' ),
      'in' : pout( '.' ),
      'out' : pout( '.' ),
      'out.debug' : pout( './super.out/debug' ),
      'out.release' : pout( './super.out/release' ),
      'will' : path.join( __dirname, '../will/Exec' ),
      'module.dir' : routinePath + '',
      'module.willfiles' : [ routinePath + '/super.im.will.yml', routinePath + '/super.ex.will.yml' ],
      'module.common' : routinePath + '/super',
      'module.original.willfiles' : null,
      'local' : null,
      'remote' : null,
      'current.remote' : null
    }
    var got = resolved;
    test.identical( got, expected );

    test.case = 'path::* - pu:0 mvu:1 pr:null'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : null,
    });
    var expected =
    [
      [
        pin( './super.im.will.yml' ),
        pin( './super.ex.will.yml' ),
      ],
      null,
      pin( '.' ),
      pin( 'super' ),
      null,
      null,
      null,
      execPath,
      './proto',
      './super.out',
      '.',
      './super.out',
      './super.out/debug',
      './super.out/release'
    ];
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );

    test.case = 'path::* - pu:0 mvu:1 pr:in'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : 'in',
    });
    var expected = pin
    ([
      [
        './super.im.will.yml',
        './super.ex.will.yml'
      ],
      null,
      '.',
      'super',
      null,
      null,
      null,
      execPath,
      './proto',
      './super.out',
      '.',
      './super.out',
      './super.out/debug',
      './super.out/release'
    ])
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );

    test.case = 'path::* - pu:0 mvu:1 pr:out'; /* */
    var resolved = module.openedModule.resolve
    ({
      selector : 'path::*',
      pathUnwrapping : 0,
      mapValsUnwrapping : 1,
      pathResolving : 'out',
    });
    var expected = pout
    ([
      [
        pin( './super.im.will.yml' ),
        pin( './super.ex.will.yml' ),
      ],
      null,
      pin( '.' ),
      pin( 'super' ),
      null,
      null,
      null,
      execPath,
      './proto',
      './super.out',
      '.',
      '.',
      './super.out/debug',
      './super.out/release',
    ]);
    var got = _.select( resolved, '*/path' );
    test.identical( got, expected );

    return null;
  });

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();
    return arg;
  });

  return ready.split();
}

pathsResolve.timeOut = 130000;

//

function pathsResolveImportIn( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'import-in-exported' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'super' );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
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
  // _.fileProvider.filesDelete( outPath );

  var module = will.moduleMake({ willfilesPath : modulePath });

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.case = 'submodule::*/path::in*=1, default';
    var resolved = module.openedModule.resolve( 'submodule::*/path::in*=1' )
    var expected = pin( 'proto' );
    test.identical( resolved, expected );

    test.case = 'submodule::*/path::in*=1, pathResolving : 0';
    var resolved = module.openedModule.resolve({ prefixlessAction : 'resolved', selector : 'submodule::*/path::in*=1', pathResolving : 0 })
    var expected = '../proto';
    test.identical( resolved, expected );

    test.case = 'submodule::*/path::in*=1, strange case';
    var resolved = module.openedModule.resolve
    ({
      selector : 'submodule::*/path::in*=1',
      mapValsUnwrapping : 1,
      singleUnwrapping : 1,
      mapFlattening : 1,
    });
    var expected = pin( 'proto' );
    test.identical( resolved, expected );

    return null;
  });

  module.openedModule.ready.thenKeep( ( arg ) =>
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
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
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
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
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
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ '../proto' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
    });
    var expected = { 'Submodule/in' : '../proto' };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
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
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
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
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ '../proto' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
      'Submodule' : { 'in' : '../proto' }
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

    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
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
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
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
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ pin( 'proto' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
    });
    var expected = { 'Submodule/in' : pin( 'proto' ) };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
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
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
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
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ pin( 'proto' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
      'Submodule' : { 'in' : pin( 'proto' ) }
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
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
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
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
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
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ '.' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 0,
      mapValsUnwrapping : 0,
    });
    var expected = { 'Submodule/proto' : '.' };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
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
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::proto*=1',
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
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ '.' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
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
      'Submodule' : { 'proto' : '.' }
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

    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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

    debugger;
    return null;
  })

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();
    return arg;
  });

  return ready.split();
  // return module.openedModule.ready.split();
}

pathsResolveImportIn.timeOut = 130000;

//

function pathsResolveOfSubmodules( test )
{
  let self = this;
  let originalRepoPath = _.path.join( self.assetDirPath, 'repo' );
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-local-repos' );
  let repoPath = _.path.join( self.tempDir, 'repo' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesDelete( repoPath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesReflect({ reflectMap : { [ originalRepoPath ] : repoPath } });
  _.fileProvider.filesDelete( outPath );

  var module = will.moduleMake({ willfilesPath : routinePath });

  /* - */

  module.openedModule.ready.thenKeep( ( arg ) =>
  {
    let builds = module.openedModule.buildsResolve({ name : 'debug.raw' });
    test.identical( builds.length, 1 );
    let build = builds[ 0 ];
    return build.perform();
  })

  /* - */

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.case = 'resolve submodules';
    var submodules = module.openedModule.submodulesResolve({ selector : '*' });
    test.identical( submodules.length, 2 );

    test.case = 'path::in, wTools';
    var submodule = submodules[ 0 ];
    var resolved = submodule.resolve( 'path::in' );
    var expected = path.join( submodulesPath, 'Tools' );
    test.identical( resolved, expected );

    test.case = 'path::in, wTools, through oModule';
    var submodule = submodules[ 0 ].oModule;
    var resolved = submodule.openedModule.resolve( 'path::in' );
    var expected = path.join( submodulesPath, 'Tools' );
    test.identical( resolved, expected );

    test.case = 'path::out, wTools';
    var submodule = submodules[ 0 ];
    var resolved = submodule.resolve( 'path::out' );
    var expected = path.join( submodulesPath, 'Tools/out' );
    test.identical( resolved, expected );

    test.case = 'path::out, wTools, through oModule';
    var submodule = submodules[ 0 ].oModule;
    var resolved = submodule.openedModule.resolve( 'path::out' );
    var expected = path.join( submodulesPath, 'Tools/out' );
    test.identical( resolved, expected );

    return null;
  })

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();
    return arg;
  })

  return ready.split().finally( ( err, arg ) =>
  {
    if( err && err.finited )
    return null;
    if( err )
    throw err;
    return null;
  });

}

pathsResolveOfSubmodules.timeOut = 500000;

//

function pathsResolveOutFileOfExports( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'multiple-exports-exported' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'super.out/supermodule' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  function pin( filePath )
  {
    return path.s.join( routinePath, filePath );
  }

  function pout( filePath )
  {
    return path.s.join( routinePath, 'out', filePath );
  }

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  var module = will.moduleMake({ willfilesPath : modulePath });

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.open( 'without export' );

    test.case = 'submodule::*/path::in*=1, default';
    var resolved = module.openedModule.resolve( 'submodule::*/path::in*=1' );
    var expected = pin( '.' );
    test.identical( resolved, expected );

    test.case = 'submodule::*/path::in*=1, pathResolving : 0';
    var resolved = module.openedModule.resolve({ prefixlessAction : 'resolved', selector : 'submodule::*/path::in*=1', pathResolving : 0 });
    var expected = '..';
    test.identical( resolved, expected );

    test.case = 'submodule::*/path::in*=1, strange case';
    var resolved = module.openedModule.resolve
    ({
      selector : 'submodule::*/path::in*=1',
      mapValsUnwrapping : 1,
      singleUnwrapping : 1,
      mapFlattening : 1,
    });
    var expected = pin( '.' );
    test.identical( resolved, expected );

    test.close( 'without export' );

    /* - */

    test.open( 'with export' );

    test.case = 'submodule::*/exported::*=1debug/path::in*=1, default';
    var resolved = module.openedModule.resolve( 'submodule::*/exported::*=1debug/path::in*=1' );
    var expected = pin( '.' );
    test.identical( resolved, expected );

    test.case = 'submodule::*/exported::*=1debug/path::in*=1, pathResolving : 0';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/exported::*=1debug/path::in*=1',
      pathResolving : 0,
    })
    var expected = '..';
    test.identical( resolved, expected );

    test.case = 'submodule::*/exported::*=1debug/path::in*=1, strange case';
    var resolved = module.openedModule.resolve
    ({
      selector : 'submodule::*/exported::*=1debug/path::in*=1',
      mapValsUnwrapping : 1,
      singleUnwrapping : 1,
      mapFlattening : 1,
    });
    var expected = pin( '.' );
    test.identical( resolved, expected );

    test.close( 'with export' );

    // "submodule::*/exported::*=1debug/path::exported.dir*=1"

    return null;
  });

  module.openedModule.ready.thenKeep( ( arg ) =>
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
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = '..';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 0,
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = '..';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ '..' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = { 'Submodule/in' : '..' };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = '..';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = '..';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ '..' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
      'Submodule' : { 'in' : '..' }
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

    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 1,
    });
    var expected = pin( '.' );
    test.identical( resolved, expected );

    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
    ({
      prefixlessAction : 'resolved',
      selector : 'submodule::*/path::in*=1',
      pathUnwrapping : 1,
      pathResolving : 'in',
      mapFlattening : 1,
      singleUnwrapping : 1,
      mapValsUnwrapping : 0,
    });
    var expected = pin( '.' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ pin( '.' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = { 'Submodule/in' : pin( '.' ) };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = pin( '.' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = pin( '.' );
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ pin( '.' ) ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::in*=1';
    var resolved = module.openedModule.resolve
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
      'Submodule' : { 'in' : pin( '.' ) }
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
    var resolved = module.openedModule.resolve
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
    var expected = './proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
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
    var expected = './proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ './proto' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
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
    var expected = { 'Submodule/proto' : './proto' };
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 0' );

    test.close( 'mapFlattening : 1' );
    test.open( 'mapFlattening : 0' );

    test.open( 'singleUnwrapping : 1' );

    test.open( 'mapValsUnwrapping : 1' );

    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
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
    var expected = './proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
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
    var expected = './proto';
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 0' );

    test.close( 'singleUnwrapping : 1' );
    test.open( 'singleUnwrapping : 0' );

    test.open( 'mapValsUnwrapping : 1' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
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
    var expected = [ [ './proto' ] ];
    test.identical( resolved, expected );
    test.close( 'mapValsUnwrapping : 1' );
    test.open( 'mapValsUnwrapping : 0' );
    test.case = 'submodule::*/path::proto*=1';
    var resolved = module.openedModule.resolve
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
      'Submodule' : { 'proto' : './proto' }
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

    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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
    var resolved = module.openedModule.resolve
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

    debugger;
    return null;
  })

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();
    return arg;
  });

  return ready.split();
}

pathsResolveOutFileOfExports.timeOut = 130000;

//

function pathsResolveComposite( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'composite-path' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, '.' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  function pin( filePath )
  {
    return path.s.join( routinePath, 'in', filePath );
  }

  function pout( filePath )
  {
    return path.s.join( routinePath, 'out', filePath );
  }

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  var module = will.moduleMake({ willfilesPath : modulePath });

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.case = 'path::protoDir1';
    var resolved = module.openedModule.resolve( 'path::protoDir1' )
    var expected = pin( 'proto/dir' );
    test.identical( resolved, expected );

    test.case = 'path::protoDir2';
    var resolved = module.openedModule.resolve( 'path::protoDir2' )
    var expected = pin( 'protodir' );
    test.identical( resolved, expected );

    test.case = 'path::protoDir3';
    var resolved = module.openedModule.resolve( 'path::protoDir3' )
    var expected = pin( 'prefix/proto/dir/dir2' );
    test.identical( resolved, expected );

    test.case = 'path::protoDir4';
    var resolved = module.openedModule.resolve( 'path::protoDir4' )
    var expected = pin( '../prefix/aprotobdirc/dir2' );
    test.identical( resolved, expected );

    test.case = 'path::protoDir4b';
    var resolved = module.openedModule.resolve( 'path::protoDir4b' )
    var expected = pin( '../prefix/aprotobdirc/dir2/proto' );
    test.identical( resolved, expected );

    return null;
  });

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();
    return arg;
  });

  return ready.split();
  // return module.openedModule.ready.split();
}

pathsResolveComposite.timeOut = 130000;

//

function pathsResolveComposite2( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'import-auto' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'module/Proto' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  function pin( filePath )
  {
    return path.s.join( routinePath, 'in', filePath );
  }

  function pout( filePath )
  {
    return path.s.join( routinePath, 'out', filePath );
  }

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  var module = will.moduleMake({ willfilesPath : modulePath });

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.case = 'path::export';
    debugger;
    var resolved = module.openedModule.resolve({ selector : 'path::export', pathResolving : 0 })
    var expected = path.join( routinePath, '.module/Proto/proto' );
    test.identical( resolved, expected );
    debugger;

    return null;
  });

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();
    return arg;
  });

  return ready.split();
  // return module.openedModule.ready.split();
}

pathsResolveComposite2.timeOut = 130000;

//

function pathsResolveArray( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'make' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, 'v1' );
  let will = new _.Will;
  let path = _.fileProvider.path;

  function pin( filePath )
  {
    return path.s.join( routinePath, '', filePath );
  }

  function pout( filePath )
  {
    return path.s.join( routinePath, 'out', filePath );
  }

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

  var module = will.moduleMake({ willfilesPath : modulePath });

  /* - */

  module.openedModule.ready.thenKeep( ( arg ) =>
  {

    test.case = 'path::produced.js';
    var got = module.openedModule.pathResolve
    ({
      selector : 'path::produced.js',
      pathResolving : 'in',
      missingAction : 'undefine',
    });
    var expected = pin( 'file/Produced.js2' );
    test.identical( got, expected );

    test.case = 'path::temp';
    var got = module.openedModule.pathResolve
    ({
      selector : 'path::temp',
      pathResolving : 'in',
      missingAction : 'undefine',
    });
    var expected = pin( [ 'file/Produced.txt2', 'file/Produced.js2' ] );
    test.identical( got, expected );

    return null;
  });

  /* - */

  let ready = module.openedModule.ready.finallyKeep( ( err, arg ) =>
  {
    if( err )
    throw err;
    test.is( err === undefined );
    module.finit();
    return arg;
  });

  return ready.split();
  // return module.openedModule.ready.split();
}

//

function submodulesResolve( test )
{
  let self = this;
  let originalRepoPath = _.path.join( self.assetDirPath, 'repo' );
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-local-repos' );
  let repoPath = _.path.join( self.tempDir, 'repo' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, '.' );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let will = new _.Will;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesDelete( repoPath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesReflect({ reflectMap : { [ originalRepoPath ] : repoPath } });
  _.fileProvider.filesDelete( outPath );

  var module = will.moduleMake({ willfilesPath : modulePath });

  /* */

  return module.openedModule.ready.split()
  .then( () =>
  {
    test.open( 'not downloaded' );

    test.case = 'trivial';
    var submodule = module.openedModule.submodulesResolve({ selector : 'Tools' });
    test.is( submodule instanceof will.Submodule );
    test.is( !submodule.isDownloaded );
    test.is( !!submodule.oModule );
    test.identical( submodule.name, 'Tools' );
    test.identical( submodule.oModule.openedModule, null );
    test.identical( submodule.oModule.willfilesPath, _.uri.s.join( routinePath, '.module/Tools/out/wTools.out.will' ) );
    test.identical( submodule.oModule.dirPath, _.uri.s.join( routinePath, '.module/Tools/out' ) );
    test.identical( submodule.oModule.localPath, _.uri.join( routinePath, '.module/Tools' ) );
    test.identical( submodule.oModule.remotePath, _.uri.join( repoPath, 'git://Tools?out=out/wTools.out.will#master' ) );

    test.close( 'not downloaded' );
    return null;
  })

  /* */

  .then( () =>
  {
    return module.openedModule.submodulesDownload();
  })

  .then( () =>
  {
    test.open( 'downloaded' );

    test.case = 'trivial';
    var submodule = module.openedModule.submodulesResolve({ selector : 'Tools' });
    test.is( submodule instanceof will.Submodule );
    test.is( submodule.isDownloaded );
    test.is( !!submodule.oModule );
    test.identical( submodule.name, 'Tools' );

    // test.identical( submodule.oModule.name, 'Tools' );
    // test.identical( submodule.oModule.willfilesPath, _.uri.s.join( routinePath, '.module/Tools/out/wTools.out.will.yml' ) );
    // test.identical( submodule.oModule.dirPath, _.uri.join( routinePath, '.module/Tools/out' ) );
    // test.identical( submodule.oModule.localPath, _.uri.join( routinePath, '.module/Tools' ) );
    // test.identical( submodule.oModule.remotePath, _.uri.join( repoPath, 'git://Tools?out=out/wTools.out.will#master' ) );
    // test.identical( submodule.oModule.currentRemotePath, _.uri.join( repoPath, 'git://Tools?out=out/wTools.out.will#master' ) );

    test.identical( submodule.oModule.name, 'Tools' );
    test.identical( submodule.oModule.willfilesPath, _.uri.s.join( routinePath, '.module/Tools/out/wTools.out.will.yml' ) );
    test.identical( submodule.oModule.dirPath, _.uri.join( routinePath, '.module/Tools/out' ) );
    test.identical( submodule.oModule.localPath, _.uri.join( routinePath, '.module/Tools' ) );
    test.identical( submodule.oModule.remotePath, _.uri.join( repoPath, 'git://Tools?out=out/wTools.out.will#master' ) );

    test.identical( submodule.oModule.openedModule.name, 'Tools' );
    test.identical( submodule.oModule.openedModule.resourcesFormed, 9 );
    test.identical( submodule.oModule.openedModule.submodulesFormed, 9 );
    test.identical( submodule.oModule.openedModule.willfilesPath, _.uri.s.join( routinePath, '.module/Tools/out/wTools.out.will.yml' ) );
    test.identical( submodule.oModule.openedModule.dirPath, _.uri.join( routinePath, '.module/Tools/out' ) );
    test.identical( submodule.oModule.openedModule.localPath, _.uri.join( routinePath, '.module/Tools' ) );
    test.identical( submodule.oModule.openedModule.remotePath, _.uri.join( repoPath, 'git://Tools?out=out/wTools.out.will#master' ) );
    test.identical( submodule.oModule.openedModule.currentRemotePath, _.uri.join( repoPath, 'git://Tools?out=out/wTools.out.will#master' ) );

    test.case = 'mask, single module';
    var submodule = module.openedModule.submodulesResolve({ selector : 'T*' });
    test.is( submodule instanceof will.Submodule );
    test.identical( submodule.name, 'Tools' );

    test.case = 'mask, two modules';
    var submodules = module.openedModule.submodulesResolve({ selector : '*ls' });
    test.identical( submodules.length, 2 );
    test.is( submodules[ 0 ] instanceof will.Submodule );
    test.identical( submodules[ 0 ].name, 'Tools' );
    test.is( submodules[ 1 ] instanceof will.Submodule );
    test.identical( submodules[ 1 ].name, 'PathFundamentals' );

    test.close( 'downloaded' );
    return null;
  })

}

submodulesResolve.timeOut = 500000;

//

function submodulesDeleteAndDownload( test )
{
  let self = this;
  let originalRepoPath = _.path.join( self.assetDirPath, 'repo' );
  let originalDirPath = _.path.join( self.assetDirPath, 'submodules-del-download' );
  let repoPath = _.path.join( self.tempDir, 'repo' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let modulePath = _.path.join( routinePath, '.' );
  let submodulesPath = _.path.join( routinePath, '.module' );
  let outPath = _.path.join( routinePath, 'out' );
  let will = new _.Will;

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesDelete( repoPath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  _.fileProvider.filesReflect({ reflectMap : { [ originalRepoPath ] : repoPath } });
  _.fileProvider.filesDelete( outPath );

  var module = will.moduleMake({ willfilesPath : modulePath });

  /* */

  return module.openedModule.ready.split()
  .then( () =>
  {

    let builds = module.openedModule.buildsResolve({ name : 'build' });
    test.identical( builds.length, 1 );

    let build = builds[ 0 ];
    let con = build.perform();

    con.then( ( arg ) =>
    {
      var files = self.find( submodulesPath );
      test.is( _.arrayHas( files, './Tools' ) );
      test.is( _.arrayHas( files, './PathFundamentals' ) );
      test.gt( files.length, 280 );
      return arg;
    })

    con.then( () => build.perform() )

    con.then( ( arg ) =>
    {
      var files = self.find( submodulesPath );
      test.is( _.arrayHas( files, './Tools' ) );
      test.is( _.arrayHas( files, './PathFundamentals' ) );
      test.gt( files.length, 280 );
      return arg;
    })

    con.finally( ( err, arg ) =>
    {

      test.identical( will.moduleArray.length, 3 );
      test.identical( _.mapKeys( will.moduleWithIdMap ).length, 3 );
      test.identical( _.mapKeys( will.moduleWithPathMap ).length, 3 );
      test.identical( will.openerModuleArray.length, 3 );
      test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, 3 );
      test.identical( will.willfileArray.length, 3 );
      test.identical( _.mapKeys( will.willfileWithPathMap ).length, 3 );

      debugger;
      module.finit();
      debugger;

      test.identical( will.moduleArray.length, 0 );
      test.identical( _.mapKeys( will.moduleWithIdMap ).length, 0 );
      test.identical( _.mapKeys( will.moduleWithPathMap ).length, 0 );
      test.identical( will.openerModuleArray.length, 0 );
      test.identical( _.mapKeys( will.openerModuleWithIdMap ).length, 0 );
      test.identical( will.willfileArray.length, 0 );
      test.identical( _.mapKeys( will.willfileWithPathMap ).length, 0 );

      if( err )
      throw err;
      return arg;
    })

    return con;
  })

  /* */

}

submodulesDeleteAndDownload.timeOut = 500000;

// --
// define class
// --

var Self =
{

  name : 'Tools/atop/WillInternals',
  silencing : 1,

  onSuiteBegin : onSuiteBegin,
  onSuiteEnd : onSuiteEnd,
  routineTimeOut : 60000,

  context :
  {
    tempDir : null,
    assetDirPath : null,
  },

  tests :
  {

    buildSimple,
    makeNamed,
    makeAnon,
    makeOutNamed,
    clone,

    reflectorResolve,

    superResolve,
    buildsResolve,
    pathsResolve,
    pathsResolveImportIn,
    pathsResolveOfSubmodules,
    pathsResolveOutFileOfExports,
    pathsResolveComposite,
    pathsResolveComposite2,
    pathsResolveArray,

    submodulesResolve,
    submodulesDeleteAndDownload,

  }

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
