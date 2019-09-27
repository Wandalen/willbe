(function _Main_s_() {

'use strict';

/**
 * Collection of functions for vector math. MathVector introduces missing in JavaScript type VectorImage. VectorImage is a reference, it does not contain data but only refer on actual ( aka Long ) container of lined data. VectorImage could have offset, length and stride what makes look original container differently. Length of VectorImage is not necessarily equal to the length of the original container, siblings elements of VectorImage is not necessarily sibling in the original container, so storage format of vectors does not make a big difference for math algorithms. MathVector implements functions for the VectorImage and mirrors them for Array/Buffer. Use MathVector to be more functional with math and less constrained with storage format.
  @module Tools/math/Vector
*/

/**
 * @file vector/Main.s.
 */

/**
 *@summary Collection of functions for vector math
  @namespace "wTools.vector"
  @memberof module:Tools/math/Vector
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wProto' );
  _.include( 'wEqualer' )
  _.include( 'wMathScalar' )

}

let _ = _global_.wTools;
let _hasLength = _.hasLength;
let _min = Math.min;
let _max = Math.max;
let _arraySlice = _.longSlice;
let _sqrt = Math.sqrt;
let _abs = Math.abs;
let _sqr = _.sqr;
// let __assert = _.assert;
let _assertMapHasOnly = _.assertMapHasOnly;
let _routineIs = _.routineIs;

// debugger;
//
// if( _.accuracy === undefined )
// _.accuracy = 1e-7;
//
// if( _.accuracySqr === undefined )
// _.accuracySqr = 1e-15;

let Parent = null;
let Self = Object.create( null );

function Vector(){ throw _.err( 'should not be called' ) };
Vector.prototype = Object.create( null );
Vector.prototype._vectorBuffer = null;

// --
// from
// --

/**
* @summary Creates vector from array of length `length`.
* @param {Number} length Length of array.
*
* @example
* var vec = wTools.vector.makeArrayOfLength( 3 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function makeArrayOfLength
* @memberof module:Tools/math/Vector.wTools.vector
*/

function makeArrayOfLength( length )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let srcArray = new this.ArrayType( length );
  return fromArray( srcArray );
}

/**
* @summary Creates vector from array of length `length` and fills it with element `value`.
* @param {Number} length Length of array.
* @param {} value Element for fill operation.
*
* @example
* var vec = wTools.vector.makeArrayOfLengthWithValue( 3,0 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function makeArrayOfLengthWithValue
* @memberof module:Tools/math/Vector.wTools.vector
*/

function makeArrayOfLengthWithValue( length,value )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let srcArray = new this.ArrayType( length );
  for( let i = 0 ; i < length ; i++ )
  srcArray[ i ] = value;
  return fromArray( srcArray );
}

// --
// from
// --

function VectorFromNumber() {};
VectorFromNumber.prototype =
{
  eGet : function( index ){ return this._vectorBuffer[ 0 ]; },
  eSet : function( index,src ){ this._vectorBuffer[ 0 ] = src; },
  constructor : VectorFromNumber,
}

Object.setPrototypeOf( VectorFromNumber.prototype,Vector.prototype );

_.propertyConstant( VectorFromNumber.prototype,
{
  offset : 0,
  stride : 0,
});

/**
* @summary Creates vector of length `length` from value of `number`.
* @param {Number|Array} number Source number, vector or array.
* @param {Number} length Length of new vector.
*
* @example
* var vec = wTools.vector.fromMaybeNumber( 3,1 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function fromMaybeNumber
* @memberof module:Tools/math/Vector.wTools.vector
*/

function fromMaybeNumber( number,length )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( length >= 0 );

  let numberIs = _.numberIs( number );

  _.assert( numberIs || _.longIs( number ) || _.vectorIs( number ) );

  if( !numberIs )
  {
    _.assert( number.length === length );
    return this.fromArray( number );
  }

  let result = new VectorFromNumber();
  result._vectorBuffer = [ number ];
  _.propertyConstant( result,{ length : length } );

  return result;
}

//


/**
* @summary Creates vector from entity `srcArray`.
* @param {Array} srcArray Source array, vector, space.
*
* @example
* var srcArray = [ 1, 2, 3 ];
* var vec = wTools.vector.from( srcArray );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function from
* @memberof module:Tools/math/Vector.wTools.vector
*/

function from( srcArray )
{

  _.assert( arguments.length === 1,'from expects single arguments { srcArray }' );

  if( _.vectorIs( srcArray ) )
  return srcArray;
  else if( _.longIs( srcArray ) )
  return fromArray( srcArray );
  else if( _.spaceIs( srcArray ) )
  {
    _.assert( srcArray.dims.length === 2 );
    _.assert( srcArray.dims[ 0 ] === 1 || srcArray.dims[ 1 ] === 1 );
    if( srcArray.dims[ 0 ] === 1 )
    return srcArray.rowVectorGet( 0 );
    else
    return srcArray.colVectorGet( 0 );
  }
  else _.assert( 0,'cant make Vector from',_.strType( srcArray ) );

}

//

function VectorFromArray(){};
VectorFromArray.prototype =
{
  '_lengthGet' : function(){ return this._vectorBuffer.length; },
  eGet : function( index ){ return this._vectorBuffer[ index ]; },
  eSet : function( index,src ){ this._vectorBuffer[ index ] = src; },
  constructor : VectorFromArray,
}

Object.setPrototypeOf( VectorFromArray.prototype,Vector.prototype );

_.accessor.readOnly
({
  object : VectorFromArray.prototype,
  prime : 0,
  names :
  {
    length : 'length',
  },
});

_.propertyConstant( VectorFromArray.prototype,
{
  offset : 0,
  stride : 1,
});

/**
* @summary Creates vector from source array `srcArray`.
* @param {Array} srcArray Source array or vector.
*
* @example
* var srcArray = [ 1, 2, 3 ];
* var vec = wTools.vector.fromArray( srcArray );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function fromArray
* @memberof module:Tools/math/Vector.wTools.vector
*/

function fromArray( srcArray )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.vectorIs( srcArray ) || _.longIs( srcArray ) );

  if( srcArray._vectorBuffer )
  return srcArray;

  let result = new VectorFromArray();
  result._vectorBuffer = srcArray;

  Object.freeze( result );
  return result;
}

//

function VectorSub(){};
VectorSub.prototype =
{
  eGet : function( index )
  {
    _.assert( index < this.length );
    return this._vectorBuffer[ this.offset+index ];
  },
  eSet : function( index,src )
  {
    _.assert( index < this.length );
    this._vectorBuffer[ this.offset+index ] = src;
  },
  constructor : VectorSub,
}

Object.setPrototypeOf( VectorSub.prototype, Vector.prototype );

_.propertyConstant( VectorSub.prototype,
{
  stride : 1,
});

/**
* @summary Creates vector from part of source array `srcArray`.
* @param {Array} srcArray Source array.
* @param {Array} offset Offset to sub array in source array `srcArray`.
* @param {Array} length Length of new vector.
*
* @example
* var srcArray = [ 1, 2, 3 ];
* var vec = wTools.vector.fromSubArray( srcArray, 0, 2 );
* console.log( 'vec: ', vec );
* console.log( 'vec.toStr(): ', vec.toStr() );
*
* @function fromSubArray
* @memberof module:Tools/math/Vector.wTools.vector
*/

function fromSubArray( srcArray,offset,length )
{

  if( offset === undefined )
  offset = 0;

  if( length === undefined )
  length = srcArray.length-offset;

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( !!srcArray );
  _.assert( offset+length <= srcArray.length );

  if( srcArray._vectorBuffer )
  {

    if( srcArray.offset )
    offset = srcArray.offset + offset*( srcArray.stride || 1 );

    length = _min( length,srcArray.length );

    if( srcArray.stride )
    return fromSubArrayWithStride( srcArray._vectorBuffer,offset,length,srcArray.stride );

    srcArray = srcArray._vectorBuffer;

  }

  let result = new VectorSub();
  result._vectorBuffer = srcArray;
  result.length = length;
  result.offset = offset;

  Object.freeze( result );
  return result;
}

//

function VectorSubArrayWithStride(){};
VectorSubArrayWithStride.prototype =
{
  eGet : function( index )
  {
    let i = this.offset+index*this.stride;
    _.assert( index < this.length );
    _.assert( i < this._vectorBuffer.length );
    return this._vectorBuffer[ i ];
  },
  eSet : function( index,src )
  {
    let i = this.offset+index*this.stride;
    _.assert( index < this.length );
    _.assert( i < this._vectorBuffer.length );
    this._vectorBuffer[ i ] = src;
  },
  constructor : VectorSubArrayWithStride,
}

Object.setPrototypeOf( VectorSubArrayWithStride.prototype,Vector.prototype );

function fromSubArrayWithStride( srcArray,offset,length,stride )
{

  _.assert( arguments.length === 4 );
  _.assert( 0 <= stride );
  _.assert( _.numberIs( offset ) );
  _.assert( _.numberIs( length ) );
  _.assert( offset+(length-1)*stride < srcArray.length );

  if( stride === 1 )
  return fromSubArray( srcArray,offset,length );

  if( srcArray._vectorBuffer )
  {
    throw _.err( 'not implemented' );
  }

  let result = new VectorSubArrayWithStride();
  result._vectorBuffer = srcArray;
  result.length = length;
  result.offset = offset;
  result.stride = stride;

  Object.freeze( result );
  return result;
}

//

function fromArrayWithStride( srcArray,stride )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  return this.fromSubArrayWithStride( srcArray,0,Math.ceil( srcArray.length / stride ),stride );
}

//

function variants( variants )
{
  let result = _.longSlice( variants );
  let length;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.longIs( variants );

  /* */

  for( let v = 0 ; v < result.length ; v++ )
  {
    let variant = result[ v ];

    _.assert( _.numberIs( variant ) || _.longIs( variant ) || _.vectorIs( variant ) );

    if( _.numberIs( variant ) )
    continue;

    if( length !== undefined )
    _.assert( variant.length === length,'all variants should have same length' );

    length = variant.length;

  }

  if( length === undefined )
  length = 1;

  /* */

  for( let v = 0 ; v < result.length ; v++ )
  {
    let variant = result[ v ];

    if( _.vectorIs( variant ) )
    continue;

    if( _.longIs( variant ) )
    variant = result[ v ] = _.vector.fromArray( variant );
    else
    variant = result[ v ] = _.vector.fromMaybeNumber( variant,length );

  }

  /* */

  return result;
}

//

function withWrapper( o )
{

  o = _.routineOptions( withWrapper, arguments );

  // if( o.routine.name === '_equalAre' )
  // debugger;

  if( _.objectIs( o.routine ) )
  {
    let result = Object.create( null );
    for( let r in o.routine )
    {
      let optionsForWrapper = _.mapExtend( null,o );
      optionsForWrapper.routine = o.routine[ r ];
      result[ r ] = withWrapper( optionsForWrapper );
    }
    return result;
  }

  let op = o.routine.operation;

  /* if routine does not take vector than this is not used at all */

  if( op.takingVectors && op.takingVectors[ 1 ] === 0 )
  o.usingThisAsFirstArgument = 0;

  /* */

  let onReturn = o.onReturn;
  let usingThisAsFirstArgument = o.usingThisAsFirstArgument ? 1 : 0;
  let theRoutine = o.routine;

  let takingArguments = op.takingArguments;
  let takingVectors = op.takingVectors;
  let takingVectorsOnly = op.takingVectorsOnly;
  let returningSelf = op.returningSelf;
  let returningNew = op.returningNew;
  let returningArray = op.returningArray;
  let modifying = op.modifying;
  let notMethod = op.notMethod;

  /* verification */

  _.assert( _.mapIs( op ) );
  _.assert( _.routineIs( theRoutine ) );
  _.assert( _.numberIs( takingArguments ) || _.arrayIs( takingArguments ) );
  _.assert( _.numberIs( takingVectors ) || _.arrayIs( takingVectors ) );
  _.assert( _.boolIs( takingVectorsOnly ) );
  _.assert( _.boolIs( returningSelf ) );
  _.assert( _.boolIs( returningNew ) );
  _.assert( _.boolIs( returningArray ) );
  _.assert( _.boolIs( modifying ) );

  _.assert( _.routineIs( onReturn ) );
  _.assert( _.routineIs( theRoutine ) );

  /* adjust */

  if( _.numberIs( takingArguments ) ) takingArguments = Object.freeze([ takingArguments,takingArguments ]);
  else takingArguments = Object.freeze( takingArguments.slice() );

  if( _.numberIs( takingVectors ) )
  takingVectors = Object.freeze([ takingVectors,takingVectors ]);
  else
  takingVectors = Object.freeze( takingVectors.slice() );
  let hasOptionalVectors = takingVectors[ 0 ] !== takingVectors[ 1 ];

  /* */

  function makeVector( arg )
  {
    if( _routineIs( arg ) )
    return arg;

    // if( _hasLength( arg ) && ( !_.Space || !( arg instanceof _.Space ) ) )
    if( _.longIs( arg ) )
    return Self.fromArray( arg );
    return arg;
  }

  /* */

  function vectorWrap()
  {
    let l = arguments.length + usingThisAsFirstArgument;
    let args = new Array( l );

    _.assert( takingArguments[ 0 ] <= l && l <= takingArguments[ 1 ] );

    let s = 0;
    let d = 0;
    if( usingThisAsFirstArgument )
    {
      args[ d ] = this;
      d += 1;
    }

    for( ; d < takingVectors[ 0 ] ; d++, s++ )
    {
      args[ d ] = makeVector( arguments[ s ] );
      _.assert( _.vectorIs( args[ d ] ) || ( d === 0 && returningNew ) );
    }

    let optionalLength;
    if( hasOptionalVectors )
    {
      optionalLength = _min( takingVectors[ 1 ],l );
      for( ; d < optionalLength ; d++, s++ )
      args[ d ] = makeVector( arguments[ s ] );
    }

    optionalLength = _min( takingArguments[ 1 ],l );
    for( ; d < optionalLength ; d++, s++ )
    args[ d ] = arguments[ s ];

    let result = theRoutine.apply( Self,args );

    return onReturn.call( this,result,theRoutine );
  }

  vectorWrap.notMethod = notMethod;
  vectorWrap.operation = op;

  return vectorWrap;
}

withWrapper.defaults =
{
  usingThisAsFirstArgument : null,
  routine : null,
  onReturn : null,
}

// --
// from
// --

let routineFrom =
{

  makeArrayOfLength : makeArrayOfLength,
  makeArrayOfLengthWithValue : makeArrayOfLengthWithValue,

  fromMaybeNumber : fromMaybeNumber,
  from : from,
  fromArray : fromArray,
  fromSubArray : fromSubArray,
  fromSubArrayWithStride : fromSubArrayWithStride,
  fromArrayWithStride : fromArrayWithStride,

  variants : variants,

  withWrapper : withWrapper,

}

// --
// declare
// --

let Proto =
{


  _routineFrom : routineFrom,

}

_.mapExtend( Proto,routineFrom );
_.mapExtend( Self,Proto );

Object.setPrototypeOf( Self,wTools );
Self.constructor = function Vector(){};

_.vector = Self;
_.Vector = Vector;

_.assert( _.routineIs( Self.withWrapper ) );
_.assert( _.objectIs( Self.array ) );
_.assert( _.routineIs( Self.array.arrayFromCoercing ) );
_.assert( _.routineIs( Self.array.makeArrayOfLength ) );

_.assert( _.numberIs( _.accuracy ) );
_.assert( _.numberIs( _.accuracySqr ) );

//

if( typeof module !== 'undefined' )
{
  require( './l1/Operations.s' );
  require( './l3/Routines.s' );
  require( './l5/Array.s' );
  require( './l5/Methods.s' );
}

})();
