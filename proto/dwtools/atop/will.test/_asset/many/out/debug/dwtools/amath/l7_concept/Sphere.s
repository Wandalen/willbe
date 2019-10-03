(function _Sphere_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.sphere = _.sphere || Object.create( null );

/**
 * @description
 * A sphere is the space enclosed by all the points at a given distance to a center:
 *
 * For the following functions, spheres must have the shape [ centerX, centerY, centerZ, radius ],
 * where the dimension equals the object´s length minus one.
 *
 * Moreover, centerX, centerY, centerZ are the coordinates of the center of the sphere,
 * and radius is the radius pf the sphere.
 * @namespace "wTools.sphere"
 * @memberof module:Tools/math/Concepts 
 */

/*

  A sphere is the space enclosed by all the points at a given distance to a center:

  For the following functions, spheres must have the shape [ centerX, centerY, centerZ, radius ],
where the dimension equals the object´s length minus one.

  Moreover, centerX, centerY, centerZ are the coordinates of the center of the sphere,
and radius is the radius pf the sphere.

*/
// --
//
// --

/**
  *Create a sphere of dimension dim. Returns the created sphere. Sphere is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created sphere.
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.make( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, 1 ];
  * _.make( [ 0, 0, 0, 1 ] );
  *
  * @returns { Array } Returns the array of the created sphere.
  * @function make
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.sphere.makeZero( dim );
  if( _.sphere.is( dim ) )
  _.avector.assign( result,dim );
  return result;
}

//

/**
  *Create a zero sphere of dimension dim. Returns the created sphere. Sphere is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created sphere.
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.makeZero( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.makeZero( [ 0, 0, 0, 1 ] );
  *
  * @returns { Array } Returns the array of the created sphere.
  * @function makeZero
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function makeZero( dim )
{
  if( _.sphere.is( dim ) )
  dim = _.sphere.dimGet( dim );

  if( dim === undefined || dim === null )
  dim = 3;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.numberIs( dim ) );

  let result = _.dup( 0,dim+1 );

  return result;
}

//

/**
  *Create a nil sphere of dimension dim. Returns the created sphere. Sphere is stored in Array data structure.
  * Dim remains unchanged.
  *
  * @param { Number } dim - Dimension of the created sphere.
  *
  * @example
  * // returns [ 0, 0, 0, - Infinity ];
  * _.makeNil( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, - Infinity ];
  * _.makeNil( [ 0, 2, 0, 1 ] );
  *
  * @returns { Array } Returns the array of the created sphere.
  * @function makeNil
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function makeNil( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.sphere.makeZero( dim );
  result[ result.length-1 ] = -Infinity;
  return result;
}

//

/**
  *Transform a sphere to a zero sphere. Returns the transformed sphere. Sphere is stored in Array data structure.
  *
  * @param { Array } sphere - Destination sphere.
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.zero( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, 0 ];
  * _.zero( [ 0, 2, 0, 1 ] );
  *
  * @returns { Array } Returns the array of the transformed sphere.
  * @function zero
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function zero( sphere )
{
  if( !_.sphere.is( sphere ) )
  return _.sphere.makeZero( sphere );

  let sphereView = _.sphere._from( sphere );
  for( let i = 0 ; i < sphereView.length ; i++ )
  sphereView.eSet( i,0 );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.sphere.is( sphere ) );

  return sphere;
}

//

/**
  *Transform a sphere to a nil sphere. Returns the transformed sphere. Sphere is stored in Array data structure.
  *
  * @param { Array } sphere - Destination sphere.
  *
  * @example
  * // returns [ 0, 0, 0, - Infinity ];
  * _.nil( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, - Infinity ];
  * _.nil( [ 0, 2, 0, 1 ] );
  *
  * @returns { Array } Returns the array of the transformed sphere.
  * @function nil
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function nil( sphere )
{
  if( !_.sphere.is( sphere ) )
  return _.sphere.makeNil( sphere );

  let sphereView = _.sphere._from( sphere );
  for( let i = 0 ; i < sphereView.length-1 ; i++ )
  sphereView.eSet( i,0 );
  sphereView.eSet( sphereView.length-1,-Infinity );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.sphere.is( sphere ) );

  return sphere;
}

//

/**
  *Transform a sphere to a sphere centered in the origin with a given radius. Returns the created sphere.
  * Sphere is stored in Array data structure.
  *
  * @param { Array } sphere - Destination sphere.
  * @param { Number } radius - Source radius.
  *
  * @example
  * // returns [ 0, 0, 0, 0.5 ];
  * _.centeredOfRadius( [ 1, 1, 1, 2] );
  *
  * @example
  * // returns [ 0, 0, 0, 3 ];
  * _.centeredOfRadius( 3 );
  *
  * @example
  * // returns [ 0, 0, 0, 3 ];
  * _.centeredOfSize( [ 1, 1, 2, 2], 3 );
  *
  * @returns { Array } Returns the created sphere.
  * @function centeredOfRadius
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function centeredOfRadius( sphere, radius )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIs( radius ) );

  sphere = _.sphere.zero( sphere );
  _.assert( _.sphere.is( sphere ) );

  _.sphere.radiusSet( sphere,radius );

  return sphere;
}

//

/**
  *Transform a sphere to a string. Returns the created string.
  * Sphere is stored in Array data structure.
  *
  * @param { Array } sphere - Destination sphere.
  * @param { Number } options - Source options.
  *
  * @example
  * // returns [ 1, 1, 2, 2 ];
  * _.toStr( [ 1, 1, 2, 2] );
  *
  * @returns { String } Returns an string with the box information.
  * @function toStr
  * @throws { Error } An Error if ( arguments.length ) is different than one or two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function toStr( sphere,options )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.sphere.is( sphere ) );

  // let sphereView = _.sphere._from( sphere );
  // let center = _.sphere.centerGet( sphereView );
  // let radius = _.sphere.radiusGet( sphereView );
  // let dim = _.sphere.dimGet( sphereView );

  return _.toStr( sphere,options );
  debugger;
}

//

/**
  *Create or return a sphere. Returns the created sphere.
  *
  * @param { Array } sphere - Destination sphere.
  *
  * @example
  * // returns [ 1, 1, 2, 2 ];
  * _.from( [ 1, 1, 2, 2 ] );
  *
  * @example
  * // returns _.vector.from( [ 1, 1, 2, 2 ] );
  * _.from( _.vector.from( [ 1, 1, 2, 2 ] ) );
  *
  * @function from
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function from( sphere )
{

  if( _.objectIs( sphere ) )
  {
    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assertMapHasOnly( sphere,{ center : 'center' , radius : 'radius' } );
    sphere = [ sphere.center[ 0 ] , sphere.center[ 1 ] , sphere.center[ 2 ] , sphere.radius ]
  }
  else
  {
    _.assert( arguments.length === 1, 'Expects single argument' );
  }

  _.assert( _.vectorAdapterIs( sphere ) || _.longIs( sphere ) );

  if( _.vectorAdapterIs( sphere ) )
  {
    debugger;
    throw _.err( 'not implemented' );
    return sphere.slice();
  }

  return sphere;
}

//

/**
  *Create or return a sphere vector. Returns the created sphere.
  *
  * @param { Array } sphere - Destination sphere.
  *
  * @example
  * // returns _.vector.from( [ 1, 1, 2, 2 ] );
  * _._from( [ 1, 1, 2, 2 ] );
  *
  * @returns { Vector } Returns the vector of the sphere.
  * @function _from
  * @throws { Error } An Error if ( arguments.length ) is different than zero or one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function _from( sphere )
{
  _.assert( _.sphere.is( sphere ) )
  _.assert( arguments.length === 1, 'Expects single argument' );
  return _.vector.from( sphere );
}

//

/**
  * Create or expand a sphere from an array of points. Returns the expanded sphere. Spheres are stored in Array data structure.
  * Points stay untouched, sphere changes. Created spheres have center in origin.
  *
  * @param { Array } sphere - sphere to be expanded.
  * @param { Array } points - Array of points of reference with expansion dimensions.
  *
  * @example
  * // returns [ 0, 0, 0, 3 ];
  * _.fromPoints( null , [ [ 0, 0, 3 ], [ 0, 2, 0 ], [ 1, 0, 0 ] ] );
  *
  * @example
  * // returns [ 0, - 1, 2 ];
  * _.fromPoints( [ 0, - 1, 1 ], [ [ 1, 0 ], [ 0, -3 ], [ 0, 0 ] ] );
  *
  * @returns { Array } Returns the array of the sphere expanded.
  * @function fromPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( point ) is not array.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function fromPoints( sphere, points )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.arrayIs( points )  || _.longIs( points ) );

  debugger;
  //throw _.err( 'not tested' );


  let dimp = points[0].length;

  if( sphere === null )
  sphere = _.sphere.make(dimp);

  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let maxr = 0;

  for ( let i = 0 ; i < points.length ; i += 1 )
  {
    maxr = Math.max( maxr, _.vector.distanceSqr( center , _.vector.from( points[ i ] ) ) );
  }

  debugger;
  sphere[ dimp ] = Math.sqrt( maxr );

  return sphere;
}

//

/**
  * Create or expand a sphere from a box. Returns the expanded sphere. Spheres are stored in Array data structure.
  * Box stay untouched, sphere changes.
  *
  * @param { Array } sphere - sphere to be expanded.
  * @param { Array } box - box of reference with expansion dimensions.
  *
  * @example
  * // returns [ 0, 0, 0, Math.sqrt( 27 ) ];
  * _.fromBox( null , [ - 3, - 3, -3, 3, 3, 3 ] );
  *
  * @returns { Array } Returns the array of the sphere expanded.
  * @function fromBox
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( point ) is not array.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function fromBox( sphere, box )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  _.assert( _.box.is( box ) );

  let boxView = _.box._from( box );
  let dimB = _.box.dimGet( boxView );
  let min = _.box.cornerLeftGet( boxView );
  let max = _.box.cornerRightGet( boxView );
  let size = _.box.sizeGet( boxView );

  if( sphere === null )
  sphere = _.sphere.make( dim );

  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimS = _.sphere.dimGet( sphereView );

  _.assert( dimS === dimB );
  //  _.assert( dim === _.sphere.dimGet(  sphere) );

  center.copy( min );
  vector.addVectors( center,max );
  vector.divScalar( center,2 );

  /* radius based on 2 major dimensions */

  // debugger;
  // _.avector.sort( size );
  // _.sphere.radiusSet( sphereView , _.avector.mag( size.slice( 1, 3 ) ) / 2 );
  _.sphere.radiusSet( sphereView , _.avector.mag( size ) / 2 );

  return sphere;
}

//

/**
  * Create or modify sphere coordinates from a center and a radius. Returns the modified sphere.
  * Spheres are stored in Array data structure. Center and radius stay untouched, sphere changes.
  *
  * @param { Array } sphere - sphere to be modified.
  * @param { Array } center - Array of coordinates for new center of sphere.
  * @param { Number } radius - Value for new radius of sphere.
  *
  * @example
  * // returns [ 0, 2, 0, 1 ];
  * _.fromCenterAndRadius( null , [ 0, 2, 0 ], 1 );
  *
  * @example
  * // returns [ 1, 0, 2 ];
  * _.fromCenterAndRadius( [ 0, - 1, 1 ], [ 1, 0 ], 2 );
  *
  * @returns { Array } Returns the array of the sphere with new coordinates.
  * @function fromCenterAndRadius
  * @throws { Error } An Error if ( arguments.length ) is different than three.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( center ) is not point.
  * @throws { Error } An Error if ( radius ) is not number.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function fromCenterAndRadius( sphere, center, radius )
{
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.longIs( center ) );
  _.assert( _.numberIs( radius ) );

  if( sphere === null )
  sphere = _.sphere.make( center.length );

  let sphereView = _.sphere._from( sphere );
  let _center = _.sphere.centerGet( sphereView );
  let _dim = _.sphere.dimGet( sphereView );

  _.assert( center.length === _dim );

  _center.copy( center );
  _.sphere.radiusSet( sphereView , radius );

  return sphere;
}

//

/**
  * Check if input is a sphere. Returns true if it is a sphere and false if not.
  *
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.is( [ 0, 0, 0, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is sphere
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function is( sphere )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( sphere ) || _.vectorAdapterIs( sphere ) ) && sphere.length > 0;
}

//

/**
  * Check if input is an empty sphere. Returns true if it is an empty sphere and false if not.
  *
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.isEmpty( [ 0, 0, 0, 0 ] );
  *
  * @returns { Boolean } Returns true if the input is an empty sphere
  * @function isEmpty
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function isEmpty( sphere )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.sphere.is( sphere ) );

  let sphereView = _.sphere._from( sphere );
  let radius = _.sphere.radiusGet( sphereView );

  return( radius <= 0 );
}

//

/**
  * Check if input is a zero sphere. Returns true if it is a zero sphere and false if not.
  *
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.isZero( [ 0, 0, 0, 0 ] );
  *
  * @returns { Boolean } Returns true if the input is a zero sphere
  * @function isZero
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function isZero( sphere )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.sphere.is( sphere ) );

  let sphereView = _.sphere._from( sphere );
  let radius = _.sphere.radiusGet( sphereView );

  return( radius === 0 );
}

//

/**
  * Check if input is a nil sphere. Returns true if it is a nil sphere and false if not.
  *
  * @param { Array } sphere - Source sphere.
  *
  * @example
  * // returns true;
  * _.isNil( [ 0, 0, 0, - Infinity ] );
  *
  * @returns { Boolean } Returns true if the input is a nil sphere
  * @function isNil
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function isNil( sphere )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  // debugger;
  // throw _.err( 'not tested' );

  let sphereView = _.sphere._from( sphere );
  let radius = _.sphere.radiusGet( sphereView );
  let center = _.sphere.centerGet( sphereView );

  // debugger;

  if( radius !== -Infinity )
  return false;

  if( !_.vector.allZero( center ) )
  return false;

  return true;
}

//

/**
  * Get Sphere dimension. Returns the dimension of the Sphere (number). Sphere stays untouched.
  *
  * @param { Array } sphere - The source sphere.
  *
  * @example
  * // returns 3
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the sphere.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function dimGet( sphere )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.sphere.is( sphere ) );
  return sphere.length - 1;
}

//

/**
  * Get the center of a sphere. Returns a vector with the coordinates of the center of the sphere.
  * Sphere stays untouched.
  *
  * @param { Array } sphere - The source sphere.
  *
  * @example
  * // returns   0, 0, 2
  * _.centerGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  0
  * _.centerGet( [ 0, 1 ] );
  *
  * @returns { Vector } Returns the coordinates of the center of the sphere.
  * @function centerGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function centerGet( sphere )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let sphereView = _.sphere._from( sphere );
  return sphereView.subarray( 0,sphere.length-1 );
}

//

/**
  * Get the radius of a sphere. Returns a number with the radius of the sphere.
  * Sphere stays untouched.
  *
  * @param { Array } sphere - The source sphere.
  *
  * @example
  * // returns 2
  * _.radiusGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  1
  * _.radiusGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the radius of the sphere.
  * @function radiusGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function radiusGet( sphere )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let sphereView = _.sphere._from( sphere );
  return sphereView.eGet( sphere.length-1 );
}

//


/**
  * Set the radius of a sphere. Returns a vector with the sphere including the new radius.
  * Radius stays untouched.
  *
  * @param { Array } sphere - The source and destination sphere.
  * @param { Number } radius - The source radius to set.
  *
  * @example
  * // returns [ 0, 0, 2, 4 ]
  * _.radiusSet( [ 0, 0, 2, 2 ], 4 );
  *
  * @example
  * // returns  [ 0, - 2 ]
  * _.radiusSet( [ 0, 1 ], -2 );
  *
  * @returns { Array } Returns the sphere with the modified radius.
  * @function radiusSet
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( radius ) is not number.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function radiusSet( sphere, radius )
{
  _.assert( _.sphere.is( sphere ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.numberIs( radius ) );

  //if( _.vectorAdapterIs( sphere ) )
  //{
  let sphereView = _.sphere._from( sphere );
  //return sphereView.eSet( sphere.length-1, radius );
  //console.log('vector');
  sphereView.eSet( sphere.length-1, radius );
  return sphereView;
  //}

  // Alternative solution
  //if( _.longIs( sphere ) )
  //{
  //  sphere[ sphere.length-1 ] = radius;
  //  return sphere;
  //}
  debugger;
}

//

/**
  * Check if a sphere contains a point. Returns true if it is contained and false if not.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns true;
  * _.pointContains( [ 0, 0, 0, 1 ], [ 0, 0, 0 ] );
  *
  * @returns { Boolean } Returns true if the sphere contains the point
  * @function pointContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function pointContains( sphere, point )
{

  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dim = _.sphere.dimGet( sphereView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dim === point.length );

  debugger;
  //throw _.err( 'not tested' );

  return ( vector.distanceSqr( vector.from( point ) , center ) <= ( radius * radius ) );
}

//

/**
  * Calculate the distance between a sphere and a point. Returns the calculated distance.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns 0;
  * _.pointDistance( [ 0, 0, 0, 1 ], [ 0, 0, 0 ] );
  *
  * @returns { Number } Returns the distance between the sphere and the point
  * @function pointDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function pointDistance( sphere, point )
{

  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dim = _.sphere.dimGet( sphereView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dim === point.length );

  debugger;
  //throw _.err( 'not tested' );

  let distance = vector.distance( vector.from( point ) , center ) - radius;

  if( distance < 0 )
  return 0;
  else
  return distance;
}

//

/**
  * Clamp a point to a sphere. Returns the closest point in the sphere. Sphere and point stay unchanged.
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } point - The point to be clamped against the box.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns [ 3, 0, 0 ]
  * _.pointClosestPoint( [ 1, 0, 0, 2 ], [ 4, 0, 0 ] );
  *
  *
  * @returns { Array } Returns an array with the coordinates of the clamped point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) (the sphere and the point don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere.
  * @throws { Error } An Error if ( point ) is not point.
  * @throws { Error } An Error if ( dstPoint ) is not dstPoint.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function pointClosestPoint( sphere, srcPoint, dstPoint )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dim = _.sphere.dimGet( sphereView );

  if( arguments.length === 2 )
  dstPoint = srcPoint.slice();

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( dim === srcPoint.length );
  let srcPointv = vector.from( srcPoint );
  _.assert( dim === dstPoint.length );
  let dstPointv = _.vector.from( dstPoint );

  if( _.sphere.pointContains( sphereView, srcPointv ) )
  return srcPointv;

  debugger;
  // throw _.err( 'not tested' );

  for( let i = 0; i < dim; i++ )
  {
    dstPointv.eSet( i, srcPointv.eGet( i ) );
  }

  let distanseSqr = vector.distanceSqr( srcPointv , center );
  if( distanseSqr > radius * radius )
  {
    _.vector.subVectors( dstPointv,center );
    _.vector.normalize( dstPointv );
    _.vector.mulScalar( dstPointv,radius );
    _.vector.addVectors( dstPointv,center );
  }

  return dstPoint;
}

//


//

/**
  * Expand a sphere with a point. Returns the new sphere.
  * Point remains unchanged, sphere changes.
  *
  * @param { Array } sphere - Destination sphere.
  * @param { Array } point - Source point.
  *
  * @example
  * // returns [ 0, 0, 0, Math.sqrt( 27 ) ];
  * _.pointExpand( [ 0, 0, 0, 1 ], [ 3, 3, 3 ] );
  *
  * @returns { Array } Returns the coordinates of the expanded sphere
  * @function pointExpand
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( sphere ) is not a sphere.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function pointExpand( sphere , point )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( point ) || _.vectorAdapterIs( point ) );
  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dim = _.sphere.dimGet( sphereView );


  let pointView = vector.from( point );

  _.assert( dim === point.length );

  // debugger;

  if( radius === -Infinity )
  {
    center.copy( point );
    _.sphere.radiusSet( sphereView,0 );
    return sphere;
  }

  let distance = _.vector.distance( center , pointView );
  if( radius < distance )
  {

    _.assert( distance > 0 );

    // _.vector.mix( center, point, 0.5 + ( -radius ) / ( distance*2 ) );
    // _.sphere.radiusSet( sphereView,( distance+radius ) / 2 );
    _.sphere.radiusSet( sphereView, distance );

  }

  return sphere;
}

//

/**
  * Checks if a sphere contains a box. Returns True if the sphere contains the box.
  * Sphere and box remain unchanged.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } box - Source box
  *
  * @example
  * // returns true
  * _.boxContains( [ 1, 1, 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @example
  * // returns false
  * _.boxContains( [ - 2, - 2, - 2, 1 ], [ 0, 0, 0, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the sphere contains the box, and false if not.
  * @function boxContains
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function boxContains( sphere, box )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimS = _.sphere.dimGet( sphereView );

  let boxView = _.box._from( box );
  let dimB = _.box.dimGet( boxView );
  let min = _.box.cornerLeftGet( boxView );
  let max = _.box.cornerRightGet( boxView );

  _.assert( dimS === dimB, 'Arguments must have same dimension' );

  /* src corners */

  let c = _.Space.makeZero( [ 3, 8 ] );
  c.colVectorGet( 0 ).copy( [ min.eGet( 0 ), min.eGet( 1 ), min.eGet( 2 ) ] );
  c.colVectorGet( 1 ).copy( [ max.eGet( 0 ), min.eGet( 1 ), min.eGet( 2 ) ] );
  c.colVectorGet( 2 ).copy( [ min.eGet( 0 ), max.eGet( 1 ), min.eGet( 2 ) ] );
  c.colVectorGet( 3 ).copy( [ min.eGet( 0 ), min.eGet( 1 ), max.eGet( 2 ) ] );
  c.colVectorGet( 4 ).copy( [ max.eGet( 0 ), max.eGet( 1 ), max.eGet( 2 ) ] );
  c.colVectorGet( 5 ).copy( [ min.eGet( 0 ), max.eGet( 1 ), max.eGet( 2 ) ] );
  c.colVectorGet( 6 ).copy( [ max.eGet( 0 ), min.eGet( 1 ), max.eGet( 2 ) ] );
  c.colVectorGet( 7 ).copy( [ max.eGet( 0 ), max.eGet( 1 ), min.eGet( 2 ) ] );

  for( let j = 0 ; j < 8 ; j++ )
  {
    let srcCorner = c.colVectorGet( j );

    if( _.sphere.pointContains( sphereView, srcCorner ) === false )
    {
    return false;
    }
  }

  return true;
}

//

/**
  * Checks if a sphere and a box Intersect. Returns True if they intersect.
  * Sphere and box remain unchanged.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } box - Source box
  *
  * @example
  * // returns true
  * _.boxIntersects( [ - 1, - 1, - 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @example
  * // returns false
  * _.boxIntersects( [ - 2, - 2, - 2, 1 ], [ 0, 0, 0, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the box and the sphere intersect and false if not.
  * @function boxIntersects
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function boxIntersects( sphere, box )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimS = _.sphere.dimGet( sphereView );

  let boxView = _.box._from( box );
  let dimB = _.box.dimGet( boxView );

  _.assert( dimS === dimB, 'Arguments must have same dimension' );

  if( _.box.pointContains( boxView, center ) === true )
  {
    return true;
  }
  else
  {
    let distance = _.box.pointDistance( boxView, center );
    if( distance <= radius )
    {
      return true;
    }
  }
  return false;
}

//

/**
  * Calculates the distance between a sphere and a box. Returns the calculated distance.
  * Sphere and box remain unchanged.
  *
  * @param { Array } sphere - Source sphere.
  * @param { Array } box - Source box
  *
  * @example
  * // returns 0
  * _.boxDistance( [ - 1, - 1, - 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.boxDistance( [ 0, 0, - 2, 1 ], [ 0, 0, 0, 1, 1, 1 ] );
  *
  * @returns { Boolean } Returns the distance between the sphere and the plane.
  * @function boxDistance
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function boxDistance( sphere, box )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let sphereView = _.sphere._from( sphere );
  let boxView = _.box._from( box );

  let distance = _.box.sphereDistance( boxView, sphereView );

  return distance;
}

//

/**
  * Gets the closest point in a sphere to a box. Returns the calculated point.
  * Sphere and box remain unchanged.
  *
  * @param { Array } srcSphere - Source sphere.
  * @param { Array } srcBox - Source box.
  * @param { Array } dstPoint - Destination point (optional).
  *
  * @example
  * // returns Math.sqrt( 27 ) - 2
  * _.boxClosestPoint( [ 0, 0, 0, 1 ], [ 2, 0, 0, 4, 0, 0 ] );
  *
  * @returns { Array } Returns the closest point in a sphere to a box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */
function boxClosestPoint( srcSphere, srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let sphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimS = _.sphere.dimGet( sphereView );

  let boxView = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxView );
  let min = _.box.cornerLeftGet( boxView );
  let max = _.box.cornerRightGet( boxView );

  _.assert( dimS === dimB );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLengthZeroed( dimB );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( dimB === dstPoint.length );
  let dstPointView = _.vector.from( dstPoint );

  if( _.sphere.boxIntersects( sphereView, boxView ) )
  return 0;

  let boxPoint = _.box.sphereClosestPoint( boxView, sphereView );
  let point = _.sphere.pointClosestPoint( sphereView, boxPoint );

  for( let i = 0; i < point.length; i++ )
  {
    dstPointView.eSet( i, point[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands a sphere with a box. Returns the expanded sphere.
  * Sphere changes and box remains unchanged.
  *
  * @param { Array } dstSphere - Destination sphere.
  * @param { Array } srcBox - Source box
  *
  * @example
  * // returns [ -1, -1, -1, Math.sqrt( 27 )]
  * _.boxExpand( [ - 1, - 1, - 1, 2 ], [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @returns { Sphere } Returns an array with the center and radius of the expanded sphere.
  * @function boxExpand
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the sphere and box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */
function boxExpand( dstSphere, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let sphereView = _.sphere._from( dstSphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimS = _.sphere.dimGet( sphereView );

  _.assert( _.box.is( srcBox ) );
  let boxView = _.box._from( srcBox );
  let dimB = _.box.dimGet( boxView );
  let min = _.box.cornerLeftGet( boxView );
  let max = _.box.cornerRightGet( boxView );

  _.assert( dimS === dimB );

  /* box corners */
  let c = _.box.cornersGet( boxView );

  let distance = radius;
  for( let j = 0 ; j < _.Space.dimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colVectorGet( j );
    let d = _.avector.distance( corner, center );
    if( d > distance )
    {
      distance = d;
    }
  }

  _.sphere.radiusSet( sphereView, distance );

  return dstSphere;
}

//

/**
  * Get the bounding box of a sphere. Returns destination box.
  * Sphere and box are stored in Array data structure. Source sphere stays untouched.
  *
  * @param { Array } dstBox - destination box.
  * @param { Array } srcSphere - source sphere for the bounding box.
  *
  * @example
  * // returns [ - 2, - 2, - 2, 2, 2, 2 ]
  * _.boundingBoxGet( null, [ 0, 0, 0, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding box.
  * @function boundingBoxGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(sphere) (the sphere and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcSphere ) is not sphere
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */
function boundingBoxGet( dstBox, srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let sphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimS = _.sphere.dimGet( sphereView );

  if( dstBox === null || dstBox === undefined )
  dstBox = _.box.makeNil( dimS );

  _.assert( _.box.is( dstBox ) );
  let dimB = _.box.dimGet( dstBox );

  _.assert( dimS === dimB );

  let boxView = _.box._from( dstBox );
  let box = _.box._from( _.box.fromSphere( null, sphereView ) );

  for( let b = 0; b < boxView.length; b++ )
  {
    boxView.eSet( b, box.eGet( b ) );
  }

  return dstBox;
}

//

function capsuleIntersects( srcSphere , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = _.capsule._from( tstCapsule );
  let sphereView = _.sphere._from( srcSphere );

  let gotBool = _.capsule.sphereIntersects( tstCapsuleView, sphereView );
  return gotBool;
}

//

function capsuleDistance( srcSphere , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = _.capsule._from( tstCapsule );
  let sphereView = _.sphere._from( srcSphere );

  let gotDist = _.capsule.sphereDistance( tstCapsuleView, sphereView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a sphere to a capsule. Returns the calculated point.
  * Sphere and capsule remain unchanged
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } capsule - The source capsule.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let capsule = [ 0, 0, 0, - 1, - 1, - 1, 1 ]
  * _.capsuleClosestPoint( [ 0, 0, 0, 2 ], capsule );
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * _.capsuleClosestPoint( [ 2, 0, 0, 1 ], capsule );
  *
  * @returns { Array } Returns the closest point to the capsule.
  * @function capsuleClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere
  * @throws { Error } An Error if ( capsule ) is not capsule
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */
function capsuleClosestPoint( sphere, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let sphereView = _.sphere._from( sphere );
  let dimSphere = _.sphere.dimGet( sphereView );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimSphere );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let capsuleView = _.capsule._from( capsule );
  let dimCapsule  = _.capsule.dimGet( capsuleView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimSphere === dstPoint.length );
  _.assert( dimSphere === dimCapsule );

  if( _.capsule.sphereIntersects( capsuleView, sphereView ) )
  return 0
  else
  {
    let capsulePoint = _.capsule.sphereClosestPoint( capsule, sphereView );

    let spherePoint = _.vector.from( _.sphere.pointClosestPoint( sphereView, capsulePoint ) );

    for( let i = 0; i < dimSphere; i++ )
    {
      dstPointView.eSet( i, spherePoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a sphere contains a frustum. Returns true if frustum is contained.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  *
  * @example
  * // returns false;
  * _.frustumContains( [ 2, 2, 2, 1 ], _.frustum.make() );
  **
  * @returns { Boolean } Returns true if the sphere contains the frustum.
  * @function frustumContains
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function frustumContains( srcSphere, tstFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( tstFrustum ) );

  let srcSphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( srcSphereView );
  let radius = _.sphere.radiusGet( srcSphereView );
  let dimS = _.sphere.dimGet( srcSphereView );

  let points = _.frustum.cornersGet( tstFrustum );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colVectorGet( i );
    let c = _.sphere.pointContains( srcSphereView, point );
    if( c === false )
    return false;
  }

  return true;
}

//

/**
  * Check if a sphere and a frustum intersect. Returns true if frustum is contained.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  *
  * @example
  * // returns false;
  * _.frustumIntersects( [ 2, 2, 2, 1 ], _.frustum.make() );
  **
  * @returns { Boolean } Returns true if the sphere and the frustum intersect, false if not.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function frustumIntersects( srcSphere, tstFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( tstFrustum ) );
  let srcSphereView = _.sphere._from( srcSphere );

  let gotBool = _.frustum.sphereIntersects( tstFrustum, srcSphereView );

  return gotBool;
}

//

/**
  * Calculates the distance between a sphere and a frustum. Returns the calculated distance.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  *
  * @example
  * // returns 1;
  * let frustum = _.Space.make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.frustumDistance( [ 1, 3, 1, 1 ], frustum );
  *
  * @returns { Number } Returns the distance between sphere and frustum.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function frustumDistance( srcSphere, tstFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( tstFrustum ) );

  let srcSphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( srcSphereView );
  let radius = _.sphere.radiusGet( srcSphereView );
  let dimS = _.sphere.dimGet( srcSphereView );

  if( _.frustum.sphereIntersects( tstFrustum, srcSphereView ) )
  return 0;

  let closestPoint = _.frustum.sphereClosestPoint( tstFrustum, srcSphereView );
  let distance = _.avector.distance( closestPoint, center ) - radius;

  return distance;
}

//

/**
  * Calculates the closest point in a sphere to a frustum. Returns the calculated point.
  * Frustum and sphere remain unchanged.
  *
  * @param { Sphere } srcSphere - Source sphere.
  * @param { Frustum } tstFrustum - Test frustum.
  * @param { Point } dstPoint - Destination point.
  *
  * @example
  * // returns [ 2, 0, 0 ];
  * let frustum = _.Space.make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.frustumClosestPoint( [ 3, 0, 0, 1 ], frustum );
  *
  * @returns { Array } Returns the closest point to a frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two pr three.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function frustumClosestPoint( srcSphere, tstFrustum, dstPoint )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( _.frustum.is( tstFrustum ) );

  if( arguments.length === 2 )
  dstPoint = [ 0, 0, 0 ];

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let dstPointView = _.vector.from( dstPoint );

  let srcSphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( srcSphereView );
  let radius = _.sphere.radiusGet( srcSphereView );
  let dimS = _.sphere.dimGet( srcSphereView );

  _.assert( dimS === dstPoint.length );

  if( _.frustum.sphereIntersects( tstFrustum, srcSphereView ) )
  return 0;

  let fClosestPoint = _.frustum.sphereClosestPoint( tstFrustum, srcSphereView );
  let sClosestPoint = _.sphere.pointClosestPoint( srcSphereView, fClosestPoint );

  for( let i = 0; i < sClosestPoint.length; i++ )
  {
    dstPointView.eSet( i, sClosestPoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands an sphere with a frustum. Returns the expanded sphere.
  * Frustum remains unchanged.
  *
  * @param { Sphere } dstSphere - Destination sphere.
  * @param { Frustum } tstFrustum - Source frustum.
  *
  * @example
  * // returns [ 3, 0, 0, 3.3166247903554 ];
  * let frustum = _.Space.make( [ 4, 6 ] ).copy(
  *   [ 0,   0,   0,   0, - 1,   1,
  *     1, - 1,   0,   0,   0,   0,
  *     0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1 ] );
  * _.frustumExpand( [ 3, 0, 0, 1 ], frustum );
  *
  * @returns { Array } Returns an array with the expanded sphere dimensions.
  * @function frustumExpand
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstFrustum ) is not frustum.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function frustumExpand( dstSphere, srcFrustum )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dstSphereView = _.sphere._from( dstSphere );
  let center = _.sphere.centerGet( dstSphereView );
  let radius = _.sphere.radiusGet( dstSphereView );
  let dimS = _.sphere.dimGet( dstSphereView );

  if( _.sphere.frustumContains( dstSphereView, srcFrustum ) )
  return dstSphere;

  let points = _.frustum.cornersGet( srcFrustum );

  for( let i = 0 ; i < points.length ; i += 1 )
  {
    let point = points.colVectorGet( i );
    if( _.sphere.pointContains( dstSphereView, point ) === false )
    _.sphere.pointExpand( dstSphereView, point )

  }

  return dstSphere;
}

//

function lineIntersects( srcSphere, tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = _.sphere._from( srcSphere );
  let tstLineView = _.line._from( tstLine );

  let gotBool = _.line.sphereIntersects( tstLineView, srcSphereView );

  return gotBool;
}

//

function lineDistance( srcSphere , tstLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = _.sphere._from( srcSphere );
  let tstLineView = _.line._from( tstLine );

  let gotDist = _.line.sphereDistance( tstLineView, srcSphereView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a sphere to a line. Returns the calculated point.
  * Sphere and line remain unchanged
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } line - The source line.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let line = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.lineClosestPoint( [ 0, 0, 0, 1 ], line );
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * _.lineClosestPoint( [ 2, 0, 0, 1 ], line );
  *
  * @returns { Array } Returns the closest point to the line.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere
  * @throws { Error } An Error if ( line ) is not line
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */
function lineClosestPoint( sphere, line, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let lineView = _.line._from( line );
  let origin = _.line.originGet( lineView );
  let direction = _.line.directionGet( lineView );
  let dimLine  = _.line.dimGet( lineView );

  let srcSphereView = _.sphere._from( sphere );
  let dimSphere = _.sphere.dimGet( srcSphereView );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimSphere );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );


  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimSphere === dstPoint.length );
  _.assert( dimSphere === dimLine );

  if( _.line.sphereIntersects( lineView, srcSphereView ) )
  return 0
  else
  {
    let linePoint = _.line.sphereClosestPoint( line, srcSphereView );

    let spherePoint = _.vector.from( _.sphere.pointClosestPoint( srcSphereView, linePoint ) );

    for( let i = 0; i < dimSphere; i++ )
    {
      dstPointView.eSet( i, spherePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  * Check if a plane and a sphere intersect.
  * Sphere and plane remain unchanged.
  *
  * @param { Array } sphere - Source sphere
  * @param { Array } plane - Source plane
  *
  * @example
  * // returns true
  * _.planeIntersects( [ 0, 0, 0, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns false
  * _.planeIntersects( [ 0, 0, 0, 2 ], [ 1, 0, 0, 3 ] );
  *
  * @returns { Boolean } Returns true of they intersect, false if not.
  * @function planeIntersects
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the sphere and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function planeIntersects( sphere, plane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let sphereView = _.sphere._from( sphere );
  let planeView = _.plane._from( plane );

  let gotBool = _.plane.sphereIntersects( planeView, sphereView );

  return gotBool;
}

//

/**
  * Return the distance between a sphere and a plane.
  * Sphere and plane remain unchanged.
  *
  * @param { Array } sphere - Source sphere
  * @param { Array } plane - Source plane
  *
  * @example
  * // returns 0
  * _.planeDistance( [ 0, 0, 0, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns 1
  * _.planeDistance( [ 0, 0, 0, 2 ], [ 1, 0, 0, 3 ] );
  *
  * @returns { Array } Returns the calculated distance.
  * @function planeDistance
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the sphere and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function planeDistance( sphere, plane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let sphereView = _.sphere._from( sphere );
  let planeView = _.plane._from( plane );

  let distance = _.plane.sphereDistance( planeView, sphereView );

  return distance;
}

//

/**
  * Calculate the closest point in a sphere to a plane.
  * Sphere and plane remain unchanged.
  *
  * @param { Array } sphere - Source sphere
  * @param { Array } plane - Source plane
  * @param { Array } dstPoint - Destination point
  *
  * @example
  * // returns 0
  * _.planeClosestPoint( [ 0, 0, 0, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns [ -2, 0, 0 ]
  * _.planeClosestPoint( [ 0, 0, 0, 2 ], [ 1, 0, 0, 3 ] );
  *
  * @returns { Array } Returns the calculated point.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the sphere and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function planeClosestPoint( sphere, plane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dim = _.sphere.dimGet( sphereView );

  let planeView = _.plane._from( plane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let dimP = _.plane.dimGet( planeView );

  _.assert( dim === dimP );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( dim === dstPoint.length );

  let dstPointView = _.vector.from( dstPoint );

  if( _.plane.sphereIntersects( planeView, sphereView ) )
  return 0;

  debugger;
  // throw _.err( 'not tested' );

  let planePoint = _.plane.pointCoplanarGet( planeView, center );
  let spherePoint = _.sphere.pointClosestPoint( sphereView, planePoint );

  for ( let i = 0; i < spherePoint.length; i++ )
  {
    dstPointView.eSet( i, spherePoint[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands a sphere with a plane equation.
  * Plane remains unchanged.
  *
  * @param { Array } dstSphere - Destination sphere
  * @param { Array } srcPlane - Source plane
  *
  * @example
  * // returns [ 0, 0, 0, 2 ]
  * _.planeExpand( [ 0, 0, 0, 2 ], [ 1, 0, 0, 1 ] );
  *
  * @example
  * // returns [ 0, 0, 0, 3 ]
  * _.planeExpand( [ 0, 0, 0, 2 ], [ 1, 0, 0, 3 ] );
  *
  * @returns { Array } Returns the expanded sphere.
  * @function planeExpand
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the sphere and the plane don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function planeExpand( dstSphere, srcPlane )
{
  _.assert( arguments.length === 2 , 'Expects two arguments' );

  let sphereView = _.sphere._from( dstSphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dim = _.sphere.dimGet( sphereView );

  _.assert( _.plane.is( srcPlane ) );

  let planeView = _.plane._from( srcPlane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let dimP = _.plane.dimGet( planeView );

  _.assert( dim === dimP );

  if( _.plane.sphereIntersects( planeView, sphereView ) )
  return dstSphere;

  debugger;
  // throw _.err( 'not tested' );

  let planePoint = _.plane.pointCoplanarGet( planeView, center );
  _.sphere.pointExpand( sphereView, planePoint );

  return dstSphere;
}

//

function rayIntersects( srcSphere, tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = _.sphere._from( srcSphere );
  let tstRayView = _.ray._from( tstRay );

  let gotBool = _.ray.sphereIntersects( tstRayView, srcSphereView );

  return gotBool;
}

//

function rayDistance( srcSphere , tstRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = _.sphere._from( srcSphere );
  let tstRayView = _.ray._from( tstRay );

  let gotDist = _.ray.sphereDistance( tstRayView, srcSphereView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a sphere to a ray. Returns the calculated point.
  * Sphere and ray remain unchanged
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } ray - The source ray.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let ray = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.rayClosestPoint( [ 0, 0, 0, 1 ], ray );
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * _.rayClosestPoint( [ 2, 0, 0, 1 ], ray );
  *
  * @returns { Array } Returns the closest point to the ray.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere
  * @throws { Error } An Error if ( ray ) is not ray
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */
function rayClosestPoint( sphere, ray, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let rayView = _.ray._from( ray );
  let origin = _.ray.originGet( rayView );
  let direction = _.ray.directionGet( rayView );
  let dimRay  = _.ray.dimGet( rayView );

  let srcSphereView = _.sphere._from( sphere );
  let dimSphere = _.sphere.dimGet( srcSphereView );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimSphere );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );


  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimSphere === dstPoint.length );
  _.assert( dimSphere === dimRay );

  if( _.ray.sphereIntersects( rayView, srcSphereView ) )
  return 0
  else
  {
    let rayPoint = _.ray.sphereClosestPoint( ray, srcSphereView );

    let spherePoint = _.vector.from( _.sphere.pointClosestPoint( srcSphereView, rayPoint ) );

    for( let i = 0; i < dimSphere; i++ )
    {
      dstPointView.eSet( i, spherePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

function segmentIntersects( srcSphere, tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = _.sphere._from( srcSphere );
  let tstSegmentView = _.segment._from( tstSegment );

  let gotBool = _.segment.sphereIntersects( tstSegmentView, srcSphereView );

  return gotBool;
}

//

function segmentDistance( srcSphere , tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcSphereView = _.sphere._from( srcSphere );
  let tstSegmentView = _.segment._from( tstSegment );

  let gotDist = _.segment.sphereDistance( tstSegmentView, srcSphereView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a sphere to a segment. Returns the calculated point.
  * Sphere and segment remain unchanged
  *
  * @param { Array } sphere - The source sphere.
  * @param { Array } segment - The source segment.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * let segment = [ 0, 0, 0, - 1, - 1, - 1 ]
  * _.segmentClosestPoint( [ 0, 0, 0, 1 ], segment );
  *
  * @example
  * // returns [ 1, 0, 0 ]
  * _.segmentClosestPoint( [ 2, 0, 0, 1 ], segment );
  *
  * @returns { Array } Returns the closest point to the segment.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( sphere ) is not sphere
  * @throws { Error } An Error if ( segment ) is not segment
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */
function segmentClosestPoint( sphere, segment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let segmentView = _.segment._from( segment );
  let origin = _.segment.originGet( segmentView );
  let direction = _.segment.directionGet( segmentView );
  let dimSegment  = _.segment.dimGet( segmentView );

  let srcSphereView = _.sphere._from( sphere );
  let dimSphere = _.sphere.dimGet( srcSphereView );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimSphere );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );


  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimSphere === dstPoint.length );
  _.assert( dimSphere === dimSegment );

  if( _.segment.sphereIntersects( segmentView, srcSphereView ) )
  return 0
  else
  {
    let segmentPoint = _.segment.sphereClosestPoint( segment, srcSphereView );

    let spherePoint = _.vector.from( _.sphere.pointClosestPoint( srcSphereView, segmentPoint ) );

    for( let i = 0; i < dimSphere; i++ )
    {
      dstPointView.eSet( i, spherePoint.eGet( i ) );
    }

    return dstPoint;
  }
}

//

/**
  *Check if the source sphere contains test sphere. Returns true if it is contained, false if not.
  * Spheres are stored in Array data structure and remain unchanged
  *
  * @param { Array } srcSphere - The source sphere (container).
  * @param { Array } tstSphere - The tested sphere (the sphere to check if it is contained in srcSphere).
  *
  * @example
  * // returns true
  * _.sphereContains( [ 0, 0, 0, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns false
  * _.sphereContains( [ 0, 0, 0, 2 ], [ 0, 0, 1, 2.5 ] );
  *
  * @returns { Boolean } Returns true if the sphere is contained and false if not.
  * @function sphereContains
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) ( The two spheres don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function sphereContains( srcSphere, tstSphere )
{

  let _srcSphere = _.sphere._from( srcSphere );
  let srcCenter = _.sphere.centerGet( _srcSphere );
  let srcRadius = _.sphere.radiusGet( _srcSphere );
  let srcDim = _.sphere.dimGet( _srcSphere );

  let _tstSphere = _.sphere._from( tstSphere );
  let tstCenter = _.sphere.centerGet( _tstSphere );
  let tstRadius = _.sphere.radiusGet( _tstSphere );
  let tstDim = _.sphere.dimGet( _tstSphere );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcDim === tstDim );
  debugger;
  // throw _.err( 'not tested' );

  let d = _.sphere.pointDistance( _srcSphere, tstCenter ) + tstRadius;
  if( d <= srcRadius )
  return true;
  else
  return false;
}

//

/**
  * Returns true if the two spheres intersect. Spheres remain unchanged.
  *
  * @param { Array } sphere one
  * @param { Array } sphere two
  *
  * @example
  * // returns true
  * _.sphereIntersects( [ - 1, 0, 0, 2 ], [ 1, 0, 0, 2 ] );
  *
  * @example
  * // returns false
  * _.sphereIntersects( [ - 2, 0, 0, 1 ], [ 2, 0, 0, 1 ] );
  *
  * @returns { Boolean } Returns true if the two spheres intersect and false if not.
  * @function sphereIntersects
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the two spheres have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function sphereIntersects( sphere1, sphere2 )
{

  let sphereView1 = _.sphere._from( sphere1 );
  let center1 = _.sphere.centerGet( sphereView1 );
  let radius1 = _.sphere.radiusGet( sphereView1 );
  let dim1 = _.sphere.dimGet( sphereView1 );

  let sphereView2 = _.sphere._from( sphere2 );
  let center2 = _.sphere.centerGet( sphereView2 );
  let radius2 = _.sphere.radiusGet( sphereView2 );
  let dim2 = _.sphere.dimGet( sphereView2 );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dim1 === dim2 );
  debugger;
  // throw _.err( 'not tested' );

  let r = radius1 + radius2;
  return _.vector.distanceSqr( center1,center2 ) <= r*r;
}

//

/**
  * Calculates the distance between two spheres. Returns the distance value, 0 if they intersect.
  * Spheres are stored in Array data structure and remain unchanged.
  *
  * @param { Array } srcSphere - The source sphere.
  * @param { Array } tstSphere - The tested sphere (the sphere to calculate the distance to).
  *
  * @example
  * // returns 0
  * _.sphereDistance( [ 0, 0, 0, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns 1
  * _.sphereDistance( [ 0, 0, 0, 2 ], [ 0, 0, 4, 1 ] );
  *
  * @returns { Number } Returns the calculated distance.
  * @function sphereDistance
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) ( The two spheres don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSphere ) is not sphere
  * @throws { Error } An Error if ( tstSphere ) is not sphere
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function sphereDistance( srcSphere, tstSphere )
{

  let _srcSphere = _.sphere._from( srcSphere );
  let srcCenter = _.sphere.centerGet( _srcSphere );
  let srcRadius = _.sphere.radiusGet( _srcSphere );
  let srcDim = _.sphere.dimGet( _srcSphere );

  let _tstSphere = _.sphere._from( tstSphere );
  let tstCenter = _.sphere.centerGet( _tstSphere );
  let tstRadius = _.sphere.radiusGet( _tstSphere );
  let tstDim = _.sphere.dimGet( _tstSphere );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcDim === tstDim );
  debugger;
  // throw _.err( 'not tested' );

  if( _.sphere.sphereIntersects( srcSphere, tstSphere ) )
  return 0;

  let distance = _.vector.distance( srcCenter, tstCenter ) - tstRadius - srcRadius;

  return distance;
}

//

/**
  * Calculates the closest point in a sphere to another sphere. Returns the calculated point.
  * Spheres are stored in Array data structure and remain unchanged.
  *
  * @param { Array } srcSphere - The source sphere.
  * @param { Array } tstSphere - The test sphere.
  * @param { Array } dstPoint - The destination point.
  *
  * @example
  * // returns 0
  * _.sphereClosestPoint( [ 0, 0, 0, 2 ], [ 0.5, 0.5, 1, 1 ] );
  *
  * @example
  * // returns [ 0, 0, 2 ]
  * _.sphereClosestPoint( [ 0, 0, 0, 2 ], [ 0, 0, 4, 1 ] );
  *
  * @returns { Array } Returns the calculated point.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( dim ) is different than dimGet( sphere ) ( The two spheres don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( tstSphere ) is not sphere.
  * @throws { Error } An Error if ( dstPoint ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function sphereClosestPoint( srcSphere, tstSphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let _srcSphere = _.sphere._from( srcSphere );
  let srcCenter = _.sphere.centerGet( _srcSphere );
  let srcRadius = _.sphere.radiusGet( _srcSphere );
  let srcDim = _.sphere.dimGet( _srcSphere );

  let _tstSphere = _.sphere._from( tstSphere );
  let tstCenter = _.sphere.centerGet( _tstSphere );
  let tstRadius = _.sphere.radiusGet( _tstSphere );
  let tstDim = _.sphere.dimGet( _tstSphere );

  _.assert( srcDim === tstDim );

  debugger;
  // throw _.err( 'not tested' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcDim );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  _.assert( srcDim === dstPoint.length );
  let dstPointv = _.vector.from( dstPoint );

  if( _.sphere.sphereIntersects( srcSphere, tstSphere ) )
  return 0;

  let point = _.sphere.pointClosestPoint( _srcSphere, tstCenter );

  for( let i = 0; i < point.length; i++ )
  {
    dstPointv.eSet( i, point[ i ] );
  }

  return dstPoint;
}

//

/**
  * Expands an sphere with a second sphere. Returns an array with the corrdinates of the expanded sphere
  *
  * @param { Array } sphereDst - Destination sphere.
  * @param { Array } sphereSrc - Source Sphere.
  *
  * @example
  * // returns [ 0, 0, 0, 3 ]
  * _.sphereExpand( [ 0, 0, 0, 2 ], [ 0, 0, 0, 3 ] );
  *
  * @returns { Array } Returns an array with the coordinates of the expanded sphere.
  * @function sphereExpand
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the two spheres have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @memberof module:Tools/math/Concepts.wTools.sphere
  */

function sphereExpand( sphereDst, sphereSrc )
{

  let sphereViewDst = _.sphere._from( sphereDst );
  let centerDst = _.sphere.centerGet( sphereViewDst );
  let radiusDst = _.sphere.radiusGet( sphereViewDst );
  let dimDst = _.sphere.dimGet( sphereViewDst );

  _.assert( _.sphere.is( sphereSrc ) );

  let sphereViewSrc = _.sphere._from( sphereSrc );
  let centerSrc = _.sphere.centerGet( sphereViewSrc );
  let radiusSrc = _.sphere.radiusGet( sphereViewSrc );
  let dimSrc = _.sphere.dimGet( sphereViewSrc );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dimDst === dimSrc );

  if( radiusSrc === -Infinity )
  {
    return sphereDst;
  }

  if( radiusDst === -Infinity )
  {
    sphereViewDst.copy( sphereViewSrc );
    return sphereDst;
  }

  let distance = _.vector.distance( centerDst,centerSrc );
  if( radiusDst < distance+radiusSrc )
  {
    //if( distance > 0 )
    //_.vector.mix( centerDst, centerSrc, 0.5 + ( radiusSrc-radiusDst ) / ( distance*2 ) );

    //if( distance > 0 )
    //_.sphere.radiusSet( sphereViewDst,( distance+radiusSrc+radiusDst ) / 2 );
    _.sphere.radiusSet( sphereViewDst,( distance + radiusSrc ) );
    //else
    //_.sphere.radiusSet( sphereViewDst,Math.max( radiusDst,radiusSrc ) );

  }

  return sphereDst;
}

//

function matrixHomogenousApply( sphere,matrix )
{

  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dim = _.sphere.dimGet( sphereView );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.spaceIs( matrix ) );
  _.assert( dim+1 === matrix.ncol );

  matrix.matrixHomogenousApply( center );
  _.sphere.radiusSet( sphereView,radius * matrix.scaleMaxGet() )

  return sphere;
}

//

function translate( sphere,offset )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.spaceIs( matrix ) );
  debugger;
  throw _.err( 'not tested' );

  let sphereView = _.sphere._from( sphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dim = _.sphere.dimGet( sphereView );

  debugger;

  center.add( offset );

  return sphere;
}

// --
// declare
// --

let Proto =
{

  make : make,
  makeZero : makeZero,
  makeNil : makeNil,

  zero : zero,
  nil : nil,
  centeredOfRadius : centeredOfRadius,

  toStr : toStr,

  from : from,
  _from : _from,
  fromPoints : fromPoints,
  fromBox : fromBox,
  fromCenterAndRadius : fromCenterAndRadius,

  is : is,
  isEmpty : isEmpty,
  isZero : isZero,
  isNil : isNil,

  dimGet : dimGet,
  centerGet : centerGet,
  radiusGet : radiusGet,
  radiusSet : radiusSet,

  pointContains : pointContains,
  pointDistance : pointDistance,
  pointClosestPoint : pointClosestPoint,
  // pointClosestPoint : pointClosestPoint, /* qqq : implement me - Already implemented - to test */
  pointExpand : pointExpand,

  boxContains : boxContains, /* qqq : implement me */
  boxIntersects : boxIntersects,
  boxDistance : boxDistance, /* qqq : implement me - Same as _.box.sphereDistance */
  boxClosestPoint : boxClosestPoint, /* qqq : implement me */
  boxExpand : boxExpand,
  boundingBoxGet : boundingBoxGet,

  capsuleIntersects : capsuleIntersects,
  capsuleDistance : capsuleDistance,
  capsuleClosestPoint : capsuleClosestPoint,

  frustumContains : frustumContains, /* qqq : implement me */
  frustumIntersects : frustumIntersects, /* qqq : implement me - Same as _.frustum.sphereIntersects */
  frustumDistance : frustumDistance, /* qqq : implement me */
  frustumClosestPoint : frustumClosestPoint, /* qqq : implement me */
  frustumExpand : frustumExpand, /* qqq : implement me */

  lineIntersects : lineIntersects, /* Same as _.line.sphereIntersects */
  lineDistance : lineDistance,  /* Same as _.line.sphereDistance */
  lineClosestPoint : lineClosestPoint,

  planeIntersects : planeIntersects, /* qqq : implement me - Same as _.plane.sphereIntersects */
  planeDistance : planeDistance, /* qqq : implement me - Same as _.plane.sphereDistance */
  planeClosestPoint : planeClosestPoint, /* qqq : implement me */
  planeExpand : planeExpand, /* qqq : implement me */

  rayIntersects : rayIntersects, /* Same as _.ray.sphereIntersects */
  rayDistance : rayDistance,  /* Same as _.ray.sphereDistance */
  rayClosestPoint : rayClosestPoint,

  segmentIntersects : segmentIntersects, /* Same as _.segment.sphereIntersects */
  segmentDistance : segmentDistance,  /* Same as _.segment.sphereDistance */
  segmentClosestPoint : segmentClosestPoint,

  sphereContains : sphereContains, /* qqq : implement me */
  sphereIntersects : sphereIntersects,
  sphereDistance : sphereDistance, /* qqq : implement me */
  sphereClosestPoint : sphereClosestPoint, /* qqq : implement me */
  sphereExpand : sphereExpand,

  matrixHomogenousApply : matrixHomogenousApply,
  translate : translate,

}

_.mapSupplement( Self,Proto );

//

if( typeof module !== 'undefined' )
{
  // require( './Box.s' );
}

})();
