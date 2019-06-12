( function _bPremature_s_() {

'use strict'; 

let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

// --
// routine
// --


/**
 * Returns true if entity ( src ) is a String.
 * @function strIs
 * @param {} src - entity to check
 * @memberof wTools
 */

function strIs( src )
{
  let result = _ObjectToString.call( src ) === '[object String]';
  return result;
}

//

/**
 * Returns true if entity ( src ) is a Function.
 * @function routineIs
 * @param {} src - entity to check
 * @memberof wTools
 */

function routineIs( src )
{
  return _ObjectToString.call( src ) === '[object Function]';
}

//

/**
 * Returns true if entity ( src ) is an Object.
 * @function objectIs
 * @param {} src - entity to check
 * @memberof wTools
 */

function objectIs( src )
{
  return _ObjectToString.call( src ) === '[object Object]';
}

//

/**
 * Returns true if entity ( src ) is an Arguments object.
 * @function argumentsArrayIs
 * @param {} src - entity to check
 * @memberof wTools
 */

function argumentsArrayIs( src )
{
  return _ObjectToString.call( src ) === '[object Arguments]';
}

//

/**
 * @summary Tests if provided condidion is true.
 *
 * @description
 *
 * * If ( msg ) is a Function - overrides ( msg ) with result of execution.
 * * If ( msg ) is a String - uses it as message.
 * * If ( msg ) is not defined - uses default message: 'Assertion fails'.
 * * If ( msg ) has any other type - uses it as argument for 'throw' statement
 *
 * @example
 * _.assert( _.strIs( src ), 'Src is not a string' );
 *
 * @function assert
 * @param {} condition - condition to check
 * @param {} msg - error message
 * @throws {Error} If condition fails. Uses second argument ( msg ) as error message.
 * @memberof wTools
 */

function assert( condition, msg )
{

  if( Config.debug === false )
  return true;

  if( arguments.length !== 1 && arguments.length !== 2 )
  {
    debugger;
    throw Error( 'Premature version of assert expects one or two arguments' );
  }

  if( !condition )
  {
    debugger;
    if( routineIs( msg ) )
    msg = msg();
    if( strIs( msg ) )
    throw Error( msg );
    else if( msg === undefined )
    throw Error( 'Assertion fails' );
    else
    throw msg;

  }

  return true;
}

//

/**
 * @summary Supplements source options map with defaults of current function( routine ) and checks if all options are known.
 *
 * @description
 *
 * * If ( args ) is an Arguments array, first argument should be a source options map;
 * * If ( args ) is not defined, creates a copy of default options;
 * * If ( defaults ) is not defined, uses defaults map from 'routine.defaults' property;
 *
 * @example
 *
 * function add( o )
 * {
 *  _.routineOptions( add, o );
 *  return o.a + o.b;
 * }
 *
 * add.defaults =
 * {
 *  a : 0,
 *  b : 0
 * }
 *
 * add({ a : 1, b : 1 }) // 2
 * add({ b : 1 }) // 1
 * add({ a : 1, c : 3 }) // throws an error, option "c" is unknown
 *
 * @function routineOptions
 * @param {Function} routine - target routine
 * @param {Arguments|Object} args - arguments array or options map
 * @param {Object} defaults - map with default options
 * @throws {Error} If first argument( routine ) is not a Function.
 * @throws {Error} If second argument( args ) is not an Arguments array or Map.
 * @throws {Error} If third argument( defaults ) is not an Object.
 * @throws {Error} If source options map has unknown properties.
 * @memberof wTools
 */

function routineOptions( routine, args, defaults )
{

  if( !argumentsArrayIs( args ) )
  args = [ args ];

  let options = args[ 0 ];
  if( options === undefined )
  options = Object.create( null );
  defaults = defaults || routine.defaults;

  assert( arguments.length === 2 || arguments.length === 3, 'Expects 2 or 3 arguments' );
  assert( routineIs( routine ), 'Expects routine' );
  assert( objectIs( defaults ), 'Expects routine with defined defaults or defaults in third argument' );
  assert( objectIs( options ), 'Expects object' );
  assert( args.length === 0 || args.length === 1, () => 'Expects single options map, but got ' + args.length + ' arguments' );

  mapSupplementStructureless( options, defaults ); /* xxx qqq : use instead of mapComplement */

  // _.mapComplement( options, defaults );
  // _.assertMapHasNoUndefine( options );

  for( let k in options )
  {
    assert( defaults[ k ] !== undefined, () => 'Unknown option ' + k )
  }

  return options;
}

//

function mapSupplementStructureless( dstMap, srcMap )
{
  if( dstMap === null && arguments.length === 2 )
  return Object.assign( Object.create( null ), srcMap );

  if( dstMap === null )
  dstMap = Object.create( null );

  for( let a = 1 ; a < arguments.length ; a++ )
  {
    srcMap = arguments[ a ];
    for( let s in srcMap )
    {
      if( dstMap[ s ] !== undefined )
      continue;
      if( _.objectLike( srcMap[ s ] ) || _.arrayLike( srcMap[ s ] ) )
      {
        debugger;
        throw Error( 'Source map should have only primitive elements, but ' + s + ' is ' + srcMap[ s ] );
      }
      dstMap[ s ] = srcMap[ s ];
    }
  }

  return dstMap
}

//

function vectorize_pre( routine, args )
{
  let o = args[ 0 ];

  if( args.length === 2 )
  o = { routine : args[ 0 ], select : args[ 1 ] }
  else if( routineIs( o ) || strIs( o ) )
  o = { routine : args[ 0 ] }

  routineOptions( routine, o );
  assert( arguments.length === 2, 'Expects exactly two arguments' );
  assert( routineIs( o.routine ) || strIs( o.routine ) || _.strsAreAll( o.routine ), () => 'Expects routine {-o.routine-}, but got ' + o.routine );
  assert( args.length === 1 || args.length === 2 );
  assert( o.select >= 1 || strIs( o.select ) || _.arrayIs( o.select ), () => 'Expects {-o.select-} as number >= 1, string or array, but got ' + o.select );

  return o;
}

//

function vectorize_body( o )
{

  _.assertRoutineOptions( vectorize_body, arguments );

  if( _.arrayIs( o.routine ) && o.routine.length === 1 )
  o.routine = o.routine[ 0 ];

  let routine = o.routine;
  let fieldFilter = o.fieldFilter;
  let bypassingFilteredOut = o.bypassingFilteredOut;
  let vectorizingArray = o.vectorizingArray;
  let vectorizingMapVals = o.vectorizingMapVals;
  let vectorizingMapKeys = o.vectorizingMapKeys;
  let pre = null;
  let select = o.select === null ? 1 : o.select;
  let selectAll = o.select === Infinity;
  let multiply = select > 1 ? multiplyReally : multiplyNo;

  routine = routineNormalize( routine );

  assert( routineIs( routine ), () => 'Expects routine {-o.routine-}, but got ' + routine );

  /* */

  let resultRoutine = vectorizeArray;

  if( _.numberIs( select ) )
  {
    if( !vectorizingArray && !vectorizingMapVals && !vectorizingMapKeys )
    resultRoutine = routine;
    else if( fieldFilter )
    resultRoutine = vectorizeWithFilters;
    else if( vectorizingMapKeys )
    {
      // assert( !vectorizingMapVals, '{-o.vectorizingMapKeys-} and {-o.vectorizingMapVals-} should not be enabled at the same time' );

      if( vectorizingMapVals )
      {
        assert( select === 1, 'Only single argument is allowed if {-o.vectorizingMapKeys-} and {-o.vectorizingMapVals-} are enabled.' );
        resultRoutine = vectorizeMapWithKeysOrArray;
      }
      else
      {
        resultRoutine = vectorizeKeysOrArray;
      }
    }
    else if( !vectorizingArray || vectorizingMapVals )
    resultRoutine = vectorizeMapOrArray;
    else if( multiply === multiplyNo )
    resultRoutine = vectorizeArray;
    else
    resultRoutine = vectorizeArrayMultiplying;

    /*
      vectorizeWithFilters : multiply + array/map vectorizing + filter
      vectorizeArray : array vectorizing
      vectorizeArrayMultiplying :  multiply + array vectorizing
      vectorizeMapOrArray :  multiply +  array/map vectorizing
    */

  }
  else
  {
    assert( multiply === multiplyNo, 'not implemented' );
    if( routine.pre )
    {
      pre = routine.pre;
      routine = routine.body;
    }
    if( fieldFilter )
    assert( 0, 'not implemented' );
    else if( vectorizingArray || !vectorizingMapVals )
    {
      if( strIs( select ) )
      resultRoutine = vectorizeForOptionsMap;
      else
      resultRoutine = vectorizeForOptionsMapForKeys;
    }
    else
    assert( 0, 'not implemented' );
  }

  /* */

  _.routineExtend( resultRoutine, routine );

  /* */

  return resultRoutine;

  /* - */

  function routineNormalize( routine )
  {

    if( strIs( routine ) )
    {
      return function methodCall()
      {
        assert( routineIs( this[ routine ] ), () => 'Context ' + _.toStrShort( this ) + ' does not have routine ' + routine );
        return this[ routine ].apply( this, arguments );
      }
    }
    else if( _.arrayIs( routine ) )
    {
      assert( routine.length === 2 );
      return function methodCall()
      {
        let c = this[ routine[ 0 ] ];
        assert( routineIs( c[ routine[ 1 ] ] ), () => 'Context ' + _.toStrShort( c ) + ' does not have routine ' + routine );
        return c[ routine[ 1 ] ].apply( c, arguments );
      }
    }

    return routine;
  }

  /* - */

  function multiplyNo( args )
  {
    return args;
  }

  /* - */

  function multiplyReally( args )
  {
    let length;
    let keys;

    args = _.longSlice( args );

    if( selectAll )
    select = args.length;

    assert( args.length === select, () => 'Expects ' + select + ' arguments, but got ' + args.length );

    for( let d = 0 ; d < select ; d++ )
    {
      if( vectorizingArray && _.arrayIs( args[ d ] ) )
      {
        length = args[ d ].length;
        break;
      }
      if( vectorizingMapVals && _.mapIs( args[ d ] ) )
      {
        keys = _.mapOwnKeys( args[ d ] );
        break;
      }
    }

    if( length !== undefined )
    {
      for( let d = 0 ; d < select ; d++ )
      {
        if( vectorizingMapVals )
        assert( !_.mapIs( args[ d ] ), () => 'Arguments should have only arrays or only maps, but not both. Incorrect argument : ' + args[ d ] );
        else if( vectorizingMapKeys && _.mapIs( args[ d ] ) )
        continue;

        args[ d ] = _.multiple( args[ d ], length );
      }

    }
    else if( keys !== undefined )
    {
      for( let d = 0 ; d < select ; d++ )
      if( _.mapIs( args[ d ] ) )
      assert( _.arraySetIdentical( _.mapOwnKeys( args[ d ] ), keys ), () => 'Maps should have same keys : ' + keys );
      else
      {
        if( vectorizingArray )
        assert( !_.longIs( args[ d ] ), () => 'Arguments should have only arrays or only maps, but not both. Incorrect argument : ' + args[ d ] );

        let arg = Object.create( null );
        _.mapSetWithKeys( arg, keys, args[ d ] );
        args[ d ] = arg;
      }
    }

    return args;
  }

  /* - */

  function vectorizeArray()
  {

    let args = arguments;
    let src = args[ 0 ];

    if( _.longIs( src ) )
    {
      let args2 = _.longSlice( args );
      let result = [];
      for( let r = 0 ; r < src.length ; r++ )
      {
        args2[ 0 ] = src[ r ];
        result[ r ] = routine.apply( this, args2 );
      }
      return result;
    }

    return routine.apply( this, args );
  }

  /* - */

  function vectorizeArrayMultiplying()
  {

    let args = multiply( arguments );
    let src = args[ 0 ];

    if( _.longIs( src ) )
    {
      let args2 = _.longSlice( args );
      let result = [];
      for( let r = 0 ; r < src.length ; r++ )
      {
        for( let m = 0 ; m < select ; m++ )
        args2[ m ] = args[ m ][ r ];
        result[ r ] = routine.apply( this, args2 );
      }
      return result;
    }

    return routine.apply( this, args );
  }

  /* - */

  function vectorizeForOptionsMap( srcMap )
  {
    let src = srcMap[ select ];

    assert( arguments.length === 1, 'Expects single argument' );

    if( _.longIs( src ) )
    {
      let args = _.longSlice( arguments );
      if( pre )
      {
        args = pre( routine, args );
        assert( _.arrayLikeResizable( args ) );
      }
      let result = [];
      for( let r = 0 ; r < src.length ; r++ )
      {
        args[ 0 ] = _.mapExtend( null, srcMap );
        args[ 0 ][ select ] = src[ r ];
        result[ r ] = routine.apply( this, args );
      }
      return result;
    }

    return routine.apply( this, arguments );
  }

  /* - */

  function vectorizeForOptionsMapForKeys()
  {
    let result = [];

    for( let i = 0; i < o.select.length; i++ )
    {
      select = o.select[ i ];
      result[ i ] = vectorizeForOptionsMap.apply( this, arguments );
    }
    return result;
  }

  /* - */

  function vectorizeMapOrArray()
  {

    let args = multiply( arguments );
    let src = args[ 0 ];

    if( vectorizingArray && _.longIs( src ) )
    {
      let args2 = _.longSlice( args );
      let result = [];
      for( let r = 0 ; r < src.length ; r++ )
      {
        for( let m = 0 ; m < select ; m++ )
        args2[ m ] = args[ m ][ r ];
        result[ r ] = routine.apply( this, args2 );
      }
      return result;
    }
    else if( vectorizingMapVals && _.mapIs( src ) )
    {
      let args2 = _.longSlice( args );
      let result = Object.create( null );
      for( let r in src )
      {
        for( let m = 0 ; m < select ; m++ )
        args2[ m ] = args[ m ][ r ];

        result[ r ] = routine.apply( this, args2 );
      }
      return result;
    }

    return routine.apply( this, arguments );
  }

  /* - */

  function vectorizeMapWithKeysOrArray()
  {
    let args = multiply( arguments );
    let srcs = args[ 0 ];

    assert( args.length === select, () => 'Expects ' + select + ' arguments but got : ' + args.length );

    if( vectorizingMapKeys && vectorizingMapVals &&_.mapIs( srcs ) )
    {
      let result = Object.create( null );
      for( let s in srcs )
      {
        let val = routine.call( this, srcs[ s ] );
        let key = routine.call( this, s );
        result[ key ] = val;
      }
      return result;
    }
    else if( vectorizingArray && _.arrayIs( srcs ) )
    {
      let result = [];
      for( let s = 0 ; s < srcs.length ; s++ )
      result[ s ] = routine.call( this, srcs[ s ] );
      return result;
    }

    return routine.apply( this, arguments );
  }

  /* - */

  function vectorizeWithFilters( src )
  {

    assert( 0, 'not tested' );
    assert( arguments.length === 1, 'Expects single argument' );

    let args = multiply( arguments );

    if( vectorizingArray && _.longIs( src ) )
    {
      args = _.longSlice( args );
      let result = [];
      throw _.err( 'not tested' );
      for( let r = 0 ; r < src.length ; r++ )
      {
        if( fieldFilter( src[ r ], r, src ) )
        {
          args[ 0 ] = src[ r ];
          result.push( routine.apply( this, args ) );
        }
        else if( bypassingFilteredOut )
        {
          result.push( src[ r ] );
        }
      }
      return result;
    }
    else if( vectorizingMapVals && _.mapIs( src ) )
    {
      args = _.longSlice( args );
      let result = Object.create( null );
      throw _.err( 'not tested' );
      for( let r in src )
      {
        if( fieldFilter( src[ r ], r, src ) )
        {
          args[ 0 ] = src[ r ];
          result[ r ] = routine.apply( this, args );
        }
        else if( bypassingFilteredOut )
        {
          result[ r ] = src[ r ];
        }
      }
      return result;
    }

    return routine.call( this, src );
  }

  /* - */

  function vectorizeKeysOrArray()
  {
    let args = multiply( arguments );
    let src = args[ 0 ];
    let args2;
    let result;
    let map;
    let mapIndex;
    let arr;

    assert( args.length === select, () => 'Expects ' + select + ' arguments but got : ' + args.length );

    if( vectorizingMapKeys )
    {
      for( let d = 0; d < select; d++ )
      {
        if( vectorizingArray && _.arrayIs( args[ d ] ) )
        arr = args[ d ];
        else if( _.mapIs( args[ d ] ) )
        {
          assert( map === undefined, () => 'Arguments should have only single map. Incorrect argument : ' + args[ d ] );
          map = args[ d ];
          mapIndex = d;
        }
      }
    }

    if( map )
    {
      result = Object.create( null );
      args2 = _.longSlice( args );

      if( vectorizingArray && _.arrayIs( arr ) )
      {
        for( let i = 0; i < arr.length; i++ )
        {
          for( let m = 0 ; m < select ; m++ )
          args2[ m ] = args[ m ][ i ];

          for( let k in map )
          {
            args2[ mapIndex ] = k;
            let key = routine.apply( this, args2 );
            result[ key ] = map[ k ];
          }
        }
      }
      else
      {
        for( let k in map )
        {
          args2[ mapIndex ] = k;
          let key = routine.apply( this, args2 );
          result[ key ] = map[ k ];
        }
      }

      return result;
    }
    else if( vectorizingArray && _.longIs( src ) )
    {
      args2 = _.longSlice( args );
      result = [];
      for( let r = 0 ; r < src.length ; r++ )
      {
        for( let m = 0 ; m < select ; m++ )
        args2[ m ] = args[ m ][ r ];
        result[ r ] = routine.apply( this, args2 );
      }
      return result;
    }

    return routine.apply( this, arguments );
  }

}

/* qqq : implement options combination vectorizingMapVals : 1, vectorizingMapKeys : 1, vectorizingArray : [ 0, 1 ] */
/* qqq : cover it */

vectorize_body.defaults =
{
  routine : null,
  fieldFilter : null,
  bypassingFilteredOut : 1,
  vectorizingArray : 1,
  vectorizingMapVals : 0,
  vectorizingMapKeys : 0,
  select : 1,
}

//

function vectorize()
{
  let o = vectorize.pre.call( this, vectorize, arguments );
  let result = vectorize.body.call( this, o );
  return result;
}

vectorize.pre = vectorize_pre;
vectorize.body = vectorize_body;
vectorize.defaults = Object.create( vectorize_body.defaults );

//

function vectorizeAll_body( o )
{
  _.assertRoutineOptions( vectorize, arguments );

  let routine1 = _.vectorize.body.call( this, o );

  return all;

  function all()
  {
    let result = routine1.apply( this, arguments );
    return _.all( result );
  }

}

vectorizeAll_body.defaults = Object.create( vectorize_body.defaults );

//

function vectorizeAll()
{
  let o = vectorizeAll.pre.call( this, vectorizeAll, arguments );
  let result = vectorizeAll.body.call( this, o );
  return result;
}

vectorizeAll.pre = vectorize_pre;
vectorizeAll.body = vectorizeAll_body;
vectorizeAll.defaults = Object.create( vectorizeAll_body.defaults );

//

function vectorizeAny_body( o )
{
  _.assertRoutineOptions( vectorize, arguments );

  let routine1 = _.vectorize.body.call( this, o );

  return any;

  function any()
  {
    let result = routine1.apply( this, arguments );
    return _.any( result );
  }

}

vectorizeAny_body.defaults = Object.create( vectorize_body.defaults );

//

function vectorizeAny()
{
  let o = vectorizeAny.pre.call( this, vectorizeAny, arguments );
  let result = vectorizeAny.body.call( this, o );
  return result;
}

vectorizeAny.pre = vectorize_pre;
vectorizeAny.body = vectorizeAny_body;
vectorizeAny.defaults = Object.create( vectorizeAny_body.defaults );

//

function vectorizeNone_body( o )
{
  _.assertRoutineOptions( vectorize, arguments );

  let routine1 = _.vectorize.body.call( this, o );

  return none;

  function none()
  {
    let result = routine1.apply( this, arguments );
    return _.none( result );
  }

}

vectorizeNone_body.defaults = Object.create( vectorize_body.defaults );

//

function vectorizeNone()
{
  let o = vectorizeNone.pre.call( this, vectorizeNone, arguments );
  let result = vectorizeNone.body.call( this, o );
  return result;
}

vectorizeNone.pre = vectorize_pre;
vectorizeNone.body = vectorizeNone_body;
vectorizeNone.defaults = Object.create( vectorizeNone_body.defaults );

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

  strIs,
  routineIs,
  objectIs,
  argumentsArrayIs,

  assert,
  routineOptions,

  routineVectorize_functor : vectorize,
  vectorize,
  vectorizeAll,
  vectorizeAny,
  vectorizeNone,

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
