( function _AxisAndAngle_test_s_( ) {

'use strict';

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
var Parent = wTester;

var avector = _.avector;
var vector = _.vector;
var pi = Math.PI;
var sin = Math.sin;
var cos = Math.cos;
var atan2 = Math.atan2;
var asin = Math.asin;
var sqr = _.sqr;
var sqrt = _.sqrt;
var clamp = _.clamp;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --

function is( test )
{

  test.case = 'array'; /* */

  test.is( !_.axisAndAngle.is([]) );
  test.is( !_.axisAndAngle.is([ 0 ]) );
  test.is( !_.axisAndAngle.is([ 0,0 ]) );

  test.is( !_.axisAndAngle.is([ 0,0,0 ]) );
  test.is( _.axisAndAngle.is( [ 0,0,0 ],0 ) );
  test.is( !_.axisAndAngle.is( [ 0,0,0 ],null ) );
  test.is( !_.axisAndAngle.is( null,0 ) );
  test.is( !_.axisAndAngle.is( null,null ) );

  test.is( _.axisAndAngle.is([ 0,0,0,0 ]) );
  test.is( !_.axisAndAngle.is( [ 0,0,0,0 ],0 ) );
  test.is( !_.axisAndAngle.is( [ 0,0,0,0 ],null ) );

  test.is( !_.axisAndAngle.is([ 0,0,0,0,0 ]) );
  test.is( !_.axisAndAngle.is([ 0,0,0,0,0,0 ]) );
  test.is( !_.axisAndAngle.is([ 1,2,3,0,1,2 ]) );
  test.is( !_.axisAndAngle.is([ 0,0,0,0,0,0,0 ]) );

  test.case = 'vector'; /* */

  test.is( !_.axisAndAngle.is( _.vector.fromArray([]) ) );
  test.is( !_.axisAndAngle.is( _.vector.fromArray([ 0 ]) ) );
  test.is( !_.axisAndAngle.is( _.vector.fromArray([ 0,0 ]) ) );

  test.is( !_.axisAndAngle.is( _.vector.fromArray([ 0,0,0 ]) ) );
  test.is( _.axisAndAngle.is( _.vector.fromArray( [ 0,0,0 ]),0 ) );
  test.is( !_.axisAndAngle.is( _.vector.fromArray( [ 0,0,0 ]),null ) );

  test.is( _.axisAndAngle.is( _.vector.fromArray( [ 0,0,0,0 ]) ) );
  test.is( !_.axisAndAngle.is( _.vector.fromArray( [ 0,0,0,0 ] ),0 ) );
  test.is( !_.axisAndAngle.is( _.vector.fromArray( [ 0,0,0,0 ] ),null ) );

  test.is( !_.axisAndAngle.is( _.vector.fromArray([ 0,0,0,0,0 ]) ) );
  test.is( !_.axisAndAngle.is( _.vector.fromArray([ 0,0,0,0,0,0 ]) ) );
  test.is( !_.axisAndAngle.is( _.vector.fromArray([ 1,2,3,0,1,2 ]) ) );
  test.is( !_.axisAndAngle.is( _.vector.fromArray([ 0,0,0,0,0,0,0 ]) ) );

  test.case = 'not axisAndAngle'; /* */

  test.is( !_.axisAndAngle.is( 'abcdef' ) );
  test.is( !_.axisAndAngle.is( {} ) );
  test.is( !_.axisAndAngle.is( function( a,b,c,d,e,f ){} ) );

}

//

function like( test )
{

  test.case = 'array'; /* */

  test.is( !_.axisAndAngle.like([]) );
  test.is( !_.axisAndAngle.like([ 0 ]) );
  test.is( !_.axisAndAngle.like([ 0,0 ]) );

  test.is( !_.axisAndAngle.like([ 0,0,0 ]) );
  test.is( _.axisAndAngle.like( [ 0,0,0 ],0 ) );
  test.is( _.axisAndAngle.like( [ 0,0,0 ],null ) );
  test.is( _.axisAndAngle.like( null,0 ) );
  test.is( _.axisAndAngle.like( null,null ) );

  test.is( _.axisAndAngle.like([ 0,0,0,0 ]) );
  test.is( !_.axisAndAngle.like( [ 0,0,0,0 ],0 ) );
  test.is( !_.axisAndAngle.like( [ 0,0,0,0 ],null ) );

  test.is( !_.axisAndAngle.like([ 0,0,0,0,0 ]) );
  test.is( !_.axisAndAngle.like([ 0,0,0,0,0,0 ]) );
  test.is( !_.axisAndAngle.like([ 1,2,3,0,1,2 ]) );
  test.is( !_.axisAndAngle.like([ 0,0,0,0,0,0,0 ]) );

  test.case = 'vector'; /* */

  test.is( !_.axisAndAngle.like( _.vector.fromArray([]) ) );
  test.is( !_.axisAndAngle.like( _.vector.fromArray([ 0 ]) ) );
  test.is( !_.axisAndAngle.like( _.vector.fromArray([ 0,0 ]) ) );

  test.is( !_.axisAndAngle.like( _.vector.fromArray([ 0,0,0 ]) ) );
  test.is( _.axisAndAngle.like( _.vector.fromArray( [ 0,0,0 ]),0 ) );
  test.is( _.axisAndAngle.like( _.vector.fromArray( [ 0,0,0 ]),null ) );

  test.is( _.axisAndAngle.like( _.vector.fromArray( [ 0,0,0,0 ]) ) );
  test.is( !_.axisAndAngle.like( _.vector.fromArray( [ 0,0,0,0 ] ),0 ) );
  test.is( !_.axisAndAngle.like( _.vector.fromArray( [ 0,0,0,0 ] ),null ) );

  test.is( !_.axisAndAngle.like( _.vector.fromArray([ 0,0,0,0,0 ]) ) );
  test.is( !_.axisAndAngle.like( _.vector.fromArray([ 0,0,0,0,0,0 ]) ) );
  test.is( !_.axisAndAngle.like( _.vector.fromArray([ 1,2,3,0,1,2 ]) ) );
  test.is( !_.axisAndAngle.like( _.vector.fromArray([ 0,0,0,0,0,0,0 ]) ) );

  test.case = 'not axisAndAngle'; /* */

  test.is( !_.axisAndAngle.like( 'abcdef' ) );
  test.is( !_.axisAndAngle.like( {} ) );
  test.is( !_.axisAndAngle.like( function( a,b,c,d,e,f ){} ) );

}

//

function isZero( test )
{

  test.case = 'zero'; /* */

  test.is( _.axisAndAngle.isZero([ 0,0,0,0 ]) );
  test.is( _.axisAndAngle.isZero([ 1,0,0,0 ]) );
  test.is( _.axisAndAngle.isZero([ 0,1,0,0 ]) );
  test.is( _.axisAndAngle.isZero([ 0,0,1,0 ]) );

  test.is( _.axisAndAngle.isZero( [ 0,0,1 ],0 ) );

  test.case = 'not zero'; /* */

  test.is( !_.axisAndAngle.isZero([ 0,0,0,+0.1 ]) );
  test.is( !_.axisAndAngle.isZero([ 1,0,0,+0.1 ]) );
  test.is( !_.axisAndAngle.isZero([ 0,1,0,+0.1 ]) );
  test.is( !_.axisAndAngle.isZero([ 0,0,1,+0.1 ]) );
  test.is( !_.axisAndAngle.isZero([ 1,0,0,-0.1 ]) );
  test.is( !_.axisAndAngle.isZero([ 0,1,0,-0.1 ]) );
  test.is( !_.axisAndAngle.isZero([ 0,0,1,-0.1 ]) );

  test.is( !_.axisAndAngle.isZero([ 0,0,0 ],+0.1 ) );
  test.is( !_.axisAndAngle.isZero([ 1,0,0 ],+0.1 ) );
  test.is( !_.axisAndAngle.isZero([ 0,1,0 ],+0.1 ) );
  test.is( !_.axisAndAngle.isZero([ 0,0,1 ],+0.1 ) );
  test.is( !_.axisAndAngle.isZero([ 1,0,0 ],-0.1 ) );
  test.is( !_.axisAndAngle.isZero([ 0,1,0 ],-0.1 ) );
  test.is( !_.axisAndAngle.isZero([ 0,0,1 ],-0.1 ) );

  test.is( !_.axisAndAngle.isZero( [ 0,0,1 ],null ) );
  test.is( !_.axisAndAngle.isZero( null,0 ) );
  test.is( !_.axisAndAngle.isZero( null,null ) );

  test.is( !_.axisAndAngle.isZero( [ 0,0,1,0 ],null ) );
  test.is( !_.axisAndAngle.isZero( [ 0,0,1,0 ],0 ) );

}

//

function make( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.axisAndAngle.make( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.axisAndAngle.make( src );
  var expected = [ 0,0,0,0, ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src array'; /* */

  var src = [ 0,1,2,5, ];
  var got = _.axisAndAngle.make( src );
  var expected = [ 0,1,2,5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src array and angle'; /* */

  var src = [ 0,1,2 ];
  var got = _.axisAndAngle.make( src,5 );
  var expected = [ 0,1,2,5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,5 ]);
  var got = _.axisAndAngle.make( src );
  var expected = [ 0,1,2,5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2 ]);
  var got = _.axisAndAngle.make( src,5 );
  var expected = [ 0,1,2,5 ];
  test.identical( got,expected );
  test.is( got !== src );

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.axisAndAngle.make( 0 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( 4 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( '4' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( [ 0,0,0,0 ],2 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( [ 0,0,0 ],2,2 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.make( [ 0,0,0 ] ) );

}

//

function makeZero( test )
{

  test.case = 'trivial'; /* */

  var got = _.axisAndAngle.makeZero();
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( undefined ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( null ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( 4 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero([ 0,0,0 ],1) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero([ 0,0,0,0 ]) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero([ 0,0,0,0,1,2 ]) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( '4' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.makeZero( [ 0,0,0,0,1,2 ],2 ) );

}

//

function from( test )
{

  test.case = 'from null'; /* */

  var src = null;
  var got = _.axisAndAngle.from( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'from null and null'; /* */

  var src = null;
  var got = _.axisAndAngle.from( src,null );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'from null and angle'; /* */

  var src = null;
  var got = _.axisAndAngle.from( src,3 );
  var expected = [ 0,0,0,3 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'from array and null'; /* */

  var src = [ 0,1,2 ];
  debugger;
  var got = _.axisAndAngle.from( src,null );
  var expected = [ 0,1,2,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'from array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.axisAndAngle.from( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got === src );

  test.case = 'from array and angle'; /* */

  var src = [ 0,1,2 ];
  var got = _.axisAndAngle.from( src,3 );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'from vector'; /* */

  var src = _.vector.from([ 0,1,2,3 ]);
  var got = _.axisAndAngle.from( src );
  var expected = _.vector.from([ 0,1,2,3 ]);
  test.identical( got,expected );
  test.is( got === src );

  test.case = 'from vector and angle'; /* */

  debugger;
  var src = _.vector.from([ 0,1,2 ]);
  var got = _.axisAndAngle.from( src,3 );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.axisAndAngle.from() );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( undefined ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( null,null,null ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( [ 1,2,3,4,5 ] ) );

  test.shouldThrowErrorSync( () => _.axisAndAngle.from( 'abcd' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.from( {} ) );

}

//

function _from( test )
{

  test.case = '_from null'; /* */

  var src = null;
  var got = _.axisAndAngle._from( src );
  var expected = _.vector.from([ 0,0,0,0 ]);
  test.identical( got,expected );
  test.is( got !== src );

  test.case = '_from null and null'; /* */

  var src = null;
  var got = _.axisAndAngle._from( src,null );
  var expected = _.vector.from([ 0,0,0,0 ]);
  test.identical( got,expected );
  test.is( got !== src );

  test.case = '_from null and angle'; /* */

  var src = null;
  var got = _.axisAndAngle._from( src,3 );
  var expected = _.vector.from([ 0,0,0,3 ]);
  test.identical( got,expected );
  test.is( got !== src );

  test.case = '_from array and null'; /* */

  var src = [ 0,1,2 ];
  debugger;
  var got = _.axisAndAngle._from( src,null );
  var expected = _.vector.from([ 0,1,2,0 ]);
  test.identical( got,expected );
  test.is( got !== src );
  test.is( got._vectorBuffer !== src );
  test.is( !!got._vectorBuffer );

  test.case = '_from array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.axisAndAngle._from( src );
  var expected = _.vector.from([ 0,1,2,3 ]);
  test.identical( got,expected );
  test.is( got !== src );
  test.is( got._vectorBuffer === src );
  test.is( !!got._vectorBuffer );

  test.case = '_from array and angle'; /* */

  var src = [ 0,1,2 ];
  var got = _.axisAndAngle._from( src,3 );
  var expected = _.vector.from([ 0,1,2,3 ]);
  test.identical( got,expected );
  test.is( got !== src );
  test.is( got._vectorBuffer !== src );
  test.is( !!got._vectorBuffer );

  test.case = '_from vector'; /* */

  var src = _.vector.from([ 0,1,2,3 ]);
  var got = _.axisAndAngle._from( src );
  var expected = _.vector.from([ 0,1,2,3 ]);
  test.identical( got,expected );
  test.is( got === src );

  test.case = '_from vector and angle'; /* */

  var src = _.vector.from([ 0,1,2 ]);
  var got = _.axisAndAngle._from( src,3 );
  var expected = _.vector.from([ 0,1,2,3 ]);
  test.identical( got,expected );
  test.is( got !== src );
  test.is( got._vectorBuffer !== src );
  test.is( !!got._vectorBuffer );

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.axisAndAngle._from() );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( undefined ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( null,null,null ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( [ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( [ 1,2,3,4,5 ] ) );

  test.shouldThrowErrorSync( () => _.axisAndAngle._from( _.vector.from([ 1,2,3 ]) ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( _.vector.from([ 1,2,3,4,5 ]) ) );

  test.shouldThrowErrorSync( () => _.axisAndAngle._from( 'abcd' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle._from( {} ) );

}

//

function zero( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.axisAndAngle.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.axisAndAngle.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,5 ];
  var got = _.axisAndAngle.zero( dst );
  var expected = [ 0,1,2,0 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,5 ]);
  var got = _.axisAndAngle.zero( dst );
  var expected = _.vector.fromArray([ 0,1,2,0 ]);
  test.identical( got,expected );
  test.is( got === dst );

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.axisAndAngle.zero( 4 ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.zero([ 0,0,0 ]) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.zero( '4' ) );
  test.shouldThrowErrorSync( () => _.axisAndAngle.zero( [ 0,0,0,5,5,5 ],2 ) );

}

//

function eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast( test )
{
  debugger;

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler = _.euler.make();
  var quat1 = _.quat.make();
  var matrix = _.Space.makeZero( [ 3, 3 ] );
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();
  var axisAngle1 = _.axisAndAngle.makeZero();
  var axisAngle2 = _.axisAndAngle.makeZero();

  // var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  // var deltas = [ -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  var deltas = [ -accuracySqr, 0, +accuracySqr, +0.1 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4 ];
  // var anglesLocked = [ 0, Math.PI / 3 ];
  var anglesLocked = [ Math.PI / 3 ];

  /* */

  var o =
  {
    deltas : deltas,
    angles : angles,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler )
  {
    quat1 = _.euler.toQuat2( euler, quat1 );
    axisAngle1 = _.quat.toAxisAndAngle( quat1, axisAngle1 );
    matrix = _.axisAndAngle.toMatrixRotation( axisAngle1, matrix );
    axisAngle2 = _.axisAndAngle.fromMatrixRotation( axisAngle2, matrix );
    quat2 = _.quat.fromAxisAndAngle( quat2, axisAngle2 );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
    test.is( eq );
  }

}

eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast.timeOut = 20000;
eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast.usingSourceCode = 0;
eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast.rapidity = 3;

//

function eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow( test )
{
  debugger;

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler = _.euler.make();
  var quat1 = _.quat.make();
  var matrix = _.Space.makeZero( [ 3, 3 ] );
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();
  var axisAngle1 = _.axisAndAngle.makeZero();
  var axisAngle2 = _.axisAndAngle.makeZero();

  var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4, Math.PI/6 ];
  // var anglesLocked = [ 0, Math.PI / 3 ];
  var anglesLocked =  [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];

  /* */

  var o =
  {
    deltas : deltas,
    angles : angles,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler )
  {
    quat1 = _.euler.toQuat2( euler, quat1 );
    axisAngle1 = _.quat.toAxisAndAngle( quat1, axisAngle1 );
    matrix = _.axisAndAngle.toMatrixRotation( axisAngle1, matrix );
    axisAngle2 = _.axisAndAngle.fromMatrixRotation( axisAngle2, matrix );
    quat2 = _.quat.fromAxisAndAngle( quat2, axisAngle2 );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
    test.is( eq );
  }

}

eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow.timeOut =100000;
eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow.usingSourceCode = 0;
eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow.rapidity = 2;

//

function eachAngle( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( eachAngle, o );

  var euler = _.euler.from( o.dst );
  for( var r = 0; r < o.representations.length; r++ )
  {
    var representation = o.representations[ r ];
    _.euler.representationSet( euler, representation );
    for( var ang1 = 0; ang1 < o.angles.length; ang1++ )
    {
      for( var quad1 = 0; quad1 < o.quadrants.length; quad1++ )
      {
        for( var d = 0; d < o.deltas.length; d++ )
        {
          euler[ 0 ] = o.angles[ ang1 ] + o.quadrants[ quad1 ]*Math.PI/2 + o.deltas[ d ];
          for( var ang2 = ang1; ang2 < o.angles.length; ang2++ )
          {
            for( var quad2 = quad1; quad2 < o.quadrants.length; quad2++ )
            {
              for( var d2 = 0; d2 < o.deltas.length; d2++ )
              {
                euler[ 1 ] = o.angles[ ang2 ] + o.quadrants[ quad2 ]*Math.PI/2 + o.deltas[ d2 ];
                for( var ang3 = 0; ang3 < o.anglesLocked.length; ang3++ )
                {
                  for( var quad3 = 0; quad3 < o.quadrantsLocked.length; quad3++ )
                  {
                    for( var d3 = 0; d3 < o.deltasLocked.length; d3++ )
                    {
                      euler[ 2 ] = o.anglesLocked[ ang3 ] + o.quadrantsLocked[ quad3 ]*Math.PI/2 + o.deltasLocked[ d3 ];
                      o.onEach( euler );
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

}

eachAngle.defaults =
{
  representations : [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ],
  angles : [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ],
  anglesLocked : [ 0, Math.PI / 3 ],
  quadrants : [ 0, 1, 2, 3 ],
  quadrantsLocked : [ 0 ],
  deltas : null,
  deltasLocked : [ 0 ],
  onEach : null,
  dst : null,
}

// --
// declare
// --

var Self =
{

  name : 'Tools.Math.AxisAndAngle',
  silencing : 1,
  enabled : 1,
  // routine : 'eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow',

  context :
  {
    eachAngle : eachAngle,
  },

  tests :
  {

    is : is,
    like : like,
    isZero : isZero,

    make : make,
    makeZero : makeZero,

    from : from,
    _from : _from,

    zero : zero,

    /* takes 6 seconds */
    eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast : eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatFast,
    /* takes  seconds */
    eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow : eulerToQuatToAxisAndAngleMatrixToAxisAndAngleToQuatSlow,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
