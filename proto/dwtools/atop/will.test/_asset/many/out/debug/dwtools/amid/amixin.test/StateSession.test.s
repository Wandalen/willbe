( function _StateSession_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../amixin/StateSession.s' );

}

var _ = wTools;

//

function trivial( test )
{
  let filesTree = { 'storage' : "{ random : 0.6397020320139724 }" }
  let fileProvider = new _.FileProvider.Extract({ filesTree : filesTree });

  function SomeClass( o )
  {
    return _.workpiece.construct( SomeClass, this, arguments );
  }

  function init( o )
  {
    let sample = this;
    _.workpiece.initFields( sample );
  }

  function storageLoaded( op )
  {
    let self = this;
    let result = _.StateStorage.prototype.storageLoaded.call( self, op );
    self.random = op.storage.random;
    return result;
  }

  function storageToSave( op )
  {
    let self = this;

    let storage = { random : self.random };

    return storage;
  }

  let Associates =
  {
    opened : 0,
    storageFileName :  'storage',
    storageFilePath :  '/storage',
    fileProvider :  _.define.own( fileProvider ),
  }

  let Extend =
  {
    init : init,
    storageLoaded : storageLoaded,
    storageToSave : storageToSave,
    Associates : Associates,
  }

  _.classDeclare
  ({
    cls : SomeClass,
    extend : Extend,
  });

  _.StateStorage.mixin( SomeClass );
  _.StateSession.mixin( SomeClass );

  /* */

  let sample = new SomeClass();
  let storageFilePath = sample.storageFilePath;
  test.identical( sample.random, undefined );
  sample.sessionOpen();
  var expected = sample.fileProvider.fileReadJs( storageFilePath );
  test.identical( sample.random, expected.random );
  sample.random = Math.random();
  sample.sessionCloseSaving();
  var got = sample.fileProvider.fileReadJs( storageFilePath );
  var expected = { random : sample.random };
  test.identical( got, expected )
  // console.log( 'sample.random', sample.storageFilePathToLoadGet(), sample.random );

  /* */

  test.identical( 1,1 );

}

//

var Self =
{

  name : 'Tools.mid.StateSession',
  silencing : 1,

  tests :
  {
    trivial : trivial,
  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
