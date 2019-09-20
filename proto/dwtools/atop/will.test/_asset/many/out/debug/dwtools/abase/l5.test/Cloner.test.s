( function _Cloner_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( '../l5/Cloner.s' );

  _.include( 'wTesting' );

}
var _global = _global_;
var _ = _global_.wTools;

//

function checker( t )
{

  /* map */

  t.description = 'similar map type, no content';
  var ins1 = Object.create( null );
  var ins2 = {};
  t.is( _.entityIdentical( ins1,ins2 ) );

  t.description = 'similar map type, same content';
  var ins1 = Object.create( null );
  ins1.a = 1;
  var ins2 = {};
  ins2.a = 1;
  t.is( _.entityIdentical( ins1,ins2 ) );

  /* array */

  t.description = 'different buffer type, same content';
  var ins1 = new Float32Array([ 1,2,3 ]);
  var ins2 = new Float64Array([ 1,2,3 ]);
  t.is( !_.entityIdentical( ins1,ins2 ) );

  t.description = 'different buffer type, same content';
  var ins1 = new Float32Array([ 1,2,3 ]);
  var ins2 = [ 1,2,3 ];
  t.is( !_.entityIdentical( ins1,ins2 ) );

  t.description = 'same buffer type, different content';
  var ins1 = new Float32Array([ 1,2,3 ]);
  var ins2 = new Float32Array([ 3,4,5 ]);
  t.is( !_.entityIdentical( ins1,ins2 ) );

  t.description = 'different buffer type, same content';
  var ins1 = new Float32Array([ 1,2,3 ]);
  var ins2 = new Float32Array([ 1,2,3 ]);
  t.is( _.entityIdentical( ins1,ins2 ) );

  t.description = 'same array type, same content';
  var ins1 = [ 1,2,3 ];
  var ins2 = [ 1,2,3 ];
  t.is( _.entityIdentical( ins1,ins2 ) );

  t.description = 'BufferView, same content';
  var ins1 = new DataView( new Float32Array([ 1,2,3 ]).buffer );
  var ins2 = new DataView( new Float32Array([ 1,2,3 ]).buffer );
  t.is( _.entityIdentical( ins1,ins2 ) );

  t.description = 'BufferView, different content';
  var ins1 = new DataView( new Float32Array([ 1,2,3 ]).buffer );
  var ins2 = new DataView( new Float32Array([ 3,2,1 ]).buffer );
  t.is( !_.entityIdentical( ins1,ins2 ) );

  t.description = 'BufferRaw, same content';
  var ins1 = new DataView( new Float32Array([ 1,2,3 ]).buffer );
  var ins2 = new DataView( new Float32Array([ 1,2,3 ]).buffer );
  t.is( _.entityIdentical( ins1,ins2 ) );

  t.description = 'BufferRaw, different content';
  var ins1 = new DataView( new Float32Array([ 1,2,3 ]).buffer );
  var ins2 = new DataView( new Float32Array([ 3,2,1 ]).buffer );
  t.is( !_.entityIdentical( ins1,ins2 ) );

}

//

function trivial( t )
{

  // t.description = 'cloning String';
  // var src = 'abc';
  // var dst = _.cloneJust( src );
  // t.identical( dst,src );
  //
  // t.description = 'cloning Number';
  // var src = 13;
  // var dst = _.cloneJust( src );
  // t.identical( dst,src );

  t.description = 'cloning ArrayBuffer';
  var src = new ArrayBuffer( 10 );
  debugger;
  var dst = _.cloneJust( src );
  debugger;
  t.identical( dst,src );
  debugger;
  t.is( dst !== src );

  debugger;
  t.description = 'cloning ArrayBuffer';
  var src = new Float32Array([ 1,2,3,4 ]).buffer;
  var dst = _.cloneJust( src );
  t.identical( dst,src );
  t.is( dst !== src );
  debugger;

  t.description = 'cloning TypedBuffer';
  var src = new Float32Array( 10 );
  var dst = _.cloneJust( src );
  t.identical( dst,src );
  t.is( dst instanceof Float32Array );
  t.is( dst !== src );

  t.description = 'cloning DataView';
  var src = new DataView( new ArrayBuffer( 10 ) );
  var dst = _.cloneJust( src );
  t.identical( dst,src );
  t.is( dst !== src );

  t.description = 'cloning Array';
  var src = new Array( 10 );
  var dst = _.cloneJust( src );
  t.identical( dst,src );

  t.description = 'cloning Array';
  var src = [ 1,2,3 ];
  var dst = _.cloneJust( src );
  t.identical( dst,src );
  t.is( dst !== src );

  t.description = 'cloning Map';
  var src = Object.create( null );
  var dst = _.cloneJust( src );
  t.identical( dst,src );
  t.is( dst !== src );

  t.description = 'cloning Map';
  var src = {};
  var dst = _.cloneJust( src );
  t.identical( dst,src );
  t.is( dst !== src );

  t.description = 'cloning Map';
  var src = { a : 1, c : 3 };
  var dst = _.cloneJust( src );
  t.identical( dst,src );
  t.is( dst !== src );

  debugger;
}

//

var Self =
{

  name : 'Tools.base.l5.Cloner',
  silencing : 1,

  tests :
  {

    checker,
    trivial,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
