(function _fVectorMethods_s_() {

'use strict';

let _ = _global_.wTools;
let _hasLength = _.hasLength;
let _arraySlice = _.longSlice;
let _sqr = _.sqr;
// let __assert = _.assert;
let _assertMapHasOnly = _.assertMapHasOnly;
let _routineIs = _.routineIs;

let _min = Math.min;
let _max = Math.max;
let _sqrt = Math.sqrt;
let _abs = Math.abs;

let accuracy = _.accuracy;
let accuracySqr = _.accuracySqr;

let Parent = null;
let Self = _.Vector;
let vector = _.vector;

// --
// etc
// --

function to( cls )
{
  let self = this;
  let result,array;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.constructorLikeArray( cls ) )
  {
    result = new cls( self.length );
    array = result;
    for( let i = 0 ; i < result.length ; i++ )
    array[ i ] = self.eGet( i );
    return result;
  }
  else if( _.constructorIsVector( cls ) )
  {
    return this;
  }
  else if( _.constructorIsSpace( cls ) )
  {
    return _.Space.makeCol( this )
  }

  _.assert( 0,'unknown class to convert to',_.strType( cls ) );
}

//

function eGet( index )
{
  let self = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  return vector.eGet( self,index );
}

//

function eSet( index,val )
{
  let self = this;
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  return vector.eGet( self,index,val );
}

//

function assign()
{
  let self = this;
  let args = _.longSlice( arguments );
  args.unshift( self );
  return vector.assign.apply( vector,args );
}

//

function copy( src )
{
  let self = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  return vector.assign( self,src );
}

//

// function clone()
// {
//   let self = this;
//   _.assert( arguments.length === 0 );
//   _.assert( _.vectorAdapterIs( self ) );
//   return vector.clone( self );
// }

//

function makeSimilar( length )
{
  let self = this;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  return vector.makeSimilar( self,length );
}

//

function slice( b,e )
{
  let self = this;

  _.assert( arguments.length <= 2 );
  _.assert( _.vectorAdapterIs( self ) );

  return vector.slice( self,b,e );
}

//

function slicedArray( b,e )
{
  let self = this;

  _.assert( arguments.length <= 2 );
  _.assert( _.vectorAdapterIs( self ) );

  return vector.slicedArray( self,b,e );
}

//

function slicedVector( b,e )
{
  let self = this;

  _.assert( arguments.length <= 2 );
  _.assert( _.vectorAdapterIs( self ) );

  return vector.slicedVector( self,b,e );
}

//

function resizedArray( first,last,val )
{
  let self = this;
  _.assert( arguments.length <= 3 );
  let result = vector.resizedArray( self,first,last,val );
  return result;
}

//

function resizedVector( first,last,val )
{
  let self = this;
  _.assert( arguments.length <= 3 );
  let result = vector.resizedVector( self,first,last,val );
  return result;
}

//

function subarray( first,last )
{
  let self = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  return vector.subarray( self,first,last );
}

//

function toArray()
{
  let self = this;

  _.assert( arguments.length === 0 );
  _.assert( _.vectorAdapterIs( self ) );

  return vector.toArray( self );
}

//

function toStr( o )
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.mapIs( o ) || o === undefined );
  _.assert( _.vectorAdapterIs( self ) );

  return vector._toStr( self,o );
}

//

function equalWith( src2, it )
{
  let src1 = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  return vector.equalAre( src2, src1, it );
}

equalWith.takingArguments = 2;
equalWith.takingVectors = 2;
equalWith.takingVectorsOnly = true;
equalWith.returningSelf = false;
equalWith.returningNew = false;
equalWith.modifying = false;

//

function identicalWith( src2, it )
{
  let src1 = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  debugger; xxx
  return vector.identicalAre( src2, src1, it );
}

identicalWith.takingArguments = 2;
identicalWith.takingVectors = 2;
identicalWith.takingVectorsOnly = true;
identicalWith.returningSelf = false;
identicalWith.returningNew = false;
identicalWith.modifying = false;

//

function equivalentWith( src2, it )
{
  let src1 = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  debugger; xxx
  return vector.equivalentAre( src2, src1, it );
}

equivalentWith.takingArguments = [ 2,3 ];
equivalentWith.takingVectors = 2;
equivalentWith.takingVectorsOnly = false;
equivalentWith.returningSelf = false;
equivalentWith.returningNew = false;
equivalentWith.modifying = false;

//

function sameWith( src2 )
{
  let src1 = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( src1._vectorBuffer !== src2._vectorBuffer )
  return false;
  if( src1.offset !== src2.offset )
  return false;
  if( src1.length !== src2.length )
  return false;
  debugger;
  return true;
}

sameWith.takingArguments = [ 2,3 ];
sameWith.takingVectors = 2;
sameWith.takingVectorsOnly = false;
sameWith.returningSelf = false;
sameWith.returningNew = false;
sameWith.modifying = false;

//

function hasShape( src )
{
  if( _.spaceIs( src ) )
  return src.dims.length === 2 && src.dims[ 0 ] === self.length && src.dims[ 1 ] === 1;
  return this.length === src.length;
}

hasShape.takingArguments = 2;
hasShape.takingVectors = 2;
hasShape.takingVectorsOnly = true;
hasShape.returningSelf = false;
hasShape.returningNew = false;
hasShape.modifying = false;

// --
// declare
// --

let Proto =
{

  to : to,

  eGet : eGet,
  eSet : eSet,

  assign : assign,
  copy : copy,

  makeSimilar : makeSimilar,

  slice : slice,
  slicedArray : slicedArray,
  slicedVector : slicedVector,

  resizedArray : resizedArray,
  resizedVector : resizedVector,

  subarray : subarray,

  // toArray : toArray,
  toStr : toStr,

  equalWith : equalWith,
  identicalWith : identicalWith,
  equivalentWith : equivalentWith,
  sameWith : sameWith,

  hasShape : hasShape,

}

_.mapExtend( Self.prototype,Proto );

// --
// declare
// --

function declareSingleArgumentRoutine( routine, r )
{
  let op = routine.operation;

  // if( r === '_equalAre' )
  // debugger;
  //
  // if( r === 'toArray' )
  // debugger;

  let absLike = op.returningOnly === 'self' && op.modifying && op.atomWise && op.homogeneous;
  let reduceToScalarLike = op.returningOnly === 'atomic' && !op.modifying && op.atomWise && op.homogeneous;

  let singleArgument = _.arraysAreIdentical( op.takingArguments, [ 1,1 ] );
  let singleVector = op.takingVectors[ 1 ] === 1;

  let oneOrTwoArguments = _.arraysAreIdentical( op.takingArguments, [ 1,2 ] );
  let oneOrInfinity = _.arraysAreIdentical( op.takingArguments, [ 1,Infinity ] );

  let doesFit = ( singleArgument && singleVector ) || ( absLike && oneOrTwoArguments ) || ( reduceToScalarLike && ( singleArgument || oneOrInfinity ) );

  if( !doesFit )
  return false;

  _.assert( Self.prototype[ r ] === undefined );

  Self.prototype[ r ] = function singleArgumentRoutine()
  {
    _.assert( arguments.length === 0 );
    _.assert( _.vectorAdapterIs( this ) );
    return routine.call( vector,this );
  }

}

//

function declareTwoArgumentsRoutine( routine, r )
{
  let op = routine.operation;

  // if( r === 'mulScalar' )
  // debugger;

  if( !_.arraysAreIdentical( op.takingArguments , [ 2,2 ] ) )
  return false;
  // if( !_.arraysAreIdentical( op.takingVectors , [ 1,1 ] ) )
  if( !_.arraysAreIdentical( op.takingVectors , [ 1,1 ] ) && !_.arraysAreIdentical( op.takingVectors , [ 0,1 ] ) )
  return false;

  _.assert( Self.prototype[ r ] === undefined );

  Self.prototype[ r ] = function scalarRoutine( scalar )
  {
    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assert( _.vectorAdapterIs( this ) );
    return routine.call( vector,this,scalar );
  }

}

//

let routines = _.vector.RoutinesMathematical;
for( let r in routines )
{
  let routine = routines[ r ];

  _.assert( _.routineIs( routine ) );

  declareSingleArgumentRoutine( routine , r );
  declareTwoArgumentsRoutine( routine , r );

}

_.assert( _.routineIs( Self.prototype.mag ) );
_.assert( _.routineIs( Self.prototype.magSqr ) );

_.assert( _.routineIs( Self.prototype.toArray ) );

_.assert( _.routineIs( Self.prototype.abs ) );
_.assert( _.routineIs( Self.prototype.makeSimilar ) );
_.assert( _.routineIs( Self.prototype.assign ) );
_.assert( _.routineIs( Self.prototype.slice ) );

_.assert( _.routineIs( Self.prototype.allZero ) );

})();
