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
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.strIs( src ) )
  {
    if( src.length )
    return _.bufferBytesFrom( src ).byteLength;
    return src.length;
  }

  if( _.numberIs( src ) )
  return 8;

  if( !_.definedIs( src ) )
  return 8;

  if( _.boolIs( src ) || _.dateIs( src ) )
  return 8;

  if( _.numberIs( src.byteLength ) )
  return src.byteLength;

  if( _.regexpIs( src ) )
  return entitySize( src.source ) + src.flags.length * 2;

  if( _.longIs( src ) )
  {
    let result = 0;
    for( let i = 0; i < src.length; i++ )
    {
      result += _.entitySize( src[ i ] );
      if( isNaN( result ) )
      break;
    }
    return result;
  }

  if( _.mapIs( src ) )
  {
    let result = 0;
    for( let k in src )
    {
      result += _.entitySize( k );
      result += _.entitySize( src[ k ] );
      if( isNaN( result ) )
      break;
    }
    return result;
  }

  return NaN;
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

  entityLength,
  entitySize,

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
