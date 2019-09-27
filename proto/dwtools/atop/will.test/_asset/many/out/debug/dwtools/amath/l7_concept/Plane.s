(function _Plane_s_() {

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.plane = _.plane || Object.create( null );

/**
 * @description
 * A plane is a flat surface represented by an equation of the type:
 *   Ax + By + Cz = D ( for 3D, where x, y and z represent the 3 axes )
 *
 * For the following functions, planes must have the shape [ A, B,... , D ],
 * where the dimension equals the object´s length minus one.
 * @namespace "wTools.plane"
 * @memberof module:Tools/math/Concepts 
 */

/*

  A plane is a flat surface represented by an equation of the type:
    Ax + By + Cz = D ( for 3D, where x, y and z represent the 3 axes )

  For the following functions, planes must have the shape [ A, B,... , D ],
  where the dimension equals the object´s length minus one.

*/
// --
//
// --

function make( dim )
{
  if( dim === undefined )
  dim = 3;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.numberIs( dim ) );
  let dst = _.dup( 0,dim+1 );
  return dst;
}

//

function _from( plane )
{
  _.assert( _.plane.is( plane ) );
  _.assert( _.vectorIs( plane ) || _.longIs( plane ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return _.vector.from( plane );
}

//

function is( plane )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( plane ) || _.vectorIs( plane ) ) && plane.length >= 1;
}

//


/**
  * Create a plane from another plane or a normal and a bias. Returns the new plane.
  * Planes are stored in Array data structure. Source plane/Normal and bias stay untouched, dst plane changes.
  *
  * @param { Array } dstplane - Destination plane to be expanded.
  * @param { Array } srcplane - Source plane.
  * Alternative to srcplane:
  * @param { Array } normal - Array of points with normal vector coordinates.
  * @param { Number } bias - Number with bias value.
  *
  * @example
  * // returns [ 0, 0, 1, 2 ];
  * _.from( [ 0, 0, 0, 0 ] , [ 0, 0, 1, 2 ] );
  *
  * @example
  * // returns [ 0, - 1, 2, 2 ];
  * _.from( [ 0, 0, 1, 1 ], [ 0, - 1, 2 ], 2 );
  *
  * @returns { Array } Returns the array of the new plane.
  * @function from
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( normal ) is not array.
  * @throws { Error } An Error if ( bias ) is not number.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function from( plane )
{

  if( plane === null )
  plane = _.plane.make();

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  debugger;
  // throw _.err( 'not tested' );

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  if( arguments.length === 2 )
  {
    debugger;
  //  throw _.err( 'not tested' );
    _.avector.assign( planeView,arguments[ 1 ] )
  }
  else if( arguments.length === 3 )
  {
    debugger;
  //  throw _.err( 'not tested' );
    _.avector.assign( normal,vector.from( arguments[ 1 ] ) );
    _.plane.biasSet( planeView,arguments[ 2 ] );
  }
  else _.assert( 0,'unexpected arguments' );

  return plane;
}

//

/**
  * Create a plane from a normal and a point. Returns the new plane.
  * Planes are stored in Array data structure. Normal and point stay untouched, plane changes.
  *
  * @param { Array } plane - Plane to be modified.
  * @param { Array } anormal - Array of points with normal vector coordinates.
  * @param { Array } abias - Array with point coordinates.
  *
  * @example
  * // returns [ 0, 0, 1, 2 ];
  * _.fromNormalAndPoint( [ 0, 0, 0, 0 ] , [ 0, 0, 1 ], [ 2, 0, 0 ] );
  *
  * @returns { Array } Returns the array of the new plane.
  * @function fromNormalAndPoint
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( anormal ) is not array.
  * @throws { Error } An Error if ( apoint ) is not a point.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function fromNormalAndPoint( plane, anormal, apoint )
{

  if( plane === null )
  plane = _.plane.make();

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  debugger;
  //throw _.err( 'not tested' );

  debugger;
  normal.copy( anormal );
  _.plane.biasSet( plane , - _.vector.dot( _.vector.from( apoint ) , normal ) );

  return plane;
}

//

/**
  * Create a plane from three points. Returns the new plane.
  * Planes are stored in Array data structure. The points remain untouched, plane changes.
  *
  * @param { Array } plane - Plane to be modified.
  * @param { Array } a - First point in the new plane.
  * @param { Array } b - Second point in the new plane.
  * @param { Array } c - Third point in the new plane.
  *
  * @example
  * // returns [ 0, 1, 0, 0 ];
  * _.fromPoints( [ 0, 0, 0 ] , [ 0, 0, 1 ], [ 2, 0, 0 ] );
  *
  * @returns { Array } Returns the array of the new plane.
  * @function fromPoints
  * @throws { Error } An Error if ( arguments.length ) is different than four.
  * @throws { Error } An Error if ( dim ) point dimension is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( a ) is not a point.
  * @throws { Error } An Error if ( b ) is not a point.
  * @throws { Error } An Error if ( c ) is not a point.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function fromPoints( plane,a,b,c )
{

  if( plane === null )
  plane = _.plane.make();

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  _.assert( arguments.length === 4 );
  debugger;
  //throw _.err( 'not tested' );

  a = _.vector.from( a );
  b = _.vector.from( b );
  c = _.vector.from( c );

  let n1 = vector.subVectors( a.clone() , b );
  let n2 = vector.subVectors( c.clone() , b );
  normal = vector.cross( n1,n2 );
  debugger;
  normal.normalize();

  _.plane.fromNormalAndPoint( plane, normal, a );

  return plane;
}

//

function dimGet( plane )
{
  let dim = plane.length - 1;

  _.assert( _.plane.is( plane ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  debugger;

  return dim;
}

//

function normalGet( plane )
{
  let planeView = _.plane._from( plane );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return planeView.subarray( 0,planeView.length-1 );
}

//

function biasGet( plane )
{
  let planeView = _.plane._from( plane );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return planeView.eGet( planeView.length-1 );
}

//

function biasSet( plane,bias )
{
  let planeView = _.plane._from( plane );

  _.assert( _.numberIs( bias ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  //throw _.err( 'not tested' );

  return planeView.eSet( planeView.length-1,bias );
}

//

/**
  * Check if a plane contains a point. Returns true if the point is contained.
  * The point an the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Vector } point - Source point.
  *
  * @example
  * // returns false;
  * _.pointsDistance( [ 0, 1, 0, 1 ] , _.vector.from( [ 0, 0, 1 ] ) );
  *
  * @returns { Boolean } Returns true if the plane contains the point and false if not.
  * @function pointContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( point ) is not a vector.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */

function pointContains( plane , point )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = _.plane._from( plane );
  let pointVector = _.vector.from( point );

  if( Math.abs( _.plane.pointDistance( plane, pointVector ) ) < 1E-12 )
  return true;
  else
  return false;
}

//

/**
  * Get the distance between a point and a plane. Returns the distance value.
  * The point an the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Vector } point - Source point.
  *
  * @example
  * // returns 1;
  * _.pointsDistance( [ 0, 1, 0, 1 ] , _.vector.from( [ 0, 0, 1 ] ) );
  *
  * @returns { Number } Returns the distance from the point to the plane.
  * @function pointDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( point ) is not a vector.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function pointDistance( plane , point )
{

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let pointVector = _.vector.from( point );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let mod = _.vector.dot( normal, normal );
  mod = Math.sqrt( mod );

  let distance = ( _.vector.dot( normal , pointVector ) + bias ) / mod ;

  // distance = Math.abs( distance );

  return distance;

}

//

/**
  * Get the proyection of a point in a plane. Returns the new point coordinates.
  * The plane remains unchanged, the point changes.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } point - Source and destination point.
  *
  * @example
  * // returns [ - 1, 2, 2 ];
  * _.pointCoplanarGet( [ 1, 0, 0, 1 ] , [ 2, 2, 2 ]);
  *
  * @returns { Array } Returns the new point in the plane.
  * @function pointCoplanarGet
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( point ) is not point.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function pointCoplanarGet( plane , point, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( point.length );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = _.vector.from( dstPoint );
  let pointVector = _.vector.from( point.slice() );
  let planeView = _.plane._from( plane.slice() );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  _.assert( plane.length - 1 === point.length , 'Plane and point have different dimensions' );
  _.assert( dstPoint.length === point.length , 'Source and test points have different dimensions' );

  let lambda = - (( _.vector.dot( normal , pointVector ) + bias ) / _.vector.dot( normal, normal ) ) ;

  debugger;
  //throw _.err( 'not tested' );

  let movement = _.vector.mulScalar( normal, lambda );

  pointVector = _.vector.add( pointVector ,  movement  );

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointView.eSet( i, pointVector.eGet( i ) );
  }
  return dstPoint;
}

// function pointCoplanarGet( plane , point )
// {

//  if( !point )
//  point = [ 0,0,0 ];

//  let pointVector = _.vector.from( point );
//  let planeView = _.plane._from( plane );
//  let normal = _.plane.normalGet( planeView );
//  let bias = _.plane.biasGet( planeView );

//  _.assert( arguments.length === 1 || arguments.length === 2 );
//  debugger;
//  throw _.err( 'not tested' );

//  _.avector.assign( pointVector , normal  );
//  _.avector.mulScalar( pointVector, -bias );

//  return point
//  }

//

/**
  * Check if a plane and a box intersect. Returns true if they intersect and false if not.
  * The box and the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns true;
  * _.boxIntersects( [ 1, 0, 0, 1 ] , [ -1, 2, 2, -1, 2, 8 ]);
  *
  * @example
  * // returns false;
  * _.boxIntersects( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Boolean } Returns true if the plane and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the plane and box don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function boxIntersects( plane , srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let bool = false;
  let planeView = _.plane._from( plane );
  let dimP = _.plane.dimGet( planeView );
  let boxView = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxView );
  let min = _.box.cornerLeftGet( boxView );
  let max = _.box.cornerRightGet( boxView );

  _.assert( dimP === dimB );

  /* box corners */
  let c =  _.box.cornersGet( boxView );

  min = _.vector.from( min );
  let distance = _.plane.pointDistance( plane, min );
  if( distance === 0 )
  {
    bool = true;
  }
  else
  {
    let side = distance/ Math.abs( distance );
    for( let j = 1 ; j < _.Space.dimsOf( c )[ 1 ] ; j++ )
    {
      let corner = c.colVectorGet( j );
      distance = _.plane.pointDistance( plane, corner );
      if( distance === 0 )
      {
        bool = true;
      }
      else
      {
        let newSide = distance/ Math.abs( distance );
        if( side === - newSide )
        {
          bool = true;
        }
        side = newSide;
      }
    }
  }
  return bool;
}

//

/**
  * Get the distance between a plane and a box. Returns the calculated distance.
  * The box and the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns 0;
  * _.boxDistance( [ 1, 0, 0, 1 ] , [ -1, 2, 2, -1, 2, 8 ]);
  *
  * @example
  * // returns 3;
  * _.boxDistance( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the distance between the plane and the box.
  * @function boxDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the plane and box don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function boxDistance( plane , srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = _.plane._from( plane );
  let boxView = _.box._from( srcBox );

  let distance = _.box.planeDistance( boxView, planeView );

  return distance;
}

//

/**
  * Get the closest point in a plane to a box. Returns the calculated point.
  * The box and the plane remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } srcBox - Source box.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 2, 2, 2 ];
  * _.boxClosestPoint( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Array } Returns the closest point in the plane to the box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the plane and box don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function boxClosestPoint( srcPlane , srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = _.vector.from( dstPoint );

  let planeView = _.plane._from( srcPlane );
  let dimP = _.plane.dimGet( planeView );

  let boxView = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxView );
  let min = _.box.cornerLeftGet( boxView );
  let max = _.box.cornerRightGet( boxView );

  _.assert( dimP === dimB );
  _.assert( dimP === dstPointView.length );

  if( _.plane.boxIntersects( planeView, boxView ) )
  return 0;

  let boxPoint = _.box.planeClosestPoint( boxView, planeView );

  let planePoint = _.plane.pointCoplanarGet( planeView, boxPoint );

  for( let i = 0; i < planePoint.length; i++ )
  {
    dstPointView.eSet( i, planePoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Get the bounding box of a plane. Returns destination box.
  * Plane and box are stored in Array data structure. Source plane stays untouched.
  *
  * @param { Array } dstBox - destination box.
  * @param { Array } srcPlane - source plane for the bounding box.
  *
  * @example
  * // returns [ 0, -Infinity, - Infinity, 0, Infinity, Infinity ]
  * _.boundingBoxGet( null, [ 1, 0, 0, 0 ] );
  *
  * @returns { Array } Returns the array of the bounding box.
  * @function boundingBoxGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(plane) (the plane and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcPlane ) is not plane
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function boundingBoxGet( dstBox, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcPlaneView = _.plane._from( srcPlane );
  let normal = _.plane.normalGet( srcPlaneView );
  let bias = _.plane.biasGet( srcPlaneView );
  let dimPlane  = _.plane.dimGet( srcPlaneView )

  if( dstBox === null || dstBox === undefined )
  dstBox = _.box.makeNil( dimPlane );

  _.assert( _.box.is( dstBox ) );
  let boxView = _.box._from( dstBox );
  let dimB = _.box.dimGet( boxView );

  _.assert( dimPlane === dimB );

  let zeros = 0;
  for( let i = 0; i < dimB; i++ )
  {
    if( normal.eGet( i ) === 0 )
    {
      zeros = zeros + 1;
    }
  }
  logger.log( zeros )

  if( zeros === dimB - 1 )
  {
    for( let i = 0; i < dimB; i++ )
    {
      if(  normal.eGet( i ) !== 0  )
      {
        boxView.eSet( i, - bias / normal.eGet( i ) );
        boxView.eSet( i + dimB, - bias / normal.eGet( i ) );
      }
      else
      {
        boxView.eSet( i, - Infinity );
        boxView.eSet( i + dimB, Infinity );
      }
    }

  }
  else
  {
    for( let i = 0; i < dimB; i++ )
    {
      boxView.eSet( i, - Infinity );
      boxView.eSet( i + dimB, Infinity );
    }
  }

  return dstBox;
}

//

function capsuleIntersects( srcPlane , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = _.capsule._from( tstCapsule );
  let planeView = _.plane._from( srcPlane );

  let gotBool = _.capsule.planeIntersects( tstCapsuleView, planeView );
  return gotBool;
}

//

function capsuleDistance( srcPlane , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = _.capsule._from( tstCapsule );
  let planeView = _.plane._from( srcPlane );

  let gotDist = _.capsule.planeDistance( tstCapsuleView, planeView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a plane to a capsule. Returns the calculated point.
  * Plane and capsule remain unchanged
  *
  * @param { Array } plane - The source plane.
  * @param { Array } capsule - The source capsule.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let capsule = [ 0, 0, 0, - 1, - 1, - 1, 1 ]
  * _.capsuleClosestPoint( [ 1, 0, 0, 0 ], capsule );
  *
  * @example
  * // returns [ 3, 0, 0 ]
  * _.capsuleClosestPoint( [ 1, 0, 0, - 3 ], capsule );
  *
  * @returns { Array } Returns the closest point to the capsule.
  * @function capsuleClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane
  * @throws { Error } An Error if ( capsule ) is not capsule
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function capsuleClosestPoint( plane, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = _.plane._from( plane );
  let dimPlane = _.plane.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimPlane );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let capsuleView = _.capsule._from( capsule );
  let dimCapsule  = _.capsule.dimGet( capsuleView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimPlane === dstPoint.length );
  _.assert( dimPlane === dimCapsule );

  if( _.capsule.planeIntersects( capsuleView, planeView ) )
  return 0
  else
  {
    let capsulePoint = _.capsule.planeClosestPoint( capsule, planeView );

    let planePoint = _.vector.from( _.plane.pointCoplanarGet( planeView, capsulePoint ) );

    for( let i = 0; i < dimPlane; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a plane and a frustum intersect. Returns true if they intersect.
  * The plane and the frustum remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns false;
  * let srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumIntersects( [ 0, 1, 0, 1 ] , srcFrustum );
  *
  * @returns { Boolean } Returns true if the plane and the frustum intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the plane and frustum don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function frustumIntersects( srcPlane, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );
  let srcPlaneView = _.plane._from( srcPlane );

  let gotBool = _.frustum.planeIntersects( srcFrustum, srcPlaneView );

  return gotBool;
}

//

/**
  * Get the distance between a plane and a frustum. Returns the calculated distance.
  * The plane and the frustum remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 1;
  * let srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumDistance( [ 0, 1, 0, 1 ] , srcFrustum );
  *
  * @returns { Array } Returns the distance between the plane and the frustum.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the plane and frustum don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function frustumDistance( srcPlane , srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );
  let srcPlaneView = _.plane._from( srcPlane );

  let distance = _.frustum.planeDistance( srcFrustum, srcPlaneView );
  return distance;
}

//

/**
  * Get the closest point in a plane to a frustum. Returns the calculated point.
  * The plane and the frustum remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } srcFrustum - Source frustum.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 0, 1, 1 ];
  * let srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumClosestPoint( [ 0, 1, 0, 1 ] , srcFrustum );
  *
  * @returns { Array } Returns the closest point in the plane to the frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the plane and frustum don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function frustumClosestPoint( srcPlane , srcFrustum, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = _.vector.from( dstPoint );

  let planeView = _.plane._from( srcPlane );
  let dimP = _.plane.dimGet( planeView );
  _.assert( dimP === dstPointView.length );

  let dimF = _.Space.dimsOf( srcFrustum ) ;
  let rows = dimF[ 0 ];
  let cols = dimF[ 1 ];
  _.assert( dimP === rows - 1 );

  if( _.frustum.planeIntersects( srcFrustum, planeView ) )
  return 0;

  let frustumPoint = _.frustum.planeClosestPoint( srcFrustum, planeView );

  let planePoint = _.plane.pointCoplanarGet( planeView, frustumPoint );

  for( let i = 0; i < planePoint.length; i++ )
  {
    dstPointView.eSet( i, planePoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Check if a plane and a line intersect. Returns true if they intersect.
  * The plane and line remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } line -  First and last points in line.
  *
  * @example
  * // returns true
  * _.lineIntersects( [ 1, 0, 0, 1 ] , [ - 2, - 2, - 2, 3, 3, 3 ]);
  *
  * @example
  * // returns false
  * _.lineIntersects( [ 1, 0, 0, 1 ] , [ 2, 2, 2, 3, 3, 3 ]);
  *
  * @returns { Boolean } Returns true if the line and plane intersect, false if not.
  * @function lineIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( line ) is not line.
  * @memberof module:Tools/math/Concepts.wTools.plane
*/
function lineIntersects( srcPlane , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstLineView = _.line._from( tstLine );
  let planeView = _.plane._from( srcPlane );

  let gotBool = _.line.planeIntersects( tstLineView, planeView );

  return gotBool;
}

//

/**
  * Returns the intersection point between a plane and a line. Returns the intersection point coordinates.
  * The plane and line remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } line -  First and last points in line.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.lineIntersection( [ 1, 0, 0, 0 ] , [ - 2, - 2, - 2 ], [ 3, 3, 3 ]);
  *
  *
  * @returns { Point } Returns the point of intersection between a plane and a line.
  * @function lineIntersection
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( line ) is not line.
  * @throws { Error } An Error if ( point ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function lineIntersection( plane , line , point )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );


  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let lineView = _.vector.from( line );

  debugger;
  throw _.err( 'not tested' );

  if( point === null )
  point = [ 0,0,0 ];

  let direction = _.line.pointDirection( point );

  let dot = _.vector.dot( normal , direction );

  if( Math.abs( dot ) < _.accuracySqr )
  {

    if( _.plane.pointDistance( plane, lineView.eGet( 0 ) ) < _.accuracySqr )
    {
      _.avector.assign( point, lineView.eGet( 0 ) );
      return point
    }

    return false;
  }

  let t = - ( _.vector.dot( lineView.eGet( 0 ) , this.normal ) + bias ) / dot;

  if( t < 0 || t > 1 )
  return false;

  return _.line.at( [ lineView.eGet( 0 ),direction ] , t );
}

//

function lineDistance( srcPlane , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstLineView = _.line._from( tstLine );
  let planeView = _.plane._from( srcPlane );

  let gotDist = _.line.planeDistance( tstLineView, planeView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a plane to a line. Returns the calculated point.
  * Plane and line remain unchanged
  *
  * @param { Array } plane - The source plane.
  * @param { Array } line - The source line.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  *  plane = [ 0, 0, 1, 2 ];
  *  line = [ 0, 0, 0, 0, 0, - 1 ];
  * _.lineClosestPoint( plane, line );
  *
  * @example
  * // returns [ 0, 0, - 2 ]
  *  plane = [ 0, 0, 1, 2 ];
  *  line = [ 0, 0, 0, 0, - 1, 0 ];
  * _.lineClosestPoint( plane, line );
  *
  * @returns { Array } Returns the closest point to the line.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane
  * @throws { Error } An Error if ( line ) is not line
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function lineClosestPoint( plane, line, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = _.plane._from( plane );
  let dimP = _.plane.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimP );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let lineView = _.line._from( line );
  let origin = _.line.originGet( lineView );
  let direction = _.line.directionGet( lineView );
  let dimLine  = _.line.dimGet( lineView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimP === dstPoint.length );
  _.assert( dimP === dimLine );

  if( _.line.planeIntersects( lineView, planeView ) )
  return 0
  else
  {
    let linePoint = _.line.planeClosestPoint( line, planeView );

    let planePoint = _.vector.from( _.plane.pointCoplanarGet( planeView, linePoint ) );

    for( let i = 0; i < dimP; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if two planes intersect. Returns true if they intersect.
  * The planes remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } tstPlane - Test plane.
  *
  * @example
  * // returns true;
  * _.planeIntersects( [ 1, 0, 0, 0 ] , [ 3, 2, 0, 1 ]);
  *
  * @returns { Boolean } Returns true if the planes intersect, false if not.
  * @function planeIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( tstPlane ) is not plane.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function planeIntersects( srcPlane, tstPlane )
{
  let srcPlaneView = _.plane._from( srcPlane.slice() );
  let srcNormal = _.plane.normalGet( srcPlaneView );
  let srcBias = _.plane.biasGet( srcPlaneView );

  let dstPlaneView = _.plane._from( tstPlane.slice() );
  let tstNormal = _.plane.normalGet( dstPlaneView );
  let tstBias = _.plane.biasGet( dstPlaneView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  //throw _.err( 'not tested' );

  let factor = srcNormal.eGet( 0 ) / tstNormal.eGet( 0 );
  srcNormal.normalize();
  tstNormal.normalize();

  for( let i = 0; i < srcNormal.length ; i++ )
  {
    if( Math.abs( tstNormal.eGet( i ) - srcNormal.eGet( i ) ) > 1E-7 )
    return true;
  }

  if( Math.abs( tstBias*factor - srcBias ) < 1E-7 )
  return true;

  return false;
}

//

/**
  * Calculates the distance between two planes. Returns the calculated distance.
  * The planes remain unchanged.
  *
  * @param { Array } srcPlane - Source plane.
  * @param { Array } tstPlane - Test plane.
  *
  * @example
  * // returns 0;
  * _.planeDistance( [ 1, 0, 0, 0 ] , [ 3, 2, 0, 1 ]);
  *
  * @returns { Number } Returns the distance between the two planes.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( tstPlane ) is not plane.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function planeDistance( srcPlane, tstPlane )
{
  let srcPlaneView = _.plane._from( srcPlane );
  let srcNormal = _.plane.normalGet( srcPlaneView );
  let srcBias = _.plane.biasGet( srcPlaneView );

  let dstPlaneView = _.plane._from( tstPlane );
  let tstNormal = _.plane.normalGet( dstPlaneView );
  let tstBias = _.plane.biasGet( dstPlaneView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcPlaneView.length === dstPlaneView.length, 'Planes must have same dimension' );

  debugger;
  //throw _.err( 'not tested' );

  if( _.plane.planeIntersects( srcPlaneView, dstPlaneView ) === true )
  return 0;

  let factor = srcNormal.eGet( 0 ) / tstNormal.eGet( 0 );
  dstPlaneView.mulScalar( factor )

  let a2 =  srcNormal.eGet( 0 ) * srcNormal.eGet( 0 );
  let b2 =  srcNormal.eGet( 1 ) * srcNormal.eGet( 1 );
  let c2 =  srcNormal.eGet( 2 ) * srcNormal.eGet( 2 );
  let module = Math.sqrt( a2 + b2 + c2 );

  let distance = Math.abs( tstBias*factor - srcBias ) / module;
  return distance;
}

//

function rayIntersects( srcPlane , tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = _.plane._from( srcPlane );
  let tstRayView = _.ray._from( tstRay );

  let gotBool = _.ray.planeIntersects( tstRayView, planeView );

  return gotBool;
}

//

function rayDistance( srcPlane , tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = _.plane._from( srcPlane );
  let tstRayView = _.ray._from( tstRay );

  let gotDist = _.ray.planeDistance( tstRayView, planeView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a plane to a ray. Returns the calculated point.
  * Plane and ray remain unchanged
  *
  * @param { Array } plane - The source plane.
  * @param { Array } ray - The source ray.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0.5
  * let ray = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.rayClosestPoint( [ 1, 0, 0, -0.5 ], ray );
  *
  * @example
  * // returns 0
  * _.rayClosestPoint( [ 1, 0, 0, 2 ], ray );
  *
  * @returns { Array } Returns the closest point to the ray.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane
  * @throws { Error } An Error if ( ray ) is not ray
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function rayClosestPoint( plane, ray, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = _.plane._from( plane );
  let dimP = _.plane.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimP );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let rayView = _.ray._from( ray );
  let origin = _.ray.originGet( rayView );
  let direction = _.ray.directionGet( rayView );
  let dimRay  = _.ray.dimGet( rayView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimP === dstPoint.length );
  _.assert( dimP === dimRay );

  if( _.ray.planeIntersects( rayView, planeView ) )
  return 0
  else
  {
    let rayPoint = _.ray.planeClosestPoint( ray, planeView );

    let planePoint = _.vector.from( _.plane.pointCoplanarGet( planeView, rayPoint ) );

    for( let i = 0; i < dimP; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
* Check if a plane and a segment intersect. Returns true if they intersect.
* The plane and segment remain unchanged.
*
* @param { Array } plane - Source plane.
* @param { Array } segment -  First and last points in segment.
*
* @example
* // returns true
* _.segmentIntersects( [ 1, 0, 0, 1 ] , [ - 2, - 2, - 2, 3, 3, 3 ]);
*
* @example
* // returns false
* _.segmentIntersects( [ 1, 0, 0, 1 ] , [  2, 2, 2, 3, 3, 3 ]);
*
* @returns { Boolean } Returns true if the segment and plane intersect, false if not.
* @function segmentIntersects
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( plane ) is not plane.
* @throws { Error } An Error if ( segment ) is not segment.
* @memberof module:Tools/math/Concepts.wTools.plane
*/
function segmentIntersects( plane , segment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  let segmentView = _.segment._from( segment );
  let origin = _.segment.originGet( segmentView );
  let end = _.segment.endPointGet( segmentView );

  debugger;
  //throw _.err( 'not tested' );

  let b = _.plane.pointDistance( planeView, origin );
  let e = _.plane.pointDistance( planeView, end );

  debugger;
  return ( b <= 0 && e >= 0 ) || ( e <= 0 && b >= 0 );
}

//

function segmentDistance( srcPlane , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = _.segment._from( tstSegment );
  let planeView = _.plane._from( srcPlane );

  let gotDist = _.segment.planeDistance( tstSegmentView, planeView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a plane to a segment. Returns the calculated point.
  * Plane and segment remain unchanged
  *
  * @param { Array } plane - The source plane.
  * @param { Array } segment - The source segment.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  *  plane = [ 0, 0, 1, 2 ];
  *  segment = [ 0, 0, 0, 0, 0, - 1 ];
  * _.segmentClosestPoint( plane, segment );
  *
  * @example
  * // returns [ 0, 0, - 2 ]
  *  plane = [ 0, 0, 1, 2 ];
  *  segment = [ 0, 0, 0, 0, - 1, 0 ];
  * _.segmentClosestPoint( plane, segment );
  *
  * @returns { Array } Returns the closest point to the segment.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( plane ) is not plane
  * @throws { Error } An Error if ( segment ) is not segment
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function segmentClosestPoint( plane, segment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let planeView = _.plane._from( plane );
  let dimP = _.plane.dimGet( planeView );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimP );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let segmentView = _.segment._from( segment );
  let origin = _.segment.originGet( segmentView );
  let direction = _.segment.directionGet( segmentView );
  let dimSegment  = _.segment.dimGet( segmentView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimP === dstPoint.length );
  _.assert( dimP === dimSegment );

  if( _.segment.planeIntersects( segmentView, planeView ) )
  return 0
  else
  {
    let segmentPoint = _.segment.planeClosestPoint( segment, planeView );
    let planePoint = _.vector.from( _.plane.pointCoplanarGet( planeView, segmentPoint ) );

    for( let i = 0; i < dimP; i++ )
    {
      dstPointView.eSet( i, planePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Check if a plane and a sphere intersect. Returns true if they intersect and false if not.
  * The sphere and the plane remain unchanged.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.sphereIntersects( [ 1, 0, 0, 1 ] , [ 2, 2, 2, 8 ]);
  *
  * @example
  * // returns false;
  * _.sphereIntersects( [ 0, 1, 0, 1 ] , [ 2, 2, 2, 2 ]);
  *
  * @returns { Boolean } Returns true if the plane and the sphere intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function sphereIntersects( plane , sphere )
{
  let bool = false;
  let planeView = _.plane._from( plane );
  _.assert( _.sphere.is( sphere ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  debugger;

  let distance = _.plane.sphereDistance( plane, sphere );

  if( distance <= 0 )
  {
    bool = true;
  }

  return bool;
}

//

/**
  * Get the distance between a plane and a sphere. Returns the distance value.
  * The sphere an the plane remain unchanged.
  * If sphere and plane intersect, it returns 0.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns 1;
  * _.sphereDistance( [ 0, 1, 0, 1 ] , [ 0, 0, 2, 1 ]);
  *
  * @returns { Number } Returns the distance from the sphere to the plane.
  * @function sphereDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function sphereDistance( plane , sphere )
{

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  let center = _.sphere.centerGet( sphere );
  center = _.vector.from( center );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  //throw _.err( 'not tested' );

  let d = _.plane.pointDistance( plane , center );
  d = Math.abs( d ) - _.sphere.radiusGet( sphere );

  if( d < 0 )
  return 0;
  else
  return d;

}

//

/**
  * Get the closest point in a plane to a sphere. Returns the calculated point.
  * The sphere an the plane remain unchanged.
  * If sphere and plane intersect, it returns 0.
  *
  * @param { Array } plane - Source plane.
  * @param { Array } sphere - Source sphere.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns [ 0, 2, 0 ];
  * _.sphereClosestPoint( [ 1, 0, 0, 0 ] , [ 3, 2, 0, 1 ]);
  *
  * @returns { Array } Returns the distance from the sphere to the plane.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function sphereClosestPoint( plane , sphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  let dstPointView = _.vector.from( dstPoint );

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  _.assert( planeView.length - 1 === dstPoint.length , 'Plane and point must have same dimension' );

  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );

  if( _.plane.sphereIntersects( planeView, sphereView ) === true )
  return 0;

  let point = _.plane.pointCoplanarGet( planeView, center );

  for( let i = 0; i < point.length; i++ )
  {
    dstPointView.eSet( i, point[ i ] );
  }

  return dstPoint;
}

//

/**
  * Get the bounding sphere of a plane. Returns the destination sphere.
  * Plane and sphere are stored in Array data structure. Source plane stays untouched.
  *
  * @param { Array } dstSphere - destination sphere.
  * @param { Array } srcPlane - source plane for the bounding sphere.
  *
  * @example
  * // returns [ 0, 2, 0, Infinity ]
  * _.boundingSphereGet( null, [ 0, 1, 0, - 2 ] );
  *
  * @returns { Array } Returns the array of the bounding sphere.
  * @function boundingSphereGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(plane) (the plane and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstSphere ) is not sphere
  * @throws { Error } An Error if ( srcPlane ) is not plane
  * @memberof module:Tools/math/Concepts.wTools.plane
  */
function boundingSphereGet( dstSphere, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let planeView = _.plane._from( srcPlane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let dimPlane = _.plane.dimGet( planeView )

  if( dstSphere === null || dstSphere === undefined )
  dstSphere = _.sphere.makeZero( dimPlane );

  _.assert( _.sphere.is( dstSphere ) );
  let dstSphereView = _.sphere._from( dstSphere );
  let center = _.sphere.centerGet( dstSphereView );
  let radiusSphere = _.sphere.radiusGet( dstSphereView );
  let dimSphere = _.sphere.dimGet( dstSphereView );
  logger.log( dimPlane, dimSphere )
  _.assert( dimPlane === dimSphere );

  let distOrigin = _.vector.distance( _.vector.from( _.array.makeArrayOfLengthZeroed( dimPlane ) ), normal );

  // Center of the sphere
  if( distOrigin === 0 )
  {
    for( let c = 0; c < center.length; c++ )
    {
      center.eSet( c, 0 );
    }
  }
  else
  {
    let pointInPlane = _.vector.from( _.plane.pointCoplanarGet( planeView, _.array.makeArrayOfLengthZeroed( dimPlane ) ) );
    logger.log( pointInPlane )

    for( let c = 0; c < center.length; c++ )
    {
      center.eSet( c, pointInPlane.eGet( c ) );
    }
  }

  // Radius of the sphere
  _.sphere.radiusSet( dstSphereView, Infinity );

  return dstSphere;
}

//

function matrixHomogenousApply( plane , matrix )
{

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  throw _.err( 'not tested' );

  normal = normal.clone();

  /* let m = m1.normalProjectionMatrixGet( matrix ); */

  if( matrix.ncol === 4 )
  matrix = matrix.normalProjectionMatrixMake();

  normal = _.space.mul( matrix,normal );

  let point = _.plane.pointCoplanarGet( plane );
  matrix.matrixHomogenousApply( point );

  return _.plane.fromNormalAndPoint( plane , normal , point );
}

//

/**
  * Translates a plane by a given offset. Returns the new plane coordinates.
  * The offset remains unchanged, the plane changes.
  *
  * @param { Array } plane - Source and destination plane.
  * @param { Array } offset -  Offset to translate the plane.
  *
  * @example
  * // returns [ 1, 0, 0, 1 ];
  * _.translate( [ 1, 0, 0, 1 ] , [ 0, 2, 0 ] );
  *
  * @example
  * // returns [ 1, 0, 0, - 1 ]
  * _.translate( [ 1, 0, 0, 1 ] ,  [  2, 2, 2 ] );
  *
  * @returns { Boolean } Returns the translated plane.
  * @function translate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @throws { Error } An Error if ( offset ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */

function translate( plane , offset )
{

  let _offset = _.vector.from( offset );
  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  //  throw _.err( 'not tested' );

  _.plane.biasSet( plane, bias - _.vector.dot( normal,_offset ) )

  return plane;
}

//

/**
  * Normalize a plane coordinates. Returns the normalized plane coordinates.
  * The plane changes.
  *
  * @param { Array } plane - Source and destination plane.
  *
  * @example
  * // returns [ 1, 0, 0, 0 ];
  * _.normalize( [ 1, 0, 0, 0 ] );
  *
  * @example
  * // returns [ 1, 0, 0, 2 ]
  * _.translate( [ 1, 0, 0, 2 ]  );
  *
  * @returns { Array } Returns the normalized plane.
  * @function normalize
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */

function normalize( plane )
{

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  _.assert( arguments.length === 1, 'Expects single argument' );
  debugger;
  //throw _.err( 'not tested' );

  let scaler = 1.0 / normal.mag();
  normal.mulScalar( scaler );
  _.plane.biasSet( planeView,bias*scaler );

  return plane;
}

//

/**
  * Negate a plane coordinates. Returns the negated plane coordinates.
  * The plane changes.
  *
  * @param { Array } plane - Source and destination plane.
  *
  * @example
  * // returns [ - 1, 0, 0, 0 ];
  * _.negate( [ 1, 0, 0, 0 ] );
  *
  * @example
  * // returns [ - 1, 0, 0, - 2 ]
  * _.negate( [ 1, 0, 0, 2 ]  );
  *
  * @returns { Array } Returns the negated plane.
  * @function negate
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */

function negate( plane )
{

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );

  _.assert( arguments.length === 1, 'Expects single argument' );
  debugger;
  // throw _.err( 'not tested' );

  _.vector.mulScalar( normal,-1 );
  _.plane.biasSet( planeView,-bias );

  return plane;
}

//

/**
  * Returns the intersection point between three planes. Returns the intersection point coordinates, NaN if the plane´s intersection is not a point.
  * The planes remain unchanged.
  *
  * @param { Array } planeone - Source plane.
  * @param { Array } planetwo - Source plane.
  * @param { Array } planethree - Source plane.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.threeIntersectionPoint( [ 1, 0, 0, 0 ] , [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ] );
  *
  *
  * @returns { Point } Returns the point of intersection between three planes.
  * @function threeIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( plane ) is not plane.
  * @memberof module:Tools/math/Concepts.wTools.plane
  */

function threeIntersectionPoint( planeone , planetwo , planethree )
{

  let planeViewOne = _.plane._from( planeone );
  let normalOne = _.plane.normalGet( planeViewOne );
  let biasOne = _.plane.biasGet( planeViewOne );
  let planeViewTwo = _.plane._from( planetwo );
  let normalTwo = _.plane.normalGet( planeViewTwo );
  let biasTwo = _.plane.biasGet( planeViewTwo );
  let planeViewThree = _.plane._from( planethree );
  let normalThree = _.plane.normalGet( planeViewThree );
  let biasThree = _.plane.biasGet( planeViewThree );

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( normalOne.length === normalTwo.length && normalTwo.length == normalThree.length );

  let Ispoint = _.vector.dot( normalOne, _.vector.cross( normalTwo.clone(), normalThree ) );

  let point;
  if( Ispoint != 0)
  {
    let cross23 = _.vector.cross( normalTwo.clone(), normalThree );
    let cross31 = _.vector.cross( normalThree.clone(), normalOne );
    let cross12 = _.vector.cross( normalOne.clone(), normalTwo );

    let Mcross23 = _.vector.mulScalar( cross23, - 1.0*biasOne );
    let Mcross31 = _.vector.mulScalar( cross31, - 1.0*biasTwo );
    let Mcross12 = _.vector.mulScalar( cross12, - 1.0*biasThree );

    point = _.vector.mulScalar( _.vector.addVectors( Mcross23, Mcross31, Mcross12 ) , 1.0 / Ispoint);

    return point;
  }

  else
  {
    point = NaN;
    return point;
  }

}


// --
// declare
// --

let Proto =
{

  make : make,
  _from : _from,
  is : is,

  from : from,
  fromNormalAndPoint : fromNormalAndPoint,
  fromPoints : fromPoints,

  dimGet : dimGet,
  normalGet : normalGet,
  biasGet : biasGet,
  biasSet : biasSet,

  pointContains : pointContains, /* qqq : implement me */
  pointDistance : pointDistance,
  pointCoplanarGet : pointCoplanarGet,
  // pointClosestPoint : pointClosestPoint, /* qqq : implement me - done in pointCoplanarGet */

  boxIntersects : boxIntersects,
  boxDistance : boxDistance, /* qqq: implement me - Same as _.box.planeDistance */
  boxClosestPoint : boxClosestPoint, /* qqq: implement me */
  boundingBoxGet : boundingBoxGet,

  capsuleIntersects : capsuleIntersects,
  capsuleDistance : capsuleDistance,
  capsuleClosestPoint : capsuleClosestPoint,

  frustumIntersects : frustumIntersects, /* qqq: implement me - Same as _.frustum.planeIntersects */
  frustumDistance : frustumDistance, /* qqq: implement me - Same as _.frustum.planeDistance */
  frustumClosestPoint : frustumClosestPoint, /* qqq: implement me */

  lineIntersects : lineIntersects,
  lineIntersection : lineIntersection,
  lineDistance : lineDistance,
  lineClosestPoint : lineClosestPoint,

  planeIntersects : planeIntersects, /* qqq: implement me */
  planeDistance : planeDistance, /* qqq: implement me */

  rayIntersects : rayIntersects, /* Same as _.ray.planeIntersects */
  rayDistance : rayDistance, /* Same as _.ray.planeDistance */
  rayClosestPoint : rayClosestPoint,

  segmentIntersects : segmentIntersects,
  segmentDistance : segmentDistance,
  segmentClosestPoint : segmentClosestPoint,

  sphereIntersects : sphereIntersects,
  sphereDistance : sphereDistance,
  sphereClosestPoint : sphereClosestPoint, /* qqq: implement me */
  boundingSphereGet : boundingSphereGet,

  matrixHomogenousApply : matrixHomogenousApply,
  translate : translate,

  normalize : normalize,
  negate : negate,

  threeIntersectionPoint : threeIntersectionPoint,

}

_.mapSupplement( Self,Proto );

})();
