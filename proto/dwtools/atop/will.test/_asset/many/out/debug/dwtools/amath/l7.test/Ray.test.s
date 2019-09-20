( function _Ray_test_s_( ) {

'use strict';

// return;

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );
  _.include( 'wMathSpace' );

  require( '../l8/Concepts.s' );

}

//

var _ = _global_.wTools.withArray.Float32;
var Space = _.Space;
var vector = _.vector;
var vec = _.vector.fromArray;
var avector = _.avector;
var sqrt = _.sqrt;
var Parent = wTester;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --

function make( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotRay = _.ray.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotRay = _.ray.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotRay = _.ray.make( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotRay = _.ray.make( srcDim );
  var expected = [ 0, 1, 2, 3 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotRay = _.ray.make( srcDim );
  var expected = [ 0,1,2,3 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.make( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.make( 'ray' ));
}

//

function makeZero( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotRay = _.ray.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotRay = _.ray.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotRay = _.ray.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotRay = _.ray.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotRay = _.ray.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.makeZero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.makeZero( 'ray' ));

}

//

function makeNil( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotRay = _.ray.makeNil( srcDim );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotRay = _.ray.makeNil( srcDim );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotRay = _.ray.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotRay = _.ray.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotRay = _.ray.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.makeNil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.makeNil( 'ray' ));
}

//

function zero( test )
{
  test.case = 'srcRay undefined'; /* */

  var srcRay = undefined;
  var gotRay = _.ray.zero( srcRay );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay null'; /* */

  var srcRay = null;
  var gotRay = _.ray.zero( srcRay );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay 2'; /* */

  var srcRay = 2;
  var gotRay = _.ray.zero( srcRay );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay array'; /* */

  var srcRay = [ 0, 1, 2, 3 ];
  var gotRay = _.ray.zero( srcRay );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotRay, expected );
  test.is( gotRay === srcRay );

  test.case = 'srcRay vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotRay = _.ray.zero( srcRay );
  var expected =  _.vector.fromArray( [ 0, 0, 0, 0 ] );
  test.identical( gotRay, expected );
  test.is( gotRay === srcRay );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.zero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.zero( 'ray' ));

}

//

function nil( test )
{
  test.case = 'srcRay undefined'; /* */

  var srcRay = undefined;
  var gotRay = _.ray.nil( srcRay );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay null'; /* */

  var srcRay = null;
  var gotRay = _.ray.nil( srcRay );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay 2'; /* */

  var srcRay = 2;
  var gotRay = _.ray.nil( srcRay );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay !== srcRay );

  test.case = 'srcRay array'; /* */

  var srcRay = [ 0, 1, 2, 3 ];
  var gotRay = _.ray.nil( srcRay );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotRay, expected );
  test.is( gotRay === srcRay );

  test.case = 'srcRay vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotRay = _.ray.nil( srcRay );
  var expected = _.vector.fromArray( [ Infinity, Infinity, - Infinity, - Infinity ] );
  test.identical( gotRay, expected );
  test.is( gotRay === srcRay );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.nil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.nil( 'ray' ));
}

//

function from( test )
{
  test.case = 'Same instance returned - array'; /* */

  var srcRay = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0, 2, 2 ];

  var gotRay = _.ray.from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay === gotRay );

  test.case = 'Different instance returned - vector -> array'; /* */

  var srcRay = _.vector.fromArray( [ 0, 0, 2, 2 ] );
  var expected = _.vector.fromArray( [ 0, 0, 2, 2 ] );

  var gotRay = _.ray.from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay === gotRay );

  test.case = 'Same instance returned - empty array'; /* */

  var srcRay = [];
  var expected =  [];

  var gotRay = _.ray.from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay === gotRay );

  test.case = 'Different instance returned - null -> array'; /* */

  var srcRay = null;
  var expected =  [ 0, 0, 0, 0, 0, 0 ];

  var gotRay = _.ray.from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay !== gotRay );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.from( ));
  test.shouldThrowErrorSync( () => _.ray.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.ray.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray.from( 'ray' ));
  test.shouldThrowErrorSync( () => _.ray.from( NaN ));
  test.shouldThrowErrorSync( () => _.ray.from( undefined ));
}

//

function _from( test )
{
  test.case = 'Same instance returned - vector'; /* */

  var srcRay = [ 0, 0, 2, 2 ];
  var expected = _.vector.from( [ 0, 0, 2, 2 ] );

  var gotRay = _.ray._from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay !== gotRay );

  test.case = 'Different instance returned - vector -> vector'; /* */

  var srcRay = _.vector.from( [ 0, 0, 2, 2 ] );
  var expected = _.vector.from( [ 0, 0, 2, 2 ] );

  var gotRay = _.ray._from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay === gotRay );

  test.case = 'Same instance returned - empty vector'; /* */

  var srcRay = [];
  var expected =  _.vector.from( [] );

  var gotRay = _.ray._from( srcRay );
  test.identical( gotRay, expected );
  test.is( srcRay !== gotRay );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray._from( ));
  test.shouldThrowErrorSync( () => _.ray._from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.ray._from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.ray._from( 'ray' ));
  test.shouldThrowErrorSync( () => _.ray._from( NaN ));
  test.shouldThrowErrorSync( () => _.ray._from( null ));
  test.shouldThrowErrorSync( () => _.ray._from( undefined ));
}

//

function fromPair( test )
{
  test.case = 'Pair stay unchanged'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 2, 4 ] ];
  var expected = _.vector.from( [ 0, 1, 2, 0, 1, 2 ] );

  var gotRay = _.ray.fromPair( pair );
  test.identical( gotRay, expected );

  var oldPair = [ [ 0, 1, 2 ], [ 0, 2, 4 ] ];
  test.identical( pair, oldPair );

  test.case = 'Ray starts in origin'; /* */

  var pair = [ [ 0, 0, 0 ], [ 0, 1, 2 ] ];
  var expected = _.vector.from( [ 0, 0, 0, 0, 1, 2 ] );

  var gotRay = _.ray.fromPair( pair );
  test.identical( gotRay, expected );

  test.case = 'Ray is point'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 1, 2 ] ];
  var expected =  _.vector.from( [ 0, 1, 2, 0, 0, 0 ] );

  var gotRay = _.ray.fromPair( pair );
  test.identical( gotRay, expected );

  test.case = 'Ray of 1 dimension'; /* */

  var pair = [ [ 3 ], [ 4 ] ];
  var expected =  _.vector.from( [ 3, 1 ] );

  var gotRay = _.ray.fromPair( pair );
  test.identical( gotRay, expected );

  test.case = 'Ray goes up in y and down in z'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 3, 1 ] ];
  var expected =  _.vector.from( [ 0, 1, 2, 0, 2, -1 ] );

  var gotRay = _.ray.fromPair( pair );
  test.identical( gotRay, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.fromPair( ));
  test.shouldThrowErrorSync( () => _.ray.fromPair( null ));
  test.shouldThrowErrorSync( () => _.ray.fromPair( [ 2, 4 ], [ 3, 6 ] ));
  test.shouldThrowErrorSync( () => _.ray.fromPair( [ 2, 4 ], [ 3, 6, 2 ] ));
  test.shouldThrowErrorSync( () => _.ray.fromPair( [ [ 2, 4 ], [ 3, 6 ], [ 3, 6 ] ] ));
  test.shouldThrowErrorSync( () => _.ray.fromPair( undefined ));

}

//

function is( test )
{
  debugger;
  test.case = 'array'; /* */

  test.is( _.ray.is( [] ) );
  test.is( _.ray.is([ 0, 0 ]) );
  test.is( _.ray.is([ 1, 2, 3, 4 ]) );
  test.is( _.ray.is([ 0, 0, 0, 0, 0, 0 ]) );

  test.case = 'vector'; /* */

  test.is( _.ray.is( _.vector.fromArray([]) ) );
  test.is( _.ray.is( _.vector.fromArray([ 0, 0 ]) ) );
  test.is( _.ray.is( _.vector.fromArray([ 1, 2, 3, 4 ]) ) );
  test.is( _.ray.is( _.vector.fromArray([ 0, 0, 0, 0, 0, 0 ]) ) );

  test.case = 'not ray'; /* */

  test.is( !_.ray.is([ 0 ]) );
  test.is( !_.ray.is([ 0, 0, 0 ]) );

  test.is( !_.ray.is( _.vector.fromArray([ 0 ]) ) );
  test.is( !_.ray.is( _.vector.fromArray([ 0, 0, 0 ]) ) );

  test.is( !_.ray.is( 'abc' ) );
  test.is( !_.ray.is( { origin : [ 0, 0, 0 ], direction : [ 1, 1, 1 ] } ) );
  test.is( !_.ray.is( function( a, b, c ){} ) );

  test.is( !_.ray.is( null ) );
  test.is( !_.ray.is( undefined ) );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.is( ));
  test.shouldThrowErrorSync( () => _.ray.is( [ 0, 0 ], [ 1, 1 ] ));

}

//

function dimGet( test )
{
  test.case = 'srcRay 1D - array'; /* */

  var srcRay = [ 0, 1 ];
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  test.case = 'srcRay 1D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1 ] );
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  test.case = 'srcRay 2D - array'; /* */

  var srcRay = [ 0, 1, 2, 3 ];
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  test.case = 'srcRay 2D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  test.case = 'srcRay 3D - array'; /* */

  var srcRay = [ 0, 1, 2, 3, 4, 5 ];
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  test.case = 'srcRay 3D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDim = _.ray.dimGet( srcRay );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcRay );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.dimGet( ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( 'ray' ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( null ) );
  test.shouldThrowErrorSync( () => _.ray.dimGet( undefined ) );

}

//

function originGet( test )
{
  test.case = 'Source ray remains unchanged'; /* */

  var srcRay = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var gotOrigin = _.ray.originGet( srcRay );
  test.identical( gotOrigin, expected );

  var oldSrcRay = [ 0, 0, 1, 1 ];
  test.equivalent( srcRay, oldSrcRay );

  test.case = 'srcRay 1D - array'; /* */

  var srcRay = [ 0, 1 ];
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  test.case = 'srcRay 1D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1 ] );
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  test.case = 'srcRay 2D - array'; /* */

  var srcRay = [ 0, 1, 2, 3 ];
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  test.case = 'srcRay 2D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  test.case = 'srcRay 3D - array'; /* */

  var srcRay = [ 0, 1, 2, 3, 4, 5 ];
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  test.case = 'srcRay 3D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotOrigin = _.ray.originGet( srcRay );
  var expected = _.vector.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcRay );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.originGet( ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( 'ray' ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( null ) );
  test.shouldThrowErrorSync( () => _.ray.originGet( undefined ) );

}

//

function directionGet( test )
{
  test.case = 'Source ray remains unchanged'; /* */

  var srcRay = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 1, 1 ] );

  var gotDirection = _.ray.directionGet( srcRay );
  test.identical( gotDirection, expected );

  var oldSrcRay = [ 0, 0, 1, 1 ];
  test.equivalent( srcRay, oldSrcRay );

  test.case = 'srcRay 1D - array'; /* */

  var srcRay = [ 0, 1 ];
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  test.case = 'srcRay 1D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1 ] );
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  test.case = 'srcRay 2D - array'; /* */

  var srcRay = [ 0, 1, 2, 3 ];
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  test.case = 'srcRay 2D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  test.case = 'srcRay 3D - array'; /* */

  var srcRay = [ 0, 1, 2, 3, 4, 5 ];
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  test.case = 'srcRay 3D - vector'; /* */

  var srcRay = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDirection = _.ray.directionGet( srcRay );
  var expected = _.vector.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcRay );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.directionGet( ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( 'ray' ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( null ) );
  test.shouldThrowErrorSync( () => _.ray.directionGet( undefined ) );

}

//

function rayAt( test )
{
  test.case = 'Source ray and factor remain unchanged'; /* */

  var srcRay = [ 0, 0, 1, 1 ];
  var factor = 1;
  var expected = [ 1, 1 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  var oldSrcRay = [ 0, 0, 1, 1 ];
  test.equivalent( srcRay, oldSrcRay );

  var oldFactor = 1;
  test.equivalent( factor, oldFactor );

  test.case = 'Factor = null, return origin'; /* */

  var srcRay = [ 0, 0, 1, 1 ];
  var factor = 0;
  var expected = [ 0, 0 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  test.case = 'Factor = 0, return origin'; /* */

  var srcRay = [ 0, 0, 1, 1 ];
  var factor = 0;
  var expected = [ 0, 0 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  test.case = 'Factor = 1, return origin + direction'; /* */

  var srcRay = [ 0, 1, 1, 1 ];
  var factor = 1;
  var expected = [ 1, 2 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  test.case = '3D ray'; /* */

  var srcRay = [ 0, 1, 2, 1, 1, 1 ];
  var factor = 1;
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  test.case = 'factor smaller than 1'; /* */

  var srcRay = [ 0, 1, 2, 2, 2, 2 ];
  var factor = 0.5;
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  test.case = 'factor bigger than one'; /* */

  var srcRay = [ 0, 1, 2, 1, 1, 1 ];
  var factor = 5;
  var expected = [ 5, 6, 7 ];

  var gotPoint = _.ray.rayAt( srcRay, factor );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayAt( ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( 'ray', 1 ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.ray.rayAt( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( null, 1 ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( undefined, 1 ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayAt( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function getFactor( test )
{

  test.case = 'Ray and Point remain unchanged'; /* */

  var ray = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = 1;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor, expected );

  var oldRay = [  - 1,  - 1 , 1, 1 ];
  test.identical( ray, oldRay );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null ray contains empty point'; /* */

  var ray = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Point ray contains Point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Factor smaller than one'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0.5;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Factor bigger than one'; /* */

  var ray = [ 0, 0, 0, 1, 1, 1 ];
  var point = [  6, 6, 6 ];
  var expected = 6;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values'; /* */

  var ray = [ 0, 0, 0, 1, 2, 3 ];
  var point = [  6, 12, 18 ];
  var expected = 6;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var ray = [ 0, 0, 0, 1, 2, 0 ];
  var point = [  6, 12, 0 ];
  var expected = 6;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var ray = [ 0, 0, 0, 0, 2, 3 ];
  var point = [  0, 12, 18 ];
  var expected = 6;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var ray = [ 0, 0, 0, 1, 2, 0 ];
  var point = [  6, 12, 18];
  var expected = false;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Ray under point'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = false;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Ray ( normalized to 1 )'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = 1/ Math.sqrt( 2 );

  var gotFactor = _.ray.getFactor( ray, point );
  test.equivalent( gotFactor,  expected );

  test.case = 'Ray of four dimensions'; /* */

  var ray = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0, 0 ];
  var expected = 1;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Ray of 7 dimensions'; /* */

  var ray = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 1, -1, -1, -1, -1, -1, -1 ];
  var expected = 1;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Ray of 1 dimension contains point'; /* */

  var ray = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0.5;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );

  test.case = 'Ray of 1 dimension desn´t contain point '; /* */

  var ray = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = false;

  var gotFactor = _.ray.getFactor( ray, point );
  test.identical( gotFactor,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.getFactor( ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 1, 1, 2, 2 ], 'factor') );
  test.shouldThrowErrorSync( () => _.ray.getFactor( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.getFactor( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function rayParallel3D( test )
{
  test.case = 'Source rays and accuracySqr remain unchanged'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 0, 0, 0, 2, 2, 2 ];
  var accuracySqr = 1E-10;
  var expected = true;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray, accuracySqr );
  test.identical( isParallel, expected );

  var oldSrc1Ray = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  var oldAccuracySqr = 1E-10;
  test.equivalent( accuracySqr, oldAccuracySqr );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 7, 7, 7 ];
  var expected = true;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( different origin - opposite direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, - 7, - 7, - 7 ];
  var expected = true;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( src1Ray is a point )'; /* */

  var src1Ray = [ 3, 7, 1, 0, 0, 0 ];
  var src2Ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( src2Ray is a point )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are not parallel ( same origin - different direction )'; /* */

  var src1Ray = [ 3, 7, 1, 1, - 1, 1 ];
  var src2Ray = [ 3, 7, 1, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are perpendicular'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 1 ];
  var expected = false;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel to x'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, 1, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel but in a opposite direction'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, - 1, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel3D( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayParallel3D( ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel3D( [ 0, 0, 0 ] ) );
   test.shouldThrowErrorSync( () => _.ray.rayParallel3D( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel3D( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.ray.rayParallel3D( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel3D( null, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel3D( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel3D( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel3D( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel3D( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel3D( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayParallel( test )
{
  test.case = 'Source rays and accuracySqr remain unchanged'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 0, 0, 0, 2, 2, 2 ];
  var accuracySqr = 1E-10;
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray, accuracySqr );
  test.identical( isParallel, expected );

  var oldSrc1Ray = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  var oldAccuracySqr = 1E-10;
  test.equivalent( accuracySqr, oldAccuracySqr );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 7, 7, 7 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( different origin - opposite direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, - 7, - 7, - 7 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( src1Ray is a point )'; /* */

  var src1Ray = [ 3, 7, 1, 0, 0, 0 ];
  var src2Ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( src2Ray is a point )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel ( src2Ray is a point - 4D )'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1, 0, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are not parallel ( same origin - different direction )'; /* */

  var src1Ray = [ 3, 7, 1, 1, - 1, 1 ];
  var src2Ray = [ 3, 7, 1, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are perpendicular'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 1 ];
  var expected = false;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel to x'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, 1, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel but in a opposite direction'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, - 1, 0, 0 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel 2D'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, - 2, - 2 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are not parallel 2D'; /* */

  var src1Ray = [ 3, 7, 1, - 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel 4D'; /* */

  var src1Ray = [ 0, 0, 1, 1, 0, 1, 2, 3 ];
  var src2Ray = [ 3, 7, - 2, - 2, 0, 2, 4, 6 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are not parallel 4D'; /* */

  var src1Ray = [ 3, 7, 1, - 1, 3, 7, 1, - 1 ];
  var src2Ray = [ 3, 7, 7, 7, 3, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are parallel 6D'; /* */

  var src1Ray = [ 0, 0, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5 ];
  var src2Ray = [ 3, 7, - 2, - 2, 0, 0, 0, 2, 4, 6, 8, 10 ];
  var expected = true;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  test.case = 'Rays are not parallel 6D'; /* */

  var src1Ray = [ 0, 0, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5 ];
  var src2Ray = [ 3, 7, - 2, - 2, 0, 0, 0, 2, 8, 6, 8, 10 ];
  var expected = false;

  var isParallel = _.ray.rayParallel( src1Ray, src2Ray );
  test.identical( isParallel, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayParallel( ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 0, 0, 0 ] ) );
   test.shouldThrowErrorSync( () => _.ray.rayParallel( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( null, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayParallel( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayIntersectionFactors( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 2, 2 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays don´t intersect'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 0, 2, -1 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays intersect in their origin'; /* */

  var src1Ray = [ 3, 7, 1, 0 ];
  var src2Ray = [ 3, 7, 0, 1 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = _.vector.from( [ 1, 3 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = _.vector.from( [ 3, 2 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays 3D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 3, 0, 1, 4 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays 3D intersection 3rd coordinate 0'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 0 ];
  var src2Ray = [ 3, 3, 0, 0, 1, 0 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays 3D no intersection'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 5, 0, 1, 4 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays 4D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 3, 3, 0, 2, 1, 4 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Rays 4D no intersection'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 3, 5, 3, 0, 0, 1, 4 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays 4D no intersection out of 3D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1, 1, -1 ];
  var src2Ray = [ 3, 3, 3, 2, 0, 1, 4, 3 ];
  var expected = 0;

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Rays 8D intersection'; /* */

  var src1Ray = [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1  ];
  var src2Ray = [ 3, 3, 3, 3, 3, 3, 3, 3, 0, 2, 1, 4, 0, 2, 1, 4 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.ray.rayIntersectionFactors( src1Ray, src2Ray );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionFactors( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayIntersectionPoints( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 2, 2 ];
  var expected = [ [ 0, 0 ], [ 0, 0 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = [ [ 0, 0 ], [ 0, 0 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays don´t intersect'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 0, 2, -1 ];
  var expected = 0;

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays intersect in their origin'; /* */

  var src1Ray = [ 3, 7, 1, 0 ];
  var src2Ray = [ 3, 7, 0, 1 ];
  var expected = [ [ 3, 7 ], [ 3, 7 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = [ [ 1, 0 ], [ 1, 0 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = [ [ 0, 0 ], [ 0, 0 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays don´t intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 3, 1, 4 ];
  var expected = [ [ 9, 9, 9 ], [ 9, 9, 9 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays 3D intersection 3rd coordinate 0'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 0 ];
  var src2Ray = [ 3, 3, 0, 0, 1, 0 ];
  var expected = [ [ 3, 3, 0 ], [ 3, 3, 0 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays don´t intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Rays intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = [ [ 9, 9, 9, 10 ], [ 9, 9, 9, 10 ] ];

  var isIntersectionPoints = _.ray.rayIntersectionPoints( src1Ray, src2Ray );
  test.identical( isIntersectionPoints, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoints( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayIntersectionPoint( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 0, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect in their origin'; /* */

  var src1Ray = [ 3, 7, 1, 0 ];
  var src2Ray = [ 3, 7, 0, 1 ];
  var expected = [ 3, 7 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = [ 1, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 3, 1, 4 ];
  var expected = [ 9, 9, 9 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = [ 9, 9, 9, 10 ];

  var isIntersectionPoint = _.ray.rayIntersectionPoint( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPoint( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayIntersectionPointAccurate( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 0, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect in their origin'; /* */

  var src1Ray = [ 3, 7, 1, 0 ];
  var src2Ray = [ 3, 7, 0, 1 ];
  var expected = [ 3, 7 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = [ 1, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 3, 1, 4 ];
  var expected = [ 9, 9, 9 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays don´t intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Rays intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = [ 9, 9, 9, 10 ];

  var isIntersectionPoint = _.ray.rayIntersectionPointAccurate( src1Ray, src2Ray );
  test.identical( isIntersectionPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersectionPointAccurate( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function pointContains( test )
{

  test.case = 'Ray and Point remain unchanged'; /* */

  var ray = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool, expected );

  var oldRay = [  - 1,  - 1 , 1, 1 ];
  test.identical( ray, oldRay );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null ray contains empty point'; /* */

  var ray = null;
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Point ray contains Point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray contains point'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray over point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Point closer to origin'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 0, -2 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) contains point'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain point'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of four dimensions contains point'; /* */

  var ray = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of four dimensions doesn´t contain point'; /* */

  var ray = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of 7 dimensions contains point'; /* */

  var ray = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 1, -1, -1, -1, -1, -1, -1 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of 7 dimensions doesn´t contain point'; /* */

  var ray = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ 0, 4, 3.5, 0, 5, 2, 2 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of 1 dimension contains point'; /* */

  var ray = [ 0, 2 ];
  var point = [ 1 ];
  var expected = true;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );

  test.case = 'Ray of 1 dimension desn´t contain point '; /* */

  var ray = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = false;

  var gotBool = _.ray.pointContains( ray, point );
  test.identical( gotBool,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.pointContains( ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.pointContains( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.pointContains( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function pointDistance( test )
{

  test.case = 'Ray and Point remain unchanged'; /* */

  var ray = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance, expected );

  var oldRay = [  - 1,  - 1 , 1, 1 ];
  test.identical( ray, oldRay );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null ray Distance empty point'; /* */

  var ray = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Point ray Distance same Point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Point ray Distance other Point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 3, 4, 0 ];
  var expected = 5;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray contains point'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray over point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = 1;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Point closer to origin'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 0, -2 ];
  var expected = 2;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray ( normalized to 1 ) Distance point'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain point'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = 0.568342039793567;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.equivalent( gotDistance,  expected );

  test.case = 'Ray of four dimensions distance '; /* */

  var ray = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 4 ];
  var expected = Math.sqrt( 12 );

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray of 7 dimensions distance'; /* */

  var ray = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 0, 0, 0, 0, 0, 0, 1 ];
  var point = [ 2, 2, 2, 2, 2, 2, 2 ];
  var expected = Math.sqrt( 96 );

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray of 1 dimension contains point'; /* */

  var ray = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );

  test.case = 'Ray of 1 dimension distance'; /* */

  var ray = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = 3;

  var gotDistance = _.ray.pointDistance( ray, point );
  test.identical( gotDistance,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.pointDistance( ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.pointDistance( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function pointClosestPoint( test )
{

  test.case = 'Ray and Point remain unchanged'; /* */

  var ray = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = [ 0, 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint, expected );

  var oldRay = [  - 1,  - 1 , 1, 1 ];
  test.identical( ray, oldRay );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null ray - empty point'; /* */

  var ray = null;
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Point ray - same Point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Point ray - other Point'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var point = [ 3, 4, 0 ];
  var expected = [ 1, 2, 3 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray contains point'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 1 ];
  var expected = [ 1, 1, 1 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray over point'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = [ 0, 0, 4 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Point closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 2, - 2, - 2 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) Distance point'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = [ 0.5, 0.5, 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain point'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = [ 0.02572500470627867, 0.10157398765468795, 0.10157398765468795 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.equivalent( gotClosestPoint,  expected );

  test.case = 'Ray of four dimensions distance '; /* */

  var ray = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 4 ];
  var expected = [ 1, 1, 1, 1 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray of 7 dimensions distance'; /* */

  var ray = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 0, 0, 0, 0, 0, 0, 1 ];
  var point = [ 2, 2, 2, 2, 2, 2, 2 ];
  var expected = [ - 2, - 2, - 2, - 2, - 2, - 2, 2 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray of 1 dimension contains point'; /* */

  var ray = [ 0, 2 ];
  var point = [ 1 ];
  var expected = [ 1 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray of 1 dimension distance'; /* */

  var ray = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = [ 0 ];

  var gotClosestPoint = _.ray.pointClosestPoint( ray, point );
  test.identical( gotClosestPoint,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.pointClosestPoint( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function boxIntersects( test )
{

  test.case = 'Ray and box remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  test.case = 'Null ray - empty box'; /* */

  var ray = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'box ray - same box'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'point ray - no intersection'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = false;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'point ray in box'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray and box intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray over box'; /* */

  var ray = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = false;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'box closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = false;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain box'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, - 0.303 ];
  var expected = false;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.equivalent( gotBool,  expected );

  test.case = '2D intersection'; /* */

  var ray = [ 0, 0, 2, 2 ];
  var box = [ 1, 2, 3, 4 ];
  var expected = true;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );

  test.case = '2D no intersection'; /* */

  var ray = [ 0, 0, 2, -2 ];
  var box = [ 1, 2, 3, 4 ];
  var expected = false;

  var gotBool = _.ray.boxIntersects( ray, box );
  test.identical( gotBool,  expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.boxIntersects( ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.boxIntersects( [ 1, 1, 2, 2 ], - 2 ) );

}

//

function boxDistance( test )
{
  test.case = 'Ray and box remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  test.case = 'Null ray - empty box'; /* */

  var ray = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'box ray - same box'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'point ray'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 5 ];
  var expected = 1;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'point ray in box'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray and box intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray over box'; /* */

  var ray = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = Math.sqrt( 2 );

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'box corner closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = Math.sqrt( 3 );

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'box side closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ -1, -1, -1, 0.5, 0.5, - 0.1 ];
  var expected = 0.1;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = 0;

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain box'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, 0.303 ];
  var expected = 0.04570949385069674;

  var gotBool = _.ray.boxDistance( ray, box );
  test.equivalent( gotBool,  expected );

  test.case = '2D'; /* */

  var ray = [ 2, 2, 2, 2 ];
  var box = [ 0, 0, 1, 1 ];
  var expected = Math.sqrt( 2 );

  var gotBool = _.ray.boxDistance( ray, box );
  test.identical( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.boxDistance( ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.boxDistance( [ 1, 1, 2, 2 ], - 2 ) );

}

//

function boxClosestPoint( test )
{
  test.case = 'Ray and box remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  test.case = 'Null ray - empty box'; /* */

  var ray = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'box ray - same box'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'point ray'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'point ray in box'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'Ray and box intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'Ray over box'; /* */

  var ray = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = [ 0, 0, 4 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'box corner closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'box side closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ -1, -1, -1, 0.5, 0.5, - 0.1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'box corner not close to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ 6, 7, 8, 6, 9, 10 ];
  var expected = [ 7, 7, 7 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = 0;

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) doesn´t contain box'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, - 0.303 ];
  var expected = [ 0.005519293548276563, 0.021792674525669315, 0.021792674525669315 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.equivalent( gotPoint,  expected );

  test.case = '2D'; /* */

  var ray = [ 0, 0, 2, 1 ];
  var box = [ 6, 7, 10, 8 ];
  var expected = [ 10.8, 5.4 ];

  var gotPoint = _.ray.boxClosestPoint( ray, box );
  test.identical( gotPoint,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.boxClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );

}

//

function boundingBoxGet( test )
{

  test.case = 'Source ray remains unchanged'; /* */

  var srcRay = [ 0, 0, 0, 3, 3, 3 ];
  var dstBox = [ 1, 1, 1, 2, 2, 2 ];
  var expected = [ 0, 0, 0, Infinity, Infinity, Infinity ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( expected, gotBox );
  test.is( dstBox === gotBox );

  var oldSrcRay = [ 0, 0, 0, 3, 3, 3 ];
  test.identical( srcRay, oldSrcRay );

  test.case = 'Empty'; /* */

  var srcRay = [ ];
  var dstBox = [ ];
  var expected = [ ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( gotBox, expected );

  test.case = 'Zero ray to zero box'; /* */

  var srcRay = [ 0, 0, 0, 0, 0, 0 ];
  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( gotBox, expected );

  test.case = 'Ray inside box'; /* */

  var srcRay = [ 1, 1, 1, 4, 4, 4 ];
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = [ 1, 1, 1, Infinity, Infinity, Infinity ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( gotBox, expected );

  test.case = 'Ray outside Box'; /* */

  var srcRay = [ - 1, - 1, - 1, 1, 2, 3 ];
  var dstBox = [ - 3, - 4, - 5, - 5, - 4, - 2 ];
  var expected = [ - 1, - 1, - 1, Infinity, Infinity, Infinity ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( gotBox, expected );

  test.case = 'Point ray and point Box'; /* */

  var srcRay = [ 1, 2, 3, 0, 0, 0 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = [ 1, 2, 3, 1, 2, 3 ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( gotBox, expected );

  test.case = 'Negative ray direction'; /* */

  var srcRay = [ 1, 2, 3, - 3, - 2, - 1 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = [  - Infinity, - Infinity, - Infinity, 1, 2, 3 ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( gotBox, expected );

  test.case = 'Mixed directions'; /* */

  var srcRay = [ 1, 2, 3, - 1, 0, 1 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = [ - Infinity, 2, 3, 1, 2, Infinity ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( gotBox, expected );

  test.case = 'srcRay vector'; /* */

  var srcRay = _.vector.from( [ - 8, - 5, 4.5, 4, 7, 16.5 ] );
  var dstBox = [ 1, - 1, 5, 0, 3, 2 ];
  var expected = [ - 8, - 5, 4.5, Infinity, Infinity, Infinity ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( gotBox, expected );

  test.case = 'dstBox vector - 2D'; /* */

  var srcRay = [ - 1, 0, - 2, 3 ];
  var dstBox = _.vector.from( [ 1, 2, 3, 9 ] );
  var expected = _.vector.from( [ - Infinity, 0, - 1, Infinity ] );

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( gotBox, expected );

  test.case = 'dstBox null'; /* */

  var srcRay = [ 2.2, 3.3, - 4.4, 0 ];
  var dstBox = null;
  var expected = [ - Infinity, 3.3, 2.2, 3.3 ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.equivalent( gotBox, expected );

  test.case = 'dstBox undefined'; /* */

  var srcRay = [ - 1, - 3, - 5, 1 ];
  var dstBox = undefined;
  var expected = [  - Infinity, - 3, - 1, Infinity ];

  var gotBox = _.ray.boundingBoxGet( dstBox, srcRay );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.boundingBoxGet( ) );
  test.shouldThrowErrorSync( () => _.ray.boundingBoxGet( [] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingBoxGet( 'box', 'ray' ) );
  test.shouldThrowErrorSync( () => _.ray.boundingBoxGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingBoxGet( [ 1, 0, 1, 2, 1, 2 ], [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4, 5 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingBoxGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.ray.boundingBoxGet( [ 0, 1, 0, 1, 2 ], [ 0, 0, 1 ] ) );

}

//

function capsuleClosestPoint( test )
{
  test.case = 'Ray and capsule remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var capsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.ray.capsuleClosestPoint( ray, capsule );
  test.identical( gotPoint, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  test.case = 'zero ray - same capsule'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var capsule = [ 0, 0, 0, 0, 0, 0, 0];
  var expected = 0;

  var gotPoint = _.ray.capsuleClosestPoint( ray, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'point ray'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var capsule = [ 1, 2, 4, 3, 4, 0, 0.5 ];
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.ray.capsuleClosestPoint( ray, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'point ray in capsule'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var capsule = [ 1, 2, 2, 3, 4, 4, 1 ];
  var expected = 0;

  var gotPoint = _.ray.capsuleClosestPoint( ray, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'Ray and capsule intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var capsule = [ 0, 1, 0, 1, 2, 1, 2 ];
  var expected = 0;

  var gotPoint = _.ray.capsuleClosestPoint( ray, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'Ray over capsule'; /* */

  var ray = [ 0, 0, 4, 0, 0, 2 ];
  var capsule = [ 0, 1, 1, 3, 7, 3, 0.2 ];
  var expected = [ 0, 0, 4 ];

  var gotPoint = _.ray.capsuleClosestPoint( ray, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'capsule corner closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var capsule = [ - 2, - 2, - 2, -1, -1, -1, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.ray.capsuleClosestPoint( ray, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'capsule side closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var capsule = [ -1, -1, -1, 0.5, 0.5, - 0.2, 0.1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.ray.capsuleClosestPoint( ray, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'capsule corner not close to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var capsule = [ 6, 7, 8, 6, 9, 10, 1 ];
  var expected = [ 7, 7, 7 ];

  var gotPoint = _.ray.capsuleClosestPoint( ray, capsule );
  test.identical( gotPoint,  expected );

  test.case = '2D'; /* */

  var ray = [ 0, 0, 2, 1 ];
  var capsule = [ 6, 7, 10, 8, 0.1 ];
  var expected = [ 11.2, 5.6 ];

  var gotPoint = _.ray.capsuleClosestPoint( ray, capsule );
  test.identical( gotPoint,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( 'ray', [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( [ 1, 1, 2, 2 ], 'capsule') );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( undefined, [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( null, [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2, 3, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.capsuleClosestPoint( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2, - 1 ] ) );

}

//

function frustumIntersects( test )
{

  test.description = 'Ray and frustum remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 1, 1, 1, 3, 3, 3 ];
  var expected = true;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  var oldRay = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( ray, oldRay );

  var oldFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( srcFrustum, oldFrustum );


  test.description = 'Frustum and ray intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and ray intersect on frustum corner'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 2, 2, 0, - 1, -1, 1 ];
  var expected = true;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum corner is ray origin'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 1, 1, 1, 0, 0, 2 ];
  var expected = true;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and ray intersect on frustum side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ -1, -1, 0, 0.5, 0.5, 0 ];
  var expected = true;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and ray not intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 4, 4, 4, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and ray almost intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 1.1, 1.1, 1.1, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and ray just touching'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 1, 1, 1, 5 , 5, 5 ];
  var expected = true;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and ray just intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 0.9, 0.9, 0.9, 5, 5, 5 ];
  var expected = true;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'ray is null - intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = null;
  var expected = true;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'ray is null - no intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var ray = null;
  var expected = false;

  var gotBool = _.ray.frustumIntersects( ray, srcFrustum );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);

  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( ));
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( ray ));
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( ray, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( ray, ray, srcFrustum ));
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( null, ray ));
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( NaN, ray ));
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( srcFrustum, NaN));

  ray = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( ray, srcFrustum ));
  ray = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( ray, srcFrustum ));
  ray = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.ray.frustumIntersects( ray, srcFrustum ));

}

//

function frustumDistance( test )
{

  test.description = 'Ray and frustum remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 1, 1, 1, 3, 3, 3 ];
  var expected = 0;

  var gotDistance = _.ray.frustumDistance( ray, srcFrustum );
  test.identical( gotDistance, expected );

  var oldRay = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( ray, oldRay );

  var oldFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum and ray intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.ray.frustumDistance( ray, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and ray intersect on frustum corner'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 2, 2, 0, - 1, -1, 1 ];
  var expected = 0;

  var gotDistance = _.ray.frustumDistance( ray, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and ray intersect on frustum side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ -1, -1, 0, 0.5, 0.5, 0 ];
  var expected = 0;

  var gotDistance = _.ray.frustumDistance( ray, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and ray not intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 4, 4, 4, 5, 5, 5 ];
  var expected = Math.sqrt( 27 );

  var gotDistance = _.ray.frustumDistance( ray, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and ray almost intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 1.1, 1.1, 1.1, 5, 5, 5 ];
  var expected = Math.sqrt( 0.03 );

  var gotDistance = _.ray.frustumDistance( ray, srcFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'ray is null - intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = null;
  var expected = 0;

  var gotDistance = _.ray.frustumDistance( ray, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'ray is null - no intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var ray = null;
  var expected = Math.sqrt( 0.75 );

  var gotDistance = _.ray.frustumDistance( ray, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'ray closest to box side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var ray = [ - 2, 0.3, 0, 1, 0, 0 ];
  var expected = Math.sqrt( 0.29 );

  var gotDistance = _.ray.frustumDistance( ray, srcFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Inclined ray closest to box side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var ray = [ -2, 0.3, 0, 1, 0, 0.1 ];
  var expected = 0.2821417381318113;

  var gotDistance = _.ray.frustumDistance( ray, srcFrustum );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);

  test.shouldThrowErrorSync( () => _.ray.frustumDistance( ));
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( ray ));
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( srcFrustum ));
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( ray, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( ray, ray, srcFrustum ));
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( null, ray ));
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( NaN, ray ));
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( srcFrustum, NaN));

  ray = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( ray, srcFrustum ));
  ray = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( ray, srcFrustum ));
  ray = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.ray.frustumDistance( ray, srcFrustum ));

}

//

function frustumClosestPoint( test )
{

  test.description = 'Ray and frustum remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 1, 1, 1, 3, 3, 3 ];
  var expected = 0;

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum );
  test.identical( gotClosestPoint, expected );

  var oldRay = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( ray, oldRay );

  var oldFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum and ray intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and ray intersect on frustum corner'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 2, 2, 0, - 1, -1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and ray intersect on frustum side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ -1, -1, 0, 0.5, 0.5, 0 ];
  var expected = 0;

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and ray not intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 4, 4, 4, 5, 5, 5 ];
  var expected = [ 4, 4, 4 ];

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and ray almost intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = [ 1.1, 1.1, 1.1, 5, 5, 5 ];
  var expected = [ 1.1, 1.1, 1.1 ];

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'ray is null - intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var ray = null;
  var expected = 0;

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'ray is null - no intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var ray = null;
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'ray closest to box side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var ray = [ - 2, 0.3, 0, 1, 0, 0 ];
  var expected = [ 0.5, 0.3, 0 ];

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Inclined ray closest to box side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var ray = [ -2, 0.3, 0, 1, 0, 0.1 ];
  var expected = [ 1.0198019801980198, 0.3, 0.301980198019802 ];

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Destination point is vector'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var ray = [ 0, 2, 2, - 1, - 1, - 1 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ -0.5, 1.5, 1.5 ] );

  var gotClosestPoint = _.ray.frustumClosestPoint( ray, srcFrustum, dstPoint );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);

  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( ));
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( ray ));
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( srcFrustum ));
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( ray, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( ray, ray, srcFrustum ));
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( null, ray ));
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( NaN, ray ));
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( srcFrustum, NaN));

  ray = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( ray, srcFrustum ));
  ray = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( ray, srcFrustum ));
  ray = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.ray.frustumClosestPoint( ray, srcFrustum ));

}

//

function lineClosestPoint( test )
{
  test.case = 'Source line and ray remain unchanged'; /* */

  var srcRay = [ 0, 0, 0, 2, 2, 2 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  var oldSrcRay = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( srcRay, oldSrcRay );

  var oldTstLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( tstLine, oldTstLine );

  test.case = 'Line and ray are parallel ( different origin - same direction )'; /* */

  var srcRay = [ 3, 7, 1, 0, 0, 1 ];
  var tstLine = [ 0, 0, 0, 0, 0, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are parallel ( different origin - different direction )'; /* */

  var srcRay = [ 0, 0, 0, 0, 0, 0.5 ];
  var tstLine = [ 3, 7, 1, 0, 0, 7 ];
  var expected = [ 0, 0, 1 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are parallel ( different origin - opposite direction )'; /* */

  var srcRay = [ 3, 7, 1, 7, 0, 0 ];
  var tstLine = [ 0, 0, 0, - 1, 0, 0 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'tstLine is a point'; /* */

  var srcRay = [ 0, 0, 0, 1, 1, 1 ];
  var tstLine = [ 3, 7, 1, 0, 0, 0 ];
  var expected = [ 3.6666666, 3.6666666, 3.6666666 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'srcRay is a point'; /* */

  var srcRay = [ 3, 7, 1, 0, 0, 0 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Line and ray are the same'; /* */

  var srcRay = [ 0, 4, 2, 1, 1, 1 ];
  var tstLine = [ 0, 4, 2, 1, 1, 1 ];
  var expected = [ 0, 4, 2 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray intersect 4D'; /* */

  var srcRay = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var tstLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var expected = [ 0, 4, 2, 1 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray don´t intersect 2D - parallel'; /* */

  var srcRay = [ - 3, - 4, 1, 0 ];
  var tstLine = [ 0, 0, 2, 0 ];
  var expected = [ 0, -4 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray intersect with line´s negative factor 2D'; /* */

  var srcRay = [ - 3, - 4, 0, 1 ];
  var tstLine = [ 0, 0, 2, 0 ];
  var expected = [ -3, 0 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray don´t intersect with ray´s negative factor 2D'; /* */

  var srcRay = [ 0, 0, 2, 0 ];
  var tstLine = [ - 3, - 4, 0, 1 ];
  var expected = [ 0, 0 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are perpendicular and intersect'; /* */

  var srcRay = [ 3, 7, 1, 0, 0, 1 ];
  var tstLine = [ 3, 7, 1, 1, 0, 0 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are perpendicular and don´t intersect'; /* */

  var srcRay = [ 3, 0, 0, 1, 1, 0 ];
  var tstLine = [ 0, 0, -3, 0, 0, 1 ];
  var expected = [ 3, 0, 0 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are parallel to x'; /* */

  var srcRay = [ 3, 7, 2, 1, 0, 0 ];
  var tstLine = [ 3, 7, 1, 1, 0, 0 ];
  var expected = [ 3, 7, 2 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are parallel but in a opposite direction'; /* */

  var srcRay = [ 3, 7, 2, - 1, 0, 0 ];
  var tstLine = [ 3, 7, 1, 1, 0, 0 ];
  var expected = [ 3, 7, 2 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  test.case = 'srcRay is null'; /* */

  var srcRay = null;
  var tstLine = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.lineClosestPoint( srcRay, tstLine );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.lineClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.lineClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.lineClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.lineClosestPoint( [ 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.lineClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.lineClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function planeIntersects( test )
{

  test.case = 'Ray and plane remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  test.case = 'Null ray - empty plane'; /* */

  var ray = null;
  var plane = [ 1, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool,  expected );

  test.case = 'point ray - no intersection'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool,  expected );

  test.case = 'point ray in plane'; /* */

  var ray = [ - 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool,  expected );

  test.case = 'Ray and plane intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool,  expected );

  test.case = 'Ray over plane'; /* */

  var ray = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ 1, 0, 0, 3 ];
  var expected = false;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool,  expected );

  test.case = 'plane closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 0.5 ];
  var expected = false;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var plane = [ 0, 2, 0, - 2 ];
  var expected = true;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) no intersection'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var plane = [ 3, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.equivalent( gotBool,  expected );

  test.case = 'plane parallel to ray'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0.5 ];
  var expected = false;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool,  expected );

  test.case = 'plane parallel contains ray'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool,  expected );

  test.case = 'plane perpendicular to ray'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = true;

  var gotBool = _.ray.planeIntersects( ray, plane );
  test.identical( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.planeIntersects( ) );
  test.shouldThrowErrorSync( () => _.ray.planeIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.planeIntersects( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], 'plane') );
  test.shouldThrowErrorSync( () => _.ray.planeIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.planeIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function planeDistance( test )
{

  test.case = 'Ray and plane remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  test.case = 'Null ray - empty plane'; /* */

  var ray = null;
  var plane = [ 1, 0, 0, 1 ];
  var expected = 1;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance,  expected );

  test.case = 'point ray - no intersection'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 2;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance,  expected );

  test.case = 'point ray in plane'; /* */

  var ray = [ - 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance,  expected );

  test.case = 'Ray and plane intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance,  expected );

  test.case = 'Ray over plane'; /* */

  var ray = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ 1, 0, 0, 3 ];
  var expected = 3;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance,  expected );

  test.case = 'plane closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 0.5 ];
  var expected = 0.5;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var plane = [ 0, 2, 0, - 2 ];
  var expected = 0;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance,  expected );

  test.case = 'Ray ( normalized to 1 ) no intersection'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var plane = [ 3, 0, 0, 1 ];
  var expected = 1/3;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.equivalent( gotDistance,  expected );

  test.case = 'plane parallel to ray'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0.5 ];
  var expected = 0.5;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance,  expected );

  test.case = 'plane parallel contains ray'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance,  expected );

  test.case = 'plane perpendicular to ray'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = 0;

  var gotDistance = _.ray.planeDistance( ray, plane );
  test.identical( gotDistance,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.planeDistance( ) );
  test.shouldThrowErrorSync( () => _.ray.planeDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.planeDistance( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.planeDistance( [ 1, 1, 1, 2, 2, 2 ], 'plane') );
  test.shouldThrowErrorSync( () => _.ray.planeDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.planeDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.planeDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.planeDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.planeDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.planeDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function planeClosestPoint( test )
{

  test.case = 'Ray and plane remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  test.case = 'Null ray - empty plane'; /* */

  var ray = null;
  var plane = [ 1, 0, 0, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint,  expected );

  test.case = 'point ray - no intersection'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint,  expected );

  test.case = 'point ray in plane'; /* */

  var ray = [ - 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint,  expected );

  test.case = 'Ray and plane intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint,  expected );

  test.case = 'Ray over plane'; /* */

  var ray = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ 1, 0, 0, 3 ];
  var expected = [ 0, -6, 4 ];

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint,  expected );

  test.case = 'plane closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 0.5 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var plane = [ 0, 2, 0, - 2 ];
  var expected = 0;

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) no intersection'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var plane = [ 3, 0, 0, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.equivalent( gotPoint,  expected );

  test.case = 'plane parallel to ray'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0.5 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint,  expected );

  test.case = 'plane parallel contains ray'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint,  expected );

  test.case = 'plane perpendicular to ray'; /* */

  var ray = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = 0;

  var gotPoint = _.ray.planeClosestPoint( ray, plane );
  test.identical( gotPoint,  expected );

  test.case = 'dstPoint is array'; /* */

  var ray = [ 0, -6, 24, 1, 1, 1 ];
  var plane = [ 1, 0, 1, 3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 0, -6, 24 ];

  var gotPoint = _.ray.planeClosestPoint( ray, plane, dstPoint );
  test.identical( gotPoint,  expected );

  test.case = 'dstPoint is vector'; /* */

  var ray = [ 0, -6, 24, 1, 1, 1 ];
  var plane = [ 1, 0, 1, 3 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 0, -6, 24 ] );

  var gotPoint = _.ray.planeClosestPoint( ray, plane, dstPoint );
  test.identical( gotPoint,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.planeClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.planeClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.planeClosestPoint( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], 'plane') );
  test.shouldThrowErrorSync( () => _.ray.planeClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.planeClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function rayIntersects( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 2, 2 ];
  var expected = true;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  var oldSrc1Ray = [ 0, 0, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 0, 0, 1, 1 ];
  var expected = true;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 1 ];
  var expected = false;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 7, 7, 7 ];
  var expected = false;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays are parallel and intersect'; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ - 3, 0, 2, 0 ];
  var expected = true;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays don´t intersect with negative factor'; /* */

  var src1Ray = [ 0, 0, 1, 1 ];
  var src2Ray = [ 3, 0, 2, -1 ];
  var expected = false;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays intersect in their origin'; /* */

  var src1Ray = [ 3, 7, 1, 0 ];
  var src2Ray = [ 3, 7, 0, 1 ];
  var expected = true;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays intersect '; /* */

  var src1Ray = [ 0, 0, 1, 0 ];
  var src2Ray = [ -2, -6, 1, 2 ];
  var expected = true;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays are perpendicular '; /* */

  var src1Ray = [ -3, 0, 1, 0 ];
  var src2Ray = [ 0, -2, 0, 1 ];
  var expected = true;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays don´t intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays intersect 3D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 3, 1, 4 ];
  var expected = true;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays don´t intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  test.case = 'Rays intersect 4D'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = true;

  var isIntersection = _.ray.rayIntersects( src1Ray, src2Ray );
  test.identical( isIntersection, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.rayIntersects( ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersects( 'ray', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersects( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersects( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersects( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersects( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersects( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayIntersects( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayDistance( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  var oldSrc1Ray = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 0, 0, 0, 1 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 1 ];
  var expected = Math.sqrt( 58 );

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 0, 0, 0, 0, 0, 0.5 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 7 ];
  var expected = Math.sqrt( 58 );

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'Rays are parallel ( different origin - opposite direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = Math.sqrt( 50 );

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'src1Ray is a point'; /* */

  var src1Ray = [ 3, 7, 1, 0, 0, 0 ];
  var src2Ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 4.320493798938574;

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 4, 2, 1, 1, 1 ];
  var src2Ray = [ 0, 4, 2, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'Rays intersect 4D'; /* */

  var src1Ray = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var src2Ray = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'Rays don´t intersect 2D'; /* */

  var src1Ray = [ 0, 0, 2, 0 ];
  var src2Ray = [ - 3, - 4, 0, 1 ];
  var expected = 3;

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'Rays are perpendicular and intersect'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'Rays are perpendicular and don´t intersect'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, -2, 1, 0, 0, 1 ];
  var expected = 9;

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'Rays are parallel to x'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 2, 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'Rays are parallel but in a opposite direction'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  test.case = 'srcRay is null'; /* */

  var src1Ray = null;
  var src2Ray = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = Math.sqrt( 53 );

  var gotDistance = _.ray.rayDistance( src1Ray, src2Ray );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayDistance( ) );
  test.shouldThrowErrorSync( () => _.ray.rayDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayDistance( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayDistance( [ 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayDistance( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayClosestPoint( test )
{
  test.case = 'Source rays remain unchanged'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 0, 0, 0, 2, 2, 2 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  var oldSrc1Ray = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Ray, oldSrc1Ray );

  var oldSrc2Ray = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Ray, oldSrc2Ray );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'Rays are parallel ( different origin - same direction )'; /* */

  var src1Ray = [ 0, 0, 0, 0, 0, 1 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 1 ];
  var expected = [ 0, 0, 1 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'Rays are parallel ( different origin - different direction )'; /* */

  var src1Ray = [ 3, 7, 1, 0, 0, 7 ];
  var src2Ray = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'Rays are parallel ( different origin - opposite direction )'; /* */

  var src1Ray = [ 0, 0, 0, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = [ 3, 0, 0 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'src1Ray is a point - in srcRay1'; /* */

  var src1Ray = [ 3, 7, 1, 0, 0, 0 ];
  var src2Ray = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'src1Ray is a point - in srcRay2'; /* */

  var src1Ray = [ 0, 0, 0, 1, 1, 1 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 0 ];
  var expected = [ 3.6666666, 3.6666666, 3.6666666 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Rays are the same'; /* */

  var src1Ray = [ 0, 4, 2, 1, 1, 1 ];
  var src2Ray = [ 0, 4, 2, 1, 1, 1 ];
  var expected = [ 0, 4, 2 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'Rays intersect 4D'; /* */

  var src1Ray = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var src2Ray = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = [ 0, 4, 2, 1 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'Rays intersect 2D'; /* */

  var src1Ray = [ 0, 0, 2, 0 ];
  var src2Ray = [ - 3, - 4, 0, 1 ];
  var expected = [ 0, 0 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'Rays don´t intersect 2D'; /* */

  var src1Segment = [ 0, 0, 2, 1 ];
  var src2Segment = [ 1, 0, - 1, - 2 ];
  var expected = [ 0.8, 0.4 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Segment, src2Segment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Rays are perpendicular and intersect'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 1, 0, 0, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'Rays are perpendicular and don´t intersect'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, -2, 1, 0, 0, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'Rays are parallel to x'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 2, 1, 0, 0 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'Rays are parallel but in a opposite direction'; /* */

  var src1Ray = [ 3, 7, 1, 1, 0, 0 ];
  var src2Ray = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  test.case = 'srcRay is null'; /* */

  var src1Ray = null;
  var src2Ray = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.rayClosestPoint( src1Ray, src2Ray );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.rayClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.rayClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayClosestPoint( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayClosestPoint( [ 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.rayClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.rayClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function segmentClosestPoint( test )
{
  test.case = 'Source segment and ray remain unchanged'; /* */

  var srcRay = [ 0, 0, 0, 2, 2, 2 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  var oldSrcRay = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( srcRay, oldSrcRay );

  var oldTstSegment = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( tstSegment, oldTstSegment );

  test.case = 'Segment and ray are parallel ( different origin - same direction )'; /* */

  var srcRay = [ 3, 7, 1, 0, 0, 1 ];
  var tstSegment = [ 0, 0, 0, 0, 0, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Segment and ray are parallel ( different origin - different direction )'; /* */

  var srcRay = [ 0, 0, 0, 0, 0, 0.5 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 7 ];
  var expected = [ 0, 0, 1 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Segment and ray are parallel ( different origin - opposite direction )'; /* */

  var srcRay = [ 3, 7, 1, 7, 0, 0 ];
  var tstSegment = [ 0, 0, 0, - 10, 0, 0 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'tstSegment is a point'; /* */

  var srcRay = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 1 ];
  var expected = [ 3.6666666, 3.6666666, 3.6666666 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'srcRay is a point'; /* */

  var srcRay = [ 3, 7, 1, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Segment and ray are the same'; /* */

  var srcRay = [ 0, 4, 2, 1, 1, 1 ];
  var tstSegment = [ 0, 4, 2, 3, 7, 5 ];
  var expected = [ 0, 4, 2 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Segment and ray intersect 4D'; /* */

  var srcRay = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 2, 1, 0, 8, 2, 1 ];
  var expected = [ 0, 4, 2, 1 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Segment and ray don´t intersect 2D - parallel'; /* */

  var srcRay = [ - 3, - 4, 1, 0 ];
  var tstSegment = [ 0, 0, 2, 0 ];
  var expected = [ 0, -4 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Segment and ray intersect with segment´s negative factor 2D'; /* */

  var srcRay = [ - 3, - 4, 0, 1 ];
  var tstSegment = [ 0, 0, 2, 0 ];
  var expected = [ -3, 0 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Segment and ray don´t intersect with ray´s negative factor 2D'; /* */

  var srcRay = [ 0, 0, 2, 0 ];
  var tstSegment = [ - 3, - 4, -3, 7 ];
  var expected = [ 0, 0 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Segment and ray are perpendicular and intersect'; /* */

  var srcRay = [ 3, 7, 1, 0, 0, 1 ];
  var tstSegment = [ 3, 7, 1, 8, 7, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Segment and ray are perpendicular and don´t intersect'; /* */

  var srcRay = [ 3, 0, 0, 1, 1, 0 ];
  var tstSegment = [ 0, 0, -3, 0, 0, 1 ];
  var expected = [ 3, 0, 0 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Segment and ray are parallel to x'; /* */

  var srcRay = [ 3, 7, 2, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 1, 8, 7, 1 ];
  var expected = [ 3, 7, 2 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Segment and ray are parallel but in a opposite direction'; /* */

  var srcRay = [ 3, 7, 2, - 1, 0, 0 ];
  var tstSegment = [ 3, 7, 1, 8, 7, 1 ];
  var expected = [ 3, 7, 2 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'srcRay is null'; /* */

  var srcRay = null;
  var tstSegment = [ 3, 7, 2, 2, 7, 2 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.segmentClosestPoint( srcRay, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.ray.segmentClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.segmentClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.segmentClosestPoint( 'segment', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.segmentClosestPoint( [ 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.ray.segmentClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.segmentClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function sphereIntersects( test )
{

  test.case = 'Ray and sphere remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  test.case = 'Null ray - empty sphere'; /* */

  var ray = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'point ray center of sphere'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'point ray - no intersection'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = false;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'point ray in sphere'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Ray and sphere intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Ray over sphere'; /* */

  var ray = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = false;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'sphere closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = false;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = true;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Ray ( normalized to 1 ) no intersection'; /* */

  var ray = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var sphere = [ 3, 3, 3, 1 ];
  var expected = false;

  var gotBool = _.ray.sphereIntersects( ray, sphere );
  test.equivalent( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function sphereDistance( test )
{

  test.case = 'Ray and sphere remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  test.case = 'Null ray - empty sphere'; /* */

  var ray = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'point ray center of sphere'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'point ray - no intersection'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = Math.sqrt( 11 ) - 1;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'point ray in sphere'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Ray and sphere intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Ray over sphere'; /* */

  var ray = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = 1;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'sphere closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = Math.sqrt( 12 ) - 0.5;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = 0;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Ray ( normalized to 1 ) no intersection'; /* */

  var ray = [ 0, 0, 0, 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ) ];
  var sphere = [ 3, 0, 0, 1 ];
  var expected = Math.sqrt( 6 ) - 1;

  var gotDistance = _.ray.sphereDistance( ray, sphere );
  test.equivalent( gotDistance,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.sphereDistance( ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function sphereClosestPoint( test )
{

  test.case = 'Ray and sphere remain unchanged'; /* */

  var ray = [  - 1,  - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere );
  test.identical( gotClosestPoint, expected );

  var oldRay = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( ray, oldRay );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  test.case = 'Null ray - empty sphere'; /* */

  var ray = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'point ray center of sphere'; /* */

  var ray = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'point ray - no intersection'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = [ 1, 2, 3 ];

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'point ray in sphere'; /* */

  var ray = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray and sphere intersect'; /* */

  var ray = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray over sphere'; /* */

  var ray = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = [ 0, 0, 4 ];

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'sphere closer to origin'; /* */

  var ray = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) intersection'; /* */

  var ray = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = 0;

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Ray ( normalized to 1 ) no intersection'; /* */

  var ray = [ 0, 0, 0, 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ) ];
  var sphere = [ 3, 0, 0, 1 ];
  var expected = [ 1, 1, 1 ];

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere );
  test.equivalent( gotClosestPoint,  expected );

  test.case = 'dstPoint is vector'; /* */

  var ray = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 5, 0, 3 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 0, 5, 4 ] );

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere, dstPoint );
  test.identical( gotClosestPoint,  expected );

  test.case = 'dstPoint is array'; /* */

  var ray = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 1, 5, 0, 3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 0, 5, 4 ];

  var gotClosestPoint = _.ray.sphereClosestPoint( ray, sphere, dstPoint );
  test.identical( gotClosestPoint,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.sphereClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.ray.sphereClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereClosestPoint( 'ray', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.ray.sphereClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.ray.sphereClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.ray.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.ray.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function boundingSphereGet( test )
{

  test.case = 'Source ray remains unchanged'; /* */

  var srcRay = [ 0, 0, 0, 3, 3, 3 ];
  var dstSphere = [ 1, 1, 2, 1 ];
  var expected = [ 0, 0, 0, Infinity ];

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( expected, gotSphere );
  test.is( dstSphere === gotSphere );

  var oldSrcRay = [ 0, 0, 0, 3, 3, 3 ];
  test.identical( srcRay, oldSrcRay );

  test.case = 'Zero ray to zero sphere'; /* */

  var srcRay = [ 0, 0, 0, 0, 0, 0 ];
  var dstSphere = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( gotSphere, expected );

  test.case = 'Point ray and point Sphere'; /* */

  var srcRay = [ 1, 2, 3, 0, 0, 0 ];
  var dstSphere = [ 3, 3, 3, 0 ];
  var expected = [ 1, 2, 3, 0 ];

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( gotSphere, expected );

  test.case = 'Sphere and ray intersect'; /* */

  var srcRay = [ 0, 0, 0, 4, 4, 4 ];
  var dstSphere = [ 2, 2, 2, 1 ];
  var expected = [ 0, 0, 0, Infinity ];

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( gotSphere, expected );

  test.case = 'Sphere and ray intersect - negative dir'; /* */

  var srcRay = [ 0, 0, 0, - 1, - 1, - 1 ];
  var dstSphere = [ 0, 0, 0, 3 ];
  var expected = [ 0, 0, 0, Infinity ];

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( gotSphere, expected );

  test.case = 'Sphere and ray don´t intersect'; /* */

  var srcRay = [ - 1, 2, - 2, 5, 8, 9 ];
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ - 1, 2, - 2, Infinity ];

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( gotSphere, expected );

  test.case = 'srcRay vector'; /* */

  var srcRay = _.vector.from( [- 1, - 1, - 1, 1, 1, 1 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ - 1, - 1, - 1, Infinity ];

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere vector'; /* */

  var srcRay = [- 1, - 1, - 1, 3, 3, 1 ];
  var dstSphere = _.vector.from( [ 5, 5, 5, 3 ] );
  var expected = _.vector.from( [ - 1, - 1, - 1, Infinity ] );

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere null'; /* */

  var srcRay = [- 1, 5, - 1, 0, 0, 0 ];
  var dstSphere = null;
  var expected = [ - 1, 5, - 1, 0 ];

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere undefined'; /* */

  var srcRay = [ - 1, - 3, - 5, 1, 0, 0 ];
  var dstSphere = undefined;
  var expected = [ - 1, - 3, - 5, Infinity ];

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( gotSphere, expected );

  test.case = 'Direccion module very small'; /* */

  var srcRay = _.vector.from( [ 4, 4, 4, 0, 1E-12, - 1E-12 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ 4, 4, 4, Infinity ];

  var gotSphere = _.ray.boundingSphereGet( dstSphere, srcRay );
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( ) );
  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( [] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( 'sphere', 'ray' ) );
  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( [ 0, 0, 0, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.ray.boundingSphereGet( [ 0, 1, 0, 1 ], [ 0, 0, 1, 2, 2, 3, 1 ] ) );

}



// --
// define class
// --

var Self =
{

  name : 'Tools.Math.Ray',
  silencing : 1,
  enabled : 1,
  // routine: 'is',

  tests :
  {
    make : make,
    makeZero : makeZero,
    makeNil : makeNil,

    zero : zero,
    nil : nil,

    from: from,
    _from : _from,
    fromPair : fromPair,

    is : is,
    dimGet : dimGet,
    originGet : originGet,
    directionGet : directionGet,

    rayAt : rayAt,
    getFactor : getFactor,

    rayParallel3D : rayParallel3D,
    rayParallel : rayParallel,
    rayIntersectionFactors : rayIntersectionFactors,
    rayIntersectionPoints : rayIntersectionPoints,
    rayIntersectionPoint : rayIntersectionPoint,
    rayIntersectionPointAccurate : rayIntersectionPointAccurate,

    pointContains : pointContains,
    pointDistance : pointDistance,
    pointClosestPoint : pointClosestPoint,

    boxIntersects : boxIntersects,
    boxDistance : boxDistance,
    boxClosestPoint : boxClosestPoint,
    boundingBoxGet : boundingBoxGet,

    capsuleClosestPoint : capsuleClosestPoint,

    frustumIntersects : frustumIntersects,
    frustumDistance : frustumDistance,
    frustumClosestPoint : frustumClosestPoint,

    lineClosestPoint : lineClosestPoint,

    planeIntersects : planeIntersects,
    planeDistance : planeDistance,
    planeClosestPoint : planeClosestPoint,

    rayIntersects : rayIntersects,
    rayDistance : rayDistance,
    rayClosestPoint : rayClosestPoint,

    segmentClosestPoint : segmentClosestPoint,

    sphereIntersects : sphereIntersects,
    sphereDistance : sphereDistance,
    sphereClosestPoint : sphereClosestPoint,
    boundingSphereGet : boundingSphereGet,
  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
