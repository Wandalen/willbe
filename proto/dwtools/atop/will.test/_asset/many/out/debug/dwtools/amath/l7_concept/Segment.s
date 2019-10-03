(function _Segment_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let Self = _.segment = _.segment || Object.create( null );

/**
 * @description
 * A segment is a finite line, starting at an origin and finishing at an end point.
 *
 * For the following functions, segments must have the shape [ startX, startY, startZ, endX, endY, endZ ],
 * where the dimension equals the object´s length divided by two.
 *
 * Moreover, startX, startY and startZ are the coordinates of the origin of the segment,
 * and endX, endY and endZ the coordinates of the end of the segment.
 * @namespace "wTools.segment"
 * @memberof module:Tools/math/Concepts 
 */

/*

  A segment is a finite line, starting at an origin and finishing at an end point.

  For the following functions, segments must have the shape [ startX, startY, startZ, endX, endY, endZ ],
where the dimension equals the object´s length divided by two.

  Moreover, startX, startY and startZ are the coordinates of the origin of the segment,
and endX, endY and endZ the coordinates of the end of the segment.

*/
// --
//
// --
//


function make( dim )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let result = _.segment.makeZero( dim );
  if( _.segment.is( dim ) )
  _.avector.assign( result,dim );
  return result;
}

//

function makeZero( dim )
{
  if( _.segment.is( dim ) )
  dim = _.segment.dimGet( dim );
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
  if( _.segment.is( dim ) )
  dim = _.segment.dimGet( dim );
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

function zero( segment )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.segment.is( segment ) )
  {
    let segmentView = _.segment._from( segment );
    segmentView.assign( 0 );
    return segment;
  }

  return _.segment.makeZero( segment );
}

//

function nil( segment )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.segment.is( segment ) )
  {
    let segmentView = _.segment._from( segment );
    let min = _.segment.originGet( segmentView );
    let max = _.segment.endPointGet( segmentView );

    _.vector.assign( min, +Infinity );
    _.vector.assign( max, -Infinity );

    return segment;
  }

  return _.segment.makeNil( segment );
}

//

function from( segment )
{
//  if( _.objectIs( segment ) )
//  {
//    _.assertMapHasFields( segment,{ min : 'min' , max : 'max' } );
//    segment = _.arrayAppendArray( [],[ segment.min,segment.max ] );
//  }

  _.assert( _.segment.is( segment ) || segment === null );
  _.assert( arguments.length === 1, 'Expects single argument' );

//  if( _.vectorAdapterIs( segment ) )
//  {
//    debugger;
//    throw _.err( 'not implemented' );
//    return segment.slice();
//  }

  if( segment === null )
  return _.segment.make();

  return segment;
}

//

function _from( segment )
{
  _.assert( _.segment.is( segment ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return _.vector.from( segment );
}

//

/**
  * Check if input is a segment. Returns true if it is a segment and false if not.
  *
  * @param { Vector } segment - Source segment.
  *
  * @example
  * // returns true;
  * _.is( [ 0, 0, 1, 1 ] );
  *
  * @returns { Boolean } Returns true if the input is segment.
  * @function is
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function is( segment )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( segment ) || _.vectorAdapterIs( segment ) ) && ( segment.length >= 0 ) && ( segment.length % 2 === 0 );
}

//

/**
  * Get segment dimension. Returns the dimension of the segment. segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns 2
  * _.dimGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns 1
  * _.dimGet( [ 0, 1 ] );
  *
  * @returns { Number } Returns the dimension of the segment.
  * @function dimGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function dimGet( segment )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.segment.is( segment ) );
  return segment.length / 2;
}

//

/**
  * Get the origin of a segment. Returns a vector with the coordinates of the origin of the segment.
  * segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns   0, 0
  * _.originGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  1
  * _.originGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the coordinates of the origin of the segment.
  * @function originGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function originGet( segment )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let segmentView = _.segment._from( segment );
  return segmentView.subarray( 0, segment.length/ 2 );
}

//

/**
  * Get the end point of a segment. Returns a vector with the coordinates of the final point of the segment.
  * Segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns   2, 2
  * _.endPointGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  2
  * _.endPointGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the final point of the segment.
  * @function endPointGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function endPointGet( segment )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let segmentView = _.segment._from( segment );
  return segmentView.subarray( segment.length/ 2, segment.length );
}

//

/**
  * Get the direction of a segment. Returns a vector with the coordinates of the direction of the segment.
  * Segment stays untouched.
  *
  * @param { Vector } segment - The source segment.
  *
  * @example
  * // returns   2, 2
  * _.directionGet( [ 0, 0, 2, 2 ] );
  *
  * @example
  * // returns  2
  * _.directionGet( [ 1, 2 ] );
  *
  * @returns { Vector } Returns the direction of the segment.
  * @function directionGet
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( segment ) is not segment.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function directionGet( segment )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let segmentView = _.segment._from( segment );
  let origin = _.segment.originGet( segment );
  let endPoint = _.segment.endPointGet( segment );
  let dim = _.segment.dimGet( segmentView );
  let direction = _.vector.from( _.array.makeArrayOfLength( dim ) );

  for( var i = 0; i < dim; i++ )
  {
    direction.eSet( i, endPoint.eGet( i ) - origin.eGet( i ) );
  }

  return direction;
}

//

/**
  * Get a point in a segment. Returns a vector with the coordinates of the point of the segment.
  * Segment and factor stay untouched.
  *
  * @param { Vector } srcSegment - The source segment.
  * @param { Vector } factor - The source factor.
  *
  * @example
  * // returns   1, 1
  * _.segmentAt( [ 0, 0, 2, 2 ], 0.5 );
  *
  * @example
  * // returns  1
  * _.segmentAt( [ 1, 2 ], 0 );
  *
  * @returns { Vector } Returns a point in the segment at a given factor.
  * @function segmentAt
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( factor ) is not number.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function segmentAt( srcSegment, factor )
{
  // let result = avector.mul( null, srcSegment[ 1 ], factor );
  // avector.add( result, srcSegment[ 0 ] );

  _.assert( arguments.length === 2, 'Expects single argument' );
  _.assert( _.segment.is( srcSegment ) );

  _.assert( factor >= 0, 'Factor can not be negative ( point must be in the segment )');
  _.assert( factor <= 1, 'Factor can not be bigger than one ( point must be in the segment )');

  let segmentView = _.segment._from( srcSegment )
  let origin = _.segment.originGet( segmentView );
  let direction = _.segment.directionGet( segmentView );

  let result = avector.mul( null, direction, factor );
  result = avector.add( result, origin );

  return result;
}

segmentAt.shaderChunk =
`
  vec2 segmentAt( vec2 srcSegment[ 2 ], float factor )
  {

    vec2 result = srcSegment[ 1 ]*factor;
    result += srcSegment[ 0 ];

    return result;
  }
`

//

/**
* Get the factor of a point inside a segment. Returs the calculated factor. Point and segment stay untouched.
*
* @param { Array } srcSegment - The source segment.
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
* @returns { Number } Returns the factor if the point is inside the segment, and false if the point is outside it.
* @function getFactor
* @throws { Error } An Error if ( dim ) is different than point.length (segment and point have not the same dimension).
* @throws { Error } An Error if ( arguments.length ) is different than two.
* @throws { Error } An Error if ( srcSegment ) is not segment.
* @throws { Error } An Error if ( srcPoint ) is not point.
* @memberof module:Tools/math/Concepts.wTools.segment
*/
function getFactor( srcSegment, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcPoint.length );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimension  = _.segment.dimGet( srcSegmentView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );
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

  // Factor can not be negative
  if(  factor <= 0 - _.accuracySqr || factor >= 1 + _.accuracySqr )
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
      if(  factor <= 0 - _.accuracySqr || factor >= 1 + _.accuracySqr )
      return false;
    }
  }

  return factor;
}

//

/**
  * Check if two segments are parallel. Returns true if they are parallel and false if not.
  * Segments and accuracySqr stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  * @param { Vector } accuracySqr - The accuracy.
  *
  * @example
  * // returns   true
  * _.segmentParallel( [ 0, 0, 0, 2, 2, 2 ], [ 1, 2, 1, 3, 4, 3 ] );
  *
  * @example
  * // returns  false
  * _.segmentParallel( [ 1, 2, 1, 1, 1, 2 ], [ 1, 2, 1, 1, 3, 3 ] );
  *
  * @returns { Boolean } Returns true if the segments are parallel.
  * @function segmentParallel
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @throws { Error } An Error if ( accuracySqr ) is not number.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function segmentParallel( src1Segment, src2Segment, accuracySqr )
{
  _.assert( _.segment.is( src1Segment ) );
  _.assert( _.segment.is( src2Segment ) );
  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( src1Segment.length === src2Segment.length );

  if( arguments.length === 2 || accuracySqr === undefined || accuracySqr === null )
  accuracySqr = _.accuracySqr;;

  let direction1 = _.segment.directionGet( src1Segment );
  let direction2 = _.segment.directionGet( src2Segment );
  let proportion = undefined;

  let zeros1 = 0;                               // Check if Segment1 is a point
  for( let i = 0; i < direction1.length ; i++  )
  {
    if( direction1.eGet( i ) === 0 )
    {
      zeros1 = zeros1 + 1;
    }
    if( zeros1 === direction1.length )
    return true;
  }

  let zeros2 = 0;                               // Check if Segment2 is a point
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
  * Returns the factors for the intersection of two segments. Returns a vector with the intersection factors, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionFactors( [ 0, 0, 2, 2 ], [ 3, 3, 4, 4 ] );
  *
  * @example
  * // returns  _.vector.from( [ 2/3, 0.5 ] )
  * _.segmentIntersectionFactors( [ - 2, 0, 1, 0 ], [ 0, - 2, 0, 2 ] );
  *
  * @returns { Array } Returns the factors for the two segments intersection.
  * @function segmentIntersectionFactors
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function segmentIntersectionFactors( srcSegment1, srcSegment2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( srcSegment1.length === srcSegment2.length,'The two segments must have the same dimension' );

  let srcSegment1View = _.segment._from( srcSegment1.slice() );
  let srcSegment2View = _.segment._from( srcSegment2.slice() );

  let origin1 = _.segment.originGet( srcSegment1View );
  let origin2 = _.segment.originGet( srcSegment2View );
  let end1 = _.segment.endPointGet( srcSegment1View );
  let end2 = _.segment.endPointGet( srcSegment2View );

  let dOrigin = _.vector.from( avector.subVectors( origin2.clone(), origin1 ) );
  let direction1 = _.segment.directionGet( srcSegment1View );
  let direction2 = _.segment.directionGet( srcSegment2View );

  let directions = _.Space.make( [ srcSegment1.length / 2 , 2 ] );
  directions.colVectorGet( 0 ).copy( direction1 );
  directions.colVectorGet( 1 ).copy( direction2.clone().mulScalar( - 1 ) );

  // Same origin
  let identOrigin = 0;
  let identEnd = 0;
  let origin1End2 = 0;
  let end1Origin2 = 0;
  for( let i = 0; i < origin1.length; i++ )
  {
    if( origin1.eGet( i ) === origin2.eGet( i ) )
    identOrigin = identOrigin + 1;

    if( origin1.eGet( i ) === end2.eGet( i ) )
    origin1End2 = origin1End2 + 1;

    if( end1.eGet( i ) === origin2.eGet( i ) )
    end1Origin2 = end1Origin2 + 1;

    if( end1.eGet( i ) === end2.eGet( i ) )
    identEnd = identEnd + 1;
  }

  if( identOrigin === origin1.length )
  return _.vector.from( [ 0, 0 ] );

  else if( origin1End2 === origin1.length )
  return _.vector.from( [ 0, 1 ] );

  else if( end1Origin2 === origin1.length )
  return _.vector.from( [ 1, 0 ] );

  else if( identEnd === origin1.length )
  return _.vector.from( [ 1, 1 ] );

  // Parallel segments
  if( segmentParallel( srcSegment1, srcSegment2 ) === true )
  {
    if( _.segment.pointContains( srcSegment1, origin2 ) )
    {
      return _.vector.from( [ _.segment.getFactor( srcSegment1, origin2), 0 ] );
    }
    else if( _.segment.pointContains( srcSegment2, origin1 ) )
    {
      return _.vector.from( [  0, _.segment.getFactor( srcSegment2, origin1) ] );
    }
    else
    {
      return 0;
    }
  }

  let result = _.vector.from( [ 0, 0 ] );
  let oldResult = _.vector.from( [ 0, 0 ] );
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

    result = _.vector.from( x.base );

    let point1 = _.vector.from( _.array.makeArrayOfLength( dOrigin.length ) );
    let point2 = _.vector.from( _.array.makeArrayOfLength( dOrigin.length ) );
    let equal = 0;
    for( var j = 0; j < dOrigin.length; j++ )
    {
      point1.eSet( j, origin1.eGet( j ) + direction1.eGet( j )*result.eGet( 0 ) )
      point2.eSet( j, origin2.eGet( j ) + direction2.eGet( j )*result.eGet( 1 ) )

      if( point1.eGet( j ) + 1E-6 >= point2.eGet( j ) && point2.eGet( j ) >= point1.eGet( j ) - 1E-6 )
      {
        equal = equal + 1;
      }
    }

    let result0 = result.eGet( 0 ) >= 0 - _.accuracySqr && result.eGet( 0 ) <= 1 + _.accuracySqr;
    let result1 = result.eGet( 1 ) >= 0 - _.accuracySqr && result.eGet( 1 ) <= 1 + _.accuracySqr;
    if( equal === dOrigin.length && result0 && result1 )
    return result;
  }

  return 0;
}

//

/**
  * Returns the points of the intersection of two segments. Returns an array with the intersection points, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionPoints( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ], [ 0, 0 ] ]
  * _.segmentIntersectionPoints( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the points of intersection of the two segments.
  * @function segmentIntersectionPoints
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function segmentIntersectionPoints( srcSegment1, srcSegment2 )
{
  let factors = segmentIntersectionFactors( srcSegment1, srcSegment2 );
  if( factors === 0 )
  return 0;

  let factorsView = _.vector.from( factors );
  let result = [ Self.segmentAt( srcSegment1, factorsView.eGet( 0 ) ), Self.segmentAt( srcSegment2, factorsView.eGet( 1 ) ) ];
  return result;
}

segmentIntersectionPoints.shaderChunk =
`
  void segmentIntersectionPoints( out vec2 result[ 2 ], vec2 srcSegment1[ 2 ], vec2 srcSegment2[ 2 ] )
  {

    vec2 factors = segmentIntersectionFactors( srcSegment1,srcSegment2 );
    result[ 0 ] = segmentAt( srcSegment1,factors[ 0 ] );
    result[ 1 ] = segmentAt( srcSegment2,factors[ 1 ] );

  }
`

//

/**
  * Returns the point of the intersection of two segments. Returns an array with the intersection point, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionPoint( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ] ]
  * _.segmentIntersectionPoint( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two segments.
  * @function segmentIntersectionPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function segmentIntersectionPoint( srcSegment1,srcSegment2 )
{

  let factors = Self.segmentIntersectionFactors( srcSegment1,srcSegment2 );

  if( factors === 0 )
  return 0;

  return Self.segmentAt( srcSegment1, factors.eGet( 0 ) );

}

segmentIntersectionPoint.shaderChunk =
`
  vec2 segmentIntersectionPoint( vec2 srcSegment1[ 2 ], vec2 srcSegment2[ 2 ] )
  {

    vec2 factors = segmentIntersectionFactors( srcSegment1,srcSegment2 );
    return segmentAt( srcSegment1,factors[ 0 ] );

  }
`

//

/**
  * Returns the point of the intersection of two segments. Returns an array with the intersection point, 0 if there is no intersection.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   0
  * _.segmentIntersectionPointAccurate( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  [ [ 0, 0 ] ]
  * _.segmentIntersectionPointAccurate( [ -3, 0, 1, 0 ], [ 0, -2, 0, 1 ] );
  *
  * @returns { Array } Returns the point of intersection of the two segments.
  * @function segmentIntersectionPointAccurate
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function segmentIntersectionPointAccurate( srcSegment1, srcSegment2 )
{

  let closestPoints = Self.segmentIntersectionPoints( srcSegment1, srcSegment2 );
  debugger;

  if( closestPoints === 0 )
  return 0;

  return _.avector.mulScalar( _.avector.add( null, closestPoints[ 0 ], closestPoints[ 1 ] ), 0.5 );

}

segmentIntersectionPointAccurate.shaderChunk =
`
  vec2 segmentIntersectionPointAccurate( vec2 srcSegment1[ 2 ], vec2 srcSegment2[ 2 ] )
  {

    vec2 closestPoints[ 2 ];
    segmentIntersectionPoints( closestPoints,srcSegment1,srcSegment2 );
    return ( closestPoints[ 0 ] + closestPoints[ 1 ] ) * 0.5;

  }
`
//

/**
  * Make a segment out of two points. Returns the created segment.
  * Points stay untouched.
  *
  * @param { Array } pair - The source points.
  *
  * @example
  * // returns [ 0, 0, 1, 1 ]
  * _.fromPair( [ [ 0, 0 ], [ 1, 1 ] ] );
  *
  * @returns { Segment } Returns the segment defined by the source points.
  * @function fromPair
  * @throws { Error } An Error if ( arguments.length ) is different than one.
  * @throws { Error } An Error if ( pair ) is not array of points.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function fromPair( pair )
{
    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assert( pair.length === 2, 'Expects two points' );
    _.assert( pair[ 0 ].length === pair[ 1 ].length, 'Expects two points' );

    let result = _.vector.from( _.array.makeArrayOfLength( pair[ 0 ].length * 2 ) );
    let pair0 = _.vector.from( pair[ 0 ] );
    let pair1 = _.vector.from( pair[ 1 ] );

    for( let i = 0; i < pair0.length ; i++ )
    {
      result.eSet( i, pair0.eGet( i ) );
      result.eSet( pair0.length + i, pair1.eGet( i ) );
    }

    debugger;
    return result;
}

//

/**
  * Check if a given point is contained inside a segment. Returs true if it is contained, false if not.
  * Point and segment stay untouched.
  *
  * @param { Array } srcSegment - The source segment.
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
  * @returns { Boolen } Returns true if the point is inside the segment, and false if the point is outside it.
  * @function pointContains
  * @throws { Error } An Error if ( dim ) is different than point.length (segment and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function pointContains( srcSegment, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcPoint.length );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimension  = _.segment.dimGet( srcSegmentView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );

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

  // Factor can not be negative or superior to one
  if(  factor <= 0 - _.accuracySqr || factor >= 1 + _.accuracySqr )
  {
    return false;
  }

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

      if( Math.abs( newFactor - factor ) > _.accuracySqr && direction.eGet( i - 1 ) !== 0 )
      {
        return false;
      }
      factor = newFactor;

      // Factor can not be negative or superior to one
      if(  factor <= 0 - _.accuracySqr || factor >= 1 + _.accuracySqr )
      return false;
    }
  }

  return true;
}

//

/**
  * Get the distance between a point and a segment. Returs the calculated distance. Point and segment stay untouched.
  *
  * @param { Array } srcSegment - The source segment.
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
  * @returns { Boolen } Returns the distance between the point and the segment.
  * @function pointDistance
  * @throws { Error } An Error if ( dim ) is different than point.length (segment and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function pointDistance( srcSegment, srcPoint )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcPoint.length );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimension  = _.segment.dimGet( srcSegmentView )
  let srcPointView = _.vector.from( srcPoint.slice() );

  _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );

  if( _.segment.pointContains( srcSegmentView, srcPointView ) )
  {
    return 0;
  }
  else
  {
    let projection = _.segment.pointClosestPoint( srcSegmentView, srcPointView );
    let factor = _.segment.getFactor( srcSegmentView, projection );

    let dPoints = _.vector.from( avector.subVectors( srcPointView, projection ) );
    debugger;
    let mod = _.vector.dot( dPoints, dPoints );
    mod = Math.sqrt( mod );

    return mod;

  }
}

/**
  * Get the closest point between a point and a segment. Returs the calculated point. srcPoint and segment stay untouched.
  *
  * @param { Array } srcSegment - The source segment.
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
  * @returns { Boolen } Returns the closest point in a segment to a point.
  * @function pointClosestPoint
  * @throws { Error } An Error if ( dim ) is different than point.length (segment and point have not the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPoint ) is not point.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function pointClosestPoint( srcSegment, srcPoint, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcPoint.length );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcPoint.length );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let end = _.segment.endPointGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimension  = _.segment.dimGet( srcSegmentView )
  let srcPointView = _.vector.from( srcPoint.slice() );
  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimension === srcPoint.length, 'The segment and the point must have the same dimension' );

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
  else if( _.segment.pointContains( srcSegmentView, srcPointView ) )
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
    else if( factor > 1 )
    {
      pointVector = _.vector.from( end );
    }
    else
    {
      pointVector = _.vector.from( _.segment.segmentAt( srcSegmentView, factor ) );
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
  * Check if a segment and a box intersect. Returns true if they intersect and false if not.
  * The box and the segment remain unchanged. Only for 1D to 3D
  *
  * @param { Array } srcSegment - Source segment.
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
  * @returns { Boolean } Returns true if the segment and the box intersect.
  * @function boxIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the segment and box don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function boxIntersects( srcSegment, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcBox.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let end = _.segment.endPointGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  let boxView = _.box._from( srcBox );
  let dimBox = _.box.dimGet( boxView );
  let min = _.vector.from( _.box.cornerLeftGet( boxView ) );
  let max = _.vector.from( _.box.cornerRightGet( boxView ) );

  _.assert( dimSegment === dimBox );

  if( _.box.pointContains( boxView, origin ) || _.box.pointContains( boxView, end ) )
  return true;

  /* box corners */
  let c = _.box.cornersGet( boxView );

  for( let j = 0 ; j < _.Space.dimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colVectorGet( j );
    let projection = _.segment.pointClosestPoint( srcSegmentView, corner );

    if( _.box.pointContains( boxView, projection ) )
    return true;
  }

  return false;

}

//

/**
  * Get the distance between a segment and a box. Returns the calculated distance.
  * The box and the segment remain unchanged. Only for 1D to 3D
  *
  * @param { Array } srcSegment - Source segment.
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
  * @returns { Number } Returns the distance between the segment and the box.
  * @function boxDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the segment and box don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function boxDistance( srcSegment, srcBox )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcBox.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  let boxView = _.box._from( srcBox );
  let dimBox = _.box.dimGet( boxView );
  let min = _.vector.from( _.box.cornerLeftGet( boxView ) );
  let max = _.vector.from( _.box.cornerRightGet( boxView ) );

  _.assert( dimSegment === dimBox );

  if( _.segment.boxIntersects( srcSegmentView, boxView ) )
  return 0;

  let closestPoint = _.segment.boxClosestPoint( srcSegmentView, boxView );
  return _.box.pointDistance( boxView, closestPoint );
}

//

/**
  * Get the closest point in a segment to a box. Returns the calculated point.
  * The box and the segment remain unchanged. Only for 1D to 3D
  *
  * @param { Array } srcSegment - Source segment.
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
  * @returns { Number } Returns the closest point in the segment to the box.
  * @function boxClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcBox ) is not box.
  * @throws { Error } An Error if ( dim ) is different than box.dimGet (the segment and box don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function boxClosestPoint( srcSegment, srcBox, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcBox.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcBox.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  let boxView = _.box._from( srcBox );
  let dimBox = _.box.dimGet( boxView );
  let min = _.vector.from( _.box.cornerLeftGet( boxView ) );
  let max = _.vector.from( _.box.cornerRightGet( boxView ) );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( dimSegment === dimBox );

  if( _.segment.boxIntersects( srcSegmentView, boxView ) )
  return 0;

  /* box corners */
  let c = _.box.cornersGet( boxView );

  let distance = _.box.pointDistance( boxView, origin );
  let d = 0;
  let pointView = _.vector.from( origin );

  for( let j = 0 ; j < _.Space.dimsOf( c )[ 1 ] ; j++ )
  {
    let corner = c.colVectorGet( j );
    d = Math.abs( _.segment.pointDistance( srcSegmentView, corner ) );
    if( d < distance )
    {
      distance = d;
      pointView = _.segment.pointClosestPoint( srcSegmentView, corner );
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
  * Get the bounding box of a segment. Returns destination box.
  * Segment and box are stored in Array data structure. Source segment stays untouched.
  *
  * @param { Array } dstBox - destination box.
  * @param { Array } srcSegment - source segment for the bounding box.
  *
  * @example
  * // returns [ - 2, - 2, - 2, 2, 2, 2 ]
  * _.boundingBoxGet( null, [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding box.
  * @function boundingBoxGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(segment) (the segment and the box don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstBox ) is not box
  * @throws { Error } An Error if ( srcSegment ) is not segment
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function boundingBoxGet( dstBox, srcSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let endPoint = _.segment.endPointGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  if( dstBox === null || dstBox === undefined )
  dstBox = _.box.makeNil( dimSegment );

  _.assert( _.box.is( dstBox ) );
  let dimB = _.box.dimGet( dstBox );

  _.assert( dimSegment === dimB );

  let boxView = _.box._from( dstBox );
  let box = _.box._from( _.box.fromPoints( null, [ origin, endPoint ] ) );

  for( let b = 0; b < boxView.length; b++ )
  {
    boxView.eSet( b, box.eGet( b ) );
  }

  return dstBox;
}

//

function capsuleIntersects( srcSegment , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = _.capsule._from( tstCapsule );
  let segmentView = _.segment._from( srcSegment );

  let gotBool = _.capsule.segmentIntersects( tstCapsuleView, segmentView );
  return gotBool;
}

//

function capsuleDistance( srcSegment , tstCapsule )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let tstCapsuleView = _.capsule._from( tstCapsule );
  let segmentView = _.segment._from( srcSegment );

  let gotDist = _.capsule.segmentDistance( tstCapsuleView, segmentView );

  return gotDist;
}

//

/**
  * Calculates the closest point in a segment to a capsule. Returns the calculated point.
  * Segment and capsule remain unchanged
  *
  * @param { Array } segment - The source segment.
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
  * @throws { Error } An Error if ( segment ) is not segment
  * @throws { Error } An Error if ( capsule ) is not capsule
  * @throws { Error } An Error if ( dstPoint ) is not point
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function capsuleClosestPoint( segment, capsule, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );

  let segmentView = _.segment._from( segment );
  let dimS = _.segment.dimGet( segmentView );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( dimS );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Null or undefined dstPoint is not allowed' );

  let capsuleView = _.capsule._from( capsule );
  let dimCapsule  = _.capsule.dimGet( capsuleView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimS === dstPoint.length );
  _.assert( dimS === dimCapsule );

  if( _.capsule.segmentIntersects( capsuleView, segmentView ) )
  return 0
  else
  {
    let capsulePoint = _.capsule.segmentClosestPoint( capsule, segmentView );

    let segmentPoint = _.vector.from( _.segment.pointClosestPoint( segmentView, capsulePoint ) );

    for( let i = 0; i < dimS; i++ )
    {
      dstPointView.eSet( i, segmentPoint.eGet( i ) );
    }

    return dstPoint;
  }

}

//

/**
  * Check if a segment and a frustum intersect. Returns true if they intersect and false if not.
  * The frustum and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
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
  * @returns { Boolean } Returns true if the segment and the frustum intersect.
  * @function frustumIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the segment and frustum don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function frustumIntersects( srcSegment, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Space.dimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( srcSegment === null )
  srcSegment = _.segment.make( rows - 1 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView );

  _.assert( dimSegment === rows - 1 );

  if( _.frustum.pointContains( srcFrustum, origin ) )
  return true;

  /* frustum corners */
  let corners = _.frustum.cornersGet( srcFrustum );
  let cornersLength = _.Space.dimsOf( corners )[ 1 ];

  for( let j = 0 ; j < cornersLength ; j++ )
  {
    let corner = corners.colVectorGet( j );
    let projection = _.segment.pointClosestPoint( srcSegmentView, corner );

    if( _.frustum.pointContains( srcFrustum, projection ) )
    return true;
  }

  return false;

}

//

/**
  * Get the distance between a segment and a frustum. Returns the calculated distance.
  * The frustum and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 0;
  * var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumDistance( [ 0, 0, 0, 2, 2, 2 ] , srcFrustum );
  *
  * @example
  * // returns 1;
  * _.frustumDistance( [ 0, - 1, 0, 0, -2, 0 ] , srcFrustum );
  *
  * @returns { Number } Returns the distance between a segment and a frustum.
  * @function frustumDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the segment and frustum don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function frustumDistance( srcSegment, srcFrustum )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.frustum.is( srcFrustum ) );

  let dimFrustum = _.Space.dimsOf( srcFrustum ) ;
  let rows = dimFrustum[ 0 ];
  let cols = dimFrustum[ 1 ];

  if( srcSegment === null )
  srcSegment = _.segment.make( srcFrustum.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView );

  _.assert( dimSegment === rows - 1 );

  if( _.segment.frustumIntersects( srcSegmentView, srcFrustum ) )
  return 0;

  let closestPoint = _.segment.frustumClosestPoint( srcSegmentView, srcFrustum );

  return _.frustum.pointDistance( srcFrustum, closestPoint );
}

//

/**
  * Get the closest point in a segment to a frustum. Returns the calculated point.
  * The frustum and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcFrustum - Source frustum.
  *
  * @example
  * // returns 0;
  * var srcFrustum =  _.Space.make( [ 4, 6 ] ).copy
  * ([
  *   0,   0,   0,   0, - 1,   1,
  *   1, - 1,   0,   0,   0,   0,
  *   0,   0,   1, - 1,   0,   0,
  *   - 1,   0, - 1,   0,   0, - 1
  * ]);
  * _.frustumClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , srcFrustum );
  *
  * @example
  * // returns [ 0, - 1, 0 ];
  * _.frustumClosestPoint( [ 0, - 1, 0, 0, -2, 0 ] , srcFrustum );
  *
  * @returns { Array } Returns the closest point in the segment to the frustum.
  * @function frustumClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcFrustum ) is not frustum.
  * @throws { Error } An Error if ( dim ) is different than frustum.dimGet (the segment and frustum don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function frustumClosestPoint( srcSegment, srcFrustum, dstPoint )
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

  if( srcSegment === null )
  srcSegment = _.segment.make( srcFrustum.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( dimSegment === rows - 1 );

  if( _.segment.frustumIntersects( srcSegmentView, srcFrustum ) )
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
    d = Math.abs( _.segment.pointDistance( srcSegmentView, corner ) );
    if( d < distance )
    {
      distance = d;
      pointView = _.segment.pointClosestPoint( srcSegmentView, corner );
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
  * Check if a segment and a line intersect. Returns true if they intersect and false if not.
  * The line and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcLine - Source line.
  *
  * @example
  * // returns true;
  * var srcLine =  [ -1, -1, -1, 1, 1, 1 ]
  * var srcSegment = [ 0, 0, 0, 2, 2, 2 ]
  * _.lineIntersects( srcSegment, srcLine );
  *
  * @example
  * // returns false;
  * var srcLine =  [ -1, -1, -1, 0, 0, 1 ]
  * var srcSegment = [ 0, 1, 0, 2, 2, 2 ]
  * _.lineIntersects( srcSegment, srcLine );
  *
  * @returns { Boolean } Returns true if the segment and the line intersect.
  * @function lineIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( dim ) is different than line.dimGet (the segment and line don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function lineIntersects( srcSegment, srcLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcLineView = _.line._from( srcLine );
  let lineOrigin = _.line.originGet( srcLineView );
  let lineDirection = _.line.directionGet( srcLineView );
  let dimLine  = _.line.dimGet( srcLineView );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcLine.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let segmentOrigin = _.segment.originGet( srcSegmentView );
  let segmentEnd = _.segment.endPointGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView );

  _.assert( dimSegment === dimLine );

  let lineSegment = _.line.fromPair( [ segmentOrigin, segmentEnd ] );
  if( _.line.lineParallel( lineSegment, srcLineView ) )
  {
    if( _.line.pointContains( srcLineView, segmentOrigin ) )
    return true;
    else
    return false;
  }
  let factors = _.line.lineIntersectionFactors( lineSegment, srcLineView );

  if( factors === 0 || factors.eGet( 0 ) < 0 || factors.eGet( 0 ) > 1 )
  return false;

  return true;
}

//

/**
  * Get the distance between a line and a segment. Returns the calculated distance.
  * The segment and the line remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcLine - Test line.
  *
  * @example
  * // returns 0;
  * _.lineDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 8 );
  * _.lineDistance( [ 0, 0, 0, 0, -2, 0 ] , [ 2, 2, 2, 0, 0, 1 ]);
  *
  * @returns { Number } Returns the distance between a segment and a line.
  * @function lineDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( dim ) is different than line.dimGet (the segment and line don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function lineDistance( srcSegment, srcLine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcLine.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let srcOrigin = _.segment.originGet( srcSegmentView );
  let srcEnd = _.segment.endPointGet( srcSegmentView );
  let srcDirection = _.segment.directionGet( srcSegmentView );
  let srcDim  = _.segment.dimGet( srcSegmentView )

  let srcLineView = _.line._from( srcLine );
  let lineOrigin = _.line.originGet( srcLineView );
  let lineDirection = _.line.directionGet( srcLineView );
  let lineDim  = _.line.dimGet( srcLineView );

  _.assert( srcDim === lineDim );

  let distance;

  if( _.segment.lineIntersects( srcSegmentView, srcLineView ) === true )
  return 0;

  // Parallel segment/line
  let lineSegment = _.line.fromPair( [ srcOrigin, srcEnd ] );
  if( _.line.lineParallel( lineSegment, srcLineView ) )
  {
    // Line is point
    let lineIsPoint = 0;
    for( let i = 0; i < lineDim; i++ )
    {
      if( lineDirection.eGet( i ) === 0 )
      lineIsPoint = lineIsPoint + 1;
    }

    if( lineIsPoint === lineDim )
    {
      distance = _.segment.pointDistance( srcSegmentView, lineOrigin );
    }
    else
    {
      distance = _.line.pointDistance( srcLineView, srcOrigin );
    }
  }
  else
  {
    let srcPoint = _.segment.lineClosestPoint( srcSegmentView, srcLineView );
    let tstPoint = _.line.segmentClosestPoint( srcLineView, srcSegmentView );
    distance = _.avector.distance( srcPoint, tstPoint );
  }

  return distance;
}

//

/**
  * Get the closest point in a segment to a line. Returns the calculated point.
  * The segment and line remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcLine - Test line.
  *
  * @example
  * // returns 0;
  * _.lineClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.lineClosestPoint( [ 0, 0, 0, 0, 1, 0 ] , [ 1, 0, 0, 1, 0, 0 ]);
  *
  * @returns { Array } Returns the closest point in the srcSegment to the srcLine.
  * @function lineClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcLine ) is not line.
  * @throws { Error } An Error if ( dim ) is different than line.dimGet (the segment and line don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function lineClosestPoint( srcSegment, srcLine, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcLine.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcLine.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let srcOrigin = _.segment.originGet( srcSegmentView );
  let srcEnd = _.segment.endPointGet( srcSegmentView );
  let srcDir = _.segment.directionGet( srcSegmentView );
  let srcDim  = _.segment.dimGet( srcSegmentView );

  let srcLineView = _.line._from( srcLine );
  let lineOrigin = _.line.originGet( srcLineView );
  let tstDir = _.line.directionGet( srcLineView );
  let lineDim = _.line.dimGet( srcLineView );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( srcDim === lineDim );

  let pointView;

  // Same origin - line is point
  let identOrigin = 0;
  let linePoint = 0;
  for( let i = 0; i < srcOrigin.length; i++ )
  {
    if( srcOrigin.eGet( i ) === lineOrigin.eGet( i ) )
    identOrigin = identOrigin + 1;

    if( tstDir.eGet( i ) === 0 )
    linePoint = linePoint + 1;
  }
  if( identOrigin === srcOrigin.length )
  {
    pointView = srcOrigin;
  }
  else if( linePoint === srcOrigin.length )
  {
    pointView = _.segment.pointClosestPoint( srcSegmentView, lineOrigin );
  }
  else
  {
    let lineSegment = _.line.fromPair( [ srcOrigin, srcEnd ] );
    // Parallel segments
    if( _.line.lineParallel( lineSegment, srcLineView ) )
    {
      pointView = _.segment.pointClosestPoint( srcSegmentView, lineOrigin );
    }
    else
    {
      let srcMod = _.vector.dot( srcDir, srcDir );
      let tstMod = _.vector.dot( tstDir, tstDir );
      let mod = _.vector.dot( srcDir, tstDir );
      let dOrigin = _.vector.from( avector.subVectors( lineOrigin.slice(), srcOrigin ) );

      if( tstMod*srcMod - mod*mod === 0 )
      {
          pointView = srcOrigin;
      }
      else
      {
        let factor = ( - mod*_.vector.dot( tstDir, dOrigin ) + tstMod*_.vector.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );
        if( factor < 0 )
        {
          pointView = srcOrigin;
        }
        else if( factor > 1 )
        {
          pointView = srcEnd;
        }
        else
        {
          pointView = _.segment.segmentAt( srcSegmentView, factor );
        }
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
  * Check if a segment and a plane intersect. Returns true if they intersect and false if not.
  * The plane and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
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
  * @returns { Boolean } Returns true if the segment and the plane intersect.
  * @function planeIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the segment and plane don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function planeIntersects( srcSegment, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcPlane.length - 1 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  let planeView = _.plane._from( srcPlane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let dimPlane = _.plane.dimGet( planeView );

  _.assert( dimSegment === dimPlane );

  if( _.plane.pointContains( planeView, origin ) )
  return true;

  let dirDotNormal = _.vector.dot( direction, normal );

  if( dirDotNormal !== 0 )
  {
    let originDotNormal = _.vector.dot( origin, normal );
    let factor = - ( originDotNormal + bias ) / dirDotNormal;

    if( factor >= 0 && factor <= 1 )
    {
      return true;
    }
  }
  return false;
}

//

/**
  * Get the distance between a segment and a plane. Returns the calculated distance.
  * The plane and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
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
  * @returns { Number } Returns the distance between the segment and the plane.
  * @function planeDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the segment and plane don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function planeDistance( srcSegment, srcPlane )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcPlane.length - 1 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let end = _.segment.endPointGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  let planeView = _.plane._from( srcPlane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let dimPlane = _.plane.dimGet( planeView );

  _.assert( dimSegment === dimPlane );

  if( _.segment.planeIntersects( srcSegmentView, planeView ) )
  return 0;

  let d1 = Math.abs( _.plane.pointDistance( planeView, origin ) );
  let d2 = Math.abs( _.plane.pointDistance( planeView, end ) );

  if( d1 < d2 )
  {
    return d1;
  }
  else
  {
    return d2;
  }
}

//

/**
  * Get the closest point between a segment and a plane. Returns the calculated point.
  * The plane and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
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
  * @returns { Array } Returns the closest point in the segment to the plane.
  * @function planeClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcPlane ) is not plane.
  * @throws { Error } An Error if ( dim ) is different than plane.dimGet (the segment and plane don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function planeClosestPoint( srcSegment, srcPlane, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcPlane.length - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcPlane.length - 1 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let end = _.segment.endPointGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  let planeView = _.plane._from( srcPlane );
  let normal = _.plane.normalGet( planeView );
  let bias = _.plane.biasGet( planeView );
  let dimPlane = _.plane.dimGet( planeView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimSegment === dimPlane );

  if( _.segment.planeIntersects( srcSegmentView, planeView ) )
  return 0;

  let point;
  let d1 = Math.abs( _.plane.pointDistance( planeView, origin ) ) ;
  let d2 = Math.abs( _.plane.pointDistance( planeView, end ) );

  if( d1 <= d2 )
  {
    point = _.vector.from( origin );
  }
  else
  {
    point = _.vector.from( end );
  }
  for( let i = 0; i < point.length; i++ )
  {
    dstPointView.eSet( i, point.eGet( i ) );
  }


  return dstPoint;
}

//

/**
  * Check if a segment and a ray intersect. Returns true if they intersect and false if not.
  * The ray and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcRay - Source ray.
  *
  * @example
  * // returns true;
  * var srcRay =  [ -1, -1, -1, 1, 1, 1 ]
  * var srcSegment = [ 0, 0, 0, 2, 2, 2 ]
  * _.rayIntersects( srcSegment, srcRay );
  *
  * @example
  * // returns false;
  * var srcRay =  [ -1, -1, -1, 0, 0, 1 ]
  * var srcSegment = [ 0, 1, 0, 2, 2, 2 ]
  * _.rayIntersects( srcSegment, srcRay );
  *
  * @returns { Boolean } Returns true if the segment and the ray intersect.
  * @function rayIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the segment and ray don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function rayIntersects( srcSegment, srcRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcRayView = _.ray._from( srcRay );
  let rayOrigin = _.ray.originGet( srcRayView );
  let rayDirection = _.ray.directionGet( srcRayView );
  let dimRay  = _.ray.dimGet( srcRayView );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcRay.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let segmentOrigin = _.segment.originGet( srcSegmentView );
  let segmentEnd = _.segment.endPointGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView );

  _.assert( dimSegment === dimRay );

  let lineSegment = _.line.fromPair( [ segmentOrigin, segmentEnd ] );

  if( _.line.lineParallel( lineSegment, srcRayView ) )
  {
    if( _.ray.pointContains( srcRayView, segmentOrigin ) )
    return true;
    else
    return false;
  }

  let factors = _.ray.rayIntersectionFactors( lineSegment, srcRayView );
  logger.log( 'FACTORS', factors)
  if( factors === 0 || factors.eGet( 0 ) < 0 || factors.eGet( 1 ) < 0 || ( factors.eGet( 0 ) > 1 && factors.eGet( 1 ) > 1 ) )
  return false;

  if( factors.eGet( 0 ) > 1 )
  {
    let point = _.segment.segmentAt( srcSegmentView, factors.eGet( 1 ) );
    let contained = _.ray.pointContains( srcRayView, point );

    if( contained === false )
    return false;
  }
  else if( factors.eGet( 1 ) > 1 )
  {
    let point = _.segment.segmentAt( srcSegmentView, factors.eGet( 0 ) );
    let contained = _.ray.pointContains( srcRayView, point );

    if( contained === false )
    return false;
  }

  return true;
}

//

/**
  * Get the distance between a ray and a segment. Returns the calculated distance.
  * The segment and the ray remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcRay - Test ray.
  *
  * @example
  * // returns 0;
  * _.rayDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 12 );
  * _.rayDistance( [ 0, 0, 0, 0, -2, 0 ] , [ 2, 2, 2, 0, 0, 1 ]);
  *
  * @returns { Number } Returns the distance between a segment and a ray.
  * @function rayDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the segment and ray don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function rayDistance( srcSegment, srcRay )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcRay.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let srcOrigin = _.segment.originGet( srcSegmentView );
  let srcEnd = _.segment.endPointGet( srcSegmentView );
  let srcDirection = _.segment.directionGet( srcSegmentView );
  let srcDim  = _.segment.dimGet( srcSegmentView )

  let srcRayView = _.ray._from( srcRay );
  let rayOrigin = _.ray.originGet( srcRayView );
  let rayDirection = _.ray.directionGet( srcRayView );
  let rayDim  = _.ray.dimGet( srcRayView );

  _.assert( srcDim === rayDim );

  let distance;

  if( _.segment.rayIntersects( srcSegmentView, srcRayView ) === true )
  {
    return 0;
  }

  // Parallel segment/ray
  let lineSegment = _.line.fromPair( [ srcOrigin, srcEnd ] );
  if( _.line.lineParallel( lineSegment, srcRayView ) )
  {
    // Segment or ray is point
    let segIsPoint = 0;
    let rayIsPoint = 0;
    for( let i = 0; i < rayDim; i++ )
    {
      if( srcDirection.eGet( i ) === 0 )
      segIsPoint = segIsPoint + 1;

      if( rayDirection.eGet( i ) === 0 )
      rayIsPoint = rayIsPoint + 1;
    }
    if( segIsPoint === rayDim )
    {
      distance = _.ray.pointDistance( srcRayView, srcOrigin );
    }
    else if( rayIsPoint === rayDim )
    {
      distance = _.segment.pointDistance( srcSegmentView, rayOrigin );
    }
    else
    {
      //distance = _.segment.pointDistance( srcSegmentView, rayOrigin );
      distance = _.ray.pointDistance( srcRayView, srcOrigin );
      if(  _.ray.pointDistance( srcRayView, srcEnd ) < distance )
      distance =  _.ray.pointDistance( srcRayView, srcEnd );
    }
  }
  else
  {
    let srcPoint = _.segment.rayClosestPoint( srcSegmentView, srcRayView );
    let tstPoint = _.ray.segmentClosestPoint( srcRayView, srcSegmentView );

    distance = _.avector.distance( srcPoint, tstPoint );
  }

  return distance;
}

//

/**
  * Get the closest point in a segment to a ray. Returns the calculated point.
  * The segment and ray remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } srcRay - Test ray.
  *
  * @example
  * // returns 0;
  * _.rayClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.rayClosestPoint( [ 0, 0, 0, 0, 1, 0 ] , [ 1, 0, 0, 1, 0, 0 ]);
  *
  * @returns { Array } Returns the closest point in the srcSegment to the srcRay.
  * @function rayClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcRay ) is not ray.
  * @throws { Error } An Error if ( dim ) is different than ray.dimGet (the segment and ray don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function rayClosestPoint( srcSegment, srcRay, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcRay.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcRay.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let srcOrigin = _.segment.originGet( srcSegmentView );
  let srcEnd = _.segment.endPointGet( srcSegmentView );
  let srcDir = _.segment.directionGet( srcSegmentView );
  let srcDim  = _.segment.dimGet( srcSegmentView );

  let srcRayView = _.ray._from( srcRay );
  let rayOrigin = _.ray.originGet( srcRayView );
  let tstDir = _.ray.directionGet( srcRayView );
  let rayDim = _.ray.dimGet( srcRayView );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( srcDim === rayDim );

  let pointView;

  // Same origin - ray is point
  let identOrigin = 0;
  let rayPoint = 0;
  for( let i = 0; i < srcOrigin.length; i++ )
  {
    if( srcOrigin.eGet( i ) === rayOrigin.eGet( i ) )
    identOrigin = identOrigin + 1;

    if( tstDir.eGet( i ) === 0 )
    rayPoint = rayPoint + 1;
  }
  if( identOrigin === srcOrigin.length )
  {
    pointView = srcOrigin;
  }
  else if( rayPoint === srcOrigin.length )
  {
    pointView = _.segment.pointClosestPoint( srcSegmentView, rayOrigin );
  }
  else
  {
    let lineSegment = _.line.fromPair( [ srcOrigin, srcEnd ] );
    // Parallel segments
    if( _.line.lineParallel( lineSegment, srcRayView ) )
    {
      pointView = _.segment.pointClosestPoint( srcSegmentView, rayOrigin );
    }
    else
    {
      let srcMod = _.vector.dot( srcDir, srcDir );
      let tstMod = _.vector.dot( tstDir, tstDir );
      let mod = _.vector.dot( srcDir, tstDir );
      let dOrigin = _.vector.from( avector.subVectors( rayOrigin.slice(), srcOrigin ) );

      if( tstMod*srcMod - mod*mod === 0 )
      {
          pointView = srcOrigin;
      }
      else
      {
        let factor = ( - mod*_.vector.dot( tstDir, dOrigin ) + tstMod*_.vector.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );
        if( factor < 0 )
        {
          pointView = srcOrigin;
        }
        else if( factor > 1 )
        {
          pointView = srcEnd;
        }
        else
        {
          pointView = _.segment.segmentAt( srcSegmentView, factor );
        }
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
  * Check if two segments intersect. Returns true if they intersect, false if not.
  * Segments stay untouched.
  *
  * @param { Vector } src1Segment - The first source segment.
  * @param { Vector } src2Segment - The second source segment.
  *
  * @example
  * // returns   true
  * _.segmentIntersects( [ 0, 0, 2, 2 ], [ 1, 1, 4, 4 ] );
  *
  * @example
  * // returns  false
  * _.segmentIntersects( [ -3, 0, 1, 0 ], [ 0, -2, 1, 0 ] );
  *
  * @returns { Boolean } Returns true if the two segments intersect.
  * @function segmentIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( src1Segment ) is not segment.
  * @throws { Error } An Error if ( src2Segment ) is not segment.
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function segmentIntersects( srcSegment1, srcSegment2 )
{

  if( _.segment.segmentIntersectionFactors( srcSegment1, srcSegment2 ) === 0 )
  return false

  return true;
}

//

/**
  * Get the distance between two segments. Returns the calculated distance.
  * The segments remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } tstSegment - Test segment.
  *
  * @example
  * // returns 0;
  * _.segmentDistance( [ 0, 0, 0, 2, 2, 2 ], [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns Math.sqrt( 12 );
  * _.segmentDistance( [ 0, 0, 0, 0, -2, 0 ] , [ 2, 2, 2, 0, 0, 1 ]);
  *
  * @returns { Number } Returns the distance between two segments.
  * @function segmentDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( tstSegment ) is not segment.
  * @throws { Error } An Error if ( dim ) is different than segment.dimGet (the segments don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function segmentDistance( srcSegment, tstSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( srcSegment === null )
  srcSegment = _.segment.make( tstSegment.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let srcOrigin = _.segment.originGet( srcSegmentView );
  let srcDirection = _.segment.directionGet( srcSegmentView );
  let srcDim  = _.segment.dimGet( srcSegmentView )

  let tstSegmentView = _.segment._from( tstSegment );
  let tstOrigin = _.segment.originGet( tstSegmentView );
  let tstDirection = _.segment.directionGet( tstSegmentView );
  let tstDim  = _.segment.dimGet( tstSegmentView );

  _.assert( srcDim === tstDim );

  let distance;

  if( _.segment.segmentIntersects( srcSegmentView, tstSegmentView ) === true )
  return 0;
  // Parallel segments
  if( _.segment.segmentParallel( srcSegmentView, tstSegmentView ) )
  {
    let d1 = _.segment.pointDistance( srcSegmentView, tstOrigin );
    let d2 = _.segment.pointDistance( tstSegmentView, srcOrigin );
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
    let srcPoint = _.segment.segmentClosestPoint( srcSegmentView, tstSegmentView );
    let tstPoint = _.segment.segmentClosestPoint( tstSegmentView, srcSegmentView );
    distance = _.avector.distance( srcPoint, tstPoint );
  }


  return distance;
}

//

/**
  * Get the closest point in a segment to a segment. Returns the calculated point.
  * The segments remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
  * @param { Array } tstSegment - Test segment.
  *
  * @example
  * // returns 0;
  * _.segmentClosestPoint( [ 0, 0, 0, 2, 2, 2 ] , [ 0, 0, 0, 1, 1, 1 ]);
  *
  * @example
  * // returns [ 0, 0, 0 ];
  * _.segmentClosestPoint( [ 0, 0, 0, 0, 1, 0 ] , [ 1, 0, 0, 1, 0, 0 ]);
  *
  * @returns { Array } Returns the closest point in the srcSegment to the tstSegment.
  * @function segmentClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( tstSegment ) is not segment.
  * @throws { Error } An Error if ( dim ) is different than segment.dimGet (the segments don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function segmentClosestPoint( srcSegment, tstSegment, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( tstSegment.length / 2 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = _.segment.make( tstSegment.length / 2 );

  let srcSegmentView = _.segment._from( srcSegment );
  let srcOrigin = _.segment.originGet( srcSegmentView );
  let srcEnd = _.segment.endPointGet( srcSegmentView );
  let srcDir = _.segment.directionGet( srcSegmentView );
  let srcDim  = _.segment.dimGet( srcSegmentView );

  let tstSegmentView = _.segment._from( tstSegment );
  let tstOrigin = _.segment.originGet( tstSegmentView );
  let tstEnd = _.segment.endPointGet( tstSegmentView );
  let tstDir = _.segment.directionGet( tstSegmentView );
  let tstDim = _.segment.dimGet( tstSegmentView );

  let dstPointView = _.vector.from( dstPoint );
  _.assert( srcDim === tstDim );

  let pointView;


  if( _.segment.segmentIntersects( srcSegmentView, tstSegmentView ) )
  {
    pointView = _.segment.segmentIntersectionPoint( srcSegmentView, tstSegmentView );
  }
  else
  {
    // Parallel segments
    if( _.segment.segmentParallel( srcSegmentView, tstSegmentView ) )
    {
      pointView = _.segment.pointClosestPoint( srcSegmentView, tstOrigin );
    }
    else
    {
      let srcLine = _.vector.from( _.array.makeArrayOfLength( srcDim*2 ) );
      let tstLine = _.vector.from( _.array.makeArrayOfLength( srcDim*2 ) );

      for( var i = 0 ; i < srcDim ; i++ )
      {
        srcLine.eSet( i, srcOrigin.eGet( i ) );
        srcLine.eSet( srcDim + i, srcDir.eGet( i ) );
        tstLine.eSet( i, tstOrigin.eGet( i ) );
        tstLine.eSet( srcDim + i, tstDir.eGet( i ) );
      }

      let factors = _.line.lineIntersectionFactors( srcLine, tstLine );

      if( factors === 0 )
      {
        let srcMod = _.vector.dot( srcDir, srcDir );
        let tstMod = _.vector.dot( tstDir, tstDir );
        let mod = _.vector.dot( srcDir, tstDir );
        let dOrigin = _.vector.from( avector.subVectors( tstOrigin.slice(), srcOrigin ) );
        let factor = ( - mod*_.vector.dot( tstDir, dOrigin ) + tstMod*_.vector.dot( srcDir, dOrigin ))/( tstMod*srcMod - mod*mod );

        if( factor >= 0 && factor <= 1 )
        {
          pointView = _.segment.segmentAt( srcSegmentView, factor );
        }
        else if( factor > 1 )
        {
          pointView = srcEnd;
        }
        else if ( factor < 0 )
        {
          pointView = srcOrigin;
        }
      }
      else if( factors.eGet( 1 ) < 0 )
      {
        pointView = _.segment.pointClosestPoint( srcSegmentView, tstOrigin );
      }
      else if( factors.eGet( 1 ) > 1 )
      {
        pointView = _.segment.pointClosestPoint( srcSegmentView, tstEnd );
      }
      else if( factors.eGet( 0 ) < 0 )
      {
        //pointView = _.segment.pointClosestPoint( srcSegmentView, tstOrigin );
        pointView = srcOrigin;
      }
      else if( factors.eGet( 0 ) > 1 )
      {
        pointView = srcEnd;
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
  * Check if a segment and a sphere intersect. Returns true if they intersect and false if not.
  * The sphere and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
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
  * @returns { Boolean } Returns true if the segment and the sphere intersect.
  * @function sphereIntersects
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the segment and sphere don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function sphereIntersects( srcSegment, srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcSphere.length - 1 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  let sphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimSphere = _.sphere.dimGet( sphereView );

  _.assert( dimSegment === dimSphere );

  if( _.sphere.pointContains( sphereView, origin ) )
  return true;

  let distance = _.segment.pointDistance( srcSegmentView, center );

  if( distance <= radius)
  return true;

  return false;

}

//

/**
  * Get the distance between a segment and a sphere. Returns the calculated distance.
  * The sphere and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
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
  * @returns { Boolean } Returns the distance between the segment and the sphere.
  * @function sphereDistance
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the segment and sphere don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function sphereDistance( srcSegment, srcSphere )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcSphere.length - 1 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  let sphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimSphere = _.sphere.dimGet( sphereView );

  _.assert( dimSegment === dimSphere );

  if( _.segment.sphereIntersects( srcSegmentView, sphereView ) )
  return 0;

  return _.segment.pointDistance( srcSegmentView, center ) - radius;
}

//

/**
  * Get the closest point in a segment to a sphere. Returns the calculated point.
  * The sphere and the segment remain unchanged.
  *
  * @param { Array } srcSegment - Source segment.
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
  * @returns { Boolean } Returns the closest point in a segment to a sphere.
  * @function sphereClosestPoint
  * @throws { Error } An Error if ( arguments.length ) is different than two or three.
  * @throws { Error } An Error if ( srcSegment ) is not segment.
  * @throws { Error } An Error if ( srcSphere ) is not sphere.
  * @throws { Error } An Error if ( dim ) is different than sphere.dimGet (the segment and sphere don´t have the same dimension).
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function sphereClosestPoint( srcSegment, srcSphere, dstPoint )
{
  _.assert( arguments.length === 2 || arguments.length === 3 , 'Expects two or three arguments' );
  _.assert( _.sphere.is( srcSphere ) );

  if( arguments.length === 2 )
  dstPoint = _.array.makeArrayOfLength( srcSphere.length - 1 );

  if( dstPoint === null || dstPoint === undefined )
  throw _.err( 'Not a valid destination point' );

  if( srcSegment === null )
  srcSegment = _.segment.make( srcSphere.length - 1 );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let direction = _.segment.directionGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  let sphereView = _.sphere._from( srcSphere );
  let center = _.sphere.centerGet( sphereView );
  let radius = _.sphere.radiusGet( sphereView );
  let dimSphere = _.sphere.dimGet( sphereView );

  let dstPointView = _.vector.from( dstPoint );

  _.assert( dimSegment === dimSphere );

  if( _.segment.sphereIntersects( srcSegmentView, sphereView ) )
  return 0;

  let pointVector = _.vector.from( _.segment.pointClosestPoint( srcSegmentView, center ) );

  for( let i = 0; i < pointVector.length; i++ )
  {
    dstPointView.eSet( i, pointVector.eGet( i ) );
  }

  return dstPoint;
}

//

/**
  * Get the bounding sphere of a segment. Returns destination sphere.
  * Segment and sphere are stored in Array data structure. Source segment stays untouched.
  *
  * @param { Array } dstSphere - destination sphere.
  * @param { Array } srcSegment - source segment for the bounding sphere.
  *
  * @example
  * // returns [ 1, 1, 1, Math.sqrt( 3 ) ]
  * _.boundingSphereGet( null, [ 0, 0, 0, 2, 2, 2 ] );
  *
  * @returns { Array } Returns the array of the bounding sphere.
  * @function boundingSphereGet
  * @throws { Error } An Error if ( dim ) is different than dimGet(segment) (the segment and the sphere don´t have the same dimension).
  * @throws { Error } An Error if ( arguments.length ) is different than two.
  * @throws { Error } An Error if ( dstSphere ) is not sphere
  * @throws { Error } An Error if ( srcSegment ) is not segment
  * @memberof module:Tools/math/Concepts.wTools.segment
  */
function boundingSphereGet( dstSphere, srcSegment )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let srcSegmentView = _.segment._from( srcSegment );
  let origin = _.segment.originGet( srcSegmentView );
  let endPoint = _.segment.endPointGet( srcSegmentView );
  let dimSegment  = _.segment.dimGet( srcSegmentView )

  if( dstSphere === null || dstSphere === undefined )
  dstSphere = _.sphere.makeZero( dimSegment );

  _.assert( _.sphere.is( dstSphere ) );
  let dstSphereView = _.sphere._from( dstSphere );
  let center = _.sphere.centerGet( dstSphereView );
  let radius = _.sphere.radiusGet( dstSphereView );
  let dimS = _.sphere.dimGet( dstSphereView );

  _.assert( dimSegment === dimS );

  // Center of the sphere
  for( let c = 0; c < center.length; c++ )
  {
    center.eSet( c, ( endPoint.eGet( c ) + origin.eGet( c ) ) / 2 );
  }

  // Radius of the sphere
  _.sphere.radiusSet( dstSphereView, vector.distance( center, endPoint ) );

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

  is : is,
  dimGet : dimGet,
  originGet : originGet,
  endPointGet : endPointGet,
  directionGet : directionGet,

  segmentAt : segmentAt,
  getFactor : getFactor,

  segmentParallel : segmentParallel,

  segmentIntersectionFactors : segmentIntersectionFactors,
  segmentIntersectionPoints : segmentIntersectionPoints,
  segmentIntersectionPoint : segmentIntersectionPoint,
  segmentIntersectionPointAccurate : segmentIntersectionPointAccurate,

  fromPair : fromPair,
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

  lineIntersects : lineIntersects,
  lineDistance : lineDistance,
  lineClosestPoint : lineClosestPoint,

  planeIntersects : planeIntersects,
  planeDistance : planeDistance,
  planeClosestPoint : planeClosestPoint,

  rayIntersects : rayIntersects,
  rayDistance : rayDistance,
  rayClosestPoint : rayClosestPoint,

  segmentIntersects : segmentIntersects,
  segmentDistance : segmentDistance,
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

  // require( './Sphere.s' );

}

})();
