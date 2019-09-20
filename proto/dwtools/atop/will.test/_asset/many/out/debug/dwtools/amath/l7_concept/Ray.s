(function _Ray_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.ray = _.ray || Object.create( null );

/**
 * @description
 * A ray is a semi-infinite line, starting at an origin and following a direction.
 *
 * For the following functions, rays must have the shape [ orX, orY, orZ, dirX, dirY, dirZ ],
 * where the dimension equals the object´s length divided by two.
 *
 * Moreover, orX, orY and orZ, are the coordinates of the origin of the ray,
 * and dirX, dirY, dirZ the coordinates of the direction of the ray.
 * @namespace "wTools.ray"
 * @memberof module:Tools/math/Concepts 
 */

/*

  A ray is a semi-infinite line, starting at an origin and following a direction.

  For the following functions, rays must have the shape [ orX, orY, orZ, dirX, dirY, dirZ ],
where the dimension equals the object´s length divided by two.

  Moreover, orX, orY and orZ, are the coordinates of the origin of the ray,
and dirX, dirY, dirZ the coordinates of the direction of the ray.

*/
// --
//
// --
//


function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.ray.makeZero( dim );
  if( _.ray.is( dim ) )
  _.avector.assign( result,dim );
  return result;
}

//

function makeZero( dim )
{
  if( _.ray.is( dim ) )
  dim = _.ray.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;
  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.dup( 0,dim*2 );
  return result;
}

//

function makeNil( dim )
{
  if( _.ray.is( dim ) )
  dim = _.ray.dimGet( dim );
  if( dim === undefined || dim === null )
  dim = 3;

  _.assert( dim >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = [];
  for( let i = 0 ; i < dim ; i++ )
  result[ i ] = +Infinity;
  for( let i = 0 ; i < dim ; i++ )
  result[ dim+i ] = -Infinity;

  return result;
}

//

function zero( ray )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.ray.is( ray ) )
  {
    let rayView = _.ray._from( ray );
    rayView.assign( 0 );
    return ray;
  }

  return _.ray.makeZero( ray );
}

//

function nil( ray )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.ray.is( ray ) )
  {
    let rayView = _.ray._from( ray );
    // let min = _.ray.cornerLeftGet( rayView );
    // let max = _.ray.cornerRightGet( rayView );
    let min = _.ray.originGet( rayView );
    let max = _.ray.directionGet( rayView );

    _.vector.assign( min, +Infinity );
    _.vector.assign( max, -Infinity );

    return ray;
  }

  return _.ray.makeNil( ray );
}

//

function from( ray )
{
//  if( _.objectIs( ray ) )
//  {
//    _.assertMapHasFields( ray,{ min : 'min' , max : 'max' } );
//    ray = _.arrayAppendArrays( [],[ ray.min,ray.max ] );
//  }

  _.assert( _.ray.is( ray ) || ray === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

//  if( _.vectorIs( ray ) )
//  {
//    debugger;
//    throw _.err( 'not implemented' );
//    return ray.slice();
//  }

  if( ray === null )
  return _.ray.make();

  return ray;
}

//

function _from( ray )
{
  _.assert( _.ray.is( ray ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return _.vector.from( ray );
}

//

/**
  * Get a ray out of two points. Returns a vector with the coordinates of the ray.
  * The pair of points stays untouched.
  *
  * @param { Array } pair - The source points.
  *
  * @example
  * // returns   _.vector.from( [ 1, 2, 1, 2 ] )
  * _.fromPair( [ 1, 2 ], [ 3, 4 ] );
  *
  * @returns { Vector } Returns the ray containing the two points.
  * @function fromPair
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( pair ) is not array.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function fromPair( pair )
{
//  let result = [];
//  result[ 0 ] = pair[ 0 ];
//  result[ 1 ] = avector.sub( null, pair[ 1 ], pair[ 0 ] );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( pair.length === 2, 'Expects two points' );
  _.assert( pair[ 0 ].length === pair[ 1 ].length, 'Expects two points' );

  let result = _.vector.from( _.array.makeArrayOfLength( pair[ 0 ].length * 2 ) );
  let pair0 = _.vector.from( pair[ 0 ] );
  let pair1 = _.vector.from( pair[ 1 ] );

  for( let i = 0; i < pair0.length ; i++ )
  {
    result.eSet( i, pair0.eGet( i ) );
    result.eSet( pair0.length + i, avector.sub( null, pair1, pair0 )[ i ] );
  }

  debugger;
  return result;
}

fromPair.shaderChunk =
`
  void ray_fromPair( out vec2 dstRay[ 2 ], vec2 pair[ 2 ] )
  {
    dstRay[ 0 ] = pair[ 0 ];
    dstRay[ 1 ] = pair[ 1 ] - pair[ 0 ];
  }

  void ray_fromPair( out vec3 dstRay[ 2 ], vec3 pair[ 2 ] )
  {
    dstRay[ 0 ] = pair[ 0 ];
    dstRay[ 1 ] = pair[ 1 ] - pair[ 0 ];
  }
`

//

/**
  * Check if input is a ray. Returns true if it is a ray and false if not.
  *
  * @param { Vector } ray - Source ray.
  *
  * @example
  * // returns true;
  * _.is( [ 0, 0, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is ray.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function is( ray )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( ray ) || _.vectorIs( ray ) ) && ( ray.length >= 0 ) && ( ray.length % 2 === 0 );
}

//

/**
  * Get ray dimension. Returns the dimension of the ray. Ray stays untouched.
  *
  * @param { Vector } ray - The source ray.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the ray.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function dimGet( ray )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.ray.is( ray ) );
  return ray.length / 2;
}

//

/**
  * Get the origin of a ray. Returns a vector with the coordinates of the origin of the ray.
  * Ray stays untouched.
  *
  * @param { Vector } ray - The source ray.
  *
  * @example
  * // returns   0, 0
  * _.originGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  1
  * _.originGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the coordinates of the origin of the ray.
  * @function originGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function originGet( ray )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let rayView = _.ray._from( ray );
  return rayView.subarray( 0, ray.length/ 2 );
}

//

/**
  * Get the direction of a ray. Returns a vector with the coordinates of the direction of the ray.
  * Ray stays untouched.
  *
  * @param { Vector } ray - The source ray.
  *
  * @example
  * // returns   2, 2
  * _.directionGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  2
  * _.directionGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the direction of the ray.
  * @function directionGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( ray ) is not ray.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function directionGet( ray )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let rayView = _.ray._from( ray );
  return rayView.subarray( ray.length/ 2, ray.length );
}

//

/**
  * Get a point in a ray. Returns a vector with the coordinates of the point of the ray.
  * Ray and factor stay untouched.
  *
  * @param { Vector } srcRay - The source ray.
  * @param { Vector } factor - The source factor.
  *
  * @example
  * // returns   4, 4
  * _.rayAt( [ 0, 0, 2, 2 ], 2 );
  *
  * @example
  * // returns  1
  * _.rayAt( [ 1, 2 ], 0 );
  *
  * @returns { Vector } Returns a point in the ray at a given factor.
  * @function rayAt
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( factor ) is not number.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function rayAt( srcRay, factor )
{
  // let result = avector.mul( null, srcRay[ 1 ], factor );
  // avector.add( result, srcRay[ 0 ] );

  _.assert( arguments.length === 2, 'Expects single argument' );
  _.assert( _.ray.is( srcRay ) );
  _.assert( factor >= 0, 'Factor can not be negative ( point must be in the ray )');

  let rayView = _.ray._from( srcRay )
  let origin = _.ray.originGet( rayView );
  let direction = _.ray.directionGet( rayView );

  let result = avector.mul( null, direction, factor );
  result = avector.add( result, origin );

  return result;
}

rayAt.shaderChunk =
`
  vec2 rayAt( vec2 srcRay[ 2 ], float factor )
  {

    vec2 result = srcRay[ 1 ]*factor;
    result += srcRay[ 0 ];

    return result;
  }
`

//

/**
* Get the factor of a point inside a ray. Returs the calculated factor. Point and ray stay untouched.
*
* @param { Array } srcRay - The source ray.
* @param { Array } srcPoint - The source point.
*
* @example
* // returns 0.5
* _.getFactor( [ 0, 0, 2, 2 ], [ 1, 1 ] );
*
* @example
* // returns false
* _.getFactor( [ 0, 0, 2, 2 ], [ - 1, 3 ] );
*
* @returns { Number } Returns the factor if the point is inside the ray, and false if the point is outside it.
* @function getFactor
* @throws { Error } An Error if ( dim ) is different than point.length (ray and point have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( srcRay ) is not ray.
* @throws { Error } An Error if ( srcPoint ) is not point.
* @memberof module:Tools/math/Concepts.wTools.ray
*/
function getFactor( srcRay, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPoint.length );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimension  = _.ray.dimGet( srcRayView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The ray and the point must have the same dimension' );
  let dOrigin = _.vector.from( avector.subVectors( srcPointView, origin ) );

  let factor;
  if( direction.eGet( 0 ) === 0 )
  {
    if( Math.abs( dOrigin.eGet( 0 ) ) > _.accuracySqr )
    {
      return false;
    }
    else
    {
      factor = 0;
    }
  }
  else
  {
    factor = dOrigin.eGet( 0 ) / direction.eGet( 0 );
  }

  // Factor can not be negative nor bigger than one
  if(  factor <= 0 - _.accuracySqr )
  return false;

  for( var i = 1; i < dOrigin.length; i++ )
  {
    let newFactor;
    if( direction.eGet( i ) === 0 )
    {
      if( Math.abs( dOrigin.eGet( i ) ) > _.accuracySqr )
      {
        return false;
      }
      else
      {
        newFactor = 0;
      }
    }
    else
    {
      newFactor = dOrigin.eGet( i ) / direction.eGet( i );
      if( Math.abs( newFactor - factor ) > _.accuracySqr && newFactor !== 0 && factor !== 0 )
      {
        return false;
      }
      factor = newFactor;
      // Factor can not be negative
      if(  factor <= 0 - _.accuracySqr )
      return false;
    }
  }

  return factor;
}

//

/**
  * Check if two rays are parallel. Returns true if they are parallel and false if not.
  * Rays and accuracySqr stay untouched. Only for 3D.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  * @param { Vector } accuracySqr - The accuracy.
  *
  * @example
  * // returns   true
  * _.rayParallel( [ 0, 0, 0, 2, 2, 2 ], [ 1, 2, 1, 4, 4, 4 ] );
  *
  * @example
  * // returns  false
  * _.rayParallel( [ 1, 2, 1, 1, 1, 2 ], [ 1, 2, 1, 1, 3, 3 ] );
  *
  * @returns { Boolean } Returns true if the rays are parallel.
  * @function rayParallel
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @throws { Error } An Error if ( accuracySqr ) is not number.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function rayParallel3D( src1Ray, src2Ray, accuracySqr )
{
  // _.assert( src1Ray.length === 3 );
  // _.assert( src2Ray.length === 3 );
  // _.assert( arguments.length === 2 || arguments.length === 3 );

  // if( accuracySqr === undefined )
  // accuracySqr = Self.accuracySqr;

  // return _magSqr( avector.cross( src1Ray[ 1 ], src2Ray[ 1 ] ) ) <= Self.accuracySqr;

  _.assert( _.ray.is( src1Ray ) );
  _.assert( _.ray.is( src2Ray ) );
  _.assert( arguments.length === 2 || arguments.length === 3 );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = _.accuracySqr;;

  let direction1 = _.ray.directionGet( src1Ray );
  let direction2 = _.ray.directionGet( src2Ray );

  debugger;
  return avector.magSqr( avector.cross( null, direction1, direction2 )) <= accuracySqr;

}

//

function rayParallel( src1Ray, src2Ray, accuracySqr )
{
  // _.assert( src1Ray.length === 3 );
  // _.assert( src2Ray.length === 3 );
  // _.assert( arguments.length === 2 || arguments.length === 3 );

  // if( accuracySqr === undefined )
  // accuracySqr = Self.accuracySqr;

  // return _magSqr( avector.cross( src1Ray[ 1 ], src2Ray[ 1 ] ) ) <= Self.accuracySqr;

  _.assert( _.ray.is( src1Ray ) );
  _.assert( _.ray.is( src2Ray ) );
  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( src1Ray.length === src2Ray.length );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = _.accuracySqr;;

  let direction1 = _.ray.directionGet( src1Ray );
  let direction2 = _.ray.directionGet( src2Ray );
  let proportion = undefined;

  let zeros1 = 0;                               // Check if Ray1 is a point
  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 )
    {
      zeros1 = zeros1 + 1;
    }
    if( zeros1 === direction1.length )
    return true;
  }

  let zeros2 = 0;                               // Check if Ray2 is a point
  for( let i = 0; i < direction2.length ; i++  )
  {
    if( direction2.eGet( i ) === 0 )
    {
      zeros2 = zeros2 + 1;
    }
    if( zeros2 === direction2.length )
    return true;
  }

  debugger;

  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 || direction2.eGet( i ) === 0 )
    {
      if( direction1.eGet( i ) !== direction2.eGet( i ) )
      {
        return false;
      }
    }
    else
    {
      let newProportion = direction1.eGet( i ) / direction2.eGet( i );

      if( proportion !== undefined )
      {
        if( Math.abs( proportion - newProportion ) > accuracySqr)
        return false
      }

      proportion = newProportion;
    }
  }

  return true;
}

//

/**
  * Returns the factors for the intersection of two rays. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Rays stay untouched.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionFactors( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  _.vector.from( [ 2, 1 ] )
  * _.rayIntersectionFactors( [ - 2, 0, 1, 0 ], [ 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors for the two rays intersection.
  * @function rayIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function rayIntersectionFactors( r1, r2 )
{
  //_.assert( r1[ 0 ].length === 2,'implemented only for d2' );
  //_.assert( r2[ 0 ].length === 2,'implemented only for d2' );

  // let dorigin = avector.subVectors( r2[ 0 ].slice() , r1[ 0 ] );

  // let y = [];
  // y[ 0 ] = + dorigin[ 0 ];
  // y[ 1 ] = - dorigin[ 1 ];

  // let m = [];
  // m[ 0 ] = + r1[ 1 ][ 0 ];
  // m[ 1 ] = - r1[ 1 ][ 1 ];
  // m[ 2 ] = - r2[ 1 ][ 0 ];
  // m[ 3 ] = + r2[ 1 ][ 1 ];

  // let x = d2linearEquationSolve( m,y );
  // debbuger;
  // return x;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( r1.length === r2.length,'The two rays must have the same dimension' );

  let r1View = _.ray._from( r1.slice() );
  let r2View = _.ray._from( r2.slice() );

  let origin1 = _.ray.originGet( r1View );
  let origin2 = _.ray.originGet( r2View );
  let dOrigin = _.vector.from( avector.subVectors( origin2.clone(), origin1 ) );

  let direction1 = _.ray.directionGet( r1View );
  let direction2 = _.ray.directionGet( r2View );
  let directions = _.Space.make( [ r1.length / 2 , 2 ] );
  directions.colVectorGet( 0 ).copy( direction1 );
  directions.colVectorGet( 1 ).copy( direction2.clone().mulScalar( - 1 ) );

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < origin1.length; i++ )
  {
    if( origin1.eGet( i ) === origin2.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === origin1.length )
  return _.vector.from( [ 0, 0 ] );

  // Parallel rays
  if( rayParallel( r1View, r2View ) === true )
  {
    let factor1 = _.ray.getFactor( r1View, origin2 );
    let factor2 = _.ray.getFactor( r2View, origin1 );

    if( factor1 )
    {
      return _.vector.from( [ factor1, 0 ] );
    }
    else if( factor2 )
    {
      return _.vector.from( [ 0, factor2 ] );
    }
    else
    {
      return 0;
    }
  }

  let result = _.vector.from( [ 0, 0 ] );

  debugger;

  for( let i = 0; i < dOrigin.length - 1 ; i++ )
  {
    let m = _.Space.make( [ 2, 2 ] );
    m.rowSet( 0, directions.rowVectorGet( i ) );
    m.rowSet( 1, directions.rowVectorGet( i + 1 ) );

    let or = _.Space.makeCol( [ dOrigin.eGet( i ), dOrigin.eGet( i + 1 ) ] );

    let o =
    {
      x : null,
      m : m,
      y : or,
      kernel : null,
      pivoting : 1,
    }

    let x = _.Space.solveGeneral( o );

    if( i === 0 )
    {
      result = _.vector.from( x.base )
    }
    else
    {
      let x1 = x.base.colVectorGet( 0 ).eGet( 0 );
      let x2 = x.base.colVectorGet( 0 ).eGet( 1 );

      let samex1 = Math.abs( x1 - result.eGet( 0 ) ) < 1E-6 || Math.abs( x1 - result.eGet( 1 ) ) < 1E-6 ;
      let samex2 = Math.abs( x2 - result.eGet( 0 ) ) < 1E-6 || Math.abs( x2 - result.eGet( 1 ) ) < 1E-6 ;

      if( x1 !== 0 )
      {
        if( samex1 )
        {
          result.eSet( 0, _.vector.from( x.base ).eGet( 0 ) );
        }
        else if ( ( result.eGet( 0 ) === 0 || result.eGet( 1 ) === 0 ) && samex2 )
        {
          result.eSet( 0, _.vector.from( x.base ).eGet( 0 ) );
        }
        else
        {
          return 0;
        }
      }
      if( x2 !== 0 )
      {
        if( samex2 )
        {
          result.eSet( 1, _.vector.from( x.base ).eGet( 1 ) );
        }
        else if ( ( result.eGet( 0 ) === 0 || result.eGet( 1 ) === 0 ) && samex1 )
        {
          result.eSet( 1, _.vector.from( x.base ).eGet( 1 ) );
        }
        else
        {
          return 0;
        }
      }
    }
  }
  // Factors can not be negative
  if(  result.eGet( 0 ) <= 0 - _.accuracySqr || result.eGet( 1 ) <= 0 - _.accuracySqr )
  return 0;

  return result;
}

//

/**
  * Returns the points of the intersection of two rays. Returns an array with the intersection points, 0 if there is no intersection.
  * Rays stay untouched.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionPoints( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.rayIntersectionPoints( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the points of intersection of the two rays.
  * @function rayIntersectionPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function rayIntersectionPoints( r1,r2 )
{
  let factors = rayIntersectionFactors( r1,r2 );
  if( factors === 0 )
  return 0;

  let factorsView = _.vector.from( factors );
  let result = [ Self.rayAt( r1, factorsView.eGet( 0 ) ), Self.rayAt( r2, factorsView.eGet( 1 ) ) ];
  return result;
}

rayIntersectionPoints.shaderChunk =
`
  void rayIntersectionPoints( out vec2 result[ 2 ], vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 factors = rayIntersectionFactors( r1,r2 );
    result[ 0 ] = rayAt( r1,factors[ 0 ] );
    result[ 1 ] = rayAt( r2,factors[ 1 ] );

  }
`

//

/**
  * Returns the point of the intersection of two rays. Returns an array with the intersection point, 0 if there is no intersection.
  * Rays stay untouched.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionPoint( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ] ]
  * _.rayIntersectionPoint( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two rays.
  * @function rayIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function rayIntersectionPoint( r1,r2 )
{

  let factors = Self.rayIntersectionFactors( r1,r2 );

  if( factors === 0 )
  return 0;

  return Self.rayAt( r1,factors.eGet( 0 ) );

}

rayIntersectionPoint.shaderChunk =
`
  vec2 rayIntersectionPoint( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 factors = rayIntersectionFactors( r1,r2 );
    return rayAt( r1,factors[ 0 ] );

  }
`

//

/**
  * Returns the point of the intersection of two rays. Returns an array with the intersection point, 0 if there is no intersection.
  * Rays stay untouched.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   0
  * _.rayIntersectionPointAccurate( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ] ]
  * _.rayIntersectionPointAccurate( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two rays.
  * @function rayIntersectionPointAccurate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function rayIntersectionPointAccurate( r1,r2 )
{

  let closestPoints = Self.rayIntersectionPoints( r1,r2 );
  // return closestPoints[ 0 ].add( closestPoints[ 1 ] ).mul( 0.5 );
  debugger;

  if( closestPoints === 0)
  return 0;

  return _.avector.mulScalar( _.avector.add( null, closestPoints[ 0 ], closestPoints[ 1 ] ), 0.5 );

}

rayIntersectionPointAccurate.shaderChunk =
`
  vec2 rayIntersectionPointAccurate( vec2 r1[ 2 ], vec2 r2[ 2 ] )
  {

    vec2 closestPoints[ 2 ];
    rayIntersectionPoints( closestPoints,r1,r2 );
    return ( closestPoints[ 0 ] + closestPoints[ 1 ] ) * 0.5;

  }
`
//

/**
  * Check if a given point is contained inside a ray. Returs true if it is contained, false if not.
  * Point and ray stay untouched.
  *
  * @param { Array } srcRay - The source ray.
  * @param { Array } srcPoint - The source point.
  *
  * @example
  * // returns true
  * _.pointContains( [ 0, 0, 2, 2 ], [ 1, 1 ] );
  *
  * @example
  * // returns false
  * _.pointContains( [ 0, 0, 2, 2 ], [ - 1, 3 ] );
  *
  * @returns { Boolen } Returns true if the point is inside the ray, and false if the point is outside it.
  * @function pointContains
  * @throws { Error } An Error if ( dim ) is different than point.length (ray and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function pointContains( srcRay, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPoint.length );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimension  = _.ray.dimGet( srcRayView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The ray and the point must have the same dimension' );
  let dOrigin = _.vector.from( avector.subVectors( srcPointView, origin ) );

  let factor;
  if( direction.eGet( 0 ) === 0 )
  {
    if( Math.abs( dOrigin.eGet( 0 ) ) > _.accuracy )
    {
      return false;
    }
    else
    {
      factor = 0;
    }
  }
  else
  {
    factor = dOrigin.eGet( 0 ) / direction.eGet( 0 );
  }

  // Factor can not be negative
  if(  factor <= 0 - _.accuracy )
  return false;

  for( var i = 1; i < dOrigin.length; i++ )
  {
    let newFactor;
    if( direction.eGet( i ) === 0 )
    {
      if( Math.abs( dOrigin.eGet( i ) ) > _.accuracy )
      {
        return false;
      }
      else
      {
        newFactor = 0;
      }
    }
    else
    {
      newFactor = dOrigin.eGet( i ) / direction.eGet( i );
      if( Math.abs( newFactor - factor ) > _.accuracy && factor !== 0 )
      {
        return false;
      }
      factor = newFactor;

      if(  factor <= 0 - _.accuracy )
      return false;
    }
  }

  return true;
}

//

/**
  * Get the distance between a point and a ray. Returs the calculated distance. Point and ray stay untouched.
  *
  * @param { Array } srcRay - The source ray.
  * @param { Array } srcPoint - The source point.
  *
  * @example
  * // returns 0
  * _.pointDistance( [ 0, 0, 0, 2 ], [ 0, 1 ] );
  *
  * @example
  * // returns 2
  * _.pointDistance( [ 0, 0, 0, 2 ], [ 2, 2 ] );
  *
  * @returns { Boolen } Returns the distance between the point and the ray.
  * @function pointDistance
  * @throws { Error } An Error if ( dim ) is different than point.length (ray and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function pointDistance( srcRay, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPoint.length );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimension  = _.ray.dimGet( srcRayView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The ray and the point must have the same dimension' );

  if( _.ray.pointContains( srcRayView, srcPointView ) )
  {
    return 0;
  }
  else
  {
    let projection = _.ray.pointClosestPoint( srcRayView, srcPointView );

    let dPoints = _.vector.from( avector.subVectors( srcPointView, projection ) );
    debugger;
    let mod = _.vector.dot( dPoints, dPoints );
    mod = Math.sqrt( mod );

    return mod;
  }
}

/**
  * Get the closest point between a point and a ray. Returs the calculated point. srcPoint and ray stay untouched.
  *
  * @param { Array } srcRay - The source ray.
  * @param { Array } srcPoint - The source point.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * _.pointClosestPoint( [ 0, 0, 0, 2 ], [ 0, 1 ] );
  *
  * @example
  * // returns [ 0, 2 ]
  * _.pointClosestPoint( [ 0, 0, 0, 2 ], [ 2, 2 ] );
  *
  * @returns { Boolen } Returns the closest point in a ray to a point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than point.length (ray and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function pointClosestPoint( srcRay, srcPoint, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcPoint.length );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPoint.length );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimension  = _.ray.dimGet( srcRayView )
  let srcPointView = _.vector.from( srcPoint.slice() );
  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimension === srcPoint.length, 'The ray and the point must have the same dimension' );

  let pointVector;

  var dir = 0;
  for( var i = 0; i < direction.length; i++ )
  {
    if( direction.eGet( i ) === 0 )
    dir = dir + 1;
  }

  if( dir === direction.length )
  {
    pointVector = origin;
  }
  else if( _.ray.pointContains( srcRayView, srcPointView ) )
  {
    pointVector = _.vector.from( srcPointView );
  }
  else
  {
    let dOrigin = _.vector.from( avector.subVectors( srcPointView, origin ) );
    let dot = _.vector.dot( direction, direction );
    let factor = _.vector.dot( direction , dOrigin ) / dot ;
    if( factor < 0 || dot === 0 )
    {
      pointVector = _.vector.from( origin );
    }
    else
    {
      pointVector = _.vector.from( _.ray.rayAt( srcRayView, factor ) );
    }
  }

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointView.eSet( i, pointVector.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a ray and a box intersect. Returns true if they intersect and false if not.
  * The box and the ray remain unchanged. Only for 1D to 3D
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns true;
  * _.boxIntersects( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns false;
  * _.boxIntersects( [ 0, -1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Boolean } Returns true if the ray and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the ray and box don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function boxIntersects( srcRay, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( srcBox.length / 2 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  let boxView = _.box._from( srcBox );
  let dimBox = _.box.dimGet( boxView );
  let min = _.vector.from( _.box.cornerLeftGet( boxView ) );
  let max = _.vector.from( _.box.cornerRightGet( boxView ) );

  _.assert( dimRay === dimBox );

  if( _.box.pointContains( boxView, origin ) )
  return true;

  /* box corners */
  let c = _.box.cornersGet( boxView );

  for( let j = 0 ; j < _.Space.dimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colVectorGet( j );
    let projection = _.ray.pointClosestPoint( srcRayView, corner );

    if( _.box.pointContains( boxView, projection ) )
    return true;
  }

  return false;

}

//

/**
  * Get the distance between a ray and a box. Returns the calculated distance.
  * The box and the ray remain unchanged. Only for 1D to 3D
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns 0;
  * _.boxDistance( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 12 );
  * _.boxDistance( [ 0, 0, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the distance between the ray and the box.
  * @function boxDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the ray and box don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function boxDistance( srcRay, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( srcBox.length / 2 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  let boxView = _.box._from( srcBox );
  let dimBox = _.box.dimGet( boxView );
  let min = _.vector.from( _.box.cornerLeftGet( boxView ) );
  let max = _.vector.from( _.box.cornerRightGet( boxView ) );

  _.assert( dimRay === dimBox );

  if( _.ray.boxIntersects( srcRayView, boxView ) )
  return 0;

  let closestPoint = _.ray.boxClosestPoint( srcRayView, boxView );
  return _.box.pointDistance( boxView, closestPoint );
}

//

/**
  * Get the closest point in a ray to a box. Returns the calculated point.
  * The box and the ray remain unchanged. Only for 1D to 3D
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcBox - Source box.
  *
  * @example
  * // returns 0;
  * _.boxClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, - 1, 0 ];
  * _.boxClosestPoint( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the closest point in the ray to the box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the ray and box don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function boxClosestPoint( srcRay, srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcBox.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcRay === null )
  srcRay = _.ray.make( srcBox.length / 2 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  let boxView = _.box._from( srcBox );
  let dimBox = _.box.dimGet( boxView );
  let min = _.vector.from( _.box.cornerLeftGet( boxView ) );
  let max = _.vector.from( _.box.cornerRightGet( boxView ) );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( dimRay === dimBox );

  if( _.ray.boxIntersects( srcRayView, boxView ) )
  return 0;

  /* box corners */
  let c = _.box.cornersGet( boxView );

  let distance = _.box.pointDistance( boxView, origin );
  let d = 0;
  let pointView = _.vector.from( origin );

  for( let j = 0 ; j < _.Space.dimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colVectorGet( j );
    d = Math.abs( _.ray.pointDistance( srcRayView, corner ) );
    if( d < distance )
    {
      distance = d;
      pointView = _.ray.pointClosestPoint( srcRayView, corner );
    }
  }

  pointView = _.vector.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Get the bounding box of a ray. Returns destination box.
  * Ray and box are stored in Array data structure. Source ray stays untouched.
  *
  * @param { Array } dstBox - destination box.
  * @param { Array } srcRay - source ray for the bounding box.
  *
  * @example
  * // returns [ -Infinity, 0, 0, 0, 0, Infinity ]
  * _.boundingBoxGet( null, [ 0, 0, 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding box.
  * @function boundingBoxGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(ray) (the ray and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcRay ) is not ray
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function boundingBoxGet( dstBox, srcRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  if( dstBox === null || dstBox === undefined )
  dstBox = _.box.makeNil( dimRay );

  _.assert( _.box.is( dstBox ) );
  let boxView = _.box._from( dstBox );
  let min = _.box.cornerLeftGet( boxView );
  let max = _.box.cornerRightGet( boxView );
  let dimB = _.box.dimGet( boxView );

  _.assert( dimRay === dimB );

  let endPoint = _.array.makeArrayOfLength( dimB );

  for( let i = 0; i < dimB; i++ )
  {
    if( direction.eGet( i ) > 0 )
    {
      endPoint[ i ] = Infinity;
    }
    else if( direction.eGet( i ) < 0 )
    {
      endPoint[ i ] = - Infinity;
    }
    else
    {
      endPoint[ i ] = origin.eGet( i );
    }
  }

  let box = _.box._from( _.box.fromPoints( null, [ origin, endPoint ] ) );

  for( let b = 0; b < boxView.length; b++ )
  {
    boxView.eSet( b, box.eGet( b ) );
  }

  return dstBox;
}

//

function capsuleIntersects( srcRay , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = _.capsule._from( tstCapsule );
  let rayView = _.ray._from( srcRay );

  let gotBool = _.capsule.rayIntersects( tstCapsuleView, rayView );
  return gotBool;
}

//

function capsuleDistance( srcRay , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = _.capsule._from( tstCapsule );
  let rayView = _.ray._from( srcRay );

  let gotDist = _.capsule.rayDistance( tstCapsuleView, rayView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a ray to a capsule. Returns the calculated point.
  * Ray and capsule remain unchanged
  *
  * @param { Array } ray - The source ray.
  * @param { Array } capsule - The source capsule.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let capsule = [ 0, 0, 0, - 1, - 1, - 1, 1 ]
  * _.capsuleClosestPoint( [ 0, 0, 0, 2, 2, 2 ], capsule );
  *
  * @example
  * // returns [ 2, 2, 2 ]
  * _.capsuleClosestPoint( [ 2, 2, 2, 3, 3, 3 ], capsule );
  *
  * @returns { Array } Returns the closest point to the capsule.
  * @function capsuleClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( ray ) is not ray
  * @throws { Error } An Error if ( capsule ) is not capsule
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function capsuleClosestPoint( ray, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let rayView = _.ray._from( ray );
  let dimRay = _.ray.dimGet( rayView );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimRay );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let capsuleView = _.capsule._from( capsule );
  let dimCapsule  = _.capsule.dimGet( capsuleView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimRay === dstPoint.length );
  _.assert( dimRay === dimCapsule );

  if( _.capsule.rayIntersects( capsuleView, rayView ) )
  return 0
  else
  {
    let capsulePoint = _.capsule.rayClosestPoint( capsule, rayView );

    let rayPoint = _.vector.from( _.ray.pointClosestPoint( rayView, capsulePoint ) );

    for( let i = 0; i < dimRay; i++ )
    {
      dstPointView.eSet( i, rayPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a ray and a frustum intersect. Returns true if they intersect and false if not.
  * The frustum and the ray remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns true;
  * var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumIntersects( [ 0, 0, 0, 2, 2, 2 ] , srcFrustum );
  *
  * @example
  * // returns false;
  * _.frustumIntersects( [ 0, -1, 0, 0, -2, 0 ] , srcFrustum );
  *
  * @returns { Boolean } Returns true if the ray and the frustum intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the ray and frustum don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function frustumIntersects( srcRay, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Space.dimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( srcRay === null )
  srcRay = _.ray.make( rows - 1 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView );

  _.assert( dimRay === rows - 1 );

  if( _.frustum.pointContains( srcFrustum, origin ) )
  return true;

  /* frustum corners */
  let corners = _.frustum.cornersGet( srcFrustum );
  let cornersLength = _.Space.dimsOf( corners )[ 1 ];

  for( let j = 0 ; j < cornersLength ; j++ )
  {
    let corner = corners.colVectorGet( j );
    let projection = _.ray.pointClosestPoint( srcRayView, corner );

    if( _.frustum.pointContains( srcFrustum, projection ) )
    return true;
  }

  return false;

}

//

/**
  * Get the distance between a ray and a frustum. Returns the calculated distance.
  * The frustum and the ray remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 0;
  * _.frustumDistance( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 17 );
  * _.frustumDistance( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the distance between a ray and a frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the ray and frustum don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function frustumDistance( srcRay, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Space.dimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( srcRay === null )
  srcRay = _.ray.make( srcFrustum.length / 2 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView );

  _.assert( dimRay === rows - 1 );

  if( _.ray.frustumIntersects( srcRayView, srcFrustum ) )
  return 0;

  let closestPoint = _.ray.frustumClosestPoint( srcRayView, srcFrustum );
  return _.frustum.pointDistance( srcFrustum, closestPoint );
}

//

/**
  * Get the closest point in a ray to a frustum. Returns the calculated point.
  * The frustum and the ray remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 0;
  * _.frustumClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, - 1, 0 ];
  * _.frustumClosestPoint( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Number } Returns the closest point in the ray to the frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the ray and frustum don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function frustumClosestPoint( srcRay, srcFrustum, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Space.dimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcFrustum.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcRay === null )
  srcRay = _.ray.make( srcFrustum.length / 2 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( dimRay === rows - 1 );

  if( _.ray.frustumIntersects( srcRayView, srcFrustum ) )
  return 0;

  /* frustum corners */
  let corners = _.frustum.cornersGet( srcFrustum );
  let cornersLength = _.Space.dimsOf( corners )[ 1 ];

  let distance = _.frustum.pointDistance( srcFrustum, origin );
  let d = 0;
  let pointView = _.vector.from( origin );

  for( let j = 0 ; j < _.Space.dimsOf( corners )[ 1 ] ; j++ )
  {
    let corner = corners.colVectorGet( j );
    d = Math.abs( _.ray.pointDistance( srcRayView, corner ) );
    if( d < distance )
    {
      distance = d;
      pointView = _.ray.pointClosestPoint( srcRayView, corner );
    }
  }

  pointView = _.vector.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

function lineIntersects( srcRay , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstLineView = _.line._from( tstLine );
  let rayView = _.ray._from( srcRay );

  let gotBool = _.line.rayIntersects( tstLineView, rayView );
  return gotBool;
}

//

function lineDistance( srcRay , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstLineView = _.line._from( tstLine );
  let rayView = _.ray._from( srcRay );

  let gotDist = _.line.rayDistance( tstLineView, rayView );

  return gotDist;
}

//

/**
  * Get the closest point in a ray to a line. Returns the calculated point.
  * The ray and line remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } tstLine - Test line.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.lineClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, - 1, 0 ];
  * _.lineClosestPoint( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Array } Returns the closest point in the srcRay to the tstRay.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( tstLine ) is not line.
  * @throws { Error } An Error if ( dim ) is different than line.dimGet (the ray and line don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function lineClosestPoint( srcRay, tstLine, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( tstLine.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcRay === null )
  srcRay = _.ray.make( tstLine.length / 2 );

  let srcRayView = _.ray._from( srcRay );
  let srcOrigin = _.ray.originGet( srcRayView );
  let srcDir = _.ray.directionGet( srcRayView );
  let srcDim  = _.ray.dimGet( srcRayView );

  let tstLineView = _.line._from( tstLine );
  let tstOrigin = _.line.originGet( tstLineView );
  let tstDir = _.line.directionGet( tstLineView );
  let tstDim = _.line.dimGet( tstLineView );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( srcDim === tstDim );

  let pointView;

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < srcOrigin.length; i++ )
  {
    if( srcOrigin.eGet( i ) === tstOrigin.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === srcOrigin.length )
  pointView = srcOrigin;
  else
  {
    // Parallel ray and line
    if( _.ray.rayParallel( srcRayView, tstLineView ) )
    {
      pointView = _.ray.pointClosestPoint( srcRayView, tstOrigin );
    }
    else
    {
      let srcMod = _.vector.dot( srcDir, srcDir );
      let tstMod = _.vector.dot( tstDir, tstDir );
      let mod = _.vector.dot( srcDir, tstDir );
      let dOrigin = _.vector.from( avector.subVectors( tstOrigin.slice(), srcOrigin ) );
      let factor = ( - mod*_.vector.dot( tstDir, dOrigin ) + tstMod*_.vector.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );

      if( factor < 0 )
      {
        pointView = srcOrigin;
      }
      else
      {
        pointView = _.ray.rayAt( srcRayView, factor );
      }
    }
  }

  pointView = _.vector.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a ray and a plane intersect. Returns true if they intersect and false if not.
  * The plane and the ray remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcPlane - Source plane.
  *
  * @example
  * // returns true;
  * _.planeIntersects( [ 0, 0, 0, 2, 2, 2 ] , [ 1, 0, 0, - 1 ]);
  *
  * @example
  * // returns false;
  * _.planeIntersects( [ 0, -1, 0, 0, -2, 0 ] , [ 1, 0, 0, - 1 ]);
  *
  * @returns { Boolean } Returns true if the ray and the plane intersect.
  * @function planeIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the ray and plane don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function planeIntersects( srcRay, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPlane.length - 1 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  let planeView = _.plane._from( srcPlane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let dimPlane = _.plane.dimGet( planeView );

  _.assert( dimRay === dimPlane );

  if( _.plane.pointContains( planeView, origin ) )
  return true;

  let dirDotNormal = _.vector.dot( direction, normal );

  if( dirDotNormal !== 0 )
  {
    let originDotNormal = _.vector.dot( origin, normal );
    let factor = - ( originDotNormal + bias ) / dirDotNormal;

    if( factor >= 0 )
    {
      return true;
    }

  }

  return false;
}

//

/**
  * Get the distance between a ray and a plane. Returns the calculated distance.
  * The plane and the ray remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcPlane - Source plane.
  *
  * @example
  * // returns 0;
  * _.planeDistance( [ 0, 0, 0, 2, 2, 2 ] , [ 1, 0, 0, - 1 ]);
  *
  * @example
  * // returns 1;
  * _.planeDistance( [ 0, -1, 0, 0, -2, 0 ] , [ 1, 0, 0, - 1 ]);
  *
  * @returns { Number } Returns the distance between the ray and the plane.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the ray and plane don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function planeDistance( srcRay, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPlane.length - 1 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  let planeView = _.plane._from( srcPlane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let dimPlane = _.plane.dimGet( planeView );

  _.assert( dimRay === dimPlane );

  if( _.ray.planeIntersects( srcRayView, planeView ) )
  return 0;

  return Math.abs( _.plane.pointDistance( planeView, origin ) );
}

//

/**
  * Get the closest point between a ray and a plane. Returns the calculated point.
  * The plane and the ray remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcPlane - Source plane.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns 0;
  * _.planeClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 1, 0, 0, - 1 ]);
  *
  * @example
  * // returns [ 0, -1, 0 ];
  * _.planeClosestPoint( [ 0, -1, 0, 0, -2, 0 ] , [ 1, 0, 0, - 1 ]);
  *
  * @returns { Array } Returns the closest point in the ray to the plane.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the ray and plane don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function planeClosestPoint( srcRay, srcPlane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcPlane.length - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcRay === null )
  srcRay = _.ray.make( srcPlane.length - 1 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  let planeView = _.plane._from( srcPlane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let dimPlane = _.plane.dimGet( planeView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimRay === dimPlane );

  if( _.ray.planeIntersects( srcRayView, planeView ) )
  return 0;

  origin = _.vector.from( origin );
  for( let i = 0; i < origin.length; i++ )
  {
    dstPointView.eSet( i, origin.eGet( i ) );
  }


  return dstPoint;
}

//

/**
  * Check if two rays intersect. Returns true if they intersect, false if not.
  * Rays stay untouched.
  *
  * @param { Vector } src1Ray - The first source ray.
  * @param { Vector } src2Ray - The second source ray.
  *
  * @example
  * // returns   true
  * _.rayIntersects( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  false
  * _.rayIntersects( [ -3, 0, 1, 0 ], [ 0, -2, 1, 0 ] );
  *
  * @returns { Boolean } Returns true if the two rays intersect.
  * @function rayIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Ray ) is not ray.
  * @throws { Error } An Error if ( src2Ray ) is not ray.
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function rayIntersects( srcRay1, srcRay2 )
{

  if( _.ray.rayIntersectionFactors( srcRay1, srcRay2 ) === 0 )
  return false

  return true;
}

//

/**
  * Get the distance between two rays. Returns the calculated distance.
  * The rays remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } tstRay - Test ray.
  *
  * @example
  * // returns 0;
  * _.rayDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 12 );
  * _.rayDistance( [ 0, 0, 0, 0, -2, 0 ] , [ 2, 2, 2, 0, 0, 1 ]);
  *
  * @returns { Number } Returns the distance between two rays.
  * @function rayDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( tstRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the rays don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function rayDistance( srcRay, tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcRay === null )
  srcRay = _.ray.make( tstRay.length / 2 );

  let srcRayView = _.ray._from( srcRay );
  let srcOrigin = _.ray.originGet( srcRayView );
  let srcDirection = _.ray.directionGet( srcRayView );
  let srcDim  = _.ray.dimGet( srcRayView )

  let tstRayView = _.ray._from( tstRay );
  let tstOrigin = _.ray.originGet( tstRayView );
  let tstDirection = _.ray.directionGet( tstRayView );
  let tstDim  = _.ray.dimGet( tstRayView )

  _.assert( srcDim === tstDim );

  let distance;
  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < srcOrigin.length; i++ )
  {
    if( srcOrigin.eGet( i ) === tstOrigin.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === srcOrigin.length )
  distance = 0;
  else
  {
    // Parallel rays
    if( _.ray.rayParallel( srcRayView, tstRayView ) )
    {
      let d1 = _.ray.pointDistance( srcRayView, tstOrigin );
      let d2 = _.ray.pointDistance( tstRayView, srcOrigin );
      let d3 = _.avector.distance( srcOrigin, tstOrigin );

      if( d1 <= d2 && d1 <= d3 )
      {
        distance = d1;
      }
      else if( d2 <= d3 )
      {
        distance = d2;
      }
      else
      {
        distance = d3;
      }
    }
    else
    {
      let srcPoint = _.ray.rayClosestPoint( srcRayView, tstRayView );
      let tstPoint = _.ray.rayClosestPoint( tstRayView, srcRayView );
      distance = _.avector.distance( srcPoint, tstPoint );
    }
  }

  return distance;
}

//

/**
  * Get the closest point in a ray to a ray. Returns the calculated point.
  * The rays remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } tstRay - Test ray.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.rayClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, - 1, 0 ];
  * _.rayClosestPoint( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Array } Returns the closest point in the srcRay to the tstRay.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( tstRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the rays don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function rayClosestPoint( srcRay, tstRay, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( tstRay.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcRay === null )
  srcRay = _.ray.make( tstRay.length / 2 );

  let srcRayView = _.ray._from( srcRay );
  let srcOrigin = _.ray.originGet( srcRayView );
  let srcDir = _.ray.directionGet( srcRayView );
  let srcDim  = _.ray.dimGet( srcRayView );

  let tstRayView = _.ray._from( tstRay );
  let tstOrigin = _.ray.originGet( tstRayView );
  let tstDir = _.ray.directionGet( tstRayView );
  let tstDim = _.ray.dimGet( tstRayView );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( srcDim === tstDim );

  let pointView;

  if( _.ray.rayIntersects( srcRayView, tstRayView ) )
  {
    pointView = _.ray.rayIntersectionPoint( srcRayView, tstRayView );
  }
  else
  {
    // Parallel rays
    if( _.ray.rayParallel( srcRayView, tstRayView ) )
    {
      pointView = _.ray.pointClosestPoint( srcRayView, tstOrigin );
    }
    else
    {
      let factors = _.line.lineIntersectionFactors( srcRayView, tstRayView );

      if( factors === 0 )
      {
        let srcMod = _.vector.dot( srcDir, srcDir );
        let tstMod = _.vector.dot( tstDir, tstDir );
        let mod = _.vector.dot( srcDir, tstDir );
        let dOrigin = _.vector.from( avector.subVectors( tstOrigin.slice(), srcOrigin ) );
        let factor = ( - mod*_.vector.dot( tstDir, dOrigin ) + tstMod*_.vector.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );

        if( factor >= 0 )
        {
          pointView = _.ray.rayAt( srcRayView, factor );
        }
        else
        {
          pointView = srcOrigin;
        }
      }
      else if( factors.eGet( 1 ) < 0 )
      {
        // pointView = _.ray.rayAt( srcRayView, factor );

        pointView = _.ray.pointClosestPoint( srcRayView, tstOrigin );
      }
      else if( factors.eGet( 0 ) < 0 )
      {
        //pointView = _.ray.pointClosestPoint( srcRayView, tstOrigin );
        pointView = srcOrigin;
      }
    }
  }

  pointView = _.vector.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

function segmentIntersects( srcRay , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = _.segment._from( tstSegment );
  let rayView = _.ray._from( srcRay );

  let gotBool = _.segment.rayIntersects( tstSegmentView, rayView );
  return gotBool;
}

//

function segmentDistance( srcRay , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstSegmentView = _.segment._from( tstSegment );
  let rayView = _.ray._from( srcRay );

  let gotDist = _.segment.rayDistance( tstSegmentView, rayView );

  return gotDist;
}

//

/**
  * Get the closest point in a ray to a segment. Returns the calculated point.
  * The ray and segment remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } tstSegment - Test segment.
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.segmentClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, - 1, 0 ];
  * _.segmentClosestPoint( [ 0, - 1, 0, 0, -2, 0 ] , [ 2, 2, 2, 2, 2, 2 ]);
  *
  * @returns { Array } Returns the closest point in the srcRay to the tstRay.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( tstSegment ) is not segment.
  * @throws { Error } An Error if ( dim ) is different than segment.dimGet (the ray and segment don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function segmentClosestPoint( srcRay, tstSegment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( tstSegment.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcRay === null )
  srcRay = _.ray.make( tstSegment.length / 2 );

  let srcRayView = _.ray._from( srcRay );
  let srcOrigin = _.ray.originGet( srcRayView );
  let srcDir = _.ray.directionGet( srcRayView );
  let srcDim  = _.ray.dimGet( srcRayView );

  let tstSegmentView = _.segment._from( tstSegment );
  let tstOrigin = _.segment.originGet( tstSegmentView );
  let tstEnd = _.segment.endPointGet( tstSegmentView );
  let tstDir = _.segment.directionGet( tstSegmentView );
  let tstDim = _.segment.dimGet( tstSegmentView );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( srcDim === tstDim );

  let pointView;

  // Same origin
  let identOrigin = 0;
  for( let i = 0; i < srcOrigin.length; i++ )
  {
    if( srcOrigin.eGet( i ) === tstOrigin.eGet( i ) )
    identOrigin = identOrigin + 1;
  }
  if( identOrigin === srcOrigin.length )
  pointView = srcOrigin;
  else
  {
    // Parallel ray and segment
    let lineSegment = _.line.fromPair( [ tstOrigin, tstEnd ] );
    if( _.ray.rayParallel( srcRayView, lineSegment ) )
    {
      pointView = _.ray.pointClosestPoint( srcRayView, tstOrigin );
    }
    else
    {
      let srcMod = _.vector.dot( srcDir, srcDir );
      let tstMod = _.vector.dot( tstDir, tstDir );
      let mod = _.vector.dot( srcDir, tstDir );
      let dOrigin = _.vector.from( avector.subVectors( tstOrigin.slice(), srcOrigin ) );
      let factor = ( - mod*_.vector.dot( tstDir, dOrigin ) + tstMod*_.vector.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );

      if( factor < 0 )
      {
        pointView = srcOrigin;
      }
      else
      {
        pointView = _.ray.rayAt( srcRayView, factor );
      }
    }
  }

  pointView = _.vector.from( pointView );
  for( let i = 0; i < pointView.length; i++ )
  {
    dstPointView.eSet( i, pointView.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Check if a ray and a sphere intersect. Returns true if they intersect and false if not.
  * The sphere and the ray remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcSphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.sphereIntersects( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1 ]);
  *
  * @example
  * // returns false;
  * _.sphereIntersects( [ 0, 0, 0, 0, -2, 0 ], [ 3, 3, 3, 1 ]);
  *
  * @returns { Boolean } Returns true if the ray and the sphere intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the ray and sphere don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function sphereIntersects( srcRay, srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( srcRay === null )
  srcRay = _.ray.make( srcSphere.length - 1 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  let sphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimSphere = _.sphere.dimGet( sphereView );

  _.assert( dimRay === dimSphere );

  if( _.sphere.pointContains( sphereView, origin ) )
  return true;

  let distance = _.ray.pointDistance( srcRayView, center );

  if( distance <= radius)
  return true;

  return false;

}

//

/**
  * Get the distance between a ray and a sphere. Returns the calculated distance.
  * The sphere and the ray remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcSphere - Source sphere.
  *
  * @example
  * // returns 0;
  * _.sphereDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 27 ) -1;
  * _.sphereDistance( [ 0, 0, 0, 0, -2, 0 ], [ 3, 3, 3, 1 ]);
  *
  * @returns { Boolean } Returns the distance between the ray and the sphere.
  * @function sphereDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the ray and sphere don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function sphereDistance( srcRay, srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( srcRay === null )
  srcRay = _.ray.make( srcSphere.length - 1 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  let sphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimSphere = _.sphere.dimGet( sphereView );

  _.assert( dimRay === dimSphere );

  if( _.ray.sphereIntersects( srcRayView, sphereView ) )
  return 0;

  return _.ray.pointDistance( srcRayView, center ) - radius;
}

//

/**
  * Get the closest point in a ray to a sphere. Returns the calculated point.
  * The sphere and the ray remain unchanged.
  *
  * @param { Array } srcRay - Source ray.
  * @param { Array } srcSphere - Source sphere.
  * @param { Array } dstPoint - Destination point.
  *
  * @example
  * // returns 0;
  * _.sphereClosestPoint( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.sphereClosestPoint( [ 0, 0, 0, 0, -2, 0 ], [ 3, 3, 3, 1 ]);
  *
  * @returns { Boolean } Returns the closest point in a ray to a sphere.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the ray and sphere don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function sphereClosestPoint( srcRay, srcSphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcSphere.length - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcRay === null )
  srcRay = _.ray.make( srcSphere.length - 1 );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  let sphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimSphere = _.sphere.dimGet( sphereView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimRay === dimSphere );

  if( _.ray.sphereIntersects( srcRayView, sphereView ) )
  return 0;

  let pointVector = _.vector.from( _.ray.pointClosestPoint( srcRayView, center ) );

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointView.eSet( i, pointVector.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Get the bounding sphere of a ray. Returns destination sphere.
  * Ray and sphere are stored in Array data structure. Source ray stays untouched.
  *
  * @param { Array } dstSphere - destination sphere.
  * @param { Array } srcRay - source ray for the bounding sphere.
  *
  * @example
  * // returns [ 0, 0, 0, Infinity ]
  * _.boundingSphereGet( null, [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding sphere.
  * @function boundingSphereGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(ray) (the ray and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstSphere ) is not sphere
  * @throws { Error } An Error if ( srcRay ) is not ray
  * @memberof module:Tools/math/Concepts.wTools.ray
  */
function boundingSphereGet( dstSphere, srcRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcRayView = _.ray._from( srcRay );
  let origin = _.ray.originGet( srcRayView );
  let direction = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView )

  if( dstSphere === null || dstSphere === undefined )
  dstSphere = _.sphere.makeZero( dimRay );

  _.assert( _.sphere.is( dstSphere ) );
  let dstSphereView = _.sphere._from( dstSphere );
  let center = _.sphere.centerGet( dstSphereView );
  let radiusSphere = _.sphere.radiusGet( dstSphereView );
  let dimSphere = _.sphere.dimGet( dstSphereView );

  _.assert( dimRay === dimSphere );

  // Center of the sphere
  for( let c = 0; c < center.length; c++ )
  {
    center.eSet( c, origin.eGet( c ) );
  }

  // Radius of the sphere
  let difDirection = _.vector.distance( _.vector.from( _.array.makeArrayOfLengthZeroed( dimRay ) ), direction );

  if( difDirection === 0  )
  {
  _.sphere.radiusSet( dstSphereView, 0 );
  }
  else
  {
    _.sphere.radiusSet( dstSphereView, Infinity );
  }

  return dstSphere;
}



// --
// define class
// --

let Proto =
{

  make : make,
  makeZero : makeZero,
  makeNil : makeNil,

  zero : zero,
  nil : nil,

  from : from,
  _from : _from,
  fromPair : fromPair, // fromPoints : fromPoints,

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

  capsuleIntersects : capsuleIntersects,
  capsuleDistance : capsuleDistance,
  capsuleClosestPoint : capsuleClosestPoint,

  frustumIntersects : frustumIntersects,
  frustumDistance : frustumDistance,
  frustumClosestPoint : frustumClosestPoint,

  lineIntersects : lineIntersects,  /* Same as _.line.rayIntersects */
  lineDistance : lineDistance,  /* Same as _.line.rayDistance */
  lineClosestPoint : lineClosestPoint,

  planeIntersects : planeIntersects,
  planeDistance : planeDistance,
  planeClosestPoint : planeClosestPoint,

  rayIntersects : rayIntersects,
  rayDistance : rayDistance,
  rayClosestPoint : rayClosestPoint,

  segmentIntersects : segmentIntersects,  /* Same as _.segment.rayIntersects */
  segmentDistance : segmentDistance,  /* Same as _.segment.rayDistance */
  segmentClosestPoint : segmentClosestPoint,

  sphereIntersects : sphereIntersects,
  sphereDistance : sphereDistance,
  sphereClosestPoint : sphereClosestPoint,
  boundingSphereGet : boundingSphereGet,
}

_.mapSupplement( Self, Proto );

//

if( typeof module !== 'undefined' )
{

  require( './Sphere.s' );

}

})();
