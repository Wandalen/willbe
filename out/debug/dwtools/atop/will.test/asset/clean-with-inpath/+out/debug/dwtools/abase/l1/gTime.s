( function _gTime_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

let _ArrayIndexOf = Array.prototype.indexOf;
let _ArrayLastIndexOf = Array.prototype.lastIndexOf;
let _ArraySlice = Array.prototype.slice;
let _ArraySplice = Array.prototype.splice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _propertyIsEumerable = Object.propertyIsEnumerable;
let _ceil = Math.ceil;
let _floor = Math.floor;

// --
// time
// --

let _TimeInfinity = Math.pow( 2, 31 )-1;
function timeBegin( delay, onEnd )
{
  let timer = null;

  if( delay === undefined )
  delay = Infinity;

  if( delay >= _TimeInfinity )
  delay = _TimeInfinity;

  _.assert( arguments.length <= 4 );
  _.assert( _.numberIs( delay ) );

  if( arguments[ 2 ] !== undefined || arguments[ 3 ] !== undefined )
  onEnd = _.routineJoin.call( _, arguments[ 1 ], arguments[ 2 ], arguments[ 3 ] );

  if( delay > 0 )
  timer = setTimeout( out, delay );
  else
  timer = timeSoon( out );

  return timer;

  /* */

  function out()
  {
    if( onEnd )
    onEnd( timer );
  }

}

//

function timeEnd( timer )
{
  clearTimeout( timer );
  return timer;
}

//

function timeReady( onReady )
{

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( _.numberIs( arguments[ 0 ] ) || _.routineIs( arguments[ 0 ] ) || arguments[ 0 ] === undefined );

  let time = 0;
  if( _.numberIs( arguments[ 0 ] ) )
  {
    time = arguments[ 0 ];
    onReady = arguments[ 1 ];
  }

  if( typeof window !== 'undefined' && typeof document !== 'undefined' && document.readyState != 'complete' )
  {
    let con = _.Consequence ? new _.Consequence({ tag : 'timeReady' }) : null;

    function handleReady()
    {
      if( _.Consequence )
      return _.timeOut( time, onReady ).finally( con );
      else if( onReady )
      _.timeBegin( time, onReady );
      else _.assert( 0 );
    }

    window.addEventListener( 'load', handleReady );
    return con;
  }
  else
  {
    if( _.Consequence )
    return _.timeOut( time, onReady );
    else if( onReady )
    _.timeBegin( time, onReady );
    else _.assert( 0 );
  }

}

//

function timeReadyJoin( context, routine, args )
{

  routine = _.routineJoin( context, routine, args );

  let result = _.routineJoin( undefined, _.timeReady, [ routine ] );

  function _timeReady()
  {
    let args = arguments;
    routine = _.routineJoin( context === undefined ? this : this, routine, args );
    return _.timeReady( routine );
  }

  return _timeReady;
}

//

function timeOnce( delay, onBegin, onEnd )
{
  let con = _.Consequence ? new _.Consequence() : undefined;
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

  _.assert( delay >= 0 );
  _.assert( _.primitiveIs( onBegin ) || _.routineIs( onBegin ) || _.objectIs( onBegin ) );
  _.assert( _.primitiveIs( onEnd ) || _.routineIs( onEnd ) || _.objectIs( onEnd ) );

  return function timeOnce()
  {

    if( taken )
    {
      /*console.log( 'timeOnce :', 'was taken' );*/
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

    _.timeOut( delay, function()
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

//

/**
 * Routine creates timer that executes provided routine( onReady ) after some amout of time( delay ).
 * Returns wConsequence instance. {@link module:Tools/base/Consequence.wConsequence wConsequence}
 *
 * If ( onReady ) is not provided, timeOut returns consequence that gives empty message after ( delay ).
 * If ( onReady ) is a routine, timeOut returns consequence that gives message with value returned or error throwed by ( onReady ).
 * If ( onReady ) is a consequence or routine that returns it, timeOut returns consequence and waits until consequence from ( onReady ) resolves the message, then
 * timeOut gives that resolved message throught own consequence.
 * If ( delay ) <= 0 timeOut performs all operations on nextTick in node
 * @see {@link https://nodejs.org/en/docs/guides/event-loop-timers-and-nexttick/#the-node-js-event-loop-timers-and-process-nexttick }
 * or after 1 ms delay in browser.
 * Returned consequence controls the timer. Timer can be easly stopped by giving an error from than consequence( see examples below ).
 * Important - Error that stops timer is returned back as regular message inside consequence returned by timeOut.
 * Also timeOut can run routine with different context and arguments( see example below ).
 *
 * @param {Number} delay - Delay in ms before ( onReady ) is fired.
 * @param {Function|wConsequence} onReady - Routine that will be executed with delay.
 *
 * @example
 * // Simplest, just timer
 * let t = _.timeOut( 1000 );
 * t.got( () => console.log( 'Message with 1000ms delay' ) )
 * console.log( 'Normal message' )
 *
 * @example
 * // Run routine with delay
 * let routine = () => console.log( 'Message with 1000ms delay' );
 * let t = _.timeOut( 1000, routine );
 * t.got( () => console.log( 'Routine finished work' ) );
 * console.log( 'Normal message' )
 *
 * @example
 * // Routine returns consequence
 * let routine = () => new _.Consequence().take( 'msg' );
 * let t = _.timeOut( 1000, routine );
 * t.got( ( err, got ) => console.log( 'Message from routine : ', got ) );
 * console.log( 'Normal message' )
 *
 * @example
 * // timeOut waits for long time routine
 * let routine = () => _.timeOut( 1500, () => 'work done' ) ;
 * let t = _.timeOut( 1000, routine );
 * t.got( ( err, got ) => console.log( 'Message from routine : ', got ) );
 * console.log( 'Normal message' )
 *
 * @example
 * // how to stop timer
 * let routine = () => console.log( 'This message never appears' );
 * let t = _.timeOut( 5000, routine );
 * t.error( 'stop' );
 * t.got( ( err, got ) => console.log( 'Error returned as regular message : ', got ) );
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
 * let t = _.timeOut( 100, context, routine, arguments );
 * t.got( ( err, got ) => console.log( 'Result of routine execution : ', got ) );
 *
 * @returns {wConsequence} Returns wConsequence instance that resolves message when work is done.
 * @throws {Error} If ( delay ) is not a Number.
 * @throws {Error} If ( onEnd ) is not a routine or wConsequence instance.
 * @function timeOut
 * @memberof wTools
 */

function timeOut_pre( routine, args )
{
  let o;

  _.assert( arguments.length === 2 );
  _.assert( args );

  // debugger;

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

    // if( args[ 2 ] !== undefined || args[ 3 ] !== undefined )
    // debugger;
    if( args[ 2 ] !== undefined || args[ 3 ] !== undefined )
    onEnd = _.routineJoin.call( _, args[ 1 ], args[ 2 ], args[ 3 ] );

    o = { /*ttt*/delay, /*ttt*/onEnd }

  }
  else
  {
    o = args[ 0 ];
  }

  // debugger;

  _.routineOptions( routine, o );
  _.assert( _.numberIs( o.delay ) );
  _.assert( o.onEnd === null || _.routineIs( o.onEnd ) );

  return o;
}

//

function timeOut_body( o )
{
  let con = _.Consequence ? new _.Consequence() : undefined;
  let timer = null;
  let handleCalled = false;

  _.assertRoutineOptions( timeOut_body, arguments );

  /* */

  if( con )
  {
    // debugger;
    con.procedure( 'timeOut' ).sourcePath( o.stackLevel + 2 );
    // debugger;
    con.got( function timeGot( err, arg )
    {
      if( err )
      clearTimeout( timer );
      con.take( err, arg );
    });
  }

  /* */

  timer = _.timeBegin( o.delay, timeEnd );

  // if( o.delay > 0 )
  // timer = _.timeBegin( o.delay, timeEnd );
  // else
  // timeSoon( timeEnd );

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
      con.take( timeOut );
    }
    else
    {
      o.onEnd();
    }

  }

}

timeOut_body.defaults =
{
  delay : null,
  onEnd : null,
  stackLevel : 1,
}

let timeOut = _.routineFromPreAndBody( timeOut_pre, timeOut_body );

//

let timeSoon = typeof process === 'undefined' ? function( h ){ return setTimeout( h, 0 ) } : process.nextTick;

//

/**
 * Routine works moslty same like {@link wTools.timeOut} but has own small features:
 *  Is used to set execution time limit for async routines that can run forever or run too long.
 *  wConsequence instance returned by timeOutError always give an error:
 *  - Own 'timeOut' error message if ( onReady ) was not provided or it execution dont give any error.
 *  - Error throwed or returned in consequence by ( onRead ) routine.
 *
 * @param {Number} delay - Delay in ms before ( onReady ) is fired.
 * @param {Function|wConsequence} onReady - Routine that will be executed with delay.
 *
 * @example
 * // timeOut error after delay
 * let t = _.timeOutError( 1000 );
 * t.got( ( err, got ) => { throw err; } )
 *
 * @example
 * // using timeOutError with long time routine
 * let time = 5000;
 * let timeOut = time / 2;
 * function routine()
 * {
 *   return _.timeOut( time );
 * }
 * // orKeepingSplit waits until one of provided consequences will resolve the message.
 * // In our example single timeOutError consequence was added, so orKeepingSplit adds own context consequence to the queue.
 * // Consequence returned by 'routine' resolves message in 5000 ms, but timeOutError will do the same in 2500 ms and 'timeOut'.
 * routine()
 * .orKeepingSplit( _.timeOutError( timeOut ) )
 * .got( function( err, got )
 * {
 *   if( err )
 *   throw err;
 *   console.log( got );
 * })
 *
 * @returns {wConsequence} Returns wConsequence instance that resolves error message when work is done.
 * @throws {Error} If ( delay ) is not a Number.
 * @throws {Error} If ( onReady ) is not a routine or wConsequence instance.
 * @function timeOutError
 * @memberof wTools
 */

function timeOutError_body( o )
{
  _.assert( _.routineIs( _.Consequence ) );
  _.assertRoutineOptions( timeOutError_body, arguments );

  let stackLevel = o.stackLevel;

  o.stackLevel += 1;
  let con = _.timeOut.body.call( _, o );

  con.tag = 'TimeOutError';
  con.procedure( 'timeOutError' ).sourcePath( stackLevel + 2 );
  con.finally( function( err, arg )
  {
    if( err )
    return _.Consequence().error( err );

    err = _.err( 'Time out!' );

    Object.defineProperty( err, 'timeOut',
    {
      enumerable : false,
      configurable : false,
      writable : false,
      value : 1,
    });

    return _.Consequence().error( err );
  });

  return con;
}

timeOutError_body.defaults = Object.create( timeOut_body.defaults );

let timeOutError = _.routineFromPreAndBody( timeOut_pre, timeOutError_body );

//

function timePeriodic( delay, onReady )
{
  _.assert( _.routineIs( _.Consequence ) );
  let con = new _.Consequence();
  let id;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  // if( arguments.length > 2 )
  // {
  //   throw _.err( 'Not tested' );
  //   _.assert( arguments.length <= 4 );
  //   onReady = _.routineJoin( arguments[ 2 ], onReady[ 3 ], arguments[ 4 ] );
  // }

  _.assert( _.numberIs( delay ) );

  function handlePeriodicCon( err )
  {
    if( err ) clearInterval( id );
  }

  let _onReady = null;

  if( _.routineIs( onReady ) )
  _onReady = function()
  {
    let result = onReady.call();
    if( result === false )
    clearInterval( id );
    _.Consequence.take( con, undefined );
    con.finally( handlePeriodicCon );
  }
  else if( onReady instanceof wConsquence )
  _onReady = function()
  {
    let result = onReady.ping();
    if( result === false )
    clearInterval( id );
    _.Consequence.take( con, undefined );
    con.finally( handlePeriodicCon );
  }
  else if( onReady === undefined )
  _onReady = function()
  {
    _.Consequence.take( con, undefined );
    con.finally( handlePeriodicCon );
  }
  else throw _.err( 'unexpected type of onReady' );

  id = setInterval( _onReady, delay );

  return con;
}

//

function _timeNow_functor()
{
  let now;

  // _.assert( arguments.length === 0 );

  if( typeof performance !== 'undefined' && performance.now !== undefined )
  now = _.routineJoin( performance, performance.now );
  else if( Date.now )
  now = _.routineJoin( Date, Date.now );
  else
  now = function(){ return Date().getTime() };

  return now;
}

//

function timeFewer_functor( perTime, routine )
{
  let lastTime = _.timeNow() - perTime;

  _.assert( arguments.length === 2 );
  _.assert( _.numberIs( perTime ) );
  _.assert( _.routineIs( routine ) );

  return function fewer()
  {
    let now = _.timeNow();
    let elapsed = now - lastTime;
    if( elapsed < perTime )
    return;
    lastTime = now;
    return routine.apply( this, arguments );
  }

}

//

function timeFrom( time )
{
  _.assert( arguments.length === 1 );
  if( _.numberIs( time ) )
  return time;
  if( _.dateIs( time ) )
  return time.getTime()
  _.assert( 0, 'Not clear how to coerce to time', _.strType( time ) );
}

//

function timeSpent( description, time )
{
  let now = _.timeNow();

  if( arguments.length === 1 )
  {
    time = arguments[ 0 ];
    description = '';
  }

  _.assert( 1 <= arguments.length && arguments.length <= 2 );
  _.assert( _.numberIs( time ) );
  _.assert( _.strIs( description ) );

  // if( description && description !== ' ' )
  // description = description;

  let result = description + _.timeSpentFormat( now-time );

  return result;
}

//

function timeSpentFormat( spent )
{
  let now = _.timeNow();

  _.assert( 1 === arguments.length );
  _.assert( _.numberIs( spent ) );

  let result = ( 0.001*( spent ) ).toFixed( 3 ) + 's';

  return result;
}

//

function dateToStr( date )
{
  let y = date.getFullYear();
  let m = date.getMonth() + 1;
  let d = date.getDate();
  if( m < 10 ) m = '0' + m;
  if( d < 10 ) d = '0' + d;
  let result = [ y, m, d ].join( '.' );
  return result;
}

//

// let _timeSleepBuffer = new Int32Array( new SharedArrayBuffer( 4 ) );
// function timeSleep( time )
// {
//   _.assert( time >= 0 );
//   Atomics.wait( _timeSleepBuffer, 0, 1, time );
// }
//
// //
//
// function timeSleepUntil( o )
// {
//   if( _.routineIs( o ) )
//   o = { onCondition : o }
//
//   if( o.periodicity === undefined )
//   o.periodicity = timeSleepUntil.defaults.periodicity;
//
//   let i = 0;
//   while( !o.onCondition() )
//   {
//     _.timeSleep( o.periodicity );
//   }
//
//   return true;
// }
//
// timeSleepUntil.defaults =
// {
//   onCondition : null,
//   periodicity : 100,
// }

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

  timeBegin,
  timeEnd,

  timeReady,
  timeReadyJoin,
  timeOnce,
  timeOut,
  timeSoon,
  timeOutError,

  timePeriodic, /* dubious */

  _timeNow_functor,
  timeNow : _timeNow_functor(),

  timeFewer_functor,

  timeFrom,
  timeSpent,
  timeSpentFormat,
  dateToStr,

  // timeSleep, /* experimental */
  // timeSleepUntil, /* experimental */

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
