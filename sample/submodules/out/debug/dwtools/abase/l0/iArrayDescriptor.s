(function _kArrayDescriptor_s_() {

'use strict';

let _global = _global_;
let _ = _global.wTools;
let Self = _global.wTools;

_.assert( !_.Array );
_.assert( !_.array );
_.assert( !_.withArray );

//

function _arrayNameSpaceApplyTo( dst,def )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( !_.mapOwnKey( dst,'withArray' ) );
  _.assert( !_.mapOwnKey( dst,'array' ) );
  _.assert( !!ArrayNameSpaces[ def ] );

  dst.withArray = Object.create( null );

  for( let d in ArrayNameSpaces )
  {
    dst.withArray[ d ] = Object.create( dst );
    _.mapExtend( dst.withArray[ d ], ArrayNameSpaces[ d ] );
  }

  dst.array = dst.withArray[ def ];
  dst.ArrayNameSpaces = ArrayNameSpaces;

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

function makeSimilar( src,length )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  let result = _.longMake( src,length );

  return result;
}

//

function makeArrayOfLength( length )
{

  if( length === undefined )
  length = 0;

  _.assert( length === undefined || length >= 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  let result = new this.array.ArrayType( length );

  return result;
}

//

function makeArrayOfLengthZeroed( length )
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

  makeSimilar : makeSimilar,
  makeArrayOfLength : makeArrayOfLength,
  makeArrayOfLengthZeroed : makeArrayOfLengthZeroed,

  arrayFrom : arrayFromCoercing,
  arrayFromCoercing : arrayFromCoercing,

  array : nameSpace,

}

_.mapExtend( nameSpace, Extend );
_.assert( !ArrayNameSpaces[ ArrayName ] );

ArrayNameSpaces[ ArrayName ] = nameSpace;

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

Object.assign( wTools, Extend );

// --
//
// --

let _ArrayNameSpaces =
[
  { ArrayType : Float32Array, ArrayName : 'Float32' },
  { ArrayType : Uint32Array, ArrayName : 'Wrd32' },
  { ArrayType : Int32Array, ArrayName : 'Int32' },
  { ArrayType : Array, ArrayName : 'Array' },
]

// if( _.Array )
// debugger;
// if( _.Array )
// return;

_.assert( !_.Array );
_.assert( !_.array );
_.assert( !_.withArray );

// debugger;

let ArrayNameSpaces = Object.create( null );

_._arrayNameSpaceApplyTo = _arrayNameSpaceApplyTo;

for( let d = 0 ; d < _ArrayNameSpaces.length ; d++ )
_declare( _ArrayNameSpaces[ d ] );

_arrayNameSpaceApplyTo( _,'Array' );

// debugger;

_.assert( !_.Array );

_.assert( _.mapOwnKey( _,'withArray' ) );
_.assert( _.mapOwnKey( _,'array' ) );
_.assert( _.mapOwnKey( _.array,'array' ) );
_.assert( !_.mapOwnKey( _.array,'withArray' ) );
_.assert( !!_.array.withArray );

_.assert( _.objectIs( _.withArray ) );
_.assert( _.objectIs( _.array ) );
_.assert( _.routineIs( _.array.makeArrayOfLength ) );

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
