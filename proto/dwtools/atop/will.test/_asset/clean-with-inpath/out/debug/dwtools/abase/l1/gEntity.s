( function _gEntity_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

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
 * _.entityLength( [ 1, 2, 3 ] );
 * // returns 3
 *
 * @example
 * _.entityLength( 'string' );
 * // returns 1
 *
 * @example
 * _.entityLength( { a : 1, b : 2 } );
 * // returns 2
 *
 * @example
 * let src = undefined;
 * _.entityLength( src );
 * // returns 0
 *
 * @function entityLength
 * @memberof wTools
*/

function entityLength( src )
{
  if( src === undefined )
  return 0;
  if( _.longIs( src ) )
  return src.length;
  if( _.setLike( src ) )
  return src.size;
  if( _.hashMapLike( src ) )
  return src.size;
  if( _.objectLike( src ) )
  return _.mapOwnKeys( src ).length;
  return 1;
}

//

/**
 * Returns "size" of entity( src ). Representation of "size" depends on type of( src ):
 *  - For string returns value of it own length property;
 *  - For array-like entity returns value of it own byteLength property for( BufferRaw, TypedArray, etc )
 *    or length property for other;
 *  - In other cases returns null.
 *
 * @param {*} src - Source entity.
 * @returns {number} Returns "size" of entity.
 *
 * @example
 * _.uncountableSize( 'string' );
 * // returns 6
 *
 * @example
 * _.uncountableSize( new BufferRaw( 8 ) );
 * // returns 8
 *
 * @example
 * _.uncountableSize( 123 );
 * // returns null
 *
 * @function uncountableSize
 * @memberof wTools
*/

function uncountableSize( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.strIs( src ) )
  {
    if( src.length )
    return _.bufferBytesFrom( src ).byteLength;
    return src.length;
  }

  if( _.primitiveIs( src ) )
  return 8;

  if( _.numberIs( src.byteLength ) )
  return src.byteLength;

  // if( _.numberIs( src ) )
  // return 8;
  //
  // if( !_.definedIs( src ) )
  // return 8;
  //
  // if( _.boolIs( src ) || _.dateIs( src ) )
  // return 8;

  if( _.regexpIs( src ) )
  return _.uncountableSize( src.source ) + src.flags.length * 1;

  if( !_.countableIs( src ) )
  return 8;

  // if( _.longIs( src ) )
  // {
  //   let result = 0;
  //   for( let i = 0; i < src.length; i++ )
  //   {
  //     result += _.uncountableSize( src[ i ] );
  //     if( isNaN( result ) )
  //     break;
  //   }
  //   return result;
  // }
  //
  // if( _.mapIs( src ) )
  // {
  //   let result = 0;
  //   for( let k in src )
  //   {
  //     result += _.uncountableSize( k );
  //     result += _.uncountableSize( src[ k ] );
  //     if( isNaN( result ) )
  //     break;
  //   }
  //   return result;
  // }

  return NaN;
}

//

/**
 * Returns "size" of entity( src ). Representation of "size" depends on type of( src ):
 *  - For string returns value of it own length property;
 *  - For array-like entity returns value of it own byteLength property for( BufferRaw, TypedArray, etc )
 *    or length property for other;
 *  - In other cases returns null.
 *
 * @param {*} src - Source entity.
 * @returns {number} Returns "size" of entity.
 *
 * @example
 * _.entitySize( 'string' );
 * // returns 6
 *
 * @example
 * _.entitySize( [ 1, 2, 3 ] );
 * // returns 3
 *
 * @example
 * _.entitySize( new BufferRaw( 8 ) );
 * // returns 8
 *
 * @example
 * _.entitySize( 123 );
 * // returns null
 *
 * @function entitySize
 * @memberof wTools
*/

function entitySize( src )
{
  let result = 0;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.primitiveIs( src ) || !_.countableIs( src ) || _.bufferAnyIs( src ) )
  return _.uncountableSize( src );

  if( _.look )
  if( _.containerIs( src ) || _.countableIs( src ) )
  {
    _.look( src, onEach );
  }

  return result;
  // if( _.longLike( src ) )
  // {
  //   let result = 0;
  //   for( let i = 0; i < src.length; i++ )
  //   {
  //     result += _.entitySize( src[ i ] );
  //     if( isNaN( result ) )
  //     break;
  //   }
  //   return result;
  // }
  //
  // if( _.mapLike( src ) )
  // {
  //   let result = 0;
  //   for( let k in src )
  //   {
  //     result += _.entitySize( k );
  //     result += _.entitySize( src[ k ] );
  //     if( isNaN( result ) )
  //     break;
  //   }
  //   return result;
  // }
  //
  // if( _.setLike( src ) )
  // {
  //   let result = 0; debugger; xxx
  //   for( let e of src )
  //   {
  //     result += _.entitySize( e );
  //     if( isNaN( result ) )
  //     break;
  //   }
  //   return result;
  // }
  //
  // if( _.countableIs( src ) )
  // {
  //   let result = 0;
  //   for( let k in src )
  //   {
  //     result += _.entitySize( k );
  //     result += _.entitySize( src[ k ] );
  //     if( isNaN( result ) )
  //     break;
  //   }
  //   return result;
  // }
  //
  // return NaN;

  function onEach( e, k, it )
  {

    if( !_.numberDefined( result ) )
    {
      it.iterator.continue = false;
      return;
    }

    if( !it.down )
    return;

    if( it.down.iterable === 'map-like' || it.down.iterable === 'hash-map-like' )
    {
      result += _.uncountableSize( k );
    }

    if( _.primitiveIs( e ) || !_.countableIs( e ) || _.bufferAnyIs( e ) )
    result += _.uncountableSize( e );

  }

}

//

function containerEmpty( dstContainer )
{
  if( _.longIs( dstContainer ) )
  _.longEmpty( dstContainer );
  else if( _.setIs( dstContainer ) )
  dstContainer.clear();
  else if( _.hashMapIs( dstContainer ) )
  dstContainer.clear();
  else if( _.mapLike( dstContainer ) )
  _.mapEmpty( dstContainer );
  else
  _.assert( 0, `Not clear how to empty non-container ${_.strType( dstContainer )}` );
  return dstContainer;
}

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

  entityLength, /* qqq : implement good coverage */
  lengthOf : entityLength,

  uncountableSize, /* qqq : implement good coverage */
  entitySize, /* qqq : implement good coverage */
  sizeOf : entitySize,

  containerEmpty, /* qqq : implement good coverage */
  empty : containerEmpty,

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
