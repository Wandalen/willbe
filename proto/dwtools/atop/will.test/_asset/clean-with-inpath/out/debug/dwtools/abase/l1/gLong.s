( function _gLong_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

//

let _ArrayIndexOf = Array.prototype.indexOf;
let _ArrayLastIndexOf = Array.prototype.lastIndexOf;
let _ArraySlice = Array.prototype.slice;
let _ArraySplice = Array.prototype.splice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _ObjectPropertyIsEumerable = Object.propertyIsEnumerable;

// --
// long transformer
// --

/**
 * The longDuplicate() routine returns an array with duplicate values of a certain number of times.
 *
 * @param { objectLike } [ o = {  } ] o - The set of arguments.
 * @param { longIs } o.src - The given initial array.
 * @param { longIs } o.result - To collect all data.
 * @param { Number } [ o.numberOfAtomsPerElement = 1 ] o.numberOfAtomsPerElement - The certain number of times
 * to append the next value from (srcArray or o.src) to the (o.result).
 * If (o.numberOfAtomsPerElement) is greater that length of a (srcArray or o.src) it appends the 'undefined'.
 * @param { Number } [ o.numberOfDuplicatesPerElement = 2 ] o.numberOfDuplicatesPerElement = 2 - The number of duplicates per element.
 *
 * @example
 * _.longDuplicate( [ 'a', 'b', 'c' ] );
 * // returns [ 'a', 'a', 'b', 'b', 'c', 'c' ]
 *
 * @example
 * let options = {
 *   src : [ 'abc', 'def' ],
 *   result : [  ],
 *   numberOfAtomsPerElement : 2,
 *   numberOfDuplicatesPerElement : 3
 * };
 * _.longDuplicate( options, {} );
 * // returns [ 'abc', 'def', 'abc', 'def', 'abc', 'def' ]
 *
 * @example
 * let options = {
 *   src : [ 'abc', 'def' ],
 *   result : [  ],
 *   numberOfAtomsPerElement : 3,
 *   numberOfDuplicatesPerElement : 3
 * };
 * _.longDuplicate( options, { a : 7, b : 13 } );
 * // returns [ 'abc', 'def', undefined, 'abc', 'def', undefined, 'abc', 'def', undefined ]
 *
 * @returns { Array } Returns an array with duplicate values of a certain number of times.
 * @function longDuplicate
 * @throws { Error } Will throw an Error if ( o ) is not an objectLike.
 * @memberof wTools
 */

function longDuplicate( o )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( arguments.length === 2 )
  {
    o = { src : arguments[ 0 ], numberOfDuplicatesPerElement : arguments[ 1 ] };
  }
  else
  {
    if( !_.objectIs( o ) )
    o = { src : o };
  }

  _.assert( _.numberIs( o.numberOfDuplicatesPerElement ) || o.numberOfDuplicatesPerElement === undefined );
  _.routineOptions( longDuplicate, o );
  _.assert( _.longIs( o.src ), 'Уxpects o.src as longIs entity' );
  _.assert( _.intIs( o.src.length / o.numberOfAtomsPerElement ) );

  if( o.numberOfDuplicatesPerElement === 1 )
  {
    if( o.result )
    {
      _.assert( _.longIs( o.result ) || _.bufferTypedIs( o.result ), 'Expects o.result as longIs or TypedArray if numberOfDuplicatesPerElement equals 1' );

      if( _.bufferTypedIs( o.result ) )
      o.result = _.longShallowClone( o.result, o.src );
      else if( _.longIs( o.result ) )
      o.result.push.apply( o.result, o.src );
    }
    else
    {
      o.result = o.src;
    }
    return o.result;
  }

  let length = o.src.length * o.numberOfDuplicatesPerElement;
  let numberOfElements = o.src.length / o.numberOfAtomsPerElement;

  if( o.result )
  _.assert( o.result.length >= length );

  o.result = o.result || _.longMakeUndefined( o.src, length );

  let rlength = o.result.length;

  for( let c = 0, cl = numberOfElements ; c < cl ; c++ )
  {

    for( let d = 0, dl = o.numberOfDuplicatesPerElement ; d < dl ; d++ )
    {

      for( let e = 0, el = o.numberOfAtomsPerElement ; e < el ; e++ )
      {
        let indexDst = c*o.numberOfAtomsPerElement*o.numberOfDuplicatesPerElement + d*o.numberOfAtomsPerElement + e;
        let indexSrc = c*o.numberOfAtomsPerElement+e;
        o.result[ indexDst ] = o.src[ indexSrc ];
      }

    }

  }

  _.assert( o.result.length === rlength );

  return o.result;
}

longDuplicate.defaults =
{
  src : null,
  result : null,
  numberOfAtomsPerElement : 1,
  numberOfDuplicatesPerElement : 2,
}

//

/**
 * The routine longOnce() returns the {-dstLong-} with the duplicated elements removed.
 * The {-dstLong-} instance will be returned when possible, if not a new instance of the same type is created.
 *
 * @param { Long } dstLong - The source and destination Long.
 * @param { Function } onEvaluate - A callback function.
 *
 * @example
 * _.longOnce( [ 1, 1, 2, 'abc', 'abc', 4, true, true ] );
 * // returns [ 1, 2, 'abc', 4, true ]
 *
 * @example
 * _.longOnce( [ 1, 2, 3, 4, 5 ] );
 * // returns [ 1, 2, 3, 4, 5 ]
 *
 * @example
 * _.longOnce( [ { v : 1 },{ v : 1 }, { v : 1 } ], ( e ) => e.v );
 * // returns [ { v : 1 } ]
 *
 * @example
 * _.longOnce( [ { v : 1 },{ v : 1 }, { v : 1 } ], ( e ) => e.k );
 * // returns [ { v : 1 },{ v : 1 }, { v : 1 } ]
 *
 * @returns { Long } - If it is possible, returns the source Long without the duplicated elements.
 * Otherwise, returns copy of the source Long without the duplicated elements.
 * @function longOnce
 * @throws { Error } If passed arguments is less than one or more than two.
 * @throws { Error } If the first argument is not an long.
 * @throws { Error } If the second argument is not a Routine.
 * @memberof wTools
 */

/*
qqq : routine longOnce requires good test coverage and documentation
Dmytro : covered and extended documentation.
*/

function longOnce( dstLong, onEvaluate )
{
  _.assert( 1 <= arguments.length || arguments.length <= 2 );
  _.assert( _.longIs( dstLong ), 'Expects Long' );

  if( _.arrayIs( dstLong ) )
  return _.arrayRemoveDuplicates( dstLong, onEvaluate );

  if( !dstLong.length )
  return dstLong;

  let length = dstLong.length;

  for( let i = 0; i < dstLong.length; i++ )
  if( _.longLeftIndex( dstLong, dstLong[ i ], i+1, onEvaluate ) !== -1 )
  length--;

  if( length === dstLong.length )
  return dstLong;

  let result = _.longMakeUndefined( dstLong, length );
  result[ 0 ] = dstLong[ 0 ];

  let j = 1;
  for( let i = 1; i < dstLong.length && j < length; i++ )
  if( _.arrayRightIndex( result, dstLong[ i ], j-1, onEvaluate ) === -1 )
  result[ j++ ] = dstLong[ i ];

  _.assert( j === length );

  return result;
}

//

// function longOnce( dst, src, onEvaluate )
// {
//
//   if( _.routineIs( arguments[ 1 ] ) && arguments[ 2 ] === undefined )
//   {
//     onEvaluate = arguments[ 1 ];
//     src = undefined;
//   }
//
//   _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
//   _.assert( dst === null || _.arrayIs( dst ) );
//   _.assert( src === undefined || _.longIs( src ) );
//   _.assert( onEvaluate === undefined || _.routineIs( onEvaluate ) );
//
//   if( src && dst )
//   {
//     dst = _.arrayAppendArraysOnce( dst, src );
//     src = undefined;
//   }
//
//   if( src )
//   {
//     _.assert( dst === null );
//     let unique = _.longHasUniques
//     ({
//       src,
//       onEvaluate : onEvaluate,
//       includeFirst : 1,
//     });
//
//     let result = _.longMakeUndefined( src, unique.number );
//
//     let c = 0;
//     for( let i = 0 ; i < src.length ; i++ )
//     if( unique.is[ i ] )
//     {
//       result[ c ] = src[ i ];
//       c += 1;
//     }
//
//     return result;
//   }
//   else if( dst )
//   {
//     let unique = _.longHasUniques
//     ({
//       src : dst,
//       onEvaluate : onEvaluate,
//       includeFirst : 1,
//     });
//
//     for( let i = dst.length-1 ; i >= 0 ; i-- )
//     if( !unique.is[ i ] )
//     {
//       dst.splice( i, 1 );
//     }
//
//     return dst;
//   }
//   else _.assert( 0 );
//
// }

// function longOnce( dstLong, onEvaluate )
// {
//   _.assert( 1 <= arguments.length || arguments.length <= 3 );
//   _.assert( _.longIs( dstLong ), 'longOnce :', 'Expects Long' );
//
//   if( _.arrayIs( dstLong ) )
//   {
//     _.arrayRemoveDuplicates( dstLong, onEvaluate );
//   }
//   else if( Object.prototype.toString.call( dstLong ) === "[object Arguments]")
//   {
//     let newElement;
//     for( let i = 0; i < dstLong.length; i++ )
//     {
//       newElement = dstLong[ i ];
//       for( let j = i + 1; j < dstLong.length; j++ )
//       {
//         if( newElement === dstLong[ j ] )
//         {
//           let array = Array.from( dstLong );
//           _.arrayRemoveDuplicates( array, onEvaluate );
//           dstLong = new dstLong.constructor( array ); // xxx : result = _.longMakeUndefined( array, l-f );
//         }
//       }
//     }
//   }
//   else
//   {
//     if( !onEvaluate )
//     {
//       for( let i = 0 ; i < dstLong.length ; i++ )
//       {
//         function isDuplicated( element, index, array )
//         {
//           return ( element !== dstLong[ i ] || index === i );
//         }
//         dstLong = dstLong.filter( isDuplicated );
//       }
//     }
//     else
//     {
//       if( onEvaluate.length === 2 )
//       {
//         for( let i = 0 ; i < dstLong.length ; i++ )
//         {
//           function isDuplicated( element, index, array )
//           {
//             return ( !onEvaluate( element, dstLong[ i ] ) || index === i );
//           }
//           dstLong = dstLong.filter( isDuplicated );
//         }
//       }
//       else
//       {
//         for( let i = 0 ; i < dstLong.length ; i++ )
//         {
//           function isDuplicated( element, index, array )
//           {
//             return ( onEvaluate( element ) !== onEvaluate( dstLong[ i ] ) || index === i );
//           }
//           dstLong = dstLong.filter( isDuplicated );
//         }
//       }
//     }
//   }
//
//   return dstLong;
// }

// /* qqq : not optimal, no redundant copy */
// /*
// function longOnce( dstLong, onEvaluate )
// {
//   _.assert( 1 <= arguments.length || arguments.length <= 3 );
//   _.assert( _.longIs( dstLong ), 'longOnce :', 'Expects Long' );
//
//   if( _.arrayIs( dstLong ) )
//   {
//     _.arrayRemoveDuplicates( dstLong, onEvaluate )
//     return dstLong;
//   }
//
//   let array = Array.from( dstLong );
//   _.arrayRemoveDuplicates( array, onEvaluate )
//
//   if( array.length === dstLong.length )
//   {
//     return dstLong;
//   }
//   else
//   {
//     return new dstLong.constructor( array ); // xxx : result = _.longMakeUndefined( array, l-f );
//   }
//
// }
// */

//
// function longOnce( dst, src, onEvaluate )
// {
//
//   _.assert( arguments.length === 2 || arguments.length === 3 );
//   _.assert( dst === null || _.arrayIs( dst ) );
//   _.assert( src === null || _.longIs( src ) );
//
//   let dstUnique;
//
//   if( src && dst )
//   {
//     dst = _.arrayAppendArraysOnce( dst, src );
//   }
//
//   x
//
//   let srcUnique = _.longHasUniques
//   ({
//     src,
//     onEvaluate,
//     includeFirst : 1,
//   });
//
//   let result = _.longMakeUndefined( src, dstUnique.number + srcUnique.number );
//
//   let c = 0;
//   for( let i = 0 ; i < src.length ; i++ )
//   if( srcUnique.is[ i ] )
//   {
//     result[ c ] = src[ i ];
//     c += 1;
//   }
//
//   return result;
// }

//

function longHasUniques( o )
{

  if( _.longIs( o ) )
  o = { src : o };

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.longIs( o.src ) );
  _.assertMapHasOnly( o, longHasUniques.defaults );

  /* */

  // if( o.onEvaluate )
  // {
  //   o.src = _.entityMap( o.src, ( e ) => o.onEvaluate( e ) );
  // }

  /* */

  let number = o.src.length;
  let isUnique = [];
  let index;

  for( let i = 0 ; i < o.src.length ; i++ )
  isUnique[ i ] = 1;

  for( let i = 0 ; i < o.src.length ; i++ )
  {
    index = i;

    if( !isUnique[ i ] )
    continue;

    let currentUnique = 1;
    index = _.longLeftIndex( o.src, o.src[ i ], index+1, o.onEvaluate );
    if( index >= 0 )
    do
    {
      isUnique[ index ] = 0;
      number -= 1;
      currentUnique = 0;
      index = _.longLeftIndex( o.src, o.src[ i ], index+1, o.onEvaluate );
    }
    while( index >= 0 );

    // if( currentUnique && o.src2 )
    // do
    // {
    //   index = o.src2.indexOf( o.src2[ i ], index+1 );
    //   if( index !== -1 )
    //   currentUnique = 0;
    // }
    // while( index !== -1 );

    if( !o.includeFirst )
    if( !currentUnique )
    {
      isUnique[ i ] = 0;
      number -= 1;
    }

  }

  return { number, is : isUnique };
}

longHasUniques.defaults =
{
  src : null,
  // src2 : null,
  onEvaluate : null,
  includeFirst : 0,
}


//

// /**
//  * Routine performs two operations: slice and grow.
//  * "Slice" means returning a copy of original array( array ) that contains elements from index( f ) to index( l ),
//  * but not including ( l ).
//  * "Grow" means returning a bigger copy of original array( array ) with free space supplemented by elements with value of ( val )
//  * argument.
//  *
//  * Returns result of operation as new array with same type as original array, original array is not modified.
//  *
//  * If ( f ) > ( l ), end index( l ) becomes equal to begin index( f ).
//  * If ( l ) === ( f ) - returns empty array.
//  *
//  * To run "Slice", first ( f ) and last ( l ) indexes must be in range [ 0, array.length ], otherwise routine will run "Grow" operation.
//  *
//  * Rules for "Slice":
//  * If ( f ) >= 0  and ( l ) <= ( array.length ) - returns array that contains elements with indexies from ( f ) to ( l ) but not including ( l ).
//  *
//  * Rules for "Grow":
//  *
//  * If ( f ) < 0 - prepends some number of elements with value of argument( val ) to the result array.
//  * If ( l ) > ( array.length ) - returns array that contains elements with indexies from ( f ) to ( array.length ),
//  * and free space filled by value of ( val ) if it was provided.
//  * If ( l ) < 0, ( l ) > ( f ) - returns array filled with some amount of elements with value of argument( val ).
//  *
//  * @param { Array/BufferNode } array - Source array or buffer.
//  * @param { Number } [ f = 0 ] f - begin zero-based index at which to begin extraction.
//  * @param { Number } [ l = array.length ] l - end zero-based index at which to end extraction.
//  * @param { * } val - value used to fill the space left after copying elements of the original array.
//  *
//  * @example
//  * _.longResize( [ 1, 2, 3, 4, 5, 6, 7 ], 2, 6 );
//  * // returns [ 3, 4, 5, 6 ]
//  *
//  * @example
//  * // begin index is less then zero
//  * _.longResize( [ 1, 2, 3, 4, 5, 6, 7 ], -1, 2 );
//  * // returns [ 1, 2 ]
//  *
//  * @example
//  * //end index is bigger then length of array
//  * _.longResize( [ 1, 2, 3, 4, 5, 6, 7 ], 5, 100 );
//  * // returns [ 6, 7 ]
//  *
//  * @example
//  * //Increase size, fill empty with zeroes
//  * let arr = [ 1 ]
//  * let result = _.longResize( arr, 0, 5, 0 );
//  * console.log( result );
//  * // log [ 1, 0, 0, 0, 0 ]
//  *
//  * @example
//  * //Take two last elements from original, other fill with zeroes
//  * let arr = [ 1, 2, 3, 4, 5 ]
//  * let result = _.longResize( arr, 3, 8, 0 );
//  * console.log( result );
//  * // log [ 4, 5, 0, 0, 0 ]
//  *
//  * @example
//  * //Add two zeroes at the beginning
//  * let arr = [ 1, 2, 3, 4, 5 ]
//  * let result = _.longResize( arr, -2, arr.length, 0 );
//  * console.log( result );
//  * // log [ 0, 0, 1, 2, 3, 4, 5 ]
//  *
//  * @example
//  * //Add two zeroes at the beginning and two at end
//  * let arr = [ 1, 2, 3, 4, 5 ]
//  * let result = _.longResize( arr, -2, arr.length + 2, 0 );
//  * console.log( result );
//  * // log [ 0, 0, 1, 2, 3, 4, 5, 0, 0 ]
//  *
//  * @example
//  * //Source can be also a BufferNode
//  * let buffer = BufferNode.from( '123' );
//  * let result = _.longResize( buffer, 0, buffer.length + 2, 0 );
//  * console.log( result );
//  * // log [ 49, 50, 51, 0, 0 ]
//  *
//  * @returns { Array } Returns a shallow copy of elements from the original array supplemented with value of( val ) if needed.
//  * @function longResize
//  * @throws { Error } Will throw an Error if ( array ) is not an Array-like or BufferNode.
//  * @throws { Error } Will throw an Error if ( f ) is not a Number.
//  * @throws { Error } Will throw an Error if ( l ) is not a Number.
//  * @throws { Error } Will throw an Error if no arguments provided.
//  * @memberof wTools
// */
//
// function longResize( array, range, val )
// {
//
//   _.assert( _.longIs( array ) );
//   _.assert( _.rangeIs( f ) );
//   _.assert( 1 <= arguments.length && arguments.length <= 3 );
//
//   let result;
//   let f = range ? range[ 0 ] : undefined;
//   let l = range ? range[ 1 ] : undefined;
//
//   f = f !== undefined ? f : 0;
//   l = l !== undefined ? l : array.length;
//
//   if( l < f )
//   l = f;
//   let lsrc = Math.min( array.length, l );
//
//   // if( _.bufferTypedIs( array ) )
//   // result = new array.constructor( l-f );
//   // else
//   // result = new Array( l-f );
//
//   result = _.longMakeUndefined( array, l-f );
//
//   let f2 = Math.max( f, 0 );
//   let l2 = Math.min( array.length, l );
//
//   for( let r = f2 ; r < l2 ; r++ )
//   result[ r - f ] = array[ r ];
//
//   if( val !== undefined )
//   if( f < 0 || l > array.length )
//   {
//     for( let r = 0 ; r < -f ; r++ )
//     {
//       result[ r ] = val;
//     }
//     let r = Math.max( l2 - f, 0 );
//     for( ; r < result.length ; r++ )
//     {
//       result[ r ] = val;
//     }
//   }
//
//   return result;
// }

// //
//
// /* srcBuffer = _.arrayMultislice( [ originalBuffer, f ], [ originalBuffer, 0, srcAttribute.atomsPerElement ] ); */
//
// function arrayMultislice()
// {
//   let length = 0;
//
//   if( arguments.length === 0 )
//   return [];
//
//   for( let a = 0 ; a < arguments.length ; a++ )
//   {
//
//     let src = arguments[ a ];
//     let f = src[ 1 ];
//     let l = src[ 2 ];
//
//     _.assert( _.longIs( src ) && _.longIs( src[ 0 ] ), 'Expects array of array' );
//     f = f !== undefined ? f : 0;
//     l = l !== undefined ? l : src[ 0 ].length;
//     if( l < f )
//     l = f;
//
//     _.assert( _.numberIs( f ) );
//     _.assert( _.numberIs( l ) );
//
//     src[ 1 ] = f;
//     src[ 2 ] = l;
//
//     length += l-f;
//
//   }
//
//   let result = new arguments[ 0 ][ 0 ].constructor( length ); // xxx : result = _.longMakeUndefined( array, l-f );
//   let r = 0;
//
//   for( let a = 0 ; a < arguments.length ; a++ )
//   {
//
//     let src = arguments[ a ];
//     let f = src[ 1 ];
//     let l = src[ 2 ];
//
//     for( let i = f ; i < l ; i++, r++ )
//     result[ r ] = src[ 0 ][ i ];
//
//   }
//
//   return result;
// }

function longAreRepeatedProbe( srcArray, onEvaluate )
{
  let isUnique = _.longMakeUndefined( srcArray );
  let result = Object.create( null );
  result.array = _.arrayMake( srcArray.length );
  result.uniques = srcArray.length;
  result.condensed = srcArray.length;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.longIs( srcArray ) );

  for( let i = 0 ; i < srcArray.length ; i++ )
  {
    let element = srcArray[ i ];

    if( result.array[ i ] > 0 )
    continue;

    result.array[ i ] = 0;

    let left = _.longLeftIndex( srcArray, element, i+1, onEvaluate );
    if( left >= 0 )
    {
      result.array[ i ] = 1;
      result.uniques -= 1;
      do
      {
        result.uniques -= 1;
        result.condensed -= 1;
        result.array[ left ] = 1;
        left = _.longLeftIndex( srcArray, element, left+1, onEvaluate );
      }
      while( left >= 0 );
    }

  }

  return result;

}

//

function longAllAreRepeated( src, onEvalutate )
{
  let areRepated = _.longAreRepeatedProbe.apply( this, arguments );
  return !areRepated.uniques;
}

//

function longAnyAreRepeated( src, onEvalutate )
{
  let areRepated = _.longAreRepeatedProbe.apply( this, arguments );
  return areRepated.uniques !== src.length;
}

//

function longNoneAreRepeated( src, onEvalutate )
{
  let areRepated = _.longAreRepeatedProbe.apply( this, arguments );
  return areRepated.uniques === src.length;
}

//

/**
 * The longMask() routine returns a new instance of array that contains the certain value(s) from array (srcArray),
 * if an array (mask) contains the truth-value(s).
 *
 * The longMask() routine checks, how much an array (mask) contain the truth value(s),
 * and from that amount of truth values it builds a new array, that contains the certain value(s) of an array (srcArray),
 * by corresponding index(es) (the truth value(s)) of the array (mask).
 * If amount is equal 0, it returns an empty array.
 *
 * @param { longIs } srcArray - The source array.
 * @param { longIs } mask - The target array.
 *
 * @example
 * _.longMask( [ 1, 2, 3, 4 ], [ undefined, null, 0, '' ] );
 * // returns []
 *
 * @example
 * _longMask( [ 'a', 'b', 'c', 4, 5 ], [ 0, '', 1, 2, 3 ] );
 * // returns [ "c", 4, 5 ]
 *
 * @example
 * _.longMask( [ 'a', 'b', 'c', 4, 5, 'd' ], [ 3, 7, 0, '', 13, 33 ] );
 * // returns [ 'a', 'b', 5, 'd' ]
 *
 * @returns { longIs } Returns a new instance of array that contains the certain value(s) from array (srcArray),
 * if an array (mask) contains the truth-value(s).
 * If (mask) contains all falsy values, it returns an empty array.
 * Otherwise, it returns a new array with certain value(s) of an array (srcArray).
 * @function longMask
 * @throws { Error } Will throw an Error if (arguments.length) is less or more that two.
 * @throws { Error } Will throw an Error if (srcArray) is not an array-like.
 * @throws { Error } Will throw an Error if (mask) is not an array-like.
 * @throws { Error } Will throw an Error if length of both (srcArray and mask) is not equal.
 * @memberof wTools
 */

function longMask( srcArray, mask )
{

  let atomsPerElement = mask.length;
  let length = srcArray.length / atomsPerElement;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( srcArray ), 'longMask :', 'Expects array-like as srcArray' );
  _.assert( _.longIs( mask ), 'longMask :', 'Expects array-like as mask' );
  _.assert
  (
    _.intIs( length ),
    'longMask :', 'Expects mask that has component for each atom of srcArray',
    _.toStr
    ({
      'atomsPerElement' : atomsPerElement,
      'srcArray.length' : srcArray.length,
    })
  );

  let preserve = 0;
  for( let m = 0 ; m < mask.length ; m++ )
  if( mask[ m ] )
  preserve += 1;

  // let dstArray = new srcArray.constructor( length*preserve );
  let dstArray = _.longMakeUndefined( srcArray, length*preserve );

  if( !preserve )
  return dstArray;

  let c = 0;
  for( let i = 0 ; i < length ; i++ )
  for( let m = 0 ; m < mask.length ; m++ )
  if( mask[ m ] )
  {
    dstArray[ c ] = srcArray[ i*atomsPerElement + m ];
    c += 1;
  }

  return dstArray;
}

//

function longUnmask( o )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( arguments.length === 2 )
  o =
  {
    src : arguments[ 0 ],
    mask : arguments[ 1 ],
  }

  _.assertMapHasOnly( o, longUnmask.defaults );
  _.assert( _.longIs( o.src ), 'Expects o.src as ArrayLike' );

  let atomsPerElement = o.mask.length;

  let atomsPerElementPreserved = 0;
  for( let m = 0 ; m < o.mask.length ; m++ )
  if( o.mask[ m ] )
  atomsPerElementPreserved += 1;

  let length = o.src.length / atomsPerElementPreserved;
  if( Math.floor( length ) !== length )
  throw _.err( 'longMask :', 'Expects mask that has component for each atom of o.src', _.toStr({ 'atomsPerElementPreserved' : atomsPerElementPreserved, 'o.src.length' : o.src.length  }) );

  let dstArray = _.longMakeUndefined( o.src, atomsPerElement*length );
  // let dstArray = new o.src.constructor( atomsPerElement*length );

  let e = [];
  for( let i = 0 ; i < length ; i++ )
  {

    for( let m = 0, p = 0 ; m < o.mask.length ; m++ )
    if( o.mask[ m ] )
    {
      e[ m ] = o.src[ i*atomsPerElementPreserved + p ];
      p += 1;
    }
    else
    {
      e[ m ] = 0;
    }

    if( o.onEach )
    o.onEach( e, i );

    for( let m = 0 ; m < o.mask.length ; m++ )
    dstArray[ i*atomsPerElement + m ] = e[ m ];

  }

  return dstArray;
}

longUnmask.defaults =
{
  src : null,
  mask : null,
  onEach : null,
}

// --
// array maker
// --

/**
 * The routine arrayRandom() returns an array which contains random numbers.
 *
 * Routine accepts one or three arguments.
 * Optionally, routine can accepts one of two sets of parameters. First of them
 * is one or three arguments, the other is options map.
 *
 * Set 1:
 * @param { ArrayLike } dst - The destination array.
 * @param { Range|Number } range - The range for generating random numbers.
 * If {-range-} is number, routine makes range [ range, range ].
 * @param { Number|Range } length - The quantity of generated random numbers.
 * If dst.length < {-length-}, then routine makes new container of {-dst-} type.
 * If {-length-} is Range, then routine choose random lenght from provided range.
 *
 * Set 2:
 * @param { Object } o - The options map. Options map includes next fields:
 * @param { Function } o.onEach - The callback for generating random numbers.
 * Accepts three parameters - range, index of element, source container.
 * @param { ArrayLike } o.dst - The destination array.
 * @param { Range|Number } o.range -  The range for generating random numbers.
 * If {-range-} is number, routine makes range [ range, range ].
 * @param { Number|Range } o.length - The length of an array.
 * If dst.length < length, then routine makes new container of {-dst-} type.
 * If {-length-} is Range, then routine choose random lenght from provided range.
 *
 * @example
 * let got = _.arrayRandom( 3 );
 * // returns array with three elements in range [ 0, 1 ]
 * console.log( got );
 * // log [ 0.2054268445, 0.8651654684, 0.5564687461 ]
 *
 * @example
 * let dst = [ 0, 0, 0 ];
 * let got _.arrayRandom( dst, [ 1, 5 ], 3 );
 * // returns dst array with three elements in range [ 1, 5 ]
 * console.log( got );
 * // log [ 4.9883513548, 1.2313468546, 3.8973544247 ]
 * console.log( got === dst );
 * // log true
 *
 * @example
 * let dst = [ 0, 0, 0 ];
 * let got _.arrayRandom( dst, [ 1, 5 ], 4 );
 * // returns dst array with three elements in range [ 1, 5 ]
 * console.log( got );
 * // log [ 4.9883513548, 1.2313468546, 3.8973544247, 2.6782254287 ]
 * console.log( got === dst );
 * // log false
 *
 * @example
 * _.arrayRandom
 * ({
 *   length : 5,
 *   range : [ 1, 10 ],
 *   onEach : ( range ) => _.intRandom( range ),
 * });
 * // returns [ 6, 2, 4, 7, 8 ]
 *
 * @example
 * let dst = [ 0, 0, 0, 0, 0 ]
 * var got = _.arrayRandom
 * ({
 *   length : 3,
 *   range : [ 1, 10 ],
 *   onEach : ( range ) => _.intRandom( range ),
 * });
 * console.log( got );
 * // log [ 1, 10, 4, 0, 0 ]
 * console.log( got === dst );
 * // log true
 *
 * @returns { ArrayLike } - Returns an array of random numbers.
 * @function arrayRandom
 * @throws { Error } If arguments.length === 0, arguments.length === 2, arguments.lenght > 3.
 * @throws { Error } If arguments.length === 1, and passed argument is not options map {-o-} or {-length-}.
 * @throws { Error } If options map {-o-} has unnacessary fields.
 * @throws { Error } If {-dst-} or {-o.dst-} is not ArrayLike.
 * @throws { Error } If {-range-} or {-o.range-} is not Range or not Number.
 * @throws { Error } If {-length-} or {-o.length-} is not Number or not Range.
 * @throws { Error } If {-o.onEach-} is not routine.
 * @memberof wTools
 */

function arrayRandom( o )
{

  if( arguments[ 2 ] !== undefined )
  o = { dst : arguments[ 0 ], range : arguments[ 1 ], length : arguments[ 2 ] }
  else if( _.numberIs( o ) || _.rangeIs( o ) )
  o = { length : o }
  _.assert( arguments.length === 1 || arguments.length === 3 );
  _.routineOptions( arrayRandom, o );

  if( o.onEach === null )
  o.onEach = ( range ) => _.numberRandom( range );

  if( o.range === null )
  o.range = [ 0, 1 ];
  if( _.numberIs( o.range ) )
  o.range = [ o.range, o.range ]

  if( _.rangeIs( o.length ) )
  o.length = _.intRandom( o.length );
  if( o.length === null && o.dst )
  o.length = o.dst.length;
  if( o.length === null )
  o.length = 1;

  _.assert( _.intIs( o.length ) );

  if( o.dst === null || o.dst.length < o.length )
  o.dst = _.longMake( o.dst, o.length );

  for( let i = 0 ; i < o.length ; i++ )
  {
    o.dst[ i ] = o.onEach( o.range, i, o );
    // o.dst[ i ] = o.range[ 0 ] + Math.random()*( o.range[ 1 ] - o.range[ 0 ] );
    // if( o.int )
    // o.dst[ i ] = Math.floor( o.dst[ i ] );
  }

  return o.dst;
}

arrayRandom.defaults =
{
  // int : 0,
  dst : null,
  onEach : null,
  range : null,
  length : null,
}

//

/**
 * The arrayFromCoercing() routine converts an object-like {-srcMap-} into Array.
 *
 * @param { * } src - To convert into Array.
 *
 * @example
 * _.arrayFromCoercing( [ 3, 7, 13, 'abc', false, undefined, null, {} ] );
 * // returns [ 3, 7, 13, 'abc', false, undefined, null, {} ]
 *
 * @example
 * _.arrayFromCoercing( { a : 3, b : 7, c : 13 } );
 * // returns [ [ 'a', 3 ], [ 'b', 7 ], [ 'c', 13 ] ]
 *
 * @example
 * _.arrayFromCoercing( "3, 7, 13, 3.5abc, 5def, 7.5ghi, 13jkl" );
 * // returns [ 3, 7, 13, 3.5, 5, 7.5, 13 ]
 *
 * @example
 * let args = ( function() {
 *   return arguments;
 * } )( 3, 7, 13, 'abc', false, undefined, null, { greeting: 'Hello there!' } );
 * _.arrayFromCoercing( args );
 * // returns [ 3, 7, 13, 'abc', false, undefined, null, { greeting: 'Hello there!' } ]
 *
 * @returns { Array } Returns an Array.
 * @function arrayFromCoercing
 * @throws { Error } Will throw an Error if {-srcMap-} is not an object-like.
 * @memberof wTools
 */

function arrayFromCoercing( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.arrayIs( src ) )
  return src;

  if( _.objectIs( src ) )
  return _.mapToArray( src );

  if( _.longIs( src ) )
  return _ArraySlice.call( src );

  if( _.strIs( src ) )
  return src.split(/[, ]+/).map( function( s ){ if( s.length ) return parseFloat(s); } );

  if( _.argumentsArrayIs( src ) )
  return _ArraySlice.call( src );

  _.assert( 0, 'Unknown data type : ' + _.strType( src ) );
}

//

/**
 * The arrayFromRange() routine generate array of arithmetic progression series,
 * from the range[ 0 ] to the range[ 1 ] with increment 1.
 *
 * It iterates over loop from (range[0]) to the (range[ 1 ] - range[ 0 ]),
 * and assigns to the each index of the (result) array (range[ 0 ] + 1).
 *
 * @param { longIs } range - The first (range[ 0 ]) and the last (range[ 1 ] - range[ 0 ]) elements of the progression.
 *
 * @example
 * _.arrayFromRange( [ 1, 5 ] );
 * // returns [ 1, 2, 3, 4 ]
 *
 * @example
 * _.arrayFromRange( 5 );
 * // returns [ 0, 1, 2, 3, 4 ]
 *
 * @returns { array } Returns an array of numbers for the requested range with increment 1.
 * May be an empty array if adding the step would not converge toward the end value.
 * @function arrayFromRange
 * @throws { Error } If passed arguments is less than one or more than one.
 * @throws { Error } If the first argument is not an array-like object.
 * @throws { Error } If the length of the (range) is not equal to the two.
 * @memberof wTools
 */

function arrayFromRange( range )
{

  if( _.numberIs( range ) )
  range = [ 0, range ];

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( range.length === 2 );
  _.assert( _.longIs( range ) );

  let step = range[ 0 ] <= range[ 1 ] ? +1 : -1;

  return this.arrayFromRangeWithStep( range, step );
}

//

function arrayFromProgressionArithmetic( progression, numberOfSteps )
{
  let result;

  debugger;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( progression ) )
  _.assert( isFinite( progression[ 0 ] ) );
  _.assert( isFinite( progression[ 1 ] ) );
  _.assert( isFinite( numberOfSteps ) );
  _.assert( _.routineIs( this.ArrayType ) );

  debugger;

  if( numberOfSteps === 0 )
  return new this.ArrayType();

  if( numberOfSteps === 1 )
  return new this.ArrayType([ progression[ 0 ] ]);

  let range = [ progression[ 0 ], progression[ 0 ]+progression[ 1 ]*(numberOfSteps+1) ];
  let step = ( range[ 1 ]-range[ 0 ] ) / ( numberOfSteps-1 );

  return this.arrayFromRangeWithStep( range, step );
}

//

function arrayFromRangeWithStep( range, step )
{
  let result;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( isFinite( range[ 0 ] ) );
  _.assert( isFinite( range[ 1 ] ) );
  _.assert( step === undefined || step < 0 || step > 0 );
  _.assert( _.routineIs( this.ArrayType ) );

  if( range[ 0 ] === range[ 1 ] )
  return new this.ArrayType();

  if( range[ 0 ] < range[ 1 ] )
  {

    if( step === undefined )
    step = 1;

    _.assert( step > 0 );

    result = new this.ArrayType( Math.round( ( range[ 1 ]-range[ 0 ] ) / step ) );

    let i = 0;
    while( range[ 0 ] < range[ 1 ] )
    {
      result[ i ] = range[ 0 ];
      range[ 0 ] += step;
      i += 1;
    }

  }
  else
  {

    debugger;

    if( step === undefined )
    step = -1;

    _.assert( step < 0 );

    result = new this.ArrayType( Math.round( range[ 0 ]-range[ 1 ] / step ) );

    let i = 0;
    while( range[ 0 ] > range[ 1 ] )
    {
      result[ i ] = range[ 0 ];
      range[ 0 ] += step;
      i += 1;
    }

  }

  return result;
}

//

function arrayFromRangeWithNumberOfSteps( range , numberOfSteps )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( isFinite( range[ 0 ] ) );
  _.assert( isFinite( range[ 1 ] ) );
  _.assert( numberOfSteps >= 0 );
  _.assert( _.routineIs( this.ArrayType ) );

  if( numberOfSteps === 0 )
  return new this.ArrayType();

  if( numberOfSteps === 1 )
  return new this.ArrayType( range[ 0 ] );

  let step;

  if( range[ 0 ] < range[ 1 ] )
  step = ( range[ 1 ]-range[ 0 ] ) / (numberOfSteps-1);
  else
  step = ( range[ 0 ]-range[ 1 ] ) / (numberOfSteps-1);

  return this.arrayFromRangeWithStep( range , step );
}

// --
// array converter
// --

// /**
//  * The arrayToMap() converts an (array) into Object.
//  *
//  * @param { longIs } array - To convert into Object.
//  *
//  * @example
//  * _.arrayToMap( [] );
//  * // returns {}
//  *
//  * @example
//  * _.arrayToMap( [ 3, [ 1, 2, 3 ], 'abc', false, undefined, null, {} ] );
//  * // returns { '0' : 3, '1' : [ 1, 2, 3 ], '2' : 'abc', '3' : false, '4' : undefined, '5' : null, '6' : {} }
//  *
//  * @example
//  * let args = ( function() {
//  *   return arguments;
//  * } )( 3, 'abc', false, undefined, null, { greeting: 'Hello there!' } );
//  * _.arrayToMap( args );
//  * // returns { '0' : 3, '1' : 'abc', '2' : false, '3' : undefined, '4' : null, '5' : { greeting: 'Hello there!' } }
//  *
//  * @returns { Object } Returns an Object.
//  * @function arrayToMap
//  * @throws { Error } Will throw an Error if (array) is not an array-like.
//  * @memberof wTools
//  */
//
// function arrayToMap( array )
// {
//   let result = Object.create( null );
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.longIs( array ) );
//
//   for( let a = 0 ; a < array.length ; a++ )
//   result[ a ] = array[ a ];
//   return result;
// }
//
// //
//
// /**
//  * The arrayToStr() routine joins an array {-srcMap-} and returns one string containing each array element separated by space,
//  * only types of integer or floating point.
//  *
//  * @param { longIs } src - The source array.
//  * @param { objectLike } [ options = {  } ] options - The options.
//  * @param { Number } [ options.precision = 5 ] - The precision of numbers.
//  * @param { String } [ options.type = 'mixed' ] - The type of elements.
//  *
//  * @example
//  * _.arrayToStr( [ 1, 2, 3 ], { type : 'int' } );
//  * // returns "1 2 3 "
//  *
//  * @example
//  * _.arrayToStr( [ 3.5, 13.77, 7.33 ], { type : 'float', precission : 4 } );
//  * // returns "3.500 13.77 7.330"
//  *
//  * @returns { String } Returns one string containing each array element separated by space,
//  * only types of integer or floating point.
//  * If (src.length) is empty, it returns the empty string.
//  * @function arrayToStr
//  * @throws { Error } Will throw an Error If (options.type) is not the number or float.
//  * @memberof wTools
//  */
//
// function arrayToStr( src, options )
// {
//
//   let result = '';
//   options = options || Object.create( null );
//
//   if( options.precission === undefined ) options.precission = 5;
//   if( options.type === undefined ) options.type = 'mixed';
//
//   if( !src.length ) return result;
//
//   if( options.type === 'float' )
//   {
//     for( var s = 0 ; s < src.length-1 ; s++ )
//     {
//       result += src[ s ].toPrecision( options.precission ) + ' ';
//     }
//     result += src[ s ].toPrecision( options.precission );
//   }
//   else if( options.type === 'int' )
//   {
//     for( var s = 0 ; s < src.length-1 ; s++ )
//     {
//       result += String( src[ s ] ) + ' ';
//     }
//     result += String( src[ s ] ) + ' ';
//   }
//   else
//   {
//     throw _.err( 'not tested' );
//     for( let s = 0 ; s < src.length-1 ; s++ )
//     {
//       result += String( src[ s ] ) + ' ';
//     }
//     result += String( src[ s ] ) + ' ';
//   }
//
//   return result;
// }

// --
// array transformer
// --

/**
 * The longSelectWithIndices() routine selects elements from (srcArray) by indexes of (indicesArray).
 *
 * @param { longIs } srcArray - Values for the new array.
 * @param { ( longIs | object ) } [ indicesArray = indicesArray.indices ] - Indexes of elements from the (srcArray) or options object.
 *
 * @example
 * _.longSelectWithIndices( [ 1, 2, 3, 4, 5 ], [ 2, 3, 4 ] );
 * // returns [ 3, 4, 5 ]
 *
 * @example
 * _.longSelectWithIndices( [ 1, 2, 3 ], [ 4, 5 ] );
 * // returns [ undefined, undefined ]
 *
 * @returns { longIs } - Returns a new array with the length equal (indicesArray.length) and elements from (srcArray).
   If there is no element with necessary index than the value will be undefined.
 * @function longSelectWithIndices
 * @throws { Error } If passed arguments is not array like object.
 * @throws { Error } If the atomsPerElement property is not equal to 1.
 * @memberof wTools
 */

function longSelectWithIndices( srcArray, indicesArray )
{
  let atomsPerElement = 1;

  if( _.objectIs( indicesArray ) )
  {
    atomsPerElement = indicesArray.atomsPerElement || 1;
    indicesArray = indicesArray.indices;
  }

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( srcArray ) );
  _.assert( _.longIs( indicesArray ) );

  // let result = new srcArray.constructor( indicesArray.length );
  let result = _.longMakeUndefined( srcArray, indicesArray.length );

  if( atomsPerElement === 1 )
  for( let i = 0, l = indicesArray.length ; i < l ; i += 1 )
  {
    result[ i ] = srcArray[ indicesArray[ i ] ];
  }
  else
  for( let i = 0, l = indicesArray.length ; i < l ; i += 1 )
  {
    for( let a = 0 ; a < atomsPerElement ; a += 1 )
    result[ i*atomsPerElement+a ] = srcArray[ indicesArray[ i ]*atomsPerElement+a ];
  }

  return result;
}

// --
// long mutator
// --

function longShuffle( dst, times )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.longIs( dst ) );

  if( times === undefined )
  times = dst.length;

  let l = dst.length;
  let e1, e2;
  for( let t1 = 0 ; t1 < times ; t1++ )
  {
    let t2 = Math.floor( Math.random() * l );
    e1 = dst[ t1 ];
    e2 = dst[ t2 ];
    dst[ t1 ] = e2;
    dst[ t2 ] = e1;
  }

  return dst;
}

// --
// array mutator
// --

// function longAssign( dst, index, value )
// {
//   _.assert( arguments.length === 3, 'Expects exactly three arguments' );
//   _.assert( dst.length > index );
//   dst[ index ] = value;
//   return dst;
// }

//

/**
 * The longSwapElements() routine reverses the elements by indices (index1) and (index2) in the (dst) array.
 *
 * @param { Array } dst - The initial array.
 * @param { Number } index1 - The first index.
 * @param { Number } index2 - The second index.
 *
 * @example
 * _.longSwapElements( [ 1, 2, 3, 4, 5 ], 0, 4 );
 * // returns [ 5, 2, 3, 4, 1 ]
 *
 * @returns { Array } - Returns the (dst) array that has been modified in place by indexes (index1) and (index2).
 * @function longSwapElements
 * @throws { Error } If the first argument in not an array.
 * @throws { Error } If the second argument is less than 0 and more than a length initial array.
 * @throws { Error } If the third argument is less than 0 and more than a length initial array.
 * @memberof wTools
 */

function longSwapElements( dst, index1, index2 )
{

  if( arguments.length === 1 )
  {
    index1 = 0;
    index2 = 1;
  }

  _.assert( arguments.length === 1 || arguments.length === 3 );
  _.assert( _.longIs( dst ), 'Expects long' );
  _.assert( 0 <= index1 && index1 < dst.length, 'index1 is out of bound' );
  _.assert( 0 <= index2 && index2 < dst.length, 'index2 is out of bound' );

  let e = dst[ index1 ];
  dst[ index1 ] = dst[ index2 ];
  dst[ index2 ] = e;

  return dst;
}

//

/**
 * The longPut() routine puts all values of (arguments[]) after the second argument to the (dstArray)
 * in the position (dstOffset) and changes values of the following index.
 *
 * @param { longIs } dstArray - The source array.
 * @param { Number } [ dstOffset = 0 ] dstOffset - The index of element where need to put the new values.
 * @param {*} arguments[] - One or more argument(s).
 * If the (argument) is an array it iterates over array and adds each element to the next (dstOffset++) index of the (dstArray).
 * Otherwise, it adds each (argument) to the next (dstOffset++) index of the (dstArray).
 *
 * @example
 * _.longPut( [ 1, 2, 3, 4, 5, 6, 9 ], 2, 'str', true, [ 7, 8 ] );
 * // returns [ 1, 2, 'str', true, 7, 8, 9 ]
 *
 * @example
 * _.longPut( [ 1, 2, 3, 4, 5, 6, 9 ], 0, 'str', true, [ 7, 8 ] );
 * // returns [ 'str', true, 7, 8, 5, 6, 9 ]
 *
 * @returns { longIs } - Returns an array containing the changed values.
 * @function longPut
 * @throws { Error } Will throw an Error if (arguments.length) is less than one.
 * @throws { Error } Will throw an Error if (dstArray) is not an array-like.
 * @throws { Error } Will throw an Error if (dstOffset) is not a Number.
 * @memberof wTools
 */

function longPut( dstArray, dstOffset )
{
  _.assert( arguments.length >= 1, 'Expects at least one argument' );
  _.assert( _.longIs( dstArray ) );
  _.assert( _.numberIs( dstOffset ) );

  dstOffset = dstOffset || 0;

  for( let a = 2 ; a < arguments.length ; a++ )
  {
    let argument = arguments[ a ];
    let aIs = _.arrayIs( argument ) || _.bufferTypedIs( argument );

    if( aIs && _.bufferTypedIs( dstArray ) )
    {
      dstArray.set( argument, dstOffset );
      dstOffset += argument.length;
    }
    else if( aIs )
    for( let i = 0 ; i < argument.length ; i++ )
    {
      dstArray[ dstOffset ] = argument[ i ];
      dstOffset += 1;
    }
    else
    {
      dstArray[ dstOffset ] = argument;
      dstOffset += 1;
    }

  }

  return dstArray;
}

//

/**
 * The routine arrayFill() fills all the elements of the given Long in the provided range
 * with a static value.
 *
 * @param { Long } result - The source Long.
 * @param { * } value - Any value to fill the elements in the {-result-}.
 * If {-value-} is not provided, the routine fills elements of source Long by 0.
 * @param { Range|Number } range - The two-element array that defines the start index and the end index for copying elements.
 * If {-range-} is number, then it defines the end index, and the start index is 0.
 * If range[ 0 ] < 0, then start index sets to 0, end index incrementes by absolute value of range[ 0 ].
 * If range[ 1 ] <= range[ 0 ], then routine returns a copy of original Long.
 * If {-range-} is not provided, routine fills all elements of the {-result-}.
 *
 * @example
 * _.longFill( [ 1, 2, 3, 4, 5 ] );
 * // returns [ 0, 0, 0, 0, 0 ]
 *
 * @example
 * _.longFill( [ 1, 2, 3, 4, 5 ], 'a' );
 * // returns [ 'a', 'a', 'a', 'a', 'a' ]
 *
 * @example
 * _.longFill( [ 1, 2, 3, 4, 5 ], 'a', 2 );
 * // returns [ 'a', 'a', 3, 4, 5 ]
 *
 * @example
 * _.longFill( [ 1, 2, 3, 4, 5 ], 'a', [ 1, 3 ] );
 * // returns [ 1, 'a', 'a', 4, 5 ]
 *
 * @example
 * _.longFill( [ 1, 2, 3, 4, 5 ], 'a', [ -1, 3 ] );
 * // returns [ 'a', 'a', 'a', 'a', 5 ]
 *
 * @example
 * _.longFill( [ 1, 2, 3, 4, 5 ], 'a', [ 4, 3 ] );
 * // returns [ 1, 2, 3, 4, 5 ]
 *
 * @returns { Long } - If it is possible, returns the source Long filled with a static value.
 * Otherwise, returns copy of the source Long filled with a static value.
 * @function longFill
 * @throws { Error } If arguments.length is less then one or more then three.
 * @throws { Error } If {-result-} is not a Long.
 * @throws { Error } If {-range-} is not a Range or not a Number.
 * @memberof wTools
 */

/*
qqq : routine longFill requires good test coverage and documentation
Dmytro : extended documentation, extended coverage
*/

function longFill( result, value, range )
{

  if( range === undefined )
  range = [ 0, result.length ];
  if( _.numberIs( range ) )
  range = [ 0, range ];

  _.assert( 1 <= arguments.length && arguments.length <= 3 );
  _.assert( _.longIs( result ) );
  _.assert( _.rangeIs( range ) );

  if( value === undefined )
  value = 0;

  // if( result.length < times )
  // result = _.longGrowInplace( result, [ 0, times ] );

  result = _.longGrowInplace( result, range );

  if( range[ 0 ] < 0 )
  {
    range[ 1 ] = range[ 1 ] - range[ 0 ];
    range[ 0 ] = 0;
  }

  if( _.routineIs( result.fill ) )
  {
    // result.fill( value, 0, times );
    result.fill( value, range[ 0 ], range[ 1 ] );
  }
  else
  {
    // if( times < 0 )
    // times = result.length + times;
    // for( let t = 0 ; t < times ; t++ )
    // result[ t ] = value;

    // for( let t = 0 ; t < range[ 1 ] ; t++ )
    for( let t = range[ 0 ] ; t < range[ 1 ] ; t++ )
    result[ t ] = value;

  }

  // _.assert( times <= 0 || result[ times-1 ] === value );

  return result;
}

//
//
// function longFillTimes( result, times, value )
// {
//
//   _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
//   _.assert( _.longIs( result ) );
//
//   if( value === undefined )
//   value = 0;
//
//   if( result.length < times )
//   result = _.longGrowInplace( result, [ 0, times ] );
//
//   if( _.routineIs( result.fill ) )
//   {
//     result.fill( value, 0, times );
//   }
//   else
//   {
//     debugger;
//     if( times < 0 )
//     times = result.length + times;
//
//     for( let t = 0 ; t < times ; t++ )
//     result[ t ] = value;
//   }
//
//   _.assert( times <= 0 || result[ times-1 ] === value );
//
//   return result;
// }
//
// //
//
// function longFillWhole( result, value )
// {
//   _.assert( _.longIs( result ) );
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//   if( value === undefined )
//   value = 0;
//   return _.longFillTimes( result, result.length, value );
// }

// {
//   _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
//   _.assert( _.objectIs( o ) || _.numberIs( o ) || _.arrayIs( o ), 'arrayFill :', '"o" must be object' );
//
//   if( arguments.length === 1 )
//   {
//     if( _.numberIs( o ) )
//     o = { times : o };
//     else if( _.arrayIs( o ) )
//     o = { result : o };
//   }
//   else
//   {
//     o = { result : arguments[ 0 ], value : arguments[ 1 ] };
//   }
//
//   _.assertMapHasOnly( o, arrayFill.defaults );
//   if( o.result )
//   _.assert( _.longIs( o.result ) );
//
//   let result = o.result || [];
//   let times = o.times !== undefined ? o.times : result.length;
//   let value = o.value !== undefined ? o.value : 0;
//
//   if( _.routineIs( result.fill ) )
//   {
//     if( result.length < times )
//     result.length = times;
//     result.fill( value, 0, times );
//   }
//   else
//   {
//     for( let t = 0 ; t < times ; t++ )
//     result[ t ] = value;
//   }
//
//   _.assert( result[ times-1 ] === value );
//   return result;
// }
//
// arrayFill.defaults =
// {
//   result : null,
//   times : null,
//   value : null,
// }

//

/**
 * The longSupplement() routine returns an array (dstArray), that contains values from following arrays only type of numbers.
 * If the initial (dstArray) isn't contain numbers, they are replaced.
 *
 * It finds among the arrays the biggest array, and assigns to the variable (length), iterates over from 0 to the (length),
 * creates inner loop that iterates over (arguments[...]) from the right (arguments.length - 1) to the (arguments[0]) left,
 * checks each element of the arrays, if it contains only type of number.
 * If true, it adds element to the array (dstArray) by corresponding index.
 * Otherwise, it skips and checks following array from the last executable index, previous array.
 * If the last executable index doesn't exist, it adds 'undefined' to the array (dstArray).
 * After that it returns to the previous array, and executes again, until (length).
 *
 * @param { longIs } dstArray - The initial array.
 * @param { ...longIs } arguments[...] - The following array(s).
 *
 * @example
 * _.longSupplement( [ 4, 5 ], [ 1, 2, 3 ], [ 6, 7, 8, true, 9 ], [ 'a', 'b', 33, 13, 'e', 7 ] );
 * // returns ?
 *
 * @returns { longIs } - Returns an array that contains values only type of numbers.
 * @function longSupplement
 * @throws { Error } Will throw an Error if (dstArray) is not an array-like.
 * @throws { Error } Will throw an Error if (arguments[...]) is/are not the array-like.
 * @memberof wTools
 */

function longSupplement( dstArray )
{
  let result = dstArray;
  if( result === null )
  result = [];

  let length = result.length;
  _.assert( _.longIs( result ) || _.numberIs( result ), 'Expects object as argument' );

  for( let a = arguments.length-1 ; a >= 1 ; a-- )
  {
    _.assert( _.longIs( arguments[ a ] ), 'argument is not defined :', a );
    length = Math.max( length, arguments[ a ].length );
  }

  if( _.numberIs( result ) )
  result = arrayFill
  ({
    value : result,
    times : length,
  });

  for( let k = 0 ; k < length ; k++ )
  {

    if( k in dstArray && isFinite( dstArray[ k ] ) )
    continue;

    let a;
    for( a = arguments.length-1 ; a >= 1 ; a-- )
    if( k in arguments[ a ] && !isNaN( arguments[ a ][ k ] ) )
    break;

    if( a === 0 )
    continue;

    result[ k ] = arguments[ a ][ k ];

  }

  return result;
}

//

/**
 * The longExtendScreening() routine iterates over (arguments[...]) from the right to the left (arguments[1]),
 * and returns a (dstArray) containing the values of the following arrays,
 * if the following arrays contains the indexes of the (screenArray).
 *
 * @param { longIs } screenArray - The source array.
 * @param { longIs } dstArray - To add the values from the following arrays,
 * if the following arrays contains indexes of the (screenArray).
 * If (dstArray) contains values, the certain values will be replaced.
 * @param { ...longIs } arguments[...] - The following arrays.
 *
 * @example
 * _.longExtendScreening( [ 1, 2, 3 ], [  ], [ 0, 1, 2 ], [ 3, 4 ], [ 5, 6 ] );
 * // returns [ 5, 6, 2 ]
 *
 * @example
 * _.longExtendScreening( [ 1, 2, 3 ], [ 3, 'abc', 7, 13 ], [ 0, 1, 2 ], [ 3, 4 ], [ 'a', 6 ] );
 * // returns [ 'a', 6, 2, 13 ]
 *
 * @example
 * _.longExtendScreening( [  ], [ 3, 'abc', 7, 13 ], [ 0, 1, 2 ], [ 3, 4 ], [ 'a', 6 ] );
 * // returns [ 3, 'abc', 7, 13 ]
 *
 * @returns { longIs } Returns a (dstArray) containing the values of the following arrays,
 * if the following arrays contains the indexes of the (screenArray).
 * If (screenArray) is empty, it returns a (dstArray).
 * If (dstArray) is equal to the null, it creates a new array,
 * and returns the corresponding values of the following arrays by the indexes of a (screenArray).
 * @function longExtendScreening
 * @throws { Error } Will throw an Error if (screenArray) is not an array-like.
 * @throws { Error } Will throw an Error if (dstArray) is not an array-like.
 * @throws { Error } Will throw an Error if (arguments[...]) is/are not an array-like.
 * @memberof wTools
 */

function longExtendScreening( screenArray, dstArray )
{
  let result = dstArray;
  if( result === null )
  result = [];

  _.assert( _.longIs( screenArray ), 'Expects object as screenArray' );
  _.assert( _.longIs( result ), 'Expects object as argument' );
  for( let a = arguments.length-1 ; a >= 2 ; a-- )
  _.assert( arguments[ a ], 'Argument is not defined :', a );

  for( let k = 0 ; k < screenArray.length ; k++ )
  {

    if( screenArray[ k ] === undefined )
    continue;

    let a;
    for( a = arguments.length-1 ; a >= 2 ; a-- )
    if( k in arguments[ a ] ) break;
    if( a === 1 )
    continue;

    result[ k ] = arguments[ a ][ k ];

  }

  return result;
}

//

/**
 * The routine longSort() sorts destination Long {-dstLong-}.
 *
 * @param { Long|Null } dstLong - The destination Long. If {-dstLong-} is null, then routine makes copy from {-srcLong-}.
 * @param { Long } srcArray - Source long. Uses if {-dstLong-} is null.
 * @param { Function } onEvaluate - Callback - evaluator or comparator for sorting elements.
 *
 * @example
 * let src = [ 1, 30, -2, 5, -43 ];
 * _.longSort( null, src );
 * // returns [ -43, -2, 1, 30, 5 ]
 *
 * @example
 * let dst = [ 1, 30, -2, 5, -43 ];
 * let src = [ 0 ];
 * let got = _.longSort( dst, src );
 * console.log( got );
 * // log [ -43, -2, 1, 30, 5 ]
 * console.log( got === dst );
 * // log true
 *
 * @example
 * let dst = [ 1, 50, -2, 3, -43 ];
 * let onEval = ( e ) => e;
 * let got = _.longSort( dst, onEval );
 * console.log( got );
 * // log [ -43, -2, 1, 3, 50 ]
 * console.log( got === dst );
 * // log true
 *
 * @example
 * let dst = [ 1, 50, -2, 3, -43 ];
 * let onEval = ( a, b ) => a < b;
 * let got = _.longSort( dst, onEval );
 * console.log( got );
 * // log [ 50, 3, 1, -2, -43 ]
 * console.log( got === dst );
 * // log true
 *
 * @returns { Long } Returns sorted {-dstLong-}.
 * @function longSort
 * @throws { Error } If arguments.length is less then one or more then three.
 * @throws { Error } If {-onEvaluate-} is not a routine or not undefined.
 * @throws { Error } If {-dstLong-} is not null or not a Long.
 * @throws { Error } If arguments.length === 3 and {-srcLong-} is not a Long.
 * @throws { Error } If onEvaluate.length is less then one or more then two.
 * @memberof wTools
 */

function longSort( dstLong, srcLong, onEvaluate )
{

  if( _.routineIs( arguments[ 1 ] ) )
  {
    onEvaluate = arguments[ 1 ];
    srcLong = dstLong;
  }

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  _.assert( onEvaluate === undefined || _.routineIs( onEvaluate ) );
  _.assert( _.longIs( srcLong ) );
  _.assert( dstLong === null || _.longIs( dstLong ) );

  if( dstLong === null )
  dstLong = _.arrayMake( srcLong )

  if( onEvaluate === undefined )
  {
    dstLong.sort();
  }
  else if( onEvaluate.length === 2 )
  {
    dstLong.sort( onEvaluate );
  }
  else if( onEvaluate.length === 1 )
  {
    dstLong.sort( function( a, b )
    {
      a = onEvaluate( a );
      b = onEvaluate( b );
      if( a > b ) return +1;
      else if( a < b ) return -1;
      else return 0;
    });
  }
  else _.assert( 0, 'Expects signle-argument evaluator or two-argument comparator' );

  return dstLong;
}

// --
// array etc
// --

// function arrayIndicesOfGreatest( srcArray, numberOfElements, comparator )
// {
//   let result = [];
//   let l = srcArray.length;
//
//   debugger;
//   throw _.err( 'not tested' );
//
//   comparator = _._comparatorFromEvaluator( comparator );
//
//   function rcomparator( a, b )
//   {
//     return comparator( srcArray[ a ], srcArray[ b ] );
//   };
//
//   for( let i = 0 ; i < l ; i += 1 )
//   {
//
//     if( result.length < numberOfElements )
//     {
//       _.sorted.add( result, i, rcomparator );
//       continue;
//     }
//
//     _.sorted.add( result, i, rcomparator );
//     result.splice( result.length-1, 1 );
//
//   }
//
//   return result;
// }
//
// //
//
// /**
//  * The arraySum() routine returns the sum of an array {-srcMap-}.
//  *
//  * @param { longIs } src - The source array.
//  * @param { Routine } [ onEvaluate = function( e ) { return e } ] - A callback function.
//  *
//  * @example
//  * _.arraySum( [ 1, 2, 3, 4, 5 ] );
//  * // returns 15
//  *
//  * @example
//  * _.arraySum( [ 1, 2, 3, 4, 5 ], function( e ) { return e * 2 } );
//  * // returns 29
//  *
//  * @example
//  * _.arraySum( [ true, false, 13, '33' ], function( e ) { return e * 2 } );
//  * // returns 94
//  *
//  * @returns { Number } - Returns the sum of an array {-srcMap-}.
//  * @function arraySum
//  * @throws { Error } If passed arguments is less than one or more than two.
//  * @throws { Error } If the first argument is not an array-like object.
//  * @throws { Error } If the second argument is not a Routine.
//  * @memberof wTools
//  */
//
// function arraySum( src, onEvaluate )
// {
//   let result = 0;
//
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//   _.assert( _.longIs( src ), 'Expects ArrayLike' );
//
//   if( onEvaluate === undefined )
//   onEvaluate = function( e ){ return e; };
//
//   _.assert( _.routineIs( onEvaluate ) );
//
//   for( let i = 0 ; i < src.length ; i++ )
//   {
//     result += onEvaluate( src[ i ], i, src );
//   }
//
//   return result;
// }

// --
// array set
// --

/**
 * Returns new array that contains difference between two arrays: ( src1 ) and ( src2 ).
 * If some element is present in both arrays, this element and all copies of it are ignored.
 * @param { longIs } src1 - source array;
 * @param { longIs} src2 - array to compare with ( src1 ).
 *
 * @example
 * _.arraySetDiff( [ 1, 2, 3 ], [ 4, 5, 6 ] );
 * // returns [ 1, 2, 3, 4, 5, 6 ]
 *
 * @example
 * _.arraySetDiff( [ 1, 2, 4 ], [ 1, 3, 5 ] );
 * // returns [ 2, 4, 3, 5 ]
 *
 * @returns { Array } Array with unique elements from both arrays.
 * @function arraySetDiff
 * @throws { Error } If arguments count is not 2.
 * @throws { Error } If one or both argument(s) are not longIs entities.
 * @memberof wTools
 */

function arraySetDiff( src1, src2 )
{
  let result = [];

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( src1 ) );
  _.assert( _.longIs( src2 ) );

  for( let i = 0 ; i < src1.length ; i++ )
  {
    if( src2.indexOf( src1[ i ] ) === -1 )
    result.push( src1[ i ] );
  }

  for( let i = 0 ; i < src2.length ; i++ )
  {
    if( src1.indexOf( src2[ i ] ) === -1 )
    result.push( src2[ i ] );
  }

  return result;
}

//

function _argumentsOnly( dst, src1, src2, onEvaluate1, onEvaluate2 )
{
  _.assert( 2 <= arguments.length && arguments.length <= 5 );
  _.assert( _.longIs( dst ) || _.setIs( dst ) || dst === null );
  _.assert( _.longIs( src1 ) || _.setIs( src1 ) );
  _.assert( _.longIs( src2 ) || _.setIs( src2 ) || _.routineIs( src2 ) || src2 === undefined );
  _.assert( _.routineIs( onEvaluate1 ) || onEvaluate1 === undefined );
  _.assert( _.routineIs( onEvaluate2 ) || onEvaluate2 === undefined );

  if( dst === null )
  dst = _.containerAdapter.make( new src1.constructor() );

  if( _.routineIs( src2 ) || src2 === undefined )
  {
    onEvaluate2 = onEvaluate1;
    onEvaluate1 = src2;
    src2 = _.containerAdapter.make( src1 );
    src1 = _.containerAdapter.make( dst );
    dst = _.containerAdapter.make( new src1.original.constructor() );
  }
  else
  {
    src2 = _.containerAdapter.from( src2 );
    src1 = _.containerAdapter.from( src1 );
    dst = _.containerAdapter.from( dst );
  }

  return [ dst, src1, src2, onEvaluate1, onEvaluate2 ];
}

function arraySetDiff_( dst, src1, src2, onEvaluate1, onEvaluate2 )
{
  [ dst, src1, src2, onEvaluate1, onEvaluate2 ] = _argumentsOnly.apply( this, arguments );

  let temp = [];
  if( dst.original === src1.original )
  {
    src2.each( ( e ) => src1.has( e, onEvaluate1, onEvaluate2 ) ? null : temp.push( e ) );
    temp.forEach( ( e ) => src1.push( e ) );
  }
  else if( dst.original === src2.original )
  {
    src1.each( ( e ) => src2.has( e, onEvaluate1, onEvaluate2 ) ? null : temp.push( e ) );
    temp.forEach( ( e ) => src2.push( e ) );
  }
  else
  {
    src1.each( ( e ) => src2.has( e, onEvaluate1, onEvaluate2 ) ? null : dst.push( e ) );
    src2.each( ( e ) => src1.has( e, onEvaluate1, onEvaluate2 ) ? null : dst.push( e ) );
  }

  return dst.original;
}

//

/**
 * Returns new array that contains elements from ( src ) that are not present in ( but ).
 * All copies of ignored element are ignored too.
 * @param { longIs } src - source array;
 * @param { longIs} but - array of elements to ignore.
 *
 * @example
 * _.arraySetBut( [ 1, 1, 1 ], [ 1 ] );
 * // returns []
 *
 * @example
 * _.arraySetBut( [ 1, 1, 2, 2, 3, 3 ], [ 1, 3 ] );
 * // returns [ 2, 2 ]
 *
 * @returns { Array } Source array without elements from ( but ).
 * @function arraySetBut
 * @throws { Error } If arguments count is not 2.
 * @throws { Error } If one or both argument(s) are not longIs entities.
 * @memberof wTools
 */

function arraySetBut( dst )
{
  let args = _.longSlice( arguments );

  if( dst === null )
  if( args.length > 1 )
  {
    dst = _.longSlice( args[ 1 ] );
    args.splice( 1, 1 );
  }
  else
  {
    return [];
  }

  args[ 0 ] = dst;

  _.assert( arguments.length >= 1, 'Expects at least one argument' );
  for( let a = 0 ; a < args.length ; a++ )
  _.assert( _.longIs( args[ a ] ) );

  for( let i = dst.length-1 ; i >= 0 ; i-- )
  {
    for( let a = 1 ; a < args.length ; a++ )
    {
      let but = args[ a ];
      if( but.indexOf( dst[ i ] ) !== -1 )
      {
        dst.splice( i, 1 );
        break;
      }
    }
  }

  return dst;
}

//

function arraySetBut_( dst, src1, src2, onEvaluate1, onEvaluate2 )
{
  if( arguments.length === 1 )
  {
    if( _.longIs( dst ) )
    return _.longSlice( dst );
    else if( _.setIs( dst ) )
    return new Set( dst );
    else if( dst === null )
    return [];
    else
    _.assert( 0 );
  }
  if( dst === null && _.routineIs( src2 ) || dst === null && src2 === undefined )
  {
    if( _.longIs( src1 ) )
    return _.longSlice( src1 )
    else if( _.setIs( src1 ) )
    return new Set( src1 )
    _.assert( 0 );
  }

  [ dst, src1, src2, onEvaluate1, onEvaluate2 ] = _argumentsOnly.apply( this, arguments );

  if( dst.original === src1.original )
  src1.eachRight( ( e ) => src2.has( e, onEvaluate1, onEvaluate2 ) ? src1.remove( e ) : null );
  else
  src1.each( ( e ) => src2.has( e, onEvaluate1, onEvaluate2 ) ? null : dst.push( e ) );

  return dst.original;
}

//

/**
 * Returns array that contains elements from ( src ) that exists at least in one of arrays provided after first argument.
 * If element exists and it has copies, all copies of that element will be included into result array.
 * @param { longIs } src - source array;
 * @param { ...longIs } - sequence of arrays to compare with ( src ).
 *
 * @example
 * _.arraySetIntersection( [ 1, 2, 3 ], [ 1 ], [ 3 ] );
 * // returns [ 1, 3 ]
 *
 * @example
 * _.arraySetIntersection( [ 1, 1, 2, 2, 3, 3 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] );
 * // returns [ 1, 1, 2, 2, 3, 3 ]
 *
 * @returns { Array } Array with elements that are a part of at least one of the provided arrays.
 * @function arraySetIntersection
 * @throws { Error } If one of arguments is not an longIs entity.
 * @memberof wTools
 */

function arraySetIntersection( dst )
{

  let first = 1;
  if( dst === null )
  if( arguments.length > 1 )
  {
    dst = _.longSlice( arguments[ 1 ] );
    first = 2;
  }
  else
  {
    return [];
  }

  _.assert( arguments.length >= 1, 'Expects at least one argument' );
  _.assert( _.longIs( dst ) );
  for( let a = 1 ; a < arguments.length ; a++ )
  _.assert( _.longIs( arguments[ a ] ) );

  for( let i = dst.length-1 ; i >= 0 ; i-- )
  {

    for( let a = first ; a < arguments.length ; a++ )
    {
      let ins = arguments[ a ];
      if( ins.indexOf( dst[ i ] ) === -1 )
      {
        dst.splice( i, 1 );
        break;
      }
    }

  }

  return dst;
}

//

function arraySetIntersection_( dst, src1, src2, onEvaluate1, onEvaluate2 )
{
  if( arguments.length === 1 )
  {
    if( _.longIs( dst ) )
    return _.longSlice( dst );
    else if( _.setIs( dst ) )
    return new Set( dst );
    else if( dst === null )
    return [];
    else
    _.assert( 0 );
  }
  if( dst === null && _.routineIs( src2 ) || dst === null && src2 === undefined )
  {
    if( _.longIs( src1 ) )
    return _.longSlice( src1 )
    else if( _.setIs( src1 ) )
    return new Set( src1 )
    _.assert( 0 );
  }

  [ dst, src1, src2, onEvaluate1, onEvaluate2 ] = _argumentsOnly.apply( this, arguments );

  if( dst.original === src1.original )
  src1.eachRight( ( e ) => src2.has( e, onEvaluate1, onEvaluate2 ) ? null : src1.remove( e ) );
  else
  src1.each( ( e ) => src2.has( e, onEvaluate1, onEvaluate2 ) ? dst.push( e ) : null );

  return dst.original;
}

//

function arraySetUnion( dst )
{
  let args = _.longSlice( arguments );

  if( dst === null )
  if( arguments.length > 1 )
  {
    dst = [];
    // dst = _.longSlice( args[ 1 ] );
    // args.splice( 1, 1 );
  }
  else
  {
    return [];
  }

  _.assert( arguments.length >= 1, 'Expects at least one argument' );
  _.assert( _.longIs( dst ) );
  for( let a = 1 ; a < args.length ; a++ )
  _.assert( _.longIs( args[ a ] ) );

  for( let a = 1 ; a < args.length ; a++ )
  {
    let ins = args[ a ];
    for( let i = 0 ; i < ins.length ; i++ )
    {
      if( dst.indexOf( ins[ i ] ) === -1 )
      dst.push( ins[ i ] )
    }
  }

  return dst;
}

//

function arraySetUnion_( dst, src1, src2, onEvaluate1, onEvaluate2 )
{
  if( arguments.length === 1 )
  {
    if( dst === null )
    return [];
    else if( _.longIs( dst ) )
    return _.longSlice( dst );
    else if( _.setIs( dst ) )
    return new Set( dst );
    else
    _.assert( 0 );
  }

  [ dst, src1, src2, onEvaluate1, onEvaluate2 ] = _argumentsOnly.apply( this, arguments );

  if( dst.original === src1.original )
  src1.appendContainerOnce( src2, onEvaluate1, onEvaluate2 );
  else if( dst.original === src2.original )
  src2.appendContainerOnce( src1, onEvaluate1, onEvaluate2 );
  else
  {
    dst.appendContainerOnce( src1, onEvaluate1, onEvaluate2 );
    dst.appendContainerOnce( src2, onEvaluate1, onEvaluate2 );
  }

  return dst.original;
}

//

/*
function arraySetContainAll( src )
{
  let result = [];

  _.assert( _.longIs( src ) );

  for( let a = 1 ; a < arguments.length ; a++ )
  {

    _.assert( _.longIs( arguments[ a ] ) );

    if( src.length > arguments[ a ].length )
    return false;

    for( let i = 0 ; i < src.length ; i++ )
    {

      throw _.err( 'Not tested' );
      if( arguments[ a ].indexOf( src[ i ] ) !== -1 )
      {
        throw _.err( 'Not tested' );
        return false;
      }

    }

  }

  return true;
}
*/
//
  /**
   * The arraySetContainAll() routine returns true, if at least one of the following arrays (arguments[...]),
   * contains all the same values as in the {-srcMap-} array.
   *
   * @param { longIs } src - The source array.
   * @param { ...longIs } arguments[...] - The target array.
   *
   * @example
   * _.arraySetContainAll( [ 1, 'b', 'c', 4 ], [ 1, 2, 3, 4, 5, 'b', 'c' ] );
   * // returns true
   *
   * @example
   * _.arraySetContainAll( [ 'abc', 'def', true, 26 ], [ 1, 2, 3, 4 ], [ 26, 'abc', 'def', true ] );
   * // returns false
   *
   * @returns { boolean } Returns true, if at least one of the following arrays (arguments[...]),
   * contains all the same values as in the {-srcMap-} array.
   * If length of the {-srcMap-} is more than the next argument, it returns false.
   * Otherwise, it returns false.
   * @function arraySetContainAll
   * @throws { Error } Will throw an Error if {-srcMap-} is not an array-like.
   * @throws { Error } Will throw an Error if (arguments[...]) is not an array-like.
   * @memberof wTools
   */

function arraySetContainAll( src )
{
  _.assert( _.longIs( src ) );
  for( let a = 1 ; a < arguments.length ; a++ )
  _.assert( _.longIs( arguments[ a ] ) );

  for( let a = 1 ; a < arguments.length ; a++ )
  {
    let ins = arguments[ a ];

    for( let i = 0 ; i < ins.length ; i++ )
    {
      if( src.indexOf( ins[ i ] ) === -1 )
      return false;
    }

  }

  return true;
}

//

/**
 * The arraySetContainAny() routine returns true, if at least one of the following arrays (arguments[...]),
 * contains the first matching value from {-srcMap-}.
 *
 * @param { longIs } src - The source array.
 * @param { ...longIs } arguments[...] - The target array.
 *
 * @example
 * _.arraySetContainAny( [ 33, 4, 5, 'b', 'c' ], [ 1, 'b', 'c', 4 ], [ 33, 13, 3 ] );
 * // returns true
 *
 * @example
 * _.arraySetContainAny( [ 'abc', 'def', true, 26 ], [ 1, 2, 3, 4 ], [ 26, 'abc', 'def', true ] );
 * // returns true
 *
 * @example
 * _.arraySetContainAny( [ 1, 'b', 'c', 4 ], [ 3, 5, 'd', 'e' ], [ 'abc', 33, 7 ] );
 * // returns false
 *
 * @returns { Boolean } Returns true, if at least one of the following arrays (arguments[...]),
 * contains the first matching value from {-srcMap-}.
 * Otherwise, it returns false.
 * @function arraySetContainAny
 * @throws { Error } Will throw an Error if {-srcMap-} is not an array-like.
 * @throws { Error } Will throw an Error if (arguments[...]) is not an array-like.
 * @memberof wTools
 */

function arraySetContainAny( src )
{
  _.assert( _.longIs( src ) );
  for( let a = 1 ; a < arguments.length ; a++ )
  _.assert( _.longIs( arguments[ a ] ) );

  if( src.length === 0 )
  return true;

  for( let a = 1 ; a < arguments.length ; a++ )
  {
    let ins = arguments[ a ];

    let i;
    for( i = 0 ; i < ins.length ; i++ )
    {
      if( src.indexOf( ins[ i ] ) !== -1 )
      break;
    }

    if( i === ins.length )
    return false;

  }

  return true;
}

//

function arraySetContainNone( src )
{
  _.assert( _.longIs( src ) );

  for( let a = 1 ; a < arguments.length ; a++ )
  {

    _.assert( _.longIs( arguments[ a ] ) );

    for( let i = 0 ; i < src.length ; i++ )
    {

      if( arguments[ a ].indexOf( src[ i ] ) !== -1 )
      {
        return false;
      }

    }

  }

  return true;
}

//

/**
 * Returns true if ( ins1 ) and ( ins2) arrays have same length and elements, elements order doesn't matter.
 * Inner arrays of arguments are not compared and result of such combination will be false.
 * @param { longIs } ins1 - source array;
 * @param { longIs} ins2 - array to compare with.
 *
 * @example
 * _.arraySetIdentical( [ 1, 2, 3 ], [ 4, 5, 6 ] );
 * // returns false
 *
 * @example
 * _.arraySetIdentical( [ 1, 2, 4 ], [ 4, 2, 1 ] );
 * // returns true
 *
 * @returns { Boolean } Result of comparison as boolean.
 * @function arraySetIdentical
 * @throws { Error } If one of arguments is not an ArrayLike entity.
 * @throws { Error } If arguments length is not 2.
 * @memberof wTools
 */

function arraySetIdentical( ins1, ins2 )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( ins1 ) );
  _.assert( _.longIs( ins2 ) );

  if( ins1.length !== ins2.length )
  return false;

  let result = _.arraySetDiff( ins1, ins2 );

  return result.length === 0;
}

// --
// fields
// --

// let unrollSymbol = Symbol.for( 'unroll' );

let Fields =
{

  // ArrayType : Array,
  //
  // accuracy : 1e-7,
  // accuracySqrt : 1e-4,
  // accuracySqr : 1e-14,

}

// --
// routines
// --

let Routines =
{

  // long repeater

  longDuplicate,
  longOnce, /* xxx : review */

  longHasUniques,
  longAreRepeatedProbe,
  longAllAreRepeated,
  longAnyAreRepeated,
  longNoneAreRepeated,

  longMask, /* dubious */
  longUnmask, /* dubious */

  // array maker

  arrayRandom, /* qqq : cover and document please | Dmytro : extended coverage and documentation. Routine should be 'longRandom' or need to insert assertion */
  arrayFromCoercing,

  arrayFromRange,
  arrayFromProgressionArithmetic,
  arrayFromRangeWithStep,
  arrayFromRangeWithNumberOfSteps,

  // // array converter
  //
  // arrayToMap, /* dubious */
  // arrayToStr, /* dubious */

  // long transformer

  longSelectWithIndices,

  // long mutator

  longShuffle,

  // long mutator

  longSwapElements,
  longPut,
  longFill,
  // longFillTimes,
  // longFillWhole,

  longSupplement, /* experimental */
  longExtendScreening, /* experimental */

  longSort, /* qqq : implement good coverage, document routine longSort | Dmytro : covered and documented */

  // // array etc
  //
  // arrayIndicesOfGreatest, /* dubious */
  // arraySum, /* dubious */

  // array set

  arraySetDiff, /* qqq : ask how to improve, please */
  arraySetDiff_, /* Dmytro : routine accepts arrays and Sets, two or three parameters without callbacks, covered */
  arraySetBut, /* qqq : ask how to improve, please */
  arraySetBut_, /* Dmytro : routine accepts arrays and Sets, two or three parameters without callbacks, covered */
  arraySetIntersection, /* qqq : ask how to improve, please */
  arraySetIntersection_, /* Dmytro : routine accepts arrays and Sets, two or three parameters without callbacks, covered */
  arraySetUnion, /* qqq : ask how to improve, please */
  arraySetUnion_, /* Dmytro : routine accepts arrays and Sets, two or three parameters without callbacks, covered */

  arraySetContainAll,
  arraySetContainAny,
  arraySetContainNone,
  arraySetIdentical,

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
