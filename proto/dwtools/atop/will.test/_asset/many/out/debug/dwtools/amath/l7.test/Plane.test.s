( function _Plane_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );

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

function from( test )
{

  test.case = 'Src plane, normal and bias stay unchanged, dst plane changes'; /* */

  var dstPlane = [ 0, 0 , 1, 2 ];
  var srcPlane = [ 0, 1, 2, 3 ];
  var oldSrcPlane = srcPlane.slice();
  var normal = [ 0, 1, 2 ];
  var oldNormal = normal.slice();
  var bias = 3;
  var expected = [ 0, 1, 2, 3 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, dstPlane );
  test.identical( expected, dstPlane );
  test.identical( srcPlane, oldSrcPlane );
  test.identical( normal, oldNormal );

  var oldBias = 3;
  test.identical( bias, oldBias );

  test.case = 'null plane'; /* */

  var dstPlane = null;
  var srcPlane = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, expected );

  test.case = 'null plane fron normal and bias'; /* */

  var dstPlane = null;
  var normal = [ 0, 0, 0 ];
  var bias = 0;
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'NaN normal'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var normal = [ NaN, NaN, NaN ];
  var bias = 2;
  var expected = [ NaN, NaN, NaN, 2 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'NaN bias'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var normal = [ 0, 1, 0 ];
  var bias = NaN;
  var expected = [ 0, 1, 0, NaN ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'Erase plane'; /* */

  var dstPlane = [ 1, 1, 1, 1 ];
  var srcPlane = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, expected );

  test.case = 'Erase plane form normal and bias'; /* */

  var dstPlane = [ 1, 1, 1, 1 ];
  var normal = [ 0, 0, 0 ];
  var bias = 0;
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'Change plane'; /* */

  var dstPlane = [ 1, 0, 1, 2 ];
  var srcPlane = [ 0, 1, 0, 1 ];
  var expected = [ 0, 1, 0, 1 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, expected );

  test.case = 'Change plane from normal and bias'; /* */

  var dstPlane = [ 1, 0, 1, 2 ];
  var normal = [ 1, 2, 1 ];
  var bias = 1;
  var expected = [ 1, 2, 1, 1 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'Change plane 2D'; /* */

  var dstPlane = [ 0, 0, 0 ];
  var srcPlane = [ 0, 1, 1 ];
  var expected = [ 0, 1, 1 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, expected );

  test.case = 'Change plane 2D'; /* */

  var dstPlane = [ 0, 0, 0 ];
  var normal = [ 0, 1 ];
  var bias = 1;
  var expected = [ 0, 1, 1 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  test.case = 'Change plane 4D'; /* */

  var dstPlane = [ 0, 0, 0, 0, 0 ];
  var srcPlane = [ 0, 1, 1, 0, 1 ];
  var expected = [ 0, 1, 1, 0, 1 ];

  var gotPlane = _.plane.from( dstPlane, srcPlane );
  test.identical( gotPlane, expected );

  test.case = 'Change plane 4D'; /* */

  var dstPlane = [ 0, 0, 0, 0, 0 ];
  var normal = [ 0, 1, 1, 0 ];
  var bias = 1;
  var expected = [ 0, 1, 1, 0, 1 ];

  var gotPlane = _.plane.from( dstPlane, normal, bias );
  test.identical( gotPlane, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.from( ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ], 2 ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], null, 1 ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], [ 1, 1, 1 ], null ));
  test.shouldThrowErrorSync( () => _.plane.from( NaN, [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], NaN, 1 ));
  test.shouldThrowErrorSync( () => _.plane.from( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], 2, 3 ));

}

//

function fromNormalAndPoint( test )
{

  test.case = 'Normal and point stay unchanged, dst plane changes'; /* */

  var dstPlane = [ 0, 0 , 1, 2 ];
  var normal = [ 0, 1, 0 ];
  var oldNormal = normal.slice();
  var point = [ 0, 3, 4 ];
  var oldPoint = point.slice();
  var expected = [ 0, 1, 0, - 3 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, dstPlane );
  test.identical( expected, dstPlane );
  test.identical( normal, oldNormal );
  test.identical( point, oldPoint );

  test.case = 'NaN plane from normal and point'; /* */

  var dstPlane = [ NaN, NaN, NaN, NaN ];
  var normal = [ 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var expected = [ 0, 0, 1, - 2 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'null plane from normal and point'; /* */

  var dstPlane = null;
  var normal = [ 0, 0, 1 ];
  var point = [ 0, 0, 2 ];
  var expected = [ 0, 0, 1, - 2 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'NaN normal array'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var normal = [ NaN, NaN, NaN ];
  var point = [ 0, 0, 2 ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'NaN normal'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var normal = NaN ;
  var point = [ 0, 0, 2 ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'NaN point'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var normal = [ 0, 1, 0 ];
  var point = [ NaN, NaN, NaN ];
  var expected = [ 0, 1, 0, NaN ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'Erase plane'; /* */

  var dstPlane = [ 1, 1, 1, 1 ];
  var normal = [ 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.equivalent( gotPlane, expected );

  test.case = 'Change plane'; /* */

  var dstPlane = [ 1, 0, 1, 2 ];
  var normal = [ 1, 2, 1 ];
  var point = [ 0, 3, 0 ];
  var expected = [ 1, 2, 1, - 6 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'Change plane 2D'; /* */

  var dstPlane = [ 0, 0, 0 ];
  var normal = [ 0, 1 ];
  var point = [ 1, 0 ];
  var expected = [ 0, 1, 0 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.equivalent( gotPlane, expected );

  test.case = 'Change plane 4D'; /* */

  var dstPlane = [ 0, 0, 0, 0, 0 ];
  var normal = [ 0, 1, 1, 0 ];
  var point = [ 0, 0, 0, 4 ];
  var expected = [ 0, 1, 1, 0, 0 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.equivalent( gotPlane, expected );

  test.case = 'Negative numbers'; /* */

  var dstPlane = [ - 1, - 3, - 1 ];
  var normal = [ - 1, 0 ];
  var point = [ 4, - 4 ];
  var expected = [ - 1, 0, 4 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.identical( gotPlane, expected );

  test.case = 'Decimal numbers'; /* */

  var dstPlane = [ 0.2, 0.3, - 0.1 ];
  var normal = [ 0.57, 0.57 ];
  var point = [ 0, 0.500 ];
  var expected = [ 0.57, 0.57, - 0.285 ];

  var gotPlane = _.plane.fromNormalAndPoint( dstPlane, normal, point );
  test.equivalent( gotPlane, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0, 1 ], [ 0, 0, 1 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], null ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( NaN, [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromNormalAndPoint( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], NaN ));
}

//

function fromPoints( test )
{

  test.case = 'Points stay unchanged, dst plane changes'; /* */

  var dstPlane = [ 0, 0 , 1, 2 ];
  var a = [ 0, 1, 0 ];
  var oldA = a.slice();
  var b = [ 0, 3, 4 ];
  var oldB = b.slice();
  var c = [ 0, 2, 0 ];
  var oldC = c.slice();
  var expected = [ 1, 0, 0, 0 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c );
  test.identical( gotPlane, dstPlane );
  test.equivalent( expected, dstPlane );
  test.identical( a, oldA );
  test.identical( b, oldB );
  test.identical( c, oldC );

  test.case = 'NaN plane'; /* */

  var dstPlane = [ NaN, NaN, NaN, NaN ];
  var a = [ 2, 1, 0 ];
  var b = [ 2, 3, 4 ];
  var c = [ 2, 2, 0 ];
  var expected = [ 1, 0, 0, - 2 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.identical( gotPlane, expected );

  test.case = 'null plane from normal and point'; /* */

  var dstPlane = null;
  var a = [ 0, 1, 0 ];
  var b = [ 0, 3, 4 ];
  var c = [ 0, 2, 0 ];
  var expected = [ 1, 0, 0, 0 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.equivalent( gotPlane, expected );

  test.case = 'NaN point'; /* */

  var dstPlane = [ 0, 0, 0, 0 ];
  var a = [ NaN, NaN, NaN ];
  var b = [ 0, 3, 4 ];
  var c = [ 0, 2, 0 ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.identical( gotPlane, expected );

  test.case = 'Erase plane'; /* */

  var dstPlane = [ 1, 1, 1, 1 ];
  var a = [ 0, 0, 0 ];
  var b = [ 0, 0, 0 ];
  var c = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.equivalent( gotPlane, expected );

  test.case = 'Change plane'; /* */

  var dstPlane = [ 1, 0, 1, 2 ];
  var a = [ 1, 3, 0 ];
  var b = [ 1, 3, 4 ];
  var c = [ 1, 2, 0 ];
  var expected = [ - 1, 0, 0, 1 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.equivalent( gotPlane, expected );

  test.case = 'Negative numbers'; /* */

  var dstPlane = [ - 1, - 3, - 1, 3 ];
  var a = [ 2, 0, 2 ];
  var b = [ 2, - 2, - 2 ];
  var c = [ 2, 2, 0 ];
  var expected = [ - 1, 0, 0, 2 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.identical( gotPlane, expected );

  test.case = 'Decimal numbers'; /* */

  var dstPlane = [ 0.2, 0.3, - 0.1, 0 ];
  var a = [ 0, 0.2, 0.6 ];
  var b = [ 0, 0, 4.2 ];
  var c = [ 0, 0.3, 0 ];
  var expected = [ 1, 0, 0, 0 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.equivalent( gotPlane, expected );

  test.case = 'Points in same direction - no plane'; /* */

  var dstPlane = [ 0.2, 0.3, - 0.1, 0 ];
  var a = [ 0, 0, 1 ];
  var b = [ 0, 0, 2 ];
  var c = [ 0, 0, 3 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotPlane = _.plane.fromPoints( dstPlane, a, b, c  );
  test.equivalent( gotPlane, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.fromPoints( ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 2 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 1, 2 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], null, [ 1, 0, 0 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 1, 0 ], null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 0, 1 ], null ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], NaN, [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 1 ], NaN, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 1 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0 ], [ 0, 4 ], [ 0, 1 ], [ 0, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.fromPoints( [ 0, 0, 0, 0, 0 ], [ 0, 4, 1, 0 ], [ 0, 0, 1, 1 ], [ 0, 2, 2, 0 ] ));
}

//

function pointContains( test )
{

  test.case = 'Point and plane stay unchanged'; /* */

  var plane = [ 0, 0, 1, 2 ];
  var point = [ 0, 1, 0 ];
  var expected = false;

  var distance = _.plane.pointContains( plane, point );
  test.identical( expected, distance );

  var oldPlane = [ 0, 0, 1, 2 ];;
  test.identical( plane, oldPlane );

  var oldPoint = [ 0, 1, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Trivial - Contained'; /* */

  var plane = [ 2, 1, 0, 0 ];
  var point = [ 6, 3, -4 ];
  point = _.vector.from( point );
  var expected = false;

  var distance = _.plane.pointContains( plane, point );
  test.identical( distance, expected );

  test.case = 'NaN plane'; /* */

  var plane = [ NaN, NaN, NaN, NaN ];
  var point = [ 2, 1, 0 ];
  point = _.vector.from( point );
  var expected = false;

  var distance = _.plane.pointContains( plane, point );
  test.identical( distance, expected );

  test.case = 'NaN point'; /* */

  var plane = [ 0, 0, 0, 0 ];
  var point = [ NaN, NaN, NaN ];
  point = _.vector.from( point );
  var expected = false;

  var distance = _.plane.pointContains( plane, point );
  test.identical( distance, expected );

  test.case = 'Point under plane'; /* */

  var plane = [ 0, 0, 1, 1 ];
  var point = [ 0, 0, - 2 ];
  point = _.vector.from( point );
  var expected = false;

  var distance = _.plane.pointContains( plane, point );
  test.identical( distance, expected );

  test.case = 'Point over plane'; /* */

  var plane = [ 0, 0, 1, 1 ];
  var point = [ 0, 0, 2 ];
  var expected = false;

  var distance = _.plane.pointContains( plane, point );
  test.identical( distance, expected );

  test.case = 'Contained - Decimal numbers'; /* */

  var plane = [ 0.2, 0.3, - 0.1, 0 ];
  var point = [ 0, 0.2, 0.6 ];
  var expected = true;

  var distance = _.plane.pointContains( plane, point );
  test.equivalent( distance, expected );

  test.case = 'Not Contained - Decimal numbers'; /* */

  var plane = [ 0.2, 0.3, - 0.1, 0 ];
  var point = [ 0, 0.1, 0.6 ];
  var expected = false;

  var distance = _.plane.pointContains( plane, point );
  test.equivalent( distance, expected );

  test.case = 'Points in plane'; /* */

  var plane = [ 0.2, 0.3, - 0.1, 0 ];
  var a = [ 0, 0, 1 ];
  var b = [ 0, 1, 0 ];
  var c = [ 0, 0, 3 ];
  var expected = [ - 1, 0, 0, 0 ];

  var plane = _.plane.fromPoints( plane, a, b, c );
  test.equivalent( plane, expected );

  expected = true;

  var gotBool = _.plane.pointContains( plane, a );
  test.equivalent( gotBool, expected );
  var gotBool = _.plane.pointContains( plane, b );
  test.equivalent( gotBool, expected );
  var gotBool = _.plane.pointContains( plane, c );
  test.equivalent( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.pointContains( ));
  test.shouldThrowErrorSync( () => _.plane.pointContains( [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointContains( [ 0, 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointContains( [ 0, 0, 1, 0 ], [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointContains( [ 0, 0, 1, 0 ], [ 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointContains( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.pointContains( null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointContains( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.pointContains( NaN, [ 0, 1, 0 ] ));
}

//

function pointDistance( test )
{

  test.case = 'Point and plane stay unchanged'; /* */

  var plane = [ 0, 0 , 1, 2 ];
  var oldPlane = plane.slice();
  var point = [ 0, 1, 0 ];
  var oldPoint = point.slice();
  oldPoint = _.vector.from( point );
  point = _.vector.from( point );
  var expected = 2;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( expected, distance );
  test.identical( plane, oldPlane );
  test.identical( point, oldPoint );

  test.case = 'NaN plane'; /* */

  var plane = [ NaN, NaN, NaN, NaN ];
  var point = [ 2, 1, 0 ];
  point = _.vector.from( point );
  var expected = NaN;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( distance, expected );

  test.case = 'NaN point'; /* */

  var plane = [ 0, 0, 0, 0 ];
  var point = [ NaN, NaN, NaN ];
  point = _.vector.from( point );
  var expected = NaN;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( distance, expected );

  test.case = 'Trivial'; /* */

  var plane = [ 0, 1, 0, 2 ];
  var point = [ 1, 1, 1 ];
  point = _.vector.from( point );
  var expected = 3;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( distance, expected );

  test.case = 'Point under plane'; /* */

  var plane = [ 0, 0, 1, 1 ];
  var point = [ 0, 0, - 2 ];
  point = _.vector.from( point );
  var expected = - 1;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( distance, expected );

  test.case = 'Point over plane'; /* */

  var plane = [ 0, 0, 1, 1 ];
  var point = [ 0, 0, 2 ];
  point = _.vector.from( point );
  var expected = 3;

  var distance = _.plane.pointDistance( plane, point );
  test.identical( distance, expected );

  test.case = 'Decimal numbers'; /* */

  var plane = [ 0.2, 0.3, - 0.1, 0 ];
  var point = [ 0, 0.2, 0.6 ];
  point = _.vector.from( point );
  var expected = 0;

  var distance = _.plane.pointDistance( plane, point );
  test.equivalent( distance, expected );

  test.case = 'Decimal numbers'; /* */

  var plane = [ 0.2, 0.3, - 0.1, 0 ];
  var point = [ 0, 0.1, 0.6 ];
  point = _.vector.from( point );
  var expected = - 0.08017837257372731;

  var distance = _.plane.pointDistance( plane, point );
  test.equivalent( distance, expected );

  test.case = 'Points in plane'; /* */

  var plane = [ 0.2, 0.3, - 0.1, 0 ];
  var a = [ 0, 0, 1 ];
  var b = [ 0, 1, 0 ];
  var c = [ 0, 0, 3 ];
  var expected = [ - 1, 0, 0, 0 ];

  var plane = _.plane.fromPoints( plane, a, b, c );
  test.equivalent( plane, expected );

  a = _.vector.from( a );
  b = _.vector.from( b );
  c = _.vector.from( c );
  expected = 0;

  var dist = _.plane.pointDistance( plane, a );
  test.equivalent( dist, expected );
  var dist = _.plane.pointDistance( plane, b );
  test.equivalent( dist, expected );
  var dist = _.plane.pointDistance( plane, c );
  test.equivalent( dist, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.pointDistance( ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ], [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ], [ 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.pointDistance( NaN, [ 0, 1, 0 ] ));
}

//

function pointCoplanarGet( test )
{

  test.case = 'Plane and point remain unchanged'; /* */

  var plane = [ 1, 0, 0, 1 ];
  var point = [ 2, 0, 2 ];
  var expected = [ - 1, 0, 2 ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  var oldPoint = [ 2, 0, 2 ];
  test.identical( point, oldPoint );

  test.case = 'NaN array point'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ NaN, NaN, NaN ];
  var expected = [ NaN, NaN, NaN ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  test.case = 'Trivial'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ 1, 3, 2 ];
  var expected = [ - 1, 3, 2 ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  test.case = 'Trivial 2'; /* */

  var plane = [ 1, 0 , - 1, 0 ];
  var point = [ 2, 3, 2 ];
  var expected = [ 2, 3, 2 ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  test.case = 'Proyection 3D'; /* */

  var plane = [ 2, - 1 , 3, 1 ];
  var point = [ 4, 1, -3 ];
  var expected = [ 29/7, 13/14, -39/14  ];

  var gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.equivalent( expected, gotPoint );

  test.case = 'Point in plane'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ - 1, 2, 3 ];
  var expected = [ - 1, 2, 3 ];

  gotPoint = _.plane.pointCoplanarGet( plane, point );
  test.identical( expected, gotPoint );

  test.case = 'Destination point is vector'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var point = [ - 1, 2, 3 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ - 1, 2, 3 ] );

  gotPoint = _.plane.pointCoplanarGet( plane, point, dstPoint );
  test.identical( expected, gotPoint );
  test.identical( dstPoint, gotPoint );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( [ 0, 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( [ 0, 1, 0, 1 ], null ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( NaN, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( 'plane', [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.pointCoplanarGet( [ 0, 0, 1, 0 ], 'point' ));

}

//

function boxIntersects( test )
{

  test.case = 'box and plane stay unchanged'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var oldPlane = plane.slice();
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var oldbox = box.slice();
  var expected = false;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( expected, gotBool );
  test.identical( plane, oldPlane );
  test.identical( box, oldbox );

  test.case = 'No intersection'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );


  test.case = 'No intersection diagonal plane'; /* */

  var plane = [ - 1, 1, 0, - 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = false;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );


  test.case = 'Intersection x'; /* */

  var plane = [ 3, 0, 0, - 2 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  test.case = 'Intersection y'; /* */

  var plane = [ 0, 2, 0, - 2 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );


  test.case = 'Intersection z'; /* */

  var plane = [ 0, 0, 1, - 2 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );


  test.case = 'Intersection diagonal plane'; /* */

  var plane = [ 1, - 1, 0, 0 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  test.case = 'Intersection one side of box in plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var box = [ 0, - 2, 0, 1, 3, 3 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  test.case = 'Intersection one edge of box in plane'; /* */

  var plane = [ 1, - 1, 0, 0 ];
  var box = [ 1, 1, - 1, 2, 1, 0 ];
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  test.case = 'Zero box no intersection'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var box = _.box.makeZero( 3 );
  var expected = false;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  test.case = 'Zero box intersection'; /* */

  var plane = [ 4, - 2, 1, 0 ];
  var box = _.box.makeZero( 3 );
  var expected = true;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );


  test.case = 'Nil box'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var box = _.box.makeNil();
  var expected = false;

  var gotBool = _.plane.boxIntersects( plane, box );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.boxIntersects( ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 1, 0, 2, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1 ], [ 0, 0, 1, 0, 2, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( null, [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( NaN, [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( [ 0, 0, 1, 0 ], 'box' ));
  test.shouldThrowErrorSync( () => _.plane.boxIntersects( 'plane', [ 0, 1, 0, 1 ] ));

}

//

function boxClosestPoint( test )
{

  test.case = 'box and plane stay unchanged'; /* */

  var plane = [ 1, 0, 0, 1 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ - 1, 0, 0 ];

  var gotPoint = _.plane.boxClosestPoint( plane, box );
  test.identical( expected, gotPoint );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  var oldbox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( box, oldbox );

  test.case = 'Trivial'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var plane = [ 1, 0, 0, - 3 ];
  var expected = [ 3, 0, 0 ];

  var gotPoint = _.plane.boxClosestPoint( plane, box );
  test.identical( gotPoint, expected );

  test.case = 'Diagonal plane'; /* */

  var plane = [ - 1, 1, 0, - 2 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ -0.5, 1.5, 0 ];

  var gotPoint = _.plane.boxClosestPoint( plane, box );
  test.identical( gotPoint, expected );

  test.case = 'Intersection z'; /* */

  var plane = [ 0, 0, 1, - 2 ];
  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotPoint = _.plane.boxClosestPoint( plane, box );
  test.identical( gotPoint, expected );

  test.case = 'Intersection diagonal plane'; /* */

  var plane = [ 1, - 1, 0, 0 ];
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotPoint = _.plane.boxClosestPoint( plane, box );
  test.identical( gotPoint, expected );

  test.case = 'Intersection one side of box in plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var box = [ 0, - 2, 0, 1, 3, 3 ];
  var expected = 0;

  var gotPoint = _.plane.boxClosestPoint( plane, box );
  test.identical( gotPoint, expected );

  test.case = 'Intersection one edge of box in plane'; /* */

  var plane = [ 1, - 1, 0, 0 ];
  var box = [ 1, 1, - 1, 2, 1, 0 ];
  var expected = 0;

  var gotPoint = _.plane.boxClosestPoint( plane, box );
  test.identical( gotPoint, expected );

  test.case = 'Zero box'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var box = _.box.makeZero( 3 );
  var expected = [ 0, 1, 0 ];

  var gotPoint = _.plane.boxClosestPoint( plane, box );
  test.identical( gotPoint, expected );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( ));
  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 1, 0, 2, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( [ 0, 0, 1 ], [ 0, 0, 1, 0, 2, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( null, [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( NaN, [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( [ 0, 0, 1, 0 ], 'box' ));
  test.shouldThrowErrorSync( () => _.plane.boxClosestPoint( 'plane', [ 0, 1, 0, 1 ] ));

}

//

function boundingBoxGet( test )
{

  test.case = 'Source plane remains unchanged'; /* */

  var srcPlane = [ 1, 2, 3, 4 ];
  var dstBox = [ 1, 1, 1, 2, 2, 2 ];
  var expected = [ - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( expected, gotBox );
  test.is( dstBox === gotBox );

  var oldSrcPlane = [ 1, 2, 3, 4 ];
  test.identical( srcPlane, oldSrcPlane );

  test.case = 'Zero plane'; /* */

  var srcPlane = [ 0, 0, 0, 0 ];
  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( gotBox, expected );

  test.case = 'Plane perpendicular to x axis'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = [ 0, - Infinity, - Infinity, 0, Infinity, Infinity ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( gotBox, expected );

  test.case = 'Plane perpendicular to x axis with bias'; /* */

  var srcPlane = [ 3, 0, 0, - 6 ];
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = [ 2, - Infinity, - Infinity, 2, Infinity, Infinity ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( gotBox, expected );

  test.case = 'Plane perpendicular to y axis'; /* */

  var srcPlane = [ 0, - 3, 0, 0 ];
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = [  - Infinity, 0, - Infinity, Infinity, 0, Infinity ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( gotBox, expected );

  test.case = 'Plane perpendicular to y axis with bias'; /* */

  var srcPlane = [ 0, 3, 0, 12 ];
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = [  - Infinity, - 4, - Infinity, Infinity, - 4, Infinity ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( gotBox, expected );

  test.case = 'Plane perpendicular to z axis'; /* */

  var srcPlane = [ 0, 0, - 1, 0 ];
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = [ - Infinity, - Infinity, 0, Infinity, Infinity, 0 ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( gotBox, expected );

  test.case = 'Plane perpendicular to z axis with bias'; /* */

  var srcPlane = [ 0, 0, 12, - 6 ];
  var dstBox = [ 0, 0, 0, 5, 5, 5 ];
  var expected = [ - Infinity, - Infinity, 0.5, Infinity, Infinity, 0.5 ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( gotBox, expected );

  test.case = 'srcPlane vector'; /* */

  var srcPlane = _.vector.from( [ - 8, - 5, 4.5, 4 ] );
  var dstBox = [ 1, - 1, 5, 0, 3, 2 ];
  var expected = [ - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( gotBox, expected );

  test.case = 'dstBox vector - 2D'; /* */

  var srcPlane = [ - 4, 0, 1 ];
  var dstBox = _.vector.from( [ 1, 2, 3, 9 ] );
  var expected = _.vector.from( [ 0.25, - Infinity, 0.25, Infinity ] );

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( gotBox, expected );

  test.case = 'dstBox null'; /* */

  var srcPlane = [ 2.2, 3.3, - 4.4 ];
  var dstBox = null;
  var expected = [ - Infinity, - Infinity, Infinity, Infinity ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.equivalent( gotBox, expected );

  test.case = 'dstBox undefined'; /* */

  var srcPlane = [ 0, - 5, - 3 ];
  var dstBox = undefined;
  var expected = [  - Infinity, - 3 / 5, Infinity, - 3 / 5 ];

  var gotBox = _.plane.boundingBoxGet( dstBox, srcPlane );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( ) );
  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( [] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( 'box', 'plane' ) );
  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( [ 1, 0, 1, 2, 1, 2 ], [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4, 5 ] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.plane.boundingBoxGet( [ 0, 1, 0, 1, 2 ], [ 0, 0, 1 ] ) );

}

//

function capsuleClosestPoint( test )
{

  test.case = 'capsule and plane stay unchanged'; /* */

  var plane = [ 1, 0, 0, 1 ];
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.5 ];
  var expected = [ - 1, 0, 0 ];

  var gotPoint = _.plane.capsuleClosestPoint( plane, capsule );
  test.identical( expected, gotPoint );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  var oldCapsule = [ 0, 0, 0, 1, 1, 1, 0.5 ];
  test.identical( capsule, oldCapsule );

  test.case = 'Trivial'; /* */

  var capsule = [ 0, 0, 0, 2, 2, 2, 0.5 ];
  var plane = [ 1, 0, 0, - 3 ];
  var expected = [ 3, 2, 2 ];

  var gotPoint = _.plane.capsuleClosestPoint( plane, capsule );
  test.identical( gotPoint, expected );

  test.case = 'Diagonal plane'; /* */

  var plane = [ - 1, 1, 0, - 2 ];
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.1 ];
  var expected = [ -1, 1, 0 ];

  var gotPoint = _.plane.capsuleClosestPoint( plane, capsule );
  test.identical( gotPoint, expected );

  test.case = 'Intersection z'; /* */

  var plane = [ 0, 0, 1, - 2 ];
  var capsule = [ 0, 0, 0, 2, 2, 2, 0.5 ];
  var expected = 0;

  var gotPoint = _.plane.capsuleClosestPoint( plane, capsule );
  test.identical( gotPoint, expected );

  test.case = 'Intersection diagonal plane'; /* */

  var plane = [ 1, - 1, 0, 0 ];
  var capsule = [ 0, 0, 0, 1, 1, 1, 0.5 ];
  var expected = 0;

  var gotPoint = _.plane.capsuleClosestPoint( plane, capsule );
  test.identical( gotPoint, expected );

  test.case = 'Intersection one side of capsule in plane'; /* */

  var plane = [ 0, 2, 0, 0 ];
  var capsule = [ 0, - 2, 1, 0, - 2, 2, 2 ];
  var expected = 0;

  var gotPoint = _.plane.capsuleClosestPoint( plane, capsule );
  test.identical( gotPoint, expected );

  test.case = 'Zero capsule'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var capsule = _.capsule.makeZero( 3 );
  var expected = [ 0, 1, 0 ];

  var gotPoint = _.plane.capsuleClosestPoint( plane, capsule );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0, 1 ], [ 0, 0, 1, 0, 2, 2, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( [ 0, 0, 1 ], [ 0, 0, 1, 0, 2, 2, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( null, [ 0, 1, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( NaN, [ 0, 1, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( [ 0, 0, 1, 0 ], 'capsule' ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( 'plane', [ 0, 1, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.capsuleClosestPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0, - 1 ] ));

}

//

function frustumClosestPoint( test )
{
  test.case = 'Plane and frustum remain unchanged'; /* */

  var srcPlane = [ 1, 0, 0, 1 ];
  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var expected = [ -1, 1, 1 ];

  var gotPoint = _.plane.frustumClosestPoint( srcPlane, srcFrustum );
  test.identical( expected, gotPoint );

  var oldSrcPlane = [ 1, 0, 0, 1 ];
  test.identical( srcPlane, oldSrcPlane );

  var oldSrcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( srcFrustum, oldSrcFrustum );

  test.case = 'srcFrustum and plane don´t intersect'; /* */

  var srcPlane = [ 1, 0, 0, 1 ];
  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var expected = [ -1, 1, 1 ];

  var gotPoint = _.plane.frustumClosestPoint( srcPlane, srcFrustum );
  test.identical( expected, gotPoint );

  test.case = 'srcFrustum and Plane intersect'; /* */

  var srcPlane = [ 2, 4, - 4, - 6 ];
  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.plane.frustumClosestPoint( srcPlane, srcFrustum );
  test.identical( expected, gotPoint );

  test.case = 'Plane is frustum side'; /* */

  var srcPlane = [ 1, 0 , 0, -1 ];
  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var expected = 0;

  var gotPoint = _.plane.frustumClosestPoint( srcPlane, srcFrustum );
  test.identical( expected, gotPoint );

  test.case = 'srcFrustum corner opposite to plane'; /* */

  var srcPlane = [ 1, 1, 1, 3 ];
  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var expected = [ -1, -1, -1 ];

  var gotPoint = _.plane.frustumClosestPoint( srcPlane, srcFrustum );
  test.equivalent( expected, gotPoint );

  test.case = 'srcFrustum and srcPlane are parallel'; /* */

  var srcPlane = [ 1, 0, 0, 4 ];
  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var expected = [ - 4, 1, 1 ];

  var gotPoint = _.plane.frustumClosestPoint( srcPlane, srcFrustum );
  test.equivalent( expected, gotPoint );

  test.case = 'dstPoint is vector'; /* */

  var srcPlane = [ 1, 0, 0, 4 ];
  var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var dstPoint = _.vector.from( [ 0, 0, 0 ] )
  var expected = _.vector.from( [ - 4, 1, 1 ] );

  var gotPoint = _.plane.frustumClosestPoint( srcPlane, srcFrustum, dstPoint );
  test.equivalent( expected, gotPoint );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.frustumClosestPoint( ));
  test.shouldThrowErrorSync( () => _.plane.frustumClosestPoint( [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.frustumClosestPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.frustumClosestPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.frustumClosestPoint( null , [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.frustumClosestPoint( NaN, [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.frustumClosestPoint( [ 0, 2, 0, 1 ] , null ));
  test.shouldThrowErrorSync( () => _.plane.frustumClosestPoint( [ 0, - 1, 0, 2 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.frustumClosestPoint( 'plane', [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.frustumClosestPoint( [ 0, 1, 0, 0 ], 'plane' ));
}

//

function lineIntersects( test )
{

  test.case = 'Plane and line remain unchanged'; /* */

  var plane = [ 1, 0, 0, 1 ];
  var line = [ 1, 0, 1, 1, 1, 1 ];
  var expected = true;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  var oldLine = [ 1, 0, 1, 1, 1, 1 ];
  test.identical( line, oldLine );

  test.case = 'Line and plane intersect'; /* */

  var plane = [ 1, 0, 0, 1 ];
  var line = [ - 2, - 2, - 2 , 2, 2, 2 ];
  var expected = true;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  test.case = 'Line and Plane intersect'; /* */

  var plane = [ 1, 0, - 1, 0 ];
  var line = [ 2, 2, 1, 1, 1, 3 ];
  var expected = true;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  test.case = 'Line and Plane don´t intersect - parallel'; /* */

  var plane = [ 1, 0, - 1, 0 ];
  var line = [ 2, 2, 3, 0, 1, 0 ];
  var expected = false;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  test.case = 'Line and Plane don´t intersect - parallel opposite'; /* */

  var plane = [ 1, 0, - 1, 0 ];
  var line = [ 2, 3, -3, 0, -1, 0 ];
  var expected = false;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  test.case = 'Line in Plane'; /* */

  var plane = [ 1, 0, 0, 0 ];
  var line = [ 0, 2, 3, 0, 3, 4 ];
  var expected = true;

  var interBool = _.plane.lineIntersects( plane, line );
  test.equivalent( expected, interBool );

  test.case = 'Perpendicular line intersects'; /* */

  var plane = [ 1, 0, 0, 0 ];
  var line = [ 1, 2, 2, 1, 0, 0 ];
  var expected = true;

  var interBool = _.plane.lineIntersects( plane, line );
  test.identical( expected, interBool );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.lineIntersects( ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 0, 1, 0 ], [ [ 0, - 1, 0 ], [ 0, 3, 1, 2 ] ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 0, 1, 0, 2 ], [ [ 0, - 1, 0 ], [ 3, 1, 2 ] ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 0, 1, 0 ], [ [ 0, - 1, 0 ], [ 0, 3, 1 ] ], [ [ 0, - 1, 0 ], [ 0, 3, 1 ] ]  ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( null , [ [ 0, - 1, 0 ], [ 3, 1, 2 ] ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( NaN, [ [ 0, - 1, 0 ], [ 3, 1, 2 ] ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, 2, 0, 1 ] , null ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, - 1, 0, 2 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( [ 0, - 1, 0, 2 ], [ NaN, NaN ] ));
  test.shouldThrowErrorSync( () => _.plane.lineIntersects( 'plane', 'line' ));
}

//

function lineClosestPoint( test )
{

  test.case = 'Source plane and line remain unchanged'; /* */

  var srcPlane = [ - 1, 0, 0, 2 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotLine = _.plane.lineClosestPoint( srcPlane, tstLine );
  test.identical( expected, gotLine );

  var oldSrcPlane = [ - 1, 0, 0, 2 ];
  test.identical( srcPlane, oldSrcPlane );

  var oldtstLine = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstLine, oldtstLine );

  test.case = 'Plane and line intersect'; /* */

  var srcPlane = [ - 1, 0, 0, 1 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotLine = _.plane.lineClosestPoint( srcPlane, tstLine );
  test.identical( expected, gotLine );

  test.case = 'Line origin is in plane'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstLine = [ 0, 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotLine = _.plane.lineClosestPoint( srcPlane, tstLine );
  test.identical( expected, gotLine );

  test.case = 'Line is in plane '; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstLine = [ 0, 0, 0, 0, 1, 0 ];
  var expected = 0;

  var gotLine = _.plane.lineClosestPoint( srcPlane, tstLine );
  test.identical( expected, gotLine );

  test.case = 'Negative factor'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstLine = [ -3, -3, -3, -2, -2, -2 ];
  var expected = 0;

  var gotLine = _.plane.lineClosestPoint( srcPlane, tstLine );
  test.identical( expected, gotLine );

  test.case = 'Closest point is origin'; /* */

  var srcPlane = [ 0, 0, -1, 3 ];
  var tstLine = [ 5, 5, 2, 0, 1, 0 ];
  var expected = [ 5, 5, 3 ];

  var gotLine = _.plane.lineClosestPoint( srcPlane, tstLine );
  test.identical( expected, gotLine );

  test.case = 'dstPoint Array'; /* */

  var srcPlane = [ 0, 0, 1, -1 ];
  var tstLine = [ 4, 4, 3, 1, 0, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 4, 4, 1 ];

  var gotLine = _.plane.lineClosestPoint( srcPlane, tstLine, dstPoint );
  test.identical( expected, gotLine );
  test.is( dstPoint === gotLine );

  test.case = 'dstPoint Vector'; /* */

  var srcPlane = [ 0, 1, 0, -2 ];
  var tstLine = [ 5, 5, 1, 1, 0, 0 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 5, 2, 1 ] );

  var gotLine = _.plane.lineClosestPoint( srcPlane, tstLine, dstPoint );
  test.equivalent( expected, gotLine );
  test.is( dstPoint === gotLine );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.lineClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.plane.lineClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.plane.lineClosestPoint( 'plane', 'line' ) );
  test.shouldThrowErrorSync( () => _.plane.lineClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.plane.lineClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.plane.lineClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.plane.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.plane.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.plane.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function planeIntersects( test )
{
  test.case = 'Planes remain unchanged'; /* */

  var srcPlane = [ 1, 0, 0, 1 ];
  var tstPlane = [ 1, 1, 0, 1 ];
  var expected = true;

  var gotBool = _.plane.planeIntersects( srcPlane, tstPlane );
  test.identical( expected, gotBool );

  var oldSrcPlane = [ 1, 0, 0, 1 ];
  test.identical( srcPlane, oldSrcPlane );

  var oldtstPlane = [ 1, 1, 0, 1 ];
  test.identical( tstPlane, oldtstPlane );

  test.case = 'tstPlane and plane intersect'; /* */

  var srcPlane = [ 1, 0, 0, 1 ];
  var tstPlane = [ 1, 0, 1, 0 ];
  var expected = true;

  var gotBool = _.plane.planeIntersects( srcPlane, tstPlane );
  test.identical( expected, gotBool );

  test.case = 'tstPlane and Plane don´t intersect'; /* */

  var srcPlane = [ 1, 0 , - 1, 0 ];
  var tstPlane = [ 1, 0, -1, 2 ];
  var expected = false;

  var gotBool = _.plane.planeIntersects( srcPlane, tstPlane );
  test.identical( expected, gotBool );

  test.case = 'tstPlane and Plane don´t intersect'; /* */

  var srcPlane = [ 1, 0 , - 1, 0 ];
  var tstPlane = [ 2, 0, -2, 1 ];
  var expected = false;

  var gotBool = _.plane.planeIntersects( srcPlane, tstPlane );
  test.identical( expected, gotBool );

  test.case = 'tstPlane and srcPlane are the same'; /* */

  var srcPlane = [ 1, 0, 0, 0 ];
  var tstPlane = [ 1, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.plane.planeIntersects( srcPlane, tstPlane );
  test.equivalent( expected, gotBool );

  test.case = 'tstPlane and srcPlane are the same'; /* */

  var srcPlane = [ 1, 0, 2, 1 ];
  var tstPlane = [ 2, 0, 4, 2 ];
  var expected = true;

  var gotBool = _.plane.planeIntersects( srcPlane, tstPlane );
  test.equivalent( expected, gotBool );

  test.case = 'tstPlane and srcPlane are parallel'; /* */

  var srcPlane = [ 1, 0, 2, 1 ];
  var tstPlane = [ 2, 0, 4, 1 ];
  var expected = false;

  var gotBool = _.plane.planeIntersects( srcPlane, tstPlane );
  test.equivalent( expected, gotBool );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.planeIntersects( ));
  test.shouldThrowErrorSync( () => _.plane.planeIntersects( [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeIntersects( null , [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeIntersects( NaN, [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeIntersects( [ 0, 2, 0, 1 ] , null ));
  test.shouldThrowErrorSync( () => _.plane.planeIntersects( [ 0, - 1, 0, 2 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.planeIntersects( 'plane', [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeIntersects( [ 0, 1, 0, 0 ], 'plane' ));
}

//

function planeDistance( test )
{
  test.case = 'Planes remain unchanged'; /* */

  var srcPlane = [ 1, 0, 0, 1 ];
  var tstPlane = [ 1, 1, 0, 1 ];
  var expected = 0;

  var gotDist = _.plane.planeDistance( srcPlane, tstPlane );
  test.identical( expected, gotDist );

  var oldSrcPlane = [ 1, 0, 0, 1 ];
  test.identical( srcPlane, oldSrcPlane );

  var oldtstPlane = [ 1, 1, 0, 1 ];
  test.identical( tstPlane, oldtstPlane );

  test.case = 'tstPlane and plane intersect'; /* */

  var srcPlane = [ 1, 0, 0, 1 ];
  var tstPlane = [ 1, 0, 1, 0 ];
  var expected = 0;

  var gotDist = _.plane.planeDistance( srcPlane, tstPlane );
  test.identical( expected, gotDist );

  test.case = 'tstPlane and Plane don´t intersect'; /* */

  var srcPlane = [ 2, 4, - 4, - 6 ];
  var tstPlane = [ 1, 2, - 2, 9 ];
  var expected = 4;

  var gotDist = _.plane.planeDistance( srcPlane, tstPlane );
  test.identical( expected, gotDist );

  test.case = 'tstPlane and Plane don´t intersect'; /* */

  var srcPlane = [ 1, 0 , - 1, 0 ];
  var tstPlane = [ 2, 0, -2, 1 ];
  var expected = 0.5 / Math.sqrt( 2 );

  var gotDist = _.plane.planeDistance( srcPlane, tstPlane );
  test.identical( expected, gotDist );

  test.case = 'tstPlane and srcPlane are the same'; /* */

  var srcPlane = [ 1, 0, 0, 0 ];
  var tstPlane = [ 1, 0, 0, 0 ];
  var expected = 0;

  var gotDist = _.plane.planeDistance( srcPlane, tstPlane );
  test.equivalent( expected, gotDist );

  test.case = 'tstPlane and srcPlane are the same'; /* */

  var srcPlane = [ 1, 0, 2, 1 ];
  var tstPlane = [ 2, 0, 4, 2 ];
  var expected = 0;

  var gotDist = _.plane.planeDistance( srcPlane, tstPlane );
  test.equivalent( expected, gotDist );

  test.case = 'tstPlane and srcPlane are parallel'; /* */

  var srcPlane = [ 1, 0, 2, 1 ];
  var tstPlane = [ 2, 0, 4, 1 ];
  var expected = 0.5 / Math.sqrt( 5 );

  var gotDist = _.plane.planeDistance( srcPlane, tstPlane );
  test.equivalent( expected, gotDist );

  test.case = 'tstPlane and srcPlane exchange - same result'; /* */

  var srcPlane = [ 2, 0, 4, 1 ];
  var tstPlane = [ 1, 0, 2, 1 ];
  var expected = 0.5 / Math.sqrt( 5 );

  var gotDist = _.plane.planeDistance( srcPlane, tstPlane );
  test.equivalent( expected, gotDist );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.planeDistance( ));
  test.shouldThrowErrorSync( () => _.plane.planeDistance( [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeDistance( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeDistance( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeDistance( null , [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeDistance( NaN, [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeDistance( [ 0, 2, 0, 1 ] , null ));
  test.shouldThrowErrorSync( () => _.plane.planeDistance( [ 0, - 1, 0, 2 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.planeDistance( 'plane', [ 0, 1, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.planeDistance( [ 0, 1, 0, 0 ], 'plane' ));
}

//

function rayClosestPoint( test )
{

  test.case = 'Source plane and ray remain unchanged'; /* */

  var srcPlane = [ - 1, 0, 0, - 2 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = [ - 2, 0, 0 ];

  var gotRay = _.plane.rayClosestPoint( srcPlane, tstRay );
  test.identical( expected, gotRay );

  var oldSrcPlane = [ - 1, 0, 0, - 2 ];
  test.identical( srcPlane, oldSrcPlane );

  var oldtstRay = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstRay, oldtstRay );

  test.case = 'Plane and ray intersect'; /* */

  var srcPlane = [ - 1, 0, 0, 2  ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotRay = _.plane.rayClosestPoint( srcPlane, tstRay );
  test.identical( expected, gotRay );

  test.case = 'Ray origin is in the plane'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotRay = _.plane.rayClosestPoint( srcPlane, tstRay );
  test.identical( expected, gotRay );

  test.case = 'Ray origin in plane pointing to the other side'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, -1, -1, -1 ];
  var expected = 0;

  var gotRay = _.plane.rayClosestPoint( srcPlane, tstRay );
  test.identical( expected, gotRay );

  test.case = 'Ray origin is the closest point'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstRay = [ -3, -3, -3, -2, -2, -2 ];
  var expected = [ 0, -3, -3 ];

  var gotRay = _.plane.rayClosestPoint( srcPlane, tstRay );
  test.identical( expected, gotRay );

  test.case = 'Ray and plane are parallel'; /* */

  var srcPlane = [ 0, - 1, 0, 4 ];
  var tstRay = [ 5, 5, 2, 1, 0, 1 ];
  var expected = [ 5, 4, 2 ];

  var gotRay = _.plane.rayClosestPoint( srcPlane, tstRay );
  test.identical( expected, gotRay );

  test.case = 'dstPoint Array'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstRay = [ 5, 5, 1, 1, 0, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 0, 5, 1 ];

  var gotRay = _.plane.rayClosestPoint( srcPlane, tstRay, dstPoint );
  test.identical( expected, gotRay );
  test.is( dstPoint === gotRay );

  test.case = 'dstPoint Vector'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstRay = [ 5, 5, 1, 1, 0, 0 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 0, 5, 1 ] );

  var gotRay = _.plane.rayClosestPoint( srcPlane, tstRay, dstPoint );
  test.equivalent( expected, gotRay );
  test.is( dstPoint === gotRay );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.rayClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.plane.rayClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.plane.rayClosestPoint( 'plane', 'ray' ) );
  test.shouldThrowErrorSync( () => _.plane.rayClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.plane.rayClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.plane.rayClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.plane.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.plane.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.plane.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function segmentIntersects( test )
{

  test.case = 'Plane and segment remain unchanged'; /* */

  var plane = [ 1, 0, 0, 1 ];
  var segment = [ 1, 0, 1, 2, 1, 2 ];
  var expected = false;

  var interBool = _.plane.segmentIntersects( plane, segment );
  test.identical( expected, interBool );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  var oldSegment = [ 1, 0, 1, 2, 1, 2 ];
  test.identical( segment, oldSegment );

  test.case = 'Segment and plane intersect'; /* */

  var plane = [ 1, 0, 0, 1 ];
  var segment = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = true;

  var interBool = _.plane.segmentIntersects( plane, segment );
  test.identical( expected, interBool );

  test.case = 'Segment and Plane intersect'; /* */

  var plane = [ 1, 0, - 1, 0 ];
  var segment = [ 2, 2, 2, 3, 3, 3 ];
  var expected = true;

  var interBool = _.plane.segmentIntersects( plane, segment );
  test.identical( expected, interBool );

  test.case = 'Segment and Plane don´t intersect'; /* */

  var plane = [ 1, 0, - 1, 0 ];
  var segment = [ 2, 2, 3, 3, 3, 4 ];
  var expected = false;

  var interBool = _.plane.segmentIntersects( plane, segment );
  test.identical( expected, interBool );

  test.case = 'Segment in Plane'; /* */

  var plane = [ 1, 0, 0, 0 ];
  var segment = [ 0, 2, 3, 0, 5, 7 ];
  var expected = true;

  var interBool = _.plane.segmentIntersects( plane, segment );
  test.equivalent( expected, interBool );

  test.case = 'Perpendicular segment intersects'; /* */

  var plane = [ 1, 0, 0, 0 ];
  var segment = [ - 2, 2, 2, 2, 2, 2 ];
  var expected = true;

  var interBool = _.plane.segmentIntersects( plane, segment );
  test.identical( expected, interBool );

  test.case = 'Perpendicular segment touches plane'; /* */

  var plane = [ 1, 0, 0, 0 ];
  var segment = [ - 2, 2, 2, 0, 2, 2 ];
  var expected = true;

  var interBool = _.plane.segmentIntersects( plane, segment );
  test.identical( expected, interBool );

  test.case = 'Perpendicular doesn´t intersect'; /* */

  var plane = [ 1, 0, 0, 0 ];
  var segment = [ - 2, 2, 2, - 1, 2, 2 ];
  var expected = false;

  var interBool = _.plane.segmentIntersects( plane, segment );
  test.identical( expected, interBool );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( [ 0, 0, 1, 0 ], [ 0, - 1, 0, 0, 3, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( [ 0, 0, 1, 0, 2 ], [ 0, - 1, 0, 3, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( [ 0, 0, 1, 0 ], [ 0, - 1, 0, 0, 3, 1 ], [ 0, - 1, 0, 0, 3, 1 ]  ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( null , [ 0, - 1, 0, 3, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( NaN, [ 0, - 1, 0, 3, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( [ 0, 2, 0, 1 ] , null ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( [ 0, - 1, 0, 2 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( [ 0, - 1, 0, 2 ], [ NaN, NaN ] ));
  test.shouldThrowErrorSync( () => _.plane.segmentIntersects( 'plane', 'segment' ));
}

//

function segmentClosestPoint( test )
{

  test.case = 'Source plane and segment remain unchanged'; /* */

  var srcPlane = [ - 1, 0, 0, 2 ];
  var tstSegment = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment );
  test.identical( expected, gotSegment );

  var oldSrcPlane = [ - 1, 0, 0, 2 ];
  test.identical( srcPlane, oldSrcPlane );

  var oldtstSegment = [ 0, 0, 0, 2, 2, 2 ];
  test.identical( tstSegment, oldtstSegment );

  test.case = 'Plane and segment intersect'; /* */

  var srcPlane = [ - 1, 0, 0, 1 ];
  var tstSegment = [ 0, 0, 0, 2, 2, 2 ];
  var expected = 0;

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Segment origin is in plane'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Segment end is in plane'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstSegment = [ -3, -3, -3, 0, 0, 0 ];
  var expected = 0;

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Segment is in plane '; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 0, 0, 1, 0 ];
  var expected = 0;

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Negative factor - no intersection'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstSegment = [ 2, 2, 2, 3, 3, 3 ];
  var expected = [ 0, 2, 2 ];

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Positive factor - no intersection'; /* */

  var srcPlane = [ - 1, 0, 0, 0 ];
  var tstSegment = [ -3, -3, -3, -2, -2, -2 ];
  var expected = [ 0, -2, -2 ];

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Closest point is origin'; /* */

  var srcPlane = [ 0, 0, -1, 3 ];
  var tstSegment = [ 5, 5, 2, 0, 1, 0 ];
  var expected = [ 5, 5, 3 ];

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Closest point is end'; /* */

  var srcPlane = [ 0, 0, -1, 3 ];
  var tstSegment = [ 0, 1, 0, 5, 5, 2 ];
  var expected = [ 5, 5, 3 ];

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'dstPoint Array'; /* */

  var srcPlane = [ 0, 0, 1, -1 ];
  var tstSegment = [ 1, 0, 0, 4, 4, - 3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 1, 0, 1 ];

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment, dstPoint );
  test.identical( expected, gotSegment );
  test.is( dstPoint === gotSegment );

  test.case = 'dstPoint Vector'; /* */

  var srcPlane = [ 0, 1, 0, -2 ];
  var tstSegment = [ 1, 0, 0, 5, - 5, 1 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 1, 2, 0 ] );

  var gotSegment = _.plane.segmentClosestPoint( srcPlane, tstSegment, dstPoint );
  test.equivalent( expected, gotSegment );
  test.is( dstPoint === gotSegment );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.segmentClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.plane.segmentClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.plane.segmentClosestPoint( 'plane', 'segment' ) );
  test.shouldThrowErrorSync( () => _.plane.segmentClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.plane.segmentClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.plane.segmentClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.plane.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.plane.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.plane.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function sphereIntersects( test )
{

  test.case = 'Sphere and plane stay unchanged'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var oldPlane = plane.slice();
  var sphere = [ 2, 0, 0, 1 ];
  var oldSphere = sphere.slice();
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( expected, gotBool );
  test.identical( plane, oldPlane );
  test.identical( sphere, oldSphere );

  test.case = 'Trivial - no intersection'; /* */

  var sphere = [ 2, 0, 0, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Trivial - intersection'; /* */

  var plane = [ 0, 2, 0, - 2 ];
  var sphere = [ 1, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Center in plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, - 1, 0, 1 ];
  var expected = true;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere cuts plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1.5 ];
  var expected = true;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere touches plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = true;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere under plane'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ - 1, - 1, - 1, 1 ];
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere over plane'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ 0, 3, 0, 1 ];
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Zero sphere'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = _.sphere.makeZero();
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  test.case = 'Nil sphere'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = _.sphere.makeNil();
  var expected = false;

  var gotBool = _.plane.sphereIntersects( plane, sphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( null, [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( NaN, [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( [ 0, 0, 1, 0 ], 'sphere' ));
  test.shouldThrowErrorSync( () => _.plane.sphereIntersects( 'plane', [ 0, 1, 0, 1 ] ));

}

//

function sphereDistance( test )
{

  test.case = 'Sphere and plane stay unchanged'; /* */

  var plane = [ 1, 0, 0, 1 ];
  var oldPlane = plane.slice();
  var sphere = [ 2, 0, 0, 1 ];
  var oldSphere = sphere.slice();
  var expected = 2;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( expected, distance );
  test.identical( plane, oldPlane );
  test.identical( sphere, oldSphere );

  test.case = 'Trivial'; /* */

  var sphere = [ 2, 0, 0, 1 ];
  var plane = [ 1, 0, 0, 1 ];
  var expected = 2;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Trivial 2'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 1, 1, 1, 1 ];
  var expected = 1;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Center in plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, - 1, 0, 1 ];
  var expected = 0;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Sphere cuts plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1.5 ];
  var expected = 0;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Sphere touches plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Sphere under plane'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ - 1, - 1, - 1, 1 ];
  var expected = 1;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  test.case = 'Sphere over plane'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ 0, 3, 0, 1 ];
  var expected = 1;

  var distance = _.plane.sphereDistance( plane, sphere );
  test.identical( distance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.sphereDistance( ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.sphereDistance( NaN, [ 0, 1, 0 ] ));

}

//

function sphereClosestPoint( test )
{

  test.case = 'Sphere and plane stay unchanged'; /* */

  var plane = [ 1, 0, 0, 1 ];
  var sphere = [ 2, 0, 0, 1 ];
  var expected = [ -1, 0, 0 ];

  var gotPoint = _.plane.sphereClosestPoint( plane, sphere );
  test.identical( expected, gotPoint );

  var oldPlane = [ 1, 0, 0, 1 ];
  test.identical( plane, oldPlane );

  var oldSphere = [ 2, 0, 0, 1 ];
  test.identical( sphere, oldSphere );

  test.case = 'Trivial'; /* */

  var sphere = [ 2, 0, 0, 1 ];
  var plane = [ 1, 0, 0, 2 ];
  var expected = [ -2, 0, 0 ];

  var gotPoint = _.plane.sphereClosestPoint( plane, sphere );
  test.identical( gotPoint, expected );

  test.case = 'Trivial 2'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 1, 1, 1, 1 ];
  var expected = [ 1, - 1, 1 ];

  var gotPoint = _.plane.sphereClosestPoint( plane, sphere );
  test.identical( gotPoint, expected );

  test.case = 'Center in plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, - 1, 0, 1 ];
  var expected = 0;

  var gotPoint = _.plane.sphereClosestPoint( plane, sphere );
  test.identical( gotPoint, expected );

  test.case = 'Sphere cuts plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1.5 ];
  var expected = 0;

  var gotPoint = _.plane.sphereClosestPoint( plane, sphere );
  test.identical( gotPoint, expected );

  test.case = 'Sphere touches plane'; /* */

  var plane = [ 0, 2, 0, 2 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = 0;

  var gotPoint = _.plane.sphereClosestPoint( plane, sphere );
  test.identical( gotPoint, expected );

  test.case = 'Sphere under plane'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ - 1, - 1, - 1, 1 ];
  var expected = [ -1, 1, -1 ];

  var gotPoint = _.plane.sphereClosestPoint( plane, sphere );
  test.identical( gotPoint, expected );

  test.case = 'Sphere over plane'; /* */

  var plane = [ 0, - 2, 0, 2 ];
  var sphere = [ 0, 3, 0, 1 ];
  var expected = [ 0, 1, 0 ];

  var gotPoint = _.plane.sphereClosestPoint( plane, sphere );
  test.identical( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.sphereClosestPoint( ));
  test.shouldThrowErrorSync( () => _.plane.sphereClosestPoint( [ 0, 1, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereClosestPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereClosestPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereClosestPoint( [ 0, 0, 1 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereClosestPoint( [ 0, 0, 1, 0 ], null ));
  test.shouldThrowErrorSync( () => _.plane.sphereClosestPoint( null, [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.sphereClosestPoint( [ 0, 0, 1, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.plane.sphereClosestPoint( NaN, [ 0, 1, 0 ] ));

}

//

function boundingSphereGet( test )
{

  test.case = 'Source plane remains unchanged'; /* */

  var srcPlane = [ 0, 0, 3, 3 ];
  var dstSphere = [ 1, 1, 2, 1 ];
  var expected = [ 0, 0, - 1, Infinity ];

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.identical( expected, gotSphere );
  test.is( dstSphere === gotSphere );

  var oldSrcPlane = [ 0, 0, 3, 3 ];
  test.identical( srcPlane, oldSrcPlane );

  test.case = 'Zero plane to zero sphere'; /* */

  var srcPlane = [ 0, 0, 0, 0 ];
  var dstSphere = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, Infinity ];

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.identical( gotSphere, expected );

  test.case = 'Zero plane and point Sphere'; /* */

  var srcPlane = [ 0, 0, 0, 4 ];
  var dstSphere = [ 3, 3, 3, 0 ];
  var expected = [ 0, 0, 0, Infinity ];

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.identical( gotSphere, expected );

  test.case = 'Sphere and plane intersect'; /* */

  var srcPlane = [ 0, 0, 1, - 2 ];
  var dstSphere = [ 2, 2, 2, 1 ];
  var expected = [ 0, 0, 2, Infinity ];

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.identical( gotSphere, expected );

  test.case = 'Sphere and plane don´t intersect'; /* */

  var srcPlane = [ 1, 0, 0, 1 ];
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ - 1, 0, 0, Infinity ];

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.identical( gotSphere, expected );

  test.case = 'srcPlane vector'; /* */

  var srcPlane = _.vector.from( [- 1, - 1, - 1, 1 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ 1 / 3, 1 / 3, 1 / 3, Infinity ];

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere vector'; /* */

  var srcPlane = [- 1, - 1, - 1, 3 ];
  var dstSphere = _.vector.from( [ 5, 5, 5, 3 ] );
  var expected = _.vector.from( [ 1, 1, 1, Infinity ] );

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere null'; /* */

  var srcPlane = [- 1, 5, - 1, 0 ];
  var dstSphere = null;
  var expected = [ 0, 0, 0, Infinity ];

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere undefined'; /* */

  var srcPlane = [ - 1, - 3, - 5, 0 ];
  var dstSphere = undefined;
  var expected = [ 0, 0, 0, Infinity ];

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.identical( gotSphere, expected );

  test.case = 'Very small normal'; /* */

  var srcPlane = _.vector.from( [ 1E-12, 1E-12, 1E-12, 1E-12 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ - 1 / 3, - 1 / 3, - 1 / 3, Infinity ];

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.equivalent( gotSphere, expected );

  test.case = 'Dimension = 5'; /* */

  var srcPlane = [ 1, 0, 1, 2, 3, 4 ];
  var dstSphere = [ 0, 1, 0, 1, 2, 1 ];
  var expected = [ -0.26666666666666666, 0, -0.26666666666666666, -0.53333333333333333, -0.8, Infinity  ];

  var gotSphere = _.plane.boundingSphereGet( dstSphere, srcPlane );
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.boundingSphereGet( ) );
  test.shouldThrowErrorSync( () => _.plane.boundingSphereGet( [] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingSphereGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingSphereGet( 'sphere', 'plane' ) );
  test.shouldThrowErrorSync( () => _.plane.boundingSphereGet( [ 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingSphereGet( [ 0, 0, 0, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingSphereGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.plane.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.plane.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.plane.boundingSphereGet( [ 0, 1, 0, 1 ], [ 0, 0, 1, 2, 2, 3, 1 ] ) );

}

//

function translate( test )
{

  test.case = 'Offset remains unchanged, plane changes'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var offset = [ 1, 0, 1 ];
  var oldOffset = offset.slice();
  var expected = [ 1, 0, 0, 0 ];

  var newPlane = _.plane.translate( plane, offset );
  test.identical( expected, newPlane );
  test.identical( plane, newPlane );
  test.identical( offset, oldOffset );

  test.case = 'No change (normal and offset are perpendicular)'; /* */

  var plane = [ 1, 0 , 0, 1 ];
  var offset = [ 0, 2, 3 ];
  var expected = [ 1, 0 , 0, 1 ];

  var gotOffset = _.plane.translate( plane, offset );
  test.identical( expected, gotOffset );

  test.case = 'No change'; /* */

  var plane = [ 1, 0 , - 1, 0 ];
  var offset = [ 2, 2, 2 ];
  var expected = [ 1, 0 , - 1, 0 ];

  var gotOffset = _.plane.translate( plane, offset );
  test.identical( expected, gotOffset );

  test.case = 'Trivial translation'; /* */

  var plane = [ 1, 0 , 0, 0 ];
  var offset = [ 3, 2, 3 ];
  var expected =  [ 1, 0 , 0, - 3 ];

  var gotOffset = _.plane.translate( plane, offset );
  test.equivalent( expected, gotOffset );

  test.case = 'Negative offset'; /* */

  var plane = [ 1, 0 , 0, 0 ];
  var offset = [ - 3, - 2, - 3 ];
  var expected =  [ 1, 0 , 0, 3 ];

  var gotOffset = _.plane.translate( plane, offset );
  test.equivalent( expected, gotOffset );

  test.case = 'More dimensions'; /* */

  var plane = [ 1, 0 , 0, 2, 3, 4, 0 ];
  var offset = [ - 2, - 2, - 2, 2, 2, 2 ];
  var expected = [ 1, 0 , 0, 2, 3, 4, -16 ];

  var gotOffset = _.plane.translate( plane, offset );
  test.identical( expected, gotOffset );

  test.case = 'NaN offset'; /* */

  var plane = [ 1, 0 , 0, 0 ];
  var offset = [ NaN, NaN, NaN ];
  var expected =  [ 1, 0 , 0, NaN ];

  var gotOffset = _.plane.translate( plane, offset );
  test.equivalent( expected, gotOffset );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.translate( ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 1, 0 ], [ 0, 0, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 1, 0 ], [ 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( null, [ 0, 0, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( NaN, [ 0, 0, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 2 ], null ));
  test.shouldThrowErrorSync( () => _.plane.translate( [ 0, 0, 2 ], NaN));
  test.shouldThrowErrorSync( () => _.plane.translate( 'plane', 'offset' ));

}

//

function normalize( test )
{

  test.case = 'Plane changes'; /* */

  var plane = [ 2, 0 , 0, 1 ];
  var expected = [ 1, 0, 0, 0.5 ];

  var newPlane = _.plane.normalize( plane );
  test.identical( expected, newPlane );
  test.identical( plane, newPlane );

  test.case = 'Trivial '; /* */

  var plane = [ 2, 0 , 0, 4 ];
  var expected =  [ 1, 0 , 0, 2 ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'Trivial'; /* */

  var plane = [ 2, 2 , 2, 4 ];
  var expected = [ 2/Math.sqrt( 12 ), 2/Math.sqrt( 12 ), 2/Math.sqrt( 12 ), 4/Math.sqrt( 12 ) ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'Already normalized 1D'; /* */

  var plane = [ 1, 0 , 0, 3 ];
  var expected = [ 1, 0 , 0, 3 ];

  var normalized = _.plane.normalize( plane );
  test.identical( expected, normalized );

  test.case = 'Already normalized'; /* */

  var plane = [ 1/Math.sqrt( 2 ), 1/Math.sqrt( 2 ), 0, 2/Math.sqrt( 2 ) ];
  var expected = [1/Math.sqrt( 2 ), 1/Math.sqrt( 2 ), 0, 2/Math.sqrt( 2 ) ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'Negative coordinates'; /* */

  var plane = [ - 3, - 6 , 0, 8 ];
  var expected =  [ - 3/Math.sqrt( 45 ), - 6/Math.sqrt( 45 ) , 0, 8/Math.sqrt( 45 ) ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'More dimensions'; /* */

  var plane = [ 4, 0 , 0, 4, 0, 4, 8 ];
  var expected = [ 4/Math.sqrt( 48 ), 0 , 0, 4/Math.sqrt( 48 ), 0, 4/Math.sqrt( 48 ), 8/Math.sqrt( 48 ) ];

  var normalized = _.plane.normalize( plane );
  test.identical( expected, normalized );

  test.case = 'NaN result'; /* */

  var plane = [ NaN, NaN, NaN, NaN ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'Plane  [ 0 ]'; /* */

  var plane = [ 0 ];
  var expected =  [ NaN ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'Null coordinate'; /* */

  var plane = [ 1, null, 0, 0 ];
  var expected =  [ 1, 0, 0, 0 ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'NaN coordinates'; /* */

  var plane = [ 1, NaN, 0, 0 ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );

  test.case = 'String coordinates'; /* */

  var plane = [ 1, 'string', 0, 0 ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  var normalized = _.plane.normalize( plane );
  test.equivalent( expected, normalized );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.normalize( ));
  test.shouldThrowErrorSync( () => _.plane.normalize( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.normalize( null ));
  test.shouldThrowErrorSync( () => _.plane.normalize( NaN ));
  test.shouldThrowErrorSync( () => _.plane.normalize( 'plane' ));

}

//

function negate( test )
{

  test.case = 'Zero'; /* */

  var plane = [ 0, 0 , 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var newPlane = _.plane.negate( plane );
  test.equivalent( expected, newPlane );
  test.identical( plane, newPlane );

  test.case = 'Plane changes'; /* */

  var plane = [ 2, 0 , 0, 1 ];
  var expected = [ - 2, 0, 0, - 1 ];

  var newPlane = _.plane.negate( plane );
  test.equivalent( expected, newPlane );
  test.identical( plane, newPlane );

  test.case = 'Trivial '; /* */

  var plane = [ 2, 0 , 0, 4 ];
  var expected =  [ - 2, 0 , 0, - 4 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Trivial'; /* */

  var plane = [ 2, 2 , 2, 4 ];
  var expected = [ - 2, - 2, - 2, - 4 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Negate 1D'; /* */

  var plane = [ 1, 0 , 0, 3 ];
  var expected = [ - 1, 0 , 0, - 3 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Negate'; /* */

  var plane = [ 1/Math.sqrt( 2 ), 1/Math.sqrt( 2 ), 0, 2/Math.sqrt( 2 ) ];
  var expected = [ - 1/Math.sqrt( 2 ), - 1/Math.sqrt( 2 ), 0, - 2/Math.sqrt( 2 ) ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Negative coordinates'; /* */

  var plane = [ - 3, - 6 , 0, 8 ];
  var expected =  [ 3, 6, 0, - 8 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'More dimensions'; /* */

  var plane = [ 4, 0 , 0, 4, 0, 4, 8 ];
  var expected = [  - 4, 0 , 0, - 4, 0, - 4, - 8 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'NaN result'; /* */

  var plane = [ NaN, NaN, NaN, NaN ];
  var expected =  [ NaN, NaN, NaN, NaN ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Plane  [ 0 ]'; /* */

  var plane = [ 0 ];
  var expected =  [ 0 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'Null coordinate'; /* */

  var plane = [ 1, null, 0, 0 ];
  var expected =  [ - 1, 0, 0, 0 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'NaN coordinates'; /* */

  var plane = [ 1, NaN, 0, 0 ];
  var expected =  [ - 1, NaN, 0, 0 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );

  test.case = 'String coordinates'; /* */

  var plane = [ 1, 'string', 0, 0 ];
  var expected =  [ - 1, NaN, 0, 0 ];

  var negated = _.plane.negate( plane );
  test.equivalent( expected, negated );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.negate( ));
  test.shouldThrowErrorSync( () => _.plane.negate( [ 0, 0, 1, 0 ], [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.negate( [] ));
  test.shouldThrowErrorSync( () => _.plane.negate( null ));
  test.shouldThrowErrorSync( () => _.plane.negate( NaN ));
  test.shouldThrowErrorSync( () => _.plane.negate( 'plane' ));

}

//

function threeIntersectionPoint( test )
{

  test.case = 'Planes remain unchanged'; /* */

  var plane1 = [ 1, 0 , 0, 1 ];
  var oldPlane1 = plane1.slice();
  var plane2 = [ 1, 1 , 0, 1 ];
  var oldPlane2 = plane2.slice();
  var plane3 = [ 1, 0 , 1, 1 ];
  var oldPlane3 = plane3.slice();
  var expected = [ - 1, 0, 0 ];
  expected = _.vector.from( expected );

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.identical( expected, interPoint );
  test.identical( plane1, oldPlane1 );
  test.identical( plane2, oldPlane2 );
  test.identical( plane3, oldPlane3 );

  test.case = 'Parallel planes'; /* */

  var plane1 = [ 1, 0 , 0, 1 ];
  var plane2 = [ 2, 0 , 0, 4 ];
  var plane3 = [ 3, 0 , 0, 7 ];
  var expected = NaN;

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.identical( expected, interPoint );

  test.case = '2 Parallel planes'; /* */

  var plane1 = [ 1, 0 , 0, 1 ];
  var plane2 = [ 2, 0 , 0, 4 ];
  var plane3 = [ 3, 1 , 4, 7 ];
  var expected = NaN;

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.identical( expected, interPoint );

  test.case = 'Perpendicular planes in origin'; /* */

  var plane1 = [ 1, 0 , 0, 0 ];
  var plane2 = [ 0, 1 , 0, 0 ];
  var plane3 = [ 0, 0 , 1, 0 ];
  var expected = [ 0, 0, 0 ];
  expected = _.vector.from( expected );

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.equivalent( expected, interPoint );
  debugger;
  test.case = 'Planes in origin'; /* */

  var plane1 = [ - 1, 1, 0, 0 ];
  var plane2 = [ 0, 1 , 0, 0 ];
  var plane3 = [ 0, - 1, 6, 0 ];
  var expected = [ 0, 0, 0 ];
  expected = _.vector.from( expected );

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.equivalent( expected, interPoint );

  test.case = 'Perpendicular planes'; /* */

  var plane1 = [ 3, 0 , 0, 3 ];
  var plane2 = [ 0, - 4 , 0, 4 ];
  var plane3 = [ 0, 0 , 5, 5 ];
  var expected = [ - 1, 1, - 1 ];
  expected = _.vector.from( expected );

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.identical( expected, interPoint );

  test.case = 'Trivial'; /* */

  var plane1 = [ 2, 1, 2, 4 ];
  var plane2 = [ 1, 1 , 0, - 5 ];
  var plane3 = [ 1, - 1 , 6, 0 ];
  var expected = [ - 32, 37, 11.5 ];
  expected = _.vector.from( expected );

  var interPoint = _.plane.threeIntersectionPoint( plane1, plane2, plane3 );
  test.identical( expected, interPoint );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ] ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ], [ 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ], [ 0, - 1, 0, 2 ], [ 0, 3, 1, 2 ], [ 0, 3, 1, 2 ]  ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0, 2 ], [ 0, - 1, 0, 2 ], [ 0, 3, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ], [ 0, - 1, 0, 2, 3 ], [ 0, 3, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ], [ 0, - 1, 0, 2 ], [ 0, 3, 1, 2, 4 ] ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( null, [ 0, - 1, 0, 2 ], [ 0, 3, 1, 2 ]  ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ 0, 0, 1, 0 ], NaN, [ 0, 3, 1, 2 ], ));
  test.shouldThrowErrorSync( () => _.plane.threeIntersectionPoint( [ ], [ ], [ ] ));

}

// --
// declare
// --

var Self =
{

  name : 'Tools.Math.Plane',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,
  // routine: 'frustumClosestPoint',

  tests :
  {

    from : from,
    fromNormalAndPoint : fromNormalAndPoint,
    fromPoints : fromPoints,

    pointContains : pointContains,
    pointDistance : pointDistance,
    pointCoplanarGet : pointCoplanarGet,

    boxIntersects : boxIntersects,
    boxClosestPoint : boxClosestPoint,
    boundingBoxGet : boundingBoxGet,

    capsuleClosestPoint : capsuleClosestPoint,

    frustumClosestPoint : frustumClosestPoint,

    lineIntersects : lineIntersects,
    lineClosestPoint : lineClosestPoint,

    planeIntersects : planeIntersects,
    planeDistance, planeDistance,

    rayClosestPoint : rayClosestPoint,

    segmentIntersects : segmentIntersects,
    segmentClosestPoint : segmentClosestPoint,

    sphereIntersects : sphereIntersects,
    sphereDistance : sphereDistance,
    sphereClosestPoint : sphereClosestPoint,
    boundingSphereGet : boundingSphereGet,

    //matrixHomogenousApply : matrixHomogenousApply,
    translate : translate,

    normalize : normalize,
    negate : negate,

    threeIntersectionPoint : threeIntersectionPoint,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
