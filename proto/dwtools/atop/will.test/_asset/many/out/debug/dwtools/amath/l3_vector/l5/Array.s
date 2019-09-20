(function _Array_s_() {

'use strict';

let _ = _global_.wTools;
let _row = _.vector;
let _min = Math.min;
let _max = Math.max;
let _arraySlice = Array.prototype.slice;
let _sqrt = Math.sqrt;
let _sqr = _.sqr;

let Parent = null;
let Self = Object.create( null );

// --
// declare
// --

let Proto =
{
}

_.accessor.forbid
({
  object : Self,
  names : _.vector.Forbidden,
});

// --
// row wrap
// --

let routines = _row.RoutinesMathematical;
for( let r in routines )
{

  if( Self[ r ] )
  {
    debugger;
    continue;
  }

  function onReturn( result,theRoutine )
  {
    let op = theRoutine.operation;

    if( op.returningAtomic && _.primitiveIs( result ) )
    {
      return result;
    }
    else if( op.returningSelf )
    {
      return result.toArray();
    }
    else if( op.returningNew && _.vectorIs( result ) )
    {
      return result.toArray();
    }
    else if( op.returningArray )
    {
      _.assert( _.arrayIs( result ) || _.bufferTypedIs( result ),'unexpected' );
      return result;
    }
    else return result;
  }

  Proto[ r ] = _.vector.withWrapper
  ({
    routine : routines[ r ],
    onReturn : onReturn,
    usingThisAsFirstArgument : 0,
  });

}

// --
// declare extension
// --

Object.setPrototypeOf( Self,wTools );

_.mapExtend( Self,Proto );

_.avector = Self;

_._arrayNameSpaceApplyTo( Self,'Float32' );
_.assert( _.mapOwnKey( _.avector,'withArray' ) );
_.assert( _.objectIs( _.avector.withArray ) );
_.assert( _.objectIs( _.avector.withArray.Array ) );
_.assert( _.objectIs( _.avector.withArray.Float32 ) );

_.assert( Object.getPrototypeOf( Self ) === wTools );
_.assert( _.objectIs( _row.RoutinesMathematical ) );
_.assert( !_.avector.isValid );
_.assert( _.routineIs( _.avector.allFinite ) );

})();
