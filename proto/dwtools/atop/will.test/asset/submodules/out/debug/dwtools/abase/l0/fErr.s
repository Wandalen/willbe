( function _fErr_s_() {

'use strict'; 

/*

!!! implemen error's collectors

*/

let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

// --
// stub
// --

function diagnosticStack( stack )
{
  if( _.errIs( stack ) )
  return stack.stack || stack;
  return new Error().stack;
}

//

function diagnosticStackCondense( stack )
{
  if( _.errIs( stack ) )
  return stack.stack || stack;
  return new Error().stack;
}

//

function diagnosticLocation()
{
  return Object.create( null );
}

//

function diagnosticCode()
{
  return undefined;
}

// --
// error
// --

function errIs( src )
{
  return src instanceof Error || _ObjectToString.call( src ) === '[object Error]';
}

//

function errIsRefined( src )
{
  if( _.errIs( src ) === false )
  return false;
  return src.originalMessage !== undefined;
}

//

function errIsAttended( src )
{
  if( _.errIs( src ) === false )
  return false;
  return !!src.attended;
}

//

function errIsAttentionRequested( src )
{
  if( _.errIs( src ) === false )
  return false;
  return src.attentionRequested;
}

//

function errAttentionRequest( err )
{

  if( arguments.length !== 1 )
  throw Error( 'errAttentionRequest : Expects one argument' );
  if( !_.errIs( err ) )
  throw Error( 'errAttentionRequest : Expects error as the first argument' );

  Object.defineProperty( err, 'attended',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : 0,
  });

  Object.defineProperty( err, 'attentionRequested',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : 1,
  });

  return err;
}

//

/**
 * Creates Error object based on passed options.
 * Result error contains in message detailed stack trace and error description.
 * @param {Object} o Options for creating error.
 * @param {String[]|Error[]} o.args array with messages or errors objects, from which will be created Error obj.
 * @param {number} [o.level] using for specifying in error message on which level of stack trace was caught error.
 * @returns {Error} Result Error. If in `o.args` passed Error object, result will be reference to it.
 * @private
 * @throws {Error} Expects single argument if pass les or more than one argument
 * @throws {Error} o.args should be array like, if o.args is not array.
 * @function _err
 * @memberof wTools
 */

function _err( o )
{
  let result;

  if( arguments.length !== 1 )
  throw Error( '_err : expects single argument' );

  if( !_.longIs( o.args ) )
  throw Error( '_err : o.args should be array like' );

  if( o.usingSourceCode === undefined )
  o.usingSourceCode = _err.defaults.usingSourceCode;

  if( o.condensingStack === undefined )
  o.condensingStack = _err.defaults.condensingStack;

  if( o.args[ 0 ] === 'not implemented' || o.args[ 0 ] === 'not tested' || o.args[ 0 ] === 'unexpected' )
  if( _.debuggerEnabled )
  debugger;

  /* let */

  let originalMessage = '';
  let catches = '';
  let sourceCode = '';
  let errors = [];
  let attended = 0;

  /* Error.stackTraceLimit = 99; */

  /* find error in arguments */

  for( let a = 0 ; a < o.args.length ; a++ )
  {
    let arg = o.args[ a ];

    if( _.routineIs( arg ) )
    {
      if( arg.length === 0 )
      {}
      else
      debugger;
      if( arg.length === 0 )
      arg = o.args[ a ] = arg();
      if( _.argumentsArrayIs( arg ) )
      {
        o.args = _.longButRange( o.args, [ a,a+1 ], arg );
        a -= 1;
        continue;
      }
    }

    if( arg instanceof Error )
    {

      if( !result )
      {
        result = arg;
        catches = result.catches || '';
        sourceCode = result.sourceCode || '';
        if( o.args.length === 1 )
        attended = result.attended;
      }

      if( arg.attentionRequested === undefined )
      {
        Object.defineProperty( arg, 'attentionRequested',
        {
          enumerable : false,
          configurable : true,
          writable : true,
          value : 0,
        });
      }

      if( arg.originalMessage !== undefined )
      {
        o.args[ a ] = arg.originalMessage;
      }
      else
      {
        o.args[ a ] = arg.message || arg.msg || arg.constructor.name || 'unknown error';
        let fields = _.mapFields( arg );
        if( Object.keys( fields ).length )
        o.args[ a ] += '\n' + _.toStr( fields,{ wrap : 0, multiline : 1, levels : 2 } );
      }

      if( errors.length > 0 )
      o.args[ a ] = '\n' + o.args[ a ];
      errors.push( arg );

      o.location = _.diagnosticLocation({ error : arg, location : o.location });

    }

  }

  /* look into non-error arguments to find location */

  if( !result )
  for( let a = 0 ; a < o.args.length ; a++ )
  {
    let arg = o.args[ a ];

    if( !_.primitiveIs( arg ) && _.objectLike( arg ) )
    {
      o.location = _.diagnosticLocation({ error : arg, location : o.location });
    }

  }

  o.location = o.location || Object.create( null );

  /* level */

  // if( !_.numberIs( o.level ) )
  // o.level = result.level;
  if( !_.numberIs( o.level ) )
  o.level = _err.defaults.level;

  /* make new one if no error in arguments */

  let stack = o.stack;
  let stackCondensed = '';

  if( !result )
  {
    if( !stack )
    stack = o.fallBackStack;
    result = new Error( originalMessage + '\n' );
    if( !stack )
    {
      stack = _.diagnosticStack( result, [ o.level, -1 ] );
      if( o.location.full && stack.indexOf( '\n' ) === -1 )
      stack = o.location.full;
    }
  }
  else
  {
    if( result.stack !== undefined )
    {
      if( result.originalMessage !== undefined )
      {
        stack = result.stack;
        stackCondensed = result.stackCondensed;
      }
      else
      {
        // debugger;
        stack = _.diagnosticStack( result );
      }
    }
    else
    {
      stack = _.diagnosticStack([ o.level, Infinity ]);
    }
  }

  if( !stack )
  stack = o.fallBackStack;

  if( _.strIs( stack ) && !_.strEnds( stack, '\n' ) )
  stack = stack + '\n';

  if( stack && !stackCondensed )
  {
    stackCondensed = _.diagnosticStackCondense( stack );
  }

  /* collect data */

  for( let a = 0 ; a < o.args.length ; a++ )
  {
    let argument = o.args[ a ];
    let str;

    if( argument && !_.primitiveIs( argument ) )
    {

      if( _.primitiveIs( argument ) )
      str = String( argument );
      else if( _.routineIs( argument.toStr ) )
      str = argument.toStr();
      else if( _.errIs( argument ) || _.strIs( argument.message ) )
      {
        if( _.strIs( argument.originalMessage ) ) str = argument.originalMessage;
        else if( _.strIs( argument.message ) ) str = argument.message;
        else str = _.toStr( argument );
      }
      else str = _.toStr( argument,{ levels : 2 } );

    }
    else if( argument === undefined )
    {
      str = '\n' + String( argument ) + '\n';
    }
    else
    {
      str = String( argument );
    }

    if( _.strIs( str ) && str[ str.length-1 ] === '\n' )
    originalMessage += str;
    else
    originalMessage += str + ' ';

  }

  /* line number */

  if( o.location.line !== undefined )
  {
    Object.defineProperty( result, 'lineNumber',
    {
      enumerable : false,
      configurable : true,
      writable : true,
      value : o.location.line,
    });
  }

  /* file name */

  // if( o.location.path !== undefined && !result.fileName )
  // {
  //   Object.defineProperty( result, 'fileName',
  //   {
  //     enumerable : false,
  //     configurable : true,
  //     writable : true,
  //     value : o.location.path,
  //   });
  //   Object.defineProperty( result, 'LocationFull',
  //   {
  //     enumerable : false,
  //     configurable : true,
  //     writable : true,
  //     value : o.location.full,
  //   });
  // }

  /* source code */

  if( o.usingSourceCode )
  if( result.sourceCode === undefined )
  {
    let c = '';
    o.location = _.diagnosticLocation
    ({
      error : result,
      stack : stack,
      location : o.location,
    });
    c = _.diagnosticCode
    ({
      location : o.location,
      sourceCode : o.sourceCode,
    });
    // debugger;
    if( c && c.length < 400 )
    {
      // sourceCode += '\n';
      sourceCode += c;
      // sourceCode += '\n ';
    }
  }

  /* where it was caught */

  let floc = _.diagnosticLocation( o.level );
  // if( floc.fullWithRoutine.indexOf( 'errLogOnce' ) !== -1 )
  // debugger;
  if( !floc.service || floc.service === 1 )
  catches = '    caught at ' + floc.fullWithRoutine + '\n' + catches;

  /* message */

  let message = '';

  let briefly = result.briefly && ( result.briefly === undefined || result.briefly === null || result.briefly );
  briefly = briefly || o.briefly;
  if( briefly )
  {
    message += originalMessage;
  }
  else
  {
    message += ' * Message\n' + originalMessage + '\n';
    if( o.condensingStack )
    message += '\n * Condensed calls stack\n' + stackCondensed + '';
    else
    message += '\n * Functions stack\n' + stack + '';
    message += '\n * Catches stack\n' + catches + '\n';

    if( sourceCode )
    message += ' * Source code from ' + sourceCode + '\n';

  }

  // if( sourceCode && !briefly )
  // debugger;
  // if( sourceCode && !briefly )
  // message += '* Source code ' + sourceCode + '\n';

  try
  {
    Object.defineProperty( result, 'toString',
    {
      enumerable : false,
      configurable : true,
      writable : true,
      value : function() { return this.message },
      // value : function() { return '--\n' + this.message + '\n--' },
    });
  }
  catch( e )
  {
    if( _.debuggerEnabled )
    debugger;
    // result = new Error( message );
  }

  try
  {
    Object.defineProperty( result, 'message',
    {
      enumerable : false,
      configurable : true,
      writable : true,
      value : message,
    });
  }
  catch( e )
  {
    console.error( e );
    if( _.debuggerEnabled )
    debugger;
    // result = new Error( message );
  }

  /* original message */

  Object.defineProperty( result, 'originalMessage',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : originalMessage,
  });

  /* level */

  Object.defineProperty( result, 'level',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : o.level,
  });

  /* stack */

  try
  {
    Object.defineProperty( result, 'stack',
    {
      enumerable : false,
      configurable : true,
      writable : true,
      value : stack,
    });
  }
  catch( err )
  {
  }

  Object.defineProperty( result, 'stackCondensed',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : stackCondensed,
  });

  /* briefly */

  if( o.briefly )
  Object.defineProperty( result, 'briefly',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : o.briefly,
  });

  /* source code */

  Object.defineProperty( result, 'sourceCode',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : sourceCode || null,
  });

  /* location */

  if( result.location === undefined )
  Object.defineProperty( result, 'location',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : o.location,
  });

  if( attended === 1 )
  debugger;

  Object.defineProperty( result, 'attended',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : attended,
  });

  /* catches */

  Object.defineProperty( result, 'catches',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : catches,
  });

  /* catch count */

  Object.defineProperty( result, 'catchCounter',
  {
    enumerable : false,
    configurable : true,
    writable : true,
    value : result.catchCounter ? result.catchCounter+1 : 1,
  });

  if( originalMessage.indexOf( 'caught at' ) !== -1 )
  {
    debugger;
    // console.error( '-' );
    // console.error( result.toString() );
    // console.error( '-' );
    // throw Error( 'err : originalMessage should have no "caught at"' );
  }

  return result;
}

_err.defaults =
{
  /* to make catch stack work properly it should be 1 */
  level : 1,
  usingSourceCode : 1,
  condensingStack : 1,
  location : null,
  sourceCode : null,
  briefly : null,
  args : null,
  stack : null,
  fallBackStack : null,
}

//

/**
 * Creates error object, with message created from passed `msg` parameters and contains error trace.
 * If passed several strings (or mixed error and strings) as arguments, the result error message is created by
 concatenating them.
 *
 * @example
  function divide( x, y )
  {
    if( y == 0 )
      throw wTools.err( 'divide by zero' )
    return x / y;
  }
  divide( 3, 0 );

 // Error:
 // caught     at divide (<anonymous>:2:29)
 // divide by zero
 // Error
 //   at _err (file:///.../wTools/staging/Base.s:1418:13)
 //   at wTools.err (file:///.../wTools/staging/Base.s:1449:10)
 //   at divide (<anonymous>:2:29)
 //   at <anonymous>:1:1
 *
 * @param {...String|Error} msg Accepts list of messeges/errors.
 * @returns {Error} Created Error. If passed existing error as one of parameters, routine modified it and return
 * reference.
 * @function err
 * @memberof wTools
 */

function err()
{
  return _err
  ({
    args : arguments,
    level : 2,
  });
}

//

function errBriefly()
{
  return _err
  ({
    args : arguments,
    level : 2,
    briefly : 1,
  });
}

//

function errAttend( err, val )
{

  if( arguments.length !== 1 || !_.errIsRefined( err ) )
  err = _err
  ({
    args : arguments,
    level : 2,
  });

  /* */

  try
  {

    if( val )
    Object.defineProperty( err, 'attentionRequested',
    {
      enumerable : false,
      configurable : true,
      writable : true,
      value : 0,
    });

    Object.defineProperty( err, 'attended',
    {
      enumerable : false,
      configurable : true,
      writable : true,
      value : Config.debug ? _.diagnosticStack([ 1, Infinity ]) : 1,
    });

  }
  catch( err )
  {
    logger.warn( 'Cant assign attentionRequested and attended properties to error ' + err.toString() );
  }

  /* */

  return err;
}

//

function errRestack( err,level )
{
  if( level === undefined )
  level = 1;

  let err2 = _._err
  ({
    args : [],
    level : level+1,
  });

  return _.err( err2,err );
}

//

function error_functor( name, onMake )
{

  if( _.strIs( onMake ) || _.arrayIs( onMake ) )
  {
    let prepend = onMake;
    onMake = function onErrorMake()
    {
      debugger;
      let arg = _.arrayAppendArrays( [], [ prepend, arguments ] );
      return args;
      // return _.err.apply( _, arguments );
    }
  }
  else if( !onMake )
  onMake = function onErrorMake()
  {
    return arguments;
    // return _.err.apply( _, arguments );
  }

  let Error =
  {
    [ name ] : function()
    {
      // console.log( name );
      // debugger;

      if( !( this instanceof ErrorConstructor ) )
      {
        let err1 = new ErrorConstructor();
        let args1 = onMake.apply( err1, arguments );
        _.assert( _.arrayLike( args1 ) );
        let args2 = _.arrayAppendArrays( [], [ args1, [ ( arguments.length ? '\n' : '' ), err1 ] ] );
        let err2 = _._err({ args : args2, level : 3 });
        // let err2 = _.err.apply( _, args2 );
        // let err = _._err({ args : [ o.err ], level : _.numberIs( o.level ) ? o.level+1 : o.level });

        _.assert( err1 === err2 );
        _.assert( err2 instanceof _global.Error );
        _.assert( err2 instanceof ErrorConstructor );
        _.assert( !!err2.stack );

        return err2;
      }
      else
      {
        // debugger;
        // let r = Error.call( this );
        // debugger;
        _.assert( arguments.length === 0 );
        return this;
      }
    }
  }

  // let wrap =
  // {
  //   [ name ] : function()
  //   {
  //     console.log( name );
  //     debugger;
  //     return act.apply( this, arguments );
  //   }
  // }

  let ErrorConstructor = Error[ name ];

  _.assert( ErrorConstructor.name === name, 'Looks like your interpreter does not support dynamice naming of functions. Please use ES2015 or later interpreter.' );

  ErrorConstructor.prototype = Object.create( _global.Error.prototype );
  ErrorConstructor.prototype.constructor = ErrorConstructor;
  ErrorConstructor.constructor = ErrorConstructor;

  return ErrorConstructor;

  /* */

  // function act()
  // {
  //
  //   if( !( this instanceof Error1 ) )
  //   {
  //     let err1 = new Error1();
  //     let args = _.arrayAppendArrays( [], [ arguments, [ ( arguments.length ? '\n' : '' ), err1 ] ] );
  //     let err2 = onMake.apply( this, args );
  //
  //     _.assert( err2 instanceof Error );
  //     _.assert( err2 instanceof Error1 );
  //     _.assert( !!err2.stack );
  //
  //     return err2;
  //   }
  //
  //   _.assert( arguments.length === 0 );
  //   return this;
  // }

}

//

/**
 * Creates error object, with message created from passed `msg` parameters and contains error trace.
 * If passed several strings (or mixed error and strings) as arguments, the result error message is created by
 concatenating them. Prints the created error.
 * If _global_.logger defined, routine will use it to print error, else uses console
 *
 * @see {@link wTools.err See err}
 *
 * @example
   function divide( x, y )
   {
      if( y == 0 )
        throw wTools.errLog( 'divide by zero' )
      return x / y;
   }
   divide( 3, 0 );

   // Error:
   // caught     at divide (<anonymous>:2:29)
   // divide by zero
   // Error
   //   at _err (file:///.../wTools/staging/Base.s:1418:13)
   //   at wTools.errLog (file:///.../wTools/staging/Base.s:1462:13)
   //   at divide (<anonymous>:2:29)
   //   at <anonymous>:1:1
 *
 * @param {...String|Error} msg Accepts list of messeges/errors.
 * @returns {Error} Created Error. If passed existing error as one of parameters, routine modified it and return
 * @function errLog
 * @memberof wTools
 */

function errLog()
{

  let c = _global.logger || _global.console;
  let err = _err
  ({
    args : arguments,
    level : 2,
  });

  /* */

  if( _.routineIs( err.toString ) )
  {
    let str = err.toString();
    if( _.loggerIs( c ) )
    c.error( '#inputRaw : 1#' + str + '#inputRaw : 0#' )
    else
    c.error( str );
  }
  else
  {
    debugger;
    c.error( 'Error does not have toString' );
    c.error( err );
  }

  /* */

  _.errAttend( err );

  /* */

  return err;
}

//

function errLogOnce( err )
{
  let c = _global.logger || _global.console;
  err = _err
  ({
    args : arguments,
    level : 2,
  });

  if( err.attended )
  return err;

  /* */

  if( _.routineIs( err.toString ) )
  {
    c.error( err.toString() );
  }
  else
  {
    c.error( err );
  }

  /* */

  _.errAttend( err );
  return err;
}

// --
// checker
// --

function checkInstanceOrClass( _constructor, _this )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  debugger;
  let result =
  (
    _this === _constructor ||
    _this instanceof _constructor ||
    Object.isPrototypeOf.call( _constructor,_this ) ||
    Object.isPrototypeOf.call( _constructor,_this.prototype )
  );
  return result;
}

//

function checkOwnNoConstructor( ins )
{
  _.assert( _.objectLikeOrRoutine( ins ) );
  _.assert( arguments.length === 1 );
  let result = !_ObjectHasOwnProperty.call( ins,'constructor' );
  return result;
}

// --
// sure
// --

function _sureDebugger( condition )
{
  if( _.debuggerEnabled )
  debugger;
}

//

function sure( condition )
{

  if( !condition || !boolLike( condition ) )
  {
    _sureDebugger( condition );
    if( arguments.length === 1 )
    throw _err
    ({
      args : [ 'Assertion fails' ],
      level : 2,
    });
    else if( arguments.length === 2 )
    throw _err
    ({
      args : [ arguments[ 1 ] ],
      level : 2,
    });
    else
    throw _err
    ({
      args : _.longSlice( arguments,1 ),
      level : 2,
    });
  }

  return;

  function boolLike( src )
  {
    let type = _ObjectToString.call( src );
    return type === '[object Boolean]' || type === '[object Number]';
  }

}

//

function sureBriefly( condition )
{

  if( !condition || !boolLike( condition ) )
  {
    _sureDebugger( condition );
    if( arguments.length === 1 )
    throw _err
    ({
      args : [ 'Assertion fails' ],
      level : 2,
      briefly : 1,
    });
    else if( arguments.length === 2 )
    throw _err
    ({
      args : [ arguments[ 1 ] ],
      level : 2,
      briefly : 1,
    });
    else
    throw _err
    ({
      args : _.longSlice( arguments,1 ),
      level : 2,
      briefly : 1,
    });
  }

  return;

  function boolLike( src )
  {
    let type = _ObjectToString.call( src );
    return type === '[object Boolean]' || type === '[object Number]';
  }

}

//

function sureWithoutDebugger( condition )
{

  if( !condition || !boolLike( condition ) )
  {
    if( arguments.length === 1 )
    throw _err
    ({
      args : [ 'Assertion fails' ],
      level : 2,
    });
    else if( arguments.length === 2 )
    throw _err
    ({
      args : [ arguments[ 1 ] ],
      level : 2,
    });
    else
    throw _err
    ({
      args : _.longSlice( arguments,1 ),
      level : 2,
    });
  }

  return;

  function boolLike( src )
  {
    let type = _ObjectToString.call( src );
    return type === '[object Boolean]' || type === '[object Number]';
  }

}

//

function sureInstanceOrClass( _constructor, _this )
{
  _.sure( arguments.length === 2, 'Expects exactly two arguments' );
  _.sure( _.checkInstanceOrClass( _constructor, _this ) );
}

//

function sureOwnNoConstructor( ins )
{
  _.sure( _.objectLikeOrRoutine( ins ) );
  let args = _.longSlice( arguments );
  args[ 0 ] = _.checkOwnNoConstructor( ins );
  _.sure.apply( _, args );
}

// --
// assert
// --

/**
 * Checks condition passed by argument( condition ). Works only in debug mode. Uses StackTrace level 2.
 *
 * @see {@link wTools.err err}
 *
 * If condition is true routine returns without exceptions, otherwise routine generates and throws exception. By default generates error with message 'Assertion fails'.
 * Also generates error using message(s) or existing error object(s) passed after first argument.
 *
 * @param {*} condition - condition to check.
 * @param {String|Error} [ msgs ] - error messages for generated exception.
 *
 * @example
 * let x = 1;
 * wTools.assert( wTools.strIs( x ), 'incorrect variable type->', typeof x, 'Expects string' );
 *
 * // caught eval (<anonymous>:2:8)
 * // incorrect variable type-> number expects string
 * // Error
 * //   at _err (file:///.../wTools/staging/Base.s:3707)
 * //   at assert (file://.../wTools/staging/Base.s:4041)
 * //   at add (<anonymous>:2)
 * //   at <anonymous>:1
 *
 * @example
 * function add( x, y )
 * {
 *   wTools.assert( arguments.length === 2, 'incorrect arguments count' );
 *   return x + y;
 * }
 * add();
 *
 * // caught add (<anonymous>:3:14)
 * // incorrect arguments count
 * // Error
 * //   at _err (file:///.../wTools/staging/Base.s:3707)
 * //   at assert (file://.../wTools/staging/Base.s:4035)
 * //   at add (<anonymous>:3:14)
 * //   at <anonymous>:6
 *
 * @example
 *   function divide ( x, y )
 *   {
 *      wTools.assert( y != 0, 'divide by zero' );
 *      return x / y;
 *   }
 *   divide( 3, 0 );
 *
 * // caught     at divide (<anonymous>:2:29)
 * // divide by zero
 * // Error
 * //   at _err (file:///.../wTools/staging/Base.s:1418:13)
 * //   at wTools.errLog (file://.../wTools/staging/Base.s:1462:13)
 * //   at divide (<anonymous>:2:29)
 * //   at <anonymous>:1:1
 * @throws {Error} If passed condition( condition ) fails.
 * @function assert
 * @memberof wTools
 */

function _assertDebugger( condition, args )
{
  if( !_.debuggerEnabled )
  return;
  let err = _err
  ({
    args : _.longSlice( args, 1 ),
    level : 3,
  });
  // console.error( 'Assertion failed' );
  debugger;
}

//

function assert( condition )
{

  if( Config.debug === false )
  return true;

  if( !condition )
  {
    _assertDebugger( condition, arguments );
    if( arguments.length === 1 )
    throw _err
    ({
      args : [ 'Assertion fails' ],
      level : 2,
    });
    else if( arguments.length === 2 )
    throw _err
    ({
      args : [ arguments[ 1 ] ],
      level : 2,
    });
    else
    throw _err
    ({
      args : _.longSlice( arguments,1 ),
      level : 2,
    });
  }

  return true;

  function boolLike( src )
  {
    let type = _ObjectToString.call( src );
    return type === '[object Boolean]' || type === '[object Number]';
  }

}

//

function assertWithoutBreakpoint( condition )
{

  /*return;*/

  if( Config.debug === false )
  return true;

  if( !condition || !_.boolLike( condition ) )
  {
    if( arguments.length === 1 )
    throw _err
    ({
      args : [ 'Assertion fails' ],
      level : 2,
    });
    else if( arguments.length === 2 )
    throw _err
    ({
      args : [ arguments[ 1 ] ],
      level : 2,
    });
    else
    throw _err
    ({
      args : _.longSlice( arguments,1 ),
      level : 2,
    });
  }

  return;
}

//

function assertNotTested( src )
{

  if( _.debuggerEnabled )
  debugger;
  _.assert( false,'not tested : ' + stack( 1 ) );

}

//

/**
 * If condition failed, routine prints warning messages passed after condition argument
 * @example
  function checkAngles( a, b, c )
  {
     wTools.assertWarn( (a + b + c) === 180, 'triangle with that angles does not exists' );
  };
  checkAngles( 120, 23, 130 );

 // triangle with that angles does not exists
 * @param condition Condition to check.
 * @param messages messages to print.
 * @function assertWarn
 * @memberof wTools
 */

function assertWarn( condition )
{

  if( Config.debug )
  return;

  if( !condition || !_.boolLike( condition ) )
  {
    console.warn.apply( console,[].slice.call( arguments,1 ) );
  }

}

//

function assertInstanceOrClass( _constructor, _this )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.checkInstanceOrClass( _constructor, _this ) );
}

//

function assertOwnNoConstructor( ins )
{
  _.assert( _.objectLikeOrRoutine( ins ) );
  let args = _.longSlice( arguments );
  args[ 0 ] = _.checkOwnNoConstructor( ins );

  if( args.length === 1 )
  args.push( () => 'Entity should not own constructor, but own ' + _.toStrShort( ins ) );

  _.assert.apply( _, args );
}

// --
// let
// --

/**
 * Throwen to indicate that operation was aborted by user or other subject.
 *
 * @error ErrorAbort
 * @memberof wTools
 */

// function ErrorAbort()
// {
//   this.message = arguments.length ? _.arrayFrom( arguments ) : 'Aborted';
// }
//
// ErrorAbort.prototype = Object.create( Error.prototype );

// let ErrorAbort = error_functor( 'ErrorAbort' );
//
// let error =
// {
//   ErrorAbort : ErrorAbort,
// }

// --
// fields
// --

// let error = Object.create( null );

/**
 * @property {Object} error={}
 * @property {Boolean} debuggerEnabled=!!Config.debug
 * @name ErrFields
 * @memberof wTools
 */

let Fields =
{
  // error : error,
  error : Object.create( null ),
  debuggerEnabled : !!Config.debug,
}

// --
// routines
// --

let Routines =
{

  // stub

  diagnosticStack,
  diagnosticStackCondense,
  diagnosticLocation,
  diagnosticCode,

  // error

  errIs,
  errIsRefined,
  errIsAttended,
  errIsAttentionRequested,
  errAttentionRequest,

  _err,
  err,
  errBriefly,
  errAttend,
  errRestack,
  error_functor,

  errLog,
  errLogOnce,

  // checker

  checkInstanceOrClass,
  checkOwnNoConstructor,

  // sure

  sure,
  sureBriefly,
  sureWithoutDebugger,
  sureInstanceOrClass,
  sureOwnNoConstructor,

  // assert

  assert,
  assertWithoutBreakpoint,
  assertNotTested,
  assertWarn,

  assertInstanceOrClass,
  assertOwnNoConstructor,

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

Error.stackTraceLimit = Infinity;

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
