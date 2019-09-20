( function _StateStorage_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../amixin/aStateStorage.s' );

}

var _ = _global_.wTools;

// --
// context
// --

function sampleClassMake( o )
{

  _.routineOptions( sampleClassMake, arguments );

  if( !o.fileProvider )
  {
    let filesTree = { dir1 : { dir2 : { 'storage' : '{ random : 0.6397020320139724 }', dir3 : {} } } }
    o.fileProvider = new _.FileProvider.Extract({ filesTree : filesTree });
  }

  function SampleClass( o )
  {
    return _.workpiece.construct( SampleClass, this, arguments );
  }

  function init( o )
  {
    _.workpiece.initFields( this );
    Object.preventExtensions( this );
    if( o )
    _.mapExtend( this, o );
    if( !o || !o.fileProvider )
    this.fileProvider.filesTree = _.cloneJust( this.fileProvider.filesTree );
  }

  let Associates =
  {
    storageFileName :  o.storageFileName,
    fileProvider :  _.define.own( o.fileProvider ),
  }

  let Extend =
  {
    init : init,
    Composes : _.mapExtend( null, o.fieldsMap || {}, o.storeMap || {} ),
    Associates : Associates,
  }

  if( o.storageIs )
  Extend.storageIs = o.storageIs;
  if( o.storageLoaded )
  Extend.storageLoaded = o.storageLoaded;
  if( o.storageToSave )
  Extend.storageToSave = o.storageToSave;

  _.classDeclare
  ({
    cls : SampleClass,
    extend : Extend,
  });

  _.StateStorage.mixin( SampleClass );

  return SampleClass;
}

sampleClassMake.defaults =
{
  storageFileName : null,
  storageIs : null,
  storageLoaded : null,
  storageToSave : null,
  storeMap : null,
  fieldsMap : null,
  fileProvider : null,
}

// --
// tests
// --

function withStorageFilePath( test )
{
  let context = this;

  function storageLoaded( o )
  {
    let self = this;
    let result = _.StateStorage.prototype.storageLoaded.call( self, o );
    self.random = o.storage.random;
    return result;
  }

  function storageToSave( o )
  {
    let self = this;
    let storage = { random : self.random };
    return storage;
  }

  let storeMap =
  {
    random : null,
  }

  let fieldsMap =
  {
    storageFilePath :  '/dir1/dir2/storage',
  }

  var SampleClass = context.sampleClassMake
  ({
    storageFileName : 'storage',
    storageToSave : storageToSave,
    storageLoaded : storageLoaded,
    fieldsMap : fieldsMap,
    storeMap : storeMap,
  });

  /* */

  let sample = new SampleClass();
  test.identical( sample.random, null );

  /* */

  test.case = 'defined storageFilePath cd:/';

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), '/dir1/dir2/storage' );
  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/dir1/dir2/storage' );
  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, '/dir1/dir2/storage' );

  test.description = 'storageLoad';
  sample.storageLoad();
  var got = sample.fileProvider.fileReadJs( sample.storageFilePathToLoadGet() );
  var expected = sample.storageToSave();
  test.identical( got, expected )

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), '/dir1/dir2/storage' );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/dir1/dir2/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, '/dir1/dir2/storage' );

  test.description = 'storageSave';
  sample.random = Math.random();
  sample.storageSave();
  var got = sample.fileProvider.fileReadJs( sample.storageFilePath );
  var expected = { random : sample.random };
  test.identical( got, expected )

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), '/dir1/dir2/storage' );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/dir1/dir2/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, '/dir1/dir2/storage' );

  /* */

  test.case = 'storageFilePath:null cd:/';

  sample.storageFilePath = null;
  sample.random = undefined;

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), null );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, null );

  test.description = 'storageLoad';
  test.identical( sample.storageLoad(), false )

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), null );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, null );

  test.description = 'storageSave';
  sample.random = Math.random();
  sample.storageSave();
  var got = sample.fileProvider.fileReadJs( sample.storageFilePath );
  var expected = sample.storageToSave();
  test.identical( got, expected )

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), '/storage' );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, '/storage' );

  /* */

  test.case = 'storageFilePath:null cd:/dir1/dir2/dir3';

  sample.storageFilePath = null;
  sample.random = undefined;
  sample.fileProvider.path.current( '/dir1/dir2/dir3' );

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), '/dir1/dir2/storage' );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/dir1/dir2/dir3/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, null );

  test.description = 'storageLoad';
  sample.storageLoad();
  var got = sample.fileProvider.fileReadJs( sample.storageFilePathToLoadGet() );
  var expected = sample.storageToSave();
  test.identical( got, expected );

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), '/dir1/dir2/storage' );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/dir1/dir2/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, '/dir1/dir2/storage' );

  test.description = 'storageSave';
  sample.random = Math.random();
  sample.storageSave();
  var got = sample.fileProvider.fileReadJs( sample.storageFilePath );
  var expected = { random : sample.random };
  test.identical( got, expected )

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), '/dir1/dir2/storage' );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/dir1/dir2/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, '/dir1/dir2/storage' );

  test.description = 'storageSave';
  sample.storageFilePath = null;
  sample.random = Math.random();
  sample.storageSave();
  var got = sample.fileProvider.fileReadJs( sample.storageFilePath );
  var expected = { random : sample.random };
  test.identical( got, expected )

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), '/dir1/dir2/dir3/storage' );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/dir1/dir2/dir3/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, '/dir1/dir2/dir3/storage' );

}

//

function withoutStorageFilePath( test )
{
  let context = this;

  function storageLoaded( o )
  {
    let self = this;
    let result = _.StateStorage.prototype.storageLoaded.call( self, o );
    self.random = o.storage.random;
    return result;
  }

  function storageToSave( o )
  {
    let self = this;
    let storage = { random : self.random };
    return storage;
  }

  let storeMap =
  {
    random : null,
  }

  var fieldsMap =
  {
  }

  var SampleClass = context.sampleClassMake
  ({
    storageFileName : 'storage',
    storageToSave : storageToSave,
    storageLoaded : storageLoaded,
    storeMap : storeMap,
    fieldsMap : fieldsMap,
  });

  /* */

  let sample = new SampleClass();
  sample.fileProvider.path.current( '/dir1/dir2/dir3' );
  test.identical( sample.random, null );

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), '/dir1/dir2/storage' );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/dir1/dir2/dir3/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, undefined );

  test.description = 'storageLoad';
  sample.storageLoad();
  var expected = sample.fileProvider.fileReadJs( sample.storageFilePathToLoadGet() );
  test.identical( sample.storageToSave(), expected );
  sample.random = Math.random();

  test.description = 'storageSave';
  sample.storageSave();
  var got = sample.fileProvider.fileReadJs( sample.storageFilePathToLoadGet() );
  var expected = { random : sample.random };
  test.identical( got, expected )

  test.description = 'storageFilePathToLoadGet';
  test.identical( sample.storageFilePathToLoadGet(), '/dir1/dir2/dir3/storage' );

  test.description = 'storageFilePathToSaveGet';
  test.identical( sample.storageFilePathToSaveGet(), '/dir1/dir2/dir3/storage' );

  test.description = 'storageFilePath';
  test.identical( sample.storageFilePath, undefined );

}

//

function storageSave( test )
{
  var self = this;

  function storageToSave( o )
  {
    let self = this;
    let storage = _.mapExtend( null, _.mapOnly( self, StoreMap ) );
    return storage;
  }

  function storageLoaded( o )
  {
    let self = this;
    let result = _.StateStorage.prototype.storageLoaded.call( self, o );
    self.ino = o.storage.ino;
    return o.storage;
  }

  let StoreMap =
  {
    ino : null,
  }

  let FieldsMap =
  {
    storageFilePath : null,
    storageDirPath : null,
  }

  var sampleClass = self.sampleClassMake
  ({
    storageFileName : 'storage',
    storageToSave : storageToSave,
    storageLoaded : storageLoaded,
    fileProvider : new _.FileProvider.Extract(),
    fieldsMap : FieldsMap,
    storeMap : StoreMap
  });

  var fields =
  {
    'ino' : 3659174697525816,
  }

  /* */

  test.case = 'storageFilePath is a root directory'
  var classInstance = new sampleClass( fields );
  classInstance.storageSave();
  test.identical( classInstance.storageFilePath, '/storage' )
  var got = classInstance.fileProvider.fileReadJs( classInstance.storageFilePath );
  test.identical( got, fields );

  /* */

  test.case = 'storageFilePath does not exist'
  var classInstance = new sampleClass( _.mapExtend( null, fields, { storageFilePath : '/storageFilePath' } ) );
  classInstance.storageSave();
  test.identical( classInstance.storageFilePath, '/storageFilePath' )
  var got = classInstance.fileProvider.fileReadJs( classInstance.storageFilePath );
  test.identical( got, fields );

  /* */

  test.case = 'storageFilePath is terminal file'
  var classInstance = new sampleClass( _.mapExtend( null, fields, { storageFilePath : '/storageFilePath' } ) );
  classInstance.fileProvider.fileWrite( classInstance.storageFilePath, 'something' )
  classInstance.storageSave();
  test.identical( classInstance.storageFilePath, '/storageFilePath' )
  var got = classInstance.fileProvider.fileReadJs( classInstance.storageFilePath );
  test.identical( got, fields );

  /* */

  test.case = 'storageFilePath is directory'
  var classInstance = new sampleClass( _.mapExtend( null, fields, { storageFilePath : '/storageFilePath' } ) );
  classInstance.fileProvider.filesDelete( classInstance.storageFilePath );
  classInstance.fileProvider.dirMake( classInstance.storageFilePath );
  test.shouldThrowErrorSync( () => classInstance.storageSave() );

  /* */

  test.case = 'storageFilePath is directory'
  var classInstance = new sampleClass( _.mapExtend( null, fields, { storageDirPath : '/storageFilePath' } ) );
  classInstance.fileProvider.filesDelete( classInstance.storageDirPath );
  classInstance.fileProvider.dirMake( classInstance.storageDirPath );
  classInstance.storageSave();
  test.identical( classInstance.storageFilePath, '/storageFilePath/storage' )
  var got = classInstance.fileProvider.fileReadJs( classInstance.storageFilePath );
  test.identical( got, fields );

  /* */

  test.case = 'storageDirPath is array of paths, one of paths does not exist'
  var o2 =
  {
    storageDirPath : [ '/', '/some/dir' ],
    fileProvider : new _.FileProvider.Extract()
  }
  var classInstance = new sampleClass( _.mapExtend( null, fields, o2 ) );
  test.identical( classInstance.storageDirPath, [ '/', '/some/dir' ] );
  test.identical( classInstance.storageFilePath, null );
  test.identical( classInstance.storageFilePathToLoadGet(), null );
  test.identical( classInstance.storageFilePathToSaveGet(), [ '/storage', '/some/dir/storage' ] );
  classInstance.storageSave();
  test.identical( classInstance.storageDirPath, [ '/', '/some/dir' ] );
  test.identical( classInstance.storageFilePath, [ '/storage', '/some/dir/storage' ] );
  test.identical( classInstance.storageFilePathToLoadGet(), [ '/storage', '/some/dir/storage' ] );
  test.identical( classInstance.storageFilePathToSaveGet(), [ '/storage', '/some/dir/storage' ] );
  var storages = classInstance.storageFilePath.map( ( p ) => classInstance.fileProvider.fileReadJs( p ) );
  test.identical( storages, [ fields, fields ] );

  /* */

  test.case = 'storageDirPath is array of paths, one of paths does not exist'
  var o2 =
  {
    storageDirPath : [ '/x', '/y' ],
    storageFilePath : [ '/storage2', '/some/dir/storage2' ],
    fileProvider : new _.FileProvider.Extract()
  }
  var classInstance = new sampleClass( _.mapExtend( null, fields, o2 ) );
  test.identical( classInstance.storageDirPath, [ '/x', '/y' ] );
  test.identical( classInstance.storageFilePath, [ '/storage2', '/some/dir/storage2' ] );
  test.identical( classInstance.storageFilePathToLoadGet(), null );
  test.identical( classInstance.storageFilePathToSaveGet(), [ '/storage2', '/some/dir/storage2' ] );
  classInstance.storageSave();
  test.identical( classInstance.storageDirPath, [ '/', '/some/dir' ] );
  test.identical( classInstance.storageFilePath, [ '/storage2', '/some/dir/storage2' ] );
  test.identical( classInstance.storageFilePathToLoadGet(), [ '/storage2', '/some/dir/storage2' ] );
  test.identical( classInstance.storageFilePathToSaveGet(), [ '/storage2', '/some/dir/storage2' ] );
  var storages = classInstance.storageFilePath.map( ( p ) => classInstance.fileProvider.fileReadJs( p ) );
  test.identical( storages, [ fields, fields ] );

  var o3 =
  {
    storageDirPath : [ '/x', '/y' ],
    storageFilePath : [ '/storage2', '/some/dir/storage2' ],
    fileProvider : o2.fileProvider,
    ino : 13,
  }

  var classInstance = new sampleClass( _.mapExtend( null, fields, o3 ) );
  test.identical( classInstance.storageDirPath, [ '/x', '/y' ] );
  test.identical( classInstance.storageFilePath, [ '/storage2', '/some/dir/storage2' ] );
  test.identical( classInstance.storageFilePathToLoadGet(), [ '/storage2', '/some/dir/storage2' ] );
  test.identical( classInstance.storageFilePathToSaveGet(), [ '/storage2', '/some/dir/storage2' ] );
  test.identical( classInstance.storageToSave(), { ino : 13 } );
  classInstance.storageLoad();
  test.identical( classInstance.storageDirPath, [ '/', '/some/dir' ] );
  test.identical( classInstance.storageFilePath, [ '/storage2', '/some/dir/storage2' ] );
  test.identical( classInstance.storageFilePathToLoadGet(), [ '/storage2', '/some/dir/storage2' ] );
  test.identical( classInstance.storageFilePathToSaveGet(), [ '/storage2', '/some/dir/storage2' ] );
  test.identical( classInstance.storageToSave(), { ino : 3659174697525816 } );
  var storages = classInstance.storageFilePath.map( ( p ) => classInstance.fileProvider.fileReadJs( p ) );
  test.identical( storages, [ fields, fields ] );

  /* */

  test.case = 'set storageFilePath to null'
  var o2 =
  {
    storageFilePath : null,
  }
  var classInstance = new sampleClass( _.mapExtend( null, fields, o2 ) );

  test.identical( classInstance.storageDirPath, null );
  test.identical( classInstance.storageFilePath, null );
  test.identical( classInstance.storageFilePathToLoadGet(), null );
  test.identical( classInstance.storageFilePathToSaveGet(), '/storage' );
  test.identical( classInstance.storageToSave(), { ino : 3659174697525816 } );

  classInstance.storageSave();

  test.identical( classInstance.storageDirPath, '/' );
  test.identical( classInstance.storageFilePath, '/storage' );
  test.identical( classInstance.storageFilePathToLoadGet(), '/storage' );
  test.identical( classInstance.storageFilePathToSaveGet(), '/storage' );
  test.identical( classInstance.storageToSave(), { ino : 3659174697525816 } );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'storageSave does not accept any arguments'
  var classInstance = new sampleClass( _.mapExtend( null, fields ) );
  test.shouldThrowErrorOfAnyKind( () => classInstance.storageSave( { storageFilePath : '/__storage' } ) )

  test.case = 'set paths to null'
  var o2 =
  {
    storageFilePath : null,
    storageFileName : null,
  }
  var classInstance = new sampleClass( _.mapExtend( null, fields, o2 ) );
  test.shouldThrowErrorOfAnyKind( () => classInstance.storageSave() )

  test.case = 'set storageFileName to null'
  var o2 =
  {
    storageFileName : null
  }
  var classInstance = new sampleClass( _.mapExtend( null, fields, o2 ) );
  test.shouldThrowErrorOfAnyKind( () => classInstance.storageSave() )


}

//

function storageLoad( test )
{
  var self = this;

  function storageIs( storage )
  {
    let self = this;
    return _.mapHasExactly( storage, { ino : null } );
  }

  function storageLoaded( o )
  {
    let self = this;
    debugger;
    let result = _.StateStorage.prototype.storageLoaded.call( self, o );
    self.ino = o.storage.ino;
    return o.storage;
  }

  function storageToSave( o )
  {
    let self = this;
    let storage = _.mapOnly( self, storeMap );
    return storage;
  }

  let storeMap =
  {
    ino : null,
  }

  let fieldsMap =
  {
    storageFilePath : null,
  }

  var storeSaved =
  {
    'ino' : 3659174697525816,
  }

  var sampleClass = self.sampleClassMake
  ({
    storageFileName : 'storage',
    storageLoaded : storageLoaded,
    storageToSave : storageToSave,
    storageIs : storageIs,
    fileProvider : new _.FileProvider.Extract(),
    storeMap : storeMap,
    fieldsMap : fieldsMap,
  });

  /* - */

  test.open( 'load storage from existing file' );

  test.case = 'basic';
  var classInstance1 = new sampleClass( storeSaved );
  classInstance1.storageFilePath = '/dir1/dir2/storage';
  var classInstance2 = new sampleClass({ fileProvider : classInstance1.fileProvider });
  classInstance2.storageFilePath = '/dir1/dir2/storage';

  test.identical( classInstance1.storageFilePathToLoadGet(), null );
  test.identical( classInstance1.storageFilePathToSaveGet(), '/dir1/dir2/storage' );
  test.identical( classInstance1.storageFilePath, '/dir1/dir2/storage' );
  test.identical( classInstance2.storageFilePathToLoadGet(), null );
  test.identical( classInstance2.storageFilePathToSaveGet(), '/dir1/dir2/storage' );
  test.identical( classInstance2.storageFilePath, '/dir1/dir2/storage' );

  test.identical( classInstance1.storageToSave(), storeSaved );
  test.identical( classInstance2.storageToSave(), storeMap );
  var got = _.mapOnly( classInstance1, storeMap );
  test.identical( got, storeSaved );
  classInstance1.storageSave();
  test.identical( classInstance1.storageToSave(), classInstance1.fileProvider.fileReadJs( classInstance1.storageFilePathToLoadGet() ) )
  classInstance2.storageLoad();
  test.identical( classInstance1.storageToSave(), storeSaved );
  test.identical( classInstance2.storageToSave(), storeSaved );

  test.identical( classInstance1.storageFilePathToLoadGet(), '/dir1/dir2/storage' );
  test.identical( classInstance1.storageFilePathToSaveGet(), '/dir1/dir2/storage' );
  test.identical( classInstance1.storageFilePath, '/dir1/dir2/storage' );
  test.identical( classInstance2.storageFilePathToLoadGet(), '/dir1/dir2/storage' );
  test.identical( classInstance2.storageFilePathToSaveGet(), '/dir1/dir2/storage' );
  test.identical( classInstance2.storageFilePath, '/dir1/dir2/storage' );

  /* */

  test.case = 'storageFileName:null'
  var classInstance1 = new sampleClass( storeSaved );
  var classInstance2 = new sampleClass({ fileProvider : classInstance1.fileProvider });

  test.identical( classInstance1.storageFilePathToLoadGet(), null );
  test.identical( classInstance1.storageFilePathToSaveGet(), '/storage' );
  test.identical( classInstance1.storageFilePath, null );
  test.identical( classInstance2.storageFilePathToLoadGet(), null );
  test.identical( classInstance2.storageFilePathToSaveGet(), '/storage' );
  test.identical( classInstance2.storageFilePath, null );

  test.identical( classInstance1.storageToSave(), storeSaved );
  test.identical( classInstance2.storageToSave(), storeMap );
  var got = _.mapOnly( classInstance1, storeMap );
  test.identical( got, storeSaved );
  classInstance1.storageSave();
  test.identical( classInstance1.storageToSave(), classInstance1.fileProvider.fileReadJs( classInstance1.storageFilePathToLoadGet() ) )
  classInstance2.storageLoad();
  test.identical( classInstance1.storageToSave(), storeSaved );
  test.identical( classInstance2.storageToSave(), storeSaved );

  test.identical( classInstance1.storageFilePathToLoadGet(), '/storage' );
  test.identical( classInstance1.storageFilePathToSaveGet(), '/storage' );
  test.identical( classInstance1.storageFilePath, '/storage' );
  test.identical( classInstance2.storageFilePathToLoadGet(), '/storage' );
  test.identical( classInstance2.storageFilePathToSaveGet(), '/storage' );
  test.identical( classInstance2.storageFilePath, '/storage' );

  /* */

  test.case = 'load using only storageFilePath, file is a directory'
  var o2 =
  {
    storageFilePath : '/storage'
  }
  var classInstance = new sampleClass( o2 );
  classInstance.fileProvider.filesDelete( o2.storageFilePath );
  classInstance.fileProvider.dirMake( o2.storageFilePath );
  test.shouldThrowErrorOfAnyKind( () => classInstance.storageLoad() );

  /* */

  test.case = 'load using only storageFilePath, file is a regular file'
  var o2 =
  {
    storageFilePath : '/storage'
  }
  var classInstance = new sampleClass( o2 );
  classInstance.fileProvider.filesDelete( o2.storageFilePath );
  classInstance.fileProvider.fileWrite( o2.storageFilePath, o2.storageFilePath );
  test.shouldThrowErrorOfAnyKind( () => classInstance.storageLoad() );

  test.close( 'load storage from existing file' );

  /* - */

  test.open( 'try load not existing storage' );

  var classInstance = new sampleClass( { storageFilePath : '/storageFilePath' } );
  test.identical( classInstance.storageLoad(), false );

  test.case = 'try to provide undefined paths'
  var o2 =
  {
    storageFilePath : null,
    storageFileName : null,
  }
  var classInstance = new sampleClass(  o2 );
  test.shouldThrowErrorOfAnyKind( () => classInstance.storageLoad() )

  test.case = 'try to leave storageFilePath defined'
  var o2 =
  {
    storageFileName : null
  }
  var classInstance = new sampleClass( o2 );
  test.shouldThrowErrorOfAnyKind( () => classInstance.storageLoad() )

  test.close( 'try load not existing storage' );

  if( !Config.debug )
  return;

  test.case = 'storageSave does not accept any arguments'
  var classInstance = new sampleClass();
  test.shouldThrowErrorOfAnyKind( () => classInstance.storageLoad( { storageFilePath : '/__storage' } ) )

}

//

var Self =
{

  name : 'Tools.mid.StateStorage',
  silencing : 1,

  context :
  {
    sampleClassMake : sampleClassMake,
  },

  tests :
  {

    withStorageFilePath : withStorageFilePath,
    withoutStorageFilePath : withoutStorageFilePath,

    storageSave : storageSave,
    storageLoad : storageLoad,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
