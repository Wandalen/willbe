( function _gTime_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools.time = _global_.wTools.time || Object.create( null );

// --
// implementation
// --

function ready( timeOut, procedure, onReady )
{

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );

  if( _.numberIs( arguments[ 0 ] ) )
  {
    timeOut = arguments[ 0 ];
    if( !_.procedureIs( arguments[ 1 ] ) )
    {
      onReady = arguments[ 1 ];
      procedure = undefined;
    }
  }
  else if( _.procedureIs( arguments[ 0 ] ) )
  {
    procedure = arguments[ 0 ];
    onReady = arguments[ 1 ];
    timeOut = undefined;
  }
  else
  {
    onReady = arguments[ 0 ];
    procedure = undefined;
    timeOut = undefined;
  }

  if( !timeOut )
  timeOut = 0;

  if( !procedure )
  procedure = _.Procedure({ _stack : 1, _name : 'timeReady' });

  _.assert( _.procedureIs( procedure ) );
  _.assert( _.intIs( timeOut ) );
  _.assert( _.routineIs( onReady ) || onReady === undefined );

  if( typeof window !== 'undefined' && typeof document !== 'undefined' && document.readyState != 'complete' )
  {
    let con = _.Consequence ? new _.Consequence({ tag : 'timeReady' }) : null;

    function handleReady()
    {
      if( _.Consequence )
      return _.time.out( timeOut, procedure, onReady ).finally( con );
      else if( onReady )
      _.time.begin( timeOut, procedure, onReady );
      else _.assert( 0 );
    }

    window.addEventListener( 'load', handleReady );
    return con;
  }
  else
  {
    if( _.Consequence )
    return _.time.out( timeOut, procedure, onReady );
    else if( onReady )
    _.time.begin( timeOut, procedure, onReady );
    else _.assert( 0 );
  }

}

//

function readyJoin( context, routine, args )
{
  let joinedRoutine = _.routineJoin( context, routine, args );
  return _timeReady;
  function _timeReady()
  {
    let args = arguments;
    let procedure = _.Procedure({ _stack : 1, _name : 'timeReadyJoin' });
    let joinedRoutine2 = _.routineSeal( this, joinedRoutine, args );
    return _.time.ready( procedure, joinedRoutine2 );
  }
}

//

/**
 * Routine creates timer that executes provided routine( onReady ) after some amout of time( delay ).
 * Returns wConsequence instance. {@link module:Tools/base/Consequence.wConsequence wConsequence}
 *
 * If ( onReady ) is not provided, time.out returns consequence that gives empty message after ( delay ).
 * If ( onReady ) is a routine, time.out returns consequence that gives message with value returned or error throwed by ( onReady ).
 * If ( onReady ) is a consequence or routine that returns it, time.out returns consequence and waits until consequence from ( onReady ) resolves the message, then
 * time.out gives that resolved message throught own consequence.
 * If ( delay ) <= 0 time.out performs all operations on nextTick in node
 * @see {@link https://nodejs.org/en/docs/guides/event-loop-timers-and-nexttick/#the-node-js-event-loop-timers-and-process-nexttick }
 * or after 1 ms delay in browser.
 * Returned consequence controls the timer. Timer can be easly stopped by giving an error from than consequence( see examples below ).
 * Important - Error that stops timer is returned back as regular message inside consequence returned by time.out.
 * Also time.out can run routine with different context and arguments( see example below ).
 *
 * @param {Number} delay - Delay in ms before ( onReady ) is fired.
 * @param {Function|wConsequence} onReady - Routine that will be executed with delay.
 *
 * @example
 * // simplest, just timer
 * let t = _.time.out( 1000 );
 * t.give( () => console.log( 'Message with 1000ms delay' ) )
 * console.log( 'Normal message' )
 *
 * @example
 * // run routine with delay
 * let routine = () => console.log( 'Message with 1000ms delay' );
 * let t = _.time.out( 1000, routine );
 * t.give( () => console.log( 'Routine finished work' ) );
 * console.log( 'Normal message' )
 *
 * @example
 * // routine returns consequence
 * let routine = () => new _.Consequence().take( 'msg' );
 * let t = _.time.out( 1000, routine );
 * t.give( ( err, got ) => console.log( 'Message from routine : ', got ) );
 * console.log( 'Normal message' )
 *
 * @example
 * // time.out waits for long time routine
 * let routine = () => _.time.out( 1500, () => 'work done' ) ;
 * let t = _.time.out( 1000, routine );
 * t.give( ( err, got ) => console.log( 'Message from routine : ', got ) );
 * console.log( 'Normal message' )
 *
 * @example
 * // how to stop timer
 * let routine = () => console.log( 'This message never appears' );
 * let t = _.time.out( 5000, routine );
 * t.error( 'stop' );
 * t.give( ( err, got ) => console.log( 'Error returned as regular message : ', got ) );
 * console.log( 'Normal message' )
 *
 * @example
 * // running routine with different context and arguments
 * function routine( y )
 * {
 *   let self = this;
 *   return self.x * y;
 * }
 * let context = { x : 5 };
 * let arguments = [ 6 ];
 * let t = _.time.out( 100, context, routine, arguments );
 * t.give( ( err, got ) => console.log( 'Result of routine execution : ', got ) );
 *
 * @returns {wConsequence} Returns wConsequence instance that resolves message when work is done.
 * @throws {Error} If ( delay ) is not a Number.
 * @throws {Error} If ( onEnd ) is not a routine or wConsequence instance.
 * @function time.out
 * @memberof wTools
 */

function out_pre( routine, args )
{
  let o;
  let procedure;

  _.assert( arguments.length === 2 );
  _.assert( !!args );

  if( _.procedureIs( args[ 1 ] ) )
  {
    procedure = args[ 1 ];
    args = _.longBut( args, [ 1, 2 ] );
  }

  if( !_.mapIs( args[ 0 ] ) || args.length !== 1 )
  {
    let delay = args[ 0 ];
    let onEnd = args[ 1 ];

    if( onEnd !== undefined && !_.routineIs( onEnd ) && !_.consequenceIs( onEnd ) )
    {
      _.assert( args.length === 2, 'Expects two arguments if second one is not callable' );
      let returnOnEnd = onEnd;
      onEnd = function onEnd()
      {
        return returnOnEnd;
      }
    }
    else if( _.routineIs( onEnd ) && !_.consequenceIs( onEnd ) )
    {
      let _onEnd = onEnd;
      onEnd = function timeOutEnd()
      {
        let result = _onEnd.apply( this, arguments );
        return result === undefined ? null : result;
      }
    }

    _.assert( args.length <= 4 );

    if( args[ 1 ] !== undefined && args[ 2 ] === undefined && args[ 3 ] === undefined )
    _.assert( _.routineIs( onEnd ) || _.consequenceIs( onEnd ) );
    else if( args[ 2 ] !== undefined || args[ 3 ] !== undefined )
    _.assert( _.routineIs( args[ 2 ] ) );

    if( args[ 2 ] !== undefined || args[ 3 ] !== undefined )
    onEnd = _.routineJoin.call( _, args[ 1 ], args[ 2 ], args[ 3 ] );

    o = { delay, onEnd }

  }
  else
  {
    o = args[ 0 ];
  }

  _.assert( _.mapIs( o ) );

  if( procedure )
  o.procedure = procedure;

  _.routineOptions( routine, o );
  _.assert( _.numberIs( o.delay ) );
  _.assert( o.onEnd === null || _.routineIs( o.onEnd ) );

  return o;
}

//

function out_body( o )
{
  let con = new _.Consequence();
  let timer = null;
  let handleCalled = false;

  _.assertRoutineOptions( out_body, arguments );

  if( o.procedure === null )
  o.procedure = _.Procedure( 2 ).name( 'time.out' );
  _.assert( _.procedureIs( o.procedure ) );

  // if( o.procedure.id === 2 )
  // debugger;

  // /* */
  //
  // timer = _.time.begin( o.delay, o.procedure, timeEnd );

  /* */

  if( con )
  {
    con.procedure( o.procedure.clone() );
    // con.procedure( o.procedure );
    con.give( function timeGot( err, arg )
    {
      if( arg === _.dont )
      _.time.cancel( timer );
      con.take( err, arg );
    });
  }

  /* */

  timer = _.time.begin( o.delay, o.procedure, timeEnd );

  return con;

  /* */

  function timeEnd()
  {
    let result;

    handleCalled = true;

    if( con )
    {
      if( o.onEnd )
      con.first( o.onEnd );
      else
      con.take( _.time.out );
    }
    else
    {
      o.onEnd();
    }

  }

  /* */

}

out_body.defaults =
{
  delay : null,
  onEnd : null,
  procedure : null,
  isFinally : false,
}

let out = _.routineFromPreAndBody( out_pre, out_body );

//

/**
 * Routine works moslty same like {@link wTools.time.out} but has own small features:
 *  Is used to set execution time limit for async routines that can run forever or run too long.
 *  wConsequence instance returned by time.outError always give an error:
 *  - Own 'time.out' error message if ( onReady ) was not provided or it execution dont give any error.
 *  - Error throwed or returned in consequence by ( onRead ) routine.
 *
 * @param {Number} delay - Delay in ms before ( onReady ) is fired.
 * @param {Function|wConsequence} onReady - Routine that will be executed with delay.
 *
 * @example
 * // time.out error after delay
 * let t = _.time.outError( 1000 );
 * t.give( ( err, got ) => { throw err; } )
 *
 * @example
 * // using time.outError with long time routine
 * let time = 5000;
 * let time.out = time / 2;
 * function routine()
 * {
 *   return _.time.out( time );
 * }
 * // orKeepingSplit waits until one of provided consequences will resolve the message.
 * // In our example single time.outError consequence was added, so orKeepingSplit adds own context consequence to the queue.
 * // Consequence returned by 'routine' resolves message in 5000 ms, but time.outError will do the same in 2500 ms and 'time.out'.
 * routine()
 * .orKeepingSplit( _.time.outError( time.out ) )
 * .give( function( err, got )
 * {
 *   if( err )
 *   throw err;
 *   console.log( got );
 * })
 *
 * @returns {wConsequence} Returns wConsequence instance that resolves error message when work is done.
 * @throws {Error} If ( delay ) is not a Number.
 * @throws {Error} If ( onReady ) is not a routine or wConsequence instance.
 * @function time.outError
 * @memberof wTools
 */

/* xxx : remove the body, use out_body */
function outError_body( o )
{
  _.assert( _.routineIs( _.Consequence ) );
  _.assertRoutineOptions( outError_body, arguments );

  if( _.numberIs( o.procedure ) )
  o.procedure += 1;
  else if( o.procedure === null )
  o.procedure = 2;

  if( !o.procedure || _.numberIs( o.procedure ) )
  o.procedure = _.procedure.from( o.procedure ).nameElse( 'time.outError' );

  let con = _.time.out.body.call( _, o );
  if( Config.debug )
  con.tag = 'TimeOutError';

  // debugger;
  con.finally( function outError( err, arg )
  {
    if( err )
    throw err;
    if( arg === _.dont )
    return arg;

    err = _.time._errTimeOut
    ({
      message : 'Time out!',
      reason : 'time out',
      consequnce : con,
      procedure : o.procedure,
    });

    throw err;
    // return _.Consequence().error( err );
  });

  return con;
}

outError_body.defaults = Object.create( out_body.defaults );

let outError = _.routineFromPreAndBody( out_pre, outError_body );

//

function _errTimeOut( o )
{
  if( _.strIs( o ) )
  o = { message : o }
  o = _.routineOptions( _errTimeOut, o );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  o.message = o.message || 'Time out!';
  o.reason = o.reason || 'time out';

  let err = _._err
  ({
    args : [ o.message ],
    throws : o.procedure ? [ o.procedure._sourcePath ] : [],
    asyncCallsStack : o.procedure ? [ o.procedure.stack() ] : [],
    reason : o.reason,
  });

  // Object.defineProperty( err, 'reason',
  // {
  //   enumerable : false,
  //   configurable : false,
  //   writable : false,
  //   value : o.reason,
  // });

  if( o.consequnce )
  Object.defineProperty( err, 'consequnce',
  {
    enumerable : false,
    configurable : false,
    writable : false,
    value : o.consequnce,
  });

  return err;
}

_errTimeOut.defaults =
{
  message : null,
  reason : null,
  consequnce : null,
  procedure : null,
}

//

function rarely_functor( perTime, routine )
{
  let lastTime = _.time.now() - perTime;

  _.assert( arguments.length === 2 );
  _.assert( _.numberIs( perTime ) );
  _.assert( _.routineIs( routine ) );

  return function fewer()
  {
    let now = _.time.now();
    let elapsed = now - lastTime;
    if( elapsed < perTime )
    return;
    lastTime = now;
    return routine.apply( this, arguments );
  }

}

// //
//
// function periodic( delay, onReady )
// {
//   _.assert( _.routineIs( _.Consequence ) );
//
//   let con = new _.Consequence();
//   let id;
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( _.numberIs( delay ) );
//
//   let _onReady = null;
//
//   if( _.routineIs( onReady ) )
//   _onReady = function()
//   {
//     let result = onReady.call();
//     if( result === false )
//     clearInterval( id );
//     _.Consequence.take( con, undefined );
//     con.finally( handlePeriodicCon );
//   }
//   else if( onReady instanceof wConsquence )
//   _onReady = function()
//   {
//     let result = onReady.ping();
//     if( result === false )
//     clearInterval( id );
//     _.Consequence.take( con, undefined );
//     con.finally( handlePeriodicCon );
//   }
//   else if( onReady === undefined )
//   _onReady = function()
//   {
//     _.Consequence.take( con, undefined );
//     con.finally( handlePeriodicCon );
//   }
//   else throw _.err( 'unexpected type of onReady' );
//
//   id = setInterval( _onReady, delay );
//
//   return con;
//
//   function handlePeriodicCon( err )
//   {
//     if( arg === _.dont )
//     clearInterval( id );
//     // if( err )
//     // clearInterval( id );
//     /* xxx */
//   }
//
// }

//

function once( delay, onBegin, onEnd ) /* qqq : cover by test */
{
  let con = _.Consequence ? new _.Consequence({ /* sourcePath : 2 */ }) : undefined;
  let taken = false;
  let options;
  let optionsDefault =
  {
    delay : null,
    onBegin : null,
    onEnd : null,
  }

  if( _.objectIs( delay ) )
  {
    options = delay;
    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assertMapHasOnly( options, optionsDefault );
    delay = options.delay;
    onBegin = options.onBegin;
    onEnd = options.onEnd;
  }
  else
  {
    _.assert( 2 <= arguments.length && arguments.length <= 3 );
  }

  // _.assert( 0, 'not tested' );
  _.assert( delay >= 0 );
  _.assert( _.primitiveIs( onBegin ) || _.routineIs( onBegin ) || _.objectIs( onBegin ) );
  _.assert( _.primitiveIs( onEnd ) || _.routineIs( onEnd ) || _.objectIs( onEnd ) );

  return function once()
  {

    if( taken )
    {
      /*console.log( 'once :', 'was taken' );*/
      return;
    }
    taken = true;

    if( onBegin )
    {
      if( _.routineIs( onBegin ) ) onBegin.apply( this, arguments );
      else if( _.objectIs( onBegin ) ) onBegin.take( arguments );
      if( con )
      con.take( null );
    }

    _.time.out( delay, function()
    {

      if( onEnd )
      {
        if( _.routineIs( onEnd ) ) onEnd.apply( this, arguments );
        else if( _.objectIs( onEnd ) ) onEnd.take( arguments );
        if( con )
        con.take( null );
      }
      taken = false;

    });

    return con;
  }

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

  ready,
  readyJoin,

  out,
  outError,

  _errTimeOut,

  rarely_functor, /* check */
  // periodic, /* dubious */
  once, /* dubious */

}

//

_.mapSupplement( Self, Fields );
_.mapSupplement( Self, Routines );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();
