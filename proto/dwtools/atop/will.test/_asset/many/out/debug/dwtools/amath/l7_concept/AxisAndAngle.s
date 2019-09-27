(function _AxisAndAngle_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let pi = Math.PI;
let sin = Math.sin;
let cos = Math.cos;
let atan2 = Math.atan2;
let asin = Math.asin;
let acos = Math.acos;
let abs = Math.abs;
let sqr = _.sqr;
let sqrt = _.sqrt;

_.assert( !_.axisAndAngle );
_.assert( _.objectIs( _.avector ) );

/**
 * @namespace "wTools.axisAndAngle"
 * @memberof module:Tools/math/Concepts
 */

let Self = _.axisAndAngle = _.axisAndAngle || Object.create( _.avector );

/*

  An AxisAndAngle element represents a rotation around a direction vector of a certain magnitude.

  For the following functions, Axis Angles must have the shape [ dir1, dir2, dir3, angle ],
where dir1, dir2 and dir3 are the coordinates of the axis of the rotations,
and angle corresponds to the rotation magnitude.

*/

// --
//
// --

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle 
 * @param {Array} angle 
 * @function is
 * @memberof module:Tools/math/Concepts.wTools.axisAndAngle
 */

function is( axisAndAngle,angle )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( !_.longIs( axisAndAngle ) && !_.vectorIs( axisAndAngle ) )
  return false;

  return ( ( axisAndAngle.length === 4 ) && ( angle === undefined ) ) || ( ( axisAndAngle.length === 3 ) && ( _.numberIs( angle ) ) );
}

//

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle 
 * @param {Array} angle 
 * @function like
 * @memberof module:Tools/math/Concepts.wTools.axisAndAngle
 */

function like( axisAndAngle,angle )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( angle !== null && angle !== undefined && !_.numberIs( angle ) )
  return false;

  if( axisAndAngle === null )
  return true;

  if( !_.longIs( axisAndAngle ) && !_.vectorIs( axisAndAngle ) )
  return false;

  return ( ( axisAndAngle.length === 4 ) && ( angle === undefined ) ) || ( ( axisAndAngle.length === 3 ) && ( _.numberIs( angle ) || angle === null ) );
}

//

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle 
 * @param {Array} angle 
 * @function isZero
 * @memberof module:Tools/math/Concepts.wTools.axisAndAngle
 */

function isZero( axisAndAngle,angle )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( !this.is( axisAndAngle,angle ) )
  return false;

  if( axisAndAngle && axisAndAngle.length === 3 )
  return angle === 0;

  if( _.vectorIs( axisAndAngle ) )
  return axisAndAngle.eGet( 3 ) === 0;
  else if( _.arrayIs( axisAndAngle ) )
  return axisAndAngle[ 3 ] === 0;
  else _.assert( 0 );
}

//

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle 
 * @param {Array} angle 
 * @function make
 * @memberof module:Tools/math/Concepts.wTools.axisAndAngle
 */

function make( axisAndAngle,angle )
{
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( axisAndAngle === undefined || axisAndAngle === null || _.axisAndAngle.is( axisAndAngle,angle ) );

  let result = _.axisAndAngle.makeZero();
  let resultv = _.vector.from( result );

  let axisAndAnglev;
  if( axisAndAngle )
  axisAndAnglev = _.vector.from( axisAndAngle );

  if( axisAndAnglev )
  {
    resultv.eSet( 0,axisAndAnglev.eGet( 0 ) );
    resultv.eSet( 1,axisAndAnglev.eGet( 1 ) );
    resultv.eSet( 2,axisAndAnglev.eGet( 2 ) );
  }

  if( _.numberIs( angle ) )
  resultv.eSet( 3,angle );
  else if( axisAndAnglev )
  resultv.eSet( 3,axisAndAnglev.eGet( 3 ) );

  return result;
}

//

/**
 * @descriptionNeeded
 * @function makeZero
 * @memberof module:Tools/math/Concepts.wTools.axisAndAngle
 */

function makeZero()
{
  _.assert( arguments.length === 0 );
  let result = _.dup( 0,4 );
  return result;
}

//

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle 
 * @param {Array} angle 
 * @function from
 * @memberof module:Tools/math/Concepts.wTools.axisAndAngle
 */

function from( axisAndAngle,angle )
{

  _.assert( axisAndAngle === null || _.axisAndAngle.like( axisAndAngle,angle ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( axisAndAngle === null )
  return _.axisAndAngle.make( axisAndAngle,angle );

  if( _.vectorIs( axisAndAngle ) )
  {
    if( axisAndAngle.length === 4 )
    {
      if( angle !== undefined && angle !== null )
      axisAndAngle.eSet( 3 , angle );
      return axisAndAngle;
    }
    debugger;
    let result = axisAndAngle.resizedArray( 0,4 );
    if( angle !== undefined && angle !== null )
    result[ 3 ] = angle;
    return result;
  }
  else
  {
    if( axisAndAngle.length === 3 )
    {
      axisAndAngle = _.arrayResize( axisAndAngle,0,4 );
      axisAndAngle[ 3 ] = angle === null ? 0 : angle;
    }
  }

  return axisAndAngle;
}

//

function _from( axisAndAngle,angle )
{

  _.assert( axisAndAngle === null || _.axisAndAngle.like( axisAndAngle,angle ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( axisAndAngle === null )
  {
    axisAndAngle = _.axisAndAngle.make( axisAndAngle,angle );
  }
  else if( _.vectorIs( axisAndAngle ) )
  {
    if( axisAndAngle.length === 4 )
    {
      if( angle !== undefined && angle !== null )
      axisAndAngle.eSet( 3 , angle );
      return axisAndAngle;
    }
    debugger;
    let result = axisAndAngle.resizedVector( 0,4 );
    if( angle !== undefined && angle !== null )
    result.eSet( 3 , angle );
    return result;
  }
  else
  {
    if( axisAndAngle.length === 3 )
    {
      axisAndAngle = _.arrayResize( axisAndAngle,0,4 );
      axisAndAngle[ 3 ] = angle === null ? 0 : angle;
    }
  }

  return _.vector.fromArray( axisAndAngle );
}

// {
//   _.assert( axisAndAngle === null || _.axisAndAngle.like( axisAndAngle,angle ) );
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   if( axisAndAngle === null )
//   axisAndAngle = _.axisAndAngle.make( axisAndAngle,angle );
//
//   if( _.vectorIs( axisAndAngle ) )
//   {
//     debugger;
//     throw _.err( 'not implemented' );
//     let result = axisAndAngle.slice( 0,4 );
//     if( angle !== undefined )
//     result[ 3 ] = angle;
//     return result;
//   }
//   else
//   {
//     if( axisAndAngle.length === 3 )
//     {
//       axisAndAngle = _.arrayResize( axisAndAngle,0,4 );
//       axisAndAngle[ 3 ] = angle;
//     }
//   }
//
//   return _.vector.from( axisAndAngle );
// }

//

/**
 * @descriptionNeeded
 * @param {Array} axisAndAngle 
 * @param {Array} angle 
 * @function zero
 * @memberof module:Tools/math/Concepts.wTools.axisAndAngle
 */

function zero( axisAndAngle,angle )
{

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( axisAndAngle === undefined || axisAndAngle === null || _.axisAndAngle.is( axisAndAngle,angle ) );

  if( axisAndAngle === undefined || axisAndAngle === null )
  return _.axisAndAngle.makeZero();

  let axisAndAnglev = _.vector.from( axisAndAngle );

  axisAndAnglev.eSet( 3,0 );

  return axisAndAngle;
}

//

/**
  * Create an axis and angle rotation from a matrix rotation. Returns the created AxisAndAngle.
  * Matrix rotation stays unchanged.
  *
  * @param { Array } srcMatrix - Source matrix rotation.
  * @param { Array } axisAndAngle - Destination rotation axis and angle.
  *
  * @example
  * // returns [ 0.6520678, 0.38680106, 0.6520678, 0.92713394 ]
  * let srcMatrix = _.Space.make([ 3, 3 ]).copy
  * ([
  *   0.7701511383, -0.4207354784, 0.479425549507,
  *   0.6224468350, 0.65995573997, - 0.420735478401,
  *   - 0.13938128948, 0.622446835, 0.7701511383
  * ]);
  * _.fromMatrixRotation( [ 0, 0, 0, 0 ], srcMatrix );
  *
  * @returns { Array } Returns the corresponding axis and angle.
  * @function fromMatrixRotation
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( srcMatrix ) is not a rotation matrix.
  * @throws { Error } An Error if( axisAndAngle ) is not axis and angle.
  * @memberof module:Tools/math/Concepts.wTools.axisAndAngle
  */

function fromMatrixRotation( axisAndAngle, srcMatrix )
{

  _.assert( arguments.length === 2, 'Expects two arguments' );
  _.assert( axisAndAngle.length === 4 );
  _.assert( _.Space.is( srcMatrix ) );
  _.assert( srcMatrix.hasShape([ 3, 3 ]) );


  let quat = _.quat.fromMatrixRotation( [ 0, 0, 0, 0 ], srcMatrix );
  axisAndAngle = _.quat.toAxisAndAngle( quat, axisAndAngle );

  return axisAndAngle;

}

//

/**
  * Create a matrix rotation from an axis and angle rotation. Returns the created matrix.
  * Axis Angle stays unchanged.
  *
  * @param { Array } dstMatrix - Destination matrix rotation.
  * @param { Array } axisAndAngle - Source rotation axis and angle.
  *
  * @example
  * // returns
  * ([
  *   0.7701511383, -0.4207354784, 0.479425549507,
  *   0.6224468350, 0.65995573997, - 0.420735478401,
  *   - 0.13938128948, 0.622446835, 0.7701511383
  * ]);
  * _.toMatrixRotation( [ 0.6520678, 0.38680106, 0.6520678, 0.92713394 ], srcMatrix );
  *
  * @returns { Space } Returns the corresponding matrix rotation.
  * @function toMatrixRotation
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( dstMatrix ) is not matrix.
  * @throws { Error } An Error if( axisAndAngle ) is not axis and angle.
  * @memberof module:Tools/math/Concepts.wTools.axisAndAngle
  */

function toMatrixRotation( axisAndAngle, dstMatrix )
{

  _.assert( arguments.length === 2, 'Expects two arguments' );
  _.assert( axisAndAngle.length === 4 );
  _.assert( _.Space.is( dstMatrix ) );
  _.assert( dstMatrix.hasShape([ 3, 3 ]) );

  let quat = _.quat.fromAxisAndAngle( [ 0, 0, 0, 0 ], axisAndAngle );
  dstMatrix = _.quat.toMatrix( quat, dstMatrix );

  return dstMatrix;

}

// --
// declare
// --

let Proto =
{

  is : is,
  like : like,
  isZero : isZero,

  make : make,
  makeZero : makeZero,

  from : from,
  _from : _from,

  zero : zero,

  fromMatrixRotation : fromMatrixRotation,
  toMatrixRotation : toMatrixRotation,

}

_.mapExtend( Self,Proto );

})();
