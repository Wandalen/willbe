( function _gRoutine_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

// --
// routine
// --

// /**
//  * Return function that will call passed routine function with delay.
//  * @param {number} delay delay in milliseconds
//  * @param {Function} routine function that will be called with delay.
//  * @returns {Function} result function
//  * @throws {Error} If arguments less then 2
//  * @throws {Error} If `delay` is not a number
//  * @throws {Error} If `routine` is not a function
//  * @function routineDelayed
//  * @memberof wTools
//  */
//
// function routineDelayed( delay, routine )
// {
//
//   _.assert( arguments.length >= 2, 'Expects at least two arguments' );
//   _.assert( _.numberIs( delay ) );
//   _.assert( _.routineIs( routine ) );
//
//   if( arguments.length > 2 )
//   {
//     _.assert( arguments.length <= 4 );
//     routine = _.routineJoin.call( _, arguments[ 1 ], arguments[ 2 ], arguments[ 3 ] );
//   }
//
//   return function delayed()
//   {
//     _.timeOut( delay, this, routine, arguments );
//   }
//
// }
//
// //
//
// function routineCall( context, routine, args )
// {
//   let result;
//
//   _.assert( 1 <= arguments.length && arguments.length <= 3 );
//
//   /* */
//
//   if( arguments.length === 1 )
//   {
//     let routine = arguments[ 0 ];
//     result = routine();
//   }
//   else if( arguments.length === 2 )
//   {
//     let context = arguments[ 0 ];
//     let routine = arguments[ 1 ];
//     result = routine.call( context );
//   }
//   else if( arguments.length === 3 )
//   {
//     let context = arguments[ 0 ];
//     let routine = arguments[ 1 ];
//     let args = arguments[ 2 ];
//     _.assert( _.longIs( args ) );
//     result = routine.apply( context, args );
//   }
//   else _.assert( 0, 'unexpected' );
//
//   return result;
// }
//
// //
//
// function routineTolerantCall( context, routine, options )
// {
//
//   _.assert( arguments.length === 3, 'Expects exactly three arguments' );
//   _.assert( _.routineIs( routine ) );
//   _.assert( _.objectIs( routine.defaults ) );
//   _.assert( _.objectIs( options ) );
//
//   options = _.mapOnly( options, routine.defaults );
//   let result = routine.call( context, options );
//
//   return result;
// }
//
// //
//
// function routinesJoin()
// {
//   let result, routines, index;
//   let args = _.longSlice( arguments );
//
//   _.assert( arguments.length >= 1 && arguments.length <= 3  );
//
//   /* */
//
//   function makeResult()
//   {
//
//     _.assert( _.objectIs( routines ) || _.arrayIs( routines ) || _.routineIs( routines ) );
//
//     if( _.routineIs( routines ) )
//     routines = [ routines ];
//
//     result = _.entityMake( routines );
//
//   }
//
//   /* */
//
//   if( arguments.length === 1 )
//   {
//     routines = arguments[ 0 ];
//     index = 0;
//     makeResult();
//   }
//   else if( arguments.length === 2 )
//   {
//     routines = arguments[ 1 ];
//     index = 1;
//     makeResult();
//   }
//   else if( arguments.length === 3 )
//   {
//     routines = arguments[ 1 ];
//     index = 1;
//     makeResult();
//   }
//   else _.assert( 0, 'unexpected' );
//
//   /* */
//
//   if( _.arrayIs( routines ) )
//   for( let r = 0 ; r < routines.length ; r++ )
//   {
//     args[ index ] = routines[ r ];
//     result[ r ] = _.routineJoin.apply( this, args );
//   }
//   else
//   for( let r in routines )
//   {
//     args[ index ] = routines[ r ];
//     result[ r ] = _.routineJoin.apply( this, args );
//   }
//
//   /* */
//
//   return result;
// }
//
// //
//
// function _routinesCall( o )
// {
//   let result, context, routines, args;
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( o.args.length >= 1 && o.args.length <= 3 );
//
//   /* */
//
//   if( o.args.length === 1 )
//   {
//     routines = o.args[ 0 ];
//
//     makeResult();
//
//     if( _.arrayIs( routines ) )
//     for( let r = 0 ; r < routines.length ; r++ )
//     {
//       result[ r ] = routines[ r ]();
//       if( o.whileTrue && result[ r ] === false )
//       {
//         result = false;
//         break;
//       }
//     }
//     else
//     for( let r in routines )
//     {
//       result[ r ] = routines[ r ]();
//       if( o.whileTrue && result[ r ] === false )
//       {
//         result = false;
//         break;
//       }
//     }
//
//   }
//   else if( o.args.length === 2 )
//   {
//     context = o.args[ 0 ];
//     routines = o.args[ 1 ];
//
//     makeResult();
//
//     if( _.arrayIs( routines ) )
//     for( let r = 0 ; r < routines.length ; r++ )
//     {
//       result[ r ] = routines[ r ].call( context );
//       if( o.whileTrue && result[ r ] === false )
//       {
//         result = false;
//         break;
//       }
//     }
//     else
//     for( let r in routines )
//     {
//       result[ r ] = routines[ r ].call( context );
//       if( o.whileTrue && result[ r ] === false )
//       {
//         result = false;
//         break;
//       }
//     }
//
//   }
//   else if( o.args.length === 3 )
//   {
//     context = o.args[ 0 ];
//     routines = o.args[ 1 ];
//     args = o.args[ 2 ];
//
//     _.assert( _.longIs( args ) );
//
//     makeResult();
//
//     if( _.arrayIs( routines ) )
//     for( let r = 0 ; r < routines.length ; r++ )
//     {
//       result[ r ] = routines[ r ].apply( context, args );
//       if( o.whileTrue && result[ r ] === false )
//       {
//         result = false;
//         break;
//       }
//     }
//     else
//     for( let r in routines )
//     {
//       result[ r ] = routines[ r ].apply( context, args );
//       if( o.whileTrue && result[ r ] === false )
//       {
//         result = false;
//         break;
//       }
//     }
//
//   }
//   else _.assert( 0, 'unexpected' );
//
//   return result;
//
//   /* */
//
//   function makeResult()
//   {
//
//     _.assert
//     (
//       _.objectIs( routines ) || _.arrayIs( routines ) || _.routineIs( routines ),
//       'Expects object, array or routine (-routines-), but got', _.strType( routines )
//     );
//
//     if( _.routineIs( routines ) )
//     routines = [ routines ];
//
//     result = _.entityMake( routines );
//
//   }
//
// }
//
// _routinesCall.defaults =
// {
//   args : null,
//   whileTrue : 0,
// }
//
// //
//
// /**
//  * Call each routines in array with passed context and arguments.
//     The context and arguments are same for each called functions.
//     Can accept only routines without context and args.
//     Can accept single routine instead array.
//  * @example
//     let x = 2, y = 3,
//         o { z : 6 };
//
//     function sum( x, y )
//     {
//         return x + y + this.z;
//     },
//     prod = function( x, y )
//     {
//         return x * y * this.z;
//     },
//     routines = [ sum, prod ];
//     let res = wTools.routinesCall( o, routines, [ x, y ] );
//  // [ 11, 36 ]
//  * @param {Object} [context] Context in which calls each function.
//  * @param {Function[]} routines Array of called function
//  * @param {Array<*>} [args] Arguments that will be passed to each functions.
//  * @returns {Array<*>} Array with results of functions invocation.
//  * @function routinesCall
//  * @memberof wTools
//  */
//
// function routinesCall()
// {
//   let result;
//
//   result = _routinesCall
//   ({
//     args : arguments,
//     whileTrue : 0,
//   });
//
//   return result;
// }
//
// //
//
// function routinesCallEvery()
// {
//   let result;
//
//   result = _routinesCall
//   ({
//     args : arguments,
//     whileTrue : 1,
//   });
//
//   return result;
// }
//
// //
//
// function methodsCall( contexts, methods, args )
// {
//   let result = [];
//
//   if( args === undefined )
//   args = [];
//
//   let isContextsArray = _.longIs( contexts );
//   let isMethodsArray = _.longIs( methods );
//   let l1 = isContextsArray ? contexts.length : 1;
//   let l2 = isMethodsArray ? methods.length : 1;
//   let l = Math.max( l1, l2 );
//
//   _.assert( l >= 0 );
//   _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
//
//   if( !l )
//   return result;
//
//   let contextGet;
//   if( isContextsArray )
//   contextGet = ( i ) => contexts[ i ];
//   else
//   contextGet = ( i ) => contexts;
//
//   let methodGet;
//   if( isMethodsArray )
//   methodGet = ( i ) => methods[ i ];
//   else
//   methodGet = ( i ) => methods;
//
//   for( let i = 0 ; i < l ; i++ )
//   {
//     let context = contextGet( i );
//     let routine = context[ methodGet( i ) ];
//     _.assert( _.routineIs( routine ) );
//     result[ i ] = routine.apply( context, args )
//   }
//
//   return result;
// }

//

function _routinesComposeWithSingleArgument_pre( routine, args )
{
  let o = _.routinesCompose.pre.call( this, routine, args );

  _.assert( args.length === 1 );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  return o;
}

//

function routinesComposeReturningLast()
{
  let o = _.routinesComposeReturningLast.pre( routinesComposeReturningLast, arguments );
  let result = _.routinesComposeReturningLast.body( o );
  return result;
}

routinesComposeReturningLast.pre = _.routinesCompose.pre;
routinesComposeReturningLast.body = _.routinesCompose.body;
routinesComposeReturningLast.defaults = Object.create( _.routinesCompose.defaults );

routinesComposeReturningLast.defaults.supervisor = _.compose.supervisor.returningLast;

function routinesComposeAll()
{
  let o = _.routinesComposeAll.pre( routinesComposeAll, arguments );
  let result = _.routinesComposeAll.body( o );
  return result;
}

routinesComposeAll.pre = _routinesComposeWithSingleArgument_pre;
routinesComposeAll.body = _.routinesCompose.body;

var defaults = routinesComposeAll.defaults = Object.create( _.routinesCompose.defaults );
defaults.chainer = _.compose.chainer.composeAll;
defaults.supervisor = _.compose.supervisor.composeAll;

_.assert( _.routineIs( _.compose.chainer.originalWithDont ) );
_.assert( _.routineIs( _.compose.supervisor.composeAll ) );

//

function routinesComposeAllReturningLast()
{
  let o = _.routinesComposeAllReturningLast.pre( routinesComposeAllReturningLast, arguments );
  let result = _.routinesComposeAllReturningLast.body( o );
  return result;
}

routinesComposeAllReturningLast.pre = _routinesComposeWithSingleArgument_pre;
routinesComposeAllReturningLast.body = _.routinesCompose.body;

var defaults = routinesComposeAllReturningLast.defaults = Object.create( _.routinesCompose.defaults );
defaults.chainer = _.compose.chainer.originalWithDont;
defaults.supervisor = _.compose.supervisor.returningLast;

//

function routinesChain()
{
  let o = _.routinesChain.pre( routinesChain, arguments );
  let result = _.routinesChain.body( o );
  return result;
}

routinesChain.pre = _routinesComposeWithSingleArgument_pre;
routinesChain.body = _.routinesCompose.body;

var defaults = routinesChain.defaults = Object.create( _.routinesCompose.defaults );
defaults.chainer = _.compose.chainer.chaining;
defaults.supervisor = _.compose.supervisor.chaining;

//

function _equalizerFromMapper( mapper )
{

  if( mapper === undefined )
  mapper = function mapper( a, b ){ return a === b };

  _.assert( 0, 'not tested' )
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( mapper.length === 1 || mapper.length === 2 );

  if( mapper.length === 1 )
  {
    let equalizer = function equalizerFromMapper( a, b )
    {
      return mapper( a ) === mapper( b );
    }
    return equalizer;
  }

  return mapper;
}

//

function _comparatorFromEvaluator( evaluator )
{

  if( evaluator === undefined )
  evaluator = function comparator( a, b ){ return a-b };

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( evaluator.length === 1 || evaluator.length === 2 );

  if( evaluator.length === 1 )
  {
    let comparator = function comparatorFromEvaluator( a, b )
    {
      return evaluator( a ) - evaluator( b );
    }
    return comparator;
  }

  return evaluator;
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

  // routineDelayed,
  //
  // routineCall,
  // routineTolerantCall,
  //
  // routinesJoin,
  // _routinesCall,
  // routinesCall,
  // routinesCallEvery,
  // methodsCall,

  // routinesCompose,
  routinesComposeReturningLast,
  routinesComposeAll,
  routinesComposeAllReturningLast, /* ??? */
  routinesChain,

  _equalizerFromMapper,
  _comparatorFromEvaluator,

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
