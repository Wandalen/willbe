( function _Line_test_s_( ) {

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
  var gotLine = _.line.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotLine = _.line.make( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotLine = _.line.make( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotLine = _.line.make( srcDim );
  var expected = [ 0, 1, 2, 3 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotLine = _.line.make( srcDim );
  var expected = [ 0,1,2,3 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.make( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.line.make( 'line' ));
}

//

function makeZero( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotLine = _.line.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotLine = _.line.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotLine = _.line.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotLine = _.line.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotLine = _.line.makeZero( srcDim );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.makeZero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.line.makeZero( 'line' ));

}

//

function makeNil( test )
{
  test.case = 'srcDim undefined'; /* */

  var srcDim = undefined;
  var gotLine = _.line.makeNil( srcDim );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim null'; /* */

  var srcDim = null;
  var gotLine = _.line.makeNil( srcDim );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim 2'; /* */

  var srcDim = 2;
  var gotLine = _.line.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim array'; /* */

  var srcDim = [ 0, 1, 2, 3 ];
  var gotLine = _.line.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  test.case = 'srcDim vector'; /* */

  var srcDim = _.vector.fromArray([ 0, 1, 2, 3 ]);
  var gotLine = _.line.makeNil( srcDim );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcDim );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.makeNil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.line.makeNil( 'line' ));
}

//

function zero( test )
{
  test.case = 'srcLine undefined'; /* */

  var srcLine = undefined;
  var gotLine = _.line.zero( srcLine );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine null'; /* */

  var srcLine = null;
  var gotLine = _.line.zero( srcLine );
  var expected = [ 0, 0, 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine 2'; /* */

  var srcLine = 2;
  var gotLine = _.line.zero( srcLine );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine array'; /* */

  var srcLine = [ 0, 1, 2, 3 ];
  var gotLine = _.line.zero( srcLine );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( gotLine, expected );
  test.is( gotLine === srcLine );

  test.case = 'srcLine vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotLine = _.line.zero( srcLine );
  var expected =  _.vector.fromArray( [ 0, 0, 0, 0 ] );
  test.identical( gotLine, expected );
  test.is( gotLine === srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.zero( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.line.zero( 'line' ));

}

//

function nil( test )
{
  test.case = 'srcLine undefined'; /* */

  var srcLine = undefined;
  var gotLine = _.line.nil( srcLine );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine null'; /* */

  var srcLine = null;
  var gotLine = _.line.nil( srcLine );
  var expected = [ Infinity, Infinity, Infinity, - Infinity, - Infinity, - Infinity ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine 2'; /* */

  var srcLine = 2;
  var gotLine = _.line.nil( srcLine );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotLine, expected );
  test.is( gotLine !== srcLine );

  test.case = 'srcLine array'; /* */

  var srcLine = [ 0, 1, 2, 3 ];
  var gotLine = _.line.nil( srcLine );
  var expected = [ Infinity, Infinity, - Infinity, - Infinity ];
  test.identical( gotLine, expected );
  test.is( gotLine === srcLine );

  test.case = 'srcLine vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotLine = _.line.nil( srcLine );
  var expected = _.vector.fromArray( [ Infinity, Infinity, - Infinity, - Infinity ] );
  test.identical( gotLine, expected );
  test.is( gotLine === srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.nil( [ 0, 0 ], [ 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.line.nil( 'line' ));
}

//

function from( test )
{
  test.case = 'Same instance returned - array'; /* */

  var srcLine = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0, 2, 2 ];

  var gotLine = _.line.from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine === gotLine );

  test.case = 'Different instance returned - vector -> array'; /* */

  var srcLine = _.vector.fromArray( [ 0, 0, 2, 2 ] );
  var expected = _.vector.fromArray( [ 0, 0, 2, 2 ] );

  var gotLine = _.line.from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine === gotLine );

  test.case = 'Same instance returned - empty array'; /* */

  var srcLine = [];
  var expected =  [];

  var gotLine = _.line.from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine === gotLine );

  test.case = 'Different instance returned - null -> array'; /* */

  var srcLine = null;
  var expected =  [ 0, 0, 0, 0, 0, 0 ];

  var gotLine = _.line.from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine !== gotLine );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.from( ));
  test.shouldThrowErrorSync( () => _.line.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.line.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.line.from( 'line' ));
  test.shouldThrowErrorSync( () => _.line.from( NaN ));
  test.shouldThrowErrorSync( () => _.line.from( undefined ));
}

//

function _from( test )
{
  test.case = 'Same instance returned - vector'; /* */

  var srcLine = [ 0, 0, 2, 2 ];
  var expected = _.vector.from( [ 0, 0, 2, 2 ] );

  var gotLine = _.line._from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine !== gotLine );

  test.case = 'Different instance returned - vector -> vector'; /* */

  var srcLine = _.vector.from( [ 0, 0, 2, 2 ] );
  var expected = _.vector.from( [ 0, 0, 2, 2 ] );

  var gotLine = _.line._from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine === gotLine );

  test.case = 'Same instance returned - empty vector'; /* */

  var srcLine = [];
  var expected =  _.vector.from( [] );

  var gotLine = _.line._from( srcLine );
  test.identical( gotLine, expected );
  test.is( srcLine !== gotLine );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line._from( ));
  test.shouldThrowErrorSync( () => _.line._from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.line._from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.line._from( 'line' ));
  test.shouldThrowErrorSync( () => _.line._from( NaN ));
  test.shouldThrowErrorSync( () => _.line._from( null ));
  test.shouldThrowErrorSync( () => _.line._from( undefined ));
}

//

function fromPair( test )
{
  test.case = 'Pair stay unchanged'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 2, 4 ] ];
  var expected = _.vector.from( [ 0, 1, 2, 0, 1, 2 ] );

  var gotLine = _.line.fromPair( pair );
  test.identical( gotLine, expected );

  var oldPair = [ [ 0, 1, 2 ], [ 0, 2, 4 ] ];
  test.identical( pair, oldPair );

  test.case = 'Line starts in origin'; /* */

  var pair = [ [ 0, 0, 0 ], [ 0, 1, 2 ] ];
  var expected = _.vector.from( [ 0, 0, 0, 0, 1, 2 ] );

  var gotLine = _.line.fromPair( pair );
  test.identical( gotLine, expected );

  test.case = 'Line is point'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 1, 2 ] ];
  var expected =  _.vector.from( [ 0, 1, 2, 0, 0, 0 ] );

  var gotLine = _.line.fromPair( pair );
  test.identical( gotLine, expected );

  test.case = 'Line of 1 dimension'; /* */

  var pair = [ [ 3 ], [ 4 ] ];
  var expected =  _.vector.from( [ 3, 1 ] );

  var gotLine = _.line.fromPair( pair );
  test.identical( gotLine, expected );

  test.case = 'Line goes up in y and down in z'; /* */

  var pair = [ [ 0, 1, 2 ], [ 0, 3, 1 ] ];
  var expected =  _.vector.from( [ 0, 1, 2, 0, 2, -1 ] );

  var gotLine = _.line.fromPair( pair );
  test.identical( gotLine, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.fromPair( ));
  test.shouldThrowErrorSync( () => _.line.fromPair( null ));
  test.shouldThrowErrorSync( () => _.line.fromPair( [ 2, 4 ], [ 3, 6 ] ));
  test.shouldThrowErrorSync( () => _.line.fromPair( [ 2, 4 ], [ 3, 6, 2 ] ));
  test.shouldThrowErrorSync( () => _.line.fromPair( [ [ 2, 4 ], [ 3, 6 ], [ 3, 6 ] ] ));
  test.shouldThrowErrorSync( () => _.line.fromPair( undefined ));

}

//

function is( test )
{
  debugger;
  test.case = 'array'; /* */

  test.is( _.line.is( [] ) );
  test.is( _.line.is([ 0, 0 ]) );
  test.is( _.line.is([ 1, 2, 3, 4 ]) );
  test.is( _.line.is([ 0, 0, 0, 0, 0, 0 ]) );

  test.case = 'vector'; /* */

  test.is( _.line.is( _.vector.fromArray([]) ) );
  test.is( _.line.is( _.vector.fromArray([ 0, 0 ]) ) );
  test.is( _.line.is( _.vector.fromArray([ 1, 2, 3, 4 ]) ) );
  test.is( _.line.is( _.vector.fromArray([ 0, 0, 0, 0, 0, 0 ]) ) );

  test.case = 'not line'; /* */

  test.is( !_.line.is([ 0 ]) );
  test.is( !_.line.is([ 0, 0, 0 ]) );

  test.is( !_.line.is( _.vector.fromArray([ 0 ]) ) );
  test.is( !_.line.is( _.vector.fromArray([ 0, 0, 0 ]) ) );

  test.is( !_.line.is( 'abc' ) );
  test.is( !_.line.is( { origin : [ 0, 0, 0 ], direction : [ 1, 1, 1 ] } ) );
  test.is( !_.line.is( function( a, b, c ){} ) );

  test.is( !_.line.is( null ) );
  test.is( !_.line.is( undefined ) );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.is( ));
  test.shouldThrowErrorSync( () => _.line.is( [ 0, 0 ], [ 1, 1 ] ));

}

//

function dimGet( test )
{
  test.case = 'srcLine 1D - array'; /* */

  var srcLine = [ 0, 1 ];
  var gotDim = _.line.dimGet( srcLine );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  test.case = 'srcLine 1D - vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1 ] );
  var gotDim = _.line.dimGet( srcLine );
  var expected = 1;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  test.case = 'srcLine 2D - array'; /* */

  var srcLine = [ 0, 1, 2, 3 ];
  var gotDim = _.line.dimGet( srcLine );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  test.case = 'srcLine 2D - vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotDim = _.line.dimGet( srcLine );
  var expected = 2;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  test.case = 'srcLine 3D - array'; /* */

  var srcLine = [ 0, 1, 2, 3, 4, 5 ];
  var gotDim = _.line.dimGet( srcLine );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  test.case = 'srcLine 3D - vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDim = _.line.dimGet( srcLine );
  var expected = 3;
  test.identical( gotDim, expected );
  test.is( gotDim !== srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.dimGet( ) );
  test.shouldThrowErrorSync( () => _.line.dimGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.dimGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.line.dimGet( 'line' ) );
  test.shouldThrowErrorSync( () => _.line.dimGet( 0 ) );
  test.shouldThrowErrorSync( () => _.line.dimGet( null ) );
  test.shouldThrowErrorSync( () => _.line.dimGet( undefined ) );

}

//

function originGet( test )
{
  test.case = 'Source line remains unchanged'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var gotOrigin = _.line.originGet( srcLine );
  test.identical( gotOrigin, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  test.case = 'srcLine 1D - array'; /* */

  var srcLine = [ 0, 1 ];
  var gotOrigin = _.line.originGet( srcLine );
  var expected = _.vector.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  test.case = 'srcLine 1D - vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1 ] );
  var gotOrigin = _.line.originGet( srcLine );
  var expected = _.vector.from( [ 0 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  test.case = 'srcLine 2D - array'; /* */

  var srcLine = [ 0, 1, 2, 3 ];
  var gotOrigin = _.line.originGet( srcLine );
  var expected = _.vector.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  test.case = 'srcLine 2D - vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotOrigin = _.line.originGet( srcLine );
  var expected = _.vector.from( [ 0, 1 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  test.case = 'srcLine 3D - array'; /* */

  var srcLine = [ 0, 1, 2, 3, 4, 5 ];
  var gotOrigin = _.line.originGet( srcLine );
  var expected = _.vector.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  test.case = 'srcLine 3D - vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotOrigin = _.line.originGet( srcLine );
  var expected = _.vector.from( [ 0, 1, 2 ] );
  test.identical( gotOrigin, expected );
  test.is( gotOrigin !== srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.originGet( ) );
  test.shouldThrowErrorSync( () => _.line.originGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.originGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.line.originGet( 'line' ) );
  test.shouldThrowErrorSync( () => _.line.originGet( 0 ) );
  test.shouldThrowErrorSync( () => _.line.originGet( null ) );
  test.shouldThrowErrorSync( () => _.line.originGet( undefined ) );

}

//

function directionGet( test )
{
  test.case = 'Source line remains unchanged'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 1, 1 ] );

  var gotDirection = _.line.directionGet( srcLine );
  test.identical( gotDirection, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  test.case = 'srcLine 1D - array'; /* */

  var srcLine = [ 0, 1 ];
  var gotDirection = _.line.directionGet( srcLine );
  var expected = _.vector.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  test.case = 'srcLine 1D - vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1 ] );
  var gotDirection = _.line.directionGet( srcLine );
  var expected = _.vector.from( [ 1 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  test.case = 'srcLine 2D - array'; /* */

  var srcLine = [ 0, 1, 2, 3 ];
  var gotDirection = _.line.directionGet( srcLine );
  var expected = _.vector.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  test.case = 'srcLine 2D - vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1, 2, 3 ] );
  var gotDirection = _.line.directionGet( srcLine );
  var expected = _.vector.from( [ 2, 3 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  test.case = 'srcLine 3D - array'; /* */

  var srcLine = [ 0, 1, 2, 3, 4, 5 ];
  var gotDirection = _.line.directionGet( srcLine );
  var expected = _.vector.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  test.case = 'srcLine 3D - vector'; /* */

  var srcLine = _.vector.fromArray( [ 0, 1, 2, 3, 4, 5 ] );
  var gotDirection = _.line.directionGet( srcLine );
  var expected = _.vector.from( [ 3, 4, 5 ] );
  test.identical( gotDirection, expected );
  test.is( gotDirection !== srcLine );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.directionGet( ) );
  test.shouldThrowErrorSync( () => _.line.directionGet( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.directionGet( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.line.directionGet( 'line' ) );
  test.shouldThrowErrorSync( () => _.line.directionGet( 0 ) );
  test.shouldThrowErrorSync( () => _.line.directionGet( null ) );
  test.shouldThrowErrorSync( () => _.line.directionGet( undefined ) );

}

//

function lineAt( test )
{
  test.case = 'Source line and factor remain unchanged'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var factor = 1;
  var expected = [ 1, 1 ];

  var gotPoint = _.line.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldFactor = 1;
  test.equivalent( factor, oldFactor );

  test.case = 'Factor = null, return origin'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var factor = 0;
  var expected = [ 0, 0 ];

  var gotPoint = _.line.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = 'Factor = 0, return origin'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var factor = 0;
  var expected = [ 0, 0 ];

  var gotPoint = _.line.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = 'Factor = 1, return origin + direction'; /* */

  var srcLine = [ 0, 1, 1, 1 ];
  var factor = 1;
  var expected = [ 1, 2 ];

  var gotPoint = _.line.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = '3D line'; /* */

  var srcLine = [ 0, 1, 2, 1, 1, 1 ];
  var factor = 1;
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.line.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = 'factor smaller than 1'; /* */

  var srcLine = [ 0, 1, 2, 2, 2, 2 ];
  var factor = 0.5;
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.line.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = 'factor bigger than one'; /* */

  var srcLine = [ 0, 1, 2, 1, 1, 1 ];
  var factor = 5;
  var expected = [ 5, 6, 7 ];

  var gotPoint = _.line.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  test.case = 'Negative factor'; /* */

  var srcLine = [ 0, 1, 2, 1, 1, 1 ];
  var factor = - 5;
  var expected = [ - 5, - 4, - 3 ];

  var gotPoint = _.line.lineAt( srcLine, factor );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.lineAt( ) );
  test.shouldThrowErrorSync( () => _.line.lineAt( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineAt( [ 0, 0 ], [ 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineAt( 'line', 1 ) );
  test.shouldThrowErrorSync( () => _.line.lineAt( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.line.lineAt( 0 ) );
  test.shouldThrowErrorSync( () => _.line.lineAt( null, 1 ) );
  test.shouldThrowErrorSync( () => _.line.lineAt( undefined, 1 ) );
  test.shouldThrowErrorSync( () => _.line.lineAt( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.lineAt( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function getFactor( test )
{

  test.case = 'Line and Point remain unchanged'; /* */

  var line = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = 1;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor, expected );

  var oldLine = [  - 1,  - 1 , 1, 1 ];
  test.identical( line, oldLine );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null line contains empty point'; /* */

  var line = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Point line contains Point'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Factor smaller than one'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0.5;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Factor bigger than one'; /* */

  var line = [ 0, 0, 0, 1, 1, 1 ];
  var point = [  6, 6, 6 ];
  var expected = 6;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Negative factor'; /* */

  var line = [ 0, 0, 0, 1, 1, 1 ];
  var point = [  - 6, - 6, - 6 ];
  var expected = - 6;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );


  test.case = 'Direction with different values'; /* */

  var line = [ 0, 0, 0, 1, 2, 3 ];
  var point = [  6, 12, 18 ];
  var expected = 6;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var line = [ 0, 0, 0, 1, 2, 0 ];
  var point = [  6, 12, 0 ];
  var expected = 6;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var line = [ 0, 0, 0, 0, 2, 3 ];
  var point = [  0, 12, 18 ];
  var expected = 6;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Direction with different values ( one of them 0 )'; /* */

  var line = [ 0, 0, 0, 1, 2, 0 ];
  var point = [  6, 12, 18];
  var expected = false;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Line under point'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = false;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Line ( normalized to 1 )'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = 1/ Math.sqrt( 2 );

  var gotFactor = _.line.getFactor( line, point );
  test.equivalent( gotFactor,  expected );

  test.case = 'Line of four dimensions'; /* */

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0, 0 ];
  var expected = 1;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Line of 7 dimensions'; /* */

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 1, -1, -1, -1, -1, -1, -1 ];
  var expected = 1;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Line of 1 dimension contains point'; /* */

  var line = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0.5;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );

  test.case = 'Line of 1 dimension always contains point '; /* */

  var line = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = - 1.5;

  var gotFactor = _.line.getFactor( line, point );
  test.identical( gotFactor,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.getFactor( ) );
  test.shouldThrowErrorSync( () => _.line.getFactor( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.getFactor( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.getFactor( [ 1, 1, 2, 2 ], 'factor') );
  test.shouldThrowErrorSync( () => _.line.getFactor( 0 ) );
  test.shouldThrowErrorSync( () => _.line.getFactor( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.getFactor( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.getFactor( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.getFactor( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.getFactor( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function lineParallel3D( test )
{
  test.case = 'Source lines and accuracySqr remain unchanged'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 2, 2, 2 ];
  var accuracySqr = 1E-10;
  var expected = true;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line, accuracySqr );
  test.identical( isParallel, expected );

  var oldSrc1Line = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  var oldAccuracySqr = 1E-10;
  test.equivalent( accuracySqr, oldAccuracySqr );

  test.case = 'Lines are the same'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( different origin - same direction )'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( different origin - different direction )'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 7, 7, 7 ];
  var expected = true;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( different origin - opposite direction )'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, - 7, - 7, - 7 ];
  var expected = true;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( src1Line is a point )'; /* */

  var src1Line = [ 3, 7, 1, 0, 0, 0 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( src2Line is a point )'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are not parallel ( same origin - different direction )'; /* */

  var src1Line = [ 3, 7, 1, 1, - 1, 1 ];
  var src2Line = [ 3, 7, 1, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are perpendicular'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = false;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel to x'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 1, 0, 0 ];
  var expected = true;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel but in a opposite direction'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, - 1, 0, 0 ];
  var expected = true;

  var isParallel = _.line.lineParallel3D( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.lineParallel3D( ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel3D( [ 0, 0, 0 ] ) );
   test.shouldThrowErrorSync( () => _.line.lineParallel3D( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel3D( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.line.lineParallel3D( 0 ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel3D( null, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel3D( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel3D( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel3D( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel3D( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel3D( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}


//

function lineParallel( test )
{
  test.case = 'Source lines and accuracySqr remain unchanged'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 2, 2, 2 ];
  var accuracySqr = 1E-10;
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line, accuracySqr );
  test.identical( isParallel, expected );

  var oldSrc1Line = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  var oldAccuracySqr = 1E-10;
  test.equivalent( accuracySqr, oldAccuracySqr );

  test.case = 'Lines are the same'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( different origin - same direction )'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( different origin - different direction )'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 7, 7, 7 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( different origin - opposite direction )'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, - 7, - 7, - 7 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( src1Line is a point )'; /* */

  var src1Line = [ 3, 7, 1, 0, 0, 0 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( src2Line is a point )'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel ( src2Line is a point - 4D )'; /* */

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1, 0, 0, 0, 0 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are not parallel ( same origin - different direction )'; /* */

  var src1Line = [ 3, 7, 1, 1, - 1, 1 ];
  var src2Line = [ 3, 7, 1, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are perpendicular'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = false;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel to x'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 1, 0, 0 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel but in a opposite direction'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, - 1, 0, 0 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel 2D'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, - 2, - 2 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are not parallel 2D'; /* */

  var src1Line = [ 3, 7, 1, - 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel 4D'; /* */

  var src1Line = [ 0, 0, 1, 1, 0, 1, 2, 3 ];
  var src2Line = [ 3, 7, - 2, - 2, 0, 2, 4, 6 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are not parallel 4D'; /* */

  var src1Line = [ 3, 7, 1, - 1, 3, 7, 1, - 1 ];
  var src2Line = [ 3, 7, 7, 7, 3, 7, 7, 7 ];
  var expected = false;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are parallel 6D'; /* */

  var src1Line = [ 0, 0, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5 ];
  var src2Line = [ 3, 7, - 2, - 2, 0, 0, 0, 2, 4, 6, 8, 10 ];
  var expected = true;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  test.case = 'Lines are not parallel 6D'; /* */

  var src1Line = [ 0, 0, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5 ];
  var src2Line = [ 3, 7, - 2, - 2, 0, 0, 0, 2, 8, 6, 8, 10 ];
  var expected = false;

  var isParallel = _.line.lineParallel( src1Line, src2Line );
  test.identical( isParallel, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.lineParallel( ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel( [ 0, 0, 0 ] ) );
   test.shouldThrowErrorSync( () => _.line.lineParallel( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel( [ 0, 0 ], 'factor') );
  test.shouldThrowErrorSync( () => _.line.lineParallel( 0 ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel( null, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.lineParallel( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineIntersectionFactors( test )
{
  test.case = 'Source lines remain unchanged'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 2, 2 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  var oldSrc1Line = [ 0, 0, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  test.case = 'Lines are the same'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 1, 1 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Lines are parallel ( different origin - same direction )'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Lines are parallel ( different origin - different direction )'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Lines intersect with negative factor'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 0, 2, -1 ];
  var expected = _.vector.from( [ 1, -1 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Lines intersect in their origin'; /* */

  var src1Line = [ 3, 7, 1, 0 ];
  var src2Line = [ 3, 7, 0, 1 ];
  var expected = _.vector.from( [ 0, 0 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Lines intersect '; /* */

  var src1Line = [ 0, 0, 1, 0 ];
  var src2Line = [ -2, -6, 1, 2 ];
  var expected = _.vector.from( [ 1, 3 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Lines are perpendicular '; /* */

  var src1Line = [ -3, 0, 1, 0 ];
  var src2Line = [ 0, -2, 0, 1 ];
  var expected = _.vector.from( [ 3, 2 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Lines 3D intersection'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 3, 3, 0, 1, 4 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Lines 3D intersection negative factors'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ - 3, - 3, - 3, 0, 1, 4 ];
  var expected = _.vector.from( [ - 3, 0 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Lines 3D intersection 3rd coordinate 0'; /* */

  var src1Line = [ 5, 5, 7, 0, 0, 1 ];
  var src2Line = [ 0, 0, 0, 4, 4, 4 ];
  var expected = _.vector.from( [ -2, 1.25 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );


  test.case = 'Lines 3D intersection 3rd coordinate 0'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 0 ];
  var src2Line = [ 3, 3, 0, 0, 1, 0 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Lines 3D no intersection'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 3, 5, 0, 1, 4 ];
  var expected = 0;

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Lines 4D intersection'; /* */

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 3, 3, 3, 0, 2, 1, 4 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  test.case = 'Lines 4D no intersection'; /* */

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 3, 5, 3, 0, 0, 1, 4 ];
  var expected = 0;

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Lines 4D no intersection out of 3D intersection'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1, 1, -1 ];
  var src2Line = [ 3, 3, 3, 2, 0, 1, 4, 3 ];
  var expected = 0;

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.identical( isIntersectionFactors, expected );

  test.case = 'Lines 8D intersection'; /* */

  var src1Line = [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1  ];
  var src2Line = [ 3, 3, 3, 3, 3, 3, 3, 3, 0, 2, 1, 4, 0, 2, 1, 4 ];
  var expected = _.vector.from( [ 3, 0 ] );

  var isIntersectionFactors = _.line.lineIntersectionFactors( src1Line, src2Line );
  test.equivalent( isIntersectionFactors, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( 0 ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionFactors( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineIntersectionPoints( test )
{
  test.case = 'Source lines remain unchanged'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 2, 2 ];
  var expected = [ [ 0, 0 ], [ 0, 0 ] ];

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  var oldSrc1Line = [ 0, 0, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  test.case = 'Lines are the same'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 1, 1 ];
  var expected = [ [ 0, 0 ], [ 0, 0 ] ];

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines are parallel ( different origin - same direction )'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines are parallel ( different origin - different direction )'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines intersect with negative factor'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 0, 2, -1 ];
  var expected = [ [ 1, 1 ], [ 1, 1 ] ];

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines intersect in their origin'; /* */

  var src1Line = [ 3, 7, 1, 0 ];
  var src2Line = [ 3, 7, 0, 1 ];
  var expected = [ [ 3, 7 ], [ 3, 7 ] ];

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines intersect '; /* */

  var src1Line = [ 0, 0, 1, 0 ];
  var src2Line = [ -2, -6, 1, 2 ];
  var expected = [ [ 1, 0 ], [ 1, 0 ] ];

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines are perpendicular '; /* */

  var src1Line = [ -3, 0, 1, 0 ];
  var src2Line = [ 0, -2, 0, 1 ];
  var expected = [ [ 0, 0 ], [ 0, 0 ] ];

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines don´t intersect 3D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines intersect 3D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 3, 1, 4 ];
  var expected = [ [ 9, 9, 9 ], [ 9, 9, 9 ] ];

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines 3D intersection 3rd coordinate 0'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 0 ];
  var src2Line = [ 3, 3, 0, 0, 1, 0 ];
  var expected = [ [ 3, 3, 0 ], [ 3, 3, 0 ] ];

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines don´t intersect 4D'; /* */

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  test.case = 'Lines intersect 4D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = [ [ 9, 9, 9, 10 ], [ 9, 9, 9, 10 ] ];

  var isIntersectionPoints = _.line.lineIntersectionPoints( src1Line, src2Line );
  test.identical( isIntersectionPoints, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( 0 ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoints( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineIntersectionPoint( test )
{
  test.case = 'Source lines remain unchanged'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  var oldSrc1Line = [ 0, 0, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  test.case = 'Lines are the same'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines are parallel ( different origin - same direction )'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines are parallel ( different origin - different direction )'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines intersect with negative factor'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 0, 2, -1 ];
  var expected = [ 1, 1 ];

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines intersect in their origin'; /* */

  var src1Line = [ 3, 7, 1, 0 ];
  var src2Line = [ 3, 7, 0, 1 ];
  var expected = [ 3, 7 ];

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines intersect '; /* */

  var src1Line = [ 0, 0, 1, 0 ];
  var src2Line = [ -2, -6, 1, 2 ];
  var expected = [ 1, 0 ];

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines are perpendicular '; /* */

  var src1Line = [ -3, 0, 1, 0 ];
  var src2Line = [ 0, -2, 0, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines don´t intersect 3D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines intersect 3D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 3, 1, 4 ];
  var expected = [ 9, 9, 9 ];

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines don´t intersect 4D'; /* */

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines intersect 4D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = [ 9, 9, 9, 10 ];

  var isIntersectionPoint = _.line.lineIntersectionPoint( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPoint( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineIntersectionPointAccurate( test )
{
  test.case = 'Source lines remain unchanged'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  var oldSrc1Line = [ 0, 0, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  test.case = 'Lines are the same'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines are parallel ( different origin - same direction )'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1 ];
  var expected = 0;

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines are parallel ( different origin - different direction )'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = 0;

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines intersect with negative factor'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 0, 2, -1 ];
  var expected = [ 1, 1 ];

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines intersect in their origin'; /* */

  var src1Line = [ 3, 7, 1, 0 ];
  var src2Line = [ 3, 7, 0, 1 ];
  var expected = [ 3, 7 ];

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines intersect '; /* */

  var src1Line = [ 0, 0, 1, 0 ];
  var src2Line = [ -2, -6, 1, 2 ];
  var expected = [ 1, 0 ];

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines are perpendicular '; /* */

  var src1Line = [ -3, 0, 1, 0 ];
  var src2Line = [ 0, -2, 0, 1 ];
  var expected = [ 0, 0 ];

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines don´t intersect 3D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines intersect 3D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 3, 1, 4 ];
  var expected = [ 9, 9, 9 ];

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines don´t intersect 4D'; /* */

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = 0;

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  test.case = 'Lines intersect 4D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = [ 9, 9, 9, 10 ];

  var isIntersectionPoint = _.line.lineIntersectionPointAccurate( src1Line, src2Line );
  test.identical( isIntersectionPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( 0 ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersectionPointAccurate( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function pointContains( test )
{

  test.case = 'Line and Point remain unchanged'; /* */

  var line = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool, expected );

  var oldLine = [  - 1,  - 1 , 1, 1 ];
  test.identical( line, oldLine );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null line contains empty point'; /* */

  var line = null;
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Point line contains Point'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Line contains point'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Line over point'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = false;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Point closer to origin'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, -2 , 0 ];
  var expected = false;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Point contained with negative factor'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 0, - 2 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Point not contained with negative factor'; /* */

  var line = [ 0, 0, 0, 1, 1, 1 ];
  var point = [ 0, 0, - 1 ];
  var expected = false;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Line ( normalized to 1 ) contains point'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Line ( normalized to 1 ) doesn´t contain point'; /* */

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = false;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Line of four dimensions contains point'; /* */

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Line of four dimensions doesn´t contain point'; /* */

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = false;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Line of 7Linemensions contains point'; /* */

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 1, -1, -1, -1, -1, -1, -1 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Line of 7 dimensions doesn´t contain point'; /* */

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ 0, 4, 3.5, 0, 5, 2, 2 ];
  var expected = false;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Line of 1 dimension contains point'; /* */

  var line = [ 0, 2 ];
  var point = [ 1 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Line of 1 dimension contains point with negative factor'; /* */

  var line = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Negative factor 2 dimensions'; /* */

  var line = [ 0, 0, 1, 1 ];
  var point = [ - 3, -3 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  test.case = 'Negative factor 3 dimensions'; /* */

  var line = [ 0, 0, 0, 1, 1, 2 ];
  var point = [ - 3, -3, -6 ];
  var expected = true;

  var gotBool = _.line.pointContains( line, point );
  test.identical( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.pointContains( ) );
  test.shouldThrowErrorSync( () => _.line.pointContains( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.pointContains( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.pointContains( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.line.pointContains( 0 ) );
  test.shouldThrowErrorSync( () => _.line.pointContains( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.pointContains( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.pointContains( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.pointContains( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.pointContains( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function pointDistance( test )
{

  test.case = 'Line and Point remain unchanged'; /* */

  var line = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = 0;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance, expected );

  var oldLine = [  - 1,  - 1 , 1, 1 ];
  test.identical( line, oldLine );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null line Distance empty point'; /* */

  var line = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Point line Distance same Point'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Point line Distance other Point'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 3, 4, 0 ];
  var expected = 5;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Line contains point'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Line contains point with negative factor'; /* */

  var line = [ 0, 0, 0, 2, 2, - 2 ];
  var point = [  - 1, - 1, 1 ];
  var expected = 0;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Line over point'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = 1;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Point closer to origin'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, -2, 0 ];
  var expected = 2;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Point with negative factor'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 0, -2 ];
  var expected = 0;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Line ( normalized to 1 ) Distance point'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = 0;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Line ( normalized to 1 ) doesn´t contain point'; /* */

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = 0.568342039793567;

  var gotDistance = _.line.pointDistance( line, point );
  test.equivalent( gotDistance,  expected );

  test.case = 'Line of four dimensions distance '; /* */

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 4 ];
  var expected = Math.sqrt( 12 );

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Line of 7 dimensions distance'; /* */

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 0, 0, 0, 0, 0, 0, 1 ];
  var point = [ 2, 2, 2, 2, 2, 2, 2 ];
  var expected = Math.sqrt( 96 );

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  test.case = 'Line of 1 dimension contains point'; /* */

  var line = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0;

  var gotDistance = _.line.pointDistance( line, point );
  test.identical( gotDistance,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.pointDistance( ) );
  test.shouldThrowErrorSync( () => _.line.pointDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.pointDistance( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.pointDistance( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.line.pointDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.line.pointDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.pointDistance( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.pointDistance( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.pointDistance( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.pointDistance( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function pointClosestPoint( test )
{

  test.case = 'Line and Point remain unchanged'; /* */

  var line = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = [ 0, 0 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint, expected );

  var oldLine = [  - 1,  - 1 , 1, 1 ];
  test.identical( line, oldLine );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null line - empty point'; /* */

  var line = null;
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Point line - same Point'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Point line - other Point'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var point = [ 3, 4, 0 ];
  var expected = [ 1, 2, 3 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line contains point'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 1 ];
  var expected = [ 1, 1, 1 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line over point'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var point = [ 0, 1, 4 ];
  var expected = [ 0, 0, 4 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Point with negative factor'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 2, - 2, - 2 ];
  var expected = [ - 2, - 2, - 2 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line ( normalized to 1 ) Distance point'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var point = [ 0.500, 0.500, 0.000 ];
  var expected = [ 0.5, 0.5, 0 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line ( normalized to 1 ) doesn´t contain point'; /* */

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = [ 0.02572500470627867, 0.10157398765468795, 0.10157398765468795 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.equivalent( gotClosestPoint,  expected );

  test.case = 'Line of four dimensions distance '; /* */

  var line = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 4 ];
  var expected = [ 1, 1, 1, 1 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line of 7 dimensions distance'; /* */

  var line = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 0, 0, 0, 0, 0, 0, 1 ];
  var point = [ 2, 2, 2, 2, 2, 2, 2 ];
  var expected = [ - 2, - 2, - 2, - 2, - 2, - 2, 2 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line of 1 dimension contains point'; /* */

  var line = [ 0, 2 ];
  var point = [ 1 ];
  var expected = [ 1 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line of 1 contains point with negative factor'; /* */

  var line = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = [ - 3 ];

  var gotClosestPoint = _.line.pointClosestPoint( line, point );
  test.identical( gotClosestPoint,  expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.pointClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.line.pointClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.pointClosestPoint( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.pointClosestPoint( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.line.pointClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.line.pointClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.pointClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.pointClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.pointClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.pointClosestPoint( [ 1, 1, 2, 2 ], [ 1, 2, 3, 4 ] ) );

}

//

function boxIntersects( test )
{

  test.case = 'Line and box remain unchanged'; /* */

  var line = [  - 1,  - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  test.case = 'Null line - empty box'; /* */

  var line = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );

  test.case = 'box line - same box'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );

  test.case = 'point line - no intersection'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = false;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );

  test.case = 'point line in box'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = true;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );

  test.case = 'Line and box intersect'; /* */

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );

  test.case = 'Line over box'; /* */

  var line = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = false;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );

  test.case = 'box closer to origin'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 3, -1, -1, - 2 ];
  var expected = true;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );

  test.case = 'box with negative factor'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = true;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );

  test.case = 'Line ( normalized to 1 ) intersection'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = true;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );

  test.case = 'Line ( normalized to 1 ) doesn´t contain box'; /* */

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, - 0.303 ];
  var expected = false;

  var gotBool = _.line.boxIntersects( line, box );
  test.equivalent( gotBool,  expected );

  test.case = '2D intersection'; /* */

  var line = [ 0, 0, 2, 2 ];
  var box = [ 1, 2, 3, 4 ];
  var expected = true;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );

  test.case = '2D no intersection'; /* */

  var line = [ 0, 0, 2, -2 ];
  var box = [ 1, 2, 3, 4 ];
  var expected = false;

  var gotBool = _.line.boxIntersects( line, box );
  test.identical( gotBool,  expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.boxIntersects( ) );
  test.shouldThrowErrorSync( () => _.line.boxIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.boxIntersects( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.boxIntersects( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.line.boxIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.line.boxIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.boxIntersects( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.boxIntersects( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.boxIntersects( [ 1, 1, 2, 2 ], - 2 ) );

}

//

function boxDistance( test )
{
  test.case = 'Line and box remain unchanged'; /* */

  var line = [  - 1,  - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.line.boxDistance( line, box );
  test.identical( gotBool, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  test.case = 'Null line - empty box'; /* */

  var line = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.line.boxDistance( line, box );
  test.identical( gotBool,  expected );

  test.case = 'box line - same box'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.line.boxDistance( line, box );
  test.identical( gotBool,  expected );

  test.case = 'point line'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 5 ];
  var expected = 1;

  var gotBool = _.line.boxDistance( line, box );
  test.identical( gotBool,  expected );

  test.case = 'point line in box'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = 0;

  var gotBool = _.line.boxDistance( line, box );
  test.identical( gotBool,  expected );

  test.case = 'Line and box intersect'; /* */

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBool = _.line.boxDistance( line, box );
  test.identical( gotBool,  expected );

  test.case = 'Line over box'; /* */

  var line = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = 1;

  var gotBool = _.line.boxDistance( line, box );
  test.identical( gotBool,  expected );

  test.case = 'box corner is in line with negative factor'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = 0;

  var gotBool = _.line.boxDistance( line, box );
  test.identical( gotBool,  expected );

  test.case = 'box corner closer to origin'; /* */

  var line = [ 2, 2, 2, - 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = Math.sqrt( 24/9 );

  var gotBool = _.line.boxDistance( line, box );
  test.equivalent( gotBool,  expected );

  test.case = 'Line ( normalized to 1 ) intersection'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = 0;

  var gotBool = _.line.boxDistance( line, box );
  test.identical( gotBool, expected );

  test.case = 'Line ( normalized to 1 ) doesn´t contain box'; /* */

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, 0.303 ];
  var expected = 0.04570949385069674;

  var gotBool = _.line.boxDistance( line, box );
  test.equivalent( gotBool,  expected );

  test.case = '2D'; /* */

  var line = [ 2, 0, 2, 2 ];
  var box = [ 0, 0, 1, 1 ];
  var expected = Math.sqrt( 0.5 );

  var gotBool = _.line.boxDistance( line, box );
  test.identical( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.boxDistance( ) );
  test.shouldThrowErrorSync( () => _.line.boxDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.boxDistance( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.boxDistance( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.line.boxDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.line.boxDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.boxDistance( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.boxDistance( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.boxDistance( [ 1, 1, 2, 2 ], - 2 ) );

}

//

function boxClosestPoint( test )
{
  test.case = 'Line and box remain unchanged'; /* */

  var line = [  - 1,  - 1, -1, 1, 1, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldBox );

  test.case = 'Null line - empty box'; /* */

  var line = null;
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  test.case = 'box line - same box'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  test.case = 'point line'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 4, 3, 4, 0 ];
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  test.case = 'point line in box'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var box = [ 1, 2, 2, 3, 4, 4 ];
  var expected = 0;

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  test.case = 'Line and box intersect'; /* */

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  test.case = 'Line over box - negative factor'; /* */

  var line = [ 0, 0, 4, 0, 0, 2 ];
  var box = [ 0, 1, 1, 3, 7, 3 ];
  var expected = [ 0, 0, 1 ];

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  test.case = 'box corner - negative factor'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ - 2, - 2, - 2, -1, -1, -1 ];
  var expected = 0;

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  test.case = 'box corner closer to origin'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ 0, - 2, 0, 1, -1, 1 ];
  var expected = [ - 1/3, - 1/3, - 1/3 ];

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  test.case = 'box corner not close to origin'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var box = [ 6, 7, 8, 6, 9, 10 ];
  var expected = [ 7, 7, 7 ];

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  test.case = 'Line ( normalized to 1 ) intersection'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var box = [ 0.500, 0.123, 0, 0.734, 0.900, 0.837 ];
  var expected = 0;

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  test.case = 'Line ( normalized to 1 ) doesn´t contain box'; /* */

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var box = [ 0.12322, 0.03232, 0, 0.050, 0.500, - 0.303 ];
  var expected = [ 0.005519293548276563, 0.021792674525669315, 0.021792674525669315 ];

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.equivalent( gotPoint,  expected );

  test.case = '2D'; /* */

  var line = [ 0, 0, 2, 1 ];
  var box = [ 6, 7, 10, 8 ];
  var expected = [ 10.8, 5.4 ];

  var gotPoint = _.line.boxClosestPoint( line, box );
  test.identical( gotPoint,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.boxClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.line.boxClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.boxClosestPoint( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.boxClosestPoint( [ 1, 1, 2, 2 ], 'box') );
  test.shouldThrowErrorSync( () => _.line.boxClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.line.boxClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.boxClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.boxClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.boxClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );

}

//

function boundingBoxGet( test )
{

  test.case = 'Source line remains unchanged'; /* */

  var srcLine = [ 0, 0, 0, 3, 3, 3 ];
  var dstBox = [ 1, 1, 1, 2, 2, 2 ];
  var expected = [ - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( expected, gotBox );
  test.is( dstBox === gotBox );

  var oldSrcLine = [ 0, 0, 0, 3, 3, 3 ];
  test.identical( srcLine, oldSrcLine );

  test.case = 'Empty'; /* */

  var srcLine = [ ];
  var dstBox = [ ];
  var expected = [ ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  test.case = 'Zero line to zero box'; /* */

  var srcLine = [ 0, 0, 0, 0, 0, 0 ];
  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  test.case = 'Line inside box'; /* */

  var srcLine = [ 1, 1, 1, 4, 4, 4 ];
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = [ - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  test.case = 'Line outside Box'; /* */

  var srcLine = [ - 1, - 1, - 1, 1, 2, 3 ];
  var dstBox = [ - 3, - 4, - 5, - 5, - 4, - 2 ];
  var expected = [  - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  test.case = 'Point line and point Box'; /* */

  var srcLine = [ 1, 2, 3, 0, 0, 0 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = [ 1, 2, 3, 1, 2, 3 ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  test.case = 'Negative line direction'; /* */

  var srcLine = [ 1, 2, 3, - 3, - 2, - 1 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = [ - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  test.case = 'Mixed directions'; /* */

  var srcLine = [ 1, 2, 3, - 1, 0, 1 ];
  var dstBox = [ 3, 3, 3, 4, 4, 4 ];
  var expected = [ - Infinity, 2, - Infinity, Infinity, 2, Infinity ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  test.case = 'srcLine vector'; /* */

  var srcLine = _.vector.from( [ - 8, - 5, 4.5, 4, 7, 16.5 ] );
  var dstBox = [ 1, - 1, 5, 0, 3, 2 ];
  var expected = [  - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  test.case = 'dstBox vector - 2D'; /* */

  var srcLine = [ - 1, 0, - 2, 3 ];
  var dstBox = _.vector.from( [ 1, 2, 3, 9 ] );
  var expected = _.vector.from( [ - Infinity, - Infinity, Infinity, Infinity ] );

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  test.case = 'dstBox null'; /* */

  var srcLine = [ 2.2, 3.3, - 4.4, 0 ];
  var dstBox = null;
  var expected = [ - Infinity, 3.3, Infinity, 3.3 ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.equivalent( gotBox, expected );

  test.case = 'dstBox undefined'; /* */

  var srcLine = [ - 1, - 3, 0, 1 ];
  var dstBox = undefined;
  var expected = [  -1, - Infinity, - 1, Infinity ];

  var gotBox = _.line.boundingBoxGet( dstBox, srcLine );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.boundingBoxGet( ) );
  test.shouldThrowErrorSync( () => _.line.boundingBoxGet( [] ) );
  test.shouldThrowErrorSync( () => _.line.boundingBoxGet( 'box', 'line' ) );
  test.shouldThrowErrorSync( () => _.line.boundingBoxGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.boundingBoxGet( [ 1, 0, 1, 2, 1, 2 ], [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.line.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4, 5 ] ) );
  test.shouldThrowErrorSync( () => _.line.boundingBoxGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.line.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.line.boundingBoxGet( [ 0, 1, 0, 1, 2 ], [ 0, 0, 1 ] ) );

}

//

function capsuleClosestPoint( test )
{
  test.case = 'Line and capsule remain unchanged'; /* */

  var line = [  - 1,  - 1, -1, 1, 1, 1 ];
  var capsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.line.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.identical( capsule, oldCapsule );

  test.case = 'capsule line - same capsule'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var capsule = [ 0, 0, 0, 0, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.line.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'point line'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var capsule = [ 1, 2, 4, 3, 4, 0, 0.5 ];
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.line.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'point line in capsule'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var capsule = [ 1, 2, 2, 3, 4, 4, 1 ];
  var expected = 0;

  var gotPoint = _.line.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'Line and capsule intersect'; /* */

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.5 ];
  var expected = 0;

  var gotPoint = _.line.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'Line over capsule - negative factor'; /* */

  var line = [ 0, 0, 4, 0, 0, 2 ];
  var capsule = [ 0, 1, 1, 3, 7, 3, 0.2 ];
  var expected = [ 0, 0, 1 ];

  var gotPoint = _.line.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'capsule corner - negative factor'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var capsule = [ - 2, - 2, - 2, -1, -1, -1, 1 ];
  var expected = 0;

  var gotPoint = _.line.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint,  expected );

  test.case = 'capsule corner closer to origin'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var capsule = [ 0, - 2, 0, 1, -1, 1, 0.2 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.line.capsuleClosestPoint( line, capsule );
  test.equivalent( gotPoint,  expected );

  test.case = 'capsule corner not close to origin'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var capsule = [ 6, 7, 8, 6, 9, 10, 1 ];
  var expected = [ 7, 7, 7 ];

  var gotPoint = _.line.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint,  expected );

  test.case = '2D'; /* */

  var line = [ 0, 0, 2, 1 ];
  var capsule = [ 6, 7, 10, 8, 0.1 ];
  var expected = [ 11.2, 5.6 ];

  var gotPoint = _.line.capsuleClosestPoint( line, capsule );
  test.identical( gotPoint,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( 'line', [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( [ 1, 1, 2, 2 ], 'capsule') );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( undefined, [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( null, [ 1, 1, 2, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.capsuleClosestPoint( [ 1, 1, 2, 2 ], [ 1, 1, 2, 2, - 1 ] ) );

}

//

function frustumIntersects( test )
{

  test.description = 'Line and frustum remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 1, 1, 1, 3, 3, 3 ];
  var expected = true;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  var oldLine = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( line, oldLine );

  var oldFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( srcFrustum, oldFrustum );


  test.description = 'Frustum and line intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line intersect on frustum corner'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 2, 2, 0, - 1, -1, 1 ];
  var expected = true;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum corner is line origin'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 1, 1, 1, 0, 0, 2 ];
  var expected = true;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line intersect on frustum side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ -1, -1, 0, 0.5, 0.5, 0 ];
  var expected = true;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Negative factor'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 4, 4, 4, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line not intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 4, 4, 4, 5, 5, 0 ];
  var expected = false;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line almost intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 1.1, 1.1, 4.1, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line just touching'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 1, 1, 1, 5 , 5, 5 ];
  var expected = true;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and line just intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 0.9, 0.9, 0.9, 5, 5, 5 ];
  var expected = true;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'line is null - intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = null;
  var expected = true;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
  test.identical( gotBool, expected );

  test.description = 'line is null - no intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var line = null;
  var expected = false;

  var gotBool = _.line.frustumIntersects( line, srcFrustum );
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

  test.shouldThrowErrorSync( () => _.line.frustumIntersects( ));
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( line ));
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( srcFrustum ));
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( line, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( line, line, srcFrustum ));
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( null, line ));
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( NaN, line ));
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( srcFrustum, NaN));

  line = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.line.frustumIntersects( line, srcFrustum ));

}

//

function frustumDistance( test )
{

  test.description = 'Line and frustum remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 1, 1, 1, 3, 3, 3 ];
  var expected = 0;

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  var oldLine = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( line, oldLine );

  var oldFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum and line intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and line intersect on frustum corner'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 2, 2, 0, - 1, -1, 1 ];
  var expected = 0;

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and line intersect on frustum side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ -1, -1, 0, 0.5, 0.5, 0 ];
  var expected = 0;

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Negative factor'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 4, 4, 4, 5, 5, 5 ];
  var expected = 0;

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and line not intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 4, 4, 4, 1, 1, 0 ];
  var expected = 3;

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'Frustum and line almost intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 1.1, 1.1, 1.1, 5, 5, 0 ];
  var expected = 0.1;

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'line is null - intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = null;
  var expected = 0;

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'line is null - no intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var line = null;
  var expected = Math.sqrt( 0.75 );

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
  test.identical( gotDistance, expected );

  test.description = 'line closest to box side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var line = [ - 2, 0.3, 0, 1, 0, 0 ];
  var expected = Math.sqrt( 0.29 );

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Inclined line closest to box side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var line = [ -2, 0.3, 0, 1, 0, 0.1 ];
  var expected = 0.2821417381318113;

  var gotDistance = _.line.frustumDistance( line, srcFrustum );
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

  test.shouldThrowErrorSync( () => _.line.frustumDistance( ));
  test.shouldThrowErrorSync( () => _.line.frustumDistance( line ));
  test.shouldThrowErrorSync( () => _.line.frustumDistance( srcFrustum ));
  test.shouldThrowErrorSync( () => _.line.frustumDistance( line, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.line.frustumDistance( line, line, srcFrustum ));
  test.shouldThrowErrorSync( () => _.line.frustumDistance( null, line ));
  test.shouldThrowErrorSync( () => _.line.frustumDistance( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.line.frustumDistance( NaN, line ));
  test.shouldThrowErrorSync( () => _.line.frustumDistance( srcFrustum, NaN));

  line = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.line.frustumDistance( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.line.frustumDistance( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.line.frustumDistance( line, srcFrustum ));

}

//

function frustumClosestPoint( test )
{

  test.description = 'Line and frustum remain unchanged'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 1, 1, 1, 3, 3, 3 ];
  var expected = 0;

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  var oldLine = [ 1, 1, 1, 3, 3, 3 ];
  test.identical( line, oldLine );

  var oldFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum and line intersect'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and line intersect on frustum corner'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 2, 2, 0, - 1, -1, 1 ];
  var expected = 0;

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and line intersect on frustum side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ -1, -1, 0, 0.5, 0.5, 0 ];
  var expected = 0;

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Negative factor'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 4, 4, 4, 5, 5, 5 ];
  var expected = 0;

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Frustum and line not intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 4, 4, 4, 5, 5, 0 ];
  var expected = [ 1, 1, 4 ];

  test.description = 'Frustum and line almost intersecting'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = [ 1.1, 1.1, 1.1, 5, 5, 0 ];
  var expected = [ 1, 1, 1.1 ];

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum );
  test.equivalent( gotClosestPoint, expected );

  test.description = 'line is null - intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var line = null;
  var expected = 0;

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'line is null - no intersection'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var line = null;
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'line closest to box side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var line = [ - 2, 0.3, 0, 1, 0, 0 ];
  var expected = [ 0.5, 0.3, 0 ];

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Inclined line closest to box side'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var line = [ -2, 0.3, 0, 1, 0, 0.1 ];
  var expected = [ 1.0198019801980198, 0.3, 0.301980198019802 ];

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum );
  test.identical( gotClosestPoint, expected );

  test.description = 'Destination point is vector'; //

  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1, 0.5, - 1, 0.5, 0.5, - 1
  ]);
  var line = [ 0, 2, 2, - 1, - 1, - 1 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ -0.5, 1.5, 1.5 ] );

  var gotClosestPoint = _.line.frustumClosestPoint( line, srcFrustum, dstPoint );
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

  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( ));
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( line ));
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( srcFrustum ));
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( line, srcFrustum, srcFrustum ));
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( line, line, srcFrustum ));
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( null, line ));
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( srcFrustum, null));
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( NaN, line ));
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( srcFrustum, NaN));

  line = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( line, srcFrustum ));
  line = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.line.frustumClosestPoint( line, srcFrustum ));

}

//

function lineIntersects( test )
{
  test.case = 'Source lines remain unchanged'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 2, 2 ];
  var expected = true;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  var oldSrc1Line = [ 0, 0, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  test.case = 'Lines are the same'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 0, 0, 1, 1 ];
  var expected = true;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  test.case = 'Lines are parallel ( different origin - same direction )'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 1, 1 ];
  var expected = false;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  test.case = 'Lines are parallel ( different origin - different direction )'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 7, 7, 7 ];
  var expected = false;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  test.case = 'Lines intersect with negative factor'; /* */

  var src1Line = [ 0, 0, 1, 1 ];
  var src2Line = [ 3, 0, 2, -1 ];
  var expected = true;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  test.case = 'Lines intersect in their origin'; /* */

  var src1Line = [ 3, 7, 1, 0 ];
  var src2Line = [ 3, 7, 0, 1 ];
  var expected = true;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  test.case = 'Lines intersect '; /* */

  var src1Line = [ 0, 0, 1, 0 ];
  var src2Line = [ -2, -6, 1, 2 ];
  var expected = true;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  test.case = 'Lines are perpendicular '; /* */

  var src1Line = [ -3, 0, 1, 0 ];
  var src2Line = [ 0, -2, 0, 1 ];
  var expected = true;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  test.case = 'Lines don´t intersect 3D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  test.case = 'Lines intersect 3D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 3, 1, 4 ];
  var expected = true;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  test.case = 'Lines don´t intersect 4D'; /* */

  var src1Line = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var src2Line = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  test.case = 'Lines intersect 4D'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = true;

  var isIntersection = _.line.lineIntersects( src1Line, src2Line );
  test.identical( isIntersection, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.lineIntersects( ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersects( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersects( [ 1, 1, 2, 2 ], 'line') );
  test.shouldThrowErrorSync( () => _.line.lineIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersects( null, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersects( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersects( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersects( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.lineIntersects( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineDistance( test )
{
  test.case = 'Source lines remain unchanged'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  var oldSrc1Line = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  test.case = 'Lines are the same'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines are parallel ( different origin - same direction )'; /* */

  var src1Line = [ 0, 0, 0, 0, 0, 1 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = Math.sqrt( 58 );

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines are parallel ( different origin - different direction )'; /* */

  var src1Line = [ 0, 0, 0, 0, 0, 0.5 ];
  var src2Line = [ 3, 7, 1, 0, 0, 7 ];
  var expected = Math.sqrt( 58 );

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines are parallel ( different origin - opposite direction )'; /* */

  var src1Line = [ 0, 0, 0, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = Math.sqrt( 50 );

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'src1Line is a point'; /* */

  var src1Line = [ 3, 7, 1, 0, 0, 0 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 4.320493798938574;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines are the same'; /* */

  var src1Line = [ 0, 4, 2, 1, 1, 1 ];
  var src2Line = [ 0, 4, 2, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines intersect 4D'; /* */

  var src1Line = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var src2Line = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines intersect with negative factor 3D'; /* */

  var src1Line = [ 0, 0, 0, 3, 2, 1 ];
  var src2Line = [ - 3, - 4, -4, 0, -1, -1.5 ];
  var expected = 0;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines intersect with negative factor'; /* */

  var src1Line = [ 0, 0, 2, 0 ];
  var src2Line = [ - 3, - 4, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines don´t intersect 2D'; /* */

  var src1Line = [ 0, 0, 2, 0 ];
  var src2Line = [ - 3, - 4, 1, 0 ];
  var expected = 4;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines are perpendicular and intersect'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines are perpendicular and don´t intersect'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, -2, 1, 0, 0, 1 ];
  var expected = 9;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines are parallel to x'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 2, 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'Lines are parallel but in a opposite direction'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  test.case = 'srcLine is null'; /* */

  var src1Line = null;
  var src2Line = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = Math.sqrt( 53 );

  var gotDistance = _.line.lineDistance( src1Line, src2Line );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.lineDistance( ) );
  test.shouldThrowErrorSync( () => _.line.lineDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineDistance( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineDistance( [ 0, 0 ], 'line') );
  test.shouldThrowErrorSync( () => _.line.lineDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.line.lineDistance( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.lineDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.lineDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.lineDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function lineClosestPoint( test )
{
  test.case = 'Source lines remain unchanged'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 0, 0, 0, 2, 2, 2 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  var oldSrc1Line = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( src1Line, oldSrc1Line );

  var oldSrc2Line = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( src2Line, oldSrc2Line );

  test.case = 'Lines are parallel ( different origin - same direction )'; /* */

  var src1Line = [ 0, 0, 0, 0, 0, 1 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = [ 0, 0, 1 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'Lines are parallel ( different origin - different direction )'; /* */

  var src1Line = [ 3, 7, 1, 0, 0, 7 ];
  var src2Line = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = [ 3, 7, 0 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'Lines are parallel ( different origin - opposite direction )'; /* */

  var src1Line = [ 0, 0, 0, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = [ 3, 0, 0 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'src1Line is a point - in srcLine1'; /* */

  var src1Line = [ 3, 7, 1, 0, 0, 0 ];
  var src2Line = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'src1Line is a point - in srcLine2'; /* */

  var src1Line = [ 0, 0, 0, 1, 1, 1 ];
  var src2Line = [ 3, 7, 1, 0, 0, 0 ];
  var expected = [ 3.6666666, 3.6666666, 3.6666666 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Lines are the same'; /* */

  var src1Line = [ 0, 4, 2, 1, 1, 1 ];
  var src2Line = [ 0, 4, 2, 1, 1, 1 ];
  var expected = [ 0, 4, 2 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'Lines intersect 4D'; /* */

  var src1Line = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var src2Line = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = [ 0, 4, 2, 1 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'Lines don´t intersect 2D - parallel'; /* */

  var src1Line = [ 0, 0, 2, 0 ];
  var src2Line = [ - 3, - 4, 1, 0 ];
  var expected = [ -3, 0 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'Lines intersect with negative factor 2D'; /* */

  var src1Line = [ 0, 0, 2, 0 ];
  var src2Line = [ - 3, - 4, 0, 1 ];
  var expected = [ -3, 0 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'Lines are perpendicular and intersect'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 1, 0, 0, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'Lines are perpendicular and don´t intersect'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, -2, 1, 0, 0, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'Lines are parallel to x'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 2, 1, 0, 0 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'Lines are parallel but in a opposite direction'; /* */

  var src1Line = [ 3, 7, 1, 1, 0, 0 ];
  var src2Line = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  test.case = 'srcLine is null'; /* */

  var src1Line = null;
  var src2Line = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.lineClosestPoint( src1Line, src2Line );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.lineClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.line.lineClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineClosestPoint( [ 0, 0 ], 'line') );
  test.shouldThrowErrorSync( () => _.line.lineClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.line.lineClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.lineClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function planeIntersects( test )
{

  test.case = 'Line and plane remain unchanged'; /* */

  var line = [  - 1,  - 1, -1, 1, 1, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  test.case = 'Null line'; /* */

  var line = null;
  var plane = [ 1, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  test.case = 'point line - no intersection'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  test.case = 'point line in plane'; /* */

  var line = [ - 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  test.case = 'Line and plane intersect'; /* */

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  test.case = 'Negative factor'; /* */

  var line = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ 1, 0, 0, 3 ];
  var expected = true;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  test.case = 'Line ( normalized to 1 ) intersection'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var plane = [ 0, 2, 0, - 2 ];
  var expected = true;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  test.case = 'Line ( normalized to 1 ) no intersection'; /* */

  var line = [ 0, 0, 0, 0, 0.194, 0 ];
  var plane = [ 3, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.line.planeIntersects( line, plane );
  test.equivalent( gotBool,  expected );

  test.case = 'plane parallel to line'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0.5 ];
  var expected = false;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  test.case = 'plane parallel contains line'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  test.case = 'plane perpendicular to line'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = true;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  test.case = 'plane parallel to line 4D'; /* */

  var line = [ 0, 2, 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0, 0 ];
  var expected = false;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  test.case = 'plane parallel to line 4D'; /* */

  var line = [ 0, 2, 0, 0, 1, 0, 1, 2 ];
  var plane = [ 0, 1, 0, 0, 0 ];
  var expected = false;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );


  test.case = 'plane perpendicular to line'; /* */

  var line = [ 0, 0, 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 0, 1, 0 ];
  var expected = true;

  var gotBool = _.line.planeIntersects( line, plane );
  test.identical( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.planeIntersects( ) );
  test.shouldThrowErrorSync( () => _.line.planeIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.planeIntersects( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], 'plane') );
  test.shouldThrowErrorSync( () => _.line.planeIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.line.planeIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.planeIntersects( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function planeDistance( test )
{

  test.case = 'Line and plane remain unchanged'; /* */

  var line = [  - 1,  - 1, -1, 1, 1, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  test.case = 'Null line - empty plane'; /* */

  var line = null;
  var plane = [ 1, 0, 0, 1 ];
  var expected = 1;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );

  test.case = 'point line - no intersection'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 2;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );

  test.case = 'point line in plane'; /* */

  var line = [ - 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );

  test.case = 'Line and plane intersect'; /* */

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );

  test.case = 'Negative factor'; /* */

  var line = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ 1, 0, 0, 3 ];
  var expected = 0;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );

  test.case = 'Line ( normalized to 1 ) intersection'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var plane = [ 0, 2, 0, - 2 ];
  var expected = 0;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );

  test.case = 'plane parallel to line'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0.5 ];
  var expected = 0.5;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );

  test.case = 'plane parallel to line opposite side'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, - 1, 0, 0.5 ];
  var expected = 0.5;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );


  test.case = 'plane parallel contains line'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );

  test.case = 'plane perpendicular to line'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = 0;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );


  test.case = 'plane parallel to line 4D'; /* */

  var line = [ 1, 2, 3, 4, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0, 0 ];
  var expected = 2;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );

  test.case = 'plane perpendicular to line 4D'; /* */

  var line = [ 0, 0, 0, 0, 0, 0, 2, 0 ];
  var plane = [ 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.line.planeDistance( line, plane );
  test.identical( gotDistance,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.planeDistance( ) );
  test.shouldThrowErrorSync( () => _.line.planeDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.planeDistance( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.planeDistance( [ 1, 1, 1, 2, 2, 2 ], 'plane') );
  test.shouldThrowErrorSync( () => _.line.planeDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.line.planeDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.planeDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.planeDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.planeDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.planeDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function planeClosestPoint( test )
{

  test.case = 'Line and plane remain unchanged'; /* */

  var line = [  - 1,  - 1, -1, 1, 1, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  test.case = 'Null line - empty plane'; /* */

  var line = null;
  var plane = [ 1, 0, 0, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint,  expected );

  test.case = 'point line - no intersection'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = [ 1, 2, 3 ];

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint,  expected );

  test.case = 'point line in plane'; /* */

  var line = [ - 1, 2, 3, 0, 0, 0 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint,  expected );

  test.case = 'Line and plane intersect'; /* */

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint,  expected );

  test.case = 'Negative factor'; /* */

  var line = [ 0, -6, 4, 1, 1, 0 ];
  var plane = [ 1, 0, 0, 3 ];
  var expected = 0;

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint,  expected );

  test.case = 'Line ( normalized to 1 ) intersection'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var plane = [ 0, 2, 0, - 2 ];
  var expected = 0;

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint,  expected );

  test.case = 'Line ( normalized to 1 ) parallel'; /* */

  var line = [ 0, 0, 0, 0, 0.194, 0 ];
  var plane = [ 3, 0, 0, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.equivalent( gotPoint,  expected );

  test.case = 'plane parallel to line'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0.5 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint,  expected );

  test.case = 'plane parallel contains line'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint,  expected );

  test.case = 'plane perpendicular to line'; /* */

  var line = [ 0, 0, 0, 0, 0, 2 ];
  var plane = [ 0, 0, 1, 0 ];
  var expected = 0;

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );


  test.case = 'plane parallel to line 4D'; /* */

  var line = [ 1, 2, 3, 4, 0, 0, 0, 2 ];
  var plane = [ 0, 1, 0, 0, 0 ];
  var expected = [ 1, 2, 3, 4 ];

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint,  expected );

  test.case = 'plane perpendicular to line 4D'; /* */

  var line = [ 0, 0, 0, 0, 0, 0, 2, 0 ];
  var plane = [ 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotPoint = _.line.planeClosestPoint( line, plane );
  test.identical( gotPoint, expected );

  test.case = 'dstPoint is array'; /* */

  var line = [ 0, -6, 24, 0, 1, 0 ];
  var plane = [ 1, 0, 0, 3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 0, -6, 24 ];

  var gotPoint = _.line.planeClosestPoint( line, plane, dstPoint );
  test.identical( gotPoint,  expected );

  test.case = 'dstPoint is vector'; /* */

  var line = [ 0, -6, 24, 0, 1, 0 ];
  var plane = [ 1, 0, 0, 3 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 0, -6, 24 ] );

  var gotPoint = _.line.planeClosestPoint( line, plane, dstPoint );
  test.identical( gotPoint,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.planeClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.line.planeClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.planeClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], 'plane') );
  test.shouldThrowErrorSync( () => _.line.planeClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.line.planeClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.planeClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function rayIntersects( test )
{
  test.case = 'Source ray and line remain unchanged'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var srcRay = [ 0, 0, 2, 2 ];
  var expected = true;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  var oldSrcLine = [ 0, 0, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldSrcRay = [ 0, 0, 2, 2 ];
  test.equivalent( srcRay, oldSrcRay );

  test.case = 'Line and ray are the same'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var srcRay = [ 0, 0, 1, 1 ];
  var expected = true;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray are parallel ( different origin - same direction )'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var srcRay = [ 3, 7, 1, 1 ];
  var expected = false;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray are parallel ( different origin - different direction )'; /* */

  var srcLine = [ 0, 0, 1, 1 ];
  var srcRay = [ 3, 7, 7, 7 ];
  var expected = false;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray intersect with line´s negative factor'; /* */

  var srcLine = [ 5, 5, 1, 1 ];
  var srcRay = [ 3, 0, 1, 2.5 ];
  var expected = true;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray don´t intersect with ray´s negative factor'; /* */

  var srcLine = [ 3, 0, 1, 2.5 ];
  var srcRay = [ 6, 6, 1, 1 ];
  var expected = false;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray intersect in their origin'; /* */

  var srcLine = [ 3, 7, 1, 0 ];
  var srcRay = [ 3, 7, 0, 1 ];
  var expected = true;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray intersect '; /* */

  var srcLine = [ 0, 0, 1, 0 ];
  var srcRay = [ -2, -6, 1, 2 ];
  var expected = true;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray are perpendicular '; /* */

  var srcLine = [ -3, 0, 1, 0 ];
  var srcRay = [ 0, -2, 0, 1 ];
  var expected = true;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray don´t intersect 3D'; /* */

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var srcRay = [ 3, 0, 1, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray intersect 3D'; /* */

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var srcRay = [ 3, 7, 1, 3, 1, 4 ];
  var expected = true;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray don´t intersect 4D'; /* */

  var srcLine = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var srcRay = [ 3, 0, 1, 4, 2, 2, 2, -1 ];
  var expected = false;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  test.case = 'Line and ray intersect 4D'; /* */

  var srcLine = [ 0, 0, 0, 1, 1, 1, 1, 1 ];
  var srcRay = [ 3, 7, 1, 4, 3, 1, 4, 3 ];
  var expected = true;

  var isIntersection = _.line.rayIntersects( srcLine, srcRay );
  test.identical( isIntersection, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.rayIntersects( ) );
  test.shouldThrowErrorSync( () => _.line.rayIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.rayIntersects( 'line', [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.rayIntersects( [ 1, 1, 2, 2 ], 'ray') );
  test.shouldThrowErrorSync( () => _.line.rayIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.line.rayIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.rayIntersects( [ 1, 1, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.rayIntersects( [ 1, 1, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.rayIntersects( [ 1, 1, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.rayIntersects( [ 1, 1, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayDistance( test )
{
  test.case = 'Source line and ray remain unchanged'; /* */

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  var oldSrcLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldTstRay = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstRay, oldTstRay );

  test.case = 'Line and ray are parallel ( different origin - same direction )'; /* */

  var srcLine = [ 0, 0, 0, 0, 0, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = Math.sqrt( 58 );

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray are parallel ( different origin - different direction )'; /* */

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstRay = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = Math.sqrt( 58 );

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray are parallel ( different origin - opposite direction )'; /* */

  var srcLine = [ 0, 0, 0, 1, 0, 0 ];
  var tstRay = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = Math.sqrt( 50 );

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'srcLine is a point'; /* */

  var srcLine = [ 3, 7, 1, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected =  Math.sqrt( 168 / 9 );

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'tstRay is a point'; /* */

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 0 ];
  var expected = Math.sqrt( 168 / 9 );

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray are the same'; /* */

  var srcLine = [ 0, 4, 2, 1, 1, 1 ];
  var tstRay = [ 0, 4, 2, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray intersect 4D'; /* */

  var srcLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var tstRay = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = 0;

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray don´t intersect 2D - parallel'; /* */

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 1, 0 ];
  var expected = 4;

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray intersect with line´s negative factor 2D'; /* */

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray don´t intersect with ray´s negative factor 2D'; /* */

  var srcLine = [ - 3, - 4, 0, 1 ];
  var tstRay = [ 0, 0, 2, 0 ];
  var expected = 3;

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray are perpendicular and intersect'; /* */

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray are perpendicular and don´t intersect'; /* */

  var srcLine = [ 0, 0, -3, 0, 0, 1 ];
  var tstRay = [ 3, 0, 0, 1, 1, 0 ];
  var expected = 3;

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray are parallel to x axis'; /* */

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 2, 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'Line and ray are parallel but in a opposite direction'; /* */

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = 1;

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  test.case = 'srcLine is null'; /* */

  var srcLine = null;
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = Math.sqrt( 53 );

  var gotDistance = _.line.rayDistance( srcLine, tstRay );
  test.identical( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.rayDistance( ) );
  test.shouldThrowErrorSync( () => _.line.rayDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.rayDistance( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.rayDistance( [ 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.line.rayDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.line.rayDistance( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.rayDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.rayDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.rayDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.rayDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function rayClosestPoint( test )
{
  test.case = 'Source line and ray remain unchanged'; /* */

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 0, 0, 0, 2, 2, 2 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  var oldSrcLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldTstRay = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstRay, oldTstRay );

  test.case = 'Line and ray are parallel ( different origin - same direction )'; /* */

  var srcLine = [ 0, 0, 0, 0, 0, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = [ 0, 0, 1 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are parallel ( different origin - different direction )'; /* */

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstRay = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = [ 3, 7, 0 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are parallel ( different origin - opposite direction )'; /* */

  var srcLine = [ 0, 0, 0, 1, 0, 0 ];
  var tstRay = [ 3, 7, 1, - 7, 0, 0 ];
  var expected = [ 3, 0, 0 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'srcLine is a point'; /* */

  var srcLine = [ 3, 7, 1, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'tstRay is a point'; /* */

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstRay = [ 3, 7, 1, 0, 0, 0 ];
  var expected = [ 3.6666666, 3.6666666, 3.6666666 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Line and ray are the same'; /* */

  var srcLine = [ 0, 4, 2, 1, 1, 1 ];
  var tstRay = [ 0, 4, 2, 1, 1, 1 ];
  var expected = [ 0, 4, 2 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray intersect 4D'; /* */

  var srcLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var tstRay = [ 3, 4, 2, 1, -1, 0, 0, 0 ];
  var expected = [ 0, 4, 2, 1 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray don´t intersect 2D - parallel'; /* */

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 1, 0 ];
  var expected = [ -3, 0 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray intersect with line´s negative factor 2D'; /* */

  var srcLine = [ 0, 0, 2, 0 ];
  var tstRay = [ - 3, - 4, 0, 1 ];
  var expected = [ -3, 0 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray don´t intersect with ray´s negative factor 2D'; /* */

  var srcLine = [ - 3, - 4, 0, 1 ];
  var tstRay = [ 0, 0, 2, 0 ];
  var expected = [ -3, 0 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are perpendicular and intersect'; /* */

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 1, 0, 0, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are perpendicular and don´t intersect'; /* */

  var srcLine = [ 0, 0, -3, 0, 0, 1 ];
  var tstRay = [ 3, 0, 0, 1, 1, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are parallel to x'; /* */

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 2, 1, 0, 0 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and ray are parallel but in a opposite direction'; /* */

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  test.case = 'srcLine is null'; /* */

  var srcLine = null;
  var tstRay = [ 3, 7, 2, - 1, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.rayClosestPoint( srcLine, tstRay );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.rayClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.line.rayClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.rayClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.rayClosestPoint( [ 0, 0 ], 'ray') );
  test.shouldThrowErrorSync( () => _.line.rayClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.line.rayClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.rayClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function segmentClosestPoint( test )
{
  test.case = 'Source line and segment remain unchanged'; /* */

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 0, 0, 0, 2, 2, 2 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  var oldSrcLine = [ 0, 0, 0, 1, 1, 1 ];
  test.equivalent( srcLine, oldSrcLine );

  var oldTstSegment = [ 0, 0, 0, 2, 2, 2 ];
  test.equivalent( tstSegment, oldTstSegment );

  test.case = 'Line and segment are parallel ( different origin - same direction )'; /* */

  var srcLine = [ 0, 0, 0, 0, 0, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 7 ];
  var expected = [ 0, 0, 1 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and segment are parallel ( different origin - different direction )'; /* */

  var srcLine = [ 3, 7, 1, 0, 0, 7 ];
  var tstSegment = [ 0, 0, 0, 0, 0, 0.5 ];
  var expected = [ 3, 7, 0 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and segment are parallel ( different origin - opposite direction )'; /* */

  var srcLine = [ 0, 0, 0, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 1, - 7, 7, 1 ];
  var expected = [ 3, 0, 0 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'srcLine is a point'; /* */

  var srcLine = [ 3, 7, 1, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'tstSegment is a point'; /* */

  var srcLine = [ 0, 0, 0, 1, 1, 1 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 1 ];
  var expected = [ 3.6666666, 3.6666666, 3.6666666 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.equivalent( gotClosestPoint, expected );

  test.case = 'Line and segment are the same'; /* */

  var srcLine = [ 0, 4, 2, 1, 1, 1 ];
  var tstSegment = [ 0, 4, 2, 3, 7, 5 ];
  var expected = [ 0, 4, 2 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and segment intersect 4D'; /* */

  var srcLine = [ 0, 0, 2, 1, 0, 1, 0, 0 ];
  var tstSegment = [ 3, 4, 2, 1, -3, 4, 2, 1 ];
  var expected = [ 0, 4, 2, 1 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and segment don´t intersect 2D - parallel'; /* */

  var srcLine = [ 0, 0, 2, 0 ];
  var tstSegment = [ - 3, - 4, 3, -4 ];
  var expected = [ -3, 0 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and segment intersect with line´s negative factor 2D'; /* */

  var srcLine = [ 0, 0, 2, 0 ];
  var tstSegment = [ - 3, - 4, -3, 1 ];
  var expected = [ -3, 0 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and segment don´t intersect with segment´s negative factor 2D'; /* */

  var srcLine = [ - 3, - 4, 0, 1 ];
  var tstSegment = [ 0, 0, 2, 0 ];
  var expected = [ -3, 0 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and segment are perpendicular and intersect'; /* */

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 1, 3, 7, 8 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and segment are perpendicular and don´t intersect'; /* */

  var srcLine = [ 0, 0, -3, 0, 0, 1 ];
  var tstSegment = [ 3, 2, 0, -3, 2, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and segment are parallel to x'; /* */

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 2, 9, 7, 2 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'Line and segment are parallel but in a opposite direction'; /* */

  var srcLine = [ 3, 7, 1, 1, 0, 0 ];
  var tstSegment = [ 3, 7, 2, -3, 7, 2 ];
  var expected = [ 3, 7, 1 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  test.case = 'srcLine is null'; /* */

  var srcLine = null;
  var tstSegment = [ 3, 7, 2, -3, 7, 2 ];
  var expected = [ 0, 0, 0 ];

  var gotClosestPoint = _.line.segmentClosestPoint( srcLine, tstSegment );
  test.identical( gotClosestPoint, expected );

  /* */

  if( !Config.debug )
  return;
  test.shouldThrowErrorSync( () => _.line.segmentClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.line.segmentClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.segmentClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.segmentClosestPoint( [ 0, 0 ], 'segment') );
  test.shouldThrowErrorSync( () => _.line.segmentClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.line.segmentClosestPoint( undefined, [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.segmentClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2 ] ) );

}

//

function sphereIntersects( test )
{

  test.case = 'Line and sphere remain unchanged'; /* */

  var line = [  - 1,  - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.identical( gotBool, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  test.case = 'Null line - empty sphere'; /* */

  var line = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.identical( gotBool,  expected );

  test.case = 'point line center of sphere'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.identical( gotBool,  expected );

  test.case = 'point line - no intersection'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = false;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.identical( gotBool,  expected );

  test.case = 'point line in sphere'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Line and sphere intersect'; /* */

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Line over sphere'; /* */

  var line = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = false;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Negative factor'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = true;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.identical( gotBool,  expected );

  test.case = 'sphere closer to origin'; /* */

  var line = [ 1, 1, 1, 2, 2, 2 ];
  var sphere = [ 2, 1, 0, 0.1 ];
  var expected = false;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Line ( normalized to 1 ) intersection'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = true;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.identical( gotBool,  expected );

  test.case = 'Line ( normalized to 1 ) no intersection'; /* */

  var line = [ 0, 0, 0, 0.194, 0.766, 0.766 ];
  var sphere = [ 3, 3, 3, 1 ];
  var expected = false;

  var gotBool = _.line.sphereIntersects( line, sphere );
  test.equivalent( gotBool,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.sphereIntersects( ) );
  test.shouldThrowErrorSync( () => _.line.sphereIntersects( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.sphereIntersects( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.line.sphereIntersects( 0 ) );
  test.shouldThrowErrorSync( () => _.line.sphereIntersects( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.sphereIntersects( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function sphereDistance( test )
{

  test.case = 'Line and sphere remain unchanged'; /* */

  var line = [  - 1,  - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.sphereDistance( line, sphere );
  test.identical( gotDistance, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  test.case = 'Null line - empty sphere'; /* */

  var line = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.sphereDistance( line, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'point line center of sphere'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.sphereDistance( line, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'point line - no intersection'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = Math.sqrt( 11 ) - 1;

  var gotDistance = _.line.sphereDistance( line, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'point line in sphere'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.line.sphereDistance( line, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Line and sphere intersect'; /* */

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotDistance = _.line.sphereDistance( line, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Line over sphere'; /* */

  var line = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = 1;

  var gotDistance = _.line.sphereDistance( line, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Negative factor'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = 0;

  var gotDistance = _.line.sphereDistance( line, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Line ( normalized to 1 ) intersection'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = 0;

  var gotDistance = _.line.sphereDistance( line, sphere );
  test.identical( gotDistance,  expected );

  test.case = 'Line ( normalized to 1 ) no intersection'; /* */

  var line = [ 0, 0, 0, 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ) ];
  var sphere = [ 3, 0, 0, 1 ];
  var expected = Math.sqrt( 6 ) - 1;

  var gotDistance = _.line.sphereDistance( line, sphere );
  test.equivalent( gotDistance,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.sphereDistance( ) );
  test.shouldThrowErrorSync( () => _.line.sphereDistance( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.sphereDistance( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.line.sphereDistance( 0 ) );
  test.shouldThrowErrorSync( () => _.line.sphereDistance( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.sphereDistance( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function sphereClosestPoint( test )
{

  test.case = 'Line and sphere remain unchanged'; /* */

  var line = [  - 1,  - 1, -1, 1, 1, 1 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint, expected );

  var oldLine = [  - 1, - 1, -1, 1, 1, 1 ];
  test.identical( line, oldLine );

  var oldSphere = [ 0, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  test.case = 'Null line - empty sphere'; /* */

  var line = null;
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'point line center of sphere'; /* */

  var line = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'point line - no intersection'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 4, 3, 4, 1 ];
  var expected = [ 1, 2, 3 ];

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'point line in sphere'; /* */

  var line = [ 1, 2, 3, 0, 0, 0 ];
  var sphere = [ 2, 2, 2, 2 ];
  var expected = 0;

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line and sphere intersect'; /* */

  var line = [ -2, -2, -2, 2, 2, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line over sphere'; /* */

  var line = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 0, 0, 3 ];
  var expected = [ 0, 0, 4 ];

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Negative factor'; /* */

  var line = [ 0, 0, 0, 2, 2, 2 ];
  var sphere = [ - 2, - 2, - 2, 0.5 ];
  var expected = 0;

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line ( normalized to 1 ) intersection'; /* */

  var line = [ 0, 0, 0, 1/ Math.sqrt( 2 ), 1/ Math.sqrt( 2 ), 0 ];
  var sphere = [ 0, 2, 0, 2 ];
  var expected = 0;

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere );
  test.identical( gotClosestPoint,  expected );

  test.case = 'Line ( normalized to 1 ) no intersection'; /* */

  var line = [ 0, 0, 0, 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ), 1 / Math.sqrt( 3 ) ];
  var sphere = [ 3, 0, 0, 1 ];
  var expected = [ 1, 1, 1 ];

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere );
  test.equivalent( gotClosestPoint,  expected );

  test.case = 'dstPoint is vector'; /* */

  var line = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 0, 5, 0, 3 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 0, 5, 4 ] );

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere, dstPoint );
  test.identical( gotClosestPoint,  expected );

  test.case = 'dstPoint is array'; /* */

  var line = [ 0, -6, 4, 0, 1, 0 ];
  var sphere = [ 1, 5, 0, 3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 0, 5, 4 ];

  var gotClosestPoint = _.line.sphereClosestPoint( line, sphere, dstPoint );
  test.identical( gotClosestPoint,  expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.sphereClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.line.sphereClosestPoint( [ 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.sphereClosestPoint( 'line', [ 1, 1, 1, 2, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], 'sphere') );
  test.shouldThrowErrorSync( () => _.line.sphereClosestPoint( 0 ) );
  test.shouldThrowErrorSync( () => _.line.sphereClosestPoint( undefined, [ 1, 1, 2, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.line.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], undefined ) );
  test.shouldThrowErrorSync( () => _.line.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], - 2 ) );
  test.shouldThrowErrorSync( () => _.line.sphereClosestPoint( [ 1, 1, 1, 2, 2, 2 ], [ 1, 2, 3, 4, 5, 6 ] ) );

}

//

function boundingSphereGet( test )
{

  test.case = 'Source line remains unchanged'; /* */

  var srcLine = [ 0, 0, 0, 3, 3, 3 ];
  var dstSphere = [ 1, 1, 2, 1 ];
  var expected = [ 0, 0, 0, Infinity ];

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( expected, gotSphere );
  test.is( dstSphere === gotSphere );

  var oldSrcLine = [ 0, 0, 0, 3, 3, 3 ];
  test.identical( srcLine, oldSrcLine );

  test.case = 'Zero line to zero sphere'; /* */

  var srcLine = [ 0, 0, 0, 0, 0, 0 ];
  var dstSphere = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  test.case = 'Point line and point Sphere'; /* */

  var srcLine = [ 0, 0, 0, 0, 0, 0 ];
  var dstSphere = [ 3, 3, 3, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  test.case = 'Sphere and line intersect'; /* */

  var srcLine = [ 0, 0, 0, 4, 4, 4 ];
  var dstSphere = [ 2, 2, 2, 1 ];
  var expected = [ 0, 0, 0, Infinity ];

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  test.case = 'Sphere and line intersect - negative dir'; /* */

  var srcLine = [ 0, 0, 0, - 1, - 1, - 1 ];
  var dstSphere = [ 0, 0, 0, 3 ];
  var expected = [ 0, 0, 0, Infinity ];

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  test.case = 'Sphere and line don´t intersect'; /* */

  var srcLine = [ 1, 2, 3, 5, 8, 9 ];
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ 1, 2, 3, Infinity ];

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  test.case = 'srcLine vector'; /* */

  var srcLine = _.vector.from( [- 1, - 1, - 1, 1, 1, 1 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ - 1, - 1, - 1, Infinity ];

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere vector'; /* */

  var srcLine = [- 1, - 1, - 1, 3, 3, 1 ];
  var dstSphere = _.vector.from( [ 5, 5, 5, 3 ] );
  var expected = _.vector.from( [ - 1, - 1, - 1, Infinity ] );

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere null'; /* */

  var srcLine = [- 1, 5, - 1, 0, 0, 0 ];
  var dstSphere = null;
  var expected = [ - 1, 5, - 1, 0 ];

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere undefined'; /* */

  var srcLine = [ - 1, - 3, - 5, 1, 0, 0 ];
  var dstSphere = undefined;
  var expected = [ - 1, - 3, - 5, Infinity ];

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  test.case = 'Very small direction'; /* */

  var srcLine = _.vector.from( [ 4, 4, 4, 1E-12, 1E-12, 1E-12 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ 4, 4, 4, Infinity ];

  var gotSphere = _.line.boundingSphereGet( dstSphere, srcLine );
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( ) );
  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( [] ) );
  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( 'sphere', 'line' ) );
  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( [ 0, 0, 0, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.line.boundingSphereGet( [ 0, 1, 0, 1 ], [ 0, 0, 1, 2, 2, 3, 1 ] ) );

}




// --
// define class
// --

var Self =
{

  name : 'Tools.Math.Line',
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

    lineAt : lineAt,
    getFactor : getFactor,

    lineParallel3D : lineParallel3D,

    lineParallel : lineParallel,
    lineIntersectionFactors : lineIntersectionFactors,
    lineIntersectionPoints : lineIntersectionPoints,
    lineIntersectionPoint : lineIntersectionPoint,
    lineIntersectionPointAccurate : lineIntersectionPointAccurate,

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

    lineIntersects : lineIntersects,
    lineDistance : lineDistance,
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
