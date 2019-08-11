( function _fRoutine_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

// --
// routine
// --

function routineIs( src )
{
  return Object.prototype.toString.call( src ) === '[object Function]';
}

//

function routinesAre( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.longIs( src ) )
  {
    for( let s = 0 ; s < src.length ; s++ )
    if( !_.routineIs( src[ s ] ) )
    return false;
    return true;
  }

  return _.routineIs( src );
}

//

function routineIsPure( src )
{
  if( !src )
  return false;
  if( !( Object.getPrototypeOf( src ) === Function.__proto__ ) )
  return false;
  return true;
}

//

function routineHasName( src )
{
  if( !routineIs( src ) )
  return false;
  if( !src.name )
  return false;
  return true;
}

//

/**
 * Internal implementation.
 * @param {object} object - object to check.
 * @return {object} object - name in key/value format.
 * @function _routineJoin
 * @memberof wTools
 */

function _routineJoin( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.boolIs( o.sealing ) );
  _.assert( _.boolIs( o.extending ) );
  _.assert( _.routineIs( o.routine ), 'Expects routine' );
  _.assert( _.longIs( o.args ) || o.args === undefined );

  let routine = o.routine;
  let args = o.args;
  let context = o.context;
  let result = act();

  if( o.extending )
  {
    _.mapExtend( result, routine );

    Object.defineProperty( result, 'originalRoutine',
    {
      value : routine,
      enumerable : false,
    });

    if( context !== undefined )
    Object.defineProperty( result, 'boundContext',
    {
      value : context,
      enumerable : false,
    });

    if( args !== undefined )
    Object.defineProperty( result, 'boundArguments',
    {
      value : args,
      enumerable : false,
    });

  }

  return result;

  function act()
  {

    if( context !== undefined && args !== undefined )
    {
      if( o.sealing === true )
      {
        let name = routine.name || '__sealedContextAndArguments';
        _.assert( _.strIs( name ) );
        let __sealedContextAndArguments =
        {
          [ name ] : function()
          {
            return routine.apply( context, args );
          }
        }
        return __sealedContextAndArguments[ name ];
      }
      else
      {
        let a = _.arrayAppendArray( [ context ], args );
        return Function.prototype.bind.apply( routine, a );
      }
    }
    else if( context !== undefined && args === undefined )
    {
      if( o.sealing === true )
      {
        let name = routine.name || '__sealedContext';
        let __sealedContext =
        {
          [ name ] : function()
          {
            return routine.call( context );
          }
        }
        return __sealedContext[ name ];
      }
      else
      {
        return Function.prototype.bind.call( routine, context );
      }
    }
    else if( context === undefined && args !== undefined ) // xxx
    {
      if( o.sealing === true )
      {
        let name = routine.name || '__sealedArguments';
        _.assert( _.strIs( name ) );
        let __sealedContextAndArguments =
        {
          [ name ] : function()
          {
            return routine.apply( this, args );
          }
        }
        return __sealedContextAndArguments[ name ];
      }
      else
      {
        let name = routine.name || '__joinedArguments';
        let __joinedArguments =
        {
          [ name ] : function()
          {
            let args2 = _.arrayAppendArrays( null, [ args, arguments ] );
            return routine.apply( this, args2 );
          }
        }
        return __joinedArguments[ name ];
      }
    }
    else if( context === undefined && args === undefined ) // xxx
    {
      return routine;
      // if( !o.sealing )
      // {
      //   return routine;
      // }
      // else
      // {
      //   if( !args )
      //   args = [];
      //
      //   let name = routine.name || '__sealedArguments';
      //   let __sealedArguments =
      //   {
      //     [ name ] : function()
      //     {
      //       return routine.apply( undefined, args );
      //     }
      //   }
      //   return __sealedArguments[ name ];
      //
      // }
    }
    else _.assert( 0 );
  }

}

//

function constructorJoin( routine, args )
{

  _.assert( _.routineIs( routine ), 'Expects routine in the first argument' );
  _.assert( _.longIs( args ), 'Expects array-like in the second argument' );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  return _routineJoin
  ({
    routine,
    context : routine,
    args : args || [],
    sealing : false,
    extending : false,
  });

}

//

/**
 * The routineJoin() routine creates a new function with its 'this' ( context ) set to the provided `context`
 value. Argumetns `args` of target function which are passed before arguments of binded function during
 calling of target function. Unlike bind routine, position of `context` parameter is more intuitive.
 * @example
   let o = {
        z: 5
    };

   let y = 4;

   function sum(x, y) {
       return x + y + this.z;
    }
   let newSum = wTools.routineJoin(o, sum, [3]);
   newSum(y); // 12

   function f1(){ console.log( this ) };
   let f2 = f1.bind( undefined ); // context of new function sealed to undefined (or global object);
   f2.call( o ); // try to call new function with context set to { z: 5 }
   let f3 = _.routineJoin( undefined, f1 ); // new function.
   f3.call( o ) // print  { z: 5 }

 * @param {Object} context The value that will be set as 'this' keyword in new function
 * @param {Function} routine Function which will be used as base for result function.
 * @param {Array<*>} args Argumetns of target function which are passed before arguments of binded function during
 calling of target function. Must be wraped into array.
 * @returns {Function} New created function with preceding this, and args.
 * @throws {Error} When second argument is not callable throws error with text 'first argument must be a routine'
 * @thorws {Error} If passed arguments more than 3 throws error with text 'Expects 3 or less arguments'
 * @function routineJoin
 * @memberof wTools
 */

function routineJoin( context, routine, args )
{

  _.assert( _.routineIs( routine ), 'routineJoin :', 'Second argument must be a routine' );
  _.assert( arguments.length <= 3, 'routineJoin :', 'Expects 3 or less arguments' );

  return _routineJoin
  ({
    routine,
    context,
    args,
    sealing : false,
    extending : true,
  });

}

//

/**
 * The routineJoin() routine creates a new function with its 'this' ( context ) set to the provided `context`
 value. Argumetns `args` of target function which are passed before arguments of binded function during
 calling of target function. Unlike bind routine, position of `context` parameter is more intuitive.
 * @example
   let o = {
        z: 5
    };

   let y = 4;

   function sum(x, y) {
       return x + y + this.z;
    }
   let newSum = wTools.routineJoin(o, sum, [3]);
   newSum(y); // 12

   function f1(){ console.log( this ) };
   let f2 = f1.bind( undefined ); // context of new function sealed to undefined (or global object);
   f2.call( o ); // try to call new function with context set to { z: 5 }
   let f3 = _.routineJoin( undefined, f1 ); // new function.
   f3.call( o ) // print  { z: 5 }

 * @param {Object} context The value that will be set as 'this' keyword in new function
 * @param {Function} routine Function which will be used as base for result function.
 * @param {Array<*>} args Argumetns of target function which are passed before arguments of binded function during
 calling of target function. Must be wraped into array.
 * @returns {Function} New created function with preceding this, and args.
 * @throws {Error} When second argument is not callable throws error with text 'first argument must be a routine'
 * @thorws {Error} If passed arguments more than 3 throws error with text 'Expects 3 or less arguments'
 * @function routineJoin
 * @memberof wTools
 */

function routineJoin( context, routine, args )
{

  _.assert( _.routineIs( routine ), 'routineJoin :', 'second argument must be a routine' );
  _.assert( arguments.length <= 3, 'routineJoin :', 'Expects 3 or less arguments' );

  return _routineJoin
  ({
    routine,
    context,
    args,
    sealing : false,
    extending : true,
  });

}

//

  /**
   * Return new function with sealed context and arguments.
   *
   * @example
   let o = {
        z: 5
    };

   function sum(x, y) {
       return x + y + this.z;
    }
   let newSum = wTools.routineSeal(o, sum, [3, 4]);
   newSum(y); // 12
   * @param {Object} context The value that will be set as 'this' keyword in new function
   * @param {Function} routine Function which will be used as base for result function.
   * @param {Array<*>} args Arguments wrapped into array. Will be used as argument to `routine` function
   * @returns {Function} Result function with sealed context and arguments.
   * @function routineJoin
   * @memberof wTools
   */

function routineSeal( context, routine, args )
{

  _.assert( _.routineIs( routine ), 'routineSeal :', 'second argument must be a routine' );
  _.assert( arguments.length <= 3, 'routineSeal :', 'Expects 3 or less arguments' );

  return _routineJoin
  ({
    routine,
    context,
    args,
    sealing : true,
    extending : true,
  });

}

//

function routineOptions( routine, args, defaults )
{

  if( !_.arrayLike( args ) )
  args = [ args ];
  let options = args[ 0 ];
  if( options === undefined )
  options = Object.create( null );
  defaults = defaults || ( routine ? routine.defaults : null );

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects 2 or 3 arguments' );
  _.assert( _.routineIs( routine ) || routine === null, 'Expects routine' );
  _.assert( _.objectIs( defaults ), 'Expects routine with defined defaults or defaults in third argument' );
  _.assert( _.objectIs( options ), 'Expects object' );
  _.assert( args.length === 0 || args.length === 1, 'Expects single options map, but got', args.length, 'arguments' );

  _.assertMapHasOnly( options, defaults );
  _.mapSupplementStructureless( options, defaults ); /* xxx qqq : use instead of mapComplement */
  // _.mapComplement( options, defaults );
  _.assertMapHasNoUndefine( options );

  return options;
}

//

function assertRoutineOptions( routine, args, defaults )
{

  if( !_.arrayLike( args ) )
  args = [ args ];
  let options = args[ 0 ];
  defaults = defaults || ( routine ? routine.defaults : null );

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects 2 or 3 arguments' );
  _.assert( _.routineIs( routine ) || routine === null, 'Expects routine' );
  _.assert( _.objectIs( defaults ), 'Expects routine with defined defaults or defaults in third argument' );
  _.assert( _.objectIs( options ), 'Expects object' );
  _.assert( args.length === 0 || args.length === 1, 'Expects single options map, but got', args.length, 'arguments' );

  _.assertMapHasOnly( options, defaults );
  _.assertMapHasAll( options, defaults );
  _.assertMapHasNoUndefine( options );

  return options;
}

//

function routineOptionsPreservingUndefines( routine, args, defaults )
{

  if( !_.arrayLike( args ) )
  args = [ args ];
  let options = args[ 0 ];
  if( options === undefined )
  options = Object.create( null );
  defaults = defaults || routine.defaults;

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects 2 or 3 arguments' );
  _.assert( _.routineIs( routine ), 'Expects routine' );
  _.assert( _.objectIs( defaults ), 'Expects routine with defined defaults' );
  _.assert( _.objectIs( options ), 'Expects object' );
  _.assert( args.length === 0 || args.length === 1, 'routineOptions : expects single options map, but got', args.length, 'arguments' );

  _.assertMapHasOnly( options, defaults );
  _.mapComplementPreservingUndefines( options, defaults );

  return options;
}

//

function routineOptionsReplacingUndefines( routine, args, defaults )
{

  if( !_.arrayLike( args ) )
  args = [ args ];
  let options = args[ 0 ];
  if( options === undefined )
  options = Object.create( null );
  defaults = defaults || routine.defaults;

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects 2 or 3 arguments' );
  _.assert( _.routineIs( routine ), 'Expects routine' );
  _.assert( _.objectIs( defaults ), 'Expects routine with defined defaults or defaults in third argument' );
  _.assert( _.objectIs( options ), 'Expects object' );
  _.assert( args.length === 0 || args.length === 1, 'Expects single options map, but got', args.length, 'arguments' );

  _.assertMapHasOnly( options, defaults );
  _.mapComplementReplacingUndefines( options, defaults );

  return options;
}

//

function assertRoutineOptionsPreservingUndefines( routine, args, defaults )
{

  if( !_.arrayLike( args ) )
  args = [ args ];
  let options = args[ 0 ];
  defaults = defaults || routine.defaults;

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects 2 or 3 arguments' );
  _.assert( _.routineIs( routine ), 'Expects routine' );
  _.assert( _.objectIs( defaults ), 'Expects routine with defined defaults or defaults in third argument' );
  _.assert( _.objectIs( options ), 'Expects object' );
  _.assert( args.length === 0 || args.length === 1, 'Expects single options map, but got', args.length, 'arguments' );

  _.assertMapHasOnly( options, defaults );
  _.assertMapHasAll( options, defaults );

  return options;
}

//

function routineOptionsFromThis( routine, _this, constructor )
{

  _.assert( arguments.length === 3, 'routineOptionsFromThis : expects 3 arguments' );

  let options = _this || Object.create( null );
  if( Object.isPrototypeOf.call( constructor, _this ) || constructor === _this )
  options = Object.create( null );

  return _.routineOptions( routine, options );
}

//

function _routinesCompose_pre( routine, args )
{
  let o = args[ 0 ];

  if( !_.mapIs( o ) )
  o = { elements : args[ 0 ] }
  if( args[ 1 ] !== undefined )
  o.chainer = args[ 1 ];

  o.elements = _.arrayAppendArrays( [], [ o.elements ] );
  o.elements = o.elements.filter( ( e ) => e === null ? false : e );

  _.routineOptions( routine, o );
  _.assert( _.routinesAre( o.elements ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( args.length === 1 || args.length === 2 );
  _.assert( args.length === 1 || !_.objectIs( args[ 0 ] ) );
  _.assert( _.arrayIs( o.elements ) || _.routineIs( o.elements ) );
  _.assert( _.routineIs( args[ 1 ] ) || args[ 1 ] === undefined || args[ 1 ] === null );
  _.assert( o.chainer === null || _.routineIs( o.chainer ) );
  _.assert( o.supervisor === null || _.routineIs( o.supervisor ) );

  return o;
}

//

function _routinesCompose_body( o )
{

  if( o.chainer === null )
  o.chainer = _.compose.chainer.original;

  o.elements = _.arrayFlatten( null, o.elements ); /* qqq xxx : single argument call should be ( no-copy call ) */
  let elements = [];
  for( let s = 0 ; s < o.elements.length ; s++ )
  {
    let src = o.elements[ s ];
    _.assert( _.routineIs( src ) );
    if( src.composed )
    {
      if( src.composed.chainer === o.chainer && src.composed.supervisor === o.supervisor )
      {
        _.arrayAppendArray( elements, src.composed.elements );
      }
      else
      {
        debugger;
        _.arrayAppendElement( elements, src );
      }
    }
    else
    _.arrayAppendElement( elements, src );
  }

  o.elements = elements;

  let supervisor = o.supervisor;
  let chainer = o.chainer;
  let act;

  _.assert( _.routineIs( chainer ) );
  _.assert( supervisor === null || _.routineIs( supervisor ) );

  /* */

  if( elements.length === 0 )
  act = function empty()
  {
    return [];
  }
  // else if( elements.length === 1 ) /* xxx : optimize the case */
  // {
  //   act = elements[ 0 ];
  // }
  else act = function composition()
  {
    let result = [];
    // let args = _.unrollAppend( _.unrollFrom( null ), arguments );
    // debugger;
    let args = _.unrollFrom( arguments );
    for( let k = 0 ; k < elements.length ; k++ )
    {
      _.assert( _.unrollIs( args ), () => 'Expects unroll, but got', _.strType( args ) );
      let routine = elements[ k ];
      let r = routine.apply( this, args );
      _.assert( r !== false /* && r !== undefined */, 'Temporally forbidden type of result', r );
      _.assert( !_.argumentsArrayIs( r ) );
      if( r !== undefined )
      _.unrollAppend( result, r );
      // args = chainer( r, k, args, o );
      args = chainer( args, r, o, k );
      _.assert( args !== undefined && args !== false );
      // if( args === undefined )
      if( args === _.dont )
      break;
      args = _.unrollFrom( args );
    }
    return result;
  }

  o.act = act;
  act.composed = o;

  if( supervisor )
  {
    function compositionSupervise()
    {
      let result = supervisor( this, arguments, act, o );
      return result;
    }
    _.routineExtend( compositionSupervise, act );
    return compositionSupervise;
  }

  return act;
}

_routinesCompose_body.defaults =
{
  elements : null,
  chainer : null,
  supervisor : null,
}

//

function routinesCompose()
{
  let o = _.routinesCompose.pre( routinesCompose, arguments );
  let result = _.routinesCompose.body( o );
  return result;
}

routinesCompose.pre = _routinesCompose_pre;
routinesCompose.body = _routinesCompose_body;
routinesCompose.defaults = Object.create( routinesCompose.body.defaults );

//

/**
 * The routineExtend() is used to copy the values of all properties
 * from source routine to a target routine.
 *
 * It takes first routine (dst), and shallow clone each destination property of type map.
 * Then it checks properties of source routine (src) and extends dst by source properties.
 * The dst properties can be owerwriten by values of source routine
 * if descriptor (writable) of dst property is set.
 *
 * If the first routine (dst) is null then
 * routine routineExtend() makes a routine from routines pre and body
 * @see {@link wTools.routineFromPreAndBody} - Automatic routine generating
 * from preparation routine and main routine (body).
 *
 * @param{ routine } dst - The target routine or null.
 * @param{ * } src - The source routine or object to copy.
 *
 * @example
 * // returns [ routine routinesCompose ], got.option === 1
 * var src =
 * {
 *   pre : _.routinesCompose.pre,
 *   body : _.routinesCompose.body,
 *   someOption : 1,
 * }
 * var got = _.routineExtend( null, src );
 *
 * @example
 * // returns [ routine routinesCompose ]
 * _.routineExtend( null, _.routinesCompose );
 *
 * @example
 * // returns [ routine routinesCompose ], routinesCompose.someOption === 1
 * _.routineExtend( _.routinesCompose, { someOption : 1 } );
 *
 * @example
 * // returns [ routine routinesCompose ], routinesCompose.someOption === 1
 * _.routinesComposes.someOption = 22;
 * _.routineExtend( _.routinesCompose, { someOption : 1 } );
 *
 * @returns { routine } It will return the target routine with extended properties.
 * @function routineExtend
 * @throws { Error } Throw an error if arguments.length < 1 or arguments.length > 2.
 * @throws { Error } Throw an error if dst is not routine or not null.
 * @throws { Error } Throw an error if dst is null and src has not pre and body properties.
 * @throws { Error } Throw an error if src is primitive value.
 * @memberof wTools
 */

function routineExtend( dst )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.routineIs( dst ) || dst === null );

  /* generate dst routine */

  if( dst === null )
  {

    let dstMap = Object.create( null );
    for( let a = 0 ; a < arguments.length ; a++ )
    {
      let src = arguments[ a ];
      if( src === null )
      continue
      _.mapExtend( dstMap, src )
    }

    if( dstMap.pre && dstMap.body )
    dst = _.routineFromPreAndBody( dstMap.pre, dstMap.body );
    else
    _.assert( 0, 'Not clear how to construct the routine' );
  }

  /* shallow clone properties of dst routine */

  for( let s in dst )
  {
    let property = dst[ s ];
    if( _.mapIs( property ) )
    {
      property = _.mapExtend( null, property );
      dst[ s ] = property;
    }
  }

  /* extend dst routine */

  for( let a = 0 ; a < arguments.length ; a++ )
  {
    let src = arguments[ a ];
    if( src === null )
    continue;
    _.assert( !_.primitiveIs( src ) );
    for( let s in src )
    {
      let property = src[ s ];
      let d = Object.getOwnPropertyDescriptor( dst, s );
      if( d && !d.writable )
      continue;
      if( _.objectIs( property ) )
      {
        _.assert( !_.mapHas( dst, s ) || _.mapIs( dst[ s ] ) );
        property = Object.create( property );
        if( dst[ s ] )
        _.mapSupplement( property, dst[ s ] );
      }
      dst[ s ] = property;
    }
  }

  return dst;
}

//

function routineFromPreAndBody_pre( routine, args )
{
  let o = args[ 0 ];

  if( args[ 1 ] !== undefined )
  {
    o = { pre : args[ 0 ], body : args[ 1 ], name : args[ 2 ] };
  }

  _.routineOptions( routine, o );
  _.assert( args.length === 1 || args.length === 2 || args.length === 3 );
  _.assert( arguments.length === 2 );
  _.assert( _.routineIs( o.pre ) || _.routinesAre( o.pre ), 'Expects routine or routines {-o.pre-}' );
  _.assert( _.routineIs( o.body ), 'Expects routine {-o.body-}' );
  _.assert( o.body.defaults !== undefined, 'Body should have defaults' );

  return o;
}

//

function routineFromPreAndBody_body( o )
{

  _.assert( arguments.length === 1 ); // args, r, o, k

  if( !_.routineIs( o.pre ) )
  {
    let _pre = _.routinesCompose( o.pre, function( args, result, op, k )
    {
      _.assert( arguments.length === 4 );
      _.assert( !_.unrollIs( result ) );
      _.assert( _.objectIs( result ) );
      return _.unrollAppend([ callPreAndBody, [ result ] ]);
    });
    _.assert( _.routineIs( _pre ) );
    o.pre = function pre()
    {

      let result = _pre.apply( this, arguments );
      return result[ result.length-1 ];
    }
  }

  let pre = o.pre;
  let body = o.body;

  if( !o.name )
  {
    _.assert( _.strDefined( o.body.name ), 'Body routine should have name' );
    o.name = o.body.name;
    if( o.name.indexOf( '_body' ) === o.name.length-5 && o.name.length > 5 )
    o.name = o.name.substring( 0, o.name.length-5 );
  }

  let r =
  {
    [ o.name ] : function()
    {
      let result;
      let o = pre.call( this, callPreAndBody, arguments );
      _.assert( !_.argumentsArrayIs( o ), 'does not expect arguments array' );
      if( _.unrollIs( o ) )
      result = body.apply( this, o );
      else
      result = body.call( this, o );
      return result;
    }
  }

  let callPreAndBody = r[ o.name ];

  _.assert( _.strDefined( callPreAndBody.name ), 'Looks like your interpreter does not support dynamic naming of functions. Please use ES2015 or later interpreter.' );

  _.routineExtend( callPreAndBody, o.body );

  callPreAndBody.pre = o.pre;
  callPreAndBody.body = o.body;

  return callPreAndBody;
}

routineFromPreAndBody_body.defaults =
{
  pre : null,
  body : null,
  name : null,
}

//

function routineFromPreAndBody()
{
  let o = routineFromPreAndBody.pre.call( this, routineFromPreAndBody, arguments );
  let result = routineFromPreAndBody.body.call( this, o );
  return result;
}

routineFromPreAndBody.pre = routineFromPreAndBody_pre;
routineFromPreAndBody.body = routineFromPreAndBody_body;
routineFromPreAndBody.defaults = Object.create( routineFromPreAndBody_body.defaults );

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

  routineIs,
  routinesAre,
  routineIsPure,
  routineHasName,

  _routineJoin,
  constructorJoin,
  routineJoin,
  routineSeal,

  routineOptions,
  assertRoutineOptions,
  routineOptionsPreservingUndefines,
  assertRoutineOptionsPreservingUndefines,
  routineOptionsFromThis,

  routinesCompose,
  routineExtend,
  routineFromPreAndBody,

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
