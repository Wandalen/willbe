( function _gEntity_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

// // // --
// // // multiplier
// // // --
// //
// // function dup( ins, times, result )
// // {
// //   _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
// //   _.assert( _.numberIs( times ) || _.longIs( times ),'dup expects times as number or array' );
// //
// //   if( _.numberIs( times ) )
// //   {
// //     if( !result )
// //     result = new Array( times );
// //     for( let t = 0 ; t < times ; t++ )
// //     result[ t ] = ins;
// //     return result;
// //   }
// //   else if( _.longIs( times ) )
// //   {
// //     _.assert( times.length === 2 );
// //     let l = times[ 1 ] - times[ 0 ];
// //     if( !result )
// //     result = new Array( times[ 1 ] );
// //     for( let t = 0 ; t < l ; t++ )
// //     result[ times[ 0 ] + t ] = ins;
// //     return result;
// //   }
// //   else _.assert( 0,'unexpected' );
// //
// // }
// //
// // //
// //
// // function multiple( src, times )
// // {
// //   _.assert( arguments.length === 2 );
// //   if( _.arrayLike( src ) )
// //   _.assert( src.length === times );
// //   else
// //   src = _.dup( src, times );
// //   return src;
// // }
// //
// // //
// //
// // function multipleAll( dsts )
// // {
// //   let length = undefined;
// //
// //   _.assert( arguments.length === 1 );
// //
// //   for( let d = 0 ; d < dsts.length ; d++ )
// //   if( _.arrayIs( dsts[ d ] ) )
// //   {
// //     length = dsts[ d ].length;
// //     break;
// //   }
// //
// //   if( length === undefined )
// //   return dsts;
// //
// //   for( let d = 0 ; d < dsts.length ; d++ )
// //   dsts[ d ] = _.multiple( dsts[ d ], length );
// //
// //   return dsts;
// // }
// //
// // // --
// // // entity iterator
// // // --
// //
// // function eachSample( o )
// // {
// //
// //   if( arguments.length === 2 || _.arrayLike( arguments[ 0 ] ) )
// //   {
// //     o =
// //     {
// //       sets : arguments[ 0 ],
// //       onEach : arguments[ 1 ],
// //     }
// //   }
// //
// //   _.routineOptions( eachSample,o );
// //   _.assert( arguments.length === 1 || arguments.length === 2 );
// //   _.assert( _.routineIs( o.onEach ) || o.onEach === null );
// //   _.assert( _.arrayIs( o.sets ) || _.mapLike( o.sets ) );
// //   _.assert( o.base === undefined && o.add === undefined );
// //
// //   /* sample */
// //
// //   if( !o.sample )
// //   o.sample = _.entityMakeTivial( o.sets );
// //
// //   /* */
// //
// //   let keys = _.longIs( o.sets ) ? _.arrayFromRange([ 0,o.sets.length ]) : _.mapKeys( o.sets );
// //   if( o.result && !_.arrayIs( o.result ) )
// //   o.result = [];
// //   let len = [];
// //   let indexnd = [];
// //   let index = 0;
// //   let l = _.entityLength( o.sets );
// //
// //   /* sets */
// //
// //   let sindex = 0;
// //   _.each( o.sets, function( e,k )
// //   {
// //     let set = o.sets[ k ];
// //     _.assert( _.longIs( set ) || _.primitiveIs( set ) );
// //     if( _.primitiveIs( set ) )
// //     o.sets[ k ] = [ set ];
// //
// //     len[ sindex ] = _.entityLength( o.sets[ k ] );
// //     indexnd[ sindex ] = 0;
// //     sindex += 1;
// //   });
// //
// //   /* */
// //
// //   function firstSample()
// //   {
// //
// //     let sindex = 0;
// //     _.each( o.sets, function( e,k )
// //     {
// //       o.sample[ k ] = o.sets[ k ][ indexnd[ sindex ] ];
// //       sindex += 1;
// //       if( !len[ k ] )
// //       return 0;
// //     });
// //
// //     if( o.result )
// //     if( _.mapLike( o.sample ) )
// //     o.result.push( _.mapExtend( null, o.sample ) );
// //     else
// //     o.result.push( o.sample.slice() );
// //
// //     return 1;
// //   }
// //
// //   /* */
// //
// //   function nextSample( i )
// //   {
// //
// //     let k = keys[ i ];
// //     indexnd[ i ]++;
// //
// //     if( indexnd[ i ] >= len[ i ] )
// //     {
// //       indexnd[ i ] = 0;
// //       o.sample[ k ] = o.sets[ k ][ indexnd[ i ] ];
// //     }
// //     else
// //     {
// //       o.sample[ k ] = o.sets[ k ][ indexnd[ i ] ];
// //       index += 1;
// //
// //       if( o.result )
// //       if( _.mapLike( o.sample ) )
// //       o.result.push( _.mapExtend( null, o.sample ) );
// //       else
// //       o.result.push( o.sample.slice() );
// //
// //       return 1;
// //     }
// //
// //     return 0;
// //   }
// //
// //   /* */
// //
// //   function iterate()
// //   {
// //
// //     if( o.leftToRight )
// //     for( let i = 0 ; i < l ; i++ )
// //     {
// //       if( nextSample( i ) )
// //       return 1;
// //     }
// //     else for( let i = l - 1 ; i >= 0 ; i-- )
// //     {
// //       if( nextSample( i ) )
// //       return 1;
// //     }
// //
// //     return 0;
// //   }
// //
// //   /* */
// //
// //   if( !firstSample() )
// //   return o.result;
// //
// //   do
// //   {
// //     if( o.onEach )
// //     o.onEach.call( o.sample, o.sample, index );
// //   }
// //   while( iterate() );
// //
// //   if( o.result )
// //   return o.result;
// //   else
// //   return index;
// // }
// //
// // eachSample.defaults =
// // {
// //
// //   leftToRight : 1,
// //   onEach : null,
// //
// //   sets : null,
// //   sample : null,
// //
// //   result : 1,
// //
// // }
// //
// // //
// //
// // function eachInRange( o )
// // {
// //
// //   if( _.arrayIs( o ) )
// //   o = { range : o };
// //
// //   _.routineOptions( eachInRange,o );
// //   if( _.numberIs( o.range ) )
// //   o.range = [ 0,o.range ];
// //
// //   _.assert( arguments.length === 1, 'Expects single argument' );
// //   _.assert( o.range.length === 2 );
// //   _.assert( o.increment >= 0 );
// //
// //   let increment = o.increment;
// //   let range = o.range;
// //   let len = _.rangeNumberElements( range,o.increment );
// //   let value = range[ 0 ];
// //
// //   if( o.estimate )
// //   {
// //     return { length : len };
// //   }
// //
// //   if( o.result === null )
// //   o.result = new Float32Array( len );
// //
// //   // if( o.batch === 0 )
// //   // o.batch = o.range[ 1 ] - o.range[ 0 ];
// //
// //   /* begin */
// //
// //   if( o.onBegin )
// //   o.onBegin.call( o );
// //
// //   /* exec */
// //
// //   function exec()
// //   {
// //
// //     while( value < range[ 1 ] )
// //     {
// //
// //       if( o.onEach )
// //       o.onEach.call( o,value,o.resultIndex );
// //       if( o.result )
// //       o.result[ o.resultIndex ] = value;
// //
// //       value += increment;
// //       o.resultIndex += 1;
// //     }
// //
// //   }
// //
// //   if( len )
// //   exec();
// //
// //   /* end */
// //
// //   if( value > range[ 1 ] )
// //   if( o.onEnd )
// //   o.onEnd.call( o,o.result );
// //
// //   /* return */
// //
// //   if( o.result )
// //   return o.result;
// //   else
// //   return o.resultIndex;
// // }
// //
// // eachInRange.defaults =
// // {
// //   result : null,
// //   resultIndex : 0,
// //   range : null,
// //   onBegin : null,
// //   onEnd : null,
// //   onEach : null,
// //   increment : 1,
// //   delay : 0,
// //   estimate : 0,
// // }
// //
// // //
// //
// // function eachInManyRanges( o )
// // {
// //
// //   let len = 0;
// //
// //   if( _.arrayIs( o ) )
// //   o = { range : o };
// //
// //   _.routineOptions( eachInManyRanges,o );
// //   _.assert( arguments.length === 1, 'Expects single argument' );
// //   _.assert( _.arrayIs( o.range ) );
// //
// //   /* estimate */
// //
// //   for( let r = 0 ; r < o.range.length ; r++ )
// //   {
// //     let range = o.range[ r ];
// //     if( _.numberIs( o.range ) )
// //     range = o.range[ r ] = [ 0,o.range ];
// //     len += _.rangeNumberElements( range,o.increment );
// //   }
// //
// //   if( o.estimate )
// //   return { length : len };
// //
// //   /* exec */
// //
// //   if( o.result === null )
// //   o.result = new Float32Array( len );
// //
// //   let ranges = o.range;
// //   for( let r = 0 ; r < ranges.length ; r++ )
// //   {
// //     o.range = ranges[ r ];
// //     _.eachInRange( o );
// //   }
// //
// //   /* return */
// //
// //   if( o.result )
// //   return o.result;
// //   else
// //   return o.resultIndex;
// //
// // }
// //
// // eachInManyRanges.defaults = Object.create( eachInRange.defaults )
// //
// // //
// //
// // function eachInMultiRange( o )
// // {
// //
// //   if( !o.onEach )
// //   o.onEach = function( e )
// //   {
// //     console.log( e );
// //   }
// //
// //   _.routineOptions( eachInMultiRange,o );
// //   _.assert( _.objectIs( o ) )
// //   _.assert( _.arrayIs( o.ranges ) || _.objectIs( o.ranges ),'eachInMultiRange :','Expects o.ranges as array or object' )
// //   _.assert( _.routineIs( o.onEach ),'eachInMultiRange :','Expects o.onEach as routine' )
// //   _.assert( !o.delta || _.strType( o.delta ) === _.strType( o.ranges ),'eachInMultiRange :','o.delta must be same type as ranges' );
// //
// //   /* */
// //
// //   let iterationNumber = 1;
// //   let l = 0;
// //   let delta = _.objectIs( o.delta ) ? [] : null;
// //   let ranges = [];
// //   let names = null;
// //   if( _.objectIs( o.ranges ) )
// //   {
// //     _.assert( _.objectIs( o.delta ) || !o.delta );
// //
// //     names = [];
// //     let i = 0;
// //     for( let r in o.ranges )
// //     {
// //       names[ i ] = r;
// //       ranges[ i ] = o.ranges[ r ];
// //       if( o.delta )
// //       {
// //         if( !o.delta[ r ] )
// //         throw _.err( 'no delta for',r );
// //         delta[ i ] = o.delta[ r ];
// //       }
// //       i += 1;
// //     }
// //
// //     l = names.length;
// //
// //   }
// //   else
// //   {
// //     // ranges = o.ranges.slice();
// //     ranges = _.cloneJust( o.ranges );
// //     delta = _.longIs( o.delta ) ? o.delta.slice() : null;
// //     _.assert( !delta || ranges.length === delta.length, 'delta must be same length as ranges'  );
// //     l = o.ranges.length;
// //   }
// //
// //   let last = ranges.length-1;
// //
// //   /* adjust range */
// //
// //   function adjustRange( r )
// //   {
// //
// //     if( _.numberIs( ranges[ r ] ) )
// //     ranges[ r ] = [ 0,ranges[ r ] ];
// //
// //     if( !_.longIs( ranges[ r ] ) )
// //     throw _.err( 'Expects range as array :',ranges[ r ] );
// //
// //     _.assert( ranges[ r ].length === 2 );
// //     _.assert( _.numberIs( ranges[ r ][ 0 ] ) );
// //     _.assert( _.numberIs( ranges[ r ][ 1 ] ) );
// //
// //     if( _.numberIsInfinite( ranges[ r ][ 0 ] ) )
// //     ranges[ r ][ 0 ] = 1;
// //     if( _.numberIsInfinite( ranges[ r ][ 1 ] ) )
// //     ranges[ r ][ 1 ] = 1;
// //
// //     iterationNumber *= ranges[ r ][ 1 ] - ranges[ r ][ 0 ];
// //
// //   }
// //
// //   if( _.objectIs( ranges ) )
// //   for( let r in ranges )
// //   adjustRange( r );
// //   else
// //   for( let r = 0 ; r < ranges.length ; r++ )
// //   adjustRange( r );
// //
// //   /* estimate */
// //
// //   if( o.estimate )
// //   {
// //
// //     if( !ranges.length )
// //     return 0;
// //
// //     return { length : iterationNumber };
// //
// //   }
// //
// //   /* */
// //
// //   function getValue( arg ){ return arg.slice(); };
// //   if( names )
// //   getValue = function( arg )
// //   {
// //     let result = Object.create( null );
// //     for( let i = 0 ; i < names.length ; i++ )
// //     result[ names[ i ] ] = arg[ i ];
// //     return result;
// //   }
// //
// //   /* */
// //
// //   let indexFlat = 0;
// //   let indexNd = [];
// //   for( let r = 0 ; r < ranges.length ; r++ )
// //   {
// //     indexNd[ r ] = ranges[ r ][ 0 ];
// //     if( ranges[ r ][ 1 ] <= ranges[ r ][ 0 ] )
// //     return 0;
// //   }
// //
// //   /* */
// //
// //
// //   while( indexNd[ last ] < ranges[ last ][ 1 ] )
// //   {
// //
// //     let r = getValue( indexNd );
// //     if( o.result )
// //     o.result[ indexFlat ] = r;
// //
// //     let res = o.onEach.call( o,r,indexFlat );
// //
// //     if( res === false )
// //     break;
// //
// //     indexFlat += 1;
// //
// //     let c = 0;
// //     do
// //     {
// //       if( c >= ranges.length )
// //       break;
// //       if( c > 0 )
// //       indexNd[ c-1 ] = ranges[ c-1 ][ 0 ];
// //       if( delta )
// //       {
// //         _.assert( _.numberIsFinite( delta[ c ] ) && delta[ c ] > 0, 'delta must contain only positive numbers, incorrect element:', delta[ c ] );
// //         indexNd[ c ] += delta[ c ];
// //       }
// //       else
// //       indexNd[ c ] += 1;
// //       c += 1;
// //     }
// //     while( indexNd[ c-1 ] >= ranges[ c-1 ][ 1 ] );
// //
// //   }
// //
// //   /* */
// //
// //   if( o.result )
// //   return o.result
// //   else
// //   return indexFlat;
// // }
// //
// // eachInMultiRange.defaults =
// // {
// //   result : null,
// //   ranges : null,
// //   delta : null,
// //   onEach : null,
// //   estimate : 0,
// // }
// //
// // //
// //
// // function entityEach( src, onEach )
// // {
// //
// //   _.assert( arguments.length === 2 );
// //   _.assert( onEach.length <= 2 );
// //   _.assert( _.routineIs( onEach ) );
// //
// //   /* */
// //
// //   if( _.longIs( src ) )
// //   {
// //
// //     for( let k = 0 ; k < src.length ; k++ )
// //     {
// //       onEach( src[ k ], k, src );
// //     }
// //
// //   }
// //   else if( _.objectLike( src ) )
// //   {
// //
// //     for( let k in src )
// //     {
// //       onEach( src[ k ], k, src );
// //     }
// //
// //   }
// //   else
// //   {
// //     onEach( src, undefined, undefined );
// //   }
// //
// //   /* */
// //
// //   return src;
// // }
// //
// // //
// //
// // function entityEachName( src, onEach )
// // {
// //   _.assert( arguments.length === 2 );
// //   _.assert( onEach.length <= 2 );
// //   _.assert( _.routineIs( onEach ) );
// //
// //   /* */
// //
// //   if( _.longIs( src ) )
// //   {
// //
// //     for( let index = 0 ; index < src.length ; index++ )
// //     {
// //       onEach( src[ index ], undefined, index, src );
// //     }
// //
// //   }
// //   else if( _.objectLike( src ) )
// //   {
// //
// //     let index = 0;
// //     for( let k in src )
// //     {
// //       onEach( k, src[ k ], index, src );
// //       index += 1;
// //     }
// //
// //   }
// //   else
// //   {
// //     onEach( src, undefined, undefined, undefined );
// //   }
// //
// //   /* */
// //
// //   return src;
// //
// //   // if( arguments.length === 2 )
// //   // o = { src : arguments[ 0 ], onUp : arguments[ 1 ] }
// //   //
// //   // _.routineOptions( eachName, o );
// //   // _.assert( arguments.length === 1 || arguments.length === 2 );
// //   // _.assert( o.onUp && o.onUp.length <= 3 );
// //   //
// //   // /* */
// //   //
// //   // if( _.longIs( o.src ) )
// //   // {
// //   //
// //   //   for( let index = 0 ; index < o.src.length ; index++ )
// //   //   {
// //   //     o.onUp.call( o, o.src[ index ], undefined, index );
// //   //   }
// //   //
// //   // }
// //   // else if( _.objectLike( o.src ) )
// //   // {
// //   //
// //   //   let index = 0;
// //   //   for( let k in o.src )
// //   //   {
// //   //     o.onUp.call( o, k, o.src[ k ], index );
// //   //     index += 1;
// //   //   }
// //   //
// //   // }
// //   // else _.assert( 0, 'not container' );
// //   //
// //   // /* */
// //   //
// //   // return src;
// // }
// //
// // var defaults = entityEachName.defaults = Object.create( null );
// //
// // defaults.src = null;
// // defaults.onUp = function( e,k ){};
// //
// // //
// //
// // function entityEachOwn( src, onEach )
// // {
// //
// //   _.assert( arguments.length === 2 );
// //   _.assert( onEach.length <= 2 );
// //   _.assert( _.routineIs( onEach ) );
// //
// //   /* */
// //
// //   if( _.longIs( src ) )
// //   {
// //
// //     for( let k = 0 ; k < src.length ; k++ )
// //     {
// //       onEach( src[ k ], k, src );
// //     }
// //
// //   }
// //   else if( _.objectLike( src ) )
// //   {
// //
// //     for( let k in src )
// //     {
// //       if( !_ObjectHasOwnProperty.call( src, k ) )
// //       continue;
// //       onEach( src[ k ], k, src );
// //     }
// //
// //   }
// //   else
// //   {
// //     onEach( src, undefined, undefined );
// //   }
// //
// //   /* */
// //
// //   return src;
// // }
// //
// // //
// //
// // function entityAll( src, onEach )
// // {
// //   let result = true;
// //
// //   _.assert( arguments.length === 1 || arguments.length === 2 );
// //   _.assert( onEach === undefined || ( _.routineIs( onEach ) && onEach.length <= 2 ) );
// //
// //   /* */
// //
// //   if( _.routineIs( onEach ) )
// //   {
// //
// //     if( _.longIs( src ) )
// //     {
// //
// //       for( let k = 0 ; k < src.length ; k++ )
// //       {
// //         result = onEach( src[ k ], k, src );
// //         if( !result )
// //         return result;
// //       }
// //
// //     }
// //     else if( _.objectLike( src ) )
// //     {
// //
// //       for( let k in src )
// //       {
// //         result = onEach( src[ k ], k, src );
// //         if( !result )
// //         return result;
// //       }
// //
// //     }
// //     else
// //     {
// //       result = onEach( src, undefined, undefined );
// //       if( !result )
// //       return result;
// //     }
// //
// //   }
// //   else
// //   {
// //
// //     if( _.longIs( src ) )
// //     {
// //
// //       for( let k = 0 ; k < src.length ; k++ )
// //       {
// //         result = src[ k ];
// //         if( !result )
// //         return result;
// //       }
// //
// //     }
// //     else if( _.objectLike( src ) )
// //     {
// //
// //       for( let k in src )
// //       {
// //         result = src[ k ];
// //         if( !result )
// //         return result;
// //       }
// //
// //     }
// //     else
// //     {
// //       result = src;
// //       if( !result )
// //       return result;
// //     }
// //
// //   }
// //
// //   /* */
// //
// //   return true;
// // }
// //
// // //
// //
// // function entityAny( src, onEach )
// // {
// //   let result = false;
// //
// //   _.assert( arguments.length === 1 || arguments.length === 2 );
// //   _.assert( onEach === undefined || ( _.routineIs( onEach ) && onEach.length <= 2 ) );
// //
// //   /* */
// //
// //   if( _.routineIs( onEach ) )
// //   {
// //
// //     if( _.longIs( src ) )
// //     {
// //
// //       for( let k = 0 ; k < src.length ; k++ )
// //       {
// //         result = onEach( src[ k ], k, undefined );
// //         if( result )
// //         return result;
// //       }
// //
// //     }
// //     else if( _.objectLike( src ) )
// //     {
// //
// //       for( let k in src )
// //       {
// //         result = onEach( src[ k ], k, undefined );
// //         if( result )
// //         return result;
// //       }
// //
// //     }
// //     else
// //     {
// //       result = onEach( src, undefined, undefined );
// //       if( result )
// //       return result;
// //     }
// //
// //   }
// //   else
// //   {
// //
// //     if( _.longIs( src ) )
// //     {
// //
// //       for( let k = 0 ; k < src.length ; k++ )
// //       {
// //         result = src[ k ];
// //         if( result )
// //         return result;
// //       }
// //
// //     }
// //     else if( _.objectLike( src ) )
// //     {
// //
// //       for( let k in src )
// //       {
// //         result = src[ k ];
// //         if( result )
// //         return result;
// //       }
// //
// //     }
// //     else
// //     {
// //       result = src;
// //       if( result )
// //       return result;
// //     }
// //
// //   }
// //
// //   /* */
// //
// //   return false;
// // }
// //
// // //
// //
// // function entityNone( src, onEach )
// // {
// //   let result = true;
// //
// //   _.assert( arguments.length === 1 || arguments.length === 2 );
// //   _.assert( onEach === undefined || ( _.routineIs( onEach ) && onEach.length <= 2 ) );
// //
// //   /* */
// //
// //   if( _.routineIs( onEach ) )
// //   {
// //
// //     if( _.longIs( src ) )
// //     {
// //
// //       for( let k = 0 ; k < src.length ; k++ )
// //       {
// //         result = onEach( src[ k ], k, src );
// //         if( result )
// //         return !result;
// //       }
// //
// //     }
// //     else if( _.objectLike( src ) )
// //     {
// //
// //       for( let k in src )
// //       {
// //         result = onEach( src[ k ], k, src );
// //         if( result )
// //         return !result;
// //       }
// //
// //     }
// //     else
// //     {
// //       result = onEach( src, undefined, undefined );
// //       if( result )
// //       return !result;
// //     }
// //
// //   }
// //   else
// //   {
// //
// //     if( _.longIs( src ) )
// //     {
// //
// //       for( let k = 0 ; k < src.length ; k++ )
// //       {
// //         result = src[ k ];
// //         if( result )
// //         return !result;
// //       }
// //
// //     }
// //     else if( _.objectLike( src ) )
// //     {
// //
// //       for( let k in src )
// //       {
// //         result = src[ k ];
// //         if( result )
// //         return !result;
// //       }
// //
// //     }
// //     else
// //     {
// //       result = src;
// //       if( result )
// //       return !result;
// //     }
// //
// //   }
// //
// //   /* */
// //
// //   return true;
// // }
// //
// // //
// //
// // /**
// //  * Function that produces an elements for entityMap result
// //  * @callback wTools~onEach
// //  * @param {*} val - The current element being processed in the entity.
// //  * @param {string|number} key - The index (if entity is array) or key of processed element.
// //  * @param {Array|Object} src - The src passed to entityMap.
// //  */
// //
// // /**
// //  * Creates new instance with same as( src ) type. Elements of new instance results of calling a provided ( onEach )
// //  * function on every element of src. If entity is array, the new array has the same length as source.
// //  *
// //  * @example
// //   let numbers = [ 3, 4, 6 ];
// //
// //   function sqr( v )
// //   {
// //     return v * v
// //   };
// //
// //   let res = wTools.entityMap(numbers, sqr);
// //   // [ 9, 16, 36 ]
// //   // numbers is still [ 3, 4, 6 ]
// //
// //   function checkSidesOfTriangle( v, i, src )
// //   {
// //     let sumOthers = 0,
// //       l = src.length,
// //       j;
// //
// //     for ( j = 0; j < l; j++ )
// //     {
// //       if ( i === j ) continue;
// //       sumOthers += src[ j ];
// //     }
// //     return v < sumOthers;
// //   }
// //
// //   let res = wTools.entityMap( numbers, checkSidesOfTriangle );
// //  // [ true, true, true ]
// //  *
// //  * @param {ArrayLike|ObjectLike} src - Entity, on each elements of which will be called ( onEach ) function.
// //  * @param {wTools~onEach} onEach - Function that produces an element of the new entity.
// //  * @returns {ArrayLike|ObjectLike} New entity.
// //  * @thorws {Error} If number of arguments less or more than 2.
// //  * @thorws {Error} If( src ) is not Array or ObjectLike.
// //  * @thorws {Error} If( onEach ) is not function.
// //  * @function entityMap
// //  * @memberof wTools
// //  */
// //
// // function entityMap( src,onEach )
// // {
// //
// //   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
// //   _.assert( _.routineIs( onEach ) );
// //
// //   let result;
// //
// //   if( _.longIs( src ) )
// //   {
// //     result = _.entityMake( src );
// //     for( let s = 0 ; s < src.length ; s++ )
// //     {
// //       result[ s ] = onEach( src[ s ], s, src );
// //       _.assert( result[ s ] !== undefined,'{-entityMap-} onEach should return defined values, to been able return undefined to delete element use ( entityFilter )' )
// //     }
// //   }
// //   else if( _.objectLike( src ) )
// //   {
// //     result = _.entityMake( src );
// //     for( let s in src )
// //     {
// //       result[ s ] = onEach( src[ s ], s, src );
// //       _.assert( result[ s ] !== undefined,'{-entityMap-} onEach should return defined values, to been able return undefined to delete element use ( entityFilter )' )
// //     }
// //   }
// //   else
// //   {
// //     result = onEach( src, undefined, undefined );
// //     _.assert( result !== undefined,'{-entityMap-} onEach should return defined values, to been able return undefined to delete element use ( entityFilter )' )
// //
// //   }
// //
// //   return result;
// // }
// //
// // //
// //
// // /**
// //  * Returns generated function that takes single argument( e ) and can be called to check if object( e )
// //  * has at least one key/value pair that is represented in( condition ).
// //  * If( condition ) is provided as routine, routine uses it to check condition.
// //  * Generated function returns origin( e ) if conditions is true, else undefined.
// //  *
// //  * @param {object|function} condition - Map to compare with( e ) or custom function.
// //  * @returns {function} Returns condition check function.
// //  *
// //  * @example
// //  * //returns Object {a: 1}
// //  * let check = _._filter_functor( { a : 1, b : 1, c : 1 } );
// //  * check( { a : 1 } );
// //  *
// //  * @example
// //  * //returns false
// //  * function condition( src ){ return src.y === 1 }
// //  * let check = _._filter_functor( condition );
// //  * check( { a : 2 } );
// //  *
// //  * @function _filter_functor
// //  * @throws {exception} If no argument provided.
// //  * @throws {exception} If( condition ) is not a Routine or Object.
// //  * @memberof wTools
// // */
// //
// // function _filter_functor( condition, levels )
// // {
// //   let result;
// //
// //   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
// //   _.assert( _.routineIs( condition ) || _.objectIs( condition ) );
// //
// //   if( _.objectIs( condition ) )
// //   {
// //     let template = condition;
// //     condition = function selector( e, k, src )
// //     {
// //       _.assert( arguments.length === 3 );
// //       if( e === template )
// //       return e;
// //       if( !_.objectLike( e ) )
// //       return;
// //       let satisfied = _.mapSatisfy
// //       ({
// //         template : template,
// //         src : e,
// //         levels : levels
// //       });
// //       if( satisfied )
// //       return e;
// //     };
// //   }
// //
// //   return condition;
// // }
// //
// // //
// //
// // function entityFilter( src, onEach )
// // {
// //   let result;
// //   onEach = _._filter_functor( onEach, 1 );
// //
// //   _.assert( arguments.length === 2 );
// //   _.assert( _.objectLike( src ) || _.longIs( src ), () => 'Expects objectLike or longIs src, but got ' + _.strType( src ) );
// //   _.assert( _.routineIs( onEach ) );
// //
// //   /* */
// //
// //   if( _.longIs( src ) )
// //   {
// //     result = _.longMake( src,0 );
// //     for( let s = 0, d = 0 ; s < src.length ; s++, d++ )
// //     {
// //       let r = onEach.call( src,src[ s ],s,src );
// //       if( r === undefined )
// //       d--;
// //       else
// //       result[ d ] = r;
// //     }
// //     if( d < src.length )
// //     result = _.arraySlice( result, 0, d );
// //   }
// //   else
// //   {
// //     result = _.entityMake( src );
// //     for( let s in src )
// //     {
// //       r = onEach.call( src,src[ s ],s,src );
// //       if( r !== undefined )
// //       result[ s ] = r;
// //     }
// //   }
// //
// //   /* */
// //
// //   return result;
// // }
// //
// // //
// //
// // function _entityFilterDeep( o )
// // {
// //
// //   let result;
// //   let onEach = _._filter_functor( o.onEach,o.conditionLevels );
// //
// //   _.assert( arguments.length === 1, 'Expects single argument' );
// //   _.assert( _.objectLike( o.src ) || _.longIs( o.src ),'entityFilter : expects objectLike or longIs src, but got',_.strType( o.src ) );
// //   _.assert( _.routineIs( onEach ) );
// //
// //   /* */
// //
// //   if( _.longIs( o.src ) )
// //   {
// //     result = _.longMake( o.src,0 );
// //     for( let s = 0, d = 0 ; s < o.src.length ; s++, d++ )
// //     {
// //       let r = onEach.call( o.src,o.src[ s ],s,o.src );
// //       if( r === undefined )
// //       d--;
// //       else
// //       result[ d ] = r;
// //     }
// //     debugger;
// //     if( d < o.src.length )
// //     result = _.arraySlice( result, 0, d );
// //   }
// //   else
// //   {
// //     result = _.entityMake( o.src );
// //     for( let s in o.src )
// //     {
// //       r = onEach.call( o.src,o.src[ s ],s,o.src );
// //       if( r !== undefined )
// //       result[ s ] = r;
// //     }
// //   }
// //
// //   /* */
// //
// //   return result;
// // }
// //
// // _entityFilterDeep.defaults =
// // {
// //   src : null,
// //   onEach : null,
// //   conditionLevels : 1,
// // }
// //
// // //
// //
// // function entityFilterDeep( src, onEach )
// // {
// //   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
// //   return _entityFilterDeep
// //   ({
// //     src : src,
// //     onEach : onEach,
// //     conditionLevels : 1024,
// //   });
// // }
// //
// // //
// //
// // function entityShallowClone( src )
// // {
// //
// //   if( _.primitiveIs( src ) )
// //   return src;
// //   else if( _.mapIs( src ) )
// //   return _.mapShallowClone( src )
// //   else if( _.longIs( src ) )
// //   return _.longShallowClone( src );
// //   else _.assert( 0, 'Not clear how to shallow clone', _.strType( src ) );
// //
// // }
//
// // --
// // entity modifier
// // --
//
// function enityExtend( dst, src )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//
//   if( _.objectIs( src ) || _.longIs( src ) )
//   {
//
//     _.each( src,function( e,k )
//     {
//       dst[ k ] = e;
//     });
//
//   }
//   else
//   {
//
//     dst = src;
//
//   }
//
//   return dst;
// }
//
// //
//
// function enityExtendAppending( dst,src )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//
//   if( _.objectIs( src ) )
//   {
//
//     _.each( src,function( e,k )
//     {
//       dst[ k ] = e;
//     });
//
//   }
//   else if( _.longIs( src ) )
//   {
//
//     if( dst === null || dst === undefined )
//     dst = _.longSlice( src );
//     else
//     _.arrayAppendArray( dst,src );
//
//   }
//   else
//   {
//
//     dst = src;
//
//   }
//
//   return dst;
// }
//
// //
//
// function entityMake( src,length )
// {
//
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   if( _.arrayIs( src ) )
//   {
//     return new Array( length !== undefined ? length : src.length );
//   }
//   else if( _.longIs( src ) )
//   {
//     if( _.bufferTypedIs( src ) || _.bufferNodeIs( src ) )
//     return new src.constructor( length !== undefined ? length : src.length );
//     else
//     return new Array( length !== undefined ? length : src.length );
//   }
//   else if( _.mapIs( src ) )
//   {
//     return Object.create( null );
//   }
//   else if( _.objectIs( src ) )
//   {
//     return new src.constructor();
//   }
//   else _.assert( 0,'unexpected' );
//
// }
//
// //
//
// function entityMakeTivial( src,length )
// {
//
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   if( _.arrayIs( src ) )
//   {
//     return new Array( length !== undefined ? length : src.length );
//   }
//   else if( _.longIs( src ) )
//   {
//     if( _.bufferTypedIs( src ) || _.bufferNodeIs( src ) )
//     return new src.constructor( length !== undefined ? length : src.length );
//     else
//     return new Array( length !== undefined ? length : src.length );
//   }
//   else if( _.objectIs( src ) )
//   {
//     return Object.create( null );
//   }
//   else _.assert( 0,'unexpected' );
//
// }
//
// //
//
// /**
//  * Copies entity( src ) into( dst ) or returns own copy of( src ).Result depends on several moments:
//  * -If( src ) is a Object - returns clone of( src ) using ( onRecursive ) callback function if its provided;
//  * -If( dst ) has own 'copy' routine - copies( src ) into( dst ) using this routine;
//  * -If( dst ) has own 'set' routine - sets the fields of( dst ) using( src ) passed to( dst.set );
//  * -If( src ) has own 'clone' routine - returns clone of( src ) using ( src.clone ) routine;
//  * -If( src ) has own 'slice' routine - returns result of( src.slice ) call;
//  * -Else returns a copy of entity( src ).
//  *
//  * @param {object} dst - Destination object.
//  * @param {object} src - Source object.
//  * @param {routine} onRecursive - The callback function to copy each [ key, value ].
//  * @see {@link wTools.mapCloneAssigning} Check this function for more info about( onRecursive ) callback.
//  * @returns {object} Returns result of entities copy operation.
//  *
//  * @example
//  * let dst = { set : function( src ) { this.str = src.src } };
//  * let src = { src : 'string' };
//  *  _.entityAssign( dst, src );
//  * console.log( dst.str )
//  * //returns "string"
//  *
//  * @example
//  * let dst = { copy : function( src ) { for( let i in src ) this[ i ] = src[ i ] } }
//  * let src = { src : 'string', num : 123 }
//  *  _.entityAssign( dst, src );
//  * console.log( dst )
//  * //returns Object {src: "string", num: 123}
//  *
//  * @example
//  * //returns 'string'
//  *  _.entityAssign( null, new String( 'string' ) );
//  *
//  * @function entityAssign
//  * @throws {exception} If( arguments.length ) is not equal to 3 or 2.
//  * @throws {exception} If( onRecursive ) is not a Routine.
//  * @memberof wTools
//  *
//  */
//
// function entityAssign( dst,src,onRecursive )
// {
//   let result;
//
//   _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
//   _.assert( arguments.length < 3 || _.routineIs( onRecursive ) );
//
//   if( src === null )
//   {
//
//     result = src;
//
//   }
//   else if( dst && _.routineIs( dst.copy ) )
//   {
//
//     dst.copy( src );
//
//   }
//   else if( src && _.routineIs( src.clone ) )
//   {
//
//     if( dst instanceof src.constructor )
//     {
//       throw _.err( 'not tested' );
//       result = src.clone( dst );
//     }
//     else if( _.primitiveIs( dst ) || _.longIs( dst ) )
//     {
//       result = src.clone();
//     }
//     else _.assert( 0,'unknown' );
//
//   }
//   else if( src && _.routineIs( src.slice ) )
//   {
//
//     result = src.slice();
//
//   }
//   else if( dst && _.routineIs( dst.set ) )
//   {
//
//     dst.set( src );
//
//   }
//   else if( _.objectIs( src ) )
//   {
//
//     if( onRecursive )
//     result = _.mapCloneAssigning({ srcMap : src, dstMap : _.primitiveIs( dst ) ? Object.create( null ) : dst, onField : onRecursive } );
//     else
//     result = _.mapCloneAssigning({ srcMap : src });
//
//   }
//   else
//   {
//
//     result = src;
//
//   }
//
//   return result;
// }
//
// //
//
// /**
//  * Short-cut for entityAssign function. Copies specified( name ) field from
//  * source container( srcContainer ) into( dstContainer ).
//  *
//  * @param {object} dstContainer - Destination object.
//  * @param {object} srcContainer - Source object.
//  * @param {string} name - Field name.
//  * @param {mapCloneAssigning~onField} onRecursive - The callback function to copy each [ key, value ].
//  * @see {@link wTools.mapCloneAssigning} Check this function for more info about( onRecursive ) callback.
//  * @returns {object} Returns result of entities copy operation.
//  *
//  * @example
//  * let dst = {};
//  * let src = { a : 'string' };
//  * let name = 'a';
//  * _.entityAssignFieldFromContainer(dst, src, name );
//  * console.log( dst.a === src.a );
//  * //returns true
//  *
//  * @example
//  * let dst = {};
//  * let src = { a : 'string' };
//  * let name = 'a';
//  * function onRecursive( dstContainer,srcContainer,key )
//  * {
//  *   _.assert( _.strIs( key ) );
//  *   dstContainer[ key ] = srcContainer[ key ];
//  * };
//  * _.entityAssignFieldFromContainer(dst, src, name, onRecursive );
//  * console.log( dst.a === src.a );
//  * //returns true
//  *
//  * @function entityAssignFieldFromContainer
//  * @throws {exception} If( arguments.length ) is not equal to 3 or 4.
//  * @memberof wTools
//  *
//  */
//
// function entityAssignFieldFromContainer( dstContainer, srcContainer, name, onRecursive )
// {
//   let result;
//
//   _.assert( _.strIs( name ) || _.symbolIs( name ) );
//   _.assert( arguments.length === 3 || arguments.length === 4 );
//
//   let dstValue = _ObjectHasOwnProperty.call( dstContainer,name ) ? dstContainer[ name ] : undefined;
//   let srcValue = srcContainer[ name ];
//
//   if( onRecursive )
//   result = entityAssign( dstValue, srcValue, onRecursive );
//   else
//   result = entityAssign( dstValue, srcValue );
//
//   if( result !== undefined )
//   dstContainer[ name ] = result;
//
//   return result;
// }
//
// //
//
// /**
//  * Short-cut for entityAssign function. Assigns value of( srcValue ) to container( dstContainer ) field specified by( name ).
//  *
//  * @param {object} dstContainer - Destination object.
//  * @param {object} srcValue - Source value.
//  * @param {string} name - Field name.
//  * @param {mapCloneAssigning~onField} onRecursive - The callback function to copy each [ key, value ].
//  * @see {@link wTools.mapCloneAssigning} Check this function for more info about( onRecursive ) callback.
//  * @returns {object} Returns result of entity field assignment operation.
//  *
//  * @example
//  * let dstContainer = { a : 1 };
//  * let srcValue = 15;
//  * let name = 'a';
//  * _.entityAssignField( dstContainer, srcValue, name );
//  * console.log( dstContainer.a );
//  * //returns 15
//  *
//  * @function entityAssignField
//  * @throws {exception} If( arguments.length ) is not equal to 3 or 4.
//  * @memberof wTools
//  *
//  */
//
// function entityAssignField( dstContainer,srcValue,name,onRecursive )
// {
//   let result;
//
//   _.assert( _.strIs( name ) || _.symbolIs( name ) );
//   _.assert( arguments.length === 3 || arguments.length === 4 );
//
//   let dstValue = dstContainer[ name ];
//
//   if( onRecursive )
//   {
//     throw _.err( 'not tested' );
//     result = entityAssign( dstValue, srcValue,onRecursive );
//   }
//   else
//   {
//     result = entityAssign( dstValue, srcValue );
//   }
//
//   if( result !== undefined )
//   dstContainer[ name ] = result;
//
//   return result;
// }
//
// //
//
// /**
//  * Returns atomic entity( src ) casted into type of entity( ins ) to avoid unexpected implicit type casts.
//  *
//  * @param {object} src - Source object.
//  * @param {object} ins - Type of( src ) depends on type of this object.
//  * @returns {object} Returns object( src ) with  type of( ins ).
//  *
//  * @example
//  * //returns "string"
//  * typeof _.entityCoerceTo( 1, '1' )
//  *
//  * @example
//  * //returns "number"
//  * typeof _.entityCoerceTo( "1" , 1 )
//  *
//  * @example
//  * //returns "boolean"
//  * typeof _.entityCoerceTo( "1" , true )
//  *
//  * @function entityCoerceTo
//  * @throws {exception} If only one or no arguments provided.
//  * @throws {exception} If type of( ins ) is not supported.
//  * @memberof wTools
//  *
//  */
//
// function entityCoerceTo( src,ins )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//
//   if( _.numberIs( ins ) )
//   {
//
//     return _.numberFrom( src );
//
//   }
//   else if( _.strIs( ins ) )
//   {
//
//     return _.strFrom( src );
//
//   }
//   else if( _.boolIs( ins ) )
//   {
//
//     return _.boolFrom( src );
//
//   }
//   else _.assert( 0,'unknown type to coerce to : ' + _.strType( ins ) );
//
// }
//
// //
//
// function entityFreeze( src )
// {
//   let _src = src;
//
//   if( _.bufferTypedIs( src ) )
//   {
//     src = src.buffer;
//     debugger;
//   }
//
//   Object.freeze( src );
//
//   return _src;
// }

// --
// entity getter
// --

/**
 * Returns "length" of entity( src ). Representation of "length" depends on type of( src ):
 *  - For object returns number of it own enumerable properties;
 *  - For array or array-like object returns value of length property;
 *  - For undefined returns 0;
 *  - In other cases returns 1.
 *
 * @param {*} src - Source entity.
 * @returns {number} Returns "length" of entity.
 *
 * @example
 * //returns 3
 * _.entityLength( [ 1, 2, 3 ] );
 *
 * @example
 * //returns 1
 * _.entityLength( 'string' );
 *
 * @example
 * //returns 2
 * _.entityLength( { a : 1, b : 2 } );
 *
 * @example
 * //returns 0
 * let src = undefined;
 * _.entityLength( src );
 *
 * @function entityLength
 * @memberof wTools
*/

function entityLength( src )
{
  if( src === undefined ) return 0;
  if( _.longIs( src ) )
  return src.length;
  else if( _.objectLike( src ) )
  return _.mapOwnKeys( src ).length;
  else return 1;
}

//

/**
 * Returns "size" of entity( src ). Representation of "size" depends on type of( src ):
 *  - For string returns value of it own length property;
 *  - For array-like entity returns value of it own byteLength property for( ArrayBuffer, TypedArray, etc )
 *    or length property for other;
 *  - In other cases returns null.
 *
 * @param {*} src - Source entity.
 * @returns {number} Returns "size" of entity.
 *
 * @example
 * //returns 6
 * _.entitySize( 'string' );
 *
 * @example
 * //returns 3
 * _.entitySize( [ 1, 2, 3 ] );
 *
 * @example
 * //returns 8
 * _.entitySize( new ArrayBuffer( 8 ) );
 *
 * @example
 * //returns null
 * _.entitySize( 123 );
 *
 * @function entitySize
 * @memberof wTools
*/

function entitySize( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.strIs( src ) )
  return src.length;

  if( _.primitiveIs( src ) )
  return null;

  if( _.numberIs( src.byteLength ) )
  return src.byteLength;

  if( _.longIs( src ) )
  return src.length;

  return null;
}

//

/**
 * Returns value from entity( src ) using position provided by argument( index ).
 * For object routine iterates over all properties and returns value when counter reaches( index ).
 *
 * @param {*} src - Source entity.
 * @param {number} index - Specifies position of needed value.
 * @returns {*} Returns value at specified position.
 *
 * @example
 * //returns 1
 * _.entityValueWithIndex( [ 1, 2, 3 ], 0);
 *
 * @example
 * //returns 123
 * _.entityValueWithIndex( { a : 'str', b : 123 }, 1 )
 *
 * @example
 * //returns undefined
 * _.entityValueWithIndex( { a : 'str', b : 123 }, 2 )
 *
 * @function entityValueWithIndex
 * @memberof wTools
*/

function entityValueWithIndex( src,index )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.numberIs( index ) );

  if( _.arrayLike( src ) )
  {
    return src[ index ];
  }
  else if( _.objectIs( src ) )
  {
    let i = 0;
    for( let s in src )
    {
      if( i === index )
      return src[ s ];
      i++;
    }
  }
  else if( _.strIs( src ) )
  {
    return src[ index ];
  }
  else _.assert( 0,'unknown kind of argument',_.strType( src ) );

}

//

/**
 * Searchs value( value ) in entity( src ) and returns index/key that represent that value or
 * null if nothing finded.
 *
 * @param {*} src - Source entity.
 * @param {*} value - Specifies value to search.
 * @returns {*} Returns specific index/key or null.
 *
 * @example
 * //returns 2
 * _.entityKeyWithValue( [ 1, 2, 3 ], 3);
 *
 * @example
 * //returns null
 * _.entityKeyWithValue( { a : 'str', b : 123 }, 1 )
 *
 * @example
 * //returns "b"
 * _.entityKeyWithValue( { a : 'str', b : 123 }, 123 )
 *
 * @function entityKeyWithValue
 * @memberof wTools
*/

function entityKeyWithValue( src,value )
{
  let result = null;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( _.arrayLike( src ) )
  {
    result = src.indexOf( value );
  }
  else if( _.objectIs( src ) )
  {
    let i = 0;
    for( let s in src )
    {
      if( src[ s ] == value ) return s;
    }
  }
  else if( _.strIs( src ) )
  {
    result = src.indexOf( value );
  }
  else _.assert( 0,'unknown kind of argument',_.strType( src ) );

  if( result === -1 )
  result = null;

  return result;
}

//

function entityVals( src )
{
  let result = [];

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !_.primitiveIs( src ) );

  if( _.longIs( src ) )
  return src;

  for( let s in src )
  result.push( src[ s ] );

  return result;
}

//

/**
 * The result of _entityMost routine object.
 * @typedef {Object} wTools~entityMostResult
 * @property {Number} index - Index of found element.
 * @property {String|Number} key - If the search was on map, the value of this property sets to key of found element.
 * Else if search was on array - to index of found element.
 * @property {Number} value - The found result of onEvaluate, if onEvaluate don't set, this value will be same as element.
 * @property {Number} element - The appropriate element for found value.
 */

/**
 * Returns object( wTools~entityMostResult ) that contains min or max element of entity, it depends on( returnMax ).
 *
 * @param {ArrayLike|Object} src - Source entity.
 * @param {Function} onEvaluate  - ( onEach ) function is called for each element of( src ).If undefined routine uses it own function.
 * @param {Boolean} returnMax  - If true - routine returns maximum, else routine returns minimum value from entity.
 * @returns {wTools~entityMostResult} Object with result of search.
 *
 * @example
 * //returns { index: 0, key: 0, value: 1, element: 1 }
 * _._entityMost([ 1, 3, 3, 9, 10 ], undefined, 0 );
 *
 * @example
 * //returns { index: 4, key: 4, value: 10, element: 10 }
 * _._entityMost( [ 1, 3, 3, 9, 10 ], undefined, 1 );
 *
 * @example
 * //returns { index: 4, key: 4, value: 10, element: 10 }
 * _._entityMost( { a : 1, b : 2, c : 3 }, undefined, 0 );
 *
 * @private
 * @function _entityMost
 * @throws {Exception} If( arguments.length ) is not equal 3.
 * @throws {Exception} If( onEvaluate ) function is not implemented.
 * @memberof wTools
 */

function _entityMost( src, onEvaluate, returnMax )
{

  if( onEvaluate === undefined )
  onEvaluate = function( element ){ return element; }

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( onEvaluate.length === 1,'not mplemented' );

  let onCompare = null;

  if( returnMax )
  onCompare = function( a,b )
  {
    return a-b;
  }
  else
  onCompare = function( a,b )
  {
    return b-a;
  }

  _.assert( onEvaluate.length === 1 );
  _.assert( onCompare.length === 2 );

  let result = { index : -1, key : undefined, value : undefined, element : undefined };

  if( _.longIs( src ) )
  {

    if( src.length === 0 )
    return result;
    result.key = 0;
    result.value = onEvaluate( src[ 0 ] );
    result.element = src[ 0 ];

    for( let s = 0 ; s < src.length ; s++ )
    {
      let value = onEvaluate( src[ s ] );
      if( onCompare( value,result.value ) > 0 )
      {
        result.key = s;
        result.value = value;
        result.element = src[ s ];
      }
    }
    result.index = result.key;

  }
  else
  {

    debugger;
    for( let s in src )
    {
      result.index = 0;
      result.key = s;
      result.value = onEvaluate( src[ s ] );
      result.element = src[ s ]
      break;
    }

    let index = 0;
    for( let s in src )
    {
      let value = onEvaluate( src[ s ] );
      if( onCompare( value,result.value ) > 0 )
      {
        result.index = index;
        result.key = s;
        result.value = value;
        result.element = src[ s ];
      }
      index += 1;
    }

  }

  return result;
}

//

/**
 * Short-cut for _entityMost() routine. Returns object( wTools~entityMostResult ) with smallest value from( src ).
 *
 * @param {ArrayLike|Object} src - Source entity.
 * @param {Function} onEvaluate  - ( onEach ) function is called for each element of( src ).If undefined routine uses it own function.
 * @returns {wTools~entityMostResult} Object with result of search.
 *
 * @example
 *  //returns { index : 2, key : 'c', value 3: , element : 9  };
 *  let obj = { a : 25, b : 16, c : 9 };
 *  let min = wTools.entityMin( obj, Math.sqrt );
 *
 * @see wTools~onEach
 * @see wTools~entityMostResult
 * @function entityMin
 * @throws {Exception} If missed arguments.
 * @throws {Exception} If passed extra arguments.
 * @memberof wTools
 */

function entityMin( src,onEvaluate )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  return _entityMost( src,onEvaluate,0 );
}

//

/**
 * Short-cut for _entityMost() routine. Returns object( wTools~entityMostResult ) with biggest value from( src ).
 *
 * @param {ArrayLike|Object} src - Source entity.
 * @param {Function} onEvaluate  - ( onEach ) function is called for each element of( src ).If undefined routine uses it own function.
 * @returns {wTools~entityMostResult} Object with result of search.
 *
 * @example
 *  //returns { index: 0, key: "a", value: 25, element: 25 };
 *  let obj = { a: 25, b: 16, c: 9 };
 *  let max = wTools.entityMax( obj );
 *
 * @see wTools~onEach
 * @see wTools~entityMostResult
 * @function entityMax
 * @throws {Exception} If missed arguments.
 * @throws {Exception} If passed extra arguments.
 * @memberof wTools
 */

function entityMax( src,onEvaluate )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  return _entityMost( src, onEvaluate, 1 );
}

// // --
// // entity checker
// // --
//
// /**
//  * Checks if object( src ) has any NaN. Also works with arrays and maps. Works recursively.
//  *
//  * @param {object} src - Source object.
//  * @returns {boolean} Returns result of check for NaN.
//  *
//  * @example
//  * //returns true
//  * _.entityHasNan( NaN )
//  *
//  * @example
//  * //returns true
//  * let arr = [ NaN, 1, 2 ];
//  * _.entityHasNan( arr );
//  *
//  * @function entityHasNan
//  * @throws {exception} If no argument provided.
//  * @memberof wTools
//  *
//  */
//
// function entityHasNan( src )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//
//   let result = false;
//   if( src === undefined )
//   {
//     return true;
//   }
//   else if( _.numberIs( src ) )
//   {
//     return isNaN( src );
//   }
//   else if( _.arrayLike( src ) )
//   {
//     for( let s = 0 ; s < src.length ; s++ )
//     if( entityHasNan( src[ s ] ) )
//     {
//       return true;
//     }
//   }
//   else if( _.objectIs( src ) )
//   {
//     for( s in src )
//     if( entityHasNan( src[ s ] ) )
//     {
//       return true;
//     }
//   }
//
//   return result;
// }
//
// //
//
// /**
//  * Checks if object( src ) or array has any undefined property. Works recursively.
//  *
//  * @param {object} src - Source object.
//  * @returns {boolean} Returns result of check for undefined.
//  *
//  * @example
//  * //returns true
//  * _.entityHasUndef( undefined )
//  *
//  * @example
//  * //returns true
//  * let arr = [ undefined, 1, 2 ];
//  * _.entityHasUndef( arr );
//  *
//  * @function entityHasUndef
//  * @throws {exception} If no argument provided.
//  * @memberof wTools
//  *
//  */
//
// function entityHasUndef( src )
// {
//   _.assert( arguments.length === 1, 'Expects single argument' );
//
//   let result = false;
//   if( src === undefined )
//   {
//     return true;
//   }
//   else if( _.arrayLike( src ) )
//   {
//     for( let s = 0 ; s < src.length ; s++ )
//     if( entityHasUndef( src[ s ] ) )
//     {
//       return true;
//     }
//   }
//   else if( _.objectIs( src ) )
//   {
//     for( s in src )
//     if( entityHasUndef( src[ s ] ) )
//     {
//       return true;
//     }
//   }
//   return result;
//
// }

// --
// fields
// --

let Fields =
{
}

// --
// routines
// --

let Routines =
{

  // // multiplier
  //
  // dup : dup,
  // multiple : multiple,
  // multipleAll : multipleAll,
  //
  // // entity iterator
  //
  // eachSample : eachSample,
  // eachInRange : eachInRange,
  // eachInManyRanges : eachInManyRanges,
  // eachInMultiRange : eachInMultiRange, /* experimental */
  //
  // entityEach : entityEach,
  // entityEachName : entityEachName,
  // entityEachOwn : entityEachOwn,
  //
  // entityAll : entityAll,
  // entityAny : entityAny,
  // entityNone : entityNone,
  //
  // entityMap : entityMap,
  // _filter_functor : _filter_functor,
  // entityFilter : entityFilter,
  // _entityFilterDeep : _entityFilterDeep,
  // entityFilterDeep : entityFilterDeep,
  //
  // each : entityEach,
  // eachName : entityEachName,
  // eachOwn : entityEachOwn,
  //
  // all : entityAll,
  // any : entityAny,
  // none : entityNone,
  //
  // map : entityMap,
  // filter : entityFilter,
  //
  // entityShallowClone : entityShallowClone,
  //
  // // entity modifier
  //
  // enityExtend : enityExtend,
  // enityExtendAppending : enityExtendAppending,
  //
  // entityMake : entityMake,
  // entityMakeTivial : entityMakeTivial,
  //
  // entityAssign : entityAssign, /* dubious */
  // entityAssignFieldFromContainer : entityAssignFieldFromContainer, /* dubious */
  // entityAssignField : entityAssignField, /* dubious */
  //
  // entityCoerceTo : entityCoerceTo,
  //
  // entityFreeze : entityFreeze,

  // entity getter

  entityLength : entityLength,
  entitySize : entitySize, /* dubious */

  entityValueWithIndex : entityValueWithIndex, /* dubious */
  entityKeyWithValue : entityKeyWithValue, /* dubious */

  entityVals : entityVals,

  _entityMost : _entityMost,
  entityMin : entityMin,
  entityMax : entityMax,

  // // entity chacker
  //
  // entityHasNan : entityHasNan,
  // entityHasUndef : entityHasUndef,

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
