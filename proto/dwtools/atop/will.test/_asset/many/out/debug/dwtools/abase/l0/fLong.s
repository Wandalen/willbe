( function _fLong_s_() {

'use strict';

let _ArrayIndexOf = Array.prototype.indexOf;
let _ArrayLastIndexOf = Array.prototype.lastIndexOf;
let _ArraySlice = Array.prototype.slice;

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

/*
               |  can grow   |  can shrink  |   range
grow                +                -         positive
select              -                +         positive
relength            +                +         positive
but                 -                +         negative
*/

/* array / long / buffer */
/* - / inplace */

// --
// scalar
// --

/**
 * Produce a single array from all arguments if cant return single argument as a scalar.
 * If {-scalarAppend-} gets a single argument it returns the argument as is.
 * If {-scalarAppend-} gets an argument and one or more undefined it returns the argument as is.
 * If {-scalarAppend-} gets more than one or less than one defined arguments then it returns array having all defined arguments.
 * If some argument is a long ( for example array ) then each element of the long is treated as an argument, not recursively.
 *
 * @function scalarAppend.
 * @memberof wTools
 */

function scalarAppend( dst, src )
{

  _.assert( arguments.length === 2 );

  if( dst === undefined )
  {
    if( _.longIs( src ) )
    {
      dst = [];
    }
    else
    {
      if( src === undefined )
      return [];
      else
      return src;
    }
  }

  if( _.longIs( dst ) )
  {

    if( !_.arrayIs( dst ) )
    dst = _.arrayFrom( dst );

    if( src === undefined )
    {}
    else if( _.longIs( src ) )
    _.arrayAppendArray( dst, src );
    else
    dst.push( src );

  }
  else
  {

    if( src === undefined )
    {}
    else if( _.longIs( src ) )
    dst = _.arrayAppendArray( [ dst ], src );
    else
    dst = [ dst, src ];

  }

  return dst;
}

//

function scalarAppendOnce( dst, src )
{

  _.assert( arguments.length === 2 );

  if( dst === undefined )
  {
    if( _.longIs( src ) )
    {
      dst = [];
    }
    else
    {
      if( src === undefined )
      return [];
      else
      return src;
    }
  }

  if( _.longIs( dst ) )
  {

    if( !_.arrayIs( dst ) )
    dst = _.arrayFrom( dst );

    if( src === undefined )
    {}
    else if( _.longIs( src ) )
    _.arrayAppendArrayOnce( dst, src );
    else
    _.arrayAppendElementOnce( dst, src );

  }
  else
  {

    if( src === undefined )
    {}
    else if( _.longIs( src ) )
    dst = _.arrayAppendArrayOnce( [ dst ], src );
    else
    dst = _.arrayAppendElementOnce( [ dst ], src );

  }

  return dst;
}

//

/**
 * The scalarToVector() routine returns a new array
 * which containing the static elements only type of Number.
 *
 * It takes two arguments (dst) and (length)
 * checks if the (dst) is a Number, If the (length) is greater than or equal to zero.
 * If true, it returns the new array of static (dst) numbers.
 * Otherwise, if the first argument (dst) is an Array,
 * and its (dst.length) is equal to the (length),
 * it returns the original (dst) Array.
 * Otherwise, it throws an Error.
 *
 * @param { ( Number | Array ) } dst - A number or an Array.
 * @param { Number } length - The length of the new array.
 *
 * @example
 * _.scalarToVector( 3, 7 );
 * // returns [ 3, 3, 3, 3, 3, 3, 3 ]
 *
 * @example
 * _.scalarToVector( [ 3, 7, 13 ], 3 );
 * // returns [ 3, 7, 13 ]
 *
 * @returns { Number[] | Array } - Returns the new array of static numbers or the original array.
 * @function scalarToVector
 * @throws { Error } If missed argument, or got less or more than two arguments.
 * @throws { Error } If type of the first argument is not a number or array.
 * @throws { Error } If the second argument is less than 0.
 * @throws { Error } If (dst.length) is not equal to the (length).
 * @memberof wTools
 */

// function arrayFromNumber( dst, length )
function scalarToVector( dst, length )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.numberIs( dst ) || _.arrayIs( dst ), 'Expects array of number as argument' );
  _.assert( length >= 0 );

  if( _.numberIs( dst ) )
  {
    dst = _.longFill( [], dst, [ 0, length ] );
    // dst = _.longFillTimes( [], length, dst );
  }
  else
  {
    _.assert( dst.length === length, () => 'Expects array of length ' + length + ' but got ' + dst.length );
  }

  return dst;
}

//

function scalarFrom( src )
{
  if( _.longIs( src ) && src.length === 1 )
  return src[ 0 ];
  return src;
}

//

function scalarFromOrNull( src )
{
  if( _.longIs( src ) )
  {
    if( src.length === 1 )
    return src[ 0 ];
    else if( src.length === 0 )
    return null;
  }
  return src;
}

// --
// arguments array
// --

function argumentsArrayIs( src )
{
  return Object.prototype.toString.call( src ) === '[object Arguments]';
}

//

function argumentsArrayMake( src )
{
  _.assert( arguments.length === 1 );
  _.assert( _.numberIs( src ) || _.longIs( src ) );
  if( _.numberIs( src ) )
  return _argumentsArrayMake.apply( _, Array( src ) );
  else
  return _argumentsArrayMake.apply( _, src );
}

//

function _argumentsArrayMake()
{
  return arguments;
}

//

function argumentsArrayFrom( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( _.argumentsArrayIs( src ) )
  return src;
  return _.argumentsArrayMake( src );
}

// --
// unroll
// --

/**
 * The routine unrollIs() determines whether the passed value is an instance of type unroll ( unroll-array ).
 *
 * If {-src-} is an unroll, then returns true, otherwise returns false.
 *
 * @param { * } src - The object to be checked.
 *
 * @example
 * _.unrollIs( _.unrollMake( [ 1, 'str' ] ) );
 * // returns true
 *
 * @example
 * _.unrollIs( [] );
 * // returns false
 *
 * @example
 * _.unrollIs( 1 );
 * // returns false
 *
 * @returns { boolean } Returns true if {-src-} is an unroll.
 * @function unrollIs
 * @memberof wTools
 */

function unrollIs( src )
{
  if( !_.arrayIs( src ) )
  return false;
  return !!src[ _.unroll ];
}

//

/*
qqq : poor examples
Dmytro : examples is improved
*/

/**
 * The routine unrollIsPopulated() determines whether the unroll-array has elements (length).
 *
 * If {-src-} is an unroll-array and has one or more elements, then returns true, otherwise returns false.
 *
 * @param { * } src - The object to be checked.
 *
 * @example
 * let src = _.unrollFrom( [ 1, 'str' ] );
 * _.unrollIsPopulated( src );
 * // returns true
 *
 * @example
 * let src = _.unrollMake( [] )
 * _.unrollIsPopulated( src );
 * // returns false
 *
 * @returns { boolean } Returns true if argument ( src ) is an unroll-array and has one or more elements ( length ).
 * @function unrollIsPopulated
 * @memberof wTools
 */

function unrollIsPopulated( src )
{
  if( !_.unrollIs( src ) )
  return false;
  return src.length > 0;
}

//

/**
 * The routine unrollMake() returns a new unroll-array maked from {-src-}.
 *
 * Unroll constructed by attaching symbol _.unroll Symbol to ordinary array.
 * Making an unroll normalizes its content.
 *
 * @param { * } src - The number or array-like object to make unroll-array. Passing null returns an empty unroll.
 *
 * @example
 * let src = _.unrollMake( null );
 * _.unrollIs( src );
 * // returns true
 *
 * @example
 * let src = _.unrollMake( [ 1, 2, 'str' ] );
 * _.unrollIs( src );
 * // returns true
 *
 * @example
 * let arr = new Array( 1, 2, 'str' );
 * let unroll = _.unrollMake( [ 1, 2, 'str' ] );
 * console.log( arr === unroll );
 * // log false
 *
 * @returns { Unroll } Returns a new unroll-array maked from {-src-}.
 * Otherwise, it returns the empty unroll.
 * @function unrollMake
 * @throws { Error } If ( arguments.length ) is less or more then one.
 * @throws { Error } If argument ( src ) is not number, not array, not null.
 * @memberof wTools
 */

function unrollMake( src )
{
  let result = _.arrayMake( src );
  _.assert( arguments.length === 1 );
  _.assert( _.arrayIs( result ) );
  result[ _.unroll ] = true;
  if( !_.unrollIs( src ) )
  result = _.unrollNormalize( result );
  return result;
}

//

/*
qqq : implement unrollMakeUndefined similar to longMakeUndefined, cover and document
*/

function unrollMakeUndefined( src, length )
{
  let result = _.arrayMakeUndefined( src, length );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.arrayIs( result ) );
  result[ _.unroll ] = true;
  return result;
}

//

/**
 * The routine unrollFrom() performs conversion of {-src-} to unroll-array.
 *
 * If {-src-} is not unroll-array, routine unrollFrom() returns new unroll-array.
 * If {-src-} is unroll-array, then routine returns {-src-}.
 *
 * @param { * } src - The number, array-like object or unroll-array. Passing null returns an empty unroll.
 *
 * @example
 * let unroll = _.unrollFrom( null );
 * _.unrollIs( unroll );
 * // returns true
 *
 * @example
 * let unroll = _.unrollMake( [ 1, 2, 'str' ] );
 * let result = _.unrollFrom( unroll );
 * console.log ( unroll === result );
 * // log true
 *
 * @example
 * let arr = new Array( 1, 2, 'str' );
 * let unroll = _.unrollFrom( [ 1, 2, 'str' ] );
 * console.log( _.unrollIs( unroll ) );
 * // log true
 * console.log( arr === unroll );
 * // log false
 *
 * @returns { Unroll } Returns unroll-array converted from {-src-}.
 * If {-src-} is unroll-array, then routine returns {-src-}.
 * @function unrollFrom
 * @throws { Error } If (arguments.length) is less or more then one.
 * @throws { Error } If argument {-src-} is not number, not long-like, not null.
 * @memberof wTools
 */

function unrollFrom( src )
{
  _.assert( arguments.length === 1 );
  if( _.unrollIs( src ) )
  return src;
  return _.unrollMake( src );
}

//

/**
 * The routine unrollsFrom() performs conversion of each argument to unroll-array.
 * The routine returns unroll-array contained unroll-arrays converted from arguments.
 *
 * @param { * } srcs - The objects to be converted into unrolls.
 *
 * @example
 * let unroll = _.unrollsFrom( null );
 * console.log( unroll );
 * // log [ [] ]
 * console.log( _.unrollIs( unroll ) );
 * // log true
 *
 * @example
 * let unroll = _.unrollsFrom( [ 1, 2, 'str' ] );
 * console.log ( unroll );
 * // log [ [ 1, 2, 'str' ] ]
 * console.log( _.unrollIs( unroll ) );
 * // log true
 * console.log( _.unrollIs( unroll[ 0 ] ) );
 * // log true
 *
 * @example
 * let arr = new Array( 1, 2, 'str' );
 * let unroll = _.unrollsFrom( [ 1, 2, 'str' ] );
 * console.log( _.unrollIs( unroll ) );
 * // log true
 * console.log( arr === unroll );
 * // log false
 *
 * @example
 * let unroll = _.unrollsFrom( [], 1, null, [ 1, [] ] );
 * console.log( unroll );
 * // log [ [], [ undefined ], [], [ 1, [] ] ]
 * console.log( _.unrollIs( unroll ) );
 * // log true
 * console.log( _.unrollIs( unroll[ 0 ] ) );
 * // log true
 * console.log( _.unrollIs( unroll[ 1 ] ) );
 * // log true
 * console.log( _.unrollIs( unroll[ 2 ] ) );
 * // log true
 * console.log( _.unrollIs( unroll[ 3 ] ) );
 * // log true
 *
 * @returns { Unroll } Returns unroll-array contained unroll-arrays converted from arguments.
 * @function unrollsFrom
 * @throws { Error } If (arguments.length) is less then one.
 * @throws { Error } If any of the arguments is not number, not long-like, not null.
 * @memberof wTools
 */

function unrollsFrom( srcs )
{
  _.assert( arguments.length >= 1 );

  let dst = _.unrollMake( null );

  for( let i = 0; i < arguments.length; i ++ )
  {
    if( _.unrollIs( arguments[ i ] ) )
    dst.push( arguments[ i ] );
    else
    dst.push( _.unrollMake( arguments[ i ] ) );
  }

  return dst;
}

/**
 * The routine unrollFromMaybe() performs conversion of {-src-} to unroll-array.
 *
 * If {-src-} is not unroll-array, routine unrollFromMaybe() returns new unroll-array.
 * If {-src-} is unroll-array, then routine returns {-src-}.
 * If {-src-} has incompatible type, then routine returns {-src-}.
 *
 * @param { * } src - The object to make unroll-array.
 *
 * @example
 * var src = 'str';
 * let got = _.unrollFromMaybe( src );
 * console.log( _.unrollIs( got ) );
 * // log false
 * console.log( got === src );
 * // log true
 *
 * @example
 * let unroll = _.unrollFromMaybe( null );
 * console.log( _.unrollIs( unroll ) );
 * // log false
 *
 * @example
 * let unroll = _.unrollMake( [ 1, 2, 'str' ] );
 * let result = _.unrollFromMaybe( unroll );
 * console.log ( unroll === result );
 * // log true
 *

  qqq : in separate line after each console.log such comment should follow
        1. its lazy
        2. not returns, but output or log
        3. should be for each console.log

 * @example
 * let arr = new Array( 1, 2, 'str' );
 * let unroll = _.unrollFromMaybe( [ 1, 2, 'str' ] );
 * console.log( _.unrollIs( unroll ) );
 * // log true
 * console.log( arr === unroll );
 * // log false
 *
 * @returns { Unroll } Returns unroll-array converted from {-src-}.
 * If {-src-} is unroll-array or incompatible type, then routine returns {-src-}.
 * @function unrollFromMaybe
 * @throws { Error } If (arguments.length) is less or more then one.
 * @memberof wTools
 */

function unrollFromMaybe( src )
{
  _.assert( arguments.length === 1 );
  if( _.unrollIs( src ) || _.strIs( src ) || _.boolIs( src ) || _.mapIs( src ) || src === undefined )
  return src;
  return _.unrollMake( src );
}

//

/**
 * The routine unrollNormalize() performs normalization of {-dstArray-}.
 * Normalization is unrolling of unroll-arrays, which is elements of {-dstArray-}.
 *
 * If {-dstArray-} is unroll-array, routine unrollNormalize() returns unroll-array
 * with normalized elements.
 * If {-dstArray-} is array, routine unrollNormalize() returns array with unrolled elements.
 *
 * @param { arrayIs|Unroll } dstArray - The array to be unrolled (normalized).
 *
 * @example
 * let unroll = _.unrollFrom( [ 1, 2, _.unrollMake( [ 3, 'str' ] ) ] );
 * let result = _.unrollNormalize( unroll )
 * console.log( result );
 * // log [ 1, 2, 3, 'str' ]
 * console.log( _.unrollIs( result ) );
 * // log true
 *
 * @example
 * let unroll = _.unrollFrom( [ 1,'str' ] );
 * let result = _.unrollNormalize( [ 1, unroll, [ unroll ] ] );
 * console.log( result );
 * // log [ 1, 1, 'str', [ 1, 'str' ] ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @returns { Array } If {-dstArray-} is array, routine returns an array with normalized elements.
 * @returns { Unroll } If {-dstArray-} is unroll-array, routine returns an unroll-array with normalized elements.
 * @function unrollNormalize
 * @throws { Error } If ( arguments.length ) is not equal to one.
 * @throws { Error } If argument ( dstArray ) is not arrayLike.
 * @memberof wTools
 */

function unrollNormalize( dstArray )
{

  _.assert( arguments.length === 1 );
  _.assert
  (
      _.arrayIs( dstArray )
    , () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray )
  );

  for( let a = 0 ; a < dstArray.length ; a++ )
  {
    if( _.unrollIs( dstArray[ a ] ) )
    {
      let args = [ a, 1 ];
      args.push.apply( args, dstArray[ a ] );
      dstArray.splice.apply( dstArray, args );
      a += args.length - 3;
      /* no normalization of ready unrolls, them should be normal */
    }
    else if( _.arrayIs( dstArray[ a ] ) )
    {
      _.unrollNormalize( dstArray[ a ] );
    }
  }

  return dstArray;
}

//

/*
  qqq : extend documentation and test coverage of unrollSelect
*/

function unrollSelect( array, range, val )
{
  let result;

  if( range === undefined )
  return _.unrollMake( array );

  if( _.numberIs( range ) )
  range = [ range, array.length ];

  let f = range ? range[ 0 ] : undefined;
  let l = range ? range[ 1 ] : undefined;

  f = f !== undefined ? f : 0;
  l = l !== undefined ? l : array.length;

  _.assert( _.longIs( array ) );
  _.assert( _.rangeIs( range ) )
  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( l < f )
  l = f;

  if( f < 0 )
  {
    l -= f;
    f -= f;
  }

  if( f === 0 && l === array.length )
  return _.unrollMake( array );

  result = _.unrollMakeUndefined( array, l-f );

  /* */

  let f2 = Math.max( f, 0 );
  let l2 = Math.min( array.length, l );
  for( let r = f2 ; r < l2 ; r++ )
  result[ r-f ] = array[ r ];

  /* */

  if( val !== undefined )
  {
    for( let r = 0 ; r < -f ; r++ )
    {
      result[ r ] = val;
    }
    for( let r = l2 - f; r < result.length ; r++ )
    {
      result[ r ] = val;
    }
  }

  /* */

  return result;
}

//

/*
qqq : в unrollPrepend, unrollAppend бракує прикладів
коли src unroll і dst не null
із виводом результату
і більше ніж одним елементом

Dmytro: correct JSdoc in unrollFrom, unrollNormalize.
Improve examples in unrollPrepend, unrollAppend.
*/

/**
 * The routine unrollPrepend() returns an array with elements added to the begin of destination array {-dstArray-}.
 * During the operation unrolling of unrolls happens.
 *
 * If {-dstArray-} is unroll-array, routine unrollPrepend() returns unroll-array
 * with normalized elements.
 * If {-dstArray-} is array, routine unrollPrepend() returns array with unrolled elements.
 *
 * @param { Array|Unroll } dstArray - The destination array.
 * @param { * } args - The elements to be added.
 *
 * @example
 * let result = _.unrollPrepend( null, [ 1, 2, 'str' ] );
 * console.log( result );
 * // log [ [ 1, 2, 'str' ] ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @example
 * let result = _.unrollPrepend( null, _.unrollMake( [ 1, 2, 'str' ] ) );
 * console.log( result );
 * // log [ 1, 2, 'str' ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @example
 * let result = _.unrollPrepend( _.unrollFrom( [ 1, 'str' ] ), [ 1, 2 ] );
 * console.log( result );
 * // log [ [ 1, 2 ], 1, 'str' ]
 * console.log( _.unrollIs( result ) );
 * // log true
 *
 * @example
 * let result = _.unrollPrepend( [ 1, 'str' ],  _.unrollFrom( [ 2, 3 ] ) );
 * console.log( result );
 * // log [ 2, 3, 1, 'str' ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @example
 * let result = _.unrollPrepend( _.unrollMake( [ 1, 'str' ] ),  _.unrollFrom( [ 2, 3 ] ) );
 * console.log( result );
 * // log [ 2, 3, 1, 'str' ]
 * console.log( _.unrollIs( result ) );
 * // log true
 *
 * @returns { Unroll } If {-dstArray-} is unroll-array, routine returns updated unroll-array
 * with normalized elements that are added to the begin of {-dstArray-}.
 * @returns { Array } If {-dstArray-} is array, routine returns updated array
 * with normalized elements that are added to the begin of {-dstArray-}.
 * If {-dstArray-} is null, routine returns empty array.
 * @function unrollPrepend
 * @throws { Error } An Error if {-dstArray-} is not an Array or not null.
 * @throws { Error } An Error if ( arguments.length ) is less then one.
 * @memberof wTools
 */

function unrollPrepend( dstArray )
{
  _.assert( arguments.length >= 1 );
  _.assert( _.longIs( dstArray ) || dstArray === null, 'Expects long or unroll' );

  dstArray = dstArray || [];

  _unrollPrepend( dstArray, _.longSlice( arguments, 1 ) );

  return dstArray;

  function _unrollPrepend( dstArray, srcArray )
  {

    for( let a = srcArray.length - 1 ; a >= 0 ; a-- )
    {
      if( _.unrollIs( srcArray[ a ] ) )
      {
        _unrollPrepend( dstArray, srcArray[ a ] );
      }
      else
      {
        if( _.arrayIs( srcArray[ a ] ) )
        _.unrollNormalize( srcArray[ a ] )
        dstArray.unshift( srcArray[ a ] );
      }
    }

    return dstArray;
  }

}

//

/**
 * The routine unrollAppend() returns an array with elements added to the end of destination array {-dstArray-}.
 * During the operation unrolling of unrolls happens.
 *
 * If {-dstArray-} is unroll-array, routine unrollAppend() returns unroll-array
 * with normalized elements.
 * If {-dstArray-} is array, routine unrollAppend() returns array with unrolled elements.
 *
 * @param { Array|Unroll } dstArray - The destination array.
 * @param { * } args - The elements to be added.
 *
 * @example
 * let result = _.unrollAppend( null, [ 1, 2, 'str' ] );
 * console.log( result );
 * // log [ [ 1, 2, 'str' ] ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @example
 * let result = _.unrollAppend( null, _.unrollMake( [ 1, 2, 'str' ] ) );
 * console.log( result );
 * // log [ 1, 2, str ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @example
 * let result = _.unrollAppend( _.unrollFrom( [ 1, 'str' ] ), [ 1, 2 ] );
 * console.log( result );
 * // log [ 1, 'str', [ 1, 2 ] ]
 * console.log( _.unrollIs( result ) );
 * // log true
 *
 * @example
 * let result = _.unrollAppend( [ 1, 'str' ],  _.unrollFrom( [ 2, 3 ] ) );
 * console.log( result );
 * // log [ 1, 'str', 2, 3 ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @example
 * let result = _.unrollAppend( _.unrollMake( [ 1, 'str' ] ),  _.unrollFrom( [ 2, 3 ] ) );
 * console.log( result );
 * // log [ 1, 'str', 2, 3 ]
 * console.log( _.unrollIs( result ) );
 * // log true
 *
 * @returns { Unroll } If {-dstArray-} is unroll-array, routine returns updated unroll-array
 * with normalized elements that are added to the end of {-dstArray-}.
 * @returns { Array } If {-dstArray-} is array, routine returns updated array
 * with normalized elements that are added to the end of {-dstArray-}.
 * If {-dstArray-} is null, routine returns empty array.
 * @function unrollAppend
 * @throws { Error } An Error if {-dstArray-} is not an Array or not null.
 * @throws { Error } An Error if ( arguments.length ) is less then one.
 * @memberof wTools
 */

function unrollAppend( dstArray )
{
  _.assert( arguments.length >= 1 );
  _.assert( _.longIs( dstArray ) || dstArray === null, 'Expects long or unroll' );

  dstArray = dstArray || [];

  _unrollAppend( dstArray, _.longSlice( arguments, 1 ) );

  return dstArray;

  function _unrollAppend( dstArray, srcArray )
  {
    _.assert( arguments.length === 2 );

    for( let a = 0, len = srcArray.length ; a < len; a++ )
    {
      if( _.unrollIs( srcArray[ a ] ) )
      {
        _unrollAppend( dstArray, srcArray[ a ] );
      }
      else
      {
        if( _.arrayIs( srcArray[ a ] ) )
        _.unrollNormalize( srcArray[ a ] )
        dstArray.push( srcArray[ a ] );
      }
    }

    return dstArray;
  }

}

/*

let a1 = _.unrollFrom([ 3, 4, _.unrollFrom([ 5, 6 ]) ]);
let a2 = [ 7, _.unrollFrom([ 8, 9 ]) ] ];
_.unrollAppend( null, [ 1, 2, a1, a2, 10 ] );

let a1 = _.unrollFrom([ 3, 4, _.unrollFrom([ 5, 6 ]) ]);
let a2 = [ 7, _.unrollFrom([ 8, 9 ]) ] ];
_.unrollAppend( null, [ 1, 2, a1, a2, 10 ] );

*/

// //
//
// function unrollPrepend( dstArray )
// {
//   _.assert( arguments.length >= 1 );
//   _.assert( _.arrayIs( dstArray ) || dstArray === null, 'Expects array' );
//
//   dstArray = dstArray || [];
//
//   for( let a = arguments.length - 1 ; a >= 1 ; a-- )
//   {
//     if( _.longIs( arguments[ a ] ) )
//     {
//       dstArray.unshift.apply( dstArray, arguments[ a ] );
//     }
//     else
//     {
//       dstArray.unshift( arguments[ a ] );
//     }
//   }
//
//   dstArray[ _.unroll ] = true;
//
//   return dstArray;
// }
//
// //
//
// function unrollAppend( dstArray )
// {
//   _.assert( arguments.length >= 1 );
//   _.assert( _.arrayIs( dstArray ) || dstArray === null, 'Expects array' );
//
//   dstArray = dstArray || [];
//
//   for( let a = 1, len = arguments.length ; a < len; a++ )
//   {
//     if( _.longIs( arguments[ a ] ) )
//     {
//       dstArray.push.apply( dstArray, arguments[ a ] );
//     }
//     else
//     {
//       dstArray.push( arguments[ a ] );
//     }
//   }
//
//   dstArray[ _.unroll ] = true;
//
//   return dstArray;
// }

//

/**
 * The routine unrollRemove() removes all matching elements in destination array {-dstArray-}
 * and returns a modified {-dstArray-}. During the operation unrolling of unrolls happens.
 *
 * @param { Array|Unroll } dstArray - The destination array.
 * @param { * } args - The elements to be removed.
 *
 * @example
 * let result = _.unrollRemove( null, [ 1, 2, 'str' ] );
 * console.log( result );
 * // log []
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @example
 * let result = _.unrollRemove( _.unrollMake( null ), [ 1, 2, 'str' ] );
 * console.log( result );
 * // log []
 * console.log( _.unrollIs( result ) );
 * // log true
 *
 * @example
 * let result = _.unrollRemove( [ 1, 2, 1, 3, 'str' ], [ 1, 'str', 0, 5 ] );
 * console.log( result );
 * // log [ 1, 2, 1, 3, 'str' ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @example
 * let result = _.unrollRemove( [ 1, 2, 1, 3, 'str' ], _.unrollFrom( [ 1, 'str', 0, 5 ] ) );
 * console.log( result );
 * // log [ 2, 3 ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @example
 * let result = _.unrollRemove( _.unrollFrom( [ 1, 2, 1, 3, 'str' ] ), [ 1, 'str', 0, 5 ] );
 * console.log( result );
 * // log [ 1, 2, 1, 3, 'str' ]
 * console.log( _.unrollIs( result ) );
 * // log true
 *
 * @example
 * let dstArray = _.unrollFrom( [ 1, 2, 1, 3, 'str' ] );
 * let ins = _.unrollFrom( [ 1, 'str', 0, 5 ] );
 * let result = _.unrollRemove( dstArray, ins );
 * console.log( result );
 * // log [ 2, 3 ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @example
 * let dstArray = _.unrollFrom( [ 1, 2, 1, 3, 'str' ] );
 * let ins = _.unrollFrom( [ 1, _.unrollMake( [ 'str', 0, 5 ] ) ] );
 * let result = _.unrollRemove( dstArray, ins );
 * console.log( result );
 * // log [ 2, 3 ]
 * console.log( _.unrollIs( result ) );
 * // log false
 *
 * @returns { Unroll } If {-dstArray-} is unroll-array, routine removes all matching elements
 * and returns updated unroll-array.
 * @returns { Array } If {-dstArray-} is array, routine removes all matching elements
 * and returns updated array. If {-dstArray-} is null, routine returns empty array.
 * @function unrollAppend
 * @throws { Error } An Error if {-dstArray-} is not an Array or not null.
 * @throws { Error } An Error if ( arguments.length ) is less then one.
 * @memberof wTools
 */

function unrollRemove( dstArray )
{
  _.assert( arguments.length >= 2 );
  _.assert( _.longIs( dstArray ) || dstArray === null, 'Expects long or unroll' );

  dstArray = dstArray || [];

  _unrollRemove( dstArray, _.longSlice( arguments, 1 ) );

  return dstArray;

  function _unrollRemove( dstArray, srcArray )
  {
    _.assert( arguments.length === 2 );

    for( let a = 0, len = srcArray.length ; a < len; a++ )
    {
      if( _.unrollIs( srcArray[ a ] ) )
      {
        _unrollRemove( dstArray, srcArray[ a ] );
      }
      else
      {
        if( _.arrayIs( srcArray[ a ] ) )
        _.unrollNormalize( srcArray[ a ] );
        while( dstArray.indexOf( srcArray[ a ] ) >= 0 )
        dstArray.splice( dstArray.indexOf( srcArray[ a ] ), 1 );
      }
    }

    return dstArray;
  }

}

// --
// long
// --

/**
 * The longIs() routine determines whether the passed value is an array-like or an Array.
 * Imortant : longIs returns false for Object, even if the object has length field.
 *
 * If {-srcMap-} is an array-like or an Array, true is returned,
 * otherwise false is.
 *
 * @param { * } src - The object to be checked.
 *
 * @example
 * _.longIs( [ 1, 2 ] );
 * // returns true
 *
 * @example
 * _.longIs( 10 );
 * // returns false
 *
 * @example
 * let isArr = ( function() {
 *   return _.longIs( arguments );
 * } )( 'Hello there!' );
 * // returns true
 *
 * @returns { boolean } Returns true if {-srcMap-} is an array-like or an Array.
 * @function longIs.
 * @memberof wTools
 */

function longIs( src )
{
  if( _.primitiveIs( src ) )
  return false;
  if( _.routineIs( src ) )
  return false;
  if( _.objectIs( src ) )
  return false;
  if( _.strIs( src ) )
  return false;
  if( _.bufferNodeIs( src ) )
  return false;

  if( Object.propertyIsEnumerable.call( src, 'length' ) )
  return false;
  if( !_.numberIs( src.length ) )
  return false;

  return true;
}

//

function longIsPopulated( src )
{
  if( !_.longIs( src ) )
  return false;
  return src.length > 0;
}

//

/**
 * The longMake() routine returns a new array or a new TypedArray with length equal (length)
 * or new TypedArray with the same length of the initial array if second argument is not provided.
 *
 * @param { longIs } ins - The instance of an array.
 * @param { Number } [ length = ins.length ] - The length of the new array.
 *
 * @returns { longIs }  Returns an array with a certain (length).
 * @function longMake
 * @throws { Error } If the passed arguments is less than two.
 * @throws { Error } If the (length) is not a number.
 * @throws { Error } If the first argument in not an array like object.
 * @throws { Error } If the (length === undefined) and (_.numberIs(ins.length)) is not a number.
 * @memberof wTools
 */

/*
qqq : extend coverage and documentation of longMake
qqq : longMake does not create unrolls, but should
*/

function longMake( src, ins )
{
  // let result, length;
  let result;
  let length = ins;

  if( src === null )
  src = [];

  if( _.longIs( length ) )
  length = length.length;

  if( length === undefined )
  {
    if( _.longIs( src ) )
    length = src.length;
    else if( _.numberIs( src ) )
    length = src;
    else _.assert( 0 );
  }

  if( !_.longIs( ins ) )
  {
    if( _.longIs( src ) )
    ins = src;
    else
    ins = [];
  }

  if( !length )
  length = 0;

  if( _.argumentsArrayIs( src ) )
  src = [];

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIsFinite( length ) );
  _.assert( _.routineIs( src ) || _.longIs( src ), () => 'Expects long, but got ' + _.strType( src ) );

  if( _.routineIs( src ) )
  {
    if( ins.length === length )
    {
      debugger;
      if( src === Array )
      {
        if( _.longIs( ins ) )
        {
          if( ins.length === 1 )
          result = [ ins[ 0 ] ];
          else
          result = new( _.constructorJoin( src, ins ) );
        }
        else
        {
          result = new src( ins );
        }
      }
      else
      {
        result = new src( ins );
      }
    }
    else
    {
      result = new src( length );
      let minLen = Math.min( length, ins.length );
      for( let i = 0 ; i < minLen ; i++ )
      result[ i ] = ins[ i ];
    }
  }
  else if( _.arrayIs( src ) )
  {
    if( length === ins.length )
    {
      result = new( _.constructorJoin( src.constructor, ins ) );
    }
    else
    {
      result = new src.constructor( length );
      let minLen = Math.min( length, ins.length );
      for( let i = 0 ; i < minLen ; i++ )
      result[ i ] = ins[ i ];
    }
  }
  else
  {
    if( length === ins.length )
    {
      result = new src.constructor( ins );
    }
    else
    {
      result = new src.constructor( length );
      let minLen = Math.min( length, ins.length );
      for( let i = 0 ; i < minLen ; i++ )
      result[ i ] = ins[ i ];
    }
  }

  _.assert( _.longIs( result ) );

  return result;
}

//

function _longMakeOfLength( src, len )
{
  // let result, length;
  let result;

  if( src === null )
  src = [];

  if( _.longIs( len ) )
  len = len.length;

  if( len === undefined )
  {
    if( _.longIs( src ) )
    len = src.length;
    else if( _.numberIs( src ) )
    len = src;
    else _.assert( 0 );
  }

  if( !len )
  len = 0;

  if( _.argumentsArrayIs( src ) )
  src = [];

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIsFinite( len ) );
  _.assert( _.routineIs( src ) || _.longIs( src ), () => 'Expects long, but got ' + _.strType( src ) );

  if( _.routineIs( src ) )
  {
    result = new src( len );
  }
  else if( _.arrayIs( src ) )
  {
    if( len === src.length )
    {
      result = new( _.constructorJoin( src.constructor, src ) );
    }
    else if( len < src.length )
    {
      result = src.slice( 0, len );
    }
    else
    {
      result = new src.constructor( len );
      let minLen = Math.min( len, src.length );
      for( let i = 0 ; i < minLen ; i++ )
      result[ i ] = src[ i ];
    }
  }
  else
  {
    if( len === src.length )
    {
      result = new src.constructor( len );
    }
    else
    {
      result = new src.constructor( len );
      let minLen = Math.min( len, src.length );
      for( let i = 0 ; i < minLen ; i++ )
      result[ i ] = src[ i ];
    }
  }

  return result;
}

//

/*
qqq : extend coverage and documentation of longMakeUndefined
qqq : longMakeUndefined does not create unrolls, but should
*/

function longMakeUndefined( ins, len )
{
  let result, length;

  if( ins === null )
  ins = [];

  if( len === undefined )
  {
    length = ins.length;
  }
  else
  {
    if( _.longIs( len ) )
    length = len.length;
    else if( _.numberIs( len ) )
    length = len;
    else _.assert( 0 );
  }

  if( _.argumentsArrayIs( ins ) )
  ins = [];

  _.assert( !_.argumentsArrayIs( ins ), 'not tested' );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIsFinite( length ) );
  _.assert( _.routineIs( ins ) || _.longIs( ins ), () => 'Expects long, but got ' + _.strType( ins ) );

  if( _.routineIs( ins ) )
  result = new ins( length );
  else
  result = new ins.constructor( length );

  return result;
}

//

function longMakeZeroed( ins, src )
{
  let result, length;

  if( _.routineIs( ins ) )
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( src === undefined )
  {
    length = ins.length;
  }
  else
  {
    if( _.longIs( src ) )
    length = src.length;
    else if( _.numberIs( src ) )
    length = src;
    else _.assert( 0, 'Expects long or number as the second argument, got', _.strType( src ) );
  }

  if( _.argumentsArrayIs( ins ) )
  ins = [];

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIs( length ) );
  _.assert( _.routineIs( ins ) || _.longIs( ins ) || _.bufferRawIs( ins ), 'unknown type of array', _.strType( ins ) );

  if( _.routineIs( ins ) )
  {
    result = new ins( length );
  }
  else
  {
    result = new ins.constructor( length );
  }

  if( !_.bufferTypedIs( result ) && !_.bufferRawIs( result )  )
  for( let i = 0 ; i < length ; i++ )
  result[ i ] = 0;

  return result;
}

//

function _longClone( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.longIs( src ) || _.bufferAnyIs( src ) );
  _.assert( !_.bufferNodeIs( src ), 'not tested' );

  if( _.bufferViewIs( src ) )
  debugger;

  if( _.bufferRawIs( src ) )
  return new U8x( new U8x( src ) ).buffer;
  else if( _.bufferTypedIs( src ) || _.bufferNodeIs( src ) )
  return new src.constructor( src );
  else if( _.arrayIs( src ) )
  return src.slice();
  else if( _.bufferViewIs( src ) )
  return new src.constructor( src.buffer, src.byteOffset, src.byteLength );

  _.assert( 0, 'unknown kind of buffer', _.strType( src ) );
}

//

/* xxx : review */

function longShallowClone()
{
  let result;
  let length = 0;

  if( arguments.length === 1 )
  {
    return _._longClone( arguments[ 0 ] );
  }

  /* eval length */

  for( let a = 0 ; a < arguments.length ; a++ )
  {
    let argument = arguments[ a ];

    if( argument === undefined )
    throw _.err( 'argument is not defined' );

    if( _.longIs( argument ) ) length += argument.length;
    else if( _.bufferRawIs( argument ) ) length += argument.byteLength;
    else length += 1;
  }

  /* make result */

  if( _.arrayIs( arguments[ 0 ] ) || _.bufferTypedIs( arguments[ 0 ] ) )
  result = _.longMakeUndefined( arguments[ 0 ], length );
  else if( _.bufferRawIs( arguments[ 0 ] ) )
  result = new BufferRaw( length );

  let bufferDst;
  let offset = 0;
  if( _.bufferRawIs( arguments[ 0 ] ) )
  {
    bufferDst = new U8x( result );
  }

  /* copy */

  for( let a = 0, c = 0 ; a < arguments.length ; a++ )
  {
    let argument = arguments[ a ];
    if( _.bufferRawIs( argument ) )
    {
      bufferDst.set( new U8x( argument ), offset );
      offset += argument.byteLength;
    }
    else if( _.bufferTypedIs( arguments[ 0 ] ) )
    {
      result.set( argument, offset );
      offset += argument.length;
    }
    else if( _.longIs( argument ) )
    for( let i = 0 ; i < argument.length ; i++ )
    {
      result[ c ] = argument[ i ];
      c += 1;
    }
    else
    {
      result[ c ] = argument;
      c += 1;
    }
  }

  return result;
}

//

/**
 * Returns a copy of original array( array ) that contains elements from index( f ) to index( l ),
 * but not including ( l ).
 *
 * If ( l ) is omitted or ( l ) > ( array.length ), longSlice extracts through the end of the sequence ( array.length ).
 * If ( f ) > ( l ), end index( l ) becomes equal to begin index( f ).
 * If ( f ) < 0, zero is assigned to begin index( f ).

 * @param { Array/BufferNode } array - Source array or buffer.
 * @param { Number } [ f = 0 ] f - begin zero-based index at which to begin extraction.
 * @param { Number } [ l = array.length ] l - end zero-based index at which to end extraction.
 *
 * @example
 * _.longSlice( [ 1, 2, 3, 4, 5, 6, 7 ], 2, 6 );
 * // returns [ 3, 4, 5, 6 ]
 *
 * @example
 * // begin index is less then zero
 * _.longSlice( [ 1, 2, 3, 4, 5, 6, 7 ], -1, 2 );
 * // returns [ 1, 2 ]
 *
 * @example
 * // end index is bigger then length of array
 * _.longSlice( [ 1, 2, 3, 4, 5, 6, 7 ], 5, 100 );
 * // returns [ 6, 7 ]
 *
 * @returns { Array } Returns a shallow copy of elements from the original array.
 * @function longSlice
 * @throws { Error } Will throw an Error if ( array ) is not an Array or BufferNode.
 * @throws { Error } Will throw an Error if ( f ) is not a Number.
 * @throws { Error } Will throw an Error if ( l ) is not a Number.
 * @throws { Error } Will throw an Error if no arguments provided.
 * @memberof wTools
*/

function longSlice( array, f, l )
{
  let result;

  if( _.argumentsArrayIs( array ) )
  if( f === undefined && l === undefined )
  {
    if( array.length === 2 )
    return [ array[ 0 ], array[ 1 ] ];
    else if( array.length === 1 )
    return [ array[ 0 ] ];
    else if( array.length === 0 )
    return [];
  }

  _.assert( _.longIs( array ) );
  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( _.arrayLikeResizable( array ) )
  {
    _.assert( f === undefined || _.numberIs( f ) );
    _.assert( l === undefined || _.numberIs( l ) );
    result = array.slice( f, l );
    return result;
  }

  f = f !== undefined ? f : 0;
  l = l !== undefined ? l : array.length;

  _.assert( _.numberIs( f ) );
  _.assert( _.numberIs( l ) );

  if( f < 0 )
  f = array.length + f;
  if( l < 0 )
  l = array.length + l;

  if( f < 0 )
  f = 0;
  if( l > array.length )
  l = array.length;
  if( l < f )
  l = f;

  result = _.longMakeUndefined( array, l-f );
  // if( _.bufferTypedIs( array ) )
  // result = new array.constructor( l-f );
  // else
  // result = new Array( l-f );

  for( let r = f ; r < l ; r++ )
  result[ r-f ] = array[ r ];

  return result;
}

//

/* qqq : routine longBut requires good test coverage and documentation */

function longBut( src, range, ins )
{

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return _.longMake( src );

  if( _.arrayIs( src ) )
  return _.arrayBut( src, range, ins );

  let result;

  _.assert( _.longIs( src ) );
  _.assert( ins === undefined || _.longIs( ins ) );
  // _.assert( _.longIs( range ), 'not tested' );
  // _.assert( !_.longIs( range ), 'not tested' );

  if( _.numberIs( range ) )
  range = [ range, range + 1 ];

  _.rangeClamp( range, [ 0, src.length ] );
  if( range[ 1 ] < range[ 0 ] )
  range[ 1 ] = range[ 0 ];

  let d = range[ 1 ] - range[ 0 ];
  let len = ( ins ? ins.length : 0 );
  let d2 = d - len;
  let l2 = src.length - d2;

  result = _.longMakeUndefined( src, l2 );

  // debugger;
  // _.assert( 0, 'not tested' )

  for( let i = 0 ; i < range[ 0 ] ; i++ )
  result[ i ] = src[ i ];

  for( let i = range[ 1 ] ; i < src.length ; i++ )
  result[ i-d2 ] = src[ i ];

  if( ins )
  for( let i = 0 ; i < ins.length ; i++ )
  result[ range[ 0 ]+i ] = ins[ i ];

  return result;
}

//

/* qqq : routine longBut requires good test coverage and documentation */

function longButInplace( src, range, ins )
{

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  // if( _.arrayIs( src ) )
  if( _.arrayLikeResizable( src ) )
  return _.arrayButInplace( src, range, ins );
  else
  return _.longBut( src, range, ins ); // Dmytro : not resizable longs should be processed by longBut algorithm. If it need, I'll make copy of code.

  // let result;
  //
  // _.assert( _.longIs( src ) );
  // _.assert( ins === undefined || _.longIs( ins ) );
  // _.assert( _.longIs( range ), 'not tested' );
  // _.assert( !_.longIs( range ), 'not tested' );
  //
  // _.assert( 0, 'not implemented' )

  //
  // if( _.numberIs( range ) )
  // range = [ range, range + 1 ];
  //
  // _.rangeClamp( range, [ 0, src.length ] );
  // if( range[ 1 ] < range[ 0 ] )
  // range[ 1 ] = range[ 0 ];
  //
  // let d = range[ 1 ] - range[ 0 ];
  // let range[ 1 ] = src.length - d + ( ins ? ins.length : 0 );
  //
  // result = _.longMakeUndefined( src, range[ 1 ] );
  //
  // debugger;
  // _.assert( 0, 'not tested' )
  //
  // for( let i = 0 ; i < range[ 0 ] ; i++ )
  // result[ i ] = src[ i ];
  //
  // for( let i = range[ 1 ] ; i < range[ 1 ] ; i++ )
  // result[ i-d ] = src[ i ];
  //
  // return result;
}

//

/*
  qqq : extend documentation and test coverage of longSelect
  Dmytro : temporary using of longMake. Need to save longShallowClone.
*/

function longSelect( array, range, val )
{
  let result;

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return _.longMake( array );
  // return _.longShallowClone( array );

  if( _.numberIs( range ) )
  range = [ range, array.length ];

  // let f = range ? range[ 0 ] : undefined;
  // let l = range ? range[ 1 ] : undefined;
  //
  // f = f !== undefined ? f : 0;
  // l = l !== undefined ? l : array.length;

  _.assert( _.longIs( array ) );
  _.assert( _.rangeIs( range ) )

  // if( f < 0 )
  // {
  //   l -= f;
  //   f -= f;
  // }

  _.rangeClamp( range, [ 0, array.length ] );
  if( range[ 1 ] < range[ 0 ] )
  range[ 1 ] = range[ 0 ];

  // if( l < f )
  // l = f;

  // if( f < 0 )
  // f = 0;
  // if( l > array.length )
  // l = array.length;

  if( range[ 0 ] === 0 && range[ 1 ] === array.length )
  return _.longMake( array );
  // return _.longShallowClone( array );

  result = _.longMakeUndefined( array, range[ 1 ]-range[ 0 ] );

  /* */

  let f2 = Math.max( range[ 0 ], 0 );
  let l2 = Math.min( array.length, range[ 1 ] );
  for( let r = f2 ; r < l2 ; r++ )
  result[ r-f2 ] = array[ r ];

  /* */

  if( val !== undefined )
  {
    for( let r = 0 ; r < -range[ 0 ] ; r++ )
    {
      result[ r ] = val;
    }
    for( let r = l2 - range[ 0 ]; r < result.length ; r++ )
    {
      result[ r ] = val;
    }
  }

  /* */

  return result;
}

//

/*
  qqq : extend documentation and test coverage of longSelectInplace
  qqq : implement arraySelect
  qqq : implement arraySelectInplace
*/

function longSelectInplace( array, range, val )
{

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( _.arrayLikeResizable( array ) )
  return _.arraySelectInplace( array, range, val );
  else
  return _.longSelect( array, range, val );
  // let result;
  //
  // if( range === undefined )
  // return array;
  //
  // if( _.numberIs( range ) )
  // range = [ range, array.length ];
  //
  // // let f = range ? range[ 0 ] : undefined;
  // // let l = range ? range[ 1 ] : undefined;
  // //
  // // f = f !== undefined ? f : 0;
  // // l = l !== undefined ? l : array.length;
  //
  // _.assert( _.longIs( array ) );
  // _.assert( _.rangeIs( range ) )
  // // _.assert( _.numberIs( f ) );
  // // _.assert( _.numberIs( l ) );
  // _.assert( 1 <= arguments.length && arguments.length <= 3 );
  // // _.assert( 1 <= arguments.length && arguments.length <= 4 );
  //
  // _.rangeClamp( range, [ 0, array.length ] );
  // if( range[ 1 ] < range[ 0 ] )
  // range[ 1 ] = range[ 0 ];
  //
  // // if( l < f )
  // // l = f;
  // //
  // // if( f < 0 )
  // // f = 0;
  // // if( l > array.length )
  // // l = array.length;
  //
  // if( range[ 0 ] === 0 && range[ 1 ] === array.length )
  // // if( range[ 0 ] === 0 && l === array.length ) // Dmytro : l is not defined
  // return array;
  //
  // // if( _.bufferTypedIs( array ) )
  // // result = new array.constructor( l-f );
  // // else
  // // result = new Array( l-f );
  //
  // result = _.longMakeUndefined( array, range[ 1 ]-range[ 0 ] );
  //
  // /* */
  //
  // let f2 = Math.max( range[ 0 ], 0 );
  // let l2 = Math.min( array.length, range[ 1 ] );
  // for( let r = f2 ; r < l2 ; r++ )
  // result[ r-range[ 0 ] ] = array[ r ];
  //
  // /* */
  //
  // if( val !== undefined )
  // {
  //   for( let r = 0 ; r < -range[ 0 ] ; r++ )
  //   {
  //     result[ r ] = val;
  //   }
  //   for( let r = l2 - range[ 0 ]; r < result.length ; r++ )
  //   {
  //     result[ r ] = val;
  //   }
  // }
  //
  // /* */
  //
  // return result;
}

//

/**
 * Changes length of provided array( array ) by copying it elements to newly created array using begin( f ),
 * end( l ) positions of the original array and value to fill free space after copy( val ). Length of new array is equal to ( l ) - ( f ).
 * If ( l ) < ( f ) - value of index ( f ) will be assigned to ( l ).
 * If ( l ) === ( f ) - returns empty array.
 * If ( l ) > ( array.length ) - returns array that contains elements with indexies from ( f ) to ( array.length ),
 * and free space filled by value of ( val ) if it was provided.
 * If ( l ) < ( array.length ) - returns array that contains elements with indexies from ( f ) to ( l ).
 * If ( l ) < 0 and ( l ) > ( f ) - returns array filled with some amount of elements with value of argument( val ).
 * If ( f ) < 0 - prepends some number of elements with value of argument( let ) to the result array.
 * @param { Array/BufferNode } array - source array or buffer;
 * @param { Number } [ f = 0 ] - index of a first element to copy into new array;
 * @param { Number } [ l = array.length ] - index of a last element to copy into new array;
 * @param { * } val - value used to fill the space left after copying elements of the original array.
 *
 * @example
 * // just partial copy of origin array
 * let arr = [ 1, 2, 3, 4 ]
 * let result = _.longGrowInplace( arr, 0, 2 );
 * console.log( result );
 * // log [ 1, 2 ]
 *
 * @example
 * // increase size, fill empty with zeroes
 * let arr = [ 1 ]
 * let result = _.longGrowInplace( arr, 0, 5, 0 );
 * console.log( result );
 * // log [ 1, 0, 0, 0, 0 ]
 *
 * @example
 * // take two last elements from original, other fill with zeroes
 * let arr = [ 1, 2, 3, 4, 5 ]
 * let result = _.longGrowInplace( arr, 3, 8, 0 );
 * console.log( result );
 * // log [ 4, 5, 0, 0, 0 ]
 *
 * @example
 * // add two zeroes at the beginning
 * let arr = [ 1, 2, 3, 4, 5 ]
 * let result = _.longGrowInplace( arr, -2, arr.length, 0 );
 * console.log( result );
 * // log [ 0, 0, 1, 2, 3, 4, 5 ]
 *
 * @example
 * // add two zeroes at the beginning and two at end
 * let arr = [ 1, 2, 3, 4, 5 ]
 * let result = _.longGrowInplace( arr, -2, arr.length + 2, 0 );
 * console.log( result );
 * // log [ 0, 0, 1, 2, 3, 4, 5, 0, 0 ]
 *
 * @example
 * // source can be also a BufferNode
 * let buffer = BufferNode.from( '123' );
 * let result = _.longGrowInplace( buffer, 0, buffer.length + 2, 0 );
 * console.log( result );
 * // log [ 49, 50, 51, 0, 0 ]
 *
 * @returns { Array } Returns resized copy of a part of an original array.
 * @function longGrowInplace
 * @throws { Error } Will throw an Error if( array ) is not a Array or BufferNode.
 * @throws { Error } Will throw an Error if( f ) or ( l ) is not a Number.
 * @throws { Error } Will throw an Error if not enough arguments provided.
 * @memberof wTools
 */

/*
  qqq : extend documentation and test coverage of longGrowInplace
  qqq : implement arrayGrow
  qqq : implement arrayGrowInplace
*/

function longGrow( array, range, val )
{
  let result;

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return _.longMake( array );

  if( _.numberIs( range ) )
  range = [ 0, range ];

  let f = range ? range[ 0 ] : undefined;
  let l = range ? range[ 1 ] : undefined;

  f = f !== undefined ? f : 0;
  l = l !== undefined ? l : array.length;

  _.assert( _.longIs( array ) );
  _.assert( _.rangeIs( range ) )
  // _.assert( _.numberIs( f ) );
  // _.assert( _.numberIs( l ) );
  // _.assert( 1 <= arguments.length && arguments.length <= 4 );

  if( l < f )
  l = f;

  if( f < 0 )
  {
    l -= f;
    f -= f;
  }

  // if( _.bufferTypedIs( array ) )
  // result = new array.constructor( l-f );
  // else
  // result = new Array( l-f );

  if( f > 0 )
  f = 0;
  if( l < array.length )
  l = array.length;

  if( l === array.length )
  return _.longMake( array );

  result = _.longMakeUndefined( array, l-f );

  /* */

  let f2 = Math.max( f, 0 );
  let l2 = Math.min( array.length, l );
  for( let r = f2 ; r < l2 ; r++ )
  result[ r-f2 ] = array[ r ];

  /* */

  if( val !== undefined )
  {
    for( let r = 0 ; r < -f ; r++ )
    {
      result[ r ] = val;
    }
    for( let r = l2 - f; r < result.length ; r++ )
    {
      result[ r ] = val;
    }
  }

  /* */

  return result;
}

//

function longGrowInplace( array, range, val )
{

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( _.arrayLikeResizable( array ) )
  return _.arrayGrowInplace( array, range, val );
  else
  return _.longGrow( array, range, val );

  // let result;
  //
  // _.assert( 1 <= arguments.length && arguments.length <= 3 );   // Dmytro : in previus place some asserts lose its own sense
  //
  // if( range === undefined )
  // return array;
  //
  // let f = range ? range[ 0 ] : undefined;
  // let l = range ? range[ 1 ] : undefined;
  //
  // f = f !== undefined ? f : 0;
  // l = l !== undefined ? l : array.length;
  //
  // _.assert( _.longIs( array ) );
  // _.assert( _.rangeIs( range ) )
  // // _.assert( _.numberIs( f ) );
  // // _.assert( _.numberIs( l ) );
  // // _.assert( 1 <= arguments.length && arguments.length <= 3 );
  // // // _.assert( 1 <= arguments.length && arguments.length <= 4 );
  //
  // if( l < f )
  // l = f;
  //
  // if( f < 0 )
  // {
  //   l -= f;
  //   f -= f;
  // }
  //
  // // if( _.bufferTypedIs( array ) )
  // // result = new array.constructor( l-f );
  // // else
  // // result = new Array( l-f );
  //
  // if( f > 0 )
  // f = 0;
  // if( l < array.length )
  // l = array.length;
  //
  // if( l === array.length )
  // return array;
  //
  // result = _.longMakeUndefined( array, l-f );
  //
  // /* */
  //
  // let f2 = Math.max( f, 0 );
  // let l2 = Math.min( array.length, l );
  // for( let r = f2 ; r < l2 ; r++ )
  // result[ r-f ] = array[ r ];
  //
  // /* */
  //
  // if( val !== undefined )
  // {
  //   for( let r = 0 ; r < -f ; r++ )
  //   {
  //     result[ r ] = val;
  //   }
  //   for( let r = l2 - f; r < result.length ; r++ )
  //   {
  //     result[ r ] = val;
  //   }
  // }
  //
  // /* */
  //
  // return result;
}

function longRelength( array, range, val )
{

  let result;

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return _.longMake( array );

  if( _.numberIs( range ) )
  range = [ range, array.length ];

  let f = range ? range[ 0 ] : undefined;
  let l = range ? range[ 1 ] : undefined;

  f = f !== undefined ? f : 0;
  l = l !== undefined ? l : src.length;

  _.assert( _.longIs( array ) );
  _.assert( _.rangeIs( range ) )

  if( l < f )
  l = f;
  if( f > array.length )
  f = array.length

  if( f < 0 )
  f = 0;

  if( f === 0 && l === array.length )
  return _.longMake( array );

  result = _.longMakeUndefined( array, l-f );

  /* */

  let f2 = Math.max( f, 0 );
  let l2 = Math.min( array.length, l );
  for( let r = f2 ; r < l2 ; r++ )
  result[ r-f2 ] = array[ r ];

  /* */

  if( val !== undefined )
  {
    for( let r = l2 - range[ 0 ]; r < result.length ; r++ )
    {
      result[ r ] = val;
    }
  }

  /* */

  return result;
}

//

function longRelengthInplace( array, range, val )
{

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( _.arrayLikeResizable( array ) )
  return _.arrayRelengthInplace( array, range, val );
  else
  return _.longRelength( array, range, val );

}

//

/**
 * The longRepresent() routine returns a shallow copy of a portion of an array
 * or a new TypedArray that contains
 * the elements from (begin) index to the (end) index,
 * but not including (end).
 *
 * @param { Array } src - Source array.
 * @param { Number } begin - Index at which to begin extraction.
 * @param { Number } end - Index at which to end extraction.
 *
 * @example
 * _.longRepresent( [ 1, 2, 3, 4, 5 ], 2, 4 );
 * // returns [ 3, 4 ]
 *
 * @example
 * _.longRepresent( [ 1, 2, 3, 4, 5 ], -4, -2 );
 * // returns [ 2, 3 ]
 *
 * @example
 * _.longRepresent( [ 1, 2, 3, 4, 5 ] );
 * // returns [ 1, 2, 3, 4, 5 ]
 *
 * @returns { Array } - Returns a shallow copy of a portion of an array into a new Array.
 * @function longRepresent
 * @throws { Error } If the passed arguments is more than three.
 * @throws { Error } If the first argument is not an array.
 * @memberof wTools
 */

/* xxx : not array */

function longRepresent( src, begin, end )
{

  _.assert( arguments.length <= 3 );
  _.assert( _.longIs( src ), 'Unknown type of (-src-) argument' );
  _.assert( _.routineIs( src.slice ) || _.routineIs( src.subarray ) );

  if( _.routineIs( src.subarray ) )
  return src.subarray( begin, end );

  return src.slice( begin, end );
}

//

// --
// buffer checker
// --

function bufferRawIs( src )
{
  let type = Object.prototype.toString.call( src );
  // let result = type === '[object ArrayBuffer]';
  // return result;
  if( type === '[object ArrayBuffer]' || type === '[object SharedArrayBuffer]' )
  return true;
  return false;
}

//

function bufferTypedIs( src )
{
  let type = Object.prototype.toString.call( src );
  if( !/\wArray/.test( type ) )
  return false;
  // Dmytro : two next lines is added to correct returned result when src is SharedArrayBuffer
  if( type === '[object SharedArrayBuffer]' )
  return false;
  if( _.bufferNodeIs( src ) )
  return false;
  return true;
}

//

function bufferViewIs( src )
{
  let type = Object.prototype.toString.call( src );
  let result = type === '[object DataView]';
  return result;
}

//

function bufferNodeIs( src )
{
  if( typeof BufferNode !== 'undefined' )
  return src instanceof BufferNode;
  return false;
}

//

function bufferAnyIs( src )
{
  if( !src )
  return false;
  if( typeof src !== 'object' )
  return false;
  if( !Reflect.has( src, 'byteLength' ) )
  return false;
  // return src.byteLength >= 0;
  // return bufferTypedIs( src ) || bufferViewIs( src )  || bufferRawIs( src ) || bufferNodeIs( src );
  return true;
}

//

function bufferBytesIs( src )
{
  if( _.bufferNodeIs( src ) )
  return false;
  return src instanceof U8x;
}

//

function constructorIsBuffer( src )
{
  if( !src )
  return false;
  if( !_.numberIs( src.BYTES_PER_ELEMENT ) )
  return false;
  if( !_.strIs( src.name ) )
  return false;
  return src.name.indexOf( 'Array' ) !== -1;
}

//

/**
 * The arrayIs() routine determines whether the passed value is an Array.
 *
 * If the {-srcMap-} is an Array, true is returned,
 * otherwise false is.
 *
 * @param { * } src - The object to be checked.
 *
 * @example
 * _.arrayIs( [ 1, 2 ] );
 * // returns true
 *
 * @example
 * _.arrayIs( 10 );
 * // returns false
 *
 * @returns { boolean } Returns true if {-srcMap-} is an Array.
 * @function arrayIs
 * @memberof wTools
 */

function arrayIs( src )
{
  return Object.prototype.toString.call( src ) === '[object Array]';
}

//

function arrayIsPopulated( src )
{
  if( !_.arrayIs( src ) )
  return false;
  return src.length > 0;
}

//

function arrayLikeResizable( src )
{
  if( Object.prototype.toString.call( src ) === '[object Array]' )
  return true;
  return false;
}

//

function arrayLike( src )
{
  /* yyy : experimental */

  return _.longIs( src );

  // if( _.arrayIs( src ) )
  // return true;
  // if( _.argumentsArrayIs( src ) )
  // return true;
  // return false;
}

//

function constructorLikeArray( src )
{
  if( !src )
  return false;

  if( src === Function )
  return false;
  if( src === Object )
  return false;
  if( src === String )
  return false;

  if( _.primitiveIs( src ) )
  return false;

  if( !( 'length' in src.prototype ) )
  return false;
  if( Object.propertyIsEnumerable.call( src.prototype, 'length' ) )
  return false;

  return true;
}

//

/**
 * The hasLength() routine determines whether the passed value has the property (length).
 *
 * If {-srcMap-} is equal to the (undefined) or (null) false is returned.
 * If {-srcMap-} has the property (length) true is returned.
 * Otherwise false is.
 *
 * @param { * } src - The object to be checked.
 *
 * @example
 * _.hasLength( [ 1, 2 ] );
 * // returns true
 *
 * @example
 * _.hasLength( 'Hello there!' );
 * // returns true
 *
 * @example
 * let isLength = ( function() {
 *   return _.hasLength( arguments );
 * } )( 'Hello there!' );
 * // returns true
 *
 * @example
 * _.hasLength( 10 );
 * // returns false
 *
 * @example
 * _.hasLength( {} );
 * // returns false
 *
 * @returns { boolean } Returns true if {-srcMap-} has the property (length).
 * @function hasLength
 * @memberof wTools
 */

function hasLength( src )
{
  if( src === undefined || src === null )
  return false;
  if( _.numberIs( src.length ) )
  return true;
  return false;
}

//

function arrayHasArray( arr )
{

  if( !_.arrayLike( arr ) )
  return false;

  for( let a = 0 ; a < arr.length ; a += 1 )
  if( _.arrayLike( arr[ a ] ) )
  return true;

  return false;
}

//

/**
 * The arrayCompare() routine returns the first difference between the values of the first array from the second.
 *
 * @param { longIs } src1 - The first array.
 * @param { longIs } src2 - The second array.
 *
 * @example
 * _.arrayCompare( [ 1, 5 ], [ 1, 2 ] );
 * // returns 3
 *
 * @returns { Number } - Returns the first difference between the values of the two arrays.
 * @function arrayCompare
 * @throws { Error } Will throw an Error if (arguments.length) is less or more than two.
 * @throws { Error } Will throw an Error if (src1 and src2) are not the array-like.
 * @throws { Error } Will throw an Error if (src2.length) is less or not equal to the (src1.length).
 * @memberof wTools
 */

function arrayCompare( src1, src2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( src1 ) && _.longIs( src2 ) );
  _.assert( src2.length >= src1.length );

  let result = 0;

  for( let s = 0 ; s < src1.length ; s++ )
  {

    result = src1[ s ] - src2[ s ];
    if( result !== 0 )
    return result;

  }

  return result;
}

//

/**
 * The arraysAreIdentical() routine checks the equality of two arrays.
 *
 * @param { longIs } src1 - The first array.
 * @param { longIs } src2 - The second array.
 *
 * @example
 * _.arraysAreIdentical( [ 1, 2, 3 ], [ 1, 2, 3 ] );
 * // returns true
 *
 * @returns { Boolean } - Returns true if all values of the two arrays are equal. Otherwise, returns false.
 * @function arraysAreIdentical
 * @throws { Error } Will throw an Error if (arguments.length) is less or more than two.
 * @memberof wTools
 */

function arraysAreIdentical( src1, src2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.longIs( src1 ) );
  _.assert( _.longIs( src2 ) );

  let result = true;

  if( src1.length !== src2.length )
  return false;

  for( let s = 0 ; s < src1.length ; s++ )
  {

    result = src1[ s ] === src2[ s ];

    if( result === false )
    return false;

  }

  return result;
}

//

function arrayHas( array, value, evaluator1, evaluator2 )
{
  _.assert( 2 <= arguments.length && arguments.length <= 4 );
  _.assert( _.arrayLike( array ) );

  if( evaluator1 === undefined )
  {
    return _ArrayIndexOf.call( array, value ) !== -1;
  }
  else
  {
    if( _.arrayLeftIndex( array, value, evaluator1, evaluator2 ) >= 0 )
    return true;
    return false;
  }

}

//

/**
 * The arrayHasAny() routine checks if the {-srcMap-} array has at least one value of the following arguments.
 *
 * It iterates over array-like (arguments[]) copies each argument to the array (ins) by the routine
 * [arrayAs()]{@link wTools.arrayAs}
 * Checks, if {-srcMap-} array has at least one value of the (ins) array.
 * If true, it returns true.
 * Otherwise, it returns false.
 *
 * @see {@link wTools.arrayAs} - See for more information.
 *
 * @param { longIs } src - The source array.
 * @param {...*} arguments - One or more argument(s).
 *
 * @example
 * _.arrayHasAny( [ 5, 'str', 42, false ], false, 7 );
 * // returns true
 *
 * @returns { Boolean } - Returns true, if {-srcMap-} has at least one value of the following argument(s), otherwise false is returned.
 * @function arrayHasAny
 * @throws { Error } If the first argument in not an array.
 * @memberof wTools
 */

function arrayHasAny( src )
{
  let empty = true;
  empty = false;

  _.assert( arguments.length >= 1, 'Expects at least one argument' );
  _.assert( _.arrayLike( src ) || _.bufferTypedIs( src ), 'arrayHasAny :', 'array expected' );

  for( let a = 1 ; a < arguments.length ; a++ )
  {
    empty = false;

    let ins = _.arrayAs( arguments[ a ] );
    for( let i = 0 ; i < ins.length ; i++ )
    {
      if( src.indexOf( ins[ i ] ) !== -1 )
      return true;
    }

  }

  return empty;
}

//

function arrayHasAll( src )
{
  _.assert( arguments.length >= 1, 'Expects at least one argument' );
  _.assert( _.arrayLike( src ) || _.bufferTypedIs( src ), 'arrayHasAll :', 'array expected' );

  for( let a = 1 ; a < arguments.length ; a++ )
  {

    let ins = _.arrayAs( arguments[ a ] );
    for( let i = 0 ; i < ins.length ; i++ )
    if( src.indexOf( ins[ i ] ) === -1 )
    return false;

  }

  return true;
}

//

function arrayHasNone( src )
{
  _.assert( arguments.length >= 1, 'Expects at least one argument' );
  _.assert( _.arrayLike( src ) || _.bufferTypedIs( src ), 'arrayHasNone :', 'array expected' );

  for( let a = 1 ; a < arguments.length ; a++ )
  {

    let ins = _.arrayAs( arguments[ a ] );
    for( let i = 0 ; i < ins.length ; i++ )
    if( src.indexOf( ins[ i ] ) !== -1 )
    return false;

  }

  return true;
}

//

function arrayAll( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.longIs( src ) );

  for( let s = 0 ; s < src.length ; s += 1 )
  {
    if( !src[ s ] )
    return false;
  }

  return true;
}

//

function arrayAny( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.longIs( src ) );

  debugger;
  for( let s = 0 ; s < src.length ; s += 1 )
  if( src[ s ] )
  return true;

  debugger;
  return false;
}

//

function arrayNone( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.longIs( src ) );

  for( let s = 0 ; s < src.length ; s += 1 )
  if( src[ s ] )
  return false;

  return true;
}

// --
// array producer
// --

/* qqq
add good coverage for arrayMake
take into account unroll cases
*/

function arrayMake( src )
{
  _.assert( arguments.length === 1 );
  _.assert( _.numberIs( src ) || _.longIs( src ) || src === null );

  if( src === null )
  return Array();

  if( _.numberIs( src ) )
  return Array( src );

  if( src.length === 1 )
  return [ src[ 0 ] ];
  else
  return Array.apply( Array, src );
}

//

/* qqq : document and cover arrayMakeUndefined */

function arrayMakeUndefined( src, length )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIs( src ) || _.longIs( src ) || src === null );
  _.assert( length === undefined || _.numberIs( length ) );

  if( src && src.length && length === undefined )
  length = src.length;

  if( !length )
  length = 0;

  _.assert( _.numberIsFinite( length ) )
  return Array( length );
}

//

/* qqq
add good coverage for arrayFrom
take into account unroll cases
*/

function arrayFrom( src )
{
  _.assert( arguments.length === 1 );
  if( _.arrayIs( src ) && !_.unrollIs( src ) )
  return src;
  return _.arrayMake.call( _, src );
}

//

/**
 * The arrayAs() routine copies passed argument to the array.
 *
 * @param { * } src - The source value.
 *
 * @example
 * _.arrayAs( false );
 * // returns [ false ]
 *
 * @example
 * _.arrayAs( { a : 1, b : 2 } );
 * // returns [ { a : 1, b : 2 } ]
 *
 * @returns { Array } - If passed null or undefined than return the empty array. If passed an array then return it.
 * Otherwise return an array which contains the element from argument.
 * @function arrayAs
 * @memberof wTools
 */

function arrayAs( src )
{
  _.assert( arguments.length === 1 );
  _.assert( src !== undefined );

  if( src === null )
  return [];
  else if( _.longIs( src ) )
  return src;
  else
  return [ src ];

}

//

function arrayAsShallowing( src )
{
  _.assert( arguments.length === 1 );
  _.assert( src !== undefined );

  if( src === null )
  return [];
  else if( _.longIs( src ) )
  return _.arraySlice( src );
  else
  return [ src ];

}

// --
// array transformer
// --

/* qqq : routine arraySlice requires good test coverage and documentation */

function arraySlice( srcArray, f, l )
{
  _.assert( _.arrayLikeResizable( srcArray ) );
  _.assert( 1 <= arguments.length && arguments.length <= 3 );
  return srcArray.slice( f, l );
}

//

function arrayBut( src, range, ins )
{

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return _.arrayMake( src );

  if( _.numberIs( range ) )
  range = [ range, range + 1 ];

  _.assert( _.arrayIs( src ) );
  _.assert( _.rangeIs( range ) );
  _.assert( ins === undefined || _.longIs( ins ) );

  _.rangeClamp( range, [ 0, src.length ] );
  if( range[ 1 ] < range[ 0 ] )
  range[ 1 ] = range[ 0 ];

  let args = [ range[ 0 ], range[ 1 ] - range[ 0 ] ];

  if( ins )
  _.arrayAppendArray( args, ins );

  /* qqq : check is it optimal to make double copy */

  let result = src.slice();

  result.splice.apply( result, args );

  return result;
}

//

function arrayButInplace( src, range, ins )
{

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return src;

  if( _.numberIs( range ) )
  range = [ range, range + 1 ];

  _.assert( _.arrayLikeResizable( src ) );
  _.assert( _.rangeIs( range ) );
  _.assert( ins === undefined || _.longIs( ins ) );

  // Dmytro : missed
  _.rangeClamp( range, [ 0, src.length ] );
  if( range[ 1 ] < range[ 0 ] )
  range[ 1 ] = range[ 0 ];
  //

  let args = [ range[ 0 ], range[ 1 ] - range[ 0 ] ];

  if( ins )
  _.arrayAppendArray( args, ins );

  let result = src;

  result.splice.apply( result, args );

  return result;
}

//

function arraySelect( src, range, ins )
{
  let result;

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return src.slice();

  if( _.numberIs( range ) )
  range = [ range, src.length ];

  _.assert( _.arrayIs( src ) );
  _.assert( _.rangeIs( range ) );

  _.rangeClamp( range, [ 0, src.length ] );
  if( range[ 1 ] < range[ 0 ] )
  range[ 1 ] = range[ 0 ];

  if( range[ 0 ] === 0 && range[ 1 ] === src.length )
  return src.slice( src );

  result = _.arrayMakeUndefined( src, range[ 1 ]-range[ 0 ] );

  let f2 = Math.max( range[ 0 ], 0 );
  let l2 = Math.min( src.length, range[ 1 ] );
  for( let r = f2 ; r < l2 ; r++ )
  result[ r-range[ 0 ] ] = src[ r ];

  return result;
}

//

function arraySelectInplace( src, range, ins )
{

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return src;

  if( _.numberIs( range ) )
  range = [ range, src.length ];

  _.assert( _.arrayIs( src ) );
  _.assert( _.rangeIs( range ) );

  _.rangeClamp( range, [ 0, src.length ] );
  if( range[ 1 ] < range[ 0 ] )
  range[ 1 ] = range[ 0 ];

  if( range[ 0 ] === 0 && range[ 1 ] === src.length )
  return src;

  let f2 = Math.max( range[ 0 ], 0 );
  let l2 = Math.min( src.length, range[ 1 ] );

  let result = src;

  result.splice.apply( result, [ 0, f2 ] );
  result.length = range[ 1 ] - range[ 0 ];

  return result;
}

//

function arrayGrow( src, range, ins )
{
  let result;

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return src.slice();

  if( _.numberIs( range ) )
  range = [ 0, range ];

  let f = range ? range[ 0 ] : undefined;
  let l = range ? range[ 1 ] : undefined;

  f = f !== undefined ? f : 0;
  l = l !== undefined ? l : src.length;

  _.assert( _.arrayIs( src ) );
  _.assert( _.rangeIs( range ) )

  if( l < f )
  l = f;

  if( f < 0 )
  {
    l -= f;
    f -= f;
  }

  if( f > 0 )
  f = 0;
  if( l < src.length )
  l = src.length;

  if( l === src.length )
  return src.slice();

  result = _.arrayMakeUndefined( src, l-f );

  let f2 = Math.max( f, 0 );
  let l2 = Math.min( src.length, l );
  for( let r = f2 ; r < l2 ; r++ )
  result[ r-f ] = src[ r ];

  if( ins !== undefined )
  {
    for( let r = l2 - f; r < result.length ; r++ )
    {
      result[ r ] = ins;
    }
  }

  return result;
}

//

function arrayGrowInplace( src, range, ins )
{

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return src;

  if( _.numberIs( range ) )
  range = [ 0, range ];

  let f = range ? range[ 0 ] : undefined;
  let l = range ? range[ 1 ] : undefined;

  f = f !== undefined ? f : 0;
  l = l !== undefined ? l : src.length;

  _.assert( _.arrayIs( src ) );
  _.assert( _.rangeIs( range ) )

  if( l < f )
  l = f;

  if( f < 0 )
  {
    l -= f;
    f -= f;
  }

  if( f > 0 )
  f = 0;
  if( l < src.length )
  l = src.length;

  if( l === src.length )
  return src;

  let l2 = Math.min( src.length, l );

  let result = src;
  result.length = l;

  if( ins !== undefined )
  {
    for( let r = l2; r < result.length ; r++ )
    {
      result[ r ] = ins;
    }
  }

  return result;
}

//

function arrayRelength( src, range, ins )
{
  let result;

  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return src.slice();

  if( _.numberIs( range ) )
  range = [ range, src.length ];

  let f = range ? range[ 0 ] : undefined;
  let l = range ? range[ 1 ] : undefined;

  f = f !== undefined ? f : 0;
  l = l !== undefined ? l : src.length;

  _.assert( _.arrayIs( src ) );
  _.assert( _.rangeIs( range ) );

  if( l < f )
  l = f;

  if( f < 0 )
  f = 0;

  if( f === 0 && l === src.length )
  return src.slice( src );

  result = _.arrayMakeUndefined( src, l-f );

  let f2 = Math.max( f, 0 );
  let l2 = Math.min( src.length, l );
  for( let r = f2 ; r < l2 ; r++ )
  result[ r-f2 ] = src[ r ];

  if( ins !== undefined )
  {
    for( let r = l2 - f; r < result.length ; r++ )
    {
      result[ r ] = ins;
    }
  }

  return result;
}

//

function arrayRelengthInplace( src, range, ins )
{
  _.assert( 1 <= arguments.length && arguments.length <= 3 );

  if( range === undefined )
  return src;

  if( _.numberIs( range ) )
  range = [ range, src.length ];

  let f = range ? range[ 0 ] : undefined;
  let l = range ? range[ 1 ] : undefined;

  f = f !== undefined ? f : 0;
  l = l !== undefined ? l : src.length;

  _.assert( _.arrayIs( src ) );
  _.assert( _.rangeIs( range ) );

  if( l < f )
  l = f;

  if( f < 0 )
  f = 0;

  if( f === 0 && l === src.length )
  return src;

  let f2 = Math.max( f, 0 );
  let l2 = Math.min( src.length, l );

  let result = src;

  result.splice.apply( result, [ 0, f ] );
  result.length = l - f;

  if( ins !== undefined )
  {
    for( let r = l2 - f; r < result.length ; r++ )
    {
      result[ r ] = ins;
    }
  }

  return result;
}

// --
// array sequential search
// --

function arrayLeftIndex( arr, ins, evaluator1, evaluator2 )
{
  let fromIndex = 0;

  if( _.numberIs( arguments[ 2 ] ) )
  {
    fromIndex = arguments[ 2 ];
    evaluator1 = arguments[ 3 ];
    evaluator2 = arguments[ 4 ];
  }

  _.assert( 2 <= arguments.length && arguments.length <= 5 );
  _.assert( _.longIs( arr ) );
  _.assert( _.numberIs( fromIndex ) );
  _.assert( evaluator1 === undefined || evaluator1.length === 1 || evaluator1.length === 2 );
  _.assert( evaluator1 === undefined || _.routineIs( evaluator1 ) );
  _.assert( evaluator2 === undefined || evaluator2.length === 1 );
  _.assert( evaluator2 === undefined || _.routineIs( evaluator2 ) );

  if( !evaluator1 )
  {
    _.assert( !evaluator2 );
    return _ArrayIndexOf.call( arr, ins, fromIndex );
  }
  else if( evaluator1.length === 2 ) /* equalizer */
  {
    _.assert( !evaluator2 );
    for( let a = fromIndex ; a < arr.length ; a++ )
    {
      if( evaluator1( arr[ a ], ins ) )
      return a;
    }
  }
  else
  {

    if( evaluator2 )
    ins = evaluator2( ins );
    else
    ins = evaluator1( ins );

    for( let a = fromIndex; a < arr.length ; a++ )
    {
      if( evaluator1( arr[ a ] ) === ins )
      return a;
    }

  }

  return -1;
}

//

function arrayRightIndex( arr, ins, evaluator1, evaluator2 )
{

  let fromIndex = arr.length-1;

  if( _.numberIs( arguments[ 2 ] ) )
  {
    fromIndex = arguments[ 2 ];
    evaluator1 = arguments[ 3 ];
    evaluator2 = arguments[ 4 ];
  }

  _.assert( 2 <= arguments.length && arguments.length <= 5 );
  _.assert( _.numberIs( fromIndex ) );
  _.assert( evaluator1 === undefined || evaluator1.length === 1 || evaluator1.length === 2 );
  _.assert( evaluator1 === undefined || _.routineIs( evaluator1 ) );
  _.assert( evaluator2 === undefined || evaluator2.length === 1 );
  _.assert( evaluator2 === undefined || _.routineIs( evaluator2 ) );

  if( !evaluator1 )
  {
    _.assert( !evaluator2 );
    if( !_.arrayIs( arr ) )
    debugger;
    return _ArrayLastIndexOf.call( arr, ins, fromIndex );
  }
  else if( evaluator1.length === 2 ) /* equalizer */
  {
    _.assert( !evaluator2 );
    for( let a = fromIndex ; a >= 0 ; a-- )
    {
      if( evaluator1( arr[ a ], ins ) )
      return a;
    }
  }
  else
  {

    if( evaluator2 )
    ins = evaluator2( ins );
    else
    ins = evaluator1( ins );

    for( let a = fromIndex ; a >= 0 ; a-- )
    {
      if( evaluator1( arr[ a ] ) === ins )
      return a;
    }

  }

  return -1;
}

//

/**
 * The arrayLeft() routine returns a new object containing the properties, (index, element),
 * corresponding to a found value (ins) from an array (arr).
 *
 * It creates the variable (i), assigns and calls to it the function( _.arrayLeftIndex( arr, ins, evaluator1 ) ),
 * that returns the index of the value (ins) in the array (arr).
 * [wTools.arrayLeftIndex()]{@link wTools.arrayLeftIndex}
 * If (i) is more or equal to the zero, it returns the object containing the properties ({ index : i, element : arr[ i ] }).
 * Otherwise, it returns the empty object.
 *
 * @see {@link wTools.arrayLeftIndex} - See for more information.
 *
 * @param { longIs } arr - Entity to check.
 * @param { * } ins - Element to locate in the array.
 * @param { wTools~compareCallback } evaluator1 - A callback function.
 *
 * @example
 * _.arrayLeft( [ 1, 2, false, 'str', 5 ], 'str', function( a, b ) { return a === b } );
 * // returns { index : 3, element : 'str' }
 *
 * @example
 * _.arrayLeft( [ 1, 2, 3, 4, 5 ], 6 );
 * // returns {}
 *
 * @returns { Object } Returns a new object containing the properties, (index, element),
 * corresponding to the found value (ins) from the array (arr).
 * Otherwise, it returns the empty object.
 * @function arrayLeft
 * @throws { Error } Will throw an Error if (evaluator1) is not a Function.
 * @memberof wTools
 */

function arrayLeft( arr, ins, evaluator1, evaluator2 )
{
  let result = Object.create( null );
  let i = _.arrayLeftIndex( arr, ins, evaluator1, evaluator2 );

  _.assert( 2 <= arguments.length && arguments.length <= 4 );

  if( i >= 0 )
  {
    result.index = i;
    result.element = arr[ i ];
  }

  return result;
}

//

function arrayRight( arr, ins, evaluator1, evaluator2 )
{
  let result = Object.create( null );
  let i = _.arrayRightIndex( arr, ins, evaluator1, evaluator2 );

  _.assert( 2 <= arguments.length && arguments.length <= 4 );

  if( i >= 0 )
  {
    result.index = i;
    result.element = arr[ i ];
  }

  return result;
}

//

function arrayLeftDefined( arr )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  return _.arrayLeft( arr, true, function( e ){ return e !== undefined; } );
}

//

function arrayRightDefined( arr )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  return _.arrayRight( arr, true, function( e ){ return e !== undefined; } );
}

//

/**
 * The arrayCountElement() routine returns the count of matched elements in the {-srcArray-} array with the input { element }.
 * Returns 0 if no { element } is provided. It can take equalizer or evaluators for the routine equalities.
 *
 * @param { Array } src - The source array.
 * @param { * } element - The value to search.
 * @param { * } [ onEvaluate1 ] - It's a routine. If the routine has two parameters, it is used as an equalizer, and if it has only one, then routine used as the first part of the evaluator.
 * @param { * } [ onEvaluate2 ] - The second part of evaluator. Change the value to search.
 *
 * @example
 * // simple exapmle
 * _.arrayCountElement( [ 1, 2, 'str', 10, 10, true ], 10 );
 * // returns 2
 *
 * @example
 * // with equalizer
 * _.arrayCountElement( [ 1, 2, 'str', 10, 10, true ], 10, ( a, b ) => _.typeOf( a ) === _.typeOf( b ) );
 * // returns 4
 *
 * @example
 * // with evaluator
 * _.arrayCountElement( [ [ 10, 2 ], [ 10, 2 ], [ 'str', 10 ], [ 10, true ], [ false, 10 ] ], 10, ( e ) => e[ 0 ], ( e ) => e );
 * // returns 4
 *
 * @returns { Number } - Returns the count of matched elements in the {-srcArray-} with the { element } element.
 * @function arrayCountElement
 * @throws { Error } If passed arguments is less than two or more than four.
 * @throws { Error } If the first argument is not an array-like object.
 * @throws { Error } If the third or fourth argument is not a routine.
 * @throws { Error } If the routine in third argument has less than one or more than two arguments.
 * @throws { Error } If the routine in third argument has two arguments and fourth argument is passed into routine arrayCountElement.
 * @throws { Error } If the routine in fourth argument has less than one or more than one arguments.
 * @memberof wTools
 */

function arrayCountElement( srcArray, element, onEvaluate1, onEvaluate2 )
{
  let result = 0;

  _.assert( 2 <= arguments.length && arguments.length <= 4 );
  _.assert( _.longIs( srcArray ), 'Expects long' );

  let left = _.arrayLeftIndex( srcArray, element, onEvaluate1, onEvaluate2 );
  // let index = srcArray.indexOf( element );

  while( left >= 0 )
  {
    result += 1;
    left = _.arrayLeftIndex( srcArray, element, left+1, onEvaluate1, onEvaluate2 );
    // index = srcArray.indexOf( element, index+1 );
  }

  return result;
}

//

/**
 * The arrayCountTotal() adds all the elements in { -srcArray- }, elements can be numbers or booleans ( it considers them 0 or 1 ).
 *
 * @param { Array } srcArray - The source array.
 *
 * @example
 * _.arrayCountTotal( [ 1, 2, 10, 10 ] );
 * // returns 23
 *
 * @example
 * _.arrayCountTotal( [ true, false, false ] );
 * // returns 1
 *
 * @returns { Number } - Returns the sum of the elements in { srcArray }.
 * @function arrayCountTotal
 * @throws { Error } If passed arguments is different than one.
 * @throws { Error } If the first argument is not an array-like object.
 * @throws { Error } If { srcArray} doesn´t contain number-like elements.
 * @memberof wTools
 */

function arrayCountTotal( srcArray )
{
  let result = 0;

  _.assert( arguments.length === 1 );
  _.assert( _.longIs( srcArray ), 'Expects long' );

  for( let i = 0 ; i < srcArray.length ; i++ )
  {
    _.assert( _.boolIs( srcArray[ i ] ) || _.numberIs( srcArray[ i ] )|| srcArray[ i ] === null );
    result += srcArray[ i ];
  }

  return result;
}

//

/**
 * The arrayCountUnique() routine returns the count of matched pairs ([ 1, 1, 2, 2, ., . ]) in the array {-srcMap-}.
 *
 * @param { longIs } src - The source array.
 * @param { Function } [ onEvaluate = function( e ) { return e } ] - A callback function.
 *
 * @example
 * _.arrayCountUnique( [ 1, 1, 2, 'abc', 'abc', 4, true, true ] );
 * // returns 3
 *
 * @example
 * _.arrayCountUnique( [ 1, 2, 3, 4, 5 ] );
 * // returns 0
 *
 * @returns { Number } - Returns the count of matched pairs ([ 1, 1, 2, 2, ., . ]) in the array {-srcMap-}.
 * @function arrayCountUnique
 * @throws { Error } If passed arguments is less than one or more than two.
 * @throws { Error } If the first argument is not an array-like object.
 * @throws { Error } If the second argument is not a Function.
 * @memberof wTools
 */

function arrayCountUnique( src, onEvaluate )
{
  let found = [];
  onEvaluate = onEvaluate || function( e ){ return e };

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.longIs( src ), 'arrayCountUnique :', 'Expects ArrayLike' );
  _.assert( _.routineIs( onEvaluate ) );
  _.assert( onEvaluate.length === 1 );

  for( let i1 = 0 ; i1 < src.length ; i1++ )
  {
    let element1 = onEvaluate( src[ i1 ] );
    if( found.indexOf( element1 ) !== -1 )
    continue;

    for( let i2 = i1+1 ; i2 < src.length ; i2++ )
    {

      let element2 = onEvaluate( src[ i2 ] );
      if( found.indexOf( element2 ) !== -1 )
      continue;

      if( element1 === element2 )
      found.push( element1 );

    }

  }

  return found.length;
}

// --
// array prepend
// --

/*

qqq : optimize *OnlyStrict* routines
qqq : use for documentation

alteration Routines :

- array { Op } { Tense } { Second } { How }

alteration Op : [ Append , Prepend , Remove, Flatten ]        // operation
alteration Tense : [ - , ed ]                                 // what to return
alteration Second : [ -, element, array, array ]              // how to treat src arguments
alteration How : [ - , Once , OnceStrictly ]                  // how to treat repeats

~ 60 routines

*/

//

// function arrayPrepend_( dstArray )
// {
//   _.assert( arguments.length >= 1 );
//   _.assert( _.arrayIs( dstArray ) || dstArray === null, 'Expects array' );
//
//   dstArray = dstArray || [];
//
//   for( let a = arguments.length - 1 ; a >= 1 ; a-- )
//   {
//     if( _.longIs( arguments[ a ] ) )
//     {
//       dstArray.unshift.apply( dstArray, arguments[ a ] );
//     }
//     else
//     {
//       dstArray.unshift( arguments[ a ] );
//     }
//   }
//
//   return dstArray;
// }

//

function arrayPrepend( dstArray, ins )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayPrepended.apply( this, arguments );
  return dstArray;
}

//

/**
 * Method adds a value of argument( ins ) to the beginning of an array( dstArray )
 * if destination( dstArray ) doesn't have the value of ( ins ).
 * Additionaly takes callback( onEqualize ) that checks if element from( dstArray ) is equal to( ins ).
 *
 * @param { Array } dstArray - The destination array.
 * @param { * } ins - The value to add.
 * @param { wTools~compareCallback } onEqualize - A callback function. By default, it checks the equality of two arguments.
 *
 * @example
 * _.arrayPrependOnce( [ 1, 2, 3, 4 ], 5 );
 * // returns [ 5, 1, 2, 3, 4 ]
 *
 * @example
 * _.arrayPrependOnce( [ 1, 2, 3, 4, 5 ], 5 );
 * // returns [ 1, 2, 3, 4, 5 ]
 *
 * @example
 * _.arrayPrependOnce( [ 'Petre', 'Mikle', 'Oleg' ], 'Dmitry' );
 * // returns [ 'Dmitry', 'Petre', 'Mikle', 'Oleg' ]
 *
 * @example
 * _.arrayPrependOnce( [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ], 'Dmitry' );
 * // returns [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ]
 *
 * @example
 * function onEqualize( a, b )
 * {
 *  return a.value === b.value;
 * };
 * _.arrayPrependOnce( [ { value : 1 }, { value : 2 } ], { value : 1 }, onEqualize );
 * // returns [ { value : 1 }, { value : 2 } ]
 *
 * @returns { Array } If an array ( dstArray ) doesn't have a value ( ins ) it returns the updated array ( dstArray ) with the new length,
 * otherwise, it returns the original array ( dstArray ).
 * @function arrayPrependOnce
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if ( onEqualize ) is not an Function.
 * @throws { Error } An Error if ( arguments.length ) is not equal two or three.
 * @memberof wTools
 */

function arrayPrependOnce( dstArray, ins, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayPrependedOnce.apply( this, arguments );
  return dstArray;
}

//

/**
 * Method adds a value of argument( ins ) to the beginning of an array( dstArray )
 * if destination( dstArray ) doesn't have the value of ( ins ).
 * Additionaly takes callback( onEqualize ) that checks if element from( dstArray ) is equal to( ins ).
 * Returns updated array( dstArray ) if( ins ) was added, otherwise throws an Error.
 *
 * @param { Array } dstArray - The destination array.
 * @param { * } ins - The value to add.
 * @param { wTools~compareCallback } onEqualize - A callback function. By default, it checks the equality of two arguments.
 *
 * @example
 * _.arrayPrependOnceStrictly( [ 1, 2, 3, 4 ], 5 );
 * // returns [ 5, 1, 2, 3, 4 ]
 *
 * @example
 * _.arrayPrependOnceStrictly( [ 1, 2, 3, 4, 5 ], 5 );
 * // throws error
 *
 * @example
 * _.arrayPrependOnceStrictly( [ 'Petre', 'Mikle', 'Oleg' ], 'Dmitry' );
 * // returns [ 'Dmitry', 'Petre', 'Mikle', 'Oleg' ]
 *
 * @example
 * _.arrayPrependOnceStrictly( [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ], 'Dmitry' );
 * // throws error
 *
 * @example
 * function onEqualize( a, b )
 * {
 *  return a.value === b.value;
 * };
 * _.arrayPrependOnceStrictly( [ { value : 1 }, { value : 2 } ], { value : 0 }, onEqualize );
 * // returns [ { value : 0 }, { value : 1 }, { value : 2 } ]
 *
 * @returns { Array } If an array ( dstArray ) doesn't have a value ( ins ) it returns the updated array ( dstArray ) with the new length,
 * otherwise, it throws an Error.
 * @function arrayPrependOnceStrictly
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if ( onEqualize ) is not an Function.
 * @throws { Error } An Error if ( arguments.length ) is not equal two or three.
 * @throws { Error } An Error if ( ins ) already exists on( dstArray ).
 * @memberof wTools
 */

function arrayPrependOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  let result;
  if ( Config.debug )
  {
    debugger;
    result = arrayPrependedOnce.apply( this, arguments );
    _.assert( result >= 0, () => 'Array should have only unique elements, but has several ' + _.strShort( ins ) );
  }
  else
  {
    result = arrayPrepended.apply( this, [ dstArray, ins ] );
  }

  return dstArray;
}

//

function arrayPrepended( dstArray, ins )
{
  _.assert( arguments.length === 2  );
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );

  dstArray.unshift( ins );
  return 0;
}

//

/**
 * Method adds a value of argument( ins ) to the beginning of an array( dstArray )
 * if destination( dstArray ) doesn't have the value of ( ins ).
 * Additionaly takes callback( onEqualize ) that checks if element from( dstArray ) is equal to( ins ).
 *
 * @param { Array } dstArray - The destination array.
 * @param { * } ins - The value to add.
 * @param { wTools~compareCallback } onEqualize - A callback function. By default, it checks the equality of two arguments.
 *
 * @example
 * _.arrayPrependedOnce( [ 1, 2, 3, 4 ], 5 );
 * // returns 0
 *
 * @example
 * _.arrayPrependedOnce( [ 1, 2, 3, 4, 5 ], 5 );
 * // returns -1
 *
 * @example
 * _.arrayPrependedOnce( [ 'Petre', 'Mikle', 'Oleg' ], 'Dmitry' );
 * // returns 0
 *
 * @example
 * _.arrayPrependedOnce( [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ], 'Dmitry' );
 * // returns -1
 *
 * @example
 * function onEqualize( a, b )
 * {
 *  return a.value === b.value;
 * };
 * _.arrayPrependedOnce( [ { value : 1 }, { value : 2 } ], { value : 1 }, onEqualize );
 * // returns -1
 *
 * @returns { Array } Returns zero if elements was succesfully added, otherwise returns -1.
 *
 * @function arrayPrependedOnce
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if ( onEqualize ) is not an Function.
 * @throws { Error } An Error if ( arguments.length ) is not equal two or three.
 * @memberof wTools
 */

function arrayPrependedOnce( dstArray, ins, evaluator1, evaluator2 )
{
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );

  let i = _.arrayLeftIndex.apply( _, arguments );

  if( i === -1 )
  {
    dstArray.unshift( ins );
    return 0;
  }
  return -1;
}

//

function arrayPrependedOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{
  let result;
  if ( Config.debug )
  {
    debugger;
    result = arrayPrependedOnce.apply( this, arguments );
    _.assert( result >= 0, () => 'Array should have only unique elements, but has several ' + _.strShort( ins ) );
  }
  else
  {
    result = arrayPrepended.apply( this, [ dstArray, ins ] );
  }

  return result;
}

//

/**
 * Routine adds a value of argument( ins ) to the beginning of an array( dstArray ).
 *
 * @param { Array } dstArray - The destination array.
 * @param { * } ins - The element to add.
 *
 * @example
 * _.arrayPrependElement( [ 1, 2, 3, 4 ], 5 );
 * // returns [ 5, 1, 2, 3, 4 ]
 *
 * @example
 * _.arrayPrependElement( [ 1, 2, 3, 4, 5 ], 5 );
 * // returns [ 5, 1, 2, 3, 4, 5 ]
 *
 * @returns { Array } Returns updated array, that contains new element( ins ).
 * @function arrayPrependElement
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if ( arguments.length ) is less or more than two.
 * @memberof wTools
 */

function arrayPrependElement( dstArray, ins )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayPrependedElement.apply( this, arguments );
  return dstArray;
}

//

function arrayPrependElementOnce( dstArray, ins, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayPrependedElementOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayPrependElementOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  let result;
  if ( Config.debug )
  {
    debugger;
    result = arrayPrependedElementOnce.apply( this, arguments );
    _.assert( result !== undefined, 'Array should have only unique elements, but has several', ins );
  }
  else
  {
    result = arrayPrependedElement.apply( this, [ dstArray, ins ] );
  }

  return dstArray;
}

/*
function arrayPrependOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{

  let result = arrayPrependedOnce.apply( this, arguments );
  _.assert( result >= 0, () => 'Array should have only unique elements, but has several ' + _.strShort( ins ) );

  return dstArray;
}
*/

//

/**
 * Method adds a value of argument( ins ) to the beginning of an array( dstArray )
 * and returns zero if value was succesfully added.
 *
 * @param { Array } dstArray - The destination array.
 * @param { * } ins - The element to add.
 *
 * @example
 * _.arrayPrependedElement( [ 1, 2, 3, 4 ], 5 );
 * // returns 0
 *
 * @returns { Array } Returns updated array, that contains new element( ins ).
 * @function arrayPrependedElement
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if ( arguments.length ) is not equal to two.
 * @memberof wTools
 */

function arrayPrependedElement( dstArray, ins )
{
  _.assert( arguments.length === 2  );
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );

  dstArray.unshift( ins );

  /* xxx qqq : should return element, not index */
  // return 0;
  return ins;
}

//

function arrayPrependedElementOnce( dstArray, ins, evaluator1, evaluator2 )
{
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );

  let i = _.arrayLeftIndex.apply( _, arguments );

  if( i === -1 )
  {
    dstArray.unshift( ins );
    return dstArray[ 0 ];
  }
  return undefined;
}

//

function arrayPrependedElementOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{
  let result;
  if ( Config.debug )
  {
    debugger;
    result = arrayPrependedElementOnce.apply( this, arguments );
    _.assert( result !== undefined, 'Array should have only unique elements, but has several', ins );
  }
  else
  {
    result = arrayPrependedElement.apply( this, [ dstArray, ins ] );
  }

  return result;
}

//

/**
 * Method adds all elements from array( insArray ) to the beginning of an array( dstArray ).
 *
 * @param { Array } dstArray - The destination array.
 * @param { ArrayLike } insArray - The source array.
 *
 * @example
 * _.arrayPrependArray( [ 1, 2, 3, 4 ], [ 5 ] );
 * // returns [ 5, 1, 2, 3, 4 ]
 *
 * @example
 * _.arrayPrependArray( [ 1, 2, 3, 4, 5 ], [ 5 ] );
 * // returns [ 5, 1, 2, 3, 4, 5 ]
 *
 * @returns { Array } Returns updated array, that contains elements from( insArray ).
 * @function arrayPrependArray
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if ( insArray ) is not an ArrayLike entity.
 * @throws { Error } An Error if ( arguments.length ) is less or more than two.
 * @memberof wTools
 */

function arrayPrependArray( dstArray, insArray )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayPrependedArray.apply( this, arguments );
  return dstArray;
}

//

/**
 * Method adds all unique elements from array( insArray ) to the beginning of an array( dstArray )
 * Additionaly takes callback( onEqualize ) that checks if element from( dstArray ) is equal to( ins ).
 *
 * @param { Array } dstArray - The destination array.
 * @param { ArrayLike } insArray - The source array.
 * @param { wTools~compareCallback } onEqualize - A callback function. By default, it checks the equality of two arguments.
 *
 * @example
 * _.arrayPrependArrayOnce( [ 1, 2, 3, 4 ], [ 0, 1, 2, 3, 4 ] );
 * // returns [ 0, 1, 2, 3, 4 ]
 *
 * @example
 * _.arrayPrependArrayOnce( [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ], [ 'Dmitry' ] );
 * // returns [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ]
 *
 * @example
 * function onEqualize( a, b )
 * {
 *  return a.value === b.value;
 * };
 * _.arrayPrependArrayOnce( [ { value : 1 }, { value : 2 } ], [ { value : 1 } ], onEqualize );
 * // returns [ { value : 1 }, { value : 2 } ]
 *
 * @returns { Array } Returns updated array( dstArray ) or original if nothing added.
 * @function arrayPrependArrayOnce
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if ( insArray ) is not an ArrayLike entity.
 * @throws { Error } An Error if ( onEqualize ) is not an Function.
 * @throws { Error } An Error if ( arguments.length ) is not equal two or three.
 * @memberof wTools
 */

function arrayPrependArrayOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayPrependedArrayOnce.apply( this, arguments );
  return dstArray;
}

//

/**
 * Method adds all unique elements from array( insArray ) to the beginning of an array( dstArray )
 * Additionaly takes callback( onEqualize ) that checks if element from( dstArray ) is equal to( ins ).
 * Returns updated array( dstArray ) if all elements from( insArray ) was added, otherwise throws error.
 * Even error was thrown, elements that was prepended to( dstArray ) stays in the destination array.
 *
 * @param { Array } dstArray - The destination array.
 * @param { ArrayLike } insArray - The source array.
 * @param { wTools~compareCallback } onEqualize - A callback function. By default, it checks the equality of two arguments.
 *
 * @example
 * _.arrayPrependArrayOnceStrictly( [ 1, 2, 3, 4 ], [ 0, 1, 2, 3, 4 ] );
 * // returns [ 0, 1, 2, 3, 4 ]
 *
 * @example
 * function onEqualize( a, b )
 * {
 *  return a.value === b.value;
 * };
 * _.arrayPrependArrayOnceStrictly( [ { value : 1 }, { value : 2 } ], { value : 1 }, onEqualize );
 * // returns [ { value : 1 }, { value : 2 } ]
 *
 * * @example
 * let dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
 * _.arrayPrependArrayOnceStrictly( dst, [ 'Antony', 'Dmitry' ] );
 * // throws error, but dstArray was updated by one element from insArray
 *
 * @returns { Array } Returns updated array( dstArray ) or throws an error if not all elements from source
 * array( insArray ) was added.
 * @function arrayPrependArrayOnceStrictly
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if ( insArray ) is not an ArrayLike entity.
 * @throws { Error } An Error if ( onEqualize ) is not an Function.
 * @throws { Error } An Error if ( arguments.length ) is not equal two or three.
 * @memberof wTools
 */

function arrayPrependArrayOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  let result;
  if( Config.debug )
  {
    result = arrayPrependedArrayOnce.apply( this, arguments );
    _.assert( result === insArray.length );
  }
  else
  {
    result = arrayPrependedArray.apply( this, [ dstArray, insArray ] );
  }

  return dstArray;
}

/*
function arrayPrependArrayOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  let result = arrayPrependedArrayOnce.apply( this, arguments );
  _.assert( result === insArray.length );
  return dstArray;
}
*/

//

/**
 * Method adds all elements from array( insArray ) to the beginning of an array( dstArray ).
 * Returns count of added elements.
 *
 * @param { Array } dstArray - The destination array.
 * @param { ArrayLike } insArray - The source array.
 *
 * @example
 * let dst = [ 1, 2, 3, 4 ];
 * _.arrayPrependedArray( dst, [ 5, 6, 7 ] );
 * // returns 3
 * console.log( dst );
 * //log [ 5, 6, 7, 1, 2, 3, 4 ]
 *
 * @returns { Array } Returns count of added elements.
 * @function arrayPrependedArray
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if ( insArray ) is not an ArrayLike entity.
 * @throws { Error } An Error if ( arguments.length ) is less or more than two.
 * @memberof wTools
 */

function arrayPrependedArray( dstArray, insArray )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.arrayIs( dstArray ), 'arrayPrependedArray :', 'Expects array' );
  _.assert( _.longIs( insArray ), 'arrayPrependedArray :', 'Expects longIs' );

  dstArray.unshift.apply( dstArray, insArray );
  return insArray.length;
}

//

/**
 * Method adds all unique elements from array( insArray ) to the beginning of an array( dstArray )
 * Additionaly takes callback( onEqualize ) that checks if element from( dstArray ) is equal to( ins ).
 * Returns count of added elements.
 *
 * @param { Array } dstArray - The destination array.
 * @param { ArrayLike } insArray - The source array.
 * @param { wTools~compareCallback } onEqualize - A callback function. By default, it checks the equality of two arguments.
 *
 * @example
 * _.arrayPrependedArrayOnce( [ 1, 2, 3 ], [ 4, 5, 6] );
 * // returns 3
 *
 * @example
 * _.arrayPrependedArrayOnce( [ 0, 2, 3, 4 ], [ 1, 1, 1 ] );
 * // returns 1
 *
 * @example
 * _.arrayPrependedArrayOnce( [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ], [ 'Dmitry' ] );
 * // returns 0
 *
 * @example
 * function onEqualize( a, b )
 * {
 *  return a.value === b.value;
 * };
 * _.arrayPrependedArrayOnce( [ { value : 1 }, { value : 2 } ], [ { value : 1 } ], onEqualize );
 * // returns 0
 *
 * @returns { Array } Returns count of added elements.
 * @function arrayPrependedArrayOnce
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if ( insArray ) is not an ArrayLike entity.
 * @throws { Error } An Error if ( onEqualize ) is not an Function.
 * @throws { Error } An Error if ( arguments.length ) is not equal two or three.
 * @memberof wTools
 */

function arrayPrependedArrayOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );
  _.assert( _.longIs( insArray ) );
  _.assert( dstArray !== insArray );
  _.assert( 2 <= arguments.length && arguments.length <= 4 );

  let result = 0;

  for( let i = insArray.length - 1; i >= 0; i-- )
  {
    if( _.arrayLeftIndex( dstArray, insArray[ i ], evaluator1, evaluator2 ) === -1 )
    {
      dstArray.unshift( insArray[ i ] );
      result += 1;
    }
  }

  return result;
}

//

function arrayPrependedArrayOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
 let result;
 if( Config.debug )
 {
   result = arrayPrependedArrayOnce.apply( this, arguments );
   _.assert( result === insArray.length );
 }
 else
 {
   result = arrayPrependedArray.apply( this, [ dstArray, insArray ] );
 }

 return result;
}

//

/**
 * Method adds all elements from provided arrays to the beginning of an array( dstArray ) in same order
 * that they are in( arguments ).
 * If argument provided after( dstArray ) is not a ArrayLike entity it will be prepended to destination array as usual element.
 * If argument is an ArrayLike entity and contains inner arrays, routine looks for elements only on first two levels.
 * Example: _.arrayPrependArrays( [], [ [ 1 ], [ [ 2 ] ] ] ) -> [ 1, [ 2 ] ];
 * Throws an error if one of arguments is undefined. Even if error was thrown, elements that was prepended to( dstArray ) stays in the destination array.
 *
 * @param { Array } dstArray - The destination array.
 * @param{ longIs | * } arguments[...] - Source arguments.
 *
 * @example
 * _.arrayPrependArrays( [ 1, 2, 3, 4 ], [ 5 ], [ 6 ], 7 );
 * // returns [ 5, 6, 7, 1, 2, 3, 4 ]
 *
 * @example
 * let dst = [ 1, 2, 3, 4 ];
 * _.arrayPrependArrays( dst, [ 5 ], [ 6 ], undefined );
 * // throws error, but dst becomes equal [ 5, 6, 1, 2, 3, 4 ]
 *
 * @returns { Array } Returns updated array( dstArray ).
 * @function arrayPrependArrays
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if one of ( arguments ) is undefined.
 * @memberof wTools
 */

function arrayPrependArrays( dstArray, insArray )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayPrependedArrays.apply( this, arguments );
  return dstArray;
}

//

/**
 * Method adds all unique elements from provided arrays to the beginning of an array( dstArray ) in same order
 * that they are in( arguments ).
 * If argument provided after( dstArray ) is not a ArrayLike entity it will be prepended to destination array as usual element.
 * If argument is an ArrayLike entity and contains inner arrays, routine looks for elements only on first two levels.
 * Example: _.arrayPrependArrays( [], [ [ 1 ], [ [ 2 ] ] ] ) -> [ 1, [ 2 ] ];
 * Throws an error if one of arguments is undefined. Even if error was thrown, elements that was prepended to( dstArray ) stays in the destination array.

 * @param { Array } dstArray - The destination array.
 * @param{ longIs | * } arguments[...] - Source arguments.
 *
 * @example
 * _.arrayPrependArraysOnce( [ 1, 2, 3, 4 ], [ 5 ], 5, [ 6 ], 6, 7, [ 7 ] );
 * // returns [ 5, 6, 7, 1, 2, 3, 4 ]
 *
 * @example
 * let dst = [ 1, 2, 3, 4 ];
 * _.arrayPrependArraysOnce( dst, [ 5 ], 5, [ 6 ], 6, undefined );
 * // throws error, but dst becomes equal [ 5, 6, 1, 2, 3, 4 ]
 *
 * @returns { Array } Returns updated array( dstArray ).
 * @function arrayPrependArraysOnce
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if one of ( arguments ) is undefined.
 * @memberof wTools
 */

function arrayPrependArraysOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayPrependedArraysOnce.apply( this, arguments );
  return dstArray;
}

//

/**
 * Method adds all unique elements from provided arrays to the beginning of an array( dstArray ) in same order
 * that they are in( arguments ).
 * Throws an error if one of arguments is undefined.
 * If argument provided after( dstArray ) is not a ArrayLike entity it will be prepended to destination array as usual element.
 * If argument is an ArrayLike entity and contains inner arrays, routine looks for elements only on first two levels.
 * Example: _.arrayPrependArraysOnce( [], [ [ 1 ], [ [ 2 ] ] ] ) -> [ 1, [ 2 ] ];
 * After copying checks if all elements( from first two levels ) was copied, if true returns updated array( dstArray ), otherwise throws an error.
 * Even if error was thrown, elements that was prepended to( dstArray ) stays in the destination array.

 * @param { Array } dstArray - The destination array.
 * @param { longIs | * } arguments[...] - Source arguments.
 * @param { wTools~compareCallback } onEqualize - A callback function that can be provided through routine`s context. By default, it checks the equality of two arguments.
 *
 * @example
 * _.arrayPrependArraysOnceStrictly( [ 1, 2, 3, 4 ], 5, [ 6, [ 7 ] ], 8 );
 * // returns [ 5, 6, 7, 8, 1, 2, 3, 4 ]
 *
 * @example
 * _.arrayPrependArraysOnceStrictly( [ 1, 2, 3, 4 ], [ 5 ], 5, [ 6 ], 6, 7, [ 7 ] );
 * // throws error
 *
 * @example
 * function onEqualize( a, b )
 * {
 *  return a === b;
 * };
 * let dst = [];
 * let arguments = [ dst, [ 1, [ 2 ], [ [ 3 ] ] ], 4 ];
 * _.arrayPrependArraysOnceStrictly.apply( { onEqualize }, arguments );
 * // returns [ 1, 2, [ 3 ], 4 ]
 *
 * @returns { Array } Returns updated array( dstArray ).
 * @function arrayPrependArraysOnceStrictly
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @throws { Error } An Error if one of ( arguments ) is undefined.
 * @throws { Error } An Error if count of added elements is not equal to count of elements from( arguments )( only first two levels inside of array are counted ).
 * @memberof wTools
 */

function arrayPrependArraysOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  let result;
  if( Config.debug )
  {
    result = arrayPrependedArraysOnce.apply( this, arguments );
    let expected = 0;
    for( let i = insArray.length - 1; i >= 0; i-- )
    {
      if( _.longIs( insArray[ i ] ) )
      expected += insArray[ i ].length;
      else
      expected += 1;
    }
    _.assert( result === expected, '{-dstArray-} should have none element from {-insArray-}' );
  }
  else
  {
    result = arrayPrependedArrays.apply( this, [ dstArray, insArray ] );
  }

  return dstArray;
}

/*
function arrayPrependArraysOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  let result = arrayPrependedArraysOnce.apply( this, arguments );
  let expected = 0;

  if( Config.debug )
  {

    for( let i = insArray.length - 1; i >= 0; i-- )
    {
      if( _.longIs( insArray[ i ] ) )
      expected += insArray[ i ].length;
      else
      expected += 1;
    }

    _.assert( result === expected, '{-dstArray-} should have none element from {-insArray-}' );

  }

  return dstArray;
}
*/

//

/**
 * Method adds all elements from provided arrays to the beginning of an array( dstArray ) in same order
 * that they are in( arguments ).
 * If argument provided after( dstArray ) is not a ArrayLike entity it will be prepended to destination array as usual element.
 * If argument is an ArrayLike entity and contains inner arrays, routine looks for elements only on first two levels.
 * Example: _.arrayPrependArrays( [], [ [ 1 ], [ [ 2 ] ] ] ) -> [ 1, [ 2 ] ];
 * Throws an error if one of arguments is undefined. Even if error was thrown, elements that was prepended to( dstArray ) stays in the destination array.
 *
 * @param { Array } dstArray - The destination array.
 * @param{ longIs | * } arguments[...] - Source arguments.
 *
 * @example
 * _.arrayPrependedArrays( [ 1, 2, 3, 4 ], [ 5 ], [ 6 ], 7 );
 * // returns 3
 *
 * @example
 * let dst = [ 1, 2, 3, 4 ];
 * _.arrayPrependedArrays( dst, [ 5 ], [ 6 ], undefined );
 * // throws error, but dst becomes equal [ 5, 6, 1, 2, 3, 4 ]
 *
 * @returns { Array } Returns count of added elements.
 * @function arrayPrependedArrays
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @memberof wTools
 */

function arrayPrependedArrays( dstArray, insArray )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.arrayIs( dstArray ), 'arrayPrependedArrays :', 'Expects array' );
  _.assert( _.longIs( insArray ), 'arrayPrependedArrays :', 'Expects longIs entity' );

  let result = 0;

  for( let a = insArray.length - 1 ; a >= 0 ; a-- )
  {
    if( _.longIs( insArray[ a ] ) )
    {
      dstArray.unshift.apply( dstArray, insArray[ a ] );
      result += insArray[ a ].length;
    }
    else
    {
      dstArray.unshift( insArray[ a ] );
      result += 1;
    }
  }

  return result;
}

//

/**
 * Method adds all unique elements from provided arrays to the beginning of an array( dstArray ) in same order
 * that they are in( arguments ).
 * If argument provided after( dstArray ) is not a ArrayLike entity it will be prepended to destination array as usual element.
 * If argument is an ArrayLike entity and contains inner arrays, routine looks for elements only on first two levels.
 * Example: _.arrayPrependArrays( [], [ [ 1 ], [ [ 2 ] ] ] ) -> [ 1, [ 2 ] ];
 * Throws an error if one of arguments is undefined. Even if error was thrown, elements that was prepended to( dstArray ) stays in the destination array.
 *
 * @param { Array } dstArray - The destination array.
 * @param{ longIs | * } arguments[...] - Source arguments.
 *
 * @example
 * _.arrayPrependedArraysOnce( [ 1, 2, 3, 4, 5, 6, 7 ], [ 5 ], [ 6 ], 7 );
 * // returns 0
 *
 * @example
 * _.arrayPrependedArraysOnce( [ 1, 2, 3, 4 ], [ 5 ], 5, [ 6 ], 6, 7, [ 7 ] );
 * // returns 3
 *
 * @example
 * let dst = [ 1, 2, 3, 4 ];
 * _.arrayPrependedArraysOnce( dst, [ 5 ], [ 6 ], undefined );
 * // throws error, but dst becomes equal [ 5, 6, 1, 2, 3, 4 ]
 *
 * @returns { Array } Returns count of added elements.
 * @function arrayPrependedArraysOnce
 * @throws { Error } An Error if ( dstArray ) is not an Array.
 * @memberof wTools
 */

function arrayPrependedArraysOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  _.assert( 2 <= arguments.length && arguments.length <= 4 );
  _.assert( _.arrayIs( dstArray ), 'arrayPrependedArraysOnce :', 'Expects array' );
  _.assert( _.longIs( insArray ), 'arrayPrependedArraysOnce :', 'Expects longIs entity' );

  let result = 0;

  function _prependOnce( element )
  {
    let index = _.arrayLeftIndex( dstArray, element, evaluator1, evaluator2 );
    if( index === -1 )
    {
      // dstArray.unshift( argument );
      dstArray.splice( result, 0, element );
      result += 1;
    }
  }

  // for( let ii = insArray.length - 1; ii >= 0; ii-- )
  for( let ii = 0 ; ii < insArray.length ; ii++ )
  {
    if( _.longIs( insArray[ ii ] ) )
    {
      let array = insArray[ ii ];
      // for( let a = array.length - 1; a >= 0; a-- )
      for( let a = 0 ; a < array.length ; a++ )
      _prependOnce( array[ a ] );
    }
    else
    {
      _prependOnce( insArray[ ii ] );
    }
  }

  return result;
}

//

function arrayPrependedArraysOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
 let result;
 if( Config.debug )
 {
   result = arrayPrependedArraysOnce.apply( this, arguments );
   let expected = 0;
   for( let i = insArray.length - 1; i >= 0; i-- )
   {
     if( _.longIs( insArray[ i ] ) )
     expected += insArray[ i ].length;
     else
     expected += 1;
   }
   _.assert( result === expected, '{-dstArray-} should have none element from {-insArray-}' );
 }
 else
 {
   result = arrayPrependedArrays.apply( this, [ dstArray, insArray ] );
 }

 return result;
}

// --
// array append
// --

// function arrayAppend_( dstArray )
// {
//   _.assert( arguments.length >= 1 );
//   _.assert( _.arrayIs( dstArray ) || dstArray === null, 'Expects array' );
//
//   dstArray = dstArray || [];
//
//   for( let a = 1, len = arguments.length ; a < len; a++ )
//   {
//     if( _.longIs( arguments[ a ] ) )
//     {
//       dstArray.push.apply( dstArray, arguments[ a ] );
//     }
//     else
//     {
//       dstArray.push( arguments[ a ] );
//     }
//   }
//
//   return dstArray;
// }

//

function arrayAppend( dstArray, ins )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayAppended.apply( this, arguments );
  return dstArray;
}

//

/**
 * The arrayAppendOnce() routine adds at the end of an array (dst) a value {-srcMap-},
 * if the array (dst) doesn't have the value {-srcMap-}.
 *
 * @param { Array } dst - The source array.
 * @param { * } src - The value to add.
 *
 * @example
 * _.arrayAppendOnce( [ 1, 2, 3, 4 ], 5 );
 * // returns [ 1, 2, 3, 4, 5 ]
 *
 * @example
 * _.arrayAppendOnce( [ 1, 2, 3, 4, 5 ], 5 );
 * // returns [ 1, 2, 3, 4, 5 ]
 *
 * @example
 * _.arrayAppendOnce( [ 'Petre', 'Mikle', 'Oleg' ], 'Dmitry' );
 * // returns [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ]
 *
 * @example
 * _.arrayAppendOnce( [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ], 'Dmitry' );
 * // returns [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ]
 *
 * @returns { Array } If an array (dst) doesn't have a value {-srcMap-} it returns the updated array (dst) with the new length,
 * otherwise, it returns the original array (dst).
 * @function arrayAppendOnce
 * @throws { Error } Will throw an Error if (dst) is not an Array.
 * @throws { Error } Will throw an Error if (arguments.length) is less or more than two.
 * @memberof wTools
 */

function arrayAppendOnce( dstArray, ins, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayAppendedOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayAppendOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  let result;
  if( Config.debug )
  {
    result = arrayAppendedOnce.apply( this, arguments );
    _.assert( result >= 0, () => 'Array should have only unique elements, but has several ' + _.strShort( ins ) );
  }
  else
  {
    result = arrayAppended.apply( this, [ dstArray, ins ] );
  }
  return dstArray;
}

//

function arrayAppended( dstArray, ins )
{
  _.assert( arguments.length === 2  );
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );
  dstArray.push( ins );
  return dstArray.length - 1;
}

//

function arrayAppendedOnce( dstArray, ins, evaluator1, evaluator2 )
{
  let i = _.arrayLeftIndex.apply( _, arguments );

  if( i === -1 )
  {
    dstArray.push( ins );
    return dstArray.length - 1;
  }

  return -1;
}

//

function arrayAppendedOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{
  let result;
  if( Config.debug )
  {
    result = arrayAppendedOnce.apply( this, arguments );
    _.assert( result >= 0, () => 'Array should have only unique elements, but has several ' + _.strShort( ins ) );
  }
  else
  {
    result = arrayAppended.apply( this, [ dstArray, ins ] );
  }
  return result;
}


//

function arrayAppendElement( dstArray, ins )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayAppendedElement.apply( this, arguments );
  return dstArray;
}

//

function arrayAppendElementOnce( dstArray, ins )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayAppendedElementOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayAppendElementOnceStrictly( dstArray, ins )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  let result;
  if( Config.debug )
  {
    result = arrayAppendedElementOnce.apply( this, arguments );
    _.assert( result !== false, 'Array should have only unique elements, but has several', ins );
  }
  else
  {
    result = arrayAppendedElement.apply( this, [ dstArray, ins ] );
  }
  return dstArray;
}

//

function arrayAppendedElement( dstArray, ins )
{
  _.assert( arguments.length === 2  );
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );
  dstArray.push( ins );
  return dstArray.length - 1;
}

//

function arrayAppendedElementOnce( dstArray, ins )
{
  let i = _.arrayLeftIndex.apply( _, arguments );

  if( i === -1 )
  {
    dstArray.push( ins );
    return dstArray[ dstArray.length - 1 ];
  }

  return false;
  // return -1;
}

//

function arrayAppendedElementOnceStrictly( dstArray, ins )
{
  let result;
  if( Config.debug )
  {
    result = arrayAppendedElementOnce.apply( this, arguments );
    _.assert( result !== false, 'Array should have only unique elements, but has several', ins );
  }
  else
  {
    result = arrayAppendedElement.apply( this, [ dstArray, ins ] );
  }
  return result;
}

//

/**
* The arrayAppendArray() routine adds one or more elements to the end of the (dst) array
* and returns the new length of the array.
*
* It creates two variables the (result) - array and the (argument) - elements of array-like object (arguments[]),
* iterate over array-like object (arguments[]) and assigns to the (argument) each element,
* checks, if (argument) is equal to the 'undefined'.
* If true, it throws an Error.
* If (argument) is an array-like.
* If true, it merges the (argument) into the (result) array.
* Otherwise, it adds element to the result.
*
* @param { Array } dst - Initial array.
* @param {*} arguments[] - One or more argument(s) to add to the end of the (dst) array.
*
* @example
* _.arrayAppendArray( [ 1, 2 ], 'str', false, { a : 1 }, 42, [ 3, 7, 13 ] );
* // returns [ 1, 2, 'str', false, { a : 1 }, 42, 3, 7, 13 ];
*
* @returns { Array } - Returns an array (dst) with all of the following argument(s) that were added to the end of the (dst) array.
* @function arrayAppendArray
* @throws { Error } If the first argument is not an array.
* @throws { Error } If type of the argument is equal undefined.
* @memberof wTools
*/

function arrayAppendArray( dstArray, insArray )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayAppendedArray.apply( this, arguments );
  return dstArray;
}

//

/**
 * The arrayAppendArrayOnce() routine returns an array of elements from (dst)
 * and appending only unique following arguments to the end.
 *
 * It creates two variables the (result) - array and the (argument) - elements of array-like object (arguments[]),
 * iterate over array-like object (arguments[]) and assigns to the (argument) each element,
 * checks, if (argument) is equal to the 'undefined'.
 * If true, it throws an Error.
 * if (argument) is an array-like.
 * If true, it iterate over array (argument) and checks if (result) has the same values as the (argument).
 * If false, it adds elements of (argument) to the end of the (result) array.
 * Otherwise, it checks if (result) has not the same values as the (argument).
 * If true, it adds elements to the end of the (result) array.
 *
 * @param { Array } dst - Initial array.
 * @param {*} arguments[] - One or more argument(s).
 *
 * @example
 * _.arrayAppendArrayOnce( [ 1, 2 ], 'str', 2, {}, [ 'str', 5 ] );
 * // returns [ 1, 2, 'str', {}, 5 ]
 *
 * @returns { Array } - Returns an array (dst) with only unique following argument(s) that were added to the end of the (dst) array.
 * @function arrayAppendArrayOnce
 * @throws { Error } If the first argument is not array.
 * @throws { Error } If type of the argument is equal undefined.
 * @memberof wTools
 */

function arrayAppendArrayOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayAppendedArrayOnce.apply( this, arguments )
  return dstArray;
}

//

function arrayAppendArrayOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  let result;
  if( Config.debug )
  {
    result = arrayAppendedArrayOnce.apply( this, arguments )
    _.assert( result === insArray.length );
  }
  else
  {
    result = arrayAppendedArray.apply( this, [ dstArray, insArray ] )
  }
  return dstArray;
}

/*
function arrayAppendArrayOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  let result = arrayAppendedArrayOnce.apply( this, arguments )
  _.assert( result === insArray.length );
  return dstArray;
}
*/

//

function arrayAppendedArray( dstArray, insArray )
{
  _.assert( arguments.length === 2 )
  _.assert( _.arrayIs( dstArray ), 'arrayPrependedArray :', 'Expects array' );
  _.assert( _.longIs( insArray ), 'arrayPrependedArray :', 'Expects longIs' );

  dstArray.push.apply( dstArray, insArray );
  return insArray.length;
}

//

function arrayAppendedArrayOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  _.assert( _.longIs( insArray ) );
  _.assert( dstArray !== insArray );
  _.assert( 2 <= arguments.length && arguments.length <= 4 );

  let result = 0;

  for( let i = 0 ; i < insArray.length ; i++ )
  {
    if( _.arrayLeftIndex( dstArray, insArray[ i ], evaluator1, evaluator2 ) === -1 )
    {
      dstArray.push( insArray[ i ] );
      result += 1;
    }
  }

  return result;
}

//

function arrayAppendedArrayOnceStrictly( dstArray, ins )
{
  let result;
  if( Config.debug )
  {
    result = arrayAppendedArrayOnce.apply( this, arguments );
    _.assert( result === ins.length , 'Array should have only unique elements, but has several', ins );
  }
  else
  {
    result = arrayAppendedElement.apply( this, [ dstArray, ins ] );
  }
  return result;
}

//

function arrayAppendArrays( dstArray, insArray )
{

  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  if( dstArray === undefined )
  {
    _.assert( arguments.length === 2 );
    return insArray;
  }

  _.arrayAppendedArrays.apply( this, arguments );

  return dstArray;
}

//

function arrayAppendArraysOnce( dstArray, insArray, evaluator1, evaluator2 )
{

  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }
  else if( dstArray === undefined )
  {
    if( _.arrayIs( insArray ) )
    {
      dstArray = [];
      arguments[ 0 ] = dstArray;
    }
    else
    {
      _.assert( 2 <= arguments.length && arguments.length <= 4 );
      return insArray;
    }
  }

  arrayAppendedArraysOnce.apply( this, arguments );

  return dstArray;
}

//

function arrayAppendArraysOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  let result;
  if( Config.debug )
  {

    result = arrayAppendedArraysOnce.apply( this, arguments );

    let expected = 0;
    for( let i = insArray.length - 1; i >= 0; i-- )
    {
      if( _.longIs( insArray[ i ] ) )
      expected += insArray[ i ].length;
      else
      expected += 1;
    }
    _.assert( result === expected, '{-dstArray-} should have none element from {-insArray-}' );
  }
  else
  {
    result = arrayAppendedArrays.apply( this, [ dstArray, insArray ] );
  }

  return dstArray;
}

//

function arrayAppendedArrays( dstArray, insArray )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( !_.longIs( insArray ) && insArray !== undefined )
  insArray = [ insArray ];

  // if( !_.longIs( insArray ) )
  // {
  //   if( !_.arrayIs( dstArray ) )
  //   return [ dstArray, insArray ];
  //   else
  //   dstArray.push( insArray );
  //   return 1;
  // }

  // if( !_.arrayIs( insArray ) && insArray !== undefined )
  // insArray = [ insArray ];
  // if( !_.arrayIs( insArray ) && insArray !== undefined )
  // insArray = [ insArray ];

  _.assert( _.arrayIs( dstArray ), 'Expects array' );
  _.assert( _.longIs( insArray ), 'Expects longIs entity' );

  let result = 0;

  for( let a = 0, len = insArray.length; a < len; a++ )
  {
    if( _.longIs( insArray[ a ] ) )
    {
      dstArray.push.apply( dstArray, insArray[ a ] );
      result += insArray[ a ].length;
    }
    else
    {
      dstArray.push( insArray[ a ] );
      result += 1;
    }
  }

  return result;
}

//

function arrayAppendedArraysOnce( dstArray, insArray, evaluator1, evaluator2 )
{

  _.assert( 2 <= arguments.length && arguments.length <= 4 );

  if( dstArray === undefined )
  return insArray;

  if( !_.arrayIs( insArray ) && insArray !== undefined )
  insArray = [ insArray ];

  _.assert( _.arrayIs( dstArray ), 'Expects array' );
  _.assert( _.longIs( insArray ), 'Expects longIs entity' );

  let result = 0;

  for( let a = 0, len = insArray.length; a < len; a++ )
  {
    if( _.longIs( insArray[ a ] ) )
    {
      let array = insArray[ a ];
      for( let i = 0, alen = array.length; i < alen; i++ )
      _appendOnce( array[ i ] );
    }
    else
    {
      _appendOnce( insArray[ a ] );
    }
  }

  return result;

  function _appendOnce( argument )
  {
    let index = _.arrayLeftIndex( dstArray, argument, evaluator1, evaluator2 );
    if( index === -1 )
    {
      dstArray.push( argument );
      result += 1;
    }
  }

}

//

function arrayAppendedArraysOnceStrictly( dstArray, ins )
{
  let result;
  if( Config.debug )
  {
    result = arrayAppendedArraysOnce.apply( this, arguments );
    let expected = 0;
    for( let i = ins.length - 1; i >= 0; i-- )
    {
      if( _.longIs( ins[ i ] ) )
      expected += ins[ i ].length;
      else
      expected += 1;
    }
    _.assert( result === expected, '{-dstArray-} should have none element from {-insArray-}' );
  }
  else
  {
    result = arrayAppendedArrays.apply( this, [ dstArray, ins ] );
  }

  return result;
}

// --
// array remove
// --

/**
 * ArrayRemove, arrayRemoveOnce, arrayRemoveOnceStrictly and arrayRemoved behave just like
 * arrayRemoveElement, arrayRemoveElementOnce, arrayRemoveElementOnceStrictly and arrayRemovedElement.
 */

function arrayRemove( dstArray, ins, evaluator1, evaluator2 )
{
  arrayRemoved.apply( this, arguments );
  return dstArray;
}

//

function arrayRemoveOnce( dstArray, ins, evaluator1, evaluator2 )
{
  arrayRemovedOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayRemoveOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{
  arrayRemoveElementOnceStrictly.apply( this, arguments );
  return dstArray;
}

//

function arrayRemoved( dstArray, ins, evaluator1, evaluator2 )
{
  let removedElements = arrayRemovedElement.apply( this, arguments );
  return removedElements;
}

//

/**
 * ArrayRemovedOnce and arrayRemovedOnceStrictly behave just like arrayRemovedElementOnce and arrayRemovedElementOnceStrictly,
 * but return the index of the removed element, instead of the removed element
 */

function arrayRemovedOnce( dstArray, ins, evaluator1, evaluator2 )
{
  let index = _.arrayLeftIndex.apply( _, arguments );
  if( index >= 0 )
  dstArray.splice( index, 1 );

  return index;
}

//

function arrayRemovedOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{
  let index = _.arrayLeftIndex.apply( _, arguments );
  if( index >= 0 )
  {
    dstArray.splice( index, 1 );
  }
  else _.assert( 0, () => 'Array does not have element ' + _.toStrShort( ins ) );

  let newIndex = _.arrayLeftIndex.apply( _, arguments );
  _.assert( newIndex < 0, () => 'The element ' + _.toStrShort( ins ) + ' is several times in dstArray' );

  return index;
}

//

function arrayRemoveElement( dstArray, ins, evaluator1, evaluator2 )
{
  arrayRemovedElement.apply( this, arguments );
  return dstArray;
}

//

/**
 * The arrayRemoveElementOnce() routine removes the first matching element from (dstArray)
 * that corresponds to the condition in the callback function and returns a modified array.
 *
 * It takes two (dstArray, ins) or three (dstArray, ins, onEvaluate) arguments,
 * checks if arguments passed two, it calls the routine
 * [arrayRemovedElementOnce( dstArray, ins )]{@link wTools.arrayRemovedElementOnce}
 * Otherwise, if passed three arguments, it calls the routine
 * [arrayRemovedElementOnce( dstArray, ins, onEvaluate )]{@link wTools.arrayRemovedElementOnce}
 * @see  wTools.arrayRemovedElementOnce
 * @param { Array } dstArray - The source array.
 * @param { * } ins - The value to remove.
 * @param { wTools~compareCallback } [ onEvaluate ] - The callback that compares (ins) with elements of the array.
 * By default, it checks the equality of two arguments.
 *
 * @example
 * _.arrayRemoveElementOnce( [ 1, 'str', 2, 3, 'str' ], 'str' );
 * // returns [ 1, 2, 3, 'str' ]
 *
 * @example
 * _.arrayRemoveElementOnce( [ 3, 7, 33, 13, 33 ], 13, function( el, ins ) {
 *   return el > ins;
 * });
 * // returns [ 3, 7, 13, 33 ]
 *
 * @returns { Array } - Returns the modified (dstArray) array with the new length.
 * @function arrayRemoveElementOnce
 * @throws { Error } If the first argument is not an array.
 * @throws { Error } If passed less than two or more than three arguments.
 * @throws { Error } If the third argument is not a function.
 * @memberof wTools
 */

function arrayRemoveElementOnce( dstArray, ins, evaluator1, evaluator2 )
{
  arrayRemovedElementOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayRemoveElementOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{
  let result;
  if( Config.debug )
  {
    let result = arrayRemovedElementOnce.apply( this, arguments );
    let index = _.arrayLeftIndex.apply( _, arguments );
    _.assert( index < 0 );
    _.assert( result >= 0, () => 'Array does not have element ' + _.toStrShort( ins ) );
  }
  else
  {
    let result = arrayRemovedElement.apply( this, [ dstArray, ins ] );
  }
  return dstArray;
}

/*
function arrayRemoveElementOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{
  let result = arrayRemovedElementOnce.apply( this, arguments );
  _.assert( result >= 0, () => 'Array does not have element ' + _.toStrShort( ins ) );
  return dstArray;
}
*/

//

function arrayRemovedElement( dstArray, ins, evaluator1, evaluator2 )
{
  let index = _.arrayLeftIndex.apply( this, arguments );
  let removedElements = 0;

  for( let i = 0; i < dstArray.length; i++ )
  {
    if( index !== -1 )
    {
      dstArray.splice( index, 1 );
      removedElements = removedElements + 1;
      i = i - 1 ;
    }
    index = _.arrayLeftIndex.apply( this, arguments );
  }

  return removedElements;
}

//

/**
 * The callback function to compare two values.
 *
 * @callback wTools~compareCallback
 * @param { * } el - The element of the array.
 * @param { * } ins - The value to compare.
 */

/**
 * The arrayRemovedElementOnce() routine returns the index of the first matching element from (dstArray)
 * that corresponds to the condition in the callback function and remove this element.
 *
 * It takes two (dstArray, ins) or three (dstArray, ins, onEvaluate) arguments,
 * checks if arguments passed two, it calls built in function(dstArray.indexOf(ins))
 * that looking for the value of the (ins) in the (dstArray).
 * If true, it removes the value (ins) from (dstArray) array by corresponding index.
 * Otherwise, if passed three arguments, it calls the routine
 * [arrayLeftIndex( dstArray, ins, onEvaluate )]{@link wTools.arrayLeftIndex}
 * If callback function(onEvaluate) returns true, it returns the index that will be removed from (dstArray).
 * @see {@link wTools.arrayLeftIndex} - See for more information.
 *
 * @param { Array } dstArray - The source array.
 * @param { * } ins - The value to remove.
 * @param { wTools~compareCallback } [ onEvaluate ] - The callback that compares (ins) with elements of the array.
 * By default, it checks the equality of two arguments.
 *
 * @example
 * _.arrayRemovedElementOnce( [ 2, 4, 6 ], 4, function( el ) {
 *   return el;
 * });
 * // returns 1
 *
 * @example
 * _.arrayRemovedElementOnce( [ 2, 4, 6 ], 2 );
 * // returns 0
 *
 * @returns { Number } - Returns the index of the value (ins) that was removed from (dstArray).
 * @function arrayRemovedElementOnce
 * @throws { Error } If the first argument is not an array-like.
 * @throws { Error } If passed less than two or more than three arguments.
 * @throws { Error } If the third argument is not a function.
 * @memberof wTools
 */

function arrayRemovedElementOnce( dstArray, ins, evaluator1, evaluator2 )
{

  let index = _.arrayLeftIndex.apply( _, arguments );
  if( index >= 0 )
  dstArray.splice( index, 1 );

  return index;
  /* "!!! : breaking" */
  /* // arrayRemovedElementOnce should return the removed element
  let result;
  let index = _.arrayLeftIndex.apply( _, arguments );

  if( index >= 0 )
  {
    result = dstArray[ index ];
    dstArray.splice( index, 1 );
  }

  return result;
  */
}

//

function arrayRemovedElementOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{

  let result;
  let index = _.arrayLeftIndex.apply( _, arguments );
  if( index >= 0 )
  {
    result = dstArray[ index ];
    dstArray.splice( index, 1 );
  }
  else _.assert( 0, () => 'Array does not have element ' + _.toStrShort( ins ) );

  index = _.arrayLeftIndex.apply( _, arguments );
  _.assert( index < 0, () => 'The element ' + _.toStrShort( ins ) + ' is several times in dstArray' );

  return result;
}

/*
function arrayRemovedElementOnceStrictly( dstArray, ins, evaluator1, evaluator2 )
{

  let result;
  let index = _.arrayLeftIndex.apply( _, arguments );
  if( index >= 0 )
  {
    result = dstArray[ index ];
    dstArray.splice( index, 1 );
  }
  else _.assert( 0, () => 'Array does not have element ' + _.toStrShort( ins ) );

  return result;
}
*/

//

function arrayRemoveArray( dstArray, insArray )
{
  arrayRemovedArray.apply( this, arguments );
  return dstArray;
}

//

function arrayRemoveArrayOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  arrayRemovedArrayOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayRemoveArrayOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  let result;
  if( Config.debug )
  {
    result = arrayRemovedArrayOnce.apply( this, arguments );
    let index = - 1;
    for( let i = 0, len = insArray.length; i < len ; i++ )
    {
      index = dstArray.indexOf( insArray[ i ] );
      _.assert( index < 0 );
    }
    _.assert( result === insArray.length );

  }
  else
  {
    result = arrayRemovedArray.apply( this, [ dstArray, insArray ] );
  }
  return dstArray;
}

/*
function arrayRemoveArrayOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  let result = arrayRemovedArrayOnce.apply( this, arguments );
  _.assert( result === insArray.length );
  return dstArray;
}
*/

//

function arrayRemovedArray( dstArray, insArray )
{
  _.assert( arguments.length === 2 )
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );
  _.assert( _.longIs( insArray ) );
  _.assert( dstArray !== insArray );

  let result = 0;
  let index = -1;

  for( let i = 0, len = insArray.length; i < len ; i++ )
  {
    index = dstArray.indexOf( insArray[ i ] );
    while( index !== -1 )
    {
      dstArray.splice( index, 1 );
      result += 1;
      index = dstArray.indexOf( insArray[ i ], index );
    }
  }

  return result;
}

//

/**
 * The callback function to compare two values.
 *
 * @callback arrayRemovedArrayOnce~onEvaluate
 * @param { * } el - The element of the (dstArray[n]) array.
 * @param { * } ins - The value to compare (insArray[n]).
 */

/**
 * The arrayRemovedArrayOnce() determines whether a (dstArray) array has the same values as in a (insArray) array,
 * and returns amount of the deleted elements from the (dstArray).
 *
 * It takes two (dstArray, insArray) or three (dstArray, insArray, onEqualize) arguments, creates variable (let result = 0),
 * checks if (arguments[..]) passed two, it iterates over the (insArray) array and calls for each element built in function(dstArray.indexOf(insArray[i])).
 * that looking for the value of the (insArray[i]) array in the (dstArray) array.
 * If true, it removes the value (insArray[i]) from (dstArray) array by corresponding index,
 * and incrementing the variable (result++).
 * Otherwise, if passed three (arguments[...]), it iterates over the (insArray) and calls for each element the routine
 *
 * If callback function(onEqualize) returns true, it returns the index that will be removed from (dstArray),
 * and then incrementing the variable (result++).
 *
 * @see wTools.arrayLeftIndex
 *
 * @param { longIs } dstArray - The target array.
 * @param { longIs } insArray - The source array.
 * @param { function } onEqualize - The callback function. By default, it checks the equality of two arguments.
 *
 * @example
 * _.arrayRemovedArrayOnce( [  ], [  ] );
 * // returns 0
 *
 * @example
 * _.arrayRemovedArrayOnce( [ 1, 2, 3, 4, 5 ], [ 6, 2, 7, 5, 8 ] );
 * // returns 2
 *
 * @example
 * _.arrayRemovedArrayOnce( [ 1, 2, 3, 4, 5 ], [ 6, 2, 7, 5, 8 ], function( a, b ) {
 *   return a < b;
 * } );
 * // returns 4
 *
 * @returns { number }  Returns amount of the deleted elements from the (dstArray).
 * @function arrayRemovedArrayOnce
 * @throws { Error } Will throw an Error if (dstArray) is not an array-like.
 * @throws { Error } Will throw an Error if (insArray) is not an array-like.
 * @throws { Error } Will throw an Error if (arguments.length < 2  || arguments.length > 3).
 * @memberof wTools
 */

function arrayRemovedArrayOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );
  _.assert( _.longIs( insArray ) );
  _.assert( dstArray !== insArray );
  _.assert( 2 <= arguments.length && arguments.length <= 4 );

  let result = 0;
  let index = -1;

  for( let i = 0, len = insArray.length; i < len ; i++ )
  {
    index = _.arrayLeftIndex( dstArray, insArray[ i ], evaluator1, evaluator2 );

    if( index >= 0 )
    {
      dstArray.splice( index, 1 );
      result += 1;
    }
  }

  return result;
}

//

function arrayRemovedArrayOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  let result;
  if( Config.debug )
  {
    result = arrayRemovedArrayOnce.apply( this, arguments );
    let index = - 1;
    for( let i = 0, len = insArray.length; i < len ; i++ )
    {
      index = dstArray.indexOf( insArray[ i ] );
      _.assert( index < 0 );
    }
    _.assert( result === insArray.length );

  }
  else
  {
    result = arrayRemovedArray.apply( this, [ dstArray, insArray ] );
  }
  return result;
}

//

function arrayRemoveArrays( dstArray, insArray )
{
  arrayRemovedArrays.apply( this, arguments );
  return dstArray;
}

//

function arrayRemoveArraysOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  arrayRemovedArraysOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayRemoveArraysOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  let result;
  if( Config.debug )
  {
    result = arrayRemovedArraysOnce.apply( this, arguments );

    let expected = 0;
    for( let i = insArray.length - 1; i >= 0; i-- )
    {
      if( _.longIs( insArray[ i ] ) )
      expected += insArray[ i ].length;
      else
      expected += 1;
    }

    _.assert( result === expected );
    _.assert( arrayRemovedArraysOnce.apply( this, arguments ) === 0 );
  }
  else
  {
    result = arrayRemovedArrays.apply( this, [ dstArray, insArray ] );
  }

  return dstArray;
}

/*
function arrayRemoveArraysOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  let result = arrayRemovedArraysOnce.apply( this, arguments );

  let expected = 0;
  for( let i = insArray.length - 1; i >= 0; i-- )
  {
    if( _.longIs( insArray[ i ] ) )
    expected += insArray[ i ].length;
    else
    expected += 1;
  }

  _.assert( result === expected );

  return dstArray;
}
*/

//

function arrayRemovedArrays( dstArray, insArray )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.arrayIs( dstArray ), 'arrayRemovedArrays :', 'Expects array' );
  _.assert( _.longIs( insArray ), 'arrayRemovedArrays :', 'Expects longIs entity' );

  let result = 0;

  function _remove( argument )
  {
    let index = dstArray.indexOf( argument );
    while( index !== -1 )
    {
      dstArray.splice( index, 1 );
      result += 1;
      index = dstArray.indexOf( argument, index );
    }
  }

  for( let a = insArray.length - 1; a >= 0; a-- )
  {
    if( _.longIs( insArray[ a ] ) )
    {
      let array = insArray[ a ];
      for( let i = array.length - 1; i >= 0; i-- )
      _remove( array[ i ] );
    }
    else
    {
      _remove( insArray[ a ] );
    }
  }

  return result;
}

//

function arrayRemovedArraysOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  _.assert( 2 <= arguments.length && arguments.length <= 4 );
  _.assert( _.arrayIs( dstArray ), 'arrayRemovedArraysOnce :', 'Expects array' );
  _.assert( _.longIs( insArray ), 'arrayRemovedArraysOnce :', 'Expects longIs entity' );

  let result = 0;

  function _removeOnce( argument )
  {
    let index = _.arrayLeftIndex( dstArray, argument, evaluator1, evaluator2 );
    if( index >= 0 )
    {
      dstArray.splice( index, 1 );
      result += 1;
    }
  }

  for( let a = insArray.length - 1; a >= 0; a-- )
  {
    if( _.longIs( insArray[ a ] ) )
    {
      let array = insArray[ a ];
      for( let i = array.length - 1; i >= 0; i-- )
      _removeOnce( array[ i ] );
    }
    else
    {
      _removeOnce( insArray[ a ] );
    }
  }

  return result;
}

//

function arrayRemovedArraysOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  let result;
  if( Config.debug )
  {
    result = arrayRemovedArraysOnce.apply( this, arguments );

    let expected = 0;
    for( let i = insArray.length - 1; i >= 0; i-- )
    {
      if( _.longIs( insArray[ i ] ) )
      expected += insArray[ i ].length;
      else
      expected += 1;
    }

    _.assert( result === expected );
    _.assert( arrayRemovedArraysOnce.apply( this, arguments ) === 0 );
  }
  else
  {
    result = arrayRemovedArrays.apply( this, [ dstArray, insArray ] );
  }

  return result;
}

//

/**
 * The arrayRemoveDuplicates( dstArray, evaluator ) routine returns the dstArray with the duplicated elements removed.
 *
 * @param { ArrayIs } dstArray - The source and destination array.
 * @param { Function } [ evaluator = function( e ) { return e } ] - A callback function.
 *
 * @example
 * _.arrayRemoveDuplicates( [ 1, 1, 2, 'abc', 'abc', 4, true, true ] );
 * // returns [ 1, 2, 'abc', 4, true ]
 *
 * @example
 * _.arrayRemoveDuplicates( [ 1, 2, 3, 4, 5 ] );
 * // returns [ 1, 2, 3, 4, 5 ]
 *
 * @returns { Number } - Returns the source array without the duplicated elements.
 * @function arrayRemoveDuplicates
 * @throws { Error } If passed arguments is less than one or more than two.
 * @throws { Error } If the first argument is not an array.
 * @throws { Error } If the second argument is not a Function.
 * @memberof wTools
 */

function arrayRemoveDuplicates( dstArray, evaluator )
{
  _.assert( 1 <= arguments.length || arguments.length <= 2 );
  _.assert( _.arrayIs( dstArray ), 'Expects Array' );

  for( let i = 0 ; i < dstArray.length ; i++ )
  {
    let index;
    do
    {
      index = _.arrayRightIndex( dstArray, dstArray[ i ], evaluator );
      if( index !== i )
      {
        dstArray.splice( index, 1 );
      }
    }
    while( index !== i );
  }

  return dstArray;
}

/*
/*
function arrayRemoveDuplicates( dstArray, evaluator )
{
  _.assert( 1 <= arguments.length || arguments.length <= 2 );
  _.assert( _.arrayIs( dstArray ), 'arrayRemoveDuplicates :', 'Expects Array' );

  for( let i1 = 0 ; i1 < dstArray.length ; i1++ )
  {
    let element1 = dstArray[ i1 ];
    let index = _.arrayRightIndex( dstArray, element1, evaluator );

    while ( index !== i1 )
    {
      dstArray.splice( index, 1 );
      index = _.arrayRightIndex( dstArray, element1, evaluator );
    }
  }

  return dstArray;
}
*/

// --
// array flatten
// --

/**
 * The arrayFlatten() routine returns an array that contains all the passed arguments.
 *
 * It creates two variables the (result) - array and the {-srcMap-} - elements of array-like object (arguments[]),
 * iterate over array-like object (arguments[]) and assigns to the {-srcMap-} each element,
 * checks if {-srcMap-} is not equal to the 'undefined'.
 * If true, it adds element to the result.
 * If {-srcMap-} is an Array and if element(s) of the {-srcMap-} is not equal to the 'undefined'.
 * If true, it adds to the (result) each element of the {-srcMap-} array.
 * Otherwise, if {-srcMap-} is an Array and if element(s) of the {-srcMap-} is equal to the 'undefined' it throws an Error.
 *
 * @param {...*} arguments - One or more argument(s).
 *
 * @example
 * _.arrayFlatten( 'str', {}, [ 1, 2 ], 5, true );
 * // returns [ 'str', {}, 1, 2, 5, true ]
 *
 * @returns { Array } - Returns an array of the passed argument(s).
 * @function arrayFlatten
 * @throws { Error } If (arguments[...]) is an Array and has an 'undefined' element.
 * @memberof wTools
 */

function arrayFlatten( dstArray, insArray )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayFlattened.apply( this, arguments );

  return dstArray;
}

//

function arrayFlattenOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayFlattenedOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayFlattenOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  arrayFlattenedOnceStrictly.apply( this, arguments );
  return dstArray;
}

//

function arrayFlattened( dstArray, insArray )
{

  _.assert( arguments.length >= 1 );
  _.assert( _.objectIs( this ) );
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );

  if( arguments.length === 1 )
  {
    for( let i = dstArray.length-1; i >= 0; --i )
    if( _.longIs( dstArray[ i ] ) )
    {
      let insArray = dstArray[ i ];
      dstArray.splice( i, 1 );
      onLong( insArray, i );
    }
    return dstArray;
  }

  let result = 0;

  for( let a = 1 ; a < arguments.length ; a++ )
  {
    let insArray = arguments[ a ];

    if( _.longIs( insArray ) )
    {
      for( let i = 0, len = insArray.length; i < len; i++ )
      {
        if( _.longIs( insArray[ i ] ) )
        {
          let c = _.arrayFlattened( dstArray, insArray[ i ] );
          result += c;
        }
        else
        {
          _.assert( insArray[ i ] !== undefined, 'The Array should have no undefined' );
          dstArray.push( insArray[ i ] );
          result += 1;
        }
      }
    }
    else
    {
      _.assert( insArray !== undefined, 'The Array should have no undefined' );
      dstArray.push( insArray );
      result += 1;
    }

  }

  return result;

  /* */

  function onLong( insArray, insIndex )
  {
    for( let i = 0, len = insArray.length; i < len; i++ )
    {
      if( _.longIs( insArray[ i ] ) )
      onLong( insArray[ i ], insIndex )
      else
      dstArray.splice( insIndex++, 0, insArray[ i ] );
    }
  }

}

//

function arrayFlattenedOnce( dstArray, insArray, evaluator1, evaluator2 )
{

  _.assert( arguments.length && arguments.length <= 4 );
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );

  if( arguments.length === 1 )
  {
    _.arrayRemoveDuplicates( dstArray );

    for( let i = dstArray.length-1; i >= 0; --i )
    if( _.longIs( dstArray[ i ] ) )
    {
      let insArray = dstArray[ i ];
      dstArray.splice( i, 1 );
      onLongOnce( insArray, i );
    }
    return dstArray;
  }

  let result = 0;

  if( _.longIs( insArray ) )
  {
    for( let i = 0, len = insArray.length; i < len; i++ )
    {
      _.assert( insArray[ i ] !== undefined, 'The Array should have no undefined' );
      if( _.longIs( insArray[ i ] ) )
      {
        let c = _.arrayFlattenedOnce( dstArray, insArray[ i ], evaluator1, evaluator2 );
        result += c;
      }
      else
      {
        let index = _.arrayLeftIndex( dstArray, insArray[ i ], evaluator1, evaluator2 );
        if( index === -1 )
        {
          dstArray.push( insArray[ i ] );
          result += 1;
        }
      }
    }
  }
  else
  {

    _.assert( insArray !== undefined, 'The Array should have no undefined' );

    let index = _.arrayLeftIndex( dstArray, insArray, evaluator1, evaluator2 );
    if( index === -1 )
    {
      dstArray.push( insArray );
      result += 1;
    }
  }

  return result;

  /* */

  function onLongOnce( insArray, insIndex )
  {
    for( let i = 0, len = insArray.length; i < len; i++ )
    {
      if( _.longIs( insArray[ i ] ) )
      onLongOnce( insArray[ i ], insIndex )
      else if( _.arrayLeftIndex( dstArray, insArray[ i ] ) === -1 )
      dstArray.splice( insIndex++, 0, insArray[ i ] );
    }
  }
}

//

function arrayFlattenedOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{

  _.assert( arguments.length && arguments.length <= 4 );
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );

  let oldLength = dstArray.length;
  _.arrayRemoveDuplicates( dstArray );
  let newLength = dstArray.length;
  if( Config.debug )
  _.assert( oldLength === newLength, 'Elements in dstArray must not be repeated' );


  if( arguments.length === 1 )
  {
    for( let i = dstArray.length-1; i >= 0; --i )
    if( _.longIs( dstArray[ i ] ) )
    {
      let insArray = dstArray[ i ];
      dstArray.splice( i, 1 );
      onLongOnce( insArray, i );
    }
    return dstArray;
  }

  let result = 0;

  if( _.longIs( insArray ) )
  {
    for( let i = 0, len = insArray.length; i < len; i++ )
    {
      _.assert( insArray[ i ] !== undefined, 'The Array should have no undefined' );
      if( _.longIs( insArray[ i ] ) )
      {
        let c = _.arrayFlattenedOnceStrictly( dstArray, insArray[ i ], evaluator1, evaluator2 );
        result += c;
      }
      else
      {
        let index = _.arrayLeftIndex( dstArray, insArray[ i ], evaluator1, evaluator2 );
        if( Config.debug )
        _.assert( index === -1, 'Elements must not be repeated' );

        if( index === -1 )
        {
          dstArray.push( insArray[ i ] );
          result += 1;
        }
      }
    }
  }
  else
  {
    _.assert( insArray !== undefined, 'The Array should have no undefined' );
    let index = _.arrayLeftIndex( dstArray, insArray, evaluator1, evaluator2 );
    if( Config.debug )
    _.assert( index === -1, 'Elements must not be repeated' );

    if( index === -1 )
    {
      dstArray.push( insArray );
      result += 1;
    }
  }

  return result;

  /* */

  function onLongOnce( insArray, insIndex )
  {
    for( let i = 0, len = insArray.length; i < len; i++ )
    {
      if( _.longIs( insArray[ i ] ) )
      onLongOnce( insArray[ i ], insIndex )
      else if( _.arrayLeftIndex( dstArray, insArray[ i ] ) === -1 )
      dstArray.splice( insIndex++, 0, insArray[ i ] );
      else if( Config.debug )
      _.assert( _.arrayLeftIndex( dstArray, insArray[ i ] ) === -1, 'Elements must not be repeated' );
    }
  }
}

//

function arrayFlattenDefined( dstArray, insArray )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayFlattenedDefined.apply( this, arguments );

  return dstArray;
}

//

function arrayFlattenDefinedOnce( dstArray, insArray, evaluator1, evaluator2 )
{
  if( dstArray === null )
  {
    dstArray = [];
    arguments[ 0 ] = dstArray;
  }

  arrayFlattenedDefinedOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayFlattenDefinedOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{
  arrayFlattenedDefinedOnceStrictly.apply( this, arguments );
  return dstArray;
}

//

function arrayFlattenedDefined( dstArray, insArray )
{

  _.assert( arguments.length >= 1 );
  _.assert( _.objectIs( this ) );
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );

  if( arguments.length === 1 )
  {
    for( let i = dstArray.length-1; i >= 0; --i )
    if( _.longIs( dstArray[ i ] ) )
    {
      let insArray = dstArray[ i ];
      dstArray.splice( i, 1 );
      onLong( insArray, i );
    }
    return dstArray;
  }

  let result = 0;

  for( let a = 1 ; a < arguments.length ; a++ )
  {
    let insArray = arguments[ a ];

    if( _.longIs( insArray ) )
    {
      for( let i = 0, len = insArray.length; i < len; i++ )
      {
        if( _.longIs( insArray[ i ] ) )
        {
          let c = _.arrayFlattenedDefined( dstArray, insArray[ i ] );
          result += c;
        }
        else
        {
          // _.assert( insArray[ i ] !== undefined, 'The Array should have no undefined' );
          if( insArray[ i ] !== undefined )
          {
            dstArray.push( insArray[ i ] );
            result += 1;
          }
        }
      }
    }
    else
    {
      _.assert( insArray !== undefined, 'The Array should have no undefined' );
      if( insArray !== undefined )
      {
        dstArray.push( insArray );
        result += 1;
      }
    }

  }

  return result;

  /* */

  function onLong( insArray, insIndex )
  {
    for( let i = 0, len = insArray.length; i < len; i++ )
    {
      if( _.longIs( insArray[ i ] ) )
      onLong( insArray[ i ], insIndex )
      else
      dstArray.splice( insIndex++, 0, insArray[ i ] );
    }
  }

}

//

function arrayFlattenedDefinedOnce( dstArray, insArray, evaluator1, evaluator2 )
{

  _.assert( arguments.length && arguments.length <= 4 );
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );

  if( arguments.length === 1 )
  {
    _.arrayRemoveDuplicates( dstArray );

    for( let i = dstArray.length-1; i >= 0; --i )
    if( _.longIs( dstArray[ i ] ) )
    {
      let insArray = dstArray[ i ];
      dstArray.splice( i, 1 );
      onLongOnce( insArray, i );
    }
    return dstArray;
  }

  let result = 0;

  if( _.longIs( insArray ) )
  {
    for( let i = 0, len = insArray.length; i < len; i++ )
    {
      _.assert( insArray[ i ] !== undefined );
      if( _.longIs( insArray[ i ] ) )
      {
        let c = _.arrayFlattenedDefinedOnce( dstArray, insArray[ i ], evaluator1, evaluator2 );
        result += c;
      }
      else
      {
        let index = _.arrayLeftIndex( dstArray, insArray[ i ], evaluator1, evaluator2 );
        if( index === -1 )
        {
          dstArray.push( insArray[ i ] );
          result += 1;
        }
      }
    }
  }
  else if( insArray !== undefined )
  {

    let index = _.arrayLeftIndex( dstArray, insArray, evaluator1, evaluator2 );
    if( index === -1 )
    {
      dstArray.push( insArray );
      result += 1;
    }
  }

  return result;

  /* */

  function onLongOnce( insArray, insIndex )
  {
    for( let i = 0, len = insArray.length; i < len; i++ )
    {
      if( _.longIs( insArray[ i ] ) )
      onLongOnce( insArray[ i ], insIndex )
      else if( _.arrayLeftIndex( dstArray, insArray[ i ] ) === -1 )
      dstArray.splice( insIndex++, 0, insArray[ i ] );
    }
  }

}

//

function arrayFlattenedDefinedOnceStrictly( dstArray, insArray, evaluator1, evaluator2 )
{

  _.assert( arguments.length && arguments.length <= 4 );
  _.assert( _.arrayIs( dstArray ), () => 'Expects array as the first argument {-dstArray-} ' + 'but got ' + _.strQuote( dstArray ) );

  let oldLength = dstArray.length;
  _.arrayRemoveDuplicates( dstArray );
  let newLength = dstArray.length;
  if( Config.debug )
  _.assert( oldLength === newLength, 'Elements in dstArray must not be repeated' );


  if( arguments.length === 1 )
  {
    for( let i = dstArray.length-1; i >= 0; --i )
    if( _.longIs( dstArray[ i ] ) )
    {
      let insArray = dstArray[ i ];
      dstArray.splice( i, 1 );
      onLongOnce( insArray, i );
    }
    return dstArray;
  }

  let result = 0;

  if( _.longIs( insArray ) )
  {
    for( let i = 0, len = insArray.length; i < len; i++ )
    {
      // _.assert( insArray[ i ] !== undefined );
      if( insArray[ i ] === undefined )
      {
      }
      else if( _.longIs( insArray[ i ] ) )
      {
        let c = _.arrayFlattenedDefinedOnceStrictly( dstArray, insArray[ i ], evaluator1, evaluator2 );
        result += c;
      }
      else
      {
        let index = _.arrayLeftIndex( dstArray, insArray[ i ], evaluator1, evaluator2 );
        if( Config.debug )
        _.assert( index === -1, 'Elements must not be repeated' );
        if( index === -1 )
        {
          dstArray.push( insArray[ i ] );
          result += 1;
        }
      }
    }
  }
  else if( insArray !== undefined )
  {

    let index = _.arrayLeftIndex( dstArray, insArray, evaluator1, evaluator2 );
    if( Config.debug )
    _.assert( index === -1, 'Elements must not be repeated' );

    if( index === -1 )
    {
      dstArray.push( insArray );
      result += 1;
    }
  }

  return result;

  /* */

  function onLongOnce( insArray, insIndex )
  {
    for( let i = 0, len = insArray.length; i < len; i++ )
    {
      if( _.longIs( insArray[ i ] ) )
      onLongOnce( insArray[ i ], insIndex )
      else if( _.arrayLeftIndex( dstArray, insArray[ i ] ) === -1 )
      dstArray.splice( insIndex++, 0, insArray[ i ] );
      else if( Config.debug )
      _.assert( _.arrayLeftIndex( dstArray, insArray[ i ] ) === -1, 'Elements must not be repeated' );
    }
  }
}

// --
// array replace
// --

//

function arrayReplace( dstArray, ins, sub, evaluator1, evaluator2 )
{
  _.assert( 3 <= arguments.length && arguments.length <= 5 );

  let index = -1;
  let result = 0;

  index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );

  while( index !== -1 )
  {
    dstArray.splice( index, 1, sub );
    result += 1;
    index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );
  }

  return dstArray;
}

/**
 * The arrayReplaceOnce() routine returns the index of the (dstArray) array which will be replaced by (sub),
 * if (dstArray) has the value (ins).
 *
 * It takes three arguments (dstArray, ins, sub), calls built in function(dstArray.indexOf(ins)),
 * that looking for value (ins) in the (dstArray).
 * If true, it replaces (ins) value of (dstArray) by (sub) and returns the index of the (ins).
 * Otherwise, it returns (-1) index.
 *
 * @param { Array } dstArray - The source array.
 * @param { * } ins - The value to find.
 * @param { * } sub - The value to replace.
 *
 * @example
 * _.arrayReplaceOnce( [ 2, 4, 6, 8, 10 ], 12, 14 );
 * // returns -1
 *
 * @example
 * _.arrayReplaceOnce( [ 1, undefined, 3, 4, 5 ], undefined, 2 );
 * // returns 1
 *
 * @example
 * _.arrayReplaceOnce( [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ], 'Dmitry', 'Bob' );
 * // returns 3
 *
 * @example
 * _.arrayReplaceOnce( [ true, true, true, true, false ], false, true );
 * // returns 4
 *
 * @returns { number }  Returns the index of the (dstArray) array which will be replaced by (sub),
 * if (dstArray) has the value (ins).
 * @function arrayReplaceOnce
 * @throws { Error } Will throw an Error if (dstArray) is not an array.
 * @throws { Error } Will throw an Error if (arguments.length) is less than three.
 * @memberof wTools
 */

function arrayReplaceOnce( dstArray, ins, sub, evaluator1, evaluator2 )
{
  arrayReplacedOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayReplaceOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2 )
{
  let result;
  if( Config.debug )
  {
    result = arrayReplacedOnce.apply( this, arguments );
    _.assert( result >= 0, () => 'Array does not have element ' + _.toStrShort( ins ) );
    result = arrayReplacedOnce.apply( this, arguments );
    _.assert( result < 0, () => 'The element ' + _.toStrShort( ins ) + 'is several times in dstArray' );
  }
  else
  {
    result = arrayReplacedOnce.apply( this, arguments );
  }
  return dstArray;
}

/*
function arrayReplaceOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2 )
{
  let result = arrayReplacedOnce.apply( this, arguments );
  _.assert( result >= 0, () => 'Array does not have element ' + _.toStrShort( ins ) );
  return dstArray;
}
*/

//

function arrayReplaced( dstArray, ins, sub, evaluator1, evaluator2 )
{
  _.assert( 3 <= arguments.length && arguments.length <= 5 );

  let index = -1;
  let result = 0;

  index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );

  while( index !== -1 )
  {
    dstArray.splice( index, 1, sub );
    result += 1;
    index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );
  }

  return result;
}

//

function arrayReplacedOnce( dstArray, ins, sub, evaluator1, evaluator2 )
{
  _.assert( 3 <= arguments.length && arguments.length <= 5 );

  if( _.longIs( ins ) )
  {
    _.assert( _.longIs( sub ) );
    _.assert( ins.length === sub.length );
  }

  let index = -1;

  index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );

  if( index >= 0 )
  dstArray.splice( index, 1, sub );

  return index;
}

//

function arrayReplacedOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2 )
{
  let result;

  if( Config.debug )
  {
    result = arrayReplacedOnce.apply( this, arguments );
    _.assert( result >= 0, () => 'Array does not have element ' + _.toStrShort( ins ) );
    let newResult = arrayReplacedOnce.apply( this, arguments );
    _.assert( newResult < 0, () => 'The element ' + _.toStrShort( ins ) + 'is several times in dstArray' );
  }
  else
  {
    result = arrayReplacedOnce.apply( this, arguments );
  }

  return result;
}

//

function arrayReplaceElement( dstArray, ins, sub, evaluator1, evaluator2 )
{
  _.assert( 3 <= arguments.length && arguments.length <= 5 );

  let index = -1;
  let result = 0;

  index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );

  while( index !== -1 )
  {
    dstArray.splice( index, 1, sub );
    result += 1;
    index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );
  }

  return dstArray;
}

//

function arrayReplaceElementOnce( dstArray, ins, sub, evaluator1, evaluator2 )
{
  arrayReplacedElementOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayReplaceElementOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2 )
{
  let result;
  if( Config.debug )
  {
    result = arrayReplacedElementOnce.apply( this, arguments );
    _.assert( result !== undefined, () => 'Array does not have element ' + _.toStrShort( ins ) );
    result = arrayReplacedElementOnce.apply( this, arguments );
    _.assert( result === undefined, () => 'The element ' + _.toStrShort( ins ) + 'is several times in dstArray' );
  }
  else
  {
    result = arrayReplacedElementOnce.apply( this, arguments );
  }
  return dstArray;
}

//

function arrayReplacedElement( dstArray, ins, sub, evaluator1, evaluator2 )
{
  _.assert( 3 <= arguments.length && arguments.length <= 5 );

  let index = -1;
  let result = 0;

  index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );

  while( index !== -1 )
  {
    dstArray.splice( index, 1, sub );
    result += 1;
    index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );
  }

  return result;
}

//

function arrayReplacedElementOnce( dstArray, ins, sub, evaluator1, evaluator2 )
{
  _.assert( 3 <= arguments.length && arguments.length <= 5 );

  if( _.longIs( ins ) )
  {
    _.assert( _.longIs( sub ) );
    _.assert( ins.length === sub.length );
  }

  let index = -1;

  index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );

  if( index >= 0 )
  dstArray.splice( index, 1, sub );
  else
  return undefined;

  return ins;
}

//

function arrayReplacedElementOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2 )
{
  let result;
  if( Config.debug )
  {
    result = arrayReplacedElementOnce.apply( this, arguments );
    _.assert( result !== undefined, () => 'Array does not have element ' + _.toStrShort( ins ) );
    let newResult = arrayReplacedElementOnce.apply( this, arguments );
    _.assert( newResult === undefined, () => 'The element ' + _.toStrShort( ins ) + 'is several times in dstArray' );
  }
  else
  {
    result = arrayReplacedElementOnce.apply( this, arguments );
  }

  return result;
}

/*
function arrayReplacedOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2 )
{
  let result = arrayReplacedOnce.apply( this, arguments );
  _.assert( result >= 0, () => 'Array does not have element ' + _.toStrShort( ins ) );
  return result;
}
*/

//

function arrayReplaceArray( dstArray, ins, sub, evaluator1, evaluator2  )
{
  arrayReplacedArray.apply( this, arguments );
  return dstArray;
}

//

function arrayReplaceArrayOnce( dstArray, ins, sub, evaluator1, evaluator2  )
{
  arrayReplacedArrayOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayReplaceArrayOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2  )
{
  let result;
  if( Config.debug )
  {
    result = arrayReplacedArrayOnce.apply( this, arguments );
    _.assert( result === ins.length, '{-dstArray-} should have each element of {-insArray-}' );
    _.assert( ins.length === sub.length, '{-subArray-} should have the same length {-insArray-} has' );

    let newResult = arrayReplacedArrayOnce.apply( this, arguments );

    _.assert( newResult === 0, () => 'The element ' + _.toStrShort( ins ) + 'is several times in dstArray' );
  }
  else
  {
    result = arrayReplacedArrayOnce.apply( this, arguments );
  }

  return dstArray;
}

/*
function arrayReplaceArrayOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2  )
{
  let result = arrayReplacedArrayOnce.apply( this, arguments );
  _.assert( result === ins.length, '{-dstArray-} should have each element of {-insArray-}' );
  _.assert( ins.length === sub.length, '{-subArray-} should have the same length {-insArray-} has' );
  return dstArray;
}
*/

//

function arrayReplacedArray( dstArray, ins, sub, evaluator1, evaluator2 )
{
  _.assert( 3 <= arguments.length && arguments.length <= 5 );
  _.assert( _.longIs( ins ) );
  _.assert( _.longIs( sub ) );
  _.assert( ins.length === sub.length, '{-subArray-} should have the same length {-insArray-} has'  );

  let index = -1;
  let result = 0;
  let oldDstArray = dstArray.slice();  // Array with src values stored
  for( let i = 0, len = ins.length; i < len; i++ )
  {
    let dstArray2 = oldDstArray.slice(); // Array modified for each ins element
    index = _.arrayLeftIndex( dstArray2, ins[ i ], evaluator1, evaluator2 );
    while( index !== -1 )
    {
      let subValue = sub[ i ];
      if( subValue === undefined )
      {
        dstArray.splice( index, 1 );
        dstArray2.splice( index, 1 );
      }
      else
      {
        dstArray.splice( index, 1, subValue );
        dstArray2.splice( index, 1, subValue );
      }

      result += 1;
      index = _.arrayLeftIndex( dstArray2, ins[ i ], evaluator1, evaluator2 );
    }
  }

  return result;
}

//

function arrayReplacedArrayOnce( dstArray, ins, sub, evaluator1, evaluator2 )
{
  _.assert( _.longIs( ins ) );
  _.assert( _.longIs( sub ) );
  _.assert( ins.length === sub.length, '{-subArray-} should have the same length {-insArray-} has'  );
  _.assert( 3 <= arguments.length && arguments.length <= 5 );

  let index = -1;
  let result = 0;
  //let oldDstArray = dstArray.slice();  // Array with src values stored
  for( let i = 0, len = ins.length; i < len; i++ )
  {
    index = _.arrayLeftIndex( dstArray, ins[ i ], evaluator1, evaluator2 );
    if( index >= 0 )
    {
      let subValue = sub[ i ];
      if( subValue === undefined )
      dstArray.splice( index, 1 );
      else
      dstArray.splice( index, 1, subValue );
      result += 1;
    }
  }

  return result;
}

//

function arrayReplacedArrayOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2  )
{
  let result;
  if( Config.debug )
  {
    result = arrayReplacedArrayOnce.apply( this, arguments );
    _.assert( result === ins.length, '{-dstArray-} should have each element of {-insArray-}' );
    _.assert( ins.length === sub.length, '{-subArray-} should have the same length {-insArray-} has' );
    let newResult = arrayReplacedArrayOnce.apply( this, arguments );
    _.assert( newResult === 0, () => 'One element of ' + _.toStrShort( ins ) + 'is several times in dstArray' );
  }
  else
  {
    result = arrayReplacedArrayOnce.apply( this, arguments );
  }

  return result;
}

//

function arrayReplaceArrays( dstArray, ins, sub, evaluator1, evaluator2  )
{
  arrayReplacedArrays.apply( this, arguments );
  return dstArray;
}

//

function arrayReplaceArraysOnce( dstArray, ins, sub, evaluator1, evaluator2  )
{
  arrayReplacedArraysOnce.apply( this, arguments );
  return dstArray;
}

//

function arrayReplaceArraysOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2  )
{
  let result;
  if( Config.debug )
  {
    result = arrayReplacedArraysOnce.apply( this, arguments );

    let expected = 0;
    for( let i = ins.length - 1; i >= 0; i-- )
    {
      if( _.longIs( ins[ i ] ) )
      expected += ins[ i ].length;
      else
      expected += 1;
    }

    _.assert( result === expected, '{-dstArray-} should have each element of {-insArray-}' );
    _.assert( ins.length === sub.length, '{-subArray-} should have the same length {-insArray-} has' );
    let newResult = arrayReplacedArrayOnce.apply( this, arguments );
    _.assert( newResult === 0, () => 'One element of ' + _.toStrShort( ins ) + 'is several times in dstArray' );
  }
  else
  {
    result = arrayReplacedArrayOnce.apply( this, arguments );
  }

  return dstArray;

}

//

function arrayReplacedArrays( dstArray, ins, sub, evaluator1, evaluator2 )
{
  _.assert( 3 <= arguments.length && arguments.length <= 5 );
  _.assert( _.arrayIs( dstArray ), 'arrayReplacedArrays :', 'Expects array' );
  _.assert( _.longIs( sub ), 'arrayReplacedArrays :', 'Expects longIs entity' );
  _.assert( _.longIs( ins ), 'arrayReplacedArrays :', 'Expects longIs entity' );
  _.assert( ins.length === sub.length, '{-subArray-} should have the same length {-insArray-} has'  );

  let result = 0;
  let oldDstArray = dstArray.slice();  // Array with src values stored

  function _replace( dstArray, argument, subValue, evaluator1, evaluator2  )
  {
    let dstArray2 = oldDstArray.slice();
    //let index = dstArray.indexOf( argument );
    let index = _.arrayLeftIndex( dstArray2, argument, evaluator1, evaluator2 );

    while( index !== -1 )
    {
      dstArray2.splice( index, 1, subValue );
      dstArray.splice( index, 1, subValue );
      result += 1;
      index = _.arrayLeftIndex( dstArray2, argument, evaluator1, evaluator2 );
    }
  }

  for( let a = ins.length - 1; a >= 0; a-- )
  {
    if( _.longIs( ins[ a ] ) )
    {
      let insArray = ins[ a ];
      let subArray = sub[ a ];

      for( let i = insArray.length - 1; i >= 0; i-- )
      _replace( dstArray, insArray[ i ], subArray[ i ], evaluator1, evaluator2   );
    }
    else
    {
      _replace( dstArray, ins[ a ], sub[ a ], evaluator1, evaluator2 );
    }
  }

  return result;
}

//

function arrayReplacedArraysOnce( dstArray, ins, sub, evaluator1, evaluator2 )
{
  _.assert( 3 <= arguments.length && arguments.length <= 5 );
  _.assert( _.arrayIs( dstArray ), 'arrayReplacedArrays :', 'Expects array' );
  _.assert( _.longIs( sub ), 'arrayReplacedArrays :', 'Expects longIs entity' );
  _.assert( _.longIs( ins ), 'arrayReplacedArrays :', 'Expects longIs entity' );
  _.assert( ins.length === sub.length, '{-subArray-} should have the same length {-insArray-} has'  );

  let result = 0;
  let oldDstArray = dstArray.slice();  // Array with src values stored

  function _replace( dstArray, argument, subValue, evaluator1, evaluator2  )
  {
    let dstArray2 = oldDstArray.slice();
    //let index = dstArray.indexOf( argument );
    let index = _.arrayLeftIndex( dstArray2, argument, evaluator1, evaluator2 );

    if( index !== -1 )
    {
      dstArray2.splice( index, 1, subValue );
      dstArray.splice( index, 1, subValue );
      result += 1;
    }
  }

  for( let a = ins.length - 1; a >= 0; a-- )
  {
    if( _.longIs( ins[ a ] ) )
    {
      let insArray = ins[ a ];
      let subArray = sub[ a ];

      for( let i = insArray.length - 1; i >= 0; i-- )
      _replace( dstArray, insArray[ i ], subArray[ i ], evaluator1, evaluator2   );
    }
    else
    {
      _replace( dstArray, ins[ a ], sub[ a ], evaluator1, evaluator2 );
    }
  }

  return result;
}

//

function arrayReplacedArraysOnceStrictly( dstArray, ins, sub, evaluator1, evaluator2  )
{
  let result;
  if( Config.debug )
  {
    result = arrayReplacedArraysOnce.apply( this, arguments );

    let expected = 0;
    for( let i = ins.length - 1; i >= 0; i-- )
    {
      if( _.longIs( ins[ i ] ) )
      expected += ins[ i ].length;
      else
      expected += 1;
    }

    _.assert( result === expected, '{-dstArray-} should have each element of {-insArray-}' );
    _.assert( ins.length === sub.length, '{-subArray-} should have the same length {-insArray-} has' );
    let newResult = arrayReplacedArrayOnce.apply( this, arguments );
    _.assert( newResult === 0, () => 'The element ' + _.toStrShort( ins ) + 'is several times in dstArray' );
  }
  else
  {
    result = arrayReplacedArrayOnce.apply( this, arguments );
  }

  return result;

}

// //
//
// function arrayReplaceAll( dstArray, ins, sub, evaluator1, evaluator2 )
// {
//   arrayReplacedAll.apply( this, arguments );
//   return dstArray;
// }
//
// //
//
// function arrayReplacedAll( dstArray, ins, sub, evaluator1, evaluator2 )
// {
//   _.assert( 3 <= arguments.length && arguments.length <= 5 );
//
//   let index = -1;
//   let result = 0;
//
//   index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );
//
//   while( index !== -1 )
//   {
//     dstArray.splice( index, 1, sub );
//     result += 1;
//     index = _.arrayLeftIndex( dstArray, ins, evaluator1, evaluator2 );
//   }
//
//   return result;
// }

//

/**
 * The arrayUpdate() routine adds a value (sub) to an array (dstArray) or replaces a value (ins) of the array (dstArray) by (sub),
 * and returns the last added index or the last replaced index of the array (dstArray).
 *
 * It creates the variable (index) assigns and calls to it the function(arrayReplaceOnce( dstArray, ins, sub ).
 * [arrayReplaceOnce( dstArray, ins, sub )]{@link wTools.arrayReplaceOnce}.
 * Checks if (index) equal to the -1.
 * If true, it adds to an array (dstArray) a value (sub), and returns the last added index of the array (dstArray).
 * Otherwise, it returns the replaced (index).
 *
 * @see wTools.arrayReplaceOnce
 *
 * @param { Array } dstArray - The source array.
 * @param { * } ins - The value to change.
 * @param { * } sub - The value to add or replace.
 *
 * @example
 * let add = _.arrayUpdate( [ 'Petre', 'Mikle', 'Oleg' ], 'Dmitry', 'Dmitry' );
 * // returns 3
 * console.log( add );
 * // log [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ]
 *
 * @example
 * let add = _.arrayUpdate( [ 1, 2, 3, 4, 5 ], 6, 6 );
 * // returns 5
 * console.log( add );
 * // log [ 1, 2, 3, 4, 5, 6 ]
 *
 * @example
 * let replace = _.arrayUpdate( [ true, true, true, true, false ], false, true );
 * // returns 4
 * console.log( replace );
 * // log [ true, true true, true, true ]
 *
 * @returns { number } Returns the last added or the last replaced index.
 * @function arrayUpdate
 * @throws { Error } Will throw an Error if (dstArray) is not an array-like.
 * @throws { Error } Will throw an Error if (arguments.length) is less or more than three.
 * @memberof wTools
 */

function arrayUpdate( dstArray, ins, sub, evaluator1, evaluator2 )
{
  let index = arrayReplacedOnce.apply( this, arguments );

  if( index === -1 )
  {
    dstArray.push( sub );
    index = dstArray.length - 1;
  }

  return index;
}

// --
// fields
// --

// let unrollSymbol = Symbol.for( 'unroll' );

let Fields =
{

  ArrayType : Array,

  accuracy : 1e-7,
  accuracySqrt : 1e-4,
  accuracySqr : 1e-14,

}

// --
// routines
// --

let Routines =
{

  // scalar

  scalarAppend, /* qqq : cover routine scalarAppend */
  scalarAppendOnce, /* qqq : cover routine scalarAppendOnce */

  scalarToVector,
  scalarFrom,
  scalarFromOrNull,

  // arguments array

  argumentsArrayIs,
  argumentsArrayMake,
  _argumentsArrayMake,
  argumentsArrayFrom,

  // unroll

  unrollIs,
  unrollIsPopulated,

  unrollMake,
  unrollMakeUndefined,
  unrollFrom,
  unrollsFrom,
  unrollFromMaybe,
  unrollNormalize,

  unrollSelect,

  unrollPrepend,
  unrollAppend,
  unrollRemove,

  // long

  longIs,
  longIsPopulated,

  longMake,
  _longMakeOfLength,
  longMakeUndefined,
  longMakeZeroed,

  _longClone,
  longShallowClone,

  longSlice,
  longBut,
  longButInplace,
  longSelect,
  longSelectInplace,
  longGrow,
  longGrowInplace,
  longRelength,
  longRelengthInplace,

  longRepresent,

  // buffer checker

  bufferRawIs,
  bufferTypedIs,
  bufferViewIs,
  bufferNodeIs,
  bufferAnyIs,
  bufferBytesIs,
  bufferBytesIs,
  constructorIsBuffer,

  // array checker

  arrayIs,
  arrayIsPopulated,
  arrayLikeResizable,
  arrayLike,

  constructorLikeArray,
  hasLength,
  arrayHasArray,

  arrayCompare,
  arraysAreIdentical,

  arrayHas,
  arrayHasAny, /* qqq : remake, make it expect only 2 mandatory arguments and optional evaluator / equalizer */
  arrayHasAll, /* qqq : remake, make it expect only 2 mandatory arguments and optional evaluator / equalizer */
  arrayHasNone, /* qqq : remake, make it expect only 2 mandatory arguments and optional evaluator / equalizer */

  arrayAll,
  arrayAny,
  arrayNone,

  // array producer

  arrayMake,
  arrayMakeUndefined,
  arrayFrom,
  arrayAs,
  arrayAsShallowing,

  // array transformer

  arraySlice,
  // arrayButInplace, // Dmytro : maybe it should be arraySliceInplace
  arrayBut,
  arrayButInplace,
  arraySelect,
  arraySelectInplace,
  arrayGrow,
  arrayGrowInplace,
  arrayRelength,
  arrayRelengthInplace,

  // array sequential search

  arrayLeftIndex,
  arrayRightIndex,

  arrayLeft,
  arrayRight,

  arrayLeftDefined,
  arrayRightDefined,

  arrayCountElement, /* qqq : cover by tests */
  arrayCountTotal, /* qqq : cover by tests */
  arrayCountUnique,

  // array prepend

  arrayPrepend,
  arrayPrependOnce,
  arrayPrependOnceStrictly,
  arrayPrepended,
  arrayPrependedOnce,
  arrayPrependedOnceStrictly,

  arrayPrependElement,
  arrayPrependElementOnce,
  arrayPrependElementOnceStrictly,
  arrayPrependedElement,
  arrayPrependedElementOnce,
  arrayPrependedElementOnceStrictly,

  arrayPrependArray,
  arrayPrependArrayOnce,
  arrayPrependArrayOnceStrictly,
  arrayPrependedArray,
  arrayPrependedArrayOnce,
  arrayPrependedArrayOnceStrictly,

  arrayPrependArrays,
  arrayPrependArraysOnce,
  arrayPrependArraysOnceStrictly,
  arrayPrependedArrays,
  arrayPrependedArraysOnce,
  arrayPrependedArraysOnceStrictly,

  // array append

  arrayAppend,
  arrayAppendOnce,
  arrayAppendOnceStrictly,
  arrayAppended,
  arrayAppendedOnce,
  arrayAppendedOnceStrictly,

  arrayAppendElement, /* qqq : fill gaps */
  arrayAppendElementOnce,
  arrayAppendElementOnceStrictly,
  arrayAppendedElement,
  arrayAppendedElementOnce,
  arrayAppendedElementOnceStrictly,

  arrayAppendArray,
  arrayAppendArrayOnce,
  arrayAppendArrayOnceStrictly,
  arrayAppendedArray,
  arrayAppendedArrayOnce,
  arrayAppendedArrayOnceStrictly,

  arrayAppendArrays,
  arrayAppendArraysOnce,
  arrayAppendArraysOnceStrictly,
  arrayAppendedArrays,
  arrayAppendedArraysOnce,
  arrayAppendedArraysOnceStrictly,

  // array remove

  arrayRemove,
  arrayRemoveOnce,
  arrayRemoveOnceStrictly,
  arrayRemoved,
  arrayRemovedOnce,
  arrayRemovedOnceStrictly,

  arrayRemoveElement, /* qqq : should remove all, check test coverage */
  arrayRemoveElementOnce,
  arrayRemoveElementOnceStrictly,
  arrayRemovedElement,
  arrayRemovedElementOnce,
  arrayRemovedElementOnceStrictly,

  arrayRemoveArray,
  arrayRemoveArrayOnce,
  arrayRemoveArrayOnceStrictly,
  arrayRemovedArray,
  arrayRemovedArrayOnce,
  arrayRemovedArrayOnceStrictly,

  arrayRemoveArrays,
  arrayRemoveArraysOnce,
  arrayRemoveArraysOnceStrictly,
  arrayRemovedArrays,
  arrayRemovedArraysOnce,
  arrayRemovedArraysOnceStrictly,

  arrayRemoveDuplicates,

  // array flatten

  arrayFlatten,
  arrayFlattenOnce,
  arrayFlattenOnceStrictly,
  arrayFlattened,
  arrayFlattenedOnce,
  arrayFlattenedOnceStrictly,

  arrayFlattenDefined,
  arrayFlattenDefinedOnce,
  arrayFlattenDefinedOnceStrictly,
  arrayFlattenedDefined,
  arrayFlattenedDefinedOnce,
  arrayFlattenedDefinedOnceStrictly,

  // array replace

  arrayReplace,
  arrayReplaceOnce,
  arrayReplaceOnceStrictly,
  arrayReplaced,
  arrayReplacedOnce,
  arrayReplacedOnceStrictly, /* qqq implement */

  arrayReplaceElement,
  arrayReplaceElementOnce,
  arrayReplaceElementOnceStrictly,
  arrayReplacedElement,
  arrayReplacedElementOnce,
  arrayReplacedElementOnceStrictly,

  arrayReplaceArray,
  arrayReplaceArrayOnce,
  arrayReplaceArrayOnceStrictly,
  arrayReplacedArray,
  arrayReplacedArrayOnce,
  arrayReplacedArrayOnceStrictly,

  arrayReplaceArrays,
  arrayReplaceArraysOnce,
  arrayReplaceArraysOnceStrictly,
  arrayReplacedArrays,
  arrayReplacedArraysOnce,
  arrayReplacedArraysOnceStrictly,

  // arrayReplaceAll, // use arrayReplaceElement instead
  // arrayReplacedAll, // use arrayReplacedElement instead

  arrayUpdate,

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
