(function _kArrayDescriptor_s_() {

'use strict';

let _global = _global_;
let _ = _global.wModuleForTesting1;
let Self = _global.wModuleForTesting1;

_.assert( !_.Array );
_.assert( !_.array );
_.assert( !_.withDefaultLongType );

//

function _longDescriptorApplyTo( dst,def )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( !_.mapOwnKey( dst,'withDefaultLongType' ) );
  _.assert( !_.mapOwnKey( dst,'array' ) );
  _.assert( !!LongDescriptors[ def ] );

  dst.withDefaultLongType = Object.create( null );

  for( let d in LongDescriptors )
  {
    dst.withDefaultLongType[ d ] = Object.create( dst );
    _.mapExtend( dst.withDefaultLongType[ d ], LongDescriptors[ d ] );
  }

  dst.array = dst.withDefaultLongType[ def ];
  dst.LongDescriptors = LongDescriptors;

}

// --
// delcare
// --

function _declare( nameSpace )
{

let ArrayType = nameSpace.ArrayType;
let ArrayName = nameSpace.ArrayName;

nameSpace = _.mapExtend( null,nameSpace );

//

/**
 * @summary Creates new array based on type of `src` array. Takes length of new array from second argument `length`.
 * @param {} src Source array
 * @param {Number} [ length ] Lengthof target array.
 * @function MakeSimilar
 * @memberof wModuleForTesting1."wModuleForTesting1.array"
 */

function MakeSimilar( src,length )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  let result = _.longMakeUndefined( src,length );

  return result;
}

//

/**
 * @summary Creates new array of length( length ).
 * @description Type of array depends on `ArrayType`( see examples ).
 * @param {Number} length Lengthof new array.
 *
 * @example
 * _.long.longMake(1);
 * // returns instance of Array
 *
 * @example
 * _.withDefaultLongType.Fx.Make/*makeArrayOfLength*/(1);
 * // returns instance of F32x
 *
 * @function Make/*makeArrayOfLength*/
 * @memberof wModuleForTesting1."wModuleForTesting1.array"
 */

function Make/*makeArrayOfLength*/( length )
{

  if( length === undefined )
  length = 0;

  _.assert( length === undefined || length >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  let result = new this.array.ArrayType( length );

  return result;
}

//

/**
 * @summary Creates new array of length( length ) filled with zeroes.
 * @description Type of array depends on `ArrayType`( see examples ).
 * @param {Number} length Lengthof new array.
 *
 * @example
 * _.long.longMakeZeroed( 2 );
 * // returns Array [ 0,0 ]
 *
 * @example
 * _.withDefaultLongType.Fx.Make/*makeArrayOfLength*/( 2 );
 * // returns F32x [ 0,0 ]
 *
 * @function Make/*makeArrayOfLength*/Zeroed
 * @memberof wModuleForTesting1."wModuleForTesting1.array"
 */


function Make/*makeArrayOfLength*/Zeroed( length )
{
  if( length === undefined )
  length = 0;

  _.assert( length === undefined || length >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  let result = new this.array.ArrayType( length );

  if( this.array.ArrayType === Array )
  for( let i = 0 ; i < length ; i++ )
  result[ i ] = 0;

  return result;
}

//

/**
 * @summary Creates new array taking elements from source array `src`.
 * @description Type of new array depends on `ArrayType`( see examples ).
 * Returns new array of type `ArrayType` or src if types are same.
 * @param {} src Source array.
 *
 * @example
 * let src =  _.withDefaultLongType.Fx.Make/*makeArrayOfLength*/( 2 );
 * _.array.arrayFromCoercing( src );
 * // returns Array [ 0,0 ]
 *
 * @example
 * let src =  _.long.longMake( 2 );
 * _.withDefaultLongType.Fx.arrayFromCoercing( src );
 * // returns F32x [ 0,0 ]
 *
 * @example
 * let src =  _.long.longMake( 2 );
 * _.array.arrayFromCoercing( src );
 * // returns src
 *
 * @function arrayFromCoercing
 * @memberof wModuleForTesting1."wModuleForTesting1.array"
 */

function arrayFromCoercing( src )
{
  _.assert( _.longIs( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( src.constructor === this.array.ArrayType )
  return src;

  let result;

  if( this.array.ArrayType === Array )
  result = new( _.constructorJoin( this.array.ArrayType, src ) );
  else
  result = new this.array.ArrayType( src );

  return result;
}

// --
//
// --

let Extend =
{

  MakeSimilar,
  Make/*makeArrayOfLength*/,
  Make/*makeArrayOfLength*/Zeroed,

  arrayFrom : arrayFromCoercing,
  arrayFromCoercing,

  array : nameSpace,

}

_.mapExtend( nameSpace, Extend );
_.assert( !LongDescriptors[ ArrayName ] );

LongDescriptors[ ArrayName ] = nameSpace;

return nameSpace;

}

// --
//
// --

function makeFor_functor( cls )
{
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( cls ) );
  _.assert( _.strDefined( cls.name ) );
  let r =
  {
    [ cls.name ] : function( src )
    {
      debugger;
      _.assert( arguments.length === 1 );
      return new cls( src );
    }
  }
  return r[ cls.name ];
}

//

function fromFor_functor( cls )
{
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( cls ) );
  _.assert( _.strDefined( cls.name ) );
  let r =
  {
    [ cls.name ] : function()
    {
      debugger;
      _.assert( arguments.length === 1 );
      if( this instanceof cls )
      return this;
      return new cls( src );
    }
  }
  return r[ cls.name ];
}

//

function isFor_functor( cls )
{
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( cls ) );
  _.assert( _.strDefined( cls.name ) );
  let r =
  {
    [ cls.name ] : function( src )
    {
      debugger; xxx
      _.assert( arguments.length === 1 );
      return src instanceof cls;
    }
  }
  return r[ cls.name ];
}

//

function longDeclare( o )
{
  _.routineOptions( longDeclare, o );
  _.assert( _.strDefined( o.name ) );
  _.assert( _.strDefined( o.secondName ) || o.secondName === null );
  _.assert( _.strDefined( o.aliasName ) || o.aliasName === null );
  _.assert( _.routineIs( o.type ) );
  _.assert( _.routineIs( o.make ) || o.make === null );
  _.assert( _.routineIs( o.from ) || o.from === null );
  _.assert( _.routineIs( o.is ) || o.make === null );
  _.assert( _.boolIs( o.isTyped ) );
  _.assert( LongDescriptor[ o.name ] === undefined );

  if( !o.make )
  o.make = makeFor_functor( o.type );

  if( !o.from )
  o.from = fromFor_functor( o.type );

  if( !o.is )
  o.is = isFor_functor( o.type );

  Object.freeze( o );
  LongDescriptor[ o.name ] = o;

  return o;
}

longDeclare.defaults =
{
  name : null,
  secondName : null,
  aliasName : null,
  type : null,
  make : null,
  from : null,
  is : null,
  isTyped : null,
}

//

let LongDescriptor =
{
}

longDeclare({ name : 'Array', type : Array, make : _.arrayMake, from : _.arrayMake, is : _.arrayIs, isTyped : false });
longDeclare({ name : 'Unroll', type : Array, make : _.unrollMake, from : _.unrollFrom, is : _.unrollIs, isTyped : false });
longDeclare({ name : 'ArgumentsArray', secondName : 'Arguments', type : _._argumentsArrayMake().constructor, make : _.argumentsArrayFrom, from : _.argumentsArrayFrom, is : _.argumentsArrayIs, isTyped : false });

longDeclare({ name : 'U32x', secondName : 'Uint32', type : _global.U32x, isTyped : true });
longDeclare({ name : 'U16x', secondName : 'Uint16', type : _global.U16x, isTyped : true });
longDeclare({ name : 'U8x', secondName : 'Uint8', type : _global.U8x, isTyped : true });
longDeclare({ name : 'Ux', secondName : 'Uint32', aliasName : 'U32x', type : _global.Ux, isTyped : true });

longDeclare({ name : 'I32x', secondName : 'Int32', type : _global.I32x, isTyped : true });
longDeclare({ name : 'I16x', secondName : 'Int16', type : _global.I16x, isTyped : true });
longDeclare({ name : 'I8x', secondName : 'Int8', type : _global.I8x, isTyped : true });
longDeclare({ name : 'Ix', secondName : 'Int32', aliasName : 'I32x', type :_global.Ix, isTyped : true });

longDeclare({ name : 'F32x', secondName : 'Float32', type : _global.F32x, isTyped : true });
longDeclare({ name : 'F64x', secondName : 'Float64', type : _global.F64x, isTyped : true });
longDeclare({ name : 'Fx', secondName : 'Float32', aliasName : 'F32x', type : _global.Fx, isTyped : true });

//

let Extend =
{
  makeFor_functor,
  fromFor_functor,
  isFor_functor,
  longDeclare,
  LongDescriptor,
}

Object.assign( wModuleForTesting1, Extend );

// --
//
// --

let _ArrayNameSpaces =
[
  { ArrayType : F32x, ArrayName : 'Float32' },
  { ArrayType : U32x, ArrayName : 'Wrd32' },
  { ArrayType : I32x, ArrayName : 'Int32' },
  { ArrayType : Array, ArrayName : 'Array' },
]

// if( _.Array )
// debugger;
// if( _.Array )
// return;

_.assert( !_.Array );
_.assert( !_.array );
_.assert( !_.withDefaultLongType );

// debugger;

/**
 * @summary Array namespace
 * @namespace "wModuleForTesting1.array"
 * @memberof wModuleForTesting1
 */

let LongDescriptors = Object.create( null );

_._longDescriptorApplyTo = _longDescriptorApplyTo;

for( let d = 0 ; d < _ArrayNameSpaces.length ; d++ )
_declare( _ArrayNameSpaces[ d ] );

_longDescriptorApplyTo( _,'Array' );

// debugger;

_.assert( !_.Array );

_.assert( _.mapOwnKey( _,'withDefaultLongType' ) );
_.assert( _.mapOwnKey( _,'array' ) );
_.assert( _.mapOwnKey( _.array,'array' ) );
_.assert( !_.mapOwnKey( _.array,'withDefaultLongType' ) );
_.assert( !!_.array.withDefaultLongType );

_.assert( _.objectIs( _.withDefaultLongType ) );
_.assert( _.objectIs( _.array ) );
_.assert( _.routineIs( _.long.longMake ) );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
