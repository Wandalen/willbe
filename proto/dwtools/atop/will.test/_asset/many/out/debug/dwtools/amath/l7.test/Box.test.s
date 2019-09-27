( function _Box_test_s_( ) {

'use strict';

/*

qqq : lack of tests for box

  from : from,

qqq : sort routines implementations

*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );

//  require( '../l7/Box.s' );
//  require( '../l7/Sphere.s' );
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

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.make( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.box.make( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.box.make( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.box.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function makeZero( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.makeZero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function makeNil( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.makeNil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

}

//

function zero( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.zero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.box.zero( src );
  var expected = [ 0,0,0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.box.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.box.zero( dst );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.zero( dst );
  var expected = _.vector.fromArray([ 0,0,0,0 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst array 1d'; /* */

  var dst = [ 0,1 ];
  var got = _.box.zero( dst );
  var expected = [ 0,0 ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function nil( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.nil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.box.nil( src );
  var expected = [ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.box.nil( src );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.box.nil( dst );
  var expected = [ +Infinity,+Infinity,-Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.nil( dst );
  var expected = _.vector.fromArray([ +Infinity,+Infinity,-Infinity,-Infinity ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst array 2d'; /* */

  var dst = [ 1,3 ];
  var got = _.box.nil( dst );
  var expected = [ +Infinity,-Infinity ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function centeredOfSize( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.box.centeredOfSize( src,2 );
  var expected = [ -1,-1,-1,+1,+1,+1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.box.centeredOfSize( src,2 );
  var expected = [ -1,-1,-1,+1,+1,+1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.box.centeredOfSize( src,2 );
  var expected = [ -1,-1,+1,+1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.box.centeredOfSize( dst,2 );
  var expected = [ -1,-1,+1,+1 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.centeredOfSize( dst,2 );
  var expected = _.vector.fromArray([ -1,-1,+1,+1 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst array 2d'; /* */

  var dst = [ 1,3 ];
  var got = _.box.centeredOfSize( dst,2 );
  var expected = [ -1,+1 ];
  test.identical( got,expected );
  test.is( got === dst );

  /* */

  test.case = 'src null'; /* */

  var src = null;
  var got = _.box.centeredOfSize( null, 1 );
  var expected = [ -0.5,-0.5,-0.5,+0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2'; /* */

  var src = 2;
  var got = _.box.centeredOfSize( src, 1 );
  var expected = [ -0.5,-0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.box.centeredOfSize( dst, 1 );
  var expected = [ -0.5,-0.5,+0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ] );
  var got = _.box.centeredOfSize( dst, 1 );
  var expected = _.vector.fromArray([ -0.5,-0.5,+0.5,+0.5 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst array 2d'; /* */

  var dst = [ 1,3 ];
  var got = _.box.centeredOfSize( dst, 1 );
  var expected = [ -0.5,+0.5 ];
  test.identical( got,expected );
  test.is( got === dst );

  /* */

  test.case = 'src undefined with sizes in array'; /* */

  var src = undefined;
  var got = _.box.centeredOfSize( src,[ 1,2,4 ] );
  var expected = [ -0.5,-1,-2,+0.5,+1,+2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null with sizes in array'; /* */

  var src = null;
  var got = _.box.centeredOfSize( src,[ 1,2,4 ] );
  var expected = [ -0.5,-1,-2,+0.5,+1,+2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src 2 with sizes in array'; /* */

  var src = 2;
  var got = _.box.centeredOfSize( src,[ 2,4 ] );
  var expected = [ -1,-2,+1,+2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array with sizes in array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.box.centeredOfSize( dst,[ 2,4 ] );
  var expected = [ -1,-2,+1,+2 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector with sizes in array'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.box.centeredOfSize( dst,[ 2,4 ] );
  var expected = _.vector.fromArray([ -1,-2,+1,+2 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst array 2d with sizes in array'; /* */

  var dst = [ 1,3 ];
  var got = _.box.centeredOfSize( dst,[ 4 ] );
  var expected = [ -2,+2 ];
  test.identical( got,expected );
  test.is( got === dst );

}

//

function from( test )
{

  test.case = 'Same instance returned - array'; /* */

  var srcBox = [ 0, 0, 2, 2 ];
  var expected = [ 0, 0, 2, 2 ];

  var gotBox = _.box.from( srcBox );
  test.identical( gotBox, expected );
  test.is( srcBox === gotBox );

  test.case = 'Different instance returned - vector -> array'; /* */

  var srcBox = _.vector.fromArray( [ 0, 0, 2, 2 ] );
  var expected = _.vector.fromArray( [ 0, 0, 2, 2 ] );

  var gotBox = _.box.from( srcBox );
  test.identical( gotBox, expected );
  test.is( srcBox === gotBox );

  test.case = 'Same instance returned - empty array'; /* */

  var srcBox = [];
  var expected =  [];

  var gotBox = _.box.from( srcBox );
  test.identical( gotBox, expected );
  test.is( srcBox === gotBox );

  test.case = 'Different instance returned - null -> array'; /* */

  var srcBox = null;
  var expected =  [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.box.from( srcBox );
  test.identical( gotBox, expected );
  test.is( srcBox !== gotBox );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.from( ));
  test.shouldThrowErrorSync( () => _.box.from( [ 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.box.from( [ 0, 0, 0, 0 ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.box.from( 'box' ));
  test.shouldThrowErrorSync( () => _.box.from( NaN ));
  test.shouldThrowErrorSync( () => _.box.from( undefined ));


}

//

function fromPoints( test )
{

  test.case = 'Points remain unchanged and Destination box changes'; /* */

  var points = [ [ 1, 1 ], [ 0, 0 ], [ 0, 2 ] ];
  var expected = [ 0, 0, 1, 2 ];
  var dstBox = [ 0, 0, 1, 1 ];

  var gotBox = _.box.fromPoints( dstBox, points );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );

  var oldpoints = [ [ 1, 1 ], [ 0, 0 ], [ 0, 2 ] ];
  test.identical( points, oldpoints );

  test.case = 'Box from two points'; /* */

  var pointone = [ - 1, 2, - 3 ];
  var pointtwo = [ 1, - 2, 3 ];
  var expected = [ - 1, - 2, - 3, 1, 2, 3 ];

  var points = [ pointone, pointtwo ];
  var bbox = null;

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.case = 'Box from three points'; /* */

  var pointone = [ - 1, 2, - 3 ];
  var pointtwo = [ 1, - 2, 3 ];
  var pointthree = [ 0, 0, 6 ];
  var expected = [ - 1, - 2, - 3, 1, 2, 6 ];

  var points = [ pointone, pointtwo, pointthree ];
  var bbox = null;

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.case = 'Box from six points'; /* */

  var pointone = [ 0, 0, 3 ];
  var pointtwo = [ 0, 2, 0 ];
  var pointthree = [ 1, 0, 0 ];
  var pointfour = [ - 3, 0, 0 ];
  var pointfive = [ 0, - 2, 0 ];
  var pointsix = [ 0, 0, - 1 ];
  var expected = [ -3, - 2, - 1, 1, 2, 3 ];

  var points = [ pointone, pointtwo, pointthree, pointfour, pointfive, pointsix ];
  var bbox = null;

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.case = 'Box from two decimal points'; /* */

  var pointone = [ 0.001, -0.203, 0.889 ];
  var pointtwo = [ -0.991, 0.203, 0.005 ];
  var expected = [ -0.991, - 0.203, 0.005, 0.001, 0.203, 0.889 ];

  var points = [ pointone, pointtwo ];
  var bbox = null;

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.case = 'Box from Two points with initial box dimension'; /* */

  var pointone = [ 3, 1, 3 ];
  var pointtwo = [ 3, 8, 3 ];
  var expected = [ 2, 1, 2, 4, 8, 4 ];

  var points = [ pointone, pointtwo ];
  var bbox = [ 2, 2, 2, 4, 4, 4 ];

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.case = '0d Box from 0d points'; /* */

  var expected = [];
  var points = [ [], [], [] ];
  var bbox = [];

  bbox = _.box.fromPoints( bbox, points );
  test.equivalent( bbox, expected );

  test.case = 'Create box of two dimensions'; /* */

  var box = null;
  var points = [ [ 1, 0 ], [ 0, - 2 ], [ 0, 3 ], [ - 1, 2 ] ];
  var expected = [ - 1, - 2, 1, 3 ];

  var gotBox = _.box.fromPoints( box, points );
  test.identical( gotBox, expected );

  test.case = 'Create box three dimensions'; /* */

  var box = null;
  var points = [ [ 1, 0, 0 ], [ 0, 2, 0 ], [ 0, 0, 3 ] ];
  var expected = [ 0, 0, 0, 1, 2, 3 ];

  var gotBox = _.box.fromPoints( box, points );
  test.identical( gotBox, expected );

  test.case = 'Zero points - box not expanded'; /* */

  var box = null;
  var points = [ [ 0, 0, 0 ], [ 0, 0, 0 ] ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.case = 'Box expanded'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var points = [ [ - 1, 0, - 1 ], [ 0, 3, 0 ], [ 0, - 3, 0 ], [ 2, 2, 3 ] ] ;
  var expected = [ - 1, - 3, - 1, 2, 3, 3 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.case = 'Box out of one point'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var points = [ [ - 1, 0, - 1 ] ] ;
  var expected = [ - 1, 0, - 1, 2, 2, 2 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.case = 'Box NOT expanded ( points inside box )'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var points = [ [ 0, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] ];
  var expected = [ 0,  0, 0, 2, 2, 2 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.case = 'Box ( normalized to 1 ) expanded'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var points = [ [ - 0.900, 0, 0.900 ], [ 0, - 0.001, 0 ], [ 0.900, 0, - 0.900 ] ];
  var expected = [ - 0.900,  - 0.001, - 0.900, 0.900, 0.766, 0.900 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.case = 'Null box of four dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var points = [ [ - 1, - 2, - 3 , - 4 ], [ 1, 2, 3 , 4 ] ];
  var expected = [ - 1, - 2, - 3 , - 4, 1, 2, 3, 4 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.case = 'Null box of 7 dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var points = [ [ 1, 2, 3 , 0, 0, 0, 0 ], [ 0, 0, 0 , 4, 5, 6, 7 ] ] ;
  var expected = [ 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.case = 'Box of 1 dimension expanded'; /* */

  var box = [ 0, 0 ];
  var points = [ [ - 1 ], [ 0 ], [ 1 ] ];
  var expected = [ - 1, 1 ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  test.case = 'Box of 0 dimension expanded'; /* */

  var box = [ ];
  var points= [ [], [] ];
  var expected = [ ];

  var gotBox = _.box.fromPoints( box, points);
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromPoints();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromPoints( 'box', 'points' );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromPoints( null, 4 );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'Too few arguments - one point'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1 ]);
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1 ], [ 2, 1 ], [ 0, 3 ] ], [ 1, 0, 1 ] );
  });

  test.case = 'Wrong points dimension (box 3D vs points 4D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1, 0, 2 ], [ 0, 1, - 3, 4 ] ] );
  });

  test.case = 'Wrong points dimension (box 3D vs points 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0, 0, 0 ], [ [ 0, 1 ], [ 2, 1 ], [ 0, 3 ] ] );
  });

  test.case = 'Wrong points dimension (box 2D vs points 1D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromPoints( [ 0, 0, 0, 0 ], [ [ 1 ], [ 0 ] ] );
  });
}

//

function fromCenterAndSize( test )
{

  test.case = 'Center and size remain unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var center = [ 1, 1 ];
  var oldcenter = center.slice();
  var size = [ 4, 4 ];
  var oldsize = size.slice();
  var expected = [ - 1, - 1, 3, 3 ];

  var gotBox = _.box.fromCenterAndSize( dstBox, center, size );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );
  test.identical( center, oldcenter );
  test.identical( size, oldsize );

  test.case = 'Empty box'; /* */

  var box = [ ];
  var center = [ ];
  var size = [ ];
  var expected = [ ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.case = 'Trivial expansion'; /* */

  var box = [ 0, 1, 1, 0 ];
  var center = [ 1, 1 ];
  var size = [ 4, 4 ];
  var expected = [ - 1, - 1, 3, 3 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.case = 'Different sizes expansion'; /* */

  var box = [ 2, 2, 3, 3 ];
  var center = [ 1, 1 ];
  var size = [ 4, 2 ];
  var expected = [ - 1, 0, 3, 2 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.case = 'Decimal values'; /* */

  var box = [ 1.2, 2.4, 3.3, 4.8 ];
  var center = [ 1.5, 0.79 ];
  var size = [ 0.5, 0.2 ];
  var expected = [ 1.25, 0.69, 1.75, 0.89 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.equivalent( gotBox, expected );

  test.case = 'Negative size'; /* */

  var box = [ 0, 0, 0, 0 ];
  var center = [ 0, 0 ];
  var size = [ -2, -2 ];
  var expected = [ 1, 1, - 1, - 1 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.case = 'Box of three dimensions'; /* */

  var box = [ 1, 3, 2, 2, 4, 4 ];
  var center = [ 1, 1, 1 ];
  var size = [ 4, 4, 2 ];
  var expected = [ - 1, - 1, 0, 3, 3, 2 ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  test.case = 'NaN box'; /* */

  var box = [ NaN, NaN, NaN, NaN ];
  var center = [ NaN, NaN ];
  var size = [ NaN, NaN ];
  var expected = [ NaN, NaN, NaN, NaN ];

  var gotBox = _.box.fromCenterAndSize( box, center, size );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCenterAndSize();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCenterAndSize( 'box', 'center', 'size' );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCenterAndSize( null, 4, 5 );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1 ]);
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1 ], [ 1, 0, 1 ], [ 1, 1, 0 ] );
  });

  test.case = 'Wrong points dimension (box 3D vs points 4D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2 ], [ 0, 1, - 3, 4 ] );
  });

  test.case = 'Wrong points dimension (box 3D vs points 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1 ], [ 2, 1 ] );
  });

  test.case = 'Wrong points dimension (box 2D vs points 1D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCenterAndSize( [ 0, 0, 0, 0 ],  [ 1 ], [ 0 ]  );
  });

}

//

function fromSphere( test )
{

  test.case = 'Center and size remain unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var sphere = [ 1, 1, 1 ];
  var oldsphere = sphere.slice();
  var expected = [ - 1, - 1, 2, 2 ];

  var gotBox = _.box.fromSphere( dstBox, sphere );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );
  test.identical( sphere, oldsphere );

  test.case = 'Create box from sphere 1D same center'; /* */

  var box = [ 0, 0 ];
  var sphere = [ 0, 1 ];
  var expected = [ - 1, 1 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'Create box from sphere 1D different centers'; /* */

  var box = [ 0, 0 ];
  var sphere = [ 1, 1 ];
  var expected = [ - 1, 2 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'Expand from sphere - sphere in box'; /* */

  var box = [ 0, 2 ];
  var sphere = [ 1, 1 ];
  var expected = [ - 1, 3 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'Expand from sphere - sphere out of box'; /* */

  var box = [ 0, 2 ];
  var sphere = [ 3, 1 ];
  var expected = [ - 1, 4 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'Create box from sphere 3D same center'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 0, 0, 0, 1 ];
  var expected = [ - 1, - 1, - 1, 1, 1, 1 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'Create box from sphere 3D different center'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var sphere = [ 1, 1, 1, 1 ];
  var expected = [ - 1, - 1, - 1, 2, 2, 2 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'Expand from sphere 3D sphere in box'; /* */

  var box = [ 0, 0, 0, 2, 2, 3 ];
  var sphere = [ 1, 1, 1, 1 ];
  var expected = [ - 1, - 1, - 1, 3, 3, 4 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'Expand from sphere 3D sphere out box'; /* */

  var box = [ 0, 0, 0, 2, 2, 3 ];
  var sphere = [ 3, 3, 3, 1 ];
  var expected = [ - 1, - 1, - 1, 4, 4, 4 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'Contract Sphere - sphere in box'; /* */

  var box = [ 0, 0, 0, 2, 2, 3 ];
  var sphere = [ 1, 1, 1, - 1 ];
  var expected = [ 1, 1, 1, 1, 1, 2 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'Contract Sphere - sphere out of box'; /* */

  var box = [ 0, 0, 0, 2, 2, 3 ];
  var sphere = [ 3, 3, 3, - 1 ];
  var expected = [ 1, 1, 1, 2, 2, 2 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'Null box'; /* */

  var box = null;
  var sphere = [ 1, 1 ];
  var expected = [ 0, 2 ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'NaN box'; /* */

  var box = [ NaN, NaN ];
  var sphere = [ 1, 1 ];
  var expected = [ NaN, NaN ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  test.case = 'NaN Sphere'; /* */

  var box = [ 0, 2 ];
  var sphere = [ NaN, NaN ];
  var expected = [ NaN, NaN ];

  var gotBox = _.box.fromSphere( box, sphere );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromSphere();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromSphere( 'box', 'sphere' );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromSphere( [ 0, 1 ], null );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ]);
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ], [ 1, 1, 1, 1], [ 1, 1, 0, 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromSphere( [ 0 ], [ 0 ] );
  });

  test.case = 'Wrong dimension (box 3D vs sphere 4D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2, 1 ] );
  });

  test.case = 'Wrong dimension (box 3D vs sphere 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0, 0, 0 ], [ 0, 2, 1 ] );
  });

  test.case = 'Wrong dimension (box 2D vs sphere 1D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromSphere( [ 0, 0, 0, 0 ],  [ 0, 1 ]  );
  });

}

//

function fromCube( test )
{

  test.case = 'Cube remains unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var cube = 1;
  var expected = [ - 0.5, - 0.5, 0.5, 0.5 ];

  var gotBox = _.box.fromCube( dstBox, cube );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );

  var oldcube = 1;
  test.identical( cube, oldcube );

  test.case = 'Null box from cube'; /* */

  var box = null;
  var fromCube = 2;
  var expected = [ - 1, - 1, - 1, 1, 1, 1 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.case = 'Box from cube'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var fromCube = 6;
  var expected = [ - 3, - 3, - 3, 3, 3, 3 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.case = 'clean box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var fromCube =  0;
  var expected = [ - 0, - 0, - 0, 0, 0, 0 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.case = 'Box contracted'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var fromCube = - 1;
  var expected = [ 0.5, 0.5, 0.5, - 0.5, - 0.5, - 0.5 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.case = 'Box with decimal numbers from cube'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var fromCube =  0.100;
  var expected = [  - 0.050, - 0.050, - 0.050, 0.050, 0.050, 0.050 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.equivalent( gotBox, expected );

  test.case = 'Null box of four dimensions from cube'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var fromCube = 4;
  var expected = [ - 2, - 2, - 2, - 2, 2, 2, 2, 2 ];

  var gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  test.case = 'Null box of 7 dimensions from cube'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var fromCube = 8;
  var expected = [ - 4, - 4, - 4, - 4, - 4, - 4, - 4, 4, 4, 4, 4, 4, 4, 4 ];

  gotBox = _.box.fromCube( box, fromCube );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCube();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCube( 'box', 'cube' );
  });

  test.case = 'Cube not number'; /* */

  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCube( [ 0, 0, 1, 1 ], [ 1, 2 ] );
  });

  test.case = 'Null box from null cube'; /* */

  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCube( null, null );
  });

  test.case = 'Cube not number'; /* */

  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCube( [ 0, 0 ], [ 1 ] );
  });

  test.case = 'Empty cube and box'; /* */

  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCube( [ ], [ ] );
  });

  test.case = 'Wrong type of argument'; /* */

  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCube( 'box', 3 );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCube( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.fromCube( [ 0, 0, 0, 0, 0, 0 ], 2, 3 );
  });

}

//

function is( test )
{

  debugger;
  test.case = 'array'; /* */

  test.is( _.box.is( [] ) );
  test.is( _.box.is([ 0,0 ]) );
  test.is( _.box.is([ 1,2,3,4 ]) );
  test.is( _.box.is([ 0,0,0,0,0,0 ]) );

  test.case = 'vector'; /* */

  test.is( _.box.is( _.vector.fromArray([]) ) );
  test.is( _.box.is( _.vector.fromArray([ 0,0 ]) ) );
  test.is( _.box.is( _.vector.fromArray([ 1,2,3,4 ]) ) );
  test.is( _.box.is( _.vector.fromArray([ 0,0,0,0,0,0 ]) ) );

  test.case = 'not box'; /* */

  test.is( !_.box.is([ 0 ]) );
  test.is( !_.box.is([ 0,0,0 ]) );

  test.is( !_.box.is( _.vector.fromArray([ 0 ]) ) );
  test.is( !_.box.is( _.vector.fromArray([ 0,0,0 ]) ) );

  test.is( !_.box.is( 'abc' ) );
  test.is( !_.box.is( { center : [ 0,0,0 ], radius : 1 } ) );
  test.is( !_.box.is( function( a,b,c ){} ) );

}

//

function isEmpty( test )
{

  test.case = 'empty'; /* */

  test.is( _.box.isEmpty([]) );
  test.is( _.box.isEmpty([ 0,0 ]) );
  test.is( _.box.isEmpty([ 0,0,0,0,0,0 ]) );
  test.is( _.box.isEmpty([ 1,1 ]) );
  test.is( _.box.isEmpty([ 5,0,5,0 ]) );
  test.is( _.box.isEmpty([ -3,0,5,-3,0,5 ]) );

  test.is( _.box.isEmpty([ 0,0,0,1 ]) );
  test.is( _.box.isEmpty([ 0,-1 ]) );
  test.is( _.box.isEmpty([ 0,0,0,-1 ]) );
  test.is( _.box.isEmpty([ 0,0,5,0 ]) );

  test.is( _.box.isEmpty([ 0,-Infinity ]) );
  test.is( _.box.isEmpty([ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ]) );
  test.is( _.box.isEmpty([ 0,0,0,Infinity ]) );

  test.is( _.box.isEmpty([ 0.1,-Infinity ]) );
  test.is( _.box.isEmpty([ 0,0,0.1,-Infinity ]) );

  test.case = 'not empty'; /* */

  test.is( !_.box.isEmpty([ 0,1 ]) );

  test.is( !_.box.isEmpty([ 0,+Infinity ]) );
  test.is( !_.box.isEmpty([ -Infinity,0,0,+Infinity ]) );

  test.is( !_.box.isEmpty([ 0.1,+Infinity ]) );
  test.is( !_.box.isEmpty([ 0,0.00001,0.1,+Infinity ]) );

}

//

function isZero( test )
{

  test.case = 'zero'; /* */

  test.is( _.box.isZero([]) );
  test.is( _.box.isZero([ 0,0 ]) );
  test.is( _.box.isZero([ 0,0,0,0,0,0 ]) );
  test.is( _.box.isZero([ 1,1 ]) );
  test.is( _.box.isZero([ 5,0,5,0 ]) );
  test.is( _.box.isZero([ -3,0,5,-3,0,5 ]) );

  test.case = 'not zero'; /* */

  test.is( !_.box.isZero([ 0,1 ]) );
  test.is( !_.box.isZero([ 0,0,0,1 ]) );

  test.is( !_.box.isZero([ 0,-1 ]) );
  test.is( !_.box.isZero([ 0,0,0,-1 ]) );
  test.is( !_.box.isZero([ 0,0,5,0 ]) );

  test.is( !_.box.isZero([ 0,-Infinity ]) );
  test.is( !_.box.isZero([ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ]) );

  test.is( !_.box.isZero([ 0,Infinity ]) );
  test.is( !_.box.isZero([ 0,0,0,Infinity ]) );

  test.is( !_.box.isZero([ 0.1,-Infinity ]) );
  test.is( !_.box.isZero([ 0,0,0.1,-Infinity ]) );

}

//

function isNil( test )
{

  test.case = 'nil'; /* */

  test.is( _.box.isNil([ +Infinity,+Infinity,-Infinity,-Infinity ]) );
  test.is( _.box.isNil([ +Infinity,+Infinity,+Infinity,-Infinity,-Infinity,-Infinity ]) );

  test.is( _.box.isNil([ +1,+1,-2,-5 ]) );
  test.is( _.box.isNil([ +1,+1,+1,-2,-3,-4 ]) );

  test.case = 'not nil'; /* */

  test.is( !_.box.isNil([ 0,Infinity ]) );
  test.is( !_.box.isNil([ 0,0,0,Infinity ]) );

  test.is( !_.box.isNil([ Infinity,Infinity ]) );
  test.is( !_.box.isNil([ 0,0,0.1,Infinity ]) );

}

//

function dimGet( test )
{

  test.case = 'Source box remains unchanged'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var oldsrcBox = srcBox.slice();
  var expected = 2;

  var gotDim = _.box.dimGet( srcBox );
  test.identical( gotDim, expected );
  test.identical( srcBox, oldsrcBox );

  test.case = 'Empty box'; /* */

  var box = [];
  var expected = 0;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.case = 'One dimension box'; /* */

  var box = [ 0, 0 ];
  var expected = 1;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.case = 'Two dimension box'; /* */

  var box = [ 0, 0, 1, 1 ];
  var expected = 2;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.case = 'Three dimension box'; /* */

  var box = [ - 1, - 2, - 3, 0, 1, 2 ];
  var expected = 3;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.case = 'Four dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  var expected = 4;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.case = 'Eight dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1, - 3.2, - 3.5, 5.5, 2.3, 27, 2.2, 540 ];
  var expected = 8;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.case = 'NaN'; /* */

  var box = [ 'Hi', 'world' ];
  var expected = 1;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  test.case = 'NaN'; /* */

  var box = [ 'Hi', 'world', null, null, NaN, NaN ];
  var expected = 3;

  var gotDim = _.box.dimGet( box );
  test.identical( gotDim, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.dimGet();
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.dimGet( [ 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.dimGet( [ 0, 0, 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.dimGet( [ 0, 0, 0, 0, 0 ] );
  });
}

//

function cornerLeftGet( test )
{

  test.case = 'Source box remains unchanged'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var oldsrcBox = srcBox.slice();
  var expected = [ 0, 0 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( srcBox );
  test.identical( gotCorner, expected );
  test.identical( srcBox, oldsrcBox );

  test.case = 'Empty box'; /* */

  var box = [];
  var expected = [];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.case = 'One dimension box'; /* */

  var box = [ 0, 1 ];
  var expected = [ 0 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.case = 'Two dimension box'; /* */

  var box = [ 0, 0, 1, 1 ];
  var expected = [ 0, 0 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.case = 'Three dimension box'; /* */

  var box = [ - 1, - 2, - 3, 0, 1, 2 ];
  var expected = [ - 1, - 2, - 3 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.case = 'Four dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  var expected = [ - 1, - 2.2, - 3, 5 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.case = 'Eight dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1, - 3.2, - 3.5, 5.5, 2.3, 27, 2.2, 540 ];
  var expected = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  test.case = 'Inverted box'; /* */

  var box = [ 1, 1, 0, 0 ];
  var expected = [ 1, 1 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerLeftGet( box );
  test.identical( gotCorner, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerLeftGet();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerLeftGet( null );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerLeftGet( NaN );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerLeftGet( 'Hello' );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerLeftGet( [ 'Hello', world ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerLeftGet( [ 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerLeftGet( [ 0, 0, 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerLeftGet( [ 0, 0, 0, 0, 0 ] );
  });
}

//

function cornerRightGet( test )
{

  test.case = 'Source box remains unchanged'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var oldSrcBox = srcBox.slice();
  var expected = [ 1, 1 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( srcBox );
  test.identical( gotCorner, expected );
  test.identical( srcBox, oldSrcBox );

  test.case = 'Empty box'; /* */

  var box = [];
  var expected = [];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.case = 'One dimension box'; /* */

  var box = [ 0, 1 ];
  var expected = [ 1 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.case = 'Two dimension box'; /* */

  var box = [ 0, 0, 1, 1 ];
  var expected = [ 1, 1 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.case = 'Three dimension box'; /* */

  var box = [ - 1, - 2, - 3, 0, 1, 2 ];
  var expected = [ 0, 1, 2 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.case = 'Four dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4 ];
  var expected = [ 0.1, 1, 2, 5.4 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.case = 'Eight dimension box'; /* */

  var box = [ - 1, - 2.2, - 3, 5, 0.1, 1, 2, 5.4, - 1.1, - 3.2, - 5, 5.5, 2.3, 27, 2.2, 540 ];
  var expected = [ -1.1, - 3.2, - 5, 5.5, 2.3, 27, 2.2, 540 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  test.case = 'Empty box at [ 1, 1 ]'; /* */

  var box = [ 1, 1, 0, 0 ];
  var expected = [ 0, 0 ];
  expected = _.vector.from(expected);

  var gotCorner = _.box.cornerRightGet( box );
  test.identical( gotCorner, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerRightGet();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerRightGet( null );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerRightGet( NaN );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerRightGet( 'Hello' );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerRightGet( [ 'Hello', world ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerRightGet( [ 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerRightGet( [ 0, 0, 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornerRightGet( [ 0, 0, 0, 0, 0 ] );
  });
}

//

function centerGet( test )
{

  test.case = 'Source box remains unchanged, point changes'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var oldSrcBox = srcBox.slice();
  var expected = [ 0.5, 0.5 ];
  var point = [ 0, 5 ];

  var gotCenter = _.box.centerGet( srcBox, point );
  test.equivalent( gotCenter, expected );
  test.equivalent( point, expected );
  test.equivalent( srcBox, oldSrcBox );

  test.case = 'Empty box'; /* */

  var box = [];
  var point = [];
  var expected = [] ;

  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );
  debugger;

  test.case = 'One dimension box'; /* */

  var box = [ 0, 0 ];
  var point = [ 0 ];
  var expected = [ 0 ];

  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  var box = [ 0, 0 ];
  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  test.case = 'Two dimension box'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = [ 1, 1 ];
  var expected = [ 0.5, 1 ];

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, 0, 1, 2 ];
  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  test.case = 'Three dimension box'; /* */

  var box = [ 0, - 1, - 2, 0, 1, 2 ];
  var expected = [ 0, 0, 0 ];
  var point = [ 2, 4, - 6 ];

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, - 1, - 2, 0, 1, 2 ];

  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  test.case = 'Four dimension box'; /* */

  var box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var expected = [ 0, 0, 0, 4 ];
  var point = [ 2, 4, - 6, 2 ];

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];

  var gotCenter = _.box.centerGet( box, point );
  test.identical( gotCenter, expected );

  test.case = 'Eight dimension box'; /* */

  var box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var point = [ 2, 4, - 6, 2, 2, 4, - 6, 2 ];
  var expected = [ 0, - 1, -2, 2, 0, 1, 2, 6 ];

  var gotCenter = _.box.centerGet( box );
  test.identical( gotCenter, expected );

  var box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var gotCenter = _.box.centerGet( box, point );
  test.identical( gotCenter, expected );

  test.case = 'Point is vector'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = _.vector.from( [ 1, 1 ] );
  var expected = [ 0.5, 1 ];
  var expv = _.vector.from( expected );

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, 0, 1, 2 ];
  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expv );

  test.case = 'Point is null'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = null;
  var expected = [ 0.5, 1 ];

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, 0, 1, 2 ];
  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter,expected );

  test.case = 'Point is NaN'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = NaN;
  var expected = [ 0.5, 1 ];

  var gotCenter = _.box.centerGet( box );
  test.equivalent( gotCenter,expected );

  var box = [ 0, 0, 1, 2 ];
  var gotCenter = _.box.centerGet( box, point );
  test.equivalent( gotCenter, expected );


  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet();
  });

  test.case = 'Too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet( [ 0, 0, 1, 1 ], [ 0, 0, 0 ], [ 0, 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet( null );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet( 'string' );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet( null, [ 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet( 'string', [ 0, 0 ] );
  });


  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet( [ 0, 0, 1, 1 ], 'string' );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet( [ 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet( [ 0, 0, 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet( [ 0, 0, 0, 0, 0 ] );
  });

  test.case = 'Different dimension between box and point'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.centerGet( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0 ] );
  });

}

//

function sizeGet( test )
{

  test.case = 'Source box remains unchanged, point changes'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var point = [ 0, 5 ];
  var expected = [ 1, 1 ];

  var gotSize = _.box.sizeGet( srcBox, point );
  test.equivalent( gotSize, expected );
  test.equivalent( point, expected );

  var oldSrcBox = srcBox.slice();
  test.equivalent( srcBox, oldSrcBox );

  test.case = 'Empty box'; /* */

  var box = [];
  var point = [];
  var expected = [] ;

  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );
  debugger;

  test.case = 'One dimension box'; /* */

  var box = [ 0, 0 ];
  var point = [ 0 ];
  var expected = [ 0 ];

  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  var box = [ 0, 0 ];
  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  test.case = 'Two dimension box'; /* */

  var box = [ 0, 1, 1, 2 ];
  var point = [ 2, 4 ];
  var expected = [ 1, 1 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, 1, 1, 2 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.case = 'Three dimension box'; /* */

  var box = [ 0, - 1, - 2, 0, 1, 2 ];
  var expected = [ 0, 2, 4 ];
  var point = [ 2, 4, - 6 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, - 1, - 2, 0, 1, 2 ];

  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.case = 'Four dimension box'; /* */

  var box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var expected = [ 0, 2, 4, 4 ];
  var point = [ 2, 4, - 6, 2 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, - 1, - 2, 2, 0, 1, 2, 6 ];

  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.case = 'Eight dimension box'; /* */

  var box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var point = [ 2, 4, - 6, 2, 2, 4, - 6, 2 ];
  var expected = [ 0, 0, 0, 0, 0, 0, 0, 0 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [  0, - 1, - 2, 2, 0, 1, 2, 6, 0, - 1, - 2, 2, 0, 1, 2, 6 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );


  test.case = 'Point is vector'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = _.vector.from( [ 1, 1 ] );
  var expected = [ 1, 2 ];
  var expv = _.vector.from( expected );

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, 0, 1, 2 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expv );

  test.case = 'Point is null'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = null;
  var expected = [ 1, 2 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, 0, 1, 2 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.case = 'Point is NaN'; /* */

  var box = [ 0, 0, 1, 2 ];
  var point = NaN;
  var expected = [ 1, 2 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 0, 0, 1, 2 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  test.case = 'Empty box'; /* */

  var box = [ 1, 1, 0, 0 ];
  var point = NaN;
  var expected = [ - 1, - 1 ];

  var gotSize = _.box.sizeGet( box );
  test.identical( gotSize, expected );

  var box = [ 1, 1, 0, 0 ];
  var gotSize = _.box.sizeGet( box, point );
  test.identical( gotSize, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet();
  });

  test.case = 'Too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet( [ 0, 0, 1, 1 ], [ 0, 0, 0 ], [ 0, 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet( null );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet( 'string' );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet( null, [ 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet( 'string', [ 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */

  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet( [ 0, 0, 1, 1 ], 'string' );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet( [ 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet( [ 0, 0, 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet( [ 0, 0, 0, 0, 0 ] );
  });

  test.case = 'Different dimension between box and point'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.sizeGet( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0 ] );
  });

}

//

function cornersGet( test )
{

  test.case = 'Source box remains unchanged'; /* */

  var srcBox = [ 0, 0, 1, 1 ];
  var expected =  _.Space.make( [ 2, 4 ] ).copy
  ([
    0, 1, 0, 1,
    0, 0, 1, 1
  ]);

  var gotCorners = _.box.cornersGet( srcBox );
  test.equivalent( gotCorners, expected );

  var oldSrcBox = srcBox.slice();
  test.equivalent( srcBox, oldSrcBox );

  test.case = 'One dimension box'; /* */

  var box = [ 0, 0 ];
  var expected =  _.Space.make( [ 1, 2 ] ).copy
  ([
    0, 0
  ]);

  var gotCorners = _.box.cornersGet( box );
  test.identical( gotCorners, expected );

  test.case = 'Two dimension box'; /* */

  var box = [ 0, 1, 1, 2 ];
  var expected = _.Space.make( [ 2, 4 ] ).copy
  ([
    0, 1, 0, 1,
    1, 1, 2, 2
  ]);

  var gotCorners = _.box.cornersGet( box );
  test.identical( gotCorners, expected );

  test.case = 'Three dimension box'; /* */

  var box = [ 0, - 1, - 2, 1, 1, 2 ];
  var expected = _.Space.make( [ 3, 8 ] ).copy
  ([
    0,   1,  0,  0, 0,  1,  1, 1,
    -1, -1,  1, -1, 1, -1,  1, 1,
    -2, -2, -2,  2, 2,  2, -2, 2,
  ]);

  var gotCorners = _.box.cornersGet( box );
  test.identical( gotCorners, expected );

  test.case = 'Unity box'; /* */

  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = _.Space.make( [ 3, 8 ] ).copy
  ([
    0, 1, 0, 0, 0, 1, 1, 1,
    0, 0, 1, 0, 1, 0, 1, 1,
    0, 0, 0, 1, 1, 1, 0, 1,
  ]);

  var gotCorners = _.box.cornersGet( box );
  test.identical( gotCorners, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet();
  });

  test.case = 'Too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet( [ 0, 0, 1, 1 ], [ 0, 0, 0 ], [ 0, 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet( null );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet( 'string' );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet( null, [ 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet( 'string', [ 0, 0 ] );
  });

  test.case = 'Wrong type of arguments'; /* */

  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet( [ 0, 0, 1, 1 ], 'string' );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet( [ 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet( [ 0, 0, 0 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet( [ 0, 0, 0, 0, 0 ] );
  });

  test.case = 'Different dimension between box and point'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.cornersGet( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0 ] );
  });

}

//

function expand( test )
{

  test.case = 'Expansion array remains unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var expand = [ 0, 2 ];
  var expected = [ 0, - 2, 1, 3 ];

  var gotBox = _.box.expand( dstBox, expand );
  test.identical( gotBox, expected );
  test.identical( dstBox, expected );

  var oldexpand = [ 0, 2 ];
  test.identical( expand, oldexpand );

  test.case = 'Null box expanded'; /* */

  var box = null;
  var expand = [ 1, 2, 3 ];
  var expected = [ - 1, - 2, - 3, 1, 2, 3 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'Null box NOT expanded'; /* */

  var box = null;
  var expand = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'One side box expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var expand = [ 0, 0,  3 ];
  var expected = [ 0,  0, - 3, 0, 0, 3 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'Box expanded'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expand = [ 1, 3, 1 ];
  var expected = [ - 1, - 3, - 1, 3, 5, 3 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'Box expanded by value'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expand = 1;
  var expected = [ - 1, - 1, - 1, 3, 3, 3 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'Box NOT expanded ( empty expand array )'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var expand = [  0, 0, 0 ];
  var expected = [ 0,  0, 0, 2, 2, 2 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'Box contracted'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var expand = [ - 1, - 1, - 1 ];
  var expected = [ 1, 1, 1, 2, 2, 2 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'Box with decimal numbers expanded'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var expand = [ -0.100, 0, 0.100 ];
  var expected = [  0.050,  0.002, -0.338, 0.094, 0.766, 0.866 ];

  var gotBox = _.box.expand( box, expand );
  test.equivalent( gotBox, expected );

  test.case = 'Null box of four dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var expand = [ 1, 2, 3 , 4 ];
  var expected = [ - 1, - 2, - 3, - 4, 1, 2, 3, 4 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'Null box of 7 dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var expand = [ 1, 2, 3 , 4, 5, 6, 7 ];
  var expected = [ - 1, - 2, - 3, - 4, - 5, - 6, - 7, 1, 2, 3, 4, 5, 6, 7 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'Box of 1 dimension expanded'; /* */

  var box = [ 0, 0 ];
  var expand = [ 1 ];
  var expected = [ - 1, 1 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'Box of 0 dimension expanded'; /* */

  var box = [ ];
  var expand = [ ];
  var expected = [ ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  test.case = 'Null box expanded by value'; /* */

  var box = null;
  var expand =  4 ;
  var expected = [ - 4, -4, -4, 4, 4, 4 ];

  var gotBox = _.box.expand( box, expand );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.expand();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.expand( 'box', 'expand' );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.case = 'Wrong expand array dimension (box 3D vs array 4D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2 ] );
  });

  test.case = 'Wrong expand array dimension (box 3D vs array 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.expand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1 ] );
  });

  test.case = 'Wrong expand array dimension (box 2D vs array 1D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.expand( [ 0, 0, 0, 0 ], [ 0 ] );
  });

  test.case = 'Wrong expand array dimension (null box vs array 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.expand( null, [ 0, 1 ] );
  });

}

//

function pointContains( test )
{

  test.case = 'Box and Point remain unchanged'; /* */

  var box = [  - 1,  - 1 , 1, 1 ];
  var point = [ 0, 0 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool, expected );

  var oldBox = [  - 1,  - 1 , 1, 1 ];
  test.identical( box, oldBox );

  var oldPoint = [ 0, 0 ];
  test.identical( point, oldPoint );

  test.case = 'Null box contains empty point'; /* */

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Empty box doesn´t contain empty point'; /* */

  var box = [];
  var point = [];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Point Box contains Point'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box contains point'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box under point'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box over point'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 1, 1, 1 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box ( normalized to 1 ) contains point'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, 0.000 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box ( normalized to 1 ) doesn´t contain point'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box of four dimensions contains point'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box of four dimensions doesn´t contain point'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box of 7 dimensions contains point'; /* */

  var box = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ 0, -1, -1, 0, -1, 0, 0 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box of 7 dimensions doesn´t contain point'; /* */

  var box = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ 0, 4, 3.5, 0, 5, 2, 2 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box of 1 dimension contains point'; /* */

  var box = [ 0, 2 ];
  var point = [ 1 ];
  var expected = true;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box of 1 dimension desn´t contain point (too big)'; /* */

  var box = [ 0, 2 ];
  var point = [ 3 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool,  expected );

  test.case = 'Box of 1 dimension desn´t contain point (too small)'; /* */

  var box = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = false;

  var gotBool = _.box.pointContains( box, point );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointContains();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointContains( 'box', 'point' );
  });

  test.case = 'Point Null'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointContains( [ 0, 0, 0, 1, 1, 1 ], null );
  });


  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointContains( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointContains( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.case = 'Wrong point dimension (box 3D vs point 4D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointContains( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.case = 'Wrong point dimension (box 3D vs point 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointContains( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.case = 'Wrong point dimension (box 2D vs point 1D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointContains( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function pointDistance( test )
{

  test.case = 'Box and Point remain unchanged'; /* */

  var box = [ 0, 0, 2, 2 ];
  var point = [ 0, 3 ];
  var expected = 1;
  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( expected, gotDist );

  var oldBox = box.slice();
  test.equivalent( oldBox,oldBox );

  var oldPoint = point.slice();
  test.equivalent( point, oldPoint );

  test.case = 'Empty point relative to null box'; /* */

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Empty point relative to empty box'; /* */

  var box = [];
  var point = [];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point relative to zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point in box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point over box in one dimension'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = 1;
  debugger;
  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point under box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 1, 1, 1 ];
  var expected = 1;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point away from box in two dimensions'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 0, - 1, - 1 ];
  var expected = Math.sqrt(2);

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point away from box in three dimensions'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 3, - 1, - 1 ];
  var expected = Math.sqrt(3);

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point (normalized to one) in box'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, 0.000 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point (normalized to one) not in box'; /* */

  var box = [ - 0.050, 0.002, -0.203, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = 0.1;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point in four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point out of four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = Math.sqrt(2);

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point in seven dimensions box'; /* */

  var box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  var point = [ 0, 4, 3.5, 0, 3, 2, 2 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point out of seven dimensions box'; /* */

  var box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  var point = [ 0, 4, 3.5, 0, 4, 2, 7 ];
  var expected = 4;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point in one dimension box'; /* */

  var box = [ 0, 2 ];
  var point = [ 1 ];
  var expected = 0;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point out of one dimension box (smaller)'; /* */

  var box = [ 0, 2 ];
  var point = [ 3 ];
  var expected = 1;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  test.case = 'Point out of one dimension box (bigger)'; /* */

  var box = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = 3;

  var gotDist = _.box.pointDistance( box, point );
  test.equivalent( gotDist, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointDistance();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointDistance( 'box', 'point' );
  });

  test.case = 'Point Null'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 1, 1, 1 ], null );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.case = 'Wrong point dimension (box 3D vs point 4D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.case = 'Wrong point dimension (box 3D vs point 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.case = 'Wrong point dimension (box 2D vs point 1D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointDistance( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}


//

function pointClosestPoint( test )
{

  test.case = 'Returns same instance point, box remains unchanged'; /* */

  var box = [ 1, 1, 1, 3, 3, 3 ];
  var point = [ 0, 1, 2 ];
  var expected = [ 1, 1, 2 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped, expected );

  var oldBox = box.slice();
  test.identical( oldBox, box );

  var oldPoint = [ 0, 1, 2 ];
  test.identical( oldPoint, point );

  test.case = 'Empty point relative to null box'; /* */

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Empty point relative to empty box'; /* */

  var box = [];
  var point = [];
  var expected = [];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point relative to zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point in box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = [ 1, 1, 1 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point over box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = [ 1, 1, 2 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point under box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 1, 1, 1 ];
  var expected = [ 0, 1, 1 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point (normalized to one) in box'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, 0 ];
  var expected = [ 0.050, 0.500, 0 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point (normalized to one) not in box'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ 0.050, 0.500, - 0.303 ];
  var expected = [ 0.050, 0.500, -0.238 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point in four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = [ 0, 0, 0 , 0 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point out of four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = [ 0, - 1, 0 , 1 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point in seven dimensions box'; /* */

  var box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  var point = [ 0, 4, 3.5, 0, 4, 2, 2 ];
  var expected = [ 0, 4, 3.5, 0, 4, 2, 2 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point out of seven dimensions box'; /* */

  var box = [ - 2, 3, 3, - 1, 2, 1, 1, 1, 5, 4, 2, 4, 3, 3 ];
  var point = [ 0, 4, 3.5, 0, 5, 2, 7 ];
  var expected = [ 0, 4, 3.5, 0, 4, 2, 3 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point in one dimension box'; /* */

  var box = [ 0, 2 ];
  var point = [ 1 ];
  var expected = [ 1 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point out of one dimension box (smaller)'; /* */

  var box = [ 0, 2 ];
  var point = [ 3 ];
  var expected = [ 2 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'Point out of one dimension box (bigger)'; /* */

  var box = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = [ 0 ];

  var gotClamped = _.box.pointClosestPoint( box, point );
  test.identical( gotClamped,  expected );

  test.case = 'dstPoint is vector'; /* */

  var box = [ 0, 2 ];
  var point = [ - 3 ];
  var dstPoint = _.vector.fromArray( [ 5 ] );
  var expected = _.vector.fromArray( [ 0 ] );

  var gotClamped = _.box.pointClosestPoint( box, point, dstPoint );
  test.identical( gotClamped,  expected );
  test.identical( gotClamped,  dstPoint );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointClosestPoint();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointClosestPoint( 'box', 'point' );
  });

  test.case = 'Point Null'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointClosestPoint( [ 0, 0, 0, 1, 1, 1 ], null );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointClosestPoint( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointClosestPoint( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ], [ 1, 0, 0 ] );
  });

  test.case = 'dstPoint is null'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointClosestPoint( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], null );
  });


  test.case = 'dstPoint is undefined'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointClosestPoint( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], undefined );
  });

  test.case = 'Wrong point dimension (box 3D vs point 4D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointClosestPoint( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.case = 'Wrong point dimension (box 3D vs point 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointClosestPoint( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.case = 'Wrong point dimension (box 2D vs point 1D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointClosestPoint( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function pointExpand( test )
{

  test.case = 'Point remains unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var point = [ 0, 2 ];

  var gotBox = _.box.pointExpand( dstBox, point );
  test.identical( gotBox, dstBox );

  var oldPoint = point.slice();
  test.identical( point, oldPoint );

  var expected = [ 0, 0, 1, 2 ];
  test.identical( gotBox, expected );
  var oldPoint = [ 0, 2 ];
  test.identical( point, oldPoint );

  test.case = 'Null box expanded'; /* */

  var box = null;
  var point = [ 1, 2, 3 ];
  var expected = [ 1, 2, 3, 1, 2, 3 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.case = 'Null box NOT expanded'; /* */

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.case = 'One point box expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ - 1, 2, - 3 ];
  var expected = [ - 1,  0, - 3, 0, 2, 0 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.case = 'Box expanded'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 1, 3, - 1 ];
  var expected = [ - 1, 0, - 1, 2, 3, 2 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.case = 'Box NOT expanded ( point inside box )'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = [ 0,  0, 0, 2, 2, 2 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.case = 'Box ( normalized to 1 ) expanded'; /* */

  var box = [ - 0.050, 0.002, -0.238, 0.194, 0.766, 0.766 ];
  var point = [ -0.900, 0, 0.900 ];
  var expected = [ - 0.900,  0, -0.238, 0.194, 0.766, 0.900 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.case = 'Null box of four dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
  var point = [ 1, 2, 3 , 4 ];
  var expected = [ 0, 0, 0, 0, 1, 2, 3, 4 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.case = 'Null box of 7 dimensions expanded'; /* */

  var box = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
  var point = [ 1, 2, 3 , 4, 5, 6, 7 ];
  var expected = [ 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.case = 'Box of 1 dimension expanded'; /* */

  var box = [ 0, 0 ];
  var point = [ 1 ];
  var expected = [ 0, 1 ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.case = 'Box of 0 dimension expanded'; /* */

  var box = [ ];
  var point = [ ];
  var expected = [ ];

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  test.case = 'Box is vector'; /* */

  var box = _.vector.from( [ 0, 1, 2, 3, 4, 5 ] );
  var point = [ 0, 0, 0 ];
  var expected = _.vector.from( [ 0, 0, 0, 3, 4, 5 ] );

  var gotBox = _.box.pointExpand( box, point );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointExpand();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointExpand( 'box', 'points' );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointExpand( null, 4 );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ] );
  });

  test.case = 'Wrong point dimension (box 3D vs point 4D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 2 ] );
  });

  test.case = 'Wrong point dimension (box 3D vs point 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1 ] );
  });

  test.case = 'Wrong point dimension (box 2D vs point 1D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointExpand( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function pointRelative( test )
{

  test.case = 'Returns same instance point, box remains unchanged'; /* */

  var box = [ 0, 0, 2, 2 ];
  var point = [ 0, 1 ];

  var gotPoint = _.box.pointRelative( box, point );

  var expected = [ 0, 0.5 ];
  test.equivalent( gotPoint, expected );

  var oldPoint = [ 0, 1 ];
  test.equivalent( oldPoint, point );

  var oldBox = [ 0, 0, 2, 2 ];
  test.equivalent( oldBox, box );

  test.case = 'Empty point relative to null box'; /* */

  var box = null;
  var point = [ 0, 0, 0 ];
  var expected = [ NaN, NaN, NaN ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Empty point relative to empty box'; /* */

  var box = [];
  var point = [];
  var expected = [];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point relative to zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var point = [ 0, 0, 0 ];
  var expected = [ NaN, NaN, NaN ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point in medium of box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [  1, 1, 1 ];
  var expected = [ 0.5, 0.5, 0.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point with 1D out of box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ 1, 1, 3 ];
  var expected = [ 0.5, 0.5, 1.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point with 1D under box'; /* */

  var box = [ 0, 0, 0, 2, 2, 2 ];
  var point = [ - 1, 1, 1 ];
  var expected = [ - 0.5, 0.5, 0.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point (normalized to one) in box'; /* */

  var box = [ 0.000, 0.000, 0.000, 0.050, 0.050, 0.050 ];
  var point = [ 0.100, 0.025, 0.050 ];
  var expected = [ 2, 0.5, 1 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point (normalized to one) not in box'; /* */

  var box = [ 0.000, 0.000, 0.000, 0.050, 0.050, 0.050 ];
  var point = [ 0.075, 0.075, 0.075 ];
  var expected = [ 1.5, 1.5, 1.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point in four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, 0, 0 , 0 ];
  var expected = [ 0.5, 0.5, 0.5 , 0.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point out of four dimensions box'; /* */

  var box = [ - 1, - 1, - 1, - 1, 1, 1, 1, 1 ];
  var point = [ 0, - 2, 0 , 2 ];
  var expected = [ 0.5, - 0.5, 0.5 , 1.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point in seven dimensions box'; /* */

  var box = [ - 2, - 2, - 2, - 2, - 2, - 2, - 2, 1, 1, 1, 1, 1, 1, 1 ];
  var point = [ - 0.5, - 2, 1, - 3.5, 4, - 5, 7 ];
  var expected = [ 0.5, 0, 1, - 0.5, 2, - 1, 3 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point in one dimension box'; /* */

  var box = [ 0, 2 ];
  var point = [ 1 ];
  var expected = [ 0.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point out of one dimension box (smaller)'; /* */

  var box = [ 0, 2 ];
  var point = [ 3 ];
  var expected = [ 1.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  test.case = 'Point out of one dimension box (bigger)'; /* */

  var box = [ 0, 2 ];
  var point = [ - 3 ];
  var expected = [ - 1.5 ];

  var gotPoint = _.box.pointRelative( box, point );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointRelative();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointRelative( 'box', 'point' );
  });

  test.case = 'Point Null'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 1, 1, 1 ], null );
  });


  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0 ], [ 1, 0, 1 ], [ 1, 0, 1 ] );
  });

  test.case = 'Wrong point dimension (box 3D vs point 4D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.case = 'Wrong point dimension (box 3D vs point 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 2, 2, 2 ], [ 0, 1 ] );
  });

  test.case = 'Wrong point dimension (box 2D vs point 1D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.pointRelative( [ 0, 0, 0, 0 ], [ 0 ] );
  });
}

//

function boxContains( test )
{

  test.case = 'Source box and Destination box remain unchanged'; /* */

  // qqq : vars in case
  var srcBox = [ 0, 0, 3, 3 ];
  var tstBox = [ 1, 1, 2, 2 ];
  var expected = true;
  var gotBool = _.box.boxContains( srcBox, tstBox );
  test.identical( expected, gotBool );

  var oldSrcBox = srcBox.slice();
  test.identical( srcBox, oldSrcBox );

  var oldTstBox = tstBox.slice();
  test.identical( tstBox, oldTstBox );

  test.case = 'Empty box to empty box'; /* */

  var box = [];
  var boxTwo = [];
  var expected = false;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.case = 'Zero box to zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var boxTwo = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.case = 'Same boxes'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 0, 0, 0, 4, 4, 4 ];
  var expected = true;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.case = 'Box in box with a common side'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 1, 1, 1, 2, 2, 3 ];
  var expected = true;

  var gotBool = _.box.boxContains( box, boxTwo );
  test.identical( gotBool, expected );

  test.case = 'Box in box'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 1, 1, 1, 2, 2, 2 ];
  var expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box in box (other way aroud)'; /* */

  var box = [ 1, 1, 1, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 3, 3, 3 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box half in box'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 2, 2, 2, 6, 6, 6 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box totally out of box'; /* */

  var box = [ 0, 0, 0, 1, 1, 1 ];
  var boxTwo = [ 2, 2, 2, 3, 3, 3 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box out of box in two dimensions'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 0, - 1, - 1, 1, 0, 0 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box out of box in one dimensions'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 1, 1, 1, 3, 3, 5 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box in box (both normalized to one)'; /* */

  var box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var boxTwo = [ - 0.01, 0, - 0.02, 0.30, 0, 0.64 ];
  var expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box out of box (normalized to one)'; /* */

  var box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var boxTwo = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.90 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box in box (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box out of box (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 3 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box in box (one dimensions)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ 0, 1 ];
  var expected = true;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  test.case = 'Box out of box (four dimensions)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ 0, 4 ];
  var expected = false;

  var gotBool= _.box.boxContains( box, boxTwo );
  test.identical( gotBool,expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxContains();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxContains( 'box', 'box2' );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxContains( null, [] );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxContains( [], null );
  });


  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxContains( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxContains( [ 0, 0, 0, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] );
  });

  test.case = 'Different box dimensions (box 3D vs box 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxContains( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxContains( [ 0, 0, 0, 2, 2, 2, 2 ], [ 0, 0, 0, 2, 2, 2, 3 ], );
  });

}

//

function boxIntersects( test )
{

  test.case = 'Source box and Test box remain unchanged'; /* */

  var srcBox = [ 0, 0, 0, 2, 2, 2 ];
  var tstBox = [ 1, 1, 1, 3, 3, 3 ];
  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  var expected = true;
  test.identical( expected, gotBool );

  var oldsrcBox = srcBox.slice();
  test.identical( srcBox, oldsrcBox );

  var oldtstBox = tstBox.slice();
  test.identical( tstBox, oldtstBox );

  test.case = 'Zero box to zero box'; /* */

  var srcBox = [ 0, 0, 0, 0, 0, 0 ];
  var tstBox = [ 0, 0, 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Same boxes'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstBox = [ 0, 0, 0, 4, 4, 4 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box in box with a common side'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var tstBox = [ 1, 1, 1, 2, 2, 3 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box out of box with a common side'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var tstBox = [ 4, 4, 3, 5, 5, 5 ];
  var expected = false;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box in box'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var tstBox = [ 1, 1, 1, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box half in box'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstBox = [ 2, 2, 2, 6, 6, 6 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box totally out of box'; /* */

  var srcBox = [ 0, 0, 0, 1, 1, 1 ];
  var tstBox = [ 2, 2, 2, 3, 3, 3 ];
  var expected = false;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box out of box in two dimensions'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstBox = [ 0, - 1, - 1, 1, 0, 0 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box out of box in one dimensions'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstBox = [ 1, 1, 1, 3, 3, 5 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box in box (both normalized to one)'; /* */

  var srcBox = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var tstBox = [ - 0.01, 0, - 0.02, 0.30, 0, 0.64 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box out of box (normalized to one)'; /* */

  var srcBox = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var tstBox = [ 0.06, 0.8, 0.91, 0.64, 0.085, 0.99 ];
  var expected = false;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box half in box'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstBox = [ 2, 2, 2, 6, 6, 6 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Box of dimension 2'; /* */

  var srcBox = [ 0, 0, 4, 4 ];
  var tstBox = [ 2, 2, 6, 6 ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  test.case = 'Empty boxes intersect'; /* */

  var srcBox = [ ];
  var tstBox = [ ];
  var expected = true;

  var gotBool = _.box.boxIntersects( srcBox, tstBox );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.boxIntersects( ) );
  test.shouldThrowErrorSync( () => _.box.boxIntersects( [] ) );
  test.shouldThrowErrorSync( () => _.box.boxIntersects( 'box', 'box2' ) );
  test.shouldThrowErrorSync( () => _.box.boxIntersects(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.boxIntersects( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.boxIntersects( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.boxIntersects( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );

}

//

function boxDistance( test )
{

  test.case = 'Source and test box remain unchanged'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  var tstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.box.boxDistance( tstBox, srcBox );
  test.identical( gotDistance, expected );

  var oldSrcBox =  [ - 1, - 1, -1, 0, 0, 2 ];
  test.identical( srcBox, oldSrcBox );

  var oldTstBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstBox, oldTstBox );

  test.case = 'Corner distance 3D'; /* */

  var srcBox = [ 0, 0, 0, 1, 1, 1 ];
  var tstBox = [ 2, 2, 2, 3, 3, 3 ];
  var expected = Math.sqrt( 3 );

  var gotDistance = _.box.boxDistance( tstBox, srcBox );
  test.equivalent( gotDistance, expected );

  test.case = 'Opposite Corner distance 3D'; /* */

  var srcBox = [ 0, 0, 0, 1, 1, 1 ];
  var tstBox = [ -3, -3, -3, -2, -2, -2 ];
  var expected = Math.sqrt( 12 );

  var gotDistance = _.box.boxDistance( tstBox, srcBox );
  test.equivalent( gotDistance, expected );

  test.case = 'Corner distance 2D'; /* */

  var srcBox = [ 0, 0, 0, 1, 1, 0 ];
  var tstBox = [ 2, 2, 0, 3, 3, 0 ];
  var expected = Math.sqrt( 2 );

  var gotDistance = _.box.boxDistance( tstBox, srcBox );
  test.equivalent( gotDistance, expected );

  test.case = 'Opposite Corner distance 2D'; /* */

  var srcBox = [ 0, 0, 0, 1, 1 , 0];
  var tstBox = [ -3, -3, 0, -2, -2, 0 ];
  var expected = Math.sqrt( 8 );

  var gotDistance = _.box.boxDistance( tstBox, srcBox );
  test.equivalent( gotDistance, expected );

  test.case = 'Corner distance 1D'; /* */

  var srcBox = [ 0, 0, 0, 1, 1, 1 ];
  var tstBox = [ 2, 0, 0, 3, 1, 1 ];
  var expected = Math.sqrt( 1 );

  var gotDistance = _.box.boxDistance( tstBox, srcBox );
  test.equivalent( gotDistance, expected );

  test.case = 'Opposite Corner distance 1D'; /* */

  var srcBox = [ 0, 0, 0, 1, 1, 1 ];
  var tstBox = [ - 3, 0, 0, - 2, 1, 1 ];
  var expected = 2;

  var gotDistance = _.box.boxDistance( tstBox, srcBox );
  test.equivalent( gotDistance, expected );

  test.case = 'srcBox inside tstBox'; /* */

  var srcBox = [ 0, 0, 0, 1, 1, 1 ];
  var tstBox = [ -1, -1, -1, 2, 2, 2 ];
  var expected = 0;

  var gotDistance = _.box.boxDistance( tstBox, srcBox );
  test.equivalent( gotDistance, expected );

  test.case = 'tstBox inside srcBox'; /* */

  var srcBox = [ -1, -1, -1, 2, 2, 2 ];
  var tstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotDistance = _.box.boxDistance( tstBox, srcBox );
  test.equivalent( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.boxDistance( ) );
  test.shouldThrowErrorSync( () => _.box.boxDistance( [] ) );
  test.shouldThrowErrorSync( () => _.box.boxDistance( 'box', 'box2' ) );
  test.shouldThrowErrorSync( () => _.box.boxDistance(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.boxDistance( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.boxDistance( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.boxDistance( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
}

//

function boxClosestPoint( test )
{

  test.case = 'Source and test box remain unchanged'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  var tstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBox = _.box.boxClosestPoint( srcBox, tstBox );
  test.identical( expected, gotBox );

  var oldSrcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  test.identical( srcBox, oldSrcBox );

  var oldTstBox = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstBox, oldTstBox );

  test.case = 'Boxes intersect'; /* */

  var srcBox = [ - 1, - 1, -1, 1, 1, 1 ];
  var tstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBox = _.box.boxClosestPoint( srcBox, tstBox );
  test.identical( expected, gotBox );

  test.case = 'Boxes touching in corner'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstBox = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotBox = _.box.boxClosestPoint( srcBox, tstBox );
  test.identical( expected, gotBox );

  test.case = 'Tst Corner'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstBox = [ 1, 1, 1, 2, 2, 2 ];
  var expected = [ 1, 1, 1 ];

  var gotBox = _.box.boxClosestPoint( srcBox, tstBox );
  test.identical( expected, gotBox );

  test.case = 'Tst Corner opposite side'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstBox = [ -3, -3, -3, -2, -2, -2 ];
  var expected = [ -2, -2, -2 ];

  var gotBox = _.box.boxClosestPoint( srcBox, tstBox );
  test.identical( expected, gotBox );

  test.case = 'Src bigger than Tst side'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstBox = [ 1, 1, 5, 3, 3, 6 ];
  var expected = [ 3, 3, 5 ];

  var gotBox = _.box.boxClosestPoint( srcBox, tstBox );
  test.identical( expected, gotBox );

  test.case = 'Tst bigger than Src side'; /* */

  var srcBox = [ 1, 1, 5, 3, 3, 6 ];
  var tstBox = [ 0, 0, 0, 4, 4, 4 ];
  var expected = [ 3, 3, 4 ];

  var gotBox = _.box.boxClosestPoint( srcBox, tstBox );
  test.identical( expected, gotBox );

  test.case = 'dstPoint Array'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstBox = [ -1, -2, -3, 3, 2, -1 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 3, 2, -1 ];

  var gotBox = _.box.boxClosestPoint( srcBox, tstBox, dstPoint );
  test.identical( expected, gotBox );
  test.is( dstPoint === gotBox );

  test.case = 'dstPoint Vector'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstBox = [ -1, -2, -3, 3, 2, -1 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 3, 2, -1 ] );

  var gotBox = _.box.boxClosestPoint( srcBox, tstBox, dstPoint );
  test.identical( expected, gotBox );
  test.is( dstPoint === gotBox );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.boxClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.box.boxClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.box.boxClosestPoint( 'box', 'box2' ) );
  test.shouldThrowErrorSync( () => _.box.boxClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.boxClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.boxClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.boxClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.box.boxClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.box.boxClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function boxExpand( test )
{

  test.case = 'Source box remains unchanged and Destination box changes'; /* */

  var dstBox = [ 0, 0, 1, 1 ];
  var srcBox = [ - 1, - 1, 0, 2 ];
  var expected = [ - 1, - 1, 1, 2 ];

  var gotBox = _.box.boxExpand( dstBox, srcBox );
  test.identical( dstBox, gotBox );

  var oldSrcBox = [ - 1, - 1, 0, 2 ];
  test.identical( srcBox, oldSrcBox );

  test.case = 'Empty box expands empty box'; /* */

  var box = [];
  var boxTwo = [];
  var expected = [];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );


  test.case = 'Zero box expands zero box'; /* */

  var box = [ 0, 0, 0, 0, 0, 0 ];
  var boxTwo = [ 0, 0, 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = 'Same boxes (no expansion)'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 0, 0, 0, 4, 4, 4 ];
  var expected = [ 0, 0, 0, 4, 4, 4 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = 'Smaller box (no expansion)'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 1, 1, 1, 2, 2, 2 ];
  var expected = [ 0, 0, 0, 3, 3, 3 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = '1D expansion'; /* */

  var box = [ 0, 0, 0, 3, 3, 3 ];
  var boxTwo = [ 1, 1, 1, 2, 2, 4 ];
  var expected = [ 0, 0, 0, 3, 3, 4 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = '2D expansion'; /* */

  var box = [ 0, 0, 0, 4, 4, 4 ];
  var boxTwo = [ 2, - 2, - 2, 4, 6, 6 ];
  var expected = [ 0, - 2, - 2, 4, 6, 6 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = '3D expansion'; /* */

  var box = [ 0, 0, 0, 1, 1, 1 ];
  var boxTwo = [ - 2, - 2, - 2, 3, 3, 3 ];
  var expected = [ - 2, - 2, - 2, 3, 3, 3 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = 'Random expansion'; /* */

  var box = [ 0, - 5, 3, 2, 3, 3 ];
  var boxTwo = [ - 1, - 1, - 1, 2.5, 2.5, 2.5 ];
  var expected = [ - 1, - 5, - 1, 2.5, 3, 3 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = 'Box expanded (normalized to one)'; /* */

  var box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var boxTwo = [ - 0.01, 0, - 0.02, 0.30, 0, 0.90 ];
  var expected = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.90 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = 'Box not expanded (normalized to one)'; /* */

  var box = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];
  var boxTwo = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.70 ];
  var expected = [ - 0.02, - 0.10, - 0.04, 0.56, 0.07, 0.80 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = 'Box expanded (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 0, 3, 3, 3, 3 ];
  var expected = [ - 1, - 1, - 1, - 1, 3, 3, 3, 3 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = 'Box not expanded (four dimensions)'; /* */

  var box = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];
  var boxTwo = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
  var expected = [ - 1, - 1, - 1, - 1, 2, 2, 2, 2 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = 'Box expanded (one dimension)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ - 2, 10 ];
  var expected = [ - 2, 10 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = 'Box expanded on one side (one dimension)'; /* */

  var box = [ - 1, 2 ];
  var boxTwo = [ 0, 4 ];
  var expected = [ - 1, 4 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  test.case = 'Box not expanded (one dimension)'; /* */

  var box = [ - 1, 3 ];
  var boxTwo = [ 0, 1 ];
  var expected = [ - 1, 3 ];

  var gotBox = _.box.boxExpand( box, boxTwo );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'No arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxExpand();
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxExpand( 'box', 'box2' );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxExpand( null, [] );
  });

  test.case = 'Wrong type of argument'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxExpand( [], null );
  });

  test.case = 'Too few arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 0, 0, 0 ] );
  });

  test.case = 'too many arguments'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] );
  });

  test.case = 'Different box dimensions (box 3D vs box 2D)'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 3, 3, 3 ], [ 0, 1, 0, 2 ] );
  });

  test.case = 'Wrong box dimension'; /* */
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.box.boxExpand( [ 0, 0, 0, 2, 2, 2, 2 ], [ 0, 0, 0, 2, 2, 2, 3 ], );
  });

}

//

function capsuleClosestPoint( test )
{

  test.case = 'Source box and capsule remain unchanged'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = 0;

  var gotCapsule = _.box.capsuleClosestPoint( srcBox, tstCapsule );
  test.identical( expected, gotCapsule );

  var oldSrcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  test.identical( srcBox, oldSrcBox );

  var oldtstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  test.identical( tstCapsule, oldtstCapsule );

  test.case = 'Box and capsule intersect'; /* */

  var srcBox = [ - 1, - 1, -1, 1, 1, 1 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 1 ];
  var expected = 0;

  var gotCapsule = _.box.capsuleClosestPoint( srcBox, tstCapsule );
  test.identical( expected, gotCapsule );

  test.case = 'Capsule origin is box corner'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstCapsule = [ 0, 0, 0, 1, 1, 1, 0.5 ];
  var expected = 0;

  var gotCapsule = _.box.capsuleClosestPoint( srcBox, tstCapsule );
  test.identical( expected, gotCapsule );

  test.case = 'Capsule is box side'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstCapsule = [ - 1, 0, 0, 1, 0, 0, 0 ];
  var expected = 0;

  var gotCapsule = _.box.capsuleClosestPoint( srcBox, tstCapsule );
  test.identical( expected, gotCapsule );

  test.case = 'Negative capsule'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstCapsule = [ -3, -3, -3, -2, -2, -2, 1 ];
  var expected = [ -1, -1, -1 ];

  var gotCapsule = _.box.capsuleClosestPoint( srcBox, tstCapsule );
  test.identical( expected, gotCapsule );

  test.case = 'Closest point in box side'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstCapsule = [ 5, 5, 2, 5, 11, 2, 0.5 ];
  var expected = [ 4, 4, 2 ];

  var gotCapsule = _.box.capsuleClosestPoint( srcBox, tstCapsule );
  test.identical( expected, gotCapsule );

  test.case = 'dstPoint Array'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstCapsule = [ 5, 5, 1, 11, 5, 1, 0.3 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 4, 4, 1 ];

  var gotCapsule = _.box.capsuleClosestPoint( srcBox, tstCapsule, dstPoint );
  test.identical( expected, gotCapsule );
  test.is( dstPoint === gotCapsule );

  test.case = 'dstPoint Vector'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstCapsule = [ 5, 5, 1, 10, 5, 1, 0.2 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 4, 4, 1 ] );

  var gotCapsule = _.box.capsuleClosestPoint( srcBox, tstCapsule, dstPoint );
  test.equivalent( expected, gotCapsule );
  test.is( dstPoint === gotCapsule );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint( 'box', [ 0, 1, 0, 1, 2, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint( [ 0, 0, 0, 1, 1, 1 ], 'capsule' ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint(  null, [ 0, 1, 0, 1, 2, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint(  [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint(  NaN, [ 0, 1, 0, 1, 2, 1, 1 ] ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint(  [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1, 1 ], [ 1, 0, 1, 2, 1, 2, 1 ] ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, -1 ] ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.box.capsuleClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function frustumContains( test )
{
  test.description = 'Frustum and box remain unchanged'; //

  var frustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 1, 1, 1, 3, 3, 3 ];
  var oldBox = box.slice();
  var expected = false;

  var gotBool = _.box.frustumContains( box, frustum );
  test.identical( gotBool, expected );
  test.identical( box, oldBox );

  var oldFrustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  test.identical( frustum, oldFrustum );

  test.description = 'Box contains frustum'; //

  var frustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ -1, -1, -1, 3, 3, 3 ];
  var expected = true;

  var gotBool = _.box.frustumContains( box, frustum );
  test.identical( gotBool, expected );

  test.description = 'Box contains Zero frustum'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    0,   0,   0,   0,   0,   0 ]
  );

  var box = [ -1, -1, -1, 3, 3, 3 ];
  var expected = true;

  var gotBool = _.box.frustumContains( box, frustum );
  test.identical( gotBool, expected );

  test.description = 'Box contains frustum, touching sides'; //

  var frustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 0, 0, 0, 1, 1, 1 ];
  var expected = true;

  var gotBool = _.box.frustumContains( box, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum contains box'; //

  var frustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 0.1, 0.1, 0.1, 0.5, 0.5, 0.5 ];
  var expected = false;

  var gotBool = _.box.frustumContains( box, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box intersect'; //

  var frustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 0.1, 0.1, 0.1, 2, 2, 2 ];
  var expected = false;

  var gotBool = _.box.frustumContains( box, frustum );
  test.identical( gotBool, expected );

  test.description = 'Frustum and box in different places'; //

  var frustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ 3, 3, 3, 4, 4, 4 ];
  var expected = false;

  var gotBool = _.box.frustumContains( box, frustum );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  var frustum =  _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1 ]
  );

  test.shouldThrowErrorSync( () => _.box.frustumContains( ));
  test.shouldThrowErrorSync( () => _.box.frustumContains( box ));
  test.shouldThrowErrorSync( () => _.box.frustumContains( frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumContains( box, frustum, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumContains( box, box, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumContains( box, null ));
  test.shouldThrowErrorSync( () => _.box.frustumContains( null, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumContains( box, NaN ));
  test.shouldThrowErrorSync( () => _.box.frustumContains( NaN, frustum ));

  box = [ 0, 0, 1, 1];
  test.shouldThrowErrorSync( () => _.box.frustumContains( box, frustum ));
  box = [ 0, 0, 1, 1, 2];
  test.shouldThrowErrorSync( () => _.box.frustumContains( box, frustum ));
  box = [ 0, 0, 1, 1, 2, 2, 2 ];
  test.shouldThrowErrorSync( () => _.box.frustumContains( box, frustum ));

}

//

function frustumDistance( test )
{

  test.description = 'Frustum and box remain unchanged'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5 ];
  var oldBox = box.slice();
  var expected = 0;

  var gotDistance = _.box.frustumDistance( box, frustum );
  test.equivalent( gotDistance, expected );
  test.identical( box, oldBox );

  var oldF = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( frustum, oldF );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 2, 2, 2, 2.5, 2.5, 2.5 ];
  var expected = Math.sqrt( 3 );

  var gotDistance = _.box.frustumDistance( box, frustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 0, 0, 0 )'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, -1, -0.5, -0.5, -0.5 ];
  var expected = Math.sqrt( 0.75 );
 debugger;
  var gotDistance = _.box.frustumDistance( box, frustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Box and frustum intersect'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, -1, 0.5, 0.5, 0.5 ];
  var expected = 0;

  var gotDistance = _.box.frustumDistance( box, frustum );
  test.identical( gotDistance, expected );

  test.description = 'Point in inclined frustum side'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, 1, 0.5, 1.5, 2 ];
  var expected = Math.sqrt( 0.05 );

  var gotDistance = _.box.frustumDistance( box, frustum );
  test.equivalent( gotDistance, expected );

  test.description = 'Diagonal frustum plane'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ -2, -2, 2, 0, 0, 4 ];
  var expected = Math.sqrt( 3.4 );

  var gotDistance = _.box.frustumDistance( box, frustum );
  test.equivalent( gotDistance, expected );

  test.description = 'PointBox'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -2, -2, -2, -2, -2, -2 ];
  var expected = Math.sqrt( 12 );

  var gotDistance = _.box.frustumDistance( box, frustum );
  test.equivalent( gotDistance, expected );

  test.description = 'PointBox on side'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 1.1, 0.5, 0.5, 1.1, 0.5, 0.5 ];
  var expected = 0.1;

  var gotDistance = _.box.frustumDistance( box, frustum );
  test.equivalent( gotDistance, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.frustumDistance( ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( frustum, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( null ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( NaN ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( [ 0, 0, 2, 1 ], frustum));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( [ ] ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( [ 0, 0, 0, 0, 0, 0 ], null ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( [ 0, 0, 0, 0, 0, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( null, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( [ 0, 0, 0, 0, 0, 0 ], frustum, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumDistance( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], frustum ));

}

function frustumClosestPoint( test )
{
  test.description = 'Frustum and box remain unchanged'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5 ];
  var oldBox = box.slice();
  var expected = 0;

  var gotPoint = _.box.frustumClosestPoint( box, frustum );
  test.equivalent( gotPoint, expected );
  test.identical( box, oldBox );

  var oldFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( frustum, oldFrustum );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 1, 1, 1 )'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 2, 2, 2, 2.5, 2.5, 2.5 ];
  var expected = [ 2, 2, 2 ];

  var gotPoint = _.box.frustumClosestPoint( box, frustum );
  test.equivalent( gotPoint, expected );

  test.description = 'Frustrum as box ( 0, 0, 0, 1, 1, 1 ) - corner ( 0, 0, 0 )'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, -1, -0.5, -0.5, -0.5 ];
  var expected = [ -0.5, -0.5, -0.5 ];

  var gotPoint = _.box.frustumClosestPoint( box, frustum );
  test.equivalent( gotPoint, expected );

  test.description = 'Box and frustum intersect'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, -1, 0.5, 0.5, 0.5 ];
  var expected = 0;

  var gotPoint = _.box.frustumClosestPoint( box, frustum );
  test.equivalent( gotPoint, expected );

  test.description = 'Point in inclined frustum side'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, 1, 0.5, 1.5, 2 ];
  var expected = [ 0.5, 1.5, 1 ];

  var gotPoint = _.box.frustumClosestPoint( box, frustum );
  test.equivalent( gotPoint, expected );

  test.description = 'Diagonal frustum plane'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ -2, -2, 2, 0, 0, 4 ];
  var expected = [ 0, 0, 2 ];

  var gotPoint = _.box.frustumClosestPoint( box, frustum );
  test.equivalent( gotPoint, expected );

  test.description = 'PointBox'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -2, -2, -2, -2, -2, -2 ];
  var expected = [ -2, -2, -2 ];

  var gotPoint = _.box.frustumClosestPoint( box, frustum );
  test.equivalent( gotPoint, expected );

  test.description = 'PointBox on side'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 1.1, 0.5, 0.5, 1.1, 0.5, 0.5 ];
  var expected = [ 1.1, 0.5, 0.5 ];

  var gotPoint = _.box.frustumClosestPoint( box, frustum );
  test.equivalent( gotPoint, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( frustum, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( null ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( NaN ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( [ 0, 0, 2, 1 ], frustum));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( [ ] ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( [ 0, 0, 0, 0, 0, 0 ], null ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( [ 0, 0, 0, 0, 0, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( null, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( [ 0, 0, 0, 0, 0, 0 ], frustum, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumClosestPoint( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], frustum ));

}

function frustumExpand( test )
{

  test.description = 'Frustum remains unchanged'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5 ];
  var expected = [ 0, 0, 0, 1.5, 1.5, 1.5 ];

  var gotBox = _.box.frustumExpand( box, srcFrustum );
  test.equivalent( gotBox, expected );

  var oldFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  test.identical( srcFrustum, oldFrustum );

  test.description = 'Frustum Expands box'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 2,   0, - 2,   0,   0, - 2
  ]);
  var box = [ 0.5, 0.5, 0.5, 1.5, 1.5, 1.5 ];
  var expected = [ 0, 0, 0, 2, 2, 2 ];

  var gotBox = _.box.frustumExpand( box, srcFrustum );
  test.identical( gotBox, expected );

  test.description = 'Frustrum expands only one side of box'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 2, 0, - 2,   0,   0, - 2
  ]);
  var box = [ 0, 0, 0.5, 1.5, 2, 2 ];
  var expected = [ 0, 0, 0, 2, 2, 2 ];

  var gotBox = _.box.frustumExpand( box, srcFrustum );
  test.identical( gotBox, expected );

  test.description = 'Box outside frustum'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 2, 2, 2, 2.5, 2.5, 2.5 ];
  var expected = [ 0, 0, 0, 2.5, 2.5, 2.5 ];

  var gotBox = _.box.frustumExpand( box, srcFrustum );
  test.identical( gotBox, expected );

  test.description = 'Box outside frustum opposite side'; //

  var frustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, -1, -0.5, -0.5, -0.5 ];
  var expected = [ -1, -1, -1, 1, 1, 1 ];

  var gotBox = _.box.frustumExpand( box, srcFrustum );
  test.identical( gotBox, expected );

  test.description = 'Box and frustum intersect'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, -1, 0.5, 0.5, 0.5 ];
  var expected = [ -1, -1, -1, 1, 1, 1 ];

  var gotBox = _.box.frustumExpand( box, srcFrustum );
  test.identical( gotBox, expected );

  test.description = 'Point in inclined frustum side'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -1, -1, 1, 0.5, 1.5, 2 ];
  var expected = [ -1, -1, 0, 1, 3, 2 ];

  var gotBox = _.box.frustumExpand( box, srcFrustum );
  test.identical( gotBox, expected );

  test.description = 'Diagonal frustum plane'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1 ]
  );
  var box = [ -2, -2, 2, 0, 0, 4 ];
  var expected = [ -2, -2, 0, 1, 3, 4 ];

  var gotBox = _.box.frustumExpand( box, srcFrustum );
  test.identical( gotBox, expected );

  test.description = 'PointBox'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   2,   1, - 1,   0,   0,
    - 3,   0, - 1,   0,   0, - 1
  ]);
  var box = [ -2, -2, -2, -2, -2, -2 ];
  var expected = [ -2, -2, -2, 1, 3, 1 ];

  var gotBox = _.box.frustumExpand( box, srcFrustum );
  test.identical( gotBox, expected );

  test.description = 'PointBox on side'; //

  var srcFrustum = _.Space.make( [ 4, 6 ] ).copy
  ([
    0,   0,   0,   0, - 1,   1,
    1, - 1,   0,   0,   0,   0,
    0,   0,   1, - 1,   0,   0,
    - 1,   0, - 1,   0,   0, - 1
  ]);
  var box = [ 1.1, 0.5, 0.5, 1.1, 0.5, 0.5 ];
  var expected = [ 0, 0, 0, 1.1, 1, 1 ];

  var gotBox = _.box.frustumExpand( box, srcFrustum );
  test.identical( gotBox, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.frustumExpand( ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( frustum, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( null ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( NaN ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( [ 0, 0, 2, 1 ], frustum));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( [ 0, 0, 0, 0, 0, 0 ] ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( [ ] ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( [ 0, 0, 0, 0, 0, 0 ], null ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( [ 0, 0, 0, 0, 0, 0 ], NaN ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( null, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( NaN, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( [ 0, 0, 0, 0, 0, 0 ], frustum, frustum ));
  test.shouldThrowErrorSync( () => _.box.frustumExpand( [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], frustum ));

}

//

function lineClosestPoint( test )
{

  test.case = 'Source box and line remain unchanged'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotLine = _.box.lineClosestPoint( srcBox, tstLine );
  test.identical( expected, gotLine );

  var oldSrcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  test.identical( srcBox, oldSrcBox );

  var oldtstLine = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstLine, oldtstLine );

  test.case = 'Box and line intersect'; /* */

  var srcBox = [ - 1, - 1, -1, 1, 1, 1 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotLine = _.box.lineClosestPoint( srcBox, tstLine );
  test.identical( expected, gotLine );

  test.case = 'Line origin is box corner'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstLine = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotLine = _.box.lineClosestPoint( srcBox, tstLine );
  test.identical( expected, gotLine );

  test.case = 'Line is box side'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstLine = [ - 1, 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotLine = _.box.lineClosestPoint( srcBox, tstLine );
  test.identical( expected, gotLine );

  test.case = 'Negative factor'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstLine = [ -3, -3, -3, -2, -2, -2 ];
  var expected = 0;

  var gotLine = _.box.lineClosestPoint( srcBox, tstLine );
  test.identical( expected, gotLine );

  test.case = 'Closest point in box side'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstLine = [ 5, 5, 2, 0, 1, 0 ];
  var expected = [ 4, 4, 2 ];

  var gotLine = _.box.lineClosestPoint( srcBox, tstLine );
  test.identical( expected, gotLine );

  test.case = 'dstPoint Array'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstLine = [ 5, 5, 1, 1, 0, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 4, 4, 1 ];

  var gotLine = _.box.lineClosestPoint( srcBox, tstLine, dstPoint );
  test.identical( expected, gotLine );
  test.is( dstPoint === gotLine );

  test.case = 'dstPoint Vector'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstLine = [ 5, 5, 1, 1, 0, 0 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 4, 4, 1 ] );

  var gotLine = _.box.lineClosestPoint( srcBox, tstLine, dstPoint );
  test.equivalent( expected, gotLine );
  test.is( dstPoint === gotLine );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.lineClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.box.lineClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.box.lineClosestPoint( 'box', 'line' ) );
  test.shouldThrowErrorSync( () => _.box.lineClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.lineClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.lineClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.box.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.box.lineClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function planeDistance( test )
{

  test.case = 'Source plane and box remain unchanged'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var oldSrcBox = srcBox.slice();
  var srcPlane = [ 1, 0, 0, 1 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = 1;

  var gotDistance = _.box.planeDistance( srcBox, srcPlane );
  test.identical( expected, gotDistance );
  test.identical( srcBox, oldSrcBox );
  test.identical( srcPlane, oldSrcPlane );

  test.case = 'Plane as box side'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, - 3 ];
  var expected = 0;

  var gotDistance = _.box.planeDistance( srcBox, srcPlane );
  test.identical( expected, gotDistance );

  test.case = 'Plane touching box corner'; /* */

  var srcBox = [ 0, 1, 2, 1, 1, 3 ];
  var srcPlane = [ 1, -1, 0, 0 ];
  var expected = 0;

  var gotDistance = _.box.planeDistance( srcBox, srcPlane );
  test.identical( expected, gotDistance );

  test.case = 'Plane crossing box'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, - 1 ];
  var expected = 0;

  var gotDistance = _.box.planeDistance( srcBox, srcPlane );
  test.identical( expected, gotDistance );

  test.case = 'Plane under box parallel to side'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, 3 ];
  var expected = 3;

  var gotDistance = _.box.planeDistance( srcBox, srcPlane );
  test.identical( expected, gotDistance );

  test.case = 'Plane over box'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, - 6 ];
  var expected = 3;

  var gotDistance = _.box.planeDistance( srcBox, srcPlane );
  test.identical( expected, gotDistance );

  test.case = 'Plane close to box corner'; /* */

  var srcBox = [ 3, 0, 2, 4, 1, 2 ];
  var srcPlane = [ 1, -1, 0, 0 ];
  var expected = Math.sqrt( 2 );

  var gotDistance = _.box.planeDistance( srcBox, srcPlane );
  test.equivalent( expected, gotDistance );

  test.case = 'Zero box'; /* */

  var srcBox = [ 0, 0, 0, 0, 0, 0 ];
  var srcPlane = [ 1, -1, 4, 3 ];
  var expected = Math.sqrt( 2 )/2;

  var gotDistance = _.box.planeDistance( srcBox, srcPlane );
  test.equivalent( expected, gotDistance );

  test.case = '2D'; /* */

  var srcBox = [ 0, 0, 0, 0 ];
  var srcPlane = [ 1, -1, 3 ];
  var expected = Math.sqrt( 4.5 );

  var gotDistance = _.box.planeDistance( srcBox, srcPlane );
  test.equivalent( expected, gotDistance );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.planeDistance( ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance( [] ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance( [], [] ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance( 'box', 'plane' ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance( null, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeDistance( [ 0, 1, 0, 1, 2, 1 ], NaN ) );

}

//

function planeClosestPoint( test )
{

  test.case = 'Source plane and box remain unchanged'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var oldSrcBox = srcBox.slice();
  var srcPlane = [ 1, 0, 0, 1 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane );
  test.identical( expected, gotPoint );
  test.identical( srcBox, oldSrcBox );
  test.identical( srcPlane, oldSrcPlane );

  test.case = 'Plane and box intersect'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, - 1 ];
  var expected = 0;

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane );
  test.identical( expected, gotPoint );

  test.case = 'Plane is box side'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, 0 ];
  var expected = 0;

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane );
  test.identical( expected, gotPoint );

  test.case = 'Plane parallel to box side x = 0'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane );
  test.identical( expected, gotPoint );

  test.case = 'Plane parallel to box side y = 0'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 0, 1, 0, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane );
  test.identical( expected, gotPoint );

  test.case = 'Plane parallel to box side x = 3'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, - 4 ];
  var expected = [ 3, 0, 0 ];

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane );
  test.identical( expected, gotPoint );

  test.case = 'Plane parallel to box side y = 3'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 0, 1, 0, - 4 ];
  var expected = [ 0, 3, 0 ];

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane );
  test.identical( expected, gotPoint );

  test.case = 'Plane next to box corner [ 0, 0, 0 ]'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 1, 0, 1 ];
  var expected = [ 0, 0, 0 ];

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane );
  test.identical( expected, gotPoint );

  test.case = 'Plane next to box corner [ 3, 3, 3 ]'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 1, 0, - 7 ];
  var expected = [ 3, 3, 0 ];

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane );
  test.identical( expected, gotPoint );

  test.case = 'Plane next to box corner [ 3, 0, 0 ]'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, - 1, 0, - 7 ];
  var expected = [ 3, 0, 0 ];

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane );
  test.identical( expected, gotPoint );

  test.case = 'dstPoint is array'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, - 1, 0, - 7 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 3, 0, 0 ];

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane, dstPoint );
  test.identical( expected, gotPoint );
  test.is( dstPoint === gotPoint );

  test.case = 'dstPoint is vector'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, - 1, 0, - 7 ];
  var dstPoint = _.vector.fromArray( [ 0, 0, 0 ] );
  var expected = _.vector.fromArray( [ 3, 0, 0 ] );

  var gotPoint = _.box.planeClosestPoint( srcBox, srcPlane, dstPoint );
  test.identical( expected, gotPoint );
  test.is( dstPoint === gotPoint );
  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( [], [] ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( 'box', 'plane' ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( null, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.box.planeClosestPoint( [ 0, 1, 0, 1 ], [ 0, 0, 1 ] ) );

}

//

function planeExpand( test )
{

  test.case = 'Source plane remains unchanged'; /* */

  var dstBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, 1 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = [ -1, 0, 0, 3, 3, 3 ];

  var gotBox = _.box.planeExpand( dstBox, srcPlane );
  test.identical( expected, gotBox );
  test.is( gotBox === dstBox );
  test.identical( srcPlane, oldSrcPlane );

  test.case = 'Plane and box intersect - no expansion'; /* */

  var dstBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, - 1 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = [ 0, 0, 0, 3, 3, 3 ];

  var gotBox = _.box.planeExpand( dstBox, srcPlane );
  test.identical( expected, gotBox );

  test.case = 'Box expanded by min'; /* */

  var dstBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 1, 1, 3 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = [ -1, -1, -1, 3, 3, 3 ];

  var gotBox = _.box.planeExpand( dstBox, srcPlane );
  test.identical( expected, gotBox );

  test.case = 'Box expanded by max'; /* */

  var dstBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 1, 1, - 12 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = [ 0, 0, 0, 4, 4, 4 ];

  var gotBox = _.box.planeExpand( dstBox, srcPlane );
  test.identical( expected, gotBox );

  test.case = 'Box expanded on two sides - by min'; /* */

  var dstBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 1, 0, 8 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = [ -4, -4, 0, 3, 3, 3 ];

  var gotBox = _.box.planeExpand( dstBox, srcPlane );
  test.identical( expected, gotBox );

  test.case = 'Box expanded on two sides - by max'; /* */

  var dstBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 1, 0, - 8 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = [ 0, 0, 0, 4, 4, 3 ];

  var gotBox = _.box.planeExpand( dstBox, srcPlane );
  test.identical( expected, gotBox );

  test.case = 'Box expanded on one side by min'; /* */

  var dstBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, 3 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = [ -3, 0, 0, 3, 3, 3 ];

  var gotBox = _.box.planeExpand( dstBox, srcPlane );
  test.identical( expected, gotBox );

  test.case = 'Box expanded on one side by max'; /* */

  var dstBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcPlane = [ 1, 0, 0, - 4 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = [ 0, 0, 0, 4, 3, 3 ];

  var gotBox = _.box.planeExpand( dstBox, srcPlane );
  test.identical( expected, gotBox );

  test.case = 'dstBox is vector'; /* */

  var dstBox = _.vector.fromArray( [ 0, 0, 0, 3, 3, 3 ] );
  var srcPlane = [ 1, 1, 0, - 8 ];
  var oldSrcPlane = srcPlane.slice();
  var expected = _.vector.fromArray( [ 0, 0, 0, 4, 4, 3 ] );

  var gotBox = _.box.planeExpand( dstBox, srcPlane );
  test.identical( expected, gotBox );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.planeExpand( ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( [] ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( [], [] ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( 'box', 'plane' ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( null, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.box.planeExpand( [ 0, 1, 0, 1 ], [ 0, 0, 1 ] ) );

}

//

function rayClosestPoint( test )
{

  test.case = 'Source box and ray remain unchanged'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotRay = _.box.rayClosestPoint( srcBox, tstRay );
  test.identical( expected, gotRay );

  var oldSrcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  test.identical( srcBox, oldSrcBox );

  var oldtstRay = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstRay, oldtstRay );

  test.case = 'Box and ray intersect'; /* */

  var srcBox = [ - 1, - 1, -1, 1, 1, 1 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotRay = _.box.rayClosestPoint( srcBox, tstRay );
  test.identical( expected, gotRay );

  test.case = 'Ray origin is box corner'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstRay = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotRay = _.box.rayClosestPoint( srcBox, tstRay );
  test.identical( expected, gotRay );

  test.case = 'Ray is box side'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstRay = [ - 1, 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotRay = _.box.rayClosestPoint( srcBox, tstRay );
  test.identical( expected, gotRay );

  test.case = 'Box corner is the closest point'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstRay = [ -3, -3, -3, -2, -2, -2 ];
  var expected = [ -1, -1, -1 ];

  var gotRay = _.box.rayClosestPoint( srcBox, tstRay );
  test.identical( expected, gotRay );

  test.case = 'Closest point in box side'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstRay = [ 5, 5, 2, 0, 1, 0 ];
  var expected = [ 4, 4, 2 ];

  var gotRay = _.box.rayClosestPoint( srcBox, tstRay );
  test.identical( expected, gotRay );

  test.case = 'dstPoint Array'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstRay = [ 5, 5, 1, 1, 0, 0 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 4, 4, 1 ];

  var gotRay = _.box.rayClosestPoint( srcBox, tstRay, dstPoint );
  test.identical( expected, gotRay );
  test.is( dstPoint === gotRay );

  test.case = 'dstPoint Vector'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstRay = [ 5, 5, 1, 1, 0, 0 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 4, 4, 1 ] );

  var gotRay = _.box.rayClosestPoint( srcBox, tstRay, dstPoint );
  test.equivalent( expected, gotRay );
  test.is( dstPoint === gotRay );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.rayClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.box.rayClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.box.rayClosestPoint( 'box', 'ray' ) );
  test.shouldThrowErrorSync( () => _.box.rayClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.rayClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.rayClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.box.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.box.rayClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function segmentClosestPoint( test )
{

  test.case = 'Source box and segment remain unchanged'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotSegment = _.box.segmentClosestPoint( srcBox, tstSegment );
  test.identical( expected, gotSegment );

  var oldSrcBox = [ - 1, - 1, -1, 0, 0, 2 ];
  test.identical( srcBox, oldSrcBox );

  var oldtstSegment = [ 0, 0, 0, 1, 1, 1 ];
  test.identical( tstSegment, oldtstSegment );

  test.case = 'Box and segment intersect'; /* */

  var srcBox = [ - 1, - 1, -1, 1, 1, 1 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotSegment = _.box.segmentClosestPoint( srcBox, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Segment origin is box corner'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstSegment = [ 0, 0, 0, 1, 1, 1 ];
  var expected = 0;

  var gotSegment = _.box.segmentClosestPoint( srcBox, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Segment is box side'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstSegment = [ - 1, 0, 0, 1, 0, 0 ];
  var expected = 0;

  var gotSegment = _.box.segmentClosestPoint( srcBox, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Negative segment'; /* */

  var srcBox = [ - 1, - 1, -1, 0, 0, 0 ];
  var tstSegment = [ -3, -3, -3, -2, -2, -2 ];
  var expected = [ -1, -1, -1 ];

  var gotSegment = _.box.segmentClosestPoint( srcBox, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'Closest point in box side'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSegment = [ 5, 5, 2, 5, 11, 2 ];
  var expected = [ 4, 4, 2 ];

  var gotSegment = _.box.segmentClosestPoint( srcBox, tstSegment );
  test.identical( expected, gotSegment );

  test.case = 'dstPoint Array'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSegment = [ 5, 5, 1, 11, 5, 1 ];
  var dstPoint = [ 0, 0, 0 ];
  var expected = [ 4, 4, 1 ];

  var gotSegment = _.box.segmentClosestPoint( srcBox, tstSegment, dstPoint );
  test.identical( expected, gotSegment );
  test.is( dstPoint === gotSegment );

  test.case = 'dstPoint Vector'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSegment = [ 5, 5, 1, 10, 5, 1 ];
  var dstPoint = _.vector.from( [ 0, 0, 0 ] );
  var expected = _.vector.from( [ 4, 4, 1 ] );

  var gotSegment = _.box.segmentClosestPoint( srcBox, tstSegment, dstPoint );
  test.equivalent( expected, gotSegment );
  test.is( dstPoint === gotSegment );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.segmentClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.box.segmentClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.box.segmentClosestPoint( 'box', 'segment' ) );
  test.shouldThrowErrorSync( () => _.box.segmentClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.segmentClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.segmentClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.box.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], null ) );
  test.shouldThrowErrorSync( () => _.box.segmentClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 1, 2 ], undefined ) );

}

//

function sphereContains( test )
{

  test.case = 'Source box and test sphere remain unchanged'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var tstSphere = [ 1, 1, 2, 1 ];
  var expected = true;

  var gotBool = _.box.sphereContains( srcBox, tstSphere );
  test.identical( expected, gotBool );

  var oldSrcBox = [ 0, 0, 0, 3, 3, 3 ];
  test.identical( srcBox, oldSrcBox );

  var oldTstSphere = [ 1, 1, 2, 1 ];
  test.identical( tstSphere, oldTstSphere );

  test.case = 'Zero box to zero sphere'; /* */

  var srcBox = [ 0, 0, 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = true;

  var gotBool = _.box.sphereContains( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'box contains sphere in middle'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 2, 2, 2, 1 ];
  var expected = true;

  var gotBool = _.box.sphereContains( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere not in middle'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 1, 3, 2, 0.5 ];
  var expected = true;

  var gotBool = _.box.sphereContains( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere touches box borders'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 2, 2, 2, 2 ];
  var expected = true;

  var gotBool = _.box.sphereContains( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere not in middle touches box border'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 2, 3, 2, 1 ];
  var expected = true;

  var gotBool = _.box.sphereContains( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere bigger than box'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 2, 2, 2, 6 ];
  var expected = false;

  var gotBool = _.box.sphereContains( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere bigger than box just on one side'; /* */

  var srcBox = [ 0, 0, 1, 4, 4, 3 ];
  var tstSphere = [ 2, 2, 2, 2 ];
  var expected = false;

  var gotBool = _.box.sphereContains( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere out of box intersect'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 7, 7, 7, 5 ];
  var expected = false;

  var gotBool = _.box.sphereContains( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere out of box doesn´t intersect'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 7, 7, 7, 2 ];
  var expected = false;

  var gotBool = _.box.sphereContains( srcBox, tstSphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.sphereContains( ) );
  test.shouldThrowErrorSync( () => _.box.sphereContains( [] ) );
  test.shouldThrowErrorSync( () => _.box.sphereContains( [], [] ) );
  test.shouldThrowErrorSync( () => _.box.sphereContains( 'box', 'sphere' ) );
  test.shouldThrowErrorSync( () => _.box.sphereContains(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.sphereContains( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereContains( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereContains( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3 ] ) );

}

//

function sphereDistance( test )
{

  test.case = 'Source box and test sphere remain unchanged'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var tstSphere = [ 1, 1, 2, 1 ];
  var expected = 0;

  var gotBool = _.box.sphereDistance( srcBox, tstSphere );
  test.identical( expected, gotBool );

  var oldSrcBox = [ 0, 0, 0, 3, 3, 3 ];
  test.identical( srcBox, oldSrcBox );

  var oldTstSphere = [ 1, 1, 2, 1 ];
  test.identical( tstSphere, oldTstSphere );

  test.case = 'Zero box to zero sphere'; /* */

  var srcBox = [ 0, 0, 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.box.sphereDistance( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'box contains sphere in middle'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 2, 2, 2, 1 ];
  var expected = 0;

  var gotBool = _.box.sphereDistance( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere not in middle'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 1, 3, 2, 0.5 ];
  var expected = 0;

  var gotBool = _.box.sphereDistance( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere touches box borders'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 4, 4, 6, 2 ];
  var expected = 0;

  var gotBool = _.box.sphereDistance( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere bigger than box'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 2, 2, 2, 4 ];
  var expected = 0;

  var gotBool = _.box.sphereDistance( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere out of box intersect'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 7, 7, 7, 6 ];
  var expected = 0;

  var gotBool = _.box.sphereDistance( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere out of box don´t intersect'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 7, 7, 7, 2 ];
  var expected = Math.sqrt( 27 ) - 2;

  var gotBool = _.box.sphereDistance( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere under box'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ -7, -7, -7, 2 ];
  var expected = Math.sqrt( 147 ) - 2;

  var gotBool = _.box.sphereDistance( srcBox, tstSphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.sphereDistance( ) );
  test.shouldThrowErrorSync( () => _.box.sphereDistance( [] ) );
  test.shouldThrowErrorSync( () => _.box.sphereDistance( [], [] ) );
  test.shouldThrowErrorSync( () => _.box.sphereDistance( 'box', 'sphere' ) );
  test.shouldThrowErrorSync( () => _.box.sphereDistance(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.sphereDistance( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereDistance( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereDistance( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3 ] ) );

}

//

function sphereClosestPoint( test )
{

  test.case = 'Source box and test sphere remain unchanged'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var tstSphere = [ 1, 1, 2, 1 ];
  var expected = 0;

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( expected, gotBool );

  var oldSrcBox = [ 0, 0, 0, 3, 3, 3 ];
  test.identical( srcBox, oldSrcBox );

  var oldTstSphere = [ 1, 1, 2, 1 ];
  test.identical( tstSphere, oldTstSphere );

  test.case = 'Zero box to zero sphere'; /* */

  var srcBox = [ 0, 0, 0, 0, 0, 0 ];
  var tstSphere = [ 0, 0, 0, 0 ];
  var expected = 0;

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Zero box to point sphere'; /* */

  var srcBox = [ 0, 0, 0, 0, 0, 0 ];
  var tstSphere = [ 1, 2, 3, 0 ];
  var expected = [ 0, 0, 0 ];

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );


  test.case = 'box contains sphere in middle'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 2, 2, 2, 1 ];
  var expected = 0;

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere not in middle'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 1, 3, 2, 0.5 ];
  var expected = 0;

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere touches box borders'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 4, 4, 6, 2 ];
  var expected = 0;

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere bigger than box'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 2, 2, 2, 4 ];
  var expected = 0;

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere out of box intersect'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 7, 7, 7, 6 ];
  var expected = 0;

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere out of box don´t intersect'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 7, 7, 7, 2 ];
  var expected = [ 4, 4, 4 ];

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere under box'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ -7, -7, -7, 2 ];
  var expected = [ 0, 0, 0 ];

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere over box face'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 2, 2, 6, 1 ];
  var expected = [ 2, 2, 4 ];

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );

  test.case = 'Sphere next to box corner'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var tstSphere = [ 0, 6, 6, 1 ];
  var expected = [ 0, 4, 4 ];

  var gotBool = _.box.sphereClosestPoint( srcBox, tstSphere );
  test.identical( gotBool, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.sphereClosestPoint( ) );
  test.shouldThrowErrorSync( () => _.box.sphereClosestPoint( [] ) );
  test.shouldThrowErrorSync( () => _.box.sphereClosestPoint( [], [] ) );
  test.shouldThrowErrorSync( () => _.box.sphereClosestPoint( 'box', 'sphere' ) );
  test.shouldThrowErrorSync( () => _.box.sphereClosestPoint(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.sphereClosestPoint( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereClosestPoint( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereClosestPoint( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3 ] ) );

}

//

function sphereExpand( test )
{

  test.case = 'Source sphere remains unchanged'; /* */

  var dstBox = [ 0, 0, 0, 3, 3, 3 ];
  var srcSphere = [ 1, 1, 2, 1 ];
  var expected = [ 0, 0, 0, 3, 3, 3 ];

  var gotBox = _.box.sphereExpand( dstBox, srcSphere );
  test.identical( expected, gotBox );
  test.is( dstBox === gotBox );

  var oldSrcSphere = [ 1, 1, 2, 1 ];
  test.identical( srcSphere, oldSrcSphere );

  test.case = 'Zero box to zero sphere'; /* */

  var dstBox = [ 0, 0, 0, 0, 0, 0 ];
  var srcSphere = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0, 0, 0 ];

  var gotBox = _.box.sphereExpand( dstBox, srcSphere );
  test.identical( gotBox, expected );

  test.case = 'Sphere inside box'; /* */

  var dstBox = [ 0, 0, 0, 4, 4, 4 ];
  var srcSphere = [ 2, 2, 2, 1 ];
  var expected = [ 0, 0, 0, 4, 4, 4 ];

  var gotBox = _.box.sphereExpand( dstBox, srcSphere );
  test.identical( gotBox, expected );

  test.case = 'Point box and point Sphere'; /* */

  var dstBox = [ 0, 0, 0, 0, 0, 0 ];
  var srcSphere = [ 3, 3, 3, 0 ];
  var expected = [ 0, 0, 0, 3, 3, 3 ];

  var gotBox = _.box.sphereExpand( dstBox, srcSphere );
  test.identical( gotBox, expected );

  test.case = 'Box inside Sphere'; /* */

  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var srcSphere = [ 0, 0, 0, 3 ];
  var expected = [ -3, -3, -3, 3, 3, 3 ];

  var gotBox = _.box.sphereExpand( dstBox, srcSphere );
  test.identical( gotBox, expected );

  test.case = 'Sphere outside box'; /* */

  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var srcSphere = [ 5, 5, 5, 3 ];
  var expected = [ 0, 0, 0, 8, 8, 8 ];

  var gotBox = _.box.sphereExpand( dstBox, srcSphere );
  test.identical( gotBox, expected );

  test.case = 'dstBox vector'; /* */

  var dstBox = _.vector.from( [ 0, 0, 0, 1, 1, 1 ] );
  var srcSphere = [ 5, 5, 5, 3 ];
  var expected = _.vector.from( [ 0, 0, 0, 8, 8, 8 ] );

  var gotBox = _.box.sphereExpand( dstBox, srcSphere );
  test.identical( gotBox, expected );

  test.case = 'Sphere Intersects with box'; /* */

  var dstBox = [ 0, 0, 0, 2, 2, 2 ];
  var srcSphere = [ 3, 3, 3, 2 ];
  var expected = [ 0, 0, 0, 5, 5, 5 ];

  var gotBox = _.box.sphereExpand( dstBox, srcSphere );
  test.identical( gotBox, expected );

  test.case = 'Infinity Sphere'; /* */

  var dstBox = [ 0, 0, 0, 2, 2, 2 ];
  var srcSphere = [ 3, 3, 3, Infinity ];
  var expected = [ - Infinity, - Infinity, - Infinity, Infinity, Infinity, Infinity ];

  var gotBox = _.box.sphereExpand( dstBox, srcSphere );
  test.identical( gotBox, expected );

  test.case = 'sphere.Expand + sphere.Contains'; /* */

  var dstBox = [ 0, 0, 0, 1, 1, 1 ];
  var srcSphere = [ 5, 5, 5, 2 ];
  var expectedBool = false;
  var gotBool = _.box.sphereContains( dstBox, srcSphere );
  test.identical( gotBool, expectedBool );

  var expected = [ 0, 0, 0, 7, 7, 7 ];
  var gotBox = _.box.sphereExpand( dstBox, srcSphere );
  test.identical( gotBox, expected );

  var expectedBool = true;
  var gotBool = _.box.sphereContains( dstBox, srcSphere );
  test.identical( gotBool, expectedBool );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.sphereExpand( ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( [] ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( [], [] ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( 'box', 'sphere' ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand(  null, NaN ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( [ 0, 0, 0, 1, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( null, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.box.sphereExpand( [ 0, 1, 0, 1 ], [ 0, 0, 1 ] ) );

}

//

function boundingSphereGet( test )
{

  test.case = 'Source box remains unchanged'; /* */

  var srcBox = [ 0, 0, 0, 3, 3, 3 ];
  var dstSphere = [ 1, 1, 2, 1 ];
  var expected = [ 1.5, 1.5, 1.5, Math.sqrt( 6.75 ) ];

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( expected, gotSphere );
  test.is( dstSphere === gotSphere );

  var oldSrcBox = [ 0, 0, 0, 3, 3, 3 ];
  test.identical( srcBox, oldSrcBox );

  test.case = 'Zero box to zero sphere'; /* */

  var srcBox = [ 0, 0, 0, 0, 0, 0 ];
  var dstSphere = [ 0, 0, 0, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( gotSphere, expected );

  test.case = 'Sphere inside box - same center'; /* */

  var srcBox = [ 0, 0, 0, 4, 4, 4 ];
  var dstSphere = [ 2, 2, 2, 1 ];
  var expected = [ 2, 2, 2, Math.sqrt( 12 ) ];

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( gotSphere, expected );

  test.case = 'Point box and point Sphere'; /* */

  var srcBox = [ 0, 0, 0, 0, 0, 0 ];
  var dstSphere = [ 3, 3, 3, 0 ];
  var expected = [ 0, 0, 0, 0 ];

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( gotSphere, expected );

  test.case = 'Box inside Sphere'; /* */

  var srcBox = [ 0, 0, 0, 1, 1, 1 ];
  var dstSphere = [ 0, 0, 0, 3 ];
  var expected = [ 0.5, 0.5, 0.5, Math.sqrt( 0.75 ) ];

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( gotSphere, expected );

  test.case = 'Sphere outside box not squared'; /* */

  var srcBox = [ 1, 2, 3, 5, 8, 9 ];
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ 3, 5, 6, Math.sqrt( 22 ) ];

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( gotSphere, expected );

  test.case = 'srcBox vector'; /* */

  var srcBox = _.vector.from( [- 1, - 1, - 1, 1, 1, 1 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ 0, 0, 0, Math.sqrt( 3 )];

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere vector'; /* */

  var srcBox = [- 1, - 1, - 1, 3, 3, 1 ];
  var dstSphere = _.vector.from( [ 5, 5, 5, 3 ] );
  var expected = _.vector.from( [ 1, 1, 0, 3 ] );

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere null'; /* */

  var srcBox = [- 1, 5, - 1, 3, 7, 1 ];
  var dstSphere = null;
  var expected = [ 1, 6, 0, Math.sqrt( 6 ) ];

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( gotSphere, expected );

  test.case = 'dstSphere undefined'; /* */

  var srcBox = [- 1, - 3, - 5, 1, 0, 0 ];
  var dstSphere = undefined;
  var expected = [ 0, - 1.5, - 2.5, Math.sqrt( 9.5 ) ];

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( gotSphere, expected );

  test.case = 'srcBox inversed'; /* */

  var srcBox = _.vector.from( [ 4, 4, 4, 2, 2, 2 ] );
  var dstSphere = [ 5, 5, 5, 3 ];
  var expected = [ 3, 3, 3, Math.sqrt( 3 )];

  var gotSphere = _.box.boundingSphereGet( dstSphere, srcBox );
  test.identical( gotSphere, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( ) );
  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( [] ) );
  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( [], [] ) );
  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( 'box', 'sphere' ) );
  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( [ 0, 0, 0, 0, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( [ 0, 0, 0, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 2, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], [ 1, 0, 1, 2, 3, 4 ] ) );
  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( NaN, [ 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], null ) );
  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( [ 0, 1, 0, 1, 2, 1 ], NaN ) );
  test.shouldThrowErrorSync( () => _.box.boundingSphereGet( [ 0, 1, 0, 1 ], [ 0, 0, 1 ] ) );

}


// --
// declare
// --

var Self =
{

  name : 'Tools.Math.Box',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,
  // routine: 'frustumExpand',

  tests :
  {

    make : make,
    makeZero : makeZero,
    makeNil : makeNil,

    zero : zero,
    nil : nil,
    centeredOfSize : centeredOfSize,

    from : from,
    fromPoints : fromPoints,
    fromCenterAndSize : fromCenterAndSize,
    fromSphere : fromSphere,
    fromCube : fromCube,

    is : is,
    isEmpty : isEmpty,
    isZero : isZero,
    isNil : isNil,

    dimGet : dimGet,
    cornerLeftGet : cornerLeftGet,
    cornerRightGet : cornerRightGet,
    centerGet : centerGet,
    sizeGet : sizeGet,
    cornersGet : cornersGet,

    expand : expand,

    pointContains : pointContains,
    pointDistance : pointDistance,
    pointClosestPoint : pointClosestPoint,
    pointExpand : pointExpand,
    pointRelative : pointRelative,

    boxContains : boxContains,
    boxIntersects : boxIntersects,
    boxDistance : boxDistance,
    boxClosestPoint : boxClosestPoint,
    boxExpand : boxExpand,

    capsuleClosestPoint : capsuleClosestPoint,

    frustumContains : frustumContains,
    frustumDistance : frustumDistance,
    frustumClosestPoint : frustumClosestPoint,
    frustumExpand : frustumExpand,

    lineClosestPoint : lineClosestPoint,

    planeDistance : planeDistance,
    planeClosestPoint : planeClosestPoint,
    planeExpand : planeExpand,

    rayClosestPoint : rayClosestPoint,

    segmentClosestPoint : segmentClosestPoint,

    sphereContains : sphereContains,
    sphereDistance : sphereDistance,
    sphereClosestPoint : sphereClosestPoint,
    sphereExpand : sphereExpand,
    boundingSphereGet : boundingSphereGet,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
